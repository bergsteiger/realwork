{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

07/01/2003

  Fixed a bug in StyleManager which applied default style only (and not a class style) when no style name was specified 

06/07/2003

  Fixed some problems with applying styles with own names

05/15/2003

  Fixed operations with custom color property values

04/02/2003

  Fixed operations with Color properties

12/15/2002

  Unit created

*)

unit ElStyleMan;

interface

uses Classes,
     Windows,
     Messages,
     Graphics,
     {$ifdef VCL_4_USED}
     ImgList,
     {$endif}
     Controls,
     Forms,
     StdCtrls,
     TypInfo,
     SysUtils,
     ElVCLUtils,
     ElTools,
     ElImgLst,
     ElIni,
     {$ifdef ELPACK_UNICODE}
     ElUnicodeStrings,
     {$endif}
     ElList;

type

  TElStyleMgrChangeLink = class;
  TElStyleManager = class;

  TElStyleManager = class(TComponent)
  private
  protected
    FStyles      : TElIniFile;
    FLinksList   : TElList;
    FUpdateCount : integer;
    FOnChange    : TNotifyEvent;
    FUsesList,
    FValues      : TStringList;
    procedure TriggerChange; virtual;
    procedure NotifyLinks; virtual;
    procedure DoApplyStyle(AComponent : TComponent; StyleName : string);
    procedure WriteStyle(Stream: TStream);
    procedure ReadStyle(Stream: TStream);
    procedure DefineProperties(Filer : TFiler); override;
    procedure Loaded; override;
    procedure AssignTo(Dest : TPersistent); override;
  public
    constructor Create(AOwner : TComponent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure RegisterChanges(Value: TElStyleMgrChangeLink);
    procedure UnregisterChanges(Value: TElStyleMgrChangeLink);
    destructor Destroy; override;
    procedure ApplyStyle(AComponent : TComponent; StyleName : string);
    procedure LoadFromFile(FileName: string);
    procedure SaveToFile(FileName: string);
    procedure LoadFromStream(Stream : TStream);
    procedure SaveToStream(Stream : TStream);
    procedure Clear;
    procedure GetStyleNames(SL : TStrings);
    function GetAncestorStyle(StyleName : string): string;
    procedure GetProperties(StyleName : string; PropNames : TStrings);
  published
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
  end;

  TElStyleMgrChangeLink = class(TObject)
  private
    FSender: TElStyleManager;
    FOnChange: TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; virtual;
    property Sender: TElStyleManager read FSender;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TElStyleController = class(TComponent)

  private
    FStyleMgrLink: TElStyleMgrChangeLink;
  protected
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FComponent: TComponent;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure Notification(AComponent : TComponent; Operation : TOperation);
        override;
    procedure SetStyleName(const Value: string);
    procedure UpdateStyle;
    procedure SetComponent(Value: TComponent);
    procedure StyleMgrChange(Sender : TObject);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property Component: TComponent read FComponent write SetComponent;
  end;

const sDefaultStyleName = '(Default)';
      sTempStyleName    = '...Temp';

implementation

constructor TElStyleManager.Create(AOwner : TComponent);
begin
  inherited;
  FUsesList := TStringList.Create;
  FValues := TStringList.Create;
  FStyles := TElIniFile.Create(nil);
  FStyles.OpenKey('\' + sDefaultStyleName, true);
  FStyles.OpenKey('\', false);
end;

procedure TElStyleManager.BeginUpdate;
begin
  inc(FUpdateCount);
end;

procedure TElStyleManager.EndUpdate;
begin
  dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    TriggerChange;
  end;
end;

procedure TElStyleManager.TriggerChange;
begin
  if not (csLoading in ComponentState) then
  begin
    NotifyLinks;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TElStyleManager.NotifyLinks;
var i : integer;
begin
  if FLinksList <> nil then
    for i := 0 to FLinksList.Count - 1 do
      TElStyleMgrChangeLink(FLinksList[i]).Change;
end;

procedure TElStyleManager.RegisterChanges(Value: TElStyleMgrChangeLink);
begin
  Value.FSender := Self;
  if (FLinksList = nil) then
    FLinksList := TElList.Create;
  FLinksList.Add(Value);
end;

procedure TElStyleManager.UnregisterChanges(Value: TElStyleMgrChangeLink);
var
  I: Integer;
begin
  if FLinksList <> nil then
    for I := 0 to FLinksList.Count - 1 do
      if FLinksList[I] = Value then
      begin
        Value.FSender := nil;
        FLinksList.Delete(I);
        Break;
      end;
end;

destructor TElStyleManager.Destroy;
begin
  FreeAndNil(FLinksList);
  FreeAndNil(FUsesList);
  FreeAndNil(FValues);
  FreeAndNil(FStyles);
  inherited;
end;

procedure TElStyleManager.ApplyStyle(AComponent : TComponent; StyleName :
    string);

    procedure CopyStyleInfo(CopyFrom, CopyTo : string);
    var Ancestor : string;
        FOldKey  : string;
        i        : integer;
    begin
      if not FStyles.ReadString(CopyFrom, 'InheritsFrom', '', Ancestor) then
        Ancestor := sDefaultStyleName;
      if Ancestor <> CopyFrom then
      begin
        if FUsesList.IndexOf(Ancestor) = -1 then
        begin
          FUsesList.Add(Ancestor);
          CopyStyleInfo(Ancestor, CopyTo);
        end
        else
          Ancestor := '';
      end;
      FOldKey := FStyles.CurrentKey;
      if FStyles.OpenKey(CopyFrom, false) then
      begin
        FStyles.EnumValues(CopyFrom, FValues);

        for i := 0 to FValues.Count - 1 do
          FStyles.CopyValue(CopyFrom, FValues[i], CopyTo);
      end;
      FStyles.OpenKey(FOldKey, false);
    end;

begin
  (*if StyleName = '' then
    DoApplyStyle(AComponent, sDefaultStyleName)
  else
  *)
  begin
    FStyles.ClearKey(sTempStyleName);
    if (Length(StyleName) > 0) and (StyleName[1] = '.') then
    begin
      // style name is own name
      FUsesList.Clear;
      CopyStyleInfo('\' + AComponent.ClassName,  '\' + sTempStyleName);
      CopyStyleInfo('\' + StyleName, '\' + sTempStyleName);
      DoApplyStyle(AComponent, sTempStyleName);
    end
    else
    if FStyles.KeyExists('\' + AComponent.ClassName) then
    begin
      FUsesList.Clear;
      CopyStyleInfo('\' + AComponent.ClassName, '\' + sTempStyleName);
      DoApplyStyle(AComponent, sTempStyleName);
    end
    else
    begin
      FUsesList.Clear;
      CopyStyleInfo('\' + sDefaultStyleName, '\' + sTempStyleName);
      DoApplyStyle(AComponent, sTempStyleName);
    end;
  end;
  FStyles.Delete('\' + sTempStyleName, '');
end;

procedure TElStyleManager.DoApplyStyle(AComponent : TComponent; StyleName :
    string);
var i,
    j : integer;
    b : boolean;
    dv: double;
    s : string;
    {$ifdef VCL_5_USED}
    SL: TStringList;
    p : pointer;
    CL: TObject;
    Stream : TStream;
    {$endif}
    clr: integer;
    CurObj : TObject;
    (*
    Root   : TComponent;
    AClass : TClass;
    *)
    vt: TElValueType;
    PropInfo: PPropInfo;
    PropType,
    PropName,
    ValueName : string;

    function QueryStringListClass(Info : PTypeInfo) : boolean;
    var p : PTypeData;
    begin
      p := GetTypeData(Info);

      result := (p^.ClassType.InheritsFrom(TStrings)){$ifdef ELPACK_UNICODE} or (p^.ClassType.InheritsFrom(TElWideStrings)){$endif};
    end;

    function QueryImageClass(Info : PTypeInfo) : boolean;
    var p : PTypeData;
    begin
      p := GetTypeData(Info);
      result := (* (p^.ClassType.InheritsFrom(TCustomImageList)) or *)
                (p^.ClassType.InheritsFrom(TBitmap)) or (p^.ClassType.InheritsFrom(TIcon));
    end;

    function QueryComponentClass(Info : PTypeInfo) : boolean;
    var p : PTypeData;
    begin
      p := GetTypeData(Info);
      result := (p^.ClassType.InheritsFrom(TComponent));
    end;

begin
  FValues.Clear;
  if FStyles.OpenKey('\' + StyleName, false) then
  begin
    FStyles.EnumValues('', FValues);
    for i := 0 to FValues.Count - 1 do
    begin         
      ValueName := FValues[i];
      CurObj := AComponent;

      PropName := ValueName;
      if Pos('.', ValueName) > 0 then
      begin
        {$ifndef VCL_5_USED}
        Continue;
        {$else}
        PropName := Copy(ValueName, 1, Pos('.', ValueName) - 1);
        PropInfo := GetPropInfo(CurObj.ClassInfo, PropName);
        if PropInfo = nil then
          Continue;
        if (PropInfo.PropType^.Kind <> tkClass) or (QueryComponentClass(PropInfo.PropType^)) then
          Continue;
        PropName := Copy(ValueName, Pos('.', ValueName) + 1, Length(ValueName));
        CurObj := GetObjectProp(CurObj, PropInfo);
        {$endif}
      end;
      PropType := '';
      if Pos('|', PropName) > 0 then
      begin
        PropType := Copy(PropName, Pos('|', PropName) + 1, Length(PropName));
        Delete(PropName, Pos('|', PropName), Length(PropName));
      end;
      PropInfo := GetPropInfo(CurObj.ClassInfo, PropName);
      if PropInfo <> nil then
      begin
        if PropType <> '' then
        begin
          if Uppercase(PropInfo.PropType^.Name) <> Uppercase(PropType) then
            Continue;
        end;

        vt := FStyles.GetValueType('', ValueName);

        case vt of
          evtUnknown:
            begin
              // do nothing
            end;
          evtBoolean:
            begin
              if PropInfo.PropType^.Kind = tkEnumeration then
              begin
                if FStyles.ReadBool('', ValueName, false, b) then
                  SetOrdProp(CurObj, PropInfo, Integer(b));
              end;
            end;
          evtInt:
            begin
              if PropInfo.PropType^.Kind in [tkInteger, tkEnumeration] then
              begin
                if FStyles.ReadInteger('', ValueName, 0, j) then
                  SetOrdProp(CurObj, PropInfo, j);
              end;
            end;
          evtDouble:
            begin
              if PropInfo.PropType^.Kind = tkFloat then
              begin
                if FStyles.ReadDouble('', ValueName, 0, dv) then
                  SetFloatProp(CurObj, PropInfo, dv);
              end;
            end;
          evtString:
            begin
              if PropInfo.PropType^.Kind in [{$ifdef VCL_5_USED}tkSet,{$endif} tkChar, tkString, tkLString, tkWString] then
              begin
                if FStyles.ReadString('', ValueName, '', S) then
                begin
                  {$ifdef VCL_5_USED}
                  if PropInfo.PropType^.Kind = tkSet then
                    SetSetProp(CurObj, PropInfo, S)
                  else
                  {$endif}
                    SetStrProp(CurObj, PropInfo, S);
                end
              end
              else
              if PropInfo.PropType^.Kind = tkInteger then
              begin
                if FStyles.ReadString('', ValueName, '', S) then
                begin
                  clr := clNone;
                  if IdentToColor(S, clr) then
                  begin
                    SetOrdProp(CurObj, PropInfo, clr);
                  end
                  else
                  begin
                    clr := StringToColor(S);
                    SetOrdProp(CurObj, PropInfo, clr);
                  end;
                end;
              end;
            end;
          {$ifdef VCL_5_USED}
          evtMultiString:
            begin
              if (PropInfo.PropType^.Kind = tkClass) and QueryStringListClass(PropInfo.PropType^) then
              begin
                SL := TStringList.Create;
                try
                  if FStyles.ReadMultiString('', ValueName, SL) then
                  begin
                    CL := GetObjectProp(CurObj, PropInfo);
                    if CL is TStrings then
                      TStringList(CL).Assign(SL)
                    {$ifdef ELPACK_UNICODE}
                    else
                    if CL is TElWideStrings then
                      TStringList(CL).Assign(SL);
                    {$else}
                    ;
                    {$endif}
                  end;
                finally
                  FreeAndNil(SL);
                end;
              end;
            end;
          evtBinary:
            begin
              if (PropInfo.PropType^.Kind = tkClass) and QueryImageClass(PropInfo.PropType^) then
              begin
                j := -1;
                FStyles.ReadBinary('', ValueName, p, j);
                if j > -1 then
                begin
                  GetMem(p, j);
                  try
                    if FStyles.ReadBinary('', ValueName, p, j) then
                    begin
                      Stream := TMemoryStream.Create;
                      try
                        Stream.Write(pchar(P)^, j);
                        Stream.Position := 0;
                        CL := GetObjectProp(CurObj, PropInfo);
                        if CL is TBitmap then
                          TBitmap(CL).LoadFromStream(Stream)
                        else
                        if CL is TIcon then
                          TIcon(CL).LoadFromStream(Stream)
                        (*
                        else
                        begin
                          AClass := FindClass(PropInfo.Name);
                          if (AClass <> nil) and (AClass.InheritsFrom(TCustomImageList)) then
                          begin
                            Stream.ReadBuffer(b, sizeof(b));
                            if b and (CurObj is TComponent) then
                            begin
                              Root := GetRootComponent(TComponent(CurObj));
                              ReadStringFromStream(Stream, S);
                              CL := Root.FindComponent(S);
                              if CL is TCustomImageList then
                                SetObjectProp(CurObj, PropInfo, CL);
                            end
                            else
                            if CL is TElImageList then
                              TElImageList(CL).ReadImg(Stream);
                          end;
                        end;
                        *)
                      finally
                        FreeAndNil(Stream);
                      end;
                    end;
                  finally
                    FreeMem(p);
                  end;
                end;
              end;
            end;
          {$endif}
        end; // case
      end; // if
    end; // for
  end; // if
end;

procedure TElStyleManager.LoadFromFile;
var
  T: TFileStream;
begin
  T := nil;
  try
    T := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    LoadFromStream(T);
  finally
    T.Free;
  end;
end;

procedure TElStyleManager.SaveToFile;
var
  T: TFileStream;
begin
  T := nil;
  try
    T := TFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
    SaveToStream(T);
  finally
    T.Free;
  end;
end;

procedure TElStyleManager.LoadFromStream(Stream : TStream);
begin
  FStyles.LoadFromStream(Stream);
  TriggerChange;
end;

procedure TElStyleManager.SaveToStream(Stream : TStream);
begin
  FStyles.SaveToStream(Stream);
end;

procedure TElStyleManager.WriteStyle(Stream: TStream);
begin
  FStyles.SaveToStream(Stream);
end;

procedure TElStyleManager.ReadStyle(Stream: TStream);
begin
  BeginUpdate;
  FStyles.LoadFromStream(Stream);
  EndUpdate;
end;

procedure TElStyleManager.DefineProperties(Filer : TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Style', ReadStyle, WriteStyle, FStyles.SubKeysCount('\') > 0);
end;

procedure TElStyleManager.Loaded;
begin
  inherited;
  TriggerChange;
end;

procedure TElStyleManager.AssignTo(Dest : TPersistent);
var Stream : TStream;
begin
  if Dest is TElStyleManager then
  begin
    TElStyleManager(Dest).BeginUpdate;
    try
      Stream := TMemoryStream.Create;
      try
        FStyles.SaveToStream(Stream);
        Stream.Position := 0;
        TElStyleManager(Dest).FStyles.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    finally
      TElStyleManager(Dest).EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TElStyleManager.Clear;
begin
  FStyles.Clear;
  FStyles.OpenKey('\' + sDefaultStyleName, true);
  FStyles.OpenKey('\', false);
end;

procedure TElStyleManager.GetStyleNames(SL : TStrings);
begin
  FStyles.EnumSubKeys('\', SL);
end;

function TElStyleManager.GetAncestorStyle(StyleName : string): string;
begin
  if not FStyles.ReadString('\' + StyleName, 'InheritsFrom', '', Result) then
    Result := '';
end;

procedure TElStyleManager.GetProperties(StyleName : string; PropNames :
    TStrings);
var SaveKey : string;
    i       : integer;
begin
  SaveKey := FStyles.CurrentKey;
  if FStyles.OpenKey('\' + StyleName, false) then
  begin
    FStyles.EnumValues('', PropNames);
    i := PropNames.IndexOf('InheritsFrom');
    if i <> -1 then
      PropNames.Delete(i);
  end;
  FStyles.OpenKey(SaveKey, false)
end;

// ======== TElStyleMgrChangeLink ========

destructor TElStyleMgrChangeLink.Destroy;
begin
  inherited Destroy;
end;

procedure TElStyleMgrChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender);
end;

// ======== TElStyleController ========

procedure TElStyleController.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    {$endif}
    if FStyleManager <> nil then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TElStyleController.Notification(AComponent : TComponent; Operation :
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FStyleManager then
      StyleManager := nil;
    if AComponent = FComponent then
      Component := nil;
  end;
end;

procedure TElStyleController.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TElStyleController.UpdateStyle;
begin
  if (FStyleManager <> nil) and (FComponent <> nil) then
  begin
    FStyleManager.ApplyStyle(FComponent, StyleName);
  end;
end;

procedure TElStyleController.SetComponent(Value: TComponent);
begin
  if FComponent <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FComponent <> nil) then
      if not (csDestroying in FComponent.ComponentState) then
        FComponent.RemoveFreeNotification(Self);
    {$endif}
    FComponent := Value;
    if FComponent <> nil then
      FComponent.FreeNotification(Self);
    UpdateStyle;
  end;
end;

constructor TElStyleController.Create(AOwner : TComponent);
begin
  inherited;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
end;

procedure TElStyleController.StyleMgrChange(Sender : TObject);
begin
  if (FStyleManager <> nil) and (FComponent <> nil) then
  begin
    if (FComponent is TWinControl) and (TWinControl(FComponent).HandleAllocated) then
      SendMessage(TWinControl(FComponent).Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(FComponent, StyleName);
    if (FComponent is TWinControl) and (TWinControl(FComponent).HandleAllocated) then
    begin
      SendMessage(TWinControl(FComponent).Handle, WM_SETREDRAW, 1, 0);
      TWinControl(FComponent).Invalidate;
    end;
  end;
end;

destructor TElStyleController.Destroy;
begin
  StyleManager := nil;
  Component := nil;
  FreeAndNil(FStyleMgrLink);
  inherited;
end;

end.
