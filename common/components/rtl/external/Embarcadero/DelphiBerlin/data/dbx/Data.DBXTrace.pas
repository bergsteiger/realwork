{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DBXTrace;

interface

uses
  {$IFDEF MSWINDOWS}
  Winapi.Windows,
  {$ENDIF}
  Data.DBXCommon,
  Data.DBXDelegate,
  Data.DBXPlatform,
  Data.FmtBcd,
  Data.SqlTimSt,
  Data.DBCommonTypes,
  System.Classes,
  System.Generics.Collections,
  System.SyncObjs,
  System.SysUtils
;

const
  sDriverName = 'DBXTrace';
  sConsoleOutput = ':con';
  {$IFDEF MSWINDOWS}
  sDebugStrOutput = ':dbgstr';
  {$ENDIF}

type

  TDBXTracePropertyNames = class
  const
    /// <remarks>Semicolon separate list of TDBXTraceFlagNames</remarks>
    TraceFlags = 'TraceFlags'; { do not localize }
    /// <remarks>Set to true to activate driver level tracing </remarks>
    TraceDriver = 'TraceDriver'; { do not localize }
    /// <remarks>Set to a file to send trace ouptput to. </remarks>
    TraceFile = 'TraceFile'; { do not localize }

  end;


  TDBXTraceFlagNames = class
  const
    NONE = 'NONE'; { do not localize }
    PREPARE = 'PREPARE'; { do not localize }
    EXECUTE = 'EXECUTE'; { do not localize }
    ERROR = 'ERROR'; { do not localize }
    COMMAND = 'COMMAND'; { do not localize }
    CONNECT = 'CONNECT'; { do not localize }
    TRANSACT = 'TRANSACT'; { do not localize }
    BLOB = 'BLOB'; { do not localize }
    MISC = 'MISC'; { do not localize }
    VENDOR = 'VENDOR'; { do not localize }
    PARAMETER = 'PARAMETER'; { do not localize }
    READER = 'READER'; { do not localize }
    DRIVER_LOAD = 'DRIVER_LOAD'; { do not localize }
    METADATA = 'METADATA'; { do not localize }
    DRIVER = 'DRIVER'; { do not localize }
    CUSTOM = 'CUSTOM'; { do not localize }

  end;


  TDBXTraceWriter = class
    function IsSingleton: Boolean; virtual; abstract;
    function WriteTrace(TraceInfo: TDBXTraceInfo): CBRType; virtual; abstract;
  end;


  TDBXConsoleTraceWriter = class(TDBXTraceWriter)
    function IsSingleton: Boolean; override;
    function WriteTrace(TraceInfo: TDBXTraceInfo): CBRType; override;
  end;

  TDBXTraceFormatter = class
  private
    FCommentStart: string;
    FCommentEnd: string;
    FMaxLineWidth: Integer;

    constructor Create(CommentStart, CommentEnd: string; MaxLineWidth: Integer);

    function Comment(CommentText: string): string; virtual; abstract;
    function CommentValue(ResultName: string; Value: string): string; virtual; abstract;
    function OpenComment(CommentText: string): string; virtual; abstract;
    function CloseComment: string; virtual; abstract;

    function GetProperty(ResultName, InstanceName, PropertyName: string): string; virtual; abstract;
    function SetProperty(InstanceName, PropertyName: string;
      Value: string): string; virtual; abstract;
    function CallProcedure(InstanceName, MethodName: string): string; virtual; abstract;
    function CallFunction(ResultName, InstanceName, MethodName: string): string; virtual; abstract;

    function CallOpenProcedure(InstanceName, MethodName: string): string; virtual; abstract;
    function CallOpenFunction(ResultName, InstanceName, MethodName: string): string; virtual; abstract;

    function ArrayProperty(InstanceName: string; Ordinal: Integer): string; virtual; abstract;
    function ParamString(Param: string; Separator: string): string; virtual; abstract;
    function ParamWideString(Param: string; Separator: string): string; virtual; abstract;
    function ParamBoolean(Param: Boolean; Separator: string): string; virtual; abstract;
    function ParamUInt8(Param: Byte; Separator: string): string; virtual; abstract;
    function ParamInt8(Param: ShortInt; Separator: string): string; virtual; abstract;
    function ParamUInt16(Param: Word; Separator: string): string; virtual; abstract;
    function ParamInt16(Param: SmallInt; Separator: string): string; virtual; abstract;
    function ParamInt32(Param: TInt32; Separator: string): string; virtual; abstract;
    function ParamInt64(Param: Int64; Separator: string): string; virtual; abstract;
    function ParamDouble(Param: Double; Separator: string): string; virtual; abstract;
    function ParamBcd(Param: TBcd; Separator: string): string; virtual; abstract;
    function ParamDate(Param: TDBXDate; Separator: string): string; virtual; abstract;
    function ParamTime(Param: TDBXTime; Separator: string): string; virtual; abstract;
    function ParamTimeStamp(Param: TSqlTimeStamp; Separator: string): string; virtual; abstract;
    function ParamTimeStampOffset(Param: TSqlTimeStampOffset;
      Separator: string): string; virtual; abstract;
    function ParamBytes(Param: array of Byte; Offset: Int64;
      RequestedCount, Count: Int64; Separator: string): string; virtual; abstract;

    function ColumnTypeToStr(ColumnType: TDBXType): string; virtual;

    function CloseProcedure: string; virtual; abstract;
    function CloseFunction: string; virtual; abstract;
    function QuoteString(Value: string): string; virtual; abstract;
  end;

  TDBXTracePascalFormatter = class(TDBXTraceFormatter)
  private
    function Comment(CommentText: string): string; override;
    function CommentValue(ResultName: string; Value: string): string; override;
    function OpenComment(CommentText: string): string; override;
    function CloseComment: string; override;

    function GetProperty(ResultName, InstanceName, PropertyName: string): string; override;
    function SetProperty(InstanceName, PropertyName: string;
      Value: string): string; override;
    function CallProcedure(InstanceName, MethodName: string): string; override;
    function CallFunction(ResultName, InstanceName, MethodName: string): string; override;

    function CallOpenProcedure(InstanceName, MethodName: string): string; override;
    function CallOpenFunction(ResultName, InstanceName, MethodName: string): string; override;

    function ArrayProperty(InstanceName: string; Ordinal: Integer): string; override;
    function ParamString(Param: string; Separator: string): string; override;
    function ParamWideString(Param: string; Separator: string): string; override;
    function ParamBoolean(Param: Boolean; Separator: string): string; override;
    function ParamUInt8(Param: Byte; Separator: string): string; override;
    function ParamInt8(Param: ShortInt; Separator: string): string; override;
    function ParamUInt16(Param: Word; Separator: string): string; override;
    function ParamInt16(Param: SmallInt; Separator: string): string; override;
    function ParamInt32(Param: TInt32; Separator: string): string; override;
    function ParamInt64(Param: Int64; Separator: string): string; override;
    function ParamDouble(Param: Double; Separator: string): string; override;
    function ParamBcd(Param: TBcd; Separator: string): string; override;
    function ParamDate(Param: TDBXDate; Separator: string): string; override;
    function ParamTime(Param: TDBXTime; Separator: string): string; override;
    function ParamTimeStamp(Param: TSqlTimeStamp; Separator: string): string; override;
    function ParamTimeStampOffset(Param: TSqlTimeStampOffset;
      Separator: string): string; override;
    function ParamBytes(Param: array of Byte; Offset: Int64;
      RequestedCount, Count: Int64; Separator: string): string; override;

    function CloseProcedure: string; override;
    function CloseFunction: string; override;
    function QuoteString(Value: string): string; override;

  end;

  TDBXTraceOutput = class
  private
    FName: string;
    FReferenceCount: TInt32;
    FCriticalSection: TCriticalSection;
    FFormatter: TDBXTraceFormatter;
    procedure Open; virtual; abstract;
    procedure WriteTraceln(Line: string); virtual; abstract;
    function LogTrace(TraceInfo: TDBXTraceInfo): CBRType;
    function LogDriverTrace(TraceInfo: TDBXTraceInfo): CBRType;
    function TraceFlagToString(TraceFlag: TDBXTraceFlag): string;
    procedure AddReference;
    function RemoveReference: TInt32;
    property Name: string read FName write FName;
    property Formatter: TDBXTraceFormatter read FFormatter write FFormatter;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  {$IFDEF MSWINDOWS}
  TDBXDebugStrTraceOutput = class(TDBXTraceOutput)
  private
    procedure Open; override;
    procedure WriteTraceln(Line: string); override;
  end;
  {$ENDIF}

  TDBXConsoleTraceOutput = class(TDBXTraceOutput)
  private
    procedure Open; override;
    procedure WriteTraceln(Line: string); override;
  end;

  TDBXFileTraceOutput = class(TDBXTraceOutput)
  private
    FTraceFile: TextFile;
    procedure Open; override;
    procedure WriteTraceln(Line: string); override;
  public
    destructor Destroy; override;
  end;

  TDBXTraceDriver = class(TDBXDriver)
  private
    FConnectionCount: Int64;
    FTraceOutputList: TDictionary<string, TDBXTraceOutput>;
    function GetTraceOutput(Name: string): TDBXTraceOutput;
    procedure AddTraceOutput(TraceOutput: TDBXTraceOutput);
    procedure ReleaseTraceOutput(TraceOutput: TDBXTraceOutput);
    procedure SetTraceFlags(TraceFlags: Integer);
    function GetTraceFlags: Integer;
    procedure SetTraceDriver(TraceDriver: Boolean);
    function GetTraceDriver: Boolean;
    procedure SetTraceFile(TraceFile: string);
    function GetTraceFile: string;
  protected
    function GetDriverName: string; override;
    procedure Close; override;
  public
    destructor Destroy; override;
    constructor Create(DriverDef: TDBXDriverDef); override;
    function CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection; override;
    function GetDriverVersion: string; override;
    property TraceFlags: Integer read GetTraceFlags write SetTraceFlags;
    property TraceDriver: Boolean read GetTraceDriver write SetTraceDriver;
    property TraceFile: string read GetTraceFile write SetTraceFile;
  end;

  TDBXTraceConnection = class(TDBXDelegateConnection)
  private
    [Weak]FFormatter: TDBXTraceFormatter;
    FConnectionId: Int64;
    FConnectionName: string;
    FCommandCount: Int64;
    FOriginalLogError: TDBXErrorEvent;
    [Weak]FTraceDriver: TDBXTraceDriver;
    [Weak]FTraceOutput: TDBXTraceOutput;
    procedure Trace(TraceFlags: TDBXTraceFlag; Message: string);
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
    function DerivedCreateCommand: TDBXCommand; overload; override;
    procedure DerivedOpen; override;
    procedure DerivedGetCommandTypes(const List: TStrings); override;
    procedure DerivedGetCommands(const CommandType: string;
      const List: TStrings); override;
    function CreateMorphCommand(MorphicCommand: TDBXCommand): TDBXCommand; override;
    function GetProductVersion: string; override;
    function GetProductName: string; override;
    function GetConnectionProperty(const Name: string): string; override;
    procedure LogError(DBXError: TDBXError);

    function GetName: string;
  public
    constructor Create(ConnectionBuilder: TDBXConnectionBuilder;
      TraceOutput: TDBXTraceOutput; DRIVER: TDBXTraceDriver;
      Connection: TDBXConnection; ConnectionId: Int64);
    destructor Destroy; override;
    procedure Open; override;
    procedure Close; override;
    function BeginTransaction(Isolation: TDBXIsolation): TDBXTransaction; overload; override;
    function BeginTransaction: TDBXTransaction; overload; override;
    procedure CommitFreeAndNil(var Transaction: TDBXTransaction); override;
    procedure RollbackFreeAndNil(var Transaction: TDBXTransaction); override;
    procedure RollbackIncompleteFreeAndNil(var Transaction: TDBXTransaction); override;
    function CreateCommand: TDBXCommand; override;
    function GetVendorProperty(const Name: string): string; override;
  end;


  TDBXTraceCommand = class(TDBXDelegateCommand)
  private
    [Weak]FFormatter: TDBXTraceFormatter;
    FReaderCount: Int64;
    FConnectionId: Int64;
    FCommandId: Int64;
    FCommandName: string;
    FParametersName: string;
    procedure Trace(TraceFlags: TDBXTraceFlag; Message: string);
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
    procedure Open; override;
    function DerivedGetNextReader: TDBXReader; override;
    procedure DerivedOpen; override;
    procedure DerivedClose; override;
    procedure DerivedPrepare; override;
    function DerivedExecuteQuery: TDBXReader; override;
    procedure DerivedExecuteUpdate; override;
    procedure DerivedClearParameters; override;
    function GetName: string;
  public
    constructor Create(Command: TDBXCommand; DBXContext: TDBXContext;
      Formatter: TDBXTraceFormatter; ConnectionId: Int64; CommandId: Int64);
    destructor Destroy; override;
    function CreateParameter: TDBXParameter; override;
    function GetParameters: TDBXParameterList; override;
    procedure Prepare; override;
    function ExecuteQuery: TDBXReader; override;
    procedure ExecuteUpdate; override;
    function GetNextReader: TDBXReader; override;
  end;

  TDBXTraceParameterList = class(TDBXDelegateParameterList)
  strict protected
    [Weak]FFormatter: TDBXTraceFormatter;
    FParametersName: string;
    FConnectionId: Int64;
    FCommandId: Int64;

    function GetName: string;
  protected
    function GetParameterByOrdinal(const Ordinal: TInt32): TDBXParameter; override;
    function GetCount: TInt32; override;
  public
    constructor Create(Command: TDBXCommand; Parameters: TDBXParameterList;
      DBXContext: TDBXContext; Formatter: TDBXTraceFormatter;
      ParametersName: string; ConnectionId: Int64; CommandId: Int64);
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


  TDBXTraceWritableValue = class(TDBXDelegateWritableValue)
  private
    [Weak]FFormatter: TDBXTraceFormatter;
    FValueName: string;
    FValueDisplayName: string;
    FLastOrdinal: TInt32;

    function GetValueDisplayName: string;
  protected
    constructor Create(DBXContext: TDBXContext; ValueType: TDBXValueType;
      Value: TDBXWritableValue; Formatter: TDBXTraceFormatter;
      ValueName: string); overload;
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
    function GetAsTimeStamp: TSqlTimeStamp; override;
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
    procedure SetAsTimeStamp(const Value: TSqlTimeStamp); override;
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
    function GetTimeStamp: TSqlTimeStamp; override;
    function GetTimeStampOffset: TSqlTimeStampOffset; override;
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
    procedure SetTimeStamp(const Value: TSqlTimeStamp); override;
    procedure SetTimeStampOffset(const Value: TSqlTimeStampOffset); override;
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
  end;

  TDBXTraceParameter = class(TDBXDelegateParameter)
  private
    FTraceValue: TDBXTraceWritableValue;
    [Weak]FFormatter: TDBXTraceFormatter;
    FParameterName: string;
  protected
    function GetValue: TDBXWritableValue; override;
  public
    constructor Create(DBXContext: TDBXContext; Parameter: TDBXParameter;
      Formatter: TDBXTraceFormatter; ValueName: string);
    destructor Destroy; override;
    function Clone: TObject; override;
  end;

  TDBXTraceReader = class(TDBXDelegateReader)
  private
    [Weak]FFormatter: TDBXTraceFormatter;
    FNextCount: Int64;
    FConnectionId: Int64;
    FCommandId: Int64;
    FReaderId: Int64;
    FReaderName: string;
    FClosed: Boolean;

    procedure PrintColumns;
  public
    constructor Create(DBXContext: TDBXContext; Reader: TDBXReader;
      Formatter: TDBXTraceFormatter; ConnectionId: Int64; CommandId: Int64;
      ReaderId: Int64);
    destructor Destroy; override;
    function Next: Boolean; override;
  end;

  TTraceFlag = (PARAMETER,ERROR,EXECUTE,COMMAND,CONNECT,TRANSACT,BLOB,MISC,VENDOR,READER,DRIVER_LOAD,METADATA);
  TTraceFlags = set of TTraceFlag;
  TDBXTraceProperties = class(TDBXProperties)
  strict private
  const
    StrTraceFile = 'TraceFile';

  const
    StrTraceFlags = 'TraceFlags';

  const
    StrTraceDriver = 'TraceDriver';
    function TraceFlagsToStr(Flags: TTraceFlags): string;
    function StrtoTraceFlags(Value: string): TTraceFlags;
    function GetTraceFile: string;
    function GetTraceFlags: TTraceFlags;
    function GetTraceDriver: Boolean;
    procedure SetTraceFile(const Value: string);
    procedure SetTraceFlags(const Value: TTraceFlags);
    procedure SetTraceDriver(const Value: Boolean);
  public
    constructor Create(DBXContext: TDBXContext); override;
  published
    property TraceFile: string read GetTraceFile write SetTraceFile;
    property TraceFlags: TTraceFlags read GetTraceFlags write SetTraceFlags;
    property TraceDriver: Boolean read GetTraceDriver write SetTraceDriver;
  end;


implementation

uses
  System.TypInfo,
  Data.DBXCommonResStrs,
  System.Generics.Defaults;

type

  TDBXAccessorCommand = class(TDBXCommand)
  end;


{ TDBXTraceConnection }

function TDBXTraceConnection.BeginTransaction(
  Isolation: TDBXIsolation): TDBXTransaction;
begin
  Result := inherited BeginTransaction(Isolation);
  if FDBXContext.IsTracing(TDBXTraceFlags.Transact) then
    Trace(TDBXTraceFlags.Transact, FFormatter.CallProcedure(GetName, 'BeginTransaction'));
end;

function TDBXTraceConnection.BeginTransaction: TDBXTransaction;
begin
  Result := inherited BeginTransaction;
  if FDBXContext.IsTracing(TDBXTraceFlags.Transact) then
    Trace(TDBXTraceFlags.Transact, FFormatter.CallProcedure(GetName, 'BeginTransaction'));
end;

procedure TDBXTraceConnection.Close;
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Connect) then
    Trace(TDBXTraceFlags.Connect, FFormatter.CallProcedure(GetName, 'Close'));
