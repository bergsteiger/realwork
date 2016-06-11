{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.DateTimeCtrls;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Generics.Collections, System.Types, System.UITypes, FMX.Types, FMX.TextLayout, FMX.Controls,
  FMX.StdCtrls, FMX.VirtualKeyboard, FMX.Menus, FMX.Platform, FMX.Graphics, FMX.Pickers, FMX.DateTimeCtrls.Types;

type

{ TTimeEdit }

  TDTFormatKind = (Short, Long);
  TDTTimeFormat = TDTFormatKind deprecated 'Use TDTFormatKind instead';
  TDTFormatKindHelper = record helper for TDTFormatKind
  const
    dfShort = TDTFormatKind.Short deprecated 'Use TDTFormatKind.Short';
    dfLong = TDTFormatKind.Long deprecated 'Use TDTFormatKind.Long';
  end;

  TCustomDateTimeEdit = class(TTextControl, IReadOnly, IVirtualKeyboardControl)
  private
    const UnknowFormatPart = -1;
  private
    FDTFormatter: TDateTimeFormatter;
    FReadOnly: Boolean;
    FShowCheckBox: Boolean;
    FShowClearButton: Boolean;
    FIsChecked: Boolean;
    FIsPressed: Boolean;
    FIsEmpty: Boolean;
    { Virtual Keyboard }
    FSupportKeyboardInput: Boolean;
    FKeyboardType : TVirtualkeyboardType;
    FReturnKeyType: TReturnKeyType;
    FKeyboardService: IFMXVirtualKeyboardService;
    { DateTime Formatting }
    FCustomFormat: string;
    FFormatKind: TDTFormatKind;
    { Painting }
    FSelectionFill: TBrush;
    FTextLayout: TTextLayout;
    { Style Objects }
    FCheck: TCheckBox;
    FClearButton: TControl;
    { Events }
    FOnCheckChanged: TNotifyEvent;
    FOnOpenPicker: TNotifyEvent;
    FOnClosePicker: TNotifyEvent;
    FOnDateTimeChanged: TNotifyEvent;
    procedure SetDateTime(const Value: TDateTime);
    function GetDateTime: TDateTime;
    function GetDate: TDate;
    function GetTime: TTime;
    procedure SetCustomFormat(const Value: string);
    procedure SetIndexFormatPart(const Value: Integer);
    procedure SetShowCheckBox(const Value: Boolean);
    procedure SetShowClearButton(const Value: Boolean);
    procedure SetIsChecked(const Value: Boolean);
    procedure SetIsEmpty(const Value: Boolean);
    { IVirtualKeyboardControl }
    function GetKeyboardType: TVirtualKeyboardType;
    procedure SetKeyboardType(Value: TVirtualKeyboardType);
    procedure SetReturnKeyType(Value: TReturnKeyType);
    function GetReturnKeyType: TReturnKeyType;
    function IsPassword: Boolean;
    { Context Menu }
    procedure DoCopy(Sender: TObject);
    procedure DoPaste(Sender: TObject);
    { Observers Methods }
    procedure NotifyObserverIfObserver(const AObserver: TObservers);
    procedure ObserversCallUpdate(const AObserver: TObservers);
    procedure ObserversCallTrackUpdate(const AObserver: TObservers);
    { IReadOnly }
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
  protected
    FDateTimePicker: TCustomDateTimePicker;
    FClipboardService: IFMXClipboardService;
    FContextMenu: TPopupMenu;
    { DateTime Formatting }
    FFormatSizeParts: TList<TRectF>;
    FIndexCurrentFormatPart: Integer;
    FContinueEnteringValue: Boolean;
    FEnteringValue: string;
    { Format }
    function GetFormat: string; virtual;
    function HasFormat: Boolean;
    function FindCurrentFormatPart(var ATimeSection: TDTFormatPart): Boolean;
    procedure SetFormatKind(const Value: TDTFormatKind);
    function GetFormatKind: TDTFormatKind;
    function GetMaskForEmptyDateTime: string;
    procedure GoToNextFormatPart; virtual;
    procedure GoToPreviousFormatPart; virtual;
    { Pickers }
    procedure HandlerPickerClosed(Sender: TObject); virtual;
    procedure HandlerPickerOpened(Sender: TObject); virtual;
    procedure HandlerPickerDateTimeChanged(Sender: TObject; const ADate: TDateTime); virtual;
    procedure InitPicker; virtual;
    { Painting }
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF); virtual;
    procedure DrawSelection(ACanvas: TCanvas); virtual;
    procedure CalculateTextSize; virtual;
    procedure InitTextLayout; virtual;
    property SelectionFill: TBrush read FSelectionFill;
    property TextLayout: TTextLayout read FTextLayout;
    { Keyboard & Mouse }
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure EnterValue(var KeyChar: System.WideChar); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single); override;
    { Styles }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function HasTextObject: Boolean;
    function HasCheckBox: Boolean;
    function HasClearButton: Boolean;
    procedure DoCheckChanged(Sender: TObject); virtual;
    procedure DoClearButtonClick(Sender: TObject); virtual;
    /// <summary>Notification about changing size of style's TextObject</summary>
    procedure DoTextObjectSizeChanged(Sender: TObject); virtual;
    property CheckBox: TCheckBox read FCheck;
    property ClearButton: TControl read FClearButton;
    { Checkbox }
    procedure UpdateTextOpacity; virtual;
    { Focus }
    procedure DoEnter; override;
    procedure DoExit; override;
    { Changing DateTime }
    procedure DoDateTimeChanged; virtual;
    // This method is invoked, when user changed date in UI. It is important for links with LiveBinding
    procedure DoDateTimeChangedByUser; virtual;
    procedure DoTextChanged; override;
    procedure FormatterDateTimeChanged(Sender: TObject); virtual;
    procedure IncrementDateTimePart; virtual;
    procedure DecrementDateTimePart; virtual;
    function FindDateTimeSection(const APos: TPointF): Integer; virtual;
    procedure SetTime(const Value: TTime); virtual;
    procedure SetDate(const Value: TDate); virtual;
    procedure SetTextInternal(const Value: string); override;
    procedure UpdateText; virtual;
    procedure UpdateTextWithoutChanges; virtual;
    property IndexCurrentFormatPart: Integer read FIndexCurrentFormatPart write SetIndexFormatPart;
    { Context Menu }
    procedure CreateContextMenu; virtual;
    procedure CreateContextMenuItem(const AActionName, ATitleName: string; const AEventHandler: TNotifyEvent = nil);
    function ShowContextMenu(const ScreenPosition: TPointF): Boolean; override;
    { Inherited for TextSettings }
    procedure DoChanged; override;
    function GetDefaultSize: TSizeF; override;
    function GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass; override;
    { Behaviours }
    function IsDesktop: Boolean;
    function IsMobilePreview: Boolean;
    procedure RefreshPlatformBehaviour; virtual;
    property SupportKeyboardInput: Boolean read FSupportKeyboardInput write FSupportKeyboardInput;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Pickers }
    procedure OpenPicker; virtual;
    procedure ClosePicker; virtual;
    function IsPickerOpened: Boolean; virtual;
    function HasPicker: Boolean;
    { Editable }
    function CanUsePicker: Boolean; virtual;
    function CanInput: Boolean; virtual;
    { Live Bindings}
    function CanObserve(const ID: Integer): Boolean; override;
    procedure ObserverAdded(const ID: Integer; const Observer: IObserver); override;
    procedure ObserverToggle(const AObserver: IObserver; const Value: Boolean);
    { Clipboard }
    procedure CopyToClipboard; virtual;
    procedure PasteFromClipboard; virtual;
    property DateTime: TDateTime read GetDateTime write SetDateTime;
    property Time: TTime read GetTime write SetTime;
    property Date: TDate read GetDate write SetDate;
    property ShowCheckBox: Boolean read FShowCheckBox write SetShowCheckBox default False;
    property ShowClearButton: Boolean read FShowClearButton write SetShowClearButton default False;
    property IsChecked: Boolean read FIsChecked write SetIsChecked default True;
    property IsPressed: Boolean read FIsPressed;
    property IsEmpty: Boolean read FIsEmpty write SetIsEmpty default False;
    property KeyboardType: TVirtualKeyboardType read GetKeyboardType write SetKeyboardType default TVirtualKeyboardType.NumberPad;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property Format: string read FCustomFormat write SetCustomFormat;
    property OnCheckChanged: TNotifyEvent read FOnCheckChanged write FOnCheckChanged;
    property OnClosePicker: TNotifyEvent read FOnClosePicker write FOnClosePicker;
    property OnOpenPicker: TNotifyEvent read FOnOpenPicker write FOnOpenPicker;
    property OnChange: TNotifyEvent read FOnDateTimeChanged write FOnDateTimeChanged;
  end;

  TCustomTimeEdit = class(TCustomDateTimeEdit)
  private
    FUseNowTime: Boolean;
    { Timer }
    FTimerService: IFMXTimerService;
    FTimerHandle: TFmxHandle;
    { Style Objects }
    FUpButton: TControl;
    FDownButton: TControl;
    procedure SetUseNowTime(const Value: Boolean);
  protected
    { Format }
    function GetFormat: string; override;
    { Changing Time }
    procedure SetText(const AValue: string); override;
    procedure DoTimer; virtual;
    { Events of style objects }
    procedure DoUpButtonClick(Sender: TObject); virtual;
    procedure DoDownButtonClick(Sender: TObject); virtual;
    { Styles }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    { Behaviours }
    procedure RefreshPlatformBehaviour; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CopyToClipboard; override;
    { Time changing }
    function CanInput: Boolean; override;
    property UseNowTime: Boolean read FUseNowTime write SetUseNowTime default False;
    property TimeFormatKind: TDTFormatKind read GetFormatKind write SetFormatKind default TDTFormatKind.Short;
  end;

  TTimeEdit = class(TCustomTimeEdit)
  public
    property Font;
    property FontColor;
    property TextAlign;
  published
    property ShowClearButton;
    property ShowCheckBox;
    property IsChecked;
    property IsEmpty;
    property Format;
    property Time;
    property TimeFormatKind;
    property UseNowTime;
    property OnChange;
    property OnCheckChanged;
    property OnClosePicker;
    property OnOpenPicker;
    { inherited }
    property Align;
    property Anchors;
    property CanFocus default True;
    property CanParentFocus;
    property Cursor default crIBeam;
    property ClipChildren default False;
    property ClipParent default False;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest default True;
    property Locked default False;
    property KeyboardType default TVirtualKeyboardType.NumberPad;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property ReadOnly;
    property Scale;
    property Size;
    property StyleLookup;
    property StyledSettings;
    property TextSettings;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property ParentShowHint;
    property ShowHint;
    { events }
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
  end;

