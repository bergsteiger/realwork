{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC SQLite Local SQL classes            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.SQLiteVDataSet;

interface

uses
  System.Classes,
  FireDAC.Phys.Intf,
  FireDAC.Comp.Client;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDLocalSQL = class(TFDCustomLocalSQL)
  private
    FMultipleCursors: Boolean;
    FDisableControls: Boolean;
    FIncludeHiddenFields: Boolean;
    FApplyUpdatesOnCommit: Boolean;
    FUseTransactions: Boolean;
    FSchemaNames: TStringList;
    function GetObjName(ADataSet: TFDLocalSQLDataSet): String;
  protected
    procedure InternalAttachToSQL; override;
    procedure InternalDetachFromSQL; override;
    procedure InternalDataSetAdded(ADataSet: TFDLocalSQLDataSet); override;
    procedure InternalDataSetRemoving(ADataSet: TFDLocalSQLDataSet); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property MultipleCursors: Boolean read FMultipleCursors write FMultipleCursors default True;
    property DisableControls: Boolean read FDisableControls write FDisableControls default True;
    property IncludeHiddenFields: Boolean read FIncludeHiddenFields write FIncludeHiddenFields default True;
    property ApplyUpdatesOnCommit: Boolean read FApplyUpdatesOnCommit write FApplyUpdatesOnCommit default False;
    /// <summary> The UseTransactions property controls how LocalSQL uses destination
    ///  database transactions. When it is True, then LocalSQL will use them. </summary>
    property UseTransactions: Boolean read FUseTransactions write FUseTransactions default True;
    property SchemaName;
    property DataSets;
    property Connection;
    property Active;
    property OnGetDataSet;
    property OnReleaseDataSet;
    property OnOpenDataSet;
    property OnCloseDataSet;
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Variants, Data.FmtBCD, System.Types, Data.DB,
  FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Consts,
  FireDAC.Phys.SQLiteCli, FireDAC.Phys.SQLiteWrapper,
  FireDAC.Comp.DataSet;

type
  TSQLiteVDSModule = class;
  TSQLiteVDSNotifier = class;
  TSQLiteVDSTable = class;
  TSQLiteVDSCursor = class;

  TSQLiteVDSConn = record
    FConn: NativeUInt;
    FCount: LongWord;
  end;
  PSQLiteVDSConn = ^TSQLiteVDSConn;

  TSQLiteVDSSavePoint = record
    FVIndex: Integer;
    FSavePoint: Int64;
  end;
  PSQLiteVDSSavePoint = ^TSQLiteVDSSavePoint;

  TSQLiteVDSBookmark = record
    FNames: String;
    FFields: Variant;
  end;
  PSQLiteVDSBookmark = ^TSQLiteVDSBookmark;

  TSQLiteVDSFieldTypes = set of TFieldType;
  TSQLiteVDSModOperation = (moInsert, moUpdate, moDelete);
  TSQLiteVDSTableFlags = set of (tfLockActivation, tfLockSync, tfLockCommit);

  TSQLiteVDSModule = class(TSQLiteVModule)
  private
    FConns: TFDPtrList;
    function FindDataSet(const ASchemaName, AName: String): IFDPhysLocalSQLAdapter;
    function DataSetByName(const ASchemaName, AName: String): IFDPhysLocalSQLAdapter;
    procedure SetDataSetState(const ASchemaName, AName: String; ADataSet: TDataSet; AActive: Boolean);
  protected
    function VTabCreate(const AArgs: TSQLiteVArgs): TSQLiteVTable; override;
    function VTabConnect(const AArgs: TSQLiteVArgs): TSQLiteVTable; override;
  public
    constructor Create(const AName: String; ADatabase: TSQLiteDatabase); override;
    destructor Destroy; override;
    function StartTx(ATable: TSQLiteVDSTable): Boolean;
    function EndTx(ATable: TSQLiteVDSTable): Boolean;
    procedure ClearTx;
  end;

  TSQLiteVDSNotifier = class(TComponent)
  private
    FDataSet: TDataSet;
    FDataSource: TDataSource;
    FOnDataSetChanged: TNotifyEvent;
    FLastState: TDataSetState;
    procedure DoDataSetChanged;
    procedure DoStateChanged(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure Listen(ADataSet: TDataSet);
    procedure UnListen;
    destructor Destroy; override;
    property OnDataSetChanged: TNotifyEvent read FOnDataSetChanged write FOnDataSetChanged;
  end;

  TSQLiteVDSTable = class(TSQLiteVTable)
  private
    FAdapter: IFDPhysLocalSQLAdapter;
    FDataSet: TDataSet;
    FProvider: IProviderSupportNG;
    FSavePoints: TFDPtrList;
    FNotifier: TSQLiteVDSNotifier;
    FMultipleCursors: Boolean;
    FDisableControls: Boolean;
    FIncludeHiddenFields: Boolean;
    FApplyUpdatesOnCommit: Boolean;
    FUseTransactions: Boolean;
    FSchemaName: String;
    FKeyFieldInit: Boolean;
    FKeyFields: TFDFieldList;
    FKeyFieldNames: String;
    FAutoIncField: TField;
    FInsertRowids: TFDPtrList;
    FFlags: TSQLiteVDSTableFlags;
    FLastIdxNum: Integer;
    procedure CheckReadOnly;
    procedure CheckRowids(const ARowid1, ARowid2: sqlite3_int64;
      AOp: TSQLiteVDSModOperation);
    function GetCurRowid(ADataSet: TDataSet; AKeyFields: TFDFieldList): sqlite3_int64;
    procedure ClearRowid(ARowid: sqlite3_int64);
    procedure SetCurDSRecord(const ARowid: sqlite3_int64);
    procedure SetFieldData(AInsert: Boolean);
    procedure EditDataSet(const AUpdRowid: sqlite3_int64);
    procedure CheckResultset(AExistsOnly: Boolean = False);
    function PointByVIndex(const AVIndex: Integer;
      out ASavePoint: Int64): Integer;
    procedure FreePoints(AFrom: Integer);
    procedure ReleasePoints(const AVIndex: Integer; ARollback: Boolean);
    procedure DoDataSetChanged(ASource: TObject);
    procedure ActivateDataSet(AStartRead: Boolean);
    procedure Rewind;
    function OfflineMode: Boolean;
    function OfflineSavepointSupported: Boolean;
    function TxSupported: Boolean;
    procedure CheckClose;
  protected
    procedure DescribeColumn(const AColName: String; out ANotNull, AInPK,
      AAutoInc: Boolean); override;
    function DescribeColumns: TSQLiteVColDefs; override;
    function IsUnidirectional: Boolean;

    procedure VTabDisconnect; override;
    procedure VTabDestroy; override;
    procedure VTabRename(const ANewName: String); override;

    procedure VTabSync; override;
    procedure VTabBegin; override;
    procedure VTabCommit; override;
    procedure VTabRollback; override;

    procedure VTabSavepoint(const AVIndex: Integer); override;
    procedure VTabRelease(const AVIndex: Integer); override;
    procedure VTabRollbackTo(const AVIndex: Integer); override;

    function VTabFindFunction(ACount: Integer; const AName: String;
      var AFunc: Tsqlite3_func_callback; var AArg: Pointer): Boolean; override;
    procedure VTabBestIndex(var AIdxNum: Integer; var AIdxStr: String;
      var AOrdered, AFiltered: Boolean; var ACost: Double); override;

    procedure VTabInsert(var ARowid: sqlite3_int64; AOrUpdate: Boolean); override;
    procedure VTabUpdate(const AUpdRowid: sqlite3_int64; const ANewRowid: sqlite3_int64); override;
    procedure VTabDelete(const ARowid: sqlite3_int64); override;

    function VTabOpen: TSQLiteVCursor; override;
  public
    constructor Create(AModule: TSQLiteVModule; const ASchemaName, AName: String;
      const AAdapter: IFDPhysLocalSQLAdapter; AMultipleCursors, ADisableControls,
      AIncludeHiddenFields, AApplyUpdatesOnCommit, AUseTransactions: Boolean);
    destructor Destroy; override;
  end;

  TSQLiteVDSCursor = class(TSQLiteVCursor)
  private
    FAdapter: IFDPhysLocalSQLAdapter;
    FDataSet: TDataSet;
    FMemTable: TFDMemTable;
    FKeyFields: TFDFieldList;
    FUseRanges: Boolean;
    FStart: array of TVarRec;
    FEnd: array of TVarRec;
    FExcludeStart: Boolean;
    FExcludeEnd: Boolean;
    FEmptyStart: Boolean;
    FEmptyEnd: Boolean;
    FSort: String;
    FConstrs: TFDPtrList;
    FRangeCols: TFDStringList;
    FFilterCols: TFDPtrList;
    FLastIndexStr: String;
    procedure GetFieldData(AColumn: Integer);
    function GetTable: TSQLiteVDSTable;
    procedure CleanupFilter;
    procedure SetupFilter(const AIndex: Integer; const AIndexStr: String);
  protected
    procedure VTabFilter(const AIndex: Integer; const AIndexStr: String); override;
    procedure VTabNext; override;
    function VTabEof: Boolean; override;
    procedure VTabColumn(const AIndex: Integer); override;
    procedure VTabRowid(var ARowid: sqlite3_int64); override;
    procedure VTabClose; override;
  public
    constructor Create(ATable: TSQLiteVDSTable);
    destructor Destroy; override;
    property Table: TSQLiteVDSTable read GetTable;
  end;

const
  // data type sets
  CDateTimeTypes: TSQLiteVDSFieldTypes = [ftDate, ftTime, ftDateTime,
    ftTimeStamp, ftOraTimeStamp];
  CNumericTypes: TSQLiteVDSFieldTypes = [ftFloat, ftCurrency, ftBCD,
    ftFMTBcd, ftExtended, ftSingle];
  CWideStringTypes: TSQLiteVDSFieldTypes = [ftWideString, ftFmtMemo, ftDBaseOle,
    ftWideMemo, ftFixedWideChar];
  CBlobTypes: TSQLiteVDSFieldTypes = [ftBlob, ftOraBlob, ftBytes, ftVarBytes,
    ftGraphic, ftTypedBinary];
  CStringTypes: TSQLiteVDSFieldTypes = [ftString, ftFixedChar, ftGUID, ftMemo,
    ftOraClob];

{-------------------------------------------------------------------------------}
procedure VDSError(AObj: TObject; ACode: Integer; AArgs: array of const);
begin
  raise EFDException.Create(ACode, Format(FDGetErrorMessage(ACode, AArgs), AArgs));
end;

{-------------------------------------------------------------------------------}
{ TFDLocalSQL                                                                   }
{-------------------------------------------------------------------------------}
constructor TFDLocalSQL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMultipleCursors := True;
  FDisableControls := True;
  FIncludeHiddenFields := True;
  FApplyUpdatesOnCommit := False;
  FUseTransactions := True;
  FSchemaNames := TFDStringList.Create(dupIgnore, True, False);
end;

{-------------------------------------------------------------------------------}
destructor TFDLocalSQL.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FSchemaNames);
end;

{-------------------------------------------------------------------------------}
function TFDLocalSQL.GetObjName(ADataSet: TFDLocalSQLDataSet): String;
var
  sSchema: String;
begin
  Result := ADataSet.ActualName;
  sSchema := ADataSet.ActualSchemaName;
  if Result <> '' then begin
    Result := '[' + Result + ']';
    if sSchema <> '' then
      Result := '[' + sSchema + '].' + Result;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDLocalSQL.InternalAttachToSQL;
begin
  if (Connection.RDBMSKind <> TFDRDBMSKinds.SQLite) or
     (Connection.ConnectionIntf.CliObj = nil) or
     not (TObject(Connection.ConnectionIntf.CliObj) is TSQLiteDatabase) then
    FDException(Connection, [S_FD_LPhys, S_FD_SQLiteId, 'sqlite3'],
      er_FD_SQLiteVTabCannotAttach, []);
  TSQLiteDatabase(Connection.ConnectionIntf.CliObj).
    SQLHandlerList.Add(IFDPhysSQLHandler(Self));
end;

{-------------------------------------------------------------------------------}
procedure TFDLocalSQL.InternalDetachFromSQL;
var
  i: Integer;
begin
  try
    for i := 0 to FSchemaNames.Count - 1 do
      Connection.ExecSQL('DETACH DATABASE [' + FSchemaNames[i] + ']');
  finally
    FSchemaNames.Clear;
    TSQLiteDatabase(Connection.ConnectionIntf.CliObj).
      SQLHandlerList.Remove(IFDPhysSQLHandler(Self));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDLocalSQL.InternalDataSetAdded(ADataSet: TFDLocalSQLDataSet);
var
  sArgs, sCmd: String;
  sSchema: String;
begin
  if MultipleCursors then
    sArgs := ', 1'
  else
    sArgs := ', 0';
  if DisableControls then
    sArgs := sArgs + ', 1'
  else
    sArgs := sArgs + ', 0';
  if IncludeHiddenFields then
    sArgs := sArgs + ', 1'
  else
    sArgs := sArgs + ', 0';
  if ApplyUpdatesOnCommit then
    sArgs := sArgs + ', 1'
  else
    sArgs := sArgs + ', 0';
  if UseTransactions then
    sArgs := sArgs + ', 1'
  else
    sArgs := sArgs + ', 0';

  sSchema := ADataSet.ActualSchemaName;
  if (sSchema <> '') and (FSchemaNames.IndexOf(sSchema) = -1) then begin
    Connection.ExecSQL('ATTACH DATABASE ":memory:" AS [' + sSchema + ']');
    FSchemaNames.Add(sSchema);
  end;

  sCmd := 'CREATE VIRTUAL TABLE ';
  if TSQLiteDatabase(Connection.ConnectionIntf.CliObj).Lib.Version >= svSQLite030711 then
    sCmd := sCmd + 'IF NOT EXISTS ';
  Connection.ExecSQL(sCmd + GetObjName(ADataSet) +
    ' USING DataSet(' + ADataSet.ActualName + sArgs + ')');
end;

{-------------------------------------------------------------------------------}
procedure TFDLocalSQL.InternalDataSetRemoving(ADataSet: TFDLocalSQLDataSet);
begin
  Connection.ExecSQL('DROP TABLE IF EXISTS ' + GetObjName(ADataSet));
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVDSModule                                                              }
{-------------------------------------------------------------------------------}
constructor TSQLiteVDSModule.Create(const AName: String;
  ADatabase: TSQLiteDatabase);
