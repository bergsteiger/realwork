
{*******************************************************}
{                                                       }
{       Turbo Pascal Version 7.0                        }
{       Turbo Vision Unit                               }
{                                                       }
{       Copyright (c) 1992 Borland International        }
{                                                       }
{       Virtual Pascal v2.1                             }
{       Copyright (C) 1996-2000 vpascal.com             }
{                                                       }
{*******************************************************}

unit Drivers;

{$X+,I-,S-,H-}

interface

uses Use32, Objects;

{ ******** EVENT MANAGER ******** }

const

{ Event codes }

  evMouseDown = $0001;
  evMouseUp   = $0002;
  evMouseMove = $0004;
  evMouseAuto = $0008;
  evKeyDown   = $0010;
  evCommand   = $0100;
  evBroadcast = $0200;

{ Event masks }

  evNothing   = $0000;
  evMouse     = $000F;
  evKeyboard  = $0010;
  evMessage   = $FF00;

{ Extended key codes }

  kbEsc       = $011B;  kbAltSpace  = $0200;  kbCtrlIns   = $0400;
  kbShiftIns  = $0500;  kbCtrlDel   = $0600;  kbShiftDel  = $0700;
  kbBack      = $0E08;  kbCtrlBack  = $0E7F;  kbShiftTab  = $0F00;
  kbTab       = $0F09;  kbAltQ      = $1000;  kbAltW      = $1100;
  kbAltE      = $1200;  kbAltR      = $1300;  kbAltT      = $1400;
  kbAltY      = $1500;  kbAltU      = $1600;  kbAltI      = $1700;
  kbAltO      = $1800;  kbAltP      = $1900;  kbCtrlEnter = $1C0A;
  kbEnter     = $1C0D;  kbAltA      = $1E00;  kbAltS      = $1F00;
  kbAltD      = $2000;  kbAltF      = $2100;  kbAltG      = $2200;
  kbAltH      = $2300;  kbAltJ      = $2400;  kbAltK      = $2500;
  kbAltL      = $2600;  kbAltZ      = $2C00;  kbAltX      = $2D00;
  kbAltC      = $2E00;  kbAltV      = $2F00;  kbAltB      = $3000;
  kbAltN      = $3100;  kbAltM      = $3200;  kbF1        = $3B00;
  kbF2        = $3C00;  kbF3        = $3D00;  kbF4        = $3E00;
  kbF5        = $3F00;  kbF6        = $4000;  kbF7        = $4100;
  kbF8        = $4200;  kbF9        = $4300;  kbF10       = $4400;
  kbHome      = $4700;  kbUp        = $4800;  kbPgUp      = $4900;
  kbGrayMinus = $4A2D;  kbLeft      = $4B00;  kbRight     = $4D00;
  kbGrayPlus  = $4E2B;  kbEnd       = $4F00;  kbDown      = $5000;
  kbPgDn      = $5100;  kbIns       = $5200;  kbDel       = $5300;
  kbShiftF1   = $5400;  kbShiftF2   = $5500;  kbShiftF3   = $5600;
  kbShiftF4   = $5700;  kbShiftF5   = $5800;  kbShiftF6   = $5900;
  kbShiftF7   = $5A00;  kbShiftF8   = $5B00;  kbShiftF9   = $5C00;
  kbShiftF10  = $5D00;  kbCtrlF1    = $5E00;  kbCtrlF2    = $5F00;
  kbCtrlF3    = $6000;  kbCtrlF4    = $6100;  kbCtrlF5    = $6200;
  kbCtrlF6    = $6300;  kbCtrlF7    = $6400;  kbCtrlF8    = $6500;
  kbCtrlF9    = $6600;  kbCtrlF10   = $6700;  kbAltF1     = $6800;
  kbAltF2     = $6900;  kbAltF3     = $6A00;  kbAltF4     = $6B00;
  kbAltF5     = $6C00;  kbAltF6     = $6D00;  kbAltF7     = $6E00;
  kbAltF8     = $6F00;  kbAltF9     = $7000;  kbAltF10    = $7100;
  kbCtrlPrtSc = $7200;  kbCtrlLeft  = $7300;  kbCtrlRight = $7400;
  kbCtrlEnd   = $7500;  kbCtrlPgDn  = $7600;  kbCtrlHome  = $7700;
  kbAlt1      = $7800;  kbAlt2      = $7900;  kbAlt3      = $7A00;
  kbAlt4      = $7B00;  kbAlt5      = $7C00;  kbAlt6      = $7D00;
  kbAlt7      = $7E00;  kbAlt8      = $7F00;  kbAlt9      = $8000;
  kbAlt0      = $8100;  kbAltMinus  = $8200;  kbAltEqual  = $8300;
  kbCtrlPgUp  = $8400;  kbAltBack   = $0800;  kbNoKey     = $0000;

