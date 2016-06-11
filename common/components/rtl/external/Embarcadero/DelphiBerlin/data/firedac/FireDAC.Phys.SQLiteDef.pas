{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.SQLiteDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysSQLiteConnectionDefParams
  // Generated for: FireDAC SQLite driver

  TFDSQLiteOpenMode = (omCreateUTF8, omCreateUTF16, omReadWrite, omReadOnly);
  TFDSQLiteEncrypt = (enNo, enAes_128, enAes_192, enAes_256, enAes_ctr_128, enAes_ctr_192, enAes_ctr_256, enAes_ecb_128, enAes_ecb_192, enAes_ecb_256);
  TFDSQLiteLockingMode = (lmNormal, lmExclusive);
  TFDSQLiteSynchronous = (snFull, snNormal, snOff);
  TFDSQLiteJournalMode = (jmDelete, jmTruncate, jmPersist, jmMemory, jmWAL, jmOff);
  TFDSQLiteForeignKeys = (fkOn, fkOff);
  TFDSQLiteStringFormat = (sfChoose, sfUnicode, sfANSI);
  TFDSQLiteGUIDFormat = (guiString, guiBinary);
  TFDSQLiteDateTimeFormat = (dtfString, dtfBinary, dtfDateTime);

  /// <summary> TFDPhysSQLiteConnectionDefParams class implements FireDAC SQLite driver specific connection definition class. </summary>
  TFDPhysSQLiteConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetOpenMode: TFDSQLiteOpenMode;
    procedure SetOpenMode(const AValue: TFDSQLiteOpenMode);
    function GetEncrypt: TFDSQLiteEncrypt;
    procedure SetEncrypt(const AValue: TFDSQLiteEncrypt);
    function GetBusyTimeout: Integer;
    procedure SetBusyTimeout(const AValue: Integer);
    function GetCacheSize: Integer;
    procedure SetCacheSize(const AValue: Integer);
    function GetSharedCache: Boolean;
    procedure SetSharedCache(const AValue: Boolean);
    function GetLockingMode: TFDSQLiteLockingMode;
    procedure SetLockingMode(const AValue: TFDSQLiteLockingMode);
    function GetSynchronous: TFDSQLiteSynchronous;
    procedure SetSynchronous(const AValue: TFDSQLiteSynchronous);
    function GetJournalMode: TFDSQLiteJournalMode;
    procedure SetJournalMode(const AValue: TFDSQLiteJournalMode);
    function GetForeignKeys: TFDSQLiteForeignKeys;
    procedure SetForeignKeys(const AValue: TFDSQLiteForeignKeys);
    function GetStringFormat: TFDSQLiteStringFormat;
    procedure SetStringFormat(const AValue: TFDSQLiteStringFormat);
    function GetGUIDFormat: TFDSQLiteGUIDFormat;
    procedure SetGUIDFormat(const AValue: TFDSQLiteGUIDFormat);
    function GetDateTimeFormat: TFDSQLiteDateTimeFormat;
    procedure SetDateTimeFormat(const AValue: TFDSQLiteDateTimeFormat);
    function GetExtensions: String;
    procedure SetExtensions(const AValue: String);
    function GetSQLiteAdvanced: String;
    procedure SetSQLiteAdvanced(const AValue: String);
    function GetMetaDefCatalog: String;
    procedure SetMetaDefCatalog(const AValue: String);
    function GetMetaCurCatalog: String;
    procedure SetMetaCurCatalog(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property OpenMode: TFDSQLiteOpenMode read GetOpenMode write SetOpenMode stored False default omCreateUTF8;
    property Encrypt: TFDSQLiteEncrypt read GetEncrypt write SetEncrypt stored False default enNo;
    property BusyTimeout: Integer read GetBusyTimeout write SetBusyTimeout stored False default 10000;
    property CacheSize: Integer read GetCacheSize write SetCacheSize stored False default 10000;
    property SharedCache: Boolean read GetSharedCache write SetSharedCache stored False;
    property LockingMode: TFDSQLiteLockingMode read GetLockingMode write SetLockingMode stored False default lmExclusive;
    property Synchronous: TFDSQLiteSynchronous read GetSynchronous write SetSynchronous stored False default snOff;
    property JournalMode: TFDSQLiteJournalMode read GetJournalMode write SetJournalMode stored False default jmDelete;
    property ForeignKeys: TFDSQLiteForeignKeys read GetForeignKeys write SetForeignKeys stored False default fkOn;
    property StringFormat: TFDSQLiteStringFormat read GetStringFormat write SetStringFormat stored False default sfChoose;
    property GUIDFormat: TFDSQLiteGUIDFormat read GetGUIDFormat write SetGUIDFormat stored False default guiString;
    property DateTimeFormat: TFDSQLiteDateTimeFormat read GetDateTimeFormat write SetDateTimeFormat stored False default dtfString;
    property Extensions: String read GetExtensions write SetExtensions stored False;
    property SQLiteAdvanced: String read GetSQLiteAdvanced write SetSQLiteAdvanced stored False;
    property MetaDefCatalog: String read GetMetaDefCatalog write SetMetaDefCatalog stored False;
    property MetaCurCatalog: String read GetMetaCurCatalog write SetMetaCurCatalog stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysSQLiteConnectionDefParams
// Generated for: FireDAC SQLite driver

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetOpenMode: TFDSQLiteOpenMode;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_OpenMode];
  if CompareText(s, 'CreateUTF8') = 0 then
    Result := omCreateUTF8
  else if CompareText(s, 'CreateUTF16') = 0 then
    Result := omCreateUTF16
  else if CompareText(s, 'ReadWrite') = 0 then
    Result := omReadWrite
  else if CompareText(s, 'ReadOnly') = 0 then
    Result := omReadOnly
  else
    Result := omCreateUTF8;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetOpenMode(const AValue: TFDSQLiteOpenMode);
const
  C_OpenMode: array[TFDSQLiteOpenMode] of String = ('CreateUTF8', 'CreateUTF16', 'ReadWrite', 'ReadOnly');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_OpenMode] := C_OpenMode[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetEncrypt: TFDSQLiteEncrypt;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_Encrypt];
  if CompareText(s, 'No') = 0 then
    Result := enNo
  else if CompareText(s, 'aes-128') = 0 then
    Result := enAes_128
  else if CompareText(s, 'aes-192') = 0 then
    Result := enAes_192
  else if CompareText(s, 'aes-256') = 0 then
    Result := enAes_256
  else if CompareText(s, 'aes-ctr-128') = 0 then
    Result := enAes_ctr_128
  else if CompareText(s, 'aes-ctr-192') = 0 then
    Result := enAes_ctr_192
  else if CompareText(s, 'aes-ctr-256') = 0 then
    Result := enAes_ctr_256
  else if CompareText(s, 'aes-ecb-128') = 0 then
    Result := enAes_ecb_128
  else if CompareText(s, 'aes-ecb-192') = 0 then
    Result := enAes_ecb_192
  else if CompareText(s, 'aes-ecb-256') = 0 then
    Result := enAes_ecb_256
  else
    Result := enNo;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetEncrypt(const AValue: TFDSQLiteEncrypt);
