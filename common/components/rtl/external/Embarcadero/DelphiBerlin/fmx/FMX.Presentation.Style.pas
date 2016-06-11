{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Presentation.Style;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, System.Math.Vectors, System.Rtti, System.UITypes, FMX.Controls, FMX.Types,
  FMX.Presentation.Messages, FMX.Controls.Presentation, FMX.Controls.Model;

type

  { TStyledPresentation }

  /// <summary>Basic Style presentation, which is TStyledControl object.</summary>
  TStyledPresentation = class(TStyledControl)
  private
    [Weak] FModel: TDataModel;
    [Weak] FPresentedControl: TControl;
    procedure SetDataToStyleObject(const AName: string; const AValue: TValue);
    function GetDataFromStyleObject(const AName: string): TValue;
    function GetComponentState: TComponentState;
  protected
    { Messages from Model }
    /// <summary>Notification about changing value of DataSource of a model of <c>PresentedControl</c> </summary>
    procedure MMDataChanged(var AMessage: TDispatchMessageWithValue<TDataRecord>); message PM_SET_STYLES_DATA;
    /// <summary>Request on getting data of presentation.</summary>
    procedure MMGetData(var AMessage: TDispatchMessageWithValue<TDataRecord>); message PM_GET_STYLES_DATA;
    { Messages from PresentationProxy }
    /// <summary>Notification about unloading presentation from <c>TPresentedControl</c></summary>
    procedure PMUnload(var AMessage: TDispatchMessage); message PM_UNLOAD;
    /// <summary>Notification about changing host <c>PresentedControl</c> of presentation </summary>
    procedure PMSetSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_SET_SIZE;
    procedure PMGetSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_GET_SIZE;
    procedure PMDoEnter(var AMessage: TDispatchMessage); message PM_DO_ENTER;
    procedure PMDoExit(var AMessage: TDispatchMessage); message PM_DO_EXIT;
    procedure PMIsFocused(var AMessage: TDispatchMessageWithValue<Boolean>); message PM_IS_FOCUSED;
    procedure PMGetRecommendSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_GET_RECOMMEND_SIZE;
    procedure PMSetStyleLookup(var AMessage: TDispatchMessageWithValue<string>); message PM_SET_STYLE_LOOKUP;
    procedure PMGetStyleLookup(var AMessage: TDispatchMessageWithValue<string>); message PM_GET_STYLE_LOOKUP;
    /// <summary>Request on finding style's resource in presentation</summary>
    procedure PMFindStyleResource(var AMessage: TDispatchMessageWithValue<TFindStyleResourceInfo>); message PM_FIND_STYLE_RESOURCE;
    procedure PMKeyDown(var AMessage: TDispatchMessageWithValue<TKeyInfo>); message PM_KEYDOWN;
    procedure PMKeyUp(var AMessage: TDispatchMessageWithValue<TKeyInfo>); message PM_KEYUP;
    procedure PMRealign(var AMessage: TDispatchMessage); message PM_REALIGN;
    procedure PMActionClientChanged(var AMessage: TDispatchMessage); message PM_ACTION_CLIENT_CHANGED;
    procedure PMActionChange(var AMessage: TDispatchMessageWithValue<TActionInfo>); message PM_ACTION_CHANGE;
    procedure PMApplyStyleLookup(var AMessage: TDispatchMessage); message PM_APPLY_STYLE_LOOKUP;
    procedure PMNeedStyleLookup(var AMessage: TDispatchMessage); message PM_NEED_STYLE_LOOKUP;
    procedure PMHitTestChanged(var AMessage: TDispatchMessage); message PM_HITTEST_CHANGED;
    procedure PMGetAdjustSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_GET_ADJUST_SIZE;
    /// <summary> Called from PresentedControl when SetAdjustSize method is called.</summary>
    procedure PMSetAdjustSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_SET_ADJUST_SIZE;
    procedure PMGetAdjustType(var AMessage: TDispatchMessageWithValue<TAdjustType>); message PM_GET_ADJUST_TYPE;
    ///<summary>Request to set new TAdjustType value in presentation</summary>
    procedure PMSetAdjustType(var AMessage: TDispatchMessageWithValue<TAdjustType>); message PM_SET_ADJUST_TYPE;
    /// <summary> Called from PresentedControl when StartTriggerAnimation method is called.</summary>
    procedure PMStartTriggerAnimation(var AMessage: TDispatchMessageWithValue<TTriggerInfo>); message PM_START_TRIGGER_ANIMATION;
    /// <summary> Called from PresentedControl when ApplyTriggerEffect method is called.</summary>
    procedure PMApplyTriggerEffect(var AMessage: TDispatchMessageWithValue<TTriggerInfo>); message PM_APPLY_TRIGGER_EFFECT;
    /// <summary>Gets resource link from presentation</summary>
    procedure PMGetResourceLink(var AMessage: TDispatchMessageWithValue<TFmxObject>); message PM_GET_RESOURCE_LINK;
    /// <summary>Checks is point in presentation or not</summary>
    procedure PMPointInObject(var AMessage: TDispatchMessageWithValue<TPointInObjectLocalInfo>); message PM_POINT_IN_OBJECT_LOCAL;
    /// <summary>Notification about changing absolute position of <c>PresentedControl</c>.</summary>
    procedure PMAbsoluteChanged(var AMessage: TDispatchMessage); message PM_ABSOLUTE_CHANGED;
    /// <summary>Requests, is current presentation can perform gestures or nor?</summary>
    procedure PMGetFirstControlWithGesture(var AMessage: TDispatchMessageWithValue<TFirstControlWithGestureInfo>); message PM_GET_FIRST_CONTROL_WITH_GESTURE;
    /// <summary>Implementation of IControl.HasHint.</summary>
    function HasHint: Boolean; override;
    /// <summary>Implementation of IControl.GetHintString.</summary>
    function GetHintString: string; override;
  protected
    function GetObservers: TObservers; override;
    function GetDefaultStyleLookupName: string; override;
    function GetParentClassStyleLookupName: string; override;
    procedure AdjustSize; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetStyleContext: TFmxObject; override;
    function GetStyleObject(const Clone: Boolean): TFmxObject; override;
    function GetStyleObject: TFmxObject; override;
    procedure DoApplyStyleLookup; override;
    function ShowContextMenu(const ScreenPosition: TPointF): Boolean; override;
    { Mouse Events }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X: Single; Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    procedure MouseClick(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
    { Drag and Drop }
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    procedure DragEnd; override;
    procedure DragEnter(const Data: TDragObject; const Point: TPointF); override;
    procedure DragLeave; override;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation); override;
    function GetDragMode: TDragMode; override;
    procedure BeginAutoDrag; override;
    { Focus }
    function GetCanParentFocus: Boolean; override;
    { IGestureControl }
    procedure Tap(const Point: TPointF); override;
    procedure CMGesture(var EventInfo: TGestureEventInfo); override;
    /// <summary>Defines a class of model. If ancesstor overrides model class, presentation can check class of model
    /// in moment, when presented control send a model.</summary>
    function DefineModelClass: TDataModelClass; virtual;
    /// <summary>Tries to cast current model to type <c>T</c>. If specified type <c>T</c> is not compatible with
    /// <c>Model</c>, return nil.</summary>
    function GetModel<T: TDataModel>: T;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; const AModel: TDataModel; const AControl: TControl); overload; virtual;
    procedure SetNewScene(AScene: IScene); override;
    function HasModel: Boolean;
    function PointInObjectLocal(X: Single; Y: Single): Boolean; override;
    property PresentedControl: TControl read FPresentedControl;
    /// <summary>Returns component state of <c>PresentedControl</c></summary>
    property ComponentState: TComponentState read GetComponentState;
  end;
  TStyledPresentationClass = class of TStyledPresentation;

