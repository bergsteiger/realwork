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
{*                   OVCAE.PAS 2.17                      *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcAe;
  {-Array editors using simple, picture and numeric edit fields}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics,
  Menus, Messages, SysUtils,
  OvcNf, OvcPf, OvcSf, OvcColor, OvcMisc, OvcExcpt,
  OvcBase, OvcCmd, OvcConst, OvcData, OvcEf, OvcStr;

const
  {default property values}
  aeDefActiveIndex     = 0;
  aeDefAlign           = alNone;
  aeDefAutoAdvanceChar = False;
  aeDefAutoAdvanceLR   = False;
  aeDefBeepOnError     = True;
  aeDefBorderStyle     = bsSingle;
  aeDefColor           = clWindow;
  aeDefCtl3D           = True;
  aeDefDecimalPlaces   = 0;
  aeDefDisabledBack    = clWindow;
  aeDefDisabledText    = clGrayText;
  aeDefHeight          = 150;
  aeDefHighlightBack   = clHighlight;
  aeDefHighlightText   = clHighlightText;
  aeDefInsertPushes    = True;
  aeDefLineColor       = clSilver;
  aeDefMaxLength       = 10;
  aeDefNumericDataType = nftLongInt;
  aeDefNumericMask     = '##########';
  aeDefNumItems        = 0;
  aeDefNumRows         = 0;
  aeDefParentColor     = False;
  aeDefParentCtl3D     = True;
  aeDefParentFont      = False;
  aeDefPictureMask     = 'XXXXXXXXXXXXXXX';
  aeDefReadOnly        = False;
  aeDefRightAlign      = False;
  aeDefRightJustify    = False;
  {$IFDEF Win32}
  aeDefRowHeight       = 17;
  {$ELSE}
  aeDefRowHeight       = 20;
  {$ENDIF}
  aeDefSimpleDataType  = sftString;
  aeDefSimpleMask      = pmAnyChar;
  aeDefTextMargin      = 2;
  aeDefTabStop         = True;
  aeDefTopIndex        = 0;
  aeDefTrimBlanks      = True;
  aeDefUseScrollBar    = True;
  aeDefWidth           = 100;

type
  {event to get a pointer to the cell's value}
  TGetItemEvent =
    procedure(Sender : TObject; Index : LongInt; var Value : Pointer)
    of object;
  {event to get color of the item cell}
  TGetItemColorEvent =
    procedure(Sender : TObject; Index : LongInt; var FG, BG : TColor)
    of object;
  {event to notify of a scroll action}
  TSelectEvent =
    procedure(Sender : TObject; NewIndex : LongInt)
    of object;

type
  {base class for array editors}
  TOvcBaseArrayEditor = class(TOvcBase)
  {.Z+}
  protected {private}
    {property variables}
    FActiveIndex       : LongInt;       {the focused cell}
    FAutoAdvanceChar   : Boolean;       {focus moves to next field after last character entered}
    FAutoAdvanceLR     : Boolean;       {L/R cursor movement at field ends moves focus to next/prev control}
    FBeepOnError       : Boolean;       {MessageBeep is called for error conditions}
    FBorderStyle       : TBorderStyle;  {border around the control}
    FDisabledColors    : TOvcColors;    {colors for disabled fields}   {!!.13}
    FHighlightColors   : TOvcColors;    {highlight colors}
    FInsertPushes      : Boolean;       {inserted chars push ending chars off}
    FLineColor         : TColor;        {color of row divider lines}
    FNumItems          : LongInt;       {total elements in array}
    FPadChar           : AnsiChar;      {character used to pad end of string}
    FReadOnly          : Boolean;       {prevents field editing}
    FRightAlign        : Boolean;       {enables right alignment}      {!!.10}
    FRightJustify      : Boolean;       {display text right-justified}
    FRowHeight         : Integer;       {pixel height of one row}
    FTextMargin        : Integer;       {indent from left (right)}
    FTrimBlanks        : Boolean;       {remove leading and trailing blanks if not listerals}
    FUseScrollBar      : Boolean;       {true to use virtical scroll bar}

    {event variables}
    FOnChange          : TNotifyEvent;  {change notification}
    FOnError           : TValidationErrorEvent;
    FOnGetItem         : TGetItemEvent; {method to call to get item pointer}
    FOnGetItemColor    : TGetItemColorEvent;
    FOnSelect          : TSelectEvent;  {scroll notification}
    FOnUserCommand     : TUserCommandEvent;
    FOnUserValidation  : TUserValidationEvent;

    {internal/working variables}
    aeCell             : TOvcBaseEntryField;{abstract edit cell object}
    aeDivisor          : LongInt;       {divisor for scroll bar}
    aeHighIndex        : LongInt;       {highest index value}
    aeItemPtr          : Pointer;       {pointer to data element}
    aeNumRows          : Integer;       {visible rows in window}
    aeRangeLo          : TRangeType;    {low field range limit}
    aeRangeHi          : TRangeType;    {high field range limit}
    aeRangeLoaded      : Boolean;       {flag to tell when loaded}
    aeTopIndex         : LongInt;       {index of the top item}
    aeVSHigh           : Integer;       {vertical scroll limit}

    {variables to transfer to the edit cell field}
    aeDecimalPlaces    : Byte;          {max decimal places}
    aeMaxLength        : Word;          {maximum length of string}

    {property methods}
    function GetRangeHi : string;
      {-get the high field range string value}
    function GetRangeLo : string;
      {-get the low field range string value}
    procedure SetAutoAdvanceChar(Value : Boolean);
      {-set the AutoAdvanceChar option}
    procedure SetAutoAdvanceLeftRight(Value : Boolean);
      {-set the AutoAdvanceLeftRight option}
    procedure SetBeepOnError(Value : Boolean);
      {-sets the BeepOnError option}
    procedure SetBorderStyle(const Value : TBorderStyle);
      {-set the style used for the border}
    procedure SetInsertPushes(Value : Boolean);
      {-set the InsertPushes option}
    procedure SetLineColor(Value : TColor);
      {-set the color used to draw the row divider lines}
    procedure SetNumItems(Value : LongInt);
      {-set the number of items in the array}
    procedure SetPadChar(Value : AnsiChar);
      {-set the character used to pad the end of the edit string}
    procedure SetRangeHi(const Value : string);
      {-set the high field range from a string value}
    procedure SetRangeLo(const Value : string);
      {-set the low field range from a string value}
    procedure SetReadOnly(Value : Boolean);
      {-set the read only option}
    procedure SetRightAlign(Value : Boolean);                          {!!.10}
      {-set the right align option}
    procedure SetRightJustify(Value : Boolean);
      {-set the right justify option}
    procedure SetRowHeight(Value : Integer);
      {-set the cell row height}
    procedure SetTextMargin(Value : Integer);
      {-set the text margin}
    procedure SetTrimBlanks(Value : Boolean);
      {-set the trim blanks option}
    procedure SetUseScrollBar(Value : Boolean);
      {-set use of vertical scroll bar}

    {general (internal) routines}
    procedure aeAdjustIntegralHeight;
      {-resizes the component so no partial items appear}
    procedure aeColorChanged(AColor : TObject);
      {-highlight color change-repaint}
    function aeMakeItemVisible(Index : LongInt) : Boolean;
      {-displays the Index item, scrolling as required}
    procedure aePreFocusProcess;
      {-get ready to receive focus}
    procedure aeReadRangeHi(Stream : TStream);
      {-called to read the high range from the stream}
    procedure aeReadRangeLo(Stream : TStream);
      {-called to read the low range from the stream}
    function aeScaleDown(N : LongInt) : SmallInt;
      {-returns a scaled down scroll bar value}
    function aeScaleUp(N : SmallInt) : LongInt;
      {-returns a scaled up scroll bar value}
    procedure aeSetVScrollPos;
      {-sets the vertical scroll bar position}
    procedure aeSetVScrollRange;
      {-sets the horizontal scroll bar position}
    procedure aeUpdateDisplay(Scrolled : Boolean; OldItem, NewItem : LongInt);
      {-invalidate or scroll necessary region}
    procedure aeWriteRangeHi(Stream : TStream);
      {-called to store the high range on the stream}
    procedure aeWriteRangeLo(Stream : TStream);
      {-called to store the low range on the stream}

    {VCL control messages}
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;
    procedure CMEnabledChanged(var Msg : TMessage);                    {!!.12}
      message CM_ENABLEDCHANGED;                                       {!!.12}
    procedure CMFontChanged(var Msg : TMessage);
      message CM_FONTCHANGED;
    procedure CMGotFocus(var Msg : TMessage);
      message CM_GOTFOCUS;
    procedure CMLostFocus(var Msg : TMessage);
      message CM_LOSTFOCUS;

    {windows message methods}
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
      message WM_ERASEBKGND;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;
    procedure WMVScroll(var Msg : TWMScroll);
      message WM_VSCROLL;

  protected
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
      dynamic; abstract;
      {-create the edit celll}
    function aeGetEditString : PAnsiChar;
      dynamic; abstract;
      {-return the edit cells edit string}
    procedure aeGetSampleDisplayData(P : PAnsiChar);
      dynamic; abstract;
      {-cause edit cell to display sample data}

    {event wraper methods}
    procedure DoGetCellValue(Index : LongInt);
      virtual; abstract;
      {-get the value for the "Index" cell}
    procedure DoGetItemColor(Index : LongInt; var FG, BG : TColor);
      virtual;
      {-get the color values for the "Index" cell}
    function DoPutCellValue : LongInt;
      dynamic; abstract;
      {-store the current value of the edit cell. Result is error code}
    procedure DoOnSelect(NewIndex : LongInt);
      dynamic;
      {-perform scroll action notification}

    {abstract property method}
    procedure SetActiveIndex(Value : LongInt);
      virtual; abstract;
      {-set the active array item}
  {.Z-}

    property InsertPushes : Boolean
      read FInsertPushes
      write SetInsertPushes
      default aeDefInsertPushes;

    property RightAlign : Boolean                                      {!!.10}
      read FRightAlign
      write SetRightAlign
      default aeDefRightAlign;

    property RightJustify : Boolean
      read FRightJustify
      write SetRightJustify
      default aeDefRightJustify;

    property TrimBlanks : Boolean
      read FTrimBlanks
      write SetTrimBlanks
      default aeDefTrimBlanks;

  public
  {.Z+}
    constructor Create(AOwner : TComponent);
      override;
    destructor  Destroy;
      override;
    procedure SetFocus;                                                {!!.D4}
      override;
  {.Z-}

    function WriteCellValue : LongInt;                                 {!!.13}
      {-write the current cell value. return 0 or error code}

    property ItemIndex : LongInt
      read FActiveIndex
      write SetActiveIndex
      stored False;

  published
    property AutoAdvanceChar : Boolean
      read FAutoAdvanceChar
      write SetAutoAdvanceChar
      default aeDefAutoAdvanceChar;

    property AutoAdvanceLeftRight : Boolean
      read FAutoAdvanceLR
      write SetAutoAdvanceLeftRight
      default aeDefAutoAdvanceLR;

    property BeepOnError : Boolean
      read FBeepOnError
      write FBeepOnError
      default aeDefBeepOnError;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default aeDefBorderStyle;

    property DisabledColors : TOvcColors                               {!!.13}
      read FDisabledColors
      write FDisabledColors;

    property HighlightColors : TOvcColors
      read FHighlightColors
      write FHighlightColors;

    property LineColor : TColor
      read FLineColor
      write SetLineColor
      default aeDefLineColor;

    {placed here so RowHeight is set prior to NumItems}
    property RowHeight : Integer
      read FRowHeight
      write SetRowHeight
      default aeDefRowHeight;

    property NumItems : LongInt
      read FNumItems
      write SetNumItems
      default aeDefNumItems;

    property PadChar : AnsiChar
      read FPadChar
      write SetPadChar
      default DefPadChar;

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
      default aeDefReadOnly;

    property TextMargin : Integer
      read FTextMargin
      write SetTextMargin
      default aeDefTextMargin;

    property UseScrollBar : Boolean
       read FUseScrollBar
       write SetUseScrollBar
       default aeDefUseScrollBar;

    {events}
    property OnGetItem : TGetItemEvent
      read FOnGetItem
      write FOnGetItem;

    property OnGetItemColor : TGetItemColorEvent
      read FOnGetItemColor
      write FOnGetItemColor;

    {events echoed to the edit field object}
    property OnChange : TNotifyEvent
      read FOnChange
      write FOnChange;

    property OnError : TValidationErrorEvent
      read FOnError
      write FOnError;

    property OnSelect : TSelectEvent
      read FOnSelect
      write FOnSelect;

    property OnUserCommand : TUserCommandEvent
      read FOnUserCommand
      write FOnUserCommand;

    property OnUserValidation : TUserValidationEvent
      read FOnUserValidation
      write FOnUserValidation;

    {inherited properties}
    property Align;
    property Color;
    property Ctl3D;
    property Controller;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Height;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont default aeDefParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Width;

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
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
  end;

type
  TSimpleCellField = class;
  TOvcSimpleArrayEditor = class(TOvcBaseArrayEditor)
  {.Z+}
  protected {private}
    {variables to transfer to the edit cell field}
    aeDataType    : TSimpleDataType;
    aePictureMask : AnsiChar;

    {property methods}
    procedure SetArrayDataType(Value: TSimpleDataType);
      {-set the data type for this field}
    procedure SetDecimalPlaces(Value : Byte);
      {-set the number of decimal places for the edit field}
    procedure SetMaxLength(Value : Word);
      {-set the maximum length of the edit field}
    procedure SetPictureMask(Value : AnsiChar);
      {-set the picture mask}

  protected
    procedure aeCreateEditCell;
      override;
      {-create the edit celll}
    function aeGetEditString : PAnsiChar;
      override;
      {-return the edit cells edit string}
    procedure aeGetSampleDisplayData(P : PAnsiChar);
      override;
      {-obtain sample data for the edit cell to display}

    {event wrapper methods}
    procedure DoGetCellValue(Index : LongInt);
      override;
      {-get the value for the cell with "Index"}
    function DoPutCellValue : LongInt;
      override;
      {-store the current value of the edit cell. Result is error code}

    {virtual property method}
    procedure SetActiveIndex(Value : LongInt);
      override;
      {-set the active array item}
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;

  published
    {properties for the edit cell field}
    property DataType : TSimpleDataType
      read aeDataType
      write SetArrayDataType
      default sftString;

    property DecimalPlaces : Byte
      read aeDecimalPlaces
      write SetDecimalPlaces
      default aeDefDecimalPlaces;

    property MaxLength : Word
      read aeMaxLength
      write SetMaxLength
      default aeDefMaxLength;

    property PictureMask : AnsiChar
      read aePictureMask
      write SetPictureMask;

    property InsertPushes;
    property RightAlign;                                               {!!.10}
    property TrimBlanks;
  end;

  {.Z+}
  TSimpleCellField = class(TOvcSimpleField)
  protected {private}
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;

  protected
    procedure CreateWnd;
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
  end;
  {.Z-}

type
  TPictureCellField = class;
  TOvcPictureArrayEditor = class(TOvcBaseArrayEditor)
  {.Z+}
  protected {private}
    {variables to transfer to the edit cell field}
    aeDataType    : TPictureDataType;
    aeEpoch       : Integer;          {combined epoch year and cenury}
    aePictureMask : string;

    {property methods}
    procedure SetArrayDataType(Value: TPictureDataType);
      {-set the data type for this field}
    procedure SetDecimalPlaces(Value : Byte);
      {-set the number of decimal places for the edit field}
    procedure SetEpoch(Value : Integer);
      {-set the epoch value}
    procedure SetMaxLength(Value : Word);
      {-set the maximum length of the edit field}
    procedure SetPictureMask(const Value : string);
      {-set the picture mask}

  protected
    procedure aeCreateEditCell;
      override;
      {-create the edit celll}
    function aeGetEditString : PAnsiChar;
      override;
      {-return the edit cells edit string}
    procedure aeGetSampleDisplayData(P : PAnsiChar);
      override;
      {-obtain sample data for the edit cell to display}

    {event wrapper methods}
    procedure DoGetCellValue(Index : LongInt);
      override;
      {-get the value for the cell with "Index"}
    function DoPutCellValue : LongInt;
      override;
      {-store the current value of the edit cell. Result is error code}

    {virtual property method}
    procedure SetActiveIndex(Value : LongInt);
      override;
      {-set the active array item}
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;

  published
    {properties for the edit cell field}
    property DataType : TPictureDataType
      read aeDataType
      write SetArrayDataType
      default pftString;

    property DecimalPlaces : Byte
      read aeDecimalPlaces
      write SetDecimalPlaces
      default aeDefDecimalPlaces;

    property Epoch : Integer
      read aeEpoch
      write SetEpoch;

    property MaxLength : Word
      read aeMaxLength
      write SetMaxLength
      default aeDefMaxLength;

    property PictureMask : string
      read aePictureMask
      write SetPictureMask;

    property InsertPushes;
    property RightAlign;                                               {!!.10}
    property RightJustify;
    property TrimBlanks;
  end;

  {.Z+}
  TPictureCellField = class(TOvcPictureField)
  protected {private}
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;

  protected
    procedure CreateWnd;
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
  end;
  {.Z-}

type
  TNumericCellField = class;
  TOvcNumericArrayEditor = class(TOvcBaseArrayEditor)
  {.Z+}
  protected {private}
    {variables to transfer to the edit cell field}
    aeDataType    : TNumericDataType;
    aePictureMask : string;

    {property methods}
    procedure SetArrayDataType(Value: TNumericDataType);
      {-set the data type for this field}
    procedure SetPictureMask(const Value : string);
      {-set the picture mask}

  protected
    procedure aeCreateEditCell;
      override;
      {-create the edit celll}
    function aeGetEditString : PAnsiChar;
      override;
      {-return the edit cells edit string}
    procedure aeGetSampleDisplayData(P : PAnsiChar);
      override;
      {-obtain sample data for the edit cell to display}

    {event wrapper methods}
    procedure DoGetCellValue(Index : LongInt);
      override;
      {-get the value for the cell with "Index"}
    function DoPutCellValue : LongInt;
      override;
      {-store the current value of the edit cell. Result is error code}

    {virtual property method}
    procedure SetActiveIndex(Value : LongInt);
      override;
      {-set the active array item}
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;

  published
    {properties for the edit cell field}
    property DataType : TNumericDataType
      read aeDataType
      write SetArrayDataType
      default nftLongInt;

    property PictureMask : string
      read aePictureMask
      write SetPictureMask;
  end;

  {.Z+}
  TNumericCellField = class(TOvcNumericField)
  protected {private}
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;

  protected
    procedure CreateWnd;
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
  end;
  {.Z-}


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


type
  {local class to allow access to protected entry field data/methods}
  TLocalEF = class(TOvcBaseEntryField);


{*** TOvcBaseArrayEditor ***}

procedure TOvcBaseArrayEditor.aeAdjustIntegralHeight;
  {-resizes the component so no partial items appear}
begin
  if not HandleAllocated then
    Exit;

  if csLoading in ComponentState then
    Exit;

  if ClientHeight <> aeNumRows*FRowHeight then
    ClientHeight := aeNumRows*FRowHeight;
end;

procedure TOvcBaseArrayEditor.aeColorChanged(AColor : TObject);
  {-highlight color change-repaint}
begin
  Repaint;
end;

function TOvcBaseArrayEditor.aeMakeItemVisible(Index : LongInt) : Boolean;
begin
  Result := False;

  if Index < 0 then
    Index := 0;
  if Index > aeHighIndex then
    Index := aeHighIndex;

  if Index < aeTopIndex then begin
    aeTopIndex := Index;
    Result := True;
  end else if Index > aeTopIndex+Pred(aeNumRows) then begin
    aeTopIndex := Index-Pred(aeNumRows);
    Result := True;
  end;

  {move the cell control to the new Position}
  aeCell.SetSelection(0, 0);
  aeCell.Top := (Index-aeTopIndex)*FRowHeight;
  aeCell.SetSelection(0, 255);
end;

procedure TOvcBaseArrayEditor.aePreFocusProcess;
  {-get ready to receive focus}
var
  FGColor : TColor;
  BGColor : TColor;
begin
  DoGetCellValue(FActiveIndex);

  {get color for the active cell}
  FGColor := Font.Color;
  BGColor := Color;
  DoGetItemColor(FActiveIndex, FGColor, BGColor);
  aeCell.Font.Color := FGColor;
  aeCell.Color := BGColor;
  aeCell.HighlightColors.TextColor := FHighlightColors.TextColor;
  aeCell.HighlightColors.BackColor := FHighlightColors.BackColor;
end;

procedure TOvcBaseArrayEditor.aeReadRangeHi(Stream : TStream);
  {-called to read the high range from the stream}
begin
  Stream.Read(aeRangeHi, SizeOf(TRangeType));
  aeRangeLoaded := True;
end;

procedure TOvcBaseArrayEditor.aeReadRangeLo(Stream : TStream);
  {-called to read the low range from the stream}
begin
  Stream.Read(aeRangeLo, SizeOf(TRangeType));
  aeRangeLoaded := True;
end;

function TOvcBaseArrayEditor.aeScaleDown(N : LongInt) : SmallInt;
  {-returns a scaled down scroll bar value}
begin
  Result := N div aeDivisor;
end;

function TOvcBaseArrayEditor.aeScaleUp(N : SmallInt) : LongInt;
  {-returns a scaled up scroll bar value}
begin
  if N = aeVSHigh then
    Result := aeHighIndex
  else
    Result := N * aeDivisor;
end;

procedure TOvcBaseArrayEditor.aeSetVScrollPos;
  {-sets the virtical scroll bar position}
begin
  if FUseScrollBar then
    SetScrollPos(Handle, SB_VERT, aeScaleDown(FActiveIndex), True);
end;

procedure TOvcBaseArrayEditor.aeSetVScrollRange;
  {-sets the horizontal scroll bar position}
begin
  if not FUseScrollBar then
    Exit;

  aeDivisor := 1;
  if aeHighIndex < aeNumRows then
    aeVSHigh := 1
  else if aeHighIndex <= High(SmallInt) then                           {!!.13}
    aeVSHigh := aeHighIndex
  else begin
    aeDivisor := 2*(aeHighIndex div 32768);
    aeVSHigh := aeHighIndex div aeDivisor;
  end;
  if (FNumItems > aeNumRows) or (csDesigning in ComponentState) then
    SetScrollRange(Handle, SB_VERT, 0, aeVSHigh, False)
  else
    SetScrollRange(Handle, SB_VERT, 0, 0, False);
end;

procedure TOvcBaseArrayEditor.aeUpdateDisplay(Scrolled : Boolean;
          OldItem, NewItem : LongInt);
  {-invalidate or scroll necessary region}
var
  ClipArea : TRect;
  D, Y     : LongInt;
begin
  if Scrolled then begin
    D := OldItem - NewItem;
    if Abs(D) <= aeNumRows then begin
      ClipArea := ClientRect;

      {omit area for new cell}
      if NewItem > OldItem then
        Dec(ClipArea.Bottom, FRowHeight)
      else
        Inc(ClipArea.Top, FRowHeight);

      {calc amount to scroll}
      Y := (D) * FRowHeight;

      {scroll the window setting up a clipping region}
      ScrollWindow(Handle, 0, LOWORD(Y), @ClipArea, @ClipArea);
      Update;
    end else  {more than one page}
      Invalidate;
  end else begin
    Y := (OldItem-aeTopIndex)*FRowHeight;
    ClipArea := Rect(0, Y, ClientWidth, Y+aeCell.Height);
    InvalidateRect(Handle, @ClipArea, False);
  end;
end;

procedure TOvcBaseArrayEditor.aeWriteRangeHi(Stream : TStream);
  {-called to store the high range on the stream}
begin
  Stream.Write(aeRangeHi, SizeOf(TRangeType));
end;

procedure TOvcBaseArrayEditor.aeWriteRangeLo(Stream : TStream);
  {-called to store the low range on the stream}
begin
  Stream.Write(aeRangeLo, SizeOf(TRangeType));
end;

procedure TOvcBaseArrayEditor.ChangeScale(M, D : Integer);
begin
  inherited ChangeScale(M, D);

  if M <> D then
    {scale row height}
    RowHeight := MulDiv(FRowHeight, M, D);
end;

procedure TOvcBaseArrayEditor.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  {$ENDIF}

  inherited;
end;

{!!.12}
procedure TOvcBaseArrayEditor.CMEnabledChanged(var Msg : TMessage);
begin
  inherited;

  if Assigned(aeCell) then
    aeCell.Enabled := Self.Enabled;
end;

procedure TOvcBaseArrayEditor.CMFontChanged(var Msg : TMessage);
begin
  inherited;

  if (csLoading in ComponentState) then
    Exit;

  if not HandleAllocated then
    Exit;

  {adjust integral height}
  aeAdjustIntegralHeight;
end;

procedure TOvcBaseArrayEditor.CMGotFocus(var Msg : TMessage);
begin
  {do nothing -- cell edit field will respond}
end;

procedure TOvcBaseArrayEditor.CMLostFocus(var Msg : TMessage);
begin
  {do nothing -- cell edit field will respond}
end;

constructor TOvcBaseArrayEditor.Create(AOwner : TComponent);
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

  {set default values for inherited persistent properties}
  Align           := aeDefAlign;
  Color           := aeDefColor;
  Ctl3D           := aeDefCtl3D;
  Font.Name       := 'FixedSys';  {default to a fixed pitch font}
  Font.Size       := 10;
  Height          := aeDefHeight;
  ParentColor     := aeDefParentColor;
  ParentCtl3D     := aeDefParentCtl3D;
  ParentFont      := aeDefParentFont;
  TabStop         := aeDefTabStop;
  Width           := aeDefWidth;

  {set default values for persistent properties}
  if csDesigning in ComponentState then
    FActiveIndex := -1
  else
    FActiveIndex := aeDefActiveIndex;
  FAutoAdvanceChar   := aeDefAutoAdvanceChar;
  FAutoAdvanceLR     := aeDefAutoAdvanceLR;
  FBeepOnError       := aeDefBeepOnError;
  FBorderStyle       := aeDefBorderStyle;
  FInsertPushes      := aeDefInsertPushes;
  FLineColor         := aeDefLineColor;
  FNumItems          := aeDefNumItems;
  FPadChar           := DefPadChar;
  FReadOnly          := aeDefReadOnly;
  FRightAlign        := aeDefRightAlign;                               {!!.10}
  FRightJustify      := aeDefRightJustify;
  FRowHeight         := aeDefRowHeight;
  FTextMargin        := aeDefTextMargin;
  FTrimBlanks        := aeDefTrimBlanks;
  FUseScrollBar      := aeDefUseScrollBar;

  {set defaults for working variables}
  aeDecimalPlaces    := aeDefDecimalPlaces;
  aeDivisor          := 1;
  aeHighIndex        := Pred(FNumItems);
  aeMaxLength        := aeDefMaxLength;
  aeNumRows          := aeDefNumRows;
  aeRangeLoaded      := False;
  aeTopIndex         := aeDefTopIndex;
  aeVSHigh           := 0;

  {create colors object}
  FDisabledColors := TOvcColors.Create(aeDefDisabledText, aeDefDisabledBack); {!!.13}
  FDisabledColors.OnColorChange := aeColorChanged;                     {!!.13}
  FHighlightColors := TOvcColors.Create(aeDefHighlightText, aeDefHighlightBack);
  FHighlightColors.OnColorChange := aeColorChanged;
end;

procedure TOvcBaseArrayEditor.CreateParams(var Params: TCreateParams);
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

procedure TOvcBaseArrayEditor.CreateWnd;
begin
  inherited CreateWnd;

  {create the edit cell control}
  aeCreateEditCell;

  if PopupMenu <> nil then                                             {!!.16}
    TLocalEF(aeCell).PopupMenu := PopupMenu;                           {!!.16}

  {set properties for the edit cell to match our settings}
  aeCell.AutoAdvanceChar           := FAutoAdvanceChar;
  aeCell.AutoAdvanceLeftRight      := FAutoAdvanceLR;
  aeCell.BeepOnError               := FBeepOnError;
  aeCell.HighLightColors.BackColor := FHighlightColors.BackColor;
  aeCell.HighLightColors.TextColor := FHighlightColors.TextColor;
  aeCell.InsertPushes              := FInsertPushes;
  aeCell.PadChar                   := FPadChar;
  aeCell.ReadOnly                  := FReadOnly;
  aeCell.RightAlign                := FRightAlign;                     {!!.10}
  aeCell.RightJustify              := FRightJustify;
  aeCell.TextMargin                := FTextMargin;
  aeCell.TrimBlanks                := FTrimBlanks;
  aeCell.TabStop                   := Self.TabStop;
  aeCell.Enabled                   := Self.Enabled;                    {!!.01}
  aeCell.DisabledColors.TextColor  := FDisabledColors.TextColor;       {!!.13}
  aeCell.DisabledColors.BackColor  := FDisabledColors.BackColor;       {!!.13}

  aeCell.SetBounds(0, 0, ClientWidth, FRowHeight-1);
  aeCell.Name := 'EditCell';
  if not aeRangeLoaded then begin
    aeRangeHi := TLocalEF(aeCell).efRangeHi;
    aeRangeLo := TLocalEF(aeCell).efRangeLo;
  end else begin
    TLocalEF(aeCell).efRangeHi := aeRangeHi;                           {!!.01}
    TLocalEF(aeCell).efRangeLo := aeRangeLo;                           {!!.01}
    {aeCell.SetRangeHi(aeRangeHi);}                                    {!!.01}
    {aeCell.SetRangeLo(aeRangeLo);}                                    {!!.01}
  end;
  aeCell.Parent := Self;

  {set the scroll bar range}
  aeSetVScrollRange;

  {force current item to be visible}
  aeMakeItemVisible(FActiveIndex);
end;

procedure TOvcBaseArrayEditor.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('RangeHigh', aeReadRangeHi, aeWriteRangeHi, True);
  Filer.DefineBinaryProperty('RangeLow', aeReadRangeLo, aeWriteRangeLo, True);
end;

destructor TOvcBaseArrayEditor.Destroy;
begin
  {dispose of the color objects}
  FDisabledColors.Free;                                                {!!.13}
  FHighlightColors.Free;

  inherited Destroy;
end;

procedure TOvcBaseArrayEditor.DoGetItemColor(Index : LongInt; var FG, BG : TColor);
begin
  if Assigned(FOnGetItemColor) then
    FOnGetItemColor(Self, Index, FG, BG);
end;

procedure TOvcBaseArrayEditor.DoOnSelect(NewIndex : LongInt);
  {-perform scroll action notification}
begin
  {if another array editor is connected, pass msg to it}
  if not (csDesigning in ComponentState) and Assigned(FOnSelect) then
    FOnSelect(Self, NewIndex);
end;

function TOvcBaseArrayEditor.GetRangeHi : string;
  {-get the high field range string value}
begin
  Result := TLocalEF(aeCell).efRangeToStRange(aeRangeHi);
end;

function TOvcBaseArrayEditor.GetRangeLo : string;
  {-get the low field range string value}
begin
  Result := TLocalEF(aeCell).efRangeToStRange(aeRangeLo);
end;

procedure TOvcBaseArrayEditor.Paint;
var
  CR          : TRect;
  IR, Clip    : TRect;
  I           : LongInt;
  X, Y        : Integer;
  T           : array[0..MaxEditLen] of AnsiChar;
  P           : PAnsiChar;
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
  SaveFGColor := Font.Color;

  {starting offset for text}
  X := aeCell.TextMargin-1;                                            {!!.10}

  for I := aeTopIndex to aeTopIndex + Pred(aeNumRows) do begin
    if I <> FActiveIndex then begin
      CR.Top := (I-aeTopIndex)*FRowHeight;
      CR.Bottom := CR.Top+FRowHeight-1;
      if I = aeTopIndex + Pred(aeNumRows) then
        CR.Bottom := ClientHeight;
      Y := CR.Top + TLocalEF(aeCell).efTopMargin;

      if Bool(IntersectRect(IR, CR, Clip)) then begin
        DoGetCellValue(I);

        {!!.01} {revised}
        if Enabled then begin
          FGColor := SaveFGColor;
          BGColor := Color;
        end else begin
          FGColor := FDisabledColors.TextColor;                        {!!.13}
          BGColor := FDisabledColors.BackColor;                        {!!.13}
        end;

        DoGetItemColor(I, FGColor, BGColor);

        Canvas.Font.Color := FGColor;
        Canvas.Brush.Color := BGColor;
        Canvas.FillRect(CR);                                           {!!.11}

        if csDesigning in ComponentState then begin
          aeGetSampleDisplayData(T);
          if (aeCell is TOvcNumericField) or RightAlign then begin     {!!.10}
            TrimAllSpacesPChar(T);

            {set right alignment}
            SetTextAlign(Canvas.Handle, TA_RIGHT);

            {paint the text right aligned}
            ExtTextOut(Canvas.Handle, CR.Right-FTextMargin-1, Y,
              {ETO_OPAQUE+}ETO_CLIPPED, @CR, T, StrLen(T), nil);       {!!.11}
          end else
            ExtTextOut(Canvas.Handle, X, Y, {ETO_OPAQUE+}ETO_CLIPPED,  {!!.11}
              @CR, T, StrLen(T), nil);
        end else begin
          P := aeGetEditString;
          if (aeCell is TOvcNumericField) or RightAlign then begin     {!!.10}
            StrCopy(T, P);
            TrimAllSpacesPChar(T);

            {set right alignment}
            SetTextAlign(Canvas.Handle, TA_RIGHT);

            {paint the text right aligned}
            ExtTextOut(Canvas.Handle, CR.Right-FTextMargin-1, Y,
              {ETO_OPAQUE+}ETO_CLIPPED, @CR, T, StrLen(T), nil);       {!!.11}
          end else
            ExtTextOut(Canvas.Handle, X, Y, {ETO_OPAQUE+}ETO_CLIPPED,  {!!.11}
              @CR, P, StrLen(P), nil);
        end;
      end;
    end;
  end;

  {restore the active item value}
  DoGetCellValue(FActiveIndex);

  {!!.13}
  if Enabled then begin
    FGColor := SaveFGColor;
    BGColor := Color;
  end else begin
    FGColor := FDisabledColors.TextColor;
    BGColor := FDisabledColors.BackColor;
  end;

  DoGetItemColor(FActiveIndex, FGColor, BGColor);
  aeCell.Font.Color := FGColor;
  aeCell.Color := BGColor;

  {!!.13}
  if not Enabled then begin
    aeCell.DisabledColors.TextColor := FGColor;
    aeCell.DisabledColors.BackColor := BGColor;
  end;

  {paint the active cell with the proper colors}
  aeCell.Repaint;

  {draw cell divider lines}
  Y := -1;
  Canvas.Pen.Color := FLineColor;
  for I := 0 to Pred(aeNumRows)-1 do begin
    Inc(Y, FRowHeight);
    Canvas.PolyLine([Point(0, Y), Point(ClientWidth, Y)]);
  end;
end;

procedure TOvcBaseArrayEditor.SetAutoAdvanceChar(Value : Boolean);
  {-set the AutoAdvanceChar option}
begin
  if Value <> FAutoAdvanceChar then begin
    FAutoAdvanceChar := Value;
    if csDesigning in ComponentState then
      Exit;

    if Assigned(aeCell) then begin
      aeCell.AutoAdvanceChar := FAutoAdvanceChar;
      FAutoAdvanceChar := aeCell.AutoAdvanceChar;
    end;
  end;
end;

procedure TOvcBaseArrayEditor.SetAutoAdvanceLeftRight(Value : Boolean);
  {-set the AutoAdvanceLeftRight option}
begin
  if Value <> FAutoAdvanceLR then begin
    FAutoAdvanceLR := Value;
    if csDesigning in ComponentState then
      Exit;

    if Assigned(aeCell) then begin
      aeCell.AutoAdvanceLeftRight := FAutoAdvanceLR;
      FAutoAdvanceLR := aeCell.AutoAdvanceLeftRight;
    end;
  end;
end;

procedure TOvcBaseArrayEditor.SetBeepOnError(Value : Boolean);
  {-set the BeepOnError option}
begin
  if Value <> FBeepOnError then begin
    FBeepOnError := Value;
    if csDesigning in ComponentState then
      Exit;

    if Assigned(aeCell) then begin
      aeCell.BeepOnError := FBeepOnError;
      FBeepOnError := aeCell.BeepOnError;
    end;
  end;
end;

procedure TOvcBaseArrayEditor.SetBorderStyle(const Value : TBorderStyle);
  {-set the style used for the border}
begin
  if Value <> FBorderStyle then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

{!!.14} {added}
procedure TOvcBaseArrayEditor.SetFocus;
begin
  if Assigned(aeCell) and not aeCell.Focused then
    inherited SetFocus;
end;

procedure TOvcBaseArrayEditor.SetInsertPushes(Value : Boolean);
  {-set the InsertPushes option}
begin
  if Value <> FInsertPushes then begin
    FInsertPushes := Value;
    if csDesigning in ComponentState then
      Exit;

    if Assigned(aeCell) then begin
      aeCell.InsertPushes := FInsertPushes;
      FInsertPushes := aeCell.InsertPushes;
    end;
  end;
end;

procedure TOvcBaseArrayEditor.SetLineColor(Value : TColor);
  {-set the color used to draw the row divider lines}
begin
  if Value <> FLineColor then begin
    FLineColor := Value;
    Refresh;
  end;
end;

procedure TOvcBaseArrayEditor.SetNumItems(Value : LongInt);
  {-set the number of items in the array}
begin
  if csLoading in ComponentState then
    aeNumRows := Height div FRowHeight;

  if Value >= aeNumRows then
    FNumItems := Value
  else
    FNumItems := aeNumRows;
  aeHighIndex := Pred(FNumItems);

  {reset the scroll bar}
  if HandleAllocated then begin
    aeSetVScrollRange;
    aeSetVScrollPos;
  end;
end;

procedure TOvcBaseArrayEditor.SetPadChar(Value : AnsiChar);
  {-set the character used to pad the end of the edit string}
begin
  if Value <> FPadChar then begin
    FPadChar := Value;
    if csDesigning in ComponentState then
      Exit;

    if Assigned(aeCell) then begin
      aeCell.PadChar := FPadChar;
      FPadChar := aeCell.PadChar;
    end;
  end;
end;

procedure TOvcBaseArrayEditor.SetRangeHi(const Value : string);
  {-set the high field range from a string value}
begin
  aeCell.RangeHi := Value;

  {reassign to get the range from the edit field}
  aeRangeHi := TLocalEF(aeCell).efRangeHi;
end;

procedure TOvcBaseArrayEditor.SetRangeLo(const Value : string);
  {-set the low field range from a string value}
begin
  aeCell.RangeLo := Value;
  {reassign to get the range from the edit field}
  aeRangeLo := TLocalEF(aeCell).efRangeLo;
end;

procedure TOvcBaseArrayEditor.SetReadOnly(Value : Boolean);
  {-set the read only option}
begin
  if Value <> FReadOnly then begin
    FReadOnly := Value;
    if csDesigning in ComponentState then
      Exit;

    if Assigned(aeCell) then begin
      aeCell.ReadOnly := FReadOnly;
      FReadOnly := aeCell.ReadOnly;
    end;
  end;
end;

{!!.10} {added}
procedure TOvcBaseArrayEditor.SetRightAlign(Value : Boolean);
  {-set the RightAlign option}
begin
  if Value <> FRightAlign then begin
    FRightAlign := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseArrayEditor.SetRightJustify(Value : Boolean);
  {-set the RightJustify option}
begin
  if Value <> FRightJustify then begin
    FRightJustify := Value;
    if csDesigning in ComponentState then
      Exit;

    if Assigned(aeCell) then begin
      aeCell.RightJustify := FRightJustify;
      FRightJustify := aeCell.RightJustify;
    end;
  end;
end;

procedure TOvcBaseArrayEditor.SetRowHeight(Value : Integer);
  {-set the cell row height}
begin
  if (Value <> FRowHeight) and (Value > 0) then begin
    FRowHeight := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseArrayEditor.SetTextMargin(Value : Integer);
  {-set the text margin}
begin
  if (Value <> FTextMargin) and (Value >= 2) then begin
    FTextMargin := Value;
    if Assigned(aeCell) then begin
      aeCell.TextMargin := FTextMargin;
      FTextMargin := aeCell.TextMargin;
    end;
    Refresh;
  end;
end;

procedure TOvcBaseArrayEditor.SetTrimBlanks(Value : Boolean);
  {-set the TrimBlanks option}
begin
  if Value <> FTrimBlanks then begin
    FTrimBlanks := Value;
    if csDesigning in ComponentState then
      Exit;

    if Assigned(aeCell) then begin
      aeCell.TrimBlanks := FTrimBlanks;
      FTrimBlanks := aeCell.TrimBlanks;
    end;
  end;
end;

procedure TOvcBaseArrayEditor.SetUseScrollBar(Value : Boolean);
  {-set use of vertical scroll bar}
begin
  if Value <> FUseScrollBar then begin
    FUseScrollBar := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseArrayEditor.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  Msg.Result := 1;  {don't erase background}
end;

procedure TOvcBaseArrayEditor.WMLButtonDown(var Msg : TWMLButtonDown);
var
  Pt : TPoint;
begin
  inherited;
  if (FNumItems > 0) then begin
    GetCursorPos(Pt);
    Pt := ScreenToClient(Pt);
    SetActiveIndex(aeTopIndex+(Pt.Y div FRowHeight));
    {give the edit control the focus}
    aeCell.SetFocus;
  end;
end;

procedure TOvcBaseArrayEditor.WMMouseActivate(var Msg : TWMMouseActivate);
begin
  if csDesigning in ComponentState then
    Exit;

  inherited;
end;

procedure TOvcBaseArrayEditor.WMSetFocus(var Msg : TWMSetFocus);
begin
  inherited;
  {if the focus isn't comming from our child edit cell}
  if Msg.FocusedWnd <> aeCell.Handle then begin
    aePreFocusProcess;

    {give the edit control the focus}
    aeCell.SetFocus;
  end else
    {give the focus to the previous control}
    PostMessage(TForm(GetParentForm(Self)).Handle, WM_NEXTDLGCTL, 1, 0);
end;

procedure TOvcBaseArrayEditor.WMSize(var Msg : TWMSize);
begin
  inherited;
  aeNumRows := ClientHeight div FRowHeight;

  {force num items at least as large as the number of rows}
  if FNumItems < aeNumRows then
    FNumItems := aeNumRows;

  {adjust size of edit field}
  if Assigned(aeCell) then
    aeCell.Width := ClientWidth;

  aeAdjustIntegralHeight;
end;

procedure TOvcBaseArrayEditor.WMVScroll(var Msg : TWMVScroll);
begin
  case Msg.ScrollCode of
    SB_LINEDOWN : SetActiveIndex(FActiveIndex+1);
    SB_LINEUP   : SetActiveIndex(FActiveIndex-1);
    SB_PAGEDOWN : SetActiveIndex(FActiveIndex+Pred(aeNumRows));
    SB_PAGEUP   : SetActiveIndex(FActiveIndex-Pred(aeNumRows));
    SB_THUMBPOSITION,
    SB_THUMBTRACK :
      SetActiveIndex(aeScaleUp(Msg.Pos));
  end;
end;

{!!.13} {added}
function TOvcBaseArrayEditor.WriteCellValue : LongInt;
  {-write the current cell value. return 0 or error code}
begin
  Result := DoPutCellValue;
end;


{*** TOvcSimpleArrayEditor ***}

procedure TOvcSimpleArrayEditor.aeCreateEditCell;
  {-create the edit celll}
begin
  aeCell.Free;
  aeCell := TSimpleCellField.Create(Self);

  TSimpleCellField(aeCell).DataType := aeDataType;
  TSimpleCellField(aeCell).DecimalPlaces := aeDecimalPlaces;
  TSimpleCellField(aeCell).PictureMask := aePictureMask;
  TSimpleCellField(aeCell).MaxLength := aeMaxLength;
end;

function TOvcSimpleArrayEditor.aeGetEditString : PAnsiChar;
  {-return the edit cells edit string}
begin
  Result := TSimpleCellField(aeCell).efEditSt;
end;

procedure TOvcSimpleArrayEditor.aeGetSampleDisplayData(P : PAnsiChar);
  {-cause edit cell to display sample data}
begin
  TSimpleCellField(aeCell).efGetSampleDisplayData(P);
end;

constructor TOvcSimpleArrayEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {set defaults}
  aeDataType    := aeDefSimpleDataType;
  aePictureMask := aeDefSimpleMask;
end;

destructor TOvcSimpleArrayEditor.Destroy;
begin
  aeCell.Free;
  inherited Destroy;
end;

procedure TOvcSimpleArrayEditor.DoGetCellValue(Index : LongInt);
  {-get value for this array index and assign to the edit field}
begin
  aeItemPtr := nil;
  if Assigned(FOnGetItem) and not (csDesigning in ComponentState) then
    FOnGetItem(Self, Index, aeItemPtr);

  if aeItemPtr = nil then
    TSimpleCellField(aeCell).efSetInitialValue
  else begin
    TSimpleCellField(aeCell).SetValue(aeItemPtr^);
    TSimpleCellField(aeCell).efSaveEditString;
  end;
end;

function TOvcSimpleArrayEditor.DoPutCellValue : LongInt;
  {-assign the value of the edit field to the associated variable}
begin
  Result := 0;
  if (aeItemPtr <> nil) then
    Result := TSimpleCellField(aeCell).GetValue(aeItemPtr^);
end;

procedure TOvcSimpleArrayEditor.SetActiveIndex(Value : LongInt);
  {-set the currently selected item}
var
  OldItem  : LongInt;
  Scrolled : Boolean;
  Err      : LongInt;
begin
  if csDesigning in ComponentState then
    Exit;

  {verify valid index}
  if Value < 0 then
    Value := 0
  else if Value > aeHighIndex then
    Value := aeHighIndex;

  if (Value <> FActiveIndex) then begin
    if TSimpleCellField(aeCell).Modified then begin
      {put value of cell field into user var}
      Err := DoPutCellValue;
      if Err <> 0 then begin
        PostMessage(aeCell.Handle, om_ReportError, Err, 0);
        Exit;
      end;
    end;

    TSimpleCellField(aeCell).efCaret.Visible := False;
    TSimpleCellField(aeCell).SetSelection(0, 0);
    TSimpleCellField(aeCell).Update;

    OldItem := FActiveIndex;

    {disable cell painting}
    SendMessage(aeCell.Handle, WM_SETREDRAW, 0, 0);
    try
      FActiveIndex := Value;
      Scrolled := aeMakeItemVisible(Value);

      TSimpleCellField(aeCell).efCaret.Visible := True;
      TSimpleCellField(aeCell).SetSelection(0, 255);

      {get the new pointer and value}
      DoGetCellValue(FActiveIndex);

      {reset horizontal offset}
      TSimpleCellField(aeCell).efHOffset := 0;
    finally
      {allow cell painting}
      SendMessage(aeCell.Handle, WM_SETREDRAW, 1, 0);
    end;

    aeSetVScrollPos;
    aeUpdateDisplay(Scrolled, OldItem, Value);
    DoOnSelect(FActiveIndex);
  end;
end;

procedure TOvcSimpleArrayEditor.SetArrayDataType(Value: TSimpleDataType);
  {-set the data type for this field}
begin
  aeDataType := Value;
  if Assigned(aeCell) then begin
    TSimpleCellField(aeCell).DataType := aeDataType;

    {reset our copies of the edit field properties}
    aeDataType := TSimpleCellField(aeCell).DataType;
    aeMaxLength := TSimpleCellField(aeCell).MaxLength;
    aeDecimalPlaces := TSimpleCellField(aeCell).DecimalPlaces;
    aePictureMask := TSimpleCellField(aeCell).PictureMask;
    aeRangeHi := TLocalEF(aeCell).efRangeHi;
    aeRangeLo := TLocalEF(aeCell).efRangeLo;
  end;
  Refresh;
end;

procedure TOvcSimpleArrayEditor.SetDecimalPlaces(Value : Byte);
  {-set the number of decimal places for the edit field}
begin
  if aeDecimalPlaces <> Value then begin
    aeDecimalPlaces := Value;
    if Assigned(aeCell) then begin
      TSimpleCellField(aeCell).DecimalPlaces := aeDecimalPlaces;

      {reset our copy of the edit field property}
      aeDecimalPlaces := TSimpleCellField(aeCell).DecimalPlaces;
    end;
    Refresh;
  end;
end;

procedure TOvcSimpleArrayEditor.SetMaxLength(Value : Word);
  {-set the maximum length of the edit field}
begin
  if aeMaxLength <> Value then begin
    aeMaxLength := Value;
    if Assigned(aeCell) then begin
      TSimpleCellField(aeCell).MaxLength := aeMaxLength;

      {reset our copy of the edit field property}
      aeMaxLength := TSimpleCellField(aeCell).MaxLength;
    end;
    Refresh;
  end;
end;

procedure TOvcSimpleArrayEditor.SetPictureMask(Value: AnsiChar);
  {-set the picture mask}
begin
  if aePictureMask <> Value then begin
    aePictureMask := Value;
    if Assigned(aeCell) then begin
      TSimpleCellField(aeCell).PictureMask := aePictureMask;

      {reset our copy of the edit field property}
      aePictureMask := TSimpleCellField(aeCell).PictureMask;
    end;
    Refresh;
  end;
end;

{*** TSimpleCellField ***}

constructor TSimpleCellField.Create(AOwner : TComponent);
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

procedure TSimpleCellField.CreateWnd;
begin
  {set controller before window is created}
  Controller := TOvcSimpleArrayEditor(Parent).Controller;
  inherited CreateWnd;

  {assign parent event handlers to the edit cell}
  OnChange         := TOvcSimpleArrayEditor(Parent).OnChange;
  OnClick          := TOvcSimpleArrayEditor(Parent).OnClick;
  OnDblClick       := TOvcSimpleArrayEditor(Parent).OnDblClick;
  OnEnter          := TOvcSimpleArrayEditor(Parent).OnEnter;
  OnError          := TOvcSimpleArrayEditor(Parent).OnError;
  OnExit           := TOvcSimpleArrayEditor(Parent).OnExit;
  OnKeyDown        := TOvcSimpleArrayEditor(Parent).OnKeyDown;
  OnKeyPress       := TOvcSimpleArrayEditor(Parent).OnKeyPress;
  OnKeyUp          := TOvcSimpleArrayEditor(Parent).OnKeyUp;
  OnMouseDown      := TOvcSimpleArrayEditor(Parent).OnMouseDown;
  OnMouseMove      := TOvcSimpleArrayEditor(Parent).OnMouseMove;
  OnMouseUp        := TOvcSimpleArrayEditor(Parent).OnMouseUp;
  OnUserCommand    := TOvcSimpleArrayEditor(Parent).OnUserCommand;
  OnUserValidation := TOvcSimpleArrayEditor(Parent).OnUserValidation;
end;

procedure TSimpleCellField.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd : Word;
begin
  {process keyboard commands}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));
  case Cmd of
    ccUp       :
      Parent.Perform(WM_VSCROLL, SB_LINEUP, 0);
    ccDown     :
      Parent.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    {$IFDEF Win32}
    ccFirstPage:
      Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 0), Parent.Handle);
    ccLastPage :
      Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, High(SmallInt)), Parent.Handle);
    {$ELSE}
    ccFirstPage:
      Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(0, Parent.Handle));
    ccLastPage :
      Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(High(SmallInt), Parent.Handle));
    {$ENDIF}
    ccPrevPage :
      Parent.Perform(WM_VSCROLL, SB_PAGEUP, 0);
    ccNextPage :
      Parent.Perform(WM_VSCROLL, SB_PAGEDOWN, 0);
  else
    inherited;
  end;
