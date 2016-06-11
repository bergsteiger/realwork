{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC TFDBatchMove dataset driver          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Comp.BatchMove.DataSet;

interface

uses
  System.Classes, Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Comp.Client, FireDAC.Comp.BatchMove;

type
  TFDBatchMoveDataSetDriver = class;
  TFDBatchMoveDataSetReader = class;
  TFDBatchMoveDataSetWriter = class;

  TFDBatchMoveDataSetDriver = class(TFDBatchMoveDriver, IFDBatchMoveDriver)
  private
    FActive: Boolean;
    FDataSet: TDataSet;
    FOptimise: Boolean;
    procedure SetDataSet(const AValue: TDataSet);
    function GetProvider: IProviderSupportNG;
    function GetFDDataSet: TFDAdaptedDataSet; inline;
    function IsMemTable: Boolean;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    // IFDBatchMoveDriver
    function CheckDefined(ARaise: Boolean): Boolean; virtual;
    procedure Open(AStartTx: Boolean); virtual;
    procedure Close(AStopTxError: Boolean); virtual;
    procedure Refresh; virtual;
    procedure AbortJob;
    function AddAutoFields: Boolean;
    procedure DeleteAutoFields;
    function GetCatalog: String;
    function GetIsUnicode: Boolean;
    function GetIsOpen: Boolean; virtual;
    function GetFieldCount: Integer;
    function GetFieldName(AIndex: Integer): String;
    function GetFieldIndex(const AName: String; ACheck: Boolean): Integer;
    function GetFieldInfo(AIndex: Integer; var AType: TFDDataType;
      var ASize: LongWord; var APrec, AScale: Integer; var AInKey, AIsIdentity: Boolean): TObject;
    procedure GetTableDefs(AFieldDefs: TFieldDefs; AIndexDefs: TIndexDefs);
    // introduced
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property Optimise: Boolean read FOptimise write FOptimise default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Provider: IProviderSupportNG read GetProvider;
    property FDDataSet: TFDAdaptedDataSet read GetFDDataSet;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDBatchMoveDataSetReader = class(TFDBatchMoveDataSetDriver, IFDBatchMoveReader)
  private
    FRewind: Boolean;
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
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Rewind: Boolean read FRewind write FRewind default True;
    property DataSet;
    property Optimise;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDBatchMoveDataSetWriter = class(TFDBatchMoveDataSetDriver, IFDBatchMoveWriter)
  private
    FConnection: TFDCustomConnection;
    FDisconnected: Boolean;
    FDirect: Boolean;
  protected
    // IFDBatchMoveWriter
    procedure Open(AStartTx: Boolean); override;
    procedure Close(AStopTxError: Boolean); override;
    procedure Refresh; override;
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
  published
    property Direct: Boolean read FDirect write FDirect default False;
    property DataSet;
    property Optimise;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Util, FireDAC.Stan.Consts, FireDAC.Stan.Error, FireDAC.Stan.Option,
  FireDAC.Comp.DataSet;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveDataSetDriver                                                     }
{-------------------------------------------------------------------------------}
constructor TFDBatchMoveDataSetDriver.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptimise := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDBatchMoveDataSetDriver.Destroy;
begin
  DataSet := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetDriver.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation = opRemove then
    if AComponent = DataSet then
      DataSet := nil;
  inherited Notification(AComponent, Operation);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetDriver.SetDataSet(const AValue: TDataSet);
begin
  if DataSet <> AValue then begin
    if DataSet <> nil then
      DataSet.RemoveFreeNotification(Self);
    FDataSet := AValue;
    if DataSet <> nil then
      DataSet.FreeNotification(Self);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetProvider: IProviderSupportNG;
begin
  Result := DataSet as IProviderSupportNG;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetFDDataSet: TFDAdaptedDataSet;
begin
  Result := TFDAdaptedDataSet(DataSet);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.IsMemTable: Boolean;
begin
  Result := (DataSet <> nil) and (DataSet is TFDCustomMemTable) and
    (TFDCustomMemTable(DataSet).Command = nil);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.CheckDefined(ARaise: Boolean): Boolean;
var
  iErr: Integer;
begin
  Result := (DataSet <> nil) and
    not ((BatchMove.Reader <> nil) and (TObject(BatchMove.Reader) is TFDBatchMoveDataSetDriver) and
         (BatchMove.Writer <> nil) and (TObject(BatchMove.Writer) is TFDBatchMoveDataSetDriver) and
         (TFDBatchMoveDataSetDriver(BatchMove.Reader).DataSet = TFDBatchMoveDataSetDriver(BatchMove.Writer).DataSet));
  if not Result and ARaise then begin
    if Self is TFDBatchMoveDataSetReader then
      iErr := er_FD_DPNoSrcDS
    else
      iErr := er_FD_DPNoDestDS;
    FDException(BatchMove, [S_FD_LComp, S_FD_LComp_PDM], iErr, []);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetDriver.Open(AStartTx: Boolean);
