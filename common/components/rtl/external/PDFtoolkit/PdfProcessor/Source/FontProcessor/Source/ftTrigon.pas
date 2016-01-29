{******************************************************************************}
{                                                       	               }
{ FreeType trigonometric functions interface Unit for Object Pascal            }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 2001, 2003 by                                                      }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftTrigon.h. The original Pascal code is                }
{ ftTrigon.pas, released February 2004. The initial developer of the           }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftTrigon;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftTypes, ftImage;

type
  TFT_Angle = TFT_Fixed;

const
  FT_ANGLE_PI  = 180 shl 16;
  FT_ANGLE_2PI = FT_ANGLE_PI * 2;
  FT_ANGLE_PI2 = FT_ANGLE_PI / 2;
  FT_ANGLE_PI4 = FT_ANGLE_PI / 4;

type
  TFT_Sin = function(AAngle:TFT_Angle):TFT_Fixed; cdecl;
  TFT_Cos = function(AAngle:TFT_Angle):TFT_Fixed; cdecl;
  TFT_Tan = function(AAngle:TFT_Angle):TFT_Fixed; cdecl;
  TFT_ATan2 = function(x,y:TFT_Fixed):TFT_Angle; cdecl;
  TFT_Angle_Diff = function(AAngle1, AAngle2:TFT_Angle):TFT_Angle; cdecl;
  TFT_Vector_Unit = procedure(var AVector:TFT_Vector; AAngle:TFT_Angle); cdecl;
  TFT_Vector_Rotate = procedure(var AVector:TFT_Vector; AAngle:TFT_Angle); cdecl;
  TFT_Vector_Length = function(var AVector:TFT_Vector):TFT_Fixed; cdecl;
  TFT_Vector_Polarize = procedure(var AVector:TFT_Vector; var ALength:TFT_Fixed; var AAngle:TFT_Angle); cdecl;
  TFT_Vector_From_Polar = procedure(var AVector:TFT_Vector; ALength:TFT_Fixed; AAngle:TFT_Angle); cdecl;

implementation

end.
