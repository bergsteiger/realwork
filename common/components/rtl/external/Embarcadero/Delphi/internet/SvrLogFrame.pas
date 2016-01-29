{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SvrLogFrame;

interface

uses 
{$IFDEF MSWINDOWS}
  System.Win.Registry,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ActnList, Vcl.Menus, Vcl.ComCtrls, SvrLogDetailFrame, SvrLog, System.IniFiles;

type

  TColumnInfo = record
    Visible: Boolean;
    Width: Integer;
    ColumnPosition: Integer;
    SubItemPosition: Integer;
    Caption: string;
  end;

  TLogColumnOrder = array[0..Ord(High(TLogColumn))] of TLogColumn;

  TLogFrame = class(TFrame)
    lvLog: TListView;
    PopupMenu2: TPopupMenu;
    ActionList1: TActionList;
    ClearAction: TAction;
    Clear1: TMenuItem;
    DetailAction: TAction;
    DetailAction1: TMenuItem;
    procedure ClearActionExecute(Sender: TObject);
    procedure ClearActionUpdate(Sender: TObject);
    procedure DetailActionExecute(Sender: TObject);
    procedure lvLogDblClick(Sender: TObject);
    procedure lvLogColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvLogCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    FShowingDetail: Boolean;
    FColumnToSort: Integer;
    FSortDescending: Boolean;
    FSorted: Boolean;
    FColumnInfo: array[TLogColumn] of TColumnInfo;
    FLogMax: Integer;
    FLogDelete: Integer;
    function GetCount: Integer;
    function GetIndex: Integer;
    function GetCurrent: TTransactionLogEntry;
    procedure ConstrainLog;
    function GetColumnVisible(I: TLogColumn): Boolean;
    function GetColumnWidth(I: TLogColumn): Integer;
    procedure SetColumnVisible(I: TLogColumn; const Value: Boolean);
    procedure SetColumnWidth(I: TLogColumn; const Value: Integer);
    function GetColumnCaption(I: TLogColumn): string;
    function GetColumnPosition(I: TLogColumn): Integer;
    procedure SetColumnPosition(I: TLogColumn; const Value: Integer);
     function GetSubItemPosition(I: TLogColumn): Integer;
    procedure SetSubItemPosition(I: TLogColumn; const Value: Integer);
    function GetColumn(ALogColumn: TLogColumn): TListColumn;
    procedure SetCurrent(AItem: TListItem);
    function GetItemCount: Integer;
    procedure SetLogDelete(const Value: Integer);
    procedure SetLogMax(const Value: Integer);
    function GetSelectedItem: TListItem;
    function GetSelectedItemIndex: Integer;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SynchColumnInfo;
    procedure Add(Transaction: TTransactionLogEntry);
    procedure Next;
    procedure Previous;
    procedure Clear;
    property Count: Integer read GetCount;
    procedure ShowDetail(Details: TLogDetailFrame);
    procedure RefreshColumns;
    procedure RefreshSubItems;
    procedure Save(Reg: TRegIniFile; const Section: string);
    procedure Load(Reg: TRegIniFile; const Section: string);
    procedure GetSubItemOrder(var Positions: TLogColumnOrder);
    procedure GetColumnOrder(var Positions: TLogColumnOrder);
    property Index: Integer read GetIndex;
    property Current: TTransactionLogEntry read GetCurrent;
    property LogMax: Integer read FLogMax write SetLogMax;
    property LogDelete: Integer read FLogDelete write SetLogDelete;
    property ColumnCaption[I: TLogColumn]: string read GetColumnCaption;
    property ColumnWidth[I: TLogColumn]: Integer read GetColumnWidth write SetColumnWidth;
    property ColumnVisible[I: TLogColumn]: Boolean read GetColumnVisible write SetColumnVisible;
    property ColumnPosition[I: TLogColumn]: Integer read GetColumnPosition write SetColumnPosition;
    property SubItemPosition[I: TLogColumn]: Integer read GetSubItemPosition write SetSubItemPosition;
    property Columns[I: TLogColumn]: TListColumn read GetColumn;
    property ItemCount: Integer read GetItemCount;
  end;

implementation

uses SvrLogDetailDlg, SvrConst;

{$R *.dfm}

const
  LogColumnCaptions: array[TLogColumn] of string =
    (sEvent, sTime, sDate, sElapsed, sPath, sCode, sContentLength, sContentType, sThread);
  DefaultColumnPositions: array[TLogColumn] of Integer =
    (1, 2, 3, 4, 5, 6, 7, 8, 0);
  DefaultColumnVisible: array[TLogColumn] of Boolean =
    (True, True, False, True, True, True, True, True, True);
  DefaultColumnWidth: array[TLogColumn] of Integer =
    (50, 50, 50, 50, 50, 50, 50, 50, 50);

procedure TLogFrame.Add(Transaction: TTransactionLogEntry);
var
  Item: TListItem;
  I: Integer;
  LogColumn: TLogColumn;
  Positions: TLogColumnOrder;
  HaveCaption: Boolean;
begin
  GetSubItemOrder(Positions);
  Item := lvLog.Items.Add;
  Item.Data := Transaction;
  HaveCaption := False;
  for I := Low(Positions) to High(Positions) do
  begin
    LogColumn := Positions[I];
    if ColumnVisible[LogColumn] then
    begin
      if HaveCaption then
        Item.SubItems.Add(string(Transaction.Columns[LogColumn]))
      else
      begin
        Item.Caption := string(Transaction.Columns[LogColumn]);
        HaveCaption := True;
      end;
    end;
  end;
  ConstrainLog;
  if (ItemCount = 1) or not FShowingDetail then
  begin
    SetCurrent(Item);
    if FShowingDetail then
       ShowDetail(FLogDetail.LogDetailFrame);
  end;
end;

procedure TLogFrame.RefreshSubItems;
var
  Item: TListItem;
  I, J: Integer;
  LogColumn: TLogColumn;
  Positions: TLogColumnOrder;
  HaveCaption: Boolean;
  Transaction: TTransactionLogEntry;
  Count: Integer;
begin
  GetSubItemOrder(Positions);
  lvLog.Items.BeginUpdate;
  try
    for I := 0 to lvLog.Items.Count - 1 do
    begin
      Item := lvLog.Items[I];
      Transaction := TTransactionLogEntry(Item.Data);
      HaveCaption := False;
      Count := 0;
      for J := Low(Positions) to High(Positions) do
      begin
        LogColumn := Positions[J];
        if ColumnVisible[LogColumn] then
        begin
          if HaveCaption then
          begin
            if Count >= Item.SubItems.Count then
              Item.SubItems.Add(string(Transaction.Columns[LogColumn]))
            else
              Item.SubItems[Count] := string(Transaction.Columns[LogColumn]);
            Inc(Count);
          end
          else
          begin
            Item.Caption := string(Transaction.Columns[LogColumn]);
            HaveCaption := True;
          end;
        end;
      end;
    end;
  finally
    lvLog.Items.EndUpdate;
  end;
end;

procedure TLogFrame.Clear;
var
  I: Integer;
begin
  for I := 0 to lvLog.Items.Count - 1 do
    if Assigned(lvLog.Items[I].Data) then
      TObject(lvLog.Items[I].Data).Free;
  lvLog.Items.Clear;
end;

procedure TLogFrame.ClearActionExecute(Sender: TObject);
begin
  Clear;
end;

procedure TLogFrame.ClearActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := lvLog.Items.Count > 0;
end;

function TLogFrame.GetCount: Integer;
begin
  Result := lvLog.Items.Count;
end;

function TLogFrame.GetIndex: Integer;
var
  Item: TListItem;
begin
  Item := GetSelectedItem;
  if Assigned(Item) then
    Result := Item.Index
  else
    Result := -1;
end;

procedure TLogFrame.Next;
var
  I: Integer;
begin
  I := GetSelectedItemIndex;
  if I >= 0 then
    if I + 1 < lvLog.Items.Count then
      SetCurrent(lvLog.Items[I + 1]);
end;

procedure TLogFrame.SetCurrent(AItem: TListItem);
begin
  if Assigned(AItem) then
  begin
    lvLog.Selected := AItem;
    AItem.MakeVisible(False);
  end
  else
    lvLog.Selected := nil;
end;

procedure TLogFrame.Previous;
var
  I: Integer;
begin
  I := GetSelectedItemIndex;
  if I >= 0 then
    if I > 0 then
      SetCurrent(lvLog.Items[I - 1]);
end;

procedure TLogFrame.DetailActionExecute(Sender: TObject);
begin
  with FLogDetail do
  try
    FShowingDetail := True;
    ShowModal;
  finally
    FShowingDetail := False;
  end;
end;

procedure TLogFrame.ShowDetail(Details: TLogDetailFrame);
var
  Entry: TTransactionLogEntry;
begin
  Entry := Current;
  if Assigned(Current) then
  begin
    Details.Text := string(Entry.LogString);
  end
  else
  begin
    Details.Clear;
  end;
end;

destructor TLogFrame.Destroy;
begin
  Clear;
  FreeAndNil(FLogDetail);
  inherited;
end;

function TLogFrame.GetSelectedItem: TListItem;
var
  I: Integer;
begin
  I := GetSelectedItemIndex;
  if I >= 0 then
    Result := lvLog.Items[I]
  else
    Result := nil;
end;

function TLogFrame.GetSelectedItemIndex: Integer;
var
  I: Integer;
  F: Integer;
begin
  F := -1;
  // GetNextItem might be more efficient but there are bugs
  // in the K2 version.
  for I := 0 to lvLog.Items.Count - 1 do
  begin
    Result := I;
    if lvLog.Items[Result].Selected then
      Exit;
    if lvLog.Items[Result].Focused then
      F := Result;
  end;
  Result := F;
end;

function TLogFrame.GetCurrent: TTransactionLogEntry;
var
  Item: TListItem;
begin
  Item := GetSelectedItem;
  if Assigned(Item) then
    Result := TObject(Item.Data) as TTransactionLogEntry
  else
    Result := nil;
end;

constructor TLogFrame.Create(AOwner: TComponent);
var
  I: TLogColumn;
begin
  inherited;
  FLogDetail := TLogDetail.Create(Self);
  FLogDetail.LogFrame := Self;
  for I := Low(TLogColumn) to High(TLogColumn) do
  begin
    FColumnInfo[I].Width := DefaultColumnWidth[I];
    FColumnInfo[I].Visible := DefaultColumnVisible[I];
    FColumnInfo[I].Caption := LogColumnCaptions[I];
    FColumnInfo[I].ColumnPosition := DefaultColumnPositions[I];
    FColumnInfo[I].SubItemPosition := DefaultColumnPositions[I];
  end;
  RefreshColumns;
end;


procedure TLogFrame.RefreshColumns;
var
  I: Integer;
  LogColumn: TLogColumn;
  Column: TListColumn;
  Positions: TLogColumnOrder;
  Count: Integer;
begin
  lvLog.Columns.BeginUpdate;
  try
    lvLog.Columns.Clear;
    GetColumnOrder(Positions);
    Count := 0;
    for I := Low(Positions) to High(Positions) do
    begin
      LogColumn := Positions[I];
      if FColumnInfo[LogColumn].Visible then
      begin
        FColumnInfo[LogColumn].SubItemPosition := Count;
        Column := lvLog.Columns.Add;
        Column.Caption := FColumnInfo[LogColumn].Caption;
        Column.Width := FColumnInfo[LogColumn].Width;
        Inc(Count);
      end
      else
        FColumnInfo[LogColumn].SubItemPosition := High(Positions);
    end;
  finally
    lvLog.Columns.EndUpdate;
  end;
end;

procedure TLogFrame.ConstrainLog;
var
  DeleteCount: Integer;
begin
  if LogMax > 0 then
    if lvLog.Items.Count > LogMax then
    begin
      if LogDelete > 0 then
        DeleteCount := LogDelete
      else
        DeleteCount := 1;
      while (lvLog.Items.Count > 0) and (DeleteCount > 0) do
      begin
        lvLog.Items.Delete(0);
        Dec(DeleteCount);
      end;
    end;
end;

procedure TLogFrame.SetLogMax(const Value: Integer);
begin
  FLogMax := Value;
  ConstrainLog;
end;

procedure TLogFrame.lvLogDblClick(Sender: TObject);
begin
  DetailActionExecute(Self);
end;

procedure TLogFrame.lvLogColumnClick(Sender: TObject; Column: TListColumn);
begin
  if FSorted and (FColumnToSort = Column.Index) then
    FSortDescending := not FSortDescending
  else
    FSortDescending := False;
  FColumnToSort := Column.Index;
    (Sender as TCustomListView).AlphaSort;
  FSorted := True;
end;


procedure TLogFrame.lvLogCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);

  function SortOnKey(AKey: TLogColumn): Integer;
  var
    Transaction1, Transaction2: TTransactionLogEntry;
  begin
    Result := 0;
    if FColumnToSort <> FColumnInfo[AKey].SubItemPosition then
    begin
      Transaction1 := TTransactionLogEntry(Item1.Data);
      Transaction2 := TTransactionLogEntry(Item2.Data);
      Result := AnsiStrComp(PAnsiChar(Transaction1.Columns[AKey]),
        PAnsiChar(Transaction2.Columns[AKey]));
    end;
  end;