begin
  inherited Create(AName, ADatabase);
  FConns := TFDPtrList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteVDSModule.Destroy;
begin
  ClearTx;
  FDFreeAndNil(FConns);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSModule.VTabCreate(const AArgs: TSQLiteVArgs): TSQLiteVTable;
var
  oAdapt: IFDPhysLocalSQLAdapter;
  lMultCrs, lDisCtrls, lIncHid, lApplUpd, lUseTx: Boolean;
begin
  // AArgs format:
  // AArgs count >= 4;
  // AArgs[0] = module name, AArgs[1] = catalog name, AArgs[2] = virt table name
  // AArgs[3] = dataset name
  // AArgs[4] = 0/1 - multiple cursors
  // AArgs[5] = 0/1 - disable controls
  // AArgs[6] = 0/1 - include hidden fields
  // AArgs[7] = 0/1 - apply updates on commit
  // AArgs[8] = 0/1 - use transactions
  if Length(AArgs) < 4 then
    VDSError(Self, er_FD_SQLiteVTabInvalidArgs, [4, Length(AArgs)]);
  oAdapt := DataSetByName(AArgs[1], AArgs[3]);
  lMultCrs := (Length(AArgs) < 5) or (VarToStr(AArgs[4]) = '1');
  lDisCtrls := (Length(AArgs) < 6) or (VarToStr(AArgs[5]) = '1');
  lIncHid := (Length(AArgs) < 7) or (VarToStr(AArgs[6]) = '1');
  lApplUpd := (Length(AArgs) < 8) or (VarToStr(AArgs[7]) = '1');
  lUseTx := (Length(AArgs) < 9) or (VarToStr(AArgs[8]) = '1');
  Result := TSQLiteVDSTable.Create(Self, AArgs[1], AArgs[2], oAdapt,
    lMultCrs, lDisCtrls, lIncHid, lApplUpd, lUseTx);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSModule.VTabConnect(const AArgs: TSQLiteVArgs): TSQLiteVTable;
begin
  Result := VTabCreate(AArgs);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSModule.FindDataSet(const ASchemaName, AName: String): IFDPhysLocalSQLAdapter;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Database.SQLHandlerList.Count - 1 do begin
    Result := IFDPhysSQLHandler(Database.SQLHandlerList[i]).FindAdapter(ASchemaName, AName);
    if Result <> nil then
      Break;
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSModule.DataSetByName(const ASchemaName, AName: String): IFDPhysLocalSQLAdapter;
var
  s: String;
begin
  Result := FindDataSet(ASchemaName, AName);
  if Result = nil then begin
    s := AName;
    if ASchemaName <> '' then
      s := ASchemaName + '.' + s;
    VDSError(Self, er_FD_SQLiteVTabDSNotFoundOrEmpty, [s]);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSModule.SetDataSetState(const ASchemaName, AName: String;
  ADataSet: TDataSet; AActive: Boolean);
var
  i: Integer;
  oHndl: IFDPhysSQLHandler;
