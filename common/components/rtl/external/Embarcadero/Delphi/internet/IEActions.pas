{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{
  Useful URLs:

  MSHTML Command Identifiers
  http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/mshtml/reference/commandids.asp

  Command Identifiers (DHTML)
  http://msdn.microsoft.com/library/default.asp?url=/workshop/author/dhtml/reference/commandids.asp

other supported commands

IDM_INSERTOBJECT
IDM_PRINT
IDM_IFRAME
IDM_REMOVEFORMAT

}
unit IEActions;

interface

uses System.SysUtils, Winapi.Windows, Vcl.Forms, System.Classes, Vcl.ActnList, Vcl.StdActns,
  Vcl.Dialogs, Winapi.ActiveX, WebBrowserEx, WBComp, Vcl.StdCtrls, Vcl.Graphics, MSHTML;

type

{ TWebBrowserAction }

  TWebActionOption = (woDoDefault, woPromptUser, woDontPrompt, woShowHelp);

  TWebActionApplyOption = (applyRootDocument, applyAllDocuments, applyActiveDocument);
  
  TCustomWebBrowserAction = class(TCustomAction)
  private
    FControl: TWebBrowserEx;
    FCmdStr: string;
    FCmdID: TOleEnum;
    FHTMLTag: string;
    FUseexecCommand: Boolean;
    FUpdateChecked: Boolean;
    FCommandUpdater: TWebBrowserCommandUpdater;
    FCmdGroup: TGUID;
    FWebActionApplyOption: TWebActionApplyOption;
    procedure SetCmdID(const Value: TOleEnum);
    procedure SetCommandUpdater(const Value: TWebBrowserCommandUpdater);
  protected
    FCommandState: TCommandStates;
    FInParam: OleVariant;
    FOutParam: OleVariant;
    FOption: TWebActionOption;
    FShowUI: WordBool;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateCheckedState;
    property Control: TWebBrowserEx read FControl;
    property Option: TWebActionOption read FOption write FOption;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    property ApplyOption: TWebActionApplyOption read FWebActionApplyOption write FWebActionApplyOption;
    property CmdID: TOleEnum read FCmdID write SetCmdID;
    property CmdGroup: TGUID read FCmdGroup write FCmdGroup;
    property CommandUpdater: TWebBrowserCommandUpdater read FCommandUpdater write SetCommandUpdater;
    property UseexecCommand: Boolean read FUseexecCommand write FUseexecCommand;
    property UpdateChecked: Boolean read FUpdateChecked write FUpdateChecked;
  end;

  TWebBrowserAction = class(TCustomWebBrowserAction)
  published
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TBrowserAction = class(TCustomWebBrowserAction)
  published
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property CmdID;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property Option;
    property UseexecCommand;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property Visible;
  end;

  TWebBrowserUndoAction = class(TCustomWebBrowserAction)
  private
    FAllowBatchUndo: Boolean;
  protected
    procedure BeforeAction(Target: TObject); virtual;
    procedure DoAction(Target: TObject; Data: Integer); virtual;
    procedure AfterAction(Target: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    property AllowBatchUndo: Boolean read FAllowBatchUndo write FAllowBatchUndo default True;
  end;

  TWebBrowserToggleAction = class(TWebBrowserAction)
  private
    FNotInParam: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
    property NotInParam: Boolean read FNotInParam write FNotInParam;
  end;

  TWebBrowserOverrideCursor = class(TWebBrowserToggleAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ Edit Actions }

  TWebBrowserCut = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TWebBrowserCopy = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TWebBrowserPaste = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserSelectAll = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserSelectAllControls = class(TWebBrowserAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  // Currently documented as an unsupported command but works in (at least) IE 6.0
  TWebBrowserUndo = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  // Currently documented as an unsupported command but works in (at least)  IE 6.0
  TWebBrowserRedo = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserDelete = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
    //procedure UpdateTarget(Target: TObject); override;
  end;

  TWebBrowserClearSelection = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserMultiSelect = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserAtomicSelect = class(TWebBrowserToggleAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserKeepSelection = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ Formatting operations }

  TWebBrowserFormatAction = class(TWebBrowserAction)
  public
    procedure UpdateTarget(Target: TObject); override;
  end;

  TWebBrowserBold = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserItalic = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserUnderLine = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserSuperscript = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserSubscript = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserAlignLeft = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserAlignRight = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserAlignCenter = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  // Currently documented as an unsupported command but works in IE 6.0
  TWebBrowserAlignFull = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserIndent = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserUnindent = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserFont = class(TWebBrowserFormatAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserColor = class(TWebBrowserFormatAction)
  private
    FDialog: TColorDialog;
    FExecuteResult: Boolean;
    FOnAccept: TNotifyEvent;
    FOnCancel: TNotifyEvent;
    FBeforeExecute: TNotifyEvent;
    function GetColor: TColor;
    procedure SetColor(const Value: TColor);
  protected
    procedure DoAccept; virtual;
    procedure DoCancel; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetupDialog; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    property Color: TColor read GetColor write SetColor;
    property Dialog: TColorDialog read FDialog write FDialog;
    property ExecuteResult: Boolean read FExecuteResult;
    property BeforeExecute: TNotifyEvent read FBeforeExecute write FBeforeExecute;
    property OnAccept: TNotifyEvent read FOnAccept write FOnAccept;
    property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
  end;

  TWebBrowserBackColor = class(TWebBrowserColor)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Dialog;
  end;

  TWebBrowserForeColor = class(TWebBrowserColor)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Dialog;
  end;

{ HTML Elements }

  TWebBrowserOrderedList = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserUnorderedList = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

{ HTML Element actions }

  TWebBrowserCreateURL = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TWebBrowserRemoveURL = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowser2DPosition = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserAbsolutePosition = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

{ Page actions }

  TWebBrowserDesignMode = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TWebBrowserPrint = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserPrintPreview = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserRefresh = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserSaveAs = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Option;
  end;

  TWebBrowserAddFavorites = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ Design mode }

  TWebBrowserZeroBorder = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property UpdateChecked default True;
  end;

  // The TWebBrowserShowTags action only works with the default glyphs
  // provided with Internet Explorer.

  TShowTags = (stAll, stAlignedSiteTags, stScript, stStyle, stComment,
    stArea, stUnknown, stMisc);

  TWebBrowserShowTags = class(TWebBrowserAction)
  private
    FShowTags: TShowTags;
    procedure SetShowTags(const Value: TShowTags);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
    property ShowTags: TShowTags read FShowTags write SetShowTags default stAll;
  end;

  TWebBrowserLiveResize = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserRespectVisiblity = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

  TWebBrowserAutoURLDetect = class(TWebBrowserToggleAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property UpdateChecked default True;
  end;

{ Navigation }

  TWebBrowserBack = class(TWebBrowserAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TWebBrowserForward = class(TWebBrowserAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TWebBrowserHome = class(TWebBrowserAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  // Browses to the default search site

  TWebBrowserSearch = class(TWebBrowserAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ Search/Replace }

  TWebBrowserSearchAction = class(TCommonDialogAction)
  protected
    FControl: TWebBrowserEx;
    FFindFirst: Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure Search(Sender: TObject); virtual;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{ TWebBrowserSearchFind }

  TWebBrowserSearchFind = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;


{  TWebBrowserSearchFind = class(TWebBrowserSearchAction)
  private
    function GetFindDialog: TFindDialog;
  protected
    function GetDialogClass: TCommonDialogClass; override;
  published
    property Caption;
    property Dialog: TFindDialog read GetFindDialog;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property BeforeExecute;
    property OnAccept;
    property OnCancel;
    property OnHint;
  end;}

  TWebBrowserSearchReplace = class(TWebBrowserSearchAction)
  private
    procedure Replace(Sender: TObject);
    function GetReplaceDialog: TReplaceDialog;
  protected
    function GetDialogClass: TCommonDialogClass; override;
  public
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Caption;
    property Dialog: TReplaceDialog read GetReplaceDialog;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property BeforeExecute;
    property OnAccept;
    property OnCancel;
    property OnHint;
  end;

  TWebBrowserSearchFindFirst = class(TWebBrowserSearchFind)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebBrowserSearchFindNext = class(TCustomAction)
  private
    FSearchFind: TWebBrowserSearchFind;
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property SearchFind: TWebBrowserSearchFind read FSearchFind write FSearchFind;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
  end;

{ Frame Actions }

  TWebBrowserFrameAction = class(TWebBrowserUndoAction)
  public
    procedure UpdateTarget(Target: TObject); override;
  end;

  TWebBrowserSeamlessJoin = class(TWebBrowserFrameAction)
  protected
    procedure DoAction(Target: TObject; Data: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TWebBrowserDeleteFrame = class(TWebBrowserFrameAction)
  protected
    procedure DoAction(Target: TObject; Data: Integer); override;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

{ Element Actions for actions on the element at the current caret position }

  TWebBrowserElementAction = class(TWebBrowserUndoAction)
  protected
    function GetElement: IHTMLElement; virtual;
    function IsTargetElement: Boolean; virtual;
  public
    procedure UpdateTarget(Target: TObject); override;
    property Element: IHTMLElement read GetElement;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

{ HTML Control Action }

  TWebBrowserControlAction = class(TWebBrowserElementAction)
  protected
    function GetElement: IHTMLElement; override;
  end;

{ Input Action }

  TWebBrowserInputAction = class(TWebBrowserControlAction)
  protected
    function IsTargetElement: Boolean; override;
  end;

{ Image Actions }

  TWebBrowserImageAction = class(TWebBrowserControlAction)
  protected
    function IsTargetElement: Boolean; override;
  end;

{ Table Actions }

  TWebBrowserTableAction = class(TWebBrowserControlAction)
  protected
    function IsTargetElement: Boolean; override;
  end;

  TWebBrowserTableDelete = class(TWebBrowserTableAction)
  protected
    procedure DoAction(Target: TObject; Data: Integer); override;
    function GetElement: IHTMLElement; override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TWebBrowserTableCellAction = class(TWebBrowserElementAction)
  protected
    function IsTargetElement: Boolean; override;
    function GetElement: IHTMLElement; override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TWebBrowserTableInsertRow = class(TWebBrowserTableCellAction)
  private
    FInsertAbove: Boolean;
  protected
    procedure DoAction(Target: TObject; Data: Integer); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property InsertAbove: Boolean read FInsertAbove write FInsertAbove default False;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TWebBrowserTableDeleteRow = class(TWebBrowserTableCellAction)
  public
    procedure DoAction(Target: TObject; Data: Integer); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TWebBrowserTableMoveRow = class(TWebBrowserTableCellAction)
  private
    FMoveUp: Boolean;
  protected
    procedure DoAction(Target: TObject; Data: Integer); override;
  public
    procedure UpdateTarget(Target: TObject); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property MoveUp: Boolean read FMoveUp write FMoveUp default False;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TWebBrowserTableDeleteCell = class(TWebBrowserTableCellAction)
  public
    procedure DoAction(Target: TObject; Data: Integer); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TWebBrowserTableInsertCell = class(TWebBrowserTableCellAction)
  protected
    procedure DoAction(Target: TObject; Data: Integer); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property UpdateChecked default False;
    property Visible;
  end;

  TWebBrowserTableColumnAction = class(TWebBrowserTableCellAction)
  private
    FActiveRow: IHTMLTableRow;
  protected
    property ActiveRow: IHTMLTableRow read FActiveRow;
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TWebBrowserTableInsertColumn = class(TWebBrowserTableColumnAction)
  private
    FInsertToLeft: boolean;
  protected
    procedure DoAction(Target: TObject; Data: Integer); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property InsertToLeft: boolean read FInsertToLeft write FInsertToLeft;
    property Visible;
  end;

  TWebBrowserTableDeleteColumn = class(TWebBrowserTableColumnAction)
  protected
    procedure DoAction(Target: TObject; Data: Integer); override;
  published
    property AllowBatchUndo;
    property AutoCheck;
    property CommandUpdater;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property Visible;
  end;

{ Control Selection Actions }

  TWebBrowserControlSelection = class(TCustomWebBrowserAction)
  private
    FControlRange: IHTMLControlRange;
    FAllowBatchUndo: Boolean;
    FMaxSelCount: Integer;
    FMinSelCount: Integer;
    FRange: IHTMLControlRange;
    FIgnoreLockedControls: Boolean;
  protected
    procedure BeforeAction; virtual;
    procedure DoAction(Index: Integer; Element: IHTMLElement); virtual; abstract;
    procedure AfterAction; virtual;
    function GetEnabled: Boolean; virtual;
    property ControlRange: IHTMLControlRange read FControlRange;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
    property AllowBatchUndo: Boolean read FAllowBatchUndo write FAllowBatchUndo default True;
    property MinSelCount: Integer read FMinSelCount write FMinSelCount;
    property MaxSelCount: Integer read FMaxSelCount write FMaxSelCount;
    property IgnoreLockedControls: Boolean read FIgnoreLockedControls write FIgnoreLockedControls; 
  end;

{ Z-Order Actions }

  TGetNextZIndexEvent = procedure(Sender: TObject; var NextZIndex: Integer) of object;
  TGetPrevZIndexEvent = procedure(Sender: TObject; var PrevZIndex: Integer) of object;

  TWebBrowserAbsolutionPositionAction = class(TWebBrowserControlSelection)
  protected
    function GetEnabled: Boolean; override;
  end;

  TWebBrowserBringToFront = class(TWebBrowserAbsolutionPositionAction)
  private
    FOnGetNextZIndex: TGetNextZIndexEvent;
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  published
    property CommandUpdater;
    property Caption;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property OnGetNextZIndex: TGetNextZIndexEvent read FOnGetNextZIndex write FOnGetNextZIndex;
    property SecondaryShortCuts;
    property ShortCut;
    property Visible;
  end;

  TWebBrowserSendToBack = class(TWebBrowserAbsolutionPositionAction)
  private
    FOnGetPrevZIndex: TGetPrevZIndexEvent;
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  published
    property CommandUpdater;
    property Caption;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property Visible;
    property OnGetPrevZIndex: TGetPrevZIndexEvent read FOnGetPrevZIndex write FOnGetPrevZIndex;
  end;

{ Control Alignment Actions }

  TWebBrowserAlignControls = class(TWebBrowserControlSelection)
  private
    FPrimaryElement: IHTMLElement;
  protected
    procedure BeforeAction; override;
    property PrimaryElement: IHTMLElement read FPrimaryElement;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CommandUpdater;
    property Caption;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property Visible;
  end;

  TWebBrowserAlignControlsLeft = class(TWebBrowserAlignControls)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

  TWebBrowserAlignControlsRight = class(TWebBrowserAlignControls)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

  TWebBrowserAlignControlsTop = class(TWebBrowserAlignControls)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

  TWebBrowserAlignControlsBottom = class(TWebBrowserAlignControls)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

  TWebBrowserAlignVerticalCenters = class(TWebBrowserAlignControls)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

  TWebBrowserAlignHorizontalCenters = class(TWebBrowserAlignControls)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

{ Control Size Actions }

  TWebBrowserControlSize = class(TWebBrowserAlignControls)
  published
    property CommandUpdater;
    property Caption;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property Visible;
  end;

  TWebBrowserMakeSameWidth = class(TWebBrowserControlSize)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

  TWebBrowserMakeSameHeight = class(TWebBrowserControlSize)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

  TWebBrowserMakeSameSize = class(TWebBrowserControlSize)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  end;

{ TWebBrowserDesignTimeLock }

  TWebBrowserDesignTimeLock = class(TWebBrowserControlSelection)
  protected
    procedure DoAction(Index: Integer; Element: IHTMLElement); override;
  public
    procedure UpdateTarget(Target: TObject); override;
  published
    property CommandUpdater;
    property Caption;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property OnChange;
    property OnExecute;
    property OnHint;
    property OnUpdate;
    property SecondaryShortCuts;
    property ShortCut;
    property Visible;
  end;

{ TWebBrowserInsertTag }

  TWebBrowserInsertTag = class;

  TElementCreatedEvent = procedure(Sender: TWebBrowserInsertTag;
    Element: IHTMLElement) of object;

  TWebBrowserInsertTag = class(TWebBrowserAction)
  private
    FHTMLTag: string;
    FOnElementCreated: TElementCreatedEvent;
    procedure SetHTMLTag(const Value: string);
  protected
    function CanInsert: Boolean; virtual;
    //function GetElement: IHTMLElement;
    function GetTagID: _ELEMENT_TAG_ID;
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property HTMLTag: string read FHTMLTag write SetHTMLTag;
    property OnElementCreated: TElementCreatedEvent read FOnElementCreated
      write FOnElementCreated;
  end;

  TWebBrowserInsertFormTag = class(TWebBrowserInsertTag)
  protected
    function CanInsert: Boolean; override;
  end;

{ TWebBrowserOverwrite }

  TWebBrowserOverwrite = class(TWebBrowserAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

procedure ValidateInsertablePosition(WebBrowser: TWebBrowserEx; StartPos: IMarkupPointer);
procedure ShowElementCreateError(const ATagName, AMessage: string);
function CanInsertControlAtCurrentPosition(WebBrowser: TWebBrowserEx): Boolean;

const
  sDesignTimeLock = 'Design_Time_Lock';  { do not localize }

implementation

uses System.Win.ComObj, System.Variants, Vcl.Clipbrd, mshtmcid, Vcl.Menus, SHDocVw, Vcl.OleCtrls,
  IEConst;

const
  CmdExecOption: array[TWebActionOption] of Integer = (OLECMDEXECOPT_DODEFAULT,
    OLECMDEXECOPT_PROMPTUSER, OLECMDEXECOPT_DONTPROMPTUSER,
    OLECMDEXECOPT_SHOWHELP);

{ TCustomWebBrowserAction }

constructor TCustomWebBrowserAction.Create(AOwner: TComponent);
begin
  inherited;
  Assert(ApplyOption = applyRootDocument); // Verify that this is the default
  FUpdateChecked := False;
  FInParam := Null;
  FOutParam := Null;
  FOption := woDontPrompt;
  FCmdID := 0;
  FCmdGroup := CGID_MSHTML;
end;

destructor TCustomWebBrowserAction.Destroy;
begin
  if Assigned(FControl) then
    FControl.RemoveFreeNotification(Self);
  inherited;
end;

procedure TCustomWebBrowserAction.ExecuteTarget(Target: TObject);
var
  Executed: Boolean;
  LViewLinkDocuments: IInterfaceList;
  I: Integer;
  LCommandTarget: IOleCommandTarget;
begin
  inherited;
  if Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
     Assigned(CommandUpdater.WebBrowser.Document2) then
  begin
    CommandUpdater.DoBeforeCommand(FCmdID, Executed);
    if not Executed then
    begin
      if UseexecCommand then
      begin
        (CommandUpdater.WebBrowser.ActiveDocument as IHTMLDocument2).execCommand(FCmdStr,
          FOption = woPromptUser, FInParam);
        Assert(ApplyOption = applyActiveDocument); // Make sure we don't need to handle other cases
      end
      else
      begin
        case ApplyOption of
          applyAllDocuments,
          applyRootDocument:
            LCommandTarget := CommandUpdater.WebBrowser.Document2 as IOleCommandTarget;
          applyActiveDocument:
            LCommandTarget :=  CommandUpdater.WebBrowser.ActiveDocument as IOleCommandTarget;
        else
          Assert(false);
        end;
        if LCommandTarget <> nil then
          LCommandTarget.Exec(@FCmdGroup, FCmdID,
            CmdExecOption[FOption], FInParam, FOutParam);
        if ApplyOption = applyAllDocuments then
        begin
          LViewLinkDocuments := CommandUpdater.WebBrowser.GetViewLinkDocuments(FCmdID);
          if LViewLinkDocuments <> nil then
          begin
            for I := 0 to LViewLinkDocuments.Count - 1 do
            begin
              LCommandTarget := LViewLinkDocuments[I] as IOleCommandTarget;
              if LCommandTarget <> nil then
                LCommandTarget.Exec(@FCmdGroup, FCmdID,
                   CmdExecOption[FOption], FInParam, FOutParam);
            end;
          end;
        end
      end;
    end;
    CommandUpdater.UpdateCommands(FCmdID);
    // Update the checked state here so that tool buttons won't bounce
    FCommandState := CommandUpdater.CommandState(FCmdID);
    UpdateCheckedState;
    CommandUpdater.DoAfterCommand(FCmdID);
  end;
end;

function TCustomWebBrowserAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Assigned(CommandUpdater); {and (Assigned(CommandUpdater.WebBrowser) or
   (((CommandUpdater.WebBrowser <> nil) and (Target = CommandUpdater.WebBrowser) or
     (CommandUpdater.WebBrowser = nil) and (Target is TWebBrowserEx)) and
     IsChild(TWebBrowserEx(Target).Handle, GetFocus)));}
{  if FBrowserControl = nil then
    if Result then
    begin
      if Assigned(FRegisteredBrowser) then
      begin
        if FRegisteredBrowser <> Target then
          FRegisteredBrowser.CommandUpdater.UnRegisterCommand(FCmdID);
      end
      else
      begin
        FRegisteredBrowser := Target as TWebBrowserEx;
        FRegisteredBrowser.CommandUpdater.RegisterCommand(FCmdID);
      end;
    end else if Assigned(FRegisteredBrowser) then
    begin
      FRegisteredBrowser.CommandUpdater.UnRegisterCommand(FCmdID);
      FRegisteredBrowser := nil;
    end;}
end;

procedure TCustomWebBrowserAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = CommandUpdater) then
    FCommandUpdater := nil;
end;

procedure TCustomWebBrowserAction.SetCmdID(const Value: TOleEnum);
begin
  if FCmdID <> Value then
  begin
    if Assigned(CommandUpdater) and (Value <> 0) then
      CommandUpdater.UnRegisterCommand(CmdID);
    FCmdID := Value;
    if Assigned(CommandUpdater) and (FCmdID <> 0) then
      CommandUpdater.RegisterCommand(CmdID);
  end;
end;

procedure TCustomWebBrowserAction.SetCommandUpdater(
  const Value: TWebBrowserCommandUpdater);
begin
  if FCommandUpdater <> Value then
  begin
    FCommandUpdater := Value;
    if Value <> nil then Value.FreeNotification(Self);
    if Assigned(FCommandUpdater) and (CmdID <> 0) then
      FCommandUpdater.RegisterCommand(CmdID);
  end;
end;

procedure TCustomWebBrowserAction.UpdateCheckedState;
begin
  if csChecked in FCommandState then
    Checked := True
  else if UpdateChecked and Checked then
    Checked := False;
end;

procedure TCustomWebBrowserAction.UpdateTarget(Target: TObject);
begin
  if not Assigned(CommandUpdater) or not Assigned(CommandUpdater.WebBrowser) then
  begin
    Enabled := False;
    exit;
  end;
  FCommandState := CommandUpdater.CommandState(FCmdID);
  Enabled := csEnabled in FCommandState;
  UpdateCheckedState;
end;

{ TWebBrowserOverrideCursor }

constructor TWebBrowserOverrideCursor.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_OVERRIDE_CURSOR;
end;

{ TWebBrowserCut }

constructor TWebBrowserCut.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_CUT;
end;

procedure TWebBrowserCut.ExecuteTarget(Target: TObject);
begin
  CommandUpdater.WebBrowser.CutToClipboard
end;

{ TWebBrowserCopy }

constructor TWebBrowserCopy.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Copy';           { do not localize }
  CmdID := IDM_COPY;
end;

procedure TWebBrowserCopy.ExecuteTarget(Target: TObject);
begin
  CommandUpdater.WebBrowser.CopyToClipboard
end;

{ TWebBrowserPaste }

constructor TWebBrowserPaste.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Paste';          { do not localize }
  CmdID := IDM_PASTE;
end;

{ TWebBrowserSelectAll }

constructor TWebBrowserSelectAll.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'SelectAll';      { do not localize }
  CmdID := IDM_SELECTALL;
end;

{ TWebBrowserUndo }

constructor TWebBrowserUndo.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Undo';           { do not localize }
  CmdID := IDM_UNDO;
end;

{ TWebBrowserRedo }

constructor TWebBrowserRedo.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Redo';           { do not localize }
  CmdID := IDM_REDO;
end;

{ TWebBrowserDelete }

constructor TWebBrowserDelete.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Delete';         { do not localize }
  CmdID := IDM_DELETE;
end;

{ TWebBrowserBold }

constructor TWebBrowserBold.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Bold';           { do not localize }
  CmdID := IDM_BOLD;
  FHTMLTag := 'strong';             { do not localize }
  UpdateChecked := True;
end;

{ TWebBrowserItalic }

constructor TWebBrowserItalic.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Italic';         { do not localize }
  CmdID := IDM_ITALIC;
  FHTMLTag := 'i';             { do not localize }
  UpdateChecked := True;
end;

{ TWebBrowserUnderLine }

constructor TWebBrowserUnderLine.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Underline';      { do not localize }
  CmdID := IDM_UNDERLINE;
  FHTMLTag := 'u';             { do not localize }
  UpdateChecked := True;  
end;

{ TWebBrowserClearSelection }

constructor TWebBrowserClearSelection.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Unselect';       { do not localize }
  CmdID := IDM_CLEARSELECTION;
end;

{ TWebBrowserMultiSelect }

constructor TWebBrowserMultiSelect.Create(AOwner: TComponent);
begin
  inherited;
  AutoCheck := True;
  CmdID := IDM_MULTIPLESELECTION;
  UpdateChecked := True;
end;

{ TWebBrowserAtomicSelect }

constructor TWebBrowserAtomicSelect.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_ATOMICSELECTION;
  UpdateChecked := True;
end;

{ TWebBrowserOrderedList }

constructor TWebBrowserOrderedList.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'InsertOrderedList'; { do not localize }
  CmdID := IDM_ORDERLIST;
  FHTMLTag := 'ol';               { do not localize }
  UpdateChecked := True;
end;

{ TWebBrowserUnorderedList }

constructor TWebBrowserUnorderedList.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'InsertUnorderedList'; { do not localize }
  CmdID := IDM_UNORDERLIST;
  FHTMLTag := 'ul';                 { do not localize }
  UpdateChecked := True;
end;

{ TWebBrowserAlignLeft }

constructor TWebBrowserAlignLeft.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'JustifyLeft';    { do not localize }
  CmdID := IDM_JUSTIFYLEFT;
  FHTMLTag := 'div align=left';  { do not localize }
  UpdateChecked := True;
end;

{ TWebBrowserAlignRight }

constructor TWebBrowserAlignRight.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'JustifyRight';   { do not localize }
  CmdID := IDM_JUSTIFYRIGHT;
  FHTMLTag := 'div align=right'; { do not localize }
  UpdateChecked := True;
end;

{ TWebBrowserAlignCenter }

constructor TWebBrowserAlignCenter.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'JustifyCenter';  { do not localize }
  CmdID := IDM_JUSTIFYCENTER;
  FHTMLTag := 'div align=center'; { do not localize }
  UpdateChecked := True;
end;

{ TWebBrowserAlignFull }

constructor TWebBrowserAlignFull.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'JustifyFull';  { do not localize }
  CmdID := IDM_JUSTIFYFULL;
  UpdateChecked := True;
//!!  FHTMLTag := '???';     { do not localize }
end;

{ TWebBrowserIndent }

constructor TWebBrowserIndent.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Indent';         { do not localize }
  CmdID := IDM_INDENT;
  FHTMLTag := 'blockquote dir=ltr style="MARGIN-RIGHT: 0px"' { do not localize }
end;

{ TWebBrowserUnindent }

constructor TWebBrowserUnindent.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Outdent';        { do not localize }
  CmdID := IDM_OUTDENT;
end;

{ TWebBrowserCreateURL }

constructor TWebBrowserCreateURL.Create(AOwner: TComponent);
begin
  inherited;
  FShowUI := True;
  FCmdStr := 'CreateLink';     { do not localize }
  CmdID := IDM_HYPERLINK;
  FOption := woDoDefault;
end;

procedure TWebBrowserCreateURL.UpdateTarget(Target: TObject);
var
  D2: IHTMLDocument2;
begin
  if not Assigned(CommandUpdater) or not Assigned(CommandUpdater.WebBrowser) then
  begin
    Enabled := False;
    exit;
  end;
  if CommandUpdater.WebBrowser.ActiveDocument <> nil then
    if Supports(CommandUpdater.WebBrowser.ActiveDocument, IHTMLDocument2, D2) then
      Enabled := D2.queryCommandEnabled(FCmdStr)
  else
    Enabled := False;
end;

{ TWebBrowserRemoveURL }

constructor TWebBrowserRemoveURL.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'Unlink';
  CmdID := IDM_UNLINK;
end;

{ TWebBrowser2DPosition }

constructor TWebBrowser2DPosition.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := '2D-Position';  { do not localize }
  CmdID := IDM_2D_POSITION;
  UpdateChecked := True;
end;

{ TWebBrowserAbsolutePosition }

constructor TWebBrowserAbsolutePosition.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'AbsolutePosition'; { do not localize }
  CmdID := IDM_ABSOLUTE_POSITION;
  // Jmt.  Not sure why this is needed.  Seems like ApplyAllDocuments should work but doesn't
  ApplyOption := applyActiveDocument;
  UpdateChecked := True;
end;

{ TWebBrowserDesignMode }

constructor TWebBrowserDesignMode.Create(AOwner: TComponent);
begin
  inherited;
  AutoCheck := True;
end;

procedure TWebBrowserDesignMode.ExecuteTarget(Target: TObject);
const
  DesignMode: array[Boolean] of string = ('Off', 'On');
begin
  if Checked then
    CommandUpdater.WebBrowser.Document2.designMode := 'On'
  else
    CommandUpdater.WebBrowser.Document2.designMode := 'Off';
end;

procedure TWebBrowserDesignMode.UpdateTarget(Target: TObject);
begin
  Enabled := Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
    (CommandUpdater.WebBrowser.Document2 <> nil);
end;

{ TWebBrowserPrint }

constructor TWebBrowserPrint.Create(AOwner: TComponent);
begin
  inherited;
  FShowUI := True;
  FCmdStr := 'Print';
  CmdID := IDM_PRINT;
  FOption := woDoDefault;
end;

{ TWebBrowserRefresh }

constructor TWebBrowserRefresh.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_REFRESH;
end;

{ TWebBrowserSaveAs }

constructor TWebBrowserSaveAs.Create(AOwner: TComponent);
begin
  inherited;
  FShowUI := True;
  FCmdStr := 'SaveAs';
  CmdID := IDM_SAVEAS;
  FOption := woDoDefault;
end;

{ TWebBrowserBack }

procedure TWebBrowserBack.ExecuteTarget(Target: TObject);
begin
  CommandUpdater.WebBrowser.GoBack;
end;

procedure TWebBrowserBack.UpdateTarget(Target: TObject);
begin
  Enabled := Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
    CommandUpdater.WebBrowser.BackEnabled;
end;

{ TWebBrowserForward }

procedure TWebBrowserForward.ExecuteTarget(Target: TObject);
begin
  CommandUpdater.WebBrowser.GoForward;
end;

procedure TWebBrowserForward.UpdateTarget(Target: TObject);
begin
  Enabled := Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
    CommandUpdater.WebBrowser.ForwardEnabled;
end;

{ TWebBrowserHome }

procedure TWebBrowserHome.ExecuteTarget(Target: TObject);
begin
  CommandUpdater.WebBrowser.GoHome;
end;

procedure TWebBrowserHome.UpdateTarget(Target: TObject);
begin
  Enabled := Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser);
end;

{ TWebBrowserSearch }

procedure TWebBrowserSearch.ExecuteTarget(Target: TObject);
begin
  CommandUpdater.WebBrowser.GoSearch;
end;

procedure TWebBrowserSearch.UpdateTarget(Target: TObject);
begin
                                                                    
  Enabled := Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser);
end;

procedure TWebBrowserSearchAction.ExecuteTarget(Target: TObject);
begin
  FControl := TWebBrowserEx(Target);
  if Assigned(FControl) then
    FControl.FreeNotification(Self);
  inherited ExecuteTarget(Target);
end;

function TWebBrowserSearchAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Screen.ActiveControl is TWebBrowser;
  if not Result then
    Enabled := False;
end;

procedure TWebBrowserSearchAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then
    FControl := nil;
end;

procedure TWebBrowserSearchAction.Search(Sender: TObject);
{var
  EndPtr: IMarkupPointer;
  SearchPos: IMarkupPointer;
  E: IHTMLElement;
  Result: HRESULT;}
begin
  if not Assigned(FControl) then exit;
(*
  WebBrowserEx1.MarkupServices.CreateMarkupPointer(EndPtr);
  Result := WebBrowserEx1.MarkupServices.CreateMarkupPointer(SearchPos);
  Result := EndPtr.MoveAdjacentToElement(WebBrowserEx1.Document2.body, ELEM_ADJ_BeforeEnd);
  Result := SearchPos.MoveAdjacentToElement(WebBrowserEx1.Document2.body, ELEM_ADJ_AfterBegin);
  OleCheck(SearchPos.findText('test', 0, EndPtr, EndPtr));
//  OleCheck(SearchPos.findText('test', 0, EndPtr, EndPtr));
//  WebBrowserEx1.MarkupServices.Remove(SearchPos, EndPtr);
  WebBrowserEx1.MarkupServices.InsertText('STEVE', Length('STEVE'), SearchPos);
//  Result := SearchPos.findText('test', 0, EndPtr, EndPtr);

//    if not SearchEdit(FControl, TFindDialog(FDialog).FindText,
//       TFindDialog(FDialog).Options, FFindFirst) then
//      ShowMessage(Format(STextNotFound, [TFindDialog(FDialog).FindText]));
*)
end;

procedure TWebBrowserSearchAction.UpdateTarget(Target: TObject);
begin
  Enabled := (Target is TWebBrowser) and (TWebBrowser(Target).Document <> nil);
end;

{ TWebBrowserZeroBorder }

constructor TWebBrowserZeroBorder.Create(AOwner: TComponent);
begin
  inherited;
  // !! This action is very expensive to execute on idle
  CmdID := IDM_SHOWZEROBORDERATDESIGNTIME;
  Option := woDontPrompt;
  ApplyOption := applyAllDocuments;
end;

procedure TWebBrowserZeroBorder.UpdateTarget(Target: TObject);
begin
  Enabled := Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
    not CommandUpdater.WebBrowser.UserMode;// CompareText(GetBrowserControl(Target).Document2.designMode, 'On') = 0;
  Checked := csSupported in CommandUpdater.CommandState(CmdID);
end;

{ TWebBrowserShowTags }

const
  HTMLTags: array[TShowTags] of Integer =
    (IDM_SHOWALLTAGS, IDM_SHOWALIGNEDSITETAGS, IDM_SHOWSCRIPTTAGS, IDM_SHOWSTYLETAGS,
     IDM_SHOWCOMMENTTAGS, IDM_SHOWAREATAGS, IDM_SHOWUNKNOWNTAGS, IDM_SHOWMISCTAGS);

constructor TWebBrowserShowTags.Create(AOwner: TComponent);
begin
  inherited;
  ShowTags := stAll;
  CmdID := HTMLTags[FShowTags];
  Option := woDontPrompt;
  FOutParam := NULL;
  UpdateChecked := True;
  ApplyOption := applyAllDocuments;
end;

procedure TWebBrowserShowTags.SetShowTags(const Value: TShowTags);
begin
                                                                               
  // favor of the new style
  if ShowTags <> Value then
  begin
    FShowTags := Value;
    CmdID := HTMLTags[Value];
  end;
end;

{ TWebBrowserLiveResize }

constructor TWebBrowserLiveResize.Create(AOwner: TComponent);
begin
  inherited;
  FCmdStr := 'LiveResize';
  CmdID := IDM_LIVERESIZE;
  FOption := woDoDefault;
  UpdateChecked := True;
end;

{ TWebBrowserRespectVisiblity }

constructor TWebBrowserRespectVisiblity.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_RESPECTVISIBILITY_INDESIGN;
  AutoCheck := True;
  UpdateChecked := True;
end;

{ TWebBrowserUndoAction }

procedure TWebBrowserUndoAction.AfterAction;
begin
  // Now that we are done with the Action end the undo unit
  if AllowBatchUndo then
    CommandUpdater.WebBrowser.MarkupServices.EndUndoUnit;
end;

procedure TWebBrowserUndoAction.BeforeAction;
begin
  // Start an undo unit so that the action can be undone
  if AllowBatchUndo then
    CommandUpdater.WebBrowser.MarkupServices.BeginUndoUnit(Name);
end;

constructor TWebBrowserUndoAction.Create(AOwner: TComponent);
begin
  inherited;
  FAllowBatchUndo := True;
end;

procedure TWebBrowserUndoAction.DoAction(Target: TObject; Data: Integer);
begin
end;

procedure TWebBrowserUndoAction.ExecuteTarget(Target: TObject);
begin
  BeforeAction(Target);
  DoAction(Target, 0);
  AfterAction(Target);
end;

{ TWebBrowserToggleAction }

constructor TWebBrowserToggleAction.Create(AOwner: TComponent);
begin
  inherited;
  AutoCheck := True;
  FOutParam := Null;
  TVarData(FInParam).VType := varBoolean;
  Option := woDontPrompt;
end;

procedure TWebBrowserToggleAction.ExecuteTarget(Target: TObject);
begin
  // NotInParam allows this descendants to control the FInParam value
  if NotInParam then
    FInParam := not Checked
  else
    FInParam := Checked;
  inherited;
end;

procedure TWebBrowserToggleAction.UpdateTarget(Target: TObject);
begin
  inherited;
end;

{ TWebBrowserAddFavorites }

constructor TWebBrowserAddFavorites.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_ADDFAVORITES;
  FOption := woPromptUser;
end;

{ TWebBrowserFont }

constructor TWebBrowserFont.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_FONT;
  FOption := woPromptUser;
end;

{ TWebBrowserColor }

constructor TWebBrowserColor.Create(AOwner: TComponent);
begin
  inherited;
  SetupDialog;
  DisableIfNoHandler := False;
end;

destructor TWebBrowserColor.Destroy;
begin
  if Assigned(FDialog) then
    FDialog.RemoveFreeNotification(Self);
  inherited;
end;

procedure TWebBrowserColor.DoAccept;
begin
  if Assigned(FOnAccept) then FOnAccept(Self)
  else
    Color := FDialog.Color;
end;

procedure TWebBrowserColor.DoCancel;
begin
  if Assigned(FOnCancel) then FOnCancel(Self);
end;

procedure TWebBrowserColor.ExecuteTarget(Target: TObject);
begin
  FExecuteResult := False;
  if Assigned(FDialog) then
  begin
    if Assigned(FBeforeExecute) then
      FBeforeExecute(Self);
    FControl := CommandUpdater.WebBrowser;
    try
      FDialog.Color := Color;
      FExecuteResult := FDialog.Execute;
      if FExecuteResult then
        DoAccept
      else
        DoCancel;
    finally
      FControl := nil;
    end;
  end;
end;

function TWebBrowserColor.GetColor: TColor;
var
  Clr: OleVariant;
begin
  if csDesigning in ComponentState then
  begin
    Result := clDefault;
    exit;
  end;
  Control.CommandTarget.Exec(@FCmdGroup, CmdID, OLECMDEXECOPT_DONTPROMPTUSER,
    POleVariant(nil)^, Clr);
  Result := Clr;
end;

procedure TWebBrowserColor.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if not (csDestroying in ComponentState) and (Operation = opRemove) and
     (AComponent = FDialog) then
    SetupDialog;
end;

procedure TWebBrowserColor.SetColor(const Value: TColor);
var
  Clr: OleVariant;
begin
  if csDesigning in ComponentState then exit;
  Clr := Value;
  OleCheck(Control.CommandTarget.Exec(@FCmdGroup, CmdID, OLECMDEXECOPT_DONTPROMPTUSER,
    Clr, POleVariant(nil)^));
end;

procedure TWebBrowserColor.SetupDialog;
begin
  FDialog := TColorDialog.Create(Self);
  FDialog.Name := Copy(TColorDialog.ClassName, 2, Length(TColorDialog.ClassName));
  FDialog.SetSubComponent(True);
  FDialog.FreeNotification(Self);
end;

{ TWebBrowserBackColor }

constructor TWebBrowserBackColor.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_BACKCOLOR;
  FOption := woDontPrompt;
end;

{ TWebBrowserForeColor }

constructor TWebBrowserForeColor.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_FORECOLOR;
  FOption := woDontPrompt;
end;

{ TWebBrowserPrintPreview }

constructor TWebBrowserPrintPreview.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_PRINTPREVIEW;
  FOption := woPromptUser;
end;

{ TWebBrowserAutoURLDetect }

constructor TWebBrowserAutoURLDetect.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_AUTOURLDETECT_MODE;
  UpdateChecked := True;
end;

{ TWebBrowserSearchFind }

constructor TWebBrowserSearchFind.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_FIND;
end;

{function TWebBrowserSearchFind.GetDialogClass: TCommonDialogClass;
begin
  Result := TFindDialog;
end;

function TWebBrowserSearchFind.GetFindDialog: TFindDialog;
begin
  Result := TFindDialog(FDialog);
end;}

{ TWebBrowserSearchReplace }

procedure TWebBrowserSearchReplace.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  TReplaceDialog(FDialog).OnReplace := Replace;
end;

function TWebBrowserSearchReplace.GetDialogClass: TCommonDialogClass;
begin
  Result := TReplaceDialog;
end;

function TWebBrowserSearchReplace.GetReplaceDialog: TReplaceDialog;
begin
  Result := TReplaceDialog(FDialog);
end;

procedure TWebBrowserSearchReplace.Replace(Sender: TObject);
{var
  Found: Boolean;
  FoundCount: Integer;}
begin
  // FBrowserControl gets set in ExecuteTarget
//  Found := False;
//  FoundCount := 0;
{  if Assigned(FControl) then
    with Sender as TReplaceDialog do
    begin
      if (Length(FControl.SelText) > 0) and
         (not (frReplaceAll in Dialog.Options) and
         (AnsiCompareText(FControl.SelText, FindText) = 0) or
         (frReplaceAll in Dialog.Options) and (FControl.SelText = FindText)) then
      begin
        FControl.SelText := ReplaceText;
        SearchEdit(FControl, Dialog.FindText, Dialog.Options, FFindFirst);
        if not (frReplaceAll in Dialog.Options) then exit;
      end;
      repeat
        Found := SearchEdit(FControl, Dialog.FindText, Dialog.Options, FFindFirst);
        if Found then
        begin
          FControl.SelText := ReplaceText;
          Inc(FoundCount);
        end;
      until not Found or not (frReplaceAll in Dialog.Options);
    end;
  if not Found and (FoundCount = 0) then
    ShowMessage(Format(STextNotFound, [Dialog.FindText]));}
end;

{ TWebBrowserSearchFindFirst }

constructor TWebBrowserSearchFindFirst.Create(AOwner: TComponent);
begin
  inherited;
//  FFindFirst := True;
end;

{ TWebBrowserSearchFindNext }

constructor TWebBrowserSearchFindNext.Create(AOwner: TComponent);
begin
  inherited;
  DisableIfNoHandler := False;
end;

procedure TWebBrowserSearchFindNext.ExecuteTarget(Target: TObject);
begin
  FSearchFind.FControl := TWebBrowserEx(Target);
  if not Assigned(FSearchFind) then exit;
//  FSearchFind.Search(Target);
end;

function TWebBrowserSearchFindNext.HandlesTarget(Target: TObject): Boolean;
begin
  Result := inherited HandlesTarget(Target);
//  Result := Assigned(FSearchFind) and FSearchFind.Enabled and
//    (Length(TFindDialog(FSearchFind.Dialog).FindText) <> 0);
//  Enabled := Result;
end;

procedure TWebBrowserSearchFindNext.UpdateTarget(Target: TObject);
begin
  if Assigned(FSearchFind) then
//    Enabled := FSearchFind.Enabled and (Length(TFindDialog(FSearchFind.Dialog).FindText) <> 0)
  else
    Enabled := False;
end;

{ TWebBrowserSuperscript }

constructor TWebBrowserSuperscript.Create(AOwner: TComponent);
begin
  inherited;
  FCmdID := IDM_SUPERSCRIPT;
  UpdateChecked := True;
end;

{ TWebBrowserSubscript }

constructor TWebBrowserSubscript.Create(AOwner: TComponent);
begin
  inherited;
  FCmdID := IDM_SUBSCRIPT;
  UpdateChecked := True;
end;

{ TWebBrowserFrameAction }

procedure TWebBrowserFrameAction.UpdateTarget(Target: TObject);
begin
  if Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
     Assigned(CommandUpdater.WebBrowser.Document2) then
    Enabled := CommandUpdater.WebBrowser.Document2.frames.length <> 0
  else
    Enabled := False;
end;

{ TWebBrowserSeamlessJoin }

constructor TWebBrowserSeamlessJoin.Create(AOwner: TComponent);
begin
  inherited;
  AutoCheck := True;
end;

procedure TWebBrowserSeamlessJoin.DoAction(Target: TObject; Data: Integer);
var
  FrameSet: IHTMLFrameSetElement;
begin
  inherited;
  CommandUpdater.WebBrowser.MarkupServices.BeginUndoUnit(Name);
  try
    if Checked then
    begin
      if Supports(CommandUpdater.WebBrowser.Document2.body,
         IHTMLFrameSetElement, FrameSet) then
      begin
        FrameSet.frameBorder := '0';  { do not localize }
        FrameSet.frameSpacing := 0;
        FrameSet.border := 0;
      end;
    end
    else
      with CommandUpdater.WebBrowser.Document2.body do
      begin
        removeAttribute('frameBorder', 0);   { do not localize }
        removeAttribute('border', 0);        { do not localize }
        removeAttribute('frameSpacing', 0);  { do not localize }
      end;
  finally
    CommandUpdater.WebBrowser.MarkupServices.EndUndoUnit;
  end;
end;

procedure TWebBrowserSeamlessJoin.UpdateTarget(Target: TObject);
begin
  inherited;
                                                               
end;

{ TWebBrowserDeleteFrame }

procedure TWebBrowserDeleteFrame.DoAction(Target: TObject; Data: Integer);
begin
  inherited;
                                                                                                      
  //       and the frame just moved to it's parent.
  with CommandUpdater.WebBrowser do
    MarkupServices.RemoveElement(Document2.activeElement);
end;

function TWebBrowserDeleteFrame.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Assigned(CommandUpdater) and (CommandUpdater.WebBrowser <> nil);
end;

procedure TWebBrowserDeleteFrame.UpdateTarget(Target: TObject);
begin
  if Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
     Assigned(CommandUpdater.WebBrowser.Document2) then
    if CommandUpdater.WebBrowser.Document2.frames.length <> 0 then
      Enabled := Supports(CommandUpdater.WebBrowser.Document2.activeElement, IHTMLFrameElement)
    else
      Enabled := False
  else
    Enabled := False;
end;

{ TWebBrowserElementAction }

function TWebBrowserElementAction.GetElement: IHTMLElement;
begin
  Result := nil;
  if (CommandUpdater = nil) or (CommandUpdater.WebBrowser = nil) or
     (CommandUpdater.WebBrowser.DisplayServices = nil) or
     (csDesigning in ComponentState) then exit;
  // Used cached current element
  Result := CommandUpdater.WebBrowser.CurrentElement;
end;

(* Slow version
function TWebBrowserElementAction.GetElement: IHTMLElement;
  function CreateRange: IDispatch;
  var
    Selection: IHTMLSelectionObject;
  begin
    Result := nil;
    try
      Selection := CommandUpdater.WebBrowser.Selection;
      if (Selection <> nil) then
        Result := Selection.createRange
      else
        Result := nil;
    except
      // Silent exceptions that occur when document is
      //  <body><frameset rows="*,5*"/><html></html></body>
      Result := nil;
    end;
  end;
var
  Range: IDispatch;
  TxtRange: IHTMLTxtRange;
  CtrlRange: IHTMLControlRange;
  DisplayServices: TDisplayServices;
  MarkupPointer: IMarkupPointer;
begin
  Result := nil;
  if (CommandUpdater = nil) or (CommandUpdater.WebBrowser = nil) or
     (CommandUpdater.WebBrowser.DisplayServices = nil) or
     (csDesigning in ComponentState) then exit;

  //Range := SafeCreateRange(CommandUpdater.WebBrowser);
  Range := CreateRange;
  if Supports(Range, IHTMLControlRange, CtrlRange) then
    Result := CtrlRange.item(0)
  else if Supports(Range, IHTMLTxtRange, TxtRange) then
    Result := TxtRange.parentElement
  else
  begin
    // Very slow
    OleCheck(CommandUpdater.WebBrowser.MarkupServices.CreateMarkupPointer(MarkupPointer));
    CommandUpdater.WebBrowser.Caret.MoveMarkupPointerToCaret(MarkupPointer);
    MarkupPointer.CurrentScope(Result);
  end;
end;
*)

function TWebBrowserElementAction.IsTargetElement: Boolean;
begin
  Result := Supports(GetElement, IHTMLElement);
end;

procedure TWebBrowserElementAction.UpdateTarget(Target: TObject);
begin
  if not (csDesigning in ComponentState) then
    Enabled := IsTargetElement;
end;

{ TWebBrowserTableAction }

function TWebBrowserTableAction.IsTargetElement: Boolean;
begin
  Result := Supports(GetElement, IHTMLTable);
end;


{ TWebBrowserTableCellAction }

function TWebBrowserTableCellAction.GetElement: IHTMLElement;
begin
  Result := inherited GetElement;
  while Assigned(Result) do
    if Supports(Result, IHTMLTableCell) then
      break
    else
      Result := Result.parentElement;
  if Result <> nil then
    if not CommandUpdater.WebBrowser.GetIsEditableElement(Result.ParentElement, [efInnerRequired]) then
      Result := nil;
end;

function TWebBrowserTableCellAction.IsTargetElement: Boolean;
var
  E: IHTMLElement;
begin
  E := GetElement;
  Result := Assigned(E);
end;

{ TWebBrowserTableInsertRow }

procedure TWebBrowserTableInsertRow.DoAction(Target: TObject;
  Data: Integer);
const
  RowPosition: array[Boolean] of Integer = (ELEM_ADJ_AfterEnd, ELEM_ADJ_BeforeBegin);
var
  E: IHTMLElement;
  NewRow: IHTMLElement;
  NewCell: IHTMLElement;
  Row: IHTMLTableRow;
  Cells: IHTMLElementCollection;
  I: Integer;
  Table: IHTMLTable;
  MS: TMarkupServices;
begin
  inherited;
  E := GetElement;
  while Assigned(E) and not Supports(E, IHTMLTable) do
  begin
    E := E.parentElement;
    if Supports(E, IHTMLTableRow) then
      Row := E as IHTMLTableRow;
  end;
  if Assigned(E) then
    if Assigned(Row) and Supports(E, IHTMLTable, Table) then
    begin
      MS := TMarkupServices.Create(nil);
      try
        MS.WebBrowser := CommandUpdater.WebBrowser;
        MS.StartPos.MoveAdjacentToElement(Row as IHTMLElement, RowPosition[FInsertAbove]);
        MS.FinishPos.MoveAdjacentToElement(Row as IHTMLElement, RowPosition[FInsertAbove]);
        MS.InsertPos.MoveAdjacentToElement(Row as IHTMLElement, RowPosition[FInsertAbove]);
        MS.MarkupServices.CloneElement(Row as IHTMLElement, NewRow);
        MS.InsertElement(NewRow);
        Cells := Row.cells;
        MS.StartPos.MoveAdjacentToElement(NewRow, ELEM_ADJ_AfterBegin);
        MS.FinishPos.MoveAdjacentToElement(NewRow, ELEM_ADJ_AfterBegin);
        MS.InsertPos.MoveAdjacentToElement(NewRow, ELEM_ADJ_AfterBegin);
        for I := 0 to Row.cells.length - 1 do
        begin
          MS.MarkupServices.CloneElement(Cells.item(i, i) as IHTMLElement, NewCell);
          MS.InsertElement(NewCell);
          MS.StartPos.MoveAdjacentToElement(NewCell, ELEM_ADJ_AfterEnd);
          MS.FinishPos.MoveAdjacentToElement(NewCell, ELEM_ADJ_AfterEnd);
          MS.InsertPos.MoveAdjacentToElement(NewCell, ELEM_ADJ_AfterEnd);
        end;
      finally
        MS.Free;
      end;
  end;
end;

{ TWebBrowserTableDeleteCell }

procedure TWebBrowserTableDeleteCell.DoAction(Target: TObject; Data: Integer);
var
  Cell: IHTMLTableCell;
  CellIdx: Integer;
  E: IHTMLElement;
  Row: IHTMLTableRow;
  Table: IHTMLTableSection;
begin
  inherited;
  E := GetElement;
  if Supports(E, IHTMLTableCell, Cell) then
  begin
    CellIdx := Cell.cellIndex;
    if Supports(E.parentElement, IHTMLTableRow, Row) then
      Row.deleteCell(CellIdx);
    if Row.cells.length = 0 then
      with (Row as IHTMLElement) do
        if Supports(parentElement, IHTMLTableSection, Table) then
          Table.deleteRow(Row.rowIndex);
  end;
end;

{ TWebBrowserTableInsertCell }

procedure TWebBrowserTableInsertCell.DoAction(Target: TObject;
  Data: Integer);
var
  Cell: IHTMLTableCell;
  CellIdx: Integer;
  E: IHTMLElement;
  Row: IHTMLTableRow;
begin
  inherited;
  E := GetElement;
  if Supports(E, IHTMLTableCell, Cell) then
  begin
    CellIdx := Cell.cellIndex;
    if Supports(E.parentElement, IHTMLTableRow, Row) then
      Row.insertCell(CellIdx);
  end;
end;

{ TWebBrowserTableColumnAction }

procedure TWebBrowserTableColumnAction.ExecuteTarget(Target: TObject);
var
  Cell: IHTMLTableCell;
  CellIdx: Integer;
  E: IHTMLElement;
  Row: IHTMLTableRow;
  I: Integer;
  Table: IHTMLTable;
begin
  BeforeAction(Target);
  E := GetElement;
  CellIdx := -1;
  if Supports(E, IHTMLTableCell, Cell) then
    CellIdx := Cell.cellIndex;
  while Assigned(E) and not Supports(E, IHTMLTable) do
  begin
    E := E.parentElement;
    Supports(E, IHTMLTableRow, Row);
  end;
  if Assigned(E) and (CellIdx <> -1) then
    if Supports(E, IHTMLTable, Table) then
      for I := 0 to Table.rows.length - 1 do
      begin
        FActiveRow := Table.rows.item(I,I) as IHTMLTableRow;
        if FActiveRow.cells.length < CellIdx then
          DoAction(Target, FActiveRow.cells.length - 1)
        else
          DoAction(Target, CellIdx);        
      end;
  AfterAction(Target);
end;

{ TWebBrowserTableInsertColumn }

procedure TWebBrowserTableInsertColumn.DoAction(Target: TObject;
  Data: Integer);
begin
  if not FInsertToLeft then
    Inc(Data);
                                                                              
  if Data = ActiveRow.cells.length then
    Data := -1;
  ActiveRow.insertCell(Data);
end;

{ TWebBrowserTableDeleteColumn }

procedure TWebBrowserTableDeleteColumn.DoAction(Target: TObject;
  Data: Integer);
begin
  ActiveRow.deleteCell(Data);
end;

{ TWebBrowserTableMoveRow }

procedure TWebBrowserTableMoveRow.DoAction(Target: TObject; Data: Integer);
const
  MoveDirection: array[Boolean] of Integer = (1,-1);
var
  E: IHTMLElement;
  Row: IHTMLTableRow;
  Body: IHTMLTableSection2;
begin
  inherited;
  E := GetElement;
  if Supports(E, IHTMLTableCell) then
  begin
    E := E.parentElement;
    if Supports(E, IHTMLTableRow, Row) then
      if Supports((Row as IHTMLElement).parentElement, IHTMLTableSection2, Body) then
        Body.moveRow(Row.rowIndex, Row.rowIndex + MoveDirection[MoveUp]);
  end;
end;

procedure TWebBrowserTableMoveRow.UpdateTarget(Target: TObject);
const
  MoveDirection: array[Boolean] of Integer = (1,-1);
var
  E: IHTMLElement;
  Table: IHTMLTable;
  Row: IHTMLTableRow;
begin
  if not (csDesigning in ComponentState) then
    if IsTargetElement then
    begin
      if Supports(Element, IHTMLTableCell) then
      begin
        E := Element.parentElement;
        if Supports(E, IHTMLTableRow, Row) then
          if MoveUp then
            Enabled := Row.rowIndex > 0
          else
          begin
            Table := nil;
            while Assigned(E) and not Supports(E, IHTMLTable, Table) do
              E := E.parentElement;
            if Assigned(Table) then
              Enabled := Row.rowIndex < Table.rows.length - 1;
          end;
      end;
    end
    else
      Enabled := False;
end;

{ TWebBrowserTableDeleteRow }

procedure TWebBrowserTableDeleteRow.DoAction(Target: TObject; Data: Integer);
var
  E: IHTMLElement;
  Row: IHTMLTableRow;
  TBody: IHTMLTableSection;
  Table: IHTMLTable;
  DOMNode: IHTMLDOMNode;
begin
  inherited;
  E := GetElement;
  if Supports(E.parentElement, IHTMLTableRow, Row) then
    if Supports((Row as IHTMLElement).parentElement, IHTMLTableSection, TBody) then
    begin
      TBody.deleteRow(Row.rowIndex);
      if TBody.rows.length = 0 then
        with TBody as IHTMLElement do
          if Supports(parentElement, IHTMLTable, Table) then
            if Supports(Table, IHTMLDOMNode, DOMNode) then
              DOMNode.removeNode(True);
    end;
end;

{ TWebBrowserKeepSelection }

constructor TWebBrowserKeepSelection.Create(AOwner: TComponent);
begin
  inherited;
  FOption := woDontPrompt;
  CmdID := IDM_KEEPSELECTION;
end;

{ TWebBrowserTableDelete }

procedure TWebBrowserTableDelete.DoAction(Target: TObject; Data: Integer);
var
  E: IHTMLElement;
  DOMNode: IHTMLDOMNode;
begin
  inherited;
  E := GetElement;
  if Supports(E, IHTMLDOMNode, DOMNode) then
    DOMNode.removeNode(True);
end;

function TWebBrowserTableDelete.GetElement: IHTMLElement;
begin
  Result := inherited GetElement;
  while Assigned(Result) and not Supports(Result, IHTMLTable) do
    Result := Result.parentElement;
end;

{ TWebBrowserControlSelection }

procedure TWebBrowserControlSelection.AfterAction;
begin
  // Now that we are done with the Action end the undo unit
  if AllowBatchUndo then
    CommandUpdater.WebBrowser.MarkupServices.EndUndoUnit;
end;

procedure TWebBrowserControlSelection.BeforeAction;
begin
  // Start an undo unit so that the action can be undone
  if AllowBatchUndo then
    CommandUpdater.WebBrowser.MarkupServices.BeginUndoUnit(Name);
end;

constructor TWebBrowserControlSelection.Create(AOwner: TComponent);
begin
  inherited;
  FAllowBatchUndo := True;
  FMaxSelCount := MaxInt;
  FMinSelCount := 1;
end;

procedure TWebBrowserControlSelection.ExecuteTarget(Target: TObject);
var
  I: Integer;
var
  IsLocked: OleVariant;
begin
  if Supports(SafeCreateControlRange(CommandUpdater.WebBrowser), IHTMLControlRange, FControlRange) then
  try
    BeforeAction;
    if Assigned(FControlRange) then
      for I := 0 to FControlRange.length - 1 do
      begin
        IsLocked := FControlRange.item(I).getAttribute('Design_Time_Lock', 0);
        if FIgnoreLockedControls and (not VarIsNull(IsLocked) and IsLocked) then
          continue;
        DoAction(I, FControlRange.item(I));
      end;
    AfterAction;
  finally
    FControlRange := nil;
  end;
end;

function TWebBrowserControlSelection.GetEnabled: Boolean;
begin
  Result := False;
  if Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) then
  begin
    if Supports(SafeCreateControlRange(CommandUpdater.WebBrowser),
       IHTMLControlRange, FRange) then
    begin
      Result := (FRange.length >= FMinSelCount) and (FRange.length <= FMaxSelCount);
      if Result then
        if CommandUpdater.WebBrowser.GetIsContentPage then
          if not CommandUpdater.WebBrowser.GetIsEditableElement(
            CommandUpdater.WebBrowser.CurrentElement, [efOuterRequired]) then
              Result := False;
    end;
  end
end;

procedure TWebBrowserControlSelection.UpdateTarget(Target: TObject);
begin
  try
    Enabled := GetEnabled;
  finally
    FRange := nil;
  end;
end;

{ TWebBrowserAlignControls }

procedure TWebBrowserAlignControls.BeforeAction;
begin
  inherited;
  FPrimaryElement := ControlRange.item(0);
end;

constructor TWebBrowserAlignControls.Create(AOwner: TComponent);
begin
  inherited;
  IgnoreLockedControls := True;
  MinSelCount := 2;
end;

{ TWebBrowserAlignControlsLeft }

procedure TWebBrowserAlignControlsLeft.DoAction(Index: Integer; Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.left := PrimaryElement.offsetLeft;
end;

{ TWebBrowserAlignControlsRight }

procedure TWebBrowserAlignControlsRight.DoAction(Index: Integer;
  Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.left := PrimaryElement.offsetLeft + PrimaryElement.offsetWidth - Element.offsetWidth;
end;

{ TWebBrowserAlignControlsTop }

procedure TWebBrowserAlignControlsTop.DoAction(Index: Integer;
  Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.top := PrimaryElement.offsetTop;
end;

{ TWebBrowserAlignControlsBottom }

procedure TWebBrowserAlignControlsBottom.DoAction(Index: Integer;
  Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.top := (PrimaryElement.style.pixelTop + PrimaryElement.offsetHeight) -
    Element.offsetHeight;
end;

{ TWebBrowserAlignVerticalCenters }

procedure TWebBrowserAlignVerticalCenters.DoAction(Index: Integer;
  Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.top := (PrimaryElement.style.pixelTop + PrimaryElement.offsetHeight div 2) -
    Element.offsetHeight div 2;
end;

{ TWebBrowserAlignHorizontalCenters }

procedure TWebBrowserAlignHorizontalCenters.DoAction(Index: Integer;
  Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.left := (PrimaryElement.style.pixelLeft + PrimaryElement.offsetWidth div 2) -
    Element.offsetWidth div 2;
end;

{ TWebBrowserMakeSameWidth }

procedure TWebBrowserMakeSameWidth.DoAction(Index: Integer;
  Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.width := GetPixelWidthPropertyValue(PrimaryElement);
  CommandUpdater.DoElementPropertiesChanged(Element, [epWidth]);
end;

{ TWebBrowserMakeSameHeight }

procedure TWebBrowserMakeSameHeight.DoAction(Index: Integer;
  Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.height := GetPixelHeightPropertyValue(PrimaryElement);
  CommandUpdater.DoElementPropertiesChanged(Element, [epHeight]);
end;

{ TWebBrowserMakeSameSize }

procedure TWebBrowserMakeSameSize.DoAction(Index: Integer;
  Element: IHTMLElement);
begin
  if (Index = 0) then exit;
  Element.style.Width := GetPixelWidthPropertyValue(PrimaryElement);
  Element.style.Height := GetPixelHeightPropertyValue(PrimaryElement);
  CommandUpdater.DoElementPropertiesChanged(Element, [epHeight, epHeight]);
end;

{ TWebBrowserDesignTimeLock }

procedure TWebBrowserDesignTimeLock.DoAction(Index: Integer;
  Element: IHTMLElement);
var
  Value: OleVariant;
  I: Integer;
  Range: IHTMLControlRange;
begin
  if Supports(SafeCreateControlRange(CommandUpdater.WebBrowser), IHTMLControlRange, Range) then
  begin
    for I := 0 to Range.length - 1 do
    begin
      Value := Range.Item(I).getAttribute('Design_Time_Lock', 0);
      if VarIsNull(Value) then
        Value := False;
      if Value then
      begin
        Element.removeAttribute(WideString(sDesignTimeLock), 0);
        Element.style.removeAttribute(sDesignTimeLock, 0);
      end
      else
      begin
        Element.setAttribute(sDesignTimeLock, 'true', 1);
        Element.style.setAttribute(sDesignTimeLock, 'true', 0);
      end;
    end;
    Range.select;  // Reselect range so the border around controls is redrawn
  end;
end;

procedure TWebBrowserDesignTimeLock.UpdateTarget(Target: TObject);
var
  I: Integer;
  IsLocked: OleVariant;
  Range: IHTMLControlRange;
begin
  inherited;
  if Enabled then
  begin
    if Supports(SafeCreateControlRange(CommandUpdater.WebBrowser),
       IHTMLControlRange, Range) then
      for I := 0 to Range.length - 1 do
      begin
        IsLocked := Range.Item(I).getAttribute('Design_Time_Lock', 0);
        if VarIsNull(IsLocked) or not IsLocked then
          break
      end;
    if VarIsNull(IsLocked) then
      Checked := False
    else
      Checked := IsLocked;
  end
  else
    Checked := False;
end;

{ TWebBrowserInsertTag }

function TWebBrowserInsertTag.CanInsert: Boolean;
begin
  if Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
     (Supports(SafeCreateControlRange(CommandUpdater.WebBrowser), IHTMLControlRange) or
     (CommandUpdater.WebBrowser.Document2.frames.length <> 0)) then
    Result := False
  else
    Result := IEActions.CanInsertControlAtCurrentPosition(CommandUpdater.WebBrowser);
end;


procedure ValidateInsertablePosition(WebBrowser: TWebBrowserEx; StartPos: IMarkupPointer);
var
  LElement: IHTMLElement;
begin
  if WebBrowser.GetIsContentPage then
  begin
    OleCheck(StartPos.CurrentScope(LElement));
    if not WebBrowser.GetIsEditableElement(LElement, [efInnerRequired]) then
      raise Exception.Create(sCannotInsertAtCurrentPosition);
  end;
end;

function CanInsertControlAtCurrentPosition(WebBrowser: TWebBrowserEx): Boolean;
begin
  Result := True;
  if WebBrowser.GetIsContentPage then
  begin
    case WebBrowser.CurrentElementType of
      cetAtCursor,
      cetTextRange:
        Result := WebBrowser.GetIsEditableElement(
          WebBrowser.CurrentElement, [efInnerRequired]);
      cetControlRange:
        Result := WebBrowser.GetIsEditableElement(
          WebBrowser.CurrentElement.parentElement, [efInnerRequired]);
    end;
  end;
end;

procedure ShowElementCreateError(const ATagName, AMessage: string);
begin
  MessageDlg(Format(sElementCreateError, [ATagName, AMessage]), mtError, [mbOk], 0);
end;

procedure TWebBrowserInsertTag.ExecuteTarget(Target: TObject);
var
  E: IHTMLElement;
  StartMP, FinishMP: IMarkupPointer;
  DP: IDisplayPointer;
begin
  with CommandUpdater.WebBrowser, CommandUpdater.WebBrowser.MarkupServices do
  begin
    BeginUndoUnit('Insert_Tag');  { do not localize }
    try
      OleCheck(createElement(GetTagID, #0, E));
      OleCheck(CreateMarkupPointer(StartMP));
      OleCheck(Caret.MoveMarkupPointerToCaret(StartMP));
      OleCheck(StartMP.SetGravity(POINTER_GRAVITY_Left));
      OleCheck(CreateMarkupPointer(FinishMP));
      OleCheck(Caret.MoveMarkupPointerToCaret(FinishMP));
      OleCheck(FinishMP.SetGravity(POINTER_GRAVITY_Right));
      try
        ValidateInsertablePosition(CommandUpdater.WebBrowser, StartMP); // raises exception
      except
      on E:Exception do
        begin
          ShowElementCreateError(HTMLTag, E.Message);
          Abort;
        end;
      end;
      OleCheck(InsertElement(E, StartMP, FinishMP));
      OleCheck(StartMP.MoveAdjacentToElement(E, ELEM_ADJ_AfterBegin));
      OleCheck(DisplayServices.CreateDisplayPointer(DP));
      OleCheck(DP.MoveToMarkupPointer(StartMP, nil));
      OleCheck(Caret.MoveCaretToPointer(DP, 0, CARET_DIRECTION_SAME));
    finally
      EndUndoUnit;  { do not localize }
    end;
  end;
  if Assigned(FOnElementCreated) then
    FOnElementCreated(Self, E);
end;

//function TWebBrowserInsertTag.GetElement: IHTMLElement;
//var
//  Pointer: IMarkupPointer;
//  DispPtr: IDisplayPointer;
//begin
//  Result := nil;
//  if (CommandUpdater = nil) or (CommandUpdater.WebBrowser = nil) or
//     (CommandUpdater.WebBrowser.DisplayServices = nil) or
//     (csDesigning in ComponentState) then exit;
//  Result := CommandUpdater.WebBrowser.CurrentInsertionPoint;
////  CommandUpdater.WebBrowser.DisplayServices.CreateDisplayPointer(DispPtr);
////  if Assigned(DispPtr) then
////  begin
////    OleCheck(CommandUpdater.WebBrowser.MarkupServices.CreateMarkupPointer(Pointer));
////    OleCheck(CommandUpdater.WebBrowser.Caret.MoveDisplayPointerToCaret(DispPtr));
////    OleCheck(DispPtr.PositionMarkupPointer(Pointer));
////    OleCheck(Pointer.CurrentScope(Result));
////  end;
//end;

function TWebBrowserInsertTag.GetTagID: _ELEMENT_TAG_ID;
var
  WS: WideString;
begin
  Result := TAGID_NULL;
  if Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) then
  begin
    WS := FHTMLTag;
    OleCheck(CommandUpdater.WebBrowser.MarkupServices.GetTagIDForName(WS, Result));
  end
end;

procedure TWebBrowserInsertTag.SetHTMLTag(const Value: string);
var
  WS: WideString;
  TagID: _ELEMENT_TAG_ID;
begin
  if AnsiCompareText(Value, FHTMLTag) <> 0 then
  begin
    if Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) then
    begin
      WS := Value;
      OleCheck(CommandUpdater.WebBrowser.MarkupServices.GetTagIDForName(WS, TagID));
      FHTMLTag := Value;
    end
    else
      FHTMLTag := Value;
  end;
end;

procedure TWebBrowserInsertTag.UpdateTarget(Target: TObject);
begin
  Enabled := Assigned(CommandUpdater) and Assigned(CommandUpdater.WebBrowser) and
    Assigned(CommandUpdater.WebBrowser.Document) and CanInsert;
end;

{ TWebBrowserOverwrite }

constructor TWebBrowserOverwrite.Create(AOwner: TComponent);
begin
  inherited;
  CmdID := IDM_OVERWRITE;
end;

{ TWebBrowserInputAction }

function TWebBrowserInputAction.IsTargetElement: Boolean;
begin
  Result := Supports(GetElement, IHTMLInputElement);
end;

{ TWebBrowserControlAction }

function TWebBrowserControlAction.GetElement: IHTMLElement;
var
  Selection: IHTMLControlRange;
  CtrlRange: IHTMLControlRange;
begin
  Result := nil;
  if not Assigned(CommandUpdater) or (CommandUpdater.WebBrowser = nil) or
     (csDesigning in ComponentState) then exit;
  if CommandUpdater.WebBrowser.Selection <> nil then
  begin
    Selection := SafeCreateControlRange(CommandUpdater.WebBrowser);
    if Supports(Selection, IHTMLControlRange, CtrlRange) then
      if (CtrlRange.length = 1) then
        Result := CtrlRange.item(0);
  end;
end;

{ TWebBrowserImageAction }

function TWebBrowserImageAction.IsTargetElement: Boolean;
begin
  Result := Supports(GetElement, IHTMLImgElement);
end;

{ TWebBrowserAbsolutionPositionAction }

function TWebBrowserAbsolutionPositionAction.GetEnabled: Boolean;
var
  Style: IHTMLStyle;
  I: Integer;
begin
  Result := inherited GetEnabled;
  if Result then
  begin
    if CommandUpdater.GetActionState(Self, csEnabled, Result) then
      Exit;
    for I := 0 to FRange.length - 1 do
    begin
      Style := FRange.item(I).style;
      if WideCompareText(Style.position, 'absolute') <> 0 then
      begin
        Result := False;
        break;
      end;
    end;
    CommandUpdater.SaveActionState(Self, csEnabled, Result);
  end;
end;

{ TWebBrowserBringToFront }

procedure TWebBrowserBringToFront.DoAction(Index: Integer;
  Element: IHTMLElement);
var
  ZIndex: Integer;
  Style: IHTMLStyle;
  I: Integer;
begin
  if Assigned(FOnGetNextZIndex) then
    for I := 0 to FControlRange.length - 1 do
    begin
      FOnGetNextZIndex(Self, ZIndex);
      Style := FControlRange.item(I).style;
      Style.zIndex := ZIndex;
    end;
end;

{ TWebBrowserSendToBack }

procedure TWebBrowserSendToBack.DoAction(Index: Integer;
  Element: IHTMLElement);
var
  ZIndex: Integer;
  Style: IHTMLStyle;
  I: Integer;
begin
  if Assigned(FOnGetPrevZIndex) then
    for I := 0 to FControlRange.length - 1 do
    begin
      FOnGetPrevZIndex(Self, ZIndex);
      Style := FControlRange.item(I).style;
      Style.zIndex := ZIndex;
    end;
end;

{ TWebBrowserInsertFormTag }

function TWebBrowserInsertFormTag.CanInsert: Boolean;
var
  E: IHTMLElement;
begin
  Result := inherited CanInsert;
  if not Result then exit;
  //E := GetElement;
  E := CommandUpdater.WebBrowser.CurrentElement;
  Result := True;
  while Assigned(E) do
    if Supports(E, IHTMLFormElement) then
    begin
      Result := False;
      Break;
    end
    else
      E := E.parentElement;
end;

{ TWebBrowserSelectAllControls }

procedure TWebBrowserSelectAllControls.ExecuteTarget(Target: TObject);
var
  FContentPage: Boolean;
  function CanSelect(AElement: IHTMLElement): Boolean;
  begin
    Result := (not FContentPage) or CommandUpdater.WebBrowser.GetIsEditableElement(AElement, [efOuterRequired, efSelectableControlRequired]);
  end;
var
  I: Integer;
  ControlRange: IHTMLControlRange;
  E2: IHTMLElement2;
  D2: IHTMLDocument2;
  CtrlElement: IHTMLControlElement;
  ElementCol: IHTMLElementCollection;
begin
  if Supports(CommandUpdater.WebBrowser.ActiveDocument, IHTMLDocument2, D2) and
     Supports(D2.body, IHTMLElement2, E2) and
     Supports(E2.createControlRange, IHTMLControlRange, ControlRange) and
     Supports(D2.body.all, IHTMLElementCollection, ElementCol) then
  begin
    FContentPage := CommandUpdater.WebBrowser.GetIsContentPage;
    for I := 0 to ElementCol.length - 1 do
    begin
        if Supports(ElementCol.item(I, I), IHTMLControlElement, CtrlElement) then
        try
          // Wrap in a try...except since certain table tags cause "Invalid argument" errors
          if CanSelect(CtrlElement as IHTMLElement) then
            ControlRange.add(CtrlElement)
        except
        end
        else
          if Supports(ElementCol.item(I, I), IHTMLElement2, E2) then
            if (E2.currentStyle as IHTMLCurrentStyle2).hasLayout then
              if CanSelect(E2 as IHTMLElement) then
                (ControlRange as IHTMLControlRange2).addElement(E2 as IHTMLElement);
    end;
    if ControlRange.Length > 0 then
      ControlRange.select;
  end;
end;

procedure TWebBrowserSelectAllControls.UpdateTarget(Target: TObject);
begin
  Enabled := (CommandUpdater <> nil) and (CommandUpdater.WebBrowser <> nil);
end;

{ TWebBrowserFormatAction }

procedure TWebBrowserFormatAction.UpdateTarget(Target: TObject);
begin
  inherited;
  if Enabled and CommandUpdater.WebBrowser.GetIsContentPage then
  begin
    if not CommandUpdater.WebBrowser.GetIsEditableElement(
      CommandUpdater.WebBrowser.CurrentElement, [efOuterRequired]) then
    begin
      Enabled := False;
      Checked := False;
    end;
  end;
end;

end.