{ TStyledPresentationProxy }

  /// <summary>Default proxy for styled presentation</summary>
  TStyledPresentationProxy = class(TPresentationProxy)
  protected
    function CreateReceiver: TObject; override;
  end;

  /// <summary>Generics proxy for all styled presentations</summary>
  TStyledPresentationProxy<T: TStyledPresentation, constructor> = class(TStyledPresentationProxy)
  protected
    function CreateReceiver: TObject; override;
  end;

implementation

uses
  System.SysUtils, System.Math, System.Generics.Collections, FMX.Ani, FMX.Consts, FMX.Utils, FMX.Presentation.Factory;

type
  TOpenStyledControl = class(TStyledControl);

{ TStyledPresentation }

procedure TStyledPresentation.AdjustSize;
begin
  // All needed things is doing in TPresentedControl.AdjustSize, because all needed proeprties bridged using messages
end;

procedure TStyledPresentation.ApplyStyle;
var
  Entry: TPair<string, TValue>;
begin
  inherited;
  { Models Data }
  if (FModel.DataSource <> nil) and (FModel.DataSource.Count > 0) then
    for Entry in FModel.DataSource do
      SetDataToStyleObject(Entry.Key, Entry.Value);
  TOpenStyledControl(PresentedControl).ApplyStyle;
