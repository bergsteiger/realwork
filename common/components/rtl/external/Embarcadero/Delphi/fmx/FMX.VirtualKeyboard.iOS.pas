{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2013 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit FMX.VirtualKeyboard.iOS;

interface

procedure RegisterVirtualKeyboardServices;
procedure UnregisterVirtualKeyboardServices;

implementation

uses
  System.Classes, System.SysUtils, System.TypInfo, System.Generics.Collections,
  System.UITypes, System.Types,
  Macapi.ObjectiveC, Macapi.ObjCRuntime, 
  iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.UIKit, 
  FMX.Types, FMX.VirtualKeyboard, FMX.Platform, FMX.Forms,
  FMX.Platform.iOS, FMX.Messages;

const
  TOOLBAR_HEIGHT = 44;

type
  IKeyboardEvents = interface(NSObject)
  ['{72D3A7FD-DDE3-473D-9750-46C072E7B3B7}']
    { Keyboard notifications }
    procedure KeyboardWillShow(notification: Pointer); cdecl;
    procedure KeyboardWillHide(notification: Pointer); cdecl;
    procedure KeyboardWillChangeFrame(notification: Pointer); cdecl;
    { Actions }
    procedure HideVirtualKeyboard; cdecl;
    procedure CustomButtonAction(sender: Pointer); cdecl;
    { Orientation notification }
    procedure DeviceOrientationChangeNotification(notification: Pointer); cdecl;
  end;

  TKeyboardEventHandler = class(TOCLocal)
  strict private type
    TKeyboardState = (ksShowed, ksHidden);
    { Keyborad Notifications }
    procedure SendNotificationAboutKeyboardEvent(const AVKRect: TRect; AKeyboardState :TKeyboardState);
    function GetKeyboardRect(Notification: Pointer): TRect;
  protected
    { TOCLocal }
    function GetObjectiveCClass: PTypeInfo; override;
  public
    { IKeyboardEvents }
    procedure KeyboardWillShow(notification: Pointer); cdecl;
    procedure KeyboardWillHide(notification: Pointer); cdecl;
    procedure KeyboardWillChangeFrame(notification: Pointer); cdecl;
    procedure HideVirtualKeyboard; cdecl;
    procedure CustomButtonAction(sender: Pointer); cdecl;
    procedure DeviceOrientationChangeNotification(notification: Pointer); cdecl;
  end;

  TCocoaVirtualKeyboardService = class(TInterfacedObject,
    IFMXVirtualKeyboardService,
    IFMXVirtualKeyboardToolbarService)
  private
    FKeyboardHandler: TKeyboardEventHandler;
    { IFMXVirtualKeyboardToolbarService }
    FToolbarVisible: Boolean;
    FToolBar: UIToolBar;
    FFlexibleSepararator: UIBarButtonItem;
    FHideButton: UIBarButtonItem;
    FButtons: TList<TVirtualKeyboardToolButton>;
    FUpdatingButtons: Boolean;
    FToolbarEnabled: Boolean;
    FHideButtonVisible: Boolean;
    FStoredActiveForm: TComponent;
    procedure SetToolbarVisible(const Value: Boolean);
    procedure SetToolbarFrame(const Frame: NSRect; const UseAnimation: Boolean);
    function GetToolbarFrame: NSRect;
    procedure RefreshToolbarButtons;
    procedure CreateToolbar;
    procedure ChangeToolbarOrientation;
    //
    property ToolbarVisible: Boolean read FToolbarVisible write SetToolbarVisible;
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXVirtualKeyboardService }
    function ShowVirtualKeyboard(const AControl: TFmxObject): Boolean;
    function HideVirtualKeyboard: Boolean;
    function GetVirtualKeyBoardState: TVirtualKeyBoardState;
    property VirtualKeyBoardState: TVirtualKeyBoardState read GetVirtualKeyBoardState;
    { IFMXVirtualKeyboardToolbarService }
    procedure SetToolbarEnabled(const Value: Boolean);
    function IsToolbarEnabled: Boolean;
    procedure SetHideKeyboardButtonVisibility(const Value: Boolean);
    function IsHideKeyboardButtonVisible: Boolean;
    function AddButton(const Title: string; ExecuteEvent: TNotifyEvent): TVirtualKeyboardToolButton;
    procedure DeleteButton(const Index: Integer);
    function ButtonsCount: Integer;
    function GetButtonByIndex(const Index: Integer): TVirtualKeyboardToolButton;
    procedure ClearButtons;
  end;

  TVKToolbarButton_iOS = class(TVirtualKeyboardToolButton)
  protected
    procedure DoChanged; override;
  end;

