unit fcShapeBtn;
{
//
// Components : TfcShapeBtn
//
// Copyright (c) 1999 by Woll2Woll Software
// Revision: History
// 5/10/99 - PYW - Fixed Flat Style painting bug in High Color mode.
//
}

interface

{$i fcIfDef.pas}

uses Windows, Messages, Classes, Controls, Forms, Graphics, StdCtrls,
  CommCtrl, Buttons, Dialogs, Math, Consts, SysUtils, fcCommon, fcText,
  fcButton, fcImgBtn, fcEvaluator, fcBitmap
  {$ifdef fcDelphi4up}
  ,ImgList, ActnList
  {$endif};

const DEFUNUSECOLOR = clRed;
      DEFUNUSECOLOR2 = clBlue;

type
  TfcShapeOrientation = (soLeft, soRight, soUp, soDown);

  PfcPolyGonPoints = ^TFCPolyGonPoints;
  TfcPolyGonPoints = array[0..0] of TPoint;

  TfcButtonShape = (bsRoundRect, bsEllipse, bsTriangle, bsArrow, bsDiamond,
    bsRect, bsStar, bsTrapezoid, bsCustom);

  TfcCustomShapeBtn = class(TfcCustomImageBtn)
  private
    // Property Storage Variables
    FPointList: TStringList;
    FShape: TfcButtonShape;
    FOrientation: TfcShapeOrientation;
    FRoundRectBias: Integer;
    FRegionBitmap: TBitmap;

    // Propety Access Methods
    procedure SetShape(Value: TfcButtonShape);
    procedure SetOrientation(Value: TfcShapeOrientation);
    procedure SetPointList(Value: TStringList);
    procedure SetRoundRectBias(Value: Integer);
    function CorrectedColor: TColor;
  protected
    procedure WndProc(var Message: TMessage); override;
    function StoreRegionData: Boolean; override;
    function UnusableColor: TColor;
    procedure AssignTo(Dest: TPersistent); override;
    procedure Draw3dLines(Bitmap: TfcBitmap; PointList: array of TPoint;
      NumPoints: Integer; TransColor: TColor);
    procedure SetPointToOrientation(Points: PFCPolygonPoints;
      NumPoints: Integer; Orientation: TfcShapeOrientation; Size: TSize);
    function GetCustomPoints(var Points: PFCPolygonPoints; Size: TSize): Integer;
    function GetStarPoints(var Points: PFCPolygonPoints; Size: TSize): Integer;
    function GetPolygonPoints(var Points: PFCPolyGonPoints): Integer;

    // Overriden Methods
    function CreateRegion(DoImplementation: Boolean; Down: Boolean): HRgn; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function UseRegions: boolean; override;


    property RegionBitmap: TBitmap read FRegionBitmap write FRegionBitmap;
  public
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsMultipleRegions: Boolean; override;
    function RoundShape: Boolean; virtual;
    procedure GetDrawBitmap(DrawBitmap: TfcBitmap; ForRegion: Boolean;
      ShadeStyle: TfcShadeStyle; Down: Boolean); override;
    procedure SizeToDefault; override;

    property Orientation: TfcShapeOrientation read FOrientation write SetOrientation default soUp;
    property PointList: TStringList read FPointList write SetPointList;
    property RoundRectBias: Integer read FRoundRectBias write SetRoundRectBias default 0;
    property Shape: TfcButtonShape read FShape write SetShape default bsRect;
  end;

  TfcShapeBtn = class(TfcCustomShapeBtn)
  published
    {$ifdef fcDelphi4Up}
    property Action;
    property Anchors;
    property Constraints;
    {$endif}
    property AllowAllUp;
    property Cancel;
    property Caption;
    property Color;
    property Default;
    property DitherColor;
    property Down;
    property DragCursor; //3/31/99 - PYW - Exposed DragCursor, DragMode, DragKind properties.
    {$ifdef fcDelphi4Up}
    property DragKind;
    {$endif}
    property DragMode;
    property Font;
    property Enabled;
    property Glyph;
    property GroupIndex;
    property Kind;
    property Layout;
    property Margin;
    property ModalResult;
    property NumGlyphs;
    property Options;
    property Offsets;
    property Orientation;
    property ParentClipping;
    property ParentFont;
    property ParentShowHint;
    property PointList;
    property PopupMenu;
    property RoundRectBias;
    property ShadeColors;
    property ShadeStyle;
    property Shape;
    property ShowHint;
    {$ifdef fcDelphi4Up}
    property SmoothFont;
    {$endif}
    property Spacing;
    property Style;
    property TabOrder;
    property TabStop;
    property TextOptions;
    property Visible;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnSelChange;
    property OnStartDrag;
  end;

