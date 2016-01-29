{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXDynalinkNative;

interface

uses
  Data.DBXCommon,
  Data.DBXDynalink
;

type

  TDBXDynalinkDriverLoader = class(TDBXDynalinkDriverCommonLoader)
  strict protected
    // procedure LoadDriverLibrary(DriverProperties: TDBXProperties; DBXContext: TDBXContext); override;
    function CreateMethodTable: TDBXMethodTable; override;
    function CreateDynalinkDriver: TDBXDynalinkDriver; override;
  end;

  TGetDriverFunc = function(SVendorLib, SResourceFile: PChar; out Obj): TDBXErrorCode; stdcall;

  TDBXDynalinkDriverNative = class(TDBXDynalinkDriver)
  protected
    function CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection; override;
  public
    constructor Create(DriverClone: TDBXDriver; DriverHandle: TDBXDriverHandle;
                       MethodTable: TDBXMethodTable); overload;
    constructor Create(DBXDriverDef: TDBXDriverDef;
                       DBXDriverLoader: TDBXDynalinkDriverCommonLoaderClass); overload;
    constructor Create(DBXDriverDef: TDBXDriverDef;
                       DBXDriverLoader: TDBXDynalinkDriverCommonLoaderClass;
                       DriverProps: TDBXProperties); overload;
  end;

  TDBXNativeMethodTable = class(TDBXMethodTable)
  private
    FLibraryHandle: THandle;
  public
    constructor Create(LibraryHandle: THandle);
    destructor Destroy; override;
    procedure LoadMethods; override;
    function LoadMethod(MethodName: string): TPointer; override;

  end;


implementation

uses
{$IFNDEF POSIX}
  Winapi.Windows,
{$ENDIF not POSIX}
  System.SysUtils,
  Data.DBXCommonResStrs
;


{ TDBXDynalinkDriverNative }

constructor TDBXDynalinkDriverNative.Create(DriverClone: TDBXDriver; DriverHandle: TDBXDriverHandle; MethodTable: TDBXMethodTable);
begin
  inherited Create(DriverClone, DriverHandle, MethodTable);
end;

constructor TDBXDynalinkDriverNative.Create(DBXDriverDef: TDBXDriverDef; DBXDriverLoader: TDBXDynalinkDriverCommonLoaderClass);
begin
  inherited Create(DBXDriverDef, DBXDriverLoader);
end;

constructor TDBXDynalinkDriverNative.Create(DBXDriverDef: TDBXDriverDef; DBXDriverLoader: TDBXDynalinkDriverCommonLoaderClass; DriverProps: TDBXProperties);
begin
  inherited Create(DBXDriverDef, DBXDriverLoader, DriverProps);
end;

function TDBXDynalinkDriverNative.CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
var
  ConnectionHandle: TDBXConnectionHandle;
  ErrorResult:  TDBXErrorCode;
begin
  LoadDriver(ConnectionBuilder.DbxContext);
  ErrorResult := FMethodTable.FDBXDriver_CreateConnection(FDriverHandle, ConnectionHandle);
  CheckResult(ErrorResult);
  Result := TDBXDynalinkConnection.Create(ConnectionBuilder, ConnectionHandle, FMethodTable);
end;

{ DBXDriverLoader }

function TDBXDynalinkDriverLoader.CreateDynalinkDriver: TDBXDynalinkDriver;
begin
  Result := TDBXDynalinkDriverNative.Create(TDBXDriver(nil), FDriverHandle, FMethodTable);

end;

function TDBXDynalinkDriverLoader.CreateMethodTable: TDBXMethodTable;
begin
  Result := TDBXNativeMethodTable.Create(FLibraryHandle);
end;

{ TDBXNativeMethodTable }

constructor TDBXNativeMethodTable.Create(LibraryHandle: THandle);
begin
  FLibraryHandle := LibraryHandle;
  inherited Create;
end;

destructor TDBXNativeMethodTable.Destroy;
begin
  FreeLibrary(FLibraryHandle);
  FLibraryHandle := 0;
  inherited;
end;

procedure TDBXNativeMethodTable.LoadMethods;
begin
  FDBXLoader_GetDriver :=             LoadMethod(SDBXLoader_GetDriver);
  FDBXBase_GetErrorMessageLength :=   LoadMethod(SDBXBase_GetErrorMessageLength);
  FDBXBase_GetErrorMessage :=         LoadMethod(SDBXBase_GetErrorMessage);
  FDBXBase_Close :=                   LoadMethod(SDBXBase_Close);

  FDBXRow_GetString :=                LoadMethod(SDBXRow_GetString);
  FDBXRow_GetWideString :=            LoadMethod(SDBXRow_GetWideString);
  FDBXRow_GetBoolean :=               LoadMethod(SDBXRow_GetBoolean);
  FDBXRow_GetUInt8 :=                 LoadMethod(SDBXRow_GetUInt8);
  FDBXRow_GetInt8 :=                  LoadMethod(SDBXRow_GetInt8);
  FDBXRow_GetInt16 :=                 LoadMethod(SDBXRow_GetInt16);
  FDBXRow_GetInt32 :=                 LoadMethod(SDBXRow_GetInt32);
  FDBXRow_GetInt64 :=                 LoadMethod(SDBXRow_GetInt64);
  FDBXRow_GetSingle :=                LoadMethod(SDBXRow_GetSingle);
  FDBXRow_GetDouble :=                LoadMethod(SDBXRow_GetDouble);
  FDBXRow_GetBcd :=                   LoadMethod(SDBXRow_GetBcd);
  FDBXRow_GetTimeStamp :=             LoadMethod(SDBXRow_GetTimeStamp);
  FDBXRow_GetTimeStampOffset :=       LoadMethod(SDBXRow_GetTimeStampOffset);
  FDBXRow_GetTime :=                  LoadMethod(SDBXRow_GetTime);
  FDBXRow_GetDate :=                  LoadMethod(SDBXRow_GetDate);
  FDBXRow_GetFixedBytes :=            LoadMethod(SDBXRow_GetFixedBytes);
  FDBXRow_GetByteLength :=            LoadMethod(SDBXRow_GetByteLength);
  FDBXRow_GetBytes :=                 LoadMethod(SDBXRow_GetBytes);
//  FDBXRow_GetBinary :=                LoadMethod(SDBXRow_GetBinary);
  FDBXRow_GetObjectTypeName :=        LoadMethod(SDBXRow_GetObjectTypeName);

  FDBXWritableRow_SetNull :=         LoadMethod(SDBXWritableRow_SetNull);
  FDBXWritableRow_SetString :=       LoadMethod(SDBXWritableRow_SetString);
  FDBXWritableRow_SetWideString :=   LoadMethod(SDBXWritableRow_SetWideString);
  FDBXWritableRow_SetBoolean :=      LoadMethod(SDBXWritableRow_SetBoolean);
  FDBXWritableRow_SetUInt8 :=        LoadMethod(SDBXWritableRow_SetUInt8);
  FDBXWritableRow_SetInt8 :=         LoadMethod(SDBXWritableRow_SetInt8);
  FDBXWritableRow_SetInt16 :=        LoadMethod(SDBXWritableRow_SetInt16);
  FDBXWritableRow_SetInt32 :=        LoadMethod(SDBXWritableRow_SetInt32);
  FDBXWritableRow_SetInt64 :=        LoadMethod(SDBXWritableRow_SetInt64);
  FDBXWritableRow_SetSingle :=       LoadMethod(SDBXWritableRow_SetSingle);
  FDBXWritableRow_SetDouble :=       LoadMethod(SDBXWritableRow_SetDouble);
  FDBXWritableRow_SetBcd :=          LoadMethod(SDBXWritableRow_SetBcd);
  FDBXWritableRow_SetTimeStamp :=    LoadMethod(SDBXWritableRow_SetTimeStamp);
  FDBXWritableRow_SetTimeStampOffset := LoadMethod(SDBXWritableRow_SetTimeStampOffset);
  FDBXWritableRow_SetTime :=         LoadMethod(SDBXWritableRow_SetTime);
  FDBXWritableRow_SetDate :=         LoadMethod(SDBXWritableRow_SetDate);
  FDBXWritableRow_SetBytes :=        LoadMethod(SDBXWritableRow_SetBytes);
//  FDBXWritableRow_SetBinary :=       LoadMethod(SDBXWritableRow_SetBinary);

  FDBXDriver_CreateConnection :=      LoadMethod(SDBXDriver_CreateConnection);
  FDBXDriver_GetVersion :=            LoadMethod(SDBXDriver_GetVersion);

  FDBXConnection_Connect :=           LoadMethod(SDBXConnection_Connect);
  FDBXConnection_Disconnect :=        LoadMethod(SDBXConnection_Disconnect);
  FDBXConnection_SetCallbackEvent :=  LoadMethod(SDBXConnection_SetCallbackEvent);
  FDBXConnection_CreateCommand :=     LoadMethod(SDBXConnection_CreateCommand);
  FDBXConnection_BeginTransaction :=  LoadMethod(SDBXConnection_BeginTransaction);
  FDBXConnection_Commit :=            LoadMethod(SDBXConnection_Commit);
  FDBXConnection_Rollback :=          LoadMethod(SDBXConnection_Rollback);
  FDBXConnection_GetIsolation :=      LoadMethod(SDBXConnection_GetIsolation);
  // Ok if not implemented.
  //
  FDBXConnection_GetVendorProperty := GetProcAddress(FLibraryHandle, SDBXConnection_GetVendorProperty);
//  FDBXConnection_SetProperty := GetProcAddress(FLibraryHandle, PAnsiChar(AnsiString(SDBXConnection_SetProperty)));

  FDBXCommand_CreateParameterRow :=   LoadMethod(SDBXCommand_CreateParameterRow);
  FDBXCommand_Prepare :=              LoadMethod(SDBXCommand_Prepare);
  FDBXCommand_Execute :=              LoadMethod(SDBXCommand_Execute);
  FDBXCommand_ExecuteImmediate :=     LoadMethod(SDBXCommand_ExecuteImmediate);
  FDBXCommand_GetNextReader :=        LoadMethod(SDBXCommand_GetNextReader);
  FDBXCommand_GetRowsAffected :=      LoadMethod(SDBXCommand_GetRowsAffected);
  FDBXCommand_SetMaxBlobSize :=       LoadMethod(SDBXCommand_SetMaxBlobSize);
  FDBXCommand_SetRowSetSize :=           LoadMethod(SDBXCommand_SetRowSetSize);

  FDBXCommand_GetParameterCount :=    GetProcAddress(FLibraryHandle, SDBXCommand_GetParameterCount);
  FDBXCommand_GetParameterType :=     GetProcAddress(FLibraryHandle, SDBXCommand_GetParameterType);

  FDBXParameterRow_SetParameterType :=  LoadMethod(SDBXParameterRow_SetParameterType);

  FDBXReader_GetColumnCount :=        LoadMethod(SDBXReader_GetColumnCount);
  FDBXReader_GetColumnMetadata :=     LoadMethod(SDBXReader_GetColumnMetaData);
  FDBXReader_Next :=                  LoadMethod(SDBXReader_Next);
end;

function TDBXNativeMethodTable.LoadMethod(MethodName: string): TPointer;
begin
  Result := GetProcAddress(FLibraryHandle, PChar(MethodName));

  if not Assigned(Result) then
  begin
    raise TDBXError.Create(TDBXErrorCodes.DriverInitFailed, Format(SDllProcLoadError, [MethodName]));
  end;
end;

end.

