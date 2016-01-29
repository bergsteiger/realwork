{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: D2D1.h                                 }
{          Copyright (c) Microsoft Corporation.         }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.D2D1;

{$ALIGN ON}
{$MINENUMSIZE 4}

interface

uses Winapi.DxgiFormat, Winapi.Windows, Winapi.Wincodec, Winapi.DXGI;

(*$HPPEMIT '#include <d2d1.h>' *)
(*$HPPEMIT '#include <dwrite.h>' *)

{ Translation of:
  D2DBaseTypes.h
  dcommon.h
  d2d1.h
  d2derr.h
  directwrite.h
}
// File name: D2DBaseTypes.h
// ---------------------------------------------------------------------------


// +-----------------------------------------------------------------------------
//
//  Struct:
//      D3DCOLORVALUE
//
// ------------------------------------------------------------------------------
type
  D3DCOLORVALUE = record
    r: Single;
    g: Single;
    b: Single;
    a: Single;

  end;
  TD3DColorValue = D3DCOLORVALUE;
  PD3DColorValue = ^TD3DColorValue;
  {$EXTERNALSYM D3DCOLORVALUE}

// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D_RECT_F
//
// ------------------------------------------------------------------------------
  D2D_RECT_F = record
    left: Single;
    top: Single;
    right: Single;
    bottom: Single;

    class operator Implicit(AValue: TRect): D2D_RECT_F;
    class operator Explicit(AValue: D2D_RECT_F): TRect;
  end;
  TD2DRectF = D2D_RECT_F;
  PD2DRectF = ^TD2dRectF;
  {$EXTERNALSYM D2D_RECT_F}


// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D_RECT_U
//
// ------------------------------------------------------------------------------
  D2D_RECT_U = record
    left: Cardinal;
    top: Cardinal;
    right: Cardinal;
    bottom: Cardinal;

  end;
  TD2DRectU = D2D_RECT_U;
  PD2DRectU = ^TD2dRectU;
  {$EXTERNALSYM D2D_RECT_U}


// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D_SIZE_F
//
// ------------------------------------------------------------------------------
  D2D_SIZE_F = record
    width: Single;
    height: Single;

  end;
  TD2DSizeF = D2D_SIZE_F;
  PD2DSizeF = ^TD2dSizeF;
  {$EXTERNALSYM D2D_SIZE_F}


// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D_SIZE_U
//
// ------------------------------------------------------------------------------
  D2D_SIZE_U = record
    width: UINT32;
    height: UINT32;
  end;
  TD2DSizeU = D2D_SIZE_U;
  PD2DSizeU = ^TD2dSizeU;
  {$EXTERNALSYM D2D_SIZE_U}

  D2D_COLOR_F = D3DCOLORVALUE;
  {$EXTERNALSYM D2D_COLOR_F}

// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D_MATRIX_3X2_F
//
// ------------------------------------------------------------------------------
  D2D_MATRIX_3X2_F = record
    _11: Single;
    _12: Single;
    _21: Single;
    _22: Single;
    _31: Single;
    _32: Single;

    class operator Multiply(const Left: D2D_MATRIX_3X2_F;
                        const Right: D2D_MATRIX_3X2_F): D2D_MATRIX_3X2_F;

  end;
  {$EXTERNALSYM D2D_MATRIX_3X2_F}
  TD2DMatrix3x2F = D2D_MATRIX_3X2_F;
  PD2DMatrix3x2F = ^TD2dMatrix3x2F;

// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D_POINT_2U
//
// ------------------------------------------------------------------------------
  D2D_POINT_2U = record
    x: Cardinal;
    y: Cardinal;
  end;
  TD2DPoint2u = D2D_POINT_2U;
  PD2DPoint2u = ^TD2dPoint2u;
  {$EXTERNALSYM D2D_POINT_2U}


// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D_POINT_2F
//
// ------------------------------------------------------------------------------
  D2D_POINT_2F = record
    x: Single;
    y: Single;

    class operator Implicit(AValue: TPoint): D2D_POINT_2F;
    class operator Explicit(AValue: D2D_POINT_2F): TPoint;
    class operator Multiply(point: D2D_POINT_2F; matrix: D2D_MATRIX_3X2_F): D2D_POINT_2F;
  end;
  TD2DPoint2f = D2D_POINT_2F;
  PD2DPoint2f = ^TD2DPoint2f;
  {$EXTERNALSYM D2D_POINT_2F}

