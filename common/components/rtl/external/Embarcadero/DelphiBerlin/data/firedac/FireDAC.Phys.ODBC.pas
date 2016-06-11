{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC ODBC Bridge driver               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys.ODBC;

interface

uses
  System.Classes,
  FireDAC.Phys, FireDAC.Phys.ODBCBase;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidLinux64)]
  TFDPhysODBCDriverLink = class(TFDPhysODBCBaseDriverLink)
  protected
    function GetBaseDriverID: String; override;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.SysUtils, System.Variants,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts, FireDAC.Stan.Util,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator, FireDAC.Phys.Meta,
    FireDAC.Phys.ODBCCli, FireDAC.Phys.ODBCWrapper, FireDAC.Phys.ODBCMeta,
    FireDAC.Phys.ODBCDef
{$IFDEF FireDAC_ODBC_ALLMETA}
    , FireDAC.Phys.MSSQLMeta, FireDAC.Phys.MSAccMeta, FireDAC.Phys.DB2Meta,
    FireDAC.Phys.OracleMeta, FireDAC.Phys.ASAMeta, FireDAC.Phys.MySQLMeta,
    FireDAC.Phys.ADSMeta, FireDAC.Phys.IBMeta, FireDAC.Phys.PGMeta,
    FireDAC.Phys.SQLiteMeta, FireDAC.Phys.NexusMeta, FireDAC.Phys.InfxMeta,
    FireDAC.Phys.TDataMeta
{$ENDIF}
    ;

type
  TFDPhysODBCDriver = class;
  TFDPhysODBCConnection = class;

  TFDPhysODBCDriver = class(TFDPhysODBCDriverBase)
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    procedure GetODBCConnectStringKeywords(AKeywords: TStrings); override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  end;

  TFDPhysODBCConnection = class(TFDPhysODBCConnectionBase)
  private
    FRdbmsKind: TFDRDBMSKind;
    FNumericFormat: TFDDataType;
    procedure UpdateRDBMSKind;
  protected
    function InternalCreateCommandGenerator(
      const ACommand: IFDPhysCommand): TFDPhysCommandGenerator; override;
    function InternalCreateMetadata: TObject; override;
    procedure InternalConnect; override;
    function GetNumType: TFDDataType; override;
    function GetODBCVersion: Integer; override;
  public
    constructor Create(ADriverObj: TFDPhysDriver; AConnHost: TFDPhysConnectionHost); override;
  end;

const
  S_FD_Binary = 'Binary';
  S_FD_String = 'String';

  S_FD_38 = '3.8';
  S_FD_30 = '3.0';

{-------------------------------------------------------------------------------}
{ TFDPhysODBCDriverLink                                                         }
{-------------------------------------------------------------------------------}
function TFDPhysODBCDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_ODBCId;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysODBCDriver                                                             }
{-------------------------------------------------------------------------------}
class function TFDPhysODBCDriver.GetBaseDriverID: String;
begin
  Result := S_FD_ODBCId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysODBCDriver.GetBaseDriverDesc: String;
begin
  Result := 'ODBC Data Source';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysODBCDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Other;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysODBCDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysODBCConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysODBCConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCDriver.GetODBCConnectStringKeywords(AKeywords: TStrings);
var
  i: Integer;
begin
  inherited GetODBCConnectStringKeywords(AKeywords);
  i := AKeywords.IndexOf('=DRIVER');
  if i >= 0 then
    AKeywords.Delete(i);
  i := AKeywords.IndexOf('DSN');
  if i >= 0 then
    AKeywords.Delete(i);
  AKeywords.Add(S_FD_ConnParam_ODBC_ODBCDriver + '=DRIVER');
  AKeywords.Add(S_FD_ConnParam_ODBC_DataSource + '=DSN');
  AKeywords.Add(S_FD_ConnParam_Common_Database + '=DBQ');
  AKeywords.Add(S_FD_ConnParam_Common_Database + '=DATABASE');
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oList: TFDStringList;
  oManMeta: IFDPhysManagerMetadata;