end;

procedure TSimpleCellField.WMKillFocus(var Msg : TWMKillFocus);
begin
  {save the current cell value}
  TOvcBaseArrayEditor(Parent).DoPutCellValue;

  inherited;
end;

procedure TSimpleCellField.WMSetFocus(var Msg : TWMSetFocus);
begin
  TOvcBaseArrayEditor(Parent).aePreFocusProcess;
  inherited;
end;


{*** TOvcPictureArrayEditor ***}

procedure TOvcPictureArrayEditor.aeCreateEditCell;
  {-create the edit celll}
begin
  aeCell.Free;
  aeCell := TPictureCellField.Create(Self);

  TPictureCellField(aeCell).DataType := aeDataType;
  TPictureCellField(aeCell).DecimalPlaces := aeDecimalPlaces;
  TPictureCellField(aeCell).Epoch := aeEpoch;
  TPictureCellField(aeCell).PictureMask := aePictureMask;
  TPictureCellField(aeCell).MaxLength := aeMaxLength;
end;

function TOvcPictureArrayEditor.aeGetEditString : PAnsiChar;
  {-return the edit cells edit string}
begin
  Result := TPictureCellField(aeCell).efEditSt;
end;

procedure TOvcPictureArrayEditor.aeGetSampleDisplayData(P : PAnsiChar);
  {-cause edit cell to display sample data}
