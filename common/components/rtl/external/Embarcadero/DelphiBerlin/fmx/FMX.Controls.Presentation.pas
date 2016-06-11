{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Controls.Presentation;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Types, System.Classes, System.Generics.Collections, System.Rtti, FMX.Controls, FMX.Types,
  FMX.Presentation.Messages, FMX.Controls.Model;

const
  PM_BASE                 = $400;
  PM_INIT                 = PM_BASE + 1;
  PM_UNLOAD               = PM_BASE + 2;
  PM_SET_VISIBLE          = PM_BASE + 6;
  PM_GET_VISIBLE          = PM_BASE + 7;
  PM_SET_ABSOLUTE_OPACITY = PM_BASE + 8;
  PM_GET_ABSOLUTE_OPACITY = PM_BASE + 9;
  PM_SET_SIZE             = PM_BASE + 10;
  PM_GET_SIZE             = PM_BASE + 11;
  PM_SET_ABSOLUTE_ENABLED = PM_BASE + 12;
  PM_GET_ABSOLUTE_ENABLED = PM_BASE + 13;
  PM_SET_CLIP_CHILDREN    = PM_BASE + 14;
  PM_GET_CLIP_CHILDREN    = PM_BASE + 15;
  PM_SET_STYLE_LOOKUP     = PM_BASE + 16;
  PM_GET_STYLE_LOOKUP     = PM_BASE + 17;
  PM_GET_NATIVE_OBJECT    = PM_BASE + 20;
  PM_GET_RECOMMEND_SIZE   = PM_BASE + 22;
  PM_IS_FOCUSED           = PM_BASE + 25;
  PM_RESET_FOCUS          = PM_BASE + 26;
  PM_DO_ENTER             = PM_BASE + 33;
  PM_DO_EXIT              = PM_BASE + 34;
  PM_REALIGN              = PM_BASE + 28;
  PM_REFRESH_PARENT       = PM_BASE + 29;
  PM_PARENT_CHANGED       = PM_BASE + 30;
  PM_ANCESSTOR_VISIBLE_CHANGED = PM_BASE + 31;
  PM_KEYDOWN              = PM_BASE + 32;
  PM_KEYUP                = PM_BASE + 35;
  PM_ACTION_CLIENT_CHANGED= PM_BASE + 36;
  PM_ACTION_CHANGE        = PM_BASE + 37;
  PM_APPLY_STYLE_LOOKUP   = PM_BASE + 38;
  PM_SET_STYLES_DATA      = PM_BASE + 39;
  PM_GET_STYLES_DATA      = PM_BASE + 40;
  PM_ABSOLUTE_CHANGED     = PM_BASE + 41;
  PM_HITTEST_CHANGED      = PM_BASE + 42;
  PM_GET_ADJUST_TYPE      = PM_BASE + 43;
  PM_GET_ADJUST_SIZE      = PM_BASE + 44;
  PM_SET_ADJUST_SIZE      = PM_BASE + 45;
  PM_NEED_STYLE_LOOKUP    = PM_BASE + 46;
  PM_ANCESTOR_PRESENTATION_LOADED = PM_BASE + 47;
  PM_FIND_STYLE_RESOURCE  = PM_BASE + 48;
  PM_OBJECT_AT_POINT      = PM_BASE + 49;
  PM_POINT_IN_OBJECT_LOCAL = PM_BASE + 50;
  PM_CHANGE_ORDER         = PM_BASE + 51;
  PM_START_TRIGGER_ANIMATION = PM_BASE + 52;
  PM_APPLY_TRIGGER_EFFECT = PM_BASE + 53;
  PM_GET_RESOURCE_LINK    = PM_BASE + 54;
  PM_SET_ADJUST_TYPE      = PM_BASE + 55;
  PM_ROOT_CHANGED         = PM_BASE + 56;
  PM_MOUSE_WHEEL          = PM_BASE + 57;
  PM_GET_FIRST_CONTROL_WITH_GESTURE = PM_BASE + 58;
  PM_USER                 = $1000;

type

{ TPresentationProxy }

  /// <summary>Information about key pressed by user. Used for sending message from <c>TPresentedControl</c>
  /// to presentation</summary>
  TKeyInfo = record
    /// <summary>Scan code of the pressed keyboard key, or $0.</summary>
    Key: Word;
    /// <summary>Pressed character or digit, or #0.</summary>
    KeyChar: System.WideChar;
    /// <summary>Combination of modifier keys that were pressed when the specified key (Key, KeyChar) was pressed.</summary>
    Shift: TShiftState;
  end;

  /// <summary>Information about action. Is used for sending message from <b>TPresentedControl</b> to presentation</summary>
  TActionInfo = record
    /// <summary>Data of the ASender argument of TPresentedControl.ActionChange.</summary>
    Sender: TBasicAction;
    /// <summary>Data of the ACheckDefaults argument of TPresentedControl.ActionChange.</summary>
    CheckDefaults: Boolean;
  end;

  /// <summary>Information about requesting style resource from presentation. Used for sending message from
  /// <b>TPresentedControl</b> to presentation. The |<b>Resource</b>| is filled by presentation</summary>
  TFindStyleResourceInfo = record
    /// <summary>Whether the returned style resource object should be the original style object (False) or a copy of 
    /// the original (True).</summary>
    Clone: Boolean;
    /// <summary>Name of the style resource object to return.</summary>
    ResourceName: string;
    /// <summary>Property to hold the returned style resource object.</summary>
    Resource: TFmxObject;
  end;

  /// <summary>Information about searching of control at specified point. |<b>Control</b>| contains instance of found
  /// the control</summary>
  TObjectAtPointInfo = record
    /// <summary>Hit-Test Point.</summary>
    Point: TPointF;
    /// <summary>Returned Control if it found.</summary>
    Control: IControl;
  end;

  /// <summary>Information about hit-testing point in local control at specified point.</summary>
  TPointInObjectLocalInfo = record
    /// <summary>Hit-Test Point.</summary>
    Point: TPointF;
    /// <summary>Returned true, if presentation layer contains specified point.</summary>
    Result: Boolean;
  end;

  /// <summary>Information used for staring trigger animation or effect.</summary>
  TTriggerInfo = record
    /// <summary>Link to Instance object that has triggered property</summary>
    Instance: TFmxObject;
    /// <summary>Trigger property name</summary>
    Trigger: string;
    /// <summary>Hold application before trigger animation completed</summary>
    Wait: Boolean;
  end;

  /// <summary>Information used for transfering mouse wheel event into presentation in design time.</summary>
  TMouseWheelInfo = record
    /// <summary>Indicates which shift keys--SHIFT, CTRL, ALT, and CMD (only for Mac)--were down when the pressed
    /// mouse button is released.</summary>
    Shift: TShiftState;
    /// <summary>Indicates the distance the wheel was rotated. WheelDelta is positive if the mouse was rotated upward,
    /// negative if the mouse was rotated downward.</summary>
    WheelDelta: Integer;
    /// <summary>Indicates whether the scroll bar was already moved, depending on the WheelDelta value. If one of the
    /// scrolls bars (vertical or horizontal) was already handled or it does not exist, MouseWheel tries to apply
    /// the rolling on the other scroll bar, if it exists.</summary>
    Handled: Boolean
  end;

  /// <summary>Information used for requesting control, which supports specified gestures</summary>
  TFirstControlWithGestureInfo = record
    /// <summary>Interactive gestures</summary>
    Gestures: TInteractiveGesture;
    /// <summary>Returned control, which supports specified Gestures</summary>
    Control: TComponent;
  end;

  /// <summary>Raised, when presentation received a model of the wrong class</summary>
  EPresentationWrongModel = class(Exception);

  /// <summary><para>Some composit controls like a <b>TListBox</b>, <b>TScrollBox</b>, <b>TMenu</b> and etc, have a
  /// special content for storing and moving items. </para>
  /// <para>When we embeds native control into native scrollbox, we calculate absolute position of native control by
  /// using chain of ancestors until native scrollbox. But we don't need to use <b>TContent</b> in this case, because native
  /// <b>TScrollBox</b> already considered offset of content. So for this purpose we need to use this interface.</para>
  /// <para>We will add to control this interface for asking them About need to consider its line item in case of
  /// computation of absolute coordinates for native controls.</para>
  /// </summary>
  IIgnoreControlPosition = interface
  ['{6C5DA960-D0E0-457B-9464-D489034510B7}']
    /// <summary>See description of <c>IIgnoreControlPosition</c></summary>
    function GetIgnoreControlPosition: Boolean;
  end;

  /// <summary> Proxy. Mediator. Base class for linking a <b>TPresentatedControl</b> control with a presentation.
  /// Successors of it must create presentation in <c>FMX.Presentation.Messages.TMessageSender.CreateReceiver</c>.
  /// </summary>
  TPresentationProxy = class(TMessageSender)
  private
    FNativeObject: IInterface;
    [Weak] FControl: TControl;
    [Weak] FModel: TDataModel;
  public
    /// <summary>Default constructor, requests native control by presentation by sending <b>PM_GET_NATIVE_OBJECT</b>
    /// message to presentation (<b>Receiver</b>).</summary>
    constructor Create; override;
    /// <summary>Initializes proxy by control and model and create link with presentation by using
    /// <c>FMX.Presentation.Messages.TMessageSender.CreateReceiver</c></summary>
    /// <param name="AModel">Model instance of |<b>AControl</b>|</param>
    /// <param name="AControl">Control, which supports using of presentation (usually <b>TPresentedControl</b>)</param>
    constructor Create(const AModel: TDataModel; const AControl: TControl); overload; virtual;
    /// <summary>Releases presentation, if presentation was created by using
    /// <c>FMX.Presentation.Messages.TMessageSender.CreateReceiver</c></summary>
    destructor Destroy; override;
    /// <summary>Returns True if proxy has native control. Returns False otherwise.</summary>
    function HasNativeObject: Boolean;
  public
    /// <summary>Returns presented control</summary>
    property PresentedControl: TControl read FControl;
    /// <summary>Returns model</summary>
    property Model: TDataModel read FModel;
    /// <summary>If presentation has native control, this property will contains reference on Instance of native control.
    /// Proxy send request on getting native control by using <b>PM_GET_NATIVE_OBJECT</b> message</summary>
    /// <remarks>You can use it for directly access to native control by casting to required type, if presentation uses
    /// native control</remarks>
    property NativeObject: IInterface read FNativeObject;
  end;
  /// <summary>Class of <b>TPresentationProxy</b></summary>
  TPresentationProxyClass = class of TPresentationProxy;

{ TPresentedControl }

  /// <summary>Event type for choosing presentation name by <b>TPresentedControl</b></summary>
  TPresenterNameChoosingEvent = procedure (Sender: TObject; var PresenterName: string) of object;

  /// <summary>States of presentation</summary>
  TPresentationState = (NotLoaded, Loading, Loaded, Unloading);

  /// <summary>Control, which supports working with <b>Model</b> and <b>Presentations</b>. Control can has instance of
  /// <b>Model</b> for storing data of control. <b>TPresentedControl</b> provide mechanism for choosing, creating,
  /// loading, using and unloading presentations. For communication with presentation <b>TPresentedControl</b> uses
  /// <b>TPresentationProxy</b>.</summary>
  TPresentedControl = class(TStyledControl)
  public type
    /// <summary>Defines whether the control should use styled or native presentation. This type has been deprecated,
    /// and TControlType from "FMX.Controls.pas" unit should be used instead.</summary>
    TControlType = FMX.Controls.TControlType deprecated 'Use TControlType declared in FMX.Controls.pas';
  private
    FModel: TDataModel;
    FControlType: TControlType;
    FPresentationProxy: TPresentationProxy;
    FState: TPresentationState;
    FCanUseDefaultPresentation: Boolean;
    FOnPresenterNameChoosing: TPresenterNameChoosingEvent;
    procedure SetControlType(const Value: TControlType);
    function GetPresentation: TObject;
    function CreateModel: TDataModel;
    procedure DoPresentationNameChoosing(var APresentationName: string);
    procedure RemoveStyleResource;
  protected
    procedure Loaded; override;
    { Notifications }
    /// <summary>Notifies about changed <c>ControlType</c></summary>
    procedure ControlTypeChanged; virtual;
    /// <summary>Notifies about changed <c>ClipChildren</c></summary>
    procedure ClipChildrenChanged; override;
    /// <summary>Notifies about changed <c>HitTest</c></summary>
    procedure HitTestChanged; override;
    { Styles }
    function GetDefaultStyleLookupName: string; override;
    procedure StyleLookupChanged; override;
    procedure StyleDataChanged(const Index: string; const Value: TValue); override;
    function RequestStyleData(const Index: string): TValue; override;
    function GetResourceLink: TFmxObject; override;
    { Controls Tree Structure }
    procedure AncestorParentChanged; override;
    procedure AncestorVisibleChanged(const AVisible: Boolean); override;
    procedure SetVisible(const Value: Boolean); override;
    function ObjectAtPoint(P: TPointF): IControl; override;
    procedure ChangeOrder; override;
    procedure ParentChanged; override;
    procedure DoDeleteChildren; override;
    procedure DoRootChanged; override;
    { Size and Position }
    function DoSetSize(const ASize: TControlSize; const NewPlatformDefault: Boolean; ANewWidth, ANewHeight: Single;
       var ALastWidth: Single; var ALastHeight: Single): Boolean; override;
    procedure DoAbsoluteChanged; override;
    procedure DoRealign; override;
    /// <summary>Defines recommended size for specified size <c>AWishedSize</c></summary>
    function RecommendSize(const AWishedSize: TSizeF): TSizeF; virtual;
    { Keyboard }
    procedure KeyDown(var AKey: Word; var AKeyChar: System.WideChar; AShift: TShiftState); override;
    procedure KeyUp(var AKey: Word; var AKeyChar: Char; AShift: TShiftState); override;
    { Focus }
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure AfterPaint; override;
    { IGestureControl }
    function GetFirstControlWithGesture(AGesture: TInteractiveGesture): TComponent; override;
    { IAlignableObject }
    procedure SetAdjustSizeValue(const Value: TSizeF); override;
    function GetAdjustSizeValue: TSizeF; override;
    function GetAdjustType: TAdjustType; override;
    procedure SetAdjustType(const Value: TAdjustType); override;
    { Actions }
    procedure ActionChange(ASender: TBasicAction; ACheckDefaults: Boolean); override;
    procedure DoActionClientChanged; override;
    { Presentations }
    /// <summary>Returns presentation name for current control.</summary>
    /// <remarks>By default presentation name is generated as <b>"ClassName (Without prefix T)"</b>-<c>GetPresentationSuffix</c> </remarks>
    function DefinePresentationName: string; virtual;
    /// <summary><para>Returns presentation suffix for <c>DefinePresentationName</c>, which depends on <c>ControlType</c> value.</para>
    /// <para>If <c>ControlType</c> equals <b>Styled</b>, return <b>styled</b></para>
    /// <para>If <c>ControlType</c> equals <b>Platform</b>, return <b>native</b></para></summary>
    function GetPresentationSuffix: string;
    /// <summary>Initializes a presentation through <c>PresentationProxy</c>. Allows users to set custom data for
    /// presentation</summary>
    procedure InitPresentation(APresentation: TPresentationProxy); virtual;
    /// <summary>Notify all child controls, that <c>AControl</c> changed presentation.</summary>
    procedure AncestorPresentationLoaded(const AControl: TPresentedControl);
    { Model }
    /// <summary>Tries to cast current model to type <c>T</c>. If specified type <c>T</c> is not compatible with
    /// <c>Model</c>, return nil.</summary>
    function GetModel<T: TDataModel>: T;
    /// <summary>Returns class of controls model. By default it is <c>TDataModel</c>. User can return nil. In this case
    /// <c>TPresentedControl</c> will not have Model.</summary>
    function DefineModelClass: TDataModelClass; virtual;
    /// <summary>If control cannot find presentation, control will try to load default presentation <c>'default-' +
    /// GetPresentationSuffix</c> only if this property is true.</summary>
    property CanUseDefaultPresentation: Boolean read FCanUseDefaultPresentation write FCanUseDefaultPresentation;
  protected
    /// <summary>Query interface from current control. If <c>TPresentedControl</c> doesn't support specified interface, it will
    /// query it from presentation.</summary>
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; override; stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HasPresentationProxy: Boolean;
    procedure RecalcEnabled; override;
    procedure RecalcOpacity; override;
    procedure AfterConstruction; override;
    procedure ApplyStyleLookup; override;
    procedure NeedStyleLookup; override;
    function FindStyleResource(const AStyleLookup: string; const AClone: Boolean = False): TFmxObject; override;
    function PointInObjectLocal(X: Single; Y: Single): Boolean; override;
    procedure ApplyTriggerEffect(const AInstance: TFmxObject; const ATrigger: string); override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
    procedure StartTriggerAnimationWait(const AInstance: TFmxObject; const ATrigger: string); override;
    { Presentations }
    /// <summary><para>Finds presentation proxy class from <c>TPresentationProxyFactory</c>, creates instance of presentation
    /// proxy and attaches to itself.</para><para>Also notifies all child controls about new loaded presentation.</para></summary>
    /// <remarks>If current presentation has the same class as a found new a presentation proxy class, this method
    /// doesn't replace current presentation. Unloads and releases current presentation otherwise.</remarks>
    procedure LoadPresentation; virtual;
    /// <summary>Unloads and releases current presentation proxy.</summary>
    procedure UnloadPresentation; virtual;
    /// <summary>Unloads existing presentation proxy and tries to load new instead.</summary>
    procedure ReloadPresentation;
  public
    property ControlType: TControlType read FControlType write SetControlType default TControlType.Styled;
    /// <summary>Returns instance of presentation object</summary>
    property Presentation: TObject read GetPresentation;
    /// <summary>Returns intermediary between presentation and PresentedControl. Can be used for sending messages to
    /// presentation</summary>
    property PresentationProxy: TPresentationProxy read FPresentationProxy;
    /// <summary>State of presentation: <c>NotLoaded</c>, <c>Loading</c>, <c>Loaded</c> or <c>Unloading.</c></summary>
    property PresentationState: TPresentationState read FState;
    /// <summary>Returns instance of control's model</summary>
    property Model: TDataModel read FModel;
    /// <summary>Event handler allows to change presentation name. And replace default presentation name on another. It can be used for
    /// replacing default FMX presentation on the user's presentation without creating custom component.</summary>
    property OnPresentationNameChoosing: TPresenterNameChoosingEvent read FOnPresenterNameChoosing write FOnPresenterNameChoosing;
  end;

  TDTFormatKindHelper = record helper for TControlType
  const
    Native = TControlType.Platform deprecated 'Use FMX.Controls.TControlType.Platform';
    Custom = TControlType.Styled deprecated 'Use FMX.Controls.TControlType.Styled';
  end;

implementation

uses
  {$IFDEF MACOS}Macapi.CoreFoundation, {$ENDIF} System.UITypes, System.Character, System.Math, System.Math.Vectors, System.TypInfo, 
  FMX.TextLayout, FMX.Consts, FMX.Graphics, FMX.Presentation.Factory, FMX.BehaviorManager, FMX.Presentation.Style 
  {$IFDEF MSWINDOWS}, FMX.Presentation.Win.Style, FMX.Presentation.Win{$ENDIF}
  {$IFDEF IOS}, FMX.Presentation.iOS.Style, FMX.Presentation.iOS{$ENDIF};
 
{ TPresentationProxy }

constructor TPresentationProxy.Create;
begin
  inherited;
  if (Model = nil) or (PresentedControl = nil) then
    raise EArgumentException.Create(SPresentationProxyCreateError);
  SendMessageWithResult<IInterface>(PM_GET_NATIVE_OBJECT, FNativeObject);
end;

constructor TPresentationProxy.Create(const AModel: TDataModel; const AControl: TControl);
begin
  FControl := AControl;
  FModel := AModel;
  Create;
end;

destructor TPresentationProxy.Destroy;
begin
  FControl := nil;
  FModel := nil;
  FNativeObject := nil;
  inherited;
end;

function TPresentationProxy.HasNativeObject: Boolean;
begin
  Result := FNativeObject <> nil;
end;

{ TPresentedControl }

procedure TPresentedControl.ActionChange(ASender: TBasicAction; ACheckDefaults: Boolean);
var
  Message: TActionInfo;
begin
  inherited;
  if HasPresentationProxy then
  begin
    Message.Sender := ASender;
    Message.CheckDefaults := ACheckDefaults;
    PresentationProxy.SendMessage<TActionInfo>(PM_ACTION_CHANGE, Message);
  end;
end;

procedure TPresentedControl.AfterConstruction;

  function IsRuntimeLoading: Boolean;
  begin
    Result := csLoading in ComponentState;
  end;

begin
  inherited;
  if not IsRuntimeLoading then
    LoadPresentation;
end;

procedure TPresentedControl.AncestorParentChanged;
begin
  inherited;
  if HasPresentationProxy then
  begin
    NeedStyleLookup;
    PresentationProxy.SendMessage(PM_REFRESH_PARENT);
  end;
end;

procedure TPresentedControl.AncestorPresentationLoaded(const AControl: TPresentedControl);

  procedure FindPresentedChildAndNotify(const ARootControl: TControl);
  var
    I: Integer;
    NeedNotifyChild: Boolean;
    ChildControl: TPresentedControl;
    MessageSender: IMessageSender;
  begin
    for I := 0 to ARootControl.Controls.Count - 1 do
      if ARootControl.Controls[I] is TPresentedControl then
      begin
        NeedNotifyChild := True;
        ChildControl := TPresentedControl(ARootControl.Controls[I]);
        if ChildControl.HasPresentationProxy then
          ChildControl.PresentationProxy.SendMessageWithResult<Boolean>(PM_ANCESTOR_PRESENTATION_LOADED, NeedNotifyChild);

        if NeedNotifyChild then
          ChildControl.AncestorPresentationLoaded(AControl);
      end
      else
      begin
        if Supports(ARootControl.Controls[I], IMessageSender, MessageSender) then
          MessageSender.MessageSender.SendMessageWithResult<Boolean>(PM_ANCESTOR_PRESENTATION_LOADED, NeedNotifyChild);
        FindPresentedChildAndNotify(ARootControl.Controls[I]);
      end;
  end;

begin
  FindPresentedChildAndNotify(Self);
end;

procedure TPresentedControl.AncestorVisibleChanged(const AVisible: Boolean);
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage<Boolean>(PM_ANCESSTOR_VISIBLE_CHANGED, AVisible);
end;

procedure TPresentedControl.ApplyStyleLookup;
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_APPLY_STYLE_LOOKUP)
  else
    inherited;
