{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiView;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Messaging, System.Classes, System.SysUtils, System.UITypes, System.Devices, FMX.Controls,
  FMX.Types, FMX.Objects, FMX.Platform, FMX.Forms, FMX.MultiView.Types, FMX.Controls.Presentation;

type

{ TCustomMultiView  }

  TCustomMultiView = class;

  TPresentationState = (Installed, Opened, Moving);
  TPresentationStates = set of TPresentationState;

  { Presentation for MultiView component, it has custom alignment procedure and custom behaviour of showing
    and hiding master/detail panels. }
  TMultiViewPresentation = class abstract(TInterfacedObject)
  public const
    DefaultSpeed = 0;
  private
    [Weak] FMultiView: TCustomMultiView;
    FState: TPresentationStates;
  protected
    procedure FitControlToParentHeight;
    function GetParentWidth: Single;
    /// <summary>Sets size of MultiView in opened state.</summary>
    procedure SetExpandedSize(const Value: TSizeF); virtual;
    /// <summary>If controls supports opening and closing, returns size of multiview in opened state</summary>
    function GetExpandedSize: TSizeF; virtual;
    /// <summary>If controls supports opening and closing, returns size of multiview in closed state</summary>
    function GetCollapsedSize: TSizeF; virtual;
  protected
    procedure DoShown; virtual;
    procedure DoStartShowing; virtual;
    procedure DoStartHiding; virtual;
    procedure DoHidden; virtual;
    procedure DoInstall; virtual;
    procedure DoUninstall; virtual;
    procedure DoOpen(const ASpeed: Single = DefaultSpeed); virtual;
    procedure DoClose(const ASpeed: Single = DefaultSpeed); virtual;
    procedure DoStartMoving(const ASpeed: Single = DefaultSpeed); virtual;
    procedure DoEndMoving; virtual;
    procedure StartMoving(const ASpeed: Single = DefaultSpeed);
    procedure EndMoving;
    function GetMasterButtonVisible: Boolean; virtual;
    function GetDisplayName: string; virtual;
  public
    constructor Create(AMultiView: TCustomMultiView); virtual;
    destructor Destroy; override;
    procedure Install;
    procedure Uninstall;
    procedure Open(const ASpeed: Single = DefaultSpeed);
    procedure Close(const ASpeed: Single = DefaultSpeed);
    function Opened: Boolean;
    procedure Realign; virtual;
    procedure TargetControlChanging(AOldControl: TControl; ANewControl: TControl); virtual;
    procedure UpdateSettings; virtual;
    procedure UpdateStyle; virtual;
    /// <summary>Notification about changed <c>ControlType</c> of <c>MultiView</c></summary>
    procedure ControlTypeChanged; virtual;
    /// <summary>Notification about changed <c>Parent</c> of <c>MultiView</c></summary>
    procedure ParentChanged; virtual;
    // Design Time Only
    function NeedHideInDesignTime: Boolean; virtual;
    /// <summary>Does presentation supports openning and closing MultiView?</summary>
    function CanShowHideInDesignTime: Boolean; virtual;
    property DisplayName: string read GetDisplayName;
    /// <summary>Size of MultiView in opened state</summary>
    property ExpandedSize: TSizeF read GetExpandedSize write SetExpandedSize;
    /// <summary>Size of MultiView in closed state</summary>
    property CollapsedSize: TSizeF read GetCollapsedSize;
  public
    property MultiView: TCustomMultiView read FMultiView;
    property State: TPresentationStates read FState;
    property MasterButtonVisible: Boolean read GetMasterButtonVisible;
  end;
  TMultiViewPresentationClass = class of TMultiViewPresentation;

  { Kinds of displaying Multi View:
     - |Panel| - SplitView displaying. Master and detail panels are always displayed, independent of device type
       and orientation
     - |Popover| - Displaying master panel in popup, independent from device type and orientation
     - |Drawer| - The Master panel is displayed by shift with the screen edge
     - |Custom| - The user based presentation for Multi View. User must set his presentation class
       through CustomPresentationClass property.
     - |PlatformBehaviour| - Displaying master/detail panels depend from device type and current orientation:
         * Phone (Landscape and Inverted Landscape)  - |Drawer|
         * Phone (Portrait and Inverted Portrait)    - |Drawer|
         * Tablet (Landscape and Inverted Landscape) - |Panel|
         * Tablet (Portrait and Inverted Portrait)   - |Drawer| }
  TMultiViewMode = (PlatformBehaviour, Panel, Popover, Drawer, Custom, NavigationPane);
  
  TOnPresenterChanging = procedure (Sender: TObject; var PresenterClass: TMultiViewPresentationClass) of object;

  // Only DesignTime message
  TMultiViewlDisplayedMessage = class(TMessage);

  TCustomMultiView = class(TPresentedControl)
  public const
    DefaultWidth = 250;
  private
    FMode: TMultiViewMode;
    FMasterContent: TContent;
    FMasterButton: TControl;
    FTargetControl: TControl;
    FShadowOptions: TShadowAppearance;
    FDrawerOptions: TDrawerAppearance;
    FPopoverOptions: TPopoverAppearance;
    FSplitViewOptions: TSplitViewAppearance;
    FNavigationPaneOptions: TNavigationPaneAppearance;
    FPresenter: TMultiViewPresentation;
    FCustomPresentationClass: TMultiViewPresentationClass;
    FScreenService: IFMXScreenService;
    FDeviceService: IFMXDeviceService;
    FOnPresenterChanging: TOnPresenterChanging;
    FOnStartShowing: TNotifyEvent;
    FOnStartHiding: TNotifyEvent;
    FOnShown: TNotifyEvent;
    FOnHidden: TNotifyEvent;
    procedure SetMasterButton(const Value: TControl);
    procedure SetTargetControl(const Value: TControl);
    procedure SetMode(const Value: TMultiViewMode);
    procedure SetShadowOptions(const Value: TShadowAppearance);
    procedure SetDrawerOptions(const Value: TDrawerAppearance);
    procedure SetPopoverAppearance(const Value: TPopoverAppearance);
    procedure SetSplitViewOptions(const Value: TSplitViewAppearance);
    procedure SetNavigationPaneOptions(const Value: TNavigationPaneAppearance);
    procedure SetCustomPresentationClass(const Value: TMultiViewPresentationClass);
    function AreShadowOptionsStored: Boolean;
    function AreDrawerOptionsStored: Boolean;
    function ArePopoverOptionsStored: Boolean;
    function AreSplitViewOptionsStored: Boolean;
    function AreNavigationPaneOptionsStored: Boolean;
    function DefineContext: TFmxObject;
  private
    procedure DoOrientationChanged(const Sender: TObject; const M: TMessage);
    procedure DoAnotherMultiViewDisplayed(const Sender: TObject; const M: TMessage);
    procedure DoFormSizeChanged(const Sender: TObject; const M: TMessage);
    procedure DoOptionsChanged(Sender: TObject);
  protected
    function GetOrientation: TScreenOrientation;
    function GetDeviceClass: TDeviceInfo.TDeviceClass;
    /// <summary>Returns current device. If it is design-time, returns current device, which's view is selected in IDE
    /// </summary>
    function GetDevice: TDeviceInfo;
  protected
    function IsObjectForContent(const AObject: TFmxObject): Boolean; virtual;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure DoMasterButtonClick(Sender: TObject); virtual;
    procedure ParentChanged; override;
    function IsMobilePreview: Boolean;
    procedure Loaded; override;
    procedure Resize; override;
    procedure DoAbsoluteChanged; override;
    procedure Show; override;
    /// <summary>Notifies that control changed <c>ControlType</c> property.</summary>
    procedure ControlTypeChanged; override;
    { Serialization }
    procedure WriteState(Writer: TWriter); override;
    procedure ReadState(Reader: TReader); override;
    { Events }
    procedure DoStartShowing; virtual;
    procedure DoStartHiding; virtual;
    procedure DoShown; virtual;
    procedure DoHidden; virtual;
    { Style }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    { Painting }
    procedure PaintChildren; override;
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject); override;
    { Presentation Layer }
    function RequestPresenter: Boolean; virtual;
    function DefineDrawerPresenterClass: TMultiViewPresentationClass; virtual;
    function DefinePlatformBehaviourPresenter: TMultiViewPresentationClass; virtual;
    function DefinePresenterClass: TMultiViewPresentationClass; virtual;
    procedure DoPresenterChanging(var PresenterClass: TMultiViewPresentationClass); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HasMasterButton: Boolean;
    function HasTargetControl: Boolean;
    function HasPresenter: Boolean;
    procedure HideMaster;
    procedure ShowMaster;
    procedure UpdateAlignment; virtual;
    function IsShowed: Boolean;
    /// <summary>Removes all controls from content</summary>
    procedure ClearContent;
    property MasterContent: TContent read FMasterContent;
    property Presenter: TMultiViewPresentation read FPresenter;
  public
    property CustomPresentationClass: TMultiViewPresentationClass read FCustomPresentationClass write SetCustomPresentationClass;
    property TargetControl: TControl read FTargetControl write SetTargetControl;
    /// <summary>Options of Popover mode</summary>
    property PopoverOptions: TPopoverAppearance read FPopoverOptions write SetPopoverAppearance stored ArePopoverOptionsStored;
    property MasterButton: TControl read FMasterButton write SetMasterButton;
    property Mode: TMultiViewMode read FMode write SetMode default TMultiViewMode.PlatformBehaviour;
    property ShadowOptions: TShadowAppearance read FShadowOptions write SetShadowOptions stored AreShadowOptionsStored;
    /// <summary>Options of Panel mode</summary>
    property SplitViewOptions: TSplitViewAppearance read FSplitViewOptions write SetSplitViewOptions stored AreSplitViewOptionsStored;
    /// <summary>Options of Drawer mode</summary>
    property DrawerOptions: TDrawerAppearance read FDrawerOptions write SetDrawerOptions stored AreDrawerOptionsStored;
    /// <summary>Options of Navigation Pane mode</summary>
    property NavigationPaneOptions: TNavigationPaneAppearance read FNavigationPaneOptions write SetNavigationPaneOptions stored AreNavigationPaneOptionsStored;
    property OnStartShowing: TNotifyEvent read FOnStartShowing write FOnStartShowing;
    property OnStartHiding: TNotifyEvent read FOnStartHiding write FOnStartHiding;
    property OnShown: TNotifyEvent read FOnShown write FOnShown;
    property OnHidden: TNotifyEvent read FOnHidden write FOnHidden;
    property OnPresenterChanging: TOnPresenterChanging read FOnPresenterChanging write FOnPresenterChanging;
  end;

