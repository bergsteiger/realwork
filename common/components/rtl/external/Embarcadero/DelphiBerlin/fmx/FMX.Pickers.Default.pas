{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Pickers.Default;

interface

{$SCOPEDENUMS ON}
                
procedure RegisterPickersService;
procedure UnregisterPickersService;

implementation

uses
  System.Classes, System.UITypes, System.Types, System.Math, System.SysUtils, System.Messaging, FMX.Pickers, FMX.ListBox,
  FMX.Types, FMX.ActnList, System.ImageList, FMX.Styles, FMX.Platform, FMX.Forms, FMX.Controls, FMX.DateTimeCtrls,
  FMX.Calendar;

type

{ TPopupPicker }

  { Base styled popup container with aligment by parent control } 
  TPopupPicker = class(TPopup)
  private
    procedure SetAbsoluteTargetRect(const Value: TRectF);
  protected
    procedure DoClosePopup; override;
    function GetDefaultStyleLookupName: string; override;
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Popup(const AShowModal: Boolean = False); override;
    procedure ShowPicker;
    procedure ClosePicker;
    property AbsoluteTargetRect: TRectF write SetAbsoluteTargetRect;
  end;

{ TPopupDateTimePicker }

  { TPopupPicker with TCalendar } 
  TPopupDateTimePicker = class(TPopupPicker)
  strict private
    FCalendar: TCalendar;
    FOnDateChanged: TOnDateChanged;
    procedure SetDate(const Value: TDateTime);
    procedure SetFirstDayOfWeek(const Value: TCalDayOfWeek);
    procedure SetShowWeekNumbers(const Value: Boolean);
    procedure SetTodayDefault(const Value: Boolean);
    procedure DoDateChanged(Sender: TObject);
    procedure DoDateSelected(Sender: TObject);
    procedure DoDayClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Popup(const AShowModal: Boolean = False); override;
    property Date: TDateTime write SetDate;
    property FirstDayOfWeek: TCalDayOfWeek write SetFirstDayOfWeek;
    property ShowWeekNumbers: Boolean write SetShowWeekNumbers;
    property TodayDefault: Boolean write SetTodayDefault;
    property OnDateChanged: TOnDateChanged read FOnDateChanged write FOnDateChanged;
  end;

{ TPopupListPicker }

  { TPopupPicker with TListBox }
  TPopupListPicker = class(TPopupPicker)
  strict private
    FListBox: TListBox;
    FItemWidth: Single;
    FDropDownCount: Integer;
    FOnValueChanged: TOnValueChanged;
    function GetItemIndex: Integer;
    procedure SetItemIndex(const AItemIndex: Integer);
    procedure SetItemWidth(const Value: Single);
  protected
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
    procedure DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure DoValueChanged(Sender: TObject);
    procedure UpdatePickerSize;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetValues(const AValues: TStrings; const AItemIndex: Integer);
    procedure SetItemHeight(const AHeight: Single);
    procedure SetDropDownCount(const ACountItems: Integer);
    procedure Popup(const AShowModal: Boolean = False); override;
    property ItemWidth: Single read FItemWidth write SetItemWidth;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property OnValueChanged: TOnValueChanged read FOnValueChanged write FOnValueChanged;
  end;

{ TDefaultDateTimePicker }

  TDefaultDateTimePicker = class(TCustomDateTimePicker)
  strict private
    FPopupDateTimePicker: TPopupDateTimePicker;
  protected
    procedure AbsoluteTargetRectChanged; override;
  public
    constructor Create(const APickerService: TPickerFactoryService); override;
    destructor Destroy; override;
    procedure Show; override;
    procedure Hide; override;
    function IsShown: Boolean; override;
  end;

{ TDefaultListPicker }

  TDefaultListPicker = class(TCustomListPicker)
  strict private
    FPopupListPicker: TPopupListPicker;
  protected
    procedure SetItemIndex(AValue: Integer); override;
    procedure SetValues(AValues: TStrings); override;
    procedure AbsoluteTargetRectChanged; override;
  public
    constructor Create(const APickerService: TPickerFactoryService); override;
    destructor Destroy; override;
    procedure Show; override;
    procedure Hide; override;
    function IsShown: Boolean; override;
  end;

{ TDefaultPickerService }

  TDefaultPickerService = class(TPickerFactoryService)
  private
    procedure FormShownHandler(const Sender: TObject; const M: TMessage);
  protected
    function DoCreateDateTimePicker: TCustomDateTimePicker; override;
    function DoCreateListPicker: TCustomListPicker; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  PickerService: TPickerFactoryService;

procedure RegisterPickersService;
begin
  PickerService := TDefaultPickerService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXPickerService, PickerService);
