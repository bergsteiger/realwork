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
{*                  OVCDBAE.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbAE;
  {-Data aware array editors}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Buttons, Classes, Controls, DB, DbCtrls, DBTables, Forms, Graphics, Menus,
  Messages, SysUtils,
  OvcBase, OvcColor, OvcCmd, OvcConst, OvcData, OvcDbNf, OvcDbPf, OvcDbSf,
  OvcAe, OvcEf, OvcExcpt, OvcMisc, OvcNf, OvcPf, OvcSf, OvcStr;

const
  {default property values}
  daDefActiveRow       = 0;
  daDefAutoAdvanceChar = False;
  daDefAutoAdvanceLR   = False;
  daDefAutoRowHeight   = True;
  daDefBeepOnError     = True;
  daDefBorderStyle     = bsSingle;
  daDefCaretToEnd      = True;
  daDefColor           = clWindow;
  daDefCtl3D           = True;
  daDefDateOrTime      = ftUseDate;
  daDefDecimalPlaces   = 0;
  daDefHeight          = 150;
  daDefHighlightBack   = clHighlight;
  daDefHighlightText   = clHighlightText;
  daDefIndicatorWidth  = 11;
  daDefInsertPushes    = True;
  daDefLineColor       = clSilver;
  daDefMaxLength       = 10;
  daDefPageScroll      = False;
  daDefParentColor     = False;
  daDefParentCtl3D     = True;
  daDefParentFont      = False;
  daDefReadOnly        = False;
  daDefRightAlign      = False;
  daDefRightJustify    = False;
  {$IFDEF Win32}
  daDefRowHeight       = 17;
  {$ELSE}
  daDefRowHeight       = 20;
  {$ENDIF}
  daDefShowIndicator   = True;
  daDefTabStop         = True;
  daDefTextMargin      = 2;
  daDefTrimBlanks      = True;
  daDefUseScrollBar    = True;
  daDefWidth           = 100;
  daDefZeroAsNull      = False;

type
  {event to get color of the item cell}
  TGetItemColorEvent =
    procedure(Sender : TObject; Field : TField; Row : Integer; var FG, BG : TColor)
    of object;
  {event to notify of a scroll action}
  TIndicatorClickEvent =
    procedure(Sender : TObject; Row : LongInt)
    of object;

type
  {.Z+}
  TOvcDbSimpleCell = class(TOvcDbSimpleField)
  private
  protected
    procedure CreateWnd;
      override;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
  public
    constructor Create(AOwner : TComponent);
      override;
  end;

  TOvcDbPictureCell = class(TOvcDbPictureField)
  private
  protected
    procedure CreateWnd;
      override;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
  public
    constructor Create(AOwner : TComponent);
      override;
  end;

  TOvcDbNumericCell = class(TOvcDbNumericField)
  private
  protected
    procedure CreateWnd;
      override;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
  public
    constructor Create(AOwner : TComponent);
      override;
  end;
  {.Z-}

  {base class for data-aware array editors}
  TOvcBaseDbArrayEditor = class(TOvcBase)
  {.Z+}
  protected {private}
    FActiveRow           : LongInt;      {the row index of the active item}
    FAutoAdvanceChar     : Boolean;      {focus moves to next field after last character entered}
    FAutoAdvanceLR       : Boolean;      {L/R cursor movement at field ends moves focus to next/prev control}
    FAutoRowHeight       : Boolean;      {true to automatically adjust row height based on font}
    FCaretToEnd          : Boolean;      {true to place caret at end of string}
    FBeepOnError         : Boolean;      {MessageBeep is called for error conditions}
    FBorderStyle         : TBorderStyle; {border around the control}
    FDataField           : string;       {database field name}
    FDataSource          : TDataSource;  {data source}
    FDateOrTime          : TDateOrTime;  {determines if editing dates or times}
    FDecimalPlaces       : Byte;         {max decimal places}
    FEpoch               : Integer;      {combined epoch year and cenury}
    FFieldType           : TFieldType;   {field data type}
    FHighlightColors     : TOvcColors;   {highlight colors}
    FIndicatorWidth      : Integer;      {width of row indicators}
    FInsertPushes        : Boolean;      {inserted chars push ending chars off}
    FLineColor           : TColor;       {color of row divider lines}
    FMaxLength           : Word;         {maximum length of string}
    FPadChar             : AnsiChar;     {character used to pad end of string}
    FPageScroll          : Boolean;      {true to scroll like Delphi's grids}
    FPictureMask         : string;       {picture mask}
    FReadOnly            : Boolean;      {prevents field editing}
    FRightAlign          : Boolean;      {enables right alignment}     {!!.10}
    FRightJustify        : Boolean;      {display text right-justified}
    FRowHeight           : Integer;      {pixel height of one row}
    FShowIndicator       : Boolean;      {true to show row indicators}
    FTextMargin          : Integer;      {indent from left (right)}
    FTrimBlanks          : Boolean;      {remove leading and trailing blanks if not listerals}
    FUseScrollBar        : Boolean;      {true to use vertical scroll bar}
    FZeroAsNull          : Boolean;      {true to store zero value as null}

    {cell datalink event hook variables}
    FCellOnActiveChange  : TNotifyEvent;
    FCellOnDataChange    : TNotifyEvent;
    FCellOnEditingChange : TNotifyEvent;
    FCellOnUpdateData    : TNotifyEvent;

    {event variables}
    FOnChange            : TNotifyEvent;
    FOnError             : TValidationErrorEvent;
    FOnGetItemColor      : TGetItemColorEvent;
    FOnIndicatorClick    : TIndicatorClickEvent;
    FOnUserCommand       : TUserCommandEvent;
    FOnUserValidation    : TUserValidationEvent;

    {internal/working variables}
    aeIndicators         : TImageList;    {list of indicators}
    aeNumRows            : Integer;       {visible rows in window}
    aeRangeLo            : TRangeType;    {low field range limit}
    aeRangeHi            : TRangeType;    {high field range limit}
    aeRangeLoaded        : Boolean;       {flag to tell when loaded}
    aePainting           : Boolean;       {True when painting}
    aeFocusing           : Boolean;       {True when changing focus}

    {property methods}
    function GetDataLink : TFieldDataLink;
      {-return the cell datalink}
    function GetField : TField;
      {-return the associated field object}
    function GetRangeHi : string;
      {-get the high field range string value}
    function GetRangeLo : string;
      {-get the low field range string value}
    procedure SetActiveRow(Value : LongInt);
      {-set the active row index}
    procedure SetAutoAdvanceChar(Value : Boolean);
      {-sets the AutoAdvanceChar option}
    procedure SetAutoAdvanceLeftRight(Value : Boolean);
      {-sets the AutoAdvanceLeftRight option}
    procedure SetAutoRowHeight(Value : Boolean);
      {-sets the AutoRowHeight option}
    procedure SetBeepOnError(Value : Boolean);
      {-sets the BeepOnError option}
    procedure SetBorderStyle(Value : TBorderStyle);
      {-set the style used for the border}
    procedure SetCaretToEnd(Value : Boolean);
      {-set the CaretToEnd option}
    procedure SetDataField(Value : string);
      {-set the field name}
    procedure SetDataSource(Value : TDataSource);
      {-set the data source}
    procedure SetDateOrTime(Value : TDateOrTime);
      {-set the date or time property value}
    procedure SetDecimalPlaces(Value : Byte);
      {-set the number of decimal places for the edit field}
    procedure SetEpoch(Value : Integer);
      {-set the epoch value}
    procedure SetFieldType(Value : TFieldType);
      {-set the data type for this field}
    procedure SetIndicatorWidth(Value : Integer);
      {-set the row indicator width}
    procedure SetInsertPushes(Value : Boolean);
      {-set the InsertPushes option}
    procedure SetLineColor(Value : TColor);
      {-set the color used to draw the row divider lines}
    procedure SetMaxLength(Value : Word);
      {-set the maximum length of the edit field}
    procedure SetPadChar(Value : AnsiChar);
      {-set the character used to pad the end of the edit string}
    procedure SetPictureMask(Value : string);
      {-set the picture mask}
    procedure SetRangeHi(Value : string);
      {-set the high field range from a string value}
    procedure SetRangeLo(Value : string);
      {-set the low field range from a string value}
    procedure SetReadOnly(Value : Boolean);
      {-set the read only option}
    procedure SetRightAlign(Value : Boolean);                          {!!.10}
      {-set the right align option}
    procedure SetRightJustify(Value : Boolean);
      {-set the right justify option}
    procedure SetRowHeight(Value : Integer);
      {-set the cell row height}
    procedure SetShowIndicator(Value : Boolean);
      {-set the show indicator option}
    procedure SetTextMargin(Value : Integer);
      {-set the text margin}
    procedure SetTrimBlanks(Value : Boolean);
      {-set the trim blanks option}
    procedure SetUseScrollBar(Value : Boolean);
      {-set use of vertical scroll bar}
    procedure SetZeroAsNull(Value : Boolean);
      {-set option to store zero as null}

    {general (internal) routines}
    procedure aeAdjustIntegralHeight;
      {-resizes the component so no partial items appear}
    procedure aeAdjustRowHeight;
      {-adjust the row height based on the current font}
    procedure aeColorChanged(AColor : TObject);
      {-highlight color change-repaint}
    procedure aeMoveCell(NewIndex : LongInt);
      {-moves the cell to the specified row Index}
    procedure aeReadRangeHi(Stream : TStream);
      {-called to read the high range from the stream}
    procedure aeReadRangeLo(Stream : TStream);
      {-called to read the low range from the stream}
    procedure aeUpdateActive;
      {-update the active record number}
    procedure aeUpdateNumRows;
      {-update the number of rows}
    procedure aeUpdateScrollBar;
      {-sets the vertical scroll bar position}
    procedure aeWriteRangeHi(Stream : TStream);
      {-called to store the high range value}
    procedure aeWriteRangeLo(Stream : TStream);
      {-called to store the low range value}

    {event handlers for attached cell datalink}
    procedure aeActiveChange(Sender : TObject);
      {-notification routine called by an aeCell event}
    procedure aeDataChange(Sender : TObject);
      {-notification routine called by an aeCell event}
    procedure aeEditingChange(Sender : TObject);
      {-notification routine called by an aeCell event}
    procedure aeUpdateData(Sender : TObject);
      {-notification routine called by an aeCell event}

    {VCL control messages}
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Msg : TMessage);
      message CM_FONTCHANGED;

    {windows message methods}
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
      message WM_ERASEBKGND;
    procedure WMGetMinMaxInfo(var Msg : TWMGetMinMaxInfo);
      message WM_GETMINMAXINFO;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMNCHitTest(var Msg : TWMNCHitTest);
      message WM_NCHITTEST;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;
    procedure WMVScroll(var Msg : TWMScroll);
      message WM_VSCROLL;

  protected
    {internal/working variables}
    aeCell      : TOvcBaseEntryField;

    {VCL methods}
    procedure ChangeScale(M, D : Integer);
      override;
    procedure CreateParams(var Params: TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure DefineProperties(Filer : TFiler);
      override;
    procedure Paint;
      override;

    {abstract internal methods}
    procedure aeCreateEditCell;
      virtual; abstract;
      {-create the edit cell}
    procedure aeGetCellProperties;
      virtual; abstract;
      {-freshen our copy of the cell properties}

    {general internal methods}
    function aeGetEditString : PChar;
      {-return the edit cells edit string}
    procedure aeGetSampleDisplayData(P : PChar);
      {-return a sample display string}
    procedure aeRefresh;
      {-called to conditionally call refresh}

    {event wrapper methods}
    procedure DoGetItemColor(AField : TField; ARow : Integer; var FG, BG : TColor);
      virtual;
      {-get the color values for the cell}
    procedure DoOnIndicatorClick(Row : LongInt);
      dynamic;
      {-perform indicator click notification}
  {.Z-}

    property AutoAdvanceChar : Boolean
      read FAutoAdvanceChar
      write SetAutoAdvanceChar
      default daDefAutoAdvanceChar;

    property AutoAdvanceLeftRight : Boolean
      read FAutoAdvanceLR
      write SetAutoAdvanceLeftRight
      default daDefAutoAdvanceLR;

    property AutoRowHeight : Boolean
      read FAutoRowHeight
      write SetAutoRowHeight
      default daDefAutoRowHeight;

    property BeepOnError : Boolean
      read FBeepOnError
      write FBeepOnError
      default daDefBeepOnError;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default daDefBorderStyle;

    property CaretToEnd : Boolean
      read FCaretToEnd
      write SetCaretToEnd
      default daDefCaretToEnd;

    property DataField : string
      read FDataField
      write SetDataField;

    property DataSource : TDataSource
      read FDataSource
      write SetDataSource;

    property DateOrTime : TDateOrTime
      read FDateOrTime
      write SetDateOrTime
      default daDefDateOrTime;

    property DecimalPlaces : Byte
      read FDecimalPlaces
      write SetDecimalPlaces
      default daDefDecimalPlaces;

    property Epoch : Integer
      read FEpoch
      write SetEpoch;

    property FieldType : TFieldType
      read FFieldType
      write SetFieldType;

    property HighlightColors : TOvcColors
      read FHighlightColors
      write FHighlightColors;

    property IndicatorWidth : Integer
      read FIndicatorWidth
      write SetIndicatorWidth
      default daDefIndicatorWidth;

    property InsertPushes : Boolean
      read FInsertPushes
      write SetInsertPushes
      default daDefInsertPushes;

    property LineColor : TColor
      read FLineColor
      write SetLineColor
      default daDefLineColor;

    property MaxLength : Word
      read FMaxLength
      write SetMaxLength
      default daDefMaxLength;

    property PadChar : AnsiChar
      read FPadChar
      write SetPadChar
      default DefPadChar;

    property PageScroll : Boolean
      read FPageScroll
      write FPageScroll
      default daDefPageScroll;

  {.Z+}
    property PictureMask : string
      read FPictureMask
      write SetPictureMask;
  {.Z-}

    property RangeHi : string
      read GetRangeHi
      write SetRangeHi
      stored False;

    property RangeLo : string
      read GetRangeLo
      write SetRangeLo
      stored False;

    property ReadOnly : Boolean
      read FReadOnly
      write SetReadOnly
      default daDefReadOnly;

    property RightAlign : Boolean                                      {!!.10}
      read FRightAlign
      write SetRightAlign
      default daDefRightAlign;

    property RightJustify : Boolean
      read FRightJustify
      write SetRightJustify
      default daDefRightJustify;

    property RowHeight : Integer
      read FRowHeight
      write SetRowHeight
      default daDefRowHeight;

    property ShowIndicator : Boolean
      read FShowIndicator
      write SetShowIndicator
      default daDefShowIndicator;

    property TextMargin : Integer
      read FTextMargin
      write SetTextMargin
      default daDefTextMargin;

    property TrimBlanks : Boolean
      read FTrimBlanks
      write SetTrimBlanks
      default daDefTrimBlanks;

    property UseScrollBar : Boolean
      read FUseScrollBar
      write SetUseScrollBar
      default daDefUseScrollBar;

    property ZeroAsNull : Boolean
      read FZeroAsNull
      write SetZeroAsNull
      default daDefZeroAsNull;

    {events echoed to the edit field object}
    property OnChange : TNotifyEvent
      read FOnChange
      write FOnChange;

    property OnError : TValidationErrorEvent
      read FOnError
      write FOnError;

    property OnGetItemColor : TGetItemColorEvent
      read FOnGetItemColor
      write FOnGetItemColor;

    property OnIndicatorClick : TIndicatorClickEvent
      read FOnIndicatorClick
      write FOnIndicatorClick;

    property OnUserCommand : TUserCommandEvent
      read FOnUserCommand
      write FOnUserCommand;

    property OnUserValidation : TUserValidationEvent
      read FOnUserValidation
      write FOnUserValidation;

  public
  {.Z+}
    constructor Create(AOwner : TComponent);
      override;
    destructor  Destroy;
      override;
    procedure SetFocus;                                         {!!.14}{!!.D4}
      override;
  {.Z-}

    procedure Reset;
      {-discard current changes (if any) and obtain new data from TField}
    procedure Scroll(Delta : Integer);
      {-scroll the datasource by Distance (signed)}
    procedure UpdateRecord;
      {-force cell to update its underlying TField}

    property Canvas;

  {.Z+}
    property ActiveRow : LongInt
      read FActiveRow
      write SetActiveRow
      stored False;

    property DataLink : TFieldDataLink
      read GetDataLink;
  {.Z-}

    property Field : TField
      read GetField;

  published
  end;

  TOvcDbSimpleArrayEditor = class(TOvcBaseDbArrayEditor)
  {.Z+}
  protected {private}
    {virtual methods}
    procedure aeCreateEditCell;
      override;
      {-create the edit cell}
    procedure aeGetCellProperties;
      override;
      {-freshen our copies of the cell properties}
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;

  published
    property FieldType;
    property DataSource;
    property DataField;

    property Align;                                                    {!!.13}
    property AutoAdvanceChar;
    property AutoAdvanceLeftRight;
    property AutoRowHeight;
    property BeepOnError;
    property BorderStyle;
    property CaretToEnd;
    property Color;
    property Controller;
    property Ctl3D;
    property DecimalPlaces;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Height;
    property HighlightColors;
    property IndicatorWidth;
    property InsertPushes;
    property LineColor;
    property MaxLength;
    property PadChar;
    property PageScroll;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont default daDefParentFont;
    property ParentShowHint;
    property PictureMask;
    property PopupMenu;
    property RangeHi stored False;
    property RangeLo stored False;
    property ReadOnly;
    property RightAlign;                                               {!!.10}
    property RowHeight;
    property ShowHint;
    property ShowIndicator;
    property TabOrder;
    property TabStop default daDefTabStop;                             {!!.11}
    property Tag;
    property TextMargin;
    property TrimBlanks;
    property UseScrollBar;
    property Visible;
    property Width;
    property ZeroAsNull;

    {events}
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnError;
    property OnExit;
    property OnGetItemColor;
    property OnIndicatorClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
    property OnUserCommand;
    property OnUserValidation;
  end;

  TOvcDbPictureArrayEditor = class(TOvcBaseDbArrayEditor)
  {.Z+}
  protected {private}
    {virtual methods}
    procedure aeCreateEditCell;
      override;
      {-create the edit cell}
    procedure aeGetCellProperties;
      override;
      {-freshen our copies of the cell properties}
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;

  published
    property FieldType;
    property DataSource;
    property DataField;
    property DateOrTime;

    property Align;                                                    {!!.13}
    property AutoAdvanceChar;
    property AutoAdvanceLeftRight;
    property AutoRowHeight;
    property BeepOnError;
    property BorderStyle;
    property CaretToEnd;
    property Color;
    property Controller;
    property Ctl3D;
    property DecimalPlaces;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Epoch;
    property Font;
    property Height;
    property HighlightColors;
    property InsertPushes;
    property IndicatorWidth;
    property LineColor;
    property MaxLength;
    property PadChar;
    property PageScroll;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont default daDefParentFont;
    property ParentShowHint;
    property PictureMask;
    property PopupMenu;
    property RangeHi stored False;
    property RangeLo stored False;
    property ReadOnly;
    property RightAlign;                                               {!!.10}
    property RightJustify;
    property RowHeight;
    property ShowHint;
    property ShowIndicator;
    property TabOrder;
    property TabStop default daDefTabStop;                             {!!.11}
    property Tag;
    property TextMargin;
    property TrimBlanks;
    property UseScrollBar;
    property Visible;
    property Width;
    property ZeroAsNull;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnError;
    property OnExit;
    property OnGetItemColor;
    property OnIndicatorClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
    property OnUserCommand;
    property OnUserValidation;
  end;

  TOvcDbNumericArrayEditor = class(TOvcBaseDbArrayEditor)
  {.Z+}
  protected {private}
    {virtual methods}
    procedure aeCreateEditCell;
      override;
      {-create the edit cell}
    procedure aeGetCellProperties;
      override;
      {-freshen our copies of the cell properties}
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;

  published
    property FieldType;
    property DataSource;
    property DataField;

    property Align;                                                    {!!.13}
    property AutoAdvanceChar;
    property AutoAdvanceLeftRight;
    property AutoRowHeight;
    property BeepOnError;
    property BorderStyle;
    property CaretToEnd;
    property Color;
    property Controller;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Height;
    property HighlightColors;
    property IndicatorWidth;
    property LineColor;
    property PadChar;
    property PageScroll;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont default daDefParentFont;
    property ParentShowHint;
    property PictureMask;
    property PopupMenu;
    property RangeHi stored False;
    property RangeLo stored False;
    property ReadOnly;
    property RowHeight;
    property ShowHint;
    property ShowIndicator;
    property TabOrder;
    property TabStop default daDefTabStop;                             {!!.11}
    property Tag;
    property TextMargin;
    property UseScrollBar;
    property Visible;
    property Width;
    property ZeroAsNull;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnError;
    property OnExit;
    property OnGetItemColor;
    property OnIndicatorClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
    property OnUserCommand;
    property OnUserValidation;
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

type
  TLocalEF = class(TOvcBaseEntryField);



{*** TOvcBaseDbArrayEditor ***}

procedure TOvcBaseDbArrayEditor.aeActiveChange(Sender : TObject);
begin
  if Assigned(FCellOnActiveChange) then
    FCellOnActiveChange(Sender);
end;

procedure TOvcBaseDbArrayEditor.aeAdjustIntegralHeight;
begin
  if not HandleAllocated then
    Exit;

  if csLoading in ComponentState then
    Exit;

  if ClientHeight <> aeNumRows*FRowHeight then
    ClientHeight := aeNumRows*FRowHeight;
end;

procedure TOvcBaseDbArrayEditor.aeAdjustRowHeight;
  {-adjust the row height based on the current font}
var
  DC         : hDC;
  SaveFont   : hFont;
  H          : Integer;
  SysMetrics : TTextMetric;
  Metrics    : TTextMetric;
begin
  if not FAutoRowHeight then
    Exit;

  if csLoading in ComponentState then
    Exit;

  DC := GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;

  if NewStyleControls then
    H := GetSystemMetrics(SM_CYBORDER) * 4
  else begin
    H := SysMetrics.tmHeight;
    if H > Metrics.tmHeight then
      H := Metrics.tmHeight;
    H := H div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;

  FRowHeight := Metrics.tmHeight + H;
end;

procedure TOvcBaseDbArrayEditor.aeColorChanged(AColor : TObject);
begin
  aeRefresh;
end;

procedure TOvcBaseDbArrayEditor.aeDataChange(Sender : TObject);
  {-notification routine called by an aeCell event}
begin
  if aePainting then
    Exit;

  if Assigned(FCellOnDataChange) then
    FCellOnDataChange(Sender);

  {if field data type has changed, reset properties}
  if Field <> nil then
    if Field.DataType <> FFieldType then
      aeGetCellProperties;

  {set the number of managed items}
  aeUpdateNumRows;

  {update the active record number}
  aeUpdateActive;

  {move the cell to the specified row Index}
  aeMoveCell(FActiveRow);

  {set the scroll bar range}
  aeUpdateScrollBar;

  Invalidate;
end;

procedure TOvcBaseDbArrayEditor.aeEditingChange(Sender : TObject);
begin
  if Assigned(FCellOnEditingChange) then
    FCellOnEditingChange(Sender);
end;

function TOvcBaseDbArrayEditor.aeGetEditString : PChar;
  {-return the edit cells edit string}
begin
  Result := TLocalEF(aeCell).efEditSt;
end;

procedure TOvcBaseDbArrayEditor.aeGetSampleDisplayData(P : PChar);
  {-return a sample display string}
begin
  TLocalEF(aeCell).efGetSampleDisplayData(P);
end;

procedure TOvcBaseDbArrayEditor.aeMoveCell(NewIndex : LongInt);
  {-moves the cell to the specified row Index}
begin
  if Assigned(aeCell) then
    aeCell.Top := NewIndex*FRowHeight;
end;

procedure TOvcBaseDbArrayEditor.aeReadRangeHi(Stream : TStream);
  {-called to read the high range from the stream}
begin
  Stream.Read(aeRangeHi, SizeOf(TRangeType));
  aeRangeLoaded := True;
end;

procedure TOvcBaseDbArrayEditor.aeReadRangeLo(Stream : TStream);
  {-called to read the low range from the stream}
begin
  Stream.Read(aeRangeLo, SizeOf(TRangeType));
  aeRangeLoaded := True;
end;

procedure TOvcBaseDbArrayEditor.aeRefresh;
  {-called to invalidate and paint}
begin
  Refresh;
  if Assigned(aeCell) then
    aeCell.Refresh;
end;

procedure TOvcBaseDbArrayEditor.aeUpdateActive;
begin
  if csLoading in ComponentState then
    Exit;

  if (DataLink <> nil) and DataLink.Active then
    FActiveRow := DataLink.ActiveRecord;
end;

procedure TOvcBaseDbArrayEditor.aeUpdateData(Sender : TObject);
begin
  if Assigned(FCellOnUpdateData) then
    FCellOnUpdateData(Sender);
end;

procedure TOvcBaseDbArrayEditor.aeUpdateNumRows;
  {-update the number of rows}
begin
  aeNumRows := Height div FRowHeight;
  if aeNumRows < 1 then
    aeNumRows := 1;

  if DataLink <> nil then
    if DataLink.Active and (DataLink.RecordCount > 0) then
      DataLink.BufferCount := aeNumRows;
end;

procedure TOvcBaseDbArrayEditor.aeUpdateScrollBar;
  {-sets the vertical scroll bar position}
var
  V : Integer;
begin
  if not FUseScrollBar then
    Exit;

  if csLoading in ComponentState then
    Exit;

  SetScrollRange(Self.Handle, SB_VERT, 0, 4, False);

  if (DataLink = nil) or not DataLink.Active then
    Exit;

  with DataLink.DataSet do begin
    if BOF then
      V := 0
    else if EOF then
      V := 4
    else
      V := 2;
    if GetScrollPos(Self.Handle, SB_VERT) <> V then
      SetScrollPos(Self.Handle, SB_VERT, V, True);
  end;
end;

procedure TOvcBaseDbArrayEditor.aeWriteRangeHi(Stream : TStream);
  {-called to store the high range on the stream}
begin
  Stream.Write(aeRangeHi, SizeOf(TRangeType));
end;

procedure TOvcBaseDbArrayEditor.aeWriteRangeLo(Stream : TStream);
  {-called to store the low range on the stream}
begin
  Stream.Write(aeRangeLo, SizeOf(TRangeType));
end;

procedure TOvcBaseDbArrayEditor.ChangeScale(M, D : Integer);
begin
  inherited ChangeScale(M, D);

  if M <> D then begin
    {scale row height}
    FRowHeight := MulDiv(FRowHeight, M, D);
    RecreateWnd;
  end;
end;

procedure TOvcBaseDbArrayEditor.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  {$ENDIF}

  inherited;
end;

procedure TOvcBaseDbArrayEditor.CMFontChanged(var Msg : TMessage);
begin
  inherited;

  if (csLoading in ComponentState) then
    Exit;

  if not HandleAllocated then
    Exit;

  {optionally, adjust the row height}
  aeAdjustRowHeight;

  {adjust integral height}
  aeAdjustIntegralHeight;
end;

constructor TOvcBaseDbArrayEditor.Create(AOwner : TComponent);
var
  Bmp : Graphics.TBitmap;
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  if NewStyleControls then
    ControlStyle := ControlStyle + [csClickEvents]
  else
    ControlStyle := ControlStyle + [csClickEvents, csFramed];
  {$ELSE}
    ControlStyle := ControlStyle + [csClickEvents, csFramed];
  {$ENDIF}

  {create indicators object and load bitmaps}
  Bmp := Graphics.TBitmap.Create;
  try
    Bmp.Handle := LoadOvcBaseBitmap(MakeIntResource(bmArrow));
    {$IFDEF Win32}
    aeIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    {$ELSE}
    aeIndicators := TImageList.Create(Bmp.Width, Bmp.Height);
    {$ENDIF}
    aeIndicators.AddMasked(Bmp, clWhite);
    Bmp.Handle := LoadOvcBaseBitmap(MakeIntResource(bmEdit));
    aeIndicators.AddMasked(Bmp, clWhite);
    Bmp.Handle := LoadOvcBaseBitmap(MakeIntResource(bmInsert));
    aeIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;

  {set default values for inherited persistent properties}
  Color             := daDefColor;
  Ctl3D             := daDefCtl3D;
  Height            := daDefHeight;
  ParentColor       := daDefParentColor;
  ParentCtl3D       := daDefParentCtl3D;
  ParentFont        := daDefParentFont;
  TabStop           := daDefTabStop;
  Width             := daDefWidth;

  {set default values for persistent properties}
  FActiveRow        := daDefActiveRow;
  FAutoAdvanceChar  := daDefAutoAdvanceChar;
  FAutoAdvanceLR    := daDefAutoAdvanceLR;
  FAutoRowHeight    := daDefAutoRowHeight;
  FBeepOnError      := daDefBeepOnError;
  FBorderStyle      := daDefBorderStyle;
  FCaretToEnd       := daDefCaretToEnd;
  FFieldType        := ftUnknown;
  FIndicatorWidth   := daDefIndicatorWidth;
  FInsertPushes     := daDefInsertPushes;
  FLineColor        := daDefLineColor;
  FPadChar          := DefPadChar;
  FPageScroll       := daDefPageScroll;
  FReadOnly         := daDefReadOnly;
  FRightAlign       := daDefRightAlign;                                {!!.10}
  FRightJustify     := daDefRightJustify;
  FRowHeight        := daDefRowHeight;
  FShowIndicator    := daDefShowIndicator;
  FTextMargin       := daDefTextMargin;
  FTrimBlanks       := daDefTrimBlanks;
  FUseScrollBar     := daDefUseScrollBar;
  ZeroAsNull        := daDefZeroAsNull;

  {set defaults for working variables}
  aeNumRows         := 0;
  aeRangeLoaded     := False;

  {create and initialize colors object}
  FHighlightColors := TOvcColors.Create(daDefHighlightText, daDefHighlightBack);
  FHighlightColors.OnColorChange := aeColorChanged;
end;

procedure TOvcBaseDbArrayEditor.CreateParams(var Params: TCreateParams);
const
  ScrollBar : array[Boolean] of LongInt = (0, WS_VSCROLL);
begin
  inherited CreateParams(Params);

  with Params do
    Style := LongInt(Style) or                                         {!!.D4}
      ScrollBar[FUseScrollBar] or BorderStyles[FBorderStyle];

  {$IFDEF Win32}
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  {$ENDIF}
end;

procedure TOvcBaseDbArrayEditor.CreateWnd;
begin
  inherited CreateWnd;

  {optionally, adjust the row height}
  aeAdjustRowHeight;

  {set the number of managed items}
  aeUpdateNumRows;

  {adjust integral height}
  aeAdjustIntegralHeight;

  {set the number of managed items}
  aeUpdateNumRows;

  {create the edit cell control}
  aeCreateEditCell;

  if PopupMenu <> nil then                                             {!!.16}
    TLocalEF(aeCell).PopupMenu := PopupMenu;                           {!!.16}

  {set the scroll bar range}
  aeUpdateScrollbar;

  {force current item to be visible}
  aeMoveCell(FActiveRow);
end;

procedure TOvcBaseDbArrayEditor.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('RangeHigh', aeReadRangeHi, aeWriteRangeHi, True);
  Filer.DefineBinaryProperty('RangeLow', aeReadRangeLo, aeWriteRangeLo, True);
end;

destructor TOvcBaseDbArrayEditor.Destroy;
begin
  {dispose of the color object}
  FHighlightColors.Free;
  FHighlightColors := nil;

  {free the edit cell}
  aeCell.Free;
  aeCell := nil;

  aeIndicators.Free;                                                   {!!.11}
  aeIndicators := nil;                                                 {!!.11}

  inherited Destroy;
end;

procedure TOvcBaseDbArrayEditor.DoGetItemColor(AField : TField; ARow : Integer;
          var FG, BG : TColor);
begin
  if Assigned(FOnGetItemColor) then
    FOnGetItemColor(Self, AField, ARow, FG, BG);
end;

procedure TOvcBaseDbArrayEditor.DoOnIndicatorClick(Row : LongInt);
  {-perform indicator click notification}
begin
  if not (csDesigning in ComponentState) and Assigned(FOnIndicatorClick) then
    FOnIndicatorClick(Self, Row);
end;

function TOvcBaseDbArrayEditor.GetDataLink : TFieldDataLink;
  {-return the cell datalink}
begin
  Result := nil;
  if Assigned(aeCell) then begin
    if aeCell is TOvcDbSimpleCell then
      Result := TOvcDbSimpleCell(aeCell).FDataLink
    else if aeCell is TOvcDbPictureCell then
      Result := TOvcDbPictureCell(aeCell).FDataLink
    else if aeCell is TOvcDbNumericCell then
      Result := TOvcDbNumericCell(aeCell).FDataLink;
  end;
end;

function TOvcBaseDbArrayEditor.GetField : TField;
  {-return the associated db field object}
begin
  Result := nil;
  if aeCell <> nil then begin
    if aeCell is TOvcDbSimpleCell then
      Result := TOvcDbSimpleCell(aeCell).Field
    else if aeCell is TOvcDbPictureCell then
      Result := TOvcDbPictureCell(aeCell).Field
    else if aeCell is TOvcDbNumericCell then
      Result := TOvcDbNumericCell(aeCell).Field;
  end;
end;

function TOvcBaseDbArrayEditor.GetRangeHi : string;
  {-get the high field range string value}
begin
  Result := TLocalEF(aeCell).efRangeToStRange(aeRangeHi);
end;

function TOvcBaseDbArrayEditor.GetRangeLo : string;
  {-get the low field range string value}
begin
  Result := TLocalEF(aeCell).efRangeToStRange(aeRangeLo);
end;

procedure TOvcBaseDbArrayEditor.Paint;
var
  CR          : TRect;
  IR, Clip    : TRect;
  I           : LongInt;
  X, Y        : Integer;
  SaveActive  : LongInt;
  Left        : Integer;
  Indicator   : Integer;
  HasFocus    : Boolean;
  Buf         : array[0..MaxEditLen] of Char;
  FGColor     : TColor;
  BGColor     : TColor;
  SaveFGColor : TColor;
begin
  {get the client area}
  CR := ClientRect;

  {get the cliping region}
  if csDesigning in ComponentState then
    Clip := CR
  else
    GetClipBox(Canvas.Handle, Clip);

  {set up the proper font and colors}
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  if not Enabled and (Color <> clGrayText) then
    Canvas.Font.Color := clGrayText;
  SaveFGColor := Font.Color;

  {set right alignment if this is a numeric field or using right-alignment}
  if (aeCell is TOvcDbNumericCell) or RightAlign then                  {!!.10}
    SetTextAlign(Canvas.Handle, TA_RIGHT);

  {starting offset for text}
  X := FTextMargin-1;

  HasFocus := aeCell.Focused and not (csDesigning in ComponentState);
  SaveActive := FActiveRow;
  aePainting := True;
  try
    for I := 0 to Pred(aeNumRows) do begin
      CR.Top := I*FRowHeight;
      CR.Bottom := CR.Top+FRowHeight-1;
      if I = Pred(aeNumRows) then
        CR.Bottom := ClientHeight;
      Y := CR.Top + TLocalEF(aeCell).efTopMargin;

      if Bool(IntersectRect(IR, CR, Clip)) then begin

        {display row indicator if enabled}
        if FShowIndicator then begin
          CR.Left := FIndicatorWidth;
          DrawButtonFace(Canvas, Rect(0, CR.Top, FIndicatorWidth, CR.Bottom+1),
                         1, bsNew, False, False, False);
          Canvas.Brush.Color := Color;

          if (DataLink <> nil) and DataLink.Active and (I = SaveActive) then begin
            Indicator := 0;
            if DataLink.DataSet <> nil then
              case DataLink.DataSet.State of
                dsEdit   : Indicator := 1;
                dsInsert : Indicator := 2;
              end;
            {$IFDEF Win32}
            aeIndicators.BkColor := clBtnFace;
            {$ENDIF}
            aeIndicators.Draw(Canvas, FIndicatorWidth-aeIndicators.Width-3,
              (CR.Top + CR.Bottom - aeIndicators.Height) shr 1, Indicator);
          end;
        end;

        if (I <> FActiveRow) or not HasFocus then begin
          if (DataLink <> nil) and DataLink.Active and (Field <> nil)  {!!.14}
            and (I < DataLink.RecordCount) then begin                  {!!.14}
            {change active db record}
            DataLink.ActiveRecord := I;

            {allow user to change color}
            FGColor := SaveFGColor;
            BGColor := Color;
            DoGetItemColor(Field, I, FGColor, BGColor);

            Canvas.Font.Color := FGColor;
            Canvas.Brush.Color := BGColor;

            {get text to display}
            if FFieldType = ftDateTime then begin
              case FDateOrTime of
                ftUseDate : StrPCopy(Buf, DateToStr(Field.AsDateTime));
                ftUseTime : StrPCopy(Buf, TimeToStr(Field.AsDateTime));
              else
                StrPCopy(Buf, Field.DisplayText);
              end;
            end else
              StrPCopy(Buf, Field.DisplayText);
          end else begin                                               {!!.14}
            if (DataLink <> nil) and (DataLink.DataSource <> nil) and  {!!.15}
               (DataLink.DataSource.DataSet <> nil) and                {!!.16}
               (I < DataLink.RecordCount) then                         {!!.15}
              aeGetSampleDisplayData(Buf)                              {!!.14}
            else                                                       {!!.14}
              Buf[0] := #0;                                            {!!.14}
          end;                                                         {!!.14}

          Canvas.FillRect(CR);                                         {!!.11}

          if (aeCell is TOvcDbNumericCell) or RightAlign then begin    {!!.10}
            TrimAllSpacesPChar(Buf);
            {paint the text right aligned}
            ExtTextOut(Canvas.Handle, CR.Right-FTextMargin-1, Y,       {!!.10}
              {ETO_OPAQUE+}ETO_CLIPPED, @CR, Buf, StrLen(Buf), nil);   {!!.11}
          end else begin
            if Field <> nil then begin
              case Field.Alignment of
                taLeftJustify  : Left := X + CR.Left;
                taRightJustify : Left := ClientWidth - Canvas.TextWidth(StrPas(Buf)) - X;
              else
                Left := (ClientWidth - Canvas.TextWidth(StrPas(Buf))) div 2;
              end;
            end else
              Left := X + CR.Left;
            ExtTextOut(Canvas.Handle, Left, Y,
              {ETO_OPAQUE+}ETO_CLIPPED, @CR, Buf, StrLen(Buf), nil);   {!!.11}
          end;
        end;
      end;
    end;

  finally
    {restore active record}
    if (DataLink <> nil) and DataLink.Active then
      DataLink.ActiveRecord := SaveActive;

    {clear painting flag}
    aePainting := False;
  end;

  {paint the active cell}
  FGColor := SaveFGColor;
  BGColor := Color;
  DoGetItemColor(Field, FActiveRow, FGColor, BGColor);
  aeCell.Font.Color := FGColor;
  aeCell.Color := BGColor;
  aeCell.Repaint;

  {draw cell divider lines}
  if FShowIndicator then
    X := FIndicatorWidth
  else
    X := 0;
  Y := -1;
  Canvas.Pen.Color := FLineColor;
  for I := 0 to Pred(aeNumRows)-1 do begin
    Inc(Y, FRowHeight);
    Canvas.PolyLine([Point(X, Y), Point(ClientWidth, Y)]);
  end;
end;

procedure TOvcBaseDbArrayEditor.Reset;
  {-discard current changes (if any) and obtain new data from TField}
begin
  if (DataLink <> nil) and DataLink.Active then
    DataLink.Reset;
end;

procedure TOvcBaseDbArrayEditor.Scroll(Delta : Integer);
  {-scroll the datasource by Delta (signed)}
begin
  if (DataLink <> nil) and DataLink.Active then
    DataLink.DataSet.MoveBy(Delta);
end;

procedure TOvcBaseDbArrayEditor.SetActiveRow(Value : LongInt);
  {-set the currently selected item}
begin
  if (DataLink = nil) or not DataLink.Active then
    Exit;

  if Value < 0 then
    Value := 0;
  if Value > Pred(aeNumRows) then
    Value := Pred(aeNumRows);

  if Value <> FActiveRow then
    DataLink.DataSet.MoveBy(Value-FActiveRow);
end;

procedure TOvcBaseDbArrayEditor.SetAutoAdvanceChar(Value : Boolean);
  {-set the AutoAdvanceChar option}
begin
  if Value <> FAutoAdvanceChar then begin
    FAutoAdvanceChar := Value;
    if Assigned(aeCell) then begin
      aeCell.AutoAdvanceChar := Value;

      {reset our copy of the edit field property}
      FAutoAdvanceChar := aeCell.AutoAdvanceChar;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetAutoAdvanceLeftRight(Value : Boolean);
  {-set the AutoAdvanceLeftRight option}
begin
  if Value <> FAutoAdvanceLR then begin
    FAutoAdvanceLR := Value;
    if Assigned(aeCell) then begin
      aeCell.AutoAdvanceLeftRight := Value;

      {reset our copy of the edit field property}
      FAutoAdvanceLR := aeCell.AutoAdvanceLeftRight;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetAutoRowHeight(Value : Boolean);
  {-set the AutoRowHeight option}
begin
  if Value <> FAutoRowHeight then begin
    FAutoRowHeight := Value;
    if FAutoRowHeight then
      RecreateWnd;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetBeepOnError(Value : Boolean);
  {-set the BeepOnError option}
begin
  if Value <> FBeepOnError then begin
    FBeepOnError := Value;
    if Assigned(aeCell) then begin
      aeCell.BeepOnError := FBeepOnError;

      {reset our copy of the edit field property}
      FBeepOnError := aeCell.BeepOnError;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetBorderStyle(Value : TBorderStyle);
  {-set the style used for the border}
begin
  if Value <> FBorderStyle then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetCaretToEnd(Value : Boolean);
  {-set the CaretToEnd option}
begin
  if FCaretToEnd <> Value then begin
    FCaretToEnd := Value;
    if Assigned(aeCell) then begin
      aeCell.CaretToEnd := FCaretToEnd;

      {reset our copy of the edit field property}
      FCaretToEnd := aeCell.CaretToEnd;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetDataField(Value : string);
begin
  if Value <> FDataField then begin
    FDataField := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetDataSource(Value : TDataSource);
begin
  FDataSource := Value;
  RecreateWnd;
end;

procedure TOvcBaseDbArrayEditor.SetDateOrTime(Value : TDateOrTime);
begin
  if Value <> FDateOrTime then begin
    FDateOrTime := Value;
    if Assigned(aeCell) then
      TOvcDbPictureCell(aeCell).DateOrTime := FDateOrTime;
    if not (csLoading in ComponentState) then
      aeGetCellProperties;
    Refresh;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetDecimalPlaces(Value : Byte);
  {-set the number of decimal places for the edit field}
begin
  if FDecimalPlaces <> Value then begin
    FDecimalPlaces := Value;
    if Assigned(aeCell) then begin
      aeCell.DecimalPlaces := FDecimalPlaces;

      {reset our copy of the edit field property}
      FDecimalPlaces := aeCell.DecimalPlaces;
    end;
    aeRefresh;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetEpoch(Value : Integer);
begin
  if Value <> FEpoch then begin
    FEpoch := Value;
    if Assigned(aeCell) then begin
      TOvcDbPictureCell(aeCell).Epoch := FEpoch;

      {reset our copy of the edit field property}
      FEpoch := TOvcDbPictureCell(aeCell).Epoch;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetFieldType(Value : TFieldType);
begin
  FFieldType := Value;
  RecreateWnd;
end;

{!!.14} {added}
procedure TOvcBaseDbArrayEditor.SetFocus;
begin
  if Assigned(aeCell) and not aeCell.Focused then
    inherited SetFocus;
end;

procedure TOvcBaseDbArrayEditor.SetIndicatorWidth(Value : Integer);
  {-set the row indicator width}
begin
  if (Value <> FIndicatorWidth) and (Value >= 0) then begin
    FIndicatorWidth := Value;

    {at design-time, automatically toggle the show state}
    if csDesigning in ComponentState then begin
      if FIndicatorWidth = 0 then
        FShowIndicator := False
      else
        FShowIndicator := True;
    end;

    if Assigned(aeCell) and FShowIndicator then
      aeCell.SetBounds(FIndicatorWidth, aeCell.Top,
                       ClientWidth-FIndicatorWidth, FRowHeight-1);
    Refresh;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetInsertPushes(Value : Boolean);
  {-set the InsertPushes option}
begin
  if Value <> FInsertPushes then begin
    FInsertPushes := Value;
    if Assigned(aeCell) then begin
      aeCell.InsertPushes := FInsertPushes;

      {reset our copy of the edit field property}
      FInsertPushes := aeCell.InsertPushes;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetLineColor(Value : TColor);
  {-set the color used to draw the row divider lines}
begin
  if Value <> FLineColor then begin
    FLineColor := Value;
    Refresh;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetMaxLength(Value : Word);
  {-set the maximum length of the edit field}
begin
  if FMaxLength <> Value then begin
    FMaxLength := Value;
    if Assigned(aeCell) then begin
      aeCell.MaxLength := FMaxLength;

      {reset our copy of the edit field property}
      FMaxLength := aeCell.MaxLength;
    end;
    aeRefresh;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetPadChar(Value : AnsiChar);
  {-set the character used to pad the end of the edit string}
begin
  if Value <> FPadChar then begin
    FPadChar := Value;
    if Assigned(aeCell) then begin
      aeCell.PadChar := FPadChar;

      {reset our copy of the edit field property}
      FPadChar := aeCell.PadChar;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetPictureMask(Value : string);
  {-set the picture mask}
begin
  if (Value <> FPictureMask) and (Value > '') then begin
    FPictureMask := Value;
    if Assigned(aeCell) then begin
      if aeCell is TOvcDbSimpleCell then begin
        if Length(FPictureMask) > 0 then
          TOvcDbSimpleCell(aeCell).PictureMask := FPictureMask[1];
        FPictureMask := TOvcDbSimpleCell(aeCell).PictureMask;
      end else if aeCell is TOvcDbPictureCell then begin
        TOvcDbPictureCell(aeCell).PictureMask := FPictureMask;
        FPictureMask := TOvcDbPictureCell(aeCell).PictureMask;
      end else if aeCell is TOvcDbNumericCell then begin
        TOvcDbNumericCell(aeCell).PictureMask := FPictureMask;
        FPictureMask := TOvcDbNumericCell(aeCell).PictureMask;
      end;
    end;
    aeRefresh;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetRangeHi(Value : string);
  {-set the high field range from a string value}
begin
  if Assigned(aeCell) then begin
    aeCell.RangeHi := Value;
    aeRangeHi := TLocalEF(aeCell).efRangeHi;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetRangeLo(Value : string);
  {-set the low field range from a string value}
begin
  if Assigned(aeCell) then begin
    aeCell.RangeLo := Value;
    aeRangeLo := TLocalEF(aeCell).efRangeLo;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetReadOnly(Value : Boolean);
  {-set the read only option}
begin
  if Value <> FReadOnly then begin
    FReadOnly := Value;
    if Assigned(aeCell) then begin
      aeCell.ReadOnly := FReadOnly;

      {reset our copy of the edit field property}
      FReadOnly := aeCell.ReadOnly;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetRightAlign(Value : Boolean);
  {-set the RightAlign option}
begin
  if Value <> FRightAlign then begin
    FRightAlign := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetRightJustify(Value : Boolean);
  {-set the RightJustify option}
begin
  if Value <> FRightJustify then begin
    FRightJustify := Value;
    if Assigned(aeCell) then begin
      aeCell.RightJustify := FRightJustify;

      {reset our copy of the edit field property}
      FRightJustify := aeCell.RightJustify;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetRowHeight(Value : Integer);
  {-set the cell row height}
begin
  if (Value <> FRowHeight) and (Value > 0) then begin
    FRowHeight := Value;
    if not (csLoading in ComponentState) then
      FAutoRowHeight := False;
    RecreateWnd;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetShowIndicator(Value : Boolean);
  {-set the show indicators option}
begin
  if Value <> FShowIndicator then begin
    FShowIndicator := Value;
    if Assigned(aeCell) then begin
      if FShowIndicator then begin
        {at design-time, automatically set width}
        if (csDesigning in ComponentState) and (FIndicatorWidth = 0) then
          FIndicatorWidth := daDefIndicatorWidth;

        aeCell.SetBounds(FIndicatorWidth, aeCell.Top,
                         ClientWidth-FIndicatorWidth, FRowHeight-1);
      end else
        aeCell.SetBounds(0, aeCell.Top, ClientWidth, FRowHeight-1);
    end;
    Refresh;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetTextMargin(Value : Integer);
  {-set the text margin}
begin
  if (Value <> FTextMargin) and (Value >= 2) then begin
    FTextMargin := Value;
    if Assigned(aeCell) then
      aeCell.TextMargin := Value;
    Refresh;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetTrimBlanks(Value : Boolean);
  {-set the TrimBlanks option}
begin
  if Value <> FTrimBlanks then begin
    FTrimBlanks := Value;
    if Assigned(aeCell) then begin
      aeCell.TrimBlanks := FTrimBlanks;

      {reset our copy of the edit field property}
      FTrimBlanks := aeCell.TrimBlanks;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.UpdateRecord;
  {-force cell to update its underlying TField, returns True if valid}
begin
  if (DataLink <> nil) and DataLink.Active then
    DataLink.UpdateRecord;
end;

procedure TOvcBaseDbArrayEditor.SetUseScrollBar(Value : Boolean);
  {-set use of vertical scroll bar}
begin
  if Value <> FUseScrollBar then begin
    FUseScrollBar := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseDbArrayEditor.SetZeroAsNull(Value : Boolean);
  {-set option to store zero as null}
begin
  if Value <> FZeroAsNull then begin
    FZeroAsNull := Value;
    if Assigned(aeCell) then begin
      if aeCell is TOvcDbSimpleCell then
        TOvcDbSimpleCell(aeCell).ZeroAsNull := FZeroAsNull
      else if aeCell is TOvcDbPictureCell then
        TOvcDbPictureCell(aeCell).ZeroAsNull := FZeroAsNull
      else if aeCell is TOvcDbNumericCell then
        TOvcDbNumericCell(aeCell).ZeroAsNull := FZeroAsNull;
    end;
  end;
end;

procedure TOvcBaseDbArrayEditor.WMGetMinMaxInfo(var Msg : TWMGetMinMaxInfo);
begin
  Msg.MinMaxInfo^.ptMinTrackSize.Y := FRowHeight;
  Msg.Result := 0;
end;

procedure TOvcBaseDbArrayEditor.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  Msg.Result := 1;  {don't erase background}
end;

procedure TOvcBaseDbArrayEditor.WMLButtonDown(var Msg : TWMLButtonDown);
var
  P   : TPoint;
  Row : LongInt;
begin
  inherited;

  {determine which row the click was in}
  P.X := Msg.Pos.X;
  P.Y := Msg.Pos.Y;
  Row := P.Y div FRowHeight;

  if (DataLink <> nil) and DataLink.Active and (DataLink.RecordCount > 0) and
     (Row <> DataLink.ActiveRecord) then begin
    aeFocusing := True;
    try
      {scroll the database as necessary}
      DataLink.DataSet.MoveBy(Row - DataLink.ActiveRecord);

      {give array editor the focus to force cell validation}
      SetFocus;

      {allow messages (if any) to get processed}
      Application.ProcessMessages;

      {exit if this focus change triggered an error}
      if Controller.ErrorPending then
        Exit;

      {update the active record number}
      aeUpdateActive;

      {give cell the focus}
      aeCell.SetFocus;
    finally
      aeFocusing := False;
    end;
  end;

  {see if the click was in an indicator region}
  if FShowIndicator and (P.X <= FIndicatorWidth) then
    DoOnIndicatorClick(Row);
end;

procedure TOvcBaseDbArrayEditor.WMMouseActivate(var Msg : TWMMouseActivate);
begin
  if csDesigning in ComponentState then
    Exit;

  inherited;
end;

procedure TOvcBaseDbArrayEditor.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  if csDesigning in ComponentState then
    {don't call inherited so we can bypass vcl's attempt}
    {to trap the mouse hit}
    DefaultHandler(Msg)
  else
    inherited;
end;

procedure TOvcBaseDbArrayEditor.WMSetFocus(var Msg : TWMSetFocus);
begin
  if csDesigning in ComponentState then
    Exit;

  inherited;

  if aeFocusing then
    Exit;

  {if the focus isn't comming from our child edit cell}
  if (Msg.FocusedWnd <> aeCell.Handle) then begin
    {give the edit control the focus}
    aeCell.SetFocus;
  end else
    {give the focus to the previous control}
    PostMessage(TForm(GetParentForm(Self)).Handle, WM_NEXTDLGCTL, 1, 0);
end;

procedure TOvcBaseDbArrayEditor.WMSize(var Msg : TWMSize);
begin
  inherited;

  {adjust size of edit field}
  if Assigned(aeCell) then begin
    if FShowIndicator then begin
      aeCell.Width := ClientWidth - FIndicatorWidth;
      aeCell.Left := FIndicatorWidth;
    end else
      aeCell.Width := ClientWidth;
  end;

  {set the number of managed items}
  aeUpdateNumRows;

  {adjust integral height}
  aeAdjustIntegralHeight;

  {set the number of managed items}
  aeUpdateNumRows;

  {update the active record number}
  aeUpdateActive;

  {set the scroll bar range}
  aeUpdateScrollBar;

  {move the cell to the active row Index}
  aeMoveCell(FActiveRow);
end;

procedure TOvcBaseDbArrayEditor.WMVScroll(var Msg : TWMVScroll);
begin
  if (DataLink <> nil) and DataLink.Active then with DataLink do begin
    case Msg.ScrollCode of
      SB_LINEUP        :
        if FPageScroll then
          DataSet.MoveBy(-FActiveRow-1)
        else
          DataSet.MoveBy(-1);
      SB_LINEDOWN      :
        if FPageScroll then
          DataSet.MoveBy(aeNumRows-FActiveRow)
        else
          DataSet.MoveBy(+1);
      SB_PAGEUP        :
        DataSet.MoveBy(-aeNumRows);
      SB_PAGEDOWN      :
        DataSet.MoveBy(+aeNumRows);
      SB_THUMBPOSITION :
        begin
          case Msg.Pos of
            0: DataSet.First;
            1: DataSet.MoveBy(-aeNumRows);
            2: Exit;
            3: DataSet.MoveBy(aeNumRows);
            4: DataSet.Last;
          end;
        end;
      SB_BOTTOM : DataSet.Last;
      SB_TOP    : DataSet.First;
    end;

    {update the active record number}
    aeUpdateActive;
  end;
  Update;
end;


{*** TOvcDbSimpleArrayEditor ***}

procedure TOvcDbSimpleArrayEditor.aeCreateEditCell;
begin
  aeCell.Free;
  aeCell := TOvcDbSimpleCell.Create(Self);

  {adjust cell size}
  if FShowIndicator then
    aeCell.SetBounds(FIndicatorWidth, 0, ClientWidth-FIndicatorWidth, FRowHeight-1)
  else
    aeCell.SetBounds(0, 0, ClientWidth, FRowHeight-1);

  {save current datalink notification event handlers}
  FCellOnActiveChange              := DataLink.OnActiveChange;
  FCellOnDataChange                := DataLink.OnDataChange;
  FCellOnEditingChange             := DataLink.OnEditingChange;
  FCellOnUpdateData                := DataLink.OnUpdateData;

  {assign new datalink event handlers}
  DataLink.OnActiveChange          := aeActiveChange;
  DataLink.OnDataChange            := aeDataChange;
  DataLink.OnEditingChange         := aeEditingChange;
  DataLink.OnUpdateData            := aeUpdateData;

  {set basic cell properties}
  aeCell.AutoAdvanceChar           := FAutoAdvanceChar;
  aeCell.AutoAdvanceLeftRight      := FAutoAdvanceLR;
  aeCell.BeepOnError               := FBeepOnError;
  aeCell.Enabled                   := Enabled;
  aeCell.HighLightColors.BackColor := FHighlightColors.BackColor;
  aeCell.HighLightColors.TextColor := FHighlightColors.TextColor;
  aeCell.InsertPushes              := FInsertPushes;
  aeCell.PadChar                   := FPadChar;
  aeCell.ReadOnly                  := FReadOnly;
  aeCell.RightAlign                := FRightAlign;                     {!!.10}
  aeCell.TabStop                   := TabStop;
  aeCell.TrimBlanks                := FTrimBlanks;
  aeCell.TextMargin                := FTextMargin;
  aeCell.Parent                    := Self;

  {class specific property initialization}
  if Assigned(FDataSource) then begin
    TOvcDbSimpleCell(aeCell).ZeroAsNull := FZeroAsNull;
    TOvcDbSimpleCell(aeCell).DataSource := FDataSource;
    TOvcDbSimpleCell(aeCell).DataField := FDataField;
    TOvcDbSimpleCell(aeCell).UseTFieldMask := False;
    if (DataLink <> nil) and DataLink.Active then
      FFieldType := TOvcDbSimpleCell(aeCell).FieldType
    else begin
      try
        if FFieldType <> ftUnknown then
          TOvcDbSimpleCell(aeCell).FieldType := FFieldType;
      except
        FFieldType := TOvcDbSimpleCell(aeCell).FieldType;
        raise;
      end;
    end;

    if Length(FPictureMask) > 0 then
      TOvcDbSimpleCell(aeCell).PictureMask := FPictureMask[1];
    TOvcDbSimpleCell(aeCell).MaxLength := FMaxLength;
    TOvcDbSimpleCell(aeCell).DecimalPlaces := FDecimalPlaces;
  end;

  {update range limits}
  if not aeRangeLoaded then begin
    aeRangeHi := TLocalEF(aeCell).efRangeHi;
    aeRangeLo := TLocalEF(aeCell).efRangeLo;
  end else begin
    TLocalEF(aeCell).efRangeHi := aeRangeHi;                           {!!.01}
    TLocalEF(aeCell).efRangeLo := aeRangeLo;                           {!!.01}
    {aeCell.SetRangeHi(aeRangeHi);}                                    {!!.01}
    {aeCell.SetRangeLo(aeRangeLo);}                                    {!!.01}
  end;
end;

procedure TOvcDbSimpleArrayEditor.aeGetCellProperties;
  {-freshen our copy of the cell properties}
begin
  if not Assigned(aeCell) then
    Exit;

  FFieldType     := TOvcDbSimpleCell(aeCell).FieldType;
  FMaxLength     := TOvcDbSimpleCell(aeCell).MaxLength;
  FDecimalPlaces := TOvcDbSimpleCell(aeCell).DecimalPlaces;
  FPictureMask   := TOvcDbSimpleCell(aeCell).PictureMask;
  aeRangeHi      := TLocalEF(aeCell).efRangeHi;
  aeRangeLo      := TLocalEF(aeCell).efRangeLo;
end;

constructor TOvcDbSimpleArrayEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {set default values for persistent properties}
  FDecimalPlaces   := daDefDecimalPlaces;
  FMaxLength       := daDefMaxLength;
  FPictureMask     := aeDefSimpleMask;
end;


{*** TOvcDbPictureArrayEditor ***}

procedure TOvcDbPictureArrayEditor.aeCreateEditCell;
begin
  aeCell.Free;
  aeCell := TOvcDbPictureCell.Create(Self);

  {adjust cell size}
  if FShowIndicator then
    aeCell.SetBounds(FIndicatorWidth, 0, ClientWidth-FIndicatorWidth, FRowHeight-1)
  else
    aeCell.SetBounds(0, 0, ClientWidth, FRowHeight-1);

  {save current datalink notification event handlers}
  FCellOnActiveChange              := DataLink.OnActiveChange;
  FCellOnDataChange                := DataLink.OnDataChange;
  FCellOnEditingChange             := DataLink.OnEditingChange;
  FCellOnUpdateData                := DataLink.OnUpdateData;

  {assign new datalink event handlers}
  DataLink.OnActiveChange          := aeActiveChange;
  DataLink.OnDataChange            := aeDataChange;
  DataLink.OnEditingChange         := aeEditingChange;
  DataLink.OnUpdateData            := aeUpdateData;

  {set basic cell properties}
  aeCell.AutoAdvanceChar           := FAutoAdvanceChar;
  aeCell.AutoAdvanceLeftRight      := FAutoAdvanceLR;
  aeCell.BeepOnError               := FBeepOnError;
  aeCell.Enabled                   := Enabled;
  aeCell.HighLightColors.BackColor := FHighlightColors.BackColor;
  aeCell.HighLightColors.TextColor := FHighlightColors.TextColor;
  aeCell.InsertPushes              := FInsertPushes;
  aeCell.PadChar                   := FPadChar;
  aeCell.ReadOnly                  := FReadOnly;
  aeCell.RightAlign                := FRightAlign;                     {!!.10}
  aeCell.RightJustify              := FRightJustify;
  aeCell.TabStop                   := TabStop;
  aeCell.TextMargin                := FTextMargin;
  aeCell.TrimBlanks                := FTrimBlanks;
  aeCell.Parent                    := Self;

  {class specific property initialization}
  if Assigned(FDataSource) then begin
    TOvcDbPictureCell(aeCell).ZeroAsNull := FZeroAsNull;
    TOvcDbPictureCell(aeCell).DateOrTime := FDateOrTime;
    TOvcDbPictureCell(aeCell).DataSource := FDataSource;
    TOvcDbPictureCell(aeCell).DataField := FDataField;
    TOvcDbPictureCell(aeCell).Epoch := FEpoch;
    TOvcDbPictureCell(aeCell).UseTFieldMask := False;
    if (DataLink <> nil) and DataLink.Active then
      FFieldType := TOvcDbPictureCell(aeCell).FieldType
    else begin
      try
        if FFieldType <> ftUnknown then
          TOvcDbPictureCell(aeCell).FieldType := FFieldType;
      except
        FFieldType := TOvcDbPictureCell(aeCell).FieldType;
        raise;
      end;
    end;

    if Length(FPictureMask) > 0 then
      TOvcDbPictureCell(aeCell).PictureMask := FPictureMask;
    TOvcDbPictureCell(aeCell).MaxLength := FMaxLength;
    TOvcDbPictureCell(aeCell).DecimalPlaces := FDecimalPlaces;
  end;

  {update range limits}
  if not aeRangeLoaded then begin
    aeRangeHi := TLocalEF(aeCell).efRangeHi;
    aeRangeLo := TLocalEF(aeCell).efRangeLo;
  end else begin
    TLocalEF(aeCell).efRangeHi := aeRangeHi;                           {!!.01}
    TLocalEF(aeCell).efRangeLo := aeRangeLo;                           {!!.01}
    {aeCell.SetRangeHi(aeRangeHi);}                                    {!!.01}
    {aeCell.SetRangeLo(aeRangeLo);}                                    {!!.01}
  end;
end;

procedure TOvcDbPictureArrayEditor.aeGetCellProperties;
  {-freshend our copy of the cell properties}
begin
  if not Assigned(aeCell) then
    Exit;

  FFieldType     := TOvcDbPictureCell(aeCell).FieldType;
  FMaxLength     := TOvcDbPictureCell(aeCell).MaxLength;
  FDecimalPlaces := TOvcDbPictureCell(aeCell).DecimalPlaces;
  FPictureMask   := TOvcDbPictureCell(aeCell).PictureMask;
  aeRangeHi      := TLocalEF(aeCell).efRangeHi;
  aeRangeLo      := TLocalEF(aeCell).efRangeLo;
end;

constructor TOvcDbPictureArrayEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {set default values for persistent properties}
  FDateOrTime      := daDefDateOrTime;
  FDecimalPlaces   := daDefDecimalPlaces;
  FMaxLength       := daDefMaxLength;
  FPictureMask     := aeDefPictureMask;
end;


{*** TOvcDbNumericArrayEditor ***}

procedure TOvcDbNumericArrayEditor.aeCreateEditCell;
begin
  aeCell.Free;
  aeCell := TOvcDbNumericCell.Create(Self);

  {adjust cell size}
  if FShowIndicator then
    aeCell.SetBounds(FIndicatorWidth, 0, ClientWidth-FIndicatorWidth, FRowHeight-1)
  else
    aeCell.SetBounds(0, 0, ClientWidth, FRowHeight-1);

  {save current datalink notification event handlers}
  FCellOnActiveChange              := DataLink.OnActiveChange;
  FCellOnDataChange                := DataLink.OnDataChange;
  FCellOnEditingChange             := DataLink.OnEditingChange;
  FCellOnUpdateData                := DataLink.OnUpdateData;

  {assign new datalink event handlers}
  DataLink.OnActiveChange          := aeActiveChange;
  DataLink.OnDataChange            := aeDataChange;
  DataLink.OnEditingChange         := aeEditingChange;
  DataLink.OnUpdateData            := aeUpdateData;

  {set basic cell properties}
  aeCell.AutoAdvanceChar           := FAutoAdvanceChar;
  aeCell.AutoAdvanceLeftRight      := FAutoAdvanceLR;
  aeCell.BeepOnError               := FBeepOnError;
  aeCell.Enabled                   := Enabled;
  aeCell.HighLightColors.BackColor := FHighlightColors.BackColor;
  aeCell.HighLightColors.TextColor := FHighlightColors.TextColor;
  aeCell.PadChar                   := FPadChar;
  aeCell.ReadOnly                  := FReadOnly;
  aeCell.TabStop                   := TabStop;
  aeCell.TextMargin                := FTextMargin;
  aeCell.Parent                    := Self;

  {class specific property initialization}
  if Assigned(FDataSource) then begin
    TOvcDbNumericCell(aeCell).ZeroAsNull := FZeroAsNull;
    TOvcDbNumericCell(aeCell).DataSource := FDataSource;
    TOvcDbNumericCell(aeCell).DataField := FDataField;
    if (DataLink <> nil) and DataLink.Active then
      FFieldType := TOvcDbNumericCell(aeCell).FieldType
    else begin
      try
        if FFieldType <> ftUnknown then
          TOvcDbNumericCell(aeCell).FieldType := FFieldType;
      except
        FFieldType := TOvcDbNumericCell(aeCell).FieldType;
        raise;
      end;
    end;

    if Length(FPictureMask) > 0 then
      TOvcDbNumericCell(aeCell).PictureMask := FPictureMask;
  end;

  {update range limits}
  if not aeRangeLoaded then begin
    aeRangeHi := TLocalEF(aeCell).efRangeHi;
    aeRangeLo := TLocalEF(aeCell).efRangeLo;
  end else begin
    TLocalEF(aeCell).efRangeHi := aeRangeHi;                           {!!.01}
    TLocalEF(aeCell).efRangeLo := aeRangeLo;                           {!!.01}
    {aeCell.SetRangeHi(aeRangeHi);}                                    {!!.01}
    {aeCell.SetRangeLo(aeRangeLo);}                                    {!!.01}
  end;
end;

procedure TOvcDbNumericArrayEditor.aeGetCellProperties;
  {-freshend our copy of the cell properties}
begin
  if not Assigned(aeCell) then
    Exit;

  FFieldType     := TOvcDbNumericCell(aeCell).FieldType;
  FMaxLength     := TOvcDbNumericCell(aeCell).MaxLength;
  FDecimalPlaces := TOvcDbNumericCell(aeCell).DecimalPlaces;
  FPictureMask   := TOvcDbNumericCell(aeCell).PictureMask;
  aeRangeHi      := TLocalEF(aeCell).efRangeHi;
  aeRangeLo      := TLocalEF(aeCell).efRangeLo;
end;

constructor TOvcDbNumericArrayEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {set default values for persistent properties}
  FDecimalPlaces   := daDefDecimalPlaces;
  FMaxLength       := daDefMaxLength;
  FPictureMask     := aeDefNumericMask;
end;


{*** TOvcDbSimpleCell ***}

constructor TOvcDbSimpleCell.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {assign edit field properties}
  ParentFont  := True;
  ParentColor := True;
  Ctl3D       := False;
  ParentCtl3D := False;
  BorderStyle := TBorderStyle(0);
  AutoSize    := False;
end;

procedure TOvcDbSimpleCell.CreateWnd;
begin
  {set controller before window is created}
  Controller := TOvcBaseDbArrayEditor(Parent).Controller;
  inherited CreateWnd;

  {assign parent event handlers to the edit cell}
  OnChange         := TOvcBaseDbArrayEditor(Parent).OnChange;
  OnClick          := TOvcBaseDbArrayEditor(Parent).OnClick;
  OnDblClick       := TOvcBaseDbArrayEditor(Parent).OnDblClick;
  OnEnter          := TOvcBaseDbArrayEditor(Parent).OnEnter;
  OnError          := TOvcBaseDbArrayEditor(Parent).OnError;
  OnExit           := TOvcBaseDbArrayEditor(Parent).OnExit;
  OnKeyDown        := TOvcBaseDbArrayEditor(Parent).OnKeyDown;
  OnKeyPress       := TOvcBaseDbArrayEditor(Parent).OnKeyPress;
  OnKeyUp          := TOvcBaseDbArrayEditor(Parent).OnKeyUp;
  OnMouseDown      := TOvcBaseDbArrayEditor(Parent).OnMouseDown;
  OnMouseMove      := TOvcBaseDbArrayEditor(Parent).OnMouseMove;
  OnMouseUp        := TOvcBaseDbArrayEditor(Parent).OnMouseUp;
  OnUserCommand    := TOvcBaseDbArrayEditor(Parent).OnUserCommand;
  OnUserValidation := TOvcBaseDbArrayEditor(Parent).OnUserValidation;
end;

procedure TOvcDbSimpleCell.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd : Word;
begin
  {process keyboard commands}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));
  if Cmd in [ccUp, ccDown, ccFirstPage, ccLastPage, ccPrevPage, ccNextPage] then begin
    {message was handled}
    Msg.Result := 0;

    {validate cell contents if modified}
    if Modified and not ValidateSelf then
      Exit;

    case Cmd of
      ccUp        :
        Parent.Perform(WM_VSCROLL, SB_LINEUP, 0);
      ccDown      :
        Parent.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
      {$IFDEF Win32}
      ccFirstPage :
        Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 0), Parent.Handle);
      ccLastPage  :
        Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 4), Parent.Handle);
      {$ELSE}
      ccFirstPage :
        Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(0, Parent.Handle));
      ccLastPage  :
        Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(4, Parent.Handle));
      {$ENDIF}
      ccPrevPage  :
        Parent.Perform(WM_VSCROLL, SB_PAGEUP, 0);
      ccNextPage  :
        Parent.Perform(WM_VSCROLL, SB_PAGEDOWN, 0);
    end;
  end else
    inherited;
