{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC DBX 4 Bridge driver              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys.TDBX;

interface

uses
  System.Classes,
  FireDAC.Phys.TDBXBase;

type
  TFDPhysTDBXDriverLink = class;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
  TFDPhysTDBXDriverLink = class(TFDPhysTDBXBaseDriverLink)
  protected
    function GetBaseDriverID: String; override;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.SysUtils, System.IniFiles, Data.DBXCommon, System.Variants,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts, FireDAC.Stan.Util,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.SQLGenerator, FireDAC.Phys.Meta,
{$IFNDEF FireDAC_MOBILE}
    FireDAC.Phys.MSAccMeta, FireDAC.Phys.MSSQLMeta, FireDAC.Phys.MySQLMeta,
    FireDAC.Phys.OracleMeta, FireDAC.Phys.DB2Meta, FireDAC.Phys.ASAMeta,
    FireDAC.Phys.ADSMeta, FireDAC.Phys.PGMeta, FireDAC.Phys.NexusMeta,
    FireDAC.Phys.InfxMeta,
{$ENDIF}
    FireDAC.Phys.TDBXMeta, FireDAC.Phys.IBMeta, FireDAC.Phys.SQLiteMeta,
    FireDAC.Phys.TDBXDef;

type
  TFDPhysTDBXDriver = class;
  TFDPhysTDBXConnection = class;

  TFDPhysTDBXDriver = class(TFDPhysTDBXDriverBase)
  private
    function GetDriverParams(AKeys: TStrings): TStrings;
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  end;

  TFDPhysTDBXConnection = class(TFDPhysTDBXConnectionBase)
  protected
    function InternalCreateMetadata: TObject; override;
    function InternalCreateCommandGenerator(const ACommand: IFDPhysCommand):
      TFDPhysCommandGenerator; override;
  end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDBXDriverLink                                                         }
{-------------------------------------------------------------------------------}
function TFDPhysTDBXDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_TDBXId;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDBXDriver                                                             }
{-------------------------------------------------------------------------------}
class function TFDPhysTDBXDriver.GetBaseDriverID: String;
begin
  Result := S_FD_TDBXId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysTDBXDriver.GetBaseDriverDesc: String;
begin
  Result := 'dbExpress Data Source';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysTDBXDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Other;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysTDBXDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysTDBXConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysTDBXConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXDriver.GetDriverParams(AKeys: TStrings): TStrings;
var
  sDrv: String;
  oIni: TCustomIniFile;
  i, j: Integer;
  oTab: TFDDatSTable;
begin
  Result := TFDStringList.Create;
  try
    sDrv := FDUnquote(AKeys.Values[TDBXPropertyNames.DriverName]);
    if sDrv <> '' then begin
      oIni := TMemIniFile.Create(CfgFile);
      try
        oIni.ReadSectionValues(sDrv, Result);
        oTab := inherited GetConnParams(AKeys, nil);
        try
          for i := oTab.Rows.Count - 1 downto 0 do begin
            j := Result.IndexOfName(oTab.Rows[i].GetData('Name'));
            if j <> -1 then
              Result.Delete(j);
          end;
        finally
          FDFree(oTab);
        end;
      finally
        FDFree(oIni);
      end;
    end;
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oView: TFDDatSView;
  oList, oList2: TStrings;
  oIni: TCustomIniFile;
  i: Integer;
  sName: String;
  oManMeta: IFDPhysManagerMetadata;
