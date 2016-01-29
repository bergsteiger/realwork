unit ChromeLikeFormFramePainter;

interface
uses
 Controls,
 Forms,
 Messages,
 Windows,
 Graphics,
 Types,
 UxTheme,
 vcmGlassForm;

type
 TChromeLikeFormFramePainterStyle = (ffpsLegacy, ffpsThemed);
 TChromeLikeFormFramePainterKind = (ffpkActive, ffpkInactive, ffpkDisabled);

 TChromeLikeFormFrameElement = (ffeCaptionBody, ffeCaptionLeftCorner,
  ffeCaptionRightCorner, ffeLeftEdge, ffeRightEdge, ffeBottomEdge,
  ffeLeftBottomCorner, ffeRightBottomCorner);

 TChromeLikeFormFrameElementRects = array[TChromeLikeFormFrameElement] of TRect;

 TChromeLikeformFramePainter = class(TObject)
 private
  f_Form: TvcmGlassForm;
  f_Theme: HTHEME;
  f_CaptionHeight: Integer;
  f_BorderWidth: Integer;
  f_ThemeBitmap: TBitmap;
  f_ThemeElementPlacements: TChromeLikeFormFrameElementRects;
  f_Painted: Boolean;
  f_FormActive: Boolean;
  f_UpdateCount: Integer;
  function GetPaintKind: TChromeLikeFormFramePainterKind;
  function GetPaintStyle: TChromeLikeFormFramePainterStyle;
  procedure PaintElementsInternal;
  procedure MakePlacements;
  function pm_GetTheme: HTHEME;
  property Theme: HTHEME read pm_GetTheme;
 public
  procedure BeginUpdate;
  procedure EndUpdate;
  procedure PaintElement(aCanvas: TCanvas; aElement: TChromeLikeFormFrameElement;
   const aRect: TRect);
  procedure CopyElementPartOnCanvas(aCanvas: TCanvas; const aDestRect: TRect;
   const aSrcRect: TRect);
  procedure Repaint(aActive: Boolean);
  procedure InvalidateState(aActive: Boolean);
  procedure InvalidateTheme;
  procedure InvalidateSize;
  constructor Create(aForm: TvcmGlassForm; aCaptionHeight: Integer; aBorderWidth: Integer);
  destructor Destroy; override;
 end;

implementation
uses
 SysUtils,
 ChromeLikeTypes,
 ChromeLikeWinUtils,
 Themes,
 l3Base;

{ TChromeLikeformFramePainter }

function TChromeLikeFormFramePainter.GetPaintKind: TChromeLikeFormFramePainterKind;
const
 cActiveFormArr: array[Boolean] of TChromeLikeFormFramePainterKind =
  (ffpkInActive, ffpkActive);
begin
 if f_Form.Enabled then
  Result := cActiveFormArr[f_FormActive]
 else
  Result := ffpkDisabled;
end;

function TChromeLikeformFramePainter.GetPaintStyle: TChromeLikeFormFramePainterStyle;
const
 cPainterStyleArr: array[Boolean] of TChromeLikeFormFramePainterStyle =
  (ffpsLegacy, ffpsThemed);
begin
 Result := cPainterStyleArr[IsAppThemed];
end;

