{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxInterbase;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DBXInterbaseReadOnlyMetaData, Data.DBXInterbaseMetaData;

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

{$IF (DEFINED(CPUARM) and DEFINED(IOS)) or DEFINED(ANDROID)}
  TDBXIBDriverLoader = class(TDBXDynalinkDriverLoader)
  strict protected
    function CreateMethodTable: TDBXMethodTable; override;
    function CreateDynalinkDriver: TDBXDynalinkDriver; override;
  end;

  TDBXIBMethodTable = class(TDBXNativeMethodTable)
  public
    procedure LoadMethods; override;
  end;
{$ENDIF (CPUARM and IOS) or ANDROID}

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils
{$IF (DEFINED(CPUARM) and DEFINED(IOS)) or DEFINED(ANDROID)}
  , Data.FmtBcd,
  Data.SqlTimSt
{$ENDIF (CPUARM and IOS) or ANDROID}
{$IFDEF ANDROID}
  , Posix.Stdlib,
  System.IOUtils
{$ENDIF}
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
{$IF (DEFINED(CPUARM) and DEFINED(IOS)) or DEFINED(ANDROID)}
  inherited Create(DBXDriverDef, TDBXIBDriverLoader, Props);
{$ELSE}
  inherited Create(DBXDriverDef, TDBXDynalinkDriverLoader, Props);
{$ENDIF (CPUARM and IOS) or ANDROID}
end;

{$IF (DEFINED(CPUARM) and DEFINED(IOS)) or DEFINED(ANDROID)}
const
  LibName      = 'libsqlib.a';
  VendorLib    = 'ibtogo';
  VendorLibDep = 'stdc++';

function DBXLoader_GetDriver(Count: Longint; Names: TWideStringArray;
  Values: TWideStringArray; ErrorMessage: TDBXWideStringBuilder;
  out pDriver: TDBXDriverHandle): TDBXErrorCode; cdecl; external LibName name 'DBXLoader_GetDriver' dependency VendorLib, LibCPP, VendorLibDep;

function DBXBase_GetErrorMessageLength(Handle: TDBXCommonHandle; LastErrorCode: TDBXErrorCode;
  out ErrorLen: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXBase_GetErrorMessageLength' dependency VendorLib, LibCPP, VendorLibDep;

function DBXBase_GetErrorMessage(Handle: TDBXCommonHandle; LastErrorCode: TDBXErrorCode;
  ErrorMessage: TDBXWideStringBuilder): TDBXErrorCode; cdecl; external LibName name 'DBXBase_GetErrorMessage' dependency VendorLib, LibCPP, VendorLibDep;

function DBXBase_Close(Handle: TDBXCommonHandle): TDBXErrorCode; cdecl; external LibName name 'DBXBase_Close' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetString(Handle: TDBXRowHandle; Ordinal: Longint;
  Value: TDBXAnsiStringBuilder; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetString' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetWideString(Handle: TDBXRowHandle; Ordinal: Longint;
  Value: TDBXWideStringBuilder; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetWideString' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetBoolean(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: LongBool; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetBoolean' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetUInt8(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: Byte; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetUInt8' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetInt8(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: ShortInt; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetInt8' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetInt16(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: SmallInt; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetInt16' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetInt32(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: LongInt; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetInt32' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetInt64(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: Int64; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetInt64' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetSingle(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: single; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetSingle' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetDouble(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: double; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetDouble' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetBcd(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: TBcd; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetBcd' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetTimeStamp(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: TSQLTimeStamp; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetTimeStamp' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetTimeStampOffset(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: TSQLTimeStampOffset; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetTimeStampOffset' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetTime(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: TDBXTime; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetTime' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetDate(Handle: TDBXRowHandle; Ordinal: Longint;
  out Value: TDBXDate; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetDate' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetFixedBytes(Handle: TDBXRowHandle; Ordinal: Longint;
  const Value: array of Byte; ValueOffset: Longint; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetFixedBytes' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetByteLength(Handle: TDBXRowHandle; Ordinal: Longint;
  out Length: Int64; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetByteLength' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetBytes(Handle: TDBXRowHandle; Ordinal: Longint;
  Offset: Int64; Value: array of Byte; ValueOffset, Length: Int64;
  out ReturnLength: Int64; out IsNull: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetBytes' dependency VendorLib, LibCPP, VendorLibDep;

function DBXRow_GetObjectTypeName(Handle: TDBXRowHandle; Ordinal: Longint;
  Value: TDBXWideStringBuilder; MaxLength: Integer): TDBXErrorCode; cdecl; external LibName name 'DBXRow_GetObjectTypeName' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetNull(Handle: TDBXWritableRowHandle;
  Ordinal: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetNull' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetString(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; const Value: TDBXAnsiString; Length: Int64): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetString' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetWideString(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; const Value: TDBXWideString; Length: Int64): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetWideString' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetBoolean(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetBoolean' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetUInt8(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: Byte): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetUInt8' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetInt8(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: ShortInt): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetInt8' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetInt16(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: SmallInt): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetInt16' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetInt32(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: LongInt): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetInt32' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetInt64(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: Int64): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetInt64' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetSingle(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: Single): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetSingle' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetDouble(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: Double): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetDouble' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetBcd(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: TBcd): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetBcd' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetTimeStamp(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; var Value: TSQLTimeStamp): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetTimeStamp' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetTimeStampOffset(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; var Value: TSQLTimeStampOffset): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetTimeStampOffset' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetTime(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: TDBXTime): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetTime' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetDate(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; Value: TDBXDate): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetDate' dependency VendorLib, LibCPP, VendorLibDep;

function DBXWritableRow_SetBytes(Handle: TDBXWritableRowHandle;
  Ordinal: Longint; BlobOffset: Int64; Value: TArray<Byte>; LastIndex: Longint;
  ValueOffset: Int64; Length: Int64): TDBXErrorCode; cdecl; external LibName name 'DBXWritableRow_SetBytes' dependency VendorLib, LibCPP, VendorLibDep;

function DBXDriver_CreateConnection(Handle: TDBXDriverHandle;
  out pConn: TDBXConnectionHandle): TDBXErrorCode; cdecl; external LibName name 'DBXDriver_CreateConnection' dependency VendorLib, LibCPP, VendorLibDep;

function DBXDriver_GetVersion(Handle: TDBXDriverHandle; Version: TDBXWideStringBuilder;
  MaxLength: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXDriver_GetVersion' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_Connect(Handle: TDBXConnectionHandle; Count: Longint;
  Names, Values: TWideStringArray): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_Connect' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_Disconnect(Handle: TDBXConnectionHandle): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_Disconnect' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_SetCallbackEvent(Handle: TDBXConnectionHandle; CallbackHandle: DBXCallbackHandle;
  CallbackEvent: DBXTraceCallback): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_SetCallbackEvent' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_CreateCommand(Handle: TDBXConnectionHandle; const CommandType: TDBXWideString;
  out pCommand: TDBXCommandHandle): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_CreateCommand' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_BeginTransaction(Handle: TDBXConnectionHandle; out TransactionHandle: TDBXTransactionHandle;
  IsolationLevel: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_BeginTransaction' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_Commit(Handle: TDBXConnectionHandle;
  TransactionHandle: TDBXTransactionHandle): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_Commit' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_Rollback(Handle: TDBXConnectionHandle;
  TransactionHandle: TDBXTransactionHandle): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_Rollback' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_GetIsolation(Handle: TDBXConnectionHandle;
  out IsolationLevel: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_GetIsolation' dependency VendorLib, LibCPP, VendorLibDep;

function DBXConnection_GetVendorProperty(Handle: TDBXConnectionHandle; Name: TDBXWideString;
  Value: TDBXWideStringBuilder; MaxLength: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXConnection_GetVendorProperty' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_CreateParameterRow(Handle: TDBXCommandHandle;
  out Parameters: TDBXRowHandle): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_CreateParameterRow' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_Prepare(Handle: TDBXCommandHandle;
  const SQL: TDBXWideString; Count: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_Prepare' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_Execute(Handle: TDBXCommandHandle;
  out Reader: TDBXReaderHandle): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_Execute' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_ExecuteImmediate(Handle: TDBXCommandHandle;
  const SQL: TDBXWideString; out Reader: TDBXReaderHandle): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_ExecuteImmediate' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_GetNextReader(Handle: TDBXCommandHandle;
  out Reader: TDBXReaderHandle): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_GetNextReader' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_GetRowsAffected(Handle: TDBXCommandHandle;
  out Rows: Int64): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_GetRowsAffected' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_SetMaxBlobSize(Handle: TDBXCommandHandle;
  MaxBlobSize: Int64): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_SetMaxBlobSize' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_SetRowSetSize(Handle: TDBXCommandHandle;
  RowSetSize: Int64): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_SetRowSetSize' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_GetParameterCount(Handle: TDBXCommandHandle;
  out ParameterCount: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_GetParameterCount' dependency VendorLib, LibCPP, VendorLibDep;

function DBXCommand_GetParameterType(Handle: TDBXCommandHandle; Ordinal: Longint;
  out DBXType: Longint; out DBXSubType: Longint; out Size: Int64; out Precision: Int64;
  out Scale: Longint; out Nullable: LongBool): TDBXErrorCode; cdecl; external LibName name 'DBXCommand_GetParameterType' dependency VendorLib, LibCPP, VendorLibDep;

function DBXParameterRow_SetParameterType(Handle: TDBXRowHandle; Ordinal: Longint;
  const Name: TDBXWideString; ChildPosition: Longint; ParamDirection: TDBXParameterDirection;
  DBXType: Longint; DBXSubType: Longint; Size: Int64; Precision: Int64;
  Scale: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXParameterRow_SetParameterType' dependency VendorLib, LibCPP, VendorLibDep;

function DBXReader_GetColumnCount(Handle: TDBXReaderHandle;
  out ColumnCount: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXReader_GetColumnCount' dependency VendorLib, LibCPP, VendorLibDep;

function DBXReader_GetColumnMetadata(Handle: TDBXReaderHandle;
  Ordinal: Longint; Name: TDBXWideStringBuilder; out ColumnType: Longint;
  out ColumnSubType: Longint; out Length: Longint; out Precision: Longint;
  out Scale: Longint; out flags: Longint): TDBXErrorCode; cdecl; external LibName name 'DBXReader_GetColumnMetadata' dependency VendorLib, LibCPP, VendorLibDep;

function DBXReader_Next(Handle: TDBXReaderHandle): TDBXErrorCode; cdecl; external LibName name 'DBXReader_Next' dependency VendorLib, LibCPP, VendorLibDep;

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
{$ENDIF (CPUARM and IOS) or ANDROID}

{$IFDEF ANDROID}
procedure SetInterBaseVariable;
var
  M: TMarshaller;
begin
  setenv('INTERBASE', M.AsUtf8(TPath.GetDocumentsPath + PathDelim + 'interbase').ToPointer, 1);
end;
{$ENDIF}

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXInterBaseDriver);
  TDBXDriverRegistry.RegisterDriverClass(sToGoDriverName, TDBXIBToGoDriver);
{$IFDEF ANDROID}
  SetInterBaseVariable;
{$ENDIF}
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);
  TDBXDriverRegistry.UnloadDriver(sToGoDriverName);

end.
