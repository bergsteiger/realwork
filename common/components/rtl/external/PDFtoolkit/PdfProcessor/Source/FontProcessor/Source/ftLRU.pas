{******************************************************************************}
{                                                       	               }
{ FreeType Simple LRU list-cache interface Unit for Object Pascal              }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftLRU.h. The original Pascal code is                   }
{ ftLRU.pas, released February 2004. The initial developer of the              }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{ 								               }
{******************************************************************************}
unit ftLRU;

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
  PFT_LruKey = PFT_Pointer;

  PFT_LruList = ^TFT_LruListRec;

  PFT_LruList_Class = ^TFT_LruList_ClassRec;

  PFT_LruNode = ^TFT_LruNodeRec;

  TFT_LruNodeRec = record
    next:PFT_LruNode;
    key:PFT_LruKey;
  end;


  TFT_LruListRec = record
    memory:PFT_Memory;
    clazz:PFT_LruList_Class;
    nodes:PFT_LruNode;
    max_nodes:TFT_UInt;
    num_nodes:TFT_UInt;           
    data:PFT_Pointer;
  end;

  TFT_LruList_InitFunc = ^TFT_LruList_InitFunc_;
  TFT_LruList_InitFunc_ = function(AList:PFT_LruList):TFT_ERROR; cdecl;

  TFT_LruList_DoneFunc = ^TFT_LruList_DoneFunc_;
  TFT_LruList_DoneFunc_ = procedure(AList:PFT_LruList); cdecl;

  TFT_LruNode_InitFunc = ^TFT_LruNode_InitFunc_;
  TFT_LruNode_InitFunc_ = function(ANode: PFT_LruNode; AKey:PFT_LruKey; AData:PFT_Pointer):TFT_ERROR; cdecl;

  TFT_LruNode_DoneFunc = ^TFT_LruNode_DoneFunc_;
  TFT_LruNode_DoneFunc_ = procedure(ANode: PFT_LruNode; AData: PFT_Pointer); cdecl;

  TFT_LruNode_FlushFunc = ^TFT_LruNode_FlushFunc_;
  TFT_LruNode_FlushFunc_ = function(ANode:PFT_LruNode; ANewKey:PFT_LruKey; AData:PFT_Pointer):TFT_ERROR; cdecl;

  TFT_LruNode_CompareFunc = ^TFT_LruNode_CompareFunc_;
  TFT_LruNode_CompareFunc_ = function(ANode:PFT_LruNode; AKey:PFT_LruKey; AData:PFT_Pointer):TFT_Bool; cdecl;

  TFT_LruNode_SelectFunc = ^TFT_LruNode_SelectFunc_;
  TFT_LruNode_SelectFunc_ = function(ANode:PFT_LruNode; AData:PFT_Pointer; AListData:PFT_Pointer):TFT_Bool; cdecl;

  TFT_LruList_ClassRec = record
    list_size:TFT_UInt;
    list_init:TFT_LruList_InitFunc;        // optional
    list_done:TFT_LruList_DoneFunc;        // optional

    node_size:TFT_UInt;
    node_init:TFT_LruNode_InitFunc;        // MANDATORY
    node_done:TFT_LruNode_DoneFunc;        // optional
    node_flush:TFT_LruNode_FlushFunc;      // optional
    node_compare:TFT_LruNode_CompareFunc;  // optional
  end;

  TFT_LruList_New = function(AClass:PFT_LruList_Class; AMaxElements:TFT_UInt; AUserData:PFT_Pointer; AMemory:PFT_Memory; var AList:PFT_LruList):TFT_ERROR; cdecl;
  TFT_LruList_Reset = procedure(AList:PFT_LruList); cdecl;
  TFT_LruList_Destroy = procedure(AList:PFT_LruList); cdecl;
  TFT_LruList_Lookup = function(AList:PFT_LruList; AKey:PFT_LruKey; var ANode:PFT_LruNode):TFT_ERROR; cdecl;
  TFT_LruList_Remove = procedure(AList:PFT_LruList; ANode:PFT_LruNode); cdecl;
  TFT_LruList_Remove_Selection = procedure(AList:PFT_LruList; ASelectFunc:TFT_LruNode_SelectFunc; ASelectData:PFT_Pointer); cdecl;

implementation

end.
 