end;

procedure TDBXTraceConnection.Commit(const Transaction: TDBXTransaction);
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Transact) then
    Trace(TDBXTraceFlags.Transact, FFormatter.CallProcedure(GetName, 'Commit'));
end;

procedure TDBXTraceConnection.CommitFreeAndNil(
  var Transaction: TDBXTransaction);
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Transact) then
    Trace(TDBXTraceFlags.Transact, FFormatter.CallProcedure(GetName, 'CommitFreeAndNil'));
end;

constructor TDBXTraceConnection.Create(
  ConnectionBuilder: TDBXConnectionBuilder;
  TraceOutput: TDBXTraceOutput;
  Driver: TDBXTraceDriver;
  Connection: TDBXConnection;
  ConnectionId: Int64);
begin
  inherited Create(ConnectionBuilder, ConnectionBuilder.CreateDelegateeConnection);
  if ConnectionBuilder.ConnectionProperties.GetBoolean(TDBXTracePropertyNames.TraceDriver) then
    FConnection.OnTrace := TraceOutput.LogDriverTrace;
  FTraceDriver      := Driver;
  FTraceOutput      := TraceOutput;
  FFormatter        := TraceOutput.Formatter;
  FConnectionId     := ConnectionId;
  FConnectionName   := 'ConnectionC'+IntToStr(ConnectionId);
  FOriginalLogError := FConnection.OnErrorEvent;
  SetErrorEvent(LogError);
end;

function TDBXTraceConnection.CreateAndBeginTransaction(
  const Isolation: TDBXIsolation): TDBXTransaction;
begin
  Result := inherited CreateAndBeginTransaction(Isolation);
  if FDBXContext.IsTracing(TDBXTraceFlags.Transact) then
    Trace(TDBXTraceFlags.Transact, FFormatter.CallProcedure(GetName, 'CreateAndBeginTransaction'));
end;

function TDBXTraceConnection.CreateCommand: TDBXCommand;
var
  Command: TDBXTraceCommand;
begin
  Inc(FCommandCount);
  Command := TDBXTraceCommand.Create(inherited CreateCommand, FDBXContext, FFormatter, FConnectionId, FCommandCount);
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command,
          FFormatter.CallFunction(Command.GetName, GetName, 'CreateCommand'));
  Result := Command;
end;

function TDBXTraceConnection.CreateMorphCommand(
  MorphicCommand: TDBXCommand): TDBXCommand;
begin
  Result := inherited CreateMorphCommand(MorphicCommand);
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallProcedure(GetName, 'CreateMorphCommand'));
end;

function TDBXTraceConnection.DerivedCreateCommand: TDBXCommand;
begin
  Result := inherited DerivedCreateCommand;
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallProcedure(GetName, 'DerivedCreateCommand'));
end;

procedure TDBXTraceConnection.DerivedGetCommands(const CommandType: string;
  const List: TStrings);
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallProcedure(GetName, 'DerivedGetCommands'));
end;

