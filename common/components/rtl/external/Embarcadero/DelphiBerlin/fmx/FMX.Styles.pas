{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Styles;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.SysUtils, System.Generics.Collections, FMX.Types, FMX.Consts;

type
  TStyleSignature = array [0..12] of Byte;

const
  // Sign is "FMX_STYLE 2.0"
  FireMonkeyStyleSign: TStyleSignature =
    (Byte('F'), Byte('M'), Byte('X'), Byte('_'),
     Byte('S'), Byte('T'), Byte('Y'), Byte('L'), Byte('E'), Byte(' '),
     Byte('2'), Byte('.'), Byte('0'));
  // Sign is "FMX_STYLE 2.5"
  FireMonkey25StyleSign: TStyleSignature =
    (Byte('F'), Byte('M'), Byte('X'), Byte('_'),
     Byte('S'), Byte('T'), Byte('Y'), Byte('L'), Byte('E'), Byte(' '),
     Byte('2'), Byte('.'), Byte('5'));

type
  EStyleException = class(Exception);

  TStyleFormat = (Indexed, Binary, Text);

  TStyleDescription = class(TFmxObject)
  private type
    TProperty = (Author, AuthorEMail, PlatformTarget, MobilePlatform, Title, Version);
  private const
    /// <summary>List of published properties used in streaming</summary>
    Properties: array [TProperty] of string = ('Author', 'AuthorEMail', 'PlatformTarget', 'MobilePlatform', 'Title',
      'Version');
  public const
    /// <summary>Target's names that used in style file</summary>
    PlatformTargets: array [TOSPlatform] of string = ('[WINDOWS]', '[MACOS]', '[IOS7]', '[ANDROID]');
    /// <summary>Platform's names that used at framework</summary>
    PlatformNames: array [TOSPlatform] of string = ('Windows', 'OSX', 'iOS', 'Android');
  private
    FAuthor: string;
    FVersion: string;
    FTitle: string;
    FAuthorEMail: string;
    FPlatformTarget: String;
    FMobilePlatform: Boolean;
    FAuthorURL: string;
    class function TryLoadFromStream(const Stream: TStream; var StyleDescription: TStyleDescription): Boolean;
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    function Equals(Obj: TObject): Boolean; override;
    /// <summary>Allows to check style for fitting for specified Platform</summary>
    function SupportsPlatform(const APlatform: TOSPlatform): Boolean;
  published
    property Author: string read FAuthor write FAuthor;
    property AuthorEMail: string read FAuthorEMail write FAuthorEMail;
    property AuthorURL: string read FAuthorURL write FAuthorURL;
    property PlatformTarget: string read FPlatformTarget write FPlatformTarget;
    property MobilePlatform: Boolean read FMobilePlatform write FMobilePlatform;
    property Title: string read FTitle write FTitle;
    property Version: string read FVersion write FVersion;
  end;


  TStyleTag = class(TFmxObject)
  published
    property Tag;
    property TagFloat;
    property TagString;
  end;

  IBinaryStyleContainer = interface
  ['{76589FDB-7430-4F7A-A993-44AB1664BCFD}']
    procedure ClearContainer;
    procedure AddBinaryFromStream(const Name: string; const SourceStream: TStream; const Size: Int64);
    /// <summary>Force to load all style's objects from binary stream.</summary>
    procedure UnpackAllBinaries;
  end;

  TSupportedPlatformHook = function (const PlatformTarget: string): Boolean;

  TStyleStreaming = class
  private type
    TIndexItem = record
      Name: string;
      Size: Int64;
    end;
  private class var
    FDefaultContainerClass: TFmxObjectClass;
    FSupportedPlatformHook: TSupportedPlatformHook;
  private
    class function ReadHeader(const AStream: TStream): TArray<TIndexItem>;
    class function LoadFromIndexedStream(const AStream: TStream): TFmxObject;
    class procedure SaveToIndexedStream(const Style: TFmxObject; const AStream: TStream); static;
    class function IsSupportedPlatformTarget(const PlatformTarget: string): Boolean; static;
    class function SameStyleDecription(const Style1, Style2: TFmxObject): Boolean; static;
    class function SameObject(const Obj1, Obj2: TFmxObject): Boolean; static;
    class function CompareSign(const Sign1, Sign2: TStyleSignature): Boolean;
    class function TryLoadStyleDescriptionFromIndexedStream(const Stream: TStream;
      var Description: TStyleDescription): Boolean; static;
  public
    class function DefaultIsSupportedPlatformTarget(const PlatformTarget: string): Boolean; static;

    class procedure SaveToStream(const Style: TFmxObject; const AStream: TStream;
      const Format: TStyleFormat = TStyleFormat.Indexed);

    /// <summary>Try to parse styel file and read style description. Description object should be destroyed by caller.</summary>
    class function TryLoadStyleDescription(const Stream: TStream; var Description: TStyleDescription): Boolean;

    class function LoadFromFile(const FileName: string): TFmxObject;
    class function LoadFromStream(const AStream: TStream): TFmxObject;
    class function LoadFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar): TFmxObject;

    class function CanLoadFromFile(const FileName: string): Boolean;
    class function CanLoadFromStream(const AStream: TStream):  Boolean;
    class function CanLoadFromResource(const ResourceName: string; ResourceType: PChar): Boolean; overload;
    class function CanLoadFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar): Boolean; overload;

    class function SameStyle(const Style1, Style2: TFmxObject): Boolean; static;

    class procedure SetDefaultContainerClass(const AClass: TFmxObjectClass);
    class procedure SetSupportedPlatformHook(const AHook: TSupportedPlatformHook);
  end;

  /// <summary>This procedure return correct resource name if more than one is registered for platform.</summary>
  TPlatformStyleSelectionProc = function (const APlatform: TOSPlatform): string;
  /// <summary>Anonymous method that EnumStyleResources calls in order to
  /// enumerate all the registered style resources.</summary>
  TStyleResourceEnumProc = reference to procedure (const AResourceName: string; const APlatform: TOSPlatform);

  TStyleManager = class sealed
  strict private
    class var FPlatformResources: TDictionary<string, TOSPlatform>;
    class var FSelections: TDictionary<TOSPlatform, TPlatformStyleSelectionProc>;
    class function FindDefaultStyleResource(const OSPlatform: TOSPlatform): string; static;
    class function StyleResourceForContext(const Context: TFmxObject): string; static;
  private
    class var FStyleResources: TDictionary<string, TFmxObject>;
  public
    class procedure RemoveStyleFromGlobalPool(const Style: TFmxObject); static;
    class procedure UpdateScenes; static;

    /// <summary>Enumarate all registered style resources.</summary>
    class procedure EnumStyleResources(Proc: TStyleResourceEnumProc);
    /// <summary>Return if exits in cache or load style from resource.</summary>
    class function GetStyleResource(const ResourceName: string): TFmxObject;

    /// <summary>Register style resource for specified platform.</summary>
    class procedure RegisterPlatformStyleResource(const APlatform: TOSPlatform; const ResourceName: string);
    /// <summary>Register selection procedure for specified platform.</summary>
    class procedure RegisterPlatformStyleSelection(const APlatform: TOSPlatform; const ASelection: TPlatformStyleSelectionProc);

    class function ActiveStyle(const Context: TFmxObject): TFmxObject; static;

    class procedure SetStyle(const Style: TFmxObject); overload;
    class procedure SetStyle(const Context: TFmxObject; const Style: TFmxObject); overload;
    class function SetStyleFromFile(const FileName: string): Boolean; overload;
    class function SetStyleFromFile(const Context: TFmxObject; const FileName: string): Boolean; overload;
    /// <summary>Loads from resource and sets the style specified by name as the active style, without raising an exception.</summary>
    class function TrySetStyleFromResource(const ResourceName: string): Boolean;

    class procedure UnInitialize;

    class function FindStyleDescriptor(const AObject: TFmxObject): TStyleDescription;
  end;

