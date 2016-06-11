{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.CalendarEdit.Style;

interface

uses
  System.Classes, FMX.ComboEdit.Style, FMX.Pickers, FMX.CalendarEdit, FMX.Controls.Presentation, FMX.Controls.Model;

type

{ TStyledCalendarEdit }

  TStyledCalendarEdit = class(TStyledComboEdit)
  private
    FDateTimePicker: TCustomDateTimePicker;
    function GetModel: TCalendarEditModel;
  protected
    { Messages From Model}
    procedure MMDateTimeChanged(var AMessage: TDispatchMessage); message MM_DATETIME_CHANGED;
    { Messages From Controller }
    procedure PMClosePicker(var AMessage: TDispatchMessage); message PM_CLOSEPICKER;
  protected
    procedure DoDateChanged(Sender: TObject; const ADate: TDateTime); virtual;
    procedure DoPopupClose(Sender: TObject); virtual;
    procedure DoPopup(Sender: TObject); virtual;
    procedure DoExit; override;
    procedure SetInputSupport(const Value: Boolean);
    procedure Change; override;
    /// <summary>Defines <c>TCalendarEdit</c> model class</summary>
    function DefineModelClass: TDataModelClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DropDown; override;
    procedure ClosePicker;
    function HasPicker: Boolean;
  public
    property Model: TCalendarEditModel read GetModel;
  end;

implementation

uses
  System.SysUtils, System.DateUtils, System.SysConst, FMX.Platform, FMX.Controls, FMX.Text, FMX.Presentation.Factory,
  FMX.Presentation.Style;

{ TStyledCalendarEdit }

procedure TStyledCalendarEdit.Change;
var
  Converted: Boolean;
  TempDateTime: TDateTime;
begin
  if FNeedChange then
  begin
    Converted := TryStrToDate(Text, TempDateTime, FormatSettings);
    TempDateTime := DateOf(TempDateTime);

    Model.DisableNotify;
    try
      if Converted then
        Model.DateTime := TempDateTime
      else
        SetTextInternal(Model.GetFormattedDateTimeText);
    finally
      Model.EnableNotify;
    end;
    RepaintEdit;
  end;
  inherited Change;
end;

procedure TStyledCalendarEdit.ClosePicker;
begin
  if HasPicker and FDateTimePicker.IsShown then
    FDateTimePicker.Hide;
end;

constructor TStyledCalendarEdit.Create(AOwner: TComponent);
var
  PickerService: IFMXPickerService;
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, PickerService) then
  begin
    FDateTimePicker := PickerService.CreateDateTimePicker;
    FDateTimePicker.Parent := Self;
    FDateTimePicker.OnHide := DoPopupClose;
    FDateTimePicker.OnShow := DoPopup;
    FDateTimePicker.OnDateChanged := DoDateChanged;
  end;
end;

function TStyledCalendarEdit.DefineModelClass: TDataModelClass;
begin
  Result := TCalendarEditModel;
end;

destructor TStyledCalendarEdit.Destroy;
begin
  if HasPicker and FDateTimePicker.IsShown then
    FDateTimePicker.Hide;
  FDateTimePicker.DisposeOf;
  FDateTimePicker := nil;
  inherited;
end;

procedure TStyledCalendarEdit.DoDateChanged(Sender: TObject; const ADate: TDateTime);
var
  OldText: string;
begin
  if Model.ReadOnly then
    Exit;

  Model.DateTime := DateOf(ADate);

  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
    begin
      DropDown;
      Exit;
    end;

  OldText := Text;
  SetTextInternal(Model.GetFormattedDateTimeText);
  CaretPosition := Text.Length;

  inherited Change;

  { Live Binding }
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if (OldText <> Text) and TLinkObservers.EditLinkIsEditing(Observers) then
    begin
      TLinkObservers.EditLinkModified(Observers);
      TLinkObservers.EditLinkTrackUpdate(Observers);
    end;
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    if (OldText <> Text) then
    begin
      TLinkObservers.ControlValueModified(Observers);
      TLinkObservers.ControlValueTrackUpdate(Observers);
    end;
end;

procedure TStyledCalendarEdit.DoExit;
begin
  inherited;
  if Model.InputSupport then
    Model.Caret.Visible := True;
  if HasPicker then
    FDateTimePicker.Hide;
end;

procedure TStyledCalendarEdit.DoPopup(Sender: TObject);
begin
  if Assigned(Model.OnPopup) then
    Model.OnPopup(Self);
end;

procedure TStyledCalendarEdit.DoPopupClose(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then
  begin		  
    if Model.InputSupport and (TextService <> nil) then
    begin
      Model.DisableNotify;
      try
        Model.SelStart := TextService.CombinedText.Length;
        Model.SelLength := 0;
      finally
        Model.EnableNotify;
      end;
      Model.Caret.Visible := True;
    end;
    if Assigned(Model.OnClosePopup) then
      Model.OnClosePopup(Self);
  end;
end;

procedure TStyledCalendarEdit.DropDown;
begin
  if HasPicker then
  begin
    if FDateTimePicker.IsShown then
      FDateTimePicker.Hide
    else
    begin
      Model.SelLength := 0;
      if Model.InputSupport then
        Model.Caret.Visible := False;
      { Initialization of date picker before showing }
      FDateTimePicker.Date := Model.DateTime;
      FDateTimePicker.MinDate := Model.MinDate;
      FDateTimePicker.MaxDate := Model.MaxDate;
      FDateTimePicker.ShowMode := TDatePickerShowMode.Date;
      FDateTimePicker.FirstDayOfWeek := Model.FirstDayOfWeek;
      FDateTimePicker.ShowWeekNumbers := Model.ShowWeekNumbers;
      FDateTimePicker.TodayDefault := Model.TodayDefault;
      FDateTimePicker.Show;
    end;
  end;
end;

function TStyledCalendarEdit.GetModel: TCalendarEditModel;
begin
  Result := inherited GetModel<TCalendarEditModel>;
end;

function TStyledCalendarEdit.HasPicker: Boolean;
begin
  Result := FDateTimePicker <> nil;
end;

procedure TStyledCalendarEdit.MMDateTimeChanged(var AMessage: TDispatchMessage);
begin
  SetTextInternal(Model.GetFormattedDateTimeText);
  inherited Change;
end;

procedure TStyledCalendarEdit.PMClosePicker(var AMessage: TDispatchMessage);
begin
  ClosePicker;
end;

procedure TStyledCalendarEdit.SetInputSupport(const Value: Boolean);
var
  OldValue: Boolean;
begin
  OldValue := Model.InputSupport;
  inherited;
  // Default, for same kind of input support we must use other kind of style
  // comboeditstyle and comboboxstyle
  if OldValue <> Value then
    DoStyleChanged;
end;

initialization
{$WARNINGS OFF}
  TPresentationProxyFactory.Current.Register(TCalendarEdit, TControlType.Styled, TStyledPresentationProxy<TStyledCalendarEdit>);
finalization
  TPresentationProxyFactory.Current.Unregister(TCalendarEdit, TControlType.Styled, TStyledPresentationProxy<TStyledCalendarEdit>);
{$WARNINGS ON}
end.
