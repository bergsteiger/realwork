{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC InterBase driver                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$IF DEFINED(IOS) OR DEFINED(ANDROID)}
  {$HPPEMIT LINKUNIT}
{$ELSE}
  {$IFDEF WIN32}
    {$HPPEMIT '#pragma link "FireDAC.Phys.IB.obj"'}
  {$ELSE}
    {$HPPEMIT '#pragma link "FireDAC.Phys.IB.o"'}
  {$ENDIF}
{$ENDIF}

unit FireDAC.Phys.IB;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.DatS,
  FireDAC.Phys, FireDAC.Phys.IBWrapper, FireDAC.Phys.IBBase;

type
  TFDPhysIBDriverLink = class;
  TFDIBSDump = class;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDPhysIBDriverLink = class(TFDPhysIBBaseDriverLink)
  private
    FLite: Boolean;
  protected
    function GetBaseDriverID: String; override;
    function IsConfigured: Boolean; override;
    procedure ApplyTo(const AParams: IFDStanDefinition); override;
  published
    property Lite: Boolean read FLite write FLite default False;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDIBSDump = class (TFDIBService)
  private
    FDatabase: String;
    FBackupFiles: TStrings;
    FOverwrite: Boolean;
    FOptions: TIBSDumpOptions;
    procedure SetBackupFiles(const AValue: TStrings);
  protected
    function CreateService(AEnv: TIBEnv): TIBService; override;
    procedure SetupService(AService: TIBService); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Dump;
  published
    property Database: String read FDatabase write FDatabase;
    property BackupFiles: TStrings read FBackupFiles write SetBackupFiles;
    property Overwrite: Boolean read FOverwrite write FOverwrite default False;
    property Options: TIBSDumpOptions read FOptions write FOptions default [];
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.Variants, System.SysUtils, Data.DB,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Stan.Option, FireDAC.Stan.Util,
    FireDAC.Stan.Consts, FireDAC.Stan.ResStrs,
  FireDAC.Phys.Intf, FireDAC.Phys.IBMeta, FireDAC.Phys.SQLGenerator,
    FireDAC.Phys.IBCli, FireDAC.Phys.IBDef, FireDAC.Phys.IBLiteDef;

type
  TFDPhysIBDriver = class;
  TFDPhysIBLiteDriver = class;
  TFDPhysIBConnection = class;
  TFDPhysIBCommand = class;

  TFDPhysIBDriver = class(TFDPhysIBDriverBase)
  protected
    procedure InternalLoad; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
    function GetLite: Boolean; virtual;
  end;

  TFDPhysIBLiteDriver = class(TFDPhysIBDriver)
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    function GetLite: Boolean; override;
  end;

  TFDPhysIBConnection = class(TFDPhysIBConnectionBase)
  protected
    function InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    procedure BuildIBConnectParams(AParams: TStrings;
      const AConnectionDef: IFDStanConnectionDef); override;
    procedure InternalAnalyzeSession(AMessages: TStrings); override;
  end;

  TFDPhysIBEventAlerter = class(TFDPhysIBEventAlerterBase)
  private
    procedure DoRefreshHandler(const ASub: IFDPhysChangeHandler);
  protected
    procedure InternalRefresh(const ASubscription: IFDPhysChangeHandler); override;
  end;

  TFDPhysIBCommand = class(TFDPhysIBCommandBase)
  private
    procedure DoExecuteIB2007Batch(ATimes, AOffset: Integer; var ACount: TFDCounter);
  protected
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    procedure ProcessMetaColumn(ATable: TFDDatSTable; AFmtOpts: TFDFormatOptions;
      AColIndex: Integer; ARow: TFDDatSRow; ApInfo: PFDIBColInfoRec; ARowIndex: Integer); override;
  end;

{-------------------------------------------------------------------------------}
{ TFDPhysIBDriverLink                                                           }
{-------------------------------------------------------------------------------}
function TFDPhysIBDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_IBId;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBDriverLink.ApplyTo(const AParams: IFDStanDefinition);
begin
  inherited ApplyTo(AParams);
  if Lite then
    AParams.AsYesNo[S_FD_ConnParam_IB_Lite] := Lite;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBDriverLink.IsConfigured: Boolean;
begin
  Result := inherited IsConfigured or Lite;
end;

