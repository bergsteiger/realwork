unit NOT_FINISHED_vgTypes;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "vgTypes" MUID: (4D5420EC039D)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
;

type
 PvgPolygon = ^TvgPolygon;

 PvgColor24Array = ^TvgColor24Array;

 PvgColorArray = ^TvgColorArray;

 PvgColor = ^TvgColor;

 PvgColorRec = ^TvgColorRec;

 PvgColorRecArray = ^TvgColorRecArray;

 PvgRect = ^TvgRect;

 TvgPoint = packed record
  X: Single;
  Y: Single;
 end;//TvgPoint

 TvgRectLTRB = packed record
  Left: Single;
  Top: Single;
  Right: Single;
  Bottom: Single;
 end;//TvgRectLTRB

 TvgRectPoints = packed record
  TopLeft: TvgPoint;
  BottomRight: TvgPoint;
 end;//TvgRectPoints

 TvgRect = packed record
  Case Integer of
   0: (Left: Single; Top: Single; Right: Single; Bottom: Single);
   1: (TopLeft: TvgPoint; BottomRight: TvgPoint);
 end;//TvgRect

 TvgAnimationType = (
  vgAnimationIn
  , vgAnimationOut
  , vgAnimationInOut
 );//TvgAnimationType

 TvgInterpolationType = (
  vgInterpolationLinear
  , vgInterpolationQuadratic
  , vgInterpolationCubic
  , vgInterpolationQuartic
  , vgInterpolationQuintic
  , vgInterpolationSinusoidal
  , vgInterpolationExponential
  , vgInterpolationCircular
  , vgInterpolationElastic
  , vgInterpolationBack
  , vgInterpolationBounce
 );//TvgInterpolationType

 TvgAlign = (
  vaNone
  , vaTopLeft
  , vaTopRight
  , vaBottomLeft
  , vaBottomRight
  , vaTop
  , vaLeft
  , vaRight
  , vaBottom
  , vaMostTop
  , vaMostBottom
  , vaMostLeft
  , vaMostRight
  , vaClient
  , vaContents
  , vaCenter
  , vaVertCenter
  , vaHorzCenter
  , vaHorizontal
  , vaVertical
  , vaScale
  , vaFit
  , vaFitLeft
  , vaFitRight
 );//TvgAlign

 TvgDragMode = (
  vgDragManual
  , vgDragAutomatic
 );//TvgDragMode

 TvgDragObject = record
  Source: TObject;
  Files: array of WideString;
  Data: Variant;
 end;//TvgDragObject

 TvgDragEnterEvent = procedure(Sender: TObject;
  const Data: TvgDragObject;
  const Point: TvgPoint) of object;

 TvgDragOverEvent = procedure(Sender: TObject;
  const Data: TvgDragObject;
  const Point: TvgPoint;
  var Accept: Boolean) of object;

 TvgDragDropEvent = procedure(Sender: TObject;
  const Data: TvgDragObject;
  const Point: TvgPoint) of object;

 TvgCanFocusedEvent = procedure(Sender: TObject;
  var ACanFocused: Boolean) of object;

 TvgProcessTickEvent = procedure(Sender: TObject;
  time: Single;
  deltaTime: Single) of object;

 TvgMouseEvent = procedure(Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X: Single;
  Y: Single) of object;

 TvgMouseMoveEvent = procedure(Sender: TObject;
  Shift: TShiftState;
  X: Single;
  Y: Single;
  Dx: Single;
  Dy: Single) of object;

 TvgMouseWheelEvent = procedure(Sender: TObject;
  Shift: TShiftState;
  WheelDelta: Integer;
  const MousePos: TvgPoint;
  var Handled: Boolean) of object;

 TvgKeyEvent = procedure(Sender: TObject;
  var Key: Word;
  var KeyChar: WideChar;
  Shift: TShiftState) of object;

 TvgCorner = (
  vgCornerTopLeft
  , vgCornerTopRight
  , vgCornerBottomLeft
  , vgCornerBottomRight
 );//TvgCorner

 TvgCorners = set of TvgCorner;

 TvgCornerType = (
  vgCornerRound
  , vgCornerBevel
  , vgCornerInnerRound
  , vgCornerInnerLine
 );//TvgCornerType

 TvgSide = (
  vgSideTop
  , vgSideLeft
  , vgSideBottom
  , vgSideRight
 );//TvgSide

 TvgSides = set of TvgSide;

 TFromZeroToTwoRange = 0 .. 2;

 TvgVectorArray = array [TFromZeroToTwoRange] of Single;

 TvgVectorStruct = record
  X: Single;
  Y: Single;
  W: Single;
 end;//TvgVectorStruct

 TvgVector = packed record
  Case Integer of
   0: (V: TvgVectorArray);
   1: (X: Single; Y: Single; W: Single);
 end;//TvgVector

 TvgMatrixStruct = record
  m11: Single;
  m12: Single;
  m13: Single;
  m21: Single;
  m22: Single;
  m23: Single;
  m31: Single;
  m32: Single;
  m33: Single;
 end;//TvgMatrixStruct

 TvgPolygon = array of TvgPoint;

 TvgColor = Cardinal;

 TFromZeroToZeroRange = 0 .. 0;

 TFromZeroToFourRange = 0 .. 4;

 TvgColorArray = array [TFromZeroToFourRange] of TvgColor;

 TvgColorRecStructW = record
  HiWord: Word;
  LoWord: Word;
 end;//TvgColorRecStructW

 TvgColor24 = packed record
  R: Byte;
  G: Byte;
  B: Byte;
 end;//TvgColor24

 TvgColor24Array = array [TFromZeroToZeroRange] of TvgColor24;

 TvgColorRecStructB = record
 end;//TvgColorRecStructB