{ TDateEdit }

  TCustomDateEdit = class(TCustomDateTimeEdit)
  private
    FFirstDayOfWeek: TCalDayOfWeek;
    FShowWeekNumbers: Boolean;
    FTodayDefault: Boolean;
    FArrowButton: TControl;
    procedure SetTodayDefault(const Value: Boolean);
  protected
    { Format }
    function GetFormat: string; override;
    { Pickers Events }
    procedure SetText(const AValue: string); override;
    procedure InitPicker; override;
    procedure DoArrowButtonClick(Sender: TObject);
    { Styles }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    { Keyboard Input }
    property ArrowButton: TControl read FArrowButton;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CopyToClipboard; override;
    property TodayDefault: Boolean read FTodayDefault write SetTodayDefault default False;
    property WeekNumbers: Boolean read FShowWeekNumbers write FShowWeekNumbers default False;
    property FirstDayOfWeek: TCalDayOfWeek read FFirstDayOfWeek write FFirstDayOfWeek default TCalDayOfWeek.dowLocaleDefault;
    property DateFormatKind: TDTFormatKind read GetFormatKind write SetFormatKind default TDTFormatKind.Short;
  end;

  TDateEdit = class(TCustomDateEdit)
  public
    property Font;
    property TextAlign;
  published
    property ShowClearButton;
    property ShowCheckBox;
    property IsChecked;
    property IsEmpty;
    property Date;
    property WeekNumbers;
    property Format;
    property TodayDefault;
    property DateFormatKind;
    property OnChange;
    property OnCheckChanged;
    property OnClosePicker;
    property OnOpenPicker;
    { inherited }
    property Align;
    property Anchors;
    property CanFocus default True;
    property CanParentFocus;
    property Cursor default crIBeam;
    property ClipChildren default False;
    property ClipParent default False;
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
    property Locked default False;
    property KeyboardType;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property ReadOnly;
    property Scale;
    property Size;
    property StyleLookup;
    property StyledSettings;
    property TabOrder;
    property TabStop;
    property TextSettings;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property ParentShowHint;
    property ShowHint;
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
  end;