var
  I: Integer;
begin
  if FColumnToSort = 0 then
    Compare := CompareText(Item1.Caption,Item2.Caption)
  else
  begin
    I := FColumnToSort - 1;
    Compare := AnsiCompareText(Item1.SubItems[I],Item2.SubItems[I]);
  end;
  if Compare = 0 then
  begin
    Compare := SortOnKey(lcThreadID);
    if Compare = 0 then
      Compare := SortOnKey(lcTime);
  end;
  if FSortDescending then
    Compare := -Compare;

end;

function TLogFrame.GetColumnVisible(I: TLogColumn): Boolean;
begin
  Result := FColumnInfo[I].Visible;
end;

function TLogFrame.GetColumnWidth(I: TLogColumn): Integer;
begin
  Result := FColumnInfo[I].Width;

end;

procedure TLogFrame.SetColumnVisible(I: TLogColumn; const Value: Boolean);
begin
  FColumnInfo[I].Visible := Value;

end;

procedure TLogFrame.SetColumnWidth(I: TLogColumn; const Value: Integer);
begin
  FColumnInfo[I].Width := Value;

end;

function TLogFrame.GetColumnCaption(I: TLogColumn): string;
begin
  Result := FColumnInfo[I].Caption;
end;

const
  LogColumnID: array[TLogColumn] of string =
   ('Event', 'Time', 'Date', 'Elapsed', 'Path', 'Code', 'Content_Length',   // Do not localize
    'Content_Type', 'Thread');   // Do not localize
  sWidth = 'Width';           // Do not localize
  sVisible = 'Visible';       // Do not localize
  sPosition = 'Position';     // Do not localize
  sDetails = 'Details';       // Do not localize

