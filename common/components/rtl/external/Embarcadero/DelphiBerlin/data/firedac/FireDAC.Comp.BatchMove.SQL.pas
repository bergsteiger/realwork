{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC TFDBatchMove SQL driver            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Comp.BatchMove.SQL;

interface

uses
  System.Classes, Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Comp.Client, FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.DataSet;

type
  TFDBatchMoveSQLDriver = class;
  TFDBatchMoveSQLReader = class;
  TFDBatchMoveSQLWriter = class;

  TFDBatchMoveSQLDriver = class(TFDBatchMoveDataSetDriver)
  private
    FConnection: TFDCustomConnection;
    FConnectionName: String;
    FTransaction: TFDCustomTransaction;
    FTableName: String;
    FReadSQL: String;
    FReadQuery: TFDQuery;
    FActualConnection: TFDCustomConnection;
    procedure SetConnection(const AValue: TFDCustomConnection);
    procedure SetConnectionName(const AValue: String);
    procedure SetTransaction(const AValue: TFDCustomTransaction);
    procedure SetReadSQL(const AValue: String);
    procedure SetTableName(const AValue: String);
  protected
    // TFDBatchMoveDataSetDriver
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function CheckDefined(ARaise: Boolean): Boolean; override;
    procedure Open(AStartTx: Boolean); override;
    procedure Close(AStopTxError: Boolean); override;
    // introduced
    function GetActualTableName: String; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ActualTableName: String read GetActualTableName;
  published
    property Connection: TFDCustomConnection read FConnection write SetConnection;
    property ConnectionName: String read FConnectionName write SetConnectionName;
    property Transaction: TFDCustomTransaction read FTransaction write SetTransaction;
    property TableName: String read FTableName write SetTableName;
    property ReadSQL: String read FReadSQL write SetReadSQL;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDBatchMoveSQLReader = class(TFDBatchMoveSQLDriver, IFDBatchMoveReader)
  protected
    // IFDBatchMoveReader
    function GetSourceTableName: String;
    procedure Open(AStartTx: Boolean); override;
    procedure Refresh; override;
    procedure ReadHeader;
    function Eof: Boolean;
    procedure ReadRecord;
    procedure NextRecord;
    procedure GuessFormat(AAnalyze: TFDBatchMoveAnalyze = [taDelimSep, taHeader, taFields]);
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDBatchMoveSQLWriter = class(TFDBatchMoveSQLDriver, IFDBatchMoveWriter)
  private
    FWriteSQL: String;
    FGeneratorName: String;
    FRecIndex: Integer;
    FWriteQuery: TFDQuery;
    FCreateTableParts: TFDPhysCreateTableParts;
    function MoveRecord: Integer;
  protected
    // IFDBatchMoveWriter
    function GetIsBatch: Boolean; override;
    procedure Open(AStartTx: Boolean); override;
    procedure Close(AStopTxError: Boolean); override;
    procedure CreateTable;
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
    procedure Erase(ANoUndo: Boolean);
    procedure WriteHeader;
    function FindRecord: Boolean;
    function InsertRecord: Integer;
    function UpdateRecord: Integer;
    function DeleteRecord: Integer;
    function FlushRecords: Integer;
    function GetFieldCount: Integer;
    function GetFieldName(AIndex: Integer): String;
    function GetFieldIndex(const AName: String; ACheck: Boolean): Integer;
    function GetFieldInfo(AIndex: Integer; var AType: TFDDataType;
      var ASize: LongWord; var APrec, AScale: Integer; var AInKey, AIsIdentity: Boolean): TObject;
    // TFDBatchMoveSQLDriver
    function GetActualTableName: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property WriteSQL: String read FWriteSQL write FWriteSQL;
    property GeneratorName: String read FGeneratorName write FGeneratorName;
    /// <summary> The CreateTableParts property specifies which table definition
    ///  parts will be included into CREATE TABLE statement and which associated
    ///  database objects will be create together with table. </summary>
    property CreateTableParts: TFDPhysCreateTableParts read FCreateTableParts
      write FCreateTableParts default [tpTable .. tpIndexes];
  end;

implementation

uses
  System.SysUtils, System.Variants,
  FireDAC.Stan.Util, FireDAC.Stan.Consts, FireDAC.Stan.Error, FireDAC.Stan.Option,
    FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt,
  FireDAC.Comp.DataSet;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveSQLDriver                                                         }
{-------------------------------------------------------------------------------}
constructor TFDBatchMoveSQLDriver.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FReadQuery := TFDQuery.Create(nil);
  FReadQuery.ResourceOptions.CmdExecMode := amBlocking;
  FReadQuery.ResourceOptions.PreprocessCmdText := True;
  FReadQuery.FetchOptions.Mode := fmOnDemand;
  FReadQuery.FetchOptions.Unidirectional := True;
  FReadQuery.FetchOptions.Items := [fiMeta, fiBlobs, fiDetails];
  FReadQuery.FetchOptions.Cache := [];
  FReadQuery.UpdateOptions.FastUpdates := True;
  DataSet := FReadQuery;