{-------------------------------------------------------------------------------}
{ TFDIBSDump                                                                    }
{-------------------------------------------------------------------------------}
constructor TFDIBSDump.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBackupFiles := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDIBSDump.Destroy;
begin
  FDFreeAndNil(FBackupFiles);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDIBSDump.SetBackupFiles(const AValue: TStrings);
begin
  FBackupFiles.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDIBSDump.CreateService(AEnv: TIBEnv): TIBService;
begin
  Result := TIBSDump.Create(AEnv, Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDIBSDump.SetupService(AService: TIBService);
begin
  inherited SetupService(AService);
  TIBSDump(AService).DatabaseName := FDExpandStr(Database);
  TIBSDump(AService).BackupFiles := BackupFiles;
  FDExpandStrs(TIBSDump(AService).BackupFiles);
  TIBSDump(AService).Overwrite := Overwrite;
  TIBSDump(AService).Options := Options;
end;

{-------------------------------------------------------------------------------}
procedure TFDIBSDump.Dump;
begin
  Execute;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysIBDriver                                                               }
{-------------------------------------------------------------------------------}
procedure TFDPhysIBDriver.InternalLoad;
var
  sHome, sLib: String;
begin
  sHome := '';
  sLib := '';
  GetVendorParams(sHome, sLib);
  FLib.LoadIB(sHome, sLib, GetLite());
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysIBConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
class function TFDPhysIBDriver.GetBaseDriverID: String;
begin
  Result := S_FD_IBId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysIBDriver.GetBaseDriverDesc: String;
begin
  Result := 'InterBase';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysIBDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Interbase;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysIBDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysIBConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oView: TFDDatSView;
  i: Integer;
  sName: String;