implementation

uses
  System.Types, System.TypInfo, System.Messaging, System.RTLConsts, System.Variants,
  FMX.Controls, FMX.BehaviorManager, FMX.Graphics;

type
  PResourceEnumInfo = ^TResourceEnumInfo;
  TResourceEnumInfo = record
    Name: string;
    Instance: THandle;
  end;

function ResourceEnum(Instance: THandle; Data: Pointer): Boolean; export;
begin
  Result := True;
  if FindResource(Instance, PChar(PResourceEnumInfo(Data)^.Name), RT_RCDATA) <> 0 then
  begin
    PResourceEnumInfo(Data)^.Instance := Instance;
    Result := False;
  end;
end;

function FindResourceInBundle(const AResourceName: string; ResourceType: PChar; var Module: THandle): THandle;
var
  ResourceInfo: TResourceEnumInfo;
begin
  Module := HInstance;
  Result := FindResource(Module, PChar(AResourceName), ResourceType);
  if Result = 0 then
  begin
    ResourceInfo.Name := AResourceName;
    ResourceInfo.Instance := 0;
    EnumModules(ResourceEnum, @ResourceInfo);
    Module := ResourceInfo.Instance;
    if Module <> 0 then
      Result := FindResource(Module, PChar(AResourceName), ResourceType);
  end;
end;

{ Streaming }

function ParseValuesFromStream(const ComponentClass: string; const Properties: array of string; const Input: TStream;
  var Values: TArray<Variant>): Boolean;
