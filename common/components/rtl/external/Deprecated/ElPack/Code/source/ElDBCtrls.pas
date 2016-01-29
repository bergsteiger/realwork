{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
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

(*

Version History

03/16/2002

  Added ElWideDBEdit and ElWideDBMemo
  ElRadioGroup made unicode

*)

unit ElDBCtrls;

interface

uses
     DB,
     ElPanel,
{$ifndef LINUX}
     ElToolbar,
{$else}
     ElToolBar,
{$endif}
     ElTmSchema,
     ElPopBtn,
     ElACtrls,
     ElMaskEdit,
     ElCheckCtl,
     ElCheckItemGrp,
     ElStrUtils,
{$ifdef ELPACK_UNICODE}
     ElUnicodeStrings,
{$endif}

     DBCtrls,
     Forms,
     Windows,
     Controls,
     StdCtrls,
     Graphics,
     Messages,
     Dialogs,
     ElPromptDlg,
     ElEdits,
{$ifdef VCL_6_USED}
     Types,
{$endif}
     ElGlyphs,
     Classes,
     SysUtils,
     ElDBConst,
     ElVCLUtils
     ;

type

{$ifdef MSWINDOWS}
{$ifdef ELPACK_UNICODE}
  TElFStrings = TElWideStrings;
  TElFStringList = TElWideStringList;
{$else}
  TElFStrings = TStrings;
  TElFStringList = TStringList;
{$endif}
{$else}
  TElFStrings = TElWideStrings;
  TElFStringList = TElWideStringList;
{$endif}

  TElDBEdit = class(TCustomElMaskEdit)
  private
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure ResetMaxLength;
    procedure DataChange(Sender: TObject);
    procedure ActiveChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure SetFocused(Value: Boolean);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
  protected
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset; override;
  public
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;

    property ActiveBorderType;
    property Alignment;
    property Background;
    property Flat;
    property InactiveBorderType;
    property OnMouseEnter;
    property OnMouseLeave;
    property Transparent;
    property UseBackground;
    property BorderSides;
    property HandleDialogKeys;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
    property UseXPThemes;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property Align;
    {$IFDEF VCL_4_USED}
    property Anchors;
    {$ENDIF}
    property AutoSelect;
    property AutoSize;
    {$IFDEF VCL_4_USED}
    {$ifdef MSWINDOWS}
    property BiDiMode;
    {$endif}
    {$ENDIF}
    property BorderStyle;
    property CharCase;
    property Color;
    {$IFDEF VCL_4_USED}
    property Constraints;
    {$ENDIF}
    property Cursor;
    {$ifdef MSWINDOWS}
    property DragCursor;
    {$endif}
    {$IFDEF VCL_4_USED}
    {$ifdef MSWINDOWS}
    property DragKind;
    {$endif}
    {$ENDIF}
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    {$ifdef MSWINDOWS}
    property ImeMode;
    property ImeName;
    {$endif}
    property MaxLength;
    {$ifdef MSWINDOWS}
    property OEMConvert;
    {$endif}
    {$IFDEF VCL_4_USED}
    {$ifdef MSWINDOWS}
    property ParentBiDiMode;
    {$endif}
    {$ENDIF}
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    {$ifdef MSWINDOWS}
    property PasswordChar;
    {$endif}
    property PopupMenu;
    property ShowHint;
    property TabOrder;

    property Visible;
    property OnChange;
    property OnClick;
    {$IFDEF VCL_5_USED}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF VCL_4_USED}
    {$ifdef MSWINDOWS}
    property OnEndDock;
    {$endif}
    {$ENDIF}
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
    {$ifdef MSWINDOWS}
    property OnStartDock;
    {$endif}
    {$ENDIF}
    property OnStartDrag;
  end;

  TElDBMemo = class(TElAdvancedMemo)
  private
    FAutoDisplay: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetAutoDisplay(Value: Boolean);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetReadOnly: Boolean;
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message
        WM_LBUTTONDBLCLK;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure LoadMemo; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default
        True;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;

  TElDBCheckBox = class(TElCheckBox)
  private
    FDataLink: TFieldDataLink;
    FValueCheck: TElFString;
    FValueUncheck: TElFString;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure DataChange(Sender: TObject);
    function GetFieldState: TCheckBoxState;
    procedure SetValueCheck(const Value: TElFString);
    procedure SetValueUncheck(const Value: TElFString);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;
  protected
    FUnicodeMode: TElDBUnicodeMode;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Toggle; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    procedure Click; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ValueChecked: TElFString read FValueCheck write SetValueCheck;
    property ValueUnchecked: TElFString read FValueUncheck write SetValueUncheck;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;
  end;

  TElDBRadioGroup = class(TCustomElRadioGroup)
  private
    FDataLink: TFieldDataLink;
    FOnChange: TNotifyEvent;
    FValue: TElFString;
    FValues: TElFStrings;
    FInSetValue: Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure DataChange(Sender: TObject);
    function GetButtonValue(Index: Integer): TElFString;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetItems(Value: TElFStrings);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValue(Value: TElFString);
    procedure SetValues(Value: TElFStrings);
    procedure UpdateData(Sender: TObject);
  protected
    FUnicodeMode: TElDBUnicodeMode;
    function CanModify: Boolean; override;
    procedure Change; virtual;
    procedure Click; override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property DataLink: TFieldDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    property Field: TField read GetField;
    property Value: TElFString read FValue write SetValue;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Values: TElFStrings read FValues write SetValues;
    property Items write SetItems;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;

    property Align;
    property Alignment;
{$IFDEF VCL_4_USED}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
    property BorderSides;
    property Caption;
    property CaptionColor;
    property CheckBoxChecked;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property FlatAlways;
    property Font;
    property Hints;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
  {$ifdef HAS_HTML_RENDER}
    property IsHTML;
  {$endif}
    property MoneyFlat;
    property MoneyFlatInactiveColor;
    property MoneyFlatActiveColor;
    property MoneyFlatDownColor;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCheckBox;
    property ShowFocus;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property UseXPThemes;

    {$ifdef USE_SOUND_MAP}
    property CheckSound;
    property SoundMap;
    {$endif}
    property Glyph;
    property Images;
    property AlphaForImages;
    property UseCustomGlyphs;
    property UseImageList;

    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
  end;

  TElNavButtonRole = (nbrFirst, nbrPrior, nbrNext, nbrLast,
                      nbrInsert, nbrDelete, nbrEdit, nbrPost,
                      nbrCancel, nbrRefresh,
                      // nbrSetBookmark, nbrGotoBookmark, nbrDeleteBookmark,
                      nbrSearch, nbrSetFilter, nbrRemoveFilter,
                      nbrClear, nbrOpen, nbrClose,
                      nbrFindFirst, nbrFindPrior, nbrFindNext, nbrFindLast, nbrCustom);


  TElDBNavButton = class(TCustomElToolButton)
  protected
    FRole: TElNavButtonRole;
{$IFDEF VCL_5_USED}
    FCustomAction: Boolean;
{$ENDIF}
    procedure SetRole(Value: TElNavButtonRole);
    function GetArrowThemedClassName: WideString; override;
    function GetArrowThemePartID: Integer; override;
    function GetArrowThemeStateID: Integer; override;
    function GetThemedClassName: WideString; override;
    function GetThemePartID: Integer; override;
    function GetThemeStateID: Integer; override;
    procedure SetUseImageList(newValue : Boolean); override;
    procedure Loaded; override;
    procedure SetImageList(newValue : TImageList); override;
    procedure SetImageIndex(newValue : Integer); override;

    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  public
    procedure AClick(Arrow : boolean); override;
    constructor Create(AOwner : TComponent); override;
  published
    property Role: TElNavButtonRole read FRole write SetRole default nbrCustom;

    property Wrap;
    property LargeGlyph;
    property NumLargeGlyphs;
    property Glyph;
    property NumGlyphs;
    property OwnerSettings;

    property PullDownMenu;
    property PopupPlace;
    property DisableAutoPopup;
    property Flat;
    property Layout;
    property Margin;
    property Spacing;
    property UseArrow;
    property ShadowFollowsColor;
    property ShowGlyph;
    property ShowText;
    property OnArrowClick;
    property Icon;
    property TextDrawType;
    property ThinFrame;
{$IFDEF USE_SOUND_MAP}
    property DownSound;
    property UpSound;
    property ClickSound;
    property ArrowClickSound;
    property SoundMap;
{$ENDIF}
    property UseIcon;
    property ImageIndex;
    property UseImageList;
    property OldStyled;
    property Background;
    property DownBackground;
    property BackgroundDrawBorder;
    {$ifdef MSWINDOWS}
    property UseXPThemes;
    {$endif}

    // VCL properties
    property Caption;
    property Enabled;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;