{ TCalendarBox }

implementation

uses
  System.SysUtils, System.DateUtils, System.Math, System.Character, System.TypInfo, FMX.Forms, FMX.Consts, FMX.Styles;

{ TCustomTimeEdit }

procedure TCustomDateTimeEdit.ApplyStyle;
var
  StyleObject: TFmxObject;
begin
  inherited;
  { Check box }
  if FindStyleResource<TCheckBox>('check', FCheck) then
  begin
    FCheck.Cursor := crArrow;
    FCheck.Visible := ShowCheckBox;
    FCheck.IsChecked := IsChecked;
    FCheck.OnChange := DoCheckChanged;
    UpdateTextOpacity;
  end;
  { Clear Button }
  if FindStyleResource<TControl>('clearbutton', FClearButton) then
  begin
    FClearButton.Cursor := crArrow;
    FClearButton.Visible := ShowClearButton;
    FClearButton.OnClick := DoClearButtonClick;
  end;
  { Text }
  if TextObject <> nil then
  begin
    TextObject.OnPaint := DoContentPaint;
    TextObject.OnResize := DoTextObjectSizeChanged;
    CalculateTextSize;
  end;
  { Selection brush }
  StyleObject := FindStyleResource('selection');
  if StyleObject is TBrushObject then
    FSelectionFill.Assign(TBrushObject(StyleObject).Brush);
  { Refresh platform's specific behaviour of control }
  RefreshPlatformBehaviour;
end;

procedure TCustomDateTimeEdit.GoToPreviousFormatPart;
var
  I: Integer;
  Found: Boolean;
begin
  I := IndexCurrentFormatPart - 1;
  Found := False;
  while (I >= 0) and not Found do
    if FDTFormatter.Parts[I].Part = TDTPart.Unknown then
      Dec(I)
    else
      Found := True;

  if Found then
    SetIndexFormatPart(I);
end;

procedure TCustomDateTimeEdit.InitPicker;
begin
  FDateTimePicker.Date := DateTime;
end;

procedure TCustomDateTimeEdit.CalculateTextSize;

  procedure CorrectHorizontalTextAligment(const ATextWidth: Single);
  var
    I: Integer;
    DeltaTextOffset: Double;
    TmpRect: TRectF;
  begin
    if not (TextAlign in [TTextAlign.Trailing, TTextAlign.Center]) then
      Exit;

    { Correct horizontal aligment }
    case TextAlign of
      TTextAlign.Center:
        DeltaTextOffset := TextObject.Width / 2 -  ATextWidth / 2 - FFormatSizeParts.First.Left;
      TTextAlign.Trailing:
        DeltaTextOffset := TextObject.Width - FFormatSizeParts.Last.Right;
    else
      DeltaTextOffset := 0;
    end;
    for I := FFormatSizeParts.Count - 1 downto 0 do
    begin
       TmpRect := FFormatSizeParts[I];
       TmpRect.Offset(DeltaTextOffset, 0);
       FFormatSizeParts[I] := TmpRect;
    end;
  end;

  function GetDisplayTextForPart(const AIndexPart: Integer): string;
  begin
    Result := FDTFormatter.DisplayValues[AIndexPart];
    // If date is empty, we should replace all date parts on MaskChar '_' (by default)
    if IsEmpty and (FDTFormatter[AIndexPart].Part <> TDTPart.Unknown) then
      Result := string.Create(FDTFormatter.MaskPlaceholder, Result.Length);
  end;

  function GetDisplayText: string;
  var
    I: Integer;
  begin
    Result := string.Empty;
    for I := 0 to FDTFormatter.Count - 1 do
      Result := Result + GetDisplayTextForPart(I);
  end;

var
  PartRect: TRectF;
  TotalWidth: Single;
  I: Integer;
  PartText: string;
  PartStartIndex: Integer;
begin
  if not HasTextObject then
    Exit;

  FFormatSizeParts.Clear;
  InitTextLayout;
  TotalWidth := 0;
  PartStartIndex := 0;
  FTextLayout.Text := GetDisplayText;
  for I := 0 to FDTFormatter.Count - 1 do
  begin
    PartText := GetDisplayTextForPart(I);
    PartRect := TextLayout.RegionForRange(TTextRange.Create(PartStartIndex, PartText.Length))[0];
    FFormatSizeParts.Add(PartRect);
    TotalWidth := TotalWidth + PartRect.Width;
    Inc(PartStartIndex, PartText.Length);
  end;
  CorrectHorizontalTextAligment(TotalWidth);
end;

function TCustomDateTimeEdit.CanInput: Boolean;
begin
  Result := not ReadOnly and ((ShowCheckBox and IsChecked) or not ShowCheckBox);
end;

procedure TCustomDateTimeEdit.NotifyObserverIfObserver(const AObserver: TObservers);
begin
  if AObserver.IsObserving(TObserverMapping.EditLinkID) and
    TLinkObservers.EditLinkEdit(AObserver) then
    TLinkObservers.EditLinkModified(AObserver);
  if AObserver.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueModified(AObserver);
end;

procedure TCustomDateTimeEdit.ObserversCallUpdate(const AObserver: TObservers);
begin
  if AObserver.IsObserving(TObserverMapping.EditLinkID) then
    TLinkObservers.EditLinkUpdate(AObserver);
  if AObserver.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueUpdate(AObserver);
end;

procedure TCustomDateTimeEdit.ObserversCallTrackUpdate(const AObserver: TObservers);
begin
  if AObserver.IsObserving(TObserverMapping.EditLinkID) then
    TLinkObservers.EditLinkTrackUpdate(AObserver);
  if AObserver.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueTrackUpdate(AObserver);
end;

function TCustomDateTimeEdit.CanObserve(const ID: Integer): Boolean;
begin
  Result := (ID = TObserverMapping.EditLinkID) or (ID = TObserverMapping.ControlValueID);
end;

procedure TCustomDateTimeEdit.ObserverAdded(const ID: Integer; const Observer: IObserver);
begin
  inherited;
  if (ID = TObserverMapping.EditLinkID) or (ID = TObserverMapping.ControlValueID) then
    Observer.OnObserverToggle := ObserverToggle;
end;

procedure TCustomDateTimeEdit.ObserverToggle(const AObserver: IObserver; const Value: Boolean);
var
  LEditLinkObserver: IEditLinkObserver;
begin
  if Value and Supports(AObserver, IEditLinkObserver, LEditLinkObserver) then
    FReadOnly := LEditLinkObserver.IsReadOnly;
end;

function TCustomDateTimeEdit.CanUsePicker: Boolean;
begin
  Result := HasPicker and CanInput;
end;

procedure TCustomDateTimeEdit.ClosePicker;
begin
  if HasPicker and FDateTimePicker.IsShown then
    FDateTimePicker.Hide;
end;

function TCustomDateTimeEdit.ShowContextMenu(const ScreenPosition: TPointF): Boolean;
begin
  Result := False;
  if PopupMenu <> nil then
    Result := inherited ShowContextMenu(ScreenPosition)
  else
    if not Result and not (csDesigning in ComponentState) then
    begin
      if Root <> nil then
        FContextMenu.Parent := Root.GetObject;
      try
        Result := True;
        FContextMenu.Popup(Round(ScreenPosition.X), Round(ScreenPosition.Y));
      finally
        FContextMenu.Parent := nil;
      end;
    end;
end;

procedure TCustomDateTimeEdit.CopyToClipboard;
begin
  if FClipboardService = nil then
    Exit;

  FClipboardService.SetClipboard(DateTimeToStr(DateTime));
end;

constructor TCustomDateTimeEdit.Create(AOwner: TComponent);
var
  PickerService: IFMXPickerService;
begin
  inherited;
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, FKeyboardService);
  TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, FClipboardService);
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, PickerService) then
  begin
    FDateTimePicker := PickerService.CreateDateTimePicker;
    FDateTimePicker.Parent := Self;
    FDateTimePicker.OnHide := HandlerPickerClosed;
    FDateTimePicker.OnShow := HandlerPickerOpened;
    FDateTimePicker.OnDateChanged := HandlerPickerDateTimeChanged;
  end;
  FTextLayout := TTextLayoutManager.DefaultTextLayout.Create;
  FSelectionFill := TBrush.Create(TBrushKind.Solid, $802A8ADF);
  { Date Time Formatting }
  FFormatSizeParts := TList<TRectF>.Create;
  FDTFormatter := TDateTimeFormatter.Create;
  FDTFormatter.Format := GetFormat;
  FDTFormatter.OnChange := FormatterDateTimeChanged;
  DateTime := Now;
  CanFocus := True;
  FKeyboardType := TVirtualKeyboardType.NumberPad;
  FReturnKeyType := TReturnKeyType.Default;
  FShowCheckBox := False;
  FShowClearButton := False;
  FIsChecked := True;
  FIsEmpty := False;
  FIndexCurrentFormatPart := UnknowFormatPart;
  FContinueEnteringValue := False;
  CreateContextMenu;
  RefreshPlatformBehaviour;
  SetAcceptsControls(False);
