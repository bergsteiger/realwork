{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit FMX.Grid.Style;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, System.Rtti, System.Generics.Collections, FMX.Controls, FMX.StdCtrls,
  FMX.Presentation.Style, FMX.Presentation.Messages, FMX.Controls.Presentation, FMX.Graphics, FMX.Types,
  FMX.ScrollBox.Style, FMX.ScrollBox, FMX.Header, FMX.Controls.Model, FMX.Grid;

type
  TGridPart = (Content, Columns, Header, HeaderItemSize, Selection, EditorModeChanging, EditorShowing, EditorKeyDown);
  TGridParts = set of TGridPart;

  TStyledGrid = class;

  /// <summary> The class of header item for <b>TStyledGrid</b> </summary>
  TGridHeaderItem = class(THeaderItem, ICellControl)
  private
    [Weak] FColumn: TColumn;
    [Weak] FStyledGrid: TStyledGrid;
    FResize: Boolean;
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
  protected
    procedure Click; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetDefaultStyleLookupName: string; override;
    procedure Resize; override;
    procedure Resizing; override;
    procedure Resized; override;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary> Reference to column which has this header </summary>
    property Column: TColumn read FColumn write SetColumn;
    /// <summary> Reference to grid of this header. Same as <b>Owner</b> </summary>
    property Grid: TStyledGrid read FStyledGrid;
  end;

  /// <summary> The styled presentation for <b>TCustomGrid</b> </summary>
  TStyledGrid = class(TStyledCustomScrollBox)
  public const
    MinSize = 10;
    /// <summary> The defaul color of odd rows. This value is used if the style hasn't got
    /// <c>'AlternatingRowBackground'</c>. See also <b>TGridOption.AlternatingRowBackground</b></summary>
    AlternatingBackgroundColor: TAlphaColor = $20000000;
    /// <summary> The defaul color of lines. This value is used if the style hasn't got
    /// <c>'LineFill'</c></summary>
    LineColor: TAlphaColor = $FF202020;
    DefaultRowHeight = 21;
    DefaultThickness = 1;
    DefaultFocusOpacity = 0.4;
    HitTestOptions = [TGridOption.ColumnMove, TGridOption.HeaderClick];
  private type
    TColInfo = record
      Left: Integer;
      Width: Word;
    end;
  private
    FUpdating: TGridParts;
    FEditorMode: Boolean;
    FHeader: THeader;
    FFocus: TControl;
    FFocusClone: TControl;
    FSelectionClone: TControl;
    FSelection: TControl;
    FOddFill: TBrush;
    FLineFill: TBrush;
    FEditorLineFill: TBrush;
    FEditorBackground: TBrush;
    FContentSize: TSize;
    FOldColLinesVisible: Boolean;
    FOldHeaderVisible: Boolean;
    FTopRow: Integer;
    FLeftColumn: Integer;
    FBottomRow: Integer;
    FRightColumn: Integer;
    FDefaultRowHeight: Integer;
    FWorkRect: TRectF;
    FVKRect: TRectF;
    FMouseDown: Boolean;
    FMouseDownPos: TPointF;
    FHasTouchScreen: Boolean;
    FCellControl: TStyledControl;
    FInplaceEdit: TFmxObject;
    FOldRowCount: Integer;
    FColInfo: array of TColInfo;
    FBitmapsScale: Single;
    FBitmapsHeight: Single;
    FStyledBitmaps: array [Boolean] of TBitmap;
    FBitmaps: array [Boolean] of TBitmap;
    procedure MMContentChanged(var Message: TDispatchMessage); message MM_CONTENT_CHANGED;
    procedure MMColumnChanged(var Message: TDispatchMessageWithValue<Integer>); message MM_COLUMN_CHANGED;
    procedure MMInvalidateCell(var Message: TDispatchMessageWithValue<TGridModel.TCoord>); message MM_INVALIDATE_CELL;
    procedure MMColumnMoved(var Message: TDispatchMessageWithValue<TGridModel.TColumnIndexes>); message MM_COLUMN_MOVED;
    procedure MMSelChanged(var Message: TDispatchMessage); message MM_SEL_CHANGED;
    procedure PMCellByPoint(var Message: TDispatchMessageWithValue<TGridModel.TPointInfo>); message PM_CELL_BY_POINT;
    procedure PMGetDisplay_Cells(var Message: TDispatchMessageWithValue<TGridModel.TRectCoord>);
      message PM_GET_DISPLAY_CELLS;
    procedure PMCreateCellObject(var Message: TDispatchMessageWithValue<TGridModel.TCellObjectInfo>);
      message PM_CREATE_CELL_OBJECT;
    procedure MMGetRowHeight(var Message: TDispatchMessageWithValue<Integer>); message MM_GET_ROW_HEIGHT;
    procedure MMInvalidateContentSize(var Message: TDispatchMessage); message MM_INVALIDATE_CONTENT_SIZE;
    procedure PMCanEdit(var Message: TDispatchMessageWithValue<Boolean>); message PM_CAN_EDIT;
    procedure PMSetTopLeft(var Message: TDispatchMessageWithValue<TGridModel.TCoord>); message PM_SET_TOP_LEFT;
    procedure PMScrollToSelect(var Message: TDispatchMessage); message PM_SCROLL_TO_SELECT;
    procedure MMCellRect(var Message: TDispatchMessageWithValue<TGridModel.TCellInfo>); message MM_CELL_RECT;
    procedure MMShowEditor(var Message: TDispatchMessage); message MM_SHOW_EDITOR;
    procedure MMHideEditor(var Message: TDispatchMessageWithValue<Boolean>); message MM_HIDE_EDITOR;
    procedure MMPostEditorValue(var Message: TDispatchMessage); message MM_POST_EDITOR_VALUE;
    procedure MMRefreshEditorValue(var Message: TDispatchMessage); message MM_REFRESH_EDITOR_VALUE;
    procedure MMEditorMode(var Message: TDispatchMessageWithValue<Boolean>); message MM_EDITOR_MODE;
    procedure MMGetEditorValue(var Message: TDispatchMessageWithValue<TValue>); message MM_GET_EDITOR_VALUE;
    procedure PMVKDisplacement(var Message: TDispatchMessageWithValue<TGridModel.TVKInfo>); message PM_VKDISPLACEMENT;
    procedure PMSetContent(var Message: TDispatchMessageWithValue<TScrollContent>); message PM_SET_CONTENT;
    procedure PMBeginPaintChildren(var Message: TDispatchMessage); message PM_BEGIN_PAINT_CHILDREN;
    procedure PMEndPaintChildren(var Message: TDispatchMessage); message PM_END_PAINT_CHILDREN;
    function GetModel: TGridModel;
    procedure DoContentResize(Sender: TObject);
    procedure DoGetClipRect(Sender: TObject; var ContentBounds: TRectF);
    procedure DoContentPainting(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure DoRealignItem(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure DoDrawHeader(Sender: TObject; const Canvas: TCanvas; const Item: THeaderItem; const Bounds: TRectF);
    function GetColumnCount: Integer; inline;
    function GetRowCount: Integer; inline;
    function GetLeftColumn: Integer;
    function GetTopRow: Integer;
    function GetWorkRect: TRectF;
    function GetBottomRow: Integer;
    function GetRighttColumn: Integer;
    function GetColumns(const Index: Integer): TColumn;
    function GetPaintRect: TRectF;
    procedure InternalDrawCells(const Canvas: TCanvas; const AFrontLayer: Boolean; var NeedEditorBackground: Boolean);
    procedure ClickTimerProc(Sender: TObject);
    function GetHeaderItemCount: Integer;
    function GetHeaderItem(const Index: Integer): TGridHeaderItem;
    procedure UpdateHeaderOffset;
    function EditingDone(const Accept: Boolean): Boolean;
    function PostEditorValue: Boolean;
    function GetBitmaps(const Index: Boolean): TBitmap;
    procedure FreeStyledBitmaps;
    procedure UpdateStyledBitmaps;
    procedure UpdateHeaderOptions;
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetRowHeight: Integer; virtual;
    function GetColumnThickness: Integer; virtual;
    function GetRowThickness: Integer; virtual;
    /// <summary> This function return bounds of one cell. It is called from message <b>MM_CELL_RECT</b>. See also
    /// <b>TCustomGrid.CellRect</b> </summary>
    function CellRect(const ACol, ARow: Integer): TRect;
    procedure DoViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean); override;
    function DefineModelClass: TDataModelClass; override;
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
    /// <summary> Performing of method <b>KeyDown</b> excluding the recursive call </summary>
    procedure PerformKeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    /// <summary> Sets input focus to the owner of model if possible </summary>
    /// <remarks> The <b>TStyledGrid</b> cannot have input focus </remarks>
    procedure SetFocus;
    /// <summary> Create the control that is uses for acces to elements of style (by default <c>'textcellstyle'</c>)
    /// This control is used to paint the default text cells </summary>
    function CreateDefaulCell: TStyledControl; virtual;
    /// <summary> Define the class of cell by the column. Usualy this class should support interface
    /// <b>IDrawableCell</b>. The created instance is used to paint cells. If returns <c>nil</c> then the cells is
    /// painted by default</summary>
    /// <remarks> This method is calls from handler of message <b>PM_CREATE_CELL_OBJECT</b> </remarks>
    function GetCellClass(const Column: TColumn): TFmxObjectClass; virtual;
    /// <summary> Define the class of cell editor by the column. The editor is created in the method <b>ShowEditor</b>.
    /// This method is called after <b>DoCreateCustomEditor</b> in case it return <c>nil</c> (by default) </summary>
    function GetEditorClass(const Column: TColumn): TFmxObjectClass; virtual;
    /// <summary> This virual method can create the cell editor. By default it only call the event handler
    /// <b>Model.OnCreateCustomEditor</b>. See also <b>GetCellClass</b> </summary>
    procedure DoCreateCustomEditor(const Column: TColumn; var Control: TStyledControl); virtual;
    /// <summary> Invalidates the previously calculated values of <b>ContentSize</b>, <b>WorkRect</b> etc </summary>
    procedure InvalidateContentSize;
    /// <summary> Calculation and setup size of content, also arrangement all columns and header items </summary>
    /// <remarks> This method is called from message <b>MM_CONTENT_SIZE_CHANGED</b> </remarks>
    procedure UpdateContent;
    /// <summary> Setup bounds of all columns according the header items </summary>
    procedure UpdateColumns;
    /// <summary> Complete setup of header according the bounds of columns and <b>ViewportPosition</b> </summary>
    procedure UpdateHeader;
    /// <summary> Setup bounds of the header item according the bounds of column and <b>ViewportPosition</b>
    /// </summary>
    procedure UpdateItemRect(const ColumnIndex, ItemIndex: Integer);
    /// <summary> Sets the correct coordinates for highlighting of row and cell. See the style elements
    /// <c>'selection'</c>, <c>'focus'</c>. </summary>
    procedure UpdateSelection;
    /// <summary> Defined is it acceptable to use of touch screen </summary>
    function TouchEnabled: Boolean; virtual;
    /// <summary> The value of editor of cell. If the editor absent then <c>Empty</c> </summary>
    function GetInplaceEditorValue(const AInplaceEdit: TFMXObject): TValue; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    /// <summary> Determine it is possible to open edit of cell with coordinates <b>Model.Col</b>, <b>Model.Row</b>
    /// </summary>
    /// <returns> <c>True</c> if there is possible</returns>
    function CanEdit: Boolean; virtual;
    /// <summary> This virtual method is used to determine coordinates of the editor of a cell </summary>
    /// <returns> By default value that <b>CellRect</b> return </returns>
    function GetEditorRect: TRectF; virtual;
    /// <summary> This method refresh editor of cell </summary>
    /// <param name="InplaceEdit"> An instance of the cell editor </param>
    /// <param name="RefreshAppearance"> Need to update the appearance (e.g. font color) </param>
    /// <param name="RefreshValue"> Need to update the edited value </param>
    /// <returns> <c>False</c> in case if updating fail (e.g. the edit cannot show value, or it cannot work in
    /// readonly mode) </returns>
    /// <remarks> This method call <b>TGridModel.GetValue</b>, <b>TColumn.RefreshEditor</b> </remarks>
    function RefreshEditor(const InplaceEdit: TFmxObject; const RefreshAppearance, RefreshValue: Boolean): Boolean;
      virtual;
    /// <summary> This method opens the editor if this is possibe and it was not open before and changes the property
    /// <b>EditorMode</b>. Also this method try to create cell edit by <b>DoCreateCustomEditor</b> and if it
    /// returns <c>nil</c> then, it create instance of class that defined by method <b>GetEditorClass</b>
    /// <para> After creating of edit, the method <b>RefreshEditor</b> is called. If this method returns <c>False</c>
    /// then the edit is destroyed and the property <b>EditorMode</b> is <c>False</c> </para>
    /// </summary>
    procedure ShowEditor;
    /// <summary> This method closes editor if it opened and changes the property <b>EditorMode</b> </summary>
    /// <param name="Accept"> If <c>True</c> the value of editor have to applied, otherwise the old value should be used
    /// </param>
    /// <remarks> This method is called by message <b>MM_HIDE_EDITOR</b> and call the method <b>TColumn.EditingDone</b>
    /// </remarks>
    procedure HideEditor(const Accept: Boolean);
    /// <summary> Determine the indexes row and column by absolute coordinates. If it impossible then returns <c>-1</c>
    /// </summary>
    procedure CellByPoint(const X, Y: Single; var ACol, ARow: Integer);
    /// <summary> Sets cell that is placed in top left corner of grid </summary>
    /// <param name="ACol"> The index of column. If <c>-1</c> then <b>ViewportPosition.X</b> is not changed </param>
    /// <param name="ARow"> The index of column. If <c>-1</c> then <b>ViewportPosition.Y</b> is not changed </param>
    procedure SetTopLeft(const ACol, ARow: Integer);
    /// <summary> This method moves <b>ViewportPosition</b> (if need), so that the selected cell will become visible in
    /// the work area </summary>
    procedure ScrollToSelectedCell;
    /// <summary> Indicates that the currently someone cell in the table is edited </summary>
    /// <returns> <c>True</c> if the editor of cell is shown </returns>
    property EditorMode: Boolean read FEditorMode;
    /// <summary> <c>true</c> if the touch screen is found </summary>
    property HasTouchScreen: Boolean read FHasTouchScreen;
    /// <summary> Returns the data model of <b>TGridModel</b></summary>
    property Model: TGridModel read GetModel;
    /// <summary> The real height of the row. If the property <b>Model.RowHeight</b> is zero then height of row is
    /// defined automatically by the font size </summary>
    property RowHeight: Integer read GetRowHeight;
    /// <summary> The thickness of lines between columns. See also <b>TGridOption.ColLines</b> </summary>
    property ColumnThickness: Integer read GetColumnThickness;
    /// <summary> The thickness of lines between rows. See also <b>TGridOption.RowLines</b> </summary>
    property RowThickness: Integer read GetRowThickness;
    /// <summary> The number of columns in the grid. See also <b>Model.ColumnCount</b> </summary>
    property ColumnCount: Integer read GetColumnCount;
    /// <summary> The array that contains all columns. See also <b>Model.Columns</b> </summary>
    property Columns[const Index: Integer]: TColumn read GetColumns;
    /// <summary> The number of items of header </summary>
    property HeaderItemCount: Integer read GetHeaderItemCount;
    /// <summary> The array that contains all items of header</summary>
    property HeaderItem[const Index: Integer]: TGridHeaderItem read GetHeaderItem;
    /// <summary> The number of rows in the grid. See also <b>Model.RowCount</b> </summary>
    property RowCount: Integer read GetRowCount;
    /// <summary> The index of first top row that at least partially visible </summary>
    property TopRow: Integer read GetTopRow;
    /// <summary> The index of last bottom row that at least partially visible </summary>
    property BottomRow: Integer read GetBottomRow;
    /// <summary> The index of first left column that at least partially visible </summary>
    property LeftColumn: Integer read GetLeftColumn;
    /// <summary> The index of last right column that at least partially visible </summary>
    property RigthColumn: Integer read GetRighttColumn;
    /// <summary> The coordinates of area that is visible on the grid. See also <b>ViewportPosition</b> </summary>
    /// <remarks> The coordinates is defined relatively the content</remarks>
    property WorkRect: TRectF read GetWorkRect;
    /// <summary> The coordinates of area that should be repainted. See also <b>WorkRect</b> </summary>
    property PaintRect: TRectF read GetPaintRect;
    /// <summary> The array which stores the standard image of check boxes </summary>
    property Bitmaps[const Index: Boolean]: TBitmap read GetBitmaps;
  end;

implementation

uses
  System.RTLConsts, System.Math.Vectors, System.SysUtils, System.Math, System.TypInfo, FMX.Consts,
  FMX.Presentation.Factory, FMX.Platform, FMX.Utils, FMX.TextLayout, FMX.StdActns, FMX.Objects, FMX.Ani, FMX.ExtCtrls,
  FMX.Edit, FMX.DateTimeCtrls, FMX.NumberBox, FMX.Text, FMX.ImgList;

const
  StrTextcellstyle = 'textcellstyle'; // do not localize
  StrDateeditstyle = 'dateeditstyle'; // do not localize
  StrTimeeditstyle = 'timeeditstyle'; // do not localize
  StrPopupcellstyle = 'popupcellstyle'; // do not localize
  StrImagecellstyle = 'imagecellstyle'; // do not localize
  StrHeaderitemstyle = 'headeritemstyle'; // do not localize
  StrNumberBoxstyle =  'numberboxstyle'; // do not localize
  StrFont = 'font'; // do not localize
  StrFontColor = 'foreground'; // do not localize
  StrContent = 'content'; // do not localize
  StrHindicator = 'hindicator'; // do not localize
  StrTrack = 'track'; // do not localize
  StrHtrack = 'htrack'; // do not localize
  StrBackground = 'background'; // do not localize
  StrText = 'text'; // do not localize
  StrImage = 'image'; // do not localize
  StrHeader = 'header'; // do not localize
  StrFocus = 'focus'; // do not localize
  StrSelection = 'selection'; // do not localize
  StrAlternatingRowBackgr = 'AlternatingRowBackground'; // do not localize
  StrLineFill = 'LineFill'; // do not localize
  StrEditorLineFill = 'EditorLineFill'; // do not localize
  StrEditorBackground = 'EditorBackground'; // do not localize

type
  TOpenControl = class(TControl);

  TOpenHeader = class(THeader);

type
  TSelectTimer = class(TTimer)
  public type
    TTimerAction = (ShowEditor, Exit, SelectCell, MouseClick);
    TTimerActions = set of TTimerAction;
  private
    FCoord: TGridModel.TCoord;
    FPoint: TPointF;
    FTimerActions: TTimerActions;
  public
    constructor Create(AOwner: TComponent; const Coord: TGridModel.TCoord; const Point: TPointF;
      const Event: TNotifyEvent; const TimerActions: TTimerActions); reintroduce;
  end;

{ TSelectTimer }

constructor TSelectTimer.Create(AOwner: TComponent; const Coord: TGridModel.TCoord; const Point: TPointF;
  const Event: TNotifyEvent; const TimerActions: TTimerActions);
begin
  inherited Create(AOwner);
  FTimerActions := TimerActions;
  FCoord := Coord;
  FPoint := Point;
  OnTimer := Event;
  Interval := 100;
end;

{$REGION 'TDefaultEditor'}
type
  TDefaultEditor = class(TCustomEdit, ICellControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
    [Weak] FColumn: TColumn;
    FContent: TControl;
    FOldMargins: TRectF;
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
    procedure ChangeProc(Sender: TObject);
  protected
    function GetDefaultStyleLookupName: string; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TDefaultEditor }

constructor TDefaultEditor.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
  DisableDisappear := True;
  OnChangeTracking := ChangeProc;
end;

function TDefaultEditor.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TDefaultEditor.SetColumn(const Value: TColumn);
begin
  FColumn := Value;
end;

procedure TDefaultEditor.DoExit;
begin
  inherited;
  if FColumn <> nil then
    FColumn.Model.HideEditor;
end;

procedure TDefaultEditor.ApplyStyle;
begin
  inherited;
  if (FColumn <> nil) and FindStyleResource<TControl>(StrContent, FContent) then
  begin
    FOldMargins := FContent.Margins.Rect;
    FContent.Margins.Rect := FColumn.Padding.Rect;
  end;
end;

procedure TDefaultEditor.FreeStyle;
begin
  inherited;
  if FContent <> nil then
  begin
    FContent.Margins.Rect := FOldMargins;
    FContent := nil;
  end;
end;

function TDefaultEditor.GetDefaultStyleLookupName: string;
begin
  Result := StrTextcellstyle;
end;

procedure TDefaultEditor.KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  ColChange, RowChange: Boolean;
begin
  ColChange := ([ssAlt, ssCommand] * Shift <> []) and (Key in [vkLeft, vkRight]);
  RowChange := Key in [vkUp, vkDown, vkPrior, vkNext];
  if (KeyChar = #0) and (ColChange or RowChange) then
  begin
    FStyledGrid.PerformKeyDown(Key, KeyChar, Shift);
    Key := 0;
  end
  else if (Key = 0) and (KeyChar <> #0) and (FColumn <> nil) and not FColumn.ValidChar(KeyChar) then
    KeyChar := #0;
  inherited;
end;

procedure TDefaultEditor.ChangeProc(Sender: TObject);
begin
  if FColumn <> nil then
    FColumn.EditorModified;
end;

{$ENDREGION}

{$REGION 'TCellText'}

type
  TCellText = class(TTextControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
  protected
    function GetDefaultStyleLookupName: string; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TCellText }

constructor TCellText.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
end;

procedure TCellText.ApplyStyle;
var
  Font: TFontObject;
  Brush: TBrushObject;
begin
  inherited;
  FStyledGrid.Model.DefaultTextSettings.BeginUpdate;
  try
    FStyledGrid.Model.DefaultTextSettings.Assign(DefaultTextSettings);
    if FindStyleResource<TFontObject>(StrFont, Font) then
      FStyledGrid.Model.DefaultTextSettings.Font := Font.Font;
    if FindStyleResource<TBrushObject>(StrFontColor, Brush) then
      FStyledGrid.Model.DefaultTextSettings.FontColor := Brush.Brush.Color;
    FStyledGrid.Model.DefaultTextSettings.WordWrap := False;
  finally
    FStyledGrid.Model.DefaultTextSettings.EndUpdate;
  end;
end;

procedure TCellText.FreeStyle;
begin
  inherited;
  if not (csDestroying in ComponentState) and (FStyledGrid.Model <> nil) then
    FStyledGrid.Model.DefaultTextSettings := DefaultTextSettings;
end;

function TCellText.GetDefaultStyleLookupName: string;
begin
  Result := StrTextcellstyle;
end;

{$ENDREGION}

{$REGION 'TProgressCell'}

type
  TProgressCell = class(TProgressBar, IDrawableCell, ICellControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
    [Weak] FColumn: TProgressColumn;
    FIndicator: IDrawableObject;
    FBackground: IDrawableObject;
    procedure BeforeDrawing(const Canvas: TCanvas);
    procedure AfterDrawing(const Canvas: TCanvas);
    procedure DrawCell(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
      const State: TGridDrawStates);
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Indicator: IDrawableObject read FIndicator;
    property Background: IDrawableObject read FBackground;
  end;

{ TProgressCell }

constructor TProgressCell.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
end;

function TProgressCell.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TProgressCell.SetColumn(const Value: TColumn);
begin
  ValidateInheritance(Value, TProgressColumn, True);
  FColumn := TProgressColumn(Value);
end;

procedure TProgressCell.ApplyStyle;
begin
  inherited;
  Supports(FindStyleResource(StrHindicator), IDrawableObject, FIndicator);
  if not Supports(FindStyleResource(StrHtrack), IDrawableObject, FBackground) then
    Supports(FindStyleResource(StrTrack), IDrawableObject, FBackground);
end;

procedure TProgressCell.FreeStyle;
begin
  inherited;
  FBackground := nil;
  FIndicator := nil;
end;

procedure TProgressCell.AfterDrawing(const Canvas: TCanvas);
begin

end;

procedure TProgressCell.BeforeDrawing(const Canvas: TCanvas);
begin

end;

procedure TProgressCell.DrawCell(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
  const State: TGridDrawStates);
var
  R: TRectF;
  ClampValue: Double;
  LOpacity: Single;
  S: string;
begin
  if (FColumn <> nil) and (FColumn.Max > FColumn.Min) and (Indicator <> nil) and (Bounds.Width > 1) and
    not Value.IsEmpty and not Value.IsObject then
  begin
    R := Bounds;
    if Value.IsOrdinal then
      ClampValue := Value.AsOrdinal
    else if not Value.TryAsType<Double>(ClampValue) then
    begin
      if Value.TryAsType<string>(S) then
      begin
        S := Trim(S);
        S := S.Replace('.', FormatSettings.DecimalSeparator);
        S := S.Replace(',', FormatSettings.DecimalSeparator);
        if not TryStrToFloat(S, ClampValue) then
          Exit;
      end
      else
        Exit;
    end;
    ClampValue := EnsureRange(ClampValue, FColumn.Min, FColumn.Max);
    LOpacity := FColumn.AbsoluteOpacity;
    if not Enabled then
      LOpacity := LOpacity * DisabledOpacity;
    if Background <> nil then
      Background.DrawToCanvas(Canvas, R, LOpacity);
    R.Width := ((ClampValue - FColumn.Min) / (FColumn.Max - FColumn.Min)) * R.Width;
    Indicator.DrawToCanvas(Canvas, R, LOpacity);
  end;
end;
{$ENDREGION}

{$REGION 'TCheckCell'}

type
  TCheckCell = class(TCheckBox, IDrawableCell, ICellControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
    [Weak] FColumn: TCheckColumn;
    FChanging: Boolean;
    FLayout: TControl;
    FOldAlign: TAlignLayout;
    procedure BeforeDrawing(const Canvas: TCanvas);
    procedure AfterDrawing(const Canvas: TCanvas);
    procedure DrawCell(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
      const State: TGridDrawStates);
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
  protected

    procedure DoExit; override;
    procedure ChangeProc(Sender: TObject);
    procedure KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
    procedure SetData(const Value: TValue); override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetDefaultStyleLookupName: string; override;
    function GetData: TValue; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TCheckCell }

constructor TCheckCell.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
  OnChange := ChangeProc;
end;

function TCheckCell.GetColumn: TColumn;
begin
  Result := FColumn;
end;

function TCheckCell.GetDefaultStyleLookupName: string;
begin
  Result := TCheckColumn.StrStyleName;
end;

procedure TCheckCell.SetColumn(const Value: TColumn);
begin
  ValidateInheritance(Value, TCheckColumn, True);
  FColumn := TCheckColumn(Value);
end;

function TCheckCell.GetData: TValue;
begin
  Result := IsChecked;
end;

procedure TCheckCell.ChangeProc(Sender: TObject);
var
  LData: TValue;
  BoolValue: Boolean;
begin
  if not FChanging and (FColumn <> nil) and FColumn.CanEdit and not FColumn.ReadOnly then
  begin
    FChanging := True;
    try
      FColumn.EditorModified;
      FColumn.EditingDone(Self, FStyledGrid.GetInplaceEditorValue(Self), True);
      LData := FColumn.Model.GetValue(FColumn.Model.Col, FColumn.Model.Row, True);
      if FColumn.TryGetAsBoolean(LData, BoolValue) then
      begin
        IsChecked := BoolValue;
        LData := BoolValue;
      end;
      FColumn.RefreshEditor(Self, LData);
    finally
      FChanging := False;
    end;
  end;
end;

procedure TCheckCell.DoExit;
begin
  inherited;
  if FColumn <> nil then
    FColumn.Model.HideEditor(True);
end;

procedure TCheckCell.AfterDrawing(const Canvas: TCanvas);
begin

end;

procedure TCheckCell.BeforeDrawing(const Canvas: TCanvas);
begin

end;

procedure TCheckCell.DrawCell(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
  const State: TGridDrawStates);
var
  ImgRect: TRectF;
  BoolValue: Boolean;
  LOpacity: Single;
  Bitmap: TBitmap;
  Scale: Single;
begin
  if not Value.IsEmpty and (FColumn <> nil) and FColumn.TryGetAsBoolean(Value, BoolValue) and
    (Bounds.Width > 1) and (Bounds.Height > 1) and (FStyledGrid.Bitmaps[BoolValue] <> nil) then
  begin
    Bitmap := FStyledGrid.Bitmaps[BoolValue];
    Scale := Scene.GetSceneScale;
    LOpacity := AbsoluteOpacity;
    if not Enabled then
      LOpacity := LOpacity * DisabledOpacity;
    ImgRect := TRectF.Create(0, 0, Bitmap.Width / Scale, Bitmap.Height / Scale);
    ImgRect := FColumn.RectPlaceIntoBounds(ImgRect, Bounds);
    Canvas.DrawBitmap(Bitmap, Bitmap.BoundsF, ImgRect, LOpacity, True);
  end;
end;

procedure TCheckCell.ApplyStyle;
var
  Background: TControl;
begin
  inherited;
  if FindStyleResource<TControl>(StrBackground, Background) and (Background.ParentControl <> ResourceControl) then
  begin
    FLayout := Background.ParentControl;
    FOldAlign := FLayout.Align;
    FLayout.Align := TAlignLayout.Center;
  end;
end;

procedure TCheckCell.FreeStyle;
begin
  inherited;
  if FLayout <> nil then
  begin
    FLayout.Align := FOldAlign;
    FLayout := nil;
  end;
end;

procedure TCheckCell.KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (KeyChar = #0) and (Key in [vkLeft, vkRight, vkUp, vkDown, vkPrior, vkNext]) and (FColumn.Model <> nil) then
  begin
    FStyledGrid.PerformKeyDown(Key, KeyChar, Shift);
    Key := 0;
  end;
  inherited;
end;

procedure TCheckCell.SetData(const Value: TValue);
var
  B: Boolean;
begin
  if FColumn <> nil then
  begin
    FColumn.TryGetAsBoolean(Value, B);
    IsChecked := B;
  end
  else
    IsChecked := not Value.IsEmpty;
end;

{$ENDREGION}

{$REGION 'TDateCell'}

type
  TDateCell = class(TCustomDateEdit, ICellControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
    [Weak] FColumn: TDateColumn;
    FContent: TControl;
    FBackground: TControl;
    FOldValue: TValue;
    FOldMargins: TRectF;
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
    procedure ChangeProc(Sender: TObject);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetDefaultStyleLookupName: string; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TDateCell }

constructor TDateCell.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
  OnChange := ChangeProc;
end;

function TDateCell.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TDateCell.SetColumn(const Value: TColumn);
begin
  inherited;
  ValidateInheritance(Value, TDateColumn, True);
  FColumn := TDateColumn(Value);
  if FColumn <> nil then
  begin
    ShowClearButton := FColumn.ShowClearButton;
    Format := FColumn.Format;
  end;
end;

procedure TDateCell.DoExit;
begin
  inherited;
  if FColumn <> nil then
    FColumn.Model.HideEditor;
end;

procedure TDateCell.KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (FColumn <> nil) and ([ssCtrl, ssAlt, ssShift, ssCommand] * Shift <> []) and (KeyChar = #0) and
    (Key in [vkLeft, vkRight, vkUp, vkDown, vkPrior, vkNext]) and (FColumn.Model <> nil) then
  begin
    FStyledGrid.PerformKeyDown(Key, KeyChar, Shift);
    Key := 0;
  end;
  inherited;
end;

procedure TDateCell.ApplyStyle;
begin
  inherited;
  if (FColumn <> nil) and (FindStyleResource<TControl>(StrText, FContent) or
    FindStyleResource<TControl>(StrContent, FContent)) then
  begin
    FOldMargins := FContent.Margins.Rect;
    FContent.Margins.Rect := FColumn.Padding.Rect;
  end;
  if FindStyleResource<TControl>(StrBackground, FBackground) then
    FBackground.Visible := False;
end;

procedure TDateCell.FreeStyle;
begin
  inherited;
  if FContent <> nil then
  begin
    FContent.Margins.Rect := FOldMargins;
    FContent := nil;
  end;
  if FBackground <> nil then
  begin
    FBackground.Visible := True;
    FBackground := nil;
  end;
end;

function TDateCell.GetData: TValue;
begin
  if IsEmpty then
    Result := TValue.Empty
  else
    Result := TValue.From<TDate>(Date);
end;

procedure TDateCell.SetData(const Value: TValue);
var
  LDate: TDateTime;
begin
  FOldValue := Value;
  if Value.IsEmpty then
    IsEmpty := True
  else if Value.TryAsType<TDateTime>(LDate) then
  begin
    IsEmpty := False;
    DateTime := LDate
  end
  else
    inherited;
end;

function TDateCell.GetDefaultStyleLookupName: string;
begin
  Result := StrDateeditstyle;
end;

procedure TDateCell.ChangeProc(Sender: TObject);
begin
  if FColumn <> nil then
    FColumn.EditorModified;
end;

{$ENDREGION}

{$REGION 'TTimeCell'}

type
  TTimeCell = class(TCustomTimeEdit, ICellControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
    [Weak] FColumn: TTimeColumn;
    FContent: TControl;
    FBackground: TControl;
    FOldValue: TValue;
    FOldMargins: TRectF;
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
    procedure ChangeProc(Sender: TObject);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetDefaultStyleLookupName: string; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoExit; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TTimeCell }

constructor TTimeCell.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
  OnChange := ChangeProc;
end;

function TTimeCell.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TTimeCell.SetColumn(const Value: TColumn);
begin
  inherited;
  ValidateInheritance(Value, TTimeColumn, True);
  FColumn := TTimeColumn(Value);
  if FColumn <> nil then
  begin
    ShowClearButton := FColumn.ShowClearButton;
    Format := FColumn.Format;
  end;
end;

procedure TTimeCell.DoExit;
begin
  inherited;
  if FColumn <> nil then
    FColumn.Model.HideEditor;
end;

procedure TTimeCell.ApplyStyle;
begin
  inherited;
  if (FColumn <> nil) and (FindStyleResource<TControl>(StrText, FContent) or
    FindStyleResource<TControl>(StrContent, FContent)) then
  begin
    FOldMargins := FContent.Margins.Rect;
    FContent.Margins.Rect := FColumn.Padding.Rect;
  end;
  if FindStyleResource<TControl>(StrBackground, FBackground) then
    FBackground.Visible := False;
end;

procedure TTimeCell.FreeStyle;
begin
  inherited;
  if FContent <> nil then
  begin
    FContent.Margins.Rect := FOldMargins;
    FContent := nil;
  end;
  if FBackground <> nil then
  begin
    FBackground.Visible := True;
    FBackground := nil;
  end;
end;

function TTimeCell.GetData: TValue;
begin
  if IsEmpty then
    Result := TValue.Empty
  else
    Result := TValue.From<TTime>(Time);
end;

procedure TTimeCell.SetData(const Value: TValue);
var
  LTime: TDateTime;
begin
  FOldValue := Value;
  if Value.IsEmpty then
    IsEmpty := True
  else if Value.TryAsType<TDateTime>(LTime) then
  begin
    IsEmpty := False;
    DateTime := LTime;
  end
  else
    inherited;
end;

function TTimeCell.GetDefaultStyleLookupName: string;
begin
  Result := StrTimeeditstyle;
end;

procedure TTimeCell.ChangeProc(Sender: TObject);
begin
  if FColumn <> nil then
    FColumn.EditorModified;
end;

{$ENDREGION}

{$REGION 'TPopupCell'}

type
  TPopupCell = class(TPopupBox, ICellControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
    [Weak] FColumn: TPopupColumn;
    FContent: TControl;
    FUsingIndex: Boolean;
    FOldValue: TValue;
    FInSetData: Boolean;
    FOldMargins: TRectF;
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
    procedure ChangeProc(Sender: TObject);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetDefaultStyleLookupName: string; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoExit; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TPopupCell }

constructor TPopupCell.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
  OnChange := ChangeProc;
end;

function TPopupCell.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TPopupCell.SetColumn(const Value: TColumn);
begin
  ValidateInheritance(Value, TPopupColumn, True);
  FColumn := TPopupColumn(Value);
  if FColumn <> nil then
    Items.Assign(FColumn.Items)
  else
    Items.Clear;
end;

procedure TPopupCell.DoExit;
begin
  inherited;
  if FColumn <> nil then
    FColumn.Model.HideEditor;
end;

procedure TPopupCell.ApplyStyle;
begin
  inherited;
  if (FColumn <> nil) and (FindStyleResource<TControl>(StrText, FContent) or
    FindStyleResource<TControl>(StrContent, FContent)) then
  begin
    FOldMargins := FContent.Margins.Rect;
    FContent.Margins.Rect := FColumn.Padding.Rect;
  end;
end;

procedure TPopupCell.FreeStyle;
begin
  inherited;
  if FContent <> nil then
  begin
    FContent.Margins.Rect := FOldMargins;
    FContent := nil;
  end;
end;

procedure TPopupCell.SetData(const Value: TValue);
var
  S: string;
  LIndex: Integer;
begin
  if not FInSetData then
    try
      FInSetData := True;
      FOldValue := Value;
      FUsingIndex := FOldValue.IsOrdinal and not FOldValue.IsEmpty;
      if FOldValue.IsEmpty then
        ItemIndex := -1
      else if FUsingIndex then
        ItemIndex := FOldValue.AsOrdinal
      else if FOldValue.TryAsType<string>(S) then
      begin
        LIndex := Items.IndexOf(Value.ToString);
        if LIndex >= 0 then
          ItemIndex := LIndex
        else
          Text := S;
      end
      else
        inherited;
    finally
      FInSetData := False;
    end;
end;

function TPopupCell.GetData: TValue;
begin
  if ItemIndex = -1 then
    Result := FOldValue
  else if FUsingIndex then
    Result := ItemIndex
  else
    Result := Items[ItemIndex];
end;

function TPopupCell.GetDefaultStyleLookupName: string;
begin
  Result := StrPopupcellstyle;
end;

procedure TPopupCell.ChangeProc(Sender: TObject);
begin
  if FColumn <> nil then
    FColumn.EditorModified;
end;

{$ENDREGION}

{$REGION 'TImageCell'}

type
  TImageCell = class(TImageControl, IDrawableCell, ICellControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
    [Weak] FColumn: TImageColumn;
    FBitmap: TBitmap;
    FContent: TControl;
    FBrowseMode: Boolean;
    FOldMargins: TRectF;
    procedure BeforeDrawing(const Canvas: TCanvas);
    procedure AfterDrawing(const Canvas: TCanvas);
    procedure DrawCell(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
      const State: TGridDrawStates);
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
    procedure ChangeProc(Sender: TObject);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetDefaultStyleLookupName: string; override;
    procedure DoExit; override;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TImageCell }

constructor TImageCell.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
  OnChange := ChangeProc;
end;

destructor TImageCell.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

function TImageCell.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TImageCell.SetColumn(const Value: TColumn);
begin
  inherited;
  ValidateInheritance(Value, TImageColumn, True);
  FColumn := TImageColumn(Value);
end;

procedure TImageCell.Click;
begin
  if not FBrowseMode then
  begin
    FBrowseMode := True;
    try
      inherited;
      if FColumn.PresentedControl <> nil then
        FColumn.PresentedControl.SetFocus;
      SetFocus;
    finally
      FBrowseMode := False;
    end;
  end;
end;

procedure TImageCell.DoExit;
begin
  inherited;
  if not FBrowseMode then
    FColumn.Model.HideEditor;
end;

procedure TImageCell.AfterDrawing(const Canvas: TCanvas);
begin

end;

function TImageCell.GetDefaultStyleLookupName: string;
begin
  Result := StrImagecellstyle;
end;

procedure TImageCell.ApplyStyle;
begin
  inherited;
  if (FColumn <> nil) and FindStyleResource<TControl>(StrImage, FContent) then
  begin
    FOldMargins := FContent.Margins.Rect;
    FContent.Margins.Rect := FColumn.Padding.Rect;
  end;
end;

procedure TImageCell.FreeStyle;
begin
  inherited;
  if FContent <> nil then
  begin
    FContent.Margins.Rect := FOldMargins;
    FContent := nil;
  end;
end;

procedure TImageCell.BeforeDrawing(const Canvas: TCanvas);
begin

end;

procedure TImageCell.DrawCell(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
  const State: TGridDrawStates);
var
  R: TRectF;
  LOpacity: Single;
  LBitmap: TBitmap;
begin
  if Value.IsType<TPersistent> and (Bounds.Width > 1) and (Bounds.Height > 0) then
  begin
    if Value.IsType<TBitmap> then
      LBitmap := Value.AsType<TBitmap>
    else
    begin
      if FBitmap = nil then
        FBitmap := TBitmap.Create;
      FBitmap.Assign(TPersistent(Value.AsObject));
      LBitmap := FBitmap;
    end;
    if (LBitmap = nil) or (LBitmap.IsEmpty) then
      Exit;

    R := LBitmap.BoundsF.PlaceInto(Bounds).SnapToPixel(Scene.GetSceneScale, False);
    LOpacity := AbsoluteOpacity;
    if not Enabled then
      LOpacity := LOpacity * DisabledOpacity;
    Canvas.DrawBitmap(LBitmap, LBitmap.BoundsF, R, LOpacity, False);
  end
end;

procedure TImageCell.ChangeProc(Sender: TObject);
begin
  if FColumn <> nil then
    FColumn.EditorModified;
end;

{$ENDREGION}

{$REGION 'TCurrencyCell'}

type

  TCurrencyTextSettings = class(TTextSettingsInfo.TCustomTextSettings)
  protected
    procedure DoChanged; override;
  end;

  TCurrencyModel = class(TNumberBoxModel)
  protected
    function GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass; override;
  end;

{ TCurrencyTextSettings }

procedure TCurrencyTextSettings.DoChanged;
begin
  HorzAlign := TTextAlign.Trailing;
  inherited;
end;

{ TCurrencyModel }

function TCurrencyModel.GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass;
begin
  Result := TCurrencyTextSettings;
end;

type

  TCurrencyCell = class(TNumberBox, ICellControl)
  private
    [Weak] FStyledGrid: TStyledGrid;
    [Weak] FColumn: TCurrencyColumn;
    FContent: TControl;
    FBackground: TControl;
    FOldMargins: TRectF;
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
    procedure ChangeProc(Sender: TObject);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetDefaultStyleLookupName: string; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
    function DefineModelClass: TDataModelClass; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

constructor TCurrencyCell.Create(AOwner: TComponent);
begin
  ValidateInheritance(AOwner, TStyledGrid, False);
  inherited;
  FStyledGrid := TStyledGrid(AOwner);
  ValueType := TNumValueType.Float;
  Min := -MaxInt;
  Max := MaxInt;
  OnChangeTracking := ChangeProc;
end;

procedure TCurrencyCell.ApplyStyle;
begin
  inherited;
  if (FColumn <> nil) and (FindStyleResource<TControl>(StrText, FContent) or
    FindStyleResource<TControl>(StrContent, FContent)) then
  begin
    FOldMargins := FContent.Margins.Rect;
    FContent.Margins.Rect := FColumn.Padding.Rect;
  end;
  if FindStyleResource<TControl>(StrBackground, FBackground) then
    FBackground.Visible := False;
end;

procedure TCurrencyCell.FreeStyle;
begin
  inherited;
  if FContent <> nil then
  begin
    FContent.Margins.Rect := FOldMargins;
    FContent := nil;
  end;
  if FBackground <> nil then
  begin
    FBackground.Visible := True;
    FBackground := nil;
  end;
end;

function TCurrencyCell.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TCurrencyCell.SetColumn(const Value: TColumn);
begin
  ValidateInheritance(Value, TCurrencyColumn, True);
  FColumn := TCurrencyColumn(Value);
  if FColumn <> nil then
    DecimalDigits := FColumn.DecimalDigits;
end;

function TCurrencyCell.GetData: TValue;
begin
  Result := inherited;
  if not Result.IsEmpty then
  begin
    Result := TValue.From<Double>(inherited.AsExtended);
  end;
end;

procedure TCurrencyCell.SetData(const Value: TValue);
  procedure DoClear;
  begin
    if IsNan(ValueRange.Min) then
      ValueRange.Value := 0
    else
      ValueRange.Value := System.Math.Max(0, ValueRange.Min);
    Text := '';
  end;
var
  S: string;
  E: Double;
begin
  if Value.IsEmpty then
    DoClear
  else if (Value.Kind in [tkInteger, tkInt64]) then
    ValueRange.Value := Value.AsInt64
  else if (Value.Kind = tkFloat) then
    ValueRange.Value := Value.AsExtended
  else if Value.TryAsType<string>(S) then
  begin
    S := S.Trim;
    if S.IsEmpty then
      DoClear
    else
    begin
      S := S.Replace('.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
      S := S.Replace(',', FormatSettings.DecimalSeparator, [rfReplaceAll]);
      if TryStrToFloat(S, E) then
        ValueRange.Value := E
      else
        DoClear;
    end;
  end
  else
    inherited;
end;

function TCurrencyCell.DefineModelClass: TDataModelClass;
begin
  Result := TCurrencyModel;
end;

procedure TCurrencyCell.DoExit;
begin
  inherited;
  if FColumn <> nil then
    FColumn.Model.HideEditor;
end;

function TCurrencyCell.GetDefaultStyleLookupName: string;
begin
  Result := StrNumberBoxstyle;
end;

procedure TCurrencyCell.KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  ColChange, RowChange: Boolean;
begin
  ColChange := ([ssAlt, ssCommand] * Shift <> []) and (Key in [vkLeft, vkRight]);
  RowChange := Key in [vkUp, vkDown, vkPrior, vkNext];
  if (KeyChar = #0) and (ColChange or RowChange) then
  begin
    FStyledGrid.PerformKeyDown(Key, KeyChar, Shift);
    Key := 0;
  end
  else if (Key = 0) and (KeyChar <> #0) and (FColumn <> nil) and not FColumn.ValidChar(KeyChar) then
    KeyChar := #0;
  inherited;
end;

procedure TCurrencyCell.ChangeProc(Sender: TObject);
begin
  if FColumn <> nil then
    FColumn.EditorModified;
end;

{$ENDREGION}

{$REGION 'TGridHeaderItem'}

{$REGION 'TGlyphCell'}

type

  TGlyphCell = class(TFmxObject, IDrawableCell, ICellControl)
  private
    [Weak] FColumn: TGlyphColumn;
    [Weak] FImages: TCustomImageList;
    { IDrawableCell }
    procedure BeforeDrawing(const Canvas: TCanvas);
    procedure AfterDrawing(const Canvas: TCanvas);
    procedure DrawCell(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
      const State: TGridDrawStates);
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
  end;

{ TGlyphCell }

procedure TGlyphCell.AfterDrawing(const Canvas: TCanvas);
begin
  FImages := nil;
end;

procedure TGlyphCell.BeforeDrawing(const Canvas: TCanvas);
begin
  if (FColumn <> nil) and (FColumn.GlyphInterface <> nil) and (FColumn.GlyphInterface.Images is TCustomImageList) then
    FImages := TCustomImageList(FColumn.GlyphInterface.Images)
  else
    FImages := nil;
end;

procedure TGlyphCell.DrawCell(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
  const State: TGridDrawStates);
var
  I: TImageIndex;
  LOpacity: Single;
  ImgRect: TRectF;
begin
  if (FImages <> nil) and (Canvas.Scale > 0) then
  begin
    LOpacity := FColumn.AbsoluteOpacity;
    if not FColumn.Enabled then
      LOpacity := LOpacity * FColumn.DefaultDisabledOpacity;
    I := FColumn.GetImageIndex(Value);
    ImgRect := FColumn.GlyphPlaceIntoBounds(I, Bounds, Canvas.Scale);
    FImages.Draw(Canvas, ImgRect, I, LOpacity);
  end;
end;

function TGlyphCell.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TGlyphCell.SetColumn(const Value: TColumn);
begin
  ValidateInheritance(Value, TGlyphColumn, True);
  FColumn := TGlyphColumn(Value);
end;

{$ENDREGION}

constructor TGridHeaderItem.Create(AOwner: TComponent);
begin
  inherited;
  if AOwner is TStyledGrid then
    FStyledGrid := TStyledGrid(AOwner);
  Locked := True;
  Stored := False;
end;

procedure TGridHeaderItem.Resize;
var
  I, Delta: Integer;
  Offset, LWidth: Single;
  OldDisableAlign: Boolean;
begin
  if not FResize then
  begin
    FResize := True;
    try
      if (Column <> nil) and (Grid <> nil) and ([TGridPart.Header, TGridPart.Columns] * Grid.FUpdating = []) then
      begin
        OldDisableAlign := TOpenControl(Column).FDisableAlign;
        TOpenControl(Column).FDisableAlign := True;
        try
          LWidth := Max(TStyledGrid.MinSize, Width);
          Offset := LWidth - Column.Width;
          Grid.UpdateHeaderOffset;
          Column.Width := Column.Width + Offset;
          I := Grid.Model.IndexOfColumn(Column);
          if (I >= 0) and (I < Length(Grid.FColInfo)) then
          begin
            Delta := Ceil(Column.Width) - Grid.FColInfo[I].Width;
            Grid.FColInfo[I].Width := Grid.FColInfo[I].Width + Delta;
          end
          else
            Delta := Round(Offset);
          Inc(I);
          while I < Grid.ColumnCount do
          begin
            if I < Length(Grid.FColInfo) then
              Inc(Grid.FColInfo[I].Left, Delta);
            Grid.Columns[I].Position.X := Grid.Columns[I].Position.X + Delta;
            Inc(I);
          end;
          if Grid.ColumnCount < Length(Grid.FColInfo) then
            Inc(Grid.FColInfo[Grid.ColumnCount].Left, Delta);
          for I := 0 to Header.Count - 1 do
            Grid.UpdateItemRect(Grid.Model.IndexOfColumn(TGridHeaderItem(Header.Items[I]).Column), I);
          inherited;
          Grid.UpdateSelection;
          Grid.InvalidateContentSize;
          Grid.Repaint;
        finally
          TOpenControl(Column).FDisableAlign := OldDisableAlign;
        end;
      end;
    finally
      FResize := False;
    end;
  end;
end;

procedure TGridHeaderItem.Resizing;
begin
  if (Column <> nil) and (Grid <> nil) then
    Grid.FUpdating := Grid.FUpdating + [TGridPart.HeaderItemSize];
  inherited;
end;

procedure TGridHeaderItem.Resized;
begin
  if (Column <> nil) and (Grid <> nil) then
  begin
    Grid.FUpdating := Grid.FUpdating - [TGridPart.HeaderItemSize];
    if [TGridPart.Header, TGridPart.Columns] * Grid.FUpdating = [] then
      Grid.UpdateContent;
  end;
  inherited;
end;

procedure TGridHeaderItem.Click;
begin
  inherited;
  if (Column <> nil) and (Grid <> nil) and (Grid.Model <> nil) and (TGridOption.HeaderClick in Grid.Model.Options) and
    Assigned(Grid.Model.OnHeaderClick) then
    Grid.Model.OnHeaderClick(Column);
end;

function TGridHeaderItem.GetDefaultStyleLookupName: string;
begin
  Result := StrHeaderitemstyle;
end;

procedure TGridHeaderItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FColumn) then
    FColumn := nil;
end;

function TGridHeaderItem.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TGridHeaderItem.SetColumn(const Value: TColumn);
begin
  if FColumn <> Value then
  begin
    if FColumn <> nil then
      TComponent(FColumn).RemoveFreeNotification(self);
    FColumn := Value;
    if FColumn <> nil then
      TComponent(FColumn).FreeNotification(self);
  end;
end;

{$ENDREGION}

{ TStyledGrid }

constructor TStyledGrid.Create(AOwner: TComponent);
var
  DeviceService: IFMXDeviceService;
begin
  inherited;
  FCellControl := CreateDefaulCell;
  FCellControl.Stored := False;
  FCellControl.DisableDisappear := True;
  FCellControl.Locked := True;
  FCellControl.SetBounds(-1, -1, 1, 1);
  FCellControl.HitTest := False;
  FCellControl.Parent := Self;
  if SupportsPlatformService(IFMXDeviceService, DeviceService) then
    FHasTouchScreen := TDeviceFeature.HasTouchScreen in DeviceService.GetFeatures;
  FOddFill := TBrush.Create(TBrushKind.Solid, AlternatingBackgroundColor);
  FLineFill := TBrush.Create(TBrushKind.Solid, LineColor);
  FEditorBackground := TBrush.Create(TBrushKind.Solid, TAlphaColorRec.Null);
  FEditorLineFill := TBrush.Create(TBrushKind.Solid, LineColor);
  InvalidateContentSize;
end;

destructor TStyledGrid.Destroy;
begin
  FEditorLineFill.Free;
  FEditorBackground.Free;
  FOddFill.Free;
  FLineFill.Free;
  FSelectionClone.Free;
  FFocusClone.Free;
  FreeAndNil(FCellControl);
  FreeAndNil(FInplaceEdit);
  FreeStyledBitmaps;
  inherited;
end;

procedure TStyledGrid.BeforeDestruction;
begin
  inherited;
  Content.OnGetClipRect := nil;
  Content.OnResize := nil;
  Content.OnPainting := nil;
end;

function TStyledGrid.CreateDefaulCell: TStyledControl;
begin
  Result := TCellText.Create(self);
end;

function TStyledGrid.CanEdit: Boolean;
var
  ColVisible, RowVisible: Boolean;
begin
  Result := Visible and Model.Enabled and (TGridOption.Editing in Model.Options);
  if Result then
  begin
    ColVisible := (Model.Col >= 0) and (Model.Col < Model.ColumnCount) and Columns[Model.Col].Visible and
      (Columns[Model.Col].Width > 0);
    RowVisible := (Model.Row >= 0) and (Model.Row < Model.RowCount);
    Result := ColVisible and RowVisible and Columns[Model.Col].Enabled and Columns[Model.Col].CanEdit;
  end;
end;

function TStyledGrid.CellRect(const ACol, ARow: Integer): TRect;
var
  I, X, Y: Integer;
  HiddenFound: Boolean;
begin
  if (ACol < 0) or (ACol > ColumnCount) then
    raise EArgumentOutOfRangeException.CreateResFmt(@SInvalidColumnIndex, [ACol]);
  if (ARow < 0) or (ARow > RowCount) then
    raise EArgumentOutOfRangeException.CreateResFmt(@SInvalidRowIndex, [ARow]);

  HiddenFound := False;
  X := 0;
  if Length(FColInfo) <> ColumnCount + 1 then
  begin
    SetLength(FColInfo, ColumnCount + 1);
    for I := 0 to ColumnCount - 1 do
    begin
      if HiddenFound then
        FColInfo[I].Left := X + ColumnThickness
      else
        FColInfo[I].Left := X;

      if Columns[I].EffectiveVisible then
        FColInfo[I].Width := Ceil(Columns[I].Width)
      else
        FColInfo[I].Width := 0;

      if Columns[I].EffectiveVisible then
      begin
        if Columns[I].Width > 0 then
        begin
          if HiddenFound then
          begin
            Inc(X, ColumnThickness);
            HiddenFound := False;
          end;
          Inc(X, ColumnThickness);
          Inc(X, Ceil(Columns[I].Width));
        end
        else
          HiddenFound := True;
      end;
    end;
    FColInfo[ColumnCount].Width := 0;
    if HiddenFound then
      FColInfo[ColumnCount].Left := X + ColumnThickness
    else
      FColInfo[ColumnCount].Left := X;
  end;
  Result.Left := FColInfo[ACol].Left;
  Result.Right := FColInfo[ACol].Left + FColInfo[ACol].Width;

  Y := 0;
  Inc(Y, ARow * (RowHeight + RowThickness));
  Result.Top := Y;
  Result.Bottom := Y;
  if ARow < RowCount then
    Inc(Result.Bottom, RowHeight);
end;

procedure TStyledGrid.UpdateHeaderOptions;
var
  I: Integer;
begin
  if FHeader <> nil then
  begin
    FHeader.Visible := TGridOption.Header in Model.Options;
    FHeader.DragReorder := TGridOption.ColumnMove in Model.Options;
    FHeader.Sizing := TGridOption.ColumnResize in Model.Options;
    for I := 0 to HeaderItemCount - 1 do
      HeaderItem[I].HitTest := HitTestOptions * Model.Options <> [];
  end;
end;

procedure TStyledGrid.UpdateContent;
var
  R: TRect;
  LContentSize: TSize;
  I: Integer;
  LSize: TSizeF;
begin
  if [TGridPart.Content, TGridPart.HeaderItemSize] * FUpdating = [] then
  begin
    FUpdating := FUpdating + [TGridPart.Content];
    try
      UpdateHeaderOptions;
      if (ColumnCount > 0) and (RowCount > 0) then
      begin
        R := CellRect(ColumnCount - 1, RowCount - 1);
        LContentSize.cx := R.Right;
        LContentSize.cy := R.Bottom;
        if not FVKRect.IsEmpty and (ContentLayout <> nil) then
        begin
          if (Model.Row >= 0) and (Model.Row < RowCount) then
          begin
            R := CellRect(ColumnCount - 1, Model.Row);
            LContentSize.cy := Max(LContentSize.cy, Round(ContentLayout.Height) + R.Top);
          end;
          if (Model.Col >= 0) and (Model.Col < ColumnCount) then
          begin
            R := CellRect(Model.Col, RowCount - 1);
            LContentSize.cx := Max(LContentSize.cx, Round(ContentLayout.Width) + R.Left);
          end;
        end;
      end
      else
        LContentSize := TSize.Create(0, 0);
      if Model <> nil then
        for I := 0 to ColumnCount - 1 do
          Columns[I].HitTest := False;
      if (LContentSize <> FContentSize) or ((FHeader <> nil) and (FOldHeaderVisible <> FHeader.Visible)) then
      begin
        if FHeader <> nil then
          FOldHeaderVisible := FHeader.Visible;
        InvalidateContentSize;
        FContentSize := LContentSize;
        LSize.cx := FContentSize.cx;
        LSize.cy := FContentSize.cy;
        if (FOldHeaderVisible) and (RowThickness = 0) then
          LSize.cy := LSize.cy + 1;
        Model.ContentSize.Size := LSize;
        UpdateColumns;
      end
      else
        if csDesigning in ComponentState then
          UpdateColumns;

      Content.InvalidateRect(WorkRect);
    finally
      FUpdating := FUpdating - [TGridPart.Content];
    end;
    if FOldColLinesVisible <> (TGridOption.ColLines in Model.Options) then
    begin
      FOldColLinesVisible := TGridOption.ColLines in Model.Options;
      UpdateHeader;
    end;
  end;
end;

procedure TStyledGrid.UpdateSelection;
var
  R1, R2: TRect;
  ColVisible, RowVisible, SelectionVisible, FocusVisible: Boolean;
  Obj: TFmxObject;
begin
  Enabled := Model.Enabled;
  if (FSelection <> nil) and ([TGridPart.Selection] * FUpdating = []) then
  begin
    FUpdating := FUpdating + [TGridPart.Selection];
    try
      ColVisible := (Model.Col >= 0) and (Model.Col < Model.ColumnCount) and Model.Columns[Model.Col].EffectiveVisible;
      RowVisible := (Model.Row >= 0) and (Model.Row < Model.RowCount);
      SelectionVisible := RowVisible and (TGridOption.RowSelect in Model.Options);
      if TGridOption.AlwaysShowSelection in Model.Options then
        FocusVisible := ColVisible and RowVisible
      else
        FocusVisible := Enabled and ColVisible and RowVisible and (PresentedControl.IsFocused);
      if FocusVisible and not (EditorMode or (TGridPart.EditorShowing in FUpdating)) then
      begin
        R1 := CellRect(Model.Col, Model.Row);
        if (FFocusClone = nil) and (FFocus <> nil) then
        begin
          Obj := FFocus.Clone(nil);
          if Obj is TControl then
          begin
            FFocusClone := TControl(Obj);
            FFocusClone.Visible := False;
            FFocusClone.Locked := True;
            FFocusClone.HitTest := False;
            FFocusClone.Stored := False;
            FFocusClone.Opacity := DefaultFocusOpacity;
            FFocusClone.Parent := Content;
          end
          else
            Obj.Free;
        end;
        if FFocusClone <> nil then
        begin
          FFocusClone.BoundsRect := TRectF.Create(R1);
          FFocusClone.Visible := True;
        end;
      end
      else
      begin
        if FFocusClone <> nil then
          FFocusClone.Visible := False;
      end;

      if SelectionVisible then
      begin
        R1 := CellRect(0, Model.Row);
        R2 := CellRect(ColumnCount, Model.Row);
        R1.Right := R2.Left;
        if (FSelectionClone = nil) and (FSelection <> nil) then
        begin
          Obj := FSelection.Clone(nil);
          if Obj is TControl then
          begin
            FSelectionClone := TControl(Obj);
            FSelectionClone.Visible := False;
            FSelectionClone.Locked := True;
            FSelectionClone.HitTest := False;
            FSelectionClone.Stored := False;
            FSelectionClone.Parent := Content;
          end
          else
            Obj.Free;
        end;
        if FSelectionClone <> nil then
        begin
          FSelectionClone.BoundsRect := TRectF.Create(R1);
          FSelectionClone.Visible := True;
        end;
      end
      else
      begin
        if FSelectionClone <> nil then
          FSelectionClone.Visible := False;
      end;
      if (FFocusClone <> nil) and FFocusClone.Visible then
        FFocusClone.BringToFront;
      if (FInplaceEdit <> nil) and not (TGridPart.EditorShowing in FUpdating) then
        RefreshEditor(FInplaceEdit, True, False);
    finally
      FUpdating := FUpdating - [TGridPart.Selection];
    end;
  end;
end;

function TStyledGrid.DefineModelClass: TDataModelClass;
begin
  Result := TGridModel;
end;

procedure TStyledGrid.InvalidateContentSize;
begin
  FTopRow := -1;
  FLeftColumn := -1;
  FBottomRow := -1;
  FRightColumn := -1;
  FWorkRect := TRectF.Empty;
  FDefaultRowHeight := 0;
  inherited InvalidateContentSize;
end;

procedure TStyledGrid.FreeStyledBitmaps;
var
  B: Boolean;
begin
  for B := Low(B) to High(B) do
  begin
    FreeAndNil(FStyledBitmaps[B]);
    FreeAndNil(FBitmaps[B]);
  end;
end;

procedure TStyledGrid.UpdateStyledBitmaps;
var
  B: Boolean;
begin
  FreeStyledBitmaps;
  for B := Low(B) to High(B) do
    FStyledBitmaps[B] := TCheckColumn.CreateBitmap(Model, B, False);
end;

procedure TStyledGrid.ApplyStyle;
  procedure LoadBrushes(const Brushes: array of TBrush; const Names: array of string);
  var
    BrushObject: TBrushObject;
    I: Integer;
  begin
    for I := Low(Brushes) to High(Brushes) do
      if FindStyleResource<TBrushObject>(Names[I], BrushObject) then
        Brushes[I].Assign(BrushObject.Brush);
  end;
begin
  inherited;
  FCellControl.ApplyStyleLookup;
  UpdateStyledBitmaps;
  if FindStyleResource<THeader>(StrHeader, FHeader) then
  begin
    FHeader.OnRealignItem := DoRealignItem;
    FHeader.OnDrawItem := DoDrawHeader;
    FHeader.Visible := TGridOption.Header in Model.Options;
    FHeader.Sizing := TGridOption.ColumnResize in Model.Options;
  end;
  if FindStyleResource<TControl>(StrFocus, FFocus) then
    FFocus.Visible := False;
  if FindStyleResource<TControl>(StrSelection, FSelection) then
    FSelection.Visible := False;

  LoadBrushes([FOddFill, FLineFill, FEditorLineFill, FEditorBackground], [StrAlternatingRowBackgr, StrLineFill,
    StrEditorLineFill, StrEditorBackground]);

  UpdateHeader;
  UpdateSelection;
end;

procedure TStyledGrid.FreeStyle;
  procedure AssignColors(const Brushes: array of TBrush; const Colors: array of TAlphaColor);
  var
    I: Integer;
  begin
    for I := Low(Brushes) to High(Brushes) do
    begin
      Brushes[I].Kind := TBrushKind.Solid;
      Brushes[I].Color := Colors[I];
    end;
  end;
begin
  inherited;
  FCellControl.NeedStyleLookup;
  FreeAndNil(FSelectionClone);
  FreeAndNil(FFocusClone);
  if FHeader <> nil then
  begin
    FHeader.OnRealignItem := nil;
    FHeader.OnResizeItem := nil;
    FHeader.OnItemClick := nil;
    FHeader.OnDrawItem := nil;
    FHeader.Visible := True;
    FHeader.Sizing := True;
    FHeader := nil;
  end;
  if FFocus <> nil then
  begin
    FFocus.Visible := True;
    FFocus := nil;
  end;
  if FSelection <> nil then
  begin
    FSelection.Visible := True;
    FSelection := nil;
  end;
  AssignColors([FEditorLineFill, FLineFill, FOddFill, FEditorBackground], [LineColor, LineColor,
    AlternatingBackgroundColor, TAlphaColorRec.Null]);

  FreeStyledBitmaps;
end;

procedure TStyledGrid.DoContentResize(Sender: TObject);
begin
  InvalidateContentSize;
  UpdateColumns;
end;

procedure TStyledGrid.DoGetClipRect(Sender: TObject; var ContentBounds: TRectF);
begin
  ContentBounds := WorkRect;
end;

procedure TStyledGrid.DoCreateCustomEditor(const Column: TColumn; var Control: TStyledControl);
begin
  if Assigned(Model.OnCreateCustomEditor) then
    Model.OnCreateCustomEditor(self, Column, Control);
end;

procedure TStyledGrid.InternalDrawCells(const Canvas: TCanvas; const AFrontLayer: Boolean;
  var NeedEditorBackground: Boolean);

  procedure DrawOddBackground(const APaintRect: TRectF);
  var
    Y: Integer;
    R1, R2: TRect;
    TmpRect: TRectF;
  begin
    Canvas.Stroke.Kind := TBrushKind.None;
    Canvas.Fill.Assign(FOddFill);
    R2 := CellRect(RigthColumn, 0);
    R1.Right := R2.Right;
    for Y := TopRow to BottomRow do
    begin
      R1 := CellRect(0, Y);
      R1.Right := R2.Right;
      TmpRect := TRectF.Create(R1);
      if Odd(Y) and IntersectRect(TmpRect, TmpRect, APaintRect) then
        Canvas.FillRect(TmpRect, 0, 0, AllCorners, AbsoluteOpacity);
    end;
  end;

  procedure PartialDrawing(const PaintCells: Boolean);
  var
    X, Y: Integer;
    LCellRect: TRectF;
    State, BkState: TGridDrawStates;
    CanvasState: TCanvasSaveState;
    Value: TValue;
    DrawableCellEx: IDrawableCellEx;
  begin
    for X := LeftColumn to RigthColumn do
    if (Columns[X].Enabled = AFrontLayer) and Columns[X].EffectiveVisible and (Columns[X].Width > 0) then
    begin
      DrawableCellEx := Columns[X] as IDrawableCellEx;
      CanvasState := Canvas.SaveState;
      try
        LCellRect := TRectF.Union(TRectF.Create(CellRect(X, TopRow)), TRectF.Create(CellRect(X, BottomRow)));
        Canvas.IntersectClipRect(LCellRect);
        DrawableCellEx.BeforeDrawing(Canvas);
        try
          for Y := TopRow to BottomRow do
            if not (EditorMode and (X = Model.Col) and (Y = Model.Row)) and Columns[X].EffectiveVisible and
              (Columns[X].Width > 0) then
            begin
              LCellRect := TRectF.Create(CellRect(X, Y));
              // Here we get the current state of the cell
              State := [];
              if Y = Model.Row then
              begin
                if TGridOption.RowSelect in Model.Options then
                  State := State + [TGridDrawState.RowSelected];
                BkState := State;
                if X = Model.Col then
                begin
                  BkState := State + [TGridDrawState.Selected];
                  if Enabled and (PresentedControl <> nil) and PresentedControl.IsFocused then
                    State := State + [TGridDrawState.Focused]
                  else
                    State := State + [TGridDrawState.Selected];
                end;
              end;
              if PaintCells then
              begin
                // Paint disabled columns on down layer, and paint enabled columns on front layer
                if Columns[X].Enabled = AFrontLayer then
                begin
                  Value := Model.GetValue(X, Y, False);
                  LCellRect := Columns[X].Padding.PaddingRect(LCellRect);
                    DrawableCellEx.DrawCell(Canvas, LCellRect, Y, Value, State);
                end;
              end
              else
              begin
                // Draw background
                Value := Model.GetValue(X, Y, False);
                DrawableCellEx.DrawBackground(Canvas, LCellRect, Y, Value, BkState);
              end;
            end;
        finally
          DrawableCellEx.AfterDrawing(Canvas);
        end;
      finally
        Canvas.RestoreState(CanvasState);
      end;
    end;
  end;

  procedure DrawLines(const APaintRect: TRectF; const AContentSize: TSize);
  var
    Point1, Point2: TPointF;
    X, Y: Integer;
    R: TRectF;
    InflateValue: Single;
  begin
    if Canvas.Scale > 0 then
      InflateValue := 1 / (2 * Canvas.Scale)
    else
      InflateValue := 0;
    Canvas.Stroke.Assign(FLineFill);
    if RowThickness > 0 then
    begin
      Canvas.Stroke.Thickness := RowThickness;
      Point2 := TPointF.Create(Min(APaintRect.Right, AContentSize.cx - InflateValue), MaxInt);
      for Y := TopRow to BottomRow + 1 do
      begin
        R := TRectF.Create(CellRect(0, Y));
        R.TopLeft := Canvas.AlignToPixel(R.TopLeft);
        Point1.Y := R.Top - InflateValue;
        Point1.X := R.Left - InflateValue;
        if (Point1.X < Point2.X) and not SameValue(Point1.Y, Point2.Y, InflateValue) then
        begin
          Point2.Y := Point1.Y;
          Canvas.DrawLine(Point1, Point2, AbsoluteOpacity);
        end;
      end;
    end;
    if ColumnThickness > 0 then
    begin
      Canvas.Stroke.Thickness := ColumnThickness;
      Point2 := TPointF.Create(MaxInt, Min(APaintRect.Bottom, AContentSize.cy - InflateValue));
      for X := LeftColumn to RigthColumn + 1 do
      begin
        R := TRectF.Create(CellRect(X, 0));
        R.TopLeft := Canvas.AlignToPixel(R.TopLeft);
        Point1.Y := Max(APaintRect.Top, R.Top - InflateValue);
        Point1.X := R.Left - InflateValue;
        if (Point1.Y < Point2.Y) and (Point1.X <= APaintRect.Right) and not SameValue(Point1.X, Point2.X, InflateValue)
        then
        begin
          Point2.X := Point1.X;
          Canvas.DrawLine(Point1, Point2, AbsoluteOpacity);
        end;
      end;
    end;
  end;

var
  X, Y: Integer;
  LPaintRect: TRectF;
  LContentSize: TSize;
begin
  LPaintRect := PaintRect;
  LContentSize := FContentSize;
  LContentSize.cx := CellRect(ColumnCount, 0).Left;
  LPaintRect.Right := Min(LContentSize.cx, LPaintRect.Right);
  if not AFrontLayer then
  begin
    NeedEditorBackground := False;
    if not Model.IsUpdating then
    begin
      Model.ReduceCache(LeftColumn, TopRow, RigthColumn, BottomRow);
      for Y := TopRow to BottomRow do
        for X := LeftColumn to RigthColumn do
          if Columns[X].EffectiveVisible and (Columns[X].Width > 0) then
          begin
            Model.GetValue(X, Y, False);
            if EditorMode and (X = Model.Col) and (Y = Model.Row) then
              NeedEditorBackground := True;
          end;
    end;
    if TGridOption.AlternatingRowBackground in Model.Options then
      DrawOddBackground(LPaintRect);
    PartialDrawing(False);
  end;
  PartialDrawing(True);
  if AFrontLayer and (RowThickness > 0) or (ColumnThickness > 0) then
    DrawLines(LPaintRect, LContentSize);
end;

procedure TStyledGrid.DoContentPainting(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  procedure DrawSelection(const NeedEditorBackground: Boolean);
  var
    CanvasState: TCanvasSaveState;
  begin
    if ((FSelectionClone <> nil) and IntersectRect(FSelectionClone.BoundsRect, WorkRect)) or
      (FFocusClone <> nil) and IntersectRect(FFocusClone.BoundsRect, WorkRect) then
    begin
      CanvasState := Canvas.SaveState;
      try
        if FSelectionClone <> nil then
        begin
          TOpenControl(FSelectionClone).FDisablePaint := False;
          if FSelectionClone.Visible then
            TOpenControl(FSelectionClone).PaintInternal;
          TOpenControl(FSelectionClone).FDisablePaint := True;
        end;
        if FFocusClone <> nil then
        begin
          TOpenControl(FFocusClone).FDisablePaint := False;
          if not NeedEditorBackground and FFocusClone.Visible then
            TOpenControl(FFocusClone).PaintInternal;
          TOpenControl(FFocusClone).FDisablePaint := True;
        end;
      finally
        Canvas.RestoreState(CanvasState);
      end;
    end;
  end;
  procedure DrawInplaceEditor;
  var
    LEditRect, LCellRect: TRectF;
    CanvasState: TCanvasSaveState;
    BkState: TGridDrawStates;
    InflateValue: Single;
  begin
    LEditRect := GetEditorRect;
    LCellRect := LEditRect;
    LCellRect.TopLeft := Canvas.AlignToPixel(LCellRect.TopLeft);
    LCellRect.BottomRight := Canvas.AlignToPixel(LCellRect.BottomRight);
    if Canvas.Scale > 0 then
      InflateValue := -DefaultThickness / (2 * Canvas.Scale)
    else
      InflateValue := 0;
    LCellRect.Inflate(InflateValue, InflateValue);
    if (FEditorBackground.Kind <> TBrushKind.None) and (FEditorBackground.Color <> TAlphaColorRec.Null) then
    begin
      Canvas.Fill.Assign(FEditorBackground);
      Canvas.FillRect(LCellRect, 0, 0, AllCorners, AbsoluteOpacity);
    end;
    if (FEditorLineFill.Kind <> TBrushKind.None) and (FEditorLineFill.Color <> TAlphaColorRec.Null) then
    begin
      Canvas.Stroke.Assign(FEditorLineFill);
      Canvas.Stroke.Thickness := DefaultThickness;
      Canvas.DrawRect(LCellRect, 0, 0, AllCorners, AbsoluteOpacity);
    end;
    BkState := [TGridDrawState.Focused];
    if TGridOption.RowSelect in Model.Options then
      BkState := BkState + [TGridDrawState.RowSelected];
    (Columns[Model.Col] as IDrawableCellEx).DrawBackground(Canvas, LEditRect, Model.Row,
      Model.GetValue(Model.Col, Model.Row, False), BkState);
    if FInplaceEdit is TControl then
    begin
      TOpenControl(FInplaceEdit).FDisablePaint := False;
      CanvasState := Canvas.SaveState;
      try
        TOpenControl(FInplaceEdit).BoundsRect := LEditRect;
        TOpenControl(FInplaceEdit).PaintInternal;
      finally
        Canvas.RestoreState(CanvasState);
      end;
      TOpenControl(FInplaceEdit).FDisablePaint := True;
    end;
  end;

var
  NeedEditorBackground: Boolean;
  I: Integer;
begin
  if (ColumnCount > 0) and (RowCount > 0) and (RigthColumn >= 0) and (BottomRow >= 0) then
  begin
    if not (csDesigning in ComponentState) then
      for I := 0 to ColumnCount - 1 do
        TOpenControl(Columns[I]).FDisablePaint := True;
    InternalDrawCells(Canvas, False, NeedEditorBackground);
    DrawSelection(NeedEditorBackground);
    InternalDrawCells(Canvas, True, NeedEditorBackground);
    if NeedEditorBackground then
      DrawInplaceEditor;
  end;
end;

procedure TStyledGrid.DoDrawHeader(Sender: TObject; const Canvas: TCanvas; const Item: THeaderItem;
const Bounds: TRectF);
var
  LItem: TGridHeaderItem;
begin
  if (Model <> nil) and Assigned(Model.OnDrawColumnHeader) and (Item is TGridHeaderItem) then
  begin
    LItem := TGridHeaderItem(Item);
    if (LItem.Column <> nil) and (LItem.Column.EffectiveVisible) and (LItem.Column.Width > 0) then
      Model.OnDrawColumnHeader(Model.Owner, Canvas, LItem.Column, Bounds);
  end;
end;

procedure TStyledGrid.DoEnter;
var
  LTimer: TSelectTimer;
  Coord: TGridModel.TCoord;
  TimerActions: TSelectTimer.TTimerActions;
begin
  if ([TGridPart.EditorModeChanging, TGridPart.EditorShowing] * FUpdating = []) and
    (TGridOption.AlwaysShowEditor in Model.Options) then
  begin
    Coord.Col := Model.Col;
    Coord.Row := Model.Row;
    TimerActions := [TSelectTimer.TTimerAction.ShowEditor];
    LTimer := TSelectTimer.Create(self, Coord, TPointF.Zero, ClickTimerProc, TimerActions);
    FUpdating := FUpdating + [TGridPart.EditorShowing];
    LTimer.Interval := 10;
    LTimer.Enabled := True;
  end
  else if not FMouseDown then
    UpdateSelection;
  inherited;
end;

procedure TStyledGrid.DoExit;
begin
  inherited;
  if [TGridPart.EditorModeChanging, TGridPart.EditorShowing] * FUpdating = [] then
    UpdateSelection;
end;

procedure TStyledGrid.DoRealignItem(Sender: TObject; OldIndex, NewIndex: Integer);
begin
  UpdateHeader;
  OldIndex := Model.IndexOfColumn(HeaderItem[OldIndex].Column);
  NewIndex := Model.IndexOfColumn(HeaderItem[NewIndex].Column);
  if (OldIndex >= 0) and (NewIndex >= 0) then
    Model.MoveColumn(OldIndex, NewIndex);
end;

procedure TStyledGrid.MMColumnMoved(var Message: TDispatchMessageWithValue<TGridModel.TColumnIndexes>);
begin
  SetLength(FColInfo, 0);
  InvalidateContentSize;
  UpdateColumns;
  UpdateHeader;
  UpdateSelection;
  if (Model <> nil) and Assigned(Model.OnColumnMoved) then
    Model.OnColumnMoved(Message.Value.Column, Message.Value.FromIndex, Message.Value.ToIndex);
end;

procedure TStyledGrid.DoViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
const ContentSizeChanged: Boolean);
begin
  if FInplaceEdit is TControl then
    TControl(FInplaceEdit).BoundsRect := GetEditorRect;
  if OldViewportPosition <> NewViewportPosition then
  begin
    InvalidateContentSize;
    if not SameValue(OldViewportPosition.X, NewViewportPosition.X, TEpsilon.Position) then
    begin
      TOpenHeader(FHeader).Offset := -NewViewportPosition.X;
      TOpenHeader(FHeader).DoRealign;
    end;
  end;
  inherited;
end;

function TStyledGrid.GetRowHeight: Integer;
var
  TextSettings: ITextSettings;
  LLayout: TTextLayout;
  H, MaxMargin: Single;
  I: Integer;
begin
  Result := Ceil(Model.RowHeight);
  if Result = 0 then
  begin
    if (FDefaultRowHeight = 0) and Supports(PresentedControl, ITextSettings, TextSettings) then
    begin
      LLayout := TTextLayoutManager.DefaultTextLayout.Create(Canvas);
      try
        LLayout.BeginUpdate;
        try
          LLayout.TopLeft := TPointF.Zero;
          LLayout.Text := 'p|bl';
          LLayout.MaxSize := TTextLayout.MaxLayoutSize;
          LLayout.HorizontalAlign := TTextAlign.Leading;
          LLayout.VerticalAlign := TTextAlign.Leading;
          LLayout.Font.Assign(TextSettings.ResultingTextSettings.Font);
          LLayout.Trimming := TTextTrimming.None;
          LLayout.WordWrap := False;
        finally
          LLayout.EndUpdate;
        end;
        H := LLayout.TextHeight;
      finally
        LLayout.Free;
      end;
      MaxMargin := TColumn.VertTextMargin * 2;
      for I := 0 to Model.ColumnCount - 1 do
        MaxMargin := System.Math.Max(MaxMargin, Model.Columns[I].Margins.Top + Model.Columns[I].Margins.Bottom);
      FDefaultRowHeight := Ceil(H + MaxMargin);
    end;
    Result := FDefaultRowHeight;
    if Result = 0 then
      Result := DefaultRowHeight;
  end;
end;

function TStyledGrid.GetColumnThickness: Integer;
begin
  if TGridOption.ColLines in Model.Options then
    Result := DefaultThickness
  else
    Result := 0;
end;

function TStyledGrid.GetRowThickness: Integer;
begin
  if TGridOption.RowLines in Model.Options then
    Result := DefaultThickness
  else
    Result := 0;
end;

function TStyledGrid.GetModel: TGridModel;
begin
  Result := inherited GetModel<TGridModel>;
end;

function TStyledGrid.GetColumnCount: Integer;
begin
  Result := Model.ColumnCount;
end;

function TStyledGrid.GetColumns(const Index: Integer): TColumn;
begin
  Result := Model.Columns[Index];
end;

function TStyledGrid.GetTopRow: Integer;
var
  H: Integer;
begin
  if FTopRow < 0 then
  begin
    if RowCount <= 0 then
      FTopRow := 0
    else
    begin
      H := CellRect(0, 0).Height;
      Inc(H, RowThickness);
      if H > 0 then
        FTopRow := Max(0, Round(WorkRect.Top + RowThickness) div H);
    end;
  end;
  Result := FTopRow;
end;

function TStyledGrid.GetBitmaps(const Index: Boolean): TBitmap;
var
  Height: Integer;
  SrcRect, DstRect: TRectF;
  Scale: Single;
  B: Boolean;
begin
  Scale := Scene.GetSceneScale;
  if not SameValue(Scale, FBitmapsScale, TEpsilon.Scale) then
    UpdateStyledBitmaps;
  FBitmapsScale := Scale;
  Height := Trunc((RowHeight - 2 * DefaultThickness) * Scale);
  if not SameValue(Height, FBitmapsHeight, TEpsilon.Scale) then
  begin
    FBitmapsHeight := Height;
    for B := Low(B) to High(B) do
      FreeAndNil(FBitmaps[B]);
  end;
  if (FBitmaps[Index] = nil) and (FStyledBitmaps[Index] <> nil) then
  begin
    FBitmaps[Index] := TBitmap.Create;
    try
      SrcRect := FStyledBitmaps[Index].BoundsF;
      FBitmaps[Index].SetSize(SrcRect.PlaceInto(TRectF.Create(0, 0, Height, Height)).Round.Size);
      if FBitmaps[Index].Canvas.BeginScene then
      try
        FBitmaps[Index].Canvas.Clear(TAlphaColorRec.Null);
        DstRect := SrcRect.PlaceInto(FBitmaps[Index].BoundsF);
        FBitmaps[Index].Canvas.DrawBitmap(FStyledBitmaps[Index], SrcRect, DstRect, 1, False);
      finally
        FBitmaps[Index].Canvas.EndScene;
      end;
    except
      FreeAndNil(FBitmaps[Index]);
      raise;
    end;
  end;
  Result := FBitmaps[Index];
end;

function TStyledGrid.GetBottomRow: Integer;
var
  H: Integer;
begin
  if FBottomRow < 0 then
  begin
    if (RowCount <= 0) or (WorkRect.Bottom <= RowThickness) then
      FBottomRow := -1
    else
    begin
      H := CellRect(0, 0).Height;
      Inc(H, RowThickness);
      if H > 0 then
        FBottomRow := EnsureRange((Round(WorkRect.Bottom) - RowThickness - 1) div H, 0, RowCount - 1);
    end;
  end;
  Result := FBottomRow;
end;

function TStyledGrid.GetLeftColumn: Integer;
var
  I: Integer;
begin
  if FLeftColumn < 0 then
  begin
    FLeftColumn := ColumnCount;
    for I := 0 to ColumnCount - 1 do
      if CellRect(I, 0).Right >= WorkRect.Left then
      begin
        FLeftColumn := I;
        Break;
      end;
  end;
  Result := FLeftColumn;
end;

function TStyledGrid.GetRighttColumn: Integer;
var
  I: Integer;
begin
  if FRightColumn < 0 then
  begin
    FRightColumn := LeftColumn - 1;
    for I := LeftColumn to ColumnCount - 1 do
      if CellRect(I, 0).Left < WorkRect.Right then
        FRightColumn := I
      else
        Break;
  end;
  Result := FRightColumn;
end;

function TStyledGrid.GetWorkRect: TRectF;
begin
  if FWorkRect.IsEmpty then
  begin
    if ContentLayout <> nil then
      FWorkRect := TRectF.Create(TPointF.Create(ViewportPosition.X, ViewportPosition.Y),
        ContentLayout.Width, ContentLayout.Height)
    else
      FWorkRect := TRectF.Create(TPointF.Create(ViewportPosition.X, ViewportPosition.Y),
        Content.Width, Content.Height);
  end;
  Result := FWorkRect;
end;

function TStyledGrid.GetPaintRect: TRectF;
begin
  Result := GetWorkRect;
  Result.Left := Max(Result.Left, 0);
  Result.Top := Max(Result.Top, 0);
end;

function TStyledGrid.GetRowCount: Integer;
begin
  Result := Model.RowCount;
end;

procedure TStyledGrid.CellByPoint(const X, Y: Single; var ACol, ARow: Integer);
var
  H: Single;
  LPoint: TPointF;
  LRect: TRectF;
  I: Integer;
begin
  LPoint := Content.AbsoluteToLocal(TPointF.Create(X, Y));
  H := RowHeight + RowThickness;
  if H > 0 then
  begin
    ARow := Trunc(LPoint.Y / H);
    if (ARow < 0) or (ARow >= RowCount) then
      ARow := -1;
  end;
  ACol := -1;
  for I := 0 to ColumnCount - 1 do
    if Columns[I].EffectiveVisible then
    begin
      LRect := TRectF.Create(CellRect(I, 0));
      if LRect.Width > 0 then
      begin
        LRect.Inflate(ColumnThickness, 0);
        if LRect.Left <= LPoint.X then
          if LRect.Right > LPoint.X then
          begin
            ACol := I;
            Exit;
          end
          else
            Continue
        else
          Exit;
      end;
    end;
end;

procedure TStyledGrid.PMCellByPoint(var Message: TDispatchMessageWithValue<TGridModel.TPointInfo>);
begin
  Message.Value.Coord.Clear;
  CellByPoint(Message.Value.Point.X, Message.Value.Point.Y, Message.Value.Coord.Col, Message.Value.Coord.Row);
end;

procedure TStyledGrid.MMCellRect(var Message: TDispatchMessageWithValue<TGridModel.TCellInfo>);
begin
  if (Message.Value.Coord.Col >= 0) and (Message.Value.Coord.Row >= 0) and (Message.Value.Coord.Col <= ColumnCount) and
    (Message.Value.Coord.Row <= RowCount) then
    Message.Value.Rect := CellRect(Message.Value.Coord.Col, Message.Value.Coord.Row);
end;

procedure TStyledGrid.MMColumnChanged(var Message: TDispatchMessageWithValue<Integer>);
var
  R: TRect;
  LRect: TRectF;
begin
  if (Message.Value >= 0) and (Message.Value < ColumnCount) then
  begin
    SetLength(FColInfo, 0);
    if (RowCount > 0) and (BottomRow >= TopRow) then
    begin
      R := CellRect(Message.Value, TopRow);
      LRect := TRect.Union(R, CellRect(Message.Value, BottomRow));
      if LRect.IntersectsWith(WorkRect) then
        Content.InvalidateRect(LRect);
    end
    else
      InvalidateRect(LocalRect);
    UpdateHeader;
  end;
end;

procedure TStyledGrid.MMInvalidateCell(var Message: TDispatchMessageWithValue<TGridModel.TCoord>);
var
  R: TRect;
  LRect: TRectF;
begin
  R := CellRect(Message.Value.Col, Message.Value.Row);
  LRect := TRectF.Create(R);
  if LRect.IntersectsWith(WorkRect) then
    Content.InvalidateRect(LRect);
end;

procedure TStyledGrid.MMContentChanged(var Message: TDispatchMessage);
var
  LCol, LRow: Integer;
begin
  if FOldRowCount <> RowCount then
  begin
    if (FOldRowCount = 0) and (Model.Col < 0) then
    begin
      // Select the first available cell after some data have appeared.
      LRow := Model.Row;
      LCol := Model.Col;
      if Model.FindNextCell(False, False, False, LCol, LRow) then
      begin
        Model.SelectCell(LCol, Model.Row);
        FOldRowCount := RowCount;
      end;
    end;
  end;
  UpdateContent;
end;

procedure TStyledGrid.MMEditorMode(var Message: TDispatchMessageWithValue<Boolean>);
begin
  Message.Value := FEditorMode;
end;

procedure TStyledGrid.MMGetEditorValue(var Message: TDispatchMessageWithValue<TValue>);
begin
  Message.Value := GetInplaceEditorValue(FInplaceEdit);
end;

procedure TStyledGrid.PMCreateCellObject(var Message: TDispatchMessageWithValue<TGridModel.TCellObjectInfo>);
var
  LClass: TFmxObjectClass;
  Obj: TFmxObject;
  CellControl: ICellControl;
begin
  LClass := GetCellClass(Message.Value.Column);
  if LClass <> nil then
  begin
    Obj := LClass.Create(Self);
    try
      if Supports(Obj, ICellControl, CellControl) then
        CellControl.Column := Message.Value.Column;
      Obj.Stored := False;
      if Obj is TControl then
        with TControl(Obj) do
          begin
            DisableDisappear := True;
            Locked := True;
            SetBounds(-1, -1, 0, 0);
            HitTest := False;
          end;
      Obj.Parent := Message.Value.Column;
    except
      Obj.DisposeOf;
      raise;
    end;
    Message.Value.CellObject := Obj;
  end
  else
    Message.Value.CellObject := nil;
end;

function TStyledGrid.GetCellClass(const Column: TColumn): TFmxObjectClass;
begin
  Result := nil;
  if Column is TProgressColumn then
    Result := TProgressCell
  else if Column is TCheckColumn then
    Result := TCheckCell
  else if Column is TImageColumn then
    Result := TImageCell
  else if Column is TGlyphColumn then
    Result := TGlyphCell;
end;

function TStyledGrid.GetEditorClass(const Column: TColumn): TFmxObjectClass;
begin
  Result := nil;
  if Column is TProgressColumn then
    Result := TProgressCell
  else if Column is TCheckColumn then
    Result := TCheckCell
  else if Column is TTimeColumn then
    Result := TTimeCell
  else if Column is TDateColumn then
    Result := TDateCell
  else if Column is TPopupColumn then
    Result := TPopupCell
  else if Column is TImageColumn then
    Result := TImageCell
  else if Column is TCurrencyColumn then
    Result := TCurrencyCell;
end;

procedure TStyledGrid.PMGetDisplay_Cells(var Message: TDispatchMessageWithValue<TGridModel.TRectCoord>);
begin
  Message.Value.TopLeft.Clear;
  if TopRow <= BottomRow then
  begin
    Message.Value.TopLeft.Row := TopRow;
    Message.Value.BottomRight.Row := BottomRow;
  end;
  if LeftColumn <= Min(RigthColumn, ColumnCount) then
  begin
    Message.Value.TopLeft.Col := LeftColumn;
    Message.Value.BottomRight.Col := Min(RigthColumn, ColumnCount);
  end;
end;

procedure TStyledGrid.MMGetRowHeight(var Message: TDispatchMessageWithValue<Integer>);
begin
  Message.Value := RowHeight;
end;

procedure TStyledGrid.PMScrollToSelect(var Message: TDispatchMessage);
begin
  ScrollToSelectedCell;
end;

procedure TStyledGrid.MMHideEditor(var Message: TDispatchMessageWithValue<Boolean>);
begin
  HideEditor(Message.Value);
end;

procedure TStyledGrid.MMPostEditorValue(var Message: TDispatchMessage);
begin
  if FInplaceEdit <> nil then
    PostEditorValue;
end;

procedure TStyledGrid.MMRefreshEditorValue(var Message: TDispatchMessage);
begin
  if FInplaceEdit <> nil then
    RefreshEditor(FInplaceEdit, False, True);
end;

procedure TStyledGrid.MMInvalidateContentSize(var Message: TDispatchMessage);
var
  OldDisableAlign: Boolean;
begin
  OldDisableAlign := FDisableAlign;
  try
    FDisableAlign := True;
    UpdateHeaderOptions;
  finally
    FDisableAlign := OldDisableAlign;
  end;
  RealignContent;
end;

procedure TStyledGrid.MMSelChanged(var Message: TDispatchMessage);
begin
  if not EditorMode and IsFocused and (TGridOption.AlwaysShowEditor in Model.Options) and CanEdit then
  begin
    ShowEditor;
    if not EditorMode then
      UpdateSelection;
  end
  else
    UpdateSelection;
end;

procedure TStyledGrid.SetTopLeft(const ACol, ARow: Integer);
var
  R: TRect;
  LCol, LRow: Integer;
begin
  if ((ACol >= 0) or (ARow >= 0)) and (ACol < Model.ColumnCount) and (ARow < Model.RowCount) then
  begin
    LCol := Max(0, ACol);
    LRow := Max(0, ARow);
    R := CellRect(LCol, LRow);
    AniCalculations.BeginUpdate;
    try
      if not AniCalculations.Down then
        AniCalculations.MouseDown(0, 0);
      AniCalculations.MouseLeave;
      if ACol < 0 then
        ViewportPosition := TPointF.Create(ViewportPosition.X, R.Top)
      else if ARow < 0 then
        ViewportPosition := TPointF.Create(R.Left, ViewportPosition.Y)
      else
        ViewportPosition := TPointF.Create(R.Left, R.Top);
    finally
      AniCalculations.EndUpdate;
    end;
    AniCalculations.UpdatePosImmediately(True);
  end;
end;

procedure TStyledGrid.PMCanEdit(var Message: TDispatchMessageWithValue<Boolean>);
begin
  Message.Value := CanEdit;
end;

procedure TStyledGrid.PMSetTopLeft(var Message: TDispatchMessageWithValue<TGridModel.TCoord>);
begin
  SetTopLeft(Message.Value.Col, Message.Value.Row);
end;

procedure TStyledGrid.MMShowEditor(var Message: TDispatchMessage);
begin
  ShowEditor;
end;

function TStyledGrid.GetHeaderItemCount: Integer;
begin
  if FHeader = nil then
    Result := 0
  else
    Result := FHeader.Count;
end;

function TStyledGrid.GetHeaderItem(const Index: Integer): TGridHeaderItem;
begin
  if not InRange(Index, 0, HeaderItemCount - 1) then
    raise EListError.CreateFMT(sArgumentOutOfRange_Index, [Index, HeaderItemCount])at ReturnAddress;
  Result := TGridHeaderItem(FHeader.Items[Index]);
end;

procedure TStyledGrid.ScrollToSelectedCell;
var
  LCol, LRow: Integer;
  R: TRect;
  LOffset, NewPosition: TPointF;
  LWorkRect: TRectF;
begin
  if ((Model.Col >= 0) or (Model.Row >= 0)) and (Model.Col < Model.ColumnCount) and (Model.Row < Model.RowCount) then
  begin
    LCol := Max(0, Model.Col);
    LRow := Max(0, Model.Row);
    R := CellRect(LCol, LRow);
    R.Inflate(ColumnThickness, RowThickness);
    R.Top := Max(0, R.Top);
    R.Left := Max(0, R.Left);
    LOffset := TPoint.Zero;
    if FVKRect.IsEmpty then
      LWorkRect := WorkRect
    else
    begin
      LWorkRect := FVKRect;
      LWorkRect.Offset(ViewportPosition.X, ViewportPosition.Y);
    end;
    if Model.Col >= 0 then
    begin
      if R.Right > LWorkRect.Right then
      begin
        LOffset.X := R.Right - LWorkRect.Right;
        R.Offset(-Round(LOffset.X), 0);
      end;
      if R.Left < LWorkRect.Left then
        LOffset.X := LOffset.X + R.Left - LWorkRect.Left;
    end;

    if Model.Row >= 0 then
    begin
      if R.Bottom > LWorkRect.Bottom then
      begin
        LOffset.Y := R.Bottom - LWorkRect.Bottom;
        R.Offset(-Round(LOffset.Y), 0);
      end;
      if R.Top < LWorkRect.Top then
        LOffset.Y := LOffset.Y + R.Top - LWorkRect.Top;
    end;

    NewPosition := ViewportPosition;
    NewPosition.Offset(LOffset);
    AniCalculations.BeginUpdate;
    try
      if not AniCalculations.Down then
        AniCalculations.MouseDown(0, 0);
      AniCalculations.MouseLeave;
      ViewportPosition := NewPosition;
    finally
      AniCalculations.EndUpdate;
    end;
    AniCalculations.UpdatePosImmediately(True);
  end;
end;

function TStyledGrid.TouchEnabled: Boolean;
begin
  Result := HasTouchScreen and not (csDesigning in ComponentState) and not Released;
end;

procedure TStyledGrid.ClickTimerProc(Sender: TObject);
var
  LControl: IControl;
  P: TPointF;
begin
  if Sender is TSelectTimer then
  begin
    TSelectTimer(Sender).Enabled := False;
    try
      if TGridPart.EditorShowing in FUpdating then
        FUpdating := FUpdating - [TGridPart.EditorShowing]
      else
        Exit;
      if TSelectTimer.TTimerAction.Exit in TSelectTimer(Sender).FTimerActions then
        HideEditor(False);
      if TSelectTimer.TTimerAction.SelectCell in TSelectTimer(Sender).FTimerActions then
        Model.SelectCell(TSelectTimer(Sender).FCoord.Col, TSelectTimer(Sender).FCoord.Row);
      if TSelectTimer.TTimerAction.ShowEditor in TSelectTimer(Sender).FTimerActions then
        ShowEditor;
      if EditorMode and (FInplaceEdit is TControl) then
      begin
        LControl := FInplaceEdit as IControl;
        if LControl.Enabled then
        begin
          LControl.SetFocus;
          if TSelectTimer.TTimerAction.MouseClick in TSelectTimer(Sender).FTimerActions then
          begin
            P := TControl(FInplaceEdit).AbsoluteToLocal(TSelectTimer(Sender).FPoint);
            LControl.MouseDown(TMouseButton.mbLeft, [], P.X, P.Y);
            LControl.MouseUp(TMouseButton.mbLeft, [], P.X, P.Y);
          end;
        end;
      end;
    finally
      TSelectTimer(Sender).Release;
    end;
  end;
end;

procedure TStyledGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  LCol, LRow: Integer;
  LTimer: TSelectTimer;
  TimerActions: TSelectTimer.TTimerActions;
  P: TPointF;
  Coord: TGridModel.TCoord;
begin
  if Button = TMouseButton.mbLeft then
  begin
    TimerActions := [TSelectTimer.TTimerAction.MouseClick, TSelectTimer.TTimerAction.SelectCell];
    P := LocalToAbsolute(TPointF.Create(X, Y));
    CellByPoint(P.X, P.Y, LCol, LRow);
    if (LCol = Model.Col) and (LRow = Model.Row) and not EditorMode then
      TimerActions := TimerActions + [TSelectTimer.TTimerAction.ShowEditor];
    if (LCol >= 0) and (LRow >= 0) and Columns[LCol].Enabled then
    begin
      FMouseDown := True;
      FMouseDownPos := P;
      if not (TGridPart.EditorShowing in FUpdating) then
      begin
        Coord.Col := LCol;
        Coord.Row := LRow;
        LTimer := TSelectTimer.Create(Self, Coord, P, ClickTimerProc, TimerActions);
        FUpdating := FUpdating + [TGridPart.EditorShowing];
        if AniCalculations.TouchTracking = [] then
          LTimer.Interval := 10;
        LTimer.Enabled := True;
      end;
    end;
  end;
  inherited;
end;

procedure TStyledGrid.MouseMove(Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
begin
  if FMouseDown and (TGridPart.EditorShowing in FUpdating) then
  begin
    P := LocalToAbsolute(TPointF.Create(X, Y));
    if not FMouseDownPos.EqualsTo(P, Scene.GetSceneScale) and (AniCalculations.TouchTracking <> []) then
      FUpdating := FUpdating - [TGridPart.EditorShowing];
  end;
  inherited;
end;

procedure TStyledGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FMouseDown := False;
  inherited;
end;

procedure TStyledGrid.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  if csDesigning in ComponentState then
    inherited MouseWheel(Shift + [ssHorizontal], WheelDelta, Handled)
  else
    inherited;
end;

procedure TStyledGrid.PMVKDisplacement(var Message: TDispatchMessageWithValue<TGridModel.TVKInfo>);
var
  R: TRectF;
begin
  if Message.Value.Shown then
  begin
    if ContentLayout <> nil then
    begin
      R.TopLeft := ContentLayout.AbsoluteToLocal(Message.Value.AbsoluteRect.TopLeft);
      R.BottomRight := ContentLayout.AbsoluteToLocal(Message.Value.AbsoluteRect.BottomRight);
      R.Intersect(ContentLayout.LocalRect);
      FVKRect := R;
      UpdateContent;
      ScrollToSelectedCell;
    end;
  end
  else
  begin
    FVKRect := TRectF.Empty;
    UpdateContent;
    ScrollToSelectedCell;
  end;
end;

procedure TStyledGrid.PMSetContent(var Message: TDispatchMessageWithValue<TScrollContent>);
begin
  inherited;
  InvalidateContentSize;
  Content.OnGetClipRect := DoGetClipRect;
  Content.OnResize := DoContentResize;
  Content.OnPainting := DoContentPainting;
end;

procedure TStyledGrid.PMBeginPaintChildren(var Message: TDispatchMessage);
begin
  if FHeader <> nil then
    TOpenControl(FHeader).FDisablePaint := True;
  inherited;
end;

procedure TStyledGrid.PMEndPaintChildren(var Message: TDispatchMessage);
begin
  if FHeader <> nil then
  begin
    TOpenControl(FHeader).FDisablePaint := False;
    if TGridOption.Header in Model.Options then
      TOpenControl(FHeader).PaintInternal;
  end;
  inherited;
end;

procedure TStyledGrid.UpdateColumns;
var
  I: Integer;
  R: TRect;
  LRect: TRectF;
  OldDisableAlign: Boolean;
begin
  if [TGridPart.Columns] * FUpdating = [] then
  begin
    FUpdating := FUpdating + [TGridPart.Columns];
    OldDisableAlign := TOpenControl(Content).FDisableAlign;
    try
      TOpenControl(Content).FDisableAlign := True;
      for I := 0 to ColumnCount - 1 do
        if Columns[I].EffectiveVisible then
        begin
          R := CellRect(I, 0);
          LRect := TRectF.Create(R);
          LRect.Top := WorkRect.Top;
          LRect.Bottom := WorkRect.Bottom;
          Columns[I].BoundsRect := LRect;
        end;
      UpdateSelection;
    finally
      TOpenControl(Content).FDisableAlign := OldDisableAlign;
      FUpdating := FUpdating - [TGridPart.Columns];
    end;
    UpdateHeader;
  end;
end;

procedure TStyledGrid.UpdateItemRect(const ColumnIndex, ItemIndex: Integer);
var
  LItem: THeaderItem;
  R: TRect;
begin
  if FHeader <> nil then
  begin
    if (ColumnIndex >= 0) and (ColumnIndex < ColumnCount) then
    begin
      LItem := FHeader.Items[ItemIndex];
      R := CellRect(ColumnIndex, 0);
      LItem.BoundsRect := TRectF.Create(R.Left - ViewportPosition.X - ColumnThickness, 0, R.Right - ViewportPosition.X,
        FHeader.Height);
    end
    else
    begin
      LItem := TOpenHeader(FHeader).LastItem;
      R := CellRect(ColumnCount, 0);
      LItem.BoundsRect := TRectF.Create(R.Left - ViewportPosition.X - ColumnThickness, 0,
        WorkRect.Right - ViewportPosition.X + (Width - WorkRect.Width), FHeader.Height);
    end;
  end;
end;

procedure TStyledGrid.UpdateHeaderOffset;
begin
  TOpenHeader(FHeader).Offset := -ViewportPosition.X;
end;

procedure TStyledGrid.UpdateHeader;
  procedure UpdateHeaderItem(const ColumnIndex, ItemIndex: Integer);
  var
    LItem: TGridHeaderItem;
  begin
    if FHeader.Count <= ItemIndex then
    begin
      LItem := TGridHeaderItem.Create(self);
      LItem.Parent := FHeader;
    end
    else
      LItem := TGridHeaderItem(FHeader.Items[ItemIndex]);
    if ColumnIndex < ColumnCount then
    begin
      LItem.Column := Columns[ColumnIndex];
      LItem.Text := Columns[ColumnIndex].Header;
    end;
    UpdateItemRect(ColumnIndex, ItemIndex);
  end;

var
  HiddenFound, OldDisableAlign: Boolean;
  I, ItemsCount: Integer;
begin
  if (FHeader <> nil) and FHeader.Visible and ([TGridPart.Columns, TGridPart.Header] * FUpdating = []) then
  begin
    FUpdating := FUpdating + [TGridPart.Header];
    try
      ItemsCount := 0;
      HiddenFound := False;
      UpdateHeaderOffset;
      OldDisableAlign := TOpenHeader(FHeader).FDisableAlign;
      TOpenHeader(FHeader).FDisableAlign := True;
      try
        TOpenHeader(FHeader).RemoveObject(TOpenHeader(FHeader).LastItem);
        try
          for I := 0 to ColumnCount - 1 do
            if Columns[I].EffectiveVisible then
            begin
              if Columns[I].Width > 0 then
              begin
                if HiddenFound then
                begin
                  UpdateHeaderItem(I - 1, ItemsCount);
                  Inc(ItemsCount);
                  HiddenFound := False;
                end;
                UpdateHeaderItem(I, ItemsCount);
                Inc(ItemsCount);
              end
              else
                HiddenFound := True;
            end;
          if HiddenFound then
          begin
            UpdateHeaderItem(ColumnCount - 1, ItemsCount);
            Inc(ItemsCount);
          end;
          for I := FHeader.Count - 1 downto ItemsCount do
            if FHeader.Items[I] <> TOpenHeader(FHeader).LastItem then
              FHeader.Items[I].Release;
        finally
          TOpenHeader(FHeader).AddObject(TOpenHeader(FHeader).LastItem);
        end;
      finally
        TOpenHeader(FHeader).FDisableAlign := OldDisableAlign;
        TOpenHeader(FHeader).Realign;
      end;
      for I := 0 to HeaderItemCount - 1 do
        HeaderItem[I].HitTest := HitTestOptions * Model.Options <> [];
    finally
      FUpdating := FUpdating - [TGridPart.Header];
    end;
  end;
end;

function TStyledGrid.GetEditorRect: TRectF;
begin
  Result := TRectF.Create(CellRect(Model.Col, Model.Row));
end;

function TStyledGrid.RefreshEditor(const InplaceEdit: TFmxObject; const RefreshAppearance,
  RefreshValue: Boolean): Boolean;
var
  EditorTextSettings, PresentedTextSettings: ITextSettings;
  R: TRectF;
  LAlignableObject: IAlignableObject;
  LControl: IControl;
  LValue: TValue;
begin
  Result := False;
  if (Model.Row >= 0) and (Model.Row < RowCount) and (Model.Col >= 0) and (Model.Col < ColumnCount) then
  begin
    if RefreshAppearance then
    begin
      if Supports(InplaceEdit, ITextSettings, EditorTextSettings) then
      begin
        EditorTextSettings.StyledSettings := [];
        if Supports(Columns[Model.Col], ITextSettings, PresentedTextSettings) or
          Supports(Columns[Model.Col].PresentedControl, ITextSettings, PresentedTextSettings) and
          (PresentedTextSettings.ResultingTextSettings <> nil) then
          EditorTextSettings.TextSettings.Assign(PresentedTextSettings.ResultingTextSettings);
      end;
      R := GetEditorRect;
      if Supports(InplaceEdit, IAlignableObject, LAlignableObject) then
      begin
        LAlignableObject.SetBounds(R.Left, R.Top, R.Width, R.Height);
        LAlignableObject.Align := TAlignLayout.None;
        LAlignableObject := nil;
      end;
      InplaceEdit.BringToFront;
      if Supports(InplaceEdit, IControl, LControl) then
      begin
        LControl.Visible := True;
        LControl := nil;
      end;
      Result := True;
    end;
    if RefreshValue then
    begin
      LValue := Model.GetValue(Model.Col, Model.Row, True);
      InplaceEdit.Data := LValue;
      Result := Columns[Model.Col].RefreshEditor(InplaceEdit, LValue);
    end;
  end;
end;

procedure TStyledGrid.ShowEditor;
var
  EditClass: TFmxObjectClass;
  LControl: IControl;
  LCustomEditor: TStyledControl;
  CellControl: ICellControl;
begin
  if not FEditorMode and CanEdit and (Content <> nil) and (FInplaceEdit = nil) and
    ((FUpdating - [TGridPart.EditorShowing]) = []) and
    not Released then
  begin
    FUpdating := FUpdating + [TGridPart.EditorModeChanging];
    try
      ScrollToSelectedCell;
      LControl := nil;
      LCustomEditor := nil;
      try
        DoCreateCustomEditor(Columns[Model.Col], LCustomEditor);
        if LCustomEditor = nil then
        begin
          EditClass := GetEditorClass(Columns[Model.Col]);
          if EditClass = nil then
            EditClass := TDefaultEditor;
          FInplaceEdit := EditClass.Create(Self);
        end
        else
        begin
          LCustomEditor.DisableDisappear := True;
          FInplaceEdit := LCustomEditor;
        end;
        FInplaceEdit.Stored := False;
        if Supports(FInplaceEdit, ICellControl, CellControl) then
          CellControl.Column := Columns[Model.Col];
        FInplaceEdit.Parent := Content;
        FEditorMode := RefreshEditor(FInplaceEdit, True, True);
      except
        if not FEditorMode and (FInplaceEdit <> nil) then
        begin
          FInplaceEdit.DisposeOf;
          FInplaceEdit := nil;
        end;
        raise;
      end;
      UpdateSelection;
      if FEditorMode then
      begin
        if Supports(FInplaceEdit, IControl, LControl) then
          LControl.SetFocus;
      end
      else
      begin
        FInplaceEdit.DisposeOf;
        FInplaceEdit := nil;
      end;
    finally
      FUpdating := FUpdating - [TGridPart.EditorModeChanging];
    end;
  end;
end;

function TStyledGrid.GetInplaceEditorValue(const AInplaceEdit: TFMXObject): TValue;
begin
  if AInplaceEdit <> nil then
    Result := AInplaceEdit.Data
  else
    Result := TValue.Empty;
end;

function TStyledGrid.EditingDone(const Accept: Boolean): Boolean;
var
  Editing: Boolean;
begin
  Editing := (TGridOption.Editing in Model.Options) and not Columns[Model.Col].ReadOnly;
  Result := Columns[Model.Col].EditingDone(FInplaceEdit, GetInplaceEditorValue(FInplaceEdit), Accept and Editing);
end;

function TStyledGrid.PostEditorValue: Boolean;
var
  Editing: Boolean;
begin
  Editing := (TGridOption.Editing in Model.Options) and not Columns[Model.Col].ReadOnly;
  if Editing and (FInplaceEdit <> nil) then
    Result := Columns[Model.Col].PostEditorValue(FInplaceEdit, GetInplaceEditorValue(FInplaceEdit))
  else
    Result := False;
end;

procedure TStyledGrid.HideEditor(const Accept: Boolean);
var
  LControl: IControl;
begin
  if FEditorMode and not (TGridPart.EditorModeChanging in FUpdating) then
  begin
    FUpdating := FUpdating + [TGridPart.EditorModeChanging];
    try
      if Supports(FInplaceEdit, IControl, LControl) and LControl.IsFocused and (Root <> nil) then
        Root.SetFocused(nil);
      try
        EditingDone(Accept);
      finally
        FEditorMode := False;
        if FInplaceEdit <> nil then
        begin
          FInplaceEdit.Release;
          FInplaceEdit := nil;
        end;
        UpdateSelection;
      end;
    finally
      FUpdating := FUpdating - [TGridPart.EditorModeChanging];
    end;
  end;
end;

procedure TStyledGrid.DialogKey(var Key: Word; Shift: TShiftState);

  procedure SelectNextCell(const ACol, ARow: Integer; const AEditorMode: Boolean);
  begin
    Model.SelectCell(ACol, ARow);
    ScrollToSelectedCell;
    if AEditorMode then
      ShowEditor;
    if not EditorMode then
      SetFocus;
    Key := 0;
  end;

var
  LControl: IControl;
  LEditorMode: Boolean;
  LCol, LRow: Integer;
begin
  if not Supports(FInplaceEdit, IControl, LControl) then
    LControl := nil;
  LCol := Model.Col;
  LRow := Model.Row;
  LEditorMode := EditorMode;
  if IsFocused or ((LControl <> nil) and LControl.IsFocused) then
    case Key of
      vkTab:
        if TGridOption.Tabs in Model.Options then
        begin
          HideEditor(True);
          if Model.FindNextCell(ssShift in Shift, TGridOption.RowSelect in Model.Options, LEditorMode or
            (TGridOption.AlwaysShowEditor in Model.Options), LCol, LRow) then
            SelectNextCell(LCol, LRow, LEditorMode);
        end;
      vkReturn:
        if EditorMode then
        begin
          HideEditor(True);
          if Model.CellReturnAction = TCellReturnAction.None then
            SelectNextCell(LCol, LRow, (TGridOption.AlwaysShowEditor in Model.Options))
          else
          begin
            LEditorMode := LEditorMode or (TGridOption.AlwaysShowEditor in Model.Options);
            if Model.FindNextCell(False, Model.CellReturnAction = TCellReturnAction.GotoNextRow, LEditorMode, LCol,
              LRow) then
              SelectNextCell(LCol, LRow, LEditorMode);
          end;
        end;
      vkEscape:
        if EditorMode then
        begin
          if TGridOption.AlwaysShowEditor in Model.Options then
          begin
            HideEditor(False);
            ShowEditor;
          end
          else
          begin
            HideEditor(False);
            SetFocus;
          end;
          Key := 0;
        end;
    end;
  inherited;
end;

procedure TStyledGrid.PerformKeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  if not (TGridPart.EditorKeyDown in FUpdating) then
  begin
    FUpdating := FUpdating + [TGridPart.EditorKeyDown];
    try
      KeyDown(Key, KeyChar, Shift);
    finally
      FUpdating := FUpdating - [TGridPart.EditorKeyDown];
    end;
  end;
end;

procedure TStyledGrid.SetFocus;
begin
  if (Model <> nil) and (Model.Owner is TControl) then
    TControl(Model.Owner).SetFocus;
end;

procedure TStyledGrid.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
  procedure RestoreFocus;
  begin
    if (TGridPart.EditorKeyDown in FUpdating) then
      SetFocus;
  end;
var
  LControl: IControl;
  LCol, LRow, PageSize: Integer;
begin
  if (ColumnCount > 0) and (RowCount > 0) then
  begin
    if Key = 0 then
    begin
      if TGridPart.EditorKeyDown in FUpdating then
        Exit;
      if (KeyChar <> #0) and not EditorMode and CanEdit and not Columns[Model.Col].ReadOnly and
        Columns[Model.Col].ValidChar(KeyChar) then
      begin
        ShowEditor;
        if Supports(FInplaceEdit, IControl, LControl) then
          LControl.KeyDown(Key, KeyChar, Shift);
      end;
      KeyChar := #0;
    end
    else
    begin
      LCol := Model.Col;
      LRow := Model.Row;
      if RowHeight > 0 then
        PageSize := Max(1, Trunc(Content.Height / (RowHeight + RowThickness)))
      else
        PageSize := 1;
      case Key of
        vkReturn, vkF2:
        begin
          ShowEditor;
          Key := 0;
        end;
        vkUp, vkDown, vkLeft, vkRight, vkHome, vkEnd:
          begin
            if (ssCtrl in Shift) and (Key in [vkUp, vkDown, vkHome, vkEnd]) then
            begin
              case Key of
                vkUp:
                  if TopRow > 0 then
                    SetTopLeft(-1, TopRow - 1);
                vkDown:
                  if CellRect(0, BottomRow).Bottom > WorkRect.Bottom then
                    SetTopLeft(-1, TopRow + 1);
                vkHome:
                  begin
                    Model.SelectCell(LCol, 0);
                    ScrollToSelectedCell;
                    RestoreFocus;
                  end;
                vkEnd:
                  begin
                    Model.SelectCell(LCol, RowCount - 1);
                    ScrollToSelectedCell;
                    RestoreFocus;
                  end;
              end;
            end
            else
            begin
              if Key in [vkHome, vkEnd] then
                LCol := -1;
              if Model.FindNextCell(Key in [vkUp, vkLeft, vkEnd], Key in [vkUp, vkDown], ssCtrl in Shift, LCol, LRow)
              then
              begin
                Model.SelectCell(LCol, LRow);
                ScrollToSelectedCell;
                RestoreFocus;
              end;
            end;
            Key := 0;
          end;
        vkPrior:
          begin
            if ssCtrl in Shift then
              SetTopLeft(-1, Max(0, TopRow - PageSize))
            else
            begin
              LRow := Max(0, LRow - PageSize);
              Model.SelectCell(LCol, LRow);
              ScrollToSelectedCell;
              RestoreFocus;
            end;
            Key := 0;
          end;
        vkNext:
          begin
            if ssCtrl in Shift then
            begin
              if CellRect(0, BottomRow).Bottom > WorkRect.Bottom then
                SetTopLeft(-1, EnsureRange(TopRow + PageSize, 0, RowCount - PageSize));
            end
            else
            begin
              LRow := Min(RowCount - 1, LRow + PageSize);
              Model.SelectCell(LCol, LRow);
              ScrollToSelectedCell;
              RestoreFocus;
            end;
            Key := 0;
          end;
      end;
    end;
  end;
  inherited;
end;

initialization

  TPresentationProxyFactory.Current.Register(TCustomGrid, TControlType.Styled, TStyledPresentationProxy<TStyledGrid>);
  TPresentationProxyFactory.Current.Register(TGrid, TControlType.Styled, TStyledPresentationProxy<TStyledGrid>);
  TPresentationProxyFactory.Current.Register(TStringGrid, TControlType.Styled, TStyledPresentationProxy<TStyledGrid>);

finalization

  TPresentationProxyFactory.Current.Unregister(TStringGrid, TControlType.Styled, TStyledPresentationProxy<TStyledGrid>);
  TPresentationProxyFactory.Current.Unregister(TGrid, TControlType.Styled, TStyledPresentationProxy<TStyledGrid>);
  TPresentationProxyFactory.Current.Unregister(TCustomGrid, TControlType.Styled, TStyledPresentationProxy<TStyledGrid>);

end.