{$IFDEF VCL_4_USED}
    property Action;
    property Constraints;
{$ENDIF}
{$IFDEF VCL_5_USED}
    property OnContextPopup;
    property CustomAction: Boolean read FCustomAction write FCustomAction default
        false;
{$ENDIF}
  end;

  {$warnings off}
  TElNavDataLink = class;
  TElDBNavigator = class(TElToolbar)
  private
    FDeleteRecordQuestion : string;
    FDataLink : TElNavDataLink;
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  protected
    FConfirmDelete: Boolean;
    FOnSearch: TNotifyEvent;
    FIsToolbar: Boolean;
    FIntImageList: TImageList;
    procedure ActiveChanged;
    procedure DataChanged;
    procedure EditingChanged;
    procedure DoSearch; virtual;
    function GetButtonClass: TElToolButtonClass; override;
    procedure SetIsToolbar(Value: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    procedure CMControlChange(var Msg : TCMControlChange); message CM_CONTROLCHANGE;
  public
    constructor Create(AOwner : TComponent); override;
    function FindButtonByRole(Role : TElNavButtonRole): TElDBNavButton;
    function AddButton(Role : TElNavButtonRole): TElDBNavButton;
    procedure AddButtons(const Roles : array of TElNavButtonRole);
    destructor Destroy; override;
  published
    property DeleteRecordQuestion : string read FDeleteRecordQuestion write FDeleteRecordQuestion;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete
        default true;
    property OnSearch: TNotifyEvent read FOnSearch write FOnSearch;
    property IsToolbar: Boolean read FIsToolbar write SetIsToolbar default true;
    property BtnOffsHorz default 0;
    property BtnOffsVert default 0;
    {$ifdef VCL_4_USED}
    property BevelOuter default bvNone;
    {$endif}
  end;
  {$warnings on}

  TElNavDataLink = class(TDataLink)
  private
    FNavigator: TElDBNavigator;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create(ANav: TElDBNavigator);
    destructor Destroy; override;
  end;

  {$ifdef ELPACK_UNICODE}
  TElWideDBEdit = class(TCustomElEdit)
  private
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure ResetMaxLength;
    procedure DataChange(Sender: TObject);
    procedure ActiveChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure SetFocused(Value: Boolean);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
  protected
    FUnicodeMode: TElDBUnicodeMode;
    procedure Change; override;
    function EditCanModify: Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset;
  public
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;

    property Multiline;
    property AutoSize;
    property Alignment;
    property Background;
    property BorderSides;
    property CharCase;
    property UseBackground;
    property RightAlignedView;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property WantTabs;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
    property AutoSelect;
    property HandleDialogKeys;
    property HideSelection;
    property TabSpaces;
    property Lines stored false;

    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

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

    property WordWrap;
    property ScrollBars;

    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

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
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property UseXPThemes;
    {$IFDEF VCL_4_USED}
    {$ifdef MSWINDOWS}
    property BiDiMode;
    {$endif}
    {$ENDIF}
    property Cursor;
    {$ifdef MSWINDOWS}
    property ImeMode;
    property ImeName;
    {$endif}

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
    property OnStartDrag;

  {$IFDEF VCL_4_USED}
    property OnStartDock;
    property OnEndDock;
  {$ENDIF}
  {$IFDEF VCL_5_USED}
    property OnContextPopup;
  {$ENDIF}
  end;

  TElWideDBMemo = class(TCustomElEdit)
  private
    FAutoDisplay: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetAutoDisplay(Value: Boolean);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetReadOnly: Boolean;
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message
        WM_LBUTTONDBLCLK;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
  protected
    FUnicodeMode: TElDBUnicodeMode;
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure LoadMemo; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default
        True;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;

    property AutoSize;
    property Alignment;
    property Background;
    property BorderSides;
    property CharCase;
    property UseBackground;
    property RightAlignedView;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property WantTabs;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
    property AutoSelect;
    property HandleDialogKeys;
    property HideSelection;
    property TabSpaces;
    property Lines stored false;

    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

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

    property WordWrap;
    property ScrollBars;

    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

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
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property UseXPThemes;
    {$IFDEF VCL_4_USED}
    {$ifdef MSWINDOWS}
    property BiDiMode;
    {$endif}
    {$ENDIF}
    property Cursor;
    {$ifdef MSWINDOWS}
    property ImeMode;
    property ImeName;
    {$endif}

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
    property OnStartDrag;

  {$IFDEF VCL_4_USED}
    property OnStartDock;
    property OnEndDock;
  {$ENDIF}
  {$IFDEF VCL_5_USED}
    property OnContextPopup;
  {$ENDIF}
  end;
  {$endif}

resourcestring

 rs_nbrFirst            = 'First Record';
 rs_nbrPrior            = 'Prior Record';
 rs_nbrNext             = 'Next Record';
 rs_nbrLast             = 'Last Record';
 rs_nbrInsert           = 'Insert Record';
 rs_nbrDelete           = 'Delete Record';
 rs_nbrEdit             = 'Edit Record';
 rs_nbrPost             = 'Post Record';
 rs_nbrCancel           = 'Cancel Changes';
 rs_nbrRefresh          = 'Refresh';
 rs_nbrSearch           = 'Search';
 rs_nbrSetFilter        = 'Set Filter';
 rs_nbrRemoveFilter     = 'Remove Filter';
 rs_nbrClear            = 'Clear';
 rs_nbrOpen             = 'Open';
 rs_nbrClose            = 'Close';
 rs_nbrFindFirst        = 'Find First';
 rs_nbrFindPrior        = 'Find Prior';
 rs_nbrFindNext         = 'Find Next';
 rs_nbrFindLast         = 'Find Last';

{$ifndef D_5_UP}
Const
{$else}
Var
{$endif}

  ElDBNavButtonsHint :array[Low(TElNavButtonRole)..Pred(nbrCustom)] of PResStringRec =
  (
//  nbrFirst, nbrPrior, nbrNext, nbrLast,
    @rs_nbrFirst, @rs_nbrPrior, @rs_nbrNext, @rs_nbrLast,
//  nbrInsert, nbrDelete, nbrEdit, nbrPost,
    @rs_nbrInsert, @rs_nbrDelete, @rs_nbrEdit, @rs_nbrPost,
//  nbrCancel, nbrRefresh,
    @rs_nbrCancel, @rs_nbrRefresh,
//  nbrSearch, nbrSetFilter, nbrRemoveFilter
    @rs_nbrSearch, @rs_nbrSetFilter, @rs_nbrRemoveFilter,
//  nbrClear, nbrOpen, nbrClose,
    @rs_nbrClear, @rs_nbrOpen, @rs_nbrClose,
//  nbrFindFirst, nbrFindPrior, nbrFindNext, nbrFindLast,
    @rs_nbrFindFirst, @rs_nbrFindPrior, @rs_nbrFindNext, @rs_nbrFindLast
  );

implementation

{$R eldbnav.res}

var FGlyphBitmap : TBitmap;

function TElDBEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

procedure TElDBEdit.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

{$ifdef VCL_4_USED}
function TElDBEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

function TElDBEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;
{$endif}

procedure TElDBEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TElDBEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TElDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TElDBEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

procedure TElDBEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElDBEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString{$ifdef VCL_4_USED}, ftWideString{$endif}]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

