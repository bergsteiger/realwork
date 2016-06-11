{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXDelegate;

interface

uses
  Data.DBXCommon,
  Data.DBXPlatform,
  System.Classes,
  Data.FmtBcd,
  Data.SqlTimSt,
  System.SysUtils
;

type

  TDBXDelegateConnection = class(TDBXConnection)
  strict protected
    FConnection: TDBXConnection;
  protected
    function CreateAndBeginTransaction(const Isolation: TDBXIsolation): TDBXTransaction; override;
    procedure Commit(const Transaction: TDBXTransaction); override;
    procedure Rollback(const Transaction: TDBXTransaction); override;
    function GetDatabaseMetaData: TDBXDatabaseMetaData; override;
    function GetConnectionProperties: TDBXProperties; override;
    procedure SetConnectionProperties(const Value: TDBXProperties); override;
    function GetTraceInfoEvent: TDBXTraceEvent; override;
    procedure SetTraceInfoEvent(const TraceInfoEvent: TDBXTraceEvent); override;
    function GetTraceFlags: TDBXTraceFlag; override;
    procedure SetTraceFlags(const TraceFlags: TDBXTraceFlag); override;
    function GetErrorEvent: TDBXErrorEvent; override;
    procedure SetErrorEvent(const ErrorEvent: TDBXErrorEvent); override;
    function GetDBXFormatter: TDBXFormatter; override;
    procedure SetDBXFormatter(const DBXFormatter: TDBXFormatter); override;
    function GetIsOpen: Boolean; override;
    procedure Open; override;
    function DerivedCreateCommand: TDBXCommand; overload; override;
    procedure DerivedOpen; override;
    procedure DerivedGetCommandTypes(const List: TStrings); override;
    procedure DerivedGetCommands(const CommandType: string;
      const List: TStrings); override;
    procedure DerivedClose; override;
    function CreateMorphCommand(MorphicCommand: TDBXCommand): TDBXCommand; override;
    function GetProductVersion: string; override;
    function GetProductName: string; override;
    function GetConnectionProperty(const Name: string): string; override;
  public
    constructor Create(ConnectionBuilder: TDBXConnectionBuilder;
      Connection: TDBXConnection);
    destructor Destroy; override;
    procedure Close; override;
    function BeginTransaction(Isolation: TDBXIsolation): TDBXTransaction; overload; override;
    function BeginTransaction: TDBXTransaction; overload; override;
    procedure CommitFreeAndNil(var Transaction: TDBXTransaction); override;
    procedure RollbackFreeAndNil(var Transaction: TDBXTransaction); override;
    procedure RollbackIncompleteFreeAndNil(var Transaction: TDBXTransaction); override;
    function CreateCommand: TDBXCommand; override;
    function GetVendorProperty(const Name: string): string; override;
  end;


  TDBXDelegateCommand = class(TDBXCommand)
  strict protected
    FCommand: TDBXCommand;
  protected
    procedure SetCommandType(const Value: string); override;
    function GetCommandType: string; override;
    function GetText: string; override;
    procedure SetText(const Value: string); override;
    procedure SetRowSetSize(const Value: Int64); override;
    procedure SetMaxBlobSize(const MaxBlobSize: Int64); override;
    function GetRowsAffected: Int64; override;
    procedure SetCommandTimeout(const Timeout: Integer); override;
    function GetCommandTimeout: Integer; override;
    function GetErrorEvent: TDBXErrorEvent; override;
    function CreateParameterRow: TDBXRow; override;
    procedure CreateParameters(Command: TDBXCommand); override;
    function GetParameters: TDBXParameterList; override;
    procedure Open; override;
    function DerivedGetNextReader: TDBXReader; override;
    procedure DerivedOpen; override;
    procedure DerivedClose; override;
    procedure DerivedPrepare; override;
    function DerivedExecuteQuery: TDBXReader; override;
    procedure DerivedExecuteUpdate; override;
    procedure DerivedClearParameters; override;
  public
    constructor Create(DBXContext: TDBXContext; Command: TDBXCommand);
    destructor Destroy; override;

    procedure Prepare; override;
    function ExecuteQuery: TDBXReader; override;
    procedure ExecuteUpdate; override;
    function GetNextReader: TDBXReader; override;
    function CreateParameter: TDBXParameter; override;
  end;


  TDBXDelegateParameterList = class(TDBXParameterList)
  strict protected
    FParameterList: TDBXParameterList;
  protected
    function GetParameterByOrdinal(const Ordinal: TInt32): TDBXParameter; override;
    function GetCount: TInt32; override;

    constructor Create(DBXContext: TDBXContext; Command: TDBXCommand;
      Parameters: TDBXParameterList);
  public
    destructor Destroy; override;
    procedure SetCount(const Count: TInt32); override;
    procedure AddParameter(Parameter: TDBXParameter); override;
    procedure SetParameter(const Ordinal: Integer;
      const Parameter: TDBXParameter); override;
    procedure InsertParameter(Ordinal: Integer; Parameter: TDBXParameter); override;
    procedure RemoveParameter(Ordinal: Integer); overload; override;
    procedure RemoveParameter(Parameter: TDBXParameter); overload; override;
    procedure ClearParameters; overload; override;
    procedure RemoveParameters; override;
    function GetOrdinal(const Name: string): Integer; override;
  end;

  TDBXDelegateParameter = class(TDBXParameter)
  strict protected
    FParameter: TDBXParameter;
  protected
    function GetValue: TDBXWritableValue; override;

    procedure SetParameter; override;
    procedure SetDbxRow(const DbxRow: TDBXRow); override;

    procedure SetParameterDirection(const ParameterDirection: TDBXParameterDirection); override;
    procedure SetName(const Name: string); override;
    procedure SetDisplayName(const Caption: string); override;

    procedure SetOrdinal(const Ordinal: TInt32); override;
    procedure SetDataType(const DataType: TDBXType); override;
    procedure SetSubType(const SubType: TDBXType); override;
    procedure SetPrecision(const Precision: Int64); override;
    procedure SetScale(const Scale: TInt32); override;
    procedure SetChildPosition(const ChildPosition: TInt32); override;
    procedure SetFlags(const Flags: TInt32); override;
    procedure SetNullable(const NullableValue: Boolean); override;
    procedure SetSize(const Size: Int64); override;
    procedure SetHidden(const Hidden: LongBool); override;
    procedure SetValueParameter(const ValueParameter: Boolean); override;
    procedure SetLiteral(const Literal: Boolean); override;

    function GetParameterDirection: TDBXParameterDirection; override;
    function GetName: string; override;
    function GetDisplayName: string; override;
    function GetOrdinal: TInt32; override;
    function GetDataType: TDBXType; override;
    function GetSubType: TDBXType; override;
    function GetPrecision: Int64; override;
    function GetScale: TInt32; override;
    function GetChildPosition: TInt32; override;
    function GetFlags: TInt32; override;
    function GetSize: Int64; override;
    function GetHidden: LongBool; override;
    function GetValueParameter: Boolean; override;
    function GetLiteral: Boolean; override;
  public
    constructor Create(DBXContext: TDBXContext; Parameter: TDBXParameter);
    destructor Destroy; override;
    procedure Assign(Source: TDBXParameter); override;
    function Clone: TObject; override;
  end;

  TDBXDelegateWritableValue = class(TDBXWritableValue)
  strict protected
    [Weak]FValue: TDBXValue;
    [Weak]FWritableValue: TDBXWritableValue;
  protected
    // constructor Create(ValueType: TDBXValueType; Value: TDBXValue); overload;
    constructor Create(ValueType: TDBXValueType; Value: TDBXWritableValue); overload;
    function GetNonDelegate: TDBXValue; override;
    function GetAsBoolean: Boolean; override;
    function GetAsUInt8: Byte; override;
    function GetAsInt8: ShortInt; override;
    function GetAsUInt16: Word; override;
    function GetAsInt16: SmallInt; override;
    function GetAsInt32: TInt32; override;
    function GetAsInt64: Int64; override;
    function GetAsString: string; override;
    function GetAsSingle: Single; override;
    function GetAsDouble: Double; override;
    function GetAsBcd: TBcd; override;
    function GetAsDate: TDBXDate; override;
    function GetAsTime: TDBXTime; override;
    function GetAsTimeStamp: TSQLTimeStamp; override;
    procedure SetPendingValue; override;
    procedure SetAsBoolean(const Value: Boolean); override;
    procedure SetAsUInt8(const Value: Byte); override;
    procedure SetAsInt8(const Value: ShortInt); override;
    procedure SetAsUInt16(const Value: Word); override;
    procedure SetAsInt16(const Value: SmallInt); override;
    procedure SetAsInt32(const Value: TInt32); override;
    procedure SetAsInt64(const Value: Int64); override;
    procedure SetAsString(const Value: string); override;
    procedure SetAsSingle(const Value: Single); override;
    procedure SetAsDouble(const Value: Double); override;
    procedure SetAsBcd(const Value: TBcd); override;
    procedure SetAsDate(const Value: TDBXDate); override;
    procedure SetAsTime(const Value: TDBXTime); override;
    procedure SetAsTimeStamp(const Value: TSQLTimeStamp); override;
  public
    function IsNull: Boolean; override;
    function GetValueSize: Int64; override;
{$IFNDEF NEXTGEN}
    function GetAnsiString: AnsiString; override;
{$ENDIF !NEXTGEN}
    function GetDate: TDBXDate; override;
    function GetBoolean: Boolean; overload; override;
    function GetTime: TDBXTime; override;
    function GetWideString: string; overload; override;
    function GetString: string; overload; override;
    function GetUInt8: Byte; overload; override;
    function GetInt8: ShortInt; overload; override;
    function GetUInt16: Word; overload; override;
    function GetInt16: SmallInt; overload; override;
    function GetInt32: TInt32; overload; override;
    function GetInt64: Int64; overload; override;
    function GetSingle: Single; override;
    function GetDouble: Double; override;
    function GetBytes(Offset: Int64; const Buffer: TArray<Byte>;
      BufferOffset, Length: Int64): Int64; override;
    function GetTimeStamp: TSQLTimeStamp; override;
    function GetTimeStampOffset: TSQLTimeStampOffset; override;
    function GetBcd: TBcd; override;
    function GetDBXReader(AInstanceOwner: Boolean): TDBXReader; override;
    function GetDBXConnection: TDBXConnection; override;
    function GetStream(AInstanceOwner: Boolean): TStream; override;
    function GetWideString(defaultValue: string): string; overload; override;
    function GetBoolean(defaultValue: Boolean): Boolean; overload; override;
    function GetUInt8(defaultValue: Byte): Byte; overload; override;
    function GetInt8(defaultValue: ShortInt): ShortInt; overload; override;
    function GetUInt16(defaultValue: Word): Word; overload; override;
    function GetInt16(defaultValue: SmallInt): SmallInt; overload; override;
    function GetInt32(defaultValue: TInt32): TInt32; overload; override;
    function GetInt64(defaultValue: Int64): Int64; overload; override;
    function EqualsValue(Other: TDBXValue): Boolean; override;
    procedure SetNull; override;
    procedure SetTimeStamp(const Value: TSQLTimeStamp); override;
    procedure SetTimeStampOffset(const Value: TSQLTimeStampOffset); override;
    procedure SetBcd(const Value: TBcd); override;
{$IFNDEF NEXTGEN}
    procedure SetAnsiString(const Value: AnsiString); override;
{$ENDIF !NEXTGEN}
    procedure SetBoolean(const Value: Boolean); override;
    procedure SetDate(const Value: TDBXDate); override;
    procedure SetTime(const Value: TDBXTime); override;
    procedure SetWideString(const Value: string); override;
    procedure SetString(const Value: string); override;
    procedure SetUInt8(const Value: Byte); override;
    procedure SetInt8(const Value: ShortInt); override;
    procedure SetUInt16(const Value: Word); override;
    procedure SetInt16(const Value: SmallInt); override;
    procedure SetInt32(const Value: TInt32); override;
    procedure SetInt64(const Value: Int64); override;
    procedure SetSingle(const Value: Single); override;
    procedure SetDouble(const Value: Double); override;
    procedure SetStaticBytes(Offset: Int64; const Buffer: array of Byte;
      BufferOffset: Int64; Length: Int64); override;
    procedure SetDynamicBytes(Offset: Int64; const Buffer: TArray<Byte>;
      BufferOffset: Int64; Length: Int64); override;
    procedure SetDBXReader(const Value: TDBXReader;
      const AInstanceOwner: Boolean); overload; override;
    procedure SetStream(const Stream: TStream; const AInstanceOwner: Boolean); override;
    procedure SetDBXConnection(const Value: TDBXConnection); override;
    procedure SetValue(const Value: TDBXValue); override;
    // procedure SetBytes( const Buffer: TArray<Byte>;
    // BufferOffset: Int64;
    // Length:       Int64); override;
    // procedure SetStream(const Stream: TStream); override;

    destructor Destroy; override;
  end;


  TDBXDelegateReader = class(TDBXReader)
  private
    FReader: TDBXReader;
  protected
    function DerivedNext: Boolean; override;
    procedure DerivedClose; override;
    function GetByteReader: TDBXByteReader; override;
    function GetReaderHandle: Integer; override;
    function IsUpdateable: Boolean; override;
    function GetRowHandle: Integer; override;
    function GetValue(const Ordinal: TInt32): TDBXValue; override;
    function GetValueByName(const Name: string): TDBXValue; override;
    function GetValueType(const Ordinal: TInt32): TDBXValueType; override;
    function GetColumnCount: TInt32; override;
  public
    constructor Create(DBXContext: TDBXContext; Reader: TDBXReader);
    destructor Destroy; override;
    function Next: Boolean; override;
    function Reset: Boolean; override;
    function GetObjectTypeName(Ordinal: TInt32): string; override;
    function GetOrdinal(const Name: string): TInt32; override;
  end;


{
  TDBXDelegateByteReader = class
    private
      FByteReader:  TDBXByteReader;
      FReader:        TDBXReader;

    public
      procedure GetString(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetWideString(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetInt16(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetInt32(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetInt64(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetDouble(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetBcd(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetTimeStamp(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetTime(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetDate(Ordinal: TInt32; Value: TPointer; var IsNull: LongBool); override;
      procedure GetBytes(Ordinal: TInt32; Value: TArray<Byte>; var IsNull: LongBool); override;
      procedure GetBlobLength(Ordinal: TInt32; var Length: Int64; var IsNull: LongBool); override;
      procedure GetBlob(Ordinal: TInt32; Offset: Int64; Value: TArray<Byte>;
                                 ValueOffset, Length: Int64; var IsNull: LongBool); override;
  end;
}
implementation

type

  TDBXAccessorConnection = class(TDBXConnection)
  end;


  TDBXAccessorCommand = class(TDBXCommand)
  end;

  TDBXAccessorParameterList = class(TDBXParameterList)
  end;

  TDBXAccessorMetaData = class(TDBXDatabaseMetaData)
  end;

  TDBXAccessorParameter = class(TDBXParameter)
  end;

  TDBXAccessorWritableValue = class(TDBXWritableValue)
  end;

  TDBXAccessorReader = class(TDBXReader)
  end;

{ TDBXDelegateConnection }


function TDBXDelegateConnection.BeginTransaction(
  Isolation: TDBXIsolation): TDBXTransaction;
begin
  Result := FConnection.BeginTransaction(Isolation);
end;

function TDBXDelegateConnection.BeginTransaction: TDBXTransaction;
begin
  Result := FConnection.BeginTransaction;
end;

procedure TDBXDelegateConnection.Close;
begin
  FConnection.Close;
end;

procedure TDBXDelegateConnection.Commit(const Transaction: TDBXTransaction);
begin
  TDBXAccessorConnection(FConnection).Commit(Transaction);
end;

procedure TDBXDelegateConnection.CommitFreeAndNil(
  var Transaction: TDBXTransaction);
begin
  FConnection.CommitFreeAndNil(Transaction);
end;

constructor TDBXDelegateConnection.Create(ConnectionBuilder: TDBXConnectionBuilder; Connection: TDBXConnection);
begin
  inherited Create(ConnectionBuilder);
  FConnection := Connection;
end;

function TDBXDelegateConnection.CreateAndBeginTransaction(
  const Isolation: TDBXIsolation): TDBXTransaction;
begin
  Result := TDBXAccessorConnection(FConnection).CreateAndBeginTransaction(Isolation);
end;

function TDBXDelegateConnection.CreateMorphCommand(
  MorphicCommand: TDBXCommand): TDBXCommand;
begin
  Result := inherited CreateMorphCommand(MorphicCommand);
  if Result = nil then
  begin
    Result := TDBXAccessorConnection(FConnection).CreateMorphCommand(MorphicCommand);
  end
end;

function TDBXDelegateConnection.CreateCommand: TDBXCommand;
begin
  Result := FConnection.CreateCommand;
end;

destructor TDBXDelegateConnection.Destroy;
begin
  inherited; // Release transaction stack first.
  FreeAndNil(FConnection);
  //FDBXContext freed with FConnection
end;

procedure TDBXDelegateConnection.Open;
begin
  if not FConnection.IsOpen then
  begin
    TDBXAccessorConnection(FConnection).Open;
  end;
end;

procedure TDBXDelegateConnection.Rollback(const Transaction: TDBXTransaction);
begin
  TDBXAccessorConnection(FConnection).Rollback(Transaction);
end;

procedure TDBXDelegateConnection.RollbackFreeAndNil(
  var Transaction: TDBXTransaction);
begin
  FConnection.RollbackFreeAndNil(Transaction);
end;

procedure TDBXDelegateConnection.RollbackIncompleteFreeAndNil(
  var Transaction: TDBXTransaction);
begin
  FConnection.RollbackIncompleteFreeAndNil(Transaction);
end;

function TDBXDelegateConnection.GetDatabaseMetaData: TDBXDatabaseMetaData;
begin
  Result := FConnection.DatabaseMetaData;
end;

function TDBXDelegateConnection.GetDBXFormatter: TDBXFormatter;
begin
  Result := FConnection.DBXFormatter;
end;

function TDBXDelegateConnection.GetConnectionProperties: TDBXProperties;
begin
  Result := FConnection.ConnectionProperties;
end;

function TDBXDelegateConnection.GetConnectionProperty(
  const Name: string): string;
begin
  Result := FConnection.ConnectionProperty[Name];
end;

function TDBXDelegateConnection.GetErrorEvent: TDBXErrorEvent;
begin
  Result := inherited GetErrorEvent;
end;

function TDBXDelegateConnection.GetIsOpen: Boolean;
begin
  if FConnection = nil then
    Result := False
  else
    Result := FConnection.IsOpen;
end;

function TDBXDelegateConnection.GetProductName: string;
begin
  Result := FConnection.ProductName;
end;

function TDBXDelegateConnection.GetProductVersion: string;
begin
  Result := FConnection.ProductVersion;
end;

procedure TDBXDelegateConnection.SetConnectionProperties(
  const Value: TDBXProperties);
begin
  FConnection.ConnectionProperties := Value;
end;

procedure TDBXDelegateConnection.SetDBXFormatter(
  const DBXFormatter: TDBXFormatter);
begin
  FConnection.DBXFormatter := DBXFormatter;
end;

procedure TDBXDelegateConnection.SetErrorEvent(const ErrorEvent: TDBXErrorEvent);
begin
  TDBXAccessorConnection(FConnection).SetErrorEvent(ErrorEvent);
  inherited SetErrorevent(ErrorEvent);
end;

function TDBXDelegateConnection.GetTraceFlags: TDBXTraceFlag;
begin
  Result := FConnection.TraceFlags;
end;

function TDBXDelegateConnection.GetTraceInfoEvent: TDBXTraceEvent;
begin
  Result := FConnection.OnTrace;
end;

function TDBXDelegateConnection.GetVendorProperty(const Name: string): string;
begin
  Result := FConnection.GetVendorProperty(Name);
end;

procedure TDBXDelegateConnection.DerivedClose;
begin
  TDBXAccessorConnection(FConnection).DerivedClose;
end;

function TDBXDelegateConnection.DerivedCreateCommand: TDBXCommand;
begin
  Result := TDBXAccessorConnection(FConnection).DerivedCreateCommand;
end;

procedure TDBXDelegateConnection.DerivedGetCommands(const CommandType: string;
  const List: TStrings);
begin
  TDBXAccessorConnection(FConnection).DerivedGetCommands(CommandType, List);
end;

procedure TDBXDelegateConnection.DerivedGetCommandTypes(const List: TStrings);
begin
  TDBXAccessorConnection(FConnection).DerivedGetCommandTypes(List);
end;

procedure TDBXDelegateConnection.DerivedOpen;
begin
  TDBXAccessorConnection(FConnection).DerivedOpen;
end;

procedure TDBXDelegateConnection.SetTraceFlags(const TraceFlags: TDBXTraceFlag);
begin
  FConnection.TraceFlags := TraceFlags;
end;

procedure TDBXDelegateConnection.SetTraceInfoEvent(
  const TraceInfoEvent: TDBXTraceEvent);
begin
  if Assigned(TraceInfoEvent) then
    FConnection.OnTrace := TraceInfoEvent;
end;

{ TDBXDelegateCommand }


procedure TDBXDelegateCommand.DerivedOpen;
begin
  TDBXAccessorCommand(FCommand).DerivedOpen;
end;


procedure TDBXDelegateCommand.DerivedClearParameters;
begin
  TDBXAccessorCommand(FCommand).DerivedClearParameters;
end;

procedure TDBXDelegateCommand.DerivedClose;
begin
  TDBXAccessorCommand(FCommand).DerivedClose;
end;

constructor TDBXDelegateCommand.Create(DBXContext: TDBXContext; Command: TDBXCommand);
begin
  inherited Create(DBXContext);
  FCommand := Command;
end;


procedure TDBXDelegateCommand.CreateParameters(Command: TDBXCommand);
begin
  TDBXAccessorCommand(FCommand).CreateParameters(Command);
end;


destructor TDBXDelegateCommand.Destroy;
begin
  FreeAndNil(FCommand);
  inherited;
end;

function TDBXDelegateCommand.ExecuteQuery: TDBXReader;
begin
  Result := FCommand.ExecuteQuery;
end;

procedure TDBXDelegateCommand.ExecuteUpdate;
begin
  FCommand.ExecuteUpdate;
end;

function TDBXDelegateCommand.GetParameters: TDBXParameterList;
begin
  Result := TDBXAccessorCommand(FCommand).GetParameters;
end;


function TDBXDelegateCommand.CreateParameter: TDBXParameter;
begin
  Result := FCommand.CreateParameter;
end;

function TDBXDelegateCommand.CreateParameterRow: TDBXRow;
begin
  Result := TDBXAccessorCommand(FCommand).CreateParameterRow;
end;

function TDBXDelegateCommand.GetRowsAffected: Int64;
begin
  Result := FCommand.RowsAffected;
end;

function TDBXDelegateCommand.GetText: string;
begin
  Result := FCommand.Text;
end;


function TDBXDelegateCommand.GetCommandTimeout: Integer;
begin
  Result := FCommand.CommandTimeout;
end;


function TDBXDelegateCommand.GetCommandType: string;
begin
  Result := FCommand.CommandType;
end;


function TDBXDelegateCommand.GetErrorEvent: TDBXErrorEvent;
begin
  Result := FCommand.OnErrorEvent;
end;


procedure TDBXDelegateCommand.Open;
begin
  TDBXAccessorCommand(FCommand).Open;
end;

function TDBXDelegateCommand.GetNextReader: TDBXReader;
begin
  Result := FCommand.GetNextReader;
end;

procedure TDBXDelegateCommand.Prepare;
begin
  FCommand.Prepare;
end;


function TDBXDelegateCommand.DerivedExecuteQuery: TDBXReader;
begin
  Result := TDBXAccessorCommand(FCommand).DerivedExecuteQuery;
end;

procedure TDBXDelegateCommand.DerivedExecuteUpdate;
begin
  TDBXAccessorCommand(FCommand).DerivedExecuteUpdate;
end;

function TDBXDelegateCommand.DerivedGetNextReader: TDBXReader;
begin
  Result := TDBXAccessorCommand(FCommand).DerivedGetNextReader;
end;

procedure TDBXDelegateCommand.DerivedPrepare;
begin
  TDBXAccessorCommand(FCommand).DerivedPrepare;
end;

procedure TDBXDelegateCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
  FCommand.MaxBlobSize  := MaxBlobSize;
end;

procedure TDBXDelegateCommand.SetRowSetSize(const Value: Int64);
begin
  FCommand.RowSetSize := Value;
end;


procedure TDBXDelegateCommand.SetCommandTimeout(const Timeout: Integer);
begin
  FCommand.CommandTimeout := Timeout;
end;

procedure TDBXDelegateCommand.SetCommandType(const Value: string);
begin
  Close;
  FCommand.CommandType := Value;
end;

procedure TDBXDelegateCommand.SetText(const Value: string);
begin
  Close;
  FCommand.Text := Value;
end;


{ TDBXDelegateParameters }


procedure TDBXDelegateParameterList.SetCount(const Count: TInt32);
begin
  FParameterList.SetCount(Count);
end;

procedure TDBXDelegateParameterList.AddParameter(Parameter: TDBXParameter);
begin
  FParameterList.AddParameter(Parameter);

end;

procedure TDBXDelegateParameterList.ClearParameters;
begin
  FParameterList.ClearParameters;

end;

procedure TDBXDelegateParameterList.SetParameter(const Ordinal: Integer;
  const Parameter: TDBXParameter);
begin
  FParameterList.SetParameter(Ordinal, Parameter);

end;

constructor TDBXDelegateParameterList.Create(DBXContext: TDBXContext;
  Command: TDBXCommand; Parameters: TDBXParameterList);
begin
  inherited Create(DBXContext, Command);
  FParameterList := Parameters;
end;

destructor TDBXDelegateParameterList.Destroy;
begin
  inherited;
end;

function TDBXDelegateParameterList.GetCount: TInt32;
begin
  Result := TDBXAccessorParameterList(FParameterList).GetCount;
end;

function TDBXDelegateParameterList.GetOrdinal(const Name: string): Integer;
begin
  Result := FParameterList.GetOrdinal(Name);
end;

function TDBXDelegateParameterList.GetParameterByOrdinal(
  const Ordinal: TInt32): TDBXParameter;
begin
  Result := TDBXAccessorParameterList(FParameterList).GetParameterByOrdinal(Ordinal);
end;

procedure TDBXDelegateParameterList.InsertParameter(Ordinal: Integer;
  Parameter: TDBXParameter);
begin
  FParameterList.InsertParameter(Ordinal, Parameter);
end;

procedure TDBXDelegateParameterList.RemoveParameter(Parameter: TDBXParameter);
begin
  FParameterList.RemoveParameter(Parameter);
end;


procedure TDBXDelegateParameterList.RemoveParameters;
begin
  FParameterList.RemoveParameters;
end;

procedure TDBXDelegateParameterList.RemoveParameter(Ordinal: Integer);
begin
  FParameterList.RemoveParameter(Ordinal);
end;

{ TDBXDelegateReader }

constructor TDBXDelegateReader.Create(DBXContext: TDBXContext;
  Reader: TDBXReader);
begin
  inherited Create(DBXContext, nil, nil);
  FReader := Reader;
end;

procedure TDBXDelegateReader.DerivedClose;
begin
  TDBXAccessorReader(FReader).DerivedClose;
end;

function TDBXDelegateReader.DerivedNext: Boolean;
begin
  Result := FReader.Next;
end;

destructor TDBXDelegateReader.Destroy;
begin
  FreeAndNil(FReader);
  inherited;
end;


function TDBXDelegateReader.GetByteReader: TDBXByteReader;
begin
  Result := TDBXAccessorReader(FReader).GetByteReader;
end;

function TDBXDelegateReader.GetColumnCount: TInt32;
begin
  Result := TDBXAccessorReader(FReader).GetColumnCount;
end;

function TDBXDelegateReader.GetObjectTypeName(Ordinal: TInt32): string;
begin
  Result := FReader.GetObjectTypeName(Ordinal);
end;

function TDBXDelegateReader.GetOrdinal(const Name: string): TInt32;
begin
  Result := TDBXAccessorReader(FReader).GetOrdinal(Name);
end;


function TDBXDelegateReader.GetReaderHandle: Integer;
begin
  Result := TDBXAccessorReader(FReader).GetReaderHandle;
end;


function TDBXDelegateReader.GetRowHandle: Integer;
begin
  Result := TDBXAccessorReader(FReader).GetRowHandle;
end;

function TDBXDelegateReader.GetValue(const Ordinal: TInt32): TDBXValue;
begin
  Result := TDBXAccessorReader(FReader).GetValue(Ordinal);
end;

function TDBXDelegateReader.GetValueByName(const Name: string): TDBXValue;
begin
  Result := TDBXAccessorReader(FReader).GetValueByName(Name);
end;

function TDBXDelegateReader.GetValueType(const Ordinal: TInt32): TDBXValueType;
begin
  Result := TDBXAccessorReader(FReader).GetValueType(Ordinal);
end;


function TDBXDelegateReader.IsUpdateable: Boolean;
begin
  Result := TDBXAccessorReader(FReader).IsUpdateable;
end;

function TDBXDelegateReader.Next: Boolean;
begin
  Result := FReader.Next;
end;



function TDBXDelegateReader.Reset: Boolean;
begin
  Result := FReader.Reset;
end;


{ TDBXDelegateWritableValue }

constructor TDBXDelegateWritableValue.Create(ValueType: TDBXValueType; Value: TDBXWritableValue);
begin
  inherited Create(ValueType);
  FValue := Value;
  FWritableValue := Value;
end;

destructor TDBXDelegateWritableValue.Destroy;
begin
  // These are not owned by this object, so don't free them.
  //
  FValue := nil;
  FWritableValue := nil;
  inherited;
end;


function TDBXDelegateWritableValue.EqualsValue(Other: TDBXValue): Boolean;
begin
  Result := FValue.EqualsValue(Other);
end;

function TDBXDelegateWritableValue.GetBcd: TBcd;
begin
  Result := FValue.GetBcd;
end;

function TDBXDelegateWritableValue.GetBoolean(defaultValue: Boolean): Boolean;
begin
  Result := FValue.GetBoolean(defaultValue);
end;

function TDBXDelegateWritableValue.GetBoolean: Boolean;
begin
  Result := FValue.GetBoolean;
end;

function TDBXDelegateWritableValue.GetBytes(Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64): Int64;
begin
  Result := FValue.GetBytes(Offset, Buffer, BufferOffset, Length);
end;

function TDBXDelegateWritableValue.GetDate: TDBXDate;
begin
  Result := FValue.GetDate;
end;


function TDBXDelegateWritableValue.GetDBXConnection: TDBXConnection;
begin
  Result := FValue.GetDBXConnection;
end;

function TDBXDelegateWritableValue.GetDBXReader(AInstanceOwner: Boolean): TDBXReader;
begin
  Result := FValue.GetDBXReader(AInstanceOwner);
end;

function TDBXDelegateWritableValue.GetDouble: Double;
begin
  Result := FValue.GetDouble;
end;

function TDBXDelegateWritableValue.GetInt16: SmallInt;
begin
  Result := FValue.GetInt16;
end;

function TDBXDelegateWritableValue.GetInt32: TInt32;
begin
  Result := FValue.GetInt32;
end;

function TDBXDelegateWritableValue.GetInt64: Int64;
begin
  Result := FValue.GetInt64;
end;

{$IFNDEF NEXTGEN}
function TDBXDelegateWritableValue.GetAnsiString: AnsiString;
begin
  Result := FValue.GetAnsiString;
end;
{$ENDIF !NEXTGEN}

function TDBXDelegateWritableValue.GetAsBcd: TBcd;
begin
  Result := FValue.AsBcd;
end;

function TDBXDelegateWritableValue.GetAsBoolean: Boolean;
begin
  Result := FValue.AsBoolean;
end;

function TDBXDelegateWritableValue.GetAsDate: TDBXDate;
begin
  Result := FValue.AsDate;
end;

function TDBXDelegateWritableValue.GetAsDouble: Double;
begin
  Result := FValue.AsDouble;
end;

function TDBXDelegateWritableValue.GetAsInt16: SmallInt;
begin
  Result := FValue.AsInt16;
end;

function TDBXDelegateWritableValue.GetAsInt32: TInt32;
begin
  Result := FValue.AsInt32;
end;

function TDBXDelegateWritableValue.GetAsInt64: Int64;
begin
  Result := FValue.AsInt64;
end;


function TDBXDelegateWritableValue.GetAsInt8: ShortInt;
begin
  Result := FValue.AsInt8;
end;

function TDBXDelegateWritableValue.GetAsSingle: Single;
begin
  Result := FValue.AsSingle;
end;

function TDBXDelegateWritableValue.GetAsString: string;
begin
  Result := FValue.AsString;
end;


function TDBXDelegateWritableValue.GetAsTime: TDBXTime;
begin
  Result := FValue.AsTime;
end;


function TDBXDelegateWritableValue.GetAsTimeStamp: TSQLTimeStamp;
begin
  Result := FValue.AsTimeStamp;
end;

function TDBXDelegateWritableValue.GetAsUInt16: Word;
begin
  Result := FValue.AsUInt16;
end;

function TDBXDelegateWritableValue.GetAsUInt8: Byte;
begin
  Result := FValue.AsUInt8;
end;

function TDBXDelegateWritableValue.GetTime: TDBXTime;
begin
  Result := FValue.GetTime;
end;

function TDBXDelegateWritableValue.GetTimeStamp: TSQLTimeStamp;
begin
  Result := FValue.GetTimeStamp;
end;

function TDBXDelegateWritableValue.GetTimeStampOffset: TSQLTimeStampOffset;
begin
  Result := FValue.GetTimeStampOffset;
end;

function TDBXDelegateWritableValue.GetUInt16: Word;
begin
  Result := FValue.GetUInt16;
end;

function TDBXDelegateWritableValue.GetUInt16(defaultValue: Word): Word;
begin
  Result := FValue.GetUInt16(defaultValue);
end;

function TDBXDelegateWritableValue.GetUInt8(defaultValue: Byte): Byte;
begin
  Result := FValue.GetUInt8(defaultValue);
end;

function TDBXDelegateWritableValue.GetUInt8: Byte;
begin
  Result := FValue.GetUInt8;
end;

function TDBXDelegateWritableValue.GetValueSize: Int64;
begin
  Result := FValue.GetValueSize;
end;

function TDBXDelegateWritableValue.GetWideString(
  defaultValue: string): string;
begin
  Result := FValue.GetWideString(defaultValue);
end;

function TDBXDelegateWritableValue.GetWideString: string;
begin
  Result := FValue.GetWideString;
end;


function TDBXDelegateWritableValue.GetSingle: Single;
begin
  Result := FValue.GetSingle;
end;


function TDBXDelegateWritableValue.GetStream(AInstanceOwner: Boolean): TStream;
begin
  Result := FValue.GetStream(AInstanceOwner);
end;

function TDBXDelegateWritableValue.GetString: string;
begin
  Result := FValue.GetWideString;
end;

function TDBXDelegateWritableValue.IsNull: Boolean;
begin
  Result := FValue.IsNull;
end;

procedure TDBXDelegateWritableValue.SetBcd(const Value: TBcd);
begin
  FWritableValue.SetBcd(Value);
end;

procedure TDBXDelegateWritableValue.SetBoolean(const Value: Boolean);
begin
  FWritableValue.SetBoolean(Value);
end;

//procedure TDBXDelegateWritableValue.SetBytes(const Buffer: TArray<Byte>; BufferOffset,
//  Length: Int64);
//begin
//  FWritableValue.SetBytes(Buffer, BufferOffset, Length);
//
//end;

procedure TDBXDelegateWritableValue.SetDate(const Value: TDBXDate);
begin
  FWritableValue.SetDate(Value);
end;


procedure TDBXDelegateWritableValue.SetDBXConnection(
  const Value: TDBXConnection);
begin
  FWritableValue.SetDBXConnection(Value);
end;


procedure TDBXDelegateWritableValue.SetDBXReader(const Value: TDBXReader;
  const AInstanceOwner: Boolean);
begin
  FWritableValue.SetDBXReader(Value, AInstanceOwner);
end;

procedure TDBXDelegateWritableValue.SetDouble(const Value: Double);
begin
  FWritableValue.SetDouble(Value);
end;

procedure TDBXDelegateWritableValue.SetDynamicBytes(Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64);
begin
  FWritableValue.SetDynamicBytes(Offset, Buffer, BufferOffset, Length);
end;

procedure TDBXDelegateWritableValue.SetInt16(const Value: SmallInt);
begin
  FWritableValue.SetInt16(Value);
end;

procedure TDBXDelegateWritableValue.SetInt32(const Value: TInt32);
begin
  FWritableValue.SetInt32(Value);
end;

procedure TDBXDelegateWritableValue.SetInt64(const Value: Int64);
begin
  FWritableValue.SetInt64(Value);
end;

procedure TDBXDelegateWritableValue.SetInt8(const Value: ShortInt);
begin
  FWritableValue.SetInt8(Value);
end;

procedure TDBXDelegateWritableValue.SetNull;
begin
  FWritableValue.SetNull;
end;

procedure TDBXDelegateWritableValue.SetPendingValue;
begin
  TDBXAccessorWritableValue(FWritableValue).SetPendingValue;
end;


procedure TDBXDelegateWritableValue.SetSingle(const Value: Single);
begin
  FWritableValue.SetSingle(Value);
end;

procedure TDBXDelegateWritableValue.SetStaticBytes(Offset: Int64;
  const Buffer: array of Byte; BufferOffset, Length: Int64);
begin
  FWritableValue.SetStaticBytes(Offset, Buffer, BufferOffset, Length);
end;


procedure TDBXDelegateWritableValue.SetStream(const Stream: TStream;
  const AInstanceOwner: Boolean);
begin
  FWritableValue.SetStream(Stream, AInstanceOwner);
end;


procedure TDBXDelegateWritableValue.SetString(const Value: string);
begin
  FWritableValue.SetString(Value);
end;

//procedure TDBXDelegateWritableValue.SetStream(const Stream: TStream);
//begin
//  FWritableValue.SetStream(Stream);
//end;

{$IFNDEF NEXTGEN}
procedure TDBXDelegateWritableValue.SetAnsiString(const Value: AnsiString);
begin
  FWritableValue.SetAnsiString(Value);
end;
{$ENDIF !NEXTGEN}

procedure TDBXDelegateWritableValue.SetAsBcd(const Value: TBcd);
begin
  FWritableValue.AsBcd := Value;
end;

procedure TDBXDelegateWritableValue.SetAsBoolean(const Value: Boolean);
begin
  FWritableValue.AsBoolean := Value;
end;

procedure TDBXDelegateWritableValue.SetAsDate(const Value: TDBXDate);
begin
  FWritableValue.AsDate := Value;
end;

procedure TDBXDelegateWritableValue.SetAsDouble(const Value: Double);
begin
  FWritableValue.AsDouble := Value;
end;

procedure TDBXDelegateWritableValue.SetAsInt16(const Value: SmallInt);
begin
  FWritableValue.AsInt16 := Value;
end;

procedure TDBXDelegateWritableValue.SetAsInt32(const Value: TInt32);
begin
  FWritableValue.AsInt32 := Value;
end;

procedure TDBXDelegateWritableValue.SetAsInt64(const Value: Int64);
begin
  FWritableValue.AsInt64 := Value;
end;

procedure TDBXDelegateWritableValue.SetAsInt8(const Value: ShortInt);
begin
  FWritableValue.AsInt8 := Value;
end;

procedure TDBXDelegateWritableValue.SetAsSingle(const Value: Single);
begin
  FWritableValue.AsSingle := Value;
end;

procedure TDBXDelegateWritableValue.SetAsString(const Value: string);
begin
  FWritableValue.AsString := Value;
end;

procedure TDBXDelegateWritableValue.SetAsTime(const Value: TDBXTime);
begin
  FWritableValue.AsTime := Value;
end;

procedure TDBXDelegateWritableValue.SetAsTimeStamp(const Value: TSQLTimeStamp);
begin
  FWritableValue.AsTimeStamp := Value;
end;

procedure TDBXDelegateWritableValue.SetAsUInt16(const Value: Word);
begin
  FWritableValue.AsUInt16 := Value;
end;

procedure TDBXDelegateWritableValue.SetAsUInt8(const Value: Byte);
begin
  FWritableValue.AsUInt8 := Value;
end;

procedure TDBXDelegateWritableValue.SetTime(const Value: TDBXTime);
begin
  FWritableValue.SetTime(Value);
end;

procedure TDBXDelegateWritableValue.SetTimeStamp(const Value: TSQLTimeStamp);
begin
  FWritableValue.SetTimeStamp(Value);
end;

procedure TDBXDelegateWritableValue.SetTimeStampOffset(
  const Value: TSQLTimeStampOffset);
begin
  FWritableValue.SetTimeStampOffset(Value);
end;

procedure TDBXDelegateWritableValue.SetUInt16(const Value: Word);
begin
  FWritableValue.SetUInt16(Value);
end;

procedure TDBXDelegateWritableValue.SetUInt8(const Value: Byte);
begin
  FWritableValue.SetUInt8(Value);
end;

procedure TDBXDelegateWritableValue.SetValue(const Value: TDBXValue);
begin
  FWritableValue.SetValue(Value);
end;

procedure TDBXDelegateWritableValue.SetWideString(const Value: string);
begin
  FWritableValue.SetWideString(Value);
end;

procedure TDBXDelegateParameter.Assign(Source: TDBXParameter);
begin
  FParameter.Assign(Source);
end;

function TDBXDelegateParameter.Clone: TObject;
begin
  Result := FParameter.Clone;
end;

constructor TDBXDelegateParameter.Create(DbxContext: TDBXContext; Parameter: TDBXParameter);
begin
  FParameter := Parameter;
  inherited Create(DbxContext);
                                                                                        
                                                                             
                  
   
  Name := Parameter.Name;
end;

destructor TDBXDelegateParameter.Destroy;
begin
  FreeAndNil(FParameter);
  inherited;
end;

function TDBXDelegateParameter.GetChildPosition: TInt32;
begin
  Result := TDBXAccessorParameter(FParameter).GetChildPosition;
end;

function TDBXDelegateParameter.GetDataType: TDBXType;
begin
  Result := TDBXAccessorParameter(FParameter).GetDataType;
end;

function TDBXDelegateParameter.GetDisplayName: string;
begin
  Result := TDBXAccessorParameter(FParameter).GetDisplayName;
end;

function TDBXDelegateParameter.GetFlags: TInt32;
begin
  Result := TDBXAccessorParameter(FParameter).GetFlags;
end;

function TDBXDelegateParameter.GetHidden: LongBool;
begin
  Result := TDBXAccessorParameter(FParameter).GetHidden;
end;

function TDBXDelegateParameter.GetLiteral: Boolean;
begin
  Result := TDBXAccessorParameter(FParameter).GetLiteral;
end;

function TDBXDelegateParameter.GetName: string;
begin
  Result := TDBXAccessorParameter(FParameter).GetName;
end;

function TDBXDelegateParameter.GetOrdinal: TInt32;
begin
  Result := TDBXAccessorParameter(FParameter).GetOrdinal;
end;

function TDBXDelegateParameter.GetParameterDirection: TDBXParameterDirection;
begin
  Result := TDBXAccessorParameter(FParameter).GetParameterDirection;
end;

function TDBXDelegateParameter.GetPrecision: Int64;
begin
  Result := TDBXAccessorParameter(FParameter).GetPrecision;
end;

function TDBXDelegateParameter.GetScale: TInt32;
begin
  Result := TDBXAccessorParameter(FParameter).GetScale;
end;

function TDBXDelegateParameter.GetSize: Int64;
begin
  Result := TDBXAccessorParameter(FParameter).GetSize;
end;

function TDBXDelegateParameter.GetSubType: TDBXType;
begin
  Result := TDBXAccessorParameter(FParameter).GetSubType;
end;

function TDBXDelegateParameter.GetValue: TDBXWritableValue;
begin
  Result := FParameter.Value;
end;

function TDBXDelegateParameter.GetValueParameter: Boolean;
begin
  Result := TDBXAccessorParameter(FParameter).GetValueParameter;
end;

procedure TDBXDelegateParameter.SetChildPosition(const ChildPosition: TInt32);
begin
  TDBXAccessorParameter(FParameter).SetChildPosition(ChildPosition);
end;

procedure TDBXDelegateParameter.SetDataType(const DataType: TDBXType);
begin
  TDBXAccessorParameter(FParameter).SetDataType(DataType);
end;

procedure TDBXDelegateParameter.SetDbxRow(const DbxRow: TDBXRow);
begin
  TDBXAccessorParameter(FParameter).SetDbxRow(DbxRow);
end;

procedure TDBXDelegateParameter.SetDisplayName(const Caption: string);
begin
  TDBXAccessorParameter(FParameter).SetDisplayName(Caption);
end;

procedure TDBXDelegateParameter.SetFlags(const Flags: TInt32);
begin
  TDBXAccessorParameter(FParameter).SetFlags(Flags);
end;

procedure TDBXDelegateParameter.SetHidden(const Hidden: LongBool);
begin
  TDBXAccessorParameter(FParameter).SetHidden(Hidden);
end;

procedure TDBXDelegateParameter.SetLiteral(const Literal: Boolean);
begin
  TDBXAccessorParameter(FParameter).SetLiteral(Literal);
end;

procedure TDBXDelegateParameter.SetName(const Name: string);
begin
  inherited SetName(Name);
  TDBXAccessorParameter(FParameter).SetName(Name);
end;

procedure TDBXDelegateParameter.SetNullable(const NullableValue: Boolean);
begin
  TDBXAccessorParameter(FParameter).SetNullable(NullableValue);
end;

procedure TDBXDelegateParameter.SetOrdinal(const Ordinal: TInt32);
begin
  TDBXAccessorParameter(FParameter).SetOrdinal(Ordinal);
end;

procedure TDBXDelegateParameter.SetParameter;
begin
    TDBXAccessorParameter(FParameter).SetParameter;
end;

procedure TDBXDelegateParameter.SetParameterDirection(
  const ParameterDirection: TDBXParameterDirection);
begin
  TDBXAccessorParameter(FParameter).SetParameterDirection(ParameterDirection);
end;

procedure TDBXDelegateParameter.SetPrecision(const Precision: Int64);
begin
  TDBXAccessorParameter(FParameter).SetPrecision(Precision);
end;

procedure TDBXDelegateParameter.SetScale(const Scale: TInt32);
begin
  TDBXAccessorParameter(FParameter).SetScale(Scale);
end;

procedure TDBXDelegateParameter.SetSize(const Size: Int64);
begin
  TDBXAccessorParameter(FParameter).SetSize(Size);
end;

procedure TDBXDelegateParameter.SetSubType(const SubType: TDBXType);
begin
  TDBXAccessorParameter(FParameter).SetSubType(SubType);
end;

procedure TDBXDelegateParameter.SetValueParameter(
  const ValueParameter: Boolean);
begin
  TDBXAccessorParameter(FParameter).SetValueParameter(ValueParameter);
end;

function TDBXDelegateWritableValue.GetInt16(defaultValue: Smallint): Smallint;
begin
  Result := FValue.GetInt16(defaultValue);
end;

function TDBXDelegateWritableValue.GetInt32(defaultValue: TInt32): TInt32;
begin
  Result := FValue.GetInt32(defaultValue);
end;

function TDBXDelegateWritableValue.GetInt64(defaultValue: Int64): Int64;
begin
  Result := FValue.GetInt64(defaultValue);
end;

function TDBXDelegateWritableValue.GetInt8(defaultValue: Shortint): Shortint;
begin
  Result := FValue.GetInt8(defaultValue);
end;

function TDBXDelegateWritableValue.GetInt8: ShortInt;
begin
  Result := FValue.GetInt8;
end;

function TDBXDelegateWritableValue.GetNonDelegate: TDBXValue;
begin
  Result := TDBXDriverHelp.GetNonDelegate(FValue);
end;


end.









