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

Version history

12/19/2002

  Hint strings made public

*)

unit ElCalendDlg;

interface

uses
  Windows, Dialogs, SysUtils, Messages, Classes, Graphics, Controls, Forms,
  StdCtrls,
{$ifdef VCL_6_USED}
Types,
{$endif}
  ElCalendarDefs,
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
  ElCalendar,
  ElSpin,
  ElCombos,
  ElBtnCtl,
{$else}
  ComCtrls,
  CommCtrl,
{$endif}
{$ifdef ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$endif}
  ElPopBtn,
  ElPanel,
  ElList,
  ElVCLUtils,
  ElStrUtils,
  ElXPThemedControl,
  TypInfo, ExtCtrls;

type
  TElCalendarForm = class(TForm)
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure TodayBtnClick(Sender : TObject);
    procedure OkBtnClick(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure CancelBtnClick(Sender : TObject);
    procedure CalendarChange(Sender : TObject);
    procedure CalendarClick(Sender: TObject);
    procedure ClearBtnClick(Sender : TObject);
  private
    FOnDeactivate : TNotifyEvent;
    FOnChange : TNotifyEvent;

    procedure WMQueryEndSession(var Message : TMessage); message WM_QueryEndSession;
    procedure WMActivate(var Msg : TWMActivate); message WM_ACTIVATE;
{$ifdef CALENDAR_USE_WINDOWS_CALENDAR}
    procedure WMNotify(var Msg : TWMNotify); message WM_NOTIFY;
{$endif}
  protected
    procedure TriggerChangeEvent; virtual;
  public
    Unassigned : boolean;
    IsModal : boolean;
    TodayBtn: TElPopupButton;
    ClearBtn: TElPopupButton;
    Panel2  : TElPanel;
    Panel3  : TElPanel;
    OkBtn: TElPopupButton;
    CancelBtn: TElPopupButton;
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
    Calendar: TElCalendar;
    Panel1: TElPanel;
    PrevMonBtn: TElPopupButton;
    PrevYearBtn: TElPopupButton;
    NextMonBtn: TElPopupButton;
    NextYearBtn: TElPopupButton;
    YearSpin: TElSpinEdit;
    MonthCombo: TElComboBox;

    procedure PrevYearBtnClick(Sender : TObject);
    procedure PrevMonBtnClick(Sender : TObject);
    procedure MonthComboChange(Sender : TObject);
    procedure NextMonBtnClick(Sender : TObject);
    procedure NextYearBtnClick(Sender : TObject);
    procedure YearSpinChange(Sender : TObject);
{$else}
    Calendar : TMonthCalendar;
{$endif}
    procedure SetNames;
    procedure UpdateLabel;
    destructor Destroy; override;
    constructor CreateNew(AOwner : TComponent; Dummy: Integer); {$ifdef VCL_4_USED}override;{$endif}
  published
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property OnDeactivate : TNotifyEvent read FOnDeactivate write FOnDeactivate;
  end;

type
  TElCalendarDialog = class(TComponent)
  private
    FDate : TDateTime;
    FShowHolidays : Boolean;
    FShowPeriods : Boolean;
    FStartOfWeek : TDayOfWeek;
    FUseCurrentDate : Boolean;
    FShowWeekNum : Boolean;
    FWeekEndDays : TElWeekEndDays;
    FPeriodStart : TDateTime;
    FPeriodLength: Word;
    FPeriodInterval: Word;
    FPeriodColor : TColor;
    FHolidayColor : TColor;
    FWeekEndColor : TColor;
    FUseSystemStartOfWeek: Boolean;
    FHolidays : TElHolidays;

    FOnChange : TNotifyEvent;

    procedure PrepareDialog(FrmDialogComponent : TElCalendarForm);
  protected
    FSelectionBorder: TElFlatBorderType;
    FDayCellBorder: TElFlatBorderType;
    FCurrentDayBorder: TElFlatBorderType;
    FUseLineColors: Boolean;
    FLineColorDark: TColor;
    FLineColorLight: TColor;
    FTranslateDays: Boolean;
    FOnDetermineHoliday: TElHolidayEvent;
    FUseXPThemes: Boolean;

    {$IFDEF ELPACK_USE_STYLEMANAGER}
    FStyleManager: TElStyleManager;
    FStyleName: string;
    {$endif}
    FGridVertLines: Boolean;
    FGridHorzLines: Boolean;
    FGridLineColor: TColor;
    FOnBeforeCellDraw: TBeforeCellDrawEvent;
    FOtherMonthDayColor: TColor;
    FShowOtherMonthDays: Boolean;
    {$ifdef ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    {$endif}
    procedure DefineProperties(Filer : TFiler); override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
        override;
    //FTitleColor : TColor;
    //procedure SetTitleColor(FColor : TColor);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function Execute : boolean;
  published
    property Date : TDateTime read FDate write FDate;
    property ShowHolidays : Boolean read FShowHolidays write FShowHolidays default true;
    property ShowPeriods : Boolean read FShowPeriods write FShowPeriods;
    property StartOfWeek : TDayOfWeek read FStartOfWeek write FStartOfWeek;
    property UseCurrentDate : Boolean read FUseCurrentDate write FUseCurrentDate;
    property ShowWeekNum : Boolean read FShowWeekNum write FShowWeekNum default false;
    property WeekEndDays : TElWeekEndDays read FWeekEndDays write FWeekEndDays;
    property PeriodStart : TDateTime read FPeriodStart write FPeriodStart;
    property PeriodLength: Word read FPeriodLength write FPeriodLength default 1;
    property PeriodInterval: Word read FPeriodInterval write FPeriodInterval
        default 28;
    property PeriodColor : TColor read FPeriodColor write FPeriodColor default clAqua;
    property HolidayColor : TColor read FHolidayColor write FHolidayColor;
    property WeekEndColor : TColor read FWeekEndColor write FWeekEndColor default clBtnText;
    //property TitleColor : TColor read FTitleColor write SetTitleColor default clBtnFace;
    property Holidays : TElHolidays read FHolidays;

    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property UseSystemStartOfWeek: Boolean read FUseSystemStartOfWeek write
        FUseSystemStartOfWeek;
    property SelectionBorder: TElFlatBorderType read FSelectionBorder write
        FSelectionBorder;
    property DayCellBorder: TElFlatBorderType read FDayCellBorder write
        FDayCellBorder;
    property CurrentDayBorder: TElFlatBorderType read FCurrentDayBorder write
        FCurrentDayBorder;
    property UseLineColors: Boolean read FUseLineColors write FUseLineColors;
    property LineColorDark: TColor read FLineColorDark write FLineColorDark;
    property LineColorLight: TColor read FLineColorLight write FLineColorLight;
    property TranslateDays: Boolean read FTranslateDays write FTranslateDays
        default true;
    property OnDetermineHoliday: TElHolidayEvent read FOnDetermineHoliday write
        FOnDetermineHoliday;
    {$ifdef ELPACK_USE_STYLEMANAGER}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    {$endif}
    property UseXPThemes: Boolean read FUseXPThemes write FUseXPThemes default true;
    property GridVertLines: Boolean read FGridVertLines write FGridVertLines
        default true;
    property GridHorzLines: Boolean read FGridHorzLines write FGridHorzLines
        default true;
    property GridLineColor: TColor read FGridLineColor write FGridLineColor default
        clBtnFace;
    property OnBeforeCellDraw: TBeforeCellDrawEvent read FOnBeforeCellDraw write
        FOnBeforeCellDraw;
    property OtherMonthDayColor: TColor read FOtherMonthDayColor write
        FOtherMonthDayColor default clGrayText;
    property ShowOtherMonthDays: Boolean read FShowOtherMonthDays write
        FShowOtherMonthDays default false;
  end;

var ClearCap,
    TodayCap,
    CalendarCap,
    NextYearHint,
    NextMonthHint,
    PrevYearHint,
    PrevMonthHint : TElFString;

implementation

{$ifdef VCL_4_USED}
resourcestring
{$else}
const
{$endif}
  hintNextYear = 'Next year';
  hintPrevYear = 'Previous year';
  hintNextMonth = 'Next month';
  hintPrevMonth = 'Previous month';
  capClear      = 'Clear';
  capToday      = 'Today';
  capCalendar   = 'Calendar';

procedure TElCalendarDialog.PrepareDialog(FrmDialogComponent : TElCalendarForm);
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
var
  ADay, AMonth, AYear : word;
  i : integer;
  PropInfo   : PPropInfo;
{$endif}
begin
  with FrmDialogComponent do
  begin
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
    DecodeDate(Date, AYear, AMonth, ADay);
    Calendar.Day := ADay;
    Calendar.Month := AMonth;
    Calendar.Year := AYear;
    Calendar.ShowHolidays := FShowHolidays;
    Calendar.ShowPeriods := FShowPeriods;
    Calendar.StartOfWeek := FStartOfWeek;
    Calendar.UseSystemStartOfWeek := FUseSystemStartOfWeek;
    Calendar.UseCurrentDate := FUseCurrentDate;
    Calendar.ShowWeekNum := ShowWeekNum;
    Calendar.WeekEndDays := WeekEndDays;
    Calendar.PeriodStart := PeriodStart;
    Calendar.PeriodLength := PeriodLength;
    Calendar.PeriodInterval := PeriodInterval;
    Calendar.PeriodColor := PeriodColor;
    Calendar.HolidayColor := HolidayColor;
    Calendar.WeekEndColor := WeekEndColor;
    Calendar.Holidays.Assign(FHolidays);
    Calendar.SelectionBorder := SelectionBorder;
    Calendar.DayCellBorder := DayCellBorder;
    Calendar.CurrentDayBorder := CurrentDayBorder;
    Calendar.UseLineColors := UseLineColors;
    Calendar.LineColorDark := LineColorDark;
    Calendar.LineColorLight := LineColorLight;
    Calendar.TranslateDays := TranslateDays;
    Calendar.OnDetermineHoliday := OnDetermineHoliday;
    Calendar.GridVertLines := GridVertLines;
    Calendar.GridHorzLines := GridHorzLines;
    Calendar.GridLineColor := GridLineColor;
    Calendar.OnBeforeCellDraw := OnBeforeCellDraw;
    Calendar.ShowOtherMonthDays := ShowOtherMonthDays;
    Calendar.OtherMonthDayColor := OtherMonthDayColor;

{$IFDEF ELPACK_USE_STYLEMANAGER}
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
      if PropInfo <> nil then
        SetObjectProp(Components[i], PropInfo, Self.StyleManager);
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
      if PropInfo <> nil then
        SetStrProp(Components[i], PropInfo, Self.StyleName);
    end;
{$ENDIF}
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i].ClassInfo, 'UseXPThemes');
      if PropInfo <> nil then
        SetOrdProp(Components[i], PropInfo, Ord(UseXPThemes));
    end;

