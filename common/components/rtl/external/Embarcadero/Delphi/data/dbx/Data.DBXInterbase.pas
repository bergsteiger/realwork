{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DbxInterbase"'}    {Do not Localize}
unit Data.DbxInterbase;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxInterBaseReadOnlyMetaData, Data.DbxInterBaseMetaData;

type
  TDBXInterBaseProperties = class(TDBXProperties)
  strict private
    const StrServerCharSet = 'ServerCharSet';
    function GetDatabase: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetServerCharSet: string;
    procedure SetServerCharSet(const Value: string);
    procedure SetDatabase(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
  public
    constructor Create(DBXContext: TDBXContext); override;
  published
    property Database: string read GetDatabase write SetDatabase;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property ServerCharSet: string read GetServerCharSet write SetServerCharSet;
  end;

  TDBXInterBaseDriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
  end;

  TDBXIBToGoProperties = class(TDBXInterBaseProperties)
  public
    constructor Create(DBXContext: TDBXContext); override;
  end;

  TDBXIBToGoDriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
  end;

{$IF DEFINED(CPUARM) and DEFINED(IOS)}
  TDBXIBDriverLoader = class(TDBXDynalinkDriverLoader)
  strict protected
    function CreateMethodTable: TDBXMethodTable; override;
    function CreateDynalinkDriver: TDBXDynalinkDriver; override;
  end;

  TDBXIBMethodTable = class(TDBXNativeMethodTable)
  public
    procedure LoadMethods; override;
  end;
{$ENDIF CPUARM and IOS}

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils
{$IF DEFINED(CPUARM) and DEFINED(IOS)}
  , Data.FmtBcd,
  Data.SqlTimSt
{$ENDIF CPUARM and IOS}
;

const
  sDriverName = 'InterBase';
  sToGoDriverName = 'IBToGo';

{ TDBXInterBaseDriver }

constructor TDBXInterBaseDriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXInterBaseProperties;
  I, Index: Integer;
begin
  Props := TDBXInterBaseProperties.Create(DBXDriverDef.FDBXContext);
  if DBXDriverDef.FDriverProperties <> nil then
  begin
    for I := 0 to DBXDriverDef.FDriverProperties.Count - 1 do
    begin
      Index := Props.Properties.IndexOfName(DBXDriverDef.FDriverProperties.Properties.Names[I]);
      if Index > -1 then
        Props.Properties.Strings[Index] := DBXDriverDef.FDriverProperties.Properties.Strings[I];
    end;
    Props.AddUniqueProperties(DBXDriverDef.FDriverProperties.Properties);
    DBXDriverDef.FDriverProperties.AddUniqueProperties(Props.Properties);
  end;
  inherited Create(DBXDriverDef, TDBXDynalinkDriverLoader, Props);
end;

{ TDBXInterBaseProperties }

constructor TDBXInterBaseProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXInterbase';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXInterBaseDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXInterbaseMetaDataCommandFactory,DbxInterBaseDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXInterbaseMetaDataCommandFactory,Borland.Data.DbxInterBaseDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverINTERBASE';
  Values[TDBXPropertyNames.LibraryName] := 'dbxint.dll';
  Values[TDBXPropertyNames.LibraryNameOsx] := 'libsqlib.dylib';
  Values[TDBXPropertyNames.VendorLib] := 'gds32.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'ibclient64.dll';
  Values[TDBXPropertyNames.VendorLibOsx] := 'libgds.dylib';

  Values[TDBXPropertyNames.Database] := 'database.gdb';
  Values[TDBXPropertyNames.UserName] := 'sysdba';
  Values[TDBXPropertyNames.Password] := 'masterkey';


  Values[TDBXPropertyNames.Role] := 'RoleName';
  Values[TDBXPropertyNames.MaxBlobSize] := '-1';

  Values[TDBXPropertyNames.ErrorResourceFile] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';

  Values['ServerCharSet'] := '';
  Values['SQLDialect'] := '3';
  Values['CommitRetain'] := 'False';
  Values['WaitOnLocks'] := 'True';
  Values['TrimChar'] := 'False';
  Values['SEP'] := '';
  Values['DisplayDriverName'] := 'InterBase Server';
end;

function TDBXInterBaseProperties.GetDatabase: string;
begin
  Result := Values[TDBXPropertyNames.Database];
end;

function TDBXInterBaseProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXInterBaseProperties.GetServerCharSet: string;
begin
  Result := Values[StrServerCharSet];
end;

function TDBXInterBaseProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXInterBaseProperties.SetDatabase(const Value: string);
begin
  Values[TDBXPropertyNames.Database] := Value;
end;

procedure TDBXInterBaseProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXInterBaseProperties.SetServerCharSet(const Value: string);
begin
  Values[StrServerCharSet] := Value;
end;

procedure TDBXInterBaseProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

{ TDBXInterBaseToGoProperties }

constructor TDBXIBToGoProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.VendorLib] := 'ibtogo.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'ibtogo64.dll';
  Values[TDBXPropertyNames.VendorLibOsx] := 'libibtogo.dylib';
  Values[TDBXPropertyNames.AutoUnloadDriver] := 'True';
  Values['DisplayDriverName'] := 'IBLite/ToGo';
end;

{ TDBXInterBaseToGoDriver }

constructor TDBXIBToGoDriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXIBToGoProperties;
  I, Index: Integer;
begin
  Props := TDBXIBToGoProperties.Create(DBXDriverDef.FDBXContext);
  if DBXDriverDef.FDriverProperties <> nil then
  begin
    for I := 0 to DBXDriverDef.FDriverProperties.Count - 1 do
    begin
      Index := Props.Properties.IndexOfName(DBXDriverDef.FDriverProperties.Properties.Names[I]);
      if Index > -1 then
        Props.Properties.Strings[Index] := DBXDriverDef.FDriverProperties.Properties.Strings[I];
    end;
    Props.AddUniqueProperties(DBXDriverDef.FDriverProperties.Properties);
    DBXDriverDef.FDriverProperties.AddUniqueProperties(Props.Properties);
  end;
{$IF DEFINED(CPUARM) and DEFINED(IOS)}
  inherited Create(DBXDriverDef, TDBXIBDriverLoader, Props);
{$ELSE}
  inherited Create(DBXDriverDef, TDBXDynalinkDriverLoader, Props);
{$ENDIF CPUARM and IOS}
end;

{$IF DEFINED(CPUARM) and DEFINED(IOS)}
function DBXLoader_GetDriver(Count: TInt32; Names: TWideStringArray;
  Values: TWideStringArray; ErrorMessage: TDBXWideStringBuilder;
  out pDriver: TDBXDriverHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXLoader_GetDriver' dependency 'ibtogo', 'stdc++';

function DBXBase_GetErrorMessageLength(Handle: TDBXCommonHandle; LastErrorCode: TDBXErrorCode;
  out ErrorLen: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXBase_GetErrorMessageLength' dependency 'ibtogo', 'stdc++';

function DBXBase_GetErrorMessage(Handle: TDBXCommonHandle; LastErrorCode: TDBXErrorCode;
  ErrorMessage: TDBXWideStringBuilder): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXBase_GetErrorMessage' dependency 'ibtogo', 'stdc++';

function DBXBase_Close(Handle: TDBXCommonHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXBase_Close' dependency 'ibtogo', 'stdc++';

function DBXRow_GetString(Handle: TDBXRowHandle; Ordinal: TInt32;
  Value: TDBXAnsiStringBuilder; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetString' dependency 'ibtogo', 'stdc++';

function DBXRow_GetWideString(Handle: TDBXRowHandle; Ordinal: TInt32;
  Value: TDBXWideStringBuilder; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetWideString' dependency 'ibtogo', 'stdc++';

function DBXRow_GetBoolean(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: LongBool; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetBoolean' dependency 'ibtogo', 'stdc++';

function DBXRow_GetUInt8(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: Byte; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetUInt8' dependency 'ibtogo', 'stdc++';

function DBXRow_GetInt8(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: ShortInt; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetInt8' dependency 'ibtogo', 'stdc++';

function DBXRow_GetInt16(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: SmallInt; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetInt16' dependency 'ibtogo', 'stdc++';

function DBXRow_GetInt32(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: LongInt; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetInt32' dependency 'ibtogo', 'stdc++';

function DBXRow_GetInt64(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: Int64; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetInt64' dependency 'ibtogo', 'stdc++';

function DBXRow_GetSingle(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: single; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetSingle' dependency 'ibtogo', 'stdc++';

function DBXRow_GetDouble(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: double; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetDouble' dependency 'ibtogo', 'stdc++';

function DBXRow_GetBcd(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: TBcd; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetBcd' dependency 'ibtogo', 'stdc++';

function DBXRow_GetTimeStamp(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: TSQLTimeStamp; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetTimeStamp' dependency 'ibtogo', 'stdc++';

function DBXRow_GetTimeStampOffset(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: TSQLTimeStampOffset; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetTimeStampOffset' dependency 'ibtogo', 'stdc++';

function DBXRow_GetTime(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: TDBXTime; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetTime' dependency 'ibtogo', 'stdc++';

function DBXRow_GetDate(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Value: TDBXDate; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetDate' dependency 'ibtogo', 'stdc++';

function DBXRow_GetFixedBytes(Handle: TDBXRowHandle; Ordinal: TInt32;
  const Value: array of Byte; ValueOffset: TInt32; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetFixedBytes' dependency 'ibtogo', 'stdc++';

function DBXRow_GetByteLength(Handle: TDBXRowHandle; Ordinal: TInt32;
  out Length: Int64; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetByteLength' dependency 'ibtogo', 'stdc++';

function DBXRow_GetBytes(Handle: TDBXRowHandle; Ordinal: TInt32;
  Offset: Int64; Value: array of Byte; ValueOffset, Length: Int64;
  out ReturnLength: Int64; out IsNull: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetBytes' dependency 'ibtogo', 'stdc++';

function DBXRow_GetObjectTypeName(Handle: TDBXRowHandle; Ordinal: TInt32;
  Value: TDBXWideStringBuilder; MaxLength: Integer): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXRow_GetObjectTypeName' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetNull(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetNull' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetString(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; const Value: TDBXAnsiString; Length: Int64): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetString' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetWideString(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; const Value: TDBXWideString; Length: Int64): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetWideString' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetBoolean(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetBoolean' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetUInt8(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: Byte): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetUInt8' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetInt8(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: ShortInt): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetInt8' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetInt16(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: SmallInt): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetInt16' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetInt32(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: LongInt): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetInt32' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetInt64(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: Int64): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetInt64' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetSingle(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: Single): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetSingle' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetDouble(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: Double): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetDouble' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetBcd(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: TBcd): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetBcd' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetTimeStamp(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; var Value: TSQLTimeStamp): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetTimeStamp' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetTimeStampOffset(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; var Value: TSQLTimeStampOffset): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetTimeStampOffset' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetTime(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: TDBXTime): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetTime' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetDate(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; Value: TDBXDate): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetDate' dependency 'ibtogo', 'stdc++';

function DBXWritableRow_SetBytes(Handle: TDBXWritableRowHandle;
  Ordinal: TInt32; BlobOffset: Int64; Value: TArray<Byte>; LastIndex: TInt32;
  ValueOffset: Int64; Length: Int64): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXWritableRow_SetBytes' dependency 'ibtogo', 'stdc++';

function DBXDriver_CreateConnection(Handle: TDBXDriverHandle;
  out pConn: TDBXConnectionHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXDriver_CreateConnection' dependency 'ibtogo', 'stdc++';

function DBXDriver_GetVersion(Handle: TDBXDriverHandle; Version: TDBXWideStringBuilder;
  MaxLength: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXDriver_GetVersion' dependency 'ibtogo', 'stdc++';

function DBXConnection_Connect(Handle: TDBXConnectionHandle; Count: TInt32;
  Names, Values: TWideStringArray): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_Connect' dependency 'ibtogo', 'stdc++';

function DBXConnection_Disconnect(Handle: TDBXConnectionHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_Disconnect' dependency 'ibtogo', 'stdc++';

function DBXConnection_SetCallbackEvent(Handle: TDBXConnectionHandle; CallbackHandle: DBXCallbackHandle;
  CallbackEvent: DBXTraceCallback): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_SetCallbackEvent' dependency 'ibtogo', 'stdc++';

function DBXConnection_CreateCommand(Handle: TDBXConnectionHandle; const CommandType: TDBXWideString;
  out pCommand: TDBXCommandHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_CreateCommand' dependency 'ibtogo', 'stdc++';

function DBXConnection_BeginTransaction(Handle: TDBXConnectionHandle; out TransactionHandle: TDBXTransactionHandle;
  IsolationLevel: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_BeginTransaction' dependency 'ibtogo', 'stdc++';

function DBXConnection_Commit(Handle: TDBXConnectionHandle;
  TransactionHandle: TDBXTransactionHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_Commit' dependency 'ibtogo', 'stdc++';

function DBXConnection_Rollback(Handle: TDBXConnectionHandle;
  TransactionHandle: TDBXTransactionHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_Rollback' dependency 'ibtogo', 'stdc++';

function DBXConnection_GetIsolation(Handle: TDBXConnectionHandle;
  out IsolationLevel: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_GetIsolation' dependency 'ibtogo', 'stdc++';

function DBXConnection_GetVendorProperty(Handle: TDBXConnectionHandle; Name: TDBXWideString;
  Value: TDBXWideStringBuilder; MaxLength: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXConnection_GetVendorProperty' dependency 'ibtogo', 'stdc++';

function DBXCommand_CreateParameterRow(Handle: TDBXCommandHandle;
  out Parameters: TDBXRowHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_CreateParameterRow' dependency 'ibtogo', 'stdc++';

function DBXCommand_Prepare(Handle: TDBXCommandHandle;
  const SQL: TDBXWideString; Count: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_Prepare' dependency 'ibtogo', 'stdc++';

function DBXCommand_Execute(Handle: TDBXCommandHandle;
  out Reader: TDBXReaderHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_Execute' dependency 'ibtogo', 'stdc++';

function DBXCommand_ExecuteImmediate(Handle: TDBXCommandHandle;
  const SQL: TDBXWideString; out Reader: TDBXReaderHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_ExecuteImmediate' dependency 'ibtogo', 'stdc++';

function DBXCommand_GetNextReader(Handle: TDBXCommandHandle;
  out Reader: TDBXReaderHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_GetNextReader' dependency 'ibtogo', 'stdc++';

function DBXCommand_GetRowsAffected(Handle: TDBXCommandHandle;
  out Rows: Int64): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_GetRowsAffected' dependency 'ibtogo', 'stdc++';

function DBXCommand_SetMaxBlobSize(Handle: TDBXCommandHandle;
  MaxBlobSize: Int64): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_SetMaxBlobSize' dependency 'ibtogo', 'stdc++';

function DBXCommand_SetRowSetSize(Handle: TDBXCommandHandle;
  RowSetSize: Int64): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_SetRowSetSize' dependency 'ibtogo', 'stdc++';

function DBXCommand_GetParameterCount(Handle: TDBXCommandHandle;
  out ParameterCount: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_GetParameterCount' dependency 'ibtogo', 'stdc++';

function DBXCommand_GetParameterType(Handle: TDBXCommandHandle; Ordinal: TInt32;
  out DBXType: TInt32; out DBXSubType: TInt32; out Size: Int64; out Precision: Int64;
  out Scale: TInt32; out Nullable: LongBool): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXCommand_GetParameterType' dependency 'ibtogo', 'stdc++';

function DBXParameterRow_SetParameterType(Handle: TDBXRowHandle; Ordinal: TInt32;
  const Name: TDBXWideString; ChildPosition: TInt32; ParamDirection: TDBXParameterDirection;
  DBXType: TInt32; DBXSubType: TInt32; Size: Int64; Precision: Int64;
  Scale: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXParameterRow_SetParameterType' dependency 'ibtogo', 'stdc++';

function DBXReader_GetColumnCount(Handle: TDBXReaderHandle;
  out ColumnCount: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXReader_GetColumnCount' dependency 'ibtogo', 'stdc++';

function DBXReader_GetColumnMetadata(Handle: TDBXReaderHandle;
  Ordinal: TInt32; Name: TDBXWideStringBuilder; out ColumnType: TInt32;
  out ColumnSubType: TInt32; out Length: TInt32; out Precision: TInt32;
  out Scale: TInt32; out flags: TInt32): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXReader_GetColumnMetadata' dependency 'ibtogo', 'stdc++';

function DBXReader_Next(Handle: TDBXReaderHandle): TDBXErrorCode; cdecl; external 'libsqlib.a' name 'DBXReader_Next' dependency 'ibtogo', 'stdc++';

{ TDBXIBDriverLoader }

function TDBXIBDriverLoader.CreateMethodTable: TDBXMethodTable;
begin
  Result := TDBXIBMethodTable.Create(FLibraryHandle);
end;

function TDBXIBDriverLoader.CreateDynalinkDriver: TDBXDynalinkDriver;
begin
  Result := TDBXIBToGoDriver.Create(TDBXDriver(nil), FDriverHandle, FMethodTable);
end;

{ TDBXIBMethodTable }

procedure TDBXIBMethodTable.LoadMethods;
begin
  FDBXLoader_GetDriver :=               DBXLoader_GetDriver;
  FDBXBase_GetErrorMessageLength :=     DBXBase_GetErrorMessageLength;
  FDBXBase_GetErrorMessage :=           DBXBase_GetErrorMessage;
  FDBXBase_Close :=                     DBXBase_Close;

  FDBXRow_GetString :=                  DBXRow_GetString;
  FDBXRow_GetWideString :=              DBXRow_GetWideString;
  FDBXRow_GetBoolean :=                 DBXRow_GetBoolean;
  FDBXRow_GetUInt8 :=                   DBXRow_GetUInt8;
  FDBXRow_GetInt8 :=                    DBXRow_GetInt8;
  FDBXRow_GetInt16 :=                   DBXRow_GetInt16;
  FDBXRow_GetInt32 :=                   DBXRow_GetInt32;
  FDBXRow_GetInt64 :=                   DBXRow_GetInt64;
  FDBXRow_GetSingle :=                  DBXRow_GetSingle;
  FDBXRow_GetDouble :=                  DBXRow_GetDouble;
  FDBXRow_GetBcd :=                     DBXRow_GetBcd;
  FDBXRow_GetTimeStamp :=               DBXRow_GetTimeStamp;
  FDBXRow_GetTimeStampOffset :=         DBXRow_GetTimeStampOffset;
  FDBXRow_GetTime :=                    DBXRow_GetTime;
  FDBXRow_GetDate :=                    DBXRow_GetDate;
  FDBXRow_GetFixedBytes :=              DBXRow_GetFixedBytes;
  FDBXRow_GetByteLength :=              DBXRow_GetByteLength;
  FDBXRow_GetBytes :=                   DBXRow_GetBytes;
  FDBXRow_GetObjectTypeName :=          DBXRow_GetObjectTypeName;

  FDBXWritableRow_SetNull :=            DBXWritableRow_SetNull;
  FDBXWritableRow_SetString :=          DBXWritableRow_SetString;
  FDBXWritableRow_SetWideString :=      DBXWritableRow_SetWideString;
  FDBXWritableRow_SetBoolean :=         DBXWritableRow_SetBoolean;
  FDBXWritableRow_SetUInt8 :=           DBXWritableRow_SetUInt8;
  FDBXWritableRow_SetInt8 :=            DBXWritableRow_SetInt8;
  FDBXWritableRow_SetInt16 :=           DBXWritableRow_SetInt16;
  FDBXWritableRow_SetInt32 :=           DBXWritableRow_SetInt32;
  FDBXWritableRow_SetInt64 :=           DBXWritableRow_SetInt64;
  FDBXWritableRow_SetSingle :=          DBXWritableRow_SetSingle;
  FDBXWritableRow_SetDouble :=          DBXWritableRow_SetDouble;
  FDBXWritableRow_SetBcd :=             DBXWritableRow_SetBcd;
  FDBXWritableRow_SetTimeStamp :=       DBXWritableRow_SetTimeStamp;
  FDBXWritableRow_SetTimeStampOffset := DBXWritableRow_SetTimeStampOffset;
  FDBXWritableRow_SetTime :=            DBXWritableRow_SetTime;
  FDBXWritableRow_SetDate :=            DBXWritableRow_SetDate;
  FDBXWritableRow_SetBytes :=           DBXWritableRow_SetBytes;

  FDBXDriver_CreateConnection :=        DBXDriver_CreateConnection;
  FDBXDriver_GetVersion :=              DBXDriver_GetVersion;

  FDBXConnection_Connect :=             DBXConnection_Connect;
  FDBXConnection_Disconnect :=          DBXConnection_Disconnect;
  FDBXConnection_SetCallbackEvent :=    DBXConnection_SetCallbackEvent;
  FDBXConnection_CreateCommand :=       DBXConnection_CreateCommand;
  FDBXConnection_BeginTransaction :=    DBXConnection_BeginTransaction;
  FDBXConnection_Commit :=              DBXConnection_Commit;
  FDBXConnection_Rollback :=            DBXConnection_Rollback;
  FDBXConnection_GetIsolation :=        DBXConnection_GetIsolation;
  // Ok if not implemented.
  //
  FDBXConnection_GetVendorProperty :=   DBXConnection_GetVendorProperty;

  FDBXCommand_CreateParameterRow :=     DBXCommand_CreateParameterRow;
  FDBXCommand_Prepare :=                DBXCommand_Prepare;
  FDBXCommand_Execute :=                DBXCommand_Execute;
  FDBXCommand_ExecuteImmediate :=       DBXCommand_ExecuteImmediate;
  FDBXCommand_GetNextReader :=          DBXCommand_GetNextReader;
  FDBXCommand_GetRowsAffected :=        DBXCommand_GetRowsAffected;
  FDBXCommand_SetMaxBlobSize :=         DBXCommand_SetMaxBlobSize;
  FDBXCommand_SetRowSetSize :=          DBXCommand_SetRowSetSize;

  FDBXCommand_GetParameterCount :=      DBXCommand_GetParameterCount;
  FDBXCommand_GetParameterType :=       DBXCommand_GetParameterType;

  FDBXParameterRow_SetParameterType :=  DBXParameterRow_SetParameterType;

  FDBXReader_GetColumnCount :=          DBXReader_GetColumnCount;
  FDBXReader_GetColumnMetadata :=       DBXReader_GetColumnMetadata;
  FDBXReader_Next :=                    DBXReader_Next;
end;
{$ENDIF CPUARM and IOS}

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXInterBaseDriver);
  TDBXDriverRegistry.RegisterDriverClass(sToGoDriverName, TDBXIBToGoDriver);

end.