end;

{-------------------------------------------------------------------------------}
destructor TFDBatchMoveSQLDriver.Destroy;
begin
  DataSet := nil;
  FDFreeAndNil(FReadQuery);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLDriver.SetConnection(const AValue: TFDCustomConnection);
begin
  if Connection <> AValue then begin
    if Connection <> nil then
      Connection.RemoveFreeNotification(Self);
    FConnection := AValue;
    if AValue <> nil then
      ConnectionName := '';
    if Connection <> nil then
      Connection.FreeNotification(Self);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLDriver.SetConnectionName(const AValue: String);
begin
  if CompareText(ConnectionName, AValue) <> 0 then begin
    FConnectionName := AValue;
    if AValue <> '' then
      Connection := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLDriver.SetTransaction(const AValue: TFDCustomTransaction);
begin
  if Transaction <> AValue then begin
    if Transaction <> nil then
      Transaction.RemoveFreeNotification(Self);
    FTransaction := AValue;
    if Transaction <> nil then
      Transaction.FreeNotification(Self);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLDriver.SetReadSQL(const AValue: String);
begin
  if ReadSQL <> AValue then begin
    FReadSQL := AValue;
    if ReadSQL <> '' then
      TableName := '';
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLDriver.SetTableName(const AValue: String);
begin
  if TableName <> AValue then begin
    FTableName := AValue;
    if TableName <> '' then
      ReadSQL := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLDriver.GetActualTableName: String;
begin
  Result := FDExpandStr(Trim(TableName));
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLDriver.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation = opRemove then
    if AComponent = Connection then
      Connection := nil
    else if AComponent = Transaction then
      Transaction := nil;
  inherited Notification(AComponent, Operation);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLDriver.CheckDefined(ARaise: Boolean): Boolean;
begin
  Result := ((ActualTableName <> '') or (ReadSQL <> '')) and
    ((Connection <> nil) or (ConnectionName <> ''));
  if not Result and ARaise then
    FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoSQLTab, []);

  Result := Result and (BatchMove.CommitCount > 0);
  if not Result and ARaise then
    FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoSQLBatch, []);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLDriver.Open(AStartTx: Boolean);
begin
  FReadQuery.DisableControls;
  FReadQuery.SQL.Clear;
  FReadQuery.ConnectionName := ConnectionName;
  FReadQuery.Connection := Connection;
  FReadQuery.Transaction := Transaction;
  FActualConnection := FReadQuery.PointedConnection;
  if FActualConnection = nil then
    FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], er_FD_DPNoSQLTab, []);
  inherited Open(AStartTx);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLDriver.Close(AStopTxError: Boolean);
begin
  FReadQuery.Disconnect();
  inherited Close(AStopTxError);
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveSQLReader                                                         }
{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLReader.GetSourceTableName: String;
begin
  if ReadSQL <> '' then
    Result := ''
  else
    Result := ActualTableName;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLReader.Open(AStartTx: Boolean);
begin
  inherited Open(AStartTx);
  if BatchMove.CommitCount > 0 then
    FReadQuery.FetchOptions.RowsetSize := BatchMove.CommitCount;
  if ReadSQL <> '' then
    FReadQuery.SQL.Text := ReadSQL
  else
    FReadQuery.SQL.Text := 'SELECT * FROM ' + ActualTableName;
  FReadQuery.Open;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLReader.Refresh;
begin
  FReadQuery.Close;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLReader.ReadHeader;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLReader.Eof: Boolean;
begin
  Result := DataSet.Eof;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLReader.ReadRecord;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLReader.NextRecord;
begin
  DataSet.Next;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLReader.GuessFormat(AAnalyze: TFDBatchMoveAnalyze);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveSQLWriter                                                         }
{-------------------------------------------------------------------------------}
constructor TFDBatchMoveSQLWriter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWriteQuery := TFDQuery.Create(nil);
  FWriteQuery.ResourceOptions.CmdExecMode := amBlocking;
  FWriteQuery.ResourceOptions.PreprocessCmdText := True;
  FReadQuery.FetchOptions.RowsetSize := 1;
  FCreateTableParts := [tpTable .. tpIndexes];
end;

{-------------------------------------------------------------------------------}
destructor TFDBatchMoveSQLWriter.Destroy;
begin
  FDFreeAndNil(FWriteQuery);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.GetActualTableName: String;
