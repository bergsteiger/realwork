{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Styles;

interface

uses
  System.TypInfo, System.Math, System.Classes, System.SysUtils, System.Types,
  System.UITypes, System.Generics.Collections, FMX.Types, FMX.Consts,
  FMX.Messages;

{$SCOPEDENUMS ON}

const
  // Sign is "FMX_STYLE 2.0"
  FireMonkeyStyleSign: array [0..12] of byte =
    (Byte('F'), Byte('M'), Byte('X'), Byte('_'),
     Byte('S'), Byte('T'), Byte('Y'), Byte('L'), Byte('E'), Byte(' '),
     Byte('2'), Byte('.'), Byte('0'));
  // Sign is "FMX_STYLE 3.0"
  FireMonkey25StyleSign: array [0..12] of byte =
    (Byte('F'), Byte('M'), Byte('X'), Byte('_'),
     Byte('S'), Byte('T'), Byte('Y'), Byte('L'), Byte('E'), Byte(' '),
     Byte('2'), Byte('.'), Byte('5'));

type

  TStyleDescription = class(TFmxObject)
  private
    FAuthor: string;
    FVersion: string;
    FStyleName: string;
    FAuthorEMail: string;
    FRetinaDisplay: Boolean;
    FPlatformTarget: String;
    FMobilePlatform: Boolean;
    FAuthorURL: string;
  public
    function IsSupportedPlatformTarget: Boolean;
  published
    property Author: string read FAuthor write FAuthor;
    property AuthorEMail: string read FAuthorEMail write FAuthorEMail;
    property AuthorURL: string read FAuthorURL write FAuthorURL;
    property PlatformTarget: string read FPlatformTarget write FPlatformTarget;
    property MobilePlatform: Boolean read FMobilePlatform write FMobilePlatform;
    property RetinaDisplay: Boolean read FRetinaDisplay write FRetinaDisplay;
    property StyleName: string read FStyleName write FStyleName;
    property Version: string read FVersion write FVersion;
  end;


  TStyleTag = class(TFmxObject)
  published
    property Tag;
    property TagFloat;
    property TagString;
  end;

  TStyleManager = class sealed
  strict private
    class var FActiveStyle: TFmxObject;
    class var FActiveStyleHiRes: TFmxObject;
    class var FDisableCheckTarget: Boolean;
    class function GetStyleNames: TArray<string>; static;
    class function GetActiveStyle: TFmxObject; static;
    class function GetActiveStyleHiRes: TFmxObject; static;
  private
    class function GetSystemStyle: TFmxObject; static;
    class function GetSystemStyleHiRes: TFmxObject; static;
    class procedure ClearActiveStyle; static;
    class procedure ClearActiveStyleHiRes; static;
    class procedure UpdateScenesLoRes; static;
    class procedure UpdateScenesHiRes; static;
    class function AssignedActiveStyle: TFmxObject; static;
    class function AssignedActiveStyleHiRes: TFmxObject; static;
    class function LoadFromIndexedStream(const AStream: TStream): TFmxObject;
  public
    // Update all scenes if scenes list are assigned
    class procedure UpdateScenes; static;
    // Load style from a resource
    class function LoadFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar): TFmxObject;
    // Load a style from a resource without raising an exception
    class function TryLoadFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar): Boolean;
    // Return active style
    class property ActiveStyle: TFmxObject read GetActiveStyle;
    // Return active HiRes style
    class property ActiveStyleHiRes: TFmxObject read GetActiveStyleHiRes;
    // Load a style from a file without raising an exception
    class function TryLoadFromFile(const FileName: string): Boolean;
    // Load style from a file
    class function LoadFromFile(const FileName: string): TFmxObject;
    // Load style from a file
    class function LoadFromStream(const AStream: TStream): TFmxObject;
    // Save to indexed style format
    class procedure SaveStyleToIndexedBinary(const Style: TFmxObject; const Stream: TStream);
    // Set system style
    class procedure SetSystemStyle; overload;
    // Set ActiveStyle style
    class procedure SetStyle(const Style: TFmxObject); overload;
    // Set ActiveStyleHiRes style
    class procedure SetStyleHiRes(const Style: TFmxObject); overload;
    // Load style from a file
    class function SetStyleFromFile(const FileName: string): Boolean;
    // Load HiRes style from a file
    class function SetStyleFromFileHiRes(const FileName: string): Boolean;
    // Return system style
    class property SystemStyle: TFmxObject read GetSystemStyle;
    // Return HiRes system style
    class property SystemStyleHiRes: TFmxObject read GetSystemStyleHiRes;
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    // Return Style Descriptor in style
    class function FindStyleDescriptor(const AObject: TFmxObject): TStyleDescription;
    // Returns array of registered style class names
    class property StyleNames: TArray<string> read GetStyleNames;
  end;