end;


{*** TOvcDbPictureCell ***}

constructor TOvcDbPictureCell.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {assign edit field properties}
  ParentFont  := True;
  ParentColor := True;
  Ctl3D       := False;
  ParentCtl3D := False;
  BorderStyle := TBorderStyle(0);
  AutoSize    := False;
end;

procedure TOvcDbPictureCell.CreateWnd;
begin
  {set controller before window is created}
  Controller := TOvcBaseDbArrayEditor(Parent).Controller;
  inherited CreateWnd;

  {assign parent event handlers to the edit cell}
  OnChange         := TOvcBaseDbArrayEditor(Parent).OnChange;
  OnClick          := TOvcBaseDbArrayEditor(Parent).OnClick;
  OnDblClick       := TOvcBaseDbArrayEditor(Parent).OnDblClick;
  OnEnter          := TOvcBaseDbArrayEditor(Parent).OnEnter;
  OnError          := TOvcBaseDbArrayEditor(Parent).OnError;
  OnExit           := TOvcBaseDbArrayEditor(Parent).OnExit;
  OnKeyDown        := TOvcBaseDbArrayEditor(Parent).OnKeyDown;
  OnKeyPress       := TOvcBaseDbArrayEditor(Parent).OnKeyPress;
  OnKeyUp          := TOvcBaseDbArrayEditor(Parent).OnKeyUp;
  OnMouseDown      := TOvcBaseDbArrayEditor(Parent).OnMouseDown;
  OnMouseMove      := TOvcBaseDbArrayEditor(Parent).OnMouseMove;
  OnMouseUp        := TOvcBaseDbArrayEditor(Parent).OnMouseUp;
  OnUserCommand    := TOvcBaseDbArrayEditor(Parent).OnUserCommand;
  OnUserValidation := TOvcBaseDbArrayEditor(Parent).OnUserValidation;
