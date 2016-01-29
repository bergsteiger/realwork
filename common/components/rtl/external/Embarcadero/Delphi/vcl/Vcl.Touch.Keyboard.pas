{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Touch.Keyboard;

interface

uses
  Vcl.Touch.KeyboardTypes, System.Generics.Collections, Vcl.Controls, System.Classes, Winapi.Messages, Winapi.Windows,
  Vcl.ExtCtrls, Vcl.Graphics, System.Types;

type
  TCustomTouchKeyboard = class;

  TCustomKeyboardButton = class
  public
    type
    {$SCOPEDENUMS ON}
      TDrawState = (dsNormal, dsPressed, dsDisabled);
    {$SCOPEDENUMS OFF}
  strict private
    FCaption: string;
    FState: TDrawState;
    FKey: TVirtualKey;
    FModifier: Boolean;
    FDown: Boolean;
    FID: Integer;
    FKeyImage: TKeyImage;

  private
    FBottomMargin: Integer;
    FTopMargin: Integer;
    FLeft: Integer;
    FTop: Integer;
    FHeight: Integer;
    FWidth: Integer;
    FParent: TCustomTouchKeyboard;

    procedure SetCaption(const Value: string);

  private
    procedure SetState(const Value: TDrawState; Delay: Boolean);
    function GetBoundsRect: TRect;
    procedure SetBoundsRect(const Value: TRect);
    function GetClientRect: TRect;
  public
    constructor Create(const AKey: TVirtualKey);

    procedure Paint(Canvas: TCustomCanvas = nil); virtual;

    property BottomMargin: Integer read FBottomMargin;
    property BoundsRect: TRect read GetBoundsRect write SetBoundsRect;
    property Caption: string read FCaption write SetCaption;
    property ClientRect: TRect read GetClientRect;
    property Down: Boolean read FDown write FDown;
    property Height: Integer read FHeight;
    property ID: Integer read FID write FID;
    property Key: TVirtualKey read FKey;
    property KeyImage: TKeyImage read FKeyImage write FKeyImage;
    property Left: Integer read FLeft;
    property Modifier: Boolean read FModifier write FModifier;
    property Parent: TCustomTouchKeyboard read FParent;
    property State: TDrawState read FState;
    property Top: Integer read FTop;
    property TopMargin: Integer read FTopMargin;
    property Width: Integer read FWidth;
  end;

  TKeyboardButton = class(TCustomKeyboardButton);
  TButtonList = class(TList<TCustomKeyboardButton>);
  TCustomKeyboardButtonClass = class of TCustomKeyboardButton;

  TKeyCaptions = class sealed
  public
    type
      TKeyCaption = record
        Name, Value, Language: string;
      end;

      TKeyCaptionArray = array of TKeyCaption;

    function KeyCaption(const AName, AValue, ALanguage: string): TKeyCaption;
  private
    FItems: TKeyCaptionArray;

    function GetCount: Integer;
    function GetItems(const Index: Integer): TKeyCaption;
    procedure SetItems(const Index: Integer; const Value: TKeyCaption);
  public
    function HasCaption(const AName: string; const ALanguage: string = ''): Boolean;
    procedure Clear;
    procedure Add(const AName, AValue: string; const ALanguage: string = '');
    procedure Delete(const AName: string; const ALanguage: string = '');
    function GetCaption(const AName: string; const ALanguage: string = ''): string;
    procedure SetCaption(const AName, AValue: string; const ALanguage: string = '');

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: TKeyCaption read GetItems write SetItems; default;
  end;

  TKeyboardLayouts = class sealed
  strict private
    class var FKeyboardLayouts: TVirtualKeyLayouts;

  private
    class constructor Create;
    class destructor Destroy;
    class function GetLayoutNames: TStringDynArray; static;
    class function GetCount: Integer; static;
    class function Find(const Layout, Language: string): TVirtualKeyLayout; overload;
    class function Find(const Layout: string): TVirtualKeyLayout; overload;
    class property Layouts: TVirtualKeyLayouts read FKeyboardLayouts;

  public
    class procedure LoadFromResourceName(const ResourceName: string);
    class procedure LoadFromStream(Stream: TStream);

    class property Count: Integer read GetCount;
    class property LayoutNames: TStringDynArray read GetLayoutNames;
  end;

  TCustomTouchKeyboard = class(TCustomControl)
  strict private
    type
      TChangeState = record
        Button: TCustomKeyboardButton;
        State: TCustomKeyboardButton.TDrawState;

        class function ChangeState(AButton: TCustomKeyboardButton;
          const AState: TCustomKeyboardButton.TDrawState): TChangeState; static;
      end;

      TChangeStates = class(TList<TChangeState>);
  public type
    {$SCOPEDENUMS ON}
    TDrawingStyle = (dsNormal, dsGradient);
    {$SCOPEDENUMS OFF}

  private
    FLayout: TKeyboardLayout;
    FCurrentLayout: TVirtualKeyLayout;
    FKeyCaptions: TKeyCaptions;
    FInitialized: Boolean;
    FLanguage: string;
    FChangeTimer: TTimer;
    FRepeat: TTimer;
    FRepeatDelay: Cardinal;
    FRepeatRate: Cardinal;
    FGradientEnd: TColor;
    FGradientStart: TColor;
    FDefaultButtonClass: TCustomKeyboardButtonClass;
    FChangeStates: TChangeStates;
    FDeadKey: TKeyData;
    FButtons: TButtonList;
    FUnclick: TButtonList;        // Keys that apply modifications to the current key.
    FPressedKeys: TButtonList;    // Keys that are currently held down.
    FDeadKeyUnclick: TButtonList; // Modification keys that apply to dead keys.
    FDrawingStyle: TDrawingStyle;

    procedure ToggleKeys(AButton: TCustomKeyboardButton; KeyState: TKeyState; Immediate: Boolean = False);
    procedure OnRepeat(Sender: TObject);
    procedure OnChange(Sender: TObject);
    procedure KeyClick(Button: TCustomKeyboardButton);
    function GetShiftState(const VirtualKey: TVirtualKey): TModifierState;
    procedure ProcessKeyPress(const Msg: TWmMouse; ID: Integer);
    function GetModifiedKey(const Key: TVirtualKey; const Language: string): TKey;
    function GetLanguageKey(const Key: TVirtualKey; const Language: string): TVirtualKey;
    procedure SetLayout(const Value: TKeyboardLayout);
    procedure ReadCustomCaptionOverrides(Stream: TStream);
    procedure WriteCustomCaptionOverrides(Stream: TStream);
    procedure AddChangeState(Button: TCustomKeyboardButton; const State: TCustomKeyboardButton.TDrawState);
    function GetOverrideCaption(const Key: TVirtualKey; var Caption: string): Boolean;
    procedure SetGradientEnd(const Value: TColor);
    procedure SetGradientStart(const Value: TColor);
    function GetPrimaryLanguage(const Language: string): string;
    function GetCurrentInputLanguage: string;
    procedure WMInputLangChange(var Message: TMessage); message CM_INPUTLANGCHANGE;
    procedure WMTouch(var Message: TMessage); message WM_TOUCH;
    function GetButtons(Index: Integer): TCustomKeyboardButton;
    procedure SetDrawingStyle(const Value: TDrawingStyle);
  protected
    procedure DestroyWnd; override;
    procedure Paint; override;
    procedure Resize; override;
    procedure SetEnabled(Value: Boolean); override;
    function GetPropertyNames: TStringDynArray;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateWnd; override;
    procedure DefineProperties(Filer: TFiler); override;
    function CreateKeyboard(const Language: string = ''): Boolean;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    property Buttons[Index: Integer]: TCustomKeyboardButton read GetButtons;
    function ButtonsCount: Integer;
    procedure ClearState;
    procedure UpdateCaptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Redraw;

    property CaptionOverrides: TKeyCaptions read FKeyCaptions;
    property DefaultButtonClass: TCustomKeyboardButtonClass read FDefaultButtonClass write FDefaultButtonClass;
  public
    property DrawingStyle: TDrawingStyle read FDrawingStyle write SetDrawingStyle default TDrawingStyle.dsNormal;
    property GradientEnd: TColor read FGradientEnd write SetGradientEnd default clDkGray;
    property GradientStart: TColor read FGradientStart write SetGradientStart default clLtGray;
    property Layout: TKeyboardLayout read FLayout write SetLayout;
    property RepeatRate: Cardinal read FRepeatRate write FRepeatRate default 50;
    property RepeatDelay: Cardinal read FRepeatDelay write FRepeatDelay default 300;
  end;

  TTouchKeyboard = class(TCustomTouchKeyboard)
  published
    property Anchors;
    property Align;
    property Color;
    property DrawingStyle;
    property Enabled;
    property GradientEnd;
    property GradientStart;
    property Height;
    property Left;
    property Layout;
    property ParentColor;
    property ParentShowHint;
    property RepeatRate;
    property RepeatDelay;
    property ShowHint;
    property Top;
    property Tag;
    property Width;
    property Visible;
  end;

procedure SendKeys(const Keys: array of TKeyData); overload;
procedure SendKeys(const Keys: array of TKeyData; KeyState: TKeyState); overload;
procedure SendKey(const Key: TKeyData; KeyState: TKeyState);

implementation

uses
  System.SysUtils, Vcl.GraphUtil, Winapi.UxTheme, Vcl.Consts;

{$R KeyboardLayouts.res}

type
  TState = class(TList<TKeyData>);

var
  GlobalKeyboardLayouts: TVirtualKeyLayouts;

procedure SendKeys(const Keys: array of TKeyData);

  function GetState(const Key: TKeyData; State: TState): Integer;
  var
    Index: Integer;
  begin
    Result := 0;

    for Index := 0 to State.Count - 1 do
    begin
      if (State[Index].Vk = Key.Vk) and (State[Index].ScanCode = Key.ScanCode) then
      begin
        Result := KEYEVENTF_KEYUP;
        State.Delete(Index);
        Break;
      end;
    end;
  end;

var
  Index: Integer;
  State: TState;
  Key: TKeyData;
begin
  State := TState.Create;

  try
    for Index := 0 to Length(Keys) - 1 do
    begin
      Key := Keys[Index];

      if GetState(Key, State) = 0 then
      begin
        SendKey(Key, ksDown);
        State.Add(Key);
      end
      else
        SendKey(Key, ksUp);
    end;
  finally
    State.Free;
  end;
end;

procedure SendKeys(const Keys: array of TKeyData; KeyState: TKeyState);
var
  Index: Integer;
  Key: TKeyData;
begin
  for Index := 0 to Length(Keys) - 1 do
  begin
    Key := Keys[Index];
    SendKey(Key, KeyState);
  end;
end;

procedure SendKey(const Key: TKeyData; KeyState: TKeyState);
var
  KeyFlag: Integer;
  LKey: TKeyData;
  Msg: UINT;
begin
  LKey := GetVirtualKey(Key);

  case LKey.Vk of
    VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN:
    begin
      if KeyState = ksDown then
        Msg := WM_KEYDOWN
      else
        Msg := WM_KEYUP;

      SendMessage(GetFocus, Msg, LKey.Vk, 0);
    end
    else
    begin
      if KeyState = ksDown then
        KeyFlag := 0
      else
        KeyFlag := KEYEVENTF_KEYUP;

      keybd_event(LKey.Vk, LKey.ScanCode, KeyFlag, 0);
    end;
  end;
end;

procedure PlayKey(const Key: TKey; KeyState: TKeyState);
begin
  if Length(Key.ComboKeys) > 0 then
    SendKeys(Key.ComboKeys, KeyState)
  else
    SendKey(Key, KeyState);
end;

function TouchInputToWmMouse(Control: TWinControl; const TouchInput: TouchInput): TWMMouse;
var
  P: TPoint;
begin
  Result.Msg := WM_NULL;
  if (TouchInput.dwFlags and TOUCHEVENTF_DOWN <> 0) then
    Result.Msg := WM_LBUTTONDOWN
  else if (TouchInput.dwFlags and TOUCHEVENTF_UP <> 0) then
    Result.Msg := WM_LBUTTONUP
  else if (TouchInput.dwFlags and TOUCHEVENTF_MOVE <> 0) then
    Result.Msg := WM_MOUSEMOVE;

  P := Point(TouchInput.X div 100, TouchInput.Y div 100);
  PhysicalToLogicalPoint(Control.Handle, P);
  Result.Pos := PointToSmallPoint(Control.ScreenToClient(P));
end;

{ TCustomKeyboardButton }

function TCustomKeyboardButton.GetBoundsRect: TRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Right := Left + Width;
  Result.Bottom := Top + Height;
end;

function TCustomKeyboardButton.GetClientRect: TRect;
begin
  Result.Left := Left + Key.LeftMargin;
  Result.Top := Top + TopMargin;
  Result.Right := Left + Width - Key.RightMargin;
  Result.Bottom := Top + Height - BottomMargin;
end;

constructor TCustomKeyboardButton.Create(const AKey: TVirtualKey);
begin
  inherited Create;
  FState := TDrawState.dsNormal;
  FHeight := 45;
  FWidth := 45;
  FModifier := False;
  FID := -1;
  FKey := AKey;
  FKeyImage := AKey.KeyImage;
end;

procedure TCustomKeyboardButton.Paint(Canvas: TCustomCanvas);
const
  ICON_TOP_OFFSET = 8;
  ICON_LEFT_OFFSET = 4;

  procedure PaintTab(Canvas: TCustomCanvas; Rect: TRect);
  const
    ICON_WIDTH = 36;
    ICON_HEIGHT = 12;
  begin
    // Top line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + ICON_TOP_OFFSET);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_TOP_OFFSET);

    // Top vertical line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + ICON_TOP_OFFSET - 5);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + ICON_TOP_OFFSET + 5);

    // Top arrow
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + 2, Rect.Top + ICON_TOP_OFFSET - 1);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 2, Rect.Top + ICON_TOP_OFFSET + 2);
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + 3, Rect.Top + ICON_TOP_OFFSET - 2);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 3, Rect.Top + ICON_TOP_OFFSET + 3);

    // Bottom line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + ICON_TOP_OFFSET + ICON_HEIGHT);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH + 1, Rect.Top + ICON_TOP_OFFSET + ICON_HEIGHT);

    // Bottom vertical line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_TOP_OFFSET + ICON_HEIGHT - 5);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_TOP_OFFSET + ICON_HEIGHT + 5);

    // Bottom arrow
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH - 2, Rect.Top + ICON_TOP_OFFSET + ICON_HEIGHT - 1);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH - 2, Rect.Top + ICON_TOP_OFFSET + ICON_HEIGHT + 2);
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH - 3, Rect.Top + ICON_TOP_OFFSET + ICON_HEIGHT - 2);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH - 3, Rect.Top + ICON_TOP_OFFSET + ICON_HEIGHT + 3);
  end;

  procedure PaintEnter(Canvas: TCustomCanvas; Rect: TRect);
  const
    ICON_WIDTH = 36;
    ICON_HEIGHT = 12;
  begin
    // Horizontal line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_HEIGHT - 6);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_HEIGHT + 1);

    // Vertical line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + ICON_HEIGHT);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_HEIGHT);

    // Arrow
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + 1, Rect.Top + ICON_HEIGHT - 1);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 1, Rect.Top + ICON_HEIGHT + 2);
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + 2, Rect.Top + ICON_HEIGHT - 2);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 2, Rect.Top + ICON_HEIGHT + 3);
  end;

  procedure PaintTallEnter(Canvas: TCustomCanvas; Rect: TRect);
  const
    ICON_WIDTH = 24;
    ICON_HEIGHT = 12;
  begin
    // Horizontal line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_HEIGHT - 6);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_HEIGHT + 1);

    // Vertical line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + ICON_HEIGHT);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_HEIGHT);

    // Arrow
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + 1, Rect.Top + ICON_HEIGHT - 1);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 1, Rect.Top + ICON_HEIGHT + 2);
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + 2, Rect.Top + ICON_HEIGHT - 2);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 2, Rect.Top + ICON_HEIGHT + 3);
  end;

  procedure PaintBackspace(Canvas: TCustomCanvas; Rect: TRect);
  const
    ICON_WIDTH = 24;
    ICON_HEIGHT = 24;
  begin
    // Vertical line
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + ICON_TOP_OFFSET);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + ICON_WIDTH, Rect.Top + ICON_TOP_OFFSET);

    // Arrow
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + 1, Rect.Top + ICON_TOP_OFFSET - 1);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 1, Rect.Top + ICON_TOP_OFFSET + 2);
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET + 2, Rect.Top + ICON_TOP_OFFSET - 2);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 2, Rect.Top + ICON_TOP_OFFSET + 3);
  end;

  procedure PaintShift(Canvas: TCustomCanvas; Rect: TRect);
  begin
    Canvas.MoveTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + 4 + 12);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 10, Rect.Top + 6);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 20, Rect.Top + 4 + 12);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 14, Rect.Top + 4 + 12);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 14, Rect.Top + 4 + 18);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 6, Rect.Top + 4 + 18);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET + 6, Rect.Top + 4 + 12);
    Canvas.LineTo(Rect.Left + ICON_LEFT_OFFSET, Rect.Top + 4 + 12);
  end;

  procedure PaintArrow(Canvas: TCustomCanvas; Rect: TRect; Direction: TKeyImage);
  const
    ICON_WIDTH = 8;
    ICON_HEIGHT = 8;
  var
    X, Y: Integer;
  begin
    X := (Rect.Left + Rect.Right) div 2;
    Y := (Rect.Top + Rect.Bottom) div 2;

    case Direction of
      kiUp:
      begin
        // Vertical line
        Canvas.MoveTo(X, Y - ICON_HEIGHT);
        Canvas.LineTo(X, Y + ICON_HEIGHT);

        // Arrow
        Canvas.MoveTo(X - 1, Y - 7);
        Canvas.LineTo(X + 2, Y - 7);
        Canvas.MoveTo(X - 2, Y - 6);
        Canvas.LineTo(X + 3, Y - 6);
      end;
      kiDown:
      begin
        // Vertical line
        Canvas.MoveTo(X, Y - ICON_HEIGHT);
        Canvas.LineTo(X, Y + ICON_HEIGHT);

        // Arrow
        Canvas.MoveTo(X - 1, Y + 6);
        Canvas.LineTo(X + 2, Y + 6);
        Canvas.MoveTo(X - 2, Y + 5);
        Canvas.LineTo(X + 3, Y + 5);
      end;
      kiLeft:
      begin
        // Vertical line
        Canvas.MoveTo(X - ICON_WIDTH, Y);
        Canvas.LineTo(X + ICON_WIDTH, Y);

        // Arrow
        Canvas.MoveTo(X - 6, Y - 1);
        Canvas.LineTo(X - 6, Y + 2);
        Canvas.MoveTo(X - 5, Y - 2);
        Canvas.LineTo(X - 5, Y + 3);
      end;
      kiRight:
      begin
        // Vertical line
        Canvas.MoveTo(X - ICON_WIDTH, Y);
        Canvas.LineTo(X + ICON_WIDTH, Y);

        // Arrow
        Canvas.MoveTo(X + 6, Y - 1);
        Canvas.LineTo(X + 6, Y + 2);
        Canvas.MoveTo(X + 5, Y - 2);
        Canvas.LineTo(X + 5, Y + 3);
      end;
    end;
  end;

  function GetModifier(const Key: TVirtualKey; var Value: TKeyModifier): Boolean;
  var
    Index, UnclickIndex: Integer;
    Modifier: TKeyModifier;
  begin
    Result := False;

    if FParent = nil then
      Exit;

    for Index := 0 to Length(Key.Modifiers) - 1 do
    begin
      Modifier := Key.Modifiers[Index];

      for UnclickIndex := 0 to FParent.FUnclick.Count - 1 do
      begin
        if Modifier.ModifierName = Fparent.FUnclick[UnclickIndex].Key.ModifierName then
        begin
          Value := Modifier;
          Result := True;
          Break;
        end;
      end;
    end;
  end;

