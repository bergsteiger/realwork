unit vtGrids;

{$I vtDefine.inc }

interface

 uses Messages, Windows, SysUtils, Classes, Graphics, Menus, Controls, Forms,
      StdCtrls, Mask, Grids;

 Type
  TGetCellEvent = procedure (Sender: TObject; ACol, ARow: Longint; var Value: PChar) of object;
  TSetCellEvent = procedure (Sender: TObject; ACol, ARow: Longint; Value: PChar) of object;

  TvtCustomStringGrid = class(TCustomGrid)
   private

    fRenumCol : array of integer;

    //procedure DisableEditUpdate;
    //procedure EnableEditUpdate;
    //procedure Update(ACol, ARow: Integer); reintroduce;
    //procedure SetUpdateState(Updating: Boolean);


    //FOnColumnMoved: TMovedEvent;
    FOnDrawCell: TDrawCellEvent;
    //FOnGetEditMask: TGetEditEvent;
    FOnGetCellText: TGetCellEvent;
    FOnSetCellText: TSetCellEvent;
    //FOnRowMoved: TMovedEvent;
    //FOnSelectCell: TSelectCellEvent;
    //FOnSetEditText: TSetEditEvent;
    //FOnTopLeftChanged: TNotifyEvent;
    procedure   SizeChanged(OldColCount, OldRowCount: Longint); override;

   protected
    procedure   DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure   ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure   RowMoved(FromIndex, ToIndex: Longint); override;

    function    GetEditMask(ACol, ARow: Longint): string; override;

    function    GetCellText(ACol, ARow: Longint): PChar;
    procedure   SetCellText(ACol, ARow: Longint; Value: PChar);
    function    GetEditText(ACol, ARow: Longint): string; override;
    procedure   SetEditText(ACol, ARow: Longint; const Value: string); override;

    function    SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure   TopLeftChanged; override;
   public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    //function    CellRect(ACol, ARow: Longint): TRect;
    procedure   MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
   end;

  TvtStringGrid = class(TvtCustomStringGrid)
   public
    property Canvas;
    property Col;
    property ColWidths;
    property EditorMode;
    property GridHeight;
    property GridWidth;
    property LeftCol;
    property Selection;
    property Row;
    property RowHeights;
    property TabStops;
    property TopRow;
   published
    //property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnDrawCell: TDrawCellEvent read FOnDrawCell write FOnDrawCell;
    //property OnGetEditMask: TGetEditEvent read FOnGetEditMask write FOnGetEditMask;
    property OnGetCellText: TGetCellEvent read FOnGetCellText write FOnGetCellText;
    property OnSetCellText: TSetCellEvent read FOnSetCellText write FOnSetCellText;
    //property OnRowMoved: TMovedEvent read FOnRowMoved write FOnRowMoved;
    //property OnSelectCell: TSelectCellEvent read FOnSelectCell write FOnSelectCell;
    //property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged write FOnTopLeftChanged;

    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property ColCount;
    property Constraints;
    property Ctl3D;
    property DefaultColWidth;
    property DefaultRowHeight;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property FixedCols;
    property RowCount;
    property FixedRows;
    property Font;
    property GridLineWidth;
    property Options;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property VisibleColCount;
    property VisibleRowCount;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;

    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
   end;

implementation

{TvtCustomStringGrid}

constructor TvtCustomStringGrid.Create(AOwner: TComponent);
 begin
  inherited Create(AOwner);
  SizeChanged(ColCount, RowCount);
 end;

destructor TvtCustomStringGrid.Destroy;
 begin
  inherited Destroy;
 end;