//// D2D1.H : GUIDS
const
  SID_ID2D1Resource                 = '{2cd90691-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1Bitmap                   = '{a2296057-ea42-4099-983b-539fb6505426}';
  SID_ID2D1GradientStopCollection   = '{2cd906a7-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1Brush                    = '{2cd906a8-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1BitmapBrush              = '{2cd906aa-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1SolidColorBrush          = '{2cd906a9-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1LinearGradientBrush      = '{2cd906ab-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1RadialGradientBrush      = '{2cd906ac-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1StrokeStyle              = '{2cd9069d-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1Geometry                 = '{2cd906a1-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1RectangleGeometry        = '{2cd906a2-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1RoundedRectangleGeometry = '{2cd906a3-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1EllipseGeometry          = '{2cd906a4-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1GeometryGroup            = '{2cd906a6-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1TransformedGeometry      = '{2cd906bb-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1SimplifiedGeometrySink   = '{2cd9069e-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1GeometrySink             = '{2cd9069f-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1TessellationSink         = '{2cd906c1-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1PathGeometry             = '{2cd906a5-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1Mesh                     = '{2cd906c2-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1Layer                    = '{2cd9069b-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1DrawingStateBlock        = '{28506e39-ebf6-46a1-bb47-fd85565ab957}';
  SID_ID2D1RenderTarget             = '{2cd90694-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1BitmapRenderTarget       = '{2cd90695-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1HwndRenderTarget         = '{2cd90698-12e2-11dc-9fed-001143a055f9}';
  SID_ID2D1GdiInteropRenderTarget   = '{e0db51c3-6f77-4bae-b3d5-e47509b35838}';
  SID_ID2D1DCRenderTarget           = '{1c51bc64-de61-46fd-9899-63a5d8f03950}';
  SID_ID2D1Factory                  = '{06152247-6f50-465a-9245-118bfd3b6007}';

  IID_ID2D1Resource                 : TGUID = SID_ID2D1Resource;
  {$EXTERNALSYM IID_ID2D1Resource}
  IID_ID2D1Bitmap                   : TGUID = SID_ID2D1Bitmap;
  {$EXTERNALSYM IID_ID2D1Bitmap}
  IID_ID2D1GradientStopCollection   : TGUID = SID_ID2D1GradientStopCollection;
  {$EXTERNALSYM IID_ID2D1GradientStopCollection}
  IID_ID2D1Brush                    : TGUID = SID_ID2D1Brush;
  {$EXTERNALSYM IID_ID2D1Brush}
  IID_ID2D1BitmapBrush              : TGUID = SID_ID2D1BitmapBrush;
  {$EXTERNALSYM IID_ID2D1BitmapBrush}
  IID_ID2D1SolidColorBrush          : TGUID = SID_ID2D1SolidColorBrush;
  {$EXTERNALSYM IID_ID2D1SolidColorBrush}
  IID_ID2D1LinearGradientBrush      : TGUID = SID_ID2D1LinearGradientBrush;
  {$EXTERNALSYM IID_ID2D1LinearGradientBrush}
  IID_ID2D1RadialGradientBrush      : TGUID = SID_ID2D1RadialGradientBrush;
  {$EXTERNALSYM IID_ID2D1RadialGradientBrush}
  IID_ID2D1StrokeStyle              : TGUID = SID_ID2D1StrokeStyle;
  {$EXTERNALSYM IID_ID2D1StrokeStyle}
  IID_ID2D1Geometry                 : TGUID = SID_ID2D1Geometry;
  {$EXTERNALSYM IID_ID2D1Geometry}
  IID_ID2D1RectangleGeometry        : TGUID = SID_ID2D1RectangleGeometry;
  {$EXTERNALSYM IID_ID2D1RectangleGeometry}
  IID_ID2D1RoundedRectangleGeometry : TGUID = SID_ID2D1RoundedRectangleGeometry;
  {$EXTERNALSYM IID_ID2D1RoundedRectangleGeometry}
  IID_ID2D1EllipseGeometry          : TGUID = SID_ID2D1EllipseGeometry;
  {$EXTERNALSYM IID_ID2D1EllipseGeometry}
  IID_ID2D1GeometryGroup            : TGUID = SID_ID2D1GeometryGroup;
  {$EXTERNALSYM IID_ID2D1GeometryGroup}
  IID_ID2D1TransformedGeometry      : TGUID = SID_ID2D1TransformedGeometry;
  {$EXTERNALSYM IID_ID2D1TransformedGeometry}
  IID_ID2D1SimplifiedGeometrySink   : TGUID = SID_ID2D1SimplifiedGeometrySink;
  {$EXTERNALSYM IID_ID2D1SimplifiedGeometrySink}
  IID_ID2D1GeometrySink             : TGUID = SID_ID2D1GeometrySink;
  {$EXTERNALSYM IID_ID2D1GeometrySink}
  IID_ID2D1TessellationSink         : TGUID = SID_ID2D1TessellationSink;
  {$EXTERNALSYM IID_ID2D1TessellationSink}
  IID_ID2D1PathGeometry             : TGUID = SID_ID2D1PathGeometry;
  {$EXTERNALSYM IID_ID2D1PathGeometry}
  IID_ID2D1Mesh                     : TGUID = SID_ID2D1Mesh;
  {$EXTERNALSYM IID_ID2D1Mesh}
  IID_ID2D1Layer                    : TGUID = SID_ID2D1Layer;
  {$EXTERNALSYM IID_ID2D1Layer}
  IID_ID2D1DrawingStateBlock        : TGUID = SID_ID2D1DrawingStateBlock;
  {$EXTERNALSYM IID_ID2D1DrawingStateBlock}
  IID_ID2D1RenderTarget             : TGUID = SID_ID2D1RenderTarget;
  {$EXTERNALSYM IID_ID2D1RenderTarget}
  IID_ID2D1BitmapRenderTarget       : TGUID = SID_ID2D1BitmapRenderTarget;
  {$EXTERNALSYM IID_ID2D1BitmapRenderTarget}
  IID_ID2D1HwndRenderTarget         : TGUID = SID_ID2D1HwndRenderTarget;
  {$EXTERNALSYM IID_ID2D1HwndRenderTarget}
  IID_ID2D1GdiInteropRenderTarget   : TGUID = SID_ID2D1GdiInteropRenderTarget;
  {$EXTERNALSYM IID_ID2D1GdiInteropRenderTarget}
  IID_ID2D1DCRenderTarget           : TGUID = SID_ID2D1DCRenderTarget;
  {$EXTERNALSYM IID_ID2D1DCRenderTarget}
  IID_ID2D1Factory                  : TGUID = SID_ID2D1Factory;
  {$EXTERNALSYM IID_ID2D1Factory}
//// DWrite.H : GUIDS
  SID_IDWriteFontFileLoader       = '{727cad4e-d6af-4c9e-8a08-d695b11caa49}';
  SID_IDWriteLocalFontFileLoader  = '{b2d9f3ec-c9fe-4a11-a2ec-d86208f7c0a2}';
  SID_IDWriteFontFileStream       = '{6d4865fe-0ab8-4d91-8f62-5dd6be34a3e0}';
  SID_IDWriteFontFile             = '{739d886a-cef5-47dc-8769-1a8b41bebbb0}';
  SID_IDWriteRenderingParams      = '{2f0da53a-2add-47cd-82ee-d9ec34688e75}';
  SID_IDWriteFontFace             = '{5f49804d-7024-4d43-bfa9-d25984f53849}';
  SID_IDWriteFontCollectionLoader = '{cca920e4-52f0-492b-bfa8-29c72ee0a468}';
  SID_IDWriteFontFileEnumerator   = '{72755049-5ff7-435d-8348-4be97cfa6c7c}';
  SID_IDWriteLocalizedStrings     = '{08256209-099a-4b34-b86d-c22b110e7771}';
  SID_IDWriteFontCollection       = '{a84cee02-3eea-4eee-a827-87c1a02a0fcc}';
  SID_IDWriteFontList             = '{1a0d8438-1d97-4ec1-aef9-a2fb86ed6acb}';
  SID_IDWriteFontFamily           = '{da20d8ef-812a-4c43-9802-62ec4abd7add}';
  SID_IDWriteFont                 = '{acd16696-8c14-4f5d-877e-fe3fc1d32737}';
  SID_IDWriteTextFormat           = '{9c906818-31d7-4fd3-a151-7c5e225db55a}';
  SID_IDWriteTypography           = '{55f1112b-1dc2-4b3c-9541-f46894ed85b6}';
  SID_IDWriteNumberSubstitution   = '{14885CC9-BAB0-4f90-B6ED-5C366A2CD03D}';
  SID_IDWriteTextAnalysisSource   = '{688e1a58-5094-47c8-adc8-fbcea60ae92b}';
  SID_IDWriteTextAnalysisSink     = '{5810cd44-0ca0-4701-b3fa-bec5182ae4f6}';
  SID_IDWriteTextAnalyzer         = '{b7e6163e-7f46-43b4-84b3-e4e6249c365d}';
  SID_IDWriteInlineObject         = '{8339FDE3-106F-47ab-8373-1C6295EB10B3}';
  SID_IDWritePixelSnapping        = '{eaf3a2da-ecf4-4d24-b644-b34f6842024b}';
  SID_IDWriteTextRenderer         = '{ef8a8135-5cc6-45fe-8825-c5a0724eb819}';
  SID_IDWriteTextLayout           = '{53737037-6d14-410b-9bfe-0b182bb70961}';
  SID_IDWriteBitmapRenderTarget   = '{5e5a32a3-8dff-4773-9ff6-0696eab77267}';
  SID_IDWriteGdiInterop           = '{1edd9491-9853-4299-898f-6432983b6f3a}';
  SID_IDWriteGlyphRunAnalysis     = '{7d97dbf7-e085-42d4-81e3-6a883bded118}';
  SID_IDWriteFactory              = '{b859ee5a-d838-4b5b-a2e8-1adc7d93db48}';

  IID_IDWriteFontFileLoader       : TGUID = SID_IDWriteFontFileLoader;
  {$EXTERNALSYM IID_IDWriteFontFileLoader}
  IID_IDWriteLocalFontFileLoader  : TGUID = SID_IDWriteLocalFontFileLoader;
  {$EXTERNALSYM IID_IDWriteLocalFontFileLoader}
  IID_IDWriteFontFileStream       : TGUID = SID_IDWriteFontFileStream;
  {$EXTERNALSYM IID_IDWriteFontFileStream}
  IID_IDWriteFontFile             : TGUID = SID_IDWriteFontFile;
  {$EXTERNALSYM IID_IDWriteFontFile}
  IID_IDWriteRenderingParams      : TGUID = SID_IDWriteRenderingParams;
  {$EXTERNALSYM IID_IDWriteRenderingParams}
  IID_IDWriteFontFace             : TGUID = SID_IDWriteFontFace;
  {$EXTERNALSYM IID_IDWriteFontFace}
  IID_IDWriteFontCollectionLoader : TGUID = SID_IDWriteFontCollectionLoader;
  {$EXTERNALSYM IID_IDWriteFontCollectionLoader}
  IID_IDWriteFontFileEnumerator   : TGUID = SID_IDWriteFontFileEnumerator;
  {$EXTERNALSYM IID_IDWriteFontFileEnumerator}
  IID_IDWriteLocalizedStrings     : TGUID = SID_IDWriteLocalizedStrings;
  {$EXTERNALSYM IID_IDWriteLocalizedStrings}
  IID_IDWriteFontCollection       : TGUID = SID_IDWriteFontCollection;
  {$EXTERNALSYM IID_IDWriteFontCollection}
  IID_IDWriteFontList             : TGUID = SID_IDWriteFontList;
  {$EXTERNALSYM IID_IDWriteFontList}
  IID_IDWriteFontFamily           : TGUID = SID_IDWriteFontFamily;
  {$EXTERNALSYM IID_IDWriteFontFamily}
  IID_IDWriteFont                 : TGUID = SID_IDWriteFont;
  {$EXTERNALSYM IID_IDWriteFont}
  IID_IDWriteTextFormat           : TGUID = SID_IDWriteTextFormat;
  {$EXTERNALSYM IID_IDWriteTextFormat}
  IID_IDWriteTypography           : TGUID = SID_IDWriteTypography;
  {$EXTERNALSYM IID_IDWriteTypography}
  IID_IDWriteNumberSubstitution   : TGUID = SID_IDWriteNumberSubstitution;
  {$EXTERNALSYM IID_IDWriteNumberSubstitution}
  IID_IDWriteTextAnalysisSource   : TGUID = SID_IDWriteTextAnalysisSource;
  {$EXTERNALSYM IID_IDWriteTextAnalysisSource}
  IID_IDWriteTextAnalysisSink     : TGUID = SID_IDWriteTextAnalysisSink;
  {$EXTERNALSYM IID_IDWriteTextAnalysisSink}
  IID_IDWriteTextAnalyzer         : TGUID = SID_IDWriteTextAnalyzer;
  {$EXTERNALSYM IID_IDWriteTextAnalyzer}
  IID_IDWriteInlineObject         : TGUID = SID_IDWriteInlineObject;
  {$EXTERNALSYM IID_IDWriteInlineObject}
  IID_IDWritePixelSnapping        : TGUID = SID_IDWritePixelSnapping;
  {$EXTERNALSYM IID_IDWritePixelSnapping}
  IID_IDWriteTextRenderer         : TGUID = SID_IDWriteTextRenderer;
  {$EXTERNALSYM IID_IDWriteTextRenderer}
  IID_IDWriteTextLayout           : TGUID = SID_IDWriteTextLayout;
  {$EXTERNALSYM IID_IDWriteTextLayout}
  IID_IDWriteBitmapRenderTarget   : TGUID = SID_IDWriteBitmapRenderTarget;
  {$EXTERNALSYM IID_IDWriteBitmapRenderTarget}
  IID_IDWriteGdiInterop           : TGUID = SID_IDWriteGdiInterop;
  {$EXTERNALSYM IID_IDWriteGdiInterop}
  IID_IDWriteGlyphRunAnalysis     : TGUID = SID_IDWriteGlyphRunAnalysis;
  {$EXTERNALSYM IID_IDWriteGlyphRunAnalysis}
  IID_IDWriteFactory              : TGUID = SID_IDWriteFactory;
  {$EXTERNALSYM IID_IDWriteFactory}


//// DCommon.H : Consts, Enums, Flags
// The measuring method used for text layout.
type
  DWRITE_MEASURING_MODE = type Integer;
  {$EXTERNALSYM DWRITE_MEASURING_MODE}
  TDWriteMeasuringMode = DWRITE_MEASURING_MODE;
  PDWriteMeasuringMode = ^TDWriteMeasuringMode;
const
  // Text is measured using glyph ideal metrics whose values are independent to the current display resolution.
  DWRITE_MEASURING_MODE_NATURAL = 0;
  {$EXTERNALSYM DWRITE_MEASURING_MODE_NATURAL}
  // Text is measured using glyph display compatible metrics whose values tuned for the current display resolution.
  DWRITE_MEASURING_MODE_GDI_CLASSIC = 1;
  {$EXTERNALSYM DWRITE_MEASURING_MODE_GDI_CLASSIC}
  // Text is measured using the same glyph display metrics as text measured by GDI using a font
  // created with CLEARTYPE_NATURAL_QUALITY.
  DWRITE_MEASURING_MODE_GDI_NATURAL = 2;
  {$EXTERNALSYM DWRITE_MEASURING_MODE_GDI_NATURAL}

//// D2D1.h : Consts, Enums, Flags
const
  D2D1_INVALID_TAG = $FFFFFFFFFFFFFFFF;                      
  {$EXTERNALSYM D2D1_INVALID_TAG}
  D2D1_DEFAULT_FLATTENING_TOLERANCE = (0.25);
  {$EXTERNALSYM D2D1_DEFAULT_FLATTENING_TOLERANCE}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_ALPHA_MODE
//
//  Synopsis:
//      Qualifies how alpha is to be treated in a bitmap or render target containing
//      alpha.
//
// ------------------------------------------------------------------------------
type
  D2D1_ALPHA_MODE = type Integer;
  {$EXTERNALSYM D2D1_ALPHA_MODE}
  TD2D1AlphaMode = D2D1_ALPHA_MODE;
  PD2D1AlphaMode = ^TD2D1AlphaMode;

const
  D2D1_ALPHA_MODE_UNKNOWN       = 0; // Alpha mode should be determined implicitly.
                                     // Some target surfaces do not supply or imply
                                     // this information in which case alpha must
                                     // be specified.
  {$EXTERNALSYM D2D1_ALPHA_MODE_UNKNOWN}
  D2D1_ALPHA_MODE_PREMULTIPLIED = 1; // Treat the alpha as premultipled.
  {$EXTERNALSYM D2D1_ALPHA_MODE_PREMULTIPLIED}
  D2D1_ALPHA_MODE_STRAIGHT      = 2; // Opacity is in the 'A' component only.
  {$EXTERNALSYM D2D1_ALPHA_MODE_STRAIGHT}
  D2D1_ALPHA_MODE_IGNORE        = 3; // Ignore any alpha channel information.
  {$EXTERNALSYM D2D1_ALPHA_MODE_IGNORE}
  D2D1_ALPHA_MODE_FORCE_DWORD   = $FFFFFFFF;
  {$EXTERNALSYM D2D1_ALPHA_MODE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_GAMMA
//
//  Synopsis:
//      This determines what gamma is used for interpolation/blending.
//
// ------------------------------------------------------------------------------
type
  D2D1_GAMMA = type Integer;
  {$EXTERNALSYM D2D1_GAMMA}
  TD2D1Gamma = D2D1_GAMMA;
  PD2D1Gamma = ^TD2D1Gamma;
const
  D2D1_GAMMA_2_2         = 0; // Colors are manipulated in 2.2 gamma color space.
  {$EXTERNALSYM D2D1_GAMMA_2_2}
  D2D1_GAMMA_1_0         = 1; // Colors are manipulated in 1.0 gamma color space.
  {$EXTERNALSYM D2D1_GAMMA_1_0}
  D2D1_GAMMA_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_GAMMA_FORCE_DWORD}

//+-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_OPACITY_MASK_CONTENT
//
//  Synopsis:
//      Specifies what the contents are of an opacity mask.
//
//------------------------------------------------------------------------------
type
  D2D1_OPACITY_MASK_CONTENT = type Integer;
  {$EXTERNALSYM D2D1_OPACITY_MASK_CONTENT}
  TD2D1OpacityMaskContent = D2D1_OPACITY_MASK_CONTENT;
  PD2D1OpacityMaskContent = ^TD2D1OpacityMaskContent;
const
  D2D1_OPACITY_MASK_CONTENT_GRAPHICS            = 0; // The mask contains geometries or bitmaps.
  {$EXTERNALSYM D2D1_OPACITY_MASK_CONTENT_GRAPHICS}
  D2D1_OPACITY_MASK_CONTENT_TEXT_NATURAL        = 1; // The mask contains text rendered using one of the natural text modes.
  {$EXTERNALSYM D2D1_OPACITY_MASK_CONTENT_TEXT_NATURAL}
  D2D1_OPACITY_MASK_CONTENT_TEXT_GDI_COMPATIBLE = 2; // The mask contains text rendered using one of the GDI compatible text modes.
  {$EXTERNALSYM D2D1_OPACITY_MASK_CONTENT_TEXT_GDI_COMPATIBLE}
  D2D1_OPACITY_MASK_CONTENT_FORCE_DWORD         = $FFFFFFFF;
  {$EXTERNALSYM D2D1_OPACITY_MASK_CONTENT_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_EXTEND_MODE
//
//  Synopsis:
//      Enum which descibes how to sample from a source outside it's base tile.
//
// ------------------------------------------------------------------------------
type
  D2D1_EXTEND_MODE = type Integer;
  {$EXTERNALSYM D2D1_EXTEND_MODE}
  TD2D1ExtendMode = D2D1_EXTEND_MODE;
  PD2D1ExtendMode = ^TD2D1ExtendMode;
const
  D2D1_EXTEND_MODE_CLAMP       = 0; // Extend the edges of the source out by
                                    //clamping sample points outside the source
                                    // to the edges.
  {$EXTERNALSYM D2D1_EXTEND_MODE_CLAMP}
  D2D1_EXTEND_MODE_WRAP        = 1; // The base tile is drawn untransformed and
                                    //the remainder are filled by repeating
                                    // the base tile.
  {$EXTERNALSYM D2D1_EXTEND_MODE_WRAP}
  D2D1_EXTEND_MODE_MIRROR      = 2;
                                    // The same as wrap, but alternate tiles
                                    // are flipped  The base tile is drawn
                                    // untransformed.
  {$EXTERNALSYM D2D1_EXTEND_MODE_MIRROR}
  D2D1_EXTEND_MODE_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_EXTEND_MODE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_ANTIALIAS_MODE
//
//  Synopsis:
//      Enum which descibes the manner in which we render edges of non-text primitives.
//
// ------------------------------------------------------------------------------
type
  D2D1_ANTIALIAS_MODE = type Integer;
  {$EXTERNALSYM D2D1_ANTIALIAS_MODE}
  TD2D1AntiAliasMode = D2D1_ANTIALIAS_MODE;
  PD2D1AntiAliasMode = ^TD2D1AntiAliasMode;
const
  D2D1_ANTIALIAS_MODE_PER_PRIMITIVE = 0; // The edges of each primitive are antialiased sequentially.
  {$EXTERNALSYM D2D1_ANTIALIAS_MODE_PER_PRIMITIVE}
  D2D1_ANTIALIAS_MODE_ALIASED       = 1; // Each pixel is rendered if its pixel center is contained by the geometry.
  {$EXTERNALSYM D2D1_ANTIALIAS_MODE_ALIASED}
  D2D1_ANTIALIAS_MODE_FORCE_DWORD   = $FFFFFFFF; 
  {$EXTERNALSYM D2D1_ANTIALIAS_MODE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_TEXT_ANTIALIAS_MODE
// 
// ------------------------------------------------------------------------------
type
  D2D1_TEXT_ANTIALIAS_MODE = type Integer; 
  {$EXTERNALSYM D2D1_TEXT_ANTIALIAS_MODE}
  TD2D1TextAntiAliasMode = D2D1_TEXT_ANTIALIAS_MODE;
  PD2D1TextAntiAliasMode = ^TD2D1TextAntiAliasMode;
const
  D2D1_TEXT_ANTIALIAS_MODE_DEFAULT     = 0; // Render text using the current system setting.
  {$EXTERNALSYM D2D1_TEXT_ANTIALIAS_MODE_DEFAULT}
  D2D1_TEXT_ANTIALIAS_MODE_CLEARTYPE   = 1; // Render text using ClearType.
  {$EXTERNALSYM D2D1_TEXT_ANTIALIAS_MODE_CLEARTYPE}
  D2D1_TEXT_ANTIALIAS_MODE_GRAYSCALE   = 2; // Render text using gray-scale.
  {$EXTERNALSYM D2D1_TEXT_ANTIALIAS_MODE_GRAYSCALE}
  D2D1_TEXT_ANTIALIAS_MODE_ALIASED     = 3; // Render text aliased.
  {$EXTERNALSYM D2D1_TEXT_ANTIALIAS_MODE_ALIASED}
  D2D1_TEXT_ANTIALIAS_MODE_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_TEXT_ANTIALIAS_MODE_FORCE_DWORD}



// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_BITMAP_INTERPOLATION_MODE
//
// ------------------------------------------------------------------------------
type
  D2D1_BITMAP_INTERPOLATION_MODE = type Integer;
  {$EXTERNALSYM D2D1_BITMAP_INTERPOLATION_MODE}
  TD2D1BitmapInterpolationMode = D2D1_BITMAP_INTERPOLATION_MODE;
  PD2D1BitmapInterpolationMode = ^TD2D1BitmapInterpolationMode;
const
  D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0;  // Nearest Neighbor filtering.
                                                        //Also known as nearest pixel
                                                        //or nearest point sampling.
  {$EXTERNALSYM D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR}
  D2D1_BITMAP_INTERPOLATION_MODE_LINEAR           = 1;  // Linear filtering.
  {$EXTERNALSYM D2D1_BITMAP_INTERPOLATION_MODE_LINEAR}
  D2D1_BITMAP_INTERPOLATION_MODE_FORCE_DWORD      = $FFFFFFFF;
  {$EXTERNALSYM D2D1_BITMAP_INTERPOLATION_MODE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Flag:
//      D2D1_DRAW_TEXT_OPTIONS
//
//  Synopsis:
//      Modifications made to the draw text call that influence how the text is
//      rendered.
//
// ------------------------------------------------------------------------------
type
  D2D1_DRAW_TEXT_OPTIONS = type Integer;
  {$EXTERNALSYM D2D1_DRAW_TEXT_OPTIONS}
  TD2D1DrawTextOptions = D2D1_DRAW_TEXT_OPTIONS;
  PD2D1DrawTextOptions = ^TD2D1DrawTextOptions;
const
  D2D1_DRAW_TEXT_OPTIONS_NO_SNAP     = $00000001; // Do not snap the baseline of the text vertically.
  {$EXTERNALSYM D2D1_DRAW_TEXT_OPTIONS_NO_SNAP}
  D2D1_DRAW_TEXT_OPTIONS_CLIP     = $00000002; // Clip the text to the content bounds.
  {$EXTERNALSYM D2D1_DRAW_TEXT_OPTIONS_CLIP}
  D2D1_DRAW_TEXT_OPTIONS_NONE        = $00000000;
  {$EXTERNALSYM D2D1_DRAW_TEXT_OPTIONS_NONE}
  D2D1_DRAW_TEXT_OPTIONS_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_DRAW_TEXT_OPTIONS_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_ARC_SIZE
// 
//  Synopsis:
//      Differentiates which of the two possible arcs could match the given arc
//      parameters.
// 
// ------------------------------------------------------------------------------
type
  D2D1_ARC_SIZE = type Integer;
  {$EXTERNALSYM D2D1_ARC_SIZE}
  TD2D1ArcSize = D2D1_ARC_SIZE;
  PD2D1ArcSize = ^TD2D1ArcSize;
const
  D2D1_ARC_SIZE_SMALL       = 0;
  {$EXTERNALSYM D2D1_ARC_SIZE_SMALL}
  D2D1_ARC_SIZE_LARGE       = 1; 
  {$EXTERNALSYM D2D1_ARC_SIZE_LARGE}
  D2D1_ARC_SIZE_FORCE_DWORD = $FFFFFFFF; 
  {$EXTERNALSYM D2D1_ARC_SIZE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_CAP_STYLE
// 
//  Synopsis:
//      Enum which descibes the drawing of the ends of a line.
// 
// ------------------------------------------------------------------------------
type
  D2D1_CAP_STYLE = type Integer;
  {$EXTERNALSYM D2D1_CAP_STYLE}
  TD2D1CapStyle = D2D1_CAP_STYLE;
  PD2D1CapStyle = ^TD2D1CapStyle;

const
  D2D1_CAP_STYLE_FLAT        = 0;         // Flat line cap.
  {$EXTERNALSYM D2D1_CAP_STYLE_FLAT}
  D2D1_CAP_STYLE_SQUARE      = 1;         // Square line cap.
  {$EXTERNALSYM D2D1_CAP_STYLE_SQUARE}
  D2D1_CAP_STYLE_ROUND       = 2;         // Round line cap.
  {$EXTERNALSYM D2D1_CAP_STYLE_ROUND}
  D2D1_CAP_STYLE_TRIANGLE    = 3;         // Triangle line cap.
  {$EXTERNALSYM D2D1_CAP_STYLE_TRIANGLE}
  D2D1_CAP_STYLE_FORCE_DWORD = $FFFFFFFF; 
  {$EXTERNALSYM D2D1_CAP_STYLE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_DASH_STYLE
//
// ------------------------------------------------------------------------------
type
  D2D1_DASH_STYLE = type Integer; 
  {$EXTERNALSYM D2D1_DASH_STYLE}
  TD2D1DashStyle = D2D1_DASH_STYLE;
  PD2D1DashStyle = ^TD2D1DashStyle;
const
  D2D1_DASH_STYLE_SOLID        = 0; 
  {$EXTERNALSYM D2D1_DASH_STYLE_SOLID}
  D2D1_DASH_STYLE_DASH         = 1; 
  {$EXTERNALSYM D2D1_DASH_STYLE_DASH}
  D2D1_DASH_STYLE_DOT          = 2; 
  {$EXTERNALSYM D2D1_DASH_STYLE_DOT}
  D2D1_DASH_STYLE_DASH_DOT     = 3;
  {$EXTERNALSYM D2D1_DASH_STYLE_DASH_DOT}
  D2D1_DASH_STYLE_DASH_DOT_DOT = 4; 
  {$EXTERNALSYM D2D1_DASH_STYLE_DASH_DOT_DOT}
  D2D1_DASH_STYLE_CUSTOM       = 5; 
  {$EXTERNALSYM D2D1_DASH_STYLE_CUSTOM}
  D2D1_DASH_STYLE_FORCE_DWORD  = $FFFFFFFF; 
  {$EXTERNALSYM D2D1_DASH_STYLE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_LINE_JOIN
// 
//  Synopsis:
//      Enum which descibes the drawing of the corners on the line.
//
// ------------------------------------------------------------------------------
type
  D2D1_LINE_JOIN = type Integer;
  {$EXTERNALSYM D2D1_LINE_JOIN}
  TD2D1LineJoin = D2D1_LINE_JOIN;
  PD2D1LineJoin = ^TD2D1LineJoin;
const
  D2D1_LINE_JOIN_MITER          = 0;         // Miter join.
  {$EXTERNALSYM D2D1_LINE_JOIN_MITER}
  D2D1_LINE_JOIN_BEVEL          = 1;         // Bevel join.
  {$EXTERNALSYM D2D1_LINE_JOIN_BEVEL}
  D2D1_LINE_JOIN_ROUND          = 2;         // Round join.
  {$EXTERNALSYM D2D1_LINE_JOIN_ROUND}
  D2D1_LINE_JOIN_MITER_OR_BEVEL = 3;         // Miter/Bevel join.
  {$EXTERNALSYM D2D1_LINE_JOIN_MITER_OR_BEVEL}
  D2D1_LINE_JOIN_FORCE_DWORD    = $FFFFFFFF; 
  {$EXTERNALSYM D2D1_LINE_JOIN_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_COMBINE_MODE
//
//  Synopsis:
//      This enumeration describes the type of combine operation to be performed.
// 
// ------------------------------------------------------------------------------
type
  D2D1_COMBINE_MODE = type Integer;
  {$EXTERNALSYM D2D1_COMBINE_MODE}
  TD2D1CombineMode = D2D1_COMBINE_MODE;
  PD2D1CombineMode = ^TD2D1CombineMode;
const
  D2D1_COMBINE_MODE_UNION       = 0; // Produce a geometry representing the
                                     // set of points contained in either
                                     // the first or the second geometry.
  {$EXTERNALSYM D2D1_COMBINE_MODE_UNION}
  D2D1_COMBINE_MODE_INTERSECT   = 1; // Produce a geometry representing the
                                     // set of points common to the first
                                     // and the second geometries.
  {$EXTERNALSYM D2D1_COMBINE_MODE_INTERSECT}
  D2D1_COMBINE_MODE_XOR         = 2; // Produce a geometry representing the set
                                     // of points contained in the first geometry
                                     // or the second geometry, but not both.
  {$EXTERNALSYM D2D1_COMBINE_MODE_XOR}
  D2D1_COMBINE_MODE_EXCLUDE     = 3; // Produce a geometry representing the set
                                     // of points contained in the first geometry
                                     // but not the second geometry.
  {$EXTERNALSYM D2D1_COMBINE_MODE_EXCLUDE}
  D2D1_COMBINE_MODE_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_COMBINE_MODE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_GEOMETRY_RELATION
// 
// ------------------------------------------------------------------------------
type
  D2D1_GEOMETRY_RELATION = type Integer;
  {$EXTERNALSYM D2D1_GEOMETRY_RELATION}
  TD2D1GeometryRelation = D2D1_GEOMETRY_RELATION;
  PD2D1GeometryRelation = ^TD2D1GeometryRelation;
const
  // The relation between the geometries couldn't be determined. This value is never
  // returned by any D2D method.
  D2D1_GEOMETRY_RELATION_UNKNOWN      = 0;
  {$EXTERNALSYM D2D1_GEOMETRY_RELATION_UNKNOWN}
  // The two geometries do not intersect at all.
  D2D1_GEOMETRY_RELATION_DISJOINT     = 1;
  {$EXTERNALSYM D2D1_GEOMETRY_RELATION_DISJOINT}
  // The passed in geometry is entirely contained by the object.
  D2D1_GEOMETRY_RELATION_IS_CONTAINED = 2;
  {$EXTERNALSYM D2D1_GEOMETRY_RELATION_IS_CONTAINED}
  // The object entirely contains the passed in geometry.
  D2D1_GEOMETRY_RELATION_CONTAINS     = 3;
  {$EXTERNALSYM D2D1_GEOMETRY_RELATION_CONTAINS}
  // The two geometries overlap but neither completely contains the other.
  D2D1_GEOMETRY_RELATION_OVERLAP      = 4;
  {$EXTERNALSYM D2D1_GEOMETRY_RELATION_OVERLAP}
  D2D1_GEOMETRY_RELATION_FORCE_DWORD  = $FFFFFFFF; 
  {$EXTERNALSYM D2D1_GEOMETRY_RELATION_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_GEOMETRY_SIMPLIFICATION_OPTION
//
//  Synopsis:
//      Specifies how simple the output of a simplified geometry sink should be.
// 
// ------------------------------------------------------------------------------
type
  D2D1_GEOMETRY_SIMPLIFICATION_OPTION = type Integer;
  {$EXTERNALSYM D2D1_GEOMETRY_SIMPLIFICATION_OPTION}
  TD2D1GeometrySimplificationOption = D2D1_GEOMETRY_SIMPLIFICATION_OPTION;
  PD2D1GeometrySimplificationOption = ^TD2D1GeometrySimplificationOption;
const
  D2D1_GEOMETRY_SIMPLIFICATION_OPTION_CUBICS_AND_LINES = 0; 
  {$EXTERNALSYM D2D1_GEOMETRY_SIMPLIFICATION_OPTION_CUBICS_AND_LINES}
  D2D1_GEOMETRY_SIMPLIFICATION_OPTION_LINES            = 1; 
  {$EXTERNALSYM D2D1_GEOMETRY_SIMPLIFICATION_OPTION_LINES}
  D2D1_GEOMETRY_SIMPLIFICATION_OPTION_FORCE_DWORD      = $FFFFFFFF; 
  {$EXTERNALSYM D2D1_GEOMETRY_SIMPLIFICATION_OPTION_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Enum:
//      D2D1_FIGURE_BEGIN
// 
//  Synopsis:
//      Indicates whether the given figure is filled or hollow.
//
// ------------------------------------------------------------------------------
type
  D2D1_FIGURE_BEGIN = type Integer;
  {$EXTERNALSYM D2D1_FIGURE_BEGIN}
  TD2D1FigureBegin = D2D1_FIGURE_BEGIN;
  PD2D1FigureBegin = ^TD2D1FigureBegin;
const
  D2D1_FIGURE_BEGIN_FILLED      = 0;
  {$EXTERNALSYM D2D1_FIGURE_BEGIN_FILLED}
  D2D1_FIGURE_BEGIN_HOLLOW      = 1;
  {$EXTERNALSYM D2D1_FIGURE_BEGIN_HOLLOW}
  D2D1_FIGURE_BEGIN_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_FIGURE_BEGIN_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_FIGURE_END
//
//  Synopsis:
//      Indicates whether the figure ir open or closed on its end point.
//
// ------------------------------------------------------------------------------
type
  D2D1_FIGURE_END = type Integer;
  {$EXTERNALSYM D2D1_FIGURE_END}
  TD2D1_FigureEnd = D2D1_FIGURE_END;
  PD2D1_FigureEnd = ^TD2D1_FigureEnd;
const
  D2D1_FIGURE_END_OPEN        = 0;
  {$EXTERNALSYM D2D1_FIGURE_END_OPEN}
  D2D1_FIGURE_END_CLOSED      = 1;
  {$EXTERNALSYM D2D1_FIGURE_END_CLOSED}
  D2D1_FIGURE_END_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_FIGURE_END_FORCE_DWORD}

// +-----------------------------------------------------------------------------
// 
//  Flag:
//      D2D1_PATH_SEGMENT
// 
//  Synopsis:
//      Indicates whether the given segment should be stroked, or, if the join between
//      this segment and the previous one should be smooth.
//
// ------------------------------------------------------------------------------
type
  D2D1_PATH_SEGMENT = type Integer;
  {$EXTERNALSYM D2D1_PATH_SEGMENT}
  TD2D1PathSegment = D2D1_PATH_SEGMENT;
  PD2D1PathSegment = ^TD2D1PathSegment;
const
  D2D1_PATH_SEGMENT_NONE                  = $00000000;
  {$EXTERNALSYM D2D1_PATH_SEGMENT_NONE}
  D2D1_PATH_SEGMENT_FORCE_UNSTROKED       = $00000001;
  {$EXTERNALSYM D2D1_PATH_SEGMENT_FORCE_UNSTROKED}
  D2D1_PATH_SEGMENT_FORCE_ROUND_LINE_JOIN = $00000002;
  {$EXTERNALSYM D2D1_PATH_SEGMENT_FORCE_ROUND_LINE_JOIN}
  D2D1_PATH_SEGMENT_FORCE_DWORD           = $FFFFFFFF;
  {$EXTERNALSYM D2D1_PATH_SEGMENT_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_SWEEP_DIRECTION
//
// ------------------------------------------------------------------------------
type
  D2D1_SWEEP_DIRECTION = type Integer;
  {$EXTERNALSYM D2D1_SWEEP_DIRECTION}
  TD2D1SweepDirection = D2D1_SWEEP_DIRECTION;
  PD2D1SweepDirection = ^TD2D1SweepDirection;
const
  D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE = 0;
  {$EXTERNALSYM D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE}
  D2D1_SWEEP_DIRECTION_CLOCKWISE         = 1;
  {$EXTERNALSYM D2D1_SWEEP_DIRECTION_CLOCKWISE}
  D2D1_SWEEP_DIRECTION_FORCE_DWORD       = $FFFFFFFF;
  {$EXTERNALSYM D2D1_SWEEP_DIRECTION_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_FILL_MODE
//
// ------------------------------------------------------------------------------
type
  D2D1_FILL_MODE = type Integer;
  {$EXTERNALSYM D2D1_FILL_MODE}
  TD2D1FillMode = D2D1_FILL_MODE;
  PD2D1FillMode = ^TD2D1FillMode;
const
  D2D1_FILL_MODE_ALTERNATE   = 0;
  {$EXTERNALSYM D2D1_FILL_MODE_ALTERNATE}
  D2D1_FILL_MODE_WINDING     = 1;
  {$EXTERNALSYM D2D1_FILL_MODE_WINDING}
  D2D1_FILL_MODE_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_FILL_MODE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Flag:
//      D2D1_LAYER_OPTIONS
//
//  Synopsis:
//      Specified options that can be applied when a layer resource is applied to create
//      a layer.
//
// ------------------------------------------------------------------------------
type
  D2D1_LAYER_OPTIONS = type Integer;
  {$EXTERNALSYM D2D1_LAYER_OPTIONS}
  TD2D1LayerOptions = D2D1_LAYER_OPTIONS;
  PD2D1LayerOptions = ^TD2D1LayerOptions;
const
  D2D1_LAYER_OPTIONS_NONE                     = $00000000;
  {$EXTERNALSYM D2D1_LAYER_OPTIONS_NONE}
  // The layer will render correctly for ClearType text. If the render target was set
  // to ClearType previously, the layer will continue to render ClearType. If the
  // render target was set to ClearType and this option is not specified, the render
  // target will be set to render gray-scale until the layer is popped. The caller
  // can override this default by calling SetTextAntialiasMode while within the
  // layer. This flag is slightly slower than the default.
  D2D1_LAYER_OPTIONS_INITIALIZE_FOR_CLEARTYPE = $00000001;
  {$EXTERNALSYM D2D1_LAYER_OPTIONS_INITIALIZE_FOR_CLEARTYPE}
  D2D1_LAYER_OPTIONS_FORCE_DWORD              = $FFFFFFFF;
  {$EXTERNALSYM D2D1_LAYER_OPTIONS_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Flag:
//      D2D1_WINDOW_STATE
//
// ------------------------------------------------------------------------------
type
  D2D1_WINDOW_STATE = type Integer;
  {$EXTERNALSYM D2D1_WINDOW_STATE}
  TD2D1WindowState = D2D1_WINDOW_STATE;
  PD2D1WindowState = ^TD2D1WindowState;
const
  D2D1_WINDOW_STATE_NONE        = $0000000;
  {$EXTERNALSYM D2D1_WINDOW_STATE_NONE}
  D2D1_WINDOW_STATE_OCCLUDED    = $0000001;
  {$EXTERNALSYM D2D1_WINDOW_STATE_OCCLUDED}
  D2D1_WINDOW_STATE_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_WINDOW_STATE_FORCE_DWORD}

//+-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_RENDER_TARGET_TYPE
//
//------------------------------------------------------------------------------
type
  D2D1_RENDER_TARGET_TYPE = type Integer;
  {$EXTERNALSYM D2D1_RENDER_TARGET_TYPE}
  TD2D1RenderTargetType = D2D1_RENDER_TARGET_TYPE;
  PD2D1RenderTargetType = ^TD2D1RenderTargetType;
const
  // D2D is free to choose the render target type for the caller.
  D2D1_RENDER_TARGET_TYPE_DEFAULT = 0;
  {$EXTERNALSYM D2D1_RENDER_TARGET_TYPE_DEFAULT}
  // The render target will render using the CPU.
  D2D1_RENDER_TARGET_TYPE_SOFTWARE = 1;
  {$EXTERNALSYM D2D1_RENDER_TARGET_TYPE_SOFTWARE}
  // The render target will render using the GPU.
  D2D1_RENDER_TARGET_TYPE_HARDWARE = 2;
  {$EXTERNALSYM D2D1_RENDER_TARGET_TYPE_HARDWARE}
  D2D1_RENDER_TARGET_TYPE_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_RENDER_TARGET_TYPE_FORCE_DWORD}

//+-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_FEATURE_LEVEL
//
//------------------------------------------------------------------------------
type
  D2D1_FEATURE_LEVEL = type Integer;
  {$EXTERNALSYM D2D1_FEATURE_LEVEL}
  TD2D1FeatureLevel = D2D1_FEATURE_LEVEL;
  PD2D1FeatureLevel = ^TD2D1FeatureLevel;

  D3D10_FEATURE_LEVEL1 = type Integer;
  {$EXTERNALSYM D3D10_FEATURE_LEVEL1}
  TD3D10FeatureLevel1 = D3D10_FEATURE_LEVEL1;
  PD3D10FeatureLevel1 = ^TD3D10FeatureLevel1;

const
  D3D10_FEATURE_LEVEL_10_0	= $A000;
  {$EXTERNALSYM D3D10_FEATURE_LEVEL_10_0}
  D3D10_FEATURE_LEVEL_10_1	= $A100;
  {$EXTERNALSYM D3D10_FEATURE_LEVEL_10_1}
  D3D10_FEATURE_LEVEL_9_1	= $9100;
  {$EXTERNALSYM D3D10_FEATURE_LEVEL_9_1}
  D3D10_FEATURE_LEVEL_9_2	= $9200;
  {$EXTERNALSYM D3D10_FEATURE_LEVEL_9_2}
  D3D10_FEATURE_LEVEL_9_3	= $9300;
  {$EXTERNALSYM D3D10_FEATURE_LEVEL_9_3}

  // The caller does not require a particular underlying D3D device level.
  D2D1_FEATURE_LEVEL_DEFAULT = 0;
  {$EXTERNALSYM D2D1_FEATURE_LEVEL_DEFAULT}
  // The D3D device level is DX9 compatible.
  D2D1_FEATURE_LEVEL_9 = D3D10_FEATURE_LEVEL_9_1;
  {$EXTERNALSYM D2D1_FEATURE_LEVEL_9}
  // The D3D device level is DX10 compatible.
  D2D1_FEATURE_LEVEL_10 = D3D10_FEATURE_LEVEL_10_0;
  {$EXTERNALSYM D2D1_FEATURE_LEVEL_10}
  D2D1_FEATURE_LEVEL_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_FEATURE_LEVEL_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Flag:
//      D2D1_RENDER_TARGET_USAGE
//
// ------------------------------------------------------------------------------
type
  D2D1_RENDER_TARGET_USAGE = type Integer;
  {$EXTERNALSYM D2D1_RENDER_TARGET_USAGE}
  TD2D1RenderTargetUsage = D2D1_RENDER_TARGET_USAGE;
  PD2D1RenderTargetUsage = ^TD2D1RenderTargetUsage;
const
  D2D1_RENDER_TARGET_USAGE_NONE                     = $00000000;
  {$EXTERNALSYM D2D1_RENDER_TARGET_USAGE_NONE}
  // Rendering will occur locally, if a terminal-services session is established, the
  // bitmap updates will be sent to the terminal services client.
  D2D1_RENDER_TARGET_USAGE_FORCE_BITMAP_REMOTING    = $00000001;
  {$EXTERNALSYM D2D1_RENDER_TARGET_USAGE_FORCE_BITMAP_REMOTING}
  // The render target will allow a call to GetDC on the IGdiInteropRenderTarget
  // interface. Rendering will also occur locally.
  D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE           = $00000002;
  {$EXTERNALSYM D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE}
  D2D1_RENDER_TARGET_USAGE_FORCE_DWORD              = $FFFFFFFF;
  {$EXTERNALSYM D2D1_RENDER_TARGET_USAGE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Flag:
//      D2D1_PRESENT_OPTIONS
//
//  Synopsis:
//      Describes how present should behave.
//
// ------------------------------------------------------------------------------
type
  D2D1_PRESENT_OPTIONS = type Integer;
  {$EXTERNALSYM D2D1_PRESENT_OPTIONS}
  TD2D1PresentOptions = D2D1_PRESENT_OPTIONS;
  PD2D1PresentOptions = ^TD2D1PresentOptions;
const
  D2D1_PRESENT_OPTIONS_NONE            = $00000000;
  {$EXTERNALSYM D2D1_PRESENT_OPTIONS_NONE}
  D2D1_PRESENT_OPTIONS_RETAIN_CONTENTS = $00000001; // Keep the target contents intact
                                                    // through present.
  {$EXTERNALSYM D2D1_PRESENT_OPTIONS_RETAIN_CONTENTS}
  D2D1_PRESENT_OPTIONS_IMMEDIATELY     = $00000002; // Do not wait for display refresh
                                                    // to commit changes to display.
  {$EXTERNALSYM D2D1_PRESENT_OPTIONS_IMMEDIATELY}
  D2D1_PRESENT_OPTIONS_FORCE_DWORD     = $FFFFFFFF;
  {$EXTERNALSYM D2D1_PRESENT_OPTIONS_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Flag:
//      D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS
//
// ------------------------------------------------------------------------------
type
  D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS = type Integer;
  {$EXTERNALSYM D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS}
  TD2D1CompatibleRenderTargetOptions = D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS;
  PD2D1CompatibleRenderTargetOptions = ^TD2D1CompatibleRenderTargetOptions;
const
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_NONE           = $00000000;
  {$EXTERNALSYM D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_NONE}
  // The compatible render target will allow a call to GetDC on the
  // IGdiInteropRenderTarget interface. This can be specified even if the parent
  // render target is not GDI compatible.
  D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_GDI_COMPATIBLE = $00000001;
  {$EXTERNALSYM D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_GDI_COMPATIBLE}
  D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_FORCE_DWORD    = $FFFFFFFF;
  {$EXTERNALSYM D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_DC_INITIALIZE_MODE
//
// ------------------------------------------------------------------------------
type
  D2D1_DC_INITIALIZE_MODE = type Integer;
  {$EXTERNALSYM D2D1_DC_INITIALIZE_MODE}
  TD2D1DCInitializeMode = D2D1_DC_INITIALIZE_MODE;
  PD2D1DCInitializeMode = ^TD2D1DCInitializeMode;
const
  // The contents of the D2D render target will be copied to the DC.
  D2D1_DC_INITIALIZE_MODE_COPY        = 0;
  {$EXTERNALSYM D2D1_DC_INITIALIZE_MODE_COPY}
  // The contents of the DC will be cleared.
  D2D1_DC_INITIALIZE_MODE_CLEAR       = 1;
  {$EXTERNALSYM D2D1_DC_INITIALIZE_MODE_CLEAR}
  D2D1_DC_INITIALIZE_MODE_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_DC_INITIALIZE_MODE_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_DEBUG_LEVEL
//
//  Synopsis:
//      Indicates the debug level to be outputed by the debug layer.
//
// ------------------------------------------------------------------------------
type
  D2D1_DEBUG_LEVEL = type Integer;
  {$EXTERNALSYM D2D1_DEBUG_LEVEL}
  TD2D1DebugLevel = D2D1_DEBUG_LEVEL;
  PD2D1DebugLevel = ^TD2D1DebugLevel;
const
  D2D1_DEBUG_LEVEL_NONE        = 0;
  {$EXTERNALSYM D2D1_DEBUG_LEVEL_NONE}
  D2D1_DEBUG_LEVEL_ERROR       = 1;
  {$EXTERNALSYM D2D1_DEBUG_LEVEL_ERROR}
  D2D1_DEBUG_LEVEL_WARNING     = 2;
  {$EXTERNALSYM D2D1_DEBUG_LEVEL_WARNING}
  D2D1_DEBUG_LEVEL_INFORMATION = 3;
  {$EXTERNALSYM D2D1_DEBUG_LEVEL_INFORMATION}
  D2D1_DEBUG_LEVEL_FORCE_DWORD = $FFFFFFFF;
  {$EXTERNALSYM D2D1_DEBUG_LEVEL_FORCE_DWORD}

// +-----------------------------------------------------------------------------
//
//  Enum:
//      D2D1_FACTORY_TYPE
//
//  Synopsis:
//      Specifies the threading model of the created factory and all of its derived
//      resources.
//
// ------------------------------------------------------------------------------
type
  D2D1_FACTORY_TYPE = type Integer;
  {$EXTERNALSYM D2D1_FACTORY_TYPE}
  TD2D1FactoryType = D2D1_FACTORY_TYPE;
  PD2D1FactoryType = ^TD2D1FactoryType;
const
  D2D1_FACTORY_TYPE_SINGLE_THREADED = 0; // The resulting factory and derived resources
                                         // may only be invoked serially. Reference
                                         // counts on resources are interlocked,
                                         // however, resource and render target state
                                         // is not protected from multi-threaded access.
  {$EXTERNALSYM D2D1_FACTORY_TYPE_SINGLE_THREADED}
  D2D1_FACTORY_TYPE_MULTI_THREADED  = 1; // The resulting factory may be invoked from
                                         // multiple threads. Returned resources use
                                         // interlocked reference counting and their
                                         // state is protected.
  {$EXTERNALSYM D2D1_FACTORY_TYPE_MULTI_THREADED}
  D2D1_FACTORY_TYPE_FORCE_DWORD     = $FFFFFFFF;
  {$EXTERNALSYM D2D1_FACTORY_TYPE_FORCE_DWORD}

type
  HMONITOR = THandle;
  {$EXTERNALSYM HMONITOR}

//// DWrite.h : Consts, Enums, Flags

// The type of a font represented by a single font file.
// Font formats that consist of multiple files, e.g. Type 1 .PFM and .PFB, have
// separate enum values for each of the file type.
type
  DWRITE_FONT_FILE_TYPE = type Integer;
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE}
  TDWriteFontFileType = DWRITE_FONT_FILE_TYPE;
  PDWriteFontFileType = ^TDWriteFontFileType;
const
  DWRITE_FONT_FILE_TYPE_UNKNOWN             = 0; // Font type is not recognized by the DirectWrite font system.
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE_UNKNOWN}
  DWRITE_FONT_FILE_TYPE_CFF                 = 1; // OpenType font with CFF outlines.
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE_CFF}
  DWRITE_FONT_FILE_TYPE_TRUETYPE            = 2; // OpenType font with TrueType outlines.
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE_TRUETYPE}
  DWRITE_FONT_FILE_TYPE_TRUETYPE_COLLECTION = 3; // OpenType font that contains a TrueType collection.
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE_TRUETYPE_COLLECTION}
  DWRITE_FONT_FILE_TYPE_TYPE1_PFM           = 4; // Type 1 PFM font.
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE_TYPE1_PFM}
  DWRITE_FONT_FILE_TYPE_TYPE1_PFB           = 5; // Type 1 PFB font.
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE_TYPE1_PFB}
  DWRITE_FONT_FILE_TYPE_VECTOR              = 6; // Vector .FON font.
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE_VECTOR}
  DWRITE_FONT_FILE_TYPE_BITMAP              = 7; // Bitmap .FON font.
  {$EXTERNALSYM DWRITE_FONT_FILE_TYPE_BITMAP}

// The file format of a complete font face.
// Font formats that consist of multiple files, e.g. Type 1 .PFM and .PFB, have
// a single enum entry.
type
  DWRITE_FONT_FACE_TYPE = type Integer;
  {$EXTERNALSYM DWRITE_FONT_FACE_TYPE}
  TDWriteFontFaceType = DWRITE_FONT_FACE_TYPE;
  PDWriteFontFaceType = ^TDWriteFontFaceType;
const
  DWRITE_FONT_FACE_TYPE_CFF                 = 0; // OpenType font face with CFF outlines.
  {$EXTERNALSYM DWRITE_FONT_FACE_TYPE_CFF}
  DWRITE_FONT_FACE_TYPE_TRUETYPE            = 1; // OpenType font face with TrueType outlines.
  {$EXTERNALSYM DWRITE_FONT_FACE_TYPE_TRUETYPE}
  DWRITE_FONT_FACE_TYPE_TRUETYPE_COLLECTION = 2; // OpenType font face that is a part of a TrueType collection.
  {$EXTERNALSYM DWRITE_FONT_FACE_TYPE_TRUETYPE_COLLECTION}
  DWRITE_FONT_FACE_TYPE_TYPE1               = 3; // A Type 1 font face.
  {$EXTERNALSYM DWRITE_FONT_FACE_TYPE_TYPE1}
  DWRITE_FONT_FACE_TYPE_VECTOR              = 4; // A vector .FON format font face.
  {$EXTERNALSYM DWRITE_FONT_FACE_TYPE_VECTOR}
  DWRITE_FONT_FACE_TYPE_BITMAP              = 5; // A bitmap .FON format font face.
  {$EXTERNALSYM DWRITE_FONT_FACE_TYPE_BITMAP}
  DWRITE_FONT_FACE_TYPE_UNKNOWN             = 6; // Font face type is not recognized by the DirectWrite font system.
  {$EXTERNALSYM DWRITE_FONT_FACE_TYPE_UNKNOWN}

// Specifies algorithmic style simulations to be applied to the font face.
// Bold and oblique simulations can be combined via bitwise OR operation.
type
  DWRITE_FONT_SIMULATIONS = type Integer;
  {$EXTERNALSYM DWRITE_FONT_SIMULATIONS}
  TDWriteFontSimulations = DWRITE_FONT_SIMULATIONS;
  PDWriteFontSimulations = ^TDWriteFontSimulations;
const
  DWRITE_FONT_SIMULATIONS_NONE    = $0000;  // No simulations are performed.
  {$EXTERNALSYM DWRITE_FONT_SIMULATIONS_NONE}
  DWRITE_FONT_SIMULATIONS_BOLD    = $0001;  // Algorithmic emboldening is performed.
  {$EXTERNALSYM DWRITE_FONT_SIMULATIONS_BOLD}
  DWRITE_FONT_SIMULATIONS_OBLIQUE = $0002;  // Algorithmic italicization is performed.
  {$EXTERNALSYM DWRITE_FONT_SIMULATIONS_OBLIQUE}

// The font weight enumeration describes common values for degree of blackness or thickness of strokes of characters in a font.
// Font weight values less than 1 or greater than 999 are considered to be invalid, and they are rejected by font API functions.
type
  DWRITE_FONT_WEIGHT = type Integer;
  {$EXTERNALSYM DWRITE_FONT_WEIGHT}
  TDWriteFontWeight = DWRITE_FONT_WEIGHT;
  PDWriteFontWeight = ^TDWriteFontWeight;
const
  DWRITE_FONT_WEIGHT_THIN        = 100;  // Predefined font weight : Thin (100).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_THIN}
  DWRITE_FONT_WEIGHT_EXTRA_LIGHT = 200;  // Predefined font weight : Extra-light (200).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_EXTRA_LIGHT}
  DWRITE_FONT_WEIGHT_ULTRA_LIGHT = 200;  // Predefined font weight : Ultra-light (200).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_ULTRA_LIGHT}
  DWRITE_FONT_WEIGHT_LIGHT       = 300;  // Predefined font weight : Light (300).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_LIGHT}
  DWRITE_FONT_WEIGHT_NORMAL      = 400;  // Predefined font weight : Normal (400).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_NORMAL}
  DWRITE_FONT_WEIGHT_REGULAR     = 400;  // Predefined font weight : Regular (400).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_REGULAR}
  DWRITE_FONT_WEIGHT_MEDIUM      = 500;  // Predefined font weight : Medium (500).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_MEDIUM}
  DWRITE_FONT_WEIGHT_DEMI_BOLD   = 600;  // Predefined font weight : Demi-bold (600).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_DEMI_BOLD}
  DWRITE_FONT_WEIGHT_SEMI_BOLD   = 600;  // Predefined font weight : Semi-bold (600).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_SEMI_BOLD}
  DWRITE_FONT_WEIGHT_BOLD        = 700;  // Predefined font weight : Bold (700).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_BOLD}
  DWRITE_FONT_WEIGHT_EXTRA_BOLD  = 800;  // Predefined font weight : Extra-bold (800).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_EXTRA_BOLD}
  DWRITE_FONT_WEIGHT_ULTRA_BOLD  = 800;  // Predefined font weight : Ultra-bold (800).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_ULTRA_BOLD}
  DWRITE_FONT_WEIGHT_BLACK       = 900;  // Predefined font weight : Black (900).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_BLACK}
  DWRITE_FONT_WEIGHT_HEAVY       = 900;  // Predefined font weight : Heavy (900).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_HEAVY}
  DWRITE_FONT_WEIGHT_EXTRA_BLACK = 950;  // Predefined font weight : Extra-black (950).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_EXTRA_BLACK}
  DWRITE_FONT_WEIGHT_ULTRA_BLACK = 950;  // Predefined font weight : Ultra-black (950).
  {$EXTERNALSYM DWRITE_FONT_WEIGHT_ULTRA_BLACK}

// The font stretch enumeration describes relative change from the normal aspect ratio
// as specified by a font designer for the glyphs in a font.
// Values less than 1 or greater than 9 are considered to be invalid, and they are rejected by font API functions.
type
  DWRITE_FONT_STRETCH = type Integer;
  {$EXTERNALSYM DWRITE_FONT_STRETCH}
  TDWriteFontStretch = DWRITE_FONT_STRETCH;
  PDWriteFontStretch = ^TDWriteFontStretch;
const
  DWRITE_FONT_STRETCH_UNDEFINED       = 0;  // Predefined font stretch : Not known (0).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_UNDEFINED}
  DWRITE_FONT_STRETCH_ULTRA_CONDENSED = 1;  // Predefined font stretch : Ultra-condensed (1).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_ULTRA_CONDENSED}
  DWRITE_FONT_STRETCH_EXTRA_CONDENSED = 2;  // Predefined font stretch : Extra-condensed (2).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_EXTRA_CONDENSED}
  DWRITE_FONT_STRETCH_CONDENSED       = 3;  // Predefined font stretch : Condensed (3).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_CONDENSED}
  DWRITE_FONT_STRETCH_SEMI_CONDENSED  = 4;  // Predefined font stretch : Semi-condensed (4).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_SEMI_CONDENSED}
  DWRITE_FONT_STRETCH_NORMAL          = 5;  // Predefined font stretch : Normal (5).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_NORMAL}
  DWRITE_FONT_STRETCH_MEDIUM          = 5;  // Predefined font stretch : Medium (5).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_MEDIUM}
  DWRITE_FONT_STRETCH_SEMI_EXPANDED   = 6;  // Predefined font stretch : Semi-expanded (6).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_SEMI_EXPANDED}
  DWRITE_FONT_STRETCH_EXPANDED        = 7;  // Predefined font stretch : Expanded (7).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_EXPANDED}
  DWRITE_FONT_STRETCH_EXTRA_EXPANDED  = 8;  // Predefined font stretch : Extra-expanded (8).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_EXTRA_EXPANDED}
  DWRITE_FONT_STRETCH_ULTRA_EXPANDED  = 9;  // Predefined font stretch : Ultra-expanded (9).
  {$EXTERNALSYM DWRITE_FONT_STRETCH_ULTRA_EXPANDED}

// The font style enumeration describes the slope style of a font face, such as Normal, Italic or Oblique.
// Values other than the ones defined in the enumeration are considered to be invalid, and they are rejected by font API functions.
type
  DWRITE_FONT_STYLE = type Integer;
  TDWriteFontStyle = DWRITE_FONT_STYLE;
  PDWriteFontStyle = ^TDWriteFontStyle;
const
  DWRITE_FONT_STYLE_NORMAL  = 0; // Font slope style : Normal.
  {$EXTERNALSYM DWRITE_FONT_STYLE_NORMAL}
  DWRITE_FONT_STYLE_OBLIQUE = 1; // Font slope style : Oblique.
  {$EXTERNALSYM DWRITE_FONT_STYLE_OBLIQUE}
  DWRITE_FONT_STYLE_ITALIC  = 2; // Font slope style : Italic.
  {$EXTERNALSYM DWRITE_FONT_STYLE_ITALIC}

// The informational string enumeration identifies a string in a font.
type
  DWRITE_INFORMATIONAL_STRING_ID = type Integer;
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_ID}
  TDWriteInformationalStringID = DWRITE_INFORMATIONAL_STRING_ID;
  PDWriteInformationalStringID = ^TDWriteInformationalStringID;
const
  DWRITE_INFORMATIONAL_STRING_NONE                      = 0;  // Unspecified name ID.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_NONE}
  DWRITE_INFORMATIONAL_STRING_COPYRIGHT_NOTICE          = 1;  // Copyright notice provided by the font.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_COPYRIGHT_NOTICE}
  DWRITE_INFORMATIONAL_STRING_VERSION_STRINGS           = 2;  // String containing a version number.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_VERSION_STRINGS}
  DWRITE_INFORMATIONAL_STRING_TRADEMARK                 = 3;  // Trademark information provided by the font.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_TRADEMARK}
  DWRITE_INFORMATIONAL_STRING_MANUFACTURER              = 4;  // Name of the font manufacturer.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_MANUFACTURER}
  DWRITE_INFORMATIONAL_STRING_DESIGNER                  = 5;  // Name of the font designer.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_DESIGNER}
  DWRITE_INFORMATIONAL_STRING_DESIGNER_URL              = 6;  // URL of font designer (with protocol, e.g., http:// , ftp:// ).
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_DESIGNER_URL}
  DWRITE_INFORMATIONAL_STRING_DESCRIPTION               = 7;  // Description of the font. Can contain revision information,
                                                              // usage recommendations, history, features, etc.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_DESCRIPTION}
  DWRITE_INFORMATIONAL_STRING_FONT_VENDOR_URL           = 8;  // URL of font vendor (with protocol, e.g., http:// , ftp:// ). 
                                                              // If a unique serial number is embedded in the URL, it can be
                                                              // used to register the font.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_FONT_VENDOR_URL}
  DWRITE_INFORMATIONAL_STRING_LICENSE_DESCRIPTION       = 9;  // Description of how the font may be legally used, or different
                                                              // example scenarios for licensed use. This field should be 
                                                              // written in plain language, not legalese.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_LICENSE_DESCRIPTION}
  
  DWRITE_INFORMATIONAL_STRING_LICENSE_INFO_URL          = 10; // URL where additional licensing information can be found.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_LICENSE_INFO_URL}

  DWRITE_INFORMATIONAL_STRING_WIN32_FAMILY_NAMES        = 11; // GDI-compatible family name. Because GDI allows a maximum of 
                                                              // four fonts per family, fonts in the same family may have different
                                                              // GDI-compatible family names (e.g., "Arial", "Arial Narrow", "Arial Black").
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_WIN32_FAMILY_NAMES}

  DWRITE_INFORMATIONAL_STRING_WIN32_SUBFAMILY_NAMES     = 12; // GDI-compatible subfamily name.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_WIN32_SUBFAMILY_NAMES}
  
  DWRITE_INFORMATIONAL_STRING_PREFERRED_FAMILY_NAMES    = 13; // Family name preferred by the designer. This enables font 
                                                              // designers to group more than four fonts in a single family
                                                              // without losing compatibility with GDI. This name is typically
                                                              // only present if it differs from the GDI-compatible family name.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_PREFERRED_FAMILY_NAMES}
  
  DWRITE_INFORMATIONAL_STRING_PREFERRED_SUBFAMILY_NAMES = 14; // Subfamily name preferred by the designer. This name is typically
                                                              // only present if it differs from the GDI-compatible subfamily name.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_PREFERRED_SUBFAMILY_NAMES}
  
  DWRITE_INFORMATIONAL_STRING_SAMPLE_TEXT               = 15; // Sample text. This can be the font name or any other text that the
                                                              // designer thinks is the best example to display the font in.
  {$EXTERNALSYM DWRITE_INFORMATIONAL_STRING_SAMPLE_TEXT}

// Specifies the type of DirectWrite factory object.
// DirectWrite factory contains internal state such as font loader registration and cached font data.
// In most cases it is recommended to use the shared factory object, because it allows multiple components
// that use DirectWrite to share internal DirectWrite state and reduce memory usage.
// However, there are cases when it is desirable to reduce the impact of a component,
// such as a plug-in from an untrusted source, on the rest of the process by sandboxing and isolating it
// from the rest of the process components. In such cases, it is recommended to use an isolated factory for the sandboxed
// component.
type
  DWRITE_FACTORY_TYPE = type Integer;
  {$EXTERNALSYM DWRITE_FACTORY_TYPE}
  TDWriteFactoryType = DWRITE_FACTORY_TYPE;
  PDWriteFactoryType = ^TDWriteFactoryType;
const
  // Shared factory allow for re-use of cached font data across multiple in process components.
  // Such factories also take advantage of cross process font caching components for better performance.
  DWRITE_FACTORY_TYPE_SHARED   = 0;
  {$EXTERNALSYM DWRITE_FACTORY_TYPE_SHARED}
  // Objects created from the isolated factory do not interact with internal DirectWrite state from other components.
  DWRITE_FACTORY_TYPE_ISOLATED = 1;
  {$EXTERNALSYM DWRITE_FACTORY_TYPE_ISOLATED}

// Represents the internal structure of a device pixel (i.e., the physical arrangement of red,
// green, and blue color components) that is assumed for purposes of rendering text.
type
  DWRITE_PIXEL_GEOMETRY = type Integer;
  {$EXTERNALSYM DWRITE_PIXEL_GEOMETRY}
  TDWritePixelGeometry = DWRITE_PIXEL_GEOMETRY;
  PDWritePixelGeometry = ^TDWritePixelGeometry;
const
  // The red, green, and blue color components of each pixel are assumed to occupy the same point.
  DWRITE_PIXEL_GEOMETRY_FLAT = 0;
  {$EXTERNALSYM DWRITE_PIXEL_GEOMETRY_FLAT}
  // Each pixel comprises three vertical stripes, with red on the left, green in the center, and
  // blue on the right. This is the most common pixel geometry for LCD monitors.
  DWRITE_PIXEL_GEOMETRY_RGB  = 1;
  {$EXTERNALSYM DWRITE_PIXEL_GEOMETRY_RGB}
  // Each pixel comprises three vertical stripes, with blue on the left, green in the center, and
  // red on the right.
  DWRITE_PIXEL_GEOMETRY_BGR  = 2;
  {$EXTERNALSYM DWRITE_PIXEL_GEOMETRY_BGR}

// Represents a method of rendering glyphs.
type
  DWRITE_RENDERING_MODE = type Integer;
  {$EXTERNALSYM DWRITE_RENDERING_MODE}
  TDWriteRenderingMode = DWRITE_RENDERING_MODE;
  PDWriteRenderingMode = ^TDWriteRenderingMode;
const
  // Specifies that the rendering mode is determined automatically based on the font and size.
  DWRITE_RENDERING_MODE_DEFAULT = 0;
  {$EXTERNALSYM DWRITE_RENDERING_MODE_DEFAULT}
  // Specifies that no anti-aliasing is performed. Each pixel is either set to the foreground
  // color of the text or retains the color of the background.
  DWRITE_RENDERING_MODE_ALIASED = 1;
  {$EXTERNALSYM DWRITE_RENDERING_MODE_ALIASED}
  // Specifies ClearType rendering with the same metrics as aliased text. Glyphs can only
  // be positioned on whole-pixel boundaries.
  DWRITE_RENDERING_MODE_CLEARTYPE_GDI_CLASSIC = 2;
  {$EXTERNALSYM DWRITE_RENDERING_MODE_CLEARTYPE_GDI_CLASSIC}
  // Specifies ClearType rendering with the same metrics as text rendering using GDI using a font
  // created with CLEARTYPE_NATURAL_QUALITY. Glyph metrics are closer to their ideal values than
  // with aliased text, but glyphs are still positioned on whole-pixel boundaries.
  DWRITE_RENDERING_MODE_CLEARTYPE_GDI_NATURAL = 3;
  {$EXTERNALSYM DWRITE_RENDERING_MODE_CLEARTYPE_GDI_NATURAL}
  // Specifies ClearType rendering with anti-aliasing in the horizontal dimension only. This is
  // typically used with small to medium font sizes (up to 16 ppem).
  DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL = 4;
  {$EXTERNALSYM DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL}
  // Specifies ClearType rendering with anti-aliasing in both horizontal and vertical dimensions.
  // This is typically used at larger sizes to makes curves and diagonal lines look smoother, at
  // the expense of some softness.
  DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL_SYMMETRIC = 5;
  {$EXTERNALSYM DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL_SYMMETRIC}
  // Specifies that rendering should bypass the rasterizer and use the outlines directly. This is
  // typically used at very large sizes.
  DWRITE_RENDERING_MODE_OUTLINE = 6;
  {$EXTERNALSYM DWRITE_RENDERING_MODE_OUTLINE}

// Direction for how reading progresses.
type
  DWRITE_READING_DIRECTION = type Integer;
  {$EXTERNALSYM DWRITE_READING_DIRECTION}
  TDWriteReadingDirection = DWRITE_READING_DIRECTION;
  PDWriteReadingDirection = ^TDWriteReadingDirection;
const
  DWRITE_READING_DIRECTION_LEFT_TO_RIGHT = 0; // Reading progresses from left to right.
  {$EXTERNALSYM DWRITE_READING_DIRECTION_LEFT_TO_RIGHT}
  DWRITE_READING_DIRECTION_RIGHT_TO_LEFT = 1; // Reading progresses from right to left.
  {$EXTERNALSYM DWRITE_READING_DIRECTION_RIGHT_TO_LEFT}

// Direction for how lines of text are placed relative to one another.
type
  DWRITE_FLOW_DIRECTION = type Integer;
  {$EXTERNALSYM DWRITE_FLOW_DIRECTION}
  TDWriteFlowDirection = DWRITE_FLOW_DIRECTION;
  PDWriteFlowDirection = ^TDWriteFlowDirection;
const
  DWRITE_FLOW_DIRECTION_TOP_TO_BOTTOM = 0; // Text lines are placed from top to bottom.
  {$EXTERNALSYM DWRITE_FLOW_DIRECTION_TOP_TO_BOTTOM}

// Alignment of paragraph text along the reading direction axis relative to
// the leading and trailing edge of the layout box.
type
  DWRITE_TEXT_ALIGNMENT = type Integer;
  {$EXTERNALSYM DWRITE_TEXT_ALIGNMENT}
  TDWriteTextAlignment = DWRITE_TEXT_ALIGNMENT;
  PDWriteTextAlignment = ^TDWriteTextAlignment;
const
  // The leading edge of the paragraph text is aligned to the layout box's leading edge.
  DWRITE_TEXT_ALIGNMENT_LEADING = 0;
  {$EXTERNALSYM DWRITE_TEXT_ALIGNMENT_LEADING}
  // The trailing edge of the paragraph text is aligned to the layout box's trailing edge.
  DWRITE_TEXT_ALIGNMENT_TRAILING = 1;
  {$EXTERNALSYM DWRITE_TEXT_ALIGNMENT_TRAILING}
  // The center of the paragraph text is aligned to the center of the layout box.
  DWRITE_TEXT_ALIGNMENT_CENTER = 2;
  {$EXTERNALSYM DWRITE_TEXT_ALIGNMENT_CENTER}

// Alignment of paragraph text along the flow direction axis relative to the
// flow's beginning and ending edge of the layout box.
type
  DWRITE_PARAGRAPH_ALIGNMENT = type Integer;
  {$EXTERNALSYM DWRITE_PARAGRAPH_ALIGNMENT}
  TDWriteParagraphAlignment = DWRITE_PARAGRAPH_ALIGNMENT;
  PDWriteParagraphAlignment = ^TDWriteParagraphAlignment;
const
  // The first line of paragraph is aligned to the flow's beginning edge of the layout box.
  DWRITE_PARAGRAPH_ALIGNMENT_NEAR = 0;
  {$EXTERNALSYM DWRITE_PARAGRAPH_ALIGNMENT_NEAR}
  // The last line of paragraph is aligned to the flow's ending edge of the layout box.
  DWRITE_PARAGRAPH_ALIGNMENT_FAR = 1;
  {$EXTERNALSYM DWRITE_PARAGRAPH_ALIGNMENT_FAR}
  // The center of the paragraph is aligned to the center of the flow of the layout box.
  DWRITE_PARAGRAPH_ALIGNMENT_CENTER = 2;
  {$EXTERNALSYM DWRITE_PARAGRAPH_ALIGNMENT_CENTER}

// Word wrapping in multiline paragraph.
type
  DWRITE_WORD_WRAPPING = type Integer;
  {$EXTERNALSYM DWRITE_WORD_WRAPPING}
  TDWriteWordWrapping = DWRITE_WORD_WRAPPING;
  PDWriteWordWrapping = ^TDWriteWordWrapping;
const
  // Words are broken across lines to avoid text overflowing the layout box.
  DWRITE_WORD_WRAPPING_WRAP = 0;
  {$EXTERNALSYM DWRITE_WORD_WRAPPING_WRAP}
  // Words are kept within the same line even when it overflows the layout box.
  // This option is often used with scrolling to reveal overflow text.
  DWRITE_WORD_WRAPPING_NO_WRAP = 1;
  {$EXTERNALSYM DWRITE_WORD_WRAPPING_NO_WRAP}

// The method used for line spacing in layout.
type
  DWRITE_LINE_SPACING_METHOD = type Integer;
  {$EXTERNALSYM DWRITE_LINE_SPACING_METHOD}
  TDWwriteLineSpacingMethod = DWRITE_LINE_SPACING_METHOD;
  PDWwriteLineSpacingMethod = ^TDWwriteLineSpacingMethod;
const
  // Line spacing depends solely on the content, growing to accomodate the size of fonts and inline objects.
  DWRITE_LINE_SPACING_METHOD_DEFAULT = 0;
  {$EXTERNALSYM DWRITE_LINE_SPACING_METHOD_DEFAULT}
  // Lines are explicitly set to uniform spacing, regardless of contained font sizes.
  // This can be useful to avoid the uneven appearance that can occur from font fallback.
  DWRITE_LINE_SPACING_METHOD_UNIFORM = 1;
  {$EXTERNALSYM DWRITE_LINE_SPACING_METHOD_UNIFORM}

// Text granularity used to trim text overflowing the layout box.
type
  DWRITE_TRIMMING_GRANULARITY = type Integer;
  {$EXTERNALSYM DWRITE_TRIMMING_GRANULARITY}
  TDWriteTrimmingGranularity = DWRITE_TRIMMING_GRANULARITY;
  PDWriteTrimmingGranularity = ^TDWriteTrimmingGranularity;
const
  DWRITE_TRIMMING_GRANULARITY_NONE      = 0; // No trimming occurs. Text flows beyond the layout width.
  {$EXTERNALSYM DWRITE_TRIMMING_GRANULARITY_NONE}
  DWRITE_TRIMMING_GRANULARITY_CHARACTER = 1; // Trimming occurs at character cluster boundary.
  {$EXTERNALSYM DWRITE_TRIMMING_GRANULARITY_CHARACTER}
  DWRITE_TRIMMING_GRANULARITY_WORD      = 2; // Trimming occurs at word boundary.
  {$EXTERNALSYM DWRITE_TRIMMING_GRANULARITY_WORD}

// Typographic feature of text supplied by the font.
type
  DWRITE_FONT_FEATURE_TAG = type Integer;
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG}
  TDWriteFontFeatureTag = DWRITE_FONT_FEATURE_TAG;
  PDWriteFontFeatureTag = ^TDWriteFontFeatureTag;
const
  DWRITE_FONT_FEATURE_TAG_ALTERNATIVE_FRACTIONS           = $63726661;        // 'afrc'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_ALTERNATIVE_FRACTIONS}
  DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS_FROM_CAPITALS   = $63703263;        // 'c2pc'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS_FROM_CAPITALS}
  DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS_FROM_CAPITALS    = $63733263;        // 'c2sc'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS_FROM_CAPITALS}
  DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_ALTERNATES           = $746C6163;        // 'calt'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_ALTERNATES}
  DWRITE_FONT_FEATURE_TAG_CASE_SENSITIVE_FORMS            = $65736163;        // 'case'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_CASE_SENSITIVE_FORMS}
  DWRITE_FONT_FEATURE_TAG_GLYPH_COMPOSITION_DECOMPOSITION = $706D6363;        // 'ccmp'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_GLYPH_COMPOSITION_DECOMPOSITION}
  DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_LIGATURES            = $67696C63;        // 'clig'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_LIGATURES}
  DWRITE_FONT_FEATURE_TAG_CAPITAL_SPACING                 = $70737063;        // 'cpsp'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_CAPITAL_SPACING}
  DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_SWASH                = $68777363;        // 'cswh'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_SWASH}
  DWRITE_FONT_FEATURE_TAG_CURSIVE_POSITIONING             = $73727563;        // 'curs'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_CURSIVE_POSITIONING}
  DWRITE_FONT_FEATURE_TAG_DEFAULT                         = $746C6664;        // 'dflt'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_DEFAULT}
  DWRITE_FONT_FEATURE_TAG_DISCRETIONARY_LIGATURES         = $67696C64;        // 'dlig'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_DISCRETIONARY_LIGATURES}
  DWRITE_FONT_FEATURE_TAG_EXPERT_FORMS                    = $74707865;        // 'expt'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_EXPERT_FORMS}
  DWRITE_FONT_FEATURE_TAG_FRACTIONS                       = $63617266;        // 'frac'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_FRACTIONS}
  DWRITE_FONT_FEATURE_TAG_FULL_WIDTH                      = $64697766;        // 'fwid'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_FULL_WIDTH}
  DWRITE_FONT_FEATURE_TAG_HALF_FORMS                      = $666C6168;        // 'half'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_HALF_FORMS}
  DWRITE_FONT_FEATURE_TAG_HALANT_FORMS                    = $6E6C6168;        // 'haln'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_HALANT_FORMS}
  DWRITE_FONT_FEATURE_TAG_ALTERNATE_HALF_WIDTH            = $746C6168;        // 'halt'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_ALTERNATE_HALF_WIDTH}
  DWRITE_FONT_FEATURE_TAG_HISTORICAL_FORMS                = $74736968;        // 'hist'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_HISTORICAL_FORMS}
  DWRITE_FONT_FEATURE_TAG_HORIZONTAL_KANA_ALTERNATES      = $616E6B68;        // 'hkna'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_HORIZONTAL_KANA_ALTERNATES}
  DWRITE_FONT_FEATURE_TAG_HISTORICAL_LIGATURES            = $67696C68;        // 'hlig'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_HISTORICAL_LIGATURES}
  DWRITE_FONT_FEATURE_TAG_HALF_WIDTH                      = $64697768;        // 'hwid'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_HALF_WIDTH}
  DWRITE_FONT_FEATURE_TAG_HOJO_KANJI_FORMS                = $6F6A6F68;        // 'hojo'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_HOJO_KANJI_FORMS}
  DWRITE_FONT_FEATURE_TAG_JIS04_FORMS                     = $3430706A;        // 'jp04'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_JIS04_FORMS}
  DWRITE_FONT_FEATURE_TAG_JIS78_FORMS                     = $3837706A;        // 'jp78'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_JIS78_FORMS}
  DWRITE_FONT_FEATURE_TAG_JIS83_FORMS                     = $3338706A;        // 'jp83'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_JIS83_FORMS}
  DWRITE_FONT_FEATURE_TAG_JIS90_FORMS                     = $3039706A;        // 'jp90'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_JIS90_FORMS}
  DWRITE_FONT_FEATURE_TAG_KERNING                         = $6E72656B;        // 'kern'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_KERNING}
  DWRITE_FONT_FEATURE_TAG_STANDARD_LIGATURES              = $6167696C;        // 'liga'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STANDARD_LIGATURES}
  DWRITE_FONT_FEATURE_TAG_LINING_FIGURES                  = $6D756E6C;        // 'lnum'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_LINING_FIGURES}
  DWRITE_FONT_FEATURE_TAG_LOCALIZED_FORMS                 = $6C636F6C;        // 'locl'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_LOCALIZED_FORMS}
  DWRITE_FONT_FEATURE_TAG_MARK_POSITIONING                = $6B72616D;        // 'mark'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_MARK_POSITIONING}
  DWRITE_FONT_FEATURE_TAG_MATHEMATICAL_GREEK              = $6B72676D;        // 'mgrk'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_MATHEMATICAL_GREEK}
  DWRITE_FONT_FEATURE_TAG_MARK_TO_MARK_POSITIONING        = $6B6D6B6D;        // 'mkmk'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_MARK_TO_MARK_POSITIONING}
  DWRITE_FONT_FEATURE_TAG_ALTERNATE_ANNOTATION_FORMS      = $746C616E;        // 'nalt'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_ALTERNATE_ANNOTATION_FORMS}
  DWRITE_FONT_FEATURE_TAG_NLC_KANJI_FORMS                 = $6B636C6E;        // 'nlck'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_NLC_KANJI_FORMS}
  DWRITE_FONT_FEATURE_TAG_OLD_STYLE_FIGURES               = $6D756E6F;        // 'onum'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_OLD_STYLE_FIGURES}
  DWRITE_FONT_FEATURE_TAG_ORDINALS                        = $6E64726F;        // 'ordn'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_ORDINALS}
  DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_ALTERNATE_WIDTH    = $746C6170;        // 'palt'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_ALTERNATE_WIDTH}
  DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS                 = $70616370;        // 'pcap'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS}
  DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_FIGURES            = $6D756E70;        // 'pnum'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_FIGURES}
  DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_WIDTHS             = $64697770;        // 'pwid'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_WIDTHS}
  DWRITE_FONT_FEATURE_TAG_QUARTER_WIDTHS                  = $64697771;        // 'qwid'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_QUARTER_WIDTHS}
  DWRITE_FONT_FEATURE_TAG_REQUIRED_LIGATURES              = $67696C72;        // 'rlig'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_REQUIRED_LIGATURES}
  DWRITE_FONT_FEATURE_TAG_RUBY_NOTATION_FORMS             = $79627572;        // 'ruby'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_RUBY_NOTATION_FORMS}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_ALTERNATES            = $746C6173;        // 'salt'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_ALTERNATES}
  DWRITE_FONT_FEATURE_TAG_SCIENTIFIC_INFERIORS            = $666E6973;        // 'sinf'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_SCIENTIFIC_INFERIORS}
  DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS                  = $70636D73;        // 'smcp'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS}
  DWRITE_FONT_FEATURE_TAG_SIMPLIFIED_FORMS                = $6C706D73;        // 'smpl'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_SIMPLIFIED_FORMS}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1                 = $31307373;        // 'ss01'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_2                 = $32307373;        // 'ss02'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_2}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_3                 = $33307373;        // 'ss03'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_3}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_4                 = $34307373;        // 'ss04'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_4}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_5                 = $35307373;        // 'ss05'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_5}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_6                 = $36307373;        // 'ss06'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_6}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_7                 = $37307373;        // 'ss07'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_7}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_8                 = $38307373;        // 'ss08'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_8}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_9                 = $39307373;        // 'ss09'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_9}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_10                = $30317373;        // 'ss10'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_10}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_11                = $31317373;        // 'ss11'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_11}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_12                = $32317373;        // 'ss12'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_12}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_13                = $33317373;        // 'ss13'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_13}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_14                = $34317373;        // 'ss14'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_14}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_15                = $35317373;        // 'ss15'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_15}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_16                = $36317373;        // 'ss16'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_16}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_17                = $37317373;        // 'ss17'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_17}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_18                = $38317373;        // 'ss18'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_18}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_19                = $39317373;        // 'ss19'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_19}
  DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_20                = $30327373;        // 'ss20'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_20}
  DWRITE_FONT_FEATURE_TAG_SUBSCRIPT                       = $73627573;        // 'subs'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_SUBSCRIPT}
  DWRITE_FONT_FEATURE_TAG_SUPERSCRIPT                     = $73707573;        // 'sups'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_SUPERSCRIPT}
  DWRITE_FONT_FEATURE_TAG_SWASH                           = $68737773;        // 'swsh'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_SWASH}
  DWRITE_FONT_FEATURE_TAG_TITLING                         = $6C746974;        // 'titl'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_TITLING}
  DWRITE_FONT_FEATURE_TAG_TRADITIONAL_NAME_FORMS          = $6D616E74;        // 'tnam'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_TRADITIONAL_NAME_FORMS}
  DWRITE_FONT_FEATURE_TAG_TABULAR_FIGURES                 = $6D756E74;        // 'tnum'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_TABULAR_FIGURES}
  DWRITE_FONT_FEATURE_TAG_TRADITIONAL_FORMS               = $64617274;        // 'trad'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_TRADITIONAL_FORMS}
  DWRITE_FONT_FEATURE_TAG_THIRD_WIDTHS                    = $64697774;        // 'twid'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_THIRD_WIDTHS}
  DWRITE_FONT_FEATURE_TAG_UNICASE                         = $63696E75;        // 'unic'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_UNICASE}
  DWRITE_FONT_FEATURE_TAG_SLASHED_ZERO                    = $6F72657A;        // 'zero'
  {$EXTERNALSYM DWRITE_FONT_FEATURE_TAG_SLASHED_ZERO}

type
  DWRITE_SCRIPT_SHAPES = type Integer;
  {$EXTERNALSYM DWRITE_SCRIPT_SHAPES}
  TDWriteScriptShapes = DWRITE_SCRIPT_SHAPES;
  PDWriteScriptShapes = ^TDWriteScriptShapes;
const
  // No additional shaping requirement. Text is shaped with the writing system default behavior.
  DWRITE_SCRIPT_SHAPES_DEFAULT = 0;
  {$EXTERNALSYM DWRITE_SCRIPT_SHAPES_DEFAULT}
  // Text should leave no visual on display i.e. control or format control characters.
  DWRITE_SCRIPT_SHAPES_NO_VISUAL = 1;
  {$EXTERNALSYM DWRITE_SCRIPT_SHAPES_NO_VISUAL}

// Condition at the edges of inline object or text used to determine
// line-breaking behavior.
type
  DWRITE_BREAK_CONDITION = type Integer;
  {$EXTERNALSYM DWRITE_BREAK_CONDITION}
  TDWriteBreakCondition = DWRITE_BREAK_CONDITION;
  PDWriteBreakCondition = ^TDWriteBreakCondition;
const
  // Whether a break is allowed is determined by the condition of the
  // neighboring text span or inline object.
  DWRITE_BREAK_CONDITION_NEUTRAL = 0;
  {$EXTERNALSYM DWRITE_BREAK_CONDITION_NEUTRAL}
  // A break is allowed, unless overruled by the condition of the
  // neighboring text span or inline object, either prohibited by a
  // May Not or forced by a Must.
  DWRITE_BREAK_CONDITION_CAN_BREAK = 1;
  {$EXTERNALSYM DWRITE_BREAK_CONDITION_CAN_BREAK}
  // There should be no break, unless overruled by a Must condition from
  // the neighboring text span or inline object.
  DWRITE_BREAK_CONDITION_MAY_NOT_BREAK = 2;
  {$EXTERNALSYM DWRITE_BREAK_CONDITION_MAY_NOT_BREAK}
  // The break must happen, regardless of the condition of the adjacent
  // text span or inline object.
  DWRITE_BREAK_CONDITION_MUST_BREAK = 3;
  {$EXTERNALSYM DWRITE_BREAK_CONDITION_MUST_BREAK}

// How to apply number substitution on digits and related punctuation.
type
  DWRITE_NUMBER_SUBSTITUTION_METHOD = type Integer;
  {$EXTERNALSYM DWRITE_NUMBER_SUBSTITUTION_METHOD}
  TDWriteNumberSubstitutionMethod = DWRITE_NUMBER_SUBSTITUTION_METHOD;
  PDWriteNumberSubstitutionMethod = ^TDWriteNumberSubstitutionMethod;
const
  // Specifies that the substitution method should be determined based
  // on LOCALE_IDIGITSUBSTITUTION value of the specified text culture.
  DWRITE_NUMBER_SUBSTITUTION_METHOD_FROM_CULTURE = 0;
  {$EXTERNALSYM DWRITE_NUMBER_SUBSTITUTION_METHOD_FROM_CULTURE}
  // If the culture is Arabic or Farsi, specifies that the number shape
  // depend on the context. Either traditional or nominal number shape
  // are used depending on the nearest preceding strong character or (if
  // there is none) the reading direction of the paragraph.
  DWRITE_NUMBER_SUBSTITUTION_METHOD_CONTEXTUAL = 1;
  {$EXTERNALSYM DWRITE_NUMBER_SUBSTITUTION_METHOD_CONTEXTUAL}
  // Specifies that code points 0x30-0x39 are always rendered as nominal numeral
  // shapes (ones of the European number), i.e., no substitution is performed.
  DWRITE_NUMBER_SUBSTITUTION_METHOD_NONE = 2;
  {$EXTERNALSYM DWRITE_NUMBER_SUBSTITUTION_METHOD_NONE}
  // Specifies that number are rendered using the national number shape
  // as specified by the LOCALE_SNATIVEDIGITS value of the specified text culture.
  DWRITE_NUMBER_SUBSTITUTION_METHOD_NATIONAL = 3;
  {$EXTERNALSYM DWRITE_NUMBER_SUBSTITUTION_METHOD_NATIONAL}
  // Specifies that number are rendered using the traditional shape
  // for the specified culture. For most cultures, this is the same as
  // NativeNational. However, NativeNational results in Latin number
  // for some Arabic cultures, whereas this value results in Arabic
  // number for all Arabic cultures.
  DWRITE_NUMBER_SUBSTITUTION_METHOD_TRADITIONAL = 4;
  {$EXTERNALSYM DWRITE_NUMBER_SUBSTITUTION_METHOD_TRADITIONAL}

// The DWRITE_TEXTURE_TYPE enumeration identifies a type of alpha texture. An alpha texture is a bitmap of alpha values, each
// representing the darkness (i.e., opacity) of a pixel or subpixel.
type
  DWRITE_TEXTURE_TYPE = type Integer;
  TDWriteTextureType = DWRITE_TEXTURE_TYPE;
  PDWriteTextureType = ^TDWriteTextureType;
const
  // Specifies an alpha texture for aliased text rendering (i.e., bi-level, where
  // each pixel is either fully opaque or fully transparent), with one byte per pixel.
  DWRITE_TEXTURE_ALIASED_1x1 = 0;
  {$EXTERNALSYM DWRITE_TEXTURE_ALIASED_1x1}
  // Specifies an alpha texture for ClearType text rendering, with three bytes per pixel in the horizontal dimension and
  // one byte per pixel in the vertical dimension.
  DWRITE_TEXTURE_CLEARTYPE_3x1 = 1;
  {$EXTERNALSYM DWRITE_TEXTURE_CLEARTYPE_3x1}

// Maximum alpha value in a texture returned by IDWriteGlyphRunAnalysis::CreateAlphaTexture.
const
  DWRITE_ALPHA_MAX = 255;
  {$EXTERNALSYM DWRITE_ALPHA_MAX}


type
  ID2D1Geometry = interface;
  ID2D1Brush = interface;
  ID2D1Factory = interface;
  ID2D1RenderTarget = interface;
  ID2D1SimplifiedGeometrySink = interface;
  ID2D1TessellationSink = interface;
  ID2D1BitmapRenderTarget = interface;
  IDWriteFontFace = interface;
  IDWriteFontFileStream = interface;
  IDWriteFactory = interface;
  IDWriteFontFileEnumerator = interface;
  IDWriteFontFamily = interface;
  IDWriteFont = interface;
  IDWriteInlineObject = interface;
  IDWriteTextRenderer = interface;
  IDWriteRenderingParams = interface;
  IDWriteTextFormat = interface;
  IDWriteTextLayout = interface;

//// D2D1.H: Structs

// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D1_PIXEL_FORMAT
//
// ------------------------------------------------------------------------------
  D2D1_PIXEL_FORMAT = record
    format: DXGI_FORMAT;
    alphaMode: D2D1_ALPHA_MODE;
  end;
  TD2D1PixelFormat = D2D1_PIXEL_FORMAT;
  PD2D1PixelFormat = ^TD2D1PixelFormat;
  {$EXTERNALSYM D2D1_PIXEL_FORMAT}

  D2D1_POINT_2U = D2D_POINT_2U;
  {$EXTERNALSYM D2D1_POINT_2U}
  TD2D1Point2U    = D2D1_POINT_2U;
  PD2D1Point2U    = ^TD2D1Point2U;

  D2D1_POINT_2F = D2D_POINT_2F;
  {$EXTERNALSYM D2D1_POINT_2F}
  TD2D1Point2F    = D2D1_POINT_2F;
  PD2D1Point2F    = ^TD2D1Point2F;

  D2D1_RECT_F = D2D_RECT_F;
  {$EXTERNALSYM D2D1_RECT_F}
  TD2D1RectF      = D2D1_RECT_F;
  PD2D1RectF      = ^TD2D1RectF;

  D2D1_RECT_U = D2D_RECT_U;
  {$EXTERNALSYM D2D1_RECT_U}
  TD2D1RectU      = D2D1_RECT_U;
  PD2D1RectU      = ^TD2D1RectU;

  D2D1_SIZE_F = D2D_SIZE_F;
  {$EXTERNALSYM D2D1_SIZE_F}
  TD2D1SizeF      = D2D1_SIZE_F;
  PD2D1SizeF      = ^TD2D1SizeF;

  D2D1_SIZE_U = D2D_SIZE_U;
  {$EXTERNALSYM D2D1_SIZE_U}
  TD2D1SizeU      = D2D1_SIZE_U;
  PD2D1SizeU      = ^TD2D1SizeU;

  D2D1_COLOR_F = D2D_COLOR_F;
  {$EXTERNALSYM D2D1_COLOR_F}
  TD2D1ColorF     = D2D1_COLOR_F;
  PD2D1ColorF     = ^TD2D1ColorF;

  D2D1_MATRIX_3X2_F = D2D_MATRIX_3X2_F;
  {$EXTERNALSYM D2D1_MATRIX_3X2_F}
  TD2D1Matrix3x2F = D2D1_MATRIX_3X2_F;
  PD2D1Matrix3x2F = ^TD2D1Matrix3x2F;

  D2D1_TAG = UINT64;
  {$EXTERNALSYM D2D1_TAG}
  TD2D1Tag        = D2D1_TAG;
  PD2D1Tag        = ^TD2D1Tag;



// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D1_BITMAP_PROPERTIES
//
// ------------------------------------------------------------------------------
  D2D1_BITMAP_PROPERTIES = record
    pixelFormat: D2D1_PIXEL_FORMAT;
    dpiX: Single;
    dpiY: Single;
  end;
  TD2D1BitmapProperties = D2D1_BITMAP_PROPERTIES;
  PD2D1BitmapProperties = ^TD2D1BitmapProperties;
  {$EXTERNALSYM D2D1_BITMAP_PROPERTIES}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_GRADIENT_STOP
//
// ------------------------------------------------------------------------------
  D2D1_GRADIENT_STOP = record 
    position: Single;
    color: D2D1_COLOR_F;
  end;
  TD2D1GradientStop = D2D1_GRADIENT_STOP;
  PD2D1GradientStop = ^TD2D1GradientStop;
  {$EXTERNALSYM D2D1_GRADIENT_STOP}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_BRUSH_PROPERTIES
//
// ------------------------------------------------------------------------------
  D2D1_BRUSH_PROPERTIES = record
    opacity: Single;
    transform: D2D1_MATRIX_3X2_F;
  end;
  TD2D1BrushProperties = D2D1_BRUSH_PROPERTIES;
  PD2D1BrushProperties = ^TD2D1BrushProperties;
  {$EXTERNALSYM D2D1_BRUSH_PROPERTIES}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_BITMAP_BRUSH_PROPERTIES
// 
// ------------------------------------------------------------------------------
  D2D1_BITMAP_BRUSH_PROPERTIES = record
    extendModeX: D2D1_EXTEND_MODE;
    extendModeY: D2D1_EXTEND_MODE;
    interpolationMode: D2D1_BITMAP_INTERPOLATION_MODE;
  end;
  TD2D1BitmapBrushProperties = D2D1_BITMAP_BRUSH_PROPERTIES;
  PD2D1BitmapBrushProperties = ^TD2D1BitmapBrushProperties;
  {$EXTERNALSYM D2D1_BITMAP_BRUSH_PROPERTIES}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES
// 
// ------------------------------------------------------------------------------
  D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES = record
    startPoint: D2D1_POINT_2F;
    endPoint: D2D1_POINT_2F;
  end;
  TD2D1LinearGradientBrushProperties = D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES;
  PD2D1LinearGradientBrushProperties = ^TD2D1LinearGradientBrushProperties;
  {$EXTERNALSYM D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES}

// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES
// 
// ------------------------------------------------------------------------------
  D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES = record
    center: D2D1_POINT_2F;
    gradientOriginOffset: D2D1_POINT_2F;
    radiusX: Single;
    radiusY: Single;
  end;
  TD2D1RadialGradientBrushProperties = D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES;
  PD2D1RadialGradientBrushProperties = ^TD2D1RadialGradientBrushProperties;
  {$EXTERNALSYM D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_BEZIER_SEGMENT
// 
//  Synopsis:
//      Describes a cubic bezier in a path.
// 
// ------------------------------------------------------------------------------
  D2D1_BEZIER_SEGMENT = record 
    point1: D2D1_POINT_2F;
    point2: D2D1_POINT_2F;
    point3: D2D1_POINT_2F;
  end;
  TD2D1BezierSegment = D2D1_BEZIER_SEGMENT;
  PD2D1BezierSegment = ^TD2D1BezierSegment;
  {$EXTERNALSYM D2D1_BEZIER_SEGMENT}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_TRIANGLE
// 
//  Synopsis:
//      Describes a triangle.
// 
// ------------------------------------------------------------------------------
  D2D1_TRIANGLE = record
    point1: D2D1_POINT_2F;
    point2: D2D1_POINT_2F;
    point3: D2D1_POINT_2F;
  end;
  TD2D1Triangle = D2D1_TRIANGLE;
  PD2D1Triangle = ^TD2D1Triangle;
  {$EXTERNALSYM D2D1_TRIANGLE}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_ARC_SEGMENT
// 
//  Synopsis:
//      Describes an arc that is defined as part of a path.
// 
// ------------------------------------------------------------------------------
  D2D1_ARC_SEGMENT = record 
    point: D2D1_POINT_2F;
    size: D2D1_SIZE_F;
    rotationAngle: Single;
    sweepDirection: D2D1_SWEEP_DIRECTION;
    arcSize: D2D1_ARC_SIZE;
  end;
  TD2D1ArcSegment = D2D1_ARC_SEGMENT;
  PD2D1ArcSegment = ^TD2D1ArcSegment;
  {$EXTERNALSYM D2D1_ARC_SEGMENT}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_QUADRATIC_BEZIER_SEGMENT
//
// ------------------------------------------------------------------------------
  D2D1_QUADRATIC_BEZIER_SEGMENT = record
    point1: D2D1_POINT_2F;
    point2: D2D1_POINT_2F;
  end;
  TD2D1QuadraticBezierSegment = D2D1_QUADRATIC_BEZIER_SEGMENT;
  PD2D1QuadraticBezierSegment = ^TD2D1QuadraticBezierSegment;
  {$EXTERNALSYM D2D1_QUADRATIC_BEZIER_SEGMENT}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_ELLIPSE
// 
// ------------------------------------------------------------------------------
  D2D1_ELLIPSE = record 
    point: D2D1_POINT_2F;
    radiusX: Single;
    radiusY: Single;
  end;
  TD2D1Ellipse = D2D1_ELLIPSE;
  PD2D1Ellipse = ^TD2D1Ellipse;
  {$EXTERNALSYM D2D1_ELLIPSE}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_ROUNDED_RECT
// 
// ------------------------------------------------------------------------------
  D2D1_ROUNDED_RECT = record
    rect: D2D1_RECT_F;
    radiusX: Single;
    radiusY: Single;
  end;
  TD2D1RoundedRect = D2D1_ROUNDED_RECT;
  PD2D1RoundedRect = ^TD2D1RoundedRect;
  {$EXTERNALSYM D2D1_ROUNDED_RECT}

// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D1_STROKE_STYLE_PROPERTIES
// 
//  Synopsis:
//      Properties, aside from the width, that allow geometric penning to be specified.
// 
// ------------------------------------------------------------------------------
  D2D1_STROKE_STYLE_PROPERTIES = record
    startCap: D2D1_CAP_STYLE;
    endCap: D2D1_CAP_STYLE;
    dashCap: D2D1_CAP_STYLE;
    lineJoin: D2D1_LINE_JOIN;
    miterLimit: Single;
    dashStyle: D2D1_DASH_STYLE;
    dashOffset: Single;
  end;
  TD2D1StrokeStyleProperties = D2D1_STROKE_STYLE_PROPERTIES;
  PD2D1StrokeStyleProperties = ^TD2D1StrokeStyleProperties;
  {$EXTERNALSYM D2D1_STROKE_STYLE_PROPERTIES}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_RENDER_TARGET_PROPERTIES
//
// ------------------------------------------------------------------------------
  D2D1_RENDER_TARGET_PROPERTIES = record
    &type: TD2D1RenderTargetType;
    pixelFormat: TD2D1PixelFormat;
    dpiX: Single;
    dpiY: Single;
    usage: TD2D1RenderTargetUsage;
    minLevel: TD2D1FeatureLevel;
  end;
  TD2D1RenderTargetProperties = D2D1_RENDER_TARGET_PROPERTIES;
  PD2D1RenderTargetProperties = ^TD2D1RenderTargetProperties;
  {$EXTERNALSYM D2D1_RENDER_TARGET_PROPERTIES}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_HWND_RENDER_TARGET_PROPERTIES
// 
// ------------------------------------------------------------------------------
  D2D1_HWND_RENDER_TARGET_PROPERTIES = record
    hwnd: HWND;
    pixelSize: D2D1_SIZE_U;
    presentOptions: D2D1_PRESENT_OPTIONS;
  end;
  TD2D1HwndRenderTargetProperties = D2D1_HWND_RENDER_TARGET_PROPERTIES;
  PD2D1HwndRenderTargetProperties = ^TD2D1HwndRenderTargetProperties;
  {$EXTERNALSYM D2D1_HWND_RENDER_TARGET_PROPERTIES}

// +-----------------------------------------------------------------------------
// 
//  Struct:
//      D2D1_DRAWING_STATE_DESCRIPTION
//
//  Synopsis:
//      Allows the drawing state to be atomically created. This also specifies the
//      drawing state that is saved into an IDrawingStateBlock object.
//
// ------------------------------------------------------------------------------
  D2D1_DRAWING_STATE_DESCRIPTION = record
    antialiasMode: D2D1_ANTIALIAS_MODE;
    textAntialiasMode: D2D1_TEXT_ANTIALIAS_MODE;
    tag1: D2D1_TAG;
    tag2: D2D1_TAG;
    transform: D2D1_MATRIX_3X2_F;

  end;
  TD2D1DrawingStateDescription = D2D1_DRAWING_STATE_DESCRIPTION;
  PD2D1DrawingStateDescription = ^TD2D1DrawingStateDescription;
  {$EXTERNALSYM D2D1_DRAWING_STATE_DESCRIPTION}

// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D1_FACTORY_OPTIONS
//
//  Synopsis:
//      Allows additional parameters for factory creation.
//
// ------------------------------------------------------------------------------
  D2D1_FACTORY_OPTIONS = record
    // Requests a certain level of debugging information from the debug layer. This
    // parameter is ignored if the debug layer DLL is not present.
    debugLevel: D2D1_DEBUG_LEVEL;
  end;
  TD2D1FactoryOptions = D2D1_FACTORY_OPTIONS;
  PD2D1FactoryOptions = ^TD2D1FactoryOptions;
  {$EXTERNALSYM D2D1_FACTORY_OPTIONS}

// +-----------------------------------------------------------------------------
//
//  Struct:
//      D2D1_LAYER_PARAMETERS
//
// ------------------------------------------------------------------------------
  D2D1_LAYER_PARAMETERS = record
    // The rectangular clip that will be applied to the layer. The clip is affected by
    // the world transform. Content outside of the content bounds will not render.
    contentBounds: TD2D1RectF;
    // A general mask that can be optionally applied to the content. Content not inside
    // the fill of the mask will not be rendered.
    geometricMask: ID2D1Geometry;
    // Specifies whether the mask should be aliased or antialiased.
    maskAntialiasMode: TD2D1AntiAliasMode;
    // An additional transform that may be applied to the mask in addition to the
    // current world transform.
    maskTransform: TD2D1Matrix3x2F;
    // The opacity with which all of the content in the layer will be blended back to
    // the target when the layer is popped.
    opacity: Single;
    // An additional brush that can be applied to the layer. Only the opacity channel
    // is sampled from this brush and multiplied both with the layer content and the
    // over-all layer opacity.
    opacityBrush: ID2D1Brush;
    // Specifies if ClearType will be rendered into the layer.
    layerOptions: TD2D1LayerOptions;
  end;
  TD2D1LayerParameters = D2D1_LAYER_PARAMETERS;
  PD2D1LayerParameters = ^TD2D1LayerParameters;
  {$EXTERNALSYM D2D1_LAYER_PARAMETERS}

//// DWrite.h : Structs
// The DWRITE_FONT_METRICS structure specifies the metrics of a font face that
// are applicable to all glyphs within the font face.
  //designUnitsPerEm: The number of font design units per em unit.
    // Font files use their own coordinate system of font design units.
    // A font design unit is the smallest measurable unit in the em square,
    // an imaginary square that is used to size and align glyphs.
    // The concept of em square is used as a reference scale factor when defining font size and device transformation semantics.
    // The size of one em square is also commonly used to compute the paragraph identation value.
  // ascent: Ascent value of the font face in font design units.
    // Ascent is the distance from the top of font character alignment box to English baseline.
  // descent: Descent value of the font face in font design units.
    // Descent is the distance from the bottom of font character alignment box to English baseline.
  // lineGap: Line gap in font design units.
    // Recommended additional white space to add between lines to improve legibility. The recommended line spacing 
    // (baseline-to-baseline distance) is thus the sum of ascent, descent, and lineGap. The line gap is usually 
    // positive or zero but can be negative, in which case the recommended line spacing is less than the height
    // of the character alignment box.
  // capHeight: Cap height value of the font face in font design units.
    // Cap height is the distance from English baseline to the top of a typical English capital.
    // Capital "H" is often used as a reference character for the purpose of calculating the cap height value.
  // xHeight: x-height value of the font face in font design units.
    // x-height is the distance from English baseline to the top of lowercase letter "x", or a similar lowercase character.
  // underlinePosition: The underline position value of the font face in font design units.
    // Underline position is the position of underline relative to the English baseline.
    // The value is usually made negative in order to place the underline below the baseline.
  // underlineThickness: The suggested underline thickness value of the font face in font design units.
  // strikesthroughPosition: The strikethrough position value of the font face in font design units.
    // Strikethrough position is the position of strikethrough relative to the English baseline.
    // The value is usually made positive in order to place the strikethrough above the baseline.
  // strikethroughThickness: The suggested strikethrough thickness value of the font face in font design units.
  DWRITE_FONT_METRICS = record
    designUnitsPerEm: Word;
    ascent: Word;
    descent: Word;
    lineGap: Shortint;
    capHeight: Word;
    xHeight: Word;
    underlinePosition: Shortint;
    underlineThickness: Word;
    strikethroughPosition: Shortint;
    strikethroughThickness: Word;
  end;
  TDwriteFontMetrics = DWRITE_FONT_METRICS;
  PDwriteFontMetrics = ^TDwriteFontMetrics;
  {$EXTERNALSYM DWRITE_FONT_METRICS}

// The DWRITE_GLYPH_METRICS structure specifies the metrics of an individual glyph.
// The units depend on how the metrics are obtained.
  // leftSideBearing: Specifies the X offset from the glyph origin to the left edge of the black box.
    // The glyph origin is the current horizontal writing position.
    // A negative value means the black box extends to the left of the origin (often true for lowercase italic 'f').
  // advanceWidth: Specifies the X offset from the origin of the current glyph to the origin of the next glyph when writing horizontally.
  // rightSideBearing: Specifies the X offset from the right edge of the black box to the origin of the next glyph when writing horizontally.
    // The value is negative when the right edge of the black box overhangs the layout box.
  // topSideBearing: Specifies the vertical offset from the vertical origin to the top of the black box.
    // Thus, a positive value adds whitespace whereas a negative value means the glyph overhangs the top of the layout box.
  // advanceHeight: Specifies the Y offset from the vertical origin of the current glyph to the vertical origin of the next glyph when writing vertically.
    // (Note that the term "origin" by itself denotes the horizontal origin. The vertical origin is different.
    // Its Y coordinate is specified by verticalOriginY value,
    // and its X coordinate is half the advanceWidth to the right of the horizontal origin).
  // bottomSideBearing: Specifies the vertical distance from the black box's bottom edge to the advance height.
    // Positive when the bottom edge of the black box is within the layout box.
    // Negative when the bottom edge of black box overhangs the layout box.
  // verticalOriginY Specifies the Y coordinate of a glyph's vertical origin, in the font's design coordinate system.
    // The y coordinate of a glyph's vertical origin is the sum of the glyph's top side bearing
    // and the top (i.e. yMax) of the glyph's bounding box.
  DWRITE_GLYPH_METRICS = record
    leftSideBearing: Integer;
    advanceWidth: Cardinal;
    rightSideBearing: Integer;
    topSideBearing: Integer;
    advanceHeight: Cardinal;
    bottomSideBearing: Integer;
    verticalOriginY: Integer;
  end;
  TDwriteGlyphMetrics = DWRITE_GLYPH_METRICS;
  PDwriteGlyphMetrics = ^TDwriteGlyphMetrics;
  {$EXTERNALSYM DWRITE_GLYPH_METRICS}

// Optional adjustment to a glyph's position. An glyph offset changes the position of a glyph without affecting
// the pen position. Offsets are in logical, pre-transform units.
  // advanceOffset:  Offset in the advance direction of the run. A positive advance offset moves the glyph to the right
  // (in pre-transform coordinates) if the run is left-to-right or to the left if the run is right-to-left.
  // ascenderOffset: Offset in the ascent direction, i.e., the direction ascenders point. A positive ascender offset moves
  // the glyph up (in pre-transform coordinates).
  DWRITE_GLYPH_OFFSET = record
    advanceOffset: Single;
    ascenderOffset: Single;
  end;
  TDwriteGlyphOffset = DWRITE_GLYPH_OFFSET;
  PDwriteGlyphOffset = ^TDwriteGlyphOffset;
  {$EXTERNALSYM DWRITE_GLYPH_OFFSET}

// The DWRITE_MATRIX structure specifies the graphics transform to be applied
// to rendered glyphs.
  // m11: Horizontal scaling / cosine of rotation
  // m12: Vertical shear / sine of rotation
  // m21: Horizontal shear / negative sine of rotation
  // m22: Vertical scaling / cosine of rotation
  // dx:  Horizontal shift (always orthogonal regardless of rotation)
  // dy: Vertical shift (always orthogonal regardless of rotation)
  DWRITE_MATRIX = record 
    m11: Single;
    m12: Single;
    m21: Single;
    m22: Single;
    dx: Single;
    dy: Single;
  end;
  TDwriteMatrix = DWRITE_MATRIX;
  PDwriteMatrix = ^TDwriteMatrix;
  {$EXTERNALSYM DWRITE_MATRIX}

// The DWRITE_TEXT_RANGE structure specifies a range of text positions where format is applied.
  //startPosition: The start text position of the range.
  //length: The number of text positions in the range.
  DWRITE_TEXT_RANGE = record
    startPosition: Cardinal;
    length: Cardinal;
  end;
  TDwriteTextRange = DWRITE_TEXT_RANGE;
  PDwriteTextRange = ^TDwriteTextRange;
  {$EXTERNALSYM DWRITE_TEXT_RANGE}

  // The DWRITE_FONT_FEATURE structure specifies properties used to identify and execute typographic feature in the font.
    // nameTag: The feature OpenType name identifier.
    // parameter: Execution parameter of the feature.
      // The parameter should be non-zero to enable the feature.  Once enabled, a feature can't be disabled again within
      // the same range.  Features requiring a selector use this value to indicate the selector index.
  DWRITE_FONT_FEATURE = record
    nameTag: DWRITE_FONT_FEATURE_TAG;
    parameter: Cardinal;
  end;
  TDwriteFontFeature = DWRITE_FONT_FEATURE;
  PDwriteFontFeature = ^TDwriteFontFeature;
  {$EXTERNALSYM DWRITE_FONT_FEATURE}

// Defines a set of typographic features to be applied during shaping.
// Notice the character range which this feature list spans is specified
// as a separate parameter to GetGlyphs.
    //features:  Array of font features.
    //featureCount: The number of features.
  DWRITE_TYPOGRAPHIC_FEATURES = record
    features: PDwriteFontFeature;
    featureCount: Cardinal;
  end;
  TDwriteTypographicFeatures = DWRITE_TYPOGRAPHIC_FEATURES;
  PDwriteTypographicFeatures = ^TDwriteTypographicFeatures;
  {$EXTERNALSYM DWRITE_TYPOGRAPHIC_FEATURES}

// The DWRITE_TRIMMING structure specifies the trimming option for text overflowing the layout box.
  // granularity: Text granularity of which trimming applies.
  // delimiter: Character code used as the delimiter signaling the beginning of the portion of text to be preserved,
    // most useful for path ellipsis, where the delimeter would be a slash.
  // delimiterCount: How many occurences of the delimiter to step back.
  DWRITE_TRIMMING = record
    granularity: DWRITE_TRIMMING_GRANULARITY;

    delimiter: Cardinal;

    delimiterCount: Cardinal;
  end;
  TDwriteTrimming = DWRITE_TRIMMING;
  PDwriteTrimming = ^TDwriteTrimming;
  {$EXTERNALSYM DWRITE_TRIMMING}

// Association of text and its writing system script as well as some display attributes.
  // script: Zero-based index representation of writing system script.
  // shapes: Additional shaping requirement of text.
  DWRITE_SCRIPT_ANALYSIS = record
    script: Word;
    shapes: DWRITE_SCRIPT_SHAPES;
  end;
  TDwriteScriptAnalysis = DWRITE_SCRIPT_ANALYSIS;
  PDwriteScriptAnalysis = ^TDwriteScriptAnalysis;
  {$EXTERNALSYM DWRITE_SCRIPT_ANALYSIS}

// Line breakpoint characteristics of a character.
  // 2: breakConditionBefore: Breaking condition before the character.
  // 2: breakConditionAfter: Breaking condition after the character.
  // 1: isWhitespace: The character is some form of whitespace, which may be meaningful
  //      for justification.
  // 1: isSoftHyphen: The character is a soft hyphen, often used to indicate hyphenation
  //      points inside words.
  // 2: padding:
{  WRITE_LINE_BREAKPOINT = record
     data : Byte;
       breakConditionBefore: Byte:2; <-H2PAS - Bit indicator;
       breakConditionAfter:  Byte:2; <-H2PAS - Bit indicator;
       isWhitespace:         Byte:1; <-H2PAS - Bit indicator;
       isSoftHyphen:         Byte:1; <-H2PAS - Bit indicator;
       padding:              Byte:2; <-H2PAS - Bit indicator;
   end; }
  DWRITE_LINE_BREAKPOINT = record
    data: Byte;  //UInt8;
    private
      function  GetByte(const Index: Integer): Byte;
      procedure SetByte(const Index: Integer; value: Byte);
    public
      property breakConditionBefore: Byte Index $0003 read GetByte write SetByte; // mask $0003, offset 0 
      property breakConditionAfter: Byte  Index $0203 read GetByte write SetByte; // mask $0003, offset 2 
      property isWhiteSpace: Byte         Index $0401 read GetByte write SetByte; // mask $0001, offset 4
      property isSoftHyphen: Byte         Index $0501 read GetByte write SetByte; // mask $0001, offset 5
      property padding: Byte              Index $0603 read GetByte write SetByte; // mask $0003, offset 6
  end;
//
  TDwriteLineBreakpoint = DWRITE_LINE_BREAKPOINT;
  PDwriteLineBreakpoint = ^TDwriteLineBreakpoint;
  {$EXTERNALSYM DWRITE_LINE_BREAKPOINT}

// Shaping output properties per input character.
  // 1: isShapedAlone: This character can be shaped independently from the others
  //   (usually set for the space character).
  // 15: reserved: Reserved for use by shaping engine.
{  DWRITE_SHAPING_TEXT_PROPERTIES = record
     data: Word;
       isShapedAlone: Word:1;  <-H2PAS - Bit indicator;
       reserved:      Word:15; <-H2PAS - Bit indicator;
   end; }
  DWRITE_SHAPING_TEXT_PROPERTIES = record
    data: WORD; //UINT16;
    private
      function  GetWord(const Index: Integer): WORD;
      procedure SetWord(const Index: Integer; value: WORD);
    public
      property isShapedAlone: WORD Index $00000001 read GetWord write SetWord; // mask $0001, offset 0
      property reserved: WORD      Index $00017FFF read GetWord write SetWord; // mask $7FFF, offset 1
  end;
  TDwriteShapingTextProperties = DWRITE_SHAPING_TEXT_PROPERTIES;
  PDwriteShapingTextProperties = ^TDwriteShapingTextProperties;
  {$EXTERNALSYM DWRITE_SHAPING_TEXT_PROPERTIES}

// Shaping output properties per output glyph.
  // 4: justification: Justification class, whether to use spacing, kashidas, or
  //   another method. This exists for backwards compatibility
  //   with Uniscribe's SCRIPT_JUSTIFY enum.
  // 1: isClusterStart: Indicates glyph is the first of a cluster.
  // 1: isDiacritic: Glyph is a diacritic.
  // 1: isZeroWidthSpace: Glyph has no width, blank, ZWJ, ZWNJ etc.
  // 9: reserved: Reserved for use by shaping engine.
{  DWRITE_SHAPING_GLYPH_PROPERTIES = record 
     data : WORD;
       justification:    Word:4; <-H2PAS - Bit indicator;
       isClusterStart:   Word:1; <-H2PAS - Bit indicator;
       isDiacritic:      Word:1; <-H2PAS - Bit indicator;
       isZeroWidthSpace: Word:1; <-H2PAS - Bit indicator;
       reserved:         Word:9; <-H2PAS - Bit indicator;
   end; }
  DWRITE_SHAPING_GLYPH_PROPERTIES = record 
    data : WORD; //UINT16
    private
      function  GetWord(const Index: Integer): WORD;
      procedure SetWord(const Index: Integer; value: WORD);
    public
      property justification: WORD    Index $0000000F read GetWord write SetWord; // mask $000F, offset 0
      property isClusterStart: WORD   Index $00040001 read GetWord write SetWord; // mask $0001, offset 4
      property isDiacritic: WORD      Index $00050001 read GetWord write SetWord; // mask $0001, offset 5
      property isZeroWidthSpace: WORD Index $00060001 read GetWord write SetWord; // mask $0001, offset 6
      property reserved: WORD         Index $000701FF read GetWord write SetWord; // mask $01FF, offset 7
  end;
  TDwriteShapingGlyphProperties = DWRITE_SHAPING_GLYPH_PROPERTIES;
  PDwriteShapingGlyphProperties = ^TDwriteShapingGlyphProperties;
  {$EXTERNALSYM DWRITE_SHAPING_GLYPH_PROPERTIES}

// The DWRITE_GLYPH_RUN structure contains the information needed by renderers
// to draw glyph runs. All coordinates are in device independent pixels (DIPs).
  //fontFace: The physical font face to draw with.
  //fonstEmSize: Logical size of the font in DIPs, not points (equals 1/96 inch).
  //glyphCount: The number of glyphs.
  //glyphIndicies: The indices to render.
  //glyphAdvances: Glyph advance widths.
  //glyphOffsets: Glyph offsets.
  //isSideways: If true, specifies that glyphs are rotated 90 degrees to the left and
    // vertical metrics are used. Vertical writing is achieved by specifying
    // isSideways = true and rotating the entire run 90 degrees to the right
    // via a rotate transform.
  //bidiLevel: The implicit resolved bidi level of the run. Odd levels indicate
    // right-to-left languages like Hebrew and Arabic, while even levels
    // indicate left-to-right languages like English and Japanese (when
    // written horizontally). For right-to-left languages, the text origin
    // is on the right, and text should be drawn to the left.
  DWRITE_GLYPH_RUN = record
    fontFace: IDWriteFontFace;
    fontEmSize: Single;
    glyphCount: Cardinal;
    glyphIndices: PWord;
    glyphAdvances: PSingle;
    glyphOffsets: PDwriteGlyphOffset;
    isSideways: BOOL;
    bidiLevel: Cardinal;
  end;
  TDwriteGlyphRun = DWRITE_GLYPH_RUN;
  PDwriteGlyphRun = ^TDwriteGlyphRun;
  {$EXTERNALSYM DWRITE_GLYPH_RUN}

// The DWRITE_GLYPH_RUN_DESCRIPTION structure contains additional properties
// related to those in DWRITE_GLYPH_RUN.
  // localeName: The locale name associated with this run.
  // string: The text associated with the glyphs.
  // stringLength: The number of characters (UTF16 code-units).
  //   Note that this may be different than the number of glyphs.
  // clusterMap: An array of indices to the glyph indices array, of the first glyphs of
  //   all the glyph clusters of the glyphs to render.
  // textPosition: Corresponding text position in the original string
  //   this glyph run came from.
  DWRITE_GLYPH_RUN_DESCRIPTION = record
    localeName: PWCHAR;
    _string: PWCHAR;
    stringLength: Cardinal;
    clusterMap: PWord;
    textPosition: Cardinal;
  end;
  TDwriteGlyphRunDescription = DWRITE_GLYPH_RUN_DESCRIPTION;
  PDwriteGlyphRunDescription = ^TDwriteGlyphRunDescription;
  {$EXTERNALSYM DWRITE_GLYPH_RUN_DESCRIPTION}

// The DWRITE_UNDERLINE structure contains about the size and placement of
// underlines. All coordinates are in device independent pixels (DIPs).
  // width: Width of the underline, measured parallel to the baseline.
  // thickness: Thickness of the underline, measured perpendicular to the
  //   baseline.
  // offset: Offset of the underline from the baseline.
  //   A positive offset represents a position below the baseline and
  //   a negative offset is above.
  // runHeight: Height of the tallest run where the underline applies.
  // readingDirection: Reading direction of the text associated with the underline.  This
  //   value is used to interpret whether the width value runs horizontally
  //   or vertically.
  // flowDirection: Flow direction of the text associated with the underline.  This value
  //   is used to interpret whether the thickness value advances top to
  //   bottom, left to right, or right to left.
  // localeName: Locale of the text the underline is being drawn under. Can be
  //   pertinent where the locale affects how the underline is drawn.
  //   For example, in vertical text, the underline belongs on the
  //   left for Chinese but on the right for Japanese.
  //   This choice is completely left up to higher levels.
  // measuringMode: The measuring mode can be useful to the renderer to determine how
  //   underlines are rendered, e.g. rounding the thickness to a whole pixel
  //   in GDI-compatible modes.

  DWRITE_UNDERLINE = record
    width: Single;
    thickness: Single;
    offset: Single;
    runHeight: Single;
    readingDirection: DWRITE_READING_DIRECTION;
    flowDirection: DWRITE_FLOW_DIRECTION;
    localeName: PWCHAR;
    measuringMode: DWRITE_MEASURING_MODE;
  end;
  TDwriteUnderline = DWRITE_UNDERLINE;
  PDwriteUnderline = ^TDwriteUnderline;
  {$EXTERNALSYM DWRITE_UNDERLINE}

// The DWRITE_STRIKETHROUGH structure contains about the size and placement of
// strickthroughs. All coordinates are in device independent pixels (DIPs).
  // width: Width of the strikethrough, measured parallel to the baseline.
  // thickness: Thickness of the strikethrough, measured perpendicular to the
  //   baseline.
  // offset: Offset of the stikethrough from the baseline.
  //   A positive offset represents a position below the baseline and
  //   a negative offset is above.
  // readingDirection: Reading direction of the text associated with the strikethrough.  This
  //   value is used to interpret whether the width value runs horizontally
  //   or vertically.
  // flowDirection: Flow direction of the text associated with the strikethrough.  This
  //   value is used to interpret whether the thickness value advances top to
  //   bottom, left to right, or right to left.
  // localeName: Locale of the range. Can be pertinent where the locale affects the style.
  // measuringMode: The measuring mode can be useful to the renderer to determine how
  //   underlines are rendered, e.g. rounding the thickness to a whole pixel
  //   in GDI-compatible modes.

  DWRITE_STRIKETHROUGH = record
    width: Single;
    thickness: Single;
    offset: Single;
    readingDirection: DWRITE_READING_DIRECTION;
    flowDirection: DWRITE_FLOW_DIRECTION;
    localeName: PWCHAR;
    measuringMode: DWRITE_MEASURING_MODE;
  end;
  TDwriteStrikethrough = DWRITE_STRIKETHROUGH;
  PDwriteStrikethrough = ^TDwriteStrikethrough;
  {$EXTERNALSYM DWRITE_STRIKETHROUGH}

// The DWRITE_LINE_METRICS structure contains information about a formatted
// line of text.
  // length: The number of total text positions in the line.
  //   This includes any trailing whitespace and newline characters.
  // trailingWhitespaceLength: The number of whitespace positions at the end of the line.  Newline
  //   sequences are considered whitespace.
  // newlineLength: The number of characters in the newline sequence at the end of the line.
  //   If the count is zero, then the line was either wrapped or it is the
  //   end of the text.
  // height: Height of the line as measured from top to bottom.
  // baseline: Distance from the top of the line to its baseline.
  // isTrimmed: The line is trimmed.
  DWRITE_LINE_METRICS = record
    length: Cardinal;
    trailingWhitespaceLength: Cardinal;
    newlineLength: Cardinal;
    height: Single;
    baseline: Single;
    isTrimmed: BOOL;
  end;
  TDwriteLineMetrics = DWRITE_LINE_METRICS;
  PDwriteLineMetrics = ^TDwriteLineMetrics;
  {$EXTERNALSYM DWRITE_LINE_METRICS}


// The DWRITE_CLUSTER_METRICS structure contains information about a glyph cluster.
  // width: The total advance width of all glyphs in the cluster.
  // length: The number of text positions in the cluster.
  // 1: canWrapLineAfter: Indicate whether line can be broken right after the cluster.
  // 1: isWhitespace:     Indicate whether the cluster corresponds to whitespace character.
  // 1: isNewline:        Indicate whether the cluster corresponds to a newline character.
  // 1: sSoftHyphen:      Indicate whether the cluster corresponds to soft hyphen character.
  // 1: isRightToLeft:    Indicate whether the cluster is read from right to left.
  // 11: padding
{  DWRITE_CLUSTER_METRICS = record
     width: Single;
     length: Word;
     data : Word;
       canWrapLineAfter: Word:1; <-H2PAS - Bit indicator;
       isWhitespace:     Word:1; <-H2PAS - Bit indicator;
       isNewline:        Word:1; <-H2PAS - Bit indicator;
       isSoftHyphen:     Word:1; <-H2PAS - Bit indicator;
       isRightToLeft:    Word:1; <-H2PAS - Bit indicator;
       padding:          Word:11; <-H2PAS - Bit indicator;
  end; }
  DWRITE_CLUSTER_METRICS = record
    width:  Single;
    length: UINT16;
    data:   WORD; //UINT16
    private
      function  GetWord(const Index: Integer): WORD;
      procedure SetWord(const Index: Integer; value: WORD);
    public
      property canWrapLineAfter: WORD Index $00000001 read GetWord write SetWord; // mask $0001, offset 0
      property isWhitespace: WORD     Index $00010001 read GetWord write SetWord; // mask $0001, offset 1
      property isNewline: WORD        Index $00020001 read GetWord write SetWord; // mask $0001, offset 2
      property isSoftHyphen: WORD     Index $00030001 read GetWord write SetWord; // mask $0001, offset 3
      property isRightToLeft: WORD    Index $00040001 read GetWord write SetWord; // mask $0001, offset 4
      property padding: WORD          Index $0005000B read GetWord write SetWord; // mask $000B, offset 5
  end;

  TDwriteClusterMetrics = DWRITE_CLUSTER_METRICS;
  PDwriteClusterMetrics = ^TDwriteClusterMetrics;
  {$EXTERNALSYM DWRITE_CLUSTER_METRICS}

// Overall metrics associated with text after layout.
// All coordinates are in device independent pixels (DIPs).
  // left: Left-most point of formatted text relative to layout box
  //   (excluding any glyph overhang).
  // top: Top-most point of formatted text relative to layout box
  //   (excluding any glyph overhang).
  // width: The width of the formatted text ignoring trailing whitespace
  //   at the end of each line.
  // widthIncludingTrailingWhitespace:
  //   The width of the formatted text taking into account the
  //   trailing whitespace at the end of each line.
  // height: The height of the formatted text. The height of an empty string
  //   is determined by the size of the default font's line height.
  // layoutWidth: Initial width given to the layout. Depending on whether the text
  //   was wrapped or not, it can be either larger or smaller than the
  //   text content width.
  // layoutHeight: Initial height given to the layout. Depending on the length of the
  //   text, it may be larger or smaller than the text content height.
  // maxBidiReorderingDepth: The maximum reordering count of any line of text, used
  //   to calculate the most number of hit-testing boxes needed.
  //   If the layout has no bidirectional text or no text at all,
  //   the minimum level is 1.
  // lineCount: Total number of lines.
  DWRITE_TEXT_METRICS = record
    left: Single;
    top: Single;
    width: Single;
    widthIncludingTrailingWhitespace: Single;
    height: Single;
    layoutWidth: Single;
    layoutHeight: Single;
    maxBidiReorderingDepth: Cardinal;
    lineCount: Cardinal;
  end;
  TDWriteTextMetrics = DWRITE_TEXT_METRICS;
  PDWriteTextMetrics = ^TDWriteTextMetrics;
  {$EXTERNALSYM DWRITE_TEXT_METRICS}

// Properties describing the geometric measurement of an
// application-defined inline object.
  // Width of the inline object.
  // Height of the inline object as measured from top to bottom.
  // Distance from the top of the object to the baseline where it is lined up with the adjacent text.
    // If the baseline is at the bottom, baseline simply equals height.
  // Flag indicating whether the object is to be placed upright or alongside the text baseline
    // for vertical text.
  DWRITE_INLINE_OBJECT_METRICS = record
    width: Single;
    height: Single;
    baseline: Single;
    supportsSideways: BOOL;
  end;
  TDwriteInlineObjectMetrics = DWRITE_INLINE_OBJECT_METRICS;
  PDwriteInlineObjectMetrics = ^TDwriteInlineObjectMetrics;
  {$EXTERNALSYM DWRITE_INLINE_OBJECT_METRICS}

// The DWRITE_OVERHANG_METRICS structure holds how much any visible pixels
// overshoot each side of the layout or inline objects.
// Positive overhangs indicate that the visible area extends outside the layout
// box or inline object, while negative values mean there is whitespace inside.
// The returned values are unaffected by rendering transforms or pixel snapping.
// Additionally, they may not exactly match final target's pixel bounds after
// applying grid fitting and hinting.
  // left: The distance from the left-most visible DIP to its left alignment edge.
  // top: The distance from the top-most visible DIP to its top alignment edge.
  // right: The distance from the right-most visible DIP to its right alignment edge.
  // bottom: The distance from the bottom-most visible DIP to its bottom alignment edge.
  DWRITE_OVERHANG_METRICS = record
    left: Single;
    top: Single;
    right: Single;
    bottom: Single;
  end;
  TDwriteOverhangMetrics = DWRITE_OVERHANG_METRICS;
  PDwriteOverhangMetrics = ^TDwriteOverhangMetrics;
  {$EXTERNALSYM DWRITE_OVERHANG_METRICS}

// Geometry enclosing of text positions.
  // textPosition: First text position within the geometry.
  // length: Number of text positions within the geometry.
  // left: Left position of the top-left coordinate of the geometry.
  // top: Top position of the top-left coordinate of the geometry.
  // width: Geometry's width.
  // height: Geometry's height.
  // bidiLevel: Bidi level of text positions enclosed within the geometry.
  // isText: Geometry encloses text?
  // isTrimmed: Range is trimmed.
  DWRITE_HIT_TEST_METRICS = record
    textPosition: Cardinal;
    length: Cardinal;
    left: Single;
    top: Single;
    width: Single;
    height: Single;
    bidiLevel: Cardinal;
    isText: BOOL;
    isTrimmed: BOOL;
  end;
  TDwriteHitTestMetrics = DWRITE_HIT_TEST_METRICS;
  PDwriteHitTestMetrics = ^TDwriteHitTestMetrics;
  {$EXTERNALSYM DWRITE_HIT_TEST_METRICS}

//// D2D1.H: Interfaces
// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1Resource
//
//  Synopsis:
//      The root interface for all resources in D2D.
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1Resource);'}
  ID2D1Resource = interface(IUnknown)
    [SID_ID2D1Resource]
    // Retrieve the factory associated with this resource.
    procedure GetFactory(out factory: ID2D1Factory); stdcall;
  end;
  {$EXTERNALSYM ID2D1Resource}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1Bitmap
//
//  Synopsis:
//      Root bitmap resource, linearly scaled on a draw call.
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1Bitmap);'}
  ID2D1Bitmap = interface(ID2D1Resource)
    [SID_ID2D1Bitmap]
    // Returns the size of the bitmap in resolution independent units.
    procedure GetSize(out size: TD2D1SizeF); stdcall;

    // Returns the size of the bitmap in resolution dependent units, (pixels).
    procedure GetPixelSize(out pixelSize: TD2D1SizeU); stdcall;

    // Retrieve the format of the bitmap.
    procedure GetPixelFormat(out pixelFormat: TD2D1PixelFormat); stdcall;

    // Return the DPI of the bitmap.
    procedure GetDpi(out dpiX, dpiY: Single); stdcall;

    function CopyFromBitmap(var destPoint: D2D1_POINT_2U; const bitmap: ID2D1Bitmap;
      var srcRect: D2D1_RECT_U): HResult; stdcall;

    function CopyFromRenderTarget(var destPoint: D2D1_POINT_2U;
      const renderTarget: ID2D1RenderTarget; var srcRect: D2D1_RECT_U): HResult; stdcall;

    function CopyFromMemory(var dstRect: D2D1_RECT_U; srcData: Pointer;
      pitch: Cardinal): HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1Bitmap}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1GradientStopCollection
//
//  Synopsis:
//      Represents an collection of gradient stops that can then be the source resource
//      for either a linear or radial gradient brush.
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1GradientStopCollection);'}
  ID2D1GradientStopCollection = interface(ID2D1Resource)
    [SID_ID2D1GradientStopCollection]
    function GetGradientStopCount: Cardinal; stdcall;
    // Copies the gradient stops from the collection into the caller's interface.
    procedure GetGradientStops(gradientStops: PD2D1GradientStop;
      gradientStopsCount: UINT); stdcall;

    // Returns whether the interpolation occurs with 1.0 or 2.2 gamma.
    function GetColorInterpolationGamma: TD2D1Gamma; stdcall;

    function GetExtendMode: TD2D1ExtendMode; stdcall;
  end;
  {$EXTERNALSYM ID2D1GradientStopCollection}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1Brush
//
//  Synopsis:
//      The root brush interface. All brushes can be used to fill or pen a geometry.
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1Brush);'}
  ID2D1Brush = interface(ID2D1Resource)
    [SID_ID2D1Brush]
    // Sets the opacity for when the brush is drawn over the entire fill of the brush.
    procedure SetOpacity(opacity: Single); stdcall;
    // Sets the transform that applies to everything drawn by the brush.
    procedure SetTransform(const transform: TD2D1Matrix3x2F); stdcall;

    function GetOpacity: Single; stdcall;

    procedure GetTransform(out transform: TD2D1Matrix3x2F); stdcall;
  end;
  {$EXTERNALSYM ID2D1Brush}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1BitmapBrush
//
//  Synopsis:
//      A bitmap brush allows a bitmap to be used to fill a geometry.
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1BitmapBrush);'}
  ID2D1BitmapBrush = interface(ID2D1Brush)
    [SID_ID2D1BitmapBrush]
    // Sets how the bitmap is to be treated outside of its natural extent on the X
    // axis.
    procedure SetExtendModeX(extendModeX: D2D1_EXTEND_MODE); stdcall;
    // Sets how the bitmap is to be treated outside of its natural extent on the Y
    // axis.
    procedure SetExtendModeY(extendModeY: D2D1_EXTEND_MODE); stdcall;

    // Sets the interpolation mode used when this brush is used.
    procedure SetInterpolationMode(
      interpolationMode: D2D1_BITMAP_INTERPOLATION_MODE); stdcall;

    // Sets the bitmap associated as the source of this brush.
    procedure SetBitmap(const bitmap: ID2D1Bitmap); stdcall;
  
    function GetExtendModeX: TD2D1ExtendMode; stdcall;

    function GetExtendModeY: TD2D1ExtendMode; stdcall;

    function GetInterpolationMode: TD2D1BitmapInterpolationMode; stdcall;
  
    procedure GetBitmap(out bitmap: ID2D1Bitmap); stdcall;
  end;
  {$EXTERNALSYM ID2D1BitmapBrush}

// +-----------------------------------------------------------------------------
// 
//  Interface:
//      ID2D1SolidColorBrush
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1SolidColorBrush);'}
  ID2D1SolidColorBrush = interface(ID2D1Brush)
    [SID_ID2D1SolidColorBrush]
    procedure SetColor(const color: TD2D1ColorF); stdcall;

    procedure GetColor(var color: TD2D1ColorF); stdcall;
  end;
  {$EXTERNALSYM ID2D1SolidColorBrush}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1LinearGradientBrush
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1LinearGradientBrush);'}
  ID2D1LinearGradientBrush = interface(ID2D1Brush)
    [SID_ID2D1LinearGradientBrush]
    procedure SetStartPoint(startPoint: TD2D1Point2F); stdcall;

    // Sets the end point of the gradient in local coordinate space. This is not
    // influenced by the geometry being filled.
    procedure SetEndPoint(endPoint: TD2D1Point2F); stdcall;

    procedure GetStartPoint(out startPoint: TD2D1Point2F); stdcall;

    procedure GetEndPoint(out endPoint: TD2D1Point2F); stdcall;
  
    procedure GetGradientStopCollection(
      out gradientStopCollection: ID2D1GradientStopCollection); stdcall;
  end;
  {$EXTERNALSYM ID2D1LinearGradientBrush}

// +-----------------------------------------------------------------------------
// 
//  Interface:
//      ID2D1RadialGradientBrush
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1RadialGradientBrush);'}
  ID2D1RadialGradientBrush = interface(ID2D1Brush)
    [SID_ID2D1RadialGradientBrush]
    procedure SetCenter(center: TD2D1Point2F); stdcall;
  
    // Sets offset of the origin relative to the radial gradient center.
    procedure SetGradientOriginOffset(
      gradientOriginOffset: TD2D1Point2F); stdcall;

    procedure SetRadiusX(radiusX: Single); stdcall;
  
    procedure SetRadiusY(radiusY: Single); stdcall;
  
    procedure GetCenter(out center: TD2D1Point2F); stdcall;

    procedure GetGradientOriginOffset(
    out gradientOriginOffset: TD2D1Point2F); stdcall;

    function GetRadiusX: Single; stdcall;

    function GetRadiusY: Single; stdcall;

    procedure GetGradientStopCollection(
      out gradientStopCollection: ID2D1GradientStopCollection); stdcall;
  end;
  {$EXTERNALSYM ID2D1RadialGradientBrush}

// +-----------------------------------------------------------------------------
// 
//  Interface:
//      ID2D1StrokeStyle
// 
//  Synopsis:
//      Resource interface that holds pen style properties.
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1StrokeStyle);'}
  ID2D1StrokeStyle = interface(ID2D1Resource)
    [SID_ID2D1StrokeStyle]
    function GetStartCap: TD2D1CapStyle; stdcall;

    function GetEndCap: TD2D1CapStyle; stdcall;

    function GetDashCap: TD2D1CapStyle; stdcall;

    function GetMiterLimit: Single; stdcall;

    function GetLineJoin: TD2D1LineJoin; stdcall;

    function GetDashOffset: Single; stdcall;

    function GetDashStyle: TD2D1DashStyle; stdcall;

    function GetDashesCount: Cardinal; stdcall;
  
    // Returns the dashes from the object into a user allocated array. The user must
    // call GetDashesCount to retrieve the required size.
    procedure GetDashes(dashes: PSingle; dashesCount: UINT); stdcall;
  end;
  {$EXTERNALSYM ID2D1StrokeStyle}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1Geometry
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1Geometry);'}
  ID2D1Geometry = interface(ID2D1Resource)
    [SID_ID2D1Geometry]
    function GetBounds(const worldTransform: TD2D1Matrix3x2F;
      out bounds: D2D1_RECT_F): HResult; stdcall;

    // Get the bounds of the corresponding geometry after it has been widened or have
    // an optional pen style applied.
    function GetWidenedBounds(strokeWidth: Single; const strokeStyle: ID2D1StrokeStyle;
      const worldTransform: TD2D1Matrix3x2F; flatteningTolerance: Single;
      out bounds: D2D1_RECT_F): HResult; stdcall;

    // Checks to see whether the corresponding penned and widened geometry contains the
    // given point.
    function StrokeContainsPoint(point: D2D1_POINT_2F; strokeWidth: Single;
      strokeStyle: ID2D1StrokeStyle; const worldTransform: TD2D1Matrix3x2F;
      flatteningTolerance: Single; out contains: Bool): HResult; stdcall;

    // Test whether the given fill of this geometry would contain this point.
    function FillContainsPoint(point: D2D1_POINT_2F;
      const worldTransform: TD2D1Matrix3x2F; flatteningTolerance: Single;
      out contains: Bool): HResult; stdcall;

    // Compare how one geometry intersects or contains another geometry.
    function CompareWithGeometry(const inputGeometry: ID2D1Geometry;
      const inputGeometryTransform: TD2D1Matrix3x2F; flatteningTolerance: Single;
      out relation: D2D1_GEOMETRY_RELATION): HResult; stdcall;

    // Converts a geometry to a simplified geometry that has arcs and quadratic beziers
    // removed.
    function Simplify(simplificationOption: D2D1_GEOMETRY_SIMPLIFICATION_OPTION;
      const worldTransform: TD2D1Matrix3x2F; flatteningTolerance: Single;
      const geometrySink: ID2D1SimplifiedGeometrySink): HResult; stdcall;

    // Tessellates a geometry into triangles.
    function Tessellate(const worldTransform: TD2D1Matrix3x2F;
      flatteningTolerance: Single;
      const tessellationSink: ID2D1TessellationSink): HResult; stdcall;

    // Performs a combine operation between the two geometries to produce a resulting
    // geometry.
    function CombineWithGeometry(const inputGeometry: ID2D1Geometry;
      combineMode: D2D1_COMBINE_MODE; const inputGeometryTransform: TD2D1Matrix3x2F;
      flatteningTolerance: Single;
      const geometrySink: ID2D1SimplifiedGeometrySink): HResult; stdcall;

    // Computes the outline of the geometry. The result is written back into a
    // simplified geometry sink.
    function Outline(const worldTransform: TD2D1Matrix3x2F;
      flatteningTolerance: Single;
      const geometrySink: ID2D1SimplifiedGeometrySink): HResult; stdcall;

    // Computes the area of the geometry.
    function ComputeArea(const worldTransform: TD2D1Matrix3x2F;
      flatteningTolerance: Single; out area: Single): HResult; stdcall;

    // Computes the length of the geometry.
    function ComputeLength(const worldTransform: TD2D1Matrix3x2F;
      flatteningTolerance: Single; out length: Single): HResult; stdcall;

    // Computes the point and tangent a given distance along the path.
    function ComputePointAtLength(length: Single;
      const worldTransform: TD2D1Matrix3x2F; flatteningTolerance: Single;
      point, unitTangentVector: PD2D1Point2F): HResult; stdcall;

    // Get the geometry and widen it as well as apply an optional pen style.
    function Widen(strokeWidth: Single; const strokeStyle: ID2D1StrokeStyle;
      const worldTransform: TD2D1Matrix3x2F; flatteningTolerance: Single;
      const geometrySink: ID2D1SimplifiedGeometrySink): HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1Geometry}
  PID2D1Geometry = ^ID2D1Geometry;

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1RectangleGeometry
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1RectangleGeometry);'}
  ID2D1RectangleGeometry = interface(ID2D1Geometry)
    [SID_ID2D1RectangleGeometry]
    procedure GetRect(var rect: D2D1_RECT_F); stdcall;
  end;
  {$EXTERNALSYM ID2D1RectangleGeometry}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1RoundedRectangleGeometry
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1RoundedRectangleGeometry);'}
  ID2D1RoundedRectangleGeometry = interface(ID2D1Geometry)
    [SID_ID2D1RoundedRectangleGeometry]
    procedure GetRoundedRect(var roundedRect: D2D1_ROUNDED_RECT); stdcall;
  end;
  {$EXTERNALSYM ID2D1RoundedRectangleGeometry}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1EllipseGeometry
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1EllipseGeometry);'}
  ID2D1EllipseGeometry = interface(ID2D1Geometry)
    [SID_ID2D1EllipseGeometry]
    procedure GetEllipse(var ellipse: D2D1_ELLIPSE); stdcall;
  end;
  {$EXTERNALSYM ID2D1EllipseGeometry}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1GeometryGroup
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1GeometryGroup);'}
  ID2D1GeometryGroup = interface(ID2D1Geometry)
    [SID_ID2D1GeometryGroup]
    function GetFillMode: TD2D1FillMode; stdcall;

    function GetSourceGeometryCount: Cardinal; stdcall;

    procedure GetSourceGeometries(geometries: PID2D1Geometry;
      geometriesCount: UINT); stdcall;
  end;
  {$EXTERNALSYM ID2D1GeometryGroup}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1TransformedGeometry
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1TransformedGeometry);'}
  ID2D1TransformedGeometry = interface(ID2D1Geometry)
    [SID_ID2D1TransformedGeometry]
    procedure GetSourceGeometry(out sourceGeometry: ID2D1Geometry); stdcall; //Note: Result is not automatically _AddRef-ed.

    procedure GetTransform(out transform: TD2D1Matrix3x2F); stdcall;
  end;
  {$EXTERNALSYM ID2D1TransformedGeometry}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1SimplifiedGeometrySink
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1SimplifiedGeometrySink);'}
  ID2D1SimplifiedGeometrySink = interface(IUnknown)
    [SID_ID2D1SimplifiedGeometrySink]
    procedure SetFillMode(fillMode: D2D1_FILL_MODE); stdcall;

    procedure SetSegmentFlags(vertexFlags: D2D1_PATH_SEGMENT); stdcall;

    procedure BeginFigure(startPoint: D2D1_POINT_2F;
      figureBegin: D2D1_FIGURE_BEGIN); stdcall;

    procedure AddLines(points: PD2D1Point2F; pointsCount: UINT); stdcall;

    procedure AddBeziers(beziers: PD2D1BezierSegment;
      beziersCount: UINT); stdcall;

    procedure EndFigure(figureEnd: D2D1_FIGURE_END); stdcall;

    function Close: HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1SimplifiedGeometrySink}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1GeometrySink
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1GeometrySink);'}
  ID2D1GeometrySink = interface(ID2D1SimplifiedGeometrySink)
    [SID_ID2D1GeometrySink]
    procedure AddLine(point: D2D1_POINT_2F); stdcall;

    procedure AddBezier(const bezier: D2D1_BEZIER_SEGMENT); stdcall;

    procedure AddQuadraticBezier(const bezier: D2D1_QUADRATIC_BEZIER_SEGMENT); stdcall;

    procedure AddQuadraticBeziers(beziers: PD2D1QuadraticBezierSegment;
      beziersCount: UINT); stdcall;

    procedure AddArc(const arc: D2D1_ARC_SEGMENT); stdcall;
  end;
  {$EXTERNALSYM ID2D1GeometrySink}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1TessellationSink
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1TessellationSink);'}
  ID2D1TessellationSink = interface(IUnknown)
    [SID_ID2D1TessellationSink]
    procedure AddTriangles(triangles: PD2D1Triangle;
      trianglesCount: UINT); stdcall;

    function Close: HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1TessellationSink}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1PathGeometry
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1PathGeometry);'}
  ID2D1PathGeometry = interface(ID2D1Geometry)
    [SID_ID2D1PathGeometry]
    function Open(out geometrySink: ID2D1GeometrySink): HResult; stdcall;

    // Retrieve the contents of this geometry. The caller passes an implementation of a
    // ID2D1GeometrySink interface to receive the data.
    function Stream(const geometrySink: ID2D1GeometrySink): HResult; stdcall;

    function GetSegmentCount(var count: Cardinal): HResult; stdcall;

    function GetFigureCount(var count: Cardinal): HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1PathGeometry}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1Mesh
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1Mesh);'}
  ID2D1Mesh = interface(ID2D1Resource)
    [SID_ID2D1Mesh]
    function Open(out tessellationSink: ID2D1TessellationSink): HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1Mesh}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1Layer
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1Layer);'}
  ID2D1Layer = interface(ID2D1Resource)
    [SID_ID2D1Layer]
    procedure GetSize(out size: TD2D1SizeF); stdcall;
  end;
  {$EXTERNALSYM ID2D1Layer}