const
  Rounding = 5;
  OuterEdgeColors: array[TDrawState] of TColor = (clBlack, clCream, clCream);
  InnerEdgeColors: array[TDrawState] of TColor = (clGray, clDkGray, clGray);
  BkStartColors: array[TDrawState] of TColor = (clDkGray, clCream, clGray);
  BkEndColors: array[TDrawState] of TColor = (clBlack, clLtGray, clCream);
  TextColors: array[TDrawState] of TColor = (clWhite, clBlack, clGray);
var
  LRgn: HRGN;
  LRect: TRect;
  LCanvas: TCanvas;
  LCaption: string;
  Modifier: TKeyModifier;
begin
  if Canvas <> nil then
    LCanvas := Canvas as TCanvas
  else
    LCanvas := Parent.Canvas;
  LRect := ClientRect;
  Inc(LRect.Right, 1);
  Inc(LRect.Bottom, 1);
  LRgn := CreateRoundRectRgn(LRect.Left, LRect.Top, LRect.Right, LRect.Bottom,
    Rounding, Rounding);
  if LRgn = 0 then
    Exit;
  try
    if SelectClipRgn(LCanvas.Handle, LRgn) = ERROR then
      Exit;
    try
      GradientFillCanvas(LCanvas, BkStartColors[FState],
        BkEndColors[FState], LRect, gdVertical);

      LCanvas.Brush.Style := bsClear;
      LCanvas.Pen.Color := OuterEdgeColors[FState];
      Dec(LRect.Right, 1);
      Dec(LRect.Bottom, 1);
      LCanvas.RoundRect(LRect, Rounding, Rounding);

      LCanvas.Pen.Color := InnerEdgeColors[FState];
      LCanvas.Brush.Style := bsClear;
      InflateRect(LRect, -1, -1);
      LCanvas.RoundRect(LRect, Rounding - 1, Rounding - 1);

      LCanvas.Pen.Color := TextColors[FState];

      LCanvas.Font.Color := TextColors[FState];
      if GetModifier(Key, Modifier) then
        LCanvas.Font.Size := Modifier.FontSize
      else
        LCanvas.Font.Size := Key.FontSize;

      case KeyImage of
        kiOverride:
        begin
          if not Parent.GetOverrideCaption(Key, LCaption) then
            LCaption := Caption;
          LCanvas.TextOut(LRect.Left + 4, LRect.Top + 4, LCaption);
        end;
        kiText: LCanvas.TextOut(LRect.Left + 4, LRect.Top + 4, Caption);
        kiTab: PaintTab(LCanvas, LRect);
        kiShift: PaintShift(LCanvas, LRect);
        kiEnter: PaintEnter(LCanvas, LRect);
        kiBackspace: PaintBackspace(LCanvas, LRect);
        kiUp, kiDown,kiLeft, kiRight: PaintArrow(LCanvas, LRect, KeyImage);
        kiTallEnter: PaintTallEnter(LCanvas, LRect);
      end;
    finally
      SelectClipRgn(LCanvas.Handle, 0);
    end;
  finally
    DeleteObject(LRgn);
  end;
