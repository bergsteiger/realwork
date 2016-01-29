{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Pickers.iOS;

interface

procedure RegisterPickersService;
procedure UnregisterPickersService;

implementation

uses
  System.Classes, System.SysUtils, System.TypInfo, System.Types,
  FMX.Pickers, FMX.Platform, FMX.Types, FMX.Consts, FMX.Controls, FMX.Platform.iOS, FMX.Forms,
  Macapi.ObjectiveC, Macapi.ObjCRuntime,
  iOSapi.Foundation, iOSapi.CocoaTypes, iOSapi.UIKit, iOSapi.CoreGraphics;

type

  IDialogActions = interface (NSObject)
  ['{59D129A3-8EA1-4B48-A09F-4DF2ACA7E26F}']
    procedure Cancel; cdecl;
    procedure Done; cdecl;
    procedure Hidden; cdecl;
    procedure StartChangeDeviceOrientation(notification: Pointer); cdecl;
  end;

  /// <summary>
  ///    Picker's States
  /// </summary>
  TPickerState = (psHidden, psShowed);

  // Only for iPad
  TPopoverDelegate = class;

  /// <summary>
  ///   Native animated popup with 2 buttons (Done, Close)
  /// </summary>
  TPopupDialog = class (TOCLocal)
  strict private
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
  protected
    FParentControl: TControl;
    FPickerState: TPickerState;
    // For iPad
    FUIPopoverController: UIPopoverController;
    FUIPopoverContent: UIViewController;
    FUIPopoverDelegate: TPopoverDelegate;
    // Common controls for all devices: iPhone and iPad idioms
    FUIContainerView: UIView;
    FUIToolBar: UIToolBar;
    FUICloseButton: UIBarButtonItem;
    FUIFlexibleSepararator: UIBarButtonItem;
    FUIDoneButton: UIBarButtonItem;
    procedure DoShow; virtual;
    procedure DoDone; virtual;
    procedure DoCancel; virtual;
    procedure DoHide; virtual;
    procedure DoPopoverDismiss;
    function GetPopupFrame: NSRect; virtual;
    function GetToolbarFrame: NSRect;
    function GetContentFrame: NSRect;
    { TOCLocal }
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Show;
    procedure Hide;
    { IDialogActions }
    procedure Cancel; cdecl;
    procedure Done; cdecl;
    procedure Hidden; cdecl;
    procedure StartChangeDeviceOrientation(notification: Pointer); cdecl;
    property ParentControl: TControl read FParentControl write FParentControl;
    property PickerState: TPickerState read FPickerState;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
  end;

  TPopoverDelegate = class (TOCLocal, UIPopoverControllerDelegate)
  strict private
    FPopupDialog: TPopupDialog;
  public
    constructor Create(const APopupDialog: TPopupDialog);
    { UIPopoverControllerDelegate }
    procedure popoverControllerDidDismissPopover(popoverController: UIPopoverController); cdecl;
    function popoverControllerShouldDismissPopover(popoverController: UIPopoverController): Boolean; cdecl;
  end;

  // To inherit the IDialogActions interface it is impossible
  // Because the child interface can be not registered in Objective C
  // at the moment of creation of a copy of a class. It registers
  // at the moment of creation of a copy of a class.
  IDateTimeDialogActions = interface (NSObject)
  ['{47CDC1C0-8FF6-4815-94A0-79893BDFD722}']
    procedure Cancel; cdecl;
    procedure Done; cdecl;
    procedure Hidden; cdecl;
    procedure StartChangeDeviceOrientation(notification: Pointer); cdecl;
  end;

  /// <summary>
  ///   Native animated popup with 2 buttons (Done, Close) and Date picker
  /// </summary>
  TDateTimePopupDialog = class (TPopupDialog)
  private
    FDateTimePicker: UIDatePicker;
    FOnDateChanged: TOnDateChanged;
    function GetDateTime: TDateTime;
    procedure SetDateTime(const Value: TDateTime);
    procedure SetShowMode(const Value: TDatePickerShowMode);
    procedure DoDateChanged;
  protected
    procedure DoDone; override;
    { TOCLocal }
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create;
    destructor Destroy; override;
    property Kind: TDatePickerShowMode write SetShowMode;
    property DateTime: TDateTime read GetDateTime write SetDateTime;
    property OnDateChanged: TOnDateChanged read FOnDateChanged write FOnDateChanged;
  end;

  IListBoxDialogActions = interface (NSObject)
  ['{0BA0DD09-C216-44A6-99AA-5F139F936557}']
    procedure Cancel; cdecl;
    procedure Done; cdecl;
    procedure Hidden; cdecl;
    procedure StartChangeDeviceOrientation(notification: Pointer); cdecl;
  end;

  TPickerDelegate = class;
  TPickerDataSource = class;

  /// <summary>
  ///   Native animated popup with 2 buttons (Done, Close) and Custom picker
  /// </summary>
  TListBoxPopupDialog = class (TPopupDialog)
  private
    FOnValueChanged: TOnValueChanged;
    procedure SetValues(const AValues: TStrings);
    procedure DoValueChanged;
    procedure SetItemIndex(const Value: Integer);
  protected
    FValues: NSMutableArray;
    FListBoxPicker: UIPickerView;
    FDelegate: TPickerDelegate;
    FDataSource: TPickerDataSource;
    procedure DoDone; override;
    { TOCLocal }
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create;
    destructor Destroy; override;
    property Values: TStrings write SetValues;
    property ItemIndex: Integer write SetItemIndex;
    property OnValueChanged: TOnValueChanged read FOnValueChanged write FOnValueChanged;
  end;

  {$REGION 'Helpers for event handling of native components'}

  /// <summary>
  ///   Class implement delegate and protocol interfaces for work with
  ///   UIPickerView in <see cref="TPickerServiceiOS"/>
  /// </summary>
  TPickerDataSource = class (TOCLocal, UIPickerViewDataSource)
  strict private
    FValues: NSArray;
  public
    { UIPickerViewDataSource }
    function numberOfComponentsInPickerView(pickerView: UIPickerView): NSInteger; cdecl;
    function pickerView(pickerView: UIPickerView; numberOfRowsInComponent: NSInteger): NSInteger; cdecl;

    constructor Create(const AValues: NSArray);
    destructor Destroy; override;
    property Values: NSArray read FValues write FValues;
  end;

  TPickerDelegate = class (TOCLocal, UIPickerViewDelegate)
  strict private
    FValues: NSArray;
  public
    constructor Create(const AValues: NSArray);
    destructor Destroy; override;
    { UIPickerViewDelegate }
//    procedure pickerView(pickerView: UIPickerView; didSelectRow: NSInteger; inComponent: NSInteger); cdecl;
//    function pickerView(pickerView: UIPickerView; rowHeightForComponent: NSInteger): Single; cdecl; overload;
    function pickerView(pickerView: UIPickerView; titleForRow: NSInteger; forComponent: NSInteger): NSString; cdecl;
//    function pickerView(pickerView: UIPickerView; viewForRow: NSInteger; forComponent: NSInteger; reusingView: UIView): UIView; cdecl; overload;
//    function pickerView(pickerView: UIPickerView; widthForComponent: NSInteger): Single; cdecl; overload;
    property Values: NSArray read FValues write FValues;
  end;

{$ENDREGION}

{ TCocoaDateTimePicker }

  TCocoaDateTimePicker = class (TCustomDateTimePicker)
  strict private
    FPopupDateTimePicker: TDateTimePopupDialog;
  public
    constructor Create(const APickerService: TPickerFactoryService);
    destructor Destroy; override;
    procedure Show; override;
    procedure Hide; override;
    function IsShown: Boolean; override;
  end;

{ TCocoaListPicker }

  TCocoaListPicker = class (TCustomListPicker)
  strict private
    FPopupListPicker: TListBoxPopupDialog;
  public
    constructor Create(const APickerService: TPickerFactoryService);
    destructor Destroy; override;
    procedure Show; override;
    procedure Hide; override;
    function IsShown: Boolean; override;
  end;

{ Picker Service }

  TCocoaPickerService = class (TPickerFactoryService)
  protected
    function DoCreateDateTimePicker: TCustomDateTimePicker; override;
    function DoCreateListPicker: TCustomListPicker; override;
  end;

var
  PickerService: TPickerFactoryService;

procedure RegisterPickersService;
begin
  PickerService := TCocoaPickerService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXPickerService, PickerService);