procedure TChromeLikeformFramePainter.PaintElementsInternal;
var
 l_TotalRect: TRect;

 procedure lp_PaintElementsThemed;
 (* –исует форму со стил€ми *)
 const
  cEdgeStateArr: array[Boolean] of Integer =
   (FS_INACTIVE, FS_ACTIVE);
  // - —осто€ни€ границ окна
  cWindowStateArr: array[Boolean] of Integer =
   (WP_CAPTION, WP_MAXCAPTION);
  // - PartID в зависимости от состо€ни€ окна
  cNormalCaptionStateArr: array[Boolean] of Integer =
   (CS_INACTIVE, CS_ACTIVE);
  // - StateID дл€ заголовка нормального окна в зависимости от активности окна
  cMaxCaptionStateArr: array[Boolean] of Integer =
   (MXCS_INACTIVE, MXCS_ACTIVE);
  // - StateID дл€ заголовка развернутого окна в зависимости от активности окна
 var
  l_CaptionRect: TRect;
  l_LeftEdgeRect: TRect;
  l_RightEdgeRect: TRect;
  l_BottomEdgeRect: TRect;
  l_StateID: Integer;
  l_PaintKind: TChromeLikeFormFramePainterKind;
 begin
  l_PaintKind := GetPaintKind;
  UnionRect(l_CaptionRect,  f_ThemeElementPlacements[ffeCaptionLeftCorner],
   f_ThemeElementPlacements[ffeCaptionRightCorner]);
  UnionRect(l_CaptionRect, l_CaptionRect,
   f_ThemeElementPlacements[ffeCaptionBody]);

  UnionRect(l_BottomEdgeRect, f_ThemeElementPlacements[ffeBottomEdge],
   f_ThemeElementPlacements[ffeRightBottomCorner]);
  UnionRect(l_BottomEdgeRect, l_BottomEdgeRect,
   f_ThemeElementPlacements[ffeLeftBottomCorner]);

  if (f_Form.WindowState <> wsMaximized) then
  // - ƒл€ максимизированной формы границы не рисуем
  begin
   DrawThemeBackground(Theme,
                       f_ThemeBitmap.Canvas.Handle,
                       WP_FRAMELEFT,
                       cEdgeStateArr[f_FormActive],
                       f_ThemeElementPlacements[ffeLeftEdge],
                       nil);
   // - Ћева€ граница

   DrawThemeBackground(Theme,
                       f_ThemeBitmap.Canvas.Handle,
                       WP_FRAMERIGHT,
                       cEdgeStateArr[f_FormActive],
                       f_ThemeElementPlacements[ffeRightEdge],
                       nil);
   // - ѕрава€ граница

   DrawThemeBackground(Theme,
                       f_ThemeBitmap.Canvas.Handle,
                       WP_FRAMEBOTTOM,
                       cEdgeStateArr[f_FormActive],
                       l_BottomEdgeRect,
                       nil);
   // - Ќидн€€ граница
  end;
  if (f_Form.WindowState = wsMaximized) then
   l_StateID := cMaxCaptionStateArr[f_FormActive]
  else
   l_StateID := cNormalCaptionStateArr[f_FormActive];

  DrawThemeBackground(Theme,
                      f_ThemeBitmap.Canvas.Handle,
                      cWindowStateArr[f_Form.WindowState = wsMaximized],
                      l_StateID,
                      l_CaptionRect,
                      nil);
  // - «аголовок
 end;

 procedure lp_PaintElementsLegacy;
 (* –исует форму в классическом оформлении *)
 type
  TCaptionColorPair = record
   rColorFrom: TColor;
   rColorTo: TColor;
  end;
 const
  cCaptionColors: array[Boolean] of TCaptionColorPair =
   ((rColorFrom: clInactiveCaption; rColorTo: clGradientInactiveCaption),
    (rColorFrom: clActiveCaption; rColorTo: clGradientActiveCaption));
  // - ÷вета дл€ рисовани€ заголовка
  cStyleArr: array[ffeCaptionLeftCorner..ffeRightBottomCorner] of UINT =
   (BF_TOPLEFT, BF_TOPRIGHT, BF_LEFT, BF_RIGHT,
    BF_BOTTOM, BF_BOTTOMLEFT, BF_BOTTOMRIGHT);
  // - ¬иды границ окна
 var
  l_Index: TChromeLikeFormFrameElement;
  l_BrushRecall: TBrushRecall;
  l_GradientCaptionsEnabled: BOOL;
  l_LegacyCaptionBlueStrip: TRect;
  l_LegacyFrameTopEdge: TRect;
 begin
  f_ThemeBitmap.Canvas.Brush.Color := clBtnFace;
  f_ThemeBitmap.Canvas.FillRect(l_TotalRect);

  if (f_Form.WindowState <> wsMaximized) then
  // - ƒл€ максимизированной формы границы не рисуем
  begin
   for l_Index := ffeCaptionLeftCorner to ffeRightBottomCorner do
    DrawEdge(f_ThemeBitmap.Canvas.Handle,
             f_ThemeElementPlacements[l_Index],
             BDR_RAISEDINNER or BDR_RAISEDOUTER,
             cStyleArr[l_Index]);
   l_LegacyFrameTopEdge := f_ThemeElementPlacements[ffeCaptionLeftCorner];
   l_LegacyFrameTopEdge.Right := f_ThemeElementPlacements[ffeCaptionRightCorner].Left;
   l_LegacyFrameTopEdge.Bottom := f_BorderWidth * 2;
   DrawEdge(f_ThemeBitmap.Canvas.Handle,
            l_LegacyFrameTopEdge,
            BDR_RAISEDINNER or BDR_RAISEDOUTER,
            BF_TOP);
   // - Ќарисовали границы
  end;

  l_GradientCaptionsEnabled := False;

  l_LegacyCaptionBlueStrip := f_ThemeElementPlacements[ffeCaptionBody];
  Inc(l_LegacyCaptionBlueStrip.Top, f_BorderWidth);

  SystemParametersInfo(SPI_GETGRADIENTCAPTIONS,
                       0,
                       @l_GradientCaptionsEnabled,
                       0);

  if l_GradientCaptionsEnabled then
   FillGradient(f_ThemeBitmap.Canvas.Handle,
                l_LegacyCaptionBlueStrip,
                255,
                cCaptionColors[GetPaintKind = ffpkActive].rColorFrom,
                cCaptionColors[GetPaintKind = ffpkActive].rColorTo,
                gdHorizontal)
   // - градиентный заголовок
  else
  begin
   l_BrushRecall := TBrushRecall.Create(f_ThemeBitmap.Canvas.Brush);
   try
    f_ThemeBitmap.Canvas.Brush.Color := cCaptionColors[GetPaintKind = ffpkActive].rColorFrom;
    f_ThemeBitmap.Canvas.FillRect(l_LegacyCaptionBlueStrip);
   finally
    FreeAndNil(l_BrushRecall);
   end;
   // - неградиентный заголовок
  end;
 end;

