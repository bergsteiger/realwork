{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Datasnap.DSCommonProxy;

interface

uses
  Data.DBXCommonTable,
  Data.DBXCommon,
  System.Classes,
  System.SysUtils;

type
  TDSProxyClass = class;
  TDSProxyMetadata = class;
  TDSProxyMethod = class;
  TDSProxyParameter = class;
  IDSProxyMetaDataLoader = interface;
  IDSProxyWriter = interface;

  TDSMethodParametersEntity = class(TDBXTableEntity)
  public
    constructor Create(const Table: TDBXTable; const OwnTable: Boolean); overload;
    constructor Create(const OwnTable: Boolean); overload;
  protected
    function GetMethodAlias: string;
    procedure SetMethodAlias(const ClassName: string);
    function GetServerClassName: string;
    procedure SetServerClassName(const ClassName: string);
    function GetServerMethodName: string;
    procedure SetServerMethodName(const ClassName: string);
    function GetParameterName: string;
    procedure SetParameterName(const ParameterName: string);
    function GetParameterTypeName: string;
    procedure SetParameterTypeName(const DataTypeName: string);
    function GetParameterTypeUnit: string;
    procedure SetParameterTypeUnit(const DataTypeUnit: string);
    function GetParameterDirection: Integer;
    procedure SetParameterDirection(const ParameterDirection: Integer);
    function GetParameterDBXDataType: Integer;
    procedure SetParameterDBXDataType(const DbxDataType: Integer);
    function GetDBXParameterDirection: Integer;
    procedure SetDBXParameterDirection(const DbxParameterDirection: Integer);
  private
    class function CreateMethodTable: TDBXTable; static;
  public
    property MethodAlias: string read GetMethodAlias write SetMethodAlias;
    property ServerClassName: string read GetServerClassName write SetServerClassName;
    property ServerMethodName: string read GetServerMethodName write SetServerMethodName;
    property ParameterName: string read GetParameterName write SetParameterName;
    property ParameterTypeName: string read GetParameterTypeName write SetParameterTypeName;
    property ParameterTypeUnit: string read GetParameterTypeUnit write SetParameterTypeUnit;
    property ParameterDirection: Integer read GetParameterDirection write SetParameterDirection;
    property ParameterDBXDataType: Integer read GetParameterDBXDataType write SetParameterDBXDataType;
    property DBXParameterDirection: Integer read GetDBXParameterDirection write SetDBXParameterDirection;
  end;

  TDSProxyClass = class
  public
    destructor Destroy; override;
    procedure AddMethod(const ProxyMethod: TDSProxyMethod);
  private
    FProxyClassName: string;
    FFirstMethod: TDSProxyMethod;
    FLastMethod: TDSProxyMethod;
    FNext: TDSProxyClass;
  public
    property ProxyClassName: string read FProxyClassName write FProxyClassName;
    property FirstMethod: TDSProxyMethod read FFirstMethod write FFirstMethod;
    property LastMethod: TDSProxyMethod read FLastMethod write FLastMethod;
    property Next: TDSProxyClass read FNext write FNext;
  end;

  TDSProxyMetadata = class
  public
    destructor Destroy; override;
    procedure LoadMetadata(MethodParameters: TDSMethodParametersEntity);
  private
    procedure AddClass(const ProxyClass: TDSProxyClass);
  private
    FFirstClass: TDSProxyClass;
    FLastClass: TDSProxyClass;
    procedure Clear;
  public
    property Classes: TDSProxyClass read FFirstClass;
  end;

  IDSProxyMetaDataLoader = interface
    ['{768E0AB8-3FEB-4BBF-8AAB-9ACE5A8D2CBF}']
    procedure Load(AMetaData: TDSProxyMetadata);
  end;

  IDSProxyWriter = interface
    ['{0840A428-9BD6-4F76-BEF4-969013CDABCC}']
    function Name: string;
    procedure Write(const Line: string);
    procedure WriteLine;
  end;

  TDSProxyStreamWriter = class(TInterfacedObject, IDSProxyWriter)
  private
    FName: string;
    FStreamWriter: TStreamWriter;
    procedure Write(const Line: string);
    procedure WriteLine;
    function Name: string;
  public
    constructor Create(Name: string; Stream: TStream; Encoding: TEncoding);
    destructor Destroy; override;
  end;

  TDSProxyMetaDataLoader = class(TInterfacedObject, IDSProxyMetaDataLoader)
  private
    [Weak]FConnection: TDbxConnection;
    FConnectionString: string;
    FOpenConnection: TFunc<TDBXConnection>;
    FCloseConnection: TProc<TDBXConnection>;
    { IDSProxyMetaDataLoader }
    procedure Load(MetaData: TDSProxyMetadata);

    procedure LoadFromConnection(AConnection: TDBXConnection; AMetaData: TDSProxyMetadata);
  public
    constructor Create(AConnection: TDbxConnection); overload;
    constructor Create(const AConnectionString: string); overload;
    constructor Create(AOpenConnection: TFunc<TDBXConnection>;
      ACloseConnection: TProc<TDBXConnection>); overload;
  end;

  TDSProxyMethod = class
  public
    destructor Destroy; override;
    procedure AddParameter(const ProxyParameter: TDSProxyParameter);
    function HasReturnValue: Boolean;
    procedure InitParameters;
    function HasParametersWithUserType: Boolean;
  private
    FFirstParameter: TDSProxyParameter;
    FLastParameter: TDSProxyParameter;
    FProxyMethodName: string;
    FMethodAlias: string;
    FNext: TDSProxyMethod;
    FInputCount: Integer;
    FOutputCount: Integer;
    FReturnParameter: TDSProxyParameter;
    FParameterCount: Integer;
    FHasUserTypeParameter: Boolean;
  public
    property ProxyMethodName: string read FProxyMethodName write FProxyMethodName;
    property Next: TDSProxyMethod read FNext write FNext;
    property InputCount: Integer read FInputCount;
    property OutputCount: Integer read FOutputCount;
    property MethodAlias: string read FMethodAlias write FMethodAlias;
    property Parameters: TDSProxyParameter read FFirstParameter;
    property ParameterCount: Integer read FParameterCount;
    property ReturnParameter: TDSProxyParameter read FReturnParameter;
  end;

  TDSProxyParameter = class
  protected
    procedure SetTypeUnit(const TypeUnit: string); virtual;
    function GetTypeUnit: string; virtual;
    
    
    /// <returns>- true is the parameter is JSON type</returns>
    function IsKnownJSONTypeName: Boolean; virtual;
  private
    FNext: TDSProxyParameter;
    FParameterDirection: Integer;
    FDataType: Integer;
    FParameterName: string;
    FTypeName: string;
    FTypeUnit: string;
  public
    property TypeName: string read FTypeName write FTypeName;
    property Next: TDSProxyParameter read FNext write FNext;
    property ParameterDirection: Integer read FParameterDirection write FParameterDirection;
    property DataType: Integer read FDataType write FDataType;
    property ParameterName: string read FParameterName write FParameterName;
    property TypeUnit: string read GetTypeUnit write SetTypeUnit;
    
    
    /// <returns>- true is the parameter is JSON type</returns>
    property KnownJSONTypeName: Boolean read IsKnownJSONTypeName;
  end;

  TDSProxyException = class(Exception);

const
  sImplementation = 'implementation';
  sInterface = 'interface';
  sASMethodsPrefix = 'AS_*';
  sDSAdminClassName = 'DSAdmin';
  sDSMetadataClassName = 'DSMetadata';

implementation

uses
  Data.DBXTableFactory,
  Datasnap.DSNames,
  Data.DBXPlatform,
  Data.DBXClientResStrs
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

constructor TDSMethodParametersEntity.Create(const Table: TDBXTable; const OwnTable: Boolean);
begin
  inherited Create(Table, OwnTable);
end;

constructor TDSMethodParametersEntity.Create(const OwnTable: Boolean);
begin
  inherited Create(CreateMethodTable, OwnTable);
end;

class function TDSMethodParametersEntity.CreateMethodTable: TDBXTable;
var
  Table: TDBXTable;
  MethodAlias: TDBXValueType;
  ClassName: TDBXValueType;
  MethodName: TDBXValueType;
  ParameterName: TDBXValueType;
  DataTypeName: TDBXValueType;
  DataTypeUnit: TDBXValueType;
  ParameterDirection: TDBXValueType;
  DbxDataType: TDBXValueType;
  DbxParameterDirection: TDBXValueType;
  TypeList: TDBXValueTypeArray;
begin
  Table := TDBXTableFactory.CreateDBXTable;
  Table.DBXTableName := 'MethodParametersTable';
  MethodAlias := TDBXValueType.Create;
  MethodAlias.Name := TDSMethodParametersColumns.MethodAlias;
  MethodAlias.DisplayName := TDSMethodParametersColumns.MethodAlias;
  MethodAlias.DataType := TDBXDataTypes.WideStringType;
  MethodAlias.Size := 256;
  ClassName := TDBXValueType.Create;
  ClassName.Name := TDSMethodParametersColumns.ServerClassName;
  ClassName.DisplayName := TDSMethodParametersColumns.ServerClassName;
  ClassName.DataType := TDBXDataTypes.WideStringType;
  ClassName.Size := 256;
  MethodName := TDBXValueType.Create;
  MethodName.Name := TDSMethodParametersColumns.ServerMethodName;
  MethodName.DisplayName := TDSMethodParametersColumns.ServerMethodName;
  MethodName.DataType := TDBXDataTypes.WideStringType;
  MethodName.Size := 256;
  ParameterName := TDBXValueType.Create;
  ParameterName.Name := TDSMethodParametersColumns.ParameterName;
  ParameterName.DisplayName := TDSMethodParametersColumns.ParameterName;
  ParameterName.DataType := TDBXDataTypes.WideStringType;
  ParameterName.Size := 256;
  DataTypeName := TDBXValueType.Create;
  DataTypeName.Name := TDSMethodParametersColumns.ParameterTypeName;
  DataTypeName.DisplayName := TDSMethodParametersColumns.ParameterTypeName;
  DataTypeName.DataType := TDBXDataTypes.WideStringType;
  DataTypeName.Size := 256;
  DataTypeUnit := TDBXValueType.Create;
  DataTypeUnit.Name := TDSMethodParametersColumns.ParameterTypeUnit;
  DataTypeUnit.DisplayName := TDSMethodParametersColumns.ParameterTypeUnit;
  DataTypeUnit.DataType := TDBXDataTypes.WideStringType;
  DataTypeUnit.Size := 256;
  ParameterDirection := TDBXValueType.Create;
  ParameterDirection.Name := TDSMethodParametersColumns.ParameterDirection;
  ParameterDirection.DisplayName := TDSMethodParametersColumns.ParameterDirection;
  ParameterDirection.DataType := TDBXDataTypes.Int32Type;
  ParameterDirection.Size := 4;
  DbxDataType := TDBXValueType.Create;
  DbxDataType.Name := TDSMethodParametersColumns.DbxDataType;
  DbxDataType.DisplayName := TDSMethodParametersColumns.DbxDataType;
  DbxDataType.DataType := TDBXDataTypes.Int32Type;
  DbxDataType.Size := 4;
  DbxParameterDirection := TDBXValueType.Create;
  DbxParameterDirection.Name := TDSMethodParametersColumns.DbxParameterDirection;
  DbxParameterDirection.DisplayName := TDSMethodParametersColumns.DbxParameterDirection;
  DbxParameterDirection.DataType := TDBXDataTypes.Int32Type;
  DbxParameterDirection.Size := 4;
  SetLength(TypeList,9);
  TypeList[0] := MethodAlias;
  TypeList[1] := ClassName;
  TypeList[2] := MethodName;
  TypeList[3] := ParameterName;
  TypeList[4] := DataTypeName;
  TypeList[5] := DataTypeUnit;
  TypeList[6] := ParameterDirection;
  TypeList[7] := DbxDataType;
  TypeList[8] := DbxParameterDirection;
  Table.Columns := TypeList;
  Result := Table;
end;

function TDSMethodParametersEntity.GetMethodAlias: string;
begin
  Result := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.MethodAlias)].AsString;