var
  PropValues: TDictionary<string, Variant>;
  Reader: TReader;
  ObjectName, PropName: string;
  FoundComponent, FoundProperty: Boolean;
  FoundValue: TList<Variant>;

  procedure ConvertValue; forward;

  procedure ConvertHeader(RootComponent: Boolean);
  var
    ClassName: string;
    Flags: TFilerFlags;
    Position: Integer;
  begin
    Reader.ReadPrefix(Flags, Position);
    ClassName := Reader.ReadStr;
    ObjectName := Reader.ReadStr;
    if (RootComponent and (ComponentClass = '')) or SameText(ComponentClass, ClassName) then
      FoundComponent := True;
    if ObjectName = '' then
      ObjectName := ClassName;
  end;

  procedure AddValue(const V: Variant);
  begin
    if FoundProperty then
      FoundValue.Add(V);
  end;

  procedure ConvertProperty; forward;

  procedure ConvertValue;
  const
    LineLength = 64;
  var
    I: Integer;
    S, V: string;
  begin
    case Reader.NextValue of
      vaList:
        begin
          Reader.ReadValue;
          while not Reader.EndOfList do
            ConvertValue;
          Reader.ReadListEnd;
        end;
      vaInt8, vaInt16, vaInt32:
        AddValue(Reader.ReadInteger);
      vaExtended:
        AddValue(Reader.ReadFloat);
      vaDouble:
        AddValue(Reader.ReadDouble);
      vaSingle:
        AddValue(Reader.ReadSingle);
      vaCurrency:
        AddValue(Reader.ReadCurrency);
      vaDate:
        AddValue(Reader.ReadDate);
      vaWString, vaUTF8String, vaString, vaLString:
        AddValue(Reader.ReadString);
      vaIdent, vaFalse, vaTrue, vaNil, vaNull:
        AddValue(Reader.ReadIdent);
      vaBinary:
        Reader.SkipValue;
      vaSet:
        begin
          Reader.ReadValue;
          I := 0;
          V := '';
          while True do
          begin
            S := Reader.ReadStr;
            if S = '' then Break;
            if I > 0 then V := V + ', ';
            V := V + S;
            Inc(I);
          end;
          AddValue(V);
        end;
      vaCollection:
        begin
          Reader.ReadValue;
          while not Reader.EndOfList do
          begin
            if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
              ConvertValue;
            Reader.CheckValue(vaList);
            while not Reader.EndOfList do
              ConvertProperty;
            Reader.ReadListEnd;
          end;
          Reader.ReadListEnd;
        end;
      vaInt64:
        AddValue(Reader.ReadInt64);
    else
      raise EReadError.CreateResFmt(@SPropertyException,
        [ObjectName, DotSep, PropName, IntToStr(Ord(Reader.NextValue))]);
    end;
  end;

  procedure ConvertProperty;
  var
    SaveFound: Boolean;
    Name: string;
  begin
    SaveFound := FoundProperty;
    try
      PropName := Reader.ReadStr;
      Name := PropName;
      FoundProperty := FoundComponent and PropValues.ContainsKey(PropName);
      FoundValue.Clear;
      ConvertValue;
      if FoundValue.Count = 1 then
        PropValues[Name] := FoundValue[0];
    finally
      FoundProperty := SaveFound;
    end;
  end;

  procedure ConvertObject(RootComponent: Boolean);
  begin
    ConvertHeader(RootComponent);
    while not Reader.EndOfList do
      ConvertProperty;
    Reader.ReadListEnd;
    if not FoundComponent then
    begin
      while not Reader.EndOfList do
      begin
        ConvertObject(False);
        if FoundComponent then
          Exit;
      end;
      Reader.ReadListEnd;
    end;
  end;

var
  I: Integer;
begin
  FoundComponent := False;
  FoundProperty := False;
  FoundValue := TList<Variant>.Create;
  try
    GlobalNameSpace.BeginWrite;
    Reader := TReader.Create(Input, 4096);
    try
      PropValues := TDictionary<string, Variant>.Create;
      try
        for I := Low(Properties) to High(Properties) do
          PropValues.Add(Properties[I], System.Variants.Null);
        Reader.ReadSignature;
        ConvertObject(True);
        SetLength(Values, Length(Properties));
        for I := Low(Properties) to High(Properties) do
          Values[I] := PropValues[Properties[I]];
      finally
        PropValues.Free;
      end;
    finally
      Reader.Free;
    end;
  finally
    FoundValue.Free;
    GlobalNameSpace.EndWrite;
  end;
  Result := FoundComponent;
end;

{ TStyleDescription }

procedure TStyleDescription.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('RetinaDisplay', IgnoreBooleanValue, nil, False);
end;

function TStyleDescription.Equals(Obj: TObject): Boolean;
var
  Desc: TStyleDescription;