begin
 if (f_UpdateCount = 0) then
 begin
  l_TotalRect := Rect(0, 0, f_Form.Width, f_Form.Height);
  if (GetPaintStyle = ffpsThemed) then
   lp_PaintElementsThemed
  else
   lp_PaintElementsLegacy;
 end;
end;

procedure TChromeLikeformFramePainter.MakePlacements;
var
 l_FormRect: TRect;
 l_CaptionRect: TRect;
 l_BottomEdgeTop: Integer;
begin
 l3FillChar(f_ThemeElementPlacements, SizeOf(f_ThemeElementPlacements), 0);
 l_FormRect := Rect(0, 0, f_Form.Width, f_Form.Height);
 l_CaptionRect := Rect(0, 0, f_Form.Width, f_CaptionHeight);

 f_ThemeElementPlacements[ffeCaptionBody] := l_CaptionRect;
 Inc(f_ThemeElementPlacements[ffeCaptionBody].Left, f_BorderWidth);
 Dec(f_ThemeElementPlacements[ffeCaptionBody].Right, f_BorderWidth);
 // - тело заголовка

 f_ThemeElementPlacements[ffeCaptionLeftCorner] := Rect(0, 0, f_BorderWidth,
  f_BorderWidth);
 // - левый угол заголовка

 f_ThemeElementPlacements[ffeCaptionRightCorner] := l_CaptionRect;
 f_ThemeElementPlacements[ffeCaptionRightCorner].Left := l_CaptionRect.Right - f_BorderWidth;
 // - правый угол заголовка

 l_BottomEdgeTop := l_FormRect.Bottom - f_BorderWidth;
 // - Y-координата верха нижней границы формы

 f_ThemeElementPlacements[ffeLeftEdge] := Rect(0, f_BorderWidth, f_BorderWidth,
  l_BottomEdgeTop);
 // - лева€ граница

 f_ThemeElementPlacements[ffeRightEdge] := Rect(l_FormRect.Right - f_BorderWidth,
  f_BorderWidth, l_FormRect.Right, l_BottomEdgeTop);
 // - права€ граница

 f_ThemeElementPlacements[ffeBottomEdge] := Rect(f_BorderWidth, l_BottomEdgeTop,
  l_FormRect.Right - f_BorderWidth, l_FormRect.Bottom);
 // - нижн€€ граница

 f_ThemeElementPlacements[ffeLeftBottomCorner] := Rect(0, l_BottomEdgeTop,
  f_BorderWidth, l_FormRect.Bottom);
 // - Ќижний левый угол границы

 f_ThemeElementPlacements[ffeRightBottomCorner] := Rect(l_FormRect.Right - f_BorderWidth,
  l_BottomEdgeTop, l_FormRect.Right, l_FormRect.Bottom);
 // - Ќижний правый угол границы