end;

procedure TDSMethodParametersEntity.SetMethodAlias(const ClassName: string);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.MethodAlias)].AsString := ClassName;
end;

function TDSMethodParametersEntity.GetServerClassName: string;
begin
  Result := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ServerClassName)].AsString;
end;

procedure TDSMethodParametersEntity.SetServerClassName(const ClassName: string);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ServerClassName)].AsString := ClassName;
end;

function TDSMethodParametersEntity.GetServerMethodName: string;
begin
  Result := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ServerMethodName)].AsString;
end;

procedure TDSMethodParametersEntity.SetServerMethodName(const ClassName: string);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ServerMethodName)].AsString := ClassName;
end;

function TDSMethodParametersEntity.GetParameterName: string;
begin
  Result := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ParameterName)].AsString;
end;

procedure TDSMethodParametersEntity.SetParameterName(const ParameterName: string);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ParameterName)].AsString := ParameterName;
end;

function TDSMethodParametersEntity.GetParameterTypeName: string;
begin
  Result := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ParameterTypeName)].AsString;
end;

procedure TDSMethodParametersEntity.SetParameterTypeName(const DataTypeName: string);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ParameterTypeName)].AsString := DataTypeName;
end;

function TDSMethodParametersEntity.GetParameterTypeUnit: string;
begin
  try
    Result := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ParameterTypeUnit)].AsString;
  except
    // Ordinal does not exist in Delphi 2010
    Result := '';
  end;
