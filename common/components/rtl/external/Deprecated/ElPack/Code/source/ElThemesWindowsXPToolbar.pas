
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

unit ElThemesWindowsXPToolbar;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeToolbarPart = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeToolbar = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeToolbar }

constructor TWindowsXPThemeToolbar.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Toolbar');
  AddPart(0, Root);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.Button');
  AddPart(TP_BUTTON, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.DropdownButton');
  AddPart(TP_DROPDOWNBUTTON, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.SplitButton');
  AddPart(TP_SPLITBUTTON, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.SplitButtonDropdown');
  AddPart(TP_SPLITBUTTONDROPDOWN, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.Separator');
  AddPart(TP_SEPARATOR, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.SeparatorVert');
  AddPart(TP_SEPARATORVERT, Part);
end;

{ TWindowsXPThemeToolbarPart }

function TWindowsXPThemeToolbarPart.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= TS_NORMAL) and (StateID <= TS_HOTCHECKED) then
    Result := StateID - TS_NORMAL
  else
    Result := 0;
end;

{$ENDIF}

end.
