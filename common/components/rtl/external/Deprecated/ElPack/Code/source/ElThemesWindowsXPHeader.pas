
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

unit ElThemesWindowsXPHeader;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeHeaderItem = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeHeader = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeHeader }

constructor TWindowsXPThemeHeader.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Header');
  AddPart(0, Root);
  Part := TWindowsXPThemeHeaderItem.Create(Self, Root, 'Header.HeaderItem');
  AddPart(HP_HEADERITEM, Part);
  Part := TWindowsXPThemeHeaderItem.Create(Self, Root, 'Header.HeaderItem');
  AddPart(HP_HEADERITEMLEFT, Part);
  Part := TWindowsXPThemeHeaderItem.Create(Self, Root, 'Header.HeaderItem');
  AddPart(HP_HEADERITEMRIGHT, Part);
end;

{ TWindowsXPThemeHeaderItem }

function TWindowsXPThemeHeaderItem.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID = HIS_NORMAL) or (StateID = HILS_NORMAL) or (StateID = HIRS_NORMAL) then
    Result := 0
  else
  if (StateID = HIS_HOT) or (StateID = HILS_HOT) or (StateID = HIRS_HOT) then
    Result := 1
  else
  if (StateID = HIS_PRESSED) or (StateID = HILS_PRESSED) or (StateID = HIRS_PRESSED) then
    Result := 2
  else
    Result := 0;
end;

{$ENDIF}

end.
