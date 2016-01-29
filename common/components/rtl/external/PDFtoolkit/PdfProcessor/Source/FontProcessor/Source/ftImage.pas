{******************************************************************************}
{                                                       	               }
{ FreeType glyph image formats and default raster interface interface Unit     }
{ for Object Pascal                                                            }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftImage.h. The original Pascal code is                 }
{ ftImage.pas, released February 2004. The initial developer of the            }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftImage;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftTypes;

type

  TFT_Pos = LongInt;

  PFT_Vector = ^TFT_Vector;
  TFT_Vector = record
    X: TFT_Pos;
    Y: TFT_Pos;
  end;

  TFT_BBox = record
    xMin, yMin:TFT_Pos;
    xMax, yMax:TFT_Pos;
  end;

  TFT_Pixel_Mode=(FT_PIXEL_MODE_NONE, FT_PIXEL_MODE_MONO, FT_PIXEL_MODE_GRAY, FT_PIXEL_MODE_GRAY2,
    FT_PIXEL_MODE_GRAY4, FT_PIXEL_MODE_LCD, FT_PIXEL_MODE_LCD_V, FT_PIXEL_MODE_MAX);

  TFT_Palette_Mode=(ft_palette_mode_rgb, ft_palette_mode_rgba, ft_palettte_mode_max);

  PFT_BITMAP = ^TFT_BITMAP;
  TFT_BITMAP = record
    Rows:LongInt;
    Width:LongInt;
    Pitch:LongInt;
    Buffer:Pointer;
    NumberOfGrays:SmallInt;
    PixelMode:Byte;
    PaletteMode:Byte;
    Palette:Pointer;
  end;

  TFT_Outline = record
    n_contours:SmallInt;
    n_points:SmallInt;
    points:PFT_Vector;
    tags: ^AnsiChar;
    contours:PSmallInt;
    flags:Integer;
  end;

  TFT_Outline_MoveToFunc = ^TFT_Outline_MoveToFunc_;
  TFT_Outline_MoveToFunc_ = function(ATo:PFT_Vector; AUser:Pointer):Integer; cdecl;
  TFT_Outline_MoveTo_Func = TFT_Outline_MoveToFunc;

  TFT_Outline_LineToFunc = ^TFT_Outline_LineToFunc_;
  TFT_Outline_LineToFunc_ = function(ATo:PFT_Vector; AUser:Pointer):Integer; cdecl;
  TFT_Outline_LineTo_Func = TFT_Outline_LineToFunc;

  TFT_Outline_ConicToFunc = ^TFT_Outline_ConicToFunc_;
  TFT_Outline_ConicToFunc_ = function(AControl:PFT_Vector; ATo:PFT_Vector; AUser:Pointer):Integer; cdecl;
  TFT_Outline_ConicTo_Func = TFT_Outline_ConicToFunc;

  TFT_Outline_CubicToFunc = ^TFT_Outline_CubicToFunc_;
  TFT_Outline_CubicToFunc_ = function(AControl1:PFT_Vector; AControl2:PFT_Vector; ATo:PFT_Vector; AUser:Pointer):Integer;cdecl;
  TFT_Outline_CubicTo_Func = TFT_Outline_CubicToFunc;

  PFT_Outline_Funcs = ^TFT_Outline_Funcs;
  TFT_Outline_Funcs = record
    move_to:TFT_Outline_MoveToFunc;
    line_to:TFT_Outline_LineToFunc;
    conic_to:TFT_Outline_ConicToFunc;
    cubic_to:TFT_Outline_CubicToFunc;

    shift:Integer;
    delta:TFT_Pos;
  end;


{$IFDEF VCL6ORABOVE}

  TFT_Glyph_Format = ( FT_GLYPH_FORMAT_NONE=0,
                       FT_GYLPH_FORMAT_COMPOSITE=(99 shl 24) or (111 shl 16) or (109 shl 8) or (112),
                       FT_GLYPH_FORMAT_BITMAP=(98 shl 24) or (105 shl 16) or (116 shl 8) or (115),
                       FT_GLYPH_FORMAT_OUTLINE=(111 shl 24) or (117 shl 16) or (116 shl 8) or (108),
                       FT_GLYPH_FORMAT_PLOTTER=(112 shl 24) or (108 shl 16) or (111 shl 8) or (116));
{$ENDIF}

{$IFDEF DELPHI5}
  TFT_Glyph_Format = Integer;
  const
  FT_GLYPH_FORMAT_NONE = 0;
  FT_GYLPH_FORMAT_COMPOSITE = (99 shl 24) or (111 shl 16) or (109 shl 8) or (112);
  FT_GLYPH_FORMAT_BITMAP = (98 shl 24) or (105 shl 16) or (116 shl 8) or (115);
  FT_GLYPH_FORMAT_OUTLINE = (111 shl 24) or (117 shl 16) or (116 shl 8) or (108);
  FT_GLYPH_FORMAT_PLOTTER = (112 shl 24) or (108 shl 16) or (111 shl 8) or (116);

