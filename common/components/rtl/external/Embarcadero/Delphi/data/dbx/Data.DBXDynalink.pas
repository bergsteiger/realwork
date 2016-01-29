{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXDynalink;

interface

uses
{$IFNDEF POSIX}
  Winapi.Windows,
{$ENDIF}
  Data.DBXCommon,
  Data.DBXPlatform,
  Data.FMTBcd,
  Data.SqlTimSt,
  Data.DBCommonTypes,
  Data.DBXClassRegistry,
  System.Classes,
  System.SysUtils
;


const

  MAX_VERSION_STRING_LENGTH = 128;


type
  TDBXHandle = Pointer;
  TPointer = Pointer;

  TDBXCommonHandle = TDBXHandle;
  TDBXTransactionHandle = TDBXHandle;
  TDBXDriverHandle = TDBXHandle;
  TDBXConnectionHandle = TDBXHandle;
  TDBXCommandHandle = TDBXHandle;
  TDBXMetaDataHandle = TDBXHandle;
  TDBXRowHandle = TDBXHandle;
  TDBXReaderHandle = TDBXHandle;
  TDBXWritableRowHandle = TDBXHandle;

  DBXCallbackHandle = TDBXHandle;

const
  SDYNALINK_LOADER_NAME = 'TDBXDynalinkDriverLoader'; { Do not resource }

{$IFDEF MACOS}
  SDBX_ADAPTER_NAME = 'libsqladapter.dylib';
{$ELSE}
  SDBX_ADAPTER_NAME = 'dbxadapter.dll';
{$ENDIF}

  SDBXLoader_GetDriver = 'DBXLoader_GetDriver';

  SDBXBase_GetErrorMessageLength = 'DBXBase_GetErrorMessageLength';
  SDBXBase_GetErrorMessage = 'DBXBase_GetErrorMessage';
  SDBXBase_Close = 'DBXBase_Close';

  SDBXRow_GetString = 'DBXRow_GetString';
  SDBXRow_GetWideString = 'DBXRow_GetWideString';
  SDBXRow_GetUInt8 = 'DBXRow_GetUInt8';
  SDBXRow_GetInt8 = 'DBXRow_GetInt8';
  SDBXRow_GetInt16 = 'DBXRow_GetInt16';
  SDBXRow_GetBoolean = 'DBXRow_GetBoolean';
  SDBXRow_GetInt32 = 'DBXRow_GetInt32';
  SDBXRow_GetInt64 = 'DBXRow_GetInt64';
  SDBXRow_GetSingle = 'DBXRow_GetSingle';
  SDBXRow_GetDouble = 'DBXRow_GetDouble';
  SDBXRow_GetBcd = 'DBXRow_GetBcd';
  SDBXRow_GetTimeStamp = 'DBXRow_GetTimeStamp';
  SDBXRow_GetTimeStampOffset = 'DBXRow_GetTimeStampOffset';
  SDBXRow_GetTime = 'DBXRow_GetTime';
  SDBXRow_GetDate = 'DBXRow_GetDate';
  SDBXRow_GetFixedBytes = 'DBXRow_GetFixedBytes';
  SDBXRow_GetBytes = 'DBXRow_GetBytes';
  SDBXRow_GetByteLength = 'DBXRow_GetByteLength';
  SDBXRow_GetObjectTypeName = 'DBXRow_GetObjectTypeName';

  SDBXWritableRow_SetNull = 'DBXWritableRow_SetNull';
  SDBXWritableRow_SetString = 'DBXWritableRow_SetString';
  SDBXWritableRow_SetWideString = 'DBXWritableRow_SetWideString';
  SDBXWritableRow_SetBoolean = 'DBXWritableRow_SetBoolean';
  SDBXWritableRow_SetUInt8 = 'DBXWritableRow_SetUInt8';
  SDBXWritableRow_SetInt8 = 'DBXWritableRow_SetInt8';
  SDBXWritableRow_SetInt16 = 'DBXWritableRow_SetInt16';
  SDBXWritableRow_SetInt32 = 'DBXWritableRow_SetInt32';
  SDBXWritableRow_SetInt64 = 'DBXWritableRow_SetInt64';
  SDBXWritableRow_SetSingle = 'DBXWritableRow_SetSingle';
  SDBXWritableRow_SetDouble = 'DBXWritableRow_SetDouble';
  SDBXWritableRow_SetBcd = 'DBXWritableRow_SetBcd';
  SDBXWritableRow_SetTimeStamp = 'DBXWritableRow_SetTimeStamp';
  SDBXWritableRow_SetTimeStampOffset = 'DBXWritableRow_SetTimeStampOffset';
  SDBXWritableRow_SetTime = 'DBXWritableRow_SetTime';
  SDBXWritableRow_SetDate = 'DBXWritableRow_SetDate';
  SDBXWritableRow_SetBytes = 'DBXWritableRow_SetBytes';
  SDBXWritableRow_SetBinary = 'DBXWritableRow_SetBinary';

  SDBXDriver_CreateConnection = 'DBXDriver_CreateConnection';
  SDBXDriver_GetVersion = 'DBXDriver_GetVersion';

  SDBXConnection_Connect = 'DBXConnection_Connect';
  SDBXConnection_Disconnect = 'DBXConnection_Disconnect';
  SDBXConnection_SetCallbackEvent = 'DBXConnection_SetCallbackEvent';
  SDBXConnection_CreateCommand = 'DBXConnection_CreateCommand';
  SDBXConnection_GetMetaData = 'DBXConnection_GetMetaData';
  SDBXConnection_BeginTransaction = 'DBXConnection_BeginTransaction';
  SDBXConnection_Commit = 'DBXConnection_Commit';
  SDBXConnection_Rollback = 'DBXConnection_Rollback';
  SDBXConnection_GetIsolation = 'DBXConnection_GetIsolation';
  SDBXConnection_GetVendorProperty = 'DBXConnection_GetVendorProperty';

  SDBXCommand_CreateParameterRow = 'DBXCommand_CreateParameterRow';
  SDBXCommand_Prepare = 'DBXCommand_Prepare';
  SDBXCommand_Execute = 'DBXCommand_Execute';
  SDBXCommand_ExecuteImmediate = 'DBXCommand_ExecuteImmediate';
  SDBXCommand_GetNextReader = 'DBXCommand_GetNextReader';
  SDBXCommand_GetRowsAffected = 'DBXCommand_GetRowsAffected';
  SDBXCommand_SetMaxBlobSize = 'DBXCommand_SetMaxBlobSize';
  SDBXCommand_SetRowSetSize = 'DBXCommand_SetRowSetSize';
  SDBXCommand_GetParameterCount = 'DBXCommand_GetParameterCount';
  SDBXCommand_GetParameterType = 'DBXCommand_GetParameterType';

  SDBXParameterRow_SetParameterType = 'DBXParameterRow_SetParameterType';

  SDBXReader_GetColumnCount = 'DBXReader_GetColumnCount';
  SDBXReader_GetColumnMetaData = 'DBXReader_GetColumnMetadata';
  SDBXReader_Next = 'DBXReader_Next';

  SDBXMetaData_GetMetaData = 'DBXMetaData_GetMetaData';

type
  TDBXDynalinkPropertyNames = class
  const
    BlobSize = 'BlobSize'; { Do not Resource }
    ErrorResourceFile = 'ErrorResourceFile'; { Do not Resource }
    LocaleCode = 'LocaleCode'; { Do not Resource }
    Compressed = 'Compressed'; { Do not Resource }
    Encrypted = 'Encrypted'; { Do not Resource }

  end;

  TDBXDynalinkDriverLoaderClass = class of TClassRegistryObject; // class of TObject;

  TInt32 = Integer;

  DBXTraceCallback = function(Handle: DBXCallbackHandle; TraceCategory: TInt32;
    TraceMessage: TDBXWideString): CBRType; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommon_GetErrorMessageLength = function(Handle: TDBXCommonHandle;
    LastErrorCode: TDBXErrorCode; out ErrorLen: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommon_GetErrorMessage = function(Handle: TDBXCommonHandle;
    LastErrorCode: TDBXErrorCode; ErrorMessage: TDBXWideStringBuilder)
    : TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommon_Close = function(Handle: TDBXCommonHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetString = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    Value: TDBXAnsiStringBuilder; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetWideString = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    Value: TDBXWideStringBuilder; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetBoolean = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: LongBool; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetUInt8 = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: Byte; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetInt8 = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: ShortInt; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetInt16 = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: SmallInt; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetInt32 = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: LongInt; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetInt64 = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: Int64; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetSingle = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: single; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetDouble = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: double; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetBcd = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: TBcd; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetTimeStamp = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: TSQLTimeStamp; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetTimeStampOffset = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: TSQLTimeStampOffset; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetTime = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: TDBXTime; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetDate = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Value: TDBXDate; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetBytes = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    Offset: Int64; Value: array of Byte; ValueOffset, Length: Int64;
    out ReturnLength: Int64; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetFixedBytes = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    const Value: array of Byte; ValueOffset: TInt32;
    out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetByteLength = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    out Length: Int64; out IsNull: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXRow_GetObjectTypeName = function(Handle: TDBXRowHandle; Ordinal: TInt32;
    Value: TDBXWideStringBuilder; MaxLength: Integer): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetNull = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetString = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; const Value: TDBXAnsiString; Length: Int64): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetWideString = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; const Value: TDBXWideString; Length: Int64): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetBoolean = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: LongBool): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetUInt8 = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: Byte): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetInt8 = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: ShortInt): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetInt16 = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: SmallInt): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetInt32 = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: LongInt): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetInt64 = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: Int64): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetSingle = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: single): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetDouble = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: double): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetBcd = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: TBcd): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetTimeStamp = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; var Value: TSQLTimeStamp): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetTimeStampOffset = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; var Value: TSQLTimeStampOffset): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetTime = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: TDBXTime): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetDate = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; Value: TDBXDate): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXWritableRow_SetBytes = function(Handle: TDBXWritableRowHandle;
    Ordinal: TInt32; BlobOffset: Int64; Value: TArray<Byte>; LastIndex: TInt32; { dummy to simulate native "open array" }
    ValueOffset: Int64; Length: Int64): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}

  TDBXLoader_GetDriver = function(Count: TInt32; Names: TWideStringArray;
    Values: TWideStringArray; ErrorMessage: TDBXWideStringBuilder;
    out pDriver: TDBXDriverHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}

  TDBXDriver_CreateConnection = function(Handle: TDBXDriverHandle;
    out pConn: TDBXConnectionHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXDriver_GetVersion = function(
    Handle: TDBXDriverHandle;
    Version: TDBXWideStringBuilder;
    MaxLength: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_Connect = function(Handle: TDBXConnectionHandle; Count: TInt32;
    Names, Values: TWideStringArray): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_Disconnect = function(Handle: TDBXConnectionHandle)
    : TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_SetCallbackEvent = function(Handle: TDBXConnectionHandle;
    CallbackHandle: DBXCallbackHandle; CallbackEvent: DBXTraceCallback)
    : TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_CreateCommand = function(Handle: TDBXConnectionHandle;
    const CommandType: TDBXWideString; out pCommand: TDBXCommandHandle)
    : TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_GetMetaData = function(Handle: TDBXConnectionHandle;
    out pMetaData: TDBXMetaDataHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_BeginTransaction = function(Handle: TDBXConnectionHandle;
    out TransactionHandle: TDBXTransactionHandle; IsolationLevel: TInt32)
    : TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_Commit = function(Handle: TDBXConnectionHandle;
    TransactionHandle: TDBXTransactionHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_Rollback = function(Handle: TDBXConnectionHandle;
    TransactionHandle: TDBXTransactionHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_GetIsolation = function(Handle: TDBXConnectionHandle;
    out IsolationLevel: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXConnection_GetVendorProperty = function(
  Handle: TDBXConnectionHandle;
  Name: TDBXWideString;
  Value: TDBXWideStringBuilder;
  MaxLength: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}

  TDBXCommand_CreateParameterRow = function(Handle: TDBXCommandHandle;
    out Parameters: TDBXRowHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_Prepare = function(Handle: TDBXCommandHandle;
    const SQL: TDBXWideString; Count: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_Execute = function(Handle: TDBXCommandHandle;
    out Reader: TDBXReaderHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_ExecuteImmediate = function(Handle: TDBXCommandHandle;
    const SQL: TDBXWideString; out Reader: TDBXReaderHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_GetNextReader = function(Handle: TDBXCommandHandle;
    out Reader: TDBXReaderHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_GetRowsAffected = function(Handle: TDBXCommandHandle;
    out Rows: Int64): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_SetMaxBlobSize = function(Handle: TDBXCommandHandle;
    MaxBlobSize: Int64): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_SetRowSetSize = function(Handle: TDBXCommandHandle;
    RowSetSize: Int64): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_GetParameterCount = function(Handle: TDBXCommandHandle;
    out ParameterCount: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXCommand_GetParameterType = function(Handle: TDBXCommandHandle;
    Ordinal: TInt32; out DBXType: TInt32; out DBXSubType: TInt32; out Size: Int64;
    out Precision: Int64; out Scale: TInt32; out Nullable: LongBool)
    : TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXParameterRow_SetParameterType = function(Handle: TDBXRowHandle;
    Ordinal: TInt32; const Name: TDBXWideString; ChildPosition: TInt32;
    ParamDirection: TDBXParameterDirection; DBXType: TInt32; DBXSubType: TInt32;
    Size: Int64; Precision: Int64; Scale: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXReader_GetColumnCount = function(Handle: TDBXReaderHandle;
    out ColumnCount: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXReader_GetColumnMetadata = function(Handle: TDBXReaderHandle;
    Ordinal: TInt32; Name: TDBXWideStringBuilder; out ColumnType: TInt32;
    out ColumnSubType: TInt32; out Length: TInt32; out Precision: TInt32;
    out Scale: TInt32; out flags: TInt32): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
  TDBXReader_Next = function(Handle: TDBXReaderHandle): TDBXErrorCode; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}

  TDBXMethodTable = class
  private
    procedure RaiseError(DBXContext: TDBXContext; DBXResult: TDBXErrorCode;
      DBXHandle: TDBXCommonHandle; AdditionalInfo: string); overload;
    procedure RaiseError(DBXContext: TDBXContext; DBXResult: TDBXErrorCode;
      DBXHandle: TDBXCommonHandle); overload;
  public
    FDBXLoader_GetDriver: TDBXLoader_GetDriver;

    FDBXBase_GetErrorMessageLength: TDBXCommon_GetErrorMessageLength;
    FDBXBase_GetErrorMessage: TDBXCommon_GetErrorMessage;
    FDBXBase_Close: TDBXCommon_Close;

    FDBXRow_GetString: TDBXRow_GetString;
    FDBXRow_GetWideString: TDBXRow_GetWideString;
    FDBXRow_GetBoolean: TDBXRow_GetBoolean;
    FDBXRow_GetUInt8: TDBXRow_GetUInt8;
    FDBXRow_GetInt8: TDBXRow_GetInt8;
    FDBXRow_GetInt16: TDBXRow_GetInt16;
    FDBXRow_GetInt32: TDBXRow_GetInt32;
    FDBXRow_GetInt64: TDBXRow_GetInt64;
    FDBXRow_GetSingle: TDBXRow_GetSingle;
    FDBXRow_GetDouble: TDBXRow_GetDouble;
    FDBXRow_GetBcd: TDBXRow_GetBcd;
    FDBXRow_GetTimeStamp: TDBXRow_GetTimeStamp;
    FDBXRow_GetTimeStampOffset: TDBXRow_GetTimeStampOffset;
    FDBXRow_GetTime: TDBXRow_GetTime;
    FDBXRow_GetDate: TDBXRow_GetDate;
    FDBXRow_GetFixedBytes: TDBXRow_GetFixedBytes;
    FDBXRow_GetByteLength: TDBXRow_GetByteLength;
    FDBXRow_GetBytes: TDBXRow_GetBytes;
    FDBXRow_GetObjectTypeName: TDBXRow_GetObjectTypeName;

    FDBXWritableRow_SetNull: TDBXWritableRow_SetNull;
    FDBXWritableRow_SetString: TDBXWritableRow_SetString;
    FDBXWritableRow_SetWideString: TDBXWritableRow_SetWideString;
    FDBXWritableRow_SetBoolean: TDBXWritableRow_SetBoolean;
    FDBXWritableRow_SetUInt8: TDBXWritableRow_SetUInt8;
    FDBXWritableRow_SetInt8: TDBXWritableRow_SetInt8;
    FDBXWritableRow_SetInt16: TDBXWritableRow_SetInt16;
    FDBXWritableRow_SetInt32: TDBXWritableRow_SetInt32;
    FDBXWritableRow_SetInt64: TDBXWritableRow_SetInt64;
    FDBXWritableRow_SetSingle: TDBXWritableRow_SetSingle;
    FDBXWritableRow_SetDouble: TDBXWritableRow_SetDouble;
    FDBXWritableRow_SetBcd: TDBXWritableRow_SetBcd;
    FDBXWritableRow_SetTimeStamp: TDBXWritableRow_SetTimeStamp;
    FDBXWritableRow_SetTimeStampOffset: TDBXWritableRow_SetTimeStampOffset;
    FDBXWritableRow_SetTime: TDBXWritableRow_SetTime;
    FDBXWritableRow_SetDate: TDBXWritableRow_SetDate;
    FDBXWritableRow_SetBytes: TDBXWritableRow_SetBytes;

    FDBXDriver_CreateConnection: TDBXDriver_CreateConnection;
    FDBXDriver_GetVersion: TDBXDriver_GetVersion;

    FDBXConnection_Connect: TDBXConnection_Connect;
    FDBXConnection_Disconnect: TDBXConnection_Disconnect;
    FDBXConnection_SetCallbackEvent: TDBXConnection_SetCallbackEvent;
    FDBXConnection_CreateCommand: TDBXConnection_CreateCommand;
    FDBXConnection_GetMetaData: TDBXConnection_GetMetaData;
    FDBXConnection_BeginTransaction: TDBXConnection_BeginTransaction;
    FDBXConnection_Commit: TDBXConnection_Commit;
    FDBXConnection_Rollback: TDBXConnection_Rollback;
    FDBXConnection_GetIsolation: TDBXConnection_GetIsolation;
    FDBXConnection_GetVendorProperty: TDBXConnection_GetVendorProperty;

    FDBXCommand_CreateParameterRow: TDBXCommand_CreateParameterRow;
    FDBXCommand_Prepare: TDBXCommand_Prepare;
    FDBXCommand_Execute: TDBXCommand_Execute;
    FDBXCommand_ExecuteImmediate: TDBXCommand_ExecuteImmediate;
    FDBXCommand_GetNextReader: TDBXCommand_GetNextReader;
    FDBXCommand_GetRowsAffected: TDBXCommand_GetRowsAffected;
    FDBXCommand_SetMaxBlobSize: TDBXCommand_SetMaxBlobSize;
    FDBXCommand_SetRowSetSize: TDBXCommand_SetRowSetSize;
    FDBXCommand_GetParameterCount: TDBXCommand_GetParameterCount;
    FDBXCommand_GetParameterType: TDBXCommand_GetParameterType;

    FDBXParameterRow_SetParameterType: TDBXParameterRow_SetParameterType;

    FDBXReader_GetColumnCount: TDBXReader_GetColumnCount;
    FDBXReader_GetColumnMetadata: TDBXReader_GetColumnMetadata;
    FDBXReader_Next: TDBXReader_Next;

    constructor Create;

    function LoadMethod(MethodName: string): TPointer; virtual; abstract;

    procedure LoadMethods; virtual; abstract;

  end;

  TDBXDynalinkReader = class(TDBXReader)
  private
    procedure CheckResult(DBXResult: TDBXErrorCode);
    constructor Create(DBXContext: TDBXContext; ReaderHandle: TDBXReaderHandle;
      MethodTable: TDBXMethodTable; ByteReader: TDBXByteReader);
  protected
    FReaderHandle: TDBXReaderHandle;
    FMethodTable: TDBXMethodTable;
    procedure DerivedClose; override;
    function DerivedNext: Boolean; override;

  end;

  TDBXDynalinkRow = class(TDBXRow)
  private
    FRowHandle: TDBXRowHandle;
    [Weak]FMethodTable: TDBXMethodTable;
    FTempBuffer: TArray<Byte>;
    procedure CheckResult(DBXResult: TDBXErrorCode);
    procedure CheckParameterResult(DBXResult: TDBXErrorCode; DbxValue: TDbxValue);
    procedure ParameterError(DBXResult: TDBXErrorCode; DbxValue: TDbxValue);

  protected
    constructor Create(DBXContext: TDBXContext; MethodTable: TDBXMethodTable;
      RowHandle: TDBXRowHandle);

    procedure GetAnsiString(DbxValue: TDBXAnsiStringValue;
      var AnsiStringVar: TDBXAnsiStringBuilder; var IsNull: LongBool); override;
    procedure GetWideString(DbxValue: TDBXWideStringValue;
      var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool); override;
    procedure GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool;
      var IsNull: LongBool); override;
    procedure GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
      var IsNull: LongBool); override;
    procedure GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
      var IsNull: LongBool); override;
    procedure GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
      var IsNull: LongBool); override;
    procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
      var IsNull: LongBool); override;
    procedure GetSingle(DbxValue: TDBXSingleValue; var Value: single;
      var IsNull: LongBool); override;
    procedure GetDouble(DbxValue: TDBXDoubleValue; var Value: double;
      var IsNull: LongBool); override;
    procedure GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd;
      var IsNull: LongBool); override;
    procedure GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate;
      var IsNull: LongBool); override;
    procedure GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime;
      var IsNull: LongBool); override;
    procedure GetTimeStamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp; var IsNull: LongBool); override;
    procedure GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
      var Value: TSQLTimeStampOffset; var IsNull: LongBool); override;
    procedure GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64;
      const Buffer: TArray<Byte>; BufferOffset, Length: Int64;
      var ReturnLength: Int64; var IsNull: LongBool); override;
    procedure GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64;
      var IsNull: LongBool); override;
    procedure GetStream(DbxValue: TDBXStreamValue; var Stream: TStream;
      var IsNull: LongBool); overload; override;
    procedure SetStream(DbxValue: TDBXStreamValue;
      StreamReader: TDBXStreamReader); overload; override;

    procedure SetNull(DbxValue: TDbxValue); override;
{$IFNDEF NEXTGEN}
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); override;
{$ELSE}
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: string); override;
{$ENDIF !NEXTGEN}
    procedure SetWideString(DbxValue: TDBXWideStringValue;
      const Value: string); override;
    procedure SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean); override;
    procedure SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte); override;
    procedure SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt); override;
    procedure SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt); override;
    procedure SetInt32(DbxValue: TDBXInt32Value; Value: TInt32); override;
    procedure SetInt64(DbxValue: TDBXInt64Value; Value: Int64); override;
    procedure SetSingle(DbxValue: TDBXSingleValue; Value: single); override;
    procedure SetDouble(DbxValue: TDBXDoubleValue; Value: double); override;

    procedure SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd); override;

    procedure SetDate(DbxValue: TDBXDateValue; Value: TDBXDate); override;
    procedure SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime); override;

    procedure SetTimestamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp); override;
    procedure SetTimestampOffset(DbxValue: TDBXTimeStampOffsetValue;
      var Value: TSQLTimeStampOffset); override;

    procedure SetDynamicBytes(DbxValue: TDbxValue; Offset: Int64;
      const Buffer: TArray<Byte>; BufferOffset: Int64; Count: Int64); override;
{$IFNDEF NEXTGEN}
    procedure SetAnsiMemo(DbxValue: TDBXAnsiMemoValue; const Value: AnsiString); override;
{$ENDIF !NEXTGEN}
    procedure SetWideMemo(DbxValue: TDBXWideMemoValue;
      const Value: string); override;

    function GetObjectTypeName(Ordinal: TInt32): string; override;

    procedure SetValueType(ValueType: TDBXValueType); override;
    procedure GetLength(DbxValue: TDbxValue; var ByteLength: Int64;
      var IsNull: LongBool); override;
  public
    destructor Destroy; override;
  end;

  TDBXDynalinkCommand = class(TDBXCommand)
  private
    FConnectionHandle: TDBXConnectionHandle;
    FCommandHandle: TDBXCommandHandle;
    [Weak]FMethodTable: TDBXMethodTable;

    procedure CheckResult(DBXResult: TDBXErrorCode);
    constructor Create(DBXContext: TDBXContext;
      ConnectionHandle: TDBXConnectionHandle; MethodTable: TDBXMethodTable);

  protected
    procedure SetRowSetSize(const RowSetSize: Int64); override;
    procedure SetMaxBlobSize(const MaxBlobSize: Int64); override;
    function GetRowsAffected: Int64; override;
    function CreateParameterRow: TDBXRow; override;

    function DerivedExecuteQuery: TDBXReader; override;
    procedure DerivedExecuteUpdate; override;
    procedure DerivedPrepare; override;
    procedure DerivedOpen; override;
    procedure DerivedClose; override;
  public
    destructor Destroy; override;
    function DerivedGetNextReader: TDBXReader; override;
  end;

  TDBXDynalinkByteReader = class(TDBXByteReader)
  private
    FReaderHandle: TDBXReaderHandle;
    [Weak]FMethodTable: TDBXMethodTable;
    constructor Create(DBXContext: TDBXContext; ReaderHandle: TDBXReaderHandle;
      MethodTable: TDBXMethodTable);
    procedure CheckResult(DBXResult: TDBXErrorCode);
  public
{$IFNDEF NEXTGEN}
    procedure GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>;
      Offset: TInt32; var IsNull: LongBool); override;
{$ENDIF !NEXTGEN}
    procedure GetWideString(Ordinal: TInt32; const Value: TArray<Byte>;
      Offset: TInt32; var IsNull: LongBool); override;
    procedure GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt32(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt64(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetSingle(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetDouble(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetBcd(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetTimeStampOffset(Ordinal: TInt32; const Value: TArray<Byte>;
      Offset: TInt32; var IsNull: LongBool); override;
    procedure GetTime(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetDate(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;

    procedure GetByteLength(Ordinal: TInt32; var Length: Int64;
      var IsNull: LongBool); override;
    function GetBytes(Ordinal: TInt32; Offset: Int64; const Value: TArray<Byte>;
      ValueOffset, Length: Int64; var IsNull: LongBool): Int64; override;

  end;

  TDBXDynalinkConnection = class;

  TDBXDynalinkTransaction = class(TDBXTransaction)
  private
    FTransactionHandle: TDBXTransactionHandle;
    constructor Create(Connection: TDBXDynalinkConnection;
      IsolationLevel: TDBXIsolation; TransactionHandle: TDBXTransactionHandle);
  end;

  TDBXDynalinkConnection = class(TDBXConnection)
  private
    FTraceCallback: DBXTraceCallback;

  protected
    FConnectionHandle: TDBXConnectionHandle;
    [Weak]FMethodTable: TDBXMethodTable;

    procedure CheckResult(DBXResult: TDBXErrorCode);
    function CreateAndBeginTransaction(const Isolation: TDBXIsolation): TDBXTransaction; override;
    procedure Commit(const InTransaction: TDBXTransaction); override;
    procedure Rollback(const InTransaction: TDBXTransaction); override;
    function DBXCallback(Handle: DBXCallbackHandle; TraceFlag: TDBXTraceFlag;
      TraceMessage: TDBXWideString): CBRType; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
    procedure SetTraceInfoEvent(const TraceInfoEvent: TDBXTraceEvent); override;
    procedure DerivedOpen; override;
    procedure DerivedGetCommandTypes(const List: TStrings); override;
    procedure DerivedGetCommands(const CommandType: string;
      const List: TStrings); override;
    procedure DerivedClose; override;

  public
    procedure Close; override;
    function GetVendorProperty(const Name: string): string; override;
    constructor Create(ConnectionBuilder: TDBXConnectionBuilder;
      ConnectionHandle: TDBXConnectionHandle; MethodTable: TDBXMethodTable);
  end;

  TDBXDynalinkDriverCommonLoaderClass = class of TDBXDynalinkDriverCommonLoader;

  TDBXDynalinkDriver = class(TDBXDriver)
  private
    FStringVersion: string;
    function CreateDynalinkCommand(DBXContext: TDBXContext;
      Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;

  strict protected
    FDriverHandle: TDBXDriverHandle;
    FMethodTable: TDBXMethodTable;
    FDriverLoaderClass: TDBXDynalinkDriverCommonLoaderClass;

    procedure CheckResult(DBXResult: TDBXErrorCode);
    procedure LoadDriver(DBXContext: TDBXContext);
  protected
    procedure Close; override;
  public
    constructor Create(Driver: TDBXDriver; DriverHandle: TDBXDriverHandle;
      MethodTable: TDBXMethodTable); overload;
    constructor Create(DBXDriverDef: TDBXDriverDef;
      DBXDriverLoader: TDBXDynalinkDriverCommonLoaderClass); overload;
    constructor Create(DBXDriverDef: TDBXDriverDef;
      DBXDriverLoader: TDBXDynalinkDriverCommonLoaderClass;
      DriverProps: TDBXProperties); overload;
    destructor Destroy; override;
    function GetDriverVersion: string; override;
  end;

  TDBXDynalinkDriverCommonLoader = class(TDBXDriverLoader)
  private
    procedure LoadDriverLibraryAndMethodTable(DBXContext: TDBXContext;
      Properties: TDBXProperties);
    procedure FreeOldLibrary;
  strict protected
    FLibraryHandle: HModule;
    FOldLibraryHandle: HModule;

    procedure LoadDriverLibrary(DriverProperties: TDBXProperties;
      DBXContext: TDBXContext); virtual;
    function CreateMethodTable: TDBXMethodTable; virtual; abstract;
    function CreateDynalinkDriver: TDBXDynalinkDriver; virtual; abstract;
  protected
    FMethodTable: TDBXMethodTable;
    FDriverHandle: TDBXDriverHandle;
  public
    constructor Create; override;
    function Load(DriverDef: TDBXDriverDef): TDBXDriver; override;
  end;

implementation

uses
  Data.DBXCommonResStrs,
  Data.DBXDynalinkNative
;

var
  DBXDynalinkDriverLoaderClass: TDBXDynalinkDriverLoaderClass;

{ TDBXDynalinkDriver }

procedure TDBXDynalinkDriver.CheckResult(DBXResult: TDBXErrorCode);
begin
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDBXContext, DBXResult, FDriverHandle, '');
end;

procedure TDBXDynalinkDriver.Close;
begin
  inherited;

end;

constructor TDBXDynalinkDriver.Create(Driver: TDBXDriver; DriverHandle: TDBXDriverHandle; MethodTable: TDBXMethodTable);
begin
  inherited Create;
  FMethodTable := MethodTable;
  FDriverHandle := DriverHandle;
  // '' makes this the default command factory.
  //
  AddCommandFactory('', CreateDynalinkCommand);
  if (DriverProperties = nil) or not DriverProperties.GetBoolean(TDBXPropertyNames.AutoUnloadDriver) then
    CacheUntilFinalization;
end;

constructor TDBXDynalinkDriver.Create(DBXDriverDef: TDBXDriverDef; DBXDriverLoader: TDBXDynalinkDriverCommonLoaderClass);
begin
  inherited Create(DBXDriverDef);
  FDriverLoaderClass := DBXDriverLoader;
  // '' makes this the default command factory.
  //
  AddCommandFactory('', CreateDynalinkCommand);
  if (DriverProperties = nil) or not DriverProperties.GetBoolean(TDBXPropertyNames.AutoUnloadDriver) then
    CacheUntilFinalization;
end;

constructor TDBXDynalinkDriver.Create(DBXDriverDef: TDBXDriverDef; DBXDriverLoader: TDBXDynalinkDriverCommonLoaderClass; DriverProps: TDBXProperties);
begin
  inherited Create;
  FDriverLoaderClass := DBXDriverLoader;
  // '' makes this the default command factory.
  //
  AddCommandFactory('', CreateDynalinkCommand);
  InitDriverProperties(DriverProps);
  if (DriverProperties = nil) or not DriverProperties.GetBoolean(TDBXPropertyNames.AutoUnloadDriver) then
    CacheUntilFinalization;
end;

function TDBXDynalinkDriver.CreateDynalinkCommand(DbxContext: TDBXContext;
  Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
begin
  Result := TDBXDynalinkCommand.Create(DbxContext, (TDBXDynalinkConnection(Connection).FConnectionHandle), FMethodTable);
end;

destructor TDBXDynalinkDriver.Destroy;
begin
  if FMethodTable <> nil then
    FMethodTable.FDBXBase_Close(FDriverHandle);
  FDriverHandle := nil;
  FreeAndNil(FMethodTable);
  inherited Destroy;
end;

function TDBXDynalinkDriver.GetDriverVersion: string;
var
  ErrorResult: TDBXErrorCode;
  StringVersionBuilder: TDBXWideStringBuilder;
begin
    LoadDriver(FDBXContext);

    StringVersionBuilder := TDBXPlatform.CreateWideStringBuilder(2*MAX_VERSION_STRING_LENGTH+1);
    try
      ErrorResult := FMethodTable.FDBXDriver_GetVersion(FDriverHandle, StringVersionBuilder, MAX_VERSION_STRING_LENGTH);
      CheckResult(ErrorResult);
      FStringVersion := TDBXPlatform.ToWideString(StringVersionBuilder);
    finally
      TDBXPlatform.FreeAndNilWideStringBuilder(StringVersionBuilder);
    end;
  Result := FStringVersion;

end;


procedure TDBXDynalinkDriver.LoadDriver(DBXContext: TDBXContext);
var
  Loader: TDBXDynalinkDriverCommonLoader;
begin
  if not Assigned(FMethodTable) then
  begin
    Loader := FDriverLoaderClass.Create;
    try
      Loader.LoadDriverLibraryAndMethodTable(DBXContext, GetDriverProperties);
      FMethodTable := Loader.FMethodTable;
      Loader.FMethodTable := nil;
      FDriverHandle := Loader.FDriverHandle;
      Loader.FreeOldLibrary;
    finally
      FreeAndNil(Loader.FMethodTable);
      Loader.Free;
    end;
  end;
end;

{ TDBXMethodTable }


constructor TDBXMethodTable.Create;
begin
  inherited Create;
end;

procedure TDBXMethodTable.RaiseError(DBXContext: TDBXContext;
DBXResult: TDBXErrorCode; DBXHandle: TDBXCommonHandle);
begin
  RaiseError(DBXContext, DBXResult, DBXHandle, '');
end;

procedure TDBXMethodTable.RaiseError(DBXContext: TDBXContext;
DBXResult: TDBXErrorCode; DBXHandle: TDBXCommonHandle;
AdditionalInfo: string);
var
  ErrorMessageBuilder: TDBXWideStringBuilder;
  ErrorMessage: string;
  Status: TDBXErrorCode;
  MessageLength: TInt32;
begin
  ErrorMessage := '';
  Status := FDBXBase_GetErrorMessageLength(DBXHandle, DBXResult, MessageLength);
  if(Status = TDBXErrorCodes.None) and(MessageLength > 0) then
  begin
    ErrorMessageBuilder := TDBXPlatform.CreateWideStringBuilder(MessageLength+1);
    try
      Status := FDBXBase_GetErrorMessage(DBXHandle, DBXResult, ErrorMessageBuilder);
      if(Status = TDBXErrorCodes.None) then
      begin
        ErrorMessage := TDBXPlatform.ToWideString(ErrorMessageBuilder);
      end;
    finally
      TDBXPlatform.FreeAndNilWideStringBuilder(ErrorMessageBuilder);
    end;
  end;
  if AdditionalInfo <> '' then
  begin
    DBXContext.Error(DBXResult, Format(SAdditionalInfo, [AdditionalInfo, ErrorMessage]));
  end else
  begin
    DBXContext.Error(DBXResult, ErrorMessage);
  end;

end;

{ TDBXDynalinkDriverLoader }

constructor TDBXDynalinkDriverCommonLoader.Create;
begin
  inherited;
  FLibraryHandle := HModule(0);
  FMethodTable   := nil;
  FDriverHandle  := nil;
  FLoaderName    := SDYNALINK_LOADER_NAME;
end;

procedure TDBXDynalinkDriverCommonLoader.LoadDriverLibraryAndMethodTable(
  DBXContext: TDBXContext; Properties: TDBXProperties);
var
  ErrorResult:          TDBXErrorCode;
  ErrorMessageBuilder:  TDBXWideStringBuilder;
  Count:                TInt32;
  Names:                TWideStringArray;
  Values:               TWideStringArray;
  ErrorMessage:         string;
begin
{$IFDEF MACOS}
  if Properties[TDBXPropertyNames.LibraryNameOsx] <> '' then
{$ELSE}
  if Properties[TDBXPropertyNames.LibraryName] <> '' then
{$ENDIF MACOS}
  begin
{$IF not (DEFINED(CPUARM) and DEFINED(IOS))}
    LoadDriverLibrary(Properties, DBXContext);
{$ENDIF not (CPUARM and IOS)}
    FMethodTable   := CreateMethodTable;
    try
      FMethodTable.LoadMethods;
    except
      on EDBXError: TDBXError do
        begin
          DBXContext.OnError(EDBXError);
          raise;
        end;
    end;
    Count := Properties.Properties.Count;
    Properties.GetLists(Names, Values);


    ErrorMessageBuilder := TDBXPlatform.CreateWideStringBuilder(256);
    try
      ErrorResult := FMethodTable.FDBXLoader_GetDriver(Count, Names, Values,
                                                       ErrorMessageBuilder,
                                                       FDriverHandle);

      if ErrorResult <> TDBXErrorCodes.None then
      begin
        TDBXPlatform.CopyWideStringBuilder(ErrorMessageBuilder, ErrorMessage);

        DBXContext.Error(ErrorResult, ErrorMessage);
      end;
    finally
       TDBXPlatform.FreeAndNilWideStringBuilder(ErrorMessageBuilder);
    end;
  end;
end;

procedure TDBXDynalinkDriverCommonLoader.FreeOldLibrary;
begin
    if FOldLibraryHandle <> 0 then
    begin
      FreeLibrary(FOldLibraryHandle);
      FOldLibraryHandle := 0;
    end;
end;

function TDBXDynalinkDriverCommonLoader.Load(DriverDef: TDBXDriverDef): TDBXDriver;
begin
  Result := nil;
{$IFDEF MACOS}
  if DriverDef.FDriverProperties[TDBXPropertyNames.LibraryNameOsx] <> '' then
{$ELSE}
  if DriverDef.FDriverProperties[TDBXPropertyNames.LibraryName] <> '' then
{$ENDIF}
  begin
    try
      LoadDriverLibraryAndMethodTable(DriverDef.FDBXContext, DriverDef.FDriverProperties);
      Result  := CreateDynalinkDriver;
      FreeOldLibrary;
      FMethodTable := nil;
    finally
      FreeAndNil(FMethodTable); // NO-OP if success because it is set to nil.
    end;
  end;
end;

procedure TDBXDynalinkDriverCommonLoader.LoadDriverLibrary(
  DriverProperties: TDBXProperties; DBXContext: TDBXContext);
var
  GetNewDriver:       THandle;
  LastError:          Integer;
  LibraryName:        string;
begin
{$IFDEF MACOS}
  LibraryName       := DriverProperties[TDBXPropertyNames.LibraryNameOsx];
{$ELSE}
  LibraryName       := DriverProperties[TDBXPropertyNames.LibraryName];
{$ENDIF}
  FLibraryHandle := LoadLibrary(MarshaledString(LibraryName));

  if FLibraryHandle = HModule(0) then
  begin
    LastError := GetLastError;
    DBXContext.Error(TDBXErrorCodes.DriverInitFailed, Format(sDLLLoadError, [LibraryName, LastError]));
  end;

  GetNewDriver := THandle(GetProcAddress(FLibraryHandle, SDBXLoader_GetDriver));

  if GetNewDriver = THandle(0) then
  begin
    FOldLibraryHandle := FLibraryHandle;
    FLibraryHandle := THandle(LoadLibrary(SDBX_ADAPTER_NAME));
    if FLibraryHandle = THandle(0) then
      DBXContext.Error(TDBXErrorCodes.DriverInitFailed, Format(sDLLLoadError, [SDBX_ADAPTER_NAME, GetLastError]));

    GetNewDriver := THandle(GetProcAddress(FLibraryHandle, SDBXLoader_GetDriver));

    if GetNewDriver = THandle(0) then
    begin
      FreeLibrary(FLibraryHandle);
      DBXContext.Error(TDBXErrorCodes.DriverInitFailed, Format(SDllProcLoadError, [SDBXLoader_GetDriver]));
    end;
  end;

end;

{ TDBXDynalinkConnection }

function TDBXDynalinkConnection.CreateAndBeginTransaction(
  const Isolation: TDBXIsolation): TDBXTransaction;
var
  TransactionHandle: TDBXTransactionHandle;
begin
  CheckResult(FMethodTable.FDBXConnection_BeginTransaction(FConnectionHandle, TransactionHandle, Integer(Isolation)));
  Result := TDBXDynalinkTransaction.Create(Self, Isolation, TransactionHandle);
end;

procedure TDBXDynalinkConnection.CheckResult(DBXResult: TDBXErrorCode);
begin
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDBXContext, DBXResult, FConnectionHandle, '');
end;

procedure TDBXDynalinkConnection.Close;
begin
  inherited Close;
  CheckResult(FMethodTable.FDBXBase_Close(FConnectionHandle));
  FConnectionHandle := nil;
end;

procedure TDBXDynalinkConnection.Commit(const InTransaction: TDBXTransaction);
var
  Transaction: TDBXDynalinkTransaction;
begin
  Transaction := TDBXDynalinkTransaction(InTransaction);
  CheckResult(FMethodTable.FDBXConnection_Commit(FConnectionHandle, Transaction.FTransactionHandle));
end;

procedure TDBXDynalinkConnection.Rollback(const InTransaction: TDBXTransaction);
var
  Transaction: TDBXDynalinkTransaction;
begin
  Transaction := TDBXDynalinkTransaction(InTransaction);
  CheckResult(FMethodTable.FDBXConnection_Rollback(FConnectionHandle, Transaction.FTransactionHandle));
end;

function NativeDBXCallback(Handle: DBXCallbackHandle;
 TraceCategory: TInt32; TraceMessage: TDBXWideString): CBRType; {$IFDEF POSIX} cdecl; {$ELSE} stdcall; {$ENDIF}
begin
  Result := TDBXDynalinkConnection(Handle).DBXCallback(nil, TraceCategory, TraceMessage);
end;

procedure TDBXDynalinkConnection.SetTraceInfoEvent(
  const TraceInfoEvent: TDBXTraceEvent);
var
  CallbackHandle:   DBXCallbackHandle;
begin
  inherited;
  if not Assigned(TraceInfoEvent) then
    CheckResult(FMethodTable.FDBXConnection_SetCallbackEvent(FConnectionHandle, nil, nil))
  else
  begin
    FTraceCallback   := NativeDBXCallback;
    CallbackHandle   := Self;
    CheckResult(FMethodTable.FDBXConnection_SetCallbackEvent(FConnectionHandle, CallbackHandle, FTraceCallback));
  end;
end;

function TDBXDynalinkConnection.DBXCallback(Handle: DBXCallbackHandle;
  TraceFlag: TDBXTraceFlag; TraceMessage: TDBXWideString): CBRType;
begin
  Result := FDBXContext.Trace(TraceFlag, TraceMessage);
end;

constructor TDBXDynalinkConnection.Create(
  ConnectionBuilder:        TDBXConnectionBuilder;
  ConnectionHandle:     TDBXConnectionHandle;
  MethodTable:          TDBXMethodTable);
begin
  inherited Create(ConnectionBuilder);
  FConnectionHandle := ConnectionHandle;
  FMethodTable      := MethodTable;
end;

procedure TDBXDynalinkConnection.DerivedClose;
begin
end;

procedure TDBXDynalinkConnection.DerivedGetCommands(const CommandType: string;
  const List: TStrings);
begin
end;

procedure TDBXDynalinkConnection.DerivedGetCommandTypes(const List: TStrings);
begin
end;

procedure TDBXDynalinkConnection.DerivedOpen;
var
  Count:          TInt32;
  Names:          TWideStringArray;
  Values:         TWideStringArray;
  IsolationLevel: Integer;
  DBXError:       TDBXErrorCode;
begin
  Count := FConnectionProperties.Properties.Count;
  FConnectionProperties.GetLists(Names, Values);

  CheckResult(FMethodTable.FDBXConnection_Connect(FConnectionHandle, Count, Names, Values));
  DBXError := FMethodTable.FDBXConnection_GetIsolation(FConnectionHandle, IsolationLevel);
  // Some drivers like mysql do not support isoalation level.
  //
  if DBXError = TDBXErrorCodes.NotSupported then
    IsolationLevel := TInt32(TDBXIsolations.DirtyRead)
  else
    CheckResult(DBXError);

  FIsolationLevel := TDBXIsolation(IsolationLevel);

end;

function TDBXDynalinkConnection.GetVendorProperty(const Name: string): string;
var
  ErrorResult: TDBXErrorCode;
  StringVersionBuilder: TDBXWideStringBuilder;
begin
  if Assigned(FMethodTable.FDBXConnection_GetVendorProperty) then
  begin
    StringVersionBuilder := TDBXPlatform.CreateWideStringBuilder(MAX_VERSION_STRING_LENGTH+1);
    try
      ErrorResult := FMethodTable.FDBXConnection_GetVendorProperty(FConnectionHandle, TDBXWideString(Name), (StringVersionBuilder), MAX_VERSION_STRING_LENGTH);
      if ErrorResult = TDBXErrorCodes.None then
        Result := TDBXPlatform.ToWideString(StringVersionBuilder)
      else
        Result := '';
    except
      Result := '';
    end;
    TDBXPlatform.FreeAndNilWideStringBuilder(StringVersionBuilder);
  end else
    Result := '';
end;

{ TDBXDynalinkCommand }

function TDBXDynalinkCommand.CreateParameterRow: TDBXRow;
var
  ParameterRowHandle: TDBXRowHandle;
begin
  if FCommandHandle = nil then
    Open;
  CheckResult(FMethodTable.FDBXCommand_CreateParameterRow(FCommandHandle, ParameterRowHandle));
  Result := TDBXDynalinkRow.Create(FDBXContext, FMethodTable, ParameterRowHandle);
end;


procedure TDBXDynalinkCommand.CheckResult(DBXResult: TDBXErrorCode);
begin
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDBXContext, DBXResult, FCommandHandle, '');
end;

destructor TDBXDynalinkCommand.Destroy;
begin
  Close;
  inherited Destroy;
end;

procedure TDBXDynalinkCommand.DerivedClose;
begin
  if FCommandHandle <> nil then
  begin
    CheckResult(FMethodTable.FDBXBase_Close(FCommandHandle));
    FCommandHandle := nil;
  end;
end;

constructor TDBXDynalinkCommand.Create(DBXContext: TDBXContext;
  ConnectionHandle: TDBXConnectionHandle;
  MethodTable: TDBXMethodTable);
begin
  inherited Create(DBXContext);
  FConnectionHandle  := ConnectionHandle;
  FMethodTable    := MethodTable;
end;


function TDBXDynalinkCommand.DerivedExecuteQuery: TDBXReader;
var
  ReaderHandle: TDBXReaderHandle;
  ByteReader: TDBXDynalinkByteReader;
begin
  ReaderHandle := nil;

  if FCommandHandle = nil then
    Open;

  // Cheaper than using the property access which will cause a parameter row
  // to be allocated.  Also allows delegate driver to delegate the ParameterRow.
  //
  if ((FParameters = nil) or (FParameters.Count = 0)) and (not isPrepared) then
    CheckResult(FMethodTable.FDBXCommand_ExecuteImmediate(FCommandHandle, TDBXWideString(GetText), ReaderHandle))
  else
    CheckResult(FMethodTable.FDBXCommand_Execute(FCommandHandle, ReaderHandle));
  if ReaderHandle = nil then
  begin
    Result := nil;
  end else begin
    ByteReader := TDBXDynalinkByteReader.Create(FDBXContext, ReaderHandle, FMethodTable);
    Result := TDBXDynalinkReader.Create(FDBXContext, ReaderHandle, FMethodTable, ByteReader);
  end;
end;

procedure TDBXDynalinkCommand.DerivedExecuteUpdate;
var
  ReaderHandle: TDBXReaderHandle;
begin
  // Cheaper than using the property access which will cause a parameter row
  // to be allocated.  Also allows delegate driver to delegate the ParameterRow.
  //
  if ((FParameters = nil) or (FParameters.Count = 0)) and (not isPrepared) then
    CheckResult(FMethodTable.FDBXCommand_ExecuteImmediate(FCommandHandle, TDBXWideString(GetText), ReaderHandle))
  else
    CheckResult(FMethodTable.FDBXCommand_Execute(FCommandHandle, ReaderHandle));
end;


function TDBXDynalinkCommand.DerivedGetNextReader: TDBXReader;
var
  ReaderHandle: TDBXReaderHandle;
  ByteReader: TDBXDynalinkByteReader;
  DBXResult: TDBXErrorCode;
begin
  Result := nil;
  DBXResult := FMethodTable.FDBXCommand_GetNextReader(FCommandHandle, ReaderHandle);
  if    (DBXResult <> TDBXErrorCodes.EOF)
    and (DBXResult <> TDBXErrorCodes.NotSupported)
    and (DBXResult <> TDBXErrorCodes.NoData) then
  begin
    CheckResult(DBXResult);
    ByteReader := TDBXDynalinkByteReader.Create(FDBXContext, ReaderHandle, FMethodTable);
    Result := TDBXDynalinkReader.Create(FDBXContext, ReaderHandle, FMethodTable, ByteReader);
  end;
end;

function TDBXDynalinkCommand.GetRowsAffected: Int64;
begin
  CheckResult(FMethodTable.FDBXCommand_GetRowsAffected(FCommandHandle, Result));
end;

procedure TDBXDynalinkCommand.DerivedOpen;
begin
  CheckResult(FMethodTable.FDBXConnection_CreateCommand(FConnectionHandle, TDBXWideString(CommandType), FCommandHandle));
end;

procedure TDBXDynalinkCommand.DerivedPrepare;
var
  Ordinal, ParameterCount, DataType, SubType, Scale: TInt32;
  Size, Precision: Int64;
  Nullable: LongBool;
  Parameter: TDBXParameter;
  StringVersionBuilder: TDBXWideStringBuilder;
begin
  CheckResult(FMethodTable.FDBXCommand_Prepare(FCommandHandle, TDBXWideString(GetText), Parameters.Count));
  StringVersionBuilder := TDBXPlatform.CreateWideStringBuilder(MAX_VERSION_STRING_LENGTH+1);
  if (Parameters.Count = 0) and Assigned(FMethodTable.FDBXCommand_GetParameterCount)
       and (FMethodTable.FDBXConnection_GetVendorProperty(FConnectionHandle, TDBXPropertyNames.SupportsParameterMetadata, StringVersionBuilder, 0) = TDBXErrorCodes.None) then
  begin
    CheckResult(FMethodTable.FDBXCommand_GetParameterCount(FCommandHandle, ParameterCount));
    if ParameterCount > 0 then
    begin
      Parameters.SetCount(ParameterCount);
      for Ordinal := 0 to ParameterCount - 1 do
      begin
        Parameter := CreateParameter;
        CheckResult(FMethodTable.FDBXCommand_GetParameterType(FCommandHandle, Ordinal,
                    DataType, SubType, Size, Precision, Scale, Nullable));
        Parameter.DataType := DataType;
        Parameter.SubType := SubType;
        Parameter.Size := Size;
        Parameter.Precision := Precision;
        Parameter.Scale := Scale;
        Parameter.Nullable := Nullable;
        Parameters.SetParameter(Ordinal, Parameter);
        TDBXDriverHelp.UpdateParameterType(Parameter);
      end;
    end;
  end;
  TDBXPlatform.FreeAndNilWideStringBuilder(StringVersionBuilder);
end;

procedure TDBXDynalinkCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
  Open;
  CheckResult(FMethodTable.FDBXCommand_SetMaxBlobSize(FCommandHandle, MaxBlobSize));
end;

procedure TDBXDynalinkCommand.SetRowSetSize(const RowSetSize: Int64);
begin
  Open;
  CheckResult(FMethodTable.FDBXCommand_SetRowSetSize(FCommandHandle, RowSetSize));
end;

{ TDBXDynalinkReader }

procedure TDBXDynalinkReader.CheckResult(DBXResult: TDBXErrorCode);
begin
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDBXContext, DBXResult, FReaderHandle, '');
end;

procedure TDBXDynalinkReader.DerivedClose;
begin
  if FReaderHandle <> nil then
  begin
    CheckResult(FMethodTable.FDBXBase_Close(FReaderHandle));
    FReaderHandle := nil;
  end;
end;

constructor TDBXDynalinkReader.Create(DBXContext: TDBXContext;
  ReaderHandle: TDBXReaderHandle; MethodTable: TDBXMethodTable; ByteReader: TDBXByteReader);
var
  Ordinal:            TInt32;
  Length:             TInt32;
  ColumnType:         TInt32;
  ColumnSubType:      TInt32;
  Precision:          TInt32;
  Scale:              TInt32;
  Flags:              TInt32;
  Column:             TDBXValueType;
  ColumnCount:        TInt32;
  Values:             TDBXWritableValueArray;
  NameStringBuilder:  TDBXWideStringBuilder;
  MaxIdentifier:      TInt32;
  Name:               string;
begin
  inherited Create(DBXContext, TDBXDynalinkRow.Create(DBXContext, MethodTable, ReaderHandle), ByteReader);
  FReaderHandle := ReaderHandle;
  FMethodTable  := MethodTable;
  CheckResult(FMethodTable.FDBXReader_GetColumnCount(ReaderHandle, ColumnCount));
  SetLength(Values, ColumnCount);

  MaxIdentifier := 255;
  NameStringBuilder := TDBXPlatform.CreateWideStringBuilder(MaxIdentifier+1);
  try
    for Ordinal := 0 to High(Values) do
    begin
      CheckResult(FMethodTable.FDBXReader_GetColumnMetadata(
          ReaderHandle, Ordinal, NameStringBuilder, ColumnType,
          ColumnSubType, Length, Precision, Scale, Flags));

      Column                := TDBXDriverHelp.CreateTDBXValueType(DBXContext);
      Column.DataType       := ColumnType;
      Column.SubType        := ColumnSubType;
      Column.Ordinal        := Ordinal;
      Column.Precision      := Precision;
      Column.Scale          := Scale;
      Column.Size           := Length;
      TDBXPlatform.CopyWideStringBuilder(NameStringBuilder, Name);
      Column.Name           := Name;
      Column.ValueTypeFlags := Flags;

      Values[Ordinal] := TDBXValue.CreateValue(FDBXContext, Column, FDbxRow, true);
    end;
  finally
    TDBXPlatform.FreeAndNilWideStringBuilder(NameStringBuilder);
  end;

  SetValues(Values);
end;

function TDBXDynalinkReader.DerivedNext: Boolean;
var
  DBXResult: TDBXErrorCode;
begin
  if FReaderHandle = nil then
    DBXResult := TDBXErrorCodes.NoData
  else
    DBXResult := FMethodTable.FDBXReader_Next(FReaderHandle);

  if DBXResult = TDBXErrorCodes.None then
  begin
    Result := true;
  end else if (DBXResult = TDBXErrorCodes.NoData) or (DBXResult = TDBXErrorCodes.EOF) then
  begin
    Result := false;
  end else
  begin
    Result := false;
    CheckResult(DBXResult);
  end;
end;

{ TDBXDynalinkTransaction }

constructor TDBXDynalinkTransaction.Create(Connection: TDBXDynalinkConnection; IsolationLevel: TDBXIsolation; TransactionHandle: TDBXTransactionHandle);
begin
  inherited Create(Connection);
  FIsolationLevel     := IsolationLevel;
  FTransactionHandle  := TransactionHandle;
end;

{ TDBXDynalinkByteReader }

procedure TDBXDynalinkByteReader.CheckResult(DBXResult: TDBXErrorCode);
begin
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDBXContext, DBXResult, FReaderHandle, '');
end;

constructor TDBXDynalinkByteReader.Create(DBXContext: TDBXContext;
  ReaderHandle: TDBXReaderHandle; MethodTable: TDBXMethodTable);
begin
  inherited Create(DBXContext);
  FReaderHandle := ReaderHandle;
  FMethodTable  := MethodTable;
end;

procedure TDBXDynalinkByteReader.GetBcd(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

function TDBXDynalinkByteReader.GetBytes(Ordinal: TInt32; Offset: Int64;
  const Value: TArray<Byte>; ValueOffset, Length: Int64; var IsNull: LongBool): Int64;
begin
  CheckResult(FMethodTable.FDBXRow_GetBytes(FReaderHandle,
                                            Ordinal,
                                            Offset,
                                            Value,
                                            ValueOffset,
                                            Length,
                                            Result,
                                            IsNull));
end;

{$IFNDEF NEXTGEN}
procedure TDBXDynalinkByteReader.GetAnsiString(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: Integer; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;
{$ENDIF !NEXTGEN}

procedure TDBXDynalinkByteReader.GetDate(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetDouble(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetInt16(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetInt32(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetInt64(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetSingle(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetByteLength(Ordinal: TInt32; var Length: Int64;
  var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetByteLength(FReaderHandle, Ordinal, Length, IsNull));
end;


procedure TDBXDynalinkByteReader.GetTime(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetTimeStampOffset(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

//If we add driver support for UInt16, implement this
procedure TDBXDynalinkByteReader.GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXDynalinkByteReader.GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

procedure TDBXDynalinkByteReader.GetWideString(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetFixedBytes(FReaderHandle, Ordinal,
                                            Value,
                                            Offset, IsNull));
end;

{ TDBXDynalinkRow }

procedure TDBXDynalinkRow.CheckResult(DBXResult: TDBXErrorCode);
begin
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDBXContext, DBXResult, FRowHandle, '');
end;

procedure TDBXDynalinkRow.ParameterError(DBXResult: TDBXErrorCode; DbxValue: TDbxValue);
begin
  if DBXResult = TDBXErrorCodes.UnsupportedFieldType then
  begin
    FMethodTable.RaiseError(FDBXContext, DBXResult, FRowHandle,
    Format(SInvalidDataType, [TDBXValueType.DataTypeName(DbxValue.ValueType.DataType)]));
  end else
    FMethodTable.RaiseError(FDBXContext, DBXResult, FRowHandle, '');

end;

procedure TDBXDynalinkRow.CheckParameterResult(DBXResult: TDBXErrorCode; DbxValue: TDbxValue);
begin
  if DBXResult <> TDBXErrorCodes.None then
    ParameterError(DBXResult, DbxValue);
end;

constructor TDBXDynalinkRow.Create(DBXContext: TDBXContext; MethodTable: TDBXMethodTable; RowHandle: TDBXRowHandle);
begin
  inherited Create(DBXContext);
  FRowHandle := RowHandle;
  FMethodTable        := MethodTable;
end;

destructor TDBXDynalinkRow.Destroy;
begin
  FTempBuffer := nil;
end;

procedure TDBXDynalinkRow.GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd;
  var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetBcd(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FdbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetByteLength(FRowHandle, DbxValue.ValueType.Ordinal, ByteLength, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetLength(DbxValue: TDBXValue;
  var ByteLength: Int64; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetByteLength(FRowHandle, DbxValue.ValueType.Ordinal, ByteLength, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetBytes(DbxValue: TDBXByteArrayValue;
  Offset: Int64; const Buffer: TArray<Byte>; BufferOffset, Length: Int64;
  var ReturnLength: Int64; var IsNull: LongBool);
begin
  CheckResult(FMethodTable.FDBXRow_GetBytes(FRowHandle, DbxValue.ValueType.Ordinal, Offset, Buffer, BufferOffset, Length, ReturnLength, IsNull));
end;

procedure TDBXDynalinkRow.GetSingle(DbxValue: TDBXSingleValue;
  var Value: Single; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetSingle(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
      FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetStream(DbxValue: TDBXStreamValue;
  var Stream: TStream; var IsNull: LongBool);
var
  ByteLength: Int64;
  ReturnLength: Int64;
  ByteBuffer: TArray<Byte>;
begin
  GetLength(DbxValue, ByteLength, IsNull);
  if not IsNull then
  begin
    SetLength(ByteBuffer, ByteLength);
    GetBytes(DbxValue, 0, ByteBuffer, 0, ByteLength, ReturnLength, IsNull);
    Stream := TBytesStream.Create(ByteBuffer);
  end;

end;

procedure TDBXDynalinkRow.SetSingle(DbxValue: TDBXSingleValue; Value: Single);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetSingle(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetStream(DbxValue: TDBXStreamValue;
  StreamReader: TDBXStreamReader);
var
  BufferSize, BytesRead, ReadBytes: Integer;
begin
  BufferSize := Length(FTempBuffer);
  try
    BytesRead := StreamReader.Size;
    if BytesRead < 0 then
    begin
      if BufferSize < 1024 then
      begin
        BufferSize := 1024;
        SetLength(FTempBuffer, BufferSize);
      end;
      BytesRead := 0;
      while not StreamReader.Eos do
      begin
        if BytesRead = BufferSize then
        begin
          if BufferSize < (32*1024) then
            Inc(BufferSize, BufferSize * 2)
          else
            Inc(BufferSize, (32*1024));
          SetLength(FTempBuffer, BufferSize);
        end;
        ReadBytes := StreamReader.Read(FTempBuffer, BytesRead, BufferSize - BytesRead);
        if ReadBytes > 0 then
        begin
          Inc(BytesRead, ReadBytes);
        end;
      end;
    end else
    begin
      if BytesRead > BufferSize then
        SetLength(FTempBuffer, BytesRead);
      StreamReader.Read(FTempBuffer, 0, BytesRead);
    end;
    SetDynamicBytes(DbxValue, 0, FTempBuffer, 0, BytesRead);
  finally
    if BufferSize > (64*1024) then
      FTempBuffer := nil;
  end;
end;

procedure TDBXDynalinkRow.GetBoolean(DbxValue: TDBXBooleanValue;
  var Value: LongBool; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetBoolean(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;


procedure TDBXDynalinkRow.GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetDate(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDBXContext, DBXResult, FRowHandle);
end;



procedure TDBXDynalinkRow.GetDouble(DbxValue: TDBXDoubleValue;
  var Value: Double; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetDouble(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
      FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetInt16(DbxValue: TDBXInt16Value;
  var Value: SmallInt; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetInt16(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetInt32(DbxValue: TDBXInt32Value;
  var Value: TInt32; var IsNull: LongBool);

var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetInt32(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetInt64(DbxValue: TDBXInt64Value;
  var Value: Int64; var IsNull: LongBool);

var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetInt64(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;


procedure TDBXDynalinkRow.GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
  var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetInt8(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

function TDBXDynalinkRow.GetObjectTypeName(Ordinal: TInt32): string;
var
  WideStringBuilder: TDBXWideStringBuilder;
  DBXResult: TDBXErrorCode;
  MaxLength: Integer;
begin
  MaxLength := 128;
  WideStringBuilder := TDBXPlatform.CreateWideStringBuilder(MaxLength);
  try
    DBXResult := FMethodTable.FDBXRow_GetObjectTypeName(FRowHandle, Ordinal, WideStringBuilder, MaxLength);
    if DBXResult <> TDBXErrorCodes.None then
      FMethodTable.RaiseError(FDBXContext, DBXResult, FRowHandle);
    Result := TDBXPlatform.ToWideString(WideStringBuilder);
  finally
      TDBXPlatform.FreeAndNilWideStringBuilder(WideStringBuilder);
  end;
end;

procedure TDBXDynalinkRow.GetAnsiString(DbxValue: TDBXAnsiStringValue; var AnsiStringVar: TDBXAnsiStringBuilder; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
    DBXResult := FMethodTable.FDBXRow_GetString(FRowHandle, DbxValue.ValueType.Ordinal, AnsiStringVar, IsNull);
    if DBXResult <> TDBXErrorCodes.None then
      FMethodTable.RaiseError(FDBXContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetTime(DbxValue: TDBXTimeValue;
  var Value: TDBXTime; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetTime(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
    if DBXResult <> TDBXErrorCodes.None then
      FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetTimeStamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetTimeStamp(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetTimeStampOffset(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
  var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetUInt8(FRowHandle, DbxValue.ValueType.Ordinal, Value, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDbxContext, DBXResult, FRowHandle);
end;

procedure TDBXDynalinkRow.GetWideString(DbxValue: TDBXWideStringValue; var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool);
var
  DBXResult: TDBXErrorCode;
begin
  DBXResult := FMethodTable.FDBXRow_GetWideString(FRowHandle, DbxValue.ValueType.Ordinal, WideStringBuilder, IsNull);
  if DBXResult <> TDBXErrorCodes.None then
    FMethodTable.RaiseError(FDBXContext, DBXResult, FRowHandle);
end;

{$IFNDEF NEXTGEN}
procedure TDBXDynalinkRow.SetAnsiMemo(DbxValue: TDBXAnsiMemoValue;
  const Value: AnsiString);
begin
  SetDynamicBytes(DbxValue, 0, TDBXPlatform.AnsiStrToBytes(Value), 0, Length(Value));
end;
{$ENDIF !NEXTGEN}

procedure TDBXDynalinkRow.SetWideMemo(DbxValue: TDBXWideMemoValue;
  const Value: string);
begin
  SetDynamicBytes(DbxValue, 0, TDBXPlatform.WideStrToBytes(Value), 0, Value.Length);
end;

procedure TDBXDynalinkRow.SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetBCD(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetBoolean(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetDynamicBytes(DbxValue: TDBXValue; Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Count: Int64);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetBytes(FRowHandle, DbxValue.ValueType.Ordinal, Offset, Buffer, Length(Buffer), {dummy to simulate native "open array"}
   BufferOffset, Count), DbxValue);
end;

procedure TDBXDynalinkRow.SetDate(DbxValue: TDBXDateValue; Value: TDBXDate);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetDate(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetDouble(DbxValue: TDBXDoubleValue; Value: Double);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetDouble(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetInt16(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetInt32(DbxValue: TDBXInt32Value; Value: TInt32);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetInt32(FRowHandle, DbxValue.ValueType.Ordinal, Value), DBXValue);
end;

procedure TDBXDynalinkRow.SetInt64(DbxValue: TDBXInt64Value; Value: Int64);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetInt64(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetInt8(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetNull(DbxValue: TDBXValue);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetNull(FRowHandle, DbxValue.ValueType.Ordinal), DBXValue);
end;

procedure TDBXDynalinkRow.SetValueType(ValueType: TDBXValueType);
begin
  CheckResult(FMethodTable.FDBXParameterRow_SetParameterType(FRowHandle,
    ValueType.Ordinal, TDBXWideString(ValueType.Name),
    ValueType.ChildPosition, ValueType.ParameterDirection, ValueType.DataType,
    ValueType.SubType, ValueType.Size, ValueType.Precision, ValueType.Scale));
end;

{$IFNDEF NEXTGEN}
procedure TDBXDynalinkRow.SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetString(FRowHandle, DbxValue.ValueType.Ordinal, TDBXAnsiString(Value), Length(Value)), DBXValue);
end;
{$ELSE}
procedure TDBXDynalinkRow.SetString(DbxValue: TDBXAnsiStringValue; const Value: string);
var
  M: TMarshaller;
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetString(FRowHandle, DbxValue.ValueType.Ordinal, M.AsAnsi(Value).ToPointer, Value.Length), DBXValue);
end;
{$ENDIF !NEXTGEN}

procedure TDBXDynalinkRow.SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetTime(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetTimestamp(DbxValue: TDBXTimeStampValue; var Value: TSQLTimeStamp);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetTimeStamp(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetTimestampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetTimeStampOffset(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetUInt8(FRowHandle, DbxValue.ValueType.Ordinal, Value), DbxValue);
end;

procedure TDBXDynalinkRow.SetWideString(DbxValue: TDBXWideStringValue; const Value: string);
begin
  CheckParameterResult(FMethodTable.FDBXWritableRow_SetWideString(FRowHandle, DbxValue.ValueType.Ordinal, TDBXWideString(Value), Value.Length), DbxValue);
end;

initialization
  DBXDynalinkDriverLoaderClass := TDBXDynalinkDriverLoader;
  TClassRegistry.GetClassRegistry
  .RegisterRegistryClass(SDYNALINK_LOADER_NAME, DBXDynalinkDriverLoaderClass);
finalization
  if DBXDynalinkDriverLoaderClass <> nil then
    TClassRegistry.GetClassRegistry
    .UnregisterClass(SDYNALINK_LOADER_NAME);
end.





