begin
  Result := inherited GetActualTableName;
  if Result = '' then
    Result := FDExpandStr(Trim(BatchMove.Reader.SourceTableName));
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.GetIsBatch: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLWriter.Open(AStartTx: Boolean);
var
  oGen: IFDPhysCommandGenerator;
  i: Integer;
  oPar: TFDParam;
  oFld: TField;
  lHasArrays: Boolean;
begin
  inherited Open(AStartTx);
  FRecIndex := 0;

  if ReadSQL <> '' then
    FReadQuery.SQL.Text := ReadSQL
  else
    FReadQuery.SQL.Text := 'SELECT * FROM ' + ActualTableName + ' WHERE 0=1';
  try
    FReadQuery.Open;
  except
    on E: EFDDBEngineException do
      if (poCreateDest in BatchMove.Options) and
         (ReadSQL = '') and (E.Kind = ekObjNotExists) then begin
        CreateTable;
        FReadQuery.Open;
      end
      else
        raise;
  end;
  if poIdentityInsert in BatchMove.Options then
    for i := 0 to FReadQuery.FieldCount - 1 do begin
      oFld := FReadQuery.Fields[i];
      if oFld is TFDAutoIncField then
        TFDAutoIncField(oFld).IdentityInsert := True
      else begin
        oFld.ReadOnly := False;
        oFld.ProviderFlags := oFld.ProviderFlags + [pfInUpdate];
      end;
    end;

  FWriteQuery.ConnectionName := ConnectionName;
  FWriteQuery.Connection := Connection;
  FWriteQuery.Transaction := Transaction;
  FWriteQuery.SQL.Clear;
  FWriteQuery.Params.Clear;

  if WriteSQL <> '' then
    FWriteQuery.SQL.Text := WriteSQL
  else begin
    FActualConnection.ConnectionIntf.CreateCommandGenerator(oGen, FReadQuery.Command.CommandIntf);
    oGen.FillRowOptions := [];
    oGen.GenOptions := [goBeautify, goNoVersion];
    oGen.Options := FReadQuery.OptionsIntf;
    oGen.Table := FReadQuery.Table;
    oGen.Params := FWriteQuery.Params;

    case BatchMove.Mode of
    dmAlwaysInsert: FWriteQuery.SQL.Text := oGen.GenerateInsert;
    dmAppend:       FWriteQuery.SQL.Text := oGen.GenerateMerge(maInsertIgnore);
    dmUpdate:       FWriteQuery.SQL.Text := oGen.GenerateUpdate;
    dmAppendUpdate: FWriteQuery.SQL.Text := oGen.GenerateMerge(maInsertUpdate);
    dmDelete:       FWriteQuery.SQL.Text := oGen.GenerateDelete;
    end;
  end;

  lHasArrays := False;
  FWriteQuery.Params.ArraySize := 1;
  for i := 0 to FWriteQuery.ParamCount - 1 do begin
    oPar := FWriteQuery.Params[i];
    oFld := FReadQuery.FindField(oPar.Name);
    if oFld <> nil then begin
      oPar.AssignFieldValue(oFld, Null);
      lHasArrays := lHasArrays or (oPar.ArrayType = atTable);
    end;
  end;
  if not lHasArrays then
    FWriteQuery.Params.ArraySize := BatchMove.CommitCount;

  if AStartTx and (BatchMove.CommitCount > 0) then
    StartTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLWriter.CreateTable;
var
  oTab: TFDTable;
begin
  if ReadSQL = '' then begin
    oTab := TFDTable.Create(nil);
    try
      oTab.ConnectionName := ConnectionName;
      oTab.Connection := Connection;
      oTab.Transaction := Transaction;
      oTab.TableName := ActualTableName;
      oTab.UpdateOptions.GeneratorName := GeneratorName;
                                                                  
                                                         
      BatchMove.Reader.GetTableDefs(oTab.FieldDefs, oTab.IndexDefs);
      oTab.CreateTable(True, CreateTableParts);
    finally
      FDFree(oTab);
    end;
  end
  else
    FDCapabilityNotSupported(BatchMove, [S_FD_LComp, S_FD_LComp_PDM]);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLWriter.Close(AStopTxError: Boolean);
begin
  FWriteQuery.Disconnect();
  FWriteQuery.Params.ClearValues();
  inherited Close(AStopTxError);
  if AStopTxError then
    RollbackTransaction
  else
    CommitTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLWriter.StartTransaction;
begin
  if Transaction <> nil then begin
    if not Transaction.Active then
      Transaction.StartTransaction;
  end
  else begin
    if not FActualConnection.InTransaction then
      FActualConnection.StartTransaction;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLWriter.RollbackTransaction;