implementation

var GoodVideoDriverVar: Integer = -1;

function GoodVideoDriver: Boolean;
var TmpBm: TfcBitmap;
    TmpBitmap: TBitmap;
begin
  if GoodVideoDriverVar = -1 then
  begin
    TmpBm := TfcBitmap.Create;
    TmpBm.LoadBlank(1, 1);
    TmpBm.Pixels[0, 0] := fcGetColor(RGB(192, 192, 192));
    TmpBitmap := TBitmap.Create;
    TmpBitmap.Width := 1;
    TmpBitmap.Height := 1;
    TmpBitmap.Canvas.Draw(0, 0, TmpBm);
    with fcGetColor(TmpBitmap.Canvas.Pixels[0, 0]) do
      GoodVideoDriverVar := ord((r < 200) and (g < 200) and (b < 200));
    TmpBitmap.Free;
    TmpBm.Free;
  end;
  result := GoodVideoDriverVar = 1;
end;

{$R-}

procedure TfcCustomShapeBtn.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  exit;

  if (Button = mbLeft) and Enabled then
  begin
    if not Down then
    begin
      Down:=False;
      Invalidate;
    end;
  end;
end;

constructor TfcCustomShapeBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPointList := TStringList.Create;
  FShape := bsRect;
  FOrientation := soUp;
  FRoundRectBias := 25;
  FRegionBitmap := TBitmap.Create;
  Color := clBtnFace;
  ShadeStyle := fbsHighlight;
end;

destructor TfcCustomShapeBtn.Destroy;
begin
  FPointList.Free;
  FRegionBitmap.Free;
  inherited;
end;

procedure TfcCustomShapeBtn.SetOrientation(Value: TfcShapeOrientation);
begin
  if FOrientation<> Value then
  begin
    FOrientation:= Value;
    Recreatewnd;
  end
end;

procedure TfcCustomShapeBtn.SetPointList(Value: TStringList);
begin
  FPointList.Assign(Value);
  RecreateWnd;
end;

procedure TfcCustomShapeBtn.SetShape(Value: TfcButtonShape);
begin
  if FShape <> Value then
  begin
    FShape := Value;
    Recreatewnd;

    // Ensures that the control's rectangle gets invalidated even in a transparent button group
    if (Parent <> nil) and fcIsClass(Parent.ClassType, 'TfcCustomButtonGroup') then
      fcParentInvalidate(Parent, True);
  end
end;

// Given a set of points will rotate the points to the given orientation.
// Method assumes points passed in are oriented up

procedure TfcCustomShapeBtn.SetPointToOrientation(Points: PFCPolygonPoints;
  NumPoints: Integer; Orientation: TfcShapeOrientation; Size: TSize);
var i: Integer;
    RepeatInc, RepCount: Integer;
begin
  RepCount := 0;
  case Orientation of
    soLeft: RepCount := 3;
    soRight: RepCount := 1;
    soUp: RepCount := 0;
    soDown: RepCount := 2;
  end;
  for RepeatInc := 1 to RepCount do
    for i := 0 to NumPoints - 1 do with Points[i] do
      Points[i] := Point(Size.cx - (y * Size.cx div Size.cy), (x * Size.cy div Size.cx));
end;

procedure SetupPointList(var PointList: PfcPolygonPoints; NumPoints: Integer);
begin
  PointList := AllocMem((NumPoints + 1) * SizeOf(TPoint));
  FillChar(PointList^, (NumPoints + 1) * SizeOf(TPoint), 0);