{ Additional keyboard codes that Borland forgot to define }

 kbCtrlA      = $1E01;  kbCtrlB     = $3002;  kbCtrlC     = $2E03;
 kbCtrlD      = $2004;  kbCtrlE     = $1205;  kbCtrlF     = $2106;
 kbCtrlG      = $2207;  kbCtrlH     = $2308;  kbCtrlI     = $1709;
 kbCtrlJ      = $240A;  kbCtrlK     = $250B;  kbCtrlL     = $260C;
 kbCtrlM      = $320D;  kbCtrlN     = $310E;  kbCtrlO     = $180F;
 kbCtrlP      = $1910;  kbCtrlQ     = $1011;  kbCtrlR     = $1312;
 kbCtrlS      = $1F13;  kbCtrlT     = $1414;  kbCtrlU     = $1615;
 kbCtrlV      = $2F16;  kbCtrlW     = $1117;  kbCtrlX     = $2D18;
 kbCtrlY      = $1519;  kbCtrlZ     = $2C1A;

{ 101-key AT keyboard }

 kbAltTab     = $A500; kbAltDel     = $A300;  kbAltIns    = $A200;
 kbAltPgDn    = $A100; kbAltDown    = $A000;  kbAltEnd    = $9F00;
 kbAltRight   = $9D00; kbAltLeft    = $9B00;  kbAltPgUp   = $9900;
 kbAltUp      = $9800; kbAltHome    = $9700;  kbCtrlTab   = $9400;
 kbCtrlGreyPlus=$9000; kbCtrlCenter = $8F00;  kbCtrlMinus = $8E00;
 kbCtrlUp     = $8D00; kbAltF12     = $8C00;  kbAltF11    = $8B00;
 kbCtrlF12    = $8A00; kbCtrlF11    = $8900;  kbShiftF12  = $8800;
 kbShiftF11   = $8700; kbF12        = $8600;  kbF11       = $8500;
 kbAltGrayPlus= $4E00; kbCenter     = $4C00;  kbAltGreyAst= $3700;
 kbAltSlash   = $3500; kbAltPeriod  = $3400;  kbAltComma  = $3300;
 kbAltBackSlash=$2B00; kbAltOpQuote = $2900;  kbAltQuote  = $2800;
 kbAltSemicolon=$2700; kbAltRgtBrack= $1B00;  kbAltLftBrack=$1A00;
 kbAltEsc     = $0100; kbCtrlDown   = $9100;

{ Special keys }

kbAltShiftBack = $0900;

{ Keyboard state and shift masks }

  kbRightShift  = $0001;
  kbLeftShift   = $0002;
  kbCtrlShift   = $0004;
  kbAltShift    = $0008;
  kbScrollState = $0010;
  kbNumState    = $0020;
  kbCapsState   = $0040;
  kbInsState    = $0080;

{ Mouse button state masks }

  mbLeftButton  = $01;
  mbRightButton = $02;
  mbWheel       = $03;

type
{ Event record }
  PEvent = ^TEvent;
  TEvent = record
    What: Word;
    case Word of
      evNothing: ();
      evMouse: (
        Buttons: Byte;
        Double: Boolean;
        Where: TPoint);
      evKeyDown: (
        case Integer of
          0: (KeyCode: Word;
              ShiftState: Byte);
          1: (CharCode: Char;
              ScanCode: Byte));
      evMessage: (
        Command: Word;
        case Word of
          0: (InfoPtr: Pointer);
          1: (InfoLong: Longint);
          2: (InfoWord: Word);
          3: (InfoInt: Integer);
          4: (InfoByte: Byte);
          5: (InfoChar: Char));
  end;

  TShiftStateHandler = function(var ShiftState: Byte): Boolean;
  TCtrlBreakAction = procedure;

const

{ Initialized variables }

  ButtonCount: Byte = 0;
  MouseEvents: Boolean = False;
  MouseReverse: Boolean = False;
  DoubleDelay: Word = 8;
  RepeatDelay: Word = 8;
  GetShiftStateHandler: TShiftStateHandler = nil;
  CtrlBreakAction: TCtrlBreakAction = nil;
  KeyDownMask: Word = evKeyDown;
  NonStandardModes = True;

var
  MouseButtons: Byte;
  MouseWhere: TPoint;
  MouseEventMask: Word;
  CodePage: Word;

{ Event manager routines }

procedure InitEvents;
procedure DoneEvents;
procedure ShowMouse;  pascal;
procedure HideMouse;  pascal;
procedure UpdateMouseWhere; pascal;
procedure GetMouseEvent(var Event: TEvent);
procedure GetKeyEvent(var Event: TEvent);
function GetShiftState: Byte;

