{******************************************************************************}
{                                                       	               }
{ FreeType high-level API and common types interface Unit for Object Pascal    }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: freetype.h. The original Pascal code is                }
{ FreeType.pas, released February 2004. The initial developer of the           }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit FreeType;

{$I ..\..\Utils\gtCompilerDefines.inc}

interface

uses
  ftTypes, ftImage, ftobjs, ftConfig, Windows, sysutils;

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

type

{$IFDEF VCL6ORABOVE}

  TFT_Encoding=(FT_ENCODING_NONE=0,
    FT_ENCODING_MS_SYMBOL=(115 shl 24) or (121 shl 16) or (109 shl 8) or (98),
    FT_ENCODING_UNICODE=(117 shl 24) or (110 shl 16) or (105 shl 8) or (99),

    FT_ENCODING_SJIS=(115 shl 24) or (106 shl 16) or (105 shl 8) or (115),
    FT_ENCODING_GB2312=(103 shl 24) or (98 shl 16) or (32 shl 8) or (32),
    FT_ENCODING_BIG5=(98 shl 24) or (105 shl 16) or (103 shl 8) or (53),
    FT_ENCODING_WANSUNG=(119 shl 24) or (97 shl 16) or (110 shl 8) or (115),
    FT_ENCODING_JOHAB=(106 shl 24) or (111 shl 16) or (104 shl 8) or (97),

    FT_ENCODING_MS_SJIS    = FT_ENCODING_SJIS,
    FT_ENCODING_MS_GB2312  = FT_ENCODING_GB2312,
    FT_ENCODING_MS_BIG5    = FT_ENCODING_BIG5,
    FT_ENCODING_MS_WANSUNG = FT_ENCODING_WANSUNG,
    FT_ENCODING_MS_JOHAB   = FT_ENCODING_JOHAB,

    FT_ENCODING_ADOBE_STANDARD=(65 shl 24) or (68 shl 16) or (79 shl 8) or (66),
    FT_ENCODING_ADOBE_EXPERT=(65 shl 24) or (68 shl 16) or (66 shl 8) or (69),
    FT_ENCODING_ADOBE_CUSTOM=(65 shl 24) or (68 shl 16) or (66 shl 8) or (67),
    FT_ENCODING_ADOBE_LATIN_1=(108 shl 24) or (97 shl 16) or (116 shl 8) or (49),

    FT_ENCODING_OLD_LATIN_2=(108 shl 24) or (97 shl 16) or (116 shl 8) or (50),

    FT_ENCODING_APPLE_ROMAN=(97 shl 24) or (114 shl 16) or (109 shl 8) or (110));
{$ENDIF}

{$IFDEF DELPHI5}
  TFT_Encoding = Integer;
  const
    FT_ENCODING_NONE = 0;
    FT_ENCODING_MS_SYMBOL = (115 shl 24) or (121 shl 16) or (109 shl 8) or (98);
    FT_ENCODING_UNICODE = (117 shl 24) or (110 shl 16) or (105 shl 8) or (99);

    FT_ENCODING_SJIS = (115 shl 24) or (106 shl 16) or (105 shl 8) or (115);
    FT_ENCODING_GB2312 = (103 shl 24) or (98 shl 16) or (32 shl 8) or (32);
    FT_ENCODING_BIG5 = (98 shl 24) or (105 shl 16) or (103 shl 8) or (53);
    FT_ENCODING_WANSUNG = (119 shl 24) or (97 shl 16) or (110 shl 8) or (115);
    FT_ENCODING_JOHAB = (106 shl 24) or (111 shl 16) or (104 shl 8) or (97);

    FT_ENCODING_MS_SJIS    = FT_ENCODING_SJIS;
    FT_ENCODING_MS_GB2312  = FT_ENCODING_GB2312;
    FT_ENCODING_MS_BIG5    = FT_ENCODING_BIG5;
    FT_ENCODING_MS_WANSUNG = FT_ENCODING_WANSUNG;
    FT_ENCODING_MS_JOHAB   = FT_ENCODING_JOHAB;

    FT_ENCODING_ADOBE_STANDARD=(65 shl 24) or (68 shl 16) or (79 shl 8) or (66);
    FT_ENCODING_ADOBE_EXPERT=(65 shl 24) or (68 shl 16) or (66 shl 8) or (69);
    FT_ENCODING_ADOBE_CUSTOM=(65 shl 24) or (68 shl 16) or (66 shl 8) or (67);
    FT_ENCODING_ADOBE_LATIN_1=(108 shl 24) or (97 shl 16) or (116 shl 8) or (49);

    FT_ENCODING_OLD_LATIN_2=(108 shl 24) or (97 shl 16) or (116 shl 8) or (50);

    FT_ENCODING_APPLE_ROMAN=(97 shl 24) or (114 shl 16) or (109 shl 8) or (110);
{$ENDIF}