end;

procedure UnregisterPickersService;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXPickerService);
  PickerService := nil;
end;

{$REGION 'Objective C - Delphi Helpers'}

function GetTimeZone: Integer;
begin
  Result := TNSTimeZone.Wrap(TNSTimeZone.OCClass.localTimeZone).secondsFromGMT;
end;

function DateTimeToNSDate(const ADateTime: TDateTime): NSDate;
var
  IntervalInterval: NSTimeInterval;
begin
  IntervalInterval := (ADateTime  - EncodeDate(2001, 1, 1)) * SecsPerDay;
  Result := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceReferenceDate(IntervalInterval));
end;

function NSDateToDateTime(const ANSDate: NSDate): TDateTime;
begin
  Result := (ANSDate.TimeIntervalSince1970) / SecsPerDay + EncodeDate(1970, 1, 1);
end;

function GetSharedApplication: UIApplication;
begin
  Result := TUIApplication.Wrap(TUIApplication.OCClass.sharedApplication);
end;

function GetMainScreen: UIScreen;
begin
  Result := TUIScreen.Wrap(TUIScreen.OCClass.mainScreen);
end;

function GetDefaultNotificationCenter: NSNotificationCenter;
begin
  Result := TNSNotificationCenter.Wrap(TNSNotificationCenter.OCClass.defaultCenter);