{$ENDIF}

type
  PFT_Raster = ^TFT_RasterRec;
  TFT_RasterRec = Pointer;

  PFT_Span = ^TFT_Span;
  TFT_Span = record
    x:SmallInt;
    len:Word;
    coverage:Byte;
  end;

  TFT_SpanFunc = ^TFT_SpanFunc_;
  TFT_SpanFunc_ = procedure(y:Integer; Count:Integer; Spans: PFT_Span; AUser:Pointer); cdecl;
  TFT_Raster_Span_Func = TFT_SpanFunc;

  TFT_Raster_BitTest_Func = ^TFT_Raster_BitTest_Func_;
  TFT_Raster_BitTest_Func_=function(y,x:Integer; AUser:Pointer):Integer; cdecl;

  TFT_Raster_BitSet_Func = ^TFT_Raster_BitSet_Func_;
  TFT_Raster_BitSet_Func_ = procedure(y,x:Integer; AUser:Pointer); cdecl;

  PFT_Raster_Params = ^TFT_Raster_Params;
  TFT_Raster_Params = record
    target:PFT_Bitmap;
    source:Pointer;
    flags:Integer;
    gray_spans:TFT_SpanFunc;
    black_spans:TFT_SpanFunc;
    bit_test:TFT_Raster_BitTest_Func;     // doesn't work!
    bit_set:TFT_Raster_BitSet_Func;       // doesn't work!
    user:Pointer;
    clip_box:TFT_BBox;
  end;

  TFT_Raster_NewFunc = ^TFT_Raster_NewFunc_;
  TFT_Raster_NewFunc_ = function(AMemory:Pointer; var ARaster: PFT_Raster):Integer; cdecl;
  TFT_Raster_New_Func = TFT_Raster_NewFunc;

  TFT_Raster_DoneFunc = ^TFT_Raster_DoneFunc_;
  TFT_Raster_DoneFunc_ = procedure(ARaster:PFT_Raster); cdecl;
  TFT_Raster_Done_Func = TFT_Raster_DoneFunc;

  TFT_Raster_ResetFunc = ^TFT_Raster_ResetFunc_;
  TFT_Raster_ResetFunc_ = procedure(ARaster:PFT_Raster; APool_Base:PByte; APool_Size:Cardinal); cdecl;
  TFT_Raster_Reset_Func = TFT_Raster_ResetFunc;

  TFT_Raster_SetModeFunc = ^TFT_Raster_SetModeFunc_;
  TFT_Raster_SetModeFunc_ = function(ARaster:PFT_Raster; AMode:Cardinal; AArgs:Pointer):Integer; cdecl;
  TFT_Raster_Set_Mode_Func = TFT_Raster_SetModeFunc;

  TFT_Raster_RenderFunc = ^TFT_Raster_RenderFunc_;
  TFT_Raster_RenderFunc_ = function(ARaster:PFT_Raster; AParams:PFT_Raster_Params):Integer; cdecl;
  TFT_Raster_Render_Func = TFT_Raster_RenderFunc;

  TFT_Raster_Funcs = record
    glyph_format:TFT_Glyph_Format;
    raster_new:TFT_Raster_NewFunc;
    raster_reset:TFT_Raster_ResetFunc;
    raster_set_mode:TFT_Raster_SetModeFunc;
    raster_render:TFT_Raster_RenderFunc;
    raster_done:TFT_Raster_DoneFunc;
  end;

const
  FT_OUTLINE_NONE                       = $0;
  FT_OUTLINE_OWNER                      = $1;
  FT_OUTLINE_EVEN_ODD_FILL              = $2;
  FT_OUTLINE_REVERSE_FILL               = $4;
  FT_OUTLINE_IGNORE_DROPOUTS            = $8;

  FT_OUTLINE_HIGH_PRECISION             = $100;
  FT_OUTLINE_SINGLE_PASS                = $200;

  FT_CURVE_TAG_ON                       = 1;
  FT_CURVE_TAG_CONIC                    = 0;
  FT_CURVE_TAG_CUBIC                    = 2;

  FT_CURVE_TAG_TOUCH_X                  = 8;  // reserved for the TrueType hinter
  FT_CURVE_TAG_TOUCH_Y                  = 16; // reserved for the TrueType hinter

  FT_RASTER_FLAG_DEFAULT                = $0;
  FT_RASTER_FLAG_AA                     = $1;
  FT_RASTER_FLAG_DIRECT                 = $2;
  FT_RASTER_FLAG_CLIP                   = $4;

implementation

end.