procedure TElDBEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if Alignment <> FDataLink.Field.Alignment then
    begin
      Text := '';  {forces update}
      Alignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString{$ifdef VCL_4_USED}, ftWideString{$endif}]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if Focused and FDataLink.CanModify then
    begin
      Text := FDataLink.Field.AsString
    end
    else
    begin
      Text := FDataLink.Field.DisplayText;
      if FDataLink.Editing then
        Modified := True;
    end;
  end else
  begin
    Alignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name
    else
      EditText := '';
  end;
end;

procedure TElDBEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

constructor TElDBEdit.Create(AOwner : TComponent);
begin
  inherited;
  inherited ReadOnly := true;
  ControlStyle := ControlStyle - [csSetCaption];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TElDBEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

procedure TElDBEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

procedure TElDBEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TElDBEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TElDBEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TElDBEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TElDBEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TElDBEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (Alignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

function TElDBEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TElDBEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElDBEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElDBEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;


function TElDBMemo.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBMemo.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBMemo.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBMemo.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBMemo.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBMemo.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TElDBMemo.LoadMemo;
begin
  if (not FMemoLoaded) and Assigned(FDataLink.Field) then
  begin
    if FDataLink.Field.IsBlob or {$ifdef VCL_4_USED}(FDataLink.Field.DataType = ftWideString) or {$ENDIF}
       (FDataLink.Field.DataType = ftString)
    then
    begin
      try
        Lines.Text := FDataLink.Field.AsString;
        FMemoLoaded := True;
      except
        { Memo too large }
        on E:EInvalidOperation do
          Lines.Text := Format('(%s)', [E.Message]);
      end;
      EditingChange(Self);
    end
    else
    begin
      if FFocused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
        Text := FDataLink.Field.DisplayText;
      FMemoLoaded := True;
      //???:
      //EditingChange(Self);
    end;
  end;
end;

constructor TElDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TElDBMemo.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBMemo.Change;
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

procedure TElDBMemo.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    inherited ReadOnly := False;
end;

procedure TElDBMemo.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TElDBMemo.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TElDBMemo.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
    begin
      FMemoLoaded := False;
      LoadMemo;
    end
    else
    begin
      Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
      FMemoLoaded := False;
    end;
  end
  else
  begin
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TElDBMemo.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

{$ifdef VCL_4_USED}
function TElDBMemo.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;
{$endif}

function TElDBMemo.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
      FDataLink.Edit;
  end;
end;

procedure TElDBMemo.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key := #0;
  end;
end;

procedure TElDBMemo.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElDBMemo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBMemo.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

procedure TElDBMemo.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{$ifdef VCL_4_USED}
function TElDBMemo.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;
{$endif}

procedure TElDBMemo.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsString := Text;
end;

{$ifdef VCL_4_USED}
function TElDBMemo.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;
{$endif}

procedure TElDBMemo.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElDBMemo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TElDBMemo.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElDBMemo.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

function TElDBCheckBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBCheckBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBCheckBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBCheckBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBCheckBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBCheckBox.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBCheckBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

constructor TElDBCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  State := cbUnchecked;
  FValueCheck := 'True';
  FValueUncheck := 'False';
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TElDBCheckBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;
procedure TElDBCheckBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBCheckBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;
procedure TElDBCheckBox.DataChange(Sender: TObject);
begin
  State := GetFieldState;
end;

{$ifdef VCL_4_USED}
function TElDBCheckBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;
{$endif}

function TElDBCheckBox.GetFieldState: TCheckBoxState;
var
  Text: TElFString;
begin
  if FDatalink.Field <> nil then
    if FDataLink.Field.IsNull then
      Result := cbGrayed
    else
    if FDataLink.Field.DataType = ftBoolean then
      if FDataLink.Field.AsBoolean then
        Result := cbChecked
      else
        Result := cbUnchecked
    else
    begin
      Result := cbGrayed;
      Text := FDataLink.Field.Text;
      if ValueMatch(FValueCheck, Text) then
        Result := cbChecked
      else
      if ValueMatch(FValueUncheck, Text) then
        Result := cbUnchecked;
    end
  else
    Result := cbUnchecked;
end;

procedure TElDBCheckBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      FDataLink.Edit;
    #27:
      FDataLink.Reset;
  end;
end;

procedure TElDBCheckBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBCheckBox.SetValueCheck(const Value: TElFString);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

procedure TElDBCheckBox.SetValueUncheck(const Value: TElFString);
begin
  FValueUncheck := Value;
  DataChange(Self);
end;

procedure TElDBCheckBox.Toggle;
begin
  if FDataLink.Edit then
  begin
    inherited Toggle;
    FDataLink.Modified;
  end;
end;

{$ifdef VCL_4_USED}
function TElDBCheckBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;
{$endif}

procedure TElDBCheckBox.UpdateData(Sender: TObject);
var
  S: TElFString;
{$ifdef ELPACK_UNICODE}
  st : string;
{$endif}
begin
  if State = cbGrayed then
    FDataLink.Field.Clear
  else
  if FDataLink.Field.DataType = ftBoolean then
    FDataLink.Field.AsBoolean := Checked
  else
  begin
    if Checked then
      S := FValueCheck
    else
      S := FValueUncheck;
    {$ifdef ELPACK_UNICODE}
    if (UnicodeMode = umForceUTF8) and
       (ConvertUTF16toUTF8(S, st, strictConversion, false) <> sourceIllegal)
    then
      FDataLink.Field.Text := st
    else
    begin
      {$ifdef VCL_4_USED}
      if (FDataLink.Field.DataType = ftWideString) and (not FDataLink.Field.IsNull) then
        FDataLink.Field.Value := S
      else
      {$ENDIF}
        FDataLink.Field.Text := S;
    end;
    {$else}
        FDataLink.Field.Value := S;
    {$endif}
  end;
end;

{$ifdef VCL_4_USED}
function TElDBCheckBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;
{$endif}

function TElDBCheckBox.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      Result := True;
      Break;
    end;
end;

procedure TElDBCheckBox.Click;
begin
  if FDataLink.CanModify then
  begin
    FDataLink.Edit;
    inherited Click;
    FDataLink.Modified;
  end;
end;

constructor TElDBRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FValues := TElFStringList.Create;
end;

destructor TElDBRadioGroup.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FValues.Free;
  inherited Destroy;
end;

function TElDBRadioGroup.CanModify: Boolean;
begin
  //if not FInSetValue then
    Result := FDataLink.Edit;
end;

procedure TElDBRadioGroup.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TElDBRadioGroup.Click;
begin
  if not FInSetValue then
  begin
    inherited Click;
    if ItemIndex >= 0 then Value := GetButtonValue(ItemIndex);
    if FDataLink.Editing then FDataLink.Modified;
  end;
end;
procedure TElDBRadioGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    if ItemIndex >= 0 then
      TRadioButton(Controls[ItemIndex]).SetFocus else
      TRadioButton(Controls[0]).SetFocus;
    raise;
  end;
  inherited;
end;
procedure TElDBRadioGroup.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    {$ifdef ELPACK_UNICODE}
    {$ifdef VCL_4_USED}
    if (FDataLink.Field.DataType = ftWideString) and (not FDataLink.Field.IsNull) then
      Value := FDataLink.Field.Value
    else
    {$ENDIF}
    {$endif}
      Value := FDataLink.Field.AsString;
  end
  else
    Value := '';
end;

{$ifdef VCL_4_USED}
function TElDBRadioGroup.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and
    DataLink.ExecuteAction(Action);
end;
{$endif}

function TElDBRadioGroup.GetButtonValue(Index: Integer): TElFString;
begin
  if (Index < FValues.Count) and (FValues[Index] <> '') then
    Result := FValues[Index]
  else
  if Index < Items.Count then
    Result := Items[Index]
  else
    Result := '';
end;

function TElDBRadioGroup.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBRadioGroup.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBRadioGroup.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBRadioGroup.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBRadioGroup.KeyPress(var Key: Char);
begin
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
  inherited KeyPress(Key);
end;

procedure TElDBRadioGroup.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBRadioGroup.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBRadioGroup.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBRadioGroup.SetItems(Value: TElFStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TElDBRadioGroup.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TElDBRadioGroup.SetValue(Value: TElFString);
var
  I, Index: Integer;
begin
  if FValue <> Value then
  begin
    FInSetValue := True;
    try
      Index := -1;
      for I := 0 to Items.Count - 1 do
        if Value = GetButtonValue(I) then
        begin
          Index := I;
          Break;
        end;
      ItemIndex := Index;
    finally
      FInSetValue := False;
    end;
    FValue := Value;
    Change;
  end;
end;

procedure TElDBRadioGroup.SetValues(Value: TElFStrings);
begin
  FValues.Assign(Value);
  DataChange(Self);
end;

{$ifdef VCL_4_USED}
function TElDBRadioGroup.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;
{$endif}

procedure TElDBRadioGroup.UpdateData(Sender: TObject);
{$ifdef ELPACK_UNICODE}
var st : string;
{$endif}
begin
  if FDataLink.Field <> nil then
  begin
    {$ifdef ELPACK_UNICODE}
    if (UnicodeMode = umForceUTF8) and
       (ConvertUTF16toUTF8(Value, st, strictConversion, false) <> sourceIllegal)
    then
      FDataLink.Field.Text := st
    else
    begin
      {$ifdef VCL_4_USED}
      if (FDataLink.Field.DataType = ftWideString) {?}and (not FDataLink.Field.IsNull) then
        FDataLink.Field.Value := Value
      else
      {$ENDIF}
        FDataLink.Field.Text := Value;
    end;
    {$else}
    FDataLink.Field.Value := Value;
    {$endif}
  end;
end;

{$ifdef VCL_4_USED}
function TElDBRadioGroup.UseRightToLeftAlignment: Boolean;
begin
  Result := inherited UseRightToLeftAlignment;
end;
{$endif}

procedure TElDBNavButton.SetRole(Value: TElNavButtonRole);
begin
  // if FRole <> Value then
  begin
    FRole := Value;
    if FRole = nbrCustom then
      Images := TElDBNavigator(Parent).Images
    else
    begin
      inherited SetImageIndex(integer(FRole));
      inherited SetImageList(TElDBNavigator(Parent).FIntImageList);
      inherited SetUseImageList(true);
    end;
  end;
end;

procedure TElDBNavButton.AClick(Arrow : boolean);
begin
  if (not Arrow) and (TElDBNavigator(Parent).FDataLink.DataSet <> nil){$IFDEF VCL_5_USED} and (not CustomAction) {$ENDIF} then
  with TElDBNavigator(Parent).FDataLink.DataSet do
  begin
    case Role of
      nbrPrior: Prior;
      nbrNext: Next;
      nbrFirst: First;
      nbrLast: Last;
      nbrInsert: Insert;
      nbrEdit: Edit;
      nbrCancel: Cancel;
      nbrPost: Post;
      nbrRefresh: Refresh;
      nbrSetFilter: Filtered := true;
      nbrRemoveFilter: Filtered := false;
      nbrClear: ClearFields;
      nbrOpen: Active := true;
      nbrClose: Active := false;
      nbrFindFirst: FindFirst;
      nbrFindNext: FindNext;
      nbrFindPrior: FindPrior;
      nbrFindLast: FindLast;
      //FIX ME!!!
      nbrDelete: if (not TElDBNavigator(Parent).ConfirmDelete) or (ElMessageDlg(TElDBNavigator(Parent).DeleteRecordQuestion, mtConfirmation, mbOKCancel, 0) <> idCancel) then Delete;
      nbrSearch: TElDBNavigator(Parent).DoSearch;
    end;
  end;
  inherited;
end;

function TElDBNavButton.GetArrowThemedClassName: WideString;
begin
    if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
      Result := 'TOOLBAR'
    else
      Result := 'BUTTON';
end;

function TElDBNavButton.GetArrowThemePartID: Integer;
begin
   if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
     Result := TP_SPLITBUTTONDROPDOWN
   else
     Result := CP_DROPDOWNBUTTON;
end;

function TElDBNavButton.GetArrowThemeStateID: Integer;
begin
  if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
  begin
    if not Enabled then
      result := TS_DISABLED
    else
    if FState in [ebsArrDown, ebsExclusive] then
      result := TS_PRESSED
    else
    if FMouseInArrow or FMouseInControl then
      result := TS_HOT
    else
      result := TS_NORMAL;
  end
  else
  begin
    if not Enabled then
      result := CBXS_DISABLED
    else
    if FState in [ebsArrDown, ebsExclusive] then
      result := CBXS_PRESSED
    else
    if FMouseInControl or FMouseInArrow then
      result := CBXS_HOT
    else
      result := CBXS_NORMAL;
  end;
end;

function TElDBNavButton.GetThemedClassName: WideString;
begin
   if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
     Result := 'TOOLBAR'
   else
     Result := 'BUTTON';
end;

function TElDBNavButton.GetThemePartID: Integer;
begin
  if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
  case ButtonType of
    ebtSeparator:
      begin
        result := TP_SPLITBUTTON;
      end;
    ebtDivider:
      begin
        if (Parent as TElToolbar).Orientation = eboVert then
          result := TP_SEPARATORVERT
        else
          result := TP_SEPARATOR;
      end;
    else
      begin
        if (not UseArrow) and (PulldownMenu <> nil) then
          result := TP_DROPDOWNBUTTON
        else
        if UseArrow then
          result := TP_SPLITBUTTON
        else
          result := TP_BUTTON;
      end;
  end
  else
    Result := BP_PUSHBUTTON;
end;

function TElDBNavButton.GetThemeStateID: Integer;
begin
  //case Self.FButtonType of
  //  ebtButton:
  if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
  begin
    if not Enabled then
      result := TS_DISABLED
    else
    if FState in [ebsDown, ebsExclusive] then
      result := TS_PRESSED
    else
    if (Down and IsSwitch) then
    begin
      if FMouseInControl or FMouseInArrow then
        result := TS_HOTCHECKED
      else
        result := TS_CHECKED;
    end
    else
    if FMouseInControl or FMouseInArrow then
      result := TS_HOT
    else
      result := TS_NORMAL;
  end
  else
  begin
    if not Enabled then
      result := PBS_DISABLED
    else
    if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
      result := PBS_PRESSED
    else
    if FMouseInControl or FMouseInArrow then
      result := PBS_HOT
    else
      result := PBS_NORMAL;
  end;
end;

procedure TElDBNavButton.SetUseImageList(newValue : Boolean);
begin
  if (UseImageList <> newValue) then
  begin
    if (FRole = nbrCustom) or (ComponentState * [csLoading, csReading] <> []) then
      inherited SetUseImageList(newValue);
  end; { if }
end; { SetUseImageList }

procedure TElDBNavButton.Loaded;
begin
  inherited;
  if FRole <> nbrCustom then
  begin
    inherited SetImageList(TElDBNavigator(Parent).FIntImageList);
    inherited SetUseImageList(true);
    inherited SetImageIndex(integer(FRole));
  end;
end;

procedure TElDBNavButton.SetImageList(newValue : TImageList);
begin
  if (FRole = nbrCustom) or (ComponentState * [csLoading, csReading] <> []) then
    inherited SetImageList(newValue);
end;

constructor TElDBNavButton.Create(AOwner : TComponent);
begin
  inherited;
  FRole := nbrCustom;
end;

procedure TElDBNavButton.SetImageIndex(newValue : Integer);
begin
  if (FRole = nbrCustom) or (ComponentState * [csLoading, csReading] <> []) then
    inherited SetImageIndex(newValue);
end;

// Set Default Hint Strings
procedure TElDBNavButton.CMHintShow(var Message: TMessage);
 var HintInfo : PHintInfo;
  procedure GetHintButtonByRole;
   var {$ifdef ELPACK_UNICODE}
       T        : WideChar;
       WS       : WideString;
       {$endif}
       l        : integer;
       S        : String;
  begin
      if not Assigned(ElDBNavButtonsHint[Role]) then
        exit;

      S := LoadResString(ElDBNavButtonsHint[Role]);

      if Length(S)=0 then
        exit;

      {$ifdef ELPACK_UNICODE}
        S := GetShortHintW(S);
        WS:= S;

        l := Length(S) + 1 + Length(WS) * 2;
        SetLength(HintInfo.HintStr, l + 4);
        Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);
        Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
        T := #0;
        Move(T, HintInfo.HintStr[l + 1], sizeof(T));
        T := #$FFFE;
        Move(T, HintInfo.HintStr[l + 3], sizeof(T));
      {$else}
        l := Length(S);
        SetLength(HintInfo.HintStr, l + 1);
        Move(S[1], HintInfo.HintStr[1], l);
        HintInfo.HintStr[l+1] := #0;
      {$endif}
  end;
begin
  inherited;
  if (Role = nbrCustom)or(Length(Hint)>0) then exit;
  HintInfo := PHintInfo(Message.lParam);
  GetHintButtonByRole;
end;

function TElDBNavigator.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TElDBNavigator.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if not (csLoading in ComponentState) then
    ActiveChanged;
  if Value <> nil then Value.FreeNotification(Self);
end;

constructor TElDBNavigator.Create(AOwner : TComponent);
begin
  inherited;
  FDataLink := TElNavDataLink.Create(Self);
  FConfirmDelete := true;
  FIntImageList := TImageList.Create(Self);
  FIntImageList.Width := 14;
  FIntImageList.Height := 13;
   //FIX ME!!!
  FIntImageList.AddMasked(FGlyphBitmap, FGlyphBitmap.Canvas.Pixels[0, FGlyphBitmap.Height - 1]);
  UseImageList := true;
  ShowCaption := false;
  ShowGlyph := true;
  BtnOffsHorz := 0;
  BtnOffsVert := 0;
  {$ifdef VCL_4_USED}
  BevelOuter := bvNone;
  {$endif}
end;

procedure TElDBNavigator.ActiveChanged;
 var
   I: integer;
   AButton   : TElDBNavButton;
begin
  if ButtonCount=0 then
    exit;
  if (not (Enabled and FDataLink.Active)) or (FDataLink.DataSource = nil) then
    for i := FButtons.Count - 1 DownTo 0 do
      begin
        if (CustomToolButton[i] is TElDBNavButton) then
        begin
          AButton := CustomToolButton[i] as TElDBNavButton;
          if AButton.Role = nbrOpen then
              AButton.Enabled := True
            else
              TControl(FButtons[I]).Enabled := False;
        end;
      end
  else
  begin
    for i := FButtons.Count - 1 DownTo 0 do
      begin
        if (CustomToolButton[i] is TElDBNavButton) then
        begin
          AButton := CustomToolButton[i] as TElDBNavButton;
          case AButton.Role of

              nbrOpen  : AButton.Enabled := False;

              nbrClose : AButton.Enabled := True;

              nbrFindFirst,
              nbrFindPrior,
              nbrFindNext,
              nbrFindLast
                       : AButton.Enabled := True;
          end;
        end;
      end;
    DataChanged;
    EditingChanged;
  end;
end;

procedure TElDBNavigator.DataChanged;
var
  UpEnable,
  DownEnable: Boolean;
  AButton   : TElDBNavButton;
  i         : integer;
begin
  if ButtonCount=0 then
    exit;
  UpEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.BOF;
  DownEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.EOF;
  for i:=ButtonCount-1 DownTo 0 do begin
      if (CustomToolButton[i] is TElDBNavButton) then
      begin
        AButton := CustomToolButton[i] as TElDBNavButton;
        case AButton.Role of
          nbrFirst,
          nbrPrior   :   AButton.Enabled := UpEnable;
          nbrNext,
          nbrLast    :   AButton.Enabled := DownEnable;
          nbrDelete  :   AButton.Enabled :=
                            Enabled and FDataLink.Active and
                            FDataLink.DataSet.CanModify and
                            not (FDataLink.DataSet.BOF and
                            FDataLink.DataSet.EOF);
          // nbrSetBookmark, nbrGotoBookmark, nbrDeleteBookmark,
          nbrSetFilter : AButton.Enabled := (not FDataLink.DataSource.DataSet.Filtered);
          nbrRemoveFilter
                     :   AButton.Enabled := FDataLink.DataSource.DataSet.Filtered;
        end;//of case
      end;//of if (CustomToolButton[i] is TElDBNavButton)
  end;//of for i
end;

procedure TElDBNavigator.EditingChanged;
var
  CanModify: Boolean;
  AButton  : TElDBNavButton;
  i         : integer;
begin
  if ButtonCount=0 then
    exit;
  CanModify := Enabled and FDataLink.Active and (FDataLink.DataSet <> nil) and FDataLink.DataSet.CanModify;

  for i:=ButtonCount-1 DownTo 0 do begin
      if (CustomToolButton[i] is TElDBNavButton) then
      begin
        AButton := CustomToolButton[i] as TElDBNavButton;
        case AButton.Role of
          nbrInsert  :  AButton.Enabled := CanModify;
          nbrEdit    :  AButton.Enabled := CanModify and not FDataLink.Editing;
          nbrPost,
          nbrCancel  :  AButton.Enabled := CanModify and FDataLink.Editing;
          nbrRefresh :  AButton.Enabled := CanModify;
          // nbrSetBookmark, nbrGotoBookmark, nbrDeleteBookmark,
          nbrSearch  :  AButton.Enabled := CanModify and not FDataLink.Editing;
          nbrClear   :  AButton.Enabled := CanModify and FDataLink.Editing;
        end;//of case
      end;//of if (CustomToolButton[i] is TElDBNavButton)
  end;//of for i
end;

function TElDBNavigator.FindButtonByRole(Role : TElNavButtonRole):
    TElDBNavButton;
var i : integer;
begin
  result := nil;
  for i := 0 to FButtons.Count -1 do
  begin
    if TElDBNavButton(FButtons[i]).Role = Role then
    begin
      result := TElDBNavButton(FButtons[i]);
      Break;
    end;
  end;
end;

function TElDBNavigator.AddButton(Role : TElNavButtonRole): TElDBNavButton;
begin
  if Role <> nbrCustom then
    Result := FindButtonByRole(Role)
  else
    Result := nil;

  if Result = nil then
  begin
    Result := TElDBNavButton(inherited AddButton(ebtButton));
    Result.Role := Role;
  end;
  ActiveChanged;
end;

procedure TElDBNavigator.AddButtons(const Roles : array of TElNavButtonRole);
 var i:integer;
begin
    for i:=0 to High(Roles) do
      AddButton(Roles[i]);
    ActiveChanged;
end;

procedure TElDBNavigator.DoSearch;
begin
  if Assigned(FOnSearch) then FOnSearch(Self);
end;

function TElDBNavigator.GetButtonClass: TElToolButtonClass;
begin
  Result := TElDBNavButton;
end;

procedure TElDBNavigator.SetIsToolbar(Value: Boolean);
var i : integer;
begin
  if FIsToolbar <> Value then
  begin
    FIsToolbar := Value;
    if (ComponentState * [csLoading, csReading, csDestroying] = []) then
    for i := 0 to FButtons.Count - 1 do
    begin
      TElToolButton(FButtons[i]).Invalidate;
    end;
  end;
end;

destructor TElDBNavigator.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FIntImageList.Free;
  FIntImageList := nil;
  inherited;
end;

procedure TElDBNavigator.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBNavigator.Loaded;
begin
  inherited;
  ActiveChanged;
end;
procedure TElDBNavigator.CMControlChange(var Msg : TCMControlChange);
begin
  inherited;
  ActiveChanged;
end;

procedure TElDBNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;
constructor TElNavDataLink.Create(ANav: TElDBNavigator);
begin
  inherited Create;
  FNavigator := ANav;
  {$ifdef VCL_4_USED}
  VisualControl := True;
  {$endif}
end;

destructor TElNavDataLink.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

procedure TElNavDataLink.ActiveChanged;
begin
  if FNavigator <> nil then FNavigator.ActiveChanged;
end;

procedure TElNavDataLink.DataSetChanged;
begin
  if FNavigator <> nil then FNavigator.DataChanged;
end;

procedure TElNavDataLink.EditingChanged;
begin
  if FNavigator <> nil then FNavigator.EditingChanged;
end;


{$ifdef ELPACK_UNICODE}
constructor TElWideDBEdit.Create(AOwner : TComponent);
begin
  inherited;
  inherited ReadOnly := true;
  ControlStyle := ControlStyle - [csSetCaption];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TElWideDBEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

procedure TElWideDBEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

procedure TElWideDBEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

procedure TElWideDBEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TElWideDBEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  DoExit;
end;

procedure TElWideDBEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TElWideDBEdit.DataChange(Sender: TObject);
var W : WideString;
begin
  if FDataLink.Field <> nil then
  begin
    if Alignment <> FDataLink.Field.Alignment then
    begin
      Text := '';  {forces update}
      Alignment := FDataLink.Field.Alignment;
    end;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString{$ifdef VCL_4_USED}, ftWideString{$endif}]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    //if Focused and FDataLink.CanModify then
    begin
      if FDataLink.Field.isNull then
        W := ''
      else
      if (UnicodeMode = umForceUTF8) and
         (ConvertUTF8toUTF16(FDataLink.Field.AsString, W, strictConversion, false)<> sourceIllegal)
      then
      else
      begin
        {$ifdef VCL_4_USED}
        if (FDataLink.Field.DataType = ftWideString) then
          W := FDataLink.Field.Value
        else
        {$ENDIF}
          W := FDataLink.Field.AsString;
      end;
      Text := W;
    end;
  end
  else
  begin
    Alignment := taLeftJustify;
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
  end;