begin
  if Obj is TStyleDescription then
  begin
    Desc := TStyleDescription(Obj);
    Result := (Author = Desc.Author) and (AuthorEMail = Desc.AuthorEMail) and (AuthorURL = Desc.AuthorURL) and
      (PlatformTarget = Desc.PlatformTarget) and (MobilePlatform = Desc.MobilePlatform) and
      (Title = Desc.Title) and (Version = Desc.Version);
  end
  else
    Result := inherited Equals(Obj);
end;

function TStyleDescription.SupportsPlatform(const APlatform: TOSPlatform): Boolean;
begin
  Result := PlatformTarget.ToUpperInvariant.Contains(PlatformTargets[APlatform]);
end;

class function TStyleDescription.TryLoadFromStream(const Stream: TStream;
  var StyleDescription: TStyleDescription): Boolean;
var
  Values: TArray<Variant>;
begin
  Result := ParseValuesFromStream('TStyleDescription', Properties, Stream, Values);
  if Result then
  begin
    StyleDescription := TStyleDescription.Create(nil);
    if Values[Integer(TProperty.Author)] <> Null then
      StyleDescription.Author := Values[Integer(TProperty.Author)];
    if Values[Integer(TProperty.AuthorEMail)] <> Null then
      StyleDescription.AuthorEMail := Values[Integer(TProperty.AuthorEMail)];
    if Values[Integer(TProperty.PlatformTarget)] <> Null then
      StyleDescription.PlatformTarget := Values[Integer(TProperty.PlatformTarget)];
    if Values[Integer(TProperty.MobilePlatform)] <> Null then
      StyleDescription.MobilePlatform := Values[Integer(TProperty.MobilePlatform)];
    if Values[Integer(TProperty.Title)] <> Null then
      StyleDescription.Title := Values[Integer(TProperty.Title)];
    if Values[Integer(TProperty.Version)] <> Null then
      StyleDescription.Version := Values[Integer(TProperty.Version)];
  end
  else
    StyleDescription := nil;
end;

{ TStyleReader }

type
  TStyleReader = class(TReader)
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

{ TStyleStreaming }

class function TStyleStreaming.SameObject(const Obj1, Obj2: TFmxObject): Boolean;
var
  I: Integer;
begin
  Result := (Obj1.Name = Obj2.Name) and (Obj1.ChildrenCount = Obj2.ChildrenCount);
  if Result then
  begin
    for I := 0 to Obj1.ChildrenCount - 1 do
      if not SameObject(Obj1.Children[I], Obj2.Children[I]) then
      begin
        Result := False;
        Exit;
      end;
  end;
end;

class function TStyleStreaming.SameStyleDecription(const Style1, Style2: TFmxObject): Boolean;
var
  Desc1, Desc2: TStyleDescription;
begin
  Desc1 := TStyleManager.FindStyleDescriptor(Style1);
  Desc2 := TStyleManager.FindStyleDescriptor(Style2);

  Result := True;
  if (Desc1 <> nil) or (Desc2 <> nil) then
    Result := Desc1.Equals(Desc2);
end;

class function TStyleStreaming.SameStyle(const Style1, Style2: TFmxObject): Boolean;
begin
  if (Style1.ChildrenCount = 0) or (Style2.ChildrenCount = 0) then
  begin
    Result := (Style1.ChildrenCount = 0) and (Style2.ChildrenCount = 0);
    Exit;
  end;
  Result := (Style1.ChildrenCount = Style2.ChildrenCount) and SameStyleDecription(Style1, Style2) and
    SameObject(Style1, Style2);
end;

class function TStyleStreaming.IsSupportedPlatformTarget(
  const PlatformTarget: string): Boolean;
begin
  Result := True;
  if PlatformTarget = '' then Exit;
  if Assigned(FSupportedPlatformHook) then
    Result := FSupportedPlatformHook(PlatformTarget)
  else
    Result := DefaultIsSupportedPlatformTarget(PlatformTarget);
end;

class function TStyleStreaming.DefaultIsSupportedPlatformTarget(const PlatformTarget: string): Boolean;
begin
  Result := True;
  if PlatformTarget = '' then Exit;

  {$IFDEF MSWINDOWS}
  if (Pos('[MSWINDOWS]', UpperCase(PlatformTarget)) = 0) then
    Result := False;
  {$ENDIF}
  {$IFDEF MACOS}
  {$IFNDEF NEXTGEN}
  if (Pos('[MACOS]', UpperCase(PlatformTarget)) = 0) then
    Result := False;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF IOS}
  if (Pos('[IOS]', UpperCase(PlatformTarget)) = 0) and (Pos('[IOSALTERNATE]', UpperCase(PlatformTarget)) = 0) then
    Result := False;
  {$ENDIF}
  {$IFDEF ANDROID}
  if (Pos('[ANDROID]', UpperCase(PlatformTarget)) = 0) then
    Result := False;
  {$ENDIF}
