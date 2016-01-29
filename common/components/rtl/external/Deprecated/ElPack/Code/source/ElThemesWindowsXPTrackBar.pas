
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

unit ElThemesWindowsXPTrackBar;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows, ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeTrackBarThumb = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeTrackBarTics = class(TWindowsXPThemePart)
  public
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
  end;

  TWindowsXPThemeTrackBar = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema, ElThemesWindowsXPConsts;

{ TWindowsXPThemeTrackBar }

constructor TWindowsXPThemeTrackBar.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'TrackBar');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'TrackBar.Track');
  AddPart(TKP_TRACK, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'TrackBar.TrackVert');
  AddPart(TKP_TRACKVERT, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.Thumb');
  AddPart(TKP_THUMB, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbBottom');
  AddPart(TKP_THUMBBOTTOM, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbTop');
  AddPart(TKP_THUMBTOP, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbVert');
  AddPart(TKP_THUMBVERT, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbLeft');
  AddPart(TKP_THUMBLEFT, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbRight');
  AddPart(TKP_THUMBRIGHT, Part);
  Part := TWindowsXPThemeTrackBarTics.Create(Self, Root, 'TrackBar.Tics');
  AddPart(TKP_TICS, Part);
  Part := TWindowsXPThemeTrackBarTics.Create(Self, Root, 'TrackBar.TicsVert');
  AddPart(TKP_TICSVERT, Part);
end;

{ TWindowsXPThemeTrackBarThumb }

function TWindowsXPThemeTrackBarThumb.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= TUS_NORMAL) and (StateID <= TUS_DISABLED) then
    Result := StateID - TUS_NORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemeTrackBarTics }

procedure TWindowsXPThemeTrackBarTics.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
var
  Pen: HPen;
begin
  if Defined[TPP_COLOR] then
  begin
    Pen := CreatePen(PS_SOLID, 1, ColorProp[TPP_COLOR]);
    Pen := SelectObject(DC, Pen);
    if Rect.Right - Rect.Left > Rect.Bottom - Rect.Top then
    begin
      MoveToEx(DC, Rect.Left, Rect.Bottom, nil);
      LineTo(DC, Rect.Right, Rect.Bottom);
    end
    else begin
      MoveToEx(DC, Rect.Right, Rect.Top, nil);
      LineTo(DC, Rect.Right, Rect.Bottom);
    end;
    Pen := SelectObject(DC, Pen);
    DeleteObject(Pen);
  end
  else
    inherited;
end;

{$ENDIF}

end.