begin
  Result := inherited GetConnParams(AKeys, AParams);

  Employ;
  oList := TFDStringList.Create(#0, ';');
  try
    ODBCEnvironment.GetDrivers(oList, True);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_ODBC_ODBCDriver, oList.DelimitedText, '', S_FD_ConnParam_ODBC_ODBCDriver, -1]);

    ODBCEnvironment.GetDSNs(oList, False, True);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_ODBC_DataSource, oList.DelimitedText, '', S_FD_ConnParam_ODBC_DataSource, 2]);

    Result.Rows.Add([Unassigned, S_FD_ConnParam_ODBC_NumericFormat, S_FD_Binary + ';' + S_FD_String, S_FD_String, S_FD_ConnParam_ODBC_NumericFormat, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_ODBC_ODBCVersion, S_FD_38 + ';' + S_FD_30, S_FD_30, S_FD_ConnParam_ODBC_ODBCVersion, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefCatalog, '@S', '', S_FD_ConnParam_Common_MetaDefCatalog, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefSchema, '@S', '', S_FD_ConnParam_Common_MetaDefSchema, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurCatalog, '@S', '', S_FD_ConnParam_Common_MetaCurCatalog, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurSchema, '@S', '', S_FD_ConnParam_Common_MetaCurSchema, -1]);

    FDPhysManager.CreateMetadata(oManMeta);
    oManMeta.GetRDBMSNames(oList);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_RDBMS, oList.DelimitedText, '', S_FD_ConnParam_Common_RDBMS, -1]);
  finally
    FDFree(oList);
    Vacate;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysODBCConnection                                                         }
{-------------------------------------------------------------------------------}
constructor TFDPhysODBCConnection.Create(ADriverObj: TFDPhysDriver;
  AConnHost: TFDPhysConnectionHost);
begin
  inherited Create(ADriverObj, AConnHost);
  UpdateRDBMSKind;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnection.UpdateRDBMSKind;
begin
  if FRdbmsKind = TFDRDBMSKinds.Unknown then
    FRdbmsKind := TFDPhysODBCConnectionDefParams(ConnectionDef.Params).RDBMS;
  if (FRdbmsKind = TFDRDBMSKinds.Unknown) and (ODBCConnection <> nil) then
    FRdbmsKind := ODBCConnection.RdbmsKind;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnection.InternalConnect;
begin
  inherited InternalConnect;
  FRdbmsKind := TFDRDBMSKinds.Unknown;
  case TFDPhysODBCConnectionDefParams(ConnectionDef.Params).NumericFormat of
  nfBinary: FNumericFormat := dtBCD;
  nfString: FNumericFormat := dtAnsiString;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnection.GetNumType: TFDDataType;
begin
  Result := FNumericFormat;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnection.GetODBCVersion: Integer;
const
  C_Vers: array [TFDODBCVersion] of Integer = (SQL_OV_ODBC3_80, SQL_OV_ODBC3);
begin
  Result := C_Vers[TFDPhysODBCConnectionDefParams(ConnectionDef.Params).ODBCVersion];
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnection.InternalCreateCommandGenerator(const ACommand:
  IFDPhysCommand): TFDPhysCommandGenerator;
begin
  UpdateRDBMSKind;
                                                                                 
{$IFDEF FireDAC_ODBC_ALLMETA}
  if ACommand <> nil then
    case FRdbmsKind of
    TFDRDBMSKinds.Oracle:      Result := TFDPhysOraCommandGenerator.Create(ACommand, False);
    TFDRDBMSKinds.MSSQL:       Result := TFDPhysMSSQLCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.MSAccess:    Result := TFDPhysMSAccCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.MySQL:       Result := TFDPhysMySQLCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.Db2:         Result := TFDPhysDb2CommandGenerator.Create(ACommand);
    TFDRDBMSKinds.SQLAnywhere: Result := TFDPhysASACommandGenerator.Create(ACommand);
    TFDRDBMSKinds.Advantage:   Result := TFDPhysADSCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.Interbase,
    TFDRDBMSKinds.Firebird:    Result := TFDPhysIBCommandGenerator.Create(ACommand, 0, ecANSI);
    TFDRDBMSKinds.PostgreSQL:  Result := TFDPhysPgCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.SQLite:      Result := TFDPhysSQLiteCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.NexusDB:     Result := TFDPhysNexusCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.Informix:    Result := TFDPhysInfxCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.Teradata:    Result := TFDPhysTDataCommandGenerator.Create(ACommand);
    else                       Result := TFDPhysCommandGenerator.Create(ACommand);
    end
  else
    case FRdbmsKind of
    TFDRDBMSKinds.Oracle:      Result := TFDPhysOraCommandGenerator.Create(Self, False);
    TFDRDBMSKinds.MSSQL:       Result := TFDPhysMSSQLCommandGenerator.Create(Self);
    TFDRDBMSKinds.MSAccess:    Result := TFDPhysMSAccCommandGenerator.Create(Self);
    TFDRDBMSKinds.MySQL:       Result := TFDPhysMySQLCommandGenerator.Create(Self);
    TFDRDBMSKinds.Db2:         Result := TFDPhysDb2CommandGenerator.Create(Self);
    TFDRDBMSKinds.SQLAnywhere: Result := TFDPhysASACommandGenerator.Create(Self);
    TFDRDBMSKinds.Advantage:   Result := TFDPhysADSCommandGenerator.Create(Self);
    TFDRDBMSKinds.Interbase,
    TFDRDBMSKinds.Firebird:    Result := TFDPhysIBCommandGenerator.Create(Self, 0, ecANSI);
    TFDRDBMSKinds.PostgreSQL:  Result := TFDPhysPgCommandGenerator.Create(Self);
    TFDRDBMSKinds.SQLite:      Result := TFDPhysSQLiteCommandGenerator.Create(Self);
    TFDRDBMSKinds.NexusDB:     Result := TFDPhysNexusCommandGenerator.Create(Self);
    TFDRDBMSKinds.Informix:    Result := TFDPhysInfxCommandGenerator.Create(Self);
    TFDRDBMSKinds.Teradata:    Result := TFDPhysTDataCommandGenerator.Create(Self);
    else                       Result := TFDPhysCommandGenerator.Create(Self);
    end;
{$ELSE}
  if ACommand <> nil then
    Result := TFDPhysCommandGenerator.Create(ACommand)
  else
    Result := TFDPhysCommandGenerator.Create(Self);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnection.InternalCreateMetadata: TObject;