type
  PPS_PrivateRec = ^TPS_PrivateRec;

  TPS_PrivateRec = record
    Force_bold: TFT_Bool;
  end;

  PPS_FontInfoRec = ^TPS_FontInfoRec;

  TPS_FontInfoRec = record
    Version: PFT_String;
    Notice: PFT_String;
    Full_name: PFT_String;
    Family_name: PFT_String;
    Weight: PFT_String;
    Italic_angle: TFT_Long;
    Is_fixed_pitch: TFT_Bool;
    Underline_position: TFT_Short;
    Underline_thickness: TFT_UShort;
  end;

  PFT_Library = ^TFT_LibraryRec;
  PFT_Module = ^TFT_ModuleRec;

  TFT_Glyph_Metrics = record
    Width: TFT_Pos;
    Height: TFT_Pos;
    HorzBearingX: TFT_Pos;
    HorzBearingY: TFT_Pos;
    HorzAdvance: TFT_Pos;
    VertBearingX: TFT_Pos;
    VertBearingY: TFT_Pos;
    VertAdvance: TFT_Pos;
  end;

  PFT_Bitmap_Size = ^TFT_Bitmap_Size;
  TFT_Bitmap_Size = record
    height:TFT_Short;
    width:TFT_Short;

    size:TFT_Pos;

    x_ppem:TFT_Pos;
    y_ppem:TFT_Pos;
  end;

  PFT_Driver = ^TFT_DriverRec;
  PFT_Renderer = ^TFT_RendererRec;

  PFT_GlyphSlotRec = ^TFT_GlyphSlotRec;
  PFT_GlyphSlot = PFT_GlyphSlotRec;

  PPFT_Face = ^PFT_Face;
  PFT_Face = ^TFT_FaceRec;

  TFT_SubGlyph = ^TFT_SubGlyphRec;

  TFT_SubGlyphRec = record
    index: TFT_Int;
    flags: TFT_UShort;
    arg1: TFT_Int;
    arg2: TFT_Int;
    transform: TFT_Matrix;
  end;

  TFT_GlyphSlotRec = record
    FTLibrary: PFT_Library;
    Face:PFT_Face;
    next:PFT_GlyphSlot;
    reserved:TFT_UInt;
    generic:TFT_Generic;

    metrics: TFT_Glyph_Metrics;
    linearHoriAdvance:TFT_Fixed;
    linearVertAdvance:TFT_Fixed;
    advance:TFT_Vector;

    format: TFT_Glyph_Format;

    bitmap:TFT_Bitmap;
    bitmap_left:TFT_Int;
    bitmap_top:TFT_Int;

    outline:TFT_Outline;

    num_subglyphs:TFT_UInt;
    subglyphs:TFT_SubGlyph;

    control_data:Pointer;
    control_len:LongInt;

    other:Pointer;

    internal:Pointer;
  end;

  PPFT_Size = ^PFT_Size;
  PFT_Size = ^TFT_SizeRec;

  TFT_Size_Metrics = record
    x_ppem:TFT_UShort;
    y_ppem:TFT_UShort;

    x_scale:TFT_Fixed;
    y_scale:TFT_Fixed;

    ascender:TFT_Pos;
    descender:TFT_Pos;
    height:TFT_Pos;
    max_advance:TFT_Pos;
  end;

  TFT_SizeRec = record
    Face:PFT_Face;
    Generic:TFT_Generic;
    metrics:TFT_Size_Metrics;
    internal:Pointer;
  end;

  PPFT_CharMap = ^PFT_CharMap;
  PFT_CharMap = ^TFT_CharMapRec;

  TFT_CharMapRec=record
    Face:PFT_Face;
    encoding:TFT_Encoding;
    platform_id:TFT_UShort;
    encoding_id:TFT_UShort;
  end;

  TFT_FaceRec = record

    num_faces:TFT_Long;
    face_index:TFT_Long;

    face_flags:TFT_Long;
    style_flags:TFT_Long;

    num_glyphs:TFT_Long;

    family_name:PFT_String;
    style_name:PFT_String;

    num_fixed_sizes:TFT_Int;
    available_sizes:PFT_Bitmap_Size;

    num_charmaps:TFT_Int;
    charmaps:PPFT_CharMap;

    generic:TFT_Generic;

    bbox:TFT_BBox;

    units_per_EM:TFT_UShort;
    ascender:TFT_Short;
    descender:TFT_Short;
    height:TFT_Short;

    max_advance_width:TFT_Short;
    max_advance_height:TFT_Short;

    underline_position:TFT_Short;
    underline_thickness:TFT_Short;

    glyph:PFT_GlyphSlot;
    size:PFT_Size;
    charmap:PFT_CharMap;

    driver:Pointer; //FT_Driver
    memory:Pointer; //FT_Memory
    stream:Pointer; //FT_Stream

    sizes_list:TFT_ListRec;

    autohint:TFT_Generic;
    extensions: Pointer; //void*

    internal:Pointer;
  end;

  TFT_Init_FreeType = function(var ALibrary:PFT_Library):TFT_ERROR; cdecl;
  TFT_Library_Version = procedure(Alibrary:PFT_Library; var AMajor:TFT_Int; var AMinor:TFT_Int; var APatch:TFT_Int); cdecl;
  TFT_Done_FreeType = function(ALibrary:PFT_Library):TFT_ERROR; cdecl;