end;

function IsPad: Boolean;
begin
  Result := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).userInterfaceIdiom = UIUserInterfaceIdiomPad;
end;

{$ENDREGION}

{ TCocoaPickerSerivce }

function TCocoaPickerService.DoCreateDateTimePicker: TCustomDateTimePicker;
begin
  Result := TCocoaDateTimePicker.Create(Self);
end;

function TCocoaPickerService.DoCreateListPicker: TCustomListPicker;
begin
  Result := TCocoaListPicker.Create(Self);
end;

{ TCocoaDateTimePicker }

constructor TCocoaDateTimePicker.Create(const APickerService: TPickerFactoryService);
begin
  inherited Create(APickerService);
  FPopupDateTimePicker := TDateTimePopupDialog.Create;
end;

destructor TCocoaDateTimePicker.Destroy;
begin
  FreeAndNil(FPopupDateTimePicker);
  inherited Destroy;
end;

procedure TCocoaDateTimePicker.Hide;
begin
  if IsShown then
    FPopupDateTimePicker.Hide;
end;

function TCocoaDateTimePicker.IsShown: Boolean;
begin
  Result := FPopupDateTimePicker.PickerState = TPickerState.psShowed;
end;

procedure TCocoaDateTimePicker.Show;
begin
  FPopupDateTimePicker.ParentControl := Parent;
  FPopupDateTimePicker.Kind := ShowMode;
  FPopupDateTimePicker.DateTime := Date;
  FPopupDateTimePicker.OnDateChanged := OnDateChanged;
  FPopupDateTimePicker.OnHide := OnHide;
  FPopupDateTimePicker.OnShow := OnShow;

  FPopupDateTimePicker.Show;
end;

{ TPopupDialog }

procedure TPopupDialog.Cancel;
begin
  DoCancel;
  Hide;
end;

constructor TPopupDialog.Create;
var
  PickerFrame: NSRect;
  Buttons: NSMutableArray;