procedure TDBXTraceConnection.DerivedGetCommandTypes(const List: TStrings);
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallProcedure(GetName, 'DerivedGetCommandTypes'));
end;

procedure TDBXTraceConnection.DerivedOpen;
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Connect) then
    Trace(TDBXTraceFlags.Connect, FFormatter.CallProcedure(GetName, 'DerivedOpen'));
end;

destructor TDBXTraceConnection.Destroy;
begin
  if IsOpen then
    Close;
  if Assigned(FDBXContext) and (FDBXContext.IsTracing(TDBXTraceFlags.Connect)) then
    Trace(TDBXTraceFlags.Connect, FFormatter.CallOpenProcedure('', 'FreeAndNil')
          + GetName + FFormatter.CloseProcedure);
  if (FTraceDriver <> nil) then
    FTraceDriver.ReleaseTraceOutput(FTraceOutput);
  FTraceOutput := nil;
  inherited;
end;

procedure TDBXTraceConnection.Open;
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Connect) then
    Trace(TDBXTraceFlags.Connect, FFormatter.CallProcedure(GetName, 'Open'));
end;

procedure TDBXTraceConnection.Rollback(const Transaction: TDBXTransaction);
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Transact) then
    Trace(TDBXTraceFlags.Transact, FFormatter.CallProcedure(GetName, 'Rollback'));
end;

procedure TDBXTraceConnection.RollbackFreeAndNil(
  var Transaction: TDBXTransaction);
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Transact) then
    Trace(TDBXTraceFlags.Transact, FFormatter.CallProcedure(GetName, 'RollbackFreeAndNil'));
end;

procedure TDBXTraceConnection.RollbackIncompleteFreeAndNil(
  var Transaction: TDBXTransaction);
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Transact) then
    Trace(TDBXTraceFlags.Transact, FFormatter.CallProcedure(GetName, 'RollbackIncompleteFreeAndNil'));
end;

function TDBXTraceConnection.GetName: string;
begin
  Result := FConnectionName;
end;

function TDBXTraceConnection.GetProductName: string;
begin
  Result := inherited GetProductName;
  if FDBXContext.IsTracing(TDBXTraceFlags.MetaData) then
    Trace(TDBXTraceFlags.MetaData, FFormatter.CallProcedure(GetName, 'GetProductName'));
end;

function TDBXTraceConnection.GetProductVersion: string;
begin
  Result := inherited GetProductVersion;
  if FDBXContext.IsTracing(TDBXTraceFlags.MetaData) then
    Trace(TDBXTraceFlags.MetaData, FFormatter.CallProcedure(GetName, 'GetProductVersion'));
end;

function TDBXTraceConnection.GetConnectionProperties: TDBXProperties;
begin
  Result := inherited GetConnectionProperties;
  if FDBXContext.IsTracing(TDBXTraceFlags.Connect) then
    Trace(TDBXTraceFlags.Connect, FFormatter.CallProcedure(GetName, 'GetConnectionProperties'));
end;

function TDBXTraceConnection.GetConnectionProperty(
  const Name: string): string;
begin
  Result := inherited GetConnectionProperty(Name);
  if FDBXContext.IsTracing(TDBXTraceFlags.Connect) then
    Trace(TDBXTraceFlags.Connect, FFormatter.CallProcedure(GetName, 'GetConnectionProperty'));
end;

function TDBXTraceConnection.GetDatabaseMetaData: TDBXDatabaseMetaData;
begin
  Result := inherited GetDatabaseMetaData;
  if FDBXContext.IsTracing(TDBXTraceFlags.MetaData) then
    Trace(TDBXTraceFlags.MetaData, FFormatter.CallProcedure(GetName, 'GetDatabaseMetaData'));
end;

function TDBXTraceConnection.GetDBXFormatter: TDBXFormatter;
begin
  Result := inherited GetDBXFormatter;
end;

function TDBXTraceConnection.GetErrorEvent: TDBXErrorEvent;
begin
  Result := inherited GetErrorEvent;
end;

function TDBXTraceConnection.GetIsOpen: Boolean;
begin
  Result := inherited GetIsOpen;
  if FDBXContext.IsTracing(TDBXTraceFlags.Connect) and Assigned(FTraceOutput) then
    Trace(TDBXTraceFlags.Connect, FFormatter.CallProcedure(GetName, 'GetIsOpen'));
end;

procedure TDBXTraceConnection.SetConnectionProperties(
  const Value: TDBXProperties);
begin
  inherited;
  if FDBXContext.IsTracing(TDBXTraceFlags.Connect) then
    Trace(TDBXTraceFlags.Connect, FFormatter.CallProcedure(GetName, 'SetConnectionProperties'));
end;

function TDBXTraceConnection.GetTraceFlags: TDBXTraceFlag;
begin
  Result := inherited GetTraceFlags;
end;

procedure TDBXTraceConnection.SetDBXFormatter(
  const DBXFormatter: TDBXFormatter);
begin
  inherited;
  if Assigned(FDBXContext) then
    FDBXContext.DBXFormatter := DBXFormatter;
end;

procedure TDBXTraceConnection.SetErrorEvent(const ErrorEvent: TDBXErrorEvent);
begin
  inherited;
  if Assigned(FDBXContext) then
    FDBXContext.OnError := ErrorEvent;
end;

function TDBXTraceConnection.GetTraceInfoEvent: TDBXTraceEvent;
begin
  Result := inherited GetTraceInfoEvent;
end;

function TDBXTraceConnection.GetVendorProperty(
  const Name: string): string;
begin
  Result := inherited GetVendorProperty(Name);
  if FDBXContext.IsTracing(TDBXTraceFlags.Driver) then
    Trace(TDBXTraceFlags.Driver, FFormatter.CallProcedure(GetName, 'GetVendorProperty'));
end;

procedure TDBXTraceConnection.LogError(DBXError: TDBXError);
var
  ErrorMessage: string;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Error) then
  begin
    ErrorMessage := FFormatter.Comment( TDBXError.ErrorCodeToString(DBXError.ErrorCode)
                       + ' ' + DBXError.Message);
    FDBXContext.Trace(TDBXTraceFlags.Error, ErrorMessage);
    if Assigned(FOriginalLogError) then
      FOriginalLogError(DBXError);
  end;
end;

procedure TDBXTraceConnection.SetTraceFlags(const TraceFlags: TDBXTraceFlag);
begin
  inherited;
  if Assigned(FDBXContext) then
    FDBXContext.TraceFlags := TraceFlags;
end;

procedure TDBXTraceConnection.SetTraceInfoEvent(
  const TraceInfoEvent: TDBXTraceEvent);
begin
  inherited;
  if Assigned(FDBXContext) then
    FDBXContext.OnTrace := TraceInfoEvent;
end;

procedure TDBXTraceConnection.Trace(TraceFlags: TDBXTraceFlag;
  Message: string);
begin
  FDBXContext.Trace(TraceFlags, Message);
end;


{ TDBXTraceCommand }

constructor TDBXTraceCommand.Create(Command: TDBXCommand; DBXContext: TDBXContext; Formatter: TDBXTraceFormatter; ConnectionId: Int64; CommandId: Int64);
begin
  inherited Create(DBXContext, Command);
  FFormatter      := Formatter;
  FConnectionId   := ConnectionId;
  FCommandId      := CommandId;
  FCommandName    := 'CommandC'+IntToStr(ConnectionId)+'_'+IntToStr(CommandId);
  FParametersName := FCommandName+'.Parameters';
end;

function TDBXTraceCommand.CreateParameter: TDBXParameter;
begin
  Result := TDBXTraceParameter.Create(FDBXContext, FCommand.CreateParameter, FFormatter, FParametersName);
end;

function TDBXTraceCommand.CreateParameterRow: TDBXRow;
begin
  Result := inherited CreateParameterRow;
end;

procedure TDBXTraceCommand.CreateParameters(Command: TDBXCommand);
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    Trace(TDBXTraceFlags.Parameter,
      FFormatter.CallProcedure(GetName, 'CreateParameters'));
  inherited;
end;

procedure TDBXTraceCommand.DerivedClearParameters;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallProcedure(GetName, 'DerivedClearParameters'));
  inherited;
end;

procedure TDBXTraceCommand.DerivedClose;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallProcedure(GetName, 'DerivedClose'));
  inherited;
end;

function TDBXTraceCommand.DerivedExecuteQuery: TDBXReader;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Execute) then
    Trace(TDBXTraceFlags.Execute, FFormatter.CallFunction('Reader', GetName, 'DerivedExecuteQuery'));
  Result := inherited DerivedExecuteQuery;
end;

procedure TDBXTraceCommand.DerivedExecuteUpdate;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Execute) then
    Trace(TDBXTraceFlags.Execute, FFormatter.CallProcedure(GetName, 'DerivedExecuteUpdate'));
  inherited;
end;

function TDBXTraceCommand.DerivedGetNextReader: TDBXReader;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Reader) then
    Trace(TDBXTraceFlags.Reader, FFormatter.CallFunction('Reader', GetName, 'DerivedGetNextReader'));
  Result := inherited DerivedGetNextReader;
end;

procedure TDBXTraceCommand.DerivedOpen;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallProcedure(GetName, 'DerivedOpen'));
  inherited;
end;

procedure TDBXTraceCommand.DerivedPrepare;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Prepare) then
    Trace(TDBXTraceFlags.Prepare, FFormatter.CallProcedure(GetName, 'DerivedPrepare'));
  inherited;
end;

destructor TDBXTraceCommand.Destroy;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallOpenProcedure('', 'FreeAndNil')
          + GetName + FFormatter.CloseProcedure);
  inherited;
end;

function TDBXTraceCommand.ExecuteQuery: TDBXReader;
var
  ReaderName: string;
begin
  Inc(FReaderCount);
  if FDBXContext.IsTracing(TDBXTraceFlags.Execute) then
  begin
    ReaderName := 'ReaderC'+IntToStr(FConnectionId)+'_'+IntToStr(FCommandId)+'_'+IntToStr(FReaderCount);
    Trace(TDBXTraceFlags.Command,
          FFormatter.CallFunction(ReaderName, GetName, 'ExecuteQuery'));
  end;
  Result := inherited ExecuteQuery;
  if (Result <> nil) and FDBXContext.IsTracing(TDBXTraceFlags.Reader) then
  begin
    Result := TDBXTraceReader.Create(FDBXContext, Result, FFormatter, FConnectionId, FCommandId, FreaderCount);
  end;
end;

procedure TDBXTraceCommand.ExecuteUpdate;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Execute) then
    Trace(TDBXTraceFlags.Execute, FFormatter.CallProcedure(GetName, 'ExecuteUpdate'));
  inherited ExecuteUpdate;
