
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

unit ElThemesWindowsXPScrollBar;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeScrollBarPart = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeScrollBarButton = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeScrollBarSizeBox = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeScrollBar = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeScrollBar }

constructor TWindowsXPThemeScrollBar.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemeScrollBarPart.Create(Self, nil, 'ScrollBar');
  AddPart(0, Root);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.LowerTrackHorz');
  AddPart(SBP_LOWERTRACKHORZ, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.LowerTrackVert');
  AddPart(SBP_LOWERTRACKVERT, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.ThumbBtnHorz');
  AddPart(SBP_THUMBBTNHORZ, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.ThumbBtnVert');
  AddPart(SBP_THUMBBTNVERT, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.UpperTrackHorz');
  AddPart(SBP_UPPERTRACKHORZ, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.UpperTrackVert');
  AddPart(SBP_UPPERTRACKVERT, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.GripperHorz');
  AddPart(SBP_GRIPPERHORZ, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.GripperVert');
  AddPart(SBP_GRIPPERVERT, Part);
  Part := TWindowsXPThemeScrollBarButton.Create(Self, Root, 'ScrollBar.ArrowBtn');
  AddPart(SBP_ARROWBTN, Part);
  Part := TWindowsXPThemeScrollBarSizeBox.Create(Self, Root, 'ScrollBar.SizeBox');
  AddPart(SBP_SIZEBOX, Part);
end;

{ TWindowsXPThemeScrollBarPart }

function TWindowsXPThemeScrollBarPart.GetStateRectIndex(StateID: integer): integer;
begin
  case StateID of
    SCRBS_NORMAL  : Result := 0;
    SCRBS_HOT     : Result := 1;
    SCRBS_PRESSED : Result := 2;
    SCRBS_DISABLED: Result := 3;
  else
    Result := 0;
  end;
end;

{ TWindowsXPThemeScrollBarButton }

function TWindowsXPThemeScrollBarButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= ABS_UPNORMAL) and (StateID <= ABS_RIGHTDISABLED) then
    Result := StateID - ABS_UPNORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemeScrollBarSizeBox }

function TWindowsXPThemeScrollBarSizeBox.GetStateRectIndex(StateID: integer): integer;
begin
  if StateID = SZB_LEFTALIGN then
    Result := 1
  else
    Result := 0;
end;

{$ENDIF}

end.
