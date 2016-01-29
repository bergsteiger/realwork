
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

unit ElThemesWindowsXPButton;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows, ElThemesGeneral, ElThemesWindowsXP;

type
  TWindowsXPThemePushButtonDisabled = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemePushButton = class(TWindowsXPThemePart)
  private
    FDisabled: TWindowsXPThemePushButtonDisabled;
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
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

  TWindowsXPThemeRadioButtonDisabled = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeRadioButton = class(TWindowsXPThemePart)
  private
    FUncheckedDisabled: TWindowsXPThemeRadioButtonDisabled;
    FCheckedDisabled: TWindowsXPThemeRadioButtonDisabled;
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
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

  TWindowsXPThemeCheckBoxDisabled = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeCheckBox = class(TWindowsXPThemePart)
  private
    FUncheckedDisabled: TWindowsXPThemeCheckBoxDisabled;
    FCheckedDisabled: TWindowsXPThemeCheckBoxDisabled;
    FMixedDisabled: TWindowsXPThemeCheckBoxDisabled;
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
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

  TWindowsXPThemeGroupBox = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeButton = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

{ TWindowsXPThemeButton }

constructor TWindowsXPThemeButton.Create(Manager: TThemeManager);
var
  Part: TWindowsXPThemePart;
begin
  inherited;
  Part := TWindowsXPThemePushButton.Create(Self, nil, 'Button.PushButton');
  AddPart(BP_PUSHBUTTON, Part);
  Part := TWindowsXPThemeRadioButton.Create(Self, nil, 'Button.RadioButton');
  AddPart(BP_RADIOBUTTON, Part);
  Part := TWindowsXPThemeCheckBox.Create(Self, nil, 'Button.CheckBox');
  AddPart(BP_CHECKBOX, Part);
  Part := TWindowsXPThemeGroupBox.Create(Self, nil, 'Button.GroupBox');
  AddPart(BP_GROUPBOX, Part);
end;

{ TWindowsXPThemePushButtonDisabled }

function TWindowsXPThemePushButtonDisabled.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= PBS_NORMAL) and (StateID <= PBS_DEFAULTED) then
    Result := StateID - PBS_NORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemePushButton }

constructor TWindowsXPThemePushButton.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FDisabled := TWindowsXPThemePushButtonDisabled.Create(Theme, Self,
    'Button.PushButton(Disabled)');
end;

destructor TWindowsXPThemePushButton.Destroy;
begin
  FDisabled.Free;
  inherited;
end;

procedure TWindowsXPThemePushButton.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  if StateID = PBS_DISABLED then
    FDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect)
  else
    inherited;
end;

procedure TWindowsXPThemePushButton.DrawThemeText(DC: HDC;
  StateID: integer; Text: PWideChar; CharCount: integer; TextFlags,
  TextFlags2: cardinal; var Rect: TRect);
begin
  if StateID = PBS_DISABLED then
    FDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect)
  else
    inherited;
end;

function TWindowsXPThemePushButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= PBS_NORMAL) and (StateID <= PBS_DEFAULTED) then
    Result := StateID - PBS_NORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemeRadioButtonDisabled }

function TWindowsXPThemeRadioButtonDisabled.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= RBS_UNCHECKEDNORMAL) and (StateID <= RBS_CHECKEDDISABLED) then
    Result := StateID - RBS_UNCHECKEDNORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemeRadioButton }

constructor TWindowsXPThemeRadioButton.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FUncheckedDisabled := TWindowsXPThemeRadioButtonDisabled.Create(Theme,
    Self, 'Button.RadioButton(UncheckedDisabled)');
  FCheckedDisabled := TWindowsXPThemeRadioButtonDisabled.Create(Theme,
    Self, 'Button.RadioButton(CheckedDisabled)');
end;

destructor TWindowsXPThemeRadioButton.Destroy;
begin
  FCheckedDisabled.Free;
  FUncheckedDisabled.Free;
  inherited;
end;

procedure TWindowsXPThemeRadioButton.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  case StateID of
    RBS_UNCHECKEDDISABLED: FUncheckedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    RBS_CHECKEDDISABLED  : FCheckedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
  else
    inherited;
  end;
end;

procedure TWindowsXPThemeRadioButton.DrawThemeText(DC: HDC;
  StateID: integer; Text: PWideChar; CharCount: integer; TextFlags,
  TextFlags2: cardinal; var Rect: TRect);
begin
  case StateID of
    RBS_UNCHECKEDDISABLED: FUncheckedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    RBS_CHECKEDDISABLED  : FCheckedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
  else
    inherited;
  end;
end;

function TWindowsXPThemeRadioButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= RBS_UNCHECKEDNORMAL) and (StateID <= RBS_CHECKEDDISABLED) then
    Result := StateID - RBS_UNCHECKEDNORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemeCheckBoxDisabled }

function TWindowsXPThemeCheckBoxDisabled.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= CBS_UNCHECKEDNORMAL) and (StateID <= CBS_MIXEDDISABLED) then
    Result := StateID - CBS_UNCHECKEDNORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemeCheckBox }

constructor TWindowsXPThemeCheckBox.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FUncheckedDisabled := TWindowsXPThemeCheckBoxDisabled.Create(Theme,
    Self, 'Button.CheckBox(UncheckedDisabled)');
  FCheckedDisabled := TWindowsXPThemeCheckBoxDisabled.Create(Theme,
    Self, 'Button.CheckBox(CheckedDisabled)');
  FMixedDisabled := TWindowsXPThemeCheckBoxDisabled.Create(Theme,
    Self, 'Button.CheckBox(MixedDisabled)');
end;

destructor TWindowsXPThemeCheckBox.Destroy;
begin
  FMixedDisabled.Free;
  FCheckedDisabled.Free;
  FUncheckedDisabled.Free;
  inherited;
end;

procedure TWindowsXPThemeCheckBox.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  case StateID of
    CBS_UNCHECKEDDISABLED: FUncheckedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    CBS_CHECKEDDISABLED  : FCheckedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    CBS_MIXEDDISABLED    : FMixedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
  else
    inherited;
  end;
end;

procedure TWindowsXPThemeCheckBox.DrawThemeText(DC: HDC; StateID: integer;
  Text: PWideChar; CharCount: integer; TextFlags, TextFlags2: cardinal;
  var Rect: TRect);
begin
  case StateID of
    CBS_UNCHECKEDDISABLED: FUncheckedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    CBS_CHECKEDDISABLED  : FCheckedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    CBS_MIXEDDISABLED    : FMixedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
  else
    inherited;
  end;
end;

function TWindowsXPThemeCheckBox.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= CBS_UNCHECKEDNORMAL) and (StateID <= CBS_MIXEDDISABLED) then
    Result := StateID - CBS_UNCHECKEDNORMAL
  else
    Result := 0;
end;

{ TWindowsXPThemeGroupBox }

function TWindowsXPThemeGroupBox.GetStateRectIndex(StateID: integer): integer;
begin
  Result := 0;
end;

{$ENDIF}

end.
