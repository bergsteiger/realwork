{******************************************************************************}
{                                                       	               }
{ Generic list support for FreeType interface Unit for Object Pascal           }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2003 by                                                 }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftList.h. The original Pascal code is                  }
{ ftList.pas, released February 2004. The initial developer of the             }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftList;

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
  TFT_List_Find = function(AList:PFT_List; AData:Pointer):PFT_ListNode; cdecl;
  TFT_List_Add = procedure(AList:PFT_List; ANode: PFT_ListNode); cdecl;
  TFT_List_Insert = procedure(AList:PFT_List; ANode: PFT_ListNode); cdecl;
  TFT_List_Remove = procedure(AList:PFT_List; ANode: PFT_ListNode); cdecl;
  TFT_List_Up = procedure(AList:PFT_List; ANode: PFT_ListNode); cdecl;


  TFT_List_Iterator = ^TFT_List_Iterator_;
  TFT_List_Iterator_ = function(ANode:PFT_ListNode; AUser:Pointer):TFT_ERROR; cdecl;

  TFT_List_Iterate = function(AList:PFT_List; AIterator:TFT_List_Iterator; AUser:Pointer):TFT_ERROR; cdecl;

  TFT_List_Destructor = ^TFT_List_Destructor_;
  TFT_List_Destructor_ = procedure(AMemory:PFT_Memory; AData:Pointer; AUser:Pointer); cdecl;

  TFT_List_Finalize = procedure(AList:PFT_List; ADestroy: TFT_List_Destructor; AMemory: PFT_Memory; AUser:Pointer); cdecl;

implementation

end.