begin
  TPictureCellField(aeCell).efGetSampleDisplayData(P);
end;

constructor TOvcPictureArrayEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {set defaults}
  aeDataType      := pftString;
  aePictureMask   := aeDefPictureMask;
end;

destructor TOvcPictureArrayEditor.Destroy;
begin
  aeCell.Free;
  inherited Destroy;
end;

procedure TOvcPictureArrayEditor.DoGetCellValue(Index : LongInt);
  {-get value for this array index and assign to the edit field}
begin
  aeItemPtr := nil;
  if Assigned(FOnGetItem) and not (csDesigning in ComponentState) then
    FOnGetItem(Self, Index, aeItemPtr);

  if aeItemPtr = nil then
    TPictureCellField(aeCell).efSetInitialValue
  else begin
    TPictureCellField(aeCell).SetValue(aeItemPtr^);
    TPictureCellField(aeCell).efSaveEditString;
  end;
end;

function TOvcPictureArrayEditor.DoPutCellValue : LongInt;
  {-assign the value of the edit field to the associated variable}
begin
  Result := 0;
  if (aeItemPtr <> nil) then
    Result := TPictureCellField(aeCell).GetValue(aeItemPtr^);
end;

procedure TOvcPictureArrayEditor.SetActiveIndex(Value : LongInt);
  {-set the currently selected item}