end;

class function TStyleStreaming.ReadHeader(const AStream: TStream): TArray<TIndexItem>;
var
  R: TReader;
begin
  R := TReader.Create(AStream, 1024);
  R.ReadListBegin;
  while not R.EndOfList do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[High(Result)].Name := R.ReadString.ToLowerInvariant;
    Result[High(Result)].Size := R.ReadInteger;
  end;
  R.ReadListEnd;
  R.Free;
end;

class function TStyleStreaming.LoadFromIndexedStream(const AStream: TStream): TFmxObject;
var
  BinaryStream: TMemoryStream;
  IndexArray: TArray<TIndexItem>;
  I: Integer;
  Container: IBinaryStyleContainer;
  ItemObject: TFmxObject;
  Reader: TStyleReader;
  ObjectsLocation: Int64;
begin
  IndexArray := ReadHeader(AStream);

  if FDefaultContainerClass <> nil then
    Result := FDefaultContainerClass.Create(nil)
  else
    Result := TFmxObject.Create(nil);

  Supports(Result, IBinaryStyleContainer, Container);

  if Container <> nil then
    Container.ClearContainer;

  BeginGlobalLoading;
  try
    ObjectsLocation := AStream.Position;
    // First load all graphics
    if Container <> nil then
      for I := 0 to High(IndexArray) do
        if TBitmapCodecManager.CodecExists(IndexArray[I].Name) then
          Container.AddBinaryFromStream(IndexArray[I].Name, AStream, IndexArray[I].Size)
        else
          AStream.Seek(IndexArray[I].Size, soCurrent);

    // Load other objects
    AStream.Position := ObjectsLocation;
    for I := 0 to High(IndexArray) do
    begin
      if Container <> nil then
      begin
        if not TBitmapCodecManager.CodecExists(IndexArray[I].Name) then
          Container.AddBinaryFromStream(IndexArray[I].Name, AStream, IndexArray[I].Size)
        else
          AStream.Seek(IndexArray[I].Size, soCurrent);
      end
      else
      begin
        BinaryStream := TMemoryStream.Create;
        try
          BinaryStream.SetSize(IndexArray[I].Size);
          BinaryStream.CopyFrom(AStream, IndexArray[I].Size);
          BinaryStream.Position := 0;

          Reader := TStyleReader.Create(BinaryStream, 4096);
          try
            ItemObject := TFmxObject(Reader.ReadRootComponent(nil));
          finally
            Reader.Free;
          end;

          Result.AddObject(ItemObject);
        finally
          BinaryStream.Free;
        end;
      end;
    end;
    NotifyGlobalLoading
  finally
    EndGlobalLoading
  end;
end;

class function TStyleStreaming.CanLoadFromResource(const ResourceName: string; ResourceType: PChar): Boolean;
var
  Module: THandle;
begin
  if FindResourceInBundle(ResourceName, RT_RCDATA, Module) <> 0 then
    Result := CanLoadFromResource(Module, ResourceName, RT_RCDATA)
  else
    Result := False;
end;

class function TStyleStreaming.CanLoadFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar): Boolean;
var
  S: TStream;
begin
  Result := False;
  if FindResource(Instance, PChar(ResourceName), RT_RCDATA) <> 0 then
  begin
    S := TResourceStream.Create(Instance, ResourceName, ResourceType);
    try
      Result := TStyleStreaming.CanLoadFromStream(S);
    finally
      S.Free;
    end;
  end;
end;

class function TStyleStreaming.LoadFromResource(Instance: HINST; const ResourceName: string; ResourceType: PChar): TFmxObject;
var
  Stream: TStream;
begin
  Result := nil;
  Stream := TResourceStream.Create(Instance, ResourceName, ResourceType);
  try
   if TStyleStreaming.CanLoadFromStream(Stream) then
      Result := TStyleStreaming.LoadFromStream(Stream)
    else
      raise EStyleException.CreateRes(@SCannotLoadStyleFromRes);
  finally
    Stream.Free;
  end;
end;

class function TStyleStreaming.CanLoadFromFile(const FileName: string): Boolean;
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    Result := TStyleStreaming.CanLoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

class function TStyleStreaming.TryLoadStyleDescriptionFromIndexedStream(const Stream: TStream;
  var Description: TStyleDescription): Boolean;
var
  BinaryStream: TMemoryStream;
  IndexArray: TArray<TIndexItem>;
  I: Integer;
  LStyleDescriptionName : string;
