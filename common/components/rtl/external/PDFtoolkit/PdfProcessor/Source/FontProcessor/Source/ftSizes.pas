{******************************************************************************}
{                                                       	               }
{ FreeType size objects management interface Unit for Object Pascal            }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2003 by                                                 }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftSizes.h. The original Pascal code is                 }
{ ftSizes.pas, released February 2004. The initial developer of the            }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftSizes;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  FreeType, ftTypes;

type
  TFT_New_Size = function(AFace:PFT_Face; var ASize:PFT_Size):TFT_ERROR; cdecl;
  TFT_Done_Size = function(ASize:PFT_Size):TFT_ERROR; cdecl;
  TFT_Activate_Size = function(ASize:PFT_Size):TFT_ERROR; cdecl;

implementation

end.