end;

type
  TCustomTimeEditSettings = class (TTextSettingsInfo.TCustomTextSettings)
  public
    constructor Create(const AOwner: TPersistent); override;
  published
    property Font;
    property FontColor;
    property HorzAlign default TTextAlign.Leading;
    property VertAlign default TTextAlign.Center;
  end;

{ TCustomTimeEdit }

procedure TCustomTimeEdit.ApplyStyle;
begin
  inherited;
  { Spin buttons }
  if FindStyleResource<TControl>('upbutton', FUpButton) then
  begin
    FUpButton.Cursor := crArrow;
    FUpButton.TouchTargetExpansion.Bottom := 0;
    FUpButton.OnClick := DoUpButtonClick;
  end;
  if FindStyleResource<TControl>('downbutton', FDownButton) then
  begin
    FDownButton.Cursor := crArrow;
    FDownButton.TouchTargetExpansion.Top := 0;
    FDownButton.OnClick := DoDownButtonClick;
  end;
end;

function TCustomTimeEdit.CanInput: Boolean;
begin
  Result := inherited and not UseNowTime;
end;

procedure TCustomTimeEdit.CopyToClipboard;
begin
  if FClipboardService = nil then
    Exit;

  FClipboardService.SetClipboard(TimeToStr(Time));
end;

constructor TCustomTimeEdit.Create(AOwner: TComponent);
begin
  inherited;
  DateTime := System.SysUtils.Time;
  TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, FTimerService);
  if HasPicker then
    FDateTimePicker.ShowMode := TDatePickerShowMode.Time;
  Cursor := crIBeam;
end;

destructor TCustomTimeEdit.Destroy;
begin
  FTimerService := nil;
  inherited;
end;

procedure TCustomTimeEdit.DoDownButtonClick(Sender: TObject);
begin
  if not IsFocused then
    SetFocus;
  DecrementDateTimePart;
  DoDateTimeChangedByUser;
end;

procedure TCustomTimeEdit.DoTimer;
begin
  Time := System.SysUtils.Now;
end;

procedure TCustomTimeEdit.DoUpButtonClick(Sender: TObject);
begin
  if not IsFocused then
    SetFocus;
  IncrementDateTimePart;
  DoDateTimeChangedByUser;
end;

procedure TCustomTimeEdit.FreeStyle;
begin
  if FUpButton <> nil then
    FUpButton.OnClick := nil;
  FUpButton := nil;
  if FDownButton <> nil then
    FDownButton.OnClick := nil;
  FDownButton := nil;
  inherited;
end;

function TCustomTimeEdit.GetFormat: string;
begin
  if Format.IsEmpty then
    // FormatSettings TimeFormat uses 'm' for setting minutes.
    // But FormatDateTime uses 'n' for settings minutes. So we need to replace
    // 'm' -> 'n'
    if FFormatKind = TDTFormatKind.Short then
      Result := FormatSettings.ShortTimeFormat.Replace('m','n')
    else
      Result := FormatSettings.LongTimeFormat.Replace('m','n')
  else
    Result := inherited;
end;

procedure TCustomTimeEdit.RefreshPlatformBehaviour;
begin
  // For Mobile preview mode on Windows, we don't have special time picker,
  // so we turn on using keyboard for inputting time in this case.
  SupportKeyboardInput := IsDesktop;
end;