{ TMultiView }

  TMultiView = class(TCustomMultiView)
  published
    property TargetControl;
    property DrawerOptions;
    property PopoverOptions;
    property MasterButton;
    property Mode;
    property NavigationPaneOptions;
    property ShadowOptions;
    property SplitViewOptions;
    property OnPresenterChanging;
    property OnStartShowing;
    property OnStartHiding;
    property OnShown;
    property OnHidden;
    { inherited }
    property ControlType;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled default True;
    property Locked;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    property Padding;
    property Opacity;
    property PopupMenu;
    property Scale;
    property Size;
    property StyleLookup;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property TabOrder;
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
    property OnClick;
    property OnDblClick;
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

implementation

uses
  System.Math, FMX.MultiView.Presentations, FMX.Dialogs, FMX.Consts, FMX.Styles, FMX.Graphics, FMX.BehaviorManager,
  FMX.Ani, FMX.Presentation.Style;

{ TCustomMultiView }

procedure TCustomMultiView.ApplyStyle;
begin
  inherited;
  if HasPresenter then
    Presenter.UpdateStyle;
end;

function TCustomMultiView.AreNavigationPaneOptionsStored: Boolean;
begin
  Result := not FNavigationPaneOptions.AreDefaultValues;
end;

function TCustomMultiView.ArePopoverOptionsStored: Boolean;
begin
  Result := not FPopoverOptions.AreDefaultValues;