begin
  Result := False;

  IndexArray := ReadHeader(Stream);
  LStyleDescriptionName := StyleDescriptionName.ToLowerInvariant;
  for I := 0 to High(IndexArray) do
    if IndexArray[I].Name.Contains(LStyleDescriptionName) then
    begin
      BinaryStream := TMemoryStream.Create;
      try
        BinaryStream.CopyFrom(Stream, IndexArray[I].Size);
        BinaryStream.Position := 0;

        Result := TStyleDescription.TryLoadFromStream(BinaryStream, Description);
      finally
        BinaryStream.Free;
      end;
      Break;
    end
    else
      Stream.Seek(IndexArray[I].Size, soCurrent);
end;

class function TStyleStreaming.LoadFromFile(const FileName: string): TFmxObject;
var
  Stream: TStream;
begin
  Result := nil;
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    if TStyleStreaming.CanLoadFromStream(Stream) then
      Result := TStyleStreaming.LoadFromStream(Stream)
    else
      raise EStyleException.CreateResFmt(@SCannotLoadStyleFromFile, [FileName]);
  finally
    Stream.Free;
  end;
end;

class function TStyleStreaming.LoadFromStream(const AStream: TStream): TFmxObject;
var
  BinStream: TStream;
  Reader: TStyleReader;
  Sign: TStyleSignature;
begin
  Result := nil;
  if TStyleStreaming.CanLoadFromStream(AStream) then
  begin
    GlobalNameSpace.BeginWrite;
    try
      ActivateClassGroup(TFmxObject);
      case TestStreamFormat(AStream) of
        sofUnknown: begin
          AStream.Read(Sign[0], Length(Sign));
          if CompareSign(Sign, FireMonkey25StyleSign) then
            Result := LoadFromIndexedStream(AStream)
          else if CompareSign(Sign, FireMonkeyStyleSign) then
            Result := LoadFromStream(AStream);
        end;
        sofBinary: begin
          Reader := TStyleReader.Create(AStream, 4096);
          try
            BeginGlobalLoading;
            try
              Result := TFmxObject(Reader.ReadRootComponent(nil));
              NotifyGlobalLoading;
            finally
              EndGlobalLoading;
            end;
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
              BeginGlobalLoading;
              try
                Result := TFmxObject(Reader.ReadRootComponent(nil));
                NotifyGlobalLoading;
              finally
                EndGlobalLoading;
              end;
            finally
              Reader.Free;
            end;
          finally
            BinStream.Free;
          end;
        end;
      end;
    finally
      GlobalNameSpace.EndWrite;
    end;
  end
  else
    raise EStyleException.CreateRes(@SCannotLoadStyleFromStream);
end;

class function TStyleStreaming.CanLoadFromStream(const AStream: TStream): Boolean;
var
  SavePosition: Int64;
  Description: TStyleDescription;
begin
  Result := False;
  if AStream.Size = 0 then
    Exit;

  SavePosition := AStream.Position;
  try
    if TryLoadStyleDescription(AStream, Description) then
    begin
      Result := IsSupportedPlatformTarget(Description.PlatformTarget);
      Description.Free;
    end
    else
      Result := True;
  finally
    AStream.Position := SavePosition;
  end;
end;

class function TStyleStreaming.CompareSign(const Sign1, Sign2: TStyleSignature): Boolean;
begin
  Result := CompareMem(@Sign1[0], @Sign2[0], Length(Sign1));
end;

class procedure TStyleStreaming.SaveToIndexedStream(const Style: TFmxObject; const AStream: TStream);
var
  W: TWriter;
  CurrentObject: Integer;
  Stream: TStream;
  ObjectsBinary: array of TStream;
  StyleObject: TFmxObject;
  Container: IBinaryStyleContainer;
begin
  AStream.Write(FireMonkey25StyleSign, SizeOf(FireMonkey25StyleSign));

  if Supports(Style, IBinaryStyleContainer, Container) then
    Container.UnpackAllBinaries;

  CurrentObject := 0;
  SetLength(ObjectsBinary, Style.ChildrenCount);
  if Style.Children <> nil then
    for StyleObject in Style.Children do
    begin
      if not StyleObject.Stored then Continue;

      ObjectsBinary[CurrentObject] := TMemoryStream.Create;
      ObjectsBinary[CurrentObject].WriteComponent(StyleObject);
      Inc(CurrentObject);
    end;

  try
    W := TWriter.Create(AStream, 1024);
    try
      W.WriteListBegin;
      try
        CurrentObject := 0;
        if Style.Children <> nil then
          for StyleObject in Style.Children do
          begin
            if not StyleObject.Stored then Continue;

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
  finally
    for Stream in ObjectsBinary do
      if Stream <> nil then
        Stream.Free;
  end;

  if Style.Children <> nil then
    for StyleObject in Style.Children do
      if StyleObject.Stored then
        AStream.WriteComponent(StyleObject);
end;

class procedure TStyleStreaming.SaveToStream(const Style: TFmxObject; const AStream: TStream;
  const Format: TStyleFormat = TStyleFormat.Indexed);
var
  Binary: TStream;