procedure TCustomTimeEdit.SetText(const AValue: string);
var
  TempTime: TDateTime;
begin
  inherited;
  if TryStrToDateTime(AValue, TempTime, FormatSettings) and (TimeOf(TempTime) <> Time) then
    DateTime := Date + TimeOf(TempTime);
end;

procedure TCustomTimeEdit.SetUseNowTime(const Value: Boolean);
begin
  if UseNowTime <> Value then
  begin
    FUseNowTime := Value;
    if (FTimerService <> nil) and not (csDesigning in ComponentState) then
      if UseNowTime then
      begin
        FTimerHandle := FTimerService.CreateTimer(1 * MSecsPerSec, DoTimer);
        Time := System.SysUtils.Time;
        ClosePicker;
      end
      else
        FTimerService.DestroyTimer(FTimerHandle);
  end;
end;

{ TCustomTimeEditSettings }

constructor TCustomTimeEditSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  WordWrap := False;
end;

function TCustomDateTimeEdit.GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass;
begin
  Result := TCustomTimeEditSettings;
end;

function TCustomDateTimeEdit.GetTime: TTime;
begin
  Result := TimeOf(DateTime);
end;

procedure TCustomDateTimeEdit.CreateContextMenu;
begin
  if FContextMenu <> nil then
    FContextMenu.Free;

  FContextMenu := TPopupMenu.Create(Self);
  FContextMenu.PopupComponent := Self;
  FContextMenu.Stored := False;

  CreateContextMenuItem('copy', SEditCopy, DoCopy);
  CreateContextMenuItem('paste', SEditPaste, DoPaste);
end;

procedure TCustomDateTimeEdit.CreateContextMenuItem(const AActionName, ATitleName: string; const AEventHandler: TNotifyEvent = nil);
var
  TmpItem: TMenuItem;
begin
  Assert(not ATitleName.IsEmpty);
  Assert(not AActionName.IsEmpty);

  TmpItem := TMenuItem.Create(FContextMenu);
  TmpItem.Parent := FContextMenu;
  TmpItem.Text := ATitleName;
  TmpItem.StyleName := AActionName;
  TmpItem.OnClick := AEventHandler;
end;

procedure TCustomDateTimeEdit.FormatterDateTimeChanged(Sender: TObject);
begin
  UpdateText;
  // If date was null, DoDateTimeChanged will generated in IsEmpty setter.
  if IsEmpty then
    IsEmpty := False
  else
    DoDateTimeChanged;
end;

procedure TCustomDateTimeEdit.DecrementDateTimePart;
var
  DTPart: TDTFormatPart;
begin
  if FindCurrentFormatPart(DTPart) and CanInput then
  begin
    if DTPart.Value - 1 < DTPart.Range.Min then
      DTPart.Value := DTPart.Range.Max
    else
      DTPart.Value := DTPart.Value - 1;
    FDTFormatter.Values[IndexCurrentFormatPart] := DTPart.Value;
  end;
end;

destructor TCustomDateTimeEdit.Destroy;
begin
  FreeAndNil(FSelectionFill);
  FKeyboardService := nil;
  FClipboardService := nil;
  FreeAndNil(FDTFormatter);
  FreeAndNil(FFormatSizeParts);
  ClosePicker;
  FreeAndNil(FDateTimePicker);
  FreeAndNil(FTextLayout);
  inherited;
end;

procedure TCustomDateTimeEdit.DoChanged;
begin
  inherited;
  if ResultingTextSettings.IsAdjustChanged then
    CalculateTextSize;
end;

procedure TCustomDateTimeEdit.DoCheckChanged(Sender: TObject);
begin
  IsChecked := FCheck.IsChecked;
  UpdateTextOpacity;
  if Assigned(FOnCheckChanged) then
    FOnCheckChanged(Self);
end;

procedure TCustomDateTimeEdit.DoClearButtonClick(Sender: TObject);
begin
  if CanInput then
  begin
    IsEmpty := True;
    DoDateTimeChangedByUser;
  end;
end;

procedure TCustomDateTimeEdit.HandlerPickerClosed(Sender: TObject);
begin
  if Assigned(FOnClosePicker) and not (csDestroying in ComponentState) then
    FOnClosePicker(Self);
end;

procedure TCustomDateTimeEdit.DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
var
  State: TCanvasSaveState;
begin
  State := Canvas.SaveState;
  try
    DrawSelection(Canvas);
  finally
    Canvas.RestoreState(State);
  end;
end;

procedure TCustomDateTimeEdit.DoCopy(Sender: TObject);
begin
  CopyToClipboard;
end;

procedure TCustomDateTimeEdit.DoDateTimeChanged;
begin
  if Assigned(FOnDateTimeChanged) and not (csLoading in ComponentState) then
    FOnDateTimeChanged(Self);
end;

procedure TCustomDateTimeEdit.DoDateTimeChangedByUser;
begin
  NotifyObserverIfObserver(Observers);
  ObserversCallTrackUpdate(Observers);
end;

procedure TCustomDateTimeEdit.DoEnter;
begin
  inherited;
  if IndexCurrentFormatPart = UnknowFormatPart then
    IndexCurrentFormatPart := FindDateTimeSection(TPointF.Zero);
end;

procedure TCustomDateTimeEdit.DoExit;
begin
  inherited;
  ClosePicker;
  ObserversCallUpdate(Observers); // OnExit updates Bindings if not tracking;
end;

procedure TCustomDateTimeEdit.HandlerPickerOpened(Sender: TObject);
begin
  if Assigned(FOnOpenPicker) then
    FOnOpenPicker(Self);
end;

procedure TCustomDateTimeEdit.DoPaste(Sender: TObject);
begin
  PasteFromClipboard;
  DoDateTimeChangedByUser;
end;

procedure TCustomDateTimeEdit.DoTextChanged;
begin
  inherited;
  CalculateTextSize;
end;

procedure TCustomDateTimeEdit.DoTextObjectSizeChanged(Sender: TObject);
begin
  CalculateTextSize;
end;

procedure TCustomDateTimeEdit.HandlerPickerDateTimeChanged(Sender: TObject; const ADate: TDateTime);
begin
  if not CanInput then
    Exit;

  // This event can be invoked, when we select date by first time, when date was null earlier.
  // In this case picker is display old value of date and Picker should allow repeatedly select this date
  if not SameDateTime(ADate, DateTime) then
  begin
    DateTime := ADate;
    DoDateTimeChangedByUser;
  end
  else if IsEmpty then
  begin
    IsEmpty := False;
    DoDateTimeChangedByUser;
  end;
