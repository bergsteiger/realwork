
{*****************************************************}
{                                                     }
{             EldoS Themes Support Library            }
{                                                     }
{           (C) 2002-2003 EldoS Corporation           }
{                http://www.eldos.com/                }
{                                                     }
{*****************************************************}

{$include elpack2.inc}

{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

unit ElThemesWindowsXPTypes;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows, Classes, Graphics;

type
  TXPBgType = (bgNone, bgBorderFill, bgImageFile);
  TXPBorderType = (btNone, btRect, btRoundRect, btEllipse);
  TXPContentAlignment = (caLeft, caCenter, caRight);
  TXPFillType = (ftNone, ftSolid, ftVertGradient, ftHorzGradient,
    ftRadialGradient, ftTileImage);
  TXPFont = packed record
    Name: string[33];
    Size: integer;
    Style: TFontStyles;
  end;
  TXPGlyphType = (gtNone, gtImageGlyph, gtFontGlyph);
  TXPHAlign = (haLeft, haCenter, haRight);
  TXPIconEffect = (ieNone, ieGlow, ieShadow, iePulse, ieAlpha);
  TXPImageLayout = (ilVertical, ilHorizontal);
  TXPImageSelect = (isNone, isDPI, isSize);
  TXPMargins = packed record
    Left: integer;
    Right: integer;
    Top: integer;
    Bottom: integer;
  end;
  TXPSize = packed record
    Width: integer;
    Height: integer;
  end;
  TXPOffsetType = (otTopLeft, otTopRight, otTopMiddle, otBottomLeft,
    otBottomRight, otBottomMiddle, otMiddleLeft, otMiddleRight, otLeftOfCaption,
    otRightOfCaption, otLeftOfLastButton, otRightOfLastButton,
    otAboveLastButton, otBelowLastButton);
  TXPShadowType = (stNone, stSingle, stContinuous);
  TXPSizingType = (stStretch, stTrueSize, stTile, stTileHorz, stTileVert,
    stTileCenter);
  TXPVAlign = (vaTop, vaCenter, vaBottom);

  TXPRectArray = array of TRect;
  PXPRectArray = ^TXPRectArray;

{$ENDIF}

implementation

end.