const
  C_Encrypt: array[TFDSQLiteEncrypt] of String = ('No', 'aes-128', 'aes-192', 'aes-256', 'aes-ctr-128', 'aes-ctr-192', 'aes-ctr-256', 'aes-ecb-128', 'aes-ecb-192', 'aes-ecb-256');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_Encrypt] := C_Encrypt[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetBusyTimeout: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_SQLite_BusyTimeout) then
    Result := 10000
  else
    Result := FDef.AsInteger[S_FD_ConnParam_SQLite_BusyTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetBusyTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_SQLite_BusyTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetCacheSize: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_SQLite_CacheSize) then
    Result := 10000
  else
    Result := FDef.AsInteger[S_FD_ConnParam_SQLite_CacheSize];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetCacheSize(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_SQLite_CacheSize] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetSharedCache: Boolean;
begin
  if not FDef.HasValue(S_FD_ConnParam_SQLite_SharedCache) then
    Result := True
  else
    Result := FDef.AsBoolean[S_FD_ConnParam_SQLite_SharedCache];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetSharedCache(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_SQLite_SharedCache] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetLockingMode: TFDSQLiteLockingMode;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_LockingMode];
  if CompareText(s, 'Normal') = 0 then
    Result := lmNormal
  else if CompareText(s, 'Exclusive') = 0 then
    Result := lmExclusive
  else
    Result := lmExclusive;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetLockingMode(const AValue: TFDSQLiteLockingMode);