end;

procedure TPresentedControl.ChangeOrder;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_CHANGE_ORDER);
end;

procedure TPresentedControl.ClipChildrenChanged;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage<Boolean>(PM_SET_CLIP_CHILDREN, ClipChildren);
end;

procedure TPresentedControl.ControlTypeChanged;
begin
end;

constructor TPresentedControl.Create(AOwner: TComponent);
begin
  inherited;
  FState := TPresentationState.NotLoaded;
  FModel := CreateModel;
  FCanUseDefaultPresentation := True;
  ClipChildren := False;
end;

function TPresentedControl.CreateModel: TDataModel;
var
  ModelClass: TDataModelClass;
begin
  ModelClass := DefineModelClass;
  if ModelClass <> nil then
    Result := ModelClass.Create(Self)
  else
    Result := nil;
end;

function TPresentedControl.DefineModelClass: TDataModelClass;
begin
  Result := TDataModel;
end;

function TPresentedControl.DefinePresentationName: string;
begin
  Result := TPresentationProxyFactory.GeneratePresentationName(ClassType, ControlType);
end;

destructor TPresentedControl.Destroy;
begin
  UnloadPresentation;
  FModel.Free;
  inherited;
end;

procedure TPresentedControl.DoAbsoluteChanged;
begin
  inherited;
  if not (csLoading in ComponentState) and HasPresentationProxy then
    PresentationProxy.SendMessage(PM_ABSOLUTE_CHANGED);
