{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.TreeView;

interface

uses
  System.Classes, System.Types, System.UITypes,
  FMX.Types, FMX.Layouts, FMX.ListBox, FMX.StdCtrls, FMX.Objects, FMX.Controls,
  System.Generics.Collections, FMX.TextLayout;

type

{ TTreeViewItem }

  TCustomTreeView = class;

  TTreeViewItem = class(TTextControl, IItemsContainer)
  private
    FIsExpanded: Boolean;
    FExpander: TControl;
    FButton: TCustomButton;
    FCheck: TCheckBox;
    FGlobalIndex: Integer;
    FIsChecked: Boolean;
    FIsSelected: Boolean;
    FContent: TContent;
    FNoItemsContent: TLayout;
    FVisibleCount: Integer;
    FTextObject: TText;
    FMinItemSize: TSizeF;
    FDefaultItemSize: TSizeF;
    function GetLevelOffset: Single;
    function GetChildrenOffset: Single;
    procedure SetIsExpanded(const Value: Boolean);
    procedure DoButtonClick(Sender: TObject);
    procedure DoCheckClick(Sender: TObject);
    function GetCount: Integer;
    procedure SetIsChecked(const Value: Boolean);
    procedure UpdateCheckBoxVisibility;
    procedure UpdateExpandedButtonVisibility;
    procedure SetIsSelected(const Value: Boolean);
    procedure HitTestReader(Reader: TReader);
    procedure CalculateCountVisibleItems;
    { IItemsContainer }
    function IItemsContainer.GetItemsCount = GetCount;
    function GetItem(const AIndex: Integer): TFmxObject;
    function GetMinItemSize: TSizeF;
    procedure OnExpandButtonStyleLookup(Sender: TObject);
  protected
    procedure ChangeOrder; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DragEnd; override;
    function CalcMinSize: TSizeF;
    procedure InvalidateTextSize;
    procedure SetText(const Value: string); override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    function EnterChildren(AObject: IControl): Boolean; override;
    function GetAbsoluteRect: TRectF; override;
    procedure ContentAddObject(const AObject: TFmxObject); virtual;
    procedure ContentInsertObject(const AIndex: Integer; const AObject: TFmxObject); virtual;
    procedure ContentRemoveObject(const AObject: TFmxObject); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Paint; override;
    procedure SetVisible(const Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Sort(Compare: TFmxObjectSortCompare); override;
    function ItemByPoint(const X, Y: Single): TTreeViewItem;
    function ItemByIndex(const Idx: Integer): TTreeViewItem;
    function TreeView: TCustomTreeView;
    function Level: Integer;
    function ParentItem: TTreeViewItem;
    procedure Select;
    procedure Deselect;
    procedure ExpandAll;
    procedure CollapseAll;
    procedure Expand;
    procedure Collapse;
    property Count: Integer read GetCount;
    property VisibleCount: Integer read FVisibleCount;
    property GlobalIndex: Integer read FGlobalIndex;
    property MinItemSize: TSizeF read GetMinItemSize;
    property DefaultItemSize: TSizeF read FDefaultItemSize;
    property Items[const Index: Integer]: TTreeViewItem read ItemByIndex; default;
  published
    property Align;
    property AutoTranslate default True;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    {triggers}
    property IsChecked: Boolean read FIsChecked write SetIsChecked;
    property IsExpanded: Boolean read FIsExpanded write SetIsExpanded;
    property IsSelected: Boolean read FIsSelected write SetIsSelected;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property Text;
    property TextAlign default TTextAlign.taLeading;
    property Visible default True;
    property Width;
    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Mouse events}
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TTreeView }

  TOnCompareTreeViewItemEvent = function(Item1, Item2: TTreeViewItem): Integer of object;
  TOnTreeViewDragChange = procedure(SourceItem, DestItem: TTreeViewItem;
    var Allow: Boolean) of object;

{ TTreeView }

  TCustomTreeView = class(TScrollBox, IItemsContainer)
  private
    FMouseSelecting: Boolean;
    FOnChange: TNotifyEvent;
    FSelected: TTreeViewItem;
    FItemHeight: Single;
    FCountExpanded: Integer;
    FGlobalCount: Integer;
    FShowCheckboxes: Boolean;
    FOnChangeCheck: TNotifyEvent;
    FSorted: Boolean;
    FOnCompare: TOnCompareTreeViewItemEvent;
    FMultiSelect: Boolean;
    FFirstSelect: TTreeViewItem;
    FFocusedSelection: TControl;
    FSelection: TControl;
    FSelections: TControlList;
    FAllowDrag: Boolean;
    FDragItem: TTreeViewItem;
    FOnDragChange: TOnTreeViewDragChange;
    FGlobalList: TList<TTreeViewItem>;
    FAlternatingRowBackground: Boolean;
    FOddFill: TBrush;
    FFirstVisibleItem, FLastVisibleItem: Integer;
    FNoItemsContent: TContent;
    FHoveredItem: TTreeViewItem;
    FTextLayout: TTextLayout;
    procedure SetItemHeight(const Value: Single);
    procedure SetCheckboxesVisibility(const Value: Boolean);
    function GetTreeItem(Index: Integer): TTreeViewItem;
    procedure SetSorted(const Value: Boolean);
    procedure SortItems;
    procedure SelectRange(const Item1, Item2: TTreeViewItem);
    procedure UpdateSelection;
    procedure UpdateVisibleItems;
    procedure UpdateGlobalIndexes;
    procedure SetAllowDrag(const Value: Boolean);
    function GetCount: Integer;
    procedure SetAlternatingRowBackground(const Value: Boolean);
    procedure SetHoveredItem(const Value: TTreeViewItem);
    function LocalPointToHoveredItemLocalPoint(const AX, AY: Single): TPointF;
    { IItemsContainer }
    function IItemsContainer.GetItemsCount = GetCount;
    function GetItem(const AIndex: Integer): TFmxObject;
    function MouseInContentLayout(const X, Y: Single): Boolean;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations); override;
    { Selection }
    procedure ClearSelection;
    procedure SelectAll;
    procedure SetSelected(const Value: TTreeViewItem); virtual;
    { Styles }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    { Tree View Events }
    procedure DoChange; virtual;
    procedure DoChangeCheck(const Item: TTreeViewItem); virtual;
    { Focus }
    procedure DoEnter; override;
    procedure DoExit; override;
    { Children structure }
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    function IsAddToContent(const AObject: TFmxObject): Boolean; override;
    procedure ContentAddObject(const AObject: TFmxObject); override;
    procedure ContentInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure ContentRemoveObject(const AObject: TFmxObject); override;
    { Content Scrolling }
    procedure ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                     const ContentSizeChanged: boolean); override;
    function CreateScrollContent: TScrollContent; override;
    function DoCalcContentBounds: TRectF; override;
    function GetItemRect(const Item: TTreeViewItem): TRectF;
    { Painting }
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    function IsOpaque: Boolean; override;
    { Mouse events }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    { Keyboards events }
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    { Drag And Drop }
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    function ObjectAtPoint(P: TPointF): IControl; override;
    procedure ChangeOrder; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure ExpandAll;
    procedure CollapseAll;
    function ItemByText(const AText: string): TTreeViewItem;
    function ItemByPoint(const X, Y: Single): TTreeViewItem;
    function ItemByIndex(const Idx: Integer): TTreeViewItem;
    function ItemByGlobalIndex(const Idx: Integer): TTreeViewItem;
    property Count: Integer read GetCount;
    property GlobalCount: Integer read FGlobalCount;
    property CountExpanded: Integer read FCountExpanded;
    property Selected: TTreeViewItem read FSelected write SetSelected;
    property Items[Index: Integer]: TTreeViewItem read GetTreeItem;
    property AllowDrag: Boolean read FAllowDrag write SetAllowDrag;
    property AlternatingRowBackground: Boolean read FAlternatingRowBackground write SetAlternatingRowBackground;
    property ItemHeight: Single read FItemHeight write SetItemHeight;
    property MultiSelect: Boolean read FMultiSelect write FMultiSelect default False;
    property ShowCheckboxes: Boolean read FShowCheckboxes write SetCheckboxesVisibility default False;
    property Sorted: Boolean read FSorted write SetSorted default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChangeCheck: TNotifyEvent read FOnChangeCheck write FOnChangeCheck;
    property OnCompare: TOnCompareTreeViewItemEvent read FOnCompare write FOnCompare;
    property OnDragChange: TOnTreeViewDragChange read FOnDragChange write FOnDragChange;
  end;

  TTreeView = class(TCustomTreeView)
  published
    property StyleLookup;
    property CanFocus default True;
    property CanParentFocus;
    property DisableFocusEffect default True;
    property TabOrder;
    property AllowDrag default False;
    property AlternatingRowBackground default False;
    property ItemHeight;
    property MultiSelect default False;
    property ShowCheckboxes default False;
    property Sorted default False;
    property OnCanFocus;
    property OnChange;
    property OnChangeCheck;
    property OnCompare;
    property OnDragChange;
    property OnKeyDown;
    property OnKeyUp;
  end;