procedure TvtCustomStringGrid.MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(X, Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;

procedure TvtCustomStringGrid.SizeChanged(OldColCount, OldRowCount: Longint);
 var
  I : Integer;
 begin
  If (High(fRenumCol) = Pred(ColCount)) then Exit;
  If ColCount > 0
   then
    begin
     SetLength(fRenumCol, ColCount);
     For I := 0 to Pred(ColCount) do
     fRenumCol[I] := I;
    end
   else
    fRenumCol := nil;
 end;

procedure TvtCustomStringGrid.ColumnMoved(FromIndex, ToIndex: Longint);
 var
  lSave : Integer;
 begin
  lSave := fRenumCol[FromIndex];
  fRenumCol[FromIndex] := fRenumCol[ToIndex];
  fRenumCol[ToIndex]   := lSave;
 end;

procedure TvtCustomStringGrid.RowMoved(FromIndex, ToIndex: Longint);
 begin
  //if Assigned(FOnRowMoved) then FOnRowMoved(Self, FromIndex, ToIndex);
 end;

function TvtCustomStringGrid.GetEditMask(ACol, ARow: Longint): string;
 begin
  Result := '';
  //if Assigned(FOnGetEditMask) then FOnGetEditMask(Self, ACol, ARow, Result);
 end;

function TvtCustomStringGrid.GetCellText(ACol, ARow: Longint): PChar;
 begin
  Result := '';
  if Assigned(FOnGetCellText) then FOnGetCellText(Self, fRenumCol[ACol], ARow, Result);
 end;

procedure TvtCustomStringGrid.SetCellText(ACol, ARow: Longint; Value: PChar);
 begin
  if Assigned(FOnSetCellText) then FOnSetCellText(Self, ACol, ARow, Value);
 end;

function  TvtCustomStringGrid.GetEditText(ACol, ARow: Longint): string;
 begin
  Result := StrPas(GetCellText(ACol, ARow));
 end;

procedure TvtCustomStringGrid.SetEditText(ACol, ARow: Longint; const Value: string);
 begin
  SetCellText(ACol, ARow, PChar(Value));
 end;

{begin
  DisableEditUpdate;
  try
    if Value <> Cells[ACol, ARow] then Cells[ACol, ARow] := Value;
  finally
    EnableEditUpdate;
  end;
  inherited SetEditText(ACol, ARow, Value);
end;
}

function TvtCustomStringGrid.SelectCell(ACol, ARow: Longint): Boolean;
begin
  Result := True;
  //if Assigned(FOnSelectCell) then FOnSelectCell(Self, ACol, ARow, Result);
end;

procedure TvtCustomStringGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
 var
  Hold: Integer;
 begin
  If DefaultDrawing
   then Canvas.TextRect(ARect, ARect.Left+2, ARect.Top+2, StrPas(GetCellText(ACol, ARow)))
   else
    begin
     if Assigned(FOnDrawCell) then
      begin
       if UseRightToLeftAlignment then
        begin
         ARect.Left := ClientWidth - ARect.Left;
         ARect.Right := ClientWidth - ARect.Right;
         Hold := ARect.Left;
         ARect.Left := ARect.Right;
         ARect.Right := Hold;
         //ChangeGridOrientation(False);
        end;
       FOnDrawCell(Self, ACol, ARow, ARect, AState);
       //if UseRightToLeftAlignment then ChangeGridOrientation(True);
      end;
    end;
 end;

procedure TvtCustomStringGrid.TopLeftChanged;
 begin
  inherited TopLeftChanged;
  //if Assigned(FOnTopLeftChanged) then FOnTopLeftChanged(Self);
 end;

{procedure TvtCustomStringGrid.DisableEditUpdate;
 begin
  Inc(FEditUpdate);
 end;

procedure TvtCustomStringGrid.EnableEditUpdate;
 begin
  Dec(FEditUpdate);
 end;
 }

{procedure TvtCustomStringGrid.SetUpdateState(Updating: Boolean);
 begin
  FUpdating := Updating;
  if not Updating and FNeedsUpdating then
  begin
    InvalidateGrid;
    FNeedsUpdating := False;
  end;
 end;

procedure TvtCustomStringGrid.Update(ACol, ARow: Integer);
 begin
  if not FUpdating then InvalidateCell(ACol, ARow)
  else FNeedsUpdating := True;
  if (ACol = Col) and (ARow = Row) and (FEditUpdate = 0) then InvalidateEditor;
 end;
}
end.
