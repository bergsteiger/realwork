{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

(*

Version History

03/30/2003

  DrawFlatFrame* functions made CLX-compatible
  DrawEdge implemented

03/15/2003

  Fixed the problem with aligning long text which doesn't fit into space in DrawTextExW

08/18/2002

  Improved DrawTextExW to support DT_WORD_ELLIPSIS and DT_END_ELLIPSIS in multiline mode

07/26/2002

  Fixed DrawText function to prevent automatic word wrap

11/28/2001

  New border style, fbtColorLineBorder, added

11/01/2001

  8K limitation in DrawTextW removed.

10/11/2001

  Overhang was not taken into account in NextLineW. Fixed.
  DrawFlatScrollbars incorrectly calculated the position of scrollbar in control
  that had Ctl3D = false. Fixed.

10/05/2001

  Fixed measurement of single-line DT_WORDWRAP'ed text in DrawTextW

09/12/2001

  Fixed the problem with fonts synthesized by GDI in DrawTextExW

09/11/2001

  DrawTextExW fixed to support lines with up to 8192 characters

09/08/2001

  Fixed some problems with incorrect rectangle in DrawTextExW

08/22/2001

  DrawTextW added to provide Unicode support in Win 9x.

07/27/2001

  Added AlphaFill method

05/27/2001 (c) Akzhan Abdulin

    DrawButtonFrameEx2 rewritten to support clNone color

*)

unit ElVCLUtils;

interface

uses
  Messages,
  Windows,
  Forms,
  Graphics,
  StdCtrls,
  Controls,
  Registry,
  Clipbrd,
  ElInprocHookAPI,
  Classes,
  SysUtils,
  ElStrUtils,
  ElTools;

{$IFDEF D_2}
type
  PHintInfo = ^THintInfo;
{$ENDIF}

const
  MOUSE_WHEEL_DELTA = 120;
  {$ifdef BUILDER_USED}
  {$externalsym CM_MOUSEWHEEL}
  {$endif}
  CM_MOUSEWHEEL     = CM_BASE + WM_MOUSEWHEEL;
  {$ifdef B_4_UP}
  {$externalsym WM_MOUSEWHEEL}
  {$endif}
  WM_MOUSEWHEEL     = $020A;
  {$ifdef BUILDER_USED}
  {$externalsym WM_UPDATESBFRAME}
  {$endif}
  WM_UPDATESBFRAME  = WM_USER + 1298;

{$IFNDEF B_5_UP}
  DT_HIDEPREFIX = $00100000;
  WM_CHANGEUISTATE = $0127;
  WM_UPDATEUISTATE = $0128;
  WM_QUERYUISTATE = $0129;
{$ENDIF}
{$IFDEF B_4_UP}
{$EXTERNALSYM SPI_GETKEYBOARDCUES}
  SPI_GETKEYBOARDCUES = $100A;
{$ELSE}
  SPI_GETKEYBOARDCUES = $100A;
{$ENDIF}

{$IFDEF BUILDER_USED}
const
  { gradient drawing modes }
{$EXTERNALSYM GRADIENT_FILL_RECT_H}
  GRADIENT_FILL_RECT_H = $00000000;
{$EXTERNALSYM GRADIENT_FILL_RECT_V}
  GRADIENT_FILL_RECT_V = $00000001;
{$EXTERNALSYM GRADIENT_FILL_TRIANGLE}
  GRADIENT_FILL_TRIANGLE = $00000002;
{$EXTERNALSYM GRADIENT_FILL_OP_FLAG}
  GRADIENT_FILL_OP_FLAG = $000000FF;
{$ELSE}
const
  { gradient drawing modes }
  GRADIENT_FILL_RECT_H = $00000000;
  GRADIENT_FILL_RECT_V = $00000001;
  GRADIENT_FILL_TRIANGLE = $00000002;
  GRADIENT_FILL_OP_FLAG = $000000FF;
{$ENDIF}

  SC_DRAGMOVE = $F012;
var
  ParentControlRepaintedMessage: DWORD;

{$IFNDEF MSWINDOWS}
  { 3D border styles }
  BDR_RAISEDOUTER = 1;
  BDR_SUNKENOUTER = 2;
  BDR_RAISEDINNER = 4;
  BDR_SUNKENINNER = 8;

  BDR_OUTER = 3;
  BDR_INNER = 12;
  BDR_RAISED = 5;
  BDR_SUNKEN = 10;

  EDGE_RAISED = (BDR_RAISEDOUTER or BDR_RAISEDINNER);
  EDGE_SUNKEN = (BDR_SUNKENOUTER or BDR_SUNKENINNER);
  EDGE_ETCHED = (BDR_SUNKENOUTER or BDR_RAISEDINNER);
  EDGE_BUMP = (BDR_RAISEDOUTER or BDR_SUNKENINNER);

  { Border flags }
  BF_LEFT = 1;
  BF_TOP = 2;
  BF_RIGHT = 4;
  BF_BOTTOM = 8;

  BF_TOPLEFT = (BF_TOP or BF_LEFT);
  BF_TOPRIGHT = (BF_TOP or BF_RIGHT);
  BF_BOTTOMLEFT = (BF_BOTTOM or BF_LEFT);
  BF_BOTTOMRIGHT = (BF_BOTTOM or BF_RIGHT);
  BF_RECT = (BF_LEFT or BF_TOP or BF_RIGHT or BF_BOTTOM);

  BF_DIAGONAL = $10;

  { For diagonal lines, the BF_RECT flags specify the end point of the}
  { vector bounded by the rectangle parameter.}
  BF_DIAGONAL_ENDTOPRIGHT = (BF_DIAGONAL or BF_TOP or BF_RIGHT);
  BF_DIAGONAL_ENDTOPLEFT = (BF_DIAGONAL or BF_TOP or BF_LEFT);
  BF_DIAGONAL_ENDBOTTOMLEFT = (BF_DIAGONAL or BF_BOTTOM or BF_LEFT);
  BF_DIAGONAL_ENDBOTTOMRIGHT = (BF_DIAGONAL or BF_BOTTOM or BF_RIGHT);

  BF_MIDDLE = $800;   { Fill in the middle }
  BF_SOFT = $1000;    { For softer buttons }
  BF_ADJUST = $2000;  { Calculate the space left over }
  BF_FLAT = $4000;    { For flat rather than 3D borders }
  BF_MONO = $8000;    { For monochrome borders }

  { DrawText() Format Flags }
  DT_TOP = 0;
  DT_LEFT = 0;
  DT_CENTER = 1;
  DT_RIGHT = 2;
  DT_VCENTER = 4;
  DT_BOTTOM = 8;
  DT_WORDBREAK = $10;
  DT_SINGLELINE = $20;
  DT_EXPANDTABS = $40;
  DT_TABSTOP = $80;
  DT_NOCLIP = $100;
  DT_EXTERNALLEADING = $200;
  DT_CALCRECT = $400;
  DT_NOPREFIX = $800;
  DT_INTERNAL = $1000;
//  DT_HIDEPREFIX = $00100000;
  DT_PREFIXONLY = $00200000;

  DT_EDITCONTROL = $2000;
  DT_PATH_ELLIPSIS = $4000;
  DT_END_ELLIPSIS = $8000;
  DT_MODIFYSTRING = $10000;
  DT_RTLREADING = $20000;
  DT_WORD_ELLIPSIS = $40000;
{$ENDIF}

{$IFNDEF VCL_4_USED}
type
  TWMMouseWheel = record
    Msg: Cardinal;
    Keys: SmallInt;
    WheelDelta: SmallInt;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint);
      1: (
        Pos: TSmallPoint;
        Result: Longint);
  end;

{$ENDIF}

{$IFNDEF VCL_4_USED}
type
  TImageIndex = type Integer;
{$ELSE}
{$IFNDEF B_5_UP}
type
  TImageIndex = type Integer;
{$ENDIF}
{$ENDIF}

type
  TBlendFunction = record
    BlendOp: Byte;
    BlendFlags: Byte;
    SourceConstantAlpha: Byte;
    AlphaFormat: Byte;
  end;

  PGradientRect = ^TGradientRect;
{$IFDEF BUILDER_USED}
{$ifdef B_4_UP}
{$EXTERNALSYM _GRADIENT_RECT}
{$endif}
  _GRADIENT_RECT = packed record
    UpperLeft: ULONG;
    LowerRight: ULONG;
  end;
  TGradientRect = _GRADIENT_RECT;
{$ifdef B_4_UP}
{$EXTERNALSYM GRADIENT_RECT}
{$endif}
  GRADIENT_RECT = _GRADIENT_RECT;
{$ELSE}
  _GRADIENT_RECT = packed record
    UpperLeft: ULONG;
    LowerRight: ULONG;
  end;
  TGradientRect = _GRADIENT_RECT;
  GRADIENT_RECT = _GRADIENT_RECT;
{$ENDIF}

type
  TAlphaBlend =
    function(
    hdcDest: HDC; // handle to destination DC
    nXOriginDest: Integer; // x-coord of upper-left corner
    nYOriginDest: Integer; // y-coord of upper-left corner
    nWidthDest: Integer; // destination width
    nHeightDest: Integer; // destination height
    hdcSrc: HDC; // handle to source DC
    nXOriginSrc: Integer; // x-coord of upper-left corner
    nYOriginSrc: Integer; // y-coord of upper-left corner
    nWidthSrc: Integer; // source width
    nHeightSrc: Integer; // source height
    blendFunction: Integer // alpha-blending function

    ): BOOL; stdcall;

type

  TElLinkCtlPos = (lcpLeftTop, lcpLeftBottom, lcpLeftCenter,
    lcpTopLeft, lcpTopRight, lcpTopCenter,
    lcpRightTop, lcpRightBottom, lcpRightCenter,
    lcpBottomLeft, lcpBottomRight, lcpBottomCenter);

  TElBkGndType = (bgtTileBitmap, bgtStretchBitmap, bgtColorFill,
    bgtCenterBitmap, bgtHorzGradient, bgtVertGradient, bgtTopLeftBitmap);
  TElBorderSide = (ebsLeft, ebsRight, ebsTop, ebsBottom);
  TElBorderSides = set of TElBorderSide;
  TElFlatBorderType = (fbtFlat, fbtSunken, fbtSunkenInner,
    fbtSunkenOuter, fbtRaised, fbtRaisedInner, fbtRaisedOuter,
    fbtBump, fbtBigBump, fbtEtched, fbtFramed,
    fbtLine, fbtLineBorder, fbtNone, fbtColorLineBorder);

  TElTextDrawType = (tdtNormal, tdtShadowed, tdtRaised);
  TElArrowDir = (eadLeft, eadUp, eadRight, eadDown);

  TTaskbarEdge = (tbeBottom, tbeLeft, tbeTop, tbeRight);

  TElTextCase = (etcNoChange, etcUppercase, etcLowercase);

{$IFNDEF BUILDER_USED}
  HDC = Windows.HDC;
{$ENDIF}

const

  AllBorderSides: TElBorderSides = [ebsLeft, ebsRight, ebsTop, ebsBottom];


const
  smXEdge: array[boolean] of DWORD = (SM_CXBORDER, SM_CXEDGE);
  smYEdge: array[boolean] of DWORD = (SM_CYBORDER, SM_CYEDGE);

function GetSysTrayRect: TRect;
function GetTaskbarEdge: TTaskbarEdge;
function GetTaskbarRect: TRect;

procedure MinimizeToTray(Wnd: HWND);

procedure GradientFill(DC: HDC; R: TRect; StartColor, EndColor: TColor; Steps:
  integer; Vertical: boolean);

procedure GradientFillEx(DC: HDC; DCRect, R: TRect; Origin: TPoint;
  StartColor, EndColor: TColor; Steps: integer;
  Vertical: boolean);
// DCRect - the rectangle of the "real DC", i.e. the DC, on which the painting is
//          usually performed
// R      - the real rectangle to be painted
// Origin - The original point, i.e. the point, which, when addded to R, would have
//          been copied from the "real DC"

function GetTopOwnerControl(Component: TComponent): TControl;

function GetKeybTimes(TimeKind: integer): integer;
// correct parameter values are SPI_GETKEYBOARDDELAY and SPI_GETKEYBOARDSPEED

function FindVCLChild(Control: TWinControl; ChildHandle: HWND): TWinControl;
function GetOwnerFrameForm(Component: TComponent): TWinControl;
function GetTopWindowHandle(Child: HWND): HWND;

function HitTest(R: TRect; Pt: TPoint; CornerSize, BorderSize: integer):
integer;

//procedure FillSolidRect2(DC : QPainterH; Rect : TRect; Color : TColor);
//procedure FillSolidRect(DC : QPainterH; x, y, cx, cy : integer; Color : TColor);

procedure FillSolidRect2(DC: HDC; Rect: TRect; Color: TColor);
procedure FillSolidRect(DC: HDC; x, y, cx, cy: integer; Color: TColor);

procedure TiledPaint(Canvas: TCanvas; Bitmap: TBitmap; Rect: TRect);
// destination rectangle is meant.

procedure DrawEdge(DC: HDC; var RC: TRect; edge: UINT; grfFlags: UINT);
procedure DrawEdgeEx(DC: HDC; var RC: TRect; edge: UINT; grfFlags: UINT; Color1, Color2, Color3, Color4 : TColor);

procedure DrawButtonFrame(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean);
procedure DrawButtonFrameEx2(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean; ButtonColor: TColor; Thin: boolean; clrHighlight, clrDkShadow, clrFace,
  clrShadow: TColor; BorderSides : TElBorderSides);
procedure DrawButtonFrameEx3(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean;
  ButtonColor: TColor; Thin: boolean; BorderSides: TElBorderSides);
procedure Draw3dBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4:
  TColor);

procedure Draw3dRectEx(DC: HDC; x, y, cx, cy: integer; clrTopLeft,
  clrBottomRight: COLORREF;
  BorderSides: TElBorderSides);

function DrawBevel(DC: HDC; R: TRect; Color1, Color2: TColor; Sides:
  TElBorderSides): TRect;

function DrawFlatFrame(DC: HDC; R: TRect; BkColor: TColor; Focused: boolean):
TRect;
function DrawFlatFrame2(DC: HDC; R: TRect; BkColor: TColor; Focused: boolean;
  BorderSides: TElBorderSides): TRect;
{$ifdef MSWINDOWS}
procedure DrawFlatFrameEx(DC: HDC; R: TRect; BkColor: TColor; Focused, Enabled:
  boolean);
{$endif}
procedure DrawFlatFrameEx2(DC: HDC; R: TRect; Color, BkColor: TColor;
  Focused, Enabled: boolean;
  BorderSides: TElBorderSides;
  BorderType: TElFlatBorderType;
  Color1, Color2, Color3, Color4, Color5 : TColor);

function DrawFlatScrollbars(
  Wnd: HWND; DC: HDC;
  Rect: TRect; Focused: boolean;
  ScrollBars: TScrollStyle; DragHorz, DragVert: boolean;
  IsControl: boolean; Style, ExStyle: integer): TRect;

procedure DrawTypedText(Canvas: TCanvas; Bounds: TRect; Text: string; Flags:
  integer; DrawType: TElTextDrawType);
{$IFNDEF BROKEN_UNICODE}
procedure DrawTypedTextW(Canvas: TCanvas; Bounds: TRect; Text: WideString;
  Flags: integer; DrawType: TElTextDrawType);
{$ENDIF}

procedure DrawFlatScrollbarThumb(DC: HDC; rc: TRect; Focused: boolean);

procedure DrawTransparentBitmapEx(DC: HDC; Bitmap: TBitmap; X, Y: integer; Src:
  TRect; Transparent: TColor);

procedure DrawArrow(Canvas: TCanvas; Dir: TElArrowDir; R: TRect; Color: TColor;
  Enabled: boolean);

function RectsIntersect(R1, R2: TRect): boolean;
function RectVisible(Canvas : TCanvas; R: TRect): boolean;


function GetDesktopTop: integer;
function GetDesktopLeft: integer;
function GetDesktopBottom: integer;
function GetDesktopRight: integer;
function GetDesktopRect: TRect;

function GetWorkSpaceTop: integer;
function GetWorkSpaceLeft: integer;
function GetWorkSpaceBottom: integer;
function GetWorkSpaceRight: integer;
function GetWorkSpaceRect: TRect;

const
  WaitCursor: TCursor = crHourGlass;

procedure StartWait;
procedure StopWait;

function InvertColor(aColor: TColor): TColor;

function RGBtoHLS(rgbc: integer): integer;
function HLStoRGB(hlsc: integer): integer;

procedure DrawFlatScrollBarsEx(
  Wnd: HWND; DC: HDC;
  Rect: TRect; Focused: boolean; ScrollBars: TScrollStyle;
  DragHorz, DragVert: boolean; IsControl: boolean;
  BkColor, DitherColor, ButtonColor, ArrowColor, hotbuttonColor: TColor;
  DrawFrames, DitherBack: boolean);

procedure DrawFlatScrollBarEx(
  Wnd: HWND; DC: HDC;
  Rect: TRect; nType: integer; bScrollbarCtrl: boolean;
  Dragging: boolean; Focused: boolean;
  BkColor, DitherColor, ButtonColor, ArrowColor, HotButtonColor: TColor;
  DrawFrames, DitherBack: boolean);

function AlphaBlend(
  hdcDest: HDC; // handle to destination DC
  nXOriginDest: Integer; // x-coord of upper-left corner
  nYOriginDest: Integer; // y-coord of upper-left corner
  nWidthDest: Integer; // destination width
  nHeightDest: Integer; // destination height
  hdcSrc: HDC; // handle to source DC
  nXOriginSrc: Integer; // x-coord of upper-left corner
  nYOriginSrc: Integer; // y-coord of upper-left corner
  nWidthSrc: Integer; // source width
  nHeightSrc: Integer; // source height
  SourceConstantAlpha: Byte;
    // Specifies an alpha transparency value to be used on the entire source bitmap
  srcAlpha: byte
  ): Boolean;

{$IFNDEF D_2}
procedure AlphaCopyRect(DestDC: HDC; Dest: TRect; SourceDC: HDC; Source: TRect;
  AlphaLevel: byte; UseAlphaLevel: boolean);
procedure AlphaCopyRect2(DestDC: HDC; Dest: TRect; SourceDC: HDC; Source: TRect;
  Mask: TBitmap; AlphaLevel: byte);
function IsAlphaEmpty(bmp: TBitmap): boolean;
procedure ClearAlpha(var bmp: TBitmap);
procedure AlphaFillRect(Canvas: TCanvas; Rect: TRect; Color: TColor; AlphaLevel:
  byte);
{$ENDIF}


function DrawTextW(hDC: HDC; lpString: PWideChar; nCount: Integer; var lpRect:
  TRect; uFormat: UINT): Integer;
function GetSysColorPen(Color: COLORREF): HPEN;

function IncColor(const Color: TColor; RInc, GInc, BInc: integer): integer;

procedure DrawFocus(Canvas: TCanvas; R: TRect);

function Win2KHideUIState: boolean;

function ModalFormVisible: boolean;

function ShiftStateToKeyData(Shift: TShiftState): integer;

function GetTimeAMChar: char;
function GetTimePMChar: char;

{$IFDEF BUILDER_USED}
{$EXTERNALSYM GetGValue}
function GetGValue(aColor: TColor): byte;
{$EXTERNALSYM GetBValue}
function GetBValue(aColor: TColor): byte;
{$EXTERNALSYM GetRValue}
function GetRValue(aColor: TColor): byte;
{$EXTERNALSYM RGB}
function RGB(R, G, B: byte): TColor;
{$ELSE}
function GetGValue(aColor: TColor): byte;
function GetBValue(aColor: TColor): byte;
function GetRValue(aColor: TColor): byte;
function RGB(R, G, B: byte): TColor;
{$ENDIF}

