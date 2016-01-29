{******************************************************************************}
{                                                       	               }
{ FreeType simple types definitions interface Unit for Object Pascal           }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001 by                                                       }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftTypes.h. The original Pascal code is                 }
{ ftTypes.pas, released February 2004. The initial developer of the            }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftTypes;

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
  TFT_Bool = Byte;

  TFT_FWord = SmallInt;

  TFT_UFWord = Word;

  TFT_Char = Byte;

  PPFT_Byte = ^PFT_Byte;
  PFT_Byte = ^TFT_Byte;
  TFT_Byte = ShortInt;

  PFT_String = ^TFT_String;
  TFT_String = AnsiChar;

  TFT_Short = SmallInt;
  TFT_UShort = Word;

  TFT_Int = Integer;
  TFT_UInt = LongWord;

  TFT_Long = LongInt;
  TFT_ULong = Cardinal;

  TFT_F2Dot14 = SmallInt;
  TFT_F26Dot6 = LongInt;

  TFT_Fixed = LongInt;

  TFT_ERROR = integer;

  PFT_Pointer = pointer;

  TSize_t = LongWord;

  TFT_Offset = TSize_t;

  TFT_PtrDist = TSize_t;

  TFT_UnitVector = record
    x:TFT_F2Dot14;
    y:TFT_F2Dot14;
  end;

  PFT_Matrix=^TFT_Matrix;
  TFT_Matrix= record
    xx, xy:TFT_Fixed;
    yx, yy:TFT_Fixed;
  end;

  TFT_Data = record
    pointer:PFT_Byte;
    length:TFT_Int;
  end;

  TFT_Generic= record
    data:Pointer;
    finalizer:Pointer; //FT_Generic_Finalizer
  end;

  PFT_ListNode = ^TFT_ListNodeRec;
  PFT_List = ^TFT_ListRec;

  TFT_ListNodeRec = record
    prev:PFT_ListNode;
    next:PFT_ListNode;
    data:Pointer;
  end;

  TFT_ListRec = record
    head:PFT_ListNode;
    tail:PFT_ListNode;
  end;

{$IFDEF DELPHI5}
type
  PCardinal     = ^Cardinal;
  PPChar        = ^PChar;
  PPAnsiChar    = PPChar;
  PPointer      = ^Pointer;
  PSmallInt     = ^SmallInt;
  PByte         = ^Byte;

  { TStream seek origins }
  TSeekOrigin = (soBeginning, soCurrent, soEnd);

  const
    NaN = 0.0 / 0.0;
{$ENDIF}

implementation

end.