end;

procedure TCustomKeyboardButton.SetBoundsRect(const Value: TRect);
begin
  FTop := Value.Top;
  FLeft := Value.Left;
  FWidth := Value.Right;
  FHeight := Value.Bottom;
end;

procedure TCustomKeyboardButton.SetCaption(const Value: string);
begin
  if Value <> FCaption then
    FCaption := Value;
end;

procedure TCustomKeyboardButton.SetState(const Value: TDrawState; Delay: Boolean);
begin
  case Value of
    TDrawState.dsNormal:
    begin
      if Delay and (Parent <> nil) then
        Parent.AddChangeState(Self, Value)
      else
        FState := Value;
    end;
    TDrawState.dsPressed, TDrawState.dsDisabled: FState := Value;
  end;
end;

{ TCustomTouchKeyboard }

procedure TCustomTouchKeyboard.AddChangeState(Button: TCustomKeyboardButton;
  const State: TCustomKeyboardButton.TDrawState);
begin
  FChangeStates.Add(TChangeState.ChangeState(Button, State));
  FChangeTimer.Enabled := True;
end;

function TCustomTouchKeyboard.ButtonsCount: Integer;
begin
  Result := FButtons.Count;
end;

procedure TCustomTouchKeyboard.ClearState;
var
  Index: Integer;
  Button: TCustomKeyboardButton;
begin
  FDeadKey := VKey(-1, -1);
  FUnclick.Clear;
  FDeadKeyUnclick.Clear;

  for Index := 0 to FPressedKeys.Count - 1 do
  begin
    Button := FPressedKeys[Index];
    Button.Down := False;
    Button.SetState(TCustomKeyboardButton.TDrawState.dsNormal, False);

    if Button.Modifier then
      PlayKey(GetLanguageKey(Button.Key, FLanguage), ksUp);
  end;

  FPressedKeys.Clear;
end;

constructor TCustomTouchKeyboard.Create(AOwner: TComponent);
begin
  inherited;
  FRepeatDelay := 300;
  FRepeatRate := 50;
  FLayout := 'Standard';
  FUnclick := TButtonList.Create;
  FPressedKeys := TButtonList.Create;
  FDeadKeyUnclick := TButtonList.Create;
  FButtons := TButtonList.Create;
  FDeadKey := VKey(-1, -1);
  BevelOuter := bvNone;
  FInitialized := False;
  FRepeat := TTimer.Create(Self);
  FRepeat.Enabled := False;
  FRepeat.OnTimer := OnRepeat;
  FLanguage := GetCurrentInputLanguage;
  DoubleBuffered := False;
  ParentDoubleBuffered := False;
  Touch.TabletOptions := [];
  FDefaultButtonClass := TKeyboardButton;
  FKeyCaptions := TKeyCaptions.Create;
  FChangeStates := TChangeStates.Create;
  FChangeTimer := TTimer.Create(Self);
  FChangeTimer.Enabled := False;
  FChangeTimer.OnTimer := OnChange;
  FChangeTimer.Interval := 100;
  FGradientEnd := clLtGray;
  FGradientStart := clDkGray;
  ControlStyle := ControlStyle - [csGestures];
  FDrawingStyle := TDrawingStyle.dsNormal;
end;