end;

procedure TOvcDbPictureCell.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd : Word;
begin
  {process keyboard commands}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));
  if Cmd in [ccUp, ccDown, ccFirstPage, ccLastPage, ccPrevPage, ccNextPage] then begin
    {message was handled}
    Msg.Result := 0;

    {validate cell contents if modified}
    if Modified and not ValidateSelf then
      Exit;

    case Cmd of
      ccUp        :
        Parent.Perform(WM_VSCROLL, SB_LINEUP, 0);
      ccDown      :
        Parent.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
      {$IFDEF Win32}
      ccFirstPage :
        Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 0), Parent.Handle);
      ccLastPage  :
        Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 4), Parent.Handle);
      {$ELSE}
      ccFirstPage :
        Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(0, Parent.Handle));
      ccLastPage  :
        Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(4, Parent.Handle));
      {$ENDIF}
      ccPrevPage  :
        Parent.Perform(WM_VSCROLL, SB_PAGEUP, 0);
      ccNextPage  :
        Parent.Perform(WM_VSCROLL, SB_PAGEDOWN, 0);
    end;
  end else
    inherited;
end;

{*** TOvcDbNumericCell ***}

constructor TOvcDbNumericCell.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {assgin edit field properties}
  ParentFont  := True;
  ParentColor := True;
  Ctl3D       := False;
  ParentCtl3D := False;
  BorderStyle := TBorderStyle(0);
  AutoSize    := False;