begin
  inherited Create;

  //Subscribing to change orientation events
  GetDefaultNotificationCenter.addObserver(GetObjectID, sel_getUid('StartChangeDeviceOrientation:'),
    (NSSTR(FMXStartChangeDeviceOrientation) as ILocalObject).GetObjectID, nil);

  // Root view
  FUIContainerView := TUIView.Create;
  PickerFrame := GetPopupFrame;
  FUIContainerView.setFrame(PickerFrame);

  if IsPad then
  begin
    FUIPopoverContent := TUIViewController.Create;
    FUIPopoverContent.setView(FUIContainerView);
    FUIPopoverContent.setContentSizeForViewInPopover(PickerFrame.size);
    FUIPopoverController := TUIPopoverController.Alloc;
    FUIPopoverController.initWithContentViewController(FUIPopoverContent);
    FUIPopoverDelegate := TPopoverDelegate.Create(Self);
    FUIPopoverController.setDelegate(FUIPopoverDelegate.GetObjectID);
  end;

  // Toolbar
  FUIToolBar := TUIToolbar.Create;
  FUIToolBar.setBarStyle(UIBarStyleBlackOpaque);
  FUIToolBar.setFrame(GetToolbarFrame);
  FUIToolBar.setAlpha(0.8);
  FUIContainerView.addSubview(FUIToolBar);
  FUIToolBar.setAutoresizingMask(UIViewAutoresizingFlexibleWidth);
  Buttons := TNSMutableArray.Create;

  // Close Button
  FUICloseButton := TUIBarButtonItem.Create;
  FUICloseButton.setTitle(NSSTR(SPickerCancel));
  FUICloseButton.setStyle(UIBarButtonItemStyleBordered);
  FUICloseButton.setTarget(Self.GetObjectID);
  FUICloseButton.setAction(sel_getUid('Cancel'));
  Buttons.addObject(ILocalObject(FUICloseButton).GetObjectID);

  // Flexible Separator
  FUIFlexibleSepararator := TUIBarButtonItem.Create;
  FUIFlexibleSepararator.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, nil, nil);
  Buttons.addObject(ILocalObject(FUIFlexibleSepararator).GetObjectID);

                
  FUIDoneButton := TUIBarButtonItem.Create;
  FUIDoneButton.setTitle(NSSTR(SPickerDone));
  FUIDoneButton.setStyle(UIBarButtonItemStyleDone);
  FUIDoneButton.setTarget(Self.GetObjectID);
  FUIDoneButton.setAction(sel_getUid('Done'));
  Buttons.addObject(ILocalObject(FUIDoneButton).GetObjectID);

  // Add button to Toolbar
  FUIToolBar.setItems(Buttons);
end;

function TPopupDialog.GetPopupFrame: NSRect;
var
  ScreenRect: NSRect;
begin
  ScreenRect := GetMainScreen.applicationFrame;
  if IsPad then
  begin
    Result.origin.x := 0;
    Result.origin.y := 0;
    Result.size.width := 320;
    Result.size.height := 260;
  end
  else
  begin
    case TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).orientation of
      UIDeviceOrientationUnknown,
      UIDeviceOrientationFaceDown,
      UIDeviceOrientationFaceUp,
      UIDeviceOrientationPortrait,
      UIDeviceOrientationPortraitUpsideDown:
        begin
          Result.origin.x := 0;
          Result.origin.y := ScreenRect.size.height - 260;
          Result.size.width := 320;
          Result.size.height := 260;
        end;
      UIDeviceOrientationLandscapeLeft,
      UIDeviceOrientationLandscapeRight:
        begin
          Result.origin.x := 0;
          Result.origin.y := ScreenRect.size.width - 260;
          Result.size.width := ScreenRect.size.height;
          Result.size.height := 260;
        end;
    end;
  end;
end;