end;

procedure TDSMethodParametersEntity.SetParameterTypeUnit(const DataTypeUnit: string);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ParameterTypeUnit)].AsString := DataTypeUnit;
end;

function TDSMethodParametersEntity.GetParameterDirection: Integer;
begin
  Result := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ParameterDirection)].AsInt32;
end;

procedure TDSMethodParametersEntity.SetParameterDirection(const ParameterDirection: Integer);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.ParameterDirection)].AsInt32 := ParameterDirection;
end;

function TDSMethodParametersEntity.GetParameterDBXDataType: Integer;
var
  Value: TDBXValue;
begin
  Value := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.DbxDataType)];
  if Value.IsNull then
    Result := TDBXDataTypes.UnknownType
  else 
    Result := Value.AsInt32;
end;

procedure TDSMethodParametersEntity.SetParameterDBXDataType(const DbxDataType: Integer);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.DbxDataType)].AsInt32 := DbxDataType;
end;

function TDSMethodParametersEntity.GetDBXParameterDirection: Integer;
begin
  Result := Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.DbxParameterDirection)].AsInt32;
end;

procedure TDSMethodParametersEntity.SetDBXParameterDirection(const DbxParameterDirection: Integer);
begin
  Table.Value[Table.GetOrdinal(TDSMethodParametersColumns.DbxParameterDirection)].AsInt32 := DbxParameterDirection;