begin
  FActive := DataSet.Active;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetDriver.Close(AStopTxError: Boolean);
begin
  DataSet.Active := FActive;
  DataSet.EnableControls;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetDriver.Refresh;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetDriver.AbortJob;
begin
  if (DataSet <> nil) and (DataSet is TFDAdaptedDataSet) then
    TFDAdaptedDataSet(DataSet).AbortJob(True);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.AddAutoFields: Boolean;
begin
  // nothing
  Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetDriver.DeleteAutoFields;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetCatalog: String;
begin
  if (DataSet is TFDAdaptedDataSet) and
     (TFDAdaptedDataSet(DataSet).PointedConnection <> nil) and
     (TFDAdaptedDataSet(DataSet).PointedConnection.ConnectionIntf <> nil) then
    Result := TFDAdaptedDataSet(DataSet).PointedConnection.ConnectionIntf.CurrentCatalog
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetIsUnicode: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetIsOpen: Boolean;
begin
  Result := DataSet.Active;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetFieldCount: Integer;
begin
  Result := DataSet.FieldCount;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetFieldName(AIndex: Integer): String;
begin
  Result := DataSet.Fields[AIndex].FieldName;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetFieldIndex(const AName: String; ACheck: Boolean): Integer;
var
  oField: TField;
begin
  if ACheck then
    Result := DataSet.FieldByName(AName).Index
  else begin
    oField := DataSet.FindField(AName);
    if oField <> nil then
      Result := oField.Index
    else
      Result := -1;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetDriver.GetFieldInfo(AIndex: Integer; var AType: TFDDataType;
  var ASize: LongWord; var APrec, AScale: Integer; var AInKey, AIsIdentity: Boolean): TObject;
var
  eAttrs: TFDDataAttributes;
  oField: TField;
begin
  AType := dtUnknown;
  ASize := 0;
  APrec := 0;
  AScale := 0;
  eAttrs := [];
  oField := DataSet.Fields[AIndex];
  TFDFormatOptions.FieldDef2ColumnDef(oField, AType, ASize, APrec, AScale, eAttrs);
  AInKey := pfInKey in oField.ProviderFlags;
  AIsIdentity := (oField is TFDAutoIncField) or
    (DataSet is TFDDataSet) and (caAutoInc in TFDDataSet(DataSet).GetFieldColumn(oField).ActualAttributes);
  Result := oField;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetDriver.GetTableDefs(AFieldDefs: TFieldDefs; AIndexDefs: TIndexDefs);
var
  oIndexDefs: TIndexDefs;
  sKeyFields: String;
  oInd: TIndexDef;
begin
  if not DataSet.FieldDefs.Updated then
    DataSet.FieldDefs.Update;
  AFieldDefs.Assign(DataSet.FieldDefs);

  if Provider = nil then begin
    oIndexDefs := nil;
    sKeyFields := '';
  end
  else begin
    oIndexDefs := Provider.PSGetIndexDefs();
    sKeyFields := Provider.PSGetKeyFields();
  end;
  if oIndexDefs = nil then
    AIndexDefs.Clear
  else
    AIndexDefs.Assign(oIndexDefs);

  if sKeyFields <> '' then begin
    oInd := AIndexDefs.GetIndexForFields(sKeyFields, False);
    if oInd <> nil then begin
      if not (ixPrimary in oInd.Options) then
        oInd.Options := oInd.Options + [ixPrimary];
    end
    else
      AIndexDefs.Add('', sKeyFields, [ixPrimary]);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveDataSetReader                                                     }
{-------------------------------------------------------------------------------}
constructor TFDBatchMoveDataSetReader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRewind := True;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetReader.GetSourceTableName: String;
begin
  if Provider <> nil then
    Result := Provider.PSGetTableName
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetReader.Open(AStartTx: Boolean);
var
  oFO: TFDFetchOptions;
begin
  inherited Open(AStartTx);
  DataSet.DisableControls;

  if Optimise and
     (DataSet is TFDAdaptedDataSet) and not IsMemTable and FDDataSet.ClientCursor then begin
    oFO := FDDataSet.FetchOptions;
    oFO.Items := [fiBlobs, fiDetails];
    oFO.Mode := fmOnDemand;
    if oFO.RowsetSize < BatchMove.CommitCount then
      oFO.RowsetSize := BatchMove.CommitCount;
    oFO.Cache := [];
    oFO.Unidirectional := True;
  end;

  if Rewind and DataSet.Active and not DataSet.Bof then
    try
      DataSet.First;
    except
      if not IsMemTable then begin
        DataSet.Close;
        DataSet.Open;
      end;
    end
  else
    DataSet.Active := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetReader.Refresh;
begin
  if not IsMemTable then
    DataSet.Close;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetReader.ReadHeader;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetReader.Eof: Boolean;
begin
  Result := DataSet.Eof;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetReader.ReadRecord;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetReader.NextRecord;
