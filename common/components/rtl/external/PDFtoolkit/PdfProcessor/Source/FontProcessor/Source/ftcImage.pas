{******************************************************************************}
{                                                       	               }
{ FreeType Generic Image cache (specification)                                 }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftcImage.h. The original Pascal code is                }
{ ftcImage.pas, released February 2004. The initial developer of the           }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftcImage;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftCache, ftTypes, ftGlyph, ftConfig;

type
  PFTC_ImageType = ^TFTC_ImageTypeRec;
  TFTC_ImageTypeRec = record
    font:TFTC_FontRec;
    flags:TFT_Int32;
  end;


  PFTC_ImageCache = ^TFTC_ImageCacheRec;
  TFTC_ImageCacheRec = record
  end;

  TFTC_ImageCache_New=function(AManager:PFTC_Manager; var ACache:PFTC_ImageCache):TFT_ERROR; cdecl;
  TFTC_ImageCache_Lookup=function(ACache:PFTC_ImageCache; AImageType:PFTC_ImageType; AGlyphIndex: TFT_UInt; var AGlyph:PFT_Glyph; var ANode:PFTC_Node):TFT_ERROR; cdecl;

const
  ftc_image_format_bitmap       = $0;
  ftc_image_format_outline      = $1;

  ftc_image_format_mask         = $F;

  ftc_image_flag_monochrome     = $10;
  ftc_image_flag_unhinted       = $20;
  ftc_image_flag_autohinted     = $40;
  ftc_image_flag_unscaled       = $80;
  ftc_image_flag_no_sbits       = $100;

  // monochrome bitmap
  ftc_image_mono                = ftc_image_format_bitmap or ftc_image_flag_monochrome;

  // anti-aliased bitmap
  ftc_image_grays               = ftc_image_format_bitmap;

  // scaled outline
  ftc_image_outline             = ftc_image_format_outline;

type
  PFTC_Image_Cache = PFTC_ImageCache;

  PFTC_Image_Desc = ^TFTC_Image_DescRec;
  TFTC_Image_DescRec = record
    font:TFTC_FontRec;
    image_type:TFT_UInt;
  end;

  TFTC_Image_Cache_New = function(AManager:PFTC_Manager; var ACache:PFTC_Image_Cache):TFT_ERROR; cdecl;
  TFTC_Image_Cache_Lookup = function(ACache: PFTC_Image_Cache; var ADesc:PFTC_Image_Desc; AGlyphIndex:TFT_UInt; var AGlyph:PFT_Glyph):TFT_ERROR; cdecl;


implementation

end.