{ ******** SCREEN MANAGER ******** }

procedure ConsoleOutput(x, x2, y: integer);

const

{ Screen modes }

  smBW80        = $0002;
  smCO80        = $0003;
  smMono        = $0007;
  smNonStandard = $00FF;
  smFont8x8     = $0100;

const

{ Initialized variables }

  StartupMode: Word = $FFFF;
  CheckSnow: Boolean = False;   { not used }

var

{ Uninitialized variables }

  ScreenMode: Word;
  ScreenWidth: Byte;
  ScreenHeight: Byte;
  HiResScreen: Boolean;
  ScreenBuffer: Pointer;
  CursorLines: SmallWord;
  // ScreenMirror made larger to handle Win2000
  ScreenMirror: array[0..65535] of Byte;

{ Screen manager routines }

procedure InitVideo;
procedure DoneVideo;
procedure SetVideoMode(Mode: Word);
procedure ClearScreen;

{ Keyboard }

procedure InitKeyboard;

{ Initialized variables }

const
  CtrlBreakHit: Boolean = False;
  SaveCtrlBreak: Boolean = False;       { not used }
  SysErrActive: Boolean = False;
  FailSysErrors: Boolean = False;       { not used }

{ System error handler routines }

procedure InitSysError;
procedure DoneSysError;

{ ******** UTILITY ROUTINES ******** }

{ Keyboard support routines }

function GetAltChar(KeyCode: Word): Char;
function GetAltCode(Ch: Char): Word;
function GetCtrlChar(KeyCode: Word): Char;
function GetCtrlCode(Ch: Char): Word;
function CtrlToArrow(KeyCode: SmallWord): SmallWord;

{ String routines }

procedure FormatStr(var Result: String; const Format: String; var Params);
procedure PrintStr(const S: String);

{ Buffer move routines }

procedure MoveBuf(var Dest; var Source; Attr: Byte; Count: Word); pascal;
procedure MoveChar(var Dest; C: Char; Attr: Byte; Count: Word); pascal;
procedure MoveCStr(var Dest; Str: String; Attrs: SmallWord); pascal;
procedure MoveStr(var Dest; Str: String; Attr: Byte); pascal;
function CStrLen(const S: String): Integer; pascal;

implementation

uses W32SysLow, Windows;

{ ******** EVENT MANAGER ******** }

var

{ Event manager variables }

  LastButtons: Byte;
  DownButtons: Byte;
  LastDouble: Boolean;
  DownWhere: TPoint;
  DownTicks: Word;
  AutoTicks: Word;
  AutoDelay: Word;
  StrtCurY1: Integer;
  StrtCurY2: Integer;
  StrtCurVisible: Boolean;

// Detects mouse driver, moves mouse pointer to the top left corner

procedure DetectMouse;
begin
  ButtonCount := SysTVDetectMouse;
end;

// Shows mouse pointer

procedure ShowMouse;
begin
  SysTVShowMouse;
end;

// Hides mouse pointer

procedure HideMouse;
begin
  SysTVHideMouse;
end;

// Initializes Turbo Vision's event manager by setting event mask and
// showing the mouse. Called automatically by TApplication.Init.

procedure InitEvents;
begin
  if ButtonCount <> 0 then
  begin
    DownButtons := 0;
    LastDouble := False;
    LastButtons := 0;       // Assume that no button is pressed
    SysTVInitMouse(MouseWhere.X, MouseWhere.Y);
    MouseEvents := True;
  end;
end;

// Terminates Turbo Vision's event manager and hides the mouse. Called
// automatically by TApplication.Done.

procedure DoneEvents;
begin
  if ButtonCount <> 0 then
  begin
    SysTVDoneMouse(False);
    MouseEvents := False;
  end;
end;

// Checks whether a mouse event is available by polling the mouse event
// queue maintained by OS/2. If a mouse event has occurred, Event.What
// is set to evMouseDown, evMouseUp,evMouseMove, or evMouseAuto;
// Event.Buttons is set to mbLeftButton or mbRightButton;
// Event.Double is set to True or False;
// Event.Where is set to the mouse position in global coordinates.
// If no mouse events are available, Event.What is set to evNothing.
// GetMouseEvent is called by TProgram.GetEvent.

procedure GetMouseEvent(var Event: TEvent);
var
  SysMouseEvent: TSysMouseEvent;
  CurTicks: Word;
  B: Byte;

procedure StoreEvent(MouWhat: Word);
begin
  LastButtons := MouseButtons;
  MouseWhere.X := SysMouseEvent.smePos.X;
  MouseWhere.Y := SysMouseEvent.smePos.Y;
  with Event do
  begin
    What := MouWhat;
    Buttons := MouseButtons;
    Double  := LastDouble;
    Where.X := SysMouseEvent.smePos.X;
    Where.Y := SysMouseEvent.smePos.Y;
  end;