end;

procedure UnregisterPickersService;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXPickerService);
  PickerService := nil;
end;

procedure TPopupPicker.ClosePicker;
begin
  IsOpen := False;
end;

constructor TPopupPicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  PlacementTarget := nil;
  Placement := TPlacement.Bottom;
  Stored := False;
  Parent := nil;
  Locked := True;
  Width := 186;
  Height := 166;
end;

procedure TPopupPicker.DialogKey(var Key: Word; Shift: TShiftState);
begin
  inherited DialogKey(Key, Shift);
  if Key in [vkTab, vkReturn, vkEscape] then
    ClosePopup;
end;

procedure TPopupPicker.DoClosePopup;
begin
  inherited DoClosePopup;
  // We need to reset parent, because parent destroy our picker, when root form
  // for parent control start destroying
  Parent := nil;
end;

function TPopupPicker.GetDefaultStyleLookupName: string;
begin
  Result := 'combopopupstyle';
end;

procedure TPopupPicker.Popup(const AShowModal: Boolean = False);
var
  ParentControl: TControl;
begin
  if Parent is TControl then
  begin
    ParentControl := Parent as TControl;
    Self.Opacity := ParentControl.Opacity;
  end;
  inherited Popup;
end;

procedure TPopupPicker.SetAbsoluteTargetRect(const Value: TRectF);
var
  LocalRect: TRectF;
  ScreenRect: TRectF;
begin
  if Value.IsEmpty then
    PlacementRectangle.Rect := TRectF.Empty
  else if ParentControl <> nil then
  begin
    LocalRect := Value;
    LocalRect.Location := ParentControl.AbsoluteToLocal(LocalRect.TopLeft);
    PlacementRectangle.Rect := LocalRect;
  end
  else
  begin
    ScreenRect := Value;
    if Screen.ActiveForm <> nil then
      ScreenRect.Location := Screen.ActiveForm.ClientToScreen(ScreenRect.TopLeft); 
    PlacementRectangle.Rect := ScreenRect;
  end;
end;

procedure TPopupPicker.ShowPicker;
begin
  // We use singleton picker for all control. Therefore, if we need show
  // picker twice for two different control. We must correctly close picker for
  // first control, and show again for second control.
  if IsOpen then
    ClosePicker;
  IsOpen := True;
end;

{ TDateTimePicker }

constructor TPopupDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCalendar := TCalendar.Create(Self);
  FCalendar.Parent := Self;
  FCalendar.Stored := False;
  FCalendar.Position.Point := PointF(0, 0);
  FCalendar.DisableFocusEffect := True;
  FCalendar.OnChange := DoDateChanged;
  FCalendar.OnDateSelected := DoDateSelected;
  FCalendar.OnDayClick := DoDayClick;
end;

procedure TPopupDateTimePicker.DoDateChanged(Sender: TObject);
begin
  if Assigned(FOnDateChanged) then
    FOnDateChanged(Parent, FCalendar.Date);
end;

procedure TPopupDateTimePicker.DoDateSelected(Sender: TObject);
begin
  IsOpen := False;
end;

procedure TPopupDateTimePicker.DoDayClick(Sender: TObject);
begin
  DoDateChanged(Parent);
  IsOpen := False;
end;

procedure TPopupDateTimePicker.Popup(const AShowModal: Boolean = False);

  procedure UpdateCalendarStyleAndPickerSize;
  begin
    FCalendar.ApplyStyleLookup;
    Width := FCalendar.Width + Padding.Right + Padding.Left;
    Height := FCalendar.Height + Padding.Bottom + Padding.Top;
  end;

begin
  if Parent is TControl then
    UpdateCalendarStyleAndPickerSize;
  inherited Popup(AShowModal);
end;

procedure TPopupDateTimePicker.SetDate(const Value: TDateTime);
begin
  FCalendar.DateTime := Value;
end;

procedure TPopupDateTimePicker.SetFirstDayOfWeek(const Value: TCalDayOfWeek);
begin
  FCalendar.FirstDayOfWeek := Value;
end;

