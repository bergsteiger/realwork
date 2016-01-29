
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

unit ElThemesWindowsXPProgress;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeProgress = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeProgress }

constructor TWindowsXPThemeProgress.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Progress');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Progress.Bar');
  AddPart(PP_BAR, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Progress.BarVert');
  AddPart(PP_BARVERT, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Progress.Chunk');
  AddPart(PP_CHUNK, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Progress.ChunkVert');
  AddPart(PP_CHUNKVERT, Part);
end;

{$ENDIF}

end.