end;

function TElWideDBEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TElWideDBEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

function TElWideDBEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElWideDBEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElWideDBEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElWideDBEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElWideDBEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElWideDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) or (Multiline and (Key = VK_RETURN)) or
     (Key = VK_BACK) or
     ((Key = VK_INSERT) and (ssShift in Shift))
  then
    FDataLink.Edit;
  inherited KeyDown(Key, Shift);
end;

procedure TElWideDBEdit.KeyPress(var Key: Char);
begin
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
  inherited KeyPress(Key);
end;

procedure TElWideDBEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElWideDBEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElWideDBEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TElWideDBEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString{$ifdef VCL_4_USED}, ftWideString{$endif}]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

procedure TElWideDBEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

procedure TElWideDBEdit.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElWideDBEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (Alignment <> taLeftJustify) then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TElWideDBEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TElWideDBEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElWideDBEdit.UpdateData(Sender: TObject);
var W : WideString;
    st: string;
begin
  if (UnicodeMode = umForceUTF8) and
     (ConvertUTF16toUTF8(Text, st, strictConversion, false) <> sourceIllegal)
  then
    FDataLink.Field.Value := st
  else
  begin
    {$ifdef VCL_4_USED}
    if (FDataLink.Field.DataType = ftWideString) {?} and (not FDataLink.Field.IsNull) then
    begin
      W := Text;
      FDataLink.Field.Value := W;
    end
    else
    {$ENDIF}
      FDataLink.Field.Text := Text;
  end;