procedure TCustomTouchKeyboard.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('CustomCaptionOverrides', ReadCustomCaptionOverrides,
    WriteCustomCaptionOverrides, CaptionOverrides.Count > 0); // do not localize
end;

function TCustomTouchKeyboard.CreateKeyboard(const Language: string): Boolean;
var
  Index, RowIndex, ColIndex: Integer;
  Button: TCustomKeyboardButton;
  LeftPosition, TopPosition: Integer;
  KeyboardState: TKeyboardState;
  KeyboardLayout: TVirtualKeyLayout;
  Row: TVirtualKeys;
  FoundCaps: Boolean;
begin
  Result := False;
  FoundCaps := False;
  for Index := 0 to FButtons.Count - 1 do
    FButtons[Index].Free;
  FButtons.Clear;
  FDeadKey := VKey(-1, -1);
  TopPosition := 0;

  if Language <> '' then
    FLanguage := Language;

  KeyboardLayout := TKeyboardLayouts.Find(Layout, Language);
  if KeyboardLayout = nil then
    KeyboardLayout := TKeyboardLayouts.Find(Layout, GetPrimaryLanguage(Language));
  if KeyboardLayout = nil then
    KeyboardLayout := TKeyboardLayouts.Find(Layout);
  if KeyboardLayout = nil then Exit;
  FCurrentLayout := KeyboardLayout;
  for RowIndex := 0 to KeyboardLayout.Keys.Count - 1 do
  begin
    LeftPosition := 0;
    Row := KeyboardLayout.Keys[RowIndex];

    for ColIndex := 0 to Row.Count - 1 do
    begin
      Button := DefaultButtonClass.Create(Row[ColIndex]);
      Button.FParent := Self;
      Button.FTopMargin := Row.TopMargin;
      Button.FBottomMargin := Row.BottomMargin;
      Button.BoundsRect := Rect(LeftPosition, TopPosition,
        Button.Key.Width, Button.Key.Height);
      FButtons.Add(Button);

      if Button.Key.ModifierName <> '' then
      begin
        Button.Modifier := True;

        // Special case for Caps Lock where the state is checked.
        if ((Button.Key.Vk = VK_CAPITAL) or (Button.Key.ScanCode = 58)) then
        begin
          ZeroMemory(@KeyboardState[0], Length(KeyboardState));
          GetKeyboardState(KeyboardState);
          if KeyboardState[VK_CAPITAL] = 1 then
          begin
            FoundCaps := True;
            Button.Down := True;
            Button.SetState(TCustomKeyboardButton.TDrawState.dsPressed, False);
            FPressedKeys.Add(Button);
            FUnclick.Add(Button);
          end;
        end;
      end;

      Inc(LeftPosition, Button.Width);
    end;

    Inc(TopPosition, KeyboardLayout.RowHeight);
  end;

  Constraints.MinWidth := KeyboardLayout.MinWidth;
  Constraints.MinHeight := KeyboardLayout.MinHeight;
  Constraints.MaxWidth := KeyboardLayout.MaxWidth;
  Constraints.MaxHeight := KeyboardLayout.MaxHeight;
  Resize;
  Result := True;

  if FoundCaps then
    UpdateCaptions;
end;

procedure TCustomTouchKeyboard.CreateWnd;
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    if not FInitialized and TOSVersion.Check(6, 1) and RegisterTouchWindow(Handle, 0) then
        FInitialized := True;
    CreateKeyboard(FLanguage);
    Redraw;
  end;
end;

destructor TCustomTouchKeyboard.Destroy;
var
  Index: Integer;
  Button: TCustomKeyboardButton;
begin
  for Index := 0 to FUnclick.Count - 1 do
  begin
    Button := FUnclick[Index];

    case Button.Key.ScanCode of
      29: SendKey(VKey(-1, 29), ksUp);
      42: SendKey(VKey(-1, 42), ksUp);
      56: SendKey(VKey(-1, 56), ksUp);
      else
      begin
        if Button.Key.Caption = 'AltGr' then
        begin
          SendKey(VKey(-1, 56), ksUp);
          SendKey(VKey(-1, 29), ksUp);
        end;
      end;
    end;
  end;

  FUnclick.Free;
  FPressedKeys.Free;
  FDeadKeyUnclick.Free;
  for Index := 0 to FButtons.Count - 1 do
    FButtons[Index].Free;
  FButtons.Free;
  FRepeat.Free;
  FKeyCaptions.Free;
  FChangeStates.Free;
  FChangeTimer.Free;
  inherited;
end;

procedure TCustomTouchKeyboard.DestroyWnd;
begin
  if FInitialized then
  begin
    UnregisterTouchWindow(Handle);
    FInitialized := False;
  end;
  inherited;
end;

procedure TCustomTouchKeyboard.SetDrawingStyle(const Value: TDrawingStyle);
begin
  if Value <> FDrawingStyle then
  begin
    FDrawingStyle := Value;
    Invalidate;
  end;
end;

procedure TCustomTouchKeyboard.SetEnabled(Value: Boolean);
var
  Index: Integer;
  DrawState: TCustomKeyboardButton.TDrawState;
begin
  inherited;

  if Value then
    DrawState := TCustomKeyboardButton.TDrawState.dsNormal
  else
    DrawState := TCustomKeyboardButton.TDrawState.dsDisabled;

  for Index := 0 to FButtons.Count - 1 do
    FButtons[Index].SetState(DrawState, True);
end;

procedure TCustomTouchKeyboard.SetGradientEnd(const Value: TColor);
begin
  FGradientEnd := Value;
  Invalidate;
end;

procedure TCustomTouchKeyboard.SetGradientStart(const Value: TColor);
begin
  FGradientStart := Value;
  Invalidate;
end;