end;

destructor TDSProxyClass.Destroy;
var
  ProxyMethod: TDSProxyMethod;
  NextProxyMethod: TDSProxyMethod;
begin
  ProxyMethod := FirstMethod;
  while ProxyMethod <> nil do
  begin
    NextProxyMethod := ProxyMethod.Next;
    FreeAndNil(ProxyMethod);
    ProxyMethod := NextProxyMethod;
  end;
  inherited Destroy;
end;

procedure TDSProxyClass.AddMethod(const ProxyMethod: TDSProxyMethod);
begin
  if FirstMethod = nil then
  begin
    FirstMethod := ProxyMethod;
    LastMethod := ProxyMethod;
  end
  else 
  begin
    LastMethod.Next := ProxyMethod;
    LastMethod := ProxyMethod;
  end;
end;

procedure TDSProxyMetadata.AddClass(const ProxyClass: TDSProxyClass);
begin
  if FFirstClass = nil then
  begin
    FFirstClass := ProxyClass;
    FLastClass := ProxyClass;
  end
  else 
  begin
    FLastClass.Next := ProxyClass;
    FLastClass := ProxyClass;
  end;
end;

destructor TDSProxyMetadata.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TDSProxyMetaData.Clear;
var
  ProxyClass: TDSProxyClass;
  NextProxyClass: TDSProxyClass;
begin
  ProxyClass := FFirstClass;
  while ProxyClass <> nil do
  begin
    NextProxyClass := ProxyClass.Next;
    FreeAndNil(ProxyClass);
    ProxyClass := NextProxyClass;
  end;
  FFirstClass := nil;
  FLastClass := nil;
end;