var
  OldItem  : LongInt;
  Scrolled : Boolean;
  Err      : LongInt;
begin
  if csDesigning in ComponentState then
    Exit;

  {verify valid index}
  if Value < 0 then
    Value := 0
  else if Value > aeHighIndex then
    Value := aeHighIndex;

  if (Value <> FActiveIndex) then begin
    if TPictureCellField(aeCell).Modified then begin
      {put value of cell field into user var}
      Err := DoPutCellValue;
      if Err <> 0 then begin
        PostMessage(aeCell.Handle, om_ReportError, Err, 0);
        Exit;
      end;
    end;

    TPictureCellField(aeCell).efCaret.Visible := False;
    TPictureCellField(aeCell).SetSelection(0, 0);
    TPictureCellField(aeCell).Update;

    OldItem := FActiveIndex;

    {disable cell painting}
    SendMessage(aeCell.Handle, WM_SETREDRAW, 0, 0);
    try
      FActiveIndex := Value;
      Scrolled := aeMakeItemVisible(Value);

      TPictureCellField(aeCell).efCaret.Visible := True;
      TPictureCellField(aeCell).SetSelection(0, 255);

      {get the new pointer and value}
      DoGetCellValue(FActiveIndex);
      {reset horizontal offset}
      TPictureCellField(aeCell).efHOffset := 0;
    finally
      {allow cell painting}
      SendMessage(aeCell.Handle, WM_SETREDRAW, 1, 0);
    end;

    aeSetVScrollPos;
    aeUpdateDisplay(Scrolled, OldItem, Value);
    DoOnSelect(FActiveIndex);
  end;