// +-----------------------------------------------------------------------------
// 
//  Interface:
//      ID2D1DrawingStateBlock
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1DrawingStateBlock);'}
  ID2D1DrawingStateBlock = interface(ID2D1Resource)
    [SID_ID2D1DrawingStateBlock]
    // Retrieves the state currently contained within this state block resource.
    procedure GetDescription(
      var stateDescription: D2D1_DRAWING_STATE_DESCRIPTION); stdcall;

    // Sets the state description of this state block resource.
    procedure SetDescription(
      var stateDescription: D2D1_DRAWING_STATE_DESCRIPTION); stdcall;

    // Sets the text rendering parameters of this state block resource.
    procedure SetTextRenderingParams(
      const textRenderingParams: IDWriteRenderingParams); stdcall;

    // Retrieves the text rendering parameters contained within this state block
    // resource. If a NULL text rendering parameter was specified, NULL will be
    // returned.
    procedure GetTextRenderingParams(
      out textRenderingParams: IDWriteRenderingParams); stdcall;
  end;
  {$EXTERNALSYM ID2D1DrawingStateBlock}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1RenderTarget
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1RenderTarget);'}
  ID2D1RenderTarget = interface(ID2D1Resource)
    [SID_ID2D1RenderTarget]
    // Create a D2D bitmap by copying from memory, or create uninitialized.
    function CreateBitmap(size: D2D1_SIZE_U; srcData: Pointer; pitch: Cardinal;
      const bitmapProperties: TD2D1BitmapProperties;
      out bitmap: ID2D1Bitmap): HResult; stdcall;