procedure TPopupDateTimePicker.SetShowWeekNumbers(const Value: Boolean);
begin
   FCalendar.WeekNumbers := Value;
end;

procedure TPopupDateTimePicker.SetTodayDefault(const Value: Boolean);
begin
   FCalendar.TodayDefault := Value;
end;

{ TDropDownPicker }

constructor TPopupListPicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropDownCount := 8;
  FItemWidth := 0;
  FListBox := TListBox.Create(Self);
  FListBox.Parent := Self;
  FListBox.Stored := False;
  FListBox.Align := TAlignLayout.Client;
  FListBox.ShowCheckboxes := False;
  FListBox.OnChange := DoValueChanged;
  FListBox.OnMouseMove := DoMouseMove;
  FListBox.OnMouseUp := DoMouseUp;
end;

procedure TPopupListPicker.DialogKey(var Key: Word; Shift: TShiftState);
begin
  inherited DialogKey(Key, Shift);
  case Key of
    vkHome:
      ItemIndex := 0;
    vkEnd:
      ItemIndex := FListBox.Count - 1;
    vkUp, vkLeft:
      ItemIndex := Max(0, ItemIndex - 1);
    vkDown, vkRight:
      ItemIndex := Min(FListBox.Count - 1, ItemIndex + 1);
  end;
end;

procedure TPopupListPicker.DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
  Item: TListBoxItem;
begin
  Item := FListBox.ItemByPoint(X, Y);
  if Item <> nil then
  begin
    FListBox.OnChange := nil;
    try
      FListBox.ItemIndex := Item.Index;
    finally
      FListBox.OnChange := DoValueChanged;
    end;
  end;
end;

procedure TPopupListPicker.DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Item: TListBoxItem;
begin
  Item := FListBox.ItemByPoint(X, Y);
  if Item <> nil then
    DoValueChanged(FListBox);

  IsOpen := False;
end;

procedure TPopupListPicker.DoValueChanged(Sender: TObject);
begin
  if Assigned(FOnValueChanged) then
    FOnValueChanged(Sender, FListBox.ItemIndex);
end;

function TPopupListPicker.GetItemIndex: Integer;
begin
  Result := FListBox.ItemIndex;
end;

procedure TPopupListPicker.Popup(const AShowModal: Boolean = False);
var
  IndexOfFirstVisibleItem: Integer;
  IndexOfLastVisibleItem: Integer;
  StyleDescriptor: TStyleDescription;
  P: TPointF;

  procedure CalculateRangeVisibleItems;
  begin
    if FListBox.ItemIndex - (FDropDownCount - 1) div 2 > 0 then
      IndexOfFirstVisibleItem := FListBox.ItemIndex - (FDropDownCount - 1) div 2
    else
      IndexOfFirstVisibleItem := 0;

    IndexOfLastVisibleItem := IndexOfFirstVisibleItem + FDropDownCount - 1;

    if (IndexOfLastVisibleItem >= 0) and not (IndexOfLastVisibleItem <= FListBox.Count - 1) then
    begin
      IndexOfLastVisibleItem := FListBox.Count - 1;
      IndexOfFirstVisibleItem := Max(IndexOfLastVisibleItem - FDropDownCount + 1, 0);
    end;
  end;

  procedure ScrollListBoxToFirstVisibleItem;
  var
    ScrollPos: TPointF;
  begin
    ScrollPos := FListBox.ListItems[IndexOfFirstVisibleItem].Position.Point;
    FListBox.ScrollBy(0, -ScrollPos.Y);
  end;

  procedure OffsetPopupToCurrentItem;
  var
    ScrollPos: TPointF;
  begin
    if FListBox.Selected = nil then
      Exit;

    ScrollPos := FListBox.ListItems[FListBox.ItemIndex].AbsoluteRect.TopLeft;
    ScrollPos := AbsoluteToLocal(ScrollPos);
    if Parent is TControl then
      VerticalOffset := -TControl(Parent).Height - ScrollPos.Y;
  end;