end;

function GetNum(Num: Integer): Integer;
begin
  result := Num;
end;

function TfcCustomShapeBtn.GetCustomPoints(var Points: PFCPolygonPoints; Size: TSize): Integer;
var i: Integer;
    CurPoint, x, y: string;
begin
  result := PointList.Count;
  if result <= 2 then
  begin
    result := 0;
    Exit;
  end;

  SetupPointList(Points, result);

  try
    for i := 0 to result - 1 do
    begin
      CurPoint := UpperCase(PointList[i]);
      if Pos(',', CurPoint) = 0 then
        raise EInvalidOperation.Create('Invalid Custom Points Format.  X and Y ' +
          'Coordinates must be separated by a comma and space.');
      CurPoint := fcReplace(CurPoint, ',', ', ');
      CurPoint := fcReplace(CurPoint, ',  ', ', ');
      CurPoint := fcReplace(CurPoint, 'WIDTH', InttoStr(Size.cx));
      CurPoint := fcReplace(CurPoint, 'HEIGHT', InttoStr(Size.cy));
      x := fcGetToken(CurPoint, ', ', 0);
      y := fcGetToken(CurPoint, ', ', 1);
      with Point(TfcEvaluator.Evaluate(x), TfcEvaluator.Evaluate(y)) do
        Points[i] := Point(x, y);
    end;
  except
    FreeMem(Points);
    Points := nil;
    FShape := bsRect;
    raise;
  end;
end;

function TfcCustomShapeBtn.GetStarPoints(var Points: PFCPolygonPoints; Size: TSize): Integer;
var BottomOff: Integer;
    BaseTri, SideTri, HeightTri: Integer;
    Side: Integer;
begin
  result := 10;
  SetupPointList(Points, result);

  Side := Trunc(Size.cy / Cos(DegToRad(18)));
  SideTri := Trunc(Side / (2 + 2 * Sin(DegToRad(18))));
  BaseTri := Side - 2 * SideTri;
  HeightTri := Trunc(SideTri * Cos(DegToRad(18)));
  BottomOff := Trunc(Tan(DegToRad(18)) * Size.cy);
  Points[GetNum(0)] := Point(Size.cx div 2, 0);
  Points[GetNum(1)] := Point(Size.cx div 2 + BaseTri div 2, HeightTri);
  Points[GetNum(2)] := Point(Size.cx, Points[GetNum(1)].y);
  Points[GetNum(3)] := Point(Points[GetNum(1)].x + Trunc(Sin(DegToRad(18)) * BaseTri),
                     Points[GetNum(1)].y + Trunc(Cos(DegToRad(18)) * BaseTri));
  Points[GetNum(4)] := Point(Size.cx div 2 + BottomOff, Size.cy);
  Points[GetNum(5)] := Point(Size.cx div 2, Size.cy - Trunc(Sin(DegToRad(36)) * SideTri));
  Points[GetNum(6)] := Point(Size.cx div 2 - BottomOff, Size.cy);
  Points[GetNum(7)] := Point(Size.cx - Points[GetNum(3)].x, Points[GetNum(3)].y);
  Points[GetNum(8)] := Point(0, Points[GetNum(2)].y);
  Points[GetNum(9)] := Point(Size.cx - Points[GetNum(1)].x, Points[GetNum(1)].y);
end;