end;

function TChromeLikeFormFramePainter.pm_GetTheme: HTHEME;
const
 cThemeWndClass: PWideChar = 'WINDOW';
begin
 if (f_Theme = 0) then
  f_Theme := OpenThemeData(f_Form.Handle, cThemeWndClass);
 Result := f_Theme;
end;

procedure TChromeLikeformFramePainter.BeginUpdate;
begin
 Inc(f_UpdateCount);
end;

procedure TChromeLikeformFramePainter.EndUpdate;
begin
 Dec(f_UpdateCount);
 if (f_UpdateCount = 0) then
  PaintElementsInternal;
end;

constructor TChromeLikeformFramePainter.Create(aForm: TvcmGlassForm;
  aCaptionHeight, aBorderWidth: Integer);
begin
 inherited Create;
 f_Form := aForm;
 f_Theme := 0;
 f_CaptionHeight := aCaptionHeight;
 f_BorderWidth := aBorderWidth;
 f_ThemeBitmap := TBitmap.Create;
 f_Painted := False;
 InvalidateSize;
 l3FillChar(f_ThemeElementPlacements, SizeOf(f_ThemeElementPlacements), 0);
end;

destructor TChromeLikeformFramePainter.Destroy;
begin
 if (f_Theme <> 0) then
  CloseThemeData(f_Theme);
 FreeAndNil(f_ThemeBitmap);
 inherited;
end;

procedure TChromeLikeformFramePainter.InvalidateSize;
begin
 f_Painted := False;
 f_ThemeBitmap.Width := f_Form.Width;
 f_ThemeBitmap.Height := f_Form.Height;
 MakePlacements;
 PaintElementsInternal;
end;

procedure TChromeLikeFormFramePainter.PaintElement(aCanvas: TCanvas;
 aElement: TChromeLikeFormFrameElement; const aRect: TRect);
begin
 CopyElementPartOnCanvas(aCanvas, aRect, f_ThemeElementPlacements[aElement]);
end;

procedure TChromeLikeformFramePainter.CopyElementPartOnCanvas(aCanvas: TCanvas;
 const aDestRect: TRect; const aSrcRect: TRect);
begin
 Assert(aCanvas <> nil);
 if (not f_Painted) then
  PaintElementsInternal;
 aCanvas.CopyRect(aDestRect, f_ThemeBitmap.Canvas, aSrcRect);
end;

procedure TChromeLikeFormFramePainter.Repaint(aActive: Boolean);
begin
 BeginUpdate;
 InvalidateSize;
 InvalidateState(aActive);
 EndUpdate;
end;

procedure TChromeLikeFormFramePainter.InvalidateState(aActive: Boolean);
begin
 f_FormActive := aActive;
 PaintElementsInternal;
end;

procedure TChromeLikeformFramePainter.InvalidateTheme;
begin
 if (f_Theme <> 0) then
  CloseThemeData(f_Theme);
 f_Painted := False;
end;

initialization
 InitThemeLibrary;
finalization
 FreeThemeLibrary;

end.