var
  CocoaKeyboardService: TCocoaVirtualKeyboardService;


procedure RegisterVirtualKeyboardServices;
begin
  CocoaKeyboardService := TCocoaVirtualKeyboardService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXVirtualKeyboardService, CocoaKeyboardService);
  TPlatformServices.Current.AddPlatformService(IFMXVirtualKeyboardToolbarService, CocoaKeyboardService);
end;

procedure UnregisterVirtualKeyboardServices;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXVirtualKeyboardService);
  TPlatformServices.Current.RemovePlatformService(IFMXVirtualKeyboardToolbarService);
  FreeAndNil(CocoaKeyboardService);
end;

{ TVirtualKeyboardEventHandler }

procedure TKeyboardEventHandler.CustomButtonAction(sender: Pointer);
var
  Index: Integer;
begin
  Index := TUIBarButtonItem.Wrap(sender).tag - 1;
  if Index >= 0 then
    TVKToolbarButton_iOS(CocoaKeyboardService.FButtons[Index]).DoExecute;
end;

procedure TKeyboardEventHandler.DeviceOrientationChangeNotification(notification: Pointer);
begin
  CocoaKeyboardService.ChangeToolbarOrientation;
end;

function TKeyboardEventHandler.GetKeyboardRect(Notification: Pointer): TRect;
var
  OCRect: NSRect;
  ScreenService: IFMXScreenService;
  Orientation: TScreenOrientation;
begin
  OCRect := iOSapi.UIKit.TNSValue.Wrap(TNSNotification.Wrap(Notification).userInfo.valueForKey(NSSTR('UIKeyboardFrameEndUserInfoKey'))).CGRectValue;
  Orientation := TScreenOrientation.soPortrait;
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenService)) then
    Orientation := ScreenService.GetScreenOrientation;

  case Orientation of
  TScreenOrientation.soPortrait,
  TScreenOrientation.soInvertedPortrait:
    Result := TRect.Create(Point(Round(OCRect.origin.x), Round(OCRect.origin.y)), Round(OCRect.size.width), Round(OCRect.size.height));
  TScreenOrientation.soLandscape,
  TScreenOrientation.soInvertedLandscape:
    Result := TRect.Create(Point(Round(OCRect.origin.y), Round(OCRect.origin.x)), Round(OCRect.size.height), Round(OCRect.size.width));
  end;
end;

function TKeyboardEventHandler.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IKeyboardEvents);
end;

procedure TKeyboardEventHandler.HideVirtualKeyboard;
begin
  try
    Screen.ActiveForm.Focused := nil;
  except
    Application.HandleException(Screen.ActiveForm);
  end;
end;

procedure TKeyboardEventHandler.KeyboardWillChangeFrame(
  notification: Pointer);
begin

end;

procedure TKeyboardEventHandler.KeyboardWillHide(notification: Pointer);
var
  VKRect: TRect;
begin
  CocoaKeyboardService.ToolbarVisible := False;
  VKRect := GetKeyboardRect(notification);
  SendNotificationAboutKeyboardEvent(VKRect, TKeyboardState.ksHidden);
end;

procedure TKeyboardEventHandler.KeyboardWillShow(notification: Pointer);
var
  VKRect: TRect;
begin
  VKRect := GetKeyboardRect(notification);
  CocoaKeyboardService.CreateToolbar;
  CocoaKeyboardService.ToolbarVisible := True;
  if CocoaKeyboardService.IsToolbarEnabled then
    VKRect.Top := VKRect.Top - TOOLBAR_HEIGHT;
  SendNotificationAboutKeyboardEvent(VKRect, TKeyboardState.ksShowed);
end;

procedure TKeyboardEventHandler.SendNotificationAboutKeyboardEvent(const AVKRect: TRect;
  AKeyboardState: TKeyboardState);
var
  Message: TVKStateChangeMessage;
begin
  Message := TVKStateChangeMessage.Create(AKeyboardState = TKeyboardState.ksShowed, AVKRect);
  TMessageManager.DefaultManager.SendMessage(Self, Message, True);
end;

