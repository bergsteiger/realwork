{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSCustomConnectorProxyWriter;

interface

uses
  Data.DBXPlatform,
  Datasnap.DSCommonProxy,
  Datasnap.DSProxyWriter,
  System.SysUtils;

type
  TDSCustomConnectorProxyWriter = class abstract(TDSCustomProxyWriter)
  public
    constructor Create; virtual;
  protected
    Get: string;
    Post: string;
    Put: string;
    Delete: string;
    FPostPrefix: string;
    FPutPrefix: string;
    FDeletePrefix: string;
    FGenerateURLFunctions: Boolean;
    FSupportedTypes: TDBXInt32s;
    FNonURLTypes: TDBXInt32s;
    function GetMethodRequestType(const ProxyClass: TDSProxyClass;
      const Method: TDSProxyMethod): string; virtual;
    function Contains(const Arr: TDBXInt32s; const Value: Integer): Boolean;
    function ExtendedIncludeClass(const ProxyClass: TDSProxyClass): Boolean;
    function ExtendedIncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean;
    procedure ForEachInputParameter(const ProxyMethod: TDSProxyMethod;
      Callback: TProc<TDSProxyParameter>);
    procedure ForEachOutputParameter(const ProxyMethod: TDSProxyMethod;
      Callback: TProc<TDSProxyParameter>);
    procedure ForEachParameter(const ProxyMethod: TDSProxyMethod;
      Callback: TProc<TDSProxyParameter>);
    function GetFirstClass: TDSProxyClass;

    function IsOutputParameter(const Param: TDSProxyParameter): Boolean;
    function IsInputParameter(const Param: TDSProxyParameter): Boolean;
    function GetNonURLTypes: TDBXInt32s; virtual;
    function GetSupportedTypes: TDBXInt32s; virtual;
    function IsPrimitiveJSONType(ClassName: string): Boolean; virtual; final;
    function GetAssignmentString: string; override;
    function GetSetter(Param: TDSProxyParameter): string; virtual;
    function GetGetter(Param: TDSProxyParameter): string; virtual;
    function IsDBXValueTypeParameter(const Param: TDSProxyParameter): Boolean;
    function GetParameterDirection(Direction: Integer): string; virtual;
    function GetParameterDirectionPrefix: string; virtual;
    function GetOutputParametersCount(const ProxyMethod: TDSProxyMethod): Integer; virtual;
    function HasOnlyURLParams(const Method: TDSProxyMethod): Boolean;
    function IsProcedure(const ProxyMethod: TDSProxyMethod): Boolean;
    function GetReturnParam(const ProxyMethod: TDSProxyMethod): TDSProxyParameter;
    function GetMethodRequestName(const ProxyClass: TDSProxyClass;
      const Method: TDSProxyMethod): string; virtual;
    function GetParameterType(ParameterType: Integer): string; virtual;
    function GetParameterTypePrefix: string; virtual;

    property SupportedTypes: TDBXInt32s read GetSupportedTypes;
    property NonURLTypes: TDBXInt32s read GetNonURLTypes;
    property FirstClass: TDSProxyClass read GetFirstClass;
  end;

implementation

uses
  Data.DbxCommon, Datasnap.DSProxyUtils, System.StrUtils;

{ TDSCustomConnectorProxyWriter }

constructor TDSCustomConnectorProxyWriter.Create;
begin
  Get := 'GET';
  Post := 'POST';
  Put := 'PUT';
  Delete := 'DELETE';
  FPostPrefix := 'update';
  FPutPrefix := 'accept';
  FDeletePrefix := 'cancel';
  inherited Create;
  FIndentIncrement := 2;
  FIndentString := '';
end;

function TDSCustomConnectorProxyWriter.GetAssignmentString: string;
begin
  Result := '=';
end;

function TDSCustomConnectorProxyWriter.GetGetter(Param: TDSProxyParameter): string;
begin
  if IsDBXValueTypeParameter(Param) then
    Exit('GetAsDBXValue');
  case Param.DataType of
    TDBXDataTypes.UnknownType:
      raise EDSProxyException.Create('Cannot get getter for DataType UNKNOWN');
    TDBXDataTypes.AnsiStringType:
      begin
        Exit('GetAsAnsiString');
      end;
    TDBXDataTypes.DateType:
      begin
        Exit('GetAsTDBXDate');
      end;
    TDBXDataTypes.BlobType:
      Exit('GetAsBlob');
    TDBXDataTypes.BooleanType:
      begin
        Exit('GetAsBoolean');
      end;
    TDBXDataTypes.Int16Type:
      begin
        Exit('GetAsInt16');
      end;
    TDBXDataTypes.Int32Type:
      begin
        Exit('GetAsInt32');
      end;
    TDBXDataTypes.DoubleType:
      begin
        Exit('GetAsDouble');
      end;
    TDBXDataTypes.BcdType:
      Exit('GetAsBcd');
    TDBXDataTypes.BytesType:
      Exit('GetAsBytes');
    TDBXDataTypes.TimeType:
      Exit('GetAsTDBXTime');
    TDBXDataTypes.DatetimeType:
      Exit('GetAsDateTime');
    TDBXDataTypes.UInt16Type:
      begin
        Exit('GetAsUInt16');
      end;
    TDBXDataTypes.UInt32Type:
      begin
        Exit('GetAsUInt32');
      end;
    TDBXDataTypes.VarBytesType:
      Exit('<NOT SUPPORTED VARBYTES>');
    TDBXDataTypes.CursorType:
      Exit('<NOT SUPPORTED CURSOR>');
    TDBXDataTypes.Int64Type:
      begin
        Exit('GetAsInt64');
      end;
    TDBXDataTypes.UInt64Type:
      begin
        Exit('GetAsUInt64');
      end;
    TDBXDataTypes.AdtType:
      Exit('<NOT SUPPORTED ADT>');
    TDBXDataTypes.ArrayType:
      Exit('<NOT SUPPORTED ARRAY>');
    TDBXDataTypes.RefType:
      Exit('<NOT SUPPORTED REF>');
    TDBXDataTypes.TableType:
      Exit('GetAsTable');
    TDBXDataTypes.TimeStampType:
      Exit('GetAsTimeStamp');
    TDBXDataTypes.CurrencyType:
      Exit('GetAsCurrency');
    TDBXDataTypes.WideStringType:
      begin
        Exit('GetAsString');
      end;
    TDBXDataTypes.SingleType:
      begin
        Exit('GetAsSingle');
      end;
    TDBXDataTypes.Int8Type:
      begin
        Exit('GetAsInt8');
      end;
    TDBXDataTypes.UInt8Type:
      begin
        Exit('GetAsUInt8');
      end;
    TDBXDataTypes.ObjectType:
      Exit('GetAsObject');
    TDBXDataTypes.CharArrayType:
      Exit('<NOT SUPPORTED CHARARRAY>');
    TDBXDataTypes.IntervalType:
      Exit('<NOT SUPPORTED INTERVAL>');
    TDBXDataTypes.BinaryBlobType:
      Exit('GetAsStream');
    TDBXDataTypes.DBXConnectionType:
      Exit('<NOT SUPPORTED DBXConnection>');
    TDBXDataTypes.VariantType:
      Exit('GetAsVariant');
    TDBXDataTypes.TimeStampOffsetType:
      Exit('<NOT SUPPORTED TimeStampOffset>');
    TDBXDataTypes.JsonValueType:
      Exit('GetAsJSONValue');
    TDBXDataTypes.CallbackType:
      Exit('<NOT SUPPORTED Callback>');
    TDBXDataTypes.MaxBaseTypes:
      Exit('<NOT SUPPORTED MaxBase>');
  end;
  Exit('<NOT SUPPORTED ???>');

end;

function TDSCustomConnectorProxyWriter.GetMethodRequestType(const ProxyClass: TDSProxyClass;
  const Method: TDSProxyMethod): string;
var
  MName: string;
  Aux, Param: TDSProxyParameter;
  LastType: Integer;
  HadIn: Boolean;
begin
  MName := Method.ProxyMethodName;
  if MName.StartsWith(FPutPrefix) and (MName.Length > FPutPrefix.Length) then
    Exit(Put);
  if MName.StartsWith(FPostPrefix) and (MName.Length > FPostPrefix.Length) then
    Exit(Post);
  if MName.StartsWith(FDeletePrefix) and (MName.Length > FDeletePrefix.Length) then
    Exit(Delete);
  if (string.Compare(sDSAdminClassName, ProxyClass.ProxyClassName, True) = 0) and
    (Method.ParameterCount > 0) then
  begin
    HadIn := False;
    Param := Method.Parameters;
    Aux := Param;
    while Aux <> nil do
    begin
      if (Aux <> nil) and
        ((Aux.ParameterDirection = TDBXParameterDirections.InParameter) or
        (Aux.ParameterDirection = TDBXParameterDirections.InOutParameter)) then
      begin
        HadIn := True;
        Param := Aux;
      end;
      Aux := Aux.Next;
    end;
    LastType := Param.DataType;
    if HadIn and Contains(NonURLTypes, LastType) then
      Exit(Post);
  end;
  Result := Get;
end;

function TDSCustomConnectorProxyWriter.GetNonURLTypes: TDBXInt32s;
var
  I: Integer;
begin
  if FNonURLTypes = nil then
  begin
    SetLength(FNonURLTypes, 9);
    I := 0;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.JsonValueType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.ObjectType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.TableType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.BytesType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.VarBytesType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.ArrayType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.CharArrayType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.BlobType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.BinaryBlobType;
  end;
  Result := FNonURLTypes;
end;

function TDSCustomConnectorProxyWriter.GetSetter(Param: TDSProxyParameter): string;
begin
  if IsDBXValueTypeParameter(Param) then
    Exit('SetAsDBXValue');

  case Param.DataType of
    TDBXDataTypes.UnknownType:
      raise EDSProxyException.Create('Cannot get setter for DataType UNKNOWN');
    TDBXDataTypes.AnsiStringType:
      begin
        Exit('SetAsAnsiString');
      end;
    TDBXDataTypes.DateType:
      begin
        Exit('SetAsTDBXDate');
      end;
    TDBXDataTypes.BlobType:
      Exit('SetAsBlob');
    TDBXDataTypes.BooleanType:
      begin
        Exit('SetAsBoolean');
      end;
    TDBXDataTypes.Int16Type:
      begin
        Exit('SetAsInt16');
      end;
    TDBXDataTypes.Int32Type:
      begin
        Exit('SetAsInt32');
      end;
    TDBXDataTypes.DoubleType:
      begin
        Exit('SetAsDouble');
      end;
    TDBXDataTypes.BcdType:
      Exit('SetAsBcd');
    TDBXDataTypes.BytesType:
      Exit('SetAsBytes');
    TDBXDataTypes.TimeType:
      Exit('SetAsTDBXTime');
    TDBXDataTypes.DatetimeType:
      Exit('SetAsDateTime');
    TDBXDataTypes.UInt16Type:
      begin
        Exit('SetAsUInt16');
      end;
    TDBXDataTypes.UInt32Type:
      begin
        Exit('SetAsUInt32');
      end;
    TDBXDataTypes.Int64Type:
      begin
        Exit('SetAsInt64');
      end;
    TDBXDataTypes.UInt64Type:
      begin
        Exit('SetAsUInt64');
      end;
    TDBXDataTypes.TableType:
      Exit('SetAsTable');
    TDBXDataTypes.TimeStampType:
      Exit('SetAsTimeStamp');
    TDBXDataTypes.CurrencyType:
      Exit('SetAsCurrency');
    TDBXDataTypes.WideStringType:
      // Exit('SetAsString');
      begin
        Exit('SetAsString');
      end;

    TDBXDataTypes.SingleType:
      begin
        Exit('SetAsSingle');
      end;
    TDBXDataTypes.Int8Type:
      begin
        Exit('SetAsInt8');
      end;
    TDBXDataTypes.UInt8Type:
      begin
        Exit('SetAsUInt8');
      end;
    TDBXDataTypes.ObjectType:
      Exit('SetAsObject');
    TDBXDataTypes.BinaryBlobType:
      Exit('SetAsStream');
    TDBXDataTypes.JsonValueType:
      Exit('SetAsJSONValue');
    TDBXDataTypes.MaxBaseTypes:
      Exit('<NOT SUPPORTED MaxBase>');
    TDBXDataTypes.VariantType, TDBXDataTypes.DBXConnectionType,
      TDBXDataTypes.TimeStampOffsetType, TDBXDataTypes.CallbackType,
      TDBXDataTypes.IntervalType, TDBXDataTypes.CharArrayType,
      TDBXDataTypes.AdtType, TDBXDataTypes.ArrayType, TDBXDataTypes.RefType,
      TDBXDataTypes.VarBytesType, TDBXDataTypes.CursorType:
      Exit('<WARNING! Type ' + Param.TypeName + ' is not supported>');
  end;
end;

function TDSCustomConnectorProxyWriter.GetSupportedTypes: TDBXInt32s;
var
  I: Integer;
begin
  if FSupportedTypes = nil then
  begin
    SetLength(FSupportedTypes, 24);
    I := 0;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.AnsiStringType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.WideStringType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.BooleanType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.Int8Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.Int16Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.Int32Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.Int64Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.UInt8Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.UInt16Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.UInt32Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.UInt64Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.DoubleType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.SingleType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.CurrencyType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.BcdType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.DateType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.DatetimeType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.TimeType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.TimeStampType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.JsonValueType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.ArrayType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.ObjectType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.TableType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.BinaryBlobType;
  end;
  Result := FSupportedTypes;
end;

function TDSCustomConnectorProxyWriter.HasOnlyURLParams(const Method: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
  PtType: Integer;
begin
  Param := nil;
  if Method <> nil then
    Param := Method.Parameters;
  while Param <> nil do
  begin
    if (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) or
      (Param.ParameterDirection = TDBXParameterDirections.InParameter) then
    begin
      PtType := Param.DataType;
      if not Contains(SupportedTypes, PtType) or Contains(NonURLTypes, PtType)
      then
        Exit(False);
    end;
    Param := Param.Next;
  end;
  Result := True;
end;

function TDSCustomConnectorProxyWriter.IsProcedure(const ProxyMethod: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
begin
  Param := GetReturnParam(ProxyMethod);
  Result := (not Assigned(Param));
end;

function TDSCustomConnectorProxyWriter.IsDBXValueTypeParameter(const Param: TDSProxyParameter): Boolean;
begin
  Result := AnsiStartsStr('TDBX', Param.TypeName) and
    AnsiEndsStr('Value', Param.TypeName);
end;

function TDSCustomConnectorProxyWriter.IsInputParameter(const Param: TDSProxyParameter): Boolean;
begin
  Result := Param.ParameterDirection in [TDBXParameterDirections.InParameter,
    TDBXParameterDirections.InOutParameter];
end;

function TDSCustomConnectorProxyWriter.IsOutputParameter(const Param: TDSProxyParameter): Boolean;
begin
  Result := Param.ParameterDirection in [TDBXParameterDirections.OutParameter,
    TDBXParameterDirections.InOutParameter,
    TDBXParameterDirections.ReturnParameter];
end;

function TDSCustomConnectorProxyWriter.IsPrimitiveJSONType(ClassName: string): Boolean;
begin
  Result := (ClassName = 'TJSONTrue') or (ClassName = 'TJSONFalse') or
    (ClassName = 'TJSONNull') or (ClassName = 'TJSONString') or
    (ClassName = 'TJSONNumber');
end;

function TDSCustomConnectorProxyWriter.GetParameterDirection(Direction: Integer): string;
begin
  case Direction of
    TDBXParameterDirections.InParameter:
      Exit(GetParameterDirectionPrefix+'Input');
    TDBXParameterDirections.OutParameter:
      Exit(GetParameterDirectionPrefix+'Output');
    TDBXParameterDirections.InOutParameter:
      Exit(GetParameterDirectionPrefix+'InputOutput');
    TDBXParameterDirections.ReturnParameter:
      Exit(GetParameterDirectionPrefix+'ReturnValue');
  else
    raise Exception.Create('Param direction not allowed');
  end;
end;

function TDSCustomConnectorProxyWriter.GetParameterDirectionPrefix: string;
begin
  Result := 'DSRESTParamDirection.';
end;

function TDSCustomConnectorProxyWriter.GetParameterType(
  ParameterType: Integer): string;
begin
     case ParameterType of
    TDBXDataTypes.UnknownType:
      Exit(GetParameterTypePrefix+'UnknownType');
    TDBXDataTypes.AnsiStringType:
      Exit(GetParameterTypePrefix+'AnsiStringType');
    TDBXDataTypes.DateType:
      Exit(GetParameterTypePrefix+'DateType');
    TDBXDataTypes.BlobType:
      Exit(GetParameterTypePrefix+'BlobType');
    TDBXDataTypes.BooleanType:
      Exit(GetParameterTypePrefix+'BooleanType');
    TDBXDataTypes.Int16Type:
      Exit(GetParameterTypePrefix+'Int16Type');
    TDBXDataTypes.Int32Type:
      Exit(GetParameterTypePrefix+'Int32Type');
    TDBXDataTypes.DoubleType:
      Exit(GetParameterTypePrefix+'DoubleType');
    TDBXDataTypes.BcdType:
      Exit(GetParameterTypePrefix+'BcdType');
    TDBXDataTypes.BytesType:
      Exit(GetParameterTypePrefix+'BytesType');
    TDBXDataTypes.TimeType:
      Exit(GetParameterTypePrefix+'TimeType');
    TDBXDataTypes.DatetimeType:
      Exit(GetParameterTypePrefix+'DateTimeType');
    TDBXDataTypes.UInt16Type:
      Exit(GetParameterTypePrefix+'UInt16Type');
    TDBXDataTypes.UInt32Type:
      Exit(GetParameterTypePrefix+'UInt32Type');
    TDBXDataTypes.VarBytesType:
      Exit(GetParameterTypePrefix+'VarBytesType');
    TDBXDataTypes.CursorType:
      Exit(GetParameterTypePrefix+'CursorType');
    TDBXDataTypes.Int64Type:
      Exit(GetParameterTypePrefix+'Int64Type');
    TDBXDataTypes.UInt64Type:
      Exit(GetParameterTypePrefix+'UInt64Type');
    TDBXDataTypes.AdtType:
      Exit(GetParameterTypePrefix+'AdtType');
    TDBXDataTypes.ArrayType:
      Exit(GetParameterTypePrefix+'ArrayType');
    TDBXDataTypes.RefType:
      Exit(GetParameterTypePrefix+'RefType');
    TDBXDataTypes.TableType:
      Exit(GetParameterTypePrefix+'TableType');
    TDBXDataTypes.TimeStampType:
      Exit(GetParameterTypePrefix+'TimeStampType');
    TDBXDataTypes.CurrencyType:
      Exit(GetParameterTypePrefix+'CurrencyType');
    TDBXDataTypes.WideStringType:
      Exit(GetParameterTypePrefix+'WideStringType');
    TDBXDataTypes.SingleType:
      Exit(GetParameterTypePrefix+'SingleType');
    TDBXDataTypes.Int8Type:
      Exit(GetParameterTypePrefix+'Int8Type');
    TDBXDataTypes.UInt8Type:
      Exit(GetParameterTypePrefix+'UInt8Type');
    TDBXDataTypes.ObjectType:
      Exit(GetParameterTypePrefix+'ObjectType');
    TDBXDataTypes.CharArrayType:
      Exit(GetParameterTypePrefix+'CharArrayType');
    TDBXDataTypes.IntervalType:
      Exit(GetParameterTypePrefix+'IntervalType');
    TDBXDataTypes.BinaryBlobType:
      Exit(GetParameterTypePrefix+'BinaryBlobType');
    TDBXDataTypes.DBXConnectionType:
      Exit('NOT ALLOWED');
    TDBXDataTypes.VariantType:
      Exit(GetParameterTypePrefix+'VariantType');
    TDBXDataTypes.TimeStampOffsetType:
      Exit(GetParameterTypePrefix+'TimeStampOffsetType');
    TDBXDataTypes.JsonValueType:
      Exit(GetParameterTypePrefix+'JsonValueType');
    TDBXDataTypes.CallbackType:
      Exit('NOT ALLOWED');
    TDBXDataTypes.MaxBaseTypes:
      Exit('NOT ALLOWED');
  end;

end;

function TDSCustomConnectorProxyWriter.GetParameterTypePrefix: string;
begin
  Result := 'DBXDataTypes.';
end;

function TDSCustomConnectorProxyWriter.GetReturnParam(const ProxyMethod: TDSProxyMethod): TDSProxyParameter;
var
  R: TDSProxyParameter;
begin
  ForEachOutputParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin
      if Param.ParameterDirection = TDBXParameterDirections.ReturnParameter then
        R := Param;
    end);
  Result := R;
end;

function TDSCustomConnectorProxyWriter.GetOutputParametersCount(const ProxyMethod: TDSProxyMethod): Integer;
var
  Param: TDSProxyParameter;
begin
  Result := 0;
  Param := ProxyMethod.Parameters;
  while Param <> nil do
  begin
    if IsOutputParameter(Param) then
      inc(Result);
    Param := Param.Next;
  end;
end;

function TDSCustomConnectorProxyWriter.ExtendedIncludeClass(const ProxyClass: TDSProxyClass): Boolean;
var
  ProxyMethod: TDSProxyMethod;
begin
  if IncludeClass(ProxyClass) then
  begin

    if (string.Compare(sDSMetadataClassName, ProxyClass.ProxyClassName, True) = 0) or
       (string.Compare(sDSAdminClassName, ProxyClass.ProxyClassName, True) = 0) then
      Exit(False);
    ProxyMethod := ProxyClass.FirstMethod;
    while ProxyMethod <> nil do
    begin
      if ExtendedIncludeMethod(ProxyMethod) then
        Exit(True);
      ProxyMethod := ProxyMethod.Next;
    end;
  end;
  Result := False;
end;

function TDSCustomConnectorProxyWriter.Contains(const Arr: TDBXInt32s;
  const Value: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to Length(Arr) - 1 do
  begin
    if Arr[I] = Value then
      Exit(True);
  end;
  Result := False;
end;

function TDSCustomConnectorProxyWriter.ExtendedIncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
  PtType: Integer;
  PtName: string;
begin
  if IncludeMethod(ProxyMethod) then
  begin
    Param := ProxyMethod.Parameters;
    if Param <> nil then
      while Param <> nil do
      begin
        PtType := Param.DataType;
        if not Contains(SupportedTypes, PtType) then
          Exit(False)
        else if (Param.ParameterDirection = TDBXParameterDirections.
          ReturnParameter) and (PtType = TDBXDataTypes.WideStringType) then
        begin
          PtName := Param.TypeName;
          if not(PtName.ToLower = 'string') then
            Exit(False);
        end;
        Param := Param.Next;
      end;
    Exit(True);
  end;
  Result := False;
end;

procedure TDSCustomConnectorProxyWriter.ForEachParameter(const ProxyMethod: TDSProxyMethod;
  Callback: TProc<TDSProxyParameter>);
var
  Param: TDSProxyParameter;
begin
  Param := ProxyMethod.Parameters;
  while Param <> nil do
  begin
    Callback(Param);
    Param := Param.Next;
  end;
end;

procedure TDSCustomConnectorProxyWriter.ForEachOutputParameter(const ProxyMethod: TDSProxyMethod;
  Callback: TProc<TDSProxyParameter>);
var
  Param: TDSProxyParameter;
begin
  Param := ProxyMethod.Parameters;
  while Param <> nil do
  begin
    if IsOutputParameter(Param) then
      Callback(Param);
    Param := Param.Next;
  end;
end;

procedure TDSCustomConnectorProxyWriter.ForEachInputParameter(const ProxyMethod: TDSProxyMethod;
  Callback: TProc<TDSProxyParameter>);
var
  Param: TDSProxyParameter;
begin
  Param := ProxyMethod.Parameters;
  while Param <> nil do
  begin
    if IsInputParameter(Param) then
      Callback(Param);
    Param := Param.Next;
  end;
end;

function TDSCustomConnectorProxyWriter.GetFirstClass: TDSProxyClass;
begin
  Result := Metadata.Classes;
end;

function TDSCustomConnectorProxyWriter.GetMethodRequestName(const ProxyClass: TDSProxyClass;
  const Method: TDSProxyMethod): string;
var
  MName, MType: string;
  PrefixLength: Integer;
begin
  MType := GetMethodRequestType(ProxyClass, Method);
  MName := Method.ProxyMethodName;
  PrefixLength := 0;
  if not(string.Compare(sDSAdminClassName, ProxyClass.ProxyClassName, True) = 0) then
  begin
    if (Put = MType) then
      PrefixLength := FPutPrefix.Length
    else if (Post = MType) then
      PrefixLength := FPostPrefix.Length
    else if (Delete = MType) then
      PrefixLength := FDeletePrefix.Length;
    if (PrefixLength > 0) and (PrefixLength < MName.Length) then
      MName := MName.Substring(PrefixLength, MName.Length - PrefixLength);
  end;
  Result := MName;
end;

end.