end;

// GetMouseEvent body

begin
  if not MouseEvents then
    Event.What := evNothing
  else
    begin
      if not SysTVGetMouseEvent(SysMouseEvent) then
        begin
          MouseButtons := LastButtons;
          SysMouseEvent.smeTime := SysSysMsCount;
          SysMouseEvent.smePos.X := MouseWhere.X;
          SysMouseEvent.smePos.Y := MouseWhere.Y;
        end
      else
        begin
          if MouseReverse then
          begin
            B := 0;
            if (SysMouseEvent.smeButtons and $0001) <> 0 then
              Inc(B, $0002);
            if (SysMouseEvent.smeButtons and $0002) <> 0 then
              Inc(B, $0001);
            SysMouseEvent.smeButtons := B;
          end;
          MouseButtons := SysMouseEvent.smeButtons;
        end;
      // ms -> ticks: 1 DOS timer tick = 55ms
      CurTicks  := SysMouseEvent.smeTime div 55;
      // Process mouse event
      if (LastButtons <> 0) and (MouseButtons = 0) then
        StoreEvent(evMouseUp) // button is released
      else
        if LastButtons = MouseButtons then
          begin
            if (SysMouseEvent.smePos.Y <> MouseWhere.Y) or (SysMouseEvent.smePos.X <> MouseWhere.X) then
              StoreEvent(evMouseMove)
            else
              if (MouseButtons <> 0) and ((CurTicks - AutoTicks) >= AutoDelay) then
                begin
                  AutoTicks := CurTicks;
                  AutoDelay := 1;
                  StoreEvent(evMouseAuto);
                end
              else
                StoreEvent(evNothing);
          end
        else // CurButton <> 0, LastButton = 0
          begin
            LastDouble := False;
            if (MouseButtons = DownButtons) and (SysMouseEvent.smePos.Y = DownWhere.Y) and (SysMouseEvent.smePos.X = DownWhere.X)
              and ((CurTicks - DownTicks) < DoubleDelay) then
                LastDouble := True;
            DownButtons := MouseButtons;
            DownWhere.Y := SysMouseEvent.smePos.Y;
            DownWhere.X := SysMouseEvent.smePos.X;
            DownTicks   := CurTicks;
            AutoTicks   := CurTicks;
            AutoDelay   := RepeatDelay;
            StoreEvent(evMouseDown);
          end;
    end;
end;

procedure InitKeyboard;
begin
  SysTVKbdInit;
end;

procedure UpdateMouseWhere;
begin
  SysTVUpdateMouseWhere(MouseWhere.X, MouseWhere.Y);
end;

// Checks whether a keyboard event is available. If a key has been
// pressed, Event.What is set to evKeyDown and Event.KeyCode is set to
// the scan code of the key. Otherwise, Event.What is set to evNothing.
// GetKeyEvent is called by TProgram.GetEvent.

procedure GetKeyEvent(var Event: TEvent);
var
  I: Integer;
  SysKeyEvent: TSysKeyEvent;
// Keyboard scan codes
const
  scSpace    = $39;  scIns      = $52;  scDel      = $53;
  scBack     = $0E;  scUp       = $48;  scDown     = $50;
  scLeft     = $4B;  scRight    = $4D;  scHome     = $47;
  scEnd      = $4F;  scPgUp     = $49;  scPgDn     = $51;
  scCtrlIns  = $92;  scCtrlDel  = $93;  scCtrlUp   = $8D;
  scCtrlDown = $91;  kbShift    = kbLeftShift + kbRightShift;

type
  KeyTransEntry = record
    Scan:  Byte;
    Shift: Byte;
    Code:  Word;
  end;

const
  KeyTranslateTable : array [1..15] of KeyTransEntry =
    (( Scan: scSpace   ; Shift: $08 ; Code: kbAltSpace    ), // Alt-Space
     ( Scan: scIns     ; Shift: $04 ; Code: kbCtrlIns     ), // Ctrl-Ins
     ( Scan: scCtrlIns ; Shift: $04 ; Code: kbCtrlIns     ), // Ctrl-Ins
     ( Scan: scIns     ; Shift: $01 ; Code: kbShiftIns    ), // Shift-Ins
     ( Scan: scIns     ; Shift: $02 ; Code: kbShiftIns    ), // Shift-Ins
     ( Scan: scIns     ; Shift: $03 ; Code: kbShiftIns    ), // Shift-Ins
     ( Scan: scDel     ; Shift: $04 ; Code: kbCtrlDel     ), // Ctrl-Del
     ( Scan: scCtrlDel ; Shift: $04 ; Code: kbCtrlDel     ), // Ctrl-Del
     ( Scan: scDel     ; Shift: $01 ; Code: kbShiftDel    ), // Shift-Del
     ( Scan: scDel     ; Shift: $02 ; Code: kbShiftDel    ), // Shift-Del
     ( Scan: scDel     ; Shift: $03 ; Code: kbShiftDel    ), // Shift-Del
     ( Scan: scBack    ; Shift: $09 ; Code: kbAltShiftBack), // Alt-Shift-Backspace
     ( Scan: scBack    ; Shift: $0A ; Code: kbAltShiftBack), // Alt-Shift-Backspace
     ( Scan: scBack    ; Shift: $0B ; Code: kbAltShiftBack), // Alt-Shift-Backspace
     ( Scan: scBack    ; Shift: $08 ; Code: kbAltBack    )); // Alt-Backspace