type
  TStoredActiveForm = class (TComponent)
  private
    [weak]FForm: TCommonCustomForm;
    procedure SetForm(const Value: TCommonCustomForm);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    property Form: TCommonCustomForm read FForm write SetForm;
  end;

{ TStoredActiveForm }

procedure TStoredActiveForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FForm then
      FForm := nil;
  end;
end;

procedure TStoredActiveForm.SetForm(const Value: TCommonCustomForm);
begin
  if FForm <> Value then
  begin
    if Assigned(FForm) then
    begin
      //if Assigned(FForm.Handle) then
      //  WindowHandleToPlatform(FForm.Handle).View.resignFirstResponder;
      TComponent(FForm).RemoveFreeNotification(self);
      FForm := nil;
    end;
    FForm := Value;
    if Assigned(FForm) then
    begin
      TComponent(FForm).FreeNotification(self);
    end;
  end;
end;


{ TCocoaVirtualKeyboardToolbarService }

function TCocoaVirtualKeyboardService.AddButton(const Title: string;
  ExecuteEvent: TNotifyEvent): TVirtualKeyboardToolButton;
begin
  FUpdatingButtons := True;
  Result := TVKToolbarButton_iOS.Create;
  Result.Title := Title;
  Result.OnExecute := ExecuteEvent;
  FUpdatingButtons := False;
  FButtons.Add(Result);
  RefreshToolbarButtons;
end;

function TCocoaVirtualKeyboardService.ButtonsCount: Integer;
begin
  Result := FButtons.Count;
end;

procedure TCocoaVirtualKeyboardService.ChangeToolbarOrientation;
begin
  //Need to change orientation without animation
  if Assigned(FToolBar) then
    SetToolbarFrame(GetToolbarFrame, False);
end;

procedure TCocoaVirtualKeyboardService.ClearButtons;
begin
  if FButtons.Count > 0 then
  begin
    FUpdatingButtons := True;
    FButtons.Clear;
    FUpdatingButtons := False;
    RefreshToolbarButtons;
  end;
end;

constructor TCocoaVirtualKeyboardService.Create;
begin
  inherited Create;
  FStoredActiveForm := TStoredActiveForm.Create(nil);
  FKeyboardHandler := TKeyboardEventHandler.Create;
  //Subscribing to events
  TNSNotificationCenter.Wrap(TNSNotificationCenter.OCClass.defaultCenter).addObserver(
    FKeyboardHandler.GetObjectID,
    sel_getUid('KeyboardWillShow:'),
    (NSSTR('UIKeyboardWillShowNotification') as ILocalObject).GetObjectID,
    nil);
  TNSNotificationCenter.Wrap(TNSNotificationCenter.OCClass.defaultCenter).addObserver(
    FKeyboardHandler.GetObjectID,
    sel_getUid('KeyboardWillHide:'),
    (NSSTR('UIKeyboardWillHideNotification') as ILocalObject).GetObjectID,
    nil);
  TNSNotificationCenter.Wrap(TNSNotificationCenter.OCClass.defaultCenter).addObserver(
    FKeyboardHandler.GetObjectID,
    sel_getUid('KeyboardWillChangeFrame:'),
    (NSSTR('UIKeyboardWillChangeFrameNotification') as ILocalObject).GetObjectID,
    nil);
  TNSNotificationCenter.Wrap(TNSNotificationCenter.OCClass.defaultCenter).addObserver(
    FKeyboardHandler.GetObjectID,
    sel_getUid('DeviceOrientationChangeNotification:'),
    (NSSTR(FMXStartChangeDeviceOrientation) as ILocalObject).GetObjectID,
    nil);

  //IFMXVirtualKeyboardToolbarService
  FUpdatingButtons := False;
  FToolbarVisible := False;
  FButtons := TList<TVirtualKeyboardToolButton>.Create;
  //
  FToolbarEnabled := (TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).userInterfaceIdiom = UIUserInterfaceIdiomPhone);
  FHideButtonVisible := (TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).userInterfaceIdiom = UIUserInterfaceIdiomPhone);
end;

procedure TCocoaVirtualKeyboardService.CreateToolbar;
var
  SharedApplication: UIApplication;
  KeyWindow: UIWindow;
