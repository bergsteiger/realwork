{******************************************************************************}
{                                                       	               }
{ FreeType Cache subsystem interface Unit for Object Pascal                    }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftCache.h. The original Pascal code is                 }
{ ftCache.pas, released February 2004. The initial developer of the            }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftCache;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  FreeType, ftTypes, ftObjs, ftcCache;

type
  TFTC_Face_Requester = ^TFTC_Face_Requester_;

  PFTC_Scaler = ^TFTC_ScalerRec;
  TFTC_ScalerRec = record
    face_id: PFTC_FaceID;
    width: TFT_UInt;
    height: TFT_UInt;
    pixel: TFT_Int;
    x_res: TFT_UInt;
    y_res: TFT_UInt;
  end;        

  TFTC_FontRec = record
    face_id:PFTC_FaceID;
    pix_width:TFT_UShort;
    pix_height:TFT_UShort;
  end;

  PFTC_Font = ^TFTC_FontRec;

  PFTC_Manager = ^TFTC_ManagerRec;

  PPFTC_Node = ^PFTC_Node;
  PFTC_Node = ^TFTC_NodeRec;

  TFTC_Manager_New = function(ALibrary:PFT_Library; AMaxFaces:TFT_UInt; AMaxSizes:TFT_UInt; AMaxBytes:TFT_ULong; ARequester:TFTC_Face_Requester;
    AReqData:PFT_Pointer; var AManager:PFTC_Manager):TFT_ERROR; cdecl;
  TFTC_Manager_Reset = procedure(AManager:PFTC_Manager); cdecl;
  TFTC_Manager_Done = procedure(AManager:PFTC_Manager); cdecl;
  TFTC_Manager_Lookup_Face = function(AManager:PFTC_Manager; AFaceID:PFTC_FaceID; var AFace:PFT_Face):TFT_ERROR; cdecl;
  TFTC_Manager_Lookup_Size = function(AManager:PFTC_Manager; AFont:PFTC_Font; var AFace:PFT_Face; var ASize:PFT_Size):TFT_ERROR; cdecl;

implementation

end.