begin
  with Event do
    if not SysTVGetKeyEvent(SysKeyEvent) then
      What := evNothing
    else
      begin
        What       := KeyDownMask;
        KeyCode    := SysKeyEvent.skeKeyCode;
        ShiftState := SysKeyEvent.skeShiftState;
        for I := Low(KeyTranslateTable) to High(KeyTranslateTable) do
          with KeyTranslateTable[I] do
          begin
            if (Scan = ScanCode) and ((Shift and ShiftState) = Shift) then
            begin
              KeyCode := Code;
              Break;
            end;
          end;
        if (CharCode = #$E0) and (ScanCode in
          [scUp,scDown,scLeft,scRight,scIns,scDel,scHome,scEnd,scPgUp,scPgDn,
          Hi(kbCtrlHome), Hi(kbCtrlEnd)  , Hi(kbCtrlPgUp), Hi(kbCtrlPgDn),
          Hi(kbCtrlLeft), Hi(kbCtrlRight),    scCtrlUp,       scCtrlDown]) then
            CharCode := #0;      // Grey Keys
        if KeyCode = $E00D then  // Grey Enter
          KeyCode := kbEnter;
        InfoPtr := nil;
      end;
end;

// Returns a byte containing the current Shift key state, as reported by
// the system. The return value contains a combination of the kbXXXX constants
// for shift states.

function GetShiftState: Byte;
var
  Handled: Boolean;
begin
  Handled := False;
  if @GetShiftStateHandler <> nil then
    Handled := GetShiftStateHandler(Result);
  if not Handled then
    Result := SysTVGetShiftState;
end;

{ ******** SCREEN MANAGER ******** }

// Fixes the CRT mode if required

function FixCrtMode(Mode: Word): Word;
begin
  case Lo(Mode) of
    smMono,smCO80,smBW80:
      FixCrtMode := Mode;
    smNonStandard:
      if NonStandardModes then
        FixCrtMode := Mode
      else
        FixCrtMode := smCO80;
    else FixCrtMode := smCO80;
  end;
end;

// Updates the CRT-related variables

procedure SetCrtData;
var
  BufSize: Word;
  Y1,Y2: Integer;
  Visible: Boolean;
  SrcSize: TSysPoint;
begin
  ScreenMode := SysTVGetScrMode(@SrcSize);
  ScreenHeight := SrcSize.Y;
  ScreenWidth := SrcSize.X;
  ShowMouse;
  HiResScreen := True;
  ScreenBuffer := SysTVGetSrcBuf;
  SysTVGetCurType(Y1, Y2, Visible);
  WordRec(CursorLines).Hi := Y1;
  WordRec(CursorLines).Lo := Y2;
  SysTVSetCurType(Y1, Y2, False);   // Hide cursor
end;

const
  MaxViewWidth = 255;
procedure ConsoleOutput(x, x2, y: integer);
var
  len: integer;
  start: PByte;
  _to: TSmallRect;
  cbuf: array[0..MaxViewWidth] of TCharInfo;
  cbufp: PCharInfo;
  bsize, from: TCoord;
  i: integer;
begin
  start := PByte(Integer(ScreenBuffer) + 2*(y*ScreenWidth + x));
  len := x2 - x;
  with _to do
  begin
    Left    := x;
    Top     := y;
    Right   := x+len-1;
    Bottom  := y;
  end;
  cbufp := @cbuf[0];
  for i := 0 to len-1 do
  begin
    cbufp.AsciiChar  := PChar(start)^;
    Inc(start);
    cbufp.Attributes := PByte(start)^;
    Inc(start);
    Inc(cbufp);
  end;
  bsize.X := len;
  bsize.Y := 1;
  FillChar(from, sizeof(from),0);
  WriteConsoleOutput(SysConOut,@cbuf,bsize,from,_to);
end;

// Detects video modes