end;

procedure TPresentedControl.DoActionClientChanged;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_ACTION_CLIENT_CHANGED);
end;

procedure TPresentedControl.DoDeleteChildren;
begin
  if not (csDestroying in ComponentState) then
    UnloadPresentation;
  inherited;
end;

procedure TPresentedControl.DoEnter;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_DO_ENTER);
end;

procedure TPresentedControl.DoExit;
begin
  inherited;
  if HasPresentationProxy then
  begin
    PresentationProxy.SendMessage(PM_RESET_FOCUS);
    PresentationProxy.SendMessage(PM_DO_EXIT);
  end;
end;

procedure TPresentedControl.DoPresentationNameChoosing(var APresentationName: string);
begin
  if Assigned(FOnPresenterNameChoosing) then
    FOnPresenterNameChoosing(Self, APresentationName);
end;

procedure TPresentedControl.DoRealign;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_REALIGN);
end;

procedure TPresentedControl.DoRootChanged;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage<IRoot>(PM_ROOT_CHANGED, Root);
end;

function TPresentedControl.DoSetSize(const ASize: TControlSize; const NewPlatformDefault: Boolean;
  ANewWidth, ANewHeight: Single; var ALastWidth, ALastHeight: Single): Boolean;
var
  NewSize: TSizeF;
  OldSize: TSizeF;