function ColorDarker(const OriginalColor: TColor; const Percent: Byte): TColor;
function ColorLighter(const Color: TColor; const Percent: Byte): TColor;

{$IFDEF ELPACK_UNICODE}
function GetShortHintW(Hint: WideString): WideString;
{$ENDIF}

procedure CopyTextToClipboard(AText: TElFString);

procedure FreeAndNil(var Obj);

function GetOwnerForm(Component: TComponent): TForm;
function GetRootComponent(Component: TComponent): TComponent;

{< VCL DFM UTILS}

type

  TElReader = class(TReader)
  {$IFNDEF VCL_4_UP}
  protected
    procedure SkipSetBody;
    procedure SkipProperty;
  {$ENDIF}
  {$IFDEF D_5_UP}
  procedure ReadPropertyFix(AInstance: TPersistent); // - Fix read TPersistent complex property defined by means of DefineProperty
  {$ENDIF}
  public

    procedure FakeDefineProperty(Filer: TFiler);

    procedure SkipValue;

    procedure FakeValue(Reader: TReader); // - Skip any property. (Except for complex: persistent.property)

    procedure FakeInteger(Reader: TReader);
    procedure FakeBoolean(Reader: TReader);
    procedure FakeStr(Reader: TReader);
    procedure FakeIdent(Reader: TReader);
  end;

  function GetElReader : TElReader;

{> VCL DFM UTILS}

function DWordToStr(Value:DWORD):String;

{$IFDEF MSWINDOWS}
function GetScrollBarPos( hWnd: THandle; BarFlag:Integer ):Integer;
{$IFNDEF VCL_5_USED}
function SafeLoadLibrary(const FileName: string): HMODULE;
{$ENDIF IFNDEF VCL_5_USED}
{$ENDIF IFDEF MSWINDOWS}

implementation

uses
  {$IFDEF D_6_UP}
  RTLConsts,
  {$ELSE}
  Consts,
  {$ENDIF}
  TypInfo;

type
  TTriVertex = packed record
    x: longint;
    y: longint;
    Red: word;
    Green: word;
    Blue: word;
    Alpha: word;
  end;

  TGradientFillProc = function(DC: HDC; Verteces: pointer; NumVerteces: DWORD;
    Meshes: pointer; NumMeshes: DWORD; Mode: DWORD): DWORD; stdcall;

var
  MSImg32Lib: THandle;
  GradientFillProc: TGradientFillProc;

function GetTimeAMChar: char;
begin
  if Length(TimeAMString) > 0 then
    result := TimeAMString[1]
  else
    result := #0;
end;

function GetTimePMChar: char;
begin
  if Length(TimePMString) > 0 then
    result := TimePMString[1]
  else
    result := #0;
end;

function ColorLighter(const Color: TColor; const Percent: Byte): TColor;
var
  R, G, B: Byte;
  FColor: TColorRef;
begin
  FColor := ColorToRGB(Color);

  R := GetRValue(FColor);
  G := GetGValue(FColor);
  B := GetBValue(FColor);

  R := R + muldiv(255 - r, Percent, 100);
  G := G + muldiv(255 - g, Percent, 100);
  B := B + muldiv(255 - b, Percent, 100);

  Result := RGB(R, G, B);
end;

function ColorDarker(const OriginalColor: TColor; const Percent: Byte): TColor;
var
  R, G, B: Integer;
  WinColor: Integer;
begin
  WinColor := ColorToRGB(OriginalColor);
  R := GetRValue(WinColor);
  G := GetGValue(WinColor);
  B := GetBValue(WinColor);

  R := MulDiv(R, Percent, 100);
  G := MulDiv(G, Percent, 100);
  B := MulDiv(B, Percent, 100);

  if R < 0 then R := 0;
  if G < 0 then G := 0;
  if B < 0 then B := 0;

  Result := RGB(R, G, B);
end;

function IncColor(const Color: TColor; RInc, GInc, BInc: integer): integer;
var
  r, g, b: integer;
begin
  r := (ColorToRgb(Color) and $0000FF) + RInc;
  g := (ColorToRgb(Color) and $00FF00) shr 8 + GInc;
  b := (ColorToRgb(Color) and $FF0000) shr 16 + BInc;

  if r < 0 then
    r := 0
  else
    if r > 255 then
    r := 255;
  if g < 0 then
    g := 0
  else
    if g > 255 then
    g := 255;
  if b < 0 then
    b := 0
  else
    if b > 255 then
    b := 255;
  result := (b shl 16) or (g shl 8) or r;
end;

function GetBValue(aColor: TColor): Byte;
begin
  result := (ColorToRgb(aColor) and $FF0000) shr 16;
end;

function GetGValue(aColor: TColor): Byte;
begin
  result := (ColorToRgb(aColor) and $00FF00) shr 8;
end;

function GetRValue(aColor: TColor): Byte;
begin
  result := (ColorToRgb(aColor) and $0000FF);
end;

function RGB(R, G, B: Byte): TColor;
begin
  result := (b shl 16) or (g shl 8) or r;
end;

function InvertColor(aColor: TColor): TColor;
var
  r, g, b: integer;
begin
  r := GetRValue(ColorToRgb(aColor));
  g := GetGValue(ColorToRgb(aColor));
  b := GetBValue(ColorToRgb(aColor));

  r := (not r) and $000000FF;
  g := ((not g) and $000000FF) shl 8;
  b := ((not b) and $000000FF) shl 16;

  Result := b or g or r;
end;


function GetWorkSpaceRect: TRect;

const
  SM_XVIRTUALSCREEN = 76;
  SM_YVIRTUALSCREEN = 77;
  SM_CXVIRTUALSCREEN = 78;
  SM_CYVIRTUALSCREEN = 79;

begin
  if IsWin98Up or IsWin2000Up then
  begin
    result.Left := 0;
    result.Top := 0;
    result.Right := GetSystemMetrics(SM_CXVIRTUALSCREEN);
    result.Bottom := GetSystemMetrics(SM_CYVIRTUALSCREEN);
    OffsetRect(Result, getsystEmmetrics(SM_XVIRTUALSCREEN),
      GetSystemMetrics(SM_YVIRTUALSCREEN));
  end
  else
  begin
    result.Left := 0;
    result.Top := 0;
    result.Right := GetSystemMetrics(SM_CXSCREEN);
    result.Bottom := GetSystemMetrics(SM_CYSCREEN);
  end;
end;

function GetWorkSpaceTop: integer;
begin
  result := GetWorkSpaceRect.Top;
end;

function GetWorkSpaceLeft: integer;
begin
  result := GetWorkSpaceRect.Left;
end;

function GetWorkSpaceBottom: integer;
begin
  result := GetWorkSpaceRect.Bottom;
end;

function GetWorkSpaceRight: integer;
begin
  result := GetWorkSpaceRect.Right;
end;

function GetDesktopRect: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @result, 0);
end;

function GetDesktopTop: integer;
begin
  result := GetDesktopRect.Top;
end;

function GetDesktopLeft: integer;
begin
  result := GetDesktopRect.Left;
end;

function GetDesktopBottom: integer;
begin
  result := GetDesktopRect.Bottom;
end;

function GetDesktopRight: integer;
begin
  result := GetDesktopRect.Right;
end;

procedure MinimizeToTray(Wnd: HWND);
var
  WinPlace: TWindowPlacement;
  R: TRect;
begin
  WinPlace.length := SizeOf(TWindowPlacement);
  GetWindowPlacement(Wnd, @WinPlace);
  WinPlace.flags := WPF_SETMINPOSITION;
  R := GetSysTrayRect;
  WinPlace.ptMinPosition.x := R.Left;
  WinPlace.ptMinPosition.y := R.Top;
  SetWindowPlacement(Wnd, @WinPlace);
  SendMessage(Wnd, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

function GetSysTrayRect: TRect;
var
  H1,
    H2: HWND;
begin
  SetRectEmpty(result);
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    H2 := FindWindowEx(H1, 0, 'TrayNotifyWnd', nil);
    if H2 <> 0 then
      GetWindowRect(H2, result);
  end;
end;

function GetTaskbarRect: TRect;
var
  H1: HWND;
begin
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
    GetWindowRect(H1, Result)
  else
    SetRectEmpty(result);
end;

function GetTaskbarEdge: TTaskbarEdge;
var
  H1: HWND;
  R: TRect;
  DesktopWidth,
    DesktopHeight: integer;
begin
  result := tbeBottom;
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    R := GetWorkSpaceRect;
    DesktopWidth := R.Right - R.Left;
    DesktopHeight := R.Bottom - R.Top;
    GetWindowRect(H1, R);
    if R.Top > DesktopHeight div 2 then
      result := tbeBottom
    else
      if R.Right < DesktopWidth div 2 then
      result := tbeLeft
    else
      if R.Bottom < DesktopHEight div 2 then
      result := tbeTop
    else
      if R.Left > DesktopWidth div 2 then
      result := tbeRight;
  end;
end;


{$WARNINGS off}

function GetKeybTimes(TimeKind: integer): integer;
begin
  SystemParametersInfo(TimeKind, 0, @result, 0);
  if TimeKind = SPI_GETKEYBOARDSPEED then
  begin
    result := 1000 div (result + 1);
  end
  else
    if TimeKind = SPI_GETKEYBOARDDELAY then
  begin
    result := 250 * (result + 1);
  end;
end;
{$WARNINGS on}

procedure GradientFillEx(DC: HDC; DCRect, R: TRect; Origin: TPoint; StartColor,
  EndColor: TColor; Steps: integer; Vertical: boolean);
var
  i: integer;
  RBeg, RDif, Rc,
    GBeg, GDif, Gc,
    BBeg, BDif, Bc: integer;
  Brush,
    OldBrush: HBrush;
  R1, R2, R3: TRect;
begin
  if StartColor = EndColor then
  begin
    Brush := CreateSolidBrush(ColorToRGB(StartColor));
    FillRect(DC, R, Brush);
    DeleteObject(Brush);
  end
  else
  begin
    RBeg := GetRValue(ColorToRGB(StartColor));
    GBeg := GetGValue(ColorToRGB(StartColor));
    BBeg := GetBValue(ColorToRGB(StartColor));
    RDif := GetRValue(ColorToRGB(EndColor)) - RBeg;
    GDif := GetGValue(ColorToRGB(EndColor)) - GBeg;
    BDif := GetBValue(ColorToRGB(EndColor)) - BBeg;
    R1 := R;
    for i := 0 to Steps - 1 do // Iterate
    begin
      if Vertical then
      begin
        R1.Top := R.Top + MulDiv(i, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Top + MulDiv(i + 1, R.Bottom - R.Top, Steps);
      end
      else
      begin
        R1.Left := R.Left + MulDiv(i, R.Right - R.Left, Steps);
        R1.Right := R.Left + MulDiv(i + 1, R.Right - R.Left, Steps);
      end;
      R3 := DCRect;
      OffsetRect(R3, Origin.X, Origin.Y);
      IntersectRect(R2, R3, R1);
      if not IsRectEmpty(R2) then
      begin
        //R2 := R1;
        OffsetRect(R2, -Origin.x, -Origin.y);
        Rc := RBeg + MulDiv(i, RDif, Steps - 1);
        Gc := GBeg + MulDiv(i, GDif, Steps - 1);
        Bc := BBeg + MulDiv(i, BDif, Steps - 1);

        Brush := CreateSolidBrush(RGB(Rc, Gc, Bc));
        OldBrush := SelectObject(DC, Brush);
        PatBlt(DC, R2.Left, R2.Top, R2.Right - R2.Left, R2.Bottom - R2.Top,
          PATCOPY);
        SelectObject(DC, OldBrush);
        DeleteObject(Brush);
      end;
    end; // for
  end;
end;

procedure GradientFill(DC: HDC; R: TRect; StartColor, EndColor: TColor; Steps:
  integer; Vertical: boolean);
var
  i: integer;
  c1,
    c2: TColorRef;
  RBeg, RDif, Rc,
    GBeg, GDif, Gc,
    BBeg, BDif, Bc: integer;

  Brush,
    OldBrush: HBrush;
  Verteces: array[0..1] of TTriVertex;
  GradientRect: TGradientRect;

  R1: TRect;
begin
  c1 := ColorToRGB(StartColor);
  c2 := ColorToRGB(EndColor);
  if c1 = c2 then
  begin
    Brush := CreateSolidBrush(ColorToRGB(StartColor));
    FillRect(DC, R, Brush);
    DeleteObject(Brush);
  end
  else
    if (IsWin98Up or IsWin2000Up) and (@GradientFillProc <> nil) then
  begin
    Verteces[0].x := R.Left;
    Verteces[0].y := R.Top;
    Verteces[0].Red := GetRValue(c1) shl 8;
    Verteces[0].Green := GetGValue(c1) shl 8;
    Verteces[0].Blue := GetBValue(c1) shl 8;
    Verteces[0].Alpha := 0;
    Verteces[1].x := R.Right;
    Verteces[1].y := R.Bottom;
    Verteces[1].Red := GetRValue(c2) shl 8;
    Verteces[1].Green := GetGValue(c2) shl 8;
    Verteces[1].Blue := GetBValue(c2) shl 8;
    Verteces[1].Alpha := 0;
    GradientRect.UpperLeft := 0;
    GradientRect.LowerRight := 1;
    if Vertical then
      GradientFillProc(DC, @Verteces[0], 2, @GradientRect, 1,
        GRADIENT_FILL_RECT_V)
    else
      GradientFillProc(DC, @Verteces[0], 2, @GradientRect, 1,
        GRADIENT_FILL_RECT_H);
  end
  else
  begin
    RBeg := GetRValue(c1);
    GBeg := GetGValue(c1);
    BBeg := GetBValue(c1);
    RDif := GetRValue(c2) - RBeg;
    GDif := GetGValue(c2) - GBeg;
    BDif := GetBValue(c2) - BBeg;

    R1 := R;
    for i := 0 to Steps - 1 do // Iterate
    begin
      if Vertical then
      begin
        R1.Top := R.Top + MulDiv(i, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Top + MulDiv(i + 1, R.Bottom - R.Top, Steps);
      end
      else
      begin
        R1.Left := R.Left + MulDiv(i, R.Right - R.Left, Steps);
        R1.Right := R.Left + MulDiv(i + 1, R.Right - R.Left, Steps);
      end;

      Rc := RBeg + MulDiv(i, RDif, Steps - 1);
      Gc := GBeg + MulDiv(i, GDif, Steps - 1);
      Bc := BBeg + MulDiv(i, BDif, Steps - 1);

      Brush := CreateSolidBrush(RGB(Rc, Gc, Bc));
      OldBrush := SelectObject(DC, Brush);
      PatBlt(DC, R1.Left, R1.Top, R1.Right - R1.Left, R1.Bottom - R1.Top,
        PATCOPY);
      SelectObject(DC, OldBrush);
      DeleteObject(Brush);
    end; // for
  end;
end;

procedure DrawArrow(Canvas: TCanvas; Dir: TElArrowDir; R: TRect; Color: TColor;
  Enabled: boolean);
var
  FSavePenColor: TColor;
  DestRect: TRect;
begin
  FSavePenColor := Canvas.Pen.Color;
  if Enabled then
    Canvas.Pen.Color := Color
  else
    Canvas.Pen.Color := clBtnHighlight;
  case Dir of
    eadRight:
      begin
        if (R.Right - R.Left < 3) or (R.Bottom - R.Top < 6) then exit;
        CenterRects(4, R.Right - R.Left, 7, R.Bottom - R.Top, DestRect);
        if not Enabled then
          OffsetRect(DestRect, R.Left + 1, R.Top + 1)
        else
          OffsetRect(DestRect, R.Left, R.Top);

        with Canvas do
        begin
          MoveTo(DestRect.Left, DestRect.Top);
          LineTo(DestRect.Left, DestRect.Top + 7);
          MoveTo(DestRect.Left + 1, DestRect.Top + 1);
          LineTo(DestRect.Left + 1, DestRect.Top + 6);
          MoveTo(DestRect.Left + 2, DestRect.Top + 2);
          LineTo(DestRect.Left + 2, DestRect.Top + 5);
          MoveTo(DestRect.Left + 3, DestRect.Top + 3);
          LineTo(DestRect.Left + 3, DestRect.Top + 4);
          (*
          {$ifndef CLX_USED}
          Pixels[DestRect.Left + 3, DestRect.Top + 3] := Canvas.Pen.Color;
          {$else}
          DrawPoint(DestRect.Left + 3, DestRect.Top + 3);
          {$endif}
          *)
          if not Enabled then
          begin
            Canvas.Pen.Color := clBtnShadow;
            OffsetRect(DestRect, -1, -1);
            MoveTo(DestRect.Left, DestRect.Top);
            LineTo(DestRect.Left, DestRect.Top + 7);
            MoveTo(DestRect.Left + 1, DestRect.Top + 1);
            LineTo(DestRect.Left + 1, DestRect.Top + 6);
            MoveTo(DestRect.Left + 2, DestRect.Top + 2);
            LineTo(DestRect.Left + 2, DestRect.Top + 5);
            MoveTo(DestRect.Left + 3, DestRect.Top + 3);
            LineTo(DestRect.Left + 3, DestRect.Top + 4);

            (*
            {$ifndef CLX_USED}
            Pixels[DestRect.Left + 3, DestRect.Top + 3] := Canvas.Pen.Color;
            {$else}
            DrawPoint(DestRect.Left + 3, DestRect.Top + 3);
            {$endif}
            *)
          end;
        end;
      end;
    eadUp:
      begin
        if (R.Right - R.Left < 6) or (R.Bottom - R.Top < 3) then exit;
        CenterRects(7, R.Right - R.Left, 4, R.Bottom - R.Top, DestRect);
        if not Enabled then
          OffsetRect(DestRect, R.Left + 1, R.Top + 1)
        else
          OffsetRect(DestRect, R.Left, R.Top);
        with Canvas do
        begin
          //mdm - Decremented all "LineTo(DestRect.Left" by one to draw properly
          MoveTo(DestRect.Left, DestRect.Top + 3);
          LineTo(DestRect.Left + 7, DestRect.Top + 3);

          MoveTo(DestRect.Left + 1, DestRect.Top + 2);
          LineTo(DestRect.Left + 6, DestRect.Top + 2);

          MoveTo(DestRect.Left + 2, DestRect.Top + 1);
          LineTo(DestRect.Left + 5, DestRect.Top + 1);

          MoveTo(DestRect.Left + 3, DestRect.Top);
          LineTo(DestRect.Left + 4, DestRect.Top);

          (*
          {$ifndef CLX_USED}
          Pixels[DestRect.Left + 3, DestRect.Top] := Canvas.Pen.Color;
          {$else}
          DrawPoint(DestRect.Left + 3, DestRect.Top);
          {$endif}
          *)

          if not Enabled then
          begin
            Canvas.Pen.Color := clBtnShadow;
            OffsetRect(DestRect, -1, -1);
            MoveTo(DestRect.Left, DestRect.Top + 3);
            LineTo(DestRect.Left + 7, DestRect.Top + 3);

            MoveTo(DestRect.Left + 1, DestRect.Top + 2);
            LineTo(DestRect.Left + 6, DestRect.Top + 2);

            MoveTo(DestRect.Left + 2, DestRect.Top + 1);
            LineTo(DestRect.Left + 5, DestRect.Top + 1);

            MoveTo(DestRect.Left + 3, DestRect.Top);
            LineTo(DestRect.Left + 4, DestRect.Top);

            (*
            {$ifndef CLX_USED}
            Pixels[DestRect.Left + 3, DestRect.Top] := Canvas.Pen.Color;
            {$else}
            DrawPoint(DestRect.Left + 3, DestRect.Top);
            {$endif}
            *)
          end;
        end;
      end;
    eadLeft:
      begin
        if (R.Right - R.Left < 3) or (R.Bottom - R.Top < 6) then exit;
        CenterRects(4, R.Right - R.Left, 7, R.Bottom - R.Top, DestRect);
        if not Enabled then
          OffsetRect(DestRect, R.Left + 1, R.Top + 1)
        else
          OffsetRect(DestRect, R.Left, R.Top);
        with Canvas do
        begin
          MoveTo(DestRect.Left + 3, DestRect.Top);
          LineTo(DestRect.Left + 3, DestRect.Top + 7);
          MoveTo(DestRect.Left + 2, DestRect.Top + 1);
          LineTo(DestRect.Left + 2, DestRect.Top + 6);
          MoveTo(DestRect.Left + 1, DestRect.Top + 2);
          LineTo(DestRect.Left + 1, DestRect.Top + 5);

          MoveTo(DestRect.Left, DestRect.Top + 3);
          LineTo(DestRect.Left, DestRect.Top + 4);

          (*
          {$ifndef CLX_USED}
          Pixels[DestRect.Left, DestRect.Top + 3] := Canvas.Pen.Color;
          {$else}
          DrawPoint(DestRect.Left, DestRect.Top + 3);
          {$endif}
          *)
          if not Enabled then
          begin
            Canvas.Pen.Color := clBtnShadow;
            OffsetRect(DestRect, -1, -1);
            MoveTo(DestRect.Left + 3, DestRect.Top);
            LineTo(DestRect.Left + 3, DestRect.Top + 7);
            MoveTo(DestRect.Left + 2, DestRect.Top + 1);
            LineTo(DestRect.Left + 2, DestRect.Top + 6);
            MoveTo(DestRect.Left + 1, DestRect.Top + 2);
            LineTo(DestRect.Left + 1, DestRect.Top + 5);

            MoveTo(DestRect.Left, DestRect.Top + 3);
            LineTo(DestRect.Left, DestRect.Top + 4);

            (*
            {$ifndef CLX_USED}
            Pixels[DestRect.Left, DestRect.Top + 3] := Canvas.Pen.Color;
            {$else}
            DrawPoint(DestRect.Left, DestRect.Top + 3);
            {$endif}
            *)
          end;
        end;
      end;
    eadDown:
      begin
        if (R.Right - R.Left < 6) or (R.Bottom - R.Top < 3) then exit;
        CenterRects(7, R.Right - R.Left, 4, R.Bottom - R.Top, DestRect);
        if not Enabled then
          OffsetRect(DestRect, R.Left + 1, R.Top + 1)
        else
          OffsetRect(DestRect, R.Left, R.Top);
        with Canvas do
        begin
          MoveTo(DestRect.Left, DestRect.Top);
          LineTo(DestRect.Left + 7, DestRect.Top);

          MoveTo(DestRect.Left + 1, DestRect.Top + 1);
          LineTo(DestRect.Left + 6, DestRect.Top + 1);

          MoveTo(DestRect.Left + 2, DestRect.Top + 2);
          LineTo(DestRect.Left + 5, DestRect.Top + 2);

          MoveTo(DestRect.Left + 3, DestRect.Top + 3);
          LineTo(DestRect.Left + 4, DestRect.Top + 3);
          (*
          {$ifndef CLX_USED}
          Pixels[DestRect.Left + 3, DestRect.Top + 3] := Canvas.Pen.Color;
          {$else}
          DrawPoint(DestRect.Left + 3, DestRect.Top + 3);
          {$endif}
          *)
          if not Enabled then
          begin
            Canvas.Pen.Color := clBtnShadow;
            OffsetRect(DestRect, -1, -1);

            MoveTo(DestRect.Left, DestRect.Top);
            LineTo(DestRect.Left + 7, DestRect.Top);

            MoveTo(DestRect.Left + 1, DestRect.Top + 1);
            LineTo(DestRect.Left + 6, DestRect.Top + 1);

            MoveTo(DestRect.Left + 2, DestRect.Top + 2);
            LineTo(DestRect.Left + 5, DestRect.Top + 2);

            MoveTo(DestRect.Left + 3, DestRect.Top + 3);
            LineTo(DestRect.Left + 4, DestRect.Top + 3);

            (*
            {$ifndef CLX_USED}
            Pixels[DestRect.Left + 3, DestRect.Top + 3] := Canvas.Pen.Color;
            {$else}
            DrawPoint(DestRect.Left + 3, DestRect.Top + 3);
            {$endif}
            *)
          end;
        end;
      end;
  end;
  Canvas.Pen.Color := FSavePenColor;
end;

function RectsIntersect(R1, R2: TRect): boolean;
var
  R: TRect;
begin
  IntersectRect(R, R1, R2);
  result := not IsRectEmpty(R);
end;

function RectVisible(Canvas : TCanvas; R: TRect): boolean;
begin
  result := Windows.RectVisible(Canvas.Handle, R);
end;


function FindVCLChild(Control: TWinControl; ChildHandle: HWND): TWinControl;
var
  i: integer;
  C: TWinControl;
begin
  for i := 0 to Control.ControlCount - 1 do // Iterate
  begin
    if Control.Controls[i] is TWinControl then
    begin
      C := TWinControl(Control.Controls[i]);
      if C.HandleAllocated and (C.Handle = ChildHandle) then
      begin
        result := C;
        exit;
      end;
    end;
  end; // for
  result := nil;
end;


procedure DrawTransparentBitmapEx(DC: HDC; Bitmap: TBitmap; X, Y: integer; Src:
  TRect; Transparent: TColor);
var
  cColor: TColorRef;
  bmAndBack,
    bmAndObject,
    bmAndMem,
    bmSave,
    bmBackOld,
    bmObjectOld,
    bmMemOld,
    bmSaveOld: HBitmap;
  hdcMem,
    hdcBack,
    hdcObject,
    hdcTemp,
    hdcSave: HDC;
  bmWidth, bmHeight: integer;
begin
  hdcTemp := CreateCompatibleDC(DC);
  SelectObject(hdcTemp, Bitmap.Handle); { select the bitmap }

  bmWidth := Src.Right - Src.Left;
  bmHeight := Src.Bottom - Src.Top;

   { create some DCs to hold temporary data }
  hdcBack := CreateCompatibleDC(DC);
  hdcObject := CreateCompatibleDC(DC);
  hdcMem := CreateCompatibleDC(DC);
  hdcSave := CreateCompatibleDC(DC);

   { create a bitmap for each DC }

   { monochrome DC }
  bmAndBack := CreateBitmap(bmWidth, bmHeight, 1, 1, nil);
  bmAndObject := CreateBitmap(bmWidth, bmHeight, 1, 1, nil);

  bmAndMem := CreateCompatibleBitmap(DC, bmWidth, bmHeight);
  bmSave := CreateCompatibleBitmap(DC, bmWidth, bmHeight);

   { each DC must select a bitmap object to store pixel data }
  bmBackOld := SelectObject(hdcBack, bmAndBack);
  bmObjectOld := SelectObject(hdcObject, bmAndObject);
  bmMemOld := SelectObject(hdcMem, bmAndMem);
  bmSaveOld := SelectObject(hdcSave, bmSave);

   { set proper mapping mode }
  SetMapMode(hdcTemp, GetMapMode(DC));

   { save the bitmap sent here, because it will be overwritten }
  BitBlt(hdcSave, 0, 0, bmWidth, bmHeight, hdcTemp, Src.Left, Src.Top, SRCCOPY);

   { set the background color of the source DC to the color.
    contained in the parts of the bitmap that should be transparent }
  cColor := SetBkColor(hdcTemp, ColorToRGB(transParent));

   { create the object mask for the bitmap by performing a BitBlt()
     from the source bitmap to a monochrome bitmap }
  BitBlt(hdcObject, 0, 0, bmWidth, bmHeight, hdcTemp, Src.Left, Src.Top,
    SRCCOPY);

   { set the background color of the source DC back to the original
color }
  SetBkColor(hdcTemp, cColor);

   { create the inverse of the object mask }
  BitBlt(hdcBack, 0, 0, bmWidth, bmHeight, hdcObject, 0, 0, NOTSRCCOPY);

   { copy the background of the main DC to the destination }
  BitBlt(hdcMem, 0, 0, bmWidth, bmHeight, DC, X, Y, SRCCOPY);

   { mask out the places where the bitmap will be placed }
  BitBlt(hdcMem, 0, 0, bmWidth, bmHeight, hdcObject, 0, 0, SRCAND);

   { mask out the transparent colored pixels on the bitmap }
  BitBlt(hdcTemp, Src.Left, Src.Top, bmWidth, bmHeight, hdcBack, 0, 0, SRCAND);

   { XOR the bitmap with the background on the destination DC }
  BitBlt(hdcMem, 0, 0, bmWidth, bmHeight, hdcTemp, Src.Left, Src.Top, SRCPAINT);

   { copy the destination to the screen }
  BitBlt(DC, X, Y, bmWidth, bmHeight, hdcMem, 0, 0, SRCCOPY);

   { place the original bitmap back into the bitmap sent here }
  BitBlt(hdcTemp, Src.Left, Src.Top, bmWidth, bmHeight, hdcSave, 0, 0, SRCCOPY);

   { delete the memory bitmaps }
  DeleteObject(SelectObject(hdcBack, bmBackOld));
  DeleteObject(SelectObject(hdcObject, bmObjectOld));
  DeleteObject(SelectObject(hdcMem, bmMemOld));
  DeleteObject(SelectObject(hdcSave, bmSaveOld));

   { delete the memory DCs }
  DeleteDC(hdcMem);
  DeleteDC(hdcBack);
  DeleteDC(hdcObject);
  DeleteDC(hdcSave);
  DeleteDC(hdcTemp);
end;

{$IFNDEF BROKEN_UNICODE}

procedure DrawTypedTextW(Canvas: TCanvas; Bounds: TRect; Text: WideString;
  Flags: integer; DrawType: TElTextDrawType);
var
  Col: TColor;
begin
  case DrawType of
    tdtNormal:
      ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), Bounds,
        Flags);
    tdtShadowed:
      begin
        OffsetRect(Bounds, 2, 2);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnShadow;
        ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text),
          Bounds, Flags);
        OffsetRect(Bounds, -2, -2);
        Canvas.Font.Color := col;
        ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text),
          Bounds, Flags);
      end;
    tdtRaised:
      begin
        OffsetRect(Bounds, -1, -1);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnHighlight;
        ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text),
          Bounds, Flags);
        OffsetRect(Bounds, 1, 1);
        Canvas.Font.Color := col;
        ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text),
          Bounds, Flags);
      end;
  end;