begin
  for i := 0 to Database.SQLHandlerList.Count - 1 do begin
    oHndl := IFDPhysSQLHandler(Database.SQLHandlerList[i]);
    if oHndl.FindAdapter(ASchemaName, AName) <> nil then begin
      if AActive then
        oHndl.OpenDataSet(ASchemaName, AName, ADataSet)
      else
        oHndl.CloseDataSet(ASchemaName, AName, ADataSet);
      Break;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSModule.StartTx(ATable: TSQLiteVDSTable): Boolean;
var
  i: Integer;
  pConn: PSQLiteVDSConn;
begin
  Result := False;
  if (ATable.FAdapter.Conn = 0) or (ATable.FProvider = nil) then
    Exit;
  for i := 0 to FConns.Count - 1 do
    if PSQLiteVDSConn(FConns[i])^.FConn = ATable.FAdapter.Conn then begin
      Inc(PSQLiteVDSConn(FConns[i])^.FCount);
      Exit;
    end;
  New(pConn);
  FConns.Add(pConn);
  pConn^.FConn := ATable.FAdapter.Conn;
  Result := not ATable.FProvider.PSInTransaction;
  if Result then
    pConn^.FCount := 1
  else
    pConn^.FCount := MaxInt;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSModule.EndTx(ATable: TSQLiteVDSTable): Boolean;
var
  i: Integer;
begin
  Result := False;
  if (ATable.FAdapter.Conn = 0) or (ATable.FProvider = nil) then
    Exit;
  for i := 0 to FConns.Count - 1 do
    if PSQLiteVDSConn(FConns[i])^.FConn = ATable.FAdapter.Conn then begin
      if PSQLiteVDSConn(FConns[i])^.FCount > 0 then
        Dec(PSQLiteVDSConn(FConns[i])^.FCount);
      if PSQLiteVDSConn(FConns[i])^.FCount = 0 then begin
        Result := ATable.FProvider.PSInTransaction;
        Dispose(PSQLiteVDSConn(FConns[i]));
        FConns.Delete(i);
      end;
      Exit;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSModule.ClearTx;
var
  i: Integer;
begin
  for i := 0 to FConns.Count - 1 do
    Dispose(PSQLiteVDSConn(FConns[i]));
  FConns.Clear;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVDSNotifier                                                            }
{-------------------------------------------------------------------------------}
destructor TSQLiteVDSNotifier.Destroy;
begin
  UnListen;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSNotifier.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  DoDataSetChanged;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSNotifier.UnListen;
begin
  if csDestroying in FDataSet.ComponentState then
    FDataSource := nil
  else
    FDFreeAndNil(FDataSource);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSNotifier.DoDataSetChanged;
begin
  if Assigned(FOnDataSetChanged) then
    FOnDataSetChanged(FDataSet);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSNotifier.DoStateChanged(Sender: TObject);
begin
  if (FDataSource.State in [dsBrowse, dsInactive]) and (FLastState <> FDataSource.State) then begin
    FLastState := FDataSource.State;
    DoDataSetChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSNotifier.Listen(ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
  FDataSet.FreeNotification(Self);
  FDataSource := TDataSource.Create(FDataSet);
  FDataSource.DataSet := FDataSet;
  FDataSource.OnStateChange := DoStateChanged;
  FLastState := FDataSet.State;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVDSTable                                                               }
{-------------------------------------------------------------------------------}
constructor TSQLiteVDSTable.Create(AModule: TSQLiteVModule; const ASchemaName, AName: String;
  const AAdapter: IFDPhysLocalSQLAdapter; AMultipleCursors, ADisableControls,
  AIncludeHiddenFields, AApplyUpdatesOnCommit, AUseTransactions: Boolean);
begin
  inherited Create(AModule, AName);
  FSchemaName := ASchemaName;
  FSavePoints := TFDPtrList.Create;
  FAdapter := AAdapter;
  FMultipleCursors := AMultipleCursors;
  FDisableControls := ADisableControls;
  FIncludeHiddenFields := AIncludeHiddenFields;
  FApplyUpdatesOnCommit := AApplyUpdatesOnCommit;
  FUseTransactions := AUseTransactions;
  FDataSet := AAdapter.DataSet as TDataSet;
  FProvider := IProviderSupportNG(FDataSet);
  FNotifier := TSQLiteVDSNotifier.Create(nil);
  FNotifier.Listen(FDataSet);
  FNotifier.OnDataSetChanged := DoDataSetChanged;
  FKeyFields := TFDFieldList.Create;
  FInsertRowids := TFDPtrList.Create;
  FLastIdxNum := 0;
  // disable first sync & commit, which are issued right after VTab creation
  FFlags := [tfLockSync, tfLockCommit];
  ActivateDataSet(False);
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteVDSTable.Destroy;
var
  i: Integer;
begin
  inherited Destroy;
  DoDataSetChanged(nil);
  FreePoints(0);
  FDFreeAndNil(FSavePoints);
  FDFreeAndNil(FKeyFields);
  for i := 0 to FInsertRowids.Count - 1 do
    Dispose(PSQLiteVDSBookmark(FInsertRowids[i]));
  FDFreeAndNil(FInsertRowids);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.ActivateDataSet(AStartRead: Boolean);
var
  i: Integer;
  oFld: TField;
  lUseAllFields: Boolean;
begin
  if (FDataSet = nil) or (tfLockActivation in FFlags) then
    Exit;
  Include(FFlags, tfLockActivation);
  try
    if AStartRead then
      TSQLiteVDSModule(FModule).SetDataSetState(FSchemaName, FName, FDataSet, True);
    if not FDataSet.Active then
      FDataSet.Active := True;
  finally
    Exclude(FFlags, tfLockActivation);
  end;
  if not FKeyFieldInit then begin
    if FProvider <> nil then
      FKeyFieldNames := FProvider.PSGetKeyFields
    else
      FKeyFieldNames := '';
    // if no PK exists - use all fields having pfInKey, pfInWhere flags
    lUseAllFields := FKeyFieldNames = '';
    if lUseAllFields or (FAutoIncField = nil) then
      for i := 0 to FDataSet.FieldCount - 1 do begin
        oFld := FDataSet.Fields[i];
        if oFld.FieldKind = fkData then begin
          if lUseAllFields and ([pfInKey, pfInWhere] * oFld.ProviderFlags <> []) then begin
            if FKeyFieldNames <> '' then
              FKeyFieldNames := FKeyFieldNames + ';';
            FKeyFieldNames := FKeyFieldNames + oFld.FieldName;
          end;
          if (FAutoIncField = nil) and (oFld.AutoGenerateValue = arAutoInc) then begin
            FAutoIncField := oFld;
            if not lUseAllFields then
              Break;
          end;
        end;
      end;
    FKeyFields.Clear;
    FDataSet.GetFieldList(FKeyFields, FKeyFieldNames);
    FKeyFieldInit := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.DescribeColumn(const AColName: String; out ANotNull,
  AInPK, AAutoInc: Boolean);
var
  i: Integer;
  oFld: TField;
begin
  for i := 0 to FDataSet.FieldCount - 1 do begin
    oFld := FDataSet.Fields[i];
    if CompareText(oFld.FieldName, AColName) = 0 then begin
      AInPK := pfInKey in oFld.ProviderFlags;
      AAutoInc := (oFld.AutoGenerateValue = arAutoInc) or (oFld is TAutoIncField);
      ANotNull := oFld.Required or AInPK or AAutoInc;
      Break;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSTable.DescribeColumns: TSQLiteVColDefs;

  function GetMapDataType(AField: TField): String;
  const
    C_VAR: array [Boolean] of String = ('VAR', '');
  var
    iPrec, iSize: Integer;
    lFixedLen: Boolean;
  begin
    Result := '';
    iPrec := 0;
    iSize := 0;
    // determine attributes
    lFixedLen := (AField is TStringField) and TStringField(AField).FixedChar;
    if AField is TStringField then
      iSize := TStringField(AField).Size
    else if AField is TBinaryField then
      iSize := TBinaryField(AField).Size
    else if AField is TFMTBCDField then begin
      iPrec := TFMTBCDField(AField).Precision;
      iSize := TFMTBCDField(AField).Size;
    end
    else if AField is TBcdField then begin
      iPrec := TBCDField(AField).Precision;
      iSize := TBCDField(AField).Size;
    end;
    // map data type
    case AField.DataType of
    ftBoolean:         Result := 'BOOLEAN';
    ftByte:            Result := 'UNSIGNED TINYINT';
    ftLongWord:        Result := 'UNSIGNED MEDIUMINT';
    ftShortint:        Result := 'TINYINT';
    ftExtended:        Result := 'DOUBLE';
    ftFloat:           Result := 'DOUBLE';
    ftWord:            Result := 'UNSIGNED SMALLINT';
    ftSmallint:        Result := 'SMALLINT';
    ftAutoInc,
    ftInteger:         Result := 'MEDIUMINT';
    ftLargeint:        Result := 'BIGINT';
    ftSingle:          Result := 'SINGLE';
    ftCurrency:        Result := 'CURRENCY';
    ftFmtBCD,
    ftBCD:             Result := 'NUMERIC(' + IntToStr(iPrec) + ',' +
                                              IntToStr(iSize) + ')';
    ftDate:            Result := 'DATE';
    ftDateTime:        Result := 'DATETIME';
    ftOraTimeStamp,
    ftTimeStampOffset,
    ftTimeStamp:       Result := 'TIMESTAMP';
    ftTime:            Result := 'TIME';
    ftParadoxOle,
    ftOraInterval:     Result := 'INTERVAL';
    ftFixedWideChar,
    ftFixedChar,
    ftString:          Result := C_VAR[lFixedLen] + 'CHAR(' + IntToStr(iSize) + ')';
    ftGUID:            Result := 'GUID';
    ftWideString:      Result := 'N' + C_VAR[lFixedLen] + 'CHAR(' + IntToStr(iSize) + ')';
    ftBytes:           Result := 'BINARY(' + IntToStr(iSize) + ')';
    ftVarBytes:        Result := 'VARBINARY(' + IntToStr(iSize) + ')';
    ftBlob,
    ftGraphic,
    ftTypedBinary,
    ftOraBlob:         Result := 'BLOB';
    ftMemo,
    ftOraClob:         Result := 'MEMO';
    ftWideMemo,
    ftFmtMemo:         Result := 'NTEXT';
    ftDBaseOle:        Result := 'XML'
    // ftUnknown, ftCursor, ftADT, ftArray, ftReference,
    // ftDataSet, ftVariant, ftInterface, ftIDispatch
    else               VDSError(Self, er_FD_SQLiteVTabDSNotSupported, []);
    end;
  end;