implementation

uses System.Math, System.SysUtils, System.RTLConsts, FMX.Ani, FMX.Platform;

type

  TTreeViewItemContent = class(TContent)
  private
    FItem: TTreeViewItem;
  protected
    function GetFirstVisibleObjectIndex: Integer; override;
    function GetLastVisibleObjectIndex: Integer; override;
    function GetAbsoluteRect: TRectF; override;
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
  public
  end;

{ TTreeViewItemContent }

procedure TTreeViewItemContent.DoAddObject(const AObject: TFmxObject);
begin
  inherited DoAddObject(AObject);
  if Assigned(Parent) and (Parent is TTreeViewItem) then
    TTreeViewItem(Parent).ContentAddObject(AObject);
end;

procedure TTreeViewItemContent.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if Assigned(Parent) and (Parent is TTreeViewItem) then
    TTreeViewItem(Parent).ContentRemoveObject(AObject);
end;

procedure TTreeViewItemContent.DoInsertObject(Index: Integer;
  const AObject: TFmxObject);
begin
  inherited DoInsertObject(Index, AObject);
  if Assigned(Parent) and (Parent is TTreeViewItem) then
    TTreeViewItem(Parent).ContentInsertObject(Index, AObject);
end;

procedure TTreeViewItemContent.DoRealign;
begin
end;

function TTreeViewItemContent.GetAbsoluteRect: TRectF;
begin
  if Assigned(FItem) then
    Result := FItem.GetAbsoluteRect
  else
    Result := inherited GetAbsoluteRect;
end;

function TTreeViewItemContent.GetFirstVisibleObjectIndex: Integer;
begin
  Result := 0;
end;

function TTreeViewItemContent.GetLastVisibleObjectIndex: Integer;
begin
  if FItem.IsExpanded then
    Result := ControlsCount
  else
    Result := 0;
end;

{ TTreeViewItem }

constructor TTreeViewItem.Create(AOwner: TComponent);
begin
  inherited;
  AutoTranslate := True;
  TextAlign := TTextAlign.taLeading;
  Height := 19;
  HitTest := False;
  CanFocus := False;
  FContent := TTreeViewItemContent.Create(Self);
  TTreeViewItemContent(FContent).FItem := Self;
  FContent.Stored := False;
  FContent.Parent := Self;
  FContent.Locked := True;
  FContent.HitTest := False;
end;

procedure TTreeViewItem.ChangeOrder;
var
  LTreeView : TCustomTreeView;
begin
  inherited ChangeOrder;
  LTreeView := TreeView;
  if Assigned(LTreeView) and not LTreeView.IsUpdating then
  begin
    LTreeView.BeginUpdate;
    try
      LTreeView.InvalidateContentSize;
    finally
      LTreeView.EndUpdate;
    end;
  end;
end;

procedure TTreeViewItem.ContentAddObject(const AObject: TFmxObject);
var
  LTreeView : TCustomTreeView;
begin
  if not (AObject is TTreeViewItem) then
  begin
    if not Assigned(FNoItemsContent) then
    begin
      FNoItemsContent := TLayout.Create(nil);
      FNoItemsContent.Parent := Self;
      FNoItemsContent.SetBounds(0, 0, 0, 0);
      FNoItemsContent.Stored := False;
      FNoItemsContent.Locked := True;
      FNoItemsContent.HitTest := False;
    end;
    FNoItemsContent.AddObject(AObject)
  end
  else
  begin
    LTreeView := TreeView;
    if Assigned(LTreeView) and not LTreeView.IsUpdating then
    begin
      LTreeView.BeginUpdate;
      try
        LTreeView.InvalidateContentSize;
      finally
        LTreeView.EndUpdate;
      end;
    end;
  end;
end;

procedure TTreeViewItem.ContentInsertObject(const AIndex: Integer;
  const AObject: TFmxObject);
begin
  ContentAddObject(AObject);
end;

procedure TTreeViewItem.ContentRemoveObject(const AObject: TFmxObject);
var
  LTreeView: TCustomTreeView;
begin
  if AObject is TTreeViewItem then
  begin
    // After removing child item, we need recalculate Visible Items Count
    // and update Visible of 'Expand' button
    CalculateCountVisibleItems;
    UpdateExpandedButtonVisibility;

    TTreeViewItem(AObject).Deselect;
    LTreeView := TreeView;
    if Assigned(LTreeView) and not LTreeView.IsUpdating then
    begin
      LTreeView.BeginUpdate;
      try
        LTreeView.InvalidateContentSize;
      finally
        LTreeView.EndUpdate;
      end;
    end;
  end;
end;

procedure TTreeViewItem.CalculateCountVisibleItems;
var
  I: Integer;
begin
  FVisibleCount := 0;
  for I := 0 to Count - 1 do
    if FContent.Controls[I].IsVisible then
      Inc(FVisibleCount);
end;

procedure TTreeViewItem.DragEnd;
var
  LTreeView : TCustomTreeView;
begin
  inherited;
  DragLeave;
  LTreeView := TreeView ;
  if Assigned(LTreeView) and Assigned(LTreeView.FDragItem) then
  begin
    LTreeView.FDragItem.RemoveFreeNotify(TreeView);
    LTreeView.FDragItem := nil;
  end;
end;

function TTreeViewItem.GetAbsoluteRect: TRectF;
var
  I: Integer;
begin
  Result := inherited GetAbsoluteRect;
  if IsExpanded and (Count > 0) then
  begin
    for I := 0 to Count - 1 do
      Result := UnionRect(Result, Items[I].AbsoluteRect);
  end;
end;

function TTreeViewItem.GetLevelOffset: Single;
var
  P: TFmxObject;
begin
  Result := 0;
  P := Parent;
  if Assigned(P) and (P is TContent) then
    P := P.Parent;
  while Assigned(P) and (P is TTreeViewItem) do
  begin
    Result := Result + TTreeViewItem(P).GetChildrenOffset;
    P := P.Parent;
    if (P is TContent) then
      P := P.Parent;
  end;
end;

function TTreeViewItem.GetMinItemSize: TSizeF;
begin
  if (FMinItemSize.Width = 0) and (FMinItemSize.Height = 0) then
    FMinItemSize := CalcMinSize;
  Result := FMinItemSize;
end;

function TTreeViewItem.GetChildrenOffset: Single;
begin
  if Assigned(FExpander) then
  begin
    Result := FExpander.Width;
  end
  else
    Result := 19;
end;

function TTreeViewItem.GetCount: Integer;
begin
  Result := FContent.ControlsCount;
end;

procedure TTreeViewItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('HitTest', HitTestReader, nil, False);
end;

procedure TTreeViewItem.Deselect;
begin
  IsSelected := False;
end;

destructor TTreeViewItem.Destroy;
var
  LTreeView: TCustomTreeView;
  procedure ClerRef(var Value: TTreeViewItem);
  begin
    if Value = Self then
      Value := nil;
  end;