end;

procedure TCustomDateTimeEdit.DrawSelection(ACanvas: TCanvas);

  function IsFormActive: Boolean;
  begin
    Result := (Scene.GetObject is TCustomForm) and (Scene.GetObject as TCustomForm).Active;
  end;

  function IsNeedDrawSelection: Boolean;
  begin
    Result := CanInput and SupportKeyboardInput and IsFormActive and IsFocused and not IsPickerOpened;
  end;

var
  TextRect: TRectF;
begin
  if InRange(IndexCurrentFormatPart, 0, FFormatSizeParts.Count - 1) and IsNeedDrawSelection then
  begin
    TextRect := FFormatSizeParts[IndexCurrentFormatPart];
    TextRect := TextRect * TextObject.LocalRect;
    ACanvas.FillRect(TextRect, 0, 0, AllCorners, AbsoluteOpacity, SelectionFill);
  end;
end;

procedure TCustomDateTimeEdit.OpenPicker;
begin
  if CanUsePicker and not FDateTimePicker.IsShown then
  begin
    InitPicker;
    FDateTimePicker.PreferedDisplayIndex := Screen.DisplayFromPoint(Screen.MousePos).Index;
    FDateTimePicker.Show;
  end;
end;

procedure TCustomDateTimeEdit.EnterValue(var KeyChar: System.WideChar);
var
  DTPart: TDTFormatPart;
  Age: Int64;
begin
  if FindCurrentFormatPart(DTPart) then
  begin
    FEnteringValue := FEnteringValue + KeyChar;
    if not FEnteringValue.IsEmpty and (DTPart.Range.Max < FEnteringValue.ToInteger) then
    begin
      FContinueEnteringValue := False;
      FEnteringValue := KeyChar;
    end;

    if FContinueEnteringValue then
      DTPart.Value := FEnteringValue.ToInteger
    else
      DTPart.Value := Round(KeyChar.GetNumericValue);

    if DTPart.Part in [TDTPart.Year, TDTPart.Month, TDTPart.Day] then
      DTPart.Value := Max(DTPart.Value, 1);

    // If current section is year part in short format, we should automaticaly set era for year.
    // It facilitates input year for user. Because user cannot see year entirely
    // Sample: Input '98', Output '1998'
    //         Input '10', Output '2010'
    //         Input '150', Output '0150'
    //         Input '1520', Output '1520'
    if (DTPart.Part = TDTPart.Year) and DTPart.IsShortYearFormat and (FEnteringValue.Length <= 2) then
    begin
      Age := Trunc(YearOf(System.SysUtils.Date) / 100);
      if FEnteringValue.ToInteger < 50 then
        DTPart.Value := Age * 100 + DTPart.Value
      else
        DTPart.Value := (Age - 1) * 100 + DTPart.Value;
    end;

    FDTFormatter.Values[IndexCurrentFormatPart] := DTPart.Value;
    FContinueEnteringValue := True;
    KeyChar := #0;
  end;
end;

function TCustomDateTimeEdit.FindDateTimeSection(const APos: TPointF): Integer;
var
  Found: Boolean;
  I: Integer;
begin
  Found := False;
  I := 0;
  while (I < FFormatSizeParts.Count) and not Found do
    if InRange(APos.X, FFormatSizeParts[I].Left, FFormatSizeParts[I].Right) and (FDTFormatter[I].Part <> TDTPart.Unknown) then
      Found := True
    else
      Inc(I);

  if Found then
    Result := I
  else
  begin
    if FFormatSizeParts.Count > 0 then
    begin
      if APos.X < FFormatSizeParts.First.Left then
        Result := 0
      else
      if APos.X > FFormatSizeParts.Last.Right then
        Result := FFormatSizeParts.Count - 1
      else
        Result := IndexCurrentFormatPart;
    end
    else
      Result := UnknowFormatPart;
  end;
end;

procedure TCustomDateTimeEdit.FreeStyle;
begin
  if HasTextObject then
  begin
    TextObject.OnPaint := nil;
    TextObject.OnResize := nil;
  end;
  if HasCheckBox then
    FCheck.OnChange := nil;
  FCheck := nil;
  if HasClearButton then
    FClearButton.OnClick := nil;
  FClearButton := nil;
  inherited;
end;

function TCustomDateTimeEdit.FindCurrentFormatPart(var ATimeSection: TDTFormatPart): Boolean;
begin
  Result := InRange(IndexCurrentFormatPart, 0, FDTFormatter.Count - 1);
  if Result then
     ATimeSection := FDTFormatter[IndexCurrentFormatPart];
end;

function TCustomDateTimeEdit.GetDate: TDate;
begin
  Result := DateOf(DateTime);
end;

function TCustomDateTimeEdit.GetDateTime: TDateTime;
begin
  Result := FDTFormatter.DateTime;
end;

function TCustomDateTimeEdit.GetDefaultSize: TSizeF;
var
  DefMetricsSrv: IFMXDefaultMetricsService;
begin
  if SupportsPlatformService(IFMXDefaultMetricsService, DefMetricsSrv) and
    DefMetricsSrv.SupportsDefaultSize(TComponentKind.Edit) then
    Result := TSizeF.Create(DefMetricsSrv.GetDefaultSize(TComponentKind.Edit).Width,
      DefMetricsSrv.GetDefaultSize(TComponentKind.Edit).Height)
  else
    Result := TSizeF.Create(100, 22);
end;

function TCustomDateTimeEdit.GetFormat: string;
begin
  Result := Format;
end;

function TCustomDateTimeEdit.GetMaskForEmptyDateTime: string;
var
  I: Integer;
  DTPart: TDTFormatPart;
  FormatMask: string;
  DisplayValue: string;
begin
  FormatMask := string.Empty;
  if IsDesktop and not IsMobilePreview then
    for I := 0 to FDTFormatter.Count - 1 do
    begin
      DTPart := FDTFormatter.Parts[I];
      DisplayValue := FDTFormatter.DisplayValues[I];
      if IsEmpty and (DTPart.Part <> TDTPart.Unknown) then
        FormatMask := FormatMask + string.Create(FDTFormatter.MaskPlaceholder, DisplayValue.Length)
      else
        FormatMask := FormatMask + DisplayValue;
    end;
  Result := FormatMask;