function TfcCustomShapeBtn.GetPolygonPoints(var Points: PfcPolygonPoints): Integer;
var Size: TSize;
begin
  result := 0;
  Size := fcSize(Width - 1, Height - 1);
  case Shape of
    bsTriangle: begin
      result := 3;
      SetupPointList(Points, result);
      // Default Up, SetPointToOrientation adjusts for orientation
      Points[GetNum(0)] := Point(Size.cx div 2, 0);
      Points[GetNum(1)] := Point(Size.cx, Size.cy);
      Points[GetNum(2)] := Point(0, Size.cy);
    end;
    bsTrapezoid: begin
      result := 4;
      SetupPointList(Points, result);
      // Default Up, SetPointToOrientation adjusts for orientation
      Points[GetNum(0)] := Point(fcMin(Size.cy div 2, Size.cx div 2 div 2), 0);
      Points[GetNum(1)] := Point(Size.cx - fcMin(Size.cy div 2, Size.cx div 2 div 2), 0);
      Points[GetNum(2)] := Point(Size.cx, Size.cy);
      Points[GetNum(3)] := Point(0, Size.cy);
    end;
    bsArrow: begin
      result := 7;
      SetupPointList(Points, result);
      // Default Up, SetPointToOrientation adjusts for orientation
      Points[GetNum(0)] := Point(0, Size.cy div 3);
      Points[GetNum(1)] := Point(Size.cx div 2, 0);
      Points[GetNum(2)] := Point(Size.cx, Size.cy div 3);
      Points[GetNum(3)] := Point(Size.cx - Size.cx div 4, Size.cy div 3);
      Points[GetNum(4)] := Point(Size.cx - Size.cx div 4, Size.cy);
      Points[GetNum(5)] := Point(Size.cx div 4, Size.cy);
      Points[GetNum(6)] := Point(Size.cx div 4, Size.cy div 3);
    end;
    bsDiamond: begin
      result := 4;
      SetupPointList(Points, result);
      Points[GetNum(0)] := Point(Size.cx div 2, 0);
      Points[GetNum(1)] := Point(Size.cx, Size.cy div 2);
      Points[GetNum(2)] := Point(Size.cx div 2, Size.cy);
      Points[GetNum(3)] := Point(0, Size.cy div 2);
    end;
    bsRect: begin
      result := 4;
      SetupPointList(Points, result);
      Points[GetNum(0)] := Point(0, 0);
      Points[GetNum(1)] := Point(Size.cx, 0);
      Points[GetNum(2)] := Point(Size.cx, Size.cy);
      Points[GetNum(3)] := Point(0, Size.cy);
    end;
    bsStar: result := GetStarPoints(Points, Size);
    bsCustom: result := GetCustomPoints(Points, Size);
  end;
  if result > 0 then
  begin
    Points[result] := Points[0];
    inc(result);
    SetPointToOrientation(Points, result, Orientation, Size);
  end;
end;

function TfcCustomShapeBtn.CreateRegion(DoImplementation: Boolean; Down: Boolean): HRgn;
var DrawBitmap: TfcBitmap;
begin
  result := inherited CreateRegion(False, Down);
  if not DoImplementation or (result <> 0) then Exit;

  DrawBitmap := TfcBitmap.Create;
  try
    GetDrawBitmap(DrawBitmap, True, ShadeStyle, Down);
    result := fcRegionFromBitmap(DrawBitmap, UnusableColor);
  finally
    SaveRegion(result, Down);
    DrawBitmap.Free;
  end;
end;

function TfcCustomShapeBtn.IsMultipleRegions: Boolean;
begin
  result := False;
end;

function TfcCustomShapeBtn.StoreRegionData: Boolean;
begin
  result := False;
end;

function TfcCustomShapeBtn.CorrectedColor: TColor;
begin
  with fcGetColor(Color) do
  begin
    if not GoodVideoDriver then
    begin
      // 5/10/99 - PYW - Fixed Flat Style painting bug in High Color mode.
      if (r > 0) and (r mod 8 = 0) then dec(r);
      if (g > 0) and (g mod 8 = 0) then dec(g);
      if (b > 0) and (b mod 8 = 0) then dec(b);
    end;
    result := RGB(r, g, b);
  end;
end;

function TfcCustomShapeBtn.UnusableColor: TColor;
begin
  if Color <> DEFUNUSECOLOR then result := DEFUNUSECOLOR else result := DEFUNUSECOLOR2;
end;

type TBooleanArray = array[0..0] of Boolean;
     PBooleanArray = ^TBooleanArray;

procedure TfcCustomShapeBtn.AssignTo(Dest: TPersistent);
begin
  if Dest is TfcCustomShapeBtn then
    with Dest as TfcCustomShapeBtn do
  begin
    Orientation := self.Orientation;
    PointList := self.PointList;
    RoundRectBias := self.RoundRectBias;
    Shape := self.Shape;
  end;
  inherited;
