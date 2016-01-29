{******************************************************************************}
{                                                       	               }
{ FreeType low-level system interface definition interface Unit for            }
{ Object Pascal                                                                } 
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002 by                                                 }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftSystem.h. The original Pascal code is                }
{ ftSystem.pas, released February 2004. The initial developer of the           }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftSystem;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  Windows;

type
  PFT_Memory = ^TFT_MemoryRec;

  TFT_Alloc_Func = ^TFT_Alloc_Func_;
  TFT_Alloc_Func_ = function(AMemory:PFT_Memory; ASize:LongInt):Pointer; cdecl;

  TFT_Free_Func = ^TFT_Free_Func_;
  TFT_Free_Func_ = procedure(AMemory:PFT_Memory; ABlock:Pointer); cdecl;

  TFT_Realloc_Func = ^TFT_Realloc_Func_;
  TFT_Realloc_Func_ = function(AMemory:PFT_Memory; ACurSize:LongInt; ANewSize:LongInt; ABlock:Pointer):Pointer; cdecl;

  TFT_MemoryRec = record
    User: Pointer;
    alloc: TFT_Alloc_Func;
    free: TFT_Free_Func;
    realloc: TFT_Realloc_Func;
  end;


  PFT_Stream = ^TFT_StreamRec;

  TFT_StreamDesc = record
    case Integer of    //
      0: (Value:LongInt);
      1: (P:Pointer);
  end;

  TFT_Stream_IoFunc = ^TFT_Stream_IoFunc_;
  TFT_Stream_IoFunc_ = function(AStream:PFT_Stream; AOffset:DWord; ABuffer:PAnsiChar; ACount:DWord):Cardinal; cdecl;

  TFT_Stream_CloseFunc = ^TFT_Stream_CloseFunc_;
  TFT_Stream_CloseFunc_ = procedure(AStream:PFT_Stream); cdecl;

  TFT_StreamRec = record
    base:PAnsiChar;
    size:DWord;
    pos:DWord;

    descriptor:TFT_StreamDesc;
    pathname:TFT_StreamDesc;
    read:TFT_Stream_IoFunc;
    close:TFT_Stream_CloseFunc;

    memory:PFT_Memory;
    cursor:PAnsiChar;
    limit:PAnsiChar;
  end;

implementation

end.