end;

procedure TStyledPresentation.BeginAutoDrag;
begin
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).BeginAutoDrag
  else
    inherited;
end;

procedure TStyledPresentation.CMGesture(var EventInfo: TGestureEventInfo);
var
  GestureControl: IGestureControl;
begin
  inherited;
  if Supports(PresentedControl, IGestureControl, GestureControl) then
    GestureControl.CMGesture(EventInfo);
end;

constructor TStyledPresentation.Create(AOwner: TComponent; const AModel: TDataModel; const AControl: TControl);
begin
  FPresentedControl := AControl;
  FModel := AModel;
  if FModel is DefineModelClass then
    FModel.Receiver := Self
  else
    raise EPresentationWrongModel.CreateFmt(SWrongModelClassType, [DefineModelClass.ClassName, FModel.ClassName]);

  Create(AOwner);

  FPresentedControl.InsertObject(0, Self);
end;

constructor TStyledPresentation.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
  CanParentFocus := True;
  DisableDisappear := True;
  Lock;
  Stored := False;
end;

function TStyledPresentation.DefineModelClass: TDataModelClass;
begin
  Result := TDataModel;
end;

procedure TStyledPresentation.DoApplyStyleLookup;
begin
  inherited;
  if Assigned(PresentedControl.OnApplyStyleLookup) then
    PresentedControl.OnApplyStyleLookup(PresentedControl);
end;

procedure TStyledPresentation.DoMouseEnter;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).DoMouseEnter;
end;

procedure TStyledPresentation.DoMouseLeave;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).DoMouseLeave;
end;

procedure TStyledPresentation.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).DragDrop(Data, Point);
end;

procedure TStyledPresentation.DragEnd;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).DragEnd;
end;

procedure TStyledPresentation.DragEnter(const Data: TDragObject; const Point: TPointF);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).DragEnter(Data, Point);
end;

procedure TStyledPresentation.DragLeave;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).DragLeave;
end;

procedure TStyledPresentation.DragOver(const Data: TDragObject; const Point: TPointF;
  var Operation: TDragOperation);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).DragOver(Data, Point, Operation);
end;

procedure TStyledPresentation.FreeStyle;
var
  Entry: TPair<string, TValue>;
begin
  TOpenStyledControl(PresentedControl).FreeStyle;
  { Models Data }
  if (FModel <> nil) and (FModel.DataSource <> nil) and (FModel.DataSource.Count > 0) then
  begin
    for Entry in FModel.DataSource do
      FModel.DataSource.AddOrSetValue(Entry.Key, FModel.Data[Entry.Key]);
  end;
  inherited;
end;

function TStyledPresentation.GetCanParentFocus: Boolean;
begin
  if PresentedControl <> nil then
    Result := PresentedControl.CanParentFocus
  else
    Result := inherited;
end;

function TStyledPresentation.GetComponentState: TComponentState;
begin
  Result := PresentedControl.ComponentState
end;

function TStyledPresentation.GetDataFromStyleObject(const AName: string): TValue;
var
  Obj: TObject;
  InstanceName, PropertyName: string;
  PropertyValue: TValue;