end;

function TCustomMultiView.IsMobilePreview: Boolean;
var
  StyleDescriptor: TStyleDescription;
begin
  StyleDescriptor := TStyleManager.GetStyleDescriptionForControl(Self);
  if StyleDescriptor <> nil then
    Result := StyleDescriptor.MobilePlatform
  else
    Result := False;
end;

function TCustomMultiView.IsObjectForContent(const AObject: TFmxObject): Boolean;
begin
  Result := not AObject.Equals(FMasterContent) and not AObject.Equals(ResourceLink) and not (AObject is TAnimation)
    and not (AObject is TSeparatorLine) and (Children.IndexOf(AObject) = -1) and not (AObject is TStyledPresentation);
end;

function TCustomMultiView.IsShowed: Boolean;
begin
  Result := HasPresenter and (TPresentationState.Opened in Presenter.State);
end;

procedure TCustomMultiView.PaintChildren;

  procedure PaintDesignTimePresenterLabel;
  const
    LabelMargins = 10;
    LabelPadding = 5;
  var
    TextWidth: Double;
    TextHeight: Double;
    TextRect: TRectF;
    PresenterDisplayName: string;
  begin
    if HasPresenter then
    begin
      PresenterDisplayName := Presenter.DisplayName;
      TextWidth := Canvas.TextWidth(PresenterDisplayName) + 2 * LabelPadding;
      TextHeight := Canvas.TextHeight(PresenterDisplayName) + 2 * LabelPadding;
      TextRect := TRectF.Create(TPointF.Create(Width - TextWidth - LabelMargins, Height - TextHeight - LabelMargins),
        TextWidth, TextHeight);
      if LocalRect.Contains(TextRect) then
      begin
        Canvas.Fill.Color := TAlphaColorRec.Black;
        Canvas.FillRect(TextRect, 3, 3, AllCorners, 0.5);
        Canvas.Fill.Color := TAlphaColorRec.White;
        Canvas.FillText(TextRect, PresenterDisplayName, False, 1, [], TTextAlign.Center, TTextAlign.Center);
      end;
    end;
  end;