implementation

uses FMX.Forms, FMX.Platform, FMX.Dialogs, FMX.Controls;

{ TStyleReader }

type
  TStyleReader = class(TReader)
  private
  protected
    procedure SetName(Component: TComponent; var Name: string); override;
    function Error(const Message: string): Boolean; override;
  end;


function TStyleReader.Error(const Message: string): Boolean;
begin
  Result := True;
end;

procedure TStyleReader.SetName(Component: TComponent; var Name: string);
begin
  Name := '';
end;

{ TStyleDescription }

function TStyleDescription.IsSupportedPlatformTarget;
begin
  Result := True;
  if FPlatformTarget = '' then Exit;
  {$IFDEF MSWINDOWS}
  if (Pos('[MSWINDOWS]', UpperCase(FPlatformTarget)) = 0) and (Pos('[IOSALTERNATE]', UpperCase(FPlatformTarget)) = 0)  then
    Result := False;
  {$ENDIF}
  {$IFDEF MACOS}
  {$IFNDEF NEXTGEN}
  if (Pos('[MACOS]', UpperCase(FPlatformTarget)) = 0) then
    Result := False;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF IOS}
  if (Pos('[IOS]', UpperCase(FPlatformTarget)) = 0) and (Pos('[IOSALTERNATE]', UpperCase(FPlatformTarget)) = 0) then
    Result := False;
  {$ENDIF}
end;

{ TStyleNotification }

type
  TStyleManagerNotification = class(TFmxObject)
  private
  protected
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject); override;
  end;

procedure TStyleManagerNotification.FreeNotification(AObject: TObject);
begin
  inherited;
  if AObject = TStyleManager.AssignedActiveStyle then
    TStyleManager.ClearActiveStyle;
  if AObject = TStyleManager.AssignedActiveStyleHiRes then
    TStyleManager.ClearActiveStyleHiRes;
end;

var
  StyleManagerNotification: TStyleManagerNotification;

{ TStyleManager }

class procedure TStyleManager.UnInitialize;
begin
  FreeAndNil(FActiveStyleHiRes);
  FreeAndNil(FActiveStyle);
  FreeAndNil(StyleManagerNotification);
end;

class function TStyleManager.GetActiveStyle: TFmxObject;
begin
  { load default styles - important - because not default styles can be incomplete }
  if not Assigned(FActiveStyle) then
  begin
    FActiveStyle := SystemStyle;
    if not Assigned(StyleManagerNotification) then
      StyleManagerNotification := TStyleManagerNotification.Create(nil);
    if Assigned(FActiveStyle) then
      FActiveStyle.AddFreeNotify(StyleManagerNotification);
  end;
  Result := FActiveStyle;
end;

class function TStyleManager.GetActiveStyleHiRes: TFmxObject;
begin
  { load default HiRes styles - important - because not default styles can be incomplete }
  if not Assigned(FActiveStyleHiRes) then
  begin
    FActiveStyleHiRes := SystemStyleHiRes;
    if not Assigned(StyleManagerNotification) then
      StyleManagerNotification := TStyleManagerNotification.Create(nil);
    if Assigned(FActiveStyleHiRes) then
      FActiveStyleHiRes.AddFreeNotify(StyleManagerNotification);
  end;
  Result := FActiveStyleHiRes;
  if not Assigned(FActiveStyleHiRes) then
    Result := GetActiveStyle;
end;