procedure TDSProxyMetadata.LoadMetadata(MethodParameters: TDSMethodParametersEntity);
var
  ProxyClass: TDSProxyClass;
  ProxyMethod: TDSProxyMethod;
  ProxyParam: TDSProxyParameter;
  ParamDirection: Integer;
begin
  Clear;
  while MethodParameters.Table.InBounds do
  begin
    ProxyClass := TDSProxyClass.Create;
    AddClass(ProxyClass);
    ProxyClass.ProxyClassName := MethodParameters.ServerClassName;
    while MethodParameters.Table.InBounds and (ProxyClass.ProxyClassName = MethodParameters.ServerClassName) do
    begin
      ProxyMethod := TDSProxyMethod.Create;
      ProxyClass.AddMethod(ProxyMethod);
      ProxyMethod.MethodAlias := MethodParameters.MethodAlias;
      ProxyMethod.ProxyMethodName := MethodParameters.ServerMethodName;
      while MethodParameters.Table.InBounds and (ProxyClass.ProxyClassName = MethodParameters.ServerClassName) and (ProxyMethod.ProxyMethodName = MethodParameters.ServerMethodName) do
      begin
        ParamDirection := MethodParameters.DBXParameterDirection;
        if MethodParameters.ParameterDBXDataType <> TDBXDataTypes.UnknownType then
        begin
          ProxyParam := TDSProxyParameter.Create;
          ProxyMethod.AddParameter(ProxyParam);
          ProxyParam.DataType := MethodParameters.ParameterDBXDataType;
          ProxyParam.ParameterDirection := ParamDirection;
          ProxyParam.ParameterName := MethodParameters.ParameterName;
          ProxyParam.TypeName := MethodParameters.ParameterTypeName;
          ProxyParam.TypeUnit := MethodParameters.ParameterTypeUnit;
        end;
        MethodParameters.Table.Next;
      end;
      ProxyMethod.InitParameters;
    end;
    if ProxyClass.FirstMethod = nil then
      MethodParameters.Table.Next;
  end;
end;

destructor TDSProxyMethod.Destroy;
var
  ProxyParameter: TDSProxyParameter;
  NextProxyParameter: TDSProxyParameter;
begin
  ProxyParameter := FFirstParameter;
  while ProxyParameter <> nil do
  begin
    NextProxyParameter := ProxyParameter.Next;
    FreeAndNil(ProxyParameter);
    ProxyParameter := NextProxyParameter;
  end;
  inherited Destroy;
end;

procedure TDSProxyMethod.AddParameter(const ProxyParameter: TDSProxyParameter);
begin
  if FFirstParameter = nil then
  begin
    FFirstParameter := ProxyParameter;
    FLastParameter := ProxyParameter;
  end
  else 
  begin
    FLastParameter.Next := ProxyParameter;
    FLastParameter := ProxyParameter;
  end;
end;

function TDSProxyMethod.HasReturnValue: Boolean;
begin
  Result := FReturnParameter <> nil;
end;

procedure TDSProxyMethod.InitParameters;
var
  Param: TDSProxyParameter;
begin
  FReturnParameter := nil;
  FInputCount := 0;
  FOutputCount := 0;
  FParameterCount := 0;
  FHasUserTypeParameter := False;
  Param := FFirstParameter;
  while Param <> nil do
  begin
    FParameterCount := FParameterCount + 1;
    case Param.ParameterDirection of
      TDBXParameterDirections.InParameter:
        FInputCount := FInputCount + 1;
      TDBXParameterDirections.InOutParameter:
        begin
          FInputCount := FInputCount + 1;
          FOutputCount := FOutputCount + 1;
        end;
      TDBXParameterDirections.OutParameter:
        FOutputCount := FOutputCount + 1;
      TDBXParameterDirections.ReturnParameter:
        FReturnParameter := Param;
    end;
    if not FHasUserTypeParameter and (Param.DataType = TDBXDataTypes.JsonValueType) and not Param.KnownJSONTypeName then
      FHasUserTypeParameter := True;
    Param := Param.Next;
  end;
end;

function TDSProxyMethod.HasParametersWithUserType: Boolean;
begin
  Result := FHasUserTypeParameter;
end;

procedure TDSProxyParameter.SetTypeUnit(const TypeUnit: string);
begin
  self.FTypeUnit := TypeUnit;
end;