end;

function TElWideDBEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElWideDBEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

constructor TElWideDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  Multiline := true;
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TElWideDBMemo.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElWideDBMemo.Change;
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

procedure TElWideDBMemo.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    inherited ReadOnly := False;
end;

procedure TElWideDBMemo.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TElWideDBMemo.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TElWideDBMemo.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
    begin
      FMemoLoaded := False;
      LoadMemo;
    end
    else
    begin
      Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
      FMemoLoaded := False;
    end;
  end
  else
  begin
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TElWideDBMemo.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

function TElWideDBMemo.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElWideDBMemo.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElWideDBMemo.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElWideDBMemo.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElWideDBMemo.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElWideDBMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or (Key = VK_RETURN) or
       (Key = VK_BACK) or
       ((Key = VK_INSERT) and (ssShift in Shift))
    then
      FDataLink.Edit;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TElWideDBMemo.KeyPress(var Key: Char);
begin
  if FMemoLoaded then
  begin
    if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then
      LoadMemo;
    Key := #0;
  end;
  inherited KeyPress(Key);
end;

procedure TElWideDBMemo.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElWideDBMemo.LoadMemo;
var W : WideString;
begin
  if (not FMemoLoaded) and Assigned(FDataLink.Field) then
  begin
    if FDataLink.Field.IsBlob or
       {$ifdef VCL_4_USED}
       (FDataLink.Field.DataType = ftWideString) or
       {$ENDIF}
       (FDataLink.Field.DataType = ftString)
    then
    begin
      try
        if FDataLink.Field.isNull then
          W :=''
        else
        if (UnicodeMode = umForceUTF8) and
           (ConvertUTF8toUTF16(FDataLink.Field.AsString, W, strictConversion, false) <> sourceIllegal)
        then
        else
        begin
          {$ifdef VCL_4_USED}
          if (FDataLink.Field.DataType = ftWideString) then
            W := FDataLink.Field.Value
          else
          {$ENDIF}
            W := FDataLink.Field.AsString;
        end;
        Text := W;
        FMemoLoaded := True;
      except
        { Memo too large }
        on E:EInvalidOperation do
          Text := Format('(%s)', [E.Message]);
      end;
      EditingChange(Self);
    end
    else
    begin
      if FFocused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
        Text := FDataLink.Field.DisplayText;
      FMemoLoaded := True;
      //???:
      //EditingChange(Self);
    end;
  end;
end;

procedure TElWideDBMemo.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElWideDBMemo.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TElWideDBMemo.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElWideDBMemo.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElWideDBMemo.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

procedure TElWideDBMemo.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TElWideDBMemo.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElWideDBMemo.UpdateData(Sender: TObject);
var st : string;
begin
  if (UnicodeMode = umForceUTF8) and
     (ConvertUTF16toUTF8(Text, st, strictConversion, false) <> sourceIllegal)
  then
    FDataLink.Field.Value := st
  else
  begin
    {$ifdef VCL_4_USED}
    if (FDataLink.Field.DataType = ftWideString) {?} and (not FDataLink.Field.IsNull) then
      FDataLink.Field.Value := Text
    else
    {$ENDIF}
      FDataLink.Field.AsString := Text;
  end;
end;

function TElWideDBMemo.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElWideDBMemo.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBMemo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TElWideDBMemo.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBMemo.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

{$endif}

initialization

  FGlyphBitmap := TBitmap.Create;
  FGlyphBitmap.LoadFromResourceName(HInstance, 'ELDBNAVBUTTONS');

finalization

  FGlyphBitmap.Free;

end.