begin
  Result := inherited GetConnParams(AKeys, AParams);
  oView := Result.Select('Name=''' + S_FD_ConnParam_Common_Database + '''');
  if oView.Rows.Count = 1 then begin
    oView.Rows[0].BeginEdit;
    oView.Rows[0].SetValues('Type', '@F:InterBase Database|*.gdb;*.ib');
    oView.Rows[0].EndEdit;
  end;

  if GetLite() then
    for i := Result.Rows.Count - 1 downto 0 do begin
      sName := Result.Rows[i].GetData('Name');
      if (CompareText(sName, S_FD_ConnParam_Common_Pooled) = 0) or
         (CompareText(sName, S_FD_ConnParam_Common_OSAuthent) = 0) or
         (CompareText(sName, S_FD_ConnParam_IB_Protocol) = 0) or
         (CompareText(sName, S_FD_ConnParam_Common_Server) = 0) or
         (CompareText(sName, S_FD_ConnParam_Common_Port) = 0) or
         (CompareText(sName, S_FD_ConnParam_IB_SQLDialect) = 0) or
         (CompareText(sName, S_FD_ConnParam_IB_RoleName) = 0) then
        Result.Rows[i].Delete();
    end
  else begin
    Result.Rows.Add([Unassigned, S_FD_ConnParam_IB_InstanceName, '@S', '', S_FD_ConnParam_IB_InstanceName, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_IB_SEPassword, '@P', '', S_FD_ConnParam_IB_SEPassword, -1]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBDriver.GetLite: Boolean;
begin
  Result := (Params <> nil) and Params.AsYesNo[S_FD_ConnParam_IB_Lite];
end;

{-------------------------------------------------------------------------------}
{ TFDPhysIBLiteDriver                                                           }
{-------------------------------------------------------------------------------}
class function TFDPhysIBLiteDriver.GetBaseDriverID: String;
begin
  Result := S_FD_IBLiteId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysIBLiteDriver.GetBaseDriverDesc: String;
begin
  Result := 'InterBase Lite';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysIBLiteDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysIBLiteConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBLiteDriver.GetLite: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysIBConnection                                                           }
{-------------------------------------------------------------------------------}
function TFDPhysIBConnection.InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter;
begin
  if CompareText(AEventKind, S_FD_EventKind_IB_Events) = 0 then
    Result := TFDPhysIBEventAlerter.Create(Self, AEventKind)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBConnection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysIBCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBConnection.BuildIBConnectParams(AParams: TStrings;
  const AConnectionDef: IFDStanConnectionDef);
var
  oParams: TFDPhysIBConnectionDefParams;
begin
  inherited BuildIBConnectParams(AParams, AConnectionDef);
  if ConnectionDef.Params is TFDPhysIBConnectionDefParams then begin
    oParams := ConnectionDef.Params as TFDPhysIBConnectionDefParams;
    if ConnectionDef.HasValue(S_FD_ConnParam_IB_InstanceName) then
      AParams.Add('instance_name=' + oParams.InstanceName);
    if ConnectionDef.HasValue(S_FD_ConnParam_IB_SEPassword) then
      AParams.Add('sys_encrypt_password=' + oParams.SEPassword);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBConnection.InternalAnalyzeSession(AMessages: TStrings);
begin
  inherited InternalAnalyzeSession(AMessages);

  // 3. Use IB driver to connect to InterBase server with gds32.dll
  if ServerBrand <> ibInterbase then
    AMessages.Add(S_FD_IBWarnNotIBSrv);
  if IBEnv.Lib.Brand <> ibInterbase then
    AMessages.Add(S_FD_IBWarnNotIBClnt);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysIBEventAlerter                                                         }
{-------------------------------------------------------------------------------}
procedure TFDPhysIBEventAlerter.DoRefreshHandler(const ASub: IFDPhysChangeHandler);
var
  oSrcMan: TFDDatSManager;
  oSrcTab: TFDDatSTable;
  i: Integer;
begin
  if ASub.MergeManager <> nil then begin
    oSrcMan := TFDDatSManager.Create;
    oSrcTab := nil;
  end
  else begin
    oSrcMan := nil;
    oSrcTab := TFDDatSTable.Create;
  end;

  try
    if ASub.TrackCommand.State = csOpen then begin
      if ASub.TrackCommand.Options.FetchOptions.AutoFetchAll = afAll then
        if ASub.MergeManager <> nil then
          ASub.TrackCommand.Fetch(ASub.MergeManager, mmRely)
        else
          ASub.TrackCommand.Fetch(ASub.MergeTable, True, True);
      ASub.TrackCommand.CloseAll;
    end;

    ASub.TrackCommand.Prepare;
    ASub.TrackCommand.Open;

    if oSrcMan <> nil then begin
      oSrcMan.Assign(ASub.MergeManager);
      ASub.TrackCommand.Fetch(oSrcMan, mmRely);
      ASub.MergeManager.Merge(oSrcMan, GetOptions.MergeData, mmNone, []);
      for i := 0 to oSrcMan.Tables.Count - 1 do
        if oSrcMan.Tables[i].Rows.Count > 0 then begin
          ASub.ResyncContent;
          Break;
        end;
    end

    else begin
      oSrcTab.Assign(ASub.MergeTable);
      ASub.TrackCommand.Fetch(oSrcTab, True, True);
      ASub.MergeTable.Merge(oSrcTab, GetOptions.MergeData, mmNone, []);
      if oSrcTab.Rows.Count > 0 then
        ASub.ResyncContent;
    end;
  finally
    FDFree(oSrcMan);
    FDFree(oSrcTab);
    ASub.ContentModified := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBEventAlerter.InternalRefresh(const ASubscription: IFDPhysChangeHandler);
var
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
  sSub, sDev: String;
  oHnlr: IFDPhysChangeHandler;
  oTx: IFDPhysTransaction;
  lStartTX: Boolean;
  ePrevIsol: TFDTxIsolation;
  oCmd: IFDPhysCommand;
  i: Integer;
begin
  GetConnection.CreateMetadata(oConnMeta);
  if (GetSubscriptionName = '') or
     not (((oConnMeta as IFDPhysIBConnectionMetadata).Brand = ibInterbase) and
          (oConnMeta.ServerVersion >= ivIB120000) and
          (oConnMeta.ClientVersion >= ivIB120000)) then begin
    inherited InternalRefresh(ASubscription);
    Exit;
  end;

  sDev := '';
  sSub := GetSubscriptionName;
  i := Pos(';', sSub);
  if i <> 0 then begin
    sDev := Copy(sSub, i + 1, Length(sSub));
    sSub := Copy(sSub, 1, i - 1);
    if sDev <> '' then
      sDev := ' AT ' + QuotedStr(sDev);
  end;
  rName.FObject := sSub;
  sSub := oConnMeta.EncodeObjName(rName, nil, [eoNormalize]);

  if ASubscription <> nil then
    oHnlr := ASubscription
  else
    oHnlr := FChangeHandlers[0] as IFDPhysChangeHandler;
  oTx := oHnlr.TrackCommand.Transaction;
  if oTx = nil then
    oTx := GetConnection.Transaction;

  lStartTX := not oTx.Active;
  ePrevIsol := oTx.Options.Isolation;
  if lStartTX then begin
    oTx.Options.Isolation := xiSnapshot;
    oTx.StartTransaction;
  end;

  try
    GetConnection.CreateCommand(oCmd);
    SetupCommand(oCmd);
    oCmd.Prepare('SET SUBSCRIPTION ' + sSub + sDev + ' ACTIVE');
    oCmd.Execute();
    try

      if ASubscription <> nil then begin
        if IsRunning and ASubscription.ContentModified then
          DoRefreshHandler(ASubscription);
      end
      else
        for i := FChangeHandlers.Count - 1 to 0 do begin
          if not IsRunning then
            Break;
          oHnlr := FChangeHandlers[i] as IFDPhysChangeHandler;
          if oHnlr.ContentModified then
            DoRefreshHandler(oHnlr);
        end;

    finally
      oCmd.Prepare('SET SUBSCRIPTION ' + sSub + sDev + ' INACTIVE');
      oCmd.Execute();
    end;

    if lStartTX then begin
      oTx.Commit;
      oTx.Options.Isolation := ePrevIsol;
    end;

  except
    if lStartTX then begin
      oTx.Rollback;
      oTx.Options.Isolation := ePrevIsol;
    end;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysIBCommand                                                              }
{-------------------------------------------------------------------------------}
procedure TFDPhysIBCommand.DoExecuteIB2007Batch(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
var
  iBatchSize, iRows: LongWord;
  iCurTimes, iCurOffset, i: Integer;
  oResOpts: TFDResourceOptions;
begin
  oResOpts := FOptions.ResourceOptions;
  // total size of XSQLVAR, which will be send to server in single packet
  iBatchSize := FStmt.MaximumBatchSize;
  if iBatchSize > LongWord(oResOpts.ArrayDMLSize) then
    iBatchSize := LongWord(oResOpts.ArrayDMLSize);

  // If block will have only single command or there are OUT params, then go
  // by standard route - execute command once for each param array item.
  if (iBatchSize <= 1) or (FStmt.OutVars.VarCount > 0) then begin
    DoExecute(ATimes, AOffset, ACount, False);
    Exit;
  end;

  iCurOffset := AOffset;
  iCurTimes := LongWord(AOffset) + iBatchSize;
  while iCurOffset < ATimes do begin
    if iCurTimes > ATimes then
      iCurTimes := ATimes;
    FStmt.InVars.RowCount := Word(iCurTimes - iCurOffset);
    SetParamValues(iCurTimes, iCurOffset);
    CheckArrayDMLWithIntStr(iCurTimes, iCurOffset);
    try
      try
        FStmt.ExecuteBatch;
      finally
        if FStmt <> nil then
          for i := 0 to FStmt.InVars.RowCount - 1 do begin
            iRows := FStmt.InVars.FRowsAffected[i];
            if iRows = $FFFFFFFF then
              Break;
            if iRows > 0 then
              Inc(ACount);
          end;
      end;
    except
      on E: EIBNativeException do begin
        E.Errors[0].RowIndex := iCurOffset + ACount;
        raise;
      end;
    end;
    if FStmt.OutVars.VarCount > 0 then
      GetParamValues(iCurTimes, iCurOffset);
    FStmt.Close;
    Inc(iCurOffset, iBatchSize);
    Inc(iCurTimes, iBatchSize);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBCommand.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
begin
  CheckSPPrepared(skStoredProcNoCrs);
  CheckParamInfos;
  ACount := 0;
  if (ATimes - AOffset > 1) and
     (FStmt.Lib.Brand = ibInterbase) and (FStmt.Lib.Version >= ivIB110000) and
     (GetCommandKind in [skDelete, skInsert, skUpdate, skMerge]) then
    DoExecuteIB2007Batch(ATimes, AOffset, ACount)
  else
    DoExecute(ATimes, AOffset, ACount, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBCommand.ProcessMetaColumn(ATable: TFDDatSTable;
  AFmtOpts: TFDFormatOptions; AColIndex: Integer; ARow: TFDDatSRow;
  ApInfo: PFDIBColInfoRec; ARowIndex: Integer);
var
  iVal: Integer;
  iSize: Longword;
  eIndexType: TFDPhysIndexKind;
  eTableType: TFDPhysTableKind;
  eScope: TFDPhysObjectScope;
  pBlob: PISC_QUAD;
  eDataType: TFDDataType;
  eRule: TFDPhysCascadeRuleKind;
  s: String;
  lUseBase: Boolean;

  procedure SetScope;
  begin
    if not ApInfo^.FVar.GetData(iVal, iSize) or (iVal = 0) then
      eScope := osMy
    else
      eScope := osSystem;
    ARow.SetData(AColIndex, Integer(eScope));
  end;

  procedure SetDataType;
  begin
    if not ApInfo^.FVar.GetData(iVal, iSize) or (iVal = 0) then
      eDataType := dtUnknown
    else
      case iVal of
      7: eDataType := dtInt16;
      8: eDataType := dtInt32;
      9: eDataType := dtInt64;
      10: eDataType := dtSingle;
      11: eDataType := dtDouble;
      12: eDataType := dtDate;
      13: eDataType := dtTime;
      14: eDataType := dtAnsiString;
      16: eDataType := dtInt64;
      17: eDataType := dtBoolean;
      27: eDataType := dtDouble;
      35: eDataType := dtDateTimeStamp;
      37: eDataType := dtAnsiString;
      40: eDataType := dtAnsiString;
      45: eDataType := dtBlob;
      261: eDataType := dtMemo;
      else eDataType := dtUnknown;
      end;
    ARow.SetData(AColIndex, Integer(eDataType));
  end;

begin
  lUseBase := True;
  if (IBConnection.ServerBrand = ibInterbase) and
     (IBConnection.ServerVersion < ivIB070500) then
    case GetMetaInfoKind of
    mkIndexes:
      if AColIndex = 6 then begin
        if not ApInfo^.FVar.GetData(iVal, iSize) or (iVal = 0) then
          eIndexType := ikNonUnique
        else if (iVal = 1) and not VarIsNull(ARow.GetData(5)) then
          eIndexType := ikPrimaryKey
        else
          eIndexType := ikUnique;
        ARow.SetData(AColIndex, Integer(eIndexType));
        lUseBase := False;
      end;
    mkTables:
      if AColIndex = 4 then begin
        if not ApInfo^.FVar.GetData(pBlob, iSize) then
          eTableType := tkTable
        else
          eTableType := tkView;
        ARow.SetData(AColIndex, Integer(eTableType));
        lUseBase := False;
      end
      else if AColIndex = 5 then begin
        SetScope;
        lUseBase := False;
      end;
    mkTableFields:
      if AColIndex = 6 then begin
        SetDataType;
        lUseBase := False;
      end;
    mkForeignKeys:
      if (AColIndex = 8) or (AColIndex = 9) then begin
        s := ApInfo^.FVar.AsString;
        if CompareText('RESTRICT', s) = 0 then
          eRule := ckRestrict
        else if CompareText('CASCADE', s) = 0 then
          eRule := ckCascade
        else if CompareText('SET NULL', s) = 0 then
          eRule := ckSetNull
        else if CompareText('SET DEFAULT', s) = 0 then
          eRule := ckSetDefault
        else
          eRule := ckNone;
        ARow.SetData(AColIndex, Integer(eRule));
        lUseBase := False;
      end;
    mkProcs:
      if AColIndex = 7 then begin
        SetScope;
        lUseBase := False;
      end;
    mkProcArgs:
      if AColIndex = 9 then begin
        SetDataType;
        lUseBase := False;
      end;
    mkGenerators:
      if AColIndex = 4 then begin
        SetScope;
        lUseBase := False;
      end;
    mkResultSetFields:
      if (AColIndex = 7) or (AColIndex = 8) then begin
        if not ApInfo^.FVar.GetData(pBlob, iSize) then
          iVal := 0
        else
          iVal := 1;
        ARow.SetData(AColIndex, iVal);
        lUseBase := False;
      end;
    end;
  if lUseBase then
    inherited ProcessMetaColumn(ATable, AFmtOpts, AColIndex, ARow, ApInfo, ARowIndex);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysIBDriver);
  FDPhysManager().RegisterDriverClass(TFDPhysIBLiteDriver);

end.