end;

procedure TOvcPictureArrayEditor.SetArrayDataType(Value: TPictureDataType);
  {-set the data type for this field}
begin
  aeDataType := Value;
  if Assigned(aeCell) then begin
    TPictureCellField(aeCell).DataType := aeDataType;

    {reset our copies of the edit field properties}
    aeDataType := TPictureCellField(aeCell).DataType;
    aeMaxLength := TPictureCellField(aeCell).MaxLength;
    aeDecimalPlaces := TPictureCellField(aeCell).DecimalPlaces;
    aePictureMask := TPictureCellField(aeCell).PictureMask;
    aeRangeHi := TLocalEF(aeCell).efRangeHi;
    aeRangeLo := TLocalEF(aeCell).efRangeLo;
  end;
  Refresh;
end;

procedure TOvcPictureArrayEditor.SetDecimalPlaces(Value : Byte);
  {-set the number of decimal places for the edit field}
begin
  if aeDecimalPlaces <> Value then begin
    aeDecimalPlaces := Value;
    if Assigned(aeCell) then begin
      TPictureCellField(aeCell).DecimalPlaces := aeDecimalPlaces;

      {reset our copy of the edit field property}
      aeDecimalPlaces := TPictureCellField(aeCell).DecimalPlaces;
    end;
    Refresh;
  end;
