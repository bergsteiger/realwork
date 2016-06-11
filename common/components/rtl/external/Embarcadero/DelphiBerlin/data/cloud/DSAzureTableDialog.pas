{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzureTableDialog;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, System.JSON, Vcl.Dialogs, DSAzure, Vcl.ExtCtrls, Vcl.Forms,
  System.Generics.Collections, Vcl.Graphics, Vcl.Grids, Vcl.ImgList, Vcl.Menus, Vcl.StdCtrls, System.SysUtils,
  Vcl.ValEdit, Xml.XMLIntf;

type
  ///<summary> Possible data types for a table 'column' (Entity property)
  ///</summary>
  TPropertyDataType =
      (azdtBinary, azdtBoolean, azdtDateTime, azdtDouble, azdtGuid, azdtInt32, azdtInt64, azdtString, azdtUnknown);

  TRowType = (azrUnknown, azrLoading, azrRow, azrTruncated);

  /// <summary>
  ///  Continuation token which may exist if results of a entity population are partial.
  /// </summary>
  /// <remarks>
  ///  An entity population will be partial if there are more than 1000 results or if there is a timeout.
  /// </remarks>
  TAzureRowContinuationToken = record
    IsValid: Boolean; //True if the population result was partial and this token should be used
    NextRowKey: String;
    NextPartitionKey: String;
  end;

  ///<summary>
  ///  Representing a single cell (Row/Column) of a table
  ///</summary>
  TAzureTableColumn = class
  protected
    FDataType: TPropertyDataType;
  public
    Name: String;
    Value: String;
    constructor Create; Virtual;
    /// <summary> Creates a clone of the instance </summary>
    function Copy: TAzureTableColumn;
    procedure SetDataType(Value: String);
    property DataType: TPropertyDataType read FDataType write FDataType;
  end;

  TAzureRow = class
  protected
    FRowType: TRowType;
  public
    Constructor Create(RowType: TRowType = azrRow); Virtual;
    property RowType: TRowType read FRowType;
  end;

  ///<summary>
  ///  Table Entity (Row) specific information.
  ///</summary>
  TAzureTableRow = class(TAzureRow)
  protected
    //NOTE: Timestamp is ignored, as suggested here: http://msdn.microsoft.com/en-us/library/dd179338.aspx
    FRowKey: TAzureTableColumn;
    FPartitionKey: TAzureTableColumn;
    FColumns: TDictionary<String,TAzureTableColumn>;
  public
    constructor Create; Reintroduce;
    destructor Destroy; Override;
    function GetID: String; Virtual;
    procedure SetColumn(Key: String; Value: TAzureTableColumn);
    function ClearColumn(Key: String; InstanceOwner: Boolean = True): TAzureTableColumn;
    procedure ClearColumns(InstanceOwner: Boolean = True);
    function GetColumn(Key: String; IgnoreCase: Boolean = False): TAzureTableColumn;
    property RowKey: TAzureTableColumn read FRowKey;
    property PartitionKey: TAzureTableColumn read FPartitionKey;
    property Columns: TDictionary<String,TAzureTableColumn> read FColumns write FColumns;
  end;

  ///<summary>
  ///  Wrapper for a Table Row, which allows for modification which can either be committed or rolled back.
  ///</summary>
  TAzureTemporaryTableRow = class(TAzureTableRow)
  protected
    FWrapped: TAzureTableRow;
    FNewRow: Boolean;
  public
    constructor Create(RowKey, PartitionKey: String); Reintroduce; Overload;
    constructor Create(Wrapped: TAzureTableRow); Reintroduce; Overload;
    destructor Destroy; Override;

    function GetID: String; Override;

    /// <summary> This commits the changes into the wrapped object, but does not push these changes
    ///    to the Azure server. That is the job of whoever calls this commit.
    /// </summary>
    function Commit: TAzureTableRow;
    property Wrapped: TAzureTableRow read FWrapped;
    property IsNewRow: Boolean read FNewRow;
  end;

  /// <summary> Dialog for managing an Azure table, with the ability to add/remove and edit rows and columns.
  /// </summary>
  TTAzureTableDialog = class(TForm)
    CloseButton: TButton;
    commitButton: TButton;
    outerpanel: TPanel;
    leftCol: TPanel;
    panSplit: TSplitter;
    rightCol: TPanel;
    ColumnTable: TValueListEditor;
    EntityLabel: TLabel;
    RowList: TListBox;
    Panel1: TPanel;
    RowsLabel: TLabel;
    ImageList1: TImageList;
    filterField: TButtonedEdit;
    ImportRowsDialog: TOpenDialog;
    procedure FormDestroy(Sender: TObject);
    procedure commitButtonClick(Sender: TObject);
    procedure RowListClick(Sender: TObject);
    procedure filterFieldRightButtonClick(Sender: TObject);
    procedure filterFieldKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    FConnectionInfo: TAzureConnectionString;
    FTableName: String;
    FCurrentEntity: TAzureTemporaryTableRow;
    FCurrentColumn: TAzureTableColumn;
    FAddingRow: Boolean;
    FDeleteColumnItem: TMenuItem;
    FAdvancedFilterPrefix: String;

    function ByteContent(DataStream: TStream): TArray<Byte>;

    procedure InitializeRows;
    procedure ClearRows;
    procedure ClearColumnTable;
    procedure AddRow(ColumnEntry: TAzureTableColumn);

    procedure FilterRows;

    procedure RowsPopulated(Rows: TList<TAzureTableRow>; ContinuationToken: TAzureRowContinuationToken);
    procedure RowCreatedOrUpdated(Row: TAzureTableRow; IsNew: Boolean);
    procedure BatchRowsCreated(Success: Boolean);
    procedure RowDeleted(Row: TAzureTableRow; Success: Boolean);

    function CreateRowListPopupMenu: TPopupMenu;
    procedure UpdateRowListPopupMenu(Sender: TObject);
    procedure HandleRowKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    function CreateColumnsPopupMenu: TPopupMenu;
    procedure UpdateColumnsPopupMenu(Sender: TObject);
    procedure CreateDTMenuItem(Menu: TPopupMenu; Parent: TMenuItem; DataTypeName: String);
    procedure HandleColumnDblClick(Sender: TObject);

    function GetSelectedRow: TAzureTableRow;
    function GetLastRow: TAzureTableRow;

    procedure EnableRowSelection(Enabled: Boolean = True);
    procedure ImportRows(RowArray: TJSONArray);

    //Context Menu actions
    procedure SetCurrentEntity(Row: TAzureTemporaryTableRow = nil);
    procedure AddRowAction(Sender: TObject);
    procedure DeleteRowAction(Sender: TObject);
    procedure ImportRowsAction(Sender: TObject);
    procedure RefreshRowsAction(Sender: TObject);

    procedure EditColumnAction(Sender: TObject);
    procedure AddColumnAction(Sender: TObject);
    procedure DeleteColumnAction(Sender: TObject);
    procedure SetDataTypeAction(Sender: TObject);

    procedure SetColumnValue(OriginalName: String; Column: TAzureTableColumn);
  public
    constructor Create(AOwner: TComponent; ConnectionInfo: TAzureConnectionString); reintroduce;
    procedure SetTable(TableName: String);
    property AdvancedFilterPrefix: String read FAdvancedFilterPrefix write FAdvancedFilterPrefix;
  end;

  /// <summary> Returns the string representation of the given data type </summary>
  function GetDataType(DataType: TPropertyDataType): String; Overload;

  /// <summary> Returns the data type for the given string representation. </summary>
  function GetDataType(DataType: String): TPropertyDataType; Overload;

  /// <summary> Returns true if the given value is a valid format to be transformed into the specified data type
  /// </summary>
  function ValidateValueForDataType(Value: String; DataType: TPropertyDataType): Boolean;

  /// <summary> Helper function for populating a row object from the 'content' node of an Azure xml file. </summary>
  function GetRowFromConentNode(ContentNode: IXMLNode): TAzureTableRow;

const
  ADD_ROW = 'AddRow';
  DELETE_ROW = 'DeleteRow';
  IMPORT_ROWS = 'ImportRows';
  REFRESH_ROWS = 'RefreshRows';
  EDIT_COLUMN = 'EditColumn';
  ADD_COLUMN = 'AddColumn';
  DELETE_COLUMN = 'DeleteColumn';
  DATA_TYPE_ITEM = 'DataType';
  XML_ROWKEY = 'RowKey';
  XML_PARTITION = 'PartitionKey';
  XML_TIMESTAMP = 'Timestamp';

  DT_XML_PREFIX = 'Edm.';
  DT_BINARY = 'Binary';
  DT_BOOLEAN = 'Boolean';
  DT_DATETIME = 'DateTime';
  DT_DOUBLE = 'Double';
  DT_GUID = 'Guid';
  DT_INT32 = 'Int32';
  DT_INT64 = 'Int64';
  DT_STRING = 'String';

implementation

{$R *.dfm}

uses
  Winapi.ActiveX, AzureUI, Data.DBXClientResStrs, DSAzureTable, DSAzureTableRowDialog,
  System.StrUtils, System.UITypes, Winapi.Windows, Xml.XMLDoc;

type
  TRowPopulatorCallback = procedure(Rows: TList<TAzureTableRow>; ContinuationToken: TAzureRowContinuationToken) of object;
  TBatchRowCreatedCallback = procedure(Success: Boolean) of object;
  TRowCreatedCallback = procedure(Row: TAzureTableRow; IsNew: Boolean) of object;
  TRowDeletedCallback = procedure(Row: TAzureTableRow; Success: Boolean) of object;

  /// <summary> Thread for populating Table rows (Entities) </summary>
  TRowPopulator = class(TThread)
  protected
    FTableName: String;
    FFilter: String;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TRowPopulatorCallback;
    FTableService: TAzureTableService;
    FAdvancedFilterPrefix: String;

    function BuildFilterString: String;
  public
    constructor Create(TableName: String;
                       ConnectionInfo: TAzureConnectionString;
                       Callback: TRowPopulatorCallback;
                       AdvancedFilterPrefix: String; Filter: String = ''); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  /// <summary> Thread for creating or updating a given row (Entity) </summary>
  TRowCreator = class(TThread)
  protected
    FTableName: String;
    FRow: TAzureTemporaryTableRow;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TRowCreatedCallback;
    FTableService: TAzureTableService;
  public
    constructor Create(TableName: String; Row: TAzureTemporaryTableRow;
                       ConnectionInfo: TAzureConnectionString;
                       Callback: TRowCreatedCallback); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  /// <summary> Thread for creating (not updating) a batch of Rows (Entities) </summary>
  TBatchRowCreator = class(TThread)
  protected
    FTableName: String;
    FRows: TJSONArray;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TBatchRowCreatedCallback;
    FTableService: TAzureTableService;

    function CreateRow(Row: TJSONObject): Boolean;
  public
    constructor Create(TableName: String; Rows: TJSONArray;
                       ConnectionInfo: TAzureConnectionString;
                       Callback: TBatchRowCreatedCallback); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  /// <summary> Thread for deleting a row (Entity) </summary>
  TRowDeletor = class(TThread)
  protected
    FTableName: String;
    FRow: TAzureTableRow;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TRowDeletedCallback;
    FTableService: TAzureTableService;
  public
    constructor Create(TableName: String; Row: TAzureTableRow;
                       ConnectionInfo: TAzureConnectionString;
                       Callback: TRowDeletedCallback); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

{ TTAzureTableDialog }
function GetDataType(DataType: String): TPropertyDataType;
begin
  Result := azdtUnknown;
  if AnsiStartsStr(DT_XML_PREFIX, DataType) then
    DataType := Copy(DataType, Length(DT_XML_PREFIX) + 1);

  if DataType = DT_BINARY then
    Result := azdtBinary
  else if DataType = DT_BOOLEAN then
    Result := azdtBoolean
  else if DataType = DT_DATETIME then
    Result := azdtDateTime
  else if DataType = DT_DOUBLE then
    Result := azdtDouble
  else if DataType = DT_GUID then
    Result := azdtGuid
  else if DataType = DT_INT32 then
    Result := azdtInt32
  else if DataType = DT_INT64 then
    Result := azdtInt64
  else if DataType = DT_STRING then
    Result := azdtString;
end;

function GetDataType(DataType: TPropertyDataType): String;
begin
  case DataType of
    azdtBinary: Result:= DT_XML_PREFIX + DT_BINARY;
    azdtBoolean: Result:= DT_XML_PREFIX + DT_BOOLEAN;
    azdtDateTime: Result:= DT_XML_PREFIX + DT_DATETIME;
    azdtDouble: Result:= DT_XML_PREFIX + DT_DOUBLE;
    azdtGuid: Result:= DT_XML_PREFIX + DT_GUID;
    azdtInt32: Result:= DT_XML_PREFIX + DT_INT32;
    azdtInt64: Result:= DT_XML_PREFIX + DT_INT64;
    azdtString: Result:= DT_XML_PREFIX + DT_STRING;
    else
      Result:= EmptyStr;
  end;
end;

function ValidateValueForDataType(Value: String; DataType: TPropertyDataType): Boolean;
begin
  Result := False;

  if DataType = azdtUnknown then
    Exit(False);

  if DataType = azdtString then
    Exit(True);

  if DataType = azdtGuid then
    Exit(True);

  if DataType = azdtBoolean then
    Exit((LowerCase(Value) = 'true') or (LowerCase(Value) = 'false'));

  if (DataType = azdtInt32) or (DataType = azdtInt64) then
  begin
    try
      StrToInt(Value);
      Exit(True);
    except
      Exit(False);
    end;
  end;

  if (DataType = azdtDouble) then
  begin
    try
      StrToFloat(Value);
      Exit(True);
    except
      Exit(False);
    end;
  end;

                                                                  
  if (DataType = azdtDateTime) or (DataType = azdtBinary) then
    Result := True;
end;

function GetRowFromConentNode(ContentNode: IXMLNode): TAzureTableRow;
var
  PropertiesNode: IXMLNode;
  PropertyNode: IXMLNode;
  PropName: String;
  Aux: Integer;
  Row: TAzureTableRow;
  Column: TAzureTableColumn;
begin
  if (ContentNode = nil) or (ContentNode.NodeName <> NODE_TABLE_CONTENT) then
    Exit(nil);

  Result := nil;

  if (ContentNode.HasChildNodes) then
  begin
    PropertiesNode := GetFirstMatchingChildNode(ContentNode, NODE_PROPERTIES);

    if (PropertiesNode <> nil) and (PropertiesNode.HasChildNodes) then
    begin
      PropertyNode := PropertiesNode.ChildNodes.First;
      Row := TAzureTableRow.Create;

      while PropertyNode <> nil do
      begin
        try
          PropName := PropertyNode.NodeName;
          Aux := AnsiPos(':', PropName);
          if Aux > -1 then
            PropName := Copy(PropName, Aux + 1);

          if PropName = XML_PARTITION then
            Row.PartitionKey.Value := PropertyNode.Text
          else if PropName = XML_ROWKEY then
            Row.RowKey.Value := PropertyNode.Text
          else
          begin
            Column := TAzureTableColumn.Create;
            Column.Name := PropName;
            Column.Value := PropertyNode.Text;

            if PropertyNode.HasAttribute('m:type') then
              Column.SetDataType(PropertyNode.Attributes['m:type']);

            Row.Columns.Add(PropName, Column);
          end;
        except
          break;
        end;
        PropertyNode := PropertyNode.NextSibling;
      end;

      Result := Row;
    end;
  end;
end;

procedure TTAzureTableDialog.SetCurrentEntity(Row: TAzureTemporaryTableRow);
var
  Key: String;
  Value: TAzureTableColumn;
begin
  if (FCurrentEntity <> nil) and commitButton.Enabled then
  begin
    if not (MessageDlg(SConfirmRowChangeLoss, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      FreeAndNil(Row);
      Exit;
    end;
  end;

  FreeAndNil(FCurrentEntity);

  FCurrentEntity := Row;

  ColumnTable.Enabled := (Row <> nil);
  commitButton.Enabled := (Row <> nil) and Row.IsNewRow;

  if Row = nil then
  begin
    EntityLabel.Caption := EmptyStr;
    ClearColumnTable;
  end
  else
  begin
    EntityLabel.Caption := Format(SEntityTitle, [FCurrentEntity.GetID]);

    ColumnTable.Strings.BeginUpdate;
    try
      ClearColumnTable;
      ColumnTable.InsertRow(XML_ROWKEY, Row.RowKey.Value, True);
      ColumnTable.InsertRow(XML_PARTITION, Row.PartitionKey.Value, True);

      for Key in Row.Columns.Keys do
      begin
        //hide timestamp, as the online documentation says to do
        if Key <> XML_TIMESTAMP then
        begin
          Value := Row.Columns.Items[Key];
          ColumnTable.InsertRow(Key, Value.Value, True);
        end;
      end;
    finally
      ColumnTable.Strings.EndUpdate;
    end;
  end;
end;

procedure TTAzureTableDialog.SetDataTypeAction(Sender: TObject);
var
  DataType: TPropertyDataType;
begin
  if (FCurrentColumn <> nil) and (Sender is TMenuItem) then
  begin
    DataType := GetDataType(TMenuItem(Sender).Name);

    if (DataType <> FCurrentColumn.DataType) then
    begin
      if ValidateValueForDataType(FCurrentColumn.Value, DataType) then
      begin
        FCurrentColumn.DataType := DataType;
        commitButton.Enabled := True;
      end
      else
        MessageDlg(Format(SInvalidDataType, [TMenuItem(Sender).Name, FCurrentColumn.Value]),
                   mtError, [mbOK], 0);
    end;
  end;
end;

procedure TTAzureTableDialog.SetColumnValue(OriginalName: String; Column: TAzureTableColumn);
var
  RowIndex: Integer;
begin
  if (FCurrentEntity = nil) or (Column = nil) then
    Exit;

  if ColumnTable.FindRow(OriginalName, RowIndex) then
  begin
    ColumnTable.Keys[RowIndex] := Column.Name;
    ColumnTable.Values[Column.Name] := Column.Value;
  end
  else
  begin
    ColumnTable.InsertRow(Column.Name, Column.Value, True);
  end;
end;

procedure TTAzureTableDialog.EditColumnAction(Sender: TObject);
var
  Dialog: TTAzureTableRowDialog;
  OriginalName: String;
begin
  if (FCurrentEntity = nil) or (FCurrentColumn = nil) then
    Exit;

  Dialog := TTAzureTableRowDialog.Create(Self, FCurrentColumn, FCurrentEntity);

  try
    ColumnTable.Strings.BeginUpdate;
    if (Dialog.ShowModal  = mrOK) then
    begin
      OriginalName := FCurrentColumn.Name;
      //name of property has changed
      if OriginalName <> Dialog.Name then
      begin
        FCurrentEntity.ClearColumn(OriginalName, False);
        FCurrentEntity.SetColumn(Dialog.Name, Dialog.PersistChanges);
      end
      else
        Dialog.PersistChanges;

      SetColumnValue(OriginalName, FCurrentColumn);

      commitButton.Enabled := True;
    end;
  finally
    ColumnTable.Strings.EndUpdate;
    FreeAndNil(Dialog);
  end;
end;

procedure TTAzureTableDialog.AddColumnAction(Sender: TObject);
var
  Dialog: TTAzureTableRowDialog;
  NewColumn: TAzureTableColumn;
begin
  if FCurrentEntity = nil then
    Exit;

  Dialog := TTAzureTableRowDialog.Create(Self, nil, FCurrentEntity);

  try
    if (Dialog.ShowModal  = mrOK) then
    begin
      NewColumn := Dialog.PersistChanges;
      AddRow(NewColumn);
      commitButton.Enabled := True;
    end;
  finally
    FreeAndNil(Dialog);
  end;
end;

procedure TTAzureTableDialog.AddRow(ColumnEntry: TAzureTableColumn);
begin
  if (FCurrentEntity = nil) or (ColumnEntry = nil) then
    Exit;

  ColumnTable.Strings.BeginUpdate;
  try
    if (ColumnTable.Strings.IndexOfName(EmptyStr) = (ColumnTable.Strings.Count - 1)) then
      ColumnTable.Strings.Delete(ColumnTable.Strings.Count - 1);
    ColumnTable.InsertRow(ColumnEntry.Name, ColumnEntry.Value, True);

    FCurrentEntity.SetColumn(ColumnEntry.Name, ColumnEntry);
  finally
    ColumnTable.Strings.EndUpdate;
  end;
end;

procedure TTAzureTableDialog.AddRowAction(Sender: TObject);
var
  NewRow: TAzureTemporaryTableRow;
  PartitionKey: String;
  SelectedRow: TAzureTableRow;
begin
  if not FAddingRow then
  begin
    SelectedRow := GetSelectedRow;

    //If no row is selected, use the partition key from the last row
    if (SelectedRow = nil) then
      SelectedRow := GetLastRow;

    if SelectedRow <> nil then
      PartitionKey := SelectedRow.PartitionKey.Value;

    NewRow := TAzureTemporaryTableRow.Create(EmptyStr, PartitionKey);

    SetCurrentEntity(NewRow);
  end;
end;

procedure TTAzureTableDialog.BatchRowsCreated(Success: Boolean);
begin
  if not Assigned(Self) then
    Exit;

  EnableRowSelection(True);
  if not Success then
    MessageDlg(SImportEntitiesError, mtError, [mbOK], 0);

  InitializeRows;
end;

function TTAzureTableDialog.ByteContent(DataStream: TStream): TArray<Byte>;
var
  Buffer: TArray<Byte>;
begin
  if not Assigned(DataStream) then
    exit(nil);

  SetLength(Buffer, DataStream.Size);
  // the content may have been read
  DataStream.Position := 0;
  if DataStream.Size > 0 then
    DataStream.Read(Buffer[0], DataStream.Size);

  Result := Buffer;
end;

procedure TTAzureTableDialog.ClearColumnTable;
begin
  try
    if ColumnTable.Strings.Count > 0 then
    begin
      SelectTopCell(ColumnTable, True);
      ColumnTable.Strings.Clear;
    end;
  except
  end;
end;

procedure TTAzureTableDialog.ClearRows;
var
  I: Integer;
begin
  ClearColumnTable;
  for I := 0 to Pred(RowList.Items.Count) do
  begin
    //if the current instance is the same as FCurrentEntity set it to nil here
    //so we don't get an access violation when later freeing FCurrententity. This will probably
    //never be the case, but it doesn't hurt to be safe
    if RowList.Items.Objects[I] = FCurrentEntity then
      FCurrentEntity := nil;
    RowList.Items.Objects[I].Free;
    RowList.Items.Objects[I] := nil;
  end;
  FreeAndNil(FCurrentEntity);
  RowList.Clear;
end;

procedure TTAzureTableDialog.commitButtonClick(Sender: TObject);
var
  Row: TAzureTemporaryTableRow;
begin
  Assert(FCurrentEntity <> nil);
  Row := FCurrentEntity;

  //prevent the current entity from being freed, as it will be freed later in the TRowCreator thread
  FCurrentEntity := nil;
  EnableRowSelection(False);
  TRowCreator.Create(FTableName, Row, FConnectionInfo, RowCreatedOrUpdated);
end;

constructor TTAzureTableDialog.Create(AOwner: TComponent; ConnectionInfo: TAzureConnectionString);
begin
  inherited Create(AOwner);
  FConnectionInfo := ConnectionInfo;
  RowList.PopupMenu := CreateRowListPopupMenu;
  RowList.OnKeyUp := HandleRowKeyUp;
  EntityLabel.Caption := EmptyStr;
  ColumnTable.Enabled := False;
  ColumnTable.PopupMenu := CreateColumnsPopupMenu;
  ColumnTable.OnDblClick := HandleColumnDblClick;
  FAdvancedFilterPrefix := '~';
end;

function TTAzureTableDialog.CreateColumnsPopupMenu: TPopupMenu;
var
  Menu: TPopupMenu;
  Item: TMenuItem;
begin
  Menu := TPopupMenu.Create(Self);
  Menu.OnPopup := UpdateColumnsPopupMenu;

  Item := Menu.CreateMenuItem;
  Item.Name := EDIT_COLUMN;
  Item.Caption := SEditColumn;
  Item.OnClick := EditColumnAction;
  Menu.Items.Add(Item);

  FDeleteColumnItem := Menu.CreateMenuItem;
  FDeleteColumnItem.Name := DELETE_COLUMN;
  FDeleteColumnItem.Caption := SDeleteColumn;
  FDeleteColumnItem.OnClick := DeleteColumnAction;
  Menu.Items.Add(FDeleteColumnItem);

  Item := Menu.CreateMenuItem;
  Item.Name := 'N1';
  Item.Caption := cLineCaption;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := ADD_COLUMN;
  Item.Caption := SAddColumn;
  Item.OnClick := AddColumnAction;
  Menu.Items.Add(Item);

  Result := Menu;
end;

procedure TTAzureTableDialog.CreateDTMenuItem(Menu: TPopupMenu; Parent: TMenuItem; DataTypeName: String);
var
  Item: TMenuItem;
begin
  Item := Menu.CreateMenuItem;
  Item.Name := DataTypeName;
  Item.Caption := DT_XML_PREFIX + DataTypeName;
  Item.OnClick := SetDataTypeAction;
  Parent.Add(Item);
end;

function TTAzureTableDialog.CreateRowListPopupMenu: TPopupMenu;
var
  Menu: TPopupMenu;
  Item: TMenuItem;
begin
  Menu := TPopupMenu.Create(Self);
  Menu.OnPopup := UpdateRowListPopupMenu;

  Item := Menu.CreateMenuItem;
  Item.Name := ADD_ROW;
  Item.Caption := SAddTableEntity;
  Item.OnClick := AddRowAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := DELETE_ROW;
  Item.Caption := SDeleteTableEntity;
  Item.OnClick := DeleteRowAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := IMPORT_ROWS;
  Item.Caption := SImportTableEntities;
  Item.OnClick := ImportRowsAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := REFRESH_ROWS;
  Item.Caption := SRefresh;
  Item.OnClick := RefreshRowsAction;
  Menu.Items.Add(Item);

  Result := Menu;
end;

procedure TTAzureTableDialog.DeleteColumnAction(Sender: TObject);
var
  Index: Integer;
begin
  if (FCurrentColumn <> nil) and (FCurrentEntity <> nil) then
  begin
    Index := ColumnTable.Strings.IndexOfName(FCurrentColumn.Name);
    if (Index > -1) then
    begin
      commitButton.Enabled := True;
      ColumnTable.DeleteRow(Index + 1);
      FCurrentEntity.ClearColumn(FCurrentColumn.Name, True);
    end;
  end;
end;

procedure TTAzureTableDialog.DeleteRowAction(Sender: TObject);
var
  Row: TAzureTableRow;
begin
  Row := GetSelectedRow;

  if Row <> nil then
  begin
    if ConfirmDeleteItem then
    begin
      EnableRowSelection(False);
      ClearColumnTable;
      TRowDeletor.Create(FTableName, Row, FConnectionInfo, RowDeleted);
    end;
  end;
end;

procedure TTAzureTableDialog.EnableRowSelection(Enabled: Boolean);
begin
  if not Assigned(Self) or not Assigned(RowList) then
    Exit;

  if not Enabled then
    SetCurrentEntity(nil);

  RowList.Enabled := Enabled;
  FilterField.Enabled := Enabled;
end;

procedure TTAzureTableDialog.filterFieldKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    FilterRows;
end;

procedure TTAzureTableDialog.filterFieldRightButtonClick(Sender: TObject);
begin
  FilterRows;
end;

procedure TTAzureTableDialog.FilterRows;
begin
  InitializeRows;
end;

procedure TTAzureTableDialog.FormDestroy(Sender: TObject);
begin
  ClearRows;
end;

function TTAzureTableDialog.GetLastRow: TAzureTableRow;
var
  Count: Integer;
begin
  Result := nil;
  Count := RowList.Count;

  if Count > 0 then
  begin
    Result := TAzureTableRow(RowList.Items.Objects[Count - 1]);

    if (Result <> nil) and (Result.RowType <> azrRow) and (Count > 1) then
    begin
      Result := TAzureTableRow(RowList.Items.Objects[Count - 2]);
      Assert(Result.RowType = azrRow);
    end;
  end;
end;

function TTAzureTableDialog.GetSelectedRow: TAzureTableRow;
var
  Index: Integer;
  Row: TAzureRow;
begin
  Result := nil;
  Index := RowList.ItemIndex;
  if Index > -1 then
  begin
    Row := TAzureRow(RowList.Items.Objects[Index]);
    if Row.RowType = azrRow then    
      Result := TAzureTableRow(Row);
  end;
end;

procedure TTAzureTableDialog.HandleColumnDblClick(Sender: TObject);
begin
  //Populate FCurrentcolumn
  UpdateColumnsPopupMenu(Sender);

  //open colum edit dialog, if current selected column is valid
  EditColumnAction(Sender);
end;

procedure TTAzureTableDialog.HandleRowKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) then
    DeleteRowAction(Sender);
end;

procedure TTAzureTableDialog.SetTable(TableName: String);
begin
  FTableName := TableName;

  if TableName = '' then
    Caption := STableEditorTitle
  else
    Caption := Format(STableEditorTitle2, [TableName]);

  InitializeRows;
end;

procedure TTAzureTableDialog.UpdateColumnsPopupMenu(Sender: TObject);
var
  P: TPoint;
  Col: Integer;
  Row: Integer;
  MenuItem: TMenuItem;
begin
  FCurrentColumn := nil;
  FDeleteColumnItem.Enabled := False;

  GetCursorPos(P);
  P.X := P.X - ColumnTable.ClientOrigin.X;
  P.Y := P.Y - ColumnTable.ClientOrigin.Y;
  ColumnTable.MouseToCell(P.X, P.Y, Col, Row);

  for MenuItem in ColumnTable.PopupMenu.Items do
  begin
    if FCurrentEntity = nil then
      MenuItem.Enabled := False
    else if (MenuItem.Name = EDIT_COLUMN) or (MenuItem.Name = DELETE_COLUMN) then
    begin
      //enabled if it isn't the RowKey or PartitionKey row. For those rows, it is only enabled
      //if it is the edit item and it is a new row.
      MenuItem.Enabled := (Row > -1) and ((Row > 2) or (FCurrentEntity.IsNewRow and (MenuItem.Name = EDIT_COLUMN)));
      if MenuItem.Enabled then
      begin
        FCurrentColumn := FCurrentEntity.GetColumn(ColumnTable.Keys[Row]);
      end;
    end;
  end;
end;

procedure TTAzureTableDialog.UpdateRowListPopupMenu(Sender: TObject);
var
  Row: TAzureTableRow;
  MenuItem: TMenuItem;
begin
  Row := GetSelectedRow;

  for MenuItem in RowList.PopupMenu.Items do
  begin
    if (MenuItem.Name = DELETE_ROW) then
      MenuItem.Enabled := (Row <> nil)
    else
      MenuItem.Visible := True;
  end;
end;

procedure TTAzureTableDialog.ImportRows(RowArray: TJSONArray);
begin
  EnableRowSelection(False);
  TBatchRowCreator.Create(FTableName, RowArray, FConnectionInfo, BatchRowsCreated);
end;

procedure TTAzureTableDialog.ImportRowsAction(Sender: TObject);
var
  FileStream: TFileStream;
  FileBytes: TArray<Byte>;
  RowValue: TJSONValue;
begin
  if ImportRowsDialog.Execute then
  begin
    FileStream := nil;
    FileBytes := nil;
    try
      try
        FileStream := TFileStream.Create(ImportRowsDialog.FileName, fmOpenRead);
        FileBytes := ByteContent(FileStream);
        RowValue := TJSONObject.ParseJSONValue(FileBytes, 0);

        if RowValue is TJSONArray then
          ImportRows(TJSONArray(RowValue));
      except
        MessageDlg(SImportEntitiesError, mtError, [mbOK], 0);
      end;
    finally
      FreeAndNil(FileStream);
    end;
  end;
end;

procedure TTAzureTableDialog.InitializeRows;
begin
  EnableRowSelection(False);
  ClearRows;
  RowList.AddItem(SNodeLoading, TAzureRow.Create(azrLoading));
  TRowPopulator.Create(FTableName, FConnectionInfo, RowsPopulated, FAdvancedFilterPrefix, filterField.Text);
end;

procedure TTAzureTableDialog.RefreshRowsAction(Sender: TObject);
begin
  if not FAddingRow then
    InitializeRows;
end;

procedure TTAzureTableDialog.RowCreatedOrUpdated(Row: TAzureTableRow; IsNew: Boolean);
begin
  if not Assigned(Self) then
    Exit;

 EnableRowSelection(True);
 RowList.ClearSelection;

 if Row = nil then
 begin
   if IsNew then
     MessageDlg(SAddEntityError, mtError, [mbOK], 0)
   else
     MessageDlg(SUpdateEntityError, mtError, [mbOK], 0);
   InitializeRows;
 end;

 if IsNew and (Row <> nil) then
 begin
   RowList.AddItem(Row.GetID, Row);
 end
end;

procedure TTAzureTableDialog.RowDeleted(Row: TAzureTableRow; Success: Boolean);
begin
  if not Assigned(Self) then
    Exit;

  EnableRowSelection(True);
  if (Success) then
  begin
    if FCurrentEntity = Row then
      SetCurrentEntity(nil);
    RowList.DeleteSelected;
    FreeAndNil(Row);
  end
  else if Row <> nil then
    MessageDlg(Format(SDeleteEntityError, [Row.GetID]), mtError, [mbOK], 0);
end;

procedure TTAzureTableDialog.RowListClick(Sender: TObject);
var
  Row: TAzureTableRow;
begin
  Row := GetSelectedRow;
  if Row <> nil then
  begin
    if (FCurrentEntity <> nil) and (not FCurrentEntity.IsNewRow) then
    begin
      //If the selected row is the one already being viewed then no need to replace it
      if (FCurrentEntity.RowKey = Row.RowKey) and
         (FCurrentEntity.PartitionKey = Row.PartitionKey) then
        Exit;
    end;
    SetCurrentEntity(TAzureTemporaryTableRow.Create(Row));
  end
  else
    SetCurrentEntity(nil);
end;

procedure TTAzureTableDialog.RowsPopulated(Rows: TList<TAzureTableRow>; ContinuationToken: TAzureRowContinuationToken);
var
  Row: TAzureTableRow;
  Aux: TAzureRow;
begin
  if not Assigned(Self) then
    Exit;

  EnableRowSelection(True);
  ClearRows;

  if Rows <> nil then
  begin
    RowList.Items.BeginUpdate;
    try
      for Row in Rows do
      begin
        RowList.AddItem(Row.GetID, Row);
      end;

      if ContinuationToken.IsValid then
      begin
        Aux := TAzureRow.Create(azrTruncated);
        RowList.AddItem(SResultsTruncated, Aux);
      end;

      //The items are now managed by the list
      Rows.Clear;
      FreeAndNil(Rows);
    finally
      RowList.Items.EndUpdate;
    end;
  end;
end;

{ TTableRowData }

function TAzureTableRow.ClearColumn(Key: String; InstanceOwner: Boolean): TAzureTableColumn;
begin
  Result := GetColumn(Key);
  FColumns.Remove(Key);

  if InstanceOwner then
  begin
    FreeAndNil(Result);
  end;
end;

procedure TAzureTableRow.ClearColumns(InstanceOwner: Boolean);
var
  C: TAzureTableColumn;
begin
  if InstanceOwner then
  begin
    for C in FColumns.Values do
      C.Free;
  end;

  FColumns.Clear;
end;

constructor TAzureTableRow.Create;
begin
  inherited Create(azrRow);
  FRowKey := TAzureTableColumn.Create;
  FRowKey.Name := XML_ROWKEY;

  FPartitionKey := TAzureTableColumn.Create;
  FPartitionKey.Name := XML_PARTITION;

  FColumns := TDictionary<String,TAzureTableColumn>.Create;
end;

destructor TAzureTableRow.Destroy;
begin
  ClearColumns;
  FreeAndNil(FColumns);
  FreeAndNil(FRowKey);
  FreeAndNil(FPartitionKey);
  inherited;
end;

function TAzureTableRow.GetColumn(Key: String; IgnoreCase: Boolean): TAzureTableColumn;
var
  KeyLower: String;
  AKey: String;
begin
  Result := nil;

  if CompareText(Key, XML_ROWKEY) = 0 then
    Exit(FRowKey);

  if CompareText(Key, XML_PARTITION) = 0 then
    Exit(FPartitionKey);

  if IgnoreCase then
  begin
    KeyLower := AnsiLowerCase(Key);
    for AKey in FColumns.Keys do
    begin
      if KeyLower = AnsiLowerCase(AKey) then
        Exit(FColumns.Items[AKey]);
    end;
  end
  else if not FColumns.TryGetValue(Key, Result) then
    Exit(nil);
end;

function TAzureTableRow.GetID: String;
begin
  Result := Format('%s.%s', [RowKey.Value, PartitionKey.Value]);
end;

procedure TAzureTableRow.SetColumn(Key: String; Value: TAzureTableColumn);
begin
  if (Key <> EmptyStr) and (Value <> nil) then
  begin
    ClearColumn(Key);
    FColumns.Add(Key, Value);
  end;
end;

{ TRowPopulator }

constructor TRowPopulator.Create(TableName: String; ConnectionInfo: TAzureConnectionString;
                                 Callback: TRowPopulatorCallback; AdvancedFilterPrefix: String;
                                 Filter: String);
begin
  inherited Create;
  Assert(ConnectionInfo <> nil);
  Assert(TableName <> EmptyStr);

  FTableName := TableName;
  FFilter := Filter;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FAdvancedFilterPrefix := AdvancedFilterPrefix;
end;

destructor TRowPopulator.Destroy;
begin
  FreeAndNil(FTableService);
  inherited;
end;

function TRowPopulator.BuildFilterString: String;
var
  Filter: String;
begin
  Filter := FFilter;
  Result := Filter;

  if Trim(Filter) = EmptyStr then
    Exit(EmptyStr);
  if (Trim(FAdvancedFilterPrefix) = EmptyStr) then
    Result := Trim(Filter)
  else if AnsiStartsStr(FAdvancedFilterPrefix, FFilter) then
    Result := Trim(Copy(Filter, Length(FAdvancedFilterPrefix) + 1))
  else
  begin
    Filter := Trim(Filter);
    Result := Format('(RowKey eq ''%s'') or (PartitionKey eq ''%s'')', [Filter, Filter]);
  end;
end;

procedure TRowPopulator.Execute;
const
  NextRow = 'x-ms-continuation-NextRowKey';
  NextPartition = 'x-ms-continuation-NextPartitionKey';
var
  xml: String;
  xmlDoc: IXMLDocument;
  Rows: TList<TAzureTableRow>;
  TableNode: IXMLNode;
  ContentNode: IXMLNode;
  Row: TAzureTableRow;
  ContinuationToken: TAzureRowContinuationToken;
begin
  inherited;
  FreeOnTerminate := True;

  CoInitialize(nil);
  Rows := nil;
  xmlDoc := nil;

  try
    try
      FTableService := TAzureTableService.Create(FConnectionInfo);

      xml := FTableService.QueryEntities(FTableName, BuildFilterString);
      xmlDoc := TXMLDocument.Create(nil);
      xmlDoc.LoadFromXML(xml);

      ContinuationToken.NextRowKey := FTableService.ResponseHeader[NextRow];
      ContinuationToken.NextPartitionKey := FTableService.ResponseHeader[NextPartition];
      ContinuationToken.IsValid := FTableService.ResponseHeaderExists[NextRow] or
                                   FTableService.ResponseHeaderExists[NextPartition];

      Rows := TList<TAzureTableRow>.Create;

      TableNode := xmlDoc.DocumentElement.ChildNodes.FindNode(NODE_TABLE);

      while (TableNode <> nil) and (TableNode.HasChildNodes) do
      begin
        if (TableNode.NodeName = NODE_TABLE) then
        begin
          ContentNode := TableNode.ChildNodes.FindNode(NODE_TABLE_CONTENT);

          Row := GetRowFromConentNode(ContentNode);
          if Row <> nil then
            Rows.Add(Row);
        end;
        TableNode := TableNode.NextSibling;
      end;
    except
      FreeAndNil(Rows);
    end;
  finally
    CoUnInitialize();
    TThread.Synchronize(nil, procedure begin FCallback(Rows, ContinuationToken); end);
  end;
end;

{ TAzureTableColumn }

function TAzureTableColumn.Copy: TAzureTableColumn;
begin
  if not Assigned(Self) then
    Exit(nil);

  Result := TAzureTableColumn.Create;
  Result.Name := Name;
  Result.Value := Value;
  Result.DataType := DataType;
end;

constructor TAzureTableColumn.Create;
begin
  DataType := azdtString;
end;

procedure TAzureTableColumn.SetDataType(Value: String);
begin
  DataType := GetDataType(Value);
end;

{ TAzureRow }

constructor TAzureRow.Create(RowType: TRowType);
begin
  FRowType := RowType;
end;

{ TRowCreator }

constructor TRowCreator.Create(TableName: String; Row: TAzureTemporaryTableRow;
                               ConnectionInfo: TAzureConnectionString; Callback: TRowCreatedCallback);
begin
  inherited Create;
  Assert(Row <> nil);
  FTableName := TableName;
  FRow := Row;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
end;

destructor TRowCreator.Destroy;
begin
  FreeAndNil(FTableService);
  inherited;
end;

procedure TRowCreator.Execute;
var
  RowObj: TJSONObject;
  AddedRow: TAzureTableRow;
  Key: String;
  Value: TAzureTableColumn;
  xml: String;
  xmlDoc: IXMLDocument;
  ContentNode: IXMLNode;
  IsNew: Boolean;
begin
  inherited;
  FreeOnTerminate := True;

  AddedRow := nil;

  IsNew := FRow.IsNewRow;

  try
    RowObj := TJSONObject.Create;

    RowObj.AddPair(XML_ROWKEY,  TJSONString.Create(FRow.RowKey.Value));
    RowObj.AddPair(XML_PARTITION,  TJSONString.Create(FRow.PartitionKey.Value));

    for Key in FRow.Columns.Keys do
    begin
      Value := FRow.GetColumn(Key);
      if Value.DataType = azdtString then
        RowObj.AddPair(Key,  TJSONString.Create(Value.Value))
      else
        RowObj.AddPair(Key, TJSONArray.Create(Value.Value, GetDataType(Value.DataType)));
    end;

    FTableService := TAzureTableService.Create(FConnectionInfo);

    try
      if FRow.IsNewRow then
      begin
        try
          CoInitialize(nil);

          xml := FTableService.InsertEntity(FTableName, RowObj);

          xmlDoc := TXMLDocument.Create(nil);
          xmlDoc.LoadFromXML(xml);

          ContentNode := xmlDoc.DocumentElement.ChildNodes.FindNode(NODE_TABLE_CONTENT);

          AddedRow := GetRowFromConentNode(ContentNode);
        finally
          CoUninitialize;
        end;
      end
      else if FTableService.UpdateEntity(FTableName, RowObj) then
      begin
        AddedRow := FRow.Commit;
      end;
    except
      FreeAndNil(AddedRow);
    end;
  finally
    FreeAndNil(RowObj);
    FreeAndNil(FRow);

    TThread.Synchronize(nil, procedure begin FCallback(AddedRow, IsNew); end);
  end;
end;

{ TRowDeletor }

constructor TRowDeletor.Create(TableName: String; Row: TAzureTableRow; ConnectionInfo: TAzureConnectionString;
                               Callback: TRowDeletedCallback);
begin
  inherited Create;
  Assert(Row <> nil);
  FTableName := TableName;
  FRow := Row;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
end;

destructor TRowDeletor.Destroy;
begin
  FreeAndNil(FTableService);
  inherited;
end;

procedure TRowDeletor.Execute;
var
  Success: Boolean;
begin
  inherited;
  FreeOnTerminate := True;

  Success := False;

  try
    FTableService := TAzureTableService.Create(FConnectionInfo);

    try
      Success := FTableService.DeleteEntity(FTableName, FRow.PartitionKey.Value, FRow.RowKey.Value);
    except
      Success := False;
    end;
  finally
    TThread.Synchronize(nil, procedure begin FCallback(FRow, Success); end);
  end;
end;

{ TBatchRowCreator }

constructor TBatchRowCreator.Create(TableName: String; Rows: TJSONArray; ConnectionInfo: TAzureConnectionString;
                                    Callback: TBatchRowCreatedCallback);
begin
  inherited Create;
  Assert(Rows <> nil);
  FTableName := TableName;
  FRows := Rows;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
end;

destructor TBatchRowCreator.Destroy;
begin
  FreeAndNil(FTableService);
  inherited;
end;

function TBatchRowCreator.CreateRow(Row: TJSONObject): Boolean;
var
  RowKey: String;
  PartitionKey: String;
  Pair: TJSONPair;
begin
  if Row = nil then
    Exit(False);

  Pair := Row.Get('RowKey');

  //get RowKey and PartitionKey, which are required Entity properties
  if Pair = nil then
    Exit(False)
  else
    RowKey := Pair.Value;

  Pair := Row.Get('PartitionKey');

  if Pair = nil then
    Exit(False)
  else
    PartitionKey := Pair.Value;

  Result := True;

  try
    FTableService.InsertEntity(FTableName, Row);
  except
    Result := False;
  end;
end;

procedure TBatchRowCreator.Execute;
var
  Aux: TJSONValue;
  RowObj: TJSONObject;
  I: Integer;
  Success: Boolean;
begin
  inherited;
  FreeOnTerminate := True;

  Success := True;

  try
    FTableService := TAzureTableService.Create(FConnectionInfo);

    for I := 0 to FRows.Count - 1 do
    begin
      Aux := FRows.Items[I];
      if Aux is TJSONObject then
      begin
        RowObj := TJSONObject(Aux);
        try
          Success := CreateRow(RowObj) and Success;
        except
          Success := False;
        end;
      end;
    end;
  finally
    FreeAndNil(FRows);
    TThread.Synchronize(nil, procedure begin FCallback(Success); end);
  end;
end;

{ TAzureTemporaryTableRow }

constructor TAzureTemporaryTableRow.Create(RowKey, PartitionKey: String);
begin
  Inherited Create;

  FNewRow := True;
  FWrapped := TAzureTableRow.Create;

  FRowKey.Value := RowKey;
  FPartitionKey.Value := PartitionKey;
end;

constructor TAzureTemporaryTableRow.Create(Wrapped: TAzureTableRow);
var
  Key: String;
  Value: TAzureTableColumn;
begin
  Inherited Create;

  FNewRow := False;
  FWrapped := Wrapped;

  if Wrapped <> nil then
  begin
    FRowKey.Value := Wrapped.RowKey.Value;
    FPartitionKey.Value := Wrapped.PartitionKey.Value;

    for Key in Wrapped.Columns.Keys do
    begin
      Value := Wrapped.GetColumn(Key);
      SetColumn(Key, Value.Copy);
    end;
  end;
end;

destructor TAzureTemporaryTableRow.Destroy;
begin
  if IsNewRow then
    FreeAndNil(FWrapped);
  inherited;
end;

function TAzureTemporaryTableRow.GetID: String;
begin
  if IsNewRow then
    Result := SNewEntityTitle
  else
    Result := Inherited GetID;
end;

function TAzureTemporaryTableRow.Commit: TAzureTableRow;
var
  Key: String;
  Value: TAzureTableColumn;
begin
  if FWrapped = nil then
    Exit(nil);

  if not IsNewRow then
    FWrapped.ClearColumns;

  FWrapped.RowKey.Value := RowKey.Value;
  FWrapped.PartitionKey.Value := PartitionKey.Value;

  for Key in Columns.Keys do
  begin
    Value := GetColumn(Key);
    FWrapped.SetColumn(Key, Value.Copy);
  end;

  Result := FWrapped;
end;

end.