begin
  SharedApplication := TUIApplication.Wrap(TUIApplication.OCClass.sharedApplication);
  KeyWindow := SharedApplication.keyWindow;
  if Assigned(KeyWindow) and Assigned(KeyWindow.rootViewController) then
  begin
    if not Assigned(FToolBar) and FToolbarEnabled then
    begin
      FToolBar := TUIToolbar.Create;
      FToolBar.setBarStyle(UIBarStyleBlackOpaque);
      FToolBar.setAlpha(0.8);
      SetToolbarFrame(GetToolbarFrame, False);
      RefreshToolbarButtons;
      KeyWindow.rootViewController.view.addSubview(FToolbar);
    end
    else
      KeyWindow.rootViewController.view.bringSubviewToFront(FToolbar);
  end;
end;

procedure TCocoaVirtualKeyboardService.DeleteButton(
  const Index: Integer);
begin
  if (Index >= 0) and (Index < FButtons.Count) then
  begin
    FButtons.Delete(Index);
    RefreshToolbarButtons;
  end;
end;

destructor TCocoaVirtualKeyboardService.Destroy;
begin
  TNSNotificationCenter.Wrap(TNSNotificationCenter.OCClass.defaultCenter).removeObserver(FKeyboardHandler.GetObjectID);
  FreeAndNil(FKeyboardHandler);
  //IFMXVirtualKeyboardToolbarService
  FUpdatingButtons := True;
  FreeAndNil(FButtons);
  if Assigned(FToolBar) then
  begin
    if Assigned(FToolBar.items) then
      FToolBar.items.release;
    FToolBar.release;
    FToolBar := nil;
  end;
  if Assigned(FFlexibleSepararator) then
  begin
    FFlexibleSepararator.release;
    FFlexibleSepararator := nil;
  end;
  if Assigned(FHideButton) then
  begin
    FHideButton.release;
    FHideButton := nil;
  end;
  FreeAndNil(FStoredActiveForm);
  inherited;
end;

function TCocoaVirtualKeyboardService.GetButtonByIndex(
  const Index: Integer): TVirtualKeyboardToolButton;
begin
  if (Index >= 0) and (Index < FButtons.Count) then
    Result := FButtons[Index]
  else
    Result := nil;
end;

function TCocoaVirtualKeyboardService.GetToolbarFrame: NSRect;
var
  ScreenRect: NSRect;
begin
  ScreenRect := TUIScreen.Wrap(TUIScreen.OCClass.mainScreen).applicationFrame;
  Result.origin.x := 0;
  Result.size.height := TOOLBAR_HEIGHT;
  case TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).orientation of
    UIDeviceOrientationUnknown,
    UIDeviceOrientationFaceDown,
    UIDeviceOrientationFaceUp,
    UIDeviceOrientationPortrait,
    UIDeviceOrientationPortraitUpsideDown:
      begin
        if ToolbarVisible then
          if TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).userInterfaceIdiom = UIUserInterfaceIdiomPhone then
            Result.origin.y := ScreenRect.size.height - 260
          else
            Result.origin.y := ScreenRect.size.height - 308
        else
          Result.origin.y := ScreenRect.size.height;
        Result.size.width := ScreenRect.size.width;
      end;
    UIDeviceOrientationLandscapeLeft,
    UIDeviceOrientationLandscapeRight:
      begin
        if ToolbarVisible then
          if TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).userInterfaceIdiom = UIUserInterfaceIdiomPhone then
            Result.origin.y := ScreenRect.size.width - 206
          else
            Result.origin.y := ScreenRect.size.width - 396
        else
          Result.origin.y := ScreenRect.size.width;
        Result.size.width := ScreenRect.size.height;
      end;
  end;
end;

function TCocoaVirtualKeyboardService.GetVirtualKeyBoardState: TVirtualKeyBoardState;
begin
  Result := [vksAutoShow];
end;

function TCocoaVirtualKeyboardService.IsHideKeyboardButtonVisible: Boolean;
begin
  Result := FHideButtonVisible;
end;

function TCocoaVirtualKeyboardService.IsToolbarEnabled: Boolean;
begin
  Result := FToolbarEnabled;
end;

procedure TCocoaVirtualKeyboardService.RefreshToolbarButtons;
var
  Buttons: NSMutableArray;
  I: Integer;
  B: UIBarButtonItem;