destructor TPopupDialog.Destroy;
begin
  GetDefaultNotificationCenter.removeObserver(GetObjectID);
  FUIDoneButton.release;
  FUIFlexibleSepararator.release;
  FUICloseButton.release;
  FUIToolBar.release;
  FUIContainerView.release;
  if IsPad then
  begin
    FUIPopoverContent.release;
    FUIPopoverController.release;
    FUIPopoverDelegate.Free;
  end;
  inherited Destroy;
end;

procedure TPopupDialog.DoCancel;
begin
  // Nothing
end;

procedure TPopupDialog.DoDone;
begin
  // Nothing
end;

procedure TPopupDialog.DoHide;
begin
  FPickerState := TPickerState.psHidden;
  if Assigned(FOnHide) then
    FOnHide(FParentControl);
  if Assigned(Screen.ActiveForm) then
    Screen.ActiveForm.Focused := nil;
end;

procedure TPopupDialog.Done;
begin
  DoDone;
  Hide;
end;

procedure TPopupDialog.DoPopoverDismiss;
begin
  DoHide;
end;

procedure TPopupDialog.DoShow;
begin
  FPickerState := TPickerState.psShowed;
  if Assigned(FOnShow) then
    FOnShow(FParentControl);
end;

function TPopupDialog.GetToolbarFrame: NSRect;
begin
  Result := GetPopupFrame;
  Result.origin.x := 0;
  Result.origin.y := 0;
  Result.size.height := 44;
end;

function TPopupDialog.GetContentFrame: NSRect;
var
  ToolBarFrame: NSRect;
begin
  Result := GetPopupFrame;
  ToolBarFrame := GetToolbarFrame;
  Result.origin.x := 0;
  Result.origin.y := ToolBarFrame.origin.y +  ToolBarFrame.size.height;
  Result.size.height := Result.size.height - ToolBarFrame.size.height;
end;

function TPopupDialog.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IDialogActions);
end;

procedure TPopupDialog.Hidden;
begin
  if not IsPad and (FPickerState = TPickerState.psHidden) then
    FUIContainerView.removeFromSuperview;
end;

procedure TPopupDialog.Hide;
var
  EndFrame: NSRect;
begin
  if not Assigned(FUIContainerView.superview) then
    Exit;

  if IsPad then
    FUIPopoverController.dismissPopoverAnimated(True)
  else
  begin
    EndFrame := GetPopupFrame;
    EndFrame.origin.y := EndFrame.origin.y + EndFrame.size.height;

    // Start Slide down Animation
    TUIView.OCClass.beginAnimations(nil, nil);
    try
      TUIView.OCClass.setAnimationDuration(0.3);
      FUIContainerView.setFrame(EndFrame);
      TUIView.OCClass.setAnimationDelegate(Self.GetObjectID);
      TUIView.OCClass.setAnimationDidStopSelector(sel_getUid('Hidden'))
    finally
      TUIView.OCClass.commitAnimations;
    end;
  end;
  DoHide;
end;

procedure TPopupDialog.Show;
var
  StartFrame: CGRect;
  EndFrame: NSRect;
  AbsolutePos: TPointF;
begin
  if IsPad then
  begin
    AbsolutePos := FParentControl.LocalToAbsolute(PointF(0, 0));
    FUIPopoverController.presentPopoverFromRect(
     CGRectMake(AbsolutePos.X, AbsolutePos.Y, FParentControl.Width, FParentControl.Height) , GetSharedApplication.keyWindow.rootViewController.view,
     UIPopoverArrowDirectionAny, True);
  end
  else
  begin
    GetSharedApplication.keyWindow.rootViewController.view.addSubview(FUIContainerView);
    // Setting animation
    StartFrame := GetPopupFrame;
    EndFrame := StartFrame;
    StartFrame.origin.y := StartFrame.origin.y + StartFrame.size.height;
    FUIContainerView.setFrame(StartFrame);

    // Start Animation
    TUIView.OCClass.beginAnimations(nil, nil);
    try
      TUIView.OCClass.setAnimationDuration(0.3);
      FUIContainerView.setFrame(EndFrame);
    finally
      TUIView.OCClass.commitAnimations;
    end;
  end;
  DoShow;