var
  iSrvVer, iClntVer: TFDVersion;
begin
  GetVersions(iSrvVer, iClntVer);
  UpdateRDBMSKind;
                                                                        
{$IFDEF FireDAC_ODBC_ALLMETA}
  case FRdbmsKind of
  TFDRDBMSKinds.Oracle:      Result := TFDPhysOraMetadata.Create(Self, iSrvVer, iClntVer, False);
  TFDRDBMSKinds.MSSQL:       Result := TFDPhysMSSQLMetadata.Create(Self, False, True, True, True,
    (ODBCConnection <> nil) and (ODBCConnection.DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc]),
    iSrvVer, iClntVer, False);
  TFDRDBMSKinds.MSAccess:    Result := TFDPhysMSAccMetadata.Create(Self, iSrvVer, iClntVer, GetKeywords);
  TFDRDBMSKinds.MySQL:       Result := TFDPhysMySQLMetadata.Create(Self, False, iSrvVer, iClntVer,
    [nmCaseSens, nmDBApply], False);
  TFDRDBMSKinds.Db2:         Result := TFDPhysDb2Metadata.Create(Self, iSrvVer, iClntVer, GetKeywords, False, True);
  TFDRDBMSKinds.SQLAnywhere: Result := TFDPhysASAMetadata.Create(Self, iSrvVer, iClntVer, GetKeywords);
  TFDRDBMSKinds.Advantage:   Result := TFDPhysADSMetadata.Create(Self, iSrvVer, iClntVer, True);
  TFDRDBMSKinds.Interbase:   Result := TFDPhysIBMetadata.Create(Self, ibInterbase, iSrvVer, iClntVer, 3, False);
  TFDRDBMSKinds.Firebird:    Result := TFDPhysIBMetadata.Create(Self, ibFirebird, iSrvVer, iClntVer, 3, False);
  TFDRDBMSKinds.PostgreSQL:  Result := TFDPhysPgMetadata.Create(Self, iSrvVer, iClntVer, False, False, False, True);
  TFDRDBMSKinds.SQLite:      Result := TFDPhysSQLiteMetadata.Create(Self, sbSQLite, iSrvVer,
    iClntVer, False, False);
  TFDRDBMSKinds.NexusDB:     Result := TFDPhysNexusMetadata.Create(Self, iSrvVer, iClntVer);
  TFDRDBMSKinds.Informix:    Result := TFDPhysInfxMetadata.Create(Self, iSrvVer, iClntVer,
    GetKeywords, False, True);
  TFDRDBMSKinds.Teradata:    Result := TFDPhysTDataMetadata.Create(Self, iSrvVer, iClntVer,
    GetKeywords, True, tmTeradata);
  else                       Result := nil;
  end;
{$ELSE}
  Result := nil;
{$ENDIF}
  if (ODBCConnection <> nil) and ODBCConnection.Connected then
    Result := TFDPhysODBCMetadata.Create(Self, iSrvVer, iClntVer, TFDPhysConnectionMetadata(Result))
  else if Result = nil then
    Result := TFDPhysConnectionMetadata.Create(Self, iSrvVer, iClntVer, False);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysODBCDriver);

end.
