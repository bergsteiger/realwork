
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

unit ElThemesWindowsXPWindow;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeWindowFrame = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeWindowButton = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeWindow = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeWindow }

constructor TWindowsXPThemeWindow.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Window');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Window.Dialog');
  AddPart(WP_DIALOG, Part);
  // Normal Frames
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.FrameLeft');
  AddPart(WP_FRAMELEFT, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.FrameRight');
  AddPart(WP_FRAMERIGHT, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.FrameBottom');
  AddPart(WP_FRAMEBOTTOM, Part);
  // Small Frames
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallFrameLeft');
  AddPart(WP_SMALLFRAMELEFT, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallFrameRight');
  AddPart(WP_SMALLFRAMERIGHT, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallFrameBottom');
  AddPart(WP_SMALLFRAMEBOTTOM, Part);
  // Normal Captions
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.Caption');
  AddPart(WP_CAPTION, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.MinCaption');
  AddPart(WP_MINCAPTION, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.MaxCaption');
  AddPart(WP_MAXCAPTION, Part);
  // Small Captions
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallCaption');
  AddPart(WP_SMALLCAPTION, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallMinCaption');
  AddPart(WP_SMALLMINCAPTION, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallMaxCaption');
  AddPart(WP_SMALLMAXCAPTION, Part);
  // Normal Buttons
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.CloseButton');
  AddPart(WP_CLOSEBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MaxButton');
  AddPart(WP_MAXBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MinButton');
  AddPart(WP_MINBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.RestoreButton');
  AddPart(WP_RESTOREBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.HelpButton');
  AddPart(WP_HELPBUTTON, Part);
  //Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.SysButton');
  //AddPart(WP_SYSBUTTON, Part);
  // Small Close Button
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.SmallCloseButton');
  AddPart(WP_SMALLCLOSEBUTTON, Part);
  // MDI Buttons
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MDICloseButton');
  AddPart(WP_MDICLOSEBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MDIMinButton');
  AddPart(WP_MDIMINBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MDIRestoreButton');
  AddPart(WP_MDIRESTOREBUTTON, Part);
end;

{ TWindowsXPThemeWindowFrame }

function TWindowsXPThemeWindowFrame.GetStateRectIndex(StateID: integer): integer;
begin
  if StateID = FS_INACTIVE then
    Result := 1
  else
    Result := 0;
end;

{ TWindowsXPThemeWindowButton }

function TWindowsXPThemeWindowButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= CBS_NORMAL) and (StateID <= CBS_INACTIVEDISABLED) then
    Result := StateID - CBS_NORMAL
  else
    Result := 0;
end;

{$ENDIF}

end.
