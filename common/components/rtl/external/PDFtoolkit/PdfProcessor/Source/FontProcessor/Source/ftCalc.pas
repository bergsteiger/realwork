{******************************************************************************}
{                                                       	               }
{ FreeType Arithmetic computations interface Unit for Object Pascal            }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002 by                                                 }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftCalc.h. The original Pascal code is                  }
{ ftCalc.pas, released February 2004. The initial developer of the             }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftCalc;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftTypes, ftConfig;

type
  TFT_SqrtFixed=function(x:TFT_Int32):TFT_Int32; cdecl;
  TFT_Sqrt32=function(x:TFT_Int32):TFT_Int32; cdecl;

implementation

end.
