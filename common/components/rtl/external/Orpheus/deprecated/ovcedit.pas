{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}
{$R-} {Range-Checking}
{$S-} {Stack-Overflow Checking}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}
{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCEDIT.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcEdit;

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF} MMSystem, {!!.13}
  Classes, Controls, Forms, Graphics, Menus, Messages, StdCtrls, SysUtils,
  OvcBase, OvcCaret, OvcColor, OvcConst, OvcCmd, OvcData,
  OvcEditN, OvcEditU, OvcExcpt, OvcFxFnt, OvcMisc, OvcStr,
  OvcEditP;

const
  MaxSmallInt         = High(SmallInt);

  {default property values}
  edDefAutoIndent       = False;           {true to perform auto indentation}
  edDefBackupExt        = 'BAK';           {extension used for backup files}
  edDefBorderStyle      = bsSingle;        {component border style}
  edDefCtl3D            = True;            {true to default to use ctl3d}
  edDefHeight           = 150;             {default component height}
  edDefHighlightBack    = clHighlight;     {default highlight backgrond color}
  edDefHighlightText    = clHighlightText; {default highlight text color}
  edDefHideSelection    = True;            {true to hide selection by default}
  edDefInsertMode       = True;            {default to start in insert mode}
  edDefIsOpen           = False;           {default to not open the file}
  edDefLeftMargin       = 15;              {width of left margin}
  edDefMakeBackup       = False;           {don't make backups by default}
  edDefMaxBytes         = MaxLongInt;      {default maximum characters in editor}
  edDefParaLimit        = MaxLongInt;      {default maximum paragraphs in editor}
  edDefParentColor      = False;           {default to not use parent}
  edDefParentCtl3D      = True;
  edDefParaLengthLimit  = MaxSmallInt;
  edDefReadOnly         = False;
  edDefRightMargin      = 5;               {width of right margin}
  edDefScrollBars       = ssBoth;
  edDefScrollBarsAlways = False;
  edDefScrollPastEnd    = False;
  edDefShowBookmarks    = True;
  edDefTabSize          = 8;
  edDefTabStop          = True;
  edDefTabType          = ttReal;
  edDefTrimWhiteSpace   = True;
  edDefUndoBufferSize   = 8*1024;
  edDefWantEnter        = True;
  edDefWantTab          = False;
  edDefWidth            = 200;
  edDefWordWrap         = False;
  edDefWordDelimiters   = ^I#39#13#10' ,./?;:`"<>[]{}-=\+|()%@&^$#!~*';
  edDefWrapAtLeft       = True;
  edDefWrapColumn       = 80;
  edDefWrapToWindow     = False;

type
  TEditorErrorEvent =
    procedure(Sender : TObject; var ErrorCode : Word)
    of object;
    {-event to provide alternate handling of errors}

  TEditorDrawLineEvent =
    procedure(Sender : TObject; EditorCanvas : TCanvas; Rect : TRect;
              S : PAnsiChar; Len, Line, Pos, Count,
              HBLine, HBCol, HELine, HECol : Integer;
              var WasDrawn : Boolean)
    of object;
    {-event to provide owner-draw}

  TOvcCustomEditor = class(TOvcEditBase)
  {.Z+}
  protected {private}
    FAutoIndent       : Boolean;      {true to do auto indentation}
    FBorderStyle      : TBorderStyle; {border style to use}
    FByteLimit        : LongInt;      {max characters in editor}
    FFixedFont        : TOvcFixedFont;{fixed font}
    FHideSelection    : Boolean;      {true to hide selection with focus loss}
    FHighlightColors  : TOvcColors;   {background and text highlight colors}
    FInsertMode       : Boolean;      {if True, we're in insert mode}
    FLeftMargin       : Integer;      {width of left margin}
    FParaLengthLimit  : Integer;      {max paragraph size}
    FParaLimit        : LongInt;      {max number of paragraphs}
    FReadOnly         : Boolean;      {true if read only}
    FRightMargin      : Integer;      {width of right margin}
    FScrollBars       : TScrollStyle; {scroll bar style to use}
    FScrollBarsAlways : Boolean;      {true to force scroll bars}
    FScrollPastEnd    : Boolean;      {true to allow scroll past end}
    FShowBookmarks    : Boolean;      {true to display bookmarks}
    FTabSize          : Byte;         {tab size}
    FTabType          : TTabType;     {real, smart, or fixed tabs}
    FTrimWhiteSpace   : Boolean;      {remove white space during append}
    FUndoBufferSize   : Word;         {undo buffer size}
    FWantEnter        : Boolean;      {true to capture enter key}
    FWantTab          : Boolean;      {true to capture tab key}
    FWordDelimiters   : string;       {characters that seperate words}
    FWordWrap         : Boolean;      {true if in word wrap mode}
    FWrapAtLeft       : Boolean;      {true to wrap caret at left}
    FWrapColumn       : Integer;      {column to word wrap at}
    FWrapToWindow     : Boolean;      {true to wrap at control edge}

    FOnChange         : TNotifyEvent;                                  {!!.10}
    FOnDrawLine       : TEditorDrawLineEvent;
    FOnError          : TEditorErrorEvent;
    FOnShowStatus     : TShowStatusEvent;
    FOnTopLineChanged : TTopLineChangedEvent;
    FOnUserCommand    : TUserCommandEvent;

    {internal variables}
    edAnchor          : TMarker;    {anchor for highlighting}
    edBMGlyphs        : TBitMap;    {marker glyphs}
    edCapture         : Boolean;    {if True, we have the capture}
    edCaret           : TOvcCaretPair; {our carets}
    edCols            : Integer;    {number of columns displayable in window}
    edColWid          : Integer;    {width of one column}
    edCurCol          : Integer;    {current column in edCurLine}
    edCurLine         : LongInt;    {current line}
    edCurPara         : LongInt;    {current paragraph}
    edDivisor         : LongInt;    {divisor for scroll bars}
    edHDelta          : Integer;    {horizontal scroll delta}
    edHltBgn          : TMarker;    {starting pos for highlight}
    edHltBgnL         : TOvcTextPos;{starting pos for highlight - Line,Col}
    edHltEnd          : TMarker;    {ending pos for highlight}
    edHltEndL         : TOvcTextPos;{ending pos for highlight - Line,Col}
    edHScroll         : Boolean;    {if True, we have a horizontal scroll bar}
    edHSMax           : Integer;    {max value for horizontal scroll bar}
    edLinePos         : Integer;    {offset into edCurPara for start of edCurLine}
    edParas           : TParaList;  {list of paragraphs}
    edPendingHSP      : Boolean;    {horizontal scroll position pending}
    edPendingVSP      : Boolean;    {vertical scroll position pending}
    edPendingVSR      : Boolean;    {vertical scroll pending}
    edPrev            : TOvcCustomEditor; {previous attached editor}
    edRedrawPending   : Boolean;    {redraw pending}
    edRowHt           : Integer;    {height of one row}
    edRows            : Integer;    {number of rows in window}
    edSelCursor       : hCursor;    {selection cursor}
    edSelCursorOn     : Boolean;    {is selection cursor in use?}
    edTopLine         : LongInt;    {line at top of window}
    edTopPara         : LongInt;    {paragraph at top of window}
    edTopPos          : Integer;    {offset into edTopPara for start of edTopLine}
    edVScroll         : Boolean;    {if True, we have a vertical scroll bar}
    edVSMax           : LongInt;    {max value for vertical scroll bar}
    edSuppressChar    : Boolean;    {suppress next character}

    {property methods}
    function GetFirstEditor : TOvcCustomEditor;
      {-return a pointer to the first attached editor}
    function GetInsCaretType : TOvcCaret;
      {-return the current caret type}
    function GetOvrCaretType : TOvcCaret;
      {-return the current caret type}
    function GetLeftColumn : Integer;
      {-return the left-most visible column number}
    function GetLineCount : LongInt;
      {-get the total number of lines}
    function GetLineLength(LineNum : LongInt) : Integer;
      {-get the length of the line LineNum}
    function GetModified : Boolean;
      {-get the value of the modified flag}
    function GetNextEditor : TOvcCustomEditor;
      {-return a pointer to the next editor}
    function GetParaPointer(ParaNum : LongInt) : PAnsiChar;
      {-get a pointer to the specified paragraph}
    function GetParaLength(ParaNum : LongInt) : Integer;
      {-get the length of the paragraph ParaNum}
    function GetPrevEditor : TOvcCustomEditor;
      {-return a pointer to the previous editor}
    function GetStringLine(LineNum : LongInt) : string;
      {-return the text for the specified line}
    function GetTopLine : LongInt;
      {-get the number of the line at the top of the window}
    function GetVisibleColumns : Integer;
      {-get the number of visible columns}
    function GetVisibleRows : Integer;
      {-get the number of visible rows}
    procedure SetBorderStyle(const Value : TBorderStyle);
      {-set the style used for the border}
    procedure SetFixedFont(Value : TOvcFixedFont);
      {-set the fixed font}
    procedure SetHideSelection(Value : Boolean);
      {-set hide selection flag}
    procedure SetInsCaretType(const Value : TOvcCaret);
      {-set the type of caret to use}
    procedure SetInsertMode(Value : Boolean);
      {-turn insert mode on or off}
    procedure SetLeftMargin(Value : Integer);
      {-set the width of the left margin}
    procedure SetModified(Value : Boolean);
      {-change the modified flag}
    procedure SetOvrCaretType(const Value : TOvcCaret);
      {-set the type of caret to use}
    procedure SetParaLengthLimit(Value : Integer);
      {-set a limit on the length of a paragraph}
    procedure SetParaLimit(Value : LongInt);
      {-set a limit on the total number of paragraphs}
    procedure SetRightMargin(Value : Integer);
      {-set the width of the right margin}
    procedure SetScrollBars(Value : TScrollStyle);
      {-set use of vertical and horizontal scroll bars}
    procedure SetScrollBarsAlways(Value : Boolean);
      {-set use of scroll bars always}
    procedure SetScrollPastEnd(Value : Boolean);
      {-set option that allows scrolling past end of text}
    procedure SetShowBookmarks(Value : Boolean);
      {-set option to display bookmarks in left margin}
    procedure SetTabSize(Value : Byte);
      {-set the distance between tab stops}
    procedure SetTabType(Value : TTabType);
      {-set the tab type}
    procedure SetTopLine(Value : LongInt);
      {-set the line to show at the top of the window}
    procedure SetUndoBufferSize(Value : Word);
      {-set the size of the undo buffer. This destroys the existing buffer}
    procedure SetWordDelimiters(Value : string);
      {set the characters that delimit words}
    procedure SetWordWrap(Value : Boolean);
      {-turn word wrap on or off}
    procedure SetWrapAtLeft(Value : Boolean);
      {-set wrap at left option}
    procedure SetWrapColumn(Value : Integer);
      {-set the column for word wrap}
    procedure SetWrapToWindow(Value : Boolean);
      {-set the option to automatically adjust the column for word wrap}

    {internal methods}
    procedure edAdjustWrapColumn;
    procedure edBackspace;
    procedure edCalcRowColInfo;
    function edCaretInWindow(var Col : Word) : Boolean;
    procedure edCaretLeft(Shift : Boolean);
    procedure edCaretRight(Shift : Boolean);
    procedure edChangeTopLine(Value : LongInt);
    procedure edColorChanged(AColor : TObject);
    procedure edDeleteLine;
    procedure edDeleteSelection;
    procedure edDeleteToBeginning;
    procedure edDeleteToEnd;
    procedure edDeleteWord;
    procedure edDetach;
    procedure edDoTab;
    procedure edFixedFontChanged(Sender : TObject);
    function edGetEditLine(LineNum : LongInt; Buf : PAnsiChar; BufLen : Word) : Integer;
    function  edGetIndentLevel(N : LongInt; Col : Integer) : Integer;
    procedure edGetMousePos(var Line : LongInt; var Col : Integer);
    function  edHaveHighlight : Boolean;
    procedure edHScrollPrim(Delta : Integer);
    procedure edInsertChar(Ch : AnsiChar);
    function edInsertTextAtCaret(P : PAnsiChar) : Word;
    function edIsWordDelim(Ch : AnsiChar) : Boolean;
    function edIsStringHighlighted(S : PAnsiChar; MatchCase : Boolean) : Boolean;
    procedure edMoveCaret(HDelta : Integer; VDelta : LongInt; MVP, DragH : Boolean);
    procedure edMoveCaretPrim(HDelta : Integer; VDelta : LongInt; MVP, DragH, AbsCol : Boolean);
    procedure edMoveCaretTo(Line : LongInt; Col : Integer; DragH : Boolean);
    procedure edMoveCaretToPP(Para : LongInt; Pos : Integer; DragH : Boolean);
    procedure edMoveToEndOfLine(Shift : Boolean);
    procedure edNewLine(BreakP, Follow : Boolean);
    procedure edPositionCaret(Col : Word);
    procedure edReadBookmarkGlyphs;
    procedure edReadMargin(Reader : TReader);
    procedure edRecreateWnd;                                           {!!.13}
    procedure edRedraw(Now : Boolean);
    procedure edRefreshLines(Start, Stop : LongInt);
    function  edReplaceSelection(P : PAnsiChar) : Word;
    procedure edResetHighlight(Refresh : Boolean);
    function edSearchReplace(FS, RS : PAnsiChar; Options : TSearchOptionSet) : LongInt;
    procedure edSetCaretSize;
    procedure edSetHScrollPos;
    procedure edSetHScrollRange;
    procedure edSetSelectionPP(Para1 : LongInt; Pos1 : Integer;
                               Para2 : LongInt; Pos2 : Integer;
                               CaretAtEnd : Boolean);
    procedure edSetSelPrim(Para1 : LongInt; Pos1 : Integer;
                           Para2 : LongInt; Pos2 : Integer);
    procedure edSetVScrollPos;
    procedure edSetVScrollRange;
    procedure edUpdateVScrollRange;
    procedure edUpdateVScrollPos;
    procedure edUpdateHighlight(Refresh : Boolean);
    procedure edUpdateHScrollPos;
    procedure edVScrollPrim(Delta : LongInt);
    procedure edWordLeft(Shift : Boolean);
    procedure edWordRight(Shift : Boolean);

    {routines for updating attached windows}
    procedure edUpdateOnDeletedParaPrim(N : LongInt; Current : Boolean);
    procedure edUpdateOnDeletedTextPrim(N : LongInt; Pos, Count : Integer;
                                      Current : Boolean);
    procedure edUpdateOnInsertedParaPrim(N : LongInt; Pos, Indent : Integer;
                                         Current : Boolean);
    procedure edUpdateOnInsertedTextPrim(N : LongInt; Pos, Count : Integer;
                                         Current : Boolean);
    procedure edUpdateOnJoinedParasPrim(N : LongInt; Pos : Integer; Current : Boolean);

    {VCL control methods}
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;
    procedure CMDialogChar(var Msg : TCMDialogChar);
      message CM_DIALOGCHAR;
    procedure CMFontChanged(var Msg : TMessage);
      message CM_FONTCHANGED;

    {private message handling methods}
    procedure OMShowStatus(var Msg : TOMShowStatus);
      message om_ShowStatus;

    {windows message handling methods}
    procedure WMChar(var Msg : TWMChar);
      message WM_CHAR;
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
      message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode);
      message WM_GETDLGCODE;
    procedure WMHScroll(var Msg: TWMHScroll);
      message WM_HSCROLL;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMLButtonDblClk(var Msg : TWMLButtonDblClk);
      message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg : TWMLButtonUp);
      message WM_LBUTTONUP;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMNCHitTest(var Msg : TWMNCHitTest);
      message WM_NCHITTEST;
    procedure WMSetCursor(var Msg : TWMSetCursor);
      message WM_SETCURSOR;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMVScroll(var Msg: TWMVScroll);
      message WM_VSCROLL;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;
    procedure WMSysKeyDown(var Msg : TWMSysKeyDown);
      message WM_SYSKEYDOWN;

  protected
    {VCL methods}
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure DefineProperties(Filer : TFiler);
      override;
    procedure Paint;
      override;

    procedure DoOnChange;
      dynamic;
      {-perform notification of an editro change}
    function DoOnDrawLine(EditorCanvas : TCanvas; Rect : TRect;
             S : PAnsiChar; Len, Line, Pos, Count,
             HBLine, HBCol, HELine, HECol : Integer) : Boolean;
      virtual;
      {-call the OnDrawLine method, if assigned}
    procedure DoOnError(ErrorCode : Word);
      dynamic;
      {-call the OnError method, if assigned, otherwise raise exception}
    procedure DoOnShowStatus(LineNum : LongInt; ColNum : Word);
      dynamic;
      {-call the OnShowStatus mehtod, if assigned}
    procedure DoOnTopLineChanged(Line : LongInt);
      dynamic;
      {-perform notification of a top line changed}
    procedure DoOnUserCommand(Command : Word);
      dynamic;
      {-perform notification of a user command}
    procedure edAddSampleParas;
      dynamic;
      {-add sample text, if designing}
    procedure edScrollPrim(HDelta : Integer; VDelta : LongInt);
      dynamic;                                                         {!!.11}

    {virtual property mentods}
    function GetReadOnly : Boolean;
      virtual;
      {-return read-only status}
    procedure SetByteLimit(Value : LongInt);
      virtual;
      {-set a limit on the total number of bytes}
  {.Z-}

    {properties}
    property AutoIndent : Boolean
      read FAutoIndent
      write FAutoIndent
      default edDefAutoIndent;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default edDefBorderStyle;

    property ByteLimit : LongInt
      read FByteLimit
      write SetByteLimit
      default edDefMaxBytes;

    property CaretIns : TOvcCaret
      read GetInsCaretType
      write SetInsCaretType;

    property CaretOvr : TOvcCaret
      read GetOvrCaretType
      write SetOvrCaretType;

    property FixedFont : TOvcFixedFont
       read FFixedFont
       write SetFixedFont;

    property HideSelection : Boolean
      read FHideSelection
      write SetHideSelection
      default edDefHideSelection;

    property HighlightColors : TOvcColors
      read FHighlightColors
      write FHighlightColors;

    property InsertMode : Boolean
      read FInsertMode
      write SetInsertMode
      default edDefInsertMode;

    property LeftMargin : Integer
      read FLeftMargin
      write SetLeftMargin
      default edDefLeftMargin;

    property ParaLengthLimit : Integer
      read FParaLengthLimit
      write SetParaLengthLimit
      default edDefParaLengthLimit;

    property ParaLimit : LongInt
      read FParaLimit
      write SetParaLimit
      default edDefParaLimit;

    property ReadOnly : Boolean
      read GetReadOnly
      write FReadOnly
      default edDefReadOnly;

    property RightMargin : Integer
      read FRightMargin
      write SetRightMargin
      default edDefRightMargin;                                        {!!.14}

    property ScrollBars : TScrollStyle
       read FScrollBars
       write SetScrollBars
       default edDefScrollBars;

    property ScrollBarsAlways : Boolean
       read FScrollBarsAlways
       write SetScrollBarsAlways
       default edDefScrollBarsAlways;

    property ScrollPastEnd : Boolean
       read FScrollPastEnd
       write SetScrollPastEnd
       default edDefScrollPastEnd;

    property ShowBookmarks : Boolean
      read FShowBookmarks
      write SetShowBookmarks
      default edDefShowBookmarks;

    property TabSize : Byte
      read FTabSize
      write SetTabSize
      default edDefTabSize;

    property TabType : TTabType
      read FTabType
      write SetTabType
      default edDefTabType;

    property TrimWhiteSpace : Boolean
      read FTrimWhiteSpace
      write FTrimWhiteSpace
      default edDefTrimWhiteSpace;

    property UndoBufferSize : Word
      read FUndoBufferSize
      write SetUndoBufferSize
      default edDefUndoBufferSize;

    property WantEnter : Boolean
      read FWantEnter
      write FWantEnter
      default edDefWantEnter;

    property WantTab : Boolean
      read FWantTab
      write FWantTab
      default edDefWantTab;

    property WordWrap : Boolean
      read FWordWrap
      write SetWordWrap
      default edDefWordWrap;

    property WrapAtLeft : Boolean
      read FWrapAtLeft
      write SetWrapAtLeft
      default edDefWrapAtLeft;

    property WrapColumn : Integer
      read FWrapColumn
      write SetWrapColumn
      default edDefWrapColumn;

    property WrapToWindow : Boolean
      read FWrapToWindow
      write SetWrapToWindow
      default edDefWrapToWindow;

    {events}
    property OnChange : TNotifyEvent
      read FOnChange
      write FOnChange;

    property OnDrawLine : TEditorDrawLineEvent
      read FOnDrawLine
      write FOnDrawLine;

    property OnError : TEditorErrorEvent
      read FOnError
      write FOnError;

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
    {public internal variables and methods}
    edNext : TOvcCustomEditor; {next attached editor}

    procedure edResetPositionInfo;
    procedure edUpdateOnDeletedPara(N : LongInt);
    procedure edUpdateOnDeletedText(N : LongInt; Pos, Count : Integer);
    procedure edUpdateOnInsertedPara(N : LongInt; Pos, Indent : Integer);
    procedure edUpdateOnInsertedText(N : LongInt; Pos, Count : Integer);
    procedure edUpdateOnJoinedParas(N : LongInt; Pos : Integer);
  {.Z-}

    constructor Create(AOwner : TComponent);
      override;
    destructor  Destroy;
      override;

    {public methods}
    function  AppendPara(Para : PAnsiChar) : Word;
      {-append Para to the list of paragraphs}
    procedure Attach(Editor : TOvcCustomEditor);
      virtual;
      {-attach this editor to another editor's text stream}
    procedure BeginUpdate;                                             {!!.11}
      {-suspend window updates}
    function CanRedo : Boolean;
      {-return True if the last undo can be redone}
    function CanUndo : Boolean;
      {-return True if the last change can be undone}
    procedure Clear;
      {-delete all text and updates window}
    procedure ClearSelection;
      {-delete the current selection}
    procedure ClearMarker(N : Byte);
      {-remove the specified text marker}
    procedure CopyToClipboard;
      dynamic;
      {-copy highlighted text to the clipboard}
    procedure CutToClipboard;
      dynamic;
      {-copy highlighted text to the clipboard and then delete it}
    procedure DeleteAll(UpdateScreen : Boolean);
      {-delete all text}
    function EffectiveColumn(S : PAnsiChar; Col : Integer) : Integer;
      {-get the effective column for an actual column}
    procedure EndUpdate;                                               {!!.11}
      {-allow window updates}
    procedure FlushUndoBuffer;
      {-flush the undo buffer}
    function GetCaretPosition(var Col : Integer) : LongInt;
      {-return the current position of the caret}
    function GetCurrentWord : string;
      {-return the word at the current caret position}
    function GetLine(LineNum : LongInt; Dest : PAnsiChar; DestLen : Integer) : PAnsiChar;
      {-get the specified line}
    function GetMarkerPosition(N : Byte; var Col : Integer) : LongInt;
      {-return the current position of the specified marker}
    procedure GetMousePos(var L : LongInt; var C : Integer; Existing : Boolean);
      {-return line and column based on current mouse position}
    function GetPara(ParaNum : LongInt; var Len : Word) : PAnsiChar;
      {-get the specified paragraph}
    function GetPrintableLine(LineNum : LongInt; Dest : PAnsiChar; DestLen : Integer) : Integer;
      {-get a line in a format suitable for printing}
    function GetSelection(var Line1 : LongInt; var Col1 : Integer; var Line2 : LongInt; var Col2 : Integer) : Boolean;
      {-return True if any text is currently selected}
    procedure GotoMarker(N : Byte);
      {-move the caret to the specified text marker}
    function GetSelTextBuf(Buffer : PAnsiChar;
                           BufSize : LongInt) : LongInt;               {!!.11}
      {-return the selected text in Buffer and len as Result}
    function GetSelTextLen : LongInt;
      {-return the length of the selected text}
    function GetText(P : PAnsiChar; Size : LongInt) : LongInt;         {!!.11}
      {-copy text in editor into P; limit is Size (includes null)}
    {.Z+}
    function GetTextBuf(Buffer : PAnsiChar;
                        BufSize : LongInt) : LongInt;                  {!!.11}
      {-copy text in editor into Buffer; limit is Size (includes null)}
    function GetTextLen : LongInt;
      {-get the total number of bytes of text}
    {.Z-}
    function HasSelection : Boolean;                                   {!!.01}
      {-return True if any text is selected}
    procedure Insert(S : PAnsiChar);
      {-replace the current selection with a text string}
    procedure InsertString(const S : string);
      {-replace the current selection with a text string}
    procedure LineToPara(var L : LongInt; var C : Integer);
      {-convert a line,column coordinate to a paragraph,position coordinate}
    function ParaCount : LongInt;
      {-return the total number of paragraphs}
    procedure ParaToLine(var L : LongInt; var C : Integer);
      {-convert a paragraph,position coordinate to a line,column coordinate}
    procedure PasteFromClipboard;
      dynamic;
      {-paste the contents of the clipboard}
    function ProcessCommand(Cmd, CharCode : Word) : Boolean;
      dynamic;
      {-process the specified command, return True if processed}
    procedure Redo;
      {-redo the last undone operation}
      dynamic;
    procedure Deselect(CaretAtEnd : Boolean);
      {-remove any text highlighing}
    function Replace(const S, R : string; Options : TSearchOptionSet) : LongInt;
      {-search for a string and replace it with another string. return count}
      dynamic;
    procedure ResetScrollBars(UpdateScreen : Boolean);
      {-reset all scroll bars}
    function Search(const S : string; Options : TSearchOptionSet) : Boolean;
      {-search for a string returning True if found}
    procedure SelectAll(CaretAtEnd : Boolean);
      {-select all text in the editor}
    procedure SetCaretPosition(Line : LongInt; Col : Integer);
      {-move the caret to a specified line and column}
    procedure SetMarker(N : Byte);
      dynamic;
      {-set a text marker at the current caret position}
    procedure SetMarkerAt(N : Byte; Line : LongInt; Col : Integer);
      dynamic;
      {-set a text marker at the specified position}
    procedure SetSelection(Line1 : LongInt; Col1 : Integer;
                           Line2 : LongInt; Col2 : Integer;
                           CaretAtEnd : Boolean);
      {-select a region of text}
    procedure SetSelTextBuf(Buffer : PAnsiChar);
      {-replace selection with Buffer}
    procedure SetText(P : PAnsiChar);
      {-set text of editor to P}
    {.Z+}
    procedure SetTextBuf(Buffer : PAnsiChar);
      {-set text of editor to Buffer}
    {.Z-}
    procedure Undo;
      {-undo the last change}
      dynamic;

    {run-time only properties}
    property Canvas;                                                   {!!.01}

    property FirstEditor : TOvcCustomEditor
      read GetFirstEditor;

    property LeftColumn : Integer
      read GetLeftColumn;

    property Lines[LineNum : LongInt] : string
      read GetStringLine;

    property LineCount : LongInt
      read GetLineCount;

    property LineLength[LineNum : LongInt] : Integer
      read GetLineLength;

    property MaxLength : LongInt
      read FByteLimit
      write SetByteLimit
      stored False;

    property Modified : Boolean
      read GetModified
      write SetModified
      stored False;

    property NextEditor : TOvcCustomEditor
      read GetNextEditor;

    property ParaLength[ParaNum : LongInt] : Integer
      read GetParaLength;

    property ParaPointer[ParaNum : LongInt] : PAnsiChar
      read GetParaPointer;

    property PrevEditor : TOvcCustomEditor
      read GetPrevEditor;

    property TextLength : LongInt
      read GetTextLen;

    property TopLine : LongInt
      read GetTopLine
      write SetTopLine
      stored False;

    property VisibleColumns : Integer
      read GetVisibleColumns;

    property VisibleRows : Integer
      read GetVisibleRows;

    property WordDelimiters : string
      read FWordDelimiters
      write SetWordDelimiters
      stored False;
  end;

  TOvcEditor = class(TOvcCustomEditor)
  published
    property AutoIndent;
    property BorderStyle;
    property ByteLimit;
    property CaretIns;
    property CaretOvr;
    property FixedFont;
    property HideSelection;
    property HighlightColors;
    property InsertMode;
    property LeftMargin;
    property ParaLengthLimit;
    property ParaLimit;
    property ReadOnly;
    property RightMargin;
    property ScrollBars;
    property ScrollBarsAlways;
    property ScrollPastEnd;
    property ShowBookmarks;
    property TabSize;
    property TabType;
    property TrimWhiteSpace;
    property UndoBufferSize;
    property WantEnter;
    property WantTab;
    property WordWrap;
    property WrapAtLeft;
    property WrapColumn;
    property WrapToWindow;

    property OnChange;
    property OnDrawLine;
    property OnError;
    property OnShowStatus;
    property OnTopLineChanged;
    property OnUserCommand;

    {inherited properties}
    property Align;
    property Color;
    property Controller;
    property Ctl3D default edDefCtl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ParentColor default edDefParentColor;
    property ParentCtl3D default edDefParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default edDefTabStop;
    property Visible;

    {inherited events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
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

  {*** TOvcTextFileEditor ***}

  TOvcCustomTextFileEditor = class(TOvcCustomEditor)
  {.Z+}
  protected {private}
    FBackupExt  : TExtStr;
    FFileName   : string;
    FMakeBackup : Boolean;
    FIsOpen     : Boolean;

    {property methods}
    procedure SetFileName(const Value : string);
      {-set name of file being edited}
    procedure SetIsOpen(Value : Boolean);
      {-set if the file is open or not}

    {internal methods}
    function teFixFileName(const Value : string) : string;
      {-fixup file name}

  protected
    procedure CreateWnd;
      override;
    procedure Loaded;                                                  {!!.10}
      override;
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;
    procedure Attach(Editor : TOvcCustomEditor);
      override;
    procedure NewFile(const Name : string);
      {-create a new file}
    procedure LoadFromFile(const Name : string);
      {-open the file for editing}
      dynamic;
    procedure SaveToFile(const Name : string);
      {-write the text in the specified file}
      dynamic;

    {public properties}
    property BackupExt : TExtStr
      read FBackupExt
      write FBackupExt;

    property FileName : string
      read FFileName
      write SetFileName;

    property IsOpen : Boolean
      read FIsOpen
      write SetIsOpen
      default edDefIsOpen;

    property MakeBackup : Boolean
      read FMakeBackup
      write FMakeBackup
      default edDefMakeBackup;
  end;

  TOvcTextFileEditor = class(TOvcCustomTextFileEditor)
  published
    property BackupExt;
    property FileName;
    property IsOpen;
    property MakeBackup;

    property AutoIndent;
    property BorderStyle;
    property ByteLimit;
    property CaretIns;
    property CaretOvr;
    property FixedFont;
    property HideSelection;
    property HighlightColors;
    property InsertMode;
    property LeftMargin;
    property ParaLengthLimit;
    property ParaLimit;
    property ReadOnly;
    property RightMargin;
    property ScrollBars;
    property ScrollBarsAlways;
    property ScrollPastEnd;
    property ShowBookmarks;
    property TabSize;
    property TabType;
    property TrimWhiteSpace;
    property UndoBufferSize;
    property WantEnter;
    property WantTab;
    property WordWrap;
    property WrapAtLeft;
    property WrapColumn;
    property WrapToWindow;

    property OnChange;
    property OnDrawLine;
    property OnError;
    property OnShowStatus;
    property OnTopLineChanged;
    property OnUserCommand;

    {inherited properties}
    property Align;
    property Color;
    property Controller;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    {inherited events}
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


{*** Utilities ***}

function CompHltPos(var HP1, HP2 : TMarker) : ShortInt;
begin
 if HP1.Para < HP2.Para then
   Result := -1
 else if HP1.Para > HP2.Para then
   Result := +1
 else if HP1.Pos < HP2.Pos then
   Result := -1
 else if HP1.Pos > HP2.Pos then
   Result := +1
 else
   Result := 0;
end;


{*** TOvcCustomEditor ***}

function TOvcCustomEditor.AppendPara(Para : PAnsiChar) : Word;
  {-append Para to the list of paragraphs}
var
  I      : Word;
  SLen   : Word;
  SaveLC : LongInt;
begin
  SaveLC := edParas.LineCount;

  {is it OK to add this paragraph?}
  SLen := StrLen(Para);
  I := edParas.OkToInsert(0, 1, SLen+2);
  if I = 0 then
    repeat
      {is the paragraph too long?}
      if SLen > edParas.MaxParaLen then begin
        {if so, break it}
        edParas.InUndo := True;
        SLen := edBreakPoint(Para, edParas.MaxParaLen);
        edParas.InUndo := False;
      end;

      {append it}
      I := edParas.AppendParaEof(Para, SLen, FTrimWhiteSpace);

      {point to next paragraph, if any}
      Inc(Para, SLen);
      SLen := StrLen(Para);

      {if we have more to add, is it OK to add it?}
      if (I = 0) and (SLen > 0) then
        I := edParas.OkToInsert(0, 1, SLen+2);
    until (I <> 0) or (SLen = 0);

  {redraw now if we have enough to fill the window}
  if (I = 0) and (SaveLC < edRows+1) and (edParas.LineCount >= edRows+1) then begin
    edSetVScrollRange;
    edRedraw(True);
  end;

  Result := I;
end;

procedure TOvcCustomEditor.Attach(Editor : TOvcCustomEditor);
  {-associate this editor with the one whose window handle is HW}
var
  PC : TOvcCustomEditor;
begin
  if (Editor = nil) or (Editor = Self) then
    Exit;

  {switch paragraph lists}
  edParas.Free;
  edParas := Editor.edParas;

  {find the last attached window}
  PC := TOvcCustomEditor(edParas.Owner).edPrev;

  {attach us to the end of the list}
  edPrev := PC;
  edNext := PC.edNext;
  edPrev.edNext := Self;
  edNext.edPrev := Self;

  {reset scroll bars and redraw}
  ResetScrollBars(True);
end;

{!!.11}
procedure TOvcCustomEditor.BeginUpdate;
  {-suspend window updates}
begin
  Perform(WM_SETREDRAW, 0, 0);
end;

function TOvcCustomEditor.CanRedo : Boolean;
begin
  if ReadOnly then
    Result := False
  else
    Result := edParas.UndoBuffer.Redos <> 0;
end;

function TOvcCustomEditor.CanUndo : Boolean;
begin
  if ReadOnly then
    Result := False
  else
    Result := edParas.UndoBuffer.Undos <> 0;
end;

procedure TOvcCustomEditor.Clear;
  {-delete all text and update window}
begin
  DeleteAll(True);
end;

procedure TOvcCustomEditor.ClearMarker(N : Byte);
  {-remove the specified text marker}
begin
  if N < MaxMarkers then begin
    edParas.SetMarker(N, 0, 0);
    Refresh;
  end;
end;

procedure TOvcCustomEditor.ClearSelection;
  {-delete the current selection}
begin
  if edHaveHighlight then
    edDeleteSelection;
end;

procedure TOvcCustomEditor.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    edRecreateWnd;                                                     {!!.13}
  {$ENDIF}

  inherited;
end;

procedure TOvcCustomEditor.CMDialogChar(var Msg : TCMDialogChar);
begin
  {see if this is an Alt-Backspace key sequence (Alt flag is bit 29}
  if (Msg.CharCode = VK_BACK) and (HiWord(Msg.KeyData) and $2000 <> 0) then
    {indicate that its used since it may be mapped in the command processor}
    Msg.Result := 1;

  inherited;
end;

procedure TOvcCustomEditor.CMFontChanged(var Msg : TMessage);
begin
  inherited;

  if csLoading in ComponentState then
    Exit;

  if not HandleAllocated then
    Exit;

  {determine settings based on the current font}
  edCalcRowColInfo;

  {adjust wrap column}
  edAdjustWrapColumn;

  if csDesigning in ComponentState then
    Exit;

  {If this window has the focus, resize the caret}
  if HandleAllocated and (GetFocus = Handle) then begin
    edSetCaretSize;
    edPositionCaret(0);
  end;
end;

procedure TOvcCustomEditor.CopyToClipboard;
  {-copy highlighted text to clipboard}
var
  Size : LongInt;
  H    : THandle;
  S    : PAnsiChar;
  GP   : PAnsiChar;
  N    : LongInt;
  C    : Integer;
  Len  : Word;
begin
  if not edHaveHighlight then
    Exit;

  {calculate size of highlighted section}
  N := edHltBgn.Para;
  C := edHltBgn.Pos;
  Size := 0;
  repeat
    if N = edHltEnd.Para then
      Inc(Size, edHltEnd.Pos-C)
    else begin
      GetPara(N, Len);
      Inc(Len, 3);
      Inc(Size, Len-C);
    end;
    Inc(N);
    C := 1;
{$IFDEF Win32}
  until (N > edHltEnd.Para);
{$ELSE}
  until (N > edHltEnd.Para) or (Size > $FFF0);
{$ENDIF}

{$IFNDEF Win32}
  if Size > $FFF0 then begin
    DoOnError(oeRegionSize);
    Exit;
  end;
{$ENDIF}

  {allocate global memory block}
  H := GlobalAlloc(GHND, Size+1);
  if H = 0 then begin
    DoOnError(oeOutOfMemory);
    Exit;
  end;

  {copy selected text to global memory block}
  GP := GlobalLock(H);
  try
    N := edHltBgn.Para;
    C := edHltBgn.Pos;
    repeat
      S := GetPara(N, Len);
      if N = edHltEnd.Para then begin
        Len := edHltEnd.Pos-C;
        Move(S[C-1], GP^, Len);
        Inc(GP, Len);
      end else begin
        Dec(Len, Pred(C));
        Move(S[C-1], GP^, Len);
        Inc(GP, Len);
        Move(CRLF, GP^, 2);
        Inc(GP, 2);
      end;
      Inc(N);
      C := 1;
    until (N > edHltEnd.Para);
    GP^ := #0;
  finally
    GlobalUnlock(H);
  end;

  {give the handle to the clipboard}
  OpenClipboard(Handle);
  try
    EmptyClipboard;
    SetClipboardData(CF_TEXT, H);
  finally
    CloseClipboard;
  end;
end;

constructor TOvcCustomEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  if NewStyleControls then
    ControlStyle := ControlStyle + [csOpaque, csDoubleClicks]
  else
    ControlStyle := ControlStyle + [csOpaque, csDoubleClicks, csFramed];
  {$ELSE}
    ControlStyle := ControlStyle + [csOpaque, csDoubleClicks, csFramed];
  {$ENDIF}

  {set default property values}
  FAutoIndent       := edDefAutoIndent;
  FBorderStyle      := edDefBorderStyle;
  FByteLimit        := edDefMaxBytes;
  FHideSelection    := edDefHideSelection;
  FInsertMode       := edDefInsertMode;
  FLeftMargin       := edDefLeftMargin;
  FParaLengthLimit  := edDefParaLengthLimit;
  FParaLimit        := edDefParaLimit;
  FReadOnly         := edDefReadOnly;
  FRightMargin      := edDefRightMargin;
  FScrollBars       := edDefScrollBars;
  FScrollBarsAlways := edDefScrollBarsAlways;
  FScrollPastEnd    := edDefScrollPastEnd;
  FShowBookmarks    := edDefShowBookmarks;
  FTabSize          := edDefTabSize;
  FTabType          := edDefTabType;
  FTrimWhiteSpace   := edDefTrimWhiteSpace;
  FUndoBufferSize   := edDefUndoBufferSize;
  FWantEnter        := edDefWantEnter;
  FWantTab          := edDefWantTab;
  FWordDelimiters   := edDefWordDelimiters;
  FWordWrap         := edDefWordWrap;
  FWrapAtLeft       := edDefWrapAtLeft;
  FWrapColumn       := edDefWrapColumn;
  FWrapToWindow     := edDefWrapToWindow;

  edPrev := Self;
  edNext := Self;
  edRows := 0;
  edTopLine := 1;
  edTopPara := 1;
  edTopPos := 0;
  edColWid := 1;
  edRowHt := 1;
  edCurLine := 1;
  edCurPara := 1;
  edLinePos := 0;
  edCurCol := 1;
  edHDelta := 0;
  edCapture := False;
  edRedrawPending := False;
  edPendingHSP := False;
  edPendingVSP := False;
  edPendingVSR := False;
  edSelCursor := LoadCursor(hInstance, MakeIntResource(crLineCursor));
  edSelCursorOn := False;

  {initialize the paragraph list}
  edParas := TParaList.Init(Self, edDefUndoBufferSize, edDefWordWrap);
  edResetHighlight(False);

  {create the caret class}
  edCaret := TOvcCaretPair.Create(Self);

  {create highlight color object}
  FHighlightColors := TOvcColors.Create(edDefHighlightText, edDefHighlightBack);
  FHighlightColors.OnColorChange := edColorChanged;

  {default values for inherited properties}
  Ctl3D       := edDefCtl3D;
  Cursor      := crIBeam;
  Height      := edDefHeight;
  ParentColor := edDefParentColor;
  ParentCtl3D := edDefParentCtl3D;
  TabStop     := edDefTabStop;
  Width       := edDefWidth;

  FFixedFont  := TOvcFixedFont.Create;
  FFixedFont.OnChange := edFixedFontChanged;
end;

procedure TOvcCustomEditor.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do begin
    Style := LongInt(Style) or ScrollBarStyles[FScrollBars]    {!!.D4}
                   or BorderStyles[FBorderStyle];          
  end;

  {$IFDEF Win32}
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  {$ENDIF}
end;

procedure TOvcCustomEditor.CreateWnd;
begin
  inherited CreateWnd;

  {are scroll bars desired?}
  edHScroll := FScrollBars in [ssHorizontal, ssBoth];
  edVScroll := FScrollBars in [ssVertical, ssBoth];

  {add sample text if designing}
  edAddSampleParas;

  {set initial scrollbar ranges}
  edSetVScrollRange;
  edSetHScrollRange;

  {determine settings based on the current font}
  edCalcRowColInfo;

  {adjust wrap column}
  edAdjustWrapColumn;

  if FShowBookmarks then
    edReadBookmarkGlyphs;
end;

procedure TOvcCustomEditor.CutToClipboard;
begin
  if edHaveHighlight and not ReadOnly then begin
    {copy highlighted text to clipboard}
    CopyToClipboard;

    {and delete it}
    edDeleteSelection;
  end;

  {adjust scroll range}
  edSetVScrollRange;

  {force top line update and refresh scroll position}
  edScrollPrim(0, 0);
end;

procedure TOvcCustomEditor.DefineProperties(Filer : TFiler);
begin
  inherited DefineProperties(Filer);

  {define a Margin property for compatibility with eariler versions}
  Filer.DefineProperty('Margin', edReadMargin, nil, False);
end;

procedure TOvcCustomEditor.DeleteAll(UpdateScreen : Boolean);
  {-delete all text}
var
  SBL  : LongInt;
  SPL  : LongInt;
  SPLL : Integer;
  SWC  : Integer;
  SUS  : Word;
  SWW  : Boolean;
begin
  {save current settings}
  SBL := edParas.MaxBytes;
  SPL := edParas.MaxParas;
  SPLL := edParas.MaxParaLen;
  SWW := edParas.WordWrap;
  SWC := edParas.WrapColumn;
  SUS := edParas.UndoBuffer.BufSize;

  {detach ourselves from list or destroy existing paragraph list}
  edDetach;

  {create a new paragraph list}
  edParas := TParaList.Init(Self, SUS, SWW);

  {restore settings}
  edParas.SetByteLimit(SBL);
  edParas.SetParaLimit(SPL);
  SetParaLengthLimit(SPLL);
  edParas.SetWrapColumn(SWC);
  edParas.SetTabSize(FTabSize);

  {reinitialize}
  edChangeTopLine(1);
  edTopPara := 1;
  edTopPos := 0;
  edCurLine := 1;
  edCurPara := 1;
  edLinePos := 0;
  edCurCol := 1;
  edHDelta := 0;
  edRedrawPending := False;
  edPendingHSP := False;
  edPendingVSP := False;
  edPendingVSR := False;
  edResetHighlight(False);

  if HandleAllocated and UpdateScreen then                             {!!.14}
    ResetScrollBars(True);
end;

procedure TOvcCustomEditor.Deselect(CaretAtEnd : Boolean);
  {-remove any text highlighing}
var
  L1, L2 : LongInt;
  C1, C2 : Integer;
begin
  {L := GetCaretPosition(C);}
  {SetSelection(L, C, L, C, CaretAtEnd);}

  {!!.10} {revised}
  if GetSelection(L1, C1, L2, C2) then begin
    if CaretAtEnd then
      SetSelection(L2, C2, L2, C2, True)
    else
      SetSelection(L1, C1, L1, C1, True);
  end;
end;

destructor TOvcCustomEditor.Destroy;
begin
  {dispose of the  caret object}
  edCaret.Free;
  edCaret := nil;

  if edSelCursor <> 0 then
    DestroyCursor(edSelCursor);

  {unhook from other editors. if none then dispose of the para list}
  edDetach;

  {destroy marker glyphs}
  edBMGlyphs.Free;
  edBMGlyphs := nil;

  {dispose of the color object}
  FHighlightColors.Free;
  FHighlightColors := nil;

  {free our font object}
  FFixedFont.Free;
  FFixedFont := nil;

  inherited Destroy;
end;

{!!.10} {added}
procedure TOvcCustomEditor.DoOnChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TOvcCustomEditor.DoOnDrawLine(EditorCanvas : TCanvas;
         Rect : TRect; S : PAnsiChar; Len, Line, Pos, Count,
         HBLine, HBCol, HELine, HECol : Integer) : Boolean;
begin
  { EditorCanvas   - the editor's Canvas
    Rect           - the drawing boundry
    S              - the complete string for this row
    Len            - the length of S
    Line           - the editor's line number
    Pos            - first character position in S to draw
    Count          - number of characters to draw (width)
    HBLine         - line highlight begins on
    HBCol          - column highlight begins with
    HELine         - line highlight ends on
    HECol          - column highlight ends with
  }
  Result := False;
  FOnDrawLine(Self, EditorCanvas, Rect, S, Len, Line, Pos,
              Count, HBLine, HBCol, HELine, HECol, Result);
end;

procedure TOvcCustomEditor.DoOnError(ErrorCode : Word);
var
  S : string;
begin
  {if no error, exit}
  if ErrorCode = 0 then
    Exit;

  {if OnError is assigned then call user error routine}
  {otherwise, generate an exception}
  if Assigned(FOnError) then
    FOnError(Self, ErrorCode)
  else begin
    case ErrorCode of
      oeOutOfMemory  : S := GetOrphStr(SCOutOfMemory);
      oeRegionSize   : S := GetOrphStr(SCRegionTooLarge);
      oeTooManyParas : S := GetOrphStr(SCTooManyParas);
      oeCannotJoin   : S := GetOrphStr(SCCannotJoin);
      oeTooManyBytes : S := GetOrphStr(SCTooManyBytes);
      oeParaTooLong  : S := GetOrphStr(SCParaTooLong);
    else
      {raise (unknown error) exception}
      S := GetOrphStr(SCUnknownError);
    end;
    raise EEditorError.Create(S, ErrorCode, 0);
  end;
end;

procedure TOvcCustomEditor.DoOnShowStatus(LineNum : LongInt; ColNum : Word);
  {-call the OnShowStatus mehtod, if assigned}
begin
  if Assigned(FOnShowStatus) then
    FOnShowStatus(Self, LineNum, ColNum);
end;

procedure TOvcCustomEditor.DoOnTopLineChanged(Line : LongInt);
  {-perform notification of a top line changed}
begin
  if Assigned(FOnTopLineChanged) then
    FOnTopLineChanged(Self, Line);
end;

procedure TOvcCustomEditor.DoOnUserCommand(Command : Word);
  {-perform notification of a user command}
begin
  if Assigned(FOnUserCommand) then
    FOnUserCommand(Self, Command);
end;

procedure TOvcCustomEditor.edAddSampleParas;
  {-add sample text if designing}
var
  I : Integer;
  L : array[0..0] of LongInt;
  A : array[0..255] of AnsiChar;
begin
  if csDesigning in ComponentState then begin
    if edParas.ParaCount > 1 then
      DeleteAll(False);
    for I := 1 to 30 do begin
      L[0] := I;
      wvsPrintf(A, '%i%: Editor paragraph.'^I'Tab.',
                {$IFDEF Win32}@L{$ELSE}L{$ENDIF});
      AppendPara(A);
    end;
  end;
end;

procedure TOvcCustomEditor.edAdjustWrapColumn;
begin
  if FWrapToWindow and WordWrap then
    WrapColumn := VisibleColumns-2;
end;

procedure TOvcCustomEditor.edBackspace;
begin
  if ReadOnly then
    Exit;

  if not edHaveHighlight then begin
    if (edCurCol = 1) and (edCurLine = 1) then
      Exit;

    edCaretLeft(False);
  end;
  edDeleteSelection;
end;

procedure TOvcCustomEditor.edCalcRowColInfo;
var
  Metrics : TTextMetric;
  OldRows : LongInt;
  OldCols : Integer;
begin
  {set canvas font to selected font}
  Canvas.Font := FixedFont.Font;
  GetTextMetrics(Canvas.Handle, Metrics);

  {determine the width of one column}
  edColWid := Metrics.tmAveCharWidth;

  {because of possible client width and height changes due to the}
  {presence of the scroll bars, do this until there are no changes}
  repeat
    {record current rows and columns}
    OldRows := edRows;
    OldCols := edCols;

    {determine the number of columns}
    edCols := (ClientWidth - FLeftMargin - FRightMargin) div edColWid;
    if edCols <= 0 then
      edCols := 1;

    {reset scroll bar range and position}
    if (edCols <> OldCols) and (ClientWidth > 0) then begin
      edSetHScrollRange;
      edSetHScrollPos;
      if edHSMax = 0 then
        edHDelta := 0;
    end;

    {determine the height of one row}
    edRowHt := Metrics.tmHeight+Metrics.tmExternalLeading+1;

    {determine the number of rows}
    edRows := ClientHeight div edRowHt;
    if edRows <= 0 then
      edRows := 1;

    {reset scroll bar range and position}
    if (edRows <> OldRows) and (ClientHeight > 0) then begin
      edSetVScrollRange;
      edSetVScrollPos;
    end;

  until (edRows = OldRows) and (edCols = OldCols);

  edRedraw(True);
end;

function TOvcCustomEditor.edCaretInWindow(var Col : Word) : Boolean;
var
  S   : PAnsiChar;
  Len : Word;
begin
  {is the caret above or below the window?}
  if (edCurLine < edTopLine) or (edCurLine >= edTopLine+edRows) then
    Result := False
  else begin
    if Col = 0 then begin
      edParas.NthLine(edCurLine, S, Len);
      Col := edParas.EffCol(S, Len, edCurCol);
    end;

    {is the caret inside the window?}
    Result := (Col >= edHDelta+1) and (Col <= edHDelta+edCols);
  end;
end;

procedure TOvcCustomEditor.edCaretLeft(Shift : Boolean);
  {-move caret left one column}
var
  Line : LongInt;
  Pos  : Integer;
begin
  Pos := edLinePos+edCurCol;
  if Pos > 1 then
    edMoveCaretToPP(edCurPara, Pos-1, Shift)
  else if (edCurLine > 1) and FWrapAtLeft then begin
    Line := edCurLine-1;
    edMoveCaretTo(Line, edParas.LineLength(Line)+1, Shift);
  end;
end;

procedure TOvcCustomEditor.edCaretRight(Shift : Boolean);
  {-cursor right one column}
var
  Len : Word;
  Pos : Integer;
begin
  {cursor right one column}
  GetPara(edCurPara, Len);
  Pos := edLinePos+edCurCol;
  if (Pos <= Len) or ScrollPastEnd then
    edMoveCaretToPP(edCurPara, Pos+1, Shift)
  else
    edMoveCaretTo(edCurLine+1, 1, Shift);
end;

procedure TOvcCustomEditor.edChangeTopLine(Value : LongInt);
begin
  if Value <> edTopLine then begin
    edTopLine := Value;
    DoOnTopLineChanged(edTopLine);
  end;
end;

procedure TOvcCustomEditor.edColorChanged(AColor : TObject);
  {-colors have changed}
begin
  Repaint;
end;

procedure TOvcCustomEditor.edDeleteLine;
var
  Para        : LongInt;
  Pos         : Integer;
  S           : PAnsiChar;
  Len         : Word;
  SaveLinking : Boolean;
begin
  if ReadOnly then
    Exit;

  if (edCurLine = edParas.LineCount) then begin
    edParas.NthLine(edCurLine, S, Len);
    if Len = 0 then
      Exit;

    edSetSelPrim(edCurPara, edLinePos+1, edCurPara, edLinePos+Len+1);
  end else begin
    Para := edParas.FindParaByLine(edCurLine+1, Pos);
    edSetSelPrim(edCurPara, edLinePos+1, Para, Pos+1);
  end;

  {make sure that multiple delete line operations aren't linked together}
  edParas.UndoBuffer.BeginComplexOp(SaveLinking);
  edDeleteSelection;
  edParas.UndoBuffer.EndComplexOp(SaveLinking);
end;

procedure TOvcCustomEditor.edDeleteSelection;
var
  BC, EC : Integer;
  CurPos : Integer;
  BP     : LongInt;
  EP     : LongInt;
  I      : LongInt;
begin
  if ReadOnly then
    Exit;

  CurPos := edLinePos+edCurCol;
  if edHaveHighlight then begin
    {delete the highlighted text}
    BP := edHltBgn.Para;
    BC := edHltBgn.Pos;
    EP := edHltEnd.Para;
    EC := edHltEnd.Pos;
    if (BP = EP) then begin
      {all the text is in the current paragraph}
      edParas.DeleteText(Self, BP, BC, EC-BC);

      {redraw the affected lines}
      edRefreshLines(edParas.FLine, edParas.LLine);
      edMoveCaretToPP(BP, BC, False);
    end else begin
      {delete the block}
      edParas.DeleteBlock(Self, BP, BC, EP, EC);

      edSetVScrollRange;
      edRedraw(False);
      edMoveCaretToPP(BP, BC, False);
    end;
  end else if CurPos > edParas.ParaLength(edCurPara) then begin
    {join the next paragraph with the current one at the cursor}
    I := edParas.JoinWithNext(Self, edCurPara, CurPos);
    if I <> 0 then begin
      DoOnError(I);
      Exit;
    end;

    edSetVScrollRange;
    edRedraw(False);
    edMoveCaretToPP(edCurPara, CurPos, False);
  end else begin
    {delete the character at the cursor}
    edParas.NthPara(edCurPara);
    edParas.DeleteText(Self, edCurPara, CurPos, 1);

    {redraw the affected lines}
    edRefreshLines(edParas.FLine, edParas.LLine);
    edMoveCaretToPP(edCurPara, CurPos, False);
  end;

  if not edParas.UndoBuffer.Linking then
    Update;
end;

{!!.12}
procedure TOvcCustomEditor.edDeleteToBeginning;
var
  S   : PAnsiChar;
  Len : Word;
begin
  if ReadOnly then
    Exit;

  edParas.NthLine(edCurLine, S, Len);
  if (Len = 0) then
    edResetHighlight(True)
  else begin
    edSetSelPrim(edCurPara, edLinePos+1, edCurPara, edLinePos+edCurCol);
    edDeleteSelection;
  end;
end;

procedure TOvcCustomEditor.edDeleteToEnd;
var
  S   : PAnsiChar;
  Len : Word;
begin
  if ReadOnly then
    Exit;

  edParas.NthLine(edCurLine, S, Len);
  if (Len = 0) or (edCurCol > Len) then
    edResetHighlight(True)
  else begin
    edSetSelPrim(edCurPara, edLinePos+edCurCol, edCurPara, edLinePos+Len+1);
    edDeleteSelection;
  end;
end;

procedure TOvcCustomEditor.edDeleteWord;
var
  S    : PAnsiChar;
  Len  : Word;
  Pos  : Integer;
  Pos2 : Integer;
begin
  if ReadOnly then
    Exit;

  if not edHaveHighlight then begin
    S := GetPara(edCurPara, Len);

    {find end of this word}
    Pos := edLinePos+edCurCol;
    Pos2 := Pos;
    while (Pos2 <= Len) and not edIsWordDelim(S[Pos2-1]) do
      Inc(Pos2);
    if (Pos2-2 > Pos) and edIsWordDelim(S[Pos2-2])
                      and not edWhiteSpace(S[Pos2-2]) then
      Dec(Pos2);
    while (Pos2 <= Len) and edWhiteSpace(S[Pos2-1]) do
      Inc(Pos2);

    {select the word}
    edSetSelPrim(edCurPara, Pos, edCurPara, Pos2);
  end;
  edDeleteSelection;
end;

procedure TOvcCustomEditor.edDetach;
  {-detach this editor from a list of attached editors}
begin
  if (edPrev = Self) and (edNext = Self) then begin
    edParas.Free;
    edParas := nil;
  end else begin
    edPrev.edNext := edNext;
    edNext.edPrev := edPrev;
    if edParas.Owner = Self then
      edParas.Owner := edNext;
    edPrev := Self;
    edNext := Self;
  end;
end;

procedure TOvcCustomEditor.edDoTab;

  procedure InsertTab(N : Word);
  var
    S           : array[0..255] of AnsiChar;
    R           : Word;
    SaveLinking : Boolean;
    Pos         : Integer;
  begin
    if edHaveHighlight then begin
      edParas.UndoBuffer.BeginComplexOp(SaveLinking);
      edDeleteSelection;
    end else if not FInsertMode then begin
      edParas.UndoBuffer.BeginComplexOp(SaveLinking);
      edParas.DeleteText(Self, edCurPara, edCurCol, N);
      edRefreshLines(edParas.FLine, edParas.LLine);
    end else
      SaveLinking := False;

    Pos := 0;
    R := edParas.OkToInsert(edCurPara, 0, N);
    if R = 0 then begin
      Pos := edLinePos+edCurCol;
      R := edParas.InsertTextPrim(Self, edCurPara, Pos, CharStrPChar(S, ' ', N), N);
    end;
    if R = 0 then begin
      edRefreshLines(edParas.FLine, edParas.LLine);
      edMoveCaretToPP(edCurPara, Pos+N, False);
    end else
      DoOnError(R);

    edParas.UndoBuffer.EndComplexOp(SaveLinking);
  end;

  procedure FakeTab;
  var
    I : Word;
  begin
    I := Succ(Succ(Pred(edCurCol) div edParas.TabSize) * Word(edParas.TabSize));
    InsertTab(I-edCurCol);
  end;

  procedure DoSmartTab;
  var
    TabPos : Word;

    function NextIndentCol(LineNum : LongInt; Start : Word) : Word;
      {-return the column number where next tab past start is}
    var
      S    : PAnsiChar;
      Len  : Word;
      Next : Word;
    begin
      {need to use printable line}
      Len := edParas.EffLen(LineNum);
      GetMem(S, Len+1);
      try
        GetPrintableLine(LineNum, S, Len);
        if Len = 0 then
          Next := 0
        else if (Start <= Len) then begin
          Next := Start;
          if (S[Start-1] <> ' ') then
            {Start is in a word - advance to next blank}
            while (Next <= Len) and (S[Next-1] <> ' ') do
              Inc(Next);

          {in white space - advance to next non-blank}
          while (Next <= Len) and (S[Next-1] = ' ') do
            Inc(Next);
        end else
          Next := Start;
      finally
        FreeMem(S, Len+1);
      end;
      Result := Next;
    end;

  begin
    if edCurPara = 1 then
      TabPos := 0
    else begin
      {Check previous line}
      TabPos := NextIndentCol(edCurLine-1, edCurCol);
      if (TabPos = 0) and (edCurLine <> edParas.LineCount) then
        {Check next line}
        TabPos := NextIndentCol(edCurLine+1, edCurCol);
    end;

    if (TabPos > edCurCol) then
      InsertTab(TabPos-edCurCol)
    else
      TabPos := 0;

    if TabPos = 0 then
      FakeTab;
  end;

begin
  if ReadOnly then
    Exit;

  if edHaveHighlight then
    edDeleteSelection;
  case FTabType of
    ttReal  : edInsertChar(^I);
    ttSmart : DoSmartTab;
    ttFixed : FakeTab;
  end;
end;

procedure TOvcCustomEditor.edFixedFontChanged(Sender : TObject);
begin
  Perform(CM_FONTCHANGED, 0, 0);
end;

function TOvcCustomEditor.edGetEditLine(LineNum : LongInt;
         Buf : PAnsiChar; BufLen : Word) : Integer;
  {-get the specified line}
var
  S   : PAnsiChar;
  Len : Word;
begin
  edParas.NthLine(LineNum, S, Len);
  if BufLen > Len then
    BufLen := Len;
  StrLCopy(Buf, S, BufLen);
  Result := StrLen(Buf);
end;

function TOvcCustomEditor.edGetIndentLevel(N : LongInt; Col : Integer) : Integer;
var
  S   : PAnsiChar;
  I   : Word;
  Len : Word;
begin
  I := 0;
  edParas.NthLine(N, S, Len);
  if S <> nil then begin
    if Col > Len then
      Col := Len;
    while (I <= Col-1) and edWhiteSpace(S[I]) do
      Inc(I);
    I := edParas.EffCol(S, Len, I+1)-1;
  end;
  Result := I;
end;

procedure TOvcCustomEditor.edGetMousePos(var Line : LongInt; var Col : Integer);
var
  Pt  : TPoint;
  S   : PAnsiChar;
  Len : Word;
begin
  GetCursorPos(Pt);
  Pt := ScreenToClient(Pt);
  if Pt.Y < 0 then
    Line := edTopLine-1
  else if Pt.Y >= ClientHeight then
    Line := edTopLine+edRows
  else begin
    {convert to an index}
    Line := edTopLine+(Pt.Y div edRowHt);

    {check to make sure cursor is not in the bottom}
    {margin --if so, set to last visible line}
    if (Pt.Y > edRows * edRowHt) and (Pt.Y < ClientHeight) then
      Dec(Line);
  end;
  if Line > edParas.LineCount then
    Line := edParas.LineCount
  else if Line < 1 then
    Line := 1;
  edParas.NthLine(Line, S, Len);

  {adjust by (edColWid div 2) so that clicks within a charcter work better}
  Col := Succ((Pt.X-FLeftMargin + (edColWid div 2)) div edColWid)+edHDelta;
  if Col < 1 then
    Col := 1
  else
    Col := edParas.ActualCol(S, Len, Col);
  if (not ScrollPastEnd) and (Col > Len) then
    Col := Succ(Len);

  {check to make sure cursor is not in the right}
  {margin --if so, set col to last visible column}
  if (Pt.X >= edCols * edColWid + FLeftMargin - (edColWid div 2)) and
     (Pt.X < ClientWidth) then
    Col := edCols + edHDelta;
end;

function TOvcCustomEditor.edHaveHighlight : Boolean;
  {-do we have a highlighted section?}
begin
  Result := CompHltPos(edHltBgn, edHltEnd) <> 0;
end;

procedure TOvcCustomEditor.edHScrollPrim(Delta : Integer);
begin
  edScrollPrim(Delta, 0);
end;

procedure TOvcCustomEditor.edInsertChar(Ch : AnsiChar);
var
  Len         : Word;
  Res         : Word;
  Pos         : Integer;
  Insert      : Boolean;
  SaveLinking : Boolean;
  PPN         : TParaNode;
  SaveCL      : LongInt;
begin
  if edHaveHighlight then begin
    edParas.UndoBuffer.BeginComplexOp(SaveLinking);
    edDeleteSelection;
    Insert := True;
  end else begin
    SaveLinking := False;
    Insert := FInsertMode;
  end;

  PPN := edParas.NthPara(edCurPara);
  Len := PPN.SLen;

  Pos := edLinePos+edCurCol;
  if (Pos > Len) or Insert then
    Res := edParas.InsertTextPrim(Self, edCurPara, Pos, @Ch, 1)
  else
    Res := edParas.ReplaceText(Self, edCurPara, Pos, 1, @Ch, 1);

  edParas.UndoBuffer.EndComplexOp(SaveLinking);

  if Res = 0 then begin
    SaveCL := edCurLine;
    edRefreshLines(edParas.FLine, edParas.LLine);
    if edParas.LLine = MaxLongInt then
      edSetVScrollRange;
    edMoveCaretToPP(edCurPara, edLinePos+edCurCol+1, False);
    if edCurLine > SaveCL then
      {insert caused word wrap to next line. adjust horz scroll to 0}
      edScrollPrim(-edHDelta, 0);
    Update;
  end else
    DoOnError(Res);
end;

{$IFDEF Win32} {!!.11}
function TOvcCustomEditor.edInsertTextAtCaret(P : PAnsiChar) : Word;
const
  BlockSize = $F000;
var
  CurPara : LongInt;
  CurPos  : Integer;
  S       : PAnsiChar;
  SaveLen : LongInt;
  Pos     : LongInt;
  Offset  : LongInt;
  Ch      : AnsiChar;
begin
  Result := 0;
  if (P = nil) or (P^ = #0) then
    Exit;

  {get caret position}
  CurPara := edCurPara;
  CurPos := edLinePos+edCurCol;

  if StrLen(P) > BlockSize then begin
    SaveLen := StrLen(P);
    Pos := 0;
    repeat
      {pointer to block to paste}
      S := @P[Pos];
      Offset := 0;
      if Pos + BlockSize < SaveLen then begin
        {don't end block in cr/lf}
        while (S[BlockSize+Offset] in [#13, #10]) and
              (BlockSize+Offset < $FFF0) and
              (Pos+BlockSize+Offset < SaveLen) do
          Inc(Offset);
        {save character at block end}
        CH := S[BlockSize+Offset];
        {mark end of block}
        S[BlockSize+Offset] := #0;
        {do the insertion}
        Result := edParas.InsertBlock(Self, CurPara, CurPos, S);
        {restore character}
        S[BlockSize+Offset] := Ch;
      end else
        Result := edParas.InsertBlock(Self, CurPara, CurPos, S);

      {move to next block}
      Inc(Pos, BlockSize+Offset);
    until (Result <> 0) or (Pos > SaveLen);
  end else
    Result := edParas.InsertBlock(Self, CurPara, CurPos, P);

  {adjust scroll range}
  edSetVScrollRange;
  edRefreshLines(edParas.FLine, edParas.LLine);
  edMoveCaretToPP(CurPara, CurPos, False);
  Update;
end;
{$ELSE}
function TOvcCustomEditor.edInsertTextAtCaret(P : PAnsiChar) : Word;
var
  CurPara : LongInt;
  CurPos  : Integer;
begin
  Result := 0;
  if (P = nil) or (P^ = #0) then
    Exit;

  CurPara := edCurPara;
  CurPos := edLinePos+edCurCol;
  Result := edParas.InsertBlock(Self, CurPara, CurPos, P);
  edSetVScrollRange;
  edRefreshLines(edParas.FLine, edParas.LLine);
  edMoveCaretToPP(CurPara, CurPos, False);
  Update;
end;
{$ENDIF}

function TOvcCustomEditor.edIsStringHighlighted(S : PAnsiChar; MatchCase : Boolean) : Boolean;
var
  T : PAnsiChar;
  L : Word;
  J : Word;
begin
  L := StrLen(S);
  if (not edHaveHighlight) or (edHltBgn.Para <> edHltEnd.Para) or (L = 0) then
    Result := False
  else if L <> (edHltEnd.Pos-edHltBgn.Pos) then
    Result := False
  else begin
    T := GetPara(edHltBgn.Para, J);
    if MatchCase then
      Result := (StrLComp(@T[edHltBgn.Pos-1], S, L) = 0)
    else
      Result := (StrLIComp(@T[edHltBgn.Pos-1], S, L) = 0);
  end;
end;

function TOvcCustomEditor.edIsWordDelim(Ch : AnsiChar) : Boolean;
  {-return True if Ch is a word delimiter}
begin
  Result := Pos(Ch, FWordDelimiters) <> 0;
end;

procedure TOvcCustomEditor.edMoveCaret(HDelta : Integer;
          VDelta : LongInt; MVP, DragH : Boolean);
begin
  edMoveCaretPrim(HDelta, VDelta, MVP, DragH, False);
end;

procedure TOvcCustomEditor.edMoveCaretPrim(HDelta : Integer;
          VDelta : LongInt; MVP, DragH, AbsCol : Boolean);
var
  SaveCL : LongInt;
  NewTop : LongInt;
  NewHO  : Integer;
  SaveVP : Integer;
  MaxCol : Word;
  Col    : Word;
  S      : PAnsiChar;
  Len    : Word;
begin
  if (edCurLine >= edTopLine) and (edCurLine < edTopLine+edRows) then
    SaveVP := edCurLine-edTopLine
  else begin
    SaveVP := 0;
    MVP := False;
  end;
  SaveCL := edCurLine;

  {adjust current line}
  Inc(edCurLine, VDelta);
  if (edCurLine < 0) then
    if VDelta < 0 then
      edCurLine := 1
    else
      edCurLine := edParas.LineCount
  else if (edCurLine = 0) then
    edCurLine := 1
  else if edCurLine > edParas.LineCount then begin
    edCurLine := edParas.LineCount;
    if (SaveCL = edCurLine) then
      Exit;
  end;

  if (edCurLine <> SaveCL) and not AbsCol then begin
    edParas.NthLine(SaveCL, S, Len);
    edCurCol := edParas.EffCol(S, Len, edCurCol);
    edParas.NthLine(edCurLine, S, Len);
    edCurCol := edParas.ActualCol(S, Len, edCurCol);
  end else
    edParas.NthLine(edCurLine, S, Len);

  {adjust current column}
  MaxCol := Len;
  if ScrollPastEnd then
    MaxCol := edParas.MaxParaLen;
  Inc(MaxCol);
  if edParas.EffCol(S, Len, MaxCol) > edParas.MaxParaLen then
    MaxCol := edParas.ActualCol(S, Len, edParas.MaxParaLen) + 1;       {!!.01}
  Inc(edCurCol, HDelta);
  if edCurCol < 1 then
    edCurCol := 1
  else if edCurCol > MaxCol then
    edCurCol := MaxCol;

  {update edCurPara and edLinePos}
  edCurPara := edParas.FindParaByLine(edCurLine, edLinePos);

  {reposition caret}
  if DragH then
    edUpdateHighlight(True)
  else
    edResetHighlight(True);

  Col := 0;
  if MVP or not edCaretInWindow(Col) and (edRows > 0) then begin
    {scroll vertically as necessary}
    if MVP then
      NewTop := edCurLine-SaveVP
    else if edCurLine < edTopLine then
      NewTop := edCurLine
    else if edCurLine > edTopLine+Pred(edRows) then
      NewTop := edCurLine-Pred(edRows)
    else
      NewTop := edTopLine;
    if NewTop < 1 then
      NewTop := 1
    else if edCurLine > NewTop+Pred(edRows) then
      NewTop := edCurLine-Pred(edRows);

    {scroll horizontally as necessary}
    if Col = 0 then
      Col := edParas.EffCol(S, Len, edCurCol);
    if Col < edHDelta+1 then
      if Col <= 2 then
        NewHO := 0
      else
        NewHO := Col-1
    else if Col > edHDelta+edCols then
      NewHO := Col-edCols
    else
      NewHO := edHDelta;

    {do the scroll}
    if (NewHO <> edHDelta) and (SaveCL < edCurLine) then
      {we wrapped to the next line}
      edScrollPrim(-edHDelta, NewTop-edTopLine)
    else
      edScrollPrim(NewHO-edHDelta, NewTop-edTopLine);

  end else
    edPositionCaret(Col);
end;

procedure TOvcCustomEditor.edMoveCaretTo(Line : LongInt; Col : Integer; DragH : Boolean);
begin
  edMoveCaretPrim(Col-edCurCol, Line-edCurLine, False, DragH, True);
end;

procedure TOvcCustomEditor.edMoveCaretToPP(Para : LongInt; Pos : Integer; DragH : Boolean);
var
  Line : LongInt;
  Col  : Integer;
begin
  Line := edParas.FindLineByPara(Para, Pos, Col);
  edMoveCaretPrim(Col-edCurCol, Line-edCurLine, False, DragH, True);
end;

procedure TOvcCustomEditor.edMoveToEndOfLine(Shift : Boolean);
  {-move cursor to end of line}
var
  Len : Word;
  Pos : Integer;
begin
  GetPara(edCurPara, Len);
  Pos := edLinePos+edParas.LineLength(edCurLine);
  if Pos < Len then
    {somewhere in middle of paragraph?}
    edMoveCaretTo(edCurLine, edParas.LineLength(edCurLine)+1, Shift)   {!!.16}
  else
    {will be at end of paragraph}
    edMoveCaretTo(edCurLine, edParas.LineLength(edCurLine)+1, Shift);
end;

procedure TOvcCustomEditor.edNewLine(BreakP, Follow : Boolean);
var
  Indent, TS  : Integer;
  Res         : Word;
  SaveLinking : Boolean;
  Changed     : Boolean;                                               {!!.13}
begin
  Changed := False;                                                    {!!.13}
  if edHaveHighlight then begin
    {make sure that multiple selection delete operations aren't linked together}
    edParas.UndoBuffer.BeginComplexOp(SaveLinking);
    edDeleteSelection;
    edParas.UndoBuffer.EndComplexOp(SaveLinking);
    Changed := True;                                                   {!!.13}
  end;

  Indent := 0;
  if BreakP then begin
    if FAutoIndent then
      Indent := edGetIndentLevel(edCurLine, edCurCol-1);               {!!.14}
    if FTabType = ttReal then
      TS := edParas.TabSize
    else
      TS := 0;
    Res := edParas.OkToInsert(0, 1, Indent+2);
    if Res = 0 then
      Res :=
        edParas.BreakPara(Self, edCurPara, edLinePos+edCurCol, TS, Indent, True);
    if Res = 0 then begin
      edSetVScrollRange;
      edRedraw(True);
    end else begin
      DoOnError(Res);
      Exit;
    end;
    Changed := True;                                                   {!!.13}
  end;

  if Follow then begin
    {if this is the last paragraph and we didn't create a new one}
    if not BreakP and (edCurPara = edParas.ParaCount) then
      {cursor to end of file}
      edMoveCaretTo(edParas.LineCount,
                     edParas.LineLength(edParas.LineCount)+1, False)
    else
      edMoveCaretToPP(edCurPara+1, Indent+1, False);
  end;

  if Changed then                                                      {!!.13}
    DoOnChange;                                                        {!!.13}
end;

procedure TOvcCustomEditor.edPositionCaret(Col : Word);
  {-position the caret within the window}
var
  X, Y : Integer;
  S    : PAnsiChar;
  Len  : Word;
begin
  if (edCurLine > edParas.LineCount) then
    edCurLine := edParas.LineCount;

  if Col = 0 then begin
    edParas.NthLine(edCurLine, S, Len);
    Col := edParas.EffCol(S, Len, edCurCol);
  end;
  if not edCaretInWindow(Col) then begin
    X := MaxSmallInt;
    Y := MaxSmallInt;
  end else begin
    X := FLeftMargin + (Col-Succ(edHDelta))*edColWid;
    Y := (edCurLine-edTopLine)*edRowHt;
  end;
  if GetFocus = Handle then begin
    {adjust caret position if using a wide cursor}
    if (edCaret.CaretType.Shape in [csBlock, csHalfBlock, csHorzLine]) or
       (edCaret.CaretType.CaretWidth > 4) then
      Inc(X);
    edCaret.Position := Point(X-1, Y);
  end;

  PostMessage(Handle, om_ShowStatus, Col, edCurLine);
end;

procedure TOvcCustomEditor.edReadBookmarkGlyphs;
  {-read the bitmaps for the bookmarkers}
begin
  if (csDesigning in ComponentState) then
    Exit;

  {destroy glyphs if already loaded}
  edBMGlyphs.Free;
  edBMGlyphs := nil;
  edBMGlyphs := TBitMap.Create;
  edBMGlyphs.Handle := LoadOvcBaseBitMap('MARKERS');
end;

procedure TOvcCustomEditor.edReadMargin(Reader : TReader);
begin
  FLeftMargin := Reader.ReadInteger;
  FRightMargin := FLeftMargin;
end;

{!!.13} {added}
procedure TOvcCustomEditor.edRecreateWnd;
var
  PF       : TForm;
  HadFocus : Boolean;
begin
  HadFocus := Focused;
  if HadFocus then begin
    PF := TForm(GetParentForm(Self));
    if Assigned(PF) then
      SendMessage(PF.Handle, WM_NEXTDLGCTL, 0, 0);
  end;
  RecreateWnd;
  if HadFocus then
    SetFocus;
end;

procedure TOvcCustomEditor.edRedraw(Now : Boolean);
  {-redraw the editor}
begin
  if not edRedrawPending then begin
    edRedrawPending := True;
    Invalidate;
  end;
  if Now then
    Update;
end;

procedure TOvcCustomEditor.edRefreshLines(Start, Stop : LongInt);
var
  CR     : TRect;
  R1, R2 : LongInt;
  Last   : LongInt;
  T      : LongInt;
begin
  if edRedrawPending then
    Exit;

  if Start > Stop then begin
    T := Stop;
    Stop := Start;
    Start := T;
  end;
  Last := edTopLine+Pred(edRows);
  if (Start > Last) or (Stop < edTopLine) then
    Exit;

  R1 := Start-edTopLine;
  if R1 < 0 then
    R1 := 0;
  R2 := Stop-edTopLine;
  if R2 > Pred(edRows) then
    R2 := Pred(edRows);
  CR := ClientRect;
  CR.Top := R1*edRowHt;
  if R2 <> Pred(edRows) then
    CR.Bottom := Succ(R2)*edRowHt;
  InvalidateRect(Handle, @CR, False);
end;

function TOvcCustomEditor.edReplaceSelection(P : PAnsiChar) : Word;
var
  SaveLinking : Boolean;
begin
  if ReadOnly then begin
    Result := 0;
    Exit;
  end;

  if edHaveHighlight then begin
    edParas.UndoBuffer.BeginComplexOp(SaveLinking);
    edDeleteSelection;
  end else
    SaveLinking := False;

  Result := edInsertTextAtCaret(P);
  edParas.UndoBuffer.EndComplexOp(SaveLinking);
end;

procedure TOvcCustomEditor.edResetHighlight(Refresh : Boolean);
  {-reset the highlight to the position of the cursor}
var
  HadH    : Boolean;
  SaveBgn : TOvcTextPos;
  SaveEnd : TOvcTextPos;
  Len     : Word;
  Delta   : Word;
begin
  HadH := edHaveHighlight;
  SaveBgn := edHltBgnL;
  SaveEnd := edHltEndL;
  edHltBgn.Para := edCurPara;
  edHltBgn.Pos := edLinePos+edCurCol;
  Len := edParas.ParaLength(edCurPara);
  if edHltBgn.Pos > Len then begin
    Delta := edHltBgn.Pos-(Len+1);
    Dec(edHltBgn.Pos, Delta);
  end else
    Delta := 0;
  edHltEnd := edHltBgn;
  edAnchor := edHltBgn;

  edHltBgnL.Line := edCurLine;
  edHltBgnL.Col := edCurCol-Delta;
  edHltEndL := edHltBgnL;

  if Refresh and HadH then
    edRefreshLines(SaveBgn.Line, SaveEnd.Line);
end;

procedure TOvcCustomEditor.edResetPositionInfo;
  {-reset position info}
var
  C   : Integer;
  Len : Word;
begin
  {reset edCurLine, edCurCol, edLinePos}
  edCurLine := edParas.FindLineByPara(edCurPara, edLinePos+edCurCol, edCurCol);
  if edParas.WordWrap then begin
    Len := edParas.LineLength(edCurLine);
    if edCurCol > Len then
      edCurCol := Len+1;
  end;
  edParas.FindParaByLine(edCurLine, edLinePos);

  {reset edTopLine and edTopPos}
  edChangeTopLine(edParas.FindLineByPara(edTopPara, edTopPos+1, C));
  edParas.FindParaByLine(edTopLine, edTopPos);

  {reset edHltBgnL and edHltEndL}
  edHltBgnL.Line :=
    edParas.FindLineByPara(edHltBgn.Para, edHltBgn.Pos, edHltBgnL.Col);
  edHltEndL.Line :=
    edParas.FindLineByPara(edHltEnd.Para, edHltEnd.Pos, edHltEndL.Col);

  {check horizontal scrolling}
  edSetHScrollRange;
  if edHDelta > edHSMax then
    edHDelta := edHSMax;

  {reset scroll bars and redraw}
  ResetScrollBars(True);
end;

procedure TOvcCustomEditor.edScrollPrim(HDelta : Integer; VDelta : LongInt);
var
  CR    : TRect;
  SaveD : Integer;
  SaveT : LongInt;
  CRW   : Integer;
  CRH   : Integer;
  HD    : Integer;
  VD    : Integer;
begin
  SaveD := edHDelta;
  if HDelta < 0 then
    if Abs(HDelta) > edHDelta then
      edHDelta := 0
    else
      Inc(edHDelta, HDelta)
  else
    Inc(edHDelta, HDelta);

  SaveT := edTopLine;
  try
    Inc(edTopLine, VDelta);
    if edTopLine < 1 then
      edTopLine :=1
    else if edTopLine > edParas.LineCount - Pred(edRows) then begin
      edTopLine := edParas.LineCount - Pred(edRows);
      if edTopLine < 1 then
        edTopLine := 1;
    end;

    if (edTopLine = SaveT) and (edHDelta = SaveD) then begin
      edPositionCaret(0);
      Exit;
    end;

    if (edTopLine <> SaveT) then begin
      edTopPara := edParas.FindParaByLine(edTopLine, edTopPos);
      edSetVScrollPos;
    end;
    if (edHDelta <> SaveD) then
      edSetHScrollPos;

    CR := ClientRect;
    Inc(CR.Left, FLeftMargin);
    CR.Right := CR.Left+(edCols*edColWid);
    CR.Bottom := edRowHt*edRows;
    CRW := CR.Right-CR.Left;
    CRH := CR.Bottom-CR.Top;

    HD := SaveD-edHDelta;
    if Abs(HD) > CRW then
      HD := CRW+1
    else
      HD := HD*edColWid;

    VD := SaveT-edTopLine;
    if Abs(VD) > CRH then
      VD := CRH+1
    else
      VD := VD*edRowHt;

    if edRedrawPending then
      {update display now}
      Update
    else if (Abs(HD) >= CRW) or (Abs(VD) >= CRH) or ((HD <> 0) and (VD <> 0)) then
      edRedraw(True)
    else begin
      {scroll the window}
      ScrollWindow(Handle, HD, VD, @CR, @CR);

      {see if the left margin needs to be scrolled}
      if FShowBookmarks and (VD <> 0) then begin
        CR := ClientRect;
        CR.Right := FLeftMargin;
        CR.Bottom := edRowHt*edRows;
        ScrollWindow(Handle, 0, VD, @CR, @CR);
      end;

      {make sure display is updated}
      Update;
    end;
  finally
    if edTopLine <> SaveT then begin
      SaveT := edTopLine;
      {force notification of top line change}
      edTopLine := 0;
      edChangeTopLine(SaveT);
    end;
  end;
end;

function TOvcCustomEditor.edSearchReplace(FS, RS : PAnsiChar; Options : TSearchOptionSet) : LongInt;
type
  SearchFunc = function(var Buffer; BufLength : Cardinal;
                        var BT : BTable; Match : PAnsiChar;
                        var Pos : Cardinal) : Boolean;
var
  Replace       : Boolean;
  Found         : Boolean;
  MatchCase     : Boolean;
  WholeWord     : Boolean;
  FindForward   : Boolean;
  FindSelection : Boolean;
  Global        : Boolean;
  SFunc         : SearchFunc;
  CurPara       : LongInt;
  CurPos        : Integer;
  SearchLen     : Integer;
  ReplaceLen    : Integer;
  S             : PAnsiChar;
  I             : Cardinal;
  SLen          : Word;
  BT            : BTable;
  Count         : LongInt;
  RangeLo       : TMarker;
  RangeHi       : TMarker;
  MatchString   : array[0..MaxSearchString] of AnsiChar;
  ReplaceString : array[0..MaxSearchString] of AnsiChar;

  procedure SetValidRange;
  begin
    if FindSelection then begin
      RangeLo := edHltBgn;
      RangeHi := edHltEnd;
    end else if Global then begin
      RangeLo.Para := 1;
      RangeLo.Pos := 1;
      RangeHi.Para := edParas.ParaCount+1;
      RangeHi.Pos := 1;
    end else if FindForward then begin
      RangeLo.Para := CurPara;
      RangeLo.Pos := CurPos;
      RangeHi.Para := edParas.ParaCount+1;
      RangeHi.Pos := 1;
    end else begin
      RangeLo.Para := 1;
      RangeLo.Pos := 1;
      RangeHi.Para := CurPara;
      RangeHi.Pos := CurPos;
    end;
  end;

  function WholeWordCheck : Boolean;
  var
    Pos2 : Integer;
  begin
    if not WholeWord then
      WholeWordCheck := True
    else begin
      Pos2 := CurPos+SearchLen-1;
      if (CurPos > 1) and not edIsWordDelim(S[CurPos-2]) then
        WholeWordCheck := False
      else if (Pos2 < SLen) and not edIsWordDelim(S[Pos2]) then
        WholeWordCheck := False
      else
        WholeWordCheck := True;
    end;
  end;

  function InValidRange : Boolean;
  var
    Pos2 : Integer;
  begin
    Pos2 := CurPos+SearchLen-1;
    {CurPara is guaranteed to be in RangeLo.Para..RangeHi.Para}
    if (CurPara > RangeLo.Para) and (CurPara < RangeHi.Para) then
      InValidRange := True
    else if (RangeLo.Para = RangeHi.Para) then
      InValidRange := (CurPos >= RangeLo.Pos) and (Pos2 < RangeHi.Pos)
    else if (CurPara = RangeLo.Para) then
      InValidRange := CurPos >= RangeLo.Pos
    else {CurPara = RangeHi.Para}
      InValidRange := Pos2 < RangeHi.Pos;
  end;

  procedure FixRange;
  var
    D : Integer;
  begin
    D := ReplaceLen-SearchLen;
    with edParas do
      if D > 0 then begin
        FixMarkerInsertedText(RangeLo, CurPara, CurPos+SearchLen, D);
        FixMarkerInsertedText(RangeHi, CurPara, CurPos+SearchLen, D);
      end else if D < 0 then begin
        FixMarkerDeletedText(RangeLo, CurPara, CurPos+SearchLen, -D);
        FixMarkerDeletedText(RangeHi, CurPara, CurPos+SearchLen, -D);
      end;
  end;

  function FindLastInstance(First, Last : Integer) : Integer;
    {-find the last instance of the search string between columns First
      and Last in the current paragraph}
  var
    SaveFirst : Integer;
    I, J      : Cardinal;
  begin
    SaveFirst := First;
    Inc(First);
    while Succ(Last-First) >= SearchLen do begin
      J := Succ(Last-First);
      if not SFunc(S[First-1], J, BT, MatchString, I) then begin
        Result := SaveFirst;
        Exit;
      end else begin
        SaveFirst := First + LongInt(I);                               {!!.D4}
        Inc(First, I+1);
      end;
    end;
    Result := SaveFirst;
  end;

  procedure NextPara;
    {-move cursor to beginning of next paragraph}
  begin
    Inc(CurPara);
    if CurPara <= edParas.ParaCount then begin
      S := GetPara(CurPara, SLen);
      CurPos := 1;
    end;
  end;

  procedure PrevPara;
    {-move cursor to end of previous paragraph}
  begin
    Dec(CurPara);
    if CurPara > 0 then begin
      S := GetPara(CurPara, SLen);
      CurPos := SLen;
    end;
  end;

  procedure MakeReplacement;
  begin
    Result := edParas.ReplaceText(Self, CurPara, CurPos, SearchLen,
                                  ReplaceString, ReplaceLen);
    if Result = 0 then begin
      S := GetPara(CurPara, SLen);
      Inc(Count);
      FixRange;
    end;
  end;

begin
  Result := 0;

  {get search string}
  S := FS;
  if S = nil then
    Exit;

  StrCopy(MatchString, S);
  SearchLen := StrLen(MatchString);
  if SearchLen = 0 then
    Exit;

  {determine the type of the operation}
  Replace := (soReplace in Options) or (soReplaceAll in Options);
  FindForward := not (soBackward in Options);
  MatchCase := soMatchCase in Options;
  WholeWord := soWholeWord in Options;
  FindSelection := soSelText in Options;
  Global := soGlobal in Options;

  {is it a replace/all?}
  if Replace then begin
    if RS = nil then
      Exit;

    {get replacement string}
    StrCopy(ReplaceString, RS);
    ReplaceLen := StrLen(ReplaceString);
  end;

  Count := 0;
  if Replace then begin
    {make sure this is a legitimate replacement operation}
    if edIsStringHighlighted(MatchString, MatchCase) then begin
      Result := edReplaceSelection(ReplaceString);
      if Result <> 0 then begin
        DoOnError(Result);
        Exit;
      end;
      Count := 1;
    end;
  end;

  {where do we start and which direction do we go?}
  if FindSelection then begin
    if FindForward then begin
      {start at beginning of selection}
      CurPara := edHltBgn.Para;
      CurPos := edHltBgn.Pos;
    end else begin
      {start at end of selection}
      CurPara := edHltEnd.Para;
      CurPos := edHltEnd.Pos;
    end
  end else if not Global then begin
    {start at current position of cursor}
    CurPara := edCurPara;
    CurPos := edLinePos+edCurCol;
  end else if FindForward then begin
    {start at beginning of file}
    CurPara := 1;
    CurPos := 1;
  end else begin
    {start at end of file}
    CurPara := edParas.ParaCount;
    CurPos := edParas.ParaLength(CurPara)+1;
  end;

  {set valid search range}
  SetValidRange;

  {get the current paragraph}
  S := GetPara(CurPara, SLen);

  {set up for search}
  if MatchCase then
    SFunc := BMSearch
  else begin
    AnsiUpper(MatchString);
    SFunc := BMSearchUC;
  end;
  BMMakeTable(MatchString, BT);

  {display the hourglass cursor}
  Screen.Cursor := crHourGlass;
  Found := False;
  try
    if not FindForward then begin
      Dec(CurPos);
      repeat
        if (SLen < SearchLen) or (CurPos < SearchLen) then
          PrevPara
        else begin
          {look for a match in this paragraph}
          if not SFunc(S[0], CurPos, BT, MatchString, I) then
            PrevPara
          else begin
            {find the last instance of the string prior to the cursor}
            CurPos := FindLastInstance(I+1, CurPos);
            if (not WholeWordCheck) or (not InValidRange) then
              Dec(CurPos)
            else if soReplaceAll in Options then begin
              MakeReplacement;
              Dec(CurPos);
            end else begin
              Found := True;
              edSetSelectionPP(CurPara, CurPos, CurPara, CurPos+SearchLen, False);
            end;
          end;
        end;
      until (CurPara < RangeLo.Para) or Found or (Result <> 0);
    end else begin
      repeat
        I := Succ(SLen-CurPos);
        if LongInt(I) < SearchLen then
          NextPara
        else begin
          {look for a match in this paragraph starting at CurPos}
          if not SFunc(S[CurPos-1], I, BT, MatchString, I) then
            NextPara
          else begin
            Inc(CurPos, I);
            if (not WholeWordCheck) or (not InValidRange) then
              Inc(CurPos)
            else if soReplaceAll in Options then begin
              MakeReplacement;
              Inc(CurPos, ReplaceLen);
            end else begin
              Found := True;
              edSetSelectionPP(CurPara, CurPos, CurPara, CurPos+SearchLen, True);
            end;
          end;
        end;
      until (CurPara > RangeHi.Para) or Found or (Result <> 0);
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  if (soReplaceAll in Options) and (Count <> 0) then begin
    if FindSelection then
      edSetSelectionPP(RangeLo.Para, RangeLo.Pos, RangeHi.Para, RangeHi.Pos,
        CompHltPos(edAnchor, edHltEnd) = 0)
    else
      edResetHighlight(False);
    edRedraw(True);
  end;

  if Result <> 0 then
    DoOnError(Result)
  else if Count <> 0 then
    Result := Count
  else if not Found then
    Result := -1;
end;

procedure TOvcCustomEditor.edSetCaretSize;
  {-set caret size}
begin
  {set character height and width}
  edCaret.CellHeight := edRowHt;
  edCaret.CellWidth := edColWid;
  edCaret.InsertMode := InsertMode;
end;

procedure TOvcCustomEditor.edSetHScrollPos;
begin
  if not HandleAllocated then
    Exit;

  if edHScroll then
    SetScrollPos(Handle, SB_HORZ, edHDelta, True);
  edPendingHSP := False;
end;

procedure TOvcCustomEditor.edSetHScrollRange;
begin
  if not HandleAllocated then
    Exit;

  {determine the maximum scroll range}
  if edParas.WordWrap then
    edHSMax := edParas.WrapColumn
  else
    edHSMax := edParas.MaxParaLen;
  if edHSMax > MaxHScrollRange then
    edHSMax := MaxHScrollRange;

  {force scrollbar if needed}
  if (edHSMax <= 0) and FScrollBarsAlways then
    edHSMax := 1;  {force scroll bar}

  {set the scroll range}
  if edHScroll then begin
    if (edHSMax > edCols) or FScrollBarsAlways then
      SetScrollRange(Handle, SB_HORZ, 0, edHSMax, False)
    else
      SetScrollRange(Handle, SB_HORZ, 0, 0, False);
  end else
    SetScrollRange(Handle, SB_HORZ, 0, 0, False);
end;

procedure TOvcCustomEditor.edSetSelectionPP(Para1 : LongInt; Pos1 : Integer;
                                      Para2 : LongInt; Pos2 : Integer;
                                      CaretAtEnd : Boolean);
var
  Line1 : LongInt;
  Line2 : LongInt;
  Col1  : Integer;
  Col2  : Integer;
begin
  Line1 := edParas.FindLineByPara(Para1, Pos1, Col1);
  Line2 := edParas.FindLineByPara(Para2, Pos2, Col2);
  SetSelection(Line1, Col1, Line2, Col2, CaretAtEnd);
end;

procedure TOvcCustomEditor.edSetSelPrim(Para1 : LongInt; Pos1 : Integer;
                             Para2 : LongInt; Pos2 : Integer);
begin
  edHltBgn.Para := Para1;
  edHltBgn.Pos := Pos1;
  edHltEnd.Para := Para2;
  edHltEnd.Pos := Pos2;
end;

procedure TOvcCustomEditor.edSetVScrollPos;
begin
  if not HandleAllocated then
    Exit;

  if edVScroll then
    SetScrollPos(Handle, SB_VERT, edTopLine div edDivisor, True);
  edPendingVSP := False;
end;

procedure TOvcCustomEditor.edSetVScrollRange;
  {-set the vertical scroll bar range}
var
  Size : LongInt;
begin
  if not HandleAllocated then
    Exit;

  {determine the maximum scroll range}
  Size := edParas.LineCount - Pred(edRows);
  if Size < 0 then
    Size := 0;

  if Size <= MaxSmallInt then
    edDivisor := 1
  else
    edDivisor := 2*(Size div 32768);

  {scale the maximum range}
  edVSMax := Size div edDivisor;

  {force scrollbar if needed}
  if (edVSMax <= 1) and FScrollBarsAlways then
    edVSMax := 2;

  {set the scroll range}
  if edVScroll then begin
    if (edParas.LineCount > edRows) or FScrollBarsAlways then
      SetScrollRange(Handle, SB_VERT, 1, edVSMax, False)
    else
      SetScrollRange(Handle, SB_VERT, 1, 1, False);
  end else
    SetScrollRange(Handle, SB_VERT, 0, 0, False);

  {clear scroll pending flag}
  edPendingVSR := False;
end;

procedure TOvcCustomEditor.edUpdateHighlight(Refresh : Boolean);
var
  SaveBgnL : TOvcTextPos;
  SaveEndL : TOvcTextPos;
  SaveBgn  : TMarker;
  SaveEnd  : TMarker;
  TmpPos   : TMarker;
  SwpPos   : TMarker;
  Len      : Word;
  Start    : LongInt;
  Stop     : LongInt;

  procedure UpdateStartStop(L : LongInt);
  begin
    if L < Start then
      Start := L
    else if L > Stop then
      Stop := L;
  end;

begin
  SaveBgn := edHltBgn;
  SaveEnd := edHltEnd;
  SaveBgnL := edHltBgnL;
  SaveEndL := edHltEndL;
  TmpPos.Para := edCurPara;
  TmpPos.Pos := edLinePos+edCurCol;
  Len := edParas.ParaLength(edCurPara);
  if TmpPos.Pos > Len then
    TmpPos.Pos := Len+1;

  if CompHltPos(edAnchor, edHltBgn) = 0 then
    edHltBgn := TmpPos
  else
    edHltEnd := TmpPos;

  if CompHltPos(edHltBgn, edHltEnd) = 1 then begin
    SwpPos := edHltEnd;
    edHltEnd := edHltBgn;
    edHltBgn := SwpPos;
  end;

  edAnchor := TmpPos;
  if CompHltPos(SaveBgn, edHltBgn) = 0 then
    if CompHltPos(SaveEnd, edHltEnd) = 0 then
      Exit;

  if CompHltPos(SaveBgn, edHltBgn) <> 0 then
    edHltBgnL.Line :=
      edParas.FindLineByPara(edHltBgn.Para, edHltBgn.Pos, edHltBgnL.Col);
  if CompHltPos(SaveEnd, edHltEnd) <> 0 then
    edHltEndL.Line :=
      edParas.FindLineByPara(edHltEnd.Para, edHltEnd.Pos, edHltEndL.Col);

  if Refresh then begin
    Start := edCurLine;
    Stop := edCurLine;

    if SaveBgnL.Line <> edHltBgnL.Line then begin
      UpdateStartStop(SaveBgnL.Line);
      UpdateStartStop(edHltBgnL.Line);
    end;

    if SaveEndL.Line <> edHltEndL.Line then begin
      UpdateStartStop(SaveEndL.Line);
      UpdateStartStop(edHltEndL.Line);
    end;

    edRefreshLines(Start, Stop);
  end;
end;

procedure TOvcCustomEditor.edUpdateHScrollPos;
begin
  edPendingHSP := True;
end;

procedure TOvcCustomEditor.edUpdateOnInsertedText(N : LongInt; Pos, Count : Integer);
var
  PEF, PEC : TOvcCustomEditor;
begin
  PEF := edNext;
  PEC := PEF;
  repeat
    PEC.edUpdateOnInsertedTextPrim(N, Pos, Count, PEC = Self);
    PEC := PEC.edNext;
  until (PEC = PEF);
end;

procedure TOvcCustomEditor.edUpdateOnInsertedTextPrim(N : LongInt; Pos, Count : Integer;
                                           Current : Boolean);
var
  M       : TMarker;
  SaveBgn : TMarker;
  SaveEnd : TMarker;
  SP      : LongInt;
  C       : Integer;
  SPos    : Integer;
begin
  {fix edTopLine and edTopPos}
  SP := edTopPara;
  M.Para := SP;
  M.Pos := edTopPos+1;
  if (N < SP) or ((N = SP) and (Pos < M.Pos)) then begin
    edParas.FixMarkerInsertedText(M, N, Pos, Count);
    edChangeTopLine(edParas.FindLineByPara(SP, M.Pos, C));
    if (N = SP) then
      edParas.FindParaByLine(edTopLine, edTopPos);
  end;
  if Current then
    Exit;

  {fix edCurLine, edCurCol, and edLinePos}
  SP := edCurPara;
  M.Para := SP;
  M.Pos := edLinePos+edCurCol;
  SPos := M.Pos;
  if N = SP then
    edParas.FixMarkerInsertedText(M, N, Pos, Count);
  if N <= SP then
    edCurLine := edParas.FindLineByPara(SP, M.Pos, edCurCol);
  if (N = SP) and (Pos <= SPos) then
    edParas.FindParaByLine(edCurLine, edLinePos);

  {fix selection highlight}
  SaveBgn := edHltBgn;
  SaveEnd := edHltEnd;
  edParas.FixMarkerInsertedText(edHltBgn, N, Pos, Count);
  edParas.FixMarkerInsertedText(edHltEnd, N, Pos, Count);
  edParas.FixMarkerInsertedText(edAnchor, N, Pos, Count);
  if CompHltPos(SaveBgn, edHltBgn) <> 0 then
    edHltBgnL.Line :=
      edParas.FindLineByPara(edHltBgn.Para, edHltBgn.Pos, edHltBgnL.Col);
  if CompHltPos(SaveEnd, edHltEnd) <> 0 then
    edHltEndL.Line :=
      edParas.FindLineByPara(edHltEnd.Para, edHltEnd.Pos, edHltEndL.Col);

  {update display}
  edUpdateVScrollRange;
  edUpdateVScrollPos;
  edUpdateHScrollPos;
  edRedraw(False);
end;

procedure TOvcCustomEditor.edUpdateOnInsertedPara(N : LongInt; Pos, Indent : Integer);
var
  PEF, PEC : TOvcCustomEditor;
begin
  PEF := edNext;
  PEC := PEF;
  repeat
    PEC.edUpdateOnInsertedParaPrim(N, Pos, Indent, PEC = Self);
    PEC := PEC.edNext;
  until (PEC = PEF);
end;

procedure TOvcCustomEditor.edUpdateOnInsertedParaPrim(N : LongInt; Pos, Indent : Integer;
                                           Current : Boolean);
var
  M       : TMarker;
  SaveBgn : TMarker;
  SaveEnd : TMarker;
  SP      : LongInt;
  C       : Integer;
begin
  {fix edTopPara, edTopLine, and edTopPos}
  SP := edTopPara;
  if N <= SP then begin
    M.Para := SP;
    M.Pos := edTopPos+1;
    if Current and (N = SP) and (Pos = M.Pos) then
      Exit;

    edParas.FixMarkerInsertedPara(M, N, Pos, Indent);
    edTopPara := M.Para;
    edChangeTopLine(edParas.FindLineByPara(edTopPara, M.Pos, C));
    if N = SP then
      edParas.FindParaByLine(edTopLine, edTopPos);
  end;
  if Current then
    Exit;

  {fix edCurPara, edCurLine, and edCurCol}
  SP := edCurPara;
  M.Para := SP;
  M.Pos := edLinePos+edCurCol;
  if N <= SP then begin
    edParas.FixMarkerInsertedPara(M, N, Pos, Indent);
    edCurPara := M.Para;
    edCurLine := edParas.FindLineByPara(edCurPara, M.Pos, edCurCol);
    if N = SP then
      edParas.FindParaByLine(edCurLine, edLinePos);
  end;

  {fix selection highlight}
  SaveBgn := edHltBgn;
  SaveEnd := edHltEnd;
  edParas.FixMarkerInsertedPara(edHltBgn, N, Pos, Indent);
  edParas.FixMarkerInsertedPara(edHltEnd, N, Pos, Indent);
  edParas.FixMarkerInsertedPara(edAnchor, N, Pos, Indent);
  if CompHltPos(SaveBgn, edHltBgn) <> 0 then
    edHltBgnL.Line :=
      edParas.FindLineByPara(edHltBgn.Para, edHltBgn.Pos, edHltBgnL.Col);
  if CompHltPos(SaveEnd, edHltEnd) <> 0 then
    edHltEndL.Line :=
      edParas.FindLineByPara(edHltEnd.Para, edHltEnd.Pos, edHltEndL.Col);

  {update display}
  edUpdateVScrollRange;
  edUpdateVScrollPos;
  edUpdateHScrollPos;
  edRedraw(False);
end;

procedure TOvcCustomEditor.edUpdateOnDeletedPara(N : LongInt);
var
  PEF, PEC : TOvcCustomEditor;
begin
  PEF := edNext;
  PEC := PEF;
  repeat
    PEC.edUpdateOnDeletedParaPrim(N, PEC = Self);
    PEC := PEC.edNext;
  until (PEC = PEF);
end;

procedure TOvcCustomEditor.edUpdateOnDeletedParaPrim(N : LongInt; Current : Boolean);
var
  M       : TMarker;
  SaveBgn : TMarker;
  SaveEnd : TMarker;
  SP      : LongInt;
  C       : Integer;
begin
  {fix edTopLine and edTopPos}
  SP := edTopPara;
  if N <= SP then begin
    M.Para := SP;
    M.Pos := edTopPos+1;
    edParas.FixMarkDeletedPara(M, N);
    if (N < SP) or (edTopPos <> 0) then begin
      edTopPara := M.Para;
      edChangeTopLine(edParas.FindLineByPara(edTopPara, M.Pos, C));
      if N = SP then
        edParas.FindParaByLine(edTopLine, edTopPos);
    end;
  end;
  if Current then
    Exit;

  {fix edCurLine, edCurCol, and edLinePos}
  SP := edCurPara;
  if N <= SP then begin
    M.Para := SP;
    M.Pos := edLinePos+edCurCol;
    edParas.FixMarkDeletedPara(M, N);
    edCurPara := M.Para;
    edCurLine := edParas.FindLineByPara(edCurPara, M.Pos, edCurCol);
    if N = SP then
      edParas.FindParaByLine(edCurLine, edLinePos);
  end;

  {fix selection highlight}
  if (N = edHltBgn.Para) and (N = edHltEnd.Para) then begin
    {highlighted text was deleted--get rid of selection}
    edHltBgn := M;
    edHltEnd := M;
    edAnchor := M;
    edHltBgnL.Line := edCurLine;
    edHltBgnL.Col := edCurCol;
    edHltEndL := edHltBgnL;
  end else begin
    SaveBgn := edHltBgn;
    SaveEnd := edHltEnd;
    edParas.FixMarkDeletedPara(edHltBgn, N);
    edParas.FixMarkDeletedPara(edHltEnd, N);
    edParas.FixMarkDeletedPara(edAnchor, N);
    if CompHltPos(SaveBgn, edHltBgn) <> 0 then
      edHltBgnL.Line :=
        edParas.FindLineByPara(edHltBgn.Para, edHltBgn.Pos, edHltBgnL.Col);
    if CompHltPos(SaveEnd, edHltEnd) <> 0 then
      edHltEndL.Line :=
        edParas.FindLineByPara(edHltEnd.Para, edHltEnd.Pos, edHltEndL.Col);
  end;

  {update display}
  edUpdateVScrollRange;
  edUpdateVScrollPos;
  edUpdateHScrollPos;
  edRedraw(False);
end;

procedure TOvcCustomEditor.edUpdateOnDeletedText(N : LongInt; Pos, Count : Integer);
var
  PEF, PEC : TOvcCustomEditor;
begin
  PEF := edNext;
  PEC := PEF;
  repeat
    PEC.edUpdateOnDeletedTextPrim(N, Pos, Count, PEC = Self);
    PEC := PEC.edNext;
  until (PEC = PEF);
end;

procedure TOvcCustomEditor.edUpdateOnDeletedTextPrim(N : LongInt;
          Pos, Count : Integer; Current : Boolean);
var
  M       : TMarker;
  SaveBgn : TMarker;
  SaveEnd : TMarker;
  SP      : LongInt;
  C       : Integer;
  SPos    : Integer;
begin
  {fix edTopLine and edTopPos}
  SP := edTopPara;
  M.Para := SP;
  M.Pos := edTopPos+1;
  if (N <= SP) then begin
    edParas.FixMarkDeletedText(M, N, Pos, Count);
    edChangeTopLine(edParas.FindLineByPara(SP, M.Pos, C));
    if (N = SP) then
      edParas.FindParaByLine(edTopLine, edTopPos);
  end;
  if Current then
    Exit;

  {fix edCurLine, edCurCol, and edLinePos}
  SP := edCurPara;
  M.Para := SP;
  M.Pos := edLinePos+edCurCol;
  SPos := M.Pos;
  if N = SP then
    edParas.FixMarkDeletedText(M, N, Pos, Count);
  if N <= SP then
    edCurLine := edParas.FindLineByPara(SP, M.Pos, edCurCol);
  if (N = SP) and (Pos <= SPos) then
    edParas.FindParaByLine(edCurLine, edLinePos);

  {fix selection highlight}
  SaveBgn := edHltBgn;
  SaveEnd := edHltEnd;
  edParas.FixMarkDeletedText(edHltBgn, N, Pos, Count);
  edParas.FixMarkDeletedText(edHltEnd, N, Pos, Count);
  edParas.FixMarkDeletedText(edAnchor, N, Pos, Count);
  if CompHltPos(SaveBgn, edHltBgn) <> 0 then
    edHltBgnL.Line :=
      edParas.FindLineByPara(edHltBgn.Para, edHltBgn.Pos, edHltBgnL.Col);
  if CompHltPos(SaveEnd, edHltEnd) <> 0 then
    edHltEndL.Line :=
      edParas.FindLineByPara(edHltEnd.Para, edHltEnd.Pos, edHltEndL.Col);

  {update display}
  edUpdateVScrollRange;
  edUpdateVScrollPos;
  edUpdateHScrollPos;
  edRedraw(False);
end;

procedure TOvcCustomEditor.edUpdateOnJoinedParas(N : LongInt; Pos : Integer);
var
  PEF, PEC : TOvcCustomEditor;
begin
  PEF := edNext;
  PEC := PEF;
  repeat
    PEC.edUpdateOnJoinedParasPrim(N, Pos, PEC = Self);
    PEC := PEC.edNext;
  until (PEC = PEF);
end;

procedure TOvcCustomEditor.edUpdateOnJoinedParasPrim(N : LongInt; Pos : Integer;
                                          Current : Boolean);
var
  M       : TMarker;
  SaveBgn : TMarker;
  SaveEnd : TMarker;
  SP      : LongInt;
  C       : Integer;
begin
  {fix edTopLine and edLinePos}
  SP := edTopPara;
  if N <= SP then begin
    M.Para := SP;
    M.Pos := edTopPos+1;
    edParas.FixMarkerJoinedParas(M, N, Pos);
    edTopPara := M.Para;
    edChangeTopLine(edParas.FindLineByPara(edTopPara, M.Pos, C));
    edParas.FindParaByLine(edTopLine, edTopPos);
  end;
  if Current then
    Exit;

  {fix edCurLine, edCurCol, and edLinePos}
  SP := edCurPara;
  M.Para := SP;
  M.Pos := edLinePos+edCurCol;
  if N < SP then begin
    edParas.FixMarkerJoinedParas(M, N, Pos);
    edCurPara := M.Para;
    edCurLine := edParas.FindLineByPara(edCurPara, M.Pos, edCurCol);
    if N+1 = SP then
      edParas.FindParaByLine(edCurLine, edLinePos);
  end;

  {fix selection highlight}
  SaveBgn := edHltBgn;
  SaveEnd := edHltEnd;
  edParas.FixMarkerJoinedParas(edHltBgn, N, Pos);
  edParas.FixMarkerJoinedParas(edHltEnd, N, Pos);
  edParas.FixMarkerJoinedParas(edAnchor, N, Pos);
  if CompHltPos(SaveBgn, edHltBgn) <> 0 then
    edHltBgnL.Line :=
      edParas.FindLineByPara(edHltBgn.Para, edHltBgn.Pos, edHltBgnL.Col);
  if CompHltPos(SaveEnd, edHltEnd) <> 0 then
    edHltEndL.Line :=
      edParas.FindLineByPara(edHltEnd.Para, edHltEnd.Pos, edHltEndL.Col);

  {update display}
  edUpdateVScrollRange;
  edUpdateVScrollPos;
  edUpdateHScrollPos;
  edRedraw(False);
end;

procedure TOvcCustomEditor.edUpdateVScrollPos;
begin
  edPendingVSP := True;
end;

procedure TOvcCustomEditor.edUpdateVScrollRange;
begin
  edPendingVSR := True;
end;

procedure TOvcCustomEditor.edVScrollPrim(Delta : LongInt);
begin
  edScrollPrim(0, Delta);
end;

procedure TOvcCustomEditor.edWordLeft(Shift : Boolean);
  {-cursor left one word}
var
  S    : PAnsiChar;
  Len  : Word;
  Para : LongInt;
  Line : LongInt;
  Pos  : Integer;
begin
  Para := edCurPara;
  Pos := edLinePos+edCurCol;
  S := GetPara(Para, Len);
  if Pos > 1 then begin
    if Pos > Len then
      Pos := Len+1;
    Dec(Pos);
    while (Pos > 0) and edIsWordDelim(S[Pos-1]) do
      Dec(Pos);
    while (Pos > 0) and not edIsWordDelim(S[Pos-1]) do
      Dec(Pos);
    Inc(Pos);
    edMoveCaretToPP(Para, Pos, Shift);
  end else if Para > 1 then begin
    Line := edCurLine-1;
    edMoveCaretTo(Line, edParas.LineLength(Line)+1, Shift);
  end;
end;

procedure TOvcCustomEditor.edWordRight(Shift : Boolean);
  {-cursor right one word}
var
  S    : PAnsiChar;
  Len  : Word;
  Para : LongInt;
  Pos  : Integer;
begin
  Para := edCurPara;
  Pos := edLinePos+edCurCol;
  S := GetPara(Para, Len);
  if Pos <= Len then begin
    while (Pos <= Len) and not edIsWordDelim(S[Pos-1]) do
      Inc(Pos);
    while (Pos <= Len) and edIsWordDelim(S[Pos-1]) do
      Inc(Pos);
    edMoveCaretToPP(Para, Pos, Shift);
  end else
    edMoveCaretTo(edCurLine+1, 1, Shift);
end;

function TOvcCustomEditor.EffectiveColumn(S : PAnsiChar; Col : Integer) : Integer;
  {-get the effective column in S for column Col}
begin
  Result := edParas.EffCol(S, StrLen(S), Col);
end;

{!!.11}
procedure TOvcCustomEditor.EndUpdate;
  {-allow window updates}
begin
  Perform(WM_SETREDRAW, 1, 0);
  Invalidate;
end;

procedure TOvcCustomEditor.FlushUndoBuffer;
  {-flush the undo buffer}
begin
  edParas.UndoBuffer.Flush;
end;

function TOvcCustomEditor.GetCaretPosition(var Col : Integer) : LongInt;
  {-returns current line number as result, column in Col}
begin
  Col := edCurCol;
  Result := edCurLine;
end;

function TOvcCustomEditor.GetCurrentWord : string;
  {-return the word at the current caret position}
var
  P    : PAnsiChar;
  Len  : Word;
  Pos1 : Integer;
  Pos2 : Integer;
begin
  P := GetPara(edCurPara, Len);
  Pos1 := edLinePos+edCurCol-1;
  {is the caret at the start or within a word}
  if (Pos1 < Len) and not edisWordDelim(P[Pos1]) then begin

    {find beginning of this word}
    while (Pos1 > 0) and not edIsWordDelim(P[Pos1]) do
      Dec(Pos1);
    while (Pos1 < Len-1) and edIsWordDelim(P[Pos1]) do
      Inc(Pos1);

    {find end of this word}
    Pos2 := Pos1;
    while (Pos2 < Len-1) and not edIsWordDelim(P[Pos2]) do
      Inc(Pos2);
    while (Pos2 > 0) and edIsWordDelim(P[Pos2]) do
      Dec(Pos2);

    {copy the word}
    Len := Pos2 - Pos1 + 1;
    {$IFDEF Win32}
      SetLength(Result, Len);
    {$ELSE}
      if Len > 255 then
        Len := 255;
      Result[0] := Char(Len);
    {$ENDIF}
    Move(P[Pos1], Result[1], Len);

  end else
    Result := '';
end;

function TOvcCustomEditor.GetFirstEditor : TOvcCustomEditor;
  {-return pointer to first editor}
begin
  {whoever owns edParas is the first editor}
  Result := TOvcCustomEditor(edParas.Owner);
end;

function TOvcCustomEditor.GetInsCaretType : TOvcCaret;
  {-return the current caret type}
begin
  Result := edCaret.InsCaretType;
end;

function TOvcCustomEditor.GetLine(LineNum : LongInt; Dest : PAnsiChar;
         DestLen : Integer) : PAnsiChar;
  {-get the specified line}
begin
  Result := Dest;
  Result[0] := #0;
  if (LineNum < 1) or (LineNum > edParas.LineCount) then
    raise EInvalidLineOrPara.Create
  else
    edGetEditLine(LineNum, Result, DestLen);
end;

function TOvcCustomEditor.GetLeftColumn : Integer;
  {-return the left-most visible column number}
begin
  Result := Succ(edHDelta);
end;

function TOvcCustomEditor.GetLineCount : LongInt;
  {-get the total number of lines}
begin
  Result := edParas.LineCount;
end;

function TOvcCustomEditor.GetLineLength(LineNum : LongInt) : Integer;
  {-get the length of the line}
begin
  if (LineNum < 1) or (LineNum > edParas.LineCount) then
    raise EInvalidLineOrPara.Create
  else
    Result := edParas.LineLength(LineNum)
end;

function TOvcCustomEditor.GetMarkerPosition(N : Byte; var Col : Integer) : LongInt;
  {-return the current position of the specified marker}
begin
  Result := -1;
  if N < MaxMarkers then begin
    Result := edParas.Markers[N].Para;
    Col    := edParas.Markers[N].Pos;
    if (Result > 0) and (Col > 0) then
      ParaToLine(Result, Col)
    else                                                               {!!.10}
      Result := -1;                                                    {!!.10}
  end;
end;

function TOvcCustomEditor.GetModified : Boolean;
  {-get the value of the modified flag}
begin
  Result := edParas.Modified;
end;

procedure TOvcCustomEditor.GetMousePos(var L : LongInt; var C : Integer;
                                       Existing : Boolean);
  {-return line and column based on current mouse position}
var
  P : TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if not PtInRect(ClientRect, P) and Existing then begin
    L := -1;
    C := -1;
  end else
    edGetMousePos(L, C);
end;

function TOvcCustomEditor.GetNextEditor : TOvcCustomEditor;
  {-return pointer to next editor}
begin
  Result := edNext;
end;

function TOvcCustomEditor.GetOvrCaretType : TOvcCaret;
  {-return the current caret type}
begin
  Result := edCaret.OvrCaretType;
end;

function TOvcCustomEditor.GetPara(ParaNum : LongInt; var Len : Word) : PAnsiChar;
  {-get the specified paragraph}
var
  S   : PAnsiChar;
  PPN : TParaNode;
begin
  if (ParaNum < 1) or (ParaNum > edParas.ParaCount) then
    raise EInvalidLineOrPara.Create;

  PPN := edParas.NthPara(ParaNum);
  if PPN = nil then begin
    S := '';
    Len := 0;
  end else begin
    S := PPN.GetS;
    Len := PPN.SLen;
  end;
  Result := S;
end;

function TOvcCustomEditor.GetParaLength(ParaNum : LongInt) : Integer;
  {-get the length of the paragraph ParaNum}
begin
  if (ParaNum < 1) or (ParaNum > edParas.ParaCount) then
    raise EInvalidLineOrPara.Create
  else
    Result := edParas.ParaLength(ParaNum);
end;

function TOvcCustomEditor.GetParaPointer(ParaNum : LongInt) : PAnsiChar;
  {-get a pointer to the specified paragraph}
var
  Len : Word;
begin
  if (ParaNum < 1) or (ParaNum > edParas.ParaCount) then
    raise EInvalidLineOrPara.Create
  else
    Result := GetPara(ParaNum, Len);
end;

function TOvcCustomEditor.GetPrevEditor : TOvcCustomEditor;
  {-return pointer to previous editor}
begin
  Result := edPrev;
end;

function TOvcCustomEditor.GetPrintableLine(LineNum : LongInt;
         Dest : PAnsiChar; DestLen : Integer) : Integer;
  {-get a line in a format suitable for printing}
var
  S, T : PAnsiChar;
  I, L : Word;
  C    : AnsiChar;
begin
  if (LineNum < 1) or (LineNum > edParas.LineCount) then
    raise EInvalidLineOrPara.Create;

  edParas.NthLine(LineNum, S, L);
  Dest[0] := #0;
  if (L > 0) and edHaveTabs(S, L) then begin
    I := edEffectiveLen(S, L, edParas.TabSize);
    if I <= DestLen then begin
      C := S[L];
      S[L] := #0;
      DetabPChar(Dest, S, edParas.TabSize);
      S[L] := C;
    end else begin
      C := S[L];
      S[L] := #0;
      GetMem(T, I+1);
      try
        StrLCopy(Dest, DetabPChar(T, S, edParas.TabSize), DestLen);
      finally
        FreeMem(T, I+1);
      end;
      S[L] := C;
    end;
  end else begin
    if DestLen > L then
      DestLen := L;
    StrLCopy(Dest, S, DestLen);
  end;

  Result := StrLen(Dest);
end;

function TOvcCustomEditor.GetReadOnly : Boolean;
  {-return read-only status}
begin
  Result := FReadOnly;
end;

function TOvcCustomEditor.GetSelection(var Line1 : LongInt; var Col1 : Integer;
                              var Line2 : LongInt; var Col2 : Integer) : Boolean;
  {-returns True if any text is currently selected}
begin
  if edHaveHighlight then begin
    with edParas do begin
      Line1 := FindLineByPara(edHltBgn.Para, edHltBgn.Pos, Col1);
      Line2 := FindLineByPara(edHltEnd.Para, edHltEnd.Pos, Col2);
    end;
    Result := True;
  end else
    Result := False;
end;

function TOvcCustomEditor.GetSelTextBuf(Buffer : PAnsiChar; BufSize: LongInt) : LongInt;
  {-return the selected text in Buffer and len as Result}
var
  BC, EC : Integer;
  BP, EP : LongInt;
  Len    : Word;
  P      : PAnsiChar;
  I, N   : LongInt;
begin
  if edHaveHighlight then begin
    Dec(BufSize);

    BP := edHltBgn.Para;
    BC := edHltBgn.Pos;
    EP := edHltEnd.Para;
    EC := edHltEnd.Pos;

    if (BP = EP) then begin
      {all selected text is in the current paragraph}
      Result := EC - BC;
      if Result > BufSize then
        Result := BufSize;
      P := GetPara(BP, Len);
      Move(P[BC-1], Buffer^, Result);

      {add null at end of buffer}
      Buffer[Result] := #0;
    end else begin
      {get text from first partial para}
      P := GetPara(BP, Len);
      I := Len-BC+1;
      if I > BufSize then
        I := BufSize;
      Move(P[BC-1], Buffer^, I);
      Inc(Buffer, I);

      {add crlf}
      if I+2 <= BufSize then begin
        Move(CRLF, Buffer^, 2);
        Inc(Buffer, 2);
        Inc(I, 2);
      end;

      {get text from all except last para}
      for N := BP+1 to EP-1 do begin
        P := GetPara(N, Len);

        {is there room for the para and the crlf}
        if Len+2 > BufSize-I then
          Len := BufSize-I;
        Move(P^, Buffer^, Len);
        Inc(Buffer, Len);
        Inc(I, Len);
        if I+2 <= BufSize then begin
          Move(CRLF, Buffer^, 2);
          Inc(Buffer, 2);
          Inc(I, 2);
        end;
        if I >= BufSize then
          Break;
      end;

      {get text from last partial para}
      if I < BufSize then begin
        P := GetPara(EP, Len);
        Len := EC-1;
        if Len > BufSize-I then
          Len := BufSize-I;
        Move(P^, Buffer^, Len);
        Inc(Buffer, Len);
        Inc(I, Len);
        if I+2 <= BufSize then begin
          Move(CRLF, Buffer^, 2);
          Inc(Buffer, 2);
          Inc(I, 2);
        end;
      end;

      {add terminating null}
      Buffer^ := #0;

      {return bytes moved}
      Result := I;
    end;
  end else begin
    Buffer[0] := #0;
    Result := 0;
  end;
end;

function TOvcCustomEditor.GetSelTextLen : LongInt;
  {-return the length of the selected text}
var
  BC, EC : Integer;
  BP, EP : LongInt;
  Len    : Word;
  N      : LongInt;
begin
  if edHaveHighlight then begin
    BP := edHltBgn.Para;
    BC := edHltBgn.Pos;
    EP := edHltEnd.Para;
    EC := edHltEnd.Pos;

    if (BP = EP) then
      Result := EC - BC {all selected text is in the current paragraph}
    else begin
      {get length of first partial para}
      GetPara(BP, Len);
      Result := Len-BC+1+2;

      {get length of all except last para}
      for N := BP+1 to EP-1 do begin
        GetPara(N, Len);
        Inc(Result, Len + 2);
      end;

      {get length of last partial para}
      GetPara(EP, Len);
      Len := EC-1;
      Inc(Result, Len + 2);
    end;
  end else
    Result := 0;
end;

function TOvcCustomEditor.GetStringLine(LineNum : LongInt) : string;
  {-return the text for the specified line}
var
  I : Integer;
begin
  Result := '';
  if (LineNum < 1) or (LineNum > edParas.LineCount) then
    raise EInvalidLineOrPara.Create;

  {$IFDEF Win32}
    {$IFOPT H+}
     {I := edParas.LineLength(LineNum);}                               {!!.12}
      I := edParas.EffLen(LineNum);                                    {!!.12}
      if I = 0 then
        Exit;

      SetLength(Result, I);
      I := GetPrintableLine(LineNum, PAnsiChar(Result), I);
      SetLength(Result, I);
    {$ELSE}
      I := GetPrintableLine(LineNum, @Result[1], SizeOf(string)-1);
      Result[0] := Chr(I);
    {$ENDIF}
  {$ELSE}
    I := GetPrintableLine(LineNum, @Result[1], SizeOf(string)-1);
    Result[0] := Chr(I);
  {$ENDIF}

end;

function TOvcCustomEditor.GetText(P : PAnsiChar; Size : LongInt) : LongInt;
  {-copy text in editor into P; limit is Size (includes null)}
var
  S    : PAnsiChar;
  Len  : Word;
  I, N : LongInt;
begin
  Result := 0;
  if Size = 0 then
    Exit;

  Dec(Size);
  N := 0;
  I := 0;
  repeat
    Inc(N);
    S := GetPara(N, Len);
    if I+Len+2 > Size then
      Len := Size-I;
    Move(S^, P^, Len);
    Inc(P, Len);
    Inc(I, Len);
    if I+2 <= Size then begin
      Move(CRLF, P^, 2);
      Inc(P, 2);
    end;
    Inc(I, 2);
  until (N = edParas.ParaCount) or (I >= Size);
  P^ := #0;

  {return bytes moved plus one for the null char}
  if I+1 > Size then
    Result := Size
  else
    Result := I+1;
end;

function TOvcCustomEditor.GetTextBuf(Buffer : PAnsiChar; BufSize : LongInt) : LongInt;
  {-copy text in editor into Buffer; limit is Size (includes null)}
begin
  Result := GetText(Buffer, BufSize);
end;

function TOvcCustomEditor.GetTextLen : LongInt;
  {-get the total number of bytes of text}
begin
  Result := edParas.ByteCount;
end;

function TOvcCustomEditor.GetTopLine : LongInt;
  {-get the number of line at the top of window}
begin
  Result := edTopLine;
end;

function TOvcCustomEditor.GetVisibleColumns : Integer;
  {-get the number of visible columns}
begin
  HandleNeeded;
  Result := edCols;
end;

function TOvcCustomEditor.GetVisibleRows : Integer;
  {-get the number of visible rows}
begin
  HandleNeeded;
  Result := edRows;
end;

procedure TOvcCustomEditor.GotoMarker(N : Byte);
begin
  if N < MaxMarkers then
    if (edParas.Markers[N].Para <> 0) and (edParas.Markers[N].Pos <> 0) then
      with edParas.Markers[N] do
        edMoveCaretToPP(Para, Pos, False);
end;

{!!.01} {added}
function TOvcCustomEditor.HasSelection : Boolean;
  {-return True if any text is selected}
begin
  Result := edHaveHighlight;
end;

procedure TOvcCustomEditor.Insert(S : PAnsiChar);
begin
  edReplaceSelection(S);
end;

procedure TOvcCustomEditor.InsertString(const S : string);
  {-replace the current selection with a text string}
var
  P   : PChar;
  {$IFDEF Win32}
    {$IFOPT H-}
    Buf : array[0..255] of Char;
    {$ENDIF}
  {$ELSE}
    Buf : array[0..255] of Char;
  {$ENDIF}
begin
  {$IFDEF Win32}
    {$IFOPT H+}
      P := PChar(S);
    {$ELSE}
      P := @Buf;
      StrPCopy(Buf, S);
    {$ENDIF}
  {$ELSE}
    P := @Buf;
    StrPCopy(Buf, S);
  {$ENDIF}
  edReplaceSelection(P);
end;

procedure TOvcCustomEditor.LineToPara(var L : LongInt; var C : Integer);
  {-convert a Line,Col coordinate to a Paragraph,Pos coordinate}
var
  LinePos : Integer;
begin
  if (L < 1) or (L > edParas.LineCount) then
    raise EInvalidLineOrPara.Create;
  L := edParas.FindParaByLine(L, LinePos);
  Inc(C, LinePos);
end;

procedure TOvcCustomEditor.OMShowStatus(var Msg : TOMShowStatus);
begin
  DoOnShowStatus(Msg.Line, Msg.Column);
end;

procedure TOvcCustomEditor.Paint;
var
  Clip        : TRect;
  I           : Integer;
  FR, CR      : TRect;
  TC, BC      : TColor;
  HTC, HBC    : TColor;
  SA          : PAnsiChar;     {actual string, w/o tab expansion}
  SALen       : Word;          {length of SA}
  ST          : PAnsiChar;     {string with tab expansion}
  NoHighlight : Boolean;
  FirstRow    : Integer;
  LastRow     : Integer;
  FarRt       : Integer;
  HBLine      : LongInt;
  HELine      : LongInt;
  HBCol       : Integer;
  HECol       : Integer;
  effHBCol    : Integer;                                               {!!.01}
  effHECol    : Integer;                                               {!!.01}

  procedure NormalColors;
  begin
    Canvas.Font.Color := TC;
    Canvas.Brush.Color := BC;
  end;

  procedure HighlightColors;
  begin
    HTC := Graphics.ColorToRGB(FHighlightColors.TextColor);
    HBC := Graphics.ColorToRGB(FHighlightColors.BackColor);
    Canvas.Font.Color := HTC;
    Canvas.Brush.Color := HBC;
  end;

  procedure DrawBookMark(N : LongInt; Row : Integer); near;
  var
    Y   : Integer;
    HM  : Integer;
    I   : Integer;
    DR  : TRect;
    SR  : TRect;
    PL  : LongInt;
    PC  : Integer;
    BMW : Integer;
    BMH : Integer;
  begin
    HM := -1;
    if N > -1 then
      for I := 0 to MaxMarkers-1 do begin
        if (edParas.Markers[I].Para <> 0) and (edParas.Markers[I].Pos <> 0) then begin
          PL := edParas.Markers[I].Para;
          PC := edParas.Markers[I].Pos;
          ParaToLine(PL, PC);
          if (PL = N) then begin
            HM := I;
            Break;
          end;
        end;
      end;
    if HM < 0 then
      Exit;

    BMW := edBMGlyphs.Width div MaxMarkers;
    BMH := edBMGlyphs.Height;
    if (BMW > 0) and (BMW <= FLeftMargin) then begin
      Y := Pred(Row)*edRowHt;
      if (edRowHt >= BMH+2) then  {center vertically}
        Y := Y + ((edRowHt-BMH) div 2);
      DR := Rect(1, Y, BMW+1, Y + BMH);
      SR := Rect(HM*BMW, 0, Succ(HM)*BMW, BMH);
      Canvas.CopyRect(DR, edBMGlyphs.Canvas, SR);
    end;
  end;

  procedure SetRowRect(R : LongInt);
  begin
    {set bounding rectangle for Row}
    FR.Top := Pred(R)*edRowHt;
    FR.Bottom := FR.Top+edRowHt;
    if FR.Bottom > CR.Bottom then
      FR.Bottom := CR.Bottom;
  end;

  procedure DrawAt(S : PAnsiChar; Len, Row : Integer);
  const
    etoFlags = ETO_OPAQUE + ETO_CLIPPED;
  begin
    {set bounding rectangle}
    SetRowRect(Row);

    {draw the string}
    if Len = 0 then
      Canvas.FillRect(FR)
    else
      ExtTextOut(Canvas.Handle, FR.Left, FR.Top+1, etoFlags, @FR, S, Len, nil);
  end;

  procedure DrawComplexRow(S : PAnsiChar; Len, Row : Integer; N : LongInt);
    {-draw a row that has highlighting}
  var
    Len1, Len2, Len3, Col1 : Integer;
  begin
    Col1 := edHDelta+1;
    Len1 := 0;
    Len2 := 0;
    Len3 := 0;
    {is entire line unhighlighted?}
    if NoHighlight or (N < HBLine) or (N > HELine) then
      Len1 := Len

    {is entire line highlighted?}
    else if (N > HBLine) and (N < HELine) then
      Len2 := Len

    {is this the first highlighted line?}
    else if (N = HBLine) then begin
      {is this the only highlighted line?}
      if (N = HELine) then begin
        Len1 := edParas.EffCol(SA, SALen, HBCol)-Col1;
        if Len1 < 0 then
          Len1 := 0;
        Len2 := edParas.EffCol(SA, SALen, HECol)-(Col1+Len1);
        if Len1+Len2 > Len then
          Len2 := Len-Len1;
        Len3 := Len-(Len1+Len2);
        if Len3 > Len then                                             {!!.13}
          Len3 := Len;                                                 {!!.13}
      end else begin
        Len1 := edParas.EffCol(SA, SALen, HBCol)-Col1;
        if Len1 < 0 then
          Len1 := 0;
        Len2 := Len-Len1;
        Len3 := Len-(Len1+Len2);
      end

    {it's the last line--is highlighted portion visible?}
    end else if (Col1 > edParas.EffCol(SA, SALen, HECol)) then
      {no--display unhighlighted}
      Len1 := Len
    else begin
      Len2 := edParas.EffCol(SA, SALen, HECol)-Col1;
      if Len2 > Len then
        Len2 := Len;
      Len3 := Len-Len2;
    end;

    if Len1 > 0 then begin
      {draw first unhighlighted portion of line}
      if Len1 <> Len then
        FR.Right := FR.Left+(Len1*edColWid);
      DrawAt(S, Len1, Row);
      Inc(S, Len1);
      FR.Left := FR.Right;
      FR.Right := FarRt;
    end;

    if Len2 > 0 then begin
      {draw highlighted portion of line}
      if LongInt(FR.Left)+(Len2*edColWid) > FarRt then
        FR.Right := FarRt
      else
        FR.Right := FR.Left+(Len2*edColWid);

      HighlightColors;
      DrawAt(S, Len2, Row);
      NormalColors;

      Inc(S, Len2);
      FR.Left := FR.Right;
      FR.Right := FarRt;
    end;

    if (FR.Left < FR.Right) then
      {draw last unhighlighted portion of line}
      DrawAt(S, Len3, Row);
  end;

  procedure DrawRow(N : LongInt; Row : Integer);
    {-draw line N on the specified Row of the window}
  var
    S, T      : PAnsiChar;
    I, Len    : Word;
    AllocSize : Word;
    C         : AnsiChar;
  begin
    if (Row < FirstRow) or (Row > LastRow) then
      Exit;

    {get the string}
    if (N > edParas.LineCount) or (N < 0) then begin
      SA := '';
      if Assigned(FOnDrawLine) then begin
        {set bounding rectangle}
        SetRowRect(Row);
        if not DoOnDrawLine(Canvas, FR, SA, 0, N, edHDelta, edCols,
               HBLine, effHBCol, HELine, effHECol) then                {!!.01}
          DrawAt(SA, 0, Row)
      end else
        DrawAt(SA, 0, Row)
    end else begin
      T := nil;
      AllocSize := 0;
      edParas.NthLine(N, S, Len);
      SA := S;
      ST := S;
      SALen := Len;

      if (Len > 0) and edHaveTabs(S, Len) then begin
        I := edEffectiveLen(S, Len, edParas.TabSize);
        AllocSize := I+1;
        GetMem(T, AllocSize);
        C := S[Len];
        S[Len] := #0;
        DetabPChar(T, S, edParas.TabSize);
        S[Len] := C;
        S := T;
        ST := T;
        Len := I;
      end;

      if edHDelta >= Len then begin
        S := '';
        SA := S;
        ST := S;
        Len := 0;
      end else begin
        S := @S[edHDelta];
        Dec(Len, edHDelta);
        if Len > edCols then
          Len := edCols;
      end;

      if Assigned(FOnDrawLine) then begin
        {set bounding rectangle}
        SetRowRect(Row);
        if not DoOnDrawLine(Canvas, FR, ST, StrLen(ST), N, edHDelta,
               edCols, HBLine, effHBCol, HELine, effHECol) then begin  {!!.01}
          if (Len = 0) then
            DrawAt(S, 0, Row)
          else
            DrawComplexRow(S, Len, Row, N);
        end;
      end else begin
        if (Len = 0) then
          DrawAt(S, 0, Row)
        else
          DrawComplexRow(S, Len, Row, N);
      end;

      if (T <> nil) and (AllocSize > 0) then
        FreeMem(T, AllocSize);
    end;

    {reset FR}
    FR.Left := CR.Left + FLeftMargin;
    FR.Right := FarRt;
  end;

  procedure DrawEdges;
  var
    R : TRect;
  begin
    {draw left edge}
    R := Clip;
    R.Left := CR.Left;
    R.Right := CR.Left + FLeftMargin;
    Canvas.FillRect(R);

    {draw right edge}
    R.Left := FarRt;
    R.Right := CR.Right;
    Canvas.FillRect(R);
  end;

begin
  {set canvas defaults}
  Canvas.Font := FixedFont.Font;
  Canvas.Brush.Color := Color;

  {get the client rectangle}
  CR := ClientRect;
  FR := CR;
  Inc(FR.Left, FLeftMargin);
  FR.Right := FR.Left+(edCols*edColWid);
  FarRt := FR.Right;

  {figure out which rows to update}
  {get the cliping region}
  GetClipBox(Canvas.Handle, Clip);
  FirstRow := (Clip.Top div edRowHt)+1;
  LastRow :=  (Clip.Bottom+Pred(edRowHt)) div edRowHt;
  if LastRow = edRows then
    LastRow := edRows+1;

  {get colors}
  if not Enabled then
    TC := clGrayText
  else
    TC := FixedFont.Color;
  BC := Color;
  HTC := Graphics.ColorToRGB(FHighlightColors.TextColor);
  HBC := Graphics.ColorToRGB(FHighlightColors.BackColor);

  {do we need to highlight text?}
  NoHighlight := (not Enabled) or (not edHaveHighlight);

  {if we don't have the focus and we should hide the selection}
  {then we can repaint without highlighing text}
  if not NoHighlight then
    if FHideSelection and not (GetFocus = Handle) then
      NoHighlight := True;

  if NoHighlight then begin
    HBLine := 0;
    HBCol := 0;
    HELine := 0;
    HECol := 0;

    {effective columns for owner-draw line}                            {!!.01}
    effHBCol := 0;                                                     {!!.01}
    effHECol := 0;                                                     {!!.01}
  end else begin
    HBLine := edHltBgnL.Line;
    HBCol := edHltBgnL.Col;
    HELine := edHltEndL.Line;
    HECol := edHltEndL.Col;

    {effective columns for owner-draw line}                            {!!.01}
    edParas.NthLine(HBLine, SA, SALen);                                {!!.01}
    effHBCol := edParas.EffCol(SA, SALen, HBCol);                      {!!.01}
    edParas.NthLine(HELine, SA, SALen);                                {!!.01}
    effHECol := edParas.EffCol(SA, SALen, HECol);                      {!!.01}
  end;

  {draw edges of window}
  DrawEdges;

  {draw markers}
  if FShowBookMarks then
    for I := 1 to edRows do
      DrawBookmark(edTopLine+Pred(I), I);

  {setup normal colors}
  NormalColors;

  {display the text}
  for I := 1 to edRows do
    DrawRow(edTopLine+Pred(I), I);

  {do we need to fill in the partial line at the bottom of the window?}
  if LastRow > edRows then
    DrawAt('', 0, LastRow);

  edRedrawPending := False;

  {any pending scroll bar updates to take care of?}
  if edPendingVSR then
    edSetVScrollRange;
  if edPendingVSP then
    edSetVScrollPos;
  if edPendingHSP then
    edSetHScrollPos;

  {conditionally position the caret}
  edPositionCaret(0);
end;

function TOvcCustomEditor.ParaCount : LongInt;
  {-return the total number of paragraphs}
begin
  Result := edParas.ParaCount;
end;

procedure TOvcCustomEditor.ParaToLine(var L : LongInt; var C : Integer);
  {-convert a Paragraph,Pos coordinate to a Line,Col coordinate}
begin
  if (L < 1) or (L > edParas.ParaCount) then
    raise EInvalidLineOrPara.Create
  else
    L := edParas.FindLineByPara(L, C, C);
end;

{!!.11}
{$IFDEF Win32}
procedure TOvcCustomEditor.PasteFromClipboard;
var
  H   : THandle;
  P   : PAnsiChar;
  Res : Word;
begin
  if ReadOnly then
    Exit;

  OpenClipboard(Handle);
  try
    H := GetClipboardData(CF_TEXT);
    if H <> 0 then begin
      P := PAnsiChar(GlobalLock(H));
      try
        Res := edReplaceSelection(P);
      finally
        GlobalUnlock(H);
      end;
    end else
      Res := 0;
  finally
    CloseClipboard;
  end;

  DoOnError(Res);

  {adjust scroll range}
  edSetVScrollRange;

  {force top line update and refresh scroll position}
  edScrollPrim(0, 0);
end;
{$ELSE}
{!!.01} {revised}
procedure TOvcCustomEditor.PasteFromClipboard;
var
  H   : THandle;
  P   : PAnsiChar;
  Res : Word;
begin
  if ReadOnly then
    Exit;

  OpenClipboard(Handle);
  try
    H := GetClipboardData(CF_TEXT);
    if H <> 0 then begin
      if GlobalSize(H) <= $FFF0 then begin
        P := PAnsiChar(GlobalLock(H));
        try
          Res := edReplaceSelection(P);
        finally
          GlobalUnlock(H);
        end;
      end else
        Res := oeRegionSize;
    end else
      Res := 0;
  finally
    CloseClipboard;
  end;

  DoOnError(Res);

  {adjust scroll range}
  edSetVScrollRange;

  {force top line update and refresh scroll position}
  edScrollPrim(0, 0);
end;
{$ENDIF}

function TOvcCustomEditor.ProcessCommand(Cmd, CharCode : Word) : Boolean;
  {-process the specified command, return true if processed}
var
  Page : Integer;
begin
  Result := True;
  if edRows = 1 then
    Page := 1
  else
    Page := Pred(edRows);

  case Cmd of
    ccBack : {process backspace command}
      if ReadOnly then
        edCaretLeft(False)
      else
        edBackspace;
    ccBotOfPage : {cursor to bottom of window}
      if (edCurLine >= edTopLine) and (edCurLine <= Pred(edTopLine+edRows)) then
        edMoveCaret(0, Pred(edTopLine+edRows)-edCurLine, False, False)
      else
        TopLine := edCurLine-Pred(edRows);
    ccChar : {process normal character input}
      if not ReadOnly then
        edInsertChar(AnsiChar(Lo(CharCode)));
    ccCopy : {copy highlighted text to clipboard}
      if edHaveHighlight then
        CopyToClipboard;
    ccCtrlChar : ; {do nothing}
    ccCut : {cut highlighted text to clipboard}
      CutToClipboard;
    ccDel : {delete highlighted text or char at cursor}
      edDeleteSelection;
    ccDelBol : {delete to beginning of line}                           {!!.12}
      edDeleteToBeginning;                                             {!!.12}
    ccDelEol : {delete to end of line}
      edDeleteToEnd;
    ccDelLine : {delete current line}
      edDeleteLine;
    ccDelWord : {delete word at cursor}
      edDeleteWord;
    ccDown : {cursor down one row}
      edMoveCaret(0, +1, False, False);
    ccEnd : {caret to end of line}
      edMoveToEndOfLine(False);
    ccExtendDown : {extend selection down one row}
      edMoveCaret(0, +1, False, True);
    ccExtendEnd : {extend selection  to end of line}
      edMoveToEndOfLine(True);
    ccExtendHome : {extend selection to start of line}
      edMoveCaretTo(edCurLine, 1, True);
    ccExtendLeft : {extend selection to left one column}
      edCaretLeft(True);
    ccExtendPgDn : {extend selection down one page}
      edMoveCaret(0, +Page, True, True);
    ccExtendPgUp : {extend selection up one page}
      edMoveCaret(0, -Page, True, True);
    ccExtendRight : {extend selection right one character}
      edCaretRight(True);
    ccExtendUp : {cursor up one row}
      edMoveCaret(0, -1, False, True);
    ccExtBotOfPage : {extend highlight to bottom of current page}
      if (edCurLine >= edTopLine) and (edCurLine <= Pred(edTopLine+edRows)) then
        edMoveCaret(0, Pred(edTopLine+edRows)-edCurLine, False, True);
    ccExtFirstPage : {extend highlight to top of file}
      edMoveCaretTo(1, 1, True);
    ccExtLastPage : {extend highlight to bottom of file}
      edMoveCaretTo(edParas.LineCount, edParas.LineLength(edParas.LineCount)+1, True);
    ccExtTopOfPage : {extend highlight to top of current page}
      if (edCurLine >= edTopLine) and (edCurLine <= Pred(edTopLine+edRows)) then
        edMoveCaret(0, edTopLine-edCurLine, False, True);
    ccExtWordLeft : {extend highlight to left one word}
      edWordLeft(True);
    ccExtWordRight : {extend highlight to right one word}
      edWordRight(True);
    ccFirstPage : {cursor to top of file}
      edMoveCaretTo(1, 1, False);
    ccHome : {cursor to beginning of line}
      edMoveCaretTo(edCurLine, 1, False);
    ccIns : {toggle insert mode}
      SetInsertMode(not FInsertMode);
    ccLastPage : {cursor to end of file}
      edMoveCaretTo(edParas.LineCount, edParas.LineLength(edParas.LineCount)+1, False);
    ccLeft : {cursor left one column}
      edCaretLeft(False);
    ccNewLine : {start new line, cursor to next line}
      edNewLine(FInsertMode and not ReadOnly, True);
    ccTab :
      edDoTab;
    ccNextPage : {caret down one page}
      edMoveCaret(0, +Page, True, False);
    ccPaste : {paste text from clipboard}
      PasteFromClipboard;
    ccPrevPage : {cursor up one page}
      edMoveCaret(0, -Page, True, False);
    ccRedo : {redo last undone change}
      Redo;
    ccUndo : {undo changes to current line}
      Undo;
    ccRight : {cursor right one column}
      edCaretRight(False);
    ccScrollDown : {scroll display down one row}
      edVScrollPrim(+1);
    ccScrollUp : {scroll display up one row}
      edVScrollPrim(-1);
    ccTopOfPage : {cursor to top of window}
      if (edCurLine >= edTopLine) and (edCurLine <= Pred(edTopLine+edRows)) then
        edMoveCaret(0, edTopLine-edCurLine, False, False)
      else
        TopLine := edCurLine;
    ccUp : {cursor up one row}
      edMoveCaret(0, -1, False, False);
    ccWordLeft : {cursor left one word}
      edWordLeft(False);
    ccWordRight : {cursor right one word}
      edWordRight(False);
    ccSetMarker0..ccSetMarker9 :
      SetMarker(CharCode - VK_0);
    ccGotoMarker0..ccGotoMarker9 :
      GotoMarker(CharCode - VK_0);
  else
    {do user command notification for user commands}
    if Cmd >= ccUserFirst then
      DoOnUserCommand(Cmd)
    else
      Result := False;
  end;

  {generate OnChange event}                                            {!!.10}
  case Cmd of
    ccBack, ccChar, ccCut, ccDel, ccDelBol, ccDelEol,                  {!!.12}
    ccDelLine, ccDelWord, {ccNewLine,}                          {!!.12}{!!.13}
    ccPaste, ccRedo, ccTab, ccUndo :
      DoOnChange;
  end;
end;

procedure TOvcCustomEditor.Redo;
var
  Pos : Integer;
  Col : Word;
begin
  if not CanRedo then begin
    MessageBeep(0);
    Exit;
  end;

  edParas.Redo(Self, edCurPara, Pos);

  edCurLine := edParas.FindLineByPara(edCurPara, Pos, edCurCol);
  edLinePos := Pos-edCurCol;

  edResetHighlight(False);
  edRedraw(False);
  Col := 0;
  if not edCaretInWindow(Col) then
    edMoveCaretTo(edCurLine, edCurCol, False)
end;

function TOvcCustomEditor.Replace(const S, R : string; Options : TSearchOptionSet) : LongInt;
  {-search for string S and replace with R, returning -1 if S not found,
    else a replacement count}
var
  S1, R1 : array[0..MaxSearchString] of AnsiChar;
begin
  StrPLCopy(S1, S, MaxSearchString);
  StrPLCopy(R1, R, MaxSearchString);
  Result := edSearchReplace(S1, R1, Options);
end;

procedure TOvcCustomEditor.ResetScrollBars(UpdateScreen : Boolean);
  {-reset scroll bars}
begin
  if HandleAllocated then begin
    edSetVScrollRange;
    edSetVScrollPos;
    edSetHScrollRange;
    edSetHScrollPos;

    {determine settings based on the current font}
    edCalcRowColInfo;

    {adjust wrap column}
    edAdjustWrapColumn;

    {update}
    edRedraw(UpdateScreen);
  end;
end;

function TOvcCustomEditor.Search(const S : string; Options : TSearchOptionSet) : Boolean;
  {-search for string S, returning True if found}
var
  S1 : array[0..MaxSearchString] of AnsiChar;
begin
  StrPLCopy(S1, S, MaxSearchString);
  Result := edSearchReplace(S1, nil, Options) = 0;
end;

procedure TOvcCustomEditor.SelectAll(CaretAtEnd : Boolean);
  {-select all text in the editor}
begin
  SetSelection(1, 1, MaxLongInt, MaxSmallInt, CaretAtEnd);
end;

procedure TOvcCustomEditor.SetBorderStyle(const Value : TBorderStyle);
  {-set the style used for the border}
begin
  if Value <> FBorderStyle then begin
    FBorderStyle := Value;
    edRecreateWnd;                                                     {!!.13}
  end;
end;

procedure TOvcCustomEditor.SetByteLimit(Value : LongInt);
  {-set a limit on the total number of bytes}
begin
  if Value > -1 then begin
    edParas.SetByteLimit(Value);
    FByteLimit := edParas.MaxBytes;
  end;
end;

procedure TOvcCustomEditor.SetCaretPosition(Line : LongInt; Col : Integer);
  {-move cursor to Line,Col}
begin
  if (Line < 1) or (Line > edParas.LineCount) or (Col < 1) then
    raise EInvalidLineOrPara.Create
  else
    edMoveCaretTo(Line, Col, False);
end;

procedure TOvcCustomEditor.SetFixedFont(Value : TOvcFixedFont);
begin
  FFixedFont.Assign(Value);
end;

procedure TOvcCustomEditor.SetHideSelection(Value : Boolean);
  {-set the hide selection flag}
begin
  if Value <> FHideSelection then begin
    FHideSelection := Value;
    Repaint;
  end;
end;

procedure TOvcCustomEditor.SetInsCaretType(const Value : TOvcCaret);
  {-set the type of caret to use}
begin
  if Value <> edCaret.InsCaretType then
    edCaret.InsCaretType := Value;
end;

procedure TOvcCustomEditor.SetInsertMode(Value : Boolean);
  {-set the insert mode}
begin
  if FInsertMode <> Value then begin
    FInsertMode := Value;
    edCaret.InsertMode := FInsertMode;
    edPositionCaret(0);
  end;
end;

procedure TOvcCustomEditor.SetLeftMargin(Value : Integer);
  {-set the width of the left margin}
begin
  if (Value >= 0) and (Value <> FLeftMargin) then begin
    FLeftMargin := Value;
    {determine settings based on the current font}
    edCalcRowColInfo;

    {adjust wrap column}
    edAdjustWrapColumn;
    Refresh;
  end;
end;

procedure TOvcCustomEditor.SetMarker(N : Byte);
  {-set the specified text marker to the current cursor position}
begin
  if N < MaxMarkers then begin
    edParas.SetMarker(N, edCurPara, edLinePos+edCurCol);
    Refresh;
  end;
end;

procedure TOvcCustomEditor.SetMarkerAt(N : Byte; Line : LongInt; Col : Integer);
  {-set the specified text marker to the specified position}
begin
  if (N < MaxMarkers)  then begin
    if (Line < 1) or (Line > edParas.LineCount) or (Col < 1) then
      raise EInvalidLineOrCol.Create;
    edParas.SetMarkerAt(N, Line, Col);
    Refresh;
  end;
end;

procedure TOvcCustomEditor.SetModified(Value : Boolean);
  {-set the state of the modified flag}
var
  E : TOvcCustomEditor;
begin
  if edParas.Modified <> Value then begin
    edParas.Modified := Value;

    {update all attached windows, including this one}
    E := Self;
    repeat
      E.edRedraw(False);
      E := E.edNext;
    until E = Self;

    {if we're turning the flag off, any undo will modify the text}
    if not Value then
      edParas.UndoBuffer.SetModified;
  end;
end;

procedure TOvcCustomEditor.SetOvrCaretType(const Value : TOvcCaret);
  {-set the type of caret to use}
begin
  if Value <> edCaret.OvrCaretType then
    edCaret.OvrCaretType := Value;
end;

procedure TOvcCustomEditor.SetParaLengthLimit(Value : Integer);
  {-set limit on length of paragraphs}
begin
  if (Value > 0) and (Value <= MaxSmallInt) then begin                 {!!.01}
    edParas.MaxParaLen := Value;
    FParaLengthLimit := edParas.MaxParaLen;

    edSetHScrollRange;
    edSetHScrollPos;
  end;
end;

procedure TOvcCustomEditor.SetParaLimit(Value : LongInt);
  {-set a limit on the total number of paragraphs}
begin
  if Value > 0 then begin
    edParas.SetParaLimit(Value);
    FParaLimit := edParas.MaxParas;
  end;
end;

procedure TOvcCustomEditor.SetRightMargin(Value : Integer);
  {-set the width of the right margin}
begin
  if (Value >= 0) and (Value <> FRightMargin) then begin
    FRightMargin := Value;

    {determine settings based on the current font}
    edCalcRowColInfo;

    {adjust wrap column}
    edAdjustWrapColumn;
    Refresh;
  end;
end;

procedure TOvcCustomEditor.SetScrollbars(Value : TScrollStyle);
  {-set use of vertical and horizontal scroll bars}
begin
  if Value <> FScrollBars then begin
    FScrollBars := Value;
    if Value = ssNone then
      FScrollBarsAlways := False;
    edRecreateWnd;                                                     {!!.13}
  end;
end;

procedure TOvcCustomEditor.SetScrollbarsAlways(Value : Boolean);
  {-set use of scroll bars always}
begin
  if Value <> FScrollBarsAlways then begin
    if Value and (FScrollBars <> ssNone) then
      FScrollBarsAlways := True
    else
      FScrollBarsAlways := False;
    edRecreateWnd;                                                     {!!.13}
  end;
end;

procedure TOvcCustomEditor.SetScrollPastEnd(Value : Boolean);
  {-set scroll past end option}
begin
  if Value <> FScrollPastEnd then begin
    FScrollPastEnd := Value;
    if FScrollPastEnd then
      WordWrap := False;
  end;
end;

procedure TOvcCustomEditor.SetSelection(Line1 : LongInt; Col1 : Integer;
                               Line2 : LongInt; Col2 : Integer;
                               CaretAtEnd : Boolean);
begin
  if edParas.ByteCount > 0 then begin

    {force valid selection range}
    if Line1 < 1 then
      Line1 := 1;
    if Line1 > edParas.LineCount then
      Line1 := edParas.LineCount;
    if Line2 < 1 then
      Line2 := 1;
    if Line2 > edParas.LineCount then
      Line2 := edParas.LineCount;

    if Col1 < 1 then
      Col1 := 1;
    if Col1 > edParas.LineLength(Line1) then
      Col1 := edParas.LineLength(Line1)+1;
    if Col2 < 1 then
      Col2 := 1;
    if Col2 > edParas.LineLength(Line2) then
      Col2 := edParas.LineLength(Line2)+1;


    if CaretAtEnd then begin
      edCurLine := Line1;
      edCurCol := Col1;
      edCurPara := edParas.FindParaByLine(edCurLine, edLinePos);
      edResetHighlight(True);
      edMoveCaretTo(Line2, Col2, True);
    end else begin
      edCurLine := Line2;
      edCurCol := Col2;
      edCurPara := edParas.FindParaByLine(edCurLine, edLinePos);
      edResetHighlight(True);
      edMoveCaretTo(Line1, Col1, True);
    end;
  end;
end;

procedure TOvcCustomEditor.SetSelTextBuf(Buffer : PAnsiChar);
  {-replace selection with Buffer}
begin
  if not ReadOnly then
    edReplaceSelection(Buffer);
end;

procedure TOvcCustomEditor.SetShowBookmarks(Value : Boolean);
  {-set option to display bookmarks in left margin}
begin
  if Value <> FShowBookmarks then begin
    FShowBookmarks := Value;
    if Value then begin
      edReadBookmarkGlyphs;
      Refresh;
    end else begin
      edBMGlyphs.Free;
      edBMGlyphs := nil;
      Repaint;
    end;
  end;
end;

procedure TOvcCustomEditor.SetTabSize(Value : Byte);
  {-set the distance between tab stops}
begin
  if Value > 0 then begin
    edParas.SetTabSize(Value);
    FTabSize := edParas.TabSize;
    Repaint;
  end;
end;

procedure TOvcCustomEditor.SetTabType(Value : TTabType);
  {-set the tab type}
begin
  if Value <> FTabType then begin
    FTabType := Value;
    Repaint;
  end;
end;

procedure TOvcCustomEditor.SetText(P : PAnsiChar);
  {-set text of editor to P}
begin
  DeleteAll(False);
  edInsertTextAtCaret(P);
  ResetScrollBars(True);
end;

procedure TOvcCustomEditor.SetTextBuf(Buffer : PAnsiChar);
  {-set text of editor to Buffer}
begin
  SetText(Buffer);
end;

procedure TOvcCustomEditor.SetTopLine(Value : LongInt);
  {-set the index of the first visible line}
begin
  if (Value < 1) or (Value > edParas.LineCount) then
    raise EInvalidLineOrPara.Create;
  if Value <> edTopLine then
    edScrollPrim(0, Value-edTopLine);
end;

procedure TOvcCustomEditor.SetUndoBufferSize(Value : Word);
  {-set the size of the undo buffer. This destroys the existing buffer}
begin
  {if Value > -1 then begin}                                           {!!.D4}
    edParas.SetUndoSize(Value);
    FUndoBufferSize := edParas.UndoBuffer.BufSize;
  {end;}                                                               {!!.D4}
end;

procedure TOvcCustomEditor.SetWordDelimiters(Value : string);
  {set the characters that delimit words}
begin
  if Value > '' then
    FWordDelimiters := Value;
end;

procedure TOvcCustomEditor.SetWordWrap(Value : Boolean);
  {-turn word wrap on or off}
begin
  edParas.SetWordWrap(Value);
  FWordWrap := edParas.WordWrap;

  {if wordwrap is on, then wrap at left must also be on}
  if FWordWrap then begin
    {if wordwrap is on, then wrap at left must also be on}
    FWrapAtLeft := True;

    {and, ScrollPastEnd must be off}
    FScrollPastEnd := False;
  end;
end;

procedure TOvcCustomEditor.SetWrapAtLeft(Value : Boolean);
  {-set caret wrap at left option}
begin
  if edParas.WordWrap then
    {always true if in wordwrap mode}
    FWrapAtLeft := True
  else
    FWrapAtLeft := Value;
end;

procedure TOvcCustomEditor.SetWrapColumn(Value : Integer);
  {-set the column for word wrap}
begin
  if Value > 0 then begin;
    edParas.SetWrapColumn(Value);
    FWrapColumn := edParas.WrapColumn;
  end;
end;

procedure TOvcCustomEditor.SetWrapToWindow(Value : Boolean);
  {-set the option to automatically adjust the column for word wrap}
begin
  if Value <> FWrapToWindow then begin
    FWrapToWindow := Value;
    if HandleAllocated then
      edAdjustWrapColumn;
  end;
end;

procedure TOvcCustomEditor.Undo;
var
  Pos : Integer;
  Col : Word;
begin
  if not CanUndo then begin
    MessageBeep(0);
    Exit;
  end;

  edParas.Undo(Self, edCurPara, Pos);

  edCurLine := edParas.FindLineByPara(edCurPara, Pos, edCurCol);
  edLinePos := Pos-edCurCol;

  {adjust scroll range}
  edSetVScrollRange;

  {force top line update and refresh scroll position}
  edScrollPrim(0, 0);

  edResetHighlight(False);
  edRedraw(False);
  Col := 0;
  if not edCaretInWindow(Col) then
    edMoveCaretTo(edCurLine, edCurCol, False);
end;

procedure TOvcCustomEditor.WMChar(var Msg : TWMChar);
begin
  inherited;

  if not edSuppressChar and (Msg.CharCode >= VK_SPACE) then begin
    ProcessCommand(ccChar, Msg.CharCode);
    Msg.Result := 0;
  end;
end;

procedure TOvcCustomEditor.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  Msg.Result := 1;  {don't erase background}
end;

procedure TOvcCustomEditor.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;

  if csDesigning in ComponentState then
    Msg.Result := DLGC_STATIC
  else begin
    Msg.Result := Msg.Result or DLGC_WANTCHARS or DLGC_WANTARROWS or
                    DLGC_WANTALLKEYS;
    if FWantTab then
      Msg.Result := Msg.Result or DLGC_WANTTAB;
  end;
end;

procedure TOvcCustomEditor.WMHScroll(var Msg : TWMHScroll);
begin
  case Msg.ScrollCode of
    SB_LINERIGHT : edHScrollPrim(+1);
    SB_LINELEFT  : edHScrollPrim(-1);
    SB_PAGERIGHT : edHScrollPrim(+(VisibleColumns-1));
    SB_PAGELEFT  : edHScrollPrim(-(VisibleColumns-1));
    SB_THUMBPOSITION, SB_THUMBTRACK :
      if edHDelta <> Msg.Pos then begin
        edHDelta := Msg.Pos;
        edSetHScrollPos;
        edRedraw(True);
      end;
  end;
end;

procedure TOvcCustomEditor.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd  : Word;
begin
  inherited;

  {get command to process}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));

  if not ProcessCommand(Cmd, Msg.CharCode) then begin
    case Msg.CharCode of
      VK_RETURN : {start new line, cursor to next line}
        if FWantEnter then begin
          edNewLine(FInsertMode and not ReadOnly, True);
          Msg.Result := 0;
        end;
      VK_TAB : {process tab command}
        if FWantTab then begin
          edDoTab;
          Msg.Result := 0;
        end;
    end;

    {suppress the next key if this was a partial, otherwise clear flag}
    edSuppressChar := (Cmd = ccPartial);

    {suppress character generated for <CtrlBack>}                      {!!.11}
    if Msg.CharCode = VK_BACK then                                     {!!.11}
        edSuppressChar := True;                                        {!!.11}

  end else
    Msg.Result := 0;
end;

procedure TOvcCustomEditor.WMKillFocus(var Msg : TWMKillFocus);
begin
  {destroy caret}
  if Assigned(edCaret) then
    edCaret.Linked := False;

  {redraw the window if necessary}
  if FHideSelection then
    edRedraw(False);

  {set controller insert mode flag}
  Controller.InsertMode := InsertMode;

  inherited;
end;

procedure TOvcCustomEditor.WMLButtonDblClk(var Msg : TWMLButtonDblClk);
var
  S       : PAnsiChar;
  Len     : Word;
  Line    : LongInt;
  Para    : LongInt;
  BL, EL  : LongInt;
  Pos1    : Integer;
  Pos2    : Integer;
  LinePos : Integer;
  C1, C2  : Integer;
  BC, EC  : Integer;
  DragH   : Boolean;
begin
  inherited;

  {drag highlight initially if shift key is being pressed}
  DragH := (GetKeyState(VK_SHIFT) < 0);

  edGetMousePos(Line, Pos1);
  if edSelCursorOn then begin
    Para := edParas.FindParaByLine(Line, Pos2);
    Len := edParas.ParaLength(Para);

    if (not DragH) or ((Para = edHltEnd.Para) and (Para = edHltBgn.Para)) then
      edSetSelectionPP(Para, 1, Para, Len+1, True)
    else if (Para > edHltBgn.Para) then
      edSetSelectionPP(edHltBgn.Para, edHltBgn.Pos, Para+1, Len+1, True)
    else
      edSetSelectionPP(Para, 1, edHltEnd.Para, edHltEnd.Pos, False);
  end else begin
    edParas.NthLine(Line, S, Len);
    if Pos1 > Len then
      Pos1 := Len;
    Para := edParas.FindParaByLine(Line, LinePos);
    Inc(Pos1, LinePos);
    S := GetPara(Para, Len);

    {find beginning of this word}
    if Pos1 < LinePos+1 then
      Pos1 := LinePos+1;
    if (Pos1 > 1) and (Len > 0) then begin
      while (Pos1 > 0) and edIsWordDelim(S[Pos1-1]) do
        Dec(Pos1);

      while (Pos1 > 0) and not edIsWordDelim(S[Pos1-1]) do
        Dec(Pos1);

      Inc(Pos1);
    end;

    {find end of this word}
    Pos2 := Pos1;
    while (Pos2 <= Len) and not edIsWordDelim(S[Pos2-1]) do
      Inc(Pos2);
    if (Pos2-2 > Pos1) and edIsWordDelim(S[Pos2-2])
                      and not edWhiteSpace(S[Pos2-2]) then
      Dec(Pos2);
    while (Pos2 <= Len) and edWhiteSpace(S[Pos2-1]) do
      Inc(Pos2);

    {highlight the word}
    C1 := Pos1-LinePos;
    C2 := Pos2-LinePos;
    if DragH then begin
      with edHltBgn do
        BL := edParas.FindLineByPara(Para, Pos, BC);

      with edHltEnd do
        EL := edParas.FindLineByPara(Para, Pos, EC);

      if (Line > BL) or ((Line = BL) and (C1 > BC)) then
        SetSelection(BL, BC, Line, C2, True)
      else
        SetSelection(Line, C1, EL, EC, False);
    end else
      SetSelection(Line, C1, Line, C2, True);
  end;
end;

procedure TOvcCustomEditor.WMLButtonDown(var Msg : TWMLButtonDown);
var
  Line    : LongInt;
  SL      : LongInt;
  SelLine : LongInt;
  BL, EL  : LongInt;
  Col     : Integer;
  SC      : Integer;
  SelCol  : Integer;
  BC, EC  : Integer;
  DragH   : Boolean;
  OffScn  : Boolean;
  LeftBtn : Byte;
  Pt      : TPoint;
  Distance    : LongInt;                                               {!!.13}
  PrevTime    : LongInt;                                               {!!.13}
  Ticks       : LongInt;                                               {!!.13}
  R           : TRect;                                                 {!!.13}
  MaxDistance : LongInt;                                               {!!.13}
begin
  inherited;

  {solve problem with minimized modeless dialogs and MDI child windows}
  {that contain editor components}
  if not Focused and CanFocus then
    {$IFDEF Win32}
    Windows.SetFocus(Handle);
    {$ELSE}
    WinProcs.SetFocus(Handle);
    {$ENDIF}

  if (edParas.ByteCount <> 0) then begin
    {activate capture}
    SetCapture(Handle);
    edCapture := True;

    {get the physical left button}
    LeftBtn := GetLeftButton;

    {drag highlight initially if shift key is being pressed}
    DragH := (GetKeyState(VK_SHIFT) < 0);

    SelLine := 0;
    SelCol := 0;
    if edSelCursorOn then begin
      edGetMousePos(Line, Col);
      if DragH then begin
        with edHltBgn do
          BL := edParas.FindLineByPara(Para, Pos, BC);

        with edHltEnd do
          EL := edParas.FindLineByPara(Para, Pos, EC);

        if Line >= BL then begin
          SelLine := BL;
          SelCol := BC;
        end else begin
          SelLine := EL;
          SelCol := EC;
        end;
      end else begin
        SelLine := Line;
        SelCol := 1;
      end;
    end;

    {watch the mouse position while the left button is down}
    SL := -1;
    SC := -1;

    PrevTime := 0;                                                     {!!.13}
    R := Rect(0, 0, ClientWidth-1, ClientHeight-1);                    {!!.13}
    R.TopLeft := ClientToScreen(R.TopLeft);                            {!!.13}
    R.BottomRight := ClientToScreen(R.BottomRight);                    {!!.13}
    MaxDistance := GetSystemMetrics(SM_CYHSCROLL) * 3;                 {!!.13}

    repeat
      GetCursorPos(Pt);

      if (Pt.Y > R.Bottom) then                                        {!!.13}
        Distance := (Pt.Y - R.Bottom)                                  {!!.13}
      else if (Pt.Y < R.Top) then                                      {!!.13}
        Distance := (R.Top - Pt.Y)                                     {!!.13}
      else                                                             {!!.13}
        Distance := MaxDistance;                                       {!!.13}
      Ticks := LongInt(timeGetTime) - PrevTime;                 {!!.13}{!!.D4}
      if Ticks > MaxDistance-Distance then begin                       {!!.13}

        Pt := ScreenToClient(Pt);
        edGetMousePos(Line, Col);

        if (Line <> SL) or ((Col <> SC) and not edSelCursorOn) then begin
          if edSelCursorOn then begin
            OffScn := (Line < edTopLine) or (Line > edTopLine+Pred(edRows));

            if OffScn then
              BeginUpdate;

            if (Line < SelLine) or (Pt.Y < 0) then
              SetSelection(Line, 1, SelLine, SelCol, False)
            else if Line < edParas.LineCount then
              SetSelection(SelLine, SelCol, Line+1, 1, True)
            else
              SetSelection(SelLine, SelCol, Line, edParas.LineLength(Line)+1, True);

            if OffScn then begin
              EndUpdate;
              edRedrawPending := False;
              edRedraw(True);
            end;

          end else begin
            edMoveCaretTo(Line, Col, DragH);
            Update;
          end;
          SL := Line;
          SC := Col;
        end;

        PrevTime := timeGetTime;                                       {!!.13}
      end;                                                             {!!.13}
      {allow message processing}
      Application.ProcessMessages;

      DragH := True;
    until GetAsyncKeyState(LeftBtn) >= 0;
  end;
end;

procedure TOvcCustomEditor.WMLButtonUp(var Msg : TWMLButtonUp);
begin
  {deactivate capture}
  if edCapture then begin
    ReleaseCapture;
    edCapture := False;
  end;

  inherited;
end;

procedure TOvcCustomEditor.WMMouseActivate(var Msg : TWMMouseActivate);
begin
  if (csDesigning in ComponentState) or (GetFocus = Handle) then
    inherited
  else begin
    {SetFocus;}                                                        {!!.01}
    if Controller.ErrorPending then
      Msg.Result := MA_NOACTIVATEANDEAT
    else
      Msg.Result := MA_ACTIVATE;
  end;
end;

procedure TOvcCustomEditor.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  if csDesigning in ComponentState then
    {don't call inherited so we can bypass vcl's attempt}
    {to trap the mouse hit}
    DefaultHandler(Msg)
  else
    inherited;
end;

procedure TOvcCustomEditor.WMSetCursor(var Msg : TWMSetCursor);
var
  Pt : TPoint;
begin
  edSelCursorOn := False;
  if (not (csDesigning in ComponentState)) and
     (Msg.HitTest = HTCLIENT) then begin
    {get the mouse position in client coordinates}
    GetCursorPos(Pt);
    Pt := ScreenToClient(Pt);
    if Pt.X <= FLeftMargin then begin
      SetCursor(edSelCursor);
      edSelCursorOn := True;
    end else
      inherited;
  end else
    inherited;
end;

procedure TOvcCustomEditor.WMSetFocus(var Msg : TWMSetFocus);
begin
  if csDesigning in ComponentState then
    Exit;

  inherited;

  {set our insert mode}
  InsertMode := Controller.InsertMode;

  {create and display the caret}
  edCaret.Linked := True;
  edSetCaretSize;
  edPositionCaret(0);
  edCaret.Visible := True;
  {redraw the window if necessary}
  if FHideSelection then
    edRedraw(False);
end;

procedure TOvcCustomEditor.WMSize(var Msg : TWMSize);
var
  VS : Boolean;                                                        {!!.16}
begin
  inherited;

  VS := LineCount > edRows;                                            {!!.16}

  {determine settings based on the current font}
  edCalcRowColInfo;

  {adjust wrap column}
  edAdjustWrapColumn;

  if VS then                                                           {!!.16}
    if LineCount <= edRows then                                        {!!.16}
      TopLine := 1;                                                    {!!.16}
end;

{!!.01} {revised}
procedure TOvcCustomEditor.WMSysKeyDown(var Msg : TWMSysKeyDown);
var
  Cmd : Word;
begin
  inherited;

  {exit if this is a Tab key or an Alt key by itself}
  if (Msg.CharCode = VK_TAB) or (Msg.CharCode = VK_ALT) then
    Exit;

  {see if this command should be processed by us}
  Cmd := Controller.EntryCommands.TranslateKey(Msg.CharCode, [ssAlt]);
  if Cmd <> ccNone then
    ProcessCommand(Cmd, Msg.CharCode);
end;

procedure TOvcCustomEditor.WMVScroll(var Msg: TWMVScroll);
var
  NewTop : LongInt;
begin
  case Msg.ScrollCode of
    SB_LINEDOWN : edVScrollPrim(+1);
    SB_LINEUP   : edVScrollPrim(-1);
    SB_PAGEDOWN : edVScrollPrim(+edRows);
    SB_PAGEUP   : edVScrollPrim(-edRows);
    SB_THUMBPOSITION, SB_THUMBTRACK :
      begin
        if Msg.Pos = 1 then
          NewTop := 1
        else if Msg.Pos = edVSMax then begin
          if edParas.LineCount < edRows then
            NewTop := 1
          else
            NewTop := edParas.LineCount - Pred(edRows);
        end else
          NewTop := (Msg.Pos * edDivisor);
        TopLine := NewTop;
      end;
  end;
end;


{*** TOvcCustomTextFileEditor ***}

procedure TOvcCustomTextFileEditor.Attach(Editor : TOvcCustomEditor);
  {-attach this editor to Editor}
begin
  if Assigned(Editor) and HandleAllocated then begin
    inherited Attach(Editor);
    {set our file name the same as the sibling editor's}
    FFileName := (Editor as TOvcCustomTextFileEditor).FileName;
  end;
end;

constructor TOvcCustomTextFileEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FBackupExt  := edDefBackupExt;
  FIsOpen     := edDefIsOpen;
  FMakeBackup := edDefMakeBackup;
end;

procedure TOvcCustomTextFileEditor.CreateWnd;
begin
  inherited CreateWnd;

  {if FIsOpen then}                                                    {!!.10}
    {LoadFromFile(FFileName);}                                         {!!.10}
end;

{!!.10}
procedure TOvcCustomTextFileEditor.Loaded;
begin
  inherited Loaded;

  if FIsOpen then
    LoadFromFile(FFileName);
end;

procedure TOvcCustomTextFileEditor.LoadFromFile(const Name : string);
  {-read the specified file}
const
  BufSize = MaxSmallInt+1;
type
  SBuf = array[0..BufSize-1] of AnsiChar;
var
  F          : System.Text;
  S, Buf     : ^SBuf;
begin
  if Name = '' then
    Exit;

  {save FileName}
  FFileName := teFixFileName(Name);
  Buf := nil;
  S := nil;
  try
    {display hourglass}
    Screen.Cursor := crHourGlass;
    try
      {open the file}
      System.Assign(F, FFileName);
      Reset(F);
      try {finally}
        {get line buffer}
        New(S);

        {get buffer for text file - no problem if we can't, just slower}
        try
          GetMem(Buf, BufSize);
          if Assigned(Buf) then
            System.SetTextBuf(F, Buf^, BufSize);
        except
          on EOutOfMemory do {nothing}
          else
            raise;
        end;

        {delete existing text and allow display to be refreshed}
        {if HandleAllocated then begin}                                {!.14!}
          DeleteAll(True);
          Update;
        {end;}                                                         {!!.14}

        {read the file}
        while not Eof(F) do begin
          System.ReadLn(F, S^);

          {!!.13}
          case AppendPara(PAnsiChar(S)) of
            0              : {};
            oeTooManyBytes : raise EEditorError.Create(GetOrphStr(SCTooManyBytes), 0, 0);
            oeTooManyParas : raise EEditorError.Create(GetOrphStr(SCTooManyParas), 0, 0);
            oeParaTooLong  : raise EEditorError.Create(GetOrphStr(SCParaTooLong), 0, 0);
          else
            raise EEditorError.Create(GetOrphStr(SCOutOfMemory), 0, 0);
          end;
        end;

        {reset the scroll bars}
        ResetScrollBars(True);
      finally
        {close the file}
        Close(F);

        {dispose of buffer}
        if Assigned(S) then
          FreeMem(S, BufSize);
        if Assigned(Buf) then
          FreeMem(Buf, BufSize);
      end;
    finally
      {restore original cursor}
      Screen.Cursor := crDefault;
    end;
    FIsOpen := True;
  except
    IsOpen := False;
    if not (csLoading in ComponentState) then
      raise;
  end;
end;

procedure TOvcCustomTextFileEditor.NewFile(const Name : string);
  {-create a new file}
begin
  {get rid of existing text}
  DeleteAll(True);

  {reset the scroll bars}
  ResetScrollBars(True);

  {reset file name}
  FileName := Name;
end;

procedure TOvcCustomTextFileEditor.SaveToFile(const Name : string);
  {-write the current file to disk}
const
  BufSize = 8192;
var
  F          : System.Text;
  I, PC      : LongInt;
  Buf        : Pointer;
  S          : PAnsiChar;

  procedure MakeBakFile(const NewName : string);
    {-make a backup file}
  var
    BakName : string;
  begin
    if FileExists(NewName) then begin
      BakName := ChangeFileExt(NewName, '.' + FBackupExt);
      if NewName = BakName then
        Exit;

      DeleteFile(BakName);
      RenameFile(NewName, BakName);
    end;
  end;

begin
  if csDesigning in ComponentState then
    Exit;

  if Name = '' then
    Exit;

  Buf := nil;

  {display hourglass}
  Screen.Cursor := crHourGlass;
  try
    {make backup file if appropriate}
    if FMakeBackup then
      MakeBakFile(Name);

    {open the file}
    System.Assign(F, Name);
    System.ReWrite(F);
    try
      {get buffer for text file - no problem if we can't, just slower}
      try
        GetMem(Buf, BufSize);
        if Assigned(Buf) then
          System.SetTextBuf(F, Buf^, BufSize);
      except
        on EOutOfMemory do {nothing}
        else
          raise;
      end;

      {get number of paragraphs}
      PC := ParaCount;

      {create the file}
      I := 1;
      repeat
        S := GetParaPointer(I);
        if (I < PC) or (S[0] <> #0) then
          System.WriteLn(F, S);
        Inc(I);
      until (I > PC);

    finally
      {close the file}
      Close(F);

      {dispose of text buffer}
      if Assigned(Buf) then
        FreeMem(Buf, BufSize);
    end;
  finally
    {restore cursor}
    Screen.Cursor := crDefault;
  end;

  {clear the modified flag}
  SetModified(False);
end;

procedure TOvcCustomTextFileEditor.SetFileName(const Value : string);
  {-set name of file being edited}
var
  HoldIsOpen : Boolean;
begin
  if CompareText(Value, FFileName) <> 0 then begin
    HoldIsOpen := FIsOpen;
    FIsOpen := False;
    FFileName := teFixFileName(Value);
    if csDesigning in ComponentState then
      IsOpen := HoldIsOpen;
  end;
end;

procedure TOvcCustomTextFileEditor.SetIsOpen(Value : Boolean);
begin
  if (Value <> FIsOpen) and (FFileName > '') then begin
    FIsOpen := Value;
    if csLoading in ComponentState then
      Exit;

    if FIsOpen then
      LoadFromFile(FFileName)
    else begin
      {get rid of existing text}
      DeleteAll(True);

      {reset the scroll bars}
      ResetScrollBars(True);

      {add sample text if designing}
      edAddSampleParas;
    end;
  end;
end;

function TOvcCustomTextFileEditor.teFixFileName(const Value : string) : string;
  {-fixup file name}
var
  I  : SmallInt;
begin
  Result := Value;
  if Result > '' then begin
    {get rid of final '.' if any}
    I := Length(Result);
    if (I > 1) and (Result[I] = '.') then
      System.Delete(Result, I, 1);
  end;
end;



end.