end;

procedure TOvcPictureArrayEditor.SetEpoch(Value : Integer);
begin
  if Value <> aeEpoch then begin
    aeEpoch := Value;
    if Assigned(aeCell) then begin
      TPictureCellField(aeCell).Epoch := aeEpoch;

      {reset our copy of the edit field property}
      aeEpoch := TPictureCellField(aeCell).Epoch;
    end;
  end;
end;

procedure TOvcPictureArrayEditor.SetMaxLength(Value : Word);
  {-set the maximum length of the edit field}
begin
  if aeMaxLength <> Value then begin
    aeMaxLength := Value;
    if Assigned(aeCell) then begin
      TPictureCellField(aeCell).MaxLength := aeMaxLength;

      {reset our copy of the edit field property}
      aeMaxLength := TPictureCellField(aeCell).MaxLength;
    end;
    Refresh;
  end;
end;

procedure TOvcPictureArrayEditor.SetPictureMask(const Value : string);
  {-set the picture mask}
begin
  if aePictureMask <> Value then begin
    aePictureMask := Value;
    if Assigned(aeCell) then begin
      TPictureCellField(aeCell).PictureMask := aePictureMask;

      {reset our copy of the edit field properties}
      aePictureMask := TPictureCellField(aeCell).PictureMask;
      aeMaxLength := TPictureCellField(aeCell).MaxLength;
      aeDecimalPlaces := TPictureCellField(aeCell).DecimalPlaces;
    end;
    Refresh;
  end;
