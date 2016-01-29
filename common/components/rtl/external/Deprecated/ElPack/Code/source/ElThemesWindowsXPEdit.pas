
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

unit ElThemesWindowsXPEdit;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows, ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemeEditText = class(TWindowsXPThemePart)
  private
    FDisabled: TWindowsXPThemePart;
    FReadOnly: TWindowsXPThemePart;
  public
    constructor Create(Theme: TWindowsXPTheme;
      Parent: TWindowsXPThemePart; Section: string); override;
    destructor Destroy; override;
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PWideChar;
      CharCount: integer;  TextFlags: cardinal; TextFlags2: cardinal;
      var Rect: TRect); override;
  end;

  TWindowsXPThemeEdit = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeEdit }

constructor TWindowsXPThemeEdit.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Edit');
  AddPart(0, Root);
  Part := TWindowsXPThemeEditText.Create(Self, Root, 'Edit');
  AddPart(EP_EDITTEXT, Part);
end;

{ TWindowsXPThemeEditText }

constructor TWindowsXPThemeEditText.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FDisabled := TWindowsXPThemePart.Create(Theme, Self, 'Edit.Edittext(Disabled)');
  FReadOnly := TWindowsXPThemePart.Create(Theme, Self, 'Edit.Edittext(ReadOnly)');
end;

destructor TWindowsXPThemeEditText.Destroy;
begin
  FReadOnly.Free;
  FDisabled.Free;
  inherited;
end;

procedure TWindowsXPThemeEditText.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  case StateID of
    ETS_DISABLED: FDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    ETS_READONLY: FReadOnly.DrawThemeBackground(DC, StateID, Rect, ClipRect);
  else
    inherited;
  end;
end;

procedure TWindowsXPThemeEditText.DrawThemeText(DC: HDC; StateID: integer;
  Text: PWideChar; CharCount: integer; TextFlags, TextFlags2: cardinal;
  var Rect: TRect);
begin
  case StateID of
    ETS_DISABLED: FDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    ETS_READONLY: FReadOnly.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
  else
    inherited;
  end
end;

{$ENDIF}

end.