begin
  LTreeView := TreeView;
  if Assigned(LTreeView) then
  begin
    ClerRef(LTreeView.FSelected);
    ClerRef(LTreeView.FFirstSelect);
    ClerRef(LTreeView.FDragItem);
    ClerRef(LTreeView.FHoveredItem);
    ClerRef(LTreeView.FSelected);
    if Assigned(LTreeView.FGlobalList) then
      LTreeView.FGlobalList.Remove(Self);
  end;
  inherited;
end;

procedure TTreeViewItem.DoAddObject(const AObject: TFmxObject);
begin
  if AObject is TTreeViewItem then
  begin
    FContent.AddObject(AObject);
    CalculateCountVisibleItems;
    UpdateExpandedButtonVisibility;
  end
  else
    inherited;
end;

procedure TTreeViewItem.DoRemoveObject(const AObject: TFmxObject);
begin
  if (AObject is TTreeViewItem) and (TTreeViewItem(AObject).TreeView = TreeView) then
  begin
    TTreeViewItem(AObject).Parent := nil;
    TTreeViewItem(AObject).Deselect;
    CalculateCountVisibleItems;
    UpdateExpandedButtonVisibility;
  end
  else
    inherited;
end;

function TTreeViewItem.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := Items[AIndex];
end;

function TTreeViewItem.ItemByPoint(const X, Y: Single): TTreeViewItem;
var
  i: Integer;
  P, P1: TPointF;
  LItem: TTreeViewItem;
begin
  P := LocaltoAbsolute(PointF(X, Y));
  for i := 0 to Count - 1 do
  begin
    LItem := ItemByIndex(i);
    if not LItem.Visible then
      Continue;
    if LItem.PointInObject(P.X, P.Y) then
    begin
      Result := LItem;
      Exit;
    end
    else if (LItem.Count > 0) and (LItem.IsExpanded) then
    begin
      P1 := LItem.AbsoluteToLocal(P);
      Result := LItem.ItemByPoint(P1.X, P1.Y);
      if Assigned(Result) then
        Exit;
    end;
  end;
  Result := nil;
end;

procedure TTreeViewItem.InvalidateTextSize;
begin
  FMinItemSize := TSizeF.Create(0, 0);
end;

function TTreeViewItem.ItemByIndex(const Idx: Integer): TTreeViewItem;
begin
  if (Idx >= 0) and (Idx < Count) then
    Result := TTreeViewItem(FContent.Controls[Idx])
  else
    raise ERangeError.CreateFMT(sArgumentOutOfRange_Index, [Idx, Count]);
end;

procedure TTreeViewItem.Paint;
var
  R: TRectF;
begin
  inherited Paint;
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.StrokeThickness := 1;
    Canvas.StrokeDash := TStrokeDash.sdDash;
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.StrokeDash := TStrokeDash.sdSolid;
  end;
end;

function TTreeViewItem.ParentItem: TTreeViewItem;
begin
  if (Parent is TTreeViewItemContent) and (Parent.Parent is TTreeViewItem) then
    Result := TTreeViewItem(TTreeViewItemContent(Parent).Parent)
  else
    Result := nil;
end;

function TTreeViewItem.EnterChildren(AObject: IControl): Boolean;
var
  LTreeView : TCustomTreeView ;
begin
  Result := inherited EnterChildren(AObject);
  LTreeView := TreeView;
  if Assigned(LTreeView) then
  begin
    LTreeView.Selected := Self;
    Result := True;
  end;
end;

procedure TTreeViewItem.Collapse;
begin
  IsExpanded := False;
end;

procedure TTreeViewItem.CollapseAll;
var
  i: Integer;
  Item: TTreeViewItem;
begin
  BeginUpdate;
  try
    Collapse;
    for i := Count - 1 downto 0 do
    begin
      Item := ItemByIndex(i);
      if Assigned(Item) then
        Item.CollapseAll;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TTreeViewItem.Expand;
begin
  IsExpanded := True;
end;

procedure TTreeViewItem.ExpandAll;
var
  i: Integer;
  Item: TTreeViewItem;
begin
  BeginUpdate;
  try
    Expand;
    for i := Count - 1 downto 0 do
    begin
      Item := ItemByIndex(i);
      if Assigned(Item) then
        Item.ExpandAll;
    end;
  finally
    EndUpdate;
  end;
end;

function TTreeViewItem.Level: Integer;
var
  P: TFmxObject;
begin
  Result := 0;
  P := Parent;
  while Assigned(P) and not (P is TCustomTreeView) do
  begin
    Result := Result + 1;
    P := P.Parent;
    if (P is TContent) then
      P := P.Parent;
  end;
end;

procedure TTreeViewItem.OnExpandButtonStyleLookup(Sender: TObject);
begin
  UpdateExpandedButtonVisibility;
end;

function TTreeViewItem.TreeView: TCustomTreeView;
var
  P: TFmxObject;
begin
  P := Parent;
  while Assigned(P) do
  begin
    if P is TCustomTreeView then
    begin
      Result := TCustomTreeView(P);
      Exit;
    end;
    P := P.Parent;
  end;
  Result := nil;
end;

procedure TTreeViewItem.FreeStyle;
begin
  inherited;
  FDefaultItemSize := TSizeF.Create(0, 0);
  FTextObject := nil;
  if Assigned(FButton) then
  begin
    FButton.OnClick := nil;
    FButton.OnApplyStyleLookup := nil;
    FButton.Visible := False;
    FButton := nil;
  end;
  FExpander := nil;
  if Assigned(FCheck) then
  begin
    FCheck.OnClick := nil;
    FCheck.Visible := False;
    FCheck := nil;
  end;
end;

type
  TOpenTextControl = class (TTextControl)

  end;

procedure TTreeViewItem.ApplyStyle;
var
  B: TFmxObject;
  LTreeView: TCustomTreeView;
begin
  inherited;
  InvalidateTextSize;
  B := FindStyleResource('expander');
  if Assigned(B) and (B is TControl) then
  begin
    FExpander := TControl(B);
  end;
  B := FindStyleResource('button');
  if Assigned(B) and (B is TCustomButton) then
  begin
    FButton := TCustomButton(B);
    FButton.OnClick := DoButtonClick;
    FButton.OnApplyStyleLookup := OnExpandButtonStyleLookup;
    UpdateExpandedButtonVisibility;
  end;
  B := FindStyleResource('check');
  if Assigned(B) and (B is TCheckBox) then
  begin
    FCheck := TCheckBox(B);
    FCheck.IsChecked := IsChecked;
    FCheck.OnChange := DoCheckClick;
    LTreeView := TreeView ;
    if Assigned(LTreeView) then
      FCheck.Visible := LTreeView.ShowCheckboxes;
  end;
  if (TextObject is TTextControl) and
     (TOpenTextControl(TextObject).TextObject is TText) then
  begin
    FTextObject := TText(TOpenTextControl(TextObject).TextObject);
    FTextObject.AutoSize := True;
  end
  else
  begin
    if (TextObject is TText) then
    begin
      FTextObject := TText(TextObject);
      FTextObject.AutoSize := True;
    end;
  end;
  if IsSelected then
  begin
    StartTriggerAnimation(Self, 'IsSelected');
    ApplyTriggerEffect(Self, 'IsSelected');
  end;
  Align := TAlignLayout.alNone;
  FDefaultItemSize.cx := Width;
  FDefaultItemSize.cy := Height;
end;

function TTreeViewItem.CalcMinSize: TSizeF;
var
  R: TRectF;
  LLayout: TTextLayout;
  LTree: TCustomTreeView;