end;

function TDBXTraceCommand.GetRowsAffected: Int64;
var
  ResultName: string;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Execute) then
  begin
    ResultName := 'RowsAffectedC'+IntToStr(FConnectionId)+'_'+IntToStr(FCommandId);
    Trace(TDBXTraceFlags.Execute, FFormatter.GetProperty(ResultName, GetName, 'RowsAffected'));
  end;
  Result := inherited GetRowsAffected;
  if FDBXContext.IsTracing(TDBXTraceFlags.Execute) then
  begin
    Trace(TDBXTraceFlags.Execute, FFormatter.Comment(ResultName+' = '+IntToStr(Result)));
  end;
end;

function TDBXTraceCommand.GetText: string;
begin
  Result := inherited GetText;
end;

function TDBXTraceCommand.GetCommandTimeout: Integer;
begin
  Result := inherited GetCommandTimeout;
end;

function TDBXTraceCommand.GetCommandType: string;
begin
  Result := inherited GetCommandType;
end;

function TDBXTraceCommand.GetErrorEvent: TDBXErrorEvent;
begin
  Result := inherited GetErrorEvent;
end;

procedure TDBXTraceCommand.Open;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command, FFormatter.CallProcedure(GetName, 'Open'));
  inherited;
end;

function TDBXTraceCommand.GetName: string;
begin
  Result := FCommandName;
end;

function TDBXTraceCommand.GetNextReader: TDBXReader;
begin
  Result := inherited GetNextReader;
end;

function TDBXTraceCommand.GetParameters: TDBXParameterList;
begin
  if FParameters = nil then
    FParameters := TDBXTraceParameterList.Create(Self, FCommand.Parameters, FDBXContext, FFormatter, FCommandName, FConnectionId, FCommandId);
  Result := FParameters;
end;

procedure TDBXTraceCommand.Prepare;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Prepare) then
    Trace(TDBXTraceFlags.Prepare, FFormatter.CallProcedure(GetName, 'Prepare'));
  inherited;
end;

procedure TDBXTraceCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command,
      FFormatter.SetProperty(GetName, 'MaxBlobsize', FFormatter.ParamInt64(MaxBlobSize, '')));
  inherited;
end;

procedure TDBXTraceCommand.SetRowSetSize(const Value: Int64);
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command,
      FFormatter.SetProperty(GetName, 'RowSetSize', FFormatter.ParamInt64(Value, '')));
  inherited;
end;

procedure TDBXTraceCommand.SetCommandTimeout(const Timeout: Integer);
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command,
      FFormatter.SetProperty(GetName, 'CommandTimeout', FFormatter.ParamInt32(Timeout, '')));
  inherited;
end;

procedure TDBXTraceCommand.SetCommandType(const Value: string);
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command,
      FFormatter.SetProperty(GetName, 'CommandType', FFormatter.QuoteString(Value)));
  inherited;
end;

procedure TDBXTraceCommand.SetText(const Value: string);
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Command) then
    Trace(TDBXTraceFlags.Command,
          FFormatter.SetProperty(GetName, 'Text', FFormatter.QuoteString(Value)));
  inherited;
end;

procedure TDBXTraceCommand.Trace(TraceFlags: TDBXTraceFlag;
  Message: string);
begin
  FDBXContext.Trace(TraceFlags, Message);
end;

{ TDBXTraceDriver }

procedure TDBXTraceDriver.AddTraceOutput(TraceOutput: TDBXTraceOutput);
begin
  FTraceOutputList.Add(TraceOutput.Name, TraceOutput);
end;

procedure TDBXTraceDriver.Close;
begin
  inherited;
end;

constructor TDBXTraceDriver.Create(DriverDef: TDBXDriverDef);
begin
  inherited Create(DriverDef);
  InitDriverProperties(TDBXTraceProperties.Create(DriverDef.FDBXContext));
  FTraceOutputList := TObjectDictionary<string, TDBXTraceOutput>.Create([doOwnsValues], TIStringComparer.Ordinal);
end;

function TDBXTraceDriver.CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
var
  Connection:         TDBXTraceConnection;
  DBXContext:         TDBXContext;
  Properties:         TDBXProperties;
  TraceFlagList:      TStringList;
  TraceFlagsProperty: string;
  TraceFlagsString:   string;
  Index:              Integer;
  TraceFlags:         TDBXTraceFlag;
  TraceFileName:      string;
  NeedsOnTraceEvent:  Boolean;
  TraceOutput:        TDBXTraceOutput;
  Complete:           Boolean;
  LTraceName:         string;
begin
  DBXContext          := ConnectionBuilder.DBXContext;
  Properties          := ConnectionBuilder.ConnectionProperties;
  TraceFlagsProperty  := Properties.GetRequiredValue(TDBXTracePropertyNames.TraceFlags);
  TraceFlags := 0;
  if TraceFlagsProperty <> TDBXTraceFlagNames.NONE then
  begin
    TraceFlagList := TStringList.Create;
      try
      TraceFlagList.Delimiter := ';';
      TraceFlagList.DelimitedText := TraceFlagsProperty;
      for Index := 0 to TraceFlagList.Count - 1 do
      begin
        TraceFlagsString := TraceFlagList[Index];
        if TraceFlagsString = TDBXTraceFlagNames.PREPARE then
            TraceFlags := TraceFlags or TDBXTraceFlags.Prepare
        else if TraceFlagsString = TDBXTraceFlagNames.EXECUTE then
            TraceFlags := TraceFlags or TDBXTraceFlags.Execute
        else if TraceFlagsString = TDBXTraceFlagNames.ERROR then
            TraceFlags := TraceFlags or TDBXTraceFlags.Error
        else if TraceFlagsString = TDBXTraceFlagNames.COMMAND then
            TraceFlags := TraceFlags or TDBXTraceFlags.Command
        else if TraceFlagsString = TDBXTraceFlagNames.CONNECT then
            TraceFlags := TraceFlags or TDBXTraceFlags.Connect
        else if TraceFlagsString = TDBXTraceFlagNames.TRANSACT then
            TraceFlags := TraceFlags or TDBXTraceFlags.Transact
        else if TraceFlagsString = TDBXTraceFlagNames.BLOB then
            TraceFlags := TraceFlags or TDBXTraceFlags.Blob
        else if TraceFlagsString = TDBXTraceFlagNames.MISC then
            TraceFlags := TraceFlags or TDBXTraceFlags.Misc
        else if TraceFlagsString = TDBXTraceFlagNames.VENDOR then
            TraceFlags := TraceFlags or TDBXTraceFlags.Vendor
        else if TraceFlagsString = TDBXTraceFlagNames.PARAMETER then
            TraceFlags := TraceFlags or TDBXTraceFlags.Parameter
        else if TraceFlagsString = TDBXTraceFlagNames.READER then
            TraceFlags := TraceFlags or TDBXTraceFlags.Reader
        else if TraceFlagsString = TDBXTraceFlagNames.DRIVER_LOAD then
            TraceFlags := TraceFlags or TDBXTraceFlags.DriverLoad
        else if TraceFlagsString = TDBXTraceFlagNames.METADATA then
            TraceFlags := TraceFlags or TDBXTraceFlags.MetaData
        else if TraceFlagsString = TDBXTraceFlagNames.CUSTOM then
            TraceFlags := TraceFlags or TDBXTraceFlags.Custom
        else
          DBXContext.Error(TDBXErrorCodes.InvalidParameter,
          Format(SINVALID_TRACE_FLAG,
          [ TraceFlagsString, TDBXTracePropertyNames.TraceFlags,
            TDBXTraceFlagNames.NONE,
            TDBXTraceFlagNames.PARAMETER,
            TDBXTraceFlagNames.EXECUTE,
            TDBXTraceFlagNames.ERROR,
            TDBXTraceFlagNames.COMMAND,
            TDBXTraceFlagNames.CONNECT,
            TDBXTraceFlagNames.TRANSACT,
            TDBXTraceFlagNames.BLOB,
            TDBXTraceFlagNames.MISC,
            TDBXTraceFlagNames.VENDOR,
            TDBXTraceFlagNames.READER,
            TDBXTraceFlagNames.DRIVER_LOAD,
            TDBXTraceFlagNames.METADATA
            ]));
      end;
    finally
      FreeAndNil(TraceFlagList);
    end;
  end;

  {$IFDEF MSWINDOWS}
  if not IsConsole then
    LTraceName := sDebugStrOutput // Invalid file name.
  else
    LTraceName := sConsoleOutput; // Invalid file name.
  {$ELSE}
    LTraceName := sConsoleOutput; // Invalid file name.
  {$ENDIF}
  TraceFileName := Properties[TDBXTracePropertyNames.TraceFile];
  if TraceFileName = '' then
    TraceFileName := LTraceName;
  TraceOutput := GetTraceOutput(TraceFileName);
  if TraceOutput = nil then
  begin
    {$IFDEF MSWINDOWS}
    if TraceFileName = LTraceName then
      TraceOutput := TDBXDebugStrTraceOutput.Create;
    {$ENDIF}
    if TraceFileName = sConsoleOutput then
      TraceOutput := TDBXConsoleTraceOutput.Create
    else if TraceOutput = nil then
      TraceOutput := TDBXFileTraceOutput.Create;
    Complete := false;
    try
      TraceOutput.Name := TraceFileName;
      TraceOutput.Open;
      TraceOutput.AddReference;
      Complete := true;
    finally
      if not Complete then
        FreeAndNil(TraceOutput);
    end;
    AddTraceOutput(TraceOutput);
  end
  else
    TraceOutput.AddReference;

  DBXContext.TraceFlags := DBXContext.TraceFlags or TraceFlags;
  if Assigned(DBXContext.OnTrace) then
    NeedsOnTraceEvent := false
  else
  begin
    DBXContext.OnTrace := TraceOutput.LogTrace;
    NeedsOnTraceEvent := true;
  end;
  Complete := false;
  try
    Inc(FConnectionCount);
    Connection := TDBXTraceConnection.Create(ConnectionBuilder, TraceOutput, Self, nil, FConnectionCount);
    Result := Connection;
    Complete := true;
  finally
    if not Complete then
      ReleaseTraceOutput(TraceOutput);
    if NeedsOnTraceEvent then
      DBXContext.OnTrace := nil;
  end;
end;

destructor TDBXTraceDriver.Destroy;
begin
  FTraceOutputList.Free;
  inherited;
end;

function TDBXTraceDriver.GetDriverName: string;
begin
  Result := 'DBXTrace'; {Do not localize}
end;

