{******************************************************************************}
{                                                       	               }
{ FreeType high-level API and common types interface Unit for Object Pascal    }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original Pascal code is FreeTypeImport.pas, released February 2004.      }
{ The initial developer of the Pascal code is                                  }
{ Soeren Muehlbauer (soeren.dd@gmx.de).                                        }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit FreeTypeImport;

{$I ..\..\Utils\gtCompilerDefines.inc}

interface

uses
  FreeType, ftTypes, ftImage, ftSystem, ftConfig, ftObjs, ftGlyph, ftTrigon, ftCalc, ftOutln, ftcache, ftcCache, ftLRU, ftMRU,
  ftcImage, ftcCMap, ftcGlyph, ftcSBits, ftList, ftSizes, ftModule, uObjDelphiImport;

{$IFOPT D+}
{$DEFINE DEBUG}
{$ELSE}
{$UNDEF DEBUG}
{$ENDIF}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FreeType.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function  FT_Init_FreeType(var ALibrary:PFT_Library):TFT_ERROR; cdecl; external;
  procedure FT_Library_Version(Alibrary:PFT_Library; var AMajor:TFT_Int; var AMinor:TFT_Int; var APatch:TFT_Int); cdecl; external;
  function  FT_Done_FreeType(ALibrary:PFT_Library):TFT_ERROR; cdecl; external;

  function FT_New_Face(Alibrary:PFT_Library; AFileName:PAnsiChar; AFaceIndex:TFT_Long; var AFace:PFT_Face):TFT_ERROR; cdecl; external;
  function FT_New_Memory_Face(ALibrary:PFT_Library; var AFileBase:PFT_Byte; AFileSize:TFT_Long; AFaceIndex:TFT_Long;
    var AFace:PFT_Face):TFT_Error; cdecl; external;
  function FT_Open_Face(ALibrary:PFT_Library; AArgs:PFT_Open_Args; AFaceIndex:TFT_Long;var AFace:PFT_Face):TFT_Error; cdecl; external;
  function FT_Attach_File(AFace:PFT_Face; AFilePathName:PAnsiChar):TFT_ERROR; cdecl;external;
  function FT_Attach_Stream(AFace:PFT_Face; AParameters:PFT_Open_Args):TFT_ERROR; cdecl; external;
  function FT_Done_Face(AFace:PFT_Face):TFT_ERROR; cdecl; external;
  function FT_Set_Char_Size(AFace:PFT_Face; ACharWidth:TFT_F26Dot6; ACharHeight:TFT_F26Dot6; AHorzRes: TFT_UInt; AVertRes:TFT_UInt):TFT_ERROR; cdecl; external;
  function FT_Set_Pixel_Sizes(AFace:PFT_Face; APixelWidth, APixelHeight:TFT_UInt):TFT_ERROR; cdecl; external;
  function FT_Load_Glyph(AFace:PFT_Face; AGlyphIndex:TFT_UInt; ALoadFlags:TFT_Int32):TFT_ERROR; cdecl; external;
  function FT_Load_Char(AFace:PFT_Face; ACharCode:TFT_ULong; ALoadFlags:TFT_Int32):TFT_ERROR; cdecl; external;

  procedure FT_Set_Transform(AFace:PFT_Face; AMatrix:PFT_Matrix; ADelta:PFT_Vector); cdecl; external;

  function FT_Render_Glyph(ASlot:PFT_GlyphSlot; ARenderMode:TFT_Render_Mode):TFT_ERROR; cdecl; external;

  function FT_Get_Kerning(AFace:PFT_Face; ALeftGlyph:TFT_UInt; ARightGlyph:TFT_UInt; AKernMode:TFT_UInt;
    var AKerning:TFT_Vector):TFT_Error; cdecl; external;
  function FT_Get_Glyph_Name(AFace:PFT_Face; AGlyphIndex: TFT_UInt; ABuffer:PFT_Pointer; ABufferMax:TFT_UInt):TFT_Error; cdecl; external;
  function FT_Get_Postscript_Name(AFace:PFT_Face):PAnsiChar; cdecl; external;
  function FT_Select_Charmap(AFace:PFT_Face; AEncoding:TFT_Encoding):TFT_ERROR; cdecl; external;
  function FT_Set_Charmap(AFace:PFT_Face; ACharMap:PFT_CharMap):TFT_ERROR; cdecl; external;
  function FT_Get_Char_Index(AFace:PFT_Face; ACharCode:TFT_ULong):TFT_UInt; cdecl; external;
  function FT_Get_First_Char(AFace:PFT_Face; var AGlyphIndex:TFT_UInt):TFT_ULong; cdecl; external;
  function FT_Get_Next_Char(AFace:PFT_Face; ACharCode:TFT_ULong; var AGlyphIndex:TFT_UInt):TFT_ULong; cdecl; external;
  function FT_Get_Name_Index(AFace:PFT_Face; AGlyphName:PFT_String):TFT_UInt; cdecl; external;
  function FT_Get_PS_Font_Info(AFace: PFT_Face; AFontInfoRec: PPS_FontInfoRec): TFT_ERROR; cdecl; external;
  function FT_Get_PS_Font_Private(AFace: PFT_Face; APSPrivateRec: PPS_PrivateRec): TFT_ERROR; cdecl; external;


  // computations

  function  FT_MulDiv(a,b,c:TFT_Long):TFT_Long; cdecl; external;
  function  FT_MulFix(a,b:TFT_Long):TFT_Long; cdecl; external;
  function  FT_DivFix(a,b:TFT_Long):TFT_Long; cdecl; external;
  function  FT_RoundFix(a:TFT_Fixed):TFT_Fixed; cdecl; external;
  function  FT_CeilFix(a:TFT_Fixed):TFT_Fixed; cdecl; external;
  function  FT_FloorFix(a: TFT_Fixed):TFT_Fixed; cdecl; external;
  procedure FT_Vector_Transform(var AVector:TFT_Vector; AMatrix:PFT_Matrix); cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftGlyph.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function  FT_Get_Glyph(ASlot:PFT_GlyphSlot;var AGlyph: PFT_Glyph):TFT_ERROR; cdecl; external;
  function  FT_Glyph_Copy(ASource:PFT_Glyph; var ATarget:PFT_Glyph):TFT_ERROR; cdecl; external;
  function  FT_Glyph_Transform(AGlyph:PFT_Glyph; AMatrix: PFT_Matrix; ADelta:PFT_Vector):TFT_ERROR; cdecl; external;

  procedure FT_Glyph_Get_CBox(AGlyph:PFT_Glyph; ABBoxMode:TFT_UInt; var ACBox:TFT_BBox); cdecl; external;
  function  FT_Glyph_To_Bitmap(var AGlyph:PFT_Glyph; ARenderMode:TFT_Render_Mode; var AOrigin:TFT_Vector; ADestroy:TFT_Bool):TFT_ERROR; cdecl; external;

  procedure FT_Done_Glyph(AGlyph:PFT_Glyph); cdecl; external;

  procedure FT_Matrix_Multiply(AMatrix1,AMatrix2: PFT_Matrix); cdecl; external;
  function FT_Matrix_Invert(AMatrix:PFT_Matrix):TFT_ERROR; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftTrigon.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function FT_Sin(AAngle:TFT_Angle):TFT_Fixed; cdecl; external;
  function FT_Cos(AAngle:TFT_Angle):TFT_Fixed; cdecl; external;
  function FT_Tan(AAngle:TFT_Angle):TFT_Fixed; cdecl; external;
  function FT_ATan2(x,y:TFT_Fixed):TFT_Angle; cdecl; external;
  function FT_Angle_Diff(AAngle1, AAngle2:TFT_Angle):TFT_Angle; cdecl; external;
  procedure FT_Vector_Unit(var AVector:TFT_Vector; AAngle:TFT_Angle); cdecl; external;
  procedure FT_Vector_Rotate(var AVector:TFT_Vector; AAngle:TFT_Angle); cdecl; external;
  function FT_Vector_Length(var AVector:TFT_Vector):TFT_Fixed; cdecl; external;
  procedure FT_Vector_Polarize(var AVector:TFT_Vector; var ALength:TFT_Fixed; var AAngle:TFT_Angle); cdecl; external;
  procedure FT_Vector_From_Polar(var AVector:TFT_Vector; ALength:TFT_Fixed; AAngle:TFT_Angle); cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftCalc.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function FT_SqrtFixed(x:TFT_Int32):TFT_Int32; cdecl; external;