begin
  Result := TSizeF.Create(0, 0);
  LTree := TreeView;
  if Visible and Assigned(FTextObject) and Assigned(LTree) then
  begin
    LLayout := LTree.FTextLayout;
    if Assigned(LLayout) then
    begin
      LLayout.BeginUpdate;
      try
        LLayout.WordWrap := False;
        LLayout.HorizontalAlign := TTextAlign.taLeading;
        LLayout.VerticalAlign := TTextAlign.taLeading;
        LLayout.Color := TAlphaColorRec.Black;
        LLayout.Font := FTextObject.Font;
        LLayout.Opacity := 1;
        LLayout.Trimming := TTextTrimming.ttNone;
        if Text = '' then
          LLayout.Text := '1'
        else
          LLayout.Text := Text;
      finally
        LLayout.EndUpdate;
      end;
      R := LLayout.TextRect;
      Result.Width := Ceil(R.Width) + 2;
      Result.Height := Ceil(R.Height) + 4;
      if Assigned(FButton) then
      begin
        R := FButton.BoundsRect;
        R := FButton.Margins.MarginRect(R);
        Result.cx := Result.cx + R.Width;
      end;
      if Assigned(FCheck) and (FCheck.Visible) then
      begin
        R := FCheck.BoundsRect;
        R := FCheck.Margins.MarginRect(R);
        Result.cx := Result.cx + R.Width;
      end;
      Result.cx := Result.cx +
                   Padding.Left + Padding.Right;
      Result.cy := Result.cy +
                   Padding.Top + Padding.Bottom;
    end;
  end;
end;

procedure TTreeViewItem.DoCheckClick(Sender: TObject);
var
  LTreeView : TCustomTreeView ;
begin
  if Assigned(FCheck) then
    FIsChecked := FCheck.IsChecked;
  LTreeView := TreeView;
  if Assigned(LTreeView) then
  begin
    LTreeView.SetFocus;
    LTreeView.DoChangeCheck(Self);
  end;
end;

procedure TTreeViewItem.UpdateCheckBoxVisibility;
var
  i, j: Integer;
  LTreeView: TCustomTreeView;
begin
  LTreeView := TreeView;
  if Assigned(LTreeView) and Assigned(FCheck) and
     (FCheck.Visible <> LTreeView.ShowCheckboxes) then
  begin
    FCheck.Visible := LTreeView.ShowCheckboxes;
    InvalidateTextSize;
  end;
  if ControlsCount > 0 then
    for i := 0 to ControlsCount - 1 do
      if Controls[i] is TTreeViewItem then
        TTreeViewItem(Controls[i]).UpdateCheckBoxVisibility
      else if Controls[i] is TTreeViewItemContent then
        for j := 0 to Controls[i].ControlsCount - 1 do
          if Controls[i].Controls[j] is TTreeViewItem then
            TTreeViewItem(Controls[i].Controls[j]).UpdateCheckBoxVisibility
end;

procedure TTreeViewItem.UpdateExpandedButtonVisibility;
begin
  if Assigned(FButton) and not (csLoading in ComponentState) then
  begin
    FButton.Visible := VisibleCount > 0;
    if FButton.Visible then
      FButton.StartTriggerAnimation(Self, 'IsExpanded');
  end;
end;

procedure TTreeViewItem.Select;
begin
  IsSelected := True;
end;

procedure TTreeViewItem.SetIsChecked(const Value: Boolean);
var
  LTreeView: TCustomTreeView;
begin
  if FIsChecked <> Value then
  begin
    FIsChecked := Value;
    if Assigned(FCheck) then
      FCheck.IsChecked := FIsChecked;
    LTreeView := TreeView;
    if Assigned(LTreeView) then
      LTreeView.DoChangeCheck(Self);
  end;
end;

procedure TTreeViewItem.SetIsSelected(const Value: Boolean);
var
  LTreeView : TCustomTreeView ;
begin
  if FIsSelected <> Value then
  begin
    FIsSelected := Value;
    StartTriggerAnimation(Self, 'IsSelected');
    LTreeView := TreeView;
    if Assigned(LTreeView) then
    begin
      if (not assigned(LTreeView.Selected)) and not (LTreeView.MultiSelect) then
        LTreeView.Selected := Self;
      LTreeView.UpdateSelection;
    end;
  end;
end;

procedure TTreeViewItem.SetText(const Value: string);
var
  LTreeView: TCustomTreeView;
begin
  if Value <> Text then
  begin
    inherited;
    InvalidateTextSize;
    LTreeView := TreeView;
    if Assigned(LTreeView) then
      LTreeView.RealignContent;
  end;
end;

procedure TTreeViewItem.SetVisible(const Value: Boolean);
var
  LChanged: Boolean;
  LParentItem: TTreeViewItem;
  LTreeView: TCustomTreeView;
begin
  LChanged := FVisible <> Value;
  inherited;
  if LChanged then
  begin
    LParentItem := ParentItem;
    if Assigned(LParentItem) then
      ParentItem.CalculateCountVisibleItems;
    LTreeView := TreeView;
    if Assigned(LTreeView) and not LTreeView.IsUpdating then
    begin
      LTreeView.BeginUpdate;
      try
        LTreeView.InvalidateContentSize;
      finally
        LTreeView.EndUpdate;
      end;
    end;
  end;
end;

procedure TTreeViewItem.Sort(Compare: TFmxObjectSortCompare);
begin
  FContent.Sort(Compare);
end;

procedure TTreeViewItem.DoButtonClick(Sender: TObject);
begin
  IsExpanded := not IsExpanded;
end;

procedure TTreeViewItem.SetIsExpanded(const Value: Boolean);
var
  LTreeView: TCustomTreeView;
begin
  if FIsExpanded <> Value then
  begin
    FIsExpanded := Value;
    UpdateExpandedButtonVisibility;
    InvalidateTextSize;
    LTreeView := TreeView;
    if Assigned(LTreeView) and not LTreeView.IsUpdating then
      LTreeView.RealignContent;
  end;
end;

procedure TTreeViewItem.HitTestReader(Reader: TReader);
begin
  Reader.SkipValue;
end;

{ TTreeViewContent }

type

  TTreeViewContent = class(TScrollContent)
  private
    FTreeView: TCustomTreeView;
  protected
    function GetFirstVisibleObjectIndex: Integer; override;
    function GetLastVisibleObjectIndex: Integer; override;
    procedure DoRealign; override;
  public
  end;

function TTreeViewContent.GetFirstVisibleObjectIndex: Integer;
var
  Item: TTreeViewItem;
begin
  if FTreeView.FGlobalList.Count > 0 then
  begin
    Item := FTreeView.FGlobalList[FTreeView.FFirstVisibleItem];
    while Item.ParentItem <> nil do
      Item := Item.ParentItem;
    Result := Item.Index;
  end
  else
    Result := 0;
end;

function TTreeViewContent.GetLastVisibleObjectIndex: Integer;
var
  Item: TTreeViewItem;
begin
  if FTreeView.FGlobalList.Count > 0 then
  begin
    if FTreeView.FLastVisibleItem >= FTreeView.FGlobalList.Count then
    begin
      Result := ControlsCount;
      Exit;
    end;
    Item := FTreeView.FGlobalList[FTreeView.FLastVisibleItem];
    while Item.ParentItem <> nil do
      Item := Item.ParentItem;
    Result := Item.Index + 1;
    if Result > ControlsCount then
      Result := ControlsCount;
  end
  else
    Result := ControlsCount;
end;

procedure TTreeViewContent.DoRealign;
begin
end;

{ TTreeView }

constructor TCustomTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FGlobalList := TList<TTreeViewItem>.Create;
  FGlobalList.Capacity := 100;
  FOddFill := TBrush.Create(TBrushKind.bkSolid, $20000000);
  DisableFocusEffect := True;
  CanFocus := True;
  AutoCapture := True;
  Width := 100;
  Height := 100;
  FItemHeight := 0;
  SetAcceptsControls(False);
end;

function TCustomTreeView.CreateScrollContent: TScrollContent;
begin
  Result := TTreeViewContent.Create(Self);
  TTreeViewContent(Result).FTreeView := Self;
end;

destructor TCustomTreeView.Destroy;
begin
  FreeAndNil(FSelections);
  FreeAndNil(FGlobalList);
  FreeAndNil(FOddFill);
  inherited;
end;

procedure TCustomTreeView.ApplyStyle;
var
  T: TFmxObject;
