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
{*                   OVCCAL.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcCal;
  {-Calendar component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, Menus, Messages, SysUtils,
  OvcBase, OvcCmd, OvcColor, OvcConst, OvcExcpt,
  OvcData, OvcIntl, OvcVer, OvcMisc, STDate;

const
  caDefBorderStyle   = bsSingle;
  caDefDayNameLen    = 3;
  caDefDrawGridLines = True;
  caDefDrawHeader    = True;
  caDefHeaderHeight  = 0;
  caDefHeight        = 130;
  caDefInitialize    = True;
  caDefLineColor     = clSilver;
  caDefParentcolor   = False;
  caDefParentFont    = True;
  caDefReadOnly      = False;
  caDefShortNames    = False;
  caDefTabStop       = True;
  caDefTextMargin    = 2;
  caDefWeekStarts    = Sunday;
  caDefWantDblClicks = True;
  caDefWidth         = 230;

type
  TOvcCalendarColors = class(TPersistent)
  {.Z+}
  protected {private}
    FActiveColors   : TOvcColors; {active cell colors}
    FInactiveColors : TOvcColors; {inactive cell colors}
    FLabelColors    : TOvcColors; {label area colors}
    FTextColors     : TOvcColors; {normal cell colors}
  {.Z-}

  public
    constructor Create;
    destructor Destroy;
      override;

  published
    property ActiveColor   : TOvcColors
      read FActiveColors
      write FActiveColors;

    property InactiveColor : TOvcColors
      read FInactiveColors
      write FInactiveColors;

    property LabelColor    : TOvcColors
      read FLabelColors
      write FLabelColors;

    property TextColor     : TOvcColors
      read FTextColors
      write FTextColors;
  end;

type
  {draw item event}
  TDrawHeaderEvent =
    procedure(Sender : TObject; Month, Year : Integer; const Rect : TRect)
    of object;
  TDrawItemEvent =
    procedure(Sender : TObject; Day, Month, Year : Integer; const Rect : TRect)
    of object;

  TOvcCustomCalendar = class(TOvcBase)
  {.Z+}
  protected {private}
    {property variables}
    FBorderStyle   : TBorderStyle; {border style}
    FColors        : TOvcCalendarColors; {color selection object}
    FDay           : Integer;      {calendar day}
    FDayNameLen    : Byte;         {number of characters for day names}
    FDrawHeader    : Boolean;      {true to draw day name header}
    FDrawGridLines : Boolean;      {true to draw grid lines}
    FHeaderHeight  : Integer;      {height of first row-0 for auto}
    FInitialize    : Boolean;      {true to init date to current}
    FIntlSup       : TOvcIntlSup;  {international date/time support}
    FLineColor     : TColor;       {color for grid lines}
    FMonth         : Integer;      {calendar month}
    FReadOnly      : Boolean;      {true if in read only mode}
    FShortNames    : Boolean;      {true for header to show short names}
    FYear          : Integer;      {calendar year}
    FWantDblClicks : Boolean;      {true to include cs_dblclks style}
    FWeekStarts    : TDayType;     {the day that begins the week}

    {event variables}
    FOnChange     : TNotifyEvent;
    FOnDrawHeader : TDrawHeaderEvent;
    FOnDrawItem   : TDrawItemEvent;
    FOnUserCommand: TUserCommandEvent;

    {internal variables}
    clCalendar    : array[1..42] of Byte;            {current month grid}
    clFirst       : Byte;         {index for first day in current month}
    clLast        : Byte;         {index for last day in current month}
    clMask        : array[0..MaxDateLen] of AnsiChar; {default date mask}
    clRowCol      : array[0..6, 0..6] of TRect;       {cell TRect info}
    clRowCount    : Integer;      {6 if no header, otherwise 7}
    clStartRow    : Integer;                          {first row number}

    {property methods}
    function GetAsDateTime : TDateTime;
      {-returns the date as a Delphi DateTime value}
    function GetCalendarDate : TStDate;
      {-return the currently selected calendar date}
    procedure SetAsDateTime(Value : TDateTime);
      {-sets the date to a Delphi DateTime value}
    procedure SetBorderStyle(Value : TBorderStyle);
      {-change the border style}
    procedure SetCalendarDMY(Day, Month, Year : Integer);
      {-change the currently selected date}
    procedure SetDay(Value : Integer);
      {-set the currently selected day}
    procedure SetDayNameLen(Value : Byte);
      {-set the length of the display day names}
    procedure SetDrawGridLines(Value : Boolean);
      {-set the DrawLines property value}
    procedure SetDrawHeader(Value : Boolean);
      {-set the DrawHeader property value}
    procedure SetHeaderHeight(Value : Integer);
      {-set the height of the frist row}
    procedure SetInitialize(Value : Boolean);
      {-set the Initialize property value}
    procedure SetIntlSupport(Value : TOvcIntlSup);
      {-set the international support object this field will use}
    procedure SetLineColor(Value : TColor);
      {-set the color used to draw the grid lines}
    procedure SetMonth(Value : Integer);
      {-set the calendar month}
    procedure SetShortNames(Value : Boolean);
      {-set the ShortNames property value}
    procedure SetWantDblClicks(Value : Boolean);
      {-set the WantDblClicks property value}
    procedure SetWeekStarts(Value : TDayType);
      {-set which day to begin the week}
    procedure SetYear(Value : Integer);
      {-set the current year}

    {internal methods}
    procedure calColorChanged(AColor: TObject);
      {-a color has changed, refresh display}
    function calGetCurrentRectangle : TRect;
      {-get bounding rectangle for the current calendar day}
    procedure calIncCalendarDate(Months, Years : Integer);
      {-increment the calendar date by Months and Years}
    function calIsDateStored : Boolean;
      {-returns true if the date shoul;d be stored}
    procedure calRebuildCalArray;
      {-recalculate the contents of the calendar array}
    procedure calRecalcSize;
      {-calcualte new sizes for rows and columns}

    {VCL control messages}
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;

    {windows message methods}
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
      message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode);
      message WM_GETDLGCODE;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMMouseActivate(var Msg : TWMMouseActivate);
      message WM_MOUSEACTIVATE;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;
    procedure WMWININICHANGE(var Msg : TWMWinIniChange);
      message WM_WININICHANGE;

  protected
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure Paint;
      override;

    {dynamic event wrappers}
    procedure DoOnChange;
      dynamic;
      {-call the method assigned to the OnChange event}
    procedure DoOnDrawHeader(Month, Year : Integer; const Rect : TRect);
      dynamic;
      {-call the method assigned to the OnDrawHeader event}
    procedure DoOnDrawItem(Day, Month, Year : Integer; const Rect : TRect);
      dynamic;
      {-call the method assigned to the OnDrawItem event}
    procedure DoOnUserCommand(Command : Word);
      dynamic;
      {-call the method assigned to the OnUserCommand event}
    function IsReadOnly : Boolean;
      dynamic;
      {-return true if the calendar is in read-only mode}
    procedure SetCalendarDate(Value : TStDate);
      {-set the calendar display date}
      virtual;
  {.Z-}

    {properties}
    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default caDefBorderStyle;

    property Colors : TOvcCalendarColors
      read FColors
      write FColors;

    property DayNameLen : Byte
      read FDayNameLen
      write SetDayNameLen
      default caDefDayNameLen;

    property DrawGridLines : Boolean
      read FDrawGridLines
      write SetDrawGridLines
      default caDefDrawGridLines;

    property DrawHeader : Boolean
      read FDrawHeader
      write SetDrawHeader
      default caDefDrawHeader;

    property HeaderHeight : Integer
      read FHeaderHeight
      write SetHeaderHeight
      default caDefHeaderHeight;

    property Initialize : Boolean
      read FInitialize
      write SetInitialize
      nodefault;

    property LineColor     : TColor
      read FLineColor
      write SetLineColor
      default caDefLineColor;

    property ReadOnly : Boolean
      read FReadOnly
      write FReadOnly
      default caDefReadOnly;

    property ShortNames : Boolean
      read FShortNames
      write SetShortNames
      default caDefShortNames;

    property WantDblClicks : Boolean
      read FWantDblClicks
      write SetWantDblClicks
      default caDefWantDblClicks;

    property WeekStarts : TDayType
      read FWeekStarts
      write SetWeekStarts
      default caDefWeekStarts;

    {events}
    property OnChange : TNotifyEvent
      read FOnChange
      write FOnChange;

    property OnDrawHeader : TDrawHeaderEvent
      read FOnDrawHeader
      write FOnDrawHeader;

    property OnDrawItem : TDrawItemEvent
      read FOnDrawItem
      write FOnDrawItem;

    property OnUserCommand : TUserCommandEvent
      read FOnUserCommand
      write FOnUserCommand;

  public
    constructor Create(AOwner: TComponent);
      override;
    destructor Destroy;
      override;

    function DateString(const Mask : string): string;
      {-return the date string using the provided mask}
    function DayString : string;
      {-return the Day of week string}
    procedure IncDay(Delta : Integer);
      {-change the day by Delta (signed) days}
    procedure IncMonth(Delta : Integer);
      {-change the month by Delta (signed) months}
    procedure IncYear(Delta : Integer);
      {-change the year by Delta (signed) years}
    function MonthString : string;
      {-return the month string}
    procedure SetToday;
      {-set the calendar to todays date}

    property AsDateTime : TDateTime
      read GetAsDateTime
      write SetAsDateTime;

    property CalendarDate : TStDate
      read GetCalendarDate
      write SetCalendarDate;

    property Canvas;

    property Day : Integer
      read FDay
      write SetDay
      stored calIsDateStored;

    property IntlSupport : TOvcIntlSup
      read FIntlSup
      write SetIntlSupport;

    property Month : Integer
      read FMonth
      write SetMonth
      stored calIsDateStored;

    property Year : Integer
      read FYear
      write SetYear
      stored calIsDateStored;
  end;

  TOvcCalendar = class(TOvcCustomCalendar)
  published
    property Initialize; {must be read before D/M/Y}
    property BorderStyle;
    property Colors;
    property Day;
    property DayNameLen;
    property DrawGridLines;
    property DrawHeader;
    property HeaderHeight;
    property LineColor;
    property Month;
    property ReadOnly;
    property ShortNames;
    property Year;
    property WantDblClicks;
    property WeekStarts;

    property OnChange;
    property OnDrawHeader;
    property OnDrawItem;
    property OnUserCommand;

    {inherited properties}
    property Align;
    property Controller;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop
      default caDefTabStop;
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


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcCalendarColors ***}

