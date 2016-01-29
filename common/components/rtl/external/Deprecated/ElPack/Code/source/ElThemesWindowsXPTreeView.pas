
{*****************************************************}
{                                                     }
{             EldoS Themes Support Library            }
{                                                     }
{           (C) 2002-2003 EldoS Corporation           }
{                http://www.eldos.org/                }
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

unit ElThemesWindowsXPTreeView;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeTreeViewGlyph = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeTreeView = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeTreeView }

constructor TWindowsXPThemeTreeView.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'TreeView');
  AddPart(0, Root);
  Part := TWindowsXPThemeTreeViewGlyph.Create(Self, Root, 'TreeView.Glyph');
  AddPart(TVP_GLYPH, Part);
end;

{ TWindowsXPThemeTreeViewGlyph }

function TWindowsXPThemeTreeViewGlyph.GetStateRectIndex(StateID: integer): integer;
begin
  if StateID = GLPS_OPENED then
    Result := 1
  else
    Result := 0;
end;

{$ENDIF}

end.