var
  i: Integer;
  oFld: TField;
begin
  SetLength(Result, FDataSet.FieldCount);
  for i := 0 to FDataSet.FieldCount - 1 do begin
    oFld := FDataSet.Fields[i];
    Result[i].FName := oFld.FieldName;
    Result[i].FHidden := not FIncludeHiddenFields and
      ((pfHidden in oFld.ProviderFlags) or not oFld.Visible);
    Result[i].FDataType := GetMapDataType(oFld);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.DoDataSetChanged(ASource: TObject);
begin
  if (FDataSet = nil) or (FDataSet.State = dsInactive) or (ASource = nil) then begin
    FKeyFieldInit := False;
    FKeyFields.Clear;
    FKeyFieldNames := '';
    FAutoIncField := nil;
    FreePoints(0);
    if (ASource = nil) or (csDestroying in FDataSet.ComponentState) then begin
      FAdapter := nil;
      FProvider := nil;
      FDataSet := nil;
      if FNotifier <> nil then begin
        FNotifier.UnListen;
        FDFreeAndNil(FNotifier);
      end;
    end;
  end
  else
    ActivateDataSet(False);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.CheckResultset(AExistsOnly: Boolean = False);
begin
  if (FDataSet = nil) or not AExistsOnly and not FDataSet.Active then
    VDSError(Self, er_FD_SQLiteVTabDSChangedOrFreed, []);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSTable.IsUnidirectional: Boolean;
begin
  Result := (FDataSet is TFDDataSet) and TFDDataSet(FDataSet).ClientCursor and
    TFDDataSet(FDataSet).OptionsIntf.FetchOptions.Unidirectional or
    not (FDataSet is TFDDataSet) and FDataSet.IsUniDirectional;
end;

{-------------------------------------------------------------------------------}
{ Live cycle }

procedure TSQLiteVDSTable.VTabDisconnect;
begin
  DoDataSetChanged(nil);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabDestroy;
begin
  DoDataSetChanged(nil);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabRename(const ANewName: String);
begin
  FDataSet.Name := ANewName;
end;

{-------------------------------------------------------------------------------}
{ TX management }

function TSQLiteVDSTable.OfflineMode: Boolean;
begin
  Result := (afCachedUpdates in FAdapter.Features) and FAdapter.CachedUpdates;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSTable.OfflineSavepointSupported: Boolean;
begin
  Result := OfflineMode and (afSavePoints in FAdapter.Features);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSTable.TxSupported: Boolean;
begin
  Result := FUseTransactions and (afTransactions in FAdapter.Features);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabBegin;
begin
  if OfflineSavepointSupported then
    VTabSavepoint(-1);
  if TxSupported and
     (not OfflineMode or FApplyUpdatesOnCommit) and
     TSQLiteVDSModule(FModule).StartTx(Self) then
    FProvider.PSStartTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabSync;
begin
  try
    if not (tfLockSync in FFlags) then begin
      FDataSet.CheckBrowseMode;
      if OfflineMode and FApplyUpdatesOnCommit then
        if FAdapter.ApplyUpdates <> 0 then
          VDSError(Self, er_FD_SQLiteVTabDSDataModFailed, []);
    end;
  finally
    Exclude(FFlags, tfLockSync);
  end;
end;

                                                 
         
                         
           
                         
                               
                                  
                         
                     
                      
                         
                                        
                                     
 

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabCommit;
begin
  try
    if not (tfLockCommit in FFlags) then
      if OfflineSavepointSupported then
        VTabRelease(-1);
      if OfflineMode and FApplyUpdatesOnCommit then
        FAdapter.CommitUpdates;
      if TxSupported and
         (not OfflineMode or FApplyUpdatesOnCommit) and
         TSQLiteVDSModule(FModule).EndTx(Self) then
        FProvider.PSEndTransaction(True);
  finally
    Exclude(FFlags, tfLockCommit);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabRollback;
begin
  if OfflineSavepointSupported then
    VTabRollbackTo(-1)
  else if OfflineMode and FApplyUpdatesOnCommit then
    FAdapter.CancelUpdates;
  if TxSupported and
     (not OfflineMode or FApplyUpdatesOnCommit) and
     TSQLiteVDSModule(FModule).EndTx(Self) then
    FProvider.PSEndTransaction(False);
end;

{-------------------------------------------------------------------------------}
{ Savepoints management }

function TSQLiteVDSTable.PointByVIndex(const AVIndex: Integer;
  out ASavePoint: Int64): Integer;
var
  i: Integer;
  pSP: PSQLiteVDSSavePoint;
begin
  Result := -1;
  for i := 0 to FSavePoints.Count - 1 do begin
    pSP := PSQLiteVDSSavePoint(FSavePoints[i]);
    if pSP^.FVIndex = AVIndex then begin
      ASavePoint := pSP^.FSavePoint;
      Result := i;
      Break;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.FreePoints(AFrom: Integer);
var
  i: Integer;
begin
  for i := FSavePoints.Count - 1 downto AFrom do begin
    Dispose(PSQLiteVDSSavePoint(FSavePoints[i]));
    FSavePoints.Delete(i);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.ReleasePoints(const AVIndex: Integer;
  ARollback: Boolean);
var
  i: Integer;
  iSp: Int64;
begin
  if not OfflineSavepointSupported then begin
    FreePoints(0);
    if ARollback then
      VTabRollback
    else
      VTabCommit;
    Exit;
  end;
  i := PointByVIndex(AVIndex, iSp);
  if i <> -1 then begin
    if ARollback then
      FAdapter.SavePoint := iSp;
    FreePoints(i);
  end
  else if AVIndex >= 0 then
    VDSError(Self, er_FD_SQLiteVTabDSSPNotFound, [AVIndex]);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabSavepoint(const AVIndex: Integer);
var
  pSP: PSQLiteVDSSavePoint;
begin
  if not OfflineSavepointSupported then begin
    VTabBegin;
    Exit;
  end;
  New(pSP);
  pSP^.FVIndex := AVIndex;
  pSP^.FSavePoint := FAdapter.SavePoint;
  FSavePoints.Add(pSP);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabRelease(const AVIndex: Integer);
begin
  ReleasePoints(AVIndex, False);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabRollbackTo(const AVIndex: Integer);
begin
  ReleasePoints(AVIndex, True);
end;

{-------------------------------------------------------------------------------}
{ Custom functions and indexes }

function TSQLiteVDSTable.VTabFindFunction(ACount: Integer; const AName: String;
  var AFunc: Tsqlite3_func_callback; var AArg: Pointer): Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabBestIndex(var AIdxNum: Integer;
  var AIdxStr: String; var AOrdered, AFiltered: Boolean; var ACost: Double);
const
  C_Order: array [Boolean] of String = ('A', 'D');
var
  i, iFlt, iOrd: Integer;
  iVer: TFDVersion;
  lOrdered, lFiltered: Boolean;
  pOrder: PSQLiteVOrderBy;
  pConstr: PSQLiteVConstraint;

  function CheckOrderBys(AColumn: Integer; out AIndex: Integer): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    // check if same column is in WHERE and ORDER BY
    for i := 0 to Length(FOrderBys) - 1 do
      if FOrderBys[i].FColumn = AColumn then begin
        Result := True;
        AIndex := i;
        FOrderBys[i].FColumn := C_FD_SQLiteUndefRowid;
        AOrdered := lOrdered;
        Break;
      end;
  end;