begin
  case Format of
    TStyleFormat.Indexed: SaveToIndexedStream(Style, AStream);
    TStyleFormat.Binary:
      begin
        AStream.Write(FireMonkeyStyleSign, Length(FireMonkeyStyleSign));
        AStream.WriteComponent(Style);
      end;
    TStyleFormat.Text:
      begin
        Binary := TMemoryStream.Create;
        try
          Binary.WriteComponent(Style);
          Binary.Position := 0;

          ObjectBinaryToText(Binary, AStream);
        finally
          Binary.Free;
        end;
      end;
  end;
end;

class procedure TStyleStreaming.SetDefaultContainerClass(const AClass: TFmxObjectClass);
begin
  FDefaultContainerClass := AClass;
end;

class procedure TStyleStreaming.SetSupportedPlatformHook(const AHook: TSupportedPlatformHook);
begin
  FSupportedPlatformHook := AHook;
end;

class function TStyleStreaming.TryLoadStyleDescription(const Stream: TStream;
  var Description: TStyleDescription): Boolean;
var
  Sign: TStyleSignature;
  BinStream: TMemoryStream;
begin
  Result := False;
  case TestStreamFormat(Stream) of
    sofUnknown:
      begin
        Stream.Read(Sign[0], Length(Sign));
        if CompareSign(Sign, FireMonkey25StyleSign) then
          Result := TryLoadStyleDescriptionFromIndexedStream(Stream, Description)
        else if CompareSign(Sign, FireMonkeyStyleSign) then
          Result := TryLoadStyleDescription(Stream, Description);
      end;
    sofBinary:
      begin
        Result := TStyleDescription.TryLoadFromStream(Stream, Description);
      end;
    sofText, sofUTF8Text:
      begin
        BinStream := TMemoryStream.Create;
        try
          ObjectTextToBinary(Stream, BinStream);
          BinStream.Position := 0;
          Result := TStyleDescription.TryLoadFromStream(BinStream, Description);
        finally
          BinStream.Free;
        end;
      end;
  end;
end;

{ TStyleNotification }

type
  TStyleManagerNotification = class(TFmxObject)
  protected
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject); override;
  end;

procedure TStyleManagerNotification.FreeNotification(AObject: TObject);
var
  I: Integer;
begin
  inherited;
  if (TStyleManager.FStyleResources <> nil) then
    for I := 0 to TStyleManager.FStyleResources.Count - 1 do
      if TStyleManager.FStyleResources.Values.ToArray[I] = AObject then
      begin
        TStyleManager.FStyleResources.Remove(TStyleManager.FStyleResources.Keys.ToArray[I]);
        Break;
      end;
end;

var
  StyleManagerNotification: TStyleManagerNotification;

{ TStyleManager }

class procedure TStyleManager.UnInitialize;
var
  Style: TFmxObject;
begin
  if FStyleResources <> nil then
  begin
    for Style in FStyleResources.Values do
    begin
      if StyleManagerNotification <> nil then
        Style.RemoveFreeNotify(StyleManagerNotification);
      Style.DisposeOf;
    end;
    FStyleResources.Free;
  end;
  FPlatformResources.Free;
  FSelections.Free;
  StyleManagerNotification.Free;
end;

class procedure TStyleManager.EnumStyleResources(Proc: TStyleResourceEnumProc);
var
  I: Integer;
begin
  if FPlatformResources <> nil then
    for I := 0 to FPlatformResources.Count - 1 do
      Proc(FPlatformResources.Keys.ToArray[I], FPlatformResources.Values.ToArray[I]);
end;

class function TStyleManager.FindDefaultStyleResource(const OSPlatform: TOSPlatform): string;
var
  I: Integer;
begin
  if FPlatformResources = nil then
    raise EStyleException.CreateRes(@SNoPlatformStyle);

  for I := 0 to FPlatformResources.Count - 1 do
    if FPlatformResources.Values.ToArray[I] = OSPlatform then
      Exit(FPlatformResources.Keys.ToArray[I]);

  raise EStyleException.CreateRes(@SInvalidPlatformStyle);
end;

class function TStyleManager.StyleResourceForContext(const Context: TFmxObject): string;
var
  DeviceInfo: IDeviceBehavior;
  OSPlatform: TOSPlatform;
  PlatformSelection: TPlatformStyleSelectionProc;
begin
  if TBehaviorServices.Current.SupportsBehaviorService(IDeviceBehavior, DeviceInfo, Context) then
    OSPlatform := DeviceInfo.GetOSPlatform(Context)
  else
    raise EStyleException.CreateRes(@SNoIDeviceBehaviorBehavior);

  if (FSelections <> nil) and FSelections.TryGetValue(OSPlatform, PlatformSelection) then
    Result := PlatformSelection(OSPlatform)
  else
    Result := FindDefaultStyleResource(OSPlatform);
