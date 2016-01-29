{******************************************************************************}
{                                                       	               }
{ FreeType Simple LRU list-cache interface Unit for Object Pascal              }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftcGlpyh.h. The original Pascal code is                }
{ ftcGlpyh.pas, released February 2004. The initial developer of the           }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftcGlyph;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftTypes, ftConfig, ftSystem, ftMRU, ftcCache;

type
  PFTC_Family = ^TFTC_FamilyRec;
  TFTC_FamilyRec = record
    mrunode: PFTC_MruNode;
    num_nodes: TFT_UInt;
    cache: PFTC_Cache;
    clazz: PFTC_MruListClass;  
  end;

  PFTC_GNode = ^TFTC_GNodeRec;
  TFTC_GNodeRec = record
    node: TFTC_NodeRec;
    family: PFTC_Family;
    gindex: TFT_UInt;
  end;

  PFTC_GQuery = ^TFTC_GQueryRec;
  TFTC_GQueryRec = record
    gindex: TFT_UInt;
    family: PFTC_Family;
  end;

  TFTC_GNode_Init = procedure(node: PFTC_GNode; gindex: TFT_UInt; family: PFTC_Family); cdecl;
  TFTC_GNode_Compare = function(gnode: PFTC_GNode; gquery: PFTC_GQuery): TFT_Bool; cdecl;
  TFTC_GNode_UnselectFamily = procedure(gnode: PFTC_GNode; cache: PFTC_Cache); cdecl;
  TFTC_GNode_Done = procedure(node: PFTC_GNode; cache: PFTC_Cache); cdecl;
  TFTC_Family_Init = procedure(family: PFTC_Family; cache: PFTC_Cache); cdecl;

  PFTC_GCache = ^TFTC_GCacheRec;
  TFTC_GCacheRec = record
    cache: TFTC_CacheRec;
    families: TFTC_MruListRec;
  end;


  TFTC_GCache_Init = function(cache: PFTC_GCache): TFT_Error; cdecl;
  TFTC_GCache_Done = procedure(cache: PFTC_GCache); cdecl;

  TFTC_GCacheClassRec = record
    clazz: TFTC_Cache_ClassRec;
    family_class: PFTC_MruListClass;
  end;
  PFTC_GCacheClass = ^TFTC_GCacheClassRec;

  TFTC_GCache_New = function(manager:  PFTC_Manager; clazz: PFTC_GCacheClass; var acache: PFTC_GCache): TFT_Error; cdecl;
  TFTC_GCache_Lookup = function(cache:  PFTC_GCache; hash: TFT_UInt32; gindex: TFT_UInt; query: PFTC_GQuery; var anode: PFTC_Node): TFT_Error; cdecl;


implementation

end.
 