class function TStyleManager.GetSystemStyle: TFmxObject;
var
  StyleService: IFMXStyleService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXStyleService, IInterface(StyleService)) then
    Result := StyleService.GetSystemStyle
  else
    Result := nil;
end;

class function TStyleManager.GetSystemStyleHiRes: TFmxObject;
var
  StyleService: IFMXStyleHiResService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXStyleHiResService, IInterface(StyleService)) then
    Result := StyleService.GetSystemStyleHiRes
  else
    Result := nil;
end;

class function TStyleManager.GetStyleNames: TArray<string>;
begin
end;

class function TStyleManager.TryLoadFromFile(const FileName: string): Boolean;
var
  S: TFmxObject;
  Desc: TStyleDescription;
begin
  Result := False;
  FDisableCheckTarget := True;
  try
    S := LoadFromFile(FileName);
    if Assigned(S) then
    begin
      Desc := FindStyleDescriptor(S);
      if Assigned(Desc) and Desc.IsSupportedPlatformTarget then
        Result := True;
    end;
  finally
    FDisableCheckTarget := False;
  end;
end;

class function TStyleManager.LoadFromIndexedStream(const AStream: TStream): TFmxObject;
var
  StyleContainer: TStyleContainer;
begin
  StyleContainer := TStyleContainer.Create(nil);
  StyleContainer.LoadFromIndexedStream(AStream);
  Result := StyleContainer;
end;

class function TStyleManager.LoadFromStream(const AStream: TStream): TFmxObject;
var
  BinStream: TStream;
  Reader: TStyleReader;
  Sign: array of Byte;
  Desc: TStyleDescription;
begin
  Result := nil;
  // Ensure the correct class group is active
  ActivateClassGroup(TFmxObject);
  try
    SetLength(Sign, 13);
    case TestStreamFormat(AStream) of
      sofUnknown: begin
        AStream.Read(Sign[0], Length(Sign));
        if (Sign[0] = FireMonkey25StyleSign[0]) and (Sign[1] = FireMonkey25StyleSign[1]) and (Sign[2] = FireMonkey25StyleSign[2]) and
           (Sign[3] = FireMonkey25StyleSign[3]) and (Sign[4] = FireMonkey25StyleSign[4]) and (Sign[5] = FireMonkey25StyleSign[5]) and
           (Sign[6] = FireMonkey25StyleSign[6]) and (Sign[6] = FireMonkey25StyleSign[6]) and (Sign[7] = FireMonkey25StyleSign[7]) and
           (Sign[8] = FireMonkey25StyleSign[8]) and (Sign[9] = FireMonkey25StyleSign[9]) and (Sign[10] = FireMonkey25StyleSign[10]) and
           (Sign[11] = FireMonkey25StyleSign[11]) and (Sign[12] = FireMonkey25StyleSign[12]) then
          Result := LoadFromIndexedStream(AStream)
        else if (Sign[0] = FireMonkeyStyleSign[0]) and (Sign[1] = FireMonkeyStyleSign[1]) and (Sign[2] = FireMonkeyStyleSign[2]) and
           (Sign[3] = FireMonkeyStyleSign[3]) and (Sign[4] = FireMonkeyStyleSign[4]) and (Sign[5] = FireMonkeyStyleSign[5]) and
           (Sign[6] = FireMonkeyStyleSign[6]) and (Sign[6] = FireMonkeyStyleSign[6]) and (Sign[7] = FireMonkeyStyleSign[7]) and
           (Sign[8] = FireMonkeyStyleSign[8]) and (Sign[9] = FireMonkeyStyleSign[9]) and (Sign[10] = FireMonkeyStyleSign[10]) and
           (Sign[11] = FireMonkeyStyleSign[11]) and (Sign[12] = FireMonkeyStyleSign[12]) then
          Result := LoadFromStream(AStream)
        else
          Result := nil;
      end;
      sofBinary: begin
        Reader := TStyleReader.Create(AStream, 4096);
        try
          Result := TFmxObject(Reader.ReadRootComponent(nil));
        finally
          Reader.Free;
        end;
      end;
      sofText, sofUTF8Text: begin
        BinStream := TMemoryStream.Create;
        try
          ObjectTextToBinary(AStream, BinStream);
          BinStream.Position := 0;
          Reader := TStyleReader.Create(BinStream, 4096);
          try
            Result := TFmxObject(Reader.ReadRootComponent(nil));
          finally
            Reader.Free;
          end;
        finally
          BinStream.Free;
        end;
      end;
    end;
  except
    Result := nil;
  end;
  // Check description
  if not FDisableCheckTarget and Assigned(Result) then
  begin
    Desc := FindStyleDescriptor(Result);
    if Assigned(Desc) and not Desc.IsSupportedPlatformTarget then
    begin
      MessageDlg(SInvalidStyleForPlatform, TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
      FreeAndNil(Result);
    end
  end;
end;

class function TStyleManager.LoadFromFile(const FileName: string): TFmxObject;
var
  S: TStream;
  SR: TSearchRec;
  AdditionalStyle: TFmxObject;
  I: Integer;
begin
  Result := nil;
  if FileName <> '' then
  begin
    if FileExists(FileName) then
    begin
      S := TFileStream.Create(FileName, fmOpenRead);
      try
        Result := LoadFromStream(S);
      finally
        S.Free;
      end;
      // load additional (third-party) styles
      if Assigned(Result) then
      begin
        if FindFirst(ChangeFileExt(FileName, '.*' + ExtractFileExt(FileName)), $FFFF, SR) = 0 then
        begin
          try
            repeat
              S := TFileStream.Create(ExtractFilePath(FileName) + SR.Name, fmOpenRead);
              try
                AdditionalStyle := LoadFromStream(S);
                for I := AdditionalStyle.ChildrenCount - 1 downto 0 do
                  AdditionalStyle.Children[I].Parent := Result;
              finally
                S.Free;
              end;
            until FindNext(SR) <> 0;
          finally
            FindClose(SR);
          end;
        end;
      end;
    end
  end;
end;

class function TStyleManager.LoadFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar): TFmxObject;
var
  S: TStream;
