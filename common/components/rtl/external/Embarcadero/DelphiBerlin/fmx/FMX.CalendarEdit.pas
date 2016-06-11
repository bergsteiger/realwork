{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.CalendarEdit;

interface

uses
  System.UITypes, System.Classes, FMX.Types, FMX.ComboEdit, FMX.Controls.Presentation, FMX.Controls.Model;

const
  MM_DATE_CHANGED = MM_COMBOEDIT_USER + 1;
  MM_WEEK_NUMBERS_CHANGED = MM_COMBOEDIT_USER + 2;
  MM_FIRST_DAY_OF_WEEK_CHANGED = MM_COMBOEDIT_USER + 3;
  MM_DATETIME_CHANGED = MM_COMBOEDIT_USER + 4;
  PM_CLOSEPICKER = PM_COMBOEDIT_USER + 1;

type

{ TCalendarEdit }

  TCalendarEditModel = class(TComboEditModel)
  private
    FFirstDayOfWeek: TCalDayOfWeek;
    FShowWeekNumbers: Boolean;
    FTodayDefault: Boolean;
    FDateTime: TDateTime;
    FMinDate: TDateTime;
    FMaxDate: TDateTime;
    FWeekNumbers: Boolean;
    function GetDate: TDate;
    procedure SetDate(const Value: TDate);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetFirstDayOfWeek(const Value: TCalDayOfWeek);
    procedure SetTodayDefault(const Value: Boolean);
    procedure SetWeekNumbers(const Value: Boolean);
  protected
    function DoValidating(const Value: string): string; override;
  public
    constructor Create; override;
    function GetFormattedDateTimeText: string;
  public
    property Date: TDate read GetDate write SetDate;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property MinDate: TDateTime read FMinDate write FMinDate;
    property MaxDate: TDateTime read FMaxDate write FMaxDate;
    property FirstDayOfWeek: TCalDayOfWeek read FFirstDayOfWeek write SetFirstDayOfWeek;
    property ShowWeekNumbers: Boolean read FShowWeekNumbers write FShowWeekNumbers;
    property TodayDefault: Boolean read FTodayDefault write SetTodayDefault;
    property WeekNumbers: Boolean read FWeekNumbers write SetWeekNumbers;
  end;

  TCustomCalendarEdit = class(TComboEditBase)
  private
    procedure SetDate(const Value: TDate);
    function GetDate: TDate;
    procedure SetDateTime(const Value: TDateTime);
    function GetDateTime: TDateTime;
    procedure SetDateConstraints(const Index: Integer; const Value: TDateTime);
    function GetDateConstraints(const Index: Integer): TDateTime;
    procedure SetFirstDayOfWeek(const Value: TCalDayOfWeek);
    function GetFirstDayOfWeek: TCalDayOfWeek;
    procedure SetShowWeekNumbers(const Value: Boolean);
    function GetShowWeekNumbers: Boolean;
    procedure SetTodayDefault(const Value: Boolean);
    function GetTodayDefault: Boolean;
    procedure SetOnPopup(const Value: TNotifyEvent);
    function GetOnPopup: TNotifyEvent;
    procedure SetOnClosePopup(const Value: TNotifyEvent);
    function GetOnClosePopup: TNotifyEvent;
    function GetModel: TCalendarEditModel; overload;
    function AreDateConstraintsStored(const Index: Integer): Boolean;
  protected
    function DefineModelClass: TDataModelClass; override;
    function DefinePresentationName: string; override;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ClosePicker;
    property Model: TCalendarEditModel read GetModel;
  public
    property Date: TDate read GetDate write SetDate;
    property DateTime: TDateTime read GetDateTime write SetDateTime;
    property MinDate: TDateTime index 1 read GetDateConstraints write SetDateConstraints stored AreDateConstraintsStored;
    property MaxDate: TDateTime index 2 read GetDateConstraints write SetDateConstraints stored AreDateConstraintsStored;
    property TodayDefault: Boolean read GetTodayDefault write SetTodayDefault default False;
    property WeekNumbers: Boolean read GetShowWeekNumbers write SetShowWeekNumbers default False;
    property FirstDayOfWeek: TCalDayOfWeek read GetFirstDayOfWeek write SetFirstDayOfWeek default TCalDayOfWeek.dowLocaleDefault;
    property OnClosePopup: TNotifyEvent read GetOnClosePopup write SetOnClosePopup;
    property OnPopup: TNotifyEvent read GetOnPopup write SetOnPopup;
  end;

  TCalendarEdit = class(TCustomCalendarEdit)
  public
    property Font;
    property TextAlign;
  published
    property Anchors;
    property CanFocus default True;
    property CanParentFocus;
    property Cursor default crDefault;
    property ClipChildren default False;
    property ClipParent default False;
    property Date;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property FirstDayOfWeek;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest default True;
    property InputSupport default False;
    property Locked default False;
    property KeyboardType default TVirtualKeyboardType.NumbersAndPunctuation;
    property Padding;
    property Opacity;
    property Margins;
    property MinDate;
    property MaxDate;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property ReadOnly;
    property Scale;
    property Size;
    property StyleLookup;
    property StyledSettings;
    property ShowHint default False;
    property Text stored False;
    property TextSettings;
    property TodayDefault;
    property Visible default True;
    property WeekNumbers;
    property Width;
    { events }
    property OnClosePopup;
    property OnPopup;
    property OnChange;
    property OnChangeTracking;
    property OnTyping;
    property OnApplyStyleLookup;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end deprecated 'Use TDateEdit instead';

implementation

uses
  System.SysUtils, System.DateUtils, System.Math, FMX.Consts, FMX.CalendarEdit.Style;

{ TCalendarEdit }

procedure TCustomCalendarEdit.ClosePicker;
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_CLOSEPICKER);
end;