end;
{$ENDIF}

procedure DrawTypedText(Canvas: TCanvas; Bounds: TRect; Text: string; Flags:
  integer; DrawType: TElTextDrawType);
var
  Col: TColor;
begin
  case DrawType of
    tdtNormal:
      DrawText(Canvas.Handle, PChar(Text), Length(Text), Bounds, Flags);
    tdtShadowed:
      begin
        OffsetRect(Bounds, 2, 2);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnShadow;
        DrawText(Canvas.Handle, PChar(Text), Length(Text), Bounds, Flags);
        OffsetRect(Bounds, -2, -2);
        Canvas.Font.Color := col;
        DrawText(Canvas.Handle, PChar(Text), Length(Text), Bounds, Flags);
      end;
    tdtRaised:
      begin
        OffsetRect(Bounds, -1, -1);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnHighlight;
        DrawText(Canvas.Handle, PChar(Text), Length(Text), Bounds, Flags);
        OffsetRect(Bounds, 1, 1);
        Canvas.Font.Color := col;
        DrawText(Canvas.Handle, PChar(Text), Length(Text), Bounds, Flags);
      end;
  end;
end;

procedure FillSolidRect2(DC: HDC; Rect: TRect; Color: TColor);
var
  SaveC: COLORREF;
begin
  SaveC := GetBkColor(DC);
  SetBkColor(DC, Color);
  ExtTextOut(DC, 0, 0, ETO_OPAQUE, @Rect, nil, 0, nil);
  SetBkColor(DC, SaveC);
end;

procedure FillSolidRect(DC: HDC; x, y, cx, cy: integer; Color: TColor);
var
  Rect: TRect;
  SaveC: COLORREF;
begin
  SaveC := GetBkColor(DC);
  SetBkColor(DC, Color);
  Rect := Classes.Rect(x, y, x + cx, y + cy);
  ExtTextOut(DC, 0, 0, ETO_OPAQUE, @Rect, nil, 0, nil);
  SetBkColor(DC, SaveC);
end;

procedure Draw3dRect(DC: HDC; x, y, cx, cy: integer; clrTopLeft,
  clrBottomRight: COLORREF);
begin
  Draw3DRectEx(DC, x, y, cx, cy, clrTopLeft, clrBottomRight, AllBorderSides);
end;

procedure Draw3dRectEx(DC: HDC; x, y, cx, cy: integer; clrTopLeft,
  clrBottomRight: COLORREF;
  BorderSides: TElBorderSides);
var adj : integer;
begin
  if ebsTop in BorderSides then
  begin
    if ebsRight in BorderSides then
      adj := 1
    else

      adj := 0;
    FillSolidRect(DC, x, y, cx - adj, 1, clrTopLeft);
  end;
  if ebsLeft in BorderSides then
  begin
    if ebsBottom in BorderSides then
      adj := 1
    else
      adj := 0;
    FillSolidRect(DC, x, y, 1, cy - adj, clrTopLeft);
  end;
  if ebsRight in BorderSides then
    FillSolidRect(DC, x + cx, y, -1, cy, clrBottomRight);
  if ebsBottom in BorderSides then
    FillSolidRect(DC, x, y + cy, cx , -1, clrBottomRight);
end;

procedure Draw3dBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4:
  TColor);
begin
  nColor1 := ColorToRGB(GetSysColor(nColor1));
  nColor2 := ColorToRGB(GetSysColor(nColor2));
  nColor3 := ColorToRGB(GetSysColor(nColor3));
  nColor4 := ColorToRGB(GetSysColor(nColor4));
  Draw3dRect(DC, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top,
    nColor1, nColor2);
  Draw3dRect(DC, rc.left + 1, rc.top + 1, rc.right - rc.left - 2, rc.bottom -
    rc.top - 2, nColor3, nColor4);
end;

const
  hlsMax = 252; // H, L, S vary over 0 - hlsMax; best if divisible by 6
  rgbMax = 255; // r, g, b vary over 0-rgbMax; must each fit in a byte

  hlsMaxD2 = hlsMax div 2;
  hlsMaxD3 = hlsMax div 3;
  hlsMaxD6 = hlsMax div 6;
  hlsMaxD12 = hlsMax div 12;
  hlsMaxM2D3 = hlsMax * 2 div 3;
  rgbMaxM2 = rgbMax * 2;
  undefined = (hlsMaxM2D3);

procedure checkRange(var hls: integer);
begin
  if hls < 0 then inc(hls, hlsMax);
  if hls > hlsMax then
    dec(hls, hlsMax)
end;

function RGBtoHLS(rgbc: integer): integer;
var
  r, g, b, h, l, s, cMax, cMin, rD, gD, bD,
    cDiff, cDiffD2, cSum, cSumD2: integer;
begin
  r := getRValue(rgbc);
  g := getGValue(rgbc);
  b := getBValue(rgbc);
  cMax := max(max(r, g), b);
  cMin := min(min(r, g), b);

  l := (((cMax + cMin) * hlsMax) + rgbMax) div (rgbMaxM2);

  if cMax = cMin then
  begin
    s := 0;
    h := undefined
  end
  else
  begin
    cDiff := cMax - cMin;
    cDiffD2 := cDiff div 2;
    cSum := cMax + cMin;
    cSumD2 := cSum div 2;
    if l <= hlsMaxD2 then
      s := (cDiff * hlsMax + cSumD2) div cSum
    else
      s := (cDiff * hlsMax + (rgbMaxM2 - cDiff) div 2) div (rgbMaxM2 - cDiff);
    rD := ((cMax - r) * hlsMaxD6 + cDiffD2) div cDiff;
    gD := ((cMax - g) * hlsMaxD6 + cDiffD2) div cDiff;
    bD := ((cMax - b) * hlsMaxD6 + cDiffD2) div cDiff;
    if r = cMax then
      h := bD - gD
    else
      if g = cMax then
      h := hlsMaxD3 + rD - bD
    else
      h := hlsMaxM2D3 + gD - rD;
    checkRange(h);
  end;
  result := rgb(h, l, s);
end;

function HLStoRGB(hlsc: integer): integer;
var
  h, l, s, r, g, b, magic1, magic2: integer;

  function hueToRGB(n1, n2, hue: integer): integer;
  begin
    checkRange(hue);
    if hue < hlsMaxD6 then
      result := n1 + ((n2 - n1) * hue + hlsMaxD12) div hlsMaxD6
    else
      if hue < hlsMaxD2 then
      result := n2
    else
      if hue < hlsMaxM2D3 then
      result := n1 + ((n2 - n1) * (hlsMaxM2D3 - hue) + hlsMaxD12) div hlsMaxD6
    else
      result := n1
  end;

begin
  h := getRValue(hlsc);
  l := getGValue(hlsc);
  s := getBValue(hlsc);
  if s = 0 then
  begin
    r := l * rgbMax div hlsMax;
    g := r;
    b := r;
    if h <> undefined then
    begin {ERROR}
    end
  end
  else
  begin
    if l <= hlsMaxD2 then
      magic2 := (l * (hlsMax + s) + hlsMaxD2) div hlsMax
    else
      magic2 := l + s - (l * s + hlsMaxD2) div hlsMax;
    magic1 := 2 * l - magic2;
    r := Max(0, Min(255, (hueToRGB(magic1, magic2, h + hlsMaxD3) * rgbMax +
      hlsMaxD2) div hlsMax));
    g := Max(0, Min(255, (hueToRGB(magic1, magic2, h) * rgbMax + hlsMaxD2) div
      hlsMax));
    b := Max(0, Min(255, (hueToRGB(magic1, magic2, h - hlsMaxD3) * rgbMax +
      hlsMaxD2) div hlsMax));
  end;
  result := rgb(r, g, b)
end;

procedure DrawButtonFrameEx3(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean;
  ButtonColor: TColor; Thin: boolean; BorderSides: TElBorderSides);
var
  Color1,
    Color2,
    Color3,
    Color4: TColor;
  hls1, hls2, hls3, hls4: integer;
  lum: integer;

  procedure DrawBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4:
    TColor; Thin: boolean; BorderSides: TElBorderSides);
  var adj : integer;
  begin
    adj := 0;

    Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
      nColor1, nColor2, BorderSides);
    if not Thin then
    begin
      if ebsTop in BorderSides then
        inc(rc.Top);
      if ebsBottom in BorderSides then
        dec(rc.Bottom);
      if ebsLeft in BorderSides then
        inc(rc.Left);
      if ebsRight in BorderSides then
        dec(rc.Right);
      Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
        nColor3, nColor4, BorderSides);
    end;
  end;