//    // Create a D2D bitmap by copying a WIC bitmap.
    function CreateBitmapFromWicBitmap(
      const wicBitmapSource: IWICBitmapSource;
      bitmapProperties: PD2D1BitmapProperties;
      out bitmap: ID2D1Bitmap): HResult; stdcall;

    // Create a D2D bitmap by sharing bits from another resource. The bitmap must be
    // compatible with the render target for the call to succeed.
    // For example, an IWICBitmap can be shared with a software target, or a DXGI
    // surface can be shared with a DXGI render target.
    function CreateSharedBitmap(const riid: TGUID; data: Pointer;
      bitmapProperties: PD2D1BitmapProperties;
      out bitmap: ID2D1Bitmap): HResult; stdcall;

    // Creates a bitmap brush. The bitmap is scaled, rotated, skewed or tiled to fill
    // or pen a geometry.
    function CreateBitmapBrush(const bitmap: ID2D1Bitmap;
      bitmapBrushProperties: PD2D1BitmapBrushProperties;
      brushProperties: PD2D1BrushProperties;
      out bitmapBrush: ID2D1BitmapBrush): HResult; stdcall;

    function CreateSolidColorBrush(const color: D2D1_COLOR_F;
      brushProperties: PD2D1BrushProperties;
      out solidColorBrush: ID2D1SolidColorBrush): HResult; stdcall;

    // A gradient stop collection represents a set of stops in an ideal unit length.
    // This is the source resource for a linear gradient and radial gradient brush.
    function CreateGradientStopCollection(const gradientStops: PD2D1GradientStop;
      gradientStopsCount: UINT; colorInterpolationGamma: TD2D1Gamma;
      extendMode: TD2D1ExtendMode;
      out gradientStopCollection: ID2D1GradientStopCollection): HResult; stdcall;

    function CreateLinearGradientBrush(
      const linearGradientBrushProperties: TD2D1LinearGradientBrushProperties;
      brushProperties: PD2D1BrushProperties;
      gradientStopCollection: ID2D1GradientStopCollection;
      out linearGradientBrush: ID2D1LinearGradientBrush): HResult; stdcall;

    function CreateRadialGradientBrush(
      const radialGradientBrushProperties: TD2D1RadialGradientBrushProperties;
      brushProperties: PD2D1BrushProperties;
      gradientStopCollection: ID2D1GradientStopCollection;
      out radialGradientBrush: ID2D1RadialGradientBrush): HResult; stdcall;

    // Creates a bitmap render target whose bitmap can be used as a source for
    // rendering in the API.
    function CreateCompatibleRenderTarget(desiredSize: PD2D1SizeF;
      desiredPixelSize: PD2D1SizeU; desiredFormat: PD2D1PixelFormat;
      options: TD2D1CompatibleRenderTargetOptions;
      out bitmapRenderTarget: ID2D1BitmapRenderTarget): HResult; stdcall;

    // Creates a layer resource that can be used on any target and which will resize
    // under the covers if necessary.
    function CreateLayer(size: PD2D1SizeF;
      out layer: ID2D1Layer): HResult; stdcall;

    // Create a D2D mesh.
    function CreateMesh(out mesh: ID2D1Mesh): HResult; stdcall;

    procedure DrawLine(point0, point1: TD2DPoint2f;
      const brush: ID2D1Brush; strokeWidth: Single = 1.0;
      const strokeStyle: ID2D1StrokeStyle = nil); stdcall;

    procedure DrawRectangle(const rect: TD2D1RectF; const brush: ID2D1Brush;
      strokeWidth: Single = 1.0; const strokeStyle: ID2D1StrokeStyle = nil); stdcall;

    procedure FillRectangle(const rect: TD2D1RectF; const brush: ID2D1Brush); stdcall;

    procedure DrawRoundedRectangle(const roundedRect: TD2D1RoundedRect;
      const brush: ID2D1Brush; strokeWidth: Single = 1.0;
      const strokeStyle: ID2D1StrokeStyle = nil); stdcall;

    procedure FillRoundedRectangle(const roundedRect: TD2D1RoundedRect;
      const brush: ID2D1Brush); stdcall;

    procedure DrawEllipse(const ellipse: TD2D1Ellipse; const brush: ID2D1Brush;
      strokeWidth: Single = 1.0; const strokeStyle: ID2D1StrokeStyle = nil); stdcall;

    procedure FillEllipse(const ellipse: TD2D1Ellipse; const brush: ID2D1Brush); stdcall;

    procedure DrawGeometry(geometry: ID2D1Geometry; const brush: ID2D1Brush;
      strokeWidth: Single = 1.0; const strokeStyle: ID2D1StrokeStyle = nil); stdcall;

    procedure FillGeometry(const geometry: ID2D1Geometry; const brush: ID2D1Brush;
      const opacityBrush: ID2D1Brush = nil); stdcall;

    // Fill a mesh. Since meshes can only render aliased content, the render target
    // antialiasing mode must be set to aliased.
    procedure FillMesh(const mesh: ID2D1Mesh; const brush: ID2D1Brush); stdcall;

    // Fill using the opacity channel of the supplied bitmap as a mask. The alpha
    // channel of the bitmap is used to represent the coverage of the geometry at each
    // pixel, and this is filled appropriately with the brush. The render target
    // antialiasing mode must be set to aliased.
    procedure FillOpacityMask(opacityMask: ID2D1Bitmap; brush: ID2D1Brush;
      content: TD2D1OpacityMaskContent;
      destinationRectangle: PD2D1RectF = nil;
      sourceRectangle: PD2D1RectF = nil); stdcall;

    procedure DrawBitmap(const bitmap: ID2D1Bitmap;
      destinationRectangle: PD2D1RectF = nil; opacity: Single = 1.0;
      interpolationMode: TD2D1BitmapInterpolationMode = D2D1_BITMAP_INTERPOLATION_MODE_LINEAR;
      sourceRectangle: PD2D1RectF = nil); stdcall;

    // Draws the text within the given layout rectangle and by default also snaps and
    // clips it to the content bounds.
    procedure DrawText(&string: PWCHAR; stringLength: UINT;
      const textFormat: IDWriteTextFormat;
      const layoutRect: D2D1_RECT_F;
      const defaultForegroundBrush: ID2D1Brush;
      options: TD2D1DrawTextOptions = D2D1_DRAW_TEXT_OPTIONS_NONE;
      measuringMode: TDWriteMeasuringMode = DWRITE_MEASURING_MODE_NATURAL);
      stdcall;

    // Draw a snapped text layout object. Since the layout is not subsequently changed,
    // this can be more effecient than DrawText when drawing the same layout repeatedly.
    procedure DrawTextLayout(origin: D2D1_POINT_2F; const textLayout: IDWriteTextLayout;
      const defaultForegroundBrush: ID2D1Brush;
      options: D2D1_DRAW_TEXT_OPTIONS = D2D1_DRAW_TEXT_OPTIONS_NONE); stdcall;

    procedure DrawGlyphRun(baselineOrigin: D2D1_POINT_2F;
      var glyphRun: TDWriteGlyphRun;
      const foregroundBrush: ID2D1Brush;
      measuringMode: TDWriteMeasuringMode = DWRITE_MEASURING_MODE_NATURAL); stdcall;

    procedure SetTransform(const transform: TD2D1Matrix3x2F); stdcall;

    procedure GetTransform(var transform: TD2D1Matrix3x2F); stdcall;

    procedure SetAntialiasMode(antialiasMode: TD2D1AntiAliasMode); stdcall;

    function GetAntialiasMode: TD2D1AntiAliasMode; stdcall;

    procedure SetTextAntialiasMode(
      textAntialiasMode: TD2D1TextAntiAliasMode); stdcall;

    function GetTextAntialiasMode: TD2D1TextAntiAliasMode; stdcall;

    procedure SetTextRenderingParams(
      const textRenderingParams: IDWriteRenderingParams); stdcall;

    // Retrieve the text render parameters. NOTE: If NULL is specified to
    // SetTextRenderingParameters, NULL will be returned.
    procedure GetTextRenderingParams(
      out textRenderingParams: IDWriteRenderingParams); stdcall;

    // Set a tag to correspond to the succeeding primitives. If an error occurs
    // rendering a primtive, the tags can be returned from the Flush or EndDraw call.
    procedure SetTags(tag1: D2D1_TAG; tag2: D2D1_TAG); stdcall;

    // Retrieves the currently set tags. This does not retrieve the tags corresponding
    // to any primitive that is in error.
    procedure GetTags(tag1: PD2D1Tag = nil; tag2: PD2D1Tag = nil); stdcall;

    // Start a layer of drawing calls. The way in which the layer must be resolved is
    // specified first as well as the logical resource that stores the layer
    // parameters. The supplied layer resource might grow if the specified content
    // cannot fit inside it. The layer will grow monitonically on each axis.
    procedure PushLayer(var layerParameters: D2D1_LAYER_PARAMETERS;
      const layer: ID2D1Layer); stdcall;

    // Ends a layer that was defined with particular layer resources.
    procedure PopLayer; stdcall;

    function Flush(tag1: PD2D1Tag = nil; tag2: PD2D1Tag = nil): HResult; stdcall;

    // Gets the current drawing state and saves it into the supplied
    // IDrawingStatckBlock.
    procedure SaveDrawingState(
      var drawingStateBlock: ID2D1DrawingStateBlock); stdcall;

    // Copies the state stored in the block interface.
    procedure RestoreDrawingState(
      const drawingStateBlock: ID2D1DrawingStateBlock); stdcall;

    // Pushes a clip. The clip can be antialiased. The clip must be axis aligned. If
    // the current world transform is not axis preserving, then the bounding box of the
    // transformed clip rect will be used. The clip will remain in effect until a
    // PopAxisAligned clip call is made.
    procedure PushAxisAlignedClip(const clipRect: TD2D1RectF;
      antialiasMode: D2D1_ANTIALIAS_MODE); stdcall;

    procedure PopAxisAlignedClip; stdcall;

    procedure Clear(const clearColor: D2D1_COLOR_F); stdcall;

    // Start drawing on this render target. Draw calls can only be issued between a
    // BeginDraw and EndDraw call.
    procedure BeginDraw; stdcall;

    // Ends drawing on the render target, error results can be retrieved at this time,
    // or when calling flush.
    function EndDraw(tag1: PD2D1Tag = nil;
      tag2: PD2D1Tag = nil): HResult; stdcall;

    procedure GetPixelFormat(out pixelFormat: TD2D1PixelFormat); stdcall;

    // Sets the DPI on the render target. This results in the render target being
    // interpretted to a different scale. Neither DPI can be negative. If zero is
    // specified for both, the system DPI is chosen. If one is zero and the other
    // unspecified, the DPI is not changed.
    procedure SetDpi(dpiX, dpiY: Single); stdcall;

    // Return the current DPI from the target.
    procedure GetDpi(out dpiX, dpiY: Single); stdcall;

    // Returns the size of the render target in DIPs.
    procedure GetSize(out size: TD2D1SizeF); stdcall;

    // Returns the size of the render target in pixels.
    procedure GetPixelSize(out pixelSize: TD2D1SizeU); stdcall;

    // Returns the maximum bitmap and render target size that is guaranteed to be
    // supported by the render target.
    function GetMaximumBitmapSize: UInt32; stdcall;

    // Returns true if the given properties are supported by this render target. The
    // DPI is ignored. NOTE: If the render target type is software, then neither
    // D2D1_FEATURE_LEVEL_9 nor D2D1_FEATURE_LEVEL_10 will be considered to be
    // supported.
    function IsSupported(const renderTargetProperties: TD2D1RenderTargetProperties): BOOL; stdcall;
  end;
  {$EXTERNALSYM ID2D1RenderTarget}