begin
  ActivateDataSet(False);
  // We define 4 index strategies:
  // 1) - rowid only are used: Cost = 1
  // 2) - key columns only of DS are used or with rowid:
  //      Cost = R * 1 + K * 5, where R = 1 if rowid is used, K = key cols count
  // 3) - mixture of key, rowid and ordinary columns are used:
  //      Cost = R * 1 + K * 5 + N * 10, where N = ordinary cols count
  // 4) - only ordinary columns are used: Cost = N * 10
  ACost := 0;
  AIdxNum := FLastIdxNum;
  AIdxStr := '';
  iFlt := 1;
  AOrdered := False;
  AFiltered := False;
  if not FMultipleCursors and (
       IsUnidirectional or
       (FAdapter.Features * [afFilters, afRanges, afIndexFieldNames] = [])) then
    Exit;
  // preliminary decide if records will be returned ordered and filtered
  iVer := FModule.Database.Lib.Version;
  lOrdered := (iVer < svSQLite030715) and
              (FMultipleCursors or (afIndexFieldNames in FAdapter.Features));
  lFiltered := FMultipleCursors or ([afRanges, afFilters] * FAdapter.Features <> []);
  // WHERE AND ON clauses
  if lFiltered then
    for i := 0 to Length(FConstraints) - 1 do begin
      pConstr := @FConstraints[i];
      if pConstr^.FColumn <> C_FD_SQLiteUndefRowid then begin
        if pConstr^.FColumn = -1 then
          ACost := ACost + 1
        else if (pfInKey in FDataSet.Fields[pConstr^.FColumn].ProviderFlags) or
                (FDataSet.Fields[pConstr^.FColumn] is TAutoIncField) or
                (FDataSet.Fields[pConstr^.FColumn].AutoGenerateValue = arAutoInc) then
          ACost := ACost + 5
        else
          ACost := ACost + 10;
        // don't include MATCH op. as we don't know its implementation
        if pConstr^.FOp <> coMatch then begin
          pConstr^.FOmit := True;
          pConstr^.FArgvIndex := iFlt;
          if not (lOrdered and CheckOrderBys(pConstr^.FColumn, iOrd)) then
            AIdxStr := AIdxStr + Format('C%d=%d;', [pConstr^.FColumn, Ord(pConstr^.FOp)])
          else
            AIdxStr := AIdxStr + Format('%s%d=%d;', [C_Order[FOrderBys[iOrd].FDesc],
              pConstr^.FColumn, Ord(pConstr^.FOp)]);
          AFiltered := lFiltered;
          Inc(iFlt);
        end;
      end;
    end;
  // ORDER BY and HAVING clauses
  if lOrdered then
    for i := 0 to Length(FOrderBys) - 1 do begin
      pOrder := @FOrderBys[i];
      if pOrder^.FColumn <> C_FD_SQLiteUndefRowid then begin
        AIdxStr := AIdxStr + Format('%s%d;', [C_Order[pOrder^.FDesc], pOrder^.FColumn]);
        AOrdered := lOrdered;
      end;
    end;
  Inc(FLastIdxNum);
end;

{-------------------------------------------------------------------------------}
{ Data modification }

procedure TSQLiteVDSTable.CheckReadOnly;
begin
  if not FDataSet.CanModify then
    VDSError(Self, er_FD_SQLiteVTabDSDataModFailed, []);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.CheckRowids(const ARowid1, ARowid2: sqlite3_int64;
  AOp: TSQLiteVDSModOperation);

  function CompareRowids(ApBmk1, ApBmk2: PSQLiteVDSBookmark): Boolean;
  var
    i: Integer;
  begin
    Result := ApBmk1^.FNames = ApBmk2^.FNames;
    if Result then
      if VarIsArray(ApBmk1^.FFields) then begin
        for i := 0 to VarArrayHighBound(ApBmk1^.FFields, 1) do
          if not FDSameVariants(ApBmk1^.FFields[i], ApBmk2^.FFields[i]) then
            Exit(False);
      end
      else
        Result := FDSameVariants(ApBmk1^.FFields, ApBmk2^.FFields);
  end;

begin
  if (AOp = moInsert) and (ARowid1 <> C_FD_SQLiteUndefRowid) then
    // if rowid is passed by SQLite we'll need to implement
    // managing of a collection with pairs: SQLite int. rowid & ADDataset rowid
    VDSError(Self, er_FD_SQLiteVTabDSRowidInvalid, [ARowid1])
  else if (AOp = moUpdate) and (ARowid1 <> C_FD_SQLiteUndefRowid) and (ARowid1 <> ARowid2) and
          not CompareRowids(PSQLiteVDSBookmark(ARowid1), PSQLiteVDSBookmark(ARowid2)) then
    // same as above
    VDSError(Self, er_FD_SQLiteVTabDSNotSupported, []);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSTable.GetCurRowid(ADataSet: TDataSet; AKeyFields: TFDFieldList): sqlite3_int64;
var
  vValues: Variant;
  pKeys: PSQLiteVDSBookmark;
  i: Integer;
begin
  if AKeyFields.Count = 0 then
    VDSError(Self, er_FD_SQLiteVTabDSNoRowExists, []);
  if AKeyFields.Count = 1 then
    vValues := AKeyFields[0].Value
  else begin
    vValues := VarArrayCreate([0, AKeyFields.Count - 1], varVariant);
    for i := 0 to AKeyFields.Count - 1 do
      vValues[i] := AKeyFields[i].Value;
  end;
  New(pKeys);
  pKeys^.FNames := FKeyFieldNames;
  pKeys^.FFields := vValues;
  Result := sqlite3_int64(pKeys);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.ClearRowid(ARowid: sqlite3_int64);
var
  pKeys: PSQLiteVDSBookmark;
begin
  if (ARowid <> 0) and (ARowid <> C_FD_SQLiteUndefRowid) then begin
    pKeys := PSQLiteVDSBookmark(ARowid);
    FInsertRowids.Remove(pKeys);
    Dispose(pKeys);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.SetCurDSRecord(const ARowid: sqlite3_int64);
var
  pKeys: PSQLiteVDSBookmark;
begin
  try
    pKeys := PSQLiteVDSBookmark(ARowid);
    if (FMultipleCursors or not IsUnidirectional and (afIndexFieldNames in FAdapter.Features)) and
       (FAdapter.IndexFieldNames <> pKeys^.FNames) then
      FAdapter.IndexFieldNames := pKeys^.FNames;
    if not FDataSet.Locate(pKeys^.FNames, pKeys^.FFields, []) then
      VDSError(Self, er_FD_SQLiteVTabDSNoRowExists, []);
  finally
    ClearRowid(ARowid);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.SetFieldData(AInsert: Boolean);
var
  i, iSize: Integer;
  oStream: TStream;
  pBuff: Pointer;
  oFld: TField;
  oCol: TSQLiteInput;
begin
  for i := 0 to Count - 1 do begin
    oFld := FDataSet.Fields[i];
    // Skip updating read-only fields, because SQLite sets all
    // table fields (modified and not modified)
    if not oFld.ReadOnly then begin
      oCol := ColsIN[i];
      case oCol.IntDataType of
      SQLITE_INTEGER:
        if oFld.DataType = ftLargeInt then
          oFld.AsLargeInt := oCol.AsInteger
        else if oFld.DataType = ftBoolean then
          oFld.AsBoolean := oCol.AsInteger <> 0
        else
          oFld.AsInteger := oCol.AsInteger;
      SQLITE_TEXT:
        if oFld.DataType in CWideStringTypes then
          oFld.AsWideString := oCol.AsWideString
        else if oFld.DataType = ftTime then
          oFld.AsDateTime := oCol.AsTime
        else if oFld.DataType in CDateTimeTypes then
          oFld.AsDateTime := oCol.AsDateTime
        else if oFld.DataType = ftBoolean then
          oFld.AsBoolean := oCol.AsBoolean
        else if oFld.DataType in [ftBCD, ftCurrency, ftFMTBcd] then
          oFld.AsBCD := oCol.AsNumber
        else
          oFld.AsString := oCol.AsString;
      SQLITE_FLOAT:
        if oFld.DataType in CDateTimeTypes then
          oFld.AsDateTime := oCol.AsDateTime
        else if oFld.DataType = ftBoolean then
          oFld.AsBoolean := oCol.AsFloat <> 0
        else
          oFld.AsFloat := oCol.AsFloat;
      SQLITE_BLOB:
        begin
          // get blob size 1st
          oCol.GetData(pBuff, iSize, True, etBlob);
          if iSize > 0 then begin
            oCol.GetData(pBuff, iSize, False, etBlob);
            oStream := FDataSet.CreateBlobStream(oFld, bmWrite);
            try
              oStream.WriteBuffer(PByte(pBuff)^, iSize);
            finally
              FDFree(oStream);
            end;
          end;
        end;
      SQLITE_NULL:
        if not AInsert then
          oFld.Clear;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabInsert(var ARowid: sqlite3_int64; AOrUpdate: Boolean);
