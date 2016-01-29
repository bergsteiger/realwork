{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcstring;
{$I dc.inc}

interface

uses
  {$IFNDEF CLX}
  Windows, Messages, clipbrd, forms, controls, dialogs,
  {$IFDEF D3} activex {$ELSE} ole2 {$ENDIF},
  {$ELSE}
  Types, Qt, QForms, QControls, QDialogs, QClipBrd,
  {$ENDIF}
  dcsystem, dccommon,Classes, SysUtils, Consts, dcconsts, dcdreamlib, dcregexpr;

{-------------------------------------------------------------}

const

// ------------------------ memo operation codes -----------------

  {You can use them with BeginUpdate procedure }
  acNavigate            = 2;
  acJoinLines           = 3;
  acBreakLine           = 4;
  acInsert              = 5;
  acDeleteRight         = 6;
  acDeleteCharLeft      = 8;
  acDeleteLine          = 9;
  acDeleteToLineBegin   = 10;
  acMarkBlockBegin      = 11;
  acMarkBlockEnd        = 12;
  acSetSelType          = 13;
  acSetBlockAsLineBlock = 14;
  acSetBlockAsColBlock  = 15;
  acUnivMark            = 16;
  acSetSelRect          = 17;
  acSelectAll           = 18;
  acMarkLine            = 19;
  acCutBlock            = 20;
  acPasteBlock          = 21;
  acDeleteBlock         = 22;
  acMoveBlock           = 23;
  acUppercaseLine       = 24;
  acUpperCaseBlock      = 25;
  acLowerCaseBlock      = 26;
  acToggleBlockCase     = 27;
  acLowerCaseLine       = 28;
  acToggleLineCase      = 29;
  acMarkWord            = 30;
  acSetSelection        = 31;
  acDeleteWord          = 32;
  acDeleteWordRight     = 33;
  acDeleteWordLeft      = 34;
  acLowerCaseWord       = 35;
  acUpperCaseWord       = 36;
  acToggleWordCase      = 37;
  acChangeBlockTo       = 38;
  acInsertString        = 39;
  acPressEnter          = 40;
  acInsState            = 41;
  acMouseDown           = 42;
  acMouseMark           = 43;
  acCancelDragging      = 44;
  acSetBookmark         = 45;
  acClearBookmark       = 46;
  acResetPositions      = 47;
  acLoadFromStrings     = 48;
  acChangeModified      = 49;
  acRegisterNotifier    = 50;
  acCodeDesigner        = 51;
  acPressTab            = 52;
  acSetImageBit         = 53;
  acReplace             = 54;
  acFind                = 55;
  acObjNameChanged      = 56;
  acParserChanged       = 57;
  acClear               = 58;
  acPutString           = 59;
  acStringsUpdate       = 60;
  acLoaded              = 61;
  acCapitalizeWord      = 62;
  acCapitalizeLine      = 63;
  acCapitalizeBlock     = 64;
  acIndentBlock         = 65;
  acOutdentBlock        = 66;
  acQuoteBlock          = 67;
  acChangeLineColor     = 68;
  acDuplicateBlock      = 69;
  acReadonlyChanged     = 70;
  acLineChanged         = 71;
  acImportRtf           = 72;
  acItemStateChanged    = 73;

type
  TTemplateRec = record
    AName : string;
    ADesc : string;
    ACode : string;
  end;

  TObjProc = procedure of object;
  TClipFormat =(cfStreamSel, cfBlockSel);
  TOutFormatType = (ofWindows, ofMac, ofUnix);
  TStrProc = procedure(var s : string) of object;

  TOnAllowUpdate = procedure(Sender : TObject; var AllowX, AllowY : boolean) of object;

  TPosition = class(TCollectionItem)
  private
    FOnAllowUpdate : TOnAllowUpdate;
  public
    LinePos : integer;
    CharPos : integer;
    property OnAllowUpdate : TOnAllowUpdate read FOnAllowUpdate write FOnAllowUpdate;
    constructor Create(ACollection : TCollection); override;
    procedure SetPosition(AChar, ALine : integer);
    procedure Assign(Source : TPersistent); override;
    function  SameAs(P:TPosition) : boolean;
  end;

  TStringsOperation = (soNavigate, soInsert, soBreakLine, soJoinLines, soDeleteRight, soUpdateColorData);

  PUndoRecord = ^TUndoRecord;
  TUndoRecord = packed record
    FOperation   : TStringsOperation;
    FDeltaLine   : integer;  // operation count for soBreakLine and soJoinLines cases (no not used for this case)
                            // inserted text length for soInsert case
    FDeltaChar   : integer;
    FString      : string;
    FColorData   : string;
    FirstRecord  : boolean;
    FOpCode      : byte;
    FInUndoBlock : boolean;
    //FPrevItem    : PUndoRecord;
  end;

  TSearchDirection = (sdForward, sdBackward);
  TSearchScope = (ssGlobal, ssSelectedText);
  TSearchOrigin = (soFromCursor, soEntireScope);
  TSearchWhere = (swProjectFiles, swOpenFiles, swDirectories, swOther);

  TSearchOptions = class(TOptionExt)
  private
    FCaseSensitive   : boolean;
    FWholeWordsOnly  : boolean;
    FRegularExpr     : boolean;
    FDirection       : TSearchDirection;
    FScope           : TSearchScope;
    FOrigin          : TSearchOrigin;
    FPromptOnReplace : boolean;
    FTextToFind      : string;
    FReplaceWith     : string;
    FFirstSearch     : boolean;
    FinReplace       : boolean;
    FReplaceAll      : boolean;
    FShowNotFound    : boolean;
    FWhere           : TSearchWhere;
    FFileMask        : string;
    FIncludeSubDirs  : Boolean;
    function GetDisplayTextToFind : string;
  public
    constructor Create; override;
    destructor Destroy; override;
    function  GetKey : string; override;
    property DisplayTextToFind : string read GetDisplayTextToFind;
  published
    property ShowNotFound : boolean read FShowNotFound write FShowNotFound;
    property ReplaceAll : boolean read FReplaceAll write FReplaceAll;
    property InReplace : boolean read FInReplace write FInReplace;
    property FirstSearch : boolean read FFirstSearch write FFirstSearch;
    property TextToFind : string read FTextToFind write FTextToFind;
    property ReplaceWith : string read FReplaceWith write FReplaceWith;
    property PromptOnReplace : boolean read FPromptOnReplace write FPromptOnReplace;
    property CaseSensitive : boolean read FCaseSensitive write FCaseSensitive;
    property WholeWordsOnly : boolean read FWholeWordsOnly write FWholeWordsOnly;
    property RegularExpr : boolean read FRegularExpr write FRegularExpr;
    property Direction : TSearchDirection read FDirection write FDirection;
    property Scope : TSearchScope read FScope write FScope;
    property Origin : TSearchOrigin read FOrigin write FOrigin;
    property Where : TSearchWhere read FWhere write FWhere;
    property FileMask : string read FFileMask write FFileMask;
    property IncludeSubDirs : Boolean read FIncludeSubDirs write FIncludeSubDirs;
  end;

  TMemoState = (msPositionChanged, msEdited, msUndo, msBlockChanged, msInsState,msCountChanged, msModifiedChanged,
                msFoundRectChanged, msObjNameChanged, msNeedInvalidate, msParserChanged, msReadOnlyChanged);

  TMemoStates = set of TMemoState;

  TStringsOption = (soBackUnindents, soGroupUndo, soBeyondFileEnd, soForceCutCopy, soAutoIndent, soSmartTab,
                    soFindTextAtCursor, soCreateBackups, soPersistentBlocks, soOverwriteBlocks, soLimitEOL,
                    soUseTabCharacter, soCursorOnTabs, soOptimalFill, soSelectFoundText, soExcludeReadOnlyLines,
                    soCursorAlwaysOnTabs, soUsePrevIndent, soRetainColumn);

  TBlockOption = (bkStreamSel, bkBlockSel, bkNone, bkBoth);

  TStringsOptions = set of TStringsOption;

  TSelectionType = (stNotSelected, stStreamSel, stBlockSel);

  TWordSelectionType = (wsWordOnly, wsWordWithSpace, wsUntilNextWord);

  TBookMarkNumber = 1..255;

  TStringItemState = (isWasParsed, isReadOnly, isHidden, isExpanded, isCollapsed);
  TStringItemStates = set of TStringItemState;

  {$IFDEF LONGIMAGES}
  TImageBit = integer
  {$ELSE}
  TImageBit = word;
  {$ENDIF}

  TCustomMemoSource = class;
  TStringItem = class(TObject)
  private
    FString      : string;
    FOldString   : string;
    FObject      : TObject;
    FColorData   : string;
    FParserState : integer;
    FBeforeState : integer;
    FImageBits   : TImageBit;
    FItemState   : TStringItemStates;
    FTextStyle   : byte;
    FLineHeight  : integer;
    FLineWidth   : integer;
    FBaseLine    : integer;
  protected
  public
    property StrData : string read FString write FString;
    property ObjData : TObject read FObject write FObject;
    property ColorData : string read FColorData write FColorData;
    property ParserState : integer read FParserState;
    property BeforeState : integer read FBeforeState;
    property ImageBits : TImageBit read FImageBits;
    property ItemState : TStringItemStates read FItemState write FItemState;
    property TextStyle : byte read FTextStyle write FTextStyle;
    property LineHeight : integer read FLineHeight write FLineHeight; // don't use
    property LineWidth : integer read FLineWidth write FLineWidth;    // don't use
    property BaseLine : integer read FBaseLine write FBaseLine;       // don't use
    property OldString : string read FOldString write FOldString;
  end;

  TStringItemClass = class of TStringItem;

  TMemoCodeTemplate = class(TDCNamedItem)
  private
    FDescription : string;
    FCode        : TStrings;
    procedure SetCode(Value : TStrings);
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;

  published
    property Name;
    property Description : string read FDescription write FDescription;
    property Code : TStrings read FCode write SetCode;
  end;

  TMemoCodeTemplates = class(TDCNamedItems)
  private
    function  GetItem(Index : integer) : TMemoCodeTemplate;
    procedure SetItem(Index : integer; Value : TMemoCodeTemplate);
  protected
    procedure FilterNames(CodeTempl : TList; const S : string; var NameFound : boolean);
  public
    function  ConvertCodeTemplate(CodeTemplate : TMemoCodeTemplate) : string;
    function  ConvertCodeTemplates(Strings : TStrings; const S : string) : integer;
    property  Items[Index : integer ]: TMemoCodeTemplate read GetItem write SetItem;
  end;

  TMemoPositionList = class(TSortedListEx)
  public
    function  Compare(Item1, Item2 : Pointer) : integer; override;
    procedure Clear;
  end;

  PBookMarkRec = ^TBookMarkRec;
  TBookMarkRec = record
    X        : integer;
    Y        : integer;
    BookMark : integer;
  end;

  TMemoBookMarkList = class(TMemoPositionList)
  private
    procedure SetBookMark(Point : TPoint; Number : integer);
    function  GetBookMarkForLine(Line : integer) : integer;
    function  GetBookmarkFromRange(Line, FromChar, ToChar : integer) : integer;
    procedure GetBookmarksFromRange(Line, FromChar, ToChar : integer; List : TList);
    function  ClearBookMark(Number : integer; var Index : integer) : boolean;
    function  FindBookMark(Number : integer; var Pt : TBookMarkRec) : boolean;
    procedure LineChanged(FromLine, FromChar, Delta : integer);
    procedure CharChanged(FromLine, FromChar, Delta : integer);
  public
    procedure Sort;
    function  Compare(Item1, Item2 : Pointer) : integer; override;
  end;

  TVisibleLinesList = class(TSortedListEx)
  private
    FCheckIndex : boolean;
    procedure LineChanged(FromLine, Delta : integer);
    procedure SetLineVisible(Line : integer;  Value : boolean);
    function  GetLineVisible(Line : integer) : boolean;
    function  RealToVisibleIndex(Index : integer) : integer;
    function  VisibleToRealIndex(Index : integer) : integer;
  public
    function  FindNear(Item : integer; CheckIndex, Exact : boolean) : integer;
    function  Compare(Item1, Item2 : Pointer) : integer; override;
    property  LineVisible[Index : integer] : boolean read GetLineVisible write SetLineVisible;
  end;

  TUndoList = class(TRecordList)
  private
    FRecord : TUndoRecord;
  public
    procedure DeleteLast;
    procedure Clear;
    constructor CreateNew;
    function  AddUndoRecord : PUndoRecord;
    procedure ClearToIndex(Index : integer);
  end;

  TCollapseState = (csCollapsed, csExpanded, csNone);

  TGetBackpNameEvent = procedure(Sender : TObject; const FileName : string; var BackFileName : string) of object;
  TGetPositionEvent = procedure(Sender : TObject; var DeltaLine, DeltaChar : integer) of object;
  TGetSelectionTypeEvent = procedure(Sender : TObject; var SelType : TSelectionType) of object;
  TSearchExceptionEvent = procedure(Sender : TObject ; const Error : string; var Handled : boolean) of object;
  TStringsEvent = procedure(Sender : TObject; Strings : TStrings) of object;
  TCreateDialogEvent = procedure(Sender : TObject; Dialog : TCustomForm) of object;
  TClipboardEvent = TStringsEvent;
  TOnGetLineHeightEvent =  procedure(Sender : TObject; Index : integer; Item : TStringItem) of object;
  TAfterParseEvent = procedure(Sender : TObject; Index : integer; var S, ColorS : string) of object;
  TBeforeFindReplaceEvent = procedure(Sender : TObject; InReplace : boolean) of object;

  TCustomMemoSource=class(TComponent)
  private
    FTempHighlightStr     : integer;
    FTempHighlightIdx     : integer;
    FSkipClearSelection   : integer;
    OCharPos              : integer;
    OLinePos              : integer;
    FSpacesInTab          : integer;
    fUseGlobalOptions     : boolean;
    FChangedLine          : integer;
    FActiveMemo           : TWinControl;
    FSyntaxParser         : TSimpleParser;
    FOldName              : string;
    FObjectName           : string;
    OFoundRect            : TRect;
    FFoundRect            : TRect;
    FNotParsedStr         : integer;
    FSelStrings           : TStrings;
    OModified             : boolean;
    _OSelection           : TSelectionType;
    _OTopLeft             : TPosition;
    _OBottomRight         : TPosition;
    _Position             : TPosition;
    FSafeUpdate           : boolean;
    FTabStopList          : TList;
    FTabStops             : string;
    FModified             : boolean;
    FSaveModified         : boolean;
    FSaveModifiedIdx      : integer;
    FROnly                : boolean;
    FOldCount             : integer;
    FDelimeters           : string;
    FDelimSet             : TCharSet;
    FOSelectionType       : TSelectionType;
    FSelectionType        : TSelectionType;
    FCode                 : integer;
    FFirstRecord          : boolean;
    FNotifiers            : TNotifierList;
    FOptions              : TStringsOptions;
    FStrings              : TStrings;
    FExternalStrings      : TStrings;
    FUpdateCount          : integer;
    FPosition             : TPosition;
    FPositions            : TCollection;
    FTopLeft              : TPosition;
    FBottomRight          : TPosition; // selection coordinates
    FoTopLeft             : TPosition;
    FoBottomRight         : TPosition; // old selection coordinates
    FAllowUndo            : boolean;
    FUndoLimit            : integer;
    FUndoList             : TUndoList;
    FRedoList             : TUndoList;
    FState                : TMemoStates;
    FFirstChanged         : integer;
    FLastChanged          : integer;
    FBlockIndent          : integer;
    FCodeTemplates        : TMemoCodeTemplates ;
    FTemplatesType        : string;
    FHighlightUrls        : boolean;
    FOnGetBackupName      : TGetBackpNameEvent;
    FOnCreateDialog       : TCreateDialogEvent;
    FOnGetSelectionType   : TGetSelectionTypeEvent;
    FOnSearchException    : TSearchExceptionEvent;
    FOnPasteFromClipboard : TClipboardEvent;
    FOnAfterParse         : TAfterParseEvent;

    FBookMarkList         : TMemoBookMarkList;
    FVisibleLinesList     : TVisibleLinesList;
    FGotoBookMark         : boolean;
    FNeedMaxLineUpdate    : boolean;
    FMaxLineLen           : integer;
    FMaxLineLenIdx        : integer;
    FQuickLoad            : boolean;
    FBlockUpdate          : boolean;
    FInBlock              : boolean;
    FReplacedCount        : integer;

    // word wrap
    FOnNavigate           : TGetPositionEvent;
    FOnGetLineHeight      : TOnGetLineHeightEvent;
    FOnBeforeFindReplace  : TBeforeFindReplaceEvent;

    FManualPosition       : boolean;
    FMemoGetIndent        : boolean;
    FBlockOption          : TBlockOption;
    FOutFormat            : TOutFormatType;
    FUndoBlockCount       : integer;
    FUseRedo              : boolean;
    FTabString            : string;
    FDefaultParserState   : integer;
    FLeaveSpacesAndTabs   : boolean;
    FInternalData         : string;
    FInsertedLen          : integer;
    FDefaultAttribute     : integer;
    FUseDefaultAttr       : boolean;
    FInImport             : boolean;
    FInColorUpdate        : boolean;

    FVersion              : TDCVersion;
    function  GetStringItem(Index : integer) : TStringItem;
    procedure UpdateGutterImg(Index : integer);
    function  GetLineTextStyle(Index : integer) : byte;
    procedure SetLineTextStyle(Index : integer; V : byte);
    function  GetLineReadOnly(Index : integer) : boolean;
    procedure SetLineReadOnly(Index : integer; Value : boolean);
    function  GetLineVisible(Index : integer) : boolean;
    procedure SetLineVisible(Index : integer; Value : boolean);
    function  GetCollapseState(Index : integer) : TCollapseState;
    procedure SetCollapseState(Index : integer; Value : TCollapseState);
    function  SetLineState(Index,  ToIndex : integer; Value : boolean; AState : TStringItemState) : boolean;
    procedure SetSyntaxParser(Value : TSimpleParser);
    procedure SetLines(Value : TStrings);
    procedure SetModified(V : boolean);
    procedure CheckModified(Value : boolean);
    procedure FSetBookMark(Index : integer; Num : byte);
    procedure SetSpacesInTab(V : integer);
    function  FGetBookmark(Index : integer) : byte;
    procedure ResetPositions;
    procedure DeleteLastEmptyLine;
    procedure SwapUndoRedoLists;
    function  ReadOnlyLine : boolean;
    function  ReadOnlyNextLine : boolean;
    procedure FUpperCaseStr(var S : string);
    procedure FCapitalizeStr(var S : string);
    procedure FIndentBlockStr(var S : string);
    procedure FOutDentBlockStr(var S : string);
    procedure FQuoteBlockStr(var S : string);
    procedure SetOverwrite(V : boolean);
    procedure AllowUpdate(Sender : TObject; var AllowX, AllowY : boolean);
    function  GetOverwrite : boolean;
    procedure SetDelimeters(const V : string);
    procedure FLowerCaseStr(var S : string);
    procedure FToggleStrCase(var S : string);
    function  ExtraTabDelta : integer;
    procedure SetTabStops(V : string);
    procedure PasteBlockFromStrings(F : TStrings; BlockSel : boolean);
    procedure PasteBlockFromStringsEx(F, CL : TStrings; BlockSel : boolean);
    function  GetStrCount : integer;
    function  GetUseGlobalOptions : boolean;
    procedure SetSelectionType(V : TSelectionType);
    function  IsBlockEmpty(ASelType : TSelectionType) : boolean;
    function  GetSelectionRect : TRect;
    procedure SetSelectionRect(const Value : TRect);
    procedure SetFoundRect(const Value : TRect);
    function  AfterLastLine : boolean;
    procedure UpdatePositions(AOperation : TStringsOperation; StrLength : integer);

    //--- Undo support
    procedure ClearRedoBuffer;
    function  FindModifiedRecord(ACount : integer) : integer;
    function  CurrentUndoList : TUndoList;
    function  CurrentRedoList : TUndoList;
    procedure SetAllowUndo(Value : boolean);
    procedure SetUndoLimit(Value : integer);
    procedure CheckUndoLimit;
    function  StoreColorData : boolean;
    function  CreateNewUndoRecord(AOperation : TStringsOperation) : PUndoRecord;

    //--- Tab support
    function  GetVirtualTabStop(Index : integer) : integer;
    function  InsertWithTabs(Source, ColorSrc : string ; var Dest, ColorDest : string; Index : integer) : integer;
    function  GetTabDelta(CharPos, LinePos  : integer; direction : boolean; var delta : integer) : boolean;
    procedure CheckDeltaChar(LinePos, CharPos : integer; var Delta : integer);
    procedure CheckForTabs(Sender : TObject; var S : string);
    function  ChangeTabString(var s : string; Index : integer; var Count : integer) : integer;
    function  ChangeTabStringEx(var s : string; Index : integer; var Count : integer; ch : char) : integer;

    procedure DiscardTrailingTabs(WithUndo : boolean);
    function  GetSmartTabPos(i, OldPos, CurLine : integer) : integer;
    function  GetFirstNonSpaceChar(LinePos, CurChar : integer) : integer;


    function  GetCurChar : integer;
    function  GetCurLine : integer;
    function  GetSearchOptions : TSearchOptions;
    procedure SetSearchOptions(V : TSearchOptions);
    function  GetImageBit(Index, ImageIndex : integer) : boolean;
    procedure SetImageBit(Index, ImageIndex : integer; V : boolean);
    function  GetTextAtCursor : string;
    procedure SetOptions(V : TStringsOptions);
    procedure UpdateSavedPos;
    function  GetShortObjectName : string;
    procedure MoveLineProps(FromLine, ToLine : integer);
    procedure AssignLineProps(FromLine, ToLine : integer); 
    function  MoveBlockEx(DelOrigin : boolean) : boolean;
    procedure SetCodeTemplates(Value : TMemoCodeTemplates) ;
    procedure ReadBlockFromStreamEx(S : TStream; BlockSel : boolean);
    procedure SetTemplatesType(Value : string);
    procedure ParseUrl(LinePos : integer; const s: string; var ColorData : string);
    procedure SetHighLightUrls(Value : boolean);
    procedure SetBlockOption(Value : TBlockOption);
    procedure SetROnly(Value : boolean);
    procedure SetBlockIndent(Value : integer);
    procedure ReCalculateMaxLine;
    function  GetMaxLen(LinePos : integer) : integer;
    procedure MoveColorData(const Source : string; var Destination : string; LinePos, CharPos : integer);
    procedure CheckColorData(S : string; var Cs : string);
    procedure CheckStringItem(Item : TStringItem);
    procedure CheckCollapsed(Index : integer);
    procedure ExpandPrevLine(LinePos : integer);

  protected
    procedure DoLoadFromFile(Const AFileName : string); virtual;
    procedure DoSaveToFile(const AFileName : string); virtual;
    procedure SmartSearchOptions;
    function  InternalReplace : boolean;
    function  InternalFind(var Len : integer) : boolean;
    procedure WordBounds(X, Y : integer; var ALeft , ARight : integer; WordSelType : TWordSelectionType);
    function  GetStrItemClass : TStringItemClass; virtual;
    procedure GetStringsInsert(Index : integer; const S : string);
    procedure GetStringsDelete(Index : integer);
    procedure SetObjectName(const V : string); virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    function  MemoNotify(Sender : TObject;var Msg : TMessage) : boolean; virtual;
    function  GetReadOnly : boolean; virtual;
    procedure Loaded; override;
    procedure LoadGlobalOptions;
    procedure CheckSelectionType(var SelType : TSelectionType); virtual;
    function  GetStrings : TStrings; virtual;
    function  GetBackupName(const FileName : string) : string; virtual;
    function  GetNavigation(var DeltaLine, DeltaChar : integer) : TPoint;
    procedure GetLineHeight(Index : integer; Item : TStringItem);
    function  GetMemoIndent(Indent : integer) : integer;
    function  GetBookmarkFromRange(Line, FromChar, ToChar : integer) : integer;
    procedure GetBookmarksFromRange(Line, FromChar, ToChar : integer; List : TList);
    function  CreateReplaceDialog : TCustomForm; virtual;
    function  CreateSearchDialog : TCustomForm; virtual;
    function  CreateNotModalSearchDialog : TCustomForm; virtual;
    function  CheckNotModalSearchRepl(Index : integer) : boolean;
    function  HandleSearchException(const Error : string) : boolean; virtual;
    procedure PasteFromClipboard(Strings : TStrings); virtual;
    procedure ParserChanged;
    function  UpdateString(LinePos : integer) : boolean;
    procedure ParserOnChange(Sender : TObject; wParam, lParam : integer); virtual;
    function  IsSourceModified : boolean;
    procedure UpdateMaxLine(NeedUpdate : boolean);
    function  ParseStrings(FromIndex, ToIndex : integer; NeedParse : boolean) : integer;
    procedure ColorDataChanged(const S : string; LinePos, CharPos : integer);
    procedure ChangeTabIndex(s : string; var Index : integer);
    function  GetSpecialString(Index :integer; UseSpecialChars : boolean; SpaceChar, TabChar : char) : string;
    function  GetStoredColorData(Index : integer) : string;
    function  GetAttr(Point : TPoint) : byte;
    function  InsertEx(const S, ColorS : string) : integer;
    procedure SetUseGlobalOptions(val : boolean); virtual;

    procedure RestorePosition(P : TPosition);
    function  CopyPosition(P : TPosition) : TPosition;
    function  CopyCurrent : TPosition;
    procedure SelAttributesUpdated; virtual;
    function  FindWord(s : string; Pt : TPoint; WholeWord , Direction : boolean) : integer;
    procedure AfterParse(LinePos : integer; var S, ColorS : string); virtual;
    function  ChangeDeltaLine(ADeltaLine : integer) : integer;
    procedure UpdateChanged(MinChange, MaxChange : integer);
    procedure UpdateChangedLines(MinChange, MaxChange : integer);
    procedure SafeCheckModified(Value : boolean; WithUpdate : boolean);
    function  IsSyntaxParser : boolean; virtual;

    {$IFDEF DCMBCS}
    procedure DeleteRightEx(Number : integer);
    {$ENDIF}

    function  InDelimSet(const s : string; Index : integer) : boolean;
    procedure NotifyEvents(AFirstChanged, ALastChanged : integer); virtual;
    function  GetRealLineVisible(Index : integer) : boolean;
    function  GetTextAt(X, Y : integer) : string;
    function  GetOldPosition : TPoint;
    procedure BeforeFindReplace(InReplace : boolean); virtual;

    property  StringItem[Index : integer] : TStringItem read GetStringItem;
    property  OnNavigate : TGetPositionEvent read FOnNavigate write FOnNavigate;
    property  OnGetLineHeight : TOnGetLineHeightEvent read FOnGetLineHeight write FOnGetLineHeight;
    property  MemoGetIndent : boolean read FMemoGetIndent write FMemoGetIndent;
    property  ManualPosition : boolean read FManualPosition;

    property  NeedMaxLineUpdate : boolean read FNeedMaxLineUpdate;
    property  UndoList : TUndoList read FUndoList;
    property  RedoList : TUndoList read FRedoList;
    property  UseRedo : boolean read FUseRedo;
    property  OldCount : integer read FOldCount;
    property  DefaultParserState : integer read FDefaultParserState write FDefaultParserState;
    property  DefaultAttribute : integer read FDefaultAttribute write FDefaultAttribute;
    property  UseDefaultAttr : boolean read FUseDefaultAttr write FUseDefaultAttr;
    property  InImport : boolean read FInImport write FInImport;
    property  UpdateCount : integer read FUpdateCount;
    property  VisibleLinesList : TVisibleLinesList read FVisibleLinesList;
    property  SafeModified : boolean read FModified write CheckModified;
    property  BookMarkList : TMemoBookMarkList read FBookMarkList;
    property  ReplacedCount : integer read FReplacedCount;
    property  BookMarkJump : boolean read FGotoBookMark;
  public
    {$IFNDEF CLX}
    procedure LoadFromProp(Instance : TPersistent; const PropName : string);
    procedure SaveToProp(Instance : TPersistent; const PropName : string);
    {$ENDIF}
    function  CopyBlockToPos : boolean;
    procedure TempHighlightLine(Index : integer; StyleIndex : byte); virtual;
    procedure TempUnhighlightLine; virtual;

    procedure DoWithBlockStr(ACode : integer; StrAction : TStrProc; RestorePos : boolean);
    procedure DoWithBlock(ACode : integer; MarkProc, ActionProc : TObjProc; RestorePos : boolean);
    function  CheckOverwriteBlock:boolean;

    // low level strings handling methods
    procedure Navigate(ADeltaLine, ADeltaChar : integer); virtual;
    procedure BreakLine; virtual;
    procedure JoinLines; virtual;
    function  Insert(const S : string) : boolean; virtual;
    procedure DeleteRight(Number : integer); virtual;

    function  IsValidBlockPos(X, Y : integer) : boolean;
    function  SaveWithQuestion : boolean;
    function  ChangeObjectName(const NewName : string) : boolean; virtual;
    function  ParseToString(Index : integer; NeedParse : boolean) : integer;
    procedure ProcessEscape; virtual;

    procedure JumpToChar(Value : integer);
    function  IsPosInBlock(X, Y : integer) : boolean;
    procedure SelectionBounds(Aline : integer; var ALeft, ARight : integer; CheckMBCS : boolean);
    procedure JumpToLine(Value : integer);
    procedure ClearUndoBuffer;
    function  GetStrAddr(Index : integer) : PChar;
    function  GetColorData(Index : integer) : string;
    procedure UnivMark(MoveProc : TObjProc; NewSelType : TSelectionType);
    procedure RegisterNotifier(W : TNotifierProc; WithUpdate : boolean);
    procedure UnregisterNotifier(W : TNotifierProc);

// ------------------ loading from different sources ------------

    procedure LoadFromStrings(S : TStrings);
    procedure LoadFromStream(S : TStream);
    procedure LoadFromFile(const FileName : string);
    procedure QuickLoadFromFile(const FileName : string);
    procedure AssignLines(AStrings : TStrings; ASelected : boolean);
// ------------------ saving to different sources ---------------
    procedure SaveToStream(ST : TStream);
    procedure SaveToFile(const FileName : string);

    function  Save : boolean; virtual;
    procedure BeginUpdate(ACode : integer);
    procedure EndUpdate; virtual;
    procedure BeginUndoBlock;
    procedure EndUndoBlock;
    procedure BeginSafeUpdate(ACode : integer);
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Undo;
    procedure Redo;
    function  UndoAvailable : boolean;
    function  RedoAvailable : boolean;
    function  PointToSelPoint(const P : TPoint) : TPoint;
    function  SelPointToPoint(const P : TPoint) : TPoint;
    function  GetCaretPoint : TPoint;
    procedure SetCaretPoint(const P : TPoint);
    procedure JumpTo(X, Y : integer);
    procedure CursorUp;
    procedure CursorLeft;
    procedure CursorRight;
    procedure TabCursorRight;
    procedure TabCursorLeft;
    procedure CursorDown;
    procedure JumpToBlockBegin;
    procedure JumpToBlockEnd;
    procedure JumpToFileBegin;
    procedure JumpToFileEnd;
    procedure JumpToLineBegin;
    procedure JumpToLineEnd;
    procedure JumpWordLeft;
    procedure JumpWordRight;

//;--------------------- block selection ----------------------

    procedure MarkBlockBegin;
    procedure MarkBlockEnd;
    procedure MarkWord;
    procedure MarkLeft;
    procedure MarkRight;
    procedure MarkBriefColRight;
    procedure MarkBriefRight;
    procedure MarkLine;
    procedure MarkUp;
    procedure MarkDown;
    procedure MarkToLineEnd;
    procedure MarkToLineBegin;
    procedure MarkWordLeft;
    procedure MarkWordRight;
    procedure MarkToFileBegin;
    procedure MarkToFileEnd;
    procedure SelectAll;
    procedure MarkWordWithType(WordSelType : TWordSelectionType);

//;--------------------- column block selection ------------------------
    procedure MarkColLeft;
    procedure MarkColRight;
    procedure MarkColUp;
    procedure MarkColDown;
    procedure MarkColToLineEnd;
    procedure MarkColToLineBegin;
    procedure MarkColWordLeft;
    procedure MarkColWordRight;
    procedure MarkColToFileBegin;
    procedure MarkColToFileEnd;
    procedure ClearSelection;

// brackets
    procedure FindNextBracket;
    procedure NextBracket;
    procedure PrevBracket;
    function  FindCloseBracket(openbr : char; JumpifFound : boolean; var APoint : TPoint) : boolean;
    function  FindOpenBracket(closebr : char; JumpifFound : boolean; var APoint : TPoint) : boolean;


//;--------------------- block handling -----------------------

    procedure ChangeBlockTo(const S : string);
    procedure SetSelection(V : TSelectionType; ALeft, ATop, ARight, ABottom : integer);
    procedure QuoteBlock;
    function  CanPaste : boolean ;
    function  CanCopy : boolean ;
    procedure CopyBlock; virtual;
    procedure CutBlock; virtual;
    procedure PasteBlock; virtual;
    procedure DeleteBlock;
    procedure DuplicateBlock;
    procedure ReadBlockFromFile(const FileName : string);
    procedure WriteBlockToFile(const FileName : string);
    procedure ReadBlockFromStream(S : TStream);
    procedure WriteBlockToStream(S : TStream);
    procedure IndentBlock;
    procedure OutDentBlock;

    function  MoveBlock : boolean;
    procedure KeyMoveBlock;
    procedure JustifyBlock;
    procedure JustifyText;

//;--------------------- block options -------------------------

    procedure SetBlockAsColBlock;
    procedure SetBlockAsLineBlock;

//;-------------------- delete procedures ----------------------

    procedure DeleteCharRight;
    procedure DeleteCharLeft;
    procedure DeleteWord;
    procedure Clear;
    procedure DeleteWordRight;
    procedure CorrectMarkWordRight;
    procedure CorrectDeleteWordRight;
    procedure DeleteWordLeft;
    procedure DeleteLine;
    procedure DeleteToLineBegin;
    procedure DeleteToLineEnd;

//;-------------------- insert procedures ----------------------

    procedure InsertStrings(S : TStrings; BlockSel : boolean);
    procedure InsertString(const S : string);
    procedure InsertLine;
    procedure PressTab;
    procedure PressShiftTab;
    procedure PressEnter; virtual;
    procedure ToggleInsMode;
    procedure SetInsertMode;
    procedure SetOverwriteMode;
    procedure InsertDate;
    procedure InsertTime;
    {$IFNDEF CLX}
    procedure InsertGUID;
    {$ENDIF}
//;-------------------- case procedures --------------------------

    procedure UpperCaseLine;
    procedure LowerCaseLine;
    procedure ToggleLineCase;
    procedure CapitalizeWord;
    procedure CapitalizeLine;
    procedure CapitalizeBlock;

    procedure UpperCaseBlock;
    procedure LowerCaseBlock;
    procedure ToggleBlockCase;
    procedure LowerCaseWord;
    procedure UpperCaseWord;
    procedure ToggleWordCase;
    procedure ShowGoToLineDialog;

//------------- search and replace procedures --------------------

    procedure ShowSearchDialog; virtual;
    procedure ShowReplaceDialog; virtual;
    procedure KeyFindNext;
    procedure KeyReplace;
    function  Find : boolean; virtual;
    function  Replace : boolean; virtual;
    function  FindNext : boolean; virtual;

    procedure ToggleCaseSensitiveSearch;
    procedure ToggleRegularExprSearch;

//------------ bookmark procedures ---------------------------

    procedure ClearBookmark(BookMarkNumber : TBookmarkNumber);
    procedure SetBookmark(BookMarkNumber : TBookmarkNumber);
    procedure GoToBookmark(BookMarkNumber : TBookmarkNumber);
    procedure ToggleBookMark(BookMarkNumber : TBookmarkNumber);
    procedure ToggleBookMarkForLine(BookMarkNumber : TBookmarkNumber; LinePos : integer);
    function  FindBookMark(BookMarkNumber : TBookmarkNumber; var APoint : TPoint) : boolean;
    function  NextBookmarkNumber : integer;
    procedure ToggleBookMark0;
    procedure ToggleBookMark1;
    procedure ToggleBookMark2;
    procedure ToggleBookMark3;
    procedure ToggleBookMark4;
    procedure ToggleBookMark5;
    procedure ToggleBookMark6;
    procedure ToggleBookMark7;
    procedure ToggleBookMark8;
    procedure ToggleBookMark9;

    procedure GoToBookMark0;
    procedure GoToBookMark1;
    procedure GoToBookMark2;
    procedure GoToBookMark3;
    procedure GoToBookMark4;
    procedure GoToBookMark5;
    procedure GoToBookMark6;
    procedure GoToBookMark7;
    procedure GoToBookMark8;
    procedure GoToBookMark9;
    procedure ClearImageBit(Index : integer);
//----------------- new functions ----------------------------
    function CorrectTextAtCursor : string;
    function CorrectTextAt(X, Y : integer) : string;
    function CorrectCharUnderCursor(var P : TPoint) : char;
// ---------------- tabs -----------------------------------------

    function GetRealTabIndex(const s : string; Index : integer) : integer;
    function GetRelativeTabIndex(const s : string; Index : integer) : integer;
    function ExpandTabString(const s : string) : string;

//----------------- visible lines  -------------------------------

    function RealToVisibleIndex(Index : integer) : integer;
    function VisibleToRealIndex(Index : integer) : integer;
//----------------- public properties ----------------------------

    property  LeaveSpacesAndTabs : boolean read FLeaveSpacesAndTabs write FLeaveSpacesAndTabs;

    property ActiveMemo : TWinControl read FActiveMemo write FActiveMemo;
    property BookMark[Index : integer] : byte read FGetBookMark write FSetBookMark;

    property LineTextStyle[Index : integer] : byte read GetLineTextStyle write SetLineTextStyle;
    property LineReadOnly[Index : integer] : boolean read GetLineReadOnly write SetLineReadOnly;
    property LineVisible[Index : integer] : boolean read GetLineVisible write SetLineVisible;
    property CollapseState[Index : integer] : TCollapseState read GetCollapseState write SetCollapseState;

    property Strings : TStrings read FExternalStrings write SetLines;
    property CurCharPos : integer read GetCurChar write JumpToChar;
    property CurLinePos : integer read GetCurLine write JumpToLine;
    property SelectionRect : TRect read GetSelectionRect write SetSelectionRect;
    property StrCount : integer read GetStrCount;
    property State : TMemoStates read FState write FState;
    property FirstChanged : integer read FFirstChanged;
    property LastChanged : integer read FLastChanged;
    property SelectionType : TSelectionType read FSelectiontype write SetSelectionType;
    property ImageBit[Index,ImageIndex : integer] : boolean read GetImageBit write SetImageBit;
    property Modified : boolean read FModified write SetModified;
    property Editors : TNotifierList read FNotifiers;
    property Overwrite : boolean read GetOverwrite write SetOverwrite Default false;
    property SelStrings : TStrings read FSelStrings;
    property TextAtCursor : string read GetTextAtCursor;
    property DelimSet : TCharSet read FDelimSet write FDelimSet;
    property CaretPoint : TPoint read GetCaretPoint write SetCaretPoint;
    property FoundRect : TRect read FFoundRect write SetFoundRect;
    property SearchOptions : TSearchOptions read GetSearchOptions write SetSearchOptions;
    property ObjectName : string read FObjectName write SetObjectName;
    property OldObjectName : string read FOldName;
    property ShortObjectName : string read GetShortObjectName;
    property Options : TStringsOptions read FOptions write SetOptions;
    property SyntaxParser : TSimpleParser read FSyntaxParser write SetSyntaxParser;
    property TabStops : string read FTabStops write SetTabStops;
    property Delimeters : string read FDelimeters write SetDelimeters;
    property Lines : TStrings read FExternalStrings write SetLines;
    property ReadOnly : boolean read FROnly write SetROnly;// we don't use GetReadOnly for the property
    property BlockIndent : integer read FBlockIndent write SetBlockIndent default 1;
    property SpacesInTab : integer read FSpacesInTab write SetSpacesInTab;
    property UseGlobalOptions : boolean read GetUseGlobalOptions write SetUseGlobalOptions;
    property CodeTemplates : TMemoCodeTemplates read FCodeTemplates write SetCodeTemplates;
    property TemplatesType : string read FTemplatesType write SetTemplatesType;
    property HighlightUrls : boolean read FHighlightUrls write SetHighlightUrls;
    property BlockOption : TBlockOption read FBlockOption write SetBlockOption default bkBoth;
    property OutFormat : TOutFormatType read FOutFormat write FOutFormat default ofWindows;
    property AllowUndo : boolean read FAllowUndo write SetAllowUndo default true;
    property UndoLimit : integer read FUndoLimit write SetUndoLimit default 0;
    property MaxLineLen : integer read FMaxLineLen;
    property QuickLoad  : boolean read FQuickLoad write FQuickLoad;

    property OnGetBackupName : TGetBackpNameEvent  read FOnGetBackupName write FOnGetBackupName;
    property OnGetSelectionType : TGetSelectionTypeEvent read FOnGetSelectionType write FOnGetSelectionType;
    property OnSearchException : TSearchExceptionEvent read FOnSearchException write FOnSearchException;
    property OnPasteFromClipboard : TClipboardEvent read FOnPasteFromClipboard write FOnPasteFromClipboard;
    property OnCreateDialog : TCreateDialogEvent read FOnCreateDialog write FOnCreateDialog;
    property OnAfterParse : TAfterParseEvent read FOnAfterParse write FOnAfterParse;
    property OnBeforeFindReplace  : TBeforeFindReplaceEvent read FOnBeforeFindReplace write FOnBeforeFindReplace;
  published
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

  TMemoSource = class(TCustomMemoSource)
  published
    property Options;
    property SyntaxParser;
    property TabStops;
    property Delimeters;
    property Lines;
    property ReadOnly;
    property BlockIndent;
    property SpacesInTab;
    property CodeTemplates;
    property TemplatesType;
    property HighlightUrls;
    property BlockOption;
    property OutFormat;
    property AllowUndo;
    property UndoLimit;
    property OnGetBackupName;
    property OnGetSelectionType;
    property OnSearchException;
    property OnPasteFromClipboard;
    property OnCreateDialog;
    property UseGlobalOptions;//This must be the last property
  end;

  TMemoSourceOptions=class(TOptionExt)
  private
    FKeepTrailingBlanks:Boolean;
    FOptions     : TStringsOptions;
    FTabStops    : string;
    FDelimeters  : string;
    FBlockIndent : integer;
    Procedure SetKeepTrailingBlanks(Value:Boolean);
    procedure SetOptions(V : TStringsOptions);
    procedure SetTabStops(V : string);
    procedure SetDelimeters(V : string);
    procedure SetBlockIndent(V : integer);
  public
    procedure Update; override;
    function  GetKey : string; override;
    procedure InitValues; override;
  published
    Property KeepTrailingBlanks:Boolean read FKeepTrailingBlanks write SetKeepTrailingBlanks default False;
    property Options : TStringsOptions read FOptions write SetOptions;
    property TabStops : string read FTabStops write SetTabStops;
    property Delimeters : string read FDelimeters write SetDelimeters;
    property BlockIndent : integer read FBlockIndent write SetBlockIndent;
  end;

const
  ClipSelType : TClipFormat = cfStreamSel;

  msAllChanged = [msPositionChanged, msUndo, msModifiedChanged, msBlockChanged, msInsState,
                  msCountChanged, msObjNameChanged, msParserChanged];

  cDefaultOptions = [soBackUnindents, soGroupUndo, soForceCutCopy, soAutoIndent,
                     soSmartTab, soFindTextAtCursor, soOverwriteBlocks];

{--------------------------------------------}

function  SearchinStrings(S : TStrings;SrchOptions : TSearchOptions; var P : TPoint;
            var Len : integer; const DelimSet : TCharSet) : boolean;
function  ExpandTabs(const S : string; TabSize : integer) : string;
procedure ExpandTabsinStrings(FromStrings, ToStrings : TStrings; TabSize : integer);
procedure ClipboardToStrings(Strings : TStrings);
function  GetOverwrite : boolean;
function  GetSearchOptions : TSearchOptions;
procedure SetClipSelToStream;
function  MemoSourceByName(const ObjectName : string) : TCustomMemoSource;


type
  {$IFNDEF CLX}
  TClipBoardSource = class(TCustomMemoSource)
  private
    FUpdate         : boolean;
    FClipHandle     : THandleObject;
    FClipboardOwner : HWnd;
    procedure WndProc(var Msg: TMessage);
  public
    function  ChangeObjectName(const NewName : string) : boolean; override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure CopyBlock; override;
  published
    property Options;
    property SyntaxParser;
    property TabStops;
    property Delimeters;
    property ReadOnly;
    property BlockIndent;
    property SpacesInTab;
    property UseGlobalOptions;
  end;

  TClipbrdMemoSource = class(TClipboardSource)
  end;
  {$ENDIF}

  TCodeTemplateProc = procedure(CodeTemplates : TMemoCodeTemplates);

{--------------------------------------------}

function  MemoSources : TList;
function  GlobalMemoSourceOptions : TMemoSourceOptions;
procedure FillWithDelphiTemplates(CodeTemplates : TMemoCodeTemplates);
procedure FillWithCppTemplates(CodeTemplates : TMemoCodeTemplates);
procedure FillWithClipperTemplates(CodeTemplates : TMemoCodeTemplates);
                
function  ExpandString(const S : string; Margin : integer) : string;
function  ExpandStrings(Strings : TStrings ; Margin : integer) : string;
procedure RegisterTemplatesProc(const Language : string; Proc : TCodeTemplateProc);
procedure TemplatesFromArray(CodeTemplates : TMemoCodeTemplates; TemplArray : array of TTemplateRec);
function  ReadIntegerDialog(const FormCaption, InputCaption : string; HelpCtx : integer; AObject : TObject; AEvent : TMethod; var Value : integer) : boolean;

//mbcs
function  StrFromIndex(Ps : Pchar; Index : integer) : Pchar;
function  _CharToByte(const s : string; Index : integer) : integer;
function  _ByteToChar(const s : string; Index : integer) : integer;
function  _GetStrDisplayIndex(const s : string; Index : integer) : integer;
function  _Length(const s : string) : integer;
function  _Copy(const s : string; Index, Count : integer) : string;
function  _IsLeadByte(const s : string; Index : integer) : boolean;
function  _IsTrailByte(const s : string; Index : integer) : boolean;
function  _IsSingleByte(const s : string; Index : integer) : boolean;
procedure _Delete(var s : string; Index, Count : integer);
procedure _Insert(Source: string; var S: string; Index: Integer);


procedure Register;

const
  tokUrl = 12;
  tokString = 1;
  tokComment = 2;

  cFloatDelta = 100;
  cMaxWrapDelta = 255;
  cdInsertWithData = 5;

var
  cHotSpotChars : set of Char;
  FLastSource : TCustomMemoSource = nil;
  ModalSearchAndReplace : boolean = true;
implementation
uses
  replunit, searunit, searrepldlg, dcinpfrm;
  
var
  FMemoSources : TList = nil;

type

  PStringItemList = ^TStringItemList;
  TStringItemList = array[0..Maxint div sizeof(TStringItem) - 1] of TStringItem;

  TTabStringEvent = procedure(Sender : TObject; var s : string) of object;

  TInternalStrings = class(TStrings)
  private
    FItemClass      : TStringItemClass;
    FList           : PStringItemList;
    FCount          : integer;
    FCapacity       : integer;
    //FKeepSpaces     : boolean;
    FOnGetTabString : TTabStringEvent;
    FIgnoreTabs     : boolean;
    procedure Grow;
    procedure InsertItem(Index : integer; const S : string);
  protected
    function  Get(Index : integer): string; override;
    function  GetRealString(Index : integer) : string;
{$IFDEF D3}
    function  GetCapacity : integer; override;
{$ENDIF}
    function  GetCount : integer; override;
    function  GetObject(Index : integer) : TObject; override;
    procedure Put(Index : integer; const S : string); override;
    procedure PutObject(Index : integer; AObject : TObject); override;
    procedure SetCapacity(NewCapacity : integer); {$IFDEF D3} override;{$ENDIF}
    function  GetTextStr : string; override;
    function  CheckForTabs(const s : string) : string;
  public
    constructor Create(ItemClass : TStringItemClass);
    destructor Destroy; override;
    function  Add(const S : string) : integer; override;
    procedure Clear; override;
    procedure Delete(Index : integer); override;
    procedure Exchange(Index1, Index2 : integer); override;
    procedure Insert(Index : integer; const S : string); override;
    property  List : PStringItemList read FList;
    //property  KeepSpaces : boolean read FKeepSpaces write FKeepSpaces;
    property  OnGetTabString : TTabStringEvent read FOnGetTabString write FOnGetTabString;
  end;

  TSourceStrings = class(TStrings)
  private
    FMemoSource : TCustomMemoSource;
  public
    constructor Create(MemoSource : TCustomMemoSource);
  end;

  TSelectionStrings = class(TSourceStrings)
  protected
    function  Get(Index : integer) : string; override;
    function  GetEx(Index : integer; UseColorData : boolean): string;
    function  GetCount : integer; override;
    procedure Clear; override;
    procedure Delete(Index : integer); override;
    procedure Insert(Index : integer; const S : string); override;
  public
    procedure Exchange(Index1, Index2 : integer); override;
  end;

  TExternalStrings = class(TSourceStrings)
  private
    procedure SEndUpdate;
    function  InternalStrings : TStrings;
    function  GetTabString(const s : string) : string;
  protected
    procedure SetUpdateState(AUpdating : boolean); override;
    function  Get(Index : integer) : string; override;
    function  GetCount : integer; override;
    function  GetObject(Index : integer) : TObject; override;
    procedure Put(Index : integer; const S : string); override;
    function  GetTextStr : string; override;
    procedure PutObject(Index : integer; AObject : TObject); override;
    procedure SetTextStr(const Value : string); override;
  public
    procedure Clear; override;
    procedure Delete(Index : integer); override;
    procedure Exchange(Index1, Index2 : integer); override;
    procedure Insert(Index : integer; const S : string); override;
    procedure LoadFromStream(Stream : TStream); override;
    procedure SaveToStream(Stream : TStream); override;
    procedure Assign(Source : TPersistent); override;
  end;

  TTrimDirection = (tdLeft, tdRight, tdBoth);


{--------------------------------------------}

function MemoSources : TList;
begin
  If FMemoSources = nil then
    FMemoSources := TList.Create;
  result := FMemoSources;
end;

{--------------------------------------------}

function RemoveExtraEol(var s : string) : boolean;
var
  L : integer;

  procedure _Process;
  begin
    if (L > 0) and (s[L] in [#13, #10]) then
    begin
      dec(L);
      result := true;
    end;
  end;

begin
  result := false;
  L := Length(s);
  _Process;
  _Process;
  SetLength(s, L);
end;

{--------------------------------------------}

function ReadIntegerDialog(const FormCaption, InputCaption : string; HelpCtx : integer; AObject : TObject; AEvent : TMethod; var Value : integer) : boolean;
var
  F : TInputLineForm;
begin
  F := CreateInputForm(FormCaption, InputCaption, HelpCtx);
  with F do
  begin
    PropEdit.Text := IntToStr(Value);
    try
      if AEvent.Code <> nil then
        TCreateDialogEvent(AEvent)(AObject, F);
      Result := ShowModal = mrOk;
      If Result then
        Value := StrToInt(PropEdit.Text);
    finally
      Free;
    end;
  end;
end;

{--------------------------------------------}

procedure CheckLen(var S : string; Len : integer);
var
  Leng : integer;
begin
  Leng := length(S);
  if Leng > Len then
    SetLength(S, Len)
  else
    if Leng < Len then
      S := S + StringOfChar(#0, Len - Leng);
end;

{--------------------------------------------}

function StrFromIndex(Ps : Pchar; Index : integer) : Pchar;
{$IFDEF DCMBCS}
var
  i : integer;
{$ENDIF}
begin
{$IFDEF DCMBCS}
  if SysLocale.FarEast then
  begin
    result := Ps;
    for i := 0 to Index - 1 do
      result := CharNext(result);
  end
  else
    result := Ps + Index;
{$ELSE}
  result := Ps + Index;
{$ENDIF}
end;

{--------------------------------------------}

function _GetStrDisplayIndex(const s : string; Index : integer) : integer;
{$IFDEF DCMBCS}
var
  Len : integer;
  i   : integer;
{$ENDIF}
begin
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
  begin
    if Index = MaxInt then
    begin
      result := MaxInt;
      exit;
    end;
    result := 0;
    if Index = 0 then
      exit;
    Len := length(s);
    for i := 0 to Index - 1 do
      if (result < Len) and (s[result + 1] in LeadBytes) then
        inc(result, 2)
      else
        inc(result);
   end
   else
     result := Index;
  {$ELSE}
  result := Index;
  {$ENDIF}
end;

{--------------------------------------------}

function _IsLeadByte(const s : string; Index : integer) : boolean;
begin
  {$IFDEF DCMBCS}
  result :=  SysLocale.FarEast and (Index > 0) and (Index <= length(s)) and (ByteType(s, Index) = mbLeadByte);
  {$ELSE}
  result := false;
  {$ENDIF}
end;

{--------------------------------------------}

function _IsTrailByte(const s : string; Index : integer) : boolean;
begin
  {$IFDEF DCMBCS}
  result :=  SysLocale.FarEast and (Index > 0) and (Index <= length(s)) and (ByteType(s, Index) = mbTrailByte);
  {$ELSE}
  result := false;
  {$ENDIF}
end;

{--------------------------------------------}

function _IsSingleByte(const s : string; Index : integer) : boolean;
begin
  {$IFDEF DCMBCS}
  result := not SysLocale.FarEast or (Index <= 0) or (Index > length(s)) or (ByteType(s, Index) = mbSingleByte);
  {$ELSE}
  result := true;
  {$ENDIF}
end;

{--------------------------------------------}

function _ByteToChar(const s : string; Index : integer) : integer;
begin
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
  begin
    if Index > Length(s) then
      result :=  _Length(s) + Index - Length(s)
    else
      result := ByteToCharIndex(s, Index);
  end    
  else
    result := Index;
  {$ELSE}
  result := Index;
  {$ENDIF}
end;

{--------------------------------------------}

function _CharToByte(const s : string; Index : integer) : integer;
{$IFDEF DCMBCS}
var
  Len : integer;
  i   : integer;
{$ENDIF}
begin
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
  begin
    if Index = MaxInt then
    begin
      result := MaxInt;
      exit;
    end;
    result := 0;
    if Index = 0 then
      exit;
    Len := length(s);
    for i := 1 to Index - 1 do
      if (result < Len) and (s[result + 1] in LeadBytes) then
        inc(result, 2)
      else
        inc(result);
    inc(result);
  end
  else
    result := Index;
  {$ELSE}
  result := Index;
  {$ENDIF}
end;

{--------------------------------------------}

function _Length(const s : string) : integer;
{$IFDEF DCMBCS}
var
  Ps : Pchar;
{$ENDIF}
begin
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
  begin
    result := 0;
    if s <> '' then
    begin
      Ps := Pchar(s);
      while Ps^ <> #0 do
      begin
        Ps := CharNext(Ps);
        inc(result);
      end;
    end;
  end
  else
    result := length(s)
  {$ELSE}
  result := length(s)
  {$ENDIF}
end;

{--------------------------------------------}

function _Copy(const s : string; Index, Count : integer) : string;
begin
  {$IFDEF DCMBCS}
  if SysLocale.FarEast and (s <> '') then
  begin
    if Count < MaxInt then
      Count := _CharToByte(s, Index + Count);
    Index := _CharToByte(s, Index);
    if Count < MaxInt then
      dec(Count, Index)
  end;
  {$ENDIF}
  result := Copy(s, Index, Count);
end;

{--------------------------------------------}

procedure _Delete(var s : string; Index, Count : integer);
begin
  {$IFDEF DCMBCS}
  if SysLocale.FarEast and (s <> '') then
  begin
    if Count < MaxInt then
      Count := _CharToByte(s, Index + Count);
    Index := _CharToByte(s, Index);
    if Count < MaxInt then
      dec(Count, Index)
  end;
  {$ENDIF}
  Delete(s, Index, Count);
end;

{--------------------------------------------}

procedure _Insert(Source: string; var S: string; Index: Integer);
begin
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    Index := _CharToByte(s, Index);
  {$ENDIF}
  Insert(Source, s, Index);
end;

{--------------------------------------------}

function _CharPos(const s : string; ch : Char; Index : integer) : integer;
begin
  result := PosEx(ch, s, Index);
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    while (result <> 0) and not (_IsSingleByte(s, result)) do
      result := PosEx(ch, s, result + 1);
  {$ENDIF}
end;

{--------------------------------------------}

function _StrPos(const substr, s : string; Index : integer) : integer;
begin
  result := PosEx(substr, s, Index);
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    while (result <> 0) and not (_IsSingleByte(s, result)) do
      result := PosEx(substr, s, result + 1);
  {$ENDIF}
end;

{--------------------------------------------}

function _StrBackPos(const substr, s : string; Index : integer) : integer;
begin
  result := BackPosEx(substr, s, Index);
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    while (result <> 0) and not (_IsSingleByte(s, result)) do
      result := BackPosEx(substr, s, result + 1);
  {$ENDIF}
end;

{--------------------------------------------}

function TabPos(const s : string; Index : integer) : integer;
begin
  result := _CharPos(s, #9, Index);
end;

{--------------------------------------------}

function SpacePos(const s : string; Index : integer) : integer;
begin
  result := _CharPos(s, ' ', Index);
end;

{--------------------------------------------}

function _EqualChar(const s : string; Index : integer; ch : char) : boolean;
begin
  result := (s[Index] = ch) and _IsSingleByte(s, Index);
end;

{--------------------------------------------}

function _Trim(const s : string; ExcludeTab : boolean; Direction :  TTrimDirection) : string;

var
  i : integer;
  l : integer;
begin
  case Direction of
    tdRight :
      begin
        i := Length(s);
        while (i > 0) do
        begin
          if (s[i] > ' ') or (ExcludeTab and (s[i] = #9))
          {$IFDEF DCMBCS}
            or not _IsSingleByte(s, i)
          {$ENDIF}
          then
            break;
          Dec(i);
        end;
        result := Copy(s, 1, i);
      end;
    tdLeft :
      begin
        l := Length(S);
        i := 1;
        while (i <= L) do
        begin
          if (S[i] > ' ')
          {$IFDEF DCMBCS}
          or not _IsSingleByte(s, i) 
          {$ENDIF}
          then
            break;
          Inc(i);
        end;
        result := Copy(s, i, Maxint);
      end;
    else
      result := _Trim(_Trim(s, ExcludeTab, tdRight), ExcludeTab, tdLeft);
  end;
end;

{-------------------------------------------------------------}

function _TrimRight(const s : string) : string;
begin
  result := _Trim(s, false, tdRight);
end;

{-------------------------------------------------------------}

function _TrimLeft(const s : string) : string;
begin
  result := _Trim(s, false, tdLeft);
end;

{-------------------------------------------------------------}


procedure TExternalStrings.LoadFromStream(Stream: TStream);
begin
  with FMemoSource do
  begin
    BeginUpdate(acStringsUpdate);
    inherited;
    JumpTo(0, 0);
    SEndUpdate;
  end;
end;

{--------------------------------------------}

procedure TExternalStrings.SaveToStream(Stream : TStream);
var
  S           : string;
  ExludeROnly : boolean;
  {--------------------------------------------}

  function GetFormatTextStr(fmt : TOutFormatType) : string;
  var
    i    : integer;
    l    : integer;
    Size : integer;
    cnt  : integer;
    P    : PChar;
    S    : string;
  begin
    Size := 0;
    if fmt = ofWindows then
      cnt := 2
    else
      cnt := 1;

    for i := 0 to Count - 1 do
      if not (ExludeROnly and FMemoSource.GetLineReadOnly(i)) then
        Inc(Size, Length(Strings[i]) + cnt);
    SetString(result, nil, Size);
    P := Pointer(result);
    for i := 0 to Count - 1 do
      if not (ExludeROnly and FMemoSource.GetLineReadOnly(i)) then
      begin
        S := Strings[i];
        l := Length(S);
        if l <> 0 then
        begin
          System.Move(Pointer(S)^, P^, L);
          Inc(P, L);
        end;
        if fmt = ofWindows then
        begin
          P^ := #13;
          (P + 1)^ := #10;
        end
        else
        if fmt = ofMac then
          P^ := #13
        else
          P^ := #10;
        inc(P, cnt);
      end;
  end;

  {--------------------------------------------}

begin
  ExludeROnly := soExcludeReadOnlyLines in FMemoSource.FOptions;
  TInternalStrings(InternalStrings).FIgnoreTabs := true;
  try
    if not ExludeROnly and (FMemoSource.OutFormat = ofWindows) then
      inherited SaveToStream(Stream)
    else
    begin
      S := GetFormatTextStr(FMemoSource.OutFormat);
      Stream.WriteBuffer(Pointer(S)^, Length(S));
    end;
  finally
    TInternalStrings(InternalStrings).FIgnoreTabs := false;
  end;
end;


{--------------------------------------------}

procedure TExternalStrings.SetTextStr(const Value : string);
{var
  LastLine : boolean;
}
begin
  with FMemoSource do
  begin
    BeginUpdate(acStringsUpdate);
    FQuickLoad := true;
    try
      //LastLine := (Value <> '') and (Value[length(Value)] in [#13, #10]);
      inherited;
      {
      if LastLine then
        Add('');
      }
      ReCalculateMaxLine;
      JumpTo(0, 0);
    finally
      FQuickLoad := false;
      SEndUpdate;
    end;
  end;
end;

{--------------------------------------------}

procedure TExternalStrings.Assign(Source : TPersistent);
begin
  inherited;
  FMemoSource.JumpTo(0, 0);
  FMemoSource.ClearUndoBuffer;
end;

{---------TMemoPositionList---------------------------------}

procedure ClearRecordList(List : TSortedList);
var
  i : integer;
begin
  if List <> nil then
    with List do
    begin
      for i := 0 to Count - 1 do
        Dispose(Items[i]);
      Clear;
    end;
end;

{------------------------------------------------------------------}

function  TMemoPositionList.Compare(Item1, Item2 : Pointer) : integer;
begin
  result := PPoint(Item1)^.Y - PPoint(Item2)^.Y;
  if result = 0 then
    result := PPoint(Item1)^.X - PPoint(Item2)^.X;
end;

{------------------------------------------------------------------}

procedure TMemoPositionList.Clear;
begin
  ClearRecordList(Self);
end;

{------------------------------------------------------------------}

function BookMarkRec(X, Y , Number : integer) : TBookMarkRec;
begin
  result.X := X;
  result.Y := Y;
  result.BookMark := Number;
end;

{------------------------------------------------------------------}

procedure TVisibleLinesList.LineChanged(FromLine , Delta : integer);
var
  i   : integer;
  idx : integer;
begin
  idx := Max(FindNear(FromLine, false, false), 0);
  if (idx >= 0) and (idx < Count) then
  begin
    with InternalList do
      for i := idx to Count - 1 do
        if integer(Items[i]) > FromLine then
          Items[i] := Pointer(integer(Items[i]) + Delta);

    if (Delta = -1) and (idx > 0) and (Items[idx] = Items[idx - 1])  then
      Delete(idx);
  end;
end;

{------------------------------------------------------------------}

procedure TVisibleLinesList.SetLineVisible(Line : integer;  Value : boolean);
begin
  if Value then
    Remove(Pointer(Line))
  else
    Add(Pointer(Line));
end;

{------------------------------------------------------------------}

function  TVisibleLinesList.GetLineVisible(Line : integer) : boolean;
begin
  result := IndexOf(Pointer(Line)) < 0;
end;

{------------------------------------------------------------------}

function  TVisibleLinesList.Compare(Item1, Item2 : Pointer) : integer;
begin
  if FCheckIndex then
  begin
    result := integer(Item1) - CurrentIndex  - integer(Item2);
    if (result = 0) and (CurrentIndex < Count - 1) and (integer(Items[CurrentIndex + 1]) - CurrentIndex - 1  = integer(Item2)) then
      result := - 1
  end
  else
    result := integer(Item1) - integer(Item2);
end;

{------------------------------------------------------------------}

function  TVisibleLinesList.FindNear(Item : integer; CheckIndex, Exact : boolean) : integer;
var
  ALine : integer;
begin
  result := -1;
  FCheckIndex := CheckIndex;
  try
    FindNearest(Pointer(Item), result);
    begin
      if (result >= 0) and (result < Count - 1) then
        inc(result);
      while (result >= 0) and (result < Count) do
      begin
        ALine := Integer(Items[result]);
        if CheckIndex then
          dec(ALine, result);
        if (Exact and (ALine < Item)) or (not Exact and (ALine <= Item))then
          break;
        dec(result);
      end;
    end;
{    if result >= Count then
      result := -1;}
  finally
    FCheckIndex := false;
  end;
end;


{------------------------------------------------------------------}

function  TVisibleLinesList.RealToVisibleIndex(Index : integer) : integer;
var
  i : integer;
begin
  result := Index;
  if Count > 0 then
  begin
    i := FindNear(Index, false, false);
    if (i >= 0) and (i < Count) then
      dec(result,  i + 1);
  end;
end;

{------------------------------------------------------------------}

function  TVisibleLinesList.VisibleToRealIndex(Index : integer) : integer;
var
  i : integer;
begin
  result := Index;
  if Count > 0 then
  begin
    i := FindNear(Index, true, false);
    if (i >= 0) and (i < Count) then
      inc(result, i + 1);
  end;
end;

{---------TMemoBookMarkList----------------------------------------}

function  TMemoBookMarkList.Compare(Item1, Item2 : Pointer) : integer;
begin
  result := PBookMarkRec(Item1)^.Y - PBookMarkRec(Item2)^.Y;
  if (result = 0) then
    result := PBookMarkRec(Item1)^.X - PBookMarkRec(Item2)^.X;
  if result = 0 then
    result := PBookMarkRec(Item1)^.BookMark - PBookMarkRec(Item2)^.BookMark;
end;

{------------------------------------------------------------------}

procedure TMemoBookMarkList.SetBookMark(Point : TPoint; Number : integer);
var
  Bm    : TBookMarkRec;
  P     : PBookMarkRec;
  Index : integer;
begin
  Bm := BookMarkRec(Point.X, Point.Y, Number);
  if not Find(@Bm, Index) then
  begin
    New(P);
    P^ := Bm;
    Add(P);
  end;
end;

{------------------------------------------------------------------}

function  TMemoBookMarkList.GetBookMarkForLine(Line : integer) : integer;
var
  Bm    : TBookMarkRec;
  Index : integer;
begin
  Bm := BookMarkRec(0, Line, 0);
  result := 0;
  FindNearest(@Bm, Index);
  if (Index >= 0) and (Index < Count) then
    with  PBookMarkRec(Items[Index])^ do
    begin
      if Y < Line then
        inc(Index);
      if (Index < Count) then
        with PBookMarkRec(Items[Index])^ do
          if Y = Line then
            result := BookMark;
    end;
end;

{------------------------------------------------------------------}

function  TMemoBookMarkList.GetBookmarkFromRange(Line, FromChar, ToChar : integer) : integer;
var
  Bm    : TBookMarkRec;
  Index : integer;
begin
  Bm := BookMarkRec(FromChar, Line, 0);
  result := 0;
  FindNearest(@Bm, Index);
  while (Index >= 0) and (Index < Count) do
    with  PBookMarkRec(Items[Index])^ do
    begin
      if Y = Line then
      begin
        if X >= ToChar then
          break
        else
        if X >= FromChar then
        begin
          result := BookMark;
          break;
        end;
      end
      else
      if Y > Line then
        break;
      inc(Index);
    end;
end;

{------------------------------------------------------------------}

procedure TMemoBookMarkList.GetBookmarksFromRange(Line, FromChar, ToChar : integer; List : TList);
var
  Bm    : TBookMarkRec;
  Index : integer;
begin
  List.Clear;
  Bm := BookMarkRec(FromChar, Line, 0);
  FindNearest(@Bm, Index);
  while (Index >= 0) and (Index < Count) do
    with  PBookMarkRec(Items[Index])^ do
    begin
      if Y = Line then
      begin
        if X >= ToChar then
          break
        else
        if X >= FromChar then
          List.Add(Items[Index]);
      end
      else
      if Y > Line then
        break;
      inc(Index);
    end;
end;

{------------------------------------------------------------------}

function  TMemoBookMarkList.ClearBookMark(Number : integer; var Index : integer) : boolean;
var
  i : integer;
  P : PBookMarkRec;
begin
  result := false;
  for i := Count -1 downto 0 do
  begin
    P := PBookMarkRec(Items[i]);
    with P^ do
      if BookMark = Number then
      begin
        result := true;
        Index := Y;
        Delete(i);
        dispose(P);
        break;
      end;
  end;
end;

{------------------------------------------------------------------}

function  TMemoBookMarkList.FindBookMark(Number : integer; var Pt : TBookMarkRec) : boolean;
var
  i : integer;
begin
  result := false;
  for i := Count - 1 downto 0 do
    with PBookMarkRec(Items[i])^ do
      if BookMark = Number then
      begin
        Pt := PBookMarkRec(Items[i])^;
        result := true;
        break;
      end;
end;

{------------------------------------------------------------------}

procedure TMemoBookMarkList.Sort;
begin
  Sorted := false;
  Sorted := true;
end;

{------------------------------------------------------------------}

procedure TMemoBookMarkList.CharChanged(FromLine, FromChar, Delta : integer);
var
  i     : integer;
  Index : integer;
  Bm    : TBookMarkRec;
begin
  Bm := BookMarkRec(0, FromLine, 0);
  FindNearest(@Bm, Index);
  if (Index >= 0) and (Index < Count) then
  begin
    for i := Index to Count - 1 do
      with PBookMarkRec(Items[i])^ do
      begin
        if Y > FromLine then
          break;
        if (Y = FromLine) and (((Delta > 0) and (X >= FromChar)) or ((Delta < 0) and (X > FromChar))) then
          inc(X, Delta);
      end;
    Sort;
  end;
end;

{------------------------------------------------------------------}

procedure TMemoBookMarkList.LineChanged(FromLine, FromChar, Delta : integer);
var
  i     : integer;
  Index : integer;
  Bm    : TBookMarkRec;
begin
  Bm := BookMarkRec(0, FromLine, 0);
  FindNearest(@Bm, Index);
  if (Index >= 0) and (Index < Count) then
  begin
    for i := Index to Count - 1 do
      with PBookMarkRec(Items[i])^ do
        if (Y > FromLine) or ((Y = FromLine) and (X >= FromChar)) then
          inc(Y, Delta);
    Sort;
  end;
end;

{------------------------------------------------------------------}

procedure TUndoList.DeleteLast;
begin
  if Count > 0 then
  begin
    with PUndoRecord(Items[Count - 1])^ do
    begin
      FString := '';
      FColorData := '';
    end;  
    Delete(Count - 1);
    if Count * 4 < Capacity  then
      Capacity := Capacity div 2;
  end;    
end;

{------------------------------------------------------------------}

constructor TUndoList.CreateNew;
begin
  inherited Create(SizeOf(TUndoRecord));
end;

{------------------------------------------------------------------}

function TUndoList.AddUndoRecord : PUndoRecord;
begin
  FRecord.FString := '';
  FRecord.FColorData := '';
  fillchar(FRecord, sizeOf(FRecord), #0);
  result := Items[Add(@FRecord)];
end;

{------------------------------------------------------------------}

procedure TUndoList.Clear;
var
  i : integer;
begin
  for i := 0 to Count - 1 do
    with PUndoRecord(Items[i])^ do
    begin
      FString := '';
      FColorData := '';
    end;  
  inherited Clear;
end;

{------------------------------------------------------------------}

procedure TUndoList.ClearToIndex(Index : integer);
var
  ACount : integer;
begin
  for ACount := 0 to Index do
    with PUndoRecord(Items[ACount])^ do
    begin
      FString := '';
      FColorData := '';
    end;  
  ACount := Count - 1;
  if Index < ACount then
    System.Move(Items[Index + 1]^, Items[0]^, (ACount - Index) * SizeOf(TUndoRecord));
  SetCount(ACount - Index);
end;

{---------TExternalStrings------------------}

procedure TExternalStrings.SetUpdateState(AUpdating : boolean);
begin
  with FMemoSource do
    if AUpdating then
      BeginSafeUpdate(acStringsUpdate)
    else
      SEndUpdate;
end;

{--------------------------------------------}

function TExternalStrings.GetTabString(const s : string) : string;
begin
  with FMemoSource do
    if (soUseTabCharacter in Options) then
      result := s
    else
      result := ExpandTabs(S, FSpacesInTab);
end;

{--------------------------------------------}

procedure TExternalStrings.Insert(Index : integer; const S : string);
begin
  with FMemoSource do
    if FQuickLoad then
    begin
      if LeaveSpacesAndTabs then
        GetStringsInsert(Index, GetTabString(S))
      else
        GetStringsInsert(Index, _TrimRight(GetTabString(S)))
    end    
    else
    begin
      BeginSafeUpdate(acInsertString);
      try
        JumpTo(0, Index);
        UpdatePositions(soBreakLine, 0);
        GetStringsInsert(Index, GetTabString(S));
        UpdateChanged(Index, MaxInt);
      finally
        SEndUpdate;
      end;
    end;
end;

{--------------------------------------------}

procedure TExternalStrings.SEndUpdate;
begin
  with FMemoSource do
  begin
    EndUpdate;
    ClearUndoBuffer;
  end;
end;

{--------------------------------------------}

procedure TExternalStrings.Put(Index : integer; const S : string);
begin
  with FMemoSource do
  begin
    BeginSafeUpdate(acPutString);
    try
      GetStrings.Strings[Index] := GetTabString(S);
      UpdateChanged(Index, Index);
    finally
      SEndUpdate;
    end;
  end;
end;

{--------------------------------------------}

procedure TExternalStrings.Delete(Index : integer);
begin
  with FMemoSource do
  begin
    BeginSafeUpdate(acDeleteLine);
    try
      JumpTo(0, Index);
      UpdatePositions(soDeleteRight, Length(GetStrings[Index]));
      UpdatePositions(soJoinLines, 0);
      GetStringsDelete(Index);
      UpdateChanged(Index, MaxInt);
    finally
      SEndUpdate;
    end;
  end;
end;

{--------------------------------------------}

procedure TExternalStrings.Exchange(Index1, Index2 : integer);
begin
end;

{--------------------------------------------}

function TExternalStrings.InternalStrings : TStrings;
begin
  result := FMemoSource.GetStrings;
end;

{--------------------------------------------}

function TExternalStrings.GetObject(Index : integer) : TObject;
begin
  result := InternalStrings.Objects[Index];
end;

{--------------------------------------------}

procedure TExternalStrings.Clear;
begin
  with FMemoSource do
  begin
    BeginSafeUpdate(acClear);
    GetStrings.Clear;
    JumpTo(0, 0);
    FSelectionType := stNotSelected;
    UpdateSavedPos;
    UpdateChanged(0, MaxInt);
    FBookmarkList.Clear;
    FVisibleLinesList.Clear;
    RecalculateMaxLine;
    SEndUpdate;
  end;
end;

{--------------------------------------------}

type
  TMStrings = class(TStrings)
  end;

{--------------------------------------------}

procedure TExternalStrings.PutObject(Index : integer; AObject : TObject);
begin
  TMStrings(InternalStrings).PutObject(Index, AObject);
end;

{--------------------------------------------}

function TExternalStrings.Get(Index : integer): string;
begin
  result := TMStrings(InternalStrings).Get(Index);
end;

{--------------------------------------------}

function TExternalStrings.GetCount : integer;
begin
  result := InternalStrings.Count;
end;

{--------------------------------------------}

function TExternalStrings.GetTextStr : string;
begin
  with TInternalStrings(InternalStrings) do
  begin
    FIgnoreTabs := true;
    try
      result := FMemoSource.GetStrings.Text;
    finally
      FIgnoreTabs := false;
    end;
  end;
end;


{-----------TInternalStrings----------------}

constructor TInternalStrings.Create(ItemClass : TStringItemClass);
begin
  inherited Create;
  FItemClass := ItemClass;
end;

{-------------------------------------------------------------}

function TInternalStrings.GetTextStr : string;
begin
  result := inherited GetTextStr;
  RemoveExtraEol(result);
end;

{-------------------------------------------------------------}

destructor TInternalStrings.Destroy;
begin
  inherited Destroy;
  Clear;
end;

{-------------------------------------------------------------}

function TInternalStrings.Add(const S : string) : integer;
begin
  result := FCount;          
  InsertItem(result, S);
end;

{-------------------------------------------------------------}

procedure TInternalStrings.Clear;
var
  i : integer;
begin
  if FCount <> 0 then
  begin
    for i := 0 to FCount-1 do
      FList[i].Free;
    FCount := 0;
    SetCapacity(0);
  end;
end;

{-------------------------------------------------------------}

procedure TInternalStrings.Delete(Index : integer);
begin
  if (Index < 0) or (Index >= FCount) then
    exit;
  FList^[Index].Free;
  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index],
      (FCount - Index) * SizeOf(TStringItem));
end;

{-------------------------------------------------------------}

procedure TInternalStrings.Exchange(Index1, Index2 : integer);
begin
end;

{-------------------------------------------------------------}

function TInternalStrings.Get(Index : integer) : string;
begin
  if (Index < 0) or (Index >= FCount)
  then
    result := ''
  else
  begin
    if not FIgnoreTabs then
      result := CheckForTabs(FList[Index].FString)
    else
      result := FList[Index].FString;
  end;
end;

{-------------------------------------------------------------}

function  TInternalStrings.GetRealString(Index : integer) : string;
begin
  if (Index < 0) or (Index >= FCount)
  then
    result := ''
  else
    result := FList[Index].FString;
end;

{-------------------------------------------------------------}

function  TInternalStrings.CheckForTabs(const s : string) : string;
begin
  result := s;
  if Assigned(FOnGetTabString) then
    FOnGetTabString(Self, result);
end;

{-------------------------------------------------------------}

{$IFDEF D3}
function TInternalStrings.GetCapacity : integer;
begin
  result := FCapacity;
end;
{$ENDIF}

{-------------------------------------------------------------}

function TInternalStrings.GetCount : integer;
begin
  result := FCount;
end;

{-------------------------------------------------------------}

function TInternalStrings.GetObject(Index : integer) : TObject;
begin
  if (Index < 0) or (Index >= FCount)
  then
    result := nil
  else
    result := FList^[Index].FObject;
end;

{-------------------------------------------------------------}

procedure TInternalStrings.Grow;
begin
  SetCapacity(FCapacity + Max(FCapacity div 2, 64));
end;

{-------------------------------------------------------------}

procedure TInternalStrings.Insert(Index : integer; const S : string);
begin
  if (Index < 0) or (Index > FCount) then
    exit;
  InsertItem(Index, S);
end;

{-------------------------------------------------------------}


procedure TInternalStrings.InsertItem(Index : integer; const S : string);
begin
  if FCount = FCapacity then
    Grow;
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1],
      (FCount - Index) * SizeOf(TStringItem));

  FList^[Index] := FItemClass.Create;

  FList^[Index].FString := S;
  Inc(FCount);
end;

{-------------------------------------------------------------}

procedure TInternalStrings.Put(Index : integer; const S : string);
begin
  if (Index < 0) or (Index >= FCount) then
    exit;
  with FList^[Index] do
  begin
    FString := S; 
    FItemState := FItemState - [isWasParsed];
  end;
end;

{-------------------------------------------------------------}

procedure TInternalStrings.PutObject(Index : integer; AObject : TObject);
begin
  if (Index < 0) or (Index >= FCount) then
    exit;
  FList^[Index].FObject := AObject;
end;

{-------------------------------------------------------------}

procedure TInternalStrings.SetCapacity(NewCapacity : integer);
begin
  ReallocMem(FList, NewCapacity * SizeOf(TStringItem));
  FCapacity := NewCapacity;
end;

{--------TPosition----------------------------}

function TPosition.SameAs(P:TPosition):boolean;
begin
  result := (LinePos = P.LinePos) and (CharPos = P.CharPos);
end;

{--------------------------------------------}

procedure TPosition.Assign(Source : TPersistent);
begin
  if Source is TPosition then
  begin
    LinePos := TPosition(Source).LinePos;
    CharPos := TPosition(Source).CharPos;
  end
  else
    inherited;
end;

{--------------------------------------------}

procedure TPosition.SetPosition(AChar,ALine:integer);
begin
  CharPos := AChar;
  LinePos := ALine;
end;

{--------------------------------------------}

constructor TPosition.Create(ACollection:TCollection);
begin
  inherited;
end;

{--------TClipBoardSource------------------------------------}

{$IFNDEF CLX}

constructor TClipBoardSource.Create(AOwner: TComponent);
begin
  inherited;
  FObjectName := SClipboard;
  FClipHandle := THandleObject.Create(WndProc);
  FClipboardOwner := SetClipboardViewer(FClipHandle.Handle);
end;

{------------------------------------------------------------------}

destructor TClipBoardSource.Destroy;
begin
  ChangeClipboardChain(FClipHandle.Handle, FClipboardOwner);
  FClipHandle.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TClipBoardSource.CopyBlock;
begin
  FUpdate := true;
  try
    inherited;
  finally
    FUpdate := false;
  end;
end;

{------------------------------------------------------------------}

procedure TClipBoardSource.WndProc(var Msg : TMessage);
begin
  Msg.result := 0;
  case Msg.Msg of
    WM_ChangeCBChain :
      with TWMChangeCBChain(Msg) do
      begin
        if Remove = FClipboardOwner then
          FClipboardOwner := Next;
      end;
    WM_DrawClipboard :
      if not FUpdate and ClipBoard.HasFormat(CF_TEXT) then
      try
        BeginUpdate(acInsert);
        JumpToFileEnd;
        if Strings.Count > 0 then
        begin
          BreakLine;
          JumpToFileEnd;
        end;
        InsertString(ClipBoard.AsText);
      finally
        EndUpdate;
      end;
  end;
end;

{--------------------------------------------}

function TClipboardSource.ChangeObjectName(const NewName : string) : boolean;
begin
  result := false;
end;

{$ENDIF}

{--------TCustomMemoSource------------------}

procedure TCustomMemoSource.DoLoadFromFile(const AFileName : string);
var
  FileStream : TFileStream;
begin
  FileStream:=TFileStream.Create(AFileName,DefaultOpenMode);
  try
    LoadFromStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.DoSaveToFile(const AFileName : string);
begin
  Strings.SaveToFile(AFileName);
end;

{--------------------------------------------}

procedure TCustomMemoSource.TempHighlightLine(Index : integer; StyleIndex : byte);
begin
  TempUnhighlightLine;
  FTempHighlightIdx := LineTextStyle[Index];
  LineTextStyle[Index] := StyleIndex;
  FTempHighlightStr := Index + 1;
end;

{--------------------------------------------}

function TCustomMemoSource.GetStrings : TStrings;
begin
  result := FStrings;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetSpacesInTab(V : integer);
begin
  If (V < 1) or (V > 10) then
    V := 8;
  FSpacesInTab := V;
end;

{--------------------------------------------}

procedure TCustomMemoSource.Loaded;
begin
  inherited;
  BeginUpdate(acLoaded);
  Modified := false;
  JumpTo(0, 0);
  EndUpdate;
  ClearUndoBuffer;
end;

{--------------------------------------------}

function TCustomMemoSource.GetReadOnly : boolean;
begin
  result := FROnly;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetROnly(Value : boolean);
begin
  if FROnly <> Value then
  begin
    FROnly := Value;
    BeginUpdate(acReadonlyChanged);
    include(FState, msReadOnlyChanged);
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetBlockIndent(Value : integer);
begin
  FBlockIndent := max(Value, 0);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GetStringsDelete(Index : integer);
begin
  GetStrings.Delete(Index);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GetStringsInsert(Index : integer; const S : string);
begin
  GetStrings.Insert(Index, S);
end;

{--------------------------------------------}


procedure TCustomMemoSource.SetLines(Value : TStrings);
begin
  FExternalStrings.Assign(Value);
end;

{--------------------------------------------}

procedure TCustomMemoSource.Clear;
begin
  BeginUpdate(acClear);
  try
    SelectAll;
    DeleteBlock;
    JumpTo(0, 0);  
  finally
    EndUpdate;
  end;
end;
{--------------------------------------------}

{ Overwrite flag is global for all editors }

var
  FOverwrite : boolean;

{--------------------------------------------}

function GetOverwrite : boolean;
begin
  result := FOverwrite;
end;

{--------------------------------------------}

procedure SetClipSelToStream;
begin
  ClipSelType := cfStreamSel;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ParserOnChange(Sender : TObject; wParam, lParam : integer);
begin
  if FsyntaxParser = Sender then
    ParserChanged;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetSyntaxParser(Value : TSimpleParser);
begin
  if FSyntaxParser <> Value then
  begin
    if FSyntaxParser <> nil then
      FSyntaxParser.UnRegisterNotifier(ParserOnChange);
    FSyntaxParser := Value;
    if Value <> nil then
    begin
      Value.FreeNotification(Self);
      Value.RegisterNotifier(ParserOnChange);
    end;
    ParserChanged;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetOptions(V : TStringsOptions);
var
  WasUseTabCharacter : boolean;
  UpdateBeyondEof    : boolean;
begin
  if FOptions <> V then
  begin
    UpdateBeyondEof := (soBeyondFileEnd in FOptions) and not (soBeyondFileEnd in V);
    WasUseTabCharacter := soUseTabCharacter in FOptions;
    FOptions := V;
    if (soUseTabCharacter in FOptions) and not WasUseTabCharacter then
      Exclude(FOptions, soSmartTab)
    else
    if (soSmartTab in FOptions) and WasUseTabCharacter then
      Exclude(FOptions, soUseTabCharacter);
    if UpdateBeyondEof and (CaretPoint.Y > Strings.Count - 1) then
      JumpToFileEnd;
//    TInternalStrings(GetStrings).KeepSpaces := soLimitEOL in V;
  end;
end;

{--------------------------------------------}

function TCustomMemoSource.GetShortObjectName : string;
begin
  result := ChangeFileExt(ExtractFileName(ObjectName), '');
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetObjectName(const V : string);
begin
  ChangeObjectName(V);
end;

{--------------------------------------------}

function TCustomMemoSource.ChangeObjectName(const NewName : string) : boolean;
begin
  if FObjectName <> NewName then
  begin
    FOldName := FObjectName;
    BeginUpdate(acObjNameChanged);
    FObjectName := NewName;
    Include(FState, msObjNameChanged);
    EndUpdate;
  end;
  result := true;
end;

{--------------------------------------------}

function  TCustomMemoSource.GetStrCount : integer;
begin
  result := GetStrings.Count;
end;

{--------------------------------------------}

function TCustomMemoSource.IsValidBlockPos(X, Y : integer) : boolean;    
begin
  with GetSelectionRect do
    case FSelectionType of
      stNotSelected:
        result := true;
      stBlockSel:
        result := ((Y = Top) or (Y = Bottom)) and ((X = Left) or (X = Right));
      stStreamSel:
        result := ((Y = Top) and (X = Left)) or ((Y = Bottom) and (X = Right));
    else
      result := true;
    end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkLeft;
begin
 UnivMark(CursorLeft, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkRight;
begin
  UnivMark(CursorRight, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ClearSelection;
begin
  SelectionType := stNotSelected;
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkBriefColRight;
begin
  UnivMark(nil, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkBriefRight;
begin
  UnivMark(nil, stStreamSel);
end;

{--------------------------------------------}

function GetSearchOptions : TSearchOptions;
begin
  result := TSearchOptions(GetOptionsByClass(TSearchOptions));
end;

{--------------------------------------------}

function TCustomMemoSource.GetSearchOptions : TSearchOptions;
begin
  result := dcstring.GetSearchOptions;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetSearchOptions(V : TSearchOptions);
begin
  GetSearchOptions.Assign(V);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkUp;
begin
  UnivMark(CursorUp, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkDown;
begin
  UnivMark(CursorDown, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColLeft;
begin
  UnivMark(CursorLeft, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColRight;
begin
  UnivMark(CursorRight, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColUp;
begin
  UnivMark(CursorUp, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColDown;
begin
  UnivMark(CursorDown, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetSelectionRect(const Value : TRect);
begin
  BeginUpdate(acSetSelRect);
  with Value do
  begin
    FTopLeft.SetPosition(Left, Top);
    FBottomRight.SetPosition(Right, Bottom);
  end;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetFoundRect(const Value : TRect);
begin
  BeginUpdate(acSetSelRect);
  FFoundRect := Value;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.CheckSelectionType(var SelType : TSelectionType);
begin
  if SelType <> stNotSelected then
  begin
    if FBlockOption = bkNone then
      SelType := stNotSelected
    else
    if FBlockOption = bkStreamSel then
      SelType := stStreamSel
    else
    if FBlockOption = bkBlockSel then
      SelType := stBlockSel;
  end;
  if Assigned(FOnGetSelectionType) then
    FOnGetSelectionType(Self, SelType);
end;

{--------------------------------------------}

procedure TCustomMemoSource.UnivMark(MoveProc : TObjProc; NewSelType : TSelectionType);
var
  NewChar    : integer;
  NewLine    : integer;
  CurLine    : integer;
  CurChar    : integer;
  O          : TPoint;
  FSelection : TRect;
begin

  CheckSelectionType(NewSelType);
  BeginUpdate(acUnivMark);
  CurChar := GetCurChar;
  CurLine := GetCurLine;
  FSelection := GetSelectionRect;

  with FSelection do
  begin
    if (FSelectionType = stNotSelected)  or (not isValidBlockPos(CurChar, CurLine)) then
    begin
      with FSelection do
      begin
        Top := CurLine;
        Bottom := CurLine;
        Left := CurChar;
        Right := CurChar;
      end;
      if Assigned(MoveProc) then
        MoveProc;
      NewChar := GetCurChar;
      NewLine := GetCurLine;
      if NewLine = CurLine then
      begin
        if NewChar > CurChar then
          Right := NewChar
        else
          Left :=  NewChar;
      end
      else
      if NewLine < CurLine then
      begin
        Top := NewLine;
        Left := NewChar;
      end
      else
      if NewLine > CurLine then
      begin
        Bottom := NewLine;
        Right := NewChar;
      end;
    end
    else
    begin
      if Assigned(MoveProc) then
        MoveProc;
      if (NewSelType = stBlockSel) then
      begin
        NewChar := GetCurChar;
        NewLine := GetCurLine;
        if Left = Right then
        begin
          if NewChar > Left then
            Right := NewChar
          else
            Left := NewChar;
        end
        else
        if Left < CurChar then
          Right := NewChar
        else
          Left := NewChar;
        if Top = Bottom then
        begin
          if NewLine > Top then
            Bottom := NewLine
          else
            Top := NewLine;
        end
        else
        if Top < CurLine then
          Bottom := NewLine
        else
          Top := NewLine;

        SwapMaxInt(Left, Right);
        SwapMaxInt(Top,Bottom);
      end
      else
      begin
        if (CurChar = Left) and (CurLine = Top) then
        begin
          Top := GetCurLine;
          Left := GetCurChar;
        end
        else
        begin
          Right := GetCurChar;
          Bottom := GetCurLine;
        end;
        if (Top > Bottom) or ((Left > Right) and (Top = Bottom) ) then
        begin
          O := TopLeft;
          TopLeft := BottomRight;
          BottomRight := O;
        end;
      end;
    end;
    SelectionRect := FSelection;
    FSelectionType := NewSelType;
  end;
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.DiscardTrailingTabs(WithUndo : boolean);
var
  s       : string;
  trims   : string;
  len     : integer;
  OldChar : integer;
begin
  if FLeaveSpacesAndTabs  then
    exit;
  with TInternalStrings(GetStrings), CaretPoint do
  begin
    s := GetRealString(Y);
    trims := _TrimRight(s);
    len := _Length(s) - _Length(trims);
    if len > 0 then
    begin
      Self.BeginUpdate(acDeleteRight);
      if WithUndo then
      begin
        OldChar := FPosition.CharPos;
        JumpToLineEnd;
        DeleteRight(len);
        JumpToChar(OldChar);
      end
      else
        GetStrings[Y] := trims;
      UpdateString(Y);
      if StoreColorData then
        CheckStringItem(StringItem[Y]);
      Self.EndUpdate;
    end;
  end;
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.ChangeTabString(var s : string; Index : integer; var Count : integer) : integer;
begin
  result := ChangeTabStringEx(s, Index, Count, ' ');
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.ChangeTabStringEx(var s : string; Index : integer; var Count : integer; ch : char) : integer;
begin
  delete(S, Index, 1);
  while Index - 1 >= GetVirtualTabStop(Count) do
    inc(Count);
  result := GetVirtualTabStop(Count) - Index + 1;
  System.Insert(StringOfChar(ch, result), S, Index);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetRealTabIndex(const s : string; Index : integer) : integer;
begin
  result := Index;
  ChangeTabIndex(s, result);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetRelativeTabIndex(const s : string; Index : integer) : integer;
begin
  result := _Length(ExpandTabString(copy(s, 1, Index)));
end;

{-------------------------------------------------------------}

function TCustomMemoSource.ExpandTabString(const s : string) : string;
begin
  result := s;
  CheckForTabs(Self, result);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.CheckForTabs(Sender : TObject; var S : string);
var
  P   : integer;
  i   : integer;
begin
  P := TabPos(S, 0);
  i := 0;
  while P <> 0 do
  begin
    ChangeTabString(s, p, i);
    P := TabPos(S, P + 1);
  end;
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.InsertWithTabs(Source, ColorSrc : string ; var Dest, ColorDest : string; Index : integer) : integer;
var
  s    : string;
  P    : integer;
  len  : integer;
  i    : integer;
begin
  s := Dest;
  P := TabPos(s, 0);
  result := Index;
  i := 0;
  while (P <> 0) and (P < Index) do
  begin
    len := ChangeTabString(s, p, i);
    if Index - P < len then
    begin
      dec(result, Index - P);
      Source := StringOfSpace(Index - P) + Source;
      if ColorSrc <> '' then
        ColorSrc := StringOfChar(Source[1], Index - P) + ColorSrc;
      break;
    end
    else
      dec(result, len - 1);
    P := TabPos(S, P + 1);
  end;
  System.Insert(Source, Dest, result);
  if ColorSrc <> '' then
    System.Insert(ColorSrc, ColorDest, result);
  result := _Length(Source);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ChangeTabIndex(s : string; var Index : integer);
var
  len  : integer;
  P    : integer;
  idx  : integer;
  i    : integer;
begin
  P := TabPos(s, 0);
  idx := Index;
  i := 0;
  while (P <> 0) and (P < Index) do
  begin
    len := ChangeTabString(s, p, i);
    if Index - P < len then
      dec(idx, Index - P)
    else
      dec(idx, len - 1);
    P := TabPos(S, P + 1);
  end;
  Index := idx;
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.GetSpecialString(Index :integer; UseSpecialChars : boolean; SpaceChar, TabChar : char) : string;

  {-----------------------------------------------------}

  procedure ChangeTabs;
  var
    P   : integer;
    i   : integer;
    len : integer;
  begin
    begin
      P := TabPos(result, 0);
      i := 0;
      while P <> 0 do
      begin
        len := ChangeTabString(result, p, i) div 2;
        result[p + Max(len - 1, 0)] := TabChar;
        P := TabPos(result, P + 1);
      end;
    end;
  end;

  {-----------------------------------------------------}

  procedure CheckSpaces;
  var
    P : integer;
  begin
    P := SpacePos(result, 0);
    while P <> 0 do
    begin
      result[P] := SpaceChar;
      P := SpacePos(result, P + 1);
    end;
  end;

  {-----------------------------------------------------}

begin
  if UseSpecialChars and ((SpaceChar <> #0) or (TabChar <> #0)) then
  begin
    if StringItem[Index] <> nil then
      result := StringItem[Index].StrData
    else
      result := '';
    if result <> '' then
    begin
      if SpaceChar <> #0 then
        CheckSpaces;

      if TabChar <> #0 then
        ChangeTabs
      else
        CheckForTabs(Self, result);
    end;    
  end
  else
    result := Strings[Index];
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.GetTabDelta(CharPos, LinePos  : integer; direction : boolean; var delta : integer) : boolean;
var
  P   : integer;
  i   : integer;
  len : integer;
  s   : string;
begin
  result := false;
  delta := 1;
  S := TInternalStrings(GetStrings).GetRealString(LinePos);
  P := TabPos(S, 0);
  i := 0;
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    CharPos := _CharToByte(Strings[LinePos], CharPos + 1) - 1;
  {$ENDIF}
  while P <> 0 do
  begin
    len := ChangeTabString(s, p, i);
    if direction then
    begin
      if (P <= CharPos + 1) and (CharPos + 1 < P + len) then
      begin
        delta := len - (CharPos - P + 1);
        result := true;
        break;
      end;
      if P > CharPos + 1 then
        break;
    end
    else
    begin
      if (P <= CharPos) and (CharPos  < P + len) then
      begin
        delta := CharPos + 1 - P;
        result := true;
        break;
      end;
      if P > CharPos then
        break;
    end;
    P := TabPos(S, P + 1);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.UpdateSavedPos;
begin
  if FSafeupdate then
  begin
    _OSelection := FSelectionType;
    _OTopLeft.Assign(FTopLeft);
    _OBottomRight.Assign(FBottomRight);
    _Position.Assign(FPosition);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.BeginUpdate(ACode : integer);
begin
  if FUpdateCount = 0 then
  begin
    FOldCount := GetStrings.Count;
    FState := [];
    OFoundRect := FFoundRect;
    FFoundRect := Rect(0, 0, 0, 0);
    FFirstChanged := MaxInt;
    FLastChanged := - MaxInt;
    FFirstRecord := true;
    FChangedLine := - 1;
    FCode := ACode;
    OModified := FModified;

    FoTopLeft.Assign(FTopLeft);
    FoBottomRight.Assign(FBottomRight);
    FOSelectionType := FSelectionType;
    with FPosition do
    begin
      OCharPos := CharPos;
      OLinePos := LinePos;
    end;
    Inc(FUpdateCount);
    TempUnhighlightLine;
  end
  else
    Inc(FUpdateCount);

end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.TempUnhighlightLine;
begin
  if FTempHighlightStr > 0 then
  begin
    LineTextStyle[FTempHighlightStr - 1] := FTempHighlightIdx;
    FTempHighlightStr := 0;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.BeginSafeUpdate(ACode : integer);
begin
  if FUpdateCount = 0 then
  begin
    _OSelection := FSelectionType;
    _OTopLeft := CopyPosition(FTopLeft);
    _OBottomRight := CopyPosition(FBottomRight);
    _Position := CopyPosition(FPosition);
    FSafeUpdate := true;
  end;
  BeginUpdate(ACode);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.StoreColorData : boolean;
begin
  result := (SyntaxParser <> nil) and SyntaxParser.StoreColorData;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ParserChanged;
var
  i         : integer;
  StoreData : boolean;
begin
  if csDestroying in ComponentState then
    exit;
  StoreData := StoreColorData;
  BeginUpdate(acParserChanged);
  Include(FState, msParserChanged);
  with TInternalStrings(GetStrings) do
    for i := 0 to Count - 1 do
      with FList[i] do
      begin
        FItemState := FList[i].FItemState - [isWasParsed];
        if not StoreData then
          FColorData := '';
        FLineHeight := 0;
        FLineWidth := 0;
        FBaseLine := 0;
      end;
  FNotParsedStr := 0;
  ReCalculateMaxLine;
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.EndUpdate;

  {----------------------------------------------------}

  procedure UpdateSelRange;
  var
    MinLine : integer;
    MaxLine : integer;

    procedure UpdateMinMaxLine(P1, P2 : TPosition);
    begin
      if not P1.SameAs(P2) then
      begin
        MinLine := Min(MinLine, Min(P1.LinePos, P2.LinePos));
        MaxLine := Max(MaxLine, Max(P1.LinePos, P2.LinePos));
      end;
    end;

    procedure UpdateAll;
    begin
      MinLine := Min(FoTopLeft.LinePos, FTopLeft.LinePos);
      MaxLine := Max(FoBottomRight.LinePos, FBottomRight.LinePos);
    end;

  begin
    MinLine := MaxInt;
    MaxLine := - MaxInt;

    Include(FState, msBlockChanged);

    if (FOSelectionType <> FSelectionType) or((FSelectionType = stBlockSel) and
       ((FTopLeft.CharPos <> FOTopLeft.CharPos) or(FBottomRight.CharPos <> FOBottomRight.CharPos))) then
      UpdateAll
    else
    begin
      UpdateMinMaxLine(FOTopLeft, FTopLeft);
      UpdateMinMaxLine(FOBottomRight, FBottomRight);
    end;
    UpdateChangedLines(MinLine, MaxLine);
  end;

 {----------------------------------------------------}

  procedure UpdateFoundRect;

    procedure SetMinMax(const R : TRect);
    begin
      with R do
        UpdateChangedLines(Top, Bottom);
    end;

    var
      R:TRect;

  begin
    if not EqualRect(OFoundRect, FFoundRect) then
    begin
      Include(FState, msFoundRectChanged);
      if IsRectEmpty(FFoundRect) then
        SetMinMax(OFoundRect)
      else
      if IsRectEmpty(OFoundRect) then
        SetMinMax(FFoundRect)
      else
        begin
          UnionRect(R, OFoundRect, FFoundRect);
          SetMinMax(R);
        end;
    end;
  end;
  {----------------------------------------------------}

  function EqualSelections : boolean;
  begin
    result:=(FTopLeft.SameAs(FoTopLeft)) and (FBottomRight.SameAs(FoBottomRight));
  end;

  {----------------------------------------------------}

begin
  if FSafeUpdate and (FUpdateCount = 1) then
  begin
    FSelectionType :=_OSelection;
    FTopLeft.Assign(_OTopLeft);
    FBottomRight.Assign(_OBottomRight);
    _OTopLeft.Free;
    _OBottomRight.Free;
    RestorePosition(_Position);
    FSafeUpdate := false;
  end;

  if FUpdateCount > 0 then
  begin
    dec(FUpdateCount);
    if FUpdateCount = 0 then
    begin
      with FPosition do
        if (CharPos <> OCharPos) or (LinePos <> OLinePos) or FGotoBookMark then
          Include(FState, msPositionChanged);

      if (FSelectionType <> stNotSelected) and IsBlockEmpty(FSelectionType) then
        FSelectionType := stNotSelected;

      if ([msEdited, msPositionChanged] * FState <> []) and (not (msUndo in FState)) then
        ClearRedoBuffer;

      if (FOSelectionType <> FSelectionType) then
        UpdateSelRange
      else
      if (FOSelectionType <> stNotselected) then
      begin
        if Not EqualSelections then
          UpdateSelRange
        else
        if (not (soPersistentBlocks in FOptions)) and (msPositionChanged in FState) and (FSkipClearSelection = 0) then
        begin
          FSelectionType := stNotSelected;
          UpdateSelRange;
        end;
      end;

      UpdateFoundRect;

      if FOldCount <> GetStrings.Count then
        Include(FState, msCountChanged);

      if msEdited in FState then
      begin
        FModified := true;
        FNotParsedStr := Min(FNotParsedStr, FirstChanged);
      end;

      if msParserChanged in FState then
      begin
        FNotParsedStr := 0;
        FFirstChanged := 0;
        FLastChanged := MaxInt;
      end;

      if FModified <> OModified then
        Include(FState, msModifiedChanged);


      if FState <> [] then
        NotifyEvents(FFirstChanged, FLastChanged);

    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.NotifyEvents(AFirstChanged, ALastChanged : integer);
begin
  FNotifiers.NotifyEvents(Self, AFirstChanged, ALastChanged);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.BeginUndoBlock;
begin
  inc(FUndoBlockCount);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.EndUndoBlock;
begin
  dec(FUndoBlockCount);
  if (FUndoBlockCount = 0) and FAllowUndo then
    with CreateNewUndoRecord(soNavigate)^ do
    begin
      FDeltaLine := 0;
      FDeltaChar := 0;
    end;
end;

{-------------------------------------------------------------}

function ExpandString(const S : string; Margin : integer) : string;

type
  TIntArray = array[0..1] of integer;
  PIntArray = ^TIntArray;

var
  slen       : integer;
  spaces     : PIntArray;
  spacecount : integer;
  addspace   : integer;
  addcount   : integer;
  spacestr   : string;
  xcount     : integer;
  i          : integer;
begin
  result := _Trim(s, true, tdRight);
  slen := length(result);
  if slen < Margin then
    begin
      GetMem(spaces, slen * sizeof(integer));
      try
        spacecount := 0;
        i := 1;
        while (i <= slen) and (s[i] = ' ') do
          inc(i);
        while i <= slen do
        begin
          {$IFDEF DCMBCS}
          if SysLocale.FarEast and (s[i] in LeadBytes) then
          begin
            inc(i, 2);
            continue;
          end;
          {$ENDIF}
          if s[i] = ' ' then
            begin
              spaces[spacecount] := i;
              inc(spacecount);
            end;
          inc(i);
        end;

        if spacecount = 0 then
          exit;

        addspace := margin - slen;
        addcount := addspace div spacecount;
        xcount := addspace mod spacecount;
        spacestr := StringOfSpace(addcount + 1);
        for i := 1 to xcount do
          insert(spacestr, result, spaces^[spacecount - i]);

        delete(spacestr, 1, 1);

        for i := xcount to spacecount - 1 do
          insert(spacestr, result, spaces^[spacecount - i - 1]);

      finally
        FreeMem(spaces);
      end;
    end;
end;

{-------------------------------------------------------------}

function ExpandStrings(Strings : TStrings ; Margin : integer) : string;
var
  i : integer;
begin
  with Strings do
  begin
    BeginUpdate;
    try
      for i := 0 to Count -1 do
        Strings[i] :=  ExpandString(Strings[i], Margin);
    finally
      EndUpdate;
    end;
  end;    
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CurrentRedoList : TUndoList;
begin
  if FUseRedo then
    result := FUndoList
  else
    result := FRedoList;

end;

{-------------------------------------------------------------}

function TCustomMemoSource.CurrentUndoList : TUndoList;
begin
  if FUseRedo then
    result := FRedoList
  else
    result := FUndoList;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SetAllowUndo(Value : boolean);
begin
  if FAllowUndo <> Value then
  begin
    FAllowUndo := Value;
    if not Value then
      ClearUndoBuffer;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SetUndoLimit(Value : integer);
begin
  Value := Max(0, Value);
  if FUndoLimit <> Value then
  begin
     FUndoLimit := Value;
     CheckUndoLimit;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.CheckUndoLimit;
var
  Index  : integer;
  ACount : integer;
begin
  if FUseRedo or not FAllowUndo or (FUndoLimit = 0) then
    exit;
  with FUndoList do
  begin
    ACount := Count - cFloatDelta;
    if ACount > FUndoLimit then
    begin
      Index := Count - FUndoLimit - 1;
      while (Index > 0) and PUndoRecord(Items[Index])^.FInUndoBlock do
        dec(Index);
      if Index > 0 then
      begin
        dec(FSaveModifiedIdx, Index + 1);
        if FSaveModifiedIdx < 0 then
        begin
          FSaveModifiedIdx := -1;
          FSaveModified := FindModifiedRecord(Index + 1) >= 0;
        end;
        ClearToIndex(Index);
      end;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.MoveColorData(const Source : string; var Destination : string; LinePos, CharPos : integer);
var
  Len : integer;
  S   : string;
begin
  Len := Length(Source);
  S := Copy(Destination, CharPos, Len);
  if S <> Source then
  begin
    Delete(Destination, CharPos, Len);
    System.Insert(Source, Destination, CharPos);
    ColorDataChanged(S, LinePos, CharPos);
  end;  
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ColorDataChanged(const S : string; LinePos, CharPos : integer);
begin
  if FAllowUndo then
    with CreateNewUndoRecord(soUpdateColorData)^ do
    begin
      FColorData := s;
      FDeltaLine := LinePos;
      FDeltaChar := CharPos;
    end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CreateNewUndoRecord(AOperation : TStringsOperation) : PUndoRecord;
begin
  if not FAllowUndo then
    result := nil
  else
  begin
    CheckUndoLimit;
    result := CurrentUndoList.AddUndoRecord;
    with result^ do
    begin
      FOperation := AOperation;
      FirstRecord := FFirstRecord;
      FOpCode := FCode;
      FInUndoBlock := FUndoBlockCount > 0;
    end;
    FFirstRecord := false;
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.ChangeDeltaLine(ADeltaLine : integer) : integer;
begin
  result := ADeltaLine;
  with FPosition, GetStrings do
    if (not (soBeyondFileEnd in FOptions)) and (LinePos + ADeltaLine >= Count) then
    begin
      result := - LinePos + Count;
      if Count > 0 then
        Dec(result);
    end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetNavigation(var DeltaLine, DeltaChar : integer) : TPoint;
begin
  if Assigned(FOnNavigate) then
    FOnNavigate(Self, DeltaLine, DeltaChar);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.GetLineHeight(Index : integer; Item : TStringItem);
begin
  if (Item <> nil) and Assigned(FOnGetLineHeight) then
    FOnGetLineHeight(Self, Index, Item);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetMemoIndent(Indent : integer) : integer;
begin
  result := Indent;
  FMemoGetIndent := true;
  try
    GetNavigation(Indent, result);
  finally
    FMemoGetIndent := false;
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.RealToVisibleIndex(Index : integer) : integer;
begin
  result := FVisibleLinesList.RealToVisibleIndex(Index);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.VisibleToRealIndex(Index : integer) : integer;
begin
  result := FVisibleLinesList.VisibleToRealIndex(Index);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.Navigate(ADeltaLine, ADeltaChar : integer);
var
  ALen : integer;

begin
//  if ADeltaLine <> 0 then
//    DiscardTrailingTabs(false);

  GetNavigation(ADeltaLine, ADeltaChar);


  with FPosition do
  begin
    if ADeltaLine < 0 then
      ADeltaLine := max(- LinePos, ADeltaLine);
    if ADeltaChar < 0 then
      ADeltaChar := max(- CharPos, ADeltaChar);


    ADeltaLine := ChangeDeltaLine(ADeltaLine);

    if (soLimitEOL in FOptions) then
    begin
      ALen := _Length(Strings[LinePos + ADeltaLine]);
      if (CharPos + ADeltaChar > ALen ) then
          ADeltaChar := - CharPos + ALen
    end;

    if soCursorAlwaysOnTabs in FOptions then
      CheckDeltaChar(LinePos + ADeltaLine, CharPos, ADeltaChar);

    if (ADeltaChar = 0) and (ADeltaLine = 0) and not FGotoBookMark then
      exit;

    BeginUpdate(acNavigate);

    if ADeltaLine <> 0 then
      DiscardTrailingTabs(false);

    if FAllowUndo then
      with CreateNewUndoRecord(soNavigate)^ do
      begin
        FDeltaLine := ADeltaLine;
        FDeltaChar := ADeltaChar;
      end;

    inc(CharPos, ADeltaChar);
    inc(LinePos, ADeltaLine);
    if ManualPosition and not GetRealLineVisible(LinePos) then
      ExpandPrevLine(LinePos);
    EndUpdate;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ExpandPrevLine(LinePos : integer);
var
  i : integer;
begin
  for i := LinePos - 1 downto 0 do
    if CollapseState[i] = csCollapsed then
    begin
      CollapseState[i] := csExpanded;
      break;
    end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.AllowUpdate(Sender : TObject; var AllowX, AllowY : boolean);
begin
  if (Sender = FTopLeft) or (Sender = FBottomRight) then
  begin
    AllowX := FSelectionType <> stBlockSel;
    AllowY := AllowX;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.UpdatePositions(AOperation : TStringsOperation; StrLength : integer);
var
  i        : integer;
  AllowX   : boolean;
  AllowY   : boolean;
  Position : TPosition;
  procedure UpdateX(var XA, YA : integer);
  begin
    case AOperation of
      soInsert:
        Inc(XA, Strlength);
      soDeleteRight:
        begin
          Dec(XA, StrLength);
          XA := Max(XA, FPosition.CharPos);
        end;
    end;
  end;

  function ComparePos(A, B : integer; aPos : TObject) : boolean;
  begin
    if aPos  = FTopLeft then
      result := A <= B
    else
      result := A < B;
  end;

  procedure UpdateY(var XA, YA : integer; aPos : TObject);
  var
    Delta : integer;
  begin
    case AOperation of
      soBreakLine:
        begin
          Delta := XA - FPosition.CharPos;
          if (FPosition.LinePos = YA) and ComparePos(0, Delta, APos) then
            XA := Delta;
          if ComparePos(0, Delta, APos) or (FPosition.LinePos < YA) then
            inc(YA);
        end;
      soJoinLines:
        begin
          Delta := YA - FPosition.LinePos;
          if (Delta = 1) then
            Inc(XA, FPosition.CharPos);
          if (Delta = 0)then
          begin
            if XA >= FPosition.CharPos then
              XA := FPosition.CharPos;
          end
          else
            dec(YA);
        end;
    end;
  end;


begin
  for i := 0 to FPositions.Count - 1 do
  begin
    Position := TPosition(FPositions.Items[i]);
    with  Position do
    begin
      if Assigned(FOnAllowUpdate) and (FPosition.LinePos <= LinePos) then
      begin
        AllowX := true;
        Allowy := true;
        OnAllowUpdate(Position, AllowX, AllowY);
        if (AllowX) and (FPosition.LinePos = LinePos) and (ComparePos(FPosition.CharPos , CharPos, Position)) then
          UpdateX(CharPos, LinePos);
        if AllowY then
          UpdateY(CharPos, LinePos, Position);
        CharPos := Max(0, CharPos);
        LinePos := Max(0, LinePos);
      end;
    end;
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.AfterLastLine : boolean;
begin
  result := FPosition.LinePos >= GetStrings.Count;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.ReadOnlyLine : boolean;
begin
  result := (GetReadOnly) or (isReadOnly in TInternalStrings(GetStrings).FList[FPosition.LinePos].FItemState);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.ReadOnlyNextLine : boolean;
begin
  result := (GetReadOnly) or (isReadOnly in TInternalStrings(GetStrings).FList[FPosition.LinePos + 1].FItemState);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ParseUrl(LinePos : integer; const s: string; var ColorData : string);
var
  posbegin : integer;
  posend   : integer;
  lens     : integer;
  str      : string;
  ASet     : TCharSet;
begin

  lens := Length(s);
  if FInColorUpdate or (length(ColorData) <> lens) then
    exit;
  posbegin := 1;
  ASet := cOtherIdentChars + HotCharSet;
  while posbegin <= lens do
  begin
    while (posbegin <= lens) and not (s[posbegin] in ASet) do
    begin
      {$IFDEF DCMBCS}
      if SysLocale.FarEast and (s[posbegin] in LeadBytes) then
        inc(posbegin);
      {$ENDIF}
      inc(posbegin);
    end;
    posend := posbegin;

    ASet := cOtherIdentChars + cHotSpotChars;

    while (posend <= lens) and (s[posend] in cOtherIdentChars + cHotSpotChars) do
    begin
      {$IFDEF DCMBCS}
      if SysLocale.FarEast and (s[posend] in LeadBytes) then
        inc(posend);
      {$ENDIF}
      inc(posend);
    end;

    str := Copy(s, posbegin , posend - posbegin + 1);

    if IsStringHot(str) then
    begin
      if StoreColorData then
        MoveColorData(StringOfChar(char(tokUrl), posend - posbegin), ColorData, LinePos, posbegin)
      else
        FillChar(ColorData[posbegin], posend - posbegin , tokUrl);
    end;
    posbegin := posend;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SetHighLightUrls(Value : boolean);
begin
  if FHighLightUrls <> Value then
  begin
    FHighLightUrls := Value;
    ParserChanged;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SetBlockOption(Value : TBlockOption);
begin
  if FBlockOption <> Value then
  begin
    FBlockOption := Value;
    if (SelectionType = stStreamSel) and (Value = bkBlockSel) then
      SelectionType := stBlockSel
    else
    if (SelectionType = stBlockSel) and (Value = bkStreamSel) then
      SelectionType := stStreamSel
    else
    if (SelectionType <> stNotSelected) and (Value = bkNone) then
      SelectionType := stNotSelected;
  end;
end;

{-------------------------------------------------------------}

type
  TMParser = class(TSimpleParser);

procedure TCustomMemoSource.AfterParse(LinePos : integer; var S, ColorS : string);
begin
 if Assigned(FOnAfterParse) then
   FOnAfterParse(Self, LinePos, S, ColorS);
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.ParseStrings(FromIndex, ToIndex : integer; NeedParse : boolean) : integer;
var
  i        : integer;
  NewState : integer;
  Leng     : integer;
begin
   result := FChangedLine;
   ToIndex := Min(ToIndex, GetStrings.Count - 1);
   FromIndex := Max(FromIndex, 0);

   if (FromIndex <= ToIndex) then
     if (FSyntaxParser <> nil) then
       with TMParser(FSyntaxParser), TInternalStrings(GetStrings) do
       begin
         if FromIndex > 0 then
           NewState := FList[FromIndex - 1].FParserState
         else
           NewState := FDefaultParserState;
         for i := FromIndex to ToIndex do
           with FList[i] do
             if (not (isWasParsed in FItemState)) or (FBeforeState <> NewState) then
             begin
               PrepareColorData(i, StrData, FColorData);
               FBeforeState := NewState;
               UpdateLinePos(i);
               NewState := ColorString(StrData, NewState, FColorData);
               FItemState := FItemState + [isWasParsed];

               AfterParse(i, FString, FColorData);

               if FHighlightUrls then
                 ParseUrl(i, StrData, FColorData);
               if NewState <> FParserState then
               begin
                 result := Max(result, i + 1);
                 FParserState := NewState;
               end;
               GetLineHeight(i, FList[i]);
             end
             else
               NewState := FParserState;
         FNotParsedStr := ToIndex + 1;
         FChangedLine := result;
       end
     else
     if FHighlightUrls or NeedParse then
     begin
       with TInternalStrings(GetStrings) do
         for i := FromIndex to ToIndex do
           with FList[i]  do
           if (not (isWasParsed in FItemState)) then
             begin
               if FHighlightUrls then
               begin
                 Leng := Length(StrData);
                 Setlength(FColorData, Leng);
                 if Leng > 0 then
                   FillChar(FColorData[1], Leng, 0);
                 ParseUrl(i, StrData, FColorData);
               end
               else
                 FColorData := '';
               FItemState := FItemState + [isWasParsed];
               AfterParse(i, FString, FColorData);
               GetLineHeight(i , FList[i]);
             end;
       FNotParsedStr := ToIndex + 1;
       FChangedLine := result;
     end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.ParseToString(Index : integer; NeedParse : boolean) : integer;
begin
  if (FNotParsedStr <= Index) and (Index < MaxInt - cFloatDelta) then
    inc(Index, cFloatDelta);
  result := ParseStrings(FNotParsedStr, Index, NeedParse)
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.CheckColorData(S : string; var Cs : string);
var
  P   : integer;
  i   : integer;
  ch  : char;
begin
  P := TabPos(S, 0);
  i := 0;
  while P <> 0 do
  begin
    ChangeTabString(s, p, i);
    if P <= length(Cs) then
      ch := Cs[p]
    else
      ch := #0;
    ChangeTabStringEx(Cs, p, i, ch);
    P := TabPos(S, P + 1);
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetStoredColorData(Index : integer) : string;
begin
  if (Index < 0) or (Index >= GetStrings.Count)
  then
    result := ''
  else
  with TInternalStrings(GetStrings).FList[Index] do
  begin
    result := GetColorData(Index);
    CheckColorData(StrData, result);
  end;  
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetColorData(Index : integer) : string;
begin
  if (Index < 0) or (Index >= GetStrings.Count) then
    result := ''
  else
  with TInternalStrings(GetStrings).FList[Index] do
    begin
      if not (isWasParsed in FItemState) then
        ParseToString(Index, false);
      result := FColorData;
    end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.MoveLineProps(FromLine, ToLine : integer);
begin
  AssignLineProps(FromLine, ToLine);
  with TInternalStrings(GetStrings), List[FromLine] do
  begin
    FImageBits := 0;
    FTextStyle := 0;
    FObject := nil;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.AssignLineProps(FromLine, ToLine : integer);
begin
  with TInternalStrings(GetStrings), List[ToLine] do
  begin
    FImageBits := FImageBits or List[FromLine].FImageBits;
    if FTextStyle = 0 then
      FTextStyle := List[FromLine].FTextStyle;
    if FObject = nil then
      FObject := List[FromLine].FObject;
  end;
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.GetStrAddr(Index : integer) : PChar;
begin
  result := PChar(GetStrings[Index]);
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.GetMaxLen(LinePos : integer) : integer;
var
  Item : TStringItem;
begin
  if Assigned(FOnGetLineHeight) then
  begin
    Item := StringItem[LinePos];
    if Item <> nil then
       with Item do
       begin
         if not (isWasParsed in ItemState) then
           if (SyntaxParser <> nil) or FHighlightUrls then
             ParseStrings(LinePos, LinePos, true)
           else
             GetLineHeight(LinePos, Item);
         result := FLineWidth
       end
     else
       result := 0;
  end
  else
    result := 0;
  if result = 0 then
    result := length(Strings[LinePos]);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.CheckStringItem(Item : TStringItem);
var
  Len  : integer;
  Lens : integer;
begin
  if Item = nil then
    exit;
  with Item do
  begin
    Lens := Length(StrData);
    Len := Lens - length(FColorData);
    if Len > 0 then
      FColorData := FColorData + StringOfChar(#0, Len)
    else
    if Len < 0 then
      FColorData := Copy(ColorData, 1, Lens);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JoinLines;
var
  CharPos : integer;
  LinePos : integer;
  len     : integer;
  TempStr : string;
  Item    : TStringItem;
  ch      : char;
begin

  CharPos := FPosition.CharPos;
  LinePos := FPosition.LinePos;

  with TInternalStrings(GetStrings) do
  begin
    TempStr := GetRealString(LinePos);
    {$IFDEF DCMBCS}
    CharPos := _CharToByte(Strings[LinePos], CharPos + 1) - 1;
    {$ENDIF}
    ChangeTabIndex(TempStr, CharPos);
  end;

  if (msUndo in State) and (CharPos < Length(TempStr)) and (CharPos >= Length(_TrimRight(TempStr))) then
    SetLength(TempStr, CharPos);

  if (LinePos >= GetStrings.Count - 1) or (ReadOnlyLine) or (ReadOnlyNextLine) or
     (CharPos < Length(TempStr)) or (StrCount = 1)  then
    exit;
  BeginUpdate(acJoinLines);

  if isCollapsed in StringItem[LinePos].ItemState then
    CollapseState[LinePos] := csExpanded;

  if isCollapsed in StringItem[LinePos + 1].ItemState then
    CollapseState[LinePos + 1] := csExpanded;

  len := CharPos - Length(TempStr);

  with TInternalStrings(GetStrings) do
  begin
    GetStrings[LinePos] := TempStr + StringOfSpace(len) + GetRealString(LinePos + 1);
    if StoreColorData then
    begin
      Item := GetStringItem(LinePos);
      if (Item  <> nil) then
        with Item do
        begin
          if (FString = '') then
            FColorData := '';
          if FColorData <> '' then
            ch := FColorData[Length(FColorData)]
          else
            ch := #0;
          FColorData := FColorData + StringOfChar(ch, len);
          if GetStringItem(LinePos + 1) <> nil then
            FColorData := FColorData + GetStringItem(LinePos + 1).FColorData;
        end;
        CheckStringItem(Item);
    end;
  end;
  if CharPos = 0 then
    StringItem[LinePos].OldString := StringItem[LinePos + 1].OldString;
  //assign some parameters from prevstring to the current one
  AssignLineProps(LinePos + 1, LinePos);


  GetStringsDelete(LinePos + 1);
  DeleteLastEmptyLine;
  with FBookMarkList do
  begin
    CharChanged(LinePos + 1, 0, Length(TempStr) + len);
    LineChanged(LinePos, MaxInt, - 1);
  end;

  FVisibleLinesList.LineChanged(LinePos, - 1);

  // create undo record and update position list
  if FAllowUndo then
    CreateNewUndoRecord(soJoinLines);

  UpdatePositions(soJoinLines, 0);

  UpdateChanged(LinePos, MaxInt);

  if  FNeedMaxLineUpdate then
  begin
    len := GetMaxLen(LinePos);
    if (FMaxLineLen <= len) then
    begin
      FMaxLineLen := len;
      FMaxLineLenIdx := LinePos;
    end
    else
      if LinePos <= FMaxLineLenIdx then
      begin
        dec(FMaxLineLenIdx);
        if FMaxLineLenIdx = - 1 then
          ReCalculateMaxLine;
      end;
  end;
  EndUpdate;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CheckOverwriteBlock:boolean;
begin
  result := (FUpdateCount<=1) and (soOverwriteBlocks in FOptions) and
  (not (soPersistentBlocks in FOptions)) and (FSelStrings.Count > 0);
  if result then
    DeleteBlock;
end;

{-------------------------------------------------------------}


procedure TCustomMemoSource.BreakLine;
var
  TempStr   : string;
  s         : string;
  CharPos   : integer;
  LinePos   : integer;
  AIndex    : integer;
  Item      : TStringItem;
  InsideStr : boolean;
  AState    : TStringItemStates;
begin

  if GetStrings.Count = 0 then
    GetStrings.Add('');

  if (AfterLastLine) or (ReadOnlyLine) then
    exit;
  BeginUpdate(acBreakLine);

  // get current line and char positions
  CharPos := FPosition.CharPos;
  LinePos := FPosition.LinePos;

  AState := StringItem[LinePos].ItemState;

  if isCollapsed in AState then
    CollapseState[LinePos] := csExpanded;

  // insert new line
  GetStringsInsert(LinePos + 1, '');

  if AState * [isHidden, isCollapsed, isExpanded]  <> [] then
    LineVisible[LinePos + 1] := false;

  with TInternalStrings(GetStrings) do
  begin
    TempStr := GetRealString(LinePos);
    {$IFDEF DCMBCS}
    s := Strings[LinePos];
    AIndex := _CharToByte(s, CharPos + 1) - 1;
    {$ELSE}
    AIndex := CharPos;
    {$ENDIF}
    ChangeTabIndex(TempStr, AIndex);
    inc(AIndex);
  end;

  // if breaked within the string then move text after current char pos
  // to next line


  if CharPos = 0 then
    StringItem[LinePos + 1].OldString := StringItem[LinePos].OldString;


  InsideStr := AIndex  <= Length(TempStr);

  if InsideStr then
  begin
    GetStrings[LinePos + 1] := Copy(TempStr, AIndex, MaxInt);
    s := Copy(TempStr, 1, AIndex - 1);
    GetStrings[LinePos] := s;
  end
  else
    s := '';

  if StoreColorData then
  begin
    Item := StringItem[LinePos];
    with Item do
    begin
      if (FColorData <> '') then
      begin
        if not ((msUndo in State) or FInImport) then
        begin
          FDefaultAttribute := byte(FColorData[Min(AIndex, Length(ColorData))]);
          FUseDefaultAttr := true;
        end;
        if InsideStr then
          with StringItem[LinePos + 1] do
            ColorData := Copy(Item.ColorData, AIndex, MaxInt);
      end;
      CheckStringItem(Item);
      CheckStringItem(StringItem[LinePos + 1]);
    end;
  end;

  with FBookMarkList do
  begin
    LineChanged(LinePos, CharPos, 1);
    CharChanged(LinePos + 1, CharPos - 1, - CharPos);
  end;
  FVisibleLinesList.LineChanged(LinePos, 1);

  UpdateString(LinePos);

  if (CharPos = 0) or (TempStr = '') then
    MoveLineProps(LinePos, LinePos + 1);
  if  FNeedMaxLineUpdate then
  begin
    if(FMaxLineLenIdx = LinePos) then
      ReCalculateMaxLine
    else
      if LinePos <= FMaxLineLenIdx then
        inc(FMaxLineLenIdx);
  end;

  // create undo record

  if FAllowUndo then
    CreateNewUndoRecord(soBreakLine);

  if not (msUndo in FState) then
    DiscardTrailingTabs(true);


  UpdatePositions(soBreakLine, 0);

  UpdateChanged(LinePos, MaxInt);
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.UpdateChanged(MinChange, MaxChange : integer);
begin
  Include(FState, msEdited);
  UpdateChangedLines(MinChange, MaxChange);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.UpdateChangedLines(MinChange, MaxChange : integer);
begin
  FFirstChanged := Min(MinChange, FFirstChanged);
  FLastChanged := Max(MaxChange, FLastChanged);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.UpdateString(LinePos : integer) : boolean;
var
  H      : integer;
  State  : integer;
  OldStr : integer;
begin
  result := false;
  if (FInImport and (LinePos = Lines.Count - 1)) or (StringItem[LinePos] = nil) then
  begin
    UpdateChanged(LinePos, LinePos);
    exit;
  end;
  with StringItem[LinePos] do
  begin
    H := FLineHeight;
    State := ParserState;
    //if FUpdateCount = 0 then
    OldStr := FNotParsedStr;
    UpdateChanged(LinePos, LinePos);
    ParseStrings(LinePos, LinePos, true);
    FNotParsedStr := OldStr;
    result := (State <> ParserState) and not StoreColorData;
    if not ((H = FLineHeight) and (State = ParserState)) then
      UpdateChanged(LinePos, MaxInt);
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.InsertEx(const S, ColorS : string) : integer;
begin
  FInternalData := ColorS;
  try
    Insert(S);
    result := FInsertedLen;
  finally
    FInternalData := '';
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetAttr(Point : TPoint) : byte;
var
  Item : TStringItem;
  s    : string;
begin
  result := 0;
  s := '';
  with Point do
  begin
    Item := GetStringItem(Y);
    if Item <> nil then
    begin

      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
        Point.X := _CharToByte(Strings[Y], Point.X);
      {$ENDIF}

      s := GetStoredColorData(Y);
      if FDefaultAttribute >= 0 then
        result := FDefaultAttribute
      else
      if s <> '' then
      begin
        if X <= 0 then
          X := 1
        else
        if X > length(s) then
          X := length(S);

        result := byte(s[X]);
        if result = tokUrl then
        begin
          while (X > 0) and (byte(s[X]) = tokUrl)  do
            dec(X);
          if X = 0 then
            result := 0
          else
            result := byte(s[X]);
        end;
      end;
    end;
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.Insert(const S : string) : boolean;
var
  CharPos   : integer;
  LinePos   : integer;
  TempStr   : string;
  ts        : string;
  len       : integer;
  lens      : integer;
  alen      : integer;
  ATrim     : boolean;
  StoreData : boolean;
  AUpdate   : boolean;
  Attr      : byte;
  ch        : char;
begin
  FInsertedLen := 0;
  result := false;
  if (S = '') then
    exit;

  while AfterLastLine do
    GetStrings.Add('');

  if (ReadOnlyLine) then
    exit;

  result := true;

  BeginUpdate(acInsert);

  // get current line and char positions
  CharPos := FPosition.CharPos;
  LinePos := FPosition.LinePos;

  // insert
  StoreData := StoreColorData;
  if StoreData then
    Attr := GetAttr(CaretPoint)
  else
    Attr := 0;
  with TInternalStrings(GetStrings) do
  begin
    TempStr := GetRealString(LinePos);
    ts := Get(LinePos);
    len := _Length(ts);
    FInsertedLen := Len;
    Atrim := len >= CharPos;
    if len < CharPos then
    begin
      TempStr := TempStr + StringOfSpace(CharPos - len);
      if StoreData then
        with Flist[LinePos] do
        begin
          {
          if len = 0 then
            ch := #0
          else}
          ch := char(Attr);
          FColorData := FColorData + StringOfChar(ch, CharPos - len);
        end;
      len := _Length(CheckForTabs(TempStr));
      FInsertedLen := Len;
    end
    else
    if Atrim then
      len := _Length(_TrimRight(ts));

    lens := _Length(s);

    if StoreColorData then
    begin
      alen := Length(s);
      if FInternalData <> '' then
        CheckLen(FInternalData, alen)
      else
      if s <> '' then
      begin
        SetLength(FInternalData, alen);
        FillChar(FInternalData[1], alen, Attr);
      end;
    end
    else
      FInternalData := '';

    {$IFDEF DCMBCS}
    alen := _CharToByte(ts, CharPos + 1);
    {$ELSE}
    alen := CharPos + 1;
    {$ENDIF}

    alen := InsertWithTabs(s, FInternalData, TempStr, Flist[LinePos].FColorData, alen);
    FInternalData := '';

    GetStrings[LinePos] := TempStr;
    if StoreData then
      CheckStringItem(FList[LinePos]);
  end;

  TempStr := GetStrings[LinePos];
  if Atrim then
    len := _Length(_TrimRight(TempStr)) - len
  else
    len := _Length(TempStr) - len;

  if TabPos(s, 1) = 0 then
    FInsertedLen := _Length(s)
  else
    FInsertedLen := _Length(TempStr) - FInsertedLen;

  if FAllowUndo then
    if alen <> lens then
    begin
      BeginUndoBlock;
      try
        with CreateNewUndoRecord(soNavigate)^ do
        begin
          FDeltaLine := 0;
          FDeltaChar := - (alen - lens);
        end;

        with CreateNewUndoRecord(soInsert)^ do
          FDeltaLine := alen;

        with CreateNewUndoRecord(soNavigate)^ do
        begin
          FDeltaLine := 0;
          FDeltaChar := alen - lens;
        end;
      finally
         EndUndoBlock;
      end;
    end
    else
      with CreateNewUndoRecord(soInsert)^ do
        FDeltaLine := alen;

  FBookmarkList.CharChanged(LinePos, CharPos, len);

  UpdatePositions(soInsert, len);

  AUpdate := UpdateString(LinePos);
  if FNeedMaxLineUpdate then
  begin
    if AUpdate then
      ReCalculateMaxLine
    else
    begin
      alen := GetMaxLen(LinePos);
      if alen > FMaxLineLen then
      begin
        FMaxLineLen := alen;
        FMaxLineLenIdx := LinePos;
      end;
    end;
  end;
  //UpdateString(LinePos);
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure  TCustomMemoSource.CheckDeltaChar(LinePos, CharPos : integer; var Delta : integer);
var
  S    : string;
  P    : integer;
  i    : integer;
  Len  : integer;
  APos : integer;
begin
  S := TInternalStrings(GetStrings).GetRealString(LinePos);
  P := TabPos(S, 0);
  i := 0;

  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    CharPos := _CharToByte(s, CharPos);
  {$ENDIF}

  APos := CharPos + Delta;
  while P <> 0 do
  begin
    len := ChangeTabString(s, p, i);
    if (P <= APos + 1) and (APos + 1 < P + len) then
    begin
      if abs(APos + 1 - P ) < abs(APos + 1 - (P + len)) then
        APos := P
      else
        APos := P + len;
      Delta := APos - CharPos - 1;
      break;
    end;
    P := TabPos(S, P + 1);
  end;
end;

{-------------------------------------------------------------}

{$IFDEF DCMBCS}

procedure TCustomMemoSource.DeleteRightEx(Number : integer);
var
  s     : string;
begin
  if SysLocale.FarEast and (Number < MaxInt) then
    with CaretPoint do
    begin
      with TInternalStrings(GetStrings) do
        s := GetRealString(Y);
      Number := _CharToByte(s, X + 1) + Number;
      if Number <= length(s) then
        Number := _ByteToChar(s, Number) - (X + 1);
    end;
  DeleteRight(Number);
end;
{$ENDIF}

{-------------------------------------------------------------}

procedure TCustomMemoSource.DeleteRight(Number : integer);
var
  CharPos    : integer;
  LinePos    : integer;
  delta      : integer;
  AUpdate    : boolean;

  {--------------------------------------------------}
  {$IFDEF DCMBCS}

  procedure _CheckForTabs(var S : string);
  var
    P   : integer;
    i   : integer;
  begin
    P := TabPos(S, 0);
    i := 0;
    while (P <> 0) and (P < CharPos + 1) do
    begin
      ChangeTabString(s, p, i);
      P := TabPos(S, P + 1);
    end;
  end;
  {$ENDIF}

  {--------------------------------------------------}

  procedure _DeleteStr;
  var
    TempStr    : string;
    s          : string;
    ts         : string;
    cs         : string;
    AIndex     : integer;
  begin
    with TInternalStrings(GetStrings) do
    begin
      TempStr := GetRealString(LinePos);

      {$IFDEF DCMBCS}
      if SysLocale.FarEast then
      begin
        s := TempStr;
        _CheckForTabs(s);
        AIndex := CharPos + 1;
        if Number < MaxInt then
          Number := _CharToByte(s, AIndex + Number);
        AIndex := _CharToByte(s, AIndex);
        if Number < MaxInt then
          dec(Number, AIndex);
      end
      else
        AIndex := CharPos + 1;
      {$ELSE}
        AIndex := CharPos + 1;
      {$ENDIF}

      dec(AIndex);
      ChangeTabIndex(TempStr, AIndex);
      inc(AIndex);

      s := Copy(TempStr, AIndex, Number);

      if Number <> MaxInt then
      begin
        ts := Copy(TempStr, 1, AIndex + Number - 1);
        ts :=  ts + StringOfSpace(Number - 1 - Length(ts) + AIndex);
      end
      else
        ts := TempStr;

      System.Delete(TempStr, AIndex, Number);

      if StoreColorData then
        with FList[LinePos] do
        begin
          cs := Copy(FColorData, AIndex, Number);
          System.Delete(FColorData, AIndex, Number);
        end;

      GetStrings[LinePos] := TempStr;
      if StoreColorData then
        CheckStringItem(FList[LinePos]);
    end;

    if FAllowUndo then
      with CreateNewUndoRecord(soDeleteRight)^ do
      begin
        FString := s;
        FColorData := cs;
      end;

    DeleteLastEmptyLine;

    CheckForTabs(Self, ts);

    AIndex := _Length(ts) - CharPos;
    UpdatePositions(soDeleteRight, AIndex);
    FBookmarkList.CharChanged(LinePos, CharPos + AIndex - 1, - AIndex);
    AUpdate := UpdateString(LinePos);
  end;

  {--------------------------------------------------}

begin
  // get current line and char positions
  CharPos := FPosition.CharPos;
  LinePos := FPosition.LinePos;

  if (Number <= 0) or (AfterLastLine) or (ReadOnlyLine) or (CharPos >= _Length(Strings[LinePos])) then
    exit;

  BeginUpdate(acDeleteRight);

  // save deleted substring to undo record

  GetTabDelta(CharPos + 1, LinePos, false, delta);
  dec(delta);
  if delta <> 0 then
  begin
    BeginUndoBlock;
    try
      Navigate(0, - delta);
      Insert(StringOfSpace(delta));
      Navigate(0, delta);
      _DeleteStr;
    finally
      EndUndoBlock;
    end;
  end
  else
    _DeleteStr;
  if  FNeedMaxLineUpdate and (AUpdate or (FMaxLineLenIdx = LinePos)) then
    ReCalculateMaxLine;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.DeleteLastEmptyLine;
begin
  with GetStrings do
    if (Count = 1) and (Strings[0] = '') then
    begin
      Delete(0);
      UpdateChanged(0, 0);
    end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetDelimeters(const V : string);
begin
  if FDelimeters <> V then
  begin
    FDelimeters := V;
    FDelimSet := StringToCharSet([#0..#32], V, true);
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetOldPosition : TPoint;
begin
  result := Point(OCharPos, OLinePos);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetTextAt(X, Y : integer) : string;
var
  ALeft  : integer;
  ARight : integer;
begin
  WordBounds(X, Y, ALeft, ARight, wsWordOnly);
  if (ARight > ALeft) or ((ARight = ALeft) and (ARight > 0)) then
    result := Copy(Strings[Y], ALeft , ARight - ALeft + 1)
  else
    result := '';
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetTextAtCursor : string;
begin
  result := GetTextAt(GetCurChar , GetCurLine);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.InDelimSet(const s : string; Index : integer) : boolean;
begin
  result := (s[Index] in FDelimSet)
  {$IFDEF DCMBCS}
  and _IsSingleByte(s, Index)
  {$ENDIF}
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CorrectTextAt(X, Y : integer) : string;
var
  S : string;
begin
  S := Strings[Y];
  if (X >= 0) and (X < Length(S)) and not InDelimSet(s, X + 1) then
    result := GetTextAt(X, Y)
  else
    result := '';
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CorrectTextAtCursor : string;
begin
  result := CorrectTextAt(GetCurChar , GetCurLine);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetStrItemClass : TStringItemClass;
begin
  result := TStringItem;
end;

{-------------------------------------------------------------}

constructor TCustomMemoSource.Create(AOwner : TComponent);
begin
  inherited;
  MemoSources.Add(Self);
  FUndoList := TUndoList.CreateNew;
  FRedoList := TUndoList.CreateNew;
  FAllowUndo := true;
  FSelStrings := TSelectionStrings.Create(Self);
  FTabStopList := TList.Create;
  FDelimSet := [#0..#32];
  FSpacesInTab := 8;
  FSaveModifiedIdx := -1;
  FSelectionType := stNotSelected;
  FOptions := CDefaultOptions;
  FNotifiers := TNotifierList.Create;
  FStrings := TInternalStrings.Create(GetStrItemClass);
  TInternalStrings(FStrings).FOnGetTabString := CheckForTabs;

  FExternalStrings := TExternalStrings.Create(Self);
  FPositions := TCollection.Create(TPosition);
  FPosition := TPosition(FPositions.Add);
  FTopLeft := TPosition(FPositions.Add);
  FBottomRight := TPosition(FPositions.Add);
  FTopLeft.OnAllowUpdate := AllowUpdate;
  FBottomRight.OnAllowUpdate := AllowUpdate;

  // old selection positions;
  FoTopLeft := TPosition(FPositions.Add);
  FoBottomRight := TPosition(FPositions.Add);
  FCodeTemplates := TMemoCodeTemplates.Create(Self, TMemoCodeTemplate);
  FBookMarkList := TMemoBookMarkList.Create;
  FVisibleLinesList := TVisibleLinesList.Create;

  TabStops := '9,17';
  FBlockIndent := 1;
  FTemplatesType := SLangNone;
  FBlockOption := bkBoth;
  FDefaultAttribute := -1
end;

{-------------------------------------------------------------------}

procedure TCustomMemoSource.RegisterNotifier(W : TNotifierProc; WithUpdate : boolean);
var
  O : TObject;
begin
  if WithUpdate then
  begin
    BeginUpdate(acRegisterNotifier);
    FNotifiers.AddMethod(W);
    UpdateChanged(0, MaxInt);
    FState := msAllChanged;
    EndUpdate;
  end
  else
    FNotifiers.AddMethod(W);

  O := TObject(TMethod(W).Data);

  if O is TComponent then
    TComponent(O).FreeNotification(Self);
end;

{-------------------------------------------------------------------}

procedure TCustomMemoSource.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if FActiveMemo = AComponent then
      FActiveMemo := nil
    else
    if FSyntaxParser = AComponent then
      SyntaxParser := nil
    else
      if FNotifiers <> nil then
        FNotifiers.DeleteWithData(AComponent);
  end;
end;

{-------------------------------------------------------------------}

procedure TCustomMemoSource.UnregisterNotifier(W : TNotifierProc);
begin
  if FNotifiers <> nil then
    FNotifiers.DeleteMethod(W);
end;

{-------------------------------------------------------------}

destructor TCustomMemoSource.Destroy;
begin
  Destroying;
  MemoSources.Remove(Self);
  FreeObject(FStrings,FStrings);
  FreeObject(FPositions,FPositions);
  ClearUndoBuffer;
  FreeObject(FTabStopList,FTabStopList);
  FreeObject(FSelStrings,FSelStrings);
  FreeObject(FExternalStrings,FExternalStrings);
  FCodeTemplates.Free;
  FBookMarkList.Clear;
  FBookMarkList.Free;
  FVisibleLinesList.Free;
  FUndoList.Free;
  FRedoList.Free;
  if FSyntaxParser <> nil then
    FSyntaxParser.UnRegisterNotifier(ParserOnChange);
  NotifyDestroying(Self, FNotifiers);
  FreeObject(FNotifiers,FNotifiers);
  if FLastSource = Self then
    FLastSource := nil;
  if CurrentFindSource = Self then
  begin
    CurrentFindSource := nil;
    if FrmSearRepl <> nil then
      FrmSearRepl.Close;
  end;

  inherited;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SwapUndoRedoLists;
begin
  FUseRedo := not FUseRedo;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.UndoAvailable : boolean;
begin
  result := CurrentUndoList.Count <> 0;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.RedoAvailable : boolean;
begin
  result := CurrentRedoList.Count <> 0;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.Undo;
var
  CurRecord : PUndoRecord;
  FirstRec  : boolean;
  OldCode   : integer;
  inBlock   : boolean;
  StoreData : boolean;
  Item      : TStringItem;

  {-------------------------------------------------}

  function LastRecord : PUndoRecord;
  begin
    with CurrentRedoList do
      result := Items[Count - 1];
  end;

  {-------------------------------------------------}

  procedure ProcessUndoRecord;
  begin
    with LastRecord^ do
      case FOperation of
        soNavigate:
          Navigate(- FDeltaLine, - FDeltaChar);
        soInsert:
          DeleteRight(FDeltaLine);
        soBreakLine:
          JoinLines;
        soJoinLines:
          BreakLine;
        soDeleteRight:
          if StoreData  and (FColorData <> '') then
            InsertEx(FString, FColorData)
          else
            Insert(FString);
        soUpdateColorData :
          if StoreData  and (FColorData <> '') then
          begin
            Item := StringItem[FDeltaLine];
            if (Item <> nil) and (FColorData <> '') then
            begin
              MoveColorData(FColorData, Item.FColorData, FDeltaLine, FDeltaChar);
              if StringItem[FDeltaLine] <> nil then
                StringItem[FDeltaLine].ItemState := StringItem[FDeltaLine].ItemState - [isWasParsed];
                FInColorUpdate := true;
                try
                  UpdateString(FDeltaLine);
                finally
                  FInColorUpdate := false;
                end;
            end;
          end;
      end;
  end;

  {-------------------------------------------------}
  
begin
  if not UndoAvailable  or GetReadOnly then
    exit;
  SwapUndoRedoLists;
  FManualPosition := true;
  OldCode := LastRecord^.FOpCode;
  BeginUpdate(OldCode);
  StoreData := StoreColorData;
  try
    Include(FState, msUndo);
    with CurrentRedoList do
      while Count <> 0 do
      begin
        FFirstRecord := true;
        CurRecord := LastRecord;
        with CurRecord^ do
        begin
          FirstRec := FirstRecord;
          InBlock := FInUndoBlock;
          if (FOpCode <> OldCode) and not InBlock then
            break;
        end;
        ProcessUndoRecord;
        if FSaveModifiedIdx = Count - 1 then
        begin
          FSaveModifiedIdx := - 1;
          FSaveModified := true;
        end;
        DeleteLast;
        if FirstRec and not ((soGroupUndo in FOptions) or InBlock ) then
          break;
      end;
  finally
    FManualPosition := false;
    FSelectionType := stNotSelected;
    EndUpdate;
    SwapUndoRedoLists;
  end;
  if FModified and not FUseRedo then
    CheckModified(IsSourceModified);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.IsSourceModified : boolean;
var
  Rec : PUndoRecord;
  i   : integer;
begin
  result := FSaveModified;
  if result then
    exit;
  with CurrentUndoList do
    for i := Count - 1 downto 0 do
    begin
      if i = FSaveModifiedIdx then
        break;
      Rec := Items[i];
      if not (Rec^.FOperation in [soNavigate, soUpdateColorData]) then
      begin
        result := true;
        exit;
      end;
    end;
  result := false;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ReCalculateMaxLine;
var
  len : integer;
  i   : integer;
begin
  if FInBlock then
  begin
    FBlockUpdate := true;
    exit;
  end;
  FMaxLineLen := 0;
  FMaxLineLenIdx := -1;
  if FNeedMaxLineUpdate then
    with Lines do
    begin
      if Assigned(FOnGetLineHeight) then
        ParseStrings(0, Count - 1, true);
      for i := 0 to Count - 1 do
      begin
        len := GetMaxLen(i);
        if FMaxLineLen <= len then
        begin
          FMaxLineLen := len;
          FMaxLineLenIdx := i;
        end;
      end;
    end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.UpdateMaxLine(NeedUpdate : boolean);
begin
  FNeedMaxLineUpdate := FNeedMaxLineUpdate or NeedUpdate;
  ReCalculateMaxLine;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ResetPositions;
var
  i:integer;
begin
  BeginUpdate(acResetPositions);
  For i := 0 to FPositions.Count-1 do
    TPosition(FPositions.Items[i]).SetPosition(0, 0);
  FSelectionType := stNotSelected;
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.LoadFromFile(const FileName : string);
begin
  DoLoadFromFile(FileName);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.QuickLoadFromFile(const FileName : string);
begin
  FQuickLoad := true;
  try
    LoadFromFile(FileName);
  finally
    FQuickLoad := false;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.LoadFromStream(S : TStream);
begin
  try
    BeginUpdate(acLoadFromStrings);
    FExternalStrings.LoadFromStream(S);//external strings as we must expand tabs
    FState := msAllChanged;
    UpdateChanged(0, MaxInt);
    ResetPositions;
    JumpTo(0, 0);
  finally
    EndUpdate;
    ClearUndoBuffer;
  end;
  Modified := false;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SaveToStream(ST : TStream);
begin
  Strings.SaveToStream(ST)
end;

{-------------------------------------------------------------}

function TCustomMemoSource.Save : boolean;
begin
  result := false;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetBackupName(const FileName : string) : string;
begin
  result := FileBakName(FileName);
  if Assigned(FOnGetBackupName) then
    FOnGetBackupName(Self, FileName, result);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SaveToFile(const FileName : string);
var
  FTempFileName : string;
  BackFileName  : string;

  {----------------------------------------------------}

  procedure RenameWithException(const FromFName, ToFName : string);
  begin
    if not RenameFile(FromFName, ToFName) then
      raise Exception.CreateFmt(SErrRenameFile,[FromFName, ToFName]);
  end;

  {----------------------------------------------------}

  procedure DeleteWithException(const FName : string);
  begin
    if FileExists(FName) then
      if not sysutils.DeleteFile(FName) then
        raise Exception.CreateFmt(SErrDeleteFile,[FName]);
  end;

  {----------------------------------------------------}

begin
  if soCreateBackups in FOptions then
  begin
    {$IFNDEF CLX}
    FTempFileName := TempFileName(FileName);
    {$ELSE}
    FTempFileName := ChangeFileExt(FileName, '~' + Copy(ExtractFileExt(FileName), 2, MaxInt));
    {$ENDIF}
    DoSaveToFile(FTempFileName);
    BackFileName := GetBackupName(FileName);

    DeleteWithException(BackFileName);

    if FileExists(FileName) then
      RenameWithException(FileName,BackFileName);

    RenameWithException(FTempFileName,FileName);
  end
  else
    DoSaveToFile(FileName);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.LoadFromStrings(S : TStrings);
begin
  BeginUpdate(acLoadFromStrings);
  ResetPositions;
  ClearUndoBuffer;
  GetStrings.Assign(S);
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ClearUndoBuffer;
begin
  FUndoList.Clear;
  FRedoList.Clear;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ClearRedoBuffer;
begin
  CurrentRedoList.Clear;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.CursorUp;
begin
  Navigate( - 1, 0);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.CursorLeft;
begin
  if [soCursorOnTabs , soCursorAlwaysOnTabs] * FOptions  <> [] then
    TabCursorLeft
  else
    Navigate(0, -1);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.CursorRight;
var
  ALen : integer;
begin
  if [soCursorOnTabs , soCursorAlwaysOnTabs] * FOptions  <> [] then
  begin
    with FPosition do
      GetTabDelta(CharPos, LinePos, true, ALen);
      if ALen <> 1 then
      begin
        Navigate(0, ALen);
        exit;
      end;
  end;

  if soLimitEOL in FOptions then
    with FPosition , GetStrings do
    begin
      Alen := _Length(Strings[LinePos]);
      if (CharPos + 1  > ALen) then
      begin
        if (SelectionType <> stBlockSel) and (ChangeDeltaLine(1) <> 0) then
          Navigate(1, - ALen);
        exit;
      end;
    end;
  Navigate(0, 1);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.TabCursorRight;
var
  delta : integer;
begin
  with FPosition do
  begin
    GetTabDelta(CharPos, LinePos, true, delta);
    Navigate(0, delta);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.TabCursorLeft;
var
  delta : integer;
begin
  if FPosition.CharPos = 0 then
    Navigate(0, -1);
  with FPosition do
  begin
    GetTabDelta(CharPos, LinePos, false, delta);
    Navigate(0, - delta);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.CursorDown;
begin
  Navigate(1, 0);
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.GetCurChar : integer;
begin
  result := FPosition.CharPos;
end;
{-------------------------------------------------------------}

function  TCustomMemoSource.GetCurLine : integer;
begin
  result := FPosition.LinePos;
end;
{-------------------------------------------------------------}

procedure TCustomMemoSource.JumpToChar(Value : integer);
begin
  JumpTo(Value, GetCurLine);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JumpToLine(Value : integer);
begin
  JumpTo(GetCurChar, Value);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JumpTo(X, Y : integer);
begin
  FManualPosition := true;
  try
    Navigate(Y - GetCurLine, X - GetCurChar);
  finally
    FManualPosition := false;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ShowGoToLineDialog;
var
  P : integer;
begin
  if CheckNotModalSearchRepl(2) then
    exit;
  P := CurLinePos + 1;
  FLastSource := Self;
  if ReadIntegerDialog(SCapGotoLineNumber, SCapEnterNewLine, 0, Self, TMethod(FOnCreateDialog), P) and (FLastSource <> nil) then
    JumpTo(0, P - 1);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CreateReplaceDialog : TCustomForm;
begin
  if GetReadonly then
  begin
    result := nil;
    exit;
  end;
  result := TReplDialog.Create(Application);
  if Assigned(FOnCreateDialog) then
    FOnCreateDialog(Self, result);
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CheckNotModalSearchRepl(Index : integer) : boolean;
begin
  result := not ModalSearchAndReplace;
  if result then
  begin
    if FrmSearRepl = nil then
      FrmSearRepl := TFrmSearRepl(CreateNotModalSearchDialog);
    with FrmSearRepl do
    begin
      SmartSearchOptions;
      LineEd.Text := IntToStr(CurLinePos + 1);
      Show;
      SetActiveIndex(Index);
//      ActivePageIndex := Index;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ShowReplaceDialog;
var
  MRes   : integer;
  Dialog : TCustomForm;
begin
  if CheckNotModalSearchRepl(1) then
    exit;
  SmartSearchOptions;
  Dialog := CreateReplaceDialog;
  if Dialog = nil then
    exit;
  with Dialog do
  try
    FLastSource := Self;
    MRes := ShowModal;
    //GetSearchOptions.Assign(IntSearchOptions);
    if (MRes = MrOk) or (Mres = mrAll) and (FLastSource <> nil)  then
      Replace;
  finally
    Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SmartSearchOptions;
begin
  with SearchOptions do
  begin
    if soFindTextAtCursor in Options then
      TextToFind := TextAtCursor;
    if (FSelectionType <> stNotSelected) and (IsPosInBlock(CurCharPos, CurLinePos)
        or isValidBlockPos(CurCharPos, CurLinePos)) then
      Scope := ssSelectedText
    else
      Scope := ssGlobal;
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CreateSearchDialog : TCustomForm;
begin
  result := TSrchDialog.Create(Application);
  if Assigned(FOnCreateDialog) then
    FOnCreateDialog(Self, result);
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.CreateNotModalSearchDialog : TCustomForm;
begin
  result := TFrmSearRepl.Create(Application);
  if Assigned(FOnCreateDialog) then
    FOnCreateDialog(Self, result);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ShowSearchDialog;
var
  Dialog : TCustomForm;
begin
  if CheckNotModalSearchRepl(0) then
    exit;

  SmartSearchOptions;
  Dialog := CreateSearchDialog;
  if Dialog = nil then
    exit;
  with Dialog do
  try
    FLastSource := Self;
    if (ShowModal = mrOk) and (FLastSource <> nil) then
      Find;
  finally
    Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JumpToFileBegin;
begin
  JumpTo(0, 0);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JumpToFileEnd;
begin
  BeginUpdate(acNavigate);
  JumpTo(0, GetStrings.Count - 1);
  JumpToLineEnd;
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JumpToLineBegin;
begin
  JumpToChar(0);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JumpToLineEnd;
begin
  if FLeaveSpacesAndTabs then
    JumpToChar(_Length(Strings[GetCurLine]))
  else
    JumpToChar(_Length(_TrimRight(Strings[GetCurLine])));
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SetImageBit(Index, ImageIndex : integer; V : boolean);
var
  OState : TMemoStates;
begin
  if (Index < 0) or (Index > GetStrings.Count - 1) then
    exit;

  BeginUpdate(acSetImageBit);
  with TInternalStrings(GetStrings).FList[Index] do
  begin
    if V then
      FImageBits := FImageBits or (1 shl (ImageIndex))
    else
      FImageBits := FImageBits and ($FFFFFFFF - (1 shl (ImageIndex)));
  end;
  OState := FState;
  UpdateChanged(Index, Index);
  FState := OState + [msBlockChanged];

  EndUpdate;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetLineTextStyle(Index : integer) : byte;
begin
  with TInternalStrings(GetStrings) do
    if (Index < 0) or (Index >= Count)
    then
      result := 0
    else
      with FList[Index] do
        result := FTextStyle;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.SetLineTextStyle(Index : integer; V : byte);
var
  OState : TMemoStates;
begin
  if (Index < 0) or (Index > GetStrings.Count - 1) then
    exit;

  with TInternalStrings(GetStrings).FList[Index] do
    if FTextStyle <> V  then
    begin
      FTextStyle := V;
      BeginUpdate(acChangeLineColor);
      OState := FState;
      UpdateChanged(Index, Index);
      FState:=OState + [msBlockChanged];
      EndUpdate;
    end;
end;

{--------------------------------------------}

function  TCustomMemoSource.GetLineVisible(Index : integer) : boolean;
begin
  with TInternalStrings(GetStrings) do
    if (Index < 0) or (Index >= Count)
    then
      result := true
    else
      result := not (isHidden in FList[Index].FItemState);
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetLineVisible(Index : integer; Value : boolean);
var
  OState : TMemoStates;

  {----------------------------------------}

  function _PrevLine : boolean;
  begin
    result := (Index = 0) or (not FVisibleLinesList.LineVisible[Index - 1]) or (CollapseState[Index - 1] = csCollapsed);
  end;
  {----------------------------------------}

begin
  BeginUpdate(acItemStateChanged);
  OState := FState;
  if SetLineState(Index, MaxInt, not Value, isHidden) and (Value or _PrevLine)  then
  begin
    FVisibleLinesList.LineVisible[Index] := Value;
    FState := OState + [msBlockChanged, msCountChanged];
  end;
  EndUpdate;
end;

{--------------------------------------------}

function  TCustomMemoSource.GetCollapseState(Index : integer) : TCollapseState;
begin
  with TInternalStrings(GetStrings) do
    if (Index < 0) or (Index >= Count) then
      result := csNone
    else
    with FList[Index] do
      if isExpanded in FItemState then
        result := csExpanded
      else
      if isCollapsed in FItemState then
        result := csCollapsed
      else
        result := csNone;
end;

{--------------------------------------------}

function TCustomMemoSource.GetRealLineVisible(Index : integer) : boolean;
begin
  result := FVisibleLinesList.LineVisible[Index];
end;

{--------------------------------------------}

procedure TCustomMemoSource.CheckCollapsed(Index : integer);
var
  AExpanded : boolean;
  i         : integer;
begin
  with TInternalStrings(GetStrings) do
  begin
    AExpanded := isExpanded in FList[Index].FItemState;
    for i := Index + 1 to Count - 1 do
      with FList[i], FVisibleLinesList do
        if isHidden in FItemState then
        begin
          LineVisible[i] := AExpanded;
          if AExpanded and (isCollapsed in FItemState) then
            FItemState := FItemState - [isCollapsed] + [isExpanded];
        end
        else
          break;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetCollapseState(Index : integer; Value : TCollapseState);
var
  OState : TMemoStates;
begin
  if (Index < 0) or (Index > GetStrings.Count - 1) then
    exit;
  with TInternalStrings(GetStrings).FList[Index] do
  begin
    if Value = csNone then
      FItemState := FItemState - [isExpanded, isCollapsed]
    else
    if Value = csExpanded then
      FItemState := FItemState + [isExpanded] - [isCollapsed]
    else
      FItemState := FItemState - [isExpanded] + [isCollapsed];

    CheckCollapsed(Index);

    BeginUpdate(acItemStateChanged);
    OState := FState;
    UpdateChanged(Index, MaxInt);
    FState := OState + [msBlockChanged, msCountChanged];
    EndUpdate;
  end;
end;

{--------------------------------------------}

function TCustomMemoSource.SetLineState(Index,  ToIndex : integer; Value : boolean; AState : TStringItemState) : boolean;
var
  OState : TMemoStates;
begin
  result := false;
  if (Index < 0) or (Index > GetStrings.Count - 1) then
    exit;

  with TInternalStrings(GetStrings).FList[Index] do
    if ((AState in FItemState) and not Value) or (not (AState in FItemState) and Value) then
    begin
      result := true;
      if Value then
        Include(FItemState, AState)
      else
        Exclude(FItemState, AState);

      BeginUpdate(acItemStateChanged);
      OState := FState;
      UpdateChanged(Index, ToIndex);
      FState := OState + [msBlockChanged];
      EndUpdate;
    end;
end;

{--------------------------------------------}

function  TCustomMemoSource.GetLineReadOnly(Index : integer) : boolean;
begin
  with TInternalStrings(GetStrings) do
    if (Index < 0) or (Index >= Count)
    then
      result := false
    else
      result := isReadOnly in FList[Index].FItemState;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetLineReadOnly(Index : integer; Value : boolean);
begin
  SetLineState(Index, Index, Value, isReadOnly);
end;

{--------------------------------------------}

function TCustomMemoSource.GetStringItem(Index : integer) : TStringItem;
begin
  with TInternalStrings(GetStrings) do
    if (Index < 0) or (Index >= Count)
    then
      result := nil
    else
      result := FList[Index];
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.GetImageBit(Index, ImageIndex : integer) : boolean;
begin
  with TInternalStrings(GetStrings) do
    if (Index < 0) or (Index >= Count)
    then
      result := false
    else
      result := (FList[Index].FImageBits and (1 shl ImageIndex)) <> 0;
end;

{--------------------------------------------}

procedure TCustomMemoSource.DeleteCharLeft;
var
  CurLine   : integer;
  CurChar   : integer;
  IndentPos : integer;
  firstch   : integer;
  s         : string;
  {-----------------------------------------}

  function GetPrevIndentLevel : integer;
  var
    i : integer;
    S : string;
  begin
    result := 0;
    i := CurLine - 1;
    while (i > 0) and ((Length(Strings[i]) = 0) or (CurChar < GetFirstNotSpace(Strings[i]))) do
      Dec(i);
    S := Strings[i];
    if Length(S) = 0 then
      exit;

    result := Max(Min(CurChar , Length(S)), 0);

    while (result >= 0) and (S[result] = ' ') do
      dec(result);

    while (result >= 0) and (S[result] <> ' ') do
      dec(result);

    result := Max(result,0);
  end;

  {-----------------------------------------}

begin
  if CheckOverwriteBlock then
    exit;

  BeginUpdate(acDeleteCharLeft);
  CurLine := FPosition.LinePos;
  CurChar := FPosition.CharPos;
  if CurChar = 0 then
  begin
    if CurLine > 0 then
    begin
      JumpToLine(CurLine - 1);
      JumpToLineEnd;
      JoinLines;
    end;
  end
  else
  begin
    s := Strings[CurLine];
    {$IFDEF DCMBCS}
    CurChar := _CharToByte(s, CurChar + 1) - 1;
    {$ENDIF}
    if (CurChar <= Length(s)) and (CurLine < GetStrings.Count) then
    begin
      if (soBackUnindents in FOptions) and (CurChar + 1 = GetFirstNotSpace(s)) then
      begin
        IndentPos := GetPrevIndentLevel;
        if (soUseTabCharacter in FOptions) then
        begin
          SetSelection(stBlockSel, IndentPos, CurLine, CurChar - 1, CurLine);
          DeleteBlock;
          if soUseTabCharacter in Options then
          begin
            firstch := GetFirstNotSpace(Strings[CurLine]) - 1;
            if IndentPos > firstch then
              Insert(StringOfSpace(IndentPos - firstch));
          end;
        end
        else
        begin
          JumpToLineBegin;
          DeleteRight(CurChar - IndentPos);
        end;
        JumpToChar(IndentPos);
      end
      else
      begin
        TabCursorLeft;
        DeleteRight(1);
      end;
    end
    else
      CursorLeft;
  end;
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.DeleteCharRight;
begin
  if CheckOverwriteBlock then
    exit;
  if FPosition.CharPos >= _Length(Strings[FPosition.LinePos])
  then
    JoinLines
  else
    DeleteRight(1);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.Redo;
begin
  SwapUndoRedoLists;
  try
    Undo;
  finally
    SwapUndoRedoLists;
    if FModified then
      CheckModified(IsSourceModified);
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.DeleteLine;
begin
  BeginUpdate(acDeleteLine);
  JumpToLineBegin;
  DeleteRight(MaxInt);
  JoinLines;
  EndUpdate;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.GetSelectionRect:TRect;
begin
  with result do
  begin
    Top := FTopLeft.LinePos;
    Bottom := FBottomRight.LinePos;
    Left := FTopLeft.CharPos;
    Right := FBottomRight.CharPos;
   end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.IsBlockEmpty(ASelType : TSelectionType) : boolean;
begin
  with GetSelectionRect do
  begin
    case ASelType of
      stStreamSel:
        result := (Top > Bottom) or ((Top = Bottom) and (Left >= Right));
      stBlockSel:
        result := (Top > Bottom) or (Left > Right);
      else
        result := true;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.MarkBlockBegin;
begin
  BeginUpdate(acMarkBlockBegin);
  FTopLeft.Assign(FPosition);
  if FSelectionType = stNotSelected then
    FSelectionType := stStreamSel;
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.MarkBlockEnd;
begin
  BeginUpdate(acMarkBlockEnd);
  FBottomRight.Assign(FPosition);
  if FSelectionType = stNotSelected then
    FSelectionType := stStreamSel;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetBlockAsColBlock;
begin
  if FSelectionType = stStreamSel then
  begin
    BeginUpdate(acSetBlockAsColBlock);
    FSelectionType := stBlockSel;
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetBlockAsLineBlock;
begin
  if FSelectionType = stBlockSel then
  begin
    BeginUpdate(acSetBlockAsLineBlock);
    FSelectionType := stStreamSel;
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkToLineEnd;
begin
  UnivMark(JumpToLineEnd, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkToLineBegin;
begin
  UnivMark(JumpToLineBegin, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkToFileBegin;
begin
  UnivMark(JumpToFileBegin, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkToFileEnd;
begin
  UnivMark(JumpToFileEnd, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.SelectAll;
begin
  if BlockOption = bkNone then
    exit;
  inc(FSkipClearSelection);
  BeginUpdate(acSelectAll);
  try
    SelectionType := stNotSelected;
    JumpToFileBegin;
    MarkBlockBegin;
    JumpToFileEnd;
    MarkBlockEnd;
  finally
    EndUpdate;
    dec(FSkipClearSelection);
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColToLineEnd;
begin
  UnivMark(JumpToLineEnd, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColToLineBegin;
begin
  UnivMark(JumpToLineBegin, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColToFileBegin;
begin
  UnivMark(JumpToFileBegin, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColToFileEnd;
begin
  UnivMark(JumpToFileEnd, stBlockSel);
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.DeleteToLineBegin;
var
  i : integer;
  s : string;
begin
  BeginUpdate(acDeleteToLineBegin);
  i := FPosition.CharPos;
  if soUseTabCharacter in Options then
  begin
    s := TInternalStrings(GetStrings).GetRealString(FPosition.LinePos);
    ChangeTabIndex(s, i); 
  end;  
  JumpToLineBegin;
  DeleteRight(i);
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.JumpToBlockBegin;
begin
  if FSelectionType = stNotSelected then
    exit;
  with SelectionRect do
    JumpTo(Left, Top);
end;

{--------------------------------------------}

procedure TCustomMemoSource.JumpToBlockEnd;
begin
  if FSelectionType = stNotSelected then
    exit;
  with SelectionRect do
    JumpTo(Right, Bottom);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkLine;
begin
  BeginUpdate(acMarkLine);
  SetSelection(stStreamSel, 0, GetCurLine, 0, GetCurLine + 1);
  EndUpdate;
end;

{--------------------------------------------}

function TCustomMemoSource.CanPaste : boolean ;
begin
  {$IFNDEF CLX}
  result := IsClipboardFormatAvailable(CF_TEXT);
  {$ELSE}
  result := true;
  {$ENDIF}
end;

{--------------------------------------------}

function  TCustomMemoSource.CanCopy  : boolean;
begin
  result := SelectionType <> stNotSelected;
end;

{--------------------------------------------}

procedure TCustomMemoSource.PasteFromClipboard(Strings : TStrings);
begin
  if Assigned(FOnPasteFromClipboard) then
    FOnPasteFromClipboard(Self, Strings);
end;

{--------------------------------------------}

procedure TCustomMemoSource.PasteBlock;
var
  F : TStringList;
begin
   CheckOverwriteBlock;
   {$IFNDEF CLX}
   if GetClipboardOwner <> Application.Handle then
   {$ENDIF}
     ClipSelType := cfStreamSel;
   F := TStringlist.Create;
   try
     ClipboardToStrings(F);
     PasteFromClipboard(F);
     InsertStrings(F, ClipSelType = cfBlockSel);
     if not (soPersistentBlocks in Options) then
       FSelectionType := stNotSelected;
   finally
     F.Free;
   end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.FQuoteBlockStr(var S : string);
begin
  System.Insert('>', S, 1);
end;

{--------------------------------------------}

procedure TCustomMemoSource.QuoteBlock;
begin
  DoWithBlockStr(acQuoteBlock, FQuoteBlockStr, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.PasteBlockFromStrings(F : TStrings; BlockSel : boolean);
begin
  PasteBlockFromStringsEx(F, nil, BlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.PasteBlockFromStringsEx(F, CL : TStrings; BlockSel : boolean);
var
  CurLine : integer;
  CurChar : integer;

  {----------------------------------------}

  function _GetColorS(Index : integer) : string;
  begin
    if (CL = nil) or (Index < 0) or (Index >= Cl.Count) then
       result := ''
    else
      result := CL[Index]
  end;

  {----------------------------------------}

  procedure BeginU;
  begin
    BeginUpdate(acPasteBlock);
    FInBlock := true;
    FBlockUpdate := false;
  end;

  {----------------------------------------}

  procedure EndU;
  begin
    FInBlock := false;
    if FBlockUpdate then
      ReCalculateMaxLine;
    EndUpdate;
  end;

  {----------------------------------------}

  procedure PasteBlockSel;
  var
    i   : integer;
    len : integer;
  begin
    BeginU;
    try
      len := 0;
      if F.Count = 1 then
      begin
        len := InsertEx(F[0], _GetColorS(0));
        SetSelection(stStreamSel, CurChar, CurLine, CurChar + len, CurLine);
        if BlockSel then
          CursorDown
        else
          Navigate(0, len);
      end
      else
      begin
        for i := 0 to F.Count - 1 do
        begin
          if i = 0 then
            len := InsertEx(F[i], _GetColorS(i))
          else
            InsertEx(F[i], '');
          if GetCurLine < StrCount - 1 then
            CursorDown
          else
          begin
            JumpToLineEnd;
            BreakLine;
            CursorDown;
            JumpToChar(CurChar);
          end;
        end;
        SetSelection(stBlockSel, CurChar, CurLine, CurChar + len - 1, CurLine + F.Count - 1);
      end;
    finally
      EndU;
    end;  
  end;

  {----------------------------------------}

  procedure PasteStreamSel;
  var
    i        : integer;
    len      : integer;
  begin
    BeginU;
    try
      InsertLine;
      InsertEx(F[0], _GetColorS(0));
      JumpTo(0, CurLine + 1);
      len := InsertEx(F[F.Count - 1], _GetColorS(F.Count - 1));
      for i := 1 to F.Count - 2 do
      begin
        JumpTo(0, CurLine + i);
        InsertLine;
        InsertEx(F[i], _GetColorS(i));
      end;

      SetSelection(stStreamSel, CurChar, CurLine, len, CurLine + F.Count - 1);
      with SelectionRect do
        JumpTo(Right, Bottom);
    finally
      EndU;
    end;
  end;

  {----------------------------------------}

begin
  if F.Count = 0 then
    exit;
  CurLine := GetCurLine;
  CurChar := GetCurChar;
  if BlockSel or (F.Count = 1) then
    PasteBlockSel
  else
    PasteStreamSel;
end;


{--------------------------------------------}

procedure TCustomMemoSource.WordBounds(X, Y : integer; var ALeft , ARight : integer; WordSelType : TWordSelectionType);
var
  S : string;
begin

  ALeft := 0;
  ARight := 0;
  S := Strings[Y];

  if Length(s) <> 0 then
  begin
    {$IFDEF DCMBCS}
    X := _CharToByte(s, X + 1) - 1; 
    {$ENDIF}
    X := Min(X + 1, Length(S));
    ALeft := X;
    // move to left while blanks
    while (X > 0) and InDelimSet(S , X) do
      dec(X);
    // move to left while non-blanks
    while (X - 1 > 0) and not InDelimSet(S, X - 1) do
      dec(X);

    if X = 0 then
      X := ALeft;
    while InDelimSet(S, X) and (X <= Length(S)) do
      inc(X);

    if X <= Length(S) then
    begin
      ALeft := X;
      while (X < Length(S)) and not InDelimSet(S, X + 1) do
        inc(X);
      case WordSelType of
        wsWordWithSpace :
          if (X < Length(S)) and _EqualChar(S, X + 1 , ' ') then
            inc(X);
        wsUntilNextWord:
          while (X < Length(S)) and InDelimSet(S, X + 1) do
            inc(X);
      end;
      ARight := X;
    end;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkWord;
begin
  MarkWordWithType(wsWordOnly);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkWordWithType(WordSelType : TWordSelectionType);
var
  iBeg : integer;
  iEnd : integer;
  {$IFDEF DCMBCS}
  S    : string;
  {$ENDIF}
begin
  BeginUpdate(acMarkWord);
  FSelectiontype := stNotSelected;
  WordBounds(GetCurChar, GetCurLine, iBeg, iEnd, WordSelType);
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
  begin
    S := Strings[GetCurLine];
    IEnd := _ByteToChar(S, IEnd);
    IBeg := _ByteToChar(S, IBeg);
  end;
  {$ENDIF}
  if (IEnd > iBeg) or ((IEnd = iBeg) and (IEnd > 0)) then
  begin
    JumpToChar(iEnd);
    SetSelection(stStreamSel, iBeg - 1, GetCurLine, iEnd, GetCurLine);
  end;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetSelection(V : TSelectionType; ALeft, ATop, ARight, ABottom : integer);
begin
  BeginUpdate(acSetSelection);
  FSelectionType := V;
  SelectionRect := Rect(ALeft, ATop, ARight, ABottom);
  EndUpdate;
end;

{--------------------------------------------}

function  TCustomMemoSource.CopyCurrent : TPosition;
begin
  result := CopyPosition(FPosition);
end;

{--------------------------------------------}

function TCustomMemoSource.CopyPosition(P : TPosition) : TPosition;
begin
  result := TPosition(FPositions.Add);
  result.Assign(P);
  result.OnAllowUpdate := AllowUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.RestorePosition(P : TPosition);
begin
  JumpTo(P.CharPos, P.LinePos);
  P.Free;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SelAttributesUpdated;
begin
 //
end;

{--------------------------------------------}

procedure TCustomMemoSource.DeleteBlock;
var
  P : TPosition;

  {--------------------------------------------}

  procedure BeginU(NeedJump : boolean);
  begin
    BeginUpdate(acDeleteBlock);
    if NeedJump then
      with SelectionRect do
        JumpTo(_Length(FSelStrings[FSelStrings.Count - 1]), Bottom);

    P := CopyPosition(FPosition);
    FInBlock := true;
    FBlockUpdate := false;
  end;

  {--------------------------------------------}

  procedure EndU;
  begin
    FSelectionType := stNotSelected;
    RestorePosition(P);
    FInBlock := false;
    if FBlockUpdate then
      ReCalculateMaxLine;
    EndUpdate;
  end;

  {--------------------------------------------}

  procedure DeleteBlockSel;
  var
    W     : integer;
    i     : integer;
    APos  : integer;
    s     : string;
    L     : integer;
    R     : integer;
  begin
    with SelectionRect do
    begin
      BeginU(false);
      try
        W := Right - Left;
        if FSelectionType <> stStreamSel then
          inc(W);
        for i := Top to Bottom do
        begin
          JumpTo(Left, i);
          if soUseTabCharacter in Options then
          begin
            s := TInternalStrings(GetStrings).GetRealString(i);
            R := Right;
            if FSelectionType <> stStreamSel then
              inc(R);
            L := Left;
            APos := 0;
            CheckDeltaChar(i, Left, APos);
            if APos <> 0 then ///GetTabDelta(L + 1, i, true, delta) then
            begin
              TabCursorLeft;
              L := CaretPoint.X;
            end;
            ChangeTabIndex(s, R);
            ChangeTabIndex(s, L);
            DeleteRight(R - L);
          end
          else
            DeleteRight(W);
        end;
      finally
        EndU;
      end;  
    end;
  end;

  {--------------------------------------------}

  procedure DeleteStreamSel;
  var
    i : integer;
  begin
    with SelectionRect do
    begin
      BeginU(true);
      try
        DeleteToLineBegin;
        JumpToLine(Top + 1);
        for i := 1 to Bottom - Top - 1 do
          DeleteLine;
        JumpTo(Left, Top);
        DeleteToLineEnd;
        DeleteCharRight;
      finally
        EndU;
      end;
    end;
  end;

  {--------------------------------------------}

begin
  with SelectionRect do
    case FSelectionType of
      stStreamSel:
        if Top <> Bottom  then
          DeleteStreamSel
        else
          DeleteBlockSel;
      stBlockSel:
        DeleteBlockSel;
    end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.CopyBlock;
var
  s : string;
begin
  if (FSelectionType=stNotSelected) then
  begin
    {$IFNDEF CLX}
    if (soForceCutCopy in FOptions) then
      EmptyClipboard;
    {$ELSE}
    Clipboard.Clear;
    {$ENDIF}
  end
  else
    with TInternalStrings(GetStrings) do
    begin
      FIgnoreTabs := true;
      try
        s := SelStrings.Text;
        RemoveExtraEol(s);
        Clipboard.SetTextBuf(PChar(s));
        if FSelectionType = stStreamSel then
          ClipSelType := cfStreamSel
        else
          ClipSelType := cfBlockSel;
      finally
        FIgnoreTabs := false;
      end;
    end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.CutBlock;
begin
  if (FSelectionType = stNotSelected) and (not (soForceCutCopy in FOptions)) then
  begin
    {$IFNDEF CLX}
    EmptyClipboard;
    {$ELSE}
    ClipBoard.Clear;
    {$ENDIF}
    exit;
  end;
  BeginUpdate(acCutBlock);
  CopyBlock;
  DeleteBlock;
  EndUpdate;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.DuplicateBlock;
var
  ABlockSel : boolean;
  AStrings  : TStrings;
begin
  if SelectionType = stNotSelected then
    exit;
  ABlockSel := SelectionType = stBlockSel;
  BeginUpdate(acDuplicateBlock);
  AStrings := TStringList.Create;
  try
    AStrings.Assign(SelStrings);
    SelectionType := stNotSelected;
    InsertStrings(AStrings, ABlockSel);
  finally
    AStrings.Free;
    EndUpdate;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.DeleteToLineEnd;
begin
  DeleteRight(MaxInt);
end;

{--------------------------------------------}

procedure TCustomMemoSource.InsertLine;
begin
  BreakLine;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ReadBlockFromStreamEx(S : TStream; BlockSel : boolean);
var
  T : TStringList;
begin
  T := TStringList.Create;
  try
    T.LoadFromStream(S);
    InsertStrings(T, BlockSel);
  finally
    T.Free;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ReadBlockFromStream(S : TStream);
begin
  ReadBlockFromStreamEx(S, false);
end;

{--------------------------------------------}

procedure TCustomMemoSource.WriteBlockToStream(S : TStream);
begin
  if FSelectionType = stNotSelected then
    exit;
  SelStrings.SaveToStream(S);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ReadBlockFromFile(const FileName : string);
var
  Stream : TStream;
begin
  Stream := TFileStream.Create(FileName, DefaultOpenMode);
  try
    ReadBlockFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.WriteBlockToFile(const FileName : string);
var
  Stream : TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    WriteBlockToStream(Stream);
  finally
    Stream.Free;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SelectionBounds(Aline : integer; var ALeft, ARight : integer; CheckMBCS : boolean);
{$IFDEF DCMBCS}
var
  s : string;
{$ENDIF}

  {--------------------------------------------}

  procedure GetResult(A, B : integer);
  begin
    ALeft := A;
    ARight := B;
  end;

  {--------------------------------------------}


begin
  GetResult(0, 0);
  with  SelectionRect do
    case SelectionType of
      stStreamSel :
        with SelectionRect do
        begin
          if (Aline > top) and (Aline < bottom) then
            GetResult(0, MaxInt)
          else
          if (bottom <> top) then
          begin
            if (Aline = top ) then
              GetResult(Left, MaxInt)
            else
            if (Aline = bottom) then
              GetResult(0, Right);
          end
          else
          if (ALine = top) then
            GetResult(Left, Right);
        end;
      stBlockSel:
        if (Aline >= top) and (Aline <= bottom) then
          GetResult(Left, Right + 1);
    end;
  SwapMaxInt(ALeft, ARight);
  {$IFDEF DCMBCS}
  if CheckMBCS and SysLocale.FarEast then
  begin
    s := Strings[ALine];
    ALeft := _GetStrDisplayIndex(s, ALeft);
    ARight := _GetStrDisplayIndex(s, ARight);
  end;
  {$ENDIF}
end;

{--------------------------------------------}

function TCustomMemoSource.IsPosInBlock(X, Y : integer) : boolean;
var
  ALeft  : integer;
  ARight : integer;
begin
  SelectionBounds(Y, ALeft, ARight, false);
  result := (X >= ALeft) and (X < ARight);
end;

{--------------------------------------------}

function TCustomMemoSource.MoveBlock : boolean;
begin
  result := MoveBlockEx(true);
end;

{--------------------------------------------}

function TCustomMemoSource.CopyBlockToPos : boolean;
begin
  result := MoveBlockEx(false);
end;

{--------------------------------------------}

function TCustomMemoSource.MoveBlockEx(DelOrigin : boolean) : boolean;
var
  S        : TMemoryStream;
  TempPos  : TPosition;
  BlockSel : boolean;
begin
  result := not IsPosInBlock(GetCurChar, GetCurLine);
  if not result then
    exit;
  S := TMemoryStream.Create;
  BeginUpdate(acMoveBlock);
  try
    BlockSel := SelectionType = stBlockSel;
    WriteBlockToStream(S);
    TempPos := CopyPosition(FPosition);
    if DelOrigin then
      DeleteBlock;
    S.Seek(0, soFromBeginning);
    RestorePosition(TempPos);
    ReadBlockFromStreamEx(S, BlockSel);
  finally
    EndUpdate;
    S.Free;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.DoWithBlock(ACode : integer; MarkProc, ActionProc : TObjProc; RestorePos : boolean);
var
  OldSel       : TSelectionType;
  OTopLeft     : TPosition;
  OBottomRight : TPosition;
  OldPt        : TPoint;
begin

  OldSel := FSelectionType;
  OTopLeft := CopyPosition(FTopLeft);
  OBottomRight := CopyPosition(FBottomRight);

  BeginUpdate(ACode);
  if RestorePos then
    OldPt := CaretPoint;
  MarkProc;
  ActionProc;

  if RestorePos then
    CaretPoint := OldPt;

  FSelectionType := OldSel;
  FTopLeft.Assign(OTopLeft);
  FBottomRight.Assign(OBottomRight);

  OTopLeft.Free;
  OBottomRight.Free;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.DoWithBlockStr(ACode : integer; StrAction : TStrProc; RestorePos : boolean);
var
  T         : TStringList;
  CL        : TStringList;
  i         : integer;
  S         : string;
  SRect     : TRect;
  SelType   : TSelectionType;
  p         : TPoint;
  StoreData : boolean;
  len       : integer;
begin
  if FSelectionType = stNotSelected then
    exit;

  BeginUpdate(ACode);

  p := CaretPoint;
  StoreData := StoreColorData;
  T := TStringList.Create;
  if StoreData then
    CL := TStringList.Create
  else
    CL := nil;
  try
    T.Assign(SelStrings);
    if StoreData then
      with TSelectionStrings(SelStrings) do
        for i := 0 to Count - 1 do
          Cl.Add(GetEx(i, true));
    if T.Count > 0 then
    begin
      for i := 0 to T.Count - 1 do
      begin
        S := T[i];
        len := length(s);
        StrAction(S);
        T[i] := S;
        len := len - length(s);
        if StoreData and (len <> 0) then
        begin
          S := CL[i];
          StrAction(S);
          CL[i] := S;
        end;
      end;
      SRect := SelectionRect;
      SelType := FSelectionType;
      DeleteBlock;
      with SRect do
        JumpTo(Left, Top);
      PasteBlockFromStringsEx(T, Cl, SelType = stBlockSel);
    end;
  finally
    if StoreData then
      CL.Free;
    T.Free;
    if RestorePos then
      CaretPoint := p;
  end;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.UpperCaseLine;
begin
  DoWithBlock(acUppercaseLine, MarkLine, UpperCaseBlock, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.FUpperCaseStr(var S : string);
begin
  S := AnsiUpperCase(S);
end;

{--------------------------------------------}

procedure TCustomMemoSource.FLowerCaseStr(var S : string);
begin
  S := AnsiLowerCase(S);
end;

{--------------------------------------------}

procedure TCustomMemoSource.FToggleStrCase(var S : string); 
var
  i   : integer;
  len : integer;
  a   : string[1];
  b   : string[1];
begin
  len := Length(S);
  i := 1;
  while i <= len do
  begin
    {$IFDEF DCMBCS}
    if SysLocale.FarEast and (s[i] in LeadBytes) then
    begin
      inc(i, 2);
      continue;
    end;  
    {$ENDIF}
    b := S[i];
    a := AnsiUpperCase(b);
    if a = b then
      S[i] := AnsiLowerCase(b)[1]
    else
      S[i] := a[1];
    inc(i);
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.UpperCaseBlock;
begin
  DoWithBlockStr(acUpperCaseBlock, FUpperCaseStr, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.LowerCaseBlock;
begin
  DoWithBlockStr(acLowerCaseBlock, FLowerCaseStr, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBlockCase;
begin
  DoWithBlockStr(acToggleBlockCase, FToggleStrCase, true);
end;

{--------------------------------------------}

function  TCustomMemoSource.NextBookmarkNumber : integer;
var
  i : integer;
begin
  result := 0;
  with FBookmarkList do
    for i := 0 to Count - 1 do
      with PBookMarkRec(Items[i])^ do
        if BookMark > result then
          result := BookMark;
  inc(result);
end;

{--------------------------------------------}

procedure TCustomMemoSource.LowerCaseLine;
begin
  DoWithBlock(acLowerCaseLine, MarkLine, LowerCaseBlock, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleLineCase;
begin
  DoWithBlock(acToggleLineCase, MarkLine, ToggleBlockCase, true);
end;

{--------------------------------------------}

{ 1. skip all non-delimeters
  2. skip all delimeters
}
procedure TCustomMemoSource.JumpWordRight;
var
  CurChar : integer;
  S       : string;
begin
  BeginUpdate(acNavigate);
  CurChar := GetCurChar;
  S := Strings[GetCurLine];
  if CurChar >= _Length(S) then
  begin
    if GetCurLine < StrCount - 1 then
    begin
      CursorDown;
      JumpToLineBegin;
    end;
  end
  else
  begin
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      CurChar := _CharToByte(S, CurChar + 1) - 1; 
    {$ENDIF}
    while (CurChar < Length(S)) and not InDelimSet(S, CurChar + 1) do
      Inc(CurChar);
    while (CurChar < Length(S)) and InDelimSet(S, CurChar + 1) do
      Inc(CurChar);
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      CurChar := _ByteToChar(S, CurChar);
    {$ENDIF}
    JumpToChar(CurChar);
  end;
  EndUpdate;
end;

{--------------------------------------------}

{ 1. skip all delimeters
  2. skip all non delimeters and stop on first non-delimeter
}
procedure TCustomMemoSource.JumpWordLeft;
var
  S       : string;
  CurChar : integer;
begin
  BeginUpdate(acNavigate);
  S := Strings[GetCurLine];

  CurChar := GetCurChar;

  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    CurChar := _CharToByte(S, CurChar + 1) - 1;
  {$ENDIF}

  CurChar := Min(CurChar, Length(S));

  while (CurChar > 0) and InDelimSet(S, CurChar) do
    Dec(CurChar);

  if CurChar = 0 then
  begin
    if GetCurLine > 0 then
    begin
      //CursorUp;
      JumpToLine(GetCurLine - 1);
      JumpToLineEnd;
    end
    else
      JumpTo(0, 0);
  end
  else
  begin
    while (CurChar > 0) and not InDelimSet(S, CurChar) do
      Dec(CurChar);
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      CurChar := _ByteToChar(S, CurChar);
    {$ENDIF}
    JumpToChar(CurChar);
  end;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkWordRight;
begin
  UnivMark(JumpWordRight, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColWordRight;
begin
  UnivMark(JumpWordRight, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkWordLeft;
begin
  UnivMark(JumpWordLeft, stStreamSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.MarkColWordLeft;
begin
  UnivMark(JumpWordLeft, stBlockSel);
end;

{--------------------------------------------}

procedure TCustomMemoSource.DeleteWordRight;
begin
  DoWithBlock(acDeleteWordRight, MarkWordRight, DeleteBlock, false);
end;

{--------------------------------------------}

procedure TCustomMemoSource.CorrectMarkWordRight;
var
  iBeg   : integer;
  iEnd   : integer;
  AFound : boolean;
  {-------------------------------------}

  function WordFound : boolean;
  begin
    result := (IEnd > iBeg) or ((IEnd = iBeg) and (IEnd > 0));
  end;
  {-------------------------------------}

begin
  BeginUpdate(acMarkWord);
  Selectiontype := stNotSelected;
  with CaretPoint do
  begin
    WordBounds(X, Y, iBeg, iEnd, wsWordWithSpace);
    if (WordFound) and (IBeg > X + 1) then
      SetSelection(stStreamSel, X, Y, IBeg - 1, Y)
    else
    begin
      iBeg := X + 1;
      AFound := WordFound;
      if not AFound then
      begin
        WordBounds(X, Y, iBeg, iEnd, wsUntilNextWord);
        iBeg := X + 1;
        AFound := WordFound;
      end;
      if AFound then
      begin
        JumpToChar(iEnd);
        SetSelection(stStreamSel, iBeg - 1, Y, iEnd, Y);
      end;
    end;
  end;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.CorrectDeleteWordRight;
begin
  if GetCurChar >= _Length(_TrimRight(Strings[GetCurLine])) then
    JoinLines
  else
    DoWithBlock(acDeleteWordRight, CorrectMarkWordRight, DeleteBlock, false);
end;

{--------------------------------------------}

procedure TCustomMemoSource.DeleteWord;
var
  R : TRect;
begin
  R := SelectionRect;
  BeginUpdate(acDeleteWord);
  MarkWord;
  DeleteBlock;
  SelectionRect := R;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.DeleteWordLeft;
begin
  DoWithBlock(acDeleteWordLeft, MarkWordLeft, DeleteBlock, false);
end;

{--------------------------------------------}

procedure TCustomMemoSource.LowerCaseWord;
begin
  DoWithBlock(acLowerCaseWord, MarkWord, LowerCaseBlock, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.UpperCaseWord;
begin
  DoWithBlock(acUpperCaseWord, MarkWord, UpperCaseBlock, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.InsertStrings(S : TStrings; BlockSel : boolean);
var
  TempStrings : TStringList;
begin
  TempStrings := TStringList.Create;
  try
    if not (soUseTabCharacter in FOptions) then
      ExpandTabsinStrings(S, TempStrings, FSpacesInTab)
    else
      TempStrings.Text := S.Text;
    PasteBlockFromStrings(TempStrings, BlockSel);
  finally
    TempStrings.Free;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.InsertString(const S : string);
var
  L           : TStringList;
  OldSelType  : TSelectionType;
  OldSelRect  : TRect;

begin
  L := TStringList.Create;
  BeginUpdate(acInsertString);
  OldSelType := SelectionType;
  OldSelRect := SelectionRect;
  try
    L.Text := S;
    InsertStrings(L, false);
  finally
    SelectionType := OldSelType;
    SelectionRect := OldSelRect;
    L.Free;
    EndUpdate;
  end;
end;

{--------------------------------------------}

function TCustomMemoSource.ExtraTabDelta : integer;
begin
  case FTabStopList.Count of
    0: result:=8;
    1: result:=integer(FTabStopList[0]);
    else
    begin
      result := FTabStopList.Count - 1;
      result := integer(FTabStopList[result]) - integer(FTabStopList[result - 1]);
    end;
  end;
end;

{--------------------------------------------}

function TCustomMemoSource.GetVirtualTabStop(Index : integer) : integer;
var
  ACount : integer;
begin
  ACount := FTabStopList.Count;
  if Index < ACount then
    result := integer(FTabStopList.Items[Index])
  else
  begin
    if ACount = 0 then
      result := 0
    else
      result := integer(FTabStopList.Items[ACount - 1]);
    ACount := Index - (ACount - 1);
    result := result + ACount * ExtraTabDelta;
  end;
end;

{--------------------------------------------}


function TCustomMemoSource.GetFirstNonSpaceChar(LinePos, CurChar : integer) : integer;
var
  s        : string;
  CharPos  : integer;
  {--------------------------------------------}

  function _InSet(const s : string; Index : integer; CharSet : TCharSet) : boolean;
  begin
    result := (s[Index] in CharSet)
    {$IFDEF DCMBCS}
    and _IsSingleByte(s, Index)
    {$ENDIF}
  end;

  {--------------------------------------------}

begin
  result := - 1;
  CharPos := 0;
  S := Strings[LinePos];
  if CharPos >= _Length(S) then
    exit;
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    CurChar := _CharToByte(S, CurChar + 1) - 1;
  {$ENDIF}

  while (CharPos < Length(S)) and  _InSet(S, CharPos + 1, [' ', #9]) do
    Inc(CharPos);
  if CharPos <= CurChar then
  begin
    result := -1;
    exit;
  end;

  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    CharPos := _ByteToChar(S, CharPos);
  {$ENDIF}
  result := CharPos;
end;

{--------------------------------------------}

function TCustomMemoSource.GetSmartTabPos(i, OldPos, CurLine : integer) : integer;
var
  Pt     : TPoint;
  OldR   : TRect;
  OldSel : TSelectionType;
  OldOpt : TStringsOptions;
  IPos  : integer;
begin
  result := GetVirtualTabStop(i);
  if (soSmartTab in FOptions) and (CurLine > 0) then
  begin
    i := CurLine - 1;
    while (Length(Strings[i]) <= OldPos) and (i >= 0) do
      dec(i);
    if i >= 0 then
    begin
      IPos := GetFirstNonSpaceChar(i, CaretPoint.X);
      if IPos >= 0 then
        result := IPos
      else
      begin
        Pt := CaretPoint;
        OldSel := SelectionType;
        OldR := SelectionRect;
        OldOpt := FOptions;
        Exclude(FOptions, soLimitEol);
        try
          JumpToLine(i);
          JumpWordRight;
          if GetCurLine = i then
            result := CurCharPos;
        finally
          CaretPoint := Pt;
          SelectionRect := OldR;
          SelectionType := OldSel;
          FOptions := OldOpt;
        end;
      end;
    end;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.PressTab;
var
  i       : integer;
  CurLine : integer;
  OldPos  : integer;
  NewPos  : integer;
  OldPt   : TPoint;
  Count   : integer;
  S       : string;
begin

  BeginUndoBlock;
  try
    if SelectionType = stNotSelected then
      Count := 0
    else
    begin
      with SelectionRect do
        Count := abs(Bottom - Top) + 1;
      if Count <= 1 then
        DeleteBlock;
    end;

    OldPt := CaretPoint;
    OldPos := CurCharPos;
    CurLine := GetCurLine;

    BeginUpdate(acPressTab);
    i := 0;
    while OldPos >= GetVirtualTabStop(i) do
      inc(i);
    NewPos := GetSmartTabPos(i, OldPos, CurLine);

    if soUseTabCharacter in FOptions  then
      S := #9
    else
      S := StringOfSpace(NewPos - OldPos);

    if Count > 1 then
    begin
      FTabString := S;
      IndentBlock;
      FTabString := '';
    end
    else
    begin
      if OverWrite then
        CurCharPos := Newpos
      else
        if Insert(S) then
          if soUseTabCharacter in FOptions then
            TabCursorRight
          else
            CurCharPos := Newpos;
    end;
    EndUpdate;
  finally
    EndUndoBlock;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.PressShiftTab;
var
  p       : integer;
  i       : integer;
  Count   : integer;
  NewPos  : integer;
  CurLine : integer;
begin
  if SelectionType = stNotSelected then
  begin
    Count := 0;
    p := CurCharPos;
    CurLine := GetCurLine;
  end
  else
    with SelectionRect do
    begin
      Count := abs(Bottom - Top) + 1;
      p := Left;
      CurLine := Min(Bottom, Top);
    end;
  i := 0;
  while p > GetVirtualTabStop(i) do
    inc(i);

  if Count > 1 then
  begin
    NewPos := GetSmartTabPos(i, p, CurLine);
//    NewPos := GetVirtualTabStop(i);
    FTabString := StringOfSpace(NewPos - p);
    OutDentBlock;
    FTabString := '';
  end
  else
  begin
    if i < 1
    then
      CurCharPos := 0
    else
      CurCharPos := GetVirtualTabStop(i - 1);
  end
end;

{--------------------------------------------}

procedure TCustomMemoSource.PressEnter;

  {--------------------------------------------}

  function GetIndentPos(StartLine : integer) : integer;
  var
    i : integer;
  begin
    result := 0;
    for i := StartLine downto 0 do
      if Strings[i] <> '' then
      begin
        result := GetFirstNotSpace(Strings[i]);
        break;
      end;
  end;

  {--------------------------------------------}

  function ChangeToSpace(const s : string) : string;
  var
    i : integer;
  begin
    result := s;
    for i := 1 to Length(result) do
      if result[i] <> #9 then
        result[i] := ' ';
  end;

  {--------------------------------------------}

  procedure InInsertMode;
  var
    IndentPos : integer;
    S         : string;
    RealS     : string;
    CurLine   : integer;
    CurChar   : integer;
    i         : integer;
    OldPos    : integer;
    Pos       : integer;
  begin
    CurLine := GetCurLine;
    CurChar := GetCurChar;
    S := Strings[CurLine];
    if FOptions * [soUsePrevIndent, soAutoIndent, soUseTabCharacter] =  [soUsePrevIndent, soAutoIndent, soUseTabCharacter] then
      with TInternalStrings(GetStrings) do
        RealS := GetRealString(CurLine)
    else
      RealS := '';

    BreakLine;
    IndentPos := 0;

    {$IFDEF DCMBCS}
    CurChar := _CharToByte(s, CurChar +  1) - 1;
    {$ENDIF}

    if soAutoIndent in FOptions then
    begin
      if (Length(S) = 0) or ((CurChar = 0) and (S[1] <> ' ')) or
        ((CurChar <> 0) and (GetFirstNotSpace(S) <= CurChar)) then
        IndentPos := GetIndentPos(CurLine) - 1
      else
        IndentPos := CurChar;
    end;

    JumpTo(0, CurLine + 1);

    if not (soAutoIndent in FOptions) then
      exit;

    if (soUseTabCharacter in FOptions) then
    begin
      if soUsePrevIndent in FOptions then
      begin
        if RealS <> '' then
        begin
          Insert(ChangeToSpace(Copy(RealS, 1, GetRealTabIndex(RealS, IndentPos))));
          JumpToChar(IndentPos);
          exit;
        end;
      end;

      if (soOptimalFill in FOptions)  then
      begin
        i := 0;
        OldPos := 0;
        Pos := GetVirtualTabStop(i);
        while IndentPos >= Pos - 1 do
        begin
          OldPos := Pos;
          inc(i);
          Pos := GetVirtualTabStop(i);
        end;
        if i <> 0 then
          Insert(StringOfChar(#9, i) + StringOfSpace(IndentPos + 1 - OldPos))
        else
          Insert(StringOfSpace(IndentPos));
      end
      else
        Insert(StringOfSpace(IndentPos));
    end
    else
      Insert(StringOfSpace(IndentPos));
    JumpToChar(IndentPos);
  end;


  {--------------------------------------------}

  procedure InOverwriteMode;
  var
    IndentPos : integer;
    CurLine   : integer;
    CurChar   : integer;
    s         : string;
  begin
    CurLine := GetCurLine;
    CurChar := GetCurChar;
    s := Strings[CurLine];
    {$IFDEF DCMBCS}
    CurChar := _CharToByte(s, CurChar + 1) - 1; 
    {$ENDIF}
    if soAutoIndent in FOptions then
    begin
      IndentPos := GetFirstNotSpace(s) - 1;
      if (CurChar <= IndentPos) and (s <> '') then
        IndentPos := CurChar
      else
        IndentPos := GetFirstNotSpace(Strings[CurLine + 1]) - 1;
    end
    else
      IndentPos := 0;
    CursorDown;
    IndentPos := GetMemoIndent(IndentPos);
    JumpToChar(IndentPos);
  end;

  {--------------------------------------------}

begin
  BeginUpdate(acPressEnter);
  if FOverwrite  then
    InOverwriteMode
  else
  begin
    CheckOverwriteBlock;
    InInsertMode;
  end;
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ChangeBlockTo(const S : string);
var
  OldPos  : integer;
  OldLine : integer;
begin
  BeginUpdate(acChangeBlockTo);
  with SelectionRect do
  begin
    OldPos := Left;
    OldLine := Top;
  end;
  DeleteBlock;
  JumpTo(oldPos, OldLine);
  InsertString(S);
  EndUpdate;
end;

{--------------------------------------------}

function  TCustomMemoSource.GetOverwrite : boolean;
begin
  result := FOverwrite;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetOverwrite(V : boolean);
begin
  if V <> FOverwrite then
  begin
    BeginUpdate(acInsState);
    FOverwrite := V;
    Include(FState, msInsState);
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetInsertMode;
begin
  Overwrite := false;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetSelectionType(V : TSelectionType);
begin
  if V <> FSelectionType then
  begin
    BeginUpdate(acSetSelType);
    FSelectionType := V;
    CheckSelectionType(FSelectionType);
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.InsertDate;
begin
  InsertString(DateToStr(Now));
end;

{--------------------------------------------}

procedure TCustomMemoSource.InsertTime;
begin
  InsertString(TimeToStr(Time));
end;

{--------------------------------------------}
{$IFNDEF CLX}

procedure TCustomMemoSource.InsertGUID;
var
  Guid : TGuid;
begin
  CoCreateGuid(Guid);
  InsertString('[''' + GUIDToString(Guid) + ''']');
end;

{$ENDIF}

{--------------------------------------------}

procedure TCustomMemoSource.CapitalizeWord;
begin
  DoWithBlock(acCapitalizeWord, MarkWord, CapitalizeBlock, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.CapitalizeLine;
begin
  DoWithBlock(acCapitalizeLine, MarkLine, CapitalizeBlock, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.CapitalizeBlock;
begin
  DoWithBlockStr(acCapitalizeBlock, FCapitalizeStr, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.FCapitalizeStr(var S : string);
var
  firstchar : boolean;
  i         : integer;
  len       : integer;
begin
  FLowerCaseStr(S);
  len := Length(S);
  i  := 1;
  while i <= len do
  begin
    FirstChar := not InDelimSet(S, i);
    if i <> 1 then
      Firstchar := Firstchar and InDelimSet(S, i - 1);
    if FirstChar then
    begin
      {$IFDEF DCMBCS}
      if SysLocale.FarEast and (s[i] in LeadBytes) then
      begin
        inc(i, 2);
        continue;
      end;
      {$ENDIF}
      S[i] := AnsiUpperCase(S[i])[1];
    end;
    inc(i);
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.FIndentBlockStr(var S : string);
begin
  if S = '' then
    exit;
  if FTabString = '' then
    System.Insert(StringOfSpace(FBlockIndent), s, 1)
  else
    System.Insert(FTabString, s, 1)
end;

{--------------------------------------------}

procedure TCustomMemoSource.FOutDentBlockStr(var S : string);
var
  count   : integer;
  tempstr : string;
begin
  if FTabString = '' then
    tempstr := copy(S, 1, FBlockIndent)
  else
    tempstr := copy(S, 1, Length(FTabString));
  count := _Length(tempstr);
  tempstr := _TrimLeft(tempstr);
  dec(count, length(tempstr));
  if count <> 0 then
    System.Delete(s, 1, count);
end;

{--------------------------------------------}

procedure TCustomMemoSource.IndentBlock;
begin
  DoWithBlockStr(acIndentBlock, FIndentBlockStr, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.OutDentBlock;
begin
  DoWithBlockStr(acOutdentBlock, FOutDentBlockStr, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetOverwriteMode;
begin
  Overwrite := true;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleInsMode;
begin
  Overwrite := not Overwrite;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleWordCase;
begin
  DoWithBlock(acToggleWordCase, MarkWord, ToggleBlockCase, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.FSetBookMark(Index : integer; Num : byte);
begin
  if (Index < 0) or (Index >= GetStrings.Count) then
    exit;
  FBookMarkList.SetBookMark(Point(0, Index), Num);
  UpdateGutterImg(Index);
end;

{--------------------------------------------}

procedure TCustomMemoSource.UpdateGutterImg(Index : integer);
var
  OState : TMemoStates;
begin
  BeginUpdate(acSetImageBit);
  OState := FState;
  UpdateChanged(Index, Index);
  FState := OState + [msBlockChanged];
  EndUpdate;
end;

{--------------------------------------------}

function  TCustomMemoSource.FGetBookmark(Index : integer) : byte;
begin
  if (Index < 0) or (Index >= GetStrings.Count) then
    result := 0
  else
    result := FBookMarkList.GetBookMarkForLine(Index);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMarkForLine(BookMarkNumber : TBookMarkNumber; LinePos : integer);
begin
  BeginSafeUpdate(acSetBookmark);
  try
    JumpToLine(LinePos);
    if CurLinePos = LinePos then
      ToggleBookMark(BookMarkNumber);
  finally
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark(BookMarkNumber : TBookmarkNumber);
var
  Pt : TBookMarkRec;
begin
  if BookMarkNumber = 0 then
    exit;
  if FBookMarkList.FindBookMark(BookMarkNumber, Pt) and (Pt.Y = CurLinePos) then
    ClearBookmark(BookMarkNumber)
  else
    SetBookmark(BookMarkNumber)
end;

{--------------------------------------------}

function TCustomMemoSource.GetBookmarkFromRange(Line, FromChar, ToChar : integer) : integer;
begin
  result := FBookMarkList.GetBookmarkFromRange(Line, FromChar, ToChar);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GetBookmarksFromRange(Line, FromChar, ToChar : integer; List : TList);
begin
  FBookMarkList.GetBookmarksFromRange(Line, FromChar, ToChar, List);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ClearBookmark(BookMarkNumber : TBookmarkNumber);
var
  Index : integer;
begin
  if BookMarkNumber = 0 then
    exit;
  BeginUpdate(acClearBookmark);
  if FBookMarkList.ClearBookMark(BookMarkNumber, Index) then
    UpdateGutterImg(Index);
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetBookmark(BookMarkNumber : TBookmarkNumber);
begin
  if BookMarkNumber = 0 then
    exit;
  BeginUpdate(acSetBookmark);
  ClearBookMark(BookMarkNumber);
  FBookMarkList.SetBookMark(CaretPoint, BookMarkNumber);
  UpdateGutterImg(GetCurLine);
  EndUpdate;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ClearImageBit(Index : integer);
var
  Item   : TStringItem;
  OState : TMemoStates;
begin
  Item := StringItem[Index];
  if Item <> nil then
  begin
    BeginUpdate(acSetImageBit);
    OState := FState;
    Item.FImageBits := 0;
    UpdateChanged(Index, Index);
    FState := OState + [msBlockChanged];
    EndUpdate;
  end;
end;

{--------------------------------------------}

function  TCustomMemoSource.FindBookMark(BookMarkNumber : TBookmarkNumber; var APoint : TPoint) : boolean;
var
  Pt : TBookMarkRec;
begin
  Pt.X := -1;
  Pt.Y := -1;
  result := (BookMarkNumber <> 0) and FBookMarkList.FindBookMark(BookMarkNumber, Pt);
  with Pt do
    APoint := Point(X, Y);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookmark(BookMarkNumber : TBookmarkNumber);
var
  Pt : TBookMarkRec;
begin
  if BookMarkNumber=0 then
    exit;
  if FBookMarkList.FindBookMark(BookMarkNumber, Pt) then
  begin
    FGotoBookMark := true;
    try
      JumpTo(Pt.X, Pt.Y);
    finally
      FGotoBookMark := false;
    end;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark0;
begin
  ToggleBookMark(10);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark1;
begin
  ToggleBookMark(1);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark2;
begin
  ToggleBookMark(2);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark3;
begin
  ToggleBookMark(3);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark4;
begin
  ToggleBookMark(4);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark5;
begin
  ToggleBookMark(5);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark6;
begin
  ToggleBookMark(6);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark7;
begin
  ToggleBookMark(7);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark8;
begin
  ToggleBookMark(8);
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleBookMark9;
begin
  ToggleBookMark(9);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark1;
begin
  GoToBookMark(1);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark0;
begin
  GoToBookMark(10);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark2;
begin
  GoToBookMark(2);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark3;
begin
  GoToBookMark(3);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark4;
begin
  GoToBookMark(4);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark5;
begin
  GoToBookMark(5);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark6;
begin
  GoToBookMark(6);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark7;
begin
  GoToBookMark(7);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark8;
begin
  GoToBookMark(8);
end;

{--------------------------------------------}

procedure TCustomMemoSource.GoToBookMark9;
begin
  GoToBookMark(9);
end;

{--------------------------------------------}

function TCustomMemoSource.Find : boolean;
var
  Len : integer;
begin
  with SearchOptions do
  begin
    FirstSearch := true;
    InReplace := false;
    ShowNotFound := true;
  end;
  result := InternalFind(Len);
end;

{--------------------------------------------}

function TCustomMemoSource.FindModifiedRecord(ACount : integer) : integer;
var
  i : integer;
begin
  with CurrentUndoList do
  begin
    ACount := Min(ACount, Count);
    for i := ACount - 1 downto 0 do
    begin
      result := i;
      if not (PUndoRecord(Items[i])^.FOperation in [soNavigate, soUpdateColorData]) then
        exit;
    end;
  end;
  result := -1;
end;

{--------------------------------------------}

procedure TCustomMemoSource.CheckModified(Value : boolean);
begin
  SafeCheckModified(Value, true);
end;

{--------------------------------------------}

procedure TCustomMemoSource.SafeCheckModified(Value : boolean; WithUpdate : boolean);
begin
  if FModified <> Value then
  begin
    if WithUpdate then
      BeginUpdate(acChangeModified);
    FModified := Value;
    if not Value then
      FSaveModifiedIdx := FindModifiedRecord(MaxInt);
    if WithUpdate then
      EndUpdate;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetModified(V : boolean);
begin
  FSaveModified := V;
  CheckModified(V);
end;

{--------------------------------------------}

function TCustomMemoSource.InternalReplace : boolean;
var
  StoreData : boolean;
  
  {---------------------------------------}

  function DoReplace : boolean;
  var
    Mres : integer;
    Len  : integer;
  begin
    with SearchOptions do
    begin
      result := not GetReadOnly and InternalFind(Len);
      if result = false then
        exit;
      if PromptOnReplace then
        Mres := MessageDlg(Format(SAskReplace, [DisplayTextToFind]),
                {$IFNDEF CLX} mtConfirmation,{$ELSE}mtWarning,{$ENDIF} [mbYes, mbNo, mbCancel{$IFNDEF CLX},mbAll{$ENDIF}], 0)
      else
        Mres:=mrYes;

      case Mres of
        mrYes, mrAll:
          begin
            if Mres = mrAll then
            begin
              PromptOnReplace := false;
              ReplaceAll := true;
              Self.BeginUpdate(acreplace);
            end;
            FManualPosition := true;
            try
              Self.BeginUpdate(acReplace);
              if Direction = sdForward then
              begin
                Navigate(0, - Len);
                if StoreData then
                begin
                  FDefaultAttribute := -1;
                  with CaretPoint do
                    if Len = 0 then
                      FDefaultAttribute := GetAttr(Point(X, Y))
                    else
                      FDefaultAttribute := GetAttr(Point(X + 1, Y));
                end;
                DeleteRight(Len);
                if ReplaceWith <> '' then
                begin
                  Insert(ReplaceWith);
                  Navigate(0, _Length(ReplaceWith));
                end;
              end
              else
              begin
                DeleteRight(Len);
                Insert(ReplaceWith);
              end;
              inc(FReplacedCount);
            finally
              FManualPosition := false;
            end;
            Self.EndUpdate;
          end;
        mrCancel:
          result := false;
      end;
    end;
  end;

  {---------------------------------------}

  function DoAll : boolean;
  begin
    with SearchOptions do
    begin
      if not PromptOnReplace then
        Self.BeginUpdate(acreplace);
      try
        repeat
          if not PromptOnReplace then
            Screen.Cursor := crHourGlass;
          result := DoReplace;
          ShowNotFound := false;
        until not result;
      finally
        if not PromptOnReplace  then
        begin
          FFoundRect := Rect(0, 0, 0, 0);
          while FUpdateCount > 0 do
            Self.EndUpdate;
          Screen.Cursor := crDefault;
        end;
      end;
    end;
  end;
  {---------------------------------------}

begin

  FReplacedCount := 0;
  result := false;
  if ReadOnly then
    exit;
  StoreData := StoreColorData;
  inc(FSkipClearSelection);
  BeforeFindReplace(true);
  try
    with SearchOptions do
    begin
      if ReplaceAll then
        result := DoAll
      else
        begin
          result := DoReplace;
          ShowNotFound := false;
          if result and ReplaceAll then
            result := DoAll;
        end;
    end;
  finally
    dec(FSkipClearSelection);
    if StoreData then
      FDefaultAttribute := -1;
  end;
end;

{--------------------------------------------}

function TCustomMemoSource.Replace : boolean;
begin
  with SearchOptions do
  begin
    FirstSearch := true;
    InReplace := true;
    ShowNotFound := true;
  end;
  result := InternalReplace;
end;

{--------------------------------------------}

function SearchinStrings(S : TStrings; SrchOptions : TSearchOptions; var P : TPoint; var Len : integer;  
           const DelimSet : TCharSet) : boolean;
var
  OldP : TPoint;

  procedure IfFirstSearch;
  begin
    with SrchOptions do
      if FirstSearch then
      begin
        if Origin = soEntireScope then
          with P do
            if Direction = sdForward then
            begin
              X := 1;
              Y := 0;
            end
            else
            begin
              Y := S.Count - 1;
              X := Length(S[Y]);
            end;
        FirstSearch := false;
      end;
  end;

var
  SearchParams : TSearchParams;
begin
  result := false;
  if (S.Count = 0) then
    exit;
  IfFirstSearch;

  SearchParams:=[];

  with SrchOptions do
  begin
    if CaseSensitive then
      Include(SearchParams, spCaseSens);

    if WholeWordsOnly then
      Include(SearchParams, spWholeWords);

    if Direction=sdBackward then
      Include(SearchParams, spBackSearch);

    if RegularExpr then
      with TRegExpr.Create(TextToFind, CaseSensitive) do
      try
        if EmptyLineStr(TextToFind) then
        begin
          if Direction = sdForward then
            inc(P.X)
          else
            dec(P.X);
        end;
        OldP := P;
        result := FindInStringsEx(TextToFind, S, SearchParams, DelimSet, P, Len, Find);
        with P do
          if (Direction = sdForward) and (Len = 0) and (X = OldP.X) and (Y = OldP.Y) and (Y < S.Count)then
            if X < length(S[Y]) then
              inc(X)
            else
            if Y < S.Count - 1 then
            begin
              X := 0;
              inc(Y);
            end;
      finally
        Free;
      end
    else
      result := FindInStringsEx(TextToFind, S, SearchParams, DelimSet, P, Len, nil);
  end;
end;             

{--------------------------------------------}

procedure TCustomMemoSource.KeyMoveBlock;
begin
  MoveBlock;
end;

{--------------------------------------------}

procedure TCustomMemoSource.KeyFindNext;
begin
  FindNext;
end;

{--------------------------------------------}

procedure TCustomMemoSource.KeyReplace;
begin
  Replace;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleCaseSensitiveSearch;
begin
  with SearchOptions do
    CaseSensitive := not CaseSensitive;
end;

{--------------------------------------------}

procedure TCustomMemoSource.ToggleRegularExprSearch;
begin
  with SearchOptions do
    RegularExpr := not RegularExpr;
end;

{--------------------------------------------}

function TCustomMemoSource.FindNext : boolean;
var
  Len : integer;
begin
  with SearchOptions do
  begin
    ShowNotFound := true;

    if SelStrings.Count = 0 then
      Scope := ssGlobal;

    if not FirstSearch then
    begin
      if InReplace then
        result := InternalReplace
      else
        result := InternalFind(Len);
    end
    else
      result := false;
  end;
end;

{--------------------------------------------}

function TSearchOptions.GetDisplayTextToFind : string;
begin
  result := AddCharOccurence(TextToFind, '&', 1);
end;

{--------------------------------------------}

function  TCustomMemoSource.HandleSearchException(const Error : string) : boolean;
begin
  result := not ModalSearchAndReplace;
  if Assigned(FOnSearchException) then
    FOnSearchException(Self, Error, result);
end;

{--------------------------------------------}

procedure TCustomMemoSource.BeforeFindReplace(InReplace : boolean);
begin
  if Assigned(FOnBeforeFindReplace) then
    FOnBeforeFindReplace(Self, InReplace);
end;

{--------------------------------------------}

function TCustomMemoSource.InternalFind(var Len : integer) : boolean;
var
  P        : TPoint;
  S        : TStrings;
  AHandled : boolean;
  ACursor  : boolean;
  {$IFDEF DCMBCS}
  ts       : string;
  {$ENDIF}
  ALen     : integer;
  {---------------------------------------}

  procedure TextNotFound;
  var
    err : string;
  begin
    if SearchOptions.ShowNotFound then
    begin
      err := Format(SErrNotFound, [SearchOptions.DisplayTextToFind]);
      if not HandleSearchException(err) then
        MessageDlg(err, mtInformation, [mbOK], 0);
    end;
  end;

  {---------------------------------------}

begin
  AHandled := false;
  Len := 0;
  inc(FSkipClearSelection);
  BeforeFindReplace(false);
  try
    result := false;
    with SearchOptions do
      if (Scope = ssSelectedText) and (SelStrings.Count = 0) then
        if FirstSearch then
        begin
          if not HandleSearchException(SErrEmptySel) then
            raise Exception.Create(SErrEmptySel)
          else
            exit;
        end
        else
          exit;
    BeginUpdate(acFind);
    with SearchOptions do
    try
      if WholeWordsOnly and not RegularExpr then
        WholeWordsOnly := (Length(TextToFind) = Length(RemoveCharSet(FDelimSet, TextToFind)));

      if (Scope = ssSelectedText) then
      begin
        if FirstSearch and (Origin = soFromCursor) and (not IsPosInBlock(GetCurChar, GetCurLine)) then
          if not HandleSearchException(SErrOutsideSel) then
            raise Exception.Create(SErrOutsideSel)
          else
            exit;
        S := SelStrings;
        P := PointToSelPoint(CaretPoint);
      end
      else
      begin
        S := GetStrings;
        P := CaretPoint;
      end;
      {$IFDEF DCMBCS}
      with P do
      begin
        ts := Lines[Y];
        X := _CharToByte(ts, X + 1) - 1;
      end;  
      {$ENDIF}
      if Direction = sdForward then
      {$IFDEF DCMBCS}
      with P do
        if _IsLeadByte(ts, X + 1) then
          inc(X, 2)
        else
          inc(X);
      {$ELSE}
      inc(P.X);
      {$ENDIF}
      try
        ACursor := Screen.Cursor <> crHourGlass;
        if ACursor then
          Screen.Cursor := crHourGlass;
        try
          result := SearchinStrings(S, SearchOptions, P,  Len, FDelimSet);
        finally
          if ACursor then
            Screen.Cursor := crDefault;
        end;
      except
        if not HandleSearchException(Exception(ExceptObject).Message) then
          MessageDlg(Exception(ExceptObject).Message, mtInformation, [mbOK], 0);
        AHandled := true;
      end;
      if result then
      begin
        if Scope = ssSelectedText then
          P := SelPointToPoint(P);
        with P do
        begin
          if X > 0 then
            Dec(X);
          {$IFDEF DCMBCS}
          with P do
          begin
            ts := Lines[Y];
            ALen := _ByteToChar(ts, X + Len + 1) - 1;
            X := _ByteToChar(ts, X + 1) - 1;
          end;
          {$ELSE}
            ALen := X + Len;
          {$ENDIF}
          FFoundRect := Rect(X, Y, ALen , Y + 1);
          if (soSelectFoundText in FOptions)  and ((SelectionType = stNotSelected) or (Scope = ssGlobal)) then
          begin
            SelectionRect := Rect(X, Y, ALen, Y);
            SelectionType := stStreamSel;
          end;
          if Direction = sdForward then
            X := ALen;
        end;
        CaretPoint := P;
      end
      else
      if not AHandled then
        TextNotFound;
    finally
      Self.EndUpdate;
    end;
  finally
    dec(FSkipClearSelection);
  end;
end;

{--------------------------------------------}

function TCustomMemoSource.GetCaretPoint : TPoint;
begin
  with result do
  begin
    X := CurCharPos;
    Y := CurLinePos;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetCaretPoint(const P : TPoint);
begin
  with P do
    JumpTo(X, Y);
end;

{--------------------------------------------}

function TCustomMemoSource.PointToSelPoint(const P : TPoint) : TPoint;
begin
  with SelectionRect, result do
    case FSelectionType of
      stNotSelected:
        result := P;
      stStreamSel:
        begin
          Y := P.Y - Top;
          X := P.X;
          if Y = 0 then
            Dec(X, Left);
        end;
      stBlockSel:
        begin
          Y := P.Y - Top;
          X := P.X - Left;
        end;
    end;
end;

{--------------------------------------------}

function TCustomMemoSource.SelPointToPoint(const P : TPoint) : TPoint;
begin
  with SelectionRect, result do
    case FSelectionType of
      stNotSelected:
        result := P;
      stStreamSel:
        begin
          X := P.X;
          if P.Y = 0 then
            Inc(X, Left);
          Y := P.Y + Top;
        end;
      stBlockSel:
        begin
          Y := P.Y + Top;
          X := P.X + Left;
        end;
    end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SetTabStops(V : string);
var
  S      : TStringList;
  i      : integer;
  AValue : integer;
begin
  if (FtabStops <> V) and (V <> '') then
  begin
    S := TStringList.Create;
    try
      S.CommaText := V;
      for i := 0 to S.Count - 1 do
      begin
        AValue := StrToInt(S[i]);
        S.Objects[i] := Pointer(AValue);
        if (AValue <= 0) or ((i > 0) and (integer(S.Objects[i]) <= integer(S.Objects[i - 1]))) then
          raise Exception.Create(SInvalidTabRack);
      end;
      FTabStopList.Clear;
      for i := 0 to S.Count - 1 do
        FTabStopList.Add(S.Objects[i]);
      FTabStops := V;
      if FTabStopList.Count = 0 then
        FTabStopList.Add(Pointer(8));
    finally
      S.Free;
    end;
  end;
  if soUseTabCharacter in FOptions then
  begin
    UpdateChanged(0, MaxInt);
    ParserChanged;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JustifyBlock; 
var
  Sl        : TStrings;
  Alen      : integer;
  i         : integer;
  ABlockSel : boolean;
  Pt        : TPoint;
  OldPos    : TPoint;
begin
  if SelectionType = stNotSelected then
    exit;
  Sl := TStringList.Create;
  try
    Sl.Text := FSelStrings.Text;
    ALen := 0;
    for i := 0 to Sl.Count - 1 do
      ALen := Max(ALen, length(Sl[i]));
    ExpandStrings(Sl, Alen);
    ABlockSel := SelectionType = stBlockSel;
    with SelectionRect do
      Pt := Point(Left, Top);
    OldPos := Point(GetCurChar, GetCurLine);
    BeginUpdate(acPasteBlock);
    try
      DeleteBlock;
      JumpTo(Pt.X, Pt.Y);
      PasteBlockFromStrings(Sl, ABlockSel);
      JumpTo(OldPos.X, OldPos.Y);
      SelectionType := stNotSelected;
    finally
      EndUpdate;
    end;
  finally
    Sl.Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.AssignLines(AStrings : TStrings; ASelected : boolean);
var
  ASkip : boolean;
  i     : integer;
begin
  ASkip := soExcludeReadOnlyLines in FOptions;
  if not ASkip then
  begin
    if ASelected then
      AStrings.Assign(SelStrings)
    else
      AStrings.Assign(Lines);
    exit;
  end;
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    if ASelected then
    begin
      with SelectionRect do
        for i := 0 to SelStrings.Count - 1 do
          if not GetLineReadOnly(i + Top) then
            AStrings.Add(SelStrings[i])
    end
    else
      for i := 0 to Lines.Count - 1  do
        if not GetLineReadOnly(i) then
          AStrings.Add(Lines[i]);

  finally
    AStrings.EndUpdate;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.JustifyText;     
var
  ALen   : integer;
  i      : integer;
begin
  ALen := 0;
  with GetStrings do
    for i := 0 to Count - 1 do
      ALen := Max(ALen, length(Strings[i]));
  ExpandStrings(GetStrings, Alen);
  ClearUndoBuffer;
  ParserChanged;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.IsSyntaxParser : boolean;
begin
  result := (SyntaxParser <> nil) and (CompareText(SyntaxParser.ClassName, 'TSyntaxParser') = 0);// don't resource;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.FindWord(s : string; Pt : TPoint; WholeWord , Direction : boolean) : integer;
var
  line   : string;
  colors : string;

  function ValidPos(P : integer) : boolean;
  begin
    if not IsSyntaxParser then
      result := ((P > length(colors)) or not (byte(colors[P]) in [tokComment, tokString]))
    else
      result := true;
    if result and WholeWord then
        result := ((P = 1) or ((P > 1) and (line[P - 1] in DelimSet))) and
        ((P + length(s) > length(line)) or ((P + length(s) <= length(line)) and InDelimSet(line, P + length(s))));
  end;

begin

  line := Strings[Pt.Y];
  colors := GetStoredColorData(Pt.Y);
  if Direction then
  begin
    result := _StrPos(s, line, Pt.X + 1);
    while result <> 0 do
    begin
      if ValidPos(result) then
        break;
      result := _StrPos(s, line, result + 1);
    end
  end
  else
  begin
    if Pt.X > 1 then
      result := _StrBackPos(s, line, Pt.X - 1)
    else
      result := 0;
    while result <> 0 do
    begin
      if ValidPos(result) then
        break;
      result := _StrBackPos(s, line, result - 1);
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.NextBracket;
var
  ch   : char;
  P    : TPoint;
  NewP : TPoint;
begin
  BeginUpdate(acNavigate);
  P := CaretPoint;
  try
    ch := CorrectCharUnderCursor(NewP);
    if (ch in ['{', '[', '(', '<']) then
    begin
      CaretPoint := NewP;
      if not FindCloseBracket(ch, true, NewP) then
        CaretPoint := P;
    end;
  finally
    EndUpdate;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.PrevBracket;
var
  ch   : char;
  P    : TPoint;
  NewP : TPoint;
begin
  BeginUpdate(acNavigate);
  P := CaretPoint;
  try
    ch := CorrectCharUnderCursor(NewP);
    if (ch in ['}', ']', ')', '>']) then
    begin
      CaretPoint := NewP;
      if not FindOpenBracket(ch, true, NewP) then
        CaretPoint := P;
    end;
  finally
    EndUpdate;
  end;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.CorrectCharUnderCursor(var P : TPoint) : char;
var
  s      : string;
  line   : string;
  colors : string;
begin
  result := #0;
  with SelStrings do
    if (Count = 1) and (Length(Strings[0]) = 1) then
      P := SelectionRect.TopLeft
    else
      P := CaretPoint;

  with P do
  begin
    s := Lines[Y];
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      X := _CharToByte(s, X + 1) - 1;
    {$ENDIF}
    if (X >= Length(s))  then
      exit;
    line := Strings[Y];
    colors := GetStoredColorData(Y);

    if not IsSyntaxParser and (X < length(colors)) and (byte(colors[X + 1]) in [tokComment, tokString]) then
      exit;

    result := s[X + 1];
  end;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.FindNextBracket;
var
  ch : char;
  P  : TPoint;
begin
  ch := CorrectCharUnderCursor(P);
  if (ch in ['{', '[', '(', '<']) then
    NextBracket
  else
  if (ch in ['}', ']', ')', '>']) then
    PrevBracket;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.FindCloseBracket(openbr : char; JumpifFound : boolean; var APoint : TPoint) : boolean;
var
  Pt      : TPoint;
  l       : integer;
  r       : integer;
  count   : integer;
  closebr : char;

  function FindBracket(s : string) : integer;
  begin
    result := FindWord(s, Pt, false, true);
  end;

begin
  Pt := APoint;
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    with Pt do
      X := _CharToByte(Lines[Y], X + 1) - 1;
  {$ENDIF}


  if openbr = '{' then
    closebr := '}'
  else
  if openbr = '[' then
    closebr :=  ']'
  else
  if openbr = '<' then
    closebr := '>'
  else
    closebr := ')';

  inc(Pt.X);
  count := 1;
  while count > 0 do
  begin
    l := FindBracket(openbr);
    r := FindBracket(closebr);
    if l = 0 then
      if r = 0 then
      begin
        inc(Pt.Y);
        Pt.X := 0;
      end
      else
      begin
        Pt.X := r;
        dec(count);
      end
    else
      if r = 0 then
      begin
        Pt.X := l;
        inc(count);
      end
      else
      begin
        if r < l then
        begin
          Pt.X := r;
          dec(count);
          if count = 0 then
            break;
        end
        else
        begin
          Pt.X := l;
          inc(count);
        end;
      end;
    if Pt.Y > Lines.Count then
      break;
  end;
  result := count = 0;
  if result then
  begin
    dec(Pt.X);
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      with Pt do
        X := _ByteToChar(Lines[Y], X + 1) - 1;
    {$ENDIF}
    if JumpifFound  then
      CaretPoint := Pt;
    APoint := Pt;
  end;
end;

{-------------------------------------------------------------}

function  TCustomMemoSource.FindOpenBracket(closebr : char; JumpifFound : boolean; var APoint : TPoint) : boolean;
var
  Pt      : TPoint;
  l       : integer;
  r       : integer;
  count   : integer;
  openbr  : char;

  function FindBracket(s : string) : integer;
  begin
    result := FindWord(s, Pt, false, false);
  end;

begin
  Pt := APoint;
  {$IFDEF DCMBCS}
  if SysLocale.FarEast then
    with Pt do
      X := _CharToByte(Lines[Y], X + 1) - 1;
  {$ENDIF}

  if closebr = '}' then
    openbr := '{'
  else
  if closebr = ']' then
    openbr :=  '['
  else
  if closebr = '>' then
    openbr := '<'
  else
    openbr := '(';
  inc(Pt.X);

  count := 1;
  while count > 0 do
  begin
    r := FindBracket(closebr);
    l := FindBracket(openbr);
    if l = 0 then
      if r = 0 then
      begin
        dec(Pt.Y);
        Pt.X := length(Lines[Pt.Y]) + 1;
      end
      else
      begin
        Pt.X := r;
        inc(count);
      end
    else
      if r = 0 then
      begin
        Pt.X := l;
        dec(count);
      end
      else
      begin
        if r < l then
        begin
          Pt.X := l;
          dec(count);
          if count = 0 then
            break;
        end
        else
        begin
          Pt.X := r;
          inc(count);
        end;
      end;
    if Pt.Y < 0  then
      break;
  end;
  result := count = 0;
  if result then
  begin
    dec(Pt.X);
    {$IFDEF DCMBCS}
    if SysLocale.FarEast then
      with Pt do
        X := _ByteToChar(Lines[Y], X + 1) - 1;
    {$ENDIF}
    if JumpifFound  then
      CaretPoint := Pt;
    APoint := Pt;  
  end;
end;

{--------------------------------------------}

procedure TSelectionStrings.Clear;
begin
  FMemoSource.DeleteBlock;
end;

{--------------------------------------------}

procedure TSelectionStrings.Delete(Index: integer);
begin
end;

{--------------------------------------------}

procedure TSelectionStrings.Insert(Index : integer; const S : string);
begin
end;

{--------------------------------------------}

function TSelectionStrings.Get(Index : integer) : string;
begin
  result := GetEx(Index, false)
end;

{--------------------------------------------}

function TSelectionStrings.GetEx(Index : integer; UseColorData : boolean): string;
var
  R : TRect;
  s : string;

  {-------------------------------------}

  function _Get(a : integer; IncIfLead : boolean) : integer;
  begin
    {$IFDEF DCMBCS}
    result := _CharToByte(s, a);
    if IncIfLead and _IsLeadByte(s, result) then
      inc(result);
    {$ELSE}
    result := a;
    {$ENDIF}
    FMemoSource.ChangeTabIndex(s, result);
  end;

  {-------------------------------------}

  procedure AssignResult(a : integer);
  var
    ALeft : integer;
  begin
    with R do
    begin
      ALeft := _Get(Left + 1, false);
      a := _Get(a, true) - ALeft + 1;
      result := Copy(s, ALeft, a);
    end;
    AddBackSpaces(result, a);
  end;

  {-------------------------------------}

begin
  with FMemoSource do
  begin
    R := SelectionRect;
    with R do
    begin
      if (FSelectionType = stNotSelected) or (Index < 0) or (Index >= Self.Count) then
      begin
        result := '';
        exit;
      end;
      if UseColorData then
        s := GetStoredColorData(Index + Top)
      else
        s := Strings[Index + Top];

      case FSelectionType of
        stStreamSel:
          begin
            if Top = Bottom  then
              AssignResult(Right)
            else
            begin
              if Index = 0 then
                result := Copy(s, _Get(Left + 1, false), MaxInt)
              else
                if Index = Bottom - Top then
                  result := Copy(s, 1, _Get(Right, true))
                else
                  result := s
            end;
          end;
        stBlockSel:
          AssignResult(Right + 1);
      end;
    end;
  end;
end;

{--------------------------------------------}

function TSelectionStrings.GetCount : integer;
begin
  with FMemoSource do
  begin
    if FSelectionType = stNotSelected then
      result := 0
    else
      with SelectionRect do
        result := Bottom - Top + 1;
  end;
end;

{--------------------------------------------}

constructor TSourceStrings.Create(MemoSource : TCustomMemoSource);
begin
  inherited Create;
  FMemoSource := MemoSource;
end;

{--------------------------------------------}

procedure TSelectionStrings.Exchange(Index1, Index2 : integer);
begin
end;

{--------------------------------------------}

procedure ClipboardToStrings(Strings : TStrings);
var
  s : string;
begin
  with Strings do
  begin
    BeginUpdate;
    Clear;
    {$IFNDEF CLX}
    if IsClipboardFormatAvailable(CF_TEXT) then
    {$ENDIF}
    begin
      s := ClipBoard.AsText;
      Text := s;
      if (s <> '') and RemoveExtraEol(s) then
        Add('');
    end;
    EndUpdate;
  end;
end;

{--------------------------------------------}

procedure ExpandTabsinStrings(FromStrings, ToStrings : TStrings; TabSize : integer);
var
  i : integer;
begin
  with ToStrings do
  begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to FromStrings.Count - 1 do
        Add(ExpandTabs(FromStrings.Strings[i], TabSize));
    finally
      EndUpdate;
    end;
  end;
end;

{-------------------------------------------------------------}

function ExpandTabs(const S :string; TabSize : integer) : string;
var
  i      : integer;
  TabStr : string;
begin
  result := S;
  TabStr := StringOfSpace(TabSize);
  i := 0;
  while true do
  begin
    i := TabPos(result, i + 1);
    if i = 0 then
      break;
    Delete(result, i, 1);
    System.Insert(TabStr, result, i);
  end;
end;

{-------------------------------------------------------------}

constructor TSearchOptions.Create;
begin
  FOrigin := soEntireScope;
  FWhere := swDirectories;
  inherited;
end;

{-------------------------------------------------------------}

destructor TSearchOptions.Destroy;
begin
  inherited;
end;

{-------------------------------------------------------------}

function TCustomMemoSource.SaveWithQuestion : boolean;
begin
  result := false;
  if (ObjectName <> '') and FModified then
  begin
    case MessageDlg(Format(SAskSaveFile,[ObjectName]), {$IFNDEF CLX} mtConfirmation,{$ELSE} mtWarning,{$ENDIF} [mbYes, mbNo, mbCancel], 0) of
      mrYes: Save;
      mrCancel: exit;
    end;
  end;
  result := true;
end;

{-------------------------------------------------------------}

function MemoSourceByName(const ObjectName : string) : TCustomMemoSource;
var
  i : integer;
begin
  for i := 0 to MemoSources.Count - 1 do
    if CompareText(TCustomMemoSource(MemoSources[i]).ObjectName, ObjectName) = 0 then
    begin
      result := MemoSources[i];
      exit;
    end;
  result := nil;
end;

{-------------------------------------------------------------}

procedure TCustomMemoSource.ProcessEscape;
begin
end;

{-------------------------------------------------------------}

function TCustomMemoSource.MemoNotify(Sender : TObject; var Msg : TMessage) : boolean;
begin
  result := true;
end;

{-------------------------------------------------------------}


Procedure TMemoSourceOptions.SetKeepTrailingBlanks(Value:Boolean);
Begin
  If FKeepTrailingBlanks=Value Then
    Exit;
  FKeepTrailingBlanks:=Value;
  Update;  
End;

procedure TMemoSourceOptions.SetOptions(V : TStringsOptions);
begin
  if FOptions <> V then
  begin
    FOptions := V;
    Update;
  end;
end;

{-------------------------------------------------------------}

procedure TMemoSourceOptions.SetTabStops(V : string);
begin
  if FTabStops <> V then
  begin
    FTabStops := V;
    Update;
  end;
end;

{-------------------------------------------------------------}

procedure TMemoSourceOptions.SetDelimeters(V : string);
begin
  if FDelimeters <> V then
  begin
    FDelimeters := V;
    Update;
  end;
end;

{-------------------------------------------------------------}

procedure TMemoSourceOptions.SetBlockIndent(V : integer);
begin
  V := max(0, V);
  if FBlockIndent <> V then
  begin
    FBlockIndent :=V;
    Update;
  end;
end;


{------------------------------------------------------------------}

procedure TMemoSourceOptions.Update;
var
  i : integer;
begin
  if UpdateDisabled then
    exit;

  with MemoSources do
    for i := 0 to Count - 1 do
      with TCustomMemoSource(Items[i]) do
        if UseGlobalOptions then
          LoadGlobalOptions;
end;

{------------------------------------------------------------------}

function  TMemoSourceOptions.GetKey : string;
begin
  result:='CodeEdit\MemoSource\'; //don't resource
end;

{------------------------------------------------------------------}

procedure TCustomMemoSource.SetUseGlobalOptions(val : boolean);
begin
  if val <> fUseGlobalOptions then
    begin
      if val then
        LoadGlobalOptions;
      fUseGlobalOptions := val;
    end;
end;

{------------------------------------------------------------------}

function GlobalMemoSourceOptions : TMemoSourceOptions;
begin
  result := TMemoSourceOptions(GetOptionsByClass(TMemoSourceOptions));
end;

{------------------------------------------------------------------}

procedure TCustomMemoSource.LoadGlobalOptions;
begin
  AssignPropsEx(GlobalMemoSourceOptions,Self,
    'Options,TabStops,Delimeters,BlockIndent');//don't resource
  LeaveSpacesAndTabs:=GlobalMemoSourceOptions.KeepTrailingBlanks;
end;

{------------------------------------------------------------------}

procedure TMemoSourceOptions.InitValues;
begin
  FOptions := cDefaultOptions;
  FTabStops := '9,17';//don't resource
  FBlockIndent := 1;
  FDelimeters := cDelphiDelimiters;
end;

{------------------------------------------------------------------}

function  TCustomMemoSource.GetUseGlobalOptions : boolean;
begin
  result := fUseGlobalOptions;
end;

{------------------------------------------------------------------}

function  TSearchOptions.GetKey : string;
begin
  result:='SearchOptions\'; //don't resource
end;

{--------------------------------------------}

{$IFNDEF CLX}
procedure TCustomMemoSource.LoadFromProp(Instance : TPersistent; const PropName : string);
var
  S : TStream;
begin
  if Instance = nil then
  begin
    Clear;
    exit;
  end;
  S := TPropStream.Create(Instance, PropName, DefaultOpenMode);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

{--------------------------------------------}

procedure TCustomMemoSource.SaveToProp(Instance : TPersistent; const PropName : string);
var
  S : TStream;
begin
  if Instance = nil then
    exit;
  S := TPropStream.Create(Instance, PropName, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;
{$ENDIF}

{------------------------------------------------------------------}

procedure TCustomMemoSource.SetTemplatesType(Value : string);
var
  Item : TObjectParamListItem;
  Proc : TCodeTemplateProc;
begin
  if FTemplatesType <> Value then
  begin
    Item := GetItemEx(TMemoCodeTemplates, [SCodeTemplateLang], [Value], [cpIgnoreCase]);
    if Item <> nil then
    begin
      FTemplatesType := Value;
      Proc := TCodeTemplateProc(integer(Item.Params[SCodeTemplatesProc]));
      if Assigned(Proc) then
        Proc(CodeTemplates);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMemoSource.SetCodeTemplates(Value : TMemoCodeTemplates) ;
begin
  FCodeTemplates.Assign(Value);
end;

{--------TMemoCodeTemplate-----------------------------------------}

procedure TMemoCodeTemplate.SetCode(Value : TStrings);
begin
  FCode.Assign(Value);
end;

{------------------------------------------------------------------}

constructor TMemoCodeTemplate.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FCode := TStringList.Create;
end;

{------------------------------------------------------------------}

destructor TMemoCodeTemplate.Destroy;
begin
  FCode.Free;
  inherited Destroy;
end;

{----------TMemoCodeTemplates--------------------------------------}

function  TMemoCodeTemplates.GetItem(Index : integer) : TMemoCodeTemplate;
begin
  result := TMemoCodeTemplate(inherited Items[Index]);
end;

{------------------------------------------------------------------}

procedure TMemoCodeTemplates.SetItem(Index : integer; Value : TMemoCodeTemplate);
begin
  inherited Items[Index] := Value;
end;

{------------------------------------------------------------------}

procedure TMemoCodeTemplates.FilterNames(CodeTempl : TList; const S : string; var NameFound : boolean);
var
  found : boolean;
  i     : integer;
  fs    : string;
begin
  CodeTempl.Clear;
  NameFound := false;
  found := S = '' ;
  fs  := UpperCase(S);
  if not found then
    for i := 0 to Count - 1 do
      if Pos(fs, UpperCase(Items[i].Name)) = 1 then
      begin
        found := true;
        if CompareText(S, Items[i].Name) = 0 then
        begin
          CodeTempl.Add(Items[i]);
          NameFound := true;
          exit;
        end;
        break;
      end;
  for i := 0 to Count - 1 do
    if not found or (fs = '') or (Pos(fs, UpperCase(Items[i].Name)) = 1) then
      CodeTempl.Add(Items[i]);
end;

{------------------------------------------------------------------}

function TMemoCodeTemplates.ConvertCodeTemplate(CodeTemplate : TMemoCodeTemplate) : string;
begin
  with CodeTemplate do                   
    result := Description + SSeparatorTag + SBoldTag + Name + SBoldTag
end;

{-------------------------------------------------------------}

function TMemoCodeTemplates.ConvertCodeTemplates(Strings : TStrings; const S : string) : integer;
var
  i     : integer;
  found : boolean;
  Lst   : TList;

  {-------------------------------------------------------------}

  function AddCodeTemplate(Item : Pointer) : integer;
  begin
    result := Strings.AddObject(ConvertCodeTemplate(TMemoCodeTemplate(Item)), Pointer(TMemoCodeTemplate(Item).Index));
  end;

  {-------------------------------------------------------------}

begin
  Strings.Clear;
  found := false;
  result := -1;
  lst := TList.Create;
  try
    FilterNames(Lst, S, found);
    if found then
      result := AddCodeTemplate(Lst[0])
    else
      for i := 0 to Lst.Count -1 do
        AddCodeTemplate(Lst[i])
  finally
    Lst.Free;
  end;
end;

{------------------------------------------------------------------}
//BeginSkipConst
const
  maxDelphiTemplate = 22;
  DelphiTemplates : array[0 .. maxDelphiTemplate -1 ] of TTemplateRec =
  (
    (
    AName  : 'arrayc';
    ADesc  : 'array declaration (const)';
    ACode  : 'array[0..|] of = ();';
    ),
    (
    AName  : 'arrayd';
    ADesc  : 'array declaration (var)';
    ACode  : 'array[0..|] of ;';
    ),
    (
    AName  : 'casee';
    ADesc  : 'case statement (with else)';
    ACode  : 'case | of'#13#10'  : ;'#13#10'  : ;'#13#10'else ;'#13#10'end;';
    ),
    (
    AName  : 'cases';
    ADesc  : 'case statement';
    ACode  : 'case | of'#13#10'  : ;'#13#10'  : ;'#13#10'end;';
    ),
    (
    AName  : 'classc';
    ADesc  : 'class declaration (with Create/Destroy overrides)';
    ACode  : 'T| = class(T)'#13#10'private'#13#10#13#10'protected'#13#10#13#10 +
             'public'#13#10'  constructor Create; override;'#13#10'  destructor Destroy;' +
             ' override;'#13#10'published'#13#10#13#10'end;';
    ),
    (
    AName  : 'classd';
    ADesc  : 'class declaration (no parts)';
    ACode  : 'T| = class(T)'#13#10#13#10'end;';
    ),
    (
    AName  : 'classf';
    ADesc  : 'class declaration (all parts)';
    ACode  : 'T| = class(T)'#13#10'private'#13#10#13#10'protected' +
              #13#10#13#10'public'#13#10#13#10'published'#13#10#13#10'end;';
    ),
    (
    AName  : 'forb';
    ADesc  : 'for statement';
    ACode  : 'for | :=  to  do'#13#10'begin'#13#10#13#10'end;';
    ),
    (
    AName  : 'fors';
    ADesc  : 'for (no begin/end)';
    ACode  : 'for | :=  to  do';
    ),
    (
    AName  : 'function';
    ADesc  : 'function declaration';
    ACode  : 'function |(): ;'#13#10'begin'#13#10#13#10'end;';
    ),
    (
    AName  : 'ifb';
    ADesc  : 'if statement';
    ACode  : 'if | then'#13#10'begin'#13#10#13#10'end;';
    ),
    (
    AName  : 'ife';
    ADesc  : 'if then (no begin/end) else (no begin/end)';
    ACode  : 'if | then'#13#10#13#10'else';
    ),
    (
    AName  : 'ifeb';
    ADesc  : 'if then else';
    ACode  : 'if | then'#13#10'begin'#13#10#13#10'end'#13#10'else'#13#10'begin' +
              #13#10#13#10'end';
    ),
    (
    AName  : 'ifs';
    ADesc  : 'if (no begin/end)';
    ACode  : 'if | then';
    ),
    (
    AName  : 'procedure';
    ADesc  : 'procedure declaration';
    ACode  : 'procedure |();'#13#10'begin'#13#10#13#10'end;';
    ),
    (
    AName  : 'trycf';
    ADesc  : 'try finally (with Create/Free)';
    ACode  : '|variable := typename.Create;'#13#10'try'#13#10#13#10'finally'#13#10 +
             '  variable.Free;'#13#10'end;';
    ),
    (
    AName  : 'trye';
    ADesc  : 'try except';
    ACode  : 'try'#13#10'  |'#13#10'except'#13#10#13#10'end;';
    ),
    (
    AName  : 'tryf';
    ADesc  : 'try finally';
    ACode  : 'try'#13#10'  |'#13#10'finally'#13#10#13#10'end;';
    ),
    (
    AName  : 'whileb';
    ADesc  : 'while statement';
    ACode  : 'while | do'#13#10'begin'#13#10#13#10'end;';
    ),
    (
    AName  : 'whiles';
    ADesc  : 'while (no begin)';
    ACode  : 'while | do';
    ),
    (
    AName  : 'withb';
    ADesc  : 'with statement';
    ACode  : 'with | do'#13#10'begin'#13#10#13#10'end;';
    ),
    (
    AName  : 'withs';
    ADesc  : 'with (no begin)';
    ACode  : 'with | do';
    )
  );

  maxCppTemplate = 17;
  CppTemplates : array[0 .. maxCppTemplate -1 ] of TTemplateRec =
  (
    (
    AName  : 'classc';
    ADesc  : 'class declaration (with constructor/destructor)';
    ACode  : 'class T| : public T'#13#10'{'#13#10'private:'#13#10#13#10'protected:' +
             #13#10#13#10'public:'#13#10'  __fastcall T();'#13#10'  __fastcall ~T();' +
             #13#10'__published:'#13#10#13#10'};';
    ),
    (
    AName  : 'classd';
    ADesc  : 'class declaration (no parts)';
    ACode  : 'class T| : public T'#13#10'{'#13#10'};';
    ),

    (
    AName  : 'classf';
    ADesc  : 'class declaration (all parts)';
    ACode  : 'class T| : public T'#13#10'{'#13#10'private:'#13#10#13#10'protected:' +
             #13#10#13#10'public:'#13#10#13#10'__published:'#13#10#13#10'};';
    ),
    (
    AName  : 'forb';
    ADesc  : 'for statement';
    ACode  : 'for (|; ;)'#13#10'{'#13#10#13#10'}';
    ),

    (
    AName  : 'fors';
    ADesc  : 'for (no opening/closing braces)';
    ACode  : 'for (|; ;)';
    ),
    (
    AName  : 'function';
    ADesc  : 'function declaration';
    ACode  : '|()'#13#10'{'#13#10#13#10'}';
    ),
    (
    AName  : 'ifb';
    ADesc  : 'if statement';
    ACode  : 'if (|)'#13#10'{'#13#10#13#10'}';
    ),
    (
    AName  : 'ife';
    ADesc  : 'if (no opening/closing braces) else (no opening/closing braces)';
    ACode  : 'if (|)'#13#10#13#10'else';
    ),
    (
    AName  : 'ifeb';
    ADesc  : 'if else';
    ACode  : 'if (|)'#13#10'{'#13#10#13#10'}'#13#10'else'#13#10'{'#13#10#13#10'}';
    ),
    (
    AName  : 'ifs';
    ADesc  : 'if (no opening/closing braces)';
    ACode  : 'if (|)';
    ),
    (
    AName  : 'struct';
    ADesc  : 'structure declaration';
    ACode  : 'struct |'#13#10'{'#13#10'};';
    ),
    (
    AName  : 'switche';
    ADesc  : 'switch statement (with default)';
    ACode  : 'switch (|)'#13#10'{'#13#10'  case : ;'#13#10'  break;'#13#10'  case : ;' +
             #13#10'  break;'#13#10'}';
    ),
    (
    AName  : 'switchs';
    ADesc  : 'switch statement';
    ACode  : 'switch (|)'#13#10'{'#13#10'  case : ;'#13#10'  break;'#13#10'  case : ;' +
             #13#10'  break;'#13#10'  default: ;'#13#10'}';
    ),
    (
    AName  : 'templ';
    ADesc  : 'template class declaration';
    ACode  : 'template <class T>'#13#10'class |'#13#10'{'#13#10'};';
    ),
    (
    AName  : 'trye';
    ADesc  : 'try catch';
    ACode  : 'try'#13#10'{'#13#10'  |'#13#10'}'#13#10'catch()'#13#10'{'#13#10'}';
    ),
    (
    AName  : 'whileb';
    ADesc  : 'while statement';
    ACode  : 'while (|)'#13#10'{'#13#10#13#10'}';
    ),
    (
    AName  : 'whiles';
    ADesc  : 'while (no opening/closing braces)';
    ACode  : 'while (|)';
    )
  );


  maxClipperTemplate = 16;
  ClipperTemplates : array[0 .. maxClipperTemplate -1 ] of TTemplateRec =
  (
    (
    AName  : 'access assign';
    ADesc  : 'access assign declaration';
    ACode  : 'access assign | '#13#10;
    ),    (
    AName  : 'begins';
    ADesc  : 'begin sequence (' + sWithOutClause + ' recover)';
    ACode  : 'begin sequence'#13#10#13#10'end sequence;';
    ),
    (
    AName  : 'beginr';
    ADesc  :  'begin sequence (' + sWithClause + ' recover)';
    ACode  : 'begin sequence'#13#10#13#10'recover'#13#10#13#10'end sequence;';
    ),
    (
    AName  : 'caseo';
    ADesc  : 'case statement (' + sWithClause + ' otherwise)';
    ACode  : 'do case '#13#10'case | '#13#10'otherwise'#13#10'endcase;';
    ),
    (
    AName  : 'cases';
    ADesc  : 'case statement';
    ACode  : 'do case '#13#10'case | '#13#10'endcase;';
    ),
    (
    AName  : 'class';
    ADesc  : 'class declaration';
    ACode  : 'class | from xbp'#13#10'protected:'#13#10#13#10 +
             'exported:'#13#10#13#10'endclass';
    ),
    (
    AName  : 'fori';
    ADesc  : 'for statement (' + sWithClause + ' i)';
    ACode  : 'for i := 1 to |'#13#10#13#10'next i';
    ),
    (
    AName  : 'forj';
    ADesc  : 'for statement (' + sWithClause + ' j)';
    ACode  : 'for j := 1 to |'#13#10#13#10'next j';
    ),
    (
    AName  : 'forl';
    ADesc  : 'for statement ('+ sWithClause + ' len())';
    ACode  : 'nLen := len(|)'#13#10'for i := 1 to nLen'#13#10#13#10'next i';
    ),
    (
    AName  : 'function';
    ADesc  : 'function declaration';
    ACode  : 'function |()'#13#10#13#10'return NIL';
    ),
    (
    AName  : 'ifn';
    ADesc  : 'if statement (normal)';
    ACode  : 'if |'#13#10#13#10'endif';
    ),
    (
    AName  : 'ife';
    ADesc  : 'if statement (' + sWithClause + ' else)';
    ACode  : 'if |'#13#10#13#10'else'#13#10#13#10'endif';
    ),
    (
    AName  : 'method';
    ADesc  : 'method implementation';
    ACode  : 'method |:()'#13#10#13#10'return self';
    ),
    (
    AName  : 'procedure';
    ADesc  : 'procedure declaration';
    ACode  : 'procedure |()'#13#10#13#10'return';
    ),
    (
    AName  : 'whiles';
    ADesc  : 'while statement';
    ACode  : 'while |'#13#10#13#10'end';
    ),
    (
    AName  : 'while!';
    ADesc  : 'while ! eof()';
    ACode  : 'while ! eof()'#13#10#13#10'   dbskip()'#13#10'end';
    )
  );


//EndSkipConst

{-------------------------------------------------------------}

function AddCodeTemplate(CodeTemplates : TMemoCodeTemplates; const AName , ADesc, ACode :  string) : TMemoCodeTemplate;
begin
  result := TMemoCodeTemplate(CodeTemplates.Add);
  with result do
  begin
    Name := AName;
    Description := ADesc;
    Code.Text := ACode;
  end;
end;

{-------------------------------------------------------------}

procedure TemplatesFromArray(CodeTemplates : TMemoCodeTemplates; TemplArray : array of TTemplateRec);
var
  i : integer;
begin
  CodeTemplates.Clear;
  for i := Low(TemplArray) to High(TemplArray) do
    with TemplArray[i] do
      AddCodeTemplate(CodeTemplates , AName, ADesc, ACode) ;
end;

{-------------------------------------------------------------}

procedure FillWithDelphiTemplates(CodeTemplates : TMemoCodeTemplates);
begin
  TemplatesFromArray(CodeTemplates, DelphiTemplates);
end;

{--------------------------------------------------------------}

procedure FillWithCppTemplates(CodeTemplates : TMemoCodeTemplates);
begin
  TemplatesFromArray(CodeTemplates, CppTemplates);
end;

{--------------------------------------------------------------}

procedure FillWithClipperTemplates(CodeTemplates : TMemoCodeTemplates);
begin
  TemplatesFromArray(CodeTemplates, ClipperTemplates);
end;

{--------------------------------------------------------------}

procedure RegisterTemplatesProc(const Language : string; Proc : TCodeTemplateProc);
begin
  dcsystem.RegisterClassExt(TMemoCodeTemplates, [SCodeTemplateLang, SCodeTemplatesProc],
    [Language, integer(@Proc)]);
end;

{--------------------------------------------------------------}

procedure _Register;
begin
  RegisterOptionExt(TMemoSourceOptions);
  RegisterOptionExt(TSearchOptions);
  RegisterTemplatesProc(SLangNone, nil);
  RegisterTemplatesProc(SLangCustom, nil);
  RegisterTemplatesProc(SLangDelphi, FillWithDelphiTemplates);
  RegisterTemplatesProc(SLangCpb, FillWithCppTemplates);
  RegisterTemplatesProc(SLangClipper, FillWithClipperTemplates);

end;

{-------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDreamMemo,[TMemoSource {$IFNDEF CLX}, TClipbrdMemoSource {$ENDIF}]);
//  RegisterPropertyEditor(TypeInfo(string), TSearchOptions,'TextToFind',THistoryStringEdit);//don't resource
//  RegisterPropertyEditor(TypeInfo(string), TSearchOptions,'ReplaceWith',THistoryStringEdit);//don't resource
end;

{-------------------------------------------------------------}

initialization
  RunRegister;
  cHotSpotChars:=['.' , ':', '/', '@', '-', '?', '=', '~']
finalization
  FreeObject(FMemoSources,FMemoSources);
end.