const
  FT_OPEN_MEMORY                       =$1;
  FT_OPEN_STREAM                       =$2;
  FT_OPEN_PATHNAME                     =$4;
  FT_OPEN_DRIVER                       =$8;
  FT_OPEN_PARAMS                       =$10;

type
  PFT_Parameter = ^TFT_Parameter;
  TFT_Parameter = record
    tag:TFT_ULong;
    data:PFT_Pointer;
  end;

  PFT_Open_Args = ^TFT_Open_Args;
  TFT_Open_Args = record
    flags:TFT_UInt;
    memory_base:PFT_Byte;
    memory_size:TFT_Long;
    pathname:PFT_String;
    stream:pointer; //TFT_Stream
    driver:pointer; //FT_Module
    num_params:TFT_Int;
    params:PFT_Parameter;
  end;

  TFT_New_Face=function(Alibrary:PFT_Library; AFileName:PAnsiChar; AFaceIndex:TFT_Long; var AFace:PFT_Face):TFT_ERROR; cdecl;
  TFT_New_Memory_Face = function(ALibrary:PFT_Library; var AFileBase:PFT_Byte; AFileSize:TFT_Long; AFaceIndex:TFT_Long;
    var AFace:PFT_Face):TFT_Error; cdecl;
  TFT_Open_Face=function(ALibrary:PFT_Library; AArgs:PFT_Open_Args; AFaceIndex:TFT_Long;var AFace:PFT_Face):TFT_Error; cdecl;
  TFT_Attach_File=function(AFace:PFT_Face; AFilePathName:PAnsiChar):TFT_ERROR; cdecl;
  TFT_Attach_Stream=function(AFace:PFT_Face; AParameters:PFT_Open_Args):TFT_ERROR; cdecl;
  TFT_Done_Face=function(AFace:PFT_Face):TFT_ERROR; cdecl;
  TFT_Set_Char_Size=function(AFace:PFT_Face; ACharWidth:TFT_F26Dot6; ACharHeight:TFT_F26Dot6; AHorzRes: TFT_UInt; AVertRes:TFT_UInt):TFT_ERROR; cdecl;
  TFT_Set_Pixel_Sizes=function(AFace:PFT_Face; APixelWidth, APixelHeight:TFT_UInt):TFT_ERROR; cdecl;
  TFT_Load_Glyph = function(AFace:PFT_Face; AGlyphIndex:TFT_UInt; ALoadFlags:TFT_Int32):TFT_ERROR; cdecl;
  TFT_Load_Char = function(AFace:PFT_Face; ACharCode:TFT_ULong; ALoadFlags:TFT_Int32):TFT_ERROR; cdecl;