end;


{*** TPictureCellField ***}

constructor TPictureCellField.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {assgin edit field properties}
  ParentFont := True;
  ParentColor := True;
  Ctl3D := False;
  ParentCtl3D := False;
  BorderStyle := TBorderStyle(0);
  AutoSize := False;
end;

procedure TPictureCellField.CreateWnd;
begin
  {set controller before window is created}
  Controller := TOvcPictureArrayEditor(Parent).Controller;
  inherited CreateWnd;

  {assign parent event handlers to the edit cell}
  OnChange         := TOvcPictureArrayEditor(Parent).OnChange;
  OnClick          := TOvcPictureArrayEditor(Parent).OnClick;
  OnDblClick       := TOvcPictureArrayEditor(Parent).OnDblClick;
  OnEnter          := TOvcPictureArrayEditor(Parent).OnEnter;
  OnError          := TOvcPictureArrayEditor(Parent).OnError;
  OnExit           := TOvcPictureArrayEditor(Parent).OnExit;
  OnKeyDown        := TOvcPictureArrayEditor(Parent).OnKeyDown;
  OnKeyPress       := TOvcPictureArrayEditor(Parent).OnKeyPress;
  OnKeyUp          := TOvcPictureArrayEditor(Parent).OnKeyUp;
  OnMouseDown      := TOvcPictureArrayEditor(Parent).OnMouseDown;
  OnMouseMove      := TOvcPictureArrayEditor(Parent).OnMouseMove;
  OnMouseUp        := TOvcPictureArrayEditor(Parent).OnMouseUp;
  OnUserCommand    := TOvcPictureArrayEditor(Parent).OnUserCommand;
  OnUserValidation := TOvcPictureArrayEditor(Parent).OnUserValidation;
end;

procedure TPictureCellField.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd : Word;
begin
  {process keyboard commands}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));
  case Cmd of
    ccUp       :
      Parent.Perform(WM_VSCROLL, SB_LINEUP, 0);
    ccDown     :
      Parent.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    {$IFDEF Win32}
    ccFirstPage:
      Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 0), Parent.Handle);
    ccLastPage :
      Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, High(SmallInt)), Parent.Handle);
    {$ELSE}
    ccFirstPage:
      Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(0, Parent.Handle));
    ccLastPage :
      Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(High(SmallInt), Parent.Handle));
    {$ENDIF}
    ccPrevPage :
      Parent.Perform(WM_VSCROLL, SB_PAGEUP, 0);
    ccNextPage :
      Parent.Perform(WM_VSCROLL, SB_PAGEDOWN, 0);
  else
    inherited;
  end;