begin
  if HasPresentationProxy then
  begin
    NewSize := TSizeF.Create(System.Math.Max(0, ANewWidth), System.Math.Max(0, ANewHeight));
    NewSize := RecommendSize(NewSize);
    PresentationProxy.SendMessageWithResult<TSizeF>(PM_GET_SIZE, OldSize);
    Result := NewSize <> OldSize;
    ASize.SetSizeWithoutNotification(NewSize);
    ASize.SetPlatformDefaultWithoutNotification(NewPlatformDefault);
    PresentationProxy.SendMessage<TSizeF>(PM_SET_SIZE, NewSize);
  end
  else
    Result := inherited;
end;

function TPresentedControl.FindStyleResource(const AStyleLookup: string; const AClone: Boolean): TFmxObject;
var
  MessageInfo: TFindStyleResourceInfo;
begin
  Result := nil;
  if HasPresentationProxy then
  begin
    MessageInfo.Clone := AClone;
    MessageInfo.ResourceName := AStyleLookup;
    PresentationProxy.SendMessageWithResult<TFindStyleResourceInfo>(PM_FIND_STYLE_RESOURCE, MessageInfo);
    Result := MessageInfo.Resource;
  end;
  if Result = nil then
    Result := inherited;
end;

function TPresentedControl.GetAdjustSizeValue: TSizeF;
begin
  if HasPresentationProxy then
  begin
    Result := TSizeF.Create(0, 0);
    PresentationProxy.SendMessageWithResult<TSizeF>(PM_GET_ADJUST_SIZE, Result);
  end
  else
    Result := inherited;
