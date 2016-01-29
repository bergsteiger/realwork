{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcmemo;

interface
{$I dc.inc}

uses
   {$IFDEF D6}
   rtlconsts,
   {$ENDIF}

     {$IFNDEF CLX}
     Messages, Windows, Forms, Dialogs, CommCtrl, Graphics, controls, StdCtrls, clipbrd, RichEdit, menus,
     {$ELSE}
     Types, Qt, QForms, Qdialogs, QGraphics, QControls, Qstdctrls, QExtCtrls, QClipbrd, QTypes, QMenus,
     {$ENDIF}
     dcsystem, consts,  Classes, SysUtils, dcdreamlib, dcedit, dccommon, typinfo, dccontrols,
     dcstring, dcconsts, dcExport, fontman
     {$IFDEF DCMBCS}
     ,imm
     {$ENDIF}
     ;

{-------------------------------------------------------------}

Const
   cOverwrite : array[boolean] of string =(SStatInsert, SStatOverwrite);
   cModified : array[boolean] of string = ('', SStatModified);

  sAll    = -1;
  sNormal = 0;
  sCtrlK  = 1;
  sCtrlQ  = 2;
  sAltJ   = 3;
  sCtrlX  = 4;
  sCtrlO  = 5;
  sAltBrief = 6;
  sAltBriefCol = 7;
  sBriefHomeEnd = 8;
  WHEELDELTA = 120;

{$IFNDEF D3}
const
  SPI_GETWHEELSCROLLLINES = 104;
  SPI_SETWHEELSCROLLLINES = 105;

  WM_MOUSEWHEEL = $020A;
{$ENDIF}
  crMemoHandPt = 104;
type
  TDCGraphicsFormat = (gfBitmap, gfMetafile, gfEnhancedMetafile);

  TCustomDCMemo = class;

  TMemoFont = class(TFont)
  private
    FOwner : TPersistent;
  public
    constructor Create(AOwner : TPersistent);
    property Owner: TPersistent read FOwner;
  end;

{-------------------------------------------------------------}

  TMemoOption = (moDrawMargin, moDrawGutter, moThumbTracking, moDblClickLine, moColorSyntax, moLineNumbers,
    moOverwriteCaret, moLeftIndent, moDisableDrag, moSelectOnlyText, moLineNumbersOnGutter, moNotePadCursorStyle,
    moBreakWordAtMargin, moDrawSpecialSymbols, moDisableRightClickMove, moColoredLineStyle, moDisableInvertedSel,
    moHideInvisibleLines, moDrawLineBookmarks, moShowScrollHint, moUseReadOnlyColor, moExtendedSel, moCenterOnBookmark,
    moTripleClick, moLimitLineNumbers);


  TClipboardType = (cbNormal, cbRtf);

  TDCPrintOption=(poWrapLines, poInColor, poPrintSel, poPrintHeader,
    poLineNumbers, poPrintSyntax, poShowProgress);

  TDCPrintOptions = set of TDCPrintOption;
  TMemoOptions = set of TMemoOption;

  TEditState=(esNone, esBlockSel, esBlockDrag, esMarkWord);

  TUpdateMemoColors=(mcNone, mcText, mcSelection, mcSearchMatch);

  TTextStyle    = class(TDCNamedItem)
  private
    FColor            : TColor;
    FFont             : TMemoFont;
    FBrush            : TBrush;
    FUseMemoFont      : boolean;
    FUseMemoColor     : boolean;
    FUpperCase        : boolean;
    FUpdateMemoColors : TUpdateMemoColors;

    procedure SetUpdateMemoColors(V : TUpdateMemoColors);
    procedure OnFontChange(Sender : TObject);
    procedure AssignMemoColor;
    procedure AssignMemoFont;
    procedure AssignFontNameAndSize;
    function  IsColorStored : boolean;
    function  IsFontStored : boolean;
    procedure SetUseMemoFont(V : boolean);
    procedure SetUseMemoColor(V : boolean);
    procedure SetUpperCase(Value : boolean);
    procedure SetColor(V : TColor);
    procedure SetFont(V : TMemoFont);
    procedure DoParserChanged(NeedUpdate : boolean);
  protected
    procedure DoUpdateMemoColors;
  public
    function Memo : TCustomDCMemo;
    constructor Create(AOwner : TCollection); override;
    destructor Destroy; override;
  published
    property Name;
    property Color : TColor read FColor write SetColor stored IsColorStored;
    property Font : TMemoFont read FFont write SetFont stored IsFontStored;
    property UpdateMemoColors : TUpdateMemoColors read FUpdateMemoColors write SetUpdateMemoColors;
    property UseMemoColor : boolean read FUseMemoColor write SetUseMemoColor;
    property UseMemoFont : boolean read FUseMemoFont write SetUseMemoFont;
    property UpperCase : boolean read FUpperCase write SetUpperCase default false;
  end;

  TTextStyles=class(TDCNamedItems)
  private
    FUpdateCount   : integer;
    FParserChanged : boolean;
    function GetItem(index : integer) : TTextStyle;
  protected
    InColorUpdate : boolean;
  public
    procedure Assign(Source : TPersistent); override;
    procedure SetDefaultStyles;
    procedure UpdateParams;
    function GetMaxCharWidth : integer;
    function GetMaxCharHeight : integer;
    function AddStyle(const StyleName : string; AColor, ABackColor : TColor) : TTextStyle;
    function AddStyleEx(const StyleName : string; AColor, ABackColor : TColor; AStyle : TFontStyles;
      AUpdateType : TUpdateMemoColors; AUseMemoFont, AUseMemoColor : boolean) : TTextStyle;
    procedure LoadColorStyles;
    procedure SaveColorStyles;
    procedure BeginParserUpdate;
    procedure EndParserUpdate;
    property Items[Index : integer] : TTextStyle read GetItem; default;
  end;

  TGutterImage=class(TDCNamedItem)
  private
    FGlyph         : TBitmap;
    FOnClick       : TNotifyEvent;
    FBookmarkIndex : integer;
    procedure SetGlyph(Value : TBitmap);
    procedure SetBookMarkIndex(V : integer);
    function  IsBoomarkIndexStored : boolean;
    procedure FreeResources;
  protected
    procedure OnChange(Sender:TObject); override;
  public
    constructor Create(AOwner : TCollection); override;
    destructor Destroy; override;
  published
    property Name;
    property Glyph : TBitmap read FGlyph write SetGlyph;
    property OnClick : TNotifyEvent read FOnClick write FOnClick;
    property BookmarkIndex : integer read FBookmarkIndex write SetBookmarkIndex stored IsBoomarkIndexStored;
  end;

  THorzMaxPos  = 40..9999;
  TMarginPos   = 2..MaxInt;
  TGutterWidth = 5..MaxInt;

  TDCGutterImages = class(TDCNamedItems)
  public
    procedure AddFromResource(const ResName, GutterImageName : string; ABookMarkIndex : integer);
  end;

  TIntArray = array[0..MaxInt Div (SizeOf(integer) * 2)] of integer;
  PIntArray = ^TIntArray;

  TStoredPosition = class
  public
    MemoSource : TCustomMemoSource;
    WinLine    : integer;
    WinChar    : integer;
    CaretPoint : TPoint;
    constructor Create(AMemo : TCustomDCMemo);
  end;

  TPositionList = class(TSortedList)
    function  Compare(Item1, Item2 : Pointer) : integer; override;
    function  CompareWithKey(Item, Key : Pointer) : integer; override;
  end;

  TMemoPostionStore = class
  private
    FPositions : TPositionList;
  public
    constructor Create;
    destructor Destroy ; override;
    procedure SavePosition(Memo : TCustomDCMemo);
    procedure RestorePosition(Memo : TCustomDCMemo);
  end;

  PWBPoint = ^TWBPoint;
  TWBPoint = record
    X        : integer;
    Y        : integer;
    Size     : TPoint;
    BaseLine : integer;
  end;

  TConvertProc = function (Index : integer) : integer of object;

  TWordWrapList = class(TMemoPositionList)
  private
    FCheckIndex : boolean;
  public
    function  Compare(Item1, Item2 : Pointer) : integer; override;
    function  FindNear(Item : PWBPoint; CheckIndex : boolean; var Exact : boolean) : integer;

    procedure ClearRange(FromIndex, ToIndex : integer); virtual;
  end;

  TLineInfoList  = class(TWordWrapList)
    procedure ClearRange(FromIndex, ToIndex : integer); override;
  end;

  TGutterBackground = class(TControlBackground)
  protected
    function  GetPaintRect : TRect; override;
    function  GetPaintBrush : TBrush; override;
  public
    procedure PaintBackground; override;
  end;

  TSeparatorOption = (moDrawLineSeparator, moWrappedLineSeparator);
  TSeparatorOptions = set of TSeparatorOption;

  TLineSeparator = class(TPersistent)
  private
    FMemo    : TCustomDCMemo;
    FPen     : TPen;
    FOptions : TSeparatorOptions;
    procedure SetPen(Value : TPen);
    procedure SetOptions(Value : TSeparatorOptions);
  protected
    procedure PenChanged(Sender : TObject);
    procedure Update; virtual;
  public
    constructor Create(Memo : TCustomDCMemo); virtual;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
  published
    property Options : TSeparatorOptions read FOptions write SetOptions;
    property Pen : TPen read FPen write SetPen;
  end;

  TShapeHighlightType = (shDoubleLine, shSingleLine);
  TLineHighlight = class(TPersistent)
  private
    FMemo    : TCustomDCMemo;
    FPen     : TPen;
    FBrush   : TBrush;
    FVisible : boolean;
    FShape   : TShapeHighlightType;
    procedure SetVisible(Value : boolean);
    procedure SetPen(Value : TPen);
    procedure SetBrush(Value : TBrush);
    procedure SetShape(Value : TShapeHighlightType);
  protected
    procedure Update; virtual;
    procedure PenChanged(Sender : TObject);
    procedure BrushChanged(Sender : TObject);
  public
    constructor Create(Memo : TCustomDCMemo); virtual;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
  published
    property Pen : TPen read FPen write SetPen;
    property Brush : TBrush read FBrush write SetBrush;
    property Visible : boolean read FVisible write SetVisible;
    property Shape : TShapeHighlightType read FShape write SetShape;
  end;

  TSpecialSymbols = class(TPersistent)
  private
    FMemo      : TCustomDCMemo;
    FEOLString : string;
    FEOFString : string;
    FSpaceChar : char;
    FTabChar   : char;
    procedure SetEOLString(Value : string);
    procedure SetEOFString(Value : string);
    procedure SetTabChar(Value : char);
    procedure SetSpaceChar(Value : char);
    procedure ReadEOLStringData(Reader: TStream);
    procedure WriteEOLStringData(Writer: TStream);
    procedure ReadEOFStringData(Reader: TStream);
    procedure WriteEOFStringData(Writer: TStream);
  protected
    procedure Update;
  public
    procedure Assign(Source : TPersistent); override;
    constructor Create(Memo : TCustomDCMemo);
    procedure DefineProperties(Filer: TFiler);override;
  published
    property EOLString : string read FEOLString write SetEOLString Stored False;
    property EOFString : string read FEOFString write SetEOFString Stored False;
    property SpaceChar : char read FSpaceChar write SetSpaceChar default #0;
    property TabChar : char read FTabChar write SetTabChar default #0;
  end;

  TConsistentAttr = (csColor, csBkColor, csFace, csCharSet, csPitch,
    csSize, csBold, csItalic, csStrikeOut, csUnderline, csStyle);

  TConsistentAttrs = set of TConsistentAttr;

  TMemoAttributes = class(TPersistent)
  private
    FState        : TConsistentAttrs;
    FFont         : TFont;
    FCharset      : TFontCharset;
    FColor        : TColor;
    FBkColor      : TColor;
    FName         : TFontName;
    FPitch        : TFontPitch;
    FSize         : integer;
    FStyle        : TFontStyles;
    FUpdateCount  : integer;
    FUseStored    : boolean;
    FStoredAttrs  : TConsistentAttrs;
    FMemo         : TCustomDCMemo;
    FData         : integer;
    function  GetFont : TFont;
    function  GetConsistentAttrs : TConsistentAttrs;
    procedure SetCharset(Value : TFontCharset);
    procedure SetColor(Value : TColor);
    procedure SetBkColor(Value : TColor);
    procedure SetName(Value : TFontName);
    procedure SetPitch(Value : TFontPitch);
    procedure SetSize(Value : Integer);
    procedure SetStyle(Value : TFontStyles);
    function  GetResetOnOverFlow : boolean;
    procedure SetResetOnOverFlow(Value : boolean);
    procedure CheckFont;
    function  EqualFontStyles(A, B : TFontStyles; Style : TFontStyle) : boolean;
    function  GetAllAttributes(CheckStyle : boolean) : TConsistentAttrs;
    procedure AssignMemoFont;
  protected
    procedure SafeAssign(Source : TPersistent);
    property Font : TFont read GetFont;
    property UseStored : boolean read FUseStored write FUseStored;
    property StoredAttrs : TConsistentAttrs read FStoredAttrs write FStoredAttrs;
  public
    constructor Create(AOwner : TCustomDCMemo);
    destructor Destroy; override;
    procedure Update;
    procedure Assign(Source : TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    property Charset : TFontCharset read FCharset write SetCharset;
    property Color : TColor read FColor write SetColor;
    property BkColor : TColor read FBkColor write SetBkColor;
    property ConsistentAttributes : TConsistentAttrs read GetConsistentAttrs;
    property Name : TFontName read FName write SetName;
    property Pitch : TFontPitch read FPitch write SetPitch;
    property Size : integer read FSize write SetSize;
    property Style : TFontStyles read FStyle write SetStyle;
    property ResetOnOverFlow : boolean read GetResetOnOverFlow write SetResetOnOverFlow;
  end;

  TFontList = class(TSortedList)
    function Compare(Item1, Item2: Pointer) : integer; override;
  end;

  TAttributeParser = class(TSimpleParser)
  private
    FFontManager     : TList;
    FEmptyList       : TList;
    FInClearStyles   : boolean;
    FCachList        : TFontList;
    FResetOnOverFlow : boolean;
    procedure SetStrAttribute(LinePos, Left, Right : integer; Attribute : TMemoAttributes);
    procedure GetStrAttribute(LinePos, Left, Right : integer; Index : byte;
              var ConsistentAttrs : TConsistentAttrs);
    procedure GetAttributes(ARect : TRect; SelectionType : TSelectionType; Attribute : TMemoAttributes;
              var ConsistentAttrs : TConsistentAttrs);
    procedure SetAttribute(ARect : TRect; SelectionType : TSelectionType; Attribute : TMemoAttributes);
    function  GetAttr(Point : TPoint) : byte;
    function  Memo : TCustomDCMemo;
    function  GetStringItem(LinePos : integer) : TStringItem;
    function  AddNewAttribute(Attr : TMemoAttributes) : integer;
    function  IndexOfEx(Attr : TMemoAttributes) : integer;
    function  GetPos(const s : string; Index : integer) : integer;
    function  CreateEmptyList : TList;
    function  GetAttrFromIndex(Index : integer) : TMemoAttributes;
    procedure AddToCachList(Attribute : TMemoAttributes; Index : integer);
  public
    procedure GetAttribute(APoint : TPoint; Attribute : TMemoAttributes);
    function  GetFont(AState: integer): TFont; override;
    function  GetBackColor(AState: integer; var Color :  TColor) : boolean; override;
    function  ColorString(const StrData: string; InitState: integer;
              var AColorData: string): Integer; override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure PrepareColorData(LinePos : integer; const s : string ; var ColorData : string); override;
    function  StoreColorData : boolean; override;
    procedure ClearStyles;
  published
    property ResetOnOverFlow : boolean read FResetOnOverFlow write FResetOnOverFlow;
  end;

  TPopupType = (ptHint, ptListBox);
  TGutterImgsAlign = (iaLeft, iaRight);

  {$IFNDEF D5}
  TWMContextMenu = packed record
    Msg: Cardinal;
    hWnd: HWND;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint);
      1: (
        Pos: TSmallPoint;
        Result: Longint);
  end;
  {$ENDIF}

  {$IFDEF CLX}

  TCLXCaret = class
  private
    FCaretVisible : boolean;
    FOwner        : TCustomDCMemo;
    FTimer        : TTimer;
    FCaretPos     : TPoint;
    FCaretSize    : TPoint;
  private
    procedure InvalidateCaret;
    function  CaretRect : TRect;
  protected
    procedure ShowCaret;
    procedure HideCaret;
    procedure SetCaretPos(X, Y : integer);
    procedure TimerOnTimer(Sender : TObject);
    procedure PaintCaret;
  public
    constructor Create(Memo : TCustomDCMemo);
    destructor  Destroy; override;
    procedure EnableCaret;
    procedure DisableCaret;
  end;
  {$ENDIF}

  TDrawState = (dsBeforePaint, dsAfterPaint, dsText, dsAfterText, dsSelection, dsMarkedText);
  TDrawStates = set of TDrawState;
  TPrintType = (ptHeader, ptFooter);

  THintPopup = procedure(Sender : TObject; Strings : TStrings; var AllowPopup : boolean; var PopupType : TPopupType) of object;
  TTemplateInsertEvent = TStringsEvent;
  TMemoChangeEvent = procedure(Sender : TObject; State : TMemoStates) of object;
  TClickGutterEvent = procedure(Sender : TObject; LinePos, ImageIndex : integer; Shift : TShiftState) of object;
  THintInsertEvent = procedure(Sender : TObject; var s : string) of object;
  TMemoScrollEvent = procedure(Sender : TObject; ScrollStyle : TScrollStyle; Delta : integer) of object;
  TVertScrollEvent = procedure(Sender : TObject; TopLine : integer; EndScroll : boolean; var ShowScrollHint : boolean; var ScrollHint : string) of object;
   
  TGetColorStyleEvent = procedure(Sender : Tobject; APoint : TPoint; var AStyle : integer) of object;
  TJumpToUrlEvent = procedure(Sender : TObject; const s : string; var Handled : boolean) of object;

  TCollapseStateChanging = procedure(Sender : TObject; LinePos : integer; ACollapsed : boolean; var Handled : boolean) of object;
  TCollapseStateChanged = procedure(Sender : TObject; LinePos : integer; ACollapsed : boolean) of object;

  TCustomStringEvent = procedure(Sender : TObject; var s, ColorS : string) of object;
  TCustomDrawEvent = procedure (Sender : TObject; Canvas : TCanvas; const Rect : TRect; LinePos, CharPos : integer; const S : string;
                                DrawState : TDrawStates; var Handled : boolean) of object;

  TDrawGutterEvent = procedure(Sender : TObject; Canvas : TCanvas; const Rect : TRect; DrawState : TDrawState; var OwnerDraw : boolean) of object;
  TExportStringEvent = procedure(Sender : TObject; var s : string) of object;
  TFindStringInPopupEvent = procedure(Sender : TObject; Strings : TStrings; const s : string; var Index : integer; var Handled : boolean) of object;
  TGetLineNumberEvent = procedure(Sender : TObject; var s : string; var MaxLen : integer) of object;

  TGetFontFromStyleEvent = procedure(Sender : TObject; Style : integer; Font : TFont; var Color : TColor) of object;
  TBeforePrintEvent = procedure(Sender : TObject; var s : string; AType : TPrintType) of object;
  TCustomDCMemo = class(TDCCustomControl)
  private
    FCharSp                   : PIntArray;
    FCharSpCount              : integer;
    FPopupListBox             : TDCPopupListBox;
    FHideCaret                : boolean;
    FBookmarkImgIndex         : array[0..9] of integer;
    FDisabledColor            : TColor;
    FReadOnlyColor            : TColor;
    FPrintOptions             : TDCPrintOptions;
    FPaintWidth               : integer;
    FPaintHeight              : integer;
    FSpecialPaint             : boolean;
    FLineNumbersLength        : integer;
    FLineNumAlign             : TAlignment;
    FOnChange                 : TNotifyEvent;
    FOnClickGutter            : TClickGutterEvent;
    FGutterBackColor          : TColor;
    FLineBookmarkColor        : TColor;
    FLineNumbersWidth         : integer;
    FSelColor                 : TColor;
    FSelBackColor             : TColor;
    FHorzMaxPos               : THorzMaxPos;
    Tag1                      : integer;
    Tag2                      : integer;

    FSelStart                 : TPoint;
    FNeedUpdateSel            : boolean;
    FSelUpdated               : boolean;
    FSelDirection             : boolean;

    FEditState                : TEditState;

    FTextStyles               : TTextStyles;
    FGutterImgs               : TDCGutterImages;
    FGutterImgsAlign          : TGutterImgsAlign;
    FMarginPen                : TPen;
    FGutterBrush              : TBrush;
    FGutterWidth              : TGutterWidth;
    FMarginPos                : TMarginPos;
    FOptions                  : TMemoOptions;
    fDrawRect                 : TRect;
    FDrawCanvas               : TCanvas;
    WinLine                   : integer;
    WinChar                   : integer;
    FOldPoint                 : TPoint;
    FScrollBars               : TScrollStyle;
    FBorderStyle              : TBorderStyle;
    FMemoSource               : TCustomMemoSource;
    FIntSource                : TCustomMemoSource;
    FLineHeight               : integer;
    FCharWidth                : integer;
    FFont                     : TMemoFont;
    FTemplateFont             : TFont;
    FPrinterFont              : TMemoFont;
    FUsePrinterFont           : boolean;
    FGutterLineColor          : TColor;
    FMatchColor               : TColor;
    FMatchBackColor           : TColor;
    FLineNumColor             : TColor;
    fUseGlobalOptions         : boolean;
    fWheelDelta               : smallint;
    FHideSelection            : boolean;
    FCompletion               : TStrings;
    FHintPopup                : TStrings;
    FCaretSize                : TPoint;
    FInsCaretWidth            : integer;
    FLeftIndent               : integer;
    FPrintIndent              : integer;
    FLineSeparator            : TLineSeparator;
    FLineHighlight            : TLineHighlight;
    FSpecialSymbols           : TSpecialSymbols;
    FMemoBackground           : TControlBackground;
    FGutterBackground         : TControlBackground;
    FSelAttributes            : TMemoAttributes;
    FHideScrollBars           : boolean;
    FTextStylesChanged        : boolean;
    FGutterImagesChanged      : boolean;
    FMouseIsHot               : boolean;
    FMouseOnButton            : boolean;
    FMouseOnGutter            : boolean;
    FPositionStore            : TMemoPostionStore;
    FOnHintPopup              : THintPopup;
    FPopupHint                : TDCHint;
    FHintPause                : integer;
    FHintPos                  : TPoint;
    FOldCursor                : TCursor;
    FVersion                  : TDCVersion;
    FGutterLineIndent         : integer;
    FUseMonoFont              : boolean;
    FWordSelectionType        : TWordSelectionType;
    FCaretBaseLine            : integer;
    FVertFlag                 : boolean;
    FVertX                    : integer;
    FVertxChar                : integer;
    FCurStyle                 : integer;
    FCurFont                  : TFont;
    FCreated                  : boolean;
    FFontMonospaced           : boolean;
    FDefaultMenu              : TPopupMenu;
    FUseDefaultMenu           : boolean;
    FClipboardType            : TClipboardType;
    FUseTextStyle             : boolean;
    FClipCurChar              : integer;
    FBookmarkList             : TList;
    {$IFDEF CLX}
    FHintTimer                : TTimer;
    FDragTimer                : TTimer;
    FVertScrollBar            : QScrollBarH;
    FHorzScrollBar            : QScrollBarH;
    FHorzHooks                : QScrollBar_HookH;
    FVertHooks                : QScrollBar_HookH;
    FInternalColor            : QColorH;
    FClxCaret                 : TCLXCaret;
    {$ELSE}
    FDblClickTime             : DWord;
    FDblClicPoint             : TPoint;
    {$ENDIF}
    //---Word Wrap support
    FWordWrap                 : boolean;
    FWordBreakList            : TWordWrapList;
    FLineInfoList             : TLineInfoList;
    FWbCount                  : integer;
    FWBlockChanged            : boolean;
    FOldBlockOption           : TBlockOption;
    FLastWrappedLine          : integer;
    FWrapCheck                : boolean;
    FHiColor                  : boolean;
    
    FPrintPageSize            : TPoint;
    FGradientBeginColor       : TColor;
    FGradientEndColor         : TColor;
    FLineNumBackColor         : TColor;
    FOnTemplateInsert         : TTemplateInsertEvent;
    FOnHintInsert             : THintInsertEvent;
    FOnCreateDialog           : TCreateDialogEvent;
    FOnMemoScroll             : TMemoScrollEvent;
    FOnVerticalScroll         : TVertScrollEvent;
    FOnMouseLeave             : TNotifyEvent;
    FOnGetColorStyle          : TGetColorStyleEvent;
    FOnGetFontFromStyle       : TGetFontFromStyleEvent;

    FOnCustomString           : TCustomStringEvent;
    FOnCustomDraw             : TCustomDrawEvent;
    FOnDrawGutter             : TDrawGutterEvent;
    FTempBitmap               : TBitmap;

    FOnStateChange            : TMemoChangeEvent;
    FOnSelectionChange        : TNotifyEvent;
    FOnJumpToUrl              : TJumpToUrlEvent;
    FOnCollapseStateChanging  : TCollapseStateChanging;
    FOnCollapseStateChanged   : TCollapseStateChanged;
    FOnExportString           : TExportStringEvent;
    FOnFindStringInPopup      : TFindStringInPopupEvent;
    FOnGetLineNumber          : TGetLineNumberEvent;
    FOnBeforePrint            : TBeforePrintEvent;

    procedure SetHideCaret(V : boolean);
    function  GetCodeTemplates : TMemoCodeTemplates;
    procedure SetCodeTemplates(V : TMemoCodeTemplates);
    function  GetTemplatesType : string;
    procedure SetTemplatesType(Value : string);

    procedure OnGutterImgsChange(Sender : TObject);
    procedure SetHideSelection(V : Boolean);
    procedure SetDisabledColor(V : TColor);
    procedure SetReadOnlyColor(V : TColor);
    function  GetLineNumbersLength : integer;
    procedure SetLineNumAlign(V : TAlignment);
    {$IFNDEF CLX}
    function  GetText : string;
    procedure SetText(const V : string);
    {$ENDIF}
    function  GetSelText : string;
    procedure SetSelText(const V : string);
    procedure UpdateHiddenSelection;
    function  GetUseGlobalOptions : boolean;
    procedure SetLineNumColor(V : TColor);
    procedure SetDCColor(FontColor, BackColor : TColor);
    function  GetStringsOptions : TStringsOptions;
    procedure SetStringsOptions(V : TStringsOptions);
    function  GetSyntaxParser : TSimpleParser;
    function  UpdateLineNumbersWidth : boolean;
    function  GetLineNumbersWidth : integer;
    procedure SetSyntaxParser(V : TSimpleParser);
    function  GetRealGutterWidth : integer;
    function  GetRealLeftIndent : integer;
    procedure SetGutterBackColor(V : TColor);
    function  GetTabStops : string;
    procedure SetTabStops(const V : string);
    function  GetDelimiters : string;
    procedure SetDelimiters(const V : string);
    procedure SetMemoBackground(Value : TControlBackground);
    procedure SetBkgndOption(Value : TBkgndOption);
    function  GetBkgndOption : TBkgndOption;
    procedure SetGutterBackground(Value : TControlBackground);
    procedure SetBackground(Value : TBitmap);
    function  GetBackground : TBitmap;
    function  GetSourcePropsStored : boolean;
    procedure SetMatchColor(V : TColor);
    procedure SetMatchBackColor(V : TColor);
    procedure SetSelBackColor(V : TColor);
    procedure SetSelColor(V : TColor);
    function  GetLines : TStrings;
    procedure SetLines(V : TStrings);
    function  GetReadOnly : boolean;
    procedure SetReadOnly(V : boolean);
    procedure RecalculatePosition;
    procedure CheckRealPosition;
    procedure SetGutterImgs(Value : TDCGutterImages);
    procedure SetGutterImgsAlign(Value : TGutterImgsAlign);
    procedure SetHorzMaxPos(V : THorzMaxPos);
    procedure SetGutterBrush(V : TBrush);
    procedure SetLineBookmarkColor(Value : TColor);
    procedure _MMoveEvent;
    function  GetCurPosText : string;
    procedure SetMarginPen(V : TPen);
    procedure SetTextStyles(V : TTextStyles);
    procedure UpdateScrollSize;
    procedure UpdateScrollPos;
    function  CharScrollSize : boolean;
    procedure UpdateMaxLine(recalc : boolean);
    procedure KillHintTimer;
    procedure ModifyScrollBar(ScrollBar, ScrollCode, Pos : integer);
    procedure QuickPaint(OWinChar, OWinLine : integer);
    procedure FontOnChange(Sender : TObject);
    procedure PaintLineNumbers;
    procedure PaintGutter;
    function  NeedPaintGutter(var R : TRect) : boolean;
    procedure PaintLeftIndent;
    function  TempBackGround : TBitmap;
    procedure SetScrollBars(Value : TScrollStyle);
    procedure SetBorderStyle(Value : TBorderStyle);
    procedure OnInvalidate(Sender : TObject);
    procedure OnChangeMargin(Sender : TObject);
    function  GetPaintX : integer;
    procedure SetMarginPos(V : TMarginPos);
    function  GetAveLineHeight : integer;
    function  GetRealLineHeight(LinePos : integer) : integer;
    function  GetRealLineWidth(LinePos : integer) : integer;
    function  GetBaseLine(LinePos : integer) : integer;
    function  GetAveCharWidth : integer;
    procedure FreeCharSp;
    procedure UpdateCharSp(L : integer);
    procedure SetSource(Value : TCustomMemoSource);
    procedure SetGutterWidth(V : TGutterWidth);
    procedure RealPaint;
    procedure SetGutterLineColor(V : TColor);
    procedure SetOptions(Value : TMemoOptions);
    procedure PaintGutterImages;
    function  GetBlockIndent : integer;
    procedure SetBlockIndent(Value : integer);
    function  GetSpacesInTab : integer;
    procedure SetSpacesInTab(Value : integer);
    function  GetCaretPoint : TPoint;
    procedure SetCaretPoint(Value : TPoint);
    procedure SetFont(V : TMemoFont);
    procedure SetPrinterFont(Value : TMemoFont);
    procedure SetTemplateFont(Value : TFont);
    procedure SetLineNumBackColor(Value : TColor);
    procedure SetGutterLineIndent(Value : integer);
    procedure CalcGutterImgSize(Index : integer; var NewWidth, NewHeight : integer);
    procedure CodeTemplCallBack(Sender : TObject; SelIndex : integer);
    function  GetCaretWidth : integer;
    procedure SetWinLine(Value : integer);
    procedure SetWinChar(Value : integer);
    procedure SetUseMonoFont(Value : boolean);
    function  GetCaretChar : integer;
    function  GetCaretLine : integer;
    procedure SetLineSeparator(Value : TLineSeparator);
    procedure SetLineHighlight(Value : TLineHighLight);
    procedure SetSpecialSymbols(Value : TSpecialSymbols);
    function  GetSelBkColor : TColor;
    function  GetSelColor : TColor;
    function  GetHighlightUrls : boolean;
    procedure SetHighlightUrls(Value :boolean);
    function  GetAllowUndo  : boolean;
    procedure SetAllowUndo(Value : boolean);
    function  GetUndoLimit : integer;
    procedure SetUndoLimit(Value : integer);
    procedure SetSelAttributes(Value : TMemoAttributes);
    function  GetSelAttributes : TMemoAttributes;
    procedure SetClipboardType(Value : TClipboardType);
    function  GetPlainText : boolean;
    procedure SetPlainText(Value : boolean);
    function  GetBlockOption : TBlockOption;
    procedure SetBlockOption(Value : TBlockOption);
    function  GetOutFormat : TOutFormatType;
    procedure SetOutFormat(Value : TOutFormatType);
    procedure SetHideScrollBars(Value : boolean);
    function  GetDefaultMenu : TPopupMenu;
    function  CheckMenuPopup : boolean;
    //new paint
    procedure SetLeftIndent(Value : integer);
    function  GetCurFontHandle : {$IFNDEF CLX} HFONT {$ELSE} QFontH {$ENDIF};
//    function  ValidateColorStyle(index : integer) : integer;
    function  EqualStyles(a, b : integer; ASkipColor : boolean) : boolean;
    function  SetColorFromStyle(AColorStyle, AOldStyle, AOldColor, AOldBkColor : integer;
    InSelection, ASkipColor, ACalcRect : boolean) : TFont;
    procedure GetSelColorsFromStyle(Style : integer; var AColor, ABkColor : integer);
    procedure _TextOut(var R : TRect; BaseLine, CurLine, CurWrapLine, CurChar, X , Y : integer ;
               PStr : PChar; Len : integer; CalcRect, ASelection, AMarkedText : boolean);
    procedure _FillRect(ARect : TRect; CurLine, CurWrapLine, CurChar, ABeginSel, AEndSel , AOldStyle : integer);

    function  PaintString(var R : TRect; var BaseLine : integer; const S, ColorS : string;
              begChar, endChar, CurLine, CurWrapLine, CurPos, CurStyle : integer; SkipColors, CalcRect, CalcSymbols : boolean) : integer;

    function  CalcStringSize(S, ColorS : string; Pos, Len : integer; var BaseLine : integer) : TPoint;
    function  SymbolsDrawn(LinePos, CharPos : integer; const S, ColorS : string; var BaseLine : integer;
              var R : TRect; exact, CheckMBCS : boolean) : integer;
    procedure GetStrData(LinePos : integer; var S, ColorS : string);
    procedure GetStrDataEx(var TextPoint : TPoint; var S, ColorS : string);
    function  GetCaretSize : TPoint;
    function  CalcSpacesSize(Count : integer; Point : TPoint) : integer;
    function  IsMemoFontMonoSpaced : boolean;
    function  InSelection(x, y : integer) : boolean;
    function  InFoundRect(x, y : integer) : boolean;
    function  PosInBlock(X, Y : integer) : boolean;
    procedure TextStylesChanged(Sender : TObject);
    procedure UpdateLineHeight;
    function  MouseAtHotString(X, Y : integer) : boolean;
    function  IsUrlUnderPoint(Pt : TPoint; var s : string; TestOnly : boolean) : boolean;
    function  CheckMouseOnButton(X, Y : integer; var Line : integer) : boolean;

    function  GetMaxLineLen : integer;
    function  GetFontFromTextStyle(Style : integer) : TFont;
    function  GetColorFromTextStyle(Style : integer) : TColor;
    function  GetFontColorFromTextStyle(Style : integer) : TColor;
    procedure FontAndColorsFromStyle(Style : integer; var Font : TFont; var Color, BkColor : integer);
    function  CheckReadOnlyColor(AColor : TColor) : TColor;

    procedure InvalidateLines(FromLine, ToLine : integer; ParseOnly : boolean);

    function  IsUpperCaseStyle(Style : integer) : boolean;
    function  HideLines : boolean;

    function  NeedHighLightLine(CurLine : integer) : boolean;
    procedure HighLightLine(ACanvas : TCanvas; CurLine : integer; R : TRect);
    function  IsHighLightBrushClear : boolean;
    function  NeedSyntaxPaint : boolean;

    function  PixelToTextLine(var LinePos, CharPos : integer; CheckEnd : boolean) : integer;
    function  PixelToTextChar(LinePos, CharPos, X : integer; CheckEnd : boolean) : integer;
    function  GetDrawCanvas : TCanvas;
    function  LineToPixel(StartLine, ToLine, Pos : integer) : integer;
    function  TextToPixelLine(TextPoint : TPoint) : integer;
    function  TextToPixelChar(TextPoint : TPoint) : integer;
    procedure CheckVisibleIndex(var Index : integer; AVisible : boolean);

    procedure PageUpDown(direction : boolean);
    procedure DoSetFocus;
    procedure DoKillFocus;
    // rtf support
    procedure SetClipboardBuffer(Format : {$IFNDEF CLX} Word {$ELSE} string {$ENDIF}; var Buffer; Size: Integer);
    procedure GetClipboardBuffer(Format : {$IFNDEF CLX} Word {$ELSE} string {$ENDIF}; Stream : TStream);
    {$IFDEF CLX}
    procedure OnHintTimer(Sender : TObject);
    procedure OnDragTimer(Sender : TObject);
    procedure PaintScrollRect;
    procedure QTextOut(ACanvas : TCanvas; const R : TRect; Ptr : PChar; Len : integer; AFontInfo : PFontInfo; AFill : boolean; Buffer : Pointer);
    procedure QBitBlt(dst: TCanvas; dx, dy : integer; src: TCanvas; sx, sy, sw, sh : integer);
    procedure QFillRect(ACanvas : TCanvas; const R : TRect; ABrush : TBrush);
    {$ELSE}
    procedure DoTextOut(ACanvas : TCanvas; R : TRect; Style : integer; Ptr : PChar; Len : integer; Buffer : Pointer; OverHang : integer);
    {$ENDIF}
    procedure ImportText(Sender : TObject; const s : string; AFont : TFont; AColor : TColor);
    function  MoveBlockToPosEx(DeleteOrigin : boolean) : boolean;
    procedure AssignAttributeFont;
    procedure HintCallBack(Sender : TObject; SelIndex : integer); virtual;

    //---Word Wrap support
    procedure SetWordWrap(Value : boolean);
    procedure CheckWBCount(AUpdate : boolean);
    procedure WordWrapLines(FromIndex, ToIndex : integer; AInvalidate : boolean);
    procedure SafeWordWrapLines(FromIndex, ToIndex : integer);

    function  FindWordBreak(LinePos : integer; var Pos, BaseLine : integer; var R : TRect) : string;
    function  GetRealPosition(Position : TPoint) : TPoint;
    function  GetRealLineIndex(LinePos : integer; var Pos : integer) : integer;
    function  GetRealPositionEx(Position : TPoint; CheckMBCS : boolean) : TPoint;
    function  GetWBPosition(Position : TPoint) : TPoint;
    function  GetWBPositionEx(Position : TPoint; CheckMBCS, ConvertResult : boolean; var Pos : integer) : TPoint;
//    procedure CheckLastChar(var Index: integer ; AX : integer);

    function  GetRealPoint(Pt : TPoint) : TPoint;

    function  CalcWrapPos(LinePos, CharPos : integer; var APoint : TPoint) : boolean;
    function  GetRealStrCount : integer;
    function  GetRealStrCountEx : integer;
    function  GetWBStringLength(RealIndex, Index : integer; CheckLineEnd : boolean) : integer;
    function  GetWordBreakCount(FromIndex, Pos, ToIndex : integer) : integer;
    procedure WordWrapUpdated;
    procedure CheckLastWrappedLine(LinePos : integer);
    function  GetWrappedLineHeight(Index : integer) : integer;
    procedure GetWrappedPos(Index : integer; var Pos : integer);
    function  GetWrappedLineHeightEx(Index : integer; var Pos, BaseLine : integer; SingleLine, Direction : boolean) : integer;
    function  GetWrappedLineWidth(Index : integer; var Pos : integer; SingleLine : boolean) : integer;
    procedure CheckBlockOptions(Value : boolean);
    function  GetWrapMargin : integer;
    function  GetMaxCaretCharEx(CheckMaxLineLen : boolean) : integer;
    function  GetMaxCaretLineEx(AHeight : integer) : integer;
    function  DrawEof : boolean;

    procedure PopupBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PopupBoxKeyPress(Sender : TObject; var Key : char);

    procedure DoSelTimer;
    function  DoSetCursor : boolean;
    procedure DoBoundsChanged;
    procedure DoColorChanged;
    procedure MouseWheel(ADelta : integer);
    function  ContextMenu(Pt : TPoint) : boolean;


    procedure FreePopupListBox;
    function  MouseToTextPoint(XX, YY : integer; CheckEnd : boolean) : TPoint;

  protected
    {$IFNDEF CLX}
    procedure CMENABLEDCHANGED(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure WMLButtonDblClk(var Message: TMessage); message WM_LBUTTONDBLCLK;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR; ///
    procedure CreateParams(var Params: TCreateParams);override;

    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_EraseBkgnd;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    procedure WMHScroll(var Msg : TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Msg : TWMVScroll); message WM_VSCROLL;
    procedure WMMouseWheel(var Message : TMessage); message WM_MOUSEWHEEL;
    procedure WMTimer(var Msg : TWMTimer); message WM_TIMER;
    procedure WMCLEAR(var Msg : TMessage); message WM_CLEAR;
    procedure WMCOPY(var Msg : TMessage); message WM_COPY;
    procedure WMPASTE(var Msg : TMessage); message WM_PASTE;
    procedure WMCUT(var Msg : TMessage); message WM_CUT;
    procedure WMUNDO(var Msg : TMessage); message WM_UNDO;
    procedure EMUNDO(var Msg : TMessage); message EM_UNDO;
    procedure EMCANUNDO(var Msg : TMessage); message EM_CANUNDO;
    procedure EMEMPTYUNDOBUFFER(var Msg : TMessage); message EM_EMPTYUNDOBUFFER;
    procedure EMGETLINECOUNT(var Msg : TMessage); message EM_GETLINECOUNT;
    procedure EMGETLINE(var Msg : TMessage); message EM_GETLINE;
    procedure EMLINEINDEX(var Msg : TMessage); message EM_LINEINDEX;
    procedure WMGETTEXTLENGTH(var Msg : TMessage); message WM_GETTEXTLENGTH;
    procedure CMColorChanged(var Message : TMessage); message CM_COLORCHANGED;
    procedure CMENTER(var Msg : TMessage); message CM_ENTER;
    procedure CMEXIT(var Msg : TMessage); message CM_EXIT;
    procedure CMMOUSELEAVE(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMUpdateOptions(var Message: TMessage); message CM_UPDATEOPTIONS;
    procedure CreateHandle; override;

    {$ELSE}
    procedure EnabledChanged; override;
    procedure BoundsChanged; override;
    procedure ChangeScrollSize;
    function  EventFilter(Sender : QObjectH; Event : QEventH) : boolean; override;
    procedure ColorChanged; override;
    function  WidgetFlags : integer; override;
    procedure CreateWidget; override;
    procedure InitWidget; override;
    procedure DestroyWidget; override;
    procedure WidgetDestroyed; override;
    function  GetText : TCaption; override;
    procedure SetText(const V : TCaption); override;
    function  GetClientRect : TRect; override;
    procedure HookEvents; override;
    procedure ScrollHorzEventHandler(Value : integer); cdecl;
    procedure ScrollVertEventHandler(Value : integer); cdecl;
    procedure InitScrollHooks; virtual;
    procedure DoneScrollHooks; virtual;
    procedure DoDestroyWindow;
    procedure CheckThumbTrack;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure MouseLeave(AControl : TControl); override;
    procedure DblClick; override;
    function  DoMouseWheel(Shift : TShiftState; WheelDelta : Integer; MousePos : TPoint) : boolean; override;
    procedure DoContextPopup(MousePos : TPoint; var Handled : boolean); override;
    {$ENDIF}
    function  NotifySource(var Msg : TMessage):boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                X, Y: integer); override;
    procedure SourceChanged(Sender : TObject; wParam, lParam : integer);virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    function  CreateDefaultMemoSource : TCustomMemoSource; virtual;
    procedure KeyPress(var Key: Char); override;
    procedure KillTimer;
    procedure SetUseGlobalOptions(val : boolean); virtual;
    function  PopupHintBoxEx(AutoHide : boolean) : boolean;

    procedure UpdateAVESize;
    function  DoPaintGutter(const ARect : TRect; DrawState : TDrawState) : boolean; virtual;

    procedure InitDefaultKeyMapping; override;
    function  InsertChar(Key : Char) : Boolean; override;
    {$IFDEF DCMBCS}
    procedure WMImeNotify(var Msg: TMessage); message WM_IME_NOTIFY;
    function  InsertString(const s : string) : boolean; override;
    {$ENDIF}

    function  UpdateCaretMode : boolean;
    procedure CreateCaret;
    procedure Loaded; override;
    procedure DoGetFontFromStyle(Style : integer; Font : TFont; var Color : TColor); virtual;

    //procedure DefineProperties(Filer: TFiler); override;
    function  CreatePrintDialog : TCustomForm; virtual;
    function  CreatePrintProgressDialog : TCustomForm; virtual;
    procedure TemplateInsert(Strings : TStrings); virtual;
    procedure HintInsert(var s : string); virtual;
    function  ActivatePopupBox(var PopupType : TPopupType) : boolean; virtual;
    procedure MarkWordOnTemplate; virtual;
    procedure GetNavigation(Sender : TObject ; var DeltaLine, DeltaChar : integer);
    procedure GetLineHeight(Sender : TObject; Index : integer; Item : TStringItem);
    procedure DoMemoScroll(ScrollStyle : TScrollStyle; Delta : integer); virtual;
    procedure DoClickGutter(LinePos, ImageIndex : integer; Shift : TShiftState); virtual;
    procedure MakeSearchPointVisible(Rect : TRect; UseTopLeft : boolean);

    procedure DoCustomString(var S, ColorS : string); virtual;
    function  CustomDraw(Canvas : TCanvas; const R : TRect; Ptr : PChar; Len : integer;
              LinePos, CharPos : integer; DrawState : TDrawStates) : boolean; virtual;


    procedure DoGetColorStyle(Point : TPoint; var AStyle : integer); virtual;
    procedure StateChanged(AState : TMemoStates); virtual;
    procedure SelectionChanged; virtual;
    procedure MemoJumpToUrl(const s : string); virtual;
    function  CollapseStateChanging(LinePos : integer; State : TCollapseState) : boolean; virtual;
    procedure CollapseStateChanged(LinePos : integer; State : TCollapseState); virtual;
    function  DoFindInPopupBox(AStrings : TStrings; const s : string; var Index : integer) : boolean; virtual;
    procedure VerticalScroll(code : integer); virtual;
    procedure InsertHint(s : string); virtual;
    function  GetStringSize(LineNo, FromPos, Len : integer) : integer;
    procedure CenterScreenOnLineEx;
    function  IsPointVisible(Point : TPoint) : boolean;
    function  ClosePopupListBox(var Key : Word; Shift : TShiftState) : boolean; virtual;

    //popup menu
    procedure UndoClick(Sender : TObject);
    procedure CutClick(Sender : TObject);
    procedure CopyClick(Sender : TObject);
    procedure PasteClick(Sender : TObject);
    procedure DeleteClick(Sender : TObject);
    procedure SelectAllClick(Sender : TObject);
    {$IFNDEF CLX}
    function  DoBeforePrint(const s : string; PrintType : TPrintType) : string;
    {$ENDIF}
    property  DefaultMenu : TPopupMenu read GetDefaultMenu;
    property  PopupHint : TDCHint read FPopupHint;
    property  PopupList : TDCPopupListBox read FPopupListBox;
    property  HintPos : TPoint read FHintPos write FHintPos;


  public
    procedure EnsureCaretVisible;
    procedure EnsurePointVisible(Point : TPoint);
    procedure MemoJumpToLineBegin;
    procedure MemoJumpToLineEnd;
    procedure MemoMarkToLineBegin;
    procedure MemoMarkToLineEnd;
    procedure MemoCursorUp;
    procedure MemoCursorDown;
    procedure MemoCursorLeft;
    procedure MemoCursorRight;
    procedure MemoMarkDown;
    procedure MemoMarkUp;
    procedure CheckCursorLeft;
    procedure MemoMarkLeft;

    procedure UpdateCaret;
    function  TextToPixelPoint(TextPoint : TPoint) : TPoint;
    function  GetCurentPosinPixels : TPoint;
    function  PopupHintBox : boolean; virtual;
    {$IFNDEF CLX}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
    {$ELSE}
    procedure ChangeBounds(ALeft, ATop, AWidth, AHeight: integer); override;
    {$ENDIF}
    procedure TempHighlightLineWithStyle(Index : integer; const StyleName : string);
    procedure ToggleImageAndTextStyle(const StyleName : string);
    procedure SetSelTextBuf(Buffer : PChar);
    function  ConvertMousePos(XX, YY : integer) : TPoint;
    function  ConvertMousePosEx(XX, YY : integer; CheckEnd : boolean) : TPoint;
    procedure SetPosByMouse(X, Y : integer);
    function  PointToImageIndex(Line, XCoord : integer) : integer;

    {$IFNDEF CLX}
    procedure DrawMetaFileToClipboard(enhanced : boolean);
    procedure DrawBitmapToClipboard;
    procedure DrawToBMPFile(const FileName : string);
    procedure DrawToEMFWMF(const FileName : string; enhanced : boolean);
    procedure DrawToMetaFile(AMetaFile : TMetaFile; DC : THandle);
    procedure DrawToMetaFileEx(AMetaFile : TMetaFile; DC : THandle; AY : integer);
    procedure DrawToBitmap(bitmap : TBitmap);
    procedure CopyGraphicToClipboard(GraphicsFormat : TDCGraphicsFormat);
    procedure DrawToFile(FileName : string; GraphicsFormat : TDCGraphicsFormat);
    procedure PrintWithDialog;
    procedure Print;
    {$ENDIF}

    function  SelLength : integer;
    procedure LoadGlobalOptions;virtual;
    procedure ProcessEscape;
    procedure CancelDragging;
    procedure InsertSpace;
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    destructor Destroy; override;


    procedure MarkColPageUp;
    procedure MarkColPageDown;
    procedure MarkColToTop;
    procedure MarkColToBottom;
    procedure MarkPageUp;
    procedure MarkPageDown;
    procedure MarkToBottom;
    procedure MarkToTop;
    procedure JumpToScreenTop;
    procedure JumpToScreenBottom;
    procedure JumpLeftMost;
    procedure JumpRightMost;
    procedure PageDown;
    procedure PageUp;
    procedure PageLeft;
    procedure PageRight;
    procedure ScrollScreenHorz(I : integer);
    procedure ScrollScreenVert(I : integer);
    procedure ScrollUp;
    procedure ScrollDown;
    procedure ScrollPageUp;
    procedure ScrollPageDown;
    procedure ScrollLeft;
    procedure ScrollRight;
    procedure ScrollPageRight;
    procedure ScrollPageLeft;
    procedure CenterScreenOnLine;
    procedure CenteredJumpTo(X, Y : integer);
    procedure PromptedGotoLine;
    function  GetSource : TCustomMemoSource;
    procedure LoadFromFile(const FileName : string);
    procedure SaveToFile(const FileName : string);
    procedure ShowCodeTemplates;
    procedure ExportTo(const Exporter : TDCExporter);
    procedure ExportToStream(Stream : TStream; Exporter : TDCExporterClass);
    procedure ExportToFile(const FileName : string; Exporter : TDCExporterClass);
    procedure ExportToHtmlFile(const FileName : string);
    procedure ExportToRtfFile(const FileName : string);
    procedure ExportToHtmlStream(Stream : TStream);
    procedure ExportToRtfStream(Stream : TStream);

    procedure ExportToEx(const Exporter : TDCExporter; Selection : boolean);
    procedure ExportToStreamEx(Stream : TStream; Exporter : TDCExporterClass; Selection : boolean);
    procedure ExportToFileEx(const FileName : string; Exporter : TDCExporterClass; Selection : boolean);
    procedure ExportToHtmlFileEx(const FileName : string; Selection : boolean);
    procedure ExportToRtfFileEx(const FileName : string; Selection : boolean);
    procedure ExportToHtmlStreamEx(Stream : TStream; Selection : boolean);
    procedure ExportToRtfStreamEx(Stream : TStream; Selection : boolean);

    procedure PasteFromRtfStream(Stream : TStream);
    procedure PasteFromRtfFile(const FileName : string);
    procedure LoadFromRtfStream(Stream : TStream);
    procedure LoadFromRtfFile(const FileName : string);

    procedure PasteFromHtmlStream(Stream : TStream);
    procedure PasteFromHtmlFile(const FileName : string);
    procedure LoadFromHtmlStream(Stream : TStream);
    procedure LoadFromHtmlFile(const FileName : string);

    procedure PasteFromImportStream(Stream : TStream; ImporterClass : TDCImporterClass);

    function  TextAtMousePoint(Point : TPoint) : string;
    function  GetMaxCaretLine : integer;
    function  GetMaxCaretChar : integer;
    procedure ShowPopupHint(const S : string; Point : TPoint; AutoHide : boolean);
    procedure HidePopupHint;
    procedure ShowPopupListBox(Strings : TStrings);
    procedure ShowPopupListBoxEx(Strings : TStrings; AlignArray : array of TLeftRightAlign; AMaxSize : integer);

    procedure CopyToClipboard; virtual;
    procedure CutToClipboard; virtual;
    procedure PasteFromClipboard; virtual;
    function  CanPaste : boolean;
    procedure GetWrapLines(AStrings : TStrings);
    procedure GetBlockWrapLines(AStrings : TStrings);

    property  CharWidth : integer read GetAveCharWidth;
    property  LineHeight : integer read GetAveLineHeight;

    property WinLinePos : integer read WinLine write SetWinLine;
    property WinCharPos : integer read WinChar write SetWinChar;
    property CaretCharPos : integer read GetCaretChar;
    property CaretLinePos : integer read GetCaretLine;

    property DisabledColor : TColor read FDisabledColor write SetDisabledColor default clGrayText;
    property ReadOnlyColor : TColor read FReadOnlyColor write SetReadOnlyColor default clWindow;
    property CurPosText : string read GetCurPosText;
    property CaretPoint : TPoint read GetCaretPoint write SetCaretPoint;
    property CaretPos : TPoint read GetCaretPoint write SetCaretPoint;

    property SelColor : TColor read FSelColor write SetSelColor default clHighlightText;
    property SelBackColor : TColor read FSelBackColor write SetSelBackColor default clHighlight;
    property MatchColor : TColor read FMatchColor write SetMatchColor default clLime;
    property MatchBackColor : TColor read FMatchBackColor write SetMatchBackColor default clWindowText;

    property HideSelection : boolean read FHideSelection write SetHideSelection default false;
    property SpacesInTab : integer read GetSpacesInTab write SetSpacesInTab;
    property HorzMaxPos : THorzMaxPos read FHorzMaxPos write SetHorzMaxPos default 512;
    property TextStyles : TTextStyles read FTextStyles write SetTextStyles stored FTextStylesChanged;
    property MemoSource : TCustomMemoSource read FMemoSource write SetSource;
    property BorderStyle : TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property UseGlobalOptions : boolean read GetUseGlobalOptions write SetUseGlobalOptions;
    property ScrollBars : TScrollStyle read FScrollBars write SetScrollBars default ssNone;
    property Options : TMemoOptions read FOptions write SetOptions;
    property MarginPos : TMarginPos read FMarginPos write SetMarginPos default 80;
    property GutterBrush : TBrush read FGutterBrush write SetGutterBrush;
    property MarginPen : TPen read FMarginPen write SetMarginPen;
    property GutterLineColor : TColor read FGutterLineColor write SetGutterLineColor default clGray;
    property GutterWidth : TGutterWidth read FGutterWidth write SetGutterWidth default 32;
    property GutterImgs : TDCGutterImages read FGutterImgs write SetGutterImgs stored FGutterImagesChanged;
    property GutterImgsAlign : TGutterImgsAlign read FGutterImgsAlign write SetGutterImgsAlign default iaLeft;
    property LineNumbersWidth : integer read FLineNumbersWidth;
    property ClipboardType : TClipboardType read FClipboardType write SetClipboardType default cbNormal;
    property PlainText : boolean read GetPlainText write SetPlainText default true;
    property OnStateChange : TMemoChangeEvent read FOnStateChange write FOnStateChange;
    property OnSelectionChange : TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnJumpToUrl : TJumpToUrlEvent read FOnJumpToUrl write FOnJumpToUrl;
    property OnClickGutter : TClickGutterEvent read FOnClickGutter write FOnClickGutter;
    property OnHintPopup : THintPopup read FOnHintPopup write FOnHintPopup;
    property OnTemplateInsert : TTemplateInsertEvent read FOnTemplateInsert write FOnTemplateInsert;
    property OnHintInsert : THintInsertEvent read FOnHintInsert write FOnHintInsert;
    property OnCreateDialog : TCreateDialogEvent read FOnCreateDialog write FOnCreateDialog;
    property OnMemoScroll : TMemoScrollEvent read FOnMemoScroll write FOnMemoScroll;
    property OnVerticalScroll : TVertScrollEvent read FOnVerticalScroll write FOnVerticalScroll;
    property OnGetColorStyle : TGetColorStyleEvent read FOnGetColorStyle write FOnGetColorStyle;
    property OnMouseLeave : TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnGetFontFromStyle : TGetFontFromStyleEvent read FOnGetFontFromStyle write FOnGetFontFromStyle;
    property OnCustomString : TCustomStringEvent read FOnCustomString write FOnCustomString;
    property OnCustomDraw : TCustomDrawEvent read FOnCustomDraw write FOnCustomDraw;
    property OnDrawGutter : TDrawGutterEvent read FOnDrawGutter write FOnDrawGutter;
    property OnCollapseStateChanging  : TCollapseStateChanging read FOnCollapseStateChanging write FOnCollapseStateChanging;
    property OnCollapseStateChanged  : TCollapseStateChanged read FOnCollapseStateChanged write FOnCollapseStateChanged;
    property OnExportString : TExportStringEvent read FOnExportString write FOnExportString;
    property OnFindStringInPopup : TFindStringInPopupEvent read FOnFindStringInPopup write FOnFindStringInPopup;
    property OnGetLineNumber : TGetLineNumberEvent read FOnGetLineNumber write FOnGetLineNumber;
    property OnBeforePrint : TBeforePrintEvent read FOnBeforePrint write FOnBeforePrint;

    property ReadOnly : boolean read GetReadOnly write SetReadOnly stored GetSourcePropsStored;
    property Lines : TStrings read GetLines write SetLines stored GetSourcePropsStored;

    property Font : TMemoFont read FFont write SetFont;
    property PrinterFont : TMemoFont read FPrinterFont write SetPrinterFont;
    property TemplateFont : TFont read  FTemplateFont write SetTemplateFont;
    property UsePrinterFont : boolean read FUsePrinterFont write FUsePrinterFont;
    property StringsOptions : TStringsOptions read GetStringsOptions write SetStringsOptions stored GetSourcePropsStored;
    property SyntaxParser : TSimpleParser read GetSyntaxParser write SetSyntaxParser stored GetSourcePropsStored;
    property TabStops : string read GetTabStops write SetTabStops stored GetSourcePropsStored;
    property Delimeters : string read GetDelimiters write SetDelimiters stored GetSourcePropsStored;
    property AllowUndo : boolean read GetAllowUndo write SetAllowUndo default true;
    property UndoLimit : integer read GetUndoLimit write SetUndoLimit default 0;

    property LineNumColor : TColor read FLineNumColor write SetLineNumColor default clWindowText;
    property LineNumAlign : TAlignment read FLineNumAlign write SetLineNumAlign;
    property BlockIndent : integer read GetBlockIndent write SetBlockIndent;
    property GutterBackColor : TColor read FGutterBackColor write SetGutterBackColor;
    property LineBookmarkColor : TColor read FLineBookmarkColor write SetLineBookmarkColor default clRed;


    property Text : {$IFNDEF CLX} string {$ELSE} TCaption {$ENDIF}read GetText write SetText;
    property SelText : string read GetSelText write SetSelText;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property PrintOptions : TDCPrintOptions read FPrintOptions write FPrintOptions;
    property CodeTemplates : TMemoCodeTemplates read GetCodeTemplates write SetCodeTemplates;
    property TemplatesType : string read GetTemplatesType write SetTemplatesType;
    property HideCaret : boolean read FHideCaret write SetHideCaret;
    property LeftIndent : integer read FLeftIndent write SetLeftIndent default 0;
    property PrintIndent : integer read FPrintIndent write FPrintIndent default 0;
    property MemoBackground : TControlBackground read FMemoBackground write SetMemoBackground;
    property Background : TBitmap read GetBackground write SetBackground;
    property BkgndOption : TBkgndOption read GetBkgndOption write SetBkgndOption;
    property GutterBackground : TControlBackground read FGutterBackground write SetGutterBackground;
    property LineNumBackColor : TColor read FLineNumBackColor write SetLineNumBackColor default clWindow;

    property HideScrollBars : boolean read FHideScrollBars write SetHideScrollBars default false;
    property HighlightUrls : boolean read GetHighlightUrls write SetHighlightUrls default false;
    property WordWrap : boolean read FWordWrap write SetWordWrap default false;
    property BlockOption : TBlockOption read GetBlockOption write SetBlockOption default bkBoth;
    property OutFormat : TOutFormatType read GetOutFormat write SetOutFormat default ofWindows;
    property LineSeparator : TLineSeparator read FLineSeparator write SetLineSeparator;
    property LineHighlight : TLineHighlight read FLineHighlight write SetLineHighlight;
    property SpecialSymbols : TSpecialSymbols read FSpecialSymbols write SetSpecialSymbols;
    property UseDefaultMenu : boolean read FUseDefaultMenu write FUseDefaultMenu;

    property MaxLineLen : integer read GetMaxLineLen;
    property GutterLineIndent : integer read FGutterLineIndent write SetGutterLineIndent default 0;
    property HintPause : integer read FHintPause write FHintPause;
    property WordSelectionType : TWordSelectionType read FWordSelectionType write FWordSelectionType default wsWordOnly;
    property UseMonoFont : boolean read FUseMonoFont write SetUseMonoFont default true;
    property SelAttributes : TMemoAttributes read GetSelAttributes write SetSelAttributes;
  published
    property Version : TDCVersion read FVersion write FVersion Stored False;
  end;

  TDCMemo = class(TCustomDCMemo)
  published
    property DisabledColor;
    property ReadOnlyColor;
    property PrintOptions;
    property WantReturns;
    property WantTabs;
    property LineNumColor;
    property LineNumAlign;
    property StringsOptions;
    property SyntaxParser;
    property TabStops;
    property Delimeters;
    property KeyMapping;

    property UseMonoFont;
    property WordSelectionType;
    property AllowUndo;
    property UndoLimit;


    property SelColor;
    property SelBackColor;
    property MatchColor;
    property MatchBackColor;
    property LineBookmarkColor;

    property GutterBackColor;
    property HorzMaxPos;
    property HideSelection;
    property HideScrollBars;
    property MemoSource;
    property BorderStyle;
    property ScrollBars;
    property Options;
    property MarginPos;
    property GutterBrush;
    property MarginPen;
    property GutterLineColor;
    property GutterWidth;
    property GutterImgs;
    property GutterImgsAlign;
    property LeftIndent;
    property PrintIndent;
    property BlockOption;
    property WordWrap;
    property OutFormat;
    property Background;
    property BkgndOption;
    property MemoBackground;
    property GutterBackground;
    property LineSeparator;
    property LineHighlight;
    property SpecialSymbols;
    property LineNumBackColor;
    property GutterLineIndent;
    property UseDefaultMenu;
    property ClipboardType;
    property PlainText;
    {$IFNDEF CLX}
    property OemConvert;
    {$ENDIF}
    property OnGetColorStyle;
    property OnStateChange;
    property OnSelectionChange;
    property OnJumpToUrl;
    property OnClickGutter;
    property OnHintPopup;
    property OnTemplateInsert;
    property OnHintInsert;
    property OnCreateDialog;
    property OnMemoScroll;
    property OnVerticalScroll;

    property OnCustomString;
    property OnCustomDraw;
    property OnDrawGutter;

    property OnCollapseStateChanging;
    property OnCollapseStateChanged;
    property OnExportString;
    property OnFindStringInPopup;
    property OnGetLineNumber;
    property OnBeforePrint;

    property ReadOnly;
    property Lines;
    property Font;
    property TextStyles;
    property PrinterFont;
    property TemplateFont;
    property UsePrinterFont;
    property BlockIndent;
    property SpacesInTab;
    {----------}
    {$IFNDEF CLX}
    property Ctl3D;
    property ParentCtl3D;
    {$ENDIF}
    property Align;
    property ShowHint;
    property Visible;
    property Enabled;
    property ParentColor default false;//before color!!
    property Color;
    {$IFNDEF CLX}
    property DragCursor;
    {$ENDIF}
    property DragMode;
    property ParentShowHint;
    property PopupMenu;
    {$IFDEF D4}
    property Anchors;

    {$IFNDEF CLX}
    property AutoSize;
    property BiDiMode;
    {$ENDIF}
    property Constraints;
    {$IFNDEF CLX}
    property UseDockManager default true;
    property DockSite;
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    {$ENDIF}
    {$IFDEF D5}
    property OnContextPopup;  
    {$ENDIF}

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property TabOrder;
    property TabStop;
    {$IFDEF D4}
    {$IFNDEF CLX}
    property OnCanResize;
    {$ENDIF}
    property OnConstrainedResize;
    {$IFNDEF CLX}
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
    {$ENDIF}
    property OnChange;
    property CodeTemplates;
    property TemplatesType;
    property HideCaret;
    property HighlightUrls;
    property Version stored false;
    property UseGlobalOptions;//This must be the last property
  end;

  TMemoEnvOptions = class(TOptionExt)
  private
    FMarginPos     : TMarginPos;
    FGutterWidth   : TGutterWidth;
    FOptions       : TMemoOptions;
    FKeyMapping    : string;
    FGutterBrush   : TBrush;
    FMarginPen     : TPen;
    FLineSeparator : TLineSeparator;
    FLineHighLight : TLineHighLight;
    FFont          : TMemoFont;
    FColor         : TColor;
    FTextStyles    : TTextStyles;
    FDisableUpdate : boolean;
    FUseMonoFont   : Boolean;
    FReadOnlyColor : TColor;
    FSpecSymbols   : TSpecialSymbols;
    FColorSchema   : string;
    procedure SetMarginPos(V : TMarginPos);
    procedure SetTextStyles(V : TTextStyles);
    procedure SetGutterWidth(V : TGutterWidth);
    procedure SetOptions(V : TMemoOptions);
    procedure SetKeyMapping(const V : string);
    procedure SetGutterBrush(V : TBrush);
    procedure SetMarginPen(V : TPen);
    procedure SetLineSeparator(Value : TLineSeparator);
    procedure SetLineHighlight(Value : TLineHighlight);
    procedure SetFont(V : TMemoFont);
    procedure SetColor(V : TColor);
    Procedure SetUseMonoFont(Value:Boolean);
    procedure OnNeedUpdate(Sender : TObject);
    procedure SetReadOnlyColor(V: TColor);
    procedure SetSpecSymbols(V: TSpecialSymbols);
  protected
    procedure cmSaveColorStyles(var Message: TMessage); message cm_SaveColorStyles;
    procedure cmLoadColorStyles(var Message: TMessage); message cm_LoadColorStyles;
  public
    constructor Create; override;
    destructor Destroy;override;
    procedure Update; override;
    function  GetKey : string; override;
    procedure InitValues; override;
  published
    property Options : TMemoOptions read FOptions write SetOptions;
    property KeyMapping : string read FKeyMapping write SetKeyMapping;
    property MarginPos : TMarginPos read FMarginPos write SetMarginPos;
    property GutterWidth : TGutterWidth read FGutterWidth write SetGutterWidth;
    property GutterBrush : TBrush read FGutterBrush write SetGutterBrush;
    property MarginPen : TPen read FMarginPen write SetMarginPen;
    property LineSeparator : TLineSeparator read FLineSeparator write SetLineSeparator;
    property LineHighlight : TLineHighlight read FLineHighlight write SetLineHighlight;
    property Font : TMemoFont read FFont write SetFont;
    property TextStyles : TTextStyles read FTextStyles write SetTextStyles;
    property Color : TColor read FColor write SetColor;
    property UseMonoFont : Boolean read FUseMonoFont write SetUseMonoFont default True;
    property ReadOnlyColor : TColor read FReadOnlyColor write SetReadOnlyColor;
    property SpecialSymbols : TSpecialSymbols read FSpecSymbols write SetSpecSymbols;
    property ColorSchema : string read FColorSchema write FColorSchema;
  end;

function  MemoList : TList;
function  EnvOptObjectList: TList;
procedure RegisterMemoEnvOptObject(AObj: TObject);
procedure UnRegisterMemoEnvOptObject(AObj: TObject);
function  GlobalMemoOptions : TMemoEnvOptions;
procedure GetConnectedMemos(S : TCustomMemoSource; L : TList);
function  GetConnectedMemo(S : TCustomMemoSource) : TCustomDCMemo;
function  GetConnectedMemoCount(S : TCustomMemoSource) : integer;
{$IFNDEF CLX}
procedure ImageListToGutterImages(ImageList : TImageList; GutterImages: TDCGutterImages);
{$ENDIF}
procedure InitDefaultKeyboard(Instance : TObject);
procedure InitClassicKeyboard(Instance : TObject);
procedure InitBriefKeyboard(Instance : TObject);
procedure InitEpsilonKeyboard(Instance : TObject);

procedure EnumTextStyles(Proc: TGetStrProc);
procedure RemoveExtraStyles;

{-------------------------------------------------------------}

implementation

uses
  Printers, dcMemoPg, dcMemoPr, searrepldlg, dcinpfrm;

const
  cGutterImageHeight = 15;
  cGutterImageWidth = 15;
  cDragDropTimer = 1;
  cHintTimer = 2;
  sDotStr = '...';
  cDotStrLen = 3;
  MaxPaint = 512;
  {$IFDEF CLX}
  ETO_OPAQUE = 1;
  SB_BOTTOM  = 7;
  SB_LINELEFT = 0;
  SB_LINERIGHT = 1;
  SB_PAGELEFT = 2;
  SB_PAGERIGHT = 3;
  SB_TOP = 6;
  SB_THUMBPOSITION = 4;
  SB_THUMBTRACK = 5;
  SB_LINEUP = 0;
  SB_LINEDOWN = 1;
  SB_PAGEUP = 2;
  SB_PAGEDOWN = 3;
  SB_HORZ = 0;
  SB_VERT = 1;
  SB_ENDSCROLL = 8;
  isAltKeyDown = false;
  DragCursor = crDrag;
  sScrollBarSize = 16;
  CF_RTF : string = 'DC_RTF';
  CM_ENTER = CM_BASE + 26;
  CM_EXIT  = CM_BASE + 27;
  WM_LBUTTONDBLCLK = $0203;
  SPI_GETWHEELSCROLLLINES = 3;
  cCaretInterval = 500;
  {$ELSE}
  CF_RTF : cardinal = 0;
  {$ENDIF}
{-------------------------------------------------------------}

type
  TMSource = class(TCustomMemoSource);
  TMCanvas = class(TCanvas);
  TMWinControl = class(TWinControl);

  TPopupHint = class(TDCHint)
  protected
    function IsHintInRect(R : TRect; Point : TPoint) : boolean; override;
  end;
  
var
  FMemoList : TList = nil;
  FEnvOptObjectList: TList = nil;

function MemoList : TList;
begin
  if FMemoList = nil then
    FMemoList := TList.Create;
  Result := fMemoList;
end;

{-------------------------------------------------------------}

function EnvOptObjectList: TList;
begin
  if FEnvOptObjectList = nil then
    FEnvOptObjectList := TList.Create;
  Result := FEnvOptObjectList;
end;

{-------------------------------------------------------------}

procedure RegisterMemoEnvOptObject(AObj: TObject);
begin
  with EnvOptObjectList do
    if IndexOf(AObj) < 0 then
      Add(AObj);
end;

{-------------------------------------------------------------}

procedure UnRegisterMemoEnvOptObject(AObj: TObject);
begin
  EnvOptObjectList.Remove(AObj);
end;

{-------------------------------------------------------------}

function RtfClipboard : boolean;
begin
  {$IFNDEF CLX}
  result := Clipboard.HasFormat(CF_RTF);
  {$ELSE}
  result := false;
  {$ENDIF}
end;

{-------------------------------------------------------------}

function  GetConnectedMemo(S : TCustomMemoSource) : TCustomDCMemo;
var
  i : integer;
begin
  for i := 0 to MemoList.Count - 1 do
    if TCustomDCMemo(MemoList[i]).GetSource = S then
    begin
      result := MemoList[i];
      exit;
    end;
  result := nil;
end;

{-------------------------------------------------------------}

procedure GetConnectedMemos(S : TCustomMemoSource; L : TList);
var
  i:integer;
begin
  with L do
  begin
    Clear;
    for i := 0 to MemoList.Count - 1 do
      if TCustomDCMemo(MemoList[i]).GetSource = S then
        Add(MemoList[i]);
  end;
end;

{-------------------------------------------------------------}

function GetConnectedMemoCount(S : TCustomMemoSource) : integer;
var
  i:integer;
begin
  result := 0;
  for i := 0 to MemoList.Count - 1 do
    if TCustomDCMemo(MemoList[i]).GetSource = S then
      inc(result);
end;

{-------------------------------------------------------------}
{$IFNDEF CLX}
procedure ImageListToGutterImages(ImageList : TImageList; GutterImages: TDCGutterImages);
var
  i      : integer;
  Bitmap : TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    GutterImages.Clear;
    with ImageList do
      for i := 0 to Count - 1 do
      begin
        GetBitmap(i, Bitmap);
        with TGutterImage(GutterImages.Add) do
          Glyph := Bitmap;
      end;
  finally
    Bitmap.Free;
  end;
end;
{$ENDIF}
{-------------------------------------------------------------}

procedure PaintGutterLine(Canvas : TCanvas; R : TRect; X : integer; ABkColor, AColor : TColor);
begin
  with Canvas, R do
  begin
    with Pen do
    begin
      Style := psSolid;
      Width := 1;
      Color := ABkColor;
    end;
    MoveTo(X, Top);
    LineTo(X, Bottom + 1);
    inc(X);
    Pen.Color := AColor;
    MoveTo(X, Top);
    LineTo(X, Bottom + 1);
  end;
end;

{---------TWordWrapList--------------------------------------------}


function  TWordWrapList.Compare(Item1, Item2 : Pointer) : integer;
begin
  if FCheckIndex then
    result := PWBPoint(Item1)^.Y + CurrentIndex + 1 - PWBPoint(Item2)^.Y
  else
  begin
    result := PWBPoint(Item1)^.Y - PWBPoint(Item2)^.Y;
    if result = 0 then
      result := PWBPoint(Item1)^.X - PWBPoint(Item2)^.X;
  end;
end;

{------------------------------------------------------------------}

function  TWordWrapList.FindNear(Item : PWBPoint; CheckIndex : boolean; var Exact : boolean) : integer;
var
  ALine : integer;
begin
  result := -1;
  FCheckIndex := CheckIndex;
  try
    Exact := FindNearest(Item, result);
    if not Exact then
    begin
      if (result >= 0) and (result < Count - 1) then
        inc(result);
      while (result >= 0) and (result < Count) do
        with PWBPoint(Items[result])^ do
        begin
          ALine := Y;
          if CheckIndex then
            inc(ALine, result + 1);

          Exact := ALine = Item^.Y;

          if ALine < Item^.Y then
            break
          else
          if  CheckIndex then
          begin
            if Exact then
              break;
          end
          else
          if Exact and (X <= Item^.X) then
            break;

          dec(result);
        end;
    end;
    if result >= Count then
      result := -1;
  finally
    FCheckIndex := false;
  end;
end;

{------------------------------------------------------------------}

procedure TWordWrapList.ClearRange(FromIndex, ToIndex : integer);
var
  WB    : TWBPoint;
  Index : integer;
  ALine : integer;
  Exact : boolean;
begin
  if (FromIndex > ToIndex) then
    exit;
  WB.X := 0;
  WB.Y := ToIndex + 1;
  if ToIndex = MaxInt then
    Index := Count - 1
  else
    Index := FindNear(@WB, false, Exact);
  while (Index >=0) and (Index < Count) do
  begin
    ALine := PWBPoint(Items[Index])^.Y;
    if (ALine >= FromIndex) and (ALine <= ToIndex) then
    begin
      dispose(Items[Index]);
      Delete(Index)
    end
    else
      break;
    dec(Index);
  end;
end;

{------------------------------------------------------------------}

procedure TLineInfoList.ClearRange(FromIndex, ToIndex : integer);
var
  WB    : TWBPoint;
  Index : integer;
  ALine : integer;
  Exact : boolean;
begin
  if (FromIndex > ToIndex) then
    exit;
  WB.X := 0;
  WB.Y := ToIndex;
  Index := FindNear(@WB, false, Exact);
  while (Index >=0) and (Index < Count) do
  begin
    ALine := PWBPoint(Items[Index])^.Y;
    if (ALine >= FromIndex) and (ALine <= ToIndex) then
    begin
      dispose(Items[Index]);
      Delete(Index)
    end
    else
      break;
    dec(Index);
  end;
end;

{------------------------------------------------------------------}


const
  CDefaultMarginPos = 80;
  CDefaultGutterWidth = 32;
  cMaxGutterImages = 16;
  cMaxMarginWidth = 2;

{$R dcmemo.res}

{--------------------------------------------}

procedure AssignDefaultGutterBrush(Brush : TBrush ; Change : TNotifyEvent);
begin
  with Brush do
  begin
    Color := clBtnFace;
    Style := bsSolid;
    OnChange := Change;
  end;
end;

{--------------------------------------------}

procedure AssignDefaultMemoFont(Font : TMemoFont; Change : TNotifyEvent);
begin
  with Font do
  begin
    Name := 'Courier New'; //don't resource
    Size := 10;
    Color := clBlack;
    OnChange := Change;
  end;
end;

{--------------------------------------------}

procedure AssignDefaultMarginPen(Pen : TPen; Change : TNotifyEvent);
begin
  with Pen do
  begin
    Width := 1;
    Style := psSolid;
    Color := clGrayText;
    OnChange := Change;
  end;
end;


{---------TMemoEnvOptions-------------------------------------}

procedure TMemoEnvOptions.SetTextStyles(V : TTextStyles);
begin
  FTextStyles.Assign(V);
  Update;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetColor(V : TColor);
begin
  if FColor <> V then
  begin
    FColor := V;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetReadOnlyColor(V: TColor);
begin
  if FReadOnlyColor <> V then
  begin
    FReadOnlyColor := V;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetSpecSymbols(V: TSpecialSymbols);
begin
  FSpecSymbols.Assign(V);
  Update;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetFont(V : TMemoFont);
begin
  FFont.Assign(V);
  Update;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetGutterBrush(V : TBrush);
begin
  FGutterBrush.Assign(V);
  Update;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetMarginPen(V : TPen);
begin
  FMarginPen.Assign(V);
  FMarginPen.Width := Min(FMarginPen.Width, CMaxMarginWidth);
  Update;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetLineSeparator(Value : TLineSeparator);
begin
  FLineSeparator.Assign(Value);
  with FLineSeparator.FPen do
    Width := Min(Width, CMaxMarginWidth);
  Update;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetLinehighlight(Value : TLineHighlight);
begin
  FLinehighlight.Assign(Value);
  with Linehighlight.FPen do
    Width := Min(Width, CMaxMarginWidth);
  Update;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetMarginPos(V : TMarginPos);
begin
  if FMarginPos<>V then
  begin
    FMarginPos := V;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetGutterWidth(V : TGutterWidth);
begin
  if FGutterWidth <> V then
  begin
    FGutterWidth := V;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetOptions(V : TMemoOptions);
begin
  if FOptions <> V then
  begin
    FOptions := V;
    Update;
  end;
end;


{------------------------------------------------------------------}

Procedure TMemoEnvOptions.SetUseMonoFont(Value:Boolean);
Begin
  If FUseMonoFont=Value Then
    Exit;
  FUseMonoFont:=Value;
  Update;  
End;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.OnNeedUpdate(Sender : TObject);
begin
  if not FDisableUpdate then
    Update;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.InitValues;
begin
  FDisableUpdate := true;
  try
    FMarginPos := CDefaultMarginPos;
    FGutterWidth := CDefaultGutterWidth;
    FOptions := [moDrawMargin, moDrawGutter, moThumbTracking, moColorSyntax];
    FKeyMapping := ResStr(SDefault);
    AssignDefaultGutterBrush(FGutterBrush, OnNeedUpdate);
    AssignDefaultMarginPen(FMarginPen, OnNeedUpdate);
    AssignDefaultMarginPen(FLineSeparator.FPen, OnNeedUpdate);
    AssignDefaultMarginPen(FLineHighlight.FPen, OnNeedUpdate);
    AssignDefaultGutterBrush(FLineHighlight.Brush, OnNeedUpdate);
    AssignDefaultMemoFont(FFont, OnNeedUpdate);
    FColor := clWindow;
    FTextStyles.SetDefaultStyles;
    FTextStyles.OnChange := OnNeedUpdate;
    FUseMonoFont:=True;
    FReadOnlyColor := clWindow;
    with FSpecSymbols do
    begin
      FEOLString := #182;
      FEOFString := '_';
      FSpaceChar := #0;
      FTabChar := #0;
    end;
  finally
    FDisableUpdate := false;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.SetKeyMapping(const V : string);
begin
  if FKeyMapping <> V then
  begin
    FKeyMapping := V;
    Update;
  end;
end;

{------------------------------------------------------------------}

constructor TMemoEnvOptions.Create;
begin
  FGutterBrush := TBrush.Create;
  FMarginPen := TPen.Create;
  FLineSeparator := TLineSeparator.Create(nil);
  FLineHighlight := TLineHighlight.Create(nil);
  FFont := TMemoFont.Create(Self);
  FTextStyles := TTextStyles.Create(nil, TTextStyle);
  FSpecSymbols := TSpecialSymbols.Create(nil);
  inherited Create;
end;

{------------------------------------------------------------------}

destructor TMemoEnvOptions.Destroy;
begin
  FGutterBrush.Free;
  FMarginPen.Free;
  FLineSeparator.Free;
  FLineHighlight.Free;
  FFont.Free;
  FTextStyles.Free;
  FSpecSymbols.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TMemoEnvOptions.Update;
var
  i: integer;
  AMsg: TMessage;
begin
  if UpdateDisabled then
    exit;

  AMsg.Msg := CM_UPDATEOPTIONS;
  with EnvOptObjectList do
    for i := 0 to Count - 1 do
      TObject(Items[i]).Dispatch(AMsg);

  {with MemoList do
    for i := 0 to Count - 1 do
      with TCustomDCMemo(Items[i]) do
        if UseGlobalOptions then
          LoadGlobalOptions;}
end;

{------------------------------------------------------------------}

function  TMemoEnvOptions.GetKey : string;
begin
  result := 'CodeEdit\'; //don't resource
end;

{------------------------------------------------------------------}

function GlobalMemoOptions : TMemoEnvOptions;
begin
  result := TMemoEnvOptions(GetOptionsByClass(TMemoEnvOptions));
end;

{------------------------------------------------------------------}

constructor TMemoFont.Create(AOwner : TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
end;

{-------TGutterBackground-------------------------------------}

function  TGutterBackground.GetPaintRect : TRect;
begin
 with TCustomDCMemo(Owner) do
   if HandleAllocated then
     result := Rect(0, 0, GetRealGutterWidth, ClientHeight + 1)
   else
     result := Rect(0, 0, 0, 0);
end;

{------------------------------------------------------------------}

function  TGutterBackground.GetPaintBrush : TBrush;
begin
  result := TCustomDCMemo(Owner).GutterBrush;
end;

{------------------------------------------------------------------}

procedure TGutterBackground.PaintBackground;
var
  X : integer;
  R : TRect;
begin
  inherited PaintBackground;
  if NeedPaint then
    with TCustomDCMemo(Owner) do
    begin
      X := Self.TempBackground.Width - 2;
      R := Rect(0, 0, X + 2, ClientHeight + 1);
      PaintGutterLine(Self.TempBackground.Canvas, R, X, FGutterBackColor, FGutterLineColor);
    end;
end;

{---------TLineSeparator-------------------------------------------}

procedure TLineSeparator.SetPen(Value : TPen);
begin
  FPen.Assign(Value);
  FPen.Width := Min(FPen.Width, CMaxMarginWidth);
end;

{------------------------------------------------------------------}

procedure TLineSeparator.SetOptions(Value : TSeparatorOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    if (FMemo <> nil) then
      FMemo.Invalidate;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TLineSeparator.PenChanged(Sender : TObject);
begin
  if FPen.Width > CMaxMarginWidth then
    FPen.Width := CMaxMarginWidth
  else
    Update;
end;

{------------------------------------------------------------------}

constructor TLineSeparator.Create(Memo : TCustomDCMemo);
begin
  inherited Create;
  FMemo := Memo;
  FPen := TPen.Create;
end;

{------------------------------------------------------------------}

destructor TLineSeparator.Destroy;
begin
  FPen.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TLineSeparator.Update;
begin
  if (FMemo <> nil) and (moDrawLineSeparator in FOptions) then
    FMemo.Invalidate;
end;

{------------------------------------------------------------------}

procedure TLineSeparator.Assign(Source : TPersistent);
begin
  if Source is TLineSeparator then
    with TLineSeparator(Source) do
    begin
      Self.Options := Options;
      Self.Pen := Pen;
    end
  else
    inherited Assign(Source);
end;

{-------------------------------------------------------------}

function TPopupHint.IsHintInRect(R : TRect; Point : TPoint) : boolean;
begin
  result := true;
end;

{---------TLineHighlighter-------------------------------------}

procedure TLineHighlight.SetVisible(Value : boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Update;
  end;
end;

{-------------------------------------------------------------}

procedure TLineHighlight.SetPen(Value : TPen);
begin
  FPen.Assign(Value);
end;

{-------------------------------------------------------------}

procedure TLineHighlight.SetBrush(Value : TBrush);
begin
  FBrush.Assign(Value);
end;

{-------------------------------------------------------------}

procedure TLineHighlight.SetShape(Value : TShapeHighlightType);
begin
  if FShape <> Value then
  begin
    FShape := Value;
    Update;
  end;
end;

{-------------------------------------------------------------}

constructor TLineHighlight.Create(Memo : TCustomDCMemo);
begin
  inherited Create;
  FMemo := Memo;
  FPen := TPen.Create;
  FPen.OnChange := PenChanged;
  FBrush := TBrush.Create;
  FBrush.OnChange := BrushChanged;
end;

{-------------------------------------------------------------}

destructor TLineHighlight.Destroy;
begin
  FPen.Free;
  FBrush.Free;
  inherited Destroy;
end;

{-------------------------------------------------------------}

procedure TLineHighlight.Update;
begin
  if FMemo <> nil then
    with FMemo , CaretPoint do
      InvalidateLines(Y, Y, false);
end;

{-------------------------------------------------------------}

procedure TLineHighlight.PenChanged(Sender : TObject);
begin
  if FPen.Width > CMaxMarginWidth then
    FPen.Width := CMaxMarginWidth
  else
    Update;
end;

{-------------------------------------------------------------}

procedure TLineHighlight.BrushChanged(Sender : TObject);
begin
  Update;
end;

{-------------------------------------------------------------}

procedure TLineHighlight.Assign(Source : TPersistent);
begin
  if Source is TLineHighlight then
    with TLineHighlight (Source) do
    begin
      Self.Visible := Visible;
      Self.Pen := Pen;
      Self.Brush := Brush;
    end
  else
    inherited Assign(Source);
end;

{-------------------------------------------------------------}

procedure D6WriterWriteStr(const LocaleStr:String;Writer:TStream);
var
  L:Integer;
begin
  With Writer do
  begin
    L := Length(LocaleStr);
    Write(L, SizeOf(Integer));
    Write(Pointer(@LocaleStr[1])^, L);
  end;
end;

{-------------------------------------------------------------}

function D6ReaderReadStr(Reader:TStream):String;
var
  L: Integer;
begin
  L := 0;
  With Reader do
  begin
    Read(L, SizeOf(Integer));
    SetLength(Result, L);
    Read(Pointer(@Result[1])^, L);
  end;
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.ReadEOLStringData(Reader: TStream);
begin
  EOLString:=D6ReaderReadStr(Reader);
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.WriteEOLStringData(Writer: TStream);
begin
  D6WriterWriteStr(EOLString,Writer);
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.ReadEOFStringData(Reader: TStream);
begin
  EOFString:=D6ReaderReadStr(Reader);
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.WriteEOFStringData(Writer: TStream);
begin
  D6WriterWriteStr(EOFString,Writer);
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.DefineProperties(Filer: TFiler);
begin
  Filer.DefineBinaryProperty('EOLStringBinary', ReadEOLStringData, WriteEOLStringData, True);
  Filer.DefineBinaryProperty('EOFStringBinary', ReadEOFStringData, WriteEOFStringData, True);
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.SetEOLString(Value : string);
begin
  if FEOLString <> Value then
  begin
    FEOLString := Value;
    Update;
  end;
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.SetEOFString(Value : string);
begin
  if FEOFString <> Value then
  begin
    FEOFString := Value;
    Update;
  end;
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.SetTabChar(Value : char);
begin
  if FTabChar <> Value then
  begin
    FTabChar := Value;
    Update;
  end;
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.SetSpaceChar(Value : char);
begin
  if FSpaceChar <> Value then
  begin
    FSpaceChar := Value;
    Update;
  end;
end;

{-------------------------------------------------------------}

constructor TSpecialSymbols.Create(Memo : TCustomDCMemo);
begin
  inherited Create;
  FMemo := Memo;
  FEOLString := #182;
  FEOFString := '_';
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.Update;
begin
  if (FMemo <> nil) and (moDrawSpecialSymbols in FMemo.Options) then
    FMemo.Invalidate;
end;

{-------------------------------------------------------------}

procedure TSpecialSymbols.Assign(Source : TPersistent);
begin
  if Source is TSpecialSymbols then
    with TSpecialSymbols(Source) do
    begin
      Self.FEOLString := EOLString;
      Self.FEOFString := EOFString;
      Self.SpaceChar := SpaceChar;
      Self.TabChar := TabChar;
      Self.Update;
    end;
end;

{$IFDEF CLX}

{------TCLXCaret----------------------------------------------}

constructor TCLXCaret.Create(Memo : TCustomDCMemo);
begin
  inherited Create;
  FOwner := Memo;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := false;
  FTimer.Interval := cCaretInterval;
  FTimer.OnTimer := TimerOnTimer;
end;

{-------------------------------------------------------------}

procedure TCLXCaret.SetCaretPos(X, Y : integer);
begin
  if FTimer.Enabled then
  begin
    HideCaret;
    FCaretPos := Point(X, Y);
    FCaretVisible := true;
    FTimer.Enabled := false;
    FTimer.Enabled := true;
    ShowCaret;
  end
  else
    FCaretPos := Point(X, Y);
end;

{-------------------------------------------------------------}

destructor  TCLXCaret.Destroy;
begin
  FTimer.Free;
  inherited Destroy;
end;

{-------------------------------------------------------------}

procedure TCLXCaret.TimerOnTimer(Sender : TObject);
begin
  if (FOwner <> nil) and FOwner.HandleAllocated and FOwner.Focused then
  begin
    if not FCaretVisible then
      ShowCaret
    else
      HideCaret;
  end    
  else
    FCaretVisible := false;
end;

{-------------------------------------------------------------}

procedure TCLXCaret.ShowCaret;
begin
  FCaretVisible := true;
  InvalidateCaret;
end;

{-------------------------------------------------------------}

procedure TCLXCaret.PaintCaret;
var
  R        : TRect;
  OldColor : TColor;
  OldMode  : TPenMode;
  i        : integer;
begin
  if FCaretVisible then
  begin
    R := CaretRect;
    with FOwner.Canvas do
    begin
      OldColor :=  Brush.Color;
      Pen.Color := clWindow;
      OldMode := Pen.Mode;
      Pen.Mode := pmXor;
      for i := R.Left to R.Right do
      begin
        MoveTo(i, R.Top);
        LineTo(i, R.Bottom);
      end;
      Pen.Color := OldColor;
      Pen.Mode := OldMode;
    end;
  end;
end;

{-------------------------------------------------------------}

function TCLXCaret.CaretRect : TRect;
begin
  with FCaretPos do
    result := Rect(X, Y, X + FCaretSize.X - 1, Y + FCaretSize.Y - 1);
end;

{-------------------------------------------------------------}

procedure TCLXCaret.InvalidateCaret;
var
  R : TRect;
begin
  R := CaretRect;
  inc(R.Right);
  FOwner.InvalidateRect(R, true);
end;

{-------------------------------------------------------------}

procedure TCLXCaret.HideCaret;
begin
  FCaretVisible := false;
  InvalidateCaret;
end;

{-------------------------------------------------------------}

procedure TCLXCaret.EnableCaret;
begin
  FTimer.Enabled := true;
  ShowCaret;
end;

{-------------------------------------------------------------}

procedure TCLXCaret.DisableCaret;
begin
  FTimer.Enabled := false;
  HideCaret;
end;

{$ENDIF}
{---------TCustomDCMemo----------------------------------------}

procedure TCustomDCMemo.SetHideCaret(V : boolean);
begin
  if FHideCaret <> V then
  begin
    FHideCaret := V;
    UpdateCaret;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetDisabledColor(V : TColor);
begin
  if FDisabledColor <> V then
  begin
    FDisabledColor := V;
    if not Enabled then
      Invalidate;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetReadOnlyColor(V : TColor);
begin
  if FReadOnlyColor <> V then
  begin
    FReadOnlyColor := V;
    if ReadOnly then
      Invalidate;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.PromptedGotoLine;
var
  P : integer;
begin
  P := GetSource.CurLinePos + 1;
  if ReadIntegerDialog(SCapGotoLineNumber, SCapEnterNewLine, 0, Self, TMethod(FOnCreateDialog), P) then
    CenteredJumpTo(0, P - 1);
end;

{--------------------------------------------}

procedure TCustomDCMemo.CenteredJumpTo(X, Y : integer);
begin
  with GetSource do
  try
    BeginUpdate(acNavigate);
    JumpTo(X, Y);
    CenterScreenOnLine;
  finally
    EndUpdate;
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.GetText : {$IFNDEF CLX} string {$ELSE} TCaption {$ENDIF};
begin
  result := Lines.Text;
end;

{--------------------------------------------}

function TCustomDCMemo.SelLength : integer;
begin
  result := Length(SelText);
end;

{--------------------------------------------}

function TCustomDCMemo.GetSelText : string;
begin
  result := GetSource.SelStrings.Text;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetText(const V : {$IFNDEF CLX} string {$ELSE} TCaption {$ENDIF});
begin
  Lines.Text := V;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetSelTextBuf(Buffer : PChar);
begin
  SetSelText(Buffer);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetSelText(const V : string);
begin
  with GetSource do
  begin
    BeginUpdate(acChangeBlockTo);
    DeleteBlock;
    InsertString(V);
    EndUpdate;
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.GetStringsOptions : TStringsOptions;
begin
  result := GetSource.Options;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetStringsOptions(V : TStringsOptions);
begin
  GetSource.Options := V;
end;

{--------------------------------------------}

function TCustomDCMemo.GetSyntaxParser : TSimpleParser;
begin
  result := GetSource.SyntaxParser;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetSyntaxParser(V : TSimpleParser);
begin
  GetSource.SyntaxParser := V;
end;

{--------------------------------------------}

function TCustomDCMemo.GetTabStops : string;
begin
  result := GetSource.TabStops;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetTabStops(const V : string);
begin
  GetSource.TabStops := V;
end;

{--------------------------------------------}

function TCustomDCMemo.GetDelimiters : string;
begin
  result := GetSource.Delimeters;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetDelimiters(const V : string);
begin
  GetSource.Delimeters := V;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetMemoBackground(Value : TControlBackground);
begin
  FMemoBackground.Assign(Value);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetGutterBackground(Value : TControlBackground);
begin
  FGutterBackground.Assign(Value);
end;

{--------------------------------------------}

function TCustomDCMemo.GetSourcePropsStored : boolean;
begin
  result := FMemoSource = nil;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetBlockIndent : integer;
begin
  result := GetSource.BlockIndent;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetBlockIndent(Value : integer);
begin
  GetSource.BlockIndent := Value;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetOutFormat : TOutFormatType;
begin
  result := GetSource.OutFormat;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetOutFormat(Value : TOutFormatType);
begin
  GetSource.OutFormat := Value;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetClipboardType(Value : TClipboardType);
begin
  if FClipboardType <> Value then
  begin
    FClipboardType := Value;
    if not (csDesigning in ComponentState) then
      GetSelAttributes;
  end;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetPlainText : boolean;
begin
  result := FClipboardType = cbNormal;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetPlainText(Value : boolean);
begin
  if Value then
    ClipboardType := cbNormal
  else
    ClipboardType := cbRtf;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetMaxLineLen : integer;
begin
  result := TMSource(GetSource).MaxLineLen;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetLineSeparator(Value : TLineSeparator);
begin
  FLineSeparator.Assign(Value);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetLineHighlight(Value : TLineHighLight);
begin
  FLineHighLight.Assign(Value);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetSpecialSymbols(Value : TSpecialSymbols);
begin
  FSpecialSymbols.Assign(Value);
end;

{--------------------------------------------}

function  TCustomDCMemo.GetSpacesInTab : integer;
begin
  result := GetSource.SpacesInTab;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetSpacesInTab(Value : integer);
begin
  GetSource.SpacesInTab := Value;
end;

{--------------------------------------------}

function  TCustomDCMemo.MoveBlockToPosEx(DeleteOrigin : boolean) : boolean;
var
  Stream     : TMemoryStream;
  OldSelType : TClipFormat;
  TempPos    : TPosition;
begin
  with GetSource, CaretPoint do
    result := not IsPosInBlock(X, Y);
  if not result then
    exit;

  if (FClipboardType = cbRtf) and ((SyntaxParser = nil) or (SyntaxParser is TAttributeParser)) then
  begin
    Stream := TMemoryStream.Create;
    with TMSource(GetSource) do
      try
        ExportToRtfStreamEx(Stream, true);
        OldSelType := ClipSelType;
        if SelectionType = stStreamSel then
          ClipSelType := cfStreamSel
        else
          ClipSelType := cfBlockSel;
        try
          BeginUndoBlock;
          try
            TempPos := CopyCurrent;
            if DeleteOrigin then
              DeleteBlock;
            RestorePosition(TempPos);
            Stream.Seek(0, 0);
            PasteFromRtfStream(Stream);
          finally
            EndUndoBlock;
          end;  
        finally
          ClipSelType := OldSelType;
        end;
      finally
        Stream.Free;
      end;
  end
  else
    if DeleteOrigin then
      result := GetSource.MoveBlock
    else
      result := GetSource.CopyBlockToPos;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CopyToClipboard;
var
  Stream : TMemoryStream;
  ch     : char;
begin
  GetSource.CopyBlock;
  if FClipboardType = cbRtf then
  begin
    with GetSource do
      if (SelectionType <> stNotSelected) then
      begin
        Stream := TMemoryStream.Create;
        try
          ExportToRtfStreamEx(Stream, true);
          ch := #0;
          Stream.Write(ch, 1);
          SetClipboardBuffer(CF_RTF, Stream.Memory^, Stream.Size);
          if SelectionType = stStreamSel then
            ClipSelType := cfStreamSel
          else
            ClipSelType := cfBlockSel;
        finally
          Stream.Free;
        end;
     end;
  end;

end;

{--------------------------------------------}

procedure TCustomDCMemo.CutToClipboard;
begin
  with GetSource do
  begin
    BeginUpdate(acCutBlock);
    try
      CopyToClipboard;
      DeleteBlock;
    finally
      EndUpdate;
    end;  
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.PasteFromClipboard;
var
  Stream : TMemoryStream;
  Sl     : TStrings;
begin
  if ReadOnly then
    exit;
  if (FClipboardType = cbRtf) and RtfClipboard and ((SyntaxParser = nil) or (SyntaxParser is TAttributeParser)) then
  begin
    GetSource.CheckOverwriteBlock;
    Stream := TMemoryStream.Create;
    try
      GetClipboardBuffer(CF_RTF, Stream);
      {$IFNDEF CLX}
      if GetClipboardOwner <> Application.Handle then
      {$ENDIF}
         ClipSelType := cfStreamSel;
      PasteFromRtfStream(Stream);
      with TMSource(GetSource) do
        if Assigned(OnPasteFromClipboard) then
        begin
          Sl := TStringList.Create;
          try
            Stream.Seek(0, 0);
            Sl.LoadFromStream(Stream);
            PasteFromClipboard(Sl);
          finally
            Free;
          end;
      end;
    finally
      Stream.Free;
    end;
  end
  else
    GetSource.PasteBlock;
end;

{--------------------------------------------}
{$IFNDEF CLX}
procedure TCustomDCMemo.WMCLEAR(var Msg : TMessage);
begin
  GetSource.Clear;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMCOPY(var Msg : TMessage);
begin
  CopyToClipboard;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMPASTE(var Msg : TMessage);
begin
  PasteFromClipboard;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMCUT(var Msg : TMessage);
begin
  CutToClipboard;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMUNDO(var Msg : TMessage);
begin
  GetSource.Undo;
end;

{--------------------------------------------}

procedure TCustomDCMemo.EMUNDO(var Msg : TMessage);
begin
  GetSource.Undo;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CMENTER(var Msg : TMessage);
begin
  if NotifySource(msg) then
    inherited;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CMEXIT(var Msg : TMessage);
begin
  try
    if NotifySource(msg) then
      inherited;
  except
    SetFocus;
    raise;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CMMOUSELEAVE(var Message: TMessage);
begin
  inherited;
  HidePopupHint;
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

{--------------------------------------------}

procedure TCustomDCMemo.CMUpdateOptions(var Message: TMessage);
begin
  if UseGlobalOptions then
    LoadGlobalOptions;
end;

{--------------------------------------------}
{$ENDIF}

procedure TCustomDCMemo.KillHintTimer;
begin
  {$IFNDEF CLX}
  Windows.KillTimer(Handle, cHintTimer);
  {$ELSE}
  FHintTimer.Enabled := false;
  {$ENDIF}
  if FPopupHint.AutoHide then
    HidePopupHint;
  FNeedUpdateSel := false;
  FSelUpdated := false;
end;


{--------------------------------------------}

procedure TCustomDCMemo.KeyPress(var Key: Char);
var
  NeedPopup : boolean;
begin
  NeedPopup := (Key >= #32) and Assigned(FOnHintPopup) and ((FPopupListBox = nil) or not (FPopupListBox.Visible));
  inherited;
  {$IFDEF DCMBCS}
  NeedPopup := NeedPopup and (ImeCount = 0);
  {$ENDIF}
  KillHintTimer;
  if NeedPopup then
  begin
    FHintPos := CaretPoint;
    {$IFNDEF CLX}
    SetTimer(Handle, cHintTimer, FHintPause, nil);
    {$ELSE}
    FHintTimer.Interval := FHintPause;
    FHintTimer.Enabled := true;
    {$ENDIF}
  end;
end;

{--------------------------------------------}

function  TCustomDCMemo.ActivatePopupBox(var PopupType : TPopupType) : boolean;
begin
  result := false;
  FHintPopup.Clear;
  if Assigned(FOnHintPopup) then
    FOnHintPopup(Self, FHintPopup, result, PopupType);
  result := result and (FHintPopup.Count > 0);
end;

{--------------------------------------------}

function TCustomDCMemo.ClosePopupListBox(var Key : Word; Shift : TShiftState): boolean;
begin
  result := false;
end;

{--------------------------------------------}

procedure TCustomDCMemo.PopupBoxKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);

 {--------------------------------------------}

  procedure ProcessKey;
  begin
    KeyDown(Key, Shift);
  end;

 {--------------------------------------------}

begin

  with TPopupListBox(Sender) do
  begin
    if ClosePopupListBox(Key, Shift) then
      Close(false);
    case Key of
      VK_SPACE:
        begin
          Close(true);
          Key := 0;
        end;
      VK_LEFT, VK_RIGHT :
        begin
          Close(false);
          ProcessKey;
          Key := 0;
        end;
      VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR, VK_ESCAPE, VK_RETURN: ;
      else
        begin
          ProcessKey;
          Key := 0;
        end;
    end;
    if (CaretPoint.Y <> FHintPos.Y) or (CaretPos.X < FHintPos.X) then
      Close(false);
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.DoFindInPopupBox(AStrings : TStrings; const s : string; var Index : integer) : boolean;
begin
  if Assigned(FOnFindStringInPopup) then
    FOnFindStringInPopup(Self, AStrings, s, Index, result)
  else
    result := false;  
end;

{--------------------------------------------}
{$IFDEF CLX}

function _FindInStrings(Strings : TStrings; s : string) : integer;
var
  i : integer;
begin
  s := UpperCase(s);
  for i := 0 to Strings.Count - 1 do
    if Pos(s, UpperCase(Strings[i])) = 1 then
    begin
      result := i;
      exit;
    end;
  result := -1
end;

{$ENDIF}

{--------------------------------------------}

procedure TCustomDCMemo.PopupBoxKeyPress(Sender : TObject; var Key : char);
var
  Idx : integer;
  s   : string;
begin
  if Key = '.' then
  begin
    TPopupListBox(Sender).Close(true);
    KeyPress(Key);
    exit;
  end;
  KeyPress(Key);
  s := _Copy(GetSource.Strings[CaretPoint.Y], FHintPos.X + 1, CaretPoint.X - FHintPos.X);
  with TPopupListBox(Sender) do
    if DoFindInPopupBox(Items, s, idx) then
      ItemIndex := Idx
    else
      with TPopupListBox(Sender) do
      begin
        {$IFNDEF CLX}
        Idx := Perform(LB_FINDSTRING, - 1 , Longint(Pchar(s)));
        if Idx <> LB_ERR then
          ItemIndex := Idx
        else
          ItemIndex := - 1;
        {$ELSE}
        ItemIndex := _FindInStrings(Items, s);
        {$ENDIF}
      end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.FreePopupListBox;
begin
  if (FPopupListBox <> nil) and (FPopupListBox.Visible) then
    FPopupListBox.Close(false);
  FreeObject(FPopupListBox,FPopupListBox);
end;

{--------------------------------------------}

function  TCustomDCMemo.PopupHintBox : boolean;
begin
  result := PopupHintBoxEx(FPopupHint.AutoHide);
end;

{--------------------------------------------}

function  TCustomDCMemo.PopupHintBoxEx(AutoHide : boolean) : boolean; 
var
  Pt    : TPoint;
  AType : TPopupType;
begin
  result := Assigned(FOnHintPopup) and (FHintPos.X = CaretPoint.X) and (FHintPos.Y = CaretPoint.Y) and ActivatePopupBox(AType);
  if result then
  begin
    if AType = ptListBox then
      ShowPopupListBox(FHintPopup)
    else
    begin
      Pt := ClientToScreen(TextToPixelPoint(CaretPoint));
      inc(Pt.Y, GetRealLineHeight(CaretPoint.Y));
      ShowPopupHint(FHintPopup[0], Pt, AutoHide);
    end;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.ShowPopupHint(const S : string; Point : TPoint; AutoHide : boolean);
begin
  FPopupHint.AutoHide := AutoHide;
  FPopupHint.ActivateHintAtPos(Point, S);
end;

{--------------------------------------------}

procedure TCustomDCMemo.HidePopupHint;
begin
  with FPopupHint do
    if Visible then
      CancelHint;
end;

{--------------------------------------------}

procedure TCustomDCMemo.ShowPopupListBox(Strings : TStrings);
begin
  ShowPopupListBoxEx(Strings, [lrLeftJustify, lrRightJustify], 0);
end;                                                                   


{--------------------------------------------}

procedure TCustomDCMemo.ShowPopupListBoxEx(Strings : TStrings; AlignArray : array of TLeftRightAlign; AMaxSize : integer);
var
  Pt : TPoint;
begin
  FHintPos := CaretPoint;
  FreePopupListBox;
  if FHintPopup <> Strings then
    FHintPopup.Assign(Strings);
  Pt := TextToPixelPoint(CaretPoint);
  FPopupListBox := PopupListbox(Self, FHintPopup, Pt.X, Pt.Y + GetRealLineHeight(CaretPoint.Y),
  AlignArray, FTemplateFont, HintCallBack, AMaxSize);
  FPopupListBox.OnkeyDown := PopupBoxKeyDown;
  FPopupListBox.OnkeyPress :=  PopupBoxKeyPress;
end;

{--------------------------------------------}

procedure TCustomDCMemo.InsertHint(s : string);
var
  len : integer;
begin
  HintInsert(s);
  with GetSource do
  begin
    BeginUpdate(acInsert);
    len := CaretPoint.X - FHintPos.X;
    JumpTo(FHintPos.X, FHintPos.Y);
    DeleteRight(len);
    InsertString(s);
    SelectionType := stNotSelected;
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.HintCallBack(Sender : TObject; SelIndex : integer);
begin
  if (SelIndex >= 0) and (SelIndex < FHintPopup.Count) then
    InsertHint(FHintPopup[SelIndex]);
end;

{--------------------------------------------}

function TCustomDCMemo.NotifySource(var Msg : TMessage) : boolean;
begin
  result := TMSource(GetSource).MemoNotify(Self, Msg);
end;

{--------------------------------------------}
{$IFDEF CLX}

function  TCustomDCMemo.EventFilter(Sender : QObjectH; Event : QEventH) : boolean;
begin
  result := inherited EventFilter(Sender, Event);
  if QEvent_type(Event) = QEventType_FocusIn  then
    DoSetFocus
  else
  if QEvent_type(Event) =  QEventType_FocusOut then
    DoKillFocus;
end;

{--------------------------------------------}

procedure TCustomDCMemo.ColorChanged;
begin
  inherited;
  DoColorChanged;
end;

{--------------------------------------------}

function TCustomDCMemo.WidgetFlags: Integer;
begin
  result := inherited WidgetFlags or integer(WidgetFlags_WRepaintNoErase) or
  integer(WidgetFlags_WResizeNoErase) or integer(WidgetFlags_WPaintClever);
end;

{--------------------------------------------}

procedure TCustomDCMemo.InitWidget;
begin
  inherited;
  ChangeScrollSize;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CreateWidget;
begin
  inherited;
  if FScrollBars in [ssVertical, ssBoth] then
    FVertScrollBar := QScrollBar_create(Orientation_Vertical, Handle, nil)
  else
    FVertScrollBar := nil;
  if FScrollBars in [ssHorizontal, ssBoth] then
    FHorzScrollBar := QScrollBar_create(Orientation_Horizontal, Handle, nil)
  else
    FHorzScrollBar := nil;
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoDestroyWindow;
begin
  DoneScrollHooks;
  if not (csDestroying in ComponentState) then
  begin
    if FVertScrollBar <> nil then
      QScrollBar_Destroy(FVertScrollBar);
    if FHorzScrollBar <> nil then
      QScrollBar_Destroy(FHorzScrollBar);
  end;    
  FVertScrollBar := nil;
  FHorzScrollBar := nil;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WidgetDestroyed;
begin
  inherited;
  DoDestroyWindow;
end;

{--------------------------------------------}

procedure TCustomDCMemo.DestroyWidget;
begin
  inherited;
  DoDestroyWindow;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetClientRect : TRect;
begin
  result := inherited GetClientRect;
  if FHorzScrollBar <> nil then
    dec(result.Bottom, sScrollBarSize);
  if FVertScrollBar <> nil then
    dec(result.Right, sScrollBarSize);
end;

{--------------------------------------------}

procedure TCustomDCMemo.HookEvents; 
begin
  inherited HookEvents;
  InitScrollHooks;
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoneScrollHooks;
begin
  if FHorzHooks <> nil then
    QScrollBar_hook_destroy(FHorzHooks);
  if FVertHooks <> nil then
    QScrollBar_hook_destroy(FVertHooks);
  FHorzHooks := nil;
  FVertHooks := nil;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CheckThumbTrack;
begin
  if FHorzScrollBar <> nil then
    QScrollBar_setTracking(FHorzScrollBar, moThumbTracking in FOptions);
  if FVertScrollBar <> nil then
    QScrollBar_setTracking(FVertScrollBar, moThumbTracking in FOptions);
end;

{--------------------------------------------}

procedure TCustomDCMemo.InitScrollHooks;
var
  Method : TMethod;
begin
  if FHorzScrollBar <> nil then
  begin
    FHorzHooks := QScrollBar_hook_create(FHorzScrollBar);
    QScrollBar_valueChanged_Event(Method) := ScrollHorzEventHandler;
    QScrollBar_hook_hook_valueChanged(FHorzHooks, Method);
    QWidget_setCursor(FHorzScrollBar, Screen.Cursors[crDefault]);
  end;
  if FVertScrollBar <> nil then
  begin
    FVertHooks := QScrollBar_hook_create(FVertScrollBar);
    QScrollBar_valueChanged_Event(Method) := ScrollVertEventHandler;
    QScrollBar_hook_hook_valueChanged(FVertHooks, Method);
    QWidget_setCursor(FVertScrollBar, Screen.Cursors[crDefault]);
  end;
  CheckThumbTrack;
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollHorzEventHandler(Value : integer);
begin
  ModifyScrollBar(SB_HORZ, SB_THUMBPOSITION, Value);
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollVertEventHandler(Value : integer);
begin
  ModifyScrollBar(SB_VERT, SB_THUMBPOSITION, Value);
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoEnter;
var
  Message : TMessage;
begin
  Message.Msg := CM_ENTER;
  if NotifySource(Message) then
    inherited;
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoExit; 
var
  Message : TMessage;
begin
  Message.Msg := CM_EXIT;
  if NotifySource(Message) then
    inherited;
end;

{--------------------------------------------}

procedure TCustomDCMemo.MouseLeave(AControl : TControl);
begin
  inherited;
  HidePopupHint;
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

{--------------------------------------------}

procedure TCustomDCMemo.DblClick;
var
  Message : TMessage;
begin
  Message.Msg := WM_LBUTTONDBLCLK;
  if NotifySource(Message) then
    inherited;
end;

{--------------------------------------------}

function  TCustomDCMemo.DoMouseWheel(Shift : TShiftState; WheelDelta : Integer; MousePos : TPoint) : boolean;
begin
  MouseWheel(WheelDelta);
  result := true;
  inherited DoMouseWheel(Shift, WheelDelta, MousePos);
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoContextPopup(MousePos : TPoint; var Handled : boolean);
begin
  if ContextMenu(MousePos) then
  begin
    Handled := true;
    PopupMenu := nil;
  end;
  inherited;
end;

{$ELSE}
{--------------------------------------------}

procedure TCustomDCMemo.WMSetFocus(var Message : TWMSetFocus);
begin
  inherited;
  DoSetFocus;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMKillFocus(var Message : TWMSetFocus);
begin
  inherited;
  DoKillFocus;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMEraseBkgnd(var Msg : TWMEraseBkgnd);
begin
  Msg.result := 1;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP;
    if FScrollBars in [ssVertical, ssBoth] then
      Style := Style or WS_VSCROLL;
    if FScrollBars in [ssHorizontal, ssBoth] then
      Style := Style or WS_HSCROLL;

    WindowClass.style := CS_DBLCLKS;
    UpdateParamsWithBorderStyle(Params, FBorderStyle, Ctl3d);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.WMLButtonDblClk(var Message : TMessage);
begin
  if NotifySource(Message) then
    inherited;
end;

{--------------------------------------------}

procedure TCustomDCMemo.EMCANUNDO(var Msg : TMessage);
begin
  Msg.result := integer(GetSource.UndoAvailable);
end;

{--------------------------------------------}

procedure TCustomDCMemo.EMEMPTYUNDOBUFFER(var Msg : TMessage);
begin
  GetSource.ClearUndoBuffer;
end;

{--------------------------------------------}

procedure TCustomDCMemo.EMGETLINECOUNT(var Msg : TMessage);
begin
  Msg.result := Lines.Count;
end;

{--------------------------------------------}

procedure TCustomDCMemo.EMLINEINDEX(var Msg : TMessage);
var
  line : integer;
  i    : integer;
begin
  line := Msg.WParam;
  if line = -1 then
    line := CaretPos.Y;

  Msg.result := 0;
  for i := 0 to line do
    inc(Msg.result, length(Lines[i]));
end;

{--------------------------------------------}

procedure TCustomDCMemo.EMGETLINE(var Msg : TMessage);
type
  PWord = ^word;
var
  s       : TStrings;
  index   : integer;
  buf     : pchar;
  bufsize : integer;
  st      : string;
  stlen   : integer;
begin
  s := Lines;
  index := Msg.wParam; // line index

  if (index >= s.Count) then
    begin
      Msg.result := 0;
      exit;
    end;

  buf := PChar(Msg.lParam);
  if buf = nil then
    exit;

  bufsize := PWord(buf)^;

  if bufsize = 0 then
    exit;

  st := S[index];
  stlen := min(length(st), bufsize);

  if stlen = 0 then
    buf^ := #0
  else
    Move(st[1], buf^, stlen);

  Msg.result := stlen;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMGETTEXTLENGTH(var Msg : TMessage);
begin
  Msg.result := Length(Text);
end;

{$ENDIF}

{--------------------------------------------}

procedure TCustomDCMemo.MouseWheel(ADelta : integer);
var
  delta : integer;
  Lines : integer;
begin
  inc(fWheelDelta, ADelta);
  delta := fWheelDelta div WHEELDELTA;

  if delta <> 0 then
    begin
      {$IFNDEF CLX}
      SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @Lines, 0);
      {$ELSE}
      Lines := SPI_GETWHEELSCROLLLINES;
      {$ENDIF}
      ScrollScreenVert( - Max(Lines, 1) * delta);
      dec(fWheelDelta, delta * WHEELDELTA);
    end;
end;

{--------------------------------------------}

{$IFDEF DCMBCS}

procedure TCustomDCMemo.WMImeNotify(var Msg: TMessage);
var
  imc     : HIMC;
  logFont : TLogFont;
  AFont   : TFont;
begin
  with Msg do begin
    case WParam of
      IMN_SETOPENSTATUS, IMN_SETCOMPOSITIONWINDOW:
        begin
          imc := ImmGetContext(Handle);
          try
            if (imc <> 0) then
            begin
               if SyntaxParser is TAttributeParser then
                 AFont := SelAttributes.Font
               else
                 AFont := Font;
              GetObject(AFont.Handle, SizeOf(TLogFont), @logFont);
              ImmSetCompositionFont(imc, @logFont);
            end;
          finally
            ImmReleaseContext(Handle, imc);
          end;
        end;
    end;
  end;
  inherited;
end;

{$ENDIF}

{--------------------------------------------}

procedure TCustomDCMemo.SetGutterBackColor(V : TColor);
begin
  if V <> FGutterBackColor then
  begin
    FGutterBackColor := V;
    Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetGutterImgs(Value : TDCGutterImages);
begin
  FGutterImgs.Assign(Value);
  Invalidate;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetGutterImgsAlign(Value : TGutterImgsAlign);
begin
  if FGutterImgsAlign <> Value then
  begin
    FGutterImgsAlign := Value;
    Invalidate;
  end;
end;

{--------------------------------------------}

procedure TMemoEnvOptions.cmSaveColorStyles(var Message : TMessage);
begin
  FTextStyles.SaveColorStyles;
end;

{--------------------------------------------}

procedure TMemoEnvOptions.cmLoadColorStyles(var Message : TMessage);
begin
  FTextStyles.LoadColorStyles;
end;

{--------------------------------------------}

procedure TCustomDCMemo.JumpToScreenTop;
begin
  GetSource.Navigate( - GetWBPosition(CaretPoint).Y + WinLine, 0);
end;

{--------------------------------------------}

procedure TCustomDCMemo.JumpToScreenBottom;
begin
  GetSource.Navigate(GetMaxCaretLine - GetWBPosition(CaretPoint).Y + WinLine, 0);
end;

{--------------------------------------------}

procedure TCustomDCMemo.JumpLeftMost;
var
  Pos : integer;
begin
  if not FWordWrap then
    with CaretPoint do
    begin
      if FWordWrap then
        GetRealLineIndex(GetWBPosition(CaretPoint).Y, Pos)
      else
        Pos := 0;
      GetSource.JumpToChar(PixelToTextChar(Y, Pos + 1, GetPaintX, false));
    end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.JumpRightMost;
var
  Pos : integer;
begin
  if not FWordWrap then
    with CaretPoint do
    begin
      if FWordWrap then
        GetRealLineIndex(GetWBPosition(CaretPoint).Y, Pos)
      else
        Pos := 0;
      GetSource.JumpToChar(PixelToTextChar(Y, Pos + 1, ClientWidth, false));
    end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetSelColor(V : TColor);
begin
  if V <> FSelColor then
  begin
    FSelColor := V;
    Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetMatchColor(V : TColor);
begin
  if V <> FMatchColor then
  begin
    FMatchColor := V;
    Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetMatchBackColor(V : TColor);
begin
  if V <> FMatchBackColor then
  begin
    FMatchBackColor := V;
    Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetSelBackColor(V : TColor);
begin
  if V <> FSelBackColor then
  begin
    FSelBackColor := V;
    Invalidate;
  end;
end;


{--------------------------------------------}

function TCustomDCMemo.GetCurPosText : string;
begin
  result := IntToStr(CaretPoint.Y + 1) + ': ' + IntToStr(CaretPoint.X + 1);
end;

{--------------------------------------------}


function TCustomDCMemo.GetCaretPoint : TPoint;
begin
  result := GetSource.CaretPoint;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetCaretPoint(Value : TPoint);
begin
  GetSource.CaretPoint := Value;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetWinLine(Value : integer);
begin
  if Value <> WinLine then
    ScrollScreenVert(Value - WinLine);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetWinChar(Value : integer);
begin
  if Value <> WinChar then
    ScrollScreenHorz(Value - WinChar);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetFont(V:TMemoFont);
begin
  FFont.Assign(V);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetPrinterFont(Value : TMemoFont);
begin
  FPrinterFont.Assign(Value);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetLineNumBackColor(Value : TColor);
begin
  if FLineNumBackColor <> Value then
  begin
    FLineNumBackColor := Value;
    if (moLineNumbers in FOptions) and ((GetRealGutterWidth = 0) or not (moLineNumbersOnGutter in FOptions)) then
      Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetGutterLineIndent(Value : integer);
begin
  if FGutterLineIndent <> Value then
  begin
    FGutterLineIndent := Value;
    if (moLineNumbers in FOptions) and (moLineNumbersOnGutter in FOptions) then
      Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetTemplateFont(Value : TFont);
begin
  FTemplateFont.Assign(Value);
end;

{--------------------------------------------}

procedure TCustomDCMemo.InvalidateLines(FromLine, ToLine : integer; ParseOnly : boolean);
var
  R          : TRect;
  MaxScrLine : integer;
  Pt         : TPoint;
  AMaxInt    : boolean;
  AX         : integer;
begin
  Pt := GetRealPositionEx(Point(0, WinLine), true);

  CheckVisibleIndex(Pt.Y, false);

  MaxScrLine := Pt.Y + GetMaxCaretLine + 1;

  AMaxInt := (ToLine = - MaxInt) or (ToLine = MaxInt);

  if ToLine = - MaxInt then
    ToLine := MaxScrLine;
  if ParseOnly then
  begin
    GetSource.ParseToString(Min(ToLine, MaxScrLine), not FUseMonoFont);
    exit;
  end;

  FromLine := Max(Pt.Y, FromLine);
  if NeedSyntaxPaint then
    ToLine := Max(ToLine, GetSource.ParseToString(Min(ToLine, MaxScrLine), not FUseMonoFont));

  if not FUseMonoFont then
    MaxScrLine := Pt.Y + GetMaxCaretLine + 1;
  ToLine := Min(ToLine, MaxScrLine);
  if not AMaxInt and (FromLine > ToLine) then
    exit;

  with R do
  begin
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      AX := _CharToByte(Lines[Pt.Y], Pt.X + 1)
    else
      AX := Pt.X + 1;
    {$ELSE}
      AX := Pt.X + 1;
    {$ENDIF}

    Top := LineToPixel(Pt.Y, FromLine, AX);
    if AMaxInt or ((ToLine = 0) and (Lines.Count = 0)) then
      Bottom := ClientHeight
    else
      Bottom := Top + LineToPixel(FromLine, ToLine + 1, 1);
    Left := 0;//GetPaintX;
    Right := ClientWidth ;
  end;
  {$IFNDEF CLX}
  InvalidateRect(Handle, @R, false);
  {$ELSE}
//  dec(R.Bottom);
  InvalidateRect(R, false);
  {$ENDIF}
end;

{--------------------------------------------}

procedure TCustomDCMemo.InsertSpace;
begin
  InsertChar(' ');
end;

{--------------------------------------------}

{$IFDEF DCMBCS}
function TCustomDCMemo.InsertString(const s : string) : boolean;
var
  OldAttr  : integer;
  OldR     : TRect;
  SaveRect : boolean;
begin
  result := false;
  if (KeyState <> 0) then
    exit;
  result := true;
  with TMSource(GetSource) do
  begin
    BeginUpdate(acInsert);
    OldAttr := DefaultAttribute;
    try
      DefaultAttribute := -1;
      DefaultAttribute := GetAttr(CaretPoint);
      SaveRect := (soPersistentBlocks in Options) and GetOverwrite;
      if SaveRect then
        OldR := SelectionRect;
      if not CheckOverwriteBlock then
        DefaultAttribute := OldAttr;
      if GetOverwrite then
        with CaretPoint do
          DeleteRightEx(Length(s));
      if Insert(s) then
        Navigate(0, _Length(s));
      if SaveRect then
        SelectionRect := OldR
      else
      if [soOverwriteBlocks, soPersistentBlocks] * Options = [] then
        SelectionType := stNotSelected;
    finally
      DefaultAttribute := OldAttr;
      KeyState := 0;
      EndUpdate;
    end;
  end;
end;

{$ENDIF}

{--------------------------------------------}

function TCustomDCMemo.InsertChar(Key : Char) : Boolean;
var
  OldAttr  : integer;
  OldR     : TRect;
  SaveRect : boolean;
begin
  result := false;
  if (KeyState <> 0) or (not (Key in [#32..#126, #128..#255])) then
    exit;
  result := true;
  with TMSource(GetSource) do
  begin
    BeginUpdate(acInsert);
    OldAttr := DefaultAttribute;
    try
      DefaultAttribute := -1;
      DefaultAttribute := GetAttr(CaretPoint);
      SaveRect := (soPersistentBlocks in Options) and GetOverwrite;
      if SaveRect then
        OldR := SelectionRect;

      if not CheckOverwriteBlock then
        DefaultAttribute := OldAttr;
      if GetOverwrite then
        DeleteRight(1);
      if Insert(Key) then
        CursorRight;
      if SaveRect then
        SelectionRect := OldR
      else
      if [soOverwriteBlocks, soPersistentBlocks] * Options = [] then
        SelectionType := stNotSelected;
    finally
      DefaultAttribute := OldAttr;
      KeyState := 0;
      EndUpdate;
    end;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetGutterLineColor(V : TColor);
begin
  if V <> FGutterLineColor then
  begin
    FGutterLineColor := V;
    Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetGutterWidth(V : TGutterWidth);
begin
  if FGutterWidth <> V then
  begin
    FGutterWidth := V;
    if FWordWrap then
      WordWrapLines(0, MaxInt, true);
    FMemoBackGround.PaintBackground;
    FGutterBackGround.PaintBackground;
    if moDrawGutter in FOptions then
      Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetGutterBrush(V : TBrush);
begin
  FGutterBrush.Assign(V);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetMarginPen(V : TPen);
begin
  FMarginPen.Assign(V);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetLineBookmarkColor(Value : TColor);
begin
  if FLineBookmarkColor <> Value then
  begin
    FLineBookmarkColor := Value;
    if moDrawLineBookmarks in Options then
      Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetMarginPos(V : TMarginPos);
begin
  if FMarginPos <> V then
  begin
    FMarginPos := V;
    if FWordWrap and (moBreakWordAtMargin in Options) then
      WordWrapLines(0, MaxInt, true);
    Invalidate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetOptions(Value : TMemoOptions);
var
  ANeedPaint : boolean;
  AWrapWidth : integer;
begin
  if FOptions <> Value then
  begin
    ANeedPaint := NeedSyntaxPaint;
    AWrapWidth  := GetWrapMargin  - GetPaintX;
    FOptions := Value;
    ANeedPaint := ANeedPaint <> NeedSyntaxPaint;
    UpdateCaret;
    UpdateCaretMode;
    FMemoBackGround.PaintBackground;
    FGutterBackGround.PaintBackground;
    Invalidate;
    if FWordWrap and (AWrapWidth  <> GetWrapMargin  - GetPaintX) then
      WordWrapLines(0, MaxInt, true);
    with TMSource(GetSource) do
    begin
      if not FUseMonoFont and ANeedPaint then
        ParserChanged;
    end;
    UpdateScrollSize;
    UpdateScrollPos;
    UpdateLineNumbersWidth;
    {$IFDEF CLX}
    CheckThumbTrack;
    {$ENDIF}
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.PageLeft;
begin
  if GetAveCharWidth <> 0 then
    GetSource.Navigate(0,- ClientWidth div GetAveCharWidth);
end;

{--------------------------------------------}

procedure TCustomDCMemo.PageRight;
begin
  if GetAveCharWidth <> 0 then
    GetSource.Navigate(0, ClientWidth div GetAveCharWidth);
end;

{--------------------------------------------}

procedure TCustomDCMemo.PageUpDown(direction : boolean);
var
  Pos  : integer;
  Pt   : TPoint;

  {------------------------------------------}

  function _Get(Value : integer) : integer;
  begin
    if direction then
      result := Value
    else
      result := - Value;
  end;

  {------------------------------------------}

begin
  if FUseMonoFont then
    GetSource.Navigate(_Get(GetMaxCaretLine), 0)
  else
  begin
    Pt := ConvertMousePosEx(GetPaintX, _Get(ClientHeight), true);
    Pt := GetWbPosition(Pt);
    Pt.Y := Pt.Y - _Get(1);
    Pos := WinLine;
    WinLinePos := Pt.Y;
    GetSource.Navigate(Pt.Y - Pos, 0);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.PageDown;
begin
  PageUpDown(true);
end;

{--------------------------------------------}

procedure TCustomDCMemo.PageUp;
begin
  PageUpDown(false);
end;

{--------------------------------------------}

function TCustomDCMemo.GetMaxCaretChar : integer;
begin
  result := GetMaxCaretCharEx(false);
end;

{--------------------------------------------}

function  TCustomDCMemo.GetMaxCaretCharEx(CheckMaxLineLen : boolean) : integer;
var
  AX : integer;
begin
  if FUseMonoFont or (CheckMaxLineLen and (MaxLineLen = 0)) then
    result := (ClientWidth - CharWidth - GetPaintX) div CharWidth
  else
    with CaretPoint do
    begin
      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
        AX := _CharToByte(Lines[Y], X + 1) - 1
      else
        AX := X;
      {$ELSE}
        AX := X;
      {$ENDIF}
      result := PixelToTextChar(Y, AX, ClientWidth, false) -
                PixelToTextChar(Y, AX, GetPaintX, false) - 1;
    end;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetWrapMargin : integer;
begin
  if moBreakWordAtMargin in Options then
    result := FMarginPos * CharWidth  + GetPaintX
  else
    result := ClientWidth;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CheckBlockOptions(Value : boolean);
begin
  if Value then
  begin
    FOldBlockOption := BlockOption;

    if (BlockOption = bkBoth) then
      BlockOption := bkStreamSel
    else
    if BlockOption = bkBlockSel then
      BlockOption := bkNone;
    FWBlockChanged := true;
  end
  else
    if FWBlockChanged then
    begin
      FWBlockChanged := false;
      BlockOption := FOldBlockOption;
    end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.UpdateAVESize;
begin
  FCharWidth := 0;
  GetAveCharWidth;
  FLineHeight := 0;
  GetAveLineHeight;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetUseMonoFont(Value : boolean);
begin
  if FUseMonoFont <> Value then
  begin
    FUseMonoFont := Value;
    with TMSource(GetSource) do
      if Value then
        OnGetLineHeight := nil
      else
        OnGetLineHeight := Self.GetLineHeight;
    CheckBlockOptions(not Value);
    UpdateMaxLine(true);
    TMSource(GetSource).ParserChanged;
    UpdateAVESize;
    if FWordWrap then
      WordWrapLines(0, MaxInt, true);
    UpdateCaretMode;        
    Invalidate;
  end;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetMaxCaretLineEx(AHeight : integer) : integer;
var
  Pos  : integer;
  Line : integer;
begin
  if FUseMonoFont then
  begin
    result := Max(0, AHeight div LineHeight - 1);
    CheckVisibleIndex(result, false);
  end
  else
  begin
    Line := AHeight;
    Line := PixelToTextLine(Line, Pos, false);
    result := GetWBPositionEx(Point(Pos - 1, Line), false, false, Pos).Y - WinLine - 1;
    result := Max(0, result);
  end;
end;


{--------------------------------------------}

function TCustomDCMemo.GetMaxCaretLine : integer;
begin
  result := GetMaxCaretLineEx(ClientHeight);
end;

{--------------------------------------------}

procedure TCustomDCMemo.QuickPaint(OWinChar, OWinLine : integer);
var
  R  : TRect;
  R1 : TRect;
  xa : integer;
  ya : integer;
  gw : integer;

  {--------------------------------------------}

  function _GetLineHeight(LinePos : integer) : integer;
  var
    Pt    : TPoint;
    BLine : integer;
    AX    : integer;
  begin
    CheckVisibleIndex(LinePos, false);
    if FWordWrap then
    begin
      Pt := GetRealPosition(Point(0, LinePos));
      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
        AX := _CharToByte(Lines[Pt.Y], Pt.X + 1)
      else
        AX := Pt.X + 1;
      {$ELSE}
      AX := Pt.X + 1;
      {$ENDIF}
      result := GetWrappedLineHeightEx(Pt.Y, AX, BLine, true, true);
    end
    else
      result := GetRealLineHeight(LinePos);
  end;

  {--------------------------------------------}

begin
  if not HandleAllocated then
    exit;

  if FMemoBackground.NeedPaint then
    Invalidate
  else
  begin
    xa := OWinChar - WinChar;
    ya := OWinLine - WinLine;
    if (ya = 0) and (Abs(xa) = 1) then
    begin
      xa := xa * CharWidth;

      if xa > 0 then
      begin
        R := Rect(GetPaintX, 0, ClientWidth - xa, ClientHeight);
        R1 := Rect(xa, 0, ClientWidth, ClientHeight);
      end
      else
      begin
        R := Rect(GetPaintX - xa, 0, ClientWidth, ClientHeight);
        R1 := Rect(GetPaintX, 0, GetPaintX - xa, ClientHeight);
      end;
      {$IFNDEF CLX}
      ScrollWindow(Handle, xa, 0, @R, nil);
      InvalidateRect(Handle, @R1, true);
      UpdateWindow(Handle);
      {$ELSE}
      QWidget_scroll(Handle, xa, 0, @R);
      InvalidateRect(R1, false);
      {$ENDIF}
    end
    else
      if (xa = 0) and (Abs(ya) = 1)
      then
      begin
        {$IFNDEF CLX}
        if ya = 1 then
          ScrollBy(0, ya * _GetLineHeight(WinLine))
        else
          ScrollBy(0, ya * _GetLineHeight(OWinLine));
        UpdateWindow(Handle);
        {$ELSE}
        R := ClientRect;
        //R.Left := GetPaintX;
        if ya = 1 then
        begin
          gw := _GetLineHeight(WinLine);
          QWidget_scroll(Handle, 0, gw, @R);
         // R.Bottom := R.Top + gW + 1;
        end
        else
        begin
          gw := _GetLineHeight(OWinLine);
          QWidget_scroll(Handle, 0, - gw, @R);
         // R.Top := R.Bottom - gw - 1;
        end;
        //InvalidateRect(R, false);
        //Update;
        {$ENDIF}
      end
      else
        Invalidate;
  end;
  gw := GetRealGutterWidth;
  if (gw <> 0) and FGutterBackground.NeedPaint or (GutterBrush.Style <> bsSolid) then
  begin
    R := Rect(0, 0, gw, ClientHeight + 1);
    {$IFNDEF CLX}
    InvalidateRect(Handle, @R, true);
    {$ELSE}
    InvalidateRect(R, true);
    {$ENDIF}
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.EnsureCaretVisible;
begin
  EnsurePointVisible(CaretPoint);
end;

{--------------------------------------------}

procedure TCustomDCMemo.MakeSearchPointVisible(Rect : TRect; UseTopLeft : boolean);
begin
  if UseTopLeft then
    EnsurePointVisible(Rect.TopLeft)
  else
    EnsurePointVisible(Rect.BottomRight);

  if (FrmSearRepl <> nil) and (FrmSearRepl.Visible) and (CurrentFindSource = GetSource) then
  begin
    Rect.TopLeft := ClientToScreen(TextToPixelPoint(Rect.TopLeft));
    Rect.BottomRight := ClientToScreen(TextToPixelPoint(Rect.BottomRight));
    FrmSearRepl.MakeSearchVisible(Rect);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.EnsurePointVisible(Point : TPoint);
const
  cCount = 10;
var
  Pt      : TPoint;
  MaxLine : integer;
  i       : integer;
begin
  Pt := GetWBPosition(Point);
  CheckVisibleIndex(Pt.Y, true);
  if Pt.Y < WinLine then
    WinLine := Pt.Y
  else
  begin
    i := 0;
    while i < cCount do
    begin
      MaxLine := GetMaxCaretLine;
      CheckVisibleIndex(MaxLine, true);
      if Pt.Y > WinLine + MaxLine then
        WinLine :=  Pt.Y - MaxLine
      else
        break;
      if FUseMonoFont then
        break;
      inc(i);
    end;
  end;

  Pt := TextToPixelPoint(Point);
  if Pt.X < GetPaintX then
    dec(WinChar, (GetPaintX - Pt.X + CharWidth - 1) div CharWidth)
  else
    if Pt.X > ClientWidth then
      inc(WinChar, (Pt.X - ClientWidth) div CharWidth + 1);
  if not UpdateCaretMode then
    UpdateCaret;
end;

{--------------------------------------------}

procedure TCustomDCMemo.RecalculatePosition;
var
  APoint    : TPoint;
  FromLine  : integer;
  ToLine    : integer;
begin
  //FVertFlag := false;
  APoint := GetWBPosition(CaretPoint);
  if FLineHighlight.Visible and (FOldPoint.Y - APoint.Y <> 0) then
  begin
    if FWordWrap then
    begin
      FromLine := GetRealPosition(FOldPoint).Y;
      ToLine := GetRealPosition(APoint).Y;
    end
    else
    begin
      FromLine := FOldPoint.Y;
      ToLine := CaretPoint.Y;
    end;
    InvalidateLines(FromLine, FromLine, false);
    InvalidateLines(ToLine, ToLine, false);
  end;
  FOldPoint := APoint;
  {if not FUseMonoFont then
    CreateCaret;}
  EnsureCaretVisible;
  if not FUseMonoFont and (CaretPoint.Y >= Lines.Count - 1) then
    EnsureCaretVisible;
end;

{--------------------------------------------}

function TCustomDCMemo.GetCaretWidth : integer;
{$IFDEF DCMBCS}
var
  s : string;
{$ENDIF}
begin
  if (moOverwriteCaret in FOptions) and GetSource.OverWrite  then
  begin
    result := CharWidth;
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      with CaretPoint do
      begin
        s := Lines[Y];
        if _IsLeadByte(s, _CharToByte(s, X + 1)) then
          result := result * 2;
      end;
    {$ENDIF}
  end
  else
    result := FInsCaretWidth;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetRealPoint(Pt : TPoint) : TPoint;
begin
  result := Pt;
  if FWordWrap then
  begin
    Pt := GetWbPosition(Pt);
    if Pt.X = 0 then
      result := GetRealPosition(Pt);
  end;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetCaretSize : TPoint;
var
  S      : string;
  ColorS : string;
  Pos    : integer;
  Pt     : TPoint;
begin
  if HideCaret then
  begin
    result := Point(1, 1);
    FCaretBaseLine := 0;
    exit;
  end;
  if FUseMonoFont then
  begin
    result := Point(GetCaretWidth , LineHeight);
    FCaretBaseLine := 0;
  end
  else
  begin
    Pt := GetRealPoint(CaretPoint);
    GetStrData(Pt.Y, S, ColorS);
    Pos := Min(Pt.X + 1, _Length(S));
    if (S = '') then
    begin
      result := Point(CalcSpacesSize(1, Pt), GetRealLineHeight(Pt.Y));
      FCaretBaseLine := GetBaseLine(Pt.Y);
    end
    else
    begin
      if FWordWrap and (GetWBPosition(Point(Pos - 1, Pt.Y)).X = 0) and (Pos - 1 <> 0) and (Pos < _Length(s)) then
        inc(Pos);
      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
        Pos := _CharToByte(s, Pos + 1) - 1;
      {$ENDIF}

      result := CalcStringSize(S, ColorS, Max(Pos - 1, 0), 1, FCaretBaseLine);

    end;
    if not ((moOverwriteCaret in FOptions) and GetSource.OverWrite) then
      result.X := FInsCaretWidth;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CreateCaret;
begin
  with FCaretSize do
  begin
    if (X = 0) or (Y = 0) then
      FCaretSize := GetCaretSize;
    {$IFNDEF CLX}
    Windows.CreateCaret(Handle, 0, X, Y);
    {$ELSE}
    FClxCaret.FCaretSize := Point(X, Y);
    {$ENDIF}
  end;
  {$IFNDEF CLX}
  ShowCaret(Handle);
  {$ELSE}
  FClxCaret.EnableCaret;
  {$ENDIF}
end;

{--------------------------------------------}

function TCustomDCMemo.UpdateCaretMode : boolean;
var
  BLine : integer;
begin
  result := false;
  if HandleAllocated and ([csDesigning] * ComponentState = []) and Enabled and Focused then
  begin
    BLine := FCaretBaseLine;
    with GetCaretSize do
      if (FCaretSize.X <> X) or (FCaretSize.Y <> Y) or (BLine <> FCaretBaseLine) then
      begin
        FCaretSize.X := X;
        FCaretSize.Y := Y;
        {$IFNDEF CLX}
        Windows.HideCaret(Handle);
        {$ELSE}
        FCLXCaret.DisableCaret;
        {$ENDIF}
        UpdateCaret;
        CreateCaret;
        result := true;
      end;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SafeWordWrapLines(FromIndex, ToIndex : integer);
begin
  FWrapCheck := true;
  try
    WordWrapLines(FromIndex, ToIndex, true);
  finally
    FWrapCheck := false;
  end;
end;


{--------------------------------------------}

procedure TCustomDCMemo.SourceChanged(Sender : TObject; wParam, lParam : integer);
var
  OWinLine       : integer;
  OWinChar       : integer;
  NeedInvalidate : boolean;
begin
  OWinLine := WinLine;
  OWinChar := WinChar;
  with TMSource(Sender) do
  begin
    if FWordWrap then
    begin
      if msCountChanged in State then
        FWordBreakList.ClearRange(Lines.Count, MaxInt);
      if msEdited in State then
        SafeWordWrapLines(FirstChanged, LastChanged)
    end;
    if (msParserChanged in State) and FCreated and (Self.ComponentState * [csReading, csLoading] = []) then
      SafeWordWrapLines(FirstChanged, LastChanged);

    if (msReadOnlyChanged in State) and (Color <> ReadOnlyColor) then
      Invalidate;

    if (ActiveMemo = Self) and ((msPositionChanged in State) or ((msEdited in State) and not FUseMonoFont)) then
    begin
      //UpdateCaretMode;
      if (msFoundRectChanged in State) and not IsRectEmpty(FoundRect) then
        MakeSearchPointVisible(FoundRect, SearchOptions.Direction = sdForward);
      if BookMarkJump and (moCenterOnBookmark in Self.FOptions) then
        CenterScreenOnLineEx
      else
        RecalculatePosition;
    end
    else
    if (msInsState in State) and (ActiveMemo = Self) then
      UpdateCaretMode;

    StateChanged(State);

    if ([msEdited, msPositionChanged] * State <> []) then
      if UseDefaultAttr then
        UseDefaultAttr := false
      else
        DefaultAttribute := -1;

    if [msPositionChanged, msBlockChanged] * State <> [] then
      SelectionChanged;

    if Not HandleAllocated then
      exit;


    if UpdateLineNumbersWidth then
    begin
      if NeedSyntaxPaint then
        InvalidateLines(FirstChanged, LastChanged, true);
      Invalidate;
    end
    else
    begin
      NeedInvalidate := [msFoundRectChanged, msEdited, msBlockChanged, msNeedInvalidate, msParserChanged] * State <> [];

      if (WinLine <> OWinLine) or (WinChar <> OWinChar) then
      begin
        if NeedSyntaxPaint then
          InvalidateLines(FirstChanged, LastChanged, true);

        if NeedInvalidate then
          Invalidate
        else
        begin
          if HandleAllocated and Focused then
            {$IFNDEF CLX}
            SetCaretPos(- CharWidth - 10, - 10);
            {$ELSE}
            FClxCaret.SetCaretPos(- CharWidth - 10, - 10);
          {$ENDIF}
          QuickPaint(OWinChar, OWinLine);
          UpdateCaret;
        end;
      end
      else
      if NeedInvalidate then
        InvalidateLines(FirstChanged, LastChanged, false);
    end;

    if (msEdited in State) and (msCountChanged in State) and (FirstChanged > OldCount) and (moDrawSpecialSymbols in FOptions) then
      InvalidateLines(OldCount - 1, FirstChanged, false);

    if (msCountChanged in State) or (FHideScrollBars and (FScrollBars in [ssHorizontal , ssBoth]) and (State * [msEdited, msParserChanged] <> [])) then
      UpdateScrollSize;
    if (msCountChanged in State) or (msPositionChanged in State) then
      UpdateScrollPos;

    if (msEdited in State) and Assigned(FOnChange) then
      OnChange(Self);

    if ActiveMemo = Self then
      if (OWinChar <> WinChar) or (OWinLine <> WinLine) then
        UpdateScrollPos;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.StateChanged(AState : TMemoStates);
begin
  if (AState <> []) and Assigned(FOnStateChange) then
    FOnStateChange(Self, AState);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SelectionChanged;
begin
  FSelAttributes.FUseStored := false;
  if Assigned(FOnSelectionChange) then
    FOnSelectionChange(Self);
end;

{--------------------------------------------}

procedure TCustomDCMemo.MemoJumpToUrl(const s : string);
var
  Handled : boolean;
begin
  Handled := false;
  if Assigned(FOnJumpToUrl) then
    FOnJumpToUrl(Self, s, Handled);
  {$IFNDEF CLX}
  if not Handled then
    JumpToUrl(s);
  {$ENDIF}  
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetSource(Value : TCustomMemoSource);
begin
  if Value <> FMemoSource then
  begin
    GetSource.UnRegisterNotifier(SourceChanged);
    with TMSource(GetSource) do
    begin
      ActiveMemo := nil;
      OnNavigate := nil;
      OnGetLineHeight := nil;
    end;
    FPositionStore.SavePosition(Self);
    FMemoSource := Value;
    with TMSource(GetSource) do
      if (ActiveMemo = nil) or (not TWinControl(ActiveMemo).Focused) then
      begin
        ActiveMemo := Self;
        OnNavigate := Self.GetNavigation;
        if not FUseMonoFont then
          OnGetLineHeight := Self.GetLineHeight;
      end;
    GetSource.RegisterNotifier(SourceChanged, true);

    UpdateKeyMapping;
    FPositionStore.RestorePosition(Self);
    WordWrapLines(0, MaxInt, true);
    UpdateMaxLine(false);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FMemoSource) then
    MemoSource := nil;
end;

{--------------------------------------------}

function TCustomDCMemo.HideLines : boolean;
begin
  result := not WordWrap and (moHideInvisibleLines in FOptions);
end;

{--------------------------------------------}

function TCustomDCMemo.GetRealLeftIndent : integer;
begin
  if (moLeftIndent in FOptions) and (FLeftIndent > 0) then
    result := FLeftIndent
  else
    result := 0;
  if HideLines then
    inc(result, LineHeight);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetLeftIndent(Value : integer);
begin
  Value := Max(Value, 0);
  if FLeftIndent <> Value then
  begin
    FLeftIndent := Value;
    FMemoBackground.PaintBackground;
    if moLeftIndent in Options then
    begin
      if FWordWrap then
        WordWrapLines(0, MaxInt, true);
      Invalidate;
    end;
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.GetPaintX : integer;
begin
  result := GetRealGutterWidth;
  if (moLineNumbers in FOptions) and ((result = 0) or not (moLineNumbersOnGutter in Options)) then
    inc(result, FLineNumbersWidth);
  inc(result , GetRealLeftIndent);
end;

{--------------------------------------------}

procedure TCustomDCMemo.UpdateCaret;
var
  P    : TPoint;
  Pt   : TPoint;
  Pos  : integer;
  H    : integer;
  {$IFDEF DCMBCS}
  cf   : TCompositionForm;
  Imc  : HIMC;
  {$ENDIF}

begin
  if FHideCaret then
    P := Point(-5, -5)
  else
  begin
    Pt := GetRealPoint(CaretPoint);
    P := TextToPixelPoint(Pt);
    if (P.X < GetPaintX) or (P.Y < 0) then
      P := Point(- CharWidth - 10, - 10);
    if FCaretBaseLine <> 0 then
    begin
      if FWordWrap then
      begin
        {$IFDEF DCMBCS}
        if SysLocale.FarEast then
          Pos := _CharToByte(Lines[Pt.Y], Pt.X + 1)
        else
          Pos := Pt.X + 1;
        {$ELSE}
        Pos := Pt.X + 1;
        {$ENDIF}
        GetWrappedLineHeightEx(Pt.Y, Pos, H, true, true);
      end
      else
        H := GetBaseLine(Pt.Y);
      if H <> 0 then
        inc(P.Y, H - FCaretBaseLine);
    end;
  end;
  if Focused then
  begin
    {$IFNDEF CLX}
    SetCaretPos(P.X, P.Y);
    {$ELSE}
    FClxCaret.SetCaretPos(P.X, P.Y);
    {$ENDIF}
    {$IFDEF DCMBCS}
    if SysLocale.FarEast  then
    begin
      Imc := ImmGetContext(Handle);
      try
        cf.dwStyle := CFS_POINT;
        with P do
          cf.ptCurrentPos := Point(X, Y);
        ImmSetCompositionWindow(Imc, @cf);
      finally
        ImmReleaseContext(Handle, Imc);
      end;
    end;
    {$ENDIF}
  end;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetCaretChar : integer;
var
  Pos : integer;
begin
  if FUseMonoFont then
  begin
    result := GetWBPosition(CaretPoint).X;
    if FWordWrap then
        GetRealLineIndex(GetWBPosition(CaretPoint).Y, Pos)
      else
        Pos := 0;
    dec(result, PixelToTextChar(CaretPoint.Y, Pos + 1, GetPaintX, false));
  end
  else
    result := TextToPixelChar(CaretPoint);
end;

{--------------------------------------------}

function  TCustomDCMemo.GetCaretLine : integer;  
begin
  if FUseMonoFont then
  begin
    result := GetWBPosition(CaretPoint).Y;
    dec(result, WinLine);
  end
  else
    result := TextToPixelLine(CaretPoint);
end;

{--------------------------------------------}

procedure TCustomDCMemo.CheckRealPosition;
var
  APoint : TPoint;
begin
  APoint := GetRealPosition(FOldPoint);
  with GetSource, APoint do
    if (X <> CurCharPos) or (Y <> CurLinePos) then
      JumpTo(X, Y);
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoSetFocus;
begin
  with  TMSource(GetSource) do
  begin
    ActiveMemo := Self;
    OnNavigate := Self.GetNavigation;
    if not FUseMonoFont then
      OnGetLineHeight := Self.GetLineHeight;
  end;

  CurrentFindSource := GetSource;

  CheckRealPosition;
  //RecalculatePosition;

  UpdateHiddenSelection;
  CreateCaret;
  if not UpdateCaretMode then
    UpdateCaret;
  with FLineHighlight do
    if Visible then
      Update;
  StateChanged([msPositionChanged, msInsState, msCountChanged, msModifiedChanged, msObjNameChanged]);
end;

{--------------------------------------------}

procedure TCustomDCMemo.UpdateHiddenSelection;
begin
  if FHideSelection and (GetSource.SelectionType <> stNotSelected) then
    Invalidate;
end;

{--------------------------------------------}


procedure TCustomDCMemo.DoKillFocus;
begin
  CancelDragging;
  UpdateHiddenSelection;
  {$IFNDEF CLX}
  Windows.HideCaret(Handle);
  DestroyCaret;
  {$ELSE}
  FCLXCaret.DisableCaret;
  {$ENDIF}
  with FLineHighlight do
    if Visible then
      Update;
  HidePopupHint;
  TMSource(GetSource).OnNavigate := nil;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetScrollBars(Value : TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    {$IFNDEF CLX}
    RecreateWnd;
    {$ELSE}
    RecreateWidget;
    {$ENDIF}
    UpdateMaxLine(false);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetBorderStyle(Value : TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    {$IFNDEF CLX}
    RecreateWnd;
    {$ELSE}
    RecreateWidget;
    {$ENDIF}
  end;
end;

{--------------------------------------------}


procedure TCustomDCMemo.ProcessEscape;
begin
  CancelDragging;
  GetSource.ProcessEscape;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoJumpToLineBegin;

  {----------------------------------------------------}

  procedure InternalJump;
  var
    Pt : TPoint;
  begin
    if FWordWrap then
    begin
      Pt := GetWbPosition(CaretPoint);
      Pt := GetRealPosition(Point(0, Pt.Y));
      GetSource.JumpTo(Pt.X, Pt.Y);
    end
    else
      GetSource.JumpToLineBegin;
    with GetSource do
      if (not (soPersistentBlocks in Options)) then
        SelectionType := stNotSelected;
  end;

  {----------------------------------------------------}

begin
  with GetSource do
    if FHideCaret then
    begin
      BeginUpdate(acNavigate);
      InternalJump;
      WinChar := 0;
      Invalidate;
      EndUpdate;
    end
    else
      InternalJump;
end;
{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoMarkToLineBegin;
begin
  GetSource.UnivMark(MemoJumpToLineBegin, stStreamSel);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoMarkToLineEnd;
begin
  GetSource.UnivMark(MemoJumpToLineEnd, stStreamSel);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoJumpToLineEnd;
var
  Len  : integer;
  Pt   : TPoint;
  s    : string;
  ALen : integer;
begin
  with GetSource do
    if FWordWrap then
    begin
      Pt := GetWbPosition(CaretPoint);
      Len := GetWBStringLength(CaretPoint.Y, Pt.Y, false);
      s := Strings[CurLinePos];
      ALen := _Length(s);
      if Len <> ALen then
        Len := Min(Len - 1, ALen);                     /// last char
      Navigate(0,  Len - Pt.X);
      if (not (soPersistentBlocks in Options)) then
        SelectionType := stNotSelected;
    end
    else
    begin
      GetSource.JumpTolineEnd;
      if (not (soPersistentBlocks in Options)) then
        SelectionType := stNotSelected;

    end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoCursorUp;
begin
  if FHideCaret then
    ScrollUp
  else
  begin
    with GetSource do
      if (not (soPersistentBlocks in Options)) then
        SelectionType := stNotSelected;
    GetSource.CursorUp
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoMarkDown;
begin
  GetSource.UnivMark(MemoCursorDown, stStreamSel);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoMarkUp;
begin
  GetSource.UnivMark(MemoCursorUp, stStreamSel);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoCursorDown;
begin
  if FHideCaret then
    ScrollDown
  else
  begin
    with GetSource do
      if (not (soPersistentBlocks in Options)) then
        SelectionType := stNotSelected;
    GetSource.CursorDown
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.CheckCursorLeft;
begin
  with GetSource do
    if (CurCharPos = 0) and  (moNotePadCursorStyle in FOptions) then
    begin
      if CurLinePos > 0 then
      begin
        BeginUpdate(acNavigate);
        JumpToLine(CurLinePos - 1);
        JumpToLineEnd;
        EndUpdate;
      end;
    end
    else
      GetSource.CursorLeft;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoCursorLeft;
begin
  if FHideCaret then
    ScrollLeft
  else
    CheckCursorLeft;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoCursorRight;
begin
  if FHideCaret then
    ScrollRight
  else
    GetSource.CursorRight;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.MemoMarkLeft;
begin
  GetSource.UnivMark(CheckCursorLeft, stStreamSel);
end;

{-------------------------------------------------------------}

procedure InitStandardKeyboard(Memo : TCustomDCMemo);
begin
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddAllKey(VK_UP, [], MemoCursorUp);
    AddAllKey(VK_DOWN, [], MemoCursorDown);
    AddAllKey(VK_LEFT, [], MemoCursorLeft);
    AddAllKey(VK_RIGHT, [], MemoCursorRight);
    AddAllKey(VK_PRIOR, [], PageUp);
    AddAllKey(VK_NEXT, [], PageDown);
    AddSimpleKey(VK_DELETE, [], DeleteCharRight);
    AddSimpleKey(VK_BACK, [], DeleteCharLeft);
    AddSimpleKey(VK_BACK, [ssShift], DeleteCharLeft);
    AddSimpleKey(VK_RETURN, [ssShift], PressEnter);
    AddSimpleKey(VK_RETURN, [], PressEnter);
    AddSimpleKey(VK_ESCAPE, [], ProcessEscape);
    AddSimpleKey(VK_TAB, [], PressTab);
    AddSimpleKey(VK_TAB, [ssShift], PressShiftTab);
    AddSimpleKey(VK_LEFT, [ssCtrl], JumpWordLeft);
    AddSimpleKey(VK_RIGHT, [ssCtrl], JumpWordRight);
    AddSimpleKey(Key_J, [ssCtrl], ShowCodeTemplates);
  end;
end;

{-------------------------------------------------------------}

procedure InitKeyBlock(Memo : TCustomDCMemo);
begin
  with Memo.GetSource,Memo,Memo.Keys do
  begin
    AddKey(Key_K, [ssCtrl], nil,0,sCtrlK);
    AddKey(Key_Q, [ssCtrl],nil,0,sCtrlQ);

    AddKey(Key_B, [], MarkBlockBegin, sCtrlk, 0);
    AddKey(Key_C, [ssCtrl], DuplicateBlock, sCtrlk, 0);
    AddKey(Key_C, [], DuplicateBlock, sCtrlk, 0);
    AddKey(Key_I, [ssCtrl], IndentBlock, sCtrlk, 0);
    AddKey(Key_I, [], IndentBlock, sCtrlk, 0);
    AddKey(Key_L, [ssCtrl], MarkLine, sCtrlk, 0);
    AddKey(Key_L, [], MarkLine, sCtrlk, 0);
    AddKey(Key_N, [ssCtrl], UpperCaseBlock, sCtrlk, 0);
    AddKey(Key_N, [], UpperCaseBlock, sCtrlk, 0);
    AddKey(Key_O, [ssCtrl], LowerCaseBlock, sCtrlk, 0);
    AddKey(Key_O, [], LowerCaseBlock, sCtrlk, 0);
    AddKey(Key_U, [ssCtrl], OutDentBlock, sCtrlk, 0);
    AddKey(Key_U, [], OutDentBlock, sCtrlk, 0);
    AddKey(Key_K, [ssCtrl], MarkBlockEnd, sCtrlk, 0);
    AddKey(Key_K, [], MarkBlockEnd, sCtrlk, 0);
    AddKey(Key_T, [ssCtrl], MarkWord, sCtrlk, 0);
    AddKey(Key_T, [], MarkWord, sCtrlk, 0);
    AddKey(Key_V, [ssCtrl], KeyMoveBlock, sCtrlk, 0);
    AddKey(Key_V, [], KeyMoveBlock, sCtrlk, 0);
    AddKey(Key_Y, [ssCtrl], DeleteBlock, sCtrlk, 0);
    AddKey(Key_Y, [], DeleteBlock, sCtrlk, 0);
    AddKey(Key_E, [ssCtrl], LowerCaseWord, sCtrlk, 0);
    AddKey(Key_E, [], LowerCaseWord, sCtrlk, 0);
    AddKey(Key_F, [ssCtrl], UpperCaseWord, sCtrlk, 0);
    AddKey(Key_F, [], UpperCaseWord, sCtrlk, 0);
  end;
end;

{-------------------------------------------------------------}

procedure InitBlockLayout(Memo : TCustomDCMemo);
begin
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddSimpleKey(VK_DOWN, [ssShift], MemoMarkDown);
    AddSimpleKey(VK_UP, [ssShift], MemoMarkUp);
    AddSimpleKey(VK_LEFT, [ssShift], MemoMarkLeft);
    AddSimpleKey(VK_RIGHT, [ssShift], MarkRight);
    AddSimpleKey(VK_HOME, [ssShift], MemoMarkToLineBegin);
    AddSimpleKey(VK_END, [ssShift], MemoMarkToLineEnd);
    AddSimpleKey(VK_PRIOR, [ssShift], MarkPageUp);
    AddSimpleKey(VK_NEXT, [ssShift], MarkPageDown);

    AddSimpleKey(VK_PRIOR, ssCShift, MarkToTop);
    AddSimpleKey(VK_NEXT, ssCShift, MarkToBottom);
    AddSimpleKey(VK_HOME, ssCShift, MarkToFileBegin);
    AddSimpleKey(VK_END, ssCShift, MarkToFileEnd);
    AddSimpleKey(VK_LEFT, ssCShift, MarkWordLeft);
    AddSimpleKey(VK_RIGHT, ssCShift, MarkWordRight);

    AddSimpleKey(VK_DOWN, ssAShift, MarkColDown);
    AddSimpleKey(VK_UP, ssAShift, MarkColUp);
    AddSimpleKey(VK_LEFT, ssAShift, MarkColLeft);
    AddSimpleKey(VK_RIGHT, ssAShift, MarkColRight);
    AddSimpleKey(VK_HOME, ssAShift, MarkColToLineBegin);
    AddSimpleKey(VK_END, ssAShift, MarkColToLineEnd);
    AddSimpleKey(VK_PRIOR, ssAShift, MarkColPageUp);
    AddSimpleKey(VK_NEXT, ssAShift, MarkColPageDown);

    AddSimpleKey(VK_HOME, ssCAShift, MarkColToTop);
    AddSimpleKey(VK_END, ssCAShift, MarkColToBottom);
    AddSimpleKey(VK_PRIOR, ssCAShift, MarkColToFileBegin);
    AddSimpleKey(VK_NEXT, ssCAShift, MarkColToFileEnd);
    AddSimpleKey(VK_LEFT, ssCAShift, MarkColWordLeft);
    AddSimpleKey(VK_RIGHT, ssCAShift, MarkColWordRight);

  end;
end;

{-------------------------------------------------------------}

procedure InitCursorMove(Memo : TCustomDCMemo);
begin
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddKey(Key_Q, [ssCtrl], nil,0,sCtrlQ);
    AddKey(Key_B, [ssCtrl], JumpToBlockBegin, sCtrlQ, 0);
    AddKey(Key_C, [ssCtrl], JumpToFileEnd, sCtrlQ, 0);
    AddKey(Key_D, [ssCtrl], MemoJumpToLineEnd, sCtrlQ, 0);
    AddKey(Key_E, [ssCtrl], JumpToScreenTop, sCtrlQ, 0);
    AddKey(Key_K, [ssCtrl], JumpToBlockEnd, sCtrlQ, 0);
    AddKey(Key_R, [ssCtrl], JumpToFileBegin, sCtrlQ, 0);
    AddKey(Key_S, [ssCtrl], MemoJumpToLineBegin, sCtrlQ, 0);
    AddKey(Key_T, [ssCtrl], JumpToScreenTop, sCtrlQ, 0);
    AddKey(Key_U, [ssCtrl], JumpToScreenBottom, sCtrlQ, 0);
    AddKey(Key_X, [ssCtrl], JumpToScreenBottom, sCtrlQ, 0);
  end;
end;

{-------------------------------------------------------------}

procedure InitBookmarks(Memo : TCustomDCMemo);
begin
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddKey(Key_K, [ssCtrl], nil, 0, sCtrlK);
    AddKey(Key_Q, [ssCtrl], nil, 0, sCtrlQ);
    AddKey(Key_0, [ssCtrl], ToggleBookMark0, sCtrlk, 0);
    AddKey(Key_1, [ssCtrl], ToggleBookMark1, sCtrlk, 0);
    AddKey(Key_2, [ssCtrl], ToggleBookMark2, sCtrlk, 0);
    AddKey(Key_3, [ssCtrl], ToggleBookMark3, sCtrlk, 0);
    AddKey(Key_4, [ssCtrl], ToggleBookMark4, sCtrlk, 0);
    AddKey(Key_5, [ssCtrl], ToggleBookMark5, sCtrlk, 0);
    AddKey(Key_6, [ssCtrl], ToggleBookMark6, sCtrlk, 0);
    AddKey(Key_7, [ssCtrl], ToggleBookMark7, sCtrlk, 0);
    AddKey(Key_8, [ssCtrl], ToggleBookMark8, sCtrlk, 0);
    AddKey(Key_9, [ssCtrl], ToggleBookMark9, sCtrlk, 0);

    AddKey(Key_0, [], ToggleBookMark0, sCtrlk, 0);
    AddKey(Key_1, [], ToggleBookMark1, sCtrlk, 0);
    AddKey(Key_2, [], ToggleBookMark2, sCtrlk, 0);
    AddKey(Key_3, [], ToggleBookMark3, sCtrlk, 0);
    AddKey(Key_4, [], ToggleBookMark4, sCtrlk, 0);
    AddKey(Key_5, [], ToggleBookMark5, sCtrlk, 0);
    AddKey(Key_6, [], ToggleBookMark6, sCtrlk, 0);
    AddKey(Key_7, [], ToggleBookMark7, sCtrlk, 0);
    AddKey(Key_8, [], ToggleBookMark8, sCtrlk, 0);
    AddKey(Key_9, [], ToggleBookMark9, sCtrlk, 0);

    AddKey(Key_0, [], GoToBookMark0, sCtrlQ, 0);
    AddKey(Key_1, [], GoToBookMark1, sCtrlQ, 0);
    AddKey(Key_2, [], GoToBookMark2, sCtrlQ, 0);
    AddKey(Key_3, [], GoToBookMark3, sCtrlQ, 0);
    AddKey(Key_4, [], GoToBookMark4, sCtrlQ, 0);
    AddKey(Key_5, [], GoToBookMark5, sCtrlQ, 0);
    AddKey(Key_6, [], GoToBookMark6, sCtrlQ, 0);
    AddKey(Key_7, [], GoToBookMark7, sCtrlQ, 0);
    AddKey(Key_8, [], GoToBookMark8, sCtrlQ, 0);
    AddKey(Key_9, [], GoToBookMark9, sCtrlQ, 0);

    AddKey(Key_0, ssCShift, ToggleBookMark0, sCtrlQ, 0);
    AddKey(Key_1, ssCShift, ToggleBookMark1, sCtrlQ, 0);
    AddKey(Key_2, ssCShift, ToggleBookMark2, sCtrlQ, 0);
    AddKey(Key_3, ssCShift, ToggleBookMark3, sCtrlQ, 0);
    AddKey(Key_4, ssCShift, ToggleBookMark4, sCtrlQ, 0);
    AddKey(Key_5, ssCShift, ToggleBookMark5, sCtrlQ, 0);
    AddKey(Key_6, ssCShift, ToggleBookMark6, sCtrlQ, 0);
    AddKey(Key_7, ssCShift, ToggleBookMark7, sCtrlQ, 0);
    AddKey(Key_8, ssCShift, ToggleBookMark8, sCtrlQ, 0);
    AddKey(Key_9, ssCShift, ToggleBookMark9, sCtrlQ, 0);

    AddKey(Key_0, [ssCtrl], GoToBookMark0, sCtrlQ, 0);
    AddKey(Key_1, [ssCtrl], GoToBookMark1, sCtrlQ, 0);
    AddKey(Key_2, [ssCtrl], GoToBookMark2, sCtrlQ, 0);
    AddKey(Key_3, [ssCtrl], GoToBookMark3, sCtrlQ, 0);
    AddKey(Key_4, [ssCtrl], GoToBookMark4, sCtrlQ, 0);
    AddKey(Key_5, [ssCtrl], GoToBookMark5, sCtrlQ, 0);
    AddKey(Key_6, [ssCtrl], GoToBookMark6, sCtrlQ, 0);
    AddKey(Key_7, [ssCtrl], GoToBookMark7, sCtrlQ, 0);
    AddKey(Key_8, [ssCtrl], GoToBookMark8, sCtrlQ, 0);
    AddKey(Key_9, [ssCtrl], GoToBookMark9, sCtrlQ, 0);
  end;
end;

{-------------------------------------------------------------}

procedure InitBriefKeyboard(Instance : TObject);
var
  Memo : TCustomDCMemo;
begin
  Memo := TCustomDCMemo(Instance);
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddSimpleKey(VK_MINUS, [], CutToClipboard);
    AddSimpleKey(VK_INSERT, [], PasteFromClipboard);
    AddSimpleKey(VK_PLUS, [], CopyToClipboard);
    AddSimpleKey(VK_MULTIPLY, [], Undo);

    AddSimpleKey(Key_A, [ssCtrl], MarkToLineEnd);
    AddSimpleKey(Key_B, [ssCtrl], JumpToScreenBottom);
    AddSimpleKey(Key_C, [ssCtrl], CenterScreenOnLine);
    AddSimpleKey(Key_D, [ssCtrl], PageDown);
    AddSimpleKey(Key_E, [ssCtrl], PageUp);
    AddSimpleKey(Key_K, [ssCtrl], DeleteToLineBegin);
    AddSimpleKey(Key_M, [ssCtrl], PressEnter);
    AddSimpleKey(Key_T, [ssCtrl], JumpToScreenTop);
    AddSimpleKey(Key_U, [ssCtrl], Redo);
    AddSimpleKey(VK_BACK, [ssCtrl], DeleteWordLeft);
    AddSimpleKey(VK_RETURN, [ssCtrl], InsertLine);
    AddSimpleKey(Key_D, [ssAlt], DeleteLine);
    AddSimpleKey(Key_G, [ssAlt], PromptedGotoLine);


    AddSimpleKey(Key_I, [ssAlt], ToggleInsMode);
    AddSimpleKey(Key_K, [ssAlt], DeleteToLineEnd);


    AddSimpleKey(Key_U, [ssAlt], Undo);
    AddSimpleKey(VK_BACK, [ssAlt], DeleteWordRight);
    AddKey(Key_O, [ssCtrl], nil, 0, sCtrlO);
    AddKey(Key_O, [ssCtrl], ToggleBlockCase, sCtrlO, 0);


    AddSimpleKey(VK_F5, [], ShowSearchDialog);
    AddSimpleKey(VK_F6, [], ShowReplaceDialog);
    AddSimpleKey(VK_F5, [ssAlt], ShowSearchDialog);
    AddSimpleKey(VK_F6, [ssAlt], ShowReplaceDialog);
    AddSimpleKey(VK_F5, [ssShift], KeyFindNext);
    AddSimpleKey(VK_F6, [ssShift], KeyReplace);
    AddSimpleKey(VK_F5, [ssCtrl], ToggleCaseSensitiveSearch);
    AddSimpleKey(VK_F6, [ssCtrl], ToggleRegularExprSearch);

    AddSimpleKey(Key_S, [ssAlt], ShowSearchDialog);
    AddSimpleKey(Key_S, [ssCtrl], KeyFindNext);
    AddSimpleKey(Key_T, [ssAlt], ShowReplaceDialog);

    AddAllKey(VK_HOME, [ssShift], MemoJumpToLineBegin);
    AddAllKey(VK_END, [ssCtrl], JumpToScreenBottom);
    AddAllKey(VK_HOME, [ssCtrl], JumpToScreenTop);
    AddAllKey(VK_END, [ssShift], MemoJumpToLineEnd);
    AddAllKey(VK_PRIOR, [ssCtrl], JumpToFileBegin);
    AddAllKey(VK_NEXT, [ssCtrl], JumpToFileEnd);
    AddAllKey(VK_PRIOR, [ssCtrl], JumpToFileBegin);

    AddSimpleKey(Key_0, [ssAlt], ToggleBookMark0);
    AddSimpleKey(Key_1, [ssAlt], ToggleBookMark1);
    AddSimpleKey(Key_2, [ssAlt], ToggleBookMark2);
    AddSimpleKey(Key_3, [ssAlt], ToggleBookMark3);
    AddSimpleKey(Key_4, [ssAlt], ToggleBookMark4);
    AddSimpleKey(Key_5, [ssAlt], ToggleBookMark5);
    AddSimpleKey(Key_6, [ssAlt], ToggleBookMark6);
    AddSimpleKey(Key_7, [ssAlt], ToggleBookMark7);
    AddSimpleKey(Key_8, [ssAlt], ToggleBookMark8);
    AddSimpleKey(Key_9, [ssAlt], ToggleBookMark9);

    AddKey(Key_J, [ssAlt], nil, 0, sAltJ);
    AddKey(Key_0, [ssAlt], GoToBookMark0, sAltJ, 0);
    AddKey(Key_1, [ssAlt], GoToBookMark1, sAltJ, 0);
    AddKey(Key_2, [ssAlt], GoToBookMark2, sAltJ, 0);
    AddKey(Key_3, [ssAlt], GoToBookMark3, sAltJ, 0);
    AddKey(Key_4, [ssAlt], GoToBookMark4, sAltJ, 0);
    AddKey(Key_5, [ssAlt], GoToBookMark5, sAltJ, 0);
    AddKey(Key_6, [ssAlt], GoToBookMark6, sAltJ, 0);
    AddKey(Key_7, [ssAlt], GoToBookMark7, sAltJ, 0);
    AddKey(Key_8, [ssAlt], GoToBookMark8, sAltJ, 0);
    AddKey(Key_9, [ssAlt], GoToBookMark9, sAltJ, 0);

    InitStandardKeyboard(Memo);
    InitBlockLayout(Memo);

    AddKey(Key_A, [ssAlt], MarkBriefRight, 0, sAltBrief);
    AddKey(Key_C, [ssAlt], MarkBriefColRight, 0, sAltBriefCol);
    AddKey(Key_L, [ssAlt], MarkLine, 0, sAltBrief);
    AddKey(Key_M, [ssAlt], MarkToLineEnd, 0, sAltBrief);

    AddKey(VK_UP, [], MarkUp, sAltBrief, sAltBrief);
    AddKey(VK_DOWN, [], MarkDown, sAltBrief, sAltBrief);
    AddKey(VK_LEFT, [], MarkLeft, sAltBrief, sAltBrief);
    AddKey(VK_RIGHT, [], MarkRight, sAltBrief, sAltBrief);
    AddKey(VK_PRIOR, [], MarkPageUp, sAltBrief, sAltBrief);
    AddKey(VK_NEXT, [], MarkPageDown, sAltBrief, sAltBrief);
    AddKey(VK_HOME, [], MarkToLineBegin, sAltBrief, sAltBrief);
    AddKey(VK_END, [], MarkToLineEnd, sAltBrief, sAltBrief);

    AddKey(VK_UP, [], MarkColUp, sAltBriefCol, sAltBriefCol);
    AddKey(VK_DOWN, [], MarkColDown, sAltBriefCol, sAltBriefCol);
    AddKey(VK_LEFT, [], MarkColLeft, sAltBriefCol, sAltBriefCol);
    AddKey(VK_RIGHT, [], MarkColRight, sAltBriefCol, sAltBriefCol);
    AddKey(VK_PRIOR, [], MarkColPageUp, sAltBriefCol, sAltBriefCol);
    AddKey(VK_NEXT, [], MarkColPageDown, sAltBriefCol, sAltBriefCol);
    AddKey(VK_HOME, [], MarkColToLineBegin, sAltBriefCol, sAltBriefCol);
    AddKey(VK_END, [], MarkColToLineEnd, sAltBriefCol, sAltBriefCol);

    AddKey(VK_ESCAPE, [], ClearSelection, sAltBrief, 0);
    AddKey(VK_ESCAPE, [], ClearSelection, sAltBriefCol, 0);
    AddKey(VK_HOME, [], MemoJumpToLineBegin, 0, sBriefHomeEnd);
    AddKey(VK_END, [], MemoJumpToLineEnd, 0, sBriefHomeEnd);
    AddKey(VK_HOME, [], JumpToFileBegin, sBriefHomeEnd, 0);
    AddKey(VK_END, [], JumpToFileEnd, sBriefHomeEnd, 0);

  end;
end;

{-------------------------------------------------------------}

procedure InitEpsilonKeyboard(Instance : TObject);
var
  Memo : TCustomDCMemo;
begin
  Memo := TCustomDCMemo(Instance);
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddSimpleKey(Key_Y, [ssCtrl],PasteFromClipboard);
    AddSimpleKey(Key_W, [ssAlt],CopyToClipboard);
    AddSimpleKey(Key_W, [ssCtrl],CutToClipboard);

    AddSimpleKey(Key_H, [ssCtrl], DeleteCharLeft);
    AddSimpleKey(Key_H, [ssCtrl, ssAlt], DeleteWordLeft);
    AddSimpleKey(Key_D, [ssCtrl], DeleteCharRight);
    AddSimpleKey(Key_D, [ssAlt], DeleteWordRight);
    AddSimpleKey(Key_C, [ssAlt], CapitalizeWord);
    AddSimpleKey(Key_M, [ssCtrl], PressEnter);
    AddSimpleKey(Key_O, [ssCtrl], InsertLine);
    AddSimpleKey(Key_L, [ssAlt], LowerCaseWord);
    AddSimpleKey(Key_U, [ssAlt], UpperCaseWord);
    AddSimpleKey(Key_F, [ssAlt], JumpWordRight);

    AddKey(Key_X, [ssCtrl], nil, 0, sCtrlX);
    AddKey(Key_G, [ssCtrl], PromptedGotoLine, sCtrlX, 0);

    AddKey(Key_R, [ssCtrl], Redo, sCtrlX, 0);
    AddKey(Key_U, [ssCtrl], Undo, sCtrlX, 0);
    AddKey(Key_0, [ssCtrl], Clear, sCtrlX, 0);
    AddKey(VK_TAB, [ssCtrl], IndentBlock, sCtrlX, 0);

    AddSimpleKey(VK_F10, [ssCtrl], Redo);
    AddSimpleKey(VK_F9, [ssCtrl], Undo);
    AddSimpleKey(VK_INSERT, [], ToggleInsMode);
    AddSimpleKey(VK_BACK, [ssAlt], DeleteWordLeft);

    AddSimpleKey(Key_B, [ssCtrl], CursorLeft);
    AddSimpleKey(Key_F, [ssCtrl], CursorRight);
    AddSimpleKey(Key_B, [ssAlt], JumpWordLeft);
    AddSimpleKey(Key_F, [ssAlt], JumpWordRight);
    AddSimpleKey(Key_A, [ssCtrl], MemoJumpToLineBegin);
    AddSimpleKey(Key_E, [ssCtrl], MemoJumpToLineEnd);
    AddSimpleKey(Key_P, [ssCtrl], CursorUp);
    AddSimpleKey(Key_N, [ssCtrl], CursorDown);
    AddSimpleKey(Key_V, [ssCtrl], PageDown);
    AddSimpleKey(Key_V, [ssAlt], PageUp);
    AddSimpleKey(Key_Z, [ssAlt], ScrollDown);
    AddSimpleKey(Key_Z, [ssCtrl], ScrollUp);

    AddSimpleKey(Key_S, [ssCtrl, ssAlt], ShowSearchDialog);
    AddSimpleKey(Key_R, [ssCtrl, ssAlt], ShowReplaceDialog);
    AddSimpleKey(Key_5, [ssCtrl, ssShift], ShowSearchDialog);
    AddSimpleKey(Key_7, [ssCtrl, ssShift], ShowReplaceDialog);

    AddSimpleKey(VK_HOME, [], JumpToScreenTop);
    AddSimpleKey(VK_END, [], JumpToScreenBottom);
    AddSimpleKey(VK_HOME, [ssCtrl], JumpToFileBegin);
    AddSimpleKey(VK_END, [ssCtrl], JumpToFileEnd);
    AddSimpleKey(VK_F6, [ssCtrl], PageDown);
    AddSimpleKey(VK_F6, [ssCtrl, ssShift], PageDown);
    AddSimpleKey(VK_MINUS, [ssAlt], JumpToScreenTop);
///    AddSimpleKey(Key_QuoteRight, [ssAlt], JumpToFileEnd);
    AddSimpleKey(Key_QuoteLeft, [ssAlt], JumpToFileBegin);

    InitStandardKeyboard(Memo);
    InitBlockLayout(Memo);
    InitBookmarks(Memo);

  end;
end;

{-------------------------------------------------------------}

procedure InitClassDefKeyboard(Memo : TCustomDCMemo);
begin
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddSimpleKey(VK_DELETE, [ssShift], CutToClipboard);
    AddSimpleKey(VK_DELETE, [ssCtrl], DeleteBlock);
    AddSimpleKey(VK_INSERT, [ssShift], PasteFromClipboard);
    AddSimpleKey(VK_INSERT, [ssCtrl], CopyToClipboard);

    AddAllKey(VK_HOME, [], MemoJumpToLineBegin);
    AddAllKey(VK_END, [], MemoJumpToLineEnd);
    AddSimpleKey(VK_BACK, [ssCtrl], DeleteWordLeft);
    AddSimpleKey(VK_BACK, [ssAlt], Undo);
    AddSimpleKey(VK_BACK, [ssAlt, ssShift], Redo);
    AddSimpleKey(VK_INSERT, [], ToggleInsMode);
    AddSimpleKey(Key_A, [ssCtrl], SelectAll);
    {$IFNDEF CLX}
    AddSimpleKey(Key_G, ssCShift, InsertGuid);
    {$ENDIF}

    AddKey(Key_Q, [ssCtrl], nil, 0, sCtrlQ);
    AddKey(Key_A, [ssCtrl], ShowReplaceDialog, sCtrlQ, 0);
    AddKey(Key_F, [ssCtrl], ShowSearchDialog, sCtrlQ, 0);
    AddKey(Key_Y, [ssCtrl], DeleteToLineEnd, sCtrlQ, 0);
    AddKey(Key_O, [ssCtrl], nil,0,sCtrlO);
    AddKey(Key_G, [ssCtrl], PromptedGotoLine, sCtrlO, 0);
    AddKey(Key_U, [ssCtrl], ToggleBlockCase, sCtrlO, 0);

    AddKey(Key_L, [ssCtrl], MarkLine, sCtrlO, 0);
    AddSimpleKey(Key_Q, [ssCtrl, ssAlt], QuoteBlock);
    {$IFNDEF CLX}
    AddSimpleKey(VkKeyScan('['), [ssCtrl], FindNextBracket);
    {$ELSE}
    AddSimpleKey(Key_BracketLeft, [ssCtrl], FindNextBracket);
    {$ENDIF}

  end;
end;

{-------------------------------------------------------------}

procedure InitClassicKeyboard(Instance : TObject);
var
  Memo : TCustomDCMemo;
begin
  Memo := TCustomDCMemo(Instance);
  with Memo.GetSource, Memo, Memo.Keys do
  begin

    AddSimpleKey(Key_A, [ssCtrl], JumpWordLeft);
    AddSimpleKey(Key_C, [ssCtrl], JumpToScreenBottom);
    AddSimpleKey(Key_D, [ssCtrl], CursorRight);
    AddSimpleKey(Key_E, [ssCtrl], CursorUp);
    AddSimpleKey(Key_F, [ssCtrl], JumpWordRight);
    AddSimpleKey(Key_G, [ssCtrl], DeleteCharRight);
    AddSimpleKey(Key_H, [ssCtrl], DeleteCharLeft);
    AddSimpleKey(Key_I, [ssCtrl], PressTab);
    AddSimpleKey(Key_L, [ssCtrl], KeyFindNext);
    AddSimpleKey(Key_N, [ssCtrl], PressEnter);
    AddSimpleKey(Key_R, [ssCtrl], PageUp);
    AddSimpleKey(Key_S, [ssCtrl], CursorLeft);
    AddSimpleKey(Key_T, [ssCtrl], CorrectDeleteWordRight);
    AddSimpleKey(Key_V, [ssCtrl], ToggleInsMode);
    AddSimpleKey(Key_W, [ssCtrl], PageDown);
    AddSimpleKey(Key_X, [ssCtrl], CursorDown);
    AddSimpleKey(Key_Y, [ssCtrl], DeleteLine);
    AddSimpleKey(Key_Z, [ssCtrl], CursorUp);
    AddSimpleKey(Key_S, ssCShift, KeyFindNext);


    AddAllKey(VK_HOME, [ssCtrl], JumpToScreenTop);
    AddAllKey(VK_END, [ssCtrl], JumpToScreenBottom);
    AddAllKey(VK_PRIOR, [ssCtrl], JumpToFileBegin);
    AddAllKey(VK_NEXT, [ssCtrl], JumpToFileEnd);
    AddSimpleKey(VK_BACK, [ssShift], DeleteCharLeft);

    InitClassDefKeyboard(Memo);
    InitStandardKeyboard(Memo);
    InitBlockLayout(Memo);
    InitKeyBlock(Memo);
    InitCursorMove(Memo);
    InitBookmarks(Memo);
  end;
end;

{-------------------------------------------------------------}

procedure InitDefaultKeyboard(Instance : TObject);
var
  Memo : TCustomDCMemo;
begin
  Memo := TCustomDCMemo(Instance);
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddSimpleKey(Key_X, [ssCtrl], CutToClipboard);
    AddSimpleKey(Key_V, [ssCtrl], PasteFromClipboard);
    AddSimpleKey(Key_C, [ssCtrl], CopyToClipboard);

    AddSimpleKey(VK_F3, [], KeyFindNext);
    AddSimpleKey(Key_E, [ssCtrl], KeyFindNext);
    AddSimpleKey(Key_F, [ssCtrl], ShowSearchDialog);
    AddSimpleKey(Key_R, [ssCtrl], ShowReplaceDialog);


    AddAllKey(VK_HOME, [ssCtrl], JumpToFileBegin);
    AddAllKey(VK_END, [ssCtrl], JumpToFileEnd);
    AddAllKey(VK_PRIOR, [ssCtrl], JumpToScreenTop);
    AddAllKey(VK_NEXT, [ssCtrl], JumpToScreenBottom);
    AddSimpleKey(VK_DOWN, [ssCtrl], ScrollDown);
    AddSimpleKey(VK_UP, [ssCtrl], ScrollUp);

    AddSimpleKey(Key_Z, [ssCtrl], Undo);
    AddSimpleKey(Key_A, [ssCtrl], SelectAll);
    AddSimpleKey(Key_Y, [ssCtrl, ssShift], DeleteToLineEnd);
    AddSimpleKey(Key_Y, [ssCtrl], DeleteLine);
    AddSimpleKey(Key_L, [ssCtrl], KeyFindNext);
    AddSimpleKey(Key_I, [ssCtrl], PressTab);
    AddSimpleKey(Key_N, [ssCtrl], InsertLine);
    AddSimpleKey(Key_T, [ssCtrl], CorrectDeleteWordRight);
    AddSimpleKey(Key_Z, ssCShift, Redo);
    AddSimpleKey(Key_I, ssCShift, IndentBlock);
    AddSimpleKey(Key_U, ssCShift, OutdentBlock);

    AddSimpleKey(Key_0, [ssCtrl], GoToBookMark0);
    AddSimpleKey(Key_1, [ssCtrl], GoToBookMark1);
    AddSimpleKey(Key_2, [ssCtrl], GoToBookMark2);
    AddSimpleKey(Key_3, [ssCtrl], GoToBookMark3);
    AddSimpleKey(Key_4, [ssCtrl], GoToBookMark4);
    AddSimpleKey(Key_5, [ssCtrl], GoToBookMark5);
    AddSimpleKey(Key_6, [ssCtrl], GoToBookMark6);
    AddSimpleKey(Key_7, [ssCtrl], GoToBookMark7);
    AddSimpleKey(Key_8, [ssCtrl], GoToBookMark8);
    AddSimpleKey(Key_9, [ssCtrl], GoToBookMark9);
    AddSimpleKey(Key_0, [ssShift, ssCtrl], ToggleBookMark0);
    AddSimpleKey(Key_1, [ssShift, ssCtrl], ToggleBookMark1);
    AddSimpleKey(Key_2, [ssShift, ssCtrl], ToggleBookMark2);
    AddSimpleKey(Key_3, [ssShift, ssCtrl], ToggleBookMark3);
    AddSimpleKey(Key_4, [ssShift, ssCtrl], ToggleBookMark4);
    AddSimpleKey(Key_5, [ssShift, ssCtrl], ToggleBookMark5);
    AddSimpleKey(Key_6, [ssShift, ssCtrl], ToggleBookMark6);
    AddSimpleKey(Key_7, [ssShift, ssCtrl], ToggleBookMark7);
    AddSimpleKey(Key_8, [ssShift, ssCtrl], ToggleBookMark8);
    AddSimpleKey(Key_9, [ssShift, ssCtrl], ToggleBookMark9);

    InitClassDefKeyboard(Memo);
    InitStandardKeyboard(Memo);
    InitBlockLayout(Memo);
    InitKeyBlock(Memo);
    InitBookmarks(Memo);
    InitCursorMove(Memo);

  end;
end;

{-------------------------------------------------------------}

procedure InitVisualStudioKeyboard(Instance : TObject);
var
  Memo : TCustomDCMemo;
begin
  Memo := TCustomDCMemo(Instance);
  with Memo.GetSource, Memo, Memo.Keys do
  begin
    AddKey(Key_K, [ssCtrl], nil, 0, sCtrlK);
    AddKey(Key_Q, [ssCtrl], nil, 0, sCtrlQ);

    AddSimpleKey(VK_DELETE, [ssShift], CutToClipboard);
    AddSimpleKey(VK_INSERT, [ssShift], PasteFromClipboard);
    AddSimpleKey(VK_INSERT, [ssCtrl], CopyToClipboard);
    AddSimpleKey(Key_X, [ssCtrl], CutToClipboard);
    AddSimpleKey(Key_V, [ssCtrl], PasteFromClipboard);
    AddSimpleKey(Key_C, [ssCtrl], CopyToClipboard);

    AddSimpleKey(VK_F3, [], KeyFindNext);
    AddSimpleKey(Key_F, [ssCtrl], ShowSearchDialog);
    AddSimpleKey(Key_G, [ssAlt], PromptedGotoLine);
    AddSimpleKey(Key_H, [ssCtrl], ShowReplaceDialog);
    AddSimpleKey(Key_I, [ssCtrl], KeyFindNext);
    AddSimpleKey(Key_L, [ssCtrl], DeleteLine);
    AddSimpleKey(Key_T, [ssCtrl], DeleteWordLeft);
    AddSimpleKey(Key_Y, [ssCtrl], DeleteLine);
    AddSimpleKey(Key_Y, [ssCtrl, ssShift], DeleteToLineEnd);
    AddSimpleKey(Key_Z, [ssCtrl], Undo);
    AddSimpleKey(Key_Z, [ssCtrl, ssShift], Redo);
    AddKey(Key_E, [ssCtrl], LowerCaseBlock, sCtrlk, 0);
    AddKey(Key_F, [ssCtrl], UpperCaseBlock, sCtrlk, 0);

    AddKey(Key_A, [], ShowReplaceDialog, sCtrlQ, 0);
    AddKey(Key_F, [], ShowSearchDialog, sCtrlQ, 0);
    AddKey(Key_Y, [], DeleteToLineEnd, sCtrlQ, 0);

    AddKey(Key_BracketLeft, [ssCtrl], NextBracket, sCtrlQ, 0);
    AddKey(Key_BracketLeft, [], NextBracket, sCtrlQ, 0);
    AddKey(Key_BracketRight, [ssCtrl], PrevBracket, sCtrlQ, 0);
    AddKey(Key_BracketRight, [], PrevBracket, sCtrlQ, 0);
    AddSimpleKey(VK_F3, [ssAlt], ShowSearchDialog);
    AddSimpleKey(Key_BracketLeft, [ssAlt], NextBracket);
    AddSimpleKey(Key_BracketRight, [ssAlt], PrevBracket);
    AddSimpleKey(VK_BACK, [ssCtrl], DeleteWordLeft);
    AddSimpleKey(VK_INSERT, [], ToggleInsMode);

    AddSimpleKey(VK_BACK, [ssAlt], Undo);
    AddSimpleKey(VK_BACK, [ssAlt, ssShift], Redo);
    AddSimpleKey(Key_I, ssCShift, IndentBlock);
    AddSimpleKey(Key_U, ssCShift, OutdentBlock);
    AddSimpleKey(VK_DELETE, [ssCtrl], DeleteBlock);

    AddAllKey(VK_HOME, [], MemoJumpToLineBegin);
    AddAllKey(VK_END, [], MemoJumpToLineEnd);
    AddAllKey(VK_HOME, [ssCtrl], JumpToFileBegin);
    AddAllKey(VK_END, [ssCtrl], JumpToFileEnd);
    AddAllKey(VK_PRIOR, [ssCtrl], JumpToScreenTop);
    AddAllKey(VK_NEXT, [ssCtrl], JumpToScreenBottom);

  end;
  InitStandardKeyboard(Memo);
  InitBlockLayout(Memo);
  InitKeyBlock(Memo);
  InitBookmarks(Memo);
  InitCursorMove(Memo);
end;

{-------------------------------------------------------------}

procedure EnumTextStyles(Proc: TGetStrProc);
var
  i: integer;
begin
  with GlobalMemoOptions.TextStyles do
    for i := 0 to Count - 1 do
      Proc(Items[i].Name);
end;

{-------------------------------------------------------------}

procedure RemoveExtraStyles;
var
  i: integer;
  s: string;
begin
  with GlobalMemoOptions.TextStyles do
    for i := Count - 1 downto 0 do
    begin
      s := Items[i].Name;
      if (CompareText(s, STxtStEmphasis) = 0) or
         (CompareText(s, STxtStSystemVariable) = 0) or
         (CompareText(s, STxtStScriptWhiteSp) = 0) or
         (CompareText(s, STxtStScriptDelimiters) = 0) or
         (CompareText(s, STxtStScriptComment) = 0) or
         (CompareText(s, STxtStScriptString) = 0) or
         (CompareText(s, STxtStScriptNumber) = 0) or
         (CompareText(s, STxtStScriptResWord) = 0) then
        Free;
    end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.InitDefaultKeyMapping;
begin
  InitDefaultKeyboard(Self);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetDrawCanvas : TCanvas;
begin
  result := FDrawCanvas;
  if (result = nil) and HandleAllocated then
    result := Canvas;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.Paint;
var
{$IFNDEF CLX}
  DrawDC : HDC;
{$ENDIF}
  R      : TRect;
begin
  with Canvas do
  begin
    Font := Self.Font;
    FDrawRect := Canvas.Cliprect;
    FCurFont := nil;
    if FSpecialPaint then
      with FDrawRect do
      begin
        Right := Left + FPaintWidth;
        Bottom := Top + FPaintHeight;
      end;
    if FUseMonoFont then
      with FDrawRect do
        Top := (Top div LineHeight) * LineHeight;
    PaintLeftIndent;
    PaintGutter;
    PaintLineNumbers;
    PaintGutterImages;
    if NeedPaintGutter(R) then
      DoPaintGutter(R, dsAfterPaint);

    if FMemoBackground.NeedPaint then
    begin
      FDrawCanvas := TCanvas.Create;  //CreateCompatibleDC(Canvas.Handle);
      {$IFNDEF CLX}
      DrawDC := CreateCompatibleDC(Canvas.Handle);;
      FDrawCanvas.Handle := DrawDC;
      {$ENDIF}
      try
        {$IFNDEF CLX}
        SetBkMode(FDrawCanvas.Handle, TRANSPARENT);
        {$ENDIF}
        RealPaint;
      finally
        {$IFNDEF CLX}
        SetBkMode(FDrawCanvas.Handle, OPAQUE);
        {$ENDIF}
        FDrawCanvas.Free;
        FDrawCanvas := nil;
        {$IFNDEF CLX}
        DeleteDC(DrawDC);
        {$ENDIF}
      end;
    end
    else
    begin
      FDrawCanvas := nil;
      RealPaint;
    end;
    {$IFDEF CLX}
    PaintScrollRect;
    FClxCaret.PaintCaret;
    {$ENDIF}
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.PaintLeftIndent;
var
  R      : TRect;
  R1     : TRect;
  W      : integer;
begin
  if (moLeftIndent in FOptions) and (FLeftIndent > 0) then
  begin
    W := GetRealGutterWidth;
    R := Rect(W, 0, FLeftIndent + W, ClientHeight + 1);
    IntersectRect(R, R, FDrawRect);
  end
  else
    R := Rect(0, 0, 0, 0);
  if HideLines then
  begin
    W := GetPaintX;
    R1 := Rect(W - LineHeight, 0, W, ClientHeight + 1);
    IntersectRect(R1, R1, FDrawRect);
  end
  else
    R1 := Rect(0, 0, 0, 0);
  if not (IsRectEmpty(R) and IsRectEmpty(R1)) then
    with GetDrawCanvas do
    begin
      Brush.Color := Self.Color;
      FillRect(R);
      FillRect(R1);
    end;
end;

{--------------------------------------------}

function  TCustomDCMemo.DoPaintGutter(const ARect : TRect; DrawState : TDrawState) : boolean;
begin
  result := false;
  if Assigned(FOnDrawGutter) then
    FOnDrawGutter(Self, Canvas, ARect, DrawState, result);
end;

{--------------------------------------------}

function  TCustomDCMemo.NeedPaintGutter(var R : TRect) : boolean;
begin
  result := false;
  if not (moDrawGutter in FOptions) then
    exit;
  R := Rect(0, 0, GetRealGutterWidth, ClientHeight + 1);
  IntersectRect(R, R, FDrawRect);
  result := not IsRectEmpty(R);
end;

{--------------------------------------------}

procedure TCustomDCMemo.PaintGutter;
var
  R  : TRect;
  X  : integer;
begin
  if not NeedPaintGutter(R) or DoPaintGutter(R, dsBeforePaint) then
   exit;

  with Canvas do //GetDrawCanvas) do
  begin
    X := GetRealGutterWidth - 2;
    if FGutterBackGround.NeedPaint then
      {$IFNDEF CLX}
      BitBlt(Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, FGutterBackGround.TempBackground.Canvas.Handle, R.Left, R.Top, SRCCOPY)
      {$ELSE}
      QBitBlt(Canvas, R.Left, R.Top, FGutterBackGround.TempBackground.Canvas, R.Left, R.Top, R.Right - R.Left - 1, R.Bottom - R.Top)
      {$ENDIF}
    else
    begin
      R.Right := Min(R.Right, X);
      {$IFNDEF CLX}
      Windows.FillRect(Handle, R, FGutterBrush.Handle);
      {$ELSE}
      QFillRect(Canvas, R, FGutterBrush);
      {$ENDIF}
      PaintGutterLine(Canvas, R, X, FGutterBackColor, FGutterLineColor);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCMemo.LoadGlobalOptions;
begin
  TextStyles.BeginParserUpdate;
  try
    AssignPropsEx(GlobalMemoOptions,Self,
      'KeyMapping,Options,MarginPos,GutterWidth,GutterBrush,'+//don't resource
      'MarginPen,LineSeparator,LineHighlight,Font,Color,TextStyles,'+//don't resource
      'UseMonoFont,UseReadOnlyColor,ReadOnlyColor,SpecialSymbols');//don't resource
    Color := GlobalMemoOptions.Color;
    TextStyles.UpdateParams;
  finally
    TextStyles.EndParserUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCMemo.SetUseGlobalOptions(val : boolean);
begin
  if val <> fUseGlobalOptions then
    begin
      if val then
        LoadGlobalOptions;

      fUseGlobalOptions := val;

      if FMemoSource=nil then
        GetSource.UseGlobalOptions:=Val;
    end;
end;

{------------------------------------------------------------------}

function  TCustomDCMemo.GetUseGlobalOptions : boolean;
begin
  result := fUseGlobalOptions;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetLineNumColor(V : TColor);
begin
  if V <> FLineNumColor then
  begin
    FLineNumColor := V;
    if moLineNumbers in FOptions then
      Invalidate;
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.GetRealGutterWidth : integer;
begin
  if (moDrawGutter in FOptions) then
  begin
    result := FGutterWidth;
    if (moLineNumbers in Options) and (moLineNumbersOnGutter in Options) then
      result := Max(FLineNumbersWidth +  FGutterLineIndent + 2 , FGutterWidth);
  end
  else
    result := 0;
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}

procedure TCustomDCMemo.DrawToBitmap(bitmap : TBitmap);
var
  hbmp   : THandle;
  dc     : THandle;
  oldbmp : THandle;
begin
  dc := CreateCompatibleDC(Canvas.Handle);
  hbmp := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);
  oldbmp := SelectObject(dc, hbmp);
  try
    bitmap.Handle := hbmp;
    PaintTo(dc, 0, 0);
  finally
    SelectObject(dc, oldbmp);
    DeleteDC(dc);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCMemo.DrawToBMPFile(const FileName : string);
var
  bitmap : TBitmap;
begin
  bitmap := TBitmap.Create;
  try
    DrawToBitmap(bitmap);
    bitmap.SaveToFile(FileName);
  finally
    bitmap.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCMemo.DrawToEMFWMF(const FileName : string; enhanced : boolean);
var
  metafile : TMetaFile;
begin
  metafile := TMetaFile.Create;
  try
    metafile.enhanced := enhanced;
    metafile.Width := Width;
    metafile.Height := Height;
    DrawToMetaFile(metafile, 0);
    metafile.SaveToFile(FileName);
  finally
    metafile.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCMemo.DrawToFile(FileName: string; GraphicsFormat: TDCGraphicsFormat);
begin
  case GraphicsFormat of
    gfBitmap : DrawToBMPFile(FileName);
    gfMetafile : DrawToEMFWMF(FileName, false);
    gfEnhancedMetafile : DrawToEMFWMF(FileName, true);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCMemo.DrawBitmapToClipboard;
var
  bitmap : TBitmap;
begin
  bitmap := TBitmap.Create;
  try
    DrawToBitmap(bitmap);
    Clipboard.Assign(bitmap);
  finally
    bitmap.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCMemo.DrawMetaFileToClipboard(enhanced : boolean);
var
  metafile : TMetaFile;
begin
  metafile := TMetaFile.Create;
  try
    metafile.enhanced := enhanced;
    metafile.Width := Width;
    metafile.Height := Height;
    DrawToMetaFile(metafile, 0);
    Clipboard.Assign(metafile);
  finally
    metafile.Free;
  end;
end;
{$ENDIF}

{------------------------------------------------------------------}

function  TCustomDCMemo.CreatePrintDialog : TCustomForm;
begin
  {$IFNDEF CLX}
  result := TMemoPrintForm.Create(Application);
  if Assigned(FOnCreateDialog) then
    FOnCreateDialog(Self, result);
  {$ELSE}
  result := nil;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function  TCustomDCMemo.CreatePrintProgressDialog : TCustomForm;
begin
  {$IFNDEF CLX}
  result := TMemoPrintProgress.Create(Application);
  if Assigned(FOnCreateDialog) then
    FOnCreateDialog(Self, result);
  {$ELSE}
  result := nil;  
  {$ENDIF}
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}

procedure TCustomDCMemo.PrintWithDialog;
var
  FileName : string;
  Dialog   : TCustomForm;
begin
  Printer.Handle;//check for printers
  Dialog := CreatePrintDialog;
  if Dialog = nil then
    exit;
  with  TMemoPrintForm(Dialog) Do
  begin
    try
      POptions := PrintOptions;
      PrintSelCheck.Enabled := GetSource.SelectionType <> stNotSelected;
      PrintSelCheck.Checked := PrintSelCheck.Enabled;
      if GetSource.ObjectName <> '' then
        FileName := GetSource.ObjectName
      else
        FileName := SFileNameUnknown;
      lblFileName.Caption := FileName;
      FLastSource := GetSource;
      if (ShowModal = mrOk) and (FLastSource <> nil) then
      begin
        PrintOptions := POptions;
        PrintIndent := StrToIntDef(LeftMarginEdit.Text, 0);
        Self.Print;
      end;
    finally
      Free;
    end;
  end;
end;

{------------------------------------------------------------------}

function  TCustomDCMemo.DoBeforePrint(const s : string; PrintType : TPrintType) : string;
begin
  result := s;
  if Assigned(FOnBeforePrint) then
    FOnBeforePrint(Self, result, PrintType);
end;

{------------------------------------------------------------------}

procedure TCustomDCMemo.Print;
var
  MetaFile          : TMetaFile;
  PrintMemo         : TDCMemo;
  PageWidth         : integer;
  PageHeight        : integer;
  cPages            : integer;
  iPage             : integer;
  PX                : integer;
  PY                : integer;//Printer pixels per inch
  CX                : integer;
  CY                : integer;//Control pixels per inch
  PrinterLineHeight : integer;
  FileName          : string;
  MetaFileRect      : TRect;
  LinesPerPage      : integer;

  {--------------------------------------------------------}

  procedure CreatePrintMemo;
  begin
    PrintMemo := TDCMemo.Create(nil);
    PrintMemo.Visible := false;
    {$IFDEF D3}
    if Parent <> nil then
      PrintMemo.Parent := Parent
    else
      PrintMemo.ParentWindow := ParentWindow;
    {$ELSE}
    PrintMemo.Parent := Parent;
    {$ENDIF}
    PrintMemo.PrintOptions := PrintOptions;
    PrintMemo.LineNumColor := LineNumColor;
    PrintMemo.LineNumAlign := LineNumAlign;
    PrintMemo.StringsOptions := StringsOptions;
    PrintMemo.SyntaxParser := SyntaxParser;
    PrintMemo.Delimeters := Delimeters;
    PrintMemo.SelColor := SelColor;
    PrintMemo.SelBackColor := SelBackColor;
    PrintMemo.MatchColor := MatchColor;
    PrintMemo.MatchBackColor := MatchBackColor;
    PrintMemo.BorderStyle := BorderStyle;
    PrintMemo.Options := Options;
    if moLeftIndent in Options then
      PrintMemo.LeftIndent := LeftIndent
    else
    if PrintIndent <> 0 then
    begin
      PrintMemo.Options := PrintMemo.Options + [moLeftIndent];
      PrintMemo.LeftIndent := PrintIndent;
    end;
    PrintMemo.UseMonoFont := UseMonoFont;
    PrintMemo.TextStyles := TextStyles;
    if UsePrinterFont then
      PrintMemo.Font := PrinterFont
    else
      PrintMemo.Font := Font;
    PrintMemo.Color := Color;
    PrintMemo.Options := PrintMemo.Options - [moDrawGutter, moDrawMargin, moLineNumbers];
    PrintMemo.HighlightUrls := HighlightUrls;
    PrintMemo.LineNumBackColor:=LineNumBackColor;
    Printmemo.LineNumColor:=LineNumColor;
    if poWrapLines in PrintOptions then
    begin
      Printmemo.WordWrap := true;
      Printmemo.MarginPos := MarginPos;
    end;
  end;

  {--------------------------------------------------------}

  function GetPageSize : integer;
  begin
    result := PrintMemo.GetMaxCaretLineEx(PageHeight) + 1;
  end;

  {--------------------------------------------------------}

  procedure CalcSize;
  var
    ACount : integer;
  begin
    PX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    PY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
    CX := GetDeviceCaps(PrintMemo.Canvas.Handle, LOGPIXELSX);
    CY := GetDeviceCaps(PrintMemo.Canvas.Handle, LOGPIXELSY);
    PrinterLineHeight := (PrintMemo.LineHeight * PY) Div CY;
    with Printer.Canvas do
    begin
      Font := PrintMemo.Font;
      Font.Style := Font.Style + [fsBold];
    end;
    if PrintMemo.UseMonoFont then
    begin
      PageWidth := (((Printer.PageWidth * CX) div PX) div PrintMemo.CharWidth) *
                    PrintMemo.CharWidth;
      PageHeight := (((Printer.PageHeight * CY) div PY) div PrintMemo.LineHeight) *
                   PrintMemo.LineHeight;
    end
    else
    begin
      PageWidth := (Printer.PageWidth * CX) div PX;
      PageHeight := (Printer.PageHeight * CY) div PY;
    end;

    MetaFileRect := Rect(0, PrintMemo.LineHeight, Printer.PageWidth, Printer.PageHeight);
    if poPrintHeader in PrintMemo.PrintOptions then
    begin
      Dec(PageHeight, PrintMemo.LineHeight);
      Inc(MetaFileRect.Top, PrinterLineHeight);
    end;
    PrintMemo.FPrintPageSize  := Point(PageWidth, PageHeight);
    MetaFile.Width := PageWidth;
    MetaFile.Height := PageHeight;


    with PrintMemo do
    begin
      if poWrapLines in PrintOptions then
      begin
        PrintMemo.ClientWidth := PageWidth;
        WordWrapLines(0, PrintMemo.Lines.Count, true);
      end;
      if UseMonoFont then
      begin
        if WordWrap then
        begin
          GetSource.JumpToFileEnd;
          ACount := GetRealStrCount;
          GetSource.JumpToFileBegin;
        end
        else
          ACount := Lines.Count;
        cPages := (ACount * LineHeight + PageHeight - 1) div PageHeight
      end
      else
      begin
        cPages := 1;
        ACount := GetPageSize;
        while WinLinePos + ACount <= GetRealStrCount do
        begin
          WinLinePos := WinLinePos + ACount;
          inc(CPages);
          ACount := GetPageSize;
        end;
        WinLinePos := 0;
      end;
    end;
    LinesPerPage := PageHeight div PrintMemo.LineHeight;
  end;

  {--------------------------------------------------------}

  procedure CreateAllParams;
  var
    I      : integer;
    ALine  : integer;
    AState : integer;
  begin
    if GetSource.ObjectName <> '' then
      FileName := GetSource.ObjectName
    else
      FileName := SFileNameUnknown;
    if poPrintSel in PrintMemo.PrintOptions then
      FileName := SFileSelectedBlock;
    with PrintMemo do
    begin
      if (poPrintSyntax in PrintOptions) then
      begin
        Options := Options + [moColorSyntax];
        GetSource.SyntaxParser := Self.SyntaxParser;
      end
      else
      begin
        Options := Options - [moColorSyntax];
        SyntaxParser := nil;
      end;
      if not (poInColor in PrintOptions) then
      begin
        Font.Color := clBlack;
        Color := clWindow;
        for I := 0 to TextStyles.Count - 1 do
          with TextStyles[I] do
          begin
            UseMemoColor := true;
            Font.Color := clBlack;
          end;
        LineNumBackColor := clWindow;
        LineNumColor := clWindowText;
      end;
      if poPrintSel in PrintOptions then
      begin
        AState := 0;
        with TMSource(Self.GetSource) do
          if SelectionType <> stNotSelected then
          begin
            with SelectionRect do
              ALine := Min(Top, Bottom);
            if StringItem[ALine] <> nil then
              AState := StringItem[ALine].ParserState;
          end;
        TMSource(GetSource).DefaultParserState := AState;
        Self.GetSource.AssignLines(Lines, true);
      end
      else
        Self.GetSource.AssignLines(Lines, false);
      if poLineNumbers in PrintOptions then
      begin
        Options := Options + [moLineNumbers];
        FLineNumbersLength := 0;
        UpdateLineNumbersWidth;
      end;
      GetSource.JumpToFileBegin;
    end;
  end;

  {--------------------------------------------------------}

  procedure Step;
  begin
    if poShowProgress in PrintOptions Then
      MemoPrintProgress.ProgressBar.StepIt;
    Application.ProcessMessages;
  end;

  {--------------------------------------------------------}

  procedure PrintPage;
  var
    TextSize : TSize;
    PageStr  : string;
  begin
    if poShowProgress in PrintOptions then
      MemoPrintProgress.lblProgress.Caption := Format(SPrintingPage, [iPage + 1,IntToStr(cPages)]);
    Step;
    if iPage <> 0 then
      with PrintMemo do
      if UseMonoFont then
        ScrollScreenVert(LinesPerPage)
      else
        WinLinePos := WinLinePos + GetPageSize;

    PrintMemo.DrawToMetaFile(MetaFile, 0);
    Step;
    Printer.Canvas.StretchDraw(MetaFileRect, MetaFile);
    Step;
    if poPrintHeader in PrintMemo.PrintOptions then
    begin
      Printer.Canvas.Font.Color:=clBlack;
      Printer.Canvas.Textout(0, 0, DoBeforePrint(FileName, ptHeader));
      PageStr := DoBeforePrint(Format(SPageCaption,[iPage + 1,cPages]), ptFooter);
      GetTextExtentPoint32(Printer.Canvas.Handle, PChar(PageStr), Length(PageStr), TextSize);
      Printer.Canvas.Textout(Printer.PageWidth - (TextSize.cX)- TextSize.cX div Length(PageStr), 0, PageStr);
    end;
    Step;
  end;

  {--------------------------------------------------------}

const
  ControlDist = 2;

begin
  if Lines.Count = 0 then
    Exit;
  MemoPrintProgress := nil;
  PrintMemo := nil;
  MetaFile := TMetaFile.Create;
  try
    GetSource.BeginSafeUpdate(acCodeDesigner);
    if poShowProgress in PrintOptions then
    begin
      MemoPrintProgress := TMemoPrintProgress(CreatePrintProgressDialog);
      with MemoPrintProgress do
      begin
        Show;
        Application.ProcessMessages;
        lblPrinter.Caption := Format(SPrintingOnPrinter, [Printer.Printers[Printer.PrinterIndex]]);
        lblProgress.Caption := Format(SPrintingPage,[1, SMultiDot]);
        ProgressBar.Position := 0;
        Application.ProcessMessages;
      end;
    end;
    CreatePrintMemo;
    Application.ProcessMessages;
    PrintMemo.PrintOptions := PrintOptions;
    CreateAllParams;

    if poShowProgress in PrintOptions then
      with MemoPrintProgress do
        lblFileName.Caption := FileName;
    Application.ProcessMessages;
    CalcSize;
    Application.ProcessMessages;

    if poShowProgress in PrintOptions then
      with MemoPrintProgress do
      begin
        lblProgress.Caption:=Format(SPrintingPage, [1, IntToStr(cPages)]);
        pnlInfo.Height := lblProgress.Top + lblProgress.Height;
        ProgressBar.Top := pnlInfo.Top + pnlInfo.Height + ControlDist;
        btnCancel.Top := ProgressBar.Top + ProgressBar.Height + ControlDist;
        MemoPrintProgress.ClientHeight := btnCancel.Top + btnCancel.Height + ControlDist;
        ProgressBar.Max := cPages * 4;
        Application.ProcessMessages;
      end;
    if poShowProgress in PrintOptions then
      if MemoPrintProgress.ModalResult = mrCancel then
        Exit;
    try
      for iPage := 0 to cPages - 1 Do
      begin
        if iPage = 0 Then
          Printer.BeginDoc;
        if poShowProgress in PrintMemo.PrintOptions then
          if MemoPrintProgress.ModalResult=mrCancel then
            Break;
        if iPage <> 0 Then
          Printer.NewPage;
        PrintPage;
      end;

    finally
      if cPages <> 0 then
        Printer.EndDoc;
    End;
  Finally
    GetSource.EndUpdate;
    FreeObject(MemoPrintProgress,MemoPrintProgress);
    FreeObject(PrintMemo,PrintMemo);
    FreeObject(MetaFile,MetaFile);
  End;
End;

{------------------------------------------------------------------}

procedure TCustomDCMemo.CopyGraphicToClipboard(GraphicsFormat : TDCGraphicsFormat);
begin
  case GraphicsFormat of
    gfBitmap : DrawBitmapToClipboard;
    gfMetafile : DrawMetaFileToClipboard(false);
    gfEnhancedMetafile : DrawMetaFileToClipboard(true);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.DrawToMetaFile(AMetaFile : TMetaFile; DC : THandle);
Begin
  DrawToMetaFileEX(AMetaFile, DC, 0);
End;

{--------------------------------------------}

procedure TCustomDCMemo.DrawToMetaFileEx(AMetaFile : TMetaFile; DC : THandle; AY : integer);
var
  SavePaintWidth  : integer;
  SavePaintHeight : integer;
  SaveWidth       : integer;
  SaveHeight      : integer;
  SaveWinChar     :integer;
begin
//  Perform(WM_PAINT,Handle,0);
  SavePaintWidth := FPaintWidth;
  SavePaintHeight := FPaintHeight;
  SaveWidth := AMetaFile.Width;
  SaveHeight := AMetaFile.Height;
  with TMetafileCanvas.Create(AMetaFile, DC) do
    try
      FPaintWidth := SaveWidth;
      FPaintHeight := SaveHeight;
      FSpecialPaint := true;
      SaveWinChar := WinChar;
      WinChar := 0;
      SetViewportOrgEx(Handle, 0, -AY, nil);
      Perform(WM_PAINT, Handle, 0);
      WinChar := SaveWinChar;
    finally
      FSpecialPaint := false;
      FPaintWidth := SavePaintWidth;
      FPaintHeight := SavePaintHeight;
      Free;
    end;
end;

{$ENDIF}

{--------------------------------------------}

procedure TCustomDCMemo.PaintLineNumbers;
var
  i            : integer;
  y            : integer;
  S            : string;
  _GutterWidth : integer;
  Pt           : TPoint;
  H            : integer;
  AHeight      : integer;
  Offset       : integer;
  Len          : integer;
  ACanvas      : TCanvas;
  {$IFDEF CLX}
  AFontInfo    : PFontInfo;
  {$ENDIF}

  {----------------------------------------}

  function GetByteIndex(Pt : TPoint) : integer;
  begin
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      result := _CharToByte(Lines[Pt.Y], Pt.X + 1) - 1
    else
      result := Pt.X;
    {$ELSE}
      result := Pt.X;
    {$ENDIF}
  end;

  {----------------------------------------}

  procedure _inc;
  begin
    if FWordWrap then
    begin
      inc(i, GetWordBreakCount(Pt.Y, GetByteIndex(Pt), Pt.Y) + 1)
    end
    else
      inc(i);
  end;
  {----------------------------------------}

begin
  if not (moLineNumbers in FOptions) then
    exit;

  ACanvas := GetDrawCanvas;
  ACanvas.Brush.Color := Color;
  SetDCColor(FLineNumColor, Color);

  {$IFNDEF CLX}
  SetBkMode(GetDrawCanvas.Handle, TRANSPARENT);
  {$ENDIF}
  if (moLineNumbersOnGutter in Options) and (GetRealGutterWidth <> 0) then
  begin
     if FLineNumAlign = taRightJustify then
       _GutterWidth := GetRealGutterWidth - FLineNumbersWidth - FGutterLineIndent
     else
       _GutterWidth := FGutterLineIndent;

  end
  else
  begin
    _GutterWidth := GetRealGutterWidth;
    if (moLeftIndent in FOptions) and (FLeftIndent > 0) then
      inc(_GutterWidth, FLeftIndent);
  end;

  try
    if FUseMonoFont then
    begin
      y := FDrawRect.Top;
      i := y div LineHeight + WinLine;
    end
    else
    begin
      y := 0;
      i := WinLine;
    end;

    {$IFDEF CLX}
    AFontInfo := GetFontInfo(Font.Handle);
    {$ENDIF}
    CheckVisibleIndex(i, false);
    with TMSource(GetSource) do
      while y < FDrawRect.Bottom do
      begin
        Pt := GetRealPosition(Point(0, i));
        if HideLines and not GetRealLineVisible(Pt.Y) then
        begin
          _inc;
          continue;
        end;

        if Pt.X = 0 then
          S := IntToStr(Pt.Y + 1)
        else
          S := '';
        if FLineNumAlign = taLeftJustify then
          S := S + StringOfSpace(FLineNumbersLength - Length(S))
        else
          S := StringOfSpace(FLineNumbersLength - Length(S)) + S;

        if Assigned(FOnGetLineNumber) then
          FOnGetLineNumber(Self, S, Len);

        if FWordWrap and (Lines[Pt.Y] <> '') then
        begin
          Offset := GetByteIndex(Pt) + 1;
          AHeight := GetWrappedLineHeightEx(Pt.Y, Offset, H, false, true);
          Offset := GetByteIndex(Pt) + 1;
          H := GetWrappedLineHeightEx(Pt.Y, Offset, H, true, true);
        end
        else
        begin
          H := GetRealLineHeight(Pt.Y);
          AHeight := H;
        end;

        if (FPrintPageSize.Y = 0) or (Y + H <= FPrintPageSize.Y) then
        begin
          if (GetRealGutterWidth = 0) or not (moLineNumbersOnGutter in FOptions) then
            with ACanvas do
            begin
              Brush.Color := FLineNumBackColor;
              FillRect(Rect(_GutterWidth, Y, FLineNumbersWidth + _GutterWidth, Y + AHeight));
            end;
          Offset := Max((H - LineHeight) div 2, 0);
          if not ((moLimitLineNumbers in Self.FOptions) and (Pt.Y >= Lines.Count)) then
          begin
            {$IFNDEF CLX}
            ACanvas.TextOut(_GutterWidth, Y + Offset, S);
            {$ELSE}
            QTextOut(ACanvas, Rect(_GutterWidth, Y + Offset, _GutterWidth + FLineNumbersWidth, Y + Offset + AHeight), PChar(s),
                     length(s), AFontInfo, false, nil);
            {$ENDIF}
          end;  
        end;
        inc(Y, AHeight);
        _inc;
      end;
  finally
  {$IFNDEF CLX}
    SetBkMode(GetDrawCanvas.Handle, OPAQUE);
  {$ENDIF}
  end;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.GetLineNumbersLength : integer;
var
  ACount   : integer;
  AMaxLine : integer;
begin
  ACount := GetSource.StrCount;
  if moLimitLineNumbers in Options then
    result := Length(IntToStr(ACount))
  else
  begin
    AMaxLine := GetRealPosition(Point(0, WinLine + GetMaxCaretLine + 1)).Y;
    result := Length(IntToStr(Max(AMaxLine + 1, ACount) ));
  end;  
end;

{-------------------------------------------------------------}

function TCustomDCMemo.GetLineNumbersWidth : integer;
begin
  if HandleAllocated then
    FLineNumbersWidth := GetAveCharWidth * (FLineNumbersLength + 1);
  result := FLineNumbersWidth;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.UpdateLineNumbersWidth : boolean;
var
  OldLength : integer;
  s         : string;
begin
  result := moLineNumbers in FOptions;
  if not result then
    exit;
  OldLength := FLineNumbersLength;
  FLineNumbersLength := GetLineNumbersLength;

  if Assigned(FOnGetLineNumber) then
  begin
    s := '';
    FOnGetLineNumber(Self, s, FLineNumbersLength);
  end;

  result := OldLength <> FLineNumbersLength;

  if result and HandleAllocated then
  begin
    GetLineNumbersWidth;
    WordWrapLines(0, MaxInt, true);
    FGutterBackground.PaintBackground;
    UpdateCaret;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.CalcGutterImgSize(Index : integer; var NewWidth, NewHeight : integer);
begin
  with TGutterImage(FGutterImgs.Items[Index]).Glyph do
  begin
    NewHeight := Min(Height, LineHeight - 1);
    if NewHeight <> Height then
      NewWidth := MulDiv(Width, NewHeight, Height)
    else
      NewWidth := Width;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.PaintGutterImages;
var
  k          : integer;
  y          : integer;
  i          : integer;
  x          : integer;
  ImageCount : integer;
  MaxX       : integer;
  ACount     : integer;
  Pos        : integer;
  Pt         : TPoint;

  {----------------------------------------------------}

  procedure AssignX;
  begin
    if FGutterImgsAlign = iaLeft then
      X := 1
    else
      X := MaxX - 1;
  end;

  {----------------------------------------------------}

  function PaintGutterImage(Index : integer) : boolean;
  var
    NewWidth  : integer;
    Newheight : integer;
    CenterInc : integer;
    Bitmap    : TBitmap;
  begin
    result := true;
    if (Index >= FGutterImgs.Count) then
      exit;
    Bitmap := TGutterImage(FGutterImgs.Items[Index]).Glyph;
    with  Bitmap do
    begin
      CalcGutterImgSize(Index, NewWidth, NewHeight);

      result := (((X + 1 + NewWidth) > MaxX) and (FGutterImgsAlign = iaLeft)) or
                 (((X + 1 - NewWidth) < 0) and (FGutterImgsAlign = iaRight));
      if result then
        exit;

      CenterInc := (GetRealLineHeight(i) - NewHeight) div 2;
      if FGutterImgsAlign = iaRight then
        Dec(X, NewWidth + 1);

      {$IFNDEF CLX}
      TransparentBitBltEx(Canvas.Handle, GetDrawCanvas.Handle, Rect(0, 0, Width, Height),
        Rect(X, Y + CenterInc, X + NewWidth, Y + CenterInc + NewHeight), TransparentColor);
      {$ELSE}
      Self.Canvas.Draw(X, Y + CenterInc, Bitmap);
      {$ENDIF}
    end;
    if FGutterImgsAlign = iaLeft then
      Inc(X, NewWidth + 1);
  end;

  {----------------------------------------------------}

  procedure PaintBookMark(BookIndex : integer);
  begin
    if BookIndex in [1..10] then
    begin
      if BookIndex = 10 then
        BookIndex := 0;
      BookIndex := FBookmarkImgIndex[BookIndex];
      if (BookIndex <> 0) then
        PaintGutterImage(BookIndex - 1);
    end;
  end;

  {----------------------------------------------------}

  function IterateLines(Index, CPos : integer ; APaint : boolean) : integer;    
  var
    Pos    : integer;
    H      : integer;
    s      : string;
    OldPos : integer;
  begin

    if not TMSource(GetSource).GetRealLineVisible(Index) then
    begin
      result := 0;
      exit;
    end;

    result := 1;
    if FWordWrap then
    begin
      s := GetSource.Strings[index];
      if s <> '' then
      begin
        Pos := CPos;
        result := 0;
        while Pos <= length(s) do
        begin
          OldPos := Pos;
          H := GetWrappedLineHeightEx(index, Pos, H, true, true);
          if Pos > length(s) then
            Pos := MaxInt;
          if APaint then
          begin
            with TMSource(GetSource) do
            {$IFDEF DCMBCS}
              if SysLocale.FarEast then
                PaintBookMark(GetBookmarkFromRange(Index, _ByteToChar(s, OldPos) - 1, _ByteToChar(s, Pos) - 1))
              else
                PaintBookMark(GetBookmarkFromRange(Index, OldPos - 1, Pos - 1));
            {$ELSE}
              PaintBookMark(GetBookmarkFromRange(Index, OldPos - 1, Pos - 1));
            {$ENDIF}
            Inc(Y, H);
            AssignX;
          end;
          inc(result);
        end;
      end
      else
        if APaint then
        begin
          PaintBookMark(TMSource(GetSource).GetBookmarkFromRange(Index, 0 ,MaxInt));
          Inc(Y, LineHeight);
        end;
    end;
  end;

  {----------------------------------------------------}

begin
  ImageCount := FGutterImgs.Count;
  if ImageCount = 0 then
    exit;

  MaxX := GetRealGutterWidth - 3;
  if FUseMonoFont then
  begin
    y := FDrawRect.Top;
    i := y div LineHeight + WinLine;
  end
  else
  begin
    y := 0;
    i := WinLine;
  end;

  Pt := GetRealPosition(Point(0, i));

  CheckVisibleIndex(Pt.Y, false);

  with Pt do
  begin
    i := Y;
    Pos := X + 1;
  end;
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    Pos := _ByteToChar(Lines[i], Pos);
  {$ENDIF}
  with TMSource(GetSource) do
    while y < FDrawRect.Bottom do
    begin
      AssignX;
      ACount := IterateLines(i, Pos, false);
      if ACount > 0 then
        for k := 0 to ImageCount - 1 do
          if GetSource.ImageBit[i, k] then
            if PaintGutterImage(k) then
            begin
              Inc(Y, GetWrappedLineHeight(i));
              inc(i);
              Pos := 1;
              continue;
            end;

      if FWordWrap then
        IterateLines(i, Pos, true)
      else
      if GetRealLineVisible(i) then
      begin
        PaintBookMark(TMSource(GetSource).Bookmark[i]);
        Inc(Y, ACount * GetRealLineHeight(i));
      end;
      inc(i);
      Pos := 1;
    end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetDCColor(FontColor, BackColor : TColor);
begin
  with GetDrawCanvas do
  begin
    Font.Color := FontColor;
    Brush.Color := BackColor;
    {$IFDEF CLX}
    //QColor_setRgb(FInternalColor, 255,0,255);//Color); ////
    {$ENDIF}
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.TempHighlightLineWithStyle(Index : integer; const StyleName : string);
var
  StyleIndex : integer;
begin
  StyleIndex := TextStyles.IndexOfName(StyleName);
  if StyleIndex >= 0 then
    GetSource.TempHighlightLine(Index, StyleIndex);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetHighlightUrls : boolean;
begin
  result := GetSource.HighlightUrls;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetHighlightUrls(Value : boolean);
begin
  GetSource.HighlightUrls := Value;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetAllowUndo  : boolean;
begin
  result := GetSource.AllowUndo;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetAllowUndo(Value : boolean);
begin
  GetSource.AllowUndo := Value;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetUndoLimit : integer;
begin
  result := GetSource.UndoLimit;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetUndoLimit(Value : integer);
begin
  GetSource.UndoLimit := Value;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.GetSelAttributes : TMemoAttributes;
var
  AParser : TAttributeParser;
begin
  result := FSelAttributes;
  if SyntaxParser = nil then
  begin
    with FSelAttributes do
    begin
      Assign(Self.Font);
      BkColor := Self.Color;
    end;
    AParser := TAttributeParser.Create(Self);
    SyntaxParser := AParser;
  end;
  if SyntaxParser is TAttributeParser then
    with result, GetSource do
    begin
      if SelectionType = stNotSelected then
        with CaretPoint do
          TAttributeParser(SyntaxParser).GetAttribute(CaretPoint, result)
      else
        with SelectionRect.TopLeft do
          TAttributeParser(SyntaxParser).GetAttribute(Point(X + 1, Y), result);
    end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetSelAttributes(Value : TMemoAttributes);
begin
  FSelAttributes.Assign(Value);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetBlockOption : TBlockOption;
begin
  result := GetSource.BlockOption;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetBlockOption(Value : TBlockOption);
begin
  GetSource.BlockOption := Value;
  FWBlockChanged := false;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetWordWrap(Value : boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    WordWrapLines(0, MaxInt, true);
    if not (Value or FUseMonoFont) then
      TMSource(GetSource).ParserChanged;
    CheckBlockOptions(Value);
    if Value then
      WinChar := 0
    else
    begin
      WordWrapUpdated;
      Invalidate;
    end;
    UpdateMaxLine(false);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.WordWrapUpdated;
begin
  if not FWrapCheck then
  begin
    RecalculatePosition;
    UpdateCaret;
  end;
  UpdateScrollSize;
  UpdateScrollPos;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.FindWordBreak(LinePos : integer; var Pos, BaseLine : integer; var R : TRect) : string;
var
  i      : integer;
  idx    : integer;
  Len    : integer;
  s      : string;
  ColorS : string;
begin
  if FUseMonoFont then
  begin
    Len := FWbCount;
    s := Lines[LinePos];
    R := Rect(0, 0, 0, 0);
    BaseLine := 0;
  end
  else
  begin
    GetStrData(LinePos, S, ColorS);
    R := Rect(0, 0, GetWrapMargin  - GetPaintX, LineHeight);
    len := Max(SymbolsDrawn(LinePos, Pos, copy(S, Pos, length(s) - Pos + 1), copy(ColorS, Pos, length(ColorS) - Pos + 1),
           BaseLine, R, true, false) - 1, 1);
  end;
  if length(s) - Pos > Len then
  begin
    idx := -1;
    with TMSource(GetSource) do
      for i := Len + Pos downto Pos do
        if InDelimSet(s, i)  then
        begin
          idx := i;
          break;
        end;
    if idx = -1 then
      idx := Len + Pos;
    {$IFDEF DCMBCS}
    if _IsTrailByte(s, idx + 1) then
      dec(idx);
    {$ENDIF}
    result := Copy(s, Pos, idx - Pos + 1);
    if not FUseMonoFont then
      R.BottomRight := CalcStringSize(S, ColorS, Pos - 1, idx - Pos + 1, BaseLine);

    Pos := idx + 1;
  end
  else
  begin
    result := Copy(s, Pos, length(s) - Pos + 1);
    Pos := length(s) + 1;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.GetWordBreakCount(FromIndex, Pos, ToIndex : integer) : integer;
var
  WB    : TWBPoint;
  Index : integer;
  Exact : boolean;
begin
  result := 0;
  if FromIndex > ToIndex then
    exit;
  WB.X := 0;
  WB.Y := ToIndex + 1;
  with FWordBreakList do
  begin
    Index := FindNear(@WB, false, Exact);
    while (Index >=0) and (Index < Count) do
    begin
      WB := PWBPoint(Items[Index])^;
      if (WB.Y = FromIndex) and (WB.X <= Pos) then
        break;
      if (WB.Y >= FromIndex) and (WB.Y <= ToIndex) then
        inc(result)
      else
        break;
      dec(Index);
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.GetWrappedPos(Index : integer; var Pos : integer);
var
  WB     : TWBPoint;
  AIndex : integer;
  found  : boolean;
  Exact  : boolean;
begin
  CheckLastWrappedLine(Index);
  Wb.X := Pos - 1;
  Wb.Y := Index;
  found := false;
  AIndex := FWordBreakList.FindNear(@Wb, false, Exact) + 1;
  if (AIndex >= 0) and (AIndex < FWordBreakList.Count) then
  begin
    Wb := PWBPoint(FWordBreakList[AIndex])^;
    if Wb.Y = Index then
    begin
      Pos := Wb.X + 1;
      found := true;
    end;
  end;
  if not found then
    Pos := Length(Lines[Index]) + 1;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.GetWrapLines(AStrings : TStrings);
var
  i   : integer;
  len : integer;
  Pos : integer;
  Cur : integer;
  s   : string;
begin
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    if FWordWrap then
    begin
      for i := 0 to Lines.Count  - 1 do
      begin
        s := Lines[i];
        len := Length(s);
        if len > 0 then
        begin
          Pos := 1;
          while Pos <= len do
          begin
            Cur := Pos;
            GetWrappedPos(i, Pos);
            AStrings.Add(Copy(s, Cur, Pos - Cur));
          end;
        end
        else
          AStrings.Add(S);
      end;    
    end
    else
      AStrings.Assign(Lines);
  finally
    AStrings.EndUpdate;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.GetBlockWrapLines(AStrings : TStrings);
var
  i   : integer;
  len : integer;
  Pos : integer;
  Cur : integer;
  s   : string;

  {-----------------------------------------------------}

  function _Get(a : integer) : integer;
  begin
    result := a;
    TMSource(GetSource).ChangeTabIndex(s, result);
  end;

  {-----------------------------------------------------}

begin

  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    with GetSource do
      if FWordWrap and (SelectionType = stStreamSel) then
      begin
        for i := 0 to SelStrings.Count  - 1 do
        begin
          with SelectionRect do
          begin
            s := Lines[i + Top];
            if s = '' then
              AStrings.Add(s)
            else
            begin
              if Top = Bottom then
              begin
                Pos := _Get(Left + 1);
                len := _Get(Right);
              end
              else
              if i = 0 then
              begin
                Pos := _Get(Left + 1);
                len := Length(s);
              end
              else
              if i = Bottom - Top then
              begin
                Pos := 1;
                len := _Get(Right);
              end
              else
              begin
                Pos := 1;
                len := Length(s);
              end;
              len := Min(len, length(s));
              while Pos <= len do
              begin
                Cur := Pos;
                GetWrappedPos(i + Top, Pos);
                Pos := Min(Pos, Len + 1);
                AStrings.Add(Copy(s, Cur, Pos - Cur));
              end;
            end;
          end;
        end;
      end
      else
        AStrings.Assign(SelStrings);
  finally
    AStrings.EndUpdate;
  end;
end;


{-------------------------------------------------------------}

procedure TCustomDCMemo.CheckWBCount(AUpdate : boolean);
begin
  if (FWbCount <= 1) or AUpdate then
    if moBreakWordAtMargin in Options then
      FWbCount := Max(MarginPos - 1, 1)
    else
      FWbCount := Max(GetMaxCaretChar, 1)
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.WordWrapLines(FromIndex, ToIndex : integer; AInvalidate : boolean);
var
  i       : integer;
  Pos     : integer;
  s       : string;
  Index   : integer;
  LCount  : integer;
  ALine   : integer;
  Update  : boolean;
  R       : TRect;
  H       : integer;
  lpassed : boolean;

  {------------------------------------------------------}

  function  NewWBRecord(AX : integer) : PWBPoint;
  begin
    new(result);
    with result^ do
    begin
      Y := i;
      X := AX;
      Size := Point(R.Right - R.Left, R.Bottom - R.Top);
      BaseLine := ALine;
    end;
  end;

  {------------------------------------------------------}

begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if not FWordWrap or (Lines.Count = 0) then
  begin
    FWordBreakList.Clear;
    FLineInfoList.Clear;
    FLastWrappedLine := 0;
    exit;
  end;
  if  FUseMonoFont then
    CheckWBCount(true)
  else
  begin
    if GetDrawCanvas = nil then
      exit;
    if NeedSyntaxPaint then
      if ToIndex = MaxInt then
        GetSource.ParseToString(WinLine + cMaxWrapDelta, true)
      else
        GetSource.ParseToString(ToIndex, true)
  end;

  LCount := GetWordBreakCount(FromIndex, 0, ToIndex);
  if not FUseMonoFont and (FromIndex = ToIndex) then
    H := GetWrappedLineHeight(FromIndex)
  else
    H := 0;

  with GetSource do
  begin
    if ToIndex = MaxInt then
    begin
      ToIndex := WinLine + cMaxWrapDelta;
      FLastWrappedLine := ToIndex;
      Update := true;
    end
    else
    begin
      FLastWrappedLine := Max(FLastWrappedLine, ToIndex);
      Update := false;
    end;

    Index := Min(ToIndex, Strings.Count - 1);
    if FromIndex > Index then
       exit;

    if (FromIndex = 0) and Update then
    begin
      FWordBreakList.Clear;
      FLineInfoList.Clear;
    end
    else
    begin
      FWordBreakList.ClearRange(FromIndex, Index);
      FLineInfoList.ClearRange(FromIndex, Index);
    end;
    for i := FromIndex to Index do
    begin
      s := Strings[i];
      if (s <> '') and ((FUseMonoFont and (length(s) > FWbCount)) or not FUseMonoFont) then
      begin
        Pos := 1;
        lpassed := false;
        while Pos <= length(s) do
        begin
          FindWordBreak(i, Pos, ALine, R);
          if Pos <= Length(S) then
          begin
            FWordBreakList.Add(NewWBRecord(Pos - 1));
            lpassed := true;
          end
          else
            if lpassed then
              FLineInfoList.Add(NewWBRecord(0));
        end;
      end;
    end;
  end;
  WordWrapUpdated;
  AInvalidate := true;
  if ((H <> 0) and (H <> GetWrappedLineHeight(FromIndex))) or (LCount <> GetWordBreakCount(FromIndex, 0, ToIndex)) then
    InvalidateLines(FromIndex, MaxInt, not AInvalidate)
  else
    InvalidateLines(FromIndex, ToIndex, not AInvalidate);
  if AInvalidate and (FromIndex = 0) and (ToIndex = MaxInt) then
    Invalidate
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetRealPosition(Position : TPoint) : TPoint;
begin
  result := GetRealPositionEx(Position, false);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetRealPositionEx(Position : TPoint; CheckMBCS : boolean) : TPoint;
var
  Index  : integer;
  WB     : TWBPoint;
  Exact  : boolean;
  {$IFDEF DCMBCS}
  s      : string;
  Pos    : integer;
  {$ENDIF}
begin
  result := Position;
  if FWordWrap then
  begin
    CheckLastWrappedLine(result.Y);
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      with Position do
      begin
        s := Lines[GetRealLineIndex(Position.Y, Pos)];
        WB.X := _CharToByte(Copy(s, Pos + 1, MaxInt), X + 1) - 1;
        result.X := Wb.X;
      end
    else
      WB.X := Position.X;
    {$ELSE}
    WB.X := Position.X;
    {$ENDIF}

    WB.Y := Position.Y;
    Index := FWordBreakList.FindNear(@Wb, true, Exact);
    if (Index >= 0) and (Index < FWordBreakList.Count) then
      with PWBPoint(FWordBreakList[index])^ do
      begin
        if Exact then
          inc(result.X, X);
        dec(result.Y, Index + 1);
      end;
    {$IFDEF DCMBCS}
    if SysLocale.FarEast and not CheckMBCS then
      with result do
        X := _ByteToChar(s, X + 1) - 1;
    {$ELSE}
    WB.X := Position.X;
    {$ENDIF}
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.CheckLastWrappedLine(LinePos : integer);
begin
  if FWordWrap and (LinePos >= FLastWrappedLine) then
  begin
    FWrapCheck := true;
    try
      WordWrapLines(FLastWrappedLine, LinePos + cFloatDelta, true);
    finally
      FWrapCheck := false;
    end;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.CalcWrapPos(LinePos, CharPos : integer; var APoint : TPoint) : boolean;
var
  Len    : integer;
  X      : integer;
  W      : integer;
  AWidth : integer;
  OldPos : integer;
begin
  OldPos := CharPos;
  Len := Length(Lines[LinePos]) - CharPos;
  AWidth := GetRealLineWidth(LinePos);
  X := GetWrappedLineWidth(LinePos, CharPos, false);
  if X <> maxInt then
    dec(AWidth, X);
  W := GetWrapMargin - GetPaintX;
  if AWidth < W then
    inc(Len, (W - AWidth) div CalcSpacesSize(1, Point(OldPos + len, LinePos)));
  result := Len < APoint.X; // last char - 1
  if result then
  begin
    inc(APoint.Y);
    APoint.X := 0;
  end;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetWBPosition(Position : TPoint) : TPoint;
var
  CheckMBCS : boolean;
  Pos       : integer;
begin
  {$IFDEF DCMBCS}
  CheckMBCS := SysLocale.FarEast;
  {$ELSE}
  CheckMBCS := false;
  {$ENDIF}
  result := GetWBPositionEx(Position, CheckMBCS, true, Pos);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetRealLineIndex(LinePos : integer; var Pos : integer) : integer;
var
  Index : integer;
  Wb    : TWbPoint;
  Exact : boolean;
begin
  Pos := 0;
  result := LinePos;
  if FWordWrap then
  begin
    Wb.X := 0;
    Wb.Y := LinePos;
    Index := FWordBreakList.FindNear(@Wb, true, Exact);
    if (Index >= 0) and (Index < FWordBreakList.Count) then
      with PWBPoint(FWordBreakList[index])^ do
      begin
        if Exact then
          Pos := X;
        dec(result, Index + 1);
      end;
   end;
end;

{-------------------------------------------------------------}
                                     {
procedure TCustomDCMemo.CheckLastChar(var Index: integer ; AX : integer);
begin
  with FWordBreakList do
    if (Index >= 0) and (Index < Count) then
      with PWBPoint(Items[Index])^ do
        if X = AX then
          inc(Index);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetWBPositionEx(Position : TPoint; CheckMBCS, ConvertResult : boolean; var Pos : integer) : TPoint;
var
  Index      : integer;
  Wb         : TWBPoint;
  InsideLine : boolean;
  Exact      : boolean;
  {$IFDEF DCMBCS}
  s          : string;
  {$ENDIF}

begin
  result := Position;
  if FWordWrap then
  begin
    CheckLastWrappedLine(result.Y);
    InsideLine := false;
    Pos := 0;
    {$IFDEF DCMBCS}
    CheckMBCS :=  CheckMBCS and SysLocale.FarEast;
    ConvertResult := ConvertResult and CheckMBCS;
    if CheckMBCS and (Position.X < MaxInt) then
    begin
      with Position do
      begin
        s := Lines[Y];
        Wb.X := _CharToByte(s, X + 1) - 1;
      end;
      result.X := WB.X;
    end
    else
      Wb.X := Position.X;
    {$ELSE}
    Wb.X := Position.X;
    {$ENDIF}

    Wb.Y := Position.Y;
    Index := FWordBreakList.FindNear(@Wb, false, Exact);
    //CheckLastChar(Index, Wb.X);                                /// last char

    if (Index >= 0) and (Index < FWordBreakList.Count) then
    begin
      with PWBPoint(FWordBreakList[Index])^ do
      begin
        if (Y = Position.Y) then
        begin
          dec(result.X, X);
          Pos := X;
          {$IFDEF DCMBCS}
          if ConvertResult then
            delete(s, 1, Pos);
          {$ENDIF}

          InsideLine := (Index < FWordBreakList.Count - 1) and (PWBPoint(FWordBreakList[Index + 1])^.Y = Y);
        end;
        if result.Y < MaxInt - Index  - 1 then
          inc(result.Y, Index + 1);
      end;
    end;
    if FUseMonoFont then
    begin
      CheckWBCount(false);
      if result.X > FWbCount + 1 then
      begin
        inc(result.Y, result.X div FWbCount);
        result.X := 0;
      end;
    end
    else
    if not InsideLine and HandleAllocated then
      CalcWrapPos(Position.Y, Pos, result);

    {$IFDEF DCMBCS}
    if ConvertResult then
      with result do
        X := _ByteToChar(s, X + 1) - 1;
    {$ENDIF}
  end;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.NeedSyntaxPaint : boolean;
begin
  result := ((SyntaxParser <> nil) and (moColorSyntax in Options)) or HighlightUrls;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.GetLineHeight(Sender : TObject; Index : integer; Item : TStringItem);
var
  Pt        : TPoint;
  ABaseLine : integer;
  S         : string;
  CS        : string;
//  AFont     : TFont;
begin
  with Item do
  begin
    LineHeight := Self.LineHeight;
    LineWidth := 0;
    BaseLine := 0;
    if not FUseMonoFont then
    begin
      S := Lines[Index];
      if NeedSyntaxPaint then
        Cs := TMSource(GetSource).GetStoredColorData(Index)
      else
        Cs := '';
      Pt := CalcStringSize(S, Cs, 0, length(S), ABaseLine);
      LineWidth := Pt.X;
      LineHeight := Pt.Y;
      BaseLine := ABaseLine;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.GetNavigation(Sender : TObject ; var DeltaLine, DeltaChar : integer);
var
  APoint    : TPoint;
  SavePoint : TPoint;
  checkEof  : boolean;
  AWrap     : boolean;
  Process   : boolean;
  
  {-------------------------------------------------}

  function CheckMemoIndent : boolean;
  var
    Pt : TPoint;
  begin
    with TMSource(GetSource) do
    begin
      result := FWordWrap and MemoGetIndent;
      if result then
      begin
        Pt := GetWBPosition(CaretPoint);
        Pt := GetRealPosition(Point(0, Pt.Y));
        if Pt.X <> 0  then
          DeltaChar := Pt.X;
      end;
    end;
  end;

  {-------------------------------------------------}

  procedure _CheckEof;
  begin
    if checkEof and (APoint.Y > GetRealStrCount + 1) then
      APoint.X := Min(APoint.X, GetWBStringLength(CaretPoint.Y, APoint.Y, true));
  end;

  {-------------------------------------------------}

  procedure ChangeDeltaLine(var DeltaLine : integer);
  begin
    with TMSource(GetSource), CaretPoint do
      if HideLines and (DeltaLine <> 0) then
      begin
        DeltaLine := VisibleToRealIndex(RealToVisibleIndex(Y) + DeltaLine) - Y;
        if (DeltaLine <> 0) and (not (soBeyondFileEnd in Options)) and (Y + DeltaLine >= Lines.Count)
           and not GetRealLineVisible(Lines.Count - 1) then
          DeltaLine := 0;
      end;
  end;

  {-------------------------------------------------}

  procedure _ChangePoint(AWrap, AVert : boolean);
  var
    Pos     : integer;
    AIndex  : integer;
    OldChar : integer;
  begin
    if AWrap then
      APoint := GetWBPosition(SavePoint)
    else
      APoint := SavePoint;

    if AVert then
    begin
      if not FVertFlag then
      begin
        FVertX := TextToPixelChar(SavePoint);
        FVertxChar := WinChar;
      end;
      FVertFlag := true;
      ChangeDeltaLine(DeltaLine);

      inc(APoint.Y, DeltaLine);

      AIndex := GetRealLineIndex(APoint.Y, Pos);
      if AIndex < 0 then
        if APoint.Y = 0 then
        begin
          APoint := SavePoint;
          exit;
        end
        else
        begin
          AIndex := 0;
          Pos := 0;
        end;
      OldChar := WinChar;
      try
        WinChar := FVertxChar;
        APoint.X := PixelToTextChar(AIndex, Pos + 1, FVertX, true);
      finally
        WinChar := OldChar;
      end;
      if AWrap then
      begin
        _CheckEof;
        APoint.Y := GetRealPosition(APoint).Y;
        exit;
      end;
    end
    else
    begin
      inc(APoint.X, DeltaChar);
      inc(APoint.Y, DeltaLine);
    end;
    _CheckEof;
    APoint := GetRealPosition(APoint);
  end;

  {-------------------------------------------------}

begin
  with TMSource(GetSource) do
  begin
    if ManualPosition then
    begin
      FVertFlag := false;
      exit;
    end;
    with CaretPoint do
      SavePoint := Point(X, Y);
  end;


  APoint := SavePoint;

  if DeltaChar <> 0 then
    FVertFlag := false;

  checkEof := not (soBeyondFileEnd in GetSource.Options);


  AWrap := FWordWrap and not CheckMemoIndent;
  Process := true;

  if AWrap or ((DeltaChar = 0) and (not FUseMonoFont or (soRetainColumn in GetSource.Options))) then
    _ChangePoint(AWrap, DeltaChar = 0)
  else
  {$IFDEF DCMBCS}
  if SysLocale.FarEast and (DeltaChar = 0) then
    _ChangePoint(false, true)
  else
    Process := false;
  {$ELSE}
    Process := false;
  {$ENDIF}

  if Process then
  begin
    with GetSource do
      if checkEof and (APoint.Y >= Strings.Count) and (GetRealStrCount >= 0) then
      begin
        APoint.Y := Strings.Count - 1;
        APoint.X := SavePoint.X;
      end;

    with SavePoint do
    begin
      DeltaLine := APoint.Y - Y;
      DeltaChar := APoint.X - X;
    end;
  end
  else
    ChangeDeltaLine(DeltaLine);

end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.CheckVisibleIndex(var Index : integer; AVisible : boolean);
begin
  if HideLines then
    if AVisible then
      Index := GetSource.RealToVisibleIndex(Index)
    else
      Index := GetSource.VisibleToRealIndex(Index);
end;

{-------------------------------------------------------------}

function TCustomDCMemo.DrawEof : boolean;
begin
  result := (moDrawSpecialSymbols in FOptions) and (FSpecialSymbols.EOFString <> '');
end;

{-------------------------------------------------------------}

function TCustomDCMemo.GetRealStrCountEx : integer;
begin
  result := GetRealStrCount;
  if DrawEof then
    inc(result);
end;

{-------------------------------------------------------------}

function TCustomDCMemo.GetRealStrCount : integer;
begin
  result := GetSource.StrCount - 1;
  if FWordWrap then
    inc(result, FWordBreakList.Count);
  if HideLines then
    with TMSource(GetSource) do
      dec(result, VisibleLinesList.Count);
end;

{-------------------------------------------------------------}


function  TCustomDCMemo.GetWBStringLength(RealIndex, Index : integer; CheckLineEnd : boolean) : integer;
var
  Wb    : TWBPoint;
  ALine : integer;
  s     : string;
  Exact : boolean;
begin
  result := _Length(GetSource.Strings[RealIndex]) + 1;
  if FWordWrap then
  begin
    Wb.X := 0;
    Wb.Y := Index + 1;
    Index := FWordBreakList.FindNear(@WB, true, Exact);

    ALine := WB.Y - Index - 1;

    if (Index >= 0) and (Index < FWordBreakList.Count) then
      with PWBPoint(FWordBreakList[Index])^ do
      begin
    //    ALine := Y;
       // result := 0;
        if Exact  then
        begin

          s := Copy(Lines[Y], 1, X);
          if (Index > 0) then
            with PWBPoint(FWordBreakList[Index - 1])^ do
              if Y = ALine then
                delete(s, 1, X);
          result := _Length(s)
        end
        else
        begin
          s := GetSource.Strings[Y];
          if not CheckLineEnd  and (Y = ALine - 1) then
          begin
            delete(s, 1, X);
            result := _Length(s) + 1;
          end;
        end;
      end;
  end

end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ToggleImageAndTextStyle(const StyleName : string);
var
  Index          : integer;
  TextStyleIndex : integer;
  GutterImgIndex : integer;
begin
  TextStyleIndex := TextStyles.IndexOfName(StyleName);
  GutterImgIndex := GutterImgs.IndexOfName(StyleName);
  if (GutterImgIndex < 0) or (TextStyleIndex < 0) then
    exit;
  with GetSource do
    if CurLinePos < StrCount then
    begin
      ImageBit[CurLinePos, GutterImgIndex] := not ImageBit[CurLinePos, GutterImgIndex];
      if ImageBit[CurLinePos, GutterImgIndex] then
        Index := TextStyleIndex
      else
        Index := 0;
      if Index >= 0 then
        LineTextStyle[CurLinePos] := Index;
    end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetHideSelection(V : Boolean);
begin
  if FHideSelection <> V then
  begin
    FHideSelection := V;
    if (not Focused) then
      Invalidate;
  end;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetSelBkColor : TColor;
begin
  if FHideSelection and not Focused then
    result := Color
  else
    result := FSelBackColor;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetSelColor : TColor;
begin
  if FHideSelection and not Focused then
    result := GetDrawCanvas.Font.Color
  else
    result := FSelColor;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.TempBackGround : TBitmap;
begin
  result := FMemoBackGround.TempBackground;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetFontColorFromTextStyle(Style : integer) : TColor;
begin
  result := GetFontFromTextStyle(Style).Color;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.DoGetFontFromStyle(Style : integer; Font : TFont; var Color : TColor);
begin
  if Assigned(FOnGetFontFromStyle) then
    FOnGetFontFromStyle(Self, Style, Font, Color);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetFontFromTextStyle(Style : integer) : TFont;
var
  AColor : TColor;
begin
  if not FUseTextStyle and (SyntaxParser <> nil) then
    result := SyntaxParser.GetFont(Style)
  else
    result := nil;
  if (result = nil) and (Style >= 0) and (Style < TextStyles.Count) then
    result := TextStyles[Style].Font;
  if result = nil then
    result := Font;
  DoGetFontFromStyle(Style, Font, AColor);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetColorFromTextStyle(Style : integer) : TColor;
var
  AParser : TSimpleParser;
begin
  AParser := SyntaxParser;
  if not FUseTextStyle and (AParser <> nil) and AParser.GetBackColor(Style, result) then
  begin
    if result = -1 then
      result := Color;
  end
  else
  begin
    if ((Style >= 0) and (Style < TextStyles.Count)) then
      result := TextStyles[Style].Color
    else
      result := Color;
  end;
  result := CheckReadOnlyColor(result);
  DoGetFontFromStyle(Style, nil, result);
end;

{-------------------------------------------------------------}

function TCustomDCMemo.CheckReadOnlyColor(AColor : TColor) : TColor;
begin
  result := AColor;
  if (moUseReadOnlyColor in FOptions) and (result = Color) and ReadOnly then
    result := FReadOnlyColor;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.FontAndColorsFromStyle(Style : integer; var Font : TFont; var Color, BkColor : integer);
begin
  Font := GetFontFromTextStyle(Style);
  Color := Font.Color;
  BkColor := GetColorFromTextStyle(Style);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.IsUpperCaseStyle(Style : integer) : boolean;
begin
  result :=  (FUseTextStyle or (SyntaxParser = nil) or (SyntaxParser.GetFont(Style) = nil)) and
             ((Style >= 0) and (Style < TextStyles.Count) and TextStyles[Style].UpperCase);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo._FillRect(ARect : TRect; CurLine, CurWrapLine, CurChar, ABeginSel , AEndSel , AOldStyle : integer);
var
  R              : TRect;
  R1             : TRect;
  NeedPaintColor : boolean;
  FbkColor       : integer;
  FColor         : integer;
  ACanvas        : TCanvas;

  {----------------------------------------------------}

  procedure FillTextRect(R : TRect);
  begin
    with Canvas do
    begin
      Brush.Color := GetDrawCanvas.Brush.Color;
      FillRect(R);
    end;
  end;

  {----------------------------------------------------}

  procedure PaintRect(const ARect : TRect; ASelection : boolean);
  var
    ANeedPaint : boolean;
    AStates    : TDrawStates;
  begin
    if IsRectEmpty(ARect) then
      exit;

    if Assigned(FOnCustomDraw) then
    begin
      AStates := [dsBeforePaint, dsAfterText];
      if ASelection then
        AStates := AStates + [dsSelection];
      if CustomDraw(ACanvas, R, nil, 0, CurLine, CurChar, AStates) then
        exit;
    end;

    ANeedPaint := ACanvas.Brush.Color = CheckReadOnlyColor(Color);
    if FMemoBackground.NeedPaint and ANeedPaint then
      with ARect do
      begin
        if NeedHighLightLine(CurWrapLine) then
        begin
          if IsHighLightBrushClear then
            {$IFNDEF CLX}
            BitBlt(Canvas.Handle, Left, Top, Right - Left, Bottom - Top, TempBackGround.Canvas.Handle, Left, Top, SRCCOPY);
            {$ELSE}
            QBitBlt(Canvas, Left, Top, TempBackGround.Canvas, Left, Top, Right - Left, Bottom - Top);
            {$ENDIF}
          HighLightLine(Canvas, CurWrapLine, ARect);
        end
        else
          {$IFNDEF CLX}
          BitBlt(Canvas.Handle, Left, Top, Right - Left, Bottom - Top, TempBackGround.Canvas.Handle, Left, Top, SRCCOPY)
          {$ELSE}
          QBitBlt(Canvas, Left, Top, TempBackGround.Canvas, Left, Top, Right - Left, Bottom - Top)
          {$ENDIF}
      end
    else
    begin
      if ANeedPaint and NeedHighLightLine(CurWrapLine) then
      begin
        if IsHighLightBrushClear then
          FillTextRect(ARect);
        HighLightLine(ACanvas, CurWrapLine, ARect)
      end
      else
        FillTextRect(ARect);
    end;
    if Assigned(FOnCustomDraw) then
    begin
      AStates := [dsAfterPaint, dsAfterText];
      if ASelection then
        AStates := AStates + [dsSelection];
      CustomDraw(ACanvas, R, nil, 0, CurLine, CurChar, AStates);
    end;
  end;                

  {----------------------------------------------------}

begin


  with ARect do
    R := Rect(ABeginSel, Top, AEndSel, Bottom);

  ACanvas := GetDrawCanvas;

  InterSectRect(R, R, ARect);
  with ACanvas do
  begin
    FColor := Font.Color;
    FBkColor := Brush.Color;
  end;
  NeedPaintColor := (AOldStyle <> 0);

  if NeedPaintColor then
  begin
    FUseTextStyle := true;
    try
      SetDCColor(GetFontColorFromTextStyle(AOldStyle), GetColorFromTextStyle(AOldStyle));
    finally
      FUseTextStyle := false;
    end;
  end;

  if not IsRectEmpty(R) and (not (moSelectOnlyText in FOptions) or (GetSource.SelectionType = stBlockSel)) then
  begin
    with ARect do
    begin
      R1 := Rect(Left, Top, ABeginSel, Bottom);
      PaintRect(R1, false);
      R1 := Rect(AEndSel, Top, Right, Bottom);
      PaintRect(R1, false);
    end;

    if not NeedPaintColor or Focused or not FHideSelection then
    begin
      if NeedPaintColor and not (moDisableInvertedSel in FOptions) then
        SetDCColor(GetColorFromTextStyle(AOldStyle), GetFontColorFromTextStyle(AOldStyle))
      else
        SetDCColor(GetSelColor, GetSelBkColor);
    end;
    PaintRect(R, true);
  end
  else
    PaintRect(ARect, false);
  SetDCColor(FColor, FbkColor);

end;

{-------------------------------------------------------------}

function TCustomDCMemo.NeedHighLightLine(CurLine : integer) : boolean;
var
  ALine : integer;
begin
  result := Focused and FLineHighlight.Visible;
  if result then
  begin
    if FWordWrap then
      ALine := GetWBPosition(CaretPoint).Y
    else
      ALine := CaretPoint.Y;
    result := result and (CurLine = ALine);
  end;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.IsHighLightBrushClear : boolean;
begin
  result := FLineHighlight.Brush.Style = bsClear;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.HighLightLine(ACanvas : TCanvas; CurLine : integer; R : TRect);
var
  OldWidth : integer;
  OldStyle : TPenStyle;
  OldColor : TColor;

  {-----------------------------------------------------}

  procedure DoLine(FromPoint, ToPoint : TPoint);
  begin
    with ACanvas do
    begin
      MoveTo(FromPoint.X, FromPoint.Y);
      LineTo(ToPoint.X, ToPoint.Y);
    end;
  end;

  {-----------------------------------------------------}
begin
  {$IFDEF CLX}
  inc(R.Top);
  {$ENDIF}
  if NeedHighLightLine(CurLine) then
    with FLineHighlight, R do
    begin
      if not FMemoBackground.NeedPaint then
        R.Left := Max(R.Left, GetPaintX);
      {$IFNDEF CLX}
      FillRect(ACanvas.Handle, R, Brush.Handle);
      {$ELSE}
      QFillRect(ACanvas, R, Brush);
      {$ENDIF}
      with ACanvas.Pen do
      begin
        OldWidth := Width;
        OldStyle := Style;
        OldColor := Color;
      end;
      ACanvas.Pen := Pen;
      if FShape = shDoubleLine then
        DoLine(Point(Left, Top + Pen.Width - 1), Point(Right, Top + Pen.Width - 1));
      DoLine(Point(Left, Bottom - 1), Point(Right, Bottom - 1));
      if Pen.Width = 2 then
      begin
        if FShape = shDoubleLine then
          DoLine(Point(Left, Top), Point(Right, Top));
        DoLine(Point(Left, Bottom - 2), Point(Right, Bottom - 2));
      end;
      with ACanvas.Pen do
      begin
        Width := OldWidth;
        Style := OldStyle;
        Color := OldColor;
      end;

    end;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.CustomDraw(Canvas : TCanvas; const R : TRect; Ptr : PChar; Len : integer;
         LinePos, CharPos : integer; DrawState : TDrawStates) : boolean;
var
  s : string;
begin
  result := false;
  if Assigned(FOnCustomDraw) then
  begin
    if Ptr <> nil then
      SetString(s, Ptr, Len)
    else
      s := '';

    FOnCustomDraw(Self, Canvas, R, LinePos, CharPos, S, DrawState, result)
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.DoCustomString(var S, ColorS : string);
begin
  if Assigned(FOnCustomString) then
    FOnCustomString(Self, S, Colors);
end;


{-------------------------------------------------------------}

function  TCustomDCMemo.GetCurFontHandle : {$IFNDEF CLX} HFONT {$ELSE} QFontH {$ENDIF};
begin
  if FCurFont <> nil then
    result := FCurFont.Handle
  else
    {$IFNDEF CLX}
    result := 0;
    {$ELSE}
    result := nil;
   {$ENDIF}
end;

{-------------------------------------------------------------}

{$IFDEF CLX}

procedure TCustomDCMemo.QFillRect(ACanvas : TCanvas; const R : TRect; ABrush : TBrush);
begin
  with TMCanvas(ACanvas) do
  begin
    Start;
    try
      RequiredState([csHandleValid]);
      QPainter_fillRect(Handle, @R, ABrush.Handle);
    finally
      Stop;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.QTextOut(ACanvas : TCanvas; const R : TRect; Ptr : PChar; Len : integer; AFontInfo : PFontInfo; AFill : boolean; Buffer : Pointer);
var
  AFont  : QFontH;
  AWidth : integer;
  i      : integer;
  BLine  : integer;
  s      : string;
  R1     : TRect;
begin
  with TMCanvas(ACanvas) do
  begin
    Start;
    try
      if AFill then
      begin
        QPainter_setBackgroundMode(Handle, BGMode_OpaqueMode);
        QPainter_setBackgroundColor(Handle, QBrush_color(Brush.Handle));
        RequiredState([csHandleValid,  csFontValid, csBrushValid]);
      end
      else
        RequiredState([csHandleValid, csFontValid]);

      AFont := GetCurFontHandle;
      BLine := AFontInfo^.Ascent;
      if AFont <> nil then
        QPainter_setFont(Handle, AFont);
      if (Buffer = nil) then
      begin
        SetString(s, Ptr, Len);
        Qpainter_drawText(Handle, R.Left, R.Top + BLine, @s, Length(s));
      end
      else
      begin
        AWidth := 0;
        for i := 0 to Len - 1do
        begin
          s := Ptr[i];
          Qpainter_drawText(Handle, R.Left + AWidth , R.Top + BLine, @s, 1);
          inc(AWidth, PInteger(PChar(Buffer) + i * SizeOf(Integer))^);
        end;
      end;

      if AFill then
      begin
        with R, AFontInfo^ do
          R1 := Rect(Left, Top + Ascent + Descent, Right, Bottom);
        if not IsRectEmpty(R1) then
          QPainter_FillRect(Handle, @R1, Brush.Handle);
      end;
    finally
      Stop;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.QBitBlt(dst: TCanvas; dx, dy : integer; src: TCanvas; sx, sy, sw, sh : integer);
begin
  dst.Start;
  src.Start;
  try
    TMCanvas(dst).RequiredState([csHandleValid, csFontValid, csBrushValid]);
    TMCanvas(src).RequiredState([csHandleValid, csBrushValid]);
    bitBlt(QPainter_device(dst.Handle), dx, dy, QPainter_device(src.Handle), sx, sy, sw, sh, RasterOp_CopyROP, false);
  finally
    src.Stop;
    dst.Stop;
  end;
end;

{$ELSE}

{-------------------------------------------------------------}

procedure TCustomDCMemo.DoTextOut(ACanvas : TCanvas; R : TRect; Style : integer; Ptr : PChar; Len : integer; Buffer : Pointer; OverHang : integer);
begin
  if not (FHiColor or FMemoBackground.NeedPaint) then
  begin
    Style := 0;
    ACanvas.FillRect(R);
    SetBkMode(ACanvas.Handle, TRANSPARENT);
  end
  else
    if (OverHang > 0) and not UnderWindowsNT then
      with R do
        ACanvas.FillRect(Rect(Right, Top, Right + OverHang, Bottom));
  ExtTextOut(ACanvas.Handle, R.Left, R.Top, Style, @R, Ptr, Len, Buffer);
end;

{$ENDIF}

{-------------------------------------------------------------}

procedure TCustomDCMemo._TextOut(var R : TRect; BaseLine, CurLine, CurWrapLine, CurChar,
           X , Y : integer ; PStr : PChar; Len : integer; CalcRect, ASelection, AMarkedText : boolean);
var
  H           : integer;
  OldRect     : TRect;
  ABottom     : integer;
  overhang    : integer;
  s           : string;
  Ptr         : PChar;
  ACanvas     : TCanvas;
  {-------------------------------------------------}

  function AssignTempBitmap(Size : TPoint) : TCanvas;
  var
    TempCanvas : TCanvas;
  begin
    TempCanvas := GetDrawCanvas;
    with  FTempBitmap, Canvas do
    begin
      Width := Size.X;
      Height := Size.Y;
      Font.Assign(TempCanvas.Font);
      Pen.Assign(TempCanvas.Pen);
      {$IFDEF CLX}               ////
      Brush.Color := Self.Color;
      FillRect(Rect(0, 0, Width, Height));
      {$ENDIF}
      Brush.Assign(TempCanvas.Brush);
      {$IFNDEF CLX}
      SetBkMode(Handle, windows.TRANSPARENT);
      {$ENDIF}
      result := Canvas;
    end;
  end;

  {-------------------------------------------------}

  function OutText(var R : TRect; ACalc : boolean; Style : integer) : TFontInfo;
  var
    Buffer  : Pointer;
    AStates : TDrawStates;
  begin

    if ACalc then
    begin
      Buffer := nil;
      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
        Buffer := @FCharSp[0];
      {$ENDIF}
      R.Right := R.Left + GetWidthAndInfo(GetCurFontHandle, Ptr, len , @result, Buffer);
      with result do
        R.Bottom := R.Top + Ascent + Descent;
      //if not UnderWindowsNT then
       // dec(R.Right, result.OverHang);
    end
    else
    begin
      result := GetFontInfo(GetCurFontHandle)^;
      if FUseMonoFont and not FFontMonoSpaced then
        Buffer := @FCharSp[0]
      else
        Buffer := nil;
      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
        Buffer := @FCharSp[0];
      {$ENDIF}

      {$IFNDEF CLX}
      if (result.OverHang = 0) and ((FUseMonoFont and FFontMonoSpaced) or not FUseMonoFont) then
        Style := 0;
      {$ENDIF}
      if Assigned(FOnCustomDraw) then
      begin
        if ASelection then
          AStates := [dsText, dsSelection]
        else
          AStates := [dsText];
        if AMarkedText then
          include(AStates, dsMarkedText);
        if not CustomDraw(ACanvas, R, Ptr, Len, CurLine, CurChar, AStates + [dsBeforePaint]) then
        begin
          {$IFNDEF CLX}
          DoTextOut(ACanvas, R, Style, Ptr, Len, Buffer, result.OverHang);
          {$ELSE}
          QTextOut(ACanvas, R, Ptr, Len, @result, Style <> 0, Buffer);
          {$ENDIF}
          CustomDraw(ACanvas, R, Ptr, Len, CurLine, CurChar, AStates + [dsAfterPaint]);
        end;
      end
      else
      begin
        {$IFNDEF CLX}
        DoTextOut(ACanvas, R, Style, Ptr, Len, Buffer, result.OverHang);
        {$ELSE}
        QTextOut(ACanvas, R, Ptr, Len, @result, Style <> 0, Buffer);
        {$ENDIF}
     end;
    end;
  end;

  {-------------------------------------------------}

  procedure CheckBaseLine(var R : TRect; AFill : boolean);
  var
    asc    : integer;
  begin
    if (BaseLine = 0) or not NeedSyntaxPaint then
      exit;
    asc := GetFontInfo(GetCurFontHandle)^.Ascent;
    if AFill then
    begin
      R.Bottom := ABottom;
      OffsetRect(R, 0, BaseLine - asc);
      if (R.Top > OldRect.Top) or (R.Bottom < OldRect.Bottom) then
        with ACanvas do
        begin
          if R.Top > OldRect.Top then
            FillRect(Rect(R.Left, OldRect.Top, R.Right, R.Top));
          if R.Bottom < OldRect.Bottom then
            FillRect(Rect(R.Left, R.Bottom, R.Right, OldRect.Bottom));
        end;
    end
    else
      OffsetRect(R, 0, BaseLine - asc);
  end;

  {-------------------------------------------------}

  procedure _TempDraw;
  begin
    {$IFNDEF CLX}
    BitBlt(ACanvas.Handle, 0, 0, R.Right , R.Bottom, TempBackground.Canvas.Handle, X, Y, SRCCOPY);
    {$ELSE}
    QBitBlt(ACanvas, 0, 0, TempBackground.Canvas, X, Y, R.Right, R.Bottom);
    {$ENDIF}
  end;

  {-------------------------------------------------}

begin
  if IsUpperCaseStyle(FCurStyle) then
  begin
    SetString(s, Pstr, Len);
    s := UpperCase(s);
    Ptr := PChar(s);
  end
  else
    Ptr := PStr;
  if CalcRect then
  begin
    BaseLine := OutText(R, true, 0).Ascent;
    exit;
  end;
  H := 0;
  OldRect := R;
  ABottom := R.Bottom;
  if FMemoBackground.NeedPaint then
  begin
    if not FUseMonoFont then
    begin
      H := R.Bottom - R.Top;
      R.Left := 0;
      R.Top := 0;
      overhang := OutText(R, true, 0).OverHang;
      inc(R.Right, overhang);
      ABottom := R.Bottom;
      R.Bottom := R.Top + H;
    end
    else
    begin
      overhang := 0;
      OffsetRect(R,  - R.Left, - R.Top);
    end;

    ACanvas := AssignTempBitmap(R.BottomRight);
    try
      with ACanvas do
        if Brush.Color <> CheckReadOnlyColor(Color) then
          FillRect(R)
        else
        begin
          if NeedHighLightLine(CurWrapLine) then
          begin
            if IsHighLightBrushClear then
              _TempDraw;
            HighLightLine(ACanvas, CurWrapLine, R);
          end
          else
            _TempDraw;
        end;

      if not FUseMonoFont then
        CheckBaseLine(R, false);

      OutText(R, false, 0);
      {$IFNDEF CLX}
      BitBlt(Canvas.Handle, X, Y, R.Right , R.Bottom, ACanvas.Handle, 0, 0, SRCCOPY);
      {$ELSE}
      QBitBlt(Canvas, X, Y, ACanvas, 0, 0, R.Right, R.Bottom);
      {$ENDIF}
      R := Rect(X, Y, X + R.Right - R.Left, Y + H);
      dec(R.Right, overhang);
    finally
    end;
  end
  else
  begin
    ACanvas := GetDrawCanvas;
    H := R.Bottom - R.Top;
    if not FUseMonoFont then
    begin
      R.Left := X;
      R.Top := Y;
      overhang := OutText(R, true, 0).OverHang;
      inc(R.Right, overhang);
      ABottom := R.Bottom;
      R.Bottom := R.Top + H;
      CheckBaseLine(R, true);
    end
    else
      overhang := 0;

    if (ACanvas.Brush.Color = CheckReadOnlyColor(Color)) and NeedHighlightLine(CurWrapLine) then
    begin
      if IsHighlightBrushClear then
      begin
        OutText(R, false, ETO_OPAQUE);
        HighLightLine(ACanvas, CurWrapLine, Rect(X, Y, R.Right, Y + H));
      end
      else
      begin
        HighLightLine(ACanvas, CurWrapLine, Rect(X, Y, R.Right, Y + H));
        {$IFNDEF CLX}
        SetBkMode(ACanvas.Handle, TRANSPARENT);
        {$ENDIF}
        OutText(R, false, 0);
        {$IFNDEF CLX}
        SetBkMode(ACanvas.Handle, OPAQUE);
        {$ENDIF}
      end;
    end
    else
      if FUseMonoFont or (R.Right >= GetPaintX)  then
        OutText(R, false, ETO_OPAQUE);
    dec(R.Right, overhang);
  end;
end;


{-------------------------------------------------------------}

function EqualFonts(a, b : TFont; ASkipColor : boolean) : boolean;
begin
  with a do
    result := (ASkipColor or (Color = b.Color)) and (Handle  = b.Handle);
end;

{-------------------------------------------------------------}

function TCustomDCMemo.EqualStyles(a, b : integer; ASkipColor : boolean) : boolean;
begin
  {$IFDEF CLX}
  result := false;
  exit;
  {$ENDIF}
  if (a >= 0) and (b >= 0) then
    result := (ASkipColor or (GetColorFromTextStyle(a) = GetColorFromTextStyle(b))) and
    (IsUpperCaseStyle(a) = IsUpperCaseStyle(b)) and
    EqualFonts(GetFontFromTextStyle(a), GetFontFromTextStyle(b), ASkipColor)
  else
    result := true;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.SetColorFromStyle(AColorStyle, AOldStyle, AOldColor, AOldBkColor : integer ; InSelection, ASkipColor, ACalcRect : boolean) : TFont;
var
  _color : integer;
  _bkcol : integer;
  _font  : TFont;
begin
  if (AColorStyle = 0) and ((SyntaxParser = nil) or not (moColorSyntax in Options)) and (HighlightUrls) then
  begin
    _color := Font.Color;
    _bkCol := Color;
    _font := Font;
  end
  else
    FontAndColorsFromStyle(AColorStyle, _font, _color, _bkCol);


  if InSelection then
    GetSelColorsFromStyle(AOldStyle, _color, _bkcol);
  {$IFNDEF CLX}
  if not ACalcRect then
    GetDrawCanvas.Font.Assign(_font);
  {$ENDIF}  

  if (AOldBkColor <> 0) and (ASkipColor or (AOldBkColor <> {ColorToRgb(}Color) ) then ////
  begin
    if not InSelection then
      with GetDrawCanvas do
      begin
        if moColoredLineStyle in FOptions then
          SetDCColor(_color, AOldBkColor)
        else
          SetDCColor(AOldColor, AOldBkColor)
    end
    else
      SetDCColor(_color, _bkcol);
  end
  else
    if InSelection or not ASkipColor  then
      SetDCColor(_color, _bkcol);
  result := _font;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.GetSelColorsFromStyle(Style : integer; var AColor, ABkColor : integer);
begin
  if (Style > 0) and not (moDisableInvertedSel in FOptions) then
  begin
    AColor := GetColorFromTextStyle(Style);
    ABkColor := GetFontColorFromTextStyle(Style);
  end
  else
  begin
    AColor := GetSelColor;
    ABkColor := GetSelBkColor;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.InSelection(x, y : integer) : boolean;
var
  ALeft  : integer;
  ARight : integer;
begin
  if FHideSelection and not Focused then
    result := false
  else
  begin
    TMSource(GetSource).SelectionBounds(Y, ALeft, ARight, true);
    result := (X >= ALeft) and (X < ARight);
  end;  
end;

{-------------------------------------------------------------}

function TCustomDCMemo.InFoundRect(x, y : integer) : boolean; 
var
  R : TRect;
begin
  with GetSource do
    if not IsRectEmpty(FoundRect) then
      R := FoundRect
    else
      R := Rect(0, 0, 0, 0);

  with R  do
  begin
    result := not IsRectEmpty(R) and (y >= Top) and (y < Bottom);
    if not result then
      exit;
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      x := _ByteToChar(Lines[Y], x + 1) - 1;
    {$ENDIF}
    result := (x >= Left) and (x < Right);
  end;  
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.DoGetColorStyle(Point : TPoint; var AStyle : integer);
begin
  if Assigned(OnGetColorStyle) then
    OnGetColorStyle(Self, Point, AStyle);
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.PaintString(var R : TRect; var BaseLine : integer; const S, ColorS : string;
          begChar, endChar, CurLine, CurWrapLine, CurPos, CurStyle : integer; SkipColors, CalcRect, CalcSymbols : boolean) : integer;
var
  SLen          : integer;
  curchar       : integer;
  scolor        : integer;
  ncolor        : integer;
  ccount        : integer;
  ARight        : integer;
  W             : integer;
  ADescent      : integer;
  selchanged    : boolean;
  _insel        : boolean;
  oldColor      : integer;
  OldBkColor    : integer;
  PaintX        : integer;
  _MarkedText   : boolean;
  MarkedChanged : boolean;
  TextRect      : TRect;

  {-----------------------------------------------}

  function _GetColor(cchar : integer) : integer;
  begin
    if cchar <= length(ColorS) then
    begin
      result := {ValidateColorStyle}(byte(Colors[cchar]));
      if not (moColorSyntax in Options) and HighLightUrls and (result <> tokUrl) then
        result := 0;
      DoGetColorStyle(Point(cchar, CurLine), result);
    end
    else
      result := -1;

  end;

  {-----------------------------------------------}

begin
  result := 0;
  FCurFont := nil;
  FCurStyle := 0;
  TextRect := R;
  ARight := R.Right;

  curchar := begChar;
  PaintX := GetPaintX;

  {$IFDEF DCMBCS}
  if (SysLocale.FarEast) and FUseMonoFont and (begChar > 0) and (_IsLeadByte(S, begChar)) then
  begin
    dec(CurChar);
    dec(TextRect.Left, CharWidth);
  end;
  {$ENDIF}

  if CalcRect then
    BaseLine := 0;
  ADescent := 0;
  with TextRect do
    Right := Left;

  SLen := Min(Length(S), endChar);

  if curchar >= SLen then
  begin
    R.Right := 0;
    exit;
  end;

  if curchar < SLen then
  begin
    with GetDrawCanvas do
    begin
      oldColor := Font.Color;
      OldBkColor := Brush.Color;
    end;  
    while curchar < SLen do
    begin
      ccount := 0;
      scolor := _GetColor(curChar + 1);
      _insel := not CalcRect and InSelection(curchar + CurPos - 1, CurLine);
      selchanged := false;
      _MarkedText := InFoundRect(curchar + CurPos - 1, CurLine);
      MarkedChanged := false;
      repeat

        while (ccount < Slen - curchar) and (_GetColor(curchar + ccount + 1) = scolor) do
          begin
            inc(ccount);
            if not CalcRect and InSelection(curchar + ccount + CurPos - 1, CurLine) <> _insel then
            begin
              selchanged := true;
              break;
            end;
            if not CalcRect and InFoundRect(curchar + ccount + CurPos - 1, CurLine) <> _MarkedText then
            begin
              MarkedChanged := true;
              break;
            end;
            if ccount >= MaxPaint then
              break;
          end;

        ncolor := _GetColor(curchar + ccount + 1);

        if selchanged or MarkedChanged or (ccount = Slen - curchar) then
          break;

        if EqualStyles(scolor, ncolor, SkipColors or (_inSel and not selchanged) or _MarkedText) then
          scolor := ncolor
        else
          break;
        if ccount >= MaxPaint then
          break;
      until false;


      if SkipColors then
        FCurFont := SetColorFromStyle(scolor, CurStyle, OldColor, OldBkColor, _insel, SkipColors, CalcRect)
      else
        FCurFont := SetColorFromStyle(scolor, CurStyle, 0, 0, _insel, SkipColors, CalcRect);

      FCurStyle := scolor;

      if _MarkedText then
        SetDCColor(FMatchColor, FMatchBackColor);
      with TextRect do
      begin
        if FUseMonoFont then
        begin
          TextRect := Bounds(Left, Top, ccount  * CharWidth, LineHeight);
          UpdateCharSp(ccount);
        end
        else
        begin
          {$IFDEF DCMBCS}
          if SysLocale.FarEast then
            UpdateCharSp(ccount);
          {$ENDIF}
          TextRect := Rect(Right, R.Top, Right, R.Bottom);
        end;
        _TextOut(TextRect, BaseLine, CurLine, CurWrapLine, CurPos + curchar, Left, Top, @(s[curchar + 1]), ccount, CalcRect, _inSel, _MarkedText);

        if CalcSymbols and (TextRect.Right > ARight) then
        begin
          if R.Bottom - R.Top = 0 then
            R.Bottom := max(R.Bottom, Bottom);
          R.Right := TextRect.Left;
          break;
        end;

        if not FUseMonoFont then
        begin
          R.Bottom := max(R.Bottom, Bottom);
          R.Right := Right;
          with GetFontInfo(GetCurFontHandle)^ do
          begin
            BaseLine := max(BaseLine, Ascent);
            ADescent := Max(ADescent, Descent);
          end;
          if FPrintPageSize.X <> 0 then
            W := FPrintPageSize.X
          else
            W := ClientWidth;
          if not (CalcRect or CalcSymbols) and (TextRect.Right >= W) then
            break;
        end
        else
          Left := Right;
      end;
      inc(curchar, ccount);
      inc(result, ccount);
    end;
    SetColorFromStyle(-1, 0, 0, 0, false, SkipColors, CalcRect);
    SetDCColor(OldColor, OldBkColor);
  end;

  if FUseMonoFont then
    R.Right := TextRect.Right
  else
  if CalcRect and not FUseMonoFont then
    R.Bottom := max(R.Bottom, ADescent + BaseLine);

  if not CalcRect and (result <> 0) and (FCurFont <> nil) then
    with GetFontInfo(GetCurFontHandle)^ do
      inc(R.Right, OverHang - OverHang div 4);    //

end;

{-------------------------------------------------------------}


procedure TCustomDCMemo.RealPaint;
var
  SelRect         : TRect;
  StringsRect     : TRect;
//  x               : integer;
  AColorSyntax    : Boolean;
  ASkipLineColors : boolean;
  OMarPos         : integer;
  OPaintMar       : boolean;
  lTextStyle      : integer;
  PaintX          : integer;
  ACanvas         : TCanvas;
  {-----------------------------------------------------}

  procedure DrawInRect(const R : TRect; FontColor, BackColor : TColor);
  var
    A           : TRect;
    begchar     : integer;
    endchar     : integer;
    y           : integer;
    cline       : integer;
    CurPos      : integer;
    Pos         : integer;
    Curline     : integer;
    {---------------------------------------------}

    procedure PaintMar(Y, H : integer);
    begin
      if OPaintMar then
        with Canvas do
        begin
          Pen.Assign(FMarginPen);
          MoveTo(OMarPos, Y);
          LineTo(OMarPos, Y + H + 1);
        end;
    end;

    {---------------------------------------------}

    procedure PaintHorLine(Y : integer);
    begin
      if moDrawLineSeparator in FLineSeparator.FOptions then
        with ACanvas do
        begin
          ACanvas.Pen.Assign(FLineSeparator.FPen);
          MoveTo(PaintX, Y );
          LineTo(A.Right, Y);
        end;
    end;

    {---------------------------------------------}

    function SelectionBound(line : integer) : TPoint;
    var
      ALeft   : integer;
      ARight  : integer;
      Pt      : TPoint;
      AMaxInt : boolean;
      {---------------------------------------------}

      function _GetX (X : integer) : integer;
      begin
        if X = 0 then
          result := PaintX
        else
          result := TextToPixelChar(Point(X, line));
      end;

      {---------------------------------------------}

    begin
      result := Point(0, 0);
      GetSource.SelectionBounds(line , ALeft, ARight, false);
      if (ALeft = ARight) then
        exit;
      Pt := GetWBPosition(Point(ALeft, line));
      if Pt.y > Curline then
        exit
      else
      if Pt.y < Curline then
        ALeft := 0;

      AMaxInt := (ARight = MaxInt);

      Pt := GetWBPosition(Point(ARight, line));
      if Pt.y < Curline then
        exit
      else
      if Pt.y > Curline then
        AMaxInt := true;

      if AMaxInt then
        result := Point(_GetX(ALeft),  ClientWidth)
      else
        result := Point(_GetX(ALeft), _GetX(ARight));

    end;

  {---------------------------------------------}

  var

    i           : integer;
    APoint      : TPoint;
    Cs          : string;
    AString     : string;
    OldColor    : integer;
    H           : integer;
    BLine       : integer;
    len         : integer;
    ALen        : integer;
    OldY        : integer;
    AH          : integer;
    LHeight     : integer;
    AIndent     : integer;
    APos        : integer;
    ASkipLines  : boolean;

    {---------------------------------------------}

    procedure PaintLineBookmarks(List : TList; AHeight : integer);
    var
      OldBrushColor : TColor;
      i             : integer;
      Triangle      : array [0..2] of TPoint;
      space         : integer;
    begin
      if List.Count = 0 then
        exit;
      space := AHeight div  4;
      with ACanvas do
      begin
        OldBrushColor := Brush.Color;
        Brush.Color := FLineBookmarkColor;
        Pen.Color := FLineBookmarkColor;
        Pen.Width := 1;
        Pen.Style := psSolid;
        with List do
          for i := 0 to Count - 1 do
            with PBookMarkRec(Items[i])^ do
              with TextToPixelPoint(Point(X, Y)) do
              begin
                Triangle[0] := Point(X - space, Y + AHeight - 1);
                Triangle[1] := Point(X + space, Y + AHeight - 1);
                Triangle[2] := Point(X , Y + AHeight - space - 1);
                Polygon(Triangle);
              end;
        Brush.Color := OldBrushColor;
      end;
    end;

    {---------------------------------------------}

    procedure PaintLine(const ALine, AClData : string; H, BLine, MaxPos : integer);
    var
      Pt    : TPoint;
      R     : TRect;
    begin
      if (FPrintPageSize.Y = 0) or (Y + H <= FPrintPageSize.Y) then
      begin
        if not FUseMonoFont and (A.Left + GetRealLineWidth(i) < PaintX) then
        begin
          R.Left := 0;
          R.Right := 0;
        end
        else
        begin
          if FUsemonoFont then
            R := Rect(A.Left, Y, ClientWidth, Y + LineHeight)
          else
            R := Rect(A.Left, Y, A.Left, Y + H);
          PaintString(R, BLine, ALine, AClData, begChar, endChar, cline, CurLine, CurPos, lTextStyle, ASkipLineColors or not Enabled, false, false);
        end;

        with R do
        begin
          Left := Max(Left, PaintX);
          Right := Max(Right, Left);
        end;

        if (R.Right <= A.Right) then
        begin
          Pt := SelectionBound(cline);
          _FillRect(Rect(R.Right, Y, A.Right + 1, Y + H), cLine, CurLine, CurPos, Pt.X, Pt.Y, lTextStyle);
        end;
        if (moWrappedLineSeparator in FLineSeparator.FOptions) then
          PaintHorLine(Y + H - 1);
        PaintMar(Y, H);
      end;
      if moDrawLineBookmarks in Options then
      begin
        TMSource(GetSource).GetBookmarksFromRange(cline, CurPos - 1, MaxPos, FBookmarkList);
        PaintLineBookmarks(FBookmarkList, H);
      end;
      inc(Y , H);
      inc(Curline);
    end;

    {---------------------------------------------}

    function _GetChar(index : integer; IsEmpty : boolean) : char;
    var
      OldAttr : integer;
    begin
      if IsEmpty or not (SyntaxParser is TAttributeParser) then
        result := #0
      else
        with TMSource(GetSource) do
        begin
          OldAttr := DefaultAttribute;
          DefaultAttribute := -1;
          result := char(GetAttr(Point(MaxInt, Index)));
          DefaultAttribute := OldAttr;
        end;
    end;

    {---------------------------------------------}

    function ApplySpecialSymbols : integer;
    var
      IsEmpty : boolean;
    begin
      result := 0;
      if moDrawSpecialSymbols in FOptions then
      with FSpecialSymbols do
      begin
        if i < Lines.Count then
        begin
          IsEmpty := AString = '';
          AString := AString + FEOLString;
          result := Length(FEOLString);
          if AColorSyntax then
            Cs := Cs + StringOfChar(_GetChar(i, IsEmpty), Length(FEOLString));
        end
        else
          if i = Lines.Count then
          begin
            AString := AString + FEOFString;
            if AColorSyntax then
              Cs := Cs + StringOfChar(#0, Length(FEOFString));
          end;
      end;
    end;

    {---------------------------------------------}

    procedure CheckEnabled;
    begin
      if not Enabled then
        SetDCColor(FDisabledColor, BackColor);
    end;
    
    {---------------------------------------------}
    
  begin

    if FUseMonoFont then
    begin
      IntersectRect(A, R, StringsRect);
      Curline := A.Top div LineHeight + WinLine;
      CheckVisibleIndex(CurLine, false);
    end
    else
    begin
      A := R;
      A.Left := - CharWidth * WinChar;
      CurLine := PixelToTextLine(A.Top, Pos, false);
      CurLine := GetWBPositionEx(Point(Pos - 1, CurLine), false, false, Pos).Y;
    end;
    if IsRectEmpty(A) then
      exit;
    with A do
    begin
      Canvas.Brush.Color := BackColor;
      if FUseMonoFont then
      begin
        begchar := Left div CharWidth + WinChar;
        endchar := Right div CharWidth + WinChar;
      end
      else
      begin
        begchar := 0;
        endchar := MaxInt;
      end;

      APoint := GetRealPositionEx(Point(0, Curline), true);
      i := APoint.Y;

      Pos := APoint.X + 1;

      CurPos := 1;
      y := Top;

      OffSetRect(A, PaintX, 0);

      SelRect := GetSource.SelectionRect;
      if (SyntaxParser <> nil) and (SyntaxParser.GetFont(0) <> nil) then
        AColorSyntax := NeedSyntaxPaint
      else
        AColorSyntax := (TextStyles.Count > 0) and  NeedSyntaxPaint;

      CheckEnabled;
      
      ASkipLineColors := false;
      ASkipLines := HideLines;
      OldY := y;
      with TMSource(GetSource) do
        while y < Bottom do
        begin
          if ASkipLines and not GetRealLineVisible(i) then
          begin
            Pos := 1;
            inc(i);
            inc(Curline);
            continue;
          end;
          cline := i;
          if ASkipLineColors then
            CheckEnabled;

          ASkipLineColors := false;
//          OldColor := 0;
          OldColor := ACanvas.Brush.Color;
          if (TextStyles.Count > 0) then
          begin
            lTextStyle := LineTextStyle[i];
            if lTextStyle <> 0 then
            begin
              //OldColor := GetBkColor(DC);
              FUseTextStyle := true;
              try
                SetColorFromStyle(lTextStyle, 0, 0, 0,  false, false, false);
              finally
                FUseTextStyle := false;
              end;
              ASkipLineColors := true;
            end
          end
          else
            lTextStyle := 0;

          if not AColorSyntax then
            Cs := ''
          else
            Cs := GetStoredColorData(i);

          if moDrawSpecialSymbols in FOptions then
            with FSpecialSymbols do
              AString := GetSpecialString(i, FUseMonoFont, FSpaceChar, FTabChar)
          else
            AString := Strings[i];


          len := length(AString);

          ALen := ApplySpecialSymbols;

          DoCustomString(AString, Cs);

          if FWordWrap and (len <> 0) then
          begin
            while Pos <= len do
            begin
              CurPos := Pos;
              H := GetWrappedLineHeightEx(i, Pos, BLine, true, true);
              if Pos > Len then
              begin
                APos := MaxInt;
                inc(Pos, ALen);
              end
              else
                APos := Pos;
              PaintLine(Copy(AString, CurPos, Pos - CurPos), Copy(Cs, CurPos, Pos - CurPos), H, BLine, APos);
            end
          end
          else
            PaintLine(AString, Cs, GetRealLineHeight(i) , GetBaseLine(i), MaxInt);

          LHeight := LineHeight;
          if HideLines and (LHeight <> 0) then
          begin
            AH := Max(0, (Y - OldY - LHeight) div 2);
            Brush.Color := Self.Color;
            ACanvas.FillRect(Rect(PaintX - LHeight, OldY, PaintX, Y));
            if CollapseState[i] <> csNone then
            begin
              if LHeight > 16 then
                AIndent := Max((LHeight - 16) div 2, LHeight div 8)
              else
                AIndent := LHeight div 8;
              PaintExpandCollapse(Canvas, PaintX - LHeight, OldY + AH, LHeight, AIndent, CollapseState[i] = csExpanded);
            end;
          end;

          if not (moWrappedLineSeparator in FLineSeparator.FOptions) then
            PaintHorLine(Y  - 1);
          //if OldColor <> 0 then
          ACanvas.Brush.Color := OldColor;
          inc(i);
          Pos := 1;
          OldY := y;
        end;

    end;
  end;

 {---------------------------------------------}

  procedure DrawStdRect(const R : TRect);
  var
    RgnStart   : integer;
    {$IFDEF CLX}
    ARect      : TRect;
    {$ELSE}
    rgn        : HRGN;
    {$ENDIF}
    ClipCanvas : TCanvas;
  begin

    RgnStart := PaintX;
    if HideLines then
      dec(RgnStart, LineHeight);
    if FMemoBackground.NeedPaint then
      ClipCanvas := Canvas
    else
      ClipCanvas := ACanvas;
    {$IFNDEF CLX}
    with R do
      rgn := CreateRectRgn(Left + RgnStart, Top, Right + PaintX, Bottom);
    SelectClipRgn(ClipCanvas.Handle, rgn);
    {$ELSE}
    with R do
      ARect := Rect(Left + RgnStart, Top, Right + PaintX, Bottom);
    QPainter_setClipRect(ClipCanvas.Handle, @ARect);
    QPainter_setClipping(ClipCanvas.Handle, true);
    {$ENDIF}
    DrawInRect(R, Font.Color, CheckReadOnlyColor(Color));
    {$IFNDEF CLX}
    DeleteObject(rgn);
    SelectClipRgn(ClipCanvas.Handle, 0);
    {$ELSE}
    QPainter_setClipping(ClipCanvas.Handle, false);
    {$ENDIF}
  end;

 {---------------------------------------------}
var
  ADrawRect : TRect;
begin

  PaintX := GetPaintX;
  ACanvas := GetDrawCanvas;
  {$IFNDEF CLX}
  FHiColor := GetDeviceCaps(ACanvas.handle, BITSPIXEL) > 8;
  {$ELSE}
  FHiColor := true;
  {$ENDIf}

  if FSpecialPaint Then
   StringsRect := FDrawRect
  else
  begin
    if HideLines then
    begin
      IntersectRect(ADrawRect, Rect(PaintX - LineHeight, 0, PaintX, ClientHeight), FDrawRect);
      if not IsRectEmpty(ADrawRect) then
        FDrawRect.Right := Max(FDrawRect.Right, PaintX + 1);
    end;
    IntersectRect(StringsRect, Rect(PaintX, 0, ClientWidth, ClientHeight), FDrawRect);
    OffSetRect(StringsRect, - PaintX, 0);
  end;

  OMarPos := (FMarginPos - WinChar) * CharWidth + PaintX;
  OPaintMar := (OMarPos >= Max(FDrawRect.Left, PaintX)) and (OMarPos <= FDrawRect.Right) and
    (moDrawMargin in FOptions);
  if FUseMonoFont then
    with StringsRect do
    begin
      Left := (Left div CharWidth) * CharWidth;
        if Right mod CharWidth <> 0 then
          Right:=((Right div CharWidth) + 1) * CharWidth;
    end;

  SetDCColor(Font.Color, CheckReadOnlyColor(Color));
  DrawStdRect(StringsRect);
end;

{--------------------------------------------}

procedure TCustomDCMemo.OnGutterImgsChange(Sender : TObject);
var
  i:integer;
begin
  FGutterImagesChanged := true;
  FillChar(FBookmarkImgIndex, 10, 0);

  with FGutterImgs do
    for i := 0 to Count - 1 do
      with TGutterImage(Items[i]) do
        if BookmarkIndex in [0..9] then
           FBookmarkImgIndex[BookmarkIndex] := i + 1;

  Invalidate;
end;

{--------------------------------------------}

procedure TCustomDCMemo.OnInvalidate(Sender : TObject);
begin
  Invalidate;
end;

{--------------------------------------------}

procedure TCustomDCMemo.OnChangeMargin(Sender : TObject);
begin
  FMarginPen.Width := Min(FMarginPen.Width, CMaxMarginWidth);
  Invalidate;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.CreateDefaultMemoSource : TCustomMemoSource;
begin
  result := TMemoSource.Create(nil);
  with TMSource(result) do
  begin
    OnNavigate := Self.GetNavigation;
    if not FUseMonoFont then
      OnGetLineHeight := Self.GetLineHeight;
  end;  
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.DoColorChanged;
begin
  FTextStyles.UpdateParams;
  Invalidate;
  AssignAttributeFont;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.DoSetCursor : boolean;
var
  P  : TPoint;
  Pt : TPoint;

  {--------------------------------------------}

  function InValidPos(X, Y : integer) : boolean;
  begin
    with GetSource.Strings  do
      result := ((soLimitEol in StringsOptions) and (X > length(Strings[Y]))) or
                     ((not (soBeyondFileEnd in StringsOptions)) and (Y > Count));

  end;

  {--------------------------------------------}

begin
  GetCursorPos(P);
  P  := ScreenToClient(P);
  Pt := ConvertMousePosEx(P.X, P.Y, false);
  result := (P.X < GetPaintX) or ((PosInBlock(Pt.X, Pt.Y) and not InValidPos(Pt.X, Pt.Y)) );
  if result then
    {$IFNDEF CLX}
    SetCursor(Screen.Cursors[crDefault]);
    {$ELSE}
    QWidget_setCursor(Handle, Screen.Cursors[crDefault]);
    {$ENDIF}
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.DoBoundsChanged;
begin
  UpdateScrollPos;
  UpdateScrollSize;
  FMemoBackground.PaintBackground;
  FGutterBackGround.PaintBackground;
end;

{$IFDEF CLX}

{-------------------------------------------------------------}

procedure TCustomDCMemo.EnabledChanged;
begin
  inherited;
  GetSource.SelectionType:=stNotSelected;
  Invalidate;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ChangeScrollSize;
var
  R     : TRect;
  CRect : TRect;
begin
  if not HandleAllocated or ((FVertScrollBar = nil) and (FHorzScrollBar = nil)) then
    exit;

  CRect := ClientRect;

  if FVertScrollBar <> nil then
  begin
    with CRect do
      R := Rect(Right, Top, Right + sScrollBarSize,Bottom);
    QWidget_SetGeometry(FVertScrollBar, @R);
  end;
  if FHorzScrollBar <> nil then
  begin
    with CRect do
      R := Rect(Left, Bottom, Right, Bottom + sScrollBarSize);
    QWidget_SetGeometry(FHorzScrollBar, @R);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.BoundsChanged;
begin
  inherited;
  if FCreated then
  begin
    DoBoundsChanged;
    ChangeScrollSize;
    if Showing then
    begin
      if FVertScrollBar <> nil then
        QWidget_Repaint(FVertScrollBar);
      if FHorzScrollBar <> nil then
        QWidget_Repaint(FHorzScrollBar);
    end;
  end;
end;
{-------------------------------------------------------------}

procedure TCustomDCMemo.OnHintTimer(Sender : TObject);
begin
  KillHintTimer;
  PopupHintBox;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.OnDragTimer(Sender : TObject);
begin
  DoSelTimer;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.PaintScrollRect;
var
  OldColor  : TColor;
begin
  if (FHorzScrollBar <> nil) and (FVertScrollBar <> nil) and (Parent <> nil) then
    with BoundsRect do
    begin
      OldColor := Canvas.Brush.Color;
      Canvas.Brush.Color := TMWinControl(Parent).Color;
      Canvas.FillRect(Rect(Right - sScrollBarSize, Bottom - sScrollBarSize, Right, Bottom));
      Canvas.Brush.Color := OldColor;
   end;
end;

{$ELSE}

{-------------------------------------------------------------}

procedure TCustomDCMemo.CMENABLEDCHANGED(var Message: TMessage);
begin
  inherited;
  GetSource.SelectionType:=stNotSelected;
  if not Enabled and (HandleAllocated)then
    Windows.HideCaret(Handle);
  Invalidate;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.CMColorChanged(var Message : TMessage);
begin
  inherited;
  DoColorChanged;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.WMVScroll(var Msg : TWMVScroll);
begin
  ModifyScrollBar(SB_VERT, Msg.ScrollCode, GetScrollPosEx(Handle, SB_VERT));
  VerticalScroll(Msg.ScrollCode);
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMHScroll(var Msg : TWMHScroll);
begin
  ModifyScrollBar(SB_HORZ, Msg.ScrollCode, GetScrollPosEx(Handle, SB_HORZ));
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMMouseWheel(var Message : TMessage);
begin
  MouseWheel(SmallInt(HIWORD(Message.wParam)));
  Message.result := 1;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMSize(var Msg : TWMSize);
begin
  inherited;
  DoBoundsChanged;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMTimer(var Msg : TWMTimer);
begin
  if Msg.TimerID = cDragDropTimer then
    DoSelTimer
  else
  if Msg.TimerID = cHintTimer then
  begin
    KillHintTimer;
    PopupHintBox;
  end;
end;

{$ENDIF}

{-------------------------------------------------------------}

procedure TDCGutterImages.AddFromResource(const ResName, GutterImageName : string;
            ABookMarkIndex : integer);
begin
  with TGutterImage(Add) do
  begin
    Glyph.LoadFromResourceName(HInstance, ResName);
    {$IFDEF CLX}
    Glyph.Mask(clDefault);
    {$ENDIF}
    Name := GutterImageName;
    BookMarkIndex := ABookMarkIndex;
  end;
end;

{-------------------------------------------------------------}

constructor TCustomDCMemo.Create(AOwner:TComponent);
const
  EditStyle = [csClickEvents, csCaptureMouse, csOpaque, csDoubleClicks];
var
  i : integer;
begin
  FIntSource := CreateDefaultMemoSource;
  inherited;
  FUseMonoFont := true;
  FDisabledColor := clGrayText;
  FReadOnlyColor := clWindow;
  FFont := TMemoFont.Create(Self);
  AssignDefaultMemoFont(Font, FontOnChange);
  FPrinterFont := TMemoFont.Create(Self);
  FTemplateFont := TFont.Create;
  FTemplateFont.Name := 'MS Sans Serif';  //don't resource
  FTemplateFont.Size := 8;
  FLineBookmarkColor := clRed;

  AssignDefaultMemoFont(FPrinterFont, nil);

  MemoList.Add(Self);
  RegisterMemoEnvOptObject(Self);
  FHorzMaxPos:=512;

  FSelColor := clHighlightText;
  FSelBackColor := clHighlight;
  FMatchColor := clLime;
  FMatchBackColor := clWindowText;
  FTextStyles := TTextStyles.Create(Self, TTextStyle);
  FTextStyles.SetDefaultStyles;
  FTextStyles.Onchange := TextStylesChanged;

  FGutterImgs:=TDCGutterImages.Create(Self, TGutterImage);

  FGutterImgs.AddFromResource('MEMO_BREAKPOINT', 'BreakPoint', -1);//don't resource
  FCompletion := TStringList.Create;
  FHintPopup := TStringList.Create;

  for i := 0 to 9 do
    FGutterImgs.AddFromResource('BIGBOOKMARK' + IntToStr(i), 'Bookmark' + IntToStr(i), i);//don't resource

  FGutterImgs.OnChange := OnGutterImgsChange;

  OnGutterImgsChange(nil);
  FGutterImagesChanged := false;

  FOptions:=[moThumbTracking, moColorSyntax];
  FGutterLineColor := clGray;
  FMarginPos := CDefaultMarginPos;
  FGutterWidth := CDefaultGutterWidth;
  Width := 185;
  Height := 89;
  FScrollBars := ssNone;
  FBorderStyle := bsSingle;
  ParentFont := false;
  Color := clWindow;
  FGutterBackColor := Color;
  if NewStyleControls then
    ControlStyle := EditStyle else
    ControlStyle := EditStyle + [csFramed];
  TabStop := true;
  ParentColor := false;
  Cursor := crIBeam;
  FMarginPen := TPen.Create;
  FLineSeparator := TLineSeparator.Create(Self);
  FLineHighlight := TLineHighlight.Create(Self);
  FSpecialSymbols := TSpecialSymbols.Create(Self);
  FGutterBrush := TBrush.Create;
  AssignDefaultGutterBrush(FGutterBrush, OnInvalidate);
  AssignDefaultMarginPen(FMarginPen, OnChangeMargin);
  with FLineSeparator do
    AssignDefaultMarginPen(FPen, PenChanged);
  FIntSource.RegisterNotifier(SourceChanged, false);
  FLineNumColor := Font.Color;
  FLineNumAlign := taRightJustify;

  FPrintOptions := [poShowProgress];
  {$IFNDEF CLX}
  FInsCaretWidth := GetSystemMetrics(SM_CXBORDER) shl 1;
  {$ELSE}
  FInsCaretWidth := 2;
  FHintTimer := TTimer.Create(Self);
  FDragTimer := TTimer.Create(Self);
  with FDragTimer do
  begin
    Enabled := false;
    OnTimer := OnDragTimer;
    Interval := 30;
  end;
  with FHintTimer do
  begin
    Enabled := false;
    OnTimer := OnHintTimer;
  end;
  FInternalColor := QColor_Create;
  FClxCaret := TCLXCaret.Create(Self);
  {$ENDIF}
  FMemoBackground := TControlBackground.Create(Self);
  FGutterBackground := TGutterBackground.Create(Self);

  FPositionStore := TMemoPostionStore.Create;
  FWordBreakList := TWordWrapList.Create;
  FLineInfoList := TLineInfoList.Create;
  FSelAttributes := TMemoAttributes.Create(Self);
  FBookmarkList := TList.Create;
  FWbCount := 1;
  FGradientBeginColor := clBlue;
  FGradientEndColor   := clBlack;
  FPopupHint := TPopupHint.Create(Self);
  FPopupHint.Immediate := true;
  FHintPause := 500;
  FLineNumBackColor := Color;
  FTempBitmap := TBitmap.Create;

  FCreated := true;
end;

{---------------------------------------------}

procedure TCustomDCMemo.Loaded;
begin
  inherited;
  with GetSource do
  begin
    JumpTo(0, 0);
    RecalculatePosition;
    ClearUndoBuffer;
  end;
  UpdateLineHeight;
  UpdateScrollPos;
  GetSource.Modified := false;
  UpdateMaxLine(true);
  UpdateAVESize;
  WordWrapLines(0, MaxInt, false);
end;

{---------------------------------------------}

procedure TCustomDCMemo.SetBackground(Value : TBitmap);
begin
  FMemoBackground.Background.Assign(Value);
end;

{---------------------------------------------}

function  TCustomDCMemo.GetBackground : TBitmap;
begin
  result := FMemoBackground.Background;
end;

{---------------------------------------------}

procedure TCustomDCMemo.SetBkgndOption(Value : TBkgndOption);
begin
  FMemoBackground.BkgndOption := Value;
end;

{---------------------------------------------}

function  TCustomDCMemo.GetBkgndOption : TBkgndOption;
begin
  result := FMemoBackground.BkgndOption;
end;

{---------------------------------------------}

procedure TCustomDCMemo.UpdateLineHeight;
begin
  FLineHeight := 0;
  GetAveLineHeight;
end;

{---------------------------------------------}

procedure TCustomDCMemo.TextStylesChanged(Sender : TObject);
begin
  FTextStylesChanged := true;
  Invalidate;
  UpdateLineHeight;
end;

{---------------------------------------------}

function TCustomDCMemo.GetAveLineHeight : integer;
var
  AFont : TFont;
begin
  if FLineHeight = 0 then
  begin
    if FUseMonoFont then
      FLineHeight := Max(TextStyles.GetMaxCharHeight, GetMaxFontHeight(Font))
    else
      FLineHeight := GetMaxFontHeight(Font);
    if SyntaxParser <> nil then
      AFont := SyntaxParser.GetFont(- 1)
    else
      AFont := nil;
    if AFont <> nil then
      FLineHeight := Max(FLineHeight, GetMaxFontHeight(AFont));
  end;
  result := FLineHeight;
end;

{---------------------------------------------}

function TCustomDCMemo.GetAveCharWidth : integer;
var
  AFont : TFont;
begin
  if FCharWidth = 0 then
  begin
    if FUseMonoFont then
      FCharWidth := Max(TextStyles.GetMaxCharWidth, GetAveFontWidth(Font))
    else
      FCharWidth := GetAveFontWidth(Font);

    if SyntaxParser <> nil then
      AFont := SyntaxParser.GetFont(- 1)
    else
      AFont := nil;
    if AFont <> nil then
      FCharWidth := Max(FCharWidth, GetAveFontWidth(AFont));
    FreeCharSp;
    UpdateCharSp(512);
  end;
  result := FCharWidth;
end;

{---------------------------------------------}

procedure TCustomDCMemo.FreeCharSp;
begin
  if FCharSp <> nil then
  begin
    FreeMem(FCharSp, FCharSpCount * SizeOf(integer));
    FCharSpCount := 0;
    FCharSp := nil;
  end;
end;

{---------------------------------------------}

procedure TCustomDCMemo.UpdateCharSp(L : integer);
var
  i : integer;
begin
  if FCharSpCount < L then
  begin
    FreeCharSp;
    FCharSpCount := L;
    GetMem(FCharSp, FCharSpCount * SizeOf(integer));
    for i := 0 to L - 1 do
      FCharSp[i] := CharWidth;
  end;
end;

{---------------------------------------------}


procedure TCustomDCMemo.FontOnChange(Sender : TObject);
var
  OWidth : integer;
begin
  Invalidate;
  FLineHeight := 0;
  UpdateLineHeight;
  UpdateLineNumbersWidth;
  FTextStyles.UpdateParams;
  FCharWidth := 0;
  GetAveCharWidth;

  OWidth := GetRealGutterWidth;
  GetLineNumbersWidth;
  if (GetRealGutterWidth <> OWidth) and FGutterBackground.NeedPaint then
    FGutterBackground.PaintBackground;

  FCaretSize := Point(0, 0);
  UpdateCaretMode;
  WordWrapLines(0, MaxInt, true);
  UpdateScrollSize;
  UpdateScrollPos;
  UpdateMaxLine(true);
  FFontMonoSpaced  := IsMemoFontMonospaced;
  AssignAttributeFont;
  if not FUseMonoFont then
    TMSource(GetSource).ParserChanged;
end;

{-------------------------------------------------------------}

destructor TCustomDCMemo.Destroy;
begin
  with TMSource(GetSource) do
    if ActiveMemo = Self then
    begin
      OnNavigate := nil;
      OnGetLineHeight := nil;
    end;
  FreeCharSp;
  FreePopupListBox;
  KillTimer;
  UnRegisterMemoEnvOptObject(Self);
  MemoList.Remove(Self);
  GetSource.UnRegisterNotifier(SourceChanged);
  FGutterImgs.Free;
  FMarginPen.Free;
  FLineSeparator.Free;
  FLineHighlight.Free;
  FSpecialSymbols.Free;
  FTextStyles.Free;
  FGutterBrush.Free;
  FCompletion.Free;
  FHintPopup.Free;
  FMemoBackground.Free;
  FGutterBackground.Free;
  FFont.Free;
  FPrinterFont.Free;
  FTemplateFont.Free;
  FPositionStore.Free;
  FWordBreakList.Clear;
  FWordBreakList.Free;
  FLineInfoList.Clear;
  FLineInfoList.Free;
  FSelAttributes.Free;
  FBookmarkList.Free;
  FTempBitmap.Free;
  {$IFDEF CLX}
  FHintTimer.Free;
  FDragTimer.Free;
  QColor_destroy(FInternalColor);
  FClxCaret.Free;
  {$ENDIF}
  inherited;
  FIntSource.Free;
end;

{--------------------------------------------}

procedure TCustomDCMemo.AssignAttributeFont;
begin
  if SyntaxParser is TAttributeParser then
    with TMemoAttributes(TAttributeParser(SyntaxParser).FFontManager[0]) do
    begin
      inc(FUpdateCount);
      try
        Assign(Self.Font);
        BkColor := Self.Color;
      finally
        dec(FUpdateCount);
      end;
    end;
end;

{--------------------------------------------}

function TCustomDCMemo.IsMemoFontMonospaced : boolean;
var
  i     : integer;
  ASize : integer;

  {----------------------------------------}

  function CheckFont(F : TFont; ASize : integer) : boolean;
  begin
     result := IsFontMonospaced(F);
     if result then
       {$IFDEF CLX}
       result := (GetAveFontWidth(F) = ASize);// and (GetMaxFontWidth(F) = ASize);
       {$ELSE}
       result := EqualFonts(Font, F, true) and (GetMinFontHeight(F) = GetMaxFontHeight(F));
       {$ENDIF}
  end;

  {--------------------------------------------}

begin
  ASize := GetAveFontWidth(Font);
  result := CheckFont(Font, ASize);
  if result then
    for i := 0 to TextStyles.Count - 1 do
    begin
      result := CheckFont(TextStyles[i].Font, ASize);
      if not result then
        break;
    end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.MarkColToTop;
begin
  GetSource.UnivMark(JumpToScreenTop, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomDCMemo.MarkColToBottom;
begin
  GetSource.UnivMark(JumpToScreenBottom, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomDCMemo.MarkColPageUp;
begin
  GetSource.UnivMark(PageUp, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomDCMemo.MarkColPageDown;
begin
  GetSource.UnivMark(PageDown, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomDCMemo.MarkToBottom;
begin
  GetSource.UnivMark(JumpToScreenBottom, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomDCMemo.MarkToTop;
begin
  GetSource.UnivMark(JumpToScreenTop, stStreamSel);
end;


{--------------------------------------------}

procedure TCustomDCMemo.MarkPageUp;
begin
  GetSource.UnivMark(PageUp, stStreamSel);
end;

{--------------------------------------------}

function TCustomDCMemo.CharScrollSize : boolean;
begin
  result := not (FWordWrap and FHideScrollBars and (GetWrapMargin > ClientWidth)) and
            (not FHideScrollBars or FUseMonoFont or (MaxLineLen = 0));
end;

{--------------------------------------------}

procedure TCustomDCMemo.ModifyScrollBar(ScrollBar, ScrollCode, Pos : integer);

  {----------------------------------------}

  procedure ScrollHorz;

    {-----------------------------------}

    procedure _Scroll;
    begin
      if CharScrollSize then
        ScrollScreenHorz(Pos - WinChar)
      else
        ScrollScreenHorz(Pos div CharWidth - WinChar);
    end;

    {-----------------------------------}

  begin
    with GetSource do
      case ScrollCode of
        SB_BOTTOM:
          ScrollScreenHorz( - CaretPoint.X + FHorzMaxPos);
        SB_LINELEFT:
          ScrollLeft;
        SB_LINERIGHT:
          ScrollRight;
        SB_PAGELEFT:
          ScrollPageLeft;
        SB_PAGERIGHT:
          ScrollPageRight;
        SB_TOP:
          ScrollScreenHorz( - CaretPoint.X);
        SB_THUMBPOSITION:
          _Scroll;
        SB_THUMBTRACK:
          if (moThumbTracking in Self.Options) then
            _Scroll;
      end;
  end;

  {----------------------------------------}

  procedure ScrollVert;
  begin
    with GetSource do
      case ScrollCode of
        SB_LINEUP:
          ScrollUp;
        SB_LINEDOWN:
          ScrollDown;
        SB_PAGEUP:
          ScrollPageUp;
        SB_PAGEDOWN:
          ScrollPageDown;
        SB_THUMBPOSITION:
            ScrollScreenVert(Pos - WinLine);
         SB_THUMBTRACK:
          if (moThumbTracking in Self.Options) then
            ScrollScreenVert(Pos - WinLine);
        SB_BOTTOM:
          JumpToFileEnd;
        SB_TOP:
          JumpToFileBegin;
      end;
  end;
  {----------------------------------------}
begin
  if Visible and CanFocus and TabStop and not (csDesigning in ComponentState) then
    SetFocus;

  if ScrollBar = SB_HORZ then
    ScrollHorz
  else
    ScrollVert;
end;

{--------------------------------------------}

procedure TCustomDCMemo.VerticalScroll(code : integer);
var
  ShowScrollHint : boolean;
  Pt             : TPoint;
  AX             : integer;
  AY             : integer;
  s              : string;
begin
  if not (moShowScrollHint in FOptions) then
    exit;
  if (code = SB_THUMBTRACK) or (code = SB_ENDSCROLL) then
  begin
    ShowScrollHint := true;
    s := sScrollLine +  ' ';
    if moThumbTracking in FOptions then
      AY := WinLine
    else
    {$IFNDEF CLX}
      AY := GetScrollPosEx(Handle, SB_VERT);
    {$ELSE}
      AY := WinLine;
    {$ENDIF}
    CheckVisibleIndex(AY, false);
    s := s + intToStr(AY + 1);

    if Assigned(FOnVerticalScroll) then
      FOnVerticalScroll(Self, AY, code = SB_ENDSCROLL, ShowScrollHint, s);
    if ShowScrollHint then
    begin
      if code = SB_ENDSCROLL then
        HidePopupHint
      else
      if s <> '' then
        begin
          with ClientRect do
            with ClientToScreen(Point(Right, Top)) do
            begin
              AX := X - FPopupHint.GetSize(s).cX;
              GetCursorPos(Pt);
              AY := Min(Max(Y, Pt.Y), ClientToScreen(Point(Right, Bottom)).Y);
            end;
          ShowPopupHint(s, Point(AX, AY), false);
        end;
    end;
  end;  
end;

{--------------------------------------------}


procedure TCustomDCMemo.ScrollUp;
begin
  ScrollScreenVert( - 1);
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollDown;
begin
  ScrollScreenVert(1);
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollPageUp;
begin
  if GetAveLineHeight <> 0 then
    ScrollScreenVert( - ClientHeight div GetAveLineHeight);
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollPageDown;
begin
  if GetAveLineHeight <> 0 then
    ScrollScreenVert(ClientHeight div GetAveLineHeight);
end;

{--------------------------------------------}


procedure TCustomDCMemo.ScrollLeft;
begin
  ScrollScreenHorz( - 1);
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollRight;
begin
  ScrollScreenHorz(1);
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollPageRight;
begin
  if GetAveCharWidth <> 0 then
    ScrollScreenHorz((ClientWidth - GetPaintX) div GetAveCharWidth);
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollPageLeft;
begin
  if GetAveCharWidth <> 0 then
    ScrollScreenHorz( (- ClientWidth + GetPaintX) div GetAveCharWidth);
end;


{--------------------------------------------}

procedure TCustomDCMemo.ScrollScreenHorz(I : integer);
var
  OWinChar : integer;
begin
  OWinChar := WinChar;
  if i < 0 then
    i := max(i, - WinChar);
  inc(WinChar, i);
  //dec(CaretChar, i);

  if OWinChar <> WinChar then
  begin
    QuickPaint(OWinChar, WinLine);
    UpdateCaret;
    UpdateScrollPos;
    DoMemoScroll(ssHorizontal, I);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.UpdateScrollPos;
begin
  if not HandleAllocated then
    exit;
  {$IFNDEF CLX}
  if FScrollBars in [ssHorizontal, ssBoth] then
  begin
    if CharScrollSize then
      _SetScrollPos(Handle, SB_HORZ, WinChar)
    else
      _SetScrollPos(Handle, SB_HORZ, WinChar * CharWidth);
  end;
  if FScrollBars in [ssVertical, ssBoth] then
   _SetScrollPos(Handle, SB_VERT, WinLine);
  {$ELSE}
  if FHorzScrollBar <> nil then
  begin
    if CharScrollSize then
      QScrollBar_setValue(FHorzScrollBar, WinChar)
    else
      QScrollBar_setValue(FHorzScrollBar, WinChar * CharWidth);
  end;
  if FVertScrollBar <> nil then
    QScrollBar_setValue(FVertScrollBar, WinLine);
  {$ENDIF}
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetHideScrollBars(Value : boolean);
begin
  if FHideScrollBars <> Value then
  begin
    FHideScrollBars := Value;
    UpdateScrollSize;
    UpdateScrollPos;
    UpdateMaxLine(false);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.UpdateScrollSize;
var
  MaxPos   : integer;
  PageSize : integer;
  AWidth   : integer;
  {$IFDEF CLX}

  procedure QSetHorzScrollBar(Val, ASize : integer);
  begin
    if FHorzScrollBar <> nil then
    begin
      QScrollBar_setMaxValue(FHorzScrollBar, Val);
      QScrollBar_setPageStep(FHorzScrollBar, ASize);
    end;
  end;

  {--------------------------------------------}

  procedure QSetVertScrollBar(Val, ASize : integer);
  begin
    if FVertScrollBar <> nil then
    begin
      QScrollBar_setMaxValue(FVertScrollBar, Val);
      QScrollBar_setPageStep(FVertScrollBar, ASize);
    end;
  end;

  {--------------------------------------------}

  {$ENDIF}
begin
 if not HandleAllocated then
   exit;
  {horizontal}
  if FScrollBars in [ssHorizontal, ssBoth] then
  begin
    MaxPos := FHorzMaxPos;
    if not FHideScrollBars or FUseMonoFont or (MaxLineLen = 0) then
      PageSize := Max(GetMaxCaretCharEx(true) + 1, 1)
    else
      PageSize := ClientWidth - GetPaintX;

    if FHideScrollBars then
    begin
      if FWordWrap then
      begin
        if GetWrapMargin > ClientWidth then
        begin
          AWidth := GetWrapMargin;
          PageSize := ClientWidth;
        end
        else
        begin
          PageSize :=  -1;
          AWidth := 0;
        end;
        {$IFNDEF CLX}
        _SetScrollSize(Handle, SB_HORZ, 0, AWidth, PageSize);
        {$ELSE}
        QSetHorzScrollBar(AWidth, PageSize);
        {$ENDIF}
      end
      else
      begin
        if (MaxLineLen < PageSize) then
          PageSize := -1;
        {$IFNDEF CLX}
        _SetScrollSize(Handle, SB_HORZ, 0, MaxLineLen, PageSize);
        {$ELSE}
        QSetHorzScrollBar(MaxLineLen, PageSize);
        {$ENDIF}
      end
    end
    else
      {$IFNDEF CLX}
      _SetScrollSize(Handle, SB_HORZ, 0, MaxPos, PageSize);
      {$ELSE}
      QSetHorzScrollBar(MaxPos, PageSize);
      {$ENDIF}
  end;
  {vertical}
  if FScrollBars in [ssVertical, ssBoth] then
  begin
    if FUseMonoFont then
      AWidth := GetMaxCaretChar
    else
      AWidth := ClientWidth;
    MaxPos := GetRealStrCountEx;
    PageSize := GetMaxCaretLine + 1;
    CheckVisibleIndex(PageSize, true);

    if FHideScrollBars and (MaxPos < PageSize) then //and (WinLine = 0) then
      PageSize := - 1
    else
    if MaxPos < PageSize then
      MaxPos := PageSize;
    {$IFNDEF CLX}
    _SetScrollSize(Handle, SB_VERT , 0, MaxPos, PageSize);
    {$ELSE}
    QSetVertScrollBar(MaxPos, PageSize);
    {$ENDIF}
    if (FUseMonoFont and (AWidth <> GetMaxCaretChar)) or (not FUseMonoFont and (AWidth <> ClientWidth)) then
      WordWrapLines(0, MaxInt, true);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.UpdateMaxLine(recalc : boolean);
begin
  if FCreated and (ComponentState * [csReading, csLoading] = []) then
  begin
    with TMSource(GetSource) do
      if recalc or not NeedMaxLineUpdate then
        UpdateMaxLine(FHideScrollBars and not FWordWrap and (FScrollBars in [ssHorizontal, ssBoth]));
    UpdateScrollSize;
    UpdateScrollPos;
  end;
end;

{--------------------------------------------}

{$IFNDEF CLX}
procedure TCustomDCMemo.SetBounds(ALeft, ATop, AWidth, AHeight: integer);
{$ELSE}
procedure TCustomDCMemo.ChangeBounds(ALeft, ATop, AWidth, AHeight: integer);
{$ENDIF}
var
  OldWidth  : integer;
  OldHeight : integer;
begin
  if not HandleAllocated then
  begin
    inherited;
    exit;
  end;
  if FUseMonoFont then
    OldWidth := GetMaxCaretChar
  else
    OldWidth := ClientWidth;
  OldHeight := Height;
  inherited;
  if FWordWrap and not (moBreakWordAtMargin in Options) and
    ((FUseMonoFont and (GetMaxCaretChar <> OldWidth)) or (not FUseMonoFont and (ClientWidth <> OldWidth ))) then
  begin
    with GetSource do
      if CaretPoint.X > Length(Strings[CaretPoint.Y]) then
        JumpToLineEnd;
    WordWrapLines(0, MaxInt, false);
  end;
  if (OldHeight <> Height) and UpdateLineNumbersWidth then
    Invalidate;
end;

{--------------------------------------------}

procedure TCustomDCMemo.ScrollScreenVert(I : integer);
var
  OWinLine : integer;
  ACount   : integer;
begin
  OWinLine := WinLine;

  if i < 0 then
    i := max(i, - WinLine);

  ACount := GetRealStrCountEx;
  if not (soBeyondFileEnd in GetSource.Options) and  (WinLine + i >= ACount + 1) and
     not((WinLine + i = ACount + 1) and (ACount = -1)) then
    i := Max(0, ACount - WinLine);

  inc(WinLine, i);
  //dec(CaretLine, i);
  if WinLine <> OWinLine then
  begin
    QuickPaint(WinChar, OWinLine);
    UpdateCaret;
    UpdateScrollPos;
{    if HideScrollBars and (FScrollBars in [ssVertical, ssBoth]) then
      UpdateScrollSize;
}      
    DoMemoScroll(ssVertical, I);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoMemoScroll(ScrollStyle : TScrollStyle; Delta : integer);
begin
  if Assigned(FOnMemoScroll) then
    FOnMemoScroll(Self, ScrollStyle, Delta);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetPosByMouse(X, Y : integer);
var
  FTempOptions : TStringsOptions;
  TextPoint    : TPoint;
begin
  with GetSource do
  begin
    if FWordWrap then
      X  := Max(X, GetPaintX);
    TextPoint := ConvertMousePosEx(X, Y, true);
    FTempOptions := Options;
    Options := Options + [soPersistentBlocks];
    with TextPoint do
      JumpTo(X, Y);
    Options := FTempOptions;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CancelDragging;
begin
  if (FEditState in [esBlockDrag, esBlockSel]) then
  with GetSource do
  begin
    BeginUpdate(acCancelDragging);
    KillTimer;
    SelectionType := stNotSelected;
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoSelTimer;
var
  P            : TPoint;
  FTempOptions : TStringsOptions;

  {---------------------------------------}

  procedure _SetCursor(Value : TCursor);
  begin
    {$IFNDEF CLX}
    Screen.Cursor := Value
    {$ELSE}
    QWidget_setCursor(Handle, Screen.Cursors[Value]);
    {$ENDIF}
  end;

  {---------------------------------------}

  procedure UpdateSelRect;
  var
    ALeft  : integer;
    ARight : integer;
    R      : TRect;
  begin
    with TMSource(GetSource), FSelStart do
    begin
      WordBounds(X, Y, ALeft, ARight, wsWordOnly);
      if ((ARight > ALeft) or ((ARight = ALeft) and (ARight > 0))) and (ALeft <= X) and (ARight > X) then
      begin
        R := SelectionRect;
        if FSelDirection then
        begin
          R.Left := ALeft - 1;
          FSelStart.X := ALeft- 1;
        end
        else
        begin
          R.Right := ARight;
          FSelStart.X := ARight;
        end;
        SelectionRect := R;
      end;
      FSelUpdated := true;
    end;
  end;

  {---------------------------------------}

begin
  if not (FEditState in [esBlockDrag, esBlockSel]) then
    Exit;
  GetCursorPos(P);
  P := ScreenToClient(P);
  if FWordWrap then
    P.X  := Max(P.X, GetPaintX);

  P := ConvertMousePosEx(P.X, P.Y, true);

  with GetSource do
    if (P.X <> Tag1{CaretPoint.X}) or (P.Y <> CaretPoint.Y) then
      case FEditState of
        esBlockSel:
          begin
            BeginUpdate(acMouseMark);
            FSelDirection := Tag1 <= P.X;
            Tag1 := P.X;
            Tag2 := P.Y;
            if isAltKeyDown then
              SelectionType := stBlockSel
            else
              SelectionType := stStreamSel;
            UnivMark(_MMoveEvent, SelectionType);
            if FNeedUpdateSel and not FSelUpdated then
              UpdateSelRect;
            EndUpdate;
          end;
        esBlockDrag:
          begin
            begin
              FTempOptions := Options;
              Options := Options + [soPersistentBlocks];
              JumpTo(P.X, P.Y);
              Options := FTempOptions;
              if IsPosInBlock(CurCharPos, CurLinePos) then
                _SetCursor(crNoDrop)
              else
                _SetCursor(DragCursor);

            end;
          end;
      end;
end;

{--------------------------------------------}


function TCustomDCMemo.PosInBlock(X, Y : integer) : boolean;
begin
  with GetSource do
    result := GetSource.IsPosInBlock(X, Y) and not
    ((moSelectOnlyText in FOptions) and (SelectionType = stStreamSel) and
    (X > _Length(Strings[Y])))
end;

{--------------------------------------------}

function TCustomDCMemo.IsUrlUnderPoint(Pt : TPoint; var s : string; TestOnly : boolean) : boolean;
var
  Item   : TStringItem;
  begPos : integer;
  endPos : integer;
begin
  with TMSource(GetSource) do
  begin
    Item := StringItem[Pt.Y];
    result := Item <> nil;
    if result then
    with Item do
      begin
        result := (Pt.X >= 0) and (Pt.X < length(ColorData)) and (Byte(ColorData[Pt.X + 1]) = tokUrl);
        if result and not TestOnly then
        begin
          begPos := Pt.X + 1;
          endPos := Pt.X + 1;
          while (begPos > 1) and (Byte(ColorData[begPos - 1]) = tokUrl) do
            dec(begPos);
          while (endPos < length(ColorData)) and (Byte(ColorData[endPos + 1]) = tokUrl) do
            inc(endPos);
          s := Copy(StrData, begPos, endPos - begPos + 1);
        end;
      end;
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.MouseAtHotString(X, Y : integer) : boolean;
var
  s : string;
begin
  result := (GetSource.HighlightUrls) and IsUrlUnderPoint(ConvertMousePosEx(X, Y, false), s, true);
  {

  if result then
  begin
    OldSet := GetSource.DelimSet;
    GetSource.DelimSet := [chr(0)..chr(255)] - cHotSpotChars - cOtherIdentChars;
    try
      result := IsStringHot(TextAtMousePoint(Point(X, Y)));
    finally
      GetSource.DelimSet := OldSet;
    end;
  end;
  }
end;

{--------------------------------------------}

procedure TCustomDCMemo.MouseMove(Shift: TShiftState; X, Y: integer);
begin
  inherited;
  if (FEditState = esNone) and (GetSource.HighlightUrls) and MouseAtHotString(X, Y) then
  begin
    if Cursor <> crMemoHandPt then
    begin
      FOldCursor := Cursor;
      Cursor := crMemoHandPt;
    end
  end
  else
  if Cursor = crMemoHandPt then
  begin
    Cursor := FOldCursor;
    {$IFNDEF CLX}
    SetCursor(Screen.Cursors[Cursor]);
    {$ELSE}
    QWidget_setCursor(Handle, Screen.Cursors[Cursor]);
    {$ENDIF}
  end
  {$IFDEF CLX}
  else
    if (FEditState = esNone) and not DoSetCursor then
      QWidget_setCursor(Handle, Screen.Cursors[Cursor]);
  {$ENDIF}
end;

{--------------------------------------------}

procedure TCustomDCMemo.MouseDown(Button: TMouseButton; Shift: TShiftState;
          X, Y: integer);

  {--------------------------------------------}

  procedure MarkLineorWord;
  begin
    FEditState := esMarkWord;
    with GetSource do
      if moDblClickLine in Self.Options
      then
        MarkLine
      else
        MarkWordWithType(WordSelectionType);
  end;

  {--------------------------------------------}

  function CaretAtMousePos(X ,Y : integer) : boolean;
  var
    Pt : TPoint;
  begin
    Pt := ConvertMousePosEx(X, Y, true);
    result := not ((Pt.X <> CaretPoint.X) and (soLimitEol in StringsOptions) or
                  (Pt.Y <> CaretPoint.Y) and not (soBeyondFileEnd in StringsOptions));
  end;

  {--------------------------------------------}
var
  OldPos  : TPoint;
  R       : TRect;
  OldLine : integer;
  OldChar : integer;
  Line    : integer;
begin
  OldLine := WinLine;
  OldChar := WinChar;

  if not (csDesigning in ComponentState) and CanFocus then
  begin
    if (Button = mbLeft) and not Focused then
      GetSource.SelectionType := stNotSelected;
    SetFocus;
    {$IFNDEF CLX}
    Windows.SetFocus(Handle);
    {$ENDIF} 
    if ValidParentForm(Self).ActiveControl <> Self then
    begin
      MouseCapture := false;
      Exit;
    end;
  end;
  KillHintTimer;
  with GetSource do
  begin
    WinLine := OldLine;
    WinChar := OldChar;

    OldPos := CaretPoint;

    FMouseOnButton := (Button  = mbLeft) and CheckMouseOnButton(X, Y, Line);
    if not FMouseOnButton and ((Button = mbLeft) or not (moDisableRightClickMove in FOptions)) then
      SetPosByMouse(X, Y);
    if not FMouseOnButton and (Button = mbLeft) then
    begin
      if ssDouble in Shift then
      begin
        {$IFNDEF CLX}
        FDblClickTime := GetTickCount;
        FDblClicPoint := Point(X, Y);
        {$ENDIF}
        if X >= GetPaintX then
          MarkLineOrWord;
      end
      {$IFNDEF CLX}
      else
      if not (moDblClickLine in Self.FOptions) and (moTripleClick in Self.FOptions) and (GetTickCount - FDblClickTime < GetDoubleClickTime) and (X >= GetPaintX) and
             (Abs(FDblClicPoint.X - X) <= GetSystemMetrics(SM_CXDOUBLECLK)) and (Abs(FDblClicPoint.Y - Y) <= GetSystemMetrics(SM_CYDOUBLECLK)) then
      begin
        FEditState := esMarkWord;
        MarkLine;
        FDblClickTime := 0;
      end
      {$ENDIF}
      else
      if FEditState = esNone then
      begin
        if CaretAtMousePos(X, Y) and PosInBlock(CurCharPos, CurLinePos)
           and not (moDisableDrag in FOptions) and not ReadOnly then
          FEditState := esBlockDrag
        else
          begin
            SelectionType := stNotSelected;
            FEditState := esBlockSel;
            if ssShift in Shift then
            begin
              BeginUpdate(acMouseMark);
              CaretPoint := OldPos;
              DoSelTimer;
              if SelectionType = stBlockSel then
              begin
                R := SelectionRect;
                with R do
                begin
                  if Left > Right then
                    SwapInt(Left, Right);
                  if Top > Bottom then
                    SwapInt(Top, Bottom);
                end;
                SelectionRect := R;
              end;
              EndUpdate;
            end
            else
              SelectionRect := Rect(0, 0, 0, 0);
          end;
        FSelStart := CaretPoint;
        Tag1 := FSelStart.X;
        FNeedUpdateSel := false;
        FSelUpdated := false;
        {$IFNDEF CLX}
        SetTimer(Handle, cDragDropTimer, 30, nil);
        {$ELSE}
        FDragTimer.Enabled := true;
        {$ENDIF}
      end;
    end
    else
    if (Button = mbRight)  and (FEditState in [esBlockDrag, esBlockSel]) then
      KillTimer;
  end;
  FMouseIsHot := MouseAtHotString(X, Y);
  FMouseOnGutter := (X >= 0) and (X < GetRealGutterWidth);
  inherited MouseDown(Button, Shift, X, Y);
end;

{--------------------------------------------}


function TCustomDCMemo.CheckMouseOnButton(X, Y : integer; var Line : integer) : boolean;
var
  AIndent : integer;
  LHeight : integer;
begin
  Line := ConvertMousePosEx(X, Y, true).Y;
  result := HideLines and (GetSource.CollapseState[Line] <> csNone) and (LineHeight <> 0);
  if result then
  begin
    LHeight := LineHeight;
    if LHeight > 16 then
      AIndent := Max((LHeight - 16) div 2, LHeight div 8)
    else
      AIndent := LHeight div 8;
    result := (X > GetPaintX - LHeight + AIndent) and (X < GetPaintX - AIndent);
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.KillTimer;
begin
  if FEditState in [esBlockDrag, esBlockSel] then
  begin
    Screen.Cursor := crDefault;
    {$IFNDEF CLX}
    Windows.KillTimer(Handle, cDragDropTimer);
    {$ELSE}
    FDragTimer.Enabled := false;
    {$ENDIF}
    KillHintTimer;
    FEditState := esNone;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.UndoClick(Sender : TObject);
begin
  GetSource.Undo;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CutClick(Sender : TObject);
begin
  CutToClipboard;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CopyClick(Sender : TObject);
begin
  CopyToClipboard;
end;

{--------------------------------------------}

procedure TCustomDCMemo.PasteClick(Sender : TObject);
begin
  PasteFromClipboard;
end;

{--------------------------------------------}

procedure TCustomDCMemo.DeleteClick(Sender : TObject);
begin
  GetSource.DeleteBlock;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SelectAllClick(Sender : TObject);
begin
  GetSource.SelectAll;
end;

{--------------------------------------------}

function TCustomDCMemo.GetDefaultMenu : TPopupMenu;

  {----------------------------------------}

  function AddItem(const ACaption : string; AEnabled : boolean; AOnClick: TNotifyEvent) : TMenuItem;
  begin
    result := NewItem(ACaption, 0, false, AEnabled, AOnClick,  0, UniqueName(Self.Owner, 'MenuItem'));// don't resource
  end;

  {----------------------------------------}

begin
  if FDefaultMenu = nil then
  begin
    FDefaultMenu := TPopupMenu.Create(Self);
    with FDefaultMenu, Items do
    begin
      AutoPopup := true;
      Add(AddItem(SEditUndoMenu, true, UndoClick));
      Add(AddItem('-', false, nil));
      Add(AddItem(SEditCutMenu, true, CutClick));
      Add(AddItem(SEditCopyMenu, true, CopyClick));
      Add(AddItem(SEditPasteMenu, true, PasteClick));
      Add(AddItem(SDelete, true , DeleteClick));
      Add(AddItem('-', false, nil));
      Add(AddItem(SSelectAll, true, SelectAllClick));
    end;
  end;
  result := FDefaultMenu;
end;

{--------------------------------------------}

function TCustomDCMemo.CanPaste : boolean;
begin
  result := not (GetSource.Readonly) and (GetSource.CanPaste or ((FClipboardType = cbRtf)
  {$IFNDEF CLX}
  and IsClipboardFormatAvailable(CF_RTF)
  {$ENDIF}
  ));
end;

{--------------------------------------------}

function TCustomDCMemo.CheckMenuPopup : boolean;
begin
  result :=  FUseDefaultMenu and (PopupMenu = nil);
  if result then
  begin
    with GetSource, DefaultMenu do
    begin
      Items[0].Enabled := UndoAvailable;
      Items[2].Enabled := CanCopy and not GetSource.Readonly;
      Items[3].Enabled := CanCopy;
      Items[4].Enabled := Self.CanPaste;
      Items[5].Enabled := Items[2].Enabled;
    end;
    PopupMenu := DefaultMenu;
  end;
end;

function TCustomDCMemo.ContextMenu(Pt : TPoint) : boolean;
var
  Temp  : TPoint;
begin
  KillTimer;
  result:= CheckMenuPopup;
  if result and (PopupMenu <> nil) then
  begin
    if Pt.X < 0 then
      Temp := Pt
    else
    begin
      Temp := ScreenToClient(Pt);
      if not PtInRect(ClientRect, Temp) then
      begin
        result := false;
        exit;
      end;  
    end;
    if (PopupMenu <> nil) then
    begin
      {$IFNDEF CLX}
      SendCancelMode(nil);
      {$ENDIF}
      PopupMenu.PopupComponent := Self;
      if Pt.X < 0 then
      begin
        if not HideCaret and Focused then
        begin
          Pt := TextToPixelPoint(CaretPoint);
          if not PtInRect(ClientRect, Pt) then
            Pt := ClientToScreen(Point(0, 0))
          else
          begin
            Pt := ClientToScreen(Pt);
            inc(Pt.X, FCaretSize.X);
          end;
        end
        else
        Pt := ClientToScreen(Point(0, 0));
      end;
      PopupMenu.Popup(Pt.X, Pt.Y);
    end;
  end;
end;

{--------------------------------------------}
{$IFNDEF CLX}
procedure TCustomDCMemo.WMContextMenu(var Message: TWMContextMenu);
var
  Popup : boolean;
begin
  Popup := ContextMenu(SmallPointToPoint(Message.Pos));
  if Popup then
    Message.Result := 1;
  inherited;
  if Popup then
    PopupMenu := nil;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMRButtonUp(var Message: TWMRButtonUp);
var
  Popup : boolean;
begin
  KillTimer;
  Popup := CheckMenuPopup;
  inherited;
  if Popup then
    PopupMenu := nil;
end;

{--------------------------------------------}

procedure TCustomDCMemo.WMSetCursor(var Message: TWMSetCursor);
begin
  if not DoSetCursor then
    inherited;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.CMCtl3DChanged(var Message : TMessage);
begin
  inherited;
  RecreateWnd;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.CreateHandle;
begin
  inherited;
  if FUseMonoFont then
    FontOnChange(nil);
  UpdateLineNumbersWidth;
end;

{-------------------------------------------------------------}
{$ENDIF}

{$IFNDEF CLX}
procedure TCustomDCMemo.GetClipboardBuffer(Format : Word; Stream : TStream);
var
  Data    : THandle;
  DataPtr : Pointer;
begin
  with Clipboard do
  begin
    Open;
    try
      Data := GetClipboardData(Format);
      if Data = 0 then
        exit;
      DataPtr := GlobalLock(Data);
      if DataPtr = nil
        then exit;
      try
        Stream.WriteBuffer(DataPtr^, GlobalSize(Data));
        Stream.Position := 0;
      finally
        GlobalUnlock(Data);
      end;
    finally
      Close;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetClipboardBuffer(Format: Word; var Buffer; Size: Integer);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  with Clipboard do
  begin
    Open;
    try
      Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, Size);
      try
        DataPtr := GlobalLock(Data);
        try
          Move(Buffer, DataPtr^, Size);
//          Clear;
          SetClipboardData(Format, Data);
        finally
          GlobalUnlock(Data);
        end;
      except
        GlobalFree(Data);
        raise;
      end;
    finally
      Close;
    end;
  end;
end;

{$ELSE}

{-------------------------------------------------------------}

procedure TCustomDCMemo.GetClipboardBuffer(Format : string; Stream : TStream);
begin
  with Clipboard do
    if GetFormat(Format, Stream) then
      Stream.Position := 0
    else
      Stream.Size := 0;
end;


{-------------------------------------------------------------}

procedure TCustomDCMemo.SetClipboardBuffer(Format: string; var Buffer; Size: Integer);
var
  Stream     : TMemoryStream;
  MimeSource : TClxMimeSource;
begin
  Stream := TMemoryStream.Create;
  try
    Stream.Write(Buffer, Size);
    Stream.Position := 0;
    MimeSource := TClxMimeSource.Create(Format, Stream);
    try
      QClipboard_setData(ClipBoard.Handle, MimeSource.Handle);
    finally
      MimeSource.Free;
    end;
  finally
    Stream.Free;
  end;
end;

{$ENDIF}

{-------------------------------------------------------------}

procedure TCustomDCMemo.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
var
  Line      : integer;
  s         : string;
  NewState  : TCollapseState;
  AOnButton : boolean;
  {$IFDEF CLX}
  Popup     : boolean;
  {$ENDIF}
begin
  if Button = mbLeft then
    with GetSource do
      case FEditState of
        esMarkWord:
          FEditState := esNone;
        esNone:
          SelectionType := stNotSelected;
        esBlockDrag:
          begin
            KillTimer;
            if (ssCtrl in Shift) then
            begin
              if not MoveBlockToPosEx(false) then
                SelectionType := stNotSelected;
            end
            else
            if not MoveBlockToPosEx(true) then
              SelectionType := stNotSelected;
          end;
        esBlockSel:
          begin
            KillTimer;
            if not isValidBlockPos(CurCharPos, CurLinePos) then
              SelectionType := stNotSelected;
          end;
      end;

  if FMouseIsHot and (Button = mbLeft) and (FEditState = esNone) and (GetSource.HighlightUrls) then
  begin
    if IsUrlUnderPoint(ConvertMousePosEx(X, Y, false), s, false) then
      if IsEmailString(s) then
      begin
        if Pos(SUrlMailTo, UpperCase(s)) = 0 then
          s:= LowerCase(SUrlMailTo) + s;
        MemoJumpToUrl(s);
      end
      else
        MemoJumpToUrl(s);
    {
    OldSet := GetSource.DelimSet;
    GetSource.DelimSet := [chr(0)..chr(255)] - cHotSpotChars - cOtherIdentChars;
    try
      s := TextAtMousePoint(Point(X,Y));
      if IsStringHot(s) then
        if IsEmailString(s) then
        begin
          if Pos(SUrlMailTo, UpperCase(s)) = 0 then
            s:= LowerCase(SUrlMailTo) + s;
          MemoJumpToUrl(s);
        end
        else
          MemoJumpToUrl(s);
    finally
      GetSource.DelimSet := OldSet;
    end;
   }
  end;
  FMouseIsHot := false;
  {$IFDEF CLX}
  if Button = mbRight then
  begin
    KillTimer;
    Popup := CheckMenuPopup;
  end
  else
    Popup := false;
  {$ENDIF}
  inherited MouseUp(Button, Shift, X, Y);
  {$IFDEF CLX}
  if Popup then
    PopupMenu := nil;
  {$ENDIF}

  AOnButton := CheckMouseOnButton(X, Y, Line);
  with GetSource do
    if FMouseOnButton and AOnButton and (SelectionType = stNotSelected) then
      if CollapseStateChanging(Line, CollapseState[Line]) then
      begin
        if CollapseState[Line] = csExpanded then
          NewState := csCollapsed
        else
          NewState := csExpanded;
        CollapseState[Line] := NewState;
        CollapseStateChanged(Line, NewState);
        SetPosByMouse(X, Y);
      end;

  FMouseOnButton := false;
  if FMouseOnGutter and (X >= 0) and (X < GetRealGutterWidth) then
  begin
    case Button of
      mbLeft  : include(Shift, ssLeft);
      mbRight : include(Shift, ssRight);
      mbMiddle : include(Shift, ssMiddle);
    end;
    DoClickGutter(Line, PointToImageIndex(Line, X), Shift);
  end;
  FMouseOnGutter := false;
end;

{--------------------------------------------}

function TCustomDCMemo.CollapseStateChanging(LinePos : integer; State : TCollapseState) : boolean;
begin
  if Assigned(FOnCollapseStateChanging) then
    FOnCollapseStateChanging(Self, LinePos, State = csCollapsed, result)
  else
    result := true;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CollapseStateChanged(LinePos : integer; State : TCollapseState);
begin
  if Assigned(FOnCollapseStateChanged) then
    FOnCollapseStateChanged(Self, LinePos, State = csCollapsed);
end;

{--------------------------------------------}

procedure TCustomDCMemo.DoClickGutter(LinePos, ImageIndex : integer; Shift : TShiftState);
begin
  if Assigned(FOnClickGutter) then
    FOnClickGutter(Self, LinePos, ImageIndex, Shift);
end;

{--------------------------------------------}

function TCustomDCMemo.PointToImageIndex(Line, XCoord : integer) : integer;
var
  i         : integer;
  X         : integer;
  NewWidth  : integer;
  NewHeight : integer;

  {-----------------------------------}

  procedure AssignX;
  begin
    if FGutterImgsAlign = iaLeft then
      X := 1
    else
      X := GetRealGutterWidth - 4;
  end;
  
  {-----------------------------------}

begin
  result := -1;
  AssignX;

  with GetSource do
    for i := 0 to cMaxGutterImages - 1 do
      if ImageBit[Line, i] then
      begin
        CalcGutterImgSize(i, NewWidth, NewHeight);
        if ((XCoord >= x) and (XCoord < X + NewWidth + 1) and (FGutterImgsAlign = iaLeft)) or
           ((XCoord <= x) and (XCoord > X - NewWidth - 1) and (FGutterImgsAlign = iaRight)) then
        begin
          result := i;
          exit;
        end;
        if FGutterImgsAlign = iaLeft then
          Inc(X, NewWidth + 1)
        else
          Dec(X, NewWidth + 1);
      end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.GetStrData(LinePos : integer; var S, ColorS : string);
begin
  with TMSource(GetSource) do
  begin
    if StringItem[LinePos] <> nil then
      with StringItem[LinePos] do
      begin
        if not (isWasParsed in ItemState) then
          ParseToString(LinePos, not FUseMonoFont);
        S := Lines[LinePos];
        if NeedSyntaxPaint then
          ColorS := GetStoredColorData(LinePos)
        else
          ColorS := '';
      end
    else
    begin
      S := '';
      ColorS := '';
    end;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.GetStrDataEx(var TextPoint : TPoint; var S, ColorS : string);
var
  Y : integer;
begin
  GetStrData(TextPoint.Y, S, ColorS);
  if FWordWrap then
  begin
    Y := TextPoint.Y;
    TextPoint := GetWBPosition(TextPoint);
    if Y <> TextPoint.Y then
    begin
      Y := GetRealPosition(Point(0,  TextPoint.Y)).X;
      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
        Y := _CharToByte(S, Y + 1) - 1; 
      {$ENDIF}
      S := copy(S, Y + 1, Length(S) - Y);
      ColorS := copy(ColorS, Y + 1, Length(ColorS) - Y);
    end;
  end;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetRealLineHeight(LinePos : integer) : integer;
begin
  if FUseMonoFont then
  begin
    result := LineHeight;
    exit;
  end;
  with TMSource(GetSource) do
    if StringItem[LinePos] <> nil then
      with StringItem[LinePos] do
      begin
        if not (isWasParsed in ItemState) then
          ParseTostring(LinePos, not FUseMonoFont);
        result := LineHeight;
        if result = 0 then
          result := Self.LineHeight;
      end
    else
      result := LineHeight;
end;

{--------------------------------------------}


function  TCustomDCMemo.GetRealLineWidth(LinePos : integer) : integer;
begin
  if FUseMonoFont then
  begin
    result := CharWidth * Length(Lines[LinePos]);
    exit;
  end;
  with TMSource(GetSource)do
    if StringItem[LinePos] <> nil then
      with StringItem[LinePos] do
      begin
        if not (isWasParsed in ItemState) then
          ParseTostring(LinePos, not FUseMonoFont);
        result := LineWidth;
        if result = 0 then
          result := CharWidth * Length(Lines[LinePos]);
      end
    else
      result := CharWidth * Length(Lines[LinePos]);
end;

{--------------------------------------------}

function  TCustomDCMemo.GetBaseLine(LinePos : integer) : integer;
begin
  if FUseMonoFont then
  begin
    result := 0;
    exit;
  end;
  with TMSource(GetSource) do
    if StringItem[LinePos] <> nil then
      with StringItem[LinePos] do
      begin
        if not (isWasParsed in ItemState) then
          ParseTostring(LinePos, not FUseMonoFont);
        result := BaseLine;
      end
    else
      result := 0;
end;

{--------------------------------------------}

function  TCustomDCMemo.SymbolsDrawn(LinePos, CharPos : integer; const S, ColorS : string; var BaseLine : integer;
          var R : TRect; exact, CheckMBCS : boolean) : integer;
var
  Pos       : integer;
  ARight    : integer;
  cs        : string;
  i         : integer;
  RealWidth : integer;
  AtEnd     : boolean;
begin
  BaseLine := 0;
  if not HandleAllocated or (R.Right = 0) or (GetDrawCanvas = nil) then
  begin
    result := 0;
    exit;
  end;
  if S = '' then
  begin
    result :=  R.Right div CalcSpacesSize(1, Point(0, LinePos));
    exit;
  end;

  ARight := R.Right;
  R.Bottom := 0;
  result := PaintString(R, BaseLine, S, ColorS, 0, length(S), 0, 0, 0, 0, false, true, true);
  AtEnd := result = length(S);

  {$IFDEF DCMBCS}
    if CheckMBCS and SysLocale.FarEast then
      result := _ByteToChar(S, result);
  {$ENDIF}

  if FCurFont <> nil then
    if AtEnd or ((ARight = R.Right) and (result <> 0)) then
    begin
      Pos := CalcSpacesSize(1, Point(CharPos + Length(s) - 1, LinePos));
      dec(ARight, R.Right);
      i := ARight div Pos;
      if not exact and (abs(ARight - Pos * (i + 1)) < abs(ARight - Pos * i)) then
        inc(i);
      inc(result, i);
    end
    else
    begin
      cs := Copy(S, result + 1, Length(S) - result);
      if IsUpperCaseStyle(FCurStyle) then
        cs := AnsiUpperCase(cs);
      if result <> 0 then
        dec(ARight, R.Right);

      i := GetCharsInWidth(GetCurFontHandle, Pchar(cs), Length(Cs), ARight, false, Exact, RealWidth);
      {$IFDEF DCMBCS}
      if CheckMBCS and SysLocale.FarEast then
        i := _ByteToChar(cs, i);
      {$ENDIF}

      inc(result, i);
    end;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetStringSize(LineNo, FromPos, Len : integer) : integer;
begin
  if FUseMonoFont then
    result := CharWidth * Len
  else
    result := TextToPixelChar(Point(FromPos + Len, LineNo)) - TextToPixelChar(Point(FromPos, LineNo));  
end;

{--------------------------------------------}

function TCustomDCMemo.CalcStringSize(S, ColorS : string; Pos, Len : integer; var BaseLine : integer) : TPoint;
var
  R     : TRect;
begin
  BaseLine := 0;
  if not HandleAllocated then
  begin
    result := Point(0, 0);
    exit;
  end;
  R := Rect(0, 0, 0, 0);
  PaintString(R, BaseLine, S, ColorS, Pos, Pos + Len, 0, 0, 0, 0, false, true, false);
  with R do
    result := Point(Right - Left, Bottom - Top);
end;

{--------------------------------------------}

function TCustomDCMemo.CalcSpacesSize(Count : integer; Point : TPoint) : integer;
var
  {$IFNDEF CLX}
  OldFont    : THandle;
  {$ELSE}
  s          : string;
  Handle     : QFontMetricsH;
  {$ENDIF}
  AFont      : TFont;
  OldAttr    : integer;
begin
  if not HandleAllocated or (Count = 0) then
  begin
    result := 0;
    exit;
  end;
  if SyntaxParser is TAttributeParser then
    with TMSource(GetSource) do
    begin
      OldAttr := DefaultAttribute;
      DefaultAttribute := -1;
      TAttributeParser(SyntaxParser).GetAttribute(Point, FSelAttributes);
      AFont := FSelAttributes.Font;
      DefaultAttribute := OldAttr;
    end
  else
    AFont := Font;
  {$IFNDEF CLX}
  OldFont := SelectObject(Canvas.Handle, AFont.Handle);
  try
    result := Canvas.TextWidth(' ') * Count;
  finally
    SelectObject(Canvas.Handle, OldFont);
  end;  
  {$ELSE}
  Handle := QFontMetrics_create(AFont.Handle);
  s := ' ';
  result := QFontMetrics_width(Handle, @s, 1) * Count;
  QFontMetrics_destroy(Handle);
  {$ENDIF}
  if result = 0 then
    result := 1;
end;

{--------------------------------------------}

function  TCustomDCMemo.GetWrappedLineWidth(Index : integer; var Pos : integer; SingleLine : boolean) : integer;
var
  WB     : TWBPoint;
  AIndex : integer;
  Exact  : boolean;
  {------------------------------------------}

  function _GetSize(ASize, AIndex : integer) : integer;
  begin
    if FUseMonoFont then
      with PWBPoint(FWordBreakList[AIndex])^ do
      begin
        result := X;
        if AIndex > 0 then
          with PWBPoint(FWordBreakList[AIndex - 1])^ do
            if Y = Index then
              dec(result, X);
        result := CharWidth * result;
      end
    else
      result := ASize;
  end;

  {------------------------------------------}

begin
  result := 0;
  CheckLastWrappedLine(Index);
  Wb.X := Pos - 1;
  Wb.Y := Index;
  AIndex := FWordBreakList.FindNear(@Wb, false, Exact) + 1;
  Pos := MaxInt;
  if (AIndex >= 0) and (AIndex < FWordBreakList.Count) then
  begin
    Wb := PWBPoint(FWordBreakList[AIndex])^;
    if Wb.Y = Index then
    begin
      Pos := Wb.X + 1;
      if SingleLine then
        result := _GetSize(Wb.Size.X, AIndex)
      else
        while (AIndex >= 0) do
          with PWBPoint(FWordBreakList[AIndex])^ do
          begin
            if Y <> Index then
              break;
            inc(result, _GetSize(Size.X, AIndex));
            dec(AIndex);
          end;
    end;
  end;
  if result = 0 then
    result := MaxInt;
end;

{--------------------------------------------}


function TCustomDCMemo.GetWrappedLineHeight(Index : integer) : integer;
var
  BLine   : integer;
  Pos     : integer;
begin
  if FWordWrap or (Lines[Index] = '') then
  begin
    Pos := 1;
    result := GetWrappedLineHeightEx(Index, Pos, BLine, false, true)
  end
  else
    result := GetRealLineHeight(Index);
end;

{--------------------------------------------}

function TCustomDCMemo.LineToPixel(StartLine, ToLine, Pos : integer) : integer;
var
  i     : integer;
  APos  : integer;
begin
   result := 0;

   with TMSource(GetSource) do
     for i := StartLine to ToLine - 1 do
     begin
       if HideLines and not GetRealLineVisible(GetRealLineIndex(i, APos)) then
         continue;

       if (i = StartLine) and (Pos > 1) then
         inc(result, GetWrappedLineHeightEx(StartLine, Pos, APos, false, true))
       else
         inc(result, GetWrappedLineHeight(i));
     end;
end;

{--------------------------------------------}

function TCustomDCMemo.TextToPixelLine(TextPoint : TPoint) : integer;
var
  Pt     : TPoint;
  Pos    : integer;
  CurPos : integer;
  tmp    : integer;
  S      : string;
  ColorS : string;

begin
  if FUseMonoFont then
  begin
    CheckVisibleIndex(TextPoint.Y, true);
    result := GetWBPosition(TextPoint).Y;
    Dec(result, WinLine);
    result := result * LineHeight;
  end
  else
  begin
    Pt := GetRealPosition(Point(0, WinLine));

    CheckVisibleIndex(Pt.Y, false);

    if (Pt.Y = TextPoint.Y) and (Pt.X = TextPoint.X) then
    begin
      result := 0;
      exit;
    end;


    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      Pos := _CharToByte(Lines[Pt.Y], Pt.X + 1)
    else
      Pos := Pt.X + 1;
    {$ELSE}
    Pos := Pt.X + 1;
    {$ENDIF}

    if (TextPoint.Y < Pt.Y) or ((TextPoint.Y = Pt.Y) and (TextPoint.X <= Pt.X)) then
      result := - LineToPixel(TextPoint.Y, Pt.Y + 1, 1) + GetWrappedLineHeightEx(Pt.Y, Pos, CurPos, false, true)
    else
      result := LineToPixel(Pt.Y, TextPoint.Y, Pos);
    if FWordWrap and (TextPoint.X > 0) then
    begin
      if Pt.Y <> TextPoint.Y then
        Pos := 1;
      GetStrData(TextPoint.Y, S, ColorS);
      while Pos < Length(S) do
      begin
        CurPos := Pos;
        tmp := GetWrappedLineHeightEx(TextPoint.Y, Pos, tmp, true, true);
        if Pos <= Min(_CharToByte(s, TextPoint.X + 1), Length(S)) then /// last char <
          inc(result, tmp)
        else
        begin
          Pt := TextPoint;
          Dec(Pt.X, CurPos - 1);
          if (Pos > length(S)) and CalcWrapPos(TextPoint.Y, CurPos - 1, Pt) then
          begin
            Pos := 1;
            inc(result, GetWrappedLineHeightEx(TextPoint.Y + 1, Pos, CurPos, true, true));
          end;
          break;
        end;
      end;
      if (S = '') then
      begin
        Pt := TextPoint;
        if CalcWrapPos(TextPoint.Y, 0, Pt) then
         inc(result, GetRealLineHeight(TextPoint.Y));
      end;
    end;
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.TextToPixelChar(TextPoint : TPoint) : integer;
var
  S        : string;
  ColorS   : string;
  Pos      : TPoint;
  i        : integer;
  APos     : integer;
begin
  if FUseMonoFont then
  begin
    if FWordWrap then
      result := GetWBPositionEx(TextPoint, true, false, i).X
    else
      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
        with TextPoint do
        begin
          s := Lines[Y];
          result := _CharToByte(s, X + 1) - 1;
        end
      else
        result := TextPoint.X;
      {$ELSE}
      result := TextPoint.X;
      {$ENDIF}

    Dec(result, WinChar);
    result := result * CharWidth;
    Inc(result, GetPaintX);
  end
  else
  begin
    Pos := TextPoint;
    GetStrDataEx(TextPoint, S, ColorS);
    if TextPoint.X <= 0 then
      result := - CalcSpacesSize(TextPoint.X, Pos)
    else
    begin
      {$IFDEF DCMBCS}
      APos := _CharToByte(s, TextPoint.X + 1) - 1;
      {$ELSE}
      APos := TextPoint.X;
      {$ENDIF}

      result := CalcStringSize(S, ColorS, 0, APos, i).X;

      if APos > length(S) then
        inc(result, CalcSpacesSize(APos - length(S), Pos));
    end;
    inc(result, GetPaintX);
    dec(result, WinChar * CharWidth);
  end;
end;

{--------------------------------------------}

function  TCustomDCMemo.TextToPixelPoint(TextPoint : TPoint) : TPoint;
begin
  result := Point(TextToPixelChar(TextPoint), TextToPixelLine(TextPoint));
end;

{--------------------------------------------}

function TCustomDCMemo.GetCurentPosinPixels : TPoint;
begin
  result := TextToPixelPoint(CaretPoint);
end;

{--------------------------------------------}

function  TCustomDCMemo.GetWrappedLineHeightEx(Index : integer; var Pos, BaseLine : integer; SingleLine, Direction : boolean) : integer;
var
  WB     : TWBPoint;
  AIndex : integer;
  found  : boolean;
  Exact  : boolean;
  Len    : integer;
begin
  BaseLine := 0;
  result := 0;
  CheckLastWrappedLine(Index);
  Wb.X := Pos - 1;
  Wb.Y := Index;
  found := false;
  AIndex := FWordBreakList.FindNear(@Wb, false, Exact);
  if Direction then
    inc(AIndex);
  while (AIndex >= 0) and (AIndex < FWordBreakList.Count) do
  begin
    Wb := PWBPoint(FWordBreakList[AIndex])^;
    if Wb.Y <> Index then
      break;
    if Direction then
      Pos := Wb.X + 1
    else
      Pos := Wb.X;
    BaseLine := Wb.BaseLine;
    if FUseMonofont or (Wb.Size.Y = 0) then
      inc(result, GetRealLineHeight(Index))
    else
      inc(result, Wb.Size.Y);
    found := true;
    if SingleLine then
      break;
    inc(AIndex);
  end;
  if not found then
    if Direction then
      Pos := Length(Lines[Index]) + 1
    else
      if (AIndex > 0) and (PWBPoint(FWordBreakList[AIndex - 1])^.Y = Index) then
        Pos := PWBPoint(FWordBreakList[AIndex - 1])^.X
      else
        Pos := 0;
  if not (found and SingleLine) then
  begin
    if FUseMonoFont then
    begin
      inc(result, GetRealLineHeight(Index));
      exit;
    end;
    Wb.Y := Index;
    Wb.X := 0;
    with FLineInfoList do
      if Find(@Wb, AIndex) and (AIndex >= 0) and (AIndex < Count) then
      begin
        Len := PWBPoint(Items[AIndex])^.Size.Y;
        if Len <> 0 then
          inc(result, Len)
        else
          inc(result, GetRealLineHeight(Index));
        BaseLine := PWBPoint(Items[AIndex])^.BaseLine;
      end
      else
      begin
        inc(result, GetRealLineHeight(Index));
        BaseLine := GetBaseLine(Index);
      end;
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.PixelToTextLine(var LinePos, CharPos : integer; CheckEnd : boolean) : integer;
var
  H       : integer;
  OldH    : integer;
  len     : integer;
  BLine   : integer;
  Pos     : integer;
  Pt      : TPoint;
  ftime   : boolean;
  CurLine : integer;
  {-------------------------------------}

  procedure _inc(var X : integer; Count : integer);
  begin
    if LinePos >= 0 then
      inc(X, count)
    else
      dec(X, count);
  end;

  {-------------------------------------}

  function LastLine : boolean;
  begin
    if LinePos >= 0 then
    begin
      result := (H > LinePos) or (CheckEnd and (CurLine > GetRealStrCount));
    end
    else
      result := H <= LinePos;

    if result then
      LinePos := OldH;
  end;

  {-------------------------------------}

  function InString(Pos, Len : integer) : boolean;
  begin
    result := ((LinePos >= 0) and (Pos <= len)) or ((LinePos < 0 ) and (Pos > 0));
  end;

  {-------------------------------------}

begin
  CharPos := 1;
  CheckEnd := CheckEnd and not FUseMonoFont and FWordWrap and not (soBeyondFileEnd in StringsOptions);
  if FUseMonoFont then
  begin
    result :=  WinLine + LinePos div LineHeight;
    CheckVisibleIndex(result, false);
  end
  else
  begin
    CurLine := WinLine;
    CheckVisibleIndex(CurLine, false);

    Pt := GetRealPositionEx(Point(0, CurLine), true);
    result := Pt.Y;
    CharPos := Pt.X + 1;

    H := 0;
    OldH := 0;
    ftime := true;
    with TMSource(GetSource) do
    begin
      repeat
        if HideLines and not GetRealLineVisible(result) then
        begin
          _inc(result, 1);
          continue;
        end;
        len := length(Lines[result]);
        if not ftime then
          if LinePos >= 0 then
            CharPos := 1
          else
            CharPos := len;
        ftime := false;
        if FWordWrap and  (len <> 0) then
        begin
          while InString(CharPos, len) do
          begin
            Pos := CharPos;
            OldH := H;
            if LinePos < 0  then
              dec(CharPos);
            _inc(H, GetWrappedLineHeightEx(result, CharPos, BLine, true, LinePos >= 0));
            _inc(CurLine, 1);
            if LastLine then
            begin
              CharPos := Pos;
              exit;
            end;
          end;
        end
        else
        begin
          OldH := H;
          _inc(H, GetRealLineHeight(result));
          _inc(CurLine, 1);
        end;
        if LastLine then
          break;
        _inc(result, 1);
      until false;
    end;
  end;
  CharPos := 1;
end;

{--------------------------------------------}

function TCustomDCMemo.PixelToTextChar(LinePos, CharPos, X : integer; CheckEnd : boolean): integer;
var
  S       : string;
  ColorS  : string;
  Pos     : integer;
  BLine   : integer;
  AWidth  : integer;
  R       : TRect;
  exact   : boolean;
  IncX    : boolean;

  {--------------------------------------------}

  function _Check(const s : string; Pos : integer) : integer;
  begin

    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
    begin
      dec(Pos);                         /// last char
      if _IsTrailByte(s, Pos) then
        dec(Pos);
      result := _ByteToChar(S, Pos)
    end
    else
      result := Pos - 1;               /// last char
    {$ELSE}
    result := Pos - 1;                 /// last char
    {$ENDIF}
    dec(result);
  end;

  {--------------------------------------------}

begin

  exact := X >= GetWrapMargin;
  if FUseMonoFont then
    begin
      CharPos := Max(CharPos, 1);
      Dec(X, GetPaintX);
      result := WinChar + X div CharWidth;
      s := Lines[LinePos];
      Pos := CharPos;
      IncX := not exact and ((X mod CharWidth) * 2 > CharWidth);
      if IncX then
        inc(result);


      if FWordWrap and CheckEnd then
      begin
        AWidth := GetWrappedLineWidth(LinePos, Pos, true);
        if (X >= AWidth) or (IncX and (X >= AWidth - CharWidth / 2)) then
        begin
          result := _Check(S, Pos);
          exit;
        end;
      end
      {$IFDEF DCMBCS}
      else
        AWidth := 0;
      {$ELSE}
      ;
      {$ENDIF}

      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
      begin
        ColorS := Copy(s, CharPos, MaxInt);
        if _IsTrailByte(ColorS, result + 1) then
          if IncX then
            dec(result)
          else
            inc(result);
        if FWordWrap and CheckEnd and (result * CharWidth >= AWidth) then
        begin
          result := _Check(S, Pos);
          exit;
        end;
        result := _ByteToChar(ColorS, result + 1) - 1;
        inc(result, _ByteToChar(s, CharPos) - 1);
      end
      else
        inc(result, CharPos - 1);
      {$ELSE}
      inc(result, CharPos - 1);
      {$ENDIF}
      exit;
    end;


  exact := X >= GetWrapMargin;
  GetStrData(LinePos, S, ColorS);
  dec(X, GetPaintX);
  inc(X, CharWidth * WinChar);
  if (X < 0) or ((X = 0) and (CharPos = 0)) then
    result := X div CalcSpacesSize(1, Point(0, LinePos))
  else
  begin
    CharPos := Max(CharPos, 1);
    if FWordWrap then
    begin
      Pos := CharPos;
      if X >= GetWrappedLineWidth(LinePos, Pos, true) then
      begin
        result := _Check(S, Pos);
        exit;
      end;
    end
    else
      Pos := MaxInt;
    R :=  Rect(0, 0, X, 0);


    result := _ByteToChar(S, CharPos) - 1 + SymbolsDrawn(LinePos, CharPos, copy(S, CharPos, MaxInt), copy(ColorS, CharPos, MaxInt),
                                         BLine, R, exact, true);

    if FWordWrap and (_CharToByte(S, result) > Pos - 2) then
      result := _Check(S, Pos);
  end;
end;

{--------------------------------------------}

function TCustomDCMemo.ConvertMousePos(XX, YY : integer) : TPoint;
begin
  result := MouseToTextPoint(XX, YY, false);
end;

{--------------------------------------------}

function  TCustomDCMemo.MouseToTextPoint(XX, YY : integer; CheckEnd : boolean) : TPoint;
var
  LinePos : integer;
  Pos     : integer;
begin
  if FUseMonoFont then
  begin
    result.Y := WinLine + YY div LineHeight;

    if CheckEnd and not(soBeyondFileEnd in GetSource.Options) then
      result.Y := Min(result.Y, GetRealStrCount);

    result.Y := GetRealLineIndex(result.Y, Pos);
    CheckVisibleIndex(result.Y, false);
    LinePos := result.Y;
    inc(Pos);
  end
  else
  begin
    result.Y := PixelToTextLine(YY, Pos, CheckEnd);
    LinePos := result.Y;
    if (LinePos < 0) then
      LinePos := 0
    else
    if (LinePos >= Lines.Count) and not(soBeyondFileEnd in GetSource.Options) then
      LinePos := Lines.Count - 1;
  end;
  result.X := PixelToTextChar(LinePos, Pos, XX, true);
end;

{--------------------------------------------}

function  TCustomDCMemo.ConvertMousePosEx(XX, YY : integer; CheckEnd : boolean) : TPoint;
begin
  if FWordWrap then
    XX := Min(XX, GetWrapMargin);
  result := MouseToTextPoint(XX, YY, CheckEnd);
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetTextStyles(V : TTextStyles);
begin
  FTextStyles.Assign(V);
  UpdateAVESize;
  Invalidate;
end;

{--------------------------------------------}

function TCustomDCMemo.GetSource : TCustomMemoSource;
begin
  result := fMemoSource;
  if result = nil then
    result := fIntSource;
end;

{--------------------------------------------}

procedure TCustomDCMemo.SetHorzMaxPos(V : THorzMaxPos);
begin
  if (FHorzMaxPos <> V) and (V >= 40) and (V < 10000) then
  begin
    FHorzMaxPos := V;
    UpdateScrollPos;
    UpdateScrollSize;
  end;
end;

{--------------------------------------------}

function  TCustomDCMemo.IsPointVisible(Point : TPoint) : boolean;
var
  Pt      : TPoint;
  MAxLine : integer;
begin
  result := true;
  Pt := GetWBPosition(Point);
  CheckVisibleIndex(Pt.Y, true);
  if Pt.Y < WinLine then
    result := false
  else
  begin
    MaxLine := GetMaxCaretLine;
    CheckVisibleIndex(MaxLine, true);
    if Pt.Y > WinLine + MaxLine then
      result := false;
  end;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CenterScreenOnLineEx;
begin
  if IsPointVisible(CaretPoint) then
    RecalculatePosition
  else
    CenterScreenOnLine;
end;

{--------------------------------------------}

procedure TCustomDCMemo.CenterScreenOnLine;
var
  i : integer;
begin
  RecalculatePosition;
  i :=  CaretPoint.Y - GetMaxCaretLine shr 1;
  if i > 0 then
    ScrollScreenVert( - WinLine + i)
  else
    WinLinePos := 0;
end;

{--------------------------------------------}

procedure TCustomDCMemo._MMoveEvent;
var
  ALeft   : integer;
  ARight  : integer;

  {--------------------------------------------}

  function _CompareInt(A, B : integer; Equal : boolean) : boolean;
  begin
    result := ((A < B) and not Equal) or ((A <= B) and Equal);
  end;

  {--------------------------------------------}

  function InclusiveSel : boolean;
  begin
    with FSelStart do
      if Y = Tag2 then
        result := FSelDirection = (FSelStart.X <= Tag1)
      else
      if Y < Tag2 then
        result := FSelDirection
      else
        result := not FSelDirection
  end;

  {--------------------------------------------}

begin
  if moExtendedSel in FOptions then
    with TMSource(GetSource) do
      if SelectionType = stStreamSel then
      begin
        WordBounds(Tag1, Tag2, ALeft, ARight, wsWordOnly);
        if ((ARight > ALeft) or ((ARight = ALeft) and (ARight > 0))) and
          _CompareInt(Tag1, ARight, FSelDirection) and _CompareInt(ALeft - 1, Tag1, not FSelDirection) then
        begin
          with FSelStart do
            if not ((Y = Tag2) and (X >= ALeft) and (X <= ARight)) and InclusiveSel then
            begin
              if FSelDirection then
                GetSource.JumpTo(ARight, Tag2)
              else
                GetSource.JumpTo(ALeft - 1, Tag2);
              FNeedUpdateSel := true;
              exit;
            end;
        end;
      end;
  GetSource.JumpTo(Tag1, Tag2);
end;

{--------------------------------------------}

procedure TCustomDCMemo.MarkPageDown;
begin
  GetSource.UnivMark(PageDown, stStreamSel);
end;

{--------------------------------------------}

function TCustomDCMemo.GetLines : TStrings;
begin
  result := GetSource.Lines;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetLines(V : TStrings);
begin
  GetSource.Lines := V;
end;

{-------------------------------------------------------------}


function TCustomDCMemo.GetReadOnly : boolean;
begin
  result := GetSource.ReadOnly;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetReadOnly(V : boolean);
begin
  GetSource.ReadOnly := V;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetLineNumAlign(V : TAlignment);
begin
  if FLineNumAlign <> V then
  begin
    FLineNumAlign := V;
    Invalidate;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.LoadFromFile(const FileName : string);
begin
  GetSource.LoadFromFile(FileName);
  GetSource.ObjectName := FileName;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SaveToFile(const FileName : string);
begin
  GetSource.SaveToFile(FileName);
  GetSource.ObjectName := FileName;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ImportText(Sender : TObject; const s : string; AFont : TFont; AColor : TColor);
var
  len   : integer;
begin
  with TMSource(GetSource) do
  begin
    if s = SNewLine then
    begin
      if ClipSelType = cfStreamSel then
      begin
        BreakLine;
        JumpTo(0, CaretPoint.Y + 1);
        with CaretPoint do
          SelectionRect := Rect(0, Y, 0, Y);
        SelectionType := stStreamSel;
      end
      else
      begin
        if CaretPoint.Y < Lines.Count - 1 then
        begin
          CursorDown;
          JumpToChar(FClipCurChar);
        end
        else
        begin
          JumpToChar(length(Strings[CaretPoint.Y]));
          BreakLine;
          CursorDown;
          StringItem[CaretPoint.Y].ColorData := '';
          JumpToChar(FClipCurChar);
        end;
      end;
    end
    else
    if s = #9 then
    begin
      len := CaretPoint.X;
      PressTab;
      with CaretPoint do
        SetSelection(stStreamSel, len, Y, X, Y);
    end
    else
    begin
      len := InsertEx(s, '');
      with CaretPoint do
        SetSelection(stStreamSel, X, Y, X + len, Y);
      JumpToChar(CaretPoint.X + len);
    end;

    if (DefaultAttribute <> 0) or (not EqualFonts(AFont, Font, false) or ((Color <> AColor) and (AColor <> -1))) then
      with FSelAttributes do
      begin
        BeginUpdate;
        try
          FUseStored := false;
          Assign(AFont);
          if (AColor = -1) then
            BkColor := Self.Color
          else
            BkColor := AColor;
          FState := GetAllAttributes(true);
        finally
          EndUpdate;
          SelectionType := stNotSelected;
          AssignMemoFont;
        end;
      end;
    SelectionType := stNotSelected;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.PasteFromHtmlStream(Stream : TStream);
begin
  PasteFromImportStream(Stream, TDCHTMLImporter);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.PasteFromHtmlFile(const FileName : string);
var
  Stream : TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    PasteFromHtmlStream(Stream);
  finally
    Stream.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.LoadFromHtmlStream(Stream : TStream);
var
  OldUndo : boolean;
begin
  with GetSource do
  begin
    OldUndo := AllowUndo;
    AllowUndo := false;
    BeginUpdate(acLoadFromStrings);
    try
      Clear;
      if SyntaxParser is TAttributeParser then
        TAttributeParser(SyntaxParser).ClearStyles;
      PasteFromHtmlStream(Stream);
      JumpTo(0, 0);
      ClearUndoBuffer;
    finally
      AllowUndo := OldUndo;
      EndUpdate;
      Modified := false;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.LoadFromHtmlFile(const FileName : string);
var
  Stream : TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromHtmlStream(Stream);
  finally
    Stream.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.LoadFromRtfStream(Stream : TStream);
var
  OldUndo : boolean;
begin
  with GetSource do
  begin
    OldUndo := AllowUndo;
    AllowUndo := false;
    BeginUpdate(acLoadFromStrings);
    try
      Clear;
      if SyntaxParser is TAttributeParser then
        TAttributeParser(SyntaxParser).ClearStyles;
      PasteFromRtfStream(Stream);
      JumpTo(0, 0);
      ClearUndoBuffer;
    finally
      AllowUndo := OldUndo;
      EndUpdate;
      Modified := false;
    end;
  end;  
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.LoadFromRtfFile(const FileName : string);
var
  Stream : TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromRtfStream(Stream);        
  finally
    Stream.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.PasteFromRtfFile(const FileName : string);
var
  Stream : TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    PasteFromRtfStream(Stream);
  finally
    Stream.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.PasteFromRtfStream(Stream : TStream);
begin
  PasteFromImportStream(Stream, TDCRtfImporter);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.PasteFromImportStream(Stream : TStream; ImporterClass : TDCImporterClass);
var
  s        : string;
  Sl       : TStrings;
  Importer : TDCImporter;
begin
  with Stream do
  begin
    if Size = 0 then
      exit;
    SetLength(s, Size);
    Read(s[1], Size);
  end;
  Importer := ImporterClass.Create;
  try
    Stream.Seek(0, 0);
    if not Importer.IsValidStream(Stream) then
      with GetSource do
      begin
        Sl := TStringList.Create;
        try
          Sl.LoadFromStream(Stream);
          InsertStrings(Sl, not ((BlockOption = bkStreamSel) or (BlockOption = bkNone)) and (ClipSelType = cfBlockSel));
        finally
          Sl.Free;
        end;
        SelectionType := stNotSelected;
        exit;
      end;

    with TMSource(GetSource) do
    begin
      BeginUpdate(acImportRtf);
      FClipCurChar := CaretPoint.X;
      if (BlockOption = bkStreamSel) or (BlockOption = bkNone) then
        ClipSelType := cfStreamSel;
      InImport := true;
      with Importer do
        try
          GetSelAttributes;
          OnParseText := ImportText;
          ParseText(s);
        finally
          InImport := false;
          EndUpdate;
        end;
    end;
  finally
    Importer.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportTo(const Exporter : TDCExporter);
begin
  ExportToEx(Exporter, false);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToEx(const Exporter : TDCExporter; Selection : boolean);
var
  IsBold      : boolean;
  IsItalic    : boolean;
  IsUnderline : boolean;
  IsStrikeOut : boolean;
  IsFontName  : boolean;
  IsFontSize  : boolean;
  IsColor     : boolean;
  IsBkColor   : boolean;
  Data        : string;
  UseTab      : boolean;

  {------------------------------------------------------}

  procedure ProcessString(Exporter : TDCExporter; Data : string);
  begin
    Data := Exporter.TranslateString(Data);
    if Assigned(FOnExportString) then
      FOnExportString(Exporter, Data);
    Exporter.WriteString(Data);
  end;

  {------------------------------------------------------}

  procedure _StartFont(Font : TFont; Color : TColor);
  begin
    with Exporter do
    begin
      if IsFontName then
      {$IFDEF D3}
      StartFontWithCharSet(Font.Name, Font.Charset);
      {$ELSE}
        StartFont(Font.Name);
      {$ENDIF}
      if IsFontSize then
        StartFontSize(Font.Size);
      if IsBold then
        StartBold;
      if IsItalic then
        StartItalic;
      if IsUnderline then
        StartUnderline;
      if IsStrikeOut then
        StartStrikeOut;
      if IsColor then
        StartColor(Font.Color);
      if IsBkColor then
        StartBackColor(Color);
    end;
  end;

  {------------------------------------------------------}

  procedure _FinishFont;
  begin
    with Exporter do
    begin
      if IsBkColor then
        FinishBackColor;
      if IsColor then
        FinishColor;
      if IsStrikeOut then
        FinishStrikeOut;
      if IsUnderline then
        FinishUnderline;
      if IsItalic then
        FinishItalic;
      if IsBold then
        FinishBold;
      if IsFontSize then
        FinishFontSize;
      if IsFontName then
        FinishFont;
    end;
  end;

  {------------------------------------------------------}

  function _Start : integer;
  begin
    if Selection then
      with GetSource do
        if SelectionType <> stNotSelected then
          result := SelectionRect.Top
        else
          result := 0
    else
      result := 0;
  end;

  {------------------------------------------------------}

  function _End : integer;
  begin
    if Selection then
      with GetSource do
        if SelectionType <> stNotSelected then
          result := SelectionRect.Bottom
        else
          result := -1
    else
      result := Lines.Count - 1;
  end;

  {------------------------------------------------------}

  function _Get(Index : integer {$IFDEF DCMBCS}; Line : integer; AtEnd : boolean{$ENDIF}) : integer;
  {$IFDEF DCMBCS}
  var
    s : string;
  {$ENDIF}
  begin
    result := Index;
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
    begin
      s := Lines[Line];
      result := _CharToByte(s, result);
      if AtEnd and (s[result] in LeadBytes) then
        inc(result);
    end;
    {$ENDIF}
    if UseTab then
      with TMSource(GetSource) do
        ChangeTabIndex(Data, result);
  end;

  {------------------------------------------------------}

  function LineStart(Index : integer) : integer;
  begin
    result := 1;
    if Selection then
      with GetSource, SelectionRect do
        case SelectionType of
          stStreamSel:
            if (Top = Bottom) or (Index = Top) then
              result := _Get(Left + 1 {$IFDEF DCMBCS}, Index, false{$ENDIF});
          stBlockSel:
            result := _Get(Left + 1 {$IFDEF DCMBCS}, Index, false{$ENDIF});
        end;
  end;

  {------------------------------------------------------}

  function LineEnd(Index : integer) : integer;
  begin
    result := Length(Data);
    if Selection then
      with GetSource, SelectionRect do
        case SelectionType of
          stStreamSel:
            if (Top = Bottom) or (Index = Bottom) then
              result := Min(result, _Get(Right {$IFDEF DCMBCS}, Index, true{$ENDIF}));
          stBlockSel:
            result := Min(result, _Get(Right + 1 {$IFDEF DCMBCS}, Index, true{$ENDIF}));
        end;
  end;

  {------------------------------------------------------}

  procedure CheckEmptyLines(AtLineEnd : boolean; SEnd : integer; var i : integer);
  begin
    if AtLineEnd then
      while i < SEnd do
        if Lines[i + 1] = '' then
        begin
          Exporter.NewLine;
          inc(i);
        end
        else
          break;
  end;

  {------------------------------------------------------}

var
  OldFont     : TFont;
  ColorData   : string;
  I           : integer;
  J           : integer;
  NewFont     : TFont;
  OldStrIndex : integer;
  AStyle      : integer;
  AEnd        : integer;
  AStart      : integer;
  SEnd        : integer;
  SStart      : integer;
  OldBkColor  : TColor;
  NewBkColor  : TColor;
begin
  with Exporter do
  begin
    UseTab := UseTabCharacter;
    with GetSource do
      if ObjectName <> '' then
        StartDocument(ObjectName)
      else
        StartDocument(Name);
    StartBackground(Color);
  end;
  IsFontName := true;
  IsFontSize := true;
  IsColor := true;
  IsBkColor := false;
  if NeedSyntaxPaint then
  begin
    IsBold := false;
    IsItalic := false;
    IsUnderLine := false;
    IsStrikeOut := false;
  end
  else
  begin
    IsBold := fsBold in Font.Style;
    IsItalic := fsItalic in Font.Style;
    IsUnderline := fsUnderline in Font.Style;
    IsStrikeOut := fsStrikeOut in Font.Style;
  end;
  _StartFont(Font, Color);
  OldFont := Font;
  OldBkColor := Color;
  try
    if NeedSyntaxPaint then
    begin
      SStart := _Start;
      I := SStart;
      SEnd := _End;
      with TMSource(GetSource) do
        while I <= SEnd do
        begin
          if UseTab then
          begin
            if StringItem[I] <> nil then
              Data := StringItem[I].StrData
            else
              Data := '';
          end
          else
            Data := Lines[I];

          if I <> SStart then
            Exporter.NewLine;

          if Data = '' then
          begin
            inc(i);
            Continue;
          end;
          with TMSource(GetSource) do
            if UseTab then
              ColorData := GetColorData(I)
            else
              ColorData := GetStoredColorData(I);

          AStart := LineStart(i);
          J := AStart;
          AEnd := LineEnd(i);
          OldStrIndex := AStart;

          if ColorData <> '' then
            AStyle := Ord(ColorData[J])
          else
            AStyle := 0;
          if AEnd >= AStart then
          repeat
            while (J <= AEnd) and (Ord(ColorData[J]) = AStyle) do
              inc(J);

            if (J <= AEnd) and EqualStyles(AStyle, Ord(ColorData[J]), false) then
            begin
              inc(J);
              continue;
            end;

            if (AStyle = 0) and ((SyntaxParser = nil) or not (moColorSyntax in FOptions)) and (HighlightUrls) then
            begin
              NewFont := Font;
              NewBkColor := Color;
            end
            else
            begin
              NewFont := GetFontFromTextStyle(AStyle);
              NewBkColor := GetColorFromTextStyle(AStyle);
            end;
            if J <= AEnd then
              AStyle := Ord(ColorData[J]);

            IsFontName := (OldStrIndex = AStart) or (NewFont.Name <> OldFont.Name) or (NewFont.Name <> Font.Name);
            IsFontSize := (OldStrIndex = AStart) or (NewFont.Size <> OldFont.Size) or (NewFont.Size <> Font.Size);
            IsColor := (OldStrIndex = AStart) or (NewFont.Color <> OldFont.Color) or (NewFont.Color <> Font.Color);
            IsBkColor := (NewBkColor <> OldBkColor) or (NewBkColor <> Color);

            IsBold := fsBold in NewFont.Style;
            IsItalic := fsItalic in NewFont.Style;
            IsUnderline := fsUnderline in NewFont.Style;
            IsStrikeOut := fsStrikeOut in NewFont.Style;
            OldFont := NewFont;
            _StartFont(NewFont, NewBkColor);
            ProcessString(Exporter, Copy(Data, OldStrIndex, J - OldStrIndex));
            CheckEmptyLines(J > AEnd, SEnd, i);
            _FinishFont;
            OldStrIndex := J;
            if J > AEnd then
              break;
          until false;
          inc(I);
        end;
    end
    else
      with TMSource(GetSource) do
      begin
        for i := _Start to _End do
        begin
         if I <> 0 then
           Exporter.NewLine;
         if UseTab then
         begin
           if StringItem[I] <> nil then
              Data := StringItem[I].StrData
            else
              Data := '';
         end
         else
           Data := Lines[i];
         j := LineStart(i);
         AEnd := LineEnd(i);
         ProcessString(Exporter, Copy(Lines[I], j, AEnd - j +1));
        end;
    end;
  finally

    IsFontName := true;
    IsFontSize := true;
    IsColor := true;
    _FinishFont;
    with  Exporter do
    begin
      FinishBackground;
      FinishDocument;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToStream(Stream : TStream; Exporter : TDCExporterClass);
begin
  ExportToStreamEx(Stream, Exporter, false);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToStreamEx(Stream : TStream; Exporter : TDCExporterClass; Selection : boolean);
var
  ExporterInst : TDCExporter;
begin
  ExporterInst := Exporter.Create(Stream);
  try
    ExportToEx(ExporterInst, Selection);
  finally
    ExporterInst.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToFile(const FileName : string; Exporter : TDCExporterClass);
begin
  ExportToFileEx(FileName, Exporter, false);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToFileEx(const FileName : string; Exporter : TDCExporterClass; Selection : boolean);
var
  Stream : TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    ExportToStreamEx(Stream, Exporter, Selection);
  finally
    Stream.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToHtmlFile(const FileName : string);
begin
  ExportToHtmlFileEx(FileName, false);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToHtmlFileEx(const FileName : string; Selection : boolean);
begin
  ExportToFileEx(FileName, TDCHTMLExporter, Selection);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToRtfFile(const FileName : string);
begin
  ExportToRtfFileEx(FileName, false);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToRtfFileEx(const FileName : string; Selection : boolean);
Begin
  ExportToFileEx(FileName, TDCRtfExporter, Selection);
End;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToHtmlStream(Stream : TStream);
begin
  ExportToHtmlStreamEx(Stream, false);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToHtmlStreamEx(Stream : TStream; Selection : boolean);
begin
  ExportToStreamEx(Stream, TDCHTMLExporter, Selection);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToRtfStream(Stream : TStream);
begin
  ExportToRtfStreamEx(Stream, false);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.ExportToRtfStreamEx(Stream : TStream; Selection : boolean);
begin
  ExportToStreamEx(Stream, TDCRtfExporter, Selection);
end;

{-------------------------------------------------------------}

function TCustomDCMemo.GetCodeTemplates : TMemoCodeTemplates;
begin
  result := GetSource.CodeTemplates;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetCodeTemplates(V : TMemoCodeTemplates);
begin
  GetSource.CodeTemplates := V;
end;

{-------------------------------------------------------------}

function  TCustomDCMemo.GetTemplatesType : string;
begin
  result := GetSource.TemplatesType;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.SetTemplatesType(value : string);
begin
  GetSource.TemplatesType := Value;
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.HintInsert(var s : string);
begin
  if Assigned(FOnHintInsert) then
    FOnHintInsert(Self, s);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.TemplateInsert(Strings : TStrings);
begin
  if Assigned(FOnTemplateInsert) then
    FOnTemplateInsert(Self, Strings);
end;

{-------------------------------------------------------------}

procedure TCustomDCMemo.CodeTemplCallBack(Sender : TObject; SelIndex : integer);
var
  Sl    : TStringList;
  Pt    : TPoint;
  Index : integer;

  {-------------------------------------------------------}

  function CursorAtStrings(Sl : TStrings) : TPoint;
  const
    SCursorTag = '|';
  var
    s     : string;
    Pt    : TPoint;
    i     : integer;
    Len   : integer;
  begin
    result := CaretPoint;
    for i := 1 to Sl.Count - 1 do
      Sl[i] := StringOfSpace(result.X) +  Sl[i];
    if FindFirstInStrings(SCursorTag, Sl, false, Pt, Len, nil) then
    begin
      s := Sl[Pt.y];
      delete(s, Pt.x, 1);
      Sl[Pt.y] := s;
      if Pt.y = 0 then
        inc(result.x, Pt.x)
      else
        result.x := Pt.x;
      {$IFDEF DCMBCS}
      result.X := _ByteToChar(s, result.X);
      {$ENDIF}
      Dec(result.X);
      inc(result.y, Pt.y);
    end;
  end;

  {-------------------------------------------------------}

begin
  if (SelIndex >= 0) and (SelIndex < FCompletion.Count) then
    Index := integer(FCompletion.Objects[SelIndex])
  else
    Index := -1;

  with GetSource.CodeTemplates do
    if (Index >=0) and (Index < Count) then
      with GetSource do
      begin
        Sl := TStringList.Create;
        BeginUpdate(acCodeDesigner);
        try
          DeleteBlock;
          Sl.Assign(Items[Index].Code);
          TemplateInsert(Sl);
          Pt := CursorAtStrings(Sl);
          InsertStrings(Sl, false);
          SelectionType := stNotSelected;
          CaretPoint := Pt;
        finally
          EndUpdate;
          Sl.Free;
        end
      end
    else
      GetSource.SelectionType := stNotSelected;
end;

{-------------------------------------------------------------}
                                                                           
procedure TCustomDCMemo.MarkWordOnTemplate;
var
  s       : string;
  CurChar : integer;
  Pt      : TPoint;
    {-------------------------------------------------------------}

  function _InsideWord(const s : string; P : integer) : boolean;
  begin
    result := (P <= length(s)) and not (s[P] in GetSource.DelimSet) and
    (P - 1  > 0) and  not (s[P - 1] in GetSource.DelimSet);
  end;

  {-------------------------------------------------------------}

  function _AfterWord(const s : string; P : integer) : boolean;
  begin
    if P > length(S) then
      P := length(S)
    else
      P := P - 1;
    result := (P > 0) and not (s[P] in GetSource.DelimSet);
  end;

  {-------------------------------------------------------------}

  function _BeforeWord(const s : string; P : integer) : boolean;
  var
    i : integer;
  begin
    i := 1;
    while (i <= length(s)) and (s[i] in GetSource.DelimSet) do
      inc(i);
    result := P = i;
  end;

{-------------------------------------------------------------}

begin
  with GetSource do
  begin
    CurChar := CurCharPos + 1;
    s := Strings[CurLinePos];
    {$IFDEF DCMBCS}
    CurChar := _CharToByte(s, CurChar);
    {$ENDIF}
    SelectionType := stNotSelected;
    if (soPersistentBlocks in StringsOptions) or ( not _InsideWord(s, CurChar)
       and (_AfterWord(s, CurChar) or _BeforeWord(s, CurChar)) ) then
    begin
      BeginUpdate(acNavigate);
      Pt := CaretPoint;
      MarkWord;
      CaretPoint := Pt;
      EndUpdate;
    end;
  end;
end;

{-------------------------------------------------------------}


procedure TCustomDCMemo.ShowCodeTemplates;
var
  Point : TPoint;
  s     : string;
  Index : integer;
begin
  if TemplatesType = SLangNone then
    exit;

  FreePopupListBox;
  Point := GetCurentPosinPixels;
  MarkWordOnTemplate;
  with GetSource do
  begin
    if SelStrings.Count = 1 then
      s := Trim(SelStrings[0])
    else
      s := '';
    Index := CodeTemplates.ConvertCodeTemplates(FCompletion, S);
    if Index <> - 1 then
      CodeTemplCallBack(Self, Index)
    else
      FPopupListBox := PopupListbox(Self, FCompletion , Point.X, Point.Y + LineHeight,
      [lrLeftJustify, lrRightJustify ], FTemplateFont, CodeTemplCallBack, 0);
  end;
end;

{-------------------------------------------------------------}

function TCustomDCMemo.TextAtMousePoint(Point : TPoint) : string;
begin
  with GetSource do
  begin
    Point := ConvertMousePosEx(Point.X, Point.Y, false);
    result := CorrectTextAt(Point.X, Point.Y);
  end;
end;

{*************************************************************}


function TTextStyles.GetItem(index : integer) : TTextStyle;
begin
  result := TTextStyle(inherited Items[index]);
end;

{--------------------------------------------}

procedure TTextStyles.LoadColorStyles;
begin
  with TOpenDialog.Create(nil) do
  try
    Title := SLoadColorStyles;
    {$IFNDEF CLX}
    Filter := SColorStyleFilter;
    Options := [ofHideReadOnly];
    {$ENDIF}
    if Execute then
      ReadObjFromTextFile(Self, FileName);
  finally
    Free;
  end;
end;

{--------------------------------------------}

procedure TTextStyles.SaveColorStyles;
begin
  with TSaveDialog.Create(nil) do
  try
    Title := SSaveColorStyles;
    {$IFNDEF CLX}
    Filter := SColorStyleFilter;
    Options := [ofHideReadOnly];
    {$ENDIF}
    if Execute then
      WriteObjToTextFile(Self, ChangeFileExt(FileName, '.RGB')); //don't resource
  finally
    Free;
  end;
end;

{--------------------------------------------}


procedure TTextStyles.BeginParserUpdate;
begin
  inc(FUpdateCount);
end;

{---------------------------------------------}

procedure TTextStyles.EndParserUpdate;
begin
  dec(FUpdateCount);
  if (FUpdateCount = 0) and (Owner is TCustomDCMemo) then
    with TCustomDCMemo(Owner) do
    begin
      if FParserChanged  then
      begin
        TMSource(GetSource).ParserChanged;
        FParserChanged := false;
        UpdateCaretMode;
      end;
      FFontMonoSpaced := IsMemoFontMonospaced;
      UpdateLineHeight;
      UpdateScrollSize;
      UpdateScrollPos;
      UpdateAVESize;
    end;
end;

{---------------------------------------------}

procedure TTextStyles.Assign(Source : TPersistent);
begin
  BeginParserUpdate;
  try
    inherited;
  finally
    EndParserUpdate;
  end;
end;

{---------------------------------------------}

function TTextStyles.GetMaxCharWidth : integer;
var
  i : integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    result := Max(result, GetAveFontWidth(Items[i].Font));
end;

{---------------------------------------------}

function TTextStyles.GetMaxCharHeight : integer;
var
  i : integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    if Items[i].Font <> nil then
      result := Max(result, GetMaxFontHeight(Items[i].Font));
end;

{---------------------------------------------}

procedure TTextStyles.SetDefaultStyles;
begin
  BeginParserUpdate;
  try
    Clear;
    AddStyleEx(STxtStWhiteSp, clBlack, clWindow, [], mcNone, false, true);
    AddStyleEx(STxtStStr,clMaroon,clWindow,[],mcNone,false,true);
    AddStyleEx(STxtStComment, clGray, clWindow, [fsItalic], mcNone, false, true);
    AddStyleEx(STxtStIdent, clBlack, clWindow, [], mcNone, false, true);
    AddStyleEx(STxtStinteger, clGreen, clWindow,[] , mcNone, false, true);
    AddStyleEx(STxtStFloat, clGreen, clWindow, [], mcNone, false, true);
    AddStyleEx(STxtStResWords, clBlue, clWindow, [fsBold], mcNone, false, true);
    AddStyleEx(STxtStDelims, clBlack, clWindow, [], mcNone, false, true);
    AddStyleEx(STxtStDefines, clGreen, clWindow, [], mcNone, false, true);
    AddStyleEx(STxtStAsm, clGreen, clWindow, [], mcNone, false, true);
    AddStyleEx(STxtStHtmlTag, clBlue, clWindow, [], mcNone, false, true);
    AddStyleEx(STxtStHtmlParams, clBlue, clWindow, [], mcNone, false, true);
    AddStyleEx(STxtStUrl, clBlue, clWindow, [fsUnderLine], mcNone, false, true);

    AddStyleEx(STxtStBreakPnt, clWindow, clRed, [], mcNone, false, false);
    AddStyleEx(STxtStErrorLn, clWindow, clMaroon, [], mcNone, false, false);

    AddStyleEx(STxtStMarkedBlock, clWhite, clNavy, [], mcSelection, false, false);
    AddStyleEx(STxtStSearchMatch, clLime, clBlack, [], mcSearchMatch, false, false);

    AddStyleEx(STxtStEmphasis, clBlack, clWindow, [fsBold], mcNone, False, True);
    AddStyleEx(STxtStSystemVariable, clBlue, clWindow, [], mcNone, False, True);
    AddStyleEx(STxtStScriptWhiteSp, clTeal, clWindow, [], mcNone, False, True);
    AddStyleEx(STxtStScriptDelimiters, clBlack, clWindow, [], mcNone, False, True);
    AddStyleEx(STxtStScriptComment, clGray, clWindow, [fsItalic], mcNone, False, True);
    AddStyleEx(STxtStScriptString, clMaroon, clWindow, [], mcNone, False, True);
    AddStyleEx(STxtStScriptNumber, clBlue, clWindow, [], mcNone, False, True);
    AddStyleEx(STxtStScriptResWord, clBlack, clWindow, [fsBold], mcNone, False, True);

    if Owner is TCustomDCMemo then
      with TCustomDCMemo(Owner) do
        FFontMonoSpaced := IsMemoFontMonospaced;
  finally
    EndParserUpdate;
  end;

end;

{--------------------------------------------}

procedure TTextStyles.UpdateParams;
var
  i : integer;
begin
  BeginParserUpdate;
  try
    for i := 0 to Count - 1 do
      with TTextStyle(Items[i]) do
      begin
        if UseMemoColor then
          AssignMemoColor;
        if UseMemoFont then
          AssignMemoFont;
        AssignFontNameAndSize;
      end;
  finally
    EndParserUpdate;
  end;
end;

{--------------------------------------------}

procedure TTextStyle.DoUpdateMemoColors;
begin
  if Memo<>nil then
  with Memo do
    case FUpdateMemoColors of
      mcNone:
        begin
        end;
      mcText:
        begin
          Font.Color := Self.Font.Color;
          Color := Self.Color;
        end;
      mcSelection:
        begin
          SelColor := Self.Font.Color;
          SelBackColor := Self.Color;
        end;
      mcSearchMatch:
        begin
          MatchColor := Self.Font.Color;
          MatchBackColor := Self.Color;
        end;
    end;
end;

{--------------------------------------------}

procedure TTextStyle.SetUpdateMemoColors(V : TUpdateMemoColors);
begin
  if FUpdateMemoColors <> V then
  begin
    FUpdateMemoColors := V;
    DoUpdateMemoColors;
  end;
end;

{--------------------------------------------}

function TTextStyles.AddStyleEx(const StyleName : string; AColor, ABackColor : TColor;
  AStyle : TFontStyles; AUpdateType : TUpdateMemoColors; AUseMemoFont, AUseMemoColor : boolean) : TTextStyle;
begin
  BeginUpdate;
  try
    result := TTextStyle(Add);
    with result do
    begin
      Color := ABackColor;
      Name := StyleName;
      Font.Color := AColor;
      Font.Style := AStyle;
      UseMemoColor := AUseMemoColor;
      UseMemoFont := AUseMemoFont;
      UpdateMemoColors := AUpdateType;
    end;
  finally
    EndUpdate;
  end;
end;

{--------------------------------------------}

function TTextStyles.AddStyle(const StyleName : string; AColor, ABackColor : TColor) : TTextStyle;
begin
  BeginUpdate;
  try
    result := TTextStyle(Add);
    with result do
    begin
      Color := ABackColor;
      Name := StyleName;
      Font.Color := AColor;
    end;
  finally
    EndUpdate;
  end;
end;

{--------------------------------------------}

function TTextStyle.IsColorStored : boolean;
begin
  result := not FUseMemoColor;
end;

{--------------------------------------------}

function TTextStyle.IsFontStored : boolean;
begin
  result := not FUseMemoFont;
end;

{--------------------------------------------}

procedure TTextStyle.SetUseMemoFont(V : boolean);
begin
  if FUseMemoFont <> V then
  begin
    if V and (FUpdateMemoColors <> mcNone) then
      exit;
    FUseMemoFont := V;
    if V then
      AssignMemoFont;
    OnChange(Self);
  end;
end;

{--------------------------------------------}

procedure TTextStyle.SetUseMemoColor(V : boolean);
begin
  if FUseMemoColor <> V then
  begin
    if V and (FUpdateMemoColors <> mcNone) then
      exit;
    FUseMemoColor := V;
    if V then
      AssignMemoColor;
    OnChange(Self);
  end;
end;

{--------------------------------------------}

procedure TTextStyle.SetUpperCase(Value : boolean);
begin
  if FUpperCase <> Value then
  begin
    FUpperCase := Value;
    DoParserChanged(true);
    OnChange(Self);
  end;
end;

{--------------------------------------------}

procedure TTextStyle.SetColor(V : TColor);
begin
  if FColor <> V then
  begin
    FColor := V;
    FUseMemoColor := false;
    FBrush.Color := FColor;
    DoUpdateMemoColors;
    Changed(false);
  end;
end;

{--------------------------------------------}

procedure TTextStyle.SetFont(V : TMemoFont);
begin
  FFont.Assign(V);
end;

{--------------------------------------------}

function TTextStyle.Memo : TCustomDCMemo;
begin
  result := TCustomDCMemo(TTextStyles(Collection).Owner);
end;

{--------------------------------------------}

procedure TTextStyle.AssignMemoFont;
begin
  if Memo <> nil then
  begin
    Font := Memo.Font;
    FUseMemoFont := true;
  end;
end;

{--------------------------------------------}

procedure TTextStyle.AssignMemoColor;
begin
  if Memo <> nil then
  begin
    FColor := Memo.Color;
    FUseMemoColor := true;
  end
  else
    if (Collection = nil) or not TTextStyles(Collection).InColorUpdate then 
    FColor := clWindow;
end;

{--------------------------------------------}

procedure TTextStyle.AssignFontNameAndSize;
begin
  if (Memo <> nil) then
  begin
    FFont.Name := Memo.Font.Name;
    FFont.Size := Memo.Font.Size;
  end;
end;

{--------------------------------------------}

procedure TTextStyle.DoParserChanged(NeedUpdate : boolean);
begin
  if (Memo <> nil) and (NeedUpdate or not (Memo.FUseMonoFont)) then
    with TTextStyles(Collection) do
      if FUpdateCount > 0 then
        FParserChanged := true
      else
      begin
        TMSource(Memo.GetSource).ParserChanged;
        if Memo <> nil then
          with Memo do
            FFontMonoSpaced := IsMemoFontMonospaced;
      end;
end;

{--------------------------------------------}

procedure TTextStyle.OnFontChange(Sender : TObject);
begin
  FUseMemoFont := false;
  DoUpdateMemoColors;
  OnChange(Sender);
  DoParserChanged(false);
end;

{--------------------------------------------}

constructor TTextStyle.Create(AOwner : TCollection);
begin
  inherited;
  FBrush := TBrush.Create;
  FFont := TMemoFont.Create(Self);
  UseMemoColor := true;
  UseMemoFont := true;
  FFont.OnChange := OnFontChange;
end;

{--------------------------------------------}

destructor TTextStyle.Destroy;
begin
  FFont.Free;
  FBrush.Free;
  inherited;
end;

{---------TGutterImage-----------------------------------------}

procedure TGutterImage.SetBookMarkIndex(V : integer);
begin
  if FBookMarkIndex <> V then
  begin
    FBookmarkIndex := V;
    Changed(false);
  end;
end;

{-------------------------------------------------------------}

procedure TGutterImage.FreeResources;
begin
  FGlyph.Dormant;
//  FGlyph.FreeImage;
end;

{-------------------------------------------------------------}

procedure TGutterImage.OnChange(Sender:TObject);
begin
  inherited;
  FreeResources;
end;

{-------------------------------------------------------------}

constructor TGutterImage.Create(AOwner : TCollection);
begin
  inherited;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := OnChange;
  FreeResources;
  FBookMarkIndex := - 1;
end;

{-------------------------------------------------------------}

function TGutterImage.IsBoomarkIndexStored : boolean;
begin
  result := FBookMarkIndex <> -1;
end;

{-------------------------------------------------------------}

procedure TGutterImage.SetGlyph(Value : TBitmap);
begin
  FGlyph.Assign(Value);
end;

{-------------------------------------------------------------}

destructor TGutterImage.Destroy;
begin
  FGlyph.Free;
  inherited;
end;

{-------------------------------------------------------------}

procedure SaveMemoPos(AMemo : TCustomDCMemo; Pos : TStoredPosition);
begin
  with Pos do
  begin
    MemoSource  := AMemo.GetSource;
    WinLine := AMemo.WinLinePos;
    WinChar := AMemo.WinCharPos;
    CaretPoint := MemoSource.CaretPoint;
  end;
end;

{------------------------------------------------------------------}

constructor TStoredPosition.Create(AMemo : TCustomDCMemo);
begin
  inherited Create;
  SaveMemoPos(AMemo, Self);
end;

{------------------------------------------------------------------}

function  TPositionList.Compare(Item1, Item2 : Pointer) : integer;
begin
  result := integer(TStoredPosition(Item1).MemoSource) - integer(TStoredPosition(Item2).MemoSource);
end;

{------------------------------------------------------------------}

function  TPositionList.CompareWithKey(Item, Key : Pointer) : integer;
begin
  result := integer(TStoredPosition(Item).MemoSource) - integer(Key);
end;

{------------------------------------------------------------------}

constructor TMemoPostionStore.Create;
begin
  inherited Create;
  FPositions := TPositionList.Create;
end;

{------------------------------------------------------------------}

destructor TMemoPostionStore.Destroy ;
begin
  FreeSortedList(FPositions,FPositions);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TMemoPostionStore.SavePosition(Memo : TCustomDCMemo);
var
  Index : integer;
  SPos  : TStoredPosition;
begin
  if FPositions.FindByKey(Memo.GetSource, Index) then
    SaveMemoPos(Memo, TStoredPosition(FPositions[Index]))
  else
  begin
    SPos  := TStoredPosition.Create(Memo);
    FPositions.Add(SPos);
  end;
end;

{------------------------------------------------------------------}

procedure TMemoPostionStore.RestorePosition(Memo : TCustomDCMemo);
var
  Index : integer;
begin
  with Memo do
  begin
    GetSource.BeginUpdate(acNavigate);
    try
      if FPositions.FindByKey(Memo.GetSource, Index) then
        with TStoredPosition(FPositions[Index]) do
        begin
          WinLinePos := WinLine;
          WinCharPos := WinChar;
          GetSource.CaretPoint := CaretPoint;
        end
{      else
        GetSource.JumpTo(0, 0)}
    finally
      GetSource.EndUpdate;
    end;
  end;
end;

{--------TFontList--------------------------------------------------}

function TFontList.Compare(Item1, Item2: Pointer) : integer;
begin
  result := Integer(TMemoAttributes(Item1).Font.Handle) - Integer(TMemoAttributes(Item2).Font.Handle);
  if result = 0 then
    result := TMemoAttributes(Item1).Font.Color - TMemoAttributes(Item2).Font.Color;
  if result = 0 then
    result := TMemoAttributes(Item1).BkColor - TMemoAttributes(Item2).BkColor;
end;

{--------TAttributeParser------------------------------------------}

constructor TAttributeParser.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FFontManager := TList.Create;
  FCachList := TFontList.Create;
  if AOwner is TCustomDCmemo then
    with TCustomDCMemo(AOwner) do
      AddNewAttribute(FSelAttributes);
end;

{------------------------------------------------------------------}

destructor TAttributeParser.Destroy;
begin
  FreeList(FFontManager,FFontManager);
  FCachList.Free;
  FEmptyList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TAttributeParser.AddToCachList(Attribute : TMemoAttributes; Index : integer);
begin
  Attribute.FData := Index;
  FCachList.Add(Attribute);
end;

{------------------------------------------------------------------}

procedure TAttributeParser.ClearStyles;
var
  i : integer;
begin
  with FFontManager do
  begin
    for i := Count - 1 downto 1 do
      TObject(Items[i]).Free;
    Count := 1;
  end;
  FEmptyList.Free;
  FEmptyList := nil;
  FCachList.Clear;
  if Memo <> nil  then
  begin
    FInClearStyles := true;
    try
      TMSource(Memo.GetSource).ParserChanged;
    finally
      FInClearStyles := false;
    end;
  end;  
end;

{------------------------------------------------------------------}

function  TAttributeParser.GetBackColor(AState: integer; var Color :  TColor) : boolean;
begin
  result := true;
  with FFontManager do
  begin
    if (AState >= 0) and (AState < Count) then
      Color := TMemoAttributes(Items[AState]).BkColor
    else
    begin
      result := AState <> tokUrl;
      if result then
      if Memo <> nil then
        Color := Memo.Color
      else
        Color := -1;
    end;    
  end;
end;

{------------------------------------------------------------------}

function TAttributeParser.GetFont(AState: integer): TFont;
begin
  with FFontManager do
    if (AState >= 0) and (AState < Count) then
      result := TMemoAttributes(Items[AState]).Font
    else
    if (Memo <> nil) and (AState <> tokUrl) then
      result := Memo.Font
    else
      result := nil;
end;

{------------------------------------------------------------------}

function  TAttributeParser.GetAttr(Point : TPoint) : byte;
begin
  if Memo <> nil then
    result := TMSource(Memo.GetSource).GetAttr(Point)
  else
    result := 0;
end;

{------------------------------------------------------------------}

function TAttributeParser.Memo : TCustomDCMemo;
begin
  result := TCustomDCMemo(Owner);
end;

{------------------------------------------------------------------}

function TAttributeParser.GetStringItem(LinePos : integer) : TStringItem;
begin
  if (Memo <> nil) then
    with TMSource(Memo.GetSource) do
      result := StringItem[LinePos]
  else
    result := nil;
end;

{------------------------------------------------------------------}

function TAttributeParser.ColorString(const StrData: string; InitState: integer;
             var AColorData: string): Integer;
var
  Item : TStringItem;
begin
  Item := GetStringItem(FLinePos);
  if Item <> nil then
    AColorData := Item.ColorData;
  result := InitState;
end;

{------------------------------------------------------------------}

procedure TAttributeParser.GetAttribute(APoint : TPoint; Attribute : TMemoAttributes);
begin
  Attribute.SafeAssign(GetAttrFromIndex(GetAttr(APoint)));
end;

{------------------------------------------------------------------}

function  TAttributeParser.StoreColorData : boolean;
begin
  result := not FInClearStyles;
end;

{------------------------------------------------------------------}

procedure TAttributeParser.PrepareColorData(LinePos : integer; const s : string ; var ColorData : string);
begin
  if ColorData = '' then
  begin
    SetLength(ColorData, length(s));
    if ColorData <> '' then
      FillChar(ColorData[1], length(s), #0);
  end
  else
    if s <> '' then
      SetLength(ColorData, length(s));
end;

{------------------------------------------------------------------}

function TAttributeParser.IndexOfEx(Attr : TMemoAttributes) : integer;
begin
  with FCachList do
    if FCachList.Find(Attr, result) then
      result := TMemoAttributes(Items[result]).FData
    else
      result := -1;
end;

{------------------------------------------------------------------}

function TAttributeParser.AddNewAttribute(Attr : TMemoAttributes) : integer;
var
  Attribute : TMemoAttributes;
begin
  with FFontManager do
  begin
    result := IndexOfEx(Attr);
    if result < 0 then
    begin
      if Count <= 255 then
      begin
        if Count = tokUrl then
        begin
          Attribute := TMemoAttributes.Create(nil);
          if (Memo <> nil) and (Memo.TextStyles.Count > tokUrl) then
            with Memo.TextStyles[tokUrl] do
            begin
              Attribute.BkColor := Color;
              Attribute.SafeAssign(Font);
            end;
          Add(Attribute);
        end;
        Attribute := TMemoAttributes.Create(nil);
        Attribute.SafeAssign(Attr);
        result := Add(Attribute);
        AddToCachList(Attribute, result);
        if FEmptyList <> nil then
          FEmptyList.Remove(Pointer(result));
      end
      else
        if FResetOnOverFlow or (Memo = nil) or (not Memo.AllowUndo) then
        begin
          if (FEmptyList <> nil) and (FEmptyList.Count = 0) then
          begin
            FEmptyList.Free;
            FEmptyList := nil;
          end;
          if FEmptyList = nil then
            FEmptyList := CreateEmptyList;
          if FEmptyList.Count > 0 then
          begin
            result := byte(FEmptyList[0]);
            TMemoAttributes(Items[result]).SafeAssign(Attr);
            AddToCachList(Items[result], result);
            FEmptyList.Delete(0);
          end;
        end;
    end;
  end;
  if result < 0 then
    result := 0;
end;

{------------------------------------------------------------------}

function  TAttributeParser.CreateEmptyList : TList;
var
  i    : integer;
  j    : integer;
  s    : string;
  arr  : array[0..255] of boolean;
  Item : TStringItem;
begin
  result := TList.Create;
  if Memo <> nil then
    with Memo, TMSource(GetSource) do
    begin
      ClearUndoBuffer;
      fillchar(arr, 256, 0);
      for i := 0 to Strings.Count - 1 do
      begin
        Item := StringItem[i];
        if Item <> nil then
          s := Item.ColorData;
        for j := 1 to length(s) do
          arr[byte(s[j])] := true;
      end;
      arr[tokUrl] := true;
      for i := 1 to 255 do
        if not arr[i] then
          result.Add(Pointer(i));
    end;
end;

{------------------------------------------------------------------}

function  TAttributeParser.GetPos(const s : string; Index : integer) : integer;
begin
  result := Index;
  if (result <= 1) or (result = MaxInt) then
    exit;
  if Memo <> nil then
    TMSource(Memo.GetSource).ChangeTabIndex(s, result);
end;

{------------------------------------------------------------------}

function TAttributeParser.GetAttrFromIndex(Index : integer) : TMemoAttributes;
begin
  with FFontManager do
  begin
    if (Index >= 0) and (Index < Count) then
      result := Items[Index]
    else
    if Count > 0 then
      result := Items[0]
    else
    if Memo <> nil then
      result := Memo.FSelAttributes
    else
      result := nil;
  end;
end;

{------------------------------------------------------------------}

procedure TAttributeParser.GetStrAttribute(LinePos, Left, Right : integer; Index : byte;
              var ConsistentAttrs : TConsistentAttrs);
var
  i    : integer;
  Item : TStringItem;
  Attr : TMemoAttributes;
begin
  Item := GetStringItem(LinePos);
  if Item <> nil then
    with Item do
    begin
      Left := GetPos(StrData, Left);
      Right := GetPos(StrData, right);
      if ColorData = '' then
        exit;
      Left := min(Left, Length(ColorData));
      Right := min(Right, Length(ColorData));
      for i := Left to Right do
        if byte(ColorData[i]) <> Index then
          with GetAttrFromIndex(Index) do
          begin
            Attr := GetAttrFromIndex(byte(ColorData[i]));
            if Attr.CharSet <> CharSet then
              exclude(ConsistentAttrs, csCharSet);
            if Attr.Color <> Color then
              exclude(ConsistentAttrs, csColor);
            if Attr.BkColor <> BkColor then
              exclude(ConsistentAttrs, csBkColor);
            if Attr.Name <> Name then
              exclude(ConsistentAttrs, csFace);
            if Attr.Pitch <> Pitch then
              exclude(ConsistentAttrs, csPitch);
            if Attr.Size <> Size then
              exclude(ConsistentAttrs, csSize);
            if Attr.Style <> Style then
            begin
              Exclude(ConsistentAttrs, csStyle);
              if not EqualFontStyles(Attr.Style, Style, fsBold) then
                Exclude(ConsistentAttrs, csBold);
              if not EqualFontStyles(Attr.Style, Style, fsItalic) then
                Exclude(ConsistentAttrs, csItalic);
              if not EqualFontStyles(Attr.Style, Style, fsUnderLine) then
                Exclude(ConsistentAttrs, csUnderLine);
              if not EqualFontStyles(Attr.Style, Style, fsStrikeOut) then
                Exclude(ConsistentAttrs, csStrikeOut);
            end;
         end;
    end
end;

{------------------------------------------------------------------}

procedure TAttributeParser.SetStrAttribute(LinePos, Left, Right : integer; Attribute : TMemoAttributes);
var
  s     : string;
  fdata : string;
  Item  : TStringItem;

  {---------------------------------------------------}

  procedure _Change(const AString : string);
  begin
    TMSource(Memo.GetSource).ColorDataChanged(AString, LinePos, Left);
  end;

  {---------------------------------------------------}

  procedure _SetStlye(var Styles : TFontStyles; Style : TFontStyle; AInclude : boolean);
  begin
    if AInclude then
      include(Styles, Style)
    else
      exclude(Styles, Style);
  end;

  {---------------------------------------------------}

  function _AddNewAttr(Attr : TMemoAttributes) : integer;
  var
    _Attr : TMemoAttributes;
  begin
    _Attr := TMemoAttributes.Create(nil);
    inc(_Attr.FUpdateCount);
    try
      _Attr.Assign(Attr);
      with Attribute do
      begin
        if csColor in FState then
          _Attr.Color := Color;
        if csBkColor in FState then
          _Attr.BkColor := BkColor;
        if csFace in FState then
          _Attr.Name := Name;
        if csSize in FState then
          _Attr.Size := Size;
        if csCharSet in FState then
          _Attr.CharSet := CharSet;
        if csPitch in FState then
          _Attr.Pitch := Pitch;
        if csStyle in FState then
        begin
          _SetStlye(_Attr.FStyle, fsBold, csBold in FState);
          _SetStlye(_Attr.FStyle, fsItalic, csItalic in FState);
          _SetStlye(_Attr.FStyle, fsUnderLine, csUnderLine in FState);
          _SetStlye(_Attr.FStyle, fsStrikeOut, csStrikeOut in FState);
        end;
      end;
      result := AddNewAttribute(_Attr);
    finally
      _Attr.Free;
    end;
  end;

  {---------------------------------------------------}

  procedure ChangeAttribute(var s : string);
  var
    i  : integer;
    P  : integer;
    ch : char;
  begin
    P := 1;
    ch := s[1];
    for i := 1 to length(s) do
      if s[i] <> ch then
      begin
        FillChar(s[P], i - P, _AddNewAttr(GetAttrFromIndex(byte(ch))));
        P := i;
        ch := s[P];
      end;
      FillChar(s[P], length(s) - P + 1, _AddNewAttr(GetAttrFromIndex(byte(ch))));
  end;

  {---------------------------------------------------}

begin
  Item := GetStringItem(LinePos);
  if Item <> nil then
    with Item do
    begin
      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
      begin
        s := Memo.Lines[LinePos];
        Left := _CharToByte(s, Left);
        if Right < MaxInt then
          Right := _CharToByte(s, Right + 1) - 1;
      end;
      {$ENDIF}
      Left := GetPos(StrData, Left);
      Right := GetPos(StrData, Right);

      s := ColorData;
      Right := min(Right, Length(s));

      if (s = '') then
      begin
        ColorData := char(AddNewAttribute(Attribute));
        _Change(#0);
      end
      else
        if (Right >= Left) and (Left <= length(s)) then
        begin
          fdata := Copy(s, Left, Right - Left + 1);
          if (fdata <> '') then
          begin
            _Change(fdata);
            ChangeAttribute(fdata);
            Move(fdata[1], s[Left], length(fdata));
            Item.ColorData := s;
          end;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TAttributeParser.GetAttributes(ARect : TRect; SelectionType : TSelectionType; Attribute : TMemoAttributes; var ConsistentAttrs : TConsistentAttrs );
var
  i     : integer;
  Index : integer;
begin
  with Attribute do
    if FMemo <> nil then
    begin
      with ARect do
      begin
        Index := GetAttr(TopLeft);
        case SelectionType of
          stStreamSel:
            begin
              if Top = Bottom
              then
                GetStrAttribute(Top, Left + 1, Right, Index, ConsistentAttrs)
              else
                for i := Top to Bottom do
                begin
                  if i = Top then
                    GetStrAttribute(i, Left + 1, MaxInt, Index, ConsistentAttrs)
                  else
                    if i = Bottom then
                      GetStrAttribute(i, 1, Right, Index, ConsistentAttrs)
                    else
                      GetStrAttribute(i, 1, MaxInt, Index, ConsistentAttrs);
                end;
            end;
          stBlockSel:
            for i := Top to Bottom do
              GetStrAttribute(i, Left + 1, Right + 1, Index, ConsistentAttrs);
        end;
      end;
    end;
end;

{------------------------------------------------------------------}


procedure TAttributeParser.SetAttribute(ARect : TRect; SelectionType : TSelectionType; Attribute : TMemoAttributes);
var
  //Index : integer;
  i     : integer;
begin
  if Memo = nil then
    exit;
//  Index := AddNewAttribute(Attribute);
  with ARect do
    case SelectionType of
      stStreamSel:
        begin
          if Top = Bottom
          then
            SetStrAttribute(Top, Left + 1, Right, Attribute)
          else
            for i := Top to Bottom do
            begin
              if i = Top then
                SetStrAttribute(i, Left + 1, MaxInt, Attribute)
              else
                if i = Bottom then
                  SetStrAttribute(i, 1, Right, Attribute)
                else
                  SetStrAttribute(i, 1, MaxInt, Attribute);
            end;
        end;
      stBlockSel:
        for i := Top to Bottom do
        begin
          if (Memo.Lines[i] = '') and (Left > 0) then
            continue;
          SetStrAttribute(i, Left + 1, Right + 1, Attribute);
        end;
      else
        TMSource(Memo.GetSource).DefaultAttribute := AddNewAttribute(Attribute);
    end;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.BeginUpdate;
begin
  inc(FUpdateCount);
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.EndUpdate;
begin
  dec(FUpdateCount);
  if FUpdateCount <= 0 then
    Update;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.Update;
var
  i : integer;
begin
  if FUpdateCount > 0 then
    exit;
  if (FMemo <> nil) and (FMemo.SyntaxParser is TAttributeParser) then
    with FMemo, TMSource(GetSource) do
    begin
      TAttributeParser(FMemo.SyntaxParser).SetAttribute(SelectionRect, SelectionType, Self);
      if (SelectionType <> stNotSelected) then
      begin
        BeginUpdate(acLineChanged);
        try
          with SelectionRect do
          begin
            for i := Top to Bottom do
            begin
              if StringItem[i] <> nil then
                StringItem[i].ItemState := StringItem[i].ItemState - [isWasParsed];
              UpdateString(i);
            end;
          end;
        finally
          EndUpdate;
        end;
      end;
      if not InImport and (UpdateCount <= 0) then
      begin
        FMemo.UpdateMaxLine(true);
        UpdateCaretMode;
      end;
      SelAttributesUpdated;
    end;
  FState := [];
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.AssignMemoFont;
begin
  if FMemo <> nil then
  begin
    inc(FUpdateCount);
    try
      Assign(FMemo.Font);
      FBkColor := FMemo.Color;
    finally
      dec(FUpdateCount);
      FState := [];
    end;
  end;
end;

{------------------------------------------------------------------}

constructor TMemoAttributes.Create(AOwner : TCustomDCMemo);
begin
  inherited Create;
  FMemo := AOwner;
  FFont := TFont.Create;
  AssignMemoFont;
end;

{------------------------------------------------------------------}

destructor TMemoAttributes.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SafeAssign(Source : TPersistent);
var
  OldState : TConsistentAttrs;
begin
  inc(FUpdateCount);
  OldState := FState;
  try
    Assign(Source);
  finally
    FState := OldState;
    dec(FUpdateCount);
  end;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.Assign(Source : TPersistent);
begin
  if Source is TFont then
    with TFont(Source) do
    begin
      Self.BeginUpdate;
      try
        Self.Color := Color;
        Self.Name := Name;
        Self.Charset := Charset;
        Self.Style := Style;
        Self.Size := Size;
        Self.Pitch := Pitch;
      finally
        Self.EndUpdate;
      end;
    end
  else
  if Source is TMemoAttributes then
    with TMemoAttributes(Source) do
    begin
      Self.BeginUpdate;
      try
        Self.Color := Color;
        Self.BkColor := BkColor;
        Self.Name := Name;
        Self.Charset := Charset;
        Self.Size := Size;
        Self.Style := Style;
        Self.Pitch := Pitch;
      finally
        Self.EndUpdate;
      end;

    end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.CheckFont;
begin
  FFont.Charset := Charset;
  FFont.Color   := Color;
  FFont.Name    := Name;
  FFont.Pitch   := Pitch;
  FFont.Size    := Size;
  FFont.Style   := Style;
end;

{------------------------------------------------------------------}

function TMemoAttributes.EqualFontStyles(A, B : TFontStyles; Style : TFontStyle) : boolean;
begin
  result := ((Style in A) and (Style in B)) or (not (Style in A) and not (Style in B));
end;

{------------------------------------------------------------------}

function  TMemoAttributes.GetFont : TFont;
begin
  CheckFont;
  result := FFont;
end;

{------------------------------------------------------------------}

function  TMemoAttributes.GetAllAttributes(CheckStyle : boolean) : TConsistentAttrs;
begin
  result := [csColor, csBkColor, csFace, csCharSet, csPitch,
           csSize, csBold, csItalic, csStrikeOut, csUnderline, csStyle];
  if CheckStyle then
  begin
    if not (fsBold in FStyle) then
      exclude(result, csBold);
    if not (fsItalic in FStyle) then
      exclude(result, csItalic);
    if not (fsUnderLine in FStyle) then
      exclude(result, csUnderLine);
    if not (fsStrikeOut in FStyle) then
      exclude(result, csStrikeOut);
  end;
end;

{------------------------------------------------------------------}

function  TMemoAttributes.GetConsistentAttrs : TConsistentAttrs;
begin
  if not FUseStored then
  begin
    FStoredAttrs := GetAllAttributes(false);
    if (FMemo <> nil) and (FMemo.SyntaxParser is TAttributeParser) then
      with FMemo, GetSource do
        TAttributeParser(SyntaxParser).GetAttributes(SelectionRect, SelectionType, Self, FStoredAttrs);

    FUseStored := true;
  end;
  result := FStoredAttrs;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SetCharset(Value : TFontCharset);
begin
  if not ((FCharSet = Value) and (csCharSet in GetConsistentAttrs)) then
  begin
    FCharSet := Value;
    include(FState, csCharSet);
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SetColor(Value : TColor);
begin
  if not ((FColor = Value) and (csColor in GetConsistentAttrs)) then
  begin
    FColor := Value;
    include(FState, csColor);
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SetBkColor(Value : TColor);
begin
  if not ((FBkColor = Value) and (csBkColor in GetConsistentAttrs)) then
  begin
    FBkColor := Value;
    include(FState, csBkColor);
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SetName(Value : TFontName);
begin
  if not ((FName = Value) and (csFace in GetConsistentAttrs)) then
  begin
    FName := Value;
    include(FState, csFace);
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SetPitch(Value : TFontPitch);
begin
  if not ((FPitch = Value) and (csPitch in GetConsistentAttrs)) then
  begin
    FPitch := Value;
    include(FState, csPitch);
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SetSize(Value : Integer);
begin
  if not ((FSize = Value) and (csSize in GetConsistentAttrs)) then
  begin
    FSize := Value;
    include(FState, csSize);
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SetStyle(Value : TFontStyles);
begin
  if not ((FStyle = Value) and (csStyle in GetConsistentAttrs)) then
  begin
    FStyle := Value;
    include(FState, csStyle);
    if fsBold in Value then
      Include(FState, csBold);
    if fsItalic in Value then
      Include(FState, csItalic);
    if fsUnderline in Value then
      Include(FState, csUnderline);
    if fsStrikeOut in Value then
      Include(FState, csStrikeOut);
    Update;
  end;
end;

{------------------------------------------------------------------}

function  TMemoAttributes.GetResetOnOverFlow : boolean;
begin
  result := (FMemo <> nil) and (FMemo.SyntaxParser is TAttributeParser) and
            TAttributeParser(FMemo.SyntaxParser).ResetOnOverFlow
end;

{------------------------------------------------------------------}

procedure TMemoAttributes.SetResetOnOverFlow(Value : boolean);
begin
  if (FMemo <> nil) and (FMemo.SyntaxParser is TAttributeParser) then
    TAttributeParser(FMemo.SyntaxParser).ResetOnOverFlow := Value;
end;

{------------------------------------------------------------------}

initialization
  RegisterKeyboardInitProc(TCustomDCMemo, ResStr(SDefault), InitDefaultKeyboard);
  RegisterKeyboardInitProc(TCustomDCMemo, SKBDClassic, InitClassicKeyboard);
  RegisterKeyboardInitProc(TCustomDCMemo, SKBDBrief, InitBriefKeyboard);
  RegisterKeyboardInitProc(TCustomDCMemo, SKBDEpsilon, InitEpsilonKeyboard);
  RegisterKeyboardInitProc(TCustomDCMemo, SKBDVisualStudio, InitVisualStudioKeyboard);
{$IFNDEF CLX}
  Screen.Cursors[crMemoHandPt]:= LoadCursor(HInstance, 'MEMOHANDPT'); //don't resource
  CF_RTF := RegisterClipboardFormat(RichEdit.CF_RTF);
{$ELSE}
  Screen.Cursors[crMemoHandPt]:= Screen.Cursors[crHandPoint];
{$IFNDEF LINUX}
  QWindowsMime_registerMimeType(PChar(CF_RTF));
{$ENDIF}
{$ENDIF}
finalization
  FreeObject(fMemoList,fMemoList);
  FreeObject(fEnvOptObjectList,fEnvOptObjectList);
end.