begin
  inherited ApplyStyle;
  T := FindStyleResource('content');
  if Assigned(T) and (T is TControl) then
  begin
    TControl(T).OnPainting := DoContentPaint;
  end;
  T := FindStyleResource('selection');
  if Assigned(T) and (T is TControl) then
  begin
    FSelection := TControl(T);
    FSelection.Visible := False;
  end;
  T := FindStyleResource('focusedselection');
  if Assigned(T) and (T is TControl) then
  begin
    FFocusedSelection := TControl(T);
    FFocusedSelection.Visible := False;
  end;
  T := FindStyleResource('AlternatingRowBackground');
  if Assigned(T) and (T is TBrushObject) then
    FOddFill.Assign(TBrushObject(T).Brush);
  if Assigned(T) and (T is TControl) then
    TControl(T).Visible := False;
  UpdateSelection;
end;

procedure TCustomTreeView.FreeStyle;
begin
  inherited FreeStyle;
  FSelection := nil;
  FFocusedSelection := nil;
  if Assigned(FSelections) then
    FSelections.Clear;
end;

procedure TCustomTreeView.UpdateGlobalIndexes;
var
  GlobalIdx: Integer;

  procedure AlignItem(AItem: TTreeViewItem);
  var
    i: Integer;
  begin
    if Assigned(AItem) then   //don't do anything if the item is nil
    begin
      AItem.FGlobalIndex := GlobalIdx;
      GlobalIdx := GlobalIdx + 1;
      FGlobalList.Add(AItem);
      if AItem.Count > 0 then
      begin
        if AItem.IsExpanded then
          for i := 0 to AItem.Count - 1 do
            AlignItem(AItem.ItemByIndex(i));
      end;
    end;
  end;

var
  i: Integer;
begin
  FGlobalList.Clear;
  GlobalIdx := 0;
  for i := 0 to Count - 1 do
    AlignItem(ItemByIndex(i)); //not all the items are of type TTreeViewItem, so some may return nil
  FGlobalCount := GlobalIdx;
end;

function CompareTreeItem(Item1, Item2: TFmxObject): Integer;
var
  LItem1TV: TCustomTreeView;
begin
  if (Item1 is TTreeViewItem) and (Item2 is TTreeViewItem) then
  begin
    LItem1TV := TTreeViewItem(Item1).TreeView;
    if Assigned(LItem1TV) and Assigned(LItem1TV.OnCompare) then
      Result := LItem1TV.OnCompare(TTreeViewItem(Item1),
        TTreeViewItem(Item2))
    else
      Result := CompareText(TTreeViewItem(Item1).Text,
        TTreeViewItem(Item2).Text);
  end
  else
    Result := 0;
end;

procedure TCustomTreeView.SortItems;
begin
  if not FSorted then
    Exit;
  Content.Sort(CompareTreeItem);
  UpdateGlobalIndexes;
  UpdateVisibleItems;
end;

function TCustomTreeView.GetItemRect(const Item: TTreeViewItem): TRectF;
var
  P: TPointF;
begin
  if Assigned(Item) then
  begin
    P := Item.LocaltoAbsolute(PointF(0, 0));
    P := Content.AbsoluteToLocal(P);
    Result := RectF(0, 0, Item.Width, Item.Height);
    OffsetRect(Result, P.X, P.Y);
  end
  else
    Result := RectF(0, 0, 0, 0);
end;

function TCustomTreeView.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := Items[AIndex];
end;

procedure TCustomTreeView.UpdateSelection;
var
  I: Integer;
  P: TPointF;
  R: TRectF;
  SelRects: array of TRectF;
  Clone: TControl;
  TmpObj : TFmxObject;
  Item: TTreeViewItem;
begin
  if not Assigned(FSelection) then
    Exit;
  // calc rects
  SetLength(SelRects, 0);
  if GlobalCount > 0 then
    for I := FFirstVisibleItem to FLastVisibleItem do
    begin
      Item := ItemByGlobalIndex(I);
      if Item.IsSelected then
      begin
        P := Item.LocaltoAbsolute(PointF(0, 0));
        if Assigned(FSelection.Parent) and (FSelection.Parent is TControl) then
          P := TControl(FSelection.Parent).AbsoluteToLocal(P);
        R := RectF(P.X, P.Y, P.X + Item.Width,
          P.Y + Item.Height);
        if (Length(SelRects) > 0) and (I > 0) and
           ItemByGlobalIndex(I - 1).IsSelected then
          SelRects[High(SelRects)] := UnionRect(R, SelRects[High(SelRects)])
        else
        begin
          SetLength(SelRects, Length(SelRects) + 1);
          SelRects[High(SelRects)] := R;
        end;
      end;
    end;
  // Create selection list
  if not Assigned(FSelections) then
    FSelections := TControlList.Create;
  for I := 0 to FSelections.Count - 1 do
  begin
    TmpObj := FSelections[I];
    FSelections[I] := nil;
    RemoveComponent(TmpObj);
    TmpObj.Parent := nil;
    TmpObj.Free;
  end;
  FSelections.Clear;
  // create selections
  for i := 0 to Length(SelRects) - 1 do
  begin
    if Self.IsFocused and Assigned(FFocusedSelection) then
      Clone := TControl(FFocusedSelection.Clone(Self))
    else
      Clone := TControl(FSelection.Clone(Self));
    Clone.StyleName := '';
    FSelections.Add(Clone);
    Clone.Parent := FSelection.Parent;
  end;
  // hide if not need
  if Length(SelRects) < FSelections.Count then
    for I := Length(SelRects) to FSelections.Count - 1 do
      FSelections[I].Visible := False;
  // align selections
  for i := 0 to High(SelRects) do
  begin
    FSelections[I].Visible := True;
    R := SelRects[I];
    FSelections[I].SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  end;
end;

procedure TCustomTreeView.UpdateVisibleItems;
var
  First, Last, Mid: Integer;
  R: TRectF;
begin
  First := 0;
  Last := GlobalCount - 1;
  while (First < Last) do
  begin
    Mid := First + (Last - First) div 2;
    R := FGlobalList[Mid].AbsoluteRect;
    R.TopLeft := AbsoluteToLocal(R.TopLeft);
    R.BottomRight := AbsoluteToLocal(R.BottomRight);
    if R.Bottom < 0 then
      First := Mid + 1
    else if R.Top > Height then
      Last := Mid
    else
      Break;
  end;
  FFirstVisibleItem := First;
  FLastVisibleItem := Last;
  TTreeViewContent(Content).RecalcUpdateRect;
  if Assigned(FNoItemsContent) then
    FNoItemsContent.SetBounds(Content.Position.X, Content.Position.Y, Content.Width, Content.Height);
end;