end;

function TPresentedControl.GetAdjustType: TAdjustType;
begin
  if HasPresentationProxy then
  begin
    Result := TAdjustType.None;
    PresentationProxy.SendMessageWithResult<TAdjustType>(PM_GET_ADJUST_TYPE, Result);
  end
  else
    Result := inherited;
end;

function TPresentedControl.GetDefaultStyleLookupName: string;
const
  PresentedPrefix = 'presented';
begin
  Result := ClassName;
  if (Result.Chars[0].ToUpper = 'T') and (ClassName.ToLower.IndexOf(PresentedPrefix) = 1) then
    Result := GenerateStyleName(ClassName.Remove(1, PresentedPrefix.Length))
  else if ClassName.ToLower.IndexOf(PresentedPrefix) = 0 then
    Result := GenerateStyleName(ClassName.Remove(0, PresentedPrefix.Length))
  else
    Result := inherited;
end;

function TPresentedControl.GetFirstControlWithGesture(AGesture: TInteractiveGesture): TComponent;
var
  MessageInfo: TFirstControlWithGestureInfo;
begin
  Result := nil;
  if HasPresentationProxy then
  begin
    MessageInfo.Gestures := AGesture;
    MessageInfo.Control := nil;
    PresentationProxy.SendMessageWithResult<TFirstControlWithGestureInfo>(PM_GET_FIRST_CONTROL_WITH_GESTURE, MessageInfo);
    Result := MessageInfo.Control;
  end;
  if Result = nil then
    Result := inherited;