procedure DetectVideo;
begin
  ScreenMode := FixCrtMode(SysTVGetScrMode(nil));
end;

// Initializes Turbo Vision's video manager. Saves the current screen
// mode in StartupMode, and switches the screen to the mode indicated by
// ScreenMode. The ScreenWidth, ScreenHeight, HiResScreen, ScreenBuffer,
// and CursorLines variables are updated accordingly.InitVideo is called
// automatically by TApplication.Init.

procedure InitVideo;
begin
  SysTVGetCurType(StrtCurY1, StrtCurY2, StrtCurVisible);
  if StartupMode = $FFFF then
     StartupMode := SysTVGetScrMode(nil);
  if StartupMode <> ScreenMode then
    SysTVSetScrMode(ScreenMode);
  SetCrtData;
end;

// Terminates Turbo Vision's video manager by restoring the initial
// screen mode, clearing the screen, and restoring the cursor. Called
// automatically by TApplication.Done.

procedure DoneVideo;
begin
  if (StartupMode <> $FFFF) and (StartupMode <> ScreenMode) then
    SysTVSetScrMode(StartupMode);
  ClearScreen;
  SysTVSetCurType(StrtCurY1, StrtCurY2, StrtCurVisible);
  FillChar(ScreenMirror, SizeOf(ScreenMirror), 0);
end;

// Sets the video mode. Mode is one of the constants smCO80, smBW80, or smMono,
// optionally with smFont8x8 added to select 43- or 50-line mode on an EGA or
// VGA. SetVideoMode initializes the same variables as InitVideo (except for
// the StartupMode variable, which isn't affected).

procedure SetVideoMode(Mode: Word);
begin
  SysTVSetScrMode(FixCrtMode(Mode));
  SetCrtData;
end;

// Clears the screen, moves cursor to the top left corner

procedure ClearScreen;
begin
  SysTVClrScr;
end;

{ ********************* SYSTEM ERROR HANDLER ************************** }

// Initializes Turbo Vision's system error handler. Called automatically
// by TApplication.Init. Since no error handler is available,InitSysError
// sets SysErrActive to True and does nothing.

procedure InitSysError;
begin
  SysErrActive := True;
end;

// Terminates Turbo Vision's system error handler. Called automatically
// by TApplication.Done. Since no error handler is available,DoneSysError
// sets SysErrActive to False and does nothing.

procedure DoneSysError;
begin
  SysErrActive := False;
end;

// Ctrl-Break handler

function TVCtrlBreak: Boolean;
begin
  CtrlBreakHit := True;
  Result := True;
end;

{ ******** UTILITY ROUTINES ******** }

// Keyboard support routines

const

  AltCodes1: array[$10..$32] of Char =
    'QWERTYUIOP'#0#0#0#0'ASDFGHJKL'#0#0#0#0#0'ZXCVBNM';

  AltCodes2: array[$78..$83] of Char =
    '1234567890-=';

function GetAltChar(KeyCode: Word): Char;
begin
  GetAltChar := #0;
  if Lo(KeyCode) = 0 then
    case Hi(KeyCode) of
      $02: GetAltChar := #240;
      $10..$32: GetAltChar := AltCodes1[Hi(KeyCode)];
      $78..$83: GetAltChar := AltCodes2[Hi(KeyCode)];
    end;
end;

function GetAltCode(Ch: Char): Word;
var
  I: Word;
begin
  GetAltCode := 0;
  if Ch = #0 then Exit;
  Ch := UpCase(Ch);
  if Ch = #240 then
  begin
    GetAltCode := $0200;
    Exit;
  end;
  for I := $10 to $32 do
    if AltCodes1[I] = Ch then
    begin
      GetAltCode := I shl 8;
      Exit;
    end;
  for I := $78 to $83 do
    if AltCodes2[I] = Ch then
    begin
      GetAltCode := I shl 8;
      Exit;
    end;
end;

function GetCtrlChar(KeyCode: Word): Char;
begin
  GetCtrlChar := #0;
  if (Lo(KeyCode) <> 0) and (Lo(KeyCode) <= Byte('Z') - Byte('A') + 1) then
    GetCtrlChar := Char(Lo(KeyCode) + Byte('A') - 1);
end;

function GetCtrlCode(Ch: Char): Word;
begin
  GetCtrlCode := GetAltCode(Ch) or (Byte(UpCase(Ch)) - Byte('A') + 1);
end;

function CtrlToArrow(KeyCode: SmallWord): SmallWord;
const
  NumCodes = 11;
  CtrlCodes: array[0..NumCodes-1] of Char = ^S^D^E^X^A^F^G^V^R^C^H;
  ArrowCodes: array[0..NumCodes-1] of Word =
    (kbLeft, kbRight, kbUp, kbDown, kbHome, kbEnd, kbDel, kbIns,
     kbPgUp, kbPgDn, kbBack);