begin
  Result := TValue.Empty;
  if AName.Contains('.') then
  begin
    PropertyName := AName;
    InstanceName := GetToken(PropertyName, '.');
  end
  else
    InstanceName := AName;

  Obj := FindStyleResource(InstanceName);
  if Obj <> nil then
  begin
    if not PropertyName.IsEmpty then
    begin
      if FindProperty(Obj, PropertyName,
        procedure (Instance: TObject; Prop: TRttiProperty)
        begin
          PropertyValue := Prop.GetValue(Instance);
        end) then
        Result := PropertyValue;
    end
    else
      Result := TFmxObject(Obj).Data
  end;
end;

function TStyledPresentation.GetDefaultStyleLookupName: string;
begin
  if PresentedControl is TStyledControl then
    Result := TStyledControl(PresentedControl).DefaultStyleLookupName
  else
  begin
    Result := inherited;
    Result := Result.Remove(0, 6);
  end;
end;

function TStyledPresentation.GetDragMode: TDragMode;
begin
  Result := PresentedControl.DragMode
end;

function TStyledPresentation.GetHintString: string;
begin
  Result := IControl(PresentedControl).GetHintString;
end;

function TStyledPresentation.GetParentClassStyleLookupName: string;
begin
  if PresentedControl is TStyledControl then
    Result := TStyledControl(PresentedControl).ParentClassStyleLookupName
  else
  begin
    Result := inherited;
    Result := Result.Remove(0, 6);
  end;
end;

function TStyledPresentation.GetStyleContext: TFmxObject;
begin
  Result := PresentedControl;
end;

function TStyledPresentation.GetStyleObject: TFmxObject;
begin
  Result := TOpenStyledControl(PresentedControl).GetStyleObject
end;

function TStyledPresentation.GetStyleObject(const Clone: Boolean): TFmxObject;
begin
  Result := TOpenStyledControl(PresentedControl).GetStyleObject(Clone)
end;

function TStyledPresentation.GetModel<T>: T;
begin
  Result := FModel as T;
end;

function TStyledPresentation.GetObservers: TObservers;
begin
  Result := PresentedControl.Observers
end;

function TStyledPresentation.HasHint: Boolean;
begin
  Result := IControl(PresentedControl).HasHint;
end;

function TStyledPresentation.HasModel: Boolean;
begin
  Result := FModel <> nil;
end;

procedure TStyledPresentation.PMAbsoluteChanged(var AMessage: TDispatchMessage);
begin
  Size.Size := PresentedControl.Size.Size;
end;

procedure TStyledPresentation.MMDataChanged(var AMessage: TDispatchMessageWithValue<TDataRecord>);
begin
  SetDataToStyleObject(AMessage.Value.Key, AMessage.Value.Value);
end;

procedure TStyledPresentation.MMGetData(var AMessage: TDispatchMessageWithValue<TDataRecord>);
begin
  AMessage.Value.Value := GetDataFromStyleObject(AMessage.Value.Key);
end;

procedure TStyledPresentation.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).MouseDown(Button, Shift, X, Y);
end;

procedure TStyledPresentation.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).MouseMove(Shift, X, Y);
end;

procedure TStyledPresentation.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).MouseUp(Button, Shift, X, Y);
end;

procedure TStyledPresentation.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).MouseWheel(Shift, WheelDelta, Handled);
end;