begin
  if FindResource(Instance, PChar(ResourceName), ResourceType) <> 0 then
  begin
    S := TResourceStream.Create(Instance, ResourceName, ResourceType);
    FDisableCheckTarget := True;
    try
      Result := LoadFromStream(S);
    finally
      FDisableCheckTarget := False;
      S.Free;
    end;
  end
  else
    Result := nil;
end;

class function TStyleManager.TryLoadFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar): Boolean;
begin
  Result := FindResource(Instance, PChar(ResourceName), ResourceType) <> 0;
end;

class procedure TStyleManager.SaveStyleToIndexedBinary(const Style: TFmxObject; const Stream: TStream);
var
  W: TWriter;
  CurrentObject: Integer;
  ObjectsBinary: array of TStream;
  StyleObject: TFmxObject;
begin
  Stream.Write(FireMonkey25StyleSign, SizeOf(FireMonkey25StyleSign));

  CurrentObject := 0;
  SetLength(ObjectsBinary, Style.ChildrenCount);
  if Assigned(Style.Children) then
    for StyleObject in Style.Children do
    begin
      ObjectsBinary[CurrentObject] := TMemoryStream.Create;
      ObjectsBinary[CurrentObject].WriteComponent(StyleObject);
      Inc(CurrentObject);
    end;

  W := TWriter.Create(Stream, 1024);
  try
    W.WriteListBegin;
    try
      CurrentObject := 0;
      if Assigned(Style.Children) then
        for StyleObject in Style.Children do
        begin
          W.WriteString(StyleObject.StyleName);
          W.WriteInteger(ObjectsBinary[CurrentObject].Size);
          Inc(CurrentObject);
        end;
    finally
      W.WriteListEnd;
    end;
  finally
    W.Free;
  end;

  if Assigned(Style.Children) then
    for StyleObject in Style.Children do
      Stream.WriteComponent(StyleObject);
end;

