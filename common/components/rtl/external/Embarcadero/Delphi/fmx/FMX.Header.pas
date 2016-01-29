{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2013 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit FMX.Header;

interface
uses
  System.Classes, System.Types, System.UITypes, System.Rtti, System.SysUtils,
  FMX.Types, FMX.Layouts, FMX.StdCtrls, FMX.Controls;

type
  THeader = class;

  THeaderItem = class(TCustomCornerButton)
  private
    FSplitter: TControl;
    FLeftSplitter: TControl;
  protected
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    procedure DoSplitterMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure DoLeftSplitterMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    function Header: THeader;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property CanFocus default False;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmAutomatic;
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
    property StyleLookup;
    property TabOrder;
    property Text;
    property TextAlign default TTextAlign.taLeading;
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
  end;

{ THeader }

  TOnRealignItemEvent = procedure(Sender: TObject; OldIndex, NewIndex: Integer) of object;
  TOnResizeItemEvent = procedure(Sender: TObject; var NewSize: Single) of object;

  THeader = class(TStyledControl, IItemsContainer)
  private
    FOnRealignItem: TOnRealignItemEvent;
    FOnResizeItem: TOnResizeItemEvent;
    FOffset: Single;
    FLastItem: THeaderItem;
    FRadius: Single;
    FSides: TSides;
    function GetHeaderItem(Index: Integer): THeaderItem;
    procedure SetRadius(const Value: Single);
    procedure SetSides(const Value: TSides);
    function GetCount: Integer;
    { IItemContainer }
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    property Offset: Single read FOffset write FOffset; // hscroll offset used in grid
    property LastItem: THeaderItem read FLastItem;
  public
    constructor Create(AOwner: TComponent); override;
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
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
//    property Hint;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property Radius: Single read FRadius write SetRadius;
    property RotationAngle;
    property RotationCenter;
    property Scale;
//    property ShowHint default False;
    property StyleLookup;
    property TabOrder;
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

    property OnRealignItem: TOnRealignItemEvent read FOnRealignItem write FOnRealignItem;
    property OnResizeItem: TOnResizeItemEvent read FOnResizeItem write FOnResizeItem;
  end;


implementation

type
  TOpenControl = class (TControl);

{ THeaderItem }

constructor THeaderItem.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := False;
  TextAlign := TTextAlign.taLeading;
  DragMode := TDragMode.dmAutomatic;
  FSplitter := TControl.Create(Self);
  FSplitter.Parent := Self;
  FSplitter.Width := 3;
  FSplitter.Align := TAlignLayout.alRight;
  FSplitter.Locked := True;
  FSplitter.Stored := False;
  FSplitter.HitTest := True;
  FSplitter.AutoCapture := True;
  FSplitter.Cursor := crSizeWE;
  FSplitter.OnMouseMove := DoSplitterMouseMove;
  FLeftSplitter := TControl.Create(Self);
  FLeftSplitter.Parent := Self;
  FLeftSplitter.Width := 3;
  FLeftSplitter.Align := TAlignLayout.alLeft;
  FLeftSplitter.Locked := True;
  FLeftSplitter.Stored := False;
  FLeftSplitter.HitTest := True;
  FLeftSplitter.AutoCapture := True;
  FLeftSplitter.Cursor := crSizeWE;
  FLeftSplitter.OnMouseMove := DoLeftSplitterMouseMove;
end;

procedure THeaderItem.DoLeftSplitterMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
  LeftItem: THeaderItem;
begin
  LeftItem := nil;
  if (Index > 0) and TOpenControl(FLeftSplitter).FPressed then
  begin
    if Assigned(Parent) and (Parent is THeader) then
      LeftItem := THeaderItem(THeader(Parent).Children[Index - 1]);
    if not Assigned(LeftItem) then
      Exit;

    P := FLeftSplitter.LocalToAbsolute(PointF(X, Y));

    P := LeftItem.FSplitter.AbsoluteToLocal(P);
    TOpenControl(LeftItem.FSplitter).FPressed := True;
    LeftItem.DoSplitterMouseMove(Sender, Shift, P.X, P.Y);
    TOpenControl(LeftItem.FSplitter).FPressed := False;
  end;
end;

procedure THeaderItem.DoSplitterMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
var
  NewSize: Single;
begin
  if TOpenControl(FSplitter).FPressed then
  begin
    NewSize := AbsoluteToLocal(FSplitter.LocalToAbsolute(PointF(X, Y))).X;
    if NewSize < 0 then
      NewSize := 0;

    if Assigned(Parent) and (Parent is THeader) then
    begin
      if Assigned(THeader(Parent).OnResizeItem) then
        THeader(Parent).OnResizeItem(Self, NewSize);
    end;
    Width := NewSize;
    if Assigned(Parent) and (Parent is THeader) then
      THeader(Parent).Realign;
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
  if Assigned(LHeader) and Assigned(LHeader.OnRealignItem) then
    LHeader.OnRealignItem(TFmxObject(Data.Source), OldIndex, NewIndex);
end;

procedure THeaderItem.DragOver(const Data: TDragObject; const Point: TPointF;
  var Accept: Boolean);
begin
  Accept := (Data.Source is THeaderItem) and
    (THeaderItem(Data.Source).Header = Header) and (DragMode <> TDragMode.dmManual);
end;

function THeaderItem.Header: THeader;
begin
  if Assigned(Parent) and (Parent is THeader) then
    Result := THeader(Parent)
  else
    Result := nil;
end;

{ THeader }

constructor THeader.Create(AOwner: TComponent);
begin
  inherited;
  ClipChildren := True;
  FSides := AllSides;
  FLastItem := THeaderItem.Create(nil);
  FLastItem.Parent := Self;
  FLastItem.Stored := False;
  FLastItem.Locked := True;
  FLastItem.Width := 50;
  FLastItem.DragMode := TDragMode.dmManual;
  FLastItem.FSplitter.Visible := False;
  SetAcceptsControls(False);
end;

procedure THeader.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is THeaderItem then
    Realign;
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
    i: Integer;
  begin
    for i := 0 to ChildrenCount - 1 do
    begin
      if not(TControl(Children[i]) is THeaderItem) then
        Continue;
      DoPosition(TControl(Children[i]));
      // sides
      THeaderItem(Children[i]).Sides := FSides;
      // corners
      THeaderItem(Children[i]).XRadius := Radius;
      THeaderItem(Children[i]).YRadius := Radius;
      if i = 0 then
      begin
        THeaderItem(Children[i]).Corners := [TCorner.crTopLeft];
        THeaderItem(Children[i]).Sides := THeaderItem(Children[i]).Sides +
          (FSides * [TSide.sdLeft]) - [TSide.sdRight];
      end
      else if Children[i] = FLastItem then
      begin
        THeaderItem(Children[i]).Corners := [TCorner.crTopRight];
        THeaderItem(Children[i]).Sides := THeaderItem(Children[i]).Sides +
          [TSide.sdLeft];
      end
      else
      begin
        THeaderItem(Children[i]).Corners := [];
        THeaderItem(Children[i]).Sides := THeaderItem(Children[i]).Sides +
          [TSide.sdLeft] - [TSide.sdRight];
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
  FDisableAlign := True;
  try
    FLastItem.Index := Children.Count - 1;

    R := RectF(FOffset, 0, FWidth, FHeight);
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