begin
  try
    DataSet.Next;
  except
    DataSet.UpdateCursorPos;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetReader.GuessFormat(AAnalyze: TFDBatchMoveAnalyze);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{ TFDBatchMoveDataSetWriter                                                     }
{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.Open(AStartTx: Boolean);
begin
  inherited Open(AStartTx);
  FDisconnected := False;
  FConnection := nil;
  if DataSet is TFDAdaptedDataSet then begin
    FConnection := FDDataSet.PointedConnection;
    if FConnection <> nil then begin
      FDisconnected := not FConnection.Connected;
      FConnection.Connected := True;
    end;
  end;

  DataSet.DisableControls;
  if (poCreateDest in BatchMove.Options) and
     (DataSet is TFDDataSet) and not FDDataSet.Exists then
    CreateTable;

  if DataSet is TFDAdaptedDataSet then begin
    if Optimise then begin
      FDDataSet.FetchOptions.Items := [fiMeta];
      FDDataSet.FetchOptions.Mode := fmManual;
      FDDataSet.UpdateOptions.FastUpdates := True;
    end;
    if (FDDataSet.Command <> nil) and (FDDataSet.Command.CommandText.Count > 0) then
      FDDataSet.Online;
  end;

  if AStartTx and (BatchMove.CommitCount > 0) then
    StartTransaction;
  FActive := DataSet.Active;
  DataSet.Active := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.CreateTable;
begin
  if (DataSet is TFDDataSet) and not FDDataSet.Exists then begin
    FDDataSet.Active := False;
    BatchMove.Reader.GetTableDefs(FDDataSet.FieldDefs, FDDataSet.IndexDefs);
    FDDataSet.CreateDataSet;
  end
  else
    FDCapabilityNotSupported(BatchMove, [S_FD_LComp, S_FD_LComp_PDM]);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.Close(AStopTxError: Boolean);
begin
  inherited Close(AStopTxError);
  if AStopTxError then
    RollbackTransaction
  else
    CommitTransaction;
  if (FConnection <> nil) and FDisconnected then
    FConnection.Connected := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.Refresh;
begin
  inherited Refresh;
  if not IsMemTable then
    if DataSet is TFDAdaptedDataSet then
      FDDataSet.Disconnect
    else
      DataSet.Close;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.StartTransaction;
begin
  if (Provider <> nil) and not Provider.PSInTransaction then
    Provider.PSStartTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.RollbackTransaction;
begin
  if (Provider <> nil) and Provider.PSInTransaction then
    Provider.PSEndTransaction(False);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.CommitTransaction;
begin
  if (Provider <> nil) and Provider.PSInTransaction then
    Provider.PSEndTransaction(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.Erase(ANoUndo: Boolean);
begin
  if Direct and (DataSet is TFDAdaptedDataSet) then begin
    FDDataSet.ServerDeleteAll(ANoUndo);
    FDDataSet.Refresh;
  end
  else begin
    DataSet.First;
    while not DataSet.IsEmpty do
      DataSet.Delete;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBatchMoveDataSetWriter.WriteHeader;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetWriter.FindRecord: Boolean;
begin
  if Direct and (DataSet is TFDAdaptedDataSet) then begin
    FDDataSet.ServerSetKey;
    BatchMove.Mappings.Move(True);
    Result := FDDataSet.ServerGotoKey;
  end
  else
    Result := DataSet.Locate(BatchMove.Mappings.KeyFields, BatchMove.Mappings.KeyValues, []);
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetWriter.InsertRecord: Integer;
begin
  if Direct and (DataSet is TFDAdaptedDataSet) then begin
    FDDataSet.ServerAppend;
    BatchMove.Mappings.Move(False);
    FDDataSet.ServerPerform;
  end
  else begin
    DataSet.Append;
    try
      BatchMove.Mappings.Move(False);
      DataSet.Post;
    except
      DataSet.Cancel;
      raise;
    end;
  end;
  Result := 1;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetWriter.UpdateRecord: Integer;
begin
  if Direct and (DataSet is TFDAdaptedDataSet) then begin
    FDDataSet.ServerEdit;
    BatchMove.Mappings.Move(False);
    FDDataSet.ServerPerform;
  end
  else begin
    DataSet.Edit;
    try
      BatchMove.Mappings.Move(False);
      DataSet.Post;
    except
      DataSet.Cancel;
      raise;
    end;
  end;
  Result := 1;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetWriter.DeleteRecord: Integer;
begin
  if Direct and (DataSet is TFDAdaptedDataSet) then begin
    FDDataSet.ServerDelete;
    BatchMove.Mappings.Move(False);
    FDDataSet.ServerPerform;
  end
  else
    DataSet.Delete;
  Result := 1;
end;

{-------------------------------------------------------------------------------}
function TFDBatchMoveDataSetWriter.FlushRecords: Integer;
begin
  // nothing
  Result := 0;
end;

end.
