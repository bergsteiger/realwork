{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Memo;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.UITypes, System.Types, FMX.Memo.Types, FMX.Graphics, FMX.Controls.Model,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Controls, FMX.Types, FMX.Text, System.Rtti;

const
  MM_MEMO_CARETCHANGED = MM_SCROLLBOX_USER + 1;
  MM_MEMO_READONLY_CHANGED = MM_SCROLLBOX_USER + 2;
  MM_MEMO_CHECKSPELLING_CHANGED = MM_SCROLLBOX_USER + 3;
  MM_MEMO_IMEMODE_CHANGED = MM_SCROLLBOX_USER + 4;
  MM_MEMO_KEYBOARDTYPE_CHANGED = MM_SCROLLBOX_USER + 5;
  MM_MEMO_TEXT_SETTINGS_CHANGED = MM_SCROLLBOX_USER + 6;
  MM_MEMO_AUTOSELECT_CHANGED = MM_SCROLLBOX_USER + 7;
  MM_MEMO_CHARCASE_CHANGED = MM_SCROLLBOX_USER + 8;
  MM_MEMO_HIDESELECTIONONEXIT_CHANGED = MM_SCROLLBOX_USER + 9;
  MM_MEMO_MAXLENGTH_CHANGED = MM_SCROLLBOX_USER + 10;
  MM_MEMO_LINES_CHANGED = MM_SCROLLBOX_USER + 11;
  MM_MEMO_TEXT_CHANGING = MM_SCROLLBOX_USER + 12;
  MM_MEMO_GET_CARET_POSITION = MM_SCROLLBOX_USER + 13;
  MM_MEMO_SET_CARET_POSITION = MM_SCROLLBOX_USER + 14;
  MM_MEMO_SELSTART_CHANGED = MM_SCROLLBOX_USER + 15;
  MM_MEMO_SELLENGTH_CHANGED = MM_SCROLLBOX_USER + 16;
  MM_MEMO_DATADETECTORTYPES_CHANGED = MM_SCROLLBOX_USER + 17;
  MM_MEMO_LINES_INSERT_LINE = MM_SCROLLBOX_USER + 18;
  MM_MEMO_LINES_PUT_LINE = MM_SCROLLBOX_USER + 19;
  MM_MEMO_LINES_DELETE_LINE = MM_SCROLLBOX_USER + 20;
  MM_MEMO_LINES_EXCHANGE_LINES = MM_SCROLLBOX_USER + 21;
  MM_MEMO_LINES_CLEAR = MM_SCROLLBOX_USER + 22;
  MM_MEMO_UPDATE_STATE_CHANGED = MM_SCROLLBOX_USER + 23;
  MM_MEMO_CAN_SET_FOCUS = MM_SCROLLBOX_USER + 31;
  MM_MEMO_USER = MM_SCROLLBOX_USER + 32;

  PM_MEMO_GOTO_LINE_BEGIN = PM_USER_SCROLLBOX + 1;
  PM_MEMO_GOTO_LINE_END = PM_USER_SCROLLBOX + 2;
  PM_MEMO_GOTO_TEXT_BEGIN = PM_USER_SCROLLBOX + 3;
  PM_MEMO_GOTO_TEXT_END = PM_USER_SCROLLBOX + 4;
  PM_MEMO_UNDO_MANAGER_INSERT_TEXT = PM_USER_SCROLLBOX + 5;
  PM_MEMO_UNDO_MANAGER_DELETE_TEXT = PM_USER_SCROLLBOX + 6;
  PM_MEMO_UNDO_MANAGER_UNDO = PM_USER_SCROLLBOX + 7;
  PM_MEMO_SELECT_TEXT = PM_USER_SCROLLBOX + 8;
  PM_MEMO_USER = PM_USER_SCROLLBOX + 9;

type

  { TMemo }

  TDataDetectorType = (PhoneNumber, Link, Address, CalendarEvent);
  TDataDetectorTypes = set of TDataDetectorType;

  /// <summary>Data model for the TMemo control.</summary>
  TCustomMemoModel = class(TCustomScrollBoxModel)
  public type
    ///<summary>Record to notify presenter about changes in test lines.</summary>
    TLineInfo = record
      Index: Integer;
      Text: string;
      ExtraIndex: Integer;
      class function Create(const Index: Integer; const Text: string): TLineInfo; overload; static; inline;
      class function Create(const Index, ExtraIndex: Integer): TLineInfo; overload; static; inline;
    end;
  public const
    DefaultAutoSelect = False;
    DefaultCharCase = TEditCharCase.ecNormal;
    DefaultHideSelectionOnExit = True;
    DefaultKeyboardType = TVirtualKeyboardType.Default;
    DefaultMaxLength = 0;
    DefaultReadOnly = False;
    DefaultSelectionColor = $802A8ADF;
  private
    FAutoSelect: Boolean;
    FCaret: TCaret;
    FChanged: Boolean;
    FCharCase: TEditCharCase;
    FCheckSpelling: Boolean;
    FDataDetectorTypes: TDataDetectorTypes;
    FHideSelectionOnExit: Boolean;
    FImeMode: TImeMode;
    FKeyboardType: TVirtualKeyboardType;
    FLines: TStrings;
    FMaxLength: Integer;
    FReadOnly: Boolean;
    FSelectionFill: TBrush;
    FSelStart: Integer;
    FSelLength: Integer;
    FTextSettingsInfo: TTextSettingsInfo;
    FOnChange: TNotifyEvent;
    FOnChangeTracking: TNotifyEvent;
    FOnValidating: TValidateTextEvent;
    FOnValidate: TValidateTextEvent;
    procedure SetCaret(const Value: TCaret);
    procedure SetCheckSpelling(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetImeMode(const Value: TImeMode);
    procedure SetKeyboardType(const Value: TVirtualKeyboardType);
    procedure SetAutoSelect(const Value: Boolean);
    procedure SetCharCase(const Value: TEditCharCase);
    procedure SetHideSelectionOnExit(const Value: Boolean);
    procedure SetMaxLength(const Value: Integer);
    procedure SetLines(const Value: TStrings);
    procedure SetSelectionFill(const Value: TBrush);
    procedure SetSelLength(const Value: Integer);
    procedure SetSelStart(const Value: Integer);
    procedure SetTextSettingsInfo(const Value: TTextSettingsInfo);
    procedure SetDataDetectorTypes(const Value: TDataDetectorTypes);
    function GetCaretPosition: TCaretPosition; cdecl;
    procedure SetCaretPosition(const Value: TCaretPosition);
    function CanSetFocus: Boolean;
  protected
    ///<summary>Validate inputing text. Calling before OnChangeTracking</summary>
    function DoValidating(const Value: string): string; virtual;
    ///<summary>Validate inputed text. Calling before OnChange</summary>
    function DoValidate(const Value: string): string; virtual;
    ///<summary>Call OnChangeTracking event</summary>
    procedure DoChangeTracking; virtual;
    ///<summary>Call OnChange event</summary>
    procedure DoChange; virtual;
    ///<summary>Method is calling when some parameter of text settings was changed</summary>
    procedure TextSettingsChanged; virtual;
    ///<summary>Returns class type that represent used text settings. Could be overridden  in descendants to modify
    ///default behavior</summary>
    function GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass; virtual;
  public
    constructor Create(const AOwner: TComponent); override;
    destructor Destroy; override;
    ///<summary>Does memo has selected text</summary>
    function HasSelection: Boolean;
    ///<summary>Returns current selected text</summary>
    function SelectedText: string;
    ///<summary>If there were made any changes in text OnChange will be raised</summary>
    procedure Change;
    ///<summary>Convert absolute platform-dependent position in text to platform independent value in format
    ///(line_number, position_in_line)</summary>
    function TextPosToPos(const APos: Integer): TCaretPosition;
    ///<summary>Convert platform-independent position to absolute platform-dependent position</summary>
    function PosToTextPos(const APostion: TCaretPosition): Integer;
    ///<summary>Insert text in memo after defined position</summary>
    procedure InsertAfter(const APosition: TCaretPosition; const AFragment: string; const Options: TInsertOptions);
    ///<summary>Delete fragment of the text from the memo after defined position</summary>
    procedure DeleteFrom(const APosition: TCaretPosition; const ALength: Integer; const Options: TDeleteOptions);
    ///<summary>Select <c>ALength</c> characters in memo's text starting from <c>AStartPosition</c></summary>
    procedure SelectText(const AStartPosition: TCaretPosition; const ALength: Integer);
  public
    ///<summary>Select all text when control getting focus</summary>
    property AutoSelect: Boolean read FAutoSelect write SetAutoSelect;
    ///<summary>Contains component that represent current caret for control</summary>
    property Caret: TCaret read FCaret write SetCaret;
    ///<summary>Defines character case for text in component</summary>
    property CharCase: TEditCharCase read FCharCase write SetCharCase;
    ///<summary>Switch on/off spell checking feature</summary>
    property CheckSpelling: Boolean read FCheckSpelling write SetCheckSpelling;
    ///<summary>Defines the types of information that can be detected in text
    ///(for native presentation on iOS only)</summary>
    property DataDetectorTypes: TDataDetectorTypes read FDataDetectorTypes write SetDataDetectorTypes;
    ///<summary>Do not draw selected text region when component not in focus</summary>
    property HideSelectionOnExit: Boolean read FHideSelectionOnExit write SetHideSelectionOnExit default True;
    ///<summary>Text is in read-only mode</summary>
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    ///<summary>Default IME text input mode</summary>
    property ImeMode: TImeMode read FImeMode write SetImeMode;
    ///<summary>Defines visual type of on-screen-keyboard</summary>
    property KeyboardType: TVirtualKeyboardType read FKeyboardType write SetKeyboardType;
    ///<summary>Lines of text</summary>
    property Lines: TStrings read FLines write SetLines;
    ///<summary>Available maximum length of text (0 - no length limitation).</summary>
    property MaxLength: Integer read FMaxLength write SetMaxLength;
    ///<summary>Brush that is using to draw text selection region</summary>
    property SelectionFill: TBrush read FSelectionFill write SetSelectionFill;
    ///<summary>Current position of cursor in the text</summary>
    property CaretPosition: TCaretPosition read GetCaretPosition write SetCaretPosition;
    ///<summary>Text selection starting position</summary>
    property SelStart: Integer read FSelStart write SetSelStart;
    ///<summary>Length of selected text</summary>
    property SelLength: Integer read FSelLength write SetSelLength;
    ///<summary>Container for current text visualization attributes</summary>
    property TextSettingsInfo: TTextSettingsInfo read FTextSettingsInfo write SetTextSettingsInfo;
    ///<summary>Event that raises when control losing focus or user pressing ENTER key (but onlt if some changes were
    ///made)</summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    ///<summary>Event that raises on any change in text</summary>
    property OnChangeTracking: TNotifyEvent read FOnChangeTracking write FOnChangeTracking;
    ///<summary>Event that raises to validate any change in text (raises before OnChangeTracking event)</summary>
    property OnValidating: TValidateTextEvent read FOnValidating write FOnValidating;
    ///<summary>Event that raises to validate changes in text (raises before OnChange event)</summary>
    property OnValidate: TValidateTextEvent read FOnValidate write FOnValidate;
  end;

  /// <summary>TCustomMemo is the base class from which all FireMonkey multiline
  /// text editing controls, providing text scrolling, are derived.</summary>
  TCustomMemo = class(TCustomPresentedScrollBox, ITextSettings, ITextActions, IVirtualKeyboardControl, ICaret,
    IReadOnly)
  private
    FSaveReadOnly: Boolean;
    procedure ReadTextData(Reader: TReader);
    procedure ReadHideSelectionData(Reader: TReader);
    function GetModel: TCustomMemoModel; overload;
    function GetLines: TStrings;
    procedure SetLines(const Value: TStrings);
    function GetCheckSpelling: Boolean;
    procedure SetCheckSpelling(const Value: Boolean);
    function GetAutoSelect: Boolean;
    procedure SetAutoSelect(const Value: Boolean);
    function GetCaret: TCaret;
    procedure SetCaret(const Value: TCaret);
    function GetCharCase: TEditCharCase;
    procedure SetCharCase(const Value: TEditCharCase);
    function GetHideSelectionOnExit: Boolean;
    procedure SetHideSelectionOnExit(const Value: Boolean);
    function GetMaxLength: Integer;
    procedure SetMaxLength(const Value: Integer);
    function GetImeMode: TImeMode;
    procedure SetImeMode(const Value: TImeMode);
    function GetSelLength: Integer;
    procedure SetSelLength(const Value: Integer);
    function GetSelStart: Integer;
    procedure SetSelStart(const Value: Integer);
    function GetDataDetectorTypes: TDataDetectorTypes;
    procedure SetDataDetectorTypes(const Value: TDataDetectorTypes);
    function GetText: string;
    procedure SetText(const Value: string);
    function GetOnChange: TNotifyEvent;
    procedure SetOnChange(const Value: TNotifyEvent);
    function GetOnChangeTracking: TNotifyEvent;
    procedure SetOnChangeTracking(const Value: TNotifyEvent);
    function GetOnValidate: TValidateTextEvent;
    procedure SetOnValidate(const Value: TValidateTextEvent);
    function GetOnValidating: TValidateTextEvent;
    procedure SetOnValidating(const Value: TValidateTextEvent);
    { ITextSettings }
    function GetDefaultTextSettings: TTextSettings;
    function GetResultingTextSettings: TTextSettings;
    function GetTextSettings: TTextSettings;
    procedure SetTextSettings(const Value: TTextSettings);
    function GetStyledSettings: TStyledSettings;
    procedure SetStyledSettings(const Value: TStyledSettings);
    function StyledSettingsStored: Boolean;
    { IVirtualKeyboardControl }
    function GetKeyboardType: TVirtualKeyboardType;
    procedure SetKeyboardType(Value: TVirtualKeyboardType);
    procedure SetReturnKeyType(Value: TReturnKeyType);
    function GetReturnKeyType: TReturnKeyType;
    function IsPassword: Boolean;
    { ICaret }
    function GetObject: TCustomCaret;
    procedure ShowCaret;
    procedure HideCaret;
    function GetCaretPosition: TCaretPosition; cdecl;
    procedure SetCaretPosition(const Value: TCaretPosition);
    function GetSelText: string;
    function GetFont: TFont;
    function GetFontColor: TAlphaColor;
    function GetSelectionFill: TBrush;
    function GetTextAlign: TTextAlign;
    function GetWordWrap: Boolean;
    procedure SetFont(const Value: TFont);
    procedure SetFontColor(const Value: TAlphaColor);
    procedure SetTextAlign(const Value: TTextAlign);
    procedure SetWordWrap(const Value: Boolean);
    procedure ObserverToggle(const AObserver: IObserver; const Value: Boolean);
    { IReadOnly }
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function DefineModelClass: TDataModelClass; override;
    function DefinePresentationName: string; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;

    procedure DoBeginUpdate; override;
    procedure DoEndUpdate; override;

    function GetCanFocus: Boolean; override;

    { Live Binding }
    ///<summary>Retruns True if the control could be handled by live binding</summary>
    function CanObserve(const ID: Integer): Boolean; override;
    ///<summary>Registering observer handler after binding link was creaded</summary>
    procedure ObserverAdded(const ID: Integer; const Observer: IObserver); override;
  public
    constructor Create(AOwner: TComponent); override;
    ///<summary>Delete selected text</summary>
    procedure ClearSelection; deprecated 'Use DeleteSelection method instead';
    { ITextActions }
    ///<summary>Removes the selected text from the memo control</summary>
    procedure DeleteSelection;
    ///<summary>Copies the selected text to the clipboard</summary>
    procedure CopyToClipboard;
    ///<summary>Cuts the selected text to the clipboard</summary>
    procedure CutToClipboard;
    ///<summary>Pastes the text from the clipboard to the current caret position</summary>
    procedure PasteFromClipboard;
    ///<summary>Select all text</summary>
    procedure SelectAll;
    ///<summary>Selects the word containing the insertion point</summary>
    procedure SelectWord;
    ///<summary>Cancel the selection if it exists</summary>
    procedure ResetSelection;
    ///<summary>Moves the cursor to the end of the text in the memo</summary>
    procedure GoToTextEnd;
    ///<summary>Moves the cursor to the beginning of the text in the memo</summary>
    procedure GoToTextBegin;
    ///<summary>Replaces the <c>ALength</c> number of characters, beginning from the <c>AStartPos</c> position,
    ///with the the <c>AStr</c> string</summary>
    procedure Replace(const AStartPos: Integer; const ALength: Integer; const AStr: string);
    ///<summary>Moves the cursor to the end of the current line</summary>
    ///<remarks>When <c>WordWrap</c> is True the text line could be separated into several visual lines.
    ///Exactly those lines are considering to find end of the visible line at the insertion point.</remarks>
    procedure GoToLineEnd;
    ///<summary>Moves the cursor to the beginning of the current line</summary>
    ///<remarks>When <c>WordWrap</c> is True the text line could be separated into several visual lines.
    ///Exactly those lines are considering to find begin of the visible line at the insertion point.</remarks>
    procedure GoToLineBegin;
    ///<summary>Undoing the latest text change made in the memo</summary>
    procedure UnDo;

    ///<summary>Converts an absolute platform-specific position in text to a platform-independent position in the
    ///(line_number, position_in_line) format</summary>
    function TextPosToPos(const APos: Integer): TCaretPosition;
    ///<summary>Converts a platform-independent position in text to an absolute platform-specific position</summary>
    function PosToTextPos(const APostion: TCaretPosition): Integer;
    ///<summary>Inserts the <c>AFragment</c> string in the memo's text, after <c>APosition</c></summary>
    procedure InsertAfter(const APosition: TCaretPosition; const AFragment: string; const Options: TInsertOptions);
    ///<summary>Deletes the <c>ALength</c> number of characters, after the <c>APosition</c> position, from the memo's
    ///text</summary>
    procedure DeleteFrom(const APosition: TCaretPosition; const ALength: Integer; const Options: TDeleteOptions);

    ///<summary>The model handling the internal data of the memo control</summary>
    property Model: TCustomMemoModel read GetModel;
    ///<summary>The entire text in the memo</summary>
    property Text: string read GetText write SetText;
  public
    ///<summary>Determines whether all the text in the memo is automatically selected when the control gets
    ///focus</summary>
    property AutoSelect: Boolean read GetAutoSelect write SetAutoSelect;
    ///<summary>Provides access to the caret attached to the memo</summary>
    property Caret: TCaret read GetCaret write SetCaret;
    ///<summary>Defines whether to implement the 'UPPER' or 'lower' case conversion to the memo's text</summary>
    property CharCase: TEditCharCase read GetCharCase write SetCharCase;
    ///<summary>Defines whether the spell checking feature of the memo component is on or off</summary>
    property CheckSpelling: Boolean read GetCheckSpelling write SetCheckSpelling;
    ///<summary>Defines the types of information that can be detected in the memo's text
    ///(for native presentation on iOS only)</summary>
    property DataDetectorTypes: TDataDetectorTypes read GetDataDetectorTypes write SetDataDetectorTypes;
    ///<summary>Determines whether to cancel the visual indication of the selected text when the focus moves to another
    ///control.</summary>
    property HideSelectionOnExit: Boolean read GetHideSelectionOnExit write SetHideSelectionOnExit;
    ///<summary>Default IME text input mode</summary>
    property ImeMode: TImeMode read GetImeMode write SetImeMode;
    ///<summary>Defines the type of the on-screen keyboard to be displayed</summary>
    property KeyboardType: TVirtualKeyboardType read GetKeyboardType write SetKeyboardType;
    ///<summary>Provides access to individual lines of the memo's text</summary>
    property Lines: TStrings read GetLines write SetLines;
    ///<summary>The maximum number of characters that can be entered in the memo (0 - no explicit limitation)</summary>
    property MaxLength: Integer read GetMaxLength write SetMaxLength;
    ///<summary>Specifies whether the user can change the memo's text</summary>
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    ///<summary>The current cursor position in the text</summary>
    property CaretPosition: TCaretPosition read GetCaretPosition write SetCaretPosition;
    ///<summary>The brush that is used to draw a text selection region</summary>
    property SelectionFill: TBrush read GetSelectionFill;
    ///<summary>Text font</summary>
    property Font: TFont read GetFont write SetFont;
    ///<summary>The font color of the text in this memo</summary>
    property FontColor: TAlphaColor read GetFontColor write SetFontColor;
    ///<summary>Horizontal text alignment</summary>
    property TextAlign: TTextAlign read GetTextAlign write SetTextAlign;
    ///<summary>Specifies whether to wrap the text when its length is greater than the memo width</summary>
    property WordWrap: Boolean read GetWordWrap write SetWordWrap;
    ///<summary>The number of the first character selected in the memo's text</summary>
    property SelStart: Integer read GetSelStart write SetSelStart;
    ///<summary>The number of characters selected in the memo's text</summary>
    property SelLength: Integer read GetSelLength write SetSelLength;
    ///<summary>The currently selected fragment in the memo's text</summary>
    property SelText: string read GetSelText;
    ///<summary>The text representation properties that are applied from the current style</summary>
    property StyledSettings: TStyledSettings read GetStyledSettings write SetStyledSettings
      stored StyledSettingsStored nodefault;
    ///<summary>The container for the current text visualization properties</summary>
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;
    ///<summary>Raises when the memo has lost the focus or the user has pressed ENTER (but only if some changes in the
    ///text have been made)</summary>
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;
    ///<summary>Raises when any change has been made in the text</summary>
    property OnChangeTracking: TNotifyEvent read GetOnChangeTracking write SetOnChangeTracking;
    ///<summary>Raises to validate any change has been made in the text
    ///(raises before the OnChangeTracking event)</summary>
    property OnValidating: TValidateTextEvent read GetOnValidating write SetOnValidating;
    ///<summary>Raises to validate changes have been made in the text when the memo has lost the focus or the user
    ///has pressed ENTER (raises before OnChange event)</summary>
    property OnValidate: TValidateTextEvent read GetOnValidate write SetOnValidate;
  end;

  TMemo = class(TCustomMemo)
  published
    property AutoHide;
    property AutoSelect default False;
    property Caret;
    property CharCase default TEditCharCase.ecNormal;
    property CheckSpelling default False;
    property DataDetectorTypes;
    property DisableMouseWheel;
    property HideSelectionOnExit default True;
    property ImeMode default TImeMode.imDontCare;
    property KeyboardType default TVirtualKeyboardType.Default;
    property Lines;
    property MaxLength default 0;
    property ReadOnly default False;
    property ShowScrollBars default True;
    property ShowSizeGrip;
    property StyledSettings;
    property TextSettings;
    property OnChange;
    property OnChangeTracking;
    property OnValidating;
    property OnValidate;
    { inherited }
    property Align;
    property Anchors;
    property Bounces;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren;
    property ClipParent;
    property ControlType;
    property Cursor default crIBeam;
    property DisableFocusEffect;
    property DragMode;
    property Enabled;
    property EnabledScroll;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property ParentShowHint;
    property ShowHint;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnEnter;
    property OnExit;
    property OnKeyUp;
    property OnKeyDown;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnViewportPositionChange;
    property OnPresentationNameChoosing;
  end;

implementation

uses
  System.SysUtils, System.Math, {$IFDEF MACOS}Macapi.CoreFoundation, {$ENDIF}
  FMX.Platform, FMX.Consts, FMX.Memo.Style
  {$IFDEF MSWINDOWS}, FMX.Memo.Win{$ENDIF}{$IFDEF IOS}, FMX.Memo.iOS{$ENDIF};

type

  { TMemoSettingsInfo }

  TMemoSettingsInfo = class(TTextSettingsInfo)
  private
    [Weak] FModel: TCustomMemoModel;
  protected
    procedure DoCalculatedTextSettings; override;
  public
    constructor Create(AOwner: TPersistent; ATextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass); override;
    property Model: TCustomMemoModel read FModel;
  end;

  { TMemoTextSettings }

  TMemoTextSettings = class(TTextSettingsInfo.TCustomTextSettings)
  public
    constructor Create(const AOwner: TPersistent); override;
  published
    property Font;
    property FontColor default TAlphaColorRec.Black;
    property HorzAlign default TTextAlign.Leading;
    property WordWrap default False;
  end;

  { TMemoLines }

  TMemoLines = class(TStringList)
  private
    [Weak] FModel: TCustomMemoModel;
    FTextLength: Integer;
    FTextChanged: Boolean;
    procedure NotifyChanges;
  protected
    function GetTextStr: string; override;
    procedure SetTextStr(const Value: string); override;
    procedure Put(Index: Integer; const S: string); override;
    procedure InsertItem(Index: Integer; const S: string; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(Model: TCustomMemoModel);
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
  end;


function RemoveUnprintableCharacters(const S: string): string;
var
  Parts: TArray<string>;
begin
  Parts := S.Split([#0]);
  if Length(Parts) > 0 then
    Result := string.Empty.Join(string.Empty, Parts)
  else
    Result := string.Empty;
end;

  { TCustomMemoModel }

function TCustomMemoModel.CanSetFocus: Boolean;
begin
  Result := True;
  SendMessageWithResult<Boolean>(MM_MEMO_CAN_SET_FOCUS, Result);
end;

procedure TCustomMemoModel.Change;
begin
  if FChanged then
  try
    FChanged := False;
    DoChange;
  finally
  end;
end;

constructor TCustomMemoModel.Create(const AOwner: TComponent);
begin
  inherited;
  FTextSettingsInfo := TMemoSettingsInfo.Create(Self, GetTextSettingsClass);
  FAutoSelect := DefaultAutoSelect;
  FCaret := TCaret.Create(Owner as TFmxObject);
  FCaret.ReadOnly := ReadOnly;
  FCaret.Visible := True;
  FCharCase := DefaultCharCase;
  FChanged := False;
  FDataDetectorTypes := [];
  FHideSelectionOnExit := DefaultHideSelectionOnExit;
  FKeyboardType := DefaultKeyboardType;
  FLines := TMemoLines.Create(Self);
  FMaxLength := DefaultMaxLength;
  FReadOnly := DefaultReadOnly;
  FSelectionFill := TBrush.Create(TBrushKind.Solid, DefaultSelectionColor);
  AutoCalculateContentSize := False;
end;

procedure TCustomMemoModel.DeleteFrom(const APosition: TCaretPosition; const ALength: Integer;
  const Options: TDeleteOptions);
var
  LText: string;
  TmpPos, TmpLength, TmpLine, RemainLength: Integer;
  TmpS: string;
begin
  if (Lines.Count > 0) and (ALength > 0) then
  begin
    if not InRange(APosition.Line, 0, Lines.Count - 1) then
      raise EArgumentOutOfRangeException.Create(SCaretLineIncorrect);
    if not InRange(APosition.Pos, 0, Lines[APosition.Line].Length) then
      raise EArgumentOutOfRangeException.Create(SCaretPosIncorrect);

    LText := Lines.Text;

    RemainLength := ALength;
    TmpLength := ALength;
    TmpPos := PosToTextPos(APosition);

    TmpS := LText.Substring(TmpPos, TmpLength);

    if not TmpS.IsEmpty then
    begin
      if (TDeleteOption.CanUndo in Options) and (TmpLength > 0) then
        SendMessage<TFragmentDeleted>(PM_MEMO_UNDO_MANAGER_DELETE_TEXT, TFragmentDeleted.Create(TmpPos, TmpS,
          TDeleteOption.Selected in Options, TDeleteOption.MoveCaret in Options));

      Lines.BeginUpdate;
      try
        TmpPos := APosition.Pos;
        TmpLine := APosition.Line;
        while RemainLength > 0 do
        begin
          if Lines[TmpLine].IsEmpty then
          begin
            Lines.Delete(TmpLine);
            Dec(RemainLength, Lines.LineBreak.Length);
          end
          else
          begin
            TmpLength := Min(Lines[TmpLine].Length - TmpPos, RemainLength);
            Dec(RemainLength, TmpLength);
            if (TmpLength = 0) and (TmpPos = Lines[TmpLine].Length) and (TmpLine < (Lines.Count - 1)) then
            begin
              TmpS := Lines[TmpLine + 1];
              Lines.Delete(TmpLine + 1);
              Lines[TmpLine] := Lines[TmpLine] + TmpS;
              Dec(RemainLength, Lines.LineBreak.Length);
            end
            else
            begin
              TmpS := Lines[TmpLine].Remove(TmpPos, TmpLength);
              if TmpS.IsEmpty and (RemainLength > 0) then
              begin
                Lines.Delete(TmpLine);
                Dec(RemainLength, Lines.LineBreak.Length);
              end
              else if (TmpLine < (Lines.Count - 1)) and (RemainLength > 0) then
              begin
                Lines[TmpLine] := TmpS + Lines[TmpLine + 1];
                Lines.Delete(TmpLine + 1);
                Dec(RemainLength, Lines.LineBreak.Length);
              end
              else
              begin
                Lines[TmpLine] := TmpS;
                Inc(TmpLine);
              end;
            end;
          end;
        end;
      finally
        Lines.EndUpdate;
      end;

      if (TDeleteOption.MoveCaret in Options) or (SelLength <> 0) then
        CaretPosition := APosition;
    end;
  end;
end;

destructor TCustomMemoModel.Destroy;
begin
  FTextSettingsInfo.Free;
  FCaret.Free;
  FLines.Free;
  FSelectionFill.Free;
  inherited;
end;

procedure TCustomMemoModel.DoChange;
begin
  if (Owner <> nil) and Assigned(FOnChange) and not (csLoading in Owner.ComponentState) then
    FOnChange(Owner);
end;

procedure TCustomMemoModel.DoChangeTracking;
begin
  if (Owner <> nil) and not (csLoading in Owner.ComponentState) then
  begin
    FChanged := True;
    SendMessage(MM_MEMO_TEXT_CHANGING);
    if Assigned(FOnChangeTracking) then
      FOnChangeTracking(Owner);
  end;
end;

function TCustomMemoModel.DoValidate(const Value: string): string;
begin
  Result := Value;
  if Assigned(FOnValidate) and not(csLoading in Owner.ComponentState) then
    FOnValidate(Owner, Result);
end;

function TCustomMemoModel.DoValidating(const Value: string): string;
begin
  case FCharCase of
    TEditCharCase.ecUpperCase:
      Result := Value.ToUpper;
    TEditCharCase.ecLowerCase:
      Result := Value.ToLower;
    else
      Result := Value;
  end;
  if (Owner <> nil) and not (csLoading in Owner.ComponentState) and Assigned(FOnValidating) then
    FOnValidating(Owner, Result);
end;

function TCustomMemoModel.GetCaretPosition: TCaretPosition;
begin
  Result := TextPosToPos(SelStart);
  SendMessageWithResult<TCaretPosition>(MM_MEMO_GET_CARET_POSITION, Result);
end;

function TCustomMemoModel.GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass;
begin
  Result := TMemoTextSettings;
end;

function TCustomMemoModel.HasSelection: Boolean;
begin
  Result := SelLength > 0;
end;

procedure TCustomMemoModel.InsertAfter(const APosition: TCaretPosition; const AFragment: string;
  const Options: TInsertOptions);
var
  LText: string;
  Insertion: string;
  TmpS: string;
  CurrentPos: Integer;
  LPosition: TCaretPosition;
begin
  if not ((Lines.Count = 0) and (APosition.Line = 0) and (APosition.Pos = 0)) then
  begin
    if APosition.Line < 0 then
      raise EArgumentOutOfRangeException.Create(SCaretLineIncorrect);
    if APosition.Pos < 0 then
      raise EArgumentOutOfRangeException.Create(SCaretPosIncorrect);
  end;

  if APosition.Line >= Lines.Count then
    LPosition := TCaretPosition.Create(Lines.Count, 0)
  else
    LPosition := TCaretPosition.Create(APosition.Line, Min(APosition.Pos, Lines[APosition.Line].Length));

  CurrentPos := PosToTextPos(CaretPosition);
  LText := Lines.Text;
  case CharCase of
    TEditCharCase.ecNormal:
      Insertion := AFragment;
    TEditCharCase.ecUpperCase:
      Insertion := AFragment.ToUpperInvariant;
    TEditCharCase.ecLowerCase:
      Insertion := AFragment.ToLowerInvariant;
  end;

  if MaxLength > 0 then
    Insertion := Insertion.Substring(0, MaxLength - LText.Length);

  if Insertion.IsEmpty then
    Exit;

  if TInsertOption.CanUndo in Options then
    SendMessage<TFragmentInserted>(PM_MEMO_UNDO_MANAGER_INSERT_TEXT, TFragmentInserted.Create(PosToTextPos(LPosition),
      IfThen(Insertion = Lines.LineBreak, Lines.LineBreak.Length, Insertion.Length), TInsertOption.UndoPairedWithPrev
      in Options, TInsertOption.Typed in Options));

  Lines.BeginUpdate;
  try
    if LPosition.Line >= Lines.Count then
    begin
      if Insertion = Lines.LineBreak then
      begin
        if Lines.Count = 0 then
          //Adding extra line if we've pressed ENTER in an empty memo
          Lines.Add(string.Empty);
        Lines.Add(string.Empty);
      end
      else
        Lines.Add(Insertion);
    end
    else
    begin
      if Insertion = Lines.LineBreak then
      begin
        TmpS := Lines[LPosition.Line].Substring(LPosition.Pos, Lines[LPosition.Line].Length);
        Lines[LPosition.Line] := Lines[LPosition.Line].Substring(0, LPosition.Pos);
        Lines.Insert(LPosition.Line + 1, TmpS);
      end
      else
        Lines[LPosition.Line] := Lines[LPosition.Line].Insert(IfThen(Lines[LPosition.Line].Length > 0, LPosition.Pos,
          -1), Insertion);
    end;
  finally
    Lines.EndUpdate;
  end;

  if TInsertOption.Selected in Options then
  begin
    SelStart := PosToTextPos(LPosition);
    SelLength := Insertion.Length;
    if TInsertOption.MoveCaret in Options then
      CaretPosition := TextPosToPos(SelStart + SelLength);
  end
  else if not(csLoading in Owner.ComponentState) and (TInsertOption.MoveCaret in Options) then
  begin
    if Insertion = Lines.LineBreak then
      CaretPosition := TextPosToPos(CurrentPos + Lines.LineBreak.Length)
    else
      CaretPosition := TextPosToPos(CurrentPos + Insertion.Length);
  end;
end;

function TCustomMemoModel.PosToTextPos(const APostion: TCaretPosition): Integer;
var
  I: Integer;
begin
  Result := 0;
  if Lines.Count > 0 then
  begin
    for I := 0 to Min(APostion.Line, Lines.Count) - 1 do
      Inc(Result, Lines[I].Length + Lines.LineBreak.Length);
    Inc(Result, APostion.Pos);
  end;
end;

procedure TCustomMemoModel.TextSettingsChanged;
begin
  if TextSettingsInfo.ResultingTextSettings.WordWrap then
    ScrollDirections := TScrollDirections.Vertical
  else
    ScrollDirections := TScrollDirections.Both;
  SendMessage(MM_MEMO_TEXT_SETTINGS_CHANGED);
end;

function TCustomMemoModel.SelectedText: string;
var
  LSelStart, LSelLength, Line, LLength: Integer;
  SelText: TStringBuilder;
  SelBeg: TCaretPosition;
begin
  if SelLength > 0 then
  begin
    SelText := TStringBuilder.Create;
    try
      SelBeg := TextPosToPos(SelStart);
      LSelStart := SelBeg.Pos;
      Line := SelBeg.Line;
      LSelLength := SelLength;
      while LSelLength > 0 do
      begin
        LLength := Min(LSelLength, Lines[Line].Length - LSelStart);
        SelText.Append(Lines[Line].Substring(LSelStart, LSelLength));
        Dec(LSelLength, LLength);
        Inc(Line);
        if LSelLength > 0 then
        begin
          SelText.AppendLine;
          LSelStart := 0;
          Dec(LSelLength, Lines.LineBreak.Length);
        end;
      end;
      Result := SelText.ToString;
    finally
      SelText.Free;
    end;
  end
  else
    Result := string.Empty;
end;

procedure TCustomMemoModel.SelectText(const AStartPosition: TCaretPosition; const ALength: Integer);
begin
  DisableNotify;
  try
    SelStart := PosToTextPos(AStartPosition);
    SelLength := ALength;
  finally
    EnableNotify;
  end;
  SendMessage(PM_MEMO_SELECT_TEXT);
end;

procedure TCustomMemoModel.SetAutoSelect(const Value: Boolean);
begin
  if FAutoSelect <> Value then
  begin
    FAutoSelect := Value;
    SendMessage(MM_MEMO_AUTOSELECT_CHANGED);
  end;
end;

procedure TCustomMemoModel.SetCaret(const Value: TCaret);
begin
  FCaret.Assign(Value);
  SendMessage(MM_MEMO_CARETCHANGED);
end;

procedure TCustomMemoModel.SetCaretPosition(const Value: TCaretPosition);
begin
  SendMessage<TCaretPosition>(MM_MEMO_SET_CARET_POSITION, Value);
end;

procedure TCustomMemoModel.SetCharCase(const Value: TEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    case FCharCase of
      TEditCharCase.ecUpperCase:
        Lines.Text := Lines.Text.ToUpper;
      TEditCharCase.ecLowerCase:
        Lines.Text := Lines.Text.ToLower;
    end;
    SendMessage(MM_MEMO_CHARCASE_CHANGED);
  end;
end;

procedure TCustomMemoModel.SetCheckSpelling(const Value: Boolean);
begin
  if FCheckSpelling <> Value then
  begin
    FCheckSpelling := Value;
    SendMessage(MM_MEMO_CHECKSPELLING_CHANGED, Value);
  end;
end;

procedure TCustomMemoModel.SetDataDetectorTypes(const Value: TDataDetectorTypes);
begin
  if DataDetectorTypes <> Value then
  begin
    FDataDetectorTypes := Value;
    SendMessage(MM_MEMO_DATADETECTORTYPES_CHANGED, DataDetectorTypes);
  end;
end;

procedure TCustomMemoModel.SetHideSelectionOnExit(const Value: Boolean);
begin
  if FHideSelectionOnExit <> Value then
  begin
    FHideSelectionOnExit := Value;
    SendMessage(MM_MEMO_HIDESELECTIONONEXIT_CHANGED);
  end;
end;

procedure TCustomMemoModel.SetImeMode(const Value: TImeMode);
begin
  if FImeMode <> Value then
  begin
    FImeMode := Value;
    SendMessage(MM_MEMO_IMEMODE_CHANGED, Value);
  end;
end;

procedure TCustomMemoModel.SetKeyboardType(const Value: TVirtualKeyboardType);
begin
  if FKeyboardType <> Value then
  begin
    FKeyboardType := Value;
    SendMessage(MM_MEMO_KEYBOARDTYPE_CHANGED, Value);
  end;
end;

procedure TCustomMemoModel.SetLines(const Value: TStrings);
begin
  FLines.Assign(Value);
  SendMessage(MM_MEMO_LINES_CHANGED);
end;

procedure TCustomMemoModel.SetMaxLength(const Value: Integer);
var
  TruncatedText: string;
begin
  if FMaxLength <> Value then
  begin
    FMaxLength := Max(0, Value);
    TruncatedText := TruncateText(Lines.Text, FMaxLength);
    if TruncatedText <> Lines.Text then
      Lines.Text := TruncatedText;
    SendMessage(MM_MEMO_MAXLENGTH_CHANGED);
  end;
end;

procedure TCustomMemoModel.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    FCaret.ReadOnly := Value;
    SendMessage(MM_MEMO_READONLY_CHANGED, Value);
  end;
end;

procedure TCustomMemoModel.SetSelectionFill(const Value: TBrush);
begin
  FSelectionFill.Assign(Value);
end;

procedure TCustomMemoModel.SetSelLength(const Value: Integer);
begin
  if FSelLength <> Value then
  begin
    FSelLength := EnsureRange(Value, 0, Lines.Text.Length);
    SendMessage(MM_MEMO_SELLENGTH_CHANGED, Value);
  end;
end;

procedure TCustomMemoModel.SetSelStart(const Value: Integer);
begin
  FSelStart := EnsureRange(Value, 0, Lines.Text.Length);
  SendMessage(MM_MEMO_SELSTART_CHANGED, Value);
end;

procedure TCustomMemoModel.SetTextSettingsInfo(const Value: TTextSettingsInfo);
begin
  FTextSettingsInfo.Assign(Value);
end;

function TCustomMemoModel.TextPosToPos(const APos: Integer): TCaretPosition;
var
  LPos: Integer;
begin
  Result := TCaretPosition.Zero;

  if Lines.Count > 0 then
  begin
    LPos := APos;
    while (LPos > 0) and (Result.Line < Lines.Count) do
    begin
      if LPos > Lines[Result.Line].Length then
      begin
        Dec(LPos, Lines[Result.Line].Length + Lines.LineBreak.Length);
        Result.IncrementLine;
      end
      else
      begin
        if LPos >= 0 then
          Result.Pos := LPos
        else
          Result.Pos := Lines[Result.Line].Length;
        LPos := 0;
      end;
    end;
    if Result.Line >= Lines.Count then
    begin
      Result.Line := Lines.Count - 1;
      Result.Pos := Lines[Lines.Count - 1].Length;
    end;
  end;
end;

{ TCustomMemo }

function TCustomMemo.CanObserve(const ID: Integer): Boolean;
begin
  Result := (ID = TObserverMapping.EditLinkID) or (ID = TObserverMapping.ControlValueID);
end;

procedure TCustomMemo.ClearSelection;
begin
  DeleteSelection;
end;

procedure TCustomMemo.CopyToClipboard;
var
  ClipService: IFMXClipboardService;
begin
  if Model.HasSelection and TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, ClipService) then
    ClipService.SetClipboard(Model.SelectedText);
end;

constructor TCustomMemo.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
  CanFocus := True;
  Cursor := crIBeam;
  Touch.InteractiveGestures := Touch.InteractiveGestures + [TInteractiveGesture.DoubleTap, TInteractiveGesture.LongTap];
  ClipChildren := False;
end;

procedure TCustomMemo.CutToClipboard;
begin
  CopyToClipboard;
  DeleteSelection;
end;

function TCustomMemo.DefineModelClass: TDataModelClass;
begin
  Result := TCustomMemoModel;
end;

function TCustomMemo.DefinePresentationName: string;
begin
  Result := 'Memo-' + GetPresentationSuffix;
end;

procedure TCustomMemo.DefineProperties(Filer: TFiler);
var
  LTextPropLoader: TTextSettingsInfo.TTextPropLoader;
begin
  inherited;
  Filer.DefineProperty('Text', ReadTextData, nil, False);
  Filer.DefineProperty('HideSelection', ReadHideSelectionData, nil, False);
  // Only for backward compatibility with old versions
  LTextPropLoader := TTextSettingsInfo.TTextPropLoader.Create(Self, Filer);
  try
    LTextPropLoader.ReadProperties;
  finally
    LTextPropLoader.Free;
  end;
end;

procedure TCustomMemo.DeleteFrom(const APosition: TCaretPosition; const ALength: Integer;
  const Options: TDeleteOptions);
begin
  Model.DeleteFrom(APosition, ALength, Options);
end;

procedure TCustomMemo.DeleteSelection;
begin
  if not Model.ReadOnly then
  begin
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      if not TLinkObservers.EditLinkEdit(Observers) then
      begin
        TLinkObservers.EditLinkReset(Observers);
        Exit;
      end
      else
        TLinkObservers.EditLinkModified(Observers);

    if Observers.IsObserving(TObserverMapping.ControlValueID) then
      TLinkObservers.ControlValueModified(Observers);

    BeginUpdate;
    try
      Model.DeleteFrom(Model.TextPosToPos(Model.SelStart), Model.SelLength, [TDeleteOption.MoveCaret, TDeleteOption.CanUndo, TDeleteOption.Selected]);
    finally
      EndUpdate;
    end;
    Model.SelLength := 0;
  end;
end;

procedure TCustomMemo.DoBeginUpdate;
begin
  inherited;
  Model.Lines.BeginUpdate;
end;

procedure TCustomMemo.DoEndUpdate;
begin
  inherited;
  Model.Lines.EndUpdate;
end;

function TCustomMemo.GetMaxLength: Integer;
begin
  Result := Model.MaxLength;
end;

function TCustomMemo.GetModel: TCustomMemoModel;
begin
  Result := GetModel<TCustomMemoModel>;
end;

function TCustomMemo.GetObject: TCustomCaret;
begin
  Result := Model.Caret;
end;

function TCustomMemo.GetOnChange: TNotifyEvent;
begin
  Result := Model.OnChange;
end;

function TCustomMemo.GetOnChangeTracking: TNotifyEvent;
begin
  Result := Model.OnChangeTracking;
end;

function TCustomMemo.GetOnValidate: TValidateTextEvent;
begin
  Result := Model.OnValidate;
end;

function TCustomMemo.GetOnValidating: TValidateTextEvent;
begin
  Result := Model.OnValidating;
end;

function TCustomMemo.GetReadOnly: Boolean;
begin
  Result := Model.ReadOnly;
end;

function TCustomMemo.GetResultingTextSettings: TTextSettings;
begin
  Result := Model.TextSettingsInfo.ResultingTextSettings;
end;

function TCustomMemo.GetReturnKeyType: TReturnKeyType;
begin
  Result := TReturnKeyType.Default;
end;

function TCustomMemo.GetSelectionFill: TBrush;
begin
  Result := Model.SelectionFill;
end;

function TCustomMemo.GetSelLength: Integer;
begin
  Result := Model.SelLength;
end;

function TCustomMemo.GetSelStart: Integer;
begin
  Result := Model.SelStart;
end;

function TCustomMemo.GetSelText: string;
begin
  Result := Model.SelectedText;
end;

function TCustomMemo.GetStyledSettings: TStyledSettings;
begin
  Result := Model.TextSettingsInfo.StyledSettings;
end;

function TCustomMemo.GetTextSettings: TTextSettings;
begin
  Result := Model.TextSettingsInfo.TextSettings;
end;

function TCustomMemo.GetWordWrap: Boolean;
begin
  Result := Model.TextSettingsInfo.TextSettings.WordWrap;
end;

procedure TCustomMemo.SetText(const Value: string);
begin
  if Value <> Text then
    Lines.Text := Value;
end;

procedure TCustomMemo.SetTextAlign(const Value: TTextAlign);
begin
  Model.TextSettingsInfo.TextSettings.HorzAlign := Value;
end;

procedure TCustomMemo.GoToLineBegin;
begin
  Model.SendMessage(PM_MEMO_GOTO_LINE_BEGIN);
end;

procedure TCustomMemo.GoToLineEnd;
begin
  Model.SendMessage(PM_MEMO_GOTO_LINE_END);
end;

procedure TCustomMemo.GoToTextBegin;
begin
  Model.SendMessage(PM_MEMO_GOTO_TEXT_BEGIN);
end;

procedure TCustomMemo.GoToTextEnd;
begin
  Model.SendMessage(PM_MEMO_GOTO_TEXT_END);
end;

procedure TCustomMemo.HideCaret;
begin
  Model.Caret.Hide;
end;

procedure TCustomMemo.InsertAfter(const APosition: TCaretPosition; const AFragment: string;
  const Options: TInsertOptions);
begin
  Model.InsertAfter(APosition, AFragment, Options);
end;

function TCustomMemo.IsPassword: Boolean;
begin
  Result := False;
end;

procedure TCustomMemo.ObserverAdded(const ID: Integer; const Observer: IObserver);
begin
  if ID = TObserverMapping.EditLinkID then
    Observer.OnObserverToggle := ObserverToggle;
end;

procedure TCustomMemo.ObserverToggle(const AObserver: IObserver; const Value: Boolean);
var
  LEditLinkObserver: IEditLinkObserver;
  LSaveReadOnly: Boolean;
begin
  if Supports(AObserver, IEditLinkObserver, LEditLinkObserver) then
  begin
    if Value then
    begin
      LSaveReadOnly := Model.ReadOnly;
      if LEditLinkObserver.IsReadOnly then
        Model.ReadOnly := True;
      FSaveReadOnly := LSaveReadOnly;
    end
    else if not (csDestroying in ComponentState) then
      Model.ReadOnly := FSaveReadOnly;
  end;
end;

function TCustomMemo.GetCanFocus: Boolean;
begin
  Result := (inherited GetCanFocus) and Model.CanSetFocus;
end;

procedure TCustomMemo.PasteFromClipboard;

  procedure BulkPaste(APastingText : string; var ACaret : TCaretPosition);
  var
    LCaretPosition : Integer;
    LLengthResidue : Integer;
    LText : string;
    Insertion: string;
  begin
    LText := Model.Lines.Text;
    case Model.CharCase of
      TEditCharCase.ecNormal:
        Insertion := APastingText;
      TEditCharCase.ecUpperCase:
        Insertion := APastingText.ToUpperInvariant;
      TEditCharCase.ecLowerCase:
        Insertion := APastingText.ToLowerInvariant;
    end;

    if Model.MaxLength > 0 then
      Insertion := Insertion.Substring(0, Model.MaxLength - LText.Length);

    Model.SendMessage<TFragmentInserted>(PM_MEMO_UNDO_MANAGER_INSERT_TEXT,
      TFragmentInserted.Create(Model.PosToTextPos(ACaret), IfThen(Insertion = Model.Lines.LineBreak,
      Model.Lines.LineBreak.Length, Insertion.Length), False, False));
    LCaretPosition := Model.PosToTextPos(ACaret);
    LLengthResidue := LText.Length - LCaretPosition;

    Model.Lines.Text := LText.Substring(0, LCaretPosition) + Insertion + LText.Substring(LCaretPosition,
      LLengthResidue);
    ACaret := Model.TextPosToPos(lText.Length + Insertion.Length - LLengthResidue);
  end;

  procedure LightPaste(APastingStringList : TStrings; var ACaret : TCaretPosition);
  var
    I : Integer;
  begin
    for I := 0 to APastingStringList.Count - 1 do
    begin
      Model.InsertAfter(ACaret, APastingStringList[I], [TInsertOption.CanUndo]);
      Inc(ACaret.Pos, APastingStringList[I].Length);
      if I < APastingStringList.Count - 1 then
      begin
        Model.InsertAfter(ACaret, Model.Lines.LineBreak, [TInsertOption.CanUndo]);
        ACaret := TCaretPosition.Create(ACaret.Line + 1, 0);
      end;
    end;
  end;

const
  BulkThreshold = 1000;

var
  ClipService: IFMXClipboardService;
  LCaret: TCaretPosition;
  Strings: TStringList;
  ClipBoardText: string;
begin
  if not Model.ReadOnly and TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, ClipService) then
  begin
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      if not TLinkObservers.EditLinkEdit(Observers) then
      begin
        TLinkObservers.EditLinkReset(Observers);
        Exit;
      end
      else
        TLinkObservers.EditLinkModified(Observers);

    if Observers.IsObserving(TObserverMapping.ControlValueID) then
      TLinkObservers.ControlValueModified(Observers);

    BeginUpdate;
    try
      if Model.SelLength > 0 then
        LCaret := Model.TextPosToPos(Model.SelStart)
      else
        LCaret := CaretPosition;
      DeleteSelection;
      ClipBoardText := ClipService.GetClipboard.ToString;
      Strings := TStringList.Create;
      try
        Strings.Text := ClipBoardText;
        if Strings.Count < BulkThreshold then
        begin
          if ClipBoardText.EndsWith(Model.Lines.LineBreak) then
            Strings.Add(string.Empty);
          LightPaste(Strings, LCaret);
        end
        else
          BulkPaste(ClipBoardText, LCaret);
      finally
        Strings.Free;
      end;
    finally
      EndUpdate;
      CaretPosition := LCaret;
    end;
  end;
end;

function TCustomMemo.PosToTextPos(const APostion: TCaretPosition): Integer;
begin
  Result := Model.PosToTextPos(APostion);
end;

procedure TCustomMemo.ReadHideSelectionData(Reader: TReader);
begin
  HideSelectionOnExit := Reader.ReadBoolean;
end;

procedure TCustomMemo.ReadTextData(Reader: TReader);
begin
  Text := Reader.ReadString;
end;

procedure TCustomMemo.Replace(const AStartPos, ALength: Integer; const AStr: string);
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
    begin
      TLinkObservers.EditLinkReset(Observers);
      Exit;
    end
    else
      TLinkObservers.EditLinkModified(Observers);

  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueModified(Observers);

  Model.DeleteFrom(Model.TextPosToPos(AStartPos), ALength, []);
  Model.InsertAfter(Model.TextPosToPos(AStartPos), AStr, [TInsertOption.MoveCaret]);
end;

procedure TCustomMemo.ResetSelection;
var
  LCaretPosition: Integer;
begin
  LCaretPosition := Model.SelStart + Model.SelLength;
  Model.SelLength := 0;
  Model.CaretPosition := Model.TextPosToPos(LCaretPosition);
end;

{ TCustomMemo }

function TCustomMemo.GetAutoSelect: Boolean;
begin
  Result := Model.AutoSelect;
end;

function TCustomMemo.GetCaret: TCaret;
begin
  Result := Model.Caret;
end;

function TCustomMemo.GetCaretPosition: TCaretPosition;
begin
  Result := Model.CaretPosition;
end;

function TCustomMemo.GetText: string;
begin
  Result := Lines.Text;
end;

function TCustomMemo.GetTextAlign: TTextAlign;
begin
  Result := Model.TextSettingsInfo.TextSettings.HorzAlign;
end;

function TCustomMemo.GetCharCase: TEditCharCase;
begin
  Result := Model.CharCase;
end;

function TCustomMemo.GetCheckSpelling: Boolean;
begin
  Result := Model.CheckSpelling;
end;

function TCustomMemo.GetData: TValue;
begin
  Result := Lines.Text;
end;

function TCustomMemo.GetDataDetectorTypes: TDataDetectorTypes;
begin
  Result := Model.DataDetectorTypes;
end;

function TCustomMemo.GetDefaultTextSettings: TTextSettings;
begin
  Result := Model.TextSettingsInfo.DefaultTextSettings;
end;

function TCustomMemo.GetFont: TFont;
begin
  Result := Model.TextSettingsInfo.TextSettings.Font;
end;

function TCustomMemo.GetFontColor: TAlphaColor;
begin
  Result := Model.TextSettingsInfo.TextSettings.FontColor;
end;

function TCustomMemo.GetHideSelectionOnExit: Boolean;
begin
  Result := Model.HideSelectionOnExit;
end;

function TCustomMemo.GetImeMode: TImeMode;
begin
  Result := Model.ImeMode;
end;

function TCustomMemo.GetKeyboardType: TVirtualKeyboardType;
begin
  Result := Model.KeyboardType;
end;

function TCustomMemo.GetLines: TStrings;
begin
  Result := Model.Lines;
end;

procedure TCustomMemo.SelectAll;
begin
  Model.SelectText(TCaretPosition.Zero, Text.Length);
end;

procedure TCustomMemo.SelectWord;
var
  WordBeginIndex, WordEndIndex: Integer;
begin
  if Model.Lines.Count > 0 then
  begin
    if FindWordBound(Model.Lines[CaretPosition.Line], CaretPosition.Pos, WordBeginIndex, WordEndIndex) then
      Model.SelectText(TCaretPosition.Create(CaretPosition.Line, WordBeginIndex), WordEndIndex - WordBeginIndex + 1)
    else
      Model.SelLength := 0;
  end;
end;

procedure TCustomMemo.SetAutoSelect(const Value: Boolean);
begin
  Model.AutoSelect := Value;
end;

procedure TCustomMemo.SetCaret(const Value: TCaret);
begin
  Model.Caret := Value;
end;

procedure TCustomMemo.SetCaretPosition(const Value: TCaretPosition);
begin
  Model.CaretPosition := Value;
end;

procedure TCustomMemo.SetCharCase(const Value: TEditCharCase);
begin
  Model.CharCase := Value;
end;

procedure TCustomMemo.SetCheckSpelling(const Value: Boolean);
begin
  Model.CheckSpelling := Value;
end;

procedure TCustomMemo.SetData(const Value: TValue);
begin
  if not Value.IsEmpty then
    Lines.Text := Value.ToString
  else
    Lines.Text := string.Empty;
end;

procedure TCustomMemo.SetDataDetectorTypes(const Value: TDataDetectorTypes);
begin
  Model.DataDetectorTypes := Value;
end;

procedure TCustomMemo.SetFont(const Value: TFont);
begin
  Model.TextSettingsInfo.TextSettings.Font.Assign(Value);
end;

procedure TCustomMemo.SetFontColor(const Value: TAlphaColor);
begin
  Model.TextSettingsInfo.TextSettings.FontColor := Value;
end;

procedure TCustomMemo.SetHideSelectionOnExit(const Value: Boolean);
begin
  Model.HideSelectionOnExit := Value;
end;

procedure TCustomMemo.SetImeMode(const Value: TImeMode);
begin
  Model.ImeMode := Value;
end;

procedure TCustomMemo.SetKeyboardType(Value: TVirtualKeyboardType);
begin
  Model.KeyboardType := Value;
end;

procedure TCustomMemo.SetLines(const Value: TStrings);
begin
  Model.Lines.Assign(Value);
end;

procedure TCustomMemo.SetMaxLength(const Value: Integer);
begin
  Model.MaxLength := Value;
end;

procedure TCustomMemo.SetOnChange(const Value: TNotifyEvent);
begin
  Model.OnChange := Value;
end;

procedure TCustomMemo.SetOnChangeTracking(const Value: TNotifyEvent);
begin
  Model.OnChangeTracking := Value;
end;

procedure TCustomMemo.SetOnValidate(const Value: TValidateTextEvent);
begin
  Model.OnValidate := Value;
end;

procedure TCustomMemo.SetOnValidating(const Value: TValidateTextEvent);
begin
  Model.OnValidating := Value;
end;

procedure TCustomMemo.SetReadOnly(const Value: Boolean);
begin
  FSaveReadOnly := Value;
  Model.ReadOnly := Value;
end;

procedure TCustomMemo.SetReturnKeyType(Value: TReturnKeyType);
begin

end;

procedure TCustomMemo.SetSelLength(const Value: Integer);
begin
  Model.SelLength := Value;
end;

procedure TCustomMemo.SetSelStart(const Value: Integer);
begin
  Model.SelLength := 0;
  Model.SelStart := Value;
end;

procedure TCustomMemo.SetStyledSettings(const Value: TStyledSettings);
begin
  Model.TextSettingsInfo.StyledSettings := Value;
end;

procedure TCustomMemo.SetTextSettings(const Value: TTextSettings);
begin
  Model.TextSettingsInfo.TextSettings.Assign(Value);
end;

procedure TCustomMemo.SetWordWrap(const Value: Boolean);
begin
  Model.TextSettingsInfo.TextSettings.WordWrap := Value;
end;

procedure TCustomMemo.ShowCaret;
begin
  if ControlType = FMX.Controls.TControlType.Styled then
    Model.Caret.Show;
end;

function TCustomMemo.StyledSettingsStored: Boolean;
begin
  Result := StyledSettings <> DefaultStyledSettings;
end;

function TCustomMemo.TextPosToPos(const APos: Integer): TCaretPosition;
begin
  Result := Model.TextPosToPos(APos);
end;

procedure TCustomMemo.UnDo;
begin
  Model.SendMessage(PM_MEMO_UNDO_MANAGER_UNDO);
end;

{ TMemoSettingsInfo }

constructor TMemoSettingsInfo.Create(AOwner: TPersistent;
  ATextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass);
begin
  inherited;
  if AOwner is TCustomMemoModel then
    FModel := TCustomMemoModel(AOwner)
  else
    raise EArgumentException.CreateFMT(SEUseHeirs, [TCustomMemoModel.ClassName]);
end;

procedure TMemoSettingsInfo.DoCalculatedTextSettings;
begin
  FModel.TextSettingsChanged;
  inherited;
end;

{ TMemoTextSettings }

constructor TMemoTextSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  VertAlign := TTextAlign.Leading;
  HorzAlign := TTextAlign.Leading;
  FontColor := TAlphaColorRec.Black;
  WordWrap := False;
end;

{ TMemoLines }

procedure TMemoLines.Clear;
begin
  FTextChanged := FTextLength > 0;
  inherited;
  FTextLength := 0;
  FModel.DisableNotify;
  try
    FModel.SelStart := 0;
    FModel.SelLength := 0;
  finally
    FModel.EnableNotify;
  end;
  FModel.SendMessage(MM_MEMO_LINES_CLEAR);
  NotifyChanges;
  if FModel.CanNotify then
    FModel.Change;
end;

constructor TMemoLines.Create(Model: TCustomMemoModel);
begin
  inherited Create;
  FModel := Model;
end;

procedure TMemoLines.Delete(Index: Integer);
begin
  FTextLength := FTextLength - Strings[Index].Length;
  inherited;
  FModel.SendMessage(MM_MEMO_LINES_DELETE_LINE, TCustomMemoModel.TLineInfo.Create(Index, string.Empty));
  FTextChanged := True;
  NotifyChanges;
end;

procedure TMemoLines.Exchange(Index1, Index2: Integer);
begin
  inherited;
  FModel.SendMessage(MM_MEMO_LINES_EXCHANGE_LINES, TCustomMemoModel.TLineInfo.Create(Index1, Index2));
  FTextChanged := True;
  NotifyChanges;
end;

function TMemoLines.GetTextStr: string;
begin
  Result := inherited GetTextStr;
  // Removing unnecessary last line break
  Result := Result.Remove(Result.Length - LineBreak.Length, LineBreak.Length);
end;

procedure TMemoLines.InsertItem(Index: Integer; const S: string; AObject: TObject);
var
  LText: string;
  LAvailableLength: Integer;
begin
  LText := RemoveUnprintableCharacters(S);
  if FModel.CharCase = TEditCharCase.ecLowerCase then
    LText := LText.ToLower
  else if FModel.CharCase = TEditCharCase.ecUpperCase then
    LText := LText.ToUpper;
  if FModel.MaxLength > 0 then
  begin
    LAvailableLength := FModel.MaxLength - FTextLength;
    if LAvailableLength <= 0 then
      Exit;
    if LAvailableLength < LText.Length then
      LText := LText.Substring(0, LAvailableLength);
  end;
  inherited InsertItem(Index, LText, AObject);
  FTextLength := FTextLength + LText.Length;
  FModel.SendMessage(MM_MEMO_LINES_INSERT_LINE, TCustomMemoModel.TLineInfo.Create(Index, LText));
  FTextChanged := True;
  NotifyChanges;
end;

procedure TMemoLines.NotifyChanges;
begin
  if FTextChanged and (UpdateCount = 0) then
  begin
    FTextChanged := False;
    FModel.SendMessage(MM_MEMO_LINES_CHANGED);
    FModel.DoChangeTracking;
  end;
end;

procedure TMemoLines.Put(Index: Integer; const S: string);
var
  LText: string;
  LineLength: Integer;
begin
  LText := RemoveUnprintableCharacters(S);
  if FModel.CharCase = TEditCharCase.ecLowerCase then
    LText := LText.ToLower
  else if FModel.CharCase = TEditCharCase.ecUpperCase then
    LText := LText.ToUpper;
  if LText <> Strings[Index] then
  begin
    LineLength := Strings[Index].Length;
    inherited Put(Index, LText);
    FTextLength := FTextLength - LineLength + LText.Length;
    FModel.SendMessage(MM_MEMO_LINES_PUT_LINE, TCustomMemoModel.TLineInfo.Create(Index, LText));
    FTextChanged := True;
    NotifyChanges;
  end;
end;

procedure TMemoLines.SetTextStr(const Value: string);
var
  LText: string;
begin
  LText := RemoveUnprintableCharacters(Value);
  if LText.EndsWith(LineBreak) and not LText.IsEmpty then
    LText := LText + LineBreak;

  BeginUpdate;
  try
    inherited SetTextStr(LText);
  finally
    EndUpdate;
  end;

  if FModel.CanNotify then
    FModel.Change;
end;

procedure TMemoLines.SetUpdateState(Updating: Boolean);
begin
  inherited;
  FModel.SendMessage(MM_MEMO_UPDATE_STATE_CHANGED, Updating);
  if not Updating then
    NotifyChanges;
end;

{ TCustomMemoModel.TLineInfo }

class function TCustomMemoModel.TLineInfo.Create(const Index: Integer; const Text: string): TLineInfo;
begin
  Result.Index := Index;
  Result.Text := Text;
end;

class function TCustomMemoModel.TLineInfo.Create(const Index, ExtraIndex: Integer): TLineInfo;
begin
  Result.Index := Index;
  Result.ExtraIndex := ExtraIndex;
end;

initialization
 RegisterFmxClasses([TCustomMemo, TMemo]);
end.