end;

class function TStyleManager.ActiveStyle(const Context: TFmxObject): TFmxObject;
var
  StyleResource: string;
begin
  StyleResource := StyleResourceForContext(Context);
  Result := GetStyleResource(StyleResource);
end;

class procedure TStyleManager.SetStyle(const Style: TFmxObject);
begin
  SetStyle(nil, Style);
end;

class procedure TStyleManager.SetStyle(const Context, Style: TFmxObject);
var
  StyleResource: string;
  NewStyle, OldStyle: TFmxObject;
begin
  StyleResource := StyleResourceForContext(Context);

  if (FStyleResources <> nil) and FStyleResources.TryGetValue(StyleResource, OldStyle) then
  begin
    OldStyle.RemoveFreeNotify(StyleManagerNotification);
    OldStyle.DisposeOf;
    FStyleResources.Remove(StyleResource);
  end;

  if Style = nil then
    NewStyle := GetStyleResource(StyleResource)
  else
    NewStyle := Style;

  if FStyleResources = nil then
    FStyleResources := TDictionary<string, TFmxObject>.Create;
  FStyleResources.AddOrSetValue(StyleResource, NewStyle);

  NewStyle.AddFreeNotify(StyleManagerNotification);

  UpdateScenes;
end;

class function TStyleManager.SetStyleFromFile(const FileName: string): Boolean;
begin
  Result := SetStyleFromFile(nil, FileName);
end;

class function TStyleManager.SetStyleFromFile(const Context: TFmxObject; const FileName: string): Boolean;
var
  S: TFmxObject;
begin
  Result := False;
  S := TStyleStreaming.LoadFromFile(FileName);
  if S <> nil then
  begin
    Result := True;
    SetStyle(S);
  end;
end;

class procedure TStyleManager.UpdateScenes;
begin
  TMessageManager.DefaultManager.SendMessage(nil, TBeforeStyleChangingMessage.Create, True);
  TMessageManager.DefaultManager.SendMessage(nil, TStyleChangedMessage.Create(nil, nil), True);
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
       Founded := DescriptorTmp <> nil;
       Inc(I);
    end;
  Result := DescriptorTmp;
end;

class function TStyleManager.TrySetStyleFromResource(const ResourceName: string): Boolean;
var
  Style: TFmxObject;
  Module: THandle;
begin
  Result := False;
  if (FStyleResources <> nil) and FStyleResources.TryGetValue(ResourceName, Style) then
    Result := True
  else if FindResourceInBundle(ResourceName, RT_RCDATA, Module) <> 0 then
  begin
    Style := GetStyleResource(ResourceName);
    Result := True;
  end;

  if Result then
    SetStyle(Style);
end;

class function TStyleManager.GetStyleResource(const ResourceName: string): TFmxObject;
var
  Module: THandle;
begin
  if FStyleResources = nil then
    FStyleResources := TDictionary<string, TFmxObject>.Create;

  if not FStyleResources.TryGetValue(ResourceName, Result) and
    (FindResourceInBundle(ResourceName, RT_RCDATA, Module) <> 0) then
  begin
    Result := TStyleStreaming.LoadFromResource(Module, ResourceName, RT_RCDATA);

    if Result <> nil then
    begin
      TStyleManager.RemoveStyleFromGlobalPool(Result);

      if StyleManagerNotification = nil then
        StyleManagerNotification := TStyleManagerNotification.Create(nil);

      Result.AddFreeNotify(StyleManagerNotification);
    end;

    FStyleResources.Add(ResourceName, Result);
  end;
end;

class procedure TStyleManager.RegisterPlatformStyleResource(const APlatform: TOSPlatform; const ResourceName: string);
begin
  if FPlatformResources = nil then
    FPlatformResources := TDictionary<string, TOSPlatform>.Create;

  if not FPlatformResources.ContainsKey(ResourceName) then
    FPlatformResources.Add(ResourceName, APlatform);
end;

class procedure TStyleManager.RegisterPlatformStyleSelection(const APlatform: TOSPlatform;
  const ASelection: TPlatformStyleSelectionProc);
begin
  if FSelections = nil then
    FSelections := TDictionary<TOSPlatform, TPlatformStyleSelectionProc>.Create;

  if not FSelections.ContainsKey(APlatform) then
    FSelections.Add(APlatform, ASelection);
end;

class procedure TStyleManager.RemoveStyleFromGlobalPool(const Style: TFmxObject);
var
  Child: TFmxObject;
begin
  if (Style <> nil) and (Style.Children <> nil) then
    for Child in Style.Children do
      if not TBitmapCodecManager.CodecExists(Child.StyleName) then
        FMX.Types.RemoveResource(Child);
end;

initialization
  RegisterFmxClasses([TStyleDescription, TStyleTag]);
end.