constructor TOvcCalendarColors.Create;
begin
  FActiveColors   := TOvcColors.Create(clHighlightText, clHighlight);
  FInactiveColors := TOvcColors.Create(clGrayText,      clWindow);
  FLabelColors    := TOvcColors.Create(clWindowText,    clWindow);
  FTextColors     := TOvcColors.Create(clWindowText,    clWindow);
end;

destructor TOvcCalendarColors.Destroy;
begin
  FActiveColors.Free;
  FInactiveColors.Free;
  FLabelColors.Free;
  FTextColors.Free;
  inherited Destroy;
end;


{*** TOvcCustomCalendar ***}

procedure TOvcCustomCalendar.calColorChanged(AColor : TObject);
  {-a color has changed, refresh display}
begin
  Refresh;
end;

function TOvcCustomCalendar.calGetCurrentRectangle : TRect;
  {-get bounding rectangle for the current date}
var
  Idx  : Integer;
  R, C : Integer;
begin
  {index into the month grid}
  Idx := clFirst + Pred(FDay) + 6;
  R := (Idx div 7);
  C := (Idx mod 7);
  Result := clRowCol[R,C];
end;

procedure TOvcCustomCalendar.calIncCalendarDate(Months, Years : Integer);
  {-increment the calendar date by Months and Years}