procedure TCustomTouchKeyboard.SetLayout(const Value: TKeyboardLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    if not (csLoading in ComponentState) then
    begin
      CreateKeyboard(FLanguage);
      Redraw;
    end;
  end;
end;

function TCustomTouchKeyboard.GetButtons(Index: Integer): TCustomKeyboardButton;
begin
  Result := FButtons[Index];
end;

function TCustomTouchKeyboard.GetCurrentInputLanguage: string;
var
  LocaleID: cardinal;
  Size: Integer;
  Success: Boolean;
  Layout: HKL;
  SubLanguage, PrimaryLanguage: string;
begin
  Success := False;

  Layout := GetKeyboardLayout(0);
  LocaleID := LoWord(Layout);

  Size := GetLocaleInfo(LocaleID, LOCALE_SISO639LANGNAME, nil, 0);
  SetLength(PrimaryLanguage, Size);
  if GetLocaleInfo(LocaleID, LOCALE_SISO639LANGNAME, @PrimaryLanguage[1], Size) <> 0 then
  begin
    SetLength(PrimaryLanguage, Size - 1);
    Size := GetLocaleInfo(LocaleID, LOCALE_SISO3166CTRYNAME, nil, 0);
    SetLength(SubLanguage, Size);
    if GetLocaleInfo(LocaleID, LOCALE_SISO3166CTRYNAME, @SubLanguage[1], Size) <> 0 then
    begin
      SetLength(SubLanguage, Size - 1);
      Result := Format('%s-%s', [PrimaryLanguage, SubLanguage]);
      Success := True;
    end;
  end;

  if not Success then
    raise Exception.CreateRes(@SKeyboardLocaleInfo);
end;

// Returns a key that has taken all the modified keys, languages and
// overrides into account.
function TCustomTouchKeyboard.GetModifiedKey(const Key: TVirtualKey; const Language: string): TKey;

  function GetLanguageModifier(const Key: TVirtualKey; const Languages: TKeyLanguages;
    const Language: string; var Value: TKey): Boolean;
  var
    Index: Integer;
    KeyLanguage: TKeyLanguage;
  begin
    Result := False;

    for Index := 0 to Length(Languages) - 1 do
    begin
      KeyLanguage := Languages[Index];

      if KeyLanguage.Language = Language then
      begin
        if KeyLanguage.Caption = '' then
          Value.Caption := Key.Caption
        else
          Value.Caption := KeyLanguage.Caption;

        if KeyLanguage.KeyImage <> kiText then
          Value.KeyImage := Key.KeyImage
        else
          Value.KeyImage := KeyLanguage.KeyImage;

        if Length(KeyLanguage.ComboKeys) > 0 then
        begin
          Value.ComboKeys := KeyLanguage.ComboKeys;
          Value.ScanCode := -1;
          Value.Vk := -1;
        end
        else
        begin
          if KeyLanguage.Vk <> -1 then
            Value.Vk := KeyLanguage.Vk
          else
            Value.Vk := Key.Vk;

          if KeyLanguage.ScanCode <> -1 then
            Value.ScanCode := KeyLanguage.ScanCode
          else
            Value.ScanCode := Key.ScanCode;
        end;

        Result := True;
        Break;
      end;
    end;
  end;

  function GetModifier(const Key: TVirtualKey; const Keys: TButtonList; Modifier: TKeyModifier;
    const Language: string; var Value: TKey): Boolean;
  var
    Index: Integer;
  begin
    Result := False;

    for Index := 0 to Keys.Count - 1 do
    begin
      if (Modifier.ModifierName = Keys[Index].Key.ModifierName) and
        ((Modifier.Language = '') or (Modifier.Language = FLanguage) or
        (Modifier.Language = GetPrimaryLanguage(FLanguage))) then
      begin
        if GetLanguageModifier(Key, Modifier.Languages, FLanguage, Value) or
          GetLanguageModifier(Key, Modifier.Languages, GetPrimaryLanguage(FLanguage), Value) then
        begin
          Result := True;
          Break;
        end;

        Value := Modifier;
        Result := True;
        Break;
      end;
    end;
  end;

var
  Index: Integer;
  Modifier: TKeyModifier;
  LKey: TVirtualKey;
begin
  LKey := GetLanguageKey(Key, Language);

  try
    for Index := 0 to Length(Key.Modifiers) - 1 do
    begin
      Modifier := LKey.Modifiers[Index];
      if GetModifier(LKey, FUnclick, Modifier, Language, Result) then
        Exit;
    end;

    if GetLanguageModifier(LKey, Key.Languages, Language, Result) then
      Exit
    else if GetLanguageModifier(LKey, LKey.Languages, GetPrimaryLanguage(Language), Result) then
      Exit;

    Result := LKey;
  finally
    if (LKey.PublishedName <> '') and GetOverrideCaption(LKey, Result.Caption) then
      Result.KeyImage := kiOverride;
  end;
end;

function TCustomTouchKeyboard.GetLanguageKey(const Key: TVirtualKey;
  const Language: string): TVirtualKey;

  function InternalGetLanguageKey(var Key: TVirtualKey; const Language: string): Boolean;
  var
    Index: Integer;
    KeyLanguage: TKeyLanguage;
  begin
    Result := False;
    for Index := 0 to Length(Key.Languages) - 1 do
    begin
      KeyLanguage := Key.Languages[Index];

      if KeyLanguage.Language = Language then
      begin
        if KeyLanguage.Caption <> '' then
        begin
          Key.Caption := KeyLanguage.Caption;
          KeyLanguage.KeyImage := kiText;
        end;

        if Length(KeyLanguage.ComboKeys) > 0 then
        begin
          Key.ComboKeys := KeyLanguage.ComboKeys;
          Key.Vk := -1;
          Key.ScanCode := -1;
        end
        else
        begin
          if KeyLanguage.Vk <> -1 then
            Key.Vk := KeyLanguage.Vk;
          if KeyLanguage.ScanCode <> -1 then
            Key.ScanCode := KeyLanguage.ScanCode;
        end;

        Result := True;
        Break;
      end;
    end;
  end;

begin
  Result := Key;
  if not InternalGetLanguageKey(Result, Language) then
    InternalGetLanguageKey(Result, GetPrimaryLanguage(Language));
end;

function TCustomTouchKeyboard.GetPrimaryLanguage(const Language: string): string;
var
  P: PChar;
begin
  Result := '';
  P := @Language[1];
  while P^ <> #0 do
  begin
    case P^ of
      '-': Break;
    end;
    Result := Result + P^;
    Inc(P);
  end;
end;

function TCustomTouchKeyboard.GetPropertyNames: TStringDynArray;
var
  Index: Integer;
  Button: TCustomKeyboardButton;
begin
  for Index := 0 to FButtons.Count - 1 do
  begin
    Button := FButtons[Index];
    if Button.Key.PublishedName <> '' then
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1] := Button.Key.PublishedName;
    end;
  end;
end;

function TCustomTouchKeyboard.GetShiftState(const VirtualKey: TVirtualKey): TModifierState;
var
  Index, ModifierIndex: Integer;
  Button: TCustomKeyboardButton;
  Modifier: TKeyModifier;
  FoundCaps, FoundShift: Boolean;
begin
  Result := [];
  FoundCaps := False;
  FoundShift := False;

  for Index := 0 to FUnclick.Count - 1 do
  begin
    Button := FUnclick[Index];

    case Button.Key.ScanCode of
      54 {Right Shift}, 42 {Left Shift}:
      begin
        FoundShift := True;
        Include(Result, msShift);
      end;
      285 {Right CTRL}, 29 {Left CTRL}: Include(Result, msCtrl);
      312 {Right ALT}, 56 {Left ALT}: Include(Result, msAlt);
    end;

    case VirtualKey.Vk of
      VK_SHIFT:
      begin
        FoundShift := True;
        Include(Result, msShift);
      end;
      VK_CONTROL: Include(Result, msCtrl);
      VK_MENU: Include(Result, msAlt);
    end;

    if (Button.Key.Vk = VK_CAPITAL) or (Button.Key.ScanCode = 58) then
    begin
      for ModifierIndex := 0 to Length(VirtualKey.Modifiers) - 1 do
      begin
        Modifier := VirtualKey.Modifiers[ModifierIndex];
        if (Button.Key.ModifierName = Modifier.ModifierName) and
          ((Modifier.Language = '') or (Modifier.Language = FLanguage) or
          (Modifier.Language = GetPrimaryLanguage(FLanguage))) then
        begin
          FoundCaps := True;
          Include(Result, msShift);
          Break;
        end;
      end;
    end;
  end;

  if FoundShift and FoundCaps then
    Exclude(Result, msShift);
end;

procedure TCustomTouchKeyboard.ReadCustomCaptionOverrides(Stream: TStream);

  function ReadInteger: Integer;
  begin
    Stream.Read(Result, SizeOf(Result));
  end;

  function ReadString: string;
  var
    Count: Byte;
    Bytes: TBytes;
  begin
    Stream.Read(Count, SizeOf(Count));
    if Count > 0 then
    begin
      SetLength(Bytes, Count);
      ZeroMemory(@Bytes[0], Length(Bytes));
      Stream.Read(Bytes[0], Count);
      Result := TEncoding.Unicode.GetString(Bytes);
    end
    else
      Result := '';
  end;

var
  Index: Integer;
  Count, ItemCount: Integer;
  Name, Value, Language: string;
begin
  ReadInteger; // Version
  Count := ReadInteger;
  for Index := 0 to Count - 1 do
  begin
    ItemCount := ReadInteger;
    Name := ReadString;
    Value := ReadString;

    if ItemCount = 3 then
      Language := ReadString;

    CaptionOverrides.Add(Name, Value, Language);
  end;
end;

procedure TCustomTouchKeyboard.Redraw;
begin
  UpdateCaptions;
  Paint;
end;

procedure TCustomTouchKeyboard.Resize;
var
  Index: Integer;
  Button: TCustomKeyboardButton;
  WidthLeftoverIndex: Integer;
  WidthLeftover: array of Integer;
  OriginalWidthsIndex: Integer;
  OriginalWidths: array of Integer;
  RowCount, ButtonHeight, Row, TopRemainder, TopPosition: Integer;
  TallButton: TCustomKeyboardButton;
begin
  if FCurrentLayout = nil then Exit;

  // Resize all non-stretchy buttons.
  WidthLeftoverIndex := -1;
  // Find the widths of all stretchy buttons on each row. Store them in
  // the array OriginalWidths.
  OriginalWidthsIndex := -1;

  for Index := 0 to FButtons.Count - 1 do
  begin
    Button := FButtons[Index];

    if Button.Left = 0 then
    begin
      Inc(WidthLeftoverIndex);
      SetLength(WidthLeftover, Length(WidthLeftover) + 1);
      WidthLeftover[WidthLeftoverIndex] := Width + 1;
      Inc(OriginalWidthsIndex);
      SetLength(OriginalWidths, Length(OriginalWidths) + 1);
    end;

    if kfStretch in Button.Key.Flags then
      Inc(OriginalWidths[OriginalWidthsIndex], Button.Key.Width)
    else
    begin
      Button.FWidth := (Button.Key.Width * Width) div FCurrentLayout.Width;
      Dec(WidthLeftover[WidthLeftoverIndex], Button.Width);
    end;
  end;

  // Resize all stretchy buttons using OriginalWidths as the width size.
  OriginalWidthsIndex := -1;
  WidthLeftoverIndex := -1;

  for Index := 0 to FButtons.Count - 1 do
  begin
    Button := FButtons[Index];

    if Button.Left = 0 then
    begin
      Inc(OriginalWidthsIndex);
      Inc(WidthLeftoverIndex);
    end;

    if kfStretch in Button.Key.Flags then
    begin
      Button.FWidth := ((Button.Key.Width * WidthLeftover[WidthLeftoverIndex]) div
        OriginalWidths[OriginalWidthsIndex]);
    end
    else if Index = FButtons.Count - 1 then         
      Button.FWidth := Button.Width - 1;
  end;

  // Orient all buttons horizontally.
  for Index := 1 to FButtons.Count - 1 do
  begin
    Button := FButtons[Index];

    if Button.Left <> 0 then
      Button.FLeft := FButtons[Index - 1].Left + FButtons[Index - 1].Width;
  end;

  // Resize and orient all buttons vertically.
  RowCount := 0;

  for Index := 0 to FButtons.Count - 1 do
  begin
    Button := FButtons[Index];
    if Button.Left = 0 then
      Inc(RowCount);
  end;

  if RowCount > 0 then
    ButtonHeight := (Height - 1) div RowCount
  else
    ButtonHeight := 0;
  TopPosition := 0;
  Row := 0;
  TopRemainder := (Height - (ButtonHeight * RowCount));
  TallButton := nil;

  for Index := 0 to FButtons.Count - 1 do
  begin
    Button := FButtons[Index];

    if Button.Key.Height <> FCurrentLayout.RowHeight then
      TallButton := Button;

    if Button.Top <> Row then
    begin
      Row := Button.Top;

      if TopRemainder > 0 then
        TopPosition := TopPosition + ButtonHeight + 1
      else
        TopPosition := TopPosition + ButtonHeight;

      Dec(TopRemainder);

      if (TallButton <> nil) and (TallButton.Key.Height <> FCurrentLayout.RowHeight) then
      begin
        // Note: Because tall buttons are on the previous row they contain the margin
        // of that row (top and bottom). This is why Button.TopMargin is not added
        // to the hight of the tall button.
        TallButton.FHeight := TallButton.Height + ButtonHeight + TallButton.BottomMargin;

        if TopRemainder > 0 then
          TallButton.FHeight := TallButton.Height + 1;
        TallButton := nil;
      end;
    end;

    Button.FTop := TopPosition;

    if TopRemainder > 0 then
      Button.FHeight := ButtonHeight + 1
    else
      Button.FHeight := ButtonHeight;
  end;

  inherited;