function TCustomTreeView.DoCalcContentBounds: TRectF;
var
  CurY: Single;
  R: TRectF;
  i: Integer;
  procedure UpdateSize(const AItem: TTreeViewItem);
  var
    I: Integer;
    OffsetX: Single;
    HasSubItems: Boolean;
    LItem: TTreeViewItem;
    ItemSize: TSizeF;
    P: TPointF;
    MinWidth: Single;
  begin
    if Assigned(AItem) and (AItem.IsVisible or (not AItem.IsVisible and (csDesigning in ComponentState))) then
    begin
      if Assigned(AItem.FButton) then
      begin
        HasSubItems := AItem.VisibleCount > 0;
        if AItem.FButton.Visible <> AItem.FButton.Visible then
        begin
          AItem.FButton.Visible := HasSubItems;
          AItem.InvalidateTextSize;
        end;
      end;
      AItem.ApplyStyleLookup;
      OffsetX := AItem.GetLevelOffset;
      MinWidth := R.Width - OffsetX - AItem.Margins.Left - AItem.Margins.Right;
      P.Create(OffsetX + AItem.Margins.Left, CurY + AItem.Margins.Top);
      P := Content.LocalToAbsolute(P);
      P := TControl(AItem.Parent).AbsoluteToLocal(P);
      ItemSize := AItem.MinItemSize;
      if (ItemSize.Width <= 0) or (ItemSize.Height <= 0) then
      begin
        if FItemHeight <> 0 then
          ItemSize.cy := FItemHeight
        else
          ItemSize.cy := 19;
        ItemSize.cx := MinWidth;
      end
      else
      begin
        if FItemHeight <> 0 then
          ItemSize.cy := FItemHeight;
        ItemSize.cx := Max(ItemSize.cx, MinWidth);
      end;
      CurY := CurY + ItemSize.cy + AItem.Margins.Top + AItem.Margins.Bottom;
      Result.Bottom := Max(Result.Bottom, CurY);
      Result.Right := Max(Result.Right, OffsetX + ItemSize.cx + AItem.Margins.Left + AItem.Margins.Right);
      AItem.SetBounds(P.X, P.Y, AItem.Width, ItemSize.cy);
      if (AItem.Count > 0) and AItem.IsExpanded then
      for I := 0 to AItem.Count - 1 do
      begin
        LItem := AItem.ItemByIndex(I);
        if ((csDesigning in LItem.ComponentState) and LItem.DesignVisible) or
           LItem.IsVisible then
          UpdateSize(LItem);
      end;
    end;
  end;

  procedure AlignItem(AItem: TTreeViewItem);
  var
    I: Integer;
    P: TPointF;
    LItem: TTreeViewItem;
  begin
    if Assigned(AItem) and (AItem.IsVisible or (not AItem.IsVisible and (csDesigning in ComponentState))) then
    begin
      P := Result.BottomRight;
      P := Content.LocalToAbsolute(P);
      P := TControl(AItem.Parent).AbsoluteToLocal(P);
      AItem.Width := P.X - AItem.Position.X;
      if AItem.Count > 0 then
        if AItem.IsExpanded then
          for I := 0 to AItem.Count - 1 do
          begin
            LItem := AItem.ItemByIndex(I);
            if ((csDesigning in LItem.ComponentState) and LItem.DesignVisible) or
               LItem.IsVisible then
              AlignItem(LItem);
          end;
    end;
  end;

begin
  UpdateGlobalIndexes;
  if IsUpdating then
    Exit;
  if not Assigned(ContentLayout) then
    Exit;
  R := ContentLayout.LocalRect;
  Result := R;
  if Result.Bottom = Result.Top then
    Result.Bottom := Result.Top + 1;
  { content }
  FCountExpanded := 0;
  if Assigned(Content) then
  begin
    { Sort if need }
    SortItems;
    { align }
    CurY := 0;
    FTextLayout :=  TTextLayoutManager.DefaultTextLayout.Create;
    try
      for i := 0 to Count - 1 do
        UpdateSize(ItemByIndex(i));
    finally
      FreeAndNil(FTextLayout);
    end;
    for i := 0 to Count - 1 do
      AlignItem(ItemByIndex(i));
  end;
  UpdateVisibleItems;
  UpdateSelection;
end;

procedure TCustomTreeView.ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                                 const ContentSizeChanged: boolean);
begin
  inherited;
  UpdateVisibleItems;
  UpdateSelection;
end;

function TCustomTreeView.ItemByIndex(const Idx: Integer): TTreeViewItem;
begin
  if (Idx >= 0) and (Idx < Count) then
  begin
    Assert(Content.Controls[Idx] is TTreeViewItem);
    Result := TTreeViewItem(Content.Controls[Idx]);
  end
  else
    raise ERangeError.CreateFMT(sArgumentOutOfRange_Index, [Idx, Count]);
end;

function TCustomTreeView.ItemByGlobalIndex(const Idx: Integer): TTreeViewItem;
begin
  Result := FGlobalList[Idx];
end;

function TCustomTreeView.ObjectAtPoint(P: TPointF): IControl;
var
  Local, Abs: TPointF;
  Inner: IControl;
  function CheckScrollBar(ScrollBar: TScrollBar): Boolean;
  var
    R: TRectF;
  begin
    Result := Assigned(ScrollBar) and
              (ScrollBar.Visible) and
              (ScrollBar.Enabled) and
              (ScrollBar.HitTest);
    if Result then
    begin
      R := ScrollBar.AbsoluteRect;
      Result := R.Contains(Abs);
    end;
  end;
begin
  Local := ScreenToLocal(P);
  if LocalRect.Contains(Local) then
  begin
    Abs := LocalToAbsolute(Local);
    if CheckScrollBar(VScrollBar) then
      Result := IControl(VScrollBar).ObjectAtPoint(P)
    else if CheckScrollBar(HScrollBar) then
      Result := IControl(HScrollBar).ObjectAtPoint(P)
    else
    begin
      if not Supports(ItemByPoint(Local.X, Local.Y), IControl, Result) then
        Result := inherited ObjectAtPoint(P)
      else
      begin
        Inner := Result.ObjectAtPoint(P);
        if Assigned(Inner) then
          Result := Inner
        else
          if CheckHitTest(HitTest) then
            Result := Self.AsIControl
          else
            Result := inherited ObjectAtPoint(P);
      end;
    end;
  end
  else
    Result := nil;
end;

function TCustomTreeView.ItemByPoint(const X, Y: Single): TTreeViewItem;
var
  I: Integer;
  P: TPointF;
  Item: TTreeViewItem;

  function PointInItem(const Itm: TTreeViewItem; const Pt: TPointF): Boolean;
  var
    ItemPt: TPointF;
  begin
    ItemPt := Item.AbsoluteToLocal(Pt);
    Result := Content.PointInObject(Pt.X, Pt.Y)
      and (ItemPt.Y >= (0 - TouchTargetExpansion.Top)) and (ItemPt.Y <= (Itm.Height + TouchTargetExpansion.Bottom));
  end;

begin
  P := LocaltoAbsolute(PointF(X, Y));
  if GlobalCount > 0 then
    for I := FFirstVisibleItem to FLastVisibleItem do
    begin
      Item := FGlobalList[I];
      if not Item.Visible then
        Continue;
      if not IntersectRect(Item.UpdateRect,
        UpdateRect) then
        Continue;
      if PointInItem(Item, P) then
      begin
        Result := Item;
        Exit;
      end
    end;
  Result := nil;
end;

function TCustomTreeView.ItemByText(const AText: string): TTreeViewItem;
var
  Item: TTreeViewItem;
  i: Integer;
begin
  Result := nil;
  for i := 0 to GlobalCount - 1 do
  begin
    Item := ItemByGlobalIndex(i);
    if CompareText(AText, Item.Text) = 0 then
    begin
      Result := Item;
      Exit;
    end;
  end;
end;

procedure TCustomTreeView.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);

  procedure SelectUpperItem;
  var
    i: Integer;
  begin
    if Selected.GlobalIndex > 0 then
    begin
      i := Selected.GlobalIndex - 1;
      while (i >= 0) and (ItemByGlobalIndex(i).GlobalIndex > 0) and (not ItemByGlobalIndex(i).IsVisible) do
        Dec(i);
      if (i >= 0) and ItemByGlobalIndex(i).IsVisible then
        Selected := ItemByGlobalIndex(i);
    end;
  end;

  procedure SelectLowerItem;
  var
    i: Integer;
  begin
    if Selected.GlobalIndex < GlobalCount - 1 then
    begin
      i := Selected.GlobalIndex + 1;
      while (i < GlobalCount) and (ItemByGlobalIndex(i).GlobalIndex < Pred(GlobalCount)) and (not ItemByGlobalIndex(i).IsVisible) do
        Inc(i);
      if (i < GlobalCount) and ItemByGlobalIndex(i).IsVisible then
        Selected := ItemByGlobalIndex(i);
    end;
  end;

var
  LSelParentItem : TTreeViewItem;
begin
  inherited KeyDown(Key, KeyChar, Shift);
  if (Count > 0) and Assigned(Selected) then
  begin
    case Key of
      vkAdd:
        Selected.Expand;
      vkSubtract:
        Selected.Collapse;
      vkHome:
        begin
          Selected := ItemByGlobalIndex(0);
          if not Selected.Visible then
            SelectLowerItem;
        end;
      vkEnd:
        begin
          Selected := ItemByGlobalIndex(GlobalCount - 1);
          if not Selected.Visible then
            SelectUpperItem;
        end;
      vkUp:
        SelectUpperItem;
      vkDown:
        SelectLowerItem;
      vkLeft:
        if Selected.IsExpanded then
          Selected.Collapse
        else
        begin
          LSelParentItem := Selected.ParentItem;
          if Assigned(LSelParentItem) then
          begin
            Selected := LSelParentItem;
            if not Selected.IsVisible then
              SelectUpperItem;
          end;
        end;
      vkRight:
        if not Selected.IsExpanded then
          Selected.Expand
        else
          if Selected.FContent.ControlsCount > 0 then
            SelectLowerItem;
    else
      Exit;
    end;
    Key := 0;
  end;