// +-----------------------------------------------------------------------------
// 
//  Interface:
//      ID2D1BitmapRenderTarget
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1BitmapRenderTarget);'}
  ID2D1BitmapRenderTarget = interface(ID2D1RenderTarget)
    [SID_ID2D1BitmapRenderTarget]
    function GetBitmap(out bitmap: ID2D1Bitmap): HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1BitmapRenderTarget}

// +-----------------------------------------------------------------------------
//
//  Interface:
//      ID2D1HwndRenderTarget
//
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1HwndRenderTarget);'}
  ID2D1HwndRenderTarget = interface(ID2D1RenderTarget)
    [SID_ID2D1HwndRenderTarget]
    function CheckWindowState: TD2D1WindowState; stdcall;

    // Resize the buffer underlying the render target. This operation might fail if
    // there is insufficent video memory or system memory, or if the render target is
    // resized beyond the maximum bitmap size. If the method fails, the render target
    // will be placed in a zombie state and D2DERR_RECREATE_TARGET will be returned
    // from it when EndDraw is called. In addition an appropriate failure result will
    // be returned from Resize.
    function Resize(var pixelSize: D2D1_SIZE_U): HResult; stdcall;

    function GetHwnd: HWND; stdcall;
  end;
  {$EXTERNALSYM ID2D1HwndRenderTarget}