var
  pBookmark: Pointer;
begin
  CheckResultset;
  CheckReadOnly;
  CheckRowids(ARowid, 0, moInsert);
  pBookmark := FDataSet.GetBookmark;
  try
    FDataSet.Append;
    try
      SetFieldData(True);
      FDataSet.Post;
    except
      on E: Exception do
        if AOrUpdate and (FKeyFields.Count > 0) and
           (afPrimaryKey in FAdapter.Features) and FAdapter.IsPKViolation(E) then begin
          ARowid := GetCurRowid(FDataSet, FKeyFields);
          FDataSet.Cancel;
          EditDataSet(ARowid);
        end
        else begin
          FDataSet.Cancel;
          raise;
        end;
    end;
    if (FAutoIncField <> nil) and (FAutoIncField.AsLargeInt > 0) then
      FModule.Database.SetLastAutoGenValue(FAutoIncField.AsLargeInt)
    else
      FModule.Database.SetLastAutoGenValue(0);
    ARowid := GetCurRowid(FDataSet, FKeyFields);
    FInsertRowids.Add(PSQLiteVDSBookmark(ARowid));
    if FDataSet.BookmarkValid(pBookmark) then
      FDataSet.GotoBookmark(pBookmark);
  finally
    FDataSet.FreeBookmark(pBookmark);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.EditDataSet(const AUpdRowid: sqlite3_int64);
begin
  SetCurDSRecord(AUpdRowid);
  FDataSet.Edit;
  try
    SetFieldData(False);
    FDataSet.Post;
  except
    FDataSet.Cancel;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabUpdate(const AUpdRowid, ANewRowid: sqlite3_int64);
var
  pBookmark: Pointer;
begin
  try
    CheckResultset;
    CheckReadOnly;
    CheckRowids(AUpdRowid, ANewRowid, moUpdate);
    pBookmark := FDataSet.GetBookmark;
    try
      EditDataSet(AUpdRowid);
      FModule.Database.SetLastAutoGenValue(0);
      if FDataSet.BookmarkValid(pBookmark) then
        FDataSet.GotoBookmark(pBookmark);
    finally
      FDataSet.FreeBookmark(pBookmark);
    end;
  finally
    if AUpdRowid <> ANewRowid then
      ClearRowid(ANewRowid);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.VTabDelete(const ARowid: sqlite3_int64);
var
  pBookmark: Pointer;
begin
  CheckResultset;
  CheckReadOnly;
  pBookmark := FDataSet.GetBookmark;
  try
    SetCurDSRecord(ARowid);
    FDataSet.Delete;
    FModule.Database.SetLastAutoGenValue(0);
    if FDataSet.BookmarkValid(pBookmark) then
      FDataSet.GotoBookmark(pBookmark);
  finally
    FDataSet.FreeBookmark(pBookmark);
  end;
end;

{-------------------------------------------------------------------------------}
{ Cursor }

function TSQLiteVDSTable.VTabOpen: TSQLiteVCursor;
begin
  if not FMultipleCursors and (FCursors.Count >= 1) then
    VDSError(Self, er_FD_SQLiteVTabDataSetBusy, [FName]);
  Result := TSQLiteVDSCursor.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.Rewind;
begin
  if IsUnidirectional then begin
    if not (FDataSet.Bof and not FDataSet.Eof) then
      FDataSet.Active := False;
  end
  else if not FMultipleCursors then begin
    if not FDataSet.Bof and FDataSet.Active then
      FDataSet.First;
  end;
  ActivateDataSet(True);
  CheckResultset(True);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSTable.CheckClose;
begin
  if FCursors.Count = 0 then
    TSQLiteVDSModule(FModule).SetDataSetState(FSchemaName, FName, FDataSet, False);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVDSCursor                                                              }
{-------------------------------------------------------------------------------}
constructor TSQLiteVDSCursor.Create(ATable: TSQLiteVDSTable);
begin
  inherited Create(ATable);
  if ATable.FDisableControls then
    ATable.FDataSet.DisableControls;
  ATable.Rewind;
  // Clone / copy DS for each cursor. SQLite creates a cursor for each
  // DS reference in a SQL command.
  if ATable.FMultipleCursors then begin
    FMemTable := TFDMemTable.Create(nil);
    FDataSet := FMemTable;
    FAdapter := IFDPhysLocalSQLAdapter(FMemTable);
    if (Table.FDataSet is TFDDataSet) and TFDDataSet(Table.FDataSet).ClientCursor and
       not Table.IsUnidirectional then
      FMemTable.CloneCursor(TFDDataSet(Table.FDataSet))
    else
      FMemTable.CopyDataSet(Table.FDataSet, [coStructure, coCalcFields,
        coRestart, coAppend, coIndexesCopy, coConstraintsCopy, coAggregatesCopy]);
  end
  else begin
    FMemTable := nil;
    FDataSet := ATable.FDataSet;
    FAdapter := ATable.FAdapter;
  end;
  if FDataSet is TFDDataSet then
    TFDDataSet(FDataSet).Table.Locale := 0;
  FKeyFields := TFDFieldList.Create;
  FDataSet.GetFieldList(FKeyFields, ATable.FKeyFieldNames);
  FConstrs := TFDPtrList.Create;
  FRangeCols := TFDStringList.Create;
  FFilterCols := TFDPtrList.Create;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSCursor.VTabClose();
begin
  if (TSQLiteVDSTable(FTable).FDataSet <> nil) and TSQLiteVDSTable(FTable).FDisableControls then
    TSQLiteVDSTable(FTable).FDataSet.EnableControls;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteVDSCursor.Destroy;
var
  oTab: TSQLiteVDSTable;
begin
  oTab := Table;
  CleanupFilter;
  FDataSet := nil;
  FAdapter := nil;
  FDFreeAndNil(FMemTable);
  FDFreeAndNil(FKeyFields);
  FDFreeAndNil(FConstrs);
  FDFreeAndNil(FRangeCols);
  FDFreeAndNil(FFilterCols);
  inherited Destroy;
  if oTab <> nil then
    oTab.CheckClose;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSCursor.GetTable: TSQLiteVDSTable;
begin
  Result := TSQLiteVDSTable(FTable);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSCursor.GetFieldData(AColumn: Integer);
var
  oFld: TField;
  oCol: TSQLiteOutput;
  pBuff: Pointer;
  oStream: TStream;
begin
  oFld := FDataSet.Fields[AColumn];
  oCol := ColsOUT[AColumn];
  if oFld.IsNull then
    oCol.Clear
  else
    case oFld.DataType of
    ftBoolean:
      oCol.AsBoolean := oFld.AsBoolean;
    ftByte,
    ftShortint,
    ftLongWord,
    ftInteger,
    ftWord,
    ftSmallint,
    ftAutoInc:
      oCol.AsInteger := oFld.AsInteger;
    ftLargeint:
      oCol.AsInteger := oFld.AsLargeInt;
    ftExtended,
    ftSingle,
    ftFloat:
      oCol.AsFloat := oFld.AsFloat;
    ftBCD,
    ftCurrency:
      oCol.AsCurrency := oFld.AsCurrency;
    ftFMTBcd:
      oCol.AsNumber := oFld.AsBCD;
    ftTimeStamp,
    ftOraInterval,
    ftOraTimeStamp,
    ftTimeStampOffset,
    ftDateTime,
    ftParadoxOle:
      oCol.AsDateTime := oFld.AsDateTime;
    ftDate:
      oCol.AsDate := oFld.AsDateTime;
    ftTime:
      oCol.AsTime := oFld.AsDateTime;
    ftString,
    ftFixedChar,
    ftGUID:
{$IFDEF NEXTGEN}
      oCol.AsAnsiString := oFld.AsString;
{$ELSE}
      oCol.AsAnsiString := TFDAnsiString(oFld.AsAnsiString);
{$ENDIF}
    ftMemo,
    ftOraClob:
      oCol.AsString := oFld.AsString;
    ftWideMemo,
    ftFixedWideChar,
    ftWideString,
    ftFmtMemo,
    ftDBaseOle:
      oCol.AsWideString := oFld.AsWideString;
    ftBlob,
    ftOraBlob,
    ftBytes,
    ftVarBytes,
    ftGraphic,
    ftTypedBinary:
      begin
        oStream := FDataSet.CreateBlobStream(oFld, bmRead);
        pBuff := nil;
        try
          if oStream.Size > 0 then begin
            GetMem(pBuff, oStream.Size);
            oStream.ReadBuffer(PByte(pBuff)^, oStream.Size);
            oCol.SetData(pBuff, oStream.Size, etBlob);
          end;
        finally
          FreeMem(pBuff);
          FDFree(oStream);
        end;
      end;
    else
      VDSError(Self, er_FD_SQLiteVTabDSNotSupported, []);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSCursor.VTabColumn(const AIndex: Integer);