var
  I: Integer;
begin
  CtrlToArrow := KeyCode;
  for I := 0 to NumCodes - 1 do
    if WordRec(KeyCode).Lo = Byte(CtrlCodes[I]) then
    begin
      CtrlToArrow := ArrowCodes[I];
      Exit;
    end;
end;

procedure FormatStr (Var Result: String; CONST Format: String; Var Params);
TYPE TLongArray = Array[0..0] Of LongInt;
VAR ResultLength, FormatIndex, Justify, Wth: Byte; Fill: Char; S: String;

   FUNCTION LongToStr (L: Longint; Radix: Byte): String;
   CONST HexChars: Array[0..15] Of Char =
    ('0', '1', '2', '3', '4', '5', '6', '7',
     '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
   VAR I: LongInt; S: String; Sign: String[1];
   begin
     LongToStr := '';                                 { Preset empty return }
     If (L < 0) Then begin                            { If L is negative }
       Sign := '-';                                   { Sign is negative }
       L := Abs(L);                                   { Convert to positive }
     end Else Sign := '';                             { Sign is empty }
     S := '';                                         { Preset empty string }
     Repeat
       I := L MOD Radix;                              { Radix mod of value }
       S := HexChars[I] + S;                          { Add char to string }
       L := L DIV Radix;                              { Divid by radix }
     Until (L = 0);                                   { Until no remainder }
     LongToStr := Sign + S;                           { Return result }
   end;

   procedure HandleParameter (I : LongInt);
   begin
     While (FormatIndex <= Length(Format)) Do begin   { While length valid }
       While (Format[FormatIndex] <> '%') and         { Param char not found }
       (FormatIndex <= Length(Format)) Do begin       { Length still valid }
         Result[ResultLength+1] := Format[FormatIndex]; { Transfer character }
         Inc(ResultLength);                           { One character added }
         Inc(FormatIndex);                            { Next param char }
       end;
       If (FormatIndex < Length(Format)) and          { Not last char and }
       (Format[FormatIndex] = '%') Then begin         { '%' char found }
         Fill := ' ';                                 { Default fill char }
         Justify := 0;                                { Default justify }
         Wth := 0;                                    { Default 0=no width }
         Inc(FormatIndex);                            { Next character }
         If (Format[FormatIndex] = '0') Then
           Fill := '0';                               { Fill char to zero }
         If (Format[FormatIndex] = '-') Then begin    { Optional just char }
           Justify := 1;                              { Right justify }
           Inc(FormatIndex);                          { Next character }
         end;
         While ((FormatIndex <= Length(Format)) and   { Length still valid }
         (Format[FormatIndex] >= '0') and
         (Format[FormatIndex] <= '9')) Do begin       { Numeric character }
           Wth := Wth * 10;                           { Multiply x10 }
           Wth := Wth + Ord(Format[FormatIndex])-$30; { Add numeric value }
           Inc(FormatIndex);                          { Next character }
         end;
         If ((FormatIndex <= Length(Format)) and      { Length still valid }
         (Format[FormatIndex] = '#')) Then begin      { Parameter marker }
           Inc(FormatIndex);                          { Next character }
           HandleParameter(Wth);                      { Width is param idx }
         end;
         If (FormatIndex <= Length(Format)) Then begin{ Length still valid }
           Case Format[FormatIndex] Of
           '%': begin                               { Literal % }
             S := '%';
             Inc(FormatIndex);
             Move(S[1], Result[ResultLength+1], 1);
             Inc(ResultLength,Length(S));
             Continue;
           end;
           'c': S := Char(TLongArray(Params)[I]);  { Character parameter }
             'd': S := LongToStr(TLongArray(Params)[I],
               10);                                   { Decimal parameter }
             's': S := PString(TLongArray(Params)[I])^;{ String parameter }
             'x': S := LongToStr(TLongArray(Params)[I],
               16);                                   { Hex parameter }
           end;
           Inc(FormatIndex);                          { Next character }
           If (Wth > 0) Then begin                    { Width control active }
             If (Length(S) > Wth) Then begin          { We must shorten S }
               If (Justify=1) Then                    { Check right justify }
                 S := Copy(S, Length(S)-Wth+1, Wth)   { Take right side data }
                 Else S := Copy(S, 1, Wth);           { Take left side data }
             end Else begin                           { We must pad out S }
               If (Justify=1) Then                    { Right justify }
                 While (Length(S) < Wth) Do
                   S := S+Fill Else                   { Right justify fill }
                 While (Length(S) < Wth) Do
                   S := Fill + S;                     { Left justify fill }
             end;
           end;
           Move(S[1], Result[ResultLength+1],
             Length(S));                              { Move data to result }
           Inc(ResultLength,Length(S));               { Adj result length }
           Inc(I);
         end;
       end;
     end;
   end;

begin
   ResultLength := 0;                                 { Zero result length }
   FormatIndex := 1;                                  { Format index to 1 }
   HandleParameter(0);                                { Handle parameter }
   Result[0] := Chr(ResultLength);                    { Set string length }
end;

// Prints the string on the screen
procedure PrintStr(const S: String);
var
  Count: Longint;
begin
  SysFileWrite(SysFileStdOut, S[1], Length(S), Count);
end;

// Buffer move routines

// Moves text and video attributes into a buffer. Count bytes are moved
// from Source into the low bytes of corresponding words in Dest. The
// high bytes of the words in Dest are set to Attr, or remain unchanged
// if Attr is zero.

procedure MoveBuf(var Dest; var Source; Attr: Byte; Count: Word);
VAR I: Word;
begin
   For I := 1 To Count Do begin
     If (Attr <> 0) Then
       WordRec(TWordArray(Dest)[I-1]).Hi := Attr;     { Copy attribute }
     WordRec(TWordArray(Dest)[I-1]).Lo :=
      TByteArray(Source)[I-1];                        { Copy source data }
   end;
end;

// Moves characters into a buffer. The low bytes of the first Count
// words of Dest are set to C, or remain unchanged if C = #0. The high
// bytes of the words are set to Attr, or remain unchanged if Attr is
// zero.

procedure MoveChar(var Dest; C: Char; Attr: Byte; Count: Word);
VAR I: Word;
begin
   For I := 1 To Count Do begin
     If (Attr <> 0) Then
       WordRec(TWordArray(Dest)[I-1]).Hi := Attr;     { Copy attribute }
     If (Ord(C)<>0) Then
       WordRec(TWordArray(Dest)[I-1]).Lo := Byte(C);  { Copy character }
   end;
end;

// Moves a two-colored string into a buffer. The characters in Str are
// moved into the low bytes of corresponding words in Dest. The high
// bytes of the words are set to Lo(Attr) or Hi(Attr). Tilde characters
// (~) in the string toggle between the two attribute bytes passed in
// the Attr word.

procedure MoveCStr(var Dest; Str: String; Attrs: SmallWord);
VAR B: Byte; I, J: Word;
begin
   J := 0;                                            { Start position }
   For I := 1 To Length(Str) Do begin                 { For each character }
     If (Str[I] <> '~') Then begin                    { Not tilde character }
       If (Lo(Attrs) <> 0) Then
         WordRec(TWordArray(Dest)[J]).Hi := Lo(Attrs);{ Copy attribute }
       WordRec(TWordArray(Dest)[J]).Lo:=Byte(Str[I]); { Copy string char }
       Inc(J);                                        { Next position }
     end Else begin
       B := Hi(Attrs);                                { Hold attribute }
       WordRec(Attrs).Hi := Lo(Attrs);                { Copy low to high }
       WordRec(Attrs).Lo := B;                        { Complete exchange }
     end;
   end;
end;

// Moves a string into a buffer. The characters in Str are moved into
// the low bytes of corresponding words in Dest. The high bytes of the
// words are set to Attr, or remain unchanged if Attr is zero.

procedure MoveStr(var Dest; Str: String; Attr: Byte);
VAR I: Word;
begin
   For I := 1 To Length(Str) Do begin                 { For each character }
     If (Attr <> 0) Then
       WordRec(TWordArray(Dest)[I-1]).Hi := Attr;     { Copy attribute }
     WordRec(TWordArray(Dest)[I-1]).Lo:=Byte(Str[I]); { Copy string char }
   end;
end;

// Returns the length of string S, where S is a control string using
// tilde characters ('~') to designate shortcut characters. The tildes
// are excluded from the length of the string, as they will not appear
// on the screen.

function CStrLen(const S: String): Integer;
VAR I, J: Integer;
begin
   J := 0;                                            { Set result to zero }
   For I := 1 To Length(S) Do
     If (S[I] <> '~') Then Inc(J);                    { Inc count if not ~ }
   CStrLen := J;                                      { Return length }
end;


// Drivers unit initialization and shutdown
var
  SaveExit: Pointer;

procedure ExitDrivers;
begin
  DoneSysError;
  DoneEvents;
  SysTVDoneMouse(True);
  ExitProc := SaveExit;
end;

begin
  CodePage := SysGetCodePage;
  SysTVInitCursor;
  InitKeyboard;
  DetectMouse;
  DetectVideo;
  SaveExit := ExitProc;
  ExitProc := @ExitDrivers;
  CtrlBreakHandler := TVCtrlBreak;
  SysCtrlSetCBreakHandler;
end.
