{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXCDSReaders;

interface

uses
  System.Classes, System.SysUtils, Datasnap.DBClient, Data.DB,
  Data.DBXCommon, Data.DBXPlatform, Data.DBXCommonTable, Data.DBXDBReaders;

type
  TDBXClientDataSetTable = class;

  ///<summary>
  ///  This is not used directly by applications.
  ///</summary>
  TDBXCDSOriginalRow = class(TDBXDBTable)
  private
    FAtEnd: Boolean;
    FClonedTable: TDBXClientDataSetTable;
    [Weak]FClientTable: TDBXClientDataSetTable;
  protected
    function GetWritableValue(const Ordinal: TInt32): TDBXWritableValue; override;
  public
    constructor Create(ClientTable: TDBXClientDataSetTable);
    function GetOrdinal(const ColumnName: string): Integer; override;
    function First: Boolean; override;
    function Next: Boolean; override;
    function InBounds: Boolean; override;
    function GetColumns: TDBXValueTypeArray; override;
  end;

  ///<summary>
  ///  This is not used directly by applications.
  ///</summary>
  TDBXClientDataSetTable = class(TDBXDataSetTable)
  private
    FOriginal: TDBXCDSOriginalRow;
    [Weak]FClientDataset: TClientDataSet;
  protected
    constructor Create(const CollectionName: string;
      TableColumns: TDBXValueTypeArray; Table: TClientDataSet;
      OwnsTable: Boolean = true); overload;
    procedure SkipOriginalRow; override;
    function GetDeletedRows: TDBXTable; override;
    function GetInsertedRows: TDBXTable; override;
    function GetUpdatedRows: TDBXTable; override;
    function GetOriginalRow: TDBXTableRow; override;
  public
    constructor Create; overload;
    constructor Create(ClientDataSet: TClientDataSet; OwnsTable: Boolean); overload;
    destructor Destroy; override;
    procedure AcceptChanges; override;
    procedure Clear; override;
    function CreateTableView(const OrderByColumnName: string): TDBXTable; override;
    function FindStringKey(const Ordinal: Integer; const Value: string): Boolean; override;
    procedure SetColumns(const Columns: TDBXValueTypeArray); override;
  end;

  ///<summary>
  ///  <c>TDBXReader</c> implementation for <c>TDataSet</c> object.
  ///</summary>
  TDBXClientDataSetReader = class(TDBXDataSetReader)
  public
    /// <summary>
    /// Creates a <c>TDBXReader</c> for a <c>TDataSet</c> instance.  If
    /// <c>InstanceOwner</c> is true, the <c>TDataSet</c> instance will be
    /// freed when this <c>TDBXDataSetReader</c> instance is freed.
    /// </summary>
    constructor Create(Params: TDataset; InstanceOwner: Boolean = true); override;
    /// <summary>
    /// Copies the contents of <c>Reader</c> into the <c>TDataSet</c>
    /// instance.
    /// </summary>
    /// <returns>
    /// The same <c>DataSet</c> instance that was passed into this method.
    /// </returns>
    class procedure CopyReaderToClientDataSet(Reader: TDBXReader;
      Dataset: TClientDataSet); static;
    class function ToClientDataSet(AOwner: TComponent; Reader: TDBXReader;
      AOwnsInstance: Boolean): TClientDataSet; static;
  end;

implementation

uses
  Data.DBXCommonResStrs;

{ TDBXClientDataSetReader }

constructor TDBXClientDataSetReader.Create(Params: TDataset;
  InstanceOwner: Boolean);
begin
  if Params is TClientDataSet then
    inherited Create(TDBXClientDataSetTable.Create(
      Params.Name, nil, TClientDataSet(Params), InstanceOwner))
  else
    inherited Create(Params, InstanceOwner);
end;

class function TDBXClientDataSetReader.ToClientDataSet(AOwner: TComponent; Reader: TDBXReader; AOwnsInstance: Boolean): TClientDataSet;
begin
  Result := TClientDataSet.Create(AOwner);
  CopyReaderToClientDataSet(Reader, Result);
  if AOwnsInstance then
    Reader.Free;
end;

class procedure TDBXClientDataSetReader.CopyReaderToClientDataSet(
  Reader: TDBXReader; DataSet: TClientDataSet);
var
  Ordinal:      Integer;
  Table:        TDBXTable;
  ValueTypes:   TDBXValueTypeArray;
  ColumnCount:  Integer;
begin
  ColumnCount := Reader.ColumnCount;
  SetLength(ValueTypes, Reader.ColumnCount);
  for Ordinal := 0 to ColumnCount - 1 do
  begin
    ValueTypes[Ordinal] := Reader.ValueType[Ordinal].WritableClone;
  end;
  Table := TDBXClientDataSetTable.Create('', nil, DataSet, False);
  Table.Columns := ValueTypes;

  try
    while Reader.Next do
    begin
      Table.Insert;
      for Ordinal := 0 to ColumnCount - 1 do
        Table.Value[Ordinal].SetValue(Reader.Value[Ordinal]);
      Table.Post;
    end;
  finally
    Table.Free;
  end;
end;

{ TDBXCDSOriginalRow }

constructor TDBXCDSOriginalRow.Create(ClientTable: TDBXClientDataSetTable);
var
  ClientDataSet: TClientDataSet;
begin
  ClientDataSet := TClientDataSet.Create(nil);
  ClientDataSet.CloneCursor(ClientTable.FClientDataSet, True);
  ClientDataSet.StatusFilter := [usModified];
  FClonedTable := TDBXClientDataSetTable.Create(ClientTable.CollectionName, ClientTable.CopyColumns, ClientDataSet);
  FClientTable := ClientTable;
  inherited Create(nil, TDBXDataSetRow.Create(ClientDataSet));
end;

function TDBXCDSOriginalRow.First: Boolean;
begin
  FAtEnd := false;
  Result := true;
end;

function TDBXCDSOriginalRow.GetColumns: TDBXValueTypeArray;
begin
  Result := FClientTable.GetColumns;
end;

function TDBXCDSOriginalRow.GetOrdinal(const ColumnName: string): Integer;
begin
  Result := FClientTable.GetOrdinal(ColumnName);
end;

function TDBXCDSOriginalRow.GetWritableValue(
  const Ordinal: TInt32): TDBXWritableValue;
var
  TargetRecNo: Integer;
begin
  if FClientTable.Table.UpdateStatus in [usDeleted, usUnmodified] then
    Result := FClientTable.GetWritableValue(Ordinal)
  else if FClientTable.Table.UpdateStatus = usModified then
  begin
    if usModified in FClientTable.FClientDataset.StatusFilter then
      TargetRecNo := FClientTable.Table.RecNo - 1
    else
      TargetRecNo := (FClientTable.Table.RecNo * 2) - 1;
    if FClonedTable.Table.RecNo <> TargetRecNo then
    begin
      FClonedTable.Table.MoveBy(TargetRecNo - FClonedTable.Table.RecNo);
      FClonedTable.RowNavigated;
    end;
    Result := FClonedTable.GetWritableValue(Ordinal);
  end
  else
    Result := nil;
end;

function TDBXCDSOriginalRow.InBounds: Boolean;
begin
  Result := not FAtEnd;
end;

function TDBXCDSOriginalRow.Next: Boolean;
begin
  if FAtEnd then
    Result := false
  else
  begin
    FAtEnd := true;
    Result := true;
  end;
end;

{ TDBXClientDataSetTable }

constructor TDBXClientDataSetTable.Create;
begin
  Create('', nil, TClientDataSet.Create(nil), true);
end;

constructor TDBXClientDataSetTable.Create(ClientDataSet: TClientDataSet;
  OwnsTable: Boolean);
begin
  Create('', nil, ClientDataSet, OwnsTable);
end;

procedure TDBXClientDataSetTable.AcceptChanges;
begin
  FailIfRowIsNew();
  FClientDataSet.MergeChangeLog;
end;

procedure TDBXClientDataSetTable.Clear;
begin
  if (FClientDataSet.State in dsEditModes) then
    FClientDataSet.Post;
  if      not (usModified in FClientDataSet.StatusFilter)
      and not (usDeleted in FClientDataSet.StatusFilter)
      and not (usInserted in FClientDataSet.StatusFilter) then
    FClientDataSet.EmptyDataSet;
end;

function TDBXClientDataSetTable.CreateTableView(const OrderByColumnName: string): TDBXTable;
var
  View: TClientDataSet;
begin
  View := TClientDataSet.Create(nil);
  View.CloneCursor(FClientDataSet,True);
  if not OrderByColumnName.IsEmpty then
    View.IndexFieldNames := OrderByColumnName;
  Result := TDBXClientDataSetTable.Create(CollectionName, CopyColumns, View);
end;

destructor TDBXClientDataSetTable.Destroy;
begin
  FreeAndNil(FOriginal);
  inherited;
end;

function TDBXClientDataSetTable.FindStringKey(const Ordinal: Integer; const Value: string): Boolean;
var
  ColumnName: string;
begin
  ColumnName := FClientDataSet.FieldDefs[Ordinal].Name;
  if FClientDataSet.IndexFieldNames <> ColumnName then
    FClientDataSet.IndexFieldNames := ColumnName;
  Result := FClientDataSet.FindKey([Value]);
end;

constructor TDBXClientDataSetTable.Create(const CollectionName: string;
  TableColumns: TDBXValueTypeArray; Table: TClientDataSet; OwnsTable: Boolean);
begin
  inherited Create(CollectionName, Table, OwnsTable, False);
  Columns := TableColumns;
  FClientDataset := Table;
end;

procedure TDBXClientDataSetTable.SkipOriginalRow;
begin
  if (usModified in FClientDataSet.StatusFilter) and (FClientDataSet.UpdateStatus = usUnmodified) then
    FClientDataSet.Next;
end;

procedure TDBXClientDataSetTable.SetColumns(const Columns: TDBXValueTypeArray);
var
  Ordinal: Integer;
begin
  FreeValueTypes;
  ValueTypes := Columns;
  if FClientDataSet <> nil then
  begin
    FClientDataSet.Close;
    for Ordinal := Low(Columns) to High(Columns) do
    begin
      if Ordinal >= FClientDataSet.FieldDefs.Count then
        CopyValueTypeProperties(FClientDataSet.FieldDefs.AddFieldDef, Columns[Ordinal], Ordinal)
      else if not (FClientDataSet.FieldDefs[Ordinal].Name = Columns[Ordinal].Name) then
        raise TDBXError.Create(SMustKeepOriginalColumnOrder);
    end;
    FClientDataSet.CreateDataSet;

  end;
  CreateValues;
end;

function TDBXClientDataSetTable.GetDeletedRows: TDBXTable;
var
  View: TClientDataSet;
begin
  View := TClientDataSet.Create(nil);
  View.CloneCursor(FClientDataSet,True);
  View.StatusFilter := [usDeleted];
  View.Filtered := True;
  Result := TDBXClientDataSetTable.Create(CollectionName, CopyColumns, View);
  Result.First;
end;

function TDBXClientDataSetTable.GetInsertedRows: TDBXTable;
var
  View: TClientDataSet;
begin
  View := TClientDataSet.Create(nil);
  View.CloneCursor(FClientDataSet,True);
  View.StatusFilter := [usInserted];
  View.Filtered := True;
  Result := TDBXClientDataSetTable.Create(CollectionName, CopyColumns, View);
  Result.First;
end;

function TDBXClientDataSetTable.GetUpdatedRows: TDBXTable;
var
  View: TClientDataSet;
begin
  View := TClientDataSet.Create(nil);
  View.CloneCursor(FClientDataSet, False, False);
  View.StatusFilter := [usModified];
  View.Filtered := True;
  Result := TDBXClientDataSetTable.Create(CollectionName, CopyColumns, View);
  Result.First;
end;

function TDBXClientDataSetTable.GetOriginalRow: TDBXTableRow;
begin
  if FOriginal = nil then
    FOriginal := TDBXCDSOriginalRow.Create(self);
  if FClientDataSet.UpdateStatus = usInserted then
    Result := nil
  else
    Result := FOriginal;
end;

end.