begin
  Table.CheckResultset;
  GetFieldData(AIndex);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSCursor.VTabNext;
begin
  Table.CheckResultset;
  FDataSet.Next;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVDSCursor.VTabEof: Boolean;
begin
  Table.CheckResultset;
  Result := FDataSet.Eof;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSCursor.VTabRowid(var ARowid: sqlite3_int64);
begin
  Table.CheckResultset;
  ARowid := Table.GetCurRowid(FDataSet, FKeyFields);
end;

{-------------------------------------------------------------------------------}
type
  TSQLiteVDSRange = (rgNone, rgStart, rgEnd, rgBoth);
  TSQLiteVDSIndexRec = record
    FPredicate: Boolean;
    FCol: Integer;
    FOp: TSQLiteVConstraintOp;
    FBorders: TSQLiteVDSRange;
    FOrd: String;
    FRangeInd: Integer;
    FSkipSort: Boolean;
    FInFilter: Boolean;
    FAlone: Boolean;
    // ID of ColsIN collection
    FExprId: Integer;
  end;
  PSQLiteVDSIndexRec = ^TSQLiteVDSIndexRec;

procedure CleanUpVarRec(var AVar: TVarRec);
begin
  if AVar.VType = vtUnicodeString then
    UnicodeString(AVar.VUnicodeString) := ''
  else
  if AVar.VType = vtWideString then
    {$IFDEF NEXTGEN} String {$ELSE} WideString {$ENDIF} (AVar.VWideString) := ''
{$IFNDEF NEXTGEN}
  else if AVar.VType = vtAnsiString then
    AnsiString(AVar.VAnsiString) := '';
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSCursor.CleanupFilter;
var
  i: Integer;
begin
  if FConstrs <> nil then begin
    for i := 0 to FConstrs.Count - 1 do
      Dispose(PSQLiteVDSIndexRec(FConstrs[i]));
    FConstrs.Clear;
  end;
  if FRangeCols <> nil then
    FRangeCols.Clear;
  if FFilterCols <> nil then
    FFilterCols.Clear;
  for i := Low(FStart) to High(FStart) do
    CleanUpVarRec(FStart[i]);
  for i := Low(FEnd) to High(FEnd) do
    CleanUpVarRec(FEnd[i]);
  SetLength(FStart, 0);
  SetLength(FEnd, 0);
  FUseRanges := False;
  FEmptyStart := False;
  FEmptyEnd := False;
  FSort := '';
  FLastIndexStr := '';
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSCursor.SetupFilter(const AIndex: Integer; const AIndexStr: String);
const
  C_SKIP_CHECK = -1000;
var
  sConstr: String;
  i, j, k, iEq, iRgLen, iConstrs: Integer;
  pConstr: PSQLiteVDSIndexRec;
  aColMap: array of Integer;
  lHasOrderBy: Boolean;

  procedure SetupExtraCol(ACol: PSQLiteVDSIndexRec; AAlone: Boolean;
    ARangeInd, AConstrIndx: Integer);
  begin
    ACol^.FSkipSort := True;
    ACol^.FInFilter := False;
    ACol^.FRangeInd := ARangeInd;
    ACol^.FAlone := AAlone;
    if not FExcludeStart then
      FExcludeStart := (ACol^.FOp = coGreater);
    if not FExcludeEnd then
      FExcludeEnd := (ACol^.FOp = coLess);
    FRangeCols.AddPtr(IntToStr(ACol^.FCol), FConstrs[AConstrIndx]);
  end;

  function AddExtraRangeCol(AIndex, ARequired: Integer): Boolean;
  var
    l, iRangeInd, iStart, iEnd: Integer;
    pInd, pStart, pEnd: PSQLiteVDSIndexRec;
  begin
    Result := ARequired = 1;
    iRangeInd := FRangeCols.Count;
    FExcludeStart := False;
    FExcludeEnd := False;
    pStart := nil;
    pEnd := nil;
    iStart := -1;
    iEnd := -1;
    for l := 0 to FConstrs.Count - 1 do begin
      pInd := PSQLiteVDSIndexRec(FConstrs[l]);
      if pInd^.FCol = AIndex then begin
        if pStart = nil then begin
          pStart := pInd;
          iStart := l;
        end
        else begin
          pEnd := pInd;
          iEnd := l;
        end;
        if (ARequired = 1) or (pEnd <> nil) then
          Break;
      end;
    end;

    // reject mistaken cases like (f1 > 0) and (f1 >= 5)
    if not Result then
      Result := (pStart^.FOp <> pEnd^.FOp) and
                not ((pStart^.FOp in [coGreater, coGreaterOrEqual]) and
                     (pEnd^.FOp in [coGreater, coGreaterOrEqual]))  and
                not ((pStart^.FOp in [coLess, coLessOrEqual]) and
                     (pEnd^.FOp in [coLess, coLessOrEqual]));

    if Result then begin
      FSort := FSort + FDataSet.Fields[pStart^.FCol].FieldName + pStart^.FOrd;
      SetupExtraCol(pStart, ARequired = 1, iRangeInd, iStart);
      if ARequired = 2 then
        SetupExtraCol(pEnd, False, iRangeInd, iEnd);
    end;
  end;

begin
  SetLength(aColMap, Count);
  iRgLen := 0;
  // we use ranges if supported and if filtering constrs are there
  // it's a preliminary check
  FUseRanges := (Table.FMultipleCursors or (afRanges in FAdapter.Features)) and
    (Pos('=', AIndexStr) > 0);
  lHasOrderBy := False;
  iConstrs := 0;
  i := 1;
  while i <= Length(AIndexStr) do begin
    sConstr := FDExtractFieldName(AIndexStr, i);
    New(pConstr);
    if sConstr[1] = 'D' then
      pConstr^.FOrd := ':D;'
    else
      pConstr^.FOrd := ':A;';
    pConstr^.FSkipSort := sConstr[1] = 'C';
    lHasOrderBy := lHasOrderBy or not pConstr^.FSkipSort;
    iEq := Pos('=', sConstr);
    pConstr^.FPredicate := (iEq > 0);
    pConstr^.FInFilter := pConstr^.FPredicate;
    if pConstr^.FPredicate then begin
      pConstr^.FCol := StrToInt(Copy(sConstr, 2, iEq - 2));
      pConstr^.FOp := TSQLiteVConstraintOp(StrToInt(Copy(sConstr, iEq + 1, MAXINT)));
      pConstr^.FAlone := False;
      Inc(iConstrs);
      if FUseRanges then begin
        // case when user mixed up "=" operation for same column with other ops
        // we put that column to Filter instead of Ranges
        k := FRangeCols.IndexOf(IntToStr(pConstr^.FCol));
        if k <> -1 then begin
          PSQLiteVDSIndexRec(FRangeCols.Ptrs[k])^.FInFilter := True;
          FRangeCols.Delete(k);
          pConstr^.FInFilter := True;
          aColMap[pConstr^.FCol] := C_SKIP_CHECK;
        end;
        case pConstr^.FOp of
        coEqual:
          begin
            pConstr^.FBorders := rgBoth;
            // immediately add "=" ops to preliminary Range list
            if aColMap[pConstr^.FCol] = 0 then begin
              FRangeCols.AddPtr(IntToStr(pConstr^.FCol), pConstr);
              pConstr^.FInFilter := False;
            end
            else
              aColMap[pConstr^.FCol] := C_SKIP_CHECK;
          end;
        coLess,
        coLessOrEqual:    pConstr^.FBorders := rgEnd;
        coGreater,
        coGreaterOrEqual: pConstr^.FBorders := rgStart;
        else              pConstr^.FBorders := rgNone;
        end;
        Inc(iRgLen);
        // count times the column participates in conditions
        Inc(aColMap[pConstr^.FCol]);
      end;

      // this is ID of ColsIN collection to use the expression from
      pConstr^.FExprId := FConstrs.Count;
    end
    else
      pConstr^.FCol := StrToInt(Copy(sConstr, 2, Length(sConstr) - 1));
    FConstrs.Add(pConstr);
  end;
  ASSERT(iConstrs <= Count);

  // 2nd iteration to add extra columns to Range in addition with ones that
  // pariticipate in "=" operations
  if FUseRanges then begin
    for i := 0 to FRangeCols.Count - 1 do begin
      pConstr := PSQLiteVDSIndexRec(FRangeCols.Ptrs[i]);
      FSort := FSort + FDataSet.Fields[pConstr^.FCol].FieldName + pConstr^.FOrd;
      pConstr^.FRangeInd := i;
      pConstr^.FSkipSort := True;
      aColMap[pConstr^.FCol] := C_SKIP_CHECK;
    end;
    iRgLen := FRangeCols.Count;
    FEmptyStart := (iRgLen = 0);
    FEmptyEnd := FEmptyStart;
    if not lHasOrderBy then begin
      j := iRgLen;
      k := -1;
      for i := Low(aColMap) to High(aColMap) do
        // column is used in >, <, >= or <= ops
        if aColMap[i] = 2 then begin
          if not AddExtraRangeCol(i, 2) then
            Continue;
          Inc(iRgLen);
          FEmptyStart := False;
          FEmptyEnd := False;
          Break;
        end
        else if (k = -1) and (aColMap[i] = 1) then
          k := i;
      if (j = FRangeCols.Count) and (k <> -1) then begin
        AddExtraRangeCol(k, 1);
        Inc(iRgLen);
        if FEmptyStart then
          FEmptyStart := PSQLiteVDSIndexRec(FRangeCols.Ptrs[0])^.FOp in [coLess, coLessOrEqual];
        if FEmptyEnd then
          FEmptyEnd := PSQLiteVDSIndexRec(FRangeCols.Ptrs[0])^.FOp in [coGreater, coGreaterOrEqual];
      end;
    end;
    FUseRanges := (FRangeCols.Count > 0);
  end;

  // add leftovers to FSort string
  if lHasOrderBy then
    for i := 0 to FConstrs.Count - 1 do begin
      pConstr := PSQLiteVDSIndexRec(FConstrs[i]);
      if not pConstr^.FSkipSort then
        FSort := FSort + FDataSet.Fields[pConstr^.FCol].FieldName + pConstr^.FOrd;
    end;
  if FSort <> '' then begin
    if FSort[Length(FSort)] = ';' then
      FSort := Copy(FSort, 1, Length(FSort) - 1);
  end;

  // 3rd iteration for Filter constrs
  for i := 0 to FConstrs.Count - 1 do begin
    pConstr := PSQLiteVDSIndexRec(FConstrs[i]);
    if pConstr^.FInFilter then
      FFilterCols.Add(pConstr);
  end;

  if FUseRanges then begin
    SetLength(FStart, iRgLen);
    SetLength(FEnd, iRgLen);
    for i := Low(FStart) to High(FStart) do begin
      FillChar(FStart[i], SizeOf(TVarRec), 0);
      FillChar(FEnd[i], SizeOf(TVarRec), 0);
    end;
  end;

  FLastIndexStr := AIndexStr;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVDSCursor.VTabFilter(const AIndex: Integer; const AIndexStr: String);