procedure TStyledPresentation.MouseClick(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    IControl(PresentedControl).MouseClick(Button, Shift, X, Y);
end;

procedure TStyledPresentation.PMActionChange(var AMessage: TDispatchMessageWithValue<TActionInfo>);
begin
  ActionChange(AMessage.Value.Sender, AMessage.Value.CheckDefaults);
end;

procedure TStyledPresentation.PMActionClientChanged(var AMessage: TDispatchMessage);
begin
  DoActionClientChanged;
end;

procedure TStyledPresentation.PMApplyStyleLookup(var AMessage: TDispatchMessage);
begin
  ApplyStyleLookup;
end;

procedure TStyledPresentation.PMDoEnter(var AMessage: TDispatchMessage);
begin
  FIsFocused := PresentedControl.CanFocus;
  DoEnter;
  if FIsFocused and not (DisableFocusEffect or GlobalDisableFocusEffect) then
  begin
    TAnimator.StartTriggerAnimation(Self, Self, 'IsFocused');
    ApplyTriggerEffect(Self, 'IsFocused');
  end;
end;

procedure TStyledPresentation.PMDoExit(var AMessage: TDispatchMessage);
begin
  DoExit;
  if FIsFocused and not (DisableFocusEffect or GlobalDisableFocusEffect) then
  begin
    TAnimator.StartTriggerAnimation(Self, Self, 'IsFocused');
    ApplyTriggerEffect(Self, 'IsFocused');
  end;
end;

procedure TStyledPresentation.PMFindStyleResource(var AMessage: TDispatchMessageWithValue<TFindStyleResourceInfo>);
begin
  AMessage.Value.Resource := FindStyleResource(AMessage.Value.ResourceName, AMessage.Value.Clone);
end;

procedure TStyledPresentation.PMGetAdjustSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
  AMessage.Value := AdjustSizeValue;
end;

procedure TStyledPresentation.PMSetAdjustSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
  SetAdjustSizeValue(AMessage.Value);
end;

procedure TStyledPresentation.PMSetAdjustType(var AMessage: TDispatchMessageWithValue<TAdjustType>);
begin
  SetAdjustType(AMessage.Value);
end;

procedure TStyledPresentation.PMGetAdjustType(var AMessage: TDispatchMessageWithValue<TAdjustType>);
begin
  AMessage.Value := AdjustType;
end;

procedure TStyledPresentation.PMGetFirstControlWithGesture(
  var AMessage: TDispatchMessageWithValue<TFirstControlWithGestureInfo>);
begin
  if AMessage.Value.Gestures in Touch.InteractiveGestures then
    AMessage.Value.Control := Self;
end;

procedure TStyledPresentation.PMGetRecommendSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
var
  Size: TSizeF;
begin
  if AdjustType in [TAdjustType.FixedSize, TAdjustType.FixedWidth] then
    Size.Width := AdjustSizeValue.Width
  else
    Size.Width := AMessage.Value.Width;

  if AdjustType in [TAdjustType.FixedSize, TAdjustType.FixedHeight] then
    Size.Height := AdjustSizeValue.Height
  else
    Size.Height := AMessage.Value.Height;

  AMessage.Value := Size;
end;

procedure TStyledPresentation.PMGetResourceLink(var AMessage: TDispatchMessageWithValue<TFmxObject>);
begin
  AMessage.Value := ResourceLink;
end;

procedure TStyledPresentation.PMGetSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
var
  Size: TSizeF;
begin
  if AdjustType in [TAdjustType.FixedSize, TAdjustType.FixedWidth] then
    Size.Width := AdjustSizeValue.Width
  else
    Size.Width := Width;

  if AdjustType in [TAdjustType.FixedSize, TAdjustType.FixedHeight] then
    Size.Height := AdjustSizeValue.Height
  else
    Size.Height := Height;

  AMessage.Value := Size;
end;

procedure TStyledPresentation.PMGetStyleLookup(var AMessage: TDispatchMessageWithValue<string>);
begin
  AMessage.Value := StyleLookup;
end;

procedure TStyledPresentation.PMHitTestChanged(var AMessage: TDispatchMessage);
begin
  HitTest := PresentedControl.HitTest;
end;

procedure TStyledPresentation.PMIsFocused(var AMessage: TDispatchMessageWithValue<Boolean>);
begin
  AMessage.Value := IsFocused;
end;

procedure TStyledPresentation.PMKeyDown(var AMessage: TDispatchMessageWithValue<TKeyInfo>);
begin
  KeyDown(AMessage.Value.Key, AMessage.Value.KeyChar, AMessage.Value.Shift);
end;

procedure TStyledPresentation.PMKeyUp(var AMessage: TDispatchMessageWithValue<TKeyInfo>);
begin
  KeyUp(AMessage.Value.Key, AMessage.Value.KeyChar, AMessage.Value.Shift);
end;

procedure TStyledPresentation.PMNeedStyleLookup(var AMessage: TDispatchMessage);
begin
  NeedStyleLookup;
end;

procedure TStyledPresentation.PMPointInObject(var AMessage: TDispatchMessageWithValue<TPointInObjectLocalInfo>);
var
  Point: TPointF;
begin
  Point := AMessage.Value.Point;
  AMessage.Value.Result := PointInObjectLocal(Point.X, Point.Y);
end;

procedure TStyledPresentation.PMRealign(var AMessage: TDispatchMessage);
begin
  Realign;
end;

procedure TStyledPresentation.PMSetSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
var
  SizeTmp: TSizeF;
begin
  if AdjustType in [TAdjustType.FixedSize, TAdjustType.FixedWidth] then
    SizeTmp.Width := AdjustSizeValue.Width
  else
    SizeTmp.Width := AMessage.Value.Width;

  if AdjustType in [TAdjustType.FixedSize, TAdjustType.FixedHeight] then
    SizeTmp.Height := AdjustSizeValue.Height
  else
    SizeTmp.Height := AMessage.Value.Height;

  Size.Size := SizeTmp;
end;

procedure TStyledPresentation.PMSetStyleLookup(var AMessage: TDispatchMessageWithValue<string>);
begin
  if StyleLookup <> AMessage.Value then
    StyleLookup := AMessage.Value;
end;

procedure TStyledPresentation.PMApplyTriggerEffect(var AMessage: TDispatchMessageWithValue<TTriggerInfo>);
begin
  ApplyTriggerEffect(AMessage.Value.Instance, AMessage.Value.Trigger);
end;

procedure TStyledPresentation.PMStartTriggerAnimation(var AMessage: TDispatchMessageWithValue<TTriggerInfo>);
begin
  if AMessage.Value.Wait then
    StartTriggerAnimationWait(AMessage.Value.Instance, AMessage.Value.Trigger)
  else
    StartTriggerAnimation(AMessage.Value.Instance, AMessage.Value.Trigger);
end;

procedure TStyledPresentation.PMUnload(var AMessage: TDispatchMessage);
begin
  Parent := nil;
end;

function TStyledPresentation.PointInObjectLocal(X, Y: Single): Boolean;
var
  Expansion: TBounds;
begin
  Expansion := FPresentedControl.TouchTargetExpansion;
  Result := InRange(X, 0 - Expansion.Left, Width + Expansion.Right) and
    InRange(Y, 0 - Expansion.Top, Height + Expansion.Bottom);
end;

procedure TStyledPresentation.SetDataToStyleObject(const AName: string; const AValue: TValue);
var
  Obj: TObject;
  InstanceName, PropertyName: string;
  PropertyValue: TValue;
begin
  PropertyName := AName;
  InstanceName := GetToken(PropertyName, '.');

  Obj := FindStyleResource(InstanceName);
  if Obj <> nil then
    if not PropertyName.IsEmpty then
    begin
      PropertyValue := AValue;
      FindProperty(Obj, PropertyName,
        procedure (Instance: TObject; Prop: TRttiProperty)
        begin
          Prop.SetValue(Instance, PropertyValue);
        end);
    end
    else
      TFmxObject(Obj).Data := AValue;
end;

procedure TStyledPresentation.SetNewScene(AScene: IScene);
begin
  inherited;
                                                     
  NeedStyleLookup;
end;

function TStyledPresentation.ShowContextMenu(const ScreenPosition: TPointF): Boolean;
begin
  Result := IControl(PresentedControl).ShowContextMenu(ScreenPosition);
end;

procedure TStyledPresentation.Tap(const Point: TPointF);
var
  GestureControl: IGestureControl;
begin
  inherited;
  if Supports(PresentedControl, IGestureControl, GestureControl) then
    GestureControl.Tap(Point);
end;

{ TStdStyledPresentationProxy }

function TStyledPresentationProxy.CreateReceiver: TObject;
begin
  Result := TStyledPresentation.Create(nil, Model, PresentedControl);
end;

{ TStyledPresentationProxy<TPresentation> }

function TStyledPresentationProxy<T>.CreateReceiver: TObject;
var
  PresentationClass: TStyledPresentationClass;
begin
  PresentationClass := T;
  Result := PresentationClass.Create(nil, Model, PresentedControl);
end;

end.