constructor TCustomCalendarEdit.Create(AOwner: TComponent);
begin
  inherited;
  CanUseDefaultPresentation := False;
end;

function TCustomCalendarEdit.DefineModelClass: TDataModelClass;
begin
  Result := TCalendarEditModel;
end;

function TCustomCalendarEdit.DefinePresentationName: string;
begin
  Result := 'CalendarEdit-' + GetPresentationSuffix;
end;

function TCustomCalendarEdit.AreDateConstraintsStored(const Index: Integer): Boolean;
begin
  case Index of
    1: Result := SameValue(Model.MinDate, 0.0);
    2: Result := SameValue(Model.MaxDate, 0.0);
  else
    Result := True;
  end;
end;

function TCustomCalendarEdit.GetDate: TDate;
begin
  Result := Model.Date;
end;

function TCustomCalendarEdit.GetDateConstraints(const Index: Integer): TDateTime;
begin
  case Index of
    1: Result := Model.MinDate;
    2: Result := Model.MaxDate;
  else
    Result := Now;
  end;
end;

function TCustomCalendarEdit.GetDateTime: TDateTime;
begin
  Result := Model.DateTime;
end;

function TCustomCalendarEdit.GetDefaultStyleLookupName: string;
begin
  if Model.InputSupport then
    Result := 'comboeditstyle' // do not localize
  else
    Result := 'comboboxstyle'; // do not localize
end;

function TCustomCalendarEdit.GetFirstDayOfWeek: TCalDayOfWeek;
begin
  Result := Model.FirstDayOfWeek;
end;

function TCustomCalendarEdit.GetModel: TCalendarEditModel;
begin
  Result := GetModel<TCalendarEditModel>;
end;

function TCustomCalendarEdit.GetOnClosePopup: TNotifyEvent;
begin
  Result := Model.OnClosePopup;
end;

function TCustomCalendarEdit.GetOnPopup: TNotifyEvent;
begin
  Result := Model.OnPopup;
end;

function TCustomCalendarEdit.GetShowWeekNumbers: Boolean;
begin
  Result := Model.ShowWeekNumbers;
end;

function TCustomCalendarEdit.GetTodayDefault: Boolean;
begin
  Result := Model.TodayDefault;
end;

procedure TCustomCalendarEdit.SetDate(const Value: TDate);
begin
  Model.Date := Value;
end;