procedure TLogFrame.Load(Reg: TRegIniFile; const Section: string);
var
  I: TLogColumn;
  SubSection: string;
begin
  FLogDetail.Load(Reg, sDetails);
  for I := Low(TLogColumn) to High(TLogColumn) do
    begin
      SubSection := Section + '_' + LogColumnID[I];
      ColumnVisible[I] := Reg.ReadBool(SubSection, sVisible, ColumnVisible[I]);
      ColumnWidth[I] := Reg.ReadInteger(SubSection, sWidth, ColumnWidth[I]);
      ColumnPosition[I] := Reg.ReadInteger(SubSection, sPosition, ColumnPosition[I]);
    end;
  RefreshColumns;
end;

procedure TLogFrame.Save(Reg: TRegIniFile; const Section: string);
var
  I: TLogColumn;
  SubSection: string;
begin
  FLogDetail.Save(Reg, sDetails);
  SynchColumnInfo;
  for I := Low(TLogColumn) to High(TLogColumn) do
    begin
      SubSection := Section + '_' + LogColumnID[I];
      Reg.WriteBool(SubSection, sVisible, ColumnVisible[I]);
      Reg.WriteInteger(SubSection, sWidth, ColumnWidth[I]);
      Reg.WriteInteger(SubSection, sPosition, ColumnPosition[I]);
    end;
