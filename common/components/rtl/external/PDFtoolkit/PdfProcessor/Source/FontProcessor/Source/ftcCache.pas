{******************************************************************************}
{                                                       	               }
{ FreeType internal cache interface interface Unit for Object Pascal           }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 2000-2001, 2002 by                                                 }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftcCache.h. The original Pascal code is                }
{ ftcCache.pas, released February 2004. The initial developer of the           }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{                                                       	               }
{******************************************************************************}
unit ftcCache;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  FreeType, ftSystem, ftcManag, ftTypes, ftConfig, ftLRU;

type
  PFTC_FaceID=PFT_Pointer;

  TFTC_Face_RequesterInt = ^TFTC_Face_Requester_;
  TFTC_Face_Requester_ = function(AFaceID:PFTC_FaceID; ALibrary:PFT_Library; ARequestData:PFT_Pointer; var AFace:PFT_Face):TFT_ERROR; cdecl;

  PFTC_Cache = ^TFTC_CacheRec;

  PFTC_Cache_Class = ^TFTC_Cache_ClassRec;

  PFTC_Family = ^TFTC_FamilyRec;

  PFTC_Query = ^TFTC_QueryRec;

  PPFTC_NodeInt = ^PFTC_NodeInt;
  PFTC_Node = ^TFTC_NodeRec;
  PFTC_NodeInt = ^TFTC_NodeRec;

  PFTC_FamilyEntry = ^TFTC_FamilyEntryRec;
  TFTC_FamilyEntryRec = record
    family:PFTC_Family;
    cache:PFTC_Cache;
    index:TFT_UInt;
    link:TFT_UInt;
  end;

  PFTC_FamilyTable = ^TFTC_FamilyTableRec;
  TFTC_FamilyTableRec = record
    count:TFT_UInt;
    size:TFT_UInt;
    entries:PFTC_FamilyEntry;
    free:TFT_UInt;
  end;

  PFTC_Manager = ^TFTC_ManagerRec;
  TFTC_ManagerRec = record
    FTlibrary:PFT_Library;
    faces_list:PFT_LruList;
    sizes_list:PFT_LruList;

    max_weight:TFT_ULong;
    cur_weight:TFT_ULong;

    num_nodes:TFT_UInt;
    nodes_list: PFTC_NodeInt;

    caches:array[0..FTC_MAX_CACHES-1] of PFTC_Cache;

    request_data:PFT_Pointer;
    request_face:TFTC_Face_RequesterInt;

    families:TFTC_FamilyTableRec;
  end;

  Tftc_family_table_alloc = function(ATable:PFTC_FamilyTable; AMemory:PFT_Memory; var AEntry:PFTC_FamilyEntry):TFT_ERROR; cdecl;
  Tftc_family_table_free = procedure(ATable:PFTC_FamilyTable; AIdx: TFT_UInt); cdecl;

  TFTC_Manager_Compress = procedure(AManager:PFTC_Manager); cdecl;
  TFTC_Manager_Register_Cache = function(AManager: PFTC_Manager; AClass:PFTC_Cache_Class; var ACache:PFTC_Cache):TFT_ERROR; cdecl;
  TFTC_Node_Ref = procedure(ANode:PFTC_NodeInt; AManager:PFTC_Manager); cdecl;
  TFTC_Node_Unref = procedure(ANode:PFTC_NodeInt; AManager:PFTC_Manager); cdecl;

  TFTC_NodeRec = record
    mru_next:PFTC_NodeInt;      // circular mru list pointer
    mru_prev:PFTC_NodeInt;      // circular mru list pointer
    link:PFTC_NodeInt;          // used for hashing
    hash:TFT_UInt32;         // used for hashing too
    fam_index:TFT_UShort;    // index of family the node belongs to
    ref_count:TFT_Short;     // reference count for this node
  end;

  Tftc_node_done = procedure(ANode:PFTC_NodeInt; ACache: PFTC_Cache); cdecl;
  Tftc_node_destroy = procedure(ANode:PFTC_NodeInt; AManager: PFTC_Manager); cdecl;

  TFTC_QueryRec = record
    family:PFTC_Family;
    hash:TFT_UFast;
  end;

  TFTC_FamilyRec = record
    lru:TFT_LruNodeRec;
    cache:PFTC_Cache;
    num_nodes:TFT_UInt;
    fam_index:TFT_UInt;
  end;

  Tftc_family_init = function(AFamily: PFTC_Family; AQuery:PFTC_Query; ACache:PFTC_Cache):TFT_ERROR; cdecl;
  Tftc_family_done = procedure(AFamily: PFTC_Family); cdecl;

  TFTC_CacheRec = record
    manager:PFTC_Manager;
    memory:PFT_Memory;
    clazz:PFTC_Cache_Class;

    cache_index:TFT_UInt;
    cache_data:PFT_Pointer;

    p:TFT_UFast;
    mask:TFT_UFast;
    slack:TFT_Long;
    buckets:PPFTC_NodeInt;

    family_class:TFT_LruList_ClassRec;
    families:PFT_LruList;
  end;

  TFTC_Cache_InitFunc = ^TFTC_Cache_InitFunc_;
  TFTC_Cache_InitFunc_ = function(ACache:PFTC_Cache):TFT_ERROR; cdecl;

  TFTC_Cache_ClearFunc = ^TFTC_Cache_ClearFunc_;
  TFTC_Cache_ClearFunc_ = procedure(ACache:PFTC_Cache); cdecl;

  TFTC_Cache_DoneFunc = ^TFTC_Cache_DoneFunc_;
  TFTC_Cache_DoneFunc_ = procedure(ACache:PFTC_Cache); cdecl;

  TFTC_Family_InitFunc = ^TFTC_Family_InitFunc_;
  TFTC_Family_InitFunc_ = function(AFamily:PFTC_Family; AQuery:PFTC_Query; ACache:PFTC_Cache):TFT_ERROR; cdecl;

  TFTC_Family_CompareFunc = ^TFTC_Family_CompareFunc_;
  TFTC_Family_CompareFunc_ = function(AFamily:PFTC_Family; AQuery:PFTC_Query):TFT_Int; cdecl;

  TFTC_Family_DoneFunc = ^TFTC_Family_DoneFunc_;
  TFTC_Family_DoneFunc_ = procedure(AFamily:PFTC_Family; ACache: PFTC_Cache); cdecl;

  TFTC_Node_InitFunc = ^TFTC_Node_InitFunc_;
  TFTC_Node_InitFunc_ = function(ANode:PFTC_NodeInt; AType:PFT_Pointer; ACache:PFTC_Cache):TFT_ERROR; cdecl;

  TFTC_Node_WeightFunc = ^TFTC_Node_WeightFunc_;
  TFTC_Node_WeightFunc_ = function(ANode:PFTC_NodeInt; ACache: PFTC_Cache):TFT_ULong; cdecl;

  TFTC_Node_CompareFunc = ^TFTC_Node_CompareFunc_;
  TFTC_Node_CompareFunc_ = function(ANode:PFTC_NodeInt; AKey:PFT_Pointer; ACache:PFTC_Cache):TFT_Bool; cdecl;

  TFTC_Node_DoneFunc = ^TFTC_Node_DoneFunc_;
  TFTC_Node_DoneFunc_ = procedure(ANode:PFTC_NodeInt; ACache:PFTC_Cache); cdecl;

  TFTC_Cache_ClassRec = record
    cache_size:TFT_UInt;
    cache_init:TFTC_Cache_InitFunc;
    cache_clear:TFTC_Cache_ClearFunc;
    cache_done:TFTC_Cache_DoneFunc;

    family_size:TFT_UInt;
    family_init:TFTC_Family_InitFunc;
    family_compare:TFTC_Family_CompareFunc;
    family_done:TFTC_Family_DoneFunc;

    node_size:TFT_UInt;
    node_init:TFTC_Node_InitFunc;
    node_weight:TFTC_Node_WeightFunc;
    node_compare:TFTC_Node_CompareFunc;
    node_done:TFTC_Node_DoneFunc;
  end;

  Tftc_cache_done = procedure(ACache: PFTC_Cache); cdecl;
  Tftc_cache_clear = procedure(ACache: PFTC_Cache); cdecl;
  Tftc_cache_init = function(ACache: PFTC_Cache):TFT_ERROR; cdecl;
  Tftc_cache_lookup = function(ACache: PFTC_Cache; AQuery:PFTC_Query; var ANode:PFTC_NodeInt):TFT_ERROR; cdecl;

  TFTC_Cache_RemoveFaceID = procedure(cache: PFTC_Cache; face_id: PFTC_FaceID); cdecl;


implementation

end.