end;

procedure TCustomTouchKeyboard.ToggleKeys(AButton: TCustomKeyboardButton; KeyState: TKeyState;
  Immediate: Boolean = False);

  procedure SetButtonState(Button: TCustomKeyboardButton; State: TCustomKeyboardButton.TDrawState);
  begin
    if Button.State <> State then
    begin
      if Immediate then
      begin
        Button.SetState(State, False);
        Button.Paint;
      end
      else
        Button.SetState(State, True);
    end;
  end;

var
  Index: Integer;
  LButton: TCustomKeyboardButton;
  Key: TVirtualKey;
  State: TCustomKeyboardButton.TDrawState;
begin
  if KeyState = ksUp then
    State := TCustomKeyboardButton.TDrawState.dsNormal
  else
    State := TCustomKeyboardButton.TDrawState.dsPressed;

  Key := GetLanguageKey(AButton.Key, FLanguage);

  if Length(Key.ComboKeys) > 0 then
    SetButtonState(AButton, State)
  else
  begin
    // Toggle/Untoggle all keys with the same Vk or ScanCode.
    for Index := 0 to FButtons.Count - 1 do
    begin
      LButton := FButtons[Index];
      if Key.Equals(GetLanguageKey(LButton.Key, FLanguage)) then
        SetButtonState(LButton, State);
    end;
  end;
end;

procedure TCustomTouchKeyboard.UpdateCaptions;
var
  Index: Integer;
  Button: TCustomKeyboardButton;
  Key: TKey;
begin
  for Index := 0 to FButtons.Count - 1 do
  begin
    Button := FButtons[Index];
    Key := GetModifiedKey(Button.Key, FLanguage);

    if Key.KeyImage <> kiText then
      Button.KeyImage := Key.KeyImage
    else
    begin
      if Key.Caption = '' then
        Button.Caption := Key.ToString(GetShiftState(Button.Key))
      else
        Button.Caption := Key.Caption;
    end;

    if not Button.Modifier then
      Button.SetState(TCustomKeyboardButton.TDrawState.dsNormal, False);
  end;
end;

procedure TCustomTouchKeyboard.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 0;
end;

procedure TCustomTouchKeyboard.WMInputLangChange(var Message: TMessage);
var
  LLanguage: string;
  Success: Boolean;
begin
  Success := False;
  LLanguage := GetCurrentInputLanguage;

  if LLanguage <> '' then
  begin
    FLanguage := LLanguage;
    if CreateKeyboard(FLanguage) then
    begin
      Invalidate;
      Redraw;
      Paint;
      Success := True;
    end;
  end;

  if not Success then
    raise Exception.CreateRes(@SKeyboardLangChange);
end;

procedure TCustomTouchKeyboard.WMTouch(var Message: TMessage);
var
  TouchInputs: array of TouchInput;
  LTouchInput: TouchInput;
  Index, TouchCount: Integer;
begin
  try
    TouchCount := LoWord(Message.WParam);
    SetLength(TouchInputs, TouchCount);

    if GetTouchInputInfo(Message.LParam, TouchCount, @TouchInputs[0],
      SizeOf(TouchInput)) then
    begin
      for Index := 0 to Length(TouchInputs) - 1 do
      begin
        LTouchInput := TouchInputs[Index];
        ProcessKeyPress(TouchInputToWmMouse(Self, LTouchInput), LTouchInput.dwID);
      end;
    end;
  finally
    CloseTouchInputHandle(Message.LParam);
  end;
end;

procedure TCustomTouchKeyboard.WndProc(var Message: TMessage);
begin
  if not ((ssTouch in MouseOriginToShiftState) and CheckWin32Version(6, 1)) then
  begin
    if Message.Msg = WM_LBUTTONDBLCLK then
      Dec(Message.Msg, WM_LBUTTONDBLCLK - WM_LBUTTONDOWN);
    ProcessKeyPress(TWMMouse(Message), 0);
  end;

  inherited;
end;

procedure TCustomTouchKeyboard.WriteCustomCaptionOverrides(Stream: TStream);

  procedure WriteInteger(Value: Integer);
  begin
    Stream.Write(Value, SizeOf(Value));
  end;

  procedure WriteString(const Value: string);
  var
    Bytes: TBytes;
    Count: Byte;
  begin
    Bytes := TEncoding.Unicode.GetBytes(Value);
    Count := Length(Bytes);
    Stream.Write(Count, SizeOf(Count));
    if Count > 0 then
      Stream.Write(Bytes[0], Count);
  end;

var
  Index: Integer;
  Version: Integer;
  KeyItem: TKeyCaptions.TKeyCaption;
begin
  Version := 1;
  WriteInteger(Version);
  WriteInteger(CaptionOverrides.Count);
  for Index := 0 to CaptionOverrides.Count - 1 do
  begin
    KeyItem := CaptionOverrides[Index];
    if KeyItem.Language = '' then
    begin
      WriteInteger(2);
      WriteString(KeyItem.Name);
      WriteString(KeyItem.Value);
    end
    else
    begin
      WriteInteger(2);
      WriteString(KeyItem.Name);
      WriteString(KeyItem.Value);
      WriteString(KeyItem.Language);
    end;
  end;
end;

procedure TCustomTouchKeyboard.KeyClick(Button: TCustomKeyboardButton);
var
  ModifierButton: TCustomKeyboardButton;
  Index: Integer;
  Key: TKey;