begin
  inherited;
  Canvas.SetMatrix(AbsoluteMatrix);
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    DrawDesignBorder;
    PaintDesignTimePresenterLabel;
  end;
end;

procedure TCustomMultiView.ParentChanged;
begin
  inherited;
  if HasPresenter and not (csDestroying in ComponentState) then
    Presenter.ParentChanged;
  UpdateAlignment;
end;

procedure TCustomMultiView.ClearContent;
begin
  MasterContent.DeleteChildren;
  Repaint;
end;

procedure TCustomMultiView.ControlTypeChanged;
begin
  inherited;
  if HasPresenter then
    Presenter.ControlTypeChanged;
end;

constructor TCustomMultiView.Create(AOwner: TComponent);
begin
  inherited;
  TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, FScreenService);
  TPlatformServices.Current.SupportsPlatformService(IFMXDeviceService, FDeviceService);

  FMode := TMultiViewMode.PlatformBehaviour;

  // Display settings
  FShadowOptions := TShadowAppearance.Create(Self, DoOptionsChanged);
  FDrawerOptions := TDrawerAppearance.Create(Self, DoOptionsChanged);
  FPopoverOptions := TPopoverAppearance.Create(Self, DoOptionsChanged);
  FSplitViewOptions := TSplitViewAppearance.Create(Self, DoOptionsChanged);
  FNavigationPaneOptions := TNavigationPaneAppearance.Create(Self, DoOptionsChanged);

  // Content for panel's controls
  FMasterContent := TContent.Create(Self);
  FMasterContent.Parent := Self;
  FMasterContent.Stored := False;
  FMasterContent.Align := TAlignLayout.Client;
  UpdateExplicitBounds;
  FSize.Width := DefaultWidth;

  if csDesigning in ComponentState then
    RequestPresenter;

  { Message subscription }
  TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage, DoOrientationChanged);
  TMessageManager.DefaultManager.SubscribeToMessage(TSizeChangedMessage, DoFormSizeChanged);
  if csDesigning in ComponentState then
    TMessageManager.DefaultManager.SubscribeToMessage(TMultiViewlDisplayedMessage, DoAnotherMultiViewDisplayed);
end;

function TCustomMultiView.DefineContext: TFmxObject;
begin
  if Owner is TFmxObject then
    Result := TFmxObject(Owner)
  else
    Result := Parent;
end;

function TCustomMultiView.DefineDrawerPresenterClass: TMultiViewPresentationClass;
begin
  if DrawerOptions.Mode = TSlidingMode.PushingDetailView then
    Result := TMultiViewDrawerPushingPresentation
  else
    Result := TMultiViewDrawerOverlapPresentation;
end;

function TCustomMultiView.DefinePlatformBehaviourPresenter: TMultiViewPresentationClass;

  function IsLargePhone: Boolean;
  const
    MinLogicaSizeForLargePhone = 736;
  var
    ThisDevice: TDeviceInfo;
  begin
    ThisDevice := GetDevice;
    if ThisDevice <> nil then
      Result := Max(ThisDevice.MinLogicalScreenSize.Width, ThisDevice.MinLogicalScreenSize.Height) >= MinLogicaSizeForLargePhone
    else
      Result := True;
  end;

var
  Orientation: TScreenOrientation;
begin
  Result := TMultiViewDockedPanelPresentation;
  case GetDeviceClass of
    TDeviceInfo.TDeviceClass.Phone:
      if IsLargePhone and (GetOrientation in [TScreenOrientation.Landscape, TScreenOrientation.InvertedLandscape]) then
        Result := TMultiViewDockedPanelPresentation
      else
        Result := DefineDrawerPresenterClass;
    TDeviceInfo.TDeviceClass.Tablet:
    begin
      Orientation := GetOrientation;
      case Orientation of
        TScreenOrientation.Portrait,
        TScreenOrientation.InvertedPortrait:
          Result := DefineDrawerPresenterClass;
        TScreenOrientation.Landscape,
        TScreenOrientation.InvertedLandscape:
          Result := TMultiViewDockedPanelPresentation;
      end;
    end;
    TDeviceInfo.TDeviceClass.Desktop:
      if TOSVersion.Check(10) and (TOSVersion.Platform = TOSVersion.TPlatform.pfWindows) then
        Result := TMultiViewNavigationPanePresentation
      else
        Result := TMultiViewDockedPanelPresentation;
  else
    Result := DefineDrawerPresenterClass;
  end;