begin
  if ButtonColor = clBtnFace then
  begin
    Color1 := ColorToRGB(clBtnHighlight);
    Color2 := ColorToRGB(cl3DDkShadow);
    Color3 := ColorToRGB(clBtnFace);
    Color4 := ColorToRGB(clBtnShadow);
    DrawButtonFrameEx2(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
    exit;
  end
  else
  begin
    ButtonColor := ColorToRGB(ButtonColor);

    hls1 := RGBtoHLS(ButtonColor);
    hls2 := hls1;
    hls3 := hls1;
    hls4 := hls1;

    lum := Hi(hls3 and $0000FFFF);
    if lum <> 0 then
    begin
      hls1 := (Min(239, (Hi(hls3 and $0000FFFF) + lum div 3)) shl 8) or (hls1
        and
        $FF00FF);
      hls2 := (Min(239, (Hi(hls3 and $0000FFFF) - lum div 2)) shl 8) or (hls2
        and
        $FF00FF);
      hls4 := (Min(239, (Hi(hls3 and $0000FFFF) - lum div 3)) shl 8) or (hls4
        and
        $FF00FF);

      Color1 := HLStoRGB(hls1);
      Color2 := HLStoRGB(hls2);
      Color3 := ButtonColor;
      Color4 := HLStoRGB(hls4);
      DrawButtonFrameEx2(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
      exit;
    end
    else
    begin
      Color1 := ColorToRGB(clBtnHighlight);
      Color2 := ColorToRGB(cl3DDkShadow);
      Color3 := ButtonColor;
      Color4 := ColorToRGB(clBtnShadow);
      DrawButtonFrameEx2(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
      exit;
    end;
  end;
  (*
  if not Pushed then
  begin
    if Focused then
{$IFNDEF CLX_USED}
      DrawBorder(DC, rc, Color1, Color2, Color3, Color4, Thin, BorderSides)
{$ELSE}
{$IFNDEF MSWINDOWS}
      DrawBorder(DC, rc, Color1, Color4, Color3, Color2, Thin, BorderSides)
{$ELSE}
      DrawBorder(DC, rc, Color1, Color2, Color3, Color4, Thin, BorderSides)
{$ENDIF}
{$ENDIF}
    else
      DrawBorder(DC, rc, Color1, Color4, Color3, Color3, Thin, BorderSides);
  end
  else
  begin
    if Focused then
      DrawBorder(DC, rc, Color2, Color1, Color4, Color3, Thin, BorderSides)
    else
      DrawBorder(DC, rc, Color4, Color1, Color3, Color3, Thin, BorderSides);
  end;
  *)
end;

procedure DrawButtonFrame(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean);
begin
  if not Pushed then
  begin
    if Focused then
      Draw3dBorder(DC, rc, COLOR_3DHIGHLIGHT, COLOR_3DDKSHADOW, COLOR_3DFACE,
        COLOR_3DSHADOW)
    else
      Draw3dBorder(DC, rc, COLOR_3DHIGHLIGHT, COLOR_3DSHADOW, COLOR_3DFACE,
        COLOR_3DFACE);
  end
  else
    Draw3dBorder(DC, rc, COLOR_3DDKSHADOW, COLOR_3DHIGHLIGHT, COLOR_3DSHADOW,
      COLOR_3DFACE);
end;

procedure DrawButtonFrameEx2(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean; ButtonColor: TColor; Thin: boolean; clrHighlight, clrDkShadow,
    clrFace,
  clrShadow: TColor; BorderSides : TElBorderSides);
var
  Color1,
    Color2,
    Color3,
    Color4: TColor;

  procedure DrawBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4:
    TColor; Thin: boolean; BorderSides: TElBorderSides);
  var adj : integer;
  begin
    adj := 0;

    Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
      nColor1, nColor2, BorderSides);
    if not Thin then
    begin
      if ebsTop in BorderSides then
        inc(rc.Top);
      if ebsBottom in BorderSides then
        dec(rc.Bottom);
      if ebsLeft in BorderSides then
        inc(rc.Left);
      if ebsRight in BorderSides then
        dec(rc.Right);
      Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
        nColor3, nColor4, BorderSides);
    end;
  end;

begin
  Color1 := clrHighlight;
  Color2 := clrDkShadow;
  Color3 := clrFace;
  Color4 := clrShadow;
  if not Pushed then
  begin
    if Focused then
      DrawBorder(DC, rc, Color1, Color2, Color3, Color4, Thin, BorderSides)
    else
      DrawBorder(DC, rc, Color1, Color4, Color3, Color3, Thin, BorderSides);
  end
  else
    DrawBorder(DC, rc, Color4, Color1, Color2, Color3, Thin, BorderSides);
end;

{$WARNINGS off}

procedure DrawFlatFrameEx2(DC: HDC; R: TRect; Color, BkColor: TColor;
  Focused, Enabled: boolean;
  BorderSides: TElBorderSides;
  BorderType: TElFlatBorderType;
  Color1, Color2, Color3, Color4, Color5  :TColor);
var
  BtnFaceBrush,
    WindowBrush,
    ShadowBrush: HBRUSH;

  CustomColors : boolean;


  R1: TRect;
  Edge: DWORD;

const
  EdgeTypes: array[TElFlatBorderType] of DWORD = (EDGE_RAISED, BDR_SUNKEN,
    BDR_SUNKENINNER, BDR_SUNKENOUTER, EDGE_RAISED, BDR_RAISEDINNER,
    BDR_RAISEDOUTER, EDGE_BUMP, EDGE_BUMP, EDGE_ETCHED, EDGE_BUMP, 0, 0, 0, 0);
  EdgeFlat: array[boolean] of DWORD = (BF_RECT or BF_ADJUST, BF_FLAT or
    BF_ADJUST);

begin


  if BorderType = fbtFlat then
  begin
    DrawFlatFrame2(DC, R, BkColor, false, BorderSides);
    exit;
  end;

  if (BorderType <> fbtColorLineBorder) then
  begin
    CustomColors := true;
    BtnFaceBrush := CreateSolidBrush(ColorToRGB(Color1));
    WindowBrush := CreateSolidBrush(ColorToRGB(Color5));
    ShadowBrush := CreateSolidBrush(ColorToRGB(Color4));
  end
  else
  begin
    CustomColors := false;
    BtnFaceBrush := GetSysColorBrush(COLOR_BTNFACE); //get the Windows brush
    WindowBrush := GetSysColorBrush(COLOR_WINDOW); //get the Windows brush
    ShadowBrush := GetSysColorBrush(COLOR_BTNSHADOW);
  end;

  if BorderType = fbtFlat then
    Edge := BF_FLAT or BF_ADJUST
  else
  begin
    Edge := BF_ADJUST;
    if ebsLeft in BorderSides then
      Edge := Edge or BF_LEFT;
    if ebsTop in BorderSides then
      Edge := Edge or BF_TOP;
    if ebsRight in BorderSides then
      Edge := Edge or BF_RIGHT;
    if ebsBottom in BorderSides then
      Edge := Edge or BF_BOTTOM;
  end;

  if BorderType < fbtLine then
  begin
    if CustomColors then
      DrawEdgeEx(DC, R, EdgeTypes[BorderType], Edge, Color1, Color2, Color4, Color3)
    else
      DrawEdge(DC, R, EdgeTypes[BorderType], Edge);
  end;

  case BorderType of
    fbtFramed:
      with R do
      begin
        if ebsLeft in BorderSides then
          FrameRect(DC, Rect(Left - 1, Top, Left, Bottom), BtnFaceBrush);
        if ebsTop in BorderSides then
          FrameRect(DC, Rect(Left - 2, Top - 1, Right + 1, Top), BtnFaceBrush);
        if ebsRight in BorderSides then
          FrameRect(DC, Rect(Right + 1, Top - 2, Right + 2, Bottom + 2),
            ShadowBrush);
        if ebsBottom in BorderSides then
          FrameRect(DC, Rect(Left - 2, Bottom + 1, Right + 2, Bottom + 2),
            ShadowBrush);
      end;
    fbtRaised:
      begin
        R1 := R;
        (*
        R1 := DrawBevel(DC, R1, BkColor, BkColor, [ebsLeft, ebsRight, ebsTop, ebsBottom]);
        R1 := DrawBevel(DC, R1, BkColor, BkColor, [ebsLeft, ebsRight, ebsTop, ebsBottom]);
        R1 := DrawBevel(DC, R, clBtnShadow, clBtnHighlight, [ebsLeft, ebsRight, ebsTop, ebsBottom]);
        *)
        R1 := DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
        R1 := DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
        R1 := DrawBevel(DC, R, Color4, Color3, BorderSides);
      end;
    fbtRaisedInner:
      with R do
      begin
        if ebsLeft in BorderSides then
          FrameRect(DC, Rect(Left, Top, Left + 1, Bottom), BtnFaceBrush);
        if ebsTop in BorderSides then
          FrameRect(DC, Rect(Left, Top, Right, Top + 1), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), BtnFaceBrush);
      end;
    fbtRaisedOuter:
      with R do
      begin
        if ebsLeft in BorderSides then
          FillRect(DC, Rect(Left, Top, Left + 1, Bottom), BtnFaceBrush);
        if ebsTop in BorderSides then
          FillRect(DC, Rect(Left, Top, Right, Top + 1), BtnFaceBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right, Top - 1, Right + 1, Bottom + 1),
            ShadowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 1, Bottom, Right + 1, Bottom + 1),
            ShadowBrush);
      end;
    {fbtSunken:
      begin
        if not Focused then
        begin
          FrameRect (DC, R, BtnFaceBrush);
          InflateRect (R, -1, -1);
          if (not Enabled)
             then FrameRect(DC, R, WindowBrush)
             else FrameRect(DC, R, BtnFaceBrush);
        end;
      end;
    } fbtSunkenInner:
      with R do
      begin
        if ebsLeft in BorderSides then
          FrameRect(DC, Rect(Left, Top, Left + 1, Bottom), BtnFaceBrush);
        if ebsTop in BorderSides then
          FrameRect(DC, Rect(Left, Top, Right, Top + 1), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right, Top - 1, Right + 1, Bottom + 1),
            BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 1, Bottom, Right + 1, Bottom + 1),
            BtnFaceBrush);
      end;
    fbtSunkenOuter:
      with R do
      begin
        if ebsLeft in BorderSides then
          FrameRect(DC, Rect(Left, Top, Left + 1, Bottom - 1), BtnFaceBrush);
        if ebsTop in BorderSides then
          FrameRect(DC, Rect(Left, Top, Right - 1, Top + 1), BtnFaceBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right, Top - 1, Right + 1, Bottom + 1),
            WindowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 1, Bottom, Right + 1, Bottom + 1),
            WindowBrush);
      end;
    fbtBump:
      with R do
      begin
        if ebsLeft in BorderSides then
          FillRect(DC, Rect(Left - 1, Top - 1, Left, Bottom), shadoWbrush);
        if ebsTop in BorderSides then
          FillRect(DC, Rect(Left, Top - 1, Right, Top), ShadowBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right + 2, Top - 2, Right + 1, Bottom + 2),
            ShadowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 2, Bottom + 1, Right + 2, Bottom + 2),
            ShadowBrush);
      end;
    fbtBigBump:
      with R do
      begin
        if ebsLeft in BorderSides then
          FillRect(DC, Rect(Left - 1, Top - 1, Left, Bottom), ShadowBrush);
        if ebsTop in BorderSides then
          FillRect(DC, Rect(Left, Top - 1, Right, Top), ShadowBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right + 2, Top - 2, Right + 1, Bottom + 2),
            ShadowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 2, Bottom + 1, Right + 2, Bottom + 2),
            ShadowBrush);

        if ebsLeft in BorderSides then
          FillRect(DC, Rect(Left - 2, Top - 2, Left - 1, Bottom + 1),
            WindowBrush);
        if ebsTop in BorderSides then
          FillRect(DC, Rect(Left - 2, Top - 2, Right + 1, Top - 1),
            WindowBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right + 1, Top - 2, Right, Bottom + 1),
            WindowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 2, Bottom, Right + 1, Bottom + 1),
            WindowBrush);
      end;
    fbtFlat,
    fbtEtched:
      with R do
      begin
        if (ebsLeft in BorderSides) and
          (ebsTop in BorderSides) then
          FillRect(DC, Rect(Left - 1, Top - 1, Right, Top), BtnFaceBrush)
        else
          if (ebsLeft in BorderSides) then
          FillRect(DC, Rect(Left - 1, Top, Right, Top), BtnFaceBrush)
        else
          if (ebsTop in BorderSides) then
          FillRect(DC, Rect(Left, Top - 1, Right, Top), BtnFaceBrush);
      end;
    fbtLine,
      fbtLineBorder,
      fbtNone: //mdm - Support for new styles
      begin
        R1 := DrawBevel(DC, R, BkColor, BkColor, BorderSides);
        DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
        case BorderType of
          fbtLine: DrawBevel(DC, R, clWindowFrame, clWindowFrame, [ebsBottom]);
          fbtLineBorder:
            DrawBevel(Dc, R, clwindOwframe, clWindowFrame,
              BorderSides);
        end;
      end;
    fbtColorLineBorder:
      begin
        R1 := DrawBevel(DC, R, Color, Color, BorderSides);
        DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
      end;
  end;
  if CustomColors then
  begin
    DeleteObject(WindowBrush);
    DeleteObject(ShadowBrush);
    DeleteObject(BtnFaceBrush);
  end;
end;
{$ifdef MSWINDOWS}
procedure DrawFlatFrameEx(DC: HDC; R: TRect; BkColor: TColor; Focused, Enabled:
  boolean);
begin
  if Focused then
  begin
    Draw3dBorder(DC, R, COLOR_3DSHADOW, COLOR_3DHIGHLIGHT, COLOR_3DDKSHADOW,
      COLOR_3DLIGHT);
  end
  else
  begin
    if not Enabled then
      Draw3dBorder(DC, R, COLOR_3DSHADOW, COLOR_3DHIGHLIGHT, COLOR_3DFACE,
        COLOR_3DFACE)
    else
      Draw3dBorder(DC, R, COLOR_3DSHADOW, COLOR_3DHIGHLIGHT, COLOR_3DLIGHT,
        COLOR_3DLIGHT);
  end;
end;
{$endif}
function DrawFlatFrame(DC: HDC; R: TRect; BkColor: TColor; Focused: boolean):
TRect;
var
  R1: TRect;
begin
  R1 := R;
  R1 := DrawBevel(DC, R1, BkColor, BkColor, [ebsLeft, ebsRight, ebsTop,
    ebsBottom]);
  R1 := DrawBevel(DC, R1, BkColor, BkColor, [ebsLeft, ebsRight, ebsTop,
    ebsBottom]);

  if Focused then
  begin
    R := DrawBevel(DC, R, clBtnShadow, clBtnHighlight, [ebsLeft, ebsRight,
      ebsTop, ebsBottom]);
    R := DrawBevel(DC, R, clBtnText, cl3DLight, [ebsLeft, ebsRight, ebsTop,
      ebsBottom]);
  end
  else
  begin
    DrawBevel(DC, R, clBtnShadow, clBtnHighlight, [ebsLeft, ebsRight, ebsTop,
      ebsBottom]);
  end;
end;

function DrawFlatFrame2(DC: HDC; R: TRect; BkColor: TColor; Focused: boolean;
  BorderSides: TElBorderSides): TRect;
var
  R1: TRect;
begin
  R1 := R;
  R1 := DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
  R1 := DrawBevel(DC, R1, BkColor, BkColor, BorderSides);

  if Focused then
  begin
    R := DrawBevel(DC, R, clBtnShadow, clBtnHighlight, BorderSides);
    R := DrawBevel(DC, R, clBtnText, cl3DLight, BorderSides);
  end
  else
  begin
    DrawBevel(DC, R, clBtnShadow, clBtnHighlight, BorderSides);
  end;
end;

procedure TiledPaint(Canvas: TCanvas; Bitmap: TBitmap; Rect: TRect);
var
  CurRect: TRect;
  CurLeft,
    CurTop: integer;