end;

procedure TfcCustomShapeBtn.Draw3dLines(Bitmap: TfcBitmap; PointList: array of TPoint;
  NumPoints: Integer; TransColor: TColor);
  function MidPoint(p1, p2: TPoint): TPoint;
  begin
    result := Point(p1.x + (p2.x - p1.x) div 2, p1.y + (p2.y - p1.y) div 2);
  end;
var PolyRgn: HRGN;
    i: Integer;
    Difference: TSize;
    OutsideColor, InsideColor: TColor;
    Highlights: PBooleanArray;
    Offsets: PfcPolygonPoints;
    Focused: Integer;
    ACanvas: TCanvas;
begin
  ACanvas := Bitmap.Canvas;
  if RoundShape then
  begin
//    fcOffsetBitmap(Bitmap, TransColor, Point(1, 1));
    inherited Draw3dLines(Bitmap, Bitmap, TransColor, Down);
//    fcOffsetBitmap(Bitmap, TransColor, Point(-1, -1));
    Exit;
  end;

  PolyRgn := CreatePolygonRgn(PointList, NumPoints, WINDING);
  if PolyRgn = 0 then Exit;

  Highlights := AllocMem(SizeOf(Boolean) * NumPoints);
  Offsets := AllocMem(SizeOf(TPoint) * NumPoints);

  try
    for i := 0 to NumPoints - 2 do
    begin
      Highlights[i] := False;
      Difference := fcSize(Abs(PointList[i + 1].x - PointList[i].x),
                           Abs(PointList[i + 1].y - PointList[i].y));
      with MidPoint(PointList[i], PointList[i + 1]) do
        if (Difference.cx > Difference.cy) then
        begin
          if PtInRegion(PolyRgn, x, y + 1) then
          begin
            Highlights[i] := True;
            Offsets[i] := Point(0, 1);
          end else Offsets[i] := Point(0, -1);
        end else
        begin
          if PtInRegion(PolyRgn, x + 1, y) then
          begin
            Highlights[i] := True;
            Offsets[i] := Point(1, 0);
          end else Offsets[i] := Point(-1, 0);
        end;
      if (Difference.cx = 0) then
      begin
        Offsets[i] := Point(Offsets[i].x, -1);
        if PtInRegion(PolyRgn, PointList[i].x, fcMax(PointList[i].y, PointList[i + 1].y) + 1) then Offsets[i].y := 1;
      end else if (Difference.cy = 0) then
      begin
        Offsets[i] := Point(-1, Offsets[i].y);
        if PtInRegion(PolyRgn, fcMax(PointList[i].x, PointList[i + 1].x), PointList[i].y) then Offsets[i].x := 1;
      end;
    end;

    if self.Focused or Default then Focused := 1 else Focused := 0;


    for i := 0 to NumPoints - 2 do
    begin
      if Highlights[i] xor Down then InsideColor := ColorToRGB(ShadeColors.Btn3dLight)
      else InsideColor := ColorToRGB(ShadeColors.BtnShadow);

      ACanvas.Pen.Color := InsideColor;
      ACanvas.PolyLine([
        Point(PointList[i].x + Offsets[i].x * (1 + Focused), PointList[i].y + Offsets[i].y * (1 + Focused)),
        Point(PointList[i + 1].x + Offsets[i].x * (1 + Focused), PointList[i + 1].y + Offsets[i].y * (1 + Focused))
      ]);
    end;

    for i := 0 to NumPoints - 2 do
    begin
      if Highlights[i] xor Down then OutsideColor := ColorToRGB(ShadeColors.BtnHighlight)
      else OutsideColor := ColorToRGB(ShadeColors.BtnBlack);

      ACanvas.Pen.Color := OutsideColor;
      ACanvas.Polyline([
        Point(PointList[i].x + Offsets[i].x * Focused, PointList[i].y + Offsets[i].y * Focused),
        Point(PointList[i + 1].x + Offsets[i].x * Focused, PointList[i + 1].y + Offsets[i].y * Focused)
      ]);
    end;

    if self.Focused or Default then
      for i := 0 to NumPoints - 2 do
      begin
        ACanvas.Pen.Color := ShadeColors.BtnFocus;
        ACanvas.PolyLine([PointList[i], PointList[i + 1]]);
      end;
  finally
    DeleteObject(PolyRgn);
    FreeMem(Highlights);
    FreeMem(Offsets);
  end;