//  function FT_Sqrt32(x:TFT_Int32):TFT_Int32; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftOutln.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function FT_Outline_Decompose(var AOutline:TFT_Outline; AFuncInterface:PFT_Outline_Funcs; AUser:Pointer):TFT_ERROR; cdecl; external;
  function FT_Outline_New(ALibrary:PFT_Library; ANumPoints:TFT_UInt; ANumContours:TFT_Int; var AOutLine:TFT_Outline):TFT_ERROR; cdecl; external;
  function FT_Outline_New_Internal(AMemory:PFT_Memory; ANumPoints:TFT_UInt; ANumContours:TFT_Int; var AOutLine:TFT_Outline):TFT_ERROR; cdecl; external;
  function FT_Outline_Done(ALibrary:PFT_Library; var AOutline:TFT_Outline):TFT_ERROR; cdecl; external;
  function FT_Outline_Done_Internal(AMemory:PFT_Memory; var AOutline:TFT_Outline):TFT_ERROR; cdecl; external;
  function FT_Outline_Check(var AOutline:TFT_Outline):TFT_ERROR; cdecl; external;
  procedure FT_Outline_Get_CBox(var AOutline:TFT_Outline; var ACBox:TFT_BBox); cdecl; external;
  procedure FT_Outline_Translate(var AOutline:TFT_Outline; AXOffset, AYOffset: TFT_Pos); cdecl; external;
  function FT_Outline_Copy(var ASourceOutline:TFT_Outline; var ATargetOutline:TFT_Outline):TFT_ERROR; cdecl; external;
  procedure FT_Outline_Transform(var AOutline:TFT_Outline; var AMatrix:TFT_Matrix); cdecl; external;
  procedure FT_Outline_Reverse(var AOutline:TFT_Outline); cdecl; external;
  function FT_Outline_Get_Bitmap(ALibrary:PFT_Library; var AOutline:TFT_Outline; var ABitmap:TFT_BITMAP):TFT_ERROR; cdecl; external;
  function FT_Outline_Render(ALibrary:PFT_Library; var AOutline:TFT_Outline; AParams:PFT_Raster_Params):TFT_ERROR; cdecl; external;
  function FT_Outline_Get_Orientation(var outline: TFT_Outline): TFT_Orientation; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftCache.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function FTC_Manager_New(ALibrary:PFT_Library; AMaxFaces:TFT_UInt; AMaxSizes:TFT_UInt; AMaxBytes:TFT_ULong; ARequester:TFTC_Face_Requester;
    AReqData:PFT_Pointer; var AManager:PFTC_Manager):TFT_ERROR; cdecl; external;
  procedure FTC_Manager_Reset(AManager:PFTC_Manager); cdecl; external;
  procedure FTC_Manager_Done(AManager:PFTC_Manager); cdecl; external;
  function FTC_Manager_LookupFace(AManager:PFTC_Manager; AFaceID:PFTC_FaceID; var AFace:PFT_Face):TFT_ERROR; cdecl; external;
  function FTC_Manager_LookupSize(AManager:PFTC_Manager; AScaler: PFTC_Scaler; var ASize: PFT_Size):TFT_ERROR; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftcCache.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//  function  ftc_family_table_alloc(ATable:PFTC_FamilyTable; AMemory:PFT_Memory; var AEntry:PFTC_FamilyEntry):TFT_ERROR; cdecl; external;