begin
  FListBox.ApplyStyleLookup;
  UpdatePickerSize;

  // Scroll content popup combobox to selected item
  if FListBox.Selected <> nil then
  begin
    P := FListBox.ViewportPosition;
    P.Y := 0;
    FListBox.ViewportPosition := P;
    CalculateRangeVisibleItems;
    ScrollListBoxToFirstVisibleItem;
  end;

  // If current platform is Windows 8, we set special popup offset for drop down list
  if Parent is TControl then
  begin
    StyleDescriptor := TStyleManager.GetStyleDescriptionForControl(TControl(Parent));
    if (StyleDescriptor <> nil) and StyleDescriptor.PlatformTarget.Contains('[METROPOLISUI]') then
      OffsetPopupToCurrentItem;
  end;

  inherited Popup(AShowModal);
end;

procedure TPopupListPicker.SetDropDownCount(const ACountItems: Integer);
begin
  if ACountItems = 0 then
    FDropDownCount := 8
  else
    FDropDownCount := ACountItems;
  UpdatePickerSize;
end;

procedure TPopupListPicker.SetItemHeight(const AHeight: Single);
begin
  Assert(AHeight >= 0, 'Item height must to be great then 0');
  FListBox.ItemHeight := AHeight;
  UpdatePickerSize;
end;

procedure TPopupListPicker.SetItemIndex(const AItemIndex: Integer);
begin
  if AItemIndex > -1 then
    FListBox.ItemIndex := AItemIndex
  else
    FListBox.ItemIndex := -1;
end;

procedure TPopupListPicker.SetItemWidth(const Value: Single);
begin
  FItemWidth := Max(0, Value);
end;

procedure TPopupListPicker.SetValues(const AValues: TStrings; const AItemIndex: Integer);
var
  I: Integer;
  Item: TListBoxItem;
  Items: IItemsContainer;
  Glyph: IGlyph;
begin
  Assert(AValues <> nil, 'Can not set values. Values is null');
  Assert(AItemIndex < AValues.Count, 'Item index must be less than Values Count');
  FListBox.BeginUpdate;
  try
    FListBox.Clear;
    Supports(Parent, IItemsContainer, Items);
    if Supports(Parent, IGlyph, Glyph) then
      (FListBox as IGlyph).SetImages(Glyph.Images);
    for I := 0 to AValues.Count - 1 do
    begin
      Item := TListBoxItem.Create(FListBox);
      Item.Parent := FListBox;
      Item.Text := AValues[I];
      if (Items <> nil) and Supports(Items.GetItem(I), IGlyph, Glyph) then
        Item.ImageIndex := Glyph.ImageIndex;
    end;
    ItemIndex := AItemIndex;
  finally
    FListBox.EndUpdate;
  end;
  UpdatePickerSize;
end;

procedure TPopupListPicker.UpdatePickerSize;

  function HaveListBoxDefaultItemHeight: Boolean;
  begin
    Result := (FListBox.ItemHeight = 0) and (FListBox.Count > 0);
  end;

begin
  ApplyStyleLookup;
  // Calculate picker's height
  if HaveListBoxDefaultItemHeight then
    Height := Padding.Top + FListBox.ListItems[0].Height * Min(FDropDownCount, FListBox.Items.Count) +
      FListBox.BorderHeight + Padding.Bottom
  else
    Height := Padding.Top + FListBox.ItemHeight * Min(FDropDownCount, FListBox.Items.Count) +
      2 * (FListBox.Height - FListBox.ClientHeight) + Padding.Bottom;

  // Calculate picker's width
  if ItemWidth > 0 then
    Width := ItemWidth
  else
    if ParentControl <> nil then
      Width := ParentControl.Width;
end;

{ TDefaultPickerService }

constructor TDefaultPickerService.Create;
begin
  inherited;
  TMessageManager.DefaultManager.SubscribeToMessage(TFormBeforeShownMessage, FormShownHandler);
end;

destructor TDefaultPickerService.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TFormBeforeShownMessage, FormShownHandler);
  inherited;
end;

function TDefaultPickerService.DoCreateDateTimePicker: TCustomDateTimePicker;
begin
  Result := TDefaultDateTimePicker.Create(Self);
end;

function TDefaultPickerService.DoCreateListPicker: TCustomListPicker;
begin
  Result := TDefaultListPicker.Create(Self);
end;

procedure TDefaultPickerService.FormShownHandler(const Sender: TObject; const M: TMessage);
begin
{$IF Defined(IOS) or Defined(Android)}
  CloseAllPickers;
{$ENDIF}
end;

{ TDefaultDateTimePicker }

procedure TDefaultDateTimePicker.AbsoluteTargetRectChanged;
begin
  inherited;
  FPopupDateTimePicker.AbsoluteTargetRect := AbsoluteTargetRect;