begin
  if not FUpdatingButtons and Assigned(FToolBar) then
  begin
    if Assigned(FToolBar.items) then
    begin
      FToolBar.items.release;
      FFlexibleSepararator := nil;
      FHideButton := nil;
    end;

    Buttons := TNSMutableArray.Create;

    //Custom buttons
    for I := 0 to FButtons.Count - 1 do
    begin
      B := TUIBarButtonItem.Create;
      B.setTitle(NSSTR(FButtons[I].Title));
      B.setStyle(UIBarButtonItemStyleBordered);
      B.setTag(I + 1);
      B.setTarget(FKeyboardHandler.GetObjectID);
      B.setAction(sel_getUid('CustomButtonAction:'));
      B.setEnabled(False);
      Buttons.addObject(ILocalObject(B).GetObjectID);
    end;

    if FHideButtonVisible then
    begin
      //Separator
      if not Assigned(FFlexibleSepararator) then
      begin
        FFlexibleSepararator := TUIBarButtonItem.Create;
        FFlexibleSepararator.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, nil, nil);
      end;
      Buttons.addObject(ILocalObject(FFlexibleSepararator).GetObjectID);

      //Hide button
      if not Assigned(FHideButton) then
      begin
        FHideButton := TUIBarButtonItem.Create;
        FHideButton.setTitle(NSSTR('Done'));
        FHideButton.setStyle(UIBarButtonItemStyleDone);
        FHideButton.setTarget(FKeyboardHandler.GetObjectID);
        FHideButton.setAction(sel_getUid('HideVirtualKeyboard'));
      end;
      Buttons.addObject(ILocalObject(FHideButton).GetObjectID);
    end;

    FToolBar.setItems(Buttons);
  end;
end;

procedure TCocoaVirtualKeyboardService.SetHideKeyboardButtonVisibility(
  const Value: Boolean);
begin
  if FHideButtonVisible <> Value then
  begin
    FHideButtonVisible := Value;
    RefreshToolbarButtons;
  end;
end;

procedure TCocoaVirtualKeyboardService.SetToolbarEnabled(
  const Value: Boolean);
begin
  if FToolbarEnabled <> Value then
  begin
    if not Value then
      ToolbarVisible := False;
    FToolbarEnabled := Value;
  end;
end;

procedure TCocoaVirtualKeyboardService.SetToolbarFrame(
  const Frame: NSRect; const UseAnimation: Boolean);
begin
  if Assigned(FToolBar) then
    if UseAnimation then
    begin
      TUIView.OCClass.beginAnimations(nil, nil);
      try
        TUIView.OCClass.setAnimationDuration(0.25);
        TUIView.OCClass.setAnimationBeginsFromCurrentState(True);
        FToolBar.setFrame(Frame);
      finally
        TUIView.OCClass.commitAnimations;
      end;
    end
    else
      FToolBar.setFrame(Frame);
end;

procedure TCocoaVirtualKeyboardService.SetToolbarVisible(const Value: Boolean);
begin
  if FToolbarVisible <> Value then
  begin
    FToolbarVisible := Value;
    if Assigned(FToolBar) and FToolbarEnabled then
      SetToolbarFrame(GetToolbarFrame, True);
  end;
end;

function TCocoaVirtualKeyboardService.ShowVirtualKeyboard(
  const AControl: TFmxObject): Boolean;
var
  RootObj: TFmxObject;
  RootView: UIView;
begin
  RootObj := AControl.Root.GetObject;
  if RootObj is TCommonCustomForm then
  begin
    if Assigned(FStoredActiveForm) then
      TStoredActiveForm(FStoredActiveForm).Form := TCommonCustomForm(RootObj);
    RootView := WindowHandleToPlatform(TCommonCustomForm(RootObj).Handle).View;
    Result := RootView.becomeFirstResponder;
  end
  else
    Result := False;
end;

function TCocoaVirtualKeyboardService.HideVirtualKeyboard: Boolean;
var
  RootObj: TCommonCustomForm;
begin
  RootObj := nil;
  if Assigned(FStoredActiveForm) then
    RootObj := TStoredActiveForm(FStoredActiveForm).Form;
  if Assigned(RootObj) then
    Result := WindowHandleToPlatform(RootObj.Handle).View.resignFirstResponder
  else
    Result := False;
end;

{ TVKToolbarButton }

procedure TVKToolbarButton_iOS.DoChanged;
begin
  inherited;
  CocoaKeyboardService.RefreshToolbarButtons;
end;


initialization
  RegisterVirtualKeyboardServices;
finalization
  UnregisterVirtualKeyboardServices;
end.