begin
  if Transaction <> nil then begin
    if Transaction.Active then
      Transaction.Rollback;
  end
  else begin
    if FActualConnection.InTransaction then
      FActualConnection.Rollback;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLWriter.CommitTransaction;
begin
  if Transaction <> nil then begin
    if Transaction.Active then
      Transaction.Commit;
  end
  else begin
    if FActualConnection.InTransaction then
      FActualConnection.Commit;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLWriter.Erase(ANoUndo: Boolean);
var
  oConnMeta: IFDPhysConnectionMetadata;
  oGen: IFDPhysCommandGenerator;
  oCmd: IFDPhysCommand;
begin
  FActualConnection.ConnectionIntf.CreateMetadata(oConnMeta);
  if ANoUndo and oConnMeta.TruncateSupported then
    if Transaction <> nil then
      while Transaction.Active do
        Transaction.Commit
    else
      while FActualConnection.InTransaction do
        FActualConnection.Commit;

  FActualConnection.ConnectionIntf.CreateCommandGenerator(oGen, FReadQuery.Command.CommandIntf);
  oGen.Table := FReadQuery.Table;
  FActualConnection.ConnectionIntf.CreateCommand(oCmd);
  if Transaction <> nil then
    oCmd.Transaction := Transaction.TransactionIntf;
  oCmd.CommandText := oGen.GenerateDeleteAll(ANoUndo);
  oCmd.CommandKind := oGen.CommandKind;
  oCmd.Prepare;
  oCmd.Execute(1, 0, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveSQLWriter.WriteHeader;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.FindRecord: Boolean;
begin
  // nothing
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.InsertRecord: Integer;
begin
  Result := MoveRecord;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.UpdateRecord: Integer;
begin
  Result := MoveRecord;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.DeleteRecord: Integer;
begin
  Result := MoveRecord;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.MoveRecord: Integer;
var
  i, j: Integer;
  oPar: TFDParam;
  oItem: TFDBatchMoveMappingItem;
begin
  BatchMove.Mappings.Move(False);
  for i := 0 to FWriteQuery.Params.Count - 1 do begin
    oPar := FWriteQuery.Params[i];
    for j := 0 to BatchMove.Mappings.Count - 1 do begin
      oItem := BatchMove.Mappings[j];
      if oItem.DestFieldObj = oPar then begin
        oPar.Values[FRecIndex] := oItem.DestValue;
        Break;
      end;
    end;
  end;
  Inc(FRecIndex);
  if FRecIndex >= FWriteQuery.Params.ArraySize then
    Result := FlushRecords
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.FlushRecords: Integer;
begin
  try
    if FRecIndex <= 0 then
      Result := 0
    else begin
                                                   
                                                                             
      FWriteQuery.Execute(FRecIndex, 0);
      Result := FWriteQuery.RowsAffected;
    end;
  finally
    FRecIndex := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.GetFieldCount: Integer;
begin
  Result := FWriteQuery.Params.Count;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.GetFieldName(AIndex: Integer): String;
begin
  Result := FWriteQuery.Params[AIndex].Name;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.GetFieldIndex(const AName: String;
  ACheck: Boolean): Integer;
var
  oPar: TFDParam;
begin
  if ACheck then
    Result := FWriteQuery.Params.ParamByName(AName).Index
  else begin
    oPar := FWriteQuery.Params.FindParam(AName);
    if oPar <> nil then
      Result := oPar.Index
    else
      Result := -1;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveSQLWriter.GetFieldInfo(AIndex: Integer;
  var AType: TFDDataType; var ASize: LongWord; var APrec, AScale: Integer;
  var AInKey, AIsIdentity: Boolean): TObject;
var
  oPar: TFDParam;
  oField: TField;
  eAttrs: TFDDataAttributes;
begin
  AType := dtUnknown;
  ASize := 0;
  APrec := 0;
  AScale := 0;
  eAttrs := [];
  oPar := FWriteQuery.Params[AIndex];
  oField := FReadQuery.FindField(oPar.Name);
  if oField <> nil then begin
    TFDFormatOptions.FieldDef2ColumnDef(oField, AType, ASize, APrec, AScale, eAttrs);
    AInKey := pfInKey in oField.ProviderFlags;
    AIsIdentity := (oField is TFDAutoIncField) or
      (caAutoInc in FReadQuery.GetFieldColumn(oField).ActualAttributes);
  end
  else begin
    TFDFormatOptions.FieldDef2ColumnDef(oPar.DataType, oPar.Size, oPar.Precision,
      oPar.NumericScale, AType, ASize, APrec, AScale, eAttrs);
    AInKey := False;
    AIsIdentity := False;
  end;
  Result := oPar;
end;

end.
