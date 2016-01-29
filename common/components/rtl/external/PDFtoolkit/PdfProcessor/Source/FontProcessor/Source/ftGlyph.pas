{******************************************************************************}
{                                                       	               }
{ FreeType convenience functions to handle glyphs interface Unit               }
{ for Object Pascal                                                            }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftGlyph.h. The original Pascal code is                 }
{ ftGlyph.pas, released February 2004. The initial developer of the            }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{ 								               }
{******************************************************************************}
unit ftGlyph;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  FreeType, ftTypes, ftImage;

type
  PPFT_Glyph = ^PFT_Glyph;
  PFT_Glyph = ^TFT_GlyphRec;

  PFT_GlyphRec = ^TFT_GlyphRec;
  PPFT_GlyphRec = ^PFT_GlyphRec;

  TFT_GlyphRec = record
    FTLibrary: PFT_Library;
    GlyphClass: Pointer;
    GlyphFormat: TFT_Glyph_Format;
    Advance:TFT_Vector;
  end;

  PFT_BitmapGlyph = ^TFT_BitmapGlyphRec;

  PFT_BitmapGlyphRec = ^TFT_BitmapGlyphRec;
  TFT_BitmapGlyphRec = record
    root: TFT_GlyphRec;
    left: TFT_Int;
    top: TFT_Int;
    bitmap: TFT_Bitmap;
  end;

  TFT_OutlineGlyph = ^TFT_OutlineGlyphRec;

  TFT_OutlineGlyphRec = record
    root: TFT_GlyphRec;
    outline:TFT_Outline;
  end;


  TFT_Get_Glyph = function(ASlot:PFT_GlyphSlot; var AGlyph: PFT_Glyph):TFT_ERROR; cdecl;
  TFT_Glyph_Copy = function(ASource:PFT_Glyph; var ATarget: PFT_Glyph):TFT_ERROR; cdecl;
  TFT_Glyph_Transform = function(AGlyph:PFT_Glyph; AMatrix: PFT_Matrix; ADelta:PFT_Vector):TFT_ERROR; cdecl;

{$IFDEF VCL6ORABOVE}
  TFT_Glyph_BBox_Mode = (FT_GLYPH_BBOX_UNSCALED = 0, FT_GLYPH_BBOX_SUBPIXELS = 0, FT_GLYPH_BBOX_GRIDFIT = 1,
    FT_GLYPH_BBOX_TRUNCATE = 2, FT_GLYPH_BBOX_PIXELS = 3);
{$ENDIF}

{$IFDEF DELPHI5}
  TFT_Glyph_BBox_Mode = Integer;
  const
    FT_GLYPH_BBOX_UNSCALED = 0;
    FT_GLYPH_BBOX_SUBPIXELS = 0;
    FT_GLYPH_BBOX_GRIDFIT = 1;
    FT_GLYPH_BBOX_TRUNCATE = 2;
    FT_GLYPH_BBOX_PIXELS = 3;
{$ENDIF}

type
  TFT_Glyph_Get_CBox = procedure(AGlyph:PFT_Glyph; ABBoxMode:TFT_UInt; var ACBox:TFT_BBox); cdecl;
  TFT_Glyph_To_Bitmap = function(AGlyph:PPFT_Glyph; ARenderMode:TFT_Render_Mode; AOrigin:PFT_Vector; ADestroy:TFT_Bool):TFT_ERROR; cdecl;

  TFT_Done_Glyph = procedure(AGlyph:PFT_Glyph); cdecl;

  TFT_Matrix_Multiply = procedure(AMatrix1,AMatrix2: PFT_Matrix); cdecl;
  TFT_Matrix_Invert = function(AMatrix:PFT_Matrix):TFT_ERROR; cdecl;

implementation

end.
 