//  procedure ftc_family_table_free(ATable:PFTC_FamilyTable; AIdx: TFT_UInt); cdecl; external;
//
  procedure FTC_Manager_Compress(AManager:PFTC_Manager); cdecl; external;
  function  FTC_Manager_RegisterCache(AManager: PFTC_Manager; AClass:PFTC_Cache_Class; var ACache:PFTC_Cache):TFT_ERROR; cdecl; external;
//  procedure FTC_Node_Ref(ANode:PFTC_Node; AManager:PFTC_Manager); cdecl; external;
  procedure FTC_Node_Unref(ANode:PFTC_Node; AManager:PFTC_Manager); cdecl; external;
//
//  procedure ftc_node_done(ANode:PFTC_Node; ACache: PFTC_Cache); cdecl; external;
  procedure ftc_node_destroy(ANode:PFTC_Node; AManager: PFTC_Manager); cdecl; external;
//
  function  ftc_family_init(AFamily: PFTC_Family; AQuery:PFTC_Query; ACache:PFTC_Cache):TFT_ERROR; cdecl; external;
//  procedure ftc_family_done(AFamily: PFTC_Family); cdecl; external;

  procedure ftc_cache_done(ACache: PFTC_Cache); cdecl; external;
//  procedure ftc_cache_clear(ACache: PFTC_Cache); cdecl; external;
  function  FTC_Cache_Init(ACache: PFTC_Cache):TFT_ERROR; cdecl; external;
//  function  FTC_Cache_Lookup(ACache: PFTC_Cache; AQuery:PFTC_Query; var ANode:PFTC_Node):TFT_ERROR; cdecl; external;
  procedure FTC_Cache_RemoveFaceID(cache: PFTC_Cache; face_id: PFTC_FaceID); cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftLRU.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//  function FT_LruList_New(AClass:PFT_LruList_Class; AMaxElements:TFT_UInt; AUserData:PFT_Pointer; AMemory:PFT_Memory; var AList:PFT_LruList):TFT_ERROR; cdecl; external;