end;

procedure TCustomTreeView.KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited;
end;

function TCustomTreeView.LocalPointToHoveredItemLocalPoint(const AX, AY: Single): TPointF;
begin
  if Assigned(FHoveredItem) then
  begin
    Result := Self.LocalToScreen(PointF(AX, AY));
    Result := FHoveredItem.ScreenToLocal(Result);
  end;
end;

procedure TCustomTreeView.DragOver(const Data: TDragObject; const Point: TPointF;
  var Accept: Boolean);
var
  Obj: TTreeViewItem;
begin
  inherited DragOver(Data, Point, Accept);
  Obj := ItemByPoint(Point.X, Point.Y);
  if Obj <> FDragItem then
  begin
    if Assigned(FDragItem) then
    begin
      FDragItem.DragLeave;
      FDragItem.RemoveFreeNotify(Self);
    end;
    FDragItem := Obj;
    if Assigned(FDragItem) then
    begin
      FDragItem.AddFreeNotify(Self);
      FDragItem.DragEnter(Data, Point);
      Accept := True;
    end
    else
      Accept := False;
  end
  else
    Accept := True;

  if FDragItem = Selected then
    Accept := False;
end;

procedure TCustomTreeView.DragDrop(const Data: TDragObject; const Point: TPointF);
var
  Obj: TTreeViewItem;
  Allow: Boolean;
  P: TPointF;
begin
  inherited DragDrop(Data, Point);
  if Assigned(FDragItem) then
  begin
    FDragItem.DragLeave;
    FDragItem.RemoveFreeNotify(Self);
    FDragItem := nil;
  end;
  P := Point;
  Obj := ItemByPoint(P.X, P.Y);
  if not Assigned(Obj) then
  begin
    // to root
    Allow := True;
    if Assigned(OnDragChange) then
      OnDragChange(TTreeViewItem(Data.Source), nil, Allow);
    if Allow then
    begin
      TTreeViewItem(Data.Source).Parent := Self;
      TTreeViewItem(Data.Source).IsExpanded := True;
      RealignContent;
    end;
  end
  else
  begin
    Allow := True;
    if Assigned(OnDragChange) then
      OnDragChange(TTreeViewItem(Data.Source), Obj, Allow);
    if Allow then
    begin
      if not TTreeViewItem(Data.Source).isChild(Obj) then
      begin
        TTreeViewItem(Data.Source).Parent := Obj;
        if not Obj.IsExpanded then
          Obj.Expand;
        RealignContent;
      end;
    end;
  end;
end;

procedure TCustomTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);

  procedure TryMakeMultiSelect;
  var
    Item: TTreeViewItem;
  begin
    Item := ItemByPoint(X, Y);
    if not Assigned(Item) then
      Exit;

    if ([ssCtrl, ssCommand] * Shift) <> [] then
      Item.IsSelected := not Item.IsSelected
    else if ssShift in Shift then
    begin
      SelectRange(Selected, Item);
      Selected := Item;
    end
    else
    begin
      SelectRange(Item, Item);
      Selected := Item;
    end;
    FFirstSelect := Item;
  end;

  procedure TryMakeSingleSelectAndStartDrag;
  var
    LBitMap: TBitmap;
    Item: TTreeViewItem;
  begin
    Item := ItemByPoint(X, Y);
    if not Assigned(Item) then
      Exit;

    Selected := Item;
    if AllowDrag then
    begin
      LBitMap := Selected.MakeScreenshot;
      try
        Root.BeginInternalDrag(Selected, LBitMap);
      finally
        LBitMap.Free;
      end;
    end;
  end;

var
  P: TPointF;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if MouseInContentLayout(X, Y) then
  begin
    // Making selection of Items
    if Button = TMouseButton.mbLeft then
    begin
      if MultiSelect then
        TryMakeMultiSelect
      else
        TryMakeSingleSelectAndStartDrag;
      FMouseSelecting := True;
    end;
    // Transfer Click to Hovered Item
    if Assigned(FHoveredItem) then
    begin
      P := LocalPointToHoveredItemLocalPoint(X, Y);
      FHoveredItem.MouseDown(Button, Shift, P.X, P.Y);
    end;
  end;
end;

function TCustomTreeView.MouseInContentLayout(const X, Y: Single): Boolean;
var
  P: TPointF;
begin
  Result := False;
  if Assigned(ContentLayout) then
  begin
    P.Create(X, Y);
    P := LocalToAbsolute(P);
    Result := ContentLayout.AbsoluteRect.Contains(P);
  end;
end;

procedure TCustomTreeView.MouseMove(Shift: TShiftState; X, Y: Single);
var
  Item: TTreeViewItem;
  P: TPointF;
begin
  inherited MouseMove(Shift, X, Y);
  if MouseInContentLayout(X, Y) then
  begin
    Item := ItemByPoint(X, Y);
    SetHoveredItem(Item);
    if Assigned(FHoveredItem) then
    begin
      P := LocalPointToHoveredItemLocalPoint(X, Y);
      FHoveredItem.MouseMove(Shift, P.X, P.Y);
    end;
  end;
end;

procedure TCustomTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
begin
  inherited MouseUp(Button, Shift, X, Y);
  FFirstSelect := nil;
  FMouseSelecting := False;
  if Assigned(FHoveredItem) and MouseInContentLayout(X, Y) then
  begin
    P := LocalPointToHoveredItemLocalPoint(X, Y);
    FHoveredItem.MouseUp(Button, Shift, P.X, P.Y);
  end;
end;

procedure TCustomTreeView.MouseWheel(Shift: TShiftState; WheelDelta: Integer;
  var Handled: Boolean);
begin
  inherited;
  if Assigned(FHoveredItem) then
    FHoveredItem.MouseWheel(Shift, WheelDelta, Handled);
end;

procedure TCustomTreeView.ChangeOrder;
begin
  inherited ChangeOrder;
  InvalidateContentSize;
  if not IsUpdating then
    RealignContent;
end;

procedure TCustomTreeView.Clear;
var
  i: Integer;
  TmpObj: TFmxObject;
begin
  BeginUpdate;
  try
    if Assigned(Content) and (Count > 0) then
      for i := Content.ControlsCount - 1 downto 0 do
        if Content.Controls[i] is TTreeViewItem then
        begin
          TmpObj := Content.Controls[i];
          TmpObj.DisposeOf;
        end;
    FSelected := nil;
    FFirstVisibleItem := 0;
    FLastVisibleItem := 0;
    UpdateGlobalIndexes;
    UpdateSelection;
  finally
    EndUpdate;
  end;
end;

procedure TCustomTreeView.SelectRange(const Item1, Item2: TTreeViewItem);
var
  i: Integer;
  FirstItemIndex: Integer;
  LastItemIndex: Integer;
begin
  if not Assigned(Item1) or not Assigned(Item2) then
    Exit;
  FirstItemIndex := Min(Item1.GlobalIndex, Item2.GlobalIndex);
  LastItemIndex := Max(Item1.GlobalIndex, Item2.GlobalIndex);

  for i := 0 to FirstItemIndex - 1 do
    ItemByGlobalIndex(i).Deselect;
  for i := FirstItemIndex to LastItemIndex do
    ItemByGlobalIndex(i).Select;
  for i := LastItemIndex + 1 to GlobalCount - 1 do
    ItemByGlobalIndex(i).Deselect;
end;

procedure TCustomTreeView.ClearSelection;
var
  Item: TTreeViewItem;
begin
  for Item in FGlobalList do
    Item.IsSelected := False;
end;

procedure TCustomTreeView.SelectAll;
var
  i: Integer;
begin
  for i := 0 to GlobalCount - 1 do
    ItemByGlobalIndex(i).IsSelected := True;
end;

procedure TCustomTreeView.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TCustomTreeView.DoChangeCheck(const Item: TTreeViewItem);
begin
  if Assigned(FOnChangeCheck) then
    FOnChangeCheck(Item);
end;

procedure TCustomTreeView.DoContentPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  I: Integer;
  Item: TTreeViewItem;
  P: TPointF;
  R: TRectF;
begin
  if Assigned(Content) and Assigned(ContentLayout) then
  begin
    if FAlternatingRowBackground then
    begin
      Canvas.Fill.Assign(FOddFill);
      for I := FFirstVisibleItem to FLastVisibleItem  do
      begin
        if Odd(I) then
        begin
          Item := ItemByGlobalIndex(I);
          P := Item.LocalToAbsolute(PointF(0, 0));
          P := TControl(Sender).AbsoluteToLocal(P);
          R := RectF(0, P.Y, ContentLayout.Width, P.Y + Item.Height);
          if not IntersectRect(R, ARect) then
            Continue;
          Canvas.FillRect(R, 0, 0, [], AbsoluteOpacity);
        end;
      end;
    end;
  end;
end;

procedure TCustomTreeView.DoEnter;
begin
  inherited DoEnter;
  if Assigned(Selected) then
    UpdateSelection;
end;

procedure TCustomTreeView.DoExit;
begin
  inherited DoExit;
  if Assigned(Selected) then
    UpdateSelection;
end;

procedure TCustomTreeView.DoInsertObject(Index: Integer;
  const AObject: TFmxObject);
begin
  if Assigned(Content) and ((AObject is TTreeViewItem)) then
    Content.InsertObject(Index, AObject)
  else
    inherited DoInsertObject(Index, AObject);
end;

procedure TCustomTreeView.DoAddObject(const AObject: TFmxObject);
begin
  if Assigned(Content) and ((AObject is TTreeViewItem)) then
    Content.AddObject(AObject)
  else
    inherited DoAddObject(AObject);
end;

procedure TCustomTreeView.DoRemoveObject(const AObject: TFmxObject);
begin
  if (AObject is TTreeViewItem) and (TTreeViewItem(AObject).TreeView = Self) then
    TTreeViewItem(AObject).Parent := nil
  else
    inherited DoRemoveObject(AObject);
end;

procedure TCustomTreeView.DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations);
begin
  inherited;
  AAniCalculations.AutoShowing := False;
  AAniCalculations.Animation := False;
  AAniCalculations.BoundsAnimation := False;
end;

function TCustomTreeView.IsAddToContent(const AObject: TFmxObject): Boolean;
begin
  Result := inherited IsAddToContent(AObject) and (AObject <> FNoItemsContent);
end;

function TCustomTreeView.IsOpaque: Boolean;
begin
  Result := True;
end;

procedure TCustomTreeView.ContentAddObject(const AObject: TFmxObject);
begin
  if not (AObject is TTreeViewItem) then
  begin
    if not Assigned(FNoItemsContent) then
    begin
      FNoItemsContent := TContent.Create(Self);
      FNoItemsContent.Parent := Self;
      FNoItemsContent.SetBounds(0, 0, 0, 0);
      FNoItemsContent.Stored := False;
      FNoItemsContent.Locked := True;
      FNoItemsContent.HitTest := False;
    end;
    FNoItemsContent.AddObject(AObject)
  end
  else
  begin
    InvalidateContentSize;
    if not IsUpdating then
      RealignContent;
  end;
end;

procedure TCustomTreeView.ContentInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  ContentAddObject(AObject);
end;

procedure TCustomTreeView.ContentRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TTreeViewItem then
  begin
    TTreeViewItem(AObject).IsSelected := False;
    if AObject = FSelected then
      FSelected := nil;
    InvalidateContentSize;
    if not IsUpdating then
      Realign;
  end;
end;

procedure TCustomTreeView.SetSelected(const Value: TTreeViewItem);
var
  LFmxObject: TFmxObject;
  P: TPointF;
begin
  if FSelected <> Value then
  begin
    if Assigned(FSelected) and not MultiSelect then
      FSelected.IsSelected := False;

    FSelected := Value;
    if Assigned(FSelected) and Assigned(Content) then
    begin
      LFmxObject := FSelected.Parent;
      while (Assigned(LFmxObject) and not (LFmxObject is TCustomTreeView)) do
      begin
        if (LFmxObject is TTreeViewItem) then
          TTreeViewItem(LFmxObject).Expand;
        LFmxObject := LFmxObject.Parent;
      end;
      if Assigned(Content) and Assigned(ContentLayout) and Assigned(VScrollBar)
      then
      begin
        P := ContentLayout.AbsoluteToLocal(FSelected.LocaltoAbsolute(PointF(0, 0)));
        if P.Y < 0 then
          VScrollBar.Value := VScrollBar.Value + P.Y;
        if P.Y + FSelected.Margins.Top + FSelected.Margins.Bottom +
          FSelected.Height > ContentLayout.Height then
          VScrollBar.Value := VScrollBar.Value +
            (P.Y + FSelected.Margins.Top + FSelected.Margins.Bottom +
            FSelected.Height - ContentLayout.Height);
      end;
      FSelected.IsSelected := True;
    end;
    DoChange;
  end;
end;

procedure TCustomTreeView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSelected) then
    FSelected := nil;
  if (Operation = opRemove) and (AComponent = FDragItem) then
    FDragItem := nil;
end;

procedure TCustomTreeView.SetItemHeight(const Value: Single);
begin
  if FItemHeight <> Value then
  begin
    FItemHeight := Value;
    RealignContent;
  end;
end;

procedure TCustomTreeView.CollapseAll;
var
  i: Integer;
  Item: TTreeViewItem;
begin
  BeginUpdate;
  try
    for i := Count - 1 downto 0 do
    begin
      Item := Items[i];
      if Assigned(Item) then
        Item.CollapseAll;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomTreeView.ExpandAll;
var
  i: Integer;
  Item: TTreeViewItem;
begin
  BeginUpdate;
  try
    for i := Count - 1 downto 0 do
    begin
      Item := Items[i];
      if Assigned(Item) then
        Item.ExpandAll;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomTreeView.SetCheckboxesVisibility(const Value: Boolean);
var
  i: Integer;
  Item : TTreeViewItem;
begin
  if FShowCheckboxes <> Value then
  begin
    FShowCheckboxes := Value;
    for i := 0 to Count - 1 do
    begin
      Item := Items[i];
      if Assigned(Item) then
        Item.UpdateCheckBoxVisibility;
    end;
    RealignContent;
  end;
end;

function TCustomTreeView.GetTreeItem(Index: Integer): TTreeViewItem;
begin
  Result := ItemByIndex(Index);
end;

procedure TCustomTreeView.SetSorted(const Value: Boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    RealignContent;
  end;
end;

procedure TCustomTreeView.SetAllowDrag(const Value: Boolean);
begin
  if FAllowDrag <> Value then
  begin
    FAllowDrag := Value;
    if FAllowDrag then
      EnableDragHighlight := True;
  end;
end;

procedure TCustomTreeView.SetAlternatingRowBackground(const Value: Boolean);
begin
  if FAlternatingRowBackground <> Value then
  begin
    FAlternatingRowBackground := Value;
    Repaint;
  end;
end;

procedure TCustomTreeView.SetHoveredItem(const Value: TTreeViewItem);
begin
  if FHoveredItem <> Value then
  begin
    if Assigned(FHoveredItem) then
      FHoveredItem.DoMouseLeave;
    FHoveredItem := Value;
    if Assigned(FHoveredItem) then
      FHoveredItem.DoMouseEnter;
  end;
end;

function TCustomTreeView.GetCount: Integer;
begin
  Result := 0;
  if Assigned(Content) then
    Result := Content.ControlsCount;
end;

initialization
  RegisterFmxClasses([TTreeView, TTreeViewItem]);
end.
