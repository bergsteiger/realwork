{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCVIEWR.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{!!.10 - Many changes have been made to improve speed and provide better
         16-bit vs 32-bit typing. Not all have been marked.}

unit OvcViewr;
  {-Viewer component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, Menus, Messages, StdCtrls, SysUtils,
  OvcBase, OvcCaret, OvcCmd, OvcColor, OvcConst, OvcData,
  OvcExcpt, OvcFxFnt, OvcMisc, OvcStr;

type
  {text position record for viewer}
  TOvcTextPos = packed record
    Line : LongInt; {always a 32-bit quantity}
    Col  : integer; {size depends on the compiler}
  end;

  {a range of text in a viewer}
  TOvcRange = record
    Start, Stop : TOvcTextPos;
  end;

const
  {default property values for viewer and descendants}
  DefBorderStyle     = bsSingle;
  DefBufferPageCount = 16;
  DefColor           = clWindow;
  DefExpandTabs      = True;
  DefFilterChars     = True;
  DefHeight          = 150;
  DefHexMode         = False;
  DefHighlightBack   = clHighlight;
  DefHighlightText   = clHighlightText;
  DefIsOpen          = False;
  DefMarginColor     = clWindow;
  DefScrollBars      = ssBoth;
  DefShowBookmarks   = True;
  DefShowCaret       = True;
  DefTabSize         = 8;
  DefTabStop         = True;
  DefWidth           = 200;

  MaxMarkers         = 10;    {maximum number of text markers}

type
  {The ancestor viewer class}
  TOvcBaseViewer = class(TOvcBase)
  {.Z+}
  protected {private}
    {property fields - persistent}
    FBorderStyle      : TBorderStyle;
    FExpandTabs       : Boolean;
    FFixedFont        : TOvcFixedFont;
    FHighlightColors  : TOvcColors;
    FMarginColor      : TColor;
    FScrollBars       : TScrollStyle;
    FShowBookmarks    : Boolean;
    FShowCaret        : Boolean;
    FTabSize          : Byte;

    {property fields - set at runtime}
    FCaretEffCol      : integer;
    FCaretPos         : TOvcTextPos;
    FLineCount        : LongInt;
    FMarkers          : array[0..MaxMarkers-1] of TOvcTextPos;
    FTopLine          : LongInt;

    {event variables}
    FOnShowStatus     : TShowStatusEvent;
    FOnTopLineChanged : TTopLineChangedEvent;
    FOnUserCommand    : TUserCommandEvent;

    {other internal fields}
    vwAmFocused       : Boolean;         {True if focused}
    vwAnchor          : TOvcTextPos;     {anchor for highlighting}
    vwBMGlyphs        : TBitMap;         {marker glyphs}
    vwCaret           : TOvcSingleCaret; {our caret}
    vwCols            : integer;         {number of columns in window}
    vwColWid          : integer;         {width of one column}
    vwDefaultChar     : Char;            {replacement Char for current font}
    vwDitheredBG      : Boolean;         {True if a background color is dithered}
    vwDivisor         : LongInt;         {divisor for scroll bars}
    vwFile            : Integer;         {handle of file being browsed}
    vwFirstChar       : Char;            {first Char in current font}
    vwHighlight       : TOvcRange;       {highlight range}
    vwHDelta          : integer;         {horizontal scroll delta}
    vwHScroll         : Boolean;         {True if we have a horizontal scroll bar}
    vwHSHigh          : integer;         {horizontal scroll limit}
    vwLastChar        : Char;            {last Char in current font}
    vwLineSelCursor   : hCursor;         {line selection cursor}
    vwLineSelCursorOn : Boolean;         {is line selection cursor in use?}
    vwRowHt           : integer;         {height of one row}
    vwRows            : LongInt;         {number of rows in window}
    vwSaveCursor      : HCursor;         {saved cursor for lengthy waits}
    vwVScroll         : Boolean;         {True if we have a vertical scroll bar}
    vwVSHigh          : LongInt;         {vertical scroll limit}
    vwVSMax           : LongInt;         {max value for vertical scroll bar}
    vwWaiting         : Boolean;         {True if wait cursor is shown}

    {property access methods}
    function GetCaretActualPos : TOvcTextPos;
    function GetCaretEffectivePos : TOvcTextPos;
    function GetCaretType : TOvcCaret;
    function GetLineLength(LineNum : LongInt) : integer;
    function GetStringLine(LineNum : LongInt) : string;
    function GetTopLine : LongInt;
    procedure SetBorderStyle(BS : TBorderStyle);
    procedure SetCaretType(CT : TOvcCaret);
    procedure SetCaretActualPos(LC : TOvcTextPos);
    procedure SetCaretEffectivePos(LC : TOvcTextPos);
    procedure SetExpandTabs(E : Boolean);
    procedure SetFixedFont(FF : TOvcFixedFont);
    procedure SetLineCount(N : LongInt);
    procedure SetMarginColor(C : TColor);
    procedure SetScrollBars(SB : TScrollStyle);
    procedure SetShowBookmarks(SB : Boolean);
    procedure SetShowCaret(Value : Boolean);
    procedure SetTabSize(N : Byte);
    procedure SetTopLine(LineNum : LongInt);

    {VCL control messages}
    procedure CMColorChanged(var Msg: TMessage);
      message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Msg: TMessage);
      message CM_FONTCHANGED;

    {windows message methods}
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode);
      message WM_GETDLGCODE;
    procedure WMHScroll(var Msg : TWMScroll);
      message WM_HSCROLL;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg : TWMMouse);
      message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Msg : TWMMouse);
      message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var Msg : TWMMouse);
      message WM_LBUTTONUP;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMMouseMove(var Msg : TWMMouse);
      message WM_MOUSEMOVE;
    procedure WMNCHitTest(var Msg : TWMNCHitTest);
      message WM_NCHITTEST;
    procedure WMSetCursor(var Msg : TWMSetCursor);
      message WM_SETCURSOR;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMVScroll(var Msg : TWMScroll);
      message WM_VSCROLL;

  protected
    {private message methods}
    procedure OMShowStatus(var Msg : TOMShowStatus);
      message om_ShowStatus;

    procedure CreateParams(var Params: TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure Paint;
      override;

    {virtual methods}
    procedure DoOnShowStatus(LineNum : LongInt; ColNum : integer);
      dynamic;
      {-call the OnShowStatus method, if assigned}
    procedure DoOnTopLineChanged(Line : LongInt);
      dynamic;
      {-perform notification of a top line changed}
    procedure DoOnUserCommand(Command : Word);
      dynamic;
      {-perform notification of a user command}
    function GetLinePtr(LineNum : LongInt; var Len : integer) : PAnsiChar;
      virtual; abstract;
      {-return a pointer to the specified line}

    {general methods}
    procedure vwCalcColorFields;
    procedure vwCalcFontFields;
    function vwCaretIsVisible : Boolean;
    procedure vwChangeLineCount(N : LongInt);
    procedure vwFixedFontChanged(Sender : TObject);
    function vwGetLineEffLen(N : LongInt) : integer;
    procedure vwGetMousePos(var MousePos : TOvcTextPos; XPixel, YPixel : integer);
    procedure vwHighlightColorsChanged(Sender : TObject);
    procedure vwInitInternalFields;
    procedure vwInvalidateLine(LineNum : LongInt);
    procedure vwMoveCaret(HDelta : integer; VDelta : LongInt;
                        MoveByPage, AmSelecting : Boolean);
    procedure vwMoveCaretPrim(HDelta : integer; VDelta : LongInt;
                            MoveByPage, AmSelecting, AbsMove : Boolean);
    procedure vwMoveCaretTo(Line : LongInt; Col : integer; AmSelecting : Boolean);
    procedure vwPositionCaret;
    procedure vwReadBookmarkGlyphs;
    procedure vwRefreshLines(const Start, Stop : TOvcTextPos);
    procedure vwResetHighlight(Refresh : Boolean);
    procedure vwScrollPrim(HDelta : integer; VDelta : LongInt);
    procedure vwScrollPrimHorz(Delta : integer);
    procedure vwScrollPrimVert(Delta : LongInt);
    procedure vwSetHScrollPos;
    procedure vwSetHScrollRange;
    procedure vwSetVScrollPos;
    procedure vwSetVScrollRange;
    procedure vwShowWaitCursor(ShowIt : Boolean);
    procedure vwUpdateHighlight(Refresh : Boolean);
  {.Z-}

    {properties}
    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default DefBorderStyle;

    property Caret : TOvcCaret
      read GetCaretType
      write SetCaretType;

    property ExpandTabs : Boolean
      read FExpandTabs
      write SetExpandTabs
      default DefExpandTabs;

    property FixedFont : TOvcFixedFont
      read FFixedFont
      write SetFixedFont;

    property HighlightColors : TOvcColors
      read FHighlightColors
      write FHighlightColors;

    property MarginColor : TColor
      read FMarginColor
      write SetMarginColor
      default DefMarginColor;

    property ScrollBars : TScrollStyle
      read FScrollBars
      write SetScrollBars
      default DefScrollBars;

    property ShowBookmarks : Boolean
      read FShowBookmarks
      write SetShowBookmarks
      default DefShowBookmarks;

    property ShowCaret : Boolean
      read FShowCaret
      write SetShowCaret
      default DefShowCaret;

    property TabSize : Byte
      read FTabSize
      write SetTabSize
      default DefTabSize;

    {events}
    property OnShowStatus : TShowStatusEvent
       read FOnShowStatus
       write FOnShowStatus;

    property OnTopLineChanged : TTopLineChangedEvent
      read FOnTopLineChanged
      write FOnTopLineChanged;

    property OnUserCommand : TUserCommandEvent
      read FOnUserCommand
      write FOnUserCommand;

  public
  {.Z+}
    {VCL methods}
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
      override;
  {.Z-}

    function CheckLine(LineNum : LongInt) : LongInt;
      virtual;

    function ActualColumn(Line : LongInt; EffectiveCol : integer) : integer;
      {-return the actual column given the line and effective column}
    procedure ClearMarker(N : Byte);
      {-remove the specified text marker}
    procedure CopyToClipboard;
      {-copy highlighted text to the clipboard}
    function EffectiveColumn(Line : LongInt; ActualCol : integer) : integer;
      {-return the effective column given the line and actual column}
    function GetCaretPosition(var Col : integer) : LongInt;
      {-return the current position of the caret}
    function GetLine(LineNum : LongInt; Dest : PAnsiChar; DestLen : integer) : PAnsiChar;
      {-get the specified line}
    function GetMarkerPosition(N : Byte; var Col : integer) : LongInt;
      {-return the current position of the specified marker}
    function GetPrintableLine(LineNum : LongInt; Dest : PAnsiChar;
                              DestLen : integer) : integer;
      {-get a line in a format suitable for printing}
    function GetSelection(var Line1 : LongInt; var Col1 : integer;
                          var Line2 : LongInt; var Col2 : integer) : Boolean;
      {-return True if any text is currently selected}
    procedure GotoMarker(N : Byte);
      {-move the caret to the specified text marker}
    function Search(const S : string; Options : TSearchOptionSet) : Boolean;
      {-search for a string returning True if found}
      virtual;
    procedure SelectAll(CaretAtEnd : Boolean);
      {-select all text in the editor}
    procedure SetCaretPosition(Line : LongInt; Col : integer);
      {-move the caret to a specified line and column}
    procedure SetMarker(N : Byte);
      {-set a text marker at the current caret position}
    procedure SetMarkerAt(N : Byte; Line : LongInt; Col : integer);
      {-set a text marker at the specified position}
    procedure SetSelection(Line1 : LongInt; Col1 : integer;
                           Line2 : LongInt; Col2 : integer;
                           CaretAtEnd : Boolean);
      {-select a region of text}

    {public properties}
    property CaretActualPos : TOvcTextPos
      read GetCaretActualPos
      write SetCaretActualPos;

    property CaretEffectivePos : TOvcTextPos
      read GetCaretEffectivePos
      write SetCaretEffectivePos;

    property Color default DefColor;

    property LineCount : LongInt
      read FLineCount
      write SetLineCount;

    property LineLength[LineNum : LongInt] : integer
      read GetLineLength;

    property Lines[LineNum : LongInt] : string
      read GetStringLine;

    property TopLine : LongInt
      read GetTopLine
      write SetTopLine
      stored False;
  end;

  {.Z+}
  {TOvcTextFileViewer related definitions}
  TStringNode = class
  protected
    snNext : TStringNode;  {Points to the next node in the list}
    snPrev : TStringNode;  {Points to the previous node in the list}
    snS    : PAnsiChar;    {Points to the string}
    snSLen : Word;         {Length of snS}
  public                                                               {!!.D4}
    constructor Create(P : PAnsiChar);
    destructor Destroy;
      override;
    function GetS(var Len : integer) : PAnsiChar;
  end;

  TVwrStringList = class
  protected
    slHead     : TStringNode;     {Start of list}
    slTail     : TStringNode;     {End of list}
    slCount    : LongInt;         {Size of list}
    slLastN    : LongInt;         {Index of last node found}
    slLastNode : TStringNode;     {Last node found}
  public                                                               {!!.D4}
    constructor Create;
      {-Initialize an empty list}
    destructor Destroy;
      override;
      {-Destroy the list}
    function Count : LongInt;
      {-Return the size of the list}
    procedure Append(P : TStringNode);
      {-Add a node to the end of the list}
    function Nth(N : LongInt) : TStringNode;
      {-Return a pointer to the Nth node in the list}
  end;
  {.Z-}

  TOvcCustomTextFileViewer = class(TOvcBaseViewer)
  {.Z+}
  protected {private}
    {properties}
    FFileName : PString;
    FFileSize : LongInt;

    {Other fields}
    fvLines : TVwrStringList;

    {property access methods}
    function GetFileName : string;
    function GetIsOpen : Boolean;
    procedure SetFileName(const N : string);
    procedure SetIsOpen(OpenIt : Boolean);

  protected
    function GetLinePtr(LineNum : LongInt; var Len : integer) : PAnsiChar;
      override;
  {.Z-}

    {properties}
    property FileName : string
      read GetFileName
      write SetFileName;

    property IsOpen : Boolean
      read GetIsOpen
      write SetIsOpen
      default DefIsOpen;

  public
    {VCL methods}
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;

    function CheckLine(LineNum : LongInt) : LongInt;
      override;

    {public properties}
    property FileSize : LongInt
       read FFileSize;
  end;

type
  TOvcTextFileViewer = class(TOvcCustomTextFileViewer)
  published
    {properties}
    property BorderStyle;
    property Caret;
    property Controller;
    property ExpandTabs;
    property FileName;
    property FixedFont;
    property HighlightColors;
    property IsOpen;
    property MarginColor;
    property ScrollBars;
    property ShowBookmarks;
    property ShowCaret;
    property TabSize;

    property Align;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default DefTabStop;
    property Visible;

    {events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
    property OnShowStatus;
    property OnTopLineChanged;
    property OnUserCommand;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
  end;

{.Z+}
{TOvcFileViewer related definitions}
const
  {--DO NOT CHANGE ANY OF THE FOLLOWING CONSTANTS--}
  LogBufSize = 12;                {Log base 2 of PageBufSize}
  PageBufSize = 1 shl LogBufSize; {Size of each page buffer (ie 4KB)}
  MinPageCount = 2;    {Min number of page buffers for a TOvcCustomFileViewer}
  MaxPageCount = 512;  {Max number of page buffers for a TOvcCustomFileViewer}
  {$IFDEF Win32}
  LargestQuasiTime = $7FFFFFFF;
  {$ELSE}
  LargestQuasiTime = $FFFF;
  {$ENDIF}

type
  {$IFDEF Win32}
  TQuasiTime = longint;        {Quasi-time type for LRU calcs}
  TBlockNum  = longint;        {Block number type}
  {$ELSE}
  TQuasiTime = word;           {Quasi-time type for LRU calcs}
  TBlockNum  = word;           {Block number type}
  {$ENDIF}

  PfvBufferArray = ^TfvBufferArray;
  TfvBufferArray = array [0..pred(PageBufSize)] of Char;

  TfvPageRec = record
    BlockNum : TBlockNum;      {BlockNum * PageBufSize = file pos of block start}
    ByteCount: integer;        {Number of bytes used in Buffer}
    LastUsed : TQuasiTime;     {Quasi-time when last accessed}
    Buffer   : PfvBufferArray; {Points to 4KB page buffer}
  end;

type
  PfvPageArray = ^TfvPageArray;
  TfvPageArray = array[0..Pred(MaxPageCount)] of TfvPageRec;
{.Z-}

type
  TOvcCustomFileViewer = class(TOvcBaseViewer)
  {.Z+}
  protected {private}
    {properties}
    FBufferPageCount : integer;     {Number of pages in fvPages}
    FFileName        : PString;     {Name of file}
    FFileSize        : LongInt;     {File size of file if open, else 0}
    FFilterChars     : Boolean;     {True if filtering 'bad' chars}
    FInHexMode       : Boolean;     {True if displaying in Hex}
    FIsOpen          : Boolean;     {True if file is open}

    {other fields}
    fvCurLine        : LongInt;     {Current line in file           (not used in hex mode)}
    fvCurOffset      : LongInt;     {Offset of start of fvCurLine   (not used in hex mode)}
    fvKnownLine      : LongInt;     {Some known line number         (not used in hex mode)}
    fvKnownOffset    : LongInt;     {Offset of start of fvKnownLine (not used in hex mode)}
    fvLastLine       : LongInt;     {Final line number in file}
    fvLastLine2      : LongInt;     {Final line number in 'other' mode (text/hex)}
    fvLastLineOffset : LongInt;     {Offset of start of fvLastLine  (not used in hex mode)}
    fvLnBuf          : PAnsiChar;   {Line buffer}
    fvLineInBuf      : LongInt;     {Line currently in fvLnBuf}
    fvLnBufLen       : integer;     {Length of line currently in fvLnBuf}
    fvMaxPage        : LongInt;     {Max page number in fvPages}
    fvNewLine        : LongInt;     {Newest line in file            (not used in hex mode)}
    fvNewOffset      : LongInt;     {Offset of start of fvNewLine   (not used in hex mode)}
    fvPageArraySize  : integer;     {Size of the page array}
    fvPages          : PfvPageArray;{Array of page buffers, 0..fvMaxPage}
    fvTicks          : TQuasiTime;  {Quasi-time, for page buffer replacement}
    fvWorkBeg        : Integer;     {First valid offset of fvWorkPtr}   {actual ptr in 32-bit}
    fvWorkBlk        : TBlockNum;   {Working block number}
    fvWorkEnd        : integer;     {Next invalid offset of fvWorkPtr}  {actual ptr in 32-bit}
    fvWorkOffset     : LongInt;     {Working file position}
    fvWorkPtr        : PAnsiChar;   {Pointer to working character}

    {property access methods}
    function GetFileName : string;
    procedure SetBufferPageCount(BPC : integer);
    procedure SetFileName(const N : string);
    procedure SetFilterChars(FC : Boolean);
    procedure SetInHexMode(HM : Boolean);
    procedure SetIsOpen(OpenIt : Boolean);

    {general methods}
    procedure fvDeallocateBuffers;
    function fvGetLineAsText(LineNum : LongInt; var Len : integer) : PAnsiChar;
    function fvGetLineInHex(LineNum : LongInt; var Len : integer) : PAnsiChar;
    function fvGetWorkingChar : Boolean;
    procedure fvGetWorkingPage;
    procedure fvGotoHexLine(Line : LongInt);
    procedure fvGotoTextLine(Line : LongInt);
    procedure fvInitFileFields;
    procedure fvInitObjectFields;
    procedure fvNewWorkingSet;

  protected
    {virtual methods}
    function GetLinePtr(LineNum : LongInt; var Len : integer) : PAnsiChar;
      override;
  {.Z-}

    {properties}
    property BufferPageCount : integer
      read FBufferPageCount
      write SetBufferPageCount
      default DefBufferPageCount;

    property FileName : string
      read GetFileName
      write SetFileName;

    property FilterChars : Boolean
      read FFilterChars
      write SetFilterChars
      default DefFilterChars;

    property InHexMode : Boolean
      read FInHexMode
      write SetInHexMode
      default DefHexMode;

    property IsOpen : Boolean
      read FIsOpen
      write SetIsOpen
      default DefIsOpen;

  public
    {VCL methods}
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;

    {other methods}
    function CheckLine(LineNum : LongInt) : LongInt;
      override;
    function Search(const S : string; Options : TSearchOptionSet) : Boolean;
      {-search for a string returning True if found}
      override;

    {public properties}
    property FileSize : LongInt
      read FFileSize;
  end;

type
  TOvcFileViewer = class(TOvcCustomFileViewer)
  published
    {properties}
    property BorderStyle;
    property BufferPageCount;
    property Caret;
    property Controller;
    property ExpandTabs;
    property FileName;
    property FilterChars;
    property FixedFont;
    property InHexMode;
    property HighlightColors;
    property IsOpen;
    property MarginColor;
    property ScrollBars;
    property ShowBookmarks;
    property ShowCaret;
    property TabSize;

    property Align;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default DefTabStop;
    property Visible;

    {events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
    property OnShowStatus;
    property OnTopLineChanged;
    property OnUserCommand;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

{$IFNDEF Win32}
type
  OS = record O, S : Word; end;  {to split pointers into selector & offset}
{$ENDIF}

const
  HScrollMax = 512;
  BookmarkHeight = 12;               {MUST be even}
  BookmarkWidth = 12;                {MUST be even}
  LeftMargin = BookmarkWidth + 4;    {MUST be even}

const
  LineBufSize = 1024;    {Size of line buffer: ie maximum line length}

const
  {--DO NOT CHANGE ANY OF THE FOLLOWING CONSTANTS--}
  BlockUnused = $FFFF;   {Special block number to show page is unused}

const
  NullString  : array [0..1] of Char = '';
  PNullString : PAnsiChar = @NullString;


{*** helper routines ***}

{$IFDEF Win32}
function CalcActCol(S : PAnsiChar; EffCol : integer; TabSize : integer) : integer; register;
  {-Compute actual column for effective column EffCol in S, accounting for
    tabs embedded in S. EffCol can range from 0 onwards, negatives are an
    error, but are not checked for.}
asm
  push ebx
  push edi
  push esi

  mov  esi, eax
  xor  eax, eax
  and  edx, 0FFFFh
  or   edx, edx
  jz   @@ExitNoCalc

  mov  ebx, esi
  xor  edi, edi
  and  ecx, 0FFFFh
  mov  edi, ecx
  mov  ecx, edx

@@DoNextChar:
  mov  dl, [esi]
  or   dl, dl
  jz   @@Exit
  inc  esi
  cmp  dl, 9
  je   @@DoTab
  inc  eax
  cmp  eax, ecx
  jb   @@DoNextChar
  jmp  @@Exit

@@DoTab:
  xor  edx, edx
  div  edi
  inc  eax
  mul  edi
  cmp  eax, ecx
  jb   @@DoNextChar     {no, go get next Char}
  je   @@Exit           {exactly right, exit routine}
  dec  esi              {whoops, overshot due to last tab Char; correct it}
@@Exit:
  mov  eax, esi         {calc the actual col}
  sub  eax, ebx
@@ExitNoCalc:
  pop  esi
  pop  edi
  pop  ebx
end;
{$ELSE}
function CalcActCol(S : PAnsiChar; EffCol : integer; TabSize : integer) : integer; near; assembler;
  {-Compute actual column for effective column EffCol in S, accounting for
    tabs embedded in S. EffCol can range from 0 onwards, negatives are an
    error, but are not checked for.}
asm
  xor ax, ax          {set calc'd eff col to 0}
  mov cx, EffCol      {get eff col to attain}
  jcxz @@ExitNoCalc   {done if cx is zero}
  les si,S            {es:si => S[0]}
  mov bx, si          {save start offset}
  mov di,TabSize      {di has tabsize}
@@DoNextChar:
  mov dl, es:[si]     {get next Char}
  or dl, dl           {is Char a null?}
  jz @@Exit           {done if so}
  inc si              {move string pointer}
  cmp dl, 9           {is Char a tab?}
  je @@DoTab          {yes, go process it}
  inc ax              {increment eff col}
  cmp ax, cx          {have we reached the target?}
  jb @@DoNextChar     {no, go get next Char}
  jmp @@Exit          {yes, exit routine}
@@DoTab:
  xor dx,dx           {dx = 0: prepare for div}
  div di              {divide eff col by tabsize}
  inc ax              {add one}
  mul di              {multiply by tabsize}
  cmp ax, cx          {have we reached (or gone beyond) the target?}
  jb @@DoNextChar     {no, go get next Char}
  je @@Exit           {exactly right, exit routine}
  dec si              {whoops, overshot due to last tab Char; correct it}
@@Exit:
  mov ax, si          {calc the actual col}
  sub ax, bx
@@ExitNoCalc:
end;
{$ENDIF}

{$IFDEF Win32}
function CalcEffCol(S : PAnsiChar; ActCol : integer; TabSize : integer) : integer; register;
  {-Compute effective column for actual column ActCol in S, accounting for
    tabs embedded in S. ActCol can range from 0 onwards, negatives are an
    error, but are not checked for.}
asm
  push ebx
  push edi
  push esi

  mov  esi, eax
  xor  eax, eax
  and  edx, 0FFFFh
  or   edx, edx
  jz   @@Exit

  and  ecx, 0FFFFh
  mov  edi, ecx
  mov  ecx, edx

@@DoNextChar:
  mov  dl, [esi]
  or   dl, dl
  jz   @@Exit
  inc  esi
  cmp  dl, 9
  je   @@DoTab        {yes, go process tab}
  inc  eax            {increment eff col}
  dec  ecx            {decrement actual col}
  jnz  @@DoNextChar   {go back for next Char if one there}
  jmp  @@Exit         {otherwise exit}
@@DoTab:
  xor  edx,edx        {dx = 0: prepare for div}
  div  edi            {divide eff col by tabsize}
  inc  eax            {add one}
  mul  edi            {multiply by tabsize}
  dec  ecx            {decrement actual col}
  jnz  @@DoNextChar   {go back for next Char if one there}
@@Exit:
  pop  esi
  pop  edi
  pop  ebx
end;
{$ELSE}
function CalcEffCol(S : PAnsiChar; ActCol : integer; TabSize : integer) : integer; near; assembler;
  {-Compute effective column for actual column ActCol in S, accounting for
    tabs embedded in S. ActCol can range from 0 onwards, negatives are an
    error, but are not checked for.}
asm
  xor ax, ax          {set eff col to 0}
  mov cx, ActCol      {set cx to actual col}
  jcxz @@Exit         {done if cx is zero}
  les si,S            {es:si => S[0]}
  mov di,TabSize      {di has tabsize}
@@DoNextChar:
  mov dl, es:[si]     {get next Char}
  or dl, dl           {is Char a null?}
  jz @@Exit           {done if so}
  inc si              {move string pointer}
  cmp dl, 9           {is it a tab?}
  je @@DoTab          {yes, go process tab}
  inc ax              {increment eff col}
  dec cx              {decrement actual col}
  jnz @@DoNextChar    {go back for next Char if one there}
  jmp @@Exit          {otherwise exit}
@@DoTab:
  xor dx,dx           {dx = 0: prepare for div}
  div di              {divide eff col by tabsize}
  inc ax              {add one}
  mul di              {multiply by tabsize}
  dec cx              {decrement actual col}
  jnz @@DoNextChar    {go back for next Char if one there}
@@Exit:
end;
{$ENDIF}

{$IFDEF Win32}
function IsWhiteSpace(C : Char) : Boolean;
  {-Return True if a Char is 'white' space}
asm
  mov  edx, eax
  xor  eax, eax
  cmp  dl, 9h
  je   @@ReturnTrue
  cmp  dl, 20h
  jne  @@Exit

@@ReturnTrue:
  inc  eax

@@Exit:
end;
{$ELSE}
function IsWhiteSpace(C : Char) : Boolean;
  {-Return True if a Char is 'white' space}
inline(
       $31/$C0/       {  xor ax, ax       assume False }
       $5B/           {  pop bx           get Char     }
       $80/$FB/$09/   {  cmp bl, TAB      is it Tab?   }
       $74/$05/       {  je @@ReturnTrue  yes          }
       $80/$FB/$20/   {  cmp bl, SPACE    is it space? }
       $75/$01/       {  jne @@Exit       no, exit     }
                      {@@ReturnTrue:                   }
       $40            {  inc ax           return True  }
      );              {@@Exit:                         }
{$ENDIF}

{$IFDEF Win32}
procedure InsertHexPair(var Dest; C : Char); register;
  {-Convert C to hex and store in Dest}
const
  HexDigits : array[0..$F] of Char = '0123456789ABCDEF';
asm
  push edi

  mov  edi, eax
  mov  ecx, offset HexDigits
  mov  dh, dl
  and  dh, 0Fh
  shr  dl, 4
  xor  eax, eax
  mov  al, dl
  mov  dl, [ecx+eax]
  mov  al, dh
  mov  dh, [ecx+eax]
  mov  ax, dx
  stosw

  pop  edi
end;
{$ELSE}
procedure InsertHexPair(var Dest; C : Char); assembler;
  {-Convert C to hex and store in Dest}
const
  HexDigits : array[0..$F] of Char = '0123456789ABCDEF';
asm
  mov bx,offset HexDigits {bx has offset of translation table}
  mov al,C                {al = C}
  mov ah,al               {save al in ah}
  and al,$0F              {al has low nibble}
  xlat                    {translate it to a hex digit}
  xchg al,ah              {exchange al and ah}
  shr al,4                {al has value of high nibble}
  xlat                    {translate it to a hex digit}
  les di,Dest             {es:di = Dest}
  stosw                   {store result in Dest}
end;
{$ENDIF}

{$IFDEF Win32}
function MinI(X, Y : integer) : integer;
  {Return the minimum of two integers}
begin
  if (X < Y) then
    Result := X
  else
    Result := Y;
end;
{$ELSE}
function MinI(X, Y : integer) : integer;
  {Return the minimum of two integers}
inline($58/      {  pop ax}
       $5A/      {  pop dx}
       $39/$D0/  {  cmp ax, dx}
       $7E/$01/  {  jle @@Exit}
       $92       {  xchg ax, dx}
       );        {@@Exit:}
{$ENDIF}

{$IFDEF Win32}
function MaxI(X, Y : integer) : integer;
  {Return the maximum of two integers}
begin
  if (X > Y) then
    Result := X
  else
    Result := Y;
end;
{$ELSE}
function MaxI(X, Y : integer) : integer;
  {Return the maximum of two integers}
inline($58/      {  pop ax}
       $5A/      {  pop dx}
       $39/$D0/  {  cmp ax, dx}
       $7D/$01/  {  jge @@Exit}
       $92       {  xchg ax, dx}
       );        {@@Exit:}
{$ENDIF}

function MinL(X, Y : LongInt) : LongInt;
  {Return the minimum of two long integers}
begin
  if (X < Y) then
    Result := X
  else
    Result := Y;
end;

function MaxL(X, Y : LongInt) : LongInt;
  {Return the maximum of two long integers}
begin
  if (X > Y) then
    Result := X
  else
    Result := Y;
end;

function PosEqual(const P1, P2 : TOvcTextPos) : Boolean;
  {-Return True if two text positions are the same}
begin
  Result := (P1.Line = P2.Line) and (P1.Col = P2.Col);
end;

function RangeEqual(const R1, R2 : TOvcRange) : Boolean;
  {-Return True if two text ranges are the same}
begin
  Result := PosEqual(R1.Start, R2.Start) and PosEqual(R1.Stop, R2.Stop);
end;

function RangeIsEmpty(const R : TOvcRange) : Boolean;
  {-Return True if a text range is empty}
begin
  RangeIsEmpty := PosEqual(R.Start, R.Stop);
end;

function RangeIsBackwards(const R : TOvcRange) : Boolean;
  {-Return True if a text range is 'backwards'}
begin
  Result :=
     (R.Start.Line > R.Stop.Line) or
    ((R.Start.Line = R.Stop.Line) and (R.Start.Col > R.Stop.Col));
end;

{$IFDEF Win32}
function LineHasTabs(S : PAnsiChar; Len : integer) : Boolean; register;
  {-Return True if a string has tab characters}
asm
  push  edi

  mov   edi, eax
  mov   ecx, edx
  mov   al, 9h
  cld
  repne scasb
  mov   eax, 0
  jne   @@Exit
  inc   eax

@@Exit:
  pop   edi
end;
{$ELSE}
function LineHasTabs(S : PAnsiChar; Len : integer) : Boolean; near; assembler;
  {-Return True if a string has tab characters}
asm
  les di,S                    {ES:DI = S}
  mov al,9                    {AL = Tab}
  mov cx,len                  {CX has length}
  cld                         {go forward}
  repne scasb                 {search for the character}
  mov al,0                    {assume False}
  jne @1
  inc al                      {else return True}
@1:
end;
{$ENDIF}

{$IFDEF Win32}
procedure MapUnknownChars(S : PAnsiChar; Len : integer;
                          FirstChar, LastChar, DefChar : Char); register;
  {-Map chars outside the font's character set to a default Char}
asm
  push ebx              {save ebx}

  or edx, edx           {is Len <= 0?}
  jle @@Exit            {yes, exit now}
  mov  ch, LastChar     {cl = FirstChar, ch = LastChar}
  mov  bl, DefChar      {bl = DefChar}

@@GetNextChar:
  mov  bh, [eax]        {get next char from S}
  or   bh, bh           {is it the terminator?}
  jz   @@Exit           {yes, exit now}

  cmp  bh, cl           {is it < FirstChar?}
  jb   @@CvtChar        {yes, go convert}

  cmp  bh, ch           {is it > LastChar?}
  ja   @@CvtChar        {yes, go convert}

  inc  eax              {move char pointer in S}
  dec  edx              {dec Len}
  jnz  @@GetNextChar    {if Len > 0 go do next char}
  jmp  @@Exit           {all over}

@@CvtChar:
  mov  [eax], bl        {convert the current char}
  inc  eax              {move char pointer in S}
  dec  edx              {dec Len}
  jnz  @@GetNextChar    {if Len > 0 go do next char}

@@Exit:
  pop  ebx              {restore old ebx}
end;
{$ELSE}
procedure MapUnknownChars(S : PAnsiChar; Len : integer;
                          FirstChar, LastChar, DefChar : Char); near; assembler;
  {-Map chars outside the font's character set to a default Char}
asm
  mov cx,Len         {cx will hold the number of chars to go}
  jcxz @@Exit        {exit if it's zero}
  les di,S           {es:di => next character to process}
  mov bl, FirstChar  {bl is the first Char in the font}
  mov bh, LastChar   {bh is the last Char in the font}
  mov dl, DefChar    {dl is the replacement Char}
@@GetNextChar:
  mov al, es:[di]    {get the next character}
  or al, al          {is it null?}
  jz @@Exit          {yes, so exit}
  cmp al, bl         {is it less than the first Char?}
  jb @@CvtChar       {yes, so go convert}
  cmp al, bh         {is it greater than the last Char?}
  ja @@CvtChar       {yes, so go convert}
  inc di             {point to next Char}
  dec cx             {decrement the num of chars to go}
  jnz @@GetNextChar  {if more left, go process next Char}
  jmp @@Exit         {no more chars left, so exit}
@@CvtChar:
  mov es:[di], dl    {replace the unknown Char}
  inc di             {point to next Char}
  dec cx             {decrement the num of chars to go}
  jnz @@GetNextChar  {if more left, go process next Char}
@@Exit:
end;
{$ENDIF}

{*** TOvcViewerBase ***}

function TOvcBaseViewer.ActualColumn(Line : LongInt; EffectiveCol : integer) : integer;
  {-return the actual column given the line and effective column}
var
  P : PAnsiChar;
  L : integer;
begin
  if ExpandTabs and (EffectiveCol >= 0) then begin
    P := GetLinePtr(Line, L);
    Result := CalcActCol(P, EffectiveCol, TabSize);
    {minus result indicates EffectiveCol was invalid given the tabs encountered}
  end else
    Result := EffectiveCol;
end;

function TOvcBaseViewer.CheckLine(LineNum : LongInt) : LongInt;
begin
  Result := LineNum;
end;

procedure TOvcBaseViewer.CMColorChanged(var Msg : TMessage);
begin
  inherited;
  vwCalcColorFields;
end;

procedure TOvcBaseViewer.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  {$ENDIF}

  inherited;
end;

procedure TOvcBaseViewer.CMFontChanged(var Msg : TMessage);
begin
  inherited;

  if (csLoading in ComponentState) then
    Exit;

  if not HandleAllocated then
    Exit;

  vwCalcFontFields;
end;

procedure TOvcBaseViewer.ClearMarker(N : Byte);
  {-remove the specified text marker}
begin
  if N < MaxMarkers then begin
    if (FMarkers[N].Line <> -1) then
      vwInvalidateLine(FMarkers[N].Line);
    FMarkers[N].Line := -1;
    FMarkers[N].Col := -1;
  end;
end;

procedure TOvcBaseViewer.CopyToClipboard;
const
  CRLF : array[1..2] of Char = ^M^J;
var
  Size      : LongInt;
  MemHandle : THandle;
  S, Buf    : PAnsiChar;
  LineNum   : LongInt;
  Col       : integer;
  ActLen    : integer;
begin
  {nothing to do if there is no selected text}
  if RangeIsEmpty(vwHighlight) then
    Exit;

  {calculate size of highlighted section}
  LineNum := vwHighlight.Start.Line;
  Col := vwHighlight.Start.Col;
  Size := 0;
  while (LineNum < vwHighlight.Stop.Line) do begin
    GetLinePtr(LineNum, ActLen);
    inc(Size, ActLen - Col + sizeof(CRLF));
    inc(LineNum);
    Col := 0;
  end;
  inc(Size, vwHighlight.Stop.Col - Col);

  {raise an exception if too large}
  if (Size > $FFF0) then
    raise ERegionTooLarge.Create;

  {allocate a global memory block, raise exception if cannot}
  MemHandle := GlobalAlloc(GHND, Size+1);
  if (MemHandle = 0) then
    raise EOutOfMemory.Create(GetOrphStr(SCOutOfMemoryForCopy));

  {copy selected text to global memory block}
  try {except}
    try {finally}
      Buf := GlobalLock(MemHandle);
      LineNum := vwHighlight.Start.Line;
      Col := vwHighlight.Start.Col;
      while (LineNum < vwHighlight.Stop.Line) do begin
        S := GetLinePtr(LineNum, ActLen);
        Move(S[Col], Buf^, ActLen - Col);
        inc(Buf, ActLen - Col);
        Move(CRLF, Buf^, sizeof(CRLF));
        inc(Buf, sizeof(CRLF));
        inc(LineNum);
        Col := 0;
      end;
      S := GetLinePtr(LineNum, ActLen);
      Move(S[Col], Buf^, vwHighlight.Stop.Col - Col);
      inc(Buf, vwHighlight.Stop.Col - Col);
      Buf^ := #0;
    finally
      GlobalUnlock(MemHandle);
    end;{try}
  except
    GlobalFree(MemHandle);
    raise;
  end;{try}

  {give the memory handle to the clipboard}
  if not OpenClipboard(Handle) then
    GlobalFree(MemHandle)
  else begin
    EmptyClipboard;
    SetClipboardData(CF_TEXT, MemHandle);
    CloseClipboard;
  end;
end;

constructor TOvcBaseViewer.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {set default values for persistent properties}
  FBorderStyle   := DefBorderStyle;
  FExpandTabs    := DefExpandTabs;
  FMarginColor   := DefMarginColor;
  FScrollBars    := DefScrollBars;
  FShowBookmarks := DefShowBookmarks;
  FShowCaret     := DefShowCaret;
  FTabSize       := DefTabSize;

  FFixedFont := TOvcFixedFont.Create;
  FFixedFont.OnChange := vwFixedFontChanged;

  FHighlightColors := TOvcColors.Create(DefHighlightText, DefHighlightBack);
  FHighlightColors.OnColorChange := vwHighlightColorsChanged;

  vwCaret := TOvcSingleCaret.Create(Self);

  Color       := DefColor;
  Height      := DefHeight;
  ParentColor := False;
  TabStop     := DefTabStop;
  Width       := DefWidth;

  {$IFDEF Win32}
  if NewStyleControls then
    ControlStyle := [csDoubleClicks, csClickEvents, csCaptureMouse, csOpaque]
  else
    ControlStyle := [csDoubleClicks, csClickEvents, csCaptureMouse, csOpaque, csFramed];
  {$ELSE}
    ControlStyle := [csDoubleClicks, csClickEvents, csCaptureMouse, csOpaque, csFramed];
  {$ENDIF}

  vwInitInternalFields;
end;

procedure TOvcBaseViewer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do
    Style := LongInt(Style) or ScrollBarStyles[FScrollBars]            {!!.D4}
                   or BorderStyles[FBorderStyle];

  {$IFDEF Win32}
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  {$ENDIF}
end;

procedure TOvcBaseViewer.CreateWnd;
begin
  inherited CreateWnd;

  vwCalcFontFields;
  vwCalcColorFields;

  if FShowBookmarks then
    vwReadBookmarkGlyphs;
end;

destructor TOvcBaseViewer.Destroy;
begin
  if (vwLineSelCursor <> 0) then
    DestroyCursor(vwLineSelCursor);

  {destroy the glyphs object}
  vwBMGlyphs.Free;
  vwBMGlyphs := nil;

  {destroy the highlight colors object}
  FHighlightColors.Free;
  FHighlightColors := nil;

  {destroy the fixed font object}
  FFixedFont.Free;
  FFixedFont := nil;

  {destroy the caret object}
  vwCaret.Free;
  vwCaret := nil;

  inherited Destroy;
end;

procedure TOvcBaseViewer.DoOnShowStatus(LineNum : LongInt; ColNum : integer);
begin
  if Assigned(FOnShowStatus) then
    FOnShowStatus(Self, LineNum, ColNum);
end;

procedure TOvcBaseViewer.DoOnTopLineChanged(Line : LongInt);
  {-perform notification of a top line changed}
begin
  if Assigned(FOnTopLineChanged) then
    FOnTopLineChanged(Self, Line);
end;

procedure TOvcBaseViewer.DoOnUserCommand(Command : Word);
  {-perform notification of a user command}
begin
  if Assigned(FOnUserCommand) then
    FOnUserCommand(Self, Command);
end;

function TOvcBaseViewer.EffectiveColumn(Line : LongInt; ActualCol : integer) : integer;
  {-return the effective column given the line and actual column}
var
  P : PAnsiChar;
  L : integer;
begin
  if ExpandTabs and (ActualCol >= 0) then begin
    P := GetLinePtr(Line, L);
    Result := CalcEffCol(P, ActualCol, TabSize);
  end else
    Result := ActualCol;
end;

function TOvcBaseViewer.GetCaretPosition(var Col : integer) : LongInt;
  {-return the current position of the caret}
begin
  Col := FCaretPos.Col;
  Result := FCaretPos.Line;
end;

function TOvcBaseViewer.GetCaretType : TOvcCaret;
begin
  Result := vwCaret.CaretType;
end;

function TOvcBaseViewer.GetCaretActualPos : TOvcTextPos;
begin
  Result := FCaretPos;
end;

function TOvcBaseViewer.GetCaretEffectivePos : TOvcTextPos;
begin
  Result.Line := FCaretPos.Line;
  Result.Col := FCaretEffCol;
end;

function TOvcBaseViewer.GetLine(LineNum : LongInt; Dest : PAnsiChar; DestLen : integer) : PAnsiChar;
  {-get the specified line}
begin
  Result := Dest;
  GetPrintableLine(LineNum, Dest, DestLen);
end;

function TOvcBaseViewer.GetLineLength(LineNum : LongInt) : integer;
begin
  GetLinePtr(LineNum, Result);
end;

function TOvcBaseViewer.GetMarkerPosition(N : Byte; var Col : integer) : LongInt;
  {-return the current position of the specified marker}
begin
  if {(0 <= N) and} (N < MaxMarkers) then begin                        {!!.D4}
    Col := FMarkers[N].Col;
    Result := FMarkers[N].Line;
  end else begin
    Col := -1;
    Result := -1;
  end;
end;

function TOvcBaseViewer.GetPrintableLine(LineNum : LongInt; Dest : PAnsiChar; DestLen : integer) : integer;
  {-get a line in a format suitable for printing}
var
  S, T : PAnsiChar;
  EffLen,
  ActLen : integer;
begin
  S := GetLinePtr(LineNum, ActLen);
  if (ActLen = 0) then begin
    Result := 0;
    Dest[0] := #0;
  end else begin
    if (not LineHasTabs(S, ActLen)) then
      StrLCopy(Dest, S, DestLen)
    else begin
      EffLen := CalcEffCol(S, ActLen, TabSize);
      if (EffLen <= DestLen) then
        DetabPChar(Dest, S, TabSize)
      else begin
        GetMem(T, EffLen+1);
        StrLCopy(Dest, DetabPChar(T, S, TabSize), DestLen);
        FreeMem(T, EffLen+1);
      end;
    end;
    MapUnknownChars(Dest, DestLen, vwFirstChar, vwLastChar, vwDefaultChar);
    Result := StrLen(Dest);
  end;
end;

function TOvcBaseViewer.GetStringLine(LineNum : LongInt) : string;
  {-return the text for the specified line}
var
  Buf : array[0..255] of Char;
begin
  GetPrintableLine(LineNum, Buf, 256);
  Result := StrPas(Buf);
end;

function TOvcBaseViewer.GetSelection(var Line1 : LongInt; var Col1 : integer;
         var Line2 : LongInt; var Col2 : integer) : Boolean;
  {-return True if any text is currently selected}
begin
  Line1 := vwHighlight.Start.Line;
  Col1  := vwHighlight.Start.Col;
  Line2 := vwHighlight.Stop.Line;
  Col2  := vwHighlight.Stop.Col;
  Result := not RangeIsEmpty(vwHighlight);
end;

function TOvcBaseViewer.GetTopLine : LongInt;
begin
  Result := FTopLine;
end;

procedure TOvcBaseViewer.GotoMarker(N : Byte);
begin
  if {(0 <= N) and} (N < MaxMarkers) then                              {!!.D4}
    if (FMarkers[N].Line >= 0) and (FMarkers[N].Col >= 0) then
      vwMoveCaretTo(FMarkers[N].Line, FMarkers[N].Col, False);
end;

procedure TOvcBaseViewer.OMShowStatus(var Msg : TOMShowStatus);
begin
  DoOnShowStatus(Msg.Line, Msg.Column);
end;

procedure TOvcBaseViewer.Paint;
var
  ClipBox,
  CurBox      : TRect;
  FarRight    : integer;
  StartOfS    : PAnsiChar;
  NoHighlight : Boolean;
  FirstRow,
  LastRow     : integer;
  Row         : integer;
  IncludePartRow : Boolean;

  procedure DrawMarginRow(LineNum : LongInt; Row : integer);
  var
    RowStartPixel   : integer;
    HasMarkerNumber : integer;
    I               : integer;
    DestRect,
    SourceRect      : TRect;
  begin
    HasMarkerNumber := -1;
    if ShowBookmarks and (LineNum <> -1) then
      for I := MaxMarkers-1 downto 0 do
        if (FMarkers[I].Line = LineNum) then
          HasMarkerNumber := I;

    with Canvas do begin
      RowStartPixel := Row * vwRowHt;
      FillRect(Rect(0, RowStartPixel, LeftMargin, RowStartPixel+vwRowHt));

      if ShowBookmarks and (HasMarkerNumber <> -1) then begin
        if (vwRowHt >= BookmarkHeight+2) then
          RowStartPixel :=
             RowStartPixel + ((vwRowHt-BookmarkHeight) div 2);
        DestRect := Rect((LeftMargin - BookmarkWidth) div 2,
                         RowStartPixel,
                         ((LeftMargin + BookmarkWidth) div 2),
                         RowStartPixel + BookmarkHeight);
        SourceRect := Rect(HasMarkerNumber*BookmarkWidth,
                           0,
                           Succ(HasMarkerNumber)*BookmarkWidth ,
                           BookmarkHeight);
        CopyRect(DestRect, vwBMGlyphs.Canvas, SourceRect);
      end;
    end;
  end;

  procedure DrawAt(Row : integer; S : PAnsiChar; Len : integer);
    {-Draw S at Row}
  begin
    {get bounding rectangle}
    CurBox.Top := Row * vwRowHt;
    CurBox.Bottom := CurBox.Top + vwRowHt;
    if (CurBox.Bottom > ClipBox.Bottom) then
      CurBox.Bottom := ClipBox.Bottom;

    {draw the string}
    Canvas.FillRect(CurBox);
    if (Len > 0) then
      ExtTextOut(Canvas.Handle,
                 CurBox.Left, CurBox.Top+1,
                 eto_Clipped, @CurBox, S, Len, nil);
  end;

  procedure DrawComplexRow(S : PAnsiChar; Len : integer;
                           Row : integer; N : LongInt);
      {-Draw a row that has highlighting}
  var
    Len1, Len2, Len3 : integer;
    EffSelEnd        : integer;
  begin
    Len1 := 0;
    Len2 := 0;
    Len3 := 0;

    {is entire line in normal color?}
    if NoHighlight or
       (N < vwHighlight.Start.Line) or
       (N > vwHighlight.Stop.Line) then
      Len3 := Len
    {is line in middle of highlighted region?}
    else if (N > vwHighlight.Start.Line) and
            (N < vwHighlight.Stop.Line) then begin
      Len2 := Len;
      Len3 := vwCols-Len;
    end else if (N = vwHighlight.Start.Line) then {is this the first highlighted line?}
      {is this the only highlighted line?}
      if (N = vwHighlight.Stop.Line) then begin
        if ExpandTabs then begin
          Len1 :=
             MaxI(0,
                  CalcEffCol(StartOfS, vwHighlight.Start.Col, FTabSize) -
                     vwHDelta);
          Len2 := CalcEffCol(StartOfS, vwHighlight.Stop.Col, FTabSize) -
                     (vwHDelta + Len1);
        end else begin
          Len1 := MaxI(0, vwHighlight.Start.Col - vwHDelta);
          Len2 := vwHighlight.Stop.Col - (vwHDelta + Len1);
        end;
        if Len1+Len2 > Len then
          Len2 := Len-Len1;
        Len3 := vwCols-(Len1+Len2);
      end else begin {there are other highlighted lines}
        if ExpandTabs then
          Len1 := MaxI(0, CalcEffCol(StartOfS, vwHighlight.Start.Col, FTabSize) -
                     vwHDelta)
        else
          Len1 := MaxI(0, vwHighlight.Start.Col - vwHDelta);
        Len2 := Len-Len1;
        Len3 := vwCols-(Len1+Len2);
      end
    else begin {it's the last line}
      if ExpandTabs then
        EffSelEnd := CalcEffCol(StartOfS, vwHighlight.Stop.Col, FTabSize)
      else
        EffSelEnd := vwHighlight.Stop.Col;
      {is highlighted portion invisible?}
      if (vwHDelta > EffSelEnd) then
        Len1 := Len
      else begin {no there's some highlighted portion}
        Len2 := EffSelEnd - vwHDelta;
        if Len2 > Len then
          Len2 := Len;
        Len3 := vwCols-Len2;
      end;
    end;

    {draw first unhighlighted portion of line}
    if (Len1 > 0) then begin
      if (Len1 <> Len) then
        CurBox.Right := CurBox.Left+(Len1*vwColWid);
      DrawAt(Row, S, Len1);
      Inc(S, Len1);
      CurBox.Left := CurBox.Right;
      CurBox.Right := FarRight;
    end;

    {draw highlighted portion of line}
    if (Len2 > 0) then begin
      Len2 := MinI(Len2, StrLen(S));

      if Len3 > 0 then
        CurBox.Right := CurBox.Left+(Len2*vwColWid);

      Canvas.Brush.Color := HighlightColors.BackColor;
      Canvas.Font.Color := HighlightColors.TextColor;
      SetBkMode(Canvas.Handle, TRANSPARENT);

      DrawAt(Row, S, Len2);

      Canvas.Brush.Color := Color;
      Canvas.Font.Color := FixedFont.Font.Color;
      SetBkMode(Canvas.Handle, TRANSPARENT);

      Inc(S, Len2);
      CurBox.Left := CurBox.Right;
      CurBox.Right := FarRight;
    end;

    {draw last unhighlighted portion of line}
    if (Len3 > 0) then
      DrawAt(Row, S, MinI(Len3, StrLen(S)));
  end;

  procedure DrawRow(LineNum : LongInt; Row : integer);
      {-Draw line N on the specified Row of the window}
  var
    S, T   : PAnsiChar;
    EffLen : integer;
    Len    : integer;
    HasTabs: Boolean;
  begin
    {draw unused right margin}
    if (ClipBox.Right > FarRight) then begin
      CurBox.Left := FarRight;
      CurBox.Right := ClientWidth;
      DrawAt(Row, '', 0);
    end;

    {reset CurBox}
    CurBox.Left := LeftMargin;
    CurBox.Right := FarRight;

    {get the string}
    CheckLine(LineNum);
    if (LineNum >= FLineCount) or (LineNum < 0) then
      DrawAt(Row, '', 0)
    else begin
      S := GetLinePtr(LineNum, Len);
      StartOfS := S;
      HasTabs := LineHasTabs(S, Len);
      if HasTabs and (Len > 0) and ExpandTabs then begin
        EffLen := CalcEffCol(S, Len, FTabSize);
        T := StrAlloc(EffLen+1);
        S := DetabPChar(T, S, FTabSize);
        MapUnknownChars(S, EffLen, vwFirstChar, vwLastChar, vwDefaultChar);
        Len := EffLen;
      end else begin
        T := StrNew(S);
        MapUnknownChars(T, Len, vwFirstChar, vwLastChar, vwDefaultChar);
        S := T;
      end;
      if (vwHDelta >= Len) then
        Len := 0
      else begin
        S := @S[vwHDelta];
        Len := MinI(Len-vwHDelta, vwCols);
      end;
      if (Len = 0) then
           DrawAt(Row, '', Len)
      else
        DrawComplexRow(S, Len, Row, LineNum);
      if (T <> nil) then
        StrDispose(T);
    end;
  end;

begin
  {get the bounding rectangle of the unpainted area}
  GetClipBox(Canvas.Handle, ClipBox);
  FarRight := LeftMargin + (vwCols * vwColWid);

  {figure out which rows to paint}
  FirstRow := (ClipBox.Top div vwRowHt);
  LastRow :=  ((ClipBox.Bottom + Pred(vwRowHt)) div vwRowHt);
  if LastRow > Pred(vwRows) then begin
    IncludePartRow := True;
    LastRow := Pred(vwRows);
  end else
    IncludePartRow := False;

  {paint the margin area if required}
  if (ClipBox.Left < LeftMargin) then begin
    Canvas.Brush.Color := MarginColor;
    for Row := FirstRow to LastRow do
      DrawMarginRow(FTopLine+Row, Row);
    if IncludePartRow then
      DrawMarginRow(-1, vwRows);
  end;

  {display the text}
  Canvas.Brush.Color := Color;
  Canvas.Font := FixedFont.Font;
  SetBkMode(Canvas.Handle, TRANSPARENT);

  NoHighlight := RangeIsEmpty(vwHighlight);
  for Row := FirstRow to LastRow do
    DrawRow(FTopLine+Row, Row);

  if IncludePartRow then begin
    CurBox.Left := MaxI(ClipBox.Left, LeftMargin);
    CurBox.Right := ClipBox.Right;
    DrawAt(vwRows, '', 0);
  end;

  vwPositionCaret;
end;

function TOvcBaseViewer.Search(const S : string; Options : TSearchOptionSet) : Boolean;
  {-search for a string returning True if found}
type
  TSearchFunc = function(var Buffer; BufLength : Cardinal;
                         var BT : BTable;
                         Match : PAnsiChar;
                         var Pos : Cardinal) : Boolean;

var
  P          : PAnsiChar;
  MatchString: PAnsiChar;
  PatternLen : integer;
  SearchFunc : TSearchFunc;
  BT         : BTable;
  MatchCol   : Integer;
  SearchPos  : TOvcTextPos;
  SearchLen  : integer;
  ActLen     : integer;
  Pattern    : array[0..255] of Char;

  function FindLastInstance(First, Last : integer) : integer;
      {-Find the last instance of the search string between columns First
        and Last in the current line}
  var
    SearchLen : Integer;
    MatchCol  : Integer;
  begin
    Result := First;
    Inc(First);
    SearchLen := Last - First;
    while (SearchLen >= PatternLen) do begin
      {MatchCol := SearchFunc(P[First], SearchLen, BT, MatchString);}
      {if (MatchCol = SearchFailed) then}
      if not SearchFunc(P[First], SearchLen, BT,
                        MatchString, Cardinal(MatchCol)) then
        Exit;

      inc(Result, Succ(MatchCol));
      inc(First, Succ(MatchCol));
      SearchLen := Last - First;
    end;
  end;

  function MoveToNextLine(var S : PAnsiChar;
                          var SearchPos : TOvcTextPos;
                          var ActLen : integer) : Boolean;
  var
    NewLine : LongInt;
  begin
    Result := True;
    with SearchPos do begin
       NewLine := CheckLine(Line+1);
       if (NewLine <> Line) then begin
         Line := NewLine;
         S := GetLinePtr(Line, ActLen);
         Col := 0;
       end else
         Result := False;
    end;
  end;

  function MoveToPrevLine(var S : PAnsiChar;
                          var SearchPos : TOvcTextPos;
                          var ActLen : integer) : Boolean;
  begin
    with SearchPos do
      if (Line > 0) then begin
        Result := True;
        dec(Line);
        S := GetLinePtr(Line, ActLen);
        Col := ActLen;
      end else
        Result := False;
  end;

begin
  {assume it won't be not found}
  Result := False;

  {get copy of search string}
  StrPCopy(Pattern, S);

  {get the pattern length}
  PatternLen := StrLen(Pattern);
  if (PatternLen = 0) then
    Exit;

  {get local buffer and copy the pattern to it}
  MatchString := StrNew(Pattern);
  {show the hourglass cursor}
  vwShowWaitCursor(True);

  try {finally}
    {get start position of search}
    if soGlobal in Options then begin
      if soBackward in Options then begin
        {if global+backward, we'll start at the end of the file}
        SearchPos.Line := CheckLine(Pred(FLineCount));
        P := GetLinePtr(SearchPos.Line, ActLen);
        SearchPos.Col := ActLen;
      end else begin
        {if global+forward, we'll start at the top of the file}
        SearchPos.Line := 0;
        SearchPos.Col := 0;
        P := GetLinePtr(0, ActLen);
      end
    end else begin
      {if not global, we'll start from the caret position}
      SearchPos := FCaretPos;
      P := GetLinePtr(FCaretPos.Line, ActLen);
    end;

    {identify which search we'll do: case-sensitive or not}
    if soMatchCase in Options then
      SearchFunc := BMSearch
    else begin
      AnsiUpper(MatchString);
      SearchFunc := BMSearchUC;
    end;
    {make the Bayer-Moore table}
    BMMakeTable(MatchString, BT);

    if soBackward in Options then
      repeat
        if (ActLen <> 0) and (SearchPos.Col >= PatternLen) then begin
          {look for a match on this line}
          {MatchCol := SearchFunc(P[0], SearchPos.Col, BT,
                                  MatchString);}
          {if (MatchCol <> SearchFailed) then begin}
          if SearchFunc(P[0], SearchPos.Col, BT,
                        MatchString, Cardinal(MatchCol)) then begin
            Result := True;
            {find the last instance of the string prior to the caret}
            SearchPos.Col := FindLastInstance(MatchCol, SearchPos.Col);
            {highlight the string}
            SetSelection(SearchPos.Line, SearchPos.Col, SearchPos.Line, SearchPos.Col+PatternLen, False);
          end;
        end;
      until Result or (not MoveToPrevLine(P, SearchPos, ActLen))
    else
      repeat
        {calc the number of chars to search}
        SearchLen := ActLen - SearchPos.Col;
        {check whether the line is long enough}
        if SearchLen >= PatternLen then begin
          {look for a match on this line starting at SearchPos.Col}
          {MatchCol := SearchFunc(P[SearchPos.Col], SearchLen, BT,
                                  MatchString);}
          {if (MatchCol <> SearchFailed) then begin}
          if SearchFunc(P[SearchPos.Col], SearchLen, BT,
                        MatchString, Cardinal(MatchCol)) then begin
            Result := True;
            {highlight string}
            Inc(SearchPos.Col, MatchCol);
            SetSelection(SearchPos.Line, SearchPos.Col, SearchPos.Line, SearchPos.Col+PatternLen, True);
          end;
        end;
      until Result or (not MoveToNextLine(P, SearchPos, ActLen));
  finally
    vwShowWaitCursor(False);
    StrDispose(MatchString);
  end;{try}
end;

procedure TOvcBaseViewer.SelectAll(CaretAtEnd : Boolean);
  {-select all text in the viewer}
begin
  if LineCount = -1 then
    Exit;

  SetSelection(0, 0, Pred(LineCount), 0, CaretAtEnd);
end;

procedure TOvcBaseViewer.SetBorderStyle(BS : TBorderStyle);
begin
  if (BS <> BorderStyle) then begin
    FBorderStyle := BS;
    RecreateWnd;
  end;
end;

procedure TOvcBaseViewer.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  VS : Boolean;                                                        {!!.16}
begin
  if HandleAllocated then begin
    AHeight := MaxI(AHeight, vwRowHt + (Height-ClientHeight));
    AWidth := MaxI(AWidth, vwColWid + (Width-ClientWidth));
  end;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  VS := FLineCount > vwRows;                                           {!!.16}

  vwCalcFontFields;

  if VS then                                                           {!!.16}
    if FLineCount <= vwRows then                                       {!!.16}
      TopLine := 0;                                                    {!!.16}
end;

procedure TOvcBaseViewer.SetCaretPosition(Line : LongInt; Col : integer);
  {-move the caret to a specified line and column}
begin
  vwMoveCaretTo(Line, Col, False);
end;

procedure TOvcBaseViewer.SetCaretType(CT : TOvcCaret);
begin
  if (CT <> vwCaret.CaretType) then
    vwCaret.CaretType := CT;
end;

procedure TOvcBaseViewer.SetMarginColor(C : TColor);
begin
  if (C <> FMarginColor) then begin
    FMarginColor := C;
    Invalidate;
  end;
end;

procedure TOvcBaseViewer.SetCaretActualPos(LC : TOvcTextPos);
var
  ActLC : TOvcTextPos;
begin
  if (LineCount <> 0) then begin
    ActLC.Line := CheckLine(LC.Line);
    ActLC.Col := LC.Col;
    vwMoveCaretTo(ActLC.Line, ActLC.Col, False);
  end;
end;

procedure TOvcBaseViewer.SetCaretEffectivePos(LC : TOvcTextPos);
var
  ActLC : TOvcTextPos;
  Len   : integer;
begin
  if (LineCount <> 0) then begin
    ActLC.Line := CheckLine(LC.Line);
    ActLC.Col := CalcActCol(GetLinePtr(LC.Line, Len), LC.Col, TabSize);
    vwMoveCaretTo(ActLC.Line, ActLC.Col, False);
  end;
end;

procedure TOvcBaseViewer.SetExpandTabs(E : Boolean);
begin
  if (E <> ExpandTabs) then begin
    FExpandTabs := E;
    Invalidate;
  end;
end;

procedure TOvcBaseViewer.SetFixedFont(FF : TOvcFixedFont);
begin
  FFixedFont.Assign(FF);
end;

procedure TOvcBaseViewer.SetLineCount(N : LongInt);
var
 I : integer;
 NewPos : TOvcTextPos;
begin
  if (N <> FLineCount) then begin
    FLineCount := N;
    if csLoading in ComponentState then
      Exit;

    NewPos.Line := 0;
    NewPos.Col := 0;
    CaretActualPos := NewPos;
    vwResetHighlight(False);
    vwHDelta := 0;
    FMarkers[0].Line := -1;
    FMarkers[0].Col := -1;
    for i := 1 to MaxMarkers-1 do
      FMarkers[I] := FMarkers[0];
    vwSetVScrollRange;
    vwSetVScrollPos;
    vwSetHScrollRange;
    vwSetHScrollPos;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TOvcBaseViewer.SetMarker(N : Byte);
  {-set a text marker at the current caret position}
begin
  SetMarkerAt(N, FCaretPos.Line, FCaretPos.Col);
end;

procedure TOvcBaseViewer.SetMarkerAt(N : Byte; Line : LongInt; Col : integer);
  {-set a text marker at the specified position}
begin
  if {(0 <= N) and} (N < MaxMarkers) then begin                        {!!.D4}
    if (FMarkers[N].Line <> -1) then
      vwInvalidateLine(FMarkers[N].Line);
    if (FMarkers[N].Line = Line) and (FMarkers[N].Col = Col) then begin
      FMarkers[N].Line := -1;
      FMarkers[N].Col := -1;
    end else begin
      if (FMarkers[N].Line <> Line) then
        vwInvalidateLine(Line);
      FMarkers[N].Line := Line;
      FMarkers[N].Col := Col;
    end;
  end;
end;

procedure TOvcBaseViewer.SetScrollBars(SB : TScrollStyle);
begin
  if (SB <> ScrollBars) then begin
    FScrollBars := SB;
    vwVScroll := FScrollBars in [ssVertical, ssBoth];
    vwHScroll := FScrollBars in [ssHorizontal, ssBoth];
    RecreateWnd;
  end;
end;

procedure TOvcBaseViewer.SetSelection(Line1 : LongInt; Col1 : integer;
          Line2 : LongInt; Col2 : integer; CaretAtEnd : Boolean);
  {-select a region of text}
var
  NewPos : TOvcTextPos;
begin
  vwResetHighlight(True);
  if (LineCount <> 0) then
    if CaretAtEnd then begin
      NewPos.Line := CheckLine(Line1);
      NewPos.Col := Col1;
      if (not PosEqual(NewPos, vwHighlight.Start)) and
         (not PosEqual(NewPos, vwAnchor)) then
        begin
          FCaretPos := NewPos;
          vwResetHighlight(True);
        end;
      vwMoveCaretTo(Line2, Col2, True);
    end else begin
      NewPos.Line := CheckLine(Line2);
      NewPos.Col := Col2;
      if (not PosEqual(NewPos, vwHighlight.Stop)) and
         (not PosEqual(NewPos, vwAnchor)) then begin
        FCaretPos := NewPos;
        vwResetHighlight(True);
      end;
      vwMoveCaretTo(Line1, Col1, True);
    end;
end;

procedure TOvcBaseViewer.SetShowBookmarks(SB : Boolean);
begin
  if (SB <> FShowBookmarks) then begin
    FShowBookmarks := SB;
    if FShowBookmarks then
      vwReadBookmarkGlyphs
    else begin
      vwBMGlyphs.Free;
      vwBMGlyphs := nil;
    end;
    Invalidate;
  end;
end;

procedure TOvcBaseViewer.SetShowCaret(Value : Boolean);
begin
  if Value <> FShowCaret then begin
    FShowCaret := Value;
    if Focused and not (csDesigning in ComponentState) then
      vwCaret.Visible := FShowCaret;
  end;
end;

procedure TOvcBaseViewer.SetTabSize(N : Byte);
begin
  if (N <> 0) and (N <> TabSize) then begin
    FTabSize := N;
    if ExpandTabs then
      Invalidate;
  end;
end;

procedure TOvcBaseViewer.SetTopLine(LineNum : LongInt);
begin
  if (LineNum >= 0) and (LineNum <> FTopLine) then
    vwScrollPrim(0, LineNum-FTopLine);
end;

procedure TOvcBaseViewer.vwCalcColorFields;
begin
  if not HandleAllocated then
    Exit;

  vwDitheredBG :=
     (TColorRef(Color) <> GetNearestColor(Canvas.Handle, Color)) or    {!!.D4}
     (TColorRef(HighlightColors.BackColor) <>                          {!!.D4}
         GetNearestColor(Canvas.Handle, HighlightColors.BackColor));
end;

procedure TOvcBaseViewer.vwCalcFontFields;
var
  TM : TTextMetric;
  S  : string;
begin
  if not HandleAllocated then
    Exit;

  with Canvas do
    begin
      Font := FixedFont.Font;
      vwRowHt := MaxI(TextHeight(GetOrphStr(SCTallLowChars))+2, BookMarkHeight);
      S := GetOrphStr(SCAlphaString);
      vwColWid := TextWidth(S) div Length(S);

      vwRows := MaxI(ClientHeight div vwRowHt, 1);
      vwCols := MaxI((ClientWidth - LeftMargin) div vwColWid, 1);

      GetTextMetrics(Canvas.Handle, TM);
      with TM do begin
        vwFirstChar := Char(tmFirstChar);
        vwLastChar := Char(tmLastChar);
        vwDefaultChar := Char(tmDefaultChar);
      end;

      vwSetVScrollRange;
      vwSetVScrollPos;
    end;

  {set the caret cell size based on the font}
  vwCaret.CellHeight := vwRowHt;
  vwCaret.CellWidth := vwColWid;
end;

function TOvcBaseViewer.vwCaretIsVisible : Boolean;
begin
  Result :=
     (FTopLine <= FCaretPos.Line) and (FCaretPos.Line < FTopLine+vwRows) and
     (vwHDelta <= FCaretEffCol) and (FCaretEffCol < vwHDelta+vwCols);
end;

procedure TOvcBaseViewer.vwChangeLineCount(N : LongInt);
begin
  if (N <> FLineCount) then begin
    FLineCount := N;
    vwSetVScrollRange;
    vwSetVScrollPos;
  end;
end;

procedure TOvcBaseViewer.vwFixedFontChanged(Sender : TObject);
begin
  Perform(CM_FONTCHANGED, 0, 0);
end;

function TOvcBaseViewer.vwGetLineEffLen(N : LongInt) : integer;
var
  S : PAnsiChar;
begin
  S := GetLinePtr(N, Result);
  if ExpandTabs then
    Result := CalcEffCol(S, Result, TabSize);
end;

procedure TOvcBaseViewer.vwGetMousePos(var MousePos : TOvcTextPos; XPixel, YPixel : integer);
var
  S      : PAnsiChar;
  ActLen : integer;
  EffCol : integer;
begin
  with MousePos do begin
    if (XPixel < LeftMargin) then
      EffCol := MaxI(0, Pred(vwHDelta))
    else if XPixel > (LeftMargin + vwCols*vwColWid) then
      EffCol := vwHDelta + vwCols
    else
      EffCol := ((XPixel-LeftMargin) div vwColWid) + vwHDelta;

    if (YPixel < 0) then
      Line := MaxL(0, Pred(FTopLine))
    else if YPixel > (vwRows*vwRowHt) then
      Line := MinL(FTopLine + vwRows, Pred(FLineCount))
    else
      Line := MinL((YPixel div vwRowHt) + FTopLine, Pred(FLineCount));

    if ExpandTabs then begin
      S := GetLinePtr(Line, ActLen);
      Col := CalcActCol(S, EffCol, FTabSize);
    end else
      Col := EffCol;
  end;
end;

procedure TOvcBaseViewer.vwHighlightColorsChanged(Sender : TObject);
begin
  if not RangeIsEmpty(vwHighlight) then
    Invalidate;
end;

procedure TOvcBaseViewer.vwInitInternalFields;
var
  i : integer;
begin
  {initialize property fields that are not stored on a stream}
  FMarkers[0].Line := -1;
  FMarkers[0].Col := -1;
  for i := 1 to MaxMarkers-1 do
    FMarkers[i] := FMarkers[0];

  vwVScroll := FScrollBars in [ssVertical, ssBoth];
  vwHScroll := FScrollBars in [ssHorizontal, ssBoth];
  vwHSHigh := HScrollMax;
  vwLineSelCursor := LoadCursor(hInstance, PAnsiChar(crLineCursor));
  vwRowHt := 12;    {just to help out until we get the True values}
  vwColWid := 12;

  vwResetHighlight(False);

  {Note: the other fields depend on having a handle and are set by
         vwCalcFontFields and vwCalcColorFields once the window handle
         exists - see CreateWnd.}
end;

procedure TOvcBaseViewer.vwInvalidateLine(LineNum : LongInt);
var
  StartPixel : integer;
  InvRect    : TRect;
begin
  if (FTopLine <= LineNum) and (LineNum < FTopLine+vwRows) then begin
    StartPixel := (LineNum - FTopLine) * vwRowHt;
    InvRect := Rect(0, StartPixel, ClientWidth, StartPixel + vwRowHt);
    InvalidateRect(Handle, @InvRect, False);
  end;
end;

procedure TOvcBaseViewer.vwMoveCaretPrim(HDelta : integer; VDelta : LongInt;
                                   MoveByPage, AmSelecting, AbsMove : Boolean);
var
  SaveCurPos : TOvcTextPos;
  SaveHorzOfs: integer;
  NewTop     : LongInt;
  NewHorzOfs : integer;
  CurRow     : integer;
  S          : PAnsiChar;
  CurLen     : integer;
begin
  if (LineCount = 0) then
    Exit;

  if (FTopLine <= FCaretPos.Line) and (FCaretPos.Line < FTopLine+vwRows) then
    CurRow := FCaretPos.Line-FTopLine
  else begin
    CurRow := -1;
    MoveByPage := False;
  end;
  SaveCurPos := FCaretPos;
  SaveHorzOfs := vwHDelta;

  {adjust current line}
  Inc(FCaretPos.Line, VDelta);
  if (FCaretPos.Line < 0) then
    if (VDelta < 0) then
      FCaretPos.Line := 0
    else
      FCaretPos.Line := MaxLongInt
  else if (FCaretPos.Line >= FLineCount) then begin
    FCaretPos.Line := Pred(FLineCount);
    if (SaveCurPos.Line = Pred(FLineCount)) and (HDelta = 0) then
      Exit;
  end;

  FCaretPos.Line := CheckLine(FCaretPos.Line);
  S := GetLinePtr(FCaretPos.Line, CurLen);
  if ExpandTabs and (FCaretPos.Line <> SaveCurPos.Line) and (not AbsMove) then
    FCaretPos.Col := CalcActCol(S, FCaretEffCol, FTabSize);

  {adjust current column, actual and effective}
  Inc(FCaretPos.Col, HDelta);
  if (FCaretPos.Col < 0) then
    FCaretPos.Col := 0
  else if (FCaretPos.Col > CurLen) then
    FCaretPos.Col := CurLen;
  FCaretEffCol := CalcEffCol(S, FCaretPos.Col, FTabSize);

  if MoveByPage or (not vwCaretIsVisible) then begin
    {scroll vertically as necessary}
    if MoveByPage then
      NewTop := FCaretPos.Line-CurRow
    else if (FCaretPos.Line < FTopLine) then
      NewTop := FCaretPos.Line
    else if (FCaretPos.Line >= FTopLine+vwRows) then
      NewTop := FCaretPos.Line-Pred(vwRows)
    else
      NewTop := FTopLine;

    if (NewTop < 0) then
      NewTop := 0
    else if (FCaretPos.Line >= NewTop+vwRows) then
      NewTop := FCaretPos.Line-Pred(vwRows);

    {scroll horizontally as necessary}
    NewHorzOfs := vwHDelta;
    if (FCaretEffCol < vwHDelta) then
      NewHorzOfs := 0;
    if (FCaretEffCol >= vwHDelta+vwCols) then
      NewHorzOfs := FCaretEffCol-Pred(vwCols);

    {do the scroll}
    vwScrollPrim(NewHorzOfs-vwHDelta, NewTop-FTopLine);
  end;

  if PosEqual(SaveCurPos, FCaretPos) and
     (SaveHorzOfs = vwHDelta) and
     (AmSelecting = not RangeIsEmpty(vwHighlight)) then
    Exit;

  {reposition caret}
  if AmSelecting then
    vwUpdateHighlight(True)
  else
    vwResetHighlight(True);
  vwPositionCaret;
end;

procedure TOvcBaseViewer.vwMoveCaret(HDelta : integer; VDelta : LongInt;
                               MoveByPage, AmSelecting : Boolean);
begin
  vwMoveCaretPrim(HDelta, VDelta, MoveByPage, AmSelecting, False);
end;

procedure TOvcBaseViewer.vwMoveCaretTo(Line : LongInt; Col : integer; AmSelecting : Boolean);
begin
  vwMoveCaretPrim(Col-FCaretPos.Col, Line-FCaretPos.Line, False, AmSelecting, True);
end;

procedure TOvcBaseViewer.vwPositionCaret;
var
  NewPos : TPoint;
  Len : integer;
begin
  FCaretEffCol := FCaretPos.Col;
  if ExpandTabs then
    FCaretEffCol := CalcEffCol(GetLinePtr(FCaretPos.Line, Len),
                             FCaretEffCol, FTabSize);

  if vwCaretIsVisible then begin
    NewPos.X := LeftMargin + (FCaretEffCol-vwHDelta)*vwColWid;
    NewPos.Y := (FCaretPos.Line-FTopLine)*vwRowHt;
  end else begin
    NewPos.X := High(integer);
    NewPos.Y := High(integer);
  end;

  vwCaret.Position := NewPos;

  PostMessage(Handle, om_ShowStatus, FCaretEffCol, FCaretPos.Line);
end;

procedure TOvcBaseViewer.vwReadBookmarkGlyphs;
begin
  if (csDesigning in ComponentState) then
    Exit;

  vwBMGlyphs.Free;

  vwBMGlyphs := TBitMap.Create;          
  vwBMGlyphs.Handle := LoadOvcBaseBitMap('MARKERS');
end;

procedure TOvcBaseViewer.vwRefreshLines(const Start, Stop : TOvcTextPos);
var
  L : LongInt;
begin
  if (Start.Line <= Stop.Line) then
    for L := Start.Line to Stop.Line do
      vwInvalidateLine(L)
  else
    for L := Stop.Line to Start.Line do
      vwInvalidateLine(L);
end;

procedure TOvcBaseViewer.vwResetHighlight(Refresh : Boolean);
var
  SaveHlt : TOvcRange;
begin
  SaveHlt := vwHighlight;
  vwHighlight.Start := FCaretPos;
  vwHighlight.Stop := FCaretPos;
  vwAnchor := FCaretPos;
  if Refresh and (not RangeIsEmpty(SaveHlt)) then
    vwRefreshLines(SaveHlt.Start, SaveHlt.Stop);
end;

procedure TOvcBaseViewer.vwScrollPrim(HDelta : integer; VDelta : LongInt);
var
  SaveTop     : integer;
  SaveHorzOfs : integer;
  ScrollBoxWidth,
  ScrollBoxHeight,
  HD, VD      : integer;
  MarginBox,
  ScrollBox   : TRect;
begin
  SaveHorzOfs := vwHDelta;
  vwHDelta := MinI(MaxI(vwHDelta + HDelta, 0), vwHSHigh);

  SaveTop := FTopLine;
  FTopLine := MinL(MaxL(FTopLine + VDelta, 0), vwVSHigh);

  if (FTopLine = SaveTop) and (vwHDelta = SaveHorzOfs) then
    Exit;

  if (FTopLine <> SaveTop) then
    vwSetVScrollPos;

  if (vwHDelta <> SaveHorzOfs) then
    vwSetHScrollPos;

  if vwDitheredBG then
    Repaint
  else begin {the background is solid => we could scroll the window}
    ScrollBox := Rect(LeftMargin,
                      0,
                      LeftMargin + (vwCols * vwColWid),
                      vwRows * vwRowHt);
    ScrollBoxWidth := ScrollBox.Right-ScrollBox.Left;
    ScrollBoxHeight := ScrollBox.Bottom-ScrollBox.Top;

    HD := (SaveHorzOfs - vwHDelta) * vwColWid;
    VD := (SaveTop - FTopLine) * vwRowHt;

    if (Abs(HD) >= ScrollBoxWidth) or
       (Abs(VD) >= ScrollBoxHeight) or
       ((HD <> 0) and (VD <> 0)) then
      Repaint
    else begin
      {scroll the window}
      ScrollWindow(Handle, HD, VD, @ScrollBox, @ScrollBox);
      {scroll the margin only if we are scrolling vertically}
      if (VD <> 0) then
        begin
          MarginBox := Rect(0, 0, LeftMargin, vwRows * vwRowHt);
          ScrollWindow(Handle, 0, VD, @MarginBox, @MarginBox);
        end;
      {make sure display is updated}
      Update;
    end;
  end;

  {notify that the top line has changed}
  if (FTopLine <> SaveTop) then
    DoOnTopLineChanged(FTopLine);
end;

procedure TOvcBaseViewer.vwScrollPrimHorz(Delta : integer);
begin
  vwScrollPrim(Delta, 0);
end;

procedure TOvcBaseViewer.vwScrollPrimVert(Delta : LongInt);
begin
  vwScrollPrim(0, Delta);
end;

procedure TOvcBaseViewer.vwSetHScrollPos;
begin
  if vwHScroll and HandleAllocated then
    SetScrollPos(Handle, SB_HORZ, vwHDelta, True);
end;

procedure TOvcBaseViewer.vwSetHScrollRange;
begin
  if vwHScroll and HandleAllocated then
    if (FLineCount = 0) then
      if (csDesigning in ComponentState) then
        SetScrollRange(Handle, SB_HORZ, 0, 1, False)
      else
        SetScrollRange(Handle, SB_HORZ, 0, 0, False)
    else
      SetScrollRange(Handle, SB_HORZ, 0, vwHSHigh, False);
end;

procedure TOvcBaseViewer.vwSetVScrollPos;
begin
  if vwVScroll and HandleAllocated then
    SetScrollPos(Handle, SB_VERT, FTopLine div vwDivisor, True);
end;

procedure TOvcBaseViewer.vwSetVScrollRange;
begin
  vwVSHigh := FLineCount {-1} - vwRows {+1};
  if (vwVSHigh < 0) then
    vwVSHigh := 0;

  vwDivisor := Succ(vwVSHigh div $4000);
  vwVSMax := vwVSHigh div vwDivisor;

  if vwVScroll and HandleAllocated then
    if (csDesigning in ComponentState) and (vwVSMax = 0) then
      SetScrollRange(Handle, SB_VERT, 0, 1, False)
    else
      SetScrollRange(Handle, SB_VERT, 0, vwVSMax, False);
end;

procedure TOvcBaseViewer.vwShowWaitCursor(ShowIt : Boolean);
begin
  {exit if the window hasn't been created yet}
  if not HandleAllocated then
    Exit;

  if ShowIt then begin
    if not vwWaiting then begin
      vwSaveCursor := SetCursor(LoadCursor(0, IDC_WAIT));
      vwWaiting := True;
    end
  end else begin {not ShowIt}
    if vwWaiting then begin
      SetCursor(vwSaveCursor);
      vwWaiting := False;
    end;
  end;
end;

procedure TOvcBaseViewer.vwUpdateHighlight(Refresh : Boolean);
var
  SaveHlt : TOvcRange;
  SwapPos : TOvcTextPos;
begin
  SaveHlt := vwHighlight;

  if PosEqual(vwAnchor, vwHighlight.Start) then
    vwHighlight.Stop := FCaretPos
  else
    vwHighlight.Start := FCaretPos;

  if RangeIsBackwards(vwHighlight) then begin
    SwapPos := vwHighlight.Stop;
    vwHighlight.Stop := vwHighlight.Start;
    vwHighlight.Start := SwapPos;
  end;

  if Refresh and (not RangeEqual(SaveHlt, vwHighlight)) then begin
    if SaveHlt.Start.Line <> vwHighlight.Start.Line then
      vwRefreshLines(SaveHlt.Start, vwHighlight.Start);
    if SaveHlt.Stop.Line <> vwHighlight.Stop.Line then
      vwRefreshLines(SaveHlt.Stop, vwHighlight.Stop);
    vwRefreshLines(FCaretPos, FCaretPos);
  end;
end;

procedure TOvcBaseViewer.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  Msg.Result := dlgc_WantArrows;
end;

procedure TOvcBaseViewer.WMHScroll(var Msg : TWMScroll);
begin
  case Msg.ScrollCode of
    SB_LINERIGHT : vwScrollPrimHorz(+1);
    SB_LINELEFT  : vwScrollPrimHorz(-1);
    SB_PAGERIGHT : vwScrollPrimHorz(+10);
    SB_PAGELEFT  : vwScrollPrimHorz(-10);
    SB_THUMBPOSITION :
      if (vwHDelta <> Msg.Pos) then begin
        vwHDelta := Msg.Pos;
        vwSetHScrollPos;
        Repaint;
      end;
  end; {case}
end;

procedure TOvcBaseViewer.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd  : Word;
  Page : integer;

  procedure WordLeft(AmSelecting : Boolean);
    {-Caret left one Word}
  var
    S      : PAnsiChar;
    ActLen : integer;
    Pos    : TOvcTextPos;
  begin
    Pos := FCaretPos;
    with Pos do
      if (Col = 0) then begin
        if (Line = 0) then
          Exit;

        Dec(Line);
        GetLinePtr(Line, Col);
      end else begin {Col > 0}
        S := GetLinePtr(Line, ActLen);
        if (Col > ActLen) then
          Col := ActLen;
        Dec(Col);
        while (Col >= 0) and IsWhiteSpace(S[Col]) do
          Dec(Col);
        while (Col >= 0) and (not IsWhiteSpace(S[Col])) do
          Dec(Col);
        Inc(Col);
      end;
    vwMoveCaretTo(Pos.Line, Pos.Col, AmSelecting);
  end;

  procedure WordRight(AmSelecting : Boolean);
    {-Caret right one Word}
  var
    S      : PAnsiChar;
    ActLen : integer;
    Pos    : TOvcTextPos;
  begin
    Pos := FCaretPos;
    with Pos do begin
      S := GetLinePtr(Line, ActLen);
      if (Col >= ActLen) then begin
        Inc(Line);
        Col := 0;
      end else begin {Col < ActLen}
        while (Col < ActLen) and (not IsWhiteSpace(S[Col])) do
          Inc(Col);
        while (Col < ActLen) and IsWhiteSpace(S[Col]) do
          Inc(Col);
      end;
    end;
    vwMoveCaretTo(Pos.Line, Pos.Col, AmSelecting);
  end;

  procedure CaretLeft(AmSelecting : Boolean);
    {-Caret left one column}
  begin
    if (FCaretPos.Col > 0) then
      vwMoveCaret(-1, 0, False, AmSelecting)
    else if (FCaretPos.Line > 0) then
      vwMoveCaret(High(integer), -1, False, AmSelecting);
  end;

  procedure CaretRight(AmSelecting : Boolean);
    {-Caret right one column}
  var
    ActLen : integer;
  begin
    GetLinePtr(FCaretPos.Line, ActLen);
    if (FCaretPos.Col >= ActLen) then
      vwMoveCaret(-FCaretPos.Col, +1, False, AmSelecting)
    else
      vwMoveCaret(+1, 0, False, AmSelecting);
  end;

  procedure TopOfWindow(AmSelecting : Boolean);
  begin
    if (FTopLine <= FCaretPos.Line) and (FCaretPos.Line < FTopLine+vwRows) then
      vwMoveCaret(0, FTopLine-FCaretPos.Line, False, AmSelecting)
    else
      SetTopLine(FCaretPos.Line);
  end;

  procedure BottomOfWindow(AmSelecting : Boolean);
  begin
    if (FTopLine <= FCaretPos.Line) and (FCaretPos.Line < FTopLine+vwRows) then
      vwMoveCaret(0, Pred(FTopLine+vwRows)-FCaretPos.Line, False, AmSelecting)
    else
      SetTopLine(FCaretPos.Line-Pred(vwRows));
  end;

begin
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));

  Page := MaxI(1, Pred(vwRows));

  if ShowCaret then begin
    case Cmd of
      {caret movements}
      ccLeft :                         {caret left one column}
        CaretLeft(False);
      ccRight :                        {caret right one column}
        CaretRight(False);
      ccUp :                           {caret up one row}
        vwMoveCaret(0, -1, False, False);
      ccDown :                         {caret down one row}
        vwMoveCaret(0, +1, False, False);
      ccHome :                         {caret to beginning of line}
        vwMoveCaret(-FCaretPos.Col, 0, False, False);
      ccEnd :                          {caret to end of line}
        vwMoveCaret(High(integer)-FCaretPos.Col, 0, False, False);
      ccPrevPage :                     {caret up one page}
        vwMoveCaret(0, -Page, True, False);
      ccNextPage :                     {caret down one page}
        vwMoveCaret(0, +Page, True, False);
      ccFirstPage :                    {caret to top of file}
        vwMoveCaret(-FCaretPos.Col, -FCaretPos.Line, False, False);
      ccLastPage :                     {caret to end of file}
        vwMoveCaret(High(integer)-FCaretPos.Col, FLineCount, False, False);
      ccTopOfPage :                    {caret to top of window}
        TopOfWindow(False);
      ccBotOfPage :                    {caret to bottom of window}
        BottomOfWindow(False);
      {selection extensions}
      ccExtendLeft :                   {caret left one column, extend selection}
        CaretLeft(True);
      ccExtendRight :                  {caret right one column, extend selection}
        CaretRight(True);
      ccExtendUp :                     {caret up one row, extend selection}
        vwMoveCaret(0, -1, False, True);
      ccExtendDown :                   {caret down one row, extend selection}
        vwMoveCaret(0, +1, False, True);
      ccExtendPgUp :                   {caret up one page, extend selection}
        vwMoveCaret(0, -Page, True, True);
      ccExtendPgDn :                   {caret down one page, extend selection}
        vwMoveCaret(0, +Page, True, True);
      ccExtendHome :                   {caret to beginning of line, extend selection}
        vwMoveCaret(-FCaretPos.Col, 0, False, True);
      ccExtendEnd :                    {caret to end of line, extend selection}
        vwMoveCaret(High(integer)-FCaretPos.Col, 0, False, True);
      ccExtFirstPage :                 {caret to first page, extend selection}
        vwMoveCaret(-FCaretPos.Col, -FCaretPos.Line, False, True);
      ccExtLastPage :                  {caret to end of file, extend selection}
        vwMoveCaret(High(integer)-FCaretPos.Col, FLineCount, False, True);
      ccExtTopOfPage :                 {caret to top of window, extend selection}
        TopOfWindow(True);
      ccExtBotOfPage :                 {caret to bottom of window, extend selection}
        BottomOfWindow(True);
      ccExtWordLeft :                  {caret left one Word, extend selection}
        WordLeft(True);
      ccExtWordRight :                 {caret right one Word, extend selection}
        WordRight(True);
      {scrolling movements}
      ccScrollUp :                     {scroll display up one row}
        vwScrollPrimVert(-1);
      ccScrollDown :                   {scroll display down one row}
        vwScrollPrimVert(+1);
      {miscellaneous}
      ccCopy :                         {copy highlighted text to clipboard}
        CopyToClipboard;
      ccSetMarker0..ccSetMarker9 :     {set a marker}
        SetMarkerAt(Cmd-ccSetMarker0, FCaretPos.Line, FCaretPos.Col);
      ccGotoMarker0..ccGotoMarker9 :   {goto a marker}
        GotoMarker(Cmd-ccGotoMarker0);
    else
      {do user command notification for user commands}
      if Cmd >= ccUserFirst then
        DoOnUserCommand(Cmd)
      else
        inherited;
    end;
  end else begin
    case Cmd of
      ccLeft       : vwScrollPrimHorz(-1);
      ccRight      : vwScrollPrimHorz(+1);
      ccUp         : vwScrollPrimVert(-1);
      ccDown       : vwScrollPrimVert(+1);
      ccHome       : vwMoveCaret(-FCaretPos.Col, -FCaretPos.Line, False, False);
      ccEnd        : vwMoveCaret(High(integer)-FCaretPos.Col, FLineCount, False, False);
      ccFirstPage  : vwMoveCaret(-FCaretPos.Col, -FCaretPos.Line, False, False);
      ccLastPage   : vwMoveCaret(High(integer)-FCaretPos.Col, FLineCount, False, False);
      ccPrevPage   : vwMoveCaret(0, -Page, True, False);
      ccNextPage   : vwMoveCaret(0, +Page, True, False);
      ccScrollUp   : vwScrollPrimVert(-1);
      ccScrollDown : vwScrollPrimVert(+1);
    else
      {do user command notification for user commands}
      if Cmd >= ccUserFirst then
        DoOnUserCommand(Cmd)
      else
        inherited;
    end;
  end;
end;

procedure TOvcBaseViewer.WMKillFocus(var Msg : TWMKillFocus);
begin
  vwCaret.Linked := False;
  vwAmFocused := False;
  inherited;
end;

procedure TOvcBaseViewer.WMLButtonDblClk(var Msg : TWMMouse);
var
  MousePos   : TOvcTextPos;
  S          : PAnsiChar;
  ActLen     : integer;
  NewRange   : TOvcRange;
begin
  inherited;

  if not vwLineSelCursorOn then begin
    vwGetMousePos(MousePos, Msg.XPos, Msg.YPos);
    S := GetLinePtr(MousePos.Line, ActLen);

    if (ActLen > 0) then begin
      {find start of this Word}
      while (MousePos.Col >= 0) and IsWhiteSpace(S[MousePos.Col]) do
        dec(MousePos.Col);
      while (MousePos.Col >= 0) and (not IsWhiteSpace(S[MousePos.Col])) do
        dec(MousePos.Col);
      inc(MousePos.Col);

      NewRange.Start := MousePos;

      {find end of this Word}
      while (MousePos.Col < ActLen) and (not IsWhiteSpace(S[MousePos.Col])) do
        inc(MousePos.Col);
      while (MousePos.Col < ActLen) and IsWhiteSpace(S[MousePos.Col]) do
        inc(MousePos.Col);

      NewRange.Stop := MousePos;

      SetSelection(NewRange.Start.Line, NewRange.Start.Col,
                   NewRange.Stop.Line, NewRange.Stop.Col, True);
    end;
  end;
end;

procedure TOvcBaseViewer.WMLButtonDown(var Msg : TWMMouse);
var
  MousePos   : TOvcTextPos;
  ActLen     : integer;
  ShiftClick : Boolean;
  NewRange   : TOvcRange;
  LeftBtn    : Byte;
  P          : TPoint;
  SP         : TSmallPoint;
begin
  {call our ancestor - this'll set mouse capture on}
  inherited;

  {!!.01} {added}
  {solve problem with minimized modeless dialogs and MDI child windows}
  {that contain viewer components}
  if not Focused and CanFocus then
    {$IFDEF Win32}
    Windows.SetFocus(Handle);
    {$ELSE}
    WinProcs.SetFocus(Handle);
    {$ENDIF}

  vwGetMousePos(MousePos, Msg.XPos, Msg.YPos);
  ShiftClick := ssShift in KeysToShiftState(Msg.Keys);

  if not vwLineSelCursorOn then begin
    if ShiftClick then
      vwMoveCaretTo(MousePos.Line, MousePos.Col, True)
    else
      vwMoveCaretTo(MousePos.Line, MousePos.Col, False);
  end else if (not ShiftClick) or (MousePos.Line = FCaretPos.Line) then begin
    GetLinePtr(MousePos.Line, ActLen);
    NewRange.Start.Line := MousePos.Line;
    NewRange.Start.Col := 0;
    NewRange.Stop.Line := MousePos.Line;
    NewRange.Stop.Col := ActLen;
    SetSelection(NewRange.Start.Line, NewRange.Start.Col,
                 NewRange.Stop.Line, NewRange.Stop.Col, True);
  end else if (MousePos.Line > FCaretPos.Line) then begin
    GetLinePtr(MousePos.Line, ActLen);
    NewRange.Start.Line := FCaretPos.Line;
    NewRange.Start.Col := 0;
    NewRange.Stop.Line := MousePos.Line;
    NewRange.Stop.Col := ActLen;
    SetSelection(NewRange.Start.Line, NewRange.Start.Col,
                 NewRange.Stop.Line, NewRange.Stop.Col, True);
  end else begin {MousePos.Line < FCaretPos.Line}
    NewRange.Start.Line := MousePos.Line;
    NewRange.Start.Col := 0;
    NewRange.Stop.Line := FCaretPos.Line;
    NewRange.Stop.Col := ActLen;
    SetSelection(NewRange.Start.Line, NewRange.Start.Col,
                 NewRange.Stop.Line, NewRange.Stop.Col, False);
  end;


  {get the physical left button}
  LeftBtn := GetLeftButton;
  repeat
    {post ourselves fake WM_MOUSEMOVE messages}
    GetCursorPos(P);
    P := ScreenToClient(P);
    SP.X := P.X;
    SP.Y := P.Y;
    PostMessage(Handle, WM_MOUSEMOVE, 0, LongInt(SP));
    Application.ProcessMessages;
  until GetAsyncKeyState(LeftBtn) >= 0;
end;

procedure TOvcBaseViewer.WMLButtonUp(var Msg : TWMMouse);
begin
  inherited;
end;

procedure TOvcBaseViewer.WMMouseActivate(var Msg : TWMMouseActivate);
begin
  if (csDesigning in ComponentState) or vwAmFocused then
    inherited
  else begin
    {SetFocus;}                                                        {!!.01}
    if Controller.ErrorPending then
      Msg.Result := MA_NOACTIVATEANDEAT
    else
      Msg.Result := MA_ACTIVATE;
  end;
end;

procedure TOvcBaseViewer.WMMouseMove(var Msg : TWMMouse);
var
  ActLen   : integer;
  MousePos : TOvcTextPos;
  NewRange : TOvcRange;
begin
  inherited;

  if (csClicked in ControlState) then begin
    vwGetMousePos(MousePos, Msg.XPos, Msg.YPos);
    if not vwLineSelCursorOn then
      vwMoveCaretTo(MousePos.Line, MousePos.Col, True)
    else begin
      if (MousePos.Line >= vwAnchor.Line) then begin
        GetLinePtr(MousePos.Line, ActLen);
        NewRange.Start.Line := vwAnchor.Line;
        NewRange.Start.Col := 0;
        NewRange.Stop.Line := MousePos.Line;
        NewRange.Stop.Col := ActLen;
        if not RangeEqual(vwHighlight, NewRange) then
          SetSelection(NewRange.Start.Line, NewRange.Start.Col,
                       NewRange.Stop.Line, NewRange.Stop.Col, True);
      end else if (MousePos.Line < vwAnchor.Line) then begin
        GetLinePtr(vwAnchor.Line, ActLen);
        NewRange.Start.Line := MousePos.Line;
        NewRange.Start.Col := 0;
        NewRange.Stop.Line := vwAnchor.Line;
        NewRange.Stop.Col := ActLen;
        if not RangeEqual(vwHighlight, NewRange) then
          SetSelection(NewRange.Start.Line, NewRange.Start.Col,
                       NewRange.Stop.Line, NewRange.Stop.Col, False);
      end;
    end;
  end;
end;

procedure TOvcBaseViewer.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  if csDesigning in ComponentState then
    {don't call inherited so we can bypass vcl's attempt}
    {to trap the mouse hit}
    DefaultHandler(Msg)
  else
    inherited;
end;

procedure TOvcBaseViewer.WMSetCursor(var Msg : TWMSetCursor);
var
  MousePos  : TPoint;
begin
  vwLineSelCursorOn := False;
  Msg.Result := 0;
  if (not (csDesigning in ComponentState)) and (Msg.HitTest = HTCLIENT) then begin
    {convert the mouse position to client coords}
    GetCursorPos(MousePos);
    MousePos := ScreenToClient(MousePos);
    {if we're in the left margin, switch cursors}
    if (MousePos.X < LeftMargin) then begin
      SetCursor(vwLineSelCursor);
      vwLineSelCursorOn := True;
      Msg.Result := 1;
    end;
  end;
  {if we didn't process the message let the default handler do it}
  if (Msg.Result = 0) then
    DefaultHandler(Msg);
end;

procedure TOvcBaseViewer.WMSetFocus(var Msg : TWMSetFocus);
begin
  vwAmFocused := True;
  if not (csDesigning in ComponentState) then begin
    vwCaret.Visible := FShowCaret;
    vwCaret.Linked := True;
  end;
  inherited;
end;

procedure TOvcBaseViewer.WMVScroll(var Msg : TWMScroll);
var
  NewTop, Total, Max, L : LongInt;
begin
  case Msg.ScrollCode of
    SB_LINEDOWN : vwScrollPrimVert(+1);
    SB_LINEUP   : vwScrollPrimVert(-1);
    SB_PAGEDOWN : vwScrollPrimVert(+vwRows);
    SB_PAGEUP   : vwScrollPrimVert(-vwRows);
    SB_THUMBPOSITION :
      begin
        if Msg.Pos = 0 then
          NewTop := 0
        else if Msg.Pos = vwVSMax then
          if vwRows >= CheckLine(FLineCount) then
            NewTop := 0
          else
            NewTop := vwVSHigh
        else begin
          Total := FLineCount;
          Max := vwVSMax;
          CheckLine(FLineCount);
          if Total <> FLineCount then begin
            L := (LongInt(Msg.Pos)*vwVSMax) div Max;
            NewTop := L * vwDivisor;
          end else
            NewTop := CheckLine(Msg.Pos * vwDivisor);
        end;
        SetTopLine(CheckLine(NewTop));
      end;
  end;
end;

{*** File access helper routines ***}
procedure RaiseIOException(ErrCode : integer);
  var
    E       : EInOutError;
    StrCode : word;
  begin
    case ErrCode of
      2 : StrCode := SCViewerFileNotFound;
      3 : StrCode := SCViewerPathNotFound;
      4 : StrCode := SCViewerTooManyOpenFiles;
      5 : StrCode := SCViewerFileAccessDenied;
    else
      StrCode := 0;
    end;{case}
    if (StrCode = 0) then
      E := EInOutError.CreateFmt(GetOrphStr(SCViewerIOError), [ErrCode])
    else
      E := EInOutError.Create(GetOrphStr(StrCode));
    E.ErrorCode := ErrCode;
    raise E;
  end;

{*** Text file device driver ***}
{$IFDEF Win32}
{!!Note: Delphi 2.0 has a bug in that the RTL text file processing
         does not open the file in shared mode: the share bits in
         FileMode are completely ignored. This TFDD replaces the
         standard Delphi one, so that the text file viewer can
         read the file at the same time as other programs. It is
         a readonly TFDD; output is NOT supported.}

function VwrTFDD_Close(var F : TTextRec) : Integer; far;
begin
  if not CloseHandle(F.Handle) then
    Result := GetLastError
  else begin
    Result := 0;
    F.Handle := LongInt(INVALID_HANDLE_VALUE);                         {!!.D4}
    F.Mode := fmClosed;
  end;
end;

function VwrTFDD_Input(var F : TTextRec) : Integer; far;
var
  BytesRead : DWORD;
begin
  with F do begin
    if not ReadFile(Handle, BufPtr^, BufSize, BytesRead, nil) then
      Result := GetLastError
    else begin
      BufPos := 0;
      BufEnd := BytesRead;
      Result := 0;
    end;
  end;
end;

function VwrTFDD_Flush(var F : TTextRec) : Integer; far;
begin
  Result := 0;
end;

function VwrTFDD_Open(var F : TTextRec) : Integer; far;
begin
  F.Handle := CreateFile(F.Name, GENERIC_READ, FILE_SHARE_READ,
                 nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if F.Handle = LongInt(INVALID_HANDLE_VALUE) then begin               {!!.D4}
    F.Mode := fmClosed;
    Result := GetLastError;
  end else begin
    F.Mode      := fmInput;
    F.InOutFunc := @VwrTFDD_Input;
    F.FlushFunc := @VwrTFDD_Flush;
    F.CloseFunc := @VwrTFDD_Close;
    Result      := 0;
  end;
end;

procedure AssignVwrTFDD(var F : Text; FileName : string);
begin
  with TTextRec(F) do begin
    Handle   := LongInt(INVALID_HANDLE_VALUE);                         {!!.D4}
    Mode     := fmClosed;
    BufSize  := SizeOf(Buffer);
    BufPtr   := @Buffer;
    BufPos   := 0;
    OpenFunc := @VwrTFDD_Open;
    StrPCopy(Name, FileName);
  end;
end;
{$ENDIF}


{*** TStringNode ***}

constructor TStringNode.Create(P : PAnsiChar);
begin
  snNext := nil;
  snPrev := nil;
  if Assigned(P) and (P^ <> #0) then begin
    snS := StrNew(P);
    snSLen := StrLen(P);
  end else begin
    snS := PNullString;
    snSLen := 0;
  end;
end;

destructor TStringNode.Destroy;
begin
  if (snSLen > 0) then
    StrDispose(snS);
end;

function TStringNode.GetS(var Len : integer) : PAnsiChar;
begin
  Result := snS;
  Len := snSLen;
end;


{*** TVwrStringList ***}

constructor TVwrStringList.Create;
begin
  slTail := TStringNode.Create(NullString);
  slHead := TStringNode.Create(NullString);
  slHead.snNext := slTail;
  slTail.snPrev := slHead;
  slCount := 0;
  slLastN := -1;
  slLastNode := nil;
end;

destructor TVwrStringList.Destroy;
var
  N, P : TStringNode;
begin
  N := slTail;
  while Assigned(N) do begin
    P := N.snPrev;
    N.Free;
    N := P;
  end;
end;

function TVwrStringList.Count : LongInt;
begin
  Result := slCount;
end;

procedure TVwrStringList.Append(P : TStringNode);
begin
  if Assigned(P) then begin
    P.snPrev := slTail.snPrev;
    P.snNext := slTail;
    slTail.snPrev.snNext := P;
    slTail.snPrev := P;
    Inc(slCount);
  end;
end;

function TVwrStringList.Nth(N : LongInt) : TStringNode;
var
  I         : LongInt;
  DistBegin,
  DistLast,
  DistEnd   : LongInt;
begin
  if (N < 0) or (N >= slCount) then
    Result := nil
  else if N = 0 then
    Result := slHead.snNext
  else if N = Pred(slCount) then
    Result := slTail.snPrev
  else if N = slLastN then
    Result := slLastNode
  else if N = slLastN+1 then
    Result := slLastNode.snNext
  else if N = slLastN-1 then
    Result := slLastNode.snPrev
  else begin
    DistBegin := N;
    if slLastN < 0 then
      DistLast := MaxLongInt
    else
      DistLast := Abs(N - slLastN);
    DistEnd := Pred(slCount - N);

    {is it closest to the first line?}
    if (DistBegin < DistLast) and (DistBegin < DistEnd) then begin
      Result := slHead;
      for I := 0 to N do
        Result := Result.snNext;
    end else if (DistEnd < DistLast) then begin {is it closest to the last line?}
      Result := slTail;
      for I := Pred(slCount) downto N do
        Result := Result.snPrev;
    end else if (N > slLastN) then begin {is it after the last known line?}
      Result := slLastNode;
      for I := Succ(slLastN) to N do
        Result := Result.snNext;
    end else begin {it's before the last known line}
      Result := slLastNode;
      for I := Pred(slLastN) downto N do
        Result := Result.snPrev;
    end
  end;

  if Assigned(Result) then begin
    slLastN := N;
    slLastNode := Result;
  end;
end;


{*** TOvcCustomTextFileViewer ***}

constructor TOvcCustomTextFileViewer.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

destructor TOvcCustomTextFileViewer.Destroy;
begin
  fvLines.Free;
  fvLines := nil;

  {dispose of file name string}
  DisposeStr(FFileName);

  inherited Destroy;
end;

function TOvcCustomTextFileViewer.GetFileName : string;
begin
  if Assigned(FFileName) then
    Result := FFileName^
  else
    Result := '';
end;

function TOvcCustomTextFileViewer.GetIsOpen : Boolean;
begin
  Result := Assigned(fvLines);
end;

function TOvcCustomTextFileViewer.CheckLine(LineNum : LongInt) : LongInt;
begin
  Result := LineNum;
  if LineNum < 0 then
    Result := 0
  else if LineNum > Pred(FLineCount) then
    Result := Pred(FLineCount);
end;

function TOvcCustomTextFileViewer.GetLinePtr(LineNum : LongInt; var Len : integer) : PAnsiChar;
begin
  if (not Assigned(fvLines)) or (LineNum < 0) or (LineNum >= fvLines.Count) then begin
    Result := NullString;
    Len := 0;
  end else
    Result := fvLines.Nth(LineNum).GetS(Len);
end;

procedure TOvcCustomTextFileViewer.SetFileName(const N : string);
var
  WasOpen : Boolean;
begin
  WasOpen := IsOpen;
  IsOpen := False;
  AssignStr(FFileName, UpperCase(N));
  IsOpen := WasOpen;
end;

procedure TOvcCustomTextFileViewer.SetIsOpen(OpenIt : Boolean);
const
  BufSize = 8192;
var
  FM           : Word;
  FA           : Integer;
  F            : System.Text;
  Buf          : Pointer;
  ErrorCode    : Integer;
  {$IFNDEF Win32}
  SaveFileMode : Byte;
  {$ENDIF}
  S            : array [0..Pred(LineBufSize)] of AnsiChar;
begin
  if (OpenIt = GetIsOpen) then
    Exit;

  FFileSize := 0;

  if not OpenIt then begin
    {dispose of the line list}
    fvLines.Free;
    fvLines := nil;
    LineCount := 0;
    Exit;
  end;

  if (FileName = '') then
    Exit;

  try {except}

    {display hourglass}
    vwShowWaitCursor(True);

    try {finally}
      {get the size of the file}
      {$IFNDEF Win32}
      SaveFileMode := FileMode;
      {$ENDIF}
      FM := fmOpenRead or fmShareDenyWrite;
      FA := FileOpen(FileName, FM);
      if (FA < 0) then
        begin
          {$IFDEF Win32}
          ErrorCode := GetLastError;
          {$ELSE}
          ErrorCode := -vwFile;
          {$ENDIF}
          RaiseIOException(ErrorCode);
        end;
      FFileSize := FileSeek(FA, 0, 2);
      if (FFileSize < 0) then
        begin
          {$IFDEF Win32}
          ErrorCode := GetLastError;
          {$ELSE}
          ErrorCode := -1;
          {$ENDIF}
          FileClose(FA);
          RaiseIOException(ErrorCode);
        end;
      FileClose(FA);

      {reset line count}
      LineCount := 0;

      {create line list object}
      fvLines := TVwrStringList.Create;

      {open the file}
      {$IFDEF Win32}
      AssignVwrTFDD(F, Filename);
      {$ELSE}
      System.Assign(F, Filename);
      FileMode := $20; {LSB=readonly, MSB=deny write}
      {$ENDIF}
      Reset(F);

      {get buffer for text file - no problem if we can't}
      Buf := nil;
      try {except}
        GetMem(Buf, BufSize);
        System.SetTextBuf(F, Buf^, BufSize);
      except
        on EOutOfMemory do {nothing}
      end;{try}

      {read the file}
      try {finally}
        while not Eof(F) do begin
          ReadLn(F, S);
          fvLines.Append(TStringNode.Create(S));
        end;

        {add a blank line at the end of the line list}
        fvLines.Append(TStringNode.Create(NullString));
      finally
        {close the file}
        Close(F);
        {$IFNDEF Win32}
        FileMode := SaveFileMode;
        {$ENDIF}

        {dispose of buffer}
        if Assigned(Buf) then
          FreeMem(Buf, BufSize);

        {set the line count}
        LineCount := fvLines.Count;
      end;{try}
    finally
      {restore original cursor}
      vwShowWaitCursor(False);
    end;{try}

  except
    {on any exception free the line list}
    fvLines.Free;
    fvLines := nil;
    FFileSize := 0;
    LineCount := 0;
    if not (csDesigning in ComponentState) then
      raise;
  end;{try}
end;



{*** TOvcCustomFileViewer ***}

constructor TOvcCustomFileViewer.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FBufferPageCount := DefBufferPageCount;
  FFilterChars     := DefFilterChars;
  FInHexMode       := DefHexMode;
  FIsOpen          := DefIsOpen;

  fvInitObjectFields;
  fvInitFileFields;
end;

function TOvcCustomFileViewer.CheckLine(LineNum : LongInt) : LongInt;
begin
  {assume that the line is valid}
  Result := LineNum;

  {if the file is empty, or hasn't been read yet return zero}
  if (FileSize = 0) then
    Result := 0
  {do we know how many lines there really are in the file?}
  else if InHexMode or (fvLastLine >= 0) then begin
    {is this line beyond the last one?}
    if (LineNum > fvLastLine) then
      Result := fvLastLine;
  end else if (LineNum > fvKnownLine) then begin
    {we don't know how many lines there are, so is this line beyond the
     last line that we *do* know about?}

    {try to go to the specified line}
    fvGotoTextLine(LineNum);

    {did we reach the end of the file?}
    if (fvLastLine >= 0) then begin
      {tell our ancestor how many lines we really have}
      vwChangeLineCount(Succ(fvLastLine));

      {don't let the viewer go past the last line}
      if (LineNum > fvLastLine) then
        Result := fvLastLine;
    end;
  end;
end;

destructor TOvcCustomFileViewer.Destroy;
begin
  fvDeallocateBuffers;

  if IsOpen then begin
    FIsOpen := False;
    FFileSize := 0;
    SysUtils.FileClose(vwFile);
  end;

  {dispose of file name string}
  DisposeStr(FFileName);

  inherited Destroy;
end;

procedure TOvcCustomFileViewer.fvDeallocateBuffers;
var
  I : integer;
begin
  {free everything we've alloacted}
  if Assigned(fvPages) then begin
    for I := fvMaxPage downto 0 do
      if Assigned(fvPages^[I].Buffer) then
        FreeMem(fvPages^[I].Buffer, PageBufSize);
    FreeMem(fvPages, fvPageArraySize);
    fvPages := nil;
  end;
  if Assigned(fvLnBuf) then begin
    FreeMem(fvLnBuf, LineBufSize);
    fvLnBuf := nil;
  end;
end;

function TOvcCustomFileViewer.fvGetLineAsText(LineNum : LongInt; var Len : integer) : PAnsiChar;
var
  CharsLeft : integer;
begin
  {go to the specified line}
  fvGotoTextLine(LineNum);

  {save the line number}
  fvLineInBuf := LineNum;

  {initialize line}
  Result := fvLnBuf;
  Len := 0;
  fvLnBuf[0] := #0;
  fvLnBufLen := 0;

  {skip all this if we're past end-of-file}
  if (fvWorkOffset < FileSize) then begin
    {force the next Char into a buffer}
    fvGetWorkingChar;
    {calc an integer value for the number of chars left.
     If > MaxInt, force it to MaxInt; we're not particularly
     worried about the exact value if so, just so long as it's
     greater than LineBufSize}
    CharsLeft := MinL((FileSize - fvWorkOffset - 1), High(integer));

    {$IFDEF Win32}
    asm
      push ebx
      push edi
      push esi

      mov  edi, Self
      mov  edx, [edi].fvWorkEnd
      mov  esi, [edi].fvWorkPtr
      mov  edi, [edi].fvLnBuf
      mov  ebx, CharsLeft
      xor  ecx, ecx
      mov  ecx, LineBufSize-1

    @@GetNextChar:
      cmp  esi, edx
      jb   @@InsertNextChar

      push edi                             {save registers}
      push ecx
      mov  edi, Self                       {load self pointer}
      mov  [edi].fvWorkPtr, esi            {adjust fvWorkPtr}
      mov  eax, CharsLeft                  {adjust fvWorkOffset}
      sub  eax, ebx
      add  [edi].fvWorkOffset, eax
      mov  eax, edi
      call fvGetWorkingChar                {get next page buffer}
      or   al, al                          {check for EOF: set zero flag}
      pop  ecx                             {restore registers}
      pop  eax
      {xor  edx, edx}                                           {!!.12}
      mov  edx, [edi].fvWorkEnd            {reload registers}
      mov  esi, [edi].fvWorkPtr
      mov  edi, eax
      jz   @@AppendNull                    {if zf set, t'was EOF}

    @@InsertNextChar:
      cld                                  {go forward}
      lodsb                                {next character into al}
      cmp  al,13                           {is it a CR?}
      je   @@AppendNull                    {if so, we're done}
      or   al,al                           {is it a null?}
      jnz  @@DoInsert
      mov  al, ' '                         {if so, translate to space}

    @@DoInsert:
      stosb                                {store the character}
      sub  ebx,1                           {decrement CharsLeft count} {!!.13}
      jb   @@AppendNull                    {any chars left?}
      loop @@GetNextChar                   {do it again if room in fvLnBuf}

    @@AppendNull:
      xor  al,al                            {append a null}
      stosb
      pop  esi
      pop  edi
      pop  ebx
    end;
    {$ELSE}
    asm
      push ds                              {save ds}
      les di,Self                          {get Self}
      mov dx,es:[di].fvWorkEnd             {dx = fvWorkEnd}
      lds si,es:[di].fvWorkPtr             {ds:si = fvWorkPtr}
      les di,es:[di].fvLnBuf               {es:di = fvLnBuf}
      mov bx,CharsLeft                     {bx = CharsLeft}
      mov cx,LineBufSize-1                 {cx = LineBufSize-1}

    @@GetNextChar:
      cmp si,dx                            {any chars left in page buffer?}
      jb @@InsertNextChar                  {if so, continue}

      pop ds                               {restore ds}
      push di                              {save registers}
      push bx
      push cx
      les di,Self                          {load self pointer}
      mov es:[di].fvWorkPtr.Word,si        {adjust fvWorkPtr}
      mov ax,CharsLeft                     {adjust fvWorkOffset}
      sub ax,bx
      add es:[di].fvWorkOffset.Word[0],ax
      adc es:[di].fvWorkOffset.Word[2],0
      push es                              {push self pointer onto stack}
      push di
      call fvGetWorkingChar                {get next page buffer}
      or al, al                            {check for EOF: set zero flag}
      pop cx                               {restore registers}
      pop bx
      pop ax
      push ds
      les di,Self
      mov dx,es:[di].fvWorkEnd             {reload registers}
      lds si,es:[di].fvWorkPtr
      les di,es:[di].fvLnBuf
      mov di,ax
      jz @@AppendNull                      {if zf set, t'was EOF}

    @@InsertNextChar:
      cld                                  {go forward}
      lodsb                                {next character into al}
      cmp al,13                            {is it a CR?}
      je @@AppendNull                      {if so, we're done}
      or al,al                             {is it a null?}
      jnz @@DoInsert
      mov al, ' '                          {if so, translate to space}

    @@DoInsert:
      stosb                                {store the character}
      sub bx,1                             {decrement CharsLeft count}
      jb @@AppendNull                      {any chars left?}
      loop @@GetNextChar                   {do it again if room in fvLnBuf}

    @@AppendNull:
      xor al,al                            {append a null}
      stosb
      pop ds                               {restore ds}
    end;
    {$ENDIF}

    Len := StrLen(fvLnBuf);
    fvLnBufLen := Len;
  end;
end;

function TOvcCustomFileViewer.fvGetLineInHex(LineNum : LongInt; var Len : integer) : PAnsiChar;
const
  HexWidth = 75;    {width of: "LLLLLLLL  HH HH ... HH  xx...xx"}
  InitColHex = 10;  {index in string of first hex pair}
  InitColAscii = HexWidth-16; {index in string of first ASCII Char}
var
  NumChars  : integer;
  ColHex    : integer;
  ColAscii  : integer;
  i         : integer;
  HexLongIntStr : array[0..9] of Char;
  WorkChr   : Char;
begin
  {go to the specified line (it exists)}
  fvGotoHexLine(LineNum);

  {Force the page into memory if required}
  fvGetWorkingChar;

  {save the line number}
  fvLineInBuf := LineNum;

  {initialize line to all spaces}
  Result := fvLnBuf;
  Len := HexWidth;
  FillChar(fvLnBuf[0], HexWidth, ' ');
  fvLnBuf[HexWidth] := #0;
  fvLnBufLen := HexWidth;

  {plug in file offset and initialize}
  HexLPChar(HexLongIntStr, fvWorkOffset);
  Move(HexLongIntStr, fvLnBuf[0], 8);

  ColHex := InitColHex;
  ColAscii := InitColAscii;

  NumChars := MinL(16, FileSize-fvWorkOffset);
  for i := 1 to NumChars do begin
    {get next character}
    WorkChr := fvWorkPtr^;

    {plug in the hex value of the character}
    InsertHexPair(fvLnBuf[ColHex], WorkChr);

    {Can't have nulls or tabs in the ASCII part so convert them}
    if (WorkChr = #0) or
       (ExpandTabs and (WorkChr = #9)) then
      WorkChr := '.'
    {if we're filtering out bad chars then convert 'bad' chars}
    else if FilterChars then
      if (WorkChr < ' ') or (WorkChr > #127) then
        WorkChr := '.';

    {plug in the ASCII value of the character}
    fvLnBuf[ColAscii] := WorkChr;

    {advance counters}
    Inc(ColHex, 3);
    Inc(ColAscii);
    Inc(fvWorkPtr);
  end;

  inc(fvWorkOffset, NumChars);
end;

function TOvcCustomFileViewer.fvGetWorkingChar : Boolean;
begin
  Result := True;

  {check whether the work pointer is still pointing into the work buffer}
  {$IFDEF Win32}
  if (integer(fvWorkPtr) >= fvWorkEnd) or (integer(fvWorkPtr) < fvWorkBeg) then begin
  {$ELSE}
  if (OS(fvWorkPtr).O >= fvWorkEnd) or (OS(fvWorkPtr).O < fvWorkBeg) then begin
  {$ENDIF}
    {have we hit EOF?}
    if (fvWorkOffset >= FileSize) then begin
      Result := False;
      Exit;
    end;
    fvGetWorkingPage;
  end;
end;

procedure TOvcCustomFileViewer.fvGetWorkingPage;
var
  FilePosn    : longint;
  i           : integer;
  SmallestLRU : TQuasiTime;
  PageIdx     : integer;
  FoundIt     : Boolean;
begin
  {calc the working block number}
  fvWorkBlk := fvWorkOffset shr LogBufSize;

  {Scan loaded pages looking for (a) the working block or (b)
   the least recently used block. Break out if we hit on (a).}
  SmallestLRU := LargestQuasiTime;
  FoundIt := False;
  PageIdx := -1;
  for i := 0 to fvMaxPage do
    with fvPages^[i] do
      if (BlockNum = fvWorkBlk) then begin
        PageIdx := i;
        Foundit := True;
        Break;
      end else if (LastUsed < SmallestLRU) then begin
        SmallestLRU := LastUsed;
        PageIdx := i;
      end;

  {if we didn't find the working block in memory, load it now into
   the least recently used page buffer}
  if not FoundIt then begin
    with fvPages^[PageIdx] do begin
      FilePosn := FileSeek(vwFile, LongInt(fvWorkBlk) shl LogBufSize, 0);
      if (FilePosn < 0) then begin
        {$IFDEF Win32}
        FilePosn := GetLastError;
        {$ENDIF}
        RaiseIOException(FilePosn);
      end;
      FillChar(Buffer^, PageBufSize, 0);
      ByteCount := FileRead(vwFile, Buffer^, PageBufSize);
      if (ByteCount < 0) then begin
        {$IFDEF Win32}
        ByteCount := GetLastError;
        {$ENDIF}
        RaiseIOException(ByteCount);
      end;
    end;
  end;

  {increment tick counter to mark our working page}
  Inc(fvTicks);
  if (fvTicks = LargestQuasiTime) then begin
    {Tick wraparound, so reset all LastUsed fields}
    fvTicks := 1;
    for i := 0 to fvMaxPage do
      fvPages^[i].LastUsed := 0;
  end;

  {Save page buffer information}
  with fvPages^[PageIdx] do begin
    BlockNum := fvWorkBlk;
    LastUsed := fvTicks;
    fvWorkPtr := pointer(Buffer);
    {$IFDEF Win32}
    fvWorkBeg := Integer(fvWorkPtr);
    {$ELSE}
    fvWorkBeg := OS(fvWorkPtr).O;
    {$ENDIF}
    fvWorkEnd := fvWorkBeg + ByteCount;
    {$IFDEF Win32}
    inc(fvWorkPtr, fvWorkOffset - (LongInt(fvWorkBlk) shl LogBufSize));
    {$ELSE}
    inc(OS(fvWorkPtr).O, fvWorkOffset - (LongInt(fvWorkBlk) shl LogBufSize));
    {$ENDIF}
  end;
end;

procedure TOvcCustomFileViewer.fvGotoHexLine(Line : LongInt);
var
  NewOfs : LongInt;
begin
  NewOfs := MinL((Line * 16), ((FileSize-1) and $7FFFFFF0));

  {check whether we are still on the same page as before}
  if (NewOfs shr LogBufSize) = fvWorkBlk then begin
    fvWorkOffset := NewOfs;
    {$IFDEF Win32}
    fvWorkPtr := Pointer(fvWorkBeg + (fvWorkOffset - (LongInt(fvWorkBlk) shl LogBufSize)));
    {$ELSE}
    OS(fvWorkPtr).O := fvWorkBeg + (fvWorkOffset - (LongInt(fvWorkBlk) shl LogBufSize));
    {$ENDIF}
  end else begin {we've moved pages}
    fvWorkOffset := NewOfs;
    fvWorkPtr := nil;
    fvWorkBeg := MaxInt;
    fvWorkEnd := 0;
  end;
end;

procedure TOvcCustomFileViewer.fvGotoTextLine(Line : LongInt);
var
  OldNewLine    : LongInt;
  OldNewLineOfs : LongInt;
  LineDelta     : LongInt;
  LocalNL       : LongInt;
  LastLineLen   : integer;
  Delta1, Delta2, Delta3, Delta4, Delta5 : LongInt;
begin
  {is this line beyond the end?}
  if (fvLastLine >= 0) and (Line > fvLastLine) then
    Line := fvLastLine;

  {is the file empty? (or maybe it hasn't even been read)}
  if (FileSize = 0) then begin
    fvNewLine := 0;
    fvNewOffset := 0;
  end else begin {we've got to search for it}
    {save the current values for 'new' line: we might use them later
     to store in the 'known' line fields}
    OldNewLine := fvNewLine;
    OldNewLineOfs := fvNewOffset;

    {determine best position to start from}
    Delta1 := Line;                  {distance from first line}
    Delta2 := Abs(Line-fvNewLine);   {distance from previous new line}
    Delta3 := Abs(Line-fvKnownLine); {distance from last known line in file}
    if (fvLastLine >= 0) then
      Delta4 := Abs(fvLastLine-Line) {distance from last line in file}
    else
      Delta4 := MaxLongInt;
    Delta5 := Abs(Line-fvCurLine);   {distance from current line}

    {is Delta5 the smallest value?}
    if (Delta5 < Delta4) and (Delta5 < Delta3) and
       (Delta5 < Delta2) and (Delta5 < Delta1) then begin
      {yes, so start from current line}
      fvNewOffset := fvCurOffset;
      fvNewLine := fvCurLine;
    end else if (Delta4 < Delta3) and (Delta4 < Delta2) and
            (Delta4 < Delta1) then begin {is Delta4 the smallest value?}
      {yes, so start at end of file}
      fvNewOffset := fvLastLineOffset;
      fvNewLine := fvLastLine;
    end else if (Delta3 < Delta2) and (Delta3 < Delta1) then begin {is Delta3 the smallest value?}
      {yes, so start at last 'known' position in file}
      fvNewOffset := fvKnownOffset;
      fvNewLine := fvKnownLine;
    end else if (Delta1 < Delta2) then begin {is Delta1 the smallest value?}
      {start at beginning of file}
      fvNewOffset := 0;
      fvNewLine := 0;
    end;

    {this might take a while}
    LineDelta := Line - fvNewLine;
    if (Abs(LineDelta) > 100) then     {100 is arbitrary}
      vwShowWaitCursor(True);

    {get ready to search}
    fvNewWorkingSet;
    fvGetWorkingChar;

    {use a local variable for fvNewLine: it's faster}
    LocalNL := fvNewLine;

    {do we need to search forwards for the line?}
    if (LineDelta > 0) then begin
      {$IFDEF Win32}
      asm
        {Note: the following is slightly complicated by the need
               to calculate the length of the last line scanned
               through. If we do hit the last line of all, this
               value will be used to calculate fvLastLineOffset.}
        push  edi
        push  esi

        xor   eax, eax
        mov   LastLineLen, eax
        jmp   @@PrepareForSearch


      @@LoadNextPage:
        add   LastLineLen, eax
        mov   edi, Self
        add   [edi].fvWorkPtr, esi
        add   [edi].fvWorkOffset, esi

        mov   eax, edi
        call  fvGetWorkingChar
        or    al, al
        jz    @@ExitAsmBlock

      @@PrepareForSearch:
        mov   edx, Line
        mov   edi, Self
        mov   esi, [edi].fvWorkEnd
        mov   edi, [edi].fvWorkPtr
        sub   esi, edi
        mov   ecx, esi

      @@SearchForNextCR:
        mov   eax, ecx
        jecxz @@LoadNextPage
        cld
        push  ecx
        mov   al, 13
        repne scasb
        pop   eax
        jne   @@LoadNextPage

        or    ecx, ecx
        jnz   @@CheckForLF

        add   LastLineLen, eax
        mov   edi, Self
        add   [edi].fvWorkPtr, esi
        add   [edi].fvWorkOffset, esi

        mov   eax, edi
        call  fvGetWorkingChar
        or    al, al
        jz    @@ExitAsmBlock

        mov   edx, Line
        mov   edi, Self
        xor   esi, esi
        mov   esi, [edi].fvWorkEnd
        mov   edi, [edi].fvWorkPtr
        sub   esi, edi
        mov   ecx, esi

      @@CheckForLF:
        cmp   Byte ptr [edi], 10
        jne   @@CheckForTargetLine
        inc   edi
        dec   ecx

      @@CheckForTargetLine:
        xor   eax, eax
        mov   LastLineLen, eax

        inc   LocalNL
        cmp   LocalNL, edx
        jne   @@SearchForNextCR

        sub   esi, ecx

        mov   edi, Self
        add   [edi].fvWorkOffset, esi
        add   [edi].fvWorkPtr, esi

      @@ExitAsmBlock:
        pop   esi
        pop   edi
      end;
      {$ELSE}
      asm
        {Note: the following is slightly complicated by the need
               to calculate the length of the last line scanned
               through. If we do hit the last line of all, this
               value will be used to calculate fvLastLineOffset.}
        xor ax,ax                      {Set LastLineLen to zero}
        mov LastLineLen,ax
        jmp @@PrepareForSearch

      @@LoadNextPage:
        add LastLineLen,ax                   {adjust LastLineLen}
        les di,Self                          {load self pointer}
        add es:[di].fvWorkPtr.Word[0],si     {adjust fvWorkPtr}
        add es:[di].fvWorkOffset.Word[0],si  {adjust fvWorkOffset}
        adc es:[di].fvWorkOffset.Word[2],0

        push es                     {push self pointer onto stack}
        push di
        call fvGetWorkingChar       {get next page buffer}
        or al, al                   {are we past the end of file?}
        jz @@ExitAsmBlock

      @@PrepareForSearch:
        mov dx,Line.Word[2]         {dx:bx = target line number}
        mov bx,Line.Word[0]
        les di,Self
        mov si,es:[di].fvWorkEnd    {si = fvWorkEnd}
        les di,es:[di].fvWorkPtr    {es:di = fvWorkPtr}
        sub si,di                   {get # of chars left in buffer}
        mov cx,si                   {save in si as well}

      @@SearchForNextCR:
        mov ax, cx                  {ax = chars searched so far}
        jcxz @@LoadNextPage         {load next page if cx is 0}
        cld                         {go forward}
        push cx                     {save cx (chars to search)}
        mov al,13                   {search for CR}
        repne scasb
        pop ax                      {ax = chars to search value}
        jne @@LoadNextPage          {load next page if no CR found}

        or cx,cx                    {any chars left in buffer?}
        jnz @@CheckForLF            {if so, go look for LF}

        add LastLineLen,ax                   {adjust LastLineLen}
        les di,Self                          {load self pointer}
        add es:[di].fvWorkPtr.Word[0],si     {adjust fvWorkPtr}
        add es:[di].fvWorkOffset.Word[0],si  {adjust fvWorkOffset}
        adc es:[di].fvWorkOffset.Word[2],0

        push es                     {push self pointer onto stack}
        push di
        call fvGetWorkingChar       {get next page buffer}
        or al, al                   {are we past the end of file?}
        jz @@ExitAsmBlock

        mov dx,Line.Word[2]         {dx:bx = target line number}
        mov bx,Line.Word[0]
        les di,Self
        mov si,es:[di].fvWorkEnd    {si = fvWorkEnd}
        les di,es:[di].fvWorkPtr    {es:di = fvWorkPtr}
        sub si,di                   {get # of chars left in buffer}
        mov cx,si                   {save in si as well}

      @@CheckForLF:
        cmp Byte ptr es:[di],10     {is next Char a LF?}
        jne @@CheckForTargetLine    {if not, continue}
        inc di                      {else, skip over it}
        dec cx

      @@CheckForTargetLine:
        xor ax,ax                   {Set LastLineLen to zero}
        mov LastLineLen,ax

        add LocalNL.Word[0],1       {increment LocalNL}
        adc LocalNL.Word[2],0
        cmp LocalNL.Word[0],bx      {is this the line we want?}
        jne @@SearchForNextCR       {  if not search for next CR}
        cmp LocalNL.Word[2],dx
        jne @@SearchForNextCR

        sub si,cx                   {got it: subtract remaining chars}

        les di,Self                          {load self pointer}
        add es:[di].fvWorkOffset.Word[0],si  {adjust fvWorkOffset}
        adc es:[di].fvWorkOffset.Word[2],0
        add es:[di].fvWorkPtr.Word[0],si     {adjust fvWorkPtr}

      @@ExitAsmBlock:
      end;
      {$ENDIF}

      {did we hit the end of the file?}
      if (fvWorkOffset >= FileSize) then begin
        {account for the length of the last line}
        Dec(fvWorkOffset, LastLineLen);
        {have we been here before?}
        if (fvLastLine < 0) then begin
          {no-save the line number and offset of the last line}
          fvLastLine := LocalNL;
          fvLastLineOffset := fvWorkOffset;
          vwChangeLineCount(Succ(fvLastLine));
        end;
      end;
    end else if (LineDelta < 0) then begin {do we need to search backwards for the line?}
      {move to the previous character}
      Dec(fvWorkOffset);
      {$IFDEF Win32}
      Dec(fvWorkPtr);
      {$ELSE}
      Dec(OS(fvWorkPtr).O);
      {$ENDIF}
      fvGetWorkingChar;

      {move back one more if it's a LF}
      if fvWorkPtr^ = ^J then begin
        Dec(fvWorkOffset);
        {$IFDEF Win32}
        Dec(fvWorkPtr);
        {$ELSE}
        Dec(OS(fvWorkPtr).O);
        {$ENDIF}
        fvGetWorkingChar;
      end;

      {move back one more if it's a CR}
      if fvWorkPtr^ = ^M then begin
        Dec(fvWorkOffset);
        {$IFDEF Win32}
        Dec(fvWorkPtr);
        {$ELSE}
        Dec(OS(fvWorkPtr).O);
        {$ENDIF}
        fvGetWorkingChar;
      end;

      {$IFDEF Win32}
      asm
        push edi
        push esi
        jmp  @@PrepareForSearch

      @@LoadPrevPage:
        {when this point is reached SI has the number of chars
         that have been searched through in the current buffer}
        mov   edi, Self
        sub   [edi].fvWorkPtr, esi
        sub   [edi].fvWorkOffset, esi

        cmp   [edi].fvWorkOffset, -1
        je    @@ExitAsmBlock

        cld
        mov   eax, edi
        call  fvGetWorkingChar      {get next page buffer}

      @@PrepareForSearch:
        mov   edx, Line
        mov   edi, Self
        mov   esi, [edi].fvWorkBeg
        mov   edi, [edi].fvWorkPtr
        mov   ecx, edi
        sub   ecx, esi
        inc   ecx
        mov   esi, ecx
        std

      @@SearchForPrevCR:
        mov   al, 13
        repne scasb
        jne   @@LoadPrevPage
        sub   LocalNL, 1
        cmp   LocalNL, edx
        jne   @@SearchForPrevCR
        sub   esi, ecx
        dec   esi

        mov   edi, Self
        sub   [edi].fvWorkOffset, esi
        sub   [edi].fvWorkPtr, esi

      @@ExitAsmBlock:
        cld
        pop  esi
        pop  edi
      end;
      {$ELSE}
      asm
        jmp @@PrepareForSearch

      @@LoadPrevPage:
        {when this point is reached SI has the number of chars
         that have been searched through in the current buffer}
        les di,Self                          {load self pointer}
        sub es:[di].fvWorkPtr.Word[0],si     {adjust fvWorkPtr}
        sub es:[di].fvWorkOffset.Word[0],si  {adjust fvWorkOffset}
        sbb es:[di].fvWorkOffset.Word[2],0

        mov ax,es:[di].fvWorkOffset.Word[2]  {at the start of the file?}
        cmp ax,$FFFF
        je @@ExitAsmBlock

        cld
        push es                    {push self pointer onto stack}
        push di
        call fvGetWorkingChar      {get next page buffer}

      @@PrepareForSearch:
        mov dx,Line.Word[2]        {dx:bx = target line number}
        mov bx,Line.Word[0]
        les di,Self
        mov si,es:[di].fvWorkBeg   {si = fvWorkBeg}
        les di,es:[di].fvWorkPtr   {es:di = fvWorkPtr}
        mov cx,di                  {calc # of chars left in buffer}
        sub cx,si
        inc cx
        mov si,cx                  {save the # of chars we're searching}
        std                        {go backward}

      @@SearchForPrevCR:
        mov al,13                  {search for CR in buffer}
        repne scasb
        jne @@LoadPrevPage         {none found: go load prev page}
        sub LocalNL.Word[0],1      {decrement LocalNL}
        sbb LocalNL.Word[2],0
        cmp LocalNL.Word[0],bx     {is this the line we want?}
        jne @@SearchForPrevCR      {  if not search for the prev CR}
        cmp LocalNL.Word[2],dx
        jne @@SearchForPrevCR
        sub si,cx                  {yes, calculate offset in buffer}
        dec si

        les di,Self                          {load self pointer}
        sub es:[di].fvWorkOffset.Word[0],si  {adjust fvWorkOffset}
        sbb es:[di].fvWorkOffset.Word[2],0
        sub es:[di].fvWorkPtr.Word[0],si     {adjust fvWorkPtr}

      @@ExitAsmBlock:
      end;
      {$ENDIF}

      {Point to next character after end of previous line}
      Inc(fvWorkOffset);
      {$IFDEF Win32}
      Inc(fvWorkPtr);
      {$ELSE}
      Inc(OS(fvWorkPtr).O);
      {$ENDIF}
      if fvGetWorkingChar then
        if fvWorkPtr^ = ^J then begin
          Inc(fvWorkOffset);
          {$IFDEF Win32}
          Inc(fvWorkPtr);
          {$ELSE}
          Inc(OS(fvWorkPtr).O);
          {$ENDIF}
        end;
    end;

    fvNewLine := LocalNL;
    fvNewOffset := fvWorkOffset;

    if (fvNewLine = CaretActualPos.Line) then begin
      fvCurOffset := fvNewOffset;
      fvCurLine := fvNewLine;
    end;

    {is this the last line in the file that we know about?}
    if (fvLastLine < 0) then begin
      if (fvNewLine > fvKnownLine) then begin
        fvKnownLine := fvNewLine;
        fvKnownOffset := fvNewOffset;
      end;
    end else if (OldNewLine <> fvNewLine) then begin
      {have we moved off the previous new line?}
      fvKnownLine := OldNewLine;
      fvKnownOffset := OldNewLineOfs;
    end;

    vwShowWaitCursor(False);
  end;

  fvNewWorkingSet;
end;

procedure TOvcCustomFileViewer.fvInitObjectFields;
var
  I : Word;
begin
  FFileSize := 0;

  fvLnBuf := nil;
  fvPages := nil;

  try {except}
    {allocate the line buffer}
    GetMem(fvLnBuf, LineBufSize);

    {allocate page buffers}
    fvMaxPage := Pred(FBufferPageCount);
    fvPageArraySize := FBufferPageCount*sizeof(TfvPageRec);
    GetMem(fvPages, fvPageArraySize);
    FillChar(fvPages^, fvPageArraySize, 0);
    for i := 0 to fvMaxPage do begin
      GetMem(fvPages^[i].Buffer, PageBufSize);
      fvPages^[i].BlockNum := BlockUnused;
    end;

  except
    {the only problems should be memory ones}
    on EOutOfMemory do begin
      {free everything we've managed to allocate}
      fvDeallocateBuffers;
      {reraise the exception}
      raise
    end;
  end;{except}
end;

procedure TOvcCustomFileViewer.fvInitFileFields;
begin
  fvLineInBuf := -1;
  fvLnBufLen := 0;

  fvNewLine := 0;
  fvNewOffset := 0;

  fvCurLine := -1;
  fvCurOffset := 0;

  fvLastLine := -1;
  fvLastLine2 := -1;
  fvLastLineOffset := 0;

  fvKnownLine := 0;
  fvKnownOffset := 0;

  if (FFileSize <> 0) then
    if InHexMode then
      fvLastLine := (Pred(FileSize) div 16)
    else
      fvLastLine2 := (Pred(FileSize) div 16);

  fvTicks := 0;

  fvWorkOffset := 0;
  fvWorkBlk := 0;
  fvWorkBeg := MaxInt;
  fvWorkEnd := 0;
  fvWorkPtr := nil;
end;

procedure TOvcCustomFileViewer.fvNewWorkingSet;
begin
  fvWorkOffset := fvNewOffset;
  fvWorkPtr := nil;
  fvWorkBeg := MaxInt;
  fvWorkEnd := 0;
end;

function TOvcCustomFileViewer.GetFileName : string;
begin
  if Assigned(FFileName) then
    Result := FFileName^
  else
    Result := '';
end;

function TOvcCustomFileViewer.GetLinePtr(LineNum : LongInt; var Len : integer) : PAnsiChar;
begin
  {For default return a null string}
  Result := NullString;
  Len := 0;

  {if we haven't read the file yet, or it's empty, exit}
  if (FileSize = 0) then
    Exit;

  {if the line number is out of range then exit}
  if (LineNum < 0) or ((fvLastLine >= 0) and (LineNum > fvLastLine)) then
    Exit;

  {is this a line whose contents we already know?}
  if (LineNum = fvLineInBuf) then begin
    Result := fvLnBuf;
    Len := fvLnBufLen;
    Exit;
  end;

  if InHexMode then
    Result := fvGetLineInHex(LineNum, Len)
  else
    Result := fvGetLineAsText(LineNum, Len);
end;

function TOvcCustomFileViewer.Search(const S : string; Options : TSearchOptionSet) : Boolean;
  {-search for a string returning True if found}
var
  PatternLen   : integer;
  PatternPos   : integer;
  SearchOffset : LongInt;
  LastOffset   : LongInt;
  MatchString  : PAnsiChar;
  MatchCase    : Boolean;
  Found        : Boolean;
  C            : Char;
  FirstCh      : Char;
  Range        : TOvcRange;
  Map          : array [#0..#255] of Char;
  Pattern      : array[0..255] of Char;
begin
  {we need special handling only in hex mode}
  if not InHexMode then begin
    Result := inherited Search(S, Options);
    Exit;
  end;

  {get copy of search string}
  StrPCopy(Pattern, S);

  {assume failure}
  Result := False;

  {get the pattern length}
  PatternLen := StrLen(Pattern);
  if (PatternLen = 0) then
    Exit;

  {get a copy of the search string in a new buffer}
  MatchString := StrNew(Pattern);

  {get start position of search}
  if soGlobal in Options then begin
    if soBackward in Options then
      SearchOffset := Pred(FileSize)
    else
      SearchOffset := 0
  end else begin
    SearchOffset := CaretActualPos.Line * 16;
    {start at next or previous line}
    if soBackward in Options then
      dec(SearchOffset)
    else
      inc(SearchOffset, 16)
  end;

  {if we're not matching case then uppercase the pattern}
  MatchCase := soMatchCase in Options;
  if not MatchCase then
    AnsiUpper(MatchString);

  {initialize conversion map}
  for C := #0 to #255 do
    Map[C] := C;
  if not MatchCase then
    AnsiUpperBuff(@Map[#33], 256-33);

  if soBackward in Options then
    PatternPos := Pred(PatternLen)
  else
    PatternPos := 0;
  FirstCh := MatchString[PatternPos];

  Found := False;

  fvWorkOffset := SearchOffset;
  fvWorkPtr := nil;
  fvWorkBeg := MaxInt;
  fvWorkEnd := 0;

  if soBackward in Options then begin
    {get the last offset we need to check}
    LastOffset := Pred(PatternLen);

    {this could take a while}
    if Abs(SearchOffset-LastOffset) > 1000 then
      vwShowWaitCursor(True);

    {continue searching until found or we hit the last offset}
    while (not Found) and (fvWorkOffset >= LastOffset) do begin
      {get the previous character}
      {$IFDEF Win32}
      if (Integer(fvWorkPtr) < fvWorkBeg) or (Cardinal(fvWorkPtr) >= Cardinal(fvWorkEnd)) then {!!.D4}
      {$ELSE}
      if (OS(fvWorkPtr).O < fvWorkBeg) or (OS(fvWorkPtr).O >= fvWorkEnd) then
      {$ENDIF}
        fvGetWorkingChar;
      C := Map[fvWorkPtr^];

      {do we match on the first character?}
      if (C = FirstCh) then begin
        {for pattern strings longer than 1 Char, check the other chars}
        if (PatternLen > 1) then
          repeat
            dec(PatternPos);
            dec(fvWorkOffset);
            {$IFDEF Win32}
            dec(fvWorkPtr);
            if (Integer(fvWorkPtr) < fvWorkBeg) or (Cardinal(fvWorkPtr) >= Cardinal(fvWorkEnd)) then {!!.D4}
            {$ELSE}
            dec(OS(fvWorkPtr).O);
            if (OS(fvWorkPtr).O < fvWorkBeg) or (OS(fvWorkPtr).O >= fvWorkEnd) then
            {$ENDIF}
              fvGetWorkingChar;
            C := Map[fvWorkPtr^];
          until (PatternPos = 0) or (C <> MatchString[PatternPos]);
        {did we get a full match?}
        if (PatternPos = 0) and (C = MatchString[PatternPos]) then
          Found := True
        else begin {no match}
          {go back to character before the end}
          for PatternPos := PatternPos+1 to PatternLen-2 do begin
            inc(fvWorkOffset);
            {$IFDEF Win32}
            inc(fvWorkPtr);
            if (Cardinal(fvWorkPtr) >= Cardinal(fvWorkEnd)) then       {!!.D4}
              fvGetWorkingChar;
            {$ELSE}
            inc(OS(fvWorkPtr).O);
            if (OS(fvWorkPtr).O >= fvWorkEnd) then
              fvGetWorkingChar;
            {$ENDIF}
          end;
          PatternPos := PatternLen-1;
        end;
      end else begin
        dec(fvWorkOffset);
        {$IFDEF Win32}
        dec(fvWorkPtr);
        {$ELSE}
        dec(OS(fvWorkPtr).O);
        {$ENDIF}
      end;
    end;
  end else begin {search forwards}
    {get the last offset we need to check}
    LastOffset := FileSize - PatternLen;

    {this could take a while}
    if Abs(SearchOffset-LastOffset) > 1000 then
      vwShowWaitCursor(True);

    {continue searching until found or we hit the last offset}
    while (not Found) and (fvWorkOffset <= LastOffset) do begin
      {get the next character}
      {$IFDEF Win32}
      if (Cardinal(fvWorkPtr) >= Cardinal(fvWorkEnd)) then             {!!.D4}
        fvGetWorkingChar;
      {$ELSE}
      if (OS(fvWorkPtr).O >= fvWorkEnd) then
        fvGetWorkingChar;
      {$ENDIF}
      C := Map[fvWorkPtr^];

      {do we match on the first character?}
      if (C = FirstCh) then begin
        {for pattern strings longer than 1 Char, check the other chars}
        if (PatternLen > 1) then
          repeat
            inc(PatternPos);
            inc(fvWorkOffset);
            {$IFDEF Win32}
            inc(fvWorkPtr);
            if (Cardinal(fvWorkPtr) >= Cardinal(fvWorkEnd)) then       {!!.D4}
            {$ELSE}
            inc(OS(fvWorkPtr).O);
            if (OS(fvWorkPtr).O >= fvWorkEnd) then
            {$ENDIF}
              fvGetWorkingChar;
            C := Map[fvWorkPtr^];
          until (PatternPos = Pred(PatternLen)) or
                (C <> MatchString[PatternPos]);
        {did we get a full match?}
        if (PatternPos = Pred(PatternLen)) and (C = MatchString[PatternPos]) then
          Found := True
        else begin {no match}
          {go back to character before the end}
          if (PatternPos > 1) then
            for PatternPos := PatternPos downto 2 do begin
              dec(fvWorkOffset);
              {$IFDEF Win32}
              dec(fvWorkPtr);
              if (Integer(fvWorkPtr) < fvWorkBeg) then
              {$ELSE}
              dec(OS(fvWorkPtr).O);
              if (OS(fvWorkPtr).O < fvWorkBeg) then
              {$ENDIF}
                fvGetWorkingChar;
            end;
          PatternPos := 0;
        end;
      end else begin
        inc(fvWorkOffset);
        {$IFDEF Win32}
        inc(fvWorkPtr);
        {$ELSE}
        inc(OS(fvWorkPtr).O);
        {$ENDIF}
      end;
    end;
  end;

  vwShowWaitCursor(False);

  {if found, move caret to right place and show selection}
  if Found then begin
    if soBackward in Options then
      SearchOffset := fvWorkOffset
    else
      SearchOffset := fvWorkOffset - Pred(PatternLen);
    with Range.Start do begin
      Line := SearchOffset div 16;
      Col := (SearchOffset mod 16) + (75 - 16);
    end;
    inc(SearchOffset, Pred(PatternLen));
    with Range.Stop do begin
      Line := SearchOffset div 16;
      Col := Succ((SearchOffset mod 16) + (75 - 16));
    end;
    SetSelection(Range.Start.Line, Range.Start.Col,
                 Range.Stop.Line, Range.Stop.Col, not (soBackward in Options));
  end;

  Result := Found;
  StrDispose(MatchString);
end;

procedure TOvcCustomFileViewer.SetBufferPageCount(BPC : integer);
var
  i            : integer;
  LimitedBPC   : integer;
  NewPageArray : PfvPageArray;
  NewPageArraySize : integer;
  TempBuf      : PfvBufferArray;
  FoundIt      : Boolean;
begin
  LimitedBPC := MinI(MaxI(BPC, MinPageCount), MaxPageCount);
  if (LimitedBPC = FBufferPageCount) then
    Exit;

  {Does the user want MORE buffers?}
  NewPageArray := nil;
  NewPageArraySize := LimitedBPC * sizeof(TfvPageRec);
  if (LimitedBPC > FBufferPageCount) then
    try {except}
      {first allocate a new page array}
      GetMem(NewPageArray, NewPageArraySize);
      FillChar(NewPageArray^, NewPageArraySize, 0);

      {allocate the new pages}
      for i := Succ(fvMaxPage) to Pred(LimitedBPC) do begin
        GetMem(NewPageArray^[i].Buffer, PageBufSize);
        NewPageArray^[i].BlockNum := BlockUnused;
      end;

      {move everything over to our object fields}
      Move(fvPages^, NewPageArray^, fvPageArraySize);
      FreeMem(fvPages, fvPageArraySize);
      fvPages := NewPageArray;
      fvPageArraySize := NewPageArraySize;
      fvMaxPage := Pred(LimitedBPC);
      FBufferPageCount := LimitedBPC;

    except
      on EOutOfMemory do
        {free everything we've allocated, do not reraise}
        if Assigned(NewPageArray) then begin
          for i := Pred(LimitedBPC) downto Succ(fvMaxPage) do
            if Assigned(NewPageArray^[i].Buffer) then
              FreeMem(NewPageArray^[i].Buffer, PageBufSize);
            FreeMem(NewPageArray, NewPageArraySize);
        end;
    end {try}

  {Otherwise, the user wants to REDUCE the number of buffers}
  else
    try {except}
      {first allocate a new page array}
      NewPageArraySize := LimitedBPC * sizeof(TfvPageRec);
      GetMem(NewPageArray, NewPageArraySize);

      {make sure that the working page will be in the smaller page array}
      FoundIt := False;
      for i := LimitedBPC to fvMaxPage do
        with fvPages^[i] do
          if (BlockNum = fvWorkBlk) then begin
            Foundit := True;
            Break;
          end;
      if FoundIt then begin
        {swap over page 0 and page i}
        TempBuf := fvPages^[0].Buffer;
        fvPages^[0] := fvPages^[i];
        fvPages^[i].Buffer := TempBuf;
      end;

      {free up pages that are no longer required}
      for i := LimitedBPC to fvMaxPage do
        FreeMem(fvPages^[i].Buffer, PageBufSize);

      {move everything over to our object fields}
      Move(fvPages^, NewPageArray^, NewPageArraySize);
      FreeMem(fvPages, fvPageArraySize);
      fvPages := NewPageArray;
      fvPageArraySize := NewPageArraySize;
      fvMaxPage := Pred(LimitedBPC);
      FBufferPageCount := LimitedBPC;

    except
      on EOutOfMemory do begin
        {do nothing, just catch the exception}
      end;
    end;{try}
end;

procedure TOvcCustomFileViewer.SetFileName(const N : string);
var
  WasOpen : Boolean;
begin
  WasOpen := IsOpen;
  IsOpen := False;

  AssignStr(FFileName, UpperCase(N));

  IsOpen := WasOpen;
end;

procedure TOvcCustomFileViewer.SetFilterChars(FC : Boolean);
begin
  if (FC <> FFilterChars) then begin
    FFilterChars := FC;
    Invalidate;
  end;
end;

procedure TOvcCustomFileViewer.SetInHexMode(HM : Boolean);
var
  TempLine : LongInt;
begin
  if (HM <> FInHexMode) then begin
    FInHexMode := HM;

    TempLine := fvLastLine2;
    fvLastLine2 := fvLastLine;
    fvLastLine := TempLine;

    fvLineInBuf := -1;

    if HandleAllocated then
      if (fvLastLine < 0) then
        LineCount := MaxLongInt
      else
        LineCount := Succ(fvLastLine);
  end;
end;

procedure TOvcCustomFileViewer.SetIsOpen(OpenIt : Boolean);
var
  i         : integer;
  FileMode  : Word;
  ErrorCode : integer;
begin
  {Do we have anything to do?}
  if (OpenIt = FIsOpen) then
    Exit;

  {If we have to close the file, do so and exit}
  if not OpenIt then begin
    FIsOpen := False;
    FFileSize := 0;
    LineCount := 0;
    FileClose(vwFile);
    Exit;
  end;

  {Otherwise, prepare to open it}
  if (FileName = '') then
    Exit;

  FFileSize := 0;

  try {except}
    {display hourglass}
    vwShowWaitCursor(True);

    try {finally}
      {open the file}
      FileMode := fmOpenRead or fmShareDenyWrite;
      vwFile := FileOpen(FileName, FileMode);
      if (vwFile < 0) then
        begin
          {$IFDEF Win32}
          ErrorCode := GetLastError;
          {$ELSE}
          ErrorCode := -vwFile;
          {$ENDIF}
          vwFile := 0;
          RaiseIOException(ErrorCode);
        end;
      FIsOpen := True;
      FFileSize := FileSeek(vwFile, 0, 2);
      if (FFileSize < 0) then
        begin
          {$IFDEF Win32}
          ErrorCode := GetLastError;
          {$ELSE}
          ErrorCode := -1;
          {$ENDIF}
          RaiseIOException(ErrorCode);
        end;

      fvInitFileFields;

      {mark all the buffer pages as available}
      for i := fvMaxPage downto 0 do
        with fvPages^[i] do begin
          BlockNum := BlockUnused;
          ByteCount := 0;
          LastUsed := 0;
        end;

      {reset the line count}
      if (fvLastLine < 0) then
        LineCount := MaxLongInt
      else
        LineCount := Succ(fvLastLine);

    finally
      {restore original cursor}
      vwShowWaitCursor(False);
    end;{try}
  except
    {on any exception close the file, and reraise}
    if FIsOpen then begin
      {note: as Close could raise another exception, set all
             relevant object fields first}
      FIsOpen := False;
      FFileSize := 0;
      FileClose(vwFile);
    end;

    if not (csDesigning in ComponentState) then
      raise;
  end;{try}
end;



end.