end;

procedure TPopupDialog.StartChangeDeviceOrientation(notification: Pointer);
begin
  FUIContainerView.setFrame(GetPopupFrame);
end;

{ TCocoaListPicker }

constructor TCocoaListPicker.Create(const APickerService: TPickerFactoryService);
begin
  inherited Create(APickerService);
  FPopupListPicker := TListBoxPopupDialog.Create;
end;

destructor TCocoaListPicker.Destroy;
begin
  FreeAndNil(FPopupListPicker);
  inherited Destroy;
end;

procedure TCocoaListPicker.Hide;
begin
  if IsShown then
    FPopupListPicker.Hide;
end;

function TCocoaListPicker.IsShown: Boolean;
begin
  Result := FPopupListPicker.PickerState = TPickerState.psShowed;
end;

procedure TCocoaListPicker.Show;
begin
  if Values.Count = 0 then
    Exit;

  FPopupListPicker.ParentControl := Parent;
  FPopupListPicker.Values := Values;
  FPopupListPicker.ItemIndex := ItemIndex;
  FPopupListPicker.OnValueChanged := OnValueChanged;
  FPopupListPicker.OnHide := OnHide;
  FPopupListPicker.OnShow := OnShow;
  FPopupListPicker.Show;
end;

{ TDateTimePopupDialog }

constructor TDateTimePopupDialog.Create;
var
  PickerView: UIPickerView;
begin
  inherited Create;

  // Date picker                                              
  FDateTimePicker := TUIDatePicker.Alloc;
  FDateTimePicker.initWithFrame(GetContentFrame);
  FDateTimePicker.setTimeZone(TNSTimeZone.Wrap(TNSTimeZone.OCClass.timeZoneForSecondsFromGMT(0)));

  // Date picker isn't expanded on width by default like as UIPickerView.
  // Therefore that it was aligned it is necessary to receive UIPickerView
  // from child's views.
  if FDateTimePicker.subviews.count > 0 then
  begin
    PickerView := TUIPickerView.Wrap(FDateTimePicker.subviews.objectAtIndex(0));
    PickerView.setAutoresizingMask(UIViewAutoresizingFlexibleWidth or UIViewAutoresizingFlexibleLeftMargin or UIViewAutoresizingFlexibleRightMargin);
  end;
  FDateTimePicker.setAutoresizingMask(UIViewAutoresizingFlexibleWidth or UIViewAutoresizingFlexibleLeftMargin or UIViewAutoresizingFlexibleRightMargin);
  FUIContainerView.addSubview(FDateTimePicker);
end;

destructor TDateTimePopupDialog.Destroy;
begin
  FDateTimePicker.release;
  inherited Destroy;
end;

procedure TDateTimePopupDialog.DoDateChanged;
begin
  if Assigned(FOnDateChanged) then
    FOnDateChanged(FParentControl, DateTime);
end;

procedure TDateTimePopupDialog.DoDone;
begin
  DoDateChanged;
end;

function TDateTimePopupDialog.GetDateTime: TDateTime;
begin
  Result := NSDateToDateTime(FDateTimePicker.date);
end;

function TDateTimePopupDialog.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IDateTimeDialogActions);
end;

procedure TDateTimePopupDialog.SetDateTime(const Value: TDateTime);
begin
  FDateTimePicker.setDate(DateTimeToNSDate(Value));
end;

procedure TDateTimePopupDialog.SetShowMode(const Value: TDatePickerShowMode);
var
  DatePickerMode: UIDatePickerMode;
begin
  case Value of
    psmDate: DatePickerMode := UIDatePickerModeDate;
    psmTime: DatePickerMode := UIDatePickerModeTime;
    psmDateTime: DatePickerMode := UIDatePickerModeDateAndTime;
  else
    DatePickerMode := UIDatePickerModeDateAndTime;
  end;
  FDateTimePicker.setDatePickerMode(DatePickerMode);