end;

procedure TLogFrame.SynchColumnInfo;
var
  I, J: Integer;
  LogColumn, L: TLogColumn;
  Positions: TLogColumnOrder;
begin
  for I := 0 to High(Positions) do
    Positions[I] := TLogColumn(-1);
  for LogColumn := Low(TLogColumn) to High(TLogColumn) do
    if not FColumnInfo[LogColumn].Visible then
      Positions[FColumnInfo[LogColumn].ColumnPosition] := LogColumn;

  for I := 0 to lvLog.Columns.Count - 1 do
  begin
    LogColumn := Low(TLogColumn);
    for L := Low(TLogColumn) to High(TLogColumn) do
      if AnsiCompareText(FColumnInfo[L].Caption, lvLog.Columns[I].Caption) = 0 then
      begin
        LogColumn := L;
        break;
      end;
    FColumnInfo[LogColumn].Width := lvLog.Columns[I].Width;
    for J := I to High(Positions) do
      if Positions[J] = TLogColumn(-1) then
      begin
        FColumnInfo[LogColumn].ColumnPosition := J;
        Positions[J] := LogColumn;
        break;
      end;
  end;
end;

function TLogFrame.GetColumnPosition(I: TLogColumn): Integer;
begin
  Result := FColumnInfo[I].ColumnPosition;