function TDBXTraceDriver.GetDriverVersion: string;
begin
  Result := 'DBXTraceDriver 1.0'; {Do not localize}
end;

function TDBXTraceDriver.GetTraceDriver: Boolean;
begin
  Result := DriverProperties.GetBoolean(TDBXTracePropertyNames.TraceDriver);
end;

function TDBXTraceDriver.GetTraceFile: string;
begin
  Result := DriverProperties[TDBXTracePropertyNames.TraceFile];
end;

function TDBXTraceDriver.GetTraceFlags: Integer;
begin
  Result := DriverProperties.GetInteger(TDBXTracePropertyNames.TraceFlags);
end;

function TDBXTraceDriver.GetTraceOutput(Name: string): TDBXTraceOutput;
begin
  if FTraceOutputList.ContainsKey(Name) then
    Result := FTraceOutputList.Items[Name]
  else
    Result := nil;
end;

procedure TDBXTraceDriver.ReleaseTraceOutput(TraceOutput: TDBXTraceOutput);
begin
  if TraceOutput = GetTraceOutput(TraceOutput.Name) then
  begin
    if TraceOutput.RemoveReference < 1 then
      FTraceOutputList.Remove(TraceOutput.Name);
  end;
end;

procedure TDBXTraceDriver.SetTraceDriver(TraceDriver: Boolean);
begin
  DriverProperties[TDBXTracePropertyNames.TraceDriver] := BoolToStr(TraceDriver, True);
end;

procedure TDBXTraceDriver.SetTraceFile(TraceFile: string);
begin
  DriverProperties[TDBXTracePropertyNames.TraceFile] := TraceFile;
end;

procedure TDBXTraceDriver.SetTraceFlags(TraceFlags: Integer);
begin
  DriverProperties[TDBXTracePropertyNames.TraceFlags] := IntToStr(TraceFlags);
end;

{ TDBXTraceFormatter }

function TDBXTraceFormatter.ColumnTypeToStr(ColumnType: TDBXType): string;
begin
  Result := TDBXValueType.DataTypeName(ColumnType);
end;

constructor TDBXTraceFormatter.Create(CommentStart, CommentEnd: string;
  MaxLineWidth: Integer);
begin
  inherited Create;
  FCommentStart := CommentStart;
  FCommentEnd   := CommentEnd;
  FMaxLineWidth := MaxLineWidth;
end;

{ TDBXTracePascalFormatter }

function TDBXTracePascalFormatter.ArrayProperty(InstanceName: string;
  Ordinal: Integer): string;
begin
  Result := InstanceName + '[' + IntToStr(Ordinal) + ']';
end;

function TDBXTracePascalFormatter.CallFunction(ResultName, InstanceName,
  MethodName: string): string;
begin
  if InstanceName = '' then
    Result := ResultName + ' := ' + MethodName + ';'
  else
    Result := ResultName + ' := ' + InstanceName + '.' + MethodName + ';';
end;

function TDBXTracePascalFormatter.CallOpenFunction(ResultName, InstanceName,
  MethodName: string): string;
begin
  if InstanceName = '' then
    Result := ResultName + ' := ' + MethodName + '('
  else
    Result := ResultName + ' := ' + InstanceName + '.' + MethodName + '(';
end;

function TDBXTracePascalFormatter.CallOpenProcedure(InstanceName,
  MethodName: string): string;
begin
  if InstanceName = '' then
    Result := MethodName + '('
  else
    Result := InstanceName + '.' + MethodName + '(';
end;

function TDBXTracePascalFormatter.CallProcedure(InstanceName,
  MethodName: string): string;
begin
  if InstanceName = '' then
    Result := MethodName + ';'
  else
    Result := InstanceName + '.' + MethodName + ';';
end;

function TDBXTracePascalFormatter.CloseComment: string;
begin
  Result := FCommentEnd;
end;

function TDBXTracePascalFormatter.CloseFunction: string;
begin
  Result := ');';
end;

function TDBXTracePascalFormatter.CloseProcedure: string;
begin
  Result := ');';
end;

function TDBXTracePascalFormatter.Comment(CommentText: string): string;
begin
  Result := FCommentStart + CommentText + FCommentEnd;
end;

function TDBXTracePascalFormatter.CommentValue(ResultName,
  Value: string): string;
begin
  Result := FCommentStart + ResultName + ' = ' + Value + FCommentEnd;
end;

function TDBXTracePascalFormatter.GetProperty(ResultName, InstanceName,
  PropertyName: string): string;
begin
  Result := ResultName + ' := ' + InstanceName + '.' + PropertyName;
end;

function TDBXTracePascalFormatter.OpenComment(CommentText: string): string;
begin
  Result := FCommentEnd;
end;

function TDBXTracePascalFormatter.ParamBcd(Param: TBcd;
  Separator: string): string;
