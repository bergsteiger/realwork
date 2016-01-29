{******************************************************************************}
{                                                       	               }
{ FreeType small-bitmap cache interface Unit for Object Pascal                 }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 2000-2001, 2002 by                                                 }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftcSBits.h. The original Pascal code is                }
{ ftcSBits.pas, released February 2004. The initial developer of the           }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftcSBits;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftTypes, ftCache, ftcImage;

type
  PFTC_SBit = ^TFTC_SBitRec;

  TFTC_SBitRec = record
    width:TFT_Byte;
    height:TFT_Byte;
    left:TFT_Char;
    top:TFT_Char;

    format:TFT_Byte;
    max_grays:TFT_Byte;
    pitch:TFT_Short;
    xadvance:TFT_Char;
    yadvance:TFT_Char;

    buffer: PFT_Byte;
  end;

  PFTC_SBitCache = ^TFTC_SBitCacheRec;
  TFTC_SBitCacheRec = record
  end;

  PFTC_SBit_Cache = PFTC_SBitCache;

  TFTC_SBitCache_New = function(AManager:PFTC_Manager; var ACache:PFTC_SBitCache):TFT_ERROR; cdecl;
  TFTC_SBitCache_Lookup = function(ACache:PFTC_SBitCache; AType:PFTC_ImageType; AGlyphIndex:TFT_UInt; var ASBit: PFTC_SBit; var ANode:PFTC_Node):TFT_ERROR; cdecl;

  TFTC_SBit_Cache_New = function(AManager:PFTC_Manager; var ACache:PFTC_SBit_Cache):TFT_ERROR; cdecl;
  TFTC_SBit_Cache_Lookup = function(ACache:PFTC_SBit_Cache; var ADesc:PFTC_Image_Desc; AGlyphIndex:TFT_UInt; var ASBit:PFTC_SBit):TFT_ERROR; cdecl;

implementation

end.