var
  NewDate : TStDate;
begin
  NewDate := IncDateTrunc(GetCalendarDate, Months, Years);
  if NewDate <> BadDate then begin
    {make sure that the next and previous months are valid}
    if (IncDateTrunc(NewDate, 1, 0) <> BadDate) and
       (IncDateTrunc(NewDate, -1, 0) <> BadDate) then
      SetCalendarDate(NewDate);
  end;
end;

function TOvcCustomCalendar.calIsDateStored : Boolean;
  {-returns true if the date should be stored}
begin
  Result := not FInitialize;
end;

procedure TOvcCustomCalendar.calRebuildCalArray;
  {-recalculate the contents of the calendar array}
var
  Day1 : TDayType;
  I, J : Integer;
begin
  {get the first day of the current month and year}
  Day1 := DayOfWeek(DMYtoStDate(1, FMonth, FYear, 0));

  {find its index}
  I := Byte(Day1) - Byte(WeekStarts) + 1;
  if I < 1 then
    Inc(I, 7);
  clFirst := I;

  {find the index of the last day in the month}
  clLast := clFirst+DaysInMonth(FMonth, FYear, 0) - 1;

  {initialize the first part of the calendar}
  if FMonth = 1 then
    J := DaysInMonth(12, FYear-1, 0)
  else
    J := DaysInMonth(FMonth-1, FYear, 0);
  for I := clFirst-1 downto 1 do begin
    clCalendar[I] := J;
    Dec(J);
  end;

  {initialize the rest of the calendar}
  J := 1;
  for I := clFirst to 42 do begin
    clCalendar[I] := J;
    if I = clLast then
      J := 1
    else
      Inc(J);
  end;
end;

procedure TOvcCustomCalendar.calRecalcSize;
  {-calcualte new sizes for rows and columns}
var
  R   : Integer;
  C   : Integer;
  Row : array[0..6] of Integer;
  Col : array[0..6] of Integer;
  CH  : Integer;
  TH  : Integer;
  CA  : Integer;

  function SumOf(A : array of Integer; First, Last : Integer) : Integer;
  var
    I : Integer;
  begin
    Result := 0;
    for I := First to Last do
      Result := Result  + A[I];
  end;

