{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSReflect;

interface

uses
  System.Classes,
  System.JSON,
  System.JSON.Writers,
  Data.DBXCommon,
  Data.DBXJSON,
  Data.DBXJSONReflect,
  Data.DBXPlatform,
  System.TypInfo,
  System.ObjAuto,
  System.Generics.Collections,
  System.Rtti;

type
  TDSMethod = class;
  TDSClass = class;

  TArrayOfTValue = array of TValue;
  TArrayOfObject = array of TObject;

  TDSMethodArray = array of TDSMethod;
  TDSClassArray = array of TDSClass;
{$MethodInfo on}
  TDSAdapterClassType = class of TDSAdapterClass;
  TDSAdapterClass = class(TPersistent)
  private
    FAdapteeInstance: TObject;
  public
    constructor Create(AdapteeInstance: TObject); virtual;
  end;
{$MethodInfo off}

  TDSDataModuleAdapterClass = class(TDSAdapterClass)
  protected
    function ExtractDataModule: TDataModule; virtual; abstract;
  end;

  TDSClass = class
  private
    FClassRef: TPersistentClass;
    FAdapteeClass: TDSClass;
    FClassName: string;
    FIsArrayParameter: Boolean;
    FIsVarParameter: Boolean;
    FIsOutParameter: Boolean;
    FOriginalTypeData: PTypeData;
    FTypeData: PTypeData;
    FValueParameter: Boolean;
    FIsAdapted: Boolean;
    FInvalidTypeData: Boolean;
    function GetMethods: TDSMethodArray;
    function GetDBXDataType(AllowUnknown: Boolean; Parameter: TDBXParameter): Integer;
    function GetDBXSubDataType: Integer;
    function GetDSClassName: string;
    function IsVoidReturn: Boolean;
    function IsArrayParameter: Boolean;
    function IsInOutParameter: Boolean;
    function IsOutParameter: Boolean;
    function GetClassLoadError: string;
    function GetTypeUnit: string;
  public
    constructor Create(AClassRef: TPersistentClass; AIsAdapted: Boolean); overload;
    constructor Create(AClassRef: TPersistentClass; AAdapteeClass: TDSClass); overload;
    constructor Create(ClassName: string; TypeData: PTypeData;  AIsArrayParameter, AIsVarParameter, AIsOutParameter: Boolean); overload;
    destructor Destroy; override;
    function CreateInstance: TObject;
    procedure GetDbxType(Parameter: TDBXParameter);
    function CreateMethod(MethodName: string): TDSMethod;
    property Methods: TDSMethodArray read GetMethods;
    property DSClassName: string read GetDSClassName;
    property VoidReturn: Boolean read IsVoidReturn;
    property ArrayParameter: Boolean read IsArrayParameter;
    property OutParameter: Boolean read IsOutParameter;
    property InOutParameter: Boolean read IsInOutParameter;
    property ClassLoadError: string read GetClassLoadError;
    property ValueParameter: Boolean read FValueParameter;
    property AdapteeDSClass: TDSClass read FAdapteeClass;
    property TypeUnit: string read GetTypeUnit;
    property ClassRef: TPersistentClass read FClassRef;
  end;

  TDSPackage = class
  private
    FPackagename: string;
    FClassList: TStringList;
    procedure GetClassesProc(AClass: TPersistentClass);
  public
    constructor Create;
    destructor Destroy; override;
    function GetDSPackages: TDBXStringArray;
    function GetDSClasses(classNamePattern: string): TDBXStringArray;
    function CreateDSClass(ClassName: string): TDSClass;
    property PackageName: string read FPackagename write FPackagename;
    property DSPackages: TDBXStringArray read GetDSPackages;
  end;

  TDSMethodValues = class
  private type
    TArrayOfPair = array of TPair<TObject, Boolean>;
  private
    FAllocatedObjects: TArrayOfPair;
    FAllocatedReturn: TObject;
    FMethodValues: TArrayOfTValue;
    FReturnValue: TValue;
    FServerSideCommand: Boolean;
    FJSONMarshal: TJSONMarshal;
    FJSONUnMarshal: TJSONUnMarshal;
    FUserObjects: TObjectList<TObject>;

    procedure SetDBXJSONValueParameter(const DBXParameter: TDBXParameter; Value: TValue);
    procedure SetDBXParameter(const DBXParameter: TDBXParameter; Value: TValue);
    procedure SetDBXReaderParameter(const DBXParameter: TDBXParameter; Value: TValue);
    procedure SetDBXStreamParameter(const DBXParameter: TDBXParameter; Value: TValue);
    procedure PopulateMarshal(const Parameter: TDBXParameter);
    function  JSONToUserObject(Json: TJSONValue): TObject;
    function  UserObjectToJSON(Data: TObject): TJSONValue;
    procedure SetAllocatedObject(Ordinal: Integer; AllocatedObject: TObject; AlwaysFree: Boolean = False);
    procedure SetServerSideCommand(AServerSide: Boolean);
    function GetValObject<T: class>(Value: TValue): T;
  public
    constructor Create;
    destructor Destroy; override;
    function ClearReferenceParameters: Boolean;
    procedure AssignParameterValues(Parameters: TDBXParameterArray);
    procedure GetReturnValue(ReturnValue: TDBXParameter);
    procedure GetOutValue(OutValue: TDBXParameter);
    function GetValues: TArrayOfTValue;
    property ReturnValue: TValue read FReturnValue write FReturnValue;
    property ServerSidecommand: Boolean read FServerSideCommand write SetServerSideCommand;
  end;

  TDSMethod = class
  private
    FMethodInfoHeader: PMethodInfoHeader;
    FParameterTypes: TDSClassArray;
    FParameterNames: TDBXStringArray;
    FMethodName: string;
    FMethodClass: TDSClass;
    FDSReturnType: TDSClass;
    FIsPublicMethod: Boolean;
    FIsStaticMethod: Boolean;
    FIsConstructor: Boolean;
    FIsDestructor: Boolean;
    function IsPublicMethod: Boolean;
    function IsStaticMethod: Boolean;
    function GetParameterTypes: TDSClassArray;
    function GetReturnType: TDSClass;
    function GetDSMethodName: string;
    function GetMethodClass: TDSClass;
    function GetParameterNames: TDBXStringArray;
  public
    class function InvokeStringFunction(objClass: TObjectClass; methodName: string): string;

  public
    constructor Create(AMethodInfo: PMethodInfoHeader; const AMethodClass: TDSClass);
    destructor Destroy; override;
    function GetClassInstance(AObject: TObject): TObject;
    procedure Invoke(MethodInstance: TObject; MethodValues: TDSMethodValues);
    property PublicMethod: Boolean read IsPublicMethod;
    property StaticMethod: Boolean read IsStaticMethod;
    property ParameterTypes: TDSClassArray read GetParameterTypes;
    property ParameterNames: TDBXStringArray read GetParameterNames;
    property ReturnType: TDSClass read GetReturnType;
    property DSMethodName: string read GetDSMethodName;
    property MethodClass: TDSClass read GetMethodClass;
    property IsConstructor: Boolean read FIsConstructor;
    property IsDestructor: Boolean read FIsDestructor;
  end;

  const STDataSet             = 'TDataSet';
  const STParams              = 'TParams';
  const STDBXReaderValue      = 'TDBXReaderValue';
  const SOleVariant           = 'OleVariant';
implementation

uses
  Data.DB,
  Data.DBXClientResStrs,
  Data.DBXDBReaders,
  Datasnap.DSCommonServer,
  Datasnap.DSServer,
  Data.DBXDataSets,
  Data.FmtBcd,
  System.RTLConsts,
  Data.SqlTimSt,
  System.SysUtils;

type
  PJSONValue = ^TJSONValue;

{ TDSMethodValues }

procedure TDSMethodValues.AssignParameterValues(Parameters: TDBXParameterArray);
var
  I: Integer;
  ParameterValue: TDBXWritableValue;
  Parameter: TDBXParameter;
  CurrencyValue: Currency;
  StreamValue: TStream;
  JSONValue: TJSONValue;
  UserValue: TObject;
  TypeName: string;
  Reader: TDBXReader;
  DataSet: TDBXReaderDataSet;
  Params: TParams;
  LStream: TDBXJSONStream;
  LAllocatedObjects: TObjectList<TObject>;
begin
  ClearReferenceParameters;
  if Length(FMethodValues) <> Length(Parameters) then
  begin
    SetLength(FMethodValues, Length(Parameters));
    SetLength(FAllocatedObjects, Length(Parameters));
  end;

  for I := 0 to Length(Parameters) - 1 do
  begin
    Parameter := Parameters[I];
    ParameterValue := Parameter.Value;
    if Parameter.ValueParameter then
      FMethodValues[I] := ParameterValue
    else
    begin
      case Parameter.DataType of
        TDBXDataTypes.BooleanType:
          FMethodValues[I] := TValue.From<Boolean>(ParameterValue.GetBoolean);
        TDBXDataTypes.UInt8Type:
          FMethodValues[I] := TValue.From<UInt8>(ParameterValue.GetUInt8);
        TDBXDataTypes.Int8Type:
          FMethodValues[I] := TValue.From<Int8>(ParameterValue.GetInt8);
        TDBXDataTypes.UInt16Type:
          FMethodValues[I] := TValue.From<UInt16>(ParameterValue.GetUInt16);
        TDBXDataTypes.Int16Type:
          FMethodValues[I] := TValue.From<Int16>(ParameterValue.GetInt16);
        TDBXDataTypes.Int32Type:
          FMethodValues[I] := TValue.From<Int32>(ParameterValue.GetInt32);
        TDBXDataTypes.Int64Type:
          FMethodValues[I] := TValue.From<Int64>(ParameterValue.GetInt64);
        TDBXDataTypes.SingleType:
          FMethodValues[I] := TValue.From<Single>(ParameterValue.GetSingle);
        TDBXDataTypes.DoubleType:
          FMethodValues[I] := TValue.From<Double>(ParameterValue.GetDouble);
        TDBXDataTypes.DateTimeType:
          FMethodValues[I] := TValue.From<TDateTime>(SQLTimeStampToDateTime(ParameterValue.GetTimeStamp));
        TDBXDataTypes.CurrencyType:
        begin
          BCDToCurr(ParameterValue.GetBcd, CurrencyValue);
          FMethodValues[I] := TValue.From<Currency>(CurrencyValue);
        end;
        TDBXDataTypes.AnsiStringType:
{$IFDEF NEXTGEN}
          FMethodValues[I] := TValue.From<string>(ParameterValue.GetString);
{$ELSE}
          FMethodValues[I] := TValue.From<AnsiString>(ParameterValue.GetAnsiString);
{$ENDIF}
        TDBXDataTypes.WideStringType:
          FMethodValues[I] := TValue.From<string>(ParameterValue.GetWideString);
        TDBXDataTypes.TableType:
          begin
            if ParameterValue.IsNull then
              FMethodValues[I] := TValue.Empty
            else
            begin
              Reader := ParameterValue.GetDBXReader(False);
              TypeName := Parameter.TypeName;
              if TypeName = '' then
                FMethodValues[I] := TValue.From<TDBXReader>(Reader)
              else if TypeName = STDataSet then
              begin
                // Reader will be freed by a parent caller method.
                DataSet := TDBXReaderDataSet.Create(nil, Reader, False);
                DataSet.Open;
                SetAllocatedObject(I, DataSet, True);
                FMethodValues[I] := TValue.From<TDBXReaderDataSet>(DataSet);
              end
              else if TypeName = STParams then
              begin
                // Caller owns Reader and will free it later.
                Params := TDBXParamsReader.ToParams(nil, Reader, False);
                SetAllocatedObject(I, Params, True);
                FMethodValues[I] := TValue.From<TParams>(Params);
              end
              else
              begin
                SetAllocatedObject(I, Reader);
                FMethodValues[I] := TValue.From<TDBXReader>(Reader);
              end;
            end;
          end;
        TDBXDataTypes.DBXConnectionType:
          FMethodValues[I] := TValue.From<TDBXConnection>(ParameterValue.GetDBXConnection);
        TDBXDataTypes.BinaryBlobType:
          begin
            if ParameterValue.IsNull then
            begin
              if Parameter.SubType = TDBXSubDataTypes.JSONStreamSubtype then
              begin
                Assert((Parameter.ParameterDirection = TDBXParameterDirections.OutParameter) or
                  (Parameter.ParameterDirection = TDBXParameterDirections.ReturnParameter));
                LStream := TDBXJSONStream.Create;
                LAllocatedObjects := TObjectList<TObject>.Create;
                LAllocatedObjects.Add(LStream);
                // Pass TDBXJSONStream to server method
                FMethodValues[I] := TValue.From<TDBXJSONStream>(LStream);
                // Free TDBXJSONStream later
                SetAllocatedObject(I, LAllocatedObjects);
              end
              else
                FMethodValues[I] := TValue.Empty;
            end
            else if Parameter.SubType = TDBXSubDataTypes.JSONStreamSubtype then
            begin
              // Every call to GetStream gets a new TStream instance, so only fetch it
              // once.
              if not FServerSideCommand then
                StreamValue := ParameterValue.GetStream(False)
              else
                StreamValue := ParameterValue.GetStream;
              Assert(Parameter.ParameterDirection = TDBXParameterDirections.InParameter);
              LStream := TDBXJSONStream.Create(StreamValue, True);
              LAllocatedObjects := TObjectList<TObject>.Create;
              LAllocatedObjects.Add(LStream);
              // Pass JSON Stream to server method
              FMethodValues[I] := TValue.From<TDBXJSONStream>(LStream);
              // Free all objects, except stream.  Stream is out parameter.
              SetAllocatedObject(I, LAllocatedObjects);
            end
            else
            begin
              // Every call to GetStream gets a new TStream instance, so only fetch it
              // once.
              if not FServerSideCommand then
                StreamValue := ParameterValue.GetStream(False)
              else
                StreamValue := ParameterValue.GetStream;
              SetAllocatedObject(I, StreamValue);
              FMethodValues[I] := TValue.From<TStream>(StreamValue);
            end;
          end;
        TDBXDataTypes.VariantType:
          FMethodValues[I] := TValue.FromVariant(ParameterValue.AsVariant);
        TDBXDataTypes.TimeType:
          FMethodValues[I] := TValue.From<TDBXTime>(ParameterValue.GetTime);
        TDBXDataTypes.DateType:
          FMethodValues[I] := TValue.From<TDBXDate>(ParameterValue.GetDate);
        TDBXDataTypes.JsonValueType:
          begin
            if ParameterValue.IsNull then
              FMethodValues[I] := TValue.Empty
            else
            begin
              if Parameter.SubType = TDBXSubDataTypes.UserSubType then
              begin
                JSONValue := ParameterValue.GetJSONValue(True);
                if (JSONValue <> nil) and JSONValue.Null then
                  JSONValue := ParameterValue.GetJSONValue(False);
                PopulateMarshal(Parameter);
                UserValue := JSONToUserObject(JSONValue);
                FUserObjects.Add(UserValue);
                FMethodValues[I] := TValue.From<TObject>(UserValue);
              end
              else
              begin
                JSONValue := ParameterValue.GetJSONValue(False);
                SetAllocatedObject(I, JSONValue);
                FMethodValues[I] := TValue.From<TJSONValue>(JSONValue);
              end;
            end;
          end;
        TDBXDataTypes.CallbackType:
          FMethodValues[I] := TValue.From<TDBXCallback>(ParameterValue.GetCallbackValue);
      else
        raise Exception.CreateFmt(SUnknownType, [Parameter.DataType]);
      end;
    end;
  end;
end;

function TDSMethodValues.ClearReferenceParameters: Boolean;
var
  I: Integer;
begin
  Result := true;
  for I := 0 to Length(FMethodValues) - 1 do
  begin
    if not FServerSideCommand or FAllocatedObjects[I].Value then
      try
        FreeAndNil(FAllocatedObjects[I].Key)
      except
        Result := false
      end;
  end;
  SetLength(FMethodValues, 0);
  SetLength(FAllocatedObjects, 0);

  FreeAndNil(FJSONMarshal);
  FreeAndNil(FJSONUnMarshal);

  if not FServerSideCommand then
    try
      FreeAndNil(FAllocatedReturn)
    except
      Result := false
    end;

  try
    FUserObjects.Clear;
  except
    Result := false
  end;
end;

constructor TDSMethodValues.Create;
begin
  FUserObjects := TObjectList<TObject>.Create(true);
  inherited;
end;

destructor TDSMethodValues.Destroy;
begin
  ClearReferenceParameters;
  FMethodValues := nil;
  FAllocatedObjects := nil;
  FreeAndNil(FUserObjects);
  FreeAndNil(FJSONMarshal);
  FreeAndNil(FJSONUnMarshal);
  inherited;
end;

procedure TDSMethodValues.GetOutValue(OutValue: TDBXParameter);
var
  LValue: TValue;
  LStream: TStream;
begin
  LValue := FMethodValues[OutValue.Ordinal];
  if (OutValue.SubType = TDBXSubDataTypes.JSONStreamSubType) and LValue.IsObject and (LValue.AsObject is TDBXJSONStream) then
  begin
    LStream := TDBXJSONStream(LValue.AsObject).ExtractStream;
    FMethodValues[OutValue.Ordinal] := LStream;
    LValue.AsObject.Free;
    if LStream <> nil then
      LStream.Position := 0;
    SetDbxParameter(OutValue, TValue.From<TStream>(LStream));
  end
  else
    SetDbxParameter(OutValue, LValue);
end;

procedure TDSMethodValues.GetReturnValue(ReturnValue: TDBXParameter);
var
  LValue: TValue;
  LStream: TStream;
begin
  LValue := FReturnValue;
  if (ReturnValue.SubType = TDBXSubDataTypes.JSONStreamSubType) and LValue.IsObject and (LValue.AsObject is TDBXJSONStream) then
  begin
    LStream := TDBXJSONStream(LValue.AsObject).ExtractStream;
    FReturnValue := LStream;
    LValue.AsObject.Free;
    if LStream <> nil then
      LStream.Position := 0;
    SetDbxParameter(ReturnValue, TValue.From<TStream>(LStream));
  end
  else
    SetDbxParameter(ReturnValue, LValue);
end;

function TDSMethodValues.GetValues: TArrayOfTValue;
begin
  Result := FMethodValues;
end;

function TDSMethodValues.JSONToUserObject(Json: TJSONValue): TObject;
begin
  // nil parameters are accepted, usually due to var or out
  if (Json = nil) or (Json.Null) then
    exit(nil);
  Result := FJSONUnMarshal.Unmarshal(Json)
end;

procedure TDSMethodValues.PopulateMarshal(const Parameter: TDBXParameter);
begin
  if FJSONMarshal = nil then
    if (Parameter.ConnectionHandler <> nil) and
       (Parameter.ConnectionHandler is TDSServerConnectionHandler) then
      if TDSServerConnectionHandler(Parameter.ConnectionHandler).Server is TDSServer then
      begin
        FJSONMarshal := TDSServer(TDSServerConnectionHandler(Parameter.ConnectionHandler).Server).GetJSONMarshaler;
        FJSONUnMarshal := TDSServer(TDSServerConnectionHandler(Parameter.ConnectionHandler).Server).GetJSONUnMarshaler;
      end;
  // throw exception if the JSON marshal fields are not populated, NPE is next
end;

procedure TDSMethodValues.SetAllocatedObject(Ordinal: Integer;
  AllocatedObject: TObject; AlwaysFree: Boolean);
begin
  if Length(FAllocatedObjects) > Ordinal then
  begin
    if not FServerSideCommand then
      if FAllocatedObjects[Ordinal].Key <> AllocatedObject then
        // Don't free if the value has not been changed by the server method.
        // May be the same, for example, with var AStream: TStream parameter when the server method doesn't
        // assign to AStream.
        FreeAndNil(FAllocatedObjects[Ordinal].Key);
    FAllocatedObjects[Ordinal].Key := AllocatedObject;
    FAllocatedObjects[Ordinal].Value := AlwaysFree;
  end else
  begin
    if not FServerSideCommand then
      FreeAndNil(FAllocatedReturn);
    FAllocatedReturn := AllocatedObject;
  end;
end;

procedure TDSMethodValues.SetDBXParameter(const DBXParameter: TDBXParameter;
  Value: TValue);
var
  BCDValue: TBcd;
begin
  case DBXParameter.DataType of
    TDBXDataTypes.BooleanType:
      DBXParameter.Value.SetBoolean(Value.AsType<Boolean>);
    TDBXDataTypes.UInt8Type:
      DBXParameter.Value.SetUInt8(Value.AsType<UInt8>);
    TDBXDataTypes.Int8Type:
      DBXParameter.Value.SetInt8(Value.AsType<Int8>);
    TDBXDataTypes.UInt16Type:
      DBXParameter.Value.SetUInt16(Value.AsType<UInt16>);
    TDBXDataTypes.Int16Type:
      DBXParameter.Value.SetInt16(Value.AsType<Int16>);
    TDBXDataTypes.Int32Type:
      DBXParameter.Value.SetInt32(Value.AsType<Int32>);
    TDBXDataTypes.Int64Type:
      DBXParameter.Value.SetInt64(Value.AsType<Int64>);
    TDBXDataTypes.SingleType:
      DBXParameter.Value.SetSingle(Value.AsType<Single>);
    TDBXDataTypes.DoubleType:
      DBXParameter.Value.SetDouble(Value.AsType<Double>);
    TDBXDataTypes.DateTimeType:
      DBXParameter.Value.SetTimeStamp(DateTimeToSQLTimeStamp(Value.AsType<TDateTime>));
    TDBXDataTypes.CurrencyType:
      begin
        CurrToBCD(Value.AsType<Currency>, BCDValue);
        DBXParameter.Value.SetBcd(BCDValue);
      end;
    TDBXDataTypes.TimeType:
    //TDBXTime is an alias for FixedInt
      DBXParameter.Value.SetTime(Value.AsType<TDBXTime>);
    TDBXDataTypes.DateType:
    //TDBXDate is an alias for FixedInt
      DBXParameter.Value.SetDate(Value.AsType<TDBXDate>);
    TDBXDataTypes.AnsiStringType:
    begin
{$IFDEF NEXTGEN}
      DBXParameter.Value.SetString(Value.AsType<string>);
{$ELSE}
      DBXParameter.Value.SetAnsiString(Value.AsType<AnsiString>);
{$ENDIF}
    end;
    TDBXDataTypes.WideStringType:
      DBXParameter.Value.SetWideString(Value.AsType<string>);
    TDBXDataTypes.TableType:
      SetDBXReaderParameter(DBXParameter, Value);
    TDBXDataTypes.DBXConnectionType:
      DBXParameter.Value.SetDBXConnection(GetValObject<TDBXConnection>(Value));
    TDBXDataTypes.JSONValueType:
      SetDBXJSONValueParameter(DBXParameter, Value);
    TDBXDataTypes.CallbackType:
      DBXParameter.Value.SetCallbackValue(GetValObject<TDBXCallback>(Value));
    TDBXDataTypes.BinaryBlobType:
      SetDBXStreamParameter(DBXParameter, Value);
    TDBXDataTypes.VariantType:
      DBXParameter.Value.AsVariant := Value.AsVariant;
    else
      raise Exception.CreateFmt(SUnknownType, [DBXParameter.DataType]);
  end;
end;

procedure TDSMethodValues.SetDBXJSONValueParameter(const DBXParameter: TDBXParameter;
  Value: TValue);
var
  LJSONValue: TJSONValue;
  LUserValue: TObject;
begin
  if Value.IsEmpty then
    DBXParameter.Value.SetNull
  else
  begin
    if DBXParameter.SubType = TDBXSubDataTypes.UserSubType then
    begin
      PopulateMarshal(DBXParameter);
      LUserValue := GetValObject<TObject>(Value);
      LJSONValue := UserObjectToJSON(LUserValue);
      if not FUserObjects.Contains(LUserValue) then
        FUserObjects.Add(LUserValue);
    end
    else
      LJSONValue := GetValObject<TJSONValue>(Value);
    DBXParameter.Value.SetJSONValue(LJSONValue, False);
    SetAllocatedObject(DBXParameter.Ordinal, LJSONValue);
  end;
end;

function TDSMethodValues.GetValObject<T>(Value: TValue): T;
begin
  Result := Value.AsType<T>;
end;

procedure TDSMethodValues.SetDBXReaderParameter(const DBXParameter: TDBXParameter;
  Value: TValue);
var
  TypeName: string;
  DataSet: TDataSet; 
                                                                                         
  Params: TParams;   
  DBXReader: TDBXReader;
  DBXReaderValue: TDBXReaderValue;
begin
  TypeName := DBXParameter.TypeName;
  if TypeName = '' then
  begin
    if Value.IsEmpty then
      DBXParameter.Value.SetNull
    else
    begin
      DBXReader := GetValObject<TDBXReader>(Value);
      DBXParameter.Value.SetDBXReader(DBXReader, False);
      SetAllocatedObject(DBXParameter.Ordinal, DBXReader);
    end;
  end
  else if TypeName = STDBXReaderValue then
  begin
    if Value.IsEmpty then
      DBXParameter.Value.SetNull
    else
    begin
      DBXReaderValue := GetValObject<TDBXReaderValue>(Value);
      SetAllocatedObject(DBXParameter.Ordinal, DBXReaderValue.GetDBXReader(False));
      DBXParameter.Value.SetDBXReader(DBXReaderValue.GetDBXReader(False), False);
    end;
  end
  else if TypeName = STDataSet then
  begin
    if Value.IsEmpty then
      DBXParameter.Value.SetNull
    else
    begin
      Dataset := GetValObject<TDataSet>(Value);
      DBXReader := TDBXDataSetReader.Create(DataSet, DataSet.Owner = nil);
      SetAllocatedObject(DBXParameter.Ordinal, DBXReader);
      DBXParameter.Value.SetDBXReader(DBXReader, False);
    end;
  end
  else if TypeName = STParams then
  begin
    if Value.IsEmpty then
      DBXParameter.Value.SetNull
    else
    begin
      Params := GetValObject<TParams>(Value);
      DBXReader := TDBXParamsReader.Create(Params, Params.Owner = nil);
      SetAllocatedObject(DBXParameter.Ordinal, DBXReader);
      DBXParameter.Value.SetDBXReader(DBXReader, False);
    end;
  end
end;

procedure TDSMethodValues.SetDBXStreamParameter(const DBXParameter: TDBXParameter;
  Value: TValue);
var
  Stream: TStream;
begin
  if Value.IsEmpty then
    DBXParameter.Value.SetNull
  else
  begin
    Stream := GetValObject<TStream>(Value);
    DBXParameter.Value.SetStream(Stream, False);
    SetAllocatedObject(DBXParameter.Ordinal, Stream);
  end;
end;

procedure TDSMethodValues.SetServerSideCommand(AServerSide: Boolean);
begin
  FServerSidecommand := AServerSide;
end;

function TDSMethodValues.UserObjectToJSON(Data: TObject): TJSONValue;
begin
  if Data = nil then
    exit(nil);
  Result := FJSONMarshal.Marshal(Data)
end;

{ TDSMethod }

constructor TDSMethod.Create(AMethodInfo: PMethodInfoHeader; const AMethodClass: TDSClass);
var
  ReturnInfo: PReturnInfo;
  ParamInfo: PParamInfo;
  I, NumParams: Integer;
  HasResult, HasSelf: Boolean;
  TypeData: PTypeData;
// these should go in the RTL somewhere
const
  cSymbolNameSize = 256;
  mfConstructor = 1 shl 2;
  mfDestructor = 1 shl 3;
begin
  inherited Create;
  FMethodInfoHeader := AMethodInfo;
  FMethodClass := AMethodClass;
  FIsPublicMethod := True;
  ReturnInfo := Pointer(AMethodInfo);
  FMethodName := AMethodInfo.NameFld.ToString;
{$IFDEF NEXTGEN}
  Inc(IntPtr(ReturnInfo), SizeOf(TMethodInfoHeader) - cSymbolNameSize + 1 + Length(FMethodName) + 255);
{$ELSE}
  Inc(IntPtr(ReturnInfo), SizeOf(TMethodInfoHeader) - cSymbolNameSize + 1 + Length(FMethodName));
{$ENDIF}
  if Assigned(ReturnInfo.ReturnType) then
  begin
    if ReturnInfo.ReturnType^.Kind = tkClass then
      TypeData := GetTypeData(ReturnInfo.ReturnType^)
    else
      TypeData := nil;
    FDSReturnType := TDSClass.Create(UTF8ToString(ReturnInfo.ReturnType^.Name), TypeData, False, False, True)
  end
  else
    FDSReturnType := TDSClass.Create(nil, False);
  FIsConstructor := False; // (ReturnInfo.Flags and mfConstructor) <> 0;
  FIsDestructor := False; // (ReturnInfo.Flags and mfDestructor) <> 0;
  ParamInfo := Pointer(ReturnInfo);
  Inc(IntPtr(ParamInfo), SizeOf(TReturnInfo));
  HasSelf := False;
  HasResult := False;
  NumParams := ReturnInfo^.ParamCount;
  for I := 0 to NumParams - 1 do
  begin
    HasSelf := HasSelf or SameText(ParamInfo.NameFld.ToString, 'Self') or  // do not localize
       SameText(ParamInfo.NameFld.ToString, 'this'); // do not localize
    HasResult := HasResult or (pfResult in ParamInfo.Flags);
{$IFDEF NEXTGEN}
    Inc(IntPtr(ParamInfo), SizeOf(TParamInfo) - cSymbolNameSize + 1 + Length(ParamInfo.NameFld.ToString) + 255);
{$ELSE}
    Inc(IntPtr(ParamInfo), SizeOf(TParamInfo) - cSymbolNameSize + 1 + Length(ParamInfo.NameFld.ToString));
{$ENDIF}
    Inc(IntPtr(ParamInfo), PWord(ParamInfo)^);
  end;
  SetLength(FParameterTypes, NumParams - Ord(HasSelf) - Ord(HasResult));
  SetLength(FParameterNames, NumParams - Ord(HasSelf) - Ord(HasResult));
  ParamInfo := Pointer(ReturnInfo);
  Inc(IntPtr(ParamInfo), SizeOf(TReturnInfo));
  for I := 0 to NumParams - 1 - Ord(HasResult) do
  begin
    if (I > 0) or not HasSelf then
    begin
      if ParamInfo.ParamType^.Kind = tkClass then
        TypeData := GetTypeData(ParamInfo.ParamType^)
      else
        TypeData := nil;
      FParameterTypes[I - Ord(HasSelf)] := TDSClass.Create(UTF8ToString(ParamInfo.ParamType^.Name), TypeData, pfArray in ParamInfo.Flags,
        (pfVar in ParamInfo.Flags) and not (pfOut in ParamInfo.Flags), pfOut in ParamInfo.Flags);
      FParameterNames[I - Ord(HasSelf)] := UTF8ToString(ParamInfo.Name);
    end;
{$IFDEF NEXTGEN}
    Inc(IntPtr(ParamInfo), SizeOf(TParamInfo) - cSymbolNameSize + 1 + Length(ParamInfo.NameFld.ToString) + 255);
{$ELSE}
    Inc(IntPtr(ParamInfo), SizeOf(TParamInfo) - cSymbolNameSize + 1 + Length(ParamInfo.NameFld.ToString));
{$ENDIF}
    Inc(IntPtr(ParamInfo), PWord(ParamInfo)^)
  end;
end;

destructor TDSMethod.Destroy;
var
  Index: Integer;
begin
  FDSReturnType.Free;
  for Index := 0 to Length(FParameterTypes) - 1 do
    FParameterTypes[Index].Free;
  FParameterTypes := nil;
  FParameterNames := nil;
  inherited;
end;

function TDSMethod.GetMethodClass: TDSClass;
begin
  Result := FMethodClass;
end;

function TDSMethod.GetDSMethodName: string;
begin
  Result := FMethodName;
end;

function TDSMethod.GetParameterNames: TDBXStringArray;
begin
  Result := FParameterNames;
end;

function TDSMethod.GetParameterTypes: TDSClassArray;
begin
  Result := FParameterTypes;
end;

function TDSMethod.GetReturnType: TDSClass;
begin
  Result := FDSReturnType;
end;

function TDSMethod.GetClassInstance(AObject: TObject): TObject;
begin
  if FMethodClass.FIsAdapted then
    Result := TDSAdapterClass(AObject).FAdapteeInstance
  else
    Result := AObject;
end;

class function TDSMethod.InvokeStringFunction(objClass: TObjectClass; methodName: string): string;
var
  RContext: TRttiContext;
  RType: TRttiType;
  Instance: TObject;
begin
  Instance := objClass.Create;
  try
    RType := RContext.GetType(objClass);
    Result := RType.GetMethod(methodName).Invoke(Instance, []).AsString;
  finally
    Instance.Free;
  end;
end;

procedure TDSMethod.Invoke(MethodInstance: TObject;
  MethodValues: TDSMethodValues);
var
  RContext: TRttiContext;
  RType: TRttiType;
  Params: TArrayOfTValue;
begin
  Params := MethodValues.GetValues;
  RType := RContext.GetType(MethodInstance.ClassType);
  MethodValues.ReturnValue := RType.GetMethod(FMethodInfoHeader.NameFld.ToString).Invoke(MethodInstance, Params);
end;

function TDSMethod.IsPublicMethod: Boolean;
begin
  Result := FIsPublicMethod;
end;

function TDSMethod.IsStaticMethod: Boolean;
begin
  Result := FIsStaticMethod;
end;

{ TDSClass }

constructor TDSClass.Create(AClassRef: TPersistentClass; AIsAdapted: Boolean);
begin
  inherited Create;
  FIsAdapted := AIsAdapted;
  FClassRef := AClassRef;
end;

constructor TDSClass.Create(AClassRef: TPersistentClass; AAdapteeClass: TDSClass);
begin
  inherited Create;
  FClassRef         := AClassRef;
  FAdapteeClass     := AAdapteeClass;
end;

constructor TDSClass.Create(ClassName: string; TypeData: PTypeData; AIsArrayParameter, AIsVarParameter, AIsOutParameter: Boolean);
var
  LTypeInfo: PTypeInfo;
begin
  inherited Create;
  FClassName := ClassName;
  // Normalize type names (to work with C++ RTTI)
  if ClassName = 'UnicodeString' then
    FClassName := 'String'
  else if ClassName = 'short' then
    FClassName := 'SmallInt'
  else if ClassName = 'bool' then
    FClassName := 'Boolean'
  else if ClassName = '__int64' then
    FClassName := 'Int64'
  else if ClassName = 'float' then
    FClassName := 'Single'
  else if ClassName = 'double' then
    FClassName := 'Double'
  else if ClassName = 'int' then
    FClassName := 'Integer'
  else if ClassName = 'unsigned short' then
    FClassName := 'Word'
  else if ClassName = 'unsigned long' then
    FClassName := 'DWord'
  else if ClassName = 'unsigned char' then
    FClassName := 'Byte'
  else if ClassName = 'signed char' then
    FClassName := 'ShortInt'
  else if ClassName = 'unsigned' then
    FClassName := 'LongWord'
  else if ClassName = 'short' then
    FClassName := 'SmallInt'
  else if ClassName = 'unsigned long' then
    FClassName := 'DWord';
  FTypeData := TypeData;
  FIsArrayParameter := AIsArrayParameter;
  FIsVarParameter := AIsVarParameter;
  FIsOutParameter := AIsOutParameter;
  if Assigned(FTypeData) then
    if FTypeData.ClassType.InheritsFrom(TDBXWritableValue) then
      FValueParameter := true;
  if Assigned(FTypeData) then
    if FTypeData.ClassType.InheritsFrom(TDBXJSONStream) then
    begin
      FOriginalTypeData := FTypeData;
      FClassName := 'TStream';
      LTypeInfo := TypeInfo(TStream);
      FTypeData := LTypeInfo.TypeData;
      // Must not be var
      FInvalidTypeData := FIsVarParameter; 
    end;
end;

function TDSClass.CreateInstance: TObject;
var
  AdapteeInstance: TObject;
  Component: TComponent;
begin
  if Assigned(FClassRef) then
  begin
    if Assigned(FAdapteeClass) then
    begin
      AdapteeInstance := FAdapteeClass.CreateInstance;
      Result := TDSAdapterClassType(FClassRef).Create(AdapteeInstance);
    end
    else
    begin
      if FClassRef.InheritsFrom(TComponent) then
      begin
        // Allows Forms and DataModules to read in the components
        // they contain.
        //
        Component := FClassRef.NewInstance as TComponent;
        Component.Create(nil);
        Result := Component;
      end
      else
        Result := FClassRef.Create
    end;
  end
  else
    Result := nil;
end;

destructor TDSClass.Destroy;
begin
  FreeAndNil(FAdapteeClass);
  inherited;
end;

function TDSClass.GetDSClassName: string;
begin
  if FClassRef = nil then
    Result := FClassName
  else
    Result := FClassRef.ClassName;
end;

function TDSClass.GetClassLoadError: string;
begin
  Result := '';
end;

function TDSClass.GetDBXDataType(AllowUnknown: Boolean; Parameter: TDBXParameter): Integer;
begin
  if Assigned(FTypeData) then
  begin
    if FTypeData.ClassType.InheritsFrom(TDBXWideStringValue) then
      Result := TDBXDataTypes.WideStringType
    else if FTypeData.ClassType.InheritsFrom(TDBXAnsiStringValue) then
      Result := TDBXDataTypes.AnsiStringType
    else if FTypeData.ClassType.InheritsFrom(TDBXReader) then
      Result := TDBXDataTypes.TableType
    else if FTypeData.ClassType.ClassNameIs(STDataSet) then
    begin
      if Parameter <> nil then
        Parameter.TypeName := STDataSet;
      Result := TDBXDataTypes.TableType;
    end
    else if FTypeData.ClassType.ClassNameIs(STParams) then
    begin
      if Parameter <> nil then
        Parameter.TypeName := STParams;
      Result := TDBXDataTypes.TableType;
    end
    else if FTypeData.ClassType.InheritsFrom(TDBXConnection) then
      Result := TDBXDataTypes.DBXConnectionType
    else if FTypeData.ClassType.InheritsFrom(TStream) then
      Result := TDBXDataTypes.BinaryBlobType
    else if FTypeData.ClassType.InheritsFrom(TDBXUInt8Value) then
      Result := TDBXDataTypes.UInt8Type
    else if FTypeData.ClassType.InheritsFrom(TDBXInt8Value) then
      Result := TDBXDataTypes.Int8Type
    else if FTypeData.ClassType.InheritsFrom(TDBXUInt16Value) then
      Result := TDBXDataTypes.UInt16Type
    else if FTypeData.ClassType.InheritsFrom(TDBXInt16Value) then
      Result := TDBXDataTypes.Int16Type
    else if FTypeData.ClassType.InheritsFrom(TDBXInt32Value) then
      Result := TDBXDataTypes.Int32Type
    else if FTypeData.ClassType.InheritsFrom(TDBXInt64Value) then
      Result := TDBXDataTypes.Int64Type
    else if FTypeData.ClassType.InheritsFrom(TDBXSingleValue) then
      Result := TDBXDataTypes.SingleType
    else if FTypeData.ClassType.InheritsFrom(TDBXDoubleValue) then
      Result := TDBXDataTypes.DoubleType
    else if FTypeData.ClassType.InheritsFrom(TDBXBcdValue) then
      Result := TDBXDataTypes.BcdType
    else if FTypeData.ClassType.InheritsFrom(TDBXTimeValue) then
      Result := TDBXDataTypes.TimeType
    else if FTypeData.ClassType.InheritsFrom(TDBXDateValue) then
      Result := TDBXDataTypes.DateType
    else if FTypeData.ClassType.InheritsFrom(TDBXTimeStampValue) then
      Result := TDBXDataTypes.TimeStampType
    else if FTypeData.ClassType.InheritsFrom(TDBXTimeStampOffsetValue) then
      Result := TDBXDataTypes.TimeStampOffsetType
    else if FTypeData.ClassType.InheritsFrom(TDBXBooleanValue) then
      Result := TDBXDataTypes.BooleanType
    else if FTypeData.ClassType.InheritsFrom(TDBXReaderValue) then
      Result := TDBXDataTypes.TableType
    else if FTypeData.ClassType.InheritsFrom(TDBXConnectionValue) then
      Result := TDBXDataTypes.DBXConnectionType
    else if FTypeData.ClassType.InheritsFrom(TDBXJSONValue) then
      Result := TDBXDataTypes.JsonValueType
    else if FTypeData.ClassType.InheritsFrom(TJSONValue) then
      Result := TDBXDataTypes.JsonValueType
    else if FTypeData.ClassType.InheritsFrom(TDBXCallback) then
      Result := TDBXDataTypes.CallbackType
    else if FTypeData.ClassType.InheritsFrom(TDBXStreamValue) then
      Result := TDBXDataTypes.BinaryBlobType
    else if FTypeData.ClassType.ClassNameIs(SOleVariant) then
    begin
      Result := TDBXDataTypes.VariantType;
    end
    else if FTypeData.ClassType.InheritsFrom(TObject) then
      Result := TDBXDataTypes.JsonValueType
    else
    begin
      if AllowUnknown then
        Result := TDBXDataTypes.UnknownType
      else
        raise Exception.CreateFmt(SUnknownTypeName, [FTypeData.ClassType.ClassName]);
    end;
  end
  else if SameText(FClassName, 'Integer') then
    Result := TDBXDataTypes.Int32Type
  else if SameText(FClassName, 'AnsiString') then
    Result := TDBXDataTypes.AnsiStringType
  else if SameText(FClassName, 'WideString') and
          not FIsVarParameter and not FIsOutParameter then
    Result := TDBXDataTypes.WideStringType
  else if SameText(FClassName, 'String') then
    Result := TDBXDataTypes.WideStringType
//  Not supported due to ObjAuto lack of support
//  else if SameText(FClassName, 'TBcd') then
//    Result := TDBXDataTypes.BcdType
//  else if SameText(FClassName, 'TSQLTimeStamp') then
//    Result := TDBXDataTypes.TimeStampType
//  else if SameText(FClassName, 'TSQLTimeStampOffset') then
//    Result := TDBXDataTypes.TimeStampOffsetType
  else if SameText(FClassName, 'TDateTime') then
    Result := TDBXDataTypes.DateTimeType
  else if SameText(FClassName, 'Currency') then
    Result := TDBXDataTypes.CurrencyType
  else if SameText(FClassName, 'TDBXTime') then
    Result := TDBXDataTypes.TimeType
  else if SameText(FClassName, 'TDBXDate') then
    Result := TDBXDataTypes.DateType
  else if SameText(FClassName, 'Double') then
    Result := TDBXDataTypes.DoubleType
  else if SameText(FClassName, 'Single') then
    Result := TDBXDataTypes.SingleType
  else if SameText(FClassName, 'Int64') then
    Result := TDBXDataTypes.Int64Type
  else if SameText(FClassName, 'Byte') then
    Result := TDBXDataTypes.UInt8Type
  else if SameText(FClassName, 'ShortInt') then
    Result := TDBXDataTypes.Int8Type
  else if SameText(FClassName, 'Word') then
    Result := TDBXDataTypes.UInt16Type
  else if SameText(FClassName, 'SmallInt') then
    Result := TDBXDataTypes.Int16Type
  else if SameText(FClassName, 'Boolean') then
    Result := TDBXDataTypes.BooleanType
  else if SameText(FClassName, 'TJSONValue') then
    Result := TDBXDataTypes.JsonValueType
  else if SameText(FClassName, 'TJSONObject') then
    Result := TDBXDataTypes.JsonValueType
  else if SameText(FClassName, 'TJSONArray') then
    Result := TDBXDataTypes.JsonValueType
  else if SameText(FClassName, 'TJSONString') then
    Result := TDBXDataTypes.JsonValueType
  else if SameText(FClassName, 'TJSONNumber') then
    Result := TDBXDataTypes.JsonValueType
  else if SameText(FClassName, 'TJSONTrue') then
    Result := TDBXDataTypes.JsonValueType
  else if SameText(FClassName, 'TJSONFalse') then
    Result := TDBXDataTypes.JsonValueType
  else if SameText(FClassName, 'TJSONNull') then
    Result := TDBXDataTypes.JsonValueType
  else if SameText(FClassName, 'TDBXCallback') then
    Result := TDBXDataTypes.CallbackType
  else if SameText(FClassName, SOleVariant) then
  begin
    Result := TDBXDataTypes.VariantType;
  end
  else
  begin
    if AllowUnknown then
      Result := TDBXDataTypes.UnknownType
    else
      raise Exception.CreateFmt(SUnknownTypeName, [FClassName]);
  end;
end;

function TDSClass.GetDBXSubDataType: Integer;
begin
  if Assigned(FOriginalTypeData) and FOriginalTypeData.ClassType.InheritsFrom(TDBXJSONStream) then
    Result := TDBXDataTypes.JSONStreamSubtype
  else if Assigned(FTypeData) and (not FTypeData.ClassType.InheritsFrom(TDBXValue)) and
       (not FTypeData.ClassType.InheritsFrom(TJSONValue)) and (not FTypeData.ClassType.InheritsFrom(TDBXConnection)) and
       (not FTypeData.ClassType.ClassNameIs(STDataSet)) and (not FTypeData.ClassType.ClassNameIs(STParams)) and
       (not FTypeData.ClassType.InheritsFrom(TDBXCallback)) then
    Result := TDBXDataTypes.UserSubType
  else
    Result := TDBXDataTypes.UnknownType;
end;

procedure TDSClass.GetDbxType(Parameter: TDBXParameter);
begin
  Parameter.DataType := GetDBXDataType(False, Parameter);
  Parameter.SubType  := GetDBXSubDataType;
end;

function TDSClass.CreateMethod(MethodName: string): TDSMethod;
var
  I: Integer;
  ClassInfo: TMethodInfoArray;
{$IFNDEF NEXTGEN}
  ShortMethodName: ShortString;
{$ENDIF}
begin
{$IFNDEF NEXTGEN}
  ShortMethodName := ShortString(MethodName);
{$ENDIF}
  Result := nil;
  ClassInfo := System.ObjAuto.GetMethods(FClassRef);
  for I := 0 to Length(ClassInfo) - 1 do
  begin
{$IFDEF NEXTGEN}
    if ClassInfo[I].NameFld.ToString = MethodName then
{$ELSE}
    if ClassInfo[I].Name = ShortMethodName then
{$ENDIF}
    begin
      Result := TDSMethod.Create(ClassInfo[I], Self);
      Exit;
    end;
  end;
end;

function TDSClass.GetMethods: TDSMethodArray;
  function IsMethodSupported(Method: TDSMethod): Boolean;
  var
    I: Integer;
    LDSClass: TDSClass;
  begin
    if Method = nil then
      Exit(False);
    if Method.IsConstructor or Method.IsDestructor then
      Exit(False);
    // Don't allow methods that return a value type (like TDBXInt32Value)
    if Method.FDSReturnType.ValueParameter then
      Exit(False);
    if not Method.FDSReturnType.IsVoidReturn and
       (Method.FDSReturnType.GetDBXDataType(True, nil) = TDBXDataTypes.UnknownType) then
      Exit(False);
    for I := 0 to Length(Method.ParameterTypes) - 1 do
    begin
      LDSClass := Method.ParameterTypes[I];
      if LDSClass.FInvalidTypeData then
        Exit(False);

      if LDSClass.GetDBXDataType(True, nil) = TDBXDataTypes.UnknownType then
        Exit(False);

      // Don't allow out or var parameters that are value types
      if LDSClass.ValueParameter and (LDSClass.FIsVarParameter or LDSClass.FIsOutParameter) then
        Exit(False);
    end;
    Result := True;
  end;

  procedure AddMethods(const ADSClass: TDSClass);
  var
    I, Offset, SupportedMethodCount: Integer;
    ClassInfo: TMethodInfoArray;
    ClassRef: TPersistentClass;
    Methods: TDSMethodArray;
  begin
    ClassRef := ADSClass.FClassRef;
    ClassInfo := System.ObjAuto.GetMethods(ClassRef);
    Offset := Length(Result);
    SupportedMethodCount := 0;
    SetLength(Methods, Length(ClassInfo));
    for I := Low(ClassInfo) to High(ClassInfo) do
    begin
      try
        Methods[I] := TDSMethod.Create(ClassInfo[I], ADSClass);
      except
        FreeAndNil(Methods[I]);
      end;
      if IsMethodSupported(Methods[I]) then
        Inc(SupportedMethodCount);
    end;
    SetLength(Result, Length(Result) + SupportedMethodCount);
    for I := Low(Methods) to High(Methods) do
    begin
      if IsMethodSupported(Methods[I]) then
      begin
        Result[Offset] := Methods[I];
        Inc(Offset);
      end
      else
        FreeAndNil(Methods[I]);
    end;
  end;
begin
  Result := nil;
  if Assigned(FAdapteeClass) then
    AddMethods(FAdapteeClass);
  AddMethods(Self);
end;

function TDSClass.GetTypeUnit: string;
begin
  if Assigned(FTypeData) then
    exit(FTypeData.UnitNameFld.ToString)
  else
    exit(EmptyStr);
end;

function TDSClass.IsArrayParameter: Boolean;
begin
  Result := FIsArrayParameter;
end;

function TDSClass.IsInOutParameter: Boolean;
begin
  Result := FValueParameter or FIsVarParameter;
end;

function TDSClass.IsOutParameter: Boolean;
begin
  Result := FIsOutParameter;
end;

function TDSClass.IsVoidReturn: Boolean;
begin
  Result := (FClassRef = nil) and (FClassName = '');
end;

{ TDSPackage }

constructor TDSPackage.Create;
begin
  inherited Create;
  FClassList := TStringList.Create;
end;

destructor TDSPackage.Destroy;
begin
  FClassList.Free;
  inherited;
end;

procedure TDSPackage.GetClassesProc(AClass: TPersistentClass);
begin
  FClassList.Add(AClass.ClassName);
end;

function TDSPackage.CreateDSClass(ClassName: string): TDSClass;
var
  ClassRef: TPersistentClass;
begin
  ClassRef := GetClass(ClassName);
  if Assigned(ClassRef) then
    Result := TDSClass.Create(ClassRef, false)
  else
    Result := nil;
end;

function TDSPackage.GetDSClasses(
  classNamePattern: string): TDBXStringArray;
var
  ClassFinder: TClassFinder;
  I, N: Integer;
begin
  FClassList.Clear;
  ClassFinder := TClassFinder.Create(TPersistent);
  try
    ClassFinder.GetClasses(GetClassesProc);
  finally
    ClassFinder.Free;
  end;
  SetLength(Result, FClassList.Count);
  N := 0;
  for I := 0 to FClassList.Count - 1 do
  begin
    if (classNamePattern = EmptyStr) or (classNamePattern.IndexOf(FClassList[I]) <> -1) then
    begin
      Result[N] := FClassList[I];
      Inc(N);
    end;
  end;
  SetLength(Result, N);
end;

function TDSPackage.GetDSPackages: TDBXStringArray;
begin
  SetLength(Result,  0);
end;

constructor TDSAdapterClass.Create(AdapteeInstance: TObject);
begin
  inherited Create;
  FAdapteeInstance := AdapteeInstance;
end;

end.