//  procedure FT_LruList_Reset(AList:PFT_LruList); cdecl; external;
//  procedure FT_LruList_Destroy(AList:PFT_LruList); cdecl; external;
//  function FT_LruList_Lookup(AList:PFT_LruList; AKey:PFT_LruKey; var ANode:PFT_LruNode):TFT_ERROR; cdecl; external;
//  procedure FT_LruList_Remove(AList:PFT_LruList; ANode:PFT_LruNode); cdecl; external;
//  procedure FT_LruList_Remove_Selection(AList:PFT_LruList; ASelectFunc:TFT_LruNode_SelectFunc; ASelectData:PFT_Pointer); cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftcImage.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function FTC_ImageCache_New(AManager:PFTC_Manager; var ACache:PFTC_ImageCache):TFT_ERROR; cdecl; external;
  function FTC_ImageCache_Lookup(ACache:PFTC_ImageCache; AImageType:PFTC_ImageType; AGlyphIndex: TFT_UInt; var AGlyph:PFT_Glyph; var ANode:PFTC_Node):TFT_ERROR; cdecl; external;

//  function FTC_Image_Cache_New(AManager:PFTC_Manager; var ACache:PFTC_Image_Cache):TFT_ERROR; cdecl; external;
//  function FTC_Image_Cache_Lookup(ACache: PFTC_Image_Cache; var ADesc:PFTC_Image_Desc; AGlyphIndex:TFT_UInt; var AGlyph:PFT_Glyph):TFT_ERROR; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftObjs.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function  FT_New_Memory():PFT_Memory; cdecl; external;
  procedure FT_Done_Memory(AMemory:PFT_Memory); cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftcCMap.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function FTC_CMapCache_New(AManager: PFTC_Manager; var ACache:PFTC_CMapCache):TFT_ERROR; cdecl; external;
  function FTC_CMapCache_Lookup(ACache:PFTC_CMapCache; ACMapDesc:PFTC_CMapDesc; ACharCode:TFT_UInt32):TFT_UInt; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftcSBits.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function FTC_SBitCache_New(AManager:PFTC_Manager; var ACache:PFTC_SBitCache):TFT_ERROR; cdecl; external;
  function FTC_SBitCache_Lookup(ACache:PFTC_SBitCache; AType:PFTC_ImageType; AGlyphIndex:TFT_UInt; var ASBit: PFTC_SBit; var ANode:PFTC_Node):TFT_ERROR; cdecl; external;

//  function FTC_SBit_Cache_New(AManager:PFTC_Manager; var ACache:PFTC_SBit_Cache):TFT_ERROR; cdecl; external;
//  function FTC_SBit_Cache_Lookup(ACache:PFTC_SBit_Cache; var ADesc:PFTC_Image_Desc; AGlyphIndex:TFT_UInt; var ASBit:PFTC_SBit):TFT_ERROR; cdecl; external;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// ftList.pas
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  function  FT_List_Find(AList:PFT_List; AData:Pointer):PFT_ListNode; cdecl; external;
//  procedure FT_List_Add(AList:PFT_List; ANode: PFT_ListNode); cdecl; external;
//  procedure FT_List_Insert(AList:PFT_List; ANode: PFT_ListNode); cdecl; external;
//  procedure FT_List_Remove(AList:PFT_List; ANode: PFT_ListNode); cdecl; external;
//  procedure FT_List_Up(AList:PFT_List; ANode: PFT_ListNode); cdecl; external;
//
//  function FT_List_Iterate(AList:PFT_List; AIterator:TFT_List_Iterator; AUser:Pointer):TFT_ERROR; cdecl; external;
//
//  procedure FT_List_Finalize(AList:PFT_List; ADestroy: TFT_List_Destructor; AMemory: PFT_Memory; AUser:Pointer); cdecl; external;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// ftSizes.pas
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
  function FT_New_Size(AFace:PFT_Face; var ASize:PFT_Size):TFT_ERROR; cdecl; external;
  function FT_Done_Size(ASize:PFT_Size):TFT_ERROR; cdecl; external;
  function FT_Activate_Size(ASize:PFT_Size):TFT_ERROR; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftModule.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//  function FT_Add_Module(ALibrary:PFT_Library; AClazz:PFT_Module_Class):TFT_ERROR; cdecl; external;