end;

function TfcCustomShapeBtn.RoundShape: Boolean;
begin
  result := Shape in [bsRoundRect, bsEllipse];
end;

procedure TfcCustomShapeBtn.GetDrawBitmap(DrawBitmap: TfcBitmap; ForRegion: Boolean;
  ShadeStyle: TfcShadeStyle; Down: Boolean);
var PointList: PfcPolyGonPoints;
    NumPoints: Integer;
//    DitherBm: TBitmap;
    DoDraw3d: Boolean;
    OldBrush, ABrush: HBRUSH;
begin
  DoDraw3d := True;
  case ShadeStyle of
    fbsFlat: DoDraw3d := (csDesigning in ComponentState) or MouseInControl(-1, -1, False) or Down;
  end;

  ABrush := 0;
  OldBrush := 0;
  DrawBitmap.SetSize(Width, Height);

  //3/16/99 - PYW - Raises canvas draw error when anchors cause width or height to be <=0
  if (Width <=0) or (Height<=0) then exit;

  DrawBitmap.Canvas.Brush.Color := UnusableColor;
  DrawBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
  DrawBitmap.Canvas.Brush.Color := CorrectedColor;
  if DoDraw3d then DrawBitmap.Canvas.Pen.Color := ColorToRGB(DitherColor)
  else DrawBitmap.Canvas.Pen.Color := DrawBitmap.Canvas.Brush.Color;

  if Down and (DitherColor <> clNone) and (GroupIndex <> 0) then
  begin
    ABrush := fcGetDitherBrush;
    SetBkColor(DrawBitmap.Canvas.Handle, ColorToRGB(DitherColor));
    SetTextColor(DrawBitmap.Canvas.Handle, ColorToRGB(Color));
    OldBrush := SelectObject(DrawBitmap.Canvas.Handle, ABrush);
  end;

  try
    PointList := nil;
    if RoundShape then
    begin
      DrawBitmap.Canvas.Pen.Color := CorrectedColor;
      case Shape of
        bsRoundRect: DrawBitmap.Canvas.RoundRect(
          0, 0, Width - 1, Height - 1, RoundRectBias, RoundRectBias);
        bsEllipse: DrawBitmap.Canvas.Ellipse(
          0, 0, Width - 1, Height - 1);
      end;
      if not ForRegion and DoDraw3d then { 5/2/99 - RSW - Support flat for RoundShape }
         Draw3dLines(DrawBitmap, [Point(0, 0)], 0, UnusableColor);
    end else begin
      NumPoints := GetPolygonPoints(PointList);
      if PointList <> nil then Polygon(DrawBitmap.Canvas.Handle, PointList^, NumPoints);
      if not ForRegion and DoDraw3d and (PointList <> nil) then Draw3dLines(DrawBitmap, Slice(PointList^, NumPoints), NumPoints, UnusableColor);
    end;

    if OldBrush <> 0 then SelectObject(DrawBitmap.Canvas.Handle, OldBrush);
    if ABrush <> 0 then DeleteObject(ABrush);
  finally
    if not RoundShape then FreeMem(PointList);
  end;
end;

procedure TfcCustomShapeBtn.SizeToDefault;
begin
  if Width > Height then Height := Width else Width := Height;
end;

procedure TfcCustomShapeBtn.SetRoundRectBias(Value:Integer);
begin
  if Value <> FRoundRectBias then
  begin
    FRoundRectBias := Value;
    RecreateWnd;
  end;
end;

function TfcCustomShapeBtn.UseRegions: boolean;
begin
   result:= True;
end;

procedure TfcCustomShapeBtn.WndProc(var Message: TMessage);
begin
  inherited;
end;

{$R+}

end.
