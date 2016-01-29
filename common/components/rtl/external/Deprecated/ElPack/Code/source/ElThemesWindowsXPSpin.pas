
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

unit ElThemesWindowsXPSpin;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeSpinButton = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeSpin = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeSpin }

constructor TWindowsXPThemeSpin.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Spin');
  AddPart(0, Root);
  Part := TWindowsXPThemeSpinButton.Create(Self, Root, 'Spin.Up');
  AddPart(SPNP_UP, Part);
  Part := TWindowsXPThemeSpinButton.Create(Self, Root, 'Spin.Down');
  AddPart(SPNP_DOWN, Part);
  Part := TWindowsXPThemeSpinButton.Create(Self, Root, 'Spin.UpHorz');
  AddPart(SPNP_UPHORZ, Part);
  Part := TWindowsXPThemeSpinButton.Create(Self, Root, 'Spin.DownHorz');
  AddPart(SPNP_DOWNHORZ, Part);
end;

{ TWindowsXPThemeSpinButton }

function TWindowsXPThemeSpinButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID = UPS_NORMAL) or (StateID = DNS_NORMAL) or
     (StateID = UPHZS_NORMAL) or (StateID = DNHZS_NORMAL) then
    Result := 0
  else
  if (StateID = UPS_HOT) or (StateID = DNS_HOT) or
     (StateID = UPHZS_HOT) or (StateID = DNHZS_HOT) then
    Result := 1
  else
  if (StateID = UPS_PRESSED) or (StateID = DNS_PRESSED) or
     (StateID = UPHZS_PRESSED) or (StateID = DNHZS_PRESSED) then
    Result := 2
  else
  if (StateID = UPS_DISABLED) or (StateID = DNS_DISABLED) or
     (StateID = UPHZS_DISABLED) or (StateID = DNHZS_DISABLED) then
    Result := 3
  else
    Result := 0;
end;

{$ENDIF}

end.