end;

function TCustomMultiView.DefinePresenterClass: TMultiViewPresentationClass;
begin
  case Mode of
    TMultiViewMode.PlatformBehaviour:
      Result := DefinePlatformBehaviourPresenter;
    TMultiViewMode.Panel:
      Result := TMultiViewDockedPanelPresentation;
    TMultiViewMode.Popover:
      Result := TMultiViewPopoverPresentation;
    TMultiViewMode.Drawer:
      Result := DefineDrawerPresenterClass;
    TMultiViewMode.Custom:
      Result := CustomPresentationClass;
    TMultiViewMode.NavigationPane:
      Result := TMultiViewNavigationPanePresentation;
  else
    Result := nil;
  end;
  DoPresenterChanging(Result);
end;

destructor TCustomMultiView.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TOrientationChangedMessage, DoOrientationChanged);
  TMessageManager.DefaultManager.Unsubscribe(TSizeChangedMessage, DoFormSizeChanged);
  if csDesigning in ComponentState then
    TMessageManager.DefaultManager.Unsubscribe(TMultiViewlDisplayedMessage, DoAnotherMultiViewDisplayed);
  if HasTargetControl then
    TargetControl.RemoveFreeNotify(Self);
  if HasMasterButton then
    MasterButton.RemoveFreeNotify(Self);
  FPresenter.Free;
  FShadowOptions.Free;
  FDrawerOptions.Free;
  FPopoverOptions.Free;
  FSplitViewOptions.Free;
  FNavigationPaneOptions.Free;
  inherited;
end;

procedure TCustomMultiView.DoAbsoluteChanged;
begin
  inherited;
  if HasPresenter and (csDesigning in ComponentState) then
    Presenter.Realign;
end;

procedure TCustomMultiView.DoAddObject(const AObject: TFmxObject);
begin
  if IsObjectForContent(AObject) then
    FMasterContent.AddObject(AObject)
  else
    inherited;
end;

procedure TCustomMultiView.DoAnotherMultiViewDisplayed(const Sender: TObject; const M: TMessage);
begin
  if (csDesigning in ComponentState) and (Sender <> Self) and HasPresenter and Presenter.NeedHideInDesignTime then
    HideMaster;
end;

procedure TCustomMultiView.DoFormSizeChanged(const Sender: TObject; const M: TMessage);
begin
  if (Scene <> nil) and (Sender = Scene.GetObject) then
  begin
    RequestPresenter;
    UpdateAlignment;
  end;
end;

procedure TCustomMultiView.DoHidden;
begin
  if Assigned(FOnHidden) then
    FOnHidden(Self);
end;

procedure TCustomMultiView.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if IsObjectForContent(AObject) then
    FMasterContent.AddObject(AObject)
  else
    inherited;
end;

procedure TCustomMultiView.DoMasterButtonClick(Sender: TObject);
begin
  if HasPresenter then
    if Presenter.Opened then
      HideMaster
    else
      ShowMaster;
end;

procedure TCustomMultiView.DoOptionsChanged(Sender: TObject);
begin
  if not (csLoading in ComponentState) and RequestPresenter then
    Presenter.UpdateSettings;
end;

procedure TCustomMultiView.DoOrientationChanged(const Sender: TObject; const M: TMessage);
begin
  { When device changes orientation, we should request new presenter, because on different orientation
    we has different presenter (even if we has one presenter on all orientation). }
  RequestPresenter;
end;

procedure TCustomMultiView.DoPresenterChanging(var PresenterClass: TMultiViewPresentationClass);
begin
  if Assigned(FOnPresenterChanging) then
    FOnPresenterChanging(Self, PresenterClass);
end;

procedure TCustomMultiView.DoRemoveObject(const AObject: TFmxObject);
begin
  if IsObjectForContent(AObject) then
    FMasterContent.RemoveObject(AObject)
  else
    inherited;
end;

procedure TCustomMultiView.DoShown;
begin
  if Assigned(FOnShown) then
    FOnShown(Self);
end;

procedure TCustomMultiView.DoStartHiding;
begin
  if Assigned(FOnStartHiding) then
    FOnStartHiding(Self);
end;

procedure TCustomMultiView.DoStartShowing;
begin
  if Assigned(FOnStartShowing) then
    FOnStartShowing(Self);
end;