begin
  {clear row/col position structure}
  FillChar(clRowCol, SizeOf(clRowCol), #0);

  {store row and column sizes}
  for C := 0 to 6 do
    Col[C] := ClientWidth div 7;
  if FDrawHeader and (FHeaderHeight > 0) then begin
    CH := ClientHeight - FHeaderHeight;
    Row[0] := FHeaderHeight;
    for R := 1 to 6 do
      Row[R] := CH div 6;
  end else begin
    if DrawHeader then begin
      Canvas.Font := Font;
      TH := 2 * Canvas.TextHeight(GetOrphStr(SCTallLowChars)) + caDefTextMargin*3;
      Row[0] := TH;
      CH := ClientHeight - TH;
      for R := 1 to 6 do
        Row[R] := CH div 6;
    end else begin
      CH := ClientHeight;
      for R := clStartRow to 6 do
        Row[R] := CH div clRowCount;
    end;
  end;

  {clear row height for header if we aren't drawing it}
  if not DrawHeader then
    Row[0] := 0;

  {distribute any remaining pixels equally}
  for C := 0 to ClientWidth mod 7 do
    Inc(Col[C]);
  if DrawHeader then
    for R := 1 to CH mod 6 do
      Inc(Row[R])
  else
    for R := clStartRow to CH mod clRowCount do
      Inc(Row[R]);

  {determine cell adjustment based on DrawLine property setting}
  if FDrawGridLines then
    CA := 1
  else
    CA := 0;

  {initialize each cells TRect structure}
  for R := clStartRow to 6 do
    for C := 0 to 6 do begin
      clRowCol[R,C].Left := SumOf(Col, 0, C-1);
      if R = 0 then
        clRowCol[R,C].Right := SumOf(Col, 0, C)
      else
        clRowCol[R,C].Right := SumOf(Col, 0, C) - CA;
      clRowCol[R,C].Top := SumOf(Row, clStartRow, R-1);
      clRowCol[R,C].Bottom := SumOf(Row, clStartRow, R) - CA;
    end;
end;

procedure TOvcCustomCalendar.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  {$ENDIF}

  inherited;
end;

constructor TOvcCustomCalendar.Create(AOwner: TComponent);
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

  Height         := caDefHeight;
  TabStop        := caDefTabStop;
  Width          := caDefWidth;
  ParentColor    := caDefParentColor;
  ParentFont     := caDefParentFont;

  FBorderStyle   := caDefBorderStyle;
  FDayNameLen    := caDefDayNameLen;
  FDrawHeader    := caDefDrawHeader;
  FDrawGridLines := caDefDrawGridLines;
  FHeaderHeight  := caDefHeaderHeight;
  FInitialize    := caDefInitialize;
  FLineColor     := caDefLineColor;
  FReadOnly      := caDefReadOnly;
  FWantDblClicks := caDefWantDblClicks;
  FWeekStarts    := caDefWeekStarts;

  FColors := TOvcCalendarColors.Create;

  {assign color changed notification methods}
  FColors.FActiveColors.OnColorChange := calColorChanged;
  FColors.FInactiveColors.OnColorChange := calColorChanged;
  FColors.FLabelColors.OnColorChange := calColorChanged;
  FColors.FTextColors.OnColorChange := calColorChanged;

  {assign default international support object}
  FIntlSup := OvcIntlSup;

  clRowCount := 7;
  clStartRow := 0;
end;

procedure TOvcCustomCalendar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do begin
    Style := LongInt(Style) or BorderStyles[FBorderStyle];             {!!.D4}

    {set style to reflect desire for double clicks}
    if FWantDblClicks then
      ControlStyle := ControlStyle + [csDoubleClicks]
    else
      ControlStyle := ControlStyle - [csDoubleClicks];
  end;

  {$IFDEF Win32}
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  {$ENDIF}

  {get windows date mask}
  FIntlSup.InternationalLongDatePChar(clMask, FShortNames, False);
end;

procedure TOvcCustomCalendar.CreateWnd;
{$IFDEF TRIALRUN}
var
    X : Integer;
{$ENDIF}
begin
  inherited CreateWnd;
  calRecalcSize;

  {get current day, month, and year}
  if FInitialize or (csDesigning in ComponentState) then
    CalendarDate := CurrentDate;

{$IFDEF TRIALRUN}
  X := _CC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
  X := _VC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
{$ENDIF}
end;

function TOvcCustomCalendar.DateString(const Mask : string): string;
  {-return the date string using the provided mask}
var
  M   : string;
begin
  M := Mask;
  if Length(M) = 0 then
    M := StrPas(clMask);

  {convert calendar month and year to a string}
  Result := FIntlSup.DateToDateString(M, GetCalendarDate, True);
end;

function TOvcCustomCalendar.DayString: string;
  {-return the Day string}
begin
  Result := IntlSupport.DayOfWeekToString(DayOfWeekDMY(FDay, FMonth, FYear, 0));
end;

destructor TOvcCustomCalendar.Destroy;
begin
  FColors.Free;
  inherited Destroy;
end;

procedure TOvcCustomCalendar.DoOnChange;
  {-call the method assigned to the OnChange event}
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TOvcCustomCalendar.DoOnDrawHeader(Month, Year : Integer; const Rect : TRect);
  {-call the method assigned to the OnDrawItem event}
begin
  if Assigned(FOnDrawHeader) then
    FOnDrawHeader(Self, Month, Year, Rect);
end;

procedure TOvcCustomCalendar.DoOnDrawItem(Day, Month, Year : Integer; const Rect : TRect);
  {-call the method assigned to the OnDrawItem event}
begin
  if Assigned(FOnDrawItem) then
    FOnDrawItem(Self, Day, Month, Year, Rect);
end;

procedure TOvcCustomCalendar.DoOnUserCommand(Command : Word);
  {-call the method assigned to the OnUserCommand event}
begin
  if Assigned(FOnUserCommand) then
    FOnUserCommand(Self, Command);
end;

function TOvcCustomCalendar.GetAsDateTime : TDateTime;
  {-returns the date a Delphi DateTime Value}
begin
  Result := StDateToDateTime(CalendarDate);
end;

function TOvcCustomCalendar.GetCalendarDate : TStDate;
  {-return the currently selected date}
begin
  Result := DMYtoStDate(FDay, FMonth, FYear, 0);
end;

function TOvcCustomCalendar.IsReadOnly : Boolean;
begin
  Result := ReadOnly;
end;

procedure TOvcCustomCalendar.IncDay(Delta : Integer);
  {-change the day by Delta (signed) days}
begin
  SetCalendarDate(IncDate(CalendarDate, Delta, 0, 0));
end;

procedure TOvcCustomCalendar.IncMonth(Delta : Integer);
  {-change the month by Delta (signed) months}
begin
  SetCalendarDate(IncDateTrunc(CalendarDate, Delta, 0));
end;

procedure TOvcCustomCalendar.IncYear(Delta : Integer);
  {-change the year by Delta (signed) years}
begin
  SetCalendarDate(IncDateTrunc(CalendarDate, 0, Delta));
end;

function TOvcCustomCalendar.MonthString: string;
  {-return the month string}
begin
  Result := IntlSupport.MonthToString(FMonth);
end;

procedure TOvcCustomCalendar.Paint;
var
  DOW      : TDayType;
  R, C     : Integer;
  I        : Integer;
  FHt      : Integer;
  CurIndex : Integer;
  YDelta   : Integer;
  Metrics  : TTextMetric;
  M, Y     : Integer;
  HR       : TRect;

  procedure DrawLine(X1, Y1, X2, Y2 : Integer);
  begin
    with Canvas do begin
      MoveTo(X1, Y1);
      LineTo(X2, Y2);
    end;
  end;

{$IFDEF Win32}

  procedure DrawAt(Buf : PAnsiChar; R, C : Integer);
  var
    Len    : Integer;
    XDelta : Integer;
    FR     : TRect;
    Size   : TSize;
  begin
    {get bounding rectangle}
    FR := clRowCol[R,C];

    {calculate how to center it}
    Len := StrLen(Buf);

    if GetTextExtentPoint32(Canvas.Handle, Buf, Len, Size) then
      XDelta := (clRowCol[R,C].Right-clRowCol[R,C].Left-1-Size.cX) div 2
    else
      XDelta := 0;

    {draw the string}
    ExtTextOut(Canvas.Handle, FR.Left + XDelta, FR.Top + YDelta,
               ETO_CLIPPED + ETO_OPAQUE, @FR, Buf, Len, nil);
  end;

{$ELSE}

  procedure DrawAt(Buf : PAnsiChar; R, C : Integer);
  var
    Len    : Integer;
    XDelta : Integer;
    FR     : TRect;
  begin
    {get bounding rectangle}
    FR := clRowCol[R,C];

    {calculate how to center it}
    Len := StrLen(Buf);
    XDelta := (clRowCol[R,C].Right-clRowCol[R,C].Left-1 -
               SmallInt(GetTextExtent(Canvas.Handle, Buf, Len))) div 2;
    if XDelta < 0 then
      XDelta := 0;

    {draw the string}
    ExtTextOut(Canvas.Handle, FR.Left + XDelta, FR.Top + YDelta,
               ETO_CLIPPED + ETO_OPAQUE, @FR, Buf, Len, nil);
  end;

{$ENDIF}

  procedure DrawDOW(DOW : TDayType; Col : Integer);
    {-draw a day-of-week name}
  var
    S      : string[255];
    XDelta : Integer;
  begin
    {get the day of week name}
    FillChar(S, SizeOf(S), #32);
    S := IntlSupport.DayOfWeekToString(DOW);

    {truncate the day name}
    S[0] := Chr(DayNameLen);

    {compute the offest needed to center the day name}
    XDelta := (clRowCol[0,Col].Right - clRowCol[0,Col].Left - 1 -
               Canvas.TextWidth(S)) div 2;

    {draw the day name above each column}
    Canvas.TextOut(clRowCol[0,Col].Left+XDelta,
                   clRowCol[0,Col].Bottom - caDefTextMargin - FHt, S);
  end;

  procedure DrawMonthAndYear;
  var
    P : string;
    S : string;
  begin
    {get picture mask for long date}
    P := IntlSupport.InternationalLongDate(FShortNames, False);
    S := IntlSupport.DateToDateString(P, CalendarDate, True);

    {draw the month name and year at the top}
    Canvas.TextOut((ClientWidth-Canvas.TextWidth(S)) div 2, caDefTextMargin, S);
  end;

  procedure DrawDay(R, C, I : Integer; Grayed, Current : Boolean);
  var
    S  : array[0..2] of AnsiChar;
    St : string[10];
  begin
    {select colors}
    if Grayed then begin
      Canvas.Font.Color := FColors.InactiveColor.TextColor;
      Canvas.Brush.Color := FColors.InactiveColor.BackColor;
    end else if Current then begin
      Canvas.Font.Color := FColors.ActiveColor.TextColor;
      Canvas.Brush.Color := FColors.ActiveColor.BackColor;
    end else begin
      Canvas.Font.Color := FColors.TextColor.TextColor;
      Canvas.Brush.Color := FColors.TextColor.BackColor;
    end;

    {convert to a string and draw it centered in its rectangle}
    Str(clCalendar[I], St);
    StrPCopy(S, St);
    DrawAt(S, R, C);
  end;

begin
  with Canvas do begin
    {draw the basic grid}
    Canvas.Brush.Color := FColors.TextColor.BackColor;
    Pen.Color := FLineColor;

    if FDrawGridLines then begin
      {draw horizontal lines}
      for R := clStartRow+1 to 6 do
        DrawLine(0, clRowCol[R,0].Top-1, ClientWidth, clRowCol[R,0].Top-1);

      {draw vertical lines}
      for C := 1 to 6 do
        DrawLine(clRowCol[1,C].Left-1, clRowCol[0,C].Bottom,
                 clRowCol[1,C].Left-1, ClientHeight);
    end;

    {select our font}
    Canvas.Font := Self.Font;

    {determine the height of the font}
    GetTextMetrics(Canvas.Handle, Metrics);
    FHt := Metrics.tmHeight;

    {set label colors}
    Canvas.Font.Color := FColors.LabelColor.TextColor;
    Canvas.Brush.Color := FColors.LabelColor.BackColor;

    if FDrawHeader then begin
      HR := clRowCol[0,0];
      HR.Right := ClientWidth;
      if Assigned(FOnDrawHeader) then
        DoOnDrawHeader(Month, Year, HR)
      else begin
        {determine vertical spacing for header}
        YDelta := Succ(clRowCol[0,0].Bottom-clRowCol[0,0].top-FHt) div 2;
        if YDelta < 0 then
          YDelta := 0;

        {clear header area}
        Canvas.FillRect(HR);

        {draw the month name and year}
        DrawMonthAndYear;

        {draw the column labels}
        I := 0;
        DOW := WeekStarts;
        repeat
          DrawDOW(DOW, I);
          Inc(I);
          if DOW < High(DOW) then
            Inc(DOW)
          else
            DOW := Low(DOW);
        until DOW = WeekStarts;
      end;
    end;

    {determine vertical spacing}
    YDelta := Succ(clRowCol[6,0].Bottom-clRowCol[6,0].top-FHt) div 2;
    if YDelta < 0 then
      YDelta := 0;

    {draw each day}
    CurIndex := clFirst + Pred(FDay);
    I := 1;
    for R := 1 to 6 do
      for C := 0 to 6 do begin
        if Assigned(FOnDrawItem) then begin
          M := Month;
          if I < clFirst then
            Dec(M);
          if I > clLast then
            Inc(M);

          Y := Year;
          if (I < clFirst) and (Month = 1) then begin
            M := 12;
            Dec(Y);
          end;
          if (I > clLast) and (Month = 12) then begin
            M := 1;
            Inc(Y);
          end;

          DoOnDrawItem(clCalendar[I], M, Y, clRowCol[R,C]);
        end else
          DrawDay(R, C, I, (I < clFirst) or (I > clLast), I = CurIndex);
        Inc(I);
      end;
  end;

  if Focused then
    Canvas.DrawFocusRect(calGetCurrentRectangle);
end;

procedure TOvcCustomCalendar.SetAsDateTime(Value : TDateTime);
  {-sets the date to a Delphi DateTime value}
begin
  CalendarDate := DateTimeToStDate(Value);
end;

procedure TOvcCustomCalendar.SetBorderStyle(Value : TBorderStyle);
  {-change the border style}
begin
  if FBorderStyle <> Value then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TOvcCustomCalendar.SetCalendarDate(Value : TStDate);
  {-change the currently selected date}
var
  SaveMonth, SaveYear : Integer;
  R : TRect;
begin
  if (Value = BadDate) or (Value = CalendarDate) or
     (IncDateTrunc(Value, 1, 0) = BadDate) or
     (IncDateTrunc(Value, -1, 0) = BadDate) then
    Exit;

  {invalidate the current cell}
  if HandleAllocated then begin
    R := calGetCurrentRectangle;
    InvalidateRect(Handle, @R, False);
  end;

  {save the current month and year}
  SaveMonth := FMonth;
  SaveYear  := FYear;

  {convert the date to a day, month, and year}
  StDateToDMY(Value, FDay, FMonth, FYear);

  {rebuild calendar array if necessary}
  if (FMonth <> SaveMonth) or (FYear <> SaveYear) then begin
    calRebuildCalArray;
    Invalidate;
  end;

  {invalidate the new cell}
  if HandleAllocated then begin
    R := calGetCurrentRectangle;
    InvalidateRect(Handle, @R, False);

    {invalidate header}
    if DrawHeader then begin
      R := clRowCol[0,0];

      {just the top half}
      R.Bottom := R.Top + (R.Bottom-R.Top) div 2;

      {the full width}
      R.Right := ClientWidth;

      InvalidateRect(Handle, @R, False);
    end;
  end;

  Update;
  DoOnChange;
end;

procedure TOvcCustomCalendar.SetCalendarDMY(Day, Month, Year : Integer);
  {-change the currently selected date}
begin
  if ValidDate(Day, Month, Year, 0) then
    SetCalendarDate(DMYtoStDate(Day, Month, Year, 0));
end;

procedure TOvcCustomCalendar.SetDay(Value : Integer);
  {-set the currently selected day}
begin
  if (Value <> FDay) and ValidDate(Value, FMonth, FYear, 0) then
    SetCalendarDate(DMYtoStDate(Value, FMonth, FYear, 0))
  else if csDesigning in ComponentState then
    {allow invalid day to be set at design-time}
    if (Value > 0) and (Value <= 31) then
      FDay := Value;
end;

procedure TOvcCustomCalendar.SetDayNameLen(Value : Byte);
  {-set the length of the display day names}
begin
  if (Value <> FDayNameLen) and (Value > 0) then begin
    FDayNameLen := Value;
    Repaint;
  end;
end;

procedure TOvcCustomCalendar.SetDrawHeader(Value : Boolean);
  {-set the DrawHeader property value}
begin
  if Value <> FDrawHeader then begin
    FDrawHeader := Value;
    if FDrawHeader then begin
      clStartRow := 0;
      clRowCount := 7
    end else begin
      clStartRow := 1;
      clRowCount := 6;
    end;
    calRecalcSize;
    Refresh;
  end;
end;

procedure TOvcCustomCalendar.SetDrawGridLines(Value : Boolean);
  {-set the DrawLines property value}
begin
  if Value <> FDrawGridLines then begin
    FDrawGridLines := Value;
    calRecalcSize;
    Refresh;
  end;
end;

procedure TOvcCustomCalendar.SetHeaderHeight(Value : Integer);
  {-set the height of the frist row}
begin
  if (Value <> FHeaderHeight) and (Value >= 0) then begin
    FHeaderHeight := Value;
    calRecalcSize;
    Refresh;
  end;
end;

procedure TOvcCustomCalendar.SetInitialize(Value : Boolean);
  {-set the Initialize property value}
begin
  FInitialize := Value;
  if FInitialize then
    CalendarDate := CurrentDate;
end;

procedure TOvcCustomCalendar.SetIntlSupport(Value : TOvcIntlSup);
  {-set the international support object this field will use}
begin
  if Assigned(Value) then
    FIntlSup := Value
  else
    FIntlSup := OvcIntlSup;
end;

procedure TOvcCustomCalendar.SetLineColor(Value : TColor);
  {-set the color used to draw the grid lines}
begin
  if Value <> FLineColor then begin
    FLineColor := Value;
    Refresh;
  end;
end;

procedure TOvcCustomCalendar.SetMonth(Value : Integer);
  {-set the calendar month}
begin
  if (Value <> FMonth) and ValidDate(FDay, Value, FYear, 0) then
    SetCalendarDate(DMYtoStDate(FDay, Value, FYear, 0))
  else if csDesigning in ComponentState then
    {allow invalid month to be set at design-time}
    if (Value > 0) and (Value <= 12) then
      FMonth := Value;
end;

procedure TOvcCustomCalendar.SetToday;
  {-set the calendar to todays date}
begin
  SetCalendarDate(CurrentDate);
end;

procedure TOvcCustomCalendar.SetShortNames(Value : Boolean);
  {-set the ShortNames property value}
begin
  if Value <> FShortNames then begin
    FShortNames := Value;
    {get windows date mask}
    FIntlSup.InternationalLongDatePChar(clMask, FShortNames, False);
    Invalidate;
  end;
end;

procedure TOvcCustomCalendar.SetWantDblClicks(Value : Boolean);
  {-set the WantDblClicks property value}
begin
  if Value <> FWantDblClicks then begin
    FWantDblClicks := Value;
    RecreateWnd;
  end;
end;

procedure TOvcCustomCalendar.SetWeekStarts(Value : TDayType);
  {-set which day to begin the week}
begin
  if Value <> FWeekStarts then begin
    FWeekStarts := Value;
    calRebuildCalArray;
    Repaint;
  end;
end;

procedure TOvcCustomCalendar.SetYear(Value : Integer);
  {-return the currently selected year}
begin
  if (Value <> FYear) and ValidDate(FDay, FMonth, Value, 0) then
    SetCalendarDate(DMYtoStDate(FDay, FMonth, Value, 0))
  else if csDesigning in ComponentState then
    {allow invalid year to be set at design-time}
    if (Value >= MinYear) and (Value <= MaxYear) then
      FYear := Value;
end;

procedure TOvcCustomCalendar.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  if Assigned(FOnDrawItem) then
    Msg.Result := 1  {don't erase background}
  else
    inherited;
end;

procedure TOvcCustomCalendar.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TOvcCustomCalendar.WMKeyDown(var Msg : TWMKeyDown);
var
  D   : TStDate;
  Cmd : Word;
begin
  inherited;

  Cmd := Controller.EntryCommands.Translate(TMessage(Msg));
  D := GetCalendarDate;
  if not IsReadOnly and (Cmd <> ccNone) then begin
    case Cmd of
      ccLeft :
        if D > MinDate then begin
          Dec(D);
          SetCalendarDate(D);
        end;
      ccRight :
        if D < MaxDate then begin
          Inc(D);
          SetCalendarDate(D);
        end;
      ccUp :
        if D-7 >= MinDate then
          SetCalendarDate(D-7);
      ccDown :
        if D+7 <= MaxDate then
          SetCalendarDate(D+7);
      ccHome :
        SetCalendarDMY(1, FMonth, FYear);
      ccEnd :
        SetCalendarDMY(clCalendar[clLast], FMonth, FYear);
      ccPrevPage :
        calIncCalendarDate(-1, 0);
      ccNextPage :
        calIncCalendarDate(+1, 0);
      ccFirstPage :
        calIncCalendarDate(0, -1);
      ccLastPage :
        calIncCalendarDate(0, +1);
    else
      {do user command notification for user commands}
      if Cmd >= ccUserFirst then
        DoOnUserCommand(Cmd);
    end;

    {indicate that this message was processed}
    Msg.Result := 0;
  end;
end;

procedure TOvcCustomCalendar.WMKillFocus(var Msg : TWMKillFocus);
begin
  Canvas.DrawFocusRect(calGetCurrentRectangle);
  inherited;
end;

procedure TOvcCustomCalendar.WMLButtonDown(var Msg : TWMLButtonDown);
var
  R, C   : Integer;
  OldIdx : Integer;
  NewIdx : Integer;
  D      : TStDate;
begin
  inherited;

  if IsReadOnly then
    Exit;

  {calculate the row and column clicked on}
  for R := 1 to 6 do
    for C := 0 to 6 do
      if PtInRect(clRowCol[R,C], Point(Msg.XPos, Msg.YPos)) then begin
        {convert to an index}
        NewIdx := (Pred(R) * 7) + Succ(C);
        OldIdx := clFirst + Pred(FDay);
        if NewIdx <> OldIdx then begin
          {convert to a date and redraw}
          D := GetCalendarDate+(NewIdx-OldIdx);
          if (D >= MinDate) and (D <= MaxDate) then
            SetCalendarDate(D);
        end;
        Break;
      end;
end;

procedure TOvcCustomCalendar.WMMouseActivate(var Msg : TWMMouseActivate);
begin
  if csDesigning in ComponentState then
    Exit;

  inherited;

  SetFocus;
end;

procedure TOvcCustomCalendar.WMSetFocus(var Msg : TWMSetFocus);
begin
  if csDesigning in ComponentState then
    Exit;

  Canvas.DrawFocusRect(calGetCurrentRectangle);

  inherited;
end;

procedure TOvcCustomCalendar.WMSize(var Msg : TWMSize);
begin
  inherited;

  calRecalcSize;
end;

procedure TOvcCustomCalendar.WMWinIniChange(var Msg : TWMWinIniChange);
begin
  inherited;

  if not FIntlSup.AutoUpdate then
    FIntlSup.ResetInternationalInfo;

  Refresh;
end;


end.