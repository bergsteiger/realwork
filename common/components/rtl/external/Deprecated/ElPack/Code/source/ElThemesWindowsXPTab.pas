
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

unit ElThemesWindowsXPTab;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows, ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeTabPart = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  public
    procedure GetThemeBackgroundContentRect(DC: HDC; StateID: integer;
      const BoundingRect: TRect; out ContentRect: TRect); override;
  end;

  TWindowsXPThemeTab = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema, ElThemesWindowsXPConsts, ElThemesWindowsXPTypes;

{ TWindowsXPThemeTabPart }

function TWindowsXPThemeTabPart.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= TIS_NORMAL) and (StateID <= TIS_FOCUSED) then
    Result := StateID - TIS_NORMAL
  else
    Result := 0;
end;

procedure TWindowsXPThemeTabPart.GetThemeBackgroundContentRect(DC: HDC;
  StateID: integer; const BoundingRect: TRect; out ContentRect: TRect);
var
  Margins: TXPMargins;
begin
  ContentRect := BoundingRect;
  if Defined[TPP_CONTENT_MARGINS] then
  begin
    Margins := MarginsProp[TPP_CONTENT_MARGINS];
    Inc(ContentRect.Left, Margins.Left);
    Inc(ContentRect.Top, Margins.Top);
    Dec(ContentRect.Right, Margins.Right);
    Dec(ContentRect.Bottom, Margins.Bottom);
  end
  else
  if Defined[TPP_SIZING_MARGINS] then
  begin
    Margins := MarginsProp[TPP_SIZING_MARGINS];
    Inc(ContentRect.Left, Margins.Left);
    Inc(ContentRect.Top, Margins.Top);
    Dec(ContentRect.Right, Margins.Right);
    Dec(ContentRect.Bottom, Margins.Bottom);
  end;
end;

{ TWindowsXPThemeTab }

constructor TWindowsXPThemeTab.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Tab');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Tab.Body');
  AddPart(TABP_BODY, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.Pane');
  AddPart(TABP_PANE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TabItem');
  AddPart(TABP_TABITEM, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TabItemBothEdge');
  AddPart(TABP_TABITEMBOTHEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TabItemLeftEdge');
  AddPart(TABP_TABITEMLEFTEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TabItemRightEdge');
  AddPart(TABP_TABITEMRIGHTEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TopTabItem');
  AddPart(TABP_TOPTABITEM, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TopTabItemBothEdge');
  AddPart(TABP_TOPTABITEMBOTHEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TopTabItemLeftEdge');
  AddPart(TABP_TOPTABITEMLEFTEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TopTabItemRightEdge');
  AddPart(TABP_TOPTABITEMRIGHTEDGE, Part);
end;

{$ENDIF}

end.