end;

function TCustomDateTimeEdit.GetKeyboardType: TVirtualKeyboardType;
begin
  Result := FKeyboardType;
end;

function TCustomDateTimeEdit.GetReturnKeyType: TReturnKeyType;
begin
  Result := FReturnKeyType;
end;

function TCustomDateTimeEdit.IsMobilePreview: Boolean;
const
  TargetPlatformMobilePreview = '[MOBILEPREVIEW]';
var
  StyleDescriptor: TStyleDescription;
begin
  StyleDescriptor := TStyleManager.GetStyleDescriptionForControl(Self);
  if StyleDescriptor <> nil then
    Result := StyleDescriptor.PlatformTarget.Contains(TargetPlatformMobilePreview)
  else
    Result := False;
end;

function TCustomDateTimeEdit.IsDesktop: Boolean;
begin
  Result := TOSVersion.Platform in [TOSVersion.TPlatform.pfWindows, TOSVersion.TPlatform.pfMacOS, TOSVersion.TPlatform.pfLinux];
end;

function TCustomDateTimeEdit.IsPassword: Boolean;
begin
  Result := False;
end;

function TCustomDateTimeEdit.IsPickerOpened: Boolean;
begin
  Result := HasPicker and FDateTimePicker.IsShown;
end;

procedure TCustomDateTimeEdit.GoToNextFormatPart;
var
  I: Integer;
  Found: Boolean;
begin
  I := IndexCurrentFormatPart + 1;
  Found := False;
  while (I < FDTFormatter.Count) and not Found do
    if FDTFormatter[I].Part = TDTPart.Unknown then
      Inc(I)
    else
      Found := True;
  if Found then
    SetIndexFormatPart(I);
end;

function TCustomDateTimeEdit.HasCheckBox: Boolean;
begin
  Result := FCheck <> nil;
end;

function TCustomDateTimeEdit.HasClearButton: Boolean;
begin
  Result := FClearButton <> nil;
end;

function TCustomDateTimeEdit.HasTextObject: Boolean;
begin
  Result := TextObject <> nil;
end;

function TCustomDateTimeEdit.HasFormat: Boolean;
begin
  Result := FDTFormatter.Count > 0;
end;

function TCustomDateTimeEdit.HasPicker: Boolean;
begin
  Result := FDateTimePicker <> nil;
end;

procedure TCustomDateTimeEdit.IncrementDateTimePart;
var
  DTPart: TDTFormatPart;
begin
  if FindCurrentFormatPart(DTPart) and CanInput then
  begin
    if DTPart.Value + 1 > DTPart.Range.Max then
      DTPart.Value := DTPart.Range.Min
    else
      DTPart.Value := DTPart.Value + 1;
    FDTFormatter.Values[IndexCurrentFormatPart] := DTPart.Value;
  end;
end;

procedure TCustomDateTimeEdit.InitTextLayout;
begin
  TextLayout.MaxSize := TPointF.Create(TextObject.Width, TextObject.Height);
  TextLayout.HorizontalAlign := TTextAlign.Leading;
  TextLayout.VerticalAlign := ResultingTextSettings.VertAlign;
  TextLayout.Font := ResultingTextSettings.Font;
end;

procedure TCustomDateTimeEdit.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  if not CanInput then
    Exit;

  if KeyChar.IsDigit then
  begin
    EnterValue(KeyChar);
    DoDateTimeChangedByUser;
    KeyChar := #0;
  end;

  case Key of
    vkLeft:
      GoToPreviousFormatPart;
    vkRight:
      GoToNextFormatPart;
    vkUp:
    begin
      IncrementDateTimePart;
      DoDateTimeChangedByUser;
    end;
    vkDown:
    begin
      DecrementDateTimePart;
      DoDateTimeChangedByUser;
    end;
    vkC:
      if ssCtrl in Shift then
        CopyToClipboard;
    vkV:
      if ssCtrl in Shift then
      begin
        PasteFromClipboard;
        DoDateTimeChangedByUser;
      end;
    vkReturn:
      begin
        FContinueEnteringValue := False;
        FEnteringValue := '';
        ObserversCallUpdate(Observers);    // vkReturn updates Bindings if not tracking;
      end;
  else
    inherited;
    Exit;
  end;
  Key := 0;
end;

procedure TCustomDateTimeEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  AbsoluteMousePos: TPointF;
  ContentMousePos: TPointF;
begin
  if HasTextObject then
  begin
    AbsoluteMousePos := LocalToAbsolute(TPointF.Create(X, Y));
    ContentMousePos := TextObject.AbsoluteToLocal(AbsoluteMousePos);
    SetIndexFormatPart(FindDateTimeSection(ContentMousePos));
  end;
  if CanUsePicker and not SupportKeyboardInput then
    if FDateTimePicker.IsShown then
      ClosePicker
    else
      OpenPicker;
  inherited;
end;

procedure TCustomDateTimeEdit.PasteFromClipboard;
var
  DateTimeTmp: TDateTime;
  BufferString: string;
begin
  if (FClipboardService = nil) or not FClipboardService.GetClipboard.IsType<string> or not CanInput then
    Exit;

  BufferString := FClipboardService.GetClipboard.AsString;
  if TryStrToDateTime(BufferString, DateTimeTmp) then
    DateTime := DateTimeTmp;
end;

procedure TCustomDateTimeEdit.RefreshPlatformBehaviour;
begin
  SupportKeyboardInput := IsDesktop and not IsMobilePreview; // Only on desktop
end;

procedure TCustomDateTimeEdit.SetCustomFormat(const Value: string);
begin
  if Format <> Value then
  begin
    FCustomFormat := Value;
    FDTFormatter.Format := Format;
    UpdateTextWithoutChanges;
  end;
end;

procedure TCustomDateTimeEdit.SetDate(const Value: TDate);
begin
  if not SameDate(DateTime, Value) then
    DateTime := DateOf(Value) + TimeOf(DateTime);
end;

procedure TCustomDateTimeEdit.SetDateTime(const Value: TDateTime);
begin
  if not SameDate(DateTime, Value) or not SameTime(DateTime, Value) then
  begin
    FDTFormatter.DateTime := Value;
    UpdateText;
    Repaint;
  end;
end;