begin
  if not IsWinNT then
  begin
    CurTop := Rect.Top;
    while CurTop < Rect.Bottom do
    begin
      CurLeft := Rect.Left;
      while CurLeft < Rect.Right do
      begin
        CurRect := Classes.Rect(CurLeft, CurTop, Min(CurLeft + Bitmap.Width,
          Rect.Right), Min(CurTop + Bitmap.Height, Rect.Bottom));
        BitBlt(Canvas.Handle, CurLeft, CurTop, CurRect.Right - CurRect.Left,
          CurRect.Bottom - CurRect.Top, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(CurLeft, Bitmap.Width);
      end;
      Inc(CurTop, Bitmap.Height);
    end;
  end
  else
  begin
    Canvas.Brush.Bitmap := TBitmap.Create;
    Canvas.Brush.Bitmap.Assign(Bitmap);
    Canvas.FillRect(Rect);
    Canvas.Brush.Bitmap.Free;
    Canvas.Brush.Bitmap := nil;
  end;
end;


function HitTest(R: TRect; Pt: TPoint; CornerSize, BorderSize: integer):
integer;
begin
  if not PtInRect(R, Pt) then
  begin
    result := HTNOWHERE;
    exit;
  end;
  if InRange(R.Left, R.Left + BorderSize - 1, Pt.X) then
  begin
    if Pt.Y <= (R.Top + CornerSize) then
    begin
      result := HTTOPLEFT;
      exit;
    end;
    if Pt.Y >= (R.Bottom - CornerSize - 1) then
    begin
      result := HTBOTTOMLEFT;
      exit;
    end;
    result := HTLEFT;
    exit;
  end
  else
    if InRange(R.Top, R.Top + BorderSize - 1, Pt.Y) then
  begin
    if PT.X <= (R.Left + CornerSize) then
    begin
      result := HTTOPLEFT;
      exit;
    end;
    if PT.x >= (R.Right - CornerSize - 1) then
    begin
      result := HTTOPRIGHT;
      exit;
    end;
    result := HTTOP;
    exit;
  end
  else
    if InRange(R.Bottom - BorderSize - 1, R.Bottom - 1, Pt.Y) then
  begin
    if PT.X <= (R.Left + CornerSize) then
    begin
      result := HTBOTTOMLEFT;
      exit;
    end;
    if PT.x >= (R.Right - CornerSize - 1) then
    begin
      result := HTBOTTOMRIGHT;
      exit;
    end;
    result := HTBOTTOM;
    exit;
  end
  else
    if InRange(R.Right - BorderSize - 1, R.Right - 1, Pt.X) then
  begin
    if Pt.Y <= (R.Top + CornerSize) then
    begin
      result := HTTOPRIGHT;
      exit;
    end;
    if Pt.Y >= (R.Bottom - CornerSize - 1) then
    begin
      result := HTBOTTOMRIGHT;
      exit;
    end;
    result := HTRIGHT;
    exit;
  end;
  result := HTCLIENT;
end;

function GetTopWindowHandle(Child: HWND): HWND;
var
  h: HWND;
begin
  result := Child;
  while true do
  begin
    H := GetParent(result);
    if H <> 0 then
      result := H
    else
      break;
  end;
end;

function GetOwnerFrameForm(Component: TComponent): TWinControl;
begin
  while (not ((Component is TForm){$IFDEF VCL_5_USED} or (Component is
    TFrame){$ENDIF})) and (Component.Owner <> nil) do
    Component := Component.Owner;
  result := (Component as TWinControl);
end;


function GetTopOwnerControl(Component: TComponent): TControl;
begin
  while (not (Component is TControl)) and (Component.Owner <> nil) do
    Component := Component.Owner;
  result := Component as TControl;
end;

function GetRootComponent(Component: TComponent): TComponent;
begin
  while (Component.Owner <> nil) do
    Component := Component.Owner;
  result := Component;
end;

{$IFDEF VCL_6_USED}
var
{$ELSE}
const
{$ENDIF}
  WaitCount: Integer = 0;
  SaveCursor: TCursor = crDefault;

procedure StartWait;
begin
  if WaitCount = 0 then
  begin
    SaveCursor := Screen.Cursor;
    Screen.Cursor := WaitCursor;
  end;
  Inc(WaitCount);
end;

procedure StopWait;
begin
  if WaitCount > 0 then
  begin
    Dec(WaitCount);
    if WaitCount <= 0 then
      Screen.Cursor := SaveCursor;
  end;
end;

procedure DrawFlatScrollbarThumb(DC: HDC; rc: TRect; Focused: boolean);
begin
  if Focused then
    Draw3dBorder(DC, rc, COLOR_3DFACE, COLOR_3DDKSHADOW, COLOR_3DHIGHLIGHT,
      COLOR_3DSHADOW)
  else
    Draw3dBorder(DC, rc, COLOR_3DHIGHLIGHT, COLOR_3DSHADOW, COLOR_3DFACE,
      COLOR_3DFACE);
end;


function AlphaBlend(
  hdcDest: HDC; // handle to destination DC
  nXOriginDest: Integer; // x-coord of upper-left corner
  nYOriginDest: Integer; // y-coord of upper-left corner
  nWidthDest: Integer; // destination width
  nHeightDest: Integer; // destination height
  hdcSrc: HDC; // handle to source DC
  nXOriginSrc: Integer; // x-coord of upper-left corner
  nYOriginSrc: Integer; // y-coord of upper-left corner
  nWidthSrc: Integer; // source width
  nHeightSrc: Integer; // source height
  SourceConstantAlpha: Byte;
    // Specifies an alpha transparency value to be used on the entire source bitmap
  SrcAlpha: byte
  ): Boolean;
var
  hLib: HINST;
  Func: TAlphaBlend;
  blendFunction: TBlendFunction;
  iBlendFunction: Integer absolute blendFunction;
begin
{$OPTIMIZATION OFF}
  Result := False;
  if IsWin2000Up or IsWin98Up then
  begin
    hLib := LoadLibrary(PChar('msimg32.dll'));
    if hLib <> 0 then
    begin
      Func := TAlphaBlend(GetProcAddress(hLib, PChar('AlphaBlend')));
      if Assigned(Func) then
      begin
        with blendFunction do
        begin
          BlendOp := 0;
          BlendFlags := 0;
          AlphaFormat := SrcAlpha; //AC_SRC_ALPHA;
        end;
        blendFunction.SourceConstantAlpha := SourceConstantAlpha;
        Result := Func(hdcDest, nXOriginDest, nYOriginDest, nWidthdest,
          nHeightDest, hdcSrc, nXOriginSrc, nYOriginSrc, nWidthSrc, nHeightSrc,
          iBlendFunction);
      end;
      FreeLibrary(hLib);
    end;
  end;
{$OPTIMIZATION ON}
end;


procedure DrawFlatScrollBar(Wnd: HWND; DC: HDC; rect: TRect; nType: integer;
  bScrollbarCtrl: boolean; Dragging: boolean; Focused: boolean);
var
  nScrollSize: integer;
  nMinThumbSize: integer;
  RC1, RC2: TRect;
  si: TScrollInfo;
  nRange: integer;
  nThumbPos,
    nThumbSize: integer;
  nScrollArea: integer;

begin
  nScrollSize := GetSystemMetrics(SM_CXHSCROLL);

   // The minimal thumb size depends on the system version
   // For Windows 98 minimal thumb size is a half of scrollbar size
   // and for Windows NT is always 8 pixels regardless of system metrics.
   // I really don't know why.
  if IsWin98 then // Windows 98 code
    nMinThumbSize := nScrollSize div 2
  else
    nMinThumbSize := 8;

   // Calculate the arrow rectangles
  rc1 := rect;
  rc2 := rect;

  if (nType = SB_HORZ) then
  begin
    if ((rect.right - rect.left) < 2 * nScrollSize) then
      //nScrollSize := ( rect.right - rect.left ) div 2;
      nScrollSize := Round((rect.right - rect.left) / 2);
    rc1.right := rect.left + nScrollSize;
    rc2.left := rect.right - nScrollSize;
  end
  else // SB_VERT
  begin
    if ((rect.bottom - rect.top) < 2 * nScrollSize) then
      nScrollSize := (rect.bottom - rect.top) div 2;
    rc1.bottom := rect.top + nScrollSize;
    rc2.top := rect.bottom - nScrollSize;
  end;
  if not Dragging then
  begin
     // Draw the scrollbar arrows
    DrawFlatScrollbarThumb(DC, rc1, Focused);
    DrawFlatScrollbarThumb(DC, rc2, Focused);
  end;

   // Disabled scrollbar never have a thumb
  if (bScrollbarCtrl and not (IsWindowEnabled(Wnd))) then exit;

  si.cbSize := sizeof(TSCROLLINFO);
  si.fMask := SIF_ALL;
  if bScrollbarCtrl then
    GetScrollInfo(Wnd, SB_CTL, si)
  else
    GetScrollInfo(Wnd, nType, si);

  if si.nPage = 0 then exit;
   // Calculate the size and position of the thumb
  nRange := si.nMax - si.nMin + 1;

  if (nRange <> 0) then
  begin
    if nType = SB_VERT then
      nScrollArea := (rect.bottom - rect.top) - 2 * nScrollSize
    else
      nScrollArea := (rect.right - rect.left) - 2 * nScrollSize;
    if (si.nPage = 0) then // If nPage is not set then thumb has default size
      nThumbSize := GetSystemMetrics(SM_CXHTHUMB)
    else
      nThumbSize := max(MulDiv(si.nPage, nScrollArea, nRange), nMinThumbSize);

    if (nThumbSize >= nScrollArea) then
    begin
      nThumbSize := nScrollArea;
      if (bScrollbarCtrl = FALSE) then exit;
    end;

    if (DWORD(nRange) = si.nPage) then
    begin
      nThumbPos := 0;
      dec(nThumbSize);
    end
    else
    begin
      if Dragging then
        nThumbPos := MulDiv(si.nTrackPos - si.nMin, nScrollArea - nThumbSize,
          nRange - si.nPage)
      else
        nThumbPos := MulDiv(si.nPos - si.nMin, nScrollArea - nThumbSize, nRange
          - si.nPage);
    end;

    if (nType = SB_VERT) then
    begin
      rc1.top := rc1.top + nScrollSize + nThumbPos;
      rc1.bottom := rc1.top + nThumbSize;
    end
    else // SB_HORZ
    begin
      rc1.left := rc1.left + nScrollSize + nThumbPos;
      rc1.right := rc1.left + nThumbSize;
    end;

    if (nThumbSize <= nScrollArea) then
      // Don't draw the thumb when it's larger than the scroll area
      DrawFlatScrollbarThumb(DC, rc1, Focused);
  end;
end;
{$WARNINGS on}

function DrawFlatScrollbars(Wnd: HWND; DC: HDC; Rect: TRect; Focused: boolean;
  ScrollBars: TScrollStyle; DragHorz, DragVert: boolean; IsControl: boolean;
  Style, ExStyle: integer): TRect;
var
  nFrameSize,
    hScrollSize,
    vScrollSize: integer;
  RC, RC1: TRect;
  dwStyle: DWORD;
  st: integer;
  bRightVSB :Boolean;
begin
  dwStyle := Style;
  st := ExStyle;
  if ((dwStyle and WS_BORDER) = WS_BORDER) then
    nFrameSize := GetSystemMetrics(SM_CXBORDER)
  else
    if ((st and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
    nFrameSize := GetSystemMetrics(SM_CXEDGE)
  else
    nFrameSize := 0;
  hScrollSize := GetSystemMetrics(SM_CXHSCROLL);
  vScrollSize := GetSystemMetrics(SM_CYVSCROLL);
  bRightVSB := ((dwStyle and WS_VSCROLL) <> 0) and ( (ExStyle and WS_EX_LEFTSCROLLBAR)=0 );
  if (not bRightVSB) and (not NewStyleControls) then
    bRightVSB := True;
  GetClientRect(Wnd, Rc);
  GetWindowRect(Wnd, Rc1);
  OffsetRect(Rc1, -Rc1.Left, -Rc1.Top);

  // paint cross scrollbars area:
  if ((dwStyle and WS_HSCROLL) <> 0) and ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    if bRightVSB then
    begin
      rc.left := rect.right - nFrameSize - hScrollSize;
      rc.right := rect.right - nFrameSize;
    end
    else
    begin
      rc.left := rect.left + nFrameSize;
      rc.right := rect.left + rc.left + hScrollSize;
    end;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.bottom := rect.bottom - nFrameSize;
    FillRect(DC, rc, HBRUSH(COLOR_BTNFACE + 1));
  end;

  if ScrollBars = ssNone then exit;

  if ScrollBars <> ssBoth then
  begin
    if ScrollBars = ssVertical then dwStyle := dwStyle and not WS_HSCROLL;
    if ScrollBars = ssHorizontal then dwStyle := dwStyle and not WS_VSCROLL;
  end;
  if ((dwStyle and WS_HSCROLL) <> 0) and ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    // horz scrollbar:
    if bRightVSB then
    begin
      rc.left := rect.left + nFrameSize;
      rc.right := rect.right - nFrameSize - hScrollSize;
    end
    else
    begin
      rc.left := rect.left + nFrameSize + hScrollSize;
      rc.right := rect.right - nFrameSize;
    end;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBar(Wnd, DC, rc, SB_HORZ, IsControl, DragHorz, Focused);
    // vert scrollbar:
    if bRightVSB then
    begin
      rc.left := rect.right - nFrameSize - hScrollSize;
      rc.right := rect.right - nFrameSize;
    end
    else
    begin
      rc.left := rect.left + nFrameSize;
      rc.right := rc.left + hScrollSize;
    end;
    rc.top := rect.top + nFrameSize;
    rc.bottom := rect.bottom - nFrameSize - vScrollSize;
    DrawFlatScrollBar(Wnd, DC, rc, SB_VERT, IsControl, DragVert, Focused);
  end
  else
    if ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize) then
  begin
    if bRightVSB then
    begin
      rc.left := rect.right - nFrameSize - hScrollSize;
      rc.right := rect.right - nFrameSize;
    end
    else
    begin
      rc.left := rect.left + nFrameSize;
      rc.right := rc.left + hScrollSize;
    end;
    rc.top := rect.top + nFrameSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBar(Wnd, DC, rc, SB_VERT, IsControl, DragVert, Focused);
  end
  else
    if ((dwStyle and WS_HSCROLL) <> 0)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    rc.left := rect.left + nFrameSize;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.right := rect.right - nFrameSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBar(Wnd, DC, rc, SB_HORZ, IsControl, DragHorz, Focused);
  end;
end;

{$WARNINGS off}

procedure DrawFlatScrollBarEx(Wnd: HWND; DC: HDC; rect: TRect; nType:
  integer; bScrollbarCtrl: boolean; Dragging: boolean; Focused: boolean;
  BkColor, DitherColor, ButtonColor, ArrowColor, HotButtonColor: TColor;
  DrawFrames, DitherBack: boolean);
var
  nScrollSize: integer;
  nMinThumbSize: integer;
  RC1, RC2: TRect;
  si: TScrollInfo;
  nRange: integer;
  nThumbPos,
    nThumbSize: integer;
  nScrollArea: integer;

begin
  nScrollSize := GetSystemMetrics(SM_CXHSCROLL);

   // The minimal thumb size depends on the system version
   // For Windows 98 minimal thumb size is a half of scrollbar size
   // and for Windows NT is always 8 pixels regardless of system metrics.
   // I really don't know why.
  if IsWin98 then // Windows 98 code
    nMinThumbSize := nScrollSize div 2
  else
    nMinThumbSize := 8;

   // Calculate the arrow rectangles
  rc1 := rect;
  rc2 := rect;

  if (nType = SB_HORZ) then
  begin
    if ((rect.right - rect.left) < 2 * nScrollSize) then
      //nScrollSize := ( rect.right - rect.left ) div 2;
      nScrollSize := Round((rect.right - rect.left) / 2);
    rc1.right := rect.left + nScrollSize;
    rc2.left := rect.right - nScrollSize;
  end
  else // SB_VERT
  begin
    if ((rect.bottom - rect.top) < 2 * nScrollSize) then
      nScrollSize := (rect.bottom - rect.top) div 2;
    rc1.bottom := rect.top + nScrollSize;
    rc2.top := rect.bottom - nScrollSize;
  end;
  if not Dragging then
  begin
     // Draw the scrollbar arrows
    DrawFlatScrollbarThumb(DC, rc1, Focused);
    DrawFlatScrollbarThumb(DC, rc2, Focused);
  end;

   // Disabled scrollbar never have a thumb
  if (bScrollbarCtrl and not (IsWindowEnabled(Wnd))) then exit;

  si.cbSize := sizeof(TSCROLLINFO);
  si.fMask := SIF_ALL;
  if bScrollbarCtrl then
    GetScrollInfo(Wnd, SB_CTL, si)
  else
    GetScrollInfo(Wnd, nType, si);

   // Calculate the size and position of the thumb
  nRange := si.nMax - si.nMin + 1;

  if (nRange <> 0) then
  begin
    if nType = SB_VERT then
      nScrollArea := (rect.bottom - rect.top) - 2 * nScrollSize
    else
      nScrollArea := (rect.right - rect.left) - 2 * nScrollSize;
    if (si.nPage = 0) then // If nPage is not set then thumb has default size
      nThumbSize := GetSystemMetrics(SM_CXHTHUMB)
    else
      nThumbSize := max(MulDiv(si.nPage, nScrollArea, nRange), nMinThumbSize);

    if (nThumbSize >= nScrollArea) then
    begin
      nThumbSize := nScrollArea;
      if (bScrollbarCtrl = FALSE) then exit;
    end;

    if (DWORD(nRange) = si.nPage) then
    begin
      nThumbPos := 0;
      dec(nThumbSize);
    end
    else
    begin
      if Dragging then
        nThumbPos := MulDiv(si.nTrackPos - si.nMin, nScrollArea - nThumbSize,
          nRange - si.nPage)
      else
        nThumbPos := MulDiv(si.nPos - si.nMin, nScrollArea - nThumbSize, nRange
          - si.nPage);
    end;

    if (nType = SB_VERT) then
    begin
      rc1.top := rc1.top + nScrollSize + nThumbPos;
      rc1.bottom := rc1.top + nThumbSize;
    end
    else // SB_HORZ
    begin
      rc1.left := rc1.left + nScrollSize + nThumbPos;
      rc1.right := rc1.left + nThumbSize;
    end;

    if (nThumbSize <= nScrollArea) then
      // Don't draw the thumb when it's larger than the scroll area
      DrawFlatScrollbarThumb(DC, rc1, Focused);
  end;
end;

procedure DrawFlatScrollBarsEx(Wnd: HWND; DC: HDC; Rect: TRect; Focused:
  boolean; ScrollBars: TScrollStyle; DragHorz, DragVert: boolean; IsControl
  : boolean; BkColor, DitherColor, ButtonColor, ArrowColor, HotButtonColor:
  TColor; DrawFrames, DitherBack: boolean);
var
  nFrameSize,
    hScrollSize,
    vScrollSize: integer;
  RC, RC1: TRect;
  dwStyle: DWORD;
  st: integer;
begin
  if ScrollBars = ssNone then exit;
  dwStyle := GetWindowLong(Wnd, GWL_STYLE);
  st := GetWindowLong(Wnd, GWL_EXSTYLE);
  if ((dwStyle and WS_BORDER) = WS_BORDER) then
    nFrameSize := GetSystemMetrics(SM_CXBORDER)
  else
    if ((st and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
    nFrameSize := GetSystemMetrics(SM_CXEDGE)
  else
    nFrameSize := 0;
  hScrollSize := GetSystemMetrics(SM_CXHSCROLL);
  vScrollSize := GetSystemMetrics(SM_CYVSCROLL);
  GetClientRect(Wnd, Rc);
  GetWindowRect(Wnd, Rc1);
  OffsetRect(Rc1, -Rc1.Left, -Rc1.Top);

  if ScrollBars <> ssBoth then
  begin
    if ScrollBars = ssVertical then dwStyle := dwStyle and not WS_HSCROLL;
    if ScrollBars = ssHorizontal then dwStyle := dwStyle and not WS_VSCROLL;
  end;
  if ((dwStyle and WS_HSCROLL) <> 0) and ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    rc.left := rect.left + nFrameSize;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.right := rect.right - nFrameSize - hScrollSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBarEx(Wnd, DC, rc, SB_HORZ, IsControl, DragHorz, Focused,
      BkColor, DitherColor, ButtonColor, ArrowColor,
      HotButtonColor, DrawFrames, DitherBack);

    rc.left := rect.right - nFrameSize - hScrollSize;
    rc.top := rect.top + nFrameSize;
    rc.right := rect.right - nFrameSize;
    rc.bottom := rect.bottom - nFrameSize - vScrollSize;
    DrawFlatScrollBarEx(Wnd, DC, rc, SB_VERT, IsControl, DragVert, Focused,
      BkColor, DitherColor, ButtonColor, ArrowColor,
      HotButtonColor, DrawFrames, DitherBack);

    rc.left := rect.right - nFrameSize - hScrollSize;
    rc.right := rect.right - nFrameSize;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.bottom := rect.bottom - nFrameSize;
    FillRect(DC, rc, HBRUSH(COLOR_BTNFACE + 1));
  end
  else
    if ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    rc.left := rect.right - nFrameSize - hScrollSize;
    rc.top := rect.top + nFrameSize;
    rc.right := rect.right - nFrameSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBarEx(Wnd, DC, rc, SB_VERT, IsControl, DragVert, Focused,
      BkColor, DitherColor, ButtonColor, ArrowColor,
      HotButtonColor, DrawFrames, DitherBack);
  end
  else
    if ((dwStyle and WS_HSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize) then
  begin
    rc.left := rect.left + nFrameSize;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.right := rect.right - nFrameSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBarEx(Wnd, DC, rc, SB_HORZ, IsControl, DragHorz, Focused,
      BkColor, DitherColor, ButtonColor, ArrowColor,
      HotButtonColor, DrawFrames, DitherBack);
  end;
end;

{$WARNINGS on}



function DrawBevel(DC: HDC; R: TRect; Color1, Color2: TColor; Sides:
  TElBorderSides): TRect;
var
  APN,
    OPN: HPEN;
begin
  APN := CreatePen(PS_SOLID, 1, ColorToRGB(Color1));
  OPN := SelectObject(DC, APN);
  if ebsLeft in Sides then
  begin
    MoveToEx(DC, R.Left, R.Top, nil);
    LineTo(DC, R.Left, R.Bottom);
  end;
  if ebsTop in Sides then
  begin
    MoveToEx(DC, R.Left, R.Top, nil);
    LineTo(DC, R.Right, R.Top);
  end;

  SelectObject(DC, OPN);
  DeleteObject(APN);

  APN := CreatePen(PS_SOLID, 1, ColorToRGB(Color2));
  SelectObject(DC, APN);
  if ebsRight in Sides then
  begin
    MoveToEx(DC, R.Right - 1, R.Top, nil);
    LineTo(DC, R.Right - 1, R.Bottom);
  end;
  if ebsBottom in Sides then
  begin
    MoveToEx(DC, R.Left, R.Bottom - 1, nil);
    LineTo(DC, R.Right, R.Bottom - 1);
  end;
  SelectObject(DC, OPN);
  DeleteObject(APN);

  if ebsLeft in Sides then inc(R.Left);
  if ebsTop in Sides then inc(R.Top);
  if ebsRight in Sides then dec(R.Right);
  if ebsBottom in Sides then dec(R.Bottom);
  Result := R;
end;

{$IFNDEF D_2}

procedure AlphaCopyRect(DestDC: HDC; Dest: TRect; SourceDC: HDC; Source: TRect;
  AlphaLevel: byte; UseAlphaLevel: boolean);
var
  i, j, k: integer;
  Color,
    DstColor: TColor;
  DstBitmap,
    TmpBitmap: TBitmap;

    {h,} w: integer;
  Info: TBitmapInfo;
  pBits,
    dBits: pchar;
  p, dp: PInteger;
begin
  TmpBitmap := TBitmap.Create;
  TmpBitmap.Width := Dest.Right - Dest.Left;
  TmpBitmap.Height := Dest.Bottom - Dest.Top;
  TmpBitmap.PixelFormat := pf32Bit;

  DstBitmap := TBitmap.Create;
  DstBitmap.Width := Dest.Right - Dest.Left;
  DstBitmap.Height := Dest.Bottom - Dest.Top;
  DstBitmap.PixelFormat := pf32Bit;

  if (Dest.Right - Dest.Left = Source.Right - Source.Left) and
    (Dest.Bottom - Dest.Top = Source.Bottom - Source.Top) then
    bitblt(TmpBitmap.Canvas.Handle, 0, 0, Dest.Right - Dest.Left, Dest.Bottom -
      Dest.Top, SourceDC, Source.Left, Source.Top, srccopy)
  else
    StretchBlt(TmpBitmap.Canvas.Handle, 0, 0, TmpBitmap.Width, TmpBitmap.Height,
      SourceDC, Source.Left, Source.Top,
      Source.Right - Source.Left, Source.Bottom - Source.Top, SRCCOPY);

  bitblt(DstBitmap.Canvas.Handle, 0, 0, Dest.Right - Dest.Left, Dest.Bottom -
    Dest.Top, DestDC, Dest.Left, Dest.Top, srccopy);

  ZeroMemory(@Info.bmiHeader, sizeof(Info.bmiHeader));
  Info.bmiHeader.biSize := sizeof(Info.bmiHeader);
  Info.bmiHeader.biWidth := TmpBitmap.Width;
  Info.bmiHeader.biHeight := TmpBitmap.Height;
  Info.bmiHeader.biPlanes := 1;
  Info.bmiHeader.biBitCount := 32;
  Info.bmiHeader.Bicompression := BI_RGB;

  i := TmpBitmap.Width * TmpBitmap.Height * sizeof(Integer);
  GetMem(pBits, i);
  GetDIBits(DestDC, TmpBitmap.Handle, 0, TmpBitmap.Height, pBits, Info,
    DIB_RGB_COLORS);

  GetMem(dBits, i);
  GetDIBits(DestDC, DstBitmap.Handle, 0, TmpBitmap.Height, dBits, Info,
    DIB_RGB_COLORS);

  //h := TmpBitmap.Height;
  w := TmpBitmap.Width;

  for j := 0 to Dest.Bottom - Dest.Top - 1 do
  begin
    for i := 0 to Dest.Right - Dest.Left - 1 do
    begin
      k := ({H - 1 - } j) * w + i;
      p := PInteger(pBits);
      inc(p, k);
      dp := PInteger(dBits);
      inc(dp, k);

      Color := P^;
      DstColor := DP^;

      if not UseAlphaLevel then
        AlphaLevel := Color shr 24;

      P^ := ((((Color and $FF0000 shr 16) * AlphaLevel + (DstColor and $FF0000
        shr 16) * (256 - AlphaLevel)) shl 8) and $FF0000) or
        (((Color and $FF00 shr 8) * AlphaLevel + (DstColor and $FF00 shr 8) *
        (256 - AlphaLevel)) and $00FF00) or
        (((Color and $FF) * AlphaLevel + (DstColor and $FF) * (256 - AlphaLevel))
        shr 8 and $FF);
    end;
  end;
  SetDIBits(TmpBitmap.Canvas.Handle, TmpBitmap.Handle, 0, TmpBitmap.Height,
    pBits, Info, DIB_RGB_COLORS);
  bitblt(DestDC, Dest.Left, Dest.Top, Dest.Right - Dest.Left, Dest.Bottom -
    Dest.Top, TmpBitmap.Canvas.Handle, 0, 0, srccopy);
  TmpBitmap.Free;
  DstBitmap.Free;
  FreeMem(dBits);
  FreeMem(pBits);
end;

procedure AlphaCopyRect2(DestDC: HDC; Dest: TRect; SourceDC: HDC;
  Source: TRect; Mask: TBitmap; AlphaLevel: byte {; UseAlphaLevel : boolean});
type
  TstCol = record
    case Cardinal of
      0: (Blue, Green, Red, Alpha: byte);
      1: (RGBA: Cardinal);
  end;

var
  i, j, k: integer;
  Color,
  DstColor: TColor;
  DstBitmap,
  TmpBitmap,
  MskBitmap: TBitmap;

  w: integer;
  Info: TBitmapInfo;
  pBits,
  dBits,
  mBits: pchar;
  p, dp, mp: PInteger;
  Alpha: byte;
  fAlpha: double;
  src, dst: TstCol;
  SCA: word;
begin
  TmpBitmap := TBitmap.Create;
  TmpBitmap.Width := Dest.Right - Dest.Left;
  TmpBitmap.Height := Dest.Bottom - Dest.Top;
  TmpBitmap.PixelFormat := pf32Bit;

  DstBitmap := TBitmap.Create;
  DstBitmap.Width := Dest.Right - Dest.Left;
  DstBitmap.Height := Dest.Bottom - Dest.Top;
  DstBitmap.PixelFormat := pf32Bit;

  MskBitmap := TBitmap.Create;
  MskBitmap.Width := TmpBitmap.Width;
  MskBitmap.Height := TmpBitmap.Height;
  MskBitmap.PixelFormat := pf32bit;

  if (Dest.Right - Dest.Left = Source.Right - Source.Left) and
     (Dest.Bottom - Dest.Top = Source.Bottom - Source.Top) then
    bitblt(TmpBitmap.Canvas.Handle, 0, 0, Dest.Right - Dest.Left, Dest.Bottom -
           Dest.Top, SourceDC, Source.Left, Source.Top, srccopy)
  else
    StretchBlt(TmpBitmap.Canvas.Handle, 0, 0, TmpBitmap.Width, TmpBitmap.Height,
               SourceDC, Source.Left, Source.Top,
               Source.Right - Source.Left, Source.Bottom - Source.Top, SRCCOPY);

  if (MskBitmap.Width = Source.Right - Source.Left) and
     (MskBitmap.Height = Source.Bottom - Source.Top) then
    bitblt(MskBitmap.Canvas.Handle, 0, 0, MskBitmap.Width, MskBitmap.Height,
           Mask.Canvas.Handle, Source.Left, Source.Top, srccopy)
  else
    StretchBlt(MskBitmap.Canvas.Handle, 0, 0, MskBitmap.Width, MskBitmap.Height,
               Mask.Canvas.Handle, Source.Left, Source.Top,
               Source.Right - Source.Left, Source.Bottom - Source.Top, SRCCOPY);

  bitblt(DstBitmap.Canvas.Handle, 0, 0, Dest.Right - Dest.Left, Dest.Bottom -
         Dest.Top, DestDC, Dest.Left, Dest.Top, srccopy);
  ZeroMemory(@Info.bmiHeader, sizeof(Info.bmiHeader));
  Info.bmiHeader.biSize := sizeof(Info.bmiHeader);
  Info.bmiHeader.biWidth := TmpBitmap.Width;
  Info.bmiHeader.biHeight := TmpBitmap.Height;
  Info.bmiHeader.biPlanes := 1;
  Info.bmiHeader.biBitCount := 32;
  Info.bmiHeader.biCompression := BI_RGB;

  i := TmpBitmap.Width * TmpBitmap.Height * sizeof(Integer);
  GetMem(pBits, i);
  GetDIBits(DestDC, TmpBitmap.Handle, 0, TmpBitmap.Height, pBits, Info, DIB_RGB_COLORS);

  GetMem(dBits, i);
  GetDIBits(DestDC, DstBitmap.Handle, 0, TmpBitmap.Height, dBits, Info, DIB_RGB_COLORS);

  GetMem(mBits, i);
  GetDIBits(DestDC, MskBitmap.Handle, 0, MskBitmap.Height, mBits, Info, DIB_RGB_COLORS);

  w := TmpBitmap.Width;

  SCA := AlphaLevel + 1;

  for j := 0 to Dest.Bottom - Dest.Top - 1 do
  begin
    for i := 0 to Dest.Right - Dest.Left - 1 do
    begin
      k := ({H - 1 - } j) * w + i;
      p := PInteger(pBits);
      inc(p, k);
      dp := PInteger(dBits);
      inc(dp, k);

      Color := P^;
      DstColor := DP^;

      mp := PInteger(mBits);
      inc(mp, k);
      Alpha := mp^ and $FF;

      dst.rgba := DstColor;
      src.rgba := Color;

      src.Alpha := (Alpha * SCA) shr 8;
      src.Red := (src.Red * SCA) shr 8;
      src.Green := (src.Green * SCA) shr 8;
      src.Blue := (src.Blue * SCA) shr 8;

      fAlpha := Src.Alpha / 255;

      dst.Alpha := trunc(Src.Alpha + (1 - fAlpha) * Dst.Alpha);
      dst.Red := trunc(fAlpha * Src.Red + (1 - fAlpha) * Dst.Red);
      dst.Green := trunc(fAlpha * Src.Green + (1 - fAlpha) * Dst.Green);
      dst.Blue := trunc(fAlpha * Src.Blue + (1 - fAlpha) * Dst.Blue);

      P^ := dst.rgba;
    end;
  end;
  SetDIBits(TmpBitmap.Canvas.Handle, TmpBitmap.Handle, 0, TmpBitmap.Height,
    pBits, Info, DIB_RGB_COLORS);
  bitblt(DestDC, Dest.Left, Dest.Top, Dest.Right - Dest.Left, Dest.Bottom -
    Dest.Top, TmpBitmap.Canvas.Handle, 0, 0, srccopy);
  TmpBitmap.Free;
  DstBitmap.Free;
  MskBitmap.Free;
  FreeMem(dBits);
  FreeMem(pBits);
  FreeMem(mBits);
end;

function IsAlphaEmpty(bmp: TBitmap): boolean;
var
  i: integer;
  dib: pchar;
  Info: TBitmapInfo;
begin
  Result := true;
  if bmp.PixelFormat <> pf32bit then exit;

  ZeroMemory(@Info.bmiHeader, sizeof(Info.bmiHeader));
  Info.bmiHeader.biSize := sizeof(Info.bmiHeader);
  Info.bmiHeader.biWidth := bmp.Width;
  Info.bmiHeader.biHeight := bmp.Height;
  Info.bmiHeader.biPlanes := 1;
  Info.bmiHeader.biBitCount := 32;
  Info.bmiHeader.biCompression := BI_RGB;
  i := bmp.Width * bmp.Height;
  GetMem(dib, i * sizeof(Integer));
  GetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, bmp.Height, dib, Info, DIB_RGB_COLORS);

  asm
    mov edx, PInteger(dib)
    dec edx
    dec edx
    dec edx
    dec edx

    mov ecx, i
  @:
    inc edx
    inc edx
    inc edx
    inc edx
    test dword ptr [edx], $ff000000
    loopz @
    mov i, ecx
  end;

  FreeMem(dib);

  Result := i=0;
end;

procedure ClearAlpha(var bmp: TBitmap);
var
  i: integer;
  dib: pchar;
  Info: TBitmapInfo;
begin
  if bmp.PixelFormat <> pf32bit then exit;

  ZeroMemory(@Info.bmiHeader, sizeof(Info.bmiHeader));
  Info.bmiHeader.biSize := sizeof(Info.bmiHeader);
  Info.bmiHeader.biWidth := bmp.Width;
  Info.bmiHeader.biHeight := bmp.Height;
  Info.bmiHeader.biPlanes := 1;
  Info.bmiHeader.biBitCount := 32;
  Info.bmiHeader.biCompression := BI_RGB;
  i := bmp.Width * bmp.Height;
  GetMem(dib, i * sizeof(Integer));
  GetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, bmp.Height, dib, Info, DIB_RGB_COLORS);
  asm
    mov edx, PInteger(dib)
    dec edx
    dec edx
    dec edx
    dec edx

    mov ecx, i
  @:
    inc edx
    inc edx
    inc edx
    inc edx
    or dword ptr [edx], $ff000000
    xor dword ptr [edx], $ff000000
    loop @
  end;

  SetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, bmp.Height, dib, Info, DIB_RGB_COLORS);
  FreeMem(dib);
end;

procedure AlphaFillRect(Canvas: TCanvas; Rect: TRect; Color: TColor; AlphaLevel:
  byte);
var
  i, j: integer;
  DstColor: TColor;
  SrcRValue,
    SrcGValue,
    SrcBValue: integer;
  DstRValue,
    DstGValue,
    DstBValue: byte;
begin
  SrcRValue := GetRValue(Color);
  SrcGValue := GetGValue(Color);
  SrcBValue := GetBValue(Color);
  for i := Rect.Left to Rect.Right - 1 do
  begin
    for j := Rect.Top to Rect.Bottom - 1 do
    begin
      DstColor := Canvas.Pixels[i, j];
      DstRValue := (SrcRValue * AlphaLevel + GetRValue(DstColor) * (256 -
        AlphaLevel)) shr 8;
      DstGValue := (SrcGValue * AlphaLevel + GetGValue(DstColor) * (256 -
        AlphaLevel)) shr 8;
      DstBValue := (SrcBValue * AlphaLevel + GetBValue(DstColor) * (256 -
        AlphaLevel)) shr 8;
      DstColor := RGB(DstRValue, DstGValue, DstBValue);
      Canvas.Pixels[i, j] := DstColor;
    end;
  end;
end;
{$ENDIF}

{$IFNDEF BROKEN_UNICODE}

function NextLineW(hdc: HDC; const str: PWideChar; count: PInteger;
  dest: PWideChar; len: PInteger; width: integer; format: Word;
  var tabwidth, spaCewidth, prefix_offset, overhang: integer): PWideChar;
var
  i, j, k: integer;
  plen: integer;
  numspaces: integer;
  Size: TSize;
  lasttab: integer;
  wb_i,
    wb_j,
    wb_count: integer;
  maxl: integer;
  bb: boolean;

begin
  i := 0;
  j := 0;
  plen := 0;
  lasttab := 0;
  wb_i := 0;
  wb_j := 0;
  wb_count := 0;
  maxl := len^;

  while (count^ <> 0) and (j < maxl) do
  begin
    case (str[i]) of
      WideChar(#13),
        WideChar(#10):
        begin
          if (format and DT_SINGLELINE) <> DT_SINGLELINE then
          begin
            if ((count^ > 1) and (str[i] = WideChar(#13)) and (str[i + 1] =
              WideChar(#10))) then
            begin
              dec(count^);
              inc(i);
            end;
            inc(i);
            len^ := j;
            dec(count^);
            result := (@str[i]);
            exit;
          end;

          dest[j] := str[i];
          inc(j);
          inc(i);

          if {((Format and DT_NOCLIP)    <> DT_NOCLIP) or}
            ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
            ((Format and DT_WORDBREAK) = DT_WORDBREAK) then
          begin
            if (not GetTextExtentPoint32W(hdc, @dest[j - 1], 1, size)) then
            begin
              result := nil;
              exit;
            end;
            inc(plen, size.cx - overhang);
          end;
        end;
      WideChar('&'):
        begin
          bb := true;
          if ((format and DT_NOPREFIX) <> DT_NOPREFIX) and (count^ > 1) then
          begin
            inc(i);
            if (str[i] = WideChar('&')) then
              dec(count^)
            else
            begin
              prefix_offset := j;
              bb := false;
            end;
          end;
          if bb then
          begin
            dest[j] := str[i];
            inc(j);
            inc(i);
            if {((Format and DT_NOCLIP)    <> DT_NOCLIP) or}
              ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
              ((Format and DT_WORDBREAK) = DT_WORDBREAK) then
            begin
              if (not GetTextExtentPoint32W(hdc, @dest[j - 1], 1, size)) then
              begin
                result := nil;
                exit;
              end;
              inc(plen, size.cx - overhang);
            end;
          end;
        end;
      WideChar(#9):
        if (format and DT_EXPANDTABS) = DT_EXPANDTABS then
        begin
          inc(i);
          wb_i := i;
          wb_j := j;
          wb_count := count^;

          if (not GetTextExtentPoint32W(hdc, @dest[lasttab], j - lasttab, size))
            then
          begin
            result := nil;
            exit;
          end;

          numspaces := (tabwidth - (size.cx - overhang)) div spacewidth;
          for k := 0 to numspaces - 1 do
          begin
            dest[j] := WideChar(#32);
            inc(j);
          end;
          inc(plen, tabwidth - size.cx);
          lasttab := wb_j + numspaces;
        end
        else
        begin
          dest[j] := str[i];
          inc(j);
          inc(i);

          if {((Format and DT_NOCLIP)    <> DT_NOCLIP) or}
            ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
            ((Format and DT_WORDBREAK) = DT_WORDBREAK) then
          begin
            if (not GetTextExtentPoint32W(hdc, @dest[j - 1], 1, size)) then
            begin
              result := nil;
              exit;
            end;
            inc(plen, size.cx - overhang);
          end;
        end;
      WideChar(#32):
        begin
          dest[j] := str[i];
          inc(j);
          inc(i);

          if {((Format and DT_NOCLIP)    <> DT_NOCLIP) or}
            ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
            ((Format and DT_WORDBREAK) = DT_WORDBREAK) then
          begin
            wb_i := i;
            wb_j := j - 1;
            wb_count := count^;
            if (not GetTextExtentPoint32W(hdc, @dest[j - 1], 1, size)) then
            begin
              result := nil;
              exit;
            end;
            inc(plen, size.cx - overhang);
          end;
        end;
    else
      begin
        dest[j] := str[i];
        inc(j);
        inc(i);

        if {((Format and DT_NOCLIP) <> DT_NOCLIP) or}
          ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
          ((Format and DT_WORDBREAK) = DT_WORDBREAK) then
        begin
          if (not GetTextExtentPoint32W(hdc, @dest[j - 1], 1, size)) then
          begin
            result := nil;
            exit;
          end;
          inc(plen, size.cx - overhang);
        end;
      end;
    end;

    dec(count^);
    if {((format and DT_NOCLIP) <> DT_NOCLIP) or}
      ((format and DT_WORDBREAK) = DT_WORDBREAK) then
    begin
      if (plen > width)
        {and (((format and DT_CALCRECT) <> DT_CALCRECT) or (width <> 0))}then
      begin
        if (format and DT_WORDBREAK) = DT_WORDBREAK then
        begin
          if (wb_j <> 0) then
          begin
            len^ := wb_j;
            count^ := wb_count - 1;
            result := (@str[wb_i]);
            exit;
          end
          else
          begin
            len^ := j;
            result := (@str[i]);
            exit;
          end;
        end
        else
        begin
          len^ := j;
          result := nil;
          exit;
        end;
      end;
    end;
  end;

  len^ := j;
  result := nil;
end;

function DrawTextExW(hDC: HDC; lpString: PWideChar; nCount: Integer; var lpRect:
  TRect; uFormat: UINT; dtp: PDRAWTEXTPARAMS): Integer;

const
  MAX_STATIC_BUFFER = 8192;
const
  STATIC_BUFFER_LEN: integer = 8192;
const
  DT_PREFIXONLY = $00200000;

var
  size: TSize;
  strPtr: PWideChar;
  line: PWideChar;
  swapStr: PWideChar;
  linestat: array[0..MAX_STATIC_BUFFER - 1] of WideChar;
  swapstat: array[0..MAX_STATIC_BUFFER - 1] of WideChar;
  len,
    lh,
    count,
    count1: integer;
  uFormat1: integer;
  prefix_x: integer;
  prefix_end: integer;
  tm: TTextMetricA;
  lmargin: integer;
  rmargin: integer;
  x, y,
    width,
    max_width: integer;
  tabstop: integer;
  tabwidth,
    spacewidth,
    prefix_offset: integer;
  fnameDelim: PWideChar;
  totalLen: integer;
  fnameLen: integer;
  lastBkSlash: PWideChar;
  lastFwdSlash: PWideChar;
  apen,
    oldPen: HPEN;
  etoFlags: integer;
  statBufUsed: boolean;
  strCopyUsed: boolean;
begin
  len := nCount;
  if len = -1 then
    len := WideStrLen(lpString);
  if len < MAX_STATIC_BUFFER - 4 then
  begin
    strCopyUsed := false;
    statBufUsed := true;
    line := @LineStat;
    swapStr := @swapStat;
    STATIC_BUFFER_LEN := MAX_STATIC_BUFFER;
  end
  else
  begin
    strCopyUsed := false;
    if not IsWinNTUp then
    begin
      strCopyUsed := true;
      GetMem(Line, (len + 1) * sizeof(WideChar));
      WideStrLCopy(Line, lpString, len);
      lpString := Line;
    end;
    statBufUsed := false;
    STATIC_BUFFER_LEN := len;
    GetMem(Line, (len + 4) * sizeof(WideChar));
    GetMem(swapStr, (len + 4) * sizeof(WideChar));
  end;
  try
    tabStop := 8;
    count := nCount;
    prefix_x := 0;
    prefix_end := 0;
    lmargin := 0;
    rmargin := 0;
    x := lpRect.left;
    y := lpRect.top;
    max_width := 0;

    if (lpString = nil) then
    begin
      result := 0;
      exit;
    end;

    if (count = -1) then
      count := WideStrLen(lpString);
    if (count = 0) then
    begin
      lpRect.Right := lpRect.Left;
      lpRect.Bottom := lpRect.Top;
      result := 0;
      exit;
    end;

    if (uFormat and DT_CALCRECT) = DT_CALCRECT then
    begin
      if (lpRect.Right = 0) then
        lpRect.Right := 32767;
      if (lpRect.Bottom = 0) then
        lpRect.Bottom := 32767;
    end;

    width := lpRect.right - lpRect.left;

    strPtr := lpString;

    GetTextMetrics(hdc, tm);
    if (uFormat and DT_EXTERNALLEADING) = DT_EXTERNALLEADING then
      lh := tm.tmHeight + tm.tmExternalLeading
    else
      lh := tm.tmHeight;

    if dtp <> nil then
    begin
      lmargin := dtp.iLeftMargin * tm.tmAveCharWidth;
      rmargin := dtp.iRightMargin * tm.tmAveCharWidth;
      if (uFormat and (DT_CENTER or DT_RIGHT)) = 0 then
        inc(x, lmargin);
      dtp.uiLengthDrawn := 0;
    end;

    if (uFormat and DT_TABSTOP) = DT_TABSTOP then
      if dtp <> nil then
        tabStop := dtp.iTabLength
      else
        tabStop := uFormat shr 8;

    if (uFormat and DT_EXPANDTABS) = DT_EXPANDTABS then
    begin
      GetTextExtentPoint32W(hdc, WideChar(' '), 1, size);
      spacewidth := size.cx - tm.tmOverhang;
      GetTextExtentPoint32W(hdc, WideChar('o'), 1, size);
      tabwidth := (size.cx - tm.tmOverhang) * tabstop;
    end;

    if (uFormat and DT_CALCRECT) = DT_CALCRECT then
      uFormat := uFormat or DT_NOCLIP;

    repeat
      prefix_offset := -1;
      len := STATIC_BUFFER_LEN;
      strPtr := NextLineW(hdc, strPtr, @count, line, @len, width, uFormat,
        tabwidth, spacewidth, prefix_offset, tm.tmOverhang);

      if (prefix_offset <> -1) then
      begin
        GetTextExtentPoint32W(hdc, line, prefix_offset, size);
        prefix_x := size.cx;
        GetTextExtentPoint32W(hdc, line, prefix_offset + 1, size);
        prefix_end := size.cx - 1;
      end;

      if (not GetTextExtentPoint32W(hdc, line, len, size)) then
      begin
        result := 0;
        exit;
      end
      else
        inc(size.cx, tm.tmOverhang);

      if ((uFormat and DT_CALCRECT) <> DT_CALCRECT) and (lpRect.left + lpRect.right > size.cx) then
      begin
        if (uFormat and DT_CENTER) = DT_CENTER then
        begin
          if lpRect.left + lpRect.right >= size.cx then
            x := max(lpRect.Left, (lpRect.left + lpRect.right - size.cx) shr 1)
          else
            x := max(lpRect.Left, (lpRect.left + lpRect.right - size.cx) div 2);
        end
        else
          if (uFormat and DT_RIGHT) = DT_RIGHT then
          x := max(lpRect.Left, lpRect.right - size.cx);
      end;

      if ((uFormat and DT_SINGLELINE) = DT_SINGLELINE) then
      begin

        if (uFormat and DT_CALCRECT) <> DT_CALCRECT then
        begin
          if (uFormat and DT_VCENTER) = DT_VCENTER then
            y := lpRect.top + (lpRect.bottom - lpRect.top) shr 1 - size.cy shr 1
          else
            if (uFormat and DT_BOTTOM) = DT_BOTTOM then
            y := lpRect.bottom - size.cy;
        end;

        if ((uFormat and (DT_PATH_ELLIPSIS or DT_END_ELLIPSIS or
          DT_WORD_ELLIPSIS)) <> 0) then
        begin
          // fnameDelim := nil;
          if nCount >= 0 then
            totalLen := nCount
          else
            totalLen := WideStrLen(lpString);

          if (size.cx > width) then
          begin
            fnameLen := totalLen;

            count := min(totalLen + 3, STATIC_BUFFER_LEN - 3);

            if (uFormat and DT_WORD_ELLIPSIS) = DT_WORD_ELLIPSIS then
              uFormat := uFormat or DT_WORDBREAK;

            if (uFormat and DT_PATH_ELLIPSIS) = DT_PATH_ELLIPSIS then
            begin
              lastBkSlash := nil;
              lastFwdSlash := nil;

              WideStrLCopy(line, lpString, totalLen);
              line[totalLen] := WideChar('0');

              lastBkSlash := widEstrrscan(line, WideChar('\'));
              lastFwdSlash := WideStrRScan(line, WideChar('/'));
              if Integer(lastBkSlash) > integer(lastFwdSlash) then
                fnameDelim := lastBkSlash
              else
                fnameDelim := lastFwdSlash;

              if (fnameDelim <> nil) then
                fnameLen := @line[totalLen] - fnameDelim
              else
                fnameDelim := lpString;

              WideStrCopy(swapStr, '...'#0);
              WideStrLCopy(swapStr + WideStrLen(swapStr), fnameDelim, fnameLen);
              swapStr[fnameLen + 3] := WideChar(#0);
              WideStrLCopy(swapStr + WideStrLen(swapStr), lpString, totalLen -
                fnameLen);
              swapStr[totalLen + 3] := WideChar(#0);
            end
            else (* DT_END_ELLIPSIS | DT_WORD_ELLIPSIS *)
            begin
              WideStrCopy(swapStr, '...'#0);
              WideStrLCopy(swapStr + WideStrLen(swapStr), lpString, totalLen);
            end;

            len := STATIC_BUFFER_LEN;
            NextLineW(hdc, swapStr, @count, line, @len, width, uFormat,
              tabWidth, spacewidth, prefix_offset, tm.tmOverhang);

            (* if only the ELLIPSIS will fit, just let it be clipped *)
            len := max(4, len);
            GetTextExtentPoint32W(hdc, line, len, size);
            inc(size.cx, tm.tmOverhang);
            (* FIXME:
             * NextLine uses GetTextExtentPoint for each character,
             * rather than GetCharABCWidth...  So the whitespace between
             * characters is ignored in the width measurement, and the
             * reported len is too great.  To compensate, we must get
             * the width of the entire line and adjust len accordingly.
            *)
            while ((size.cx > width) and (len > 3)) do
            begin
              dec(len);
              line[len] := WideChar(#0);
              GetTextExtentPoint32W(hdc, line, len, size);
              inc(size.cx, tm.tmOverhang);
            end;

            if (fnameLen < len - 3) then
            begin
              (* put the ELLIPSIS between the path and filename *)
              WideStrLCopy(swapStr, @line[fnameLen + 3], len - 3 - fnameLen);
              swapStr[len - 3 - fnameLen] := WideChar(#0);
              WideStrCat(swapStr, '...'#0);
              WideStrLCopy(swapStr + WideStrLen(swapStr), @line[3], fnameLen);
            end
            else
            begin
              (* move the ELLIPSIS to the end *)
              WideStrLCopy(swapStr, @line[3], len - 3);
              swapStr[len - 3] := WideChar(#0);
              WideStrCopy(swapStr + WideStrLen(swapStr), '...'#0);
            end;

            WideStrLCopy(line, swapStr, len);
            line[len] := WideChar(#0);
            strPtr := nil;
          end;
        end;
        if (uFormat and DT_MODIFYSTRING) = DT_MODIFYSTRING then
          WideStrCopy(lpString, swapStr);
      end
      else
      begin
        if ((uFormat and DT_CALCRECT) <> DT_CALCRECT) and (((uFormat and
          DT_WORD_ELLIPSIS) <> 0) or (((uFormat and DT_END_ELLIPSIS) <> 0) and
          (strPtr = nil))) then
        begin
          // fnameDelim := nil;
          totalLen := len;

          if (size.cx > width) then
          begin
            fnameLen := totalLen;

            count1 := min(totalLen + 3, STATIC_BUFFER_LEN - 3);

            uformat1 := uFormat;
            if (uFormat1 and DT_WORD_ELLIPSIS) = DT_WORD_ELLIPSIS then
              uFormat1 := uFormat1 or DT_WORDBREAK;

            begin
              WideStrCopy(swapStr, '...'#0);
              WideStrLCopy(swapStr + WideStrLen(swapStr), line, len);
            end;

            len := STATIC_BUFFER_LEN;
            NextLineW(hdc, swapStr, @count1, line, @len, width, uFormat1,
              tabWidth, spacewidth, prefix_offset, tm.tmOverhang);

            (* if only the ELLIPSIS will fit, just let it be clipped *)
            len := max(4, len);
            GetTextExtentPoint32W(hdc, line, len, size);
            inc(size.cx, tm.tmOverhang);
            (* FIXME:
             * NextLine uses GetTextExtentPoint for each character,
             * rather than GetCharABCWidth...  So the whitespace between
             * characters is ignored in the width measurement, and the
             * reported len is too great.  To compensate, we must get
             * the width of the entire line and adjust len accordingly.
            *)
            while ((size.cx > width) and (len > 3)) do
            begin
              dec(len);
              line[len] := WideChar(#0);
              GetTextExtentPoint32W(hdc, line, len, size);
              inc(size.cx, tm.tmOverhang);
            end;

            if (fnameLen < len - 3) then
            begin
              (* put the ELLIPSIS between the path and filename *)
              WideStrLCopy(swapStr, @line[fnameLen + 3], len - 3 - fnameLen);
              swapStr[len - 3 - fnameLen] := WideChar(#0);
              WideStrCat(swapStr, '...'#0);
              WideStrLCopy(swapStr + WideStrLen(swapStr), @line[3], fnameLen);
            end
            else
            begin
              (* move the ELLIPSIS to the end *)
              WideStrLCopy(swapStr, @line[3], len - 3);
              swapStr[len - 3] := WideChar(#0);
              WideStrCopy(swapStr + WideStrLen(swapStr), '...'#0);
            end;

            WideStrLCopy(line, swapStr, len);
            line[len] := WideChar(#0);
            // strPtr := nil;
          end;
          if (uFormat and DT_MODIFYSTRING) = DT_MODIFYSTRING then
            WideStrCopy(lpString, swapStr);
        end;
      end;
      if (uFormat and DT_CALCRECT) <> DT_CALCRECT then
      begin
        if (uFormat and DT_PREFIXONLY) <> DT_PREFIXONLY then
        begin
          etoFlags := 0;
          if uFormat and DT_NOCLIP <> DT_NOCLIP then
            etoFlags := etoFlags or ETO_CLIPPED;
          if uFormat and DT_RTLREADING = DT_RTLREADING then
            etoFlags := etoFlags or DT_RTLREADING;

          if (etoFlags and ETO_CLIPPED) = ETO_CLIPPED then
            InflateRect(lpRect, 1, 1);
          if (not ExtTextOutW(hdc, x, y, etoFlags, @lpRect, line, len, nil))
            then
          begin
            result := 0;
            exit;
          end;
          if (etoFlags and ETO_CLIPPED) = ETO_CLIPPED then
            InflateRect(lpRect, -1, -1);
        end;
        if (prefix_offset <> -1) and ((uFormat and DT_HIDEPREFIX) = 0) then
        begin
          apen := CreatePen(PS_SOLID, 1, gettExtcolor(hdc));
          oldPen := SelectObject(hdc, apen);
          MoveToEx(hdc, x + prefix_x, y + tm.tmAscent + 1, nil);
          LineTo(hdc, x + prefix_end + 1, y + tm.tmAscent + 1);
          SelectObject(hdc, oldPen);
          DeleteObject(apen);
        end
      end
      else
        if (size.cx > max_width) then
        max_width := size.cx;

      inc(y, lh);
      if (strPtr <> nil) then
      begin
        if (uFormat and DT_CALCRECT) <> DT_CALCRECT then
        begin
          if (uFormat and DT_NOCLIP <> DT_NOCLIP) then
          begin
            if (y > lpRect.bottom - lh) then
              break;
          end;
        end;
      end;
      if dtp <> nil then
        inc(dtp.uiLengthDrawn, len);
    until (StrPtr = nil);

    if (uFormat and DT_CALCRECT) = DT_CALCRECT then
    begin
      lpRect.right := lpRect.left + max_width;
      lpRect.bottom := y;
      if (dtp <> nil) then
        inc(lpRect.right, lmargin + rmargin);
    end;
    result := y - lpRect.top;
  finally
    if strCopyUsed then
      FreeMem(lpString);
    if not statBufUsed then
    begin
      FreeMem(Line);
      FreeMem(swapStr);
    end;
  end
end;

{$ENDIF}

function DrawTextW(hDC: HDC; lpString: PWideChar; nCount: Integer; var lpRect:
  TRect; uFormat: UINT): Integer;
begin
 { if IsWinNTUp then
    result := Windows.DrawTextW(hDC, lpString, nCount, lpRect, uFormat)
  else
 }
  result := DrawTextExW(hDC, lpString, nCount, lpRect, uFormat, nil);
end;


function GetSysColorPen(Color: COLORREF): HPEN;
begin
  result := CreatePen(PS_SOLID, 1, Color);
end;


procedure DrawFocus(Canvas: TCanvas; R: TRect);

  procedure DrawLine(Canvas: TCanvas; StartX, StartY, EndX, EndY: integer);
  var
    Coord: Integer;
    // CRef: COLORREF;
    // DC: HDC;
  begin
    // CRef := ColorToRGB(Canvas.Pen.Color);
    // skip a pixel if not in grid
    Coord := (StartX and 1) xor (StartY and 1);
    if StartX = EndX then
    begin
      // draw vertical line
      Inc(Coord, StartY);
      // DC := Canvas.Handle;
      while Coord < EndY do
      begin
        Canvas.MoveTo(StartX, Coord);
        Inc(Coord, 1);
        Canvas.LineTo(StartX, Coord);
        Inc(Coord, 1);
      end;
    end
    else
    begin
      // draw horizontal line
      Inc(Coord, StartX);
      //DC := Canvas.Handle;
      while Coord < EndX do
      begin
        Canvas.MoveTo(Coord, StartY);
        Inc(Coord, 1);
        Canvas.LineTo(Coord, StartY);
        Inc(Coord, 1);
      end;
    end;
  end;

begin
  DrawLine(Canvas, R.Left, R.Top, R.Left, R.Bottom - 1);
  DrawLine(Canvas, R.Left, R.Top, R.Right - 1, R.Top);
  DrawLine(Canvas, R.Right - 1, R.Top, R.Right - 1, R.Bottom);
  DrawLine(Canvas, R.Left, R.Bottom - 1, R.Right - 1, R.Bottom - 1);
end;


function Win2KHideUIState: boolean;
var
  b: boolean;
begin
  SystemParametersInfo(SPI_GETKEYBOARDCUES, 0, @b, 0);
  result := not b;
  // R := TRegistry.Create;
// R.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', );
end;

function ModalFormVisible: boolean;
var
  i: integer;
{$IFNDEF VCL_4_USED}
  PFS: ^TFormState;
{$ENDIF}
begin
  result := false;
  for i := 0 to Screen.FormCount - 1 do
  begin
{$IFDEF VCL_4_USED}
    if fsModal in TCustomForm(Screen.Forms[i]).FormState then
{$ELSE}
{$IFNDEF D_2}
    PFS := @TCustomForm(Screen.Forms[i]).DropTarget;
{$ELSE}
    PFS := @TForm(Screen.Forms[i]).DropTarget;
{$ENDIF}
    dec(PFS);
    if fsModal in PFS^ then
{$ENDIF}
    begin
      result := true;
      exit;
    end;
  end;
end;


function ShiftStateToKeyData(Shift: TShiftState): integer;
begin
  if ssAlt in Shift then
    result := $20000000
  else
    result := 0;
end;

{$IFDEF ELPACK_UNICODE}

function GetShortHintW(Hint: WideString): WideString;
var
  I: Integer;
begin
  I := WidePos('|', Hint);
  if I = 0 then
    Result := Hint
  else
    Result := WideCopy(Hint, 1, I - 1);
end;
{$ENDIF}


procedure CopyTextToClipboard(AText: TElFString);
var
  Clip: TClipboard;
{$IFDEF ELPACK_UNICODE}
  mem: Cardinal;
  ptr: Pointer;
  SelText: WideString;
  SelLen: integer;
  S: string;
{$ENDIF}
begin
  Clip := Clipboard;
  Clip.Open;
{$IFDEF ELPACK_UNICODE}
  SelText := AText;
  SelLen := (Length(SelText) + 1) * 2;
  mem := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, SelLen);
  ptr := Windows.GlobalLock(mem);
  Move(PWideChar(SelText)^, ptr^, SelLen);
  Windows.GlobalUnlock(mem);
  Clip.SetAsHandle(CF_UNICODETEXT, mem);
  // if Win32Platform <> VER_PLATFORM_WIN32_NT then
  //begin
  S := SelText;
  SelLen := Length(S) + 1;
  mem := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, SelLen);
  ptr := Windows.GlobalLock(mem);
  Move(PChar(S)^, ptr^, SelLen);
  Windows.GlobalUnlock(mem);
  Clip.SetAsHandle(CF_TEXT, mem);
  //end;
{$ELSE}
  Clip.AsText := AText;
{$ENDIF}
  Clip.Close;
end;

procedure FreeAndNil(var Obj);
var
  O: TObject;
begin
  o := TObject(Obj);
  TObject(Obj) := nil;
  O.Free;
end;

function GetOwnerForm(Component: TComponent): TForm;
begin
  result := nil;
  while (not (Component is TForm)) and (Component.Owner <> nil) do
    Component := Component.Owner;
  if Component is TForm then result := (Component as TForm);
end;

procedure DrawEdge(DC: HDC; var RC: TRect; edge: UINT; grfFlags: UINT);
var
  Color1,
    Color2,
    Color3,
    Color4: TColor;
    BorderSides: TElBorderSides;
    R : TRect;

  procedure DrawBorder(DC: HDC; var rc: TRect; nColor1, nColor2, nColor3, nColor4:
    TColor; Inner, Outer : boolean; SunkenInner, SunkenOuter : boolean; BorderSides: TElBorderSides);
  var adj : integer;
  begin
    adj := 0;
    if Outer then
    begin
      if SunkenOuter then
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor4, nColor3, BorderSides)
      else
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor1, nColor2, BorderSides);
    end;
    if Inner then
    begin
      if Outer then
      begin
        if ebsTop in BorderSides then
          inc(rc.Top);
        if ebsBottom in BorderSides then
          dec(rc.Bottom);
        if ebsLeft in BorderSides then
          inc(rc.Left);
        if ebsRight in BorderSides then
          dec(rc.Right);
      end;
      if SunkenInner then
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor2, nColor1, BorderSides)
      else
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor3, nColor4, BorderSides);
    end;
    if Outer or (Inner and (not Outer)) then
      if ebsTop in BorderSides then
        inc(rc.Top);
      if ebsBottom in BorderSides then
        dec(rc.Bottom);
      if ebsLeft in BorderSides then
        inc(rc.Left);
      if ebsRight in BorderSides then
        dec(rc.Right);
  end;

begin
  if grfFlags and BF_DIAGONAL = BF_DIAGONAL then
  begin
    Windows.DrawEdge(DC, RC, Edge, grfFlags);
    exit;
  end;
  if grfFlags and BF_MONO = BF_MONO then
  begin
    Color1 := ColorToRGB(cl3DDkShadow);
    Color2 := ColorToRGB(cl3DDkShadow);
    Color3 := ColorToRGB(clBtnFace);
    Color4 := ColorToRGB(clBtnFace);
  end
  else
  if grfFlags and BF_FLAT = BF_FLAT then
  begin
    Color1 := ColorToRGB(clBtnShadow);
    Color2 := ColorToRGB(clBtnShadow);
    Color3 := ColorToRGB(clBtnFace);
    Color4 := ColorToRGB(clBtnFace);
  end
  else
  begin
    Color1 := ColorToRGB(clBtnFace);
    Color2 := ColorToRGB(cl3DDkShadow);
    Color3 := ColorToRGB(clBtnHighlight);
    Color4 := ColorToRGB(clBtnShadow);
  end;

  BorderSides := [];
  if (grfFlags and BF_LEFT) <> 0 then
    Include(BorderSides, ebsLeft);
  if (grfFlags and BF_TOP) <> 0 then
    Include(BorderSides, ebsTop);
  if (grfFlags and BF_RIGHT) <> 0 then
    Include(BorderSides, ebsRight);
  if (grfFlags and BF_BOTTOM) <> 0 then
    Include(BorderSides, ebsBottom);

  R := RC;

  DrawBorder(DC, r, Color1, Color2, Color3, Color4,
    {Inner}(Edge and (BDR_RAISEDINNER or BDR_SUNKENINNER)) <> 0,
    {Outer}(Edge and (BDR_RAISEDOUTER or BDR_SUNKENOUTER)) <> 0,
    {SunkenInner}(Edge and BDR_SUNKENINNER) <> 0,
    {SunkenOuter}(Edge and BDR_SUNKENOUTER) <> 0,
    BorderSides);

  if grfFlags and BF_ADJUST = BF_ADJUST then
  begin
    RC := R;
  end;

  // fill interior
  if grfFlags and BF_MIDDLE = BF_MIDDLE then
    with R do
      FillSolidRect(DC, Left, Top, Right - Left, Bottom - Top, clBtnFace);
end;

procedure DrawEdgeEx(DC: HDC; var RC: TRect; edge: UINT; grfFlags: UINT; Color1, Color2, Color3, Color4 : TColor);
var
  BorderSides: TElBorderSides;
  R : TRect;

  procedure DrawBorder(DC: HDC; var rc: TRect; nColor1, nColor2, nColor3, nColor4:
    TColor; Inner, Outer : boolean; SunkenInner, SunkenOuter : boolean; BorderSides: TElBorderSides);
  var adj : integer;
  begin
    adj := 0;
    if Outer then
    begin
      if SunkenOuter then
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor4, nColor3, BorderSides)
      else
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor1, nColor2, BorderSides);
    end;
    if Inner then
    begin
      if Outer then
      begin
        if ebsTop in BorderSides then
          inc(rc.Top);
        if ebsBottom in BorderSides then
          dec(rc.Bottom);
        if ebsLeft in BorderSides then
          inc(rc.Left);
        if ebsRight in BorderSides then
          dec(rc.Right);
      end;
      if SunkenInner then
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor2, nColor1, BorderSides)
      else
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor3, nColor4, BorderSides);
    end;
    if Outer or (Inner and (not Outer)) then
      if ebsTop in BorderSides then
        inc(rc.Top);
      if ebsBottom in BorderSides then
        dec(rc.Bottom);
      if ebsLeft in BorderSides then
        inc(rc.Left);
      if ebsRight in BorderSides then
        dec(rc.Right);
  end;

begin
  if grfFlags and BF_DIAGONAL = BF_DIAGONAL then
  begin
    Windows.DrawEdge(DC, RC, Edge, grfFlags);
    exit;
  end;
  begin
    Color1 := ColorToRGB(Color1);
    Color2 := ColorToRGB(Color2);
    Color3 := ColorToRGB(Color3);
    Color4 := ColorToRGB(Color4);
  end;

  BorderSides := [];
  if (grfFlags and BF_LEFT) <> 0 then
    Include(BorderSides, ebsLeft);
  if (grfFlags and BF_TOP) <> 0 then
    Include(BorderSides, ebsTop);
  if (grfFlags and BF_RIGHT) <> 0 then
    Include(BorderSides, ebsRight);
  if (grfFlags and BF_BOTTOM) <> 0 then
    Include(BorderSides, ebsBottom);

  R := RC;

  DrawBorder(DC, r, Color1, Color2, Color3, Color4,
    {Inner}(Edge and (BDR_RAISEDINNER or BDR_SUNKENINNER)) <> 0,
    {Outer}(Edge and (BDR_RAISEDOUTER or BDR_SUNKENOUTER)) <> 0,
    {SunkenInner}(Edge and BDR_SUNKENINNER) <> 0,
    {SunkenOuter}(Edge and BDR_SUNKENOUTER) <> 0,
    BorderSides);

  if grfFlags and BF_ADJUST = BF_ADJUST then
  begin
    RC := R;
  end;

  // fill interior
  if grfFlags and BF_MIDDLE = BF_MIDDLE then
    with R do
      FillSolidRect(DC, Left, Top, Right - Left, Bottom - Top, Color1);
end;

{< VCL DFM UTILS}

var

  fElReader: TElReader;
  fStream:TMemoryStream;

function GetElReader:TElReader;
begin
  if Assigned(fElReader) then
    Result := fElReader
  else
  begin
    fStream := TMemoryStream.Create;
    fElReader := TElReader.Create(fStream, 0);
    Result := fElReader;
  end;
end;

{ TElReader }

type

  {$warnings off}
  {$hints off}
  TReaderHack = class(TFiler)
  private
    FOwner: TComponent;
    FParent: TComponent;
    FFixups: TList;
    FLoaded: TList;
    FOnFindMethod: TFindMethodEvent;
    FOnSetName: TSetNameEvent;
    FOnReferenceName: TReferenceNameEvent;
    FOnAncestorNotFound: TAncestorNotFoundEvent;
    FOnError: TReaderError;
    {$IFDEF D_5_UP}
      FOnFindComponentClass: TFindComponentClassEvent;
      FOnCreateComponent: TCreateComponentEvent;
      FPropName: string;
      {$IFDEF D_6_UP}
      FFinder: TClassFinder;
      {$ENDIF}
      FCanHandleExcepts: Boolean;
    {$ELSE}
      FCanHandleExcepts: Boolean;
      FPropName: string;
    {$ENDIF}
  end;
  {$hints on}
  {$warnings on}

procedure TElReader.FakeDefineProperty(Filer: TFiler);
begin
  Filer.DefineProperty(TReaderHack(Filer).FPropName, FakeValue, nil, False);
end;

procedure TElReader.FakeValue(Reader: TReader);
begin
  TElReader(Reader).SkipValue;
end;

procedure TElReader.FakeInteger(Reader: TReader);
begin
  Reader.ReadInteger;
end;

procedure TElReader.FakeBoolean(Reader: TReader);
begin
  Reader.ReadBoolean;
end;

procedure TElReader.FakeStr(Reader: TReader);
begin
  Reader.ReadStr;
end;

procedure TElReader.FakeIdent(Reader: TReader);
begin
  Reader.ReadIdent;
end;

{$IFDEF  VCL_6_UP}

procedure TElReader.SkipValue;
begin
  inherited SkipValue;
end;

{$ELSE}

procedure TElReader.SkipProperty;
begin
  ReadStr; { Skips property name }
  SkipValue;
end;

procedure TElReader.SkipSetBody;
begin
  while ReadStr <> '' do begin end;
end;

procedure TElReader.SkipValue;

  procedure SkipList;
  begin
    while not EndOfList do
      SkipValue;
    ReadListEnd;
  end;

  procedure SkipBytes(Count: Longint);
  var
    Bytes: array[0..255] of Char;
  begin
    while Count > 0 do
      if Count > SizeOf(Bytes) then
      begin
        Read(Bytes, SizeOf(Bytes));
        Dec(Count, SizeOf(Bytes));
      end
      else
      begin
        Read(Bytes, Count);
        Count := 0;
      end;
  end;

  procedure SkipBinary(BytesPerUnit: Integer);
  var
    Count: Longint;
  begin
    Read(Count, SizeOf(Count));
    SkipBytes(Count * BytesPerUnit);
  end;

  procedure SkipCollection;
  begin
    while not EndOfList do
    begin
      if NextValue in [vaInt8, vaInt16, vaInt32] then
        SkipValue;
      SkipBytes(1);
      while not EndOfList do
        SkipProperty;
      ReadListEnd;
    end;
    ReadListEnd;
  end;

  var
    RTV :TValueType; // - Read Typed Value
    RBV :Integer;    // - Read Binary Value
begin
  RTV := ReadValue;
  case RTV of
    vaNull: begin end;
    vaList: SkipList;
    vaInt8: SkipBytes(1);
    vaInt16: SkipBytes(2);
    vaInt32: SkipBytes(4);
    vaExtended: SkipBytes(SizeOf(Extended));
    vaString, vaIdent: ReadStr;
    vaFalse, vaTrue: begin end;
    vaBinary: SkipBinary(1);
    vaSet: SkipSetBody;
    vaLString: SkipBinary(1);                //to D3, D4
    vaCollection: SkipCollection;
    {$IFDEF  VCL_4_UP}
    vaSingle: SkipBytes(Sizeof(Single));     //to D4
    vaCurrency: SkipBytes(SizeOf(Currency)); //to D4
    vaDate: SkipBytes(Sizeof(TDateTime));    //to D4
    vaWString: SkipBinary(1);                //to D4
    {$ENDIF}
    {$IFDEF  VCL_5_UP}
    vaInt64: SkipBytes(Sizeof(Int64));       //D5
    {$ENDIF}
    else
    begin
      RBV := Integer(RTV);
      //vaCollection, vaSingle, vaCurrency, vaDate, vaWString, vaInt64, vaUTF8String
      case RBV of
        {$IFDEF  VCL_3}                       // to D3
        {vaSingle}
        Integer(vaCollection)+1:
          SkipBytes(4{Sizeof(Single)});
        {vaCurrency}
        Integer(vaCollection)+2:
          SkipBytes(8{SizeOf(Currency)});
        {vaDate}
        Integer(vaCollection)+3:
          SkipBytes(Sizeof(TDateTime));
        {vaWString}
        Integer(vaCollection)+4:
          SkipBinary(1);
      {$ENDIF}                               // to D3, D4
      {$IFNDEF  VCL_5_UP}
        {vaInt64}
        Integer(vaCollection)+5:
          SkipBytes(2*{Sizeof(Int32)}4);
      {$ENDIF}
        {vaUTF8String}                       // to D3, D4, D5
        Integer(vaCollection)+6:
          SkipBinary(1);
      end;
    end;
  end;
end;

{$ENDIF VCL_6_UP}

{$IFDEF D_5_UP}

{$IFDEF D_5_UP}
procedure ReadError(Ident: PResStringRec);
begin
  raise EReadError.CreateRes(Ident);
end;
{$ELSE}
procedure ReadError(const Ident: string);
begin
  raise EReadError.Create(Ident);
end;
{$ENDIF}

type

  TPersistentProtected = class(TPersistent)
  end;

// Fix read TPersistent complex property defined by means of DefineProperty
procedure TElReader.ReadPropertyFix(AInstance: TPersistent);
var
  I, J, L: Integer;
  Instance: TPersistent;
  PropInfo: PPropInfo;
  PropValue: TObject;
  PropPath: string;
  vTmpStr: string;

  procedure HandleException(E: Exception);
  var
    Name: string;
  begin
    Name := '';
    if AInstance is TComponent then
      Name := TComponent(AInstance).Name;
    if Name = '' then Name := AInstance.ClassName;
    {$IFNDEF D_5_UP}
    raise EReadError.CreateFmt(SPropertyException, [Name, PropPath, E.Message]);
    {$ELSE}
    raise EReadError.CreateResFmt(@SPropertyException, [Name, DotSep, PropPath, E.Message]);
    {$ENDIF}
  end;

  procedure PropPathError;
  begin
    SkipValue;
    {$IFNDEF D_5_UP}
    ReadError(SInvalidPropertyPath);
    {$ELSE}
    ReadError(@SInvalidPropertyPath);
    {$ENDIF}
  end;

  {$IFNDEF D_5_UP}

  procedure PropertyNotFound;
  begin
    ReadError(SUnknownProperty);
  end;

  procedure PropertyError;
  begin
    SkipValue;
    PropertyNotFound;
  end;

  procedure ReadPropValue(Instance: TPersistent; PropInfo: Pointer);
  begin
    Error : cannot reimplemented ReadPropValue. IntConstList declared in implementation section :(
    //{$MESSAGE Error 'cannot reimplemented ReadPropValue. IntConstList declared in implementation section :('}
  end;

  {$ENDIF}

begin
  with TReaderHack(Self) do
  begin
  try
    PropPath := ReadStr;
    try
      I := 1;
      L := Length(PropPath);
      Instance := AInstance;
      FCanHandleExcepts := True;
      while True do
      begin
        J := I;
        while (I <= L) and (PropPath[I] <> '.') do Inc(I);
        FPropName := Copy(PropPath, J, I - J);
        if I > L then Break;
        PropInfo := GetPropInfo(Instance.ClassInfo, FPropName);
        if PropInfo = nil then
        //PropertyError(FPropName); // OLD CODE
        {+} // NEW CODE
        begin
          vTmpStr := FPropName;
          FPropName := PropPath;
          FCanHandleExcepts := False;
          TPersistentProtected(Instance).DefineProperties(Self);
          FCanHandleExcepts := True;
          if FPropName <> '' then
          begin
            FPropName := vTmpStr;
            FCanHandleExcepts := False;
            TPersistentProtected(Instance).DefineProperties(Self);
            FCanHandleExcepts := True;
            if FPropName <> '' then
              {$IFNDEF D_6_UP}
              PropertyError;
              {$ELSE}
              PropertyError(FPropName);
              {$ENDIF}
          end;
          exit;
        end;
        {+.}
        PropValue := nil;
        if PropInfo.PropType^.Kind = tkClass then
          PropValue := TObject(GetOrdProp(Instance, PropInfo));
        if not (PropValue is TPersistent) then
          PropPathError;
        Instance := TPersistent(PropValue);
        Inc(I);
      end;
      PropInfo := GetPropInfo(Instance.ClassInfo, FPropName);
      if PropInfo <> nil then ReadPropValue(Instance, PropInfo) else
      begin
        { Cannot reliably recover from an error in a defined property }
        FCanHandleExcepts := False;
        TPersistentProtected(Instance).DefineProperties(Self);
        FCanHandleExcepts := True;
        if FPropName <> '' then
          {$IFNDEF D_6_UP}
          PropertyError;
          {$ELSE}
          PropertyError(FPropName);
          {$ENDIF}
      end;
    except
      on E: Exception do HandleException(E);
    end;
  except
    on E: Exception do
      if not FCanHandleExcepts or not Error(E.Message) then raise;
  end;
  end;
end;

var
  fReader_ReadProperty_Inst :TJumpInstruction;

{$ENDIF D_5_UP}
{> VCL DFM UTILS}

function DWordToStr(Value:DWORD):String;
{$IFDEF VCL_3_USED}
var
 sBuff:PChar;
 {$IFDEF BUILDER_USED}
 wsprintf: pointer;
 {$ENDIF IFDEF BUILDER_USED}
const
 sFormat: String = '%u';
begin
  {$IFDEF BUILDER_USED}
  wsprintf := GetProcAddress(GetModuleHandle(user32), 'wsprintfA');
  {$ENDIF IFDEF BUILDER_USED}
  Result := '';
  Cardinal(sBuff) := LocalAlloc(LPTR, 15);
  if sBuff<>nil then
  try
    asm // wsprintf( lpstrBuffer, lpstrFormat, lpValue1, lpValue2, ... );
      push  Value
      push  sFormat
      push  sBuff
      {$IFDEF BUILDER_USED}
      call  dword ptr wsprintf
      {$ELSE}
      call  Windows.wsprintf
      {$ENDIF IFDEF BUILDER_USED}
      add   esp, $0C
    end;
    Result := sBuff;
  finally
    LocalFree(Cardinal(sBuff));
  end;
end;
{$ELSE}
begin
  Result := IntToStr(Value);
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
function GetScrollBarPos( hWnd: THandle; BarFlag:Integer ):Integer;
var
  SI: TScrollInfo;
begin
  SI.cbSize := SizeOf(SI);
  SI.fMask := SIF_POS;
  if GetScrollInfo(hWnd, BarFlag, SI) then
    Result := SI.nPos
  else
    Result := -1;
end;
{$IFNDEF VCL_5_USED}
function SafeLoadLibrary(const FileName: string): HMODULE;
var
  OldMode: UINT;
  FPUControlWord: Word;
begin
  OldMode := SetErrorMode(SEM_NOOPENFILEERRORBOX);
  try
    asm
      FNSTCW  FPUControlWord
    end;
    try
      Result := LoadLibrary(PChar(Filename));
    finally
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
    end;
  finally
    SetErrorMode(OldMode);
  end;
end;
{$ENDIF IFNDEF VCL_5_USED}
{$ENDIF IFDEF MSWINDOWS}

initialization
  GradientFillProc := nil;
  MSImg32Lib := LoadLibrary('msimg32.dll');
  if MSImg32Lib <> 0 then
  begin
    GradientFillProc := GetProcAddress(MSImg32Lib, 'GradientFill');
    if @GradientFillProc = nil then
    begin
      FreeLibrary(MSImg32Lib);
      MSImg32Lib := 0;
    end;
  end;

{$IFDEF D_5_UP}
  // Fix TReader.ReadProperty: read TPersistent complex property defined by means of DefineProperty
  JumpFromCode( GetNativeAddr(@TElReader.ReadProperty), @TElReader.ReadPropertyFix,
    @fReader_ReadProperty_Inst );
{$ENDIF}

finalization
  if @GradientFillProc <> nil then
    GradientFillProc := nil;
  if MSImg32Lib <> 0 then
  begin
    FreeLibrary(MSImg32Lib);
    MSImg32Lib := 0;
  end;

{$IFDEF D_5_UP}
  RestoreSavedCode( GetNativeAddr(@TElReader.ReadProperty), fReader_ReadProperty_Inst );
{$ENDIF}

{< VCL DFM UTILS}
  fElReader.Free;
  fStream.Free;
{> VCL DFM UTILS}

end.