begin
  // When setting output params, a nil'd out value is sent
  // that cannot be converted to a string.
  //
  if Param.Precision = 0 then
    Result := 'StrToBcd('''+'0'+''')' + Separator
  else
    Result := 'StrToBcd('''+BcdToStr(Param)+''')' + Separator;
end;

function TDBXTracePascalFormatter.ParamBoolean(Param: Boolean;
  Separator: string): string;
begin
  Result := BoolToStr(Param, true) + Separator;
end;

const
  Hex = '0123456789ABCDEF';

function TDBXTracePascalFormatter.ParamBytes(Param: array of Byte; Offset,
  RequestedCount, Count: Int64; Separator: string): string;
var
  Buffer: TDBXWideChars;
  BufIndex, HexIndex, Index: Integer;
  Ch: Byte;
begin
  if Count < 1 then
    SetLength(Buffer, 4+2)
  else
    SetLength(Buffer, Count*4+2);
  Buffer[1] := '[';
  BufIndex := 2;
  for Index := Offset to High(Param) do
  begin
    Ch := Param[Index];
    Buffer[BufIndex] := '$';
    Inc(BufIndex);
    HexIndex := Ch shr 4;
    if HexIndex = 0 then
      Buffer[BufIndex] := Char(Hex[(Ch shr 4)+1]);
    Buffer[BufIndex] := Char(Hex[(Ch shr 4)+1]);
    Inc(BufIndex);
    Buffer[BufIndex] := Char(Hex[(Ch and $F)+1]);
    Inc(BufIndex);
    Buffer[BufIndex] := ',';
    Inc(BufIndex);
  end;
  Buffer[BufIndex-1] := ']';

  Result := TDBXPlatform.CreateWideString(Buffer, BufIndex) + Separator;
end;

function TDBXTracePascalFormatter.ParamDate(Param: TDBXDate;
  Separator: string): string;
var
  TimeStamp: TTimeStamp;
begin
  TimeStamp.Date := Param;
  TimeStamp.Time := 0;
  Result := IntToStr(Param) + FCommentStart+DateToStr(TimeStampToDateTime(TimeStamp))+FCommentEnd + Separator;
end;

function TDBXTracePascalFormatter.ParamDouble(Param: Double;
  Separator: string): string;
begin
  Result := FloatToStr(Param) + Separator;
end;

function TDBXTracePascalFormatter.ParamInt16(Param: SmallInt;
  Separator: string): string;
begin
  Result := IntToStr(Param) + Separator;
end;

function TDBXTracePascalFormatter.ParamInt32(Param: TInt32;
  Separator: string): string;
begin
  Result := IntToStr(Param) + Separator;
end;

function TDBXTracePascalFormatter.ParamInt64(Param: Int64;
  Separator: string): string;
begin
  Result := IntToStr(Param) + Separator;
end;

function TDBXTracePascalFormatter.ParamInt8(Param: ShortInt;
  Separator: string): string;
begin
  Result := IntToStr(Param) + Separator;
end;

function TDBXTracePascalFormatter.ParamString(Param, Separator: string): string;
begin
  Result := QuoteString(Param) + Separator;
end;
function TDBXTracePascalFormatter.ParamTime(Param: TDBXTime;
  Separator: string): string;
var
  TimeStamp: TTimeStamp;
begin
  TimeStamp.Date := DateDelta;
  TimeStamp.Time := Param;
  Result := IntToStr(Param) + FCommentStart+TimeToStr(TimeStampToDateTime(TimeStamp))+FCommentEnd + Separator;
end;

function TDBXTracePascalFormatter.ParamTimeStamp(Param: TSqlTimeStamp;
  Separator: string): string;
begin
  Result := 'StrToSQLTimeSTamp(' + QuoteString(SQLTimeStampToStr('', Param)) + ')' + Separator;
end;

function TDBXTracePascalFormatter.ParamTimeStampOffset(
  Param: TSqlTimeStampOffset; Separator: string): string;
begin
  Result := 'StrToSQLTimeStampOffset(' + QuoteString(SQLTimeStampOffsetToStr('', Param)) + ')' + Separator;
end;

function TDBXTracePascalFormatter.ParamUInt16(Param: Word;
  Separator: string): string;
begin
  Result := IntToStr(Param) + Separator;
end;

function TDBXTracePascalFormatter.ParamUInt8(Param: Byte;
  Separator: string): string;
begin
  Result := IntToStr(Param) + Separator;
end;

function TDBXTracePascalFormatter.ParamWideString(Param: string;
  Separator: string): string;
begin
  Result := QuoteString(Param) + Separator;
end;

function TDBXTracePascalFormatter.QuoteString(Value: string): string;
var
  StringList: TStringList;
  Index, StartIndex, StringEnd: Integer;
  Ch: Char;
begin
  StringList := TStringList.Create;
  try
    StringList.LineBreak := '';
    StartIndex := 1;
    StringList.Add('''');
    StringEnd := Value.Length;
    Index := 1;
    while Index <= StringEnd do
    begin
      Ch := Value.Chars[Index - 1];
      if Ch < ' ' then
      begin
        StringList.Add(Value.Substring(StartIndex - 1, Index - StartIndex));
        StartIndex := Index + 1;
        StringList.Add('''#'+IntToStr(Integer(Ch))+'''');
      end;
      if Ch = #10 then
      begin
        if (Index+1) < StringEnd then
          StringList.Add(''''#13#10'+''');
      end;
      if (Index-StartIndex) > 100 then
      begin
        StringList.Add(Value.Substring(StartIndex - 1, Index - StartIndex));
        StringList.Add('''+''');
        StartIndex := Index;
      end;
      Inc(Index);
    end;
    StringList.Add(Value.Substring(StartIndex - 1, Index - StartIndex));
    StringList.Add('''');
    Result := StringList.Text;
  finally
    StringList.Free;
  end;
end;

function TDBXTracePascalFormatter.SetProperty(InstanceName,
  PropertyName: string; Value: string): string;
begin
  Result := InstanceName + '.' + PropertyName + ' := ' + Value + ';';
end;

{ TDBXTraceParameters }


procedure TDBXTraceParameterList.AddParameter(Parameter: TDBXParameter);
begin
  inherited AddParameter(Parameter);
end;

procedure TDBXTraceParameterList.ClearParameters;
begin
  inherited ClearParameters;
end;

constructor TDBXTraceParameterList.Create(
  Command: TDBXCommand; Parameters: TDBXParameterList;
  DBXContext: TDBXContext; Formatter: TDBXTraceFormatter;
  ParametersName: string; ConnectionId, CommandId: Int64);
begin
  inherited Create(DBXContext, Command, Parameters);
  FFormatter := Formatter;
  FConnectionId := ConnectionId;
  FCommandId := CommandId;
  FParametersName := ParametersName;
end;

function TDBXTraceParameterList.GetCount: TInt32;
begin
  Result := inherited GetCount;
end;

function TDBXTraceParameterList.GetName: string;
begin
  Result := FParametersName;
end;

function TDBXTraceParameterList.GetOrdinal(const Name: string): Integer;
begin
  Result := inherited GetOrdinal(Name);
end;

function TDBXTraceParameterList.GetParameterByOrdinal(
  const Ordinal: TInt32): TDBXParameter;
begin
  Result := inherited GetParameterByOrdinal(Ordinal);
end;

procedure TDBXTraceParameterList.InsertParameter(Ordinal: Integer;
  Parameter: TDBXParameter);
begin
  inherited InsertParameter(Ordinal, Parameter);
end;

procedure TDBXTraceParameterList.RemoveParameter(Ordinal: Integer);
begin
  inherited RemoveParameter(Ordinal);
end;

procedure TDBXTraceParameterList.RemoveParameter(Parameter: TDBXParameter);
begin
  inherited RemoveParameter(Parameter);
end;

procedure TDBXTraceParameterList.RemoveParameters;
begin
  inherited RemoveParameters;
end;

procedure TDBXTraceParameterList.SetCount(const Count: TInt32);
begin
  inherited SetCount(Count);
end;

procedure TDBXTraceParameterList.SetParameter(const Ordinal: Integer;
  const Parameter: TDBXParameter);
begin
  inherited SetParameter(Ordinal, Parameter);
end;

{ TDBXConsoleTraceWriter }

function TDBXConsoleTraceWriter.IsSingleton: Boolean;
begin
  Result := true;
end;

function TDBXConsoleTraceWriter.WriteTrace(TraceInfo: TDBXTraceInfo): CBRType;
begin
  Writeln(TraceInfo.Message);
  Result := cbrUSEDEF;
end;


{ TDBXTraceWritableValue }

constructor TDBXTraceWritableValue.Create(DBXContext: TDBXContext; ValueType: TDBXValueType; Value: TDBXWritableValue;  Formatter: TDBXTraceFormatter;ValueName: string);
begin
  inherited Create(ValueType, Value);
  FFormatter      := Formatter;
  FValueName      := ValueName;
  FLastOrdinal    := -1;
end;

function TDBXTraceWritableValue.EqualsValue(Other: TDBXValue): Boolean;
begin
  Result := inherited EqualsValue(Other);
end;

function TDBXTraceWritableValue.GetBcd: TBcd;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultBcd',
                                  GetValueDisplayName,
                                  'GetBcd'));
  Result := inherited GetBCD;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultBcd', FFormatter.ParamBcd(Result, '')));
end;

function TDBXTraceWritableValue.GetBoolean(defaultValue: Boolean): Boolean;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultBoolean',
                                  GetValueDisplayName,
                                  'GetBoolean'));
  Result := inherited GetBoolean(defaultValue);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultBoolean', FFormatter.ParamBoolean(Result, '')));
end;

function TDBXTraceWritableValue.GetBoolean: Boolean;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultBoolean',
                                  GetValueDisplayName,
                                  'GetBoolean'));
  Result := inherited GetBoolean;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultBoolean', FFormatter.ParamBoolean(Result, '')));
end;

function TDBXTraceWritableValue.GetBytes(Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64): Int64;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultBytes',
                                  GetValueDisplayName,
                                  'GetBytes'));
  Result := inherited GetBytes(Offset, Buffer, BufferOffset, Length);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultBytes',
          FFormatter.ParamBytes(Buffer, BufferOffset, Length, Result, '')));
end;

function TDBXTraceWritableValue.GetDate: TDBXDate;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultDate',
                                  GetValueDisplayName,
                                  'GetDate'));
  Result := inherited GetDate;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultDate', FFormatter.ParamDate(Result, '')));
end;

function TDBXTraceWritableValue.GetDBXConnection: TDBXConnection;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultDBXConnection',
                                  GetValueDisplayName,
                                  'GetDBXConnection'));
  Result := inherited GetDBXConnection;
end;

function TDBXTraceWritableValue.GetDBXReader(AInstanceOwner: Boolean): TDBXReader;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultDBXReader',
                                  GetValueDisplayName,
                                  'GetDBXReader'));
  Result := inherited GetDBXReader(AInstanceOwner);
end;

function TDBXTraceWritableValue.GetDouble: Double;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultDouble',
                                  GetValueDisplayName,
                                  'GetDouble'));
  Result := inherited GetDouble;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultDouble', FFormatter.ParamDouble(Result, '')));
end;

function TDBXTraceWritableValue.GetInt16: SmallInt;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt16',
                                  GetValueDisplayName,
                                  'GetInt16'));
  Result := inherited GetInt16;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt16', FFormatter.ParamInt16(Result, '')));
end;

function TDBXTraceWritableValue.GetInt32: TInt32;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt32',
                                  GetValueDisplayName,
                                  'GetInt32'));
  Result := inherited GetInt32;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt32', FFormatter.ParamInt32(Result, '')));
end;

function TDBXTraceWritableValue.GetInt64: Int64;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt64',
                                  GetValueDisplayName,
                                  'GetInt64'));
  Result := inherited GetInt64;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt64', FFormatter.ParamInt64(Result, '')));
end;

{$IFNDEF NEXTGEN}
function TDBXTraceWritableValue.GetAnsiString: AnsiString;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultString',
                                  GetValueDisplayName,
                                  'GetAnsiString'));
  Result := inherited GetAnsiString;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultString', FFormatter.ParamString(string(Result), '')));
end;
{$ENDIF !NEXTGEN}

function TDBXTraceWritableValue.GetAsBcd: TBcd;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultBcd',
                                  GetValueDisplayName,
                                  'GetAsBcd'));
  Result := inherited GetAsBCD;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultBcd', FFormatter.ParamBcd(Result, '')));
end;

function TDBXTraceWritableValue.GetAsBoolean: Boolean;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultBoolean',
                                  GetValueDisplayName,
                                  'GetAsBoolean'));
  Result := inherited GetAsBoolean;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultBoolean', FFormatter.ParamBoolean(Result, '')));
end;

function TDBXTraceWritableValue.GetAsDate: TDBXDate;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultDate',
                                  GetValueDisplayName,
                                  'GetAsDate'));
  Result := inherited GetAsDate;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultDate', FFormatter.ParamDate(Result, '')));
end;

function TDBXTraceWritableValue.GetAsDouble: Double;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultDouble',
                                  GetValueDisplayName,
                                  'GetAsDouble'));
  Result := inherited GetAsDouble;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultDouble', FFormatter.ParamDouble(Result, '')));
end;

function TDBXTraceWritableValue.GetAsInt16: SmallInt;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt16',
                                  GetValueDisplayName,
                                  'GetAsInt16'));
  Result := inherited GetAsInt16;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt16', FFormatter.ParamInt16(Result, '')));
end;

function TDBXTraceWritableValue.GetAsInt32: TInt32;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt32',
                                  GetValueDisplayName,
                                  'GetAsInt32'));
  Result := inherited GetInt32;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt32', FFormatter.ParamInt32(Result, '')));
end;

function TDBXTraceWritableValue.GetAsInt64: Int64;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt64',
                                  GetValueDisplayName,
                                  'GetAsInt64'));
  Result := inherited GetInt64;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt64', FFormatter.ParamInt64(Result, '')));
end;

function TDBXTraceWritableValue.GetAsInt8: ShortInt;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt8',
                                  GetValueDisplayName,
                                  'GetAsInt8'));
  Result := inherited GetAsInt8;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt8', FFormatter.ParamInt8(Result, '')));
end;

function TDBXTraceWritableValue.GetAsSingle: Single;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultSingle',
                                  GetValueDisplayName,
                                  'GetAsSingle'));
  Result := inherited GetAsSingle;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultSingle', FFormatter.ParamDouble(Result, '')));
end;

function TDBXTraceWritableValue.GetAsString: string;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultString',
                                  GetValueDisplayName,
                                  'GetAsString'));
  Result := inherited GetAsString;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultString', FFormatter.ParamString(Result, '')));
end;

function TDBXTraceWritableValue.GetAsTime: TDBXTime;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultTime',
                                  GetValueDisplayName,
                                  'GetAsTime'));
  Result := inherited GetAsTime;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultTime', FFormatter.ParamTime(Result, '')));
end;

function TDBXTraceWritableValue.GetAsTimeStamp: TSQLTimeStamp;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultTimeStamp',
                                  GetValueDisplayName,
                                  'GetAsTimeStamp'));
  Result := inherited GetAsTimeStamp;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultTimeStamp', FFormatter.ParamTimeStamp(Result, '')));
end;

function TDBXTraceWritableValue.GetAsUInt16: Word;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultUInt16',
                                  GetValueDisplayName,
                                  'GetAsUInt16'));
  Result := inherited GetAsUInt16;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultUInt16', FFormatter.ParamUInt16(Result, '')));
end;

function TDBXTraceWritableValue.GetAsUInt8: Byte;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultUInt8',
                                  GetValueDisplayName,
                                  'GetAsUInt8'));
  Result := inherited GetAsUInt8;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultUInt8', FFormatter.ParamUInt8(Result, '')));

end;

function TDBXTraceWritableValue.GetTime: TDBXTime;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultTime',
                                  GetValueDisplayName,
                                  'GetTime'));
  Result := inherited GetTime;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultTime', FFormatter.ParamTime(Result, '')));
end;

function TDBXTraceWritableValue.GetTimeStamp: TSQLTimeStamp;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultTimeStamp',
                                  GetValueDisplayName,
                                  'GetTimeStamp'));
  Result := inherited GetTimeStamp;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultTimeStamp', FFormatter.ParamTimeStamp(Result, '')));
end;

function TDBXTraceWritableValue.GetTimeStampOffset: TSQLTimeStampOffset;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultTimeStampOffset',
                                  GetValueDisplayName,
                                  'GetTimeStampOffset'));
  Result := inherited GetTimeStampOffset;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultTimeStampOffset', FFormatter.ParamTimeStampOffset(Result, '')));
end;

function TDBXTraceWritableValue.GetUInt16: Word;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultUInt16',
                                  GetValueDisplayName,
                                  'GetUInt16'));
  Result := inherited GetUInt16;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultUInt16', FFormatter.ParamUInt16(Result, '')));
end;

function TDBXTraceWritableValue.GetUInt16(defaultValue: Word): Word;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultUInt16',
                                  GetValueDisplayName,
                                  'GetUInt16'));
  Result := inherited GetUInt16(defaultValue);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultUInt16', FFormatter.ParamUInt16(Result, '')));
end;

function TDBXTraceWritableValue.GetUInt8(defaultValue: Byte): Byte;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultUInt8',
                                  GetValueDisplayName,
                                  'GetUInt8'));
  Result := inherited GetUInt8(defaultValue);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultUInt8', FFormatter.ParamUInt8(Result, '')));
end;

function TDBXTraceWritableValue.GetUInt8: Byte;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultUInt8',
                                  GetValueDisplayName,
                                  'GetUInt8'));
  Result := inherited GetUInt8;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultUInt8', FFormatter.ParamUInt8(Result, '')));
end;

function TDBXTraceWritableValue.GetValueDisplayName: string;
begin
  if FLastOrdinal <> ValueType.Ordinal then
  begin
    FValueDisplayName := FValueName + '[' + IntToStr(ValueType.Ordinal) + '].Value';
    FLastOrdinal := ValueType.Ordinal;
  end;
  Result := FValueDisplayName;
end;

function TDBXTraceWritableValue.GetValueSize: Int64;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DbxContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultGetValueSize',
                                  GetValueDisplayName,
                                  'GetValueSize'));
  Result := inherited GetValueSize;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DbxContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultGetBlobLength', FFormatter.ParamInt64(Result, '')));
end;

function TDBXTraceWritableValue.GetWideString(
  defaultValue: string): string;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultWideString',
                                  GetValueDisplayName,
                                  'GetWideString'));
  Result := inherited GetWideString(defaultValue);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultWideString', FFormatter.ParamWideString(Result, '')));
end;

function TDBXTraceWritableValue.GetWideString: string;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultWideString',
                                  GetValueDisplayName,
                                  'GetWideString'));
  Result := inherited GetWideString;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultWideString', FFormatter.ParamWideString(Result, '')));
end;

function TDBXTraceWritableValue.IsNull: Boolean;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty(GetValueDisplayName+' ResultIsNull',
                                  GetValueDisplayName,
                                  'IsNull'));
  Result := inherited IsNull;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultIsNull', FFormatter.ParamBoolean(Result, '')));
end;

procedure TDBXTraceWritableValue.SetBcd(const Value: TBcd);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetBcd')
          + FFormatter.ParamBcd(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetBoolean(const Value: Boolean);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetBoolean')
          + FFormatter.ParamBoolean(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetDate(const Value: TDBXDate);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetDate')
          + FFormatter.ParamDate(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetDBXConnection(const Value: TDBXConnection);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallProcedure(GetValueDisplayName,
          'SetDBXConnection'));
  inherited;
end;

procedure TDBXTraceWritableValue.SetDBXReader(const Value: TDBXReader;
  const AInstanceOwner: Boolean);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetDBXReader')
          + FFormatter.ParamBoolean(AInstanceOwner, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetDouble(const Value: Double);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetDouble')
          + FFormatter.ParamDouble(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetDynamicBytes(Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetDynamicBytes')
          + FFormatter.ParamInt64(Offset, ',')
          + FFormatter.ParamBytes(Buffer, BufferOffset, Length, Length, ',')
          + FFormatter.ParamInt64(BufferOffset, ',')
          + FFormatter.ParamInt64(Length, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetInt16(const Value: SmallInt);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetInt16')
          + FFormatter.ParamInt16(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetInt32(const Value: TInt32);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetInt32')
          + FFormatter.ParamInt32(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetInt64(const Value: Int64);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetInt64')
          + FFormatter.ParamInt64(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetInt8(const Value: ShortInt);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetInt8')
          + FFormatter.ParamInt8(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetNull;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallProcedure(GetValueDisplayName,
          'SetNull'));
  inherited;
end;

procedure TDBXTraceWritableValue.SetPendingValue;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallProcedure(GetValueDisplayName,
          'SetPendingValue'));
  inherited;
end;

procedure TDBXTraceWritableValue.SetSingle(const Value: Single);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetSingle')
          + FFormatter.ParamDouble(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetStaticBytes(Offset: Int64;
  const Buffer: array of Byte; BufferOffset, Length: Int64);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetStaticBytes')
          + FFormatter.ParamInt64(Offset, ',')
          + FFormatter.ParamBytes(Buffer, BufferOffset, Length, Length, ',')
          + FFormatter.ParamInt64(BufferOffset, ',')
          + FFormatter.ParamInt64(Length, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetStream(const Stream: TStream;
  const AInstanceOwner: Boolean);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetStream')
          + FFormatter.ParamBoolean(AInstanceOwner, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetString(const Value: string);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetString')
          + FFormatter.ParamString(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

{$IFNDEF NEXTGEN}
procedure TDBXTraceWritableValue.SetAnsiString(const Value: AnsiString);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAnsiString')
          + FFormatter.ParamString(string(Value), '')
          + FFormatter.CloseProcedure);
  inherited;
end;
{$ENDIF !NEXTGEN}

procedure TDBXTraceWritableValue.SetAsBcd(const Value: TBcd);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsBcd')
          + FFormatter.ParamBcd(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsBoolean(const Value: Boolean);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsBoolean')
          + FFormatter.ParamBoolean(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsDate(const Value: TDBXDate);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsDate')
          + FFormatter.ParamDate(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsDouble(const Value: Double);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsDouble')
          + FFormatter.ParamDouble(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsInt16(const Value: SmallInt);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsInt16')
          + FFormatter.ParamInt16(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsInt32(const Value: TInt32);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsInt32')
          + FFormatter.ParamInt32(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsInt64(const Value: Int64);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsInt64')
          + FFormatter.ParamInt64(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsInt8(const Value: ShortInt);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsInt8')
          + FFormatter.ParamInt8(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsSingle(const Value: Single);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsSingle')
          + FFormatter.ParamDouble(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsString(const Value: string);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsString')
          + FFormatter.ParamString(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsTime(const Value: TDBXTime);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsTime')
          + FFormatter.ParamTime(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsTimeStamp(const Value: TSQLTimeStamp);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsTimeStamp')
          + FFormatter.ParamTimeStamp(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsUInt16(const Value: Word);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsUInt16')
          + FFormatter.ParamUInt16(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetAsUInt8(const Value: Byte);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetAsUInt8')
          + FFormatter.ParamUInt8(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetTime(const Value: TDBXTime);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetTime')
          + FFormatter.ParamTime(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetTimeStamp(const Value: TSQLTimeStamp);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetTimeStamp')
          + FFormatter.ParamTimeStamp(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetTimeStampOffset(
  const Value: TSQLTimeStampOffset);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetTimeStampOffset')
          + FFormatter.ParamTimeStampOffset(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetUInt16(const Value: Word);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetUInt16')
          + FFormatter.ParamUInt16(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetUInt8(const Value: Byte);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetUInt8')
          + FFormatter.ParamUInt8(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

procedure TDBXTraceWritableValue.SetValue(const Value: TDBXValue);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallProcedure(GetValueDisplayName,
          'SetValue'));
  inherited;
end;

procedure TDBXTraceWritableValue.SetWideString(const Value: string);
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CallOpenProcedure(GetValueDisplayName,
          'SetWideString')
          + FFormatter.ParamWideString(Value, '')
          + FFormatter.CloseProcedure);
  inherited;
end;

function TDBXTraceWritableValue.GetInt16(defaultValue: Smallint): Smallint;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt16',
                                  GetValueDisplayName,
                                  'GetInt16'));
  Result := inherited GetInt16(defaultValue);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt16', FFormatter.ParamInt16(Result, '')));
end;

function TDBXTraceWritableValue.GetInt32(defaultValue: TInt32): TInt32;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt32',
                                  GetValueDisplayName,
                                  'GetInt32'));
  Result := inherited GetInt32(defaultValue);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt32', FFormatter.ParamInt32(Result, '')));
end;

function TDBXTraceWritableValue.GetInt64(defaultValue: Int64): Int64;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt64',
                                  GetValueDisplayName,
                                  'GetInt64'));
  Result := inherited GetInt64(defaultValue);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt64', FFormatter.ParamInt64(Result, '')));
end;

function TDBXTraceWritableValue.GetInt8(defaultValue: Shortint): Shortint;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt8',
                                  GetValueDisplayName,
                                  'GetInt8'));
  Result := inherited GetInt8(defaultValue);
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt8', FFormatter.ParamInt8(Result, '')));

end;

function TDBXTraceWritableValue.GetInt8: ShortInt;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultInt8',
                                  GetValueDisplayName,
                                  'GetInt8'));
  Result := inherited GetInt8;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultInt8', FFormatter.ParamInt8(Result, '')));

end;

function TDBXTraceWritableValue.GetNonDelegate: TDBXValue;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultValue',
                                  GetValueDisplayName,
                                  'GetNonDelegate'));
  Result := inherited GetNonDelegate;
end;

function TDBXTraceWritableValue.GetSingle: Single;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultSingle',
                                  GetValueDisplayName,
                                  'GetSingle'));
  Result := inherited GetSingle;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultSingle', FFormatter.ParamDouble(Result, '')));
end;

function TDBXTraceWritableValue.GetStream(AInstanceOwner: Boolean): TStream;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultStream',
                                  GetValueDisplayName,
                                  'GetStream'));
  Result := inherited GetStream(AInstanceOwner);
end;

function TDBXTraceWritableValue.GetString: string;
begin
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.GetProperty('ResultString',
                                  GetValueDisplayName,
                                  'GetString'));
  Result := inherited GetString;
  if DBXContext.IsTracing(TDBXTraceFlags.Parameter) then
    DBXContext.Trace(TDBXTraceFlags.Parameter,
          FFormatter.CommentValue(GetValueDisplayName+' ResultString', FFormatter.ParamString(Result, '')));
end;

{ TDBXTraceParameter }

function TDBXTraceParameter.Clone: TObject;
var
  Parameter: TDBXParameter;
begin
  if Assigned(FParameter) then
    Parameter := TDBXParameter(TDBXParameter(FParameter).Clone)
  else
    Parameter := nil;
  Result := TDBXTraceParameter.Create(FDBXContext, Parameter, FFormatter, FParameterName+'_Clone'); { Do not resource }
end;

constructor TDBXTraceParameter.Create(DbxContext: TDBXContext; Parameter: TDBXParameter;
Formatter: TDBXTraceFormatter; ValueName: string);
begin
  inherited Create(DbxContext, Parameter);
  FFormatter  := Formatter;
  FParameterName := ValueName;
end;

destructor TDBXTraceParameter.Destroy;
begin
  inherited;
  FreeAndNil(FTraceValue);
end;

function TDBXTraceParameter.GetValue: TDBXWritableValue;
begin
  if (FTraceValue = nil) and (FParameter.Value <> nil) then
    FTraceValue := TDBXTraceWritableValue.Create(FDbxContext, TDBXValueType(Self).Clone, FParameter.Value, FFormatter, FParameterName);
  // Subtle.  Causes type changes to be updated if needed.
  //
  inherited GetValue;
  Result := FTraceValue;
end;


{ TDBXTraceOutput }

procedure TDBXTraceOutput.AddReference;
begin
  Inc(FReferenceCount);
end;

constructor TDBXTraceOutput.Create;
begin
  inherited;
  FFormatter := TDBXTracePascalFormatter.Create('{', '}', 200);
  FCriticalSection := TCriticalSection.Create;
end;

destructor TDBXTraceOutput.Destroy;
begin
  FreeAndNil(FFormatter);
  FreeAndNil(FCriticalSection);
  inherited;
end;

function TDBXTraceOutput.LogDriverTrace(TraceInfo: TDBXTraceInfo): CBRType;
var
  DriverTraceInfo: TDBXTraceInfo;
begin
  DriverTraceInfo.TraceFlag := TraceInfo.TraceFlag or TDBXTraceFlags.Driver;
  DriverTraceInfo.Message   := FFormatter.Comment(TraceInfo.Message);
  Result := LogTrace(DriverTraceInfo);
end;

function TDBXTraceOutput.LogTrace(TraceInfo: TDBXTraceInfo): CBRType;
var
  Line, TraceName: string;
  Index, OriginalLength: Integer;
begin
  TraceName := TraceFlagToString(TraceInfo.TraceFlag);
  OriginalLength := TraceName.Length;
  for Index := OriginalLength+1 to 15 do
    TraceName := TraceName + ' ';
  Line := FFormatter.Comment(TraceName) + ' ' + TraceInfo.Message;
  FCriticalSection.Acquire;
  try
    WriteTraceln(Line);
  finally
    FCriticalSection.Release;
  end;
  Result := cbrUSEDEF;
end;

function TDBXTraceOutput.RemoveReference: TInt32;
begin
  Dec(FReferenceCount);
  Result := FReferenceCount;
end;

function TDBXTraceOutput.TraceFlagToString(TraceFlag: TDBXTraceFlag): string;
begin
  if TraceFlag and TDBXTraceFlags.Driver <> 0 then
  begin
    Result := TDBXTraceFlagNames.DRIVER + ' ' + TraceFlagToString(TraceFlag - TDBXTraceFlags.Driver);
  end else
    case TraceFlag of
        TDBXTraceFlags.Prepare:     Result := TDBXTraceFlagNames.PREPARE;
        TDBXTraceFlags.Execute:     Result := TDBXTraceFlagNames.EXECUTE;
        TDBXTraceFlags.Error:       Result := TDBXTraceFlagNames.ERROR;
        TDBXTraceFlags.Command:     Result := TDBXTraceFlagNames.COMMAND;
        TDBXTraceFlags.Connect:     Result := TDBXTraceFlagNames.CONNECT;
        TDBXTraceFlags.Transact:    Result := TDBXTraceFlagNames.TRANSACT;
        TDBXTraceFlags.Blob:        Result := TDBXTraceFlagNames.BLOB;
        TDBXTraceFlags.Misc:        Result := TDBXTraceFlagNames.MISC;
        TDBXTraceFlags.Vendor:      Result := TDBXTraceFlagNames.VENDOR;
        TDBXTraceFlags.Parameter:   Result := TDBXTraceFlagNames.PARAMETER;
        TDBXTraceFlags.Reader:      Result := TDBXTraceFlagNames.READER;
        TDBXTraceFlags.DriverLoad: Result := TDBXTraceFlagNames.DRIVER_LOAD;
        TDBXTraceFlags.MetaData:    Result := TDBXTraceFlagNames.METADATA;
      else
        Result := 'UNKNOWN' +'('+IntToStr(TraceFlag)+')';
    end;
end;

{ TDBXFileTraceOutput }

destructor TDBXFileTraceOutput.Destroy;
begin
  CloseFile(FTraceFile);
  inherited;
end;

procedure TDBXFileTraceOutput.Open;
begin
  AssignFile(FTraceFile, string(Name));
  if FileExists(Name) then
    Append(FTraceFile)
  else
    Rewrite(FTraceFile);
  WriteTraceln('Log Opened ==========================================');
end;

procedure TDBXFileTraceOutput.WriteTraceln(Line: string);
begin
  Writeln(FTraceFile, Line);
end;

{ TDBXConsoleTraceOutput }

procedure TDBXConsoleTraceOutput.Open;
begin

end;

procedure TDBXConsoleTraceOutput.WriteTraceln(Line: string);
begin
  Writeln(Line);
end;

{ TDBXTraceReader }

constructor TDBXTraceReader.Create(DBXContext: TDBXContext; Reader: TDBXReader;
  Formatter: TDBXTraceFormatter; ConnectionId, CommandId, ReaderId: Int64);
begin
  inherited Create(DBXContext, Reader);
  FFormatter      := Formatter;
  FConnectionId   := ConnectionId;
  FCommandId      := CommandId;
  FReaderId       := ReaderId;
  FReaderName     := 'ReaderC'+IntToStr(ConnectionId)+'_'+IntToStr(CommandId)+'_'+IntToStr(ReaderId);
  if FDBXContext.IsTracing(TDBXTraceFlags.Reader) then
    PrintColumns;

end;

destructor TDBXTraceReader.Destroy;
begin
  if FDBXContext.IsTracing(TDBXTraceFlags.Reader) then
  begin
    if not FClosed then
      FDbxContext.Trace(  TDBXTraceFlags.Reader,
                          ' { ' + FReaderName + ' closed.  '
                          + IntToStr(FNextCount) + ' row(s) read }');

    FDbxContext.Trace(  TDBXTraceFlags.Reader,
                        FFormatter.CallOpenProcedure('', 'FreeAndNil')
                        + FReaderName + FFormatter.CloseProcedure);
  end;
  inherited;
end;

function TDBXTraceReader.Next: Boolean;
begin
  Result := inherited Next;
  if Result then
    Inc(FNextCount)
  else if not FClosed then
  begin
    if FDBXContext.IsTracing(TDBXTraceFlags.Reader) then
    begin
      FDbxContext.Trace(  TDBXTraceFlags.Reader,
                          ' { ' + FReaderName + ' closed.  '
                          + IntToStr(FNextCount) + ' row(s) read }');
    end;
    FClosed := true;
  end;
end;

procedure TDBXTraceReader.PrintColumns;
var
  Ordinal: Integer;
  LastOrdinal: Integer;
  LocalValueType: TDBXValueType;
begin
    LastOrdinal := GetColumnCount - 1;
    for Ordinal := 0 to LastOrdinal do
    begin
      LocalValueType := ValueType[Ordinal];
      FDBXContext.Trace(TDBXTraceFlags.Reader,
                          ' {' + LocalValueType.Name
                        + '  ' + FFormatter.ColumnTypeToStr(LocalValueType.DataType)
                        + ' }');
    end;
end;

{ TDBXTraceProperties }

constructor TDBXTraceProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  TraceFlags := [PARAMETER,ERROR,EXECUTE,COMMAND,CONNECT,TRANSACT,BLOB,MISC,VENDOR,READER,DRIVER_LOAD,METADATA];
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXTrace';
  Values[TDBXPropertyNames.DelegateDriver] := BoolToStr(True, True);
end;

function TDBXTraceProperties.GetTraceDriver: Boolean;
begin
  Result := StrToBoolDef(Values[StrTraceDriver], False);
end;

function TDBXTraceProperties.GetTraceFile: string;
begin
  Result := Values[StrTraceFile];
end;

function TDBXTraceProperties.GetTraceFlags: TTraceFlags;
begin
  Result := StrToTraceFlags(Values[StrTraceFlags]);
end;

procedure TDBXTraceProperties.SetTraceDriver(const Value: Boolean);
begin
  Values[StrTraceDriver] := BoolToStr(Value, True);
end;

procedure TDBXTraceProperties.SetTraceFile(const Value: string);
begin
  Values[StrTraceFile] := Value;
end;

procedure TDBXTraceProperties.SetTraceFlags(const Value: TTraceFlags);
begin
  Values[StrTraceFlags] := TraceFlagsToStr(Value);
end;

function TDBXTraceProperties.StrtoTraceFlags(Value: string): TTraceFlags;
var
  Strings: TStringList;
  Flag: TTraceFlag;
  Info: PTypeInfo;
  Str: string;
begin
  Info := TypeInfo(TTraceFlag);
  Strings := TStringList.Create;
  try
    ExtractStrings([';'],[], PChar(Value), Strings);
    Result := [];
    for Str in Strings do
    begin
      Flag := TTraceFlag(GetEnumValue(Info, Str));
      Include(Result, Flag);
    end;
  finally
    Strings.Free;
  end;
end;

function TDBXTraceProperties.TraceFlagsToStr(Flags: TTraceFlags): string;
var
  Flag: TTraceFlag;
  Info: PTypeInfo;
begin
  Info := TypeInfo(TTraceFlag);
  Result := '';
  for Flag in Flags do
  begin
    if Result <> EmptyStr then
      Result := Result + ';';
    Result := Result + GetEnumName(Info,  Ord(Flag));
  end;
end;

{$IFDEF MSWINDOWS}
{ TDBXDebugStrTraceOutput }

procedure TDBXDebugStrTraceOutput.Open;
begin

end;

procedure TDBXDebugStrTraceOutput.WriteTraceln(Line: string);
begin
  if Line <> '' then
    OutputDebugString(Pointer(Line));
end;
{$ENDIF}

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXTraceDriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);

end.

