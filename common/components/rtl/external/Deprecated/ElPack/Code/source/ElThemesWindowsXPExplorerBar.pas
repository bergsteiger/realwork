
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

unit ElThemesWindowsXPExplorerBar;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeExplorerBarButton = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeExplorerBar = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeExplorerBar }

constructor TWindowsXPThemeExplorerBar.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'ExplorerBar');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.HeaderBackground');
  AddPart(EBP_HEADERBACKGROUND, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.HeaderClose');
  AddPart(EBP_HEADERCLOSE, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.NormalGroupBackground');
  AddPart(EBP_NORMALGROUPBACKGROUND, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.NormalGroupCollapse');
  AddPart(EBP_NORMALGROUPCOLLAPSE, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.NormalGroupExpand');
  AddPart(EBP_NORMALGROUPEXPAND, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.NormalGroupHead');
  AddPart(EBP_NORMALGROUPHEAD, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.SpecialGroupBackground');
  AddPart(EBP_SPECIALGROUPBACKGROUND, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.SpecialGroupCollapse');
  AddPart(EBP_SPECIALGROUPCOLLAPSE, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.SpecialGroupExpand');
  AddPart(EBP_SPECIALGROUPEXPAND, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.SpecialGroupHead');
  AddPart(EBP_SPECIALGROUPHEAD, Part);
end;

{ TWindowsXPThemeExplorerBarButton }

function TWindowsXPThemeExplorerBarButton.GetStateRectIndex(StateID: integer): integer;
begin
  case StateID of
    EBHC_NORMAL : Result := 0;
    EBHC_HOT    : Result := 1;
    EBHC_PRESSED: Result := 2;
  else
    Result := 0;
  end;
end;

{$ENDIF}

end.
