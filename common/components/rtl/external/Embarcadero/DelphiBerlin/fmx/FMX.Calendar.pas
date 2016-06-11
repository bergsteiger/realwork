{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Calendar;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, System.Rtti, FMX.Presentation.Messages, FMX.Controls.Presentation,
  FMX.Controls.Model;

const
  MM_DATE_CHANGED = MM_USER + 1;
  MM_WEEKNUMBERS_CHANGED = MM_USER + 2;
  MM_FIRSTDAYOFWEEK_CHANGED = MM_USER + 3;
  MM_CALENDAR_USER = MM_USER + 4;

type

{ TCalendarModel }

  TCalendarModel = class(TDataModel)
  public const
    DefaultCalDayOfWeek = TCalDayOfWeek.dowLocaleDefault;
    DefaultTodayDefault = False;
    DefaultWeekNumbers = False;
  private
    FDate: TDate;
    FFirstDayOfWeek: TCalDayOfWeek;
    FTodayDefault: Boolean;
    FWeekNumbers: Boolean;
    FOnChange: TNotifyEvent;
    FOnDateSelected: TNotifyEvent;
    FOnDayClick: TNotifyEvent;
    procedure SetDate(const Value: TDate);
    procedure SetFirstDayOfWeek(const Value: TCalDayOfWeek);
    procedure SetTodayDefault(const Value: Boolean);
    procedure SetWeekNumbers(const Value: Boolean);
  public
    constructor Create; override;
    property DateTime: TDate read FDate write SetDate;
    property FirstDayOfWeek: TCalDayOfWeek read FFirstDayOfWeek write SetFirstDayOfWeek;
    property TodayDefault: Boolean read FTodayDefault write SetTodayDefault;
    property WeekNumbers: Boolean read FWeekNumbers write SetWeekNumbers;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDateSelected: TNotifyEvent read FOnDateSelected write FOnDateSelected;
    property OnDayClick: TNotifyEvent read FOnDayClick write FOnDayClick;
  end;

{ TCalendar }

  /// <summary>TCustomCalendar is the base class for controls that display a
  /// month calendar.</summary>
  TCustomCalendar = class(TPresentedControl)
  private
    function GetDate: TDate;
    procedure SetDate(Value: TDate);
    function GetDateTime: TDateTime;
    procedure SetDateTime(const Value: TDateTime);
    function GetFirstDayOfWeek: TCalDayOfWeek;
    procedure SetFirstDayOfWeek(const Value: TCalDayOfWeek);
    function GetTodayDefault: Boolean;
    procedure SetTodayDefault(const Value: Boolean);
    function GetWeekNumbers: Boolean;
    procedure SetWeekNumbers(const Value: Boolean);
    function GetOnChange: TNotifyEvent;
    procedure SetOnChange(const Value: TNotifyEvent);
    function GetOnDateSelected: TNotifyEvent;
    procedure SetOnDateSelected(const Value: TNotifyEvent);
    function GetOnDayClick: TNotifyEvent;
    procedure SetOnDayClick(const Value: TNotifyEvent);
    function GetModel: TCalendarModel; overload;
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function GetDefaultSize: TSizeF; override;
    function DefineModelClass: TDataModelClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Model: TCalendarModel read GetModel;
    property DateTime: TDateTime read GetDateTime write SetDateTime;
  public
    /// <summary>Current selected date</summary>
    property Date: TDate read GetDate write SetDate;
    /// <summary>First day of weed.</summary>
    property FirstDayOfWeek: TCalDayOfWeek read GetFirstDayOfWeek write SetFirstDayOfWeek;
    /// <summary>Whether the calendar should take today date as default or not?</summary>
    property TodayDefault: Boolean read GetTodayDefault write SetTodayDefault;
    /// <summary>Shows week numbers?</summary>
    property WeekNumbers: Boolean read GetWeekNumbers write SetWeekNumbers;
    /// <summary>Raises when the value of Date was changed</summary>
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;
    /// <summary>Raises when the user selected day</summary>
    property OnDateSelected: TNotifyEvent read GetOnDateSelected write SetOnDateSelected;
    /// <summary>Raises when the user click on day in days list</summary>
    property OnDayClick: TNotifyEvent read GetOnDayClick write SetOnDayClick;
  end;

  TCalendar = class(TCustomCalendar)
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property ControlType;
    property Cursor default crDefault;
    property Date;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property FirstDayOfWeek default TCalendarModel.DefaultCalDayOfWeek;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TodayDefault default TCalendarModel.DefaultTodayDefault;
    property Visible default True;
    property TouchTargetExpansion;
    property WeekNumbers default TCalendarModel.DefaultWeekNumbers;
    property Width;
    property ParentShowHint;
    property ShowHint;
    { Events }
    property OnApplyStyleLookup;
    property OnChange;
    property OnDateSelected;
    property OnDayClick;
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
    property OnPresentationNameChoosing;
  end;

implementation

uses
  System.SysUtils, System.DateUtils, FMX.Types, FMX.Platform, FMX.BehaviorManager, FMX.Calendar.Style {$IFDEF IOS}, FMX.Calendar.iOS{$ENDIF};

{ TCalendarModel }

constructor TCalendarModel.Create;
begin
  inherited Create;
  FDate := Now;
  FFirstDayOfWeek := DefaultCalDayOfWeek;
  FTodayDefault := DefaultTodayDefault;
  FWeekNumbers := DefaultWeekNumbers;
end;

procedure TCalendarModel.SetDate(const Value: TDate);
begin
  if not SameDate(FDate, Value) then
  begin
    FDate := Value;
    SendMessage<TDateTime>(MM_DATE_CHANGED, Value);
  end;
end;

procedure TCalendarModel.SetFirstDayOfWeek(const Value: TCalDayOfWeek);
begin
  if FFirstDayOfWeek <> Value then
  begin
    FFirstDayOfWeek := Value;
    SendMessage<TCalDayOfWeek>(MM_FIRSTDAYOFWEEK_CHANGED, Value);
  end;
end;

procedure TCalendarModel.SetTodayDefault(const Value: Boolean);
begin
  FTodayDefault := Value;
  if FTodayDefault then
    DateTime := Now;
end;

procedure TCalendarModel.SetWeekNumbers(const Value: Boolean);
begin
  if FWeekNumbers <> Value then
  begin
    FWeekNumbers := Value;
    SendMessage<Boolean>(MM_WEEKNUMBERS_CHANGED, Value);
  end;
end;

{ TCalendar }

constructor TCustomCalendar.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
  CanUseDefaultPresentation := False;
  Width := 180;
  Height := 160;
  CanFocus := True;
  DisableFocusEffect := False;
end;

function TCustomCalendar.DefineModelClass: TDataModelClass;
begin
  Result := TCalendarModel;
end;

function TCustomCalendar.GetModel: TCalendarModel;
begin
  Result := GetModel<TCalendarModel>;
end;

function TCustomCalendar.GetData: TValue;
begin
  Result := TValue.From<TDateTime>(Model.DateTime);
end;

procedure TCustomCalendar.SetData(const Value: TValue);
var
  D: TDateTime;
begin
  if Value.IsType<TDateTime> then
    Date := Value.AsType<TDateTime>
  else if TryStrToDateTime(Value.ToString, D) then
    Date := D;
end;

function TCustomCalendar.GetDate: TDate;
begin
  Result := DateOf(Model.DateTime);
end;

function TCustomCalendar.GetDateTime: TDateTime;
begin
  Result := Model.DateTime;
end;

function TCustomCalendar.GetDefaultSize: TSizeF;
var
  MetricsService: IFMXDefaultMetricsService;
begin
  if (TBehaviorServices.Current.SupportsBehaviorService(IFMXDefaultMetricsService, MetricsService, Self)
    or SupportsPlatformService(IFMXDefaultMetricsService, MetricsService))
    and MetricsService.SupportsDefaultSize(TComponentKind.Calendar) then
    Result := TSizeF.Create(MetricsService.GetDefaultSize(TComponentKind.Calendar))
  else
    Result := TSizeF.Create(202, 180);
end;

function TCustomCalendar.GetFirstDayOfWeek: TCalDayOfWeek;
begin
  Result := Model.FirstDayOfWeek;
end;

function TCustomCalendar.GetOnChange: TNotifyEvent;
begin
  Result := Model.OnChange;
end;

function TCustomCalendar.GetOnDateSelected: TNotifyEvent;
begin
  Result := Model.OnDateSelected;
end;

function TCustomCalendar.GetOnDayClick: TNotifyEvent;
begin
  Result := Model.OnDayClick;
end;

function TCustomCalendar.GetTodayDefault: Boolean;
begin
  Result := Model.TodayDefault;
end;

function TCustomCalendar.GetWeekNumbers: Boolean;
begin
  Result := Model.WeekNumbers;
end;

procedure TCustomCalendar.SetDate(Value: TDate);
begin
  ReplaceTime(TDateTime(Value), Model.DateTime);
  try
    SetDateTime(Value);
  except
    SetDateTime(Model.DateTime);
    raise;
  end;
end;

procedure TCustomCalendar.SetDateTime(const Value: TDateTime);
begin
  Model.DateTime := Value;
end;

procedure TCustomCalendar.SetFirstDayOfWeek(const Value: TCalDayOfWeek);
begin
  Model.FirstDayOfWeek := Value;
end;

procedure TCustomCalendar.SetOnChange(const Value: TNotifyEvent);
begin
  Model.OnChange := Value;
end;

procedure TCustomCalendar.SetOnDateSelected(const Value: TNotifyEvent);
begin
  Model.OnDateSelected := Value;
end;

procedure TCustomCalendar.SetOnDayClick(const Value: TNotifyEvent);
begin
  Model.OnDayClick := Value;
end;

procedure TCustomCalendar.SetTodayDefault(const Value: Boolean);
begin
  Model.TodayDefault := Value;
end;

procedure TCustomCalendar.SetWeekNumbers(const Value: Boolean);
begin
  Model.WeekNumbers := Value;
end;

initialization
  RegisterFmxClasses([TCalendar]);
end.