end;

procedure TLogFrame.SetColumnPosition(I: TLogColumn; const Value: Integer);
begin
  FColumnInfo[I].ColumnPosition := Value;
end;

procedure TLogFrame.GetColumnOrder(var Positions: TLogColumnOrder);
var
  LogColumn: TLogColumn;
begin
  for LogColumn := Low(TLogColumn) to High(TLogColumn) do
    Positions[FColumnInfo[LogColumn].ColumnPosition] := LogColumn;
end;

procedure TLogFrame.GetSubItemOrder(var Positions: TLogColumnOrder);
var
  LogColumn: TLogColumn;
begin
  for LogColumn := Low(TLogColumn) to High(TLogColumn) do
    Positions[FColumnInfo[LogColumn].SubItemPosition] := LogColumn;
end;

function TLogFrame.GetSubItemPosition(I: TLogColumn): Integer;
begin
  Result := FColumnInfo[I].SubItemPosition;

end;

procedure TLogFrame.SetSubItemPosition(I: TLogColumn;
  const Value: Integer);
begin
  FColumnInfo[I].SubItemPosition := Value;
end;

function TLogFrame.GetColumn(ALogColumn: TLogColumn): TListColumn;
var
  I: Integer;
begin
  for I := 0 to lvLog.Columns.Count - 1 do
  begin
    Result := lvLog.Columns[I];
    if AnsiCompareText(Result.Caption, FColumnInfo[ALogColumn].Caption) = 0 then Exit;
  end;
  Result := nil;
end;

function TLogFrame.GetItemCount: Integer;
begin
  Result := lvLog.Items.Count;
end;

procedure TLogFrame.SetLogDelete(const Value: Integer);
begin
  FLogDelete := Value;
end;

end.