begin
  Key := GetModifiedKey(Button.Key, FLanguage);

  if Key.IsDeadKey then
  begin
    FDeadKey := VKey(Key.Vk, Key.ScanCode);

    // Move all the modifier keys that are not held down to the dead key.
    Index := 0;
    while Index < FUnclick.Count do
    begin
      ModifierButton := FUnclick[Index];

      if (not (kfToggle in ModifierButton.Key.Flags)) and (ModifierButton.ID = -1) then
      begin
        FDeadKeyUnclick.Add(ModifierButton);
        ToggleKeys(ModifierButton, ksUp, True);
        PlayKey(GetLanguageKey(ModifierButton.Key, FLanguage), ksUp);
        ModifierButton.Down := False;
        FUnclick.Delete(Index);
      enD
      else
        Inc(Index);
    end;

    Redraw;
    Exit;
  end;

  if (FDeadKey.Vk >= 0) or (FDeadKey.ScanCode >= 0) then
  begin
    for Index := 0 to FUnclick.Count - 1 do
    begin
      ModifierButton := FUnclick[Index];
      if ((ModifierButton.Key.Vk <> VK_CAPITAL) and (ModifierButton.Key.ScanCode <> 58)) then
        PlayKey(GetLanguageKey(ModifierButton.Key, FLanguage), ksUp);
    end;

    for Index := 0 to FDeadKeyUnclick.Count - 1 do
    begin
      ModifierButton := FDeadKeyUnclick[Index];
      PlayKey(GetLanguageKey(ModifierButton.Key, FLanguage), ksDown);
    end;

    SendKey(FDeadKey, ksDown);

    for Index := 0 to FDeadKeyUnclick.Count - 1 do
    begin
      ModifierButton := FDeadKeyUnclick[Index];
      PlayKey(GetLanguageKey(ModifierButton.Key, FLanguage), ksUp);
    end;

    SendKey(FDeadKey, ksUp);

    for Index := 0 to FUnclick.Count - 1 do
    begin
      ModifierButton := FUnclick[Index];

      if (ModifierButton.ID = -1) and
        ((ModifierButton.Key.Vk <> VK_CAPITAL) and (ModifierButton.Key.ScanCode <> 58)) then
      begin
        PlayKey(GetLanguageKey(ModifierButton.Key, FLanguage), ksDown);
      end;
    end;
  end;

  PlayKey(Key, ksDown);
  PlayKey(Key, ksUp);

  if FUnclick.Count > 0 then
  begin
    // Untoggle all keys that are currently toggled and not held down.
    Index := 0;
    while Index < FUnclick.Count do
    begin
      ModifierButton := FUnclick[Index];

      if ModifierButton.Modifier and not (kfToggle in ModifierButton.Key.Flags) and (ModifierButton.ID <> -1) then
        ModifierButton.Down := False;

      if (not (kfToggle in ModifierButton.Key.Flags)) and
        ((ModifierButton.ID = -1) or (ModifierButton.ID = 0)) then
      begin
        PlayKey(GetLanguageKey(ModifierButton.Key, FLanguage), ksUp);
        ToggleKeys(ModifierButton, ksUp, True);
        ModifierButton.Down := False;
        FUnclick.Delete(Index);
      end
      else
        Inc(Index);
    end;

    Redraw;
  end;

  FDeadKey := VKey(-1, -1);
  FDeadKeyUnclick.Clear;
end;

function TCustomTouchKeyboard.GetOverrideCaption(const Key: TVirtualKey; var Caption: string): Boolean;
begin
  Result := False;

  if CaptionOverrides.HasCaption(Key.PublishedName, FLanguage) then
  begin
    Caption := CaptionOverrides.GetCaption(Key.PublishedName, FLanguage);
    Result := True;
  end
  else if CaptionOverrides.HasCaption(Key.PublishedName) then
  begin
    Caption := CaptionOverrides.GetCaption(Key.PublishedName);
    Result := True;
  end;
end;

procedure TCustomTouchKeyboard.OnChange(Sender: TObject);
var
  ChangeState: TChangeState;
begin
  while FChangeStates.Count > 0 do
  begin
    ChangeState := FChangeStates[0];
    ChangeState.Button.SetState(ChangeState.State, False);
    ChangeState.Button.Paint;
    FChangeStates.Delete(0);
  end;

  FChangeTimer.Enabled := False;
end;

procedure TCustomTouchKeyboard.OnRepeat(Sender: TObject);
var
  Index: Integer;
  PressedKey: TCustomKeyboardButton;
  Key: TKey;
begin
  if FPressedKeys.Count > 0 then
  begin
    for Index := 0 to FPressedKeys.Count - 1 do
    begin
      PressedKey := FPressedKeys[Index];

      if not PressedKey.Modifier then
      begin
        Key := GetModifiedKey(PressedKey.Key, FLanguage);
        PlayKey(Key, ksDown);
      end;
    end;

    FRepeat.Interval := RepeatRate;
  end;
end;

procedure TCustomTouchKeyboard.Paint;
var
  MemDC: HDC;
  LCanvas: TCanvas;
  Bitmap: TBitmap;
  Index: Integer;
begin
  MemDC := CreateCompatibleDC(Canvas.Handle);
  try
    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := Width;
      Bitmap.Height := Height;
      SelectObject(MemDC, Bitmap.Handle);
      LCanvas := TCanvas.Create;
      try
        LCanvas.Handle := MemDC;
        if DrawingStyle = TDrawingStyle.dsGradient then
          GradientFillCanvas(LCanvas, GradientStart, GradientEnd, ClientRect, gdVertical)
        else
        begin
          LCanvas.Brush.Color := Color;
          LCanvas.FillRect(ClientRect);
        end;

        for Index := 0 to FButtons.Count - 1 do
          FButtons[Index].Paint(LCanvas);

        Canvas.CopyRect(ClientRect, LCanvas, ClientRect);
      finally
        LCanvas.Free;
      end;
    finally
      Bitmap.Free;
    end;
  finally
    DeleteDC(MemDC);
  end;
end;

procedure TCustomTouchKeyboard.ProcessKeyPress(const Msg: TWmMouse; ID: Integer);

  function FindButton(Point: TPoint): TCustomKeyboardButton; overload;
  var
    Index: Integer;
  begin
    Result := nil;

    for Index := 0 to FButtons.Count - 1 do
    begin
      if FButtons[Index].BoundsRect.Contains(Point) then
      begin
        Result := FButtons[Index];
        Break;
      end;
    end;
  end;

  function FindButton(ID: Integer): TCustomKeyboardButton; overload;
  var
    Index: Integer;
  begin
    Result := nil;

    if ID <> -1 then
    begin
      for Index := 0 to FButtons.Count - 1 do
      begin
        if FButtons[Index].ID = ID then
        begin
          Result := FButtons[Index];
          Break;
        end;
      end;
    end;
  end;

  function FindLastKey(Button: TCustomKeyboardButton): TCustomKeyboardButton;
  var
    Index: Integer;
  begin
    Result := nil;

    if Button <> nil then
    begin
      for Index := 0 to FPressedKeys.Count - 1 do
      begin
        if FPressedKeys[Index] = Button then
        begin
          Result := FPressedKeys[Index];
          Break;
        end;
      end;
    end;
  end;

  procedure DeleteLastKey(Button: TCustomKeyboardButton);
  var
    Index: Integer;
  begin
    for Index := 0 to FPressedKeys.Count - 1 do
    begin
      if FPressedKeys[Index] = Button then
      begin
        FPressedKeys.Delete(Index);
        Break;
      end;
    end;
  end;

  procedure DeleteUnclickKey(Button: TCustomKeyboardButton);
  var
    Index: Integer;
  begin
    for Index := 0 to FUnclick.Count - 1 do
    begin
      if FUnclick[Index] = Button then
      begin
        FUnclick.Delete(Index);
        Break;
      end;
    end;
  end;

  procedure AddLastKey(Button: TCustomKeyboardButton);
  var
    Index: Integer;
  begin
    for Index := 0 to FPressedKeys.Count - 1 do
    begin
      if FPressedKeys[Index] = Button then
        Exit;
    end;

    FPressedKeys.Add(Button);
  end;

  procedure AddOrDelete(List: TButtonList; Button: TCustomKeyboardButton);
  var
    Index: Integer;
  begin
    for Index := 0 to List.Count - 1 do
    begin
      if List[Index].Key.Equals(Button.Key) then
      begin
        List.Delete(Index);
        Exit;
      end;
    end;

    Index := 0;
    while Index < List.Count - 1 do
    begin
      if (List[Index].Key.GroupIndex = Button.Key.GroupIndex) then
        List.Delete(Index)
      else
        Inc(Index);
    end;

    List.Add(Button);
  end;


var
  Button, LastKey: TCustomKeyboardButton;
  Point: TPoint;