procedure TCustomMultiView.FreeNotification(AObject: TObject);
begin
  if AObject = MasterButton then
    MasterButton := nil;
  if AObject = TargetControl then
    TargetControl := nil;
  inherited;
end;

procedure TCustomMultiView.FreeStyle;
begin
  inherited;
  if HasPresenter and not (csDestroying in ComponentState) then
    Presenter.UpdateStyle;
end;

function TCustomMultiView.GetDevice: TDeviceInfo;
var
  DeviceService: IDeviceBehavior;
  Context: TFmxObject;
begin
  if csDesigning in ComponentState then
  begin
    Context := DefineContext;
    if TBehaviorServices.Current.SupportsBehaviorService(IDeviceBehavior, DeviceService, Context) then
      Exit(DeviceService.GetDevice(Context));
  end;
  Result := TDeviceInfo.ThisDevice;
end;

function TCustomMultiView.GetDeviceClass: TDeviceInfo.TDeviceClass;

  function DefineDeviceClassByFormSize: TDeviceInfo.TDeviceClass;
  const
    MaxPhoneWidth = 640;
  var
    Form: TCommonCustomForm;
  begin
    if (Root <> nil) and (Root.GetObject is TCommonCustomForm) then
    begin
      Form := TCommonCustomForm(Root.GetObject);
      if Form.Width <= MaxPhoneWidth then
        Result := TDeviceInfo.TDeviceClass.Phone
      else
        Result := TDeviceInfo.TDeviceClass.Tablet;
    end
    else
      Result := TDeviceInfo.TDeviceClass.Phone;
  end;

var
  DeviceService: IDeviceBehavior;
  Context: TFmxObject;
begin
  if csDesigning in ComponentState then
  begin
    Context := DefineContext;
    if TBehaviorServices.Current.SupportsBehaviorService(IDeviceBehavior, DeviceService, Context) then
      Result := DeviceService.GetDeviceClass(Context)
    else if IsMobilePreview then
      Result := DefineDeviceClassByFormSize
    else
      Result := TDeviceInfo.TDeviceClass.Desktop;
  end
  else if FDeviceService <> nil then
    Result := FDeviceService.GetDeviceClass
  else if IsMobilePreview then
    Result := DefineDeviceClassByFormSize
  else
    Result := TDeviceInfo.TDeviceClass.Desktop;
end;

function TCustomMultiView.GetOrientation: TScreenOrientation;
var
  Form: TCommonCustomForm;
  ScreenOrientation: TScreenOrientation;
begin
  if csDesigning in ComponentState then
  begin
    if (Root <> nil) and (Root.GetObject is TCommonCustomForm) then
    begin
      Form := Root.GetObject as TCommonCustomForm;
      if Form.Width > Form.Height then
        ScreenOrientation := TScreenOrientation.Landscape
      else
        ScreenOrientation := TScreenOrientation.Portrait;
    end
    else
      ScreenOrientation := TScreenOrientation.Portrait;
  end
  else
  begin
    if FScreenService <> nil then
      ScreenOrientation := FScreenService.GetScreenOrientation
    else
      ScreenOrientation := TScreenOrientation.Portrait;
  end;
  Result := ScreenOrientation;
end;

function TCustomMultiView.HasTargetControl: Boolean;
begin
  Result := TargetControl <> nil;
end;

function TCustomMultiView.HasMasterButton: Boolean;
begin
  Result := MasterButton <> nil;
end;

function TCustomMultiView.HasPresenter: Boolean;
begin
  Result := Presenter <> nil;
end;

procedure TCustomMultiView.HideMaster;
begin
  if HasPresenter then
    Presenter.Close;
end;

function TCustomMultiView.AreShadowOptionsStored: Boolean;
begin
  Result := not FShadowOptions.AreDefaultValues;
end;

function TCustomMultiView.AreDrawerOptionsStored: Boolean;
begin
  Result := not FDrawerOptions.AreDefaultValues;
end;

function TCustomMultiView.AreSplitViewOptionsStored: Boolean;
begin
  Result := not FSplitViewOptions.AreDefaultValues;
end;

procedure TCustomMultiView.Loaded;
begin
  inherited;
  RequestPresenter;
  if HasPresenter then
    Presenter.Realign;
end;

procedure TCustomMultiView.WriteState(Writer: TWriter);
var
  SavedSize: TSizeF;
begin
  // Some presentations can change size for implementation a showing or hiding. But in resource we need to save
  // expanded size. For this reason, we restore expanded size without notification only on writing to resources.
  SavedSize := Size.Size;
  try
    if HasPresenter then
      Size.SetSizeWithoutNotification(Presenter.ExpandedSize);
    inherited;
  finally
    if HasPresenter then
      Size.SetSizeWithoutNotification(SavedSize);
  end;
