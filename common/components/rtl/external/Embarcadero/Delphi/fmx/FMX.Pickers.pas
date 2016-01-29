{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Pickers;

interface

uses
  System.Classes, System.UITypes, System.Generics.Collections, System.SysUtils,
  FMX.Types, FMX.Controls;

type
  TPickerFactoryService = class;

  TDropDownKind = (ddkCustom, ddkNative);

{ TCustomPicker }

  /// <summary>
  ///   Basis for creation of any pickers. Each picker belongs to any control.
  ///   Each picker is able to appear and desappear. Only one picker
  ///   can displayed (other closed).
  /// </summary>
  TCustomPicker = class abstract
  strict private
    FPickerService: TPickerFactoryService;
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    FParent: TControl;
  public
    constructor Create(const APickerService: TPickerFactoryService);
    destructor Destroy; override;
    procedure Show; virtual;
    procedure Hide; virtual; abstract;
    function IsShown: Boolean; virtual;
  public
    property Parent: TControl read FParent write FParent;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;    
  end;

{ TCustomDateTimePicker }

  /// <summary>
  ///   Uses in the <see cref="TCustomDateTimePicker"/> as ShowMode.
  ///   Show mode of DateTime Picker
  ///   <para><c>psmDate</c> - Only Date choice</para>
  ///   <para><c>psmTime</c> - Only Time choice</para>
  ///   <para><c>psmDateTime</c> - Date and Time choice</para>
  /// </summary>
  TDatePickerShowMode = (psmDate, psmTime, psmDateTime);

  TOnDateChanged = procedure (Sender: TObject; const ADateTime: TDateTime) of object;

  /// <summary>
  ///   Picker for choosen date.
  /// </summary>
  TCustomDateTimePicker = class abstract (TCustomPicker)
  strict private
    FDate: TDateTime;
    FFirstDayOfWeek: TCalDayOfWeek;
    FShowMode: TDatePickerShowMode;
    FShowWeekNumbers: Boolean;
    FTodayDefault: Boolean;
    FOnDateChanged: TOnDateChanged;
  public
    property Date: TDateTime read FDate write FDate;
    property FirstDayOfWeek: TCalDayOfWeek read FFirstDayOfWeek write FFirstDayOfWeek;
    property ShowMode: TDatePickerShowMode read FShowMode write FShowMode;
    property ShowWeekNumbers: Boolean read FShowWeekNumbers write FShowWeekNumbers;
    property TodayDefault: Boolean read FTodayDefault write FTodayDefault;
    property OnDateChanged: TOnDateChanged read FOnDateChanged write FOnDateChanged;
  end;

{ TCustomListPicker }

  TOnValueChanged = procedure (Sender: TObject; const AValueIndex: Integer) of object;

  /// <summary>
  ///   Picker for choosen string value from list of strings.
  /// </summary>
  TCustomListPicker = class abstract (TCustomPicker)
  strict private
    FValues: TStrings;
    FCountVisibleItems: Integer;
    FItemIndex: Integer;
    FItemHeight: Single;
    FOnValueChanged: TOnValueChanged;
  protected
    procedure SetValues(AValues: TStrings); virtual;
    procedure SetItemIndex(AValue: Integer); virtual;
  public
    constructor Create(const APickerService: TPickerFactoryService);
    destructor Destroy; override;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property ItemHeight: Single read FItemHeight write FItemHeight;
    property CountVisibleItems: Integer read FCountVisibleItems write FCountVisibleItems;
    property Values: TStrings read FValues write SetValues;
    property OnValueChanged: TOnValueChanged read FOnValueChanged write FOnValueChanged;
  end;

{ Picker Factory Service }

  /// <summary>
  ///   Factory interface for creation picker instance and close all pickers.
  /// </summary>
  IFMXPickerService = interface (IInterface)
    ['{AE1A8D3C-D5FE-4343-A7B0-2AAEDA3ABB8A}']
    function CreateDateTimePicker: TCustomDateTimePicker;
    function CreateListPicker: TCustomListPicker;
    procedure CloseAllPickers;
  end;

  /// <summary>
  ///   Factory of creating pickers: Date Time Picker and List Picker
  /// </summary>
  TPickerFactoryService = class abstract (TInterfacedObject, IFMXPickerService)
  strict private
    FPickers: TList<TCustomPicker>;
  protected
    function DoCreateDateTimePicker: TCustomDateTimePicker; virtual; abstract;
    function DoCreateListPicker: TCustomListPicker; virtual; abstract;
    procedure DoPickerRemoving(const APicker: TCustomPicker); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXPickerService }
    function CreateDateTimePicker: TCustomDateTimePicker;
    function CreateListPicker: TCustomListPicker;
    procedure CloseAllPickers;
  end;

implementation

uses
{$IFDEF IOS}
  FMX.Pickers.iOS;
{$ELSE}
  FMX.Pickers.Default;
{$ENDIF}

{ TCustomListPicker }

constructor TCustomListPicker.Create(const APickerService: TPickerFactoryService);
begin
  inherited Create(APickerService);
  FValues := TStringList.Create;
end;

destructor TCustomListPicker.Destroy;
begin
  FreeAndNil(FValues);
  inherited Destroy;
end;

procedure TCustomListPicker.SetItemIndex(AValue: Integer);
begin
  FItemIndex := AValue;
end;

procedure TCustomListPicker.SetValues(AValues: TStrings);
begin
  FValues.Assign(AValues);
end;

{ TPickerService }

procedure TPickerFactoryService.CloseAllPickers;
var
  Picker: TCustomPicker;
begin
  for Picker in FPickers do
    Picker.Hide;
end;

constructor TPickerFactoryService.Create;
begin
  inherited Create;
  FPickers := TList<TCustomPicker>.Create;
end;

function TPickerFactoryService.CreateDateTimePicker: TCustomDateTimePicker;
begin
  Result := DoCreateDateTimePicker;
  FPickers.Add(Result);
end;

function TPickerFactoryService.CreateListPicker: TCustomListPicker;
begin
  Result := DoCreateListPicker;
  FPickers.Add(Result);
end;

destructor TPickerFactoryService.Destroy;
begin
  FreeAndNil(FPickers);
  inherited Destroy;
end;

procedure TPickerFactoryService.DoPickerRemoving(const APicker: TCustomPicker);
begin
  if Assigned(FPickers) and Assigned(APicker) then
    FPickers.Remove(APicker);
end;

{ TCustomPicker }

constructor TCustomPicker.Create(const APickerService: TPickerFactoryService);
begin
  Assert(Assigned(APickerService), 'APickerService can not be a nil');
  FPickerService := APickerService;
end;

destructor TCustomPicker.Destroy;
begin
  if Assigned(FPickerService) then
    FPickerService.DoPickerRemoving(Self);
  inherited Destroy;
end;

function TCustomPicker.IsShown: Boolean;
begin
  Result := False;
end;

procedure TCustomPicker.Show;
begin
  FPickerService.CloseAllPickers;
end;

initialization
  RegisterPickersService;

end.