end;

constructor TDefaultDateTimePicker.Create(const APickerService: TPickerFactoryService);
begin
  inherited Create(APickerService);
  FPopupDateTimePicker := TPopupDateTimePicker.Create(nil);
end;

destructor TDefaultDateTimePicker.Destroy;
begin
  FreeAndNil(FPopupDateTimePicker);
  inherited Destroy;
end;

procedure TDefaultDateTimePicker.Hide;
begin
  FPopupDateTimePicker.ClosePicker;
end;

function TDefaultDateTimePicker.IsShown: Boolean;
begin
  Result := FPopupDateTimePicker.IsOpen;
end;

procedure TDefaultDateTimePicker.Show;
begin
  FPopupDateTimePicker.PreferedDisplayIndex := PreferedDisplayIndex;
  FPopupDateTimePicker.Parent := Parent;
  FPopupDateTimePicker.PlacementTarget := Parent;
  FPopupDateTimePicker.AbsoluteTargetRect := AbsoluteTargetRect;
  FPopupDateTimePicker.FirstDayOfWeek := FirstDayOfWeek;
  FPopupDateTimePicker.ShowWeekNumbers := ShowWeekNumbers;
  FPopupDateTimePicker.TodayDefault := TodayDefault;
  // Reset event handler, because when we set date to TCalendar by Date, it calls OnDateChanged event.
  FPopupDateTimePicker.OnDateChanged := nil;
  try
    FPopupDateTimePicker.Date := Date;
  finally
    FPopupDateTimePicker.OnDateChanged := OnDateChanged;
  end;
  FPopupDateTimePicker.OnPopup := OnShow;
  FPopupDateTimePicker.OnClosePopup := OnHide;

  FPopupDateTimePicker.ShowPicker;
end;

{ TDefaultListPicker }

procedure TDefaultListPicker.AbsoluteTargetRectChanged;
begin
  inherited;
  FPopupListPicker.AbsoluteTargetRect := AbsoluteTargetRect;
end;

constructor TDefaultListPicker.Create(const APickerService: TPickerFactoryService);
begin
  inherited Create(APickerService);
  FPopupListPicker := TPopupListPicker.Create(nil);
end;

destructor TDefaultListPicker.Destroy;
begin
  FreeAndNil(FPopupListPicker);
  inherited Destroy;
end;

procedure TDefaultListPicker.Hide;
begin
  FPopupListPicker.ClosePicker;
end;

function TDefaultListPicker.IsShown: Boolean;
begin
  Result := FPopupListPicker.IsOpen;
end;

procedure TDefaultListPicker.SetItemIndex(AValue: Integer);
begin
  inherited;
  FPopupListPicker.OnValueChanged := nil;
  try
    FPopupListPicker.ItemIndex := AValue;
  finally
    FPopupListPicker.OnValueChanged := OnValueChanged;
  end;
end;

procedure TDefaultListPicker.SetValues(AValues: TStrings);
begin
  inherited;
  FPopupListPicker.SetValues(AValues, ItemIndex);
end;

procedure TDefaultListPicker.Show;
var
  StyleDescriptor: TStyleDescription;
begin
  FPopupListPicker.PreferedDisplayIndex := PreferedDisplayIndex;
  FPopupListPicker.PlacementTarget := Parent;
  FPopupListPicker.AbsoluteTargetRect := AbsoluteTargetRect;
  FPopupListPicker.Parent := Parent;
  FPopupListPicker.OnPopup := OnShow;
  FPopupListPicker.OnClosePopup := OnHide;
  FPopupListPicker.OnValueChanged := OnValueChanged;
  FPopupListPicker.SetValues(Values, ItemIndex);
  FPopupListPicker.SetDropDownCount(CountVisibleItems);
  FPopupListPicker.ItemWidth := ItemWidth;
  // If current platform is Windows 8, we set special settings for drop down list
  // and set special popup offset for drop down list
  StyleDescriptor := TStyleManager.GetStyleDescriptionForControl(Parent);
  if (StyleDescriptor <> nil) and StyleDescriptor.PlatformTarget.Contains('[METROPOLISUI]') then
    FPopupListPicker.SetItemHeight(Parent.Height)
  else
    FPopupListPicker.SetItemHeight(ItemHeight);
                 
  FPopupListPicker.ShowPicker;
end;

end.