const
  C_AND: array [Boolean] of String = ('', ' AND ');
  C_QUOTES: array [Boolean] of String = ('', '''');
  C_OP: array [TSQLiteVConstraintOp] of String = ('=', '>', '<', '<=', '>=', '');
var
  sFilter, sVal: String;
  i: Integer;
  lStrings: Boolean;
  pConstr: PSQLiteVDSIndexRec;
  oIn: TSQLiteInput;
  oFld: TField;

  procedure SetVarRec(var AVar: TVarRec; AIndex, ACol: Integer);
  var
    aBuff: array [0 .. 63] of Char;
    iLen: Integer;
    oIn: TSQLiteInput;
    oFld: TField;
    pData: Pointer;
  begin
    CleanUpVarRec(AVar);
    AVar.VType := vtUnicodeString;
    oIn := ColsIN[AIndex];
    if oIn.ExtDataType = etUString then begin
      oIn.GetData(pData, iLen, True, etUString);
      SetString(UnicodeString(AVar.VUnicodeString), PChar(pData), iLen);
    end
    else begin
      oFld := FDataSet.Fields[ACol];
      if oFld.DataType = ftDate then
        DateTimeToString(UnicodeString(AVar.VUnicodeString), FormatSettings.ShortDateFormat,
          oIn.AsDate, FormatSettings)
      else if oFld.DataType = ftTime then
        DateTimeToString(UnicodeString(AVar.VUnicodeString), FormatSettings.LongTimeFormat,
          oIn.AsDate, FormatSettings)
      else if oFld.DataType in CDateTimeTypes then
        DateTimeToString(UnicodeString(AVar.VUnicodeString), '', oIn.AsDateTime, FormatSettings)
      else if oFld.DataType in CNumericTypes then begin
        FDBCD2Str(aBuff, iLen, oIn.AsNumber, FormatSettings.DecimalSeparator);
        SetString(UnicodeString(AVar.VUnicodeString), aBuff, iLen);
      end
      else if oFld.DataType = ftBoolean then
        UnicodeString(AVar.VUnicodeString) := S_FD_Bools[oIn.AsBoolean]
      else if oFld.DataType in CBlobTypes then begin
        oIn.GetData(pData, iLen, True, etBlob);
{$IFDEF NEXTGEN}
        AVar.VType := vtUnicodeString;
        SetString(UnicodeString(AVar.VUnicodeString), PChar(pData), (iLen + 1) div 2);
{$ELSE}
        AVar.VType := vtAnsiString;
        SetString(AnsiString(AVar.VAnsiString), PAnsiChar(pData), iLen);
{$ENDIF}
      end
      else begin
        oIn.GetData(pData, iLen, True, etUString);
        SetString(UnicodeString(AVar.VUnicodeString), PChar(pData), iLen);
      end;
    end;
  end;

begin
  Table.CheckResultset;
  if FLastIndexStr <> AIndexStr then
    CleanupFilter;
  if AIndexStr = '' then begin
    FDataSet.Filtered := False;
    FDataSet.Filter := '';
    if FMemTable <> nil then
      FMemTable.First
    else
      Table.Rewind;
    Exit;
  end
  else if FLastIndexStr <> AIndexStr then
    SetupFilter(AIndex, AIndexStr);
  sFilter := '';

  for i := 0 to FRangeCols.Count - 1 do begin
    pConstr := PSQLiteVDSIndexRec(FRangeCols.Ptrs[i]);
    if pConstr^.FBorders in [rgStart, rgBoth] then
      SetVarRec(FStart[pConstr^.FRangeInd], pConstr^.FExprId, pConstr^.FCol)
    else if pConstr^.FAlone and (pConstr^.FRangeInd < Length(FStart)) then begin
      FStart[pConstr^.FRangeInd].VType := vtAnsiString;
      CleanUpVarRec(FStart[pConstr^.FRangeInd]);
      SetLength(FStart, Length(FStart) - 1);
    end;
    if pConstr^.FBorders in [rgEnd, rgBoth] then
      SetVarRec(FEnd[pConstr^.FRangeInd], pConstr^.FExprId, pConstr^.FCol)
    else if pConstr^.FAlone and (pConstr^.FRangeInd < Length(FEnd)) then begin
      FEnd[pConstr^.FRangeInd].VType := vtAnsiString;
      CleanUpVarRec(FEnd[pConstr^.FRangeInd]);
      SetLength(FEnd, Length(FEnd) - 1);
    end;
  end;

  for i := 0 to FFilterCols.Count - 1 do begin
    pConstr := PSQLiteVDSIndexRec(FFilterCols[i]);
    oFld := FDataSet.Fields[pConstr^.FCol];
    oIn := ColsIN[pConstr^.FExprId];
    lStrings := oFld.DataType in (CStringTypes + CWideStringTypes +
      CBlobTypes + CDateTimeTypes);
    if oFld.DataType = ftDate then
      sVal := DateToStr(oIn.AsDate)
    else if oFld.DataType = ftTime then
      sVal := TimeToStr(oIn.AsTime)
    else if oFld.DataType in CDateTimeTypes then
      sVal := DateTimeToStr(oIn.AsDateTime)
    else
      sVal := oIn.AsString;
    sFilter := sFilter + C_AND[i > 0] + oFld.FieldName + ' ' + C_OP[pConstr^.FOp] + ' ' +
      C_QUOTES[lStrings] + sVal + C_QUOTES[lStrings];
  end;

  if FSort <> '' then
    FAdapter.IndexFieldNames := FSort;
  if FUseRanges then
    if FRangeCols.Count > 0 then begin
      if FEmptyStart then
        FAdapter.SetRange([], FEnd, FExcludeStart, FExcludeEnd)
      else if FEmptyEnd then
        FAdapter.SetRange(FStart, [], FExcludeStart, FExcludeEnd)
      else
        FAdapter.SetRange(FStart, FEnd, FExcludeStart, FExcludeEnd);
    end
    else
      FAdapter.CancelRange;

  if sFilter <> '' then begin
    if not (afFilters in FAdapter.Features) then
      VDSError(Self, er_FD_SQLiteVTabDSNotSupported, []);
    FDataSet.Filter := sFilter;
    FDataSet.Filtered := True;
  end
  else begin
    FDataSet.Filtered := False;
    FDataSet.Filter := '';
  end;

  FDataSet.First;
end;

{-------------------------------------------------------------------------------}
initialization
  FDExtensionManager().AddModule('DataSet', TSQLiteVDSModule);

end.