end;

procedure TPictureCellField.WMKillFocus(var Msg : TWMKillFocus);
begin
  {save the current cell value}
  TOvcBaseArrayEditor(Parent).DoPutCellValue;

  inherited;
end;

procedure TPictureCellField.WMSetFocus(var Msg : TWMSetFocus);
begin
  TOvcBaseArrayEditor(Parent).aePreFocusProcess;

  inherited;
end;


{*** TOvcNumericArrayEditor ***}

procedure TOvcNumericArrayEditor.aeCreateEditCell;
  {-create the edit celll}
begin
  aeCell.Free;
  aeCell := TNumericCellField.Create(Self);

  TNumericCellField(aeCell).DataType := aeDataType;
  TNumericCellField(aeCell).DecimalPlaces := aeDecimalPlaces;
  TNumericCellField(aeCell).PictureMask := aePictureMask;
  TNumericCellField(aeCell).MaxLength := Length(aePictureMask);
end;

function TOvcNumericArrayEditor.aeGetEditString : PAnsiChar;
  {-return the edit cells edit string}
begin
  Result := TNumericCellField(aeCell).efEditSt;
end;

procedure TOvcNumericArrayEditor.aeGetSampleDisplayData(P : PAnsiChar);
  {-cause edit cell to display sample data}
begin
  TNumericCellField(aeCell).efGetSampleDisplayData(P);
end;

constructor TOvcNumericArrayEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {set defaults}
  aeDataType       := aeDefNumericDataType;
  aePictureMask    := aeDefNumericMask;
  aeRangeHi.rtLong := High(LongInt);
  aeRangeLo.rtLong := Low(LongInt);
end;

destructor TOvcNumericArrayEditor.Destroy;
begin
  aeCell.Free;
  inherited Destroy;
end;

procedure TOvcNumericArrayEditor.DoGetCellValue(Index : LongInt);
  {-get value for this array index and assign to the edit field}
begin
  aeItemPtr := nil;
  if Assigned(FOnGetItem) and not (csDesigning in ComponentState) then
    FOnGetItem(Self, Index, aeItemPtr);

  if aeItemPtr = nil then
    TNumericCellField(aeCell).efSetInitialValue
  else begin
    TNumericCellField(aeCell).SetValue(aeItemPtr^);
    TNumericCellField(aeCell).efSaveEditString;
  end;
end;

function TOvcNumericArrayEditor.DoPutCellValue : LongInt;
  {-assign the value of the edit field to the associated variable}
begin
  Result := 0;
  if (aeItemPtr <> nil) then
    Result := TNumericCellField(aeCell).GetValue(aeItemPtr^);
end;

procedure TOvcNumericArrayEditor.SetActiveIndex(Value : LongInt);
  {-set the currently selected item}
var
  OldItem  : LongInt;
  Scrolled : Boolean;
  Err      : LongInt;
begin
  if csDesigning in ComponentState then
    Exit;

  {verify valid index}
  if Value < 0 then
    Value := 0
  else if Value > aeHighIndex then
    Value := aeHighIndex;

  if (Value <> FActiveIndex) then begin
    if TNumericCellField(aeCell).Modified then begin
      {put value of cell field into user var}
      Err := DoPutCellValue;
      if Err <> 0 then begin
        PostMessage(aeCell.Handle, om_ReportError, Err, 0);
        Exit;
      end;
    end;

    TNumericCellField(aeCell).efCaret.Visible := False;
    TNumericCellField(aeCell).SetSelection(0, 0);
    TNumericCellField(aeCell).Update;

    OldItem := FActiveIndex;

    {disable cell painting}
    SendMessage(aeCell.Handle, WM_SETREDRAW, 0, 0);
    try
      FActiveIndex := Value;
      Scrolled := aeMakeItemVisible(Value);

      TNumericCellField(aeCell).efCaret.Visible := True;
      TNumericCellField(aeCell).SetSelection(0, 255);

      {get the new pointer and value}
      DoGetCellValue(FActiveIndex);
      {reset horizontal offset}
      TNumericCellField(aeCell).efHOffset := 0;
    finally
      {allow cell painting}
      SendMessage(aeCell.Handle, WM_SETREDRAW, 1, 0);
    end;

    aeSetVScrollPos;
    aeUpdateDisplay(Scrolled, OldItem, Value);
    DoOnSelect(FActiveIndex);
  end;
end;

procedure TOvcNumericArrayEditor.SetArrayDataType(Value: TNumericDataType);
  {-set the data type for this field}
begin
  aeDataType := Value;
  if Assigned(aeCell) then begin
    TNumericCellField(aeCell).DataType := aeDataType;

    {reset our copies of the edit field properties}
    aeDataType := TNumericCellField(aeCell).DataType;
    aeDecimalPlaces := TNumericCellField(aeCell).DecimalPlaces;
    aePictureMask := TNumericCellField(aeCell).PictureMask;
    aeRangeHi := TLocalEF(aeCell).efRangeHi;
    aeRangeLo := TLocalEF(aeCell).efRangeLo;
  end;
  Refresh;
end;

procedure TOvcNumericArrayEditor.SetPictureMask(const Value : string);
  {-set the picture mask}
begin
  if aePictureMask <> Value then begin
    aePictureMask := Value;
    if Assigned(aeCell) then begin
      TNumericCellField(aeCell).PictureMask := aePictureMask;

      {reset our copies of the edit field properties}
      aePictureMask := TNumericCellField(aeCell).PictureMask;
      aeMaxLength := TNumericCellField(aeCell).MaxLength;
      aeDecimalPlaces := TNumericCellField(aeCell).DecimalPlaces;
    end;
    Refresh;
  end;
end;


{*** TNumericCellField ***}

constructor TNumericCellField.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {assgin edit field properties}
  ParentFont := True;
  ParentColor := True;
  Ctl3D := False;
  ParentCtl3D := False;
  BorderStyle := TBorderStyle(0);
  AutoSize := False;
end;

procedure TNumericCellField.CreateWnd;
begin
  {set controller before window is created}
  Controller := TOvcNumericArrayEditor(Parent).Controller;
  inherited CreateWnd;

  {assign parent event handlers to the edit cell}
  OnClick          := TOvcNumericArrayEditor(Parent).OnClick;
  OnChange         := TOvcNumericArrayEditor(Parent).OnChange;
  OnError          := TOvcNumericArrayEditor(Parent).OnError;
  OnDblClick       := TOvcNumericArrayEditor(Parent).OnDblClick;
  OnEnter          := TOvcNumericArrayEditor(Parent).OnEnter;
  OnKeyDown        := TOvcNumericArrayEditor(Parent).OnKeyDown;
  OnKeyPress       := TOvcNumericArrayEditor(Parent).OnKeyPress;
  OnKeyUp          := TOvcNumericArrayEditor(Parent).OnKeyUp;
  OnExit           := TOvcNumericArrayEditor(Parent).OnExit;
  OnMouseDown      := TOvcNumericArrayEditor(Parent).OnMouseDown;
  OnMouseMove      := TOvcNumericArrayEditor(Parent).OnMouseMove;
  OnMouseUp        := TOvcNumericArrayEditor(Parent).OnMouseUp;
  OnUserCommand    := TOvcNumericArrayEditor(Parent).OnUserCommand;
  OnUserValidation := TOvcNumericArrayEditor(Parent).OnUserValidation;
end;

procedure TNumericCellField.WMKeyDown(var Msg : TWMKeyDown);
var
  Cmd : Word;
begin
  {process keyboard commands}
  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));
  case Cmd of
    ccUp       :
      Parent.Perform(WM_VSCROLL, SB_LINEUP, 0);
    ccDown     :
      Parent.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    {$IFDEF Win32}
    ccFirstPage:
      Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, 0), Parent.Handle);
    ccLastPage :
      Parent.Perform(WM_VSCROLL, MAKELONG(SB_THUMBPOSITION, High(SmallInt)), Parent.Handle);
    {$ELSE}
    ccFirstPage:
      Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(0, Parent.Handle));
    ccLastPage :
      Parent.Perform(WM_VSCROLL, SB_THUMBPOSITION, MAKELONG(High(SmallInt), Parent.Handle));
    {$ENDIF}
    ccPrevPage :
      Parent.Perform(WM_VSCROLL, SB_PAGEUP, 0);
    ccNextPage :
      Parent.Perform(WM_VSCROLL, SB_PAGEDOWN, 0);
  else
    inherited;
  end;
end;

procedure TNumericCellField.WMKillFocus(var Msg : TWMKillFocus);
begin
  {save the current cell value}
  TOvcBaseArrayEditor(Parent).DoPutCellValue;

  inherited;
end;

procedure TNumericCellField.WMSetFocus(var Msg : TWMSetFocus);
begin
  TOvcBaseArrayEditor(Parent).aePreFocusProcess;

  inherited;
end;



end.