{******************************************************************************}
{                                                       	               }
{ FreeType Support for the FT_Outline type used to store glyph shapes of most  }
{ scalable font formats interface Unit for Object Pascal                       }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftOutln.h. The original Pascal code is                 }
{ ftOutln.pas, released February 2004. The initial developer of the            }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftoutln;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftTypes, ftObjs, ftSystem, ftImage;

type
{$IFDEF VCL6ORABOVE}
  TFT_Orientation = (
    FT_ORIENTATION_TRUETYPE   = 0,
    FT_ORIENTATION_POSTSCRIPT = 1,
    FT_ORIENTATION_FILL_RIGHT = FT_ORIENTATION_TRUETYPE,
    FT_ORIENTATION_FILL_LEFT  = FT_ORIENTATION_POSTSCRIPT
  );
{$ENDIF}

{$IFDEF DELPHI5}
  TFT_Orientation = Integer;
  const
    FT_ORIENTATION_TRUETYPE   = 0;
    FT_ORIENTATION_POSTSCRIPT = 1;
    FT_ORIENTATION_FILL_RIGHT = FT_ORIENTATION_TRUETYPE;
    FT_ORIENTATION_FILL_LEFT  = FT_ORIENTATION_POSTSCRIPT;
{$ENDIF}

type
  TFT_Outline_Decompose = function(var AOutline:TFT_Outline; AFuncInterface:PFT_Outline_Funcs; AUser:Pointer):TFT_ERROR; cdecl;
  TFT_Outline_New = function(ALibrary:PFT_LibraryInt; ANumPoints:TFT_UInt; ANumContours:TFT_Int; var AOutLine:TFT_Outline):TFT_ERROR; cdecl;
  TFT_Outline_New_Internal = function(AMemory:PFT_Memory; ANumPoints:TFT_UInt; ANumContours:TFT_Int; var AOutLine:TFT_Outline):TFT_ERROR; cdecl;
  TFT_Outline_Done = function(ALibrary:PFT_LibraryInt; var AOutline:TFT_Outline):TFT_ERROR; cdecl;
  TFT_Outline_Done_Internal = function(AMemory:PFT_Memory; var AOutline:TFT_Outline):TFT_ERROR; cdecl;
  TFT_Outline_Check = function(var AOutline:TFT_Outline):TFT_ERROR; cdecl;
  TFT_Outline_Get_CBox = procedure(var AOutline:TFT_Outline; var ACBox:TFT_BBox); cdecl;
  TFT_Outline_Translate = procedure(var AOutline:TFT_Outline; AXOffset, AYOffset: TFT_Pos); cdecl;
  TFT_Outline_Copy = function(var ASourceOutline:TFT_Outline; var ATargetOutline:TFT_Outline):TFT_ERROR; cdecl;
  TFT_Outline_Transform = procedure(var AOutline:TFT_Outline; var AMatrix:TFT_Matrix); cdecl;
  TFT_Outline_Reverse = procedure(var AOutline:TFT_Outline); cdecl;
  TFT_Outline_Get_Bitmap = function(ALibrary:PFT_LibraryInt; var AOutline:TFT_Outline; var ABitmap:TFT_BITMAP):TFT_ERROR; cdecl;
  TFT_Outline_Render = function(ALibrary:PFT_LibraryInt; var AOutline:TFT_Outline; AParams:PFT_Raster_Params):TFT_ERROR; cdecl;

implementation

end.
 