//  function FT_Get_Module(ALibrary:PFT_Library; AModuleName:PAnsiChar):PFT_Module; cdecl; external;
//  function FT_Remove_Module(ALibrary:PFT_Library; AModule:PFT_Module):TFT_ERROR; cdecl; external;
//
//  function FT_New_Library(AMemory:PFT_Memory; var ALibrary:PFT_Library):TFT_ERROR; cdecl; external;
//  function FT_Done_Library(ALibrary:PFT_Library):TFT_ERROR; cdecl; external;
//
//  procedure FT_Set_Debug_Hook(ALibrary: PFT_Library; AHookIndex:TFT_UInt; ADebugHook:TFT_Debug_Hook_Func); cdecl; external;
//
//  procedure FT_Add_Default_Modules(ALibrary: PFT_Library); cdecl; external;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// ftMRU.pas
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
  procedure FTC_MruNode_Prepend(var plist: PFTC_MruNode; node: PFTC_MruNode); cdecl; external;
  procedure FTC_MruNode_Up(var plist: PFTC_MruNode; node: PFTC_MruNode); cdecl; external;
  procedure FTC_MruNode_Remove(var plist: PFTC_MruNode; node: PFTC_MruNode); cdecl; external;
  procedure FTC_MruList_Init(list: PFTC_MruList; clazz: PFTC_MruListClass; max_nodes: TFT_UInt; data: PFT_Pointer; memory: PFT_Memory); cdecl; external;
  procedure FTC_MruList_Reset(list: PFTC_MruList); cdecl; external;
  procedure FTC_MruList_Done(list: PFTC_MruList); cdecl; external;
//  function  FTC_MruList_Find(list: PFTC_MruList; key: PFT_Pointer): PFTC_MruNode; cdecl; external;
  function  FTC_MruList_New(list: PFTC_MruList; key: PFT_Pointer; var anode: PFTC_MruNode): TFT_Error; cdecl; external;
//  function  FTC_MruList_Lookup(list: PFTC_MruList; key: PFT_Pointer; var pnode: PFTC_MruNode): TFT_Error; cdecl; external;
  procedure FTC_MruList_Remove(list: PFTC_MruList; node: PFTC_MruNode); cdecl; external;
  procedure FTC_MruList_RemoveSelection(list: PFTC_MruList; selection: TFTC_MruNode_CompareFunc; key: PFT_Pointer); cdecl; external;


implementation

{$L '..\Obj\Release\ftInit.obj'}
{$L '..\Obj\Release\ftObjs.obj'}
{$L '..\Obj\Release\ftcalc.obj'}
{$L '..\Obj\Release\ftoutln.obj'}
{$L '..\Obj\Release\ftglyph.obj'}
{$L '..\Obj\Release\fttrigon.obj'}
{$L '..\Obj\Release\ftCache.obj'}
{$L '..\Obj\Release\ftcimage.obj'}
{$L '..\Obj\Release\ftcsbits.obj'}
{$L '..\Obj\Release\ftsystem.obj'}
{$L '..\Obj\Release\ftutil.obj'}
{$L '..\Obj\Release\ftstream.obj'}
{$L '..\Obj\Release\ftgloadr.obj'}
{$L '..\Obj\Release\ftrfork.obj'}
{$L '..\Obj\Release\ftgzip.obj'}
{$L '..\Obj\Release\ftlzw.obj'}
{$L '..\Obj\Release\ftbitmap.obj'}
{$L '..\Obj\Release\ftcmru.obj'}
{$L '..\Obj\Release\ftccache.obj'}
{$L '..\Obj\Release\fttype1.obj'}

{$L '..\Obj\Release\pfr.obj'}
procedure pfr_driver_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\autofit.obj'}
procedure autofit_module_class; external;       // Not really a procedure but a structure.

{$L '..\Obj\Release\bdf.obj'}
procedure bdf_driver_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\truetype.obj'}
procedure tt_driver_class; external;            // Not really a procedure but a structure.

{$L '..\Obj\Release\type1.obj'}
procedure t1_driver_class; external;            // Not really a procedure but a structure.

{$L '..\Obj\Release\cff.obj'}
procedure cff_driver_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\type1cid.obj'}
procedure t1cid_driver_class; external;         // Not really a procedure but a structure.

{$L '..\Obj\Release\type42.obj'}
procedure t42_driver_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\winfnt.obj'}
procedure winfnt_driver_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\pcf.obj'}
procedure pcf_driver_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\raster.obj'}
procedure ft_raster1_renderer_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\psaux.obj'}
procedure psaux_module_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\psmodule.obj'}
procedure psnames_module_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\pshinter.obj'}
procedure pshinter_module_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\sfnt.obj'}
procedure sfnt_module_class; external;           // Not really a procedure but a structure.

{$L '..\Obj\Release\smooth.obj'}
procedure ft_smooth_renderer_class; external;           // Not really a procedure but a structure.
procedure ft_smooth_lcd_renderer_class; external;           // Not really a procedure but a structure.
procedure ft_smooth_lcdv_renderer_class; external;           // Not really a procedure but a structure.

//{$L 'G:\PDF Processor\Source\freetype2\objs\release\ftutil.obj'}
{$L '..\Obj\Release\ftcglyph.obj'}
{$L '..\Obj\Release\ftcmanag.obj'}
{$L '..\Obj\Release\ftutil.obj'}
{$L '..\Obj\Release\ftObjs.obj'}
{$L '..\Obj\Release\ftcalc.obj'}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// internal functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftStream.c
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

type
  PFT_Frame_Field = ^TFT_Frame_Field;
  TFT_Frame_Field = record
    value: TFT_Byte;
    size: TFT_Byte;
    offset: TFT_UShort;
  end;

function  FT_Stream_New(lib: PFT_Library; args: PFT_Open_Args; var aStream: PFT_Stream): TFT_ERROR; cdecl; external;
procedure FT_Stream_Free(Stream: PFT_Stream; ext: TFT_Int); cdecl; external;  

procedure FT_Stream_OpenMemory(Stream: PFT_Stream; base: PFT_Byte; size: TFT_ULong); cdecl; external;

procedure FT_Stream_Close(Stream: PFT_Stream); cdecl; external;
function  FT_Stream_Seek(Stream: PFT_Stream; pos: TFT_ULong): TFT_ERROR; cdecl; external;

function  FT_Stream_Skip(Stream: PFT_Stream; distance: TFT_Long): TFT_ERROR; cdecl; external;
function  FT_Stream_Pos(Stream: PFT_Stream): TFT_Long; cdecl; external;

function  FT_Stream_Read(Stream: PFT_Stream; Buffer: PFT_Byte; Count: TFT_ULong): TFT_ERROR; cdecl; external;
function  FT_Stream_ReadAt(Stream: PFT_Stream; Pos: TFT_ULong; Buffer: PFT_Byte; Count: TFT_ULong): TFT_ERROR; cdecl; external;
function  FT_Stream_TryRead(Stream: PFT_Stream; Buffer: PFT_Byte; Count: TFT_ULong): TFT_ULong; cdecl; external;

function  FT_Stream_EnterFrame(Stream: PFT_Stream; count: TFT_ULong): TFT_ERROR; cdecl; external;
procedure FT_Stream_ExitFrame(Stream: PFT_Stream); cdecl; external;

function  FT_Stream_ExtractFrame(Stream: PFT_Stream; Count: TFT_ULong; pBytes: PPFT_Byte): TFT_ERROR; cdecl; external;
procedure FT_Stream_ReleaseFrame(Stream: PFT_Stream; pbytes: PPFT_Byte); cdecl; external;

function  FT_Stream_GetChar(Stream: PFT_Stream): TFT_Char; cdecl; external;
function  FT_Stream_GetShort(Stream: PFT_Stream): TFT_Short; cdecl; external;
function  FT_Stream_GetOffset(Stream: PFT_Stream): TFT_Long; cdecl; external;
function  FT_Stream_GetLong(Stream: PFT_Stream): TFT_Long; cdecl; external;
function  FT_Stream_GetShortLE(Stream: PFT_Stream): TFT_Short; cdecl; external;
function  FT_Stream_GetLongLE(Stream: PFT_Stream): TFT_Long; cdecl; external;

function  FT_Stream_ReadChar(Stream: PFT_Stream; var error: TFT_ERROR): TFT_Char; cdecl; external;
function  FT_Stream_ReadShort(Stream: PFT_Stream; var error: TFT_ERROR): TFT_Short; cdecl; external;
function  FT_Stream_ReadOffset(Stream: PFT_Stream; var error: TFT_ERROR): TFT_Long; cdecl; external;
function  FT_Stream_ReadLong(Stream: PFT_Stream; var error: TFT_ERROR): TFT_Long; cdecl; external;
function  FT_Stream_ReadShortLE(Stream: PFT_Stream; var error: TFT_ERROR): TFT_Short; cdecl; external;
function  FT_Stream_ReadLongLE(Stream: PFT_Stream; var error: TFT_ERROR): TFT_Long; cdecl; external;