{$else}
    Calendar.Date := Date;
{$endif}
  end;
end;

function TElCalendarDialog.Execute : boolean;
var
  FrmDialogComponent : TElCalendarForm;
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
  ADay, AMonth, AYear : word;
{$endif}
begin
  result := false;
  FrmDialogComponent := TElCalendarForm.CreateNew(self, 0);
  try
    PrepareDialog(FrmDialogComponent);

    FrmDialogComponent.ClearBtn.Visible := false;
    FrmDialogComponent.IsModal := true;
    FrmDialogComponent.OnChange := OnChange;
    if (FrmDialogComponent.ShowModal = mrOk) then
      result := true;

{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
    ADay := FrmDialogComponent.Calendar.Day;
    AMonth := FrmDialogComponent.Calendar.Month;
    AYear := FrmDialogComponent.Calendar.Year;
    FDate := EncodeDate(AYear, AMonth, ADay);
{$else}
    FDate := FrmDialogComponent.Calendar.Date;
{$endif}
  finally
    FrmDialogComponent.Free;
  end;
end;

destructor TElCalendarDialog.Destroy;
begin
  FHolidays.Free;
  inherited Destroy;
end;

constructor TElCalendarDialog.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FHolidays := TElHolidays.Create(nil);
  FShowWeekNum := False;
  FWeekEndDays := [Sat, Sun];
  FWeekEndColor := clBtnText;
  FShowHolidays := True;
  FPeriodLength := 1;
  FPeriodInterval := 28;
  FPeriodColor := clAqua;
  FDate := Now;
  FUseXPThemes := true;
  FTranslateDays := true;
  FGridLineColor := clBtnFace;
  FGridVertLines := true;
  FGridHorzLines := true;
end;

procedure TElCalendarDialog.DefineProperties(Filer : TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('GridLineWidth', FakeInteger, nil, false);
end;

procedure TElCalendarDialog.Notification(AComponent : TComponent; Operation :
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    {$ifdef ELPACK_USE_STYLEMANAGER}
    if AComponent = FStyleManager then
      StyleManager := nil;
    {$endif}
  end;
end;

{$ifdef ELPACK_USE_STYLEMANAGER}
procedure TElCalendarDialog.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FStyleManager <> nil) then
    if not (csDestroying in FStyleManager.ComponentState) then
      FStyleManager.RemoveFreeNotification(Self);
    {$endif}
    FStyleManager := Value;
    if FStyleManager <> nil then
      FStyleManager.FreeNotification(Self);
  end;
end;

procedure TElCalendarDialog.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    FStyleName := Value;
end;

{$endif}

destructor TElCalendarForm.Destroy;
begin
  inherited;
end;

{$ifdef CALENDAR_USE_WINDOWS_CALENDAR}
procedure TElCalendarForm.WMNotify(var Msg : TWMNotify);
begin
  if (Msg.NMHdr.code = MCN_SELECT) then
  begin
    TriggerChangeEvent;
  end;
  inherited;
end;
{$endif}

procedure TElCalendarForm.WMActivate(var Msg : TWMActivate);
begin
  inherited;
  if Msg.Active = WA_INACTIVE then
    if Assigned(FOnDeactivate) then FOnDeactivate(Self);
end;

procedure TElCalendarForm.WMQueryEndSession(var Message : TMessage);
begin
  inherited;
  Message.Result := 1;
end;

procedure TElCalendarForm.TriggerChangeEvent;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TElCalendarForm.SetNames;
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
var
  i : integer;
{$endif}
begin
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
  for i := 1 to 12 do
    MonthCombo.Items.Add(LongMonthNames[i]);
{$endif}
end;

procedure TElCalendarForm.UpdateLabel;
begin
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
  MonthCombo.ItemIndex := Calendar.Month - 1;
  YearSpin.Value := Calendar.Year;
{$endif}
end;

{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
procedure TElCalendarForm.PrevYearBtnClick(Sender : TObject);
begin
  Calendar.Year := Calendar.Year - 1;
  UpdateLabel;
end;

procedure TElCalendarForm.PrevMonBtnClick(Sender : TObject);
begin
  if Calendar.Month = 1 then
  begin
    Calendar.Month := 12;
    Calendar.Year := Calendar.Year - 1;
  end
  else
    Calendar.Month := Calendar.Month - 1;
  UpdateLabel;
end;
{$ENDIF}

procedure TElCalendarForm.FormCreate(Sender : TObject);
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
var Bmp : TBitmap;
{$endif}
begin
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
  Calendar := TElCalendar.Create(Self);
{$else}
  Calendar := TMonthCalendar.Create(Self);
{$endif}
  with Calendar do
  begin
    Parent := Self;
    Left := 0;
    Top := 22;
    Width := 194;
    Height := 100;

{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
    Align := alClient;
    StartOfWeek := 0;
    WeekEndDays := [Sun, Sat];
    WeekEndColor := clRed;
    ShowPeriods := False;
    HolidayColor := clBlack;
    ActiveBorderType := fbtNone;
    InactiveBorderType := fbtNone;
    BorderStyle := bsNone;
    UserNavigation := False;
    LineColorDark := clWindow;
{$endif}
    TabOrder := 1;
    OnClick := CalendarClick;
    OnChange := CalendarChange;
{$IFDEF VCL_4_USED}
    DockOrientation := doNoOrient;
    DoubleBuffered := False;
{$ENDIF}
  end;
  Panel2 := TElPanel.Create(Self);
  Panel3 := TElPanel.Create(Self);
  TodayBtn := TElPopupButton.Create(Self);
  ClearBtn := TElPopupButton.Create(Self);
  OkBtn := TElPopupButton.Create(Self);
  CancelBtn := TElPopupButton.Create(Self);
  with Panel2 do
  begin
    Parent := Self;
    Left := 0;
    Top := 143;
    Width := 194;
    Height := 30;
    Align := alBottom;
    BevelOuter := bvNone;
    TabOrder := 0;
  end;
  with Panel3 do
  begin
    Parent := Self;
    Left := 0;
    Top := 142;
    Width := 194;
    Height := 23;
    Align := alBottom;
    BevelOuter := bvNone;
    TabOrder := 1;
  end;
  with TodayBtn do
  begin
    Parent := Panel3;
    Left := 2;
    Top := 0;
    Width := 75;
    Height := 23;
    Cursor := crDefault;
    ImageIndex := 0;
    DrawDefaultFrame := False;
    PopupPlace := ppRight;
    {$ifdef HAS_HTML_RENDER}
    LinkStyle := [fsUnderline];
    {$endif}
    NumGlyphs := 1;
    Caption := TodayCap;
    TabOrder := 0;
    OnClick := TodayBtnClick;
    {$ifdef CAENDAR_USE_WINDOWS_CALENDAR}
    Visible := false;
    {$endif}
  end;
  with ClearBtn do
  begin
    Parent := Panel3;
    Left := 79;
    Top := 0;
    Width := 75;
    Height := 23;
    Cursor := crDefault;
    ImageIndex := 0;
    DrawDefaultFrame := False;
    PopupPlace := ppRight;
    {$ifdef HAS_HTML_RENDER}
    LinkStyle := [fsUnderline];
    {$endif}
    NumGlyphs := 1;
    Caption := ClearCap;
    TabOrder := 1;
    Color := clBtnFace;
    Flat := true;
    ParentColor := False;
    OnClick := ClearBtnClick;
    {$ifdef CALENDAR_USE_WINDOWS_CALENDAR}
    Visible := false;
    {$endif}
  end;
  with OkBtn do
  begin
    Parent := Panel2;
    Left := 61;
    Top := 4;
    Width := 65;
    Height := 23;
    Cursor := crDefault;
    ImageIndex := 0;
    DrawDefaultFrame := False;
    PopupPlace := ppRight;
    Default := True;
    ModalResult := 1;
    {$ifdef HAS_HTML_RENDER}
    LinkStyle := [fsUnderline];
    {$endif}
    NumGlyphs := 1;
    Caption := 'OK';
    TabOrder := 1;
    Color := clBtnFace;
    ParentColor := False;
    OnClick := OkBtnClick;
  end;
  with CancelBtn do
  begin
    Parent := Panel2;
    Left := 128;
    Top := 4;
    Width := 65;
    Height := 23;
    Cursor := crDefault;
    ImageIndex := 0;
    DrawDefaultFrame := False;
    PopupPlace := ppRight;
    Cancel := True;
    ModalResult := 2;
    {$ifdef HAS_HTML_RENDER}
    LinkStyle := [fsUnderline];
    {$endif}
    NumGlyphs := 1;
    Caption := 'Cancel';
    TabOrder := 2;
    Color := clBtnFace;
    ParentColor := False;
    OnClick := CancelBtnClick;
  end;
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
  Panel1 := TElPanel.Create(Self);
  PrevMonBtn := TElPopupButton.Create(Self);
  PrevYearBtn := TElPopupButton.Create(Self);
  NextMonBtn := TElPopupButton.Create(Self);
  NextYearBtn := TElPopupButton.Create(Self);
  YearSpin := TElSpinEdit.Create(Self);
  MonthCombo := TElComboBox.Create(Self);
  with Panel1 do
  begin
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 194;
    Height := 21;
    Align := alTop;
    BevelOuter := bvNone;
    TabOrder := 0;
  end;
  Bmp := TBitmap.Create;
  Bmp.Width := 10;
  Bmp.Height := 8;
  Bmp.PixelFormat := pf1Bit;
  try
    with PrevMonBtn do
    begin
      Parent := Panel1;
      Left := 14;
      Top := 0;
      Width := 14;
      Height := 21;
      Hint := PrevMonthHint;
      ImageIndex := 0;
      Flat := true;
      DrawArrow(Bmp.Canvas, eadLeft, Rect(0,0,10,8), clBtnText, true);
      Glyph.Assign(Bmp);
      ShowText := false;
      ShowGlyph := true;
      ShowFocus := False;
      TextDrawType := tdtNormal;
      Transparent := False;
      TabStop := False;
      TabOrder := 0;
      ThinFrame := true;
      Align := alLeft;
      OnClick := PrevMonBtnClick;
    end;
    with PrevYearBtn do
    begin
      Parent := Panel1;
      Left := 0;
      Top := 0;
      Width := 14;
      Height := 22;
      Hint := PrevYearHint;
      ImageIndex := 0;
      Flat := true;
      Bmp.Assign(nil);
      Bmp.Width := 10;
      Bmp.Height := 8;
      DrawArrow(Bmp.Canvas, eadLeft, Rect(2,0,10,8), clBtnText, true);
      DrawArrow(Bmp.Canvas, eadLeft, Rect(-2,0,6,8), clBtnText, true);
      Glyph := Bmp;
      ShowText := false;
      ShowGlyph := true;
      ShowFocus := False;
      TextDrawType := tdtNormal;
      Transparent := False;
      TabStop := False;
      TabOrder := 1;
      ThinFrame := true;
      Align := alLeft;
      OnClick := PrevYearBtnClick;
    end;
    with NextMonBtn do
    begin
      Parent := Panel1;
      Left := 166;
      Top := 0;
      Width := 14;
      Height := 21;
      Hint := NextMonthHint;
      ImageIndex := 0;
      Flat := true;
      Bmp.Assign(nil);
      Bmp.Width := 10;
      Bmp.Height := 8;
      DrawArrow(Bmp.Canvas, eadRight, Rect(0,0,10,8), clBtnText, true);
      Bmp.Transparent := true;
      Glyph := Bmp;
      ShowText := false;
      ShowGlyph := true;
      ShowFocus := False;
      TextDrawType := tdtNormal;
      Transparent := False;
      TabStop := False;
      TabOrder := 2;
      ThinFrame := true;
      Align := alRight;
      OnClick := NextMonBtnClick;
    end;
    with NextYearBtn do
    begin
      Parent := Panel1;
      Left := 180;
      Top := 0;
      Width := 14;
      Height := 21;
      Hint := NextYearHint;
      ImageIndex := 0;
      Flat := true;
      Bmp.Assign(nil);
      Bmp.Width := 10;
      Bmp.Height := 8;
      DrawArrow(Bmp.Canvas, eadRight, Rect(0,0,6,8), clBtnText, true);
      DrawArrow(Bmp.Canvas, eadRight, Rect(4,0,10,8), clBtnText, true);
      Glyph := Bmp;
      ShowText := false;
      ShowGlyph := true;
      ShowFocus := False;
      TextDrawType := tdtNormal;
      Transparent := False;
      TabStop := False;
      TabOrder := 3;
      ThinFrame := true;
      Align := alRight;
      OnClick := NextYearBtnClick;
    end;
  finally
    Bmp.Free;
  end;
  with YearSpin do
  begin
    Parent := Panel1;
    Left := 109;
    Top := 0;
    Width := 57;
    Height := 21;
    Value := 1;
    MaxValue := 4636;
    MinValue := 1;
    Increment := 1;
    LargeIncrement := 10;
    Align := alRight;
    AutoSize := False;
    Ctl3D := True;
    Flat := True;
    Color := clBtnFace;
    ButtonThinFrame := true;
    //InactiveBorderType := fbtColorLineBorder;
    //ActiveBorderType := fbtColorLineBorder;
    LineBorderActiveColor := clBtnFace;
    LineBorderInactiveColor := clBtnFace;
    ButtonFlat := true;
    BorderStyle := bsNone;
    ParentCtl3D := False;
    ButtonThinFrame := true;
    TabOrder := 5;
    OnChange := YearSpinChange;
  end;
  with MonthCombo do
  begin
    Parent := Panel1;
    Left := 28;
    Top := 0;
    Width := 81;
    Height := 21;
    Style := csDropDownList;
    DropDownCount := 12;
    Font := Panel1.Font;
    // Dropdownlist should use this color
    ListColor := clBtnFace;
    ItemHeight := 13;
    ParentFont := False;
    TabOrder := 4;
    OnChange := MonthComboChange;
    Align := alClient;
    Flat := True;
    ButtonFlat := true;
    ButtonThinFrame := true;
    Color := clBtnFace;
    ActiveBorderType := fbtNone;
    InactiveBorderType := fbtNone;
    //BorderStyle := bsSingle;
  end;
{$ENDIF}

  SetNames;
end;

{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
procedure TElCalendarForm.MonthComboChange(Sender : TObject);
begin
  if (MonthCombo.ItemIndex >= 0) and (MonthCombo.ItemIndex < 12) then
    Calendar.Month := MonthCombo.ItemIndex + 1;
end;

procedure TElCalendarForm.NextMonBtnClick(Sender : TObject);
begin
  if Calendar.Month = 12 then
  begin
    Calendar.Month := 1;
    Calendar.Year := Calendar.Year + 1;
  end
  else
    Calendar.Month := Calendar.Month + 1;
  UpdateLabel;
end;

procedure TElCalendarForm.NextYearBtnClick(Sender : TObject);
begin
  Calendar.Year := Calendar.Year + 1;
  UpdateLabel;
end;

procedure TElCalendarForm.YearSpinChange(Sender : TObject);
var
  FSaveYear : integer;
begin
  FSaveYear := Calendar.Year;
  try
    Calendar.Year := Trunc(YearSpin.Value);
  except
    Calendar.Year := FSaveYear;
    raise Exception.Create('The entered year is invalid');
  end;
end;
{$ENDIF}

procedure TElCalendarForm.FormShow(Sender : TObject);
begin
{$ifdef CALENDAR_USE_WINDOWS_CALENDAR}
  Calendar.SetBounds(0, 0, 0, 0);
  Height := Calendar.Height + GetSystemMetrics(SM_CYEDGE) * 2;
  Width := Calendar.Width + GetSystemMetrics(SM_CXEDGE) * 2;
{$endif}
  UpdateLabel;
end;

procedure TElCalendarForm.TodayBtnClick(Sender : TObject);
var
  Time : TSystemTime;
begin
  DateTimeToSystemTime(Now, Time);
{$ifdef CALENDAR_USE_WINDOWS_CALENDAR}
  Calendar.Date := Now;
{$else}
  Calendar.Day := Time.wDay;
  Calendar.Month := Time.wMonth;
  Calendar.Year := Time.wYear;
{$endif}
  UpdateLabel;
end;

procedure TElCalendarForm.OkBtnClick(Sender : TObject);
begin
  if not IsModal then Close;
end;

procedure TElCalendarForm.FormClose(Sender : TObject;
  var Action : TCloseAction);
begin
  Action := caHide;
  //Action := caFree;
end;

procedure TElCalendarForm.CancelBtnClick(Sender : TObject);
begin
  if not IsModal then Close;
end;

procedure TElCalendarForm.CalendarChange(Sender : TObject);
begin
  UpdateLabel;
end;

procedure TElCalendarForm.CalendarClick(Sender: TObject);
begin
{$ifndef CALENDAR_USE_WINDOWS_CALENDAR}
  TriggerChangeEvent;
{$endif}
end;

constructor TElCalendarForm.CreateNew(AOwner : TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner(* {$ifdef VCL_4_USED}, Dummy{$endif}*));
  {$ifndef VCL_4_USED}FormCreate(nil);{$endif}
  Width := 202;
  Height := 200;
  BorderIcons := [biSystemMenu];
  BorderStyle := bsSizeToolWin;
  Caption := CalendarCap;
  KeyPreview := True;
  Position := poScreenCenter;
  ShowHint := True;
  OnClose := FormClose;
  OnCreate := FormCreate;
  OnShow := FormShow;
end;

procedure TElCalendarForm.ClearBtnClick(Sender : TObject);
begin
  Unassigned := true;
  TriggerChangeEvent;
end;

initialization
  NextYearHint := hintNextYear;
  NextMonthHint := hintNextMonth;
  PrevYearHint := hintPrevYear;
  PrevMonthHint := hintPrevMonth;
  ClearCap := capClear;
  TodayCap := capToday;
  CalendarCap := capCalendar;

finalization

end.