end;

function TPresentedControl.GetModel<T>: T;
begin
  Result := FModel as T;
end;

function TPresentedControl.GetPresentation: TObject;
begin
  if HasPresentationProxy then
    Result := PresentationProxy.Receiver
  else
    Result := nil;
end;

function TPresentedControl.GetPresentationSuffix: string;
begin
  Result := FControlType.ToString;
end;

function TPresentedControl.HasPresentationProxy: Boolean;
begin
  Result := FPresentationProxy <> nil;
end;

procedure TPresentedControl.HitTestChanged;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_HITTEST_CHANGED);
end;

procedure TPresentedControl.InitPresentation(APresentation: TPresentationProxy);
var
  RequiredSize: TSizeF;
begin
  APresentation.SendMessage<IRoot>(PM_ROOT_CHANGED, Root);
  APresentation.SendMessage<Single>(PM_SET_ABSOLUTE_OPACITY, AbsoluteOpacity);
  APresentation.SendMessage<Boolean>(PM_SET_VISIBLE, Visible);
  APresentation.SendMessage<Boolean>(PM_SET_ABSOLUTE_ENABLED, AbsoluteEnabled);
  APresentation.SendMessage<TSizeF>(PM_SET_SIZE, BoundsRect.Size);
  APresentation.SendMessage<Boolean>(PM_SET_CLIP_CHILDREN, ClipChildren);
  APresentation.SendMessage<string>(PM_SET_STYLE_LOOKUP, StyleLookup);
  APresentation.SendMessage<Boolean>(PM_ANCESSTOR_VISIBLE_CHANGED, ParentedVisible);
  APresentation.SendMessage(PM_HITTEST_CHANGED);
  if IsFocused then
    APresentation.SendMessage(PM_DO_ENTER);

  // Refresh control size base on size of native view.
  APresentation.SendMessageWithResult<TSizeF>(PM_GET_SIZE, RequiredSize);
  SetBounds(Position.X, Position.Y, RequiredSize.Width, RequiredSize.Height);
end;

procedure TPresentedControl.KeyDown(var AKey: Word; var AKeyChar: System.WideChar; AShift: TShiftState);
var
  KeyInfo: TKeyInfo;
begin
  inherited;
  if HasPresentationProxy then
  begin
    KeyInfo.Key := AKey;
    KeyInfo.KeyChar := AKeyChar;
    KeyInfo.Shift := AShift;
    PresentationProxy.SendMessageWithResult<TKeyInfo>(PM_KEYDOWN, KeyInfo);
    AKey := KeyInfo.Key;
    AKeyChar := KeyInfo.KeyChar;
  end;
end;

procedure TPresentedControl.KeyUp(var AKey: Word; var AKeyChar: Char; AShift: TShiftState);
var
  KeyInfo: TKeyInfo;