const
  FT_LOAD_DEFAULT                      =$0;
  FT_LOAD_NO_SCALE                     =$1;
  FT_LOAD_NO_HINTING                   =$2;
  FT_LOAD_RENDER                       =$4;
  FT_LOAD_NO_BITMAP                    =$8;
  FT_LOAD_VERTICAL_LAYOUT              =$10;
  FT_LOAD_FORCE_AUTOHINT               =$20;
  FT_LOAD_CROP_BITMAP                  =$40;
  FT_LOAD_PEDANTIC                     =$80;
  FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH  =$200;
  FT_LOAD_NO_RECURSE                   =$400;
  FT_LOAD_IGNORE_TRANSFORM             =$800;
  FT_LOAD_MONOCHROME                   =$1000;
  FT_LOAD_LINEAR_DESIGN                =$2000;

  // temporary hack! //
  FT_LOAD_SBITS_ONLY                   =$4000;
  FT_LOAD_NO_AUTOHINT                  =$8000;

type
  TFT_Set_Transform = procedure(AFace:PFT_Face; AMatrix:PFT_Matrix; ADelta:PFT_Vector); cdecl;

{$IFDEF VCL6ORABOVE}
  TFT_Render_Mode = (FT_RENDER_MODE_NORMAL = 0,
    FT_RENDER_MODE_LIGHT,
    FT_RENDER_MODE_MONO,
    FT_RENDER_MODE_LCD,
    FT_RENDER_MODE_LCD_V,
    FT_RENDER_MODE_MAX);
{$ENDIF}

{$IFDEF DELPHI5}
  TFT_Render_Mode = (FT_RENDER_MODE_NORMAL,
    FT_RENDER_MODE_LIGHT,
    FT_RENDER_MODE_MONO,
    FT_RENDER_MODE_LCD,
    FT_RENDER_MODE_LCD_V,
    FT_RENDER_MODE_MAX);
{$ENDIF}

const
  FT_LOAD_TARGET_NORMAL:TFT_Int32 = ((Ord(FT_RENDER_MODE_NORMAL) and 15) shl 16);
  FT_LOAD_TARGET_LIGHT:TFT_Int32  = ((Ord(FT_RENDER_MODE_LIGHT) and 15) shl 16);
  FT_LOAD_TARGET_MONO:TFT_Int32   = ((Ord(FT_RENDER_MODE_MONO) and 15) shl 16);
  FT_LOAD_TARGET_LCD:TFT_Int32    = ((Ord(FT_RENDER_MODE_LCD) and 15) shl 16);
  FT_LOAD_TARGET_LCD_V:TFT_Int32  = ((Ord(FT_RENDER_MODE_LCD_V) and 16) shl 16);

type
  TFT_Render_Glyph = function(ASlot:PFT_GlyphSlot; ARenderMode:TFT_Render_Mode):TFT_ERROR; cdecl;

{$IFDEF VCL6ORABOVE}
  TFT_Kerning_Mode =(FT_KERNING_DEFAULT  = 0,
    FT_KERNING_UNFITTED,
    FT_KERNING_UNSCALED);
{$ENDIF}

{$IFDEF DELPHI5}
  TFT_Kerning_Mode = Integer;
  const
    FT_KERNING_DEFAULT  = 0;
    FT_KERNING_UNFITTED = 1;
    FT_KERNING_UNSCALED = 2;
{$ENDIF}