class procedure TStyleManager.SetStyle(const Style: TFmxObject);
begin
  if FActiveStyle <> Style then
  begin
    if Assigned(FActiveStyle) then
    begin
      FActiveStyle.RemoveFreeNotify(StyleManagerNotification);
      FreeAndNil(FActiveStyle);
    end;
    FActiveStyle := Style;
    if not Assigned(StyleManagerNotification) then
      StyleManagerNotification := TStyleManagerNotification.Create(nil);
    if Assigned(FActiveStyle) then
      FActiveStyle.AddFreeNotify(StyleManagerNotification);
    UpdateScenesLoRes;
  end;
end;

class procedure TStyleManager.SetStyleHiRes(const Style: TFmxObject);
begin
  if FActiveStyleHiRes <> Style then
  begin
    if Assigned(FActiveStyleHiRes) then
    begin
      FActiveStyleHiRes.RemoveFreeNotify(StyleManagerNotification);
      FreeAndNil(FActiveStyleHiRes);
    end;
    FActiveStyleHiRes := Style;
    if not Assigned(StyleManagerNotification) then
      StyleManagerNotification := TStyleManagerNotification.Create(nil);
    if Assigned(FActiveStyleHiRes) then
      FActiveStyleHiRes.AddFreeNotify(StyleManagerNotification);
    UpdateScenesHiRes;
  end;
end;

class procedure TStyleManager.SetSystemStyle;
begin
  SetStyle(SystemStyle);
  SetStyleHiRes(SystemStyleHiRes);
end;

class function TStyleManager.SetStyleFromFile(const FileName: string): Boolean;
var
  S: TFmxObject;
begin
  Result := False;
  S := LoadFromFile(FileName);
  if Assigned(S) then
  begin
    Result := True;
    SetStyle(S);
  end;
end;

class function TStyleManager.SetStyleFromFileHiRes(const FileName: string): Boolean;
var
  S: TFmxObject;
begin
  Result := False;
  S := LoadFromFile(FileName);
  if Assigned(S) then
  begin
    Result := True;
    SetStyleHiRes(S);
  end;
end;

class procedure TStyleManager.UpdateScenes;
begin
  TMessageManager.DefaultManager.SendMessage(nil, TBeforeStyleChangingMessage.Create, True);
  TMessageManager.DefaultManager.SendMessage(nil, TStyleChangedMessage.Create(nil), True);
end;

class procedure TStyleManager.UpdateScenesHiRes;
begin
  TMessageManager.DefaultManager.SendMessage(nil, TBeforeStyleChangingMessage.Create, True);
  TMessageManager.DefaultManager.SendMessage(nil, TStyleChangedMessage.Create(nil), True);
end;

class procedure TStyleManager.UpdateScenesLoRes;
begin
  TMessageManager.DefaultManager.SendMessage(nil, TBeforeStyleChangingMessage.Create, True);
  TMessageManager.DefaultManager.SendMessage(nil, TStyleChangedMessage.Create(nil), True);
end;

class function TStyleManager.AssignedActiveStyle: TFmxObject;
begin
  Result := FActiveStyle;
end;

class function TStyleManager.AssignedActiveStyleHiRes: TFmxObject;
begin
  Result := FActiveStyleHiRes;
end;

class procedure TStyleManager.ClearActiveStyle;
begin
  FActiveStyle := nil;
end;

class procedure TStyleManager.ClearActiveStyleHiRes;
begin
  FActiveStyleHiRes := nil;
end;

class function TStyleManager.FindStyleDescriptor(const AObject: TFmxObject): TStyleDescription;
var
  I: Integer;
  Founded: Boolean;
  DescriptorTmp: TStyleDescription;
begin
  I := 0;
  Founded := False;
  DescriptorTmp := nil;
  while (I < AObject.ChildrenCount) and not Founded do
    if AObject.Children[I] is TStyleDescription then
    begin
      Founded := True;
      DescriptorTmp := AObject.Children[I] as TStyleDescription;
    end
    else
    begin
       DescriptorTmp := FindStyleDescriptor(AObject.Children[I]);
       Founded := Assigned(DescriptorTmp);
       Inc(I);
    end;
  Result := DescriptorTmp;
end;

initialization
  RegisterFmxClasses([TStyleDescription, TStyleTag]);
end.