begin
  if not Enabled or (csDesigning in ComponentState) then
    Exit;

  Point:= SmallPointToPoint(Msg.Pos);

  case Msg.Msg of
    WM_LBUTTONDOWN:
    begin
      Button := FindButton(Point);

      if Button <> nil then
      begin
        Button.ID := ID;
        AddLastKey(Button);

        if Button.Modifier then
        begin
          if kfToggle in Button.Key.Flags then
          begin
            if not Button.Down then
              ToggleKeys(Button, ksDown, True);

            AddOrDelete(FUnclick, Button);
            Button.Down := not Button.Down;
            Redraw;
          end
          else if Button.Modifier then
          begin
            if not Button.Down then
            begin
              PlayKey(GetLanguageKey(Button.Key, FLanguage), ksDown);
              if Button.State = TCustomKeyboardButton.TDrawState.dsPressed then
                ToggleKeys(Button, ksUp, True)
              else
                ToggleKeys(Button, ksDown, True);
            end;

            AddOrDelete(FUnclick, Button);
            Button.Down := not Button.Down;
            Redraw;
          end;
        end
        else
        begin
          ToggleKeys(Button, ksDown, True);
          if (RepeatRate <> 0) and (RepeatDelay <> 0) then
          begin
            FRepeat.Interval := RepeatDelay;
            FRepeat.Enabled := True;
          end;
        end;
      end;
    end;

    WM_LBUTTONUP:
    begin
      Button := FindButton(Point);

      if Button <> nil then
      begin
        FRepeat.Enabled := False;
        LastKey := FindLastKey(Button);

        if LastKey <> nil then
          DeleteLastKey(LastKey);

        if (LastKey = Button) and Button.Modifier then
        begin
          if (Button.ID <> -1) and (Button.ID = ID) then
          begin
            Button.ID := -1;

            if kfToggle in Button.Key.Flags then
            begin
              PlayKey(GetLanguageKey(Button.Key, FLanguage), ksDown);
              PlayKey(GetLanguageKey(Button.Key, FLanguage), ksUp);

              if not Button.Down then
                ToggleKeys(Button, ksUp, True);
            end
            else if not Button.Down then
            begin
              PlayKey(GetLanguageKey(Button.Key, FLanguage), ksUp);
              ToggleKeys(Button, ksUp, True);
              if FUnclick.Count > 0 then
                AddOrDelete(FUnclick, Button);
              Redraw;
            end;
          end;
        end
        else if (LastKey = Button) and not Button.Modifier then
        begin
          ToggleKeys(Button, ksUp);
          Button.ID := -1;
          KeyClick(Button);
        end
        else if LastKey <> nil then
        begin
          ToggleKeys(LastKey, ksUp);
          DeleteLastKey(LastKey);
        end;
      end;
    end;

    WM_MOUSELEAVE:
    begin
      if FPressedKeys.Count > 0 then
      begin
        ClearState;
        Redraw;
      end;
    end;

    WM_MOUSEMOVE:
    begin
      if (ID <> -1) and (FPressedKeys.Count > 0) then
      begin
        Button := FindButton(Point);
        LastKey := FindButton(ID);

        if (LastKey <> nil) and (Button <> nil) and (LastKey <> Button) then
        begin
          FRepeat.Enabled := False;
          Button.ID := ID;
          LastKey.ID := -1;

          if LastKey.Modifier then
          begin
            if kfToggle in LastKey.Key.Flags then
            begin
              LastKey.Down := not LastKey.Down;
              ToggleKeys(LastKey, ksUp, True);
              DeleteLastKey(LastKey);
              DeleteUnclickKey(LastKey);
            end
            else
            begin
              LastKey.Down := not LastKey.Down;
              ToggleKeys(LastKey, ksUp, True);
              DeleteLastKey(LastKey);
              ToggleKeys(Button, ksDown, True);
              AddLastKey(Button);
            end;
          end
          else
          begin
            ToggleKeys(LastKey, ksUp, True);
            ToggleKeys(Button, ksDown, True);
            DeleteLastKey(LastKey);
            AddLastKey(Button);
          end;
        end;
      end;
    end;
  end;
end;

{ TCustomTouchKeyboard.TChangeState }

class function TCustomTouchKeyboard.TChangeState.ChangeState(AButton: TCustomKeyboardButton;
  const AState: TCustomKeyboardButton.TDrawState): TChangeState;
begin
  Result.Button := AButton;
  Result.State := AState;
end;

{ TKeyCaptions }

procedure TKeyCaptions.Add(const AName, AValue: string; const ALanguage: string = '');
begin
  SetLength(FItems, Length(FItems) + 1);
  FItems[Length(FItems) - 1] := KeyCaption(AName, AValue, ALanguage);
end;

procedure TKeyCaptions.Clear;
begin
  SetLength(FItems, 0);
end;

procedure TKeyCaptions.Delete(const AName: string; const ALanguage: string = '');
var
  Index, CopyIndex: Integer;
  Items: TKeyCaptionArray;
begin
  SetLength(Items, Length(FItems) - 1);
  Index := 0;
  CopyIndex := 0;

  while Index < Length(Items) do
  begin
    if (FItems[CopyIndex].Name = AName) and (FItems[CopyIndex].Language = ALanguage) then
      Inc(CopyIndex);
    Items[Index] := FItems[CopyIndex];
    Inc(Index);
    Inc(CopyIndex);
  end;

  FItems := Items;
end;

function TKeyCaptions.GetCaption(const AName, ALanguage: string): string;
var
  Index: Integer;
  KeyCaption: TKeyCaption;
begin
  for Index := 0 to Length(FItems) - 1 do
  begin
    KeyCaption := FItems[Index];
    if (KeyCaption.Name = AName) and (KeyCaption.Language = ALanguage) then
      Exit(KeyCaption.Value);
  end;
end;

function TKeyCaptions.GetCount: Integer;
begin
  Result := Length(FItems);
end;

function TKeyCaptions.GetItems(const Index: Integer): TKeyCaption;
begin
  Result := FItems[Index];
end;

function TKeyCaptions.HasCaption(const AName: string; const ALanguage: string = ''): Boolean;
var
  Index: Integer;
begin
  Result := False;

  for Index := 0 to Length(FItems) - 1 do
  begin
    if (FItems[Index].Name = AName) and (FItems[Index].Language = ALanguage) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TKeyCaptions.KeyCaption(const AName, AValue, ALanguage: string): TKeyCaption;
begin
  Result.Name := AName;
  Result.Value := AValue;
  Result.Language := ALanguage;
end;

procedure TKeyCaptions.SetCaption(const AName, AValue: string; const ALanguage: string = '');
var
  Index: Integer;
  Found: Boolean;
begin
  Found := False;

  for Index := 0 to Length(FItems) - 1 do
  begin
    if (FItems[Index].Name = AName) and (FItems[Index].Language = ALanguage) then
    begin
      FItems[Index].Value := AValue;
      Found := True;
      Break;
    end;
  end;

  if not Found then
    Add(AName, AValue, ALanguage);
end;

procedure TKeyCaptions.SetItems(const Index: Integer; const Value: TKeyCaption);
begin
  FItems[Index] := Value;
end;

{ TKeyboardLayouts }

function EnumResNames(Module: HMODULE; ResType, ResName: PChar;
  Nothing: Pointer): Integer; stdcall;
const
  sResourceName = 'KEYBOARD';
var
  Layout: TVirtualKeyLayout;
  Stream: TResourceStream;
begin
  if Pos(sResourceName, ResName) > 0 then
  begin
    Stream := TResourceStream.Create(HInstance, ResName, RT_RCDATA);
    try
      Layout := TVirtualKeyLayout.Create;
      Layout.LoadFromStream(Stream);
      GlobalKeyboardLayouts.Add(Layout);
    finally
      Stream.Free;
    end;
  end;
  Result := 1;
end;

class constructor TKeyboardLayouts.Create;
begin
  FKeyboardLayouts := TVirtualKeyLayouts.Create;
  GlobalKeyboardLayouts := FKeyboardLayouts;
  EnumResourceNames(HInstance, RT_RCDATA, @EnumResNames, 0);
end;

class destructor TKeyboardLayouts.Destroy;
begin
  FKeyboardLayouts.Free;
end;

class function TKeyboardLayouts.Find(const Layout: string): TVirtualKeyLayout;
var
  Index: Integer;
begin
  Result := nil;

  for Index := 0 to TKeyboardLayouts.Count - 1 do
  begin
    if Layouts[Index].KeyboardType = Layout then
    begin
      Result := TKeyboardLayouts.Layouts[Index];
      Exit;
    end;
  end;
end;

class function TKeyboardLayouts.Find(const Layout,
  Language: string): TVirtualKeyLayout;
var
  Index, LanguageIndex: Integer;
  KeyboardLayout: TVirtualKeyLayout;
begin
  Result := nil;

  for Index := TKeyboardLayouts.Count - 1 downto 0 do
  begin
    KeyboardLayout := Layouts[Index];
    for LanguageIndex := 0 to KeyboardLayout.Languages.Count - 1 do
    begin
      if (KeyboardLayout.KeyboardType = Layout) and
        (KeyboardLayout.Languages[LanguageIndex].Language = Language) then
      begin
        Result := KeyboardLayout;
        Exit;
      end;
    end;
  end;
end;

class function TKeyboardLayouts.GetCount: Integer;
begin
  Result := Layouts.Count;
end;

class function TKeyboardLayouts.GetLayoutNames: TStringDynArray;
  function FindItem(const Strings: TStringDynArray; const Value: string): Boolean;
  var
    Index: Integer;
  begin
    Result := False;

    for Index := 0 to Length(Strings) - 1 do
    begin
      if Strings[Index] = Value then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

var
  Index: Integer;
begin
  SetLength(Result, FKeyboardLayouts.Count);

  for Index := 0 to FKeyboardLayouts.Count - 1 do
    if not FindItem(Result, FKeyboardLayouts[Index].KeyboardType) then
      Result[Index] := FKeyboardLayouts[Index].KeyboardType;
end;

class procedure TKeyboardLayouts.LoadFromResourceName(
  const ResourceName: string);
var
  Stream: TResourceStream;
begin
  Stream := TResourceStream.Create(HInstance, ResourceName, RT_RCDATA);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

class procedure TKeyboardLayouts.LoadFromStream(Stream: TStream);
var
  Layout: TVirtualKeyLayout;
begin
  Layout := TVirtualKeyLayout.Create;
  Layout.LoadFromStream(Stream);
  FKeyboardLayouts.Add(Layout);
end;

end.