end;

procedure TCustomMultiView.ReadState(Reader: TReader);
begin
  inherited;
  if HasPresenter and not (TPresentationState.Opened in Presenter.State) then
  begin
    Presenter.ExpandedSize := Size.Size;
    Size.Size := Presenter.CollapsedSize;
  end;
end;

function TCustomMultiView.RequestPresenter: Boolean;
var
  PresentationClass: TMultiViewPresentationClass;
begin
  // We change instance of presenter only if Multi View changed presenter class, else we free presenter and create new
  PresentationClass := DefinePresenterClass;

  if PresentationClass = nil then
    Result := False
  else
  begin
    Result := True;
    if not (FPresenter is PresentationClass) then
    begin
      if HasPresenter then
      begin
        FPresenter.Uninstall;
        FPresenter.Free;
      end;
      FPresenter := PresentationClass.Create(Self);
      FPresenter.Install;
      if (csDesigning in ComponentState) and HasPresenter and Presenter.NeedHideInDesignTime then
        Visible := False;
    end;
  end;
end;

procedure TCustomMultiView.Resize;
begin
  inherited;
  MasterContent.Size := Size;
  UpdateAlignment;
end;

procedure TCustomMultiView.UpdateAlignment;
begin
  if HasPresenter and (ComponentState * [csLoading, csDestroying] = []) then
  begin
    BeginUpdate;
    try
      Presenter.Realign;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomMultiView.SetCustomPresentationClass(const Value: TMultiViewPresentationClass);
begin
  FCustomPresentationClass := Value;
  if Mode = TMultiViewMode.Custom then
  begin
    RequestPresenter;
    UpdateAlignment;
  end;
end;

procedure TCustomMultiView.SetTargetControl(const Value: TControl);
begin
  if TargetControl <> Value then
  begin
    if (Value <> nil) and Self.IsChild(Value) then
      raise EComponentError.CreateFmt(SObjectCannotBeChild, ['TargetControl', 'TMultiView']); // do not localize

    if FTargetControl <> nil then
      FTargetControl.RemoveFreeNotify(Self);

    if HasPresenter then
      Presenter.TargetControlChanging(TargetControl, Value);

    FTargetControl := Value;

    if HasTargetControl then
    begin
      FTargetControl.AddFreeNotify(Self);
      UpdateAlignment;
    end;
  end;
end;

procedure TCustomMultiView.SetPopoverAppearance(const Value: TPopoverAppearance);
begin
  FPopoverOptions.Assign(Value);
end;

procedure TCustomMultiView.SetMasterButton(const Value: TControl);
begin
  if MasterButton <> Value then
  begin
    if MasterButton <> nil then
    begin
      FMasterButton.RemoveFreeNotify(Self);
      FMasterButton.OnClick := nil;
    end;
    FMasterButton := Value;
    if HasMasterButton then
    begin
      FMasterButton.AddFreeNotify(Self);
      FMasterButton.OnClick := DoMasterButtonClick;
      if HasPresenter then
        FMasterButton.Visible := Presenter.MasterButtonVisible;
    end;
  end;
end;

procedure TCustomMultiView.SetMode(const Value: TMultiViewMode);
begin
  if Mode <> Value then
  begin
    FMode := Value;
    if not (csLoading in ComponentState) then
      RequestPresenter;
  end;
end;

procedure TCustomMultiView.SetNavigationPaneOptions(const Value: TNavigationPaneAppearance);
begin
  FNavigationPaneOptions.Assign(Value);
end;

procedure TCustomMultiView.SetShadowOptions(const Value: TShadowAppearance);
begin
  FShadowOptions.Assign(Value);
end;

procedure TCustomMultiView.SetDrawerOptions(const Value: TDrawerAppearance);
begin
  FDrawerOptions.Assign(Value);
end;

procedure TCustomMultiView.SetSplitViewOptions(const Value: TSplitViewAppearance);
begin
  FSplitViewOptions.Assign(Value);
end;

procedure TCustomMultiView.Show;
begin
  inherited;
  if HasPresenter and (csDesigning in ComponentState) and Presenter.NeedHideInDesignTime then
    TMessageManager.DefaultManager.SendMessage(Self, TMultiViewlDisplayedMessage.Create);
end;

procedure TCustomMultiView.ShowMaster;
begin
  if HasPresenter then
    Presenter.Open;
end;

{ TMultiViewPresentation }

procedure TMultiViewPresentation.SetExpandedSize(const Value: TSizeF);
begin
end;

