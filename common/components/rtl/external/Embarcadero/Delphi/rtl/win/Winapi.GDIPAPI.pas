      {******************************************************************}
      { GDI+ API                                                         }
      {                                                                  }
      { home page : http://www.progdigy.com                              }
      { email     : hgourvest@progdigy.com                               }
      {                                                                  }
      { date      : 15-02-2002                                           }
      {                                                                  }
      { The contents of this file are used with permission, subject to   }
      { the Mozilla Public License Version 1.1 (the "License"); you may  }
      { not use this file except in compliance with the License. You may }
      { obtain a copy of the License at                                  }
      { http://www.mozilla.org/MPL/MPL-1.1.html                          }
      {                                                                  }
      { Software distributed under the License is distributed on an      }
      { "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   }
      { implied. See the License for the specific language governing     }
      { rights and limitations under the License.                        }
      {                                                                  }
      { *****************************************************************}

{$WEAKPACKAGEUNIT}	  
unit Winapi.GDIPAPI;

{$ALIGN ON}
{$MINENUMSIZE 4}

{$IFDEF CONDITIONALEXPRESSIONS}
  {$DEFINE DELPHI6_UP}
{$ENDIF} 
(*$HPPEMIT '#include <GdiPlus.h>' *)

interface

(**************************************************************************\
*
*   GDI+ public header file
*
\**************************************************************************)

uses
  Winapi.Windows,
  Winapi.ActiveX,
  Winapi.DirectDraw,
  System.Math;

type
  INT16   = type Smallint;
  {$EXTERNALSYM INT16}
  UINT16  = type Word;
  {$EXTERNALSYM UINT16}
  PUINT16 = ^UINT16;
  {$EXTERNALSYM PUINT16}
  UINT32  = type Cardinal;
  {$EXTERNALSYM UINT32}

(**************************************************************************\
*
*   GDI+ Private Memory Management APIs
*
\**************************************************************************)

const WINGDIPDLL = 'gdiplus.dll';
{$EXTERNALSYM WINGDIPDLL}

//----------------------------------------------------------------------------
// Memory Allocation APIs
//----------------------------------------------------------------------------

function GdipAlloc(size: ULONG): pointer; stdcall;
{$EXTERNALSYM GdipAlloc}
procedure GdipFree(ptr: pointer); stdcall;
{$EXTERNALSYM GdipFree}

(**************************************************************************\
*
*   GDI+ base memory allocation class
*
\**************************************************************************)

type
  TGdiplusBase = class
  public
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
  end;
  {$EXTERNALSYM TGdiplusBase }

(**************************************************************************\
*
*   GDI+ Enumeration Types
*
\**************************************************************************)

//--------------------------------------------------------------------------
// Default bezier flattening tolerance in device pixels.
//--------------------------------------------------------------------------

const
  FlatnessDefault = 0.25;
  {$EXTERNALSYM FlatnessDefault}

//--------------------------------------------------------------------------
// Graphics and Container State cookies
//--------------------------------------------------------------------------
type
  GraphicsState     = UINT;
  {$EXTERNALSYM GraphicsState}
  GraphicsContainer = UINT;
  {$EXTERNALSYM GraphicsContainer}

//--------------------------------------------------------------------------
// Fill mode constants
//--------------------------------------------------------------------------

  FillMode = (
    FillModeAlternate,        // 0
    FillModeWinding           // 1
  );
  {$EXTERNALSYM FillMode}
  TFillMode = FillMode;
  {$EXTERNALSYM TFillMode}

//--------------------------------------------------------------------------
// Quality mode constants
//--------------------------------------------------------------------------

{$IFDEF DELPHI6_UP}
  QualityMode = (
    QualityModeInvalid   = -1,
    QualityModeDefault   =  0,
    QualityModeLow       =  1, // Best performance
    QualityModeHigh      =  2  // Best rendering quality
  );
  {$EXTERNALSYM QualityMode}
  TQualityMode = QualityMode;
  {$EXTERNALSYM TQualityMode}
{$ELSE}
  QualityMode = Integer;
  {$EXTERNALSYM QualityMode}
  const
    QualityModeInvalid   = -1;
    QualityModeDefault   =  0;
    QualityModeLow       =  1; // Best performance
    QualityModeHigh      =  2; // Best rendering quality
{$ENDIF}

//--------------------------------------------------------------------------
// Alpha Compositing mode constants
//--------------------------------------------------------------------------
type
  {$EXTERNALSYM CompositingMode}
  CompositingMode = (
    CompositingModeSourceOver,    // 0
    CompositingModeSourceCopy     // 1
  );
  TCompositingMode = CompositingMode;
  {$EXTERNALSYM TCompositingMode}

//--------------------------------------------------------------------------
// Alpha Compositing quality constants
//--------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM CompositingQuality}
  CompositingQuality = (
    CompositingQualityInvalid          = ord(QualityModeInvalid),
    CompositingQualityDefault          = ord(QualityModeDefault),
    CompositingQualityHighSpeed        = ord(QualityModeLow),
    CompositingQualityHighQuality      = ord(QualityModeHigh),
    CompositingQualityGammaCorrected,
    CompositingQualityAssumeLinear
  );
  TCompositingQuality = CompositingQuality;
  {$EXTERNALSYM TCompositingQuality}
{$ELSE}
  {$EXTERNALSYM CompositingQuality}
  CompositingQuality = Integer;
  const
    CompositingQualityInvalid          = QualityModeInvalid;
    CompositingQualityDefault          = QualityModeDefault;
    CompositingQualityHighSpeed        = QualityModeLow;
    CompositingQualityHighQuality      = QualityModeHigh;
    CompositingQualityGammaCorrected   = 3;
    CompositingQualityAssumeLinear     = 4;

type
  TCompositingQuality = CompositingQuality;
{$ENDIF}

//--------------------------------------------------------------------------
// Unit constants
//--------------------------------------------------------------------------

 // {$EXTERNALSYM Unit}
  Unit_ = (
    UnitWorld,      // 0 -- World coordinate (non-physical unit)
    UnitDisplay,    // 1 -- Variable -- for PageTransform only
    UnitPixel,      // 2 -- Each unit is one device pixel.
    UnitPoint,      // 3 -- Each unit is a printer's point, or 1/72 inch.
    UnitInch,       // 4 -- Each unit is 1 inch.
    UnitDocument,   // 5 -- Each unit is 1/300 inch.
    UnitMillimeter  // 6 -- Each unit is 1 millimeter.
  );
  {$EXTERNALSYM Unit_}
  TUnit = Unit_;
  {$EXTERNALSYM TUnit}

//--------------------------------------------------------------------------
// MetafileFrameUnit
//
// The frameRect for creating a metafile can be specified in any of these
// units.  There is an extra frame unit value (MetafileFrameUnitGdi) so
// that units can be supplied in the same units that GDI expects for
// frame rects -- these units are in .01 (1/100ths) millimeter units
// as defined by GDI.
//--------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM MetafileFrameUnit}
  MetafileFrameUnit = (
    MetafileFrameUnitPixel      = ord(UnitPixel),
    MetafileFrameUnitPoint      = ord(UnitPoint),
    MetafileFrameUnitInch       = ord(UnitInch),
    MetafileFrameUnitDocument   = ord(UnitDocument),
    MetafileFrameUnitMillimeter = ord(UnitMillimeter),
    MetafileFrameUnitGdi        // GDI compatible .01 MM units
  );
  TMetafileFrameUnit = MetafileFrameUnit;
  {$EXTERNALSYM TMetafileFrameUnit}
{$ELSE}
  {$EXTERNALSYM MetafileFrameUnit}
  MetafileFrameUnit = Integer;
  const
    MetafileFrameUnitPixel      = 2;
    MetafileFrameUnitPoint      = 3;
    MetafileFrameUnitInch       = 4;
    MetafileFrameUnitDocument   = 5;
    MetafileFrameUnitMillimeter = 6;
    MetafileFrameUnitGdi        = 7; // GDI compatible .01 MM units

type
  TMetafileFrameUnit = MetafileFrameUnit;
{$ENDIF}
//--------------------------------------------------------------------------
// Coordinate space identifiers
//--------------------------------------------------------------------------

  {$EXTERNALSYM CoordinateSpace}
  CoordinateSpace = (
    CoordinateSpaceWorld,     // 0
    CoordinateSpacePage,      // 1
    CoordinateSpaceDevice     // 2
  );
  TCoordinateSpace = CoordinateSpace;
  {$EXTERNALSYM TCoordinateSpace}

//--------------------------------------------------------------------------
// Various wrap modes for brushes
//--------------------------------------------------------------------------

  {$EXTERNALSYM WrapMode}
  WrapMode = (
    WrapModeTile,        // 0
    WrapModeTileFlipX,   // 1
    WrapModeTileFlipY,   // 2
    WrapModeTileFlipXY,  // 3
    WrapModeClamp        // 4
  );
  TWrapMode = WrapMode;
  {$EXTERNALSYM TWrapMode}

//--------------------------------------------------------------------------
// Various hatch styles
//--------------------------------------------------------------------------

  {$EXTERNALSYM HatchStyle}
  HatchStyle = (
    HatchStyleHorizontal,                  // = 0,
    HatchStyleVertical,                    // = 1,
    HatchStyleForwardDiagonal,             // = 2,
    HatchStyleBackwardDiagonal,            // = 3,
    HatchStyleCross,                       // = 4,
    HatchStyleDiagonalCross,               // = 5,
    HatchStyle05Percent,                   // = 6,
    HatchStyle10Percent,                   // = 7,
    HatchStyle20Percent,                   // = 8,
    HatchStyle25Percent,                   // = 9,
    HatchStyle30Percent,                   // = 10,
    HatchStyle40Percent,                   // = 11,
    HatchStyle50Percent,                   // = 12,
    HatchStyle60Percent,                   // = 13,
    HatchStyle70Percent,                   // = 14,
    HatchStyle75Percent,                   // = 15,
    HatchStyle80Percent,                   // = 16,
    HatchStyle90Percent,                   // = 17,
    HatchStyleLightDownwardDiagonal,       // = 18,
    HatchStyleLightUpwardDiagonal,         // = 19,
    HatchStyleDarkDownwardDiagonal,        // = 20,
    HatchStyleDarkUpwardDiagonal,          // = 21,
    HatchStyleWideDownwardDiagonal,        // = 22,
    HatchStyleWideUpwardDiagonal,          // = 23,
    HatchStyleLightVertical,               // = 24,
    HatchStyleLightHorizontal,             // = 25,
    HatchStyleNarrowVertical,              // = 26,
    HatchStyleNarrowHorizontal,            // = 27,
    HatchStyleDarkVertical,                // = 28,
    HatchStyleDarkHorizontal,              // = 29,
    HatchStyleDashedDownwardDiagonal,      // = 30,
    HatchStyleDashedUpwardDiagonal,        // = 31,
    HatchStyleDashedHorizontal,            // = 32,
    HatchStyleDashedVertical,              // = 33,
    HatchStyleSmallConfetti,               // = 34,
    HatchStyleLargeConfetti,               // = 35,
    HatchStyleZigZag,                      // = 36,
    HatchStyleWave,                        // = 37,
    HatchStyleDiagonalBrick,               // = 38,
    HatchStyleHorizontalBrick,             // = 39,
    HatchStyleWeave,                       // = 40,
    HatchStylePlaid,                       // = 41,
    HatchStyleDivot,                       // = 42,
    HatchStyleDottedGrid,                  // = 43,
    HatchStyleDottedDiamond,               // = 44,
    HatchStyleShingle,                     // = 45,
    HatchStyleTrellis,                     // = 46,
    HatchStyleSphere,                      // = 47,
    HatchStyleSmallGrid,                   // = 48,
    HatchStyleSmallCheckerBoard,           // = 49,
    HatchStyleLargeCheckerBoard,           // = 50,
    HatchStyleOutlinedDiamond,             // = 51,
    HatchStyleSolidDiamond,                // = 52,

    HatchStyleTotal                        // = 53,
  );

  const
    HatchStyleLargeGrid = HatchStyleCross; // 4
    {$EXTERNALSYM HatchStyleLargeGrid}
    HatchStyleMin       = HatchStyleHorizontal;
    {$EXTERNALSYM HatchStyleMin}
    HatchStyleMax       = HatchStyleSolidDiamond;
    {$EXTERNALSYM HatchStyleMax}

type
  THatchStyle = HatchStyle;
  {$EXTERNALSYM THatchStyle}

//--------------------------------------------------------------------------
// Dash style constants
//--------------------------------------------------------------------------

  {$EXTERNALSYM DashStyle}
  DashStyle = (
    DashStyleSolid,          // 0
    DashStyleDash,           // 1
    DashStyleDot,            // 2
    DashStyleDashDot,        // 3
    DashStyleDashDotDot,     // 4
    DashStyleCustom          // 5
  );
  TDashStyle = DashStyle;
  {$EXTERNALSYM TDashStyle}

//--------------------------------------------------------------------------
// Dash cap constants
//--------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM DashCap}
  DashCap = (
    DashCapFlat             = 0,
    DashCapRound            = 2,
    DashCapTriangle         = 3
  );
  TDashCap = DashCap;
  {$EXTERNALSYM TDashCap}
{$ELSE}
  {$EXTERNALSYM DashCap}
  DashCap = Integer;
  const
    DashCapFlat             = 0;
    DashCapRound            = 2;
    DashCapTriangle         = 3;

type
  TDashCap = DashCap;
{$ENDIF}

//--------------------------------------------------------------------------
// Line cap constants (only the lowest 8 bits are used).
//--------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM LineCap}
  LineCap = (
    LineCapFlat             = 0,
    LineCapSquare           = 1,
    LineCapRound            = 2,
    LineCapTriangle         = 3,

    LineCapNoAnchor         = $10, // corresponds to flat cap
    LineCapSquareAnchor     = $11, // corresponds to square cap
    LineCapRoundAnchor      = $12, // corresponds to round cap
    LineCapDiamondAnchor    = $13, // corresponds to triangle cap
    LineCapArrowAnchor      = $14, // no correspondence

    LineCapCustom           = $ff, // custom cap

    LineCapAnchorMask       = $f0  // mask to check for anchor or not.
  );
  TLineCap = LineCap;
  {$EXTERNALSYM TLineCap}
{$ELSE}
  {$EXTERNALSYM LineCap}
  LineCap = Integer;
  const
    LineCapFlat             = 0;
    LineCapSquare           = 1;
    LineCapRound            = 2;
    LineCapTriangle         = 3;

    LineCapNoAnchor         = $10; // corresponds to flat cap
    LineCapSquareAnchor     = $11; // corresponds to square cap
    LineCapRoundAnchor      = $12; // corresponds to round cap
    LineCapDiamondAnchor    = $13; // corresponds to triangle cap
    LineCapArrowAnchor      = $14; // no correspondence

    LineCapCustom           = $ff; // custom cap

    LineCapAnchorMask       = $f0; // mask to check for anchor or not.

type
  TLineCap = LineCap;
{$ENDIF}

//--------------------------------------------------------------------------
// Custom Line cap type constants
//--------------------------------------------------------------------------

  {$EXTERNALSYM CustomLineCapType}
  CustomLineCapType = (
    CustomLineCapTypeDefault,
    CustomLineCapTypeAdjustableArrow
  );
  TCustomLineCapType = CustomLineCapType;
  {$EXTERNALSYM TCustomLineCapType}

//--------------------------------------------------------------------------
// Line join constants
//--------------------------------------------------------------------------

  {$EXTERNALSYM LineJoin}
  LineJoin = (
    LineJoinMiter,
    LineJoinBevel,
    LineJoinRound,
    LineJoinMiterClipped
  );
  TLineJoin = LineJoin;
  {$EXTERNALSYM TLineJoin}

//--------------------------------------------------------------------------
// Path point types (only the lowest 8 bits are used.)
//  The lowest 3 bits are interpreted as point type
//  The higher 5 bits are reserved for flags.
//--------------------------------------------------------------------------

{$IFDEF DELPHI6_UP}
  {$Z1}
  {$EXTERNALSYM PathPointType}
  PathPointType = (
    PathPointTypeStart           = $00, // move
    PathPointTypeLine            = $01, // line
    PathPointTypeBezier          = $03, // default Bezier (= cubic Bezier)
    PathPointTypePathTypeMask    = $07, // type mask (lowest 3 bits).
    PathPointTypeDashMode        = $10, // currently in dash mode.
    PathPointTypePathMarker      = $20, // a marker for the path.
    PathPointTypeCloseSubpath    = $80, // closed flag

    // Path types used for advanced path.
    PathPointTypeBezier3         = $03  // cubic Bezier
  );
  TPathPointType = PathPointType;
  {$EXTERNALSYM TPathPointType}
  {$Z4}
{$ELSE}
  {$EXTERNALSYM PathPointType}
  PathPointType = Byte;
  const
    PathPointTypeStart          : Byte = $00; // move
    PathPointTypeLine           : Byte = $01; // line
    PathPointTypeBezier         : Byte = $03; // default Bezier (= cubic Bezier)
    PathPointTypePathTypeMask   : Byte = $07; // type mask (lowest 3 bits).
    PathPointTypeDashMode       : Byte = $10; // currently in dash mode.
    PathPointTypePathMarker     : Byte = $20; // a marker for the path.
    PathPointTypeCloseSubpath   : Byte = $80; // closed flag

    // Path types used for advanced path.
    PathPointTypeBezier3        : Byte = $03;  // cubic Bezier

type
  TPathPointType = PathPointType;
{$ENDIF}

//--------------------------------------------------------------------------
// WarpMode constants
//--------------------------------------------------------------------------

  {$EXTERNALSYM WarpMode}
  WarpMode = (
    WarpModePerspective,    // 0
    WarpModeBilinear        // 1
  );
  TWarpMode = WarpMode;
  {$EXTERNALSYM TWarpMode}

//--------------------------------------------------------------------------
// LineGradient Mode
//--------------------------------------------------------------------------

  {$EXTERNALSYM LinearGradientMode}
  LinearGradientMode = (
    LinearGradientModeHorizontal,         // 0
    LinearGradientModeVertical,           // 1
    LinearGradientModeForwardDiagonal,    // 2
    LinearGradientModeBackwardDiagonal    // 3
  );
  TLinearGradientMode = LinearGradientMode;
  {$EXTERNALSYM TLinearGradientMode}

//--------------------------------------------------------------------------
// Region Comine Modes
//--------------------------------------------------------------------------

  {$EXTERNALSYM CombineMode}
  CombineMode = (
    CombineModeReplace,     // 0
    CombineModeIntersect,   // 1
    CombineModeUnion,       // 2
    CombineModeXor,         // 3
    CombineModeExclude,     // 4
    CombineModeComplement   // 5 (Exclude From)
  );
  TCombineMode = CombineMode;
  {$EXTERNALSYM TCombineMode}

//--------------------------------------------------------------------------
 // Image types
//--------------------------------------------------------------------------

  {$EXTERNALSYM ImageType}
  ImageType = (
    ImageTypeUnknown,   // 0
    ImageTypeBitmap,    // 1
    ImageTypeMetafile   // 2
  );
  TImageType = ImageType;
  {$EXTERNALSYM TImageType}

//--------------------------------------------------------------------------
// Interpolation modes
//--------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM InterpolationMode}
  InterpolationMode = (
    InterpolationModeInvalid          = ord(QualityModeInvalid),
    InterpolationModeDefault          = ord(QualityModeDefault),
    InterpolationModeLowQuality       = ord(QualityModeLow),
    InterpolationModeHighQuality      = ord(QualityModeHigh),
    InterpolationModeBilinear,
    InterpolationModeBicubic,
    InterpolationModeNearestNeighbor,
    InterpolationModeHighQualityBilinear,
    InterpolationModeHighQualityBicubic
  );
  TInterpolationMode = InterpolationMode;
  {$EXTERNALSYM TInterpolationMode}
{$ELSE}
  {$EXTERNALSYM InterpolationMode}
  InterpolationMode = Integer;
  const
    InterpolationModeInvalid             = QualityModeInvalid;
    InterpolationModeDefault             = QualityModeDefault;
    InterpolationModeLowQuality          = QualityModeLow;
    InterpolationModeHighQuality         = QualityModeHigh;
    InterpolationModeBilinear            = 3;
    InterpolationModeBicubic             = 4;
    InterpolationModeNearestNeighbor     = 5;
    InterpolationModeHighQualityBilinear = 6;
    InterpolationModeHighQualityBicubic  = 7;

type
  TInterpolationMode = InterpolationMode;
{$ENDIF}

//--------------------------------------------------------------------------
// Pen types
//--------------------------------------------------------------------------

  {$EXTERNALSYM PenAlignment}
  PenAlignment = (
    PenAlignmentCenter,
    PenAlignmentInset
  );
  TPenAlignment = PenAlignment;
  {$EXTERNALSYM TPenAlignment}

//--------------------------------------------------------------------------
// Brush types
//--------------------------------------------------------------------------

  {$EXTERNALSYM BrushType}
  BrushType = (
   BrushTypeSolidColor,
   BrushTypeHatchFill,
   BrushTypeTextureFill,
   BrushTypePathGradient,
   BrushTypeLinearGradient 
  );
  TBrushType = BrushType;
  {$EXTERNALSYM TBrushType}

//--------------------------------------------------------------------------
// Pen's Fill types
//--------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM PenType}
  PenType = (
   PenTypeSolidColor       =  ord(BrushTypeSolidColor),
   PenTypeHatchFill        =  ord(BrushTypeHatchFill),
   PenTypeTextureFill      =  ord(BrushTypeTextureFill),
   PenTypePathGradient     =  ord(BrushTypePathGradient),
   PenTypeLinearGradient   =  ord(BrushTypeLinearGradient),
   PenTypeUnknown          = -1
  );
  TPenType = PenType;
  {$EXTERNALSYM TPenType}
{$ELSE}
  {$EXTERNALSYM PenType}
  PenType = Integer;
  const
    PenTypeSolidColor       =  0;
    PenTypeHatchFill        =  1;
    PenTypeTextureFill      =  2;
    PenTypePathGradient     =  3;
    PenTypeLinearGradient   =  4;
    PenTypeUnknown          = -1;

type
  TPenType = PenType;
{$ENDIF}

//--------------------------------------------------------------------------
// Matrix Order
//--------------------------------------------------------------------------

  {$EXTERNALSYM MatrixOrder}
  MatrixOrder = (
    MatrixOrderPrepend,
    MatrixOrderAppend
  );
  TMatrixOrder = MatrixOrder;
  {$EXTERNALSYM TMatrixOrder}

//--------------------------------------------------------------------------
// Generic font families
//--------------------------------------------------------------------------

  {$EXTERNALSYM GenericFontFamily}
  GenericFontFamily = (
    GenericFontFamilySerif,
    GenericFontFamilySansSerif,
    GenericFontFamilyMonospace
  );
  TGenericFontFamily = GenericFontFamily;
  {$EXTERNALSYM TGenericFontFamily}

//--------------------------------------------------------------------------
// FontStyle: face types and common styles
//--------------------------------------------------------------------------
type
  {$EXTERNALSYM FontStyle}
  FontStyle = Integer;
  const
    FontStyleRegular    = Integer(0);
    {$EXTERNALSYM FontStyleRegular}
    FontStyleBold       = Integer(1);
    {$EXTERNALSYM FontStyleBold}
    FontStyleItalic     = Integer(2);
    {$EXTERNALSYM FontStyleItalic}
    FontStyleBoldItalic = Integer(3);
    {$EXTERNALSYM FontStyleBoldItalic}
    FontStyleUnderline  = Integer(4);
    {$EXTERNALSYM FontStyleUnderline}
    FontStyleStrikeout  = Integer(8);
    {$EXTERNALSYM FontStyleStrikeout}
  Type
  TFontStyle = FontStyle;
  {$EXTERNALSYM TFontStyle}

//---------------------------------------------------------------------------
// Smoothing Mode
//---------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM SmoothingMode}
  SmoothingMode = (
    SmoothingModeInvalid     = ord(QualityModeInvalid),
    SmoothingModeDefault     = ord(QualityModeDefault),
    SmoothingModeHighSpeed   = ord(QualityModeLow),
    SmoothingModeHighQuality = ord(QualityModeHigh),
    SmoothingModeNone,
    SmoothingModeAntiAlias8x4,
    SmoothingModeAntiAlias   = SmoothingModeAntiAlias8x4,
    SmoothingModeAntiAlias8x8);
  TSmoothingMode = SmoothingMode;
  {$EXTERNALSYM TSmoothingMode}
{$ELSE}
  {$EXTERNALSYM SmoothingMode}
  SmoothingMode = Integer;
  const
    SmoothingModeInvalid     = QualityModeInvalid;
    SmoothingModeDefault     = QualityModeDefault;
    SmoothingModeHighSpeed   = QualityModeLow;
    SmoothingModeHighQuality = QualityModeHigh;
    SmoothingModeNone        = 3;
    SmoothingModeAntiAlias   = 4;

type
  TSmoothingMode = SmoothingMode;
{$ENDIF}

//---------------------------------------------------------------------------
// Pixel Format Mode
//---------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM PixelOffsetMode}
  PixelOffsetMode = (
    PixelOffsetModeInvalid     = Ord(QualityModeInvalid),
    PixelOffsetModeDefault     = Ord(QualityModeDefault),
    PixelOffsetModeHighSpeed   = Ord(QualityModeLow),
    PixelOffsetModeHighQuality = Ord(QualityModeHigh),
    PixelOffsetModeNone,    // No pixel offset
    PixelOffsetModeHalf     // Offset by -0.5, -0.5 for fast anti-alias perf
  );
  TPixelOffsetMode = PixelOffsetMode;
  {$EXTERNALSYM TPixelOffsetMode}
{$ELSE}
  {$EXTERNALSYM PixelOffsetMode}
  PixelOffsetMode = Integer;
  const
    PixelOffsetModeInvalid     = QualityModeInvalid;
    PixelOffsetModeDefault     = QualityModeDefault;
    PixelOffsetModeHighSpeed   = QualityModeLow;
    PixelOffsetModeHighQuality = QualityModeHigh;
    PixelOffsetModeNone        = 3;    // No pixel offset
    PixelOffsetModeHalf        = 4;    // Offset by -0.5, -0.5 for fast anti-alias perf

type
  TPixelOffsetMode = PixelOffsetMode;
{$ENDIF}

//---------------------------------------------------------------------------
// Text Rendering Hint
//---------------------------------------------------------------------------

  {$EXTERNALSYM TextRenderingHint}
  TextRenderingHint = (
    TextRenderingHintSystemDefault,                // Glyph with system default rendering hint
    TextRenderingHintSingleBitPerPixelGridFit,     // Glyph bitmap with hinting
    TextRenderingHintSingleBitPerPixel,            // Glyph bitmap without hinting
    TextRenderingHintAntiAliasGridFit,             // Glyph anti-alias bitmap with hinting
    TextRenderingHintAntiAlias,                    // Glyph anti-alias bitmap without hinting
    TextRenderingHintClearTypeGridFit              // Glyph CT bitmap with hinting
  );
  TTextRenderingHint = TextRenderingHint;
  {$EXTERNALSYM TTextRenderingHint}

//---------------------------------------------------------------------------
// Metafile Types
//---------------------------------------------------------------------------

  {$EXTERNALSYM MetafileType}
  MetafileType = (
    MetafileTypeInvalid,            // Invalid metafile
    MetafileTypeWmf,                // Standard WMF
    MetafileTypeWmfPlaceable,       // Placeable WMF
    MetafileTypeEmf,                // EMF (not EMF+)
    MetafileTypeEmfPlusOnly,        // EMF+ without dual, down-level records
    MetafileTypeEmfPlusDual         // EMF+ with dual, down-level records
  );
  TMetafileType = MetafileType;
  {$EXTERNALSYM TMetafileType}

//---------------------------------------------------------------------------
// Specifies the type of EMF to record
//---------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM EmfType}
  EmfType = (
    EmfTypeEmfOnly     = Ord(MetafileTypeEmf),          // no EMF+, only EMF
    EmfTypeEmfPlusOnly = Ord(MetafileTypeEmfPlusOnly),  // no EMF, only EMF+
    EmfTypeEmfPlusDual = Ord(MetafileTypeEmfPlusDual)   // both EMF+ and EMF
  );
  TEmfType = EmfType;
  {$EXTERNALSYM TEmfType}
{$ELSE}
  {$EXTERNALSYM EmfType}
  EmfType = Integer;
  const
    EmfTypeEmfOnly     = Ord(MetafileTypeEmf);          // no EMF+, only EMF
    EmfTypeEmfPlusOnly = Ord(MetafileTypeEmfPlusOnly);  // no EMF, only EMF+
    EmfTypeEmfPlusDual = Ord(MetafileTypeEmfPlusDual);   // both EMF+ and EMF

type
  TEmfType = EmfType;
{$ENDIF}

//---------------------------------------------------------------------------
// EMF+ Persistent object types
//---------------------------------------------------------------------------

  {$EXTERNALSYM ObjectType}
  ObjectType = (
    ObjectTypeInvalid,
    ObjectTypeBrush,
    ObjectTypePen,
    ObjectTypePath,
    ObjectTypeRegion,
    ObjectTypeImage,
    ObjectTypeFont,
    ObjectTypeStringFormat,
    ObjectTypeImageAttributes,
    ObjectTypeCustomLineCap
  );
  TObjectType = ObjectType;
  {$EXTERNALSYM TObjectType}

const
  ObjectTypeMax = ObjectTypeCustomLineCap;
  {$EXTERNALSYM ObjectTypeMax}
  ObjectTypeMin = ObjectTypeBrush;
  {$EXTERNALSYM ObjectTypeMin}

function ObjectTypeIsValid(type_: ObjectType): BOOL;
{$EXTERNALSYM ObjectTypeIsValid}

//---------------------------------------------------------------------------
// EMF+ Records
//---------------------------------------------------------------------------

  // We have to change the WMF record numbers so that they don't conflict with
  // the EMF and EMF+ record numbers.

const
  GDIP_EMFPLUS_RECORD_BASE      = $00004000;
  {$EXTERNALSYM GDIP_EMFPLUS_RECORD_BASE}
  GDIP_WMF_RECORD_BASE          = $00010000;
  {$EXTERNALSYM GDIP_WMF_RECORD_BASE}

// macros
function GDIP_WMF_RECORD_TO_EMFPLUS(n: integer): Integer;
{$EXTERNALSYM GDIP_WMF_RECORD_TO_EMFPLUS}
function GDIP_EMFPLUS_RECORD_TO_WMF(n: integer): Integer;
{$EXTERNALSYM GDIP_EMFPLUS_RECORD_TO_WMF}
function GDIP_IS_WMF_RECORDTYPE(n: integer): BOOL;
{$EXTERNALSYM GDIP_IS_WMF_RECORDTYPE}


{$IFDEF DELPHI6_UP}
type
  {$EXTERNALSYM EmfPlusRecordType}
  EmfPlusRecordType = (
   // Since we have to enumerate GDI records right along with GDI+ records,
   // We list all the GDI records here so that they can be part of the
   // same enumeration type which is used in the enumeration callback.

    WmfRecordTypeSetBkColor              = (META_SETBKCOLOR or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetBkMode               = (META_SETBKMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetMapMode              = (META_SETMAPMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetROP2                 = (META_SETROP2 or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetRelAbs               = (META_SETRELABS or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPolyFillMode         = (META_SETPOLYFILLMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetStretchBltMode       = (META_SETSTRETCHBLTMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextCharExtra        = (META_SETTEXTCHAREXTRA or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextColor            = (META_SETTEXTCOLOR or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextJustification    = (META_SETTEXTJUSTIFICATION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetWindowOrg            = (META_SETWINDOWORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetWindowExt            = (META_SETWINDOWEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetViewportOrg          = (META_SETVIEWPORTORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetViewportExt          = (META_SETVIEWPORTEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetWindowOrg         = (META_OFFSETWINDOWORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeScaleWindowExt          = (META_SCALEWINDOWEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetViewportOrg       = (META_OFFSETVIEWPORTORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeScaleViewportExt        = (META_SCALEVIEWPORTEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeLineTo                  = (META_LINETO or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeMoveTo                  = (META_MOVETO or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExcludeClipRect         = (META_EXCLUDECLIPRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeIntersectClipRect       = (META_INTERSECTCLIPRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeArc                     = (META_ARC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeEllipse                 = (META_ELLIPSE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFloodFill               = (META_FLOODFILL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePie                     = (META_PIE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRectangle               = (META_RECTANGLE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRoundRect               = (META_ROUNDRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePatBlt                  = (META_PATBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSaveDC                  = (META_SAVEDC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPixel                = (META_SETPIXEL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetClipRgn           = (META_OFFSETCLIPRGN or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeTextOut                 = (META_TEXTOUT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeBitBlt                  = (META_BITBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeStretchBlt              = (META_STRETCHBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolygon                 = (META_POLYGON or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolyline                = (META_POLYLINE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeEscape                  = (META_ESCAPE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRestoreDC               = (META_RESTOREDC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFillRegion              = (META_FILLREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFrameRegion             = (META_FRAMEREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeInvertRegion            = (META_INVERTREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePaintRegion             = (META_PAINTREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectClipRegion        = (META_SELECTCLIPREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectObject            = (META_SELECTOBJECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextAlign            = (META_SETTEXTALIGN or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDrawText                = ($062F or GDIP_WMF_RECORD_BASE),  // META_DRAWTEXT
    WmfRecordTypeChord                   = (META_CHORD or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetMapperFlags          = (META_SETMAPPERFLAGS or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExtTextOut              = (META_EXTTEXTOUT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetDIBToDev             = (META_SETDIBTODEV or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectPalette           = (META_SELECTPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRealizePalette          = (META_REALIZEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeAnimatePalette          = (META_ANIMATEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPalEntries           = (META_SETPALENTRIES or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolyPolygon             = (META_POLYPOLYGON or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeResizePalette           = (META_RESIZEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBBitBlt               = (META_DIBBITBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBStretchBlt           = (META_DIBSTRETCHBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBCreatePatternBrush   = (META_DIBCREATEPATTERNBRUSH or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeStretchDIB              = (META_STRETCHDIB or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExtFloodFill            = (META_EXTFLOODFILL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetLayout               = ($0149 or GDIP_WMF_RECORD_BASE),  // META_SETLAYOUT
    WmfRecordTypeResetDC                 = ($014C or GDIP_WMF_RECORD_BASE),  // META_RESETDC
    WmfRecordTypeStartDoc                = ($014D or GDIP_WMF_RECORD_BASE),  // META_STARTDOC
    WmfRecordTypeStartPage               = ($004F or GDIP_WMF_RECORD_BASE),  // META_STARTPAGE
    WmfRecordTypeEndPage                 = ($0050 or GDIP_WMF_RECORD_BASE),  // META_ENDPAGE
    WmfRecordTypeAbortDoc                = ($0052 or GDIP_WMF_RECORD_BASE),  // META_ABORTDOC
    WmfRecordTypeEndDoc                  = ($005E or GDIP_WMF_RECORD_BASE),  // META_ENDDOC
    WmfRecordTypeDeleteObject            = (META_DELETEOBJECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreatePalette           = (META_CREATEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBrush             = ($00F8 or GDIP_WMF_RECORD_BASE),  // META_CREATEBRUSH
    WmfRecordTypeCreatePatternBrush      = (META_CREATEPATTERNBRUSH or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreatePenIndirect       = (META_CREATEPENINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateFontIndirect      = (META_CREATEFONTINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBrushIndirect     = (META_CREATEBRUSHINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBitmapIndirect    = ($02FD or GDIP_WMF_RECORD_BASE),  // META_CREATEBITMAPINDIRECT
    WmfRecordTypeCreateBitmap            = ($06FE or GDIP_WMF_RECORD_BASE),  // META_CREATEBITMAP
    WmfRecordTypeCreateRegion            = (META_CREATEREGION or GDIP_WMF_RECORD_BASE),

    EmfRecordTypeHeader                  = EMR_HEADER,
    EmfRecordTypePolyBezier              = EMR_POLYBEZIER,
    EmfRecordTypePolygon                 = EMR_POLYGON,
    EmfRecordTypePolyline                = EMR_POLYLINE,
    EmfRecordTypePolyBezierTo            = EMR_POLYBEZIERTO,
    EmfRecordTypePolyLineTo              = EMR_POLYLINETO,
    EmfRecordTypePolyPolyline            = EMR_POLYPOLYLINE,
    EmfRecordTypePolyPolygon             = EMR_POLYPOLYGON,
    EmfRecordTypeSetWindowExtEx          = EMR_SETWINDOWEXTEX,
    EmfRecordTypeSetWindowOrgEx          = EMR_SETWINDOWORGEX,
    EmfRecordTypeSetViewportExtEx        = EMR_SETVIEWPORTEXTEX,
    EmfRecordTypeSetViewportOrgEx        = EMR_SETVIEWPORTORGEX,
    EmfRecordTypeSetBrushOrgEx           = EMR_SETBRUSHORGEX,
    EmfRecordTypeEOF                     = EMR_EOF,
    EmfRecordTypeSetPixelV               = EMR_SETPIXELV,
    EmfRecordTypeSetMapperFlags          = EMR_SETMAPPERFLAGS,
    EmfRecordTypeSetMapMode              = EMR_SETMAPMODE,
    EmfRecordTypeSetBkMode               = EMR_SETBKMODE,
    EmfRecordTypeSetPolyFillMode         = EMR_SETPOLYFILLMODE,
    EmfRecordTypeSetROP2                 = EMR_SETROP2,
    EmfRecordTypeSetStretchBltMode       = EMR_SETSTRETCHBLTMODE,
    EmfRecordTypeSetTextAlign            = EMR_SETTEXTALIGN,
    EmfRecordTypeSetColorAdjustment      = EMR_SETCOLORADJUSTMENT,
    EmfRecordTypeSetTextColor            = EMR_SETTEXTCOLOR,
    EmfRecordTypeSetBkColor              = EMR_SETBKCOLOR,
    EmfRecordTypeOffsetClipRgn           = EMR_OFFSETCLIPRGN,
    EmfRecordTypeMoveToEx                = EMR_MOVETOEX,
    EmfRecordTypeSetMetaRgn              = EMR_SETMETARGN,
    EmfRecordTypeExcludeClipRect         = EMR_EXCLUDECLIPRECT,
    EmfRecordTypeIntersectClipRect       = EMR_INTERSECTCLIPRECT,
    EmfRecordTypeScaleViewportExtEx      = EMR_SCALEVIEWPORTEXTEX,
    EmfRecordTypeScaleWindowExtEx        = EMR_SCALEWINDOWEXTEX,
    EmfRecordTypeSaveDC                  = EMR_SAVEDC,
    EmfRecordTypeRestoreDC               = EMR_RESTOREDC,
    EmfRecordTypeSetWorldTransform       = EMR_SETWORLDTRANSFORM,
    EmfRecordTypeModifyWorldTransform    = EMR_MODIFYWORLDTRANSFORM,
    EmfRecordTypeSelectObject            = EMR_SELECTOBJECT,
    EmfRecordTypeCreatePen               = EMR_CREATEPEN,
    EmfRecordTypeCreateBrushIndirect     = EMR_CREATEBRUSHINDIRECT,
    EmfRecordTypeDeleteObject            = EMR_DELETEOBJECT,
    EmfRecordTypeAngleArc                = EMR_ANGLEARC,
    EmfRecordTypeEllipse                 = EMR_ELLIPSE,
    EmfRecordTypeRectangle               = EMR_RECTANGLE,
    EmfRecordTypeRoundRect               = EMR_ROUNDRECT,
    EmfRecordTypeArc                     = EMR_ARC,
    EmfRecordTypeChord                   = EMR_CHORD,
    EmfRecordTypePie                     = EMR_PIE,
    EmfRecordTypeSelectPalette           = EMR_SELECTPALETTE,
    EmfRecordTypeCreatePalette           = EMR_CREATEPALETTE,
    EmfRecordTypeSetPaletteEntries       = EMR_SETPALETTEENTRIES,
    EmfRecordTypeResizePalette           = EMR_RESIZEPALETTE,
    EmfRecordTypeRealizePalette          = EMR_REALIZEPALETTE,
    EmfRecordTypeExtFloodFill            = EMR_EXTFLOODFILL,
    EmfRecordTypeLineTo                  = EMR_LINETO,
    EmfRecordTypeArcTo                   = EMR_ARCTO,
    EmfRecordTypePolyDraw                = EMR_POLYDRAW,
    EmfRecordTypeSetArcDirection         = EMR_SETARCDIRECTION,
    EmfRecordTypeSetMiterLimit           = EMR_SETMITERLIMIT,
    EmfRecordTypeBeginPath               = EMR_BEGINPATH,
    EmfRecordTypeEndPath                 = EMR_ENDPATH,
    EmfRecordTypeCloseFigure             = EMR_CLOSEFIGURE,
    EmfRecordTypeFillPath                = EMR_FILLPATH,
    EmfRecordTypeStrokeAndFillPath       = EMR_STROKEANDFILLPATH,
    EmfRecordTypeStrokePath              = EMR_STROKEPATH,
    EmfRecordTypeFlattenPath             = EMR_FLATTENPATH,
    EmfRecordTypeWidenPath               = EMR_WIDENPATH,
    EmfRecordTypeSelectClipPath          = EMR_SELECTCLIPPATH,
    EmfRecordTypeAbortPath               = EMR_ABORTPATH,
    EmfRecordTypeReserved_069            = 69,  // Not Used
    EmfRecordTypeGdiComment              = EMR_GDICOMMENT,
    EmfRecordTypeFillRgn                 = EMR_FILLRGN,
    EmfRecordTypeFrameRgn                = EMR_FRAMERGN,
    EmfRecordTypeInvertRgn               = EMR_INVERTRGN,
    EmfRecordTypePaintRgn                = EMR_PAINTRGN,
    EmfRecordTypeExtSelectClipRgn        = EMR_EXTSELECTCLIPRGN,
    EmfRecordTypeBitBlt                  = EMR_BITBLT,
    EmfRecordTypeStretchBlt              = EMR_STRETCHBLT,
    EmfRecordTypeMaskBlt                 = EMR_MASKBLT,
    EmfRecordTypePlgBlt                  = EMR_PLGBLT,
    EmfRecordTypeSetDIBitsToDevice       = EMR_SETDIBITSTODEVICE,
    EmfRecordTypeStretchDIBits           = EMR_STRETCHDIBITS,
    EmfRecordTypeExtCreateFontIndirect   = EMR_EXTCREATEFONTINDIRECTW,
    EmfRecordTypeExtTextOutA             = EMR_EXTTEXTOUTA,
    EmfRecordTypeExtTextOutW             = EMR_EXTTEXTOUTW,
    EmfRecordTypePolyBezier16            = EMR_POLYBEZIER16,
    EmfRecordTypePolygon16               = EMR_POLYGON16,
    EmfRecordTypePolyline16              = EMR_POLYLINE16,
    EmfRecordTypePolyBezierTo16          = EMR_POLYBEZIERTO16,
    EmfRecordTypePolylineTo16            = EMR_POLYLINETO16,
    EmfRecordTypePolyPolyline16          = EMR_POLYPOLYLINE16,
    EmfRecordTypePolyPolygon16           = EMR_POLYPOLYGON16,
    EmfRecordTypePolyDraw16              = EMR_POLYDRAW16,
    EmfRecordTypeCreateMonoBrush         = EMR_CREATEMONOBRUSH,
    EmfRecordTypeCreateDIBPatternBrushPt = EMR_CREATEDIBPATTERNBRUSHPT,
    EmfRecordTypeExtCreatePen            = EMR_EXTCREATEPEN,
    EmfRecordTypePolyTextOutA            = EMR_POLYTEXTOUTA,
    EmfRecordTypePolyTextOutW            = EMR_POLYTEXTOUTW,
    EmfRecordTypeSetICMMode              = 98,  // EMR_SETICMMODE,
    EmfRecordTypeCreateColorSpace        = 99,  // EMR_CREATECOLORSPACE,
    EmfRecordTypeSetColorSpace           = 100, // EMR_SETCOLORSPACE,
    EmfRecordTypeDeleteColorSpace        = 101, // EMR_DELETECOLORSPACE,
    EmfRecordTypeGLSRecord               = 102, // EMR_GLSRECORD,
    EmfRecordTypeGLSBoundedRecord        = 103, // EMR_GLSBOUNDEDRECORD,
    EmfRecordTypePixelFormat             = 104, // EMR_PIXELFORMAT,
    EmfRecordTypeDrawEscape              = 105, // EMR_RESERVED_105,
    EmfRecordTypeExtEscape               = 106, // EMR_RESERVED_106,
    EmfRecordTypeStartDoc                = 107, // EMR_RESERVED_107,
    EmfRecordTypeSmallTextOut            = 108, // EMR_RESERVED_108,
    EmfRecordTypeForceUFIMapping         = 109, // EMR_RESERVED_109,
    EmfRecordTypeNamedEscape             = 110, // EMR_RESERVED_110,
    EmfRecordTypeColorCorrectPalette     = 111, // EMR_COLORCORRECTPALETTE,
    EmfRecordTypeSetICMProfileA          = 112, // EMR_SETICMPROFILEA,
    EmfRecordTypeSetICMProfileW          = 113, // EMR_SETICMPROFILEW,
    EmfRecordTypeAlphaBlend              = 114, // EMR_ALPHABLEND,
    EmfRecordTypeSetLayout               = 115, // EMR_SETLAYOUT,
    EmfRecordTypeTransparentBlt          = 116, // EMR_TRANSPARENTBLT,
    EmfRecordTypeReserved_117            = 117, // Not Used
    EmfRecordTypeGradientFill            = 118, // EMR_GRADIENTFILL,
    EmfRecordTypeSetLinkedUFIs           = 119, // EMR_RESERVED_119,
    EmfRecordTypeSetTextJustification    = 120, // EMR_RESERVED_120,
    EmfRecordTypeColorMatchToTargetW     = 121, // EMR_COLORMATCHTOTARGETW,
    EmfRecordTypeCreateColorSpaceW       = 122, // EMR_CREATECOLORSPACEW,
    EmfRecordTypeMax                     = 122,
    EmfRecordTypeMin                     = 1,

    // That is the END of the GDI EMF records.

    // Now we start the list of EMF+ records.  We leave quite
    // a bit of room here for the addition of any new GDI
    // records that may be added later.

    EmfPlusRecordTypeInvalid = GDIP_EMFPLUS_RECORD_BASE,
    EmfPlusRecordTypeHeader,
    EmfPlusRecordTypeEndOfFile,

    EmfPlusRecordTypeComment,

    EmfPlusRecordTypeGetDC,

    EmfPlusRecordTypeMultiFormatStart,
    EmfPlusRecordTypeMultiFormatSection,
    EmfPlusRecordTypeMultiFormatEnd,

    // For all persistent objects

    EmfPlusRecordTypeObject,

    // Drawing Records

    EmfPlusRecordTypeClear,
    EmfPlusRecordTypeFillRects,
    EmfPlusRecordTypeDrawRects,
    EmfPlusRecordTypeFillPolygon,
    EmfPlusRecordTypeDrawLines,
    EmfPlusRecordTypeFillEllipse,
    EmfPlusRecordTypeDrawEllipse,
    EmfPlusRecordTypeFillPie,
    EmfPlusRecordTypeDrawPie,
    EmfPlusRecordTypeDrawArc,
    EmfPlusRecordTypeFillRegion,
    EmfPlusRecordTypeFillPath,
    EmfPlusRecordTypeDrawPath,
    EmfPlusRecordTypeFillClosedCurve,
    EmfPlusRecordTypeDrawClosedCurve,
    EmfPlusRecordTypeDrawCurve,
    EmfPlusRecordTypeDrawBeziers,
    EmfPlusRecordTypeDrawImage,
    EmfPlusRecordTypeDrawImagePoints,
    EmfPlusRecordTypeDrawString,

    // Graphics State Records

    EmfPlusRecordTypeSetRenderingOrigin,
    EmfPlusRecordTypeSetAntiAliasMode,
    EmfPlusRecordTypeSetTextRenderingHint,
    EmfPlusRecordTypeSetTextContrast,
    EmfPlusRecordTypeSetInterpolationMode,
    EmfPlusRecordTypeSetPixelOffsetMode,
    EmfPlusRecordTypeSetCompositingMode,
    EmfPlusRecordTypeSetCompositingQuality,
    EmfPlusRecordTypeSave,
    EmfPlusRecordTypeRestore,
    EmfPlusRecordTypeBeginContainer,
    EmfPlusRecordTypeBeginContainerNoParams,
    EmfPlusRecordTypeEndContainer,
    EmfPlusRecordTypeSetWorldTransform,
    EmfPlusRecordTypeResetWorldTransform,
    EmfPlusRecordTypeMultiplyWorldTransform,
    EmfPlusRecordTypeTranslateWorldTransform,
    EmfPlusRecordTypeScaleWorldTransform,
    EmfPlusRecordTypeRotateWorldTransform,
    EmfPlusRecordTypeSetPageTransform,
    EmfPlusRecordTypeResetClip,
    EmfPlusRecordTypeSetClipRect,
    EmfPlusRecordTypeSetClipPath,
    EmfPlusRecordTypeSetClipRegion,
    EmfPlusRecordTypeOffsetClip,

    EmfPlusRecordTypeDrawDriverString,

    EmfPlusRecordTotal,

    EmfPlusRecordTypeMax = EmfPlusRecordTotal-1,
    EmfPlusRecordTypeMin = EmfPlusRecordTypeHeader
  );
  TEmfPlusRecordType = EmfPlusRecordType;
  {$EXTERNALSYM TEmfPlusRecordType}
{$ELSE}
type
  {$EXTERNALSYM EmfPlusRecordType}
  EmfPlusRecordType = Integer;
  // Since we have to enumerate GDI records right along with GDI+ records,
  // We list all the GDI records here so that they can be part of the
  // same enumeration type which is used in the enumeration callback.
  const
    WmfRecordTypeSetBkColor              = (META_SETBKCOLOR or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetBkColor}
    WmfRecordTypeSetBkMode               = (META_SETBKMODE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetBkMode}
    WmfRecordTypeSetMapMode              = (META_SETMAPMODE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetMapMode}
    WmfRecordTypeSetROP2                 = (META_SETROP2 or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetROP2}
    WmfRecordTypeSetRelAbs               = (META_SETRELABS or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetRelAbs}
    WmfRecordTypeSetPolyFillMode         = (META_SETPOLYFILLMODE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetPolyFillMode}
    WmfRecordTypeSetStretchBltMode       = (META_SETSTRETCHBLTMODE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetStretchBltMode}
    WmfRecordTypeSetTextCharExtra        = (META_SETTEXTCHAREXTRA or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetTextCharExtra}
    WmfRecordTypeSetTextColor            = (META_SETTEXTCOLOR or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetTextColor}
    WmfRecordTypeSetTextJustification    = (META_SETTEXTJUSTIFICATION or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetTextJustification}
    WmfRecordTypeSetWindowOrg            = (META_SETWINDOWORG or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetWindowOrg}
    WmfRecordTypeSetWindowExt            = (META_SETWINDOWEXT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetWindowExt}
    WmfRecordTypeSetViewportOrg          = (META_SETVIEWPORTORG or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetViewportOrg}
    WmfRecordTypeSetViewportExt          = (META_SETVIEWPORTEXT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetViewportExt}
    WmfRecordTypeOffsetWindowOrg         = (META_OFFSETWINDOWORG or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeOffsetWindowOrg}
    WmfRecordTypeScaleWindowExt          = (META_SCALEWINDOWEXT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeScaleWindowExt}
    WmfRecordTypeOffsetViewportOrg       = (META_OFFSETVIEWPORTORG or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeOffsetViewportOrg}
    WmfRecordTypeScaleViewportExt        = (META_SCALEVIEWPORTEXT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeScaleViewportExt}
    WmfRecordTypeLineTo                  = (META_LINETO or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeLineTo}
    WmfRecordTypeMoveTo                  = (META_MOVETO or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeMoveTo}
    WmfRecordTypeExcludeClipRect         = (META_EXCLUDECLIPRECT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeExcludeClipRect}
    WmfRecordTypeIntersectClipRect       = (META_INTERSECTCLIPRECT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeIntersectClipRect}
    WmfRecordTypeArc                     = (META_ARC or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeArc}
    WmfRecordTypeEllipse                 = (META_ELLIPSE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeEllipse}
    WmfRecordTypeFloodFill               = (META_FLOODFILL or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeFloodFill}
    WmfRecordTypePie                     = (META_PIE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypePie}
    WmfRecordTypeRectangle               = (META_RECTANGLE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeRectangle}
    WmfRecordTypeRoundRect               = (META_ROUNDRECT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeRoundRect}
    WmfRecordTypePatBlt                  = (META_PATBLT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypePatBlt}
    WmfRecordTypeSaveDC                  = (META_SAVEDC or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSaveDC}
    WmfRecordTypeSetPixel                = (META_SETPIXEL or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetPixel}
    WmfRecordTypeOffsetClipRgn           = (META_OFFSETCLIPRGN or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeOffsetClipRgn}
    WmfRecordTypeTextOut                 = (META_TEXTOUT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeTextOut}
    WmfRecordTypeBitBlt                  = (META_BITBLT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeBitBlt}
    WmfRecordTypeStretchBlt              = (META_STRETCHBLT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeStretchBlt}
    WmfRecordTypePolygon                 = (META_POLYGON or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypePolygon}
    WmfRecordTypePolyline                = (META_POLYLINE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypePolyline}
    WmfRecordTypeEscape                  = (META_ESCAPE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeEscape}
    WmfRecordTypeRestoreDC               = (META_RESTOREDC or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeRestoreDC}
    WmfRecordTypeFillRegion              = (META_FILLREGION or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeFillRegion}
    WmfRecordTypeFrameRegion             = (META_FRAMEREGION or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeFrameRegion}
    WmfRecordTypeInvertRegion            = (META_INVERTREGION or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeInvertRegion}
    WmfRecordTypePaintRegion             = (META_PAINTREGION or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypePaintRegion}
    WmfRecordTypeSelectClipRegion        = (META_SELECTCLIPREGION or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSelectClipRegion}
    WmfRecordTypeSelectObject            = (META_SELECTOBJECT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSelectObject}
    WmfRecordTypeSetTextAlign            = (META_SETTEXTALIGN or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetTextAlign}
    WmfRecordTypeDrawText                = ($062F or GDIP_WMF_RECORD_BASE);  // META_DRAWTEXT
    {$EXTERNALSYM WmfRecordTypeDrawText}
    WmfRecordTypeChord                   = (META_CHORD or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeChord}
    WmfRecordTypeSetMapperFlags          = (META_SETMAPPERFLAGS or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetMapperFlags}
    WmfRecordTypeExtTextOut              = (META_EXTTEXTOUT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeExtTextOut}
    WmfRecordTypeSetDIBToDev             = (META_SETDIBTODEV or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetDIBToDev}
    WmfRecordTypeSelectPalette           = (META_SELECTPALETTE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSelectPalette}
    WmfRecordTypeRealizePalette          = (META_REALIZEPALETTE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeRealizePalette}
    WmfRecordTypeAnimatePalette          = (META_ANIMATEPALETTE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeAnimatePalette}
    WmfRecordTypeSetPalEntries           = (META_SETPALENTRIES or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeSetPalEntries}
    WmfRecordTypePolyPolygon             = (META_POLYPOLYGON or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypePolyPolygon}
    WmfRecordTypeResizePalette           = (META_RESIZEPALETTE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeResizePalette}
    WmfRecordTypeDIBBitBlt               = (META_DIBBITBLT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeDIBBitBlt}
    WmfRecordTypeDIBStretchBlt           = (META_DIBSTRETCHBLT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeDIBStretchBlt}
    WmfRecordTypeDIBCreatePatternBrush   = (META_DIBCREATEPATTERNBRUSH or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeDIBCreatePatternBrush}
    WmfRecordTypeStretchDIB              = (META_STRETCHDIB or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeStretchDIB}
    WmfRecordTypeExtFloodFill            = (META_EXTFLOODFILL or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeExtFloodFill}
    WmfRecordTypeSetLayout               = ($0149 or GDIP_WMF_RECORD_BASE);  // META_SETLAYOUT
    {$EXTERNALSYM WmfRecordTypeSetLayout}
    WmfRecordTypeResetDC                 = ($014C or GDIP_WMF_RECORD_BASE);  // META_RESETDC
    {$EXTERNALSYM WmfRecordTypeResetDC}
    WmfRecordTypeStartDoc                = ($014D or GDIP_WMF_RECORD_BASE);  // META_STARTDOC
    {$EXTERNALSYM WmfRecordTypeStartDoc}
    WmfRecordTypeStartPage               = ($004F or GDIP_WMF_RECORD_BASE);  // META_STARTPAGE
    {$EXTERNALSYM WmfRecordTypeStartPage}
    WmfRecordTypeEndPage                 = ($0050 or GDIP_WMF_RECORD_BASE);  // META_ENDPAGE
    {$EXTERNALSYM WmfRecordTypeEndPage}
    WmfRecordTypeAbortDoc                = ($0052 or GDIP_WMF_RECORD_BASE);  // META_ABORTDOC
    {$EXTERNALSYM WmfRecordTypeAbortDoc}
    WmfRecordTypeEndDoc                  = ($005E or GDIP_WMF_RECORD_BASE);  // META_ENDDOC
    {$EXTERNALSYM WmfRecordTypeEndDoc}
    WmfRecordTypeDeleteObject            = (META_DELETEOBJECT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeDeleteObject}
    WmfRecordTypeCreatePalette           = (META_CREATEPALETTE or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeCreatePalette}
    WmfRecordTypeCreateBrush             = ($00F8 or GDIP_WMF_RECORD_BASE);  // META_CREATEBRUSH
    {$EXTERNALSYM WmfRecordTypeCreateBrush}
    WmfRecordTypeCreatePatternBrush      = (META_CREATEPATTERNBRUSH or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeCreatePatternBrush}
    WmfRecordTypeCreatePenIndirect       = (META_CREATEPENINDIRECT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeCreatePenIndirect}
    WmfRecordTypeCreateFontIndirect      = (META_CREATEFONTINDIRECT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeCreateFontIndirect}
    WmfRecordTypeCreateBrushIndirect     = (META_CREATEBRUSHINDIRECT or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeCreateBrushIndirect}
    WmfRecordTypeCreateBitmapIndirect    = ($02FD or GDIP_WMF_RECORD_BASE);  // META_CREATEBITMAPINDIRECT
    {$EXTERNALSYM WmfRecordTypeCreateBitmapIndirect}
    WmfRecordTypeCreateBitmap            = ($06FE or GDIP_WMF_RECORD_BASE);  // META_CREATEBITMAP
    {$EXTERNALSYM WmfRecordTypeCreateBitmap}
    WmfRecordTypeCreateRegion            = (META_CREATEREGION or GDIP_WMF_RECORD_BASE);
    {$EXTERNALSYM WmfRecordTypeCreateRegion}

    EmfRecordTypeHeader                  = EMR_HEADER;
    {$EXTERNALSYM EmfRecordTypeHeader}
    EmfRecordTypePolyBezier              = EMR_POLYBEZIER;
    {$EXTERNALSYM EmfRecordTypePolyBezier}
    EmfRecordTypePolygon                 = EMR_POLYGON;
    {$EXTERNALSYM EmfRecordTypePolygon}
    EmfRecordTypePolyline                = EMR_POLYLINE;
    {$EXTERNALSYM EmfRecordTypePolyline}
    EmfRecordTypePolyBezierTo            = EMR_POLYBEZIERTO;
    {$EXTERNALSYM EmfRecordTypePolyBezierTo}
    EmfRecordTypePolyLineTo              = EMR_POLYLINETO;
    {$EXTERNALSYM EmfRecordTypePolyLineTo}
    EmfRecordTypePolyPolyline            = EMR_POLYPOLYLINE;
    {$EXTERNALSYM EmfRecordTypePolyPolyline}
    EmfRecordTypePolyPolygon             = EMR_POLYPOLYGON;
    {$EXTERNALSYM EmfRecordTypePolyPolygon}
    EmfRecordTypeSetWindowExtEx          = EMR_SETWINDOWEXTEX;
    {$EXTERNALSYM EmfRecordTypeSetWindowExtEx}
    EmfRecordTypeSetWindowOrgEx          = EMR_SETWINDOWORGEX;
    {$EXTERNALSYM EmfRecordTypeSetWindowOrgEx}
    EmfRecordTypeSetViewportExtEx        = EMR_SETVIEWPORTEXTEX;
    {$EXTERNALSYM EmfRecordTypeSetViewportExtEx}
    EmfRecordTypeSetViewportOrgEx        = EMR_SETVIEWPORTORGEX;
    {$EXTERNALSYM EmfRecordTypeSetViewportOrgEx}
    EmfRecordTypeSetBrushOrgEx           = EMR_SETBRUSHORGEX;
    {$EXTERNALSYM EmfRecordTypeSetBrushOrgEx}
    EmfRecordTypeEOF                     = EMR_EOF;
    {$EXTERNALSYM EmfRecordTypeEOF}
    EmfRecordTypeSetPixelV               = EMR_SETPIXELV;
    {$EXTERNALSYM EmfRecordTypeSetPixelV}
    EmfRecordTypeSetMapperFlags          = EMR_SETMAPPERFLAGS;
    {$EXTERNALSYM EmfRecordTypeSetMapperFlags}
    EmfRecordTypeSetMapMode              = EMR_SETMAPMODE;
    {$EXTERNALSYM EmfRecordTypeSetMapMode}
    EmfRecordTypeSetBkMode               = EMR_SETBKMODE;
    {$EXTERNALSYM EmfRecordTypeSetBkMode}
    EmfRecordTypeSetPolyFillMode         = EMR_SETPOLYFILLMODE;
    {$EXTERNALSYM EmfRecordTypeSetPolyFillMode}
    EmfRecordTypeSetROP2                 = EMR_SETROP2;
    {$EXTERNALSYM EmfRecordTypeSetROP2}
    EmfRecordTypeSetStretchBltMode       = EMR_SETSTRETCHBLTMODE;
    {$EXTERNALSYM EmfRecordTypeSetStretchBltMode}
    EmfRecordTypeSetTextAlign            = EMR_SETTEXTALIGN;
    {$EXTERNALSYM EmfRecordTypeSetTextAlign}
    EmfRecordTypeSetColorAdjustment      = EMR_SETCOLORADJUSTMENT;
    {$EXTERNALSYM EmfRecordTypeSetColorAdjustment}
    EmfRecordTypeSetTextColor            = EMR_SETTEXTCOLOR;
    {$EXTERNALSYM EmfRecordTypeSetTextColor}
    EmfRecordTypeSetBkColor              = EMR_SETBKCOLOR;
    {$EXTERNALSYM EmfRecordTypeSetBkColor}
    EmfRecordTypeOffsetClipRgn           = EMR_OFFSETCLIPRGN;
    {$EXTERNALSYM EmfRecordTypeOffsetClipRgn}
    EmfRecordTypeMoveToEx                = EMR_MOVETOEX;
    {$EXTERNALSYM EmfRecordTypeMoveToEx}
    EmfRecordTypeSetMetaRgn              = EMR_SETMETARGN;
    {$EXTERNALSYM EmfRecordTypeSetMetaRgn}
    EmfRecordTypeExcludeClipRect         = EMR_EXCLUDECLIPRECT;
    {$EXTERNALSYM EmfRecordTypeExcludeClipRect}
    EmfRecordTypeIntersectClipRect       = EMR_INTERSECTCLIPRECT;
    {$EXTERNALSYM EmfRecordTypeIntersectClipRect}
    EmfRecordTypeScaleViewportExtEx      = EMR_SCALEVIEWPORTEXTEX;
    {$EXTERNALSYM EmfRecordTypeScaleViewportExtEx}
    EmfRecordTypeScaleWindowExtEx        = EMR_SCALEWINDOWEXTEX;
    {$EXTERNALSYM EmfRecordTypeScaleWindowExtEx}
    EmfRecordTypeSaveDC                  = EMR_SAVEDC;
    {$EXTERNALSYM EmfRecordTypeSaveDC}
    EmfRecordTypeRestoreDC               = EMR_RESTOREDC;
    {$EXTERNALSYM EmfRecordTypeRestoreDC}
    EmfRecordTypeSetWorldTransform       = EMR_SETWORLDTRANSFORM;
    {$EXTERNALSYM EmfRecordTypeSetWorldTransform}
    EmfRecordTypeModifyWorldTransform    = EMR_MODIFYWORLDTRANSFORM;
    {$EXTERNALSYM EmfRecordTypeModifyWorldTransform}
    EmfRecordTypeSelectObject            = EMR_SELECTOBJECT;
    {$EXTERNALSYM EmfRecordTypeSelectObject}
    EmfRecordTypeCreatePen               = EMR_CREATEPEN;
    {$EXTERNALSYM EmfRecordTypeCreatePen}
    EmfRecordTypeCreateBrushIndirect     = EMR_CREATEBRUSHINDIRECT;
    {$EXTERNALSYM EmfRecordTypeCreateBrushIndirect}
    EmfRecordTypeDeleteObject            = EMR_DELETEOBJECT;
    {$EXTERNALSYM EmfRecordTypeDeleteObject}
    EmfRecordTypeAngleArc                = EMR_ANGLEARC;
    {$EXTERNALSYM EmfRecordTypeAngleArc}
    EmfRecordTypeEllipse                 = EMR_ELLIPSE;
    {$EXTERNALSYM EmfRecordTypeEllipse}
    EmfRecordTypeRectangle               = EMR_RECTANGLE;
    {$EXTERNALSYM EmfRecordTypeRectangle}
    EmfRecordTypeRoundRect               = EMR_ROUNDRECT;
    {$EXTERNALSYM EmfRecordTypeRoundRect}
    EmfRecordTypeArc                     = EMR_ARC;
    {$EXTERNALSYM EmfRecordTypeArc}
    EmfRecordTypeChord                   = EMR_CHORD;
    {$EXTERNALSYM EmfRecordTypeChord}
    EmfRecordTypePie                     = EMR_PIE;
    {$EXTERNALSYM EmfRecordTypePie}
    EmfRecordTypeSelectPalette           = EMR_SELECTPALETTE;
    {$EXTERNALSYM EmfRecordTypeSelectPalette}
    EmfRecordTypeCreatePalette           = EMR_CREATEPALETTE;
    {$EXTERNALSYM EmfRecordTypeCreatePalette}
    EmfRecordTypeSetPaletteEntries       = EMR_SETPALETTEENTRIES;
    {$EXTERNALSYM EmfRecordTypeSetPaletteEntries}
    EmfRecordTypeResizePalette           = EMR_RESIZEPALETTE;
    {$EXTERNALSYM EmfRecordTypeResizePalette}
    EmfRecordTypeRealizePalette          = EMR_REALIZEPALETTE;
    {$EXTERNALSYM EmfRecordTypeRealizePalette}
    EmfRecordTypeExtFloodFill            = EMR_EXTFLOODFILL;
    {$EXTERNALSYM EmfRecordTypeExtFloodFill}
    EmfRecordTypeLineTo                  = EMR_LINETO;
    {$EXTERNALSYM EmfRecordTypeLineTo}
    EmfRecordTypeArcTo                   = EMR_ARCTO;
    {$EXTERNALSYM EmfRecordTypeArcTo}
    EmfRecordTypePolyDraw                = EMR_POLYDRAW;
    {$EXTERNALSYM EmfRecordTypePolyDraw}
    EmfRecordTypeSetArcDirection         = EMR_SETARCDIRECTION;
    {$EXTERNALSYM EmfRecordTypeSetArcDirection}
    EmfRecordTypeSetMiterLimit           = EMR_SETMITERLIMIT;
    {$EXTERNALSYM EmfRecordTypeSetMiterLimit}
    EmfRecordTypeBeginPath               = EMR_BEGINPATH;
    {$EXTERNALSYM EmfRecordTypeBeginPath}
    EmfRecordTypeEndPath                 = EMR_ENDPATH;
    {$EXTERNALSYM EmfRecordTypeEndPath}
    EmfRecordTypeCloseFigure             = EMR_CLOSEFIGURE;
    {$EXTERNALSYM EmfRecordTypeCloseFigure}
    EmfRecordTypeFillPath                = EMR_FILLPATH;
    {$EXTERNALSYM EmfRecordTypeFillPath}
    EmfRecordTypeStrokeAndFillPath       = EMR_STROKEANDFILLPATH;
    {$EXTERNALSYM EmfRecordTypeStrokeAndFillPath}
    EmfRecordTypeStrokePath              = EMR_STROKEPATH;
    {$EXTERNALSYM EmfRecordTypeStrokePath}
    EmfRecordTypeFlattenPath             = EMR_FLATTENPATH;
    {$EXTERNALSYM EmfRecordTypeFlattenPath}
    EmfRecordTypeWidenPath               = EMR_WIDENPATH;
    {$EXTERNALSYM EmfRecordTypeWidenPath}
    EmfRecordTypeSelectClipPath          = EMR_SELECTCLIPPATH;
    {$EXTERNALSYM EmfRecordTypeSelectClipPath}
    EmfRecordTypeAbortPath               = EMR_ABORTPATH;
    {$EXTERNALSYM EmfRecordTypeAbortPath}
    EmfRecordTypeReserved_069            = 69;  // Not Used
    {$EXTERNALSYM EmfRecordTypeReserved_069}
    EmfRecordTypeGdiComment              = EMR_GDICOMMENT;
    {$EXTERNALSYM EmfRecordTypeGdiComment}
    EmfRecordTypeFillRgn                 = EMR_FILLRGN;
    {$EXTERNALSYM EmfRecordTypeFillRgn}
    EmfRecordTypeFrameRgn                = EMR_FRAMERGN;
    {$EXTERNALSYM EmfRecordTypeFrameRgn}
    EmfRecordTypeInvertRgn               = EMR_INVERTRGN;
    {$EXTERNALSYM EmfRecordTypeInvertRgn}
    EmfRecordTypePaintRgn                = EMR_PAINTRGN;
    {$EXTERNALSYM EmfRecordTypePaintRgn}
    EmfRecordTypeExtSelectClipRgn        = EMR_EXTSELECTCLIPRGN;
    {$EXTERNALSYM EmfRecordTypeExtSelectClipRgn}
    EmfRecordTypeBitBlt                  = EMR_BITBLT;
    {$EXTERNALSYM EmfRecordTypeBitBlt}
    EmfRecordTypeStretchBlt              = EMR_STRETCHBLT;
    {$EXTERNALSYM EmfRecordTypeStretchBlt}
    EmfRecordTypeMaskBlt                 = EMR_MASKBLT;
    {$EXTERNALSYM EmfRecordTypeMaskBlt}
    EmfRecordTypePlgBlt                  = EMR_PLGBLT;
    {$EXTERNALSYM EmfRecordTypePlgBlt}
    EmfRecordTypeSetDIBitsToDevice       = EMR_SETDIBITSTODEVICE;
    {$EXTERNALSYM EmfRecordTypeSetDIBitsToDevice}
    EmfRecordTypeStretchDIBits           = EMR_STRETCHDIBITS;
    {$EXTERNALSYM EmfRecordTypeStretchDIBits}
    EmfRecordTypeExtCreateFontIndirect   = EMR_EXTCREATEFONTINDIRECTW;
    {$EXTERNALSYM EmfRecordTypeExtCreateFontIndirect}
    EmfRecordTypeExtTextOutA             = EMR_EXTTEXTOUTA;
    {$EXTERNALSYM EmfRecordTypeExtTextOutA}
    EmfRecordTypeExtTextOutW             = EMR_EXTTEXTOUTW;
    {$EXTERNALSYM EmfRecordTypeExtTextOutW}
    EmfRecordTypePolyBezier16            = EMR_POLYBEZIER16;
    {$EXTERNALSYM EmfRecordTypePolyBezier16}
    EmfRecordTypePolygon16               = EMR_POLYGON16;
    {$EXTERNALSYM EmfRecordTypePolygon16}
    EmfRecordTypePolyline16              = EMR_POLYLINE16;
    {$EXTERNALSYM EmfRecordTypePolyline16}
    EmfRecordTypePolyBezierTo16          = EMR_POLYBEZIERTO16;
    {$EXTERNALSYM EmfRecordTypePolyBezierTo16}
    EmfRecordTypePolylineTo16            = EMR_POLYLINETO16;
    {$EXTERNALSYM EmfRecordTypePolylineTo16}
    EmfRecordTypePolyPolyline16          = EMR_POLYPOLYLINE16;
    {$EXTERNALSYM EmfRecordTypePolyPolyline16}
    EmfRecordTypePolyPolygon16           = EMR_POLYPOLYGON16;
    {$EXTERNALSYM EmfRecordTypePolyPolygon16}
    EmfRecordTypePolyDraw16              = EMR_POLYDRAW16;
    {$EXTERNALSYM EmfRecordTypePolyDraw16}
    EmfRecordTypeCreateMonoBrush         = EMR_CREATEMONOBRUSH;
    {$EXTERNALSYM EmfRecordTypeCreateMonoBrush}
    EmfRecordTypeCreateDIBPatternBrushPt = EMR_CREATEDIBPATTERNBRUSHPT;
    {$EXTERNALSYM EmfRecordTypeCreateDIBPatternBrushPt}
    EmfRecordTypeExtCreatePen            = EMR_EXTCREATEPEN;
    {$EXTERNALSYM EmfRecordTypeExtCreatePen}
    EmfRecordTypePolyTextOutA            = EMR_POLYTEXTOUTA;
    {$EXTERNALSYM EmfRecordTypePolyTextOutA}
    EmfRecordTypePolyTextOutW            = EMR_POLYTEXTOUTW;
    {$EXTERNALSYM EmfRecordTypePolyTextOutW}
    EmfRecordTypeSetICMMode              = 98;  // EMR_SETICMMODE,
    {$EXTERNALSYM EmfRecordTypeSetICMMode}
    EmfRecordTypeCreateColorSpace        = 99;  // EMR_CREATECOLORSPACE,
    {$EXTERNALSYM EmfRecordTypeCreateColorSpace}
    EmfRecordTypeSetColorSpace           = 100; // EMR_SETCOLORSPACE,
    {$EXTERNALSYM EmfRecordTypeSetColorSpace}
    EmfRecordTypeDeleteColorSpace        = 101; // EMR_DELETECOLORSPACE,
    {$EXTERNALSYM EmfRecordTypeDeleteColorSpace}
    EmfRecordTypeGLSRecord               = 102; // EMR_GLSRECORD,
    {$EXTERNALSYM EmfRecordTypeGLSRecord}
    EmfRecordTypeGLSBoundedRecord        = 103; // EMR_GLSBOUNDEDRECORD,
    {$EXTERNALSYM EmfRecordTypeGLSBoundedRecord}
    EmfRecordTypePixelFormat             = 104; // EMR_PIXELFORMAT,
    {$EXTERNALSYM EmfRecordTypePixelFormat}
    EmfRecordTypeDrawEscape              = 105; // EMR_RESERVED_105,
    {$EXTERNALSYM EmfRecordTypeDrawEscape}
    EmfRecordTypeExtEscape               = 106; // EMR_RESERVED_106,
    {$EXTERNALSYM EmfRecordTypeExtEscape}
    EmfRecordTypeStartDoc                = 107; // EMR_RESERVED_107,
    {$EXTERNALSYM EmfRecordTypeStartDoc}
    EmfRecordTypeSmallTextOut            = 108; // EMR_RESERVED_108,
    {$EXTERNALSYM EmfRecordTypeSmallTextOut}
    EmfRecordTypeForceUFIMapping         = 109; // EMR_RESERVED_109,
    {$EXTERNALSYM EmfRecordTypeForceUFIMapping}
    EmfRecordTypeNamedEscape             = 110; // EMR_RESERVED_110,
    {$EXTERNALSYM EmfRecordTypeNamedEscape}
    EmfRecordTypeColorCorrectPalette     = 111; // EMR_COLORCORRECTPALETTE,
    {$EXTERNALSYM EmfRecordTypeColorCorrectPalette}
    EmfRecordTypeSetICMProfileA          = 112; // EMR_SETICMPROFILEA,
    {$EXTERNALSYM EmfRecordTypeSetICMProfileA}
    EmfRecordTypeSetICMProfileW          = 113; // EMR_SETICMPROFILEW,
    {$EXTERNALSYM EmfRecordTypeSetICMProfileW}
    EmfRecordTypeAlphaBlend              = 114; // EMR_ALPHABLEND,
    {$EXTERNALSYM EmfRecordTypeAlphaBlend}
    EmfRecordTypeSetLayout               = 115; // EMR_SETLAYOUT,
    {$EXTERNALSYM EmfRecordTypeSetLayout}
    EmfRecordTypeTransparentBlt          = 116; // EMR_TRANSPARENTBLT,
    {$EXTERNALSYM EmfRecordTypeTransparentBlt}
    EmfRecordTypeReserved_117            = 117; // Not Used
    {$EXTERNALSYM EmfRecordTypeReserved_117}
    EmfRecordTypeGradientFill            = 118; // EMR_GRADIENTFILL,
    {$EXTERNALSYM EmfRecordTypeGradientFill}
    EmfRecordTypeSetLinkedUFIs           = 119; // EMR_RESERVED_119,
    {$EXTERNALSYM EmfRecordTypeSetLinkedUFIs}
    EmfRecordTypeSetTextJustification    = 120; // EMR_RESERVED_120,
    {$EXTERNALSYM EmfRecordTypeSetTextJustification}
    EmfRecordTypeColorMatchToTargetW     = 121; // EMR_COLORMATCHTOTARGETW,
    {$EXTERNALSYM EmfRecordTypeColorMatchToTargetW}
    EmfRecordTypeCreateColorSpaceW       = 122; // EMR_CREATECOLORSPACEW,
    {$EXTERNALSYM EmfRecordTypeCreateColorSpaceW}
    EmfRecordTypeMax                     = 122;
    {$EXTERNALSYM EmfRecordTypeMax}
    EmfRecordTypeMin                     = 1;
    {$EXTERNALSYM EmfRecordTypeMin}

    // That is the END of the GDI EMF records.

    // Now we start the list of EMF+ records.  We leave quite
    // a bit of room here for the addition of any new GDI
    // records that may be added later.

    EmfPlusRecordTypeInvalid   = GDIP_EMFPLUS_RECORD_BASE;
    {$EXTERNALSYM EmfPlusRecordTypeInvalid}
    EmfPlusRecordTypeHeader    = GDIP_EMFPLUS_RECORD_BASE + 1;
    {$EXTERNALSYM EmfPlusRecordTypeHeader}
    EmfPlusRecordTypeEndOfFile = GDIP_EMFPLUS_RECORD_BASE + 2;
    {$EXTERNALSYM EmfPlusRecordTypeEndOfFile}

    EmfPlusRecordTypeComment   = GDIP_EMFPLUS_RECORD_BASE + 3;
    {$EXTERNALSYM EmfPlusRecordTypeComment}

    EmfPlusRecordTypeGetDC     = GDIP_EMFPLUS_RECORD_BASE + 4;
    {$EXTERNALSYM EmfPlusRecordTypeGetDC}

    EmfPlusRecordTypeMultiFormatStart   = GDIP_EMFPLUS_RECORD_BASE + 5;
    {$EXTERNALSYM EmfPlusRecordTypeMultiFormatStart}
    EmfPlusRecordTypeMultiFormatSection = GDIP_EMFPLUS_RECORD_BASE + 6;
    {$EXTERNALSYM EmfPlusRecordTypeMultiFormatSection}
    EmfPlusRecordTypeMultiFormatEnd     = GDIP_EMFPLUS_RECORD_BASE + 7;
    {$EXTERNALSYM EmfPlusRecordTypeMultiFormatEnd}

    // For all persistent objects

    EmfPlusRecordTypeObject = GDIP_EMFPLUS_RECORD_BASE + 8;
    {$EXTERNALSYM EmfPlusRecordTypeObject}

    // Drawing Records

    EmfPlusRecordTypeClear           = GDIP_EMFPLUS_RECORD_BASE + 9;
    {$EXTERNALSYM EmfPlusRecordTypeClear}
    EmfPlusRecordTypeFillRects       = GDIP_EMFPLUS_RECORD_BASE + 10;
    {$EXTERNALSYM EmfPlusRecordTypeFillRects}
    EmfPlusRecordTypeDrawRects       = GDIP_EMFPLUS_RECORD_BASE + 11;
    {$EXTERNALSYM EmfPlusRecordTypeDrawRects}
    EmfPlusRecordTypeFillPolygon     = GDIP_EMFPLUS_RECORD_BASE + 12;
    {$EXTERNALSYM EmfPlusRecordTypeFillPolygon}
    EmfPlusRecordTypeDrawLines       = GDIP_EMFPLUS_RECORD_BASE + 13;
    {$EXTERNALSYM EmfPlusRecordTypeDrawLines}
    EmfPlusRecordTypeFillEllipse     = GDIP_EMFPLUS_RECORD_BASE + 14;
    {$EXTERNALSYM EmfPlusRecordTypeFillEllipse}
    EmfPlusRecordTypeDrawEllipse     = GDIP_EMFPLUS_RECORD_BASE + 15;
    {$EXTERNALSYM EmfPlusRecordTypeDrawEllipse}
    EmfPlusRecordTypeFillPie         = GDIP_EMFPLUS_RECORD_BASE + 16;
    {$EXTERNALSYM EmfPlusRecordTypeFillPie}
    EmfPlusRecordTypeDrawPie         = GDIP_EMFPLUS_RECORD_BASE + 17;
    {$EXTERNALSYM EmfPlusRecordTypeDrawPie}
    EmfPlusRecordTypeDrawArc         = GDIP_EMFPLUS_RECORD_BASE + 18;
    {$EXTERNALSYM EmfPlusRecordTypeDrawArc}
    EmfPlusRecordTypeFillRegion      = GDIP_EMFPLUS_RECORD_BASE + 19;
    {$EXTERNALSYM EmfPlusRecordTypeFillRegion}
    EmfPlusRecordTypeFillPath        = GDIP_EMFPLUS_RECORD_BASE + 20;
    {$EXTERNALSYM EmfPlusRecordTypeFillPath}
    EmfPlusRecordTypeDrawPath        = GDIP_EMFPLUS_RECORD_BASE + 21;
    {$EXTERNALSYM EmfPlusRecordTypeDrawPath}
    EmfPlusRecordTypeFillClosedCurve = GDIP_EMFPLUS_RECORD_BASE + 22;
    {$EXTERNALSYM EmfPlusRecordTypeFillClosedCurve}
    EmfPlusRecordTypeDrawClosedCurve = GDIP_EMFPLUS_RECORD_BASE + 23;
    {$EXTERNALSYM EmfPlusRecordTypeDrawClosedCurve}
    EmfPlusRecordTypeDrawCurve       = GDIP_EMFPLUS_RECORD_BASE + 24;
    {$EXTERNALSYM EmfPlusRecordTypeDrawCurve}
    EmfPlusRecordTypeDrawBeziers     = GDIP_EMFPLUS_RECORD_BASE + 25;
    {$EXTERNALSYM EmfPlusRecordTypeDrawBeziers}
    EmfPlusRecordTypeDrawImage       = GDIP_EMFPLUS_RECORD_BASE + 26;
    {$EXTERNALSYM EmfPlusRecordTypeDrawImage}
    EmfPlusRecordTypeDrawImagePoints = GDIP_EMFPLUS_RECORD_BASE + 27;
    {$EXTERNALSYM EmfPlusRecordTypeDrawImagePoints}
    EmfPlusRecordTypeDrawString      = GDIP_EMFPLUS_RECORD_BASE + 28;
    {$EXTERNALSYM EmfPlusRecordTypeDrawString}

    // Graphics State Records

    EmfPlusRecordTypeSetRenderingOrigin      = GDIP_EMFPLUS_RECORD_BASE + 29;
    {$EXTERNALSYM EmfPlusRecordTypeSetRenderingOrigin}
    EmfPlusRecordTypeSetAntiAliasMode        = GDIP_EMFPLUS_RECORD_BASE + 30;
    {$EXTERNALSYM EmfPlusRecordTypeSetAntiAliasMode}
    EmfPlusRecordTypeSetTextRenderingHint    = GDIP_EMFPLUS_RECORD_BASE + 31;
    {$EXTERNALSYM EmfPlusRecordTypeSetTextRenderingHint}
    EmfPlusRecordTypeSetTextContrast         = GDIP_EMFPLUS_RECORD_BASE + 32;
    {$EXTERNALSYM EmfPlusRecordTypeSetTextContrast}
    EmfPlusRecordTypeSetInterpolationMode    = GDIP_EMFPLUS_RECORD_BASE + 33;
    {$EXTERNALSYM EmfPlusRecordTypeSetInterpolationMode}
    EmfPlusRecordTypeSetPixelOffsetMode      = GDIP_EMFPLUS_RECORD_BASE + 34;
    {$EXTERNALSYM EmfPlusRecordTypeSetPixelOffsetMode}
    EmfPlusRecordTypeSetCompositingMode      = GDIP_EMFPLUS_RECORD_BASE + 35;
    {$EXTERNALSYM EmfPlusRecordTypeSetCompositingMode}
    EmfPlusRecordTypeSetCompositingQuality   = GDIP_EMFPLUS_RECORD_BASE + 36;
    {$EXTERNALSYM EmfPlusRecordTypeSetCompositingQuality}
    EmfPlusRecordTypeSave                    = GDIP_EMFPLUS_RECORD_BASE + 37;
    {$EXTERNALSYM EmfPlusRecordTypeSave}
    EmfPlusRecordTypeRestore                 = GDIP_EMFPLUS_RECORD_BASE + 38;
    {$EXTERNALSYM EmfPlusRecordTypeRestore}
    EmfPlusRecordTypeBeginContainer          = GDIP_EMFPLUS_RECORD_BASE + 39;
    {$EXTERNALSYM EmfPlusRecordTypeBeginContainer}
    EmfPlusRecordTypeBeginContainerNoParams  = GDIP_EMFPLUS_RECORD_BASE + 40;
    {$EXTERNALSYM EmfPlusRecordTypeBeginContainerNoParams}
    EmfPlusRecordTypeEndContainer            = GDIP_EMFPLUS_RECORD_BASE + 41;
    {$EXTERNALSYM EmfPlusRecordTypeEndContainer}
    EmfPlusRecordTypeSetWorldTransform       = GDIP_EMFPLUS_RECORD_BASE + 42;
    {$EXTERNALSYM EmfPlusRecordTypeSetWorldTransform}
    EmfPlusRecordTypeResetWorldTransform     = GDIP_EMFPLUS_RECORD_BASE + 43;
    {$EXTERNALSYM EmfPlusRecordTypeResetWorldTransform}
    EmfPlusRecordTypeMultiplyWorldTransform  = GDIP_EMFPLUS_RECORD_BASE + 44;
    {$EXTERNALSYM EmfPlusRecordTypeMultiplyWorldTransform}
    EmfPlusRecordTypeTranslateWorldTransform = GDIP_EMFPLUS_RECORD_BASE + 45;
    {$EXTERNALSYM EmfPlusRecordTypeTranslateWorldTransform}
    EmfPlusRecordTypeScaleWorldTransform     = GDIP_EMFPLUS_RECORD_BASE + 46;
    {$EXTERNALSYM EmfPlusRecordTypeScaleWorldTransform}
    EmfPlusRecordTypeRotateWorldTransform    = GDIP_EMFPLUS_RECORD_BASE + 47;
    {$EXTERNALSYM EmfPlusRecordTypeRotateWorldTransform}
    EmfPlusRecordTypeSetPageTransform        = GDIP_EMFPLUS_RECORD_BASE + 48;
    {$EXTERNALSYM EmfPlusRecordTypeSetPageTransform}
    EmfPlusRecordTypeResetClip               = GDIP_EMFPLUS_RECORD_BASE + 49;
    {$EXTERNALSYM EmfPlusRecordTypeResetClip}
    EmfPlusRecordTypeSetClipRect             = GDIP_EMFPLUS_RECORD_BASE + 50;
    {$EXTERNALSYM EmfPlusRecordTypeSetClipRect}
    EmfPlusRecordTypeSetClipPath             = GDIP_EMFPLUS_RECORD_BASE + 51;
    {$EXTERNALSYM EmfPlusRecordTypeSetClipPath}
    EmfPlusRecordTypeSetClipRegion           = GDIP_EMFPLUS_RECORD_BASE + 52;
    {$EXTERNALSYM EmfPlusRecordTypeSetClipRegion}
    EmfPlusRecordTypeOffsetClip              = GDIP_EMFPLUS_RECORD_BASE + 53;
    {$EXTERNALSYM EmfPlusRecordTypeOffsetClip}

    EmfPlusRecordTypeDrawDriverString        = GDIP_EMFPLUS_RECORD_BASE + 54;
    {$EXTERNALSYM EmfPlusRecordTypeDrawDriverString}

    EmfPlusRecordTotal                       = GDIP_EMFPLUS_RECORD_BASE + 55;
    {$EXTERNALSYM EmfPlusRecordTotal}

    EmfPlusRecordTypeMax = EmfPlusRecordTotal-1;
    {$EXTERNALSYM EmfPlusRecordTypeMax}
    EmfPlusRecordTypeMin = EmfPlusRecordTypeHeader;
    {$EXTERNALSYM EmfPlusRecordTypeMin}

type
  TEmfPlusRecordType = EmfPlusRecordType;
  {$EXTERNALSYM TEmfPlusRecordType}
{$ENDIF}
//---------------------------------------------------------------------------
// StringFormatFlags
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// String format flags
//
//  DirectionRightToLeft          - For horizontal text, the reading order is
//                                  right to left. This value is called
//                                  the base embedding level by the Unicode
//                                  bidirectional engine.
//                                  For vertical text, columns are read from
//                                  right to left.
//                                  By default, horizontal or vertical text is
//                                  read from left to right.
//
//  DirectionVertical             - Individual lines of text are vertical. In
//                                  each line, characters progress from top to
//                                  bottom.
//                                  By default, lines of text are horizontal,
//                                  each new line below the previous line.
//
//  NoFitBlackBox                 - Allows parts of glyphs to overhang the
//                                  bounding rectangle.
//                                  By default glyphs are first aligned
//                                  inside the margines, then any glyphs which
//                                  still overhang the bounding box are
//                                  repositioned to avoid any overhang.
//                                  For example when an italic
//                                  lower case letter f in a font such as
//                                  Garamond is aligned at the far left of a
//                                  rectangle, the lower part of the f will
//                                  reach slightly further left than the left
//                                  edge of the rectangle. Setting this flag
//                                  will ensure the character aligns visually
//                                  with the lines above and below, but may
//                                  cause some pixels outside the formatting
//                                  rectangle to be clipped or painted.
//
//  DisplayFormatControl          - Causes control characters such as the
//                                  left-to-right mark to be shown in the
//                                  output with a representative glyph.
//
//  NoFontFallback                - Disables fallback to alternate fonts for
//                                  characters not supported in the requested
//                                  font. Any missing characters will be
//                                  be displayed with the fonts missing glyph,
//                                  usually an open square.
//
//  NoWrap                        - Disables wrapping of text between lines
//                                  when formatting within a rectangle.
//                                  NoWrap is implied when a point is passed
//                                  instead of a rectangle, or when the
//                                  specified rectangle has a zero line length.
//
//  NoClip                        - By default text is clipped to the
//                                  formatting rectangle. Setting NoClip
//                                  allows overhanging pixels to affect the
//                                  device outside the formatting rectangle.
//                                  Pixels at the end of the line may be
//                                  affected if the glyphs overhang their
//                                  cells, and either the NoFitBlackBox flag
//                                  has been set, or the glyph extends to far
//                                  to be fitted.
//                                  Pixels above/before the first line or
//                                  below/after the last line may be affected
//                                  if the glyphs extend beyond their cell
//                                  ascent / descent. This can occur rarely
//                                  with unusual diacritic mark combinations.

//---------------------------------------------------------------------------

  {$EXTERNALSYM StringFormatFlags}
  StringFormatFlags = Integer;
  const
    StringFormatFlagsDirectionRightToLeft        = $00000001;
    {$EXTERNALSYM StringFormatFlagsDirectionRightToLeft}
    StringFormatFlagsDirectionVertical           = $00000002;
    {$EXTERNALSYM StringFormatFlagsDirectionVertical}
    StringFormatFlagsNoFitBlackBox               = $00000004;
    {$EXTERNALSYM StringFormatFlagsNoFitBlackBox}
    StringFormatFlagsDisplayFormatControl        = $00000020;
    {$EXTERNALSYM StringFormatFlagsDisplayFormatControl}
    StringFormatFlagsNoFontFallback              = $00000400;
    {$EXTERNALSYM StringFormatFlagsNoFontFallback}
    StringFormatFlagsMeasureTrailingSpaces       = $00000800;
    {$EXTERNALSYM StringFormatFlagsMeasureTrailingSpaces}
    StringFormatFlagsNoWrap                      = $00001000;
    {$EXTERNALSYM StringFormatFlagsNoWrap}
    StringFormatFlagsLineLimit                   = $00002000;
    {$EXTERNALSYM StringFormatFlagsLineLimit}

    StringFormatFlagsNoClip                      = $00004000;
    {$EXTERNALSYM StringFormatFlagsNoClip}

Type
  TStringFormatFlags = StringFormatFlags;
  {$EXTERNALSYM TStringFormatFlags}

//---------------------------------------------------------------------------
// StringTrimming
//---------------------------------------------------------------------------

  {$EXTERNALSYM StringTrimming}
  StringTrimming = (
    StringTrimmingNone,
    StringTrimmingCharacter,
    StringTrimmingWord,
    StringTrimmingEllipsisCharacter,
    StringTrimmingEllipsisWord,
    StringTrimmingEllipsisPath
  );
  TStringTrimming = StringTrimming;
  {$EXTERNALSYM TStringTrimming}

//---------------------------------------------------------------------------
// National language digit substitution
//---------------------------------------------------------------------------

  {$EXTERNALSYM StringDigitSubstitute}
  StringDigitSubstitute = (
    StringDigitSubstituteUser,          // As NLS setting
    StringDigitSubstituteNone,
    StringDigitSubstituteNational,
    StringDigitSubstituteTraditional
  );
  TStringDigitSubstitute = StringDigitSubstitute;
  {$EXTERNALSYM TStringDigitSubstitute}
  PStringDigitSubstitute = ^TStringDigitSubstitute;
  {$EXTERNALSYM PStringDigitSubstitute}

//---------------------------------------------------------------------------
// Hotkey prefix interpretation
//---------------------------------------------------------------------------

  {$EXTERNALSYM HotkeyPrefix}
  HotkeyPrefix = (
    HotkeyPrefixNone,
    HotkeyPrefixShow,
    HotkeyPrefixHide
  );
  THotkeyPrefix = HotkeyPrefix;
  {$EXTERNALSYM THotkeyPrefix}

//---------------------------------------------------------------------------
// String alignment flags
//---------------------------------------------------------------------------

  {$EXTERNALSYM StringAlignment}
  StringAlignment = (
    // Left edge for left-to-right text,
    // right for right-to-left text,
    // and top for vertical
    StringAlignmentNear,
    StringAlignmentCenter,
    StringAlignmentFar
  );
  TStringAlignment = StringAlignment;
  {$EXTERNALSYM TStringAlignment}

//---------------------------------------------------------------------------
// DriverStringOptions
//---------------------------------------------------------------------------

  {$EXTERNALSYM DriverStringOptions}
  DriverStringOptions = Integer;
  const
    DriverStringOptionsCmapLookup             = 1;
    {$EXTERNALSYM DriverStringOptionsCmapLookup}
    DriverStringOptionsVertical               = 2;
    {$EXTERNALSYM DriverStringOptionsVertical}
    DriverStringOptionsRealizedAdvance        = 4;
    {$EXTERNALSYM DriverStringOptionsRealizedAdvance}
    DriverStringOptionsLimitSubpixel          = 8;
    {$EXTERNALSYM DriverStringOptionsLimitSubpixel}

type
  TDriverStringOptions = DriverStringOptions;
  {$EXTERNALSYM TDriverStringOptions}

//---------------------------------------------------------------------------
// Flush Intention flags
//---------------------------------------------------------------------------

  {$EXTERNALSYM FlushIntention}
  FlushIntention = (
    FlushIntentionFlush,  // Flush all batched rendering operations
    FlushIntentionSync    // Flush all batched rendering operations
                          // and wait for them to complete
  );
  TFlushIntention = FlushIntention;
  {$EXTERNALSYM TFlushIntention}

//---------------------------------------------------------------------------
// Image encoder parameter related types
//---------------------------------------------------------------------------

  {$EXTERNALSYM EncoderParameterValueType}
  EncoderParameterValueType = Integer;
  const
    EncoderParameterValueTypeByte          : Integer = 1;    // 8-bit unsigned int
    {$EXTERNALSYM EncoderParameterValueTypeByte}
    EncoderParameterValueTypeASCII         : Integer = 2;    // 8-bit byte containing one 7-bit ASCII
    {$EXTERNALSYM EncoderParameterValueTypeASCII}
                                                             // code. NULL terminated.
    EncoderParameterValueTypeShort         : Integer = 3;    // 16-bit unsigned int
    {$EXTERNALSYM EncoderParameterValueTypeShort}
    EncoderParameterValueTypeLong          : Integer = 4;    // 32-bit unsigned int
    {$EXTERNALSYM EncoderParameterValueTypeLong}
    EncoderParameterValueTypeRational      : Integer = 5;    // Two Longs. The first Long is the
    {$EXTERNALSYM EncoderParameterValueTypeRational}
                                                             // numerator, the second Long expresses the
                                                             // denomintor.
    EncoderParameterValueTypeLongRange     : Integer = 6;    // Two longs which specify a range of
    {$EXTERNALSYM EncoderParameterValueTypeLongRange}
                                                             // integer values. The first Long specifies
                                                             // the lower end and the second one
                                                             // specifies the higher end. All values
                                                             // are inclusive at both ends
    EncoderParameterValueTypeUndefined     : Integer = 7;    // 8-bit byte that can take any value
    {$EXTERNALSYM EncoderParameterValueTypeUndefined}
                                                             // depending on field definition
    EncoderParameterValueTypeRationalRange : Integer = 8;    // Two Rationals. The first Rational
    {$EXTERNALSYM EncoderParameterValueTypeRationalRange}
                                                             // specifies the lower end and the second
                                                             // specifies the higher end. All values
                                                             // are inclusive at both ends
type
  TEncoderParameterValueType = EncoderParameterValueType;
  {$EXTERNALSYM TEncoderParameterValueType}

//---------------------------------------------------------------------------
// Image encoder value types
//---------------------------------------------------------------------------

  {$EXTERNALSYM EncoderValue}
  EncoderValue = (
    EncoderValueColorTypeCMYK,
    EncoderValueColorTypeYCCK,
    EncoderValueCompressionLZW,
    EncoderValueCompressionCCITT3,
    EncoderValueCompressionCCITT4,
    EncoderValueCompressionRle,
    EncoderValueCompressionNone,
    EncoderValueScanMethodInterlaced,
    EncoderValueScanMethodNonInterlaced,
    EncoderValueVersionGif87,
    EncoderValueVersionGif89,
    EncoderValueRenderProgressive,
    EncoderValueRenderNonProgressive,
    EncoderValueTransformRotate90,
    EncoderValueTransformRotate180,
    EncoderValueTransformRotate270,
    EncoderValueTransformFlipHorizontal,
    EncoderValueTransformFlipVertical,
    EncoderValueMultiFrame,
    EncoderValueLastFrame,
    EncoderValueFlush,
    EncoderValueFrameDimensionTime,
    EncoderValueFrameDimensionResolution,
    EncoderValueFrameDimensionPage
  );
  TEncoderValue = EncoderValue;
  {$EXTERNALSYM TEncoderValue}

//---------------------------------------------------------------------------
// Conversion of Emf To WMF Bits flags
//---------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM EmfToWmfBitsFlags}
  EmfToWmfBitsFlags = (
    EmfToWmfBitsFlagsDefault          = $00000000,
    EmfToWmfBitsFlagsEmbedEmf         = $00000001,
    EmfToWmfBitsFlagsIncludePlaceable = $00000002,
    EmfToWmfBitsFlagsNoXORClip        = $00000004
  );
  TEmfToWmfBitsFlags = EmfToWmfBitsFlags;
  {$EXTERNALSYM TEmfToWmfBitsFlags}
{$ELSE}
  {$EXTERNALSYM EmfToWmfBitsFlags}
  EmfToWmfBitsFlags = Integer;
  const
    EmfToWmfBitsFlagsDefault          = $00000000;
    EmfToWmfBitsFlagsEmbedEmf         = $00000001;
    EmfToWmfBitsFlagsIncludePlaceable = $00000002;
    EmfToWmfBitsFlagsNoXORClip        = $00000004;
    
type
  TEmfToWmfBitsFlags = EmfToWmfBitsFlags;
  {$EXTERNALSYM TEmfToWmfBitsFlags}
{$ENDIF}
(**************************************************************************\
*
*   GDI+ Types
*
\**************************************************************************)

//--------------------------------------------------------------------------
// Callback functions
//--------------------------------------------------------------------------

  {$EXTERNALSYM ImageAbort}
  ImageAbort = function: BOOL; stdcall;
  {$EXTERNALSYM DrawImageAbort}
  DrawImageAbort         = ImageAbort;
  {$EXTERNALSYM GetThumbnailImageAbort}
  GetThumbnailImageAbort = ImageAbort;


  // Callback for EnumerateMetafile methods.  The parameters are:

  //      recordType      WMF, EMF, or EMF+ record type
  //      flags           (always 0 for WMF/EMF records)
  //      dataSize        size of the record data (in bytes), or 0 if no data
  //      data            pointer to the record data, or NULL if no data
  //      callbackData    pointer to callbackData, if any

  // This method can then call Metafile::PlayRecord to play the
  // record that was just enumerated.  If this method  returns
  // FALSE, the enumeration process is aborted.  Otherwise, it continues.

  {$EXTERNALSYM EnumerateMetafileProc}
  EnumerateMetafileProc = function(recordType: EmfPlusRecordType; flags: UINT;
    dataSize: UINT; data: PBYTE; callbackData: pointer): BOOL; stdcall;

//--------------------------------------------------------------------------
// Primitive data types
//
// NOTE:
//  Types already defined in standard header files:
//      INT8
//      UINT8
//      INT16
//      UINT16
//      INT32
//      UINT32
//      INT64
//      UINT64
//
//  Avoid using the following types:
//      LONG - use INT
//      ULONG - use UINT
//      DWORD - use UINT32
//--------------------------------------------------------------------------

const
  { from float.h }
  FLT_MAX =  3.402823466e+38; // max value
  {$EXTERNALSYM FLT_MAX}
  FLT_MIN =  1.175494351e-38; // min positive value
  {$EXTERNALSYM FLT_MIN}

  REAL_MAX           = FLT_MAX;
  {$EXTERNALSYM REAL_MAX}
  REAL_MIN           = FLT_MIN;
  {$EXTERNALSYM REAL_MIN}
  REAL_TOLERANCE     = (FLT_MIN * 100);
  {$EXTERNALSYM REAL_TOLERANCE}
  REAL_EPSILON       = 1.192092896e-07;        // FLT_EPSILON
  {$EXTERNALSYM REAL_EPSILON}

//--------------------------------------------------------------------------
// Status return values from GDI+ methods
//--------------------------------------------------------------------------
type
  {$EXTERNALSYM Status}
  Status = (
    Ok,
    GenericError,
    InvalidParameter,
    OutOfMemory,
    ObjectBusy,
    InsufficientBuffer,
    NotImplemented,
    Win32Error,
    WrongState,
    Aborted,
    FileNotFound,
    ValueOverflow,
    AccessDenied,
    UnknownImageFormat,
    FontFamilyNotFound,
    FontStyleNotFound,
    NotTrueTypeFont,
    UnsupportedGdiplusVersion,
    GdiplusNotInitialized,
    PropertyNotFound,
    PropertyNotSupported
  );
  TStatus = Status;
  {$EXTERNALSYM TStatus}

//--------------------------------------------------------------------------
// Represents a dimension in a 2D coordinate system (floating-point coordinates)
//--------------------------------------------------------------------------

type
  PGPSizeF = ^TGPSizeF;
  {$EXTERNALSYM PGPSizeF}
  TGPSizeF = record
    Width  : Single;
    Height : Single;
  end;
  {$EXTERNALSYM TGPSizeF}

  function MakeSize(Width, Height: Single): TGPSizeF; overload;
  {$EXTERNALSYM MakeSize}

//--------------------------------------------------------------------------
// Represents a dimension in a 2D coordinate system (integer coordinates)
//--------------------------------------------------------------------------

type
  PGPSize = ^TGPSize;
  {$EXTERNALSYM PGPSize}
  TGPSize = record
    Width  : Integer;
    Height : Integer;
  end;
  {$EXTERNALSYM TGPSize}

  function MakeSize(Width, Height: Integer): TGPSize; overload;
  {$EXTERNALSYM MakeSize}

//--------------------------------------------------------------------------
// Represents a location in a 2D coordinate system (floating-point coordinates)
//--------------------------------------------------------------------------

type
  PGPPointF = ^TGPPointF;
  {$EXTERNALSYM PGPPointF}
  TGPPointF = record
    X : Single;
    Y : Single;
  end;
  {$EXTERNALSYM TGPPointF}
  TPointFDynArray = array of TGPPointF;
  {$EXTERNALSYM TPointFDynArray}

  function MakePoint(X, Y: Single): TGPPointF; overload;
  {$EXTERNALSYM MakePoint}

//--------------------------------------------------------------------------
// Represents a location in a 2D coordinate system (integer coordinates)
//--------------------------------------------------------------------------

type
  PGPPoint = ^TGPPoint;
  {$EXTERNALSYM PGPPoint}
  TGPPoint = record
    X : Integer;
    Y : Integer;
  end;
  {$EXTERNALSYM TGPPoint}
  TPointDynArray = array of TGPPoint;
  {$EXTERNALSYM TPointDynArray}

  function MakePoint(X, Y: Integer): TGPPoint; overload;
  {$EXTERNALSYM MakePoint}

//--------------------------------------------------------------------------
// Represents a rectangle in a 2D coordinate system (floating-point coordinates)
//--------------------------------------------------------------------------

type
  PGPRectF = ^TGPRectF;
  {$EXTERNALSYM PGPRectF}
  TGPRectF = record
    X     : Single;
    Y     : Single;
    Width : Single;
    Height: Single;
  end;
  {$EXTERNALSYM TGPRectF}
  TRectFDynArray = array of TGPRectF;
  {$EXTERNALSYM TRectFDynArray}

  function MakeRect(x, y, width, height: Single): TGPRectF; overload;
  {$EXTERNALSYM MakeRect}
  function MakeRect(location: TGPPointF; size: TGPSizeF): TGPRectF; overload;
  {$EXTERNALSYM MakeRect}

type
  PGPRect = ^TGPRect;
  {$EXTERNALSYM PGPRect}
  TGPRect = record
    X     : Integer;
    Y     : Integer;
    Width : Integer;
    Height: Integer;
  end;
  {$EXTERNALSYM TGPRect}
  TRectDynArray = array of TGPRect;
  {$EXTERNALSYM TRectDynArray}

  function MakeRect(x, y, width, height: Integer): TGPRect; overload;
  {$EXTERNALSYM MakeRect}
  function MakeRect(location: TGPPoint; size: TGPSize): TGPRect; overload;
  {$EXTERNALSYM MakeRect}
  function MakeRect(const Rect: TRect): TGPRect; overload;
  {$EXTERNALSYM MakeRect}

type
  TPathData = class
  public
    Count  : Integer;
    Points : PGPPointF;
    Types  : PBYTE;
    constructor Create;
    destructor Destroy; override;
  end;
  {$EXTERNALSYM TPathData}

  PCharacterRange = ^TCharacterRange;
  {$EXTERNALSYM PCharacterRange}
  TCharacterRange = record
    First  : Integer;
    Length : Integer;
  end;
  {$EXTERNALSYM TCharacterRange}

  function MakeCharacterRange(First, Length: Integer): TCharacterRange;
  {$EXTERNALSYM MakeCharacterRange}

(**************************************************************************
*
*   GDI+ Startup and Shutdown APIs
*
**************************************************************************)
type
  {$EXTERNALSYM DebugEventLevel}
  DebugEventLevel = (
    DebugEventLevelFatal,
    DebugEventLevelWarning
  );
  TDebugEventLevel = DebugEventLevel;
  {$EXTERNALSYM TDebugEventLevel}

  // Callback function that GDI+ can call, on debug builds, for assertions
  // and warnings.

  {$EXTERNALSYM DebugEventProc}
  DebugEventProc = procedure(level: DebugEventLevel; message: PChar); stdcall;

  // Notification functions which the user must call appropriately if
  // "SuppressBackgroundThread" (below) is set.

  {$EXTERNALSYM NotificationHookProc}
  NotificationHookProc = function(out token: ULONG): Status; stdcall;
  {$EXTERNALSYM NotificationUnhookProc}
  NotificationUnhookProc = procedure(token: ULONG); stdcall;

  // Input structure for GdiplusStartup

{$ALIGN 1}
  {$EXTERNALSYM GdiplusStartupInput}
  GdiplusStartupInput = record
    GdiplusVersion          : Cardinal;       // Must be 1
    DebugEventCallback      : DebugEventProc; // Ignored on free builds
    SuppressBackgroundThread: BOOL;           // FALSE unless you're prepared to call
                                              // the hook/unhook functions properly
    SuppressExternalCodecs  : BOOL;           // FALSE unless you want GDI+ only to use
  end;                                        // its internal image codecs.
  TGdiplusStartupInput = GdiplusStartupInput;
  {$EXTERNALSYM TGdiplusStartupInput}
  PGdiplusStartupInput = ^TGdiplusStartupInput;
  {$EXTERNALSYM PGdiplusStartupInput}
{$ALIGN ON}

  // Output structure for GdiplusStartup()

  {$EXTERNALSYM GdiplusStartupOutput}
  GdiplusStartupOutput = record
    // The following 2 fields are NULL if SuppressBackgroundThread is FALSE.
    // Otherwise, they are functions which must be called appropriately to
    // replace the background thread.
    //
    // These should be called on the application's main message loop - i.e.
    // a message loop which is active for the lifetime of GDI+.
    // "NotificationHook" should be called before starting the loop,
    // and "NotificationUnhook" should be called after the loop ends.

    NotificationHook  : NotificationHookProc;
    NotificationUnhook: NotificationUnhookProc;
  end;
  TGdiplusStartupOutput = GdiplusStartupOutput;
  {$EXTERNALSYM TGdiplusStartupOutput}
  PGdiplusStartupOutput = ^TGdiplusStartupOutput;
  {$EXTERNALSYM PGdiplusStartupOutput}

  // GDI+ initialization. Must not be called from DllMain - can cause deadlock.
  //
  // Must be called before GDI+ API's or constructors are used.
  //
  // token  - may not be NULL - accepts a token to be passed in the corresponding
  //          GdiplusShutdown call.
  // input  - may not be NULL
  // output - may be NULL only if input->SuppressBackgroundThread is FALSE.

  {$EXTERNALSYM GdiplusStartup}
 function GdiplusStartup(out token: ULONG; input: PGdiplusStartupInput;
   output: PGdiplusStartupOutput): Status; stdcall;

  // GDI+ termination. Must be called before GDI+ is unloaded.
  // Must not be called from DllMain - can cause deadlock.
  //
  // GDI+ API's may not be called after GdiplusShutdown. Pay careful attention
  // to GDI+ object destructors.

  {$EXTERNALSYM GdiplusShutdown}
  procedure GdiplusShutdown(token: ULONG); stdcall;


(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
* Module Name:
*   Gdiplus Pixel Formats
* Abstract:
*   GDI+ Pixel Formats
*
\**************************************************************************)

type
  PARGB  = ^ARGB;
  {$EXTERNALSYM PARGB}
  ARGB   = DWORD;
  {$EXTERNALSYM ARGB}
  ARGB64 = Int64;
  {$EXTERNALSYM ARGB64}

const
  ALPHA_SHIFT = 24;
  {$EXTERNALSYM ALPHA_SHIFT}
  RED_SHIFT   = 16;
  {$EXTERNALSYM RED_SHIFT}
  GREEN_SHIFT = 8;
  {$EXTERNALSYM GREEN_SHIFT}
  BLUE_SHIFT  = 0;
  {$EXTERNALSYM BLUE_SHIFT}
  ALPHA_MASK  = (ARGB($ff) shl ALPHA_SHIFT);
  {$EXTERNALSYM ALPHA_MASK}

  // In-memory pixel data formats:
  // bits 0-7 = format index
  // bits 8-15 = pixel size (in bits)
  // bits 16-23 = flags
  // bits 24-31 = reserved

type
  PixelFormat = Integer;
  {$EXTERNALSYM PixelFormat}
  TPixelFormat = PixelFormat;
  {$EXTERNALSYM TPixelFormat}

const
  PixelFormatIndexed     = $00010000; // Indexes into a palette
  {$EXTERNALSYM PixelFormatIndexed}
  PixelFormatGDI         = $00020000; // Is a GDI-supported format
  {$EXTERNALSYM PixelFormatGDI}
  PixelFormatAlpha       = $00040000; // Has an alpha component
  {$EXTERNALSYM PixelFormatAlpha}
  PixelFormatPAlpha      = $00080000; // Pre-multiplied alpha
  {$EXTERNALSYM PixelFormatPAlpha}
  PixelFormatExtended    = $00100000; // Extended color 16 bits/channel
  {$EXTERNALSYM PixelFormatExtended}
  PixelFormatCanonical   = $00200000;
  {$EXTERNALSYM PixelFormatCanonical}

  PixelFormatUndefined      = 0;
  {$EXTERNALSYM PixelFormatUndefined}
  PixelFormatDontCare       = 0;
  {$EXTERNALSYM PixelFormatDontCare}

  PixelFormat1bppIndexed    = (1  or ( 1 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat1bppIndexed}
  PixelFormat4bppIndexed    = (2  or ( 4 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat4bppIndexed}
  PixelFormat8bppIndexed    = (3  or ( 8 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat8bppIndexed}
  PixelFormat16bppGrayScale = (4  or (16 shl 8) or PixelFormatExtended);
  {$EXTERNALSYM PixelFormat16bppGrayScale}
  PixelFormat16bppRGB555    = (5  or (16 shl 8) or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat16bppRGB555}
  PixelFormat16bppRGB565    = (6  or (16 shl 8) or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat16bppRGB565}
  PixelFormat16bppARGB1555  = (7  or (16 shl 8) or PixelFormatAlpha or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat16bppARGB1555}
  PixelFormat24bppRGB       = (8  or (24 shl 8) or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat24bppRGB}
  PixelFormat32bppRGB       = (9  or (32 shl 8) or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat32bppRGB}
  PixelFormat32bppARGB      = (10 or (32 shl 8) or PixelFormatAlpha or PixelFormatGDI or PixelFormatCanonical);
  {$EXTERNALSYM PixelFormat32bppARGB}
  PixelFormat32bppPARGB     = (11 or (32 shl 8) or PixelFormatAlpha or PixelFormatPAlpha or PixelFormatGDI);
  {$EXTERNALSYM PixelFormat32bppPARGB}
  PixelFormat48bppRGB       = (12 or (48 shl 8) or PixelFormatExtended);
  {$EXTERNALSYM PixelFormat48bppRGB}
  PixelFormat64bppARGB      = (13 or (64 shl 8) or PixelFormatAlpha  or PixelFormatCanonical or PixelFormatExtended);
  {$EXTERNALSYM PixelFormat64bppARGB}
  PixelFormat64bppPARGB     = (14 or (64 shl 8) or PixelFormatAlpha  or PixelFormatPAlpha or PixelFormatExtended);
  {$EXTERNALSYM PixelFormat64bppPARGB}
  PixelFormatMax            = 15;
  {$EXTERNALSYM PixelFormatMax}

{$EXTERNALSYM GetPixelFormatSize}
function GetPixelFormatSize(pixfmt: PixelFormat): UINT;
{$EXTERNALSYM IsIndexedPixelFormat}
function IsIndexedPixelFormat(pixfmt: PixelFormat): BOOL;
{$EXTERNALSYM IsAlphaPixelFormat}
function IsAlphaPixelFormat(pixfmt: PixelFormat): BOOL;
{$EXTERNALSYM IsExtendedPixelFormat}
function IsExtendedPixelFormat(pixfmt: PixelFormat): BOOL;

//--------------------------------------------------------------------------
// Determine if the Pixel Format is Canonical format:
//   PixelFormat32bppARGB
//   PixelFormat32bppPARGB
//   PixelFormat64bppARGB
//   PixelFormat64bppPARGB
//--------------------------------------------------------------------------

{$EXTERNALSYM IsCanonicalPixelFormat}
function IsCanonicalPixelFormat(pixfmt: PixelFormat): BOOL;

{$IFDEF DELPHI6_UP}
type
  {$EXTERNALSYM PaletteFlags}
  PaletteFlags = (
    PaletteFlagsHasAlpha    = $0001,
    PaletteFlagsGrayScale   = $0002,
    PaletteFlagsHalftone    = $0004
  );
  TPaletteFlags = PaletteFlags;
  {$EXTERNALSYM TPaletteFlags}
{$ELSE}
type
  {$EXTERNALSYM PaletteFlags}
  PaletteFlags = Integer;
  const
    PaletteFlagsHasAlpha    = $0001;
    PaletteFlagsGrayScale   = $0002;
    PaletteFlagsHalftone    = $0004;

type
  TPaletteFlags = PaletteFlags;
{$ENDIF}

  {$EXTERNALSYM ColorPalette}
  ColorPalette = record
    Flags  : UINT ;                 // Palette flags
    Count  : UINT ;                 // Number of color entries
    Entries: array [0..0] of ARGB ; // Palette color entries
  end;

  TColorPalette = ColorPalette;
  {$EXTERNALSYM TColorPalette}
  PColorPalette = ^TColorPalette;
  {$EXTERNALSYM PColorPalette}

(**************************************************************************\
*
*   GDI+ Color Object
*
\**************************************************************************)

//----------------------------------------------------------------------------
// Color mode
//----------------------------------------------------------------------------

  {$EXTERNALSYM ColorMode}
  ColorMode = (
    ColorModeARGB32,
    ColorModeARGB64
  );
  TColorMode = ColorMode;
  {$EXTERNALSYM TColorMode}

//----------------------------------------------------------------------------
// Color Channel flags 
//----------------------------------------------------------------------------

  {$EXTERNALSYM ColorChannelFlags}
  ColorChannelFlags = (
    ColorChannelFlagsC,
    ColorChannelFlagsM,
    ColorChannelFlagsY,
    ColorChannelFlagsK,
    ColorChannelFlagsLast
  );
  TColorChannelFlags = ColorChannelFlags;
  {$EXTERNALSYM TColorChannelFlags}

//----------------------------------------------------------------------------
// Color
//----------------------------------------------------------------------------

  // Common color constants
const
  aclAliceBlue            = $FFF0F8FF;
  {$EXTERNALSYM aclAliceBlue}
  aclAntiqueWhite         = $FFFAEBD7;
  {$EXTERNALSYM aclAntiqueWhite}
  aclAqua                 = $FF00FFFF;
  {$EXTERNALSYM aclAqua}
  aclAquamarine           = $FF7FFFD4;
  {$EXTERNALSYM aclAquamarine}
  aclAzure                = $FFF0FFFF;
  {$EXTERNALSYM aclAzure}
  aclBeige                = $FFF5F5DC;
  {$EXTERNALSYM aclBeige}
  aclBisque               = $FFFFE4C4;
  {$EXTERNALSYM aclBisque}
  aclBlack                = $FF000000;
  {$EXTERNALSYM aclBlack}
  aclBlanchedAlmond       = $FFFFEBCD;
  {$EXTERNALSYM aclBlanchedAlmond}
  aclBlue                 = $FF0000FF;
  {$EXTERNALSYM aclBlue}
  aclBlueViolet           = $FF8A2BE2;
  {$EXTERNALSYM aclBlueViolet}
  aclBrown                = $FFA52A2A;
  {$EXTERNALSYM aclBrown}
  aclBurlyWood            = $FFDEB887;
  {$EXTERNALSYM aclBurlyWood}
  aclCadetBlue            = $FF5F9EA0;
  {$EXTERNALSYM aclCadetBlue}
  aclChartreuse           = $FF7FFF00;
  {$EXTERNALSYM aclChartreuse}
  aclChocolate            = $FFD2691E;
  {$EXTERNALSYM aclChocolate}
  aclCoral                = $FFFF7F50;
  {$EXTERNALSYM aclCoral}
  aclCornflowerBlue       = $FF6495ED;
  {$EXTERNALSYM aclCornflowerBlue}
  aclCornsilk             = $FFFFF8DC;
  {$EXTERNALSYM aclCornsilk}
  aclCrimson              = $FFDC143C;
  {$EXTERNALSYM aclCrimson}
  aclCyan                 = $FF00FFFF;
  {$EXTERNALSYM aclCyan}
  aclDarkBlue             = $FF00008B;
  {$EXTERNALSYM aclDarkBlue}
  aclDarkCyan             = $FF008B8B;
  {$EXTERNALSYM aclDarkCyan}
  aclDarkGoldenrod        = $FFB8860B;
  {$EXTERNALSYM aclDarkGoldenrod}
  aclDarkGray             = $FFA9A9A9;
  {$EXTERNALSYM aclDarkGray}
  aclDarkGreen            = $FF006400;
  {$EXTERNALSYM aclDarkGreen}
  aclDarkKhaki            = $FFBDB76B;
  {$EXTERNALSYM aclDarkKhaki}
  aclDarkMagenta          = $FF8B008B;
  {$EXTERNALSYM aclDarkMagenta}
  aclDarkOliveGreen       = $FF556B2F;
  {$EXTERNALSYM aclDarkOliveGreen}
  aclDarkOrange           = $FFFF8C00;
  {$EXTERNALSYM aclDarkOrange}
  aclDarkOrchid           = $FF9932CC;
  {$EXTERNALSYM aclDarkOrchid}
  aclDarkRed              = $FF8B0000;
  {$EXTERNALSYM aclDarkRed}
  aclDarkSalmon           = $FFE9967A;
  {$EXTERNALSYM aclDarkSalmon}
  aclDarkSeaGreen         = $FF8FBC8B;
  {$EXTERNALSYM aclDarkSeaGreen}
  aclDarkSlateBlue        = $FF483D8B;
  {$EXTERNALSYM aclDarkSlateBlue}
  aclDarkSlateGray        = $FF2F4F4F;
  {$EXTERNALSYM aclDarkSlateGray}
  aclDarkTurquoise        = $FF00CED1;
  {$EXTERNALSYM aclDarkTurquoise}
  aclDarkViolet           = $FF9400D3;
  {$EXTERNALSYM aclDarkViolet}
  aclDeepPink             = $FFFF1493;
  {$EXTERNALSYM aclDeepPink}
  aclDeepSkyBlue          = $FF00BFFF;
  {$EXTERNALSYM aclDeepSkyBlue}
  aclDimGray              = $FF696969;
  {$EXTERNALSYM aclDimGray}
  aclDodgerBlue           = $FF1E90FF;
  {$EXTERNALSYM aclDodgerBlue}
  aclFirebrick            = $FFB22222;
  {$EXTERNALSYM aclFirebrick}
  aclFloralWhite          = $FFFFFAF0;
  {$EXTERNALSYM aclFloralWhite}
  aclForestGreen          = $FF228B22;
  {$EXTERNALSYM aclForestGreen}
  aclFuchsia              = $FFFF00FF;
  {$EXTERNALSYM aclFuchsia}
  aclGainsboro            = $FFDCDCDC;
  {$EXTERNALSYM aclGainsboro}
  aclGhostWhite           = $FFF8F8FF;
  {$EXTERNALSYM aclGhostWhite}
  aclGold                 = $FFFFD700;
  {$EXTERNALSYM aclGold}
  aclGoldenrod            = $FFDAA520;
  {$EXTERNALSYM aclGoldenrod}
  aclGray                 = $FF808080;
  {$EXTERNALSYM aclGray}
  aclGreen                = $FF008000;
  {$EXTERNALSYM aclGreen}
  aclGreenYellow          = $FFADFF2F;
  {$EXTERNALSYM aclGreenYellow}
  aclHoneydew             = $FFF0FFF0;
  {$EXTERNALSYM aclHoneydew}
  aclHotPink              = $FFFF69B4;
  {$EXTERNALSYM aclHotPink}
  aclIndianRed            = $FFCD5C5C;
  {$EXTERNALSYM aclIndianRed}
  aclIndigo               = $FF4B0082;
  {$EXTERNALSYM aclIndigo}
  aclIvory                = $FFFFFFF0;
  {$EXTERNALSYM aclIvory}
  aclKhaki                = $FFF0E68C;
  {$EXTERNALSYM aclKhaki}
  aclLavender             = $FFE6E6FA;
  {$EXTERNALSYM aclLavender}
  aclLavenderBlush        = $FFFFF0F5;
  {$EXTERNALSYM aclLavenderBlush}
  aclLawnGreen            = $FF7CFC00;
  {$EXTERNALSYM aclLawnGreen}
  aclLemonChiffon         = $FFFFFACD;
  {$EXTERNALSYM aclLemonChiffon}
  aclLightBlue            = $FFADD8E6;
  {$EXTERNALSYM aclLightBlue}
  aclLightCoral           = $FFF08080;
  {$EXTERNALSYM aclLightCoral}
  aclLightCyan            = $FFE0FFFF;
  {$EXTERNALSYM aclLightCyan}
  aclLightGoldenrodYellow = $FFFAFAD2;
  {$EXTERNALSYM aclLightGoldenrodYellow}
  aclLightGray            = $FFD3D3D3;
  {$EXTERNALSYM aclLightGray}
  aclLightGreen           = $FF90EE90;
  {$EXTERNALSYM aclLightGreen}
  aclLightPink            = $FFFFB6C1;
  {$EXTERNALSYM aclLightPink}
  aclLightSalmon          = $FFFFA07A;
  {$EXTERNALSYM aclLightSalmon}
  aclLightSeaGreen        = $FF20B2AA;
  {$EXTERNALSYM aclLightSeaGreen}
  aclLightSkyBlue         = $FF87CEFA;
  {$EXTERNALSYM aclLightSkyBlue}
  aclLightSlateGray       = $FF778899;
  {$EXTERNALSYM aclLightSlateGray}
  aclLightSteelBlue       = $FFB0C4DE;
  {$EXTERNALSYM aclLightSteelBlue}
  aclLightYellow          = $FFFFFFE0;
  {$EXTERNALSYM aclLightYellow}
  aclLime                 = $FF00FF00;
  {$EXTERNALSYM aclLime}
  aclLimeGreen            = $FF32CD32;
  {$EXTERNALSYM aclLimeGreen}
  aclLinen                = $FFFAF0E6;
  {$EXTERNALSYM aclLinen}
  aclMagenta              = $FFFF00FF;
  {$EXTERNALSYM aclMagenta}
  aclMaroon               = $FF800000;
  {$EXTERNALSYM aclMaroon}
  aclMediumAquamarine     = $FF66CDAA;
  {$EXTERNALSYM aclMediumAquamarine}
  aclMediumBlue           = $FF0000CD;
  {$EXTERNALSYM aclMediumBlue}
  aclMediumOrchid         = $FFBA55D3;
  {$EXTERNALSYM aclMediumOrchid}
  aclMediumPurple         = $FF9370DB;
  {$EXTERNALSYM aclMediumPurple}
  aclMediumSeaGreen       = $FF3CB371;
  {$EXTERNALSYM aclMediumSeaGreen}
  aclMediumSlateBlue      = $FF7B68EE;
  {$EXTERNALSYM aclMediumSlateBlue}
  aclMediumSpringGreen    = $FF00FA9A;
  {$EXTERNALSYM aclMediumSpringGreen}
  aclMediumTurquoise      = $FF48D1CC;
  {$EXTERNALSYM aclMediumTurquoise}
  aclMediumVioletRed      = $FFC71585;
  {$EXTERNALSYM aclMediumVioletRed}
  aclMidnightBlue         = $FF191970;
  {$EXTERNALSYM aclMidnightBlue}
  aclMintCream            = $FFF5FFFA;
  {$EXTERNALSYM aclMintCream}
  aclMistyRose            = $FFFFE4E1;
  {$EXTERNALSYM aclMistyRose}
  aclMoccasin             = $FFFFE4B5;
  {$EXTERNALSYM aclMoccasin}
  aclNavajoWhite          = $FFFFDEAD;
  {$EXTERNALSYM aclNavajoWhite}
  aclNavy                 = $FF000080;
  {$EXTERNALSYM aclNavy}
  aclOldLace              = $FFFDF5E6;
  {$EXTERNALSYM aclOldLace}
  aclOlive                = $FF808000;
  {$EXTERNALSYM aclOlive}
  aclOliveDrab            = $FF6B8E23;
  {$EXTERNALSYM aclOliveDrab}
  aclOrange               = $FFFFA500;
  {$EXTERNALSYM aclOrange}
  aclOrangeRed            = $FFFF4500;
  {$EXTERNALSYM aclOrangeRed}
  aclOrchid               = $FFDA70D6;
  {$EXTERNALSYM aclOrchid}
  aclPaleGoldenrod        = $FFEEE8AA;
  {$EXTERNALSYM aclPaleGoldenrod}
  aclPaleGreen            = $FF98FB98;
  {$EXTERNALSYM aclPaleGreen}
  aclPaleTurquoise        = $FFAFEEEE;
  {$EXTERNALSYM aclPaleTurquoise}
  aclPaleVioletRed        = $FFDB7093;
  {$EXTERNALSYM aclPaleVioletRed}
  aclPapayaWhip           = $FFFFEFD5;
  {$EXTERNALSYM aclPapayaWhip}
  aclPeachPuff            = $FFFFDAB9;
  {$EXTERNALSYM aclPeachPuff}
  aclPeru                 = $FFCD853F;
  {$EXTERNALSYM aclPeru}
  aclPink                 = $FFFFC0CB;
  {$EXTERNALSYM aclPink}
  aclPlum                 = $FFDDA0DD;
  {$EXTERNALSYM aclPlum}
  aclPowderBlue           = $FFB0E0E6;
  {$EXTERNALSYM aclPowderBlue}
  aclPurple               = $FF800080;
  {$EXTERNALSYM aclPurple}
  aclRed                  = $FFFF0000;
  {$EXTERNALSYM aclRed}
  aclRosyBrown            = $FFBC8F8F;
  {$EXTERNALSYM aclRosyBrown}
  aclRoyalBlue            = $FF4169E1;
  {$EXTERNALSYM aclRoyalBlue}
  aclSaddleBrown          = $FF8B4513;
  {$EXTERNALSYM aclSaddleBrown}
  aclSalmon               = $FFFA8072;
  {$EXTERNALSYM aclSalmon}
  aclSandyBrown           = $FFF4A460;
  {$EXTERNALSYM aclSandyBrown}
  aclSeaGreen             = $FF2E8B57;
  {$EXTERNALSYM aclSeaGreen}
  aclSeaShell             = $FFFFF5EE;
  {$EXTERNALSYM aclSeaShell}
  aclSienna               = $FFA0522D;
  {$EXTERNALSYM aclSienna}
  aclSilver               = $FFC0C0C0;
  {$EXTERNALSYM aclSilver}
  aclSkyBlue              = $FF87CEEB;
  {$EXTERNALSYM aclSkyBlue}
  aclSlateBlue            = $FF6A5ACD;
  {$EXTERNALSYM aclSlateBlue}
  aclSlateGray            = $FF708090;
  {$EXTERNALSYM aclSlateGray}
  aclSnow                 = $FFFFFAFA;
  {$EXTERNALSYM aclSnow}
  aclSpringGreen          = $FF00FF7F;
  {$EXTERNALSYM aclSpringGreen}
  aclSteelBlue            = $FF4682B4;
  {$EXTERNALSYM aclSteelBlue}
  aclTan                  = $FFD2B48C;
  {$EXTERNALSYM aclTan}
  aclTeal                 = $FF008080;
  {$EXTERNALSYM aclTeal}
  aclThistle              = $FFD8BFD8;
  {$EXTERNALSYM aclThistle}
  aclTomato               = $FFFF6347;
  {$EXTERNALSYM aclTomato}
  aclTransparent          = $00FFFFFF;
  {$EXTERNALSYM aclTransparent}
  aclTurquoise            = $FF40E0D0;
  {$EXTERNALSYM aclTurquoise}
  aclViolet               = $FFEE82EE;
  {$EXTERNALSYM aclViolet}
  aclWheat                = $FFF5DEB3;
  {$EXTERNALSYM aclWheat}
  aclWhite                = $FFFFFFFF;
  {$EXTERNALSYM aclWhite}
  aclWhiteSmoke           = $FFF5F5F5;
  {$EXTERNALSYM aclWhiteSmoke}
  aclYellow               = $FFFFFF00;
  {$EXTERNALSYM aclYellow}
  aclYellowGreen          = $FF9ACD32;
  {$EXTERNALSYM aclYellowGreen}

  // Shift count and bit mask for A, R, G, B components
  AlphaShift  = 24;
  {$EXTERNALSYM AlphaShift}
  RedShift    = 16;
  {$EXTERNALSYM RedShift}
  GreenShift  = 8;
  {$EXTERNALSYM GreenShift}
  BlueShift   = 0;
  {$EXTERNALSYM BlueShift}

  AlphaMask   = $ff000000;
  {$EXTERNALSYM AlphaMask}
  RedMask     = $00ff0000;
  {$EXTERNALSYM RedMask}
  GreenMask   = $0000ff00;
  {$EXTERNALSYM GreenMask}
  BlueMask    = $000000ff;
  {$EXTERNALSYM BlueMask}


type
{  TGPColor = class
  protected
     Argb: ARGB;
  public
    constructor Create; overload;
    constructor Create(r, g, b: Byte); overload;
    constructor Create(a, r, g, b: Byte); overload;
    constructor Create(Value: ARGB); overload;
    function GetAlpha: BYTE;
    function GetA: BYTE;
    function GetRed: BYTE;
    function GetR: BYTE;
    function GetGreen: Byte;
    function GetG: Byte;
    function GetBlue: Byte;
    function GetB: Byte;
    function GetValue: ARGB;
    procedure SetValue(Value: ARGB);
    procedure SetFromCOLORREF(rgb: COLORREF);
    function ToCOLORREF: COLORREF;
    function MakeARGB(a, r, g, b: Byte): ARGB;
  end;  }

  PGPColor = ^TGPColor;
  {$EXTERNALSYM PGPColor}
  TGPColor = ARGB;
  {$EXTERNALSYM TGPColor}
  TColorDynArray = array of TGPColor;
  {$EXTERNALSYM TColorDynArray}

function MakeColor(r, g, b: Byte): ARGB; overload; inline;
{$EXTERNALSYM MakeColor}
function MakeColor(a, r, g, b: Byte): ARGB; overload; inline;
{$EXTERNALSYM MakeColor}
function GetAlpha(color: ARGB): BYTE; inline;
{$EXTERNALSYM GetAlpha}
function GetRed(color: ARGB): BYTE; inline;
{$EXTERNALSYM GetRed}
function GetGreen(color: ARGB): BYTE; inline;
{$EXTERNALSYM GetGreen}
function GetBlue(color: ARGB): BYTE; inline;
{$EXTERNALSYM GetBlue}
function ColorRefToARGB(rgb: COLORREF): ARGB; inline;
{$EXTERNALSYM ColorRefToARGB}
function ARGBToColorRef(Color: ARGB): COLORREF; inline;
{$EXTERNALSYM ARGBToColorRef}


(**************************************************************************\
*
*   GDI+ Metafile Related Structures
*
\**************************************************************************)

type
  { from Windef.h }
  RECTL = Winapi.Windows.TRect;
  {$EXTERNALSYM RECTL}
  SIZEL = Winapi.Windows.TSize;
  {$EXTERNALSYM SIZEL}

  {$EXTERNALSYM ENHMETAHEADER3}
  ENHMETAHEADER3 = record
    iType          : DWORD;  // Record type EMR_HEADER
    nSize          : DWORD;  // Record size in bytes.  This may be greater
                             // than the sizeof(ENHMETAHEADER).
    rclBounds      : RECTL;  // Inclusive-inclusive bounds in device units
    rclFrame       : RECTL;  // Inclusive-inclusive Picture Frame .01mm unit
    dSignature     : DWORD;  // Signature.  Must be ENHMETA_SIGNATURE.
    nVersion       : DWORD;  // Version number
    nBytes         : DWORD;  // Size of the metafile in bytes
    nRecords       : DWORD;  // Number of records in the metafile
    nHandles       : WORD;   // Number of handles in the handle table
                             // Handle index zero is reserved.
    sReserved      : WORD;   // Reserved.  Must be zero.
    nDescription   : DWORD;  // Number of chars in the unicode desc string
                             // This is 0 if there is no description string
    offDescription : DWORD;  // Offset to the metafile description record.
                             // This is 0 if there is no description string
    nPalEntries    : DWORD;  // Number of entries in the metafile palette.
    szlDevice      : SIZEL;  // Size of the reference device in pels
    szlMillimeters : SIZEL;  // Size of the reference device in millimeters
  end;
  TENHMETAHEADER3 = ENHMETAHEADER3;
  {$EXTERNALSYM TENHMETAHEADER3}
  PENHMETAHEADER3 = ^TENHMETAHEADER3;
  {$EXTERNALSYM PENHMETAHEADER3}

  // Placeable WMFs

  // Placeable Metafiles were created as a non-standard way of specifying how
  // a metafile is mapped and scaled on an output device.
  // Placeable metafiles are quite wide-spread, but not directly supported by
  // the Windows API. To playback a placeable metafile using the Windows API,
  // you will first need to strip the placeable metafile header from the file.
  // This is typically performed by copying the metafile to a temporary file
  // starting at file offset 22 (0x16). The contents of the temporary file may
  // then be used as input to the Windows GetMetaFile(), PlayMetaFile(),
  // CopyMetaFile(), etc. GDI functions.

  // Each placeable metafile begins with a 22-byte header,
  //  followed by a standard metafile:

  {$EXTERNALSYM PWMFRect16}
  PWMFRect16 = record
    Left   : INT16;
    Top    : INT16;
    Right  : INT16;
    Bottom : INT16;
  end;
  TPWMFRect16 = PWMFRect16;
  {$EXTERNALSYM TPWMFRect16}
  PPWMFRect16 = ^TPWMFRect16;
  {$EXTERNALSYM PPWMFRect16}

  {$EXTERNALSYM WmfPlaceableFileHeader}
  WmfPlaceableFileHeader = record
    Key         : UINT32;      // GDIP_WMF_PLACEABLEKEY
    Hmf         : INT16;       // Metafile HANDLE number (always 0)
    BoundingBox : PWMFRect16;  // Coordinates in metafile units
    Inch        : INT16;       // Number of metafile units per inch
    Reserved    : UINT32;      // Reserved (always 0)
    Checksum    : INT16;       // Checksum value for previous 10 WORDs
  end;
  TWmfPlaceableFileHeader = WmfPlaceableFileHeader;
  {$EXTERNALSYM TWmfPlaceableFileHeader}
  PWmfPlaceableFileHeader = ^TWmfPlaceableFileHeader;
  {$EXTERNALSYM PWmfPlaceableFileHeader}

  // Key contains a special identification value that indicates the presence
  // of a placeable metafile header and is always 0x9AC6CDD7.

  // Handle is used to stored the handle of the metafile in memory. When written
  // to disk, this field is not used and will always contains the value 0.

  // Left, Top, Right, and Bottom contain the coordinates of the upper-left
  // and lower-right corners of the image on the output device. These are
  // measured in twips.

  // A twip (meaning "twentieth of a point") is the logical unit of measurement
  // used in Windows Metafiles. A twip is equal to 1/1440 of an inch. Thus 720
  // twips equal 1/2 inch, while 32,768 twips is 22.75 inches.

  // Inch contains the number of twips per inch used to represent the image.
  // Normally, there are 1440 twips per inch; however, this number may be
  // changed to scale the image. A value of 720 indicates that the image is
  // double its normal size, or scaled to a factor of 2:1. A value of 360
  // indicates a scale of 4:1, while a value of 2880 indicates that the image
  // is scaled down in size by a factor of two. A value of 1440 indicates
  // a 1:1 scale ratio.

  // Reserved is not used and is always set to 0.

  // Checksum contains a checksum value for the previous 10 WORDs in the header.
  // This value can be used in an attempt to detect if the metafile has become
  // corrupted. The checksum is calculated by XORing each WORD value to an
  // initial value of 0.

  // If the metafile was recorded with a reference Hdc that was a display.

const
  GDIP_EMFPLUSFLAGS_DISPLAY      = $00000001;
  {$EXTERNALSYM GDIP_EMFPLUSFLAGS_DISPLAY}

type
  TMetafileHeader = class
  public
    Type_        : TMetafileType;
    Size         : UINT;           // Size of the metafile (in bytes)
    Version      : UINT;           // EMF+, EMF, or WMF version
    EmfPlusFlags : UINT;
    DpiX         : Single;
    DpiY         : Single;
    X            : Integer;        // Bounds in device units
    Y            : Integer;
    Width        : Integer;
    Height       : Integer;
    Header       : record
    case integer of
      0: (WmfHeader: TMETAHEADER;);
      1: (EmfHeader: TENHMETAHEADER3);
    end;
    EmfPlusHeaderSize : Integer; // size of the EMF+ header in file
    LogicalDpiX       : Integer; // Logical Dpi of reference Hdc
    LogicalDpiY       : Integer; // usually valid only for EMF+
  public
    property GetType: TMetafileType read Type_;
    property GetMetafileSize: UINT read Size;
    // If IsEmfPlus, this is the EMF+ version; else it is the WMF or EMF ver
    property GetVersion: UINT read Version;
     // Get the EMF+ flags associated with the metafile
    property GetEmfPlusFlags: UINT read EmfPlusFlags;
    property GetDpiX: Single read DpiX;
    property GetDpiY: Single read DpiY;
    procedure GetBounds(out Rect: TGPRect);
    // Is it any type of WMF (standard or Placeable Metafile)?
    function IsWmf: BOOL;
    // Is this an Placeable Metafile?
    function IsWmfPlaceable: BOOL;
    // Is this an EMF (not an EMF+)?
    function IsEmf: BOOL;
    // Is this an EMF or EMF+ file?
    function IsEmfOrEmfPlus: BOOL;
    // Is this an EMF+ file?
    function IsEmfPlus: BOOL;
    // Is this an EMF+ dual (has dual, down-level records) file?
    function IsEmfPlusDual: BOOL;
    // Is this an EMF+ only (no dual records) file?
    function IsEmfPlusOnly: BOOL;
    // If it's an EMF+ file, was it recorded against a display Hdc?
    function IsDisplay: BOOL;
    // Get the WMF header of the metafile (if it is a WMF)
    function GetWmfHeader: PMetaHeader;
    // Get the EMF header of the metafile (if it is an EMF)
    function GetEmfHeader: PENHMETAHEADER3;
  end;
  {$EXTERNALSYM TMetafileHeader}

(**************************************************************************\
*
*   GDI+ Imaging GUIDs
*
\**************************************************************************)

//---------------------------------------------------------------------------
// Image file format identifiers
//---------------------------------------------------------------------------

const
  ImageFormatUndefined : TGUID = '{b96b3ca9-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatUndefined}
  ImageFormatMemoryBMP : TGUID = '{b96b3caa-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatMemoryBMP}
  ImageFormatBMP       : TGUID = '{b96b3cab-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatBMP}
  ImageFormatEMF       : TGUID = '{b96b3cac-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatEMF}
  ImageFormatWMF       : TGUID = '{b96b3cad-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatWMF}
  ImageFormatJPEG      : TGUID = '{b96b3cae-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatJPEG}
  ImageFormatPNG       : TGUID = '{b96b3caf-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatPNG}
  ImageFormatGIF       : TGUID = '{b96b3cb0-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatGIF}
  ImageFormatTIFF      : TGUID = '{b96b3cb1-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatTIFF}
  ImageFormatEXIF      : TGUID = '{b96b3cb2-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatEXIF}
  ImageFormatIcon      : TGUID = '{b96b3cb5-0728-11d3-9d7b-0000f81ef32e}';
  {$EXTERNALSYM ImageFormatIcon}

//---------------------------------------------------------------------------
// Predefined multi-frame dimension IDs
//---------------------------------------------------------------------------

  FrameDimensionTime       : TGUID = '{6aedbd6d-3fb5-418a-83a6-7f45229dc872}';
  {$EXTERNALSYM FrameDimensionTime}
  FrameDimensionResolution : TGUID = '{84236f7b-3bd3-428f-8dab-4ea1439ca315}';
  {$EXTERNALSYM FrameDimensionResolution}
  FrameDimensionPage       : TGUID = '{7462dc86-6180-4c7e-8e3f-ee7333a7a483}';
  {$EXTERNALSYM FrameDimensionPage}

//---------------------------------------------------------------------------
// Property sets
//---------------------------------------------------------------------------

  FormatIDImageInformation : TGUID = '{e5836cbe-5eef-4f1d-acde-ae4c43b608ce}';
  {$EXTERNALSYM FormatIDImageInformation}
  FormatIDJpegAppHeaders   : TGUID = '{1c4afdcd-6177-43cf-abc7-5f51af39ee85}';
  {$EXTERNALSYM FormatIDJpegAppHeaders}

//---------------------------------------------------------------------------
// Encoder parameter sets
//---------------------------------------------------------------------------

  EncoderCompression      : TGUID = '{e09d739d-ccd4-44ee-8eba-3fbf8be4fc58}';
  {$EXTERNALSYM EncoderCompression}
  EncoderColorDepth       : TGUID = '{66087055-ad66-4c7c-9a18-38a2310b8337}';
  {$EXTERNALSYM EncoderColorDepth}
  EncoderScanMethod       : TGUID = '{3a4e2661-3109-4e56-8536-42c156e7dcfa}';
  {$EXTERNALSYM EncoderScanMethod}
  EncoderVersion          : TGUID = '{24d18c76-814a-41a4-bf53-1c219cccf797}';
  {$EXTERNALSYM EncoderVersion}
  EncoderRenderMethod     : TGUID = '{6d42c53a-229a-4825-8bb7-5c99e2b9a8b8}';
  {$EXTERNALSYM EncoderRenderMethod}
  EncoderQuality          : TGUID = '{1d5be4b5-fa4a-452d-9cdd-5db35105e7eb}';
  {$EXTERNALSYM EncoderQuality}
  EncoderTransformation   : TGUID = '{8d0eb2d1-a58e-4ea8-aa14-108074b7b6f9}';
  {$EXTERNALSYM EncoderTransformation}
  EncoderLuminanceTable   : TGUID = '{edb33bce-0266-4a77-b904-27216099e717}';
  {$EXTERNALSYM EncoderLuminanceTable}
  EncoderChrominanceTable : TGUID = '{f2e455dc-09b3-4316-8260-676ada32481c}';
  {$EXTERNALSYM EncoderChrominanceTable}
  EncoderSaveFlag         : TGUID = '{292266fc-ac40-47bf-8cfc-a85b89a655de}';
  {$EXTERNALSYM EncoderSaveFlag}

  CodecIImageBytes : TGUID = '{025d1823-6c7d-447b-bbdb-a3cbc3dfa2fc}';
  {$EXTERNALSYM CodecIImageBytes}

type
  {$EXTERNALSYM IImageBytes}
  IImageBytes = Interface(IUnknown)
    ['{025D1823-6C7D-447B-BBDB-A3CBC3DFA2FC}']
    // Return total number of bytes in the IStream
    function CountBytes(out pcb: UINT): HRESULT; stdcall;
    // Locks "cb" bytes, starting from "ulOffset" in the stream, and returns the
    // pointer to the beginning of the locked memory chunk in "ppvBytes"
    function LockBytes(cb: UINT; ulOffset: ULONG; out ppvBytes: pointer): HRESULT; stdcall;
    // Unlocks "cb" bytes, pointed by "pvBytes", starting from "ulOffset" in the
    // stream
    function UnlockBytes(pvBytes: pointer; cb: UINT; ulOffset: ULONG): HRESULT; stdcall;
  end;

//--------------------------------------------------------------------------
// ImageCodecInfo structure
//--------------------------------------------------------------------------

  {$EXTERNALSYM ImageCodecInfo}
  ImageCodecInfo = record
    Clsid             : TGUID;
    FormatID          : TGUID;
    CodecName         : PWCHAR;
    DllName           : PWCHAR;
    FormatDescription : PWCHAR;
    FilenameExtension : PWCHAR;
    MimeType          : PWCHAR;
    Flags             : DWORD;
    Version           : DWORD;
    SigCount          : DWORD;
    SigSize           : DWORD;
    SigPattern        : PBYTE;
    SigMask           : PBYTE;
  end;
  TImageCodecInfo = ImageCodecInfo;
  {$EXTERNALSYM TImageCodecInfo}
  PImageCodecInfo = ^TImageCodecInfo;
  {$EXTERNALSYM PImageCodecInfo}

//--------------------------------------------------------------------------
// Information flags about image codecs
//--------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM ImageCodecFlags}
  ImageCodecFlags = (
    ImageCodecFlagsEncoder            = $00000001,
    ImageCodecFlagsDecoder            = $00000002,
    ImageCodecFlagsSupportBitmap      = $00000004,
    ImageCodecFlagsSupportVector      = $00000008,
    ImageCodecFlagsSeekableEncode     = $00000010,
    ImageCodecFlagsBlockingDecode     = $00000020,

    ImageCodecFlagsBuiltin            = $00010000,
    ImageCodecFlagsSystem             = $00020000,
    ImageCodecFlagsUser               = $00040000
  );
  TImageCodecFlags = ImageCodecFlags;
  {$EXTERNALSYM TImageCodecFlags}
{$ELSE}
  {$EXTERNALSYM ImageCodecFlags}
  ImageCodecFlags = Integer;
  const
    ImageCodecFlagsEncoder            = $00000001;
    ImageCodecFlagsDecoder            = $00000002;
    ImageCodecFlagsSupportBitmap      = $00000004;
    ImageCodecFlagsSupportVector      = $00000008;
    ImageCodecFlagsSeekableEncode     = $00000010;
    ImageCodecFlagsBlockingDecode     = $00000020;

    ImageCodecFlagsBuiltin            = $00010000;
    ImageCodecFlagsSystem             = $00020000;
    ImageCodecFlagsUser               = $00040000;

type
  TImageCodecFlags = ImageCodecFlags;
{$ENDIF}
//---------------------------------------------------------------------------
// Access modes used when calling Image::LockBits
//---------------------------------------------------------------------------

  {$EXTERNALSYM ImageLockMode}
  ImageLockMode = Integer;
  const
    ImageLockModeRead         = $0001;
    {$EXTERNALSYM ImageLockModeRead}
    ImageLockModeWrite        = $0002;
    {$EXTERNALSYM ImageLockModeWrite}
    ImageLockModeUserInputBuf = $0004;
    {$EXTERNALSYM ImageLockModeUserInputBuf}
type
  TImageLockMode = ImageLockMode;
  {$EXTERNALSYM TImageLockMode}

//---------------------------------------------------------------------------
// Information about image pixel data
//---------------------------------------------------------------------------

{$ALIGN 1}
  {$EXTERNALSYM BitmapData}
  BitmapData = record
    Width       : UINT;
    Height      : UINT;
    Stride      : Integer;
    PixelFormat : PixelFormat;
    Scan0       : Pointer;
    Reserved    : UINT;
  end;
  TBitmapData = BitmapData;
  {$EXTERNALSYM TBitmapData}
  PBitmapData = ^TBitmapData;
  {$EXTERNALSYM PBitmapData}
{$ALIGN ON}

//---------------------------------------------------------------------------
// Image flags
//---------------------------------------------------------------------------
{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM ImageFlags}
  ImageFlags = (
    ImageFlagsNone                = 0,

    // Low-word: shared with SINKFLAG_x

    ImageFlagsScalable            = $0001,
    ImageFlagsHasAlpha            = $0002,
    ImageFlagsHasTranslucent      = $0004,
    ImageFlagsPartiallyScalable   = $0008,

    // Low-word: color space definition

    ImageFlagsColorSpaceRGB       = $0010,
    ImageFlagsColorSpaceCMYK      = $0020,
    ImageFlagsColorSpaceGRAY      = $0040,
    ImageFlagsColorSpaceYCBCR     = $0080,
    ImageFlagsColorSpaceYCCK      = $0100,

    // Low-word: image size info

    ImageFlagsHasRealDPI          = $1000,
    ImageFlagsHasRealPixelSize    = $2000,

    // High-word

    ImageFlagsReadOnly            = $00010000,
    ImageFlagsCaching             = $00020000
  );
  TImageFlags = ImageFlags;
  {$EXTERNALSYM TImageFlags}
{$ELSE}
  {$EXTERNALSYM ImageFlags}
  ImageFlags = Integer;
  const
    ImageFlagsNone                = 0;

    // Low-word: shared with SINKFLAG_x

    ImageFlagsScalable            = $0001;
    ImageFlagsHasAlpha            = $0002;
    ImageFlagsHasTranslucent      = $0004;
    ImageFlagsPartiallyScalable   = $0008;

    // Low-word: color space definition

    ImageFlagsColorSpaceRGB       = $0010;
    ImageFlagsColorSpaceCMYK      = $0020;
    ImageFlagsColorSpaceGRAY      = $0040;
    ImageFlagsColorSpaceYCBCR     = $0080;
    ImageFlagsColorSpaceYCCK      = $0100;

    // Low-word: image size info

    ImageFlagsHasRealDPI          = $1000;
    ImageFlagsHasRealPixelSize    = $2000;

    // High-word

    ImageFlagsReadOnly            = $00010000;
    ImageFlagsCaching             = $00020000;

type
  TImageFlags = ImageFlags;
{$ENDIF}


{$IFDEF DELPHI6_UP}
  {$EXTERNALSYM RotateFlipType}
  RotateFlipType = (
    RotateNoneFlipNone = 0,
    Rotate90FlipNone   = 1,
    Rotate180FlipNone  = 2,
    Rotate270FlipNone  = 3,

    RotateNoneFlipX    = 4,
    Rotate90FlipX      = 5,
    Rotate180FlipX     = 6,
    Rotate270FlipX     = 7,

    RotateNoneFlipY    = Rotate180FlipX,
    Rotate90FlipY      = Rotate270FlipX,
    Rotate180FlipY     = RotateNoneFlipX,
    Rotate270FlipY     = Rotate90FlipX,

    RotateNoneFlipXY   = Rotate180FlipNone,
    Rotate90FlipXY     = Rotate270FlipNone,
    Rotate180FlipXY    = RotateNoneFlipNone,
    Rotate270FlipXY    = Rotate90FlipNone
  );
  TRotateFlipType = RotateFlipType;
  {$EXTERNALSYM TRotateFlipType}
{$ELSE}
  {$EXTERNALSYM RotateFlipType}
  RotateFlipType = (
    RotateNoneFlipNone, // = 0,
    Rotate90FlipNone,   // = 1,
    Rotate180FlipNone,  // = 2,
    Rotate270FlipNone,  // = 3,

    RotateNoneFlipX,    // = 4,
    Rotate90FlipX,      // = 5,
    Rotate180FlipX,     // = 6,
    Rotate270FlipX      // = 7,
  );
  const
    RotateNoneFlipY    = Rotate180FlipX;
    Rotate90FlipY      = Rotate270FlipX;
    Rotate180FlipY     = RotateNoneFlipX;
    Rotate270FlipY     = Rotate90FlipX;

    RotateNoneFlipXY   = Rotate180FlipNone;
    Rotate90FlipXY     = Rotate270FlipNone;
    Rotate180FlipXY    = RotateNoneFlipNone;
    Rotate270FlipXY    = Rotate90FlipNone;

type
  TRotateFlipType = RotateFlipType;
{$ENDIF}

//---------------------------------------------------------------------------
// Encoder Parameter structure
//---------------------------------------------------------------------------

  {$EXTERNALSYM EncoderParameter}
  EncoderParameter = record
    Guid           : TGUID;   // GUID of the parameter
    NumberOfValues : ULONG;   // Number of the parameter values
    Type_          : ULONG;   // Value type, like ValueTypeLONG  etc.
    Value          : Pointer; // A pointer to the parameter values
  end;
  TEncoderParameter = EncoderParameter;
  {$EXTERNALSYM TEncoderParameter}
  PEncoderParameter = ^TEncoderParameter;
  {$EXTERNALSYM PEncoderParameter}

//---------------------------------------------------------------------------
// Encoder Parameters structure
//---------------------------------------------------------------------------

{$ALIGN 1}
  {$EXTERNALSYM EncoderParameters}
  EncoderParameters = record
    Count     : UINT;               // Number of parameters in this structure
    Parameter : array[0..0] of TEncoderParameter;  // Parameter values
  end;
  TEncoderParameters = EncoderParameters;
  {$EXTERNALSYM TEncoderParameters}
  PEncoderParameters = ^TEncoderParameters;
  {$EXTERNALSYM PEncoderParameters}
{$ALIGN ON}

//---------------------------------------------------------------------------
// Property Item
//---------------------------------------------------------------------------

  {$EXTERNALSYM PropertyItem}
  PropertyItem = record // NOT PACKED !!
    id       : PROPID;  // ID of this property
    length   : ULONG;   // Length of the property value, in bytes
    type_    : WORD;    // Type of the value, as one of TAG_TYPE_XXX
    value    : Pointer; // property value
  end;
  TPropertyItem = PropertyItem;
  {$EXTERNALSYM TPropertyItem}
  PPropertyItem = ^TPropertyItem;
  {$EXTERNALSYM PPropertyItem}

//---------------------------------------------------------------------------
// Image property types
//---------------------------------------------------------------------------

const
  PropertyTagTypeByte      : Integer =  1;
  {$EXTERNALSYM PropertyTagTypeByte}
  PropertyTagTypeASCII     : Integer =  2;
  {$EXTERNALSYM PropertyTagTypeASCII}
  PropertyTagTypeShort     : Integer =  3;
  {$EXTERNALSYM PropertyTagTypeShort}
  PropertyTagTypeLong      : Integer =  4;
  {$EXTERNALSYM PropertyTagTypeLong}
  PropertyTagTypeRational  : Integer =  5;
  {$EXTERNALSYM PropertyTagTypeRational}
  PropertyTagTypeUndefined : Integer =  7;
  {$EXTERNALSYM PropertyTagTypeUndefined}
  PropertyTagTypeSLONG     : Integer =  9;
  {$EXTERNALSYM PropertyTagTypeSLONG}
  PropertyTagTypeSRational : Integer = 10;
  {$EXTERNALSYM PropertyTagTypeSRational}

//---------------------------------------------------------------------------
// Image property ID tags
//---------------------------------------------------------------------------

  PropertyTagExifIFD            = $8769;
  {$EXTERNALSYM PropertyTagExifIFD}
  PropertyTagGpsIFD             = $8825;
  {$EXTERNALSYM PropertyTagGpsIFD}

  PropertyTagNewSubfileType     = $00FE;
  {$EXTERNALSYM PropertyTagNewSubfileType}
  PropertyTagSubfileType        = $00FF;
  {$EXTERNALSYM PropertyTagSubfileType}
  PropertyTagImageWidth         = $0100;
  {$EXTERNALSYM PropertyTagImageWidth}
  PropertyTagImageHeight        = $0101;
  {$EXTERNALSYM PropertyTagImageHeight}
  PropertyTagBitsPerSample      = $0102;
  {$EXTERNALSYM PropertyTagBitsPerSample}
  PropertyTagCompression        = $0103;
  {$EXTERNALSYM PropertyTagCompression}
  PropertyTagPhotometricInterp  = $0106;
  {$EXTERNALSYM PropertyTagPhotometricInterp}
  PropertyTagThreshHolding      = $0107;
  {$EXTERNALSYM PropertyTagThreshHolding}
  PropertyTagCellWidth          = $0108;
  {$EXTERNALSYM PropertyTagCellWidth}
  PropertyTagCellHeight         = $0109;
  {$EXTERNALSYM PropertyTagCellHeight}
  PropertyTagFillOrder          = $010A;
  {$EXTERNALSYM PropertyTagFillOrder}
  PropertyTagDocumentName       = $010D;
  {$EXTERNALSYM PropertyTagDocumentName}
  PropertyTagImageDescription   = $010E;
  {$EXTERNALSYM PropertyTagImageDescription}
  PropertyTagEquipMake          = $010F;
  {$EXTERNALSYM PropertyTagEquipMake}
  PropertyTagEquipModel         = $0110;
  {$EXTERNALSYM PropertyTagEquipModel}
  PropertyTagStripOffsets       = $0111;
  {$EXTERNALSYM PropertyTagStripOffsets}
  PropertyTagOrientation        = $0112;
  {$EXTERNALSYM PropertyTagOrientation}
  PropertyTagSamplesPerPixel    = $0115;
  {$EXTERNALSYM PropertyTagSamplesPerPixel}
  PropertyTagRowsPerStrip       = $0116;
  {$EXTERNALSYM PropertyTagRowsPerStrip}
  PropertyTagStripBytesCount    = $0117;
  {$EXTERNALSYM PropertyTagStripBytesCount}
  PropertyTagMinSampleValue     = $0118;
  {$EXTERNALSYM PropertyTagMinSampleValue}
  PropertyTagMaxSampleValue     = $0119;
  {$EXTERNALSYM PropertyTagMaxSampleValue}
  PropertyTagXResolution        = $011A;   // Image resolution in width direction
  {$EXTERNALSYM PropertyTagXResolution}
  PropertyTagYResolution        = $011B;   // Image resolution in height direction
  {$EXTERNALSYM PropertyTagYResolution}
  PropertyTagPlanarConfig       = $011C;   // Image data arrangement
  {$EXTERNALSYM PropertyTagPlanarConfig}
  PropertyTagPageName           = $011D;
  {$EXTERNALSYM PropertyTagPageName}
  PropertyTagXPosition          = $011E;
  {$EXTERNALSYM PropertyTagXPosition}
  PropertyTagYPosition          = $011F;
  {$EXTERNALSYM PropertyTagYPosition}
  PropertyTagFreeOffset         = $0120;
  {$EXTERNALSYM PropertyTagFreeOffset}
  PropertyTagFreeByteCounts     = $0121;
  {$EXTERNALSYM PropertyTagFreeByteCounts}
  PropertyTagGrayResponseUnit   = $0122;
  {$EXTERNALSYM PropertyTagGrayResponseUnit}
  PropertyTagGrayResponseCurve  = $0123;
  {$EXTERNALSYM PropertyTagGrayResponseCurve}
  PropertyTagT4Option           = $0124;
  {$EXTERNALSYM PropertyTagT4Option}
  PropertyTagT6Option           = $0125;
  {$EXTERNALSYM PropertyTagT6Option}
  PropertyTagResolutionUnit     = $0128;   // Unit of X and Y resolution
  {$EXTERNALSYM PropertyTagResolutionUnit}
  PropertyTagPageNumber         = $0129;
  {$EXTERNALSYM PropertyTagPageNumber}
  PropertyTagTransferFuncition  = $012D;
  {$EXTERNALSYM PropertyTagTransferFuncition}
  PropertyTagSoftwareUsed       = $0131;
  {$EXTERNALSYM PropertyTagSoftwareUsed}
  PropertyTagDateTime           = $0132;
  {$EXTERNALSYM PropertyTagDateTime}
  PropertyTagArtist             = $013B;
  {$EXTERNALSYM PropertyTagArtist}
  PropertyTagHostComputer       = $013C;
  {$EXTERNALSYM PropertyTagHostComputer}
  PropertyTagPredictor          = $013D;
  {$EXTERNALSYM PropertyTagPredictor}
  PropertyTagWhitePoint         = $013E;
  {$EXTERNALSYM PropertyTagWhitePoint}
  PropertyTagPrimaryChromaticities = $013F;
  {$EXTERNALSYM PropertyTagPrimaryChromaticities}
  PropertyTagColorMap           = $0140;
  {$EXTERNALSYM PropertyTagColorMap}
  PropertyTagHalftoneHints      = $0141;
  {$EXTERNALSYM PropertyTagHalftoneHints}
  PropertyTagTileWidth          = $0142;
  {$EXTERNALSYM PropertyTagTileWidth}
  PropertyTagTileLength         = $0143;
  {$EXTERNALSYM PropertyTagTileLength}
  PropertyTagTileOffset         = $0144;
  {$EXTERNALSYM PropertyTagTileOffset}
  PropertyTagTileByteCounts     = $0145;
  {$EXTERNALSYM PropertyTagTileByteCounts}
  PropertyTagInkSet             = $014C;
  {$EXTERNALSYM PropertyTagInkSet}
  PropertyTagInkNames           = $014D;
  {$EXTERNALSYM PropertyTagInkNames}
  PropertyTagNumberOfInks       = $014E;
  {$EXTERNALSYM PropertyTagNumberOfInks}
  PropertyTagDotRange           = $0150;
  {$EXTERNALSYM PropertyTagDotRange}
  PropertyTagTargetPrinter      = $0151;
  {$EXTERNALSYM PropertyTagTargetPrinter}
  PropertyTagExtraSamples       = $0152;
  {$EXTERNALSYM PropertyTagExtraSamples}
  PropertyTagSampleFormat       = $0153;
  {$EXTERNALSYM PropertyTagSampleFormat}
  PropertyTagSMinSampleValue    = $0154;
  {$EXTERNALSYM PropertyTagSMinSampleValue}
  PropertyTagSMaxSampleValue    = $0155;
  {$EXTERNALSYM PropertyTagSMaxSampleValue}
  PropertyTagTransferRange      = $0156;
  {$EXTERNALSYM PropertyTagTransferRange}

  PropertyTagJPEGProc               = $0200;
  {$EXTERNALSYM PropertyTagJPEGProc}
  PropertyTagJPEGInterFormat        = $0201;
  {$EXTERNALSYM PropertyTagJPEGInterFormat}
  PropertyTagJPEGInterLength        = $0202;
  {$EXTERNALSYM PropertyTagJPEGInterLength}
  PropertyTagJPEGRestartInterval    = $0203;
  {$EXTERNALSYM PropertyTagJPEGRestartInterval}
  PropertyTagJPEGLosslessPredictors = $0205;
  {$EXTERNALSYM PropertyTagJPEGLosslessPredictors}
  PropertyTagJPEGPointTransforms    = $0206;
  {$EXTERNALSYM PropertyTagJPEGPointTransforms}
  PropertyTagJPEGQTables            = $0207;
  {$EXTERNALSYM PropertyTagJPEGQTables}
  PropertyTagJPEGDCTables           = $0208;
  {$EXTERNALSYM PropertyTagJPEGDCTables}
  PropertyTagJPEGACTables           = $0209;
  {$EXTERNALSYM PropertyTagJPEGACTables}

  PropertyTagYCbCrCoefficients  = $0211;
  {$EXTERNALSYM PropertyTagYCbCrCoefficients}
  PropertyTagYCbCrSubsampling   = $0212;
  {$EXTERNALSYM PropertyTagYCbCrSubsampling}
  PropertyTagYCbCrPositioning   = $0213;
  {$EXTERNALSYM PropertyTagYCbCrPositioning}
  PropertyTagREFBlackWhite      = $0214;
  {$EXTERNALSYM PropertyTagREFBlackWhite}

  PropertyTagICCProfile         = $8773;   // This TAG is defined by ICC
  {$EXTERNALSYM PropertyTagICCProfile}
                                           // for embedded ICC in TIFF
  PropertyTagGamma                = $0301;
  {$EXTERNALSYM PropertyTagGamma}
  PropertyTagICCProfileDescriptor = $0302;
  {$EXTERNALSYM PropertyTagICCProfileDescriptor}
  PropertyTagSRGBRenderingIntent  = $0303;
  {$EXTERNALSYM PropertyTagSRGBRenderingIntent}

  PropertyTagImageTitle         = $0320;
  {$EXTERNALSYM PropertyTagImageTitle}
  PropertyTagCopyright          = $8298;
  {$EXTERNALSYM PropertyTagCopyright}

// Extra TAGs (Like Adobe Image Information tags etc.)

  PropertyTagResolutionXUnit           = $5001;
  {$EXTERNALSYM PropertyTagResolutionXUnit}
  PropertyTagResolutionYUnit           = $5002;
  {$EXTERNALSYM PropertyTagResolutionYUnit}
  PropertyTagResolutionXLengthUnit     = $5003;
  {$EXTERNALSYM PropertyTagResolutionXLengthUnit}
  PropertyTagResolutionYLengthUnit     = $5004;
  {$EXTERNALSYM PropertyTagResolutionYLengthUnit}
  PropertyTagPrintFlags                = $5005;
  {$EXTERNALSYM PropertyTagPrintFlags}
  PropertyTagPrintFlagsVersion         = $5006;
  {$EXTERNALSYM PropertyTagPrintFlagsVersion}
  PropertyTagPrintFlagsCrop            = $5007;
  {$EXTERNALSYM PropertyTagPrintFlagsCrop}
  PropertyTagPrintFlagsBleedWidth      = $5008;
  {$EXTERNALSYM PropertyTagPrintFlagsBleedWidth}
  PropertyTagPrintFlagsBleedWidthScale = $5009;
  {$EXTERNALSYM PropertyTagPrintFlagsBleedWidthScale}
  PropertyTagHalftoneLPI               = $500A;
  {$EXTERNALSYM PropertyTagHalftoneLPI}
  PropertyTagHalftoneLPIUnit           = $500B;
  {$EXTERNALSYM PropertyTagHalftoneLPIUnit}
  PropertyTagHalftoneDegree            = $500C;
  {$EXTERNALSYM PropertyTagHalftoneDegree}
  PropertyTagHalftoneShape             = $500D;
  {$EXTERNALSYM PropertyTagHalftoneShape}
  PropertyTagHalftoneMisc              = $500E;
  {$EXTERNALSYM PropertyTagHalftoneMisc}
  PropertyTagHalftoneScreen            = $500F;
  {$EXTERNALSYM PropertyTagHalftoneScreen}
  PropertyTagJPEGQuality               = $5010;
  {$EXTERNALSYM PropertyTagJPEGQuality}
  PropertyTagGridSize                  = $5011;
  {$EXTERNALSYM PropertyTagGridSize}
  PropertyTagThumbnailFormat           = $5012;  // 1 = JPEG, 0 = RAW RGB
  {$EXTERNALSYM PropertyTagThumbnailFormat}
  PropertyTagThumbnailWidth            = $5013;
  {$EXTERNALSYM PropertyTagThumbnailWidth}
  PropertyTagThumbnailHeight           = $5014;
  {$EXTERNALSYM PropertyTagThumbnailHeight}
  PropertyTagThumbnailColorDepth       = $5015;
  {$EXTERNALSYM PropertyTagThumbnailColorDepth}
  PropertyTagThumbnailPlanes           = $5016;
  {$EXTERNALSYM PropertyTagThumbnailPlanes}
  PropertyTagThumbnailRawBytes         = $5017;
  {$EXTERNALSYM PropertyTagThumbnailRawBytes}
  PropertyTagThumbnailSize             = $5018;
  {$EXTERNALSYM PropertyTagThumbnailSize}
  PropertyTagThumbnailCompressedSize   = $5019;
  {$EXTERNALSYM PropertyTagThumbnailCompressedSize}
  PropertyTagColorTransferFunction     = $501A;
  {$EXTERNALSYM PropertyTagColorTransferFunction}
  PropertyTagThumbnailData             = $501B;    // RAW thumbnail bits in
  {$EXTERNALSYM PropertyTagThumbnailData}
                                                   // JPEG format or RGB format
                                                   // depends on
                                                   // PropertyTagThumbnailFormat

  // Thumbnail related TAGs

  PropertyTagThumbnailImageWidth        = $5020;   // Thumbnail width
  {$EXTERNALSYM PropertyTagThumbnailImageWidth}
  PropertyTagThumbnailImageHeight       = $5021;   // Thumbnail height
  {$EXTERNALSYM PropertyTagThumbnailImageHeight}
  PropertyTagThumbnailBitsPerSample     = $5022;   // Number of bits per
  {$EXTERNALSYM PropertyTagThumbnailBitsPerSample}
                                                   // component
  PropertyTagThumbnailCompression       = $5023;   // Compression Scheme
  {$EXTERNALSYM PropertyTagThumbnailCompression}
  PropertyTagThumbnailPhotometricInterp = $5024;   // Pixel composition
  {$EXTERNALSYM PropertyTagThumbnailPhotometricInterp}
  PropertyTagThumbnailImageDescription  = $5025;   // Image Tile
  {$EXTERNALSYM PropertyTagThumbnailImageDescription}
  PropertyTagThumbnailEquipMake         = $5026;   // Manufacturer of Image
  {$EXTERNALSYM PropertyTagThumbnailEquipMake}
                                                   // Input equipment
  PropertyTagThumbnailEquipModel        = $5027;   // Model of Image input
  {$EXTERNALSYM PropertyTagThumbnailEquipModel}
                                                   // equipment
  PropertyTagThumbnailStripOffsets    = $5028;  // Image data location
  {$EXTERNALSYM PropertyTagThumbnailStripOffsets}
  PropertyTagThumbnailOrientation     = $5029;  // Orientation of image
  {$EXTERNALSYM PropertyTagThumbnailOrientation}
  PropertyTagThumbnailSamplesPerPixel = $502A;  // Number of components
  {$EXTERNALSYM PropertyTagThumbnailSamplesPerPixel}
  PropertyTagThumbnailRowsPerStrip    = $502B;  // Number of rows per strip
  {$EXTERNALSYM PropertyTagThumbnailRowsPerStrip}
  PropertyTagThumbnailStripBytesCount = $502C;  // Bytes per compressed
  {$EXTERNALSYM PropertyTagThumbnailStripBytesCount}
                                                // strip
  PropertyTagThumbnailResolutionX     = $502D;  // Resolution in width
  {$EXTERNALSYM PropertyTagThumbnailResolutionX}
                                                // direction
  PropertyTagThumbnailResolutionY     = $502E;  // Resolution in height
  {$EXTERNALSYM PropertyTagThumbnailResolutionY}
                                                // direction
  PropertyTagThumbnailPlanarConfig    = $502F;  // Image data arrangement
  {$EXTERNALSYM PropertyTagThumbnailPlanarConfig}
  PropertyTagThumbnailResolutionUnit  = $5030;  // Unit of X and Y
  {$EXTERNALSYM PropertyTagThumbnailResolutionUnit}
                                                // Resolution
  PropertyTagThumbnailTransferFunction = $5031;  // Transfer function
  {$EXTERNALSYM PropertyTagThumbnailTransferFunction}
  PropertyTagThumbnailSoftwareUsed     = $5032;  // Software used
  {$EXTERNALSYM PropertyTagThumbnailSoftwareUsed}
  PropertyTagThumbnailDateTime         = $5033;  // File change date and
  {$EXTERNALSYM PropertyTagThumbnailDateTime}
                                                 // time
  PropertyTagThumbnailArtist          = $5034;  // Person who created the
  {$EXTERNALSYM PropertyTagThumbnailArtist}
                                                // image
  PropertyTagThumbnailWhitePoint      = $5035;  // White point chromaticity
  {$EXTERNALSYM PropertyTagThumbnailWhitePoint}
  PropertyTagThumbnailPrimaryChromaticities = $5036;
  {$EXTERNALSYM PropertyTagThumbnailPrimaryChromaticities}
                                                    // Chromaticities of
                                                    // primaries
  PropertyTagThumbnailYCbCrCoefficients = $5037; // Color space transforma-
  {$EXTERNALSYM PropertyTagThumbnailYCbCrCoefficients}
                                                 // tion coefficients
  PropertyTagThumbnailYCbCrSubsampling = $5038;  // Subsampling ratio of Y
  {$EXTERNALSYM PropertyTagThumbnailYCbCrSubsampling}
                                                 // to C
  PropertyTagThumbnailYCbCrPositioning = $5039;  // Y and C position
  {$EXTERNALSYM PropertyTagThumbnailYCbCrPositioning}
  PropertyTagThumbnailRefBlackWhite    = $503A;  // Pair of black and white
  {$EXTERNALSYM PropertyTagThumbnailRefBlackWhite}
                                                 // reference values
  PropertyTagThumbnailCopyRight       = $503B;   // CopyRight holder
  {$EXTERNALSYM PropertyTagThumbnailCopyRight}

  PropertyTagLuminanceTable           = $5090;
  {$EXTERNALSYM PropertyTagLuminanceTable}
  PropertyTagChrominanceTable         = $5091;
  {$EXTERNALSYM PropertyTagChrominanceTable}

  PropertyTagFrameDelay               = $5100;
  {$EXTERNALSYM PropertyTagFrameDelay}
  PropertyTagLoopCount                = $5101;
  {$EXTERNALSYM PropertyTagLoopCount}

  PropertyTagPixelUnit         = $5110;  // Unit specifier for pixel/unit
  {$EXTERNALSYM PropertyTagPixelUnit}
  PropertyTagPixelPerUnitX     = $5111;  // Pixels per unit in X
  {$EXTERNALSYM PropertyTagPixelPerUnitX}
  PropertyTagPixelPerUnitY     = $5112;  // Pixels per unit in Y
  {$EXTERNALSYM PropertyTagPixelPerUnitY}
  PropertyTagPaletteHistogram  = $5113;  // Palette histogram
  {$EXTERNALSYM PropertyTagPaletteHistogram}

  // EXIF specific tag

  PropertyTagExifExposureTime  = $829A;
  {$EXTERNALSYM PropertyTagExifExposureTime}
  PropertyTagExifFNumber       = $829D;
  {$EXTERNALSYM PropertyTagExifFNumber}

  PropertyTagExifExposureProg  = $8822;
  {$EXTERNALSYM PropertyTagExifExposureProg}
  PropertyTagExifSpectralSense = $8824;
  {$EXTERNALSYM PropertyTagExifSpectralSense}
  PropertyTagExifISOSpeed      = $8827;
  {$EXTERNALSYM PropertyTagExifISOSpeed}
  PropertyTagExifOECF          = $8828;
  {$EXTERNALSYM PropertyTagExifOECF}

  PropertyTagExifVer           = $9000;
  {$EXTERNALSYM PropertyTagExifVer}
  PropertyTagExifDTOrig        = $9003; // Date & time of original
  {$EXTERNALSYM PropertyTagExifDTOrig}
  PropertyTagExifDTDigitized   = $9004; // Date & time of digital data generation
  {$EXTERNALSYM PropertyTagExifDTDigitized}

  PropertyTagExifCompConfig    = $9101;
  {$EXTERNALSYM PropertyTagExifCompConfig}
  PropertyTagExifCompBPP       = $9102;
  {$EXTERNALSYM PropertyTagExifCompBPP}

  PropertyTagExifShutterSpeed  = $9201;
  {$EXTERNALSYM PropertyTagExifShutterSpeed}
  PropertyTagExifAperture      = $9202;
  {$EXTERNALSYM PropertyTagExifAperture}
  PropertyTagExifBrightness    = $9203;
  {$EXTERNALSYM PropertyTagExifBrightness}
  PropertyTagExifExposureBias  = $9204;
  {$EXTERNALSYM PropertyTagExifExposureBias}
  PropertyTagExifMaxAperture   = $9205;
  {$EXTERNALSYM PropertyTagExifMaxAperture}
  PropertyTagExifSubjectDist   = $9206;
  {$EXTERNALSYM PropertyTagExifSubjectDist}
  PropertyTagExifMeteringMode  = $9207;
  {$EXTERNALSYM PropertyTagExifMeteringMode}
  PropertyTagExifLightSource   = $9208;
  {$EXTERNALSYM PropertyTagExifLightSource}
  PropertyTagExifFlash         = $9209;
  {$EXTERNALSYM PropertyTagExifFlash}
  PropertyTagExifFocalLength   = $920A;
  {$EXTERNALSYM PropertyTagExifFocalLength}
  PropertyTagExifMakerNote     = $927C;
  {$EXTERNALSYM PropertyTagExifMakerNote}
  PropertyTagExifUserComment   = $9286;
  {$EXTERNALSYM PropertyTagExifUserComment}
  PropertyTagExifDTSubsec      = $9290;  // Date & Time subseconds
  {$EXTERNALSYM PropertyTagExifDTSubsec}
  PropertyTagExifDTOrigSS      = $9291;  // Date & Time original subseconds
  {$EXTERNALSYM PropertyTagExifDTOrigSS}
  PropertyTagExifDTDigSS       = $9292;  // Date & TIme digitized subseconds
  {$EXTERNALSYM PropertyTagExifDTDigSS}

  PropertyTagExifFPXVer        = $A000;
  {$EXTERNALSYM PropertyTagExifFPXVer}
  PropertyTagExifColorSpace    = $A001;
  {$EXTERNALSYM PropertyTagExifColorSpace}
  PropertyTagExifPixXDim       = $A002;
  {$EXTERNALSYM PropertyTagExifPixXDim}
  PropertyTagExifPixYDim       = $A003;
  {$EXTERNALSYM PropertyTagExifPixYDim}
  PropertyTagExifRelatedWav    = $A004;  // related sound file
  {$EXTERNALSYM PropertyTagExifRelatedWav}
  PropertyTagExifInterop       = $A005;
  {$EXTERNALSYM PropertyTagExifInterop}
  PropertyTagExifFlashEnergy   = $A20B;
  {$EXTERNALSYM PropertyTagExifFlashEnergy}
  PropertyTagExifSpatialFR     = $A20C;  // Spatial Frequency Response
  {$EXTERNALSYM PropertyTagExifSpatialFR}
  PropertyTagExifFocalXRes     = $A20E;  // Focal Plane X Resolution
  {$EXTERNALSYM PropertyTagExifFocalXRes}
  PropertyTagExifFocalYRes     = $A20F;  // Focal Plane Y Resolution
  {$EXTERNALSYM PropertyTagExifFocalYRes}
  PropertyTagExifFocalResUnit  = $A210;  // Focal Plane Resolution Unit
  {$EXTERNALSYM PropertyTagExifFocalResUnit}
  PropertyTagExifSubjectLoc    = $A214;
  {$EXTERNALSYM PropertyTagExifSubjectLoc}
  PropertyTagExifExposureIndex = $A215;
  {$EXTERNALSYM PropertyTagExifExposureIndex}
  PropertyTagExifSensingMethod = $A217;
  {$EXTERNALSYM PropertyTagExifSensingMethod}
  PropertyTagExifFileSource    = $A300;
  {$EXTERNALSYM PropertyTagExifFileSource}
  PropertyTagExifSceneType     = $A301;
  {$EXTERNALSYM PropertyTagExifSceneType}
  PropertyTagExifCfaPattern    = $A302;
  {$EXTERNALSYM PropertyTagExifCfaPattern}

  PropertyTagGpsVer            = $0000;
  {$EXTERNALSYM PropertyTagGpsVer}
  PropertyTagGpsLatitudeRef    = $0001;
  {$EXTERNALSYM PropertyTagGpsLatitudeRef}
  PropertyTagGpsLatitude       = $0002;
  {$EXTERNALSYM PropertyTagGpsLatitude}
  PropertyTagGpsLongitudeRef   = $0003;
  {$EXTERNALSYM PropertyTagGpsLongitudeRef}
  PropertyTagGpsLongitude      = $0004;
  {$EXTERNALSYM PropertyTagGpsLongitude}
  PropertyTagGpsAltitudeRef    = $0005;
  {$EXTERNALSYM PropertyTagGpsAltitudeRef}
  PropertyTagGpsAltitude       = $0006;
  {$EXTERNALSYM PropertyTagGpsAltitude}
  PropertyTagGpsGpsTime        = $0007;
  {$EXTERNALSYM PropertyTagGpsGpsTime}
  PropertyTagGpsGpsSatellites  = $0008;
  {$EXTERNALSYM PropertyTagGpsGpsSatellites}
  PropertyTagGpsGpsStatus      = $0009;
  {$EXTERNALSYM PropertyTagGpsGpsStatus}
  PropertyTagGpsGpsMeasureMode = $00A;
  {$EXTERNALSYM PropertyTagGpsGpsMeasureMode}
  PropertyTagGpsGpsDop         = $000B;  // Measurement precision
  {$EXTERNALSYM PropertyTagGpsGpsDop}
  PropertyTagGpsSpeedRef       = $000C;
  {$EXTERNALSYM PropertyTagGpsSpeedRef}
  PropertyTagGpsSpeed          = $000D;
  {$EXTERNALSYM PropertyTagGpsSpeed}
  PropertyTagGpsTrackRef       = $000E;
  {$EXTERNALSYM PropertyTagGpsTrackRef}
  PropertyTagGpsTrack          = $000F;
  {$EXTERNALSYM PropertyTagGpsTrack}
  PropertyTagGpsImgDirRef      = $0010;
  {$EXTERNALSYM PropertyTagGpsImgDirRef}
  PropertyTagGpsImgDir         = $0011;
  {$EXTERNALSYM PropertyTagGpsImgDir}
  PropertyTagGpsMapDatum       = $0012;
  {$EXTERNALSYM PropertyTagGpsMapDatum}
  PropertyTagGpsDestLatRef     = $0013;
  {$EXTERNALSYM PropertyTagGpsDestLatRef}
  PropertyTagGpsDestLat        = $0014;
  {$EXTERNALSYM PropertyTagGpsDestLat}
  PropertyTagGpsDestLongRef    = $0015;
  {$EXTERNALSYM PropertyTagGpsDestLongRef}
  PropertyTagGpsDestLong       = $0016;
  {$EXTERNALSYM PropertyTagGpsDestLong}
  PropertyTagGpsDestBearRef    = $0017;
  {$EXTERNALSYM PropertyTagGpsDestBearRef}
  PropertyTagGpsDestBear       = $0018;
  {$EXTERNALSYM PropertyTagGpsDestBear}
  PropertyTagGpsDestDistRef    = $0019;
  {$EXTERNALSYM PropertyTagGpsDestDistRef}
  PropertyTagGpsDestDist       = $001A;
  {$EXTERNALSYM PropertyTagGpsDestDist}

(**************************************************************************\
*
*  GDI+ Color Matrix object, used with Graphics.DrawImage
*
\**************************************************************************)

//----------------------------------------------------------------------------
// Color matrix
//----------------------------------------------------------------------------

type
  {$EXTERNALSYM ColorMatrix}
  ColorMatrix = packed array[0..4, 0..4] of Single;
  TColorMatrix = ColorMatrix;
  {$EXTERNALSYM TColorMatrix}
  PColorMatrix = ^TColorMatrix;
  {$EXTERNALSYM PColorMatrix}

//----------------------------------------------------------------------------
// Color Matrix flags
//----------------------------------------------------------------------------

  {$EXTERNALSYM ColorMatrixFlags}
  ColorMatrixFlags = (
    ColorMatrixFlagsDefault,
    ColorMatrixFlagsSkipGrays,
    ColorMatrixFlagsAltGray
  );
  TColorMatrixFlags = ColorMatrixFlags;
  {$EXTERNALSYM TColorMatrixFlags}

//----------------------------------------------------------------------------
// Color Adjust Type
//----------------------------------------------------------------------------

  {$EXTERNALSYM ColorAdjustType}
  ColorAdjustType = (
    ColorAdjustTypeDefault,
    ColorAdjustTypeBitmap,
    ColorAdjustTypeBrush,
    ColorAdjustTypePen,
    ColorAdjustTypeText,
    ColorAdjustTypeCount,
    ColorAdjustTypeAny      // Reserved
  );
  TColorAdjustType = ColorAdjustType;
  {$EXTERNALSYM TColorAdjustType}

//----------------------------------------------------------------------------
// Color Map
//----------------------------------------------------------------------------

  {$EXTERNALSYM ColorMap}
  ColorMap = record
    oldColor: TGPColor;
    newColor: TGPColor;
  end;
  TColorMap = ColorMap;
  {$EXTERNALSYM TColorMap}
  PColorMap = ^TColorMap;
  {$EXTERNALSYM PColorMap}

//---------------------------------------------------------------------------
// Private GDI+ classes for internal type checking
//---------------------------------------------------------------------------

  GpGraphics = Pointer;
  {$EXTERNALSYM GpGraphics}

  GpBrush = Pointer;
  {$EXTERNALSYM GpBrush}
  GpTexture = Pointer;
  {$EXTERNALSYM GpTexture}
  GpSolidFill = Pointer;
  {$EXTERNALSYM GpSolidFill}
  GpLineGradient = Pointer;
  {$EXTERNALSYM GpLineGradient}
  GpPathGradient = Pointer;
  {$EXTERNALSYM GpPathGradient}
  GpHatch =  Pointer;
  {$EXTERNALSYM GpHatch}

  GpPen = Pointer;
  {$EXTERNALSYM GpPen}
  GpCustomLineCap = Pointer;
  {$EXTERNALSYM GpCustomLineCap}
  GpAdjustableArrowCap = Pointer;
  {$EXTERNALSYM GpAdjustableArrowCap}

  GpImage = Pointer;
  {$EXTERNALSYM GpImage}
  GpBitmap = Pointer;
  {$EXTERNALSYM GpBitmap}
  GpMetafile = Pointer;
  {$EXTERNALSYM GpMetafile}
  GpImageAttributes = Pointer;
  {$EXTERNALSYM GpImageAttributes}

  GpPath = Pointer;
  {$EXTERNALSYM GpPath}
  GpRegion = Pointer;
  {$EXTERNALSYM GpRegion}
  GpPathIterator = Pointer;
  {$EXTERNALSYM GpPathIterator}

  GpFontFamily = Pointer;
  {$EXTERNALSYM GpFontFamily}
  GpFont = Pointer;
  {$EXTERNALSYM GpFont}
  GpStringFormat = Pointer;
  {$EXTERNALSYM GpStringFormat}
  GpFontCollection = Pointer;
  {$EXTERNALSYM GpFontCollection}
  GpCachedBitmap = Pointer;
  {$EXTERNALSYM GpCachedBitmap}

  GpStatus          = TStatus;
  {$EXTERNALSYM GpStatus}
  GpFillMode        = TFillMode;
  {$EXTERNALSYM GpFillMode}
  GpWrapMode        = TWrapMode;
  {$EXTERNALSYM GpWrapMode}
  GpUnit            = TUnit;
  {$EXTERNALSYM GpUnit}
  GpCoordinateSpace = TCoordinateSpace;
  {$EXTERNALSYM GpCoordinateSpace}
  GpPointF          = PGPPointF;
  {$EXTERNALSYM GpPointF}
  GpPoint           = PGPPoint;
  {$EXTERNALSYM GpPoint}
  GpRectF           = PGPRectF;
  {$EXTERNALSYM GpRectF}
  GpRect            = PGPRect;
  {$EXTERNALSYM GpRect}
  GpSizeF           = PGPSizeF;
  {$EXTERNALSYM GpSizeF}
  GpHatchStyle      = THatchStyle;
  {$EXTERNALSYM GpHatchStyle}
  GpDashStyle       = TDashStyle;
  {$EXTERNALSYM GpDashStyle}
  GpLineCap         = TLineCap;
  {$EXTERNALSYM GpLineCap}
  GpDashCap         = TDashCap;
  {$EXTERNALSYM GpDashCap}

  GpPenAlignment    = TPenAlignment;
  {$EXTERNALSYM GpPenAlignment}

  GpLineJoin        = TLineJoin;
  {$EXTERNALSYM GpLineJoin}
  GpPenType         = TPenType;
  {$EXTERNALSYM GpPenType}

  GpMatrix          = Pointer; 
  {$EXTERNALSYM GpMatrix}
  GpBrushType       = TBrushType;
  {$EXTERNALSYM GpBrushType}
  GpMatrixOrder     = TMatrixOrder;
  {$EXTERNALSYM GpMatrixOrder}
  GpFlushIntention  = TFlushIntention;
  {$EXTERNALSYM GpFlushIntention}
  GpPathData        = TPathData;
  {$EXTERNALSYM GpPathData}

(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
* Module Name:
*   GdiplusFlat.h
* Abstract:
*   Private GDI+ header file.
*
\**************************************************************************)

  function GdipCreatePath(brushMode: GPFILLMODE;
    out path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePath}

  function GdipCreatePath2(v1: GPPOINTF; v2: PBYTE; v3: Integer; v4: GPFILLMODE;
    out path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePath2}

  function GdipCreatePath2I(v1: GPPOINT; v2: PBYTE; v3: Integer; v4: GPFILLMODE;
    out path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePath2I}

  function GdipClonePath(path: GPPATH;
    out clonePath: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipClonePath}

  function GdipDeletePath(path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeletePath}

  function GdipResetPath(path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetPath}

  function GdipGetPointCount(path: GPPATH;
    out count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPointCount}

  function GdipGetPathTypes(path: GPPATH; types: PBYTE;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathTypes}

  function GdipGetPathPoints(v1: GPPATH; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathPoints}

  function GdipGetPathPointsI(v1: GPPATH; points: GPPOINT;
             count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathPointsI}

  function GdipGetPathFillMode(path: GPPATH;
    var fillmode: GPFILLMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathFillMode}

  function GdipSetPathFillMode(path: GPPATH;
    fillmode: GPFILLMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathFillMode}

  function GdipGetPathData(path: GPPATH;
    pathData: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathData}

  function GdipStartPathFigure(path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipStartPathFigure}

  function GdipClosePathFigure(path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipClosePathFigure}

  function GdipClosePathFigures(path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipClosePathFigures}

  function GdipSetPathMarker(path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathMarker}

  function GdipClearPathMarkers(path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipClearPathMarkers}

  function GdipReversePath(path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipReversePath}

  function GdipGetPathLastPoint(path: GPPATH;
    lastPoint: GPPOINTF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathLastPoint}

  function GdipAddPathLine(path: GPPATH;
    x1, y1, x2, y2: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathLine}

  function GdipAddPathLine2(path: GPPATH; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathLine2}

  function GdipAddPathArc(path: GPPATH; x, y, width, height, startAngle,
    sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathArc}

  function GdipAddPathBezier(path: GPPATH;
    x1, y1, x2, y2, x3, y3, x4, y4: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathBezier}

  function GdipAddPathBeziers(path: GPPATH; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathBeziers}

  function GdipAddPathCurve(path: GPPATH; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathCurve}

  function GdipAddPathCurve2(path: GPPATH; points: GPPOINTF; count: Integer;
    tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathCurve2}

  function GdipAddPathCurve3(path: GPPATH; points: GPPOINTF; count: Integer;
    offset: Integer; numberOfSegments: Integer;
    tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathCurve3}

  function GdipAddPathClosedCurve(path: GPPATH; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathClosedCurve}

  function GdipAddPathClosedCurve2(path: GPPATH; points: GPPOINTF;
    count: Integer; tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathClosedCurve2}

  function GdipAddPathRectangle(path: GPPATH; x: Single; y: Single;
    width: Single; height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathRectangle}

  function GdipAddPathRectangles(path: GPPATH; rects: GPRECTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathRectangles}

  function GdipAddPathEllipse(path: GPPATH;  x: Single; y: Single;
    width: Single; height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathEllipse}

  function GdipAddPathPie(path: GPPATH; x: Single; y: Single; width: Single;
    height: Single; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathPie}

  function GdipAddPathPolygon(path: GPPATH; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathPolygon}

  function GdipAddPathPath(path: GPPATH; addingPath: GPPATH;
    connect: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathPath}

  function GdipAddPathString(path: GPPATH; string_: PWCHAR; length: Integer;
    family: GPFONTFAMILY; style: Integer; emSize: Single; layoutRect: PGPRectF;
    format: GPSTRINGFORMAT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathString}

  function GdipAddPathStringI(path: GPPATH; string_: PWCHAR; length: Integer;
    family: GPFONTFAMILY; style: Integer; emSize: Single; layoutRect: PGPRect;
    format: GPSTRINGFORMAT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathStringI}

  function GdipAddPathLineI(path: GPPATH; x1: Integer; y1: Integer; x2: Integer;
    y2: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathLineI}

  function GdipAddPathLine2I(path: GPPATH; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathLine2I}

  function GdipAddPathArcI(path: GPPATH; x: Integer; y: Integer; width: Integer;
    height: Integer; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathArcI}

  function GdipAddPathBezierI(path: GPPATH; x1: Integer; y1: Integer;
    x2: Integer; y2: Integer; x3: Integer; y3: Integer; x4: Integer;
    y4: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathBezierI}

  function GdipAddPathBeziersI(path: GPPATH; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathBeziersI}

  function GdipAddPathCurveI(path: GPPATH; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathCurveI}

  function GdipAddPathCurve2I(path: GPPATH; points: GPPOINT; count: Integer;
    tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathCurve2I}

  function GdipAddPathCurve3I(path: GPPATH; points: GPPOINT; count: Integer;
    offset: Integer; numberOfSegments: Integer;
    tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathCurve3I}

  function GdipAddPathClosedCurveI(path: GPPATH; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathClosedCurveI}

  function GdipAddPathClosedCurve2I(path: GPPATH; points: GPPOINT;
    count: Integer; tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathClosedCurve2I}

  function GdipAddPathRectangleI(path: GPPATH; x: Integer; y: Integer;
    width: Integer; height: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathRectangleI}

  function GdipAddPathRectanglesI(path: GPPATH; rects: GPRECT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathRectanglesI}

  function GdipAddPathEllipseI(path: GPPATH; x: Integer; y: Integer;
    width: Integer; height: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathEllipseI}

  function GdipAddPathPieI(path: GPPATH; x: Integer; y: Integer; width: Integer;
    height: Integer; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathPieI}

  function GdipAddPathPolygonI(path: GPPATH; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipAddPathPolygonI}

  function GdipFlattenPath(path: GPPATH; matrix: GPMATRIX;
    flatness: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFlattenPath}

  function GdipWindingModeOutline(path: GPPATH; matrix: GPMATRIX;
    flatness: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipWindingModeOutline}

  function GdipWidenPath(nativePath: GPPATH; pen: GPPEN; matrix: GPMATRIX;
    flatness: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipWidenPath}

  function GdipWarpPath(path: GPPATH; matrix: GPMATRIX; points: GPPOINTF;
    count: Integer; srcx: Single; srcy: Single; srcwidth: Single;
    srcheight: Single; warpMode: WARPMODE; flatness: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipWarpPath}

  function GdipTransformPath(path: GPPATH; matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTransformPath}

  function GdipGetPathWorldBounds(path: GPPATH; bounds: GPRECTF;
    matrix: GPMATRIX; pen: GPPEN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathWorldBounds}

  function GdipGetPathWorldBoundsI(path: GPPATH; bounds: GPRECT;
    matrix: GPMATRIX; pen: GPPEN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathWorldBoundsI}

  function GdipIsVisiblePathPoint(path: GPPATH; x: Single; y: Single;
    graphics: GPGRAPHICS; out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisiblePathPoint}

  function GdipIsVisiblePathPointI(path: GPPATH; x: Integer; y: Integer;
    graphics: GPGRAPHICS; out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisiblePathPointI}

  function GdipIsOutlineVisiblePathPoint(path: GPPATH; x: Single; y: Single;
    pen: GPPEN; graphics: GPGRAPHICS; out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsOutlineVisiblePathPoint}

  function GdipIsOutlineVisiblePathPointI(path: GPPATH; x: Integer; y: Integer;
    pen: GPPEN; graphics: GPGRAPHICS; out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsOutlineVisiblePathPointI}

//----------------------------------------------------------------------------
// PathIterator APIs 
//----------------------------------------------------------------------------

  function GdipCreatePathIter(out iterator: GPPATHITERATOR;
    path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePathIter}

  function GdipDeletePathIter(iterator: GPPATHITERATOR): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeletePathIter}

  function GdipPathIterNextSubpath(iterator: GPPATHITERATOR;
    var resultCount: Integer; var startIndex: Integer; var endIndex: Integer;
    out isClosed: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterNextSubpath}

  function GdipPathIterNextSubpathPath(iterator: GPPATHITERATOR;
    var resultCount: Integer; path: GPPATH;
    out isClosed: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterNextSubpathPath}

  function GdipPathIterNextPathType(iterator: GPPATHITERATOR;
    var resultCount: Integer; pathType: PBYTE; var startIndex: Integer;
    var endIndex: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterNextPathType}

  function GdipPathIterNextMarker(iterator: GPPATHITERATOR;
    var resultCount: Integer; var startIndex: Integer;
    var endIndex: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterNextMarker}

  function GdipPathIterNextMarkerPath(iterator: GPPATHITERATOR;
    var resultCount: Integer; path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterNextMarkerPath}

  function GdipPathIterGetCount(iterator: GPPATHITERATOR;
    out count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterGetCount}

  function GdipPathIterGetSubpathCount(iterator: GPPATHITERATOR;
    out count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterGetSubpathCount}

  function GdipPathIterIsValid(iterator: GPPATHITERATOR;
    out valid: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterIsValid}

  function GdipPathIterHasCurve(iterator: GPPATHITERATOR;
    out hasCurve: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterHasCurve}

  function GdipPathIterRewind(iterator: GPPATHITERATOR): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterRewind}

  function GdipPathIterEnumerate(iterator: GPPATHITERATOR;
    var resultCount: Integer; points: GPPOINTF; types: PBYTE;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterEnumerate}

  function GdipPathIterCopyData(iterator: GPPATHITERATOR;
    var resultCount: Integer; points: GPPOINTF; types: PBYTE;
    startIndex: Integer; endIndex: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPathIterCopyData}

//----------------------------------------------------------------------------
// Matrix APIs
//----------------------------------------------------------------------------

  function GdipCreateMatrix(out matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMatrix}

  function GdipCreateMatrix2(m11: Single; m12: Single; m21: Single; m22: Single;
    dx: Single; dy: Single; out matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMatrix2}

  function GdipCreateMatrix3(rect: GPRECTF; dstplg: GPPOINTF;
    out matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMatrix3}

  function GdipCreateMatrix3I(rect: GPRECT; dstplg: GPPOINT;
    out matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMatrix3I}

  function GdipCloneMatrix(matrix: GPMATRIX;
    out cloneMatrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneMatrix}

  function GdipDeleteMatrix(matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteMatrix}

  function GdipSetMatrixElements(matrix: GPMATRIX; m11: Single; m12: Single;
    m21: Single; m22: Single; dx: Single; dy: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetMatrixElements}

  function GdipMultiplyMatrix(matrix: GPMATRIX; matrix2: GPMATRIX;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMultiplyMatrix}

  function GdipTranslateMatrix(matrix: GPMATRIX; offsetX: Single;
    offsetY: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslateMatrix}

  function GdipScaleMatrix(matrix: GPMATRIX; scaleX: Single; scaleY: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipScaleMatrix}

  function GdipRotateMatrix(matrix: GPMATRIX; angle: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRotateMatrix}

  function GdipShearMatrix(matrix: GPMATRIX; shearX: Single; shearY: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipShearMatrix}

  function GdipInvertMatrix(matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipInvertMatrix}

  function GdipTransformMatrixPoints(matrix: GPMATRIX; pts: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTransformMatrixPoints}

  function GdipTransformMatrixPointsI(matrix: GPMATRIX; pts: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTransformMatrixPointsI}

  function GdipVectorTransformMatrixPoints(matrix: GPMATRIX; pts: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipVectorTransformMatrixPoints}

  function GdipVectorTransformMatrixPointsI(matrix: GPMATRIX; pts: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipVectorTransformMatrixPointsI}

  function GdipGetMatrixElements(matrix: GPMATRIX;
    matrixOut: PSingle): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetMatrixElements}

  function GdipIsMatrixInvertible(matrix: GPMATRIX;
    out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsMatrixInvertible}

  function GdipIsMatrixIdentity(matrix: GPMATRIX;
    out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsMatrixIdentity}

  function GdipIsMatrixEqual(matrix: GPMATRIX; matrix2: GPMATRIX;
    out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsMatrixEqual}

//----------------------------------------------------------------------------
// Region APIs
//----------------------------------------------------------------------------

  function GdipCreateRegion(out region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateRegion}

  function GdipCreateRegionRect(rect: GPRECTF;
    out region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateRegionRect}

  function GdipCreateRegionRectI(rect: GPRECT;
    out region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateRegionRectI}

  function GdipCreateRegionPath(path: GPPATH;
    out region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateRegionPath}

  function GdipCreateRegionRgnData(regionData: PBYTE; size: Integer;
    out region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateRegionRgnData}

  function GdipCreateRegionHrgn(hRgn: HRGN;
    out region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateRegionHrgn}

  function GdipCloneRegion(region: GPREGION;
    out cloneRegion: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneRegion}

  function GdipDeleteRegion(region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteRegion}

  function GdipSetInfinite(region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetInfinite}

  function GdipSetEmpty(region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetEmpty}

  function GdipCombineRegionRect(region: GPREGION; rect: GPRECTF;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCombineRegionRect}

  function GdipCombineRegionRectI(region: GPREGION; rect: GPRECT;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCombineRegionRectI}

  function GdipCombineRegionPath(region: GPREGION; path: GPPATH;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCombineRegionPath}

  function GdipCombineRegionRegion(region: GPREGION; region2: GPREGION;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCombineRegionRegion}

  function GdipTranslateRegion(region: GPREGION; dx: Single;
    dy: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslateRegion}

  function GdipTranslateRegionI(region: GPREGION; dx: Integer;
    dy: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslateRegionI}

  function GdipTransformRegion(region: GPREGION;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTransformRegion}

  function GdipGetRegionBounds(region: GPREGION; graphics: GPGRAPHICS;
    rect: GPRECTF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRegionBounds}

  function GdipGetRegionBoundsI(region: GPREGION; graphics: GPGRAPHICS;
    rect: GPRECT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRegionBoundsI}

  function GdipGetRegionHRgn(region: GPREGION; graphics: GPGRAPHICS;
    out hRgn: HRGN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRegionHRgn}

  function GdipIsEmptyRegion(region: GPREGION; graphics: GPGRAPHICS;
    out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsEmptyRegion}

  function GdipIsInfiniteRegion(region: GPREGION; graphics: GPGRAPHICS;
    out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsInfiniteRegion}

  function GdipIsEqualRegion(region: GPREGION; region2: GPREGION;
    graphics: GPGRAPHICS; out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsEqualRegion}

  function GdipGetRegionDataSize(region: GPREGION;
    out bufferSize: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRegionDataSize}

  function GdipGetRegionData(region: GPREGION; buffer: PBYTE;
    bufferSize: UINT; sizeFilled: PUINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRegionData}

  function GdipIsVisibleRegionPoint(region: GPREGION; x: Single; y: Single;
    graphics: GPGRAPHICS; out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisibleRegionPoint}

  function GdipIsVisibleRegionPointI(region: GPREGION; x: Integer; y: Integer;
    graphics: GPGRAPHICS; out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisibleRegionPointI}

  function GdipIsVisibleRegionRect(region: GPREGION; x: Single; y: Single;
    width: Single; height: Single; graphics: GPGRAPHICS;
    out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisibleRegionRect}

  function GdipIsVisibleRegionRectI(region: GPREGION; x: Integer; y: Integer;
    width: Integer; height: Integer; graphics: GPGRAPHICS;
    out result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisibleRegionRectI}

  function GdipGetRegionScansCount(region: GPREGION; out count: UINT;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRegionScansCount}

  function GdipGetRegionScans(region: GPREGION; rects: GPRECTF;
    out count: Integer; matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRegionScans}

  function GdipGetRegionScansI(region: GPREGION; rects: GPRECT;
    out count: Integer; matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRegionScansI}

//----------------------------------------------------------------------------
// Brush APIs
//----------------------------------------------------------------------------

  function GdipCloneBrush(brush: GPBRUSH;
    out cloneBrush: GPBRUSH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneBrush}

  function GdipDeleteBrush(brush: GPBRUSH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteBrush}

  function GdipGetBrushType(brush: GPBRUSH;
    out type_: GPBRUSHTYPE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetBrushType}

//----------------------------------------------------------------------------
// HatchBrush APIs
//----------------------------------------------------------------------------

  function GdipCreateHatchBrush(hatchstyle: Integer; forecol: ARGB;
    backcol: ARGB; out brush: GPHATCH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateHatchBrush}

  function GdipGetHatchStyle(brush: GPHATCH;
    out hatchstyle: GPHATCHSTYLE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetHatchStyle}

  function GdipGetHatchForegroundColor(brush: GPHATCH;
    out forecol: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetHatchForegroundColor}

  function GdipGetHatchBackgroundColor(brush: GPHATCH;
    out backcol: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetHatchBackgroundColor}

//----------------------------------------------------------------------------
// TextureBrush APIs
//----------------------------------------------------------------------------


  function GdipCreateTexture(image: GPIMAGE; wrapmode: GPWRAPMODE;
    var texture: GPTEXTURE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateTexture}

  function GdipCreateTexture2(image: GPIMAGE; wrapmode: GPWRAPMODE;
    x: Single; y: Single; width: Single; height: Single;
    out texture: GPTEXTURE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateTexture2}

  function GdipCreateTextureIA(image: GPIMAGE;
    imageAttributes: GPIMAGEATTRIBUTES; x: Single; y: Single; width: Single;
    height: Single; out texture: GPTEXTURE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateTextureIA}

  function GdipCreateTexture2I(image: GPIMAGE; wrapmode: GPWRAPMODE; x: Integer;
    y: Integer; width: Integer; height: Integer;
    out texture: GPTEXTURE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateTexture2I}

  function GdipCreateTextureIAI(image: GPIMAGE;
    imageAttributes: GPIMAGEATTRIBUTES; x: Integer; y: Integer; width: Integer;
    height: Integer; out texture: GPTEXTURE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateTextureIAI}

  function GdipGetTextureTransform(brush: GPTEXTURE;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetTextureTransform}

  function GdipSetTextureTransform(brush: GPTEXTURE;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetTextureTransform}

  function GdipResetTextureTransform(brush: GPTEXTURE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetTextureTransform}

  function GdipMultiplyTextureTransform(brush: GPTEXTURE; matrix: GPMATRIX;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMultiplyTextureTransform}

  function GdipTranslateTextureTransform(brush: GPTEXTURE; dx: Single;
    dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslateTextureTransform}

  function GdipScaleTextureTransform(brush: GPTEXTURE; sx: Single; sy: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipScaleTextureTransform}

  function GdipRotateTextureTransform(brush: GPTEXTURE; angle: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRotateTextureTransform}

  function GdipSetTextureWrapMode(brush: GPTEXTURE;
    wrapmode: GPWRAPMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetTextureWrapMode}

  function GdipGetTextureWrapMode(brush: GPTEXTURE;
    var wrapmode: GPWRAPMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetTextureWrapMode}

  function GdipGetTextureImage(brush: GPTEXTURE;
    out image: GPIMAGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetTextureImage}

//----------------------------------------------------------------------------
// SolidBrush APIs
//----------------------------------------------------------------------------

  function GdipCreateSolidFill(color: ARGB;
    out brush: GPSOLIDFILL): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateSolidFill}

  function GdipSetSolidFillColor(brush: GPSOLIDFILL;
    color: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetSolidFillColor}

  function GdipGetSolidFillColor(brush: GPSOLIDFILL;
    out color: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetSolidFillColor}

//----------------------------------------------------------------------------
// LineBrush APIs
//----------------------------------------------------------------------------

  function GdipCreateLineBrush(point1: GPPOINTF; point2: GPPOINTF; color1: ARGB;
    color2: ARGB; wrapMode: GPWRAPMODE;
    out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateLineBrush}

  function GdipCreateLineBrushI(point1: GPPOINT; point2: GPPOINT; color1: ARGB;
    color2: ARGB; wrapMode: GPWRAPMODE;
    out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateLineBrushI}

  function GdipCreateLineBrushFromRect(rect: GPRECTF; color1: ARGB;
    color2: ARGB; mode: LINEARGRADIENTMODE; wrapMode: GPWRAPMODE;
    out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateLineBrushFromRect}

  function GdipCreateLineBrushFromRectI(rect: GPRECT; color1: ARGB;
    color2: ARGB; mode: LINEARGRADIENTMODE; wrapMode: GPWRAPMODE;
    out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateLineBrushFromRectI}

  function GdipCreateLineBrushFromRectWithAngle(rect: GPRECTF; color1: ARGB;
    color2: ARGB; angle: Single; isAngleScalable: Bool; wrapMode: GPWRAPMODE;
    out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateLineBrushFromRectWithAngle}

  function GdipCreateLineBrushFromRectWithAngleI(rect: GPRECT; color1: ARGB;
    color2: ARGB; angle: Single; isAngleScalable: Bool; wrapMode: GPWRAPMODE;
    out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateLineBrushFromRectWithAngleI}

  function GdipSetLineColors(brush: GPLINEGRADIENT; color1: ARGB;
    color2: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetLineColors}

  function GdipGetLineColors(brush: GPLINEGRADIENT;
    colors: PARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineColors}

  function GdipGetLineRect(brush: GPLINEGRADIENT;
    rect: GPRECTF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineRect}

  function GdipGetLineRectI(brush: GPLINEGRADIENT;
    rect: GPRECT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineRectI}

  function GdipSetLineGammaCorrection(brush: GPLINEGRADIENT;
    useGammaCorrection: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetLineGammaCorrection}

  function GdipGetLineGammaCorrection(brush: GPLINEGRADIENT;
    out useGammaCorrection: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineGammaCorrection}

  function GdipGetLineBlendCount(brush: GPLINEGRADIENT;
    out count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineBlendCount}

  function GdipGetLineBlend(brush: GPLINEGRADIENT; blend: PSingle;
    positions: PSingle; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineBlend}

  function GdipSetLineBlend(brush: GPLINEGRADIENT; blend: PSingle;
    positions: PSingle; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetLineBlend}

  function GdipGetLinePresetBlendCount(brush: GPLINEGRADIENT;
    out count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLinePresetBlendCount}

  function GdipGetLinePresetBlend(brush: GPLINEGRADIENT; blend: PARGB;
    positions: PSingle; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLinePresetBlend}

  function GdipSetLinePresetBlend(brush: GPLINEGRADIENT; blend: PARGB;
    positions: PSingle; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetLinePresetBlend}

  function GdipSetLineSigmaBlend(brush: GPLINEGRADIENT; focus: Single;
    scale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetLineSigmaBlend}

  function GdipSetLineLinearBlend(brush: GPLINEGRADIENT; focus: Single;
    scale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetLineLinearBlend}

  function GdipSetLineWrapMode(brush: GPLINEGRADIENT;
    wrapmode: GPWRAPMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetLineWrapMode}

  function GdipGetLineWrapMode(brush: GPLINEGRADIENT;
    out wrapmode: GPWRAPMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineWrapMode}

  function GdipGetLineTransform(brush: GPLINEGRADIENT;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineTransform}

  function GdipSetLineTransform(brush: GPLINEGRADIENT;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetLineTransform}

  function GdipResetLineTransform(brush: GPLINEGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetLineTransform}

  function GdipMultiplyLineTransform(brush: GPLINEGRADIENT; matrix: GPMATRIX;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMultiplyLineTransform}

  function GdipTranslateLineTransform(brush: GPLINEGRADIENT; dx: Single;
    dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslateLineTransform}

  function GdipScaleLineTransform(brush: GPLINEGRADIENT; sx: Single; sy: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipScaleLineTransform}

  function GdipRotateLineTransform(brush: GPLINEGRADIENT; angle: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRotateLineTransform}

//----------------------------------------------------------------------------
// PathGradientBrush APIs
//----------------------------------------------------------------------------

  function GdipCreatePathGradient(points: GPPOINTF; count: Integer;
    wrapMode: GPWRAPMODE; out polyGradient: GPPATHGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePathGradient}

  function GdipCreatePathGradientI(points: GPPOINT; count: Integer;
    wrapMode: GPWRAPMODE; out polyGradient: GPPATHGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePathGradientI}

  function GdipCreatePathGradientFromPath(path: GPPATH;
    out polyGradient: GPPATHGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePathGradientFromPath}

  function GdipGetPathGradientCenterColor(brush: GPPATHGRADIENT;
    out colors: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientCenterColor}

  function GdipSetPathGradientCenterColor(brush: GPPATHGRADIENT;
    colors: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientCenterColor}

  function GdipGetPathGradientSurroundColorsWithCount(brush: GPPATHGRADIENT;
    color: PARGB; var count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientSurroundColorsWithCount}

  function GdipSetPathGradientSurroundColorsWithCount(brush: GPPATHGRADIENT;
    color: PARGB; var count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientSurroundColorsWithCount}

  function GdipGetPathGradientPath(brush: GPPATHGRADIENT;
    path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientPath}

  function GdipSetPathGradientPath(brush: GPPATHGRADIENT;
    path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientPath}

  function GdipGetPathGradientCenterPoint(brush: GPPATHGRADIENT;
    points: GPPOINTF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientCenterPoint}

  function GdipGetPathGradientCenterPointI(brush: GPPATHGRADIENT;
    points: GPPOINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientCenterPointI}

  function GdipSetPathGradientCenterPoint(brush: GPPATHGRADIENT;
    points: GPPOINTF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientCenterPoint}

  function GdipSetPathGradientCenterPointI(brush: GPPATHGRADIENT;
    points: GPPOINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientCenterPointI}

  function GdipGetPathGradientRect(brush: GPPATHGRADIENT;
    rect: GPRECTF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientRect}

  function GdipGetPathGradientRectI(brush: GPPATHGRADIENT;
    rect: GPRECT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientRectI}

  function GdipGetPathGradientPointCount(brush: GPPATHGRADIENT;
    var count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientPointCount}

  function GdipGetPathGradientSurroundColorCount(brush: GPPATHGRADIENT;
    var count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientSurroundColorCount}

  function GdipSetPathGradientGammaCorrection(brush: GPPATHGRADIENT;
    useGammaCorrection: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientGammaCorrection}

  function GdipGetPathGradientGammaCorrection(brush: GPPATHGRADIENT;
    var useGammaCorrection: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientGammaCorrection}

  function GdipGetPathGradientBlendCount(brush: GPPATHGRADIENT;
    var count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientBlendCount}

  function GdipGetPathGradientBlend(brush: GPPATHGRADIENT;
    blend: PSingle; positions: PSingle; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientBlend}

  function GdipSetPathGradientBlend(brush: GPPATHGRADIENT;
    blend: PSingle; positions: PSingle; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientBlend}

  function GdipGetPathGradientPresetBlendCount(brush: GPPATHGRADIENT;
    var count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientPresetBlendCount}

  function GdipGetPathGradientPresetBlend(brush: GPPATHGRADIENT;
    blend: PARGB; positions: PSingle; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientPresetBlend}

  function GdipSetPathGradientPresetBlend(brush: GPPATHGRADIENT;
    blend: PARGB; positions: PSingle; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientPresetBlend}

  function GdipSetPathGradientSigmaBlend(brush: GPPATHGRADIENT;
    focus: Single; scale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientSigmaBlend}

  function GdipSetPathGradientLinearBlend(brush: GPPATHGRADIENT;
    focus: Single; scale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientLinearBlend}

  function GdipGetPathGradientWrapMode(brush: GPPATHGRADIENT;
    var wrapmode: GPWRAPMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientWrapMode}

  function GdipSetPathGradientWrapMode(brush: GPPATHGRADIENT;
    wrapmode: GPWRAPMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientWrapMode}

  function GdipGetPathGradientTransform(brush: GPPATHGRADIENT;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientTransform}

  function GdipSetPathGradientTransform(brush: GPPATHGRADIENT;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientTransform}

  function GdipResetPathGradientTransform(
    brush: GPPATHGRADIENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetPathGradientTransform}

  function GdipMultiplyPathGradientTransform(brush: GPPATHGRADIENT;
    matrix: GPMATRIX; order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMultiplyPathGradientTransform}

  function GdipTranslatePathGradientTransform(brush: GPPATHGRADIENT;
    dx: Single; dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslatePathGradientTransform}

  function GdipScalePathGradientTransform(brush: GPPATHGRADIENT;
    sx: Single; sy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipScalePathGradientTransform}

  function GdipRotatePathGradientTransform(brush: GPPATHGRADIENT;
    angle: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRotatePathGradientTransform}

  function GdipGetPathGradientFocusScales(brush: GPPATHGRADIENT;
    var xScale: Single; var yScale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPathGradientFocusScales}

  function GdipSetPathGradientFocusScales(brush: GPPATHGRADIENT;
    xScale: Single; yScale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPathGradientFocusScales}

//----------------------------------------------------------------------------
// Pen APIs
//----------------------------------------------------------------------------

  function GdipCreatePen1(color: ARGB; width: Single; unit_: GPUNIT;
    out pen: GPPEN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePen1}

  function GdipCreatePen2(brush: GPBRUSH; width: Single; unit_: GPUNIT;
    out pen: GPPEN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreatePen2}

  function GdipClonePen(pen: GPPEN; out clonepen: GPPEN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipClonePen}

  function GdipDeletePen(pen: GPPEN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeletePen}

  function GdipSetPenWidth(pen: GPPEN; width: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenWidth}

  function GdipGetPenWidth(pen: GPPEN; out width: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenWidth}

  function GdipSetPenUnit(pen: GPPEN; unit_: GPUNIT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenUnit}

  function GdipGetPenUnit(pen: GPPEN; var unit_: GPUNIT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenUnit}

  function GdipSetPenLineCap197819(pen: GPPEN; startCap: GPLINECAP;
    endCap: GPLINECAP; dashCap: GPDASHCAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenLineCap197819}

  function GdipSetPenStartCap(pen: GPPEN;
    startCap: GPLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenStartCap}

  function GdipSetPenEndCap(pen: GPPEN; endCap: GPLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenEndCap}

  function GdipSetPenDashCap197819(pen: GPPEN;
    dashCap: GPDASHCAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenDashCap197819}

  function GdipGetPenStartCap(pen: GPPEN;
    out startCap: GPLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenStartCap}

  function GdipGetPenEndCap(pen: GPPEN;
    out endCap: GPLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenEndCap}

  function GdipGetPenDashCap197819(pen: GPPEN;
    out dashCap: GPDASHCAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenDashCap197819}

  function GdipSetPenLineJoin(pen: GPPEN;
    lineJoin: GPLINEJOIN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenLineJoin}

  function GdipGetPenLineJoin(pen: GPPEN;
    var lineJoin: GPLINEJOIN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenLineJoin}

  function GdipSetPenCustomStartCap(pen: GPPEN;
    customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenCustomStartCap}

  function GdipGetPenCustomStartCap(pen: GPPEN;
    out customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenCustomStartCap}

  function GdipSetPenCustomEndCap(pen: GPPEN;
    customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenCustomEndCap}

  function GdipGetPenCustomEndCap(pen: GPPEN;
    out customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenCustomEndCap}

  function GdipSetPenMiterLimit(pen: GPPEN;
    miterLimit: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenMiterLimit}

  function GdipGetPenMiterLimit(pen: GPPEN;
    out miterLimit: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenMiterLimit}

  function GdipSetPenMode(pen: GPPEN;
    penMode: GPPENALIGNMENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenMode}

  function GdipGetPenMode(pen: GPPEN;
    var penMode: GPPENALIGNMENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenMode}

  function GdipSetPenTransform(pen: GPPEN;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenTransform}

  function GdipGetPenTransform(pen: GPPEN;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenTransform}

  function GdipResetPenTransform(pen: GPPEN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetPenTransform}

  function GdipMultiplyPenTransform(pen: GPPEN; matrix: GPMATRIX;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMultiplyPenTransform}

  function GdipTranslatePenTransform(pen: GPPEN; dx: Single; dy: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslatePenTransform}

  function GdipScalePenTransform(pen: GPPEN; sx: Single; sy: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipScalePenTransform}

  function GdipRotatePenTransform(pen: GPPEN; angle: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRotatePenTransform}

  function GdipSetPenColor(pen: GPPEN; argb: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenColor}

  function GdipGetPenColor(pen: GPPEN; out argb: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenColor}

  function GdipSetPenBrushFill(pen: GPPEN; brush: GPBRUSH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenBrushFill}

  function GdipGetPenBrushFill(pen: GPPEN;
    out brush: GPBRUSH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenBrushFill}

  function GdipGetPenFillType(pen: GPPEN;
    out type_: GPPENTYPE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenFillType}

  function GdipGetPenDashStyle(pen: GPPEN;
    out dashstyle: GPDASHSTYLE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenDashStyle}

  function GdipSetPenDashStyle(pen: GPPEN;
    dashstyle: GPDASHSTYLE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenDashStyle}

  function GdipGetPenDashOffset(pen: GPPEN;
    out offset: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenDashOffset}

  function GdipSetPenDashOffset(pen: GPPEN; offset: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenDashOffset}

  function GdipGetPenDashCount(pen: GPPEN;
    var count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenDashCount}

  function GdipSetPenDashArray(pen: GPPEN; dash: PSingle;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenDashArray}

  function GdipGetPenDashArray(pen: GPPEN; dash: PSingle;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenDashArray}

  function GdipGetPenCompoundCount(pen: GPPEN;
    out count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenCompoundCount}

  function GdipSetPenCompoundArray(pen: GPPEN; dash: PSingle;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPenCompoundArray}

  function GdipGetPenCompoundArray(pen: GPPEN; dash: PSingle;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPenCompoundArray}

//----------------------------------------------------------------------------
// CustomLineCap APIs
//----------------------------------------------------------------------------

  function GdipCreateCustomLineCap(fillPath: GPPATH; strokePath: GPPATH;
    baseCap: GPLINECAP; baseInset: Single;
    out customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateCustomLineCap}

  function GdipDeleteCustomLineCap(
    customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteCustomLineCap}

  function GdipCloneCustomLineCap(customCap: GPCUSTOMLINECAP;
    out clonedCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneCustomLineCap}

  function GdipGetCustomLineCapType(customCap: GPCUSTOMLINECAP;
    var capType: CUSTOMLINECAPTYPE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCustomLineCapType}

  function GdipSetCustomLineCapStrokeCaps(customCap: GPCUSTOMLINECAP;
    startCap: GPLINECAP; endCap: GPLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetCustomLineCapStrokeCaps}

  function GdipGetCustomLineCapStrokeCaps(customCap: GPCUSTOMLINECAP;
    var startCap: GPLINECAP; var endCap: GPLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCustomLineCapStrokeCaps}

  function GdipSetCustomLineCapStrokeJoin(customCap: GPCUSTOMLINECAP;
  lineJoin: GPLINEJOIN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetCustomLineCapStrokeJoin}

  function GdipGetCustomLineCapStrokeJoin(customCap: GPCUSTOMLINECAP;
  var lineJoin: GPLINEJOIN): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCustomLineCapStrokeJoin}

  function GdipSetCustomLineCapBaseCap(customCap: GPCUSTOMLINECAP;
  baseCap: GPLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetCustomLineCapBaseCap}

  function GdipGetCustomLineCapBaseCap(customCap: GPCUSTOMLINECAP;
  var baseCap: GPLINECAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCustomLineCapBaseCap}

  function GdipSetCustomLineCapBaseInset(customCap: GPCUSTOMLINECAP;
  inset: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetCustomLineCapBaseInset}

  function GdipGetCustomLineCapBaseInset(customCap: GPCUSTOMLINECAP;
  var inset: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCustomLineCapBaseInset}

  function GdipSetCustomLineCapWidthScale(customCap: GPCUSTOMLINECAP;
  widthScale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetCustomLineCapWidthScale}

  function GdipGetCustomLineCapWidthScale(customCap: GPCUSTOMLINECAP;
  var widthScale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCustomLineCapWidthScale}

//----------------------------------------------------------------------------
// AdjustableArrowCap APIs
//----------------------------------------------------------------------------

  function GdipCreateAdjustableArrowCap(height: Single;
  width: Single;
  isFilled: Bool;
  out cap: GPADJUSTABLEARROWCAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateAdjustableArrowCap}

  function GdipSetAdjustableArrowCapHeight(cap: GPADJUSTABLEARROWCAP;
  height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetAdjustableArrowCapHeight}

  function GdipGetAdjustableArrowCapHeight(cap: GPADJUSTABLEARROWCAP;
  var height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetAdjustableArrowCapHeight}

  function GdipSetAdjustableArrowCapWidth(cap: GPADJUSTABLEARROWCAP;
  width: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetAdjustableArrowCapWidth}

  function GdipGetAdjustableArrowCapWidth(cap: GPADJUSTABLEARROWCAP;
  var width: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetAdjustableArrowCapWidth}

  function GdipSetAdjustableArrowCapMiddleInset(cap: GPADJUSTABLEARROWCAP;
  middleInset: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetAdjustableArrowCapMiddleInset}

  function GdipGetAdjustableArrowCapMiddleInset(cap: GPADJUSTABLEARROWCAP;
  var middleInset: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetAdjustableArrowCapMiddleInset}

  function GdipSetAdjustableArrowCapFillState(cap: GPADJUSTABLEARROWCAP;
  fillState: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetAdjustableArrowCapFillState}

  function GdipGetAdjustableArrowCapFillState(cap: GPADJUSTABLEARROWCAP;
  var fillState: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetAdjustableArrowCapFillState}

//---------------------------------------------------------------------------- 
// Image APIs
//----------------------------------------------------------------------------

  function GdipLoadImageFromStream(stream: ISTREAM;
  out image: GPIMAGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipLoadImageFromStream}

  function GdipLoadImageFromFile(filename: PWCHAR;
  out image: GPIMAGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipLoadImageFromFile}

  function GdipLoadImageFromStreamICM(stream: ISTREAM;
  out image: GPIMAGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipLoadImageFromStreamICM}

  function GdipLoadImageFromFileICM(filename: PWCHAR;
  out image: GPIMAGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipLoadImageFromFileICM}

  function GdipCloneImage(image: GPIMAGE;
  out cloneImage: GPIMAGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneImage}

  function GdipDisposeImage(image: GPIMAGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDisposeImage}

  function GdipSaveImageToFile(image: GPIMAGE;
  filename: PWCHAR;
  clsidEncoder: PGUID;
  encoderParams: PENCODERPARAMETERS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSaveImageToFile}

  function GdipSaveImageToStream(image: GPIMAGE;
  stream: ISTREAM;
  clsidEncoder: PGUID;
  encoderParams: PENCODERPARAMETERS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSaveImageToStream}

  function GdipSaveAdd(image: GPIMAGE;
  encoderParams: PENCODERPARAMETERS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSaveAdd}

  function GdipSaveAddImage(image: GPIMAGE;
  newImage: GPIMAGE;
  encoderParams: PENCODERPARAMETERS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSaveAddImage}

  function GdipGetImageGraphicsContext(image: GPIMAGE;
  out graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageGraphicsContext}

  function GdipGetImageBounds(image: GPIMAGE;
  srcRect: GPRECTF;
  var srcUnit: GPUNIT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageBounds}

  function GdipGetImageDimension(image: GPIMAGE;
  var width: Single;
  var height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageDimension}

  function GdipGetImageType(image: GPIMAGE;
  var type_: IMAGETYPE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageType}

  function GdipGetImageWidth(image: GPIMAGE;
  var width: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageWidth}

  function GdipGetImageHeight(image: GPIMAGE;
  var height: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageHeight}

  function GdipGetImageHorizontalResolution(image: GPIMAGE;
  var resolution: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageHorizontalResolution}

  function GdipGetImageVerticalResolution(image: GPIMAGE;
  var resolution: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageVerticalResolution}

  function GdipGetImageFlags(image: GPIMAGE;
  var flags: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageFlags}

  function GdipGetImageRawFormat(image: GPIMAGE;
  format: PGUID): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageRawFormat}

  function GdipGetImagePixelFormat(image: GPIMAGE;
  out format: TPIXELFORMAT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImagePixelFormat}

  function GdipGetImageThumbnail(image: GPIMAGE; thumbWidth: UINT;
    thumbHeight: UINT; out thumbImage: GPIMAGE;
    callback: GETTHUMBNAILIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageThumbnail}

  function GdipGetEncoderParameterListSize(image: GPIMAGE;
    clsidEncoder: PGUID; out size: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetEncoderParameterListSize}

  function GdipGetEncoderParameterList(image: GPIMAGE; clsidEncoder: PGUID;
    size: UINT; buffer: PENCODERPARAMETERS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetEncoderParameterList}

  function GdipImageGetFrameDimensionsCount(image: GPIMAGE;
    var count: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipImageGetFrameDimensionsCount}

  function GdipImageGetFrameDimensionsList(image: GPIMAGE; dimensionIDs: PGUID;
    count: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipImageGetFrameDimensionsList}

  function GdipImageGetFrameCount(image: GPIMAGE; dimensionID: PGUID;
    var count: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipImageGetFrameCount}

  function GdipImageSelectActiveFrame(image: GPIMAGE; dimensionID: PGUID;
    frameIndex: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipImageSelectActiveFrame}

  function GdipImageRotateFlip(image: GPIMAGE;
    rfType: ROTATEFLIPTYPE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipImageRotateFlip}

  function GdipGetImagePalette(image: GPIMAGE; palette: PCOLORPALETTE;
    size: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImagePalette}

  function GdipSetImagePalette(image: GPIMAGE;
    palette: PCOLORPALETTE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImagePalette}

  function GdipGetImagePaletteSize(image: GPIMAGE;
    var size: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImagePaletteSize}

  function GdipGetPropertyCount(image: GPIMAGE;
    var numOfProperty: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPropertyCount}

  function GdipGetPropertyIdList(image: GPIMAGE; numOfProperty: UINT;
    list: PPROPID): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPropertyIdList}

  function GdipGetPropertyItemSize(image: GPIMAGE; propId: PROPID;
    var size: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPropertyItemSize}

  function GdipGetPropertyItem(image: GPIMAGE; propId: PROPID; propSize: UINT;
    buffer: PPROPERTYITEM): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPropertyItem}

  function GdipGetPropertySize(image: GPIMAGE; var totalBufferSize: UINT;
    var numProperties: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPropertySize}

  function GdipGetAllPropertyItems(image: GPIMAGE; totalBufferSize: UINT;
    numProperties: UINT; allItems: PPROPERTYITEM): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetAllPropertyItems}

  function GdipRemovePropertyItem(image: GPIMAGE;
    propId: PROPID): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRemovePropertyItem}

  function GdipSetPropertyItem(image: GPIMAGE;
    item: PPROPERTYITEM): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPropertyItem}

  function GdipImageForceValidation(image: GPIMAGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipImageForceValidation}

//---------------------------------------------------------------------------- 
// Bitmap APIs
//----------------------------------------------------------------------------

  function GdipCreateBitmapFromStream(stream: ISTREAM;
    out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromStream}

  function GdipCreateBitmapFromFile(filename: PWCHAR;
    out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromFile}

  function GdipCreateBitmapFromStreamICM(stream: ISTREAM;
    out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromStreamICM}

  function GdipCreateBitmapFromFileICM(filename: PWCHAR;
    var bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromFileICM}

  function GdipCreateBitmapFromScan0(width: Integer; height: Integer;
    stride: Integer; format: PIXELFORMAT; scan0: PBYTE;
    out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromScan0}

  function GdipCreateBitmapFromGraphics(width: Integer; height: Integer;
    target: GPGRAPHICS; out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromGraphics}

  function GdipCreateBitmapFromDirectDrawSurface(surface: IDIRECTDRAWSURFACE7;
    out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromDirectDrawSurface}

  function GdipCreateBitmapFromGdiDib(gdiBitmapInfo: PBitmapInfo;
    gdiBitmapData: Pointer; out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromGdiDib}

  function GdipCreateBitmapFromHBITMAP(hbm: HBITMAP; hpal: HPALETTE;
    out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromHBITMAP}

  function GdipCreateHBITMAPFromBitmap(bitmap: GPBITMAP; out hbmReturn: HBITMAP;
    background: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateHBITMAPFromBitmap}

  function GdipCreateBitmapFromHICON(hicon: HICON;
    out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromHICON}

  function GdipCreateHICONFromBitmap(bitmap: GPBITMAP;
    out hbmReturn: HICON): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateHICONFromBitmap}

  function GdipCreateBitmapFromResource(hInstance: HMODULE;
    lpBitmapName: PWCHAR; out bitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateBitmapFromResource}

  function GdipCloneBitmapArea(x: Single; y: Single; width: Single;
    height: Single; format: PIXELFORMAT; srcBitmap: GPBITMAP;
    out dstBitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneBitmapArea}

  function GdipCloneBitmapAreaI(x: Integer; y: Integer; width: Integer;
    height: Integer; format: PIXELFORMAT; srcBitmap: GPBITMAP;
    out dstBitmap: GPBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneBitmapAreaI}

  function GdipBitmapLockBits(bitmap: GPBITMAP; rect: GPRECT; flags: UINT;
    format: PIXELFORMAT; lockedBitmapData: PBITMAPDATA): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipBitmapLockBits}

  function GdipBitmapUnlockBits(bitmap: GPBITMAP;
    lockedBitmapData: PBITMAPDATA): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipBitmapUnlockBits}

  function GdipBitmapGetPixel(bitmap: GPBITMAP; x: Integer; y: Integer;
    var color: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipBitmapGetPixel}

  function GdipBitmapSetPixel(bitmap: GPBITMAP; x: Integer; y: Integer;
    color: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipBitmapSetPixel}

  function GdipBitmapSetResolution(bitmap: GPBITMAP; xdpi: Single;
    ydpi: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipBitmapSetResolution}

//----------------------------------------------------------------------------
// ImageAttributes APIs
//----------------------------------------------------------------------------

  function GdipCreateImageAttributes(
    out imageattr: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateImageAttributes}

  function GdipCloneImageAttributes(imageattr: GPIMAGEATTRIBUTES;
    out cloneImageattr: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneImageAttributes}

  function GdipDisposeImageAttributes(
    imageattr: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDisposeImageAttributes}

  function GdipSetImageAttributesToIdentity(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesToIdentity}

  function GdipResetImageAttributes(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetImageAttributes}

  function GdipSetImageAttributesColorMatrix(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE; enableFlag: Bool; colorMatrix: PCOLORMATRIX;
    grayMatrix: PCOLORMATRIX; flags: COLORMATRIXFLAGS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesColorMatrix}

  function GdipSetImageAttributesThreshold(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE; enableFlag: Bool;
    threshold: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesThreshold}

  function GdipSetImageAttributesGamma(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE; enableFlag: Bool; gamma: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesGamma}

  function GdipSetImageAttributesNoOp(imageattr: GPIMAGEATTRIBUTES;
  type_: COLORADJUSTTYPE; enableFlag: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesNoOp}

  function GdipSetImageAttributesColorKeys(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE; enableFlag: Bool; colorLow: ARGB;
    colorHigh: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesColorKeys}

  function GdipSetImageAttributesOutputChannel(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE; enableFlag: Bool;
    channelFlags: COLORCHANNELFLAGS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesOutputChannel}

  function GdipSetImageAttributesOutputChannelColorProfile(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE; enableFlag: Bool;
    colorProfileFilename: PWCHAR): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesOutputChannelColorProfile}

  function GdipSetImageAttributesRemapTable(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE; enableFlag: Bool; mapSize: UINT;
    map: PCOLORMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesRemapTable}

  function GdipSetImageAttributesWrapMode(imageAttr: GPIMAGEATTRIBUTES;
    wrap: WRAPMODE; argb: ARGB; clamp: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesWrapMode}

  function GdipSetImageAttributesICMMode(imageAttr: GPIMAGEATTRIBUTES;
    on_: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetImageAttributesICMMode}

  function GdipGetImageAttributesAdjustedPalette(imageAttr: GPIMAGEATTRIBUTES;
    colorPalette: PCOLORPALETTE;
    colorAdjustType: COLORADJUSTTYPE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageAttributesAdjustedPalette}

//----------------------------------------------------------------------------
// Graphics APIs
//----------------------------------------------------------------------------

  function GdipFlush(graphics: GPGRAPHICS;
    intention: GPFLUSHINTENTION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFlush}

  function GdipCreateFromHDC(hdc: HDC;
    out graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFromHDC}

  function GdipCreateFromHDC2(hdc: HDC; hDevice: THandle;
    out graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFromHDC2}

  function GdipCreateFromHWND(hwnd: HWND;
    out graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFromHWND}

  function GdipCreateFromHWNDICM(hwnd: HWND;
    out graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFromHWNDICM}

  function GdipDeleteGraphics(graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteGraphics}

  function GdipGetDC(graphics: GPGRAPHICS; var hdc: HDC): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetDC}

  function GdipReleaseDC(graphics: GPGRAPHICS; hdc: HDC): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipReleaseDC}

  function GdipSetCompositingMode(graphics: GPGRAPHICS;
    compositingMode: COMPOSITINGMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetCompositingMode}

  function GdipGetCompositingMode(graphics: GPGRAPHICS;
    var compositingMode: COMPOSITINGMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCompositingMode}

  function GdipSetRenderingOrigin(graphics: GPGRAPHICS; x: Integer;
    y: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetRenderingOrigin}

  function GdipGetRenderingOrigin(graphics: GPGRAPHICS; var x: Integer;
    var y: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetRenderingOrigin}

  function GdipSetCompositingQuality(graphics: GPGRAPHICS;
    compositingQuality: COMPOSITINGQUALITY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetCompositingQuality}

  function GdipGetCompositingQuality(graphics: GPGRAPHICS;
    var compositingQuality: COMPOSITINGQUALITY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCompositingQuality}

  function GdipSetSmoothingMode(graphics: GPGRAPHICS;
    smoothingMode: SMOOTHINGMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetSmoothingMode}

  function GdipGetSmoothingMode(graphics: GPGRAPHICS;
    var smoothingMode: SMOOTHINGMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetSmoothingMode}

  function GdipSetPixelOffsetMode(graphics: GPGRAPHICS;
    pixelOffsetMode: PIXELOFFSETMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPixelOffsetMode}

  function GdipGetPixelOffsetMode(graphics: GPGRAPHICS;
    var pixelOffsetMode: PIXELOFFSETMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPixelOffsetMode}

  function GdipSetTextRenderingHint(graphics: GPGRAPHICS;
    mode: TEXTRENDERINGHINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetTextRenderingHint}

  function GdipGetTextRenderingHint(graphics: GPGRAPHICS;
    var mode: TEXTRENDERINGHINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetTextRenderingHint}

  function GdipSetTextContrast(graphics: GPGRAPHICS;
    contrast: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetTextContrast}

  function GdipGetTextContrast(graphics: GPGRAPHICS;
    var contrast: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetTextContrast}

  function GdipSetInterpolationMode(graphics: GPGRAPHICS;
    interpolationMode: INTERPOLATIONMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetInterpolationMode}

  function GdipGetInterpolationMode(graphics: GPGRAPHICS;
    var interpolationMode: INTERPOLATIONMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetInterpolationMode}

  function GdipSetWorldTransform(graphics: GPGRAPHICS;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetWorldTransform}

  function GdipResetWorldTransform(graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetWorldTransform}

  function GdipMultiplyWorldTransform(graphics: GPGRAPHICS; matrix: GPMATRIX;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMultiplyWorldTransform}

  function GdipTranslateWorldTransform(graphics: GPGRAPHICS; dx: Single;
    dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslateWorldTransform}

  function GdipScaleWorldTransform(graphics: GPGRAPHICS; sx: Single; sy: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipScaleWorldTransform}

  function GdipRotateWorldTransform(graphics: GPGRAPHICS; angle: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRotateWorldTransform}

  function GdipGetWorldTransform(graphics: GPGRAPHICS;
    matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetWorldTransform}

  function GdipResetPageTransform(graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetPageTransform}

  function GdipGetPageUnit(graphics: GPGRAPHICS;
    var unit_: GPUNIT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPageUnit}

  function GdipGetPageScale(graphics: GPGRAPHICS;
    var scale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetPageScale}

  function GdipSetPageUnit(graphics: GPGRAPHICS;
    unit_: GPUNIT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPageUnit}

  function GdipSetPageScale(graphics: GPGRAPHICS;
    scale: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetPageScale}

  function GdipGetDpiX(graphics: GPGRAPHICS;
    var dpi: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetDpiX}

  function GdipGetDpiY(graphics: GPGRAPHICS;
    var dpi: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetDpiY}

  function GdipTransformPoints(graphics: GPGRAPHICS;
    destSpace: GPCOORDINATESPACE; srcSpace: GPCOORDINATESPACE;
    points: GPPOINTF; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTransformPoints}

  function GdipTransformPointsI(graphics: GPGRAPHICS;
    destSpace: GPCOORDINATESPACE; srcSpace: GPCOORDINATESPACE;
    points: GPPOINT; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTransformPointsI}

  function GdipGetNearestColor(graphics: GPGRAPHICS;
    argb: PARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetNearestColor}

// Creates the Win9x Halftone Palette (even on NT) with correct Desktop colors

  function GdipCreateHalftonePalette: HPALETTE; stdcall;
  {$EXTERNALSYM GdipCreateHalftonePalette}

  function GdipDrawLine(graphics: GPGRAPHICS; pen: GPPEN; x1: Single;
    y1: Single; x2: Single; y2: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawLine}

  function GdipDrawLineI(graphics: GPGRAPHICS; pen: GPPEN; x1: Integer;
    y1: Integer; x2: Integer; y2: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawLineI}

  function GdipDrawLines(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawLines}

  function GdipDrawLinesI(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawLinesI}

  function GdipDrawArc(graphics: GPGRAPHICS; pen: GPPEN; x: Single; y: Single;
    width: Single; height: Single; startAngle: Single;
    sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawArc}

  function GdipDrawArcI(graphics: GPGRAPHICS; pen: GPPEN; x: Integer;
    y: Integer; width: Integer; height: Integer; startAngle: Single;
    sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawArcI}

  function GdipDrawBezier(graphics: GPGRAPHICS; pen: GPPEN; x1: Single;
    y1: Single; x2: Single; y2: Single; x3: Single; y3: Single; x4: Single;
    y4: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawBezier}

  function GdipDrawBezierI(graphics: GPGRAPHICS; pen: GPPEN; x1: Integer;
    y1: Integer; x2: Integer; y2: Integer; x3: Integer; y3: Integer;
    x4: Integer; y4: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawBezierI}

  function GdipDrawBeziers(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawBeziers}

  function GdipDrawBeziersI(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawBeziersI}

  function GdipDrawRectangle(graphics: GPGRAPHICS; pen: GPPEN; x: Single;
    y: Single; width: Single; height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawRectangle}

  function GdipDrawRectangleI(graphics: GPGRAPHICS; pen: GPPEN; x: Integer;
    y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawRectangleI}

  function GdipDrawRectangles(graphics: GPGRAPHICS; pen: GPPEN; rects: GPRECTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawRectangles}

  function GdipDrawRectanglesI(graphics: GPGRAPHICS; pen: GPPEN; rects: GPRECT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawRectanglesI}

  function GdipDrawEllipse(graphics: GPGRAPHICS; pen: GPPEN; x: Single;
    y: Single; width: Single; height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawEllipse}

  function GdipDrawEllipseI(graphics: GPGRAPHICS; pen: GPPEN; x: Integer;
    y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawEllipseI}

  function GdipDrawPie(graphics: GPGRAPHICS; pen: GPPEN; x: Single; y: Single;
    width: Single;  height: Single; startAngle: Single;
    sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawPie}

  function GdipDrawPieI(graphics: GPGRAPHICS; pen: GPPEN; x: Integer;
    y: Integer; width: Integer; height: Integer; startAngle: Single;
    sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawPieI}

  function GdipDrawPolygon(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawPolygon}

  function GdipDrawPolygonI(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawPolygonI}

  function GdipDrawPath(graphics: GPGRAPHICS; pen: GPPEN;
    path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawPath}

  function GdipDrawCurve(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINTF;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawCurve}

  function GdipDrawCurveI(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINT;
    count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawCurveI}

  function GdipDrawCurve2(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINTF;
    count: Integer; tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawCurve2}

  function GdipDrawCurve2I(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINT;
    count: Integer; tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawCurve2I}

  function GdipDrawCurve3(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINTF;
    count: Integer; offset: Integer; numberOfSegments: Integer;
    tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawCurve3}

  function GdipDrawCurve3I(graphics: GPGRAPHICS; pen: GPPEN; points: GPPOINT;
    count: Integer; offset: Integer; numberOfSegments: Integer;
    tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawCurve3I}

  function GdipDrawClosedCurve(graphics: GPGRAPHICS; pen: GPPEN;
    points: GPPOINTF; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawClosedCurve}

  function GdipDrawClosedCurveI(graphics: GPGRAPHICS; pen: GPPEN;
    points: GPPOINT; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawClosedCurveI}

  function GdipDrawClosedCurve2(graphics: GPGRAPHICS; pen: GPPEN;
    points: GPPOINTF; count: Integer; tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawClosedCurve2}

  function GdipDrawClosedCurve2I(graphics: GPGRAPHICS; pen: GPPEN;
    points: GPPOINT; count: Integer; tension: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawClosedCurve2I}

  function GdipGraphicsClear(graphics: GPGRAPHICS;
    color: ARGB): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGraphicsClear}

  function GdipFillRectangle(graphics: GPGRAPHICS; brush: GPBRUSH; x: Single;
    y: Single; width: Single; height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillRectangle}

  function GdipFillRectangleI(graphics: GPGRAPHICS; brush: GPBRUSH; x: Integer;
    y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillRectangleI}

  function GdipFillRectangles(graphics: GPGRAPHICS; brush: GPBRUSH;
    rects: GPRECTF; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillRectangles}

  function GdipFillRectanglesI(graphics: GPGRAPHICS; brush: GPBRUSH;
    rects: GPRECT; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillRectanglesI}

  function GdipFillPolygon(graphics: GPGRAPHICS; brush: GPBRUSH;
    points: GPPOINTF; count: Integer; fillMode: GPFILLMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillPolygon}

  function GdipFillPolygonI(graphics: GPGRAPHICS; brush: GPBRUSH;
    points: GPPOINT; count: Integer; fillMode: GPFILLMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillPolygonI}

  function GdipFillPolygon2(graphics: GPGRAPHICS; brush: GPBRUSH;
    points: GPPOINTF; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillPolygon2}

  function GdipFillPolygon2I(graphics: GPGRAPHICS; brush: GPBRUSH;
    points: GPPOINT; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillPolygon2I}

  function GdipFillEllipse(graphics: GPGRAPHICS; brush: GPBRUSH; x: Single;
    y: Single; width: Single; height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillEllipse}

  function GdipFillEllipseI(graphics: GPGRAPHICS; brush: GPBRUSH; x: Integer;
    y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillEllipseI}

  function GdipFillPie(graphics: GPGRAPHICS; brush: GPBRUSH; x: Single;
    y: Single; width: Single; height: Single; startAngle: Single;
    sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillPie}

  function GdipFillPieI(graphics: GPGRAPHICS; brush: GPBRUSH; x: Integer;
    y: Integer; width: Integer; height: Integer; startAngle: Single;
    sweepAngle: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillPieI}

  function GdipFillPath(graphics: GPGRAPHICS; brush: GPBRUSH;
    path: GPPATH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillPath}

  function GdipFillClosedCurve(graphics: GPGRAPHICS; brush: GPBRUSH;
    points: GPPOINTF; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillClosedCurve}

  function GdipFillClosedCurveI(graphics: GPGRAPHICS; brush: GPBRUSH;
    points: GPPOINT; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillClosedCurveI}

  function GdipFillClosedCurve2(graphics: GPGRAPHICS; brush: GPBRUSH;
    points: GPPOINTF; count: Integer; tension: Single;
    fillMode: GPFILLMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillClosedCurve2}

  function GdipFillClosedCurve2I(graphics: GPGRAPHICS; brush: GPBRUSH;
    points: GPPOINT; count: Integer; tension: Single;
    fillMode: GPFILLMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillClosedCurve2I}

  function GdipFillRegion(graphics: GPGRAPHICS; brush: GPBRUSH;
    region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFillRegion}

  function GdipDrawImage(graphics: GPGRAPHICS; image: GPIMAGE; x: Single;
    y: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImage}

  function GdipDrawImageI(graphics: GPGRAPHICS; image: GPIMAGE; x: Integer;
    y: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImageI}

  function GdipDrawImageRect(graphics: GPGRAPHICS; image: GPIMAGE; x: Single;
    y: Single; width: Single; height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImageRect}

  function GdipDrawImageRectI(graphics: GPGRAPHICS; image: GPIMAGE; x: Integer;
    y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImageRectI}

  function GdipDrawImagePoints(graphics: GPGRAPHICS; image: GPIMAGE;
    dstpoints: GPPOINTF; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImagePoints}

  function GdipDrawImagePointsI(graphics: GPGRAPHICS; image: GPIMAGE;
    dstpoints: GPPOINT; count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImagePointsI}

  function GdipDrawImagePointRect(graphics: GPGRAPHICS; image: GPIMAGE;
    x: Single; y: Single; srcx: Single; srcy: Single; srcwidth: Single;
    srcheight: Single; srcUnit: GPUNIT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImagePointRect}

  function GdipDrawImagePointRectI(graphics: GPGRAPHICS; image: GPIMAGE;
    x: Integer; y: Integer; srcx: Integer; srcy: Integer; srcwidth: Integer;
    srcheight: Integer; srcUnit: GPUNIT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImagePointRectI}

  function GdipDrawImageRectRect(graphics: GPGRAPHICS; image: GPIMAGE;
    dstx: Single; dsty: Single; dstwidth: Single; dstheight: Single;
    srcx: Single; srcy: Single; srcwidth: Single; srcheight: Single;
    srcUnit: GPUNIT; imageAttributes: GPIMAGEATTRIBUTES;
    callback: DRAWIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImageRectRect}

  function GdipDrawImageRectRectI(graphics: GPGRAPHICS; image: GPIMAGE;
    dstx: Integer; dsty: Integer; dstwidth: Integer; dstheight: Integer;
    srcx: Integer; srcy: Integer; srcwidth: Integer; srcheight: Integer;
    srcUnit: GPUNIT; imageAttributes: GPIMAGEATTRIBUTES;
    callback: DRAWIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImageRectRectI}

  function GdipDrawImagePointsRect(graphics: GPGRAPHICS; image: GPIMAGE;
    points: GPPOINTF; count: Integer; srcx: Single; srcy: Single;
    srcwidth: Single; srcheight: Single; srcUnit: GPUNIT;
    imageAttributes: GPIMAGEATTRIBUTES; callback: DRAWIMAGEABORT;
    callbackData: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImagePointsRect}

  function GdipDrawImagePointsRectI(graphics: GPGRAPHICS; image: GPIMAGE;
    points: GPPOINT; count: Integer; srcx: Integer; srcy: Integer;
    srcwidth: Integer; srcheight: Integer; srcUnit: GPUNIT;
    imageAttributes: GPIMAGEATTRIBUTES; callback: DRAWIMAGEABORT;
    callbackData: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawImagePointsRectI}

  function GdipEnumerateMetafileDestPoint(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destPoint: PGPPointF; callback: ENUMERATEMETAFILEPROC;
    callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileDestPoint}

  function GdipEnumerateMetafileDestPointI(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destPoint: PGPPoint; callback: ENUMERATEMETAFILEPROC;
    callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileDestPointI}

  function GdipEnumerateMetafileDestRect(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destRect: PGPRectF; callback: ENUMERATEMETAFILEPROC;
    callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileDestRect}

  function GdipEnumerateMetafileDestRectI(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destRect: PGPRect; callback: ENUMERATEMETAFILEPROC;
    callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileDestRectI}

  function GdipEnumerateMetafileDestPoints(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destPoints: PGPPointF; count: Integer;
    callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileDestPoints}

  function GdipEnumerateMetafileDestPointsI(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destPoints: PGPPoint; count: Integer;
    callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileDestPointsI}

  function GdipEnumerateMetafileSrcRectDestPoint(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destPoint: PGPPointF; srcRect: PGPRectF; srcUnit: TUNIT;
    callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileSrcRectDestPoint}

  function GdipEnumerateMetafileSrcRectDestPointI(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destPoint: PGPPoint; srcRect: PGPRect; srcUnit: TUNIT;
    callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileSrcRectDestPointI}

  function GdipEnumerateMetafileSrcRectDestRect(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destRect: PGPRectF; srcRect: PGPRectF; srcUnit: TUNIT;
    callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileSrcRectDestRect}

  function GdipEnumerateMetafileSrcRectDestRectI(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destRect: PGPRect; srcRect: PGPRect; srcUnit: TUNIT;
    callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileSrcRectDestRectI}

  function GdipEnumerateMetafileSrcRectDestPoints(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destPoints: PGPPointF; count: Integer; srcRect: PGPRectF;
    srcUnit: TUNIT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileSrcRectDestPoints}

  function GdipEnumerateMetafileSrcRectDestPointsI(graphics: GPGRAPHICS;
    metafile: GPMETAFILE; destPoints: PGPPoint; count: Integer; srcRect: PGPRect;
    srcUnit: TUNIT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;
    imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEnumerateMetafileSrcRectDestPointsI}

  function GdipPlayMetafileRecord(metafile: GPMETAFILE;
    recordType: EMFPLUSRECORDTYPE; flags: UINT; dataSize: UINT;
    data: PBYTE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPlayMetafileRecord}

  function GdipSetClipGraphics(graphics: GPGRAPHICS; srcgraphics: GPGRAPHICS;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetClipGraphics}

  function GdipSetClipRect(graphics: GPGRAPHICS; x: Single; y: Single;
    width: Single; height: Single; combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetClipRect}

  function GdipSetClipRectI(graphics: GPGRAPHICS; x: Integer; y: Integer;
    width: Integer; height: Integer;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetClipRectI}

  function GdipSetClipPath(graphics: GPGRAPHICS; path: GPPATH;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetClipPath}

  function GdipSetClipRegion(graphics: GPGRAPHICS; region: GPREGION;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetClipRegion}

  function GdipSetClipHrgn(graphics: GPGRAPHICS; hRgn: HRGN;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetClipHrgn}

  function GdipResetClip(graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipResetClip}

  function GdipTranslateClip(graphics: GPGRAPHICS; dx: Single;
    dy: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslateClip}

  function GdipTranslateClipI(graphics: GPGRAPHICS; dx: Integer;
    dy: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipTranslateClipI}

  function GdipGetClip(graphics: GPGRAPHICS;
    region: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetClip}

  function GdipGetClipBounds(graphics: GPGRAPHICS;
    rect: GPRECTF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetClipBounds}

  function GdipGetClipBoundsI(graphics: GPGRAPHICS;
    rect: GPRECT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetClipBoundsI}

  function GdipIsClipEmpty(graphics: GPGRAPHICS;
    result: PBool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsClipEmpty}

  function GdipGetVisibleClipBounds(graphics: GPGRAPHICS;
    rect: GPRECTF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetVisibleClipBounds}

  function GdipGetVisibleClipBoundsI(graphics: GPGRAPHICS;
    rect: GPRECT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetVisibleClipBoundsI}

  function GdipIsVisibleClipEmpty(graphics: GPGRAPHICS;
    var result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisibleClipEmpty}

  function GdipIsVisiblePoint(graphics: GPGRAPHICS; x: Single; y: Single;
    var result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisiblePoint}

  function GdipIsVisiblePointI(graphics: GPGRAPHICS; x: Integer; y: Integer;
    var result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisiblePointI}

  function GdipIsVisibleRect(graphics: GPGRAPHICS; x: Single; y: Single;
    width: Single; height: Single; var result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisibleRect}

  function GdipIsVisibleRectI(graphics: GPGRAPHICS; x: Integer; y: Integer;
    width: Integer; height: Integer; var result: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsVisibleRectI}

  function GdipSaveGraphics(graphics: GPGRAPHICS;
    var state: GRAPHICSSTATE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSaveGraphics}

  function GdipRestoreGraphics(graphics: GPGRAPHICS;
    state: GRAPHICSSTATE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRestoreGraphics}

  function GdipBeginContainer(graphics: GPGRAPHICS; dstrect: GPRECTF;
    srcrect: GPRECTF; unit_: GPUNIT;
    var state: GRAPHICSCONTAINER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipBeginContainer}

  function GdipBeginContainerI(graphics: GPGRAPHICS; dstrect: GPRECT;
    srcrect: GPRECT; unit_: GPUNIT;
    var state: GRAPHICSCONTAINER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipBeginContainerI}

  function GdipBeginContainer2(graphics: GPGRAPHICS;
    var state: GRAPHICSCONTAINER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipBeginContainer2}

  function GdipEndContainer(graphics: GPGRAPHICS;
    state: GRAPHICSCONTAINER): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipEndContainer}

  function GdipGetMetafileHeaderFromWmf(hWmf: HMETAFILE;
    wmfPlaceableFileHeader: PWMFPLACEABLEFILEHEADER;
    header: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetMetafileHeaderFromWmf}

  function GdipGetMetafileHeaderFromEmf(hEmf: HENHMETAFILE;
    header: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetMetafileHeaderFromEmf}

  function GdipGetMetafileHeaderFromFile(filename: PWCHAR;
    header: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetMetafileHeaderFromFile}

  function GdipGetMetafileHeaderFromStream(stream: ISTREAM;
    header: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetMetafileHeaderFromStream}

  function GdipGetMetafileHeaderFromMetafile(metafile: GPMETAFILE;
    header: Pointer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetMetafileHeaderFromMetafile}

  function GdipGetHemfFromMetafile(metafile: GPMETAFILE;
    var hEmf: HENHMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetHemfFromMetafile}

  function GdipCreateStreamOnFile(filename: PWCHAR; access: UINT;
    out stream: ISTREAM): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateStreamOnFile}

  function GdipCreateMetafileFromWmf(hWmf: HMETAFILE; deleteWmf: Bool;
    wmfPlaceableFileHeader: PWMFPLACEABLEFILEHEADER;
    out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMetafileFromWmf}

  function GdipCreateMetafileFromEmf(hEmf: HENHMETAFILE; deleteEmf: Bool;
    out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMetafileFromEmf}

  function GdipCreateMetafileFromFile(file_: PWCHAR;
    out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMetafileFromFile}

  function GdipCreateMetafileFromWmfFile(file_: PWCHAR;
    wmfPlaceableFileHeader: PWMFPLACEABLEFILEHEADER;
    out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMetafileFromWmfFile}

  function GdipCreateMetafileFromStream(stream: ISTREAM;
    out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateMetafileFromStream}

  function GdipRecordMetafile(referenceHdc: HDC; type_: EMFTYPE;
    frameRect: GPRECTF; frameUnit: METAFILEFRAMEUNIT;
    description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRecordMetafile}

  function GdipRecordMetafileI(referenceHdc: HDC; type_: EMFTYPE;
    frameRect: GPRECT; frameUnit: METAFILEFRAMEUNIT; description: PWCHAR;
    out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRecordMetafileI}

  function GdipRecordMetafileFileName(fileName: PWCHAR; referenceHdc: HDC;
    type_: EMFTYPE; frameRect: GPRECTF; frameUnit: METAFILEFRAMEUNIT;
    description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRecordMetafileFileName}

  function GdipRecordMetafileFileNameI(fileName: PWCHAR; referenceHdc: HDC;
    type_: EMFTYPE; frameRect: GPRECT; frameUnit: METAFILEFRAMEUNIT;
    description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRecordMetafileFileNameI}

  function GdipRecordMetafileStream(stream: ISTREAM; referenceHdc: HDC;
    type_: EMFTYPE; frameRect: GPRECTF; frameUnit: METAFILEFRAMEUNIT;
    description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRecordMetafileStream}

  function GdipRecordMetafileStreamI(stream: ISTREAM; referenceHdc: HDC;
    type_: EMFTYPE; frameRect: GPRECT; frameUnit: METAFILEFRAMEUNIT;
    description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipRecordMetafileStreamI}

  function GdipSetMetafileDownLevelRasterizationLimit(metafile: GPMETAFILE;
    metafileRasterizationLimitDpi: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetMetafileDownLevelRasterizationLimit}

  function GdipGetMetafileDownLevelRasterizationLimit(metafile: GPMETAFILE;
    var metafileRasterizationLimitDpi: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetMetafileDownLevelRasterizationLimit}

  function GdipGetImageDecodersSize(out numDecoders: UINT;
    out size: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageDecodersSize}

  function GdipGetImageDecoders(numDecoders: UINT; size: UINT;
    decoders: PIMAGECODECINFO): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageDecoders}

  function GdipGetImageEncodersSize(out numEncoders: UINT;
    out size: UINT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageEncodersSize}

  function GdipGetImageEncoders(numEncoders: UINT; size: UINT;
    encoders: PIMAGECODECINFO): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetImageEncoders}

  function GdipComment(graphics: GPGRAPHICS; sizeData: UINT;
    data: PBYTE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipComment}

//----------------------------------------------------------------------------
// FontFamily APIs
//----------------------------------------------------------------------------

  function GdipCreateFontFamilyFromName(name: PWCHAR;
    fontCollection: GPFONTCOLLECTION;
    out FontFamily: GPFONTFAMILY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFontFamilyFromName}

  function GdipDeleteFontFamily(FontFamily: GPFONTFAMILY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteFontFamily}

  function GdipCloneFontFamily(FontFamily: GPFONTFAMILY;
    out clonedFontFamily: GPFONTFAMILY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneFontFamily}

  function GdipGetGenericFontFamilySansSerif(
    out nativeFamily: GPFONTFAMILY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetGenericFontFamilySansSerif}

  function GdipGetGenericFontFamilySerif(
    out nativeFamily: GPFONTFAMILY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetGenericFontFamilySerif}

  function GdipGetGenericFontFamilyMonospace(
    out nativeFamily: GPFONTFAMILY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetGenericFontFamilyMonospace}

  function GdipGetFamilyName(family: GPFONTFAMILY; name: PWideChar;
    language: LANGID): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFamilyName}

  function GdipIsStyleAvailable(family: GPFONTFAMILY; style: Integer;
    var IsStyleAvailable: Bool): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipIsStyleAvailable}

  function GdipFontCollectionEnumerable(fontCollection: GPFONTCOLLECTION;
    graphics: GPGRAPHICS; var numFound: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFontCollectionEnumerable}

  function GdipFontCollectionEnumerate(fontCollection: GPFONTCOLLECTION;
    numSought: Integer; gpfamilies: array of GPFONTFAMILY;
    var numFound: Integer; graphics: GPGRAPHICS): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipFontCollectionEnumerate}

  function GdipGetEmHeight(family: GPFONTFAMILY; style: Integer;
    out EmHeight: UINT16): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetEmHeight}

  function GdipGetCellAscent(family: GPFONTFAMILY; style: Integer;
    var CellAscent: UINT16): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCellAscent}

  function GdipGetCellDescent(family: GPFONTFAMILY; style: Integer;
    var CellDescent: UINT16): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetCellDescent}

  function GdipGetLineSpacing(family: GPFONTFAMILY; style: Integer;
    var LineSpacing: UINT16): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLineSpacing}

//----------------------------------------------------------------------------
// Font APIs
//----------------------------------------------------------------------------

  function GdipCreateFontFromDC(hdc: HDC; out font: GPFONT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFontFromDC}

  function GdipCreateFontFromLogfontA(hdc: HDC; logfont: PLOGFONTA;
    out font: GPFONT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFontFromLogfontA}

  function GdipCreateFontFromLogfontW(hdc: HDC; logfont: PLOGFONTW;
    out font: GPFONT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFontFromLogfontW}

  function GdipCreateFont(fontFamily: GPFONTFAMILY; emSize: Single;
    style: Integer; unit_: Integer; out font: GPFONT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateFont}

  function GdipCloneFont(font: GPFONT;
    out cloneFont: GPFONT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneFont}

  function GdipDeleteFont(font: GPFONT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteFont}

  function GdipGetFamily(font: GPFONT;
    out family: GPFONTFAMILY): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFamily}

  function GdipGetFontStyle(font: GPFONT;
    var style: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFontStyle}

  function GdipGetFontSize(font: GPFONT; var size: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFontSize}

  function GdipGetFontUnit(font: GPFONT; var unit_: TUNIT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFontUnit}

  function GdipGetFontHeight(font: GPFONT; graphics: GPGRAPHICS;
    var height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFontHeight}

  function GdipGetFontHeightGivenDPI(font: GPFONT; dpi: Single;
    var height: Single): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFontHeightGivenDPI}

  function GdipGetLogFontA(font: GPFONT; graphics: GPGRAPHICS;
    var logfontA: LOGFONTA): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLogFontA}

  function GdipGetLogFontW(font: GPFONT; graphics: GPGRAPHICS;
    var logfontW: LOGFONTW): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetLogFontW}

  function GdipNewInstalledFontCollection(
    out fontCollection: GPFONTCOLLECTION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipNewInstalledFontCollection}

  function GdipNewPrivateFontCollection(
    out fontCollection: GPFONTCOLLECTION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipNewPrivateFontCollection}

  function GdipDeletePrivateFontCollection(
    out fontCollection: GPFONTCOLLECTION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeletePrivateFontCollection}

  function GdipGetFontCollectionFamilyCount(fontCollection: GPFONTCOLLECTION;
    var numFound: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFontCollectionFamilyCount}

  function GdipGetFontCollectionFamilyList(fontCollection: GPFONTCOLLECTION;
    numSought: Integer; gpfamilies: GPFONTFAMILY;
    var numFound: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetFontCollectionFamilyList}

  function GdipPrivateAddFontFile(fontCollection: GPFONTCOLLECTION;
    filename: PWCHAR): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPrivateAddFontFile}

  function GdipPrivateAddMemoryFont(fontCollection: GPFONTCOLLECTION;
    memory: Pointer; length: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipPrivateAddMemoryFont}

//----------------------------------------------------------------------------
// Text APIs
//----------------------------------------------------------------------------

  function GdipDrawString(graphics: GPGRAPHICS; string_: PWCHAR;
    length: Integer; font: GPFONT; layoutRect: PGPRectF;
    stringFormat: GPSTRINGFORMAT; brush: GPBRUSH): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawString}

  function GdipMeasureString(graphics: GPGRAPHICS; string_: PWCHAR;
    length: Integer; font: GPFONT; layoutRect: PGPRectF;
    stringFormat: GPSTRINGFORMAT; boundingBox: PGPRectF;
    codepointsFitted: PInteger; linesFilled: PInteger): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMeasureString}

  function GdipMeasureCharacterRanges(graphics: GPGRAPHICS; string_: PWCHAR;
    length: Integer; font: GPFONT; layoutRect: PGPRectF;
    stringFormat: GPSTRINGFORMAT; regionCount: Integer;
    const regions: GPREGION): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMeasureCharacterRanges}

  function GdipDrawDriverString(graphics: GPGRAPHICS; const text: PUINT16;
    length: Integer; const font: GPFONT; const brush: GPBRUSH;
    const positions: PGPPointF; flags: Integer;
    const matrix: GPMATRIX): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawDriverString}

  function GdipMeasureDriverString(graphics: GPGRAPHICS; text: PUINT16;
    length: Integer; font: GPFONT; positions: PGPPointF; flags: Integer;
    matrix: GPMATRIX; boundingBox: PGPRectF): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipMeasureDriverString}

//----------------------------------------------------------------------------
// String format APIs
//----------------------------------------------------------------------------

  function GdipCreateStringFormat(formatAttributes: Integer; language: LANGID;
    out format: GPSTRINGFORMAT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateStringFormat}

  function GdipStringFormatGetGenericDefault(
    out format: GPSTRINGFORMAT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipStringFormatGetGenericDefault}

  function GdipStringFormatGetGenericTypographic(
    out format: GPSTRINGFORMAT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipStringFormatGetGenericTypographic}

  function GdipDeleteStringFormat(format: GPSTRINGFORMAT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteStringFormat}

  function GdipCloneStringFormat(format: GPSTRINGFORMAT;
    out newFormat: GPSTRINGFORMAT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCloneStringFormat}

  function GdipSetStringFormatFlags(format: GPSTRINGFORMAT;
    flags: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetStringFormatFlags}

  function GdipGetStringFormatFlags(format: GPSTRINGFORMAT;
    out flags: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatFlags}

  function GdipSetStringFormatAlign(format: GPSTRINGFORMAT;
    align: STRINGALIGNMENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetStringFormatAlign}

  function GdipGetStringFormatAlign(format: GPSTRINGFORMAT;
    out align: STRINGALIGNMENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatAlign}

  function GdipSetStringFormatLineAlign(format: GPSTRINGFORMAT;
    align: STRINGALIGNMENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetStringFormatLineAlign}

  function GdipGetStringFormatLineAlign(format: GPSTRINGFORMAT;
    out align: STRINGALIGNMENT): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatLineAlign}

  function GdipSetStringFormatTrimming(format: GPSTRINGFORMAT;
    trimming: STRINGTRIMMING): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetStringFormatTrimming}

  function GdipGetStringFormatTrimming(format: GPSTRINGFORMAT;
    out trimming: STRINGTRIMMING): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatTrimming}

  function GdipSetStringFormatHotkeyPrefix(format: GPSTRINGFORMAT;
    hotkeyPrefix: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetStringFormatHotkeyPrefix}

  function GdipGetStringFormatHotkeyPrefix(format: GPSTRINGFORMAT;
    out hotkeyPrefix: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatHotkeyPrefix}

  function GdipSetStringFormatTabStops(format: GPSTRINGFORMAT;
    firstTabOffset: Single; count: Integer;
    tabStops: PSingle): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetStringFormatTabStops}

  function GdipGetStringFormatTabStops(format: GPSTRINGFORMAT;
    count: Integer; firstTabOffset: PSingle;
    tabStops: PSingle): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatTabStops}

  function GdipGetStringFormatTabStopCount(format: GPSTRINGFORMAT;
    out count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatTabStopCount}

  function GdipSetStringFormatDigitSubstitution(format: GPSTRINGFORMAT;
    language: LANGID;
    substitute: STRINGDIGITSUBSTITUTE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetStringFormatDigitSubstitution}

  function GdipGetStringFormatDigitSubstitution(format: GPSTRINGFORMAT;
    language: PUINT; substitute: PSTRINGDIGITSUBSTITUTE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatDigitSubstitution}

  function GdipGetStringFormatMeasurableCharacterRangeCount(format: GPSTRINGFORMAT;
    out count: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipGetStringFormatMeasurableCharacterRangeCount}

  function GdipSetStringFormatMeasurableCharacterRanges(format: GPSTRINGFORMAT;
    rangeCount: Integer; ranges: PCHARACTERRANGE): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipSetStringFormatMeasurableCharacterRanges}

//----------------------------------------------------------------------------
// Cached Bitmap APIs
//----------------------------------------------------------------------------

  function GdipCreateCachedBitmap(bitmap: GPBITMAP; graphics: GPGRAPHICS;
    out cachedBitmap: GPCACHEDBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipCreateCachedBitmap}

  function GdipDeleteCachedBitmap(
    cachedBitmap: GPCACHEDBITMAP): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDeleteCachedBitmap}

  function GdipDrawCachedBitmap(graphics: GPGRAPHICS;
    cachedBitmap: GPCACHEDBITMAP; x: Integer;
    y: Integer): GPSTATUS; stdcall;
  {$EXTERNALSYM GdipDrawCachedBitmap}

  function GdipEmfToWmfBits(hemf: HENHMETAFILE; cbData16: UINT; pData16: PBYTE;
    iMapMode: Integer; eFlags: Integer): UINT; stdcall;
  {$EXTERNALSYM GdipEmfToWmfBits}

implementation

function GdipAlloc; external WINGDIPDLL name 'GdipAlloc' delayed;
procedure GdipFree; external WINGDIPDLL name 'GdipFree' delayed;
function GdiplusStartup; external WINGDIPDLL name 'GdiplusStartup' delayed;
procedure GdiplusShutdown; external WINGDIPDLL name 'GdiplusShutdown' delayed;

function GdipCreatePath; external WINGDIPDLL name 'GdipCreatePath' delayed;
function GdipCreatePath2; external WINGDIPDLL name 'GdipCreatePath2' delayed;
function GdipCreatePath2I; external WINGDIPDLL name 'GdipCreatePath2I' delayed;
function GdipClonePath; external WINGDIPDLL name 'GdipClonePath' delayed;
function GdipDeletePath; external WINGDIPDLL name 'GdipDeletePath' delayed;
function GdipResetPath; external WINGDIPDLL name 'GdipResetPath' delayed;
function GdipGetPointCount; external WINGDIPDLL name 'GdipGetPointCount' delayed;
function GdipGetPathTypes; external WINGDIPDLL name 'GdipGetPathTypes' delayed;
function GdipGetPathPoints; external WINGDIPDLL name 'GdipGetPathPoints' delayed;
function GdipGetPathPointsI; external WINGDIPDLL name 'GdipGetPathPointsI' delayed;
function GdipGetPathFillMode; external WINGDIPDLL name 'GdipGetPathFillMode' delayed;
function GdipSetPathFillMode; external WINGDIPDLL name 'GdipSetPathFillMode' delayed;
function GdipGetPathData; external WINGDIPDLL name 'GdipGetPathData' delayed;
function GdipStartPathFigure; external WINGDIPDLL name 'GdipStartPathFigure' delayed;
function GdipClosePathFigure; external WINGDIPDLL name 'GdipClosePathFigure' delayed;
function GdipClosePathFigures; external WINGDIPDLL name 'GdipClosePathFigures' delayed;
function GdipSetPathMarker; external WINGDIPDLL name 'GdipSetPathMarker' delayed;
function GdipClearPathMarkers; external WINGDIPDLL name 'GdipClearPathMarkers' delayed;
function GdipReversePath; external WINGDIPDLL name 'GdipReversePath' delayed;
function GdipGetPathLastPoint; external WINGDIPDLL name 'GdipGetPathLastPoint' delayed;
function GdipAddPathLine; external WINGDIPDLL name 'GdipAddPathLine' delayed;
function GdipAddPathLine2; external WINGDIPDLL name 'GdipAddPathLine2' delayed;
function GdipAddPathArc; external WINGDIPDLL name 'GdipAddPathArc' delayed;
function GdipAddPathBezier; external WINGDIPDLL name 'GdipAddPathBezier' delayed;
function GdipAddPathBeziers; external WINGDIPDLL name 'GdipAddPathBeziers' delayed;
function GdipAddPathCurve; external WINGDIPDLL name 'GdipAddPathCurve' delayed;
function GdipAddPathCurve2; external WINGDIPDLL name 'GdipAddPathCurve2' delayed;
function GdipAddPathCurve3; external WINGDIPDLL name 'GdipAddPathCurve3' delayed;
function GdipAddPathClosedCurve; external WINGDIPDLL name 'GdipAddPathClosedCurve' delayed;
function GdipAddPathClosedCurve2; external WINGDIPDLL name 'GdipAddPathClosedCurve2' delayed;
function GdipAddPathRectangle; external WINGDIPDLL name 'GdipAddPathRectangle' delayed;
function GdipAddPathRectangles; external WINGDIPDLL name 'GdipAddPathRectangles' delayed;
function GdipAddPathEllipse; external WINGDIPDLL name 'GdipAddPathEllipse' delayed;
function GdipAddPathPie; external WINGDIPDLL name 'GdipAddPathPie' delayed;
function GdipAddPathPolygon; external WINGDIPDLL name 'GdipAddPathPolygon' delayed;
function GdipAddPathPath; external WINGDIPDLL name 'GdipAddPathPath' delayed;
function GdipAddPathString; external WINGDIPDLL name 'GdipAddPathString' delayed;
function GdipAddPathStringI; external WINGDIPDLL name 'GdipAddPathStringI' delayed;
function GdipAddPathLineI; external WINGDIPDLL name 'GdipAddPathLineI' delayed;
function GdipAddPathLine2I; external WINGDIPDLL name 'GdipAddPathLine2I' delayed;
function GdipAddPathArcI; external WINGDIPDLL name 'GdipAddPathArcI' delayed;
function GdipAddPathBezierI; external WINGDIPDLL name 'GdipAddPathBezierI' delayed;
function GdipAddPathBeziersI; external WINGDIPDLL name 'GdipAddPathBeziersI' delayed;
function GdipAddPathCurveI; external WINGDIPDLL name 'GdipAddPathCurveI' delayed;
function GdipAddPathCurve2I; external WINGDIPDLL name 'GdipAddPathCurve2I' delayed;
function GdipAddPathCurve3I; external WINGDIPDLL name 'GdipAddPathCurve3I' delayed;
function GdipAddPathClosedCurveI; external WINGDIPDLL name 'GdipAddPathClosedCurveI' delayed;
function GdipAddPathClosedCurve2I; external WINGDIPDLL name 'GdipAddPathClosedCurve2I' delayed;
function GdipAddPathRectangleI; external WINGDIPDLL name 'GdipAddPathRectangleI' delayed;
function GdipAddPathRectanglesI; external WINGDIPDLL name 'GdipAddPathRectanglesI' delayed;
function GdipAddPathEllipseI; external WINGDIPDLL name 'GdipAddPathEllipseI' delayed;
function GdipAddPathPieI; external WINGDIPDLL name 'GdipAddPathPieI' delayed;
function GdipAddPathPolygonI; external WINGDIPDLL name 'GdipAddPathPolygonI' delayed;
function GdipFlattenPath; external WINGDIPDLL name 'GdipFlattenPath' delayed;
function GdipWindingModeOutline; external WINGDIPDLL name 'GdipWindingModeOutline' delayed;
function GdipWidenPath; external WINGDIPDLL name 'GdipWidenPath' delayed;
function GdipWarpPath; external WINGDIPDLL name 'GdipWarpPath' delayed;
function GdipTransformPath; external WINGDIPDLL name 'GdipTransformPath' delayed;
function GdipGetPathWorldBounds; external WINGDIPDLL name 'GdipGetPathWorldBounds' delayed;
function GdipGetPathWorldBoundsI; external WINGDIPDLL name 'GdipGetPathWorldBoundsI' delayed;
function GdipIsVisiblePathPoint; external WINGDIPDLL name 'GdipIsVisiblePathPoint' delayed;
function GdipIsVisiblePathPointI; external WINGDIPDLL name 'GdipIsVisiblePathPointI' delayed;
function GdipIsOutlineVisiblePathPoint; external WINGDIPDLL name 'GdipIsOutlineVisiblePathPoint' delayed;
function GdipIsOutlineVisiblePathPointI; external WINGDIPDLL name 'GdipIsOutlineVisiblePathPointI' delayed;
function GdipCreatePathIter; external WINGDIPDLL name 'GdipCreatePathIter' delayed;
function GdipDeletePathIter; external WINGDIPDLL name 'GdipDeletePathIter' delayed;
function GdipPathIterNextSubpath; external WINGDIPDLL name 'GdipPathIterNextSubpath' delayed;
function GdipPathIterNextSubpathPath; external WINGDIPDLL name 'GdipPathIterNextSubpathPath' delayed;
function GdipPathIterNextPathType; external WINGDIPDLL name 'GdipPathIterNextPathType' delayed;
function GdipPathIterNextMarker; external WINGDIPDLL name 'GdipPathIterNextMarker' delayed;
function GdipPathIterNextMarkerPath; external WINGDIPDLL name 'GdipPathIterNextMarkerPath' delayed;
function GdipPathIterGetCount; external WINGDIPDLL name 'GdipPathIterGetCount' delayed;
function GdipPathIterGetSubpathCount; external WINGDIPDLL name 'GdipPathIterGetSubpathCount' delayed;
function GdipPathIterIsValid; external WINGDIPDLL name 'GdipPathIterIsValid' delayed;
function GdipPathIterHasCurve; external WINGDIPDLL name 'GdipPathIterHasCurve' delayed;
function GdipPathIterRewind; external WINGDIPDLL name 'GdipPathIterRewind' delayed;
function GdipPathIterEnumerate; external WINGDIPDLL name 'GdipPathIterEnumerate' delayed;
function GdipPathIterCopyData; external WINGDIPDLL name 'GdipPathIterCopyData' delayed;
function GdipCreateMatrix; external WINGDIPDLL name 'GdipCreateMatrix' delayed;
function GdipCreateMatrix2; external WINGDIPDLL name 'GdipCreateMatrix2' delayed;
function GdipCreateMatrix3; external WINGDIPDLL name 'GdipCreateMatrix3' delayed;
function GdipCreateMatrix3I; external WINGDIPDLL name 'GdipCreateMatrix3I' delayed;
function GdipCloneMatrix; external WINGDIPDLL name 'GdipCloneMatrix' delayed;
function GdipDeleteMatrix; external WINGDIPDLL name 'GdipDeleteMatrix' delayed;
function GdipSetMatrixElements; external WINGDIPDLL name 'GdipSetMatrixElements' delayed;
function GdipMultiplyMatrix; external WINGDIPDLL name 'GdipMultiplyMatrix' delayed;
function GdipTranslateMatrix; external WINGDIPDLL name 'GdipTranslateMatrix' delayed;
function GdipScaleMatrix; external WINGDIPDLL name 'GdipScaleMatrix' delayed;
function GdipRotateMatrix; external WINGDIPDLL name 'GdipRotateMatrix' delayed;
function GdipShearMatrix; external WINGDIPDLL name 'GdipShearMatrix' delayed;
function GdipInvertMatrix; external WINGDIPDLL name 'GdipInvertMatrix' delayed;
function GdipTransformMatrixPoints; external WINGDIPDLL name 'GdipTransformMatrixPoints' delayed;
function GdipTransformMatrixPointsI; external WINGDIPDLL name 'GdipTransformMatrixPointsI' delayed;
function GdipVectorTransformMatrixPoints; external WINGDIPDLL name 'GdipVectorTransformMatrixPoints' delayed;
function GdipVectorTransformMatrixPointsI; external WINGDIPDLL name 'GdipVectorTransformMatrixPointsI' delayed;
function GdipGetMatrixElements; external WINGDIPDLL name 'GdipGetMatrixElements' delayed;
function GdipIsMatrixInvertible; external WINGDIPDLL name 'GdipIsMatrixInvertible' delayed;
function GdipIsMatrixIdentity; external WINGDIPDLL name 'GdipIsMatrixIdentity' delayed;
function GdipIsMatrixEqual; external WINGDIPDLL name 'GdipIsMatrixEqual' delayed;
function GdipCreateRegion; external WINGDIPDLL name 'GdipCreateRegion' delayed;
function GdipCreateRegionRect; external WINGDIPDLL name 'GdipCreateRegionRect' delayed;
function GdipCreateRegionRectI; external WINGDIPDLL name 'GdipCreateRegionRectI' delayed;
function GdipCreateRegionPath; external WINGDIPDLL name 'GdipCreateRegionPath' delayed;
function GdipCreateRegionRgnData; external WINGDIPDLL name 'GdipCreateRegionRgnData' delayed;
function GdipCreateRegionHrgn; external WINGDIPDLL name 'GdipCreateRegionHrgn' delayed;
function GdipCloneRegion; external WINGDIPDLL name 'GdipCloneRegion' delayed;
function GdipDeleteRegion; external WINGDIPDLL name 'GdipDeleteRegion' delayed;
function GdipSetInfinite; external WINGDIPDLL name 'GdipSetInfinite' delayed;
function GdipSetEmpty; external WINGDIPDLL name 'GdipSetEmpty' delayed;
function GdipCombineRegionRect; external WINGDIPDLL name 'GdipCombineRegionRect' delayed;
function GdipCombineRegionRectI; external WINGDIPDLL name 'GdipCombineRegionRectI' delayed;
function GdipCombineRegionPath; external WINGDIPDLL name 'GdipCombineRegionPath' delayed;
function GdipCombineRegionRegion; external WINGDIPDLL name 'GdipCombineRegionRegion' delayed;
function GdipTranslateRegion; external WINGDIPDLL name 'GdipTranslateRegion' delayed;
function GdipTranslateRegionI; external WINGDIPDLL name 'GdipTranslateRegionI' delayed;
function GdipTransformRegion; external WINGDIPDLL name 'GdipTransformRegion' delayed;
function GdipGetRegionBounds; external WINGDIPDLL name 'GdipGetRegionBounds' delayed;
function GdipGetRegionBoundsI; external WINGDIPDLL name 'GdipGetRegionBoundsI' delayed;
function GdipGetRegionHRgn; external WINGDIPDLL name 'GdipGetRegionHRgn' delayed;
function GdipIsEmptyRegion; external WINGDIPDLL name 'GdipIsEmptyRegion' delayed;
function GdipIsInfiniteRegion; external WINGDIPDLL name 'GdipIsInfiniteRegion' delayed;
function GdipIsEqualRegion; external WINGDIPDLL name 'GdipIsEqualRegion' delayed;
function GdipGetRegionDataSize; external WINGDIPDLL name 'GdipGetRegionDataSize' delayed;
function GdipGetRegionData; external WINGDIPDLL name 'GdipGetRegionData' delayed;
function GdipIsVisibleRegionPoint; external WINGDIPDLL name 'GdipIsVisibleRegionPoint' delayed;
function GdipIsVisibleRegionPointI; external WINGDIPDLL name 'GdipIsVisibleRegionPointI' delayed;
function GdipIsVisibleRegionRect; external WINGDIPDLL name 'GdipIsVisibleRegionRect' delayed;
function GdipIsVisibleRegionRectI; external WINGDIPDLL name 'GdipIsVisibleRegionRectI' delayed;
function GdipGetRegionScansCount; external WINGDIPDLL name 'GdipGetRegionScansCount' delayed;
function GdipGetRegionScans; external WINGDIPDLL name 'GdipGetRegionScans' delayed;
function GdipGetRegionScansI; external WINGDIPDLL name 'GdipGetRegionScansI' delayed;
function GdipCloneBrush; external WINGDIPDLL name 'GdipCloneBrush' delayed;
function GdipDeleteBrush; external WINGDIPDLL name 'GdipDeleteBrush' delayed;
function GdipGetBrushType; external WINGDIPDLL name 'GdipGetBrushType' delayed;
function GdipCreateHatchBrush; external WINGDIPDLL name 'GdipCreateHatchBrush' delayed;
function GdipGetHatchStyle; external WINGDIPDLL name 'GdipGetHatchStyle' delayed;
function GdipGetHatchForegroundColor; external WINGDIPDLL name 'GdipGetHatchForegroundColor' delayed;
function GdipGetHatchBackgroundColor; external WINGDIPDLL name 'GdipGetHatchBackgroundColor' delayed;
function GdipCreateTexture; external WINGDIPDLL name 'GdipCreateTexture' delayed;
function GdipCreateTexture2; external WINGDIPDLL name 'GdipCreateTexture2' delayed;
function GdipCreateTextureIA; external WINGDIPDLL name 'GdipCreateTextureIA' delayed;
function GdipCreateTexture2I; external WINGDIPDLL name 'GdipCreateTexture2I' delayed;
function GdipCreateTextureIAI; external WINGDIPDLL name 'GdipCreateTextureIAI' delayed;
function GdipGetTextureTransform; external WINGDIPDLL name 'GdipGetTextureTransform' delayed;
function GdipSetTextureTransform; external WINGDIPDLL name 'GdipSetTextureTransform' delayed;
function GdipResetTextureTransform; external WINGDIPDLL name 'GdipResetTextureTransform' delayed;
function GdipMultiplyTextureTransform; external WINGDIPDLL name 'GdipMultiplyTextureTransform' delayed;
function GdipTranslateTextureTransform; external WINGDIPDLL name 'GdipTranslateTextureTransform' delayed;
function GdipScaleTextureTransform; external WINGDIPDLL name 'GdipScaleTextureTransform' delayed;
function GdipRotateTextureTransform; external WINGDIPDLL name 'GdipRotateTextureTransform' delayed;
function GdipSetTextureWrapMode; external WINGDIPDLL name 'GdipSetTextureWrapMode' delayed;
function GdipGetTextureWrapMode; external WINGDIPDLL name 'GdipGetTextureWrapMode' delayed;
function GdipGetTextureImage; external WINGDIPDLL name 'GdipGetTextureImage' delayed;
function GdipCreateSolidFill; external WINGDIPDLL name 'GdipCreateSolidFill' delayed;
function GdipSetSolidFillColor; external WINGDIPDLL name 'GdipSetSolidFillColor' delayed;
function GdipGetSolidFillColor; external WINGDIPDLL name 'GdipGetSolidFillColor' delayed;
function GdipCreateLineBrush; external WINGDIPDLL name 'GdipCreateLineBrush' delayed;
function GdipCreateLineBrushI; external WINGDIPDLL name 'GdipCreateLineBrushI' delayed;
function GdipCreateLineBrushFromRect; external WINGDIPDLL name 'GdipCreateLineBrushFromRect' delayed;
function GdipCreateLineBrushFromRectI; external WINGDIPDLL name 'GdipCreateLineBrushFromRectI' delayed;
function GdipCreateLineBrushFromRectWithAngle; external WINGDIPDLL name 'GdipCreateLineBrushFromRectWithAngle' delayed;
function GdipCreateLineBrushFromRectWithAngleI; external WINGDIPDLL name 'GdipCreateLineBrushFromRectWithAngleI' delayed;
function GdipSetLineColors; external WINGDIPDLL name 'GdipSetLineColors' delayed;
function GdipGetLineColors; external WINGDIPDLL name 'GdipGetLineColors' delayed;
function GdipGetLineRect; external WINGDIPDLL name 'GdipGetLineRect' delayed;
function GdipGetLineRectI; external WINGDIPDLL name 'GdipGetLineRectI' delayed;
function GdipSetLineGammaCorrection; external WINGDIPDLL name 'GdipSetLineGammaCorrection' delayed;
function GdipGetLineGammaCorrection; external WINGDIPDLL name 'GdipGetLineGammaCorrection' delayed;
function GdipGetLineBlendCount; external WINGDIPDLL name 'GdipGetLineBlendCount' delayed;
function GdipGetLineBlend; external WINGDIPDLL name 'GdipGetLineBlend' delayed;
function GdipSetLineBlend; external WINGDIPDLL name 'GdipSetLineBlend' delayed;
function GdipGetLinePresetBlendCount; external WINGDIPDLL name 'GdipGetLinePresetBlendCount' delayed;
function GdipGetLinePresetBlend; external WINGDIPDLL name 'GdipGetLinePresetBlend' delayed;
function GdipSetLinePresetBlend; external WINGDIPDLL name 'GdipSetLinePresetBlend' delayed;
function GdipSetLineSigmaBlend; external WINGDIPDLL name 'GdipSetLineSigmaBlend' delayed;
function GdipSetLineLinearBlend; external WINGDIPDLL name 'GdipSetLineLinearBlend' delayed;
function GdipSetLineWrapMode; external WINGDIPDLL name 'GdipSetLineWrapMode' delayed;
function GdipGetLineWrapMode; external WINGDIPDLL name 'GdipGetLineWrapMode' delayed;
function GdipGetLineTransform; external WINGDIPDLL name 'GdipGetLineTransform' delayed;
function GdipSetLineTransform; external WINGDIPDLL name 'GdipSetLineTransform' delayed;
function GdipResetLineTransform; external WINGDIPDLL name 'GdipResetLineTransform' delayed;
function GdipMultiplyLineTransform; external WINGDIPDLL name 'GdipMultiplyLineTransform' delayed;
function GdipTranslateLineTransform; external WINGDIPDLL name 'GdipTranslateLineTransform' delayed;
function GdipScaleLineTransform; external WINGDIPDLL name 'GdipScaleLineTransform' delayed;
function GdipRotateLineTransform; external WINGDIPDLL name 'GdipRotateLineTransform' delayed;
function GdipCreatePathGradient; external WINGDIPDLL name 'GdipCreatePathGradient' delayed;
function GdipCreatePathGradientI; external WINGDIPDLL name 'GdipCreatePathGradientI' delayed;
function GdipCreatePathGradientFromPath; external WINGDIPDLL name 'GdipCreatePathGradientFromPath' delayed;
function GdipGetPathGradientCenterColor; external WINGDIPDLL name 'GdipGetPathGradientCenterColor' delayed;
function GdipSetPathGradientCenterColor; external WINGDIPDLL name 'GdipSetPathGradientCenterColor' delayed;
function GdipGetPathGradientSurroundColorsWithCount; external WINGDIPDLL name 'GdipGetPathGradientSurroundColorsWithCount' delayed;
function GdipSetPathGradientSurroundColorsWithCount; external WINGDIPDLL name 'GdipSetPathGradientSurroundColorsWithCount' delayed;
function GdipGetPathGradientPath; external WINGDIPDLL name 'GdipGetPathGradientPath' delayed;
function GdipSetPathGradientPath; external WINGDIPDLL name 'GdipSetPathGradientPath' delayed;
function GdipGetPathGradientCenterPoint; external WINGDIPDLL name 'GdipGetPathGradientCenterPoint' delayed;
function GdipGetPathGradientCenterPointI; external WINGDIPDLL name 'GdipGetPathGradientCenterPointI' delayed;
function GdipSetPathGradientCenterPoint; external WINGDIPDLL name 'GdipSetPathGradientCenterPoint' delayed;
function GdipSetPathGradientCenterPointI; external WINGDIPDLL name 'GdipSetPathGradientCenterPointI' delayed;
function GdipGetPathGradientRect; external WINGDIPDLL name 'GdipGetPathGradientRect' delayed;
function GdipGetPathGradientRectI; external WINGDIPDLL name 'GdipGetPathGradientRectI' delayed;
function GdipGetPathGradientPointCount; external WINGDIPDLL name 'GdipGetPathGradientPointCount' delayed;
function GdipGetPathGradientSurroundColorCount; external WINGDIPDLL name 'GdipGetPathGradientSurroundColorCount' delayed;
function GdipSetPathGradientGammaCorrection; external WINGDIPDLL name 'GdipSetPathGradientGammaCorrection' delayed;
function GdipGetPathGradientGammaCorrection; external WINGDIPDLL name 'GdipGetPathGradientGammaCorrection' delayed;
function GdipGetPathGradientBlendCount; external WINGDIPDLL name 'GdipGetPathGradientBlendCount' delayed;
function GdipGetPathGradientBlend; external WINGDIPDLL name 'GdipGetPathGradientBlend' delayed;
function GdipSetPathGradientBlend; external WINGDIPDLL name 'GdipSetPathGradientBlend' delayed;
function GdipGetPathGradientPresetBlendCount; external WINGDIPDLL name 'GdipGetPathGradientPresetBlendCount' delayed;
function GdipGetPathGradientPresetBlend; external WINGDIPDLL name 'GdipGetPathGradientPresetBlend' delayed;
function GdipSetPathGradientPresetBlend; external WINGDIPDLL name 'GdipSetPathGradientPresetBlend' delayed;
function GdipSetPathGradientSigmaBlend; external WINGDIPDLL name 'GdipSetPathGradientSigmaBlend' delayed;
function GdipSetPathGradientLinearBlend; external WINGDIPDLL name 'GdipSetPathGradientLinearBlend' delayed;
function GdipGetPathGradientWrapMode; external WINGDIPDLL name 'GdipGetPathGradientWrapMode' delayed;
function GdipSetPathGradientWrapMode; external WINGDIPDLL name 'GdipSetPathGradientWrapMode' delayed;
function GdipGetPathGradientTransform; external WINGDIPDLL name 'GdipGetPathGradientTransform' delayed;
function GdipSetPathGradientTransform; external WINGDIPDLL name 'GdipSetPathGradientTransform' delayed;
function GdipResetPathGradientTransform; external WINGDIPDLL name 'GdipResetPathGradientTransform' delayed;
function GdipMultiplyPathGradientTransform; external WINGDIPDLL name 'GdipMultiplyPathGradientTransform' delayed;
function GdipTranslatePathGradientTransform; external WINGDIPDLL name 'GdipTranslatePathGradientTransform' delayed;
function GdipScalePathGradientTransform; external WINGDIPDLL name 'GdipScalePathGradientTransform' delayed;
function GdipRotatePathGradientTransform; external WINGDIPDLL name 'GdipRotatePathGradientTransform' delayed;
function GdipGetPathGradientFocusScales; external WINGDIPDLL name 'GdipGetPathGradientFocusScales' delayed;
function GdipSetPathGradientFocusScales; external WINGDIPDLL name 'GdipSetPathGradientFocusScales' delayed;
function GdipCreatePen1; external WINGDIPDLL name 'GdipCreatePen1' delayed;
function GdipCreatePen2; external WINGDIPDLL name 'GdipCreatePen2' delayed;
function GdipClonePen; external WINGDIPDLL name 'GdipClonePen' delayed;
function GdipDeletePen; external WINGDIPDLL name 'GdipDeletePen' delayed;
function GdipSetPenWidth; external WINGDIPDLL name 'GdipSetPenWidth' delayed;
function GdipGetPenWidth; external WINGDIPDLL name 'GdipGetPenWidth' delayed;
function GdipSetPenUnit; external WINGDIPDLL name 'GdipSetPenUnit' delayed;
function GdipGetPenUnit; external WINGDIPDLL name 'GdipGetPenUnit' delayed;
function GdipSetPenLineCap197819; external WINGDIPDLL name 'GdipSetPenLineCap197819' delayed;
function GdipSetPenStartCap; external WINGDIPDLL name 'GdipSetPenStartCap' delayed;
function GdipSetPenEndCap; external WINGDIPDLL name 'GdipSetPenEndCap' delayed;
function GdipSetPenDashCap197819; external WINGDIPDLL name 'GdipSetPenDashCap197819' delayed;
function GdipGetPenStartCap; external WINGDIPDLL name 'GdipGetPenStartCap' delayed;
function GdipGetPenEndCap; external WINGDIPDLL name 'GdipGetPenEndCap' delayed;
function GdipGetPenDashCap197819; external WINGDIPDLL name 'GdipGetPenDashCap197819' delayed;
function GdipSetPenLineJoin; external WINGDIPDLL name 'GdipSetPenLineJoin' delayed;
function GdipGetPenLineJoin; external WINGDIPDLL name 'GdipGetPenLineJoin' delayed;
function GdipSetPenCustomStartCap; external WINGDIPDLL name 'GdipSetPenCustomStartCap' delayed;
function GdipGetPenCustomStartCap; external WINGDIPDLL name 'GdipGetPenCustomStartCap' delayed;
function GdipSetPenCustomEndCap; external WINGDIPDLL name 'GdipSetPenCustomEndCap' delayed;
function GdipGetPenCustomEndCap; external WINGDIPDLL name 'GdipGetPenCustomEndCap' delayed;
function GdipSetPenMiterLimit; external WINGDIPDLL name 'GdipSetPenMiterLimit' delayed;
function GdipGetPenMiterLimit; external WINGDIPDLL name 'GdipGetPenMiterLimit' delayed;
function GdipSetPenMode; external WINGDIPDLL name 'GdipSetPenMode' delayed;
function GdipGetPenMode; external WINGDIPDLL name 'GdipGetPenMode' delayed;
function GdipSetPenTransform; external WINGDIPDLL name 'GdipSetPenTransform' delayed;
function GdipGetPenTransform; external WINGDIPDLL name 'GdipGetPenTransform' delayed;
function GdipResetPenTransform; external WINGDIPDLL name 'GdipResetPenTransform' delayed;
function GdipMultiplyPenTransform; external WINGDIPDLL name 'GdipMultiplyPenTransform' delayed;
function GdipTranslatePenTransform; external WINGDIPDLL name 'GdipTranslatePenTransform' delayed;
function GdipScalePenTransform; external WINGDIPDLL name 'GdipScalePenTransform' delayed;
function GdipRotatePenTransform; external WINGDIPDLL name 'GdipRotatePenTransform' delayed;
function GdipSetPenColor; external WINGDIPDLL name 'GdipSetPenColor' delayed;
function GdipGetPenColor; external WINGDIPDLL name 'GdipGetPenColor' delayed;
function GdipSetPenBrushFill; external WINGDIPDLL name 'GdipSetPenBrushFill' delayed;
function GdipGetPenBrushFill; external WINGDIPDLL name 'GdipGetPenBrushFill' delayed;
function GdipGetPenFillType; external WINGDIPDLL name 'GdipGetPenFillType' delayed;
function GdipGetPenDashStyle; external WINGDIPDLL name 'GdipGetPenDashStyle' delayed;
function GdipSetPenDashStyle; external WINGDIPDLL name 'GdipSetPenDashStyle' delayed;
function GdipGetPenDashOffset; external WINGDIPDLL name 'GdipGetPenDashOffset' delayed;
function GdipSetPenDashOffset; external WINGDIPDLL name 'GdipSetPenDashOffset' delayed;
function GdipGetPenDashCount; external WINGDIPDLL name 'GdipGetPenDashCount' delayed;
function GdipSetPenDashArray; external WINGDIPDLL name 'GdipSetPenDashArray' delayed;
function GdipGetPenDashArray; external WINGDIPDLL name 'GdipGetPenDashArray' delayed;
function GdipGetPenCompoundCount; external WINGDIPDLL name 'GdipGetPenCompoundCount' delayed;
function GdipSetPenCompoundArray; external WINGDIPDLL name 'GdipSetPenCompoundArray' delayed;
function GdipGetPenCompoundArray; external WINGDIPDLL name 'GdipGetPenCompoundArray' delayed;
function GdipCreateCustomLineCap; external WINGDIPDLL name 'GdipCreateCustomLineCap' delayed;
function GdipDeleteCustomLineCap; external WINGDIPDLL name 'GdipDeleteCustomLineCap' delayed;
function GdipCloneCustomLineCap; external WINGDIPDLL name 'GdipCloneCustomLineCap' delayed;
function GdipGetCustomLineCapType; external WINGDIPDLL name 'GdipGetCustomLineCapType' delayed;
function GdipSetCustomLineCapStrokeCaps; external WINGDIPDLL name 'GdipSetCustomLineCapStrokeCaps' delayed;
function GdipGetCustomLineCapStrokeCaps; external WINGDIPDLL name 'GdipGetCustomLineCapStrokeCaps' delayed;
function GdipSetCustomLineCapStrokeJoin; external WINGDIPDLL name 'GdipSetCustomLineCapStrokeJoin' delayed;
function GdipGetCustomLineCapStrokeJoin; external WINGDIPDLL name 'GdipGetCustomLineCapStrokeJoin' delayed;
function GdipSetCustomLineCapBaseCap; external WINGDIPDLL name 'GdipSetCustomLineCapBaseCap' delayed;
function GdipGetCustomLineCapBaseCap; external WINGDIPDLL name 'GdipGetCustomLineCapBaseCap' delayed;
function GdipSetCustomLineCapBaseInset; external WINGDIPDLL name 'GdipSetCustomLineCapBaseInset' delayed;
function GdipGetCustomLineCapBaseInset; external WINGDIPDLL name 'GdipGetCustomLineCapBaseInset' delayed;
function GdipSetCustomLineCapWidthScale; external WINGDIPDLL name 'GdipSetCustomLineCapWidthScale' delayed;
function GdipGetCustomLineCapWidthScale; external WINGDIPDLL name 'GdipGetCustomLineCapWidthScale' delayed;
function GdipCreateAdjustableArrowCap; external WINGDIPDLL name 'GdipCreateAdjustableArrowCap' delayed;
function GdipSetAdjustableArrowCapHeight; external WINGDIPDLL name 'GdipSetAdjustableArrowCapHeight' delayed;
function GdipGetAdjustableArrowCapHeight; external WINGDIPDLL name 'GdipGetAdjustableArrowCapHeight' delayed;
function GdipSetAdjustableArrowCapWidth; external WINGDIPDLL name 'GdipSetAdjustableArrowCapWidth' delayed;
function GdipGetAdjustableArrowCapWidth; external WINGDIPDLL name 'GdipGetAdjustableArrowCapWidth' delayed;
function GdipSetAdjustableArrowCapMiddleInset; external WINGDIPDLL name 'GdipSetAdjustableArrowCapMiddleInset' delayed;
function GdipGetAdjustableArrowCapMiddleInset; external WINGDIPDLL name 'GdipGetAdjustableArrowCapMiddleInset' delayed;
function GdipSetAdjustableArrowCapFillState; external WINGDIPDLL name 'GdipSetAdjustableArrowCapFillState' delayed;
function GdipGetAdjustableArrowCapFillState; external WINGDIPDLL name 'GdipGetAdjustableArrowCapFillState' delayed;
function GdipLoadImageFromStream; external WINGDIPDLL name 'GdipLoadImageFromStream' delayed;
function GdipLoadImageFromFile; external WINGDIPDLL name 'GdipLoadImageFromFile' delayed;
function GdipLoadImageFromStreamICM; external WINGDIPDLL name 'GdipLoadImageFromStreamICM' delayed;
function GdipLoadImageFromFileICM; external WINGDIPDLL name 'GdipLoadImageFromFileICM' delayed;
function GdipCloneImage; external WINGDIPDLL name 'GdipCloneImage' delayed;
function GdipDisposeImage; external WINGDIPDLL name 'GdipDisposeImage' delayed;
function GdipSaveImageToFile; external WINGDIPDLL name 'GdipSaveImageToFile' delayed;
function GdipSaveImageToStream; external WINGDIPDLL name 'GdipSaveImageToStream' delayed;
function GdipSaveAdd; external WINGDIPDLL name 'GdipSaveAdd' delayed;
function GdipSaveAddImage; external WINGDIPDLL name 'GdipSaveAddImage' delayed;
function GdipGetImageGraphicsContext; external WINGDIPDLL name 'GdipGetImageGraphicsContext' delayed;
function GdipGetImageBounds; external WINGDIPDLL name 'GdipGetImageBounds' delayed;
function GdipGetImageDimension; external WINGDIPDLL name 'GdipGetImageDimension' delayed;
function GdipGetImageType; external WINGDIPDLL name 'GdipGetImageType' delayed;
function GdipGetImageWidth; external WINGDIPDLL name 'GdipGetImageWidth' delayed;
function GdipGetImageHeight; external WINGDIPDLL name 'GdipGetImageHeight' delayed;
function GdipGetImageHorizontalResolution; external WINGDIPDLL name 'GdipGetImageHorizontalResolution' delayed;
function GdipGetImageVerticalResolution; external WINGDIPDLL name 'GdipGetImageVerticalResolution' delayed;
function GdipGetImageFlags; external WINGDIPDLL name 'GdipGetImageFlags' delayed;
function GdipGetImageRawFormat; external WINGDIPDLL name 'GdipGetImageRawFormat' delayed;
function GdipGetImagePixelFormat; external WINGDIPDLL name 'GdipGetImagePixelFormat' delayed;
function GdipGetImageThumbnail; external WINGDIPDLL name 'GdipGetImageThumbnail' delayed;
function GdipGetEncoderParameterListSize; external WINGDIPDLL name 'GdipGetEncoderParameterListSize' delayed;
function GdipGetEncoderParameterList; external WINGDIPDLL name 'GdipGetEncoderParameterList' delayed;
function GdipImageGetFrameDimensionsCount; external WINGDIPDLL name 'GdipImageGetFrameDimensionsCount' delayed;
function GdipImageGetFrameDimensionsList; external WINGDIPDLL name 'GdipImageGetFrameDimensionsList' delayed;
function GdipImageGetFrameCount; external WINGDIPDLL name 'GdipImageGetFrameCount' delayed;
function GdipImageSelectActiveFrame; external WINGDIPDLL name 'GdipImageSelectActiveFrame' delayed;
function GdipImageRotateFlip; external WINGDIPDLL name 'GdipImageRotateFlip' delayed;
function GdipGetImagePalette; external WINGDIPDLL name 'GdipGetImagePalette' delayed;
function GdipSetImagePalette; external WINGDIPDLL name 'GdipSetImagePalette' delayed;
function GdipGetImagePaletteSize; external WINGDIPDLL name 'GdipGetImagePaletteSize' delayed;
function GdipGetPropertyCount; external WINGDIPDLL name 'GdipGetPropertyCount' delayed;
function GdipGetPropertyIdList; external WINGDIPDLL name 'GdipGetPropertyIdList' delayed;
function GdipGetPropertyItemSize; external WINGDIPDLL name 'GdipGetPropertyItemSize' delayed;
function GdipGetPropertyItem; external WINGDIPDLL name 'GdipGetPropertyItem' delayed;
function GdipGetPropertySize; external WINGDIPDLL name 'GdipGetPropertySize' delayed;
function GdipGetAllPropertyItems; external WINGDIPDLL name 'GdipGetAllPropertyItems' delayed;
function GdipRemovePropertyItem; external WINGDIPDLL name 'GdipRemovePropertyItem' delayed;
function GdipSetPropertyItem; external WINGDIPDLL name 'GdipSetPropertyItem' delayed;
function GdipImageForceValidation; external WINGDIPDLL name 'GdipImageForceValidation' delayed;
function GdipCreateBitmapFromStream; external WINGDIPDLL name 'GdipCreateBitmapFromStream' delayed;
function GdipCreateBitmapFromFile; external WINGDIPDLL name 'GdipCreateBitmapFromFile' delayed;
function GdipCreateBitmapFromStreamICM; external WINGDIPDLL name 'GdipCreateBitmapFromStreamICM' delayed;
function GdipCreateBitmapFromFileICM; external WINGDIPDLL name 'GdipCreateBitmapFromFileICM' delayed;
function GdipCreateBitmapFromScan0; external WINGDIPDLL name 'GdipCreateBitmapFromScan0' delayed;
function GdipCreateBitmapFromGraphics; external WINGDIPDLL name 'GdipCreateBitmapFromGraphics' delayed;
function GdipCreateBitmapFromDirectDrawSurface; external WINGDIPDLL name 'GdipCreateBitmapFromDirectDrawSurface' delayed;
function GdipCreateBitmapFromGdiDib; external WINGDIPDLL name 'GdipCreateBitmapFromGdiDib' delayed;
function GdipCreateBitmapFromHBITMAP; external WINGDIPDLL name 'GdipCreateBitmapFromHBITMAP' delayed;
function GdipCreateHBITMAPFromBitmap; external WINGDIPDLL name 'GdipCreateHBITMAPFromBitmap' delayed;
function GdipCreateBitmapFromHICON; external WINGDIPDLL name 'GdipCreateBitmapFromHICON' delayed;
function GdipCreateHICONFromBitmap; external WINGDIPDLL name 'GdipCreateHICONFromBitmap' delayed;
function GdipCreateBitmapFromResource; external WINGDIPDLL name 'GdipCreateBitmapFromResource' delayed;
function GdipCloneBitmapArea; external WINGDIPDLL name 'GdipCloneBitmapArea' delayed;
function GdipCloneBitmapAreaI; external WINGDIPDLL name 'GdipCloneBitmapAreaI' delayed;
function GdipBitmapLockBits; external WINGDIPDLL name 'GdipBitmapLockBits' delayed;
function GdipBitmapUnlockBits; external WINGDIPDLL name 'GdipBitmapUnlockBits' delayed;
function GdipBitmapGetPixel; external WINGDIPDLL name 'GdipBitmapGetPixel' delayed;
function GdipBitmapSetPixel; external WINGDIPDLL name 'GdipBitmapSetPixel' delayed;
function GdipBitmapSetResolution; external WINGDIPDLL name 'GdipBitmapSetResolution' delayed;
function GdipCreateImageAttributes; external WINGDIPDLL name 'GdipCreateImageAttributes' delayed;
function GdipCloneImageAttributes; external WINGDIPDLL name 'GdipCloneImageAttributes' delayed;
function GdipDisposeImageAttributes; external WINGDIPDLL name 'GdipDisposeImageAttributes' delayed;
function GdipSetImageAttributesToIdentity; external WINGDIPDLL name 'GdipSetImageAttributesToIdentity' delayed;
function GdipResetImageAttributes; external WINGDIPDLL name 'GdipResetImageAttributes' delayed;
function GdipSetImageAttributesColorMatrix; external WINGDIPDLL name 'GdipSetImageAttributesColorMatrix' delayed;
function GdipSetImageAttributesThreshold; external WINGDIPDLL name 'GdipSetImageAttributesThreshold' delayed;
function GdipSetImageAttributesGamma; external WINGDIPDLL name 'GdipSetImageAttributesGamma' delayed;
function GdipSetImageAttributesNoOp; external WINGDIPDLL name 'GdipSetImageAttributesNoOp' delayed;
function GdipSetImageAttributesColorKeys; external WINGDIPDLL name 'GdipSetImageAttributesColorKeys' delayed;
function GdipSetImageAttributesOutputChannel; external WINGDIPDLL name 'GdipSetImageAttributesOutputChannel' delayed;
function GdipSetImageAttributesOutputChannelColorProfile; external WINGDIPDLL name 'GdipSetImageAttributesOutputChannelColorProfile' delayed;
function GdipSetImageAttributesRemapTable; external WINGDIPDLL name 'GdipSetImageAttributesRemapTable' delayed;
function GdipSetImageAttributesWrapMode; external WINGDIPDLL name 'GdipSetImageAttributesWrapMode' delayed;
function GdipSetImageAttributesICMMode; external WINGDIPDLL name 'GdipSetImageAttributesICMMode' delayed;
function GdipGetImageAttributesAdjustedPalette; external WINGDIPDLL name 'GdipGetImageAttributesAdjustedPalette' delayed;
function GdipFlush; external WINGDIPDLL name 'GdipFlush' delayed;
function GdipCreateFromHDC; external WINGDIPDLL name 'GdipCreateFromHDC' delayed;
function GdipCreateFromHDC2; external WINGDIPDLL name 'GdipCreateFromHDC2' delayed;
function GdipCreateFromHWND; external WINGDIPDLL name 'GdipCreateFromHWND' delayed;
function GdipCreateFromHWNDICM; external WINGDIPDLL name 'GdipCreateFromHWNDICM' delayed;
function GdipDeleteGraphics; external WINGDIPDLL name 'GdipDeleteGraphics' delayed;
function GdipGetDC; external WINGDIPDLL name 'GdipGetDC' delayed;
function GdipReleaseDC; external WINGDIPDLL name 'GdipReleaseDC' delayed;
function GdipSetCompositingMode; external WINGDIPDLL name 'GdipSetCompositingMode' delayed;
function GdipGetCompositingMode; external WINGDIPDLL name 'GdipGetCompositingMode' delayed;
function GdipSetRenderingOrigin; external WINGDIPDLL name 'GdipSetRenderingOrigin' delayed;
function GdipGetRenderingOrigin; external WINGDIPDLL name 'GdipGetRenderingOrigin' delayed;
function GdipSetCompositingQuality; external WINGDIPDLL name 'GdipSetCompositingQuality' delayed;
function GdipGetCompositingQuality; external WINGDIPDLL name 'GdipGetCompositingQuality' delayed;
function GdipSetSmoothingMode; external WINGDIPDLL name 'GdipSetSmoothingMode' delayed;
function GdipGetSmoothingMode; external WINGDIPDLL name 'GdipGetSmoothingMode' delayed;
function GdipSetPixelOffsetMode; external WINGDIPDLL name 'GdipSetPixelOffsetMode' delayed;
function GdipGetPixelOffsetMode; external WINGDIPDLL name 'GdipGetPixelOffsetMode' delayed;
function GdipSetTextRenderingHint; external WINGDIPDLL name 'GdipSetTextRenderingHint' delayed;
function GdipGetTextRenderingHint; external WINGDIPDLL name 'GdipGetTextRenderingHint' delayed;
function GdipSetTextContrast; external WINGDIPDLL name 'GdipSetTextContrast' delayed;
function GdipGetTextContrast; external WINGDIPDLL name 'GdipGetTextContrast' delayed;
function GdipSetInterpolationMode; external WINGDIPDLL name 'GdipSetInterpolationMode' delayed;
function GdipGetInterpolationMode; external WINGDIPDLL name 'GdipGetInterpolationMode' delayed;
function GdipSetWorldTransform; external WINGDIPDLL name 'GdipSetWorldTransform' delayed;
function GdipResetWorldTransform; external WINGDIPDLL name 'GdipResetWorldTransform' delayed;
function GdipMultiplyWorldTransform; external WINGDIPDLL name 'GdipMultiplyWorldTransform' delayed;
function GdipTranslateWorldTransform; external WINGDIPDLL name 'GdipTranslateWorldTransform' delayed;
function GdipScaleWorldTransform; external WINGDIPDLL name 'GdipScaleWorldTransform' delayed;
function GdipRotateWorldTransform; external WINGDIPDLL name 'GdipRotateWorldTransform' delayed;
function GdipGetWorldTransform; external WINGDIPDLL name 'GdipGetWorldTransform' delayed;
function GdipResetPageTransform; external WINGDIPDLL name 'GdipResetPageTransform' delayed;
function GdipGetPageUnit; external WINGDIPDLL name 'GdipGetPageUnit' delayed;
function GdipGetPageScale; external WINGDIPDLL name 'GdipGetPageScale' delayed;
function GdipSetPageUnit; external WINGDIPDLL name 'GdipSetPageUnit' delayed;
function GdipSetPageScale; external WINGDIPDLL name 'GdipSetPageScale' delayed;
function GdipGetDpiX; external WINGDIPDLL name 'GdipGetDpiX' delayed;
function GdipGetDpiY; external WINGDIPDLL name 'GdipGetDpiY' delayed;
function GdipTransformPoints; external WINGDIPDLL name 'GdipTransformPoints' delayed;
function GdipTransformPointsI; external WINGDIPDLL name 'GdipTransformPointsI' delayed;
function GdipGetNearestColor; external WINGDIPDLL name 'GdipGetNearestColor' delayed;
function GdipCreateHalftonePalette; external WINGDIPDLL name 'GdipCreateHalftonePalette' delayed;
function GdipDrawLine; external WINGDIPDLL name 'GdipDrawLine' delayed;
function GdipDrawLineI; external WINGDIPDLL name 'GdipDrawLineI' delayed;
function GdipDrawLines; external WINGDIPDLL name 'GdipDrawLines' delayed;
function GdipDrawLinesI; external WINGDIPDLL name 'GdipDrawLinesI' delayed;
function GdipDrawArc; external WINGDIPDLL name 'GdipDrawArc' delayed;
function GdipDrawArcI; external WINGDIPDLL name 'GdipDrawArcI' delayed;
function GdipDrawBezier; external WINGDIPDLL name 'GdipDrawBezier' delayed;
function GdipDrawBezierI; external WINGDIPDLL name 'GdipDrawBezierI' delayed;
function GdipDrawBeziers; external WINGDIPDLL name 'GdipDrawBeziers' delayed;
function GdipDrawBeziersI; external WINGDIPDLL name 'GdipDrawBeziersI' delayed;
function GdipDrawRectangle; external WINGDIPDLL name 'GdipDrawRectangle' delayed;
function GdipDrawRectangleI; external WINGDIPDLL name 'GdipDrawRectangleI' delayed;
function GdipDrawRectangles; external WINGDIPDLL name 'GdipDrawRectangles' delayed;
function GdipDrawRectanglesI; external WINGDIPDLL name 'GdipDrawRectanglesI' delayed;
function GdipDrawEllipse; external WINGDIPDLL name 'GdipDrawEllipse' delayed;
function GdipDrawEllipseI; external WINGDIPDLL name 'GdipDrawEllipseI' delayed;
function GdipDrawPie; external WINGDIPDLL name 'GdipDrawPie' delayed;
function GdipDrawPieI; external WINGDIPDLL name 'GdipDrawPieI' delayed;
function GdipDrawPolygon; external WINGDIPDLL name 'GdipDrawPolygon' delayed;
function GdipDrawPolygonI; external WINGDIPDLL name 'GdipDrawPolygonI' delayed;
function GdipDrawPath; external WINGDIPDLL name 'GdipDrawPath' delayed;
function GdipDrawCurve; external WINGDIPDLL name 'GdipDrawCurve' delayed;
function GdipDrawCurveI; external WINGDIPDLL name 'GdipDrawCurveI' delayed;
function GdipDrawCurve2; external WINGDIPDLL name 'GdipDrawCurve2' delayed;
function GdipDrawCurve2I; external WINGDIPDLL name 'GdipDrawCurve2I' delayed;
function GdipDrawCurve3; external WINGDIPDLL name 'GdipDrawCurve3' delayed;
function GdipDrawCurve3I; external WINGDIPDLL name 'GdipDrawCurve3I' delayed;
function GdipDrawClosedCurve; external WINGDIPDLL name 'GdipDrawClosedCurve' delayed;
function GdipDrawClosedCurveI; external WINGDIPDLL name 'GdipDrawClosedCurveI' delayed;
function GdipDrawClosedCurve2; external WINGDIPDLL name 'GdipDrawClosedCurve2' delayed;
function GdipDrawClosedCurve2I; external WINGDIPDLL name 'GdipDrawClosedCurve2I' delayed;
function GdipGraphicsClear; external WINGDIPDLL name 'GdipGraphicsClear' delayed;
function GdipFillRectangle; external WINGDIPDLL name 'GdipFillRectangle' delayed;
function GdipFillRectangleI; external WINGDIPDLL name 'GdipFillRectangleI' delayed;
function GdipFillRectangles; external WINGDIPDLL name 'GdipFillRectangles' delayed;
function GdipFillRectanglesI; external WINGDIPDLL name 'GdipFillRectanglesI' delayed;
function GdipFillPolygon; external WINGDIPDLL name 'GdipFillPolygon' delayed;
function GdipFillPolygonI; external WINGDIPDLL name 'GdipFillPolygonI' delayed;
function GdipFillPolygon2; external WINGDIPDLL name 'GdipFillPolygon2' delayed;
function GdipFillPolygon2I; external WINGDIPDLL name 'GdipFillPolygon2I' delayed;
function GdipFillEllipse; external WINGDIPDLL name 'GdipFillEllipse' delayed;
function GdipFillEllipseI; external WINGDIPDLL name 'GdipFillEllipseI' delayed;
function GdipFillPie; external WINGDIPDLL name 'GdipFillPie' delayed;
function GdipFillPieI; external WINGDIPDLL name 'GdipFillPieI' delayed;
function GdipFillPath; external WINGDIPDLL name 'GdipFillPath' delayed;
function GdipFillClosedCurve; external WINGDIPDLL name 'GdipFillClosedCurve' delayed;
function GdipFillClosedCurveI; external WINGDIPDLL name 'GdipFillClosedCurveI' delayed;
function GdipFillClosedCurve2; external WINGDIPDLL name 'GdipFillClosedCurve2' delayed;
function GdipFillClosedCurve2I; external WINGDIPDLL name 'GdipFillClosedCurve2I' delayed;
function GdipFillRegion; external WINGDIPDLL name 'GdipFillRegion' delayed;
function GdipDrawImage; external WINGDIPDLL name 'GdipDrawImage' delayed;
function GdipDrawImageI; external WINGDIPDLL name 'GdipDrawImageI' delayed;
function GdipDrawImageRect; external WINGDIPDLL name 'GdipDrawImageRect' delayed;
function GdipDrawImageRectI; external WINGDIPDLL name 'GdipDrawImageRectI' delayed;
function GdipDrawImagePoints; external WINGDIPDLL name 'GdipDrawImagePoints' delayed;
function GdipDrawImagePointsI; external WINGDIPDLL name 'GdipDrawImagePointsI' delayed;
function GdipDrawImagePointRect; external WINGDIPDLL name 'GdipDrawImagePointRect' delayed;
function GdipDrawImagePointRectI; external WINGDIPDLL name 'GdipDrawImagePointRectI' delayed;
function GdipDrawImageRectRect; external WINGDIPDLL name 'GdipDrawImageRectRect' delayed;
function GdipDrawImageRectRectI; external WINGDIPDLL name 'GdipDrawImageRectRectI' delayed;
function GdipDrawImagePointsRect; external WINGDIPDLL name 'GdipDrawImagePointsRect' delayed;
function GdipDrawImagePointsRectI; external WINGDIPDLL name 'GdipDrawImagePointsRectI' delayed;
function GdipEnumerateMetafileDestPoint; external WINGDIPDLL name 'GdipEnumerateMetafileDestPoint' delayed;
function GdipEnumerateMetafileDestPointI; external WINGDIPDLL name 'GdipEnumerateMetafileDestPointI' delayed;
function GdipEnumerateMetafileDestRect; external WINGDIPDLL name 'GdipEnumerateMetafileDestRect' delayed;
function GdipEnumerateMetafileDestRectI; external WINGDIPDLL name 'GdipEnumerateMetafileDestRectI' delayed;
function GdipEnumerateMetafileDestPoints; external WINGDIPDLL name 'GdipEnumerateMetafileDestPoints' delayed;
function GdipEnumerateMetafileDestPointsI; external WINGDIPDLL name 'GdipEnumerateMetafileDestPointsI' delayed;
function GdipEnumerateMetafileSrcRectDestPoint; external WINGDIPDLL name 'GdipEnumerateMetafileSrcRectDestPoint' delayed;
function GdipEnumerateMetafileSrcRectDestPointI; external WINGDIPDLL name 'GdipEnumerateMetafileSrcRectDestPointI' delayed;
function GdipEnumerateMetafileSrcRectDestRect; external WINGDIPDLL name 'GdipEnumerateMetafileSrcRectDestRect' delayed;
function GdipEnumerateMetafileSrcRectDestRectI; external WINGDIPDLL name 'GdipEnumerateMetafileSrcRectDestRectI' delayed;
function GdipEnumerateMetafileSrcRectDestPoints; external WINGDIPDLL name 'GdipEnumerateMetafileSrcRectDestPoints' delayed;
function GdipEnumerateMetafileSrcRectDestPointsI; external WINGDIPDLL name 'GdipEnumerateMetafileSrcRectDestPointsI' delayed;
function GdipPlayMetafileRecord; external WINGDIPDLL name 'GdipPlayMetafileRecord' delayed;
function GdipSetClipGraphics; external WINGDIPDLL name 'GdipSetClipGraphics' delayed;
function GdipSetClipRect; external WINGDIPDLL name 'GdipSetClipRect' delayed;
function GdipSetClipRectI; external WINGDIPDLL name 'GdipSetClipRectI' delayed;
function GdipSetClipPath; external WINGDIPDLL name 'GdipSetClipPath' delayed;
function GdipSetClipRegion; external WINGDIPDLL name 'GdipSetClipRegion' delayed;
function GdipSetClipHrgn; external WINGDIPDLL name 'GdipSetClipHrgn' delayed;
function GdipResetClip; external WINGDIPDLL name 'GdipResetClip' delayed;
function GdipTranslateClip; external WINGDIPDLL name 'GdipTranslateClip' delayed;
function GdipTranslateClipI; external WINGDIPDLL name 'GdipTranslateClipI' delayed;
function GdipGetClip; external WINGDIPDLL name 'GdipGetClip' delayed;
function GdipGetClipBounds; external WINGDIPDLL name 'GdipGetClipBounds' delayed;
function GdipGetClipBoundsI; external WINGDIPDLL name 'GdipGetClipBoundsI' delayed;
function GdipIsClipEmpty; external WINGDIPDLL name 'GdipIsClipEmpty' delayed;
function GdipGetVisibleClipBounds; external WINGDIPDLL name 'GdipGetVisibleClipBounds' delayed;
function GdipGetVisibleClipBoundsI; external WINGDIPDLL name 'GdipGetVisibleClipBoundsI' delayed;
function GdipIsVisibleClipEmpty; external WINGDIPDLL name 'GdipIsVisibleClipEmpty' delayed;
function GdipIsVisiblePoint; external WINGDIPDLL name 'GdipIsVisiblePoint' delayed;
function GdipIsVisiblePointI; external WINGDIPDLL name 'GdipIsVisiblePointI' delayed;
function GdipIsVisibleRect; external WINGDIPDLL name 'GdipIsVisibleRect' delayed;
function GdipIsVisibleRectI; external WINGDIPDLL name 'GdipIsVisibleRectI' delayed;
function GdipSaveGraphics; external WINGDIPDLL name 'GdipSaveGraphics' delayed;
function GdipRestoreGraphics; external WINGDIPDLL name 'GdipRestoreGraphics' delayed;
function GdipBeginContainer; external WINGDIPDLL name 'GdipBeginContainer' delayed;
function GdipBeginContainerI; external WINGDIPDLL name 'GdipBeginContainerI' delayed;
function GdipBeginContainer2; external WINGDIPDLL name 'GdipBeginContainer2' delayed;
function GdipEndContainer; external WINGDIPDLL name 'GdipEndContainer' delayed;
function GdipGetMetafileHeaderFromWmf; external WINGDIPDLL name 'GdipGetMetafileHeaderFromWmf' delayed;
function GdipGetMetafileHeaderFromEmf; external WINGDIPDLL name 'GdipGetMetafileHeaderFromEmf' delayed;
function GdipGetMetafileHeaderFromFile; external WINGDIPDLL name 'GdipGetMetafileHeaderFromFile' delayed;
function GdipGetMetafileHeaderFromStream; external WINGDIPDLL name 'GdipGetMetafileHeaderFromStream' delayed;
function GdipGetMetafileHeaderFromMetafile; external WINGDIPDLL name 'GdipGetMetafileHeaderFromMetafile' delayed;
function GdipGetHemfFromMetafile; external WINGDIPDLL name 'GdipGetHemfFromMetafile' delayed;
function GdipCreateStreamOnFile; external WINGDIPDLL name 'GdipCreateStreamOnFile' delayed;
function GdipCreateMetafileFromWmf; external WINGDIPDLL name 'GdipCreateMetafileFromWmf' delayed;
function GdipCreateMetafileFromEmf; external WINGDIPDLL name 'GdipCreateMetafileFromEmf' delayed;
function GdipCreateMetafileFromFile; external WINGDIPDLL name 'GdipCreateMetafileFromFile' delayed;
function GdipCreateMetafileFromWmfFile; external WINGDIPDLL name 'GdipCreateMetafileFromWmfFile' delayed;
function GdipCreateMetafileFromStream; external WINGDIPDLL name 'GdipCreateMetafileFromStream' delayed;
function GdipRecordMetafile; external WINGDIPDLL name 'GdipRecordMetafile' delayed;
function GdipRecordMetafileI; external WINGDIPDLL name 'GdipRecordMetafileI' delayed;
function GdipRecordMetafileFileName; external WINGDIPDLL name 'GdipRecordMetafileFileName' delayed;
function GdipRecordMetafileFileNameI; external WINGDIPDLL name 'GdipRecordMetafileFileNameI' delayed;
function GdipRecordMetafileStream; external WINGDIPDLL name 'GdipRecordMetafileStream' delayed;
function GdipRecordMetafileStreamI; external WINGDIPDLL name 'GdipRecordMetafileStreamI' delayed;
function GdipSetMetafileDownLevelRasterizationLimit; external WINGDIPDLL name 'GdipSetMetafileDownLevelRasterizationLimit' delayed;
function GdipGetMetafileDownLevelRasterizationLimit; external WINGDIPDLL name 'GdipGetMetafileDownLevelRasterizationLimit' delayed;
function GdipGetImageDecodersSize; external WINGDIPDLL name 'GdipGetImageDecodersSize' delayed;
function GdipGetImageDecoders; external WINGDIPDLL name 'GdipGetImageDecoders' delayed;
function GdipGetImageEncodersSize; external WINGDIPDLL name 'GdipGetImageEncodersSize' delayed;
function GdipGetImageEncoders; external WINGDIPDLL name 'GdipGetImageEncoders' delayed;
function GdipComment; external WINGDIPDLL name 'GdipComment' delayed;
function GdipCreateFontFamilyFromName; external WINGDIPDLL name 'GdipCreateFontFamilyFromName' delayed;
function GdipDeleteFontFamily; external WINGDIPDLL name 'GdipDeleteFontFamily' delayed;
function GdipCloneFontFamily; external WINGDIPDLL name 'GdipCloneFontFamily' delayed;
function GdipGetGenericFontFamilySansSerif; external WINGDIPDLL name 'GdipGetGenericFontFamilySansSerif' delayed;
function GdipGetGenericFontFamilySerif; external WINGDIPDLL name 'GdipGetGenericFontFamilySerif' delayed;
function GdipGetGenericFontFamilyMonospace; external WINGDIPDLL name 'GdipGetGenericFontFamilyMonospace' delayed;
function GdipGetFamilyName; external WINGDIPDLL name 'GdipGetFamilyName' delayed;
function GdipIsStyleAvailable; external WINGDIPDLL name 'GdipIsStyleAvailable' delayed;
function GdipFontCollectionEnumerable; external WINGDIPDLL name 'GdipFontCollectionEnumerable' delayed;
function GdipFontCollectionEnumerate; external WINGDIPDLL name 'GdipFontCollectionEnumerate' delayed;
function GdipGetEmHeight; external WINGDIPDLL name 'GdipGetEmHeight' delayed;
function GdipGetCellAscent; external WINGDIPDLL name 'GdipGetCellAscent' delayed;
function GdipGetCellDescent; external WINGDIPDLL name 'GdipGetCellDescent' delayed;
function GdipGetLineSpacing; external WINGDIPDLL name 'GdipGetLineSpacing' delayed;
function GdipCreateFontFromDC; external WINGDIPDLL name 'GdipCreateFontFromDC' delayed;
function GdipCreateFontFromLogfontA; external WINGDIPDLL name 'GdipCreateFontFromLogfontA' delayed;
function GdipCreateFontFromLogfontW; external WINGDIPDLL name 'GdipCreateFontFromLogfontW' delayed;
function GdipCreateFont; external WINGDIPDLL name 'GdipCreateFont' delayed;
function GdipCloneFont; external WINGDIPDLL name 'GdipCloneFont' delayed;
function GdipDeleteFont; external WINGDIPDLL name 'GdipDeleteFont' delayed;
function GdipGetFamily; external WINGDIPDLL name 'GdipGetFamily' delayed;
function GdipGetFontStyle; external WINGDIPDLL name 'GdipGetFontStyle' delayed;
function GdipGetFontSize; external WINGDIPDLL name 'GdipGetFontSize' delayed;
function GdipGetFontUnit; external WINGDIPDLL name 'GdipGetFontUnit' delayed;
function GdipGetFontHeight; external WINGDIPDLL name 'GdipGetFontHeight' delayed;
function GdipGetFontHeightGivenDPI; external WINGDIPDLL name 'GdipGetFontHeightGivenDPI' delayed;
function GdipGetLogFontA; external WINGDIPDLL name 'GdipGetLogFontA' delayed;
function GdipGetLogFontW; external WINGDIPDLL name 'GdipGetLogFontW' delayed;
function GdipNewInstalledFontCollection; external WINGDIPDLL name 'GdipNewInstalledFontCollection' delayed;
function GdipNewPrivateFontCollection; external WINGDIPDLL name 'GdipNewPrivateFontCollection' delayed;
function GdipDeletePrivateFontCollection; external WINGDIPDLL name 'GdipDeletePrivateFontCollection' delayed;
function GdipGetFontCollectionFamilyCount; external WINGDIPDLL name 'GdipGetFontCollectionFamilyCount' delayed;
function GdipGetFontCollectionFamilyList; external WINGDIPDLL name 'GdipGetFontCollectionFamilyList' delayed;
function GdipPrivateAddFontFile; external WINGDIPDLL name 'GdipPrivateAddFontFile' delayed;
function GdipPrivateAddMemoryFont; external WINGDIPDLL name 'GdipPrivateAddMemoryFont' delayed;
function GdipDrawString; external WINGDIPDLL name 'GdipDrawString' delayed;
function GdipMeasureString; external WINGDIPDLL name 'GdipMeasureString' delayed;
function GdipMeasureCharacterRanges; external WINGDIPDLL name 'GdipMeasureCharacterRanges' delayed;
function GdipDrawDriverString; external WINGDIPDLL name 'GdipDrawDriverString' delayed;
function GdipMeasureDriverString; external WINGDIPDLL name 'GdipMeasureDriverString' delayed;
function GdipCreateStringFormat; external WINGDIPDLL name 'GdipCreateStringFormat' delayed;
function GdipStringFormatGetGenericDefault; external WINGDIPDLL name 'GdipStringFormatGetGenericDefault' delayed;
function GdipStringFormatGetGenericTypographic; external WINGDIPDLL name 'GdipStringFormatGetGenericTypographic' delayed;
function GdipDeleteStringFormat; external WINGDIPDLL name 'GdipDeleteStringFormat' delayed;
function GdipCloneStringFormat; external WINGDIPDLL name 'GdipCloneStringFormat' delayed;
function GdipSetStringFormatFlags; external WINGDIPDLL name 'GdipSetStringFormatFlags' delayed;
function GdipGetStringFormatFlags; external WINGDIPDLL name 'GdipGetStringFormatFlags' delayed;
function GdipSetStringFormatAlign; external WINGDIPDLL name 'GdipSetStringFormatAlign' delayed;
function GdipGetStringFormatAlign; external WINGDIPDLL name 'GdipGetStringFormatAlign' delayed;
function GdipSetStringFormatLineAlign; external WINGDIPDLL name 'GdipSetStringFormatLineAlign' delayed;
function GdipGetStringFormatLineAlign; external WINGDIPDLL name 'GdipGetStringFormatLineAlign' delayed;
function GdipSetStringFormatTrimming; external WINGDIPDLL name 'GdipSetStringFormatTrimming' delayed;
function GdipGetStringFormatTrimming; external WINGDIPDLL name 'GdipGetStringFormatTrimming' delayed;
function GdipSetStringFormatHotkeyPrefix; external WINGDIPDLL name 'GdipSetStringFormatHotkeyPrefix' delayed;
function GdipGetStringFormatHotkeyPrefix; external WINGDIPDLL name 'GdipGetStringFormatHotkeyPrefix' delayed;
function GdipSetStringFormatTabStops; external WINGDIPDLL name 'GdipSetStringFormatTabStops' delayed;
function GdipGetStringFormatTabStops; external WINGDIPDLL name 'GdipGetStringFormatTabStops' delayed;
function GdipGetStringFormatTabStopCount; external WINGDIPDLL name 'GdipGetStringFormatTabStopCount' delayed;
function GdipSetStringFormatDigitSubstitution; external WINGDIPDLL name 'GdipSetStringFormatDigitSubstitution' delayed;
function GdipGetStringFormatDigitSubstitution; external WINGDIPDLL name 'GdipGetStringFormatDigitSubstitution' delayed;
function GdipGetStringFormatMeasurableCharacterRangeCount; external WINGDIPDLL name 'GdipGetStringFormatMeasurableCharacterRangeCount' delayed;
function GdipSetStringFormatMeasurableCharacterRanges; external WINGDIPDLL name 'GdipSetStringFormatMeasurableCharacterRanges' delayed;
function GdipCreateCachedBitmap; external WINGDIPDLL name 'GdipCreateCachedBitmap' delayed;
function GdipDeleteCachedBitmap; external WINGDIPDLL name 'GdipDeleteCachedBitmap' delayed;
function GdipDrawCachedBitmap; external WINGDIPDLL name 'GdipDrawCachedBitmap' delayed;
function GdipEmfToWmfBits; external WINGDIPDLL name 'GdipEmfToWmfBits' delayed;

// -----------------------------------------------------------------------------
// TGdiplusBase class
// -----------------------------------------------------------------------------

class function TGdiplusBase.NewInstance: TObject;
begin
  Result := InitInstance(GdipAlloc(ULONG(instanceSize)));
end;

procedure TGdiplusBase.FreeInstance;
begin
  CleanupInstance;
  GdipFree(Self);
end;

// -----------------------------------------------------------------------------
// macros
// -----------------------------------------------------------------------------

function ObjectTypeIsValid(type_: ObjectType): BOOL;
begin
  result :=  ((type_ >= ObjectTypeMin) and (type_ <= ObjectTypeMax));
end;

function GDIP_WMF_RECORD_TO_EMFPLUS(n: integer): Integer;
begin
  result := (n or GDIP_WMF_RECORD_BASE);
end;

function GDIP_EMFPLUS_RECORD_TO_WMF(n: integer): Integer;
begin
  result := n and (not GDIP_WMF_RECORD_BASE);
end;

function GDIP_IS_WMF_RECORDTYPE(n: integer): BOOL;
begin
  result := ((n and GDIP_WMF_RECORD_BASE) <> 0);
end;


//--------------------------------------------------------------------------
// TGPPoint Util
//--------------------------------------------------------------------------

function MakePoint(X, Y: Integer): TGPPoint;
begin
  result.X := X;
  result.Y := Y;
end;

function MakePoint(X, Y: Single): TGPPointF;
begin
  Result.X := X;
  result.Y := Y;
end;

//--------------------------------------------------------------------------
// TGPSize Util
//--------------------------------------------------------------------------

function MakeSize(Width, Height: Single): TGPSizeF;
begin
  result.Width := Width;
  result.Height := Height;
end;

function MakeSize(Width, Height: Integer): TGPSize;
begin
  result.Width := Width;
  result.Height := Height;
end;

//--------------------------------------------------------------------------
// TCharacterRange Util
//--------------------------------------------------------------------------

function MakeCharacterRange(First, Length: Integer): TCharacterRange;
begin
  result.First  := First;
  result.Length := Length;
end;

// -----------------------------------------------------------------------------
// RectF class
// -----------------------------------------------------------------------------

function MakeRect(x, y, width, height: Single): TGPRectF; overload;
begin
  Result.X      := x;
  Result.Y      := y;
  Result.Width  := width;
  Result.Height := height;
end;

function MakeRect(location: TGPPointF; size: TGPSizeF): TGPRectF; overload;
begin
  Result.X      := location.X;
  Result.Y      := location.Y;
  Result.Width  := size.Width;
  Result.Height := size.Height;
end;

// -----------------------------------------------------------------------------
// Rect class
// -----------------------------------------------------------------------------

function MakeRect(x, y, width, height: Integer): TGPRect; overload;
begin
  Result.X      := x;
  Result.Y      := y;
  Result.Width  := width;
  Result.Height := height;
end;

function MakeRect(location: TGPPoint; size: TGPSize): TGPRect; overload;
begin
  Result.X      := location.X;
  Result.Y      := location.Y;
  Result.Width  := size.Width;
  Result.Height := size.Height;
end;

function MakeRect(const Rect: TRect): TGPRect;
begin
  Result.X := rect.Left;
  Result.Y := Rect.Top;
  Result.Width := Rect.Right-Rect.Left;
  Result.Height:= Rect.Bottom-Rect.Top;
end;

// -----------------------------------------------------------------------------
// PathData class
// -----------------------------------------------------------------------------

constructor TPathData.Create;
begin
  Count := 0;
  Points := nil;
  Types := nil;
end;

destructor TPathData.destroy;
begin
  if assigned(Points) then freemem(Points);
  if assigned(Types) then freemem(Types);
end;


function GetPixelFormatSize(pixfmt: PixelFormat): UINT;
begin
  result := (pixfmt shr 8) and $ff;
end;

function IsIndexedPixelFormat(pixfmt: PixelFormat): BOOL;
begin
  result := (pixfmt and PixelFormatIndexed) <> 0;
end;

function IsAlphaPixelFormat(pixfmt: PixelFormat): BOOL;
begin
  result := (pixfmt and PixelFormatAlpha) <> 0;
end;

function IsExtendedPixelFormat(pixfmt: PixelFormat): BOOL;
begin
  result := (pixfmt and PixelFormatExtended) <> 0;
end;

function IsCanonicalPixelFormat(pixfmt: PixelFormat): BOOL;
begin
  result := (pixfmt and PixelFormatCanonical) <> 0;
end;

// -----------------------------------------------------------------------------
// Color class
// -----------------------------------------------------------------------------

{  constructor TGPColor.Create;
  begin
    Argb := DWORD(Black);
  end;

  // Construct an opaque Color object with
  // the specified Red, Green, Blue values.
  //
  // Color values are not premultiplied.

  constructor TGPColor.Create(r, g, b: Byte);
  begin
    Argb := MakeARGB(255, r, g, b);
  end;

  constructor TGPColor.Create(a, r, g, b: Byte);
  begin
    Argb := MakeARGB(a, r, g, b);
  end;

  constructor TGPColor.Create(Value: ARGB);
  begin
    Argb := Value;
  end;

  function TGPColor.GetAlpha: BYTE;
  begin
    result := BYTE(Argb shr AlphaShift);
  end;

  function TGPColor.GetA: BYTE;
  begin
    result := GetAlpha;
  end;

  function TGPColor.GetRed: BYTE;
  begin
    result := BYTE(Argb shr RedShift);
  end;

  function TGPColor.GetR: BYTE;
  begin
    result := GetRed;
  end;

  function TGPColor.GetGreen: Byte;
  begin
    result := BYTE(Argb shr GreenShift);
  end;

  function TGPColor.GetG: Byte;
  begin
    result := GetGreen;
  end;

  function TGPColor.GetBlue: Byte;
  begin
    result := BYTE(Argb shr BlueShift);
  end;

  function TGPColor.GetB: Byte;
  begin
    result := GetBlue;
  end;

  function TGPColor.GetValue: ARGB;
  begin
    result := Argb;
  end;

  procedure TGPColor.SetValue(Value: ARGB);
  begin
    Argb := Value;
  end;

  procedure TGPColor.SetFromCOLORREF(rgb: COLORREF);
  begin
    Argb := MakeARGB(255, GetRValue(rgb), GetGValue(rgb), GetBValue(rgb));
  end;

  function TGPColor.ToCOLORREF: COLORREF;
  begin
    result := RGB(GetRed, GetGreen, GetBlue);
  end;

  function TGPColor.MakeARGB(a, r, g, b: Byte): ARGB;
  begin
    result := ((DWORD(b) shl  BlueShift) or
               (DWORD(g) shl GreenShift) or
               (DWORD(r) shl   RedShift) or
               (DWORD(a) shl AlphaShift));
  end;  }

function MakeColor(r, g, b: Byte): ARGB; overload;
begin
  result := MakeColor(255, r, g, b);
end;

function MakeColor(a, r, g, b: Byte): ARGB; overload;
begin
  result := ((DWORD(b) shl  BlueShift) or
             (DWORD(g) shl GreenShift) or
             (DWORD(r) shl   RedShift) or
             (DWORD(a) shl AlphaShift));
end;

function GetAlpha(color: ARGB): BYTE;
begin
  result := BYTE(color shr AlphaShift);
end;

function GetRed(color: ARGB): BYTE;
begin
  result := BYTE(color shr RedShift);
end;

function GetGreen(color: ARGB): BYTE;
begin
  result := BYTE(color shr GreenShift);
end;

function GetBlue(color: ARGB): BYTE;
begin
  result := BYTE(color shr BlueShift);
end;

function ColorRefToARGB(rgb: COLORREF): ARGB;
begin
  result := MakeColor(255, GetRValue(rgb), GetGValue(rgb), GetBValue(rgb));
end;

function ARGBToColorRef(Color: ARGB): COLORREF;
begin
  result := RGB(GetRed(Color), GetGreen(Color), GetBlue(Color));
end;


// -----------------------------------------------------------------------------
// MetafileHeader class
// -----------------------------------------------------------------------------

  procedure TMetafileHeader.GetBounds(out Rect: TGPRect);
  begin
    rect.X      := X;
    rect.Y      := Y;
    rect.Width  := Width;
    rect.Height := Height;
  end;

  function TMetafileHeader.IsWmf: BOOL;
  begin
    result :=  ((Type_ = MetafileTypeWmf) or (Type_ = MetafileTypeWmfPlaceable));
  end;

  function TMetafileHeader.IsWmfPlaceable: BOOL;
  begin
    result := (Type_ = MetafileTypeWmfPlaceable);
  end;

  function TMetafileHeader.IsEmf: BOOL;
  begin
    result := (Type_ = MetafileTypeEmf);
  end;

  function TMetafileHeader.IsEmfOrEmfPlus: BOOL;
  begin
    result := (Type_ >= MetafileTypeEmf);
  end;

  function TMetafileHeader.IsEmfPlus: BOOL;
  begin
    result := (Type_ >= MetafileTypeEmfPlusOnly)
  end;

  function TMetafileHeader.IsEmfPlusDual: BOOL;
  begin
    result := (Type_ = MetafileTypeEmfPlusDual)
  end;

  function TMetafileHeader.IsEmfPlusOnly: BOOL;
  begin
    result := (Type_ = MetafileTypeEmfPlusOnly)
  end;

  function TMetafileHeader.IsDisplay: BOOL;
  begin
    result := (IsEmfPlus and ((EmfPlusFlags and GDIP_EMFPLUSFLAGS_DISPLAY) <> 0));
  end;

  function TMetafileHeader.GetWmfHeader: PMetaHeader;
  begin
    if IsWmf then result :=  @Header.WmfHeader
             else result := nil;
  end;

  function TMetafileHeader.GetEmfHeader: PENHMETAHEADER3;
  begin
    if IsEmfOrEmfPlus then result := @Header.EmfHeader
                      else result := nil;
  end;

end.