function  FT_Stream_ReadFields(Stream: PFT_Stream; Fields: PFT_Frame_Field; Structure: Pointer): TFT_ERROR; cdecl; external;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftGloadr.c
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const
  FT_SUBGLYPH_FLAG_ARGS_ARE_WORDS          = 1;
  FT_SUBGLYPH_FLAG_ARGS_ARE_XY_VALUES      = 2;
  FT_SUBGLYPH_FLAG_ROUND_XY_TO_GRID        = 4;
  FT_SUBGLYPH_FLAG_SCALE                   = 8;
  FT_SUBGLYPH_FLAG_XY_SCALE                = $40;
  FT_SUBGLYPH_FLAG_2X2                     = $80;
  FT_SUBGLYPH_FLAG_USE_MY_METRICS          = $200;

type
  PFT_GlyphLoader = ^TFT_GlyphLoaderRec;

  PFT_GlyphLoad = ^TFT_GlyphLoadRec;
  TFT_GlyphLoadRec_ = record
    outline: TFT_Outline;       // outline
    extra_points: PFT_Vector;   // extra points table
    num_subglyphs: TFT_UInt;    // number of subglyphs
    subglyphs: TFT_SubGlyph;    // subglyphs
  end;
  TFT_GlyphLoadRec = TFT_GlyphLoadRec_;


  TFT_GlyphLoaderRec_ = record
    memory: PFT_Memory;
    max_points: TFT_UInt;
    max_contours: TFT_UInt;
    max_subglyphs: TFT_UInt;
    use_extra: TFT_Bool;

    base: TFT_GlyphLoadRec;
    current: TFT_GlyphLoadRec;

    other: Pointer;
  end;
  TFT_GlyphLoaderRec = TFT_GlyphLoaderRec_;


function FT_GlyphLoader_New(memory: PFT_Memory; aloader: PFT_GlyphLoader): TFT_ERROR; cdecl; external;
function FT_GlyphLoader_CreateExtra(loader: PFT_GlyphLoader): TFT_Error; cdecl; external;
procedure FT_GlyphLoader_Done(loader: PFT_GlyphLoader); cdecl; external;
procedure FT_GlyphLoader_Reset(loader: PFT_GlyphLoader); cdecl; external;
procedure FT_GlyphLoader_Rewind(loader: PFT_GlyphLoader); cdecl; external;
function  FT_GlyphLoader_CheckPoints(loader:  PFT_GlyphLoader;
                                     n_points: TFT_UInt;
                                     n_contours: TFT_UInt): TFT_Error; cdecl; external;
function  FT_GlyphLoader_CheckSubGlyphs(loader: PFT_GlyphLoader; n_subs: TFT_UInt): TFT_Error; cdecl; external;
procedure FT_GlyphLoader_Prepare(loader: PFT_GlyphLoader); cdecl; external;
procedure FT_GlyphLoader_Add(loader: PFT_GlyphLoader); cdecl; external;
function  FT_GlyphLoader_CopyPoints(target, source: PFT_GlyphLoader): TFT_Error; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftrfork.c
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function FT_Raccess_Get_HeaderInfo(lib: PFT_Library; stream: PFT_Stream;
                                   rfork_offset: TFT_Long;
                                   var map_offset: TFT_Long;
                                   var rdata_pos: TFT_Long): TFT_ERROR; cdecl; external;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftObjs.pas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function FT_Lookup_Renderer(lib: PFT_Library; Format: TFT_Glyph_Format; var Node: PFT_ListNode): PFT_Renderer; cdecl; external;
function FT_Set_Renderer(lib: PFT_Library; Renderer: PFT_Renderer; num_params: TFT_UInt; var Parameters: PFT_Parameter): TFT_Error; cdecl; external;
function FT_Render_Glyph_Internal(lib: PFT_Library; Slot: PFT_GlyphSlot; render_mode: TFT_Render_Mode): TFT_ERROR; cdecl; external;

function FT_New_GlyphSlot(face: PFT_Face; var aslot: PFT_GlyphSlot): TFT_ERROR; cdecl; external;
procedure FT_Done_GlyphSlot(slot: PFT_GlyphSlot); cdecl; external;

procedure ft_glyphslot_free_bitmap(slot: PFT_GlyphSlot); cdecl; external;
procedure ft_glyphslot_set_bitmap(slot: PFT_GlyphSlot; buffer: PFT_Byte); cdecl; external;
function  ft_glyphslot_alloc_bitmap(slot: PFT_GlyphSlot; size: TFT_ULong): TFT_ERROR; cdecl; external;

procedure FT_Get_Module_Interface(lib: PFT_Library; mod_name: PAnsiChar); cdecl; external;
function  ft_module_get_service(module: PFT_Module; service_id: PAnsiChar): PFT_Pointer; cdecl; external;

