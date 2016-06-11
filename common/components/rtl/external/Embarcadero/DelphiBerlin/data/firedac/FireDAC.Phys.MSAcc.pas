{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{             FireDAC ODBC MS Access driver             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys.MSAcc;

interface

uses
  System.Classes,
  FireDAC.Stan.Error, 
  FireDAC.Phys, FireDAC.Phys.ODBCCli, FireDAC.Phys.ODBCWrapper, FireDAC.Phys.ODBCBase;

type
  EMSAccessNativeException = class;
  TFDPhysMSAccessDriverLink = class;
  TFDMSAccessService = class;

  EMSAccessNativeException = class(EODBCNativeException)
  public
    function AppendError(AHandle: TODBCHandle; ARecNum: SQLSmallint;
      const ASQLState: String; ANativeError: SQLInteger; const ADiagMessage,
      AResultMessage, ACommandText, AObject: String; AKind: TFDCommandExceptionKind;
      ACmdOffset, ARowIndex: Integer): TFDDBError; override;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TFDPhysMSAccessDriverLink = class(TFDPhysODBCBaseDriverLink)
  protected
    function GetBaseDriverID: String; override;
  end;

  TFDMSAccessDBVersion = (avDefault, avAccess2, avAccess95, avAccess97,
    avAccess2000, avAccess2003, avAccess2007);
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TFDMSAccessService = class (TFDPhysODBCBaseService)
  private type
    TAction = (aaCompactDB, aaRepairDB, aaCreateDB, aaDropDB);
  private
    FAction: TAction;
    FDatabase: String;
    FDestDatabase: String;
    FDBVersion: TFDMSAccessDBVersion;
    FSortOrder: String;
    FEncrypted: Boolean;
    FPassword: String;
    FResetPassword: Boolean;
    function GetDriverLink: TFDPhysMSAccessDriverLink;
    procedure SetDriverLink(const AValue: TFDPhysMSAccessDriverLink);
  protected
    procedure InternalExecute; override;
  public
    procedure CreateDB;
    procedure Drop;
    procedure Repair;
    procedure Compact;
  published
    property DriverLink: TFDPhysMSAccessDriverLink read GetDriverLink write SetDriverLink;
    property Database: String read FDatabase write FDatabase;
    property DestDatabase: String read FDestDatabase write FDestDatabase;
    property SortOrder: String read FSortOrder write FSortOrder;
    property DBVersion: TFDMSAccessDBVersion read FDBVersion write FDBVersion default avDefault;
    property Encrypted: Boolean read FEncrypted write FEncrypted default False;
    property Password: String read FPassword write FPassword;
    property ResetPassword: Boolean read FResetPassword write FResetPassword default False;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
{$IFDEF MSWINDOWS}
  // Preventing from "Inline has not been expanded"
  Winapi.Windows, System.Win.ComObj,
{$ENDIF}
{$IFDEF POSIX}
  // Preventing from "Inline has not been expanded"
  Posix.UniStd,
{$ENDIF}
  System.SysUtils, System.Variants,
  FireDAC.Stan.Consts, FireDAC.Stan.ResStrs, FireDAC.Stan.Intf, FireDAC.Stan.Util,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator, FireDAC.Phys.MSAccMeta,
    FireDAC.Phys.MSAccDef;

type
  TFDPhysMSAccessDriver = class;
  TFDPhysMSAccessConnection = class;

  TFDPhysMSAccessDriver = class(TFDPhysODBCDriverBase)
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    procedure InternalLoad; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    procedure GetODBCConnectStringKeywords(AKeywords: TStrings); override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  end;

  TFDPhysMSAccessConnection = class(TFDPhysODBCConnectionBase)
  private
    FStringFormat: TFDDataType;
  protected
    function InternalCreateCommandGenerator(const ACommand:
      IFDPhysCommand): TFDPhysCommandGenerator; override;
    function InternalCreateMetadata: TObject; override;
    procedure InternalConnect; override;
    procedure GetStrsMaxSizes(AStrDataType: SQLSmallint; AFixedLen: Boolean;
      out ACharSize, AByteSize: Integer); override;
    function GetStrsType: TFDDataType; override;
    function GetExceptionClass: EODBCNativeExceptionClass; override;
  end;

{-------------------------------------------------------------------------------}
{ EMSAccessNativeException                                                      }
{-------------------------------------------------------------------------------}
function EMSAccessNativeException.AppendError(AHandle: TODBCHandle;
  ARecNum: SQLSmallint; const ASQLState: String; ANativeError: SQLInteger;
  const ADiagMessage, AResultMessage, ACommandText, AObject: String;
  AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError;
var
  sObj: String;

  procedure ExtractObjName;
  var
    i1, i2: Integer;
  begin
    i1 := Pos('''', ADiagMessage);
    if i1 <> 0 then begin
      i2 := Pos('''', ADiagMessage, i1 + 1);
      if i2 <> 0 then
        sObj := Copy(ADiagMessage, i1 + 1, i2 - i1 - 1);
    end;
  end;

begin
  // following is not supported by MSAccess:
  // ekNoDataFound
  // ekUserPwdExpired
  // ekUserPwdWillExpire
  sObj := AObject;
  case ANativeError of
  -1102:
    AKind := ekRecordLocked;
  -1605:
    AKind := ekUKViolated;
  -1613:
    AKind := ekFKViolated;
  -1305:
    begin
      AKind := ekObjNotExists;
      // first 'xxxx' - object name
      ExtractObjName;
    end;
  -1905:
    AKind := ekUserPwdInvalid;
  end;
  Result := inherited AppendError(AHandle, ARecNum, ASQLState, ANativeError,
    ADiagMessage, AResultMessage, ACommandText, sObj, AKind, ACmdOffset, ARowIndex);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSAccessDriverLink                                                     }
{-------------------------------------------------------------------------------}
function TFDPhysMSAccessDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_MSAccId;
end;

{-------------------------------------------------------------------------------}
{ TFDMSAccessService                                                            }
{-------------------------------------------------------------------------------}
function TFDMSAccessService.GetDriverLink: TFDPhysMSAccessDriverLink;
begin
  Result := inherited DriverLink as TFDPhysMSAccessDriverLink;
end;

{-------------------------------------------------------------------------------}
procedure TFDMSAccessService.SetDriverLink(const AValue: TFDPhysMSAccessDriverLink);
begin
  inherited DriverLink := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDMSAccessService.CreateDB;
begin
  FAction := aaCreateDB;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDMSAccessService.Drop;
begin
  FAction := aaDropDB;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDMSAccessService.Compact;
begin
  FAction := aaCompactDB;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDMSAccessService.Repair;
begin
  FAction := aaRepairDB;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDMSAccessService.InternalExecute;
var
  sStr, sDrv, sDb: String;
  lSort, lLastDrv: Boolean;

  function NormFileName(AName: String): String;
  begin
    Result := FDExpandStr(AName);
    if (Pos(' ', Result) > 0) and (Result[1] <> '"') then
      Result := '"' + Result + '"';
  end;

  procedure DeleteDatabase(const AName: String);
  var
    sFile: String;
  begin
    sFile := FDExpandStr(AName);
    System.SysUtils.DeleteFile(sFile);
    System.SysUtils.DeleteFile(ChangeFileExt(sFile, '.ldb'));
    System.SysUtils.DeleteFile(ChangeFileExt(sFile, '.laccdb'));
  end;

{$IFDEF MSWINDOWS}
  function RenameDatabase(const AOldName, ANewName: String): Boolean;
  var
    sOldFile, sNewFile, sLdbFile: String;
  begin
    sOldFile := FDExpandStr(AOldName);
    sNewFile := FDExpandStr(ANewName);
    Result := RenameFile(sOldFile, sNewFile);
    if Result then begin
      sLdbFile := ChangeFileExt(sOldFile, '.ldb');
      if FileExists(sLdbFile) then
        RenameFile(sLdbFile, ChangeFileExt(sNewFile, '.ldb'));
      sLdbFile := ChangeFileExt(sOldFile, '.laccdb');
      if FileExists(sLdbFile) then
        RenameFile(sLdbFile, ChangeFileExt(sNewFile, '.laccdb'));
    end;
  end;

  function GenTempFileName(const AName: String): String;
  var
    sPath: String;
  begin
    sPath := ExtractFilePath(FDExpandStr(AName));
    SetLength(Result, MAX_PATH);
    GetTempFileName(PChar(sPath), 'FD', 0, PChar(Result));
    Result := PChar(Result);
  end;

  procedure ProcessOLEException(AExc: EOleSysError);
  var
    sMsg: String;
    iCode: Integer;
    oExc: EFDDBEngineException;
    oErr: TFDDBError;
  begin
    sMsg := AExc.Message;
    iCode := er_FD_AccUnknownOleError;
    if AExc is EOLEException then begin
      if Pos('Class not registered', sMsg) > 0 then
        iCode := er_FD_AccClassNotRegistered
      else if Pos('Unrecognized database format', sMsg) > 0 then
        iCode := er_FD_AccUnrecognizedDbFormat
      else if Pos('Not a valid password', sMsg) > 0 then
        iCode := er_FD_AccNotValidPassword;
    end
    else
      if Pos('Class not registered', sMsg) > 0 then
        iCode := er_FD_AccSysClassNotRegistered;

    oExc := FDDBEngineExceptionCreate(EMSAccessNativeException, iCode, []);
    oErr := TFDDBError.Create;
    oErr.Message := sMsg;
    oExc.Append(oErr);
    FDException(Self, oExc{$IFDEF FireDAC_Monitor}, False{$ENDIF});
  end;

  procedure CompactRepair;
  var
    vJro: Variant;
    sSource, sDest, sProvider, sDestDatabase: String;
    iEngine: Integer;
    lRename: Boolean;
  begin
    if not FileExists(Database) then
      FDException(Self, FDDBEngineExceptionCreate(EMSAccessNativeException,
        er_FD_AccDbNotExists, [Database]) {$IFDEF FireDAC_Monitor}, False{$ENDIF});
    try
      vJro := CreateOLEObject('JRO.JetEngine');
      try
        lRename := (DestDatabase = '') or (DestDatabase = Database);
        if lRename then
          sDestDatabase := GenTempFileName(Database)
        else
          sDestDatabase := DestDatabase;
        DeleteDatabase(sDestDatabase);
        sSource := 'Provider=%s;Data Source=%s;Jet OLEDB:Engine Type=%d';
        sDest := sSource;
        if Password <> '' then begin
          sSource := sSource + ';Jet OLEDB:Database Password=' + Password;
          if not ResetPassword then
            sDest := sSource;
        end;
        if lSort then
          sDest := sDest + ';LocaleIdentifier=' + SortOrder;
        if Encrypted then
          sDest := sDest + ';Jet OLEDB:Encrypt Database=True';
        iEngine := 5;
        case DBVersion of
        avDefault:
          begin
            if sDrv = 'Microsoft Access Driver (*.mdb, *.accdb)' then
              sProvider := 'Microsoft.ACE.OLEDB.12.0'
            else
              sProvider := 'Microsoft.Jet.OLEDB.4.0';
          end;
        avAccess2:
          begin
            sProvider := 'Microsoft.Jet.OLEDB.4.0';
            iEngine := 3;
          end;
        avAccess95,
        avAccess97:
          begin
            sProvider := 'Microsoft.Jet.OLEDB.4.0';
            iEngine := 4;
          end;
        avAccess2000,
        avAccess2003:
          begin
            sProvider := 'Microsoft.Jet.OLEDB.4.0';
            iEngine := 5;
          end;
        avAccess2007:
          begin
            sProvider := 'Microsoft.ACE.OLEDB.12.0';
            iEngine := 5;
          end;
        end;
        vJro.CompactDatabase(Format(sSource, [sProvider, FDExpandStr(Database),
          iEngine]), Format(sDest, [sProvider, FDExpandStr(sDestDatabase), iEngine]));
        if lRename then begin
          DeleteDatabase(Database);
          if RenameDatabase(sDestDatabase, Database) then
            DeleteDatabase(sDestDatabase);
        end;
      finally
        vJro := Unassigned;
      end;
    except
      on E: EOleSysError do
        ProcessOLEException(EOleSysError(E))
    end;
  end;
{$ENDIF}

begin
  sDrv := (DriverLink.DriverIntf as IFDPhysODBCDriver).ODBCDriver;
  case FAction of
  aaCompactDB:
{$IFDEF MSWINDOWS}
    CompactRepair;
{$ELSE}
    begin
      sDb := NormFileName(Database);
      sStr := 'COMPACT_DB=' + sDb + ' ';
      if DestDatabase = '' then
        sStr := sStr + sDb
      else
        sStr := sStr + NormFileName(DestDatabase);
      if SortOrder <> '' then
        sStr := sStr + ' ' + SortOrder;
      ExecuteBase(ODBC_ADD_DSN, sDrv, sStr);
    end;
{$ENDIF}
  aaRepairDB:
{$IFDEF MSWINDOWS}
    CompactRepair;
{$ELSE}
    begin
      sStr := 'REPAIR_DB=' + NormFileName(Database);
      ExecuteBase(ODBC_ADD_DSN, sDrv, sStr);
    end;
{$ENDIF}
  aaCreateDB:
    begin
      sStr := 'CREATE_DB';
      lLastDrv := sDrv = 'Microsoft Access Driver (*.mdb, *.accdb)';
      case DBVersion of
      avDefault:    ;
      avAccess2:    sStr := sStr + 'V2';
      avAccess95,
      avAccess97:   sStr := sStr + 'V3';
      avAccess2000: sStr := sStr + 'V4';
      avAccess2003,
      avAccess2007:
        begin
          sDrv := 'Microsoft Access Driver (*.mdb, *.accdb)';
          lLastDrv := True;
        end;
      end;
      sStr := sStr + '=' + NormFileName(Database);
      lSort := SortOrder <> '';
      if lSort and (Pos('0x', SortOrder) = 0) then begin
        sStr := sStr + ' ' + SortOrder;
{$IFDEF MSWINDOWS}
        lSort := False;
{$ENDIF}
      end;
      if Encrypted and not lLastDrv then
        sStr := sStr + ' ENCRYPT';
      ExecuteBase(ODBC_ADD_DSN, sDrv, sStr);
{$IFDEF MSWINDOWS}
      if (Password <> '') or lSort or (Encrypted and lLastDrv) then begin
        sDb := DestDatabase;
        DestDatabase := '';
        try
          CompactRepair;
        finally
          DestDatabase := sDb;
        end;
      end;
{$ENDIF}
    end;
  aaDropDB:
    DeleteDatabase(Database);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSAccessDriver                                                         }
{-------------------------------------------------------------------------------}
class function TFDPhysMSAccessDriver.GetBaseDriverID: String;
begin
  Result := S_FD_MSAccId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMSAccessDriver.GetBaseDriverDesc: String;
begin
  Result := 'Microsoft Access Database';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMSAccessDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.MSAccess;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMSAccessDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysMSAccConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccessDriver.InternalLoad;
begin
  ODBCAdvanced := 'ExtendedAnsiSQL=1';
  inherited InternalLoad;
  if ODBCDriver = '' then
    ODBCDriver := FindBestDriver([
      'Microsoft Access Driver (*.mdb, *.accdb)',
      'Microsoft Access Driver (*.mdb)',
      'Driver do Microsoft Access (*.mdb)',
      'Microsoft Access-Treiber (*.mdb)']);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccessDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysMSAccessConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccessDriver.GetODBCConnectStringKeywords(AKeywords: TStrings);
begin
  inherited GetODBCConnectStringKeywords(AKeywords);
  AKeywords.Add(S_FD_ConnParam_Common_Database + '=DBQ*');
  AKeywords.Add(S_FD_ConnParam_MSAcc_SystemDB);
  AKeywords.Add(S_FD_ConnParam_MSAcc_ReadOnly);
  AKeywords.Add('=ExtendedAnsiSQL');
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccessDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oView: TFDDatSView;
begin
  Result := inherited GetConnParams(AKeys, AParams);
  oView := Result.Select('Name=''' + S_FD_ConnParam_Common_Database + '''');
  if oView.Rows.Count = 1 then begin
    oView.Rows[0].BeginEdit;
    oView.Rows[0].SetValues('Type', '@F:Microsoft Access Database|*.mdb;*.accdb');
    oView.Rows[0].SetValues('LoginIndex', 2);
    oView.Rows[0].EndEdit;
  end;

  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSAcc_SystemDB, '@S', '', S_FD_ConnParam_MSAcc_SystemDB, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSAcc_ReadOnly, '@L', '', S_FD_ConnParam_MSAcc_ReadOnly, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSAcc_StringFormat, S_FD_Choose + ';' + S_FD_Unicode + ';' + S_FD_ANSI, S_FD_Choose, S_FD_ConnParam_MSAcc_StringFormat, -1]);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSAccessConnection                                                     }
{-------------------------------------------------------------------------------}
function TFDPhysMSAccessConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  if ACommand <> nil then
    Result := TFDPhysMSAccCommandGenerator.Create(ACommand)
  else
    Result := TFDPhysMSAccCommandGenerator.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccessConnection.InternalCreateMetadata: TObject;
var
  iSrvVer, iClntVer: TFDVersion;
begin
  GetVersions(iSrvVer, iClntVer);
  Result := TFDPhysMSAccMetadata.Create(Self, iSrvVer, iClntVer, GetKeywords);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccessConnection.InternalConnect;
var
  oParams: TFDPhysMSAccConnectionDefParams;
begin
  inherited InternalConnect;
  oParams := ConnectionDef.Params as TFDPhysMSAccConnectionDefParams;
  case oParams.StringFormat of
  sfChoose:  FStringFormat := dtUnknown;
  sfUnicode: FStringFormat := dtWideString;
  sfANSI:    FStringFormat := dtAnsiString;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccessConnection.GetStrsMaxSizes(AStrDataType: SQLSmallint;
  AFixedLen: Boolean; out ACharSize, AByteSize: Integer);
begin
  case AStrDataType of
  SQL_C_CHAR, SQL_C_WCHAR:
    ACharSize := 255;
  SQL_C_BINARY:
    ACharSize := 510;
  else
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_MSAccId]);
  end;
  AByteSize := ACharSize;
  if AStrDataType = SQL_C_WCHAR then
    AByteSize := AByteSize * SizeOf(SQLWChar);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccessConnection.GetStrsType: TFDDataType;
begin
  Result := FStringFormat;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccessConnection.GetExceptionClass: EODBCNativeExceptionClass;
begin
  Result := EMSAccessNativeException;
end;

{-------------------------------------------------------------------------------}
function MSAccessNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EMSAccessNativeException.Create;
  EMSAccessNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysMSAccessDriver);
  FDStorageManager().RegisterClass(EMSAccessNativeException, 'MSAccessNativeException',
    @MSAccessNativeExceptionLoad, @FDExceptionSave);

end.