// +-----------------------------------------------------------------------------
// 
//  Interface:
//      ID2D1GdiInteropRenderTarget
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1GdiInteropRenderTarget);'}
  ID2D1GdiInteropRenderTarget = interface(IUnknown)
    [SID_ID2D1GdiInteropRenderTarget]
    function GetDC(mode: D2D1_DC_INITIALIZE_MODE; out hdc: HDC): HResult; stdcall;

    function ReleaseDC(const update: TRect): HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1GdiInteropRenderTarget}

// +-----------------------------------------------------------------------------
// 
//  Interface:
//      ID2D1DCRenderTarget
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1DCRenderTarget);'}
  ID2D1DCRenderTarget = interface(ID2D1RenderTarget)
    [SID_ID2D1DCRenderTarget]
    function BindDC(hDC: HDC; const pSubRect: TRect): HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1DCRenderTarget}

// +-----------------------------------------------------------------------------
// 
//  Interface:
//      ID2D1Factory
//
//  Synopsis:
//      The root factory interface for all of D2D's objects.
// 
// ------------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID2D1Factory);'}
  ID2D1Factory = interface(IUnknown)
    [SID_ID2D1Factory]
    // Cause the factory to refresh any system metrics that it might have been snapped
    // on factory creation.
    function ReloadSystemMetrics: HResult; stdcall;
  
    // Retrieves the current desktop DPI. To refresh this, call ReloadSystemMetrics.
    procedure GetDesktopDpi(var dpiX, dpiY: Single); stdcall;

    function CreateRectangleGeometry(const rectangle: TD2D1RectF;
      out rectangleGeometry: ID2D1RectangleGeometry): HResult; stdcall;

    function CreateRoundedRectangleGeometry(const roundedRectangle: TD2D1RoundedRect;
      out roundedRectangleGeometry: ID2D1RoundedRectangleGeometry): HResult; stdcall;

    function CreateEllipseGeometry(const ellipse: TD2D1Ellipse;
      out ellipseGeometry: ID2D1EllipseGeometry): HResult; stdcall;

      // Create a geometry which holds other geometries.
    function CreateGeometryGroup(fillMode: D2D1_FILL_MODE;
      geometries: PID2D1Geometry; geometriesCount: UINT;
      out geometryGroup: ID2D1GeometryGroup): HResult; stdcall;

    function CreateTransformedGeometry(const sourceGeometry: ID2D1Geometry;
      const transform: tD2D1Matrix3x2F;
      out transformedGeometry: ID2D1TransformedGeometry): HResult; stdcall;

    // Returns an initially empty path geometry interface. A geometry sink is created
    // off the interface to populate it.
    function CreatePathGeometry(
      out pathGeometry: ID2D1PathGeometry): HResult; stdcall;

    // Allows a non-default stroke style to be specified for a given geometry at draw
    // time.
    function CreateStrokeStyle(const strokeStyleProperties: TD2D1StrokeStyleProperties;
      const dashes: PSingle; dashesCount: UINT;
      out strokeStyle: ID2D1StrokeStyle): HResult; stdcall;

    // Creates a new drawing state block, this can be used in subsequent
    // SaveDrawingState and RestoreDrawingState operations on the render target.
    function CreateDrawingStateBlock(
      drawingStateDescription: PD2D1DrawingStateDescription;
      const textRenderingParams: IDWriteRenderingParams;
      out drawingStateBlock: ID2D1DrawingStateBlock): HResult; stdcall;

    // Creates a render target which is a source of bitmaps.
    function CreateWicBitmapRenderTarget(
      const target: IWICBitmap;
      var renderTargetProperties: D2D1_RENDER_TARGET_PROPERTIES;
      out renderTarget: ID2D1RenderTarget): HResult; stdcall;

    // Creates a render target that appears on the display.
    function CreateHwndRenderTarget(
      const renderTargetProperties: TD2D1RenderTargetProperties;
      const hwndRenderTargetProperties: TD2D1HwndRenderTargetProperties;
      out hwndRenderTarget: ID2D1HwndRenderTarget): HResult; stdcall;

    // Creates a render target that draws to a DXGI Surface. The device that owns the
    // surface is used for rendering.
    function CreateDxgiSurfaceRenderTarget(
      const dxgiSurface: IDXGISurface;
      var renderTargetProperties: D2D1_RENDER_TARGET_PROPERTIES;
      out renderTarget: ID2D1RenderTarget): HResult; stdcall;

    // Creates a render target that draws to a GDI device context.
    function CreateDCRenderTarget(
      const renderTargetProperties: TD2D1RenderTargetProperties;
      out dcRenderTarget: ID2D1DCRenderTarget): HResult; stdcall;
  end;
  {$EXTERNALSYM ID2D1Factory}

//// DWrite.h: Interfaces
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontFileLoader);'}
  IDWriteFontFileLoader = interface(IUnknown)
    [SID_IDWriteFontFileLoader]
    function CreateStreamFromKey(fontFileReferenceKey: Pointer;
      fontFileReferenceKeySize: Cardinal;
      out fontFileStream: IDWriteFontFileStream): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontFileLoader}

// A built-in implementation of IDWriteFontFileLoader interface that operates on local font files
// and exposes local font file information from the font file reference key.
// Font file references created using CreateFontFileReference use this font file loader.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteLocalFontFileLoader);'}
  IDWriteLocalFontFileLoader = interface(IDWriteFontFileLoader)
    [SID_IDWriteLocalFontFileLoader]
    function GetFilePathLengthFromKey(fontFileReferenceKey: Pointer;
      fontFileReferenceKeySize: Cardinal;
      var filePathLength: Cardinal): HResult; stdcall;

    function GetFilePathFromKey(fontFileReferenceKey: Pointer;
      fontFileReferenceKeySize: Cardinal; var filePath: WCHAR; 
      filePathSize: Cardinal): HResult; stdcall;
  
    function GetLastWriteTimeFromKey(fontFileReferenceKey: Pointer;
      fontFileReferenceKeySize: Cardinal;
      var lastWriteTime: FILETIME): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteLocalFontFileLoader}

// The interface for loading font file data.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontFileStream);'}
  IDWriteFontFileStream = interface(IUnknown)
    [SID_IDWriteFontFileStream]
    function ReadFileFragment(var fragmentStart: Pointer; fileOffset: UINT64;
      fragmentSize: UINT64; var fragmentContext: Pointer): HResult; stdcall;
  
    procedure ReleaseFileFragment(fragmentContext: Pointer); stdcall;
  
    function GetFileSize(var fileSize: UINT64): HResult; stdcall;
  
    function GetLastWriteTime(var lastWriteTime: UINT64): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontFileStream}

// The interface that represents a reference to a font file.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontFile);'}
  IDWriteFontFile = interface(IUnknown)
    [SID_IDWriteFontFile]
    function GetReferenceKey(var fontFileReferenceKey: Pointer;
      var fontFileReferenceKeySize: Cardinal): HResult; stdcall;

    function GetLoader(
      out fontFileLoader: IDWriteFontFileLoader): HResult; stdcall;

    function Analyze(var isSupportedFontType: BOOL;
      var fontFileType: DWRITE_FONT_FILE_TYPE;
      var fontFaceType: DWRITE_FONT_FACE_TYPE;
      var numberOfFaces: Cardinal): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontFile}
  PIDWriteFontFile = ^IDWriteFontFile;

// The interface that represents text rendering settings for glyph rasterization and filtering.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteRenderingParams);'}
  IDWriteRenderingParams = interface(IUnknown)
    [SID_IDWriteRenderingParams]
    // Gets the gamma value used for gamma correction. Valid values must be
    // greater than zero and cannot exceed 256.
    function GetGamma: Single; stdcall;

    // Gets the amount of contrast enhancement. Valid values are greater than
    // or equal to zero.
    function GetEnhancedContrast: Single; stdcall;

    // Gets the ClearType level. Valid values range from 0.0f (no ClearType)
    // to 1.0f (full ClearType).
    function GetClearTypeLevel: Single; stdcall;

    // Gets the pixel geometry.
    function GetPixelGeometry: DWRITE_PIXEL_GEOMETRY; stdcall;

    // Gets the rendering mode.
    function GetRenderingMode: DWRITE_RENDERING_MODE; stdcall;
  end;
  {$EXTERNALSYM IDWriteRenderingParams}

  IDWriteGeometrySink = ID2D1SimplifiedGeometrySink;

// The interface that represents an absolute reference to a font face.
// It contains font face type, appropriate file references and face identification data.
// Various font data such as metrics, names and glyph outlines is obtained from IDWriteFontFace.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontFace);'}
  IDWriteFontFace = interface(IUnknown)
    [SID_IDWriteFontFace]
    function GetType: DWRITE_FONT_FACE_TYPE; stdcall;

    function GetFiles(var numberOfFiles: Cardinal; 
      out fontFiles: IDWriteFontFile): HResult; stdcall;
  
    function GetIndex: UINT32; stdcall;
  
    function GetSimulations: DWRITE_FONT_SIMULATIONS; stdcall;
  
    function IsSymbolFont: BOOL; stdcall;
  
    procedure GetMetrics(var fontFaceMetrics: TDwriteFontMetrics); stdcall;
  
    function GetGlyphCount: UINT16; stdcall;
  
    function GetDesignGlyphMetrics(glyphIndices: PWord; glyphCount: Cardinal;
      glyphMetrics: PDwriteGlyphMetrics; isSideways: BOOL = False): HResult; stdcall;
  
    function GetGlyphIndices(var codePoints: Cardinal; codePointCount: Cardinal; 
      var glyphIndices: Word): HResult; stdcall;
  
    function TryGetFontTable(openTypeTableTag: Cardinal; var tableData: Pointer; 
      var tableSize: Cardinal; var tableContext: Pointer; 
      var exists: BOOL): HResult; stdcall;
  
    procedure ReleaseFontTable(tableContext: Pointer); stdcall;

    function GetGlyphRunOutline(emSize: Single; const glyphIndices: PWord;
      const glyphAdvances: PSingle; const glyphOffsets: PDwriteGlyphOffset;
      glyphCount: Cardinal; isSideways: BOOL; isRightToLeft: BOOL;
      geometrySink: IDWriteGeometrySink): HResult; stdcall;
  
    function GetRecommendedRenderingMode(emSize: Single; pixelsPerDip: Single;
      measuringMode: TDWriteMeasuringMode;
      var renderingParams: IDWriteRenderingParams;
      var renderingMode: TDWriteRenderingMode): HResult; stdcall;

    function GetGdiCompatibleMetrics(emSize: Single; pixelsPerDip: Single; 
      const transform: DWRITE_MATRIX; var fontFaceMetrics: DWRITE_FONT_METRICS): HResult; stdcall;

    function GetGDICompatibleGlyphMetrics(emSize: Single; pixelsPerDip: Single; 
      const transform: DWRITE_MATRIX; useGdiNatural: BOOL; 
      glyphIndicies: PWord; glpyhCount: Cardinal): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontFace}

  // The font collection loader interface is used to construct a collection of fonts given a particular type of key.
  // The font collection loader interface is recommended to be implemented by a singleton object.
  // IMPORTANT: font collection loader implementations must not register themselves with a DirectWrite factory
  // inside their constructors and must not unregister themselves in their destructors, because
  // registration and unregistraton operations increment and decrement the object reference count respectively.
  // Instead, registration and unregistration of font file loaders with DirectWrite factory should be performed
  // outside of the font file loader implementation as a separate step.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontCollectionLoader);'}
  IDWriteFontCollectionLoader = interface(IUnknown)
    [SID_IDWriteFontCollectionLoader]
    function CreateEnumeratorFromKey(var factory: IDWriteFactory; 
      collectionKey: Pointer; collectionKeySize: Cardinal;
      out fontFileEnumerator: IDWriteFontFileEnumerator): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontCollectionLoader}

// The font file enumerator interface encapsulates a collection of font files. The font system uses this interface
// to enumerate font files when building a font collection.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontFileEnumerator);'}
  IDWriteFontFileEnumerator = interface(IUnknown)
    [SID_IDWriteFontFileEnumerator]
    function MoveNext(var hasCurrentFile: BOOL): HResult; stdcall;

    function GetCurrentFontFile(out fontFile: IDWriteFontFile): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontFileEnumerator}

// Represents a collection of strings indexed by locale name.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteLocalizedStrings);'}
  IDWriteLocalizedStrings = interface(IUnknown)
    [SID_IDWriteLocalizedStrings]
    function GetCount: UINT32; stdcall;
  
    function FindLocaleName(var localeName: WCHAR; var index: Cardinal; 
      var exists: BOOL): HResult; stdcall;
  
    function GetLocaleNameLength(index: Cardinal;
      var length: Cardinal): HResult; stdcall;
  
    function GetLocaleName(index: Cardinal; var localeName: WCHAR; 
      size: Cardinal): HResult; stdcall;
  
    function GetStringLength(index: Cardinal; 
      var length: Cardinal): HResult; stdcall;
  
    function GetString(index: Cardinal; stringBuffer: PWCHAR;
      size: Cardinal): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteLocalizedStrings}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontCollection);'}
  IDWriteFontCollection = interface(IUnknown)
    [SID_IDWriteFontCollection]
    function GetFontFamilyCount: UINT32; stdcall;

    function GetFontFamily(index: Cardinal; 
      out fontFamily: IDWriteFontFamily): HResult; stdcall;
  
    function FindFamilyName(familyName: PWCHAR; var index: Cardinal;
      var exists: BOOL): HResult; stdcall;
  
    function GetFontFromFontFace(var fontFace: IDWriteFontFace; 
      out font: IDWriteFont): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontCollection}

// The IDWriteFontList interface represents a list of fonts.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontList);'}
  IDWriteFontList = interface(IUnknown)
    [SID_IDWriteFontList]
    function GetFontCollection(
      out fontCollection: IDWriteFontCollection): HResult; stdcall;

    function GetFontCount: UINT32; stdcall;
  
    function GetFont(index: Cardinal; out font: IDWriteFont): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontList}

// The IDWriteFontFamily interface represents a set of fonts that share the same design but are differentiated
// by weight, stretch, and style.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFontFamily);'}
  IDWriteFontFamily = interface(IDWriteFontList)
    [SID_IDWriteFontFamily]
    function GetFamilyNames(out names: IDWriteLocalizedStrings): HResult; stdcall;
  
    function GetFirstMatchingFont(weight: DWRITE_FONT_WEIGHT; 
      stretch: DWRITE_FONT_STRETCH; style: DWRITE_FONT_STYLE;
      out matchingFont: IDWriteFont): HResult; stdcall;

    function GetMatchingFonts(weight: DWRITE_FONT_WEIGHT; 
      stretch: DWRITE_FONT_STRETCH; style: DWRITE_FONT_STYLE; 
      out matchingFonts: IDWriteFontList): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFontFamily}

