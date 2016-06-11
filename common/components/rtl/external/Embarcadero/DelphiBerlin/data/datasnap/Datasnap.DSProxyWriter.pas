{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSProxyWriter;

interface

uses Data.DBXPlatform, Datasnap.DSCommonProxy, System.Generics.Collections, System.Masks, System.SysUtils;

type

  TDSProxyWriter = class;

  TDSProxyWriterFactory = class
  public
    class function Instance: TDSProxyWriterFactory; static;
    class procedure RegisterWriter(const Id: string; const WriterClass: TObjectClass); static;
    class procedure UnregisterWriter(const Id: string); static;
    class function HasWriter(const Id: string): Boolean;
    class function GetWriter(const Id: string): TDSProxyWriter; static;
    class function RegisteredWritersList: TDBXStringArray; static;
    constructor Create;
    destructor Destroy; override;
  private
    class var
      FSingleton: TDSProxyWriterFactory;
      FRegisteredWriters: TDictionary<string,TObjectClass>;
  end;

  TDSProxyWriteFeature = (feConnectsWithDSRestConnection, feConnectsWithDBXConnection, feRESTClient, feDBXClient);
  TDSProxyWriteFeatures = set of TDSProxyWriteFeature;

  TDSProxyWriterProperties = record
    UsesUnits: string;
    DefaultExcludeClasses: string;
    DefaultExcludeMethods: string;
    DefaultEncoding: TEncoding;
    Author: string;
    Comment: string;
    Language: string;
    Features: TDSProxyWriteFeatures;
  end;

  TDSProxyFileDescription = record
    ID: string;
    DefaultFileExt: string;
  end;

  TDSProxyFileDescriptions = array of TDSProxyFileDescription;

  TDSCustomProxyWriter = class;

  TDSProxyWriter = class abstract(TFactoryObject)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; virtual; abstract;
    function Properties: TDSProxyWriterProperties; virtual; abstract;
    function FileDescriptions: TDSProxyFileDescriptions; virtual; abstract;
  end;

  TDSProxyParamAccess = record
    TypeIdentifier: string;
    Getter: string;
    Setter: string;
    TypeUnit: string;
    constructor Create(const ATypeId, AGetter, ASetter: string; const ATypeUnit: string = '');
  end;

  TDSCustomProxyWriter = class abstract
  public
    constructor Create;
    destructor Destroy; override;
    procedure WriteProxy; virtual;
  protected
    procedure WriteImplementation; virtual; abstract;
    procedure WriteInterface; virtual; abstract;
    procedure WriteFileHeader; virtual;
    function GetTimeStamp: string; virtual;
    procedure DerivedWrite(const Line: string); virtual; abstract;
    procedure DerivedWriteLine; virtual; abstract;
    function GetAssignmentString: string; virtual; abstract;
    function IncludeClassName(const ClassName: string): Boolean;
    function IncludeMethodName(const MethodName: string): Boolean;
    function IncludeClass(const ProxyClass: TDSProxyClass): Boolean;  virtual;
    function IncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean;  virtual;
    procedure WriteLine(const Line: string); overload;
    procedure Indent;
    procedure Outdent;
    procedure WriteLine; overload;
    function IsKnownTableTypeName(const Name: string): Boolean; virtual;
    function IsKnownDBXValueTypeName(const Name: string): Boolean; virtual;
    function IsKnownJSONTypeName(const Name: string): Boolean; virtual;
    function GetDelphiTypeName(const Param: TDSProxyParameter): string; virtual;
    function GetDelphiUnitName(const Param: TDSProxyParameter): string; virtual;
    function GetGetter(const Param: TDSProxyParameter): string;
    function GetSetter(const Param: TDSProxyParameter): string;
    function GetCreateDataSetReader(const Param: TDSProxyParameter): string; virtual; abstract;
    function GetCreateParamsReader(const Param: TDSProxyParameter): string; virtual; abstract;
  private type
    TCustomTypeMapPair = TPair<Integer, Integer>;
  strict private
    FMetadata: TDSProxyMetadata;
    FOwnsMetaData: Boolean;
    FCustomTypeMap: TDictionary<TCustomTypeMapPair, TDSProxyParamAccess>;
  private
    procedure ClearMasks;
    function InclusionTest(const Includes: TDBXStringArray; const Excludes: TDBXStringArray; const Name: string): Boolean;
    procedure SetMetaDataLoader(const Value: IDSProxyMetaDataLoader);
  protected
    FUnitFileName: string;
    FIndentString: string;
    FIndentIncrement: Integer;
    FMetaDataLoader: IDSProxyMetaDataLoader;
    procedure AddCustomTypeMap(const ADbxDataType: Integer; const AProxyParamRec: TDSProxyParamAccess); overload;
    procedure AddCustomTypeMap(const ADbxDataType, ADbxSubDataType: Integer; const AProxyParamRec: TDSProxyParamAccess); overload;
    procedure RemoveCustomTypeMap(const ADbxDataType: Integer);
  private
    FIndentSpaces: Integer;
    FMasks: TDictionary<string, TMask>;
    FIncludeClasses: TDBXStringArray;
    FExcludeClasses: TDBXStringArray;
    FIncludeMethods: TDBXStringArray;
    FExcludeMethods: TDBXStringArray;
    FProxyWriters: TDictionary<string, IDSProxyWriter>;
    function GetMetadata: TDSProxyMetadata;
    procedure SetExcludeClasses(const Value: TDBXStringArray);
    procedure SetExcludeMethods(const Value: TDBXStringArray);
    procedure SetIncludeClasses(const Value: TDBXStringArray);
    procedure SetIncludeMethods(const Value: TDBXStringArray);
  public
    property Metadata: TDSProxyMetadata read GetMetadata;
    property MetaDataLoader: IDSProxyMetaDataLoader read FMetaDataLoader write SetMetaDataLoader;
    property ProxyWriters: TDictionary<string, IDSProxyWriter> read FProxyWriters;
    property UnitFileName: string read FUnitFileName write FUnitFileName;
    property IncludeClasses: TDBXStringArray read FIncludeClasses write SetIncludeClasses;
    property ExcludeClasses: TDBXStringArray read FExcludeClasses write SetExcludeClasses;
    property IncludeMethods: TDBXStringArray read FIncludeMethods write SetIncludeMethods;
    property ExcludeMethods: TDBXStringArray read FExcludeMethods write SetExcludeMethods;
  protected
    property AssignmentString: string read GetAssignmentString;
  end;

const
  // value from toolsapi.pas
  sDSProxyDelphiLanguage = 'Delphi';
  sDSProxyCppLanguage = 'C++';
  sDSProxyJavaScriptLanguage = 'Java Script';

implementation

uses Data.DBXCommon, Datasnap.DSClientResStrs, System.Generics.Defaults
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

{ TDSClientProxyWriterFactory }
class function TDSProxyWriterFactory.Instance: TDSProxyWriterFactory;
begin
  if FSingleton = nil then
    FSingleton := TDSProxyWriterFactory.Create;
  Result := FSingleton;
end;

class procedure TDSProxyWriterFactory.RegisterWriter(const Id: string; const WriterClass: TObjectClass);
begin
  if Instance <> nil then
  begin
    if Instance.FRegisteredWriters.ContainsKey(Id) then
      Instance.FRegisteredWriters.Items[Id] := WriterClass
    else
      Instance.FRegisteredWriters.Add(Id, WriterClass);
  end;
end;

class procedure TDSProxyWriterFactory.UnregisterWriter(const Id: string);
begin
  if Instance <> nil then
  begin
    if Instance.FRegisteredWriters.ContainsKey(Id) then
    begin
      Instance.FRegisteredWriters.Remove(Id);
      if Instance.FRegisteredWriters.Count = 0 then
        FreeAndNil(FSingleton);
    end;
  end;
end;

class function TDSProxyWriterFactory.HasWriter(const Id: string): Boolean;
begin
  Result := (Instance <> nil) and Instance.FRegisteredWriters.ContainsKey(Id);
end;

class function TDSProxyWriterFactory.GetWriter(const Id: string): TDSProxyWriter;
var
  Clazz: TObjectClass;
begin
  if Id = '' then
    raise TDSProxyException.Create(SNoWriter);
  if not HasWriter(Id) then
    raise TDSProxyException.CreateFmt(SUnknownWriter, [Id]);
  if Instance.FRegisteredWriters.ContainsKey(Id) then
  begin
    Clazz := Instance.FRegisteredWriters[Id];
    try
      Exit(TDSProxyWriter(Clazz.Create));
    except
      on E: Exception do
        ;
    end;
    Result := nil;
  end
  else
    Result := nil;
end;

class function TDSProxyWriterFactory.RegisteredWritersList: TDBXStringArray;
begin
  if Instance <> nil then
    Result := TDBXStringArray(Instance.FRegisteredWriters.Keys.ToArray)
  else
    SetLength(Result, 0);
end;

constructor TDSProxyWriterFactory.Create;
begin
  inherited Create;
  FRegisteredWriters := TDictionary<string,TObjectClass>.Create(TIStringComparer.Ordinal);
end;

destructor TDSProxyWriterFactory.Destroy;
begin
  FreeAndNil(FRegisteredWriters);
  FSingleton := nil;
  inherited Destroy;
end;

procedure TDSCustomProxyWriter.WriteFileHeader;
var
  GeneratedMessage: string;
  Line: string;
  LTimeStamp: string;
begin
  GeneratedMessage := '// ' + SGeneratedCode;
  LTimeStamp := GetTimeStamp;
  if Trim(LTimeStamp) <> '' then
    LTimeStamp := '// ' + LTimeStamp;
  Line := '// ';
  WriteLine(Line);
  WriteLine(GeneratedMessage);
  if Trim(LTimeStamp) <> '' then
    WriteLine(LTimeStamp);
  WriteLine(Line);
  WriteLine;
end;

procedure TDSCustomProxyWriter.AddCustomTypeMap(const ADbxDataType: Integer;
  const AProxyParamRec: TDSProxyParamAccess);
begin
  AddCustomTypeMap(ADbxDataType, TDBXDataTypes.UnknownType, AProxyParamRec);
end;

procedure TDSCustomProxyWriter.AddCustomTypeMap(const ADbxDataType, ADbxSubDataType: Integer;
  const AProxyParamRec: TDSProxyParamAccess);
begin
  FCustomTypeMap.AddOrSetValue(TCustomTypeMapPair.Create(ADbxDataType, ADbxSubDataType), AProxyParamRec);
end;

procedure TDSCustomProxyWriter.ClearMasks;
begin
  FMasks.Clear;
end;

constructor TDSCustomProxyWriter.Create;
begin
  inherited Create;
  FMasks := TObjectDictionary<string, TMask>.Create([doOwnsValues]);
  FCustomTypeMap := TDictionary<TCustomTypeMapPair, TDSProxyParamAccess>.Create;
  FProxyWriters := TDictionary<string, IDSProxyWriter>.Create;
end;

function TDSCustomProxyWriter.InclusionTest(const Includes: TDBXStringArray; const Excludes: TDBXStringArray; const Name: string): Boolean;

  function IsMatch(const Pattern: string): Boolean;
  var
    Mask: TMask;
  begin
    if not FMasks.TryGetValue(Pattern, Mask) then
    begin
      Mask := TMask.Create(Trim(Pattern));
      FMasks.Add(Pattern, Mask);
    end;
    Result := Mask.Matches(Name);
  end;

var
  Index: Integer;
begin
  Result := True;
  if Excludes <> nil then
  begin
    for Index := 0 to Length(Excludes) - 1 do
    begin
      if IsMatch(Excludes[Index]) then
      begin
        Result := False;
        Break;
      end;
    end;
  end;
  if Includes <> nil then
  begin
    for Index := 0 to Length(Includes) - 1 do
    begin
      if IsMatch(Includes[Index]) then
      begin
        Exit(True);
      end;
    end;
    Result := False;
  end;
end;

function TDSCustomProxyWriter.IncludeClassName(const ClassName: string): Boolean;
begin
  Result := InclusionTest(FIncludeClasses, FExcludeClasses, ClassName);
end;

function TDSCustomProxyWriter.IncludeMethodName(const MethodName: string): Boolean;
begin
  Result := InclusionTest(FIncludeMethods, FExcludeMethods, MethodName);
end;

procedure TDSCustomProxyWriter.WriteLine(const Line: string);
begin
  DerivedWrite(FIndentString + Line);
  DerivedWriteLine;
end;

procedure TDSCustomProxyWriter.Indent;
var
  Index: Integer;
begin
  FIndentSpaces := FIndentSpaces + FIndentIncrement;
  for Index := 0 to FIndentIncrement - 1 do
    FIndentString := FIndentString + ' ';
end;

procedure TDSCustomProxyWriter.Outdent;
var
  Index: Integer;
begin
  FIndentSpaces := FIndentSpaces - FIndentIncrement;
  FIndentString := '';
  for Index := 0 to FIndentSpaces - 1 do
    FIndentString := FIndentString + ' ';
end;

procedure TDSCustomProxyWriter.RemoveCustomTypeMap(const ADbxDataType: Integer);
begin
  FCustomTypeMap.Remove(TCustomTypeMapPair.Create(ADbxDataType, TDBXDataTypes.UnknownType));
end;

procedure TDSCustomProxyWriter.SetExcludeClasses(const Value: TDBXStringArray);
begin
  ClearMasks;
  FExcludeClasses := Value;
end;

procedure TDSCustomProxyWriter.SetExcludeMethods(const Value: TDBXStringArray);
begin
  ClearMasks;
  FExcludeMethods := Value;
end;

procedure TDSCustomProxyWriter.SetIncludeClasses(const Value: TDBXStringArray);
begin
  ClearMasks;
  FIncludeClasses := Value;
end;

procedure TDSCustomProxyWriter.SetIncludeMethods(const Value: TDBXStringArray);
begin
  ClearMasks;
  FIncludeMethods := Value;
end;

procedure TDSCustomProxyWriter.SetMetaDataLoader(
  const Value: IDSProxyMetaDataLoader);
begin
  FMetaDataLoader := Value;
end;

procedure TDSCustomProxyWriter.WriteLine;
begin
  DerivedWriteLine;
end;

procedure TDSCustomProxyWriter.WriteProxy;
begin
  WriteFileHeader;
  WriteInterface;
  WriteImplementation;
end;

function TDSCustomProxyWriter.IsKnownTableTypeName(const Name: string): Boolean;
begin
  if not Name.IsEmpty then
  begin
    if (string.Compare(Name, 'TDataSet') = 0) or (string.Compare(Name, 'TParams') = 0) then
      Exit(True);
  end;
  Result := False;
end;

function TDSCustomProxyWriter.IsKnownDBXValueTypeName(const Name: string): Boolean;
begin
  if not Name.IsEmpty then
  begin
    if (string.Compare(Name.Substring(0, 4), 'TDBX') = 0) and (Name.IndexOf('Value') = Name.Length - 5) then
      Exit(True);
  end;
  Result := False;
end;

function TDSCustomProxyWriter.IsKnownJSONTypeName(const Name: string): Boolean;
begin
  if not Name.IsEmpty then
  begin
    if string.Compare(Name.Substring(0, 5), 'TJSON') = 0 then
      Exit(True);
  end;
  Result := False;
end;

destructor TDSCustomProxyWriter.Destroy;
begin
  FCustomTypeMap.Free;
  FMasks.Free;
  FProxyWriters.Free;
  if FOwnsMetaData then
    FMetadata.Free;
  inherited;
end;

function TDSCustomProxyWriter.GetDelphiUnitName(const Param: TDSProxyParameter): string;
var
  Pair: TCustomTypeMapPair;
  Item: TDSProxyParamAccess;
begin
  Pair := TCustomTypeMapPair.Create(Param.DataType, Param.SubDataType);
  if FCustomTypeMap.TryGetValue(Pair, Item) then
    Result := Item.TypeUnit
  else
    Result := '';
  if Result = '' then
    Result := Param.TypeUnit;
end;

function TDSCustomProxyWriter.GetDelphiTypeName(const Param: TDSProxyParameter): string;
var
  Name: string;
  Pair: TCustomTypeMapPair;
  Item: TDSProxyParamAccess;
begin
  Pair := TCustomTypeMapPair.Create(Param.DataType, Param.SubDataType);
  if FCustomTypeMap.TryGetValue(Pair, Item) then
    Exit(Item.TypeIdentifier);
  Name := Param.TypeName;
  if not Name.IsEmpty then
    Exit(Name);
  case Param.DataType of
    TDBXDataTypes.AnsiStringType:
      Name := 'AnsiString';
    TDBXDataTypes.BooleanType:
      Name := 'Boolean';
    TDBXDataTypes.Int8Type:
      Name := 'ShortInt';
    TDBXDataTypes.UInt8Type:
      Name := 'Byte';
    TDBXDataTypes.Int16Type:
      Name := 'SmallInt';
    TDBXDataTypes.UInt16Type:
      Name := 'Word';
    TDBXDataTypes.Int32Type:
      Name := 'Integer';
    TDBXDataTypes.Int64Type:
      Name := 'Int64';
    TDBXDataTypes.WideStringType:
      Name := 'String';
    TDBXDataTypes.SingleType:
      Name := 'Single';
    TDBXDataTypes.DoubleType:
      Name := 'Double';
    TDBXDataTypes.BcdType:
      Name := 'TBcd';
    TDBXDataTypes.TimeType:
      Name := 'TDBXTime';
    TDBXDataTypes.DatetimeType:
      Name := 'TDateTime';
    TDBXDataTypes.DateType:
      Name := 'TDBXDate';
    TDBXDataTypes.TimeStampType:
      Name := 'TSQLTimeStamp';
    TDBXDataTypes.TimeStampOffsetType:
      Name := 'TSQLTimeStampOffset';
    TDBXDataTypes.CurrencyType:
      Name := 'Currency';
    TDBXDataTypes.TableType:
      if IsKnownTableTypeName(Param.TypeName) then
        Name := Param.TypeName
      else
        Name := 'TDBXReader';
    TDBXDataTypes.BinaryBlobType:
      Name := 'TStream';
    TDBXDataTypes.VariantType:
      Name := 'Variant';
    TDBXDataTypes.DbxConnectionType:
      Name := 'TDBXConnection';
    else
      Name := '{UnknownType(' + IntToStr(Param.DataType) + ')}';
  end;
  Result := Name;
end;

function TDSCustomProxyWriter.GetGetter(const Param: TDSProxyParameter): string;
var
  Getter: string;
  Pair: TCustomTypeMapPair;
  Item: TDSProxyParamAccess;
begin
  Pair := TCustomTypeMapPair.Create(Param.DataType, Param.SubDataType);
  if FCustomTypeMap.TryGetValue(Pair, Item) then
    Exit(Item.Getter);
  case Param.DataType of
    TDBXDataTypes.AnsiStringType:
      Getter := 'GetAnsiString';
    TDBXDataTypes.BooleanType:
      Getter := 'GetBoolean';
    TDBXDataTypes.Int8Type:
      Getter := 'GetInt8';
    TDBXDataTypes.UInt8Type:
      Getter := 'GetUInt8';
    TDBXDataTypes.Int16Type:
      Getter := 'GetInt16';
    TDBXDataTypes.UInt16Type:
      Getter := 'GetUInt16';
    TDBXDataTypes.Int32Type:
      Getter := 'GetInt32';
    TDBXDataTypes.Int64Type:
      Getter := 'GetInt64';
    TDBXDataTypes.WideStringType:
      Getter := 'GetWideString';
    TDBXDataTypes.SingleType:
      Getter := 'GetSingle';
    TDBXDataTypes.DoubleType:
      Getter := 'GetDouble';
    TDBXDataTypes.BcdType:
      Getter := 'GetBcd';
    TDBXDataTypes.TimeType:
      Getter := 'GetTime';
    TDBXDataTypes.DatetimeType:
      Getter := 'AsDateTime';
    TDBXDataTypes.DateType:
      Getter := 'GetDate';
    TDBXDataTypes.TimeStampType:
      Getter := 'GetTimeStamp';
    TDBXDataTypes.TimeStampOffsetType:
      Getter := 'GetTimeStampOffset';
    TDBXDataTypes.CallbackType:
      Getter := 'GetCallbackValue';
    TDBXDataTypes.JsonValueType:
      Getter := 'GetJSONValue';
    TDBXDataTypes.CurrencyType:
      Getter := 'AsCurrency';
    TDBXDataTypes.TableType:
      Getter := 'GetDBXReader';
    TDBXDataTypes.BinaryBlobType:
      Getter := 'GetStream';
    TDBXDataTypes.VariantType:
      Getter := 'AsVariant';
    else
      Getter := '{UnknownType(' + IntToStr(Param.DataType) + ')}';
  end;
  Result := Getter;
end;

function TDSCustomProxyWriter.GetMetadata: TDSProxyMetadata;
begin
  if FMetaData = nil then
  begin
    FMetaData := TDSProxyMetadata.Create;
    FOwnsMetaData := True;
    if FMetaDataLoader <> nil then
      FMetaDataLoader.Load(FMetaData);
  end;
  Result := FMetaData;
end;

function TDSCustomProxyWriter.GetSetter(const Param: TDSProxyParameter): string;
var
  Setter: string;
  HasOwnerOption: Boolean;
  Pair: TCustomTypeMapPair;
  Item: TDSProxyParamAccess;
begin
  HasOwnerOption := False;
  case Param.DataType of
    TDBXDataTypes.AnsiStringType:
      Setter := 'SetAnsiString';
    TDBXDataTypes.BooleanType:
      Setter := 'SetBoolean';
    TDBXDataTypes.Int8Type:
      Setter := 'SetInt8';
    TDBXDataTypes.UInt8Type:
      Setter := 'SetUInt8';
    TDBXDataTypes.Int16Type:
      Setter := 'SetInt16';
    TDBXDataTypes.UInt16Type:
      Setter := 'SetUInt16';
    TDBXDataTypes.Int32Type:
      Setter := 'SetInt32';
    TDBXDataTypes.Int64Type:
      Setter := 'SetInt64';
    TDBXDataTypes.WideStringType:
      Setter := 'SetWideString';
    TDBXDataTypes.SingleType:
      Setter := 'SetSingle';
    TDBXDataTypes.DoubleType:
      Setter := 'SetDouble';
    TDBXDataTypes.BcdType:
      Setter := 'SetBcd';
    TDBXDataTypes.TimeType:
      Setter := 'SetTime';
    TDBXDataTypes.DatetimeType:
      Setter := 'AsDateTime';
    TDBXDataTypes.DateType:
      Setter := 'SetDate';
    TDBXDataTypes.TimeStampType:
      Setter := 'SetTimeStamp';
    TDBXDataTypes.TimeStampOffsetType:
      Setter := 'SetTimeStampOffset';
    TDBXDataTypes.CallbackType:
      Setter := 'SetCallbackValue';
    TDBXDataTypes.JsonValueType:
      begin
        Setter := 'SetJSONValue';
        HasOwnerOption := True;
      end;
    TDBXDataTypes.CurrencyType:
      Setter := 'AsCurrency';
    TDBXDataTypes.TableType:
      begin
        Setter := 'SetDBXReader';
        HasOwnerOption := True;
      end;
    TDBXDataTypes.BinaryBlobType:
      begin
        Setter := 'SetStream';
        HasOwnerOption := True;
      end;
    TDBXDataTypes.VariantType:
      Setter := 'AsVariant';
    else
      Setter := '{UnknownType(' + IntToStr(Param.DataType) + ')}';
  end;

  Pair := TCustomTypeMapPair.Create(Param.DataType, Param.SubDataType);
  if FCustomTypeMap.TryGetValue(Pair, Item) then
    // Use same HasOwnerOption value
    Setter := Item.Setter;

  if Setter.Chars[0] = 'S' then
  begin
    if (Param.DataType = TDBXDataTypes.TableType) and IsKnownTableTypeName(Param.TypeName) then
    begin
      if string.Compare(Param.TypeName, 'TDataSet', True) = 0 then
        Exit(Setter + GetCreateDataSetReader(Param))
      else if string.Compare(Param.TypeName, 'TParams', True) = 0 then
        Exit(Setter + GetCreateParamsReader(Param));
    end;
    if IsKnownDBXValueTypeName(Param.TypeName) then
      Exit(Setter + '(' + Param.ParameterName + '.Value.' + GetGetter(Param) + ')');
    Setter := Setter + '(' + Param.ParameterName;
    if HasOwnerOption then
      Setter := Setter + ', FInstanceOwner)'
    else
      Setter := Setter + ')';
  end
  else
    Setter := Setter + ' ' + AssignmentString + ' ' + Param.ParameterName;
  Result := Setter;
end;

function TDSCustomProxyWriter.GetTimeStamp: string;
var
  LNow: TDateTime;
begin
  LNow := Now;
  Result := FormatDateTime(FormatSettings.ShortDateFormat, LNow) + ' ' + FormatDateTime(FormatSettings.LongTimeFormat, LNow);
end;

function TDSCustomProxyWriter.IncludeClass(
  const ProxyClass: TDSProxyClass): Boolean;
begin
  Result := IncludeClassName(ProxyClass.ProxyClassName);
end;

function TDSCustomProxyWriter.IncludeMethod(
  const ProxyMethod: TDSProxyMethod): Boolean;
begin
  Result := INcludeMethodName(ProxyMethod.ProxyMethodName);
end;

{ TDSProxyParamAccess }

constructor TDSProxyParamAccess.Create(const ATypeId, AGetter, ASetter: string; const ATypeUnit: string);
begin
  TypeIdentifier := ATypeId;
  Getter := AGetter;
  Setter := ASetter;
  TypeUnit := ATypeUnit;
end;

end.