{$If Defined(FPC_BIG_ENDIAN)}
 TvgColorRec = packed record
  Case Integer of
   0: (Color: TvgColor);
   1: (HiWord: Word; LoWord: Word);
   2: ();
 end;//TvgColorRec
{$IfEnd} // Defined(FPC_BIG_ENDIAN)

 TvgWrapMode = (
  vgWrapTile
  , vgWrapTileOriginal
  , vgWrapTileStretch
 );//TvgWrapMode

 TvgMatrixArray = array [TFromZeroToTwoRange] of TvgVector;

 TvgMatrix = packed record
  Case Integer of
   0: (M: TvgMatrixArray);
   1: (m11: Single; m12: Single; m13: Single; m21: Single; m22: Single; m23: Single; m31: Single; m32: Single; m33: Single);
 end;//TvgMatrix

 TvgColorRecArray = array [TFromZeroToZeroRange] of TvgColorRec;

const
 cPI: Single = 3.141592654;
 cPIdiv180: Single = 0.017453292;
 c180divPI: Single = 57.29577951;
 c2PI: Single = 6.283185307;
 cPIdiv2: Single = 1.570796326;
 cPIdiv4: Single = 0.785398163;
 c3PIdiv4: Single = 2.35619449;
 cInv2PI: Single = 1/6.283185307;
 cInv360: Single = 1/360;
 c180: Single = 180;
 c360: Single = 360;
 cOneHalf: Single = 0.5;
 Epsilon: Single = 1e-40;
 AllCorners: TvgCorners = [vgCornerTopLeft, vgCornerTopRight, vgCornerBottomLeft, vgCornerBottomRight];
 AllSides: TvgSides = [vgSideTop,vgSideLeft,vgSideBottom,vgSideRight];
 ClosePolygon: TvgPoint = (X: $FFFF; Y: $FFFF);
 CurveKappa = 0.5522847498;
 CurveKappaInv = 1 - CurveKappa;
 vgWideNull = System.WideChar(#0);
 vgWideTabulator = System.WideChar(#9);
 vgWideSpace = System.WideChar(#32);
 vgWideCarriageReturn = System.WideChar($D);
 vgWideLineFeed = System.WideChar($A);
 vgWideVerticalTab = System.WideChar($B);
 vgWideFormFeed = System.WideChar($C);
 vgWideLineSeparator = System.WideChar($2028);
 vgWideParagraphSeparator = System.WideChar($2029);
 BOM_LSB_FIRST = System.WideChar($FEFF);
 BOM_MSB_FIRST = System.WideChar($FFFE);
 IdentityMatrix: TvgMatrix = (m11:1.0;m12:0.0;m13:0.0;m21:0.0;m22:1.0;m23:0.0; m31:0.0;m32:0.0;m33:1.0);
 ZeroMatrix: TvgMatrix = (m11:0.0;m12:0.0;m13:0.0;m21:0.0;m22:0.0;m23:0.0;m31:0.0;m32:0.0;m33:0.0);
 NullRect: TvgRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