end;

{ TListBoxPopupDialog }

constructor TListBoxPopupDialog.Create;
begin
  inherited Create;
  FValues := TNSMutableArray.Create;

  // ListBox picker
  FListBoxPicker := TUIPickerView.Create;
  FListBoxPicker.setFrame(GetContentFrame);
  FListBoxPicker.setShowsSelectionIndicator(True);
  FListBoxPicker.setAutoresizingMask(UIViewAutoresizingFlexibleWidth);
  FDelegate := TPickerDelegate.Create(FValues);
  FDataSource := TPickerDataSource.Create(FValues);
  FListBoxPicker.setDataSource(FDataSource.GetObjectID);
  FListBoxPicker.setDelegate(FDelegate.GetObjectID);
  FUIContainerView.addSubview(FListBoxPicker);
end;

destructor TListBoxPopupDialog.Destroy;
begin
  FValues.release;
  FListBoxPicker.release;
  inherited Destroy;
end;

procedure TListBoxPopupDialog.DoDone;
begin
  DoValueChanged;
end;

procedure TListBoxPopupDialog.DoValueChanged;
begin
  if Assigned(FOnValueChanged) and (FValues.count > 0) then
    FOnValueChanged(FParentControl, FListBoxPicker.selectedRowInComponent(0));
end;

function TListBoxPopupDialog.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IListBoxDialogActions);
end;

procedure TListBoxPopupDialog.SetItemIndex(const Value: Integer);
begin
  FListBoxPicker.selectRow(Value, 0, False);
end;

procedure TListBoxPopupDialog.SetValues(const AValues: TStrings);
var
  I: Integer;
  OCValue: NSString;
begin
  Assert(Assigned(AValues), 'AValue can not be nil');

  FValues.removeAllObjects;
  for I := 0 to AValues.Count - 1 do
  begin
    if AValues[I].IsEmpty then
      OCValue := TNSString.Create
    else
      OCValue := NSStr(AValues[I]);
    FValues.addObject((OCValue as ILocalObject).GetObjectID)
  end;
  FDelegate.Values := FValues;
  FDataSource.Values := FValues;
  FListBoxPicker.reloadAllComponents;
end;

{ TPickerDataSource }

constructor TPickerDataSource.Create(const AValues: NSArray);
begin
  inherited Create;
  FValues := AValues;
end;

destructor TPickerDataSource.Destroy;
begin
  FValues := nil;
  inherited Destroy;
end;

function TPickerDataSource.numberOfComponentsInPickerView(
  pickerView: UIPickerView): NSInteger;
begin
  Result := 1;
end;

function TPickerDataSource.pickerView(pickerView: UIPickerView;
  numberOfRowsInComponent: NSInteger): NSInteger;
begin
  Result := FValues.count;
end;

{ TPickerDelegate }

constructor TPickerDelegate.Create(const AValues: NSArray);
begin
  inherited Create;
  FValues := AValues;
end;

destructor TPickerDelegate.Destroy;
begin
  FValues := nil;
  inherited;
end;

function TPickerDelegate.pickerView(pickerView: UIPickerView; titleForRow,
  forComponent: NSInteger): NSString;
begin
  Result := TNSString.Wrap(FValues.objectAtIndex(titleForRow));
end;

{ TPopoverDelegate }

constructor TPopoverDelegate.Create(const APopupDialog: TPopupDialog);
begin
  inherited Create;
  FPopupDialog := APopupDialog;
end;

procedure TPopoverDelegate.popoverControllerDidDismissPopover(
  popoverController: UIPopoverController);
begin
  FPopupDialog.DoPopoverDismiss;
end;

function TPopoverDelegate.popoverControllerShouldDismissPopover(
  popoverController: UIPopoverController): Boolean;
begin
  Result := True;
end;

end.