begin
  inherited;
  if HasPresentationProxy then
  begin
    KeyInfo.Key := AKey;
    KeyInfo.KeyChar := AKeyChar;
    KeyInfo.Shift := AShift;
    PresentationProxy.SendMessageWithResult<TKeyInfo>(PM_KEYUP, KeyInfo);
    AKey := KeyInfo.Key;
    AKeyChar := KeyInfo.KeyChar;
  end;
end;

procedure TPresentedControl.Loaded;
begin
  inherited;
  LoadPresentation;
end;

procedure TPresentedControl.LoadPresentation;
var
  FactoryManager: TPresentationProxyFactory;
  PresentationProxyClass: TPresentationProxyClass;
  PresentationName: string;
begin
  FactoryManager := TPresentationProxyFactory.Current;
  PresentationName := DefinePresentationName;
  DoPresentationNameChoosing(PresentationName);
  if CanUseDefaultPresentation and not FactoryManager.Supported(PresentationName) then
    PresentationName := 'default-' + GetPresentationSuffix;
  if FactoryManager.Supported(PresentationName) then
  begin
    PresentationProxyClass := FactoryManager.FindPresentationProxyClass(PresentationName);
    if not (PresentationProxy is PresentationProxyClass) then
    begin
      if HasPresentationProxy then
        UnloadPresentation;
      RemoveStyleResource;
      FState := TPresentationState.Loading;
      try
        FPresentationProxy := PresentationProxyClass.Create(Model, Self);
        InitPresentation(FPresentationProxy);
        PresentationProxy.SendMessage(PM_INIT);
        AncestorPresentationLoaded(Self);
      finally
        FState := TPresentationState.Loaded;
      end;
    end;
  end
  else
    if not (csDesigning in ComponentState) and (ControlType <> TControlType.Styled) then
      ControlType := TControlType.Styled
    else
    begin
      NeedStyleLookup;
      ApplyStyleLookup;
    end;
end;

procedure TPresentedControl.NeedStyleLookup;
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_NEED_STYLE_LOOKUP)
  else
    inherited;
end;

function TPresentedControl.ObjectAtPoint(P: TPointF): IControl;
var
  Msg: TObjectAtPointInfo;
begin
  Result := inherited;
  if HasPresentationProxy and ((Result = nil) or (Result.GetObject = Self)) then
  begin
    Msg.Control := nil;
    Msg.Point := P;
    PresentationProxy.SendMessageWithResult<TObjectAtPointInfo>(PM_OBJECT_AT_POINT, Msg);
    if Msg.Control <> nil then
      Result := Msg.Control;
  end;
end;

procedure TPresentedControl.AfterPaint;
const
  LabelMargins = 3;
  LabelPadding = 3;

  function GetOverlayIcon: TBitmap;
  var
    Service: IPresentedControlBehavior;
  begin
    if TBehaviorServices.Current.SupportsBehaviorService(IPresentedControlBehavior, Service, Self) then
      Result := Service.GetOverlayIcon
    else
      Result := nil;
  end;

  procedure PaintDesignTimeCaption;
  const
    ControlTypeCaption = 'P';
  var
    TextWidth: Double;
    TextHeight: Double;
    TextRect: TRectF;
  begin
    TextWidth := Canvas.TextWidth(ControlTypeCaption) + 2 * LabelPadding;
    TextHeight := Canvas.TextHeight(ControlTypeCaption) + 2 * LabelPadding;
    TextRect := TRectF.Create(TPointF.Create(Width - TextWidth - LabelMargins, Height - TextHeight - LabelMargins),
      TextWidth, TextHeight);
    Canvas.Fill.Color := TAlphaColorRec.Black;
    Canvas.FillRect(TextRect, 3, 3, AllCorners, 0.5);
    Canvas.Fill.Color := TAlphaColorRec.White;
    Canvas.FillText(TextRect, ControlTypeCaption, False, 1, [], TTextAlign.Center, TTextAlign.Center);
  end;

  procedure PaintDesignTimeIcon;
  var
    Icon: TBitmap;
    IconRect: TRectF;
    DestRect: TRectF;
  begin
    Icon := GetOverlayIcon;
    if Icon <> nil then
    begin
      IconRect := TRectF.Create(0, 0, Icon.Width, Icon.Height);
      DestRect := TRectF.Create(TPointF.Create(Width - LabelPadding - Icon.Width, Height - LabelPadding - Icon.Height),
        Icon.Width, Icon.Height);
      Canvas.DrawBitmap(Icon, IconRect, DestRect, 0.5);
    end
    else
      PaintDesignTimeCaption;
  end;

begin
  inherited;
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo and (ControlType = TControlType.Platform) then
  begin
    Canvas.SetMatrix(AbsoluteMatrix);
    PaintDesignTimeIcon;
  end;
end;

procedure TPresentedControl.ParentChanged;
begin
  inherited;
  if HasPresentationProxy then
  begin
    NeedStyleLookup;
    PresentationProxy.SendMessage(PM_REFRESH_PARENT);
  end;
end;

function TPresentedControl.PointInObjectLocal(X, Y: Single): Boolean;
var
  PointInObjectInfo: TPointInObjectLocalInfo;
