{******************************************************************************}
{                                                       	               }
{ FreeType Simple LRU list-cache interface Unit for Object Pascal              }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftMRU.h. The original Pascal code is                   }
{ ftMRU.pas, released February 2005. The initial developer of the              }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftMRU;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface 

uses
  ftTypes, ftSystem;

type
  PFTC_MruNode = ^TFTC_MruNodeRec;

  TFTC_MruNodeRec = record
    next: PFTC_MruNode;
    prev: PFTC_MruNode;
  end;

  PFTC_MruList = ^TFTC_MruListRec;
  PFTC_MruListClass = ^TFTC_MruListClassRec;

  TFTC_MruNode_CompareFunc = function(node: PFTC_MruNode; key: PFT_Pointer): TFT_Bool; cdecl;
  TFTC_MruNode_InitFunc = function(node: PFTC_MruNode; key: PFT_Pointer; data: PFT_Pointer): TFT_Error; cdecl;
  TFTC_MruNode_ResetFunc = function(node: PFTC_MruNode; key: PFT_Pointer; data: PFT_Pointer): TFT_ERROR; cdecl;

  TFTC_MruNode_DoneFunc = procedure(node: PFTC_MruNode; data: PFT_Pointer); cdecl;


  TFTC_MruListClassRec = record
    node_size: TFT_UInt;
    node_compare: TFTC_MruNode_CompareFunc;
    node_init: TFTC_MruNode_InitFunc;
    node_reset: TFTC_MruNode_ResetFunc;
    node_done: TFTC_MruNode_DoneFunc;
  end;

  TFTC_MruListRec = record
    num_nodes: TFT_UInt;
    max_nodes: TFT_UInt;
    nodes: PFTC_MruNode;
    data: PFT_Pointer;
    clazz: TFTC_MruListClassRec;
    memory: PFT_Memory;
  end;


  TFTC_MruNode_Prepend = procedure(var plist: PFTC_MruNode; node: PFTC_MruNode); cdecl;
  TFTC_MruNode_Up = procedure(var plist: PFTC_MruNode; node: PFTC_MruNode); cdecl;
  TFTC_MruNode_Remove = procedure(var plist: PFTC_MruNode; node: PFTC_MruNode); cdecl;
  TFTC_MruList_Init = procedure(list: PFTC_MruList; clazz: PFTC_MruListClass; max_nodes: TFT_UInt; data: PFT_Pointer; memory: PFT_Memory); cdecl;
  TFTC_MruList_Reset = procedure(list: PFTC_MruList); cdecl;
  TFTC_MruList_Done = procedure(list: PFTC_MruList); cdecl;
  TFTC_MruList_Find = function(list: PFTC_MruList; key: PFT_Pointer): PFTC_MruNode; cdecl;
  TFTC_MruList_New = function(list: PFTC_MruList; key: PFT_Pointer; var anode: PFTC_MruNode): TFT_Error; cdecl;
  TFTC_MruList_Lookup = function(list: PFTC_MruList; key: PFT_Pointer; var pnode: PFTC_MruNode): TFT_Error; cdecl;
  TFTC_MruList_Remove = procedure(list: PFTC_MruList; node: PFTC_MruNode); cdecl;
  TFTC_MruList_RemoveSelection = procedure(list: PFTC_MruList; selection: TFTC_MruNode_CompareFunc; key: PFT_Pointer); cdecl;


implementation

end.