end;

procedure TOvcDbNumericCell.CreateWnd;
begin
  {set controller before window is created}
  Controller := TOvcBaseDbArrayEditor(Parent).Controller;
  inherited CreateWnd;

  {assign parent event handlers to the edit cell}
  OnChange         := TOvcBaseDbArrayEditor(Parent).OnChange;
  OnClick          := TOvcBaseDbArrayEditor(Parent).OnClick;
  OnDblClick       := TOvcBaseDbArrayEditor(Parent).OnDblClick;
  OnEnter          := TOvcBaseDbArrayEditor(Parent).OnEnter;
  OnError          := TOvcBaseDbArrayEditor(Parent).OnError;
  OnExit           := TOvcBaseDbArrayEditor(Parent).OnExit;
  OnKeyDown        := TOvcBaseDbArrayEditor(Parent).OnKeyDown;
  OnKeyPress       := TOvcBaseDbArrayEditor(Parent).OnKeyPress;
  OnKeyUp          := TOvcBaseDbArrayEditor(Parent).OnKeyUp;
  OnMouseDown      := TOvcBaseDbArrayEditor(Parent).OnMouseDown;
  OnMouseMove      := TOvcBaseDbArrayEditor(Parent).OnMouseMove;
  OnMouseUp        := TOvcBaseDbArrayEditor(Parent).OnMouseUp;
  OnUserCommand    := TOvcBaseDbArrayEditor(Parent).OnUserCommand;
  OnUserValidation := TOvcBaseDbArrayEditor(Parent).OnUserValidation;
end;

procedure TOvcDbNumericCell.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd : Word;
begin
  {process keyboard commands}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));
  if Cmd in [ccUp, ccDown, ccFirstPage, ccLastPage, ccPrevPage, ccNextPage] then begin
    {message was handled}
    Msg.Result := 0;

    {validate cell contents if modified}
    if Modified and not ValidateSelf then
      Exit;

    case Cmd of
      ccUp        :
        Parent.Perform(WM_VSCROLL, SB_LINEUP, 0);
      ccDown      :
        Parent.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
      {$IFDEF Win32}
      ccFirstPage :
        Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 0), Parent.Handle);
      ccLastPage  :
        Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 4), Parent.Handle);
      {$ELSE}
      ccFirstPage :
        Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(0, Parent.Handle));
      ccLastPage  :
        Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(4, Parent.Handle));
      {$ENDIF}
      ccPrevPage  :
        Parent.Perform(WM_VSCROLL, SB_PAGEUP, 0);
      ccNextPage  :
        Parent.Perform(WM_VSCROLL, SB_PAGEDOWN, 0);
    end;
  end else
    inherited;
end;



end.