// The IDWriteFont interface represents a physical font in a font collection.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFont);'}
  IDWriteFont = interface(IUnknown)
    [SID_IDWriteFont]
    function GetFontFamily(out fontFamily: IDWriteFontFamily): HResult; stdcall;
  
    function GetWeight: DWRITE_FONT_WEIGHT; stdcall;

    function GetStretch: DWRITE_FONT_STRETCH; stdcall;

    function GetStyle: DWRITE_FONT_STYLE; stdcall;
  
    function IsSymbolFont: BOOL; stdcall;
  
    function GetFaceNames(out names: IDWriteLocalizedStrings): HResult; stdcall;

    function GetInformationalStrings(
      informationalStringID: DWRITE_INFORMATIONAL_STRING_ID; 
      out informationalStrings: IDWriteLocalizedStrings;
      var exists: BOOL): HResult; stdcall;
  
    function GetSimulations: DWRITE_FONT_SIMULATIONS; stdcall;
  
    procedure GetMetrics(var fontMetrics: TDwriteFontMetrics); stdcall;
  
    function HasCharacter(unicodeValue: Cardinal; 
      var exists: BOOL): HResult; stdcall;

    function CreateFontFace(out fontFace: IDWriteFontFace): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteFont}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteTextFormat);'}
  IDWriteTextFormat = interface(IUnknown)
    [SID_IDWriteTextFormat]
    function SetTextAlignment(
      textAlignment: DWRITE_TEXT_ALIGNMENT): HResult; stdcall;

    function SetParagraphAlignment(
      paragraphAlignment: DWRITE_PARAGRAPH_ALIGNMENT): HResult; stdcall;

    function SetWordWrapping(wordWrapping: DWRITE_WORD_WRAPPING): HResult; stdcall;

    function SetReadingDirection(
      readingDirection: DWRITE_READING_DIRECTION): HResult; stdcall;

    function SetFlowDirection(
      flowDirection: DWRITE_FLOW_DIRECTION): HResult; stdcall;

    function SetIncrementalTabStop(incrementalTabStop: Single): HResult; stdcall;

    function SetTrimming(var trimmingOptions: TDwriteTrimming;
      trimmingSign: IDWriteInlineObject): HResult; stdcall;

    function SetLineSpacing(lineSpacingMethod: DWRITE_LINE_SPACING_METHOD;
      lineSpacing: Single; baseline: Single): HResult; stdcall;

    function GetTextAlignment: DWRITE_TEXT_ALIGNMENT; stdcall;

    function GetParagraphAlignment: DWRITE_PARAGRAPH_ALIGNMENT; stdcall;

    function GetWordWrapping: DWRITE_WORD_WRAPPING; stdcall;

    function GetReadingDirection: DWRITE_READING_DIRECTION; stdcall;

    function GetFlowDirection: DWRITE_FLOW_DIRECTION; stdcall;

    function GetIncrementalTabStop: Single; stdcall;

    function GetTrimming(var trimmingOptions: TDwriteTrimming;
      out trimmingSign: IDWriteInlineObject): HResult; stdcall;

    function GetLineSpacing(var lineSpacingMethod: DWRITE_LINE_SPACING_METHOD;
      var lineSpacing: Single; var baseline: Single): HResult; stdcall;

    function GetFontCollection(
      out fontCollection: IDWriteFontCollection): HResult; stdcall;

    function GetFontFamilyNameLength: UINT32; stdcall;

    function GetFontFamilyName(var fontFamilyName: WCHAR;
      nameSize: Cardinal): HResult; stdcall;
  
    function GetFontWeight: DWRITE_FONT_WEIGHT; stdcall;

    function GetFontStyle: DWRITE_FONT_STYLE; stdcall;
  
    function GetFontStretch: DWRITE_FONT_STRETCH; stdcall;
  
    function GetFontSize: Single; stdcall;
  
    function GetLocaleNameLength: UINT32; stdcall;
  
    function GetLocaleName(var localeName: WCHAR;
      nameSize: Cardinal): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteTextFormat}

// Font typography setting.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteTypography);'}
  IDWriteTypography = interface(IUnknown)
    [SID_IDWriteTypography]
    function AddFontFeature(fontFeature: TDwriteFontFeature): HResult; stdcall;
  
    function GetFontFeatureCount: UINT32; stdcall;
  
    function GetFontFeature(fontFeatureIndex: Cardinal;
      var fontFeature: TDwriteFontFeature): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteTypography}

// Holds the appropriate digits and numeric punctuation for a given locale.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteNumberSubstitution);'}
  IDWriteNumberSubstitution = interface(IUnknown)
    [SID_IDWriteNumberSubstitution]
  end;
  {$EXTERNALSYM IDWriteNumberSubstitution}

// The interface implemented by the text analyzer's client to provide text to
// the analyzer. It allows the separation between the logical view of text as
// a continuous stream of characters identifiable by unique text positions,
// and the actual memory layout of potentially discrete blocks of text in the
// client's backing store.
//
// If any of these callbacks returns an error, the analysis functions will
// stop prematurely and return a callback error. Rather than return E_NOTIMPL,
// an application should stub the method and return a constant/null and S_OK.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteTextAnalysisSource);'}
  IDWriteTextAnalysisSource = interface(IUnknown)
    [SID_IDWriteTextAnalysisSource]
    function GetTextAtPosition(textPosition: Cardinal; var textString: PWCHAR;
      var textLength: Cardinal): HResult; stdcall;

    function GetTextBeforePosition(textPosition: Cardinal; var textString: PWCHAR;
      var textLength: Cardinal): HResult; stdcall;
  
    function GetParagraphReadingDirection: DWRITE_READING_DIRECTION; stdcall;
  
    function GetLocaleName(textPosition: Cardinal; var textLength: Cardinal; 
      var localeName: PWCHAR): HResult; stdcall;

    function GetNumberSubstitution(textPosition: Cardinal; var textLength: Cardinal; 
      out numberSubstitution: IDWriteNumberSubstitution): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteTextAnalysisSource}

// The interface implemented by the text analyzer's client to receive the
// output of a given text analysis. The Text analyzer disregards any current
// state of the analysis sink, therefore a Set method call on a range
// overwrites the previously set analysis result of the same range.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteTextAnalysisSink);'}
  IDWriteTextAnalysisSink = interface(IUnknown)
    [SID_IDWriteTextAnalysisSink]
    function SetScriptAnalysis(textPosition: Cardinal; textLength: Cardinal; 
      var scriptAnalysis: TDwriteScriptAnalysis): HResult; stdcall;
  
    function SetLineBreakpoints(textPosition: Cardinal; textLength: Cardinal; 
      var lineBreakpoints: TDwriteLineBreakpoint): HResult; stdcall;
  
    function SetBidiLevel(textPosition: Cardinal; textLength: Cardinal;
      explicitLevel: Byte; resolvedLevel: Byte): HResult; stdcall;
  
    function SetNumberSubstitution(textPosition: Cardinal; textLength: Cardinal;
      var numberSubstitution: IDWriteNumberSubstitution): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteTextAnalysisSink}

// Analyzes various text properties for complex script processing.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteTextAnalyzer);'}
  IDWriteTextAnalyzer = interface(IUnknown)
    [SID_IDWriteTextAnalyzer]
    function AnalyzeScript(var analysisSource: IDWriteTextAnalysisSource; 
      textPosition: Cardinal; textLength: Cardinal;
      var analysisSink: IDWriteTextAnalysisSink): HResult; stdcall;
  
    function AnalyzeBidi(var analysisSource: IDWriteTextAnalysisSource; 
      textPosition: Cardinal; textLength: Cardinal;
      var analysisSink: IDWriteTextAnalysisSink): HResult; stdcall;
  
    function AnalyzeNumberSubstitution(
      var analysisSource: IDWriteTextAnalysisSource; textPosition: Cardinal;
      textLength: Cardinal; 
      var analysisSink: IDWriteTextAnalysisSink): HResult; stdcall;
  
    function AnalyzeLineBreakpoints(var analysisSource: IDWriteTextAnalysisSource;
      textPosition: Cardinal; textLength: Cardinal; 
      var analysisSink: IDWriteTextAnalysisSink): HResult; stdcall;
  
    function GetGlyphs(var textString: WCHAR; textLength: Cardinal;
      var fontFace: IDWriteFontFace; isSideways: BOOL; isRightToLeft: BOOL; 
      var scriptAnalysis: TDwriteScriptAnalysis; var localeName: WCHAR; 
      var numberSubstitution: IDWriteNumberSubstitution; 
      var features: PDwriteTypographicFeatures; var featureRangeLengths: Cardinal;
      featureRanges: Cardinal; maxGlyphCount: Cardinal; var clusterMap: Word; 
      var textProps: TDwriteShapingTextProperties; var glyphIndices: Word; 
      var glyphProps: TDwriteShapingGlyphProperties; 
      var actualGlyphCount: Cardinal): HResult; stdcall;
  
    function GetGlyphPlacements(var textString: WCHAR; var clusterMap: Word; 
      var textProps: TDwriteShapingTextProperties; textLength: Cardinal; 
      var glyphIndices: Word; var glyphProps: TDwriteShapingGlyphProperties;
      glyphCount: Cardinal; var fontFace: IDWriteFontFace; fontEmSize: Single; 
      isSideways: BOOL; isRightToLeft: BOOL;
      var scriptAnalysis: TDwriteScriptAnalysis; var localeName: WCHAR; 
      var features: PDwriteTypographicFeatures; var featureRangeLengths: Cardinal;
      featureRanges: Cardinal; var glyphAdvances: Single; 
      var glyphOffsets: TDwriteGlyphOffset): HResult; stdcall;
    
    function GetGdiCompatibleGlyphPlacements(var textString: WCHAR; var clusterMap: Word; 
      var textProps: TDwriteShapingTextProperties; textLength: Cardinal; 
      var glyphIndices: Word; var glyphProps: TDwriteShapingGlyphProperties;
      glyphCount: Cardinal; var fontFace: IDWriteFontFace; fontEmSize: Single; 
      pixelsPerDip: Single; const transform: DWRITE_MATRiX; useGdiNatural: BOOL;
      isSideways: BOOL; isRightToLeft: BOOL;
      var scriptAnalysis: TDwriteScriptAnalysis; var localeName: WCHAR; 
      var features: PDwriteTypographicFeatures; var featureRangeLengths: Cardinal;
      featureRanges: Cardinal; var glyphAdvances: Single; 
      var glyphOffsets: TDwriteGlyphOffset): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteTextAnalyzer}

// The IDWriteInlineObject interface wraps an application defined inline graphic,
// allowing DWrite to query metrics as if it was a glyph inline with the text.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteInlineObject);'}
  IDWriteInlineObject = interface(IUnknown)
    [SID_IDWriteInlineObject]
    function Draw(clientDrawingContext: Pointer; var renderer: IDWriteTextRenderer;
      originX: Single; originY: Single; isSideways: BOOL; isRightToLeft: BOOL; 
      const clientDrawingEffect: IUnknown): HResult; stdcall;

    function GetMetrics(var metrics: TDwriteInlineObjectMetrics): HResult; stdcall;
  
    function GetOverhangMetrics(
      var overhangs: TDwriteOverhangMetrics): HResult; stdcall;
  
    function GetBreakConditions(var breakConditionBefore: DWRITE_BREAK_CONDITION; 
      var breakConditionAfter: DWRITE_BREAK_CONDITION): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteInlineObject}

// The IDWritePixelSnapping interface defines the pixel snapping properties of a text renderer.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWritePixelSnapping);'}
  IDWritePixelSnapping = interface(IUnknown)
    [SID_IDWritePixelSnapping]
    function IsPixelSnappingDisabled(clientDrawingContext: Pointer;
      var isDisabled: BOOL): HResult; stdcall;

    function GetCurrentTransform(clientDrawingContext: Pointer;
      var transform: TDwriteMatrix): HResult; stdcall;

    function GetPixelsPerDip(clientDrawingContext: Pointer;
      var pixelsPerDip: Single): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWritePixelSnapping}

