{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Calendar.iOS;

interface

{$SCOPEDENUMS ON}

uses
  System.DateUtils, System.TypInfo, System.SysUtils, iOSapi.UIKit, iOSapi.Foundation, iOSapi.CocoaTypes, Macapi.Helpers,
  FMX.Presentation.iOS, FMX.Calendar, FMX.Presentation.Messages, FMX.Controls.Presentation, FMX.Controls.Model;

type

{ TiOSNativeCalendar }

  IFMXUIDatePicker = interface(UIDatePicker)
  ['{E0EA93B8-E2B2-4B02-A832-FAAC42AEA154}']
    { Touches }
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure ValueChanged; cdecl;
  end;

  TiOSNativeCalendar = class(TiOSNativeControl)
  private
    procedure SetDate(const Value: TDateTime);
    function GetDate: TDateTime;
    function GetView: UIDatePicker;
    function GetModel: TCalendarModel;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function DefineModelClass: TDataModelClass; override;
    procedure DoChange; virtual;
    procedure DoDateSelected; virtual;
  protected
    { Messages From Model}
    procedure MMDateChanged(var AMessage: TDispatchMessageWithValue<TDateTime>); message MM_DATE_CHANGED;
    { Messages From Controller }
    procedure PMInit(var AMessage: TDispatchMessage); message PM_INIT;
  public
    constructor Create; override;
    procedure ValueChanged; cdecl;
  public
    property Date: TDateTime read GetDate write SetDate;
    property Model: TCalendarModel read GetModel;
    property View: UIDatePicker read GetView;
  end;

implementation

uses
  Macapi.ObjCRuntime, FMX.Controls, FMX.Presentation.Factory, FMX.Consts;

{ TiOSNativeCalendar }

constructor TiOSNativeCalendar.Create;
begin
  inherited;
  RegisterNativeEventHandler('ValueChanged', UIControlEventValueChanged);
  View.setTimeZone(TNSTimeZone.Wrap(TNSTimeZone.OCClass.timeZoneForSecondsFromGMT(0)));
  View.setDatePickerMode(UIDatePickerModeDate);
  View.setMaximumDate(DateTimeToNSDate(MaxDateTime));
end;

procedure TiOSNativeCalendar.ValueChanged;
var
  OldDay, NewDay: Word;
begin
  OldDay := DayOf(Model.DateTime);
  NewDay := DayOf(Date);
  Model.DisableNotify;
  try
    Model.DateTime := Date;
  finally
    Model.EnableNotify;
  end;
  DoChange;
  if OldDay <> NewDay then
    DoDateSelected;
end;

procedure TiOSNativeCalendar.MMDateChanged(var AMessage: TDispatchMessageWithValue<TDateTime>);
begin
  Date := AMessage.Value;
  DoChange;
end;

function TiOSNativeCalendar.DefineModelClass: TDataModelClass;
begin
  Result := TCalendarModel;
end;

procedure TiOSNativeCalendar.DoChange;
begin
  if Assigned(Model.OnChange) then
    Model.OnChange(Control);
end;

procedure TiOSNativeCalendar.DoDateSelected;
begin
  if Assigned(Model.OnDateSelected) then
    Model.OnDateSelected(Control);
end;

function TiOSNativeCalendar.GetDate: TDateTime;
var
  DateTimeWithoutSec: TDateTime;
begin
  DateTimeWithoutSec := NSDateToDateTime(View.date);
  DateTimeWithoutSec := RecodeSecond(DateTimeWithoutSec, 0);
  DateTimeWithoutSec := RecodeMilliSecond(DateTimeWithoutSec, 0);
  Result := DateTimeWithoutSec;
end;

function TiOSNativeCalendar.GetModel: TCalendarModel;
begin
  Result := inherited GetModel<TCalendarModel>;
end;

function TiOSNativeCalendar.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IFMXUIDatePicker);
end;

function TiOSNativeCalendar.GetView: UIDatePicker;
begin
  Result := inherited GetView<UIDatePicker>;
end;

procedure TiOSNativeCalendar.PMInit(var AMessage: TDispatchMessage);
begin
  Date := Model.DateTime;
end;

procedure TiOSNativeCalendar.SetDate(const Value: TDateTime);
begin
  // Bug in using NSDate in UIDatePicker. When we set time 10:00:00, UIDatePicker shows 9:59:59,
  // but UIDatePicker.date.description shows 10:00:00
  // So we need to add 0.1 sec for it
  View.setDate(DateTimeToNSDate(Value + 0.1 / SecsPerDay), True);
end;

initialization
  TPresentationProxyFactory.Current.Register(TCalendar, TControlType.Platform, TiOSPresentationProxy<TiOSNativeCalendar>);
finalization
  TPresentationProxyFactory.Current.Unregister(TCalendar, TControlType.Platform, TiOSPresentationProxy<TiOSNativeCalendar>);
end.