procedure TMultiViewPresentation.StartMoving(const ASpeed: Single);
begin
  if not (TPresentationState.Moving in State) then
  begin
    Include(FState, TPresentationState.Moving);
    DoStartMoving(ASpeed);
  end;
end;

procedure TMultiViewPresentation.Close(const ASpeed: Single);
begin
  Exclude(FState, TPresentationState.Opened);
  DoClose(ASpeed);
end;

procedure TMultiViewPresentation.ControlTypeChanged;
begin
end;

constructor TMultiViewPresentation.Create(AMultiView: TCustomMultiView);
begin
  inherited Create;
  if AMultiView = nil then
    raise Exception.Create(SCannotCreatePresentation);
  FMultiView := AMultiView;
  FState := [];
end;

destructor TMultiViewPresentation.Destroy;
begin
  Uninstall;
  inherited;
end;

procedure TMultiViewPresentation.TargetControlChanging(AOldControl, ANewControl: TControl);
begin
end;

procedure TMultiViewPresentation.DoStartMoving(const ASpeed: Single);
begin
end;

procedure TMultiViewPresentation.DoClose(const ASpeed: Single = DefaultSpeed);
begin
end;

procedure TMultiViewPresentation.DoEndMoving;
begin
end;

procedure TMultiViewPresentation.DoHidden;
begin
  MultiView.DoHidden;
end;

procedure TMultiViewPresentation.DoInstall;
begin
  UpdateSettings;
  Realign;
  if MultiView.HasTargetControl then
    TargetControlChanging(nil, MultiView.TargetControl);
end;

procedure TMultiViewPresentation.DoOpen(const ASpeed: Single = DefaultSpeed);
begin
end;

procedure TMultiViewPresentation.DoShown;
begin
  MultiView.DoShown;
end;

procedure TMultiViewPresentation.DoUninstall;
begin
end;

procedure TMultiViewPresentation.EndMoving;
begin
  Exclude(FState, TPresentationState.Moving);
  DoEndMoving;
end;

procedure TMultiViewPresentation.FitControlToParentHeight;
begin
  if MultiView.ParentControl <> nil then
    MultiView.Height := MultiView.ParentControl.Height
  else if MultiView.Parent is TCommonCustomForm then
    MultiView.Height := (MultiView.Parent as TCommonCustomForm).ClientHeight;
end;

function TMultiViewPresentation.GetParentWidth: Single;
begin
  if MultiView.ParentControl <> nil then
    Result := MultiView.ParentControl.Width
  else if MultiView.Parent is TCommonCustomForm then
    Result := TCommonCustomForm(MultiView.Parent).ClientWidth
  else
    Result := 0;
end;

procedure TMultiViewPresentation.Install;
begin
  if not (TPresentationState.Installed in State) then
  begin
    DoInstall;
    Include(FState, TPresentationState.Installed);
  end;
end;

function TMultiViewPresentation.CanShowHideInDesignTime: Boolean;
begin
  Result := True;
end;

function TMultiViewPresentation.GetCollapsedSize: TSizeF;
begin
  Result := MultiView.Size.Size;
end;

function TMultiViewPresentation.GetDisplayName: string;
begin
  Result := ClassName;
end;

function TMultiViewPresentation.GetExpandedSize: TSizeF;
begin
  Result := MultiView.Size.Size;
end;

function TMultiViewPresentation.GetMasterButtonVisible: Boolean;
begin
  Result := True;
end;

procedure TMultiViewPresentation.Uninstall;
begin
  if TPresentationState.Installed in State then
  begin
    Exclude(FState, TPresentationState.Installed);
    DoUninstall;
  end;
end;

procedure TMultiViewPresentation.Realign;
begin
end;

procedure TMultiViewPresentation.DoStartHiding;
begin
  MultiView.DoStartHiding;
end;

procedure TMultiViewPresentation.DoStartShowing;
begin
  MultiView.DoStartShowing;
end;

procedure TMultiViewPresentation.Open(const ASpeed: Single);
begin
  Include(FState, TPresentationState.Opened);
  DoOpen(ASpeed);
end;

function TMultiViewPresentation.Opened: Boolean;
begin
  Result := TPresentationState.Opened in FState;
end;

procedure TMultiViewPresentation.ParentChanged;
begin
end;

function TMultiViewPresentation.NeedHideInDesignTime: Boolean;
begin
  Result := True;
end;

procedure TMultiViewPresentation.UpdateSettings;
begin
end;

procedure TMultiViewPresentation.UpdateStyle;
begin
end;

initialization
  RegisterFmxClasses([TCustomMultiView, TMultiView]);
end.