type
  TFT_Get_Kerning = function(AFace:PFT_Face; ALeftGlyph:TFT_UInt; ARightGlyph:TFT_UInt; AKernMode:TFT_UInt;
    var AKerning:TFT_Vector):TFT_Error; cdecl;
  TFT_Get_Glyph_Name = function(AFace:PFT_Face; AGlyphIndex: TFT_UInt; ABuffer:PFT_Pointer; ABufferMax:TFT_UInt):TFT_Error; cdecl;
  TFT_Get_Postscript_Name = function(AFace:PFT_Face):PAnsiChar; cdecl;
  TFT_Select_Charmap = function(AFace:PFT_Face; AEncoding:TFT_Encoding):TFT_ERROR; cdecl;
  TFT_Set_Charmap = function(AFace:PFT_Face; ACharMap:PFT_CharMap):TFT_ERROR; cdecl;
  TFT_Get_Char_Index=function(AFace:PFT_Face; ACharCode:TFT_ULong):TFT_UInt; cdecl;
  TFT_Get_First_Char = function(AFace:PFT_Face; var AGlyphIndex:TFT_UInt):TFT_ULong; cdecl;
  TFT_Get_Next_Char = function(AFace:PFT_Face; ACharCode:TFT_ULong; var AGlyphIndex:TFT_UInt):TFT_ULong; cdecl;
  TFT_Get_Name_Index = function(AFace:PFT_Face; AGlyphName:PFT_String):TFT_UInt; cdecl;

  // computations

  TFT_MulDiv = function(a,b,c:TFT_Long):TFT_Long; cdecl;
  TFT_MulFix = function(a,b:TFT_Long):TFT_Long; cdecl;
  TFT_DivFix = function(a,b:TFT_Long):TFT_Long; cdecl;
  TFT_RoundFix = function(a:TFT_Fixed):TFT_Fixed; cdecl;
  TFT_CeilFix = function(a:TFT_Fixed):TFT_Fixed; cdecl;
  TFT_FloorFix = function(a: TFT_Fixed):TFT_Fixed; cdecl;
  TFT_Vector_Transform = procedure(var AVector:TFT_Vector; AMatrix:PFT_Matrix); cdecl;


const
  FT_FACE_FLAG_SCALABLE                = 1 shl  0;
  FT_FACE_FLAG_FIXED_SIZES             = 1 shl  1;
  FT_FACE_FLAG_FIXED_WIDTH             = 1 shl  2;
  FT_FACE_FLAG_SFNT                    = 1 shl  3;
  FT_FACE_FLAG_HORIZONTAL              = 1 shl  4;
  FT_FACE_FLAG_VERTICAL                = 1 shl  5;
  FT_FACE_FLAG_KERNING                 = 1 shl  6;
  FT_FACE_FLAG_FAST_GLYPHS             = 1 shl  7;
  FT_FACE_FLAG_MULTIPLE_MASTERS        = 1 shl  8;
  FT_FACE_FLAG_GLYPH_NAMES             = 1 shl  9;
  FT_FACE_FLAG_EXTERNAL_STREAM         = 1 shl 10;

  FT_STYLE_FLAG_ITALIC                 = 1 shl 0;
  FT_STYLE_FLAG_BOLD                   = 1 shl 1;

function FT_HAS_HORIZONTAL(const AFace:PFT_Face):Boolean;
function FT_HAS_VERTICAL(const AFace:PFT_Face):Boolean;
function FT_HAS_KERNING(const AFace:PFT_Face):Boolean;
function FT_IS_SCALABLE(const AFace:PFT_Face):Boolean;
function FT_IS_SFNT(const AFace:PFT_Face):Boolean;
function FT_IS_FIXED_WIDTH(const AFace:PFT_Face):Boolean;
function FT_HAS_FIXED_SIZES(const AFace:PFT_Face):Boolean;
function FT_HAS_FAST_GLYPHS(const AFace:PFT_Face):Boolean;
function FT_HAS_GLYPH_NAMES(const AFace:PFT_Face):Boolean;
function FT_HAS_MULTIPLE_MASTERS(const AFace:PFT_Face):Boolean;


implementation


function FT_HAS_HORIZONTAL(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_HORIZONTAL)<>0;
end;

function FT_HAS_VERTICAL(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_VERTICAL)<>0;
end;

function FT_HAS_KERNING(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_KERNING)<>0;
end;

function FT_IS_SCALABLE(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_SCALABLE)<>0;
end;

function FT_IS_SFNT(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_SFNT)<>0;
end;

function FT_IS_FIXED_WIDTH(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_FIXED_WIDTH)<>0;
end;

function FT_HAS_FIXED_SIZES(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_FIXED_SIZES)<>0;
end;

function FT_HAS_FAST_GLYPHS(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_FAST_GLYPHS)<>0;
end;

function FT_HAS_GLYPH_NAMES(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_GLYPH_NAMES)<>0;
end;

function FT_HAS_MULTIPLE_MASTERS(const AFace:PFT_Face):Boolean;
begin
  result := (AFace.face_flags and FT_FACE_FLAG_MULTIPLE_MASTERS)<>0;
end;



end.