function  FT_CMap_New(clazz: Pointer; init_data: PFT_Pointer; charmap: PFT_CharMap; var acmap: Pointer): TFT_ERROR; cdecl; external;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftvalid.h
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

type

{$IFDEF VCL6ORABOVE}
  TFT_ValidationLevel = (
    FT_VALIDATE_DEFAULT = 0,
    FT_VALIDATE_TIGHT,
    FT_VALIDATE_PARANOID
  );
{$ENDIF}

{$IFDEF DELPHI5}
  TFT_ValidationLevel = Integer;
  const
    FT_VALIDATE_DEFAULT = 0;
    FT_VALIDATE_TIGHT = 1;
    FT_VALIDATE_PARANOID = 2;
{$ENDIF}

type
  PFT_Validator = ^TFT_ValidatorRec;

  TFT_ValidatorRec = record
    base: PFT_Byte;
    limit: PFT_Byte;
    level: TFT_ValidationLevel;
    jump_buffer: TJMP_buf;
  end;

procedure ft_validator_init(valid: PFT_Validator; var base: PFT_Byte; var limit: PFT_Byte; level: TFT_ValidationLevel); cdecl; external;
function  ft_validator_run(valid: PFT_Validator): TFT_Int; cdecl; external;
procedure ft_validator_error(valid: PFT_Validator; error: TFT_ERROR); cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftgzip.h
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function FT_Stream_OpenGzip(Stream: PFT_Stream; Source: PFT_Stream): TFT_ERROR; cdecl; external;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftlzw.h
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function FT_Stream_OpenLZW(Stream: PFT_Stream; Source: PFT_Stream): TFT_ERROR; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftserv.h
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
type
  TFT_ServiceDescRec = record
    serv_id: PAnsiChar;
    serv_data: Pointer;
  end;

  PFT_ServiceDesc = ^TFT_ServiceDescRec;

function ft_service_list_lookup(service_descriptors: PFT_ServiceDesc; service_id: PAnsiChar): PFT_Pointer; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftcglyph.h
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  procedure FTC_GNode_Init(node: PFTC_GNode; gindex: TFT_UInt; family: PFTC_Family); cdecl; external;
  function FTC_GNode_Compare(gnode: PFTC_GNode; gquery: PFTC_GQuery): TFT_Bool; cdecl; external;
  procedure FTC_GNode_UnselectFamily(gnode: PFTC_GNode; cache: PFTC_Cache); cdecl; external;
  procedure FTC_GNode_Done(node: PFTC_GNode; cache: PFTC_Cache); cdecl; external;
//  procedure FTC_Family_Init(family: PFTC_Family; cache: PFTC_Cache); cdecl; external;

  function FTC_GCache_Init(cache: PFTC_GCache): TFT_Error; cdecl; external;
  procedure FTC_GCache_Done(cache: PFTC_GCache); cdecl; external;

  function FTC_GCache_New(manager:  PFTC_Manager; clazz: PFTC_GCacheClass; var acache: PFTC_GCache): TFT_Error; cdecl; external;
//  function FTC_GCache_Lookup(cache:  PFTC_GCache; hash: TFT_UInt32; gindex: TFT_UInt; query: PFTC_GQuery; var anode: PFTC_Node): TFT_Error; cdecl; external;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ftmemory.h
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  function FT_QAlloc(memory: PFT_Memory; size: TFT_Long; var P: Pointer): TFT_Error; cdecl; external;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// tttables.h
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  function FT_Load_Sfnt_Table(face: PFT_Face; tag: TFT_ULong; offset: TFT_Long; buffer: PFT_Byte; var length: TFT_ULong): TFT_Error; cdecl; external;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Validate
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//procedure otv_BASE_validate(table: PFT_Byte; ftvalid: PFT_Validator); cdecl; external;
//procedure otv_GPOS_validate(table: PFT_Byte; glyph_count: TFT_UInt; ftvalid: PFT_Validator); cdecl; external;
//procedure otv_GPOS_subtable_validate(table: PFT_Byte; valid: PFT_Validator); cdecl; external;
//
//procedure otv_GSUB_validate(table: PFT_Byte; glyph_count: TFT_UInt; ftvalid: PFT_Validator); cdecl; external;
//procedure otv_GDEF_validate(table: PFT_Byte; gsub: PFT_Byte; gpos: PFT_Byte; ftvalid: PFT_Validator); cdecl; external;
//procedure otv_JSTF_validate(table: PFT_Byte; gsub: PFT_Byte; gpos: PFT_Byte; glyph_count: TFT_UInt; ftValid: PFT_Validator); cdecl; external;

initialization

finalization

end.
