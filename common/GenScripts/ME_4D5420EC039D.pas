unit vgTypes;

interface

uses
 l3IntfUses
 , Controls
 , Classes
;

type
 TvgPoint = record
 end;//TvgPoint
 
 TvgRectLTRB = record
 end;//TvgRectLTRB
 
 TvgRectPoints = record
 end;//TvgRectPoints
 
 TvgRect = record
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
 
 // TFromZeroToTwoRange
 
 TvgVectorArray = array [TFromZeroToTwoRange] of Single;
 
 TvgVectorStruct = record
 end;//TvgVectorStruct
 
 TvgVector = record
 end;//TvgVector
 
 TvgMatrixStruct = record
 end;//TvgMatrixStruct
 
 TvgPolygon = array of TvgPoint;
 
 PvgPolygon = ^TvgPolygon;
 
 TvgColor = Cardinal;
 
 // TFromZeroToZeroRange
 
 // TFromZeroToFourRange
 
 TvgColorArray = array [TFromZeroToFourRange] of TvgColor;
 
 TvgColorRecStructW = record
 end;//TvgColorRecStructW
 
 TvgColor24 = record
 end;//TvgColor24
 
 TvgColor24Array = array [TFromZeroToZeroRange] of TvgColor24;
 
 PvgColor24Array = ^TvgColor24Array;
 
 TvgColorRecStructB = record
 end;//TvgColorRecStructB
 
 PvgColorArray = ^TvgColorArray;
 
 PvgColor = ^TvgColor;
 
 TvgColorRec = record
 end;//TvgColorRec
 
 TvgWrapMode = (
  vgWrapTile
  , vgWrapTileOriginal
  , vgWrapTileStretch
 );//TvgWrapMode
 
 TvgMatrixArray = array [TFromZeroToTwoRange] of TvgVector;
 
 TvgMatrix = record
 end;//TvgMatrix
 
 PvgColorRec = ^TvgColorRec;
 
 TvgColorRecArray = array [TFromZeroToZeroRange] of TvgColorRec;
 
 PvgColorRecArray = ^TvgColorRecArray;
 
 PvgRect = ^TvgRect;
 
implementation

uses
 l3ImplUses
;

end.