const
  C_LockingMode: array[TFDSQLiteLockingMode] of String = ('Normal', 'Exclusive');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_LockingMode] := C_LockingMode[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetSynchronous: TFDSQLiteSynchronous;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_Synchronous];
  if CompareText(s, 'Full') = 0 then
    Result := snFull
  else if CompareText(s, 'Normal') = 0 then
    Result := snNormal
  else if CompareText(s, 'Off') = 0 then
    Result := snOff
  else
    Result := snOff;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetSynchronous(const AValue: TFDSQLiteSynchronous);
const
  C_Synchronous: array[TFDSQLiteSynchronous] of String = ('Full', 'Normal', 'Off');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_Synchronous] := C_Synchronous[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetJournalMode: TFDSQLiteJournalMode;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_JournalMode];
  if CompareText(s, 'Delete') = 0 then
    Result := jmDelete
  else if CompareText(s, 'Truncate') = 0 then
    Result := jmTruncate
  else if CompareText(s, 'Persist') = 0 then
    Result := jmPersist
  else if CompareText(s, 'Memory') = 0 then
    Result := jmMemory
  else if CompareText(s, 'WAL') = 0 then
    Result := jmWAL
  else if CompareText(s, 'Off') = 0 then
    Result := jmOff
  else
    Result := jmDelete;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetJournalMode(const AValue: TFDSQLiteJournalMode);
const
  C_JournalMode: array[TFDSQLiteJournalMode] of String = ('Delete', 'Truncate', 'Persist', 'Memory', 'WAL', 'Off');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_JournalMode] := C_JournalMode[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetForeignKeys: TFDSQLiteForeignKeys;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_ForeignKeys];
  if CompareText(s, 'On') = 0 then
    Result := fkOn
  else if CompareText(s, 'Off') = 0 then
    Result := fkOff
  else
    Result := fkOn;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetForeignKeys(const AValue: TFDSQLiteForeignKeys);
const
  C_ForeignKeys: array[TFDSQLiteForeignKeys] of String = ('On', 'Off');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_ForeignKeys] := C_ForeignKeys[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetStringFormat: TFDSQLiteStringFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_StringFormat];
  if CompareText(s, 'Choose') = 0 then
    Result := sfChoose
  else if CompareText(s, 'Unicode') = 0 then
    Result := sfUnicode
  else if CompareText(s, 'ANSI') = 0 then
    Result := sfANSI
  else
    Result := sfChoose;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetStringFormat(const AValue: TFDSQLiteStringFormat);
const
  C_StringFormat: array[TFDSQLiteStringFormat] of String = ('Choose', 'Unicode', 'ANSI');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_StringFormat] := C_StringFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetGUIDFormat: TFDSQLiteGUIDFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_GUIDFormat];
  if CompareText(s, 'String') = 0 then
    Result := guiString
  else if CompareText(s, 'Binary') = 0 then
    Result := guiBinary
  else
    Result := guiString;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetGUIDFormat(const AValue: TFDSQLiteGUIDFormat);
const
  C_GUIDFormat: array[TFDSQLiteGUIDFormat] of String = ('String', 'Binary');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_GUIDFormat] := C_GUIDFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetDateTimeFormat: TFDSQLiteDateTimeFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_SQLite_DateTimeFormat];
  if CompareText(s, 'String') = 0 then
    Result := dtfString
  else if CompareText(s, 'Binary') = 0 then
    Result := dtfBinary
  else if CompareText(s, 'DateTime') = 0 then
    Result := dtfDateTime
  else
    Result := dtfString;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetDateTimeFormat(const AValue: TFDSQLiteDateTimeFormat);
const
  C_DateTimeFormat: array[TFDSQLiteDateTimeFormat] of String = ('String', 'Binary', 'DateTime');
begin
  FDef.AsString[S_FD_ConnParam_SQLite_DateTimeFormat] := C_DateTimeFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetExtensions: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_SQLite_Extensions];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetExtensions(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_SQLite_Extensions] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetSQLiteAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_SQLite_SQLiteAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetSQLiteAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_SQLite_SQLiteAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetMetaDefCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetMetaDefCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteConnectionDefParams.GetMetaCurCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteConnectionDefParams.SetMetaCurCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog] := AValue;
end;

end.
