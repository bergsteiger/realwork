{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{             FireDAC BDE Aliases Importer              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.BDE.Import;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts, FireDAC.Stan.Option;

type
  TFDAliasImportOverwriteEvent = procedure (const AName: String;
    var AOverwrite: Integer) of object;
  TFDBDEAliasImporter = class(TObject)
  private
    FSrcParams: TFDStringList;
    FDestParams: TStrings;
    FOpts: IFDStanOptions;
    FFetch: TFDFetchOptions;
    FFmt: TFDFormatOptions;
    FUpd: TFDUpdateOptions;
    FRes: TFDResourceOptions;
    FConnectionDefFileName: String;
    FOverwriteDefs: Boolean;
    FAliasesToImport: TFDStringList;
    FOnOverwrite: TFDAliasImportOverwriteEvent;
    function GetSrcBool(const AName: String; var AResult: Boolean): Boolean;
    function GetSrcInt(const AName: String; var AResult: Integer): Boolean;
    function GetSrcStr(const AName: String; var AResult: String): Boolean;
    procedure ImportSQLCommon;
    procedure ImportOracle(AImportMode: Boolean);
    procedure ImportIB(AImportMode: Boolean);
    procedure ImportMSSQL(AImportMode: Boolean);
    procedure ImportMSAccess(AImportMode: Boolean);
    procedure ImportODBC(AImportMode: Boolean);
    procedure ImportDB2(AImportMode: Boolean);
    procedure ImportMySQL(AImportMode: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
    procedure MakeBDECompatible(
      const AConnectionDef: IFDStanConnectionDef; AEnableBCD, AEnableInteger: Boolean);
    property ConnectionDefFileName: String read FConnectionDefFileName
      write FConnectionDefFileName;
    property AliasesToImport: TFDStringList read FAliasesToImport;
    property OverwriteDefs: Boolean read FOverwriteDefs write FOverwriteDefs;
    property OnOverwrite: TFDAliasImportOverwriteEvent read FOnOverwrite
      write FOnOverwrite;
  end;

implementation

uses
  VCL.Dialogs, System.SysUtils, Bde.DBTables, BDE,
  FireDAC.Stan.Factory, FireDAC.Stan.ResStrs, FireDAC.Stan.Error, FireDAC.Stan.Util,
  FireDAC.Phys.Intf, System.TypInfo;

const
  S_OpenODBC = 'OpenODBC';
  DRIVERNAME_KEY = 'DriverName';

{-------------------------------------------------------------------------------}
constructor TFDBDEAliasImporter.Create;
begin
  inherited Create;
  FAliasesToImport := TFDStringList.Create(dupAccept, True, False);
end;

{-------------------------------------------------------------------------------}
destructor TFDBDEAliasImporter.Destroy;
begin
  FDFreeAndNil(FAliasesToImport);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDBDEAliasImporter.GetSrcBool(const AName: String; var AResult: Boolean): Boolean;
var
  i: Integer;
begin
  i := FSrcParams.IndexOfName(AName);
  Result := i <> -1;
  AResult := False;
  if Result then
    AResult := CompareText(FSrcParams.Values[AName], S_FD_True) = 0;
end;

{-------------------------------------------------------------------------------}
function TFDBDEAliasImporter.GetSrcInt(const AName: String; var AResult: Integer): Boolean;
var
  i: Integer;
begin
  i := FSrcParams.IndexOfName(AName);
  Result := i <> -1;
  AResult := 0;
  if Result then
    AResult := StrToInt(FSrcParams.Values[AName]);
end;

{-------------------------------------------------------------------------------}
function TFDBDEAliasImporter.GetSrcStr(const AName: String; var AResult: String): Boolean;
var
  i: Integer;
begin
  i := FSrcParams.IndexOfName(AName);
  Result := i <> -1;
  AResult := '';
  if Result then
    AResult := FSrcParams.Values[AName];
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.ImportSQLCommon;
var
  sVal: String;
  iVal: Integer;
  lVal: Boolean;
begin
  if GetSrcInt(szROWSETSIZE, iVal) and (iVal <> 20) then
    FFetch.RowsetSize := iVal;
  if GetSrcInt(szBLOBCOUNT, iVal) and (iVal = 0) then
    if iVal > 0 then
      FFetch.Cache := FFetch.Cache + [fiBlobs]
    else
      FFetch.Cache := FFetch.Cache - [fiBlobs];
  if GetSrcBool(szENABLESCHEMACACHE, lVal) then
    if lVal then
      FFetch.Cache := FFetch.Cache + [fiMeta]
    else
      FFetch.Cache := FFetch.Cache - [fiMeta];
  if GetSrcInt(szMAXROWS, iVal) and (iVal <> -1) then
    FFetch.RecsMax := iVal;
  if GetSrcStr(szPASSWORD, sVal) and (sVal <> '') then
    FDestParams.Values[S_FD_ConnParam_Common_Password] := sVal;
  if (GetSrcStr(szUSERNAME, sVal) or GetSrcStr(UpperCase(S_FD_ConnParam_Common_BDEStyleUserName), sVal)) and
     (sVal <> '') then
    FDestParams.Values[S_FD_ConnParam_Common_UserName] := sVal;
  if GetSrcInt(szCFGDRVTRACEMODE, iVal) and (iVal > 0) then begin
    if iVal <> 0 then
      sVal := S_FD_MoniRemote
    else
      sVal := '';
    FDestParams.Values[S_FD_ConnParam_Common_MonitorBy] := sVal;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.ImportOracle(AImportMode: Boolean);
var
  sVal: String;
  lVal: Boolean;
  oRule: TFDMapRule;
begin
  if AImportMode then
    FDestParams.Values[S_FD_ConnParam_Common_DriverID] := S_FD_OraId;
  FFmt.OwnMapRules := True;
  FFmt.MaxBcdPrecision := $7FFFFFFF;
  FFmt.MaxBcdScale := $7FFFFFFF;
  if GetSrcBool(szORAINTEGER, lVal) and lVal then begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtBCD;
    oRule.ScaleMin := 0;
    oRule.ScaleMax := 0;
    oRule.PrecMin := 0;
    oRule.PrecMax := 5;
    oRule.TargetDataType := dtInt16;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtBCD;
    oRule.ScaleMin := 0;
    oRule.ScaleMax := 0;
    oRule.PrecMin := 6;
    oRule.PrecMax := 10;
    oRule.TargetDataType := dtInt32;
  end;
  if GetSrcBool(szCFGDBENABLEBCD, lVal) and lVal then begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtDouble;
    oRule.TargetDataType := dtBCD;
  end
  else begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtBCD;
    oRule.TargetDataType := dtDouble;
  end;
  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtAnsiString;
  oRule.SizeMin := 256;
  oRule.TargetDataType := dtMemo;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtWideString;
  oRule.SizeMax := 255;
  oRule.TargetDataType := dtAnsiString;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtWideString;
  oRule.SizeMin := 256;
  oRule.TargetDataType := dtMemo;

  if AImportMode then begin
    if GetSrcStr(szCFGDRVVENDINIT, sVal) and (CompareText(sVal, 'OCI.DLL') <> 0) then
      FDestParams.Values[S_FD_DrvVendorLib] := sVal;
    if GetSrcStr(szSERVERNAME, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_Database] := sVal;
    ImportSQLCommon;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.ImportIB(AImportMode: Boolean);
var
  sVal: String;
  lVal: Boolean;
  oRule: TFDMapRule;
begin
  // all TX related settings are not imported
  if AImportMode then
    FDestParams.Values[S_FD_ConnParam_Common_DriverID] := S_FD_IBId;
  FFmt.OwnMapRules := True;
  FFmt.MaxBcdPrecision := $7FFFFFFF;
  FFmt.MaxBcdScale := $7FFFFFFF;
  if GetSrcBool(szCFGDBENABLEBCD, lVal) and lVal then begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtCurrency;
    oRule.TargetDataType := dtBCD;
  end
  else begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtBCD;
    oRule.TargetDataType := dtDouble;
  end;
  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtAnsiString;
  oRule.SizeMin := 256;
  oRule.TargetDataType := dtMemo;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtByteString;
  oRule.SizeMin := 256;
  oRule.TargetDataType := dtMemo;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtWideString;
  oRule.SizeMax := 255;
  oRule.TargetDataType := dtAnsiString;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtWideString;
  oRule.SizeMin := 256;
  oRule.TargetDataType := dtMemo;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtDateTimeStamp;
  oRule.TargetDataType := dtDateTime;

  if AImportMode then begin
    if GetSrcStr(szCFGDRVVENDINIT, sVal) and (CompareText(sVal, 'GDS32.DLL') <> 0) then
      FDestParams.Values[S_FD_DrvVendorLib] := sVal;
    if GetSrcStr(szSERVERNAME, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_Database] := sVal;
    ImportSQLCommon;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.ImportMSSQL(AImportMode: Boolean);
var
  sVal: String;
  lVal: Boolean;
  iVal: Integer;
  oRule: TFDMapRule;
begin
  if AImportMode then
    FDestParams.Values[S_FD_ConnParam_Common_DriverID] := S_FD_MSSQLId;
  FFmt.OwnMapRules := True;
  FFmt.MaxBcdPrecision := $7FFFFFFF;
  FFmt.MaxBcdScale := $7FFFFFFF;
  if GetSrcBool(szCFGDBENABLEBCD, lVal) and lVal then begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtDouble;
    oRule.ScaleMin := 1;
    oRule.TargetDataType := dtBCD;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtDouble;
    oRule.ScaleMin := 1;
    oRule.PrecMax := 17;
    oRule.TargetDataType := dtBCD;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtDouble;
    oRule.ScaleMin := 1;
    oRule.PrecMin := 19;
    oRule.TargetDataType := dtBCD;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtInt64;
    oRule.TargetDataType := dtBCD;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtCurrency;
    oRule.TargetDataType := dtBCD;
  end
  else begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtBCD;
    oRule.TargetDataType := dtDouble;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtInt64;
    oRule.TargetDataType := dtDouble;
  end;
  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtDateTimeStamp;
  oRule.TargetDataType := dtDateTime;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtByte;
  oRule.TargetDataType := dtInt16;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtGUID;
  oRule.TargetDataType := dtByteString;

  if AImportMode then begin
    if GetSrcInt(szMAXQUERYTIME, iVal) and (iVal <> $7FFFFFFF) then
      FRes.CmdExecTimeout := iVal * 1000;
    if GetSrcStr(szSYBLAPP, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_ApplicationName] := sVal;
    if GetSrcStr(szDATABASENAME, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_Database] := sVal;
    if GetSrcStr(szSYBLHOST, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_MSSQL_Address] := sVal;
    if GetSrcStr(szSYBLNATLANG, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_MSSQL_Language] := sVal;
    if GetSrcStr(szSERVERNAME, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_Server] := sVal;
    ImportSQLCommon;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.ImportMSAccess(AImportMode: Boolean);
var
  sVal: String;
  oRule: TFDMapRule;
begin
  if AImportMode then
    FDestParams.Values[S_FD_ConnParam_Common_DriverID] := S_FD_MSAccId;
  FFmt.OwnMapRules := True;
  FFmt.MaxBcdPrecision := $7FFFFFFF;
  FFmt.MaxBcdScale := $7FFFFFFF;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtBCD;
  oRule.TargetDataType := dtDouble;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtDateTimeStamp;
  oRule.TargetDataType := dtDateTime;

  if AImportMode then begin
    if GetSrcStr(szDATABASENAME, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_Database] := sVal;
    if GetSrcStr(szCFGSYSTEMDB, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_MSAcc_SystemDB] := sVal;
    if GetSrcStr(szUSERNAME, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_UserName] := sVal;
    if GetSrcStr(szPASSWORD, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_Password] := sVal;
    if GetSrcStr(szOPENMODE, sVal) and (CompareText(sVal, szREADONLY) = 0) then
      FDestParams.Values[S_FD_ConnParam_MSAcc_ReadOnly] := S_FD_True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.ImportDB2(AImportMode: Boolean);
var
  sVal: String;
  lVal: Boolean;
  iVal: Integer;
  oRule: TFDMapRule;
begin
  if AImportMode then
    FDestParams.Values[S_FD_ConnParam_Common_DriverID] := S_FD_DB2Id;
  FFmt.OwnMapRules := True;
  FFmt.MaxBcdPrecision := $7FFFFFFF;
  FFmt.MaxBcdScale := $7FFFFFFF;

  if not (GetSrcBool(szCFGDBENABLEBCD, lVal) and lVal) then begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtBCD;
    oRule.TargetDataType := dtDouble;
  end;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtDateTimeStamp;
  oRule.TargetDataType := dtDateTime;

  if AImportMode then begin
    if GetSrcInt(szMAXQUERYTIME, iVal) and (iVal <> $7FFFFFFF) then
      FRes.CmdExecTimeout := iVal * 1000;
    if GetSrcStr('DB2 DSN', sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_DB2_Alias] := sVal;
    ImportSQLCommon;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.ImportMySQL(AImportMode: Boolean);
begin
                                                                       
  ImportODBC(AImportMode);
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.ImportODBC(AImportMode: Boolean);
var
  sDrv, sVal: String;
  lVal: Boolean;
  oRule: TFDMapRule;
begin
  if GetSrcStr(szCFGODBCDSN, sVal) then begin
                                                           
                                                          
  end;
  if AImportMode then
    FDestParams.Values[S_FD_ConnParam_Common_DriverID] := S_FD_ODBCId;
  FFmt.OwnMapRules := True;
  FFmt.MaxBcdPrecision := $7FFFFFFF;
  FFmt.MaxBcdScale := $7FFFFFFF;
  if GetSrcBool(szCFGDBENABLEBCD, lVal) and lVal then begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtDouble;
    oRule.ScaleMin := 1;
    oRule.TargetDataType := dtBCD;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtDouble;
    oRule.ScaleMin := 1;
    oRule.PrecMax := 17;
    oRule.TargetDataType := dtBCD;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtDouble;
    oRule.ScaleMin := 1;
    oRule.PrecMin := 19;
    oRule.TargetDataType := dtBCD;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtBCD;
    oRule.ScaleMin := 0;
    oRule.ScaleMax := 0;
    oRule.PrecMin := 18;
    oRule.PrecMax := 18;
    oRule.TargetDataType := dtDouble;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtInt64;
    oRule.TargetDataType := dtBCD;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtCurrency;
    oRule.TargetDataType := dtBCD;
  end
  else begin
    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtBCD;
    oRule.TargetDataType := dtDouble;

    oRule := FFmt.MapRules.Add;
    oRule.SourceDataType := dtInt64;
    oRule.TargetDataType := dtDouble;
  end;
  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtDateTimeStamp;
  oRule.TargetDataType := dtDateTime;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtByte;
  oRule.TargetDataType := dtInt16;

  oRule := FFmt.MapRules.Add;
  oRule.SourceDataType := dtGUID;
  oRule.TargetDataType := dtByteString;

  if AImportMode then begin
    if GetSrcStr(szTYPe, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_ODBC_ODBCDriver] := sVal;
    if GetSrcStr(szCFGODBCDSN, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_ODBC_DataSource] := sVal;
    if GetSrcStr(szDATABASENAME, sVal) and (sVal <> '') then
      FDestParams.Values[S_FD_ConnParam_Common_Database] := sDrv;
    ImportSQLCommon;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.MakeBDECompatible(
  const AConnectionDef: IFDStanConnectionDef; AEnableBCD, AEnableInteger: Boolean);
var
  sDrv: String;
  oManMeta: IFDPhysManagerMetadata;
  iKind: TFDRDBMSKind;
begin
  FSrcParams := TFDStringList.Create(dupAccept, True, False);
  if AEnableBCD then
    FSrcParams.Add(szCFGDBENABLEBCD + '=' + UpperCase(S_FD_True));
  if AEnableInteger then
    FSrcParams.Add(szORAINTEGER + '=' + UpperCase(S_FD_True));

  FDestParams := AConnectionDef.Params;
  FFetch := TFDFetchOptions.Create(nil);
  FFmt := TFDFormatOptions.Create(nil);
  FUpd := TFDUpdateOptions.Create(nil);
  FRes := TFDResourceOptions.Create(nil);
  AConnectionDef.ReadOptions(FFmt, FUpd, FFetch, FRes);

  try
    FDPhysManager.CreateMetadata(oManMeta);
    iKind := oManMeta.GetRDBMSKind(AConnectionDef.Params.DriverID);
    if iKind = TFDRDBMSKinds.Other then begin
      sDrv := UpperCase(AConnectionDef.AsString[DRIVERNAME_KEY]);
      if sDrv = '' then
        Exit;
      if CompareText(sDrv, S_OpenODBC) <> 0 then
        raise Exception.Create(S_FD_CantMakeConnDefBDEComp);
      iKind := oManMeta.GetRDBMSKind(AConnectionDef.AsString[S_FD_ConnParam_Common_RDBMS]);
    end;
    case iKind of
    TFDRDBMSKinds.Oracle:    ImportOracle(False);
    TFDRDBMSKinds.Interbase: ImportIB(False);
    TFDRDBMSKinds.MySQL:     ImportMySQL(False);
    TFDRDBMSKinds.MSSQL:     ImportMSSQL(False);
    TFDRDBMSKinds.MSAccess:  ImportMSAccess(False);
    TFDRDBMSKinds.DB2:       ImportDB2(False);
    else                     ImportODBC(False);
    end;
    AConnectionDef.WriteOptions(FFmt, FUpd, FFetch, FRes);

  finally
    FDFreeAndNil(FSrcParams);
    FDestParams := nil;
    FDFreeAndNil(FFetch);
    FDFreeAndNil(FFmt);
    FDFreeAndNil(FUpd);
    FDFreeAndNil(FRes);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBDEAliasImporter.Execute;
var
  i, j: Integer;
  oAliases, oDrvParams: TFDStringList;
  sType, sName: String;
  oDefs: IFDStanConnectionDefs;
  oDef: IFDStanConnectionDef;
  iOverwrite: Integer;
  oManMeta: IFDPhysManagerMetadata;
begin
  oAliases := TFDStringList.Create;
  oDrvParams := TFDStringList.Create;
  FSrcParams := TFDStringList.Create(dupAccept, True, False);
  FDestParams := TFDStringList.Create;
  FOpts := TFDOptionsContainer.Create(nil, TFDFetchOptions, TFDUpdateOptions,
    TFDResourceOptions, nil);
  FFetch := FOpts.FetchOptions;
  FFmt := FOpts.FormatOptions;
  FUpd := FOpts.UpdateOptions;
  FRes := FOpts.ResourceOptions;
  FDCreateInterface(IFDStanConnectionDefs, oDefs);
  if FConnectionDefFileName <> '' then
    oDefs.Storage.FileName := FConnectionDefFileName;
  oDefs.Load;
  try
    Session.GetAliasNames(oAliases);
    for i := 0 to oAliases.Count - 1 do
      if (FAliasesToImport.Count = 0) or (FAliasesToImport.IndexOf(oAliases[i]) <> -1) then begin
        FDestParams.Clear;
        sType := Session.GetAliasDriverName(oAliases[i]);
        Session.GetDriverParams(sType, oDrvParams);
        Session.GetAliasParams(oAliases[i], FSrcParams);
        for j := 0 to oDrvParams.Count - 1 do
          if FSrcParams.IndexOfName(oDrvParams.KeyNames[j]) = -1 then
            FSrcParams.Add(oDrvParams[j]);
        FDPhysManager.CreateMetadata(oManMeta);
        case oManMeta.GetRDBMSKind(sType) of
        TFDRDBMSKinds.Oracle:    ImportOracle(True);
        TFDRDBMSKinds.Interbase: ImportIB(True);
        TFDRDBMSKinds.MSSQL:     ImportMSSQL(True);
        TFDRDBMSKinds.MSAccess:  ImportMSAccess(True);
        TFDRDBMSKinds.DB2:       ImportDB2(True);
        else
          if FSrcParams.IndexOfName(szCFGODBCDSN) <> -1 then
            ImportODBC(True)
          else begin
            ShowMessage(Format('BDE driver [%s] is not supported.'#13#10 +
                               'Alias [%s] cannot be converted.', [sType, oAliases[i]]));
            Continue;
          end;
        end;
        if OverwriteDefs then begin
          oDef := oDefs.FindConnectionDef(oAliases[i]);
          if (oDef <> nil) and Assigned(FOnOverwrite) then begin
            iOverwrite := 1;
            FOnOverwrite(oAliases[i], iOverwrite);
            if iOverwrite = 0 then
              oDef := nil
            else if iOverwrite = -1 then
              Exit;
          end
        end
        else
          oDef := nil;
        if oDef = nil then
          oDef := oDefs.Add as IFDStanConnectionDef;
        oDef.Params.SetStrings(FDestParams);
        sName := oAliases[i];
        if not OverwriteDefs then begin
          j := 0;
          while oDefs.FindConnectionDef(sName) <> nil do begin
            Inc(j);
            sName := Format('%s_%d', [oAliases[i], j]);
          end;
        end;
        oDef.Name := sName;
        oDef.WriteOptions(FFmt, FUpd, FFetch, FRes);
        oDef.MarkPersistent;
      end;
    oDefs.Save;
  finally
    FDFreeAndNil(oAliases);
    FDFreeAndNil(oDrvParams);
    FDFreeAndNil(FSrcParams);
    FDFreeAndNil(FDestParams);
    FFetch := nil;
    FFmt := nil;
    FUpd := nil;
    FRes := nil;
    FOpts := nil;
  end;
end;

(*
--------------------------
ALL

'TYPE'                f('DriverID') # not dbExpress
                      'DriverId = S_FD_TDBXId' & 'DriverName = Oracle' # dbExpress
'DLL32'               x

--------------------------
SQL Common

'BLOB SIZE'           'BlobSize' # dbExpress
'BLOBS TO CACHE'      f('FetchOptions.Cache' & fiBlobs)
'ENABLE SCHEMA CACHE' f('FetchOptions.Cache' & fiMeta)
'LANGDRIVER'          x
'MAX ROWS'            'FetchOptions.RecsMax'
'PASSWORD'            'Password'
'SCHEMA CACHE DIR'    x
'SCHEMA CACHE SIZE'   x
'SCHEMA CACHE TIME'   x
'SQLPASSTHRU MODE'    x
'SQLQRYMODE'          x
'USER NAME'           'User_Name'
'TRACE MODE'          'Tracing'

--------------------------
Oracle

'ENABLE BCD'          f('FormatOptions.MapRules')
'ENABLE INTEGERS'     f('FormatOptions.MapRules')
'LIST SYNONYMS'       x
'NET PROTOCOL'        x
'OBJECT MODE'         x
'ROWSET SIZE'         'FetchOptions.RowsetSize' # not dbExpress
                      'RowsetSize'              # dbExpress
'SERVER NAME'         'Database'
'VENDOR INIT'         'VendorLib'

--------------------------
MSSQL

'APPLICATION NAME'    'App'=v
'BLOB EDIT LOGGING'   x
'CONNECT TIMEOUT'     x
'DATABASE NAME'       'Database'=v
'DATE MODE'           x
'ENABLE BCD'          f('FormatOptions.MapRules')
'HOST NAME'           'Address'=v
'NATIONAL LANG NAME'  'Language'=v
'MAX QUERY TIME'      'ResourceOptions.CmdExecTimeout'=v*1000
'SERVER NAME'         'Server'=v
'TDS PACKET SIZE'     x
'TIMEOUT'             x

--------------------------
IB
'BATCH COUNT'         x
'COMMIT RETAIN'       ?
'ENABLE BCD'          f('FormatOptions.MapRules')
'OPEN MODE'           ?
'ROLE NAME'           'RoleName'=v
'SERVER NAME'         'Database'=v
'WAIT ON LOCKS'       ?

--------------------------
MSAccess

'DATABASE NAME'       'DBQ'=v
'LANGDRIVER'          x
'OPEN MODE'           'ReadOnly'=READ/WRITE -> 0, READ ONLY -> 1
'SYSTEM DATABASE'     'SystemDB'=v
'USER NAME'           'UID'=v
'PASSWORD'            'PWD'=v


--------------------------
ODBC

'BATCH COUNT'         x
'DATABASE NAME'       'Database'=v
'ENABLE BCD'          f('FormatOptions.MapRules')
'ODBC DSN'            'DSN'=v
'OPEN MODE'           'ReadOnly'=READ/WRITE -> 0, READ ONLY -> 1
'ROWSET SIZE'         'FetchOptions.RowsetSize' # not dbExpress
                      'RowsetSize'              # dbExpress
*)
end.