// The IDWriteTextLayout interface represents a set of application-defined
// callbacks that perform rendering of text, inline objects, and decorations
// such as underlines.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteTextRenderer);'}
  IDWriteTextRenderer = interface(IDWritePixelSnapping)
    [SID_IDWriteTextRenderer]
    function DrawGlyphRun(clientDrawingContext: Pointer; baselineOriginX: Single;
      baselineOriginY: Single; measuringMode: TDWriteMeasuringMode;
      var glyphRun: TDwriteGlyphRun;
      var glyphRunDescription: TDwriteGlyphRunDescription;
      const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawUnderline(clientDrawingContext: Pointer; baselineOriginX: Single;
      baselineOriginY: Single; var underline: TDwriteUnderline;
      const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawStrikethrough(clientDrawingContext: Pointer;
      baselineOriginX: Single; baselineOriginY: Single;
      var strikethrough: TDwriteStrikethrough;
      const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawInlineObject(clientDrawingContext: Pointer; originX: Single;
      originY: Single; var inlineObject: IDWriteInlineObject; isSideways: BOOL;
      isRightToLeft: BOOL; const clientDrawingEffect: IUnknown): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteTextRenderer}

// The IDWriteTextLayout interface represents a block of text after it has
// been fully analyzed and formatted.
//
// All coordinates are in device independent pixels (DIPs).
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteTextLayout);'}
  IDWriteTextLayout = interface(IDWriteTextFormat)
    [SID_IDWriteTextLayout]
    function SetMaxWidth(maxWidth: Single): HResult; stdcall;
  
    function SetMaxHeight(maxHeight: Single): HResult; stdcall;
  
    function SetFontCollection(var fontCollection: IDWriteFontCollection;
      textRange: TDwriteTextRange): HResult; stdcall;

    function SetFontFamilyName(fontFamilyName: PWCHAR;
      textRange: TDwriteTextRange): HResult; stdcall;

    function SetFontWeight(fontWeight: DWRITE_FONT_WEIGHT; 
      textRange: TDwriteTextRange): HResult; stdcall;
  
    function SetFontStyle(fontStyle: DWRITE_FONT_STYLE; 
      textRange: TDwriteTextRange): HResult; stdcall;
  
    function SetFontStretch(fontStretch: DWRITE_FONT_STRETCH; 
      textRange: TDwriteTextRange): HResult; stdcall;
  
    function SetFontSize(fontSize: Single; 
      textRange: TDwriteTextRange): HResult; stdcall;
  
    function SetUnderline(hasUnderline: BOOL; 
      textRange: TDwriteTextRange): HResult; stdcall;
  
    function SetStrikethrough(hasStrikethrough: BOOL;
      textRange: TDwriteTextRange): HResult; stdcall;
  
    function SetDrawingEffect(const drawingEffect: IUnknown;
      textRange: TDwriteTextRange): HResult; stdcall;

    function SetInlineObject(const inlineObject: IDWriteInlineObject;
      textRange: TDwriteTextRange): HResult; stdcall;

    function SetTypography(const typography: IDWriteTypography;
      textRange: TDwriteTextRange): HResult; stdcall;

    function SetLocaleName(var localeName: WCHAR;
      textRange: TDwriteTextRange): HResult; stdcall;
  
    function GetMaxWidth: Single; stdcall;

    function GetMaxHeight: Single; stdcall;
  
    function GetFontCollection(currentPosition: Cardinal; 
      out fontCollection: IDWriteFontCollection;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;

    function GetFontFamilyNameLength(currentPosition: Cardinal;
      var nameLength: Cardinal; 
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;
  
    function GetFontFamilyName(currentPosition: Cardinal; var fontFamilyName: WCHAR; 
      nameSize: Cardinal;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;
  
    function GetFontWeight(currentPosition: Cardinal; 
      var fontWeight: DWRITE_FONT_WEIGHT; 
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;

    function GetFontStyle(currentPosition: Cardinal; 
      var fontStyle: DWRITE_FONT_STYLE; 
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;
  
    function GetFontStretch(currentPosition: Cardinal;
      var fontStretch: DWRITE_FONT_STRETCH; 
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;
  
    function GetFontSize(currentPosition: Cardinal; var fontSize: Single;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;
  
    function GetUnderline(currentPosition: Cardinal; var hasUnderline: BOOL; 
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;
  
    function GetStrikethrough(currentPosition: Cardinal; var hasStrikethrough: BOOL;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;

    function GetDrawingEffect(currentPosition: Cardinal;
      out drawingEffect: IUnknown;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;

    function GetInlineObject(currentPosition: Cardinal;
      out inlineObject: IDWriteInlineObject;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;

    function GetTypography(currentPosition: Cardinal;
      out typography: IDWriteTypography;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;

    function GetLocaleNameLength(currentPosition: Cardinal;
      var nameLength: Cardinal;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;

    function GetLocaleName(currentPosition: Cardinal; var localeName: WCHAR;
      nameSize: Cardinal;
      var textRange: DWRITE_TEXT_RANGE {= NULL}): HResult; stdcall;

    function Draw(clientDrawingContext: Pointer; renderer: IDWriteTextRenderer;
      originX: Single; originY: Single): HResult; stdcall;

    function GetLineMetrics(lineMetrics: PDwriteLineMetrics;
      maxLineCount: Cardinal; var actualLineCount: Cardinal): HResult; stdcall;

    function GetMetrics(var textMetrics: TDwriteTextMetrics): HResult; stdcall;
  
    function GetOverhangMetrics(
      var overhangs: TDwriteOverhangMetrics): HResult; stdcall;

    function GetClusterMetrics(clusterMetrics: PDwriteClusterMetrics;
      maxClusterCount: Cardinal; 
      var actualClusterCount: Cardinal): HResult; stdcall;

    function DetermineMinWidth(var minWidth: Single): HResult; stdcall;
  
    function HitTestPoint(pointX, pointY: Single;
      out isTrailingHit: BOOL; out isInside: BOOL;
      out hitTestMetrics: TDWriteHitTestMetrics): HResult; stdcall;

    function HitTestTextPosition(textPosition: Cardinal; isTrailingHit: BOOL; 
      var pointX: Single; var pointY: Single; 
      var hitTestMetrics: TDwriteHitTestMetrics): HResult; stdcall;
  
    function HitTestTextRange(textPosition: Cardinal; textLength: Cardinal; 
      originX: Single; originY: Single; var hitTestMetrics: TDwriteHitTestMetrics; 
      maxHitTestMetricsCount: Cardinal;
      var actualHitTestMetricsCount: Cardinal): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteTextLayout}

// Encapsulates a 32-bit device independent bitmap and device context, which can be used for rendering glyphs.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteBitmapRenderTarget);'}
  IDWriteBitmapRenderTarget = interface(IUnknown)
    [SID_IDWriteBitmapRenderTarget]
    function DrawGlyphRun(baselineOriginX: Single; baselineOriginY: Single;
      measuringMode: TDWriteMeasuringMode; var glyphRun: TDwriteGlyphRun;
      renderingParams: IDWriteRenderingParams; textColor: COLORREF;
      blackBoxRect: PRect {= NULL}): HResult; stdcall;

    function GetMemoryDC: HDC; stdcall;
  
    function GetPixelsPerDip: Single; stdcall;

    function SetPixelsPerDip(pixelsPerDip: Single): HResult; stdcall;
  
    function GetCurrentTransform(var transform: TDwriteMatrix): HResult; stdcall;
  
    function SetCurrentTransform(var transform: TDwriteMatrix): HResult; stdcall;
  
    function GetSize(var size: TSize): HResult; stdcall;

    function Resize(width: Cardinal; height: Cardinal): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteBitmapRenderTarget}

// The GDI interop interface provides interoperability with GDI.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteGdiInterop);'}
  IDWriteGdiInterop = interface(IUnknown)
    [SID_IDWriteGdiInterop]
    function CreateFontFromLOGFONT(var logFont: LOGFONTW; 
      out font: IDWriteFont): HResult; stdcall;
  
    function ConvertFontToLOGFONT(font: IDWriteFont; var logFont: LOGFONTW;
      var isSystemFont: BOOL): HResult; stdcall;
  
    function ConvertFontFaceToLOGFONT(var font: IDWriteFontFace; 
      var logFont: LOGFONTW): HResult; stdcall;

    function CreateFontFaceFromHdc(hdc: HDC; 
      out fontFace: IDWriteFontFace): HResult; stdcall;
  
    function CreateBitmapRenderTarget(hdc: HDC; width: Cardinal; height: Cardinal;
      out renderTarget: IDWriteBitmapRenderTarget): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteGdiInterop}

// Interface that encapsulates information used to render a glyph run.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteGlyphRunAnalysis);'}
  IDWriteGlyphRunAnalysis = interface(IUnknown)
    [SID_IDWriteGlyphRunAnalysis]
    function GetAlphaTextureBounds(textureType: DWRITE_TEXTURE_TYPE; 
      var textureBounds: TRect): HResult; stdcall;
  
    function CreateAlphaTexture(textureType: DWRITE_TEXTURE_TYPE;
      var textureBounds: TRect; var alphaValues: Byte;
      bufferSize: Cardinal): HResult; stdcall;
  
    function GetAlphaBlendParams(var renderingParams: IDWriteRenderingParams;
      var blendGamma: Single; var blendEnhancedContrast: Single; 
      var blendClearTypeLevel: Single): HResult; stdcall;
  end;
  {$EXTERNALSYM IDWriteGlyphRunAnalysis}

// The root factory interface for all DWrite objects.
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDWriteFactory);'}
  IDWriteFactory = interface(IUnknown)
    [SID_IDWriteFactory]
    function GetSystemFontCollection(out fontCollection: IDWriteFontCollection;
      checkForUpdates: BOOL = FALSE): HResult; stdcall;

    function CreateCustomFontCollection(
      var collectionLoader: IDWriteFontCollectionLoader; collectionKey: Pointer;
      collectionKeySize: Cardinal; 
      out fontCollection: IDWriteFontCollection): HResult; stdcall;

    function RegisterFontCollectionLoader(
      var fontCollectionLoader: IDWriteFontCollectionLoader): HResult; stdcall;

    function UnregisterFontCollectionLoader(
      var fontCollectionLoader: IDWriteFontCollectionLoader): HResult; stdcall;

    function CreateFontFileReference(var filePath: WCHAR;
      var lastWriteTime: FILETIME;
      out fontFile: IDWriteFontFile): HResult; stdcall;

    function CreateCustomFontFileReference(fontFileReferenceKey: Pointer;
      fontFileReferenceKeySize: Cardinal; var fontFileLoader: IDWriteFontFileLoader;
      out fontFile: IDWriteFontFile): HResult; stdcall;

    function CreateFontFace(fontFaceType: DWRITE_FONT_FACE_TYPE;
      numberOfFiles: Cardinal; fontFiles: PIDWriteFontFile;
      faceIndex: Cardinal; fontFaceSimulationFlags: DWRITE_FONT_SIMULATIONS;
      out fontFace: IDWriteFontFace): HResult; stdcall;

    function CreateRenderingParams(
      out renderingParams: IDWriteRenderingParams): HResult; stdcall;

    function CreateMonitorRenderingParams(monitor: HMONITOR;
      out renderingParams: IDWriteRenderingParams): HResult; stdcall;
  
    function CreateCustomRenderingParams(gamma: Single; enhancedContrast: Single;
      clearTypeLevel: Single; pixelGeometry: DWRITE_PIXEL_GEOMETRY;
      renderingMode: DWRITE_RENDERING_MODE; 
      out renderingParams: IDWriteRenderingParams): HResult; stdcall;

    function RegisterFontFileLoader(
      var fontFileLoader: IDWriteFontFileLoader): HResult; stdcall;

    function UnregisterFontFileLoader(
      var fontFileLoader: IDWriteFontFileLoader): HResult; stdcall;
  
    function CreateTextFormat(const fontFamilyName: PWideChar;
      fontCollection: IDWriteFontCollection; fontWeight: DWRITE_FONT_WEIGHT;
      fontStyle: DWRITE_FONT_STYLE; fontStretch: DWRITE_FONT_STRETCH;
      fontSize: Single; const localeName: PWideChar;
      out textFormat: IDWriteTextFormat): HResult; stdcall;
  
    function CreateTypography(
      out typography: IDWriteTypography): HResult; stdcall;
  
    function GetGdiInterop(out gdiInterop: IDWriteGdiInterop): HResult; stdcall;

    function CreateTextLayout(_string: PWCHAR; stringLength: Cardinal;
      const textFormat: IDWriteTextFormat; maxWidth: Single; maxHeight: Single;
      out textLayout: IDWriteTextLayout): HResult; stdcall;
  
    function CreateGdiCompatibleTextLayout(var _string: WCHAR; stringLength: Cardinal;
      var textFormat: IDWriteTextFormat; layoutWidth: Single; layoutHeight: Single;
      pixelsPerDip: Single; var transform: TDwriteMatrix; useGdiNatural: BOOL;
      out textLayout: IDWriteTextLayout): HResult; stdcall;
  
    function CreateEllipsisTrimmingSign(textFormat: IDWriteTextFormat;
      out trimmingSign: IDWriteInlineObject): HResult; stdcall;
  
    function CreateTextAnalyzer(
      out textAnalyzer: IDWriteTextAnalyzer): HResult; stdcall;
  
    function CreateNumberSubstitution(
      substitutionMethod: DWRITE_NUMBER_SUBSTITUTION_METHOD; 
      var localeName: WideString; ignoreUserOverride: BOOL;
      out numberSubstitution: IDWriteNumberSubstitution): HResult; stdcall;

    function CreateGlyphRunAnalysis(var glyphRun: TDwriteGlyphRun;
      pixelsPerDip: Single; var transform: TDwriteMatrix;
      renderingMode: TDWriteRenderingMode; measuringMode: TDWriteMeasuringMode;
      baselineOriginX: Single; baselineOriginY: Single;
      out glyphRunAnalysis: IDWriteGlyphRunAnalysis): HResult; stdcall;
  
  end;
  {$EXTERNALSYM IDWriteFactory}
const
//// D2DErr.h : Errors
// The pixel format is not supported.
  D2DERR_UNSUPPORTED_PIXEL_FORMAT     = WINCODEC_ERR_UNSUPPORTEDPIXELFORMAT;
  {$EXTERNALSYM D2DERR_UNSUPPORTED_PIXEL_FORMAT}
// The supplied buffer was too small to accomodate the data.
  D2DERR_INSUFFICIENT_BUFFER          = HResult($8007007A);
  {$EXTERNALSYM D2DERR_INSUFFICIENT_BUFFER}

// The object was not in the correct state to process the method.
  D2DERR_WRONG_STATE                  = HResult($88990001);
  {$EXTERNALSYM D2DERR_WRONG_STATE}
// The object has not yet been initialized.
  D2DERR_NOT_INITIALIZED              = HResult($88990002);
  {$EXTERNALSYM D2DERR_NOT_INITIALIZED}
// The requested opertion is not supported.
  D2DERR_UNSUPPORTED_OPERATION        = HResult($88990003);
  {$EXTERNALSYM D2DERR_UNSUPPORTED_OPERATION}
// The geomery scanner failed to process the data.
  D2DERR_SCANNER_FAILED               = HResult($88990004);
  {$EXTERNALSYM D2DERR_SCANNER_FAILED}
// D2D could not access the screen.
  D2DERR_SCREEN_ACCESS_DENIED         = HResult($88990005);
  {$EXTERNALSYM D2DERR_SCREEN_ACCESS_DENIED}
// A valid display state could not be determined.
  D2DERR_DISPLAY_STATE_INVALID        = HResult($88990006);
  {$EXTERNALSYM D2DERR_DISPLAY_STATE_INVALID}
// The supplied vector is vero.
  D2DERR_ZERO_VECTOR                  = HResult($88990007);
  {$EXTERNALSYM D2DERR_ZERO_VECTOR}
// An internal error (D2D bug) occurred. On checked builds, we would assert.
//
// The application should close this instance of D2D and should consider
// restarting its process.
  D2DERR_INTERNAL_ERROR               = HResult($88990008);
  {$EXTERNALSYM D2DERR_INTERNAL_ERROR}
// The display format we need to render is not supported by the
// hardware device.
  D2DERR_DISPLAY_FORMAT_NOT_SUPPORTED = HResult($88990009);
  {$EXTERNALSYM D2DERR_DISPLAY_FORMAT_NOT_SUPPORTED}
// A call to this method is invalid.
  D2DERR_INVALID_CALL                 = HResult($8899000A);
  {$EXTERNALSYM D2DERR_INVALID_CALL}
// No HW rendering device is available for this operation.
  D2DERR_NO_HARDWARE_DEVICE           = HResult($8899000B);
  {$EXTERNALSYM D2DERR_NO_HARDWARE_DEVICE}
// There has been a presentation error that may be recoverable. The caller
// needs to recreate, rerender the entire frame, and reattempt present.
  D2DERR_RECREATE_TARGET              = HResult($8899000C);
  {$EXTERNALSYM D2DERR_RECREATE_TARGET}
// Shader construction failed because it was too complex.
  D2DERR_TOO_MANY_SHADER_ELEMENTS     = HResult($8899000D);
  {$EXTERNALSYM D2DERR_TOO_MANY_SHADER_ELEMENTS}
// Shader compilation failed.
  D2DERR_SHADER_COMPILE_FAILED        = HResult($8899000E);
  {$EXTERNALSYM D2DERR_SHADER_COMPILE_FAILED}
// Requested DX surface size exceeded maximum texture size.
  D2DERR_MAX_TEXTURE_SIZE_EXCEEDED    = HResult($8899000F);
  {$EXTERNALSYM D2DERR_MAX_TEXTURE_SIZE_EXCEEDED}
// The requested D2D version is not supported.
  D2DERR_UNSUPPORTED_VERSION          = HResult($88990010);
  {$EXTERNALSYM D2DERR_UNSUPPORTED_VERSION}
// Invalid number.
  D2DERR_BAD_NUMBER                   = HResult($88990011);
  {$EXTERNALSYM D2DERR_BAD_NUMBER}
// Objects used together must be created from the same factory instance.
  D2DERR_WRONG_FACTORY                = HResult($88990012);
  {$EXTERNALSYM D2DERR_WRONG_FACTORY}
// A layer resource can only be in use once at any point in time.
  D2DERR_LAYER_ALREADY_IN_USE         = HResult($88990013);
  {$EXTERNALSYM D2DERR_LAYER_ALREADY_IN_USE}
// The pop call did not match the corresponding push call
  D2DERR_POP_CALL_DID_NOT_MATCH_PUSH  = HResult($88990014);
  {$EXTERNALSYM D2DERR_POP_CALL_DID_NOT_MATCH_PUSH}
// The resource was realized on the wrong render target
  D2DERR_WRONG_RESOURCE_DOMAIN        = HResult($88990015);
  {$EXTERNALSYM D2DERR_WRONG_RESOURCE_DOMAIN}
// The push and pop calls were unbalanced;
  D2DERR_PUSH_POP_UNBALANCED          = HResult($88990016);
  {$EXTERNALSYM D2DERR_PUSH_POP_UNBALANCED}
// Attempt to copy from a render target while a layer or clip rect is applied
  D2DERR_RENDER_TARGET_HAS_LAYER_OR_CLIPRECT = HResult($88990017);
  {$EXTERNALSYM D2DERR_RENDER_TARGET_HAS_LAYER_OR_CLIPRECT}
// The brush types are incompatible for the call.
  D2DERR_INCOMPATIBLE_BRUSH_TYPES     = HResult($88990018);
  {$EXTERNALSYM D2DERR_INCOMPATIBLE_BRUSH_TYPES}
// An unknown win32 failure occurred.
  D2DERR_WIN32_ERROR                  = HResult($88990019);
  {$EXTERNALSYM D2DERR_WIN32_ERROR}
// The render target is not compatible with GDI
  D2DERR_TARGET_NOT_GDI_COMPATIBLE    = HResult($8899001A);
  {$EXTERNALSYM D2DERR_TARGET_NOT_GDI_COMPATIBLE}
// A text client drawing effect object is of the wrong type
  D2DERR_TEXT_EFFECT_IS_WRONG_TYPE    = HResult($8899001B);
  {$EXTERNALSYM D2DERR_TEXT_EFFECT_IS_WRONG_TYPE}
// The application is holding a reference to the IDWriteTextRenderer interface
// after the corresponding DrawText or DrawTextLayout call has returned. The
// IDWriteTextRenderer instance will be zombied.
  D2DERR_TEXT_RENDERER_NOT_RELEASED   = HResult($8899001C);
  {$EXTERNALSYM D2DERR_TEXT_RENDERER_NOT_RELEASED}
// The requested size is larger than the guaranteed supported texture size.
  D2DERR_EXCEEDS_MAX_BITMAP_SIZE      = HResult($8899001D);
  {$EXTERNALSYM D2DERR_EXCEEDS_MAX_BITMAP_SIZE}

//// DWrite.h : Errors
// Indicates an error in an input file such as a font file.
  DWRITE_E_FILEFORMAT                 = HResult($88985000);
  {$EXTERNALSYM DWRITE_E_FILEFORMAT}
// Indicates an error originating in DirectWrite code, which is not expected to occur but is safe to recover from.
  DWRITE_E_UNEXPECTED                 = HResult($88985001);
  {$EXTERNALSYM DWRITE_E_UNEXPECTED}
// Indicates the specified font does not exist.
  DWRITE_E_NOFONT                     = HResult($88985002);
  {$EXTERNALSYM DWRITE_E_NOFONT}
// A font file could not be opened because the file, directory, network location, drive, or other storage
// location does not exist or is unavailable.
  DWRITE_E_FILENOTFOUND               = HResult($88985003);
  {$EXTERNALSYM DWRITE_E_FILENOTFOUND}
// A font file exists but could not be opened due to access denied, sharing violation, or similar error.
  DWRITE_E_FILEACCESS                 = HResult($88985004);
  {$EXTERNALSYM DWRITE_E_FILEACCESS}
// A font collection is obsolete due to changes in the system.
  DWRITE_E_FONTCOLLECTIONOBSOLETE     = HResult($88985005);
  {$EXTERNALSYM DWRITE_E_FONTCOLLECTIONOBSOLETE}
// The given interface is already registered.
  DWRITE_E_ALREADYREGISTERED          = HResult($88985006);
  {$EXTERNALSYM DWRITE_E_ALREADYREGISTERED}

//// D2D1.h : Functions
function D2D1CreateFactory(factoryType: D2D1_FACTORY_TYPE; const riid: TGUID;
  pFactoryOptions: PD2D1FactoryOptions; out ppIFactory: ID2D1Factory): HRESULT; stdcall;
{$EXTERNALSYM D2D1CreateFactory}


procedure D2D1MakeRotateMatrix(angle: Single; center: D2D1_POINT_2F;
  matrix: PD2D1Matrix3x2F); stdcall;
{$EXTERNALSYM D2D1MakeRotateMatrix}

procedure D2D1MakeSkewMatrix(angleX: Single; angleY: Single;
  center: D2D1_POINT_2F; matrix: PD2D1Matrix3x2F); stdcall;
{$EXTERNALSYM D2D1MakeSkewMatrix}

function D2D1IsMatrixInvertible(matrix: PD2D1Matrix3x2F): BOOL; stdcall;
{$EXTERNALSYM D2D1IsMatrixInvertible}

function D2D1InvertMatrix(matrix: PD2D1Matrix3x2F): BOOL; stdcall;
{$EXTERNALSYM D2D1InvertMatrix}

//// DWrite.H : Functions
// <summary>
// Creates a DirectWrite factory object that is used for subsequent creation of individual DirectWrite objects.
// </summary>
// <param name="factoryType">Identifies whether the factory object will be shared or isolated.</param>
// <param name="iid">Identifies the DirectWrite factory interface, such as __uuidof(IDWriteFactory).</param>
// <param name="factory">Receives the DirectWrite factory object.</param>
// <returns>
// Standard HRESULT error code.
// </returns>
// <remarks>
// Obtains DirectWrite factory object that is used for subsequent creation of individual DirectWrite classes.
// DirectWrite factory contains internal state such as font loader registration and cached font data.
// In most cases it is recommended to use the shared factory object, because it allows multiple components
// that use DirectWrite to share internal DirectWrite state and reduce memory usage.
// However, there are cases when it is desirable to reduce the impact of a component,
// such as a plug-in from an untrusted source, on the rest of the process by sandboxing and isolating it
// from the rest of the process components. In such cases, it is recommended to use an isolated factory for the sandboxed
// component.
// </remarks>
function DWriteCreateFactory(factoryType: DWRITE_FACTORY_TYPE; const iid: TGUID;
  out factory: IUnknown): HRESULT; stdcall;
{$EXTERNALSYM DWriteCreateFactory}

//// D2D1Helper.h
function D2D1PointF(const X, Y: Single): TD2D1Point2F; inline;
//function D2D1Point2U(const X, Y: UInt32): TD2D1Point2U; inline;
function D2D1SizeF(const Width, Height: Single) : TD2D1SizeF; inline;
function D2D1SizeU(const Width, Height: UInt32) : TD2D1SizeU; inline;
function D2D1RectF(const Left, Top, Right, Bottom: Single): TD2D1RectF; inline; overload;
//function D2D1RectU(const Left, Top, Right, Bottom: UInt32): TD2D1RectU; inline; overload;
function D2D1ArcSegment(const Point: TD2D1Point2F; const Size: TD2D1SizeF;
  RotationAngle: Single; const sweepDirection: TD2D1SweepDirection;
  const ArcSize: TD2D1ArcSize): TD2D1ArcSegment;
function D2D1BezierSegment(const A,B,C: TD2D1Point2F) : TD2D1BezierSegment;
function D2D1Ellipse(Center: TD2D1Point2F; const Rx, Ry : Single): TD2D1Ellipse;
function D2D1RoundedRect(const Rect: TD2D1RectF; RadiusX, RadiusY: Single): TD2D1RoundedRect;
//function D2D1BrushProperties(const Opacity: Single = 1.0; const Transform: TD2D1Matrix3x2F);
function D2D1GradientStop(const Position: Single; const Color: TD2D1ColorF): TD2D1GradientStop;
function D2D1QuadraticBezierSegment(const A,B: TD2D1Point2F) : TD2D1QuadraticBezierSegment;
function D2D1StrokeStyleProperties(StartCap: TD2D1CapStyle = D2D1_CAP_STYLE_FLAT;
 EndCap: TD2D1CapStyle = D2D1_CAP_STYLE_FLAT; DashCap: TD2D1CapStyle = D2D1_CAP_STYLE_FLAT;
 LineJoin: TD2D1LineJoin = D2D1_LINE_JOIN_MITER; MiterLimit: Single = 10;
 DashStyle: TD2D1DashStyle = D2D1_DASH_STYLE_SOLID; DashOffset: Single= 0): TD2D1StrokeStyleProperties;
//function D2D1BitmapBrushProperties(ExtendModeX: TD2D1ExtendMode = D2D1_EXTEND_MODE_CLAMP;
//  ExtendModeY: TD2D1ExtendMode = D2D1_EXTEND_MODE_CLAMP;
//  InterpolationMode: TD2D1BitmapInterpolationMode = D2D1_BITMAP_INTERPOLATION_MODE_LINEAR): TD2D1BitmapBrushProperties;
function D2D1LinearGradientBrushProperties(const StartPoint, EndPoint: TD2D1Point2F): TD2D1LinearGradientBrushProperties;
function D2D1RadialGradientBrushProperties(const Center, GradientOriginOffset: TD2D1Point2F;
  RadiusX, RadiusY: Single): TD2D1RadialGradientBrushProperties;
function D2D1PixelFormat(const DxgiFormat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
  AlphaMode: TD2D1AlphaMode = D2D1_ALPHA_MODE_UNKNOWN): TD2D1PixelFormat;
function D2D1BitmapProperties(): TD2D1BitmapProperties; overload;
function D2D1BitmapProperties(PixleFormat: TD2D1PixelFormat;
  DpiX: Single = 96; DpiY: Single = 96): TD2D1BitmapProperties; overload;
function D2D1RenderTargetProperties(&Type: TD2D1RenderTargetType = D2D1_RENDER_TARGET_TYPE_DEFAULT): TD2D1RenderTargetProperties; overload;
function D2D1RenderTargetProperties(&Type: TD2D1RenderTargetType;
  const PixelFormat: TD2D1PixelFormat; DpiX: Single = 0; DpiY: Single = 0;
  Usage: TD2D1RenderTargetUsage = D2D1_RENDER_TARGET_USAGE_NONE;
  MinLevel: TD2D1FeatureLevel = D2D1_FEATURE_LEVEL_DEFAULT): TD2D1RenderTargetProperties; overload;
function D2D1HwndRenderTargetProperties(Hwnd: HWND): TD2D1HwndRenderTargetProperties; overload;
function D2D1HwndRenderTargetProperties(Hwnd: HWND; PixelSize: TD2D1SizeU;
  PresentOptions: TD2D1PresentOptions = D2D1_PRESENT_OPTIONS_NONE): TD2D1HwndRenderTargetProperties; overload;
//function D2D1LayerParameters(const ContentBounds: TD2D1RectF; const GeometryMask: ID2D1Geometry=nil;
//  MaskAntiAliasMode: TD2D1AntiAliasMode = D2D1_ANTIALIAS_MODE_PER_PRIMITIVE; Opacity: Single = 1;
//  const OpacityBrush: ID2D1Brush = nil; LayerOptions: TD2D1LayerOptions = D2D1_LAYER_OPTIONS_NONE): TD2D1LayerParameters;
//function D2D1DrawingStateDescription(AntialiasMode: TD2D1AntiAliasMode=D2D1_ANTIALIAS_MODE_PER_PRIMITIVE;
//  TextAntialiasMode: TD2D1TextAntiAliasMode = D2D1_TEXT_ANTIALIAS_MODE_DEFAULT;
//  tag1, tag2: TD2D1Tag = 0; const transform: TD2D1Matrix3x2F): TD2D1DrawingStateDescription;

function D2D1ColorF(const R,G,B,A: Single) : TD2D1ColorF; inline; overload;

type
  TD2DMatrix3x2FHelper = record helper for TD2DMatrix3X2F
    class function Identity: TD2DMatrix3X2F; static;

    class function Translation(const pos: TD2DPoint2f): TD2DMatrix3X2F; overload; static;
    class function Translation(const x, y: Single): TD2DMatrix3X2F; overload; static;

    class function Scale(const size: TD2DSizeF; const center: TD2DPoint2f): TD2DMatrix3X2F; overload; static;
    class function Scale(const width, height: Single; const center: TD2DPoint2f): TD2DMatrix3X2F; overload; static;

    class function Rotation(const angle: Single; const size: TD2DPoint2f): TD2DMatrix3X2F; overload; static;
    class function Rotation(const angle, x, y: Single): TD2DMatrix3X2F; overload; static;

    class function Skew(const angleX, angleY : Single; const center : TD2DPoint2f): TD2DMatrix3X2F; overload; static;

    function Determinant: Single; inline;

    function IsInvertible: Boolean; inline;

    function Invert: Boolean; inline;

    class function SetProduct(a, b: TD2DMatrix3X2F): TD2DMatrix3X2F; static;

  end;

const
  dwritelib = 'DWRITE.DLL';
  d2d1lib = 'd2d1.dll';

implementation

class operator D2D_RECT_F.Implicit(AValue: TRect): D2D_RECT_F;
begin
  Result.top := AValue.Top;
  Result.left := AValue.Left;
  Result.bottom := AValue.Bottom;
  Result.right := AValue.Right;
end;

class operator D2D_RECT_F.Explicit(AValue: D2D_RECT_F): TRect;
begin
  Result.top := Trunc(AValue.Top);
  Result.left := Trunc(AValue.Left);
  Result.bottom := Trunc(AValue.Bottom);
  Result.right := Trunc(AValue.Right);
end;

function TD2DMatrix3x2FHelper.Invert: Boolean;
begin
  Result := D2D1InvertMatrix(@self);
end;

function TD2DMatrix3x2FHelper.IsInvertible: Boolean;
begin
  Result := D2D1IsMatrixInvertible(@self);
end;

class operator D2D_MATRIX_3X2_F.Multiply(const Left: D2D_MATRIX_3X2_F; const Right: D2D_MATRIX_3X2_F): D2D_MATRIX_3X2_F;
begin
  Result := SetProduct(Left, Right);
end;

function TD2DMatrix3x2FHelper.Determinant: Single;
begin
  Result := (_11 * _21) - (_12 * _21);
end;

class function TD2DMatrix3x2FHelper.Rotation(
  const angle: Single; const size: D2D_POINT_2F): D2D_MATRIX_3X2_F;
begin
  D2D1MakeRotateMatrix(angle, size, @result);
end;

class function TD2DMatrix3x2FHelper.Rotation(const angle,
  x, y: Single): D2D_MATRIX_3X2_F;
begin
  Result := D2D_MATRIX_3X2_F.Rotation(angle, D2D1PointF(x,y));
end;

class function TD2DMatrix3x2FHelper.Scale(const width,
  height: Single; const center: D2D_POINT_2F): D2D_MATRIX_3X2_F;
begin
  Result := D2D_MATRIX_3X2_F.Scale(D2D1SizeF(width, height), center);
end;

class function TD2DMatrix3x2FHelper.Scale(
  const size: D2D_SIZE_F; const center: D2D_POINT_2F): D2D_MATRIX_3X2_F;
begin
  Result._11 := size.width;
  Result._12 := 0.0;
  Result._21 := 0.0;
  Result._22 := size.height;
  Result._31 := center.x - size.width * center.x;
  Result._32 := center.y - size.height * center.y;
end;

class function TD2DMatrix3x2FHelper.SetProduct(a,
  b: D2D_MATRIX_3X2_F): D2D_MATRIX_3X2_F;
begin
    Result._11 := a._11 * b._11 + a._12 * b._21;
    Result._12 := a._11 * b._12 + a._12 * b._22;
    Result._21 := a._21 * b._11 + a._22 * b._21;
    Result._22 := a._21 * b._12 + a._22 * b._22;
    Result._31 := a._31 * b._11 + a._32 * b._21 + b._31;
    Result._32 := a._31 * b._12 + a._32 * b._22 + b._32;
end;

class function TD2DMatrix3x2FHelper.Skew(const angleX,
  angleY: Single; const center : D2D_POINT_2F): D2D_MATRIX_3X2_F;
begin
  D2D1MakeSkewMatrix(angleX, angleY, center, @result);
end;

class function TD2DMatrix3x2FHelper.Translation(const x,
  y: Single): D2D_MATRIX_3X2_F;
begin
  Result := D2D_MATRIX_3X2_F.Translation(D2D1PointF(x,y));
end;

class function TD2DMatrix3x2FHelper.Translation(
  const pos: D2D_POINT_2F): D2D_MATRIX_3X2_F;
begin
  with Result do
  begin
    _11 := 1.0;   _12 := 0.0;
    _21 := 0.0;   _22 := 1.0;
    _31 := pos.x; _32 := pos.y;
  end;
end;

class function TD2DMatrix3x2FHelper.Identity: D2D_MATRIX_3X2_F;
    const Ident : D2D_MATRIX_3X2_F = (
      _11: 1.0; _12: 0.0;
      _21: 0.0; _22: 1.0;
      _31: 0.0; _32: 0.0; );
begin
  Result := Ident;
end;

class operator D2D_POINT_2F.Implicit(AValue: TPoint): D2D_POINT_2F;
begin
  Result.x := AValue.X;
  Result.y := AValue.Y;
end;

class operator D2D_POINT_2F.Explicit(AValue: D2D_POINT_2F): TPoint;
begin
  Result.x := Trunc(AValue.X);
  Result.y := Trunc(AValue.Y);
end;

class operator D2D_POINT_2F.Multiply(point: D2D_POINT_2F; matrix: D2D_MATRIX_3X2_F): D2D_POINT_2F;
begin
  Result.x := point.x * matrix._11 + point.y * matrix._21 + matrix._31;
  Result.y := point.x * matrix._12 + point.y * matrix._22 + matrix._32;
end;

var
  hDWRITE: HMODULE;
  hD2D1: HMODULE;

procedure InitD2D1; inline;
begin
  if hD2D1 = 0 then
    hD2D1 := LoadLibrary(d2d1lib);
end;

procedure FreeD2D1; inline;
begin
  if hD2D1 > 0 then
    FreeLibrary(hD2D1);
end;

procedure InitDWRITE; inline;
begin
  if hDWRITE = 0 then
    hDWRITE := LoadLibrary(dwritelib);
end;

procedure FreeDWRITE; inline;
begin
  if hDWRITE > 0 then
    FreeLibrary(hDWRITE);
end;

var
  _DWriteCreateFactory: function(factoryType: DWRITE_FACTORY_TYPE;
    const iid: TGUID; out factory: IUnknown): HRESULT; stdcall;


function DWriteCreateFactory(factoryType: DWRITE_FACTORY_TYPE;
  const iid: TGUID; out factory: IUnknown): HRESULT;
begin
  if Assigned(_DWriteCreateFactory) then
    Result := _DWriteCreateFactory(factoryType, iid, factory)
  else
  begin
    InitDWRITE;
    Result := E_NOTIMPL;
    if hDWRITE > 0 then
    begin
      _DWriteCreateFactory := GetProcAddress(hDWRITE, 'DWriteCreateFactory'); // Do not localize
      if Assigned(_DWriteCreateFactory) then
        Result := _DWriteCreateFactory(factoryType, iid, factory);
    end;
  end;
end;

var
  _D2D1CreateFactory: function (factoryType: D2D1_FACTORY_TYPE; const riid: TGUID;
  pFactoryOptions: PD2D1FactoryOptions; out ppIFactory: ID2D1Factory): HRESULT; stdcall;

  _D2D1MakeRotateMatrix: procedure(angle: Single; center: D2D1_POINT_2F;
    matrix: PD2D1Matrix3x2F); stdcall;

  _D2D1MakeSkewMatrix: procedure(angleX: Single; angleY: Single;
    center: D2D1_POINT_2F; matrix: PD2D1Matrix3x2F); stdcall;

  _D2D1IsMatrixInvertible: function(matrix: PD2D1Matrix3x2F): BOOL; stdcall;

  _D2D1InvertMatrix: function(matrix: PD2D1Matrix3x2F): BOOL; stdcall;


function D2D1CreateFactory(factoryType: D2D1_FACTORY_TYPE; const riid: TGUID; //TIID
  pFactoryOptions: PD2D1FactoryOptions; out ppIFactory: ID2D1Factory): HRESULT;
begin
  if Assigned(_D2D1CreateFactory) then
    Result := _D2D1CreateFactory(factoryType, riid, pFactoryOptions, ppIFactory)
  else
  begin
    InitD2D1;
    Result := E_NOTIMPL;
    if hD2D1 > 0 then
    begin
      _D2D1CreateFactory := GetProcAddress(hD2D1, 'D2D1CreateFactory'); // Do not localize
      if Assigned(_D2D1CreateFactory) then
        Result := _D2D1CreateFactory(factoryType, riid, pFactoryOptions,
          ppIFactory);
    end;
  end;
end;

procedure D2D1MakeRotateMatrix(angle: Single; center: D2D1_POINT_2F;
  matrix: PD2D1Matrix3x2F);
begin
  if Assigned(_D2D1MakeRotateMatrix) then
    _D2D1MakeRotateMatrix(angle, center, matrix)
  else
  begin
    InitD2D1;
    if hD2D1 > 0 then
    begin
      _D2D1MakeRotateMatrix := GetProcAddress(hD2D1, 'D2D1MakeRotateMatrix'); // Do not localize
      if Assigned(_D2D1MakeRotateMatrix) then
        _D2D1MakeRotateMatrix(angle, center, matrix);
    end;
  end;
end;

procedure D2D1MakeSkewMatrix(angleX: Single; angleY: Single;
  center: D2D1_POINT_2F; matrix: PD2D1Matrix3x2F);
begin
  if Assigned(_D2D1MakeSkewMatrix) then
    _D2D1MakeSkewMatrix(angleX, angleY, center, matrix)
  else
  begin
    InitD2D1;
    if hD2D1 > 0 then
    begin
      _D2D1MakeSkewMatrix := GetProcAddress(hD2D1, 'D2D1MakeSkewMatrix'); // Do not localize
      if Assigned(_D2D1MakeSkewMatrix) then
        _D2D1MakeSkewMatrix(angleX, angleY, center, matrix);
    end;
  end;
end;

function D2D1IsMatrixInvertible(matrix: PD2D1Matrix3x2F): BOOL;
begin
  if Assigned(_D2D1IsMatrixInvertible) then
    Result := _D2D1IsMatrixInvertible(matrix)
  else
  begin
    InitD2D1;
    Result := FALSE;
    if hD2D1 > 0 then
    begin
      _D2D1IsMatrixInvertible := GetProcAddress(hD2D1, 'D2D1IsMatrixInvertible'); // Do not localize
      if Assigned(_D2D1IsMatrixInvertible) then
        Result := _D2D1IsMatrixInvertible(matrix);
    end;
  end;
end;

function D2D1InvertMatrix(matrix: PD2D1Matrix3x2F): BOOL;
begin
  if Assigned(_D2D1InvertMatrix) then
    Result := _D2D1InvertMatrix(matrix)
  else
  begin
    InitD2D1;
    Result := FALSE;
    if hD2D1 > 0 then
    begin
      _D2D1InvertMatrix := GetProcAddress(hD2D1, 'D2D1InvertMatrix'); // Do not localize
      if Assigned(_D2D1InvertMatrix) then
        Result := _D2D1InvertMatrix(matrix);
    end;
  end;
end;


function D2D1PointF(const x, y : Single) : TD2D1Point2F;
begin
  result.x := x;
  result.y := y;
end;

function D2D1SizeF(const width, height: Single) : TD2D1SizeF;
begin
  result.width := width;
  result.height := height;
end;

function D2D1SizeU(const Width, Height: UINT32) : TD2D1SizeU;
begin
  result.width := width;
  result.height := height;
end;

function D2D1RectF(const left, top, right, bottom: Single): TD2D1RectF;
begin
  Result.left := left;
  Result.top := top;
  Result.right := right;
  Result.bottom := bottom;
end;

function D2D1ArcSegment(const Point: TD2D1Point2F; const Size: TD2D1SizeF;
  RotationAngle: Single; const sweepDirection: TD2D1SweepDirection;
  const ArcSize: TD2D1ArcSize): TD2D1ArcSegment;
begin
  Result.point := Point;
  Result.size := Size;
  Result.rotationAngle := RotationAngle;
  Result.sweepDirection := sweepDirection;
  Result.arcSize := ArcSize;
end;

function D2D1ColorF(const r,g,b,a : Single) : TD2D1ColorF;
begin
  Result.r := r;
  Result.g := g;
  Result.b := b;
  Result.a := a;
end;

function D2D1BezierSegment(const a,b,c: D2D1_Point_2F) : TD2D1BezierSegment;
begin
  Result.point1 := a;
  Result.point2 := b;
  Result.point3 := c;
end;

function D2D1GradientStop(const Position: Single; const Color: TD2D1ColorF): TD2D1GradientStop;
begin
  Result.position := Position;
  Result.color := Color;
end;

function D2D1QuadraticBezierSegment(const A,B: TD2D1Point2F) : TD2D1QuadraticBezierSegment;
begin
  Result.point1 := a;
  Result.point2 := b;
end;

function D2D1StrokeStyleProperties(StartCap: TD2D1CapStyle;
  EndCap: TD2D1CapStyle; DashCap: TD2D1CapStyle;
  LineJoin: TD2D1LineJoin; MiterLimit: Single;
  DashStyle: TD2D1DashStyle; DashOffset: Single): TD2D1StrokeStyleProperties;
begin
  Result.startCap :=  StartCap;
  Result.endCap := EndCap;
  Result.dashCap := DashCap;
  Result.lineJoin := LineJoin;
  Result.miterLimit := MiterLimit;
  Result.dashStyle := DashStyle;
  Result.dashOffset := DashOffset;
end;

function D2D1Ellipse(center: TD2D1Point2F; const rx, ry : Single) : TD2D1Ellipse;
begin
  Result.point := center;
  Result.radiusX := rx;
  result.radiusY := ry;
end;

function D2D1RoundedRect(const Rect: TD2D1RectF; RadiusX, RadiusY: Single): TD2D1RoundedRect;
begin
  result.rect := Rect;
  result.radiusX := RadiusX;
  result.radiusY := RadiusY;
end;

function D2D1LinearGradientBrushProperties(const StartPoint, EndPoint: TD2D1Point2F): TD2D1LinearGradientBrushProperties;
begin
  Result.startPoint := StartPoint;
  Result.endPoint := EndPoint;
end;

function D2D1RadialGradientBrushProperties(const Center, GradientOriginOffset: TD2D1Point2F;
  RadiusX, RadiusY: Single): TD2D1RadialGradientBrushProperties;
begin
  Result.center := Center;
  Result.gradientOriginOffset := GradientOriginOffset;
  Result.radiusX :=  RadiusX;
  Result.radiusY := RadiusY;
end;

function D2D1PixelFormat(const DxgiFormat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
  AlphaMode: TD2D1AlphaMode = D2D1_ALPHA_MODE_UNKNOWN): TD2D1PixelFormat;
begin
  Result.format := DxgiFormat;
  Result.alphaMode := AlphaMode;
end;

function D2D1RenderTargetProperties(&Type: TD2D1RenderTargetType = D2D1_RENDER_TARGET_TYPE_DEFAULT): TD2D1RenderTargetProperties; overload;
begin
  Result := D2D1RenderTargetProperties(&Type, D2D1PixelFormat());
end;

function D2D1RenderTargetProperties(&Type: TD2D1RenderTargetType;
  const PixelFormat: TD2D1PixelFormat; DpiX: Single = 0; DpiY: Single = 0;
  Usage: TD2D1RenderTargetUsage = D2D1_RENDER_TARGET_USAGE_NONE;
  MinLevel: TD2D1FeatureLevel = D2D1_FEATURE_LEVEL_DEFAULT): TD2D1RenderTargetProperties; overload;
begin
  Result.&type := &Type;
  Result.pixelFormat := PixelFormat;
  Result.dpiX := DpiX;
  Result.dpiY := DpiY;
  Result.usage := Usage;
  Result.minLevel := MinLevel;
end;

function D2D1HwndRenderTargetProperties(Hwnd: HWND): TD2D1HwndRenderTargetProperties; overload;
begin
 Result := D2D1HwndRenderTargetProperties(hwnd, D2D1SizeU(0,0));
end;

function D2D1HwndRenderTargetProperties(Hwnd: HWND; PixelSize: TD2D1SizeU;
  PresentOptions: TD2D1PresentOptions = D2D1_PRESENT_OPTIONS_NONE): TD2D1HwndRenderTargetProperties; overload;
begin
  Result.hwnd := Hwnd;
  Result.pixelSize := PixelSize;
  result.presentOptions := PresentOptions;
end;

function D2D1BitmapProperties(): TD2D1BitmapProperties;
begin
  Result := D2D1BitmapProperties(D2D1PixelFormat());
end;

function D2D1BitmapProperties(PixleFormat: TD2D1PixelFormat;
  DpiX: Single = 96; DpiY: Single = 96): TD2D1BitmapProperties; overload;
begin
  Result.pixelFormat := PixleFormat;
  Result.dpiX := DpiX;
  Result.dpiY := DpiY;
end;

{ example:
      property breakConditionAfter: Byte Index $0203 read GetBits write SetBits; // mask $0003, offset $0002 
}
function DWRITE_LINE_BREAKPOINT.GetByte(const Index: Integer): Byte;
begin
  Result := ((data shr (Index shr 8)) and (Index and $FF));
end;
procedure DWRITE_LINE_BREAKPOINT.SetByte(const Index: Integer; value: Byte);
begin
  // offset = index shr 8           , 2 in example
  // mask = index and $FF           , $0003 in example
  // shifted mask = mask shl offset , $000B in example 
  data := (data and (not ((Index and $FF) shl (Index shr 8)))) or
    ((value and Index and $FF) shl (Index shr 8));
end;

{ example
      property reserved: WORD Index $00017FFF   read GetWord write SetWord; // mask $7FFF, offset 1
}
function DWRITE_SHAPING_TEXT_PROPERTIES.GetWord(const index: Integer): WORD;
begin
  Result := ((data shr (index shr 16)) and (index and $FFFF));
end;
procedure DWRITE_SHAPING_TEXT_PROPERTIES.SetWord(const index: Integer; value: WORD);
begin
  // offset = index shr 16          , 1 in example
  // mask = index and $FFFF         , $7FFF in example
  // shifted mask = mask shl offset , $FFFE in example 
  data := (data and (not ((index and $FFFF) shl (index shr 16)))) or
    ((value and index and $FFFF) shl (index shr 16));
end;

{ example
      property reserved: WORD Index $000701FF read GetWord write SetWord; // mask $01FF, offset 7
}
function DWRITE_SHAPING_GLYPH_PROPERTIES.GetWord(const index: Integer): WORD;
begin
  Result := ((data shr (index shr 16)) and (index and $FFFF));
end;
procedure DWRITE_SHAPING_GLYPH_PROPERTIES.SetWord(const index: Integer; value: WORD);
begin
  // offset = index shr 16          , 7 in example
  // mask = index and $FFFF         , $01FF in example
  // shifted mask = mask shl offset , $0FF8 in example 
  data := (data and (not ((index and $FFFF) shl (index shr 16)))) or
    ((value and index and $FFFF) shl (index shr 16));
end;

{ example
      property isRightToLeft: WORD Index $00040001 read GetWord write SetWord; // mask $0001, offset 4
}
function DWRITE_CLUSTER_METRICS.GetWord(const index: Integer): WORD;
begin
  Result := ((data shr (index shr 16)) and (index and $FFFF));
end;
procedure DWRITE_CLUSTER_METRICS.SetWord(const index: Integer; value: WORD);
begin
  // offset = index shr 16          , 4 in example
  // mask = index and $FFFF         , $0001 in example
  // shifted mask = mask shl offset , $FFFE in example 
  data := (data and (not ((index and $FFFF) shl (index shr 16)))) or
    ((value and index and $FFFF) shl (index shr 16));
end;

initialization

finalization
  FreeDWRITE;
  FreeD2D1;
end.