function TDSProxyParameter.GetTypeUnit: string;
begin
  Result := FTypeUnit;
end;

function TDSProxyParameter.IsKnownJSONTypeName: Boolean;
begin
  if not FTypeName.IsEmpty then
  begin
    if string.Compare(FTypeName.Substring(0, 5), 'TJSON') = 0 then
      Exit(True);
  end;
  Result := False;
end;

{ TDSProxyStreamWriter }
constructor TDSProxyStreamWriter.Create(Name: string; Stream: TStream; Encoding: TEncoding);
begin
  FName := Name;
  FStreamWriter := TStreamWriter.Create(Stream, Encoding);
end;

destructor TDSProxyStreamWriter.Destroy;
begin
  FStreamWriter.Free;
  inherited;
end;

function TDSProxyStreamWriter.Name: string;
begin
  Result := FName;
end;

procedure TDSProxyStreamWriter.Write(const Line: string);
begin
  FStreamWriter.Write(Line);
end;

procedure TDSProxyStreamWriter.WriteLine;
begin
  FStreamWriter.WriteLine;
end;

{ TDSProxyMetaDataLoader }

constructor TDSProxyMetaDataLoader.Create(AConnection: TDbxConnection);
begin
  FConnection := AConnection;
end;

constructor TDSProxyMetaDataLoader.Create(AOpenConnection: TFunc<TDBXConnection>;
  ACloseConnection: TProc<TDBXConnection>);
begin
  FOpenConnection := AOpenConnection;
  FCloseConnection := ACloseConnection;
end;

constructor TDSProxyMetaDataLoader.Create(const AConnectionString: string);
begin
  FConnectionString := AConnectionString;
end;

procedure TDSProxyMetaDataLoader.Load(MetaData: TDSProxyMetadata);
var
  LConnection: TDBXConnection;
  LOwnsConnection: Boolean;
  LProperties:       TDBXProperties;
begin
  LConnection := nil;
  LOwnsConnection := False;
  try
    if Trim(FConnectionString) <> '' then
    begin
      LProperties := TDBXProperties.Create;
      try
        LProperties.SetProperties(FConnectionString);
        TDBXConnectionFactory.Lock;
        try
          LConnection := TDBXConnectionFactory.GetConnectionFactory.GetConnection(LProperties);
        finally
          TDBXConnectionFactory.Unlock;
        end;
        LOwnsConnection := True;
        LoadFromConnection(LConnection, MetaData)
      finally
        LProperties.Free;
      end;
    end
    else
    begin
      LConnection := FConnection;
      if LConnection <> nil then
        LoadFromConnection(LConnection, MetaData)
      else if Assigned(FOpenConnection) then
      begin
        LConnection := FOpenConnection;
        if LConnection <> nil then
        begin
          LoadFromConnection(LConnection, MetaData);
          if Assigned(FCloseConnection) then
            FCloseConnection(LConnection);
          Exit;
        end;
      end;
    end;
    if LConnection = nil then
      raise TDSProxyException.Create(SNoConnection);
  finally
    if LOwnsConnection then
      LConnection.Free;
  end;
end;

procedure TDSProxyMetaDataLoader.LoadFromConnection(AConnection: TDBXConnection; AMetaData: TDSProxyMetadata);
var
  Command:            TDBXCommand;
  Reader:             TDBXReader;
  MethodParameters:   TDSMethodParametersEntity;
  DBXTable:           TDBXTable;
begin
  Command := nil;
  Reader := nil;
  DBXTable := nil;
  MethodParameters := nil;
  try
    Command := AConnection.CreateCommand;
    Command.CommandType := TDBXCommandTypes.DSServerMethod;
    Command.Text := Datasnap.DSNames.TDSAdminMethods.GetServerMethodParameters;
    Reader := Command.ExecuteQuery;
    DBXTable := TDBXReaderTable.Create(Reader);
    MethodParameters := TDSMethodParametersEntity.Create(DBXTable, True);
    DBXTable := nil;
    AMetaData.LoadMetadata(MethodParameters);
  finally
    DBXTable.Free;
    // Reader must be freed before command is closed, because closing a command may clear
    // references to result tables created by executing the command. Raid 276563.
    Reader.Free;
    Command.Free;
    MethodParameters.Free;
  end;
end;


end.
