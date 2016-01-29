
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

unit ElThemesWindowsXPStatus;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows, ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeStatusPane = class(TWindowsXPThemePart)
  public
    procedure GetThemeBackgroundContentRect(DC: HDC; StateID: integer;
      const BoundingRect: TRect; out ContentRect: TRect); override;
    procedure GetThemeBackgroundExtent(DC: HDC; StateID: integer;
      const ContentRect: TRect; out ExtentRect: TRect); override;
  end;

  TWindowsXPThemeStatusGripper = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeStatus = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema, ElThemesWindowsXPTypes, ElThemesWindowsXPConsts;

{ TWindowsXPThemeStatusGripper }

function TWindowsXPThemeStatusGripper.GetStateRectIndex(StateID: integer): integer;
begin
  if StateID = SZB_LEFTALIGN then
    Result := 1
  else
    Result := 0;
end;

{ TWindowsXPThemeStatus }

constructor TWindowsXPThemeStatus.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Status');
  AddPart(0, Root);
  Part := TWindowsXPThemeStatusPane.Create(Self, Root, 'Status.Pane');
  AddPart(SP_PANE, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Status.GripperPane');
  AddPart(SP_GRIPPERPANE, Part);
  Part := TWindowsXPThemeStatusGripper.Create(Self, Root, 'Status.Gripper');
  AddPart(SP_GRIPPER, Part);
end;

{ TWindowsXPThemeStatusPane }

procedure TWindowsXPThemeStatusPane.GetThemeBackgroundContentRect(DC: HDC;
  StateID: integer; const BoundingRect: TRect; out ContentRect: TRect);
var
  Margins: TXPMargins;
begin
  ContentRect := BoundingRect;
  if Defined[TPP_SIZING_MARGINS] then
  begin
    Margins := MarginsProp[TPP_SIZING_MARGINS];
    Inc(ContentRect.Left, Margins.Left);
    Inc(ContentRect.Top, Margins.Top);
    Dec(ContentRect.Right, Margins.Right);
    Dec(ContentRect.Bottom, Margins.Bottom);
  end;
  if Defined[TPP_CONTENT_MARGINS] then
  begin
    Margins := MarginsProp[TPP_CONTENT_MARGINS];
    Inc(ContentRect.Left, Margins.Left);
    Inc(ContentRect.Top, Margins.Top);
    Dec(ContentRect.Right, Margins.Right);
    Dec(ContentRect.Bottom, Margins.Bottom);
  end;
end;

procedure TWindowsXPThemeStatusPane.GetThemeBackgroundExtent(DC: HDC;
  StateID: integer; const ContentRect: TRect; out ExtentRect: TRect);
var
  Margins: TXPMargins;
begin
  ExtentRect := ContentRect;
  if Defined[TPP_CONTENT_MARGINS] then
  begin
    Margins := MarginsProp[TPP_CONTENT_MARGINS];
    Dec(ExtentRect.Left, Margins.Left);
    Dec(ExtentRect.Top, Margins.Top);
    Inc(ExtentRect.Right, Margins.Right);
    Inc(ExtentRect.Bottom, Margins.Bottom);
  end;
  if Defined[TPP_SIZING_MARGINS] then
  begin
    Margins := MarginsProp[TPP_SIZING_MARGINS];
    Dec(ExtentRect.Left, Margins.Left);
    Dec(ExtentRect.Top, Margins.Top);
    Inc(ExtentRect.Right, Margins.Right);
    Inc(ExtentRect.Bottom, Margins.Bottom);
  end;
end;

{$ENDIF}

end.
