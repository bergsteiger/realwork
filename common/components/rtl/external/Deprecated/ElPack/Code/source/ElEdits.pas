{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2001-2003, Alexander Hramov        }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

{$UNDEF OLDELSCROLLBARS}
  {.$DEFINE OLDELSCROLLBARS}  // OLD ELSCRIOLLBAR STYLES


(*

Version History

07/06/2003

  BorderColor* properties added. They control the colors of the border, drawn when Flat is true.

07/02/2003

  Fixed the problem with caret positioning when PasswordChar <> ''

06/17/2003

  Fixed some issues in single-line mode, when Alignment is center
  or right

06/15/2003

  Fixed OnContextPopup event

05/27/2003

  When processing WM_PASTE no case conversion was made. Fixed.

05/15/2003

  MaxLength was not effective when inputting text via IME. Fixed.
  Even though ReadOnly is set to true, IME allowed input. Fixed.

05/12/2003

  No OnChange was fired when using IME editor. Fixed.

04/30/2003

  Fixed repainting of centered and right-aligned text

04/13/2003

  Fixed positioning of text in view when focus enters the control and AutoSelect is in effect

  Fixed Assign method for correct handling of empty lines (#13#10)

04/02/2003

  Fixed WMNCPaint when RightAlignedView = True (for SystemScrollBars).
  Fixed WMEraseBkgnd when BorderStyle = bsNone

03/29/2003

  Changed default for WantReturns in ElEdit to false

03/27/2003

  Fixed drawing of selected text in non-unicode mode

03/24/2003

  Replaced system ScrollBars with ElScrollBars

03/15/2003

  ChangeDisabledText changed to UseDisabledColors
  Added UseDisabledColors, DisabledColor, DisabledFontColor properties

02/15/2003

  Fixed drawing of the text with RightAlignedView property set

02/11/2003

  When new text is set, view is reset to position (0, 0)

01/20/2003

  Added support for chars with carona (c, z, l for slovak language)

12/20/2002

  Fixed issues with sanskrit language.
  Added HighlightAlphaLevel property

12/15/2002

  Added selection color properties

11/29/2002

  Copy to clipboard doesn't work correctly in Windows 9x/ME. Fixed.

11/28/2002

  Fixed processing of Return key
  Fixed processing of numpad numbers for French keyboard layout
  CharCase was ignored. Fixed.

10/30/2002

  Changed processing of numpad numbers
  Fixed sizing of single-line controls when changing font size from large to small

10/29/2002

  Some improvements of work with the system menu

10/27/2002

  Added support for chars with umlaut, grave, tilde, acute or circumflex.
  Wasn't delete selection when MaxLength = Length(Text). Fixed.
  Some internal changes.

10/14/2002

  Some memory leaks fixed in DrawTabbedText

10/10/2002

  Fixed DrawTabbedText

09/26/2002

  Added support for "Group undo" mode.

09/22/2002

  OnKeyDown wasn't called when digits or characters was pressed. Fixed.
  SetLength := 0, doesn't have effect. Fixed.

09/18/2002

  Width of Tab symbols wasn't calculated properly.

09/07/2002

  AutoSize was not taken into account when font was changed. Fixed.

08/29/2002

  Internal optimization and fixes. Fixed OnKeyDown problem. Fixed problem
  with vertical scrollbar visibility.

08/08/2002

  Fixed painting for cases when EditRect.Left or EditRect.Top are not 0.

07/31/2002

  Some internal fixes. If PopupMenu property isn't assigned, will be called
  System Menu for Edit controls.

07/25/2002
  Tab fix. Some fixes for WMKeydown.

07/22/2002

  Fixed vertical alignment of text (spoiled on 07/20/2002)
  Fixed typing of unicode text for special symbols
  Fixed processing of Enter key in Unicode mode

07/17/2002

  Fixed some problems with vertical alignment of single-line text

07/13/2001

  Added SetEditRect method and changed EditRect handling in descendant classes

06/25/2002

  Undo CRLF and Tab insert fixed. Selection fixed. Sets topline
  when scrollbars disabled. Reformat text when control resized.

06/12/2002

  MaxLength now works. Selection bug with Ctrl+Home fixed.
  Misc scrollbars fixed. Fixed bug when insert mutiline text
  with WordWrap is true. VK_DELETE event handler fixed
  (not worked when WordWrap is True)

06/10/2002

  Fixed default for Multiline.
  Fixed height adjustment during form loading
  Fixed some memory leaks

06/08/2002

  Some internal fixes.

06/06/2002

  Add TElEditStrings.AddStrings, .Find and .Exchange, .Put,
  .GetObject (loopback), .PutObject (loopback) methods.
  Memory leaks closed.

05/25/2002

  Fixed setting position for different Aligment values.
  Add NotifyUserChangeOnly, add AdjustHeight method.

05/16/2002

  Fully rewritten code. Other principles of internal work.
  Work of editor now is faster, stronger. Multilevel undo.

04/19/2002

  Fixed assignment of multiline text via Assign.
  Added Scroll method

04/15/2002

  Setting SelText when SelLength = 0 causes insertion of the text.
  Pressing Backspace when SelLength > 0 causes deletion of selected text only now.

04/10/2002

  Alt- and Ctrl- modifiers are no more blocked, so it's possible to press
  Alt+<some key> to enter locale-specific characters and Euro symbol.

04/04/2002

  The text is centered now when Multiline is false and AlignBottom = true

03/26/2002

  Lowercase and Uppercase worked wrong (were mixed). Fixed.
  Clipboard Cut now shares Clipboard Copy technique.

  Clipboard Copy now correctly sets CF_TEXT data
  (there was PChar(SelText) instead of PChar(S)).

  Clipboard Copy now sets CF_TEXT data only under
  non-Windows NT/2000/XP platform because of
  Windows Clipboard autoconvertion feature.

  Clipboard Copy sets CF_UNICODETEXT data under both Unicode
  and non-Unicode modes because of localized text Clipboard
  Paste issues.

  Fixed Clipboard Paste under non-Unicode mode to use
  CF_UNICODETEXT-formatted data when possible
  because of localized text Clipboard Paste issues.

  Clipboard Paste now uses one Clipboard object
  and do not uses wrong Open/Close semantics.

  Clipboard Copy now uses one Clipboard object,
  uses exception-safe Open/Close semantics,
  and written in Paranoid style.

  TElCustomEdit now fills background with Color
  under XP Theming mode too.

03/22/2002

  In multiline mode, when BorderStyle = bsNone, junk was drawn around the control. Fixed.

03/21/2002

  Fixed autosize issues when borders are turned off
  Fixed issues with entering numbers from numeric part of keyboard

03/20/2002

  Transparency issues fixed

03/18/2002

  Ctrl+BkSp and Ctrl+Delete delete words now

03/15/2002

  Pressing Home when cursor is on position 0 removes selection
  Now it's possible to set key in KeyPress to #0.

03/12/2002

  Autosize is now correctly set to true by default
  Combination of Ctrl and Alt does not prevent key from being processed.

03/06/2002

  Added unicode hint

02/26/2002

  Fixed scrollbars

02/23/2002

  Added CharCase property

02/18/2002

  Property UseCustomScrollBars added. Now you can use standard Windows or custom
  scrollbars.
  Support for mouse wheel added.

02/13/2002

  Fixed imageform handling

02/09/2002

  Fixed cursor size/position calculation for non-default fonts

02/01/2002

  Fixed some multiline problems

01/31/2002

  Fixed problems with Lines.Add, Lines.Insert, Lines.Clear
  Siginificantly improved speed of line addition.

  Now the control can handle even 20000 lines
  (although scrolling speed is terrible near the end of the text)

01/18/2002

  Fixed problems with scrollbar updating
  Fixed problems with IME Editors

01/12/2002

  Add AlignBottom public property. Used for vertical align text in single-line
  mode

01/06/2002

  Now the text is updated when Alignment, LeftMargin, RightMargin or TopMargin
  are changed

01/02/2002

  Under Windows XP, now all input converted to Unicode

01/01/2002

  Fixed some problems with painting borders when focus is moved

11/28/2001

  LineBorderActiveColor and LineBorderInactiveColor properties added.
  Fixed the problem with mouse selection of the text

11/16/2001

  Fix small bug in StringToPassword

11/12/2001

  Add SelectAll method come fixes in WMSetFocusMethod. Added code for context
  menu support

11/08/2001

  Solved problem with sending wm_settext in design time

11/04/2001

  Some fixes in PosFromChar, CharFromPos, WMCopy. Moved code which sets
  FLeftChar from MoveCaret to SetSelStart for normal horizontal scrolling

10/31/2001

  Select text with Shift + Left, Shift + Home and Ctrl + Shift + Left,
  bug fixed, set ScrollBars position and range moved to SetScrollBarsInfo.
  Emulate GetTextExtentExPointW for Win9x

10/30/2001

  PasswordChar assignment fixed

10/22/2001

  Some fix in unicode version

10/18/2001

  Add IME support and Unicode version of editor. Some optimization
  works.

10/15/2001

  Multiline editor completed.

10/09/2001

  Add ScrollBars, WordWrap properties to TElEdit class. Declare new class
  TElEditStrings for Multiline and WordWrap features.

*)

unit ElEdits; { TCustomElEdit component. }

{ EldoS Editor }

interface

uses
  SysUtils,
  Classes,
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  Clipbrd,
  Menus,
  {$ifdef DEBUG}
  Dialogs,
  {$endif}
  TypInfo,
  ElTools,
  {$IFDEF ELPACK_USE_IMAGEFORM}
  ElImgFrm,
  {$ENDIF}
(*
{$IFDEF ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$ENDIF}
*)
  l3Interfaces,
  
  ElList,
  ElStack,
  ElTmSchema,
  ElUxTheme,
  ElVCLUtils,
  ElXPThemedControl,
  // ElSBCtrl, <trash> // LAW 
  {$IFDEF OLDELSCROLLBARS}
  ElScrollBar,
  {$ENDIF}
  {$IFDEF ELPACK_UNICODE}
  ElUnicodeStrings,
  Imm,
  ExtCtrls,
  {$ENDIF}
  {$IFDEF VCL_6_USED}
  Types,
  {$ENDIF}
  ElStrUtils;

type
  EElEditorError = class(exception)
  end;

  TCustomElEdit = class;

{$IFDEF MSWINDOWS}
{$IFDEF ELPACK_UNICODE}
  TElFStrings = TElWideStrings;
  TElFStringList = TElWideStringList;
{$ELSE}
  TElFStrings = TStrings;
  TElFStringList = TStringList;
{$ENDIF}
{$ELSE}
  TElFStrings = TElWideStrings;
  TElFStringList = TElWideStringList;
{$ENDIF}

  TElEnhanceType = (etSelectAll);


  TElActionType = (atInsert, atDelete, atLineBreak, atGroupBreak, atPaste,
                   atBackSpace, atDeleteSel, atInsertSel);

  TElAction = class(TPersistent)
  protected
    FAction: TElActionType;
    FStartPos, FEndPos: TPoint;
    FStr: TElFString;
  public
    procedure Assign(Source: TPersistent); override;
    property Action: TElActionType read FAction;
    property CString: TElFString read FStr;
    property EndPos: TPoint read FEndPos;
    property StartPos: TPoint read FStartPos;
  end;

  TElActionList = class(TPersistent)
  protected
    FAStack: TElStack;
    FMaxUndo: integer;
    FLockCount: integer;
    function GetCanUndo: boolean; virtual;
    procedure SetMaxUndo(const Value: integer); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function PeekItem: TElAction;
    function PopItem: TElAction;
    procedure AddAction(AAction: TElActionType; ASPos, AEPos: TPoint; AStr: TElFString);
    procedure Clear;
    procedure Lock;
    procedure PushItem(Item: TElAction);
    procedure UnLock;
    property CanUndo: boolean read GetCanUndo;
    property MaxUndo: integer read FMaxUndo write SetMaxUndo default 10;
  end;

  {$IFDEF ELPACK_UNICODE}
  TElParagraph = class(TElWideStringList)
  {$ELSE}
  TElParagraph = class(TStringList)
  {$ENDIF}
  protected
    FPCount: integer;
    {$IFDEF ELPACK_UNICODE}
    function Get(Index: Integer): WideString; override;
    function GetTextStr: WideString; override;
    procedure Put(Index: Integer; const S: WideString); override;
    procedure SetTextStr(const Value: WideString); override;
    {$ELSE}
    function Get(Index: Integer): String; override;
    function GetTextStr: String; override;
    procedure Put(Index: Integer; const S: String); override;
    procedure SetTextStr(const Value: string); override;
    {$ENDIF}
  public
    {$IFDEF ELPACK_UNICODE}
    property Text: WideString read GetTextStr write SetTextStr;
    {$ELSE}
    property Text: String read GetTextStr write SetTextStr;
    {$ENDIF}
  end;

{$warnings off}
  TElParagraphList = class(TElList)
  protected
    function Get(Index: Integer): TElParagraph;
    procedure Put(Index: Integer; const Value: TElParagraph);
    procedure Delete(Index: Integer);
  public
    procedure Clear; override;
    property Items[Index: Integer]: TElParagraph read Get write Put; default;
  end;

  {$IFDEF ELPACK_UNICODE}
  TElEditStrings = class(TElWideStringList)
  {$ELSE}
  TElEditStrings = class(TStringList)
  {$ENDIF}
  private
    FElEdit : TCustomElEdit;
    RealStrings : TStringList;
    FParagraphs: TElParagraphList;
  protected
    FMaxLen : Integer;
    FIdxMaxLen : integer;
    FMaxStr : TElFString;
    FSaveStr : TElFString;
    FOnChange : TNotifyEvent;

    procedure Reformat;
    procedure Changed; override;

    {$IFDEF ELPACK_UNICODE}
    function Get(Index: integer): WideString; override;
    procedure Put(Index: Integer; const S: WideString); override;
    procedure SetTextStr(const Value: WideString); override;
    function GetTextStr: WideString; override;
    {$ELSE}
    function Get(Index: integer): String; override;
    procedure Put(Index: Integer; const S: String); override;
    procedure SetTextStr(const Value: String); override;
    function GetTextStr: String; override;
    {$ENDIF}
    procedure PutObject(Index: Integer; AObject: TObject); override;
    function GetObject(Index: Integer): TObject; override;
    function GetCount: integer; override;
    procedure ReformatParagraph(Index: integer);
    procedure ReCount(Index: integer);
    function GetParaString(Index: integer): TElFString;
    procedure SetParaString(Index: integer; const Value: TElFString);
    function GetParaCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    {$IFDEF ELPACK_UNICODE}
    procedure AddStrings(Strings: TElWideStrings); override;
    function Add(const S: WideString): Integer; override;
    procedure Insert(Index: Integer; const S: WideString); override;
    procedure InsertText(var ACaretX, ACaretY: integer; const S: WideString);
    function Find(const S: WideString; var Index: Integer): boolean; override;
    {$ELSE}
    procedure AddStrings(Strings: TStrings); override;
    function Add(const S : String): Integer; override;
    procedure Insert(Index: Integer; const S: String); override;
    procedure InsertText(var ACaretX, ACaretY: integer; const S: String);
    function Find(const S: String; var Index: Integer): boolean; override;
    {$ENDIF}
    procedure Clear; override;
    procedure Delete(Index: integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    procedure IndexToParagraph(index: integer; var Paragraph, ParaIndex: integer);
    procedure CaretToParagraph(ACaretX, ACaretY: integer; var Paragraph, ParaOffs: integer);
    procedure CaretFromParagraph(Paragraph, ParaOffs: integer; var ACaretX, ACaretY: integer);
    function GetReText: TElFString;
    function CutString(var S: TElFString; Len: integer; var RealStr: boolean): TElFString;
    property ParagraphStrings[Index: integer]: TElFString read GetParaString write SetParaString;
    property ParagraphCount: integer read GetParaCount;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TElEditorStyle = class(TObject)
  protected
    FTextColor: TColor;
    FBkColor: TColor;
    FFont: TFont;
  public
    constructor Create;
    destructor Destroy; override;
    property TextColor: TColor read FtextColor write FTextColor;
    property BkColor: TColor read FBkColor write FBkColor;
    property Font: TFont read FFont write FFont;
  end;

  TElTextPainter = class(TObject)
  protected
    FBkColor: TColor;
    FColor: TColor;
    FFont: TFont;
    FEditor: TCustomElEdit;
    procedure SetColor(const AColor: TColor); virtual;
    procedure SetBkColor(const ABkColor: TColor); virtual;
    function ExtTextOut(const ACanvas: TCanvas; X, Y: Integer; Options: Longint;
                        Rect: PRect; Str: TElFString; Count: Longint): Boolean; virtual; abstract;
    function GetTextExtentExPoint(const ACanvas: TCanvas; lpszStr: PElFChar; cchString: integer;
                                     nMaxExtent: integer; var lpnFit: integer;
                                     alpDX: PInteger; var lpSize: TSize): Boolean; virtual; abstract;
  public
    constructor Create(AEditor: TCustomElEdit);
    function CharsFitRight(AWidth : integer; FText : TElFString; StartPos : integer) : integer; virtual;
    function CharsFitLeft(AWidth : integer; FText: TElFString; StartPos : integer) : integer; virtual;
    function TextSize(ALine : TElFString) : TSize; virtual; abstract;
    procedure DrawTabbedText(const ACanvas: TCanvas; X, Y : integer; ARect: TRect; AText : TElFString; var Size : TSize); virtual;
    property Color: TColor read FColor write SetColor;
    property BkColor: TColor read FBkColor write SetBkColor;
    property Font: TFont read FFont Write FFont;
  end;


  TElWinTextPainter = class(TElTextPainter)
  protected
    function ExtTextOut(const ACanvas: TCanvas; X, Y: Integer; Options: Longint;
                        Rect: PRect; Str: TElFString; Count: Longint): Boolean; override;
    function GetTextExtentExPoint(const ACanvas: TCanvas; lpszStr: PElFChar; cchString: integer;
                                     nMaxExtent: integer; var lpnFit: integer;
                                     alpDX: PInteger; var lpSize: TSize): Boolean; override;
  public
    function TextSize(ALine: TElFString): TSize; override;
  end;

  TElEditCharCase = (eecNormal, eecUpperCase, eecLowerCase);
  TElEditScrollDir = (esdLineUp, esdLineDown, esdPageUp, esdPageDown);

  TElKeyPressExEvent = procedure(Sender : TObject; var Key : TElFString) of object;

  TCustomElEdit = class(TElXPThemedControl)
  {$IFNDEF OLDELSCROLLBARS}
  protected
(*    {< ELSCROLLBAR}
    fSBCtrl: TElSBController;
    function GetHorzScrollBar:TElCtrlScrollBarStyles;
    function GetVertScrollBar:TElCtrlScrollBarStyles;
    procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
    procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
    property scbVert: TElCtrlScrollBarStyles read GetVertScrollBar;
    property scbHorz: TElCtrlScrollBarStyles read GetHorzScrollBar;
    property SBCtrl :TElSBController read fSBCtrl;
    {> ELSCROLLBAR}*)
  {$ENDIF}
  protected
    { Protected declarations }
    FModified : Boolean;
    FEditRect : TRect;
    FLeftMargin : Integer;
    FTopMargin : integer;
    FRightMargin : Integer;
    FMouseClick : boolean;
    FBorderStyle : TBorderStyle;
    FAutoSelect : Boolean;
    FAlignment : TAlignment;
    FReadOnly : Boolean;
    FWantTabs : Boolean;
    FPasswordChar : TElFChar;
    FMaxLength : Integer;
    FSelected: boolean;
    FSelLength : Integer;
    FSelStartX: integer;
    FSelStartY: integer;
    FSelFirstX: integer;
    FSelFirstY: integer;
    FSelLastX: integer;
    FSelLastY: integer;
    FMultiline: boolean;
    FTransparent : Boolean;
    FTabString : TElFString;
    FTabSpaces : integer;
    FHasCaret : boolean;
    FCaretX : integer;
    FCaretY : integer;
    FUpdate: boolean;
    { multi level undo & redo support }
    FUndo: TElActionList;
    FRedo: TElActionList;
    { end }
    { Text drawer object }
    FTextPainter: TElTextPainter;
    FModifyCount : integer;
    FLineHeight : integer;
    FLeftChar : integer;
    FCharsInView : integer;
    FSelecting : boolean;
    FOnChange : TNotifyEvent;
    FOnSelectionChange : TNotifyEvent;
    {$IFNDEF VCL_4_USED}
    FOnResize : TNotifyEvent;
    {$ENDIF}
    ForceLeftAlignment : boolean;
    FBackground: TBitmap;
    FUseBackground: Boolean;
    {$IFDEF ELPACK_USE_IMAGEFORM}
    FImgForm: TElImageForm;
    FImgFormChLink: TImgFormChangeLink;
    {$ENDIF}
    FBorderSides: TElBorderSides;
    FActiveBorderType: TElFlatBorderType;
    FFlat: Boolean;
    FInactiveBorderType: TElFlatBorderType;
    FHandleDialogKeys: Boolean;
    FMouseOver: Boolean;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    // String list for Multiline mode
    FElEditList: TElEditStrings;
    // First visible string
    FTopLine: integer;
    FWordWrap: boolean;
    FScrollBars: TScrollStyle;
    FLinesInRect: integer;
    FCharset: Integer;

    // FKeybLayout: HKL;

    {$IFDEF OLDELSCROLLBARS}
    scbVert, scbHorz: TElScrollBar;
    {$ENDIF}
    FFlatFocusedScrollBars: Boolean;
    FUseCustomScrollBars : Boolean;
    {$IFDEF OLDELSCROLLBARS}
    FVertScrollBarStyles : TElScrollBarStyles;
    FHorzScrollBarStyles : TElScrollBarStyles;
    {$ENDIF}

    FAlienFocus : boolean;
    FAlignBottom : boolean;
    {$IFDEF ELPACK_UNICODE}
    FKeys : WideString;
    FDeadChar: Char;
    FCDead: Integer;
    FKeyDown : boolean;
    FHint: TElFString;
    {$ENDIF}

    FRightAlignedText,
    FRightAlignedView: Boolean;
    FAutoSize: Boolean;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FNotifyUserChangeOnly: Boolean;
    FCharCase: TElEditCharCase;
    FEnd: boolean;
    FWantReturns: Boolean;
    FUseSystemMenu: Boolean;

    FHideSelection : Boolean;
    FFocusedSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectColor: TColor;
    FHideSelectTextColor: TColor;
    FHighlightAlphaLevel: Integer;
    FLinkedControl: TControl;
    FLinkedControlPosition: TElLinkCtlPos;
    FLinkedControlSpacing: Integer;
    FUseDisabledColors: Boolean;
    FDisabledColor: TColor;
    FDisabledFontColor: TColor;
    FOnKeyPressEx: TElKeyPressExEvent;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorShadow: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorWindow: TColor;

////////////////////////////////////////////////////////////////////////////////
    FOldSize:integer;
    FRestrictOnTextChange:boolean;
    FDropSelection:boolean;
    FArrowsSelect:boolean;
    FSmartOnResize:boolean;
    FDeltaSize:integer;
    FNoCaret:boolean;
    FEmptyHint: TelFString;
    FEmptyHintColor: TColor;
    FRightBorderSpace: boolean;
    FPaintSelectionMode : boolean;
    // при включенном рисуется а-ля комбобокс в DropDownList режиме
    FOnEditRectChanged : TNotifyEvent;
////////////////////////////////////////////////////////////////////////////////

    function ScrollBarStylesStored: Boolean;
    procedure CMCtl3DChanged(var Msg : TMessage); message CM_CTL3DCHANGED;
    procedure WMCaptureChanged(var Msg: TMessage); message WM_CAPTURECHANGED;
    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMCut(var Msg : TMessage); message WM_CUT;
    procedure WMCopy(var Msg : TMessage); message WM_COPY;
    procedure WMPaste(var Msg : TMessage); message WM_PASTE;
    procedure WMClear(var Msg : TMessage); message WM_CLEAR;
    procedure WMGetText(var Message: TMessage); message WM_GETTEXT;
    procedure WMGetTextLength(var Message: TMessage); message WM_GETTEXTLENGTH;

    procedure WMSetText(var Msg : TMessage); message WM_SETTEXT;
    procedure WMDestroy(var Msg : TMessage); message WM_DESTROY;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMEnable(var Msg : TMessage); message WM_ENABLE;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMVScroll(var Msg : TWMScroll); message WM_VSCROLL;
    procedure WMHScroll(var Msg : TWMScroll); message WM_HSCROLL;
    procedure WMInputLangChange(var Msg: TMessage); message WM_INPUTLANGCHANGE;
    procedure WMCommand(var Msg: TWMCommand); message WM_COMMAND;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure EMSetRect(var Message: TMessage); message EM_SETRECT;
    procedure EMSetRectNP(var Message: TMessage); message EM_SETRECTNP;

    {$IFDEF ELPACK_UNICODE}
    procedure WMImeStartComposition(var Message : TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMImeComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    {$ENDIF}

(*    procedure OnHScroll(Sender: TObject; ScrollCode: TElScrollCode;
                        var ScrollPos: Integer; var DoChange : boolean);
    procedure OnVScroll(Sender: TObject; ScrollCode: TElScrollCode;
                        var ScrollPos: Integer; var DoChange : boolean);*)
    procedure SBChanged(Sender: TObject);

    procedure SetReadOnly(newValue : Boolean);
    procedure SetAlignment(newValue : TAlignment);
    procedure SetLeftMargin(newValue : Integer);
    procedure SetRightMargin(newValue : Integer);
    procedure SetBorderStyle(newValue : TBorderStyle);
    procedure SetTransparent(newValue : Boolean);
    procedure SetHideSelection(newValue : Boolean); virtual;
    function  GetPasswordChar : TElFString;
    procedure SetPasswordChar(newValue : TElFString);
    procedure DoSetEditRect(newValue : TRect);
    procedure SetTabSpaces(newValue : integer);
    procedure SetModified(newValue : Boolean);
    function GetSelectedText : TElFString;
    procedure SetBackground(const Value: TBitmap);
    procedure SetUseBackground(const Value: boolean);
    procedure SetBorderSides(Value: TElBorderSides);
    {$IFDEF ELPACK_USE_IMAGEFORM}
    procedure ImageFormChange(Sender : TObject);
    {$ENDIF}
    procedure DrawBackground(DC: HDC; R: TRect);
    procedure DrawFlatBorder;
    procedure DrawParentControl(DC: HDC);
    procedure SetScrollBars(const Value: TScrollStyle);
    procedure SetTopLine(const Value: Integer);
    procedure UpdateHeight;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;

    procedure BackgroundChanged(Sender: TObject);
    procedure SetFlatFocusedScrollBars(const Value: boolean);
    procedure AdjustHeight;

    {$IFDEF OLDELSCROLLBARS}
    procedure SetVertScrollBarStyles(newValue : TElScrollBarStyles);
    procedure SetHorzScrollBarStyles(newValue : TElScrollBarStyles);
    {$ENDIF}
    procedure SetUseCustomScrollBars(newValue : Boolean);

    procedure SetMaxLength(newValue : Integer); virtual;
    function  GetSelStart: integer; virtual;
    procedure SetSelStart(newValue : Integer); virtual;
    procedure SetSelLength(newValue : Integer); virtual;
    function GetSelLength: Integer; virtual;
    procedure SetSelText(const newValue : TElFString); virtual;
    function  StringToPassword(AString : TElFString) : TElFString;
    function  ExpandTabbedString(Text : TElFString) : TElFString;
    procedure SetScrollBarsInfo;
    procedure MoveCaret(CharNum : integer);
    procedure MakeCaret;
    procedure RepaintText(Rect : TRect);
    procedure DrawTabbedText(const ACanvas: TCanvas; X, Y : integer; AText : TElFString; var Size : TSize);
    function  ConvertBreaksFormat(Text : TElFString) : TElFString;
    function  CharsFitRight(AWidth : integer; FText : TElFString;
                            StartPos : integer) : integer;
    function  CharsFitLeft(AWidth : integer; FText: TElFString; StartPos : integer) : integer;

    procedure Change; virtual;

// вставлено ///////////////////////////////////////////////////////////////////////////////////
    procedure TriggerCaretXChangedEvent(Var Value:integer; Var Allow:boolean); virtual;
    procedure _TriggerTextChangedEvent(Sender: TObject;
{$IFDEF ELPACK_UNICODE}Var aText:WideString;{$ELSE}Var aText:String;{$ENDIF}Var Allow:boolean); 
    procedure TriggerTextChangedEvent(Sender    : TObject;
                                      var aText : Il3CString;
                                      var Allow : boolean);
      virtual;
      {-}
    function RepaintRightMargin(aOldSize:integer; aForce:boolean=false): boolean;
      {-}
    procedure SetNoCaret(Value:boolean);
      {-}
    function IsTextEmpty: boolean;
      {-}
    function AllowEnhance(const aEnhanceType: TElEnhanceType): Boolean;
      overload;
      virtual;
      {-}
    function AllowEnhance(const aEnhanceType: TElEnhanceType;
                          const aData: array of const): Boolean;
      overload;
      virtual;
      {-}
    function IsEmptyHintColorStore : Boolean;
      {-}
    procedure InternalMouseMove(Shift : TShiftState; X, Y : Integer);
      virtual;
      {* - для определения в потомках кода выполняемого в MouseMove. }
    function ExecInternalMouseMove : Boolean;
      virtual;
      {* - определяет нужно ли выполнять InternalMouseMove }
////////////////////////////////////////////////////////////////////////////////////////////////
    procedure TriggerSelectionChangeEvent; virtual;
    {$IFNDEF VCL_4_USED}
    procedure TriggerResizeEvent; virtual;
    {$ENDIF}
    procedure KeyPress(var Key : Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    // procedure DrawFrame;
    function GetReadOnly: Boolean; virtual;
    procedure PaintText(Canvas : TCanvas); virtual;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer); override;
    {$IFDEF ELPACK_USE_IMAGEFORM}
    procedure SetImageForm(newValue : TElImageForm); virtual;
    {$ENDIF}
    procedure SetFlat(const Value: boolean); virtual;
    {$IFDEF ELPACK_USE_IMAGEFORM}
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    {$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetThemedClassName: WideString; override;
    function GetLinesCount: Integer;
    procedure SetWordWrap(Value: boolean);
    procedure SetLeftChar(Value: integer);
    procedure SetAutoSize(Value: Boolean);{$IFDEF VCL_6_USED}override;{$ENDIF}
    procedure CreateWnd; override;
    {$IFNDEF OLDELSCROLLBARS}
(*    procedure DestroyWnd; override;*)
    {$ENDIF}
    procedure SetLines(Value: TElFStrings);
    function GetLines: TElFStrings;
    procedure SetTopMargin(Value: Integer);
    procedure SetAlignBottom(Value: boolean);
    // procedure UpdateFrame;
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure DoMouseEnter; virtual;
    procedure DoMouseLeave; virtual;
    procedure Loaded; override;
    procedure SetLineBorderActiveColor(Value: TColor); virtual;
    procedure SetLineBorderInactiveColor(Value: TColor); virtual;
    procedure SetActiveBorderType(const Value: TElFlatBorderType); virtual;
    procedure SetInactiveBorderType(const Value: TElFlatBorderType); virtual;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetCharCase(Value: TElEditCharCase);
    procedure SetSelection(SelX, SelY: integer);
    function DeleteSelection(aFakeDelete: boolean = False): string;
    {$IFDEF OLDELSCROLLBARS}
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    {$ENDIF}
    {$IFDEF ELPACK_UNICODE}
    procedure WMDeadChar(var Msg : TWMDeadChar); message WM_DEADCHAR;
    {$ENDIF}
(*
    {$IFDEF ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager); override;
    procedure SetStyleName(const Value: string); override;
    {$ENDIF}
*)
    {$IFDEF ELPACK_UNICODE}
    procedure SetHint(Value: TElFString); 

    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$ENDIF}
    procedure SetBottomAlign;
    function GetText: TElFString;
    function ConvertToCRLF(Str : TElFString): TElFString;
    procedure SetCaretX(const value: integer);
    procedure SetCaretY(const value: integer);
    function GetCaretXY: TPoint;
    procedure SetCaretXY(const value: TPoint);
    procedure CorrectLeftChar;
    procedure SetCaretPosition(const X, Y: integer);
    procedure SetMultiline(const Value: boolean);
    procedure SetMaxLevel(const Value: integer);
    function GetMaxLevel: integer;
    function CreateTextPainter: TElTextPainter; virtual;

    procedure EMGetSel(var Message: TMessage); message EM_GETSEL;
    procedure EMGetLine(var Message: TMessage); message EM_GETLINE;
    procedure EMGetLineCount(var Message: TMessage); message EM_GETLINECOUNT;
    procedure EMLineIndex(var Message: TMessage); message EM_LINEINDEX;
    procedure EMSetSel(var Message: TMessage); message EM_SETSEL;
    procedure EMReplaceSel(var Message: TMessage); message EM_REPLACESEL;
    procedure EMGetFirstVisibleLine(var Message: TMessage); message EM_GETFIRSTVISIBLELINE;
    procedure EMScroll(var Message: TMessage); message EM_SCROLL;
    procedure EMLineScroll(var Message: TMessage); message EM_LINESCROLL;
    procedure EMScrollCaret(var Message: TMessage); message EM_SCROLLCARET;
    procedure EMLineFromChar(var Message: TMessage); message EM_LINEFROMCHAR;
    procedure EMPosFromChar(var Message: TMessage); message EM_POSFROMCHAR;
    procedure EMCanUndo(var Message: TMessage); message EM_CANUNDO;
    procedure EMUndo(var Message: TMessage); message EM_UNDO;
    procedure SetEditRect(Value : TRect); virtual;
    procedure DefineProperties(Filer : TFiler); override;
    procedure ReadRTLContent(Reader : TReader);
    procedure SetRightAlignedView(Value: Boolean); virtual;
    procedure SetRightAlignedText(Value: Boolean); virtual;
    procedure SetFocusedSelectColor(newValue: TColor); virtual;
    procedure SetFocusedSelectTextColor(newValue: TColor); virtual;
    procedure SetHideSelectColor(newValue: TColor); virtual;
    procedure SetHideSelectTextColor(newValue: TColor); virtual;
    procedure DoChange; virtual;
    procedure SetHighlightAlphaLevel(Value: Integer); virtual;
    procedure SetLinkedControl(Value: TControl);
    procedure UpdateLinkedControl;
    procedure SetLinkedControlPosition(Value: TElLinkCtlPos);
    procedure SetLinkedControlSpacing(Value: Integer);
    function AdjustRectSB(const ARect : TRect): TRect;
    procedure SetUseDisabledColors(Value: Boolean);
    procedure SetDisabledColor(Value: TColor);
    procedure SetDisabledFontColor(Value: TColor);
    procedure ReadChangeDisabledText(Reader : TReader);
    function HasCustomBackground: Boolean;
    procedure ReadLinkCtlPos(Reader : TReader);
    procedure TriggerKeyPressEx(var Key : TElFString); virtual;

    {$ifdef VCL_5_USED}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    {$endif}
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);

    property RightAlignedText: Boolean read FRightAlignedText write
        FRightAlignedText default false;
    property RightAlignedView: Boolean read FRightAlignedView write
        SetRightAlignedView default false;

    property Background: TBitmap read FBackground write SetBackground;
    property UseBackground: Boolean read FUseBackground write SetUseBackground
        default False;
    property PasswordChar : TElFString read GetPasswordChar write SetPasswordChar; { Published }
    property MaxLength : Integer read FMaxLength write SetMaxLength default 0; { Published }
    property Transparent : Boolean read FTransparent write SetTransparent default false; { Published }
    property ReadOnly : Boolean read GetReadOnly write SetReadOnly default false; { Published }
    property WantTabs : Boolean read FWantTabs write FWantTabs default false; { Published }
    property Alignment : TAlignment read FAlignment write SetAlignment default taLeftJustify; { Published }
    property BorderStyle : TBorderStyle read FBorderStyle write SetBorderStyle; { Published }
    property AutoSelect : Boolean read FAutoSelect write FAutoSelect default false; { Published }
    property HideSelection : Boolean read FHideSelection write SetHideSelection default true; { Published }

    property EditRect : TRect read FEditRect write DoSetEditRect; { Published }
    {$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm: TElImageForm read FImgForm write SetImageForm;
    {$ENDIF}
    property Flat: Boolean read FFlat write SetFlat default False;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write
        SetInactiveBorderType default fbtSunkenOuter;


    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssNone;

    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write
        SetActiveBorderType default fbtSunken;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default true;
    property BorderSides: TElBorderSides read FBorderSides write SetBorderSides;
    property CharCase: TElEditCharCase read FCharCase write SetCharCase default
        eecNormal;
    property FlatFocusedScrollBars: Boolean read FFlatFocusedScrollBars write
        SetFlatFocusedScrollBars default False;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor;
    property Lines: TElFStrings read GetLines write SetLines;
    property MaxUndoLevel : integer read GetMaxLevel write SetMaxLevel default 10;
    property Multiline : boolean read FMultiline write SetMultiline default false;
    property TabSpaces : Integer read FTabSpaces write SetTabSpaces default 4;
    property UseSystemMenu: Boolean read FUseSystemMenu write FUseSystemMenu
        default True;
    property WantReturns: Boolean read FWantReturns write FWantReturns default false;
    property WordWrap: boolean read FWordWrap write SetWordWrap default false;

    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    {$IFNDEF VCL_4_USED}
    property OnResize : TNotifyEvent read FOnResize write FOnResize;
    {$ENDIF}
    property OnSelectionChange : TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property FocusedSelectColor: TColor read FFocusedSelectColor write
        SetFocusedSelectColor default clHighlight;
    property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write
        SetFocusedSelectTextColor default clHighlightText;
    property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor
        default clBtnFace;
    property HideSelectTextColor: TColor read FHideSelectTextColor write
        SetHideSelectTextColor default clBtnShadow;
    property HighlightAlphaLevel: Integer read FHighlightAlphaLevel write
        SetHighlightAlphaLevel default 255;
    property LinkedControl: TControl read FLinkedControl write SetLinkedControl;
    property LinkedControlPosition: TElLinkCtlPos read FLinkedControlPosition write
        SetLinkedControlPosition default lcpTopLeft;
    property LinkedControlSpacing: Integer read FLinkedControlSpacing write
        SetLinkedControlSpacing default 0;
    property UseDisabledColors: Boolean read FUseDisabledColors write
        SetUseDisabledColors default false;
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor
        default clBtnFace;
    property DisabledFontColor: TColor read FDisabledFontColor write
        SetDisabledFontColor default clGrayText;
    // candidates to publishing:
    {$IFDEF OLDELSCROLLBARS}
    property VertScrollBarStyles : TElScrollBarStyles read FVertScrollBarStyles
      write SetVertScrollBarStyles stored ScrollBarStylesStored;
    property HorzScrollBarStyles : TElScrollBarStyles read FHorzScrollBarStyles
      write SetHorzScrollBarStyles stored ScrollBarStylesStored;
    {$ELSE}
(*    {< ELSCROLLBAR}
    property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
      write SetHorzScrollBar stored ScrollBarStylesStored;
    property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
      write SetVertScrollBar stored ScrollBarStylesStored;
    {> ELSCROLLBAR}*)
    {$ENDIF}
    property UseCustomScrollBars : Boolean read FUseCustomScrollBars write SetUseCustomScrollBars
      default True;  { Published }
    property OnKeyPressEx: TElKeyPressExEvent read FOnKeyPressEx write
        FOnKeyPressEx;
////////////////////////////////////////////////////////////////////////////////
    // сохранять ли расстояние между правой границей текста и правым краем окна ввода
    property RightBorderSpace: boolean read FRightBorderSpace write FRightBorderSpace;
    property SmartOnResize: boolean read FSmartOnResize write FSmartOnResize;
    property NoCaret:boolean read FNoCaret write SetNoCaret;
    // строка, показывается вместо пустого значения. Пропадает при получении фокуса.
    property EmptyHint: TelFString read FEmptyHint write FEmptyHint;
    property EmptyHintColor: TColor read FEmptyHintColor write FEmptyHintColor
     stored IsEmptyHintColorStore;
  public
////////////////////////////////////////////////////////////////////////////////
    procedure UnSelect;
    procedure SetTextWithCaret(const S: string);    
////////////////////////////////////////////////////////////////////////////////
    procedure ClearUndoRedoLists;
    procedure SetText(newValue: TElFString);
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function GetNextWord(ACaret: TPoint) : TPoint;
    function GetPrevWord(ACaret: TPoint) : TPoint;

    function CaretFromChar(const CharNum: integer): TPoint;
    function CharFromCaret(const X, Y: integer): integer;
    function PosFromCaret(const X, Y: integer): TPoint; virtual;
    procedure CaretFromPos(APos: TPoint; var ACaretX, ACaretY: integer); virtual;

    procedure SelectAll;
    function CutToClipboard: boolean; virtual;
    procedure CopyToClipboard; virtual;
    function PasteFromClipboard: boolean; virtual;
    procedure Undo;
    procedure Scroll(ScrollDir : TElEditScrollDir);
    procedure ScrollCaret;
    function GetCanUndo: boolean;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property SelStart : Integer read GetSelStart write SetSelStart; { Published }
    property SelLength : Integer read GetSelLength write SetSelLength; { Published }
    property SelText : TElFString read GetSelectedText write SetSelText; { Published }
    property Modified : Boolean read FModified write SetModified default False; { Public }
    property SelectedText : TElFString read GetSelectedText;
    property MouseOver: Boolean read FMouseOver;
    property LinesCount: Integer read GetLinesCount;
    property TopLine: Integer read FTopLine write SetTopLine;
    property LeftChar: integer read FLeftChar write SetLeftChar;
    property LeftMargin : Integer read FLeftMargin write SetLeftMargin default 1; { Published }
    property RightMargin : Integer read FRightMargin write SetRightMargin default 2; { Published }

    property HandleDialogKeys: Boolean read FHandleDialogKeys write FHandleDialogKeys default false;
    property Text: TElFString read GetText write SetText;
    property TopMargin: Integer read FTopMargin write SetTopMargin default 1;
    property AlignBottom : boolean read FAlignBottom write SetAlignBottom default true;

    property CaretX: integer read FCaretX write SetCaretX;
    property CaretY: integer read FCaretY write SetCaretY;
    property CaretXY: TPoint read GetCaretXY write SetCaretXY;
    property CanUndo: boolean read GetCanUndo;
////////////////////////////////////////////////////////////////////////////////
    property OnEditRectChanged : TNotifyEvent
      read FOnEditRectChanged
      write FOnEditRectChanged;
      {* - вызывается при изменении рамки редактирования. }
////////////////////////////////////////////////////////////////////////////////
  published
    property NotifyUserChangeOnly: Boolean read FNotifyUserChangeOnly write FNotifyUserChangeOnly
      default true; // AND DO NOT CHANGE THIS!!!
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;

    {$IFDEF ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
    {$ENDIF}
    property TabStop default true;
    {$ifdef VCL_4_USED}
    property ImeMode;
    property ImeName;
    {$endif}
    property UseXPThemes;
  end; { TCustomElEdit }

  TCustomElMemo = class(TCustomElEdit)
  public
    constructor Create(AOwner : TComponent); override;
  end;

  TElMemo = class (TCustomElMemo)
  published
    property AutoSize;
    property Alignment;
    property AlignBottom;
    property Background;
    property BorderSides;
    
    property CharCase;
    property UseBackground;
    property RightAlignedText;
    property RightAlignedView;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property ReadOnly;
    property WantTabs;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
    property AutoSelect;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property TabSpaces;
    property Lines stored false;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;
    property Text;

    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property MaxUndoLevel;

    property WantReturns default true;
    property WordWrap;
    property ScrollBars;

(*    property VertScrollBarStyles;
    property HorzScrollBarStyles;*) // <trash> // LAW
    property UseCustomScrollBars;

    property UseSystemMenu;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;
    property OnKeyPressEx;

    property Align;

    {$IFDEF VCL_4_USED}
    property Anchors;
    {$ENDIF}
    property Color;
    {$IFDEF VCL_4_USED}
    property Constraints;
    {$ENDIF}
    property Ctl3D;
    property DragCursor;
    {$IFDEF VCL_4_USED}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default false;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

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

  {$IFDEF VCL_4_USED}
      property OnStartDock;
      property OnEndDock;
  {$ENDIF}
  {$IFDEF VCL_5_USED}
      property OnContextPopup;
  {$ENDIF}
  end;

  TElEdit = class (TCustomElEdit)
  published
    property AutoSize;
    property Alignment;
    property AlignBottom;
    property Background;
    property BorderSides;

    property CharCase;
    property UseBackground;
    property RightAlignedText;
    property RightAlignedView;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property ReadOnly;
    property WantTabs;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
    property AutoSelect;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property TabSpaces;
    property Lines stored false;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;
    property Text;

    {$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$ENDIF}
    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property MaxUndoLevel;

    property WantReturns;
    property WordWrap;
    property Multiline;
    property ScrollBars;

(*    property VertScrollBarStyles;
    property HorzScrollBarStyles;*) // <trash> // LAW
    property UseCustomScrollBars;

    property UseSystemMenu;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;
    property OnKeyPressEx;

    property Align;

    {$IFDEF VCL_4_USED}
    property Anchors;
    {$ENDIF}
    property Color;
    {$IFDEF VCL_4_USED}
    property Constraints;
    {$ENDIF}
    property Ctl3D;
    property DragCursor;
    {$IFDEF VCL_4_USED}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default false;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

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

  {$IFDEF VCL_4_USED}
      property OnStartDock;
      property OnEndDock;
  {$ENDIF}
  {$IFDEF VCL_5_USED}
      property OnContextPopup;
  {$ENDIF}
 end;

  TIntArray = array[0..MaxInt div sizeof(integer) -1] of integer;
  PIntArray = ^TIntArray;
var
  RepaintAll : boolean = true;
  FlagEdit : boolean;

const
  ElFSpace = {$IFDEF ELPACK_UNICODE}WideChar(#32){$ELSE}#32{$ENDIF};
  ElFTab = {$IFDEF ELPACK_UNICODE}WideChar(#9){$ELSE}#9{$ENDIF};
  ElFCR = {$IFDEF ELPACK_UNICODE}WideChar(#13){$ELSE}#13{$ENDIF};
  ElFLF = {$IFDEF ELPACK_UNICODE}WideChar(#10){$ELSE}#10{$ENDIF};
  {$IFDEF LINUX}
  ElFCRLF = {$IFDEF ELPACK_UNICODE}WideChar(#13){$ELSE}#13{$ENDIF};
  {$ELSE}
  ElFCRLF = {$IFDEF ELPACK_UNICODE}WideString(#13#10){$ELSE}#13#10{$ENDIF};
  {$ENDIF}

  ID_UNDO = 772;
  ID_CUT = 768;
  ID_COPY = 769;
  ID_PASTE = 770;
  ID_DELETE = 771;

{$warnings off}
{$IFNDEF BUILDER_USED}
function LoadLibrary16(LibraryName: PChar): THandle; stdcall; external kernel32 index 35;
procedure FreeLibrary16(HInstance: THandle); stdcall; external kernel32 index 36;
{$ENDIF}
{$warnings on}


implementation

uses
  l3Base,
  l3String
  ;

// Специальный трюк для `MoleBox`, который не умеет работать, если ресурс находиться в 16-ти битном файле
{$IFDEF NEMESIS}
  {$R ElEdits.res ElEdits.rc}
{$ENDIF NEMESIS}

{$IFDEF ELPACK_UNICODE}
type
  ToUnicodeProc = function(wVirtKey, wScanCode: UINT; const KeyState: TKeyboardState;
                            var pwszBuff; cchBuff: Integer; wFlags: UINT): Integer; stdcall;
var
  ToUnicode : ToUnicodeProc;
{$ENDIF}

var
  ElWhatIsMenu,
  ElEditMenu,
  ElSysWindowMenu,
  ElMDIWindowMenu,
  ID_SELECTALL: integer;

////////////////////////////////////////////////////////////////////////////////
const
 cEmptyHintColor = clGrayText;
   {* - цвет для hint-а пустого combobox-а. }
////////////////////////////////////////////////////////////////////////////////


procedure ElCallSysMenu(const IDOfMenu, Handle, X, Y: Integer; FEdit: TCustomElEdit);
var
  SysMenu: HMENU;
  h: THandle;
begin
  if IsWinNTUp then
  begin
    h := GetModuleHandle(PChar('user32.dll'));
    SysMenu := LoadMenu(h, MAKEINTRESOURCE(IDOfMenu));
  {$IFNDEF BUILDER_USED}
  end
  else
  begin
// Специальный трюк для `MoleBox`, который не умеет работать, если ресурс находиться в 16-ти битном файле
{$IFDEF NEMESIS}
    SysMenu := LoadMenu(HInstance, MAKEINTRESOURCE(IDOfMenu));
{$ELSE  NEMESIS}
    h := LoadLibrary16(PChar('user.exe'));
    SysMenu := LoadMenu(h, MAKEINTRESOURCE(IDOfMenu));
    FreeLibrary16(h);
{$ENDIF NEMESIS}
  {$ELSE}
  end
  else
  begin
    SysMenu := 0;
  {$ENDIF}
  end;
  if SysMenu <> 0 then
  try
    SysMenu := GetSubMenu(SysMenu, 0);
    if IDOfMenu = ElEditMenu then
    begin
      if IsWin2000Up then
      begin
        RemoveMenu(SysMenu, 32769, MF_BYCOMMAND);
        RemoveMenu(SysMenu, 32768, MF_BYCOMMAND);
        RemoveMenu(SysMenu, 32787, MF_BYCOMMAND);
        RemoveMenu(SysMenu, 8, MF_BYPOSITION);
      end;
      if not FEdit.CanUndo then
        EnableMenuItem(SysMenu, ID_UNDO, MF_GRAYED or MF_BYCOMMAND);
      if FEdit.SelLength = 0 then
      begin
        EnableMenuItem(SysMenu, ID_COPY, MF_GRAYED or MF_BYCOMMAND);
        EnableMenuItem(SysMenu, ID_CUT, MF_GRAYED or MF_BYCOMMAND);
        EnableMenuItem(SysMenu, ID_DELETE, MF_GRAYED or MF_BYCOMMAND);
      end;
      if (not (Clipboard.HasFormat(CF_TEXT) or Clipboard.HasFormat(CF_UNICODETEXT))) or
        FEdit.ReadOnly
      then
        EnableMenuItem(SysMenu, ID_PASTE, MF_GRAYED or MF_BYCOMMAND);

      if (FEdit.SelLength = Length(FEdit.Text)) then
        EnableMenuItem(SysMenu, ID_SELECTALL, MF_GRAYED or MF_BYCOMMAND);

    end;
    TrackPopupMenu(SysMenu, TPM_LEFTALIGN or TPM_RIGHTBUTTON, X, Y, 0, Handle, nil);
  finally
    DestroyMenu(SysMenu);
  end;
end;

(*
{$IFDEF RUCOMMENTS}
{ Вспомогательные функции для работы с RightToLeft языками }
{$ENDIF}
function Revert(S: TElFString):TElFString;
var
  i: integer;
  {$IFDEF ELPACK_UNICODE}
  S1 : WideString;
  {$ENDIF}
begin
  i := LastPos(ElFCR, S);
  while i > 0 do
  begin
    Result := Result + Copy(S, i + 1, Length(S)) + ElFCR;
    {$IFDEF ELPACK_UNICODE}
    S1 := S;
    WideDelete(S1, i, Length(S1));
    S := S1;
    {$ELSE}
    Delete(S, i, Length(S));
    {$ENDIF}
    i := LastPos(ElFCR, S);
  end;
  Result := Result + S;
end;

function InvertString(S: TElFString): TElFString;
var
  i: integer;
begin
  Result := '';
  for i := Length(S) downto 1 do
  begin
    Result := Result + S[i];
  end;
end;
*)
// move to ElVCLUtils.pas
function ElGetTextExtentExPoint(DC: HDC; lpszStr: PElFChar; cchString: integer;
                                 nMaxExtent: integer; var lpnFit: integer;
                                 alpDX: PInteger; var lpSize: TSize): BOOL;
{$IFDEF ELPACK_UNICODE}
var
  i : integer;
{$ENDIF}
begin
  Result := false;
  if (Length(lpszStr) = 0) then
  begin
    lpnFit := 0;
    exit;
  end;
  {$IFDEF ELPACK_UNICODE}
  if IsWinNTUp then
    Result := GetTextExtentExPointW(DC, PWideChar(lpszStr), cchString, nMaxExtent,
      {$IFNDEF VCL_4_USED}
      lpnFit,
      alpDX^,
      {$else}
      @lpnFit,
      alpDX,
      {$endif}
      lpSize)
  else
  begin
    i := 0;
    GetTextExtentPoint32W(DC, PWideChar(lpszStr), i + 1, lpSize);
    while lpSize.cx <= nMaxExtent do
    begin
      if Assigned(alpDX) then
      begin
        Move(lpSize.cx, alpDX^, SizeOf(Integer));
        Inc(PChar(alpDX), SizeOf(Integer));
      end;
      inc(i);
      if i > Length(lpszStr) then
      begin
        lpnFit := Length(lpszStr);;
        exit;
      end;
      GetTextExtentPoint32W(DC, PWideChar(lpszStr), i + 1, lpSize);
    end;
    lpnFit := i;
  end;
  {$ELSE}
  {$IFNDEF VCL_4_USED}
  Result := GetTextExtentExPointA(DC, PChar(lpszStr), cchString, nMaxExtent, lpnFit,
    alpDX^, lpSize);
  {$ELSE}
  Result := GetTextExtentExPointA(DC, PChar(lpszStr), cchString, nMaxExtent, @lpnFit,
    alpDX, lpSize);
  {$ENDIF}
  {$ENDIF}
end;

{$IFDEF ELPACK_UNICODE}
function KeyToUnicode(const Key: String): WideString;
var KeyboardCodePage: integer;
    Buf: String;
    LenBuf: Integer;
    LenRes: integer;
    Locale: LCID;
// const LOCALE_IDEFAULTANSICODEPAGE     = $00001004;
begin
  // Get right locale
  Locale := GetKeyboardLayout(0) and $FFFF;
  LenBuf := GetLocaleInfo(Locale, LOCALE_IDEFAULTANSICODEPAGE, nil, 0);
  SetLength(Buf, LenBuf);
  GetLocaleInfo(Locale, LOCALE_IDEFAULTANSICODEPAGE, PChar(Buf), LenBuf);
  KeyboardCodePage := StrToIntDef(Buf, GetACP);

  // Get length of result string
  LenRes := MultiByteToWideChar(KeyboardCodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS, PChar(Key),
    Length(Key), nil, 0);
  SetLength(Result, LenRes);
  MultiByteToWideChar(KeyboardCodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS, PChar(Key),
    Length(Key), PWideChar(Result), LenRes);
end;
{$ENDIF}


{--*******************************************************************
      Class: TElEditorStyle
*******************************************************************--}
constructor TElEditorStyle.Create;
begin
  FFont := TFont.Create;
end;

destructor TElEditorStyle.Destroy;
begin
  FFont.Free;
end;

{--*******************************************************************
      Class: TCustomElEdit
*******************************************************************--}
procedure TCustomElEdit.SetPasswordChar(newValue : TElFString);
{ Sets data member FPasswordChar to newValue. }
begin
  if (PasswordChar <> newValue) then
  begin
    if Length(newValue) > 0 then
      FPasswordChar := newValue[1]
    else
      FPasswordChar := #0;
    Invalidate;
  end; { if }
end; { SetPasswordChar }

function TCustomElEdit.GetPasswordChar : TElFString;
begin
  if FPasswordChar = #0 then
    result := ''
  else
    result := FPasswordChar;
end;

procedure TCustomElEdit.SetMaxLength(newValue : Integer);
{ Sets data member FMaxLength to newValue. }
begin
  if (FMaxLength <> newValue) and (NewValue >= 0) then
  begin
    FMaxLength := newValue;
    if (FMaxLength > 0) and (Length(Text) > FMaxLength) then
    {$IFDEF ELPACK_UNICODE}
      Text := WideCopy(Text, 1, FMaxLength);
    {$ELSE}
      Text := Copy(Text, 1, FMaxLength);
    {$ENDIF}
  end; { if }
end; { SetMaxLength }

function TCustomElEdit.GetSelStart: integer;
begin
  Result := CharFromCaret(CaretX, CaretY);
end;

procedure TCustomElEdit.SetSelStart(newValue : Integer);
{ Sets data member FSelStart to newValue. }
var
  FPos: TPoint;
begin
  FPos := CaretFromChar(newValue);
  UnSelect;
  CaretY := FPos.Y;
  CaretX := FPos.X;
  FSelStartX := CaretX;
  FSelStartY := CaretY;
end; { SetSelStart }

procedure TCustomElEdit.SetSelText(const newValue : TElFString);
var
  fx, fy: integer;
begin
  if FSelected then
    DeleteSelection;
  fx := CaretX;
  fy := CaretY;
  FElEditList.InsertText(fx, fy, newValue);
  SetSelection(fx, fy);
  CaretY := fy;
  CaretX := fx;
  DoChange;
  if not NotifyUserChangeOnly then
    Change;
end;

function TCustomElEdit.GetSelLength: Integer;
begin
  Result := Length(SelText);
end;

procedure TCustomElEdit.SetSelLength(newValue : Integer);
{ Sets data member FSelLength to newValue. }
var
  FPos: TPoint;
begin
  if newValue = 0 then
    UnSelect
  else
  begin
    FPos := CaretFromChar(SelStart + newValue);
    SetSelection(FPos.X, FPos.Y);
    CaretY := FPos.Y;
    CaretX := FPos.X;
  end;
  TriggerSelectionChangeEvent;
end; { SetSelLength }


procedure TCustomElEdit.SetTransparent(newValue : Boolean);
{ Sets data member FTransparent to newValue. }
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    if HandleAllocated then
      RecreateWnd;
  end; { if }
end; { SetTransparent }

procedure TCustomElEdit.WMCut(var Msg : TMessage); { private }
begin
  if CutToClipboard then
  begin
    DoChange;
    Change;
  end;
end; {WMCut}

procedure TCustomElEdit.WMCopy(var Msg : TMessage); { private }
begin
  CopyToClipboard;
end; {WMCopy}

procedure TCustomElEdit.WMPaste(var Msg : TMessage); { private }
begin
  if PasteFromClipboard then
  begin
    DoChange;
    Change;
  end;
end; {WMPaste}

procedure TCustomElEdit.WMClear(var Msg : TMessage); { private }
begin
  SelText := '';
end; { WMClear }

procedure TCustomElEdit.WMDestroy(var Msg : TMessage);
  // message WM_DESTROY;
begin//WMDestroy
 if fHasCaret and HandleAllocated and (Windows.GetFocus = Handle) then
 begin
  fHasCaret := False;
  DestroyCaret;
 end;
 inherited;
end;//WMDestroy

procedure TCustomElEdit.WMSetText(var Msg : TMessage); { private }
var
  {$IFDEF ELPACK_UNICODE}
  ANewStr : WideString;
  Len : integer;
  Temp : string;
  {$IFDEF VCL_6_USED}
  Dsgn : boolean;
  {$ENDIF}
  {$ELSE}
  ANewStr : String;
  {$ENDIF}
begin
  {$IFDEF ELPACK_UNICODE}
  if Msg.WParam = 1 then
    ANewStr := WideStrPas(PWideChar(Msg.lParam))
  else
  begin
    Temp := StrPas(PChar(Msg.LParam));
    {$IFDEF VCL_6_USED}
    if (csDesigning in ComponentState) then
      Dsgn := (Pos(Name, Temp) <> 1)
    else
      Dsgn := false;

    if Dsgn then
      ANewStr := WideStrPas(PWideChar(Msg.lParam))
    else
    {$ENDIF}
    begin
      Len := MultiByteToWideChar(GetACP(), MB_PRECOMPOSED or MB_USEGLYPHCHARS,
                                 PChar(Temp), Length(Temp), nil, 0);
      if Len > 0 then
      begin
        SetLength(ANewStr, Len);
        MultiByteToWideChar(GetACP(), MB_PRECOMPOSED or MB_USEGLYPHCHARS, PChar(Temp),
                            Length(Temp), PWideChar(ANewStr), Len)
      end
      else
        ANewStr := '';
    end;
  end;
  {$ELSE}
  ANewStr := StrPas(PChar(Msg.lParam));
  {$ENDIF}
  Msg.Result := 0;


  FElEditList.Text := ANewStr;

  if HandleAllocated then
    SetCaretPosition(CaretX, CaretY);
  Msg.Result := 1;
  DoChange;
  if not NotifyUserChangeOnly then
    Change;
  TriggerSelectionChangeEvent;
  if HandleAllocated then
    RepaintText(EditRect);
end; { WMSetText }

procedure TCustomElEdit.WMNCPaint(var Msg : TMessage); { private }
var DC :HDC;
    RW :TRect;
    RC :TRect;
    b  : Boolean;

  procedure CallInheritedWOFrame;
  var
    WS, WES :DWORD;
  begin
    try
      WES := GetWindowLong(Handle, GWL_EXSTYLE);
      if WES and WS_EX_CLIENTEDGE <> 0 then
      begin
        WS := 0;
        FPreventStyleChange := True;
        SetWindowLong(Handle, GWL_EXSTYLE, WES and not WS_EX_CLIENTEDGE);
      end
      else
      begin
        WES := 0;
        WS  := GetWindowLong(Handle, GWL_STYLE);
        if WS and WS_BORDER <> 0 then
        begin
          FPreventStyleChange := True;
          SetWindowLong(Handle, GWL_STYLE, WS and not WS_BORDER);
        end
        else
          WS := 0;
      end;
      //inherited;
      DefWindowProc(Handle, Msg.Msg, Msg.wParam, Msg.lParam);

      if WES <> 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, WES)
      else if WS <> 0 then
        SetWindowLong(Handle, GWL_STYLE, WS);

      if Flat or (not (IsThemeApplied and (BorderStyle = bsNone))) then
        DrawFlatBorder;     finally
      if FPreventStyleChange then
        FPreventStyleChange := False;
    end;
  end;

  procedure PaintCrossSystemScrollbarsArea;
    var
      nFrameSize :Integer;
      RW         :TRect;
  begin
    // paint cross scrollbars area for system scrollbars:
    begin
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RW, -RW.Left, -RW.Top);

      if ((GetWindowLong(Handle, GWL_STYLE) and WS_BORDER) = WS_BORDER) then
        nFrameSize := GetSystemMetrics(SM_CXBORDER)
      else
        if ((GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
        nFrameSize := GetSystemMetrics(SM_CXEDGE)
      else
        nFrameSize := 0;

      with RW do
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
        begin
          dec(Right, nFrameSize);
          Left:= Right - GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end
        else
        begin
          Left   := nFrameSize;
          Right := Left + GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end;
        Windows.DrawEdge(DC, RW, EDGE_SUNKEN, BF_MIDDLE);
      end;
    end;
  end;

begin
  if FPreventStyleChange then
    exit;

  b :=
     (BorderStyle = bsSingle)
     {$IFDEF OLDELSCROLLBARS}
     and
     ( (not Flat)

       or (not UseCustomScrollBars)
     )
     {$ENDIF}
  ;

  if IsThemeApplied and (BorderStyle = bsSingle) {and not Transparent} then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC = 0 then
      DC := GetWindowDC(Handle);

    if b
       {$IFNDEF OLDELSCROLLBARS} and (not UseCustomScrollBars){$ENDIF}
    then
      CallInheritedWOFrame;

    Windows.GetClientRect(Handle, RC);

    if UseCustomScrollBars then
    begin
      {$IFNDEF OLDELSCROLLBARS}
(*      if VertScrollBarStyles.Visible then
      begin
        if not RightAlignedView then
          inc(RC.Right, VertScrollBarStyles.Depth)
        else
          dec(RC.Left, VertScrollBarStyles.Depth)
      end;
      if HorzScrollBarStyles.Visible then
        inc(RC.Bottom, HorzScrollBarStyles.Depth);*) // <trash> // LAW
      {$ELSE}{
      if scbVert.Visible then
        inc(RC.Right, scbVert.Width-1);
      if scbHorz.Visible then
        inc(RC.Bottom, scbHorz.Height-1);{}
      {$ENDIF}
    end
    else
    begin
      if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
          inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
        else
          dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));
      end;
      if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
        inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));

      // paint cross scrollbars area for system scrollbar:
      if (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
         (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0)
      then
        PaintCrossSystemScrollbarsArea;
    end;

    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    DrawThemeBackground(Theme, DC, 0, 0, RW, nil);
    ReleaseDC(Handle, DC);

  end
  else
  begin
    if b or
       (
        not b
       {$IFDEF OLDELSCROLLBARS}
       and ((not Flat) or (not UseCustomScrollBars))
       {$ENDIF}
       )
    then
      CallInheritedWOFrame
    else
    if (Flat or (FUseCustomScrollBars and Multiline) or IsThemeApplied) and
      (BorderStyle = bsSingle) then
    begin
      DrawFlatBorder;
      Msg.Result := 0;
    end;
    if RightAlignedView and (not UseCustomScrollBars) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
    begin
      //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
      //if DC = 0 then
        DC := GetWindowDC(Handle);
      PaintCrossSystemScrollbarsArea;
      ReleaseDC(Handle, DC);
    end;
  end;
end; { WMNCPaint }

procedure TCustomElEdit.WMEraseBkgnd(var Msg : TWMEraseBkgnd); { private }
var
  {$IFDEF ELPACK_USE_IMAGEFORM}
  ACtl   : TWinControl;
  BgRect,
  {$ENDIF}
  R1,
  R,
  RW     : TRect;
  sid    : integer;
  aBrush : HBrush;
  AColor : TColor;
  {$IFDEF OLDELSCROLLBARS}
  procedure ExcludeCustomScrollBarsArea;
  begin
    if UseCustomScrollBars then
    begin
      if scbVert.Visible then
      with scbVert do
      begin
        ExcludeClipRect(Msg.DC,
          Left,
          Top,
          Left+Width,
          Top+Height);
        // EXCLUDE CROSS SCROLBARS AREA:
        {if scbHorz.Visible then
        ExcludeClipRect(Msg.DC,
          Left-1,
          scbHorz.Top,
          Left+Width,
          scbHorz.Top+scbHorz.Height);{}
      end;
      if scbHorz.Visible then
      with scbHorz do
        ExcludeClipRect(Msg.DC,
          Left,
          Top,
          Left+Width,
          Top+Height);
    end;
  end;
  {$ENDIF}
begin
  {$IFDEF ELPACK_USE_IMAGEFORM}
  if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
   (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
  begin
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      R1 := AdjustRectSB(ClientRect);
      BgRect := R1;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);

      BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

      FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left, BgRect.Top), false);
    end;
  end
  else
  {$ENDIF}
  if FTransparent and (not IsThemeApplied) then
    DrawParentControl(Msg.DC)
  else
  (*
  if FUseBackground and not FBackground.Empty then
    DrawBackground(Msg.DC, ClientRect)
  else
  *)
  if not IsThemeApplied then
  begin
    GetClipBox(Msg.DC, R1);
    IntersectRect(R, ClientRect, R1);

    {$IFDEF OLDELSCROLLBARS}
    ExcludeCustomScrollBarsArea;
    {$ENDIF}

    if UseDisabledColors and (not Enabled) then
      AColor := DisabledColor
    else
      AColor := Color;
    ABrush := CreateSolidBrush(ColorToRGB(AColor));
    FillRect(Msg.DC, R, ABrush);
    DeleteObject(ABrush);
  end
  else
  if IsThemeApplied and (BorderStyle=bsSingle) then
  begin
    {$IFDEF OLDELSCROLLBARS}
    ExcludeCustomScrollBarsArea;
    {$ENDIF}
    RW := BoundsRect;
    if Parent <> nil then
      MapWindowPoints(Parent.Handle, Handle, RW, 2)
    else
    if ParentWindow <> 0 then
      MapWindowPoints(ParentWindow, Handle, RW, 2);

    if not Enabled then
      sid := ETS_DISABLED
    else
    if Focused then
      sid := ETS_FOCUSED
    else
    if ReadOnly then
      sid := ETS_READONLY
    else
      sid := ETS_NORMAL;
    DrawThemeBackground(Theme, Msg.DC, EP_EDITTEXT, sid, RW, nil);
  end;
  Msg.Result := 1;
end;

procedure TCustomElEdit.Paint; { protected }
var
  BMP : TBitmap;
  Rect: TRect;
  R,
  R1   : TRect;
  aBrush : HBrush;
  AColor : TColor;
begin

  if not HandleAllocated then
    exit;
  if Flat and not IsThemeApplied then
    DrawFlatBorder;
  BMP := TBitmap.Create;
  try
    {$IFDEF OLDELSCROLLBARS}
    if (FUseCustomScrollBars and Multiline) then
    begin
      if ScrollBars in [ssHorizontal, ssBoth] then
        BMP.Height := ClientHeight - HorzScrollBarStyles.Width
      else
        BMP.Height := ClientHeight;
      {
      if ScrollBars in [ssVertical, ssBoth] then
        BMP.Width := ClientWidth - VertScrollBarStyles.Width
      else
      }
        BMP.Width := ClientWidth;
    end
    else
    {$ENDIF}
    begin
      BMP.Height := ClientHeight;
      BMP.Width := ClientWidth;
    end;
    Rect := Canvas.ClipRect;
    if IsRectEmpty(Rect) then
      Rect := EditRect;

    Rect := AdjustRectSB(Rect);

    {$IFDEF ELPACK_USE_IMAGEFORM}
    if (FImgForm = nil) or (FImgForm.Backgroundtype = bgtColorFill) or
     (csDesigning in FImgForm.GetRealControl.ComponentState) then
    {$ENDIF}
    begin
      if Transparent then
        bitblt(Bmp.Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left,
          Rect.Bottom - Rect.Top, Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY)
      else
      if FUseBackground and not FBackground.Empty then
        DrawBackground(BMP.Canvas.Handle, ClientRect)
      else
  //    if not IsThemeApplied then
      begin
        GetClipBox(BMP.Canvas.Handle, R1);
        IntersectRect(R, ClientRect, R1);
        if UseDisabledColors and (not Enabled) then
          AColor := DisabledColor
        else
          if not FPaintSelectionMode then
            AColor := Color
          else
            AColor := FFocusedSelectColor;
        ABrush := CreateSolidBrush(ColorToRGB(AColor));
        FillRect(BMP.Canvas.Handle, R, ABrush);
        DeleteObject(ABrush);
        if FPaintSelectionMode then
          DrawFocusRect(BMP.Canvas.Handle, R);
      end;
    {$IFDEF ELPACK_USE_IMAGEFORM}
    end
    else
    begin
      bitblt(Bmp.Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left,
        Rect.Bottom - Rect.Top, Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
    {$ENDIF}
    end;
    if not FPaintSelectionMode then
      BMP.Canvas.Brush.Color := Color
    else
      BMP.Canvas.Brush.Color := FFocusedSelectColor;
    BMP.Canvas.Font.Assign(Font);
    PaintText(BMP.Canvas);
    Canvas.CopyRect(Rect, BMP.Canvas, Rect);
    if (ScrollBars in [ssBoth]) and (FUseCustomScrollBars and Multiline) then
    begin
      // PAINT CROSS SCROLLBARS AREA:
      {$IFDEF OLDELSCROLLBARS}
      Rect := Classes.Rect(
        scbVert.Left,
        scbHorz.Top,
        scbVert.Left + scbVert.Width,
        scbHorz.Top + scbHorz.Height);
      {$ELSE}
(*      SetRect(Rect, scbVert.ScrollBarRect.Left,  scbHorz.ScrollBarRect.Top,
                    scbVert.ScrollBarRect.Right, scbHorz.ScrollBarRect.Bottom );*) // <trash> // LAW
      {$ENDIF}
      Assert(false);
      Canvas.Brush.Style := bsSolid;
//      Canvas.Brush.Color := scbVert.Color; <trash> // LAW
      Canvas.FillRect(Rect);
    end;
    (*
    if (ScrollBars in [ssBoth]) and (not FUseCustomScrollBars and Multiline) then
    begin
      Windows.GetClientRect(Handle, Rect);
      if (not RightAlignedView) or (not NewStyleControls) then
        Rect.Left := Rect.Right
      else
        Rect.Right := Rect.Left;
      Rect.Top  := Rect.Bottom;

      if (not RightAlignedView) or (not NewStyleControls) then
          inc(Rect.Right, GetSystemMetrics(SM_CXVSCROLL))
      else
          dec(Rect.Left, GetSystemMetrics(SM_CXVSCROLL));
      inc(Rect.Bottom, GetSystemMetrics(SM_CYHSCROLL));

      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := scbVert.Color;
      Canvas.FillRect(Rect);
    end;
    //*)
  finally
    BMP.Free;
  end;
end;

(*
procedure TCustomElEdit.DrawFrame; { protected }
var
  Rgn : HRGN;
  ADC : HDC;
  LBR : TLogBrush;
  ABR,
    OBR : HBRUSH;
  R : TRect;
begin
  if HandleAllocated then
  begin
    if FHasCaret then HideCaret(Handle);
    SetRectEmpty(R);
    Rgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
    ADC := GetWindowDC(Handle);
    GetWindowRgn(Handle, Rgn);
    Lbr.lbStyle := BS_SOLID;
    Lbr.lbColor := ColorToRgb(clBtnText);
    Lbr.lbHatch := 0;
    ABR := CreateBrushIndirect(Lbr);
    OBR := SelectObject(ADC, ABR);
    FrameRgn(ADC, Rgn, ABR, (Width - ClientWidth) div 2, (Height - ClientHeight) div 2);
    SelectObject(ADC, OBR);
    DeleteObject(ABR);

    DeleteObject(Rgn);
    ReleaseDC(Handle, ADC);
    if FHasCaret then
       ShowCaret(Handle);
  end;
end;
*)

procedure TCustomElEdit.DrawTabbedText(const ACanvas: TCanvas; X, Y : integer; AText : TElFString; var Size : TSize);
var
  DrawRect: TRect;
begin
  DrawRect.Left := EditRect.Left + FLeftMargin;
  DrawRect.Top  := EditRect.Top;
  DrawRect.Right := EditRect.Right - RightMargin;
  DrawRect.Bottom := EditRect.Bottom;

  FTextPainter.DrawTabbedText(ACanvas, X, Y, DrawRect, ExpandTabbedString(StringToPassword(AText)), Size);
end;

procedure TCustomElEdit.PaintText(Canvas : TCanvas);
var
  FText,
    FText1,
    FText2,
    FText3 : TElFString;
  sx, sy: integer;
  (*
  FSaveAlign : DWORD;
  {$ifndef CLX_USED}
  FSaveColor,
    FSaveBkColor : COLORREF;
  {$else}
  FSaveColor,
    FSaveBkColor : TColor;
  {$endif}
  FSaveBrStyle : TBrushStyle;
  *)
  TS : TSize;
  AR : TRect;
  fl : integer;
  Delta: integer;
//  ls, le : integer;
  LinesToDraw : integer;
  DrawEmptyHint : boolean;
  SaveFontColor : TColor;

begin
  if not HandleAllocated then
    exit;

  if FHasCaret then
    HideCaret(Handle);

  if UseDisabledColors and (not Enabled) then
    (*FSaveColor := *)SetTextColor(Canvas.Handle, ColorToRGB(DisabledFontColor))
  else begin
    if not FPaintSelectionMode then
      (*FSaveColor := *)SetTextColor(Canvas.Handle, ColorToRGB(Canvas.Font.Color))
    else
      (*FSaveColor := *)SetTextColor(Canvas.Handle, ColorToRGB(FocusedSelectTextColor))
  end;
  // FSaveBrStyle := Canvas.Brush.Style;
  if UseDisabledColors and (not Enabled) then
    (*FSaveBkColor := *)SetBkColor(Canvas.Handle, ColorToRGB(DisabledColor))
  else begin
    (*FSaveBkColor := *)SetBkColor(Canvas.Handle, ColorToRGB(Canvas.Brush.Color))
  end;
  if FTopLine < 0 then
   TopLine := 0;
  LinesToDraw := (FTopLine + FLinesInRect) - 1;
  if (FTopLine + FLinesInRect) > FElEditList.ParagraphCount - 1 then
    LinesToDraw := FElEditList.ParagraphCount - 1;

  DrawEmptyHint := false;
  if (FPasswordChar = #0) and (not Focused) and IsTextEmpty and (EmptyHint<>'') then
  begin
    DrawEmptyHint := true;
    LinesToDraw := 0;
  end;

  for fl := FTopLine to LinesToDraw do
  begin
    if DrawEmptyHint then
      FText := FEmptyHint
    else
      FText := StringToPassword(FElEditList.ParagraphStrings[fl]);
    FCharsInView := CharsFitRight((EditRect.Right - FRightMargin) - (EditRect.Left + FLeftMargin),
      FText, FLeftChar);
    {$IFDEF ELPACK_UNICODE}
    FText := WideCopy(FText, FLeftChar + 1, FCharsInView);
    {$ELSE}
    FText := Copy(FText, FLeftChar + 1, FCharsInView);
    {$ENDIF}

    TS := FtextPainter.TextSize(FText);
    sy := (FLineHeight * ((fl - FTopLine) + 1)) + FTopMargin;
    case Alignment of
      taRightJustify: sx := (EditRect.Right - FRightMargin) - TS.cx - 2;
      taCenter:       sx := ((EditRect.Right - FRightMargin) div 2) - (TS.cx div 2);
    else
      sx := EditRect.Left + FLeftMargin;
    end;
    (*FSaveAlign := *)SetTextAlign(Canvas.Handle, TA_BOTTOM or TA_NOUPDATECP or TA_LEFT);
    Canvas.Brush.Style := bsClear;
    if {(SelLength = 0) or }(HideSelection and not Focused) or
       ((FSelFirstX = FSelLastX) and (FSelFirstY = FSelLastY)) or
       ((fl < FSelFirstY) or (fl > FSelLastY)) then
    begin
      if DrawEmptyHint then
      begin
        SaveFontColor := Canvas.Font.Color;
        Canvas.Font.Color := EmptyHintColor;
        DrawTabbedText(Canvas, SX, SY + EditRect.Top, FText, TS);
        Canvas.Font.Color := SaveFontColor;
      end
      else
        DrawTabbedText(Canvas, SX, SY + EditRect.Top, FText, TS);
    end
    else
    begin
      if fl = FSelFirstY then
      begin
        Delta := FSelFirstX - FLeftChar;

        if Delta < 0 then
          FText1 := ''
        else
          FText1 := Copy(FText, 1, Delta);

        if FSelFirstY = FSelLastY then
        begin
          if Delta < 0 then
          begin
            {$IFDEF ELPACK_UNICODE}
            FText2 := WideCopy(FText, 1, (FSelLastX - FLeftChar));
            FText3 := WideCopy(FText, (FSelLastX - FLeftChar) + 1, Length(FText));
            {$ELSE}
            FText2 := Copy(FText, 1, (FSelLastX - FLeftChar));
            FText3 := Copy(FText, (FSelLastX - FLeftChar) + 1, Length(FText));
            //FText2 := Copy(FText, (FSelFirstX + 1), (FSelLastX - FSelFirstX));
            //FText3 := Copy(FText, (FSelLastX + 1), Length(FText));
            {$ENDIF}
          end
          else
          begin
            {$IFDEF ELPACK_UNICODE}
            FText2 := WideCopy(FText, Delta + 1, (FSelLastX - FSelFirstX));
            FText3 := WideCopy(FText, Delta + (FSelLastX - FSelFirstX) + 1, Length(FText));
            {$ELSE}
            FText2 := Copy(FText, Delta + 1, (FSelLastX - FSelFirstX));
            FText3 := Copy(FText, Delta + (FSelLastX - FSelFirstX) + 1, Length(FText));
            // FText2 := Copy(FText, (FSelFirstX + 1), (FSelLastX - FSelFirstX));
            // FText3 := Copy(FText, (FSelLastX + 1), Length(FText));
            {$ENDIF}
          end;
        end
        else
        begin
          {$IFDEF ELPACK_UNICODE}
          FText2 := WideCopy(FText, Delta + 1{FSelFirstX + 1}, Length(FText));
          {$ELSE}
          FText2 := Copy(FText, Delta + 1{FSelFirstX + 1}, Length(FText));
          {$ENDIF}
          FText3 := '';
        end;
      end
      else
      begin
        Delta := FSelLastX - FLeftChar;
        if fl = FSelLastY then
        begin
          if Delta < 0 then
          begin
            FText1 := '';
            FText2 := '';
            FText3 := Copy(FText, 1, Length(FText));
          end
          else
          begin
            FText1 := '';
            FText2 := Copy(FText, 1, Delta);
            FText3 := Copy(FText, Delta + 1, Length(FText));
          end;
        end
        else
        begin
          FText1 := '';
          FText2 := FText;
          FText3 := '';
        end;
      end;
      SetTextAlign(Canvas.Handle, TA_BOTTOM or TA_NOUPDATECP or TA_LEFT);

      if Length(FText1) > 0 then
      begin
        Canvas.Brush.Style := bsClear;
        DrawTabbedText(Canvas, SX, SY + FEditRect.Top, FText1, TS);
        inc(sx, TS.cx);
      end;
      if Length(FText2) > 0 then
      begin
        if HighlightAlphaLevel = 255 then
        begin
          Canvas.Brush.Style := bsSolid;
        end;

        if Focused then
        begin
          Canvas.Brush.Color := FocusedSelectColor;
          Canvas.Font.Color := FocusedSelectTextColor;
        end
        else
        begin
          Canvas.Brush.Color := HideSelectColor;
          Canvas.Font.Color := HideSelectTextColor;
        end;

        DrawTabbedText(Canvas, SX, SY + FEditRect.Top, FText2, TS);
        inc(sx, TS.cx);

        if HighlightAlphaLevel < 255 then
        begin
          AR := Rect(SX - TS.cx, SY + FEditRect.Top - TS.cy, SX, SY + FEditRect.Top);
          AlphaFillRect(Canvas, AR, GetBkColor(Canvas.Handle), HighlightAlphaLevel);
          Canvas.Brush.Style := bsSolid;
        end;
      end;
      if UseDisabledColors and (not Enabled) then
        Canvas.Font.Color := DisabledfontColor
      else
        Canvas.Font.Color := Font.Color;

      if UseDisabledColors and (not Enabled) then
        Canvas.Brush.Color := DisabledColor
      else
        Canvas.Brush.Color := Color;

      if Length(FText3) > 0 then
      begin
//        SetBkMode(Canvas.Handle, Windows.Transparent);
        Canvas.Brush.Style := bsSolid;
        DrawTabbedText(Canvas, SX, SY + FEditRect.Top, FText3, TS);
      end;
    end;

    if UseDisabledColors and (not Enabled) then
      Canvas.Font.Color := DisabledfontColor
    else
      Canvas.Font.Color := Font.Color;

    if UseDisabledColors and (not Enabled) then
      Canvas.Brush.Color := DisabledColor
    else
      Canvas.Brush.Color := Color;
  end;
  (*
  SetTextAlign(Canvas.Handle, FSaveAlign);
  SetTextColor(Canvas.Handle, FSaveColor);
  SetBkColor(Canvas.Handle, FSaveBkColor);
  Canvas.Brush.Style := FSaveBrStyle;
  *)

  if FHasCaret then
    ShowCaret(Handle);
end;

procedure TCustomElEdit.Change;
{ Triggers the OnChange event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnChange)) then
    FOnChange(Self);
end; { TriggerChangeEvent }

procedure TCustomElEdit.TriggerSelectionChangeEvent;
{ Triggers the OnSelectionChange event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnSelectionChange)) then
    FOnSelectionChange(Self);
end; { TriggerSelectionChangeEvent }

procedure TCustomElEdit.SetReadOnly(newValue : Boolean);
{ Sets data member FReadOnly to newValue. }
begin
  if (FReadOnly <> newValue) then
  begin
    FReadOnly := newValue;
  end; { if }
end; { SetReadOnly }

function TCustomElEdit.GetReadOnly: Boolean;
{ Sets data member FReadOnly to newValue. }
begin
 Result := FReadOnly;
end; { SetReadOnly }

procedure TCustomElEdit.SetAlignment(newValue : TAlignment);
{ Sets data member FAlignment to newValue. }
begin
  if (FAlignment <> newValue) then
  begin
    FAlignment := newValue;
    if not RightAlignedText then
      if FAlignment <> taLeftJustify then
        WordWrap := True;
    Invalidate;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
  end; { if }
end; { SetAlignment }

procedure TCustomElEdit.SetLeftMargin(newValue : Integer);
{ Sets data member FLeftMargin to newValue. }
begin
  if (FLeftMargin <> newValue) then
  begin
    FLeftMargin := newValue;
    Invalidate;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
  end; { if }
end; { SetLeftMargin }

procedure TCustomElEdit.SetRightMargin(newValue : Integer);
{ Sets data member FRightMargin to newValue. }
begin
  if (FRightMargin <> newValue) then
  begin
    FRightMargin := newValue;
    Invalidate;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
  end; { if }
end; { SetRightMargin }

procedure TCustomElEdit.SetBorderStyle(newValue : TBorderStyle);
{ Sets data member FBorderStyle to newValue. }
begin
  if (FBorderStyle <> newValue) then
  begin
    FBorderStyle := newValue;
    if HandleAllocated then
      RecreateWnd;
  end; { if }
end; { SetBorderStyle }

procedure TCustomElEdit.SetHideSelection(newValue : Boolean);
{ Sets data member FHideSelection to newValue. }
begin
  if (FHideSelection <> newValue) then
  begin
    FHideSelection := newValue;
    if not Focused then
       Invalidate;
  end; { if }
end; { SetHideSelection }

{$IFNDEF VCL_4_USED}
procedure TCustomElEdit.TriggerResizeEvent;
begin
  if (assigned(FOnResize)) then
    FOnResize(Self);
end; { TriggerResizeEvent }
{$ENDIF}

function TCustomElEdit.CaretFromChar(const CharNum: integer): TPoint;
var
  i: integer;
  Len: integer;
begin
  Len := 0;
  Result.X := 0;
  Result.Y := 0;
  for i := 0 to FElEditList.Count - 1 do
  begin
    Len := Len + Length(FElEditList.Strings[i]) + 2;
    if Len >= CharNum then
    begin
      FElEditList.CaretFromParagraph(i, (CharNum - (Len - (Length(FElEditList.Strings[i]) + 2))),
        Result.X, Result.Y);
      break;
    end;
  end;
end;

function TCustomElEdit.CharFromCaret(const X, Y: integer): integer;
var
  i: integer;
  P, PO: integer;
begin
  Result := 0;
  FElEditList.CaretToParagraph(X, Y, P, PO);
  for i := 0 to P - 1 do
    inc(Result, Length(FElEditList.Strings[i]) + 2);
  inc(Result, PO);
end;

function TCustomElEdit.PosFromCaret(const X, Y: integer): TPoint;
var
  fOrder, fDX: PIntArray;
  FClass: PChar;
  FRes: TGCPResults;
  FText1: TElFString;
  FLen: integer;
  j, i: integer;
  fy, fx: integer;
  FStr: TElFString;
  TS: TSize;
begin
  fx := FLeftMargin;
  fy := (FLineHeight * (Y - TopLine)) + FTopMargin;
  if RightAlignedText then
  begin
    if (FElEditList.ParagraphCount >= Y) then
    begin
      FText1 := StringToPassword(FElEditList.ParagraphStrings[Y]);
      FLen := Length(Ftext1);

      FOrder := nil;
      FDx := nil;
      FClass := nil;
      try
        GetMem(FOrder, FLen * sizeof(Cardinal));
        GetMem(FDX, FLen * sizeof(Integer));
        GetMem(FClass, FLen);

        FillChar(FRes, sizeof(TGCPResultsA), 0);
        FillChar(FOrder^, FLen * sizeof(Cardinal), 0);
        FillChar(FDX^, FLen * sizeof(Integer), 0);
        FillChar(FClass^, FLen, 0);
        FRes.lStructSize := sizeof(TGCPResultsA);
        FRes.lpOrder := @(FOrder[0]);
        FRes.lpDx := @(FDX[0]);
        FRes.lpClass := FClass;
        FRes.nGlyphs := FLen;

        {$IFNDEF VCL_7_USED}
        {$IFDEF ELPACK_UNICODE}
        if Boolean(GetCharacterPlacementW(Canvas.Handle, PWideChar(Ftext1), LongBool(FLen),
          LongBool(0), FRes, GCP_DIACRITIC or GCP_GLYPHSHAPE or GCP_USEKERNING or GCP_REORDER)) then
        {$ELSE}
        if Boolean(GetCharacterPlacementA(Canvas.Handle, PChar(Ftext1), LongBool(FLen), LongBool(0),
          FRes, GCP_DIACRITIC or GCP_GLYPHSHAPE or GCP_USEKERNING or GCP_REORDER)) then
        {$ENDIF}
        {$ELSE}
        {$IFDEF ELPACK_UNICODE}
        if Boolean(GetCharacterPlacementW(Canvas.Handle, PWideChar(Ftext1), FLen, 0, FRes,
           GCP_DIACRITIC or GCP_GLYPHSHAPE or GCP_USEKERNING or GCP_REORDER)) then
        {$ELSE}
        if Boolean(GetCharacterPlacementA(Canvas.Handle, PChar(Ftext1), FLen, 0, FRes,
           GCP_DIACRITIC or GCP_GLYPHSHAPE or GCP_USEKERNING or GCP_REORDER)) then
        {$ENDIF}
        {$ENDIF}
        begin
          for i := FLeftChar to X - 1 do
          begin
            j := 0;
            while FOrder[j] <> i do
              inc(j);
            inc(fx, FDX[FOrder[j]]);
          end;
        end;
      finally
        if FOrder <> nil then
          FreeMem(FOrder);
        if FDX <> nil then
          FreeMem(FDX);
        if FClass <> nil then
          FreeMem(FClass);
      end;
    end
    else
      EElEditorError.CreateFmt('Invalid Y position (%d)', [Y]);
  end
  else
  begin
    if (FElEditList.ParagraphCount >= Y) then
    begin
      FText1 := StringToPassword(FElEditList.ParagraphStrings[Y]);
      {$IFDEF ELPACK_UNICODE}
      FStr := WideCopy(FText1, FLeftChar + 1, (X - FLeftChar));
      FStr := ExpandTabbedString(FStr);
      {$ELSE}
      FStr := Copy(FText1, FLeftChar + 1, (X - FLeftChar));
      FStr := ExpandTabbedString(FStr);
      {$ENDIF}
      TS := FTextPainter.TextSize(FStr);
    end
    else
      EElEditorError.CreateFmt('Invalid Y position (%d)', [Y]);
  end;

  Canvas.Font.Assign(Font);
  if not RightAlignedText then
  begin
    TS := FtextPainter.TextSize(FStr);
    if X < FLeftChar then
      fx := -2
    else
      fx := {fx + }TS.cx;
  end;

  FText1 := ExpandTabbedString(FText1);

  if (Alignment = taCenter) and (FLeftChar = 0) then
    fX := fX + abs(((EditRect.Right - FRightMargin) div 2) - (FtextPainter.TextSize(FText1).cx div 2));

  if (Alignment = taRightJustify) and (FLeftChar = 0) then
  begin
//    if (FLeftChar = 0) and ((EditRect.Right - FRightMargin) >= FtextPainter.TextSize(FText1).cx) then
      fX := fX + abs((EditRect.Right - FRightMargin) - FtextPainter.TextSize(FText1).cx) - 2
//    else
//      fX := fX + 2;
  end;

  if (Alignment = taLeftJustify) or (FLeftChar > 0) then
    fx := fx + FEditRect.Left + FLeftMargin;

  if fx > (FEditRect.Right - FRightMargin) then
    fx := -2;
  if Y >= (TopLine + FLinesInRect) then
    fy := fy + FEditRect.Bottom;

  Result := Point(fx, fy);
end;

function TCustomElEdit.CharsFitLeft;
//var
//  FText1, FText2 : TElFString;
//  i, j, k : integer;
//  TS : TSize;
//  FSum, FTabs: integer;
//
//begin
//  FText1 := Copy(StringToPassword(FText), 1, StartPos);
//  k := Length(FText1);
//  SetLength(FText2, k);
//  for i := 0 to k - 1 do
//    FText2[i + 1] := FText1[k - i];
//  FText1 := ExpandTabbedString(FText2);
//  j := Length(FText1) - 1;
//  if j = -1 then
//  begin
//    result := 0;
//    exit;
//  end;
//  if HandleAllocated then
//    {$IFDEF ELPACK_UNICODE}
//    GetTextExtentPoint32W(Canvas.Handle, PWideChar(FTabString), Length(FTabString), TS);
//    {$ELSE}
//    GetTextExtentPoint32(Canvas.Handle, PChar(FTabString), Length(FTabString), TS);
//    {$ENDIF}
//
//  j := AWidth;
//
//  // here we can ignore margins
//  if HandleAllocated then
//    ElGetTextExtentExPoint(Canvas.Handle, PElFChar(FText1), Length(FText1), j, i, nil, TS);
//
////  result := i;
//
//{  for i := 1 to Length(FText2) do
//    if FText2[i] = ElFTab then
//      dec(result, FTabSpaces - 1);}
//
//  FSum := 0;
//  FTabs := 0;
//  j := 1;
//  while FSum < i do
//  begin
//    if FText2[j] = ElFTab then
//    begin
//      inc(FSum, FTabSpaces);
//      inc(FTabs, FTabSpaces - 1)
//    end
//    else
//      inc(FSum);
//    inc(j);
//  end;
//
//  Result := i - FTabs;
//
//  exit;
begin
  Result := FTextPainter.CharsFitLeft(AWidth, ExpandTabbedString(StringToPassword(FText)), StartPos);
end;

function TCustomElEdit.CharsFitRight(AWidth :integer; FText :TElFString; StartPos :integer):integer;
//var
//  i, j   : integer;
//  //tc, tv : integer;
//  TS     : TSize;
//  FText1 : TElFString;
//  FSum, FTabs: integer;
//
//begin
//  {$IFDEF ELPACK_UNICODE}
//  FText := WideCopy(StringToPassword(FText), StartPos + 1, Length(FText));
//  {$ELSE}
//  FText := Copy(StringToPassword(FText), StartPos + 1, Length(FText));
//  {$ENDIF}
//
//  FText1 := ExpandTabbedString(FText);
//  j := Length(FText1) - 1;
//  if (j = -1) or (AWidth <= 0) then
//  begin
//    result := 0;
//    exit;
//  end;
////  if HandleAllocated then
////    {$IFDEF ELPACK_UNICODE}
////    GetTextExtentPoint32W(Canvas.Handle, PWideChar(FTabString), Length(FTabString), TS);
////    {$ELSE}
////    GetTextExtentPoint32(Canvas.Handle, PChar(FTabString), Length(FTabString), TS);
////    {$ENDIF}
//
//  j := AWidth; {$IFDEF RUCOMMENTS}{ В j общая длина строки}{$ENDIF}
//  i := 0;
//  // here we can ignore margins
//  if HandleAllocated then
//    ElGetTextExtentExPoint(Canvas.Handle, PElFChar(FText1), Length(FText1), j, i, nil, TS);
//
//{  for j := 1 to Length(FText) do
//    if FText[j] = ElFTab then
//      dec(result, FTabSpaces - 1);}
//
//  FSum := 0;
//  FTabs := 0;
//  j := 1;
//  while FSum < i do
//  begin
//    if FText[j] = ElFTab then
//    begin
//      inc(FSum, FTabSpaces);
//      inc(FTabs, FTabSpaces - 1)
//    end
//    else
//      inc(FSum);
//    inc(j);
//  end;
//
//  Result := i - FTabs;
//
//  exit;
begin
  Result := FTextPainter.CharsFitRight(AWidth, ExpandTabbedString(StringToPassword(FText)), StartPos);
end;

procedure TCustomElEdit.CaretFromPos(APos: TPoint; var ACaretX, ACaretY: integer);
var
  i, j,
    fl : integer;
  p,
    p1,
    sp : PInteger;
  TS : TSize;
  sx,
    cv : integer;
    // used in multi-row mode
  le: integer;
  // used in tab expansion
  tc,
    tv : integer;
  FText, ST: TElFString;
begin
  fl := APos.y div FLineHeight;
  inc(fl, FTopLine);
  if fl < 0 then
    fl := 0;
  if fl > FElEditList.ParagraphCount - 1 then
    fl := FElEditList.ParagraphCount - 1;

  ACaretY := fl;
  ST := FElEditList.ParagraphStrings[fl];

  le := length(ST);

  if RightAlignedText then
    // to do
  {$IFDEF ELPACK_UNICODE}
    FText := StringToPassword(WideCopy(ST, FLeftChar, le - FLeftChar + 1))
  {$ELSE}
    FText := StringToPassword(Copy(ST, FLeftChar, le - FLeftChar + 1))
  {$ENDIF}
  else
  {$IFDEF ELPACK_UNICODE}
    FText := StringToPassword(WideCopy(ST, FLeftChar, (le - FLeftChar) + 1));
  {$ELSE}
    FText := StringToPassword(Copy(ST, FLeftChar, (le - FLeftChar) + 1));
  {$ENDIF}

  if Length(FText) = 0 then
  begin
    ACaretX := FLeftChar;
    exit;
  end;

  TS := FTextPainter.TextSize(FTabString);

  tv := TS.cx;

  tc := 0;

  TS := FTextPainter.TextSize(FText);
  case Alignment of
    taRightJustify: sx := (EditRect.Right - FRightMargin) - TS.cx;
    taCenter:       sx := (EditRect.Right - FRightMargin) div 2 - TS.cx div 2;
    else            sx := EditRect.Left + FLeftMargin;
  end;
  // Inc(sx, FLeftMargin);

  j := Length(FText) - 1;
  GetMem(P, (j + 1) * sizeof (Integer));
  sp := p;

  // in the next line we can ignore margins
  FTextPainter.GetTextExtentExPoint(Canvas, PElFChar(FText), Length(FText), FtextPainter.TextSize(FText).cx,
    i, p, TS);
//  ElGetTextExtentExPoint(Canvas.Handle, PElFChar(FText), Length(FText), FtextPainter.TextSize(FText).cx,
//    i, p, TS);
  ACaretX := FLeftChar;

  if FText[1] = ElFTab then
  begin
    inc(tc, tv - p^);
    p^ := tv;
  end;

  cv := p^ div 2;
  if sx + cv >= APos.x then
  begin
    FreeMem(sp);
    exit;
  end;
  for i := 0 to j do
  begin
    if i > 0 then
    begin
      if FText[i+1] = ElFTab then
      begin
        p1 := p;
        dec(p1);
        tc := tc + tv - (p^ - p1^){width of TAB character};
        p^ := p^ + tv - (p^ - p1^){width of TAB character};
        cv := tv div 2;
      end else
      begin
        p^ := p^ + tc;
        cv := p^;
        dec(p);
        cv := (cv - p^) div 2;
        inc(p);
      end;
    end;
    if (sx + P^ - cv) > APos.x then
    begin
      ACaretX := (i + FLeftChar);
      FreeMem(sp);
      exit;
    end;
    inc(p);
  end;
  FreeMem(sp);
//  FText := FElEditList.GetCR(fl);
  ACaretX := Length(FText) + FLeftCHar;
end;

function TCustomElEdit.GetLinesCount: Integer;
begin
  result := FElEditList.ParagraphCount;
end;

procedure TCustomElEdit.SelectAll;
var
  xCaretX: integer;
  xCaretY: integer;
begin
  if not AllowEnhance(etSelectAll) then
    exit;
   
  xCaretY := FElEditList.ParagraphCount - 1;
  xCaretX := Length(FElEditList.ParagraphStrings[FElEditList.ParagraphCount - 1]);

  if (xCaretY >= TopLine + FLinesInRect) then
  begin
    FCaretY := xCaretY;
    FCaretX := xCaretX;
    SetSelection(FCaretX, FCaretY);
    FSelStartX := 0;
    FSelStartY := 0;
    SetCaretPosition(-100, -100);
  end
  else
  begin
    CaretY := xCaretY;
    CaretX := xCaretX;
    FSelStartX := 0;
    FSelStartY := 0;
    SetSelection(CaretX, CaretY);
  end;
  TriggerSelectionChangeEvent;
  RepaintText(EditRect);
end;

procedure TCustomElEdit.SetTabSpaces(newValue : Integer);
begin
  if (FTabSpaces <> newValue) and (newValue > 0) then
  begin
    FTabSpaces := newValue;
    SetLength(FTabString, FTabSpaces);
    {$ifndef KYLIX_USED}
    {$IFDEF ELPACK_UNICODE}
    FillMemory(PWideChar(FTabString), FTabSpaces, 32);
    {$ELSE}
    FillMemory(PChar(FTabString), FTabSpaces, 32);
    {$ENDIF}
    {$else}
    memset(PWideChar(FTabString), 32, FTabSpaces);
    {$endif}
    SetCaretPosition(CaretX, CaretY);
    RepaintText(EditRect);
  end; {if}
end;

procedure TCustomElEdit.DoSetEditRect(newValue : TRect);
{ Sets data member FEditRect to newValue. }
begin
  FEditRect := newValue;
  if (FAlignBottom) then
    SetBottomAlign;
  FLinesInRect := (FEditRect.Bottom - FTopMargin) div FLineHeight;
  SetScrollBarsInfo;
////////////////////////////////////////////////////////////////////////////////
  if Assigned(FOnEditRectChanged) then
   FOnEditRectChanged(Self);
////////////////////////////////////////////////////////////////////////////////
end; { DoSetEditRect }

procedure TCustomElEdit.MakeCaret;
var
  TTM : TTextMetric;
begin
  if HandleAllocated and (not FNoCaret) then
  begin
    Canvas.Font.Assign(Font);
    GetTextMetrics(Canvas.Handle, TTM);
    if fsBold in Font.Style then
      FHasCaret := CreateCaret(Handle, 0, GetSystemMetrics(SM_CXBORDER) * 2, Abs(TTM.tmHeight))
    else
      FHasCaret := CreateCaret(Handle, 0, GetSystemMetrics(SM_CXBORDER), Abs(TTM.tmHeight));

  end;
end;

procedure TCustomElEdit.MoveCaret(CharNum : integer);
var
//  FNewPos  : TPoint;
  FCharPos : TPoint;
begin
  if HandleAllocated then
    FCharPos := Point(FCaretX, FCaretY)//PosFromChar(FText, CharNum)
  else
    FCharPos := Point(0, EditRect.Top);

//  FNewPos := FCharPos;
  if FHasCaret then
  begin
    HideCaret(Handle);
    SetCaretPos(FCharPos.X, FCharPos.Y - 1);
    if Transparent then
      RepaintText(EditRect);
    ShowCaret(Handle);
  end;
end;

procedure TCustomElEdit.SetCaretX(const value: integer);
var
  P1,
  P2,
  PI,
  Len,
  TC: integer;
  Allow:boolean;
  _Value:integer;

begin
  _Value:=Value;
  TriggerCaretXChangedEvent(_Value, Allow);

  if Allow and (Value <> FCaretX) or (Alignment <> taLeftJustify) then
  begin
    FCaretX := _Value;
    Len := Length(FElEditList.ParagraphStrings[FCaretY]);
    if ((FCaretY < FElEditList.ParagraphCount - 1) and (FCaretX > Len) and (not FEnd)) then
    begin
      FElEditList.IndexToParagraph(CaretY, P1, PI);
      TC := CaretY;
//      CaretY := CaretY + 1;
//      FElEditList.IndexToParagraph(CaretY, P2, PI);
      TC := TC + 1;
      FElEditList.IndexToParagraph(TC, P2, PI);
      if (P1 = P2) then
      begin
        if (FCaretX > Len) then
          FCaretX := 1
        else
          FCaretX := 0;
        CaretY := TC;
      end
      else
      begin
        if (FCaretX > Len) then
        begin
          FCaretX := 0;
          CaretY := TC;
        end;
//        else
//          FCaretY := TC;
      end;
    end;
    if ((FCaretY = FElEditList.ParagraphCount - 1) and (FCaretX > Len)) then
      FCaretX := Length(FElEditList.ParagraphStrings[FCaretY]);
    if (FCaretX < 0) and (FCaretY > 0) then
    begin
      FElEditList.IndexToParagraph(CaretY, P1, PI);
      CaretY := CaretY - 1;
      FElEditList.IndexToParagraph(CaretY, P2, PI);
      if FCaretY < FElEditList.ParagraphCount - 1 then
      begin
        if P1 = P2 then
          FCaretX := Length(FElEditList.ParagraphStrings[FCaretY]) - 1
        else
          FCaretX := Length(FElEditList.ParagraphStrings[FCaretY]);
      end
      else
        FCaretX := 0;
    end
    else
    if (FCaretY = 0) and (FCaretX < 0) then
      FCaretX := 0;
    CorrectLeftChar;
    SetCaretPosition(FCaretX, FCaretY);
  end;
end;

procedure TCustomElEdit.SetCaretY(const value: integer);
var
  Len: integer;
begin
  if (FCaretY <> value) then
  begin
    FCaretY := Value;
    if FCaretY > FElEditList.ParagraphCount - 1 then
      FCaretY := FElEditList.ParagraphCount - 1;
    if FCaretY < 0 then
      FCaretY := 0;
    if FCaretY < TopLine then
    begin
      TopLine := FCaretY;
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
    end;
    if FCaretY >= (TopLine + FLinesInRect) then
    begin
      TopLine := (FCaretY - FLInesInRect) + 1;
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
    end;

    Len := Length(FElEditList.ParagraphStrings[FCaretY]);

    if FCaretX > Len then
      FCaretX := Len;

    CorrectLeftChar;
    SetCaretPosition(FCaretX, FCaretY);
  end;
end;

function TCustomElEdit.GetCaretXY: TPoint;
begin
  Result := Point(CaretX, CaretY);
end;

procedure TCustomElEdit.SetCaretXY(const Value: TPoint);
begin
  CaretY := Value.Y;
  CaretX := Value.X;
end;


procedure TCustomElEdit.CorrectLeftChar;
var
  FText1: TElFString;
  TS: TSize;
  i: integer;

begin
  if HandleAllocated then
  begin
    if FElEditList.ParagraphCount > 0 then
      FText1 := FElEditList.ParagraphStrings[CaretY]
    else
      FText1 := '';

    TS := FTextPainter.TextSize(FText1);
    if TS.CX > (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin) then
      ForceLeftAlignment := true;

    if TS.CX <= (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin) then
      ForceLeftAlignment := false;
  end;

  if (Alignment = taCenter) and not (ForceLeftAlignment) then
  begin
    // if text width is less than edit width, we center-align the text
    if TS.cx < (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin) then
    begin
      FLeftChar := 0;
      SetScrollBarsInfo;
    end;
  end;
  if (Alignment = taLeftJustify) or ForceLeftAlignment then
  begin
    if (Alignment = taLeftJustify) then
      i := CharsFitRight((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin), FText1, FLeftChar)
    else
      i := CharsFitLeft((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin), FText1, Length(FText1));

    if ((FCaretX {+ FTabCor}) > FLeftChar + i) then
    begin
      if HandleAllocated then
      begin
        {$IFDEF ELPACK_UNICODE}
        TS := FtextPainter.TextSize(WideCopy(FText1, FLeftChar + 1, FCaretX - FLeftChar));
        {$ELSE}
        TS := FtextPainter.TextSize(Copy(FText1, FLeftChar + 1, FCaretX - FLeftChar));
        {$ENDIF}
        if TS.CX >= ((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin)) then
        begin
          if (Alignment = taLeftJustify) or FMultiline then
            if FRightBorderSpace then
              i := CharsFitLeft(((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin)) div 8 * 7, FText1, FCaretX)
            else
              i := CharsFitLeft(((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin)), FText1, FCaretX)
          else
            i := CharsFitLeft(((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin)), FText1, FCaretX);

          if (not FWordWrap) or (not Multiline) then
          begin
            FLeftChar := (FCaretX) - i;
            SetScrollBarsInfo;
          end;
          if FLeftChar < 0 then
          begin
            FLeftChar := 0;
            SetScrollBarsInfo;
          end;
          RepaintText(EditRect);
        end;
      end;
    end
    else
    if ((FCaretX <= FLeftChar) and (FLeftChar > 0)) then
    begin
      i := CharsFitLeft(((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin))
        div 4 * 3, FText1, FCaretX);
      if (not FWordWrap) or (not Multiline) then
        FLeftChar := FCaretX - i;
      if FLeftChar < 0 then
        FLeftChar := 0;
      SetScrollBarsInfo;
      if HandleAllocated then
        RepaintText(EditRect);
    end
    else
    if ((Alignment <> taLeftJustify) and (FLeftChar > 0)) then
    begin
      i := CharsFitLeft((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin), FText1, Length(FText1));
      FLeftChar := Length(FText1) - i;
    end;
  end
  else
  if Alignment = taRightJustify then
  begin
    if HandleAllocated then
    begin
      if TS.CX < ((EditRect.Right - FRightMargin) - (EditRect.Left + FLeftMargin)) then
      begin
        if FLeftChar <> 0 then
        begin
          FLeftChar := 0;
          SetScrollBarsInfo;
          RepaintText(EditRect);
        end;
      end
      else
      begin
        i := CharsFitRight((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin), FText1, FLeftChar);
        if (FCaretX >= FLeftChar + i) then
        begin
          if HandleAllocated then
          begin
            {$ifdef ELPACK_UNICODE}
            TS := FtextPainter.TextSize(WideCopy(StringToPassword(FText1), FLeftChar + 1, (FCaretX - FLeftChar) + 1));
            {$else}
            TS := FtextPainter.TextSize(Copy(StringToPassword(FText1), FLeftChar + 1, FCaretX - FLeftChar));
            {$endif}
            if TS.CX >= (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin) then
            begin
              if (not FWordWrap) or (not Multiline) then
              begin
                FLeftChar := FCaretX - i;
                SetScrollBarsInfo;
              end;
              if FLeftChar < 0 then
              begin
                FLeftChar := 0;
                SetScrollBarsInfo;
              end;
              RepaintText(EditRect);
            end;
          end;
        end
        else
        if ((FCaretX <= FLeftChar) and (FLeftChar > 0))  then
        begin
          FLeftChar := FCaretX;
          SetScrollBarsInfo;
          if FLeftChar < 0 then
          begin
            FLeftChar := 0;
            SetScrollBarsInfo;
          end;
          if HandleAllocated then
            RepaintText(EditRect);
        end;
      end;
    end;
  end;
end;

procedure TCustomElEdit.SetCaretPosition(const X, Y: integer);
var
  FPos: TPoint;
begin
  FPos := PosFromCaret(X, Y);
  if FHasCaret then
  begin
    HideCaret(Handle);
    SetCaretPos(FPos.X, FPos.Y);
    if Transparent then
      RepaintText(EditRect);
    ShowCaret(Handle);
  end;
end;

procedure TCustomElEdit.SetMultiline(const Value: boolean);
begin
  if FMultiline <> Value then
  begin
    FMultiline := Value;
    if Value then
    begin
      AlignBottom := false;
    end;
    if not FMultiline then
     ScrollBars := ssNone;
    if HandleAllocated and (ComponentState * [csLoading, csReading] = []) then
      RecreateWnd
    else
      SetScrollBarsInfo;
    FUpdate := true;
    FElEditList.Text := Text;
    FUpdate := false;
    if HandleAllocated then
      SetEditRect(ClientRect);
  end;
end;

procedure TCustomElEdit.EMGetSel(var Message: TMessage);
var ss, se : integer;
begin
  ss := SelStart;

  if SelLength >= 0 then
    se := ss + SelLength
  else
  begin
    ss := SelStart + SelLength;
    se := SelStart;
  end;
  Message.result := se shr 16 or ss;
  if Message.lParam <> 0 then
    PDWord(Message.lParam)^ := se;
  if Message.wParam <> 0 then
    PDWord(Message.wParam)^ := ss;
end;

procedure TCustomElEdit.EMGetLine(var Message: TMessage);
var S : TElFString;
    S1: string;
    i : integer;
begin
  if InRange(0, Lines.Count - 1, Message.wParam) then
    S := Lines.Strings[Message.wParam]
  else
    S := '';

  if Message.lParam = 0 then
    Message.Result := 0
  else
  begin
    i := PWord(Pointer(Message.lParam))^;
    S1 := S;
    i := Min(Length(S1), i);
    if i > 0 then
      Move(PChar(S1)^, PChar(Pointer(Message.lParam))^, i);
    Message.Result := i;
  end;
  if not InRange(0, Lines.Count - 1, Message.wParam) then
    Message.result := 0;
end;

procedure TCustomElEdit.EMGetLineCount(var Message: TMessage);
begin
  Message.Result := Lines.Count;
end;

procedure TCustomElEdit.EMLineIndex(var Message: TMessage);
var
  P, PI: integer;
  fx, fy: integer;
begin
  if (Message.wParam = -1) then
  begin
    FElEditList.IndexToParagraph(CaretY, P, PI);
    FElEditList.CaretFromParagraph(P, 0, fx, fy);
    Message.Result := CharFromCaret(0, fy);
  end;
  if Message.wParam > FElEditList.Count - 1 then
    Message.Result := -1
  else
  begin
    FElEditList.IndexToParagraph(Message.wParam, P, PI);
    FElEditList.CaretFromParagraph(P, 0, fx, fy);
    Message.Result := CharFromCaret(0, Message.wParam);
  end;
end;

procedure TCustomElEdit.EMSetSel(var Message: TMessage);
begin
  if Message.WParam = -1 then
  begin
    UnSelect;
  end
  else
  if (Message.WParam = 0) and (Message.lParam = -1) then
    SelectAll
  else
  begin
    if Message.WParam < Message.lParam then
    begin
      SelStart := Message.lParam;
      SelLength := -(Message.lParam - Message.WParam);
      //if FSelLength = 0 then
      //  RepaintText(EditRect);
    end
    else
    begin
      SelStart := Message.wParam;
      SelLength := (Message.lParam - Message.WParam);
      //if FSelLength = 0 then
      //  RepaintText(EditRect);
    end;
  end;
end;

procedure TCustomElEdit.EMReplaceSel(var Message: TMessage);
var S : string;
begin
  if Message.lParam = 0 then
    exit;
  if Message.wParam <> 0 then
    DeleteSelection;

  S := StrPas(PChar(Pointer(Message.lParam)));
  SetSelText(S);
end;

procedure TCustomElEdit.EMGetFirstVisibleLine(var Message: TMessage);
begin
  Message.Result := Self.TopLine
end;

procedure TCustomElEdit.EMScroll(var Message: TMessage);
begin
  Scroll(TElEditScrollDir(Message.wParam));
end;

procedure TCustomElEdit.EMLineScroll(var Message: TMessage);
begin
  TopLine := TopLine + Message.lParam;
end;


procedure TCustomElEdit.EMScrollCaret(var Message: TMessage);
begin
  ScrollCaret;
end;

procedure TCustomElEdit.EMLineFromChar(var Message: TMessage);
var
  P, PI : integer;
begin
  FElEditList.IndexToParagraph(CaretFromChar(Message.wParam).Y, P, PI);
  Message.Result := P;
end;

procedure TCustomElEdit.EMPosFromChar(var Message: TMessage);
var
  P : TPoint;
begin
  P := CaretFromChar(Message.wParam);
  P := PosFromCaret(P.X, P.Y);
  Message.Result := P.Y shl 16 or P.X;
end;

function TCustomElEdit.StringToPassword(AString : TElFString) : TElFString;
var
  j : integer;
begin
  if FPasswordChar = #0 then
  begin
    Result := AString;
    exit;
  end;
  j := Length(AString);
  SetLength(Result, j);
  while j > 0 do
  begin
    if (AString[j] = ElFCR) or (AString[j] = ElFLF) then
      Result[j] := AString[j]
    else
      Result[j] := FPasswordChar;
    dec(j);
  end;
end;

function TCustomElEdit.ExpandTabbedString(Text : TElFString) : TElFString;
var
  i : integer;
  {$IFDEF ELPACK_UNICODE}
  S : WideString;
  {$ENDIF}
begin
  while {$IFDEF ELPACK_UNICODE}WidePos(ElFTab, Text){$ELSE}Pos(#9, Text){$ENDIF} > 0 do
  begin
    {$IFDEF ELPACK_UNICODE}
    S := Text;
    i := WidePos(ElFTab, S);
    WideDelete(S, i, 1);
    WideInsert(FTabString, S, i);
    Text := S;
    {$ELSE}
    i := Pos(#9, Text);
    Delete(Text, i, 1);
    Insert(FTabString, Text, i);
    {$ENDIF}
  end;
  result := Text;
end;

procedure TCustomElEdit.RepaintText(Rect : TRect);
var
  R : TRect;
begin
  if HandleAllocated then
  begin
    // if HasCustomBackground then
    if Transparent then
    begin
      R := EditRect;
      MapWindowPoints(Handle, Parent.Handle, R, 2);
      InvalidateRect(Parent.Handle, @R, true);
      Parent.Update;
    end;
    InvalidateRect(Handle, @Rect, HasCustomBackground);
  end;
end;

function TCustomElEdit.CutToClipboard: boolean;
var
  {$IFDEF ELPACK_UNICODE}
  _S:WideString;
  {$ELSE}
  _S:string;
  {$ENDIF}
  Allow: Boolean;
begin
  Result := False;
  if FPasswordChar <> #0 then
    exit;

  _S := SelectedText;
  _TriggerTextChangedEvent(self, _S, Allow);
  Result := Allow;
  if Allow then begin
    CopyToClipboard;
    if not ReadOnly then
    begin
      DeleteSelection;
      DoChange;
      if not NotifyUserChangeOnly then
        Change;
      TriggerSelectionChangeEvent;
    end;
  end;  
end; {CutToClipboard}

procedure TCustomElEdit.CopyToClipboard;
var
  Clip : TClipboard;
  {$IFDEF ELPACK_UNICODE}
  mem : Cardinal;
  ptr : Pointer;
  SelText : WideString;
  SelLen : integer;
  {$ENDIF}
  S : String;
begin
  if FPasswordChar <> #0 then
    exit;
  if {FSelLength <> 0}FSelected then
  begin
    Clip := Clipboard;
    Clip.Open;
    {$IFDEF ELPACK_UNICODE}
    SelText := GetSelectedText;
    SelLen := (Length(SelText) + 1) * 2;
    mem := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, SelLen);
    ptr := GlobalLock(mem);
    Move(PWideChar(SelText)^, ptr^, SelLen);
    GlobalUnlock(mem);
    if Win32Platform = VER_PLATFORM_WIN32_NT then
     Clip.SetAsHandle(CF_UNICODETEXT, mem)
    else
    begin
     S := SelText;
     SelLen := Length(S) + 1;
     mem := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, SelLen);
     ptr := GlobalLock(mem);
     Move(PChar(S)^, ptr^, SelLen);
     GlobalUnlock(mem);
     Clip.SetAsHandle(CF_TEXT, mem);
     Clip.SetAsHandle(cf_Locale, Lang_Russian);
    end;
    {$ELSE}
    Clip.AsText := ConvertBreaksFormat(GetSelectedText);
    {$ENDIF ELPACK_UNICODE}
    Clip.Close;
  end;
end; {CopyToClipboard}

function TCustomElEdit.PasteFromClipboard: boolean;
var
  Clip : TClipboard;
//  FSaveSel : TPoint;
  {$IFDEF ELPACK_UNICODE}
  mem: Cardinal;
  ptr: Pointer;
  StrEnd : PWideChar;
  {$ENDIF}
  {$IFDEF ELPACK_UNICODE}
  _S:WideString;
  Piece    : WideString;
  {$ELSE}
  _S:string;
  Piece    : string;
  {$ENDIF}
  fx, fy: integer;
  FPos: TPoint;
  GLen, PLen: integer;
  Allow:boolean;

begin
  Result := False;
  if ReadOnly then
    exit;
  Clip := Clipboard;
  Clip.Open;
  {$IFDEF ELPACK_UNICODE}
  if not Clipboard.HasFormat(CF_UNICODETEXT) then
  begin
    Piece := Clip.AsText;
  end
  else
  begin
    mem := Clipboard.GetAsHandle(CF_UNICODETEXT);
    SetLength(Piece, GlobalSize(mem));
    ptr := GlobalLock(mem);
    Move(ptr^, PWideChar(Piece)^, Length(Piece));
    StrEnd := WideStrScan(PWideChar(Piece), #0);
    if StrEnd <> nil then
      SetLength(Piece, StrEnd - PWideChar(Piece));
    GlobalUnlock(mem);
  end;
  {$ELSE}
  Piece := Clip.AsText;
  {$ENDIF ELPACK_UNICODE}
  Clip.Close;

  PLen := Length(Piece);
  GLen := Length(Text);
  if PLen = 0 then
    exit;

  if ((PLen + GLen) > FMaxLength) and (FMaxLength > 0) then
  {$IFDEF ELPACK_UNICODE}
    Piece := WideCopy(Piece, 1, (FMaxLength - GLen));
  {$ELSE}
    Piece := Copy(Piece, 1, (FMaxLength - GLen));
  {$ENDIF}

  if CharCase <> eecNormal then
  begin
    {$IFNDEF ELPACK_UNICODE}
    if CharCase = eecUppercase then
      Piece := Uppercase(Piece)
    else
      Piece := Lowercase(Piece);
    {$ELSE}
    if CharCase = eecUppercase then
      Piece := WideUppercase(Piece)
    else
      Piece := WideLowercase(Piece);
    if (IsWinNTUp) and (FKeyDown) then
      if CharCase = eecUppercase then
        Piece := WideUppercase(Piece)
      else
        Piece := WideLowercase(Piece);
    {$ENDIF}
  end;

  FRestrictOnTextChange:=true;
  if FSelected then
    DeleteSelection;
  FRestrictOnTextChange:=false;    

  FX := CaretX;
  FY := CaretY;
  FPos := CaretXY;
  Allow:=true;
  _S:=Text;
{$IFDEF ELPACK_UNICODE}
  WideInsert(Piece, _S, FX+1);
{$ELSE}
  Insert(Piece, _S, FX+1);
{$ENDIF}
  { параметры, отдаваемые не отвечают реальному положению дел. возможно поправить в дальнейшем. }
  _TriggerTextChangedEvent(self, _S, Allow);
  Result := Allow;
  if Allow then begin
    FElEditList.InsertText(FX, FY, Piece);

    CaretY := FY;
    CaretX := FX;
{    DoChange;
    if not NotifyUserChangeOnly then
      Change; }
    TriggerSelectionChangeEvent;
    RepaintText(FEditRect);
    FSelStartX := CaretX;
    FSelStartY := CaretY;
    FUndo.AddAction(atInsert, FPos, CaretXY, Piece);
  end;
end; {PasteFromClipboard}

procedure TCustomElEdit.Undo;
var
  FX, FY: integer;
  AFAction: TElAction;
  FGroup: boolean;
begin
  FGroup := false;
  repeat
  if FUndo.CanUndo then
  begin
    AFAction := FUndo.PopItem;
    with AFAction do
      case FAction of
      atDeleteSel, atDelete, atBackSpace:
        begin
          FRedo.PushItem(AFAction);
          FX := FEndPos.X;
          FY := FEndPos.Y;
          FElEditList.InsertText(FX, FY, FStr);
          CaretXY := FStartPos;
          FSelStartX := CaretX;
          FSelStartY := CaretY;
          if FAction = atDeleteSel then
            if (FStartPos.Y > FY) or ((FStartPos.Y = FY) and (FStartPos.X >= FX)) then
              SetSelection(FEndPos.X, FEndPos.Y)
            else
              SetSelection(FX, FY)
        end;
      atInsert:
        begin
          FRedo.PushItem(AFAction);
          CaretXY := FStartPos;
          FSelStartX := FStartPos.X;
          FSelStartY := FStartPos.Y;
          SetSelection(FEndPos.X, FEndPos.Y);
          FUndo.Lock;
          DeleteSelection;
          FUndo.UnLock;
        end;
        atLineBreak:
          FRedo.PushItem(AFAction);
        atGroupBreak:
          FGroup := not FGroup;
        end;
      RepaintText(FEditRect);
    end;
  until not FGroup;
  Modified := FUndo.CanUndo;
  DoChange;
  if not NotifyUserChangeOnly then
    Change;
end; {Undo}

procedure TCustomElEdit.SetModified(newValue : Boolean);
{ Sets data member FModified to newValue. }
begin
//  if newValue then
//    inc(FModifyCount)
//  else
//    dec(FModifyCount);
  FModified := newValue;
end; { SetModified }

procedure TCustomElEdit.CreateParams(var Params : TCreateParams); { protected }
const
  BorderStyles : array[TBorderStyle] of Cardinal = (0, WS_BORDER);
  MultilineStyles: array[boolean] of Cardinal = (0, ES_MULTILINE);
  ScrollBar : array[TScrollStyle] of DWORD = (0, WS_HSCROLL, WS_VSCROLL,
    WS_VSCROLL or WS_HSCROLL);
  LeftSB: array[Boolean] of DWORD = (0, WS_EX_LEFTSCROLLBAR);
  RightText: array[Boolean] of DWORD = (0, WS_EX_RTLREADING or WS_EX_RIGHT);

begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle] or MultilineStyles[FMultiline];
    if {$IFDEF OLDELSCROLLBARS}(not FUseCustomScrollBars) and{$ENDIF} Multiline then
      Style := Style or ScrollBar[FScrollBars];

    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;

    if NewStyleControls then
      ExStyle := ExStyle or LeftSB[RightAlignedView] or RightText[RightAlignedText]
    else if UseCustomScrollBars then
      ExStyle := ExStyle or LeftSB[RightAlignedView];

    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
    if Transparent then
      ExStyle := ExStyle or WS_EX_TRANSPARENT;
  end;
  if (BorderStyle = bsSingle) and Flat and (not (ThemesAvailable and
    UseXPThemes {and QueryThemeData})) then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := Params.ExStyle and (not WS_EX_CLIENTEDGE);
  end;
end; { CreateParams }

procedure TCustomElEdit.WMSetFocus(var Msg : TWMSetFocus); { private }
begin
  inherited;
  if CanFocus or (GetParentForm(Self) = nil) then
  begin
    MakeCaret;
    if FHasCaret then
    begin
      SetCaretPosition(CaretX, CaretY);
      ShowCaret(Handle);
    end;
    if AutoSelect then
    begin
      SelectAll;
      LeftChar := 0;
      TopLine := 0;
    end;
    if FHideSelection or IsTextEmpty then
      RepaintText(EditRect);
  end;
  FAlienFocus := false;
  if Flat and (not IsThemeApplied) then
    DrawFlatBorder;
end; { WMSetFocus }

procedure TCustomElEdit.WMKillFocus(var Msg : TWMKillFocus); { private }
begin
  if FHasCaret then
  begin
    DestroyCaret;
    FHasCaret := false;
    //if Transparent then RepaintText(EditRect);
  end;
  if Msg.FocusedWnd = 0 then
    FAlienFocus := true;
  inherited;
  if not HandleAllocated then
    exit;
  if FHideSelection or IsTextEmpty then
    RepaintText(EditRect);
  if Flat and (not IsThemeApplied) then
    DrawFlatBorder;
end; { WMKillFocus }

procedure TCustomElEdit.WMEnable(var Msg : TMessage); { private }
begin
  inherited;
  if Msg.WParam = 0 then
  begin
    if FHasCaret then
    begin
      DestroyCaret;
      FHasCaret := false;
    end
  end
  else
  begin
    // Раскомментировано, иначе приводило к появлению в поле каретки при
    // отсутствии фокуса в компоненте в случае смены флага Enabled = True и
    // смены шрифта см. обработчик CMFontChanged, что неправильно. Морозов М.А.
    (*** Было так: *************************************************************
      // if Focused then
      // begin
        MakeCaret;
      // end;
     **************************************************************************)
    if Focused then
    begin
      MakeCaret;
    end;
  end;
end; { WMEnable }

function TCustomElEdit.RepaintRightMargin(aOldSize:integer; aForce:boolean):boolean;
Var
  Follow:boolean;
  Delta:integer;
  I:integer;
  FText1:string;
  TS:TagSize;
  NewSize:integer;
begin
  Result:=false;
  if HandleAllocated then
  begin
    if FElEditList.ParagraphCount > 0 then
      FText1 := FElEditList.ParagraphStrings[CaretY]
    else
      FText1 := '';
  end;

  NewSize:=(EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin);
  {$ifdef ELPACK_UNICODE}
  TS := FtextPainter.TextSize(WideCopy(StringToPassword(FText1), FLeftChar + 1, (Length(FText1) - FLeftChar) + 1));
  {$else}
  TS := FtextPainter.TextSize(Copy(StringToPassword(FText1), FLeftChar + 1, FCaretX));
  {$endif}

  if TS.CX <= aOldSize then
    Follow := true
  else
    Follow := false;

  if Follow then begin
    Delta:=NewSize - TS.CX;
    if (NewSize>aOldSize) or ((NewSize<aOldSize) and (Delta<FDeltaSize{20})) then begin
      if NewSize<=FDeltaSize{20} then begin
        i:=0;
      end
      else begin
        i := CharsFitLeft(NewSize-FDeltaSize{20}, FText1, Length(FText1));
      end;
      if (LeftChar<>(Length(FText1)-i)) or aForce then begin
        LeftChar:=Length(FText1)-i;
        Result:=true;
      end;
    end
  end;

end;

procedure TCustomElEdit.WMSize(var Msg : TWMSize); { private }
var
  ACaretX, ACaretY, P, PO: integer;
  l_Repainted: boolean;
//  OldLeftChar: integer;
begin
  inherited;
  if HandleAllocated then
  begin
    if ((not FMultiline) and AutoSize) and
      (ComponentState * [csLoading, csReading, csDestroying] = []) then
      AdjustHeight;

    SetEditRect(ClientRect);
    FElEditList.CaretToParagraph(CaretX, CaretY, P, PO);
    FElEditList.Reformat;
    FElEditList.ReCount(0);
    FElEditList.CaretFromParagraph(P, PO, ACaretX, ACaretY);
    CaretY := ACaretY;
    CaretX := ACaretX;
    FSelStartX := CaretX;
    FSelStartY := CaretY;

    l_Repainted := false;
    if FSmartOnResize then begin
      if RepaintRightMargin(FOldSize) then begin
        RepaintText(EditRect);
        l_Repainted := true;
      end;
    end;

    if (Alignment <> taLeftJustify) and not l_Repainted then
      RepaintText(EditRect);
  end;
  {$IFNDEF VCL_4_USED}
  TriggerResizeEvent;
  {$ENDIF}
  FOldSize := (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin);
  if FOldSize < 0 then
    FOldSize := 0;
end; { WMSize }


//???
procedure TCustomElEdit.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
var
  fx, fy: integer;
  FBeg, FEnd: TPoint;
  b : boolean;
begin
 b := false;
  if (Enabled) and (CanFocus) and (not (csDesigning in ComponentState)) and
    (GetFocus <> Handle) then
  begin
    if Multiline and (Scrollbars <> ssNone) then
    begin
      if
      {$IFDEF OLDELSCROLLBARS}
         PtInRect(Self.scbVert.BoundsRect, Point(X, Y)) or
         PtInRect(Self.scbHorz.BoundsRect, Point(X, Y))
      {$ELSE}
(*         PtInRect(Self.scbVert.ScrollBarRect, Point(X, Y)) or
         PtInRect(Self.scbHorz.ScrollBarRect, Point(X, Y))*) // <trash> // LAW
         false
      {$ENDIF}
      then
        exit;
    end;

    FMouseClick := true;
    CaretFromPos(Point(X, Y), FX, FY);
    CaretY := FY;
    CaretX := FX;
    FSelStartX := CaretX;
    FSelStartY := CaretY;
//    SetFocus;
    FMouseClick := false;
    if AutoSelect then
      SelectAll;
    b := true;
  end;
  if (ssDouble in Shift) and FDropSelection then
  begin
    CaretFromPos(Point(X, Y), FX, FY);
    CaretY := FY;
    CaretX := FX;
    FBeg := GetPrevWord(CaretXY);
    FEnd := GetNextWord(CaretXY);
    FSelStartX := FBeg.X;
    FSelStartY := FBeg.Y;
    SetSelection(FEnd.X, FEnd.Y);
    CaretXY := FEnd;
    RepaintText(FEditRect);
  end
  else
  if mbLeft = Button then
  begin
    CaretFromPos(Point(X, Y), FX, FY);
    CaretY := FY;
    CaretX := FX;
    if FDropSelection then
    begin
      if (not (ssShift in Shift)) and (not b) then
      begin
        UnSelect;
        FSelStartX := FX;
        FSelStartY := FY;
      end
      else
      if (not b) then
        SetSelection(CaretX, CaretY);
    end;
        
    TriggerSelectionChangeEvent;
    RepaintText(EditRect);
    FSelecting := true;
  end;
  if (Enabled) and (CanFocus) and (not (csDesigning in ComponentState)) and
    (GetFocus <> Handle)
    then
    SetFocus;
  SetCapture(Handle);
  inherited;
end; { MouseDown }

procedure TCustomElEdit.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
{$ifndef VCL_5_USED}
var
  APnt : TPoint;
{$endif}
//{$ifdef CLX_USED}
//var
//  AForm : TCustomForm;
//  FHasFocus: boolean;
//{$endif}
begin
  ReleaseCapture;
  if not FSelecting then
  begin
    {$ifndef VCL_5_USED}
    if (mbRight = Button) then
    begin
      APnt := Point(X, Y);
      APnt := ClientToScreen(APnt);
      if Assigned(PopupMenu) then
      begin
        PopupMenu.PopupComponent := Self;
        inherited;
        if PopupMenu.AutoPopup then
          PopupMenu.Popup(APnt.X, APnt.Y);
        ReleaseCapture;
        exit;
      end
      else
        if UseSystemMenu then
        begin
          ElCallSysMenu(ElEditMenu, Handle, APnt.X, APnt.Y, Self);
          ReleaseCapture;
        end;
    end;
    {$endif}
  end
  else
  begin
    FSelecting := false;
  end;
  inherited;
end; { MouseUp }

function TCustomElEdit.ExecInternalMouseMove : Boolean;
begin
 Result := True;
end;

procedure TCustomElEdit.InternalMouseMove(Shift : TShiftState; X, Y : Integer);
// virtual;
var
 FX, FY: integer;
begin
 if FDropSelection and {(FSelected) and }(ssLeft in Shift) then
 begin
   FSelected := true;
   CaretFromPos(Point(X, Y), FX, FY);
   SetSelection(FX, FY);
   CaretY := FY;
   CaretX := FX;
   TriggerSelectionChangeEvent;
   RepaintText(FEditRect);
 end;
end;

procedure TCustomElEdit.MouseMove(Shift : TShiftState; X, Y : Integer); { protected }
begin
  {$IFDEF OLDELSCROLLBARS}
  if (FUseCustomScrollBars and Multiline) then
    Perform(WM_SETCURSOR, Handle, WM_MOUSEMOVE shl 16 or HTCLIENT);
  {$ENDIF}
  if ExecInternalMouseMove then
   InternalMouseMove(Shift, X, Y);
  inherited;
end; {MouseMove}

procedure TCustomElEdit.KeyPress(var Key : Char); { protected }
var
  ANewStr: TElFString;
  SKey : Char;
  FCarY, FCarX, P, PO: integer;
  {$IFDEF ELPACK_UNICODE}
  S1 : WideString;
  {$ELSE}
  S1 : string;
  {$ENDIF}
  S2 : TElFString;
  FTStr: TElFString;
  FPos: TPoint;
  Allow:boolean;
begin
  try
    FRestrictOnTextChange:=true;

  SKey := Key;
  inherited KeyPress(SKey);

  if ((Integer(Key) = 127) or (Integer(Key) = VK_BACK) or
      (Integer(Key) = VK_RETURN) or  (Integer(Key) = VK_ESCAPE) or
      (Integer(Key) = VK_TAB)) or
     (Key = #0) or
     (FSelecting) then
    exit;

  if ReadOnly or (SKey = #0) or (SKey < #32) then
  begin
    {$IFDEF ELPACK_UNICODE}
    FKeys := '';
    {$ENDIF}
    exit;
  end;

  if ((Length(Text) >= FMaxLength) and (FMaxLength > 0)) and (not FSelected) then
  begin
    {$IFDEF ELPACK_UNICODE}
    FKeys := '';
    {$ENDIF}
    exit;
  end;

  Key := SKey;
  if CharCase <> eecNormal then
  begin
    {$IFNDEF ELPACK_UNICODE}
    if CharCase = eecUppercase then
      Key := Uppercase(Key)[1]
    else
      Key := Lowercase(Key)[1];
    {$ELSE}
    if CharCase = eecUppercase then
      Key := Char(WideUppercase(Key)[1])
    else
      Key := Char(WideLowercase(Key)[1]);
    if (IsWinNTUp) and (FKeyDown) then
      if CharCase = eecUppercase then
        FKeys := WideUppercase(FKeys)
      else
        FKeys := WideLowercase(FKeys);
    {$ENDIF}
  end;

  {$IFDEF ELPACK_UNICODE}
  if (IsWinNTUp) and (FKeyDown) then
  begin
    S2 := FKeys;
    TriggerKeyPressEx(S2);
  end
  else
  begin
    S2 := Key;
  end;
  {$ELSE}
  S2 := Key;
  {$ENDIF}

  Allow := False;
  if S2 <> '' then
  begin
    // begin of group undo actions.
    FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
    if FSelected then
      DeleteSelection;

    if RightAlignedText then
    begin
      FElEditList.CaretToParagraph(CaretX, CaretY, P, PO);
      S1 := FElEditList.ParagraphStrings[CaretY];
      {$IFDEF ELPACK_UNICODE}
      if (IsWinNTUp) and (FKeyDown) then
      begin
        WideInsert(S2, S1, (Length(S1) + 1) - CaretX);
        FTStr := S2;
        FKeyDown := false;
      end
      else
      begin
        WideInsert(S2, S1, (Length(S1) + 1) - CaretX);
        FTStr := S2;
      end;
      _TriggerTextChangedEvent(self, S1, Allow);
      {$ELSE}
      Insert(S2, S1, CaretX);
      FTStr := S2;
      _TriggerTextChangedEvent(self, S1, Allow);
      {$ENDIF}

      if Allow then begin
        FElEditList.ParagraphStrings[CaretY] := S1;
      end;
    end
    else
    begin
      FElEditList.CaretToParagraph(CaretX, CaretY, P, PO);
      S1 := FElEditList.ParagraphStrings[CaretY];
      {$IFDEF ELPACK_UNICODE}
      if (IsWinNTUp) and (FKeyDown) then
      begin
        WideInsert(S2, S1, CaretX + 1);
        FTStr := S2;
        FKeyDown := false;
      end
      else
      begin
        WideInsert(S2, S1, CaretX + 1);
        FTStr := S2;
      end;
      {$ELSE}
      Insert(S2, S1, CaretX + 1);
      FTStr := S2;
      {$ENDIF}
      FRestrictOnTextChange:=false;
      _TriggerTextChangedEvent(self, S1, Allow);
      if Allow then begin
        FElEditList.ParagraphStrings[CaretY] := S1;
      end;
    end;

    if (FMaxLength = 0) or (Length(ANewStr) <= FMaxLength) then
    begin
       FPos := CaretXY;
      if RightAlignedText then
        FElEditList.CaretFromParagraph(P, PO, FCarX, FCarY)
      else
        FElEditList.CaretFromParagraph(P, PO + Length(FTStr), FCarX, FCarY);

      CaretY := FCarY;
      CaretX := FCarX;
      FSelStartY := CaretY;
      FSelStartX := CaretX;
      FUndo.AddAction(atInsert, FPos, CaretXY, FTStr);
      Modified := true;
      DoChange;
      Change;
      TriggerSelectionChangeEvent;
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
    end;
    FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
  end;

  finally
    FRestrictOnTextChange:=false;
  end;
end;

procedure TCustomElEdit.SetText(newValue: TElFString);
begin
  if (ComponentState * [csLoading, csReading, csDestroying] <> []) then
  begin
    FElEditList.Text := newValue;
    exit;
  end;
  if (FElEditList.Text <> newValue) then
  begin
    {$IFNDEF ELPACK_UNICODE}
    if FCharCase = eecUppercase then
      NewValue := Uppercase(NewValue)
    else
    if FCharCase = eecLowercase then
      NewValue := Lowercase(NewValue);
    {$ELSE}
    if FCharCase = eecUppercase then
      NewValue := WideUppercase(NewValue)
    else
    if FCharCase = eecLowercase then
      NewValue := WideLowercase(NewValue);
    {$ENDIF}

    if FElEditList.ParagraphCount > 0 then
    begin
    { было:
      FUndo.AddAction(atDelete, Point(0, 0), Point(FElEditList.ParagraphCount - 1,
                  Length(FElEditList.ParagraphStrings[FElEditList.ParagraphCount - 1])),
                  newValue);
    }
      FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
      FUndo.AddAction(atDelete, {Point(0, 0),}Point(Length(FElEditList.ParagraphStrings[FElEditList.ParagraphCount - 1]),
                  FElEditList.ParagraphCount - 1),
                  Point(Length(FElEditList.ParagraphStrings[FElEditList.ParagraphCount - 1]),
                  FElEditList.ParagraphCount - 1),
                  Text);
      FUndo.AddAction(atInsert, Point(0, 0), Point(Length(newValue), 0), newValue);
      FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
    end;

    if HandleAllocated then
      SendMessage(Handle, WM_SETTEXT,
      {$IFDEF ELPACK_UNICODE}
      1, Integer(PWideChar(newValue)))
      {$ELSE}
      0, Integer(PChar(newValue)))
      {$ENDIF}
    else
    begin
      //if not NotifyUserChangeOnly then
      //  Change;
      FElEditList.Text := newValue;
      DoChange;
      if not NotifyUserChangeOnly then
        Change;
    end;
    SetScrollBarsInfo;
  end; { if }
end; { SetText }

function TCustomElEdit.GetNextWord(ACaret: TPoint) : TPoint;
var
  P: {$IFDEF ELPACK_UNICODE}PWideChar{$ELSE}PChar{$ENDIF};
  j : integer;
  CharNum: integer;
  wasbl : boolean;
  PA, PI: integer;
begin
  FElEditList.CaretToParagraph(ACaret.X, ACaret.Y, PA, PI);
  CharNum := PI;
  {$IFDEF ELPACK_UNICODE}
  P := PWideChar(FElEditList.Strings[PA]);
  {$ELSE}
  P := PChar(FElEditList.Strings[PA]);
  {$ENDIF}
  inc(P, CharNum);
  wasbl := (p^ in [ElFTab, ElFSpace]);
  if p^ in [ElFCR, ElFLF] then
  begin
    Result := Point(CharNum + 1, PI);
    exit;
  end;
  j := 0;
  while (p^ <> #13) and (p^ <> #10) do
  begin
    if P^ = #0 then
    begin
      if ACaret.Y < FElEditList.ParagraphCount - 1 then
        Result := Point(0, ACaret.Y + 1)
      else
        Result := Point(CharNum, ACaret.Y);
      exit;
    end;
    if ((P + 1)^ = #0) then
    begin
      FElEditList.CaretFromParagraph(PA, Length(FElEditList.Strings[PA]), ACaret.X, ACaret.Y);
      Result := ACaret;
      exit;
    end;
    if wasbl xor (p^ in [ElFTab, ElFSpace]) then
    begin
      while (p^ in [ElFTab, ElFSpace]) do
      begin
        inc(j);
        inc(p);
      end;
      FElEditList.CaretFromParagraph(PA, CharNum + j, ACaret.X, ACaret.Y);
      Result := ACaret;
      exit;
    end;
    inc(j);
    inc(p);
  end;
  Result := Point(CharNum + j, ACaret.Y);
end;

function TCustomElEdit.GetPrevWord(ACaret: TPoint): TPoint;
var
  p : {$IFDEF ELPACK_UNICODE}PWideChar{$ELSE}PChar{$ENDIF};
  i, j: integer;
  CharNum: integer;
  wasbl : boolean;
  PA, PI: integer;
begin
  FElEditList.CaretToParagraph(ACaret.X, ACaret.Y, PA, PI);
  CharNum := PI;
  {$IFDEF ELPACK_UNICODE}
  P := PWideChar(FElEditList.Strings[PA]);
  {$ELSE}
  P := PChar(FElEditList.Strings[PA]);
  {$ENDIF}
  inc(P, CharNum);
  wasbl := (p^ in [ElFTab, ElFSpace]);
  if p^ in [ElFCR, ElFLF] then
  begin
    result := Point(CharNum, ACaret.Y);
    exit;
  end;
  i := CharNum;
  j := 0;
  while (p^ <> ElFCR) and (p^ <> ElFLF) do
  begin
    if i < 0 then
    begin
      if PA > 0 then
        FElEditList.CaretFromParagraph(PA - 1, Length(FElEditList.Strings[PA - 1]),
          ACaret.X, ACaret.Y)
      else
        ACaret := Point(0, 0);

      Result := ACaret;
      exit;
    end;
    if wasbl xor (p^ in [ElFTab, ElFSpace]) then
    begin
      while (not (p^ in [ElFTab, ElFSpace])) do
      begin
        dec(i);
        inc(j);
        dec(p);
        if ((i < 0) or (p^ = ElFCR) or (p^ = ElFLF)) then
          break;
      end;
      FElEditList.CaretFromParagraph(PA, CharNum - j + 1, ACaret.X, ACaret.Y);
      Result := ACaret;
      exit;
    end;
    dec(i);
    inc(j);
    dec(p);
    if i = 0 then
    begin
      FElEditList.CaretFromParagraph(PA, 0, ACaret.X, ACaret.Y);
      Result := ACaret;
      exit;
    end;
  end;
  Result := Point(CharNum - j + 1, ACaret.Y);
end;

function TCustomElEdit.ConvertBreaksFormat(Text : TElFString) : TElFString;
var
  i : integer;
  {$IFDEF ELPACK_UNICODE}
  S : WideString;
  {$ENDIF}
begin
  result := Text;
  i := 1;
  while i < Length(result) do
  begin
    if Result[i + 1] = #10 then
    begin
      {$IFDEF ELPACK_UNICODE}
      S := Result;
      WideInsert(#13, S, i + 1);
      result := S;
      {$ELSE}
      insert(#13, Result, i + 1);
      {$ENDIF}
      inc(i, 2);
    end
    else if Result[i + 1] = #13 then
    begin
      {$IFDEF ELPACK_UNICODE}
      S := Result;
      WideInsert(#10, S, i + 2);
      result := S;
      {$ELSE}
      insert(#10, Result, i + 2);
      {$ENDIF}
      inc(i, 2);
    end
    else
      inc(i);
  end;
end; {ConvertBreaksFormat}

procedure TCustomElEdit.WMGetDlgCode(var Msg : TWMGetDlgCode); { private }
begin
  Msg.Result := DefWindowProc(Handle, Msg.Msg, TMessage(Msg).wParam, TMessage(Msg).lParam);
  Msg.Result := (Msg.Result and (not DLGC_WANTALLKEYS)) or DLGC_WANTARROWS or DLGC_WANTCHARS
    or DLGC_HASSETSEL;
  if WantTabs then
    Msg.Result := Msg.Result or DLGC_WANTTAB;
  if HandleDialogKeys or (Multiline and WantReturns) then
    Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end; { WMGetDlgCode }

(*
function UniCodeToAnsi(Charset: integer; const S: WideString): AnsiString;
var
  DefChar : Char;
  Flags : Integer;
  Len : integer;
  Res : integer;
begin
  Flags := WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR;
  DefChar := '?';
  Len := Length(s) div 2;
  Res := WideCharToMultiByte(Charset, Flags, PWideChar(s), Len, nil, 0, @DefChar, nil);
  if (Res = 0) and (Charset <> CP_ACP) then
  begin
    Charset := CP_ACP;
    Res := WideCharToMultiByte(Charset, Flags, PWideChar(s), Len, nil, 0, @DefChar, nil);
  end;
  if Res <> 0 then
  begin
    SetLength(Result, Res * 2);
    WideCharToMultiByte(Charset, Flags, PWideChar(s), Len, PAnsiChar(Result), Res * 2, @DefChar, nil);
  end
  else
  begin
    SetLength(Result, Len);
    FillChar(PChar(Result)^, Len, '?');
  end;
end;
*)

{$IFDEF ELPACK_UNICODE}
procedure TCustomElEdit.WMImeStartComposition(var Message: TMessage);
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
begin
  IMC := ImmGetContext(Handle);
  if (IMC <> 0) then
  begin
    GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @LogFont);
    ImmSetCompositionFont(IMC, @LogFont);
    CF.dwStyle := CFS_RECT;
    CF.rcArea  := EditRect;
    inc(CF.rcArea.Left, LeftMargin);
    dec(CF.rcArea.Right, RightMargin);
    CF.ptCurrentPos := PosFromCaret(CaretX, CaretY);

    ImmSetCompositionWindow(IMC, @CF);
    ImmReleaseContext(Handle, IMC);
  end;
  inherited;
end;

type
  TIMECompositionStringProc = function(hImc: HIMC; dWord1: DWORD; lpBuf: pointer;
    dwBufLen: DWORD): Longint; stdcall;

procedure TCustomElEdit.WMImeComposition(var Message: TMessage);
var
  IMC: HIMC;
  S: String;
  SNT: TElFString;
  Size: Integer;
  StrEnd: PWideChar;
  ImmGetCompositionStringW: TIMECompositionStringProc;
  fx, fy: integer;
  LTextLen, LSNTLen: Integer;
begin
  // Input of word is finished?
  if ((Message.LParam and GCS_RESULTSTR) <> 0) then
  begin
    IMC := ImmGetContext(Handle);
    if (IMC <> 0) and (not ReadOnly) then
    begin
      // NT, 2000, XP?
      if IsWinNTUp then
      begin
        try
          SNT := '';
          if GetModuleHandle('IMM32') <> 0 then
          begin
            ImmGetCompositionStringW := GetProcAddress(GetModuleHandle('IMM32'),
              'ImmGetCompositionStringW');
            if @ImmGetCompositionStringW <> nil then
            begin
              Size := ImmGetCompositionStringW(IMC, GCS_RESULTSTR, nil, 0);
              SetLength(SNT, Size);
              FillWideChar(PWideChar(SNT)^, Size, #0);
              ImmGetCompositionStringW(IMC, GCS_RESULTSTR, PWideChar(SNT), Size);
            end;
          end;
        finally
          ImmReleaseContext(Handle, IMC);
        end;
        StrEnd := WideStrScan(PWideChar(SNT), WideChar(#0));
        if StrEnd <> nil then
          SetLength(SNT, StrEnd - PWideChar(SNT));
      end
      else
      begin
        // IME support for Win95-98
        // Unfortunately, should properly work not for all versions
        // (you'll get a line of '?')
        S := '';
        try
          Size := ImmGetCompositionStringA(IMC, GCS_RESULTSTR, nil, 0);
          SetLength(s, Size);
          ImmGetCompositionStringA(IMC, GCS_RESULTSTR, PChar(s), Size);
        finally
          ImmReleaseContext(Handle, IMC);
        end;
        SNT := KeyToUnicode(s);
      end;

      if FCharCase = eecUppercase then
        SNT := WideUppercase(SNT)
      else
      if FCharCase = eecLowercase then
        SNT := WideLowercase(SNT);

      TriggerKeyPressEx(SNT);

      if SNT <> '' then
      begin
        LTextLen := Length(Text);
        LSNTLen := Length(SNT);

        if ((LTextLen + LSNTLen) > FMaxLength) and (FMaxLength > 0) then
          SNT := WideCopy(SNT, 1, (FMaxLength - LTextLen));

        if FSelected then
          DeleteSelection;

        fx := CaretX;
        fy := CaretY;

        FElEditList.InsertText(fx, fy, SNT);

        CaretY := fy;
        CaretX := fx;
        FSelStartX := fx;
        FSelStartY := fy;
        RepaintText(FEditRect);

        DoChange;
        Change;
      end;
      Message.Result := 0;
    end
  end
  else
    inherited;
end;
{$ENDIF}

function TCustomElEdit.GetSelectedText : TElFString;
var
  bP, bPO: integer;
  eP, ePO: integer;
  i: integer;
  // fast;
  L, Size, Count: Integer;
  {$IFDEF ELPACK_UNICODE}
  P: PWideChar;
  S: WideString;
  {$ELSE}
  P: PChar;
  S: String;
  {$ENDIF}
begin
   // {!}to do fast getseltext
   FElEditList.CaretToParagraph(FSelFirstX, FSelFirstY, bP, bPO);
   FElEditList.CaretToParagraph(FSelLastX, FSelLastY, eP, ePO);
   if eP = bP then
     {$IFDEF ELPACK_UNICODE}
     Result := WideCopy(FElEditList.FParagraphs.Items[bP].Text, bPO + 1, (ePO - bPO))
     {$ELSE}
     Result := Copy(FElEditList.FParagraphs.Items[bP].Text, bPO + 1, (ePO - bPO))
     {$ENDIF}
   else
   begin
     {$IFDEF ELPACK_UNICODE}
     Result := WideCopy(FElEditList.FParagraphs.Items[bP].Text, bPO + 1,
                        Length(FElEditList.FParagraphs.Items[bP].Text)) + ElFCRLF;
     {$ELSE}
     Result := Copy(FElEditList.FParagraphs.Items[bP].Text, bPO + 1,
                    Length(FElEditList.FParagraphs.Items[bP].Text)) + ElFCRLF;
     {$ENDIF}

     Size := Length(Result);
     Count := Size;
     inc(Size, ePO);
     for I := bP + 1 to eP - 1 do
       Inc(Size, Length(FElEditList.FParagraphs.Items[i].Text) + 2);
     SetLength(Result, Size);
     {$IFDEF ELPACK_UNICODE}
     P := PWideChar(Result);
     {$ELSE}
     P := PChar(Result);
     {$ENDIF}
     inc(P, Count);
     for I := bP + 1 to eP - 1 do
     begin
       S := FElEditList.FParagraphs.Items[i].Text;
       L := Length(S);
       if L <> 0 then
       begin
         {$IFDEF ELPACK_UNICODE}
         WideMove(S[1], P^, L);
         {$ELSE}
         Move(S[1], P^, L);
         {$ENDIF}
         Inc(P, L);
       end;
       P^ := #13;
       Inc(P);
       P^ := #10;
       Inc(P);
     end;
     {$IFDEF ELPACK_UNICODE}
     S := WideCopy(FElEditList.FParagraphs.Items[eP].Text, 1, ePO);
     {$ELSE}
     S := Copy(FElEditList.FParagraphs.Items[eP].Text, 1, ePO);
     {$ENDIF}
     L := Length(S);
     if L > 0 then
     begin
       {$IFDEF ELPACK_UNICODE}
       WideMove(S[1], P^, L);
       {$ELSE}
       Move(S[1], P^, L);
       {$ENDIF}
       // Inc(P, L);
     end;
   end;
end;

destructor TCustomElEdit.Destroy;
begin
  Destroying;
  {$IFDEF ELPACK_USE_IMAGEFORM}
  FImgFormChLink.Free;
  {$ENDIF}
  FreeAndNil(FTextPainter);
//  FElEditList.FParagraphs.Items[0].Free;
  FElEditList.Free;
  FBackground.Free;
  {$IFDEF OLDELSCROLLBARS}
  FreeAndNil(scbVert);
  FreeAndNil(scbHorz);
  FVertScrollBarStyles.Free;
  FHorzScrollBarStyles.Free;
  {$ENDIF}
  FUndo.Free;
  FRedo.Free;
  inherited;
end; { Destroy }

constructor TCustomElEdit.Create(AOwner : TComponent);
begin
////////////////////////////////////////////////////////////////////////////////
  FRestrictOnTextChange:=false;
  FDropSelection:=true;
  FArrowsSelect:=true;
  FSmartOnResize:=true;
  FOldSize:=0;
  FDeltaSize:=20;
  FNoCaret:=false;
  FEmptyHint:='';
  FEmptyHintColor := cEmptyHintColor;
  FRightBorderSpace:=true;
  FPaintSelectionMode := false;
////////////////////////////////////////////////////////////////////////////////
  NotifyUserChangeOnly := true;
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csCaptureMouse, csOpaque] + [csFixedHeight];
  FMultiline := false;
  FModifyCount := 0;
  FlagEdit := false;
  {$IFDEF ELPACK_UNICODE}
  FCDead := 1;
  FDeadChar := #0;
  {$ENDIF}
  FEnd := false;
  FUpdate := false;
  Ctl3D := true;
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
                                                                                          
  SetLeftMargin(1);
  SetRightMargin(1);
  FAlignBottom := true;
  FUseSystemMenu := true;
  FTextPainter := CreateTextPainter;
  if not FAlignBottom then
    FTopMargin := 1;
  Width := 200;
  Height := 100;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  // Height := Abs(Font.Height) + GetSystemMetrics(SM_CYBORDER) * 2 + 4;
  FLineHeight := Abs(Font.Height) + 2;
  FEditRect.Right := 100 - GetSystemMetrics(SM_CXBORDER);
  FEditRect.Bottom := Height - GetSystemMetrics(SM_CYBORDER);
  FLinesInRect := (FEditRect.Bottom - FTopMargin) div FLineHeight;
  FTabSpaces := 4;
  FTabString := '    ';
  FTopLine := 0;
  FWantReturns := false;
  FElEditList := TElEditStrings.Create;
  FAutoSize := true;
  FAlienFocus := false;
  FElEditList.FElEdit := Self;

//  SetScrollBarsInfo;
  FBorderStyle := bsSingle;
  ParentColor := false;
  Color := clWindow;
  Cursor := crIBeam;
  MoveCaret(0);
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FModified := False;
  TabStop := true;
  {$IFDEF MSWINDOWS}
  FBorderSides := AllBorderSides;
  {$ENDIF}
  {$IFDEF ELPACK_USE_IMAGEFORM}
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  {$ENDIF}

  FUseCustomScrollBars := True;
  {$IFDEF OLDELSCROLLBARS}
  scbVert := TElScrollBar.Create(nil);
  scbHorz := TElScrollBar.Create(nil);
  with scbVert do
  begin
    Parent := Self;
    Kind := sbVertical;
    OnScroll := OnVScroll;
    Ctl3D := false;
    TabStop := false;
    Width := GetSystemMetrics(SM_CXHTHUMB);
    FVertScrollBarStyles := TElScrollBarStyles.Create(scbVert, Self);
    FVertScrollBarStyles.ThumbMode := etmAuto;
    FVertScrollBarStyles.OnChange := SBChanged;
    Visible := (FUseCustomScrollBars and Multiline) and (ScrollBars in [ssVertical, ssBoth]);
  end;
  dec(FEditRect.Right, FVertScrollBarStyles.Width - 1);
  with scbHorz do
  begin
    Parent := Self;
    OnScroll := OnHScroll;
    Ctl3D := false;
    TabStop := false;
    Height := GetSystemMetrics(SM_CYVTHUMB);
    FHorzScrollBarStyles := TElScrollBarStyles.Create(scbHorz, Self);
    FVertScrollBarStyles.ThumbMode := etmAuto;
    FHorzScrollBarStyles.OnChange := SBChanged;
    Visible := (FUseCustomScrollBars and Multiline) and (ScrollBars in [ssHorizontal, ssBoth]);
  end;
  dec(FEditRect.Bottom, FHorzScrollBarStyles.Width - 1);
  {$ELSE}
(*  {< ELSCROLLBAR}
  fSBCtrl := TElSBController.Create(Self);
  // Horizontal:
  fSBCtrl.UseXPThemes := true;
  fSBCtrl.HorzScrollBarStyles.OnScroll := OnHScroll;
  fSBCtrl.HorzScrollBarStyles.OnChange := SBChanged;
  fSBCtrl.HorzScrollBarStyles.Visible :=
    (FUseCustomScrollBars and Multiline) and (ScrollBars in [ssHorizontal, ssBoth]);
  dec(FEditRect.Right, GetSystemMetrics(SM_CXHTHUMB) - 1);
  // Vertical:
  fSBCtrl.VertScrollBarStyles.OnScroll := OnVScroll;
  fSBCtrl.VErtScrollBarStyles.OnChange := SBChanged;
  fSBCtrl.VertScrollBarStyles.Visible :=
    (FUseCustomScrollBars and Multiline) and (ScrollBars in [ssVertical, ssBoth]);
  dec(FEditRect.Bottom, GetSystemMetrics(SM_CYVTHUMB) - 1);
  {> ELSCROLLBAR}*)
  {$ENDIF}
//  AdjustHeight;
  SetScrollBarsInfo;
  {$IFDEF ELPACK_UNICODE}
  ToUnicode := GetProcAddress(GetModuleHandle('USER32'), 'ToUnicode');
  {$ENDIF}
  CaretX := 0;
  CaretY := 0;
  FUndo := TElActionList.Create;
  FRedo := TElActionList.Create;

  FHighlightAlphaLevel := 255;
  FHideSelection := true;
  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := clBtnShadow;
  FLinkedControlPosition := lcpTopLeft;
  FDisabledColor := clBtnFace;
  FDisabledFontColor := clGrayText;
end; { Create }

procedure TCustomElEdit.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

{$IFDEF ELPACK_USE_IMAGEFORM}
procedure TCustomElEdit.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      {$IFDEF VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      {$ENDIF}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then
      FImgForm.RegisterChanges(FImgFormChLink);
    if HandleAllocated then
    begin
      {$IFDEF MSWINDOWS}
      RecreateWnd;
      Perform(CM_COLORCHANGED, 0, 0);
      {$ELSE}
      RecreateWidget;
      colorChanged;
      {$ENDIF}
    end;
  end;
end;
{$ENDIF}

procedure TCustomElEdit.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TCustomElEdit.WMNCCalcSize(var Message : TWMNCCalcSize);
begin
  if (BorderStyle = bsSingle) and Flat and (not (ThemesAvailable and UseXPThemes)) then
  begin
    {$IFDEF OLDELSCROLLBARS}
    if (not UseCustomScrollBars) or (not Multiline) then
    {$ENDIF}
      inherited;

      if (ebsLeft in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      if (ebsTop in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      if (ebsRight in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      if (ebsBottom in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

    if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
      Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
    if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
      Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
  end
  else
  begin
    {$IFDEF OLDELSCROLLBARS}
    if (not UseCustomScrollBars) or (not Multiline) then
    {$ENDIF}
    begin
      inherited;
      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

      if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
        Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
      if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
        Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
    end
    {$IFDEF OLDELSCROLLBARS}
    else
    begin
      if BorderStyle = bsSingle then
      begin
        if (ebsLeft in BorderSides) then
          inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
        if (ebsTop in BorderSides) then
          inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
        if (ebsRight in BorderSides) then
          dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
        if (ebsBottom in BorderSides) then
          dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

        if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
          Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
        if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
          Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
      end;
    end;
    {$ENDIF}
  end;
  // Message.Result := WVR_REDRAW;
end;

procedure TCustomElEdit.SetBorderSides(Value: TElBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElEdit.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then
      DrawFlatBorder;
  end;
end;

procedure TCustomElEdit.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      if Flat then
        Invalidate
      else
        RecreateWnd;
    SetScrollBarsInfo;
  end;
end;

procedure TCustomElEdit.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then
      DrawFlatBorder;
  end;
end;

{$IFDEF ELPACK_USE_IMAGEFORM}
procedure TCustomElEdit.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TCustomElEdit.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;
{$ENDIF}

procedure TCustomElEdit.WMWindowPosChanged(var Message: TWMWindowPosChanged);
////////////////////////////////////////////////////////////////////////////////
var
 lTemp   : TRect;
 lWMSize : TWMSize;
////////////////////////////////////////////////////////////////////////////////
begin
  inherited;
////////////////////////////////////////////////////////////////////////////////
// В случае если при обработке WM_WINDOWPOSCHANGED не будет вызвана           //
// DefWindowProc компонент не получит WM_SIZE, не будет установлена EditRect  //
// и текст отрисуется не корректно                                            //
////////////////////////////////////////////////////////////////////////////////
  lTemp := EditRect;
  SetEditRect(ClientRect);
  if not EqualRect(lTemp, EditRect) then
  begin
   FillChar(lWMSize, SizeOf(lWMSize), 0);
   with lWMSize do
   begin
    Height   := Self.Height;
    Width    := Self.Width;
    SizeType := SIZE_RESTORED;
    Msg      := WM_SIZE;
   end;
   WMSize(lWMSize);
  end;
////////////////////////////////////////////////////////////////////////////////
  UpdateLinkedControl;
  {$IFDEF ELPACK_USE_IMAGEFORM}
  Perform(IFM_REPAINTCHILDREN, 0, 0);
  {$ENDIF}
end;

procedure TCustomElEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if FLinkedControl = AComponent then
      LinkedControl := nil;
    {$IFDEF ELPACK_USE_IMAGEFORM}
    if AComponent = FImgForm then
    begin
      ImageForm := nil;
    end;
    {$ENDIF}
  end;
end;

procedure TCustomElEdit.DrawBackground(DC: HDC; R: TRect);
var
  X, Y: integer;
begin
  if FUseBackground and not FBackground.Empty then
  begin
    X := R.Left; Y := R.Top;
    while Y < R.Bottom do
    begin
      while X < R.Right do
      begin
        BitBlt(DC, X, Y, R.Right - X, R.Bottom - Y,
          FBackground.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(X, FBackground.Width);
      end;
      X := R.Left;
      Inc(Y, FBackground.Height);
    end;
  end;
end;

procedure TCustomElEdit.DrawFlatBorder;
var
  DC : HDC;
  R  : TRect;
  b  : boolean;
  BS : TElFlatBorderType;
  AColor : TColor;
const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);
begin
  if not HandleAllocated then
    exit;
  R := Rect(0, 0, Width, Height);
  DC := GetWindowDC(Handle);
  try
    if IsThemeApplied (*and (BorderStyle = bsSingle)*) then
    begin
      (*
      R1 := ClientRect;
      R1.TopLeft := Parent.ScreenToClient(ClientToScreen(R1.TopLeft));

      ax := Left - R1.Left;
      ay := Top  - R1.Top;

      R1 := ClientRect;
      OffsetRect(R1, -ax, -ay);

      with R1 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      DrawThemeBackground(Theme, DC, 0, 0, R, nil);
      *)
      RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);
      exit;
    end
    else
    begin
      if BorderStyle = bsSingle then
      begin
        b := Focused or FMouseOver;
        if b then
           BS := FActiveBorderType
        else
           BS := FInactiveBorderType;
        if Focused or FMouseOver then
          AColor := LineBorderActiveColor
        else
          AColor := LineBorderInactiveColor;
        if not Flat then
          BS := fbtSunken;
        DrawFlatFrameEx2(DC, R, AColor, Color, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
      end;
      if not IsThemeApplied then
      begin
        if (not UseCustomScrollBars) and
           (FFlatFocusedScrollBars or not (Focused or FMouseOver))
        then
          DrawFlatScrollbars(Handle, DC, R,
            (Focused or FMouseOver) and not FFlatFocusedScrollBars,
            ScrollBars, False, False, False,
            GetWindowLong(Handle, GWL_STYLE) or
              BordersFlat[(not Ctl3D) and (BorderStyle = bsSingle)],
            GetWindowLong(Handle, GWL_EXSTYLE) or Borders3D[Ctl3D and (BorderStyle = bsSingle)]
          );
      end;
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

type
  THackWinControl = class(TWinControl);

procedure TCustomElEdit.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
  R: TRect;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      R := EditRect;
      with r do
        IntersectClipRect(DC, Left, Top, Right, Bottom);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

function TCustomElEdit.GetThemedClassName: WideString;
begin
  Result := 'EDIT';
end;

procedure TCustomElEdit.SetWordWrap(Value: boolean);
begin
  if (FWordWrap <> Value) then
  begin
    FWordWrap := Value;
    Invalidate;
    SetScrollBarsInfo;
    FElEditList.Reformat;
    FElEditList.ReCount(0);
  end;
end;

procedure TCustomElEdit.SetScrollBars(const Value: TScrollStyle);
begin
    if (FScrollBars <> Value) {and (FMultiline){and ((Value <> ssNone) and (FMultiline)))} then
    begin
      if FMultiline then
        FScrollBars := Value
      else
        FScrollBars := ssNone;
      if HandleAllocated then
      begin
        if (ComponentState * [csLoading, csReading] = []) then
          RecreateWnd;
        SetScrollBarsInfo;
      end;
    end;
end;

procedure TCustomElEdit.WMVScroll(var Msg : TWMScroll);
(*var
  b : boolean;
  sc: TElScrollCode;
  sp: integer;*) // <trash> // LAW
begin
(* b := false;
 sc := escTrack;
 case Msg.ScrollCode of
   SB_LINEDOWN:
   begin
     sc := escLineDown;
     sp := FTopLine + 1;
   end;
   SB_LINEUP:
   begin
     sc := escLineUp;
     sp := FTopLine - 1;
   end;
   SB_PAGEUP:
   begin
     sc := escPageUp;
     sp := FTopLine - FLinesInRect;
   end;
   SB_PAGEDOWN:
   begin
     sc := escPageDown;
     sp := FTopLine + FLinesInRect;
   end;
   SB_THUMBTRACK:
   begin
     sc := escTrack;
     sp := Msg.Pos;
   end;
   SB_THUMBPOSITION:
   begin
     sc := escPosition;
     sp := Msg.Pos;
   end;
   SB_TOP:
   begin
     sc := escTop;
     sp := 0;
   end;
   SB_BOTTOM:
   begin
     sc := escBottom;
     sp := FElEditList.ParagraphCount - FLinesInRect;
   end;
   SB_ENDSCROLL:
   begin
     sc := escEndScroll;
     sp := FTopLine;
   end;
 end;
 if (sp >= 0) and (sp <= FElEditList.ParagraphCount - 1) then
   OnVScroll(Self, sc, sp, b);*) // <trash> // LAW
end;

procedure TCustomElEdit.WMHScroll(var Msg : TWMScroll);
(*var
  b : boolean;
  sc: TElScrollCode;
  sp: integer;*)
begin
(* b := false;
 sc := escTrack;
 case Msg.ScrollCode of
   SB_LINEDOWN:
   begin
     sc := escLineDown;
     sp := FLeftChar + 5;
   end;
   SB_LINEUP:
   begin
     sc := escLineUp;
     sp := FLeftChar - 5;
   end;
   SB_PAGEUP:
   begin
     sc := escPageUp;
     sp := FLeftChar - ClientWidth div 2;
   end;
   SB_PAGEDOWN:
   begin
     sc := escPageDown;
     sp := FLeftChar + ClientWidth div 2;
   end;
   SB_THUMBPOSITION:
   begin
     sc := escPosition;
     sp := Msg.Pos;
   end;
   SB_THUMBTRACK:
   begin
     sc := escTrack;
     sp := Msg.Pos;
   end;
   SB_LEFT:
   begin
     sc := escTop;
     sp := 0;
   end;
   SB_RIGHT:
   begin
     sc := escBottom;
     sp := FElEditList.FMaxLen - scbHorz.Page - 1;
   end;
   SB_ENDSCROLL:
   begin
     sc := escEndScroll;
     sp := FLeftChar;
   end;
 end;
 if (sp >= 0) and (sp <= FElEditList.FMaxLen) then
   OnHScroll(Self, sc, sp, b);*) // <trash> // LAW
end;

procedure TCustomElEdit.WMInputLangChange(var Msg: TMessage);
begin
  FCharSet := Msg.WParam;
  // FKeybLayout := HKL(Msg.LParam);
end;

procedure TCustomElEdit.WMCommand(var Msg: TWMCommand);
begin
  case Msg.ItemID of
  // Select All in Windows 9x/ME - 1025, in NT/2k/XP - 177
  177, 1025: SelectAll;
  ID_PASTE: begin
    if PasteFromClipboard then
    begin
      DoChange;
      Change;
    end;
  end;
  ID_CUT: begin
    if CutToClipboard then
    begin
      DoChange;
      Change;
    end;
  end;
  ID_COPY: CopyToClipboard;
  ID_DELETE:
    begin
      if FSelected then
        DeleteSelection;
      DoChange;
      Change;  
    end;
  ID_UNDO: Undo;
  end;
end;

procedure TCustomElEdit.WMMouseWheel(var Msg: TWMMouseWheel);
var
  Dy : integer;
  sl : integer;
begin
  if Multiline then
  begin
    if IsWinNT or IsWin98 then
       SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
    else
       sl := 3;
    if sl = 0 then
      sl := 1;
    Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
(*    if Dy <> 0 then
    begin
      scbVert.Position := TopLine - Dy;
      TopLine := scbVert.Position;
      scbVert.Position := FTopLine;
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
    end;*) // <trash> // LAW
  end
  else
   inherited;
end;

procedure TCustomElEdit.WMCaptureChanged(var Msg: TMessage);
begin
  inherited;
end;

procedure TCustomElEdit.SetLeftChar(Value: integer);
begin
  if (FLeftChar <> Value) and ((not FWordWrap) or (not Multiline)) then
  begin
    FLeftChar := Value;
    if FLeftChar < 0 then
      FLeftChar := 0;
    if FLeftChar > FElEditList.FMaxLen then
      FLeftChar := FElEditList.FMaxLen;

    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);

    Invalidate;
    SetScrollBarsInfo;
  end;
end;

procedure TCustomElEdit.SetTopLine(const Value: integer);
begin
  if FTopLine <> Value then
  begin
    if Value < 0 then
      if FTopLine = 0 then
        exit
      else FTopLine := 0
    else
      if (Value + FLinesInRect) > FElEditList.ParagraphCount then
      begin
        if (FTopLine = FElEditList.ParagraphCount - FLinesInRect) and (FTopLine > 0) then
          exit;
        //if FTopLine > 0 then
        FTopLine := Min(Value, FElEditList.ParagraphCount - FLinesInRect);
        if FTopLine < 0 then
          FTopLine := 0;
        //else
        //  FTopLine := 0;
      end
      else
        FTopLine := Value;

    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
    Invalidate;
    SetScrollBarsInfo;
  end;
end;

procedure TCustomElEdit.SetScrollBarsInfo;
var
  FMin: integer;
  si  : TScrollInfo;
  FCharsMax: integer;
  FMaxStr: TElFString;
{$IFDEF OLDELSCROLLBARS}
var
  VScrollRect: TRect;
  HScrollRect: TRect;
{$ENDIF}
begin
{.$ifndef CLX_USED}
  //exit;
  if not HandleAllocated then
    exit;
  // Set Scrollbars properties
  // VScroll

  {$IFDEF OLDELSCROLLBARS}
  if (FUseCustomScrollBars and Multiline) and (ScrollBars in [ssVertical, ssBoth]) then
  begin
    if RightAlignedView then
    begin
      if ScrollBars = ssBoth then
        VScrollRect := Rect(0, 0, VertScrollBarStyles.Width, ClientHeight -
          HorzScrollBarStyles.Width)
      else
        VScrollRect := Rect(0, 0, VertScrollBarStyles.Width, ClientHeight);
    end
    else
    begin
      if ScrollBars = ssBoth then
        VScrollRect := Rect(ClientWidth - VertScrollBarStyles.Width, 0, VertScrollBarStyles.Width,
          ClientHeight - HorzScrollBarStyles.Width)
      else
        VScrollRect := Rect(ClientWidth - VertScrollBarStyles.Width, 0, VertScrollBarStyles.Width,
          ClientHeight);
    end;
    with VScrollRect do
      scbVert.SetBounds(Left,Top, Right, Bottom);
  end;
  {$ENDIF}

  FMin := (FElEditList.ParagraphCount - FLinesInRect);
  if (FMin > 0) then
  begin
    if ScrollBars in [ssVertical, ssBoth] then
    begin
      si.cbSize := SizeOf(Si);
      si.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
      si.nMin := 0;
      si.nMax := FElEditList.ParagraphCount - 1;
      si.nPage := FLinesInRect;
      si.nPos := TopLine;
      {$IFDEF OLDELSCROLLBARS}
      if FUseCustomScrollBars then
      begin
        EnableScrollBar(Handle, SB_VERT, ESB_DISABLE_BOTH);
        scbVert.Visible := true;
        scbVert.Enabled := true;
      end
      else
      {$ENDIF}
      begin
        EnableScrollBar(Handle, SB_VERT, ESB_ENABLE_BOTH);
        {$IFDEF OLDELSCROLLBARS}
        scbVert.Visible := false;
        {$ENDIF}
        SetScrollInfo(Handle, SB_VERT, si,
          {$IFDEF OLDELSCROLLBARS}not FUseCustomScrollBars{$ELSE}True{$ENDIF});
      end;
      {$IFDEF OLDELSCROLLBARS}
      scbVert.SetScrollInfo(si, true);
      {$ENDIF}
    end
    {$IFDEF OLDELSCROLLBARS}
    else
      if FUseCustomScrollBars then
        scbVert.Visible := false;
    {$ENDIF}
  end
  else
  begin
//    FTopLine := 0;
    if ScrollBars in [ssVertical, ssBoth] then
    begin
      {$IFDEF OLDELSCROLLBARS}
      if FUseCustomScrollBars then
      begin
        scbVert.Max := scbVert.Min;
        scbVert.Enabled := false;
        scbVert.Visible := true;
        Invalidate;
      end
      else
      {$ENDIF}
      begin
        {$IFDEF OLDELSCROLLBARS}
        scbVert.Visible := false;
        {$ENDIF}
        EnableScrollBar(Handle, SB_VERT, ESB_DISABLE_BOTH);
        si.cbSize := sizeof(Si);
        si.fMask := SIF_RANGE;
        si.fMask := si.fMask or SIF_DISABLENOSCROLL;
        si.nMin := 0;
        si.nMax := 0;
        SetScrollInfo(Handle, SB_VERT, si,
          {$IFDEF OLDELSCROLLBARS}not FUseCustomScrollBars{$ELSE}True{$ENDIF});
        {$IFDEF OLDELSCROLLBARS}
        {$endif CLX_USED}
        // scbVert.SetScrollInfo(si, true); <trash> // LAW
      end;
    end
    {$IFDEF OLDELSCROLLBARS}
    else
      if FUseCustomScrollBars then
        scbVert.Visible := false;
    {$ENDIF}
  end;
  begin
    if ScrollBars in [ssHorizontal, ssBoth] then
    begin
      {$IFDEF OLDELSCROLLBARS}
      if FUseCustomScrollBars then
      begin
        if ScrollBars in [ssVertical, ssBoth] then
        begin
          if RightAlignedView then
            HScrollRect := Rect(FVertScrollBarStyles.Width, ClientHeight -
              FHorzScrollBarStyles.Width, ClientWidth - FVertScrollBarStyles.Width, FHorzScrollBarStyles.Width)
          else
            HScrollRect := Rect(0, ClientHeight - FHorzScrollBarStyles.Width, ClientWidth -
              FVertScrollBarStyles.Width, FHorzScrollBarStyles.Width);
        end
        else
          HScrollRect := Rect(0, ClientHeight - FHorzScrollBarStyles.Width, ClientWidth,
            FHorzScrollBarStyles.Width);
        with HScrollRect do
          scbHorz.SetBounds(Left, Top, Right, Bottom);
      end;
      {$ENDIF}

      if FElEditList.FParagraphs.Count > 0 then
        FMaxStr := FElEditList.FMaxStr;
      if {((FElEditList.FIdxMaxLen < FElEditList.ParagraphCount) and }
         (FtextPainter.TextSize(FMaxStr).cx >
           ((EditRect.Right - FRightMargin) -
            (EditRect.Left + FLeftMargin))
         )
         {or (FLeftChar > 0)} then
//      if ((FElEditList.FIdxMaxLen < FElEditList.Count) and (TextSize(FMaxStr).cx > ((EditRect.Right - FRightMargin) - (EditRect.Left + FLeftMargin))))
//         {or (FLeftChar > 0)} then
      begin
        FCharsMax := CharsFitRight((EditRect.Right - FRightMargin) - (EditRect.Left + FLeftMargin),
          FMaxStr, 0);

        si.cbSize := SizeOf(Si);
        si.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
        si.nMin := 0;
        si.nMax := FElEditList.FMaxLen;
        si.nPage := FCharsMax - 4;
        si.nPos := FLeftChar;

        {$IFDEF OLDELSCROLLBARS}
        if FUseCustomScrollBars then
        begin
          EnableScrollBar(Handle, SB_HORZ, ESB_DISABLE_BOTH);
          scbHorz.Visible := true;
          scbHorz.Enabled := true;
        end
        else
        {$ENDIF}
        begin
          {$IFDEF OLDELSCROLLBARS}
          scbHorz.Visible := false;
          {$ENDIF}
          EnableScrollBar(Handle, SB_HORZ, ESB_ENABLE_BOTH);
          SetScrollInfo(Handle, SB_HORZ, si, true);
        end;
        {$IFDEF OLDELSCROLLBARS}
        scbHorz.SetScrollInfo(si, true);
        {$ENDIF}
      end
      else
      begin
        LeftChar := 0;
        {$IFDEF OLDELSCROLLBARS}
        if FUseCustomScrollBars then
        begin
          scbHorz.Max := scbHorz.Min;
          scbHorz.Enabled := false;
          scbHorz.Visible := true;
        end
        else
        {$ENDIF}
        begin
          {$IFDEF OLDELSCROLLBARS}
          scbHorz.Visible := false;
          {$ENDIF}
          EnableScrollBar(Handle, SB_HORZ, ESB_DISABLE_BOTH);
          si.cbSize := sizeof(Si);
          si.fMask := SIF_DISABLENOSCROLL or SIF_RANGE;
          si.nMin := 0;
          si.nMax := 0;
          SetScrollInfo(Handle, SB_HORZ, si, true);
          {$IFDEF OLDELSCROLLBARS}
          scbHorz.SetScrollInfo(si, true);
          {$ENDIF}
        end;
      end;
    end
    {$IFDEF OLDELSCROLLBARS}
    else
      if FUseCustomScrollBars then
        scbHorz.Visible := false;
    {$ENDIF}
  end;
  if (Flat and ((not (Focused or FMouseOver)) or (FlatFocusedScrollBars and
    (not FUseCustomScrollBars) or (not Multiline)))) or IsThemeApplied then
    DrawFlatBorder;
end;

procedure TCustomElEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  FLineHeight := Abs(Font.Height) + 2;
  FLinesInRect := (FEditRect.Bottom - FTopMargin) div FLineHeight;
  if ((not FMultiline) and AutoSize) and
    (ComponentState * [csReading, csLoading, csDestroying] = []) then
    AdjustHeight;
  FElEditList.Reformat;
  SetScrollBarsInfo;
  if FHasCaret then
  begin
    DestroyCaret;
    MakeCaret;
    SetCaretPosition(CaretX, CaretY);
    ShowCaret(Handle);
  end;
end;

procedure TCustomElEdit.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateHeight;
  end;
end;

procedure TCustomElEdit.UpdateHeight;
begin
  if FAutoSize
    and (BorderStyle = bsSingle)
  then
    ControlStyle := ControlStyle + [csFixedHeight]
  else
    ControlStyle := ControlStyle - [csFixedHeight];
end;

procedure TCustomElEdit.CreateWnd;
begin
  {$IFNDEF OLDELSCROLLBARS}
  // fSBCtrl.Control := nil; <trash> // LAW
  {$ENDIF}

  inherited;

  {$IFNDEF OLDELSCROLLBARS}
(*  if fUseCustomScrollBars then
  begin
    fSBCtrl.Control := Self;
    if not fSBCtrl.Active then
    begin
      FUseCustomScrollBars := False;
      fSBCtrl.Control := nil;
    end;
  end;*) // <trash> // LAW
  {$ENDIF}

  FCharsInView := 0;
  SetScrollBarsInfo;
  UpdateHeight;
  if (not (csLoading in ComponentState)) and (not Multiline) and AutoSize then
    AdjustHeight;
  SetEditRect(ClientRect);

  if Flat or IsThemeApplied then
    DrawFlatBorder;
end;

{$IFNDEF OLDELSCROLLBARS}
(*{< ELSCROLLBAR}
procedure TCustomElEdit.DestroyWnd;
begin
  fSBCtrl.Control := nil;
  inherited;
end;

function TCustomElEdit.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_HORZ]);
end;

function TCustomElEdit.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_VERT]);
end;

procedure TCustomElEdit.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_HORZ].Assign(Value);
end;

procedure TCustomElEdit.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_VERT].Assign(Value);
end;
{> ELSCROLLBAR}*) // <trash> // LAW
{$ENDIF}

procedure TCustomElEdit.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
  Perform(CM_COLORCHANGED, 0, 0);
end;

procedure TCustomElEdit.WMGetText(var Message: TMessage);
var
  S: String;
begin
  if Message.wParam = 0 then
  begin
    Message.Result := 0;
  end
  else
  begin
    S := FElEditList.Text;
    Message.Result := Length(S);
    Move(PChar(S)^, PChar(Message.lParam)^, Message.Result + 1);
  end;
end;

procedure TCustomElEdit.WMGetTextLength(var Message: TMessage);
Var
  S:string;
begin
  Message.Result := 0; 
  if not (csDestroying in ComponentState) then begin
    S:=FElEditList.Text;
    Message.Result := Length(S);
  end
end;

procedure TCustomElEdit.SetLines(Value: TElFStrings);
begin
  FElEditList.Text := Value.Text;
end;

function TCustomElEdit.GetLines: TElFStrings;
begin
  Result := FElEditList
end;

procedure TCustomElEdit.SetAlignBottom(Value: boolean);
begin
  if (FAlignBottom <> Value) and (not FMultiLine) then
  begin
    FAlignBottom := Value;
    if FAlignBottom then
      FTopMargin := FEditRect.Bottom - FLineHeight - 2
    else
      FTopMargin := 1;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
    Invalidate;
  end
  else
  if Multiline then
  begin
    FAlignBottom := Value;
    FTopMargin := 1;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
    Invalidate;
  end;
end;

procedure TCustomElEdit.SetTopMargin(Value: Integer);
begin
  if (FTopMargin <> Value) and (not FAlignBottom) then
  begin
    FTopMargin := Value;
    Invalidate;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
  end;
end;

(*
procedure TCustomElEdit.UpdateFrame;
var R : TRect;
begin
  if not HandleAllocated then exit;
  R := Rect(0, 0, Width, Height);
  RedrawWindow(Handle, @R, 0, rdw_Invalidate or rdw_Frame or rdw_UpdateNow or rdw_NoChildren);
end;
*)

procedure TCustomElEdit.CMMouseEnter(var Msg : TMessage);  { private }
begin
  inherited;
  FMouseOver := true;
  DoMouseEnter;
  if (Flat and not Focused) and (not IsThemeApplied) then
    DrawFlatBorder;
end;  { CMMouseEnter }

procedure TCustomElEdit.CMMouseLeave(var Msg : TMessage);  { private }
begin
  FMouseOver := false;
  if (Msg.LParam = 0) or (Msg.LParam = Integer(Self)) then
  begin
    if (Flat and not Focused) and (not IsThemeApplied) then
      DrawFlatBorder;
    DoMouseLeave;
  end;
  inherited;
end;  { CMMouseLeave }

procedure TCustomElEdit.DoMouseEnter;
begin
  if assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TCustomElEdit.DoMouseLeave;
begin
  if assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

procedure TCustomElEdit.Loaded;
begin
  inherited;
  //???
  {$IFDEF OLDELSCROLLBARS}
  scbVert.Loaded;
  scbHorz.Loaded;
  {$ENDIF}
//  S := FText;
//  FText := '';
//  Text := S;
  SetScrollbarsInfo;
  if HandleAllocated then
  begin
    if (not Multiline) and AutoSize then
      AdjustHeight;
    SetEditRect(ClientRect);
  end;
  UpdateLinkedControl;
end;

procedure TCustomElEdit.SetFlatFocusedScrollBars(const Value: boolean);
begin
  if FFlatFocusedScrollBars <> Value then
  begin
    FFlatFocusedScrollBars := Value;
    if (Focused) and {$IFDEF OLDELSCROLLBARS}(not FUseCustomScrollBars) and{$ENDIF} Multiline then
      DrawFlatBorder;
  end;
end;

procedure TCustomElEdit.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      Invalidate;
  end;
end;

procedure TCustomElEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      Invalidate;
  end;
end;

procedure TCustomElEdit.EMSetRect(var Message: TMessage);
begin
  EditRect := (PRect(Message.lParam))^;
  Invalidate;
end;

procedure TCustomElEdit.EMSetRectNP(var Message: TMessage);
begin
  EditRect := (PRect(Message.lParam))^;
end;

procedure TCustomElEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if IsThemeApplied or UseDisabledColors then
    Invalidate;
end;

procedure TCustomElEdit.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  {$ifndef OLDELSCROLLBARS}
//  fSBCtrl.UseXPThemes := Value; <trash> // LAW
  {$endif}
  if HandleAllocated then
    RecreateWnd;
end;

(*
procedure TCustomElEdit.OnHScroll(Sender: TObject; ScrollCode: TElScrollCode;
                                var ScrollPos: Integer; var DoChange : boolean);
begin
  if (FLeftChar <> ScrollPos) then
  begin
    if (scbHorz.Page + ScrollPos) > (FElEditList.FMaxLen) then
      LeftChar := FElEditList.FMaxLen - scbHorz.Page + 1
    else
      LeftChar := ScrollPos;

    DoChange := true;
    DrawFlatBorder;
  end;
end;

procedure TCustomElEdit.OnVScroll(Sender: TObject; ScrollCode: TElScrollCode;
                                var ScrollPos: Integer; var DoChange : boolean);
begin
  if (FTopLine <> ScrollPos) then
  begin
    TopLine := ScrollPos;
    DoChange := true;
    DrawFlatBorder;
  end;
end;
*) // <trash> // LAW

{$IFDEF OLDELSCROLLBARS}
procedure TCustomElEdit.SetVertScrollBarStyles(newValue : TElScrollBarStyles);
begin
  FVertScrollBarStyles.Assign(newValue);
end;  { SetVertScrollBarStyles }

procedure TCustomElEdit.SetHorzScrollBarStyles(newValue : TElScrollBarStyles);
begin
  FHorzScrollBarStyles.Assign(newValue);
end;  { SetHorzScrollBarStyles }
{$ENDIF}

procedure TCustomElEdit.SBChanged(Sender: TObject);
begin
(*  if FUseCustomScrollBars then
  begin
    FScrollBars := ssNone;
    if (scbVert.Visible) and (scbHorz.Visible) then
      FScrollBars := ssBoth
    else
      if scbVert.Visible then
        FScrollBars := ssVertical
      else
        if scbVert.Visible then
          FScrollBars := ssHorizontal;
  end;*) // <trash> // LAW
  SetScrollBarsInfo;
  Invalidate;
end;

procedure TCustomElEdit.SetUseCustomScrollBars(newValue : Boolean);
{ Sets data member FUseCustomScrollBars to newValue. }
begin
  if (FUseCustomScrollBars <> newValue) then
  begin
    FUseCustomScrollBars := newValue;
    {< ELSCROLLBAR}
    {$IFNDEF OLDELSCROLLBARS}
(*    if fUseCustomScrollBars then
    begin
      fSBCtrl.Control := nil;
      fSBCtrl.Control := Self;
      if not fSBCtrl.Active then
      begin
        FUseCustomScrollBars := False;
        fSBCtrl.Control := nil;
        exit;
      end;
    end
    else
      fSBCtrl.Control := nil;*) // <trash> // LAW
    {$ENDIF}
    {> ELSCROLLBAR}
    if Multiline then
    begin
      RecreateWnd;
      SetScrollBarsInfo;
    end;
  end;  { if }
end;  { SetUseCustomScrollBars }

function TCustomElEdit.DeleteSelection(aFakeDelete: boolean): string;
var
  bP, bPO: integer;
  eP, ePO: integer;
  FX, FY: integer;
  i: integer;
  {$IFDEF ELPACK_UNICODE}
  S: WideString;
  {$ELSE}
  S: String;
  {$ENDIF}
  FTstr: TElFString;
  Allow:boolean;
begin
  Result := '';
  if FSelected then
  begin
    FTstr := SelText;
    FElEditList.CaretToParagraph(FSelFirstX, FSelFirstY, bP, bPO);
    FElEditList.CaretToParagraph(FSelLastX, FSelLastY, eP, ePO);
    if eP = bP then
    begin
      S := FElEditList.FParagraphs.Items[bP].Text;
      {$IFDEF ELPACK_UNICODE}
      WideDelete(S, bPO + 1, (ePO - bPO));
      {$ELSE}
      Delete(S, bPO + 1, (ePO - bPO));
      {$ENDIF}
      if not FRestrictOnTextChange then begin
        _TriggerTextChangedEvent(self, S, Allow);
      end
      else
        Allow:=true;

      if Allow then begin
        if aFakeDelete then
          Result := S
        else
          FElEditList.FParagraphs.Items[bP].Text := S;
      end;
    end
    else
    begin
      S := FElEditList.FParagraphs.Items[bP].Text;
      {$IFDEF ELPACK_UNICODE}
      WideDelete(S, bPO + 1, Length(S));
      {$ELSE}
      Delete(S, bPO + 1, Length(S));
      {$ENDIF}
      _TriggerTextChangedEvent(self, S, Allow);
      if Allow then begin
        if not aFakeDelete then
        begin
          FElEditList.FParagraphs.Items[bP].Text := S;
          for i := eP - 1 downto bP + 1 do
            FElEditList.FParagraphs.Delete(i);

          S := FElEditList.FParagraphs.Items[bP + 1].Text;
          {$IFDEF ELPACK_UNICODE}
          WideDelete(S, 1, ePO);
          {$ELSE}
          Delete(S, 1, ePO);
          {$ENDIF}
          FElEditList.FParagraphs.Items[bP].Text := FElEditList.FParagraphs.Items[bP].Text + S;
          FElEditList.FParagraphs.Delete(bP + 1);
        end
        else
          Result := FElEditList.FParagraphs.Items[bP].Text + S;
      end;
    end;
    if not aFakeDelete then
    begin
      FElEditList.ReformatParagraph(bP);
      FElEditList.ReCount(bP);
      FElEditList.CaretFromParagraph(bP, bPO, FX, FY);
      FUndo.AddAction(atDeleteSel, CaretXY, Point(FX, FY), FTStr);
      CaretY := FY;
      CaretX := FX;
      FSelStartY := CaretY;
      FSelStartX := CaretX;
      UnSelect;
    end;  
  end;
end;

procedure TCustomElEdit.UnSelect;
begin
  if FSelected and FDropSelection then
  begin
    FSelFirstX := FSelStartX;
    FSelFirstY := FSelStartY;
    FSelLastX := FSelStartX;
    FSelLastY := FSelStartY;
    FSelected := false;
    TriggerSelectionChangeEvent;
    RepaintText(EditRect);
  end;
end;

procedure TCustomElEdit.SetSelection(SelX, SelY: integer);
begin
//  if FSelected then
//  begin
    if SelY <= FSelStartY then
    begin
      FSelFirstY := SelY;
      FSelLastY := FSelStartY;
    end
    else
    begin
      FSelFirstY := FSelStartY;
      FSelLastY := SelY;
    end;
    if (SelY < FSelStartY) or ((SelX <= FSelStartX) and (SelY <= FSelStartY)) then
    begin
      FSelFirstX := SelX;
      FSelLastX := FSelStartX;
    end
    else
    begin
      FSelFirstX := FSelStartX;
      FSelLastX := SelX;
    end;
    FSelected := not ((FSelFirstY = FSelLastY) and (FSelFirstX = FSelLastX));
    if not FSelected then
     RepaintText(EditRect);
{  end
  else
  begin
    FSelStartX := SelX;
    FSelStartY := SelY;
    FSelFirstX := SelX;
    FSelFirstY := SelY;
    FSelLastX := SelX;
    FSelLastY := SelY;
    FSelected := true;
  end;}
end;

procedure TCustomElEdit.SetCharCase(Value: TElEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    if FCharCase <> eecNormal then
    begin
      {$IFNDEF ELPACK_UNICODE}
      if FCharCase = eecUppercase then
        Text := Uppercase(Text)
      else
        Text := Lowercase(Text);
      {$ELSE}
      if FCharCase = eecUppercase then
        Text := WideUppercase(Text)
      else
        Text := WideLowercase(Text);
      {$ENDIF}
    end;
  end;
end;

{$IFDEF OLDELSCROLLBARS}
procedure TCustomElEdit.WMSetCursor(var Message: TWMSetCursor);
var Control : TControl;
    P: TPoint;
begin
  if (FUseCustomScrollBars and Multiline) then
  with Message do
    if CursorWnd = Handle then
      if Smallint(HitTest) = HTCLIENT then
      begin
        GetCursorPos(P);
        Control := ControlAtPos(ScreenToClient(P), true{$IFDEF VCL_5_USED}, true{$ENDIF});
        if Control is TElScrollBar then
        begin
          Windows.SetCursor(Screen.Cursors[Control.Cursor]);
          exit;
        end;
      end;
  inherited;
end;
{$ENDIF}

{$IFDEF ELPACK_UNICODE}
procedure TCustomElEdit.CMHintShow(var Message: TMessage);
var T: WideChar;
  HintInfo : PHintInfo;
  l : integer;
  S : String;
  WS: WideString;
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);
  if Length(FHint) = 0 then
  begin
    if TControl(Self).Hint<>'' then begin
      Hint:=TControl(Self).Hint;
    end
    else begin
      HintInfo.hintStr := '';
      exit;
    end;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := GetShortHintW(FHint);
  end
  else
  begin
    S := FHint;
    WS := FHint;
  end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;

procedure TCustomElEdit.SetHint(Value: TElFString);
{
var S : String;
    i,
    l : integer;
    T : WideChar;
}
begin
{
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;

  Это зачем всё, ручное вот это переконверчивание?
  Hint у TControl в результате получается совершенно кривой.
  // Марков
}
  FHint := Value;
  inherited Hint := Value;
end;
{$ENDIF ELPACK_UNICODE}

procedure TCustomElEdit.SetBottomAlign;
begin
  FTopMargin := FEditRect.Top + (FEditRect.Bottom - FEditRect.Top - FLineHeight) div 2;
end;

procedure TCustomElEdit.Scroll(ScrollDir : TElEditScrollDir);
var Msg : TWMVScroll;
begin
  Msg.Msg := WM_VSCROLL;
  Msg.Pos := 0;
  Msg.ScrollBar := SB_VERT;
  Msg.Result := 0;
  case ScrollDir of
    esdLineUp:
      Msg.ScrollCode := SB_LINEUP;
    esdLineDown:
      Msg.ScrollCode := SB_LINEDOWN;
    esdPageUp:
      Msg.ScrollCode := SB_PAGEUP;
    esdPageDown:
      Msg.ScrollCode := SB_PAGEDOWN;
  end;
  WMVSCroll(Msg);
end;

procedure TCustomElEdit.SetMaxLevel(const Value: integer);
begin
  if Value >= 0 then
    FUndo.MaxUndo := Value;
end;

function TCustomElEdit.GetMaxLevel: integer;
begin
  Result := FUndo.MaxUndo;
end;

function TCustomElEdit.GetCanUndo: boolean;
begin
  Result := FUndo.CanUndo;
end;

function TCustomElEdit.CreateTextPainter: TElTextPainter;
begin
  Result := TElWinTextPainter.Create(Self);
end;


procedure TCustomElEdit.ScrollCaret;
begin
  (*
  if Multiline and ((TopLine > Self.FCaretPos.y) or (TopLine + FLinesInRect <= TopLine)) then
    TopLine := Max(0, FCaretPos.y - FLinesInRect shr 1);
  if Multiline then
    SetScrollBarsInfo;

  RepaintText;
  *)
//  SetSelStart(SelStart);
  SetCaretPosition(CaretX, CaretY);
end;

function TCustomElEdit.GetText: TElFString;
//var
//  {$IFDEF ELPACK_UNICODE}
//  S: WideString;
//  {$ELSE}
//  S: String;
//  {$ENDIF}
begin
  Result := FElEditList.Text;
//  {$IFDEF ELPACK_UNICODE}
//  Result := WideCopy(S, 1, Length(S){ - Length(ElFCRLF)});
//  {$ELSE}
//  Result := Copy(S, 1, Length(S){ - Length(ElFCRLF)});
//  {$ENDIF}
end;

function TCustomElEdit.ConvertToCRLF(Str : TElFString): TElFString;
var i, j : integer;
    ps, pd : PElFChar;
begin
  j := 0;
  for i := 1 to Length(Str) do
    if (Str[i] = #13) and (Str[i+1] <> #10) then
      inc(j);
  if (Length(Str) > 0) and (j > 0) then
  begin
    SetLength(Result, Length(Str) + j);
    ps := @Str[1];
    pd := @Result[1];
    while ps^ <> #0 do
    begin
      if ps^ = #13 then
      begin
        pd^ := ps^; inc(ps); inc(pd);
        if (ps^ <> #10) then
        begin
          pd^ := #10;
          inc(pd);
        end;
      end
      else
      begin
        pd^ := ps^; inc(ps); inc(pd);
      end;
    end;
  end
  else
    Result := Str;
end;

procedure TCustomElEdit.EMCanUndo(var Message: TMessage);
begin
  Message.Result := integer(CanUndo);
end;

procedure TCustomElEdit.EMUndo(var Message: TMessage);
begin
  Message.Result := Integer(CanUndo);
  Undo;
end;

procedure TCustomElEdit.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics: TTextMetric;
  I: Integer;
  Metrics: TTextMetric;
begin
  if not FMultiline then
  begin
    DC := GetDC(0);
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);

    if BorderStyle = bsSingle then
    begin
      if Ctl3D then
        I := GetSystemMetrics(SM_CYEDGE) * 4
      else
        I := GetSystemMetrics(SM_CYBORDER) * 6;
    end
    else
      I := 0;
    Height := Metrics.tmHeight + I;
    // FLinesInRect := (FEditRect.Bottom - FTopMargin) div FLineHeight;
//    if (FAlignBottom) then
//      SetBottomAlign;
  end;
end;

procedure TCustomElEdit.WMKeyDown(var Msg : TWMKeyDown); { private }
{$IFDEF ELPACK_UNICODE}
var KeyState: TKeyboardState;
    s : WideString;
    Len : Integer;
    FAdd: Integer;
    ACharCode : integer;
//    Allow:boolean;
    {.............................................................}
    function IsSpecialLanguage: Boolean;
    var Language: Integer;
    begin
      Language := (GetKeyboardLayout(0) and $FFFF);
      Result := (Language = $0439) {or  //Hindi
                (Language = $0404) or  //Chinese (Taiwan)
                (Language = $0804) or  //Chinese (PRC)
                (Language = $0c04) or  //Chinese (Hong Kong)
                (Language = $1004)};   //Chinese (Singapore)

    end;
    {.............................................................}
{$ENDIF}
begin
  {$IFDEF ELPACK_UNICODE}
  Len := 0;
  if IsWinNTUp {and IsSpecialLanguage } then
  begin
    // Manual translation of key codes to Unicode
    // if Msg.CharCode in [ord('A')..ord('Z'),ord('0')..ord('9'),187..192,220] then
   if not (Msg.CharCode in [8, 9, 13, 27]) then
    begin
      SetLength(s, 5);
      if GetKeyboardState(KeyState) and ((KeyState[VK_CONTROL] and $80)=0) then
      begin
        ACharCode := Msg.CharCode;
// Remark for input numpad digits.
//        if ACharCode in [VK_NUMPAD0 .. VK_NUMPAD9] then
//          ACharCode := Msg.CharCode - VK_NUMPAD0 + ord('0');
        Len := ToUnicode(ACharCode, Msg.KeyData, KeyState, PWideChar(s)^, 5, 0);
        if Len > 1 then
        begin
          SetLength(s, Len);
          if (FDeadChar <> #0) then
          begin
            if FCDead >= 1 then
            begin
              FKeys := s;
              FKeyDown := true;
              SendMessage(Handle, WM_CHAR, Word(FDeadChar), 0);
              FDeadChar := #0;
              FCDead := 0;
            end
            else
              Inc(FCDead);
          end
          else
          begin
            FKeys := s;
            FKeyDown := true;
          end;
        end
        else
        if (FDeadChar <> #0) and (Len = 1) then
        begin
          FAdd := -1;
          case FDeadChar of
            #96: FAdd := 0;  // GRAVE
            #180: FAdd := 1; // ACUTE
            '^': FAdd := 2;  // CIRCUMFLEX
            '~': FAdd := 3;  // TILDE
            #168: FAdd := 4; // UMLAUT
            #161: Fadd := 5; // CORONA
          end;
          if FAdd >= 0 then
            case s[1] of
              'A': FKeys := WideChar($00C0 + FAdd);
              'E': FKeys := WideChar($00C8 + FAdd);
              'I': FKeys := WideChar($00CC + FAdd);
              'O': FKeys := WideChar($00D2 + FAdd);
              'U': FKeys := WideChar($00D9 + FAdd);
              'a': FKeys := WideChar($00E0 + FAdd);
              'e': FKeys := WideChar($00E8 + FAdd);
              'i': FKeys := WideChar($00EC + FAdd);
              'o': FKeys := WideChar($00F2 + FAdd);
              'u': FKeys := WideChar($00F9 + FAdd);
              else
              begin
                if ((WideUpperCase(s[1]) = 'Y') and (FAdd = 1)) or ((s[1] = 'y') and
                  (FAdd = 4)) then
                begin
                  if FAdd = 1 then
                  begin
                    case s[1] of
                    'Y': FKeys := WideChar($00DD);
                    'y': FKeys := WideChar($00FD);
                    end;
                  end
                  else
                    FKeys := WideChar($00FF);
                end
                else
                if (FAdd = 5) and ((WideUpperCase(s[1]) = 'C') or (WideUpperCase(s[1]) = 'Z') or
                  (WideUpperCase(s[1]) = 'L')) then
                begin
                  case s[1] of
                  'C': FKeys := WideChar($010C);
                  'c': FKeys := WideChar($010D);
                  'Z': FKeys := WideChar($017D);
                  'z': FKeys := WideChar($017E);
                  'L': FKeys := WideChar($013D);
                  'l': FKeys := WideChar($013E);
                  end;
                end
                else
                begin
                  SetLength(s, 2);
                  s[2] := s[1];
                  s[1] := WideChar(FDeadChar);
                  FKeys := s;
                  FKeyDown := true;
                end;
              end;
            end;
          FDeadChar := #0;
        end
        else
        if Len > 0 then
        begin
          SetLength(s, Len);
          FKeys := s;
          FKeyDown := true;
        end;
      end;
    end;
  end;
  if Len <= 0 then
    inherited
  else
  begin
    inherited;
    Msg.CharCode := 0;
    Msg.Result   := 0;
  end;
  {$ELSE}
  inherited;
  {$ENDIF}
end;

procedure TCustomElEdit.KeyDown(var Key: Word; Shift: TShiftState); { private }
const
  SpecKeys = [VK_DELETE, VK_BACK, VK_RETURN, VK_TAB];
  ROSpecKeys = [];
  SRArrowKeys = [VK_LEFT, VK_RIGHT, VK_HOME, VK_END];
  MRArrowKeys = [VK_DOWN, VK_UP, VK_PRIOR, VK_NEXT];
  ArrowKeys = SRArrowKeys + MRArrowKeys;

function IsSpecKeys(AKey: word): boolean;
begin
  Result := false;
  if Key in SpecKeys then
    Result := true;
end;

function IsROSpecKeys(AKey: word): boolean;
begin
  Result := false;
  if Key in ROSpecKeys then
    Result := true;
end;

function IsSRArrowKeys(AKey: word): boolean;
begin
  Result := false;
  if Key in SRArrowKeys then
    Result := true;
end;

function IsMRArrowKeys(AKey: word): boolean;
begin
  Result := false;
  if Key in MRArrowKeys then
    Result := true;
end;

function IsArrowKeys(AKey: word): boolean;
begin
  Result := IsSRArrowKeys(Key) or IsMRArrowKeys(Key);
end;

var
  {$IFDEF ELPACK_UNICODE}
  S       : WideString;
  {$ELSE}
  S       : String;
  {$ENDIF}
  FX, FY: integer;
  P, PI: integer;
  FStr: TElFString;
  FPos: TPoint;
  FTStr: TElFString;
  Allow:boolean;

    procedure AcceptText;
    begin
      if (FMaxLength = 0) or (Length(Text) <= FMaxLength) then
      begin
        Modified := true;
        InvalidateRect(Handle, @FEditRect, HasCustomBackground);
        DoChange;
        Change;
        TriggerSelectionChangeEvent;
        SetScrollBarsInfo;
      end
      else
        InvalidateRect(Handle, @FEditRect, HasCustomBackground);
    end;

    procedure DoPressBack;
    Var
      Allow:boolean;
    begin
      if FSelected then
       DeleteSelection
      else
      begin
        FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
        FPos := CaretXY;
        if CaretX = 0 then
        begin
          if (PI = 0) and (P > 0) then
          begin
            S := FElEditList.FParagraphs.Items[P].Text;
            CaretY := CaretY - 1;
            CaretX := Length(FElEditList.FParagraphs.Items[P - 1].Strings[
              FElEditList.FParagraphs.Items[P - 1].Count - 1]);
            FUndo.AddAction(atBackSpace, FPos, CaretXY, ElFCRLF);
            FElEditList.FParagraphs.Items[P - 1].Text := FElEditList.FParagraphs.Items[P - 1].Text +
              S;
            FElEditList.FParagraphs.Delete(P);
            FElEditList.ReformatParagraph(P - 1);
            FElEditList.ReCount(P - 1);
          end
          else
          begin
            CaretX := CaretX - 1;
            {$IFDEF ELPACK_UNICODE}
            S := FElEditList.ParagraphStrings[CaretY];
            FTStr := WideCopy(S, CaretX, 1);
            WideDelete(S, CaretX, 1);
            FElEditList.ParagraphStrings[CaretY] := S;
            {$ELSE}
            S := FElEditList.ParagraphStrings[CaretY];
            FTStr := Copy(S, CaretX, 1);
            Delete(S, CaretX, 1);
            FElEditList.ParagraphStrings[CaretY] := S;
            {$ENDIF}
            if PI > 0 then
            begin
              FElEditList.CaretFromParagraph(P, PI - 1, FX, FY);
              CaretY := FY;
              CaretX := FX;
              FSelStartX := CaretX;
              FSelStartY := CaretY;
            end
            else
            if (P = 0) and (Length(S) = 0) then
              FElEditList.FParagraphs.Delete(0);
            FUndo.AddAction(atBackSpace, FPos, CaretXY, FTStr);
          end;
        end
        else
        begin
          {$IFDEF ELPACK_UNICODE}
          S := FElEditList.ParagraphStrings[CaretY];
          FTStr := WideCopy(S, CaretX, 1);
          WideDelete(S, CaretX, 1);
          {$ELSE}
          S := FElEditList.ParagraphStrings[CaretY];
          FTStr := Copy(S, CaretX, 1);
          Delete(S, CaretX, 1);
          {$ENDIF}
          _TriggerTextChangedEvent(self, S, Allow);
          if Allow then begin
            FElEditList.ParagraphStrings[CaretY] := S;
            FElEditList.CaretFromParagraph(P, PI - 1, FX, FY);
            CaretY := FY;
            CaretX := FX;
            FUndo.AddAction(atBackSpace, FPos, CaretXY, FTStr);
            if FElEditList.ParagraphCount <= FLinesInRect then
              TopLine := 0;
          end;
        end;
      end;
    end;

begin
  inherited KeyDown(Key, Shift);
  if FSelecting then
    exit;
  if (not FMultiline) and IsMRArrowKeys(Key) then
  begin
    case Key of
      VK_DOWN : Key := VK_RIGHT;
      VK_UP : Key := VK_LEFT;
      VK_PRIOR : Key := VK_HOME;
      VK_NEXT : Key := VK_END;
//this line blocked other listeners from getting the Return key press
//      VK_RETURN : Key := 0;
    end;
  end;

  if RightAlignedText then
  begin
    case Key of
    VK_LEFT: Key := VK_RIGHT;
    VK_RIGHT: Key := VK_LEFT;
    VK_HOME: Key := VK_END;
    VK_END: Key := VK_HOME;
    end;
  end;
  if ((Shift = [ssCtrl]) or (Shift = [ssShift])) and (Key = VK_RETURN) then
    Shift := [];
  if Shift = [] then
  begin
    if ReadOnly and (not (IsArrowKeys(Key))) then
      exit;
    if ((not ReadOnly) and (IsSpecKeys(Key))) or
      ((IsROSpecKeys(Key))) then
    begin
      case Key of
        VK_BACK :
          begin
            DoPressBack;
          end;
        VK_DELETE :
          begin
            if FSelected then
             DeleteSelection
            else
            begin
              FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
              if PI < Length(FElEditList.{Paragraph}Strings[P]) then
              begin
                S := FElEditList.Strings[P];
                {$IFDEF ELPACK_UNICODE}
                WideDelete(S, PI + 1, 1);
                {$ELSE}
                Delete(S, PI + 1, 1);
                {$ENDIF}
                _TriggerTextChangedEvent(self, S, Allow);
                if Allow then begin
                  {$IFDEF ELPACK_UNICODE}
                  FUndo.AddAction(atDelete, CaretXY, CaretXY, WideCopy({S}FElEditList.Strings[P], CaretX + 1, 1));
//                  WideDelete(S, PI + 1, 1);
                  {$ELSE}
                  FUndo.AddAction(atDelete, CaretXY, CaretXY, System.Copy({S}FElEditList.Strings[P], CaretX + 1, 1));
//                  Delete(S, PI + 1, 1);
                  {$ENDIF}
                  FElEditList.Strings[P] := S;
                  FElEditList.ReformatParagraph(P);
                  FElEditList.ReCount(P);
                end;
              end
              else
              begin
                if (P + 1) < FElEditList.FParagraphs.Count then
                begin
                  FUndo.AddAction(atDelete, CaretXY, CaretXY, ElFCRLF);
                  S := FElEditList.FParagraphs.Items[P + 1].Text;
                  _TriggerTextChangedEvent(self, S, Allow);
                  if Allow then begin
                    FElEditList.FParagraphs.Items[P].Text := FElEditList.FParagraphs.Items[P].Text +
                      S;
                    FElEditList.FParagraphs.Delete(P + 1);
                    FElEditList.ReformatParagraph(P);
                    FElEditList.ReCount(P);
                  end;
                end;
              end;
              FElEditList.CaretFromParagraph(P, PI, FX, FY);
              CaretY := FY;
              CaretX := FX;
              FSelStartX := CaretX;
              FSelStartY := CaretY;
            end;
            if FElEditList.ParagraphCount <= FLinesInRect then
              TopLine := 0;
          end
        (*
        VK_DELETE :
          begin
            if FSelected then
             DeleteSelection
            else
            begin
              FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
              if PI < Length(FElEditList.{Paragraph}Strings[P]) then
              begin
                {$IFDEF ELPACK_UNICODE}
                S := FElEditList.Strings[P];
                FUndo.AddAction(atDelete, CaretXY, CaretXY, WideCopy(S, CaretX + 1, 1));
                WideDelete(S, PI + 1, 1);
                {$ELSE}
                S := FElEditList.Strings[P];
                FUndo.AddAction(atDelete, CaretXY, CaretXY, System.Copy(S, CaretX + 1, 1));
                Delete(S, P + 1, 1);
                FElEditList.Strings[P] := S;
                {$ENDIF}
                FElEditList.Strings[P] := S;
                FElEditList.ReformatParagraph(P);
                FElEditList.ReCount(P);
              end
              else
              begin
                if (P + 1) < FElEditList.FParagraphs.Count then
                begin
                  FUndo.AddAction(atDelete, CaretXY, CaretXY, ElFCRLF);
                  S := FElEditList.FParagraphs.Items[P + 1].Text;
                  FElEditList.FParagraphs.Items[P].Text := FElEditList.FParagraphs.Items[P].Text + S;
                  FElEditList.FParagraphs.Delete(P + 1);
                  FElEditList.ReformatParagraph(P);
                  FElEditList.ReCount(P);
                end;
              end;
              FElEditList.CaretFromParagraph(P, PI, FX, FY);
              CaretY := FY;
              CaretX := FX;
              FSelStartX := CaretX;
              FSelStartY := CaretY;
            end;
            if FElEditList.ParagraphCount <= FLinesInRect then
              TopLine := 0;
          end
        *)
      else
        begin
          // now we can be sure we are getting in, only in multi line mode, without blocking others from
          // getting the return key press event
          if (FMultiline) and (Key = VK_RETURN) and (((Length(Text) < (FMaxLength - 1)) and
            (FMaxLength > 0)) or (FMaxLength = 0)) then
          begin
            if FSelected then
              DeleteSelection;
            FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
            FX := CaretX;
            FY := CaretY;
            if (PI > 0) then
            begin
              FElEditList.FParagraphs.Insert(P + 1, TElParagraph.Create);

              FStr := FElEditList.FParagraphs.Items[P].Text;
              {$IFDEF ELPACK_UNICODE}
              FStr := WideCopy(FStr, PI + 1, Length(FStr) - PI);
              {$ELSE}
              FStr := Copy(FStr, PI + 1, Length(FStr) - PI);
              {$ENDIF}

              S := FElEditList.FParagraphs.Items[P].Text;
              {$IFDEF ELPACK_UNICODE}
              WideDelete(S, PI + 1, Length(S) - PI);
              {$ELSE}
              Delete(S, PI + 1, Length(S) - PI);
              {$ENDIF}
              FElEditList.FParagraphs.Items[P].Text := S;

              FElEditList.ReformatParagraph(P);
              if CaretX = 0 then
              begin
                FElEditList.FParagraphs.Items[P + 1].Add('');
                FElEditList.FParagraphs.Insert(P + 2, TElParagraph.Create);
                FElEditList.FParagraphs.Items[P + 2].Add(FStr);
                FElEditList.ReformatParagraph(P + 2);
                FUndo.AddAction(atLineBreak, Point((P + 1), 1), Point(0, 0), '');
              end
              else
              begin
                FElEditList.FParagraphs.Items[P + 1].Add(FStr);
                FElEditList.ReformatParagraph(P + 1);
              end;


              FElEditList.ReCount(P);
              CaretY := CaretY + 1;
              CaretX := 0;
              FSelStartX := CaretX;
              FSelStartY := CaretY;
            end;
            if PI = 0 then
            begin
              if FElEditList.FParagraphs.Count = 0 then
                FElEditList.FParagraphs.Items[0].Add('');
              FElEditList.FParagraphs.Insert(P, TElParagraph.Create);
              FElEditList.FParagraphs.Items[P].Add('');
              FElEditList.ReCount(P);
              CaretY := CaretY + 1;
              FSelStartX := CaretX;
              FSelStartY := CaretY;
            end;
            FUndo.AddAction(atInsert, Point(FX, FY), CaretXY, '');
          end
          else
          if (Key = VK_TAB) and (((Length(Text) < FMaxLength) and (FMaxLength > 0)) or
            (FMaxLength = 0)) then
            begin
              if FSelected then
                DeleteSelection;
              FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
              S := FElEditList.ParagraphStrings[CaretY];
              {$IFDEF ELPACK_UNICODE}
              WideInsert(ElFTab, S, CaretX + 1);
              {$ELSE}
              Insert(ElFTab, S, CaretX + 1);
              {$ENDIF}
              FElEditList.ParagraphStrings[CaretY] := S;
              FElEditList.CaretFromParagraph(P, PI + 1, FX, FY);
{              FElEditList.CaretFromParagraph(P, PI, FX, FY);

              FX := CaretX;
              FY := CaretY;
}
              CaretY := FY;
              CaretX := FX;
              FSelStartX := CaretX;
              FSelStartY := CaretY;

              FUndo.AddAction(atInsert, Point(FX, FY), CaretXY, FTabString);
            end;
        end;
      end;
      AcceptText;
    end
    else
    if IsArrowKeys(Key) then
    begin
      case Key of
        VK_LEFT :
          begin
            UnSelect;
            CaretX := CaretX - 1;
            FSelStartX := FCaretX;
            FSelStartY := FCaretY;
            TriggerSelectionChangeEvent;
          end;
        VK_RIGHT :
          begin
            UnSelect;
            CaretX := CaretX + 1;
            FSelStartX := FCaretX;
            FSelStartY := FCaretY;
            TriggerSelectionChangeEvent;
          end;
        VK_HOME :
          begin
            UnSelect;
            CaretX := 0;
            FSelStartX := FCaretX;
            FSelStartY := FCaretY;
            TriggerSelectionChangeEvent;
          end;
        VK_END :
          begin
            UnSelect;
            FEnd := true;
            CaretX := Length(FElEditList.ParagraphStrings[CaretY]);
            FEnd := false;
            FSelStartY := FCaretY;
            FSelStartX := FCaretX;
            TriggerSelectionChangeEvent;
          end;
        VK_UP :
          begin
            begin
              UnSelect;
              CaretY := CaretY - 1;
              FSelStartX := FCaretX;
              FSelStartY := FCaretY;
              TriggerSelectionChangeEvent;
            end;
          end;
        VK_DOWN :
          begin
            begin
              UnSelect;
              CaretY := CaretY + 1;
              FSelStartX := FCaretX;
              FSelStartY := FCaretY;
              TriggerSelectionChangeEvent;
            end;
          end;
        VK_NEXT :
          begin
            begin
              UnSelect;
              CaretY := CaretY + FLinesInRect;
              FSelStartX := FCaretX;
              FSelStartY := FCaretY;
              TriggerSelectionChangeEvent;
            end;
          end;
         VK_PRIOR :
           begin
            begin
              UnSelect;
              CaretY := CaretY - FLinesInRect;
              FSelStartX := FCaretX;
              FSelStartY := FCaretY;
              TriggerSelectionChangeEvent;
            end;
           end;
      end; // case
    end;
  end
  else
  if (Shift = [ssShift]) or (Shift = [ssCtrl, ssShift]) then
  begin
    if Shift = [ssShift] then
    begin
      if Key = VK_BACK then
      begin
        DoPressBack;
        AcceptText;
        Key := 0;
      end;

      if (Key = VK_DELETE) then
      begin
        if CutToClipboard then
        begin
          DoChange;
//          if NotifyUserChangeOnly then
            Change;
        end;
        Key := 0;
      end;

      if (Key = VK_INSERT) then
      begin
        if PasteFromClipboard then
        begin
          DoChange;
//          if NotifyUserChangeOnly then
            Change;
        end;
        Key := 0;
      end;
    end;
    if IsArrowKeys(Key) and FArrowsSelect then
    begin
      case Key of
        VK_LEFT :
          begin
            if ssCtrl in Shift then
              CaretXY := GetPrevWord(Point(CaretX - 1, CaretY))
            else
              CaretX := CaretX - 1;
            SetSelection(CaretX, CaretY);
            RepaintText(FEditRect);
          end; // VK_LEFT
        VK_RIGHT :
          begin
            if ssCtrl in Shift then
              CaretXY := GetNextWord(CaretXY)
            else
              CaretX := CaretX + 1;
            SetSelection(CaretX, CaretY);
            RepaintText(FEditRect);
          end;
        VK_HOME :
          begin
            if ssCtrl in Shift then
            begin
              CaretY := 0;
              CaretX := 0;
            end
            else
              CaretX := 0;
            SetSelection(CaretX, CaretY);
            RepaintText(FEditRect);
          end;
        VK_END :
          begin
            if ssCtrl in Shift then
            begin
              CaretY := FElEditList.ParagraphCount;
              CaretX := Length(FElEditList.ParagraphStrings[FElEditList.ParagraphCount - 1]);
            end
            else
            begin
              FEnd := true;
              CaretX := Length(FElEditList.ParagraphStrings[CaretY]);
              FEnd := false;
            end;
            SetSelection(CaretX, CaretY);
            RepaintText(FEditRect);
          end;
        VK_UP :
          begin
            CaretY := CaretY - 1;
            SetSelection(CaretX, CaretY);
            RepaintText(FEditRect);
          end; // VK_UP + Shift
        VK_DOWN :
          begin
            CaretY := CaretY + 1;
            SetSelection(CaretX, CaretY);
            RepaintText(FEditRect);
          end;
        VK_NEXT :
          begin
            CaretY := CaretY + FLinesInRect;
            SetSelection(CaretX, CaretY);
            RepaintText(FEditRect);
          end;
        VK_PRIOR :
          begin
            CaretY := CaretY - FLinesInRect;
            SetSelection(CaretX, CaretY);
            RepaintText(FEditRect);
          end; // VK_PRIOR + Shift
      end; // case
    end;
    inherited;
  end
  else
  if Shift = [ssCtrl] then
  begin
    if (Char(Key) = 'C') or (Key = VK_INSERT) then
    begin
      CopyToClipboard;
      Key := 0;
    end;
    if (Char(Key) = 'X') then
    begin
      if CutToClipboard then
      begin
        DoChange;
//        if NotifyUserChangeOnly then
          Change;
      end;
      Key := 0;
    end;
    if (Char(Key) = 'Z') then
    begin
      if not ReadOnly then
      begin
        Undo;
        DoChange;
        if NotifyUserChangeOnly then
          Change;
      end;
      Key := 0;
    end;
    if (Char(Key) = 'V') then
    begin
      if PasteFromClipboard then
      begin
        DoChange;
//        if NotifyUserChangeOnly then
          Change;
      end;
      Key := 0;
    end;
    if (Char(Key) = 'A') then
    begin
      SelectAll;
      Key := 0;
    end;
    if (Key = VK_BACK) or (Key = VK_DELETE) then
    begin
      if FSelected then
        DeleteSelection;

      if (Key = VK_BACK) then
      begin
        FPos := GetPrevWord(Point(CaretX - 1, CaretY));
        SetSelection(FPos.X, FPos.Y);
        DeleteSelection;
        Change;
      end;

      if (Key = VK_DELETE) then
      begin
        FPos := GetNextWord(CaretXY);
        SetSelection(FPos.X, FPos.Y);
        DeleteSelection;
        Change;
      end;
    end;
    if (IsSRArrowKeys(Key)) then
    begin
      case Key of
        VK_LEFT :
          begin
            // ctrl+left
            FPos := GetPrevWord(Point(CaretX - 1, CaretY));
            if FSelected then
              UnSelect;
            CaretXY := FPos;
            FSelStartX := FCaretX;
            FSelStartY := FCaretY;
            TriggerSelectionChangeEvent;
            RepaintText(EditRect);
          end;
        VK_RIGHT :
          begin
            FPos := GetNextWord(CaretXY);
            if FSelected then
              UnSelect;
            CaretXY := FPos;
            FSelStartX := FCaretX;
            FSelStartY := FCaretY;
            TriggerSelectionChangeEvent;
            RepaintText(EditRect);
          end;
        VK_HOME :
          begin
            if FSelected then
              UnSelect;
            CaretX := 0;
            CaretY := 0;
            FSelStartX := FCaretX;
            FSelStartY := FCaretY;
          end;
        VK_END :
          begin
            if FSelected then
              UnSelect;
            FElEditList.CaretFromParagraph(FElEditList.FParagraphs.Count - 1,
                Length(FElEditList.FParagraphs.Items[FElEditList.FParagraphs.Count - 1].Text),
                FX, FY);
            CaretX := FX;
            CaretY := FY;
            FSelStartX := FCaretX;
            FSelStartY := FCaretY;
          end;
      end; // case
    end;
//   inherited;
  end
  else
    inherited;
end; { KeyDown }

procedure TCustomElEdit.SetEditRect(Value : TRect);
begin
  {$IFDEF OLDELSCROLLBARS}
  if scbVert <> nil then
  {$ENDIF}
  begin
(*    if scbVert.Visible then
    begin
      if RightAlignedView then
        {$IFDEF OLDELSCROLLBARS}
        Value.Left := scbVert.Width
        {$ELSE}
        //Value.Left := WidthRect(scbVert.ScrollBarRect)
        {$ENDIF}
      else
        {$IFDEF OLDELSCROLLBARS}
        Value.Right := Value.Right - scbVert.Width;
        {$ELSE}
        //Value.Right := Value.Right - WidthRect(scbVert.ScrollBarRect);
        {$ENDIF}
    end;*) // <trash> // LAW
  end;
  {$IFDEF OLDELSCROLLBARS}
  if scbHorz <> nil then
  {$ENDIF}
  begin
(*    if scbHorz.Visible then
      {$IFDEF OLDELSCROLLBARS}
      Value.Bottom := Value.Bottom - scbHorz.Height;
      {$ELSE}
      //Value.Bottom := Value.Bottom - HeightRect(scbHorz.ScrollBarRect);
      {$ENDIF}*) // <trash> // LAW
  end;
  DoSetEditRect(Value);
end;

procedure TCustomElEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  //if not HandleAllocated then
  //  SetEditRect(Rect(0, 0, AWidth, AHeight));
end;

procedure TCustomElEdit.CMCtl3DChanged(var Msg : TMessage);
begin
  inherited;
  if HandleAllocated then
    SetEditRect(ClientRect);
end; { CMCtl3DChanged }

function TCustomElEdit.ScrollBarStylesStored: Boolean;
begin
  Result := Multiline and UseCustomScrollBars;
end;

procedure TCustomElEdit.DefineProperties(Filer : TFiler);
begin
  inherited;
  Filer.DefineProperty('LinkControlPosition', ReadLinkCtlPos, nil, false);
  Filer.DefineProperty('RTLContent', ReadRTLContent, nil, false);
  Filer.DefineProperty('ChangeDisabledText', ReadChangeDisabledText, nil, false);
end;

procedure TCustomElEdit.ReadRTLContent(Reader : TReader);
begin
  RightAlignedText := Reader.ReadBoolean;
end;

procedure TCustomElEdit.SetRightAlignedView(Value: Boolean);
begin
  if FRightAlignedView <> Value then
  begin
    FRightAlignedView := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElEdit.SetRightAlignedText(Value: Boolean);
begin
  if FRightAlignedText <> Value then
  begin
    FRightAlignedText := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElEdit.SetFocusedSelectColor(newValue: TColor);
begin
  if (FFocusedSelectColor <> newValue) then
  begin
    FFocusedSelectColor := newValue;
    if (Focused or (not FHideSelection)) then Invalidate;
  end;  {if}
end;

procedure TCustomElEdit.SetFocusedSelectTextColor(newValue: TColor);
begin
  if (FFocusedSelectTextColor <> newValue) then
  begin
    FFocusedSelectTextColor := newValue;
    if (Focused or (not FHideSelection)) then Invalidate;
  end;  {if}
end;

procedure TCustomElEdit.SetHideSelectColor(newValue: TColor);
begin
  if (FHideSelectColor <> newValue) then
  begin
    FHideSelectColor := newValue;
    if not Focused and not FHideSelection then Invalidate;
  end;  {if}
end;

procedure TCustomElEdit.SetHideSelectTextColor(newValue: TColor);
begin
  if (FHideSelectTextColor <> newValue) then
  begin
    FHideSelectTextColor := newValue;
    if not Focused and not FHideSelection then Invalidate;
  end;  {if}
end;

procedure TCustomElEdit.DoChange;
begin
  // intentionally left blank
end;

procedure TCustomElEdit.SetHighlightAlphaLevel(Value: Integer);
begin
  if FHighlightAlphaLevel <> Value then
  begin
    FHighlightAlphaLevel := Value;
  end;
end;

(*
{$IFDEF ELPACK_USE_STYLEMANAGER}
procedure TCustomElEdit.SetStyleManager(Value: TElStyleManager);
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    scbVert.StyleManager := Value;
    scbHorz.StyleManager := Value;
  end;
end;

procedure TCustomElEdit.SetStyleName(const Value: string);
begin
  inherited;
  scbVert.Name := Value;
  scbHorz.Name := Value;
end;
{$ENDIF}
*)

{ TElEditStrings }

{$IFDEF ELPACK_UNICODE}
function TElEditStrings.Get(Index: integer): WideString;
{$ELSE}
function TElEditStrings.Get(Index: integer): String;
{$ENDIF}
begin
  Result := FParagraphs.Items[Index].Text;
end;

{$IFDEF ELPACK_UNICODE}
procedure TElEditStrings.Put(Index: Integer; const S: WideString);
{$ELSE}
procedure TElEditStrings.Put(Index: Integer; const S: String);
{$ENDIF}
begin
  Changing;
  FParagraphs.Items[Index].Text := S;
  Changed;
end;

procedure TElEditStrings.PutObject(Index: Integer; AObject: TObject);
begin
  ;
end;

function TElEditStrings.GetObject(Index: Integer): TObject;
begin
  Result := nil;
end;

function TElEditStrings.GetCount: integer;
begin
  Result := FParagraphs.Count;
end;


function TElEditStrings.CutString(var S: TElFString;
                   Len: integer; var RealStr: boolean): TElFString;
var
  CRLFPos : integer;
begin
  if Len = 0 then
  begin
    result := '';
    exit;
  end;
  if not FElEdit.RightAlignedText then
  begin
    {$IFDEF ELPACK_UNICODE}
    CRLFPos := WidePos(ElFCR, S);
    {$ELSE}
    CRLFPos := Pos(#13, S);
    {$ENDIF}

    if Len = Length(S) then Dec(Len);

    if (((CRLFPos = 0) or (CRLFPos > Len)) and (FElEdit.FWordWrap and FElEdit.Multiline) and
      (Length(S) > Len{ + 1})) then
    begin
      CRLFPos := Len;
      while CRLFPos > 1 do
        if (S[CRLFPos] = #32) or (S[CRLFPos] = #9) then
          break
        else
          dec(CRLFPos);
      if CRLFPos = 1 then
        CRLFPos := Len;
      // to do
      (*      {$IFDEF ELPACK_UNICODE}
      WideInsert(ElFCR, WideString(S), CRLFPos);
      {$ELSE}
      Insert(ElFCR, S, CRLFPos);
      {$ENDIF}*)
    end;

    {$IFDEF ELPACK_UNICODE}
    Result := WideCopy(S, CRLFPos + 1, Length(S));
    S := WideCopy(S, 1, CRLFPos);
    {$ELSE}
    Result := System.Copy(S, CRLFPos + 1, Length(S));
    S := System.Copy(S, 1, CRLFPos);
    {$ENDIF}
  end
  else
  begin
    {$IFDEF ELPACK_UNICODE}
    CRLFPos := WideLastPos(ElFCR, S);
    {$ELSE}
    CRLFPos := LastPos(#13, S);
    {$ENDIF}

    if (((CRLFPos = 0) or ((Length(S) - CRLFPos) - 1 > Len)) and FElEdit.FWordWrap and
      FElEdit.Multiline) then
    begin
      RealStr := false;
      CRLFPos := Length(S) - Len;
      // Cut string on boundary of word
      while CRLFPos < Length(S) do
        if S[CRLFPos] = #32 then
          break
        else
          inc(CRLFPos);
    end
    else
      RealStr := Boolean(RealStrings.IndexOf(IntToStr(Count - 1)) < 0);

    {$IFDEF ELPACK_UNICODE}
    Result:=WideCopy(S, 1, CRLFPos - 1);
    S:=WideCopy(S, CRLFPos + 1, Length(S));
    {$ELSE}
    Result:=System.Copy(S, CRLFPos - 1, Length(S));
    S:=System.Copy(S, 1, CRLFPos);
    {$ENDIF}
  end;
end;

procedure TElEditStrings.IndexToParagraph(index: integer; var Paragraph, ParaIndex: integer);
var
  FBegin, FMiddle, FEnd: integer;
begin
  Paragraph := 0;
  ParaIndex := 0;
  FBegin := 0;
  FEnd := FParagraphs.Count - 1;
  while FBegin <= FEnd do
  begin
    FMiddle := (FBegin + FEnd) shr 1;
    if Index > FParagraphs.Items[FMiddle].FPCount + (FParagraphs.Items[FMiddle].Count - 1) then
      FBegin := FMiddle + 1
    else
    begin
      FEnd := FMiddle - 1;
      if (Index >= FParagraphs.Items[FMiddle].FPCount) and
         (Index <= (FParagraphs.Items[FMiddle].FPCount + FParagraphs.Items[FMiddle].Count - 1)) then
      begin
        Paragraph := FMiddle;
        ParaIndex := Index - FParagraphs.Items[FMiddle].FPCount;
        FBegin := FEnd + 1;
      end;
    end;
  end;
end;

procedure TElEditStrings.CaretToParagraph(ACaretX, ACaretY: integer; var Paragraph, ParaOffs: integer);
var
  i, PI: integer;
begin
  IndexToParagraph(ACaretY, Paragraph, PI);
  ParaOffs := ACaretX;
  for i := 0 to PI - 1 do
    ParaOffs := ParaOffs + Length(FParagraphs.Items[Paragraph].Strings[i]);
  if ParaOffs > Length(Strings[Paragraph]) then
    ParaOffs := Length(Strings[Paragraph]);
  if ParaOffs < 0 then
    ParaOffs := 0;
end;

procedure TElEditStrings.CaretFromParagraph(Paragraph, ParaOffs: integer; var ACaretX,
  ACaretY: integer);
var
  FLen, i: integer;
begin
  ACaretY := FParagraphs.Items[Paragraph].FPCount;
  FLen := Length(FParagraphs.Items[Paragraph].Strings[0]);
  i := 1;
  while ((ParaOffs > FLen) and (FParagraphs.Items[Paragraph].Count > i)) do
  begin
    FLen := FLen + Length(FParagraphs.Items[Paragraph].Strings[i]);
    inc(i);
  end;
  ACaretY := ACaretY + (i - 1);
  ACaretX := abs(FLen - Length(FParagraphs.Items[Paragraph].Strings[i - 1]) - ParaOffs);
  if ACaretX < 0 then
    ACaretX := -1;
end;

function TElEditStrings.GetParaCount: integer;
begin
  if FParagraphs.Count > 0 then
    Result := FParagraphs.Items[FParagraphs.Count - 1].FPCount +
      FParagraphs.Items[FParagraphs.Count - 1].Count
  else
    Result := 0;
end;

function TElEditStrings.GetParaString(Index: integer): TElFString;
var
  P, Pi: integer;
begin
  IndexToParagraph(Index, P, Pi);
  if FParagraphs.Count > 0 then
    Result := FParagraphs.Items[P].Strings[Pi]
  else
    Result := '';
end;

procedure TElEditStrings.SetParaString(Index: integer; const Value: TElFString);
var
  P, Pi: integer;
begin
  IndexToParagraph(Index, P, Pi);
  if FParagraphs.Count = 0 then
  begin
    if Index > 0 then
      EElEditorError.CreateFmt('List index outbound (%d)', [Index])
    else
      FParagraphs.Items[P].Strings[Pi] := Value;
  end
  else
  begin
    FParagraphs.Items[P].Strings[Pi] := Value;
    ReformatParagraph(P);
    ReCount(P);
  end;
end;

procedure TElEditStrings.ReCount(Index: integer);
var
  i: integer;
begin
  for i := Index to FParagraphs.Count - 1 do
  begin
    if i = 0 then
      FParagraphs.Items[i].FPCount := 0
    else
      FParagraphs.Items[i].FPCount := FParagraphs.Items[i - 1].FPCount +
        FParagraphs.Items[i - 1].Count;
  end;
  FElEdit.SetScrollBarsInfo;
end;


procedure TElEditStrings.ReformatParagraph(Index: integer);
var
  T: TElFString;
  S: TElFString;
  StartPos, i : integer;
  FPara: TElParagraph;
  RStr: boolean;
  FChars: integer;
begin
//  S := Get(Index);
  FPara := FParagraphs.Items[Index];
  S := FPara.Text;
  FPara.Clear;
  FPara.Add('');
  if Index = FIdxMaxLen then
    FMaxLen := 0;
  if FElEdit.WordWrap and FElEdit.Multiline then
  begin
    i := 0;
    while (i <= FPara.Count - 1) do
    begin
      if FElEdit.RightAlignedText then
        StartPos := {$IFDEF ELPACK_UNICODE}WideLastPos(#13, S){$ELSE}LastPos(#13, S){$ENDIF}
      else
        StartPos := 0;
//      if (Length(S) > FChars) and ((FElEdit.EditRect.Right - FElEdit.RightMargin) > 0) then
      if (FElEdit.FtextPainter.TextSize(S).cx + 2) >= (FElEdit.EditRect.Right - FElEdit.RightMargin) then
      begin
        FChars := FElEdit.CharsFitRight((FElEdit.FEditRect.Right - FElEdit.FRightMargin) -
          (FElEdit.EditRect.Left + FElEdit.FLeftMargin), S, StartPos);
        T := CutString(S, FChars, RStr);
        FPara.Put(i, S);
        FPara.Insert(i + 1, T);
        if (FElEDit.RightAlignedView and (not RStr)) then
          RealStrings.Insert(i, IntToStr(i));
        S := T;
      end
      else
        if i = 0 then
          FPara.Put(i, S);
      Inc(i);
    end;
  end
  else
  begin
    i := Length(S);
    if FMaxLen < i then
    begin
      FMaxLen := i;
      FIdxMaxLen := Index;
      FMaxStr := S;
    end;
    FPara.Put(0, S);
  end;
end;

procedure TElEditStrings.Reformat;
var
  i: integer;

begin
  FMaxLen := 0;
  FIdxMaxLen := 0;
  FMaxStr := '';
  for i := 0 to FParagraphs.Count - 1 do
    ReformatParagraph(i);
  FElEdit.SetScrollBarsInfo;
end;

procedure TElEditStrings.Changed;
begin
  inherited;
  if Assigned(FOnChange) then
    FOnChange(Self);
  if FElEdit.HandleAllocated then
    InvalidateRect(FElEdit.Handle, @FElEdit.FEditRect, FElEdit.HasCustomBackground);
end;

{$IFDEF ELPACK_UNICODE}
function TElEditStrings.GetTextStr: WideString;
{$ELSE}
function TElEditStrings.GetTextStr: String;
{$ENDIF}
var
  I, L, Size, Count: Integer;
  {$IFDEF ELPACK_UNICODE}
  P: PWideChar;
  S: WideString;
  {$ELSE}
  P: PChar;
  S: String;
  {$ENDIF}
begin
  Count := GetCount;
  Size := 0;
  for I := 0 to Count - 1 do
    Inc(Size, Length(FParagraphs.Items[i].Text) + 2);
  Dec(Size, 2);
  SetLength(Result, Size);
  {$IFDEF ELPACK_UNICODE}
  P := PWideChar(Result);
  {$ELSE}
  P := PChar(Result);
  {$ENDIF}
  for I := 0 to Count - 1 do
  begin
    S := FParagraphs.Items[i].Text;
    L := Length(S);
    if L <> 0 then
    begin
      {$IFDEF ELPACK_UNICODE}
      WideMove(S[1], P^, L);
      {$ELSE}
      System.Move(S[1], P^, L);
      {$ENDIF}
      Inc(P, L);
    end;
    if (i < Count - 1) then
    begin
      P^ := #13;
      Inc(P);
      P^ := #10;
      Inc(P);
    end
  end;
end;

{$IFDEF ELPACK_UNICODE}
procedure TElEditStrings.SetTextStr(const Value: WideString);
var
  S: WideString;
  P, Start: PWideChar;
{$ELSE}
procedure TElEditStrings.SetTextStr(const Value: String);
var
  S: String;
  P, Start: PChar;
{$ENDIF}
  i: integer;
begin
  if (Text <> Value) or (FElEdit.FUpdate) then
  begin
    if FElEdit.Multiline then
    begin
      BeginUpdate;
      try
        Clear;
        FParagraphs.Clear;
        {$IFDEF ELPACK_UNICODE}
        P := PWideChar(Value);
        {$ELSE}
        P := PChar(Value);
        {$ENDIF}
        i := 0;
        if P <> nil then
          while P^ <> #0 do
          begin
            Start := P;
            while not ((P^ = #0) or (P^ = #13) or (P^ = #10)) do
              Inc(P);
            {$IFDEF ELPACK_UNICODE}
            SetWideString(S, Start, (P - Start));
            {$ELSE}
            SetString(S, Start, (P - Start));
            {$ENDIF}
            FParagraphs.Add(TElParagraph.Create);
            FParagraphs.Items[i].Text := S;
            if (P^ = #13) and ((P + 1)^ = #10) then
            begin
              inc(P, 2);
              if P^ = #0 then
                FParagraphs.Insert(i + 1, TElParagraph.Create);
            end
            else
              if (P^ <> #0) then
                inc(P, 1);
            inc(i);
          end;
      finally
        EndUpdate;
      end;
      Reformat;
      ReCount(0);
    end
    else
    begin
      BeginUpdate;
      try
        Clear;
        FParagraphs.Clear;
        FParagraphs.Items[0].Put(0, Value);
      finally
        EndUpdate;
      end;
    end;
  end;
  (*
  if FElEdit.HandleAllocated then
  begin
    FElEdit.CaretY := 0;
    FElEdit.CaretX := 0;
    FElEdit.LeftChar := 0;
    FElEdit.TopLine := 0;
  end
  else
  *)
  with FElEdit do
  begin
    FCaretY := 0;
    FCaretX := 0;
    FLeftChar := 0;
    FTopLine := 0;

    FSelFirstX := FSelStartX;
    FSelFirstY := FSelStartY;
    FSelLastX := FSelStartX;
    FSelLastY := FSelStartY;
    FSelected := false;
  end;
end;

function TElEditStrings.GetReText: TElFString;
var
  i: integer;
  ReStr: TElFString;
begin
  for i := Count - 1 downto 0 do
  begin
    ReStr := ReStr + ParagraphStrings[i];
    if ((RealStrings.IndexOf(IntToStr(i)) >= 0) and (i > 0)) then
      ReStr := ReStr + ElFCR;
  end;
  Result := ReStr;
end;

constructor TElEditStrings.Create;
begin
  inherited;
  // to do
  RealStrings := TStringList.Create;
  FParagraphs := TElParagraphList.Create;
end;

destructor TElEditStrings.Destroy;
begin
  RealStrings.Free;
  FParagraphs.Free;
  inherited;
end;

procedure TElEditStrings.Delete(Index: integer);
begin
  Changing;
  FParagraphs.Delete(Index);
  Changed;
end;

procedure TElEditStrings.Exchange(Index1, Index2: Integer);
begin
  Changing;
  FParagraphs.Exchange(Index1, Index2);
  Changed;
end;

procedure TElEditStrings.Clear;
begin
  Changing;
  inherited;
  FParagraphs.Clear;
  Changed;
end;

{$IFDEF ELPACK_UNICODE}
procedure TElEditStrings.AddStrings(Strings: TElWideStrings);
{$ELSE}
procedure TElEditStrings.AddStrings(Strings: TStrings);
{$ENDIF}
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Strings.Count - 1 do
      Add(Strings[I]);
  finally
    EndUpdate;
  end;
end;

{$IFDEF ELPACK_UNICODE}
function TElEditStrings.Add(const S: WideString): Integer;
{$ELSE}
function TElEditStrings.Add(const S: String): Integer;
{$ENDIF}
begin
  if FParagraphs.Count > 0 then
    Result := FParagraphs.Count
  else
    Result := 0;
  Insert(Result, S);
end;

{$IFDEF ELPACK_UNICODE}
function TElEditStrings.Find(const S: WideString; var Index: Integer): boolean;
{$ELSE}
function TElEditStrings.Find(const S: String; var Index: Integer): boolean;
{$ENDIF}
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    {$IFDEF ELPACK_UNICODE}
    C := WideCompareText(Get(i), S);
    {$ELSE}
    C := AnsiCompareText(Get(i), S);
    {$ENDIF}
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

{$IFDEF ELPACK_UNICODE}
procedure TElEditStrings.Insert(Index: Integer; const S : WideString);
{$ELSE}
procedure TElEditStrings.Insert(Index: Integer; const S : String);
{$ENDIF}
var
  {$IFDEF ELPACK_UNICODE}
  P, Start: PWideChar;
  S1: WideString;
  {$ELSE}
  P, Start: PChar;
  S1: String;
  {$ENDIF}
  i: integer;
begin
  Changing;
  if FElEdit.FMultiline then
  begin
    {$IFDEF ELPACK_UNICODE}
    if s = '' then
      P := PWideChar(TElFString(#13#10))
    else
      P := PWideChar(S);
    {$ELSE}
    if s = '' then
      P := PChar(#13#10)
    else
      P := PChar(S);
    {$ENDIF}
    i := Index;
    while (P^ <> #0) do
    begin
      Start := P;
      while not ((P^ = #13) or (P^ = #10) or (P^ = #0)) do
        Inc(P);
      {$IFDEF ELPACK_UNICODE}
      SetWideString(S1, Start, (P - Start));
      {$ELSE}
      SetString(S1, Start, (P - Start));
      {$ENDIF}
      FParagraphs.Insert(i, TElParagraph.Create);
      FParagraphs.Items[i].Text := S1;
      ReformatParagraph(i);
      if (P^ = #13) and ((P + 1)^ = #10) then
      begin
        inc(P, 2);
        if (P^ = #0) and (s <> '') then
          FParagraphs.Insert(i + 1, TElParagraph.Create);
      end
      else
        if (P^ <> #0) then inc(P, 1);
      inc(i);
    end;
    ReCount(Index);
  end;
  Changed;
end;

{$IFDEF ELPACK_UNICODE}
procedure TElEditStrings.InsertText(var ACaretX, ACaretY: integer; const S: WideString);
{$ELSE}
procedure TElEditStrings.InsertText(var ACaretX, ACaretY: integer; const S: String);
{$ENDIF}
var
  {$IFDEF ELPACK_UNICODE}
  P, Start: PWideChar;
  S1, D, S2: WideString;
  {$ELSE}
  P, Start: PChar;
  S1, D, S2: String;
  {$ENDIF}
  PA, PO: integer;
  CountBefore: integer;
  FFlag: boolean;
  S2Len: Integer;
begin
  Changing;
  S2Len := -1;
  FFlag := false;
  CountBefore := Count;
  CaretToParagraph(ACaretX, ACaretY, PA, PO);
  D := Get(PA);
  {$IFDEF ELPACK_UNICODE}
  P := PWideChar(S);
  {$ELSE}
  P := PChar(S);
  {$ENDIF}
  Start := P;
  while not ((P^ = #13) or (P^ = #10) or (P^ = #0)) do
    Inc(P);
  {$IFDEF ELPACK_UNICODE}
  SetWideString(S1, Start, (P - Start));
  {$ELSE}
  SetString(S1, Start, (P - Start));
  {$ENDIF}
  if (P^ = #13) and ((P + 1)^ = #10) then
  begin
    if (P + 2)^ <> #0 then
      inc(P, 2)
    else
      FFLag := true;
  end
  else
    if (P^ <> #0) then inc(P, 1);
  if (P^ <> #0) or (S = ElFCRLF) then
  begin
    {$IFDEF ELPACK_UNICODE}
    S2 := WideCopy(D, PO + 1, Length(D));
    WideDelete(D, PO + 1, Length(D));
    {$ELSE}
    S2 := System.Copy(D, PO + 1, Length(D));
    System.Delete(D, PO + 1, Length(D));
    {$ENDIF}
    S2Len := Length(S2);
    if not FFlag then
      S2 := P + S2;
    Insert(PA + 1, S2);
  end;
  {$IFDEF ELPACK_UNICODE}
  WideInsert(S1, D, PO + 1);
  {$ELSE}
  System.Insert(S1, D, PO + 1);
  {$ENDIF}
  FParagraphs.Items[PA].Text := D;
  ReformatParagraph(PA);
  ReCount(PA);
  if S2Len >= 0 then
  begin
    PA := PA + (Count - CountBefore);
    if CountBefore = 0 then
      Dec(PA);
    PO := Length(Strings[PA]) - S2Len;
  end
  else
    PO := PO + Length(S1);
  CaretFromParagraph(PA, PO, ACaretX, ACaretY);
  Changed;
end;


{ TElParagraph }

{$IFDEF ELPACK_UNICODE}
procedure TElParagraph.SetTextStr(const Value: WideString);
{$ELSE}
procedure TElParagraph.SetTextStr(const Value: String);
{$ENDIF}
begin
  inherited;
end;

{$IFDEF ELPACK_UNICODE}
function TElParagraph.Get(Index: Integer): WideString;
{$ELSE}
function TElParagraph.Get(Index: Integer): String;
{$ENDIF}
begin
  if ((Count = 0) and (Index = 0)) then
    Add('');
  Result := inherited Get(IndeX);
end;


{$IFDEF ELPACK_UNICODE}
procedure TElParagraph.Put(Index: Integer; const S: WideString);
{$ELSE}
procedure TElParagraph.Put(Index: Integer; const S: String);
{$ENDIF}
begin
  if ((Count = 0) and (Index = 0)) then
    Add('');
  inherited Put(Index, S);
end;

{$IFDEF ELPACK_UNICODE}
function TElParagraph.GetTextStr: WideString;
{$ELSE}
function TElParagraph.GetTextStr: String;
{$ENDIF}
var
  i: integer;
begin
//  Result := inherited GetTextStr;
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Get(i);
end;

{ TElParagraphList }

function TElParagraphList.Get(Index: Integer): TElParagraph;
begin
  if ((Count = 0) and (Index = 0)) then
    Add(TElParagraph.Create);
  Result := TElParagraph(inherited Get(Index));
end;

procedure TElParagraphList.Put(Index: Integer; const Value: TElParagraph);
begin
  inherited Put(Index, Value);
end;

procedure TElParagraphList.Delete(Index: integer);
begin
  Get(Index).Free;
  Remove(Get(Index));
end;

procedure TElParagraphList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Get(i).Free;
  inherited Clear;
end;

{ TElAction }

procedure TElAction.Assign(Source: TPersistent);
begin
  if (Source is TElAction) then
  begin
    FAction := TElAction(Source).FAction;
    FStartPos := TElAction(Source).FStartPos;
    FEndPos := TElAction(Source).FEndPos;
    FStr := TElAction(Source).FStr;
  end
  else
    inherited Assign(Source);
end;

{ TElActionList }

constructor TElActionList.Create;
begin
  FAStack := TElStack.Create;
  FLockCount := 0;
end;

destructor TElActionList.Destroy;
begin
  while not FAStack.Empty do
    TElAction(FAStack.Pop).Free;
  FAStack.Free;
end;

procedure TElActionList.AddAction(AAction: TElActionType; ASPos,
  AEPos: TPoint; AStr: TElFString);
var
  NewAction: TElAction;
begin
  if FLockCount = 0 then
  begin
    NewAction := TElAction.Create;
    try
      with NewAction do
      begin
        FAction := AAction;
        FStartPos := ASPos;
        FEndPos := AEPos;
        FStr := AStr;
      end;
      PushItem(NewAction);
    except
      NewAction.Free;
    end;
  end;
end;

function TElActionList.GetCanUndo: boolean;
begin
  Result := not FAStack.Empty;
end;

function TElActionList.PeekItem: TElAction;
begin
  Result := TElAction(FAStack.Last);
end;

function TElActionList.PopItem: TElAction;
begin
  Result := TElAction(FAStack.Pop);
end;

procedure TElActionList.PushItem(Item: TElAction);
begin
  if (FAStack.Count = FMaxUndo) and (FMaxUndo > 0) then
  begin
    TElAction(FAStack.Items[0]).Free;
    FAStack.ShiftUp(1);
  end;
  FAStack.Push(Item);
end;

procedure TElActionList.SetMaxUndo(const Value: integer);
begin
  if FMaxUndo <> Value then
  begin
    if FAStack.Count > Value then
      FAStack.ShiftUp(abs(FMaxUndo - Value));
    FMaxUndo := Value;
  end;
end;

procedure TElActionList.Lock;
begin
  inc(FLockCount);
end;

procedure TElActionList.UnLock;
begin
  if FLockCount > 0 then
    dec(FLockCount);
end;

{$IFDEF ELPACK_UNICODE}
procedure TCustomElEdit.WMDeadChar(var Msg : TWMDeadChar);
begin
  FDeadChar := Char(Msg.CharCode);
  Msg.Result := 0;
//  MessageBox(0, PChar('Dead char is '+IntToStr(Msg.CharCode)), 'd', 0);
end;
{$ENDIF}

procedure TCustomElEdit.SetLinkedControl(Value: TControl);
begin
  if (FLinkedControl <> Value) and (FlinkedControl <> Self) then
  begin
    {$IFDEF VCL_5_USED}
    if FLinkedControl <> nil then
      if not (csDestroying in FLinkedControl.ComponentState) then
        FLinkedControl.RemoveFreeNotification(Self);
    {$ENDIF}
    FLinkedControl := Value;
    if FLinkedControl <> nil then
      FLinkedControl.FreeNotification(Self);
    UpdateLinkedControl;
  end;
end;

procedure TCustomElEdit.UpdateLinkedControl;
begin
  if FLinkedControl <> nil then
  begin
    case FLinkedControlPosition of
      lcpLeftTop:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top,
          FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftBottom:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top +
          Height - FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftCenter:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top +
          (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopLeft:
        FLinkedControl.SetBounds(Left, Top - FLinkedControl.Height - FLinkedControlSpacing,
          FLinkedControl.Width, FLinkedControl.Height);
      lcpTopRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top - FLinkedControl.Height -
          FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top -
          FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightTop:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top, FLinkedControl.Width,
          FLinkedControl.Height);
      lcpRightBottom:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top + Height -
          FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightCenter:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top +
          (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomLeft:
        FLinkedControl.SetBounds(Left, Top + Height + FLinkedControlSpacing, FLinkedControl.Width,
          FLinkedControl.Height);
      lcpBottomRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top + Height +
          FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top + Height +
          FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
    end;
  end;
end;

procedure TCustomElEdit.SetLinkedControlPosition(Value: TElLinkCtlPos);
begin
  if FLinkedControlPosition <> Value then
  begin
    FLinkedControlPosition := Value;
    UpdateLinkedControl;
  end;
end;

procedure TCustomElEdit.SetLinkedControlSpacing(Value: Integer);
begin
  if FLinkedControlSpacing <> Value then
  begin
    FLinkedControlSpacing := Value;
    UpdateLinkedControl;
  end;
end;

function TCustomElEdit.AdjustRectSB(const ARect : TRect): TRect;
begin
  Result := ARect;
  {$IFDEF OLDELSCROLLBARS}
  if (FUseCustomScrollBars and Multiline) then
  begin
    if ScrollBars in [ssHorizontal, ssBoth] then
      Result.Bottom := min(ARect.Bottom, ClientHeight - HorzScrollBarStyles.Width);
    if ScrollBars in [ssVertical, ssBoth] then
    begin
      if RightAlignedView then
        Result.Left := Max(ARect.Left, VertScrollBarStyles.Width)
      else
        Result.Right := min(ARect.Right, ClientWidth - VertScrollBarStyles.Width);
    end;
  end;
  {$ENDIF}
end;

procedure TCustomElEdit.SetUseDisabledColors(Value: Boolean);
begin
  if FUseDisabledColors <> Value then
  begin
    FUseDisabledColors := Value;
    if not Enabled then
      RepaintText(EditRect);
  end;
end;

procedure TCustomElEdit.SetDisabledColor(Value: TColor);
begin
  if FDisabledColor <> Value then
  begin
    FDisabledColor := Value;
    if (not Enabled) and UseDisabledColors then
      RepaintText(EditRect);
  end;
end;

procedure TCustomElEdit.SetDisabledFontColor(Value: TColor);
begin
  if FDisabledFontColor <> Value then
  begin
    FDisabledFontColor := Value;
    if (not Enabled) and UseDisabledColors then
      RepaintText(EditRect);
  end;
end;

procedure TCustomElEdit.ReadChangeDisabledText(Reader : TReader);
begin
  UseDisabledColors := Reader.ReadBoolean;
end;

function TCustomElEdit.HasCustomBackground: Boolean;
begin
  result := false;
  if {$ifdef ELPACK_USE_IMAGEFORM}((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
    (not (csDesigning in FImgForm.GetRealControl.ComponentState))) or{$endif}
      FTransparent or IsThemeApplied then
    Result := true;
end;

procedure TCustomElEdit.ReadLinkCtlPos(Reader : TReader);
var S : String;
begin
  S := Reader.ReadIdent;
  {$ifdef VCL_5_USED}
  TypInfo.SetEnumProp(Self, 'LinkedControlPosition', S);
  {$endif}
end;

procedure TCustomElEdit.TriggerKeyPressEx(var Key : TElFString);
begin
  if assigned(FOnKeyPressEx) then
    FOnKeyPressEx(Self, Key);
end;


{$ifdef VCL_5_USED}
procedure TCustomElEdit.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  PopupMenu: TPopupMenu;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  Pt := SmallPointToPoint(Message.Pos);
  if Pt.X < 0 then
    Temp := Pt
  else
  begin
    Temp := ScreenToClient(Pt);
    if not PtInRect(ClientRect, Temp) then
    begin
      inherited;
      Exit;
    end;
  end;

  Handled := False;
  DoContextPopup(Temp, Handled);
  Message.Result := Ord(Handled);
  if Handled then Exit;

  PopupMenu := GetPopupMenu;
  if Assigned(PopupMenu) then
  begin
    if PopupMenu.AutoPopup then
    begin
      SendCancelMode(nil);
      PopupMenu.PopupComponent := Self;
      if Pt.X < 0 then
        Pt := ClientToScreen(Point(0,0));
      PopupMenu.Popup(Pt.X, Pt.Y);
      Message.Result := 1;
    end;
  end
  else
    if UseSystemMenu then
    begin
      //Pt := ClientToScreen(Pt);
      ElCallSysMenu(ElEditMenu, Handle, Pt.X, Pt.Y, Self);
      ReleaseCapture;
    end;
end;

{$endif}

procedure TCustomElEdit.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;

procedure TCustomElEdit.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;

procedure TCustomElEdit.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;

procedure TCustomElEdit.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;

procedure TCustomElEdit.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;


procedure TElActionList.Clear;
begin
  FAStack.Clear;
end;

{ TCustomElMemo }

constructor TCustomElMemo.Create(AOwner : TComponent);
begin
  inherited;
  WantReturns := true;
  Multiline := true;
  Height := 89;
  Width := 185;
end;

{ TElTextPainter }

function TElTextPainter.CharsFitLeft(AWidth: integer; FText: TElFString; StartPos: integer): integer;
var
  FText1, FText2 : TElFString;
  i, j, k : integer;
  TS : TSize;
  FSum, FTabs: integer;

begin
  Result := -1;
  if FEditor <> nil then
  begin
    {$ifdef ELPACK_UNICODE}
    FText1 := WideCopy(FText, 1, StartPos);
    {$else}
    FText1 := Copy(FText, 1, StartPos);
    {$endif}
    k := Length(FText1);
    SetLength(FText2, k);

    for i := 0 to k - 1 do
      FText2[i + 1] := FText1[k - i];

    FText1 := FText2;

    j := Length(FText1) - 1;
    if j = -1 then
    begin
      result := 0;
      exit;
    end;

    if FEditor.HandleAllocated then
      TS := TextSize(FEditor.FTabString);

    j := AWidth;

    // here we can ignore margins
    if FEditor.HandleAllocated then
      GetTextExtentExPoint(FEditor.Canvas, PElFChar(FText1), Length(FText1), j, i, nil, TS);

    FSum := 0;
    FTabs := 0;
    j := 1;
    while FSum < i do
    begin
      if FText2[j] = ElFTab then
      begin
        inc(FSum, FEditor.FTabSpaces);
        inc(FTabs, FEditor.FTabSpaces - 1)
      end
      else
        inc(FSum);
      inc(j);
    end;

    Result := i - FTabs;
  end;
end;

function TElTextPainter.CharsFitRight(AWidth: integer; FText: TElFString; StartPos: integer): integer;
var
  i, j   : integer;
  //tc, tv : integer;
  TS     : TSize;
  FText1 : TElFString;
  FSum, FTabs: integer;

begin
  Result := -1;
  if FEditor <> nil then
  begin
    {$IFDEF ELPACK_UNICODE}
    FText := WideCopy(FText, StartPos + 1, Length(FText));
    {$ELSE}
    FText := Copy(FText, StartPos + 1, Length(FText));
    {$ENDIF}

    FText1 := FText;
    j := Length(FText1) - 1;
    if (j = -1) or (AWidth <= 0) then
    begin
      result := 0;
      exit;
    end;

    j := AWidth;     i := 0;
    // here we can ignore margins
    if FEditor.HandleAllocated then
      GetTextExtentExPoint(FEditor.Canvas, PElFChar(FText1), Length(FText1), j, i, nil, TS);

    FSum := 0;
    FTabs := 0;
    j := 1;
    while FSum < i do
    begin
      if FText[j] = ElFTab then
      begin
        inc(FSum, FEditor.FTabSpaces);
        inc(FTabs, FEditor.FTabSpaces - 1)
      end
      else
        inc(FSum);
      inc(j);
    end;

    Result := i - FTabs;
  end;
end;

constructor TElTextPainter.Create(AEditor: TCustomElEdit);
begin
 inherited Create;
 FEditor := AEditor;
 FFont := FEditor.Font;
end;

procedure TElTextPainter.DrawTabbedText(const ACanvas: TCanvas; X, Y: Integer; ARect: TRect; AText: TElFString; var Size: TSize);
begin
  ExtTextOut(ACanvas, X, Y, ETO_CLIPPED, @(ARect), AText, Length(AText));
  Size := TextSize(Atext);
end;

procedure TElTextPainter.SetBkColor(const ABkColor: TColor);
begin
  if FBkColor <> ABkColor then
  begin
    FBkColor := ABkColor;
    FEditor.Invalidate;
  end;
end;

procedure TElTextPainter.SetColor(const AColor: TColor);
begin
  if FColor <> AColor then
  begin
    FColor := AColor;
    FEditor.Canvas.Pen.Color := FColor;
    FEditor.Invalidate;
  end;
end;

{ TElCLXTextPainter }



{ TElWinTextPainter }
function TElWinTextPainter.ExtTextOut(const ACanvas: TCanvas; X, Y, Options: Integer; Rect: PRect; Str: TElFString; Count: Integer): Boolean;
begin
  {$ifdef ELPACK_UNICODE}
  Result := ExtTextOutW(ACanvas.Handle, X, Y, Options, Rect, PWideChar(Str), Count, nil);
  {$else}
  Result := ExtTextOutA(ACanvas.Handle, X, Y, Options, Rect, PChar(Str), Count, nil);
  {$endif}
end;

function TElWinTextPainter.GetTextExtentExPoint(const ACanvas: TCanvas; lpszStr: PElFChar;
  cchString, nMaxExtent: integer; var lpnFit: integer; alpDX: PInteger;
  var lpSize: TSize): Boolean;
begin
  Result := ElGetTextExtentExPoint(ACanvas.Handle, lpszStr, cchString, nMaxExtent, lpnFit, alpDX, lpSize);
end;

function TElWinTextPainter.TextSize(ALine: TElFString): TSize;
begin
  Result := TSize(Point(0, 0));
  FEditor.Canvas.Font.Assign(Font);
  if FEditor.HandleAllocated then
    {$IFDEF ELPACK_UNICODE}
    GetTextExtentPoint32W(FEditor.Canvas.Handle, PWideChar(ALine), Length(ALine), Result);
    {$ELSE}
    GetTextExtentPoint32(FEditor.Canvas.Handle, PChar(ALine), Length(ALine), Result);
    {$ENDIF}
end;

{$hints off}
procedure TCustomElEdit._TriggerTextChangedEvent(Sender: TObject;
{$IFDEF ELPACK_UNICODE}Var aText:WideString;{$ELSE}Var aText:String;{$ENDIF}Var Allow:boolean);
Var
  S: Il3Cstring;
begin
  Allow := true;
  S := l3CStr(aText);
  TriggerTextChangedEvent(Sender, S, Allow);
  if Allow then
   aText := l3Str(S);
end;

procedure TCustomElEdit.TriggerTextChangedEvent(Sender    : TObject;
                                                Var aText : Il3CString;
                                                Var Allow : boolean);
begin
  Allow:=true;
end;

procedure TCustomElEdit.SetNoCaret(Value:boolean);
begin
  if Value<>FNoCaret then begin
    FNoCaret:=Value;
    if Value then begin
      MakeCaret;
    end
    else begin
      if FHasCaret then
        DestroyCaret;
    end;
  end;
end;

function TCustomElEdit.AllowEnhance(const aEnhanceType: TElEnhanceType): Boolean;
begin
  Result := AllowEnhance(aEnhanceType, []);
end;

function TCustomElEdit.AllowEnhance(const aEnhanceType: TElEnhanceType;
                                    const aData: array of const): Boolean; 
begin
  Result := True;
end;

function TCustomElEdit.IsEmptyHintColorStore : Boolean;
begin
 Result := FEmptyHintColor <> cEmptyHintColor;
end;

procedure TCustomElEdit.SetTextWithCaret(const S: string);
begin
 Text := S;
 CaretX := Length(S);
 CaretY := 0;
 SelLength := 0;
 SelStart := CaretX;
end;

function TCustomElEdit.IsTextEmpty:boolean;
Var
  fl: integer;
  LinesToDraw: integer;
begin
  Result := true;
  LinesToDraw := (FTopLine + FLinesInRect) - 1;
  if (FTopLine + FLinesInRect) > FElEditList.ParagraphCount - 1 then
    LinesToDraw := FElEditList.ParagraphCount - 1;

  for fl := FTopLine to LinesToDraw do
  begin
    if FElEditList.ParagraphStrings[fl] <> '' then
    begin
      Result := false;
      break;
    end;
  end;
end;

procedure TCustomElEdit.TriggerCaretXChangedEvent(Var Value:integer; Var Allow:boolean);
begin
  Allow:=true;
end;

procedure TCustomElEdit.ClearUndoRedoLists;
begin
  FUndo.Clear;
  fRedo.Clear;
end;

begin
  ElWhatIsMenu := 4;
  if IsWinNTUp then
  begin
    ElEditMenu := 1;
    ElSysWindowMenu := 16;
    ElMDIWindowMenu := 32;
    ID_SELECTALL := 177;
  end
  else
  begin
    ElEditMenu := 3;
    ElSysWindowMenu := 1;
    ElMDIWindowMenu := 2;
    ID_SELECTALL := 1025;
  end;
end.
