{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Header;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, FMX.Types, FMX.StdCtrls, FMX.Controls, FMX.Graphics;

type
  THeader = class;

  THeaderItem = class(TCustomCornerButton)
  private const
    DragTolerance = 3;
  private
    FSplitter: TControl;
    FLeftSplitter: TControl;
    FDragging: Boolean;
    FDownPos: TPointF;
    [Weak] FHeader: THeader;
    function AllowDrag: Boolean;
    procedure UpdateSplitter;
    procedure SplitterMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure SplitterMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    function GetPredItem: THeaderItem;
  protected
    procedure Click; override;
    procedure DragEnd; override;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    procedure DoSplitterMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure DoLeftSplitterMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure SetVisible(const Value: Boolean); override;
    procedure ParentChanged; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure PaintChildren; override;
    procedure DrawItem(const Canvas: TCanvas; const Rect: TRectF); virtual;
    /// <summary> This virtual method is called when user began resizing of item with the mouse </summary>
    procedure Resizing; virtual;
    /// <summary> This virtual method is called when user finished resizing of item with the mouse </summary>
    procedure Resized; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    property Header: THeader read FHeader;
  published
    property Align;
    property CanFocus default False;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property Text;
    property StyledSettings;
    property TextSettings;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property OnApplyStyleLookup;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
  end;

{ THeader }

  TOnRealignItemEvent = procedure(Sender: TObject; OldIndex, NewIndex: Integer) of object;

  TOnResizeItemEvent = procedure(Sender: TObject; var NewSize: Single) of object;

  THeaderItemClick = procedure(Item: THeaderItem) of object;

  TDrawHeaderItemEvent = procedure (Sender: TObject; const Canvas: TCanvas; const Item: THeaderItem; const Bounds: TRectF) of object;

  THeader = class(TStyledControl, IItemsContainer)
  private
    FOnRealignItem: TOnRealignItemEvent;
    FOnResizeItem: TOnResizeItemEvent;
    FOffset: Single;
    FLastItem: THeaderItem;
    FRadius: Single;
    FSides: TSides;
    FOnItemClick: THeaderItemClick;
    FDragReorder: Boolean;
    FSizing: Boolean;
    FOnDrawItem: TDrawHeaderItemEvent;
    function GetHeaderItem(Index: Integer): THeaderItem;
    procedure SetRadius(const Value: Single);
    procedure SetSides(const Value: TSides);
    function GetCount: Integer;
    { IItemContainer }
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    procedure SetDragReorder(const Value: Boolean);
    procedure SetSizing(const Value: Boolean);
    procedure UpdateSplitters;
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoItemClick(const Item: THeaderItem); virtual;
    property Offset: Single read FOffset write FOffset; // hscroll offset used in grid
    property LastItem: THeaderItem read FLastItem;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoDrawHeader(const Canvas: TCanvas; const Item: THeaderItem; const Bounds: TRectF);
  public
    constructor Create(AOwner: TComponent); override;
    procedure BeforeDestruction; override;
    procedure Paint; override;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: THeaderItem read GetHeaderItem;
  published
    property Sides: TSides read FSides write SetSides;
    property Anchors;
    property Align;
    property CanFocus default False;
    property CanParentFocus;
    property ClipChildren default True;
    property ClipParent default False;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property DragReorder: Boolean read FDragReorder write SetDragReorder default True;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Sizing: Boolean read FSizing write SetSizing default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property Radius: Single read FRadius write SetRadius;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
//    property ShowHint default False;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
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
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnDrawItem: TDrawHeaderItemEvent read FOnDrawItem write FOnDrawItem;
    property OnRealignItem: TOnRealignItemEvent read FOnRealignItem write FOnRealignItem;
    property OnResizeItem: TOnResizeItemEvent read FOnResizeItem write FOnResizeItem;
    property OnItemClick: THeaderItemClick read FOnItemClick write FOnItemClick;
  end;


implementation

uses
  FMX.Consts;

type
  TOpenControl = class (TControl);

{ THeaderItem }

procedure THeaderItem.Click;
begin
  inherited;
  if FHeader <> nil then
    FHeader.DoItemClick(Self);
end;

constructor THeaderItem.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := False;
  TextAlign := TTextAlign.Leading;
  FSplitter := TControl.Create(Self);
  FSplitter.Parent := Self;
  FSplitter.Width := 3;
  FSplitter.Align := TAlignLayout.Right;
  FSplitter.Locked := True;
  FSplitter.Stored := False;
  FSplitter.HitTest := True;
  FSplitter.AutoCapture := True;
  FSplitter.Cursor := crSizeWE;
  FSplitter.OnMouseMove := DoSplitterMouseMove;
  FSplitter.OnMouseDown := SplitterMouseDown;
  FSplitter.OnMouseUp := SplitterMouseUp;
  FLeftSplitter := TControl.Create(Self);
  FLeftSplitter.Parent := Self;
  FLeftSplitter.Width := 3;
  FLeftSplitter.Align := TAlignLayout.Left;
  FLeftSplitter.Locked := True;
  FLeftSplitter.Stored := False;
  FLeftSplitter.HitTest := True;
  FLeftSplitter.AutoCapture := True;
  FLeftSplitter.Cursor := crSizeWE;
  FLeftSplitter.OnMouseMove := DoLeftSplitterMouseMove;
  FLeftSplitter.OnMouseDown := SplitterMouseDown;
  FLeftSplitter.OnMouseUp := SplitterMouseUp;
end;

function THeaderItem.GetPredItem: THeaderItem;
var
  I: Integer;
begin
  Result := nil;
  if Header <> nil then
  begin
    I := Index - 1;
    while I >= 0 do
      if Header.Children[I] is THeaderItem then
        Exit(THeaderItem(Header.Children[I]))
      else
        Dec(I);
  end;
end;

procedure THeaderItem.DoLeftSplitterMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
  PredItem: THeaderItem;
begin
  if TOpenControl(FLeftSplitter).Pressed then
  begin
    PredItem := GetPredItem;
    if PredItem <> nil then
    begin
      P := FLeftSplitter.LocalToAbsolute(PointF(X, Y));
      P := PredItem.FSplitter.AbsoluteToLocal(P);
      TOpenControl(PredItem.FSplitter).Pressed := True;
      PredItem.DoSplitterMouseMove(Sender, Shift, P.X, P.Y);
      TOpenControl(PredItem.FSplitter).Pressed := False;
    end;
  end;
end;

procedure THeaderItem.DoSplitterMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
var
  NewSize: Single;
begin
  if TOpenControl(FSplitter).Pressed then
  begin
    NewSize := AbsoluteToLocal(FSplitter.LocalToAbsolute(PointF(X, Y))).X;
    if NewSize < 0 then
      NewSize := 0;

    if Header <> nil then
    begin
      if Assigned(Header.OnResizeItem) then
        Header.OnResizeItem(Self, NewSize);
    end;
    Width := NewSize;
    if Header <> nil then
      Header.Realign;
  end;
end;

procedure THeaderItem.DragDrop(const Data: TDragObject; const Point: TPointF);
var
  NewIndex, OldIndex: Integer;
  LHeader : THeader;
begin
  inherited;
  NewIndex := Index;
  OldIndex := TFmxObject(Data.Source).Index;
  TFmxObject(Data.Source).Index := Index;
  LHeader := Header;
  if (LHeader <> nil) and Assigned(LHeader.OnRealignItem) then
    LHeader.OnRealignItem(TFmxObject(Data.Source), OldIndex, NewIndex);
  FDragging := False;
end;

procedure THeaderItem.DragEnd;
begin
  inherited;
  FDragging := False;
end;

procedure THeaderItem.DragOver(const Data: TDragObject; const Point: TPointF;
  var Operation: TDragOperation);
begin
  if (Data.Source is THeaderItem) and (THeaderItem(Data.Source).Header = Header) and AllowDrag then
    Operation := TDragOperation.Move
  else
    Operation := TDragOperation.None;
end;

procedure THeaderItem.DrawItem(const Canvas: TCanvas; const Rect: TRectF);
begin
  if FHeader <> nil then
    FHeader.DoDrawHeader(Canvas, Self, Rect);
end;

procedure THeaderItem.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  FDragging := False;
  FDownPos := TPointF.Create(X, Y);
end;

function THeaderItem.AllowDrag: Boolean;
begin
  Result := (FHeader <> nil) and (FHeader.DragReorder) and (Header.LastItem <> Self);
end;

procedure THeaderItem.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (ssLeft in Shift) and not FDragging and ((FDownPos - TPointF.Create(X, Y)).Length > DragTolerance) and AllowDrag then
  begin
    FDragging := True;
    ReleaseCapture;
    BeginAutoDrag;
    RestoreButtonState;
  end;
end;

procedure THeaderItem.PaintChildren;
begin
  inherited;
  Canvas.SetMatrix(AbsoluteMatrix);
  DrawItem(Canvas, LocalRect);
end;

procedure THeaderItem.SetVisible(const Value: Boolean);
begin
  if inherited Visible <> Value then
  begin
    inherited;
    if Header <> nil then
      Header.Realign;
  end;
end;

procedure THeaderItem.SplitterMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  PredItem: THeaderItem;
begin
  if Button in [TMouseButton.mbLeft, TMouseButton.mbRight] then
  begin
    if Sender = FLeftSplitter then
    begin
      PredItem := GetPredItem;
      if PredItem <> nil then
        PredItem.Resizing;
    end
    else
      Resizing;
  end;
end;

procedure THeaderItem.SplitterMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  PredItem: THeaderItem;
begin
  if Button in [TMouseButton.mbLeft, TMouseButton.mbRight] then
  begin
    if Sender = FLeftSplitter then
    begin
      PredItem := GetPredItem;
      if PredItem <> nil then
        PredItem.Resized;
    end
    else
      Resized;
  end;
end;

procedure THeaderItem.UpdateSplitter;
begin
  if FHeader <> nil then
  begin
    FSplitter.HitTest := FHeader.Sizing;
    FLeftSplitter.HitTest := FHeader.Sizing;
  end;
end;

procedure THeaderItem.ParentChanged;
begin
  inherited;
  if (Parent is THeader) then
  begin
    FHeader := THeader(Parent);
    UpdateSplitter;
  end
  else
    FHeader := nil;
end;

procedure THeaderItem.Resized;
begin

end;

procedure THeaderItem.Resizing;
begin

end;

type
  TLastItem = class (THeaderItem)
  private
    FIsCanFree: Boolean;
  protected
    function GetDefaultStyleLookupName: string; override;
  public
    destructor Destroy; override;
  end;

{ TLastItem }

destructor TLastItem.Destroy;
begin
  if not FIsCanFree then
  begin
    if Owner is THeader then
      THeader(Owner).RemoveObject(Self);
    raise EComponentError.Create(SCannotDeleteDefColumn);
  end;
  inherited;
end;

function TLastItem.GetDefaultStyleLookupName: string;
begin
  Result := 'headeritemstyle';
end;

{ THeader }

constructor THeader.Create(AOwner: TComponent);
begin
  inherited;
  ClipChildren := True;
  FSizing := True;
  FDragReorder := True;
  FSides := AllSides;
  FLastItem := TLastItem.Create(self);
  FLastItem.Parent := Self;
  FLastItem.Stored := False;
  FLastItem.Locked := True;
  FLastItem.Width := 50;
  FLastItem.DragMode := TDragMode.dmManual;
  FLastItem.FSplitter.Visible := False;
  SetAcceptsControls(False);
end;

procedure THeader.BeforeDestruction;
begin
  inherited;
  if FLastItem <> nil then
    TLastItem(FLastItem).FIsCanFree := True;
end;

procedure THeader.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is THeaderItem then
    Realign;
end;

procedure THeader.DoDrawHeader(const Canvas: TCanvas; const Item: THeaderItem; const Bounds: TRectF);
begin
  if Assigned(FOnDrawItem) then
    FOnDrawItem(Self, Canvas, Item, Bounds);
end;

procedure THeader.DoItemClick(const Item: THeaderItem);
begin
  if Assigned(OnItemClick) then
    OnItemClick(Item);
end;

procedure THeader.DoRealign;
var
  R: TRectF;

  procedure DoPosition(Control: TControl);
  begin
    if not Control.Visible then
      Exit;
    Control.SetBounds(R.Left, R.Top, Control.Width, R.Height);
    if Control <> FLastItem then
      R.Left := R.Left + Control.Width;
  end;

  procedure DoAlign;
  var
    I: Integer;
  begin
    for I := 0 to ChildrenCount - 1 do
    begin
      if not(TControl(Children[I]) is THeaderItem) then
        Continue;
      DoPosition(TControl(Children[I]));
      // sides
      THeaderItem(Children[I]).Sides := FSides;
      // corners
      THeaderItem(Children[I]).XRadius := Radius;
      THeaderItem(Children[I]).YRadius := Radius;
      if I = 0 then
      begin
        THeaderItem(Children[I]).Corners := [TCorner.TopLeft];
        THeaderItem(Children[I]).Sides := THeaderItem(Children[I]).Sides + (FSides * [TSide.Left]) - [TSide.Right];
      end
      else if Children[I] = FLastItem then
      begin
        THeaderItem(Children[I]).Corners := [TCorner.TopRight];
        THeaderItem(Children[I]).Sides := THeaderItem(Children[I]).Sides + [TSide.Left];
      end
      else
      begin
        THeaderItem(Children[I]).Corners := [];
        THeaderItem(Children[I]).Sides := THeaderItem(Children[I]).Sides + [TSide.Left] - [TSide.Right];
      end;
    end;
  end;

begin
//  inherited;
  if csDestroying in ComponentState then
    Exit;
  if FDisableAlign then
    Exit;
  if ChildrenCount = 0 then
    Exit;
  if FLastItem <> nil then
  begin
    FDisableAlign := True;
    try
      FLastItem.Index := Children.Count - 1;

      R := TRectF.Create(FOffset, 0, FSize.Width, FSize.Height);
      R := Padding.PaddingRect(R);
      DoAlign;

      if R.Left > R.Right then
        FLastItem.Width := 0
      else
        FLastItem.Width := R.Right - R.Left;
    finally
      FDisableAlign := False;
    end;
  end;
end;

function THeader.GetCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to ChildrenCount - 1 do
    if Children[i] is THeaderItem then
      Result := Result + 1;
end;

function THeader.GetHeaderItem(Index: Integer): THeaderItem;
var
  i, C: Integer;
begin
  Result := nil;
  C := 0;
  for i := 0 to Children.Count - 1 do
    if Children[i] is THeaderItem then
    begin
      if C = Index then
      begin
        Result := THeaderItem(Children[i]);
        Break;
      end;
      C := C + 1;
    end;
end;

function THeader.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := Items[AIndex];
end;

function THeader.GetItemsCount: Integer;
begin
  Result := Count;
end;

procedure THeader.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if (AComponent is THeaderItem) then
    begin
      RemoveObject(THeaderItem(AComponent));
      if ([csLoading, csDestroying] * ComponentState = []) then
        Realign;
      if AComponent = FLastItem then
        FLastItem := nil;
    end;
  end;
end;

procedure THeader.Paint;
var
  R: TRectF;
begin
  inherited Paint;
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

procedure THeader.SetDragReorder(const Value: Boolean);
begin
  if FDragReorder <> Value then
    FDragReorder := Value;
end;

procedure THeader.UpdateSplitters;
var
  I: Integer;
begin
  for I := 0 to Controls.Count - 1 do
    if Controls[i] is THeaderItem then
      THeaderItem(Controls[i]).UpdateSplitter;
end;

procedure THeader.SetSizing(const Value: Boolean);
begin
  if FSizing <> Value then
  begin
    FSizing := Value;
    UpdateSplitters;
  end;
end;

procedure THeader.SetRadius(const Value: Single);
begin
  if FRadius <> Value then
  begin
    FRadius := Value;
    Realign;
  end;
end;

procedure THeader.SetSides(const Value: TSides);
begin
  if FSides <> Value then
  begin
    FSides := Value;
    Realign;
  end;
end;

initialization
  RegisterFmxClasses([THeader, THeaderItem]);
end.