procedure TCustomDateTimeEdit.SetIndexFormatPart(const Value: Integer);
begin
  if FIndexCurrentFormatPart <> Value then
  begin
    FIndexCurrentFormatPart := Value;
    FContinueEnteringValue := False;
    FEnteringValue := '';
    Repaint;
  end;
end;

procedure TCustomDateTimeEdit.SetIsChecked(const Value: Boolean);
begin
  if FIsChecked <> Value then
  begin
    FIsChecked := Value;
    if HasCheckBox then
      FCheck.IsChecked := FIsChecked;
    if not IsChecked then
      ClosePicker;
    ApplyTriggerEffect(Self, 'IsChecked');
    StartTriggerAnimation(Self, 'IsChecked');
  end;
end;

procedure TCustomDateTimeEdit.SetIsEmpty(const Value: Boolean);
begin
  if IsEmpty <> Value then
  begin
    FIsEmpty := Value;
    UpdateText;
    DoDateTimeChanged;
    ApplyTriggerEffect(Self, 'IsEmpty');
    StartTriggerAnimation(Self, 'IsEmpty');
  end;
end;

procedure TCustomDateTimeEdit.SetKeyboardType(Value: TVirtualKeyboardType);
begin
  FKeyboardType := Value;
end;

function TCustomDateTimeEdit.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TCustomDateTimeEdit.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TCustomDateTimeEdit.SetReturnKeyType(Value: TReturnKeyType);
begin
  FReturnKeyType := Value;
end;

procedure TCustomDateTimeEdit.SetShowCheckBox(const Value: Boolean);
begin
  if FShowCheckBox <> Value then
  begin
    FShowCheckBox := Value;
    UpdateTextOpacity;
    if HasCheckBox then
      FCheck.Visible := Value;
  end;
end;

procedure TCustomDateTimeEdit.SetShowClearButton(const Value: Boolean);
begin
  if FShowClearButton <> Value then
  begin
    FShowClearButton := Value;
    if HasClearButton then
      FClearButton.Visible := Value;
  end;
end;

procedure TCustomDateTimeEdit.SetTextInternal(const Value: string);
begin
  if IsEmpty then
    inherited SetTextInternal(GetMaskForEmptyDateTime)
  else
    inherited SetTextInternal(Value);
  CalculateTextSize;
end;

procedure TCustomDateTimeEdit.SetTime(const Value: TTime);
begin
  if not SameTime(DateTime, Value) then
    DateTime := DateOf(DateTime) + TimeOf(Value);
end;

procedure TCustomDateTimeEdit.SetFormatKind(const Value: TDTFormatKind);
begin
  if FFormatKind <> Value then
  begin
    FFormatKind := Value;
    FDTFormatter.Format := GetFormat;
    UpdateTextWithoutChanges;
    Repaint;
  end;
end;

function TCustomDateTimeEdit.GetFormatKind: TDTFormatKind;
begin
  Result := FFormatKind;
end;

procedure TCustomDateTimeEdit.UpdateText;
begin
  if IsEmpty then
    Text := GetMaskForEmptyDateTime
  else
    Text := FormatDateTime(GetFormat, DateTime);
end;

procedure TCustomDateTimeEdit.UpdateTextOpacity;
begin
  if HasTextObject then
  begin
    if ShowCheckBox then
      TextObject.Enabled := IsChecked
    else
      TextObject.Enabled := True;
  end;
end;

procedure TCustomDateTimeEdit.UpdateTextWithoutChanges;
begin
  if IsEmpty then
    SetTextInternal(GetMaskForEmptyDateTime)
  else
    SetTextInternal(FormatDateTime(GetFormat, DateTime));
end;

{ TCalendarEdit }

procedure TCustomDateEdit.ApplyStyle;
begin
  inherited;
  { Arrow Button }
  if FindStyleResource<TControl>('arrow', FArrowButton) then
    FArrowButton.OnClick := DoArrowButtonClick;
end;

procedure TCustomDateEdit.InitPicker;
begin
  inherited;
  FDateTimePicker.TodayDefault := TodayDefault;
  FDateTimePicker.FirstDayOfWeek := FirstDayOfWeek;
  FDateTimePicker.ShowWeekNumbers := WeekNumbers;
end;

procedure TCustomDateEdit.CopyToClipboard;
begin
  if FClipboardService = nil then
    Exit;

  FClipboardService.SetClipboard(DateToStr(Date));
end;

constructor TCustomDateEdit.Create(AOwner: TComponent);
begin
  inherited;
  DateTime := System.SysUtils.Date;
  Cursor := crIBeam;
  FFirstDayOfWeek := TCalDayOfWeek.dowLocaleDefault;
end;

procedure TCustomDateEdit.DoArrowButtonClick(Sender: TObject);
begin
  if not IsFocused then
    SetFocus;

  if IsPickerOpened then
    ClosePicker
  else
    OpenPicker;
end;

procedure TCustomDateEdit.FreeStyle;
begin
  if FArrowButton <> nil then
    FArrowButton.OnClick:= nil;
  FArrowButton := nil;
  inherited;
end;

function TCustomDateEdit.GetFormat: string;
begin
  if Format.IsEmpty then
    if FFormatKind = TDTFormatKind.Short then
      Result := FormatSettings.ShortDateFormat
    else
      Result := FormatSettings.LongDateFormat
  else
    Result := inherited;
end;

procedure TCustomDateEdit.SetText(const AValue: string);
var
  TempDate: TDateTime;
  CustomFormatSettings: TFormatSettings;
begin
  inherited;
  CustomFormatSettings := FormatSettings;
  CustomFormatSettings.ShortDateFormat := GetFormat;
  if TryStrToDate(AValue, TempDate, CustomFormatSettings) and not SameDate(DateOf(TempDate), Date) then
    DateTime := DateOf(TempDate) + Time;
end;

procedure TCustomDateEdit.SetTodayDefault(const Value: Boolean);
begin
  if TodayDefault <> Value then
  begin
    FTodayDefault := Value;
    if TodayDefault then
      DateTime := Now;
  end;
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TDTFormatKind), ['dfShort', 'dfLong']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TDTFormatKind));
end;

initialization
  RegisterAliases;
  RegisterFmxClasses([TCustomTimeEdit, TTimeEdit, TCustomDateEdit, TDateEdit]);
finalization
  UnregisterAliases;
end.