procedure TCustomCalendarEdit.SetDateConstraints(const Index: Integer; const Value: TDateTime);
begin
  if (Index = 1) and not SameValue(Model.MaxDate, 0.0) and (Value > Model.MaxDate) then
    raise Exception.CreateFmt(SDateTimeMax, [DateToStr(Model.MaxDate)]);
  if (Index = 2) and not SameValue(Model.MinDate, 0.0) and (Value < Model.MinDate) then
    raise Exception.CreateFmt(SDateTimeMin, [DateToStr(Model.MinDate)]);

  case Index of
    1: Model.MinDate := Value;
    2: Model.MaxDate := Value;
  end;
end;

procedure TCustomCalendarEdit.SetDateTime(const Value: TDateTime);
begin
  Model.DateTime := Value;
end;

procedure TCustomCalendarEdit.SetFirstDayOfWeek(const Value: TCalDayOfWeek);
begin
  Model.FirstDayOfWeek := Value;
end;

procedure TCustomCalendarEdit.SetOnClosePopup(const Value: TNotifyEvent);
begin
  Model.OnClosePopup := Value;
end;

procedure TCustomCalendarEdit.SetOnPopup(const Value: TNotifyEvent);
begin
  Model.OnPopup := Value;
end;

procedure TCustomCalendarEdit.SetShowWeekNumbers(const Value: Boolean);
begin
  Model.ShowWeekNumbers := Value;
end;

procedure TCustomCalendarEdit.SetTodayDefault(const Value: Boolean);
begin
  Model.TodayDefault := Value;
end;

{ TCalendarEditModel }

constructor TCalendarEditModel.Create;
begin
  inherited;
  FMinDate := 0.0;
  FMaxDate := 0.0;
  FFirstDayOfWeek := TCalDayOfWeek.dowLocaleDefault;
  Date := Trunc(Now);
  FilterChar := '0123456789./';
  KeyboardType := TVirtualKeyboardType.NumbersAndPunctuation;
  InputSupport := False;
end;

function TCalendarEditModel.DoValidating(const Value: string): string;
var
  TempDateTime: TDateTime;
begin
  if TryStrToDate(Value, TempDateTime, FormatSettings) then
    TempDateTime := DateOf(TempDateTime) + Time
  else
    TempDateTime := DateTime;
  Result := inherited DoValidating(DateToStr(TempDateTime));
  if TryStrToDate(Result, TempDateTime, FormatSettings) then
    DateTime := DateOf(TempDateTime) + Time;
  Result := DateToStr(TempDateTime);
end;

function TCalendarEditModel.GetDate: TDate;
begin
  Result := DateOf(FDateTime);
end;

function TCalendarEditModel.GetFormattedDateTimeText: string;
begin
  Result := DateToStr(DateTime);
end;

procedure TCalendarEditModel.SetDate(const Value: TDate);
begin
  if Date <> Value then
  begin
    FDateTime := DateOf(Value) + Time;
    Text := GetFormattedDateTimeText;
    inherited Change;
  end;
end;

procedure TCalendarEditModel.SetDateTime(const Value: TDateTime);
begin
  if DateTime <> Value then
  begin
    FDateTime := Value;
    SendMessage(MM_DATETIME_CHANGED);
  end;
end;

procedure TCalendarEditModel.SetFirstDayOfWeek(const Value: TCalDayOfWeek);
begin
  if FFirstDayOfWeek <> Value then
  begin
    FFirstDayOfWeek := Value;
    SendMessage<TCalDayOfWeek>(MM_FIRST_DAY_OF_WEEK_CHANGED, Value);
  end;
end;

procedure TCalendarEditModel.SetTodayDefault(const Value: Boolean);
begin
  FTodayDefault := Value;
  if FTodayDefault then
    DateTime := Now;
end;

procedure TCalendarEditModel.SetWeekNumbers(const Value: Boolean);
begin
  if FWeekNumbers <> Value then
  begin
    FWeekNumbers := Value;
    SendMessage<Boolean>(MM_WEEK_NUMBERS_CHANGED, Value);
  end;
end;

initialization
{$WARNINGS OFF}
  RegisterFmxClasses([TCalendarEdit]);
{$WARNINGS ON}
end.
