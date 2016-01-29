
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

unit ElThemesWindowsXPComboBox;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeComboBoxDropDown = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeComboBox = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeComboBoxDropDown }

function TWindowsXPThemeComboBoxDropDown.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= CBXS_NORMAL) and (StateID <= CBXS_DISABLED) then
    Result := StateID - CBXS_NORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemeComboBox }

constructor TWindowsXPThemeComboBox.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'ComboBox');
  AddPart(0, Root);
  Part := TWindowsXPThemeComboBoxDropDown.Create(Self, Root, 'ComboBox.DropDownButton');
  AddPart(CP_DROPDOWNBUTTON, Part);
end;

{$ENDIF}

end.