begin
  PointInObjectInfo.Result := inherited PointInObjectLocal(X, Y);
  if HasPresentationProxy then
  begin
    PointInObjectInfo.Point := TPointF.Create(X, Y);
    PresentationProxy.SendMessageWithResult<TPointInObjectLocalInfo>(PM_POINT_IN_OBJECT_LOCAL, PointInObjectInfo);
  end;
  Result := PointInObjectInfo.Result;
end;

function TPresentedControl.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) or (HasPresentationProxy and PresentationProxy.Receiver.GetInterface(IID, Obj)) then
    Result := S_OK
  else
    Result := E_NOINTERFACE
end;

procedure TPresentedControl.RecalcEnabled;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage<Boolean>(PM_SET_ABSOLUTE_ENABLED, AbsoluteEnabled);
end;

procedure TPresentedControl.RecalcOpacity;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage<Single>(PM_SET_ABSOLUTE_OPACITY, AbsoluteOpacity);
end;

function TPresentedControl.RecommendSize(const AWishedSize: TSizeF): TSizeF;
begin
  Result := AWishedSize;
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<TSizeF>(PM_GET_RECOMMEND_SIZE, Result);
end;

procedure TPresentedControl.ReloadPresentation;
begin
  UnloadPresentation;
  LoadPresentation;
end;

procedure TPresentedControl.RemoveStyleResource;
var
  SaveResourceLink: TFmxObject;
begin
  SaveResourceLink := inherited ResourceLink;
  if SaveResourceLink <> nil then
  begin
    try
      SaveResourceLink.Parent := nil;
      FreeStyle;
    finally
      SaveResourceLink.DisposeOf;
    end;
    SetAdjustType(TAdjustType.None);
  end;
end;

function TPresentedControl.RequestStyleData(const Index: string): TValue;
var
  DataRecord: TDataRecord;
begin
  if HasPresentationProxy then
  begin
    DataRecord := TDataRecord.Create(Index, TValue.Empty);
    PresentationProxy.SendMessage<TDataRecord>(PM_GET_STYLES_DATA, DataRecord);
    Result := DataRecord.Value;
  end
  else
    Result := inherited;
end;

function TPresentedControl.GetResourceLink: TFmxObject;
begin
  Result := nil;
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<TFmxObject>(PM_GET_RESOURCE_LINK, Result);
  if Result = nil then
    Result := inherited;
end;

procedure TPresentedControl.UnloadPresentation;
begin
  if HasPresentationProxy then
  begin
    FState := TPresentationState.Unloading;
    try
      Model.Receiver := nil;
      FPresentationProxy.SendMessage(PM_UNLOAD);
      FreeAndNil(FPresentationProxy);
    finally
      FState := TPresentationState.NotLoaded;
    end;
  end;
end;

procedure TPresentedControl.SetAdjustSizeValue(const Value: TSizeF);
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage<TSizeF>(PM_SET_ADJUST_SIZE, Value)
  else
    inherited;
end;

procedure TPresentedControl.SetAdjustType(const Value: TAdjustType);
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage<TAdjustType>(PM_SET_ADJUST_TYPE, Value)
  else
    inherited;
end;

procedure TPresentedControl.SetControlType(const Value: TControlType);
begin
  if ControlType <> Value then
  begin
    FControlType := Value;
    ControlTypeChanged;
    if not (csLoading in ComponentState) then
      ReloadPresentation;
  end;
end;

procedure TPresentedControl.SetVisible(const Value: Boolean);
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage<Boolean>(PM_SET_VISIBLE, Value);
end;

procedure TPresentedControl.ApplyTriggerEffect(const AInstance: TFmxObject; const ATrigger: string);
var
  Info: TTriggerInfo;
begin
  inherited;
  if HasPresentationProxy then
  begin
    Info.Instance := AInstance;
    Info.Trigger := ATrigger;
    Info.Wait := False;
    PresentationProxy.SendMessage<TTriggerInfo>(PM_APPLY_TRIGGER_EFFECT, Info)
  end;
end;

procedure TPresentedControl.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
var
  Info: TTriggerInfo;
begin
  inherited;
  if HasPresentationProxy then
  begin
    Info.Instance := AInstance;
    Info.Trigger := ATrigger;
    Info.Wait := False;
    PresentationProxy.SendMessage<TTriggerInfo>(PM_START_TRIGGER_ANIMATION, Info)
  end;
end;

procedure TPresentedControl.StartTriggerAnimationWait(const AInstance: TFmxObject; const ATrigger: string);
var
  Info: TTriggerInfo;
begin
  inherited;
  if HasPresentationProxy then
  begin
    Info.Instance := AInstance;
    Info.Trigger := ATrigger;
    Info.Wait := True;
    PresentationProxy.SendMessage<TTriggerInfo>(PM_START_TRIGGER_ANIMATION, Info)
  end;
end;

procedure TPresentedControl.StyleDataChanged(const Index: string; const Value: TValue);
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage<TDataRecord>(PM_SET_STYLES_DATA, TDataRecord.Create(Index, Value))
  else
    inherited;
end;

procedure TPresentedControl.StyleLookupChanged;
begin
  inherited;
  if HasPresentationProxy then
    PresentationProxy.SendMessage<string>(PM_SET_STYLE_LOOKUP, StyleLookup);
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TControlType), ['Custom', 'Native']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TControlType));
end;

initialization
  RegisterAliases;
finalization
  UnregisterAliases;
end.