begin
  Result := inherited GetConnParams(AKeys, AParams);
  oView := Result.Select('Name=''' + S_FD_ConnParam_Common_Database + '''');
  if oView.Rows.Count = 1 then begin
    oView.Rows[0].BeginEdit;
    oView.Rows[0].SetValues('LoginIndex', 2);
    oView.Rows[0].EndEdit;
  end;

  oIni := TIniFile.Create(CfgFile);
  oList := TFDStringList.Create('"', ';');
  try
    oIni.ReadSection(TDBXPropertyNames.InstalledDrivers, oList);
    Result.Rows.Add([Unassigned, TDBXPropertyNames.DriverName, oList.DelimitedText, '', TDBXPropertyNames.DriverName, -1]);
  finally
    FDFree(oList);
    FDFree(oIni);
  end;

  oList := GetDriverParams(AKeys);
  try
    for i := 0 to oList.Count - 1 do begin
      sName := oList.KeyNames[i];
      oIni := TMemIniFile.Create(CfgFile);
      oList2 := TFDStringList.Create('"', ';');
      try
        oIni.ReadSection(sName, oList2);
        Result.Rows.Add([Unassigned, sName, oList2.DelimitedText, oList.ValueFromIndex[i], sName, -1]);
      finally
        FDFree(oList2);
        FDFree(oIni);
      end;
    end;
  finally
    FDFree(oList);
  end;

  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefCatalog, '@S', '', S_FD_ConnParam_Common_MetaDefCatalog, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefSchema, '@S', '', S_FD_ConnParam_Common_MetaDefSchema, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurCatalog, '@S', '', S_FD_ConnParam_Common_MetaCurCatalog, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurSchema, '@S', '', S_FD_ConnParam_Common_MetaCurSchema, -1]);

  oList := TStringList.Create(#0, ';');
  try
    FDPhysManager.CreateMetadata(oManMeta);
    oManMeta.GetRDBMSNames(oList);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_RDBMS, oList.DelimitedText, '', S_FD_ConnParam_Common_RDBMS, -1]);
  finally
    FDFree(oList);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDBXConnection                                                         }
{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
                                                                                 
  if ACommand <> nil then
    case GetRDBMSKindFromAlias of
{$IFNDEF FireDAC_MOBILE}
    TFDRDBMSKinds.Oracle:      Result := TFDPhysOraCommandGenerator.Create(ACommand, False);
    TFDRDBMSKinds.MSSQL:       Result := TFDPhysMSSQLCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.MSAccess:    Result := TFDPhysMSAccCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.MySQL:       Result := TFDPhysMySQLCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.Db2:         Result := TFDPhysDb2CommandGenerator.Create(ACommand);
    TFDRDBMSKinds.SQLAnywhere: Result := TFDPhysASACommandGenerator.Create(ACommand);
    TFDRDBMSKinds.Advantage:   Result := TFDPhysADSCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.PostgreSQL:  Result := TFDPhysPgCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.NexusDB:     Result := TFDPhysNexusCommandGenerator.Create(ACommand);
    TFDRDBMSKinds.Informix:    Result := TFDPhysInfxCommandGenerator.Create(ACommand);
{$ENDIF}
    TFDRDBMSKinds.Interbase,
    TFDRDBMSKinds.Firebird:    Result := TFDPhysIBCommandGenerator.Create(ACommand, 0, ecANSI);
    TFDRDBMSKinds.SQLite:      Result := TFDPhysSQLiteCommandGenerator.Create(ACommand);
    else                       Result := TFDPhysCommandGenerator.Create(ACommand);
    end
  else
    case GetRDBMSKindFromAlias of
{$IFNDEF FireDAC_MOBILE}
    TFDRDBMSKinds.Oracle:      Result := TFDPhysOraCommandGenerator.Create(Self, False);
    TFDRDBMSKinds.MSSQL:       Result := TFDPhysMSSQLCommandGenerator.Create(Self);
    TFDRDBMSKinds.MSAccess:    Result := TFDPhysMSAccCommandGenerator.Create(Self);
    TFDRDBMSKinds.MySQL:       Result := TFDPhysMySQLCommandGenerator.Create(Self);
    TFDRDBMSKinds.Db2:         Result := TFDPhysDb2CommandGenerator.Create(Self);
    TFDRDBMSKinds.SQLAnywhere: Result := TFDPhysASACommandGenerator.Create(Self);
    TFDRDBMSKinds.Advantage:   Result := TFDPhysADSCommandGenerator.Create(Self);
    TFDRDBMSKinds.PostgreSQL:  Result := TFDPhysPgCommandGenerator.Create(Self);
    TFDRDBMSKinds.NexusDB:     Result := TFDPhysNexusCommandGenerator.Create(Self);
    TFDRDBMSKinds.Informix:    Result := TFDPhysInfxCommandGenerator.Create(Self);
{$ENDIF}
    TFDRDBMSKinds.Interbase,
    TFDRDBMSKinds.Firebird:    Result := TFDPhysIBCommandGenerator.Create(Self, 0, ecANSI);
    TFDRDBMSKinds.SQLite:      Result := TFDPhysSQLiteCommandGenerator.Create(Self);
    else                       Result := TFDPhysCommandGenerator.Create(Self);
    end
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnection.InternalCreateMetadata: TObject;
var
  iSQLDialect: Integer;
  iClntVer: TFDVersion;
  eBrand: TFDPhysIBBrand;
begin
  if (DbxConnection <> nil) and (DbxConnection is TDBXConnection) then
    iClntVer := FDVerStr2Int(TDBXConnection(DbxConnection).ProductVersion)
  else
    iClntVer := 0;
                                                                        
  case GetRDBMSKindFromAlias of
{$IFNDEF FireDAC_MOBILE}
  TFDRDBMSKinds.Oracle:      Result := TFDPhysOraMetadata.Create(Self, iClntVer, iClntVer, False);
  TFDRDBMSKinds.MSSQL:       Result := TFDPhysMSSQLMetadata.Create(Self, False, True, True, True,
    False, 0, iClntVer, False);
  TFDRDBMSKinds.MSAccess:    Result := TFDPhysMSAccMetadata.Create(Self, 0, iClntVer, GetKeywords);
  TFDRDBMSKinds.MySQL:       Result := TFDPhysMySQLMetadata.Create(Self, False, 0, iClntVer,
    [nmCaseSens, nmDBApply], False);
  TFDRDBMSKinds.Db2:         Result := TFDPhysDb2Metadata.Create(Self, 0, iClntVer, GetKeywords, False, True);
  TFDRDBMSKinds.SQLAnywhere: Result := TFDPhysASAMetadata.Create(Self, 0, iClntVer, GetKeywords);
  TFDRDBMSKinds.Advantage:   Result := TFDPhysADSMetadata.Create(Self, 0, iClntVer, True);
  TFDRDBMSKinds.PostgreSQL:  Result := TFDPhysPgMetadata.Create(Self, 0, iClntVer, False, False, False, True);
  TFDRDBMSKinds.NexusDB:     Result := TFDPhysNexusMetadata.Create(Self, 0, iClntVer);
  TFDRDBMSKinds.Informix:    Result := TFDPhysInfxMetadata.Create(Self, 0, iClntVer,
    GetKeywords, False, True);
{$ENDIF}
  TFDRDBMSKinds.Interbase,
  TFDRDBMSKinds.Firebird:
    begin
      iSQLDialect := ConnectionDef.AsInteger[S_FD_ConnParam_IB_SQLDialect];
      if iSQLDialect = 0 then
        iSQLDialect := 3;
      if CompareText(DriverName, 'firebird') = 0 then
        eBrand := ibFirebird
      else
        eBrand := ibInterbase;
      Result := TFDPhysIBMetadata.Create(Self, eBrand, 0, iClntVer, iSQLDialect, False);
    end;
  TFDRDBMSKinds.SQLite:      Result := TFDPhysSQLiteMetadata.Create(Self, sbSQLite, 0,
    iClntVer, False, False);
  else
    if (DbxConnection <> nil) and DbxConnection.IsOpen then
      Result := TFDPhysTDBXMetadata.Create(Self, GetKeywords)
    else
      Result := TFDPhysConnectionMetadata.Create(Self, 0, 0, False);
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  try
    TDBXConnectionFactory.GetConnectionFactory;
    // if previous line passed OK, then TDBX is installed correctly
    FDPhysManager().RegisterDriverClass(TFDPhysTDBXDriver);
  except
    // none
  end;

end.
