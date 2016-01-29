{******************************************************************************}
{                                                       	               }
{ FreeType charmap cache interface Unit for Object Pascal                      }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 2000-2001, 2003 by                                                 }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftcCMap.h. The original Pascal code is                 }
{ ftcCMap.pas, released February 2004. The initial developer of the            }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftcCMap;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftTypes,ftCache, ftcCache, ftConfig, FreeType;

type
  PFTC_CMapCache = ^TFTC_CMapCacheRec;
  TFTC_CMapCacheRec = record
  end;


{$IFDEF VCL6ORABOVE}
  TFTC_CMapType = (
    FTC_CMAP_BY_INDEX    = 0,
    FTC_CMAP_BY_ENCODING = 1,
    FTC_CMAP_BY_ID       = 2);
{$ENDIF}

{$IFDEF DELPHI5}
  TFTC_CMapType = Integer;
  const
    FTC_CMAP_BY_INDEX    = 0;
    FTC_CMAP_BY_ENCODING = 1;
    FTC_CMAP_BY_ID       = 2;
{$ENDIF}

type
  PFTC_CMapDesc = ^TFTC_CMapDescRec;

  TFTC_CMapIdRec = record
    FTPlatform:TFT_UInt;
    encoding:TFT_UInt;
  end;

  TFTC_CMapDescRec = record
    face_id:PFTC_FaceID;
    CMapType:TFTC_CMapType;
    case Integer of    //
      0: (Index:TFT_UInt);
      1: (Encoding:TFT_Encoding);
      2: (ID: TFTC_CMapIdRec);
  end;

  TFTC_CMapCache_New = function(AManager: PFTC_Manager; var ACache:PFTC_CMapCache):TFT_ERROR; cdecl;
  TFTC_CMapCache_Lookup = function(ACache:PFTC_CMapCache; ACMapDesc:PFTC_CMapDesc; ACharCode:TFT_UInt32):TFT_UInt; cdecl;

implementation

end.
