{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Switch.Win;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, Winapi.Messages, FMX.StdCtrls, FMX.Presentation.Messages, FMX.Controls.Presentation,
  FMX.Styles.Switch, FMX.Presentation.Win.Style, FMX.Controls.Model;

type

{ TWinSwitch }

  /// <summary>Styled presentation of <c>TSwitch</c></summary>
  TWinSwitch = class(TWinStyledPresentation)
  private
    [Weak] FModel: TSwitchModel;
    [Weak] FSwitchObject: TCustomSwitchObject;
    FMouseEntered: Boolean;
    procedure SwitchObjectChanged(Sender: TObject);
  protected
    { Messages from Model}
    /// <summary>Notification about changing Value of <c>TSwitch</c></summary>
    procedure MMValueChanged(var AMessage: TDispatchMessageWithValue<Boolean>); message MM_VALUE_CHANGED;
    { Messages from Controller }
    /// <summary>Notification about initialization of current presentation</summary>
    procedure PMInit(var AMessage: TDispatchMessage); message PM_INIT;
    { Windows messages }
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseLeave(var Message: TMessage); message WM_MOUSELEAVE;
  protected
    /// <summary>Defines <c>TSwitch</c> model class</summary>
    function DefineModelClass: TDataModelClass; override;
    { Styles }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    { Mouse Events }
    /// <summary>Notification about entering mouse cursor into presentation</summary>
    procedure DoMouseEnter; virtual;
    /// <summary>Notification about leaving mouse cursor from presentation</summary>
    procedure DoMouseLeave; virtual;
    /// <summary>Changes value of <c>TSwitchModel.Value</c></summary>
    procedure DoSwitch; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>Model of <c>TSwitch</c></summary>
    property Model: TSwitchModel read FModel;
    /// <summary>Access to switch style object. Can be nil, if current style doesn't have it.</summary>
    property SwitchObject: TCustomSwitchObject read FSwitchObject;
  end;

implementation

uses
  System.UITypes, System.SysUtils, Winapi.Windows, FMX.Presentation.Factory, FMX.Controls, FMX.Types, FMX.Helpers.Win,
  FMX.Presentation.Win;

{ TStyledSwitch }

procedure TWinSwitch.ApplyStyle;
begin
  // We don't invoke inherited ApplyStyle, because we don't want to send it to PresentedControl
  if ResourceLink is TCustomSwitchObject then
  begin
    FSwitchObject := TCustomSwitchObject(ResourceLink);
    FSwitchObject.Value := Model.Value;
    FSwitchObject.Control := Control;
    FSwitchObject.OnChange := SwitchObjectChanged;
  end;
end;

constructor TWinSwitch.Create(AOwner: TComponent);
begin
  inherited;
  FModel := TSwitchModel(inherited Model);
  FMouseEntered := False;
end;

procedure TWinSwitch.DoSwitch;
begin
  Model.DisableNotify;
  try
    if SwitchObject <> nil then
      Model.Value := FSwitchObject.Value;
    Model.Change;
  finally
    Model.EnableNotify;
  end;
end;

procedure TWinSwitch.FreeStyle;
begin
  if FSwitchObject <> nil then
  begin
    FSwitchObject.Control := nil;
    FSwitchObject.OnChange := nil;
    FSwitchObject := nil;
  end;
end;

procedure TWinSwitch.MMValueChanged(var AMessage: TDispatchMessageWithValue<Boolean>);
begin
  if FSwitchObject <> nil then
    FSwitchObject.Value := AMessage.Value
  else
    SwitchObjectChanged(Self);
end;

function TWinSwitch.DefineModelClass: TDataModelClass;
begin
  Result := TSwitchModel;
end;

procedure TWinSwitch.DoMouseEnter;
var
  Control: IControl;
begin
  if Supports(FSwitchObject, IControl, Control) then
    Control.DoMouseEnter;
end;

procedure TWinSwitch.DoMouseLeave;
var
  Control: IControl;
begin
  if Supports(FSwitchObject, IControl, Control) then
    Control.DoMouseLeave;
end;

procedure TWinSwitch.PMInit(var AMessage: TDispatchMessage);
begin
  inherited;
  if SwitchObject <> nil then
    SwitchObject.Value := Model.Value;
end;

procedure TWinSwitch.SwitchObjectChanged(Sender: TObject);
begin
  DoSwitch;
end;

procedure TWinSwitch.WMLButtonDown(var Message: TWMLButtonDown);
var
  Control: IControl;
begin
  // We don't invoke inherited method, because we don't want to send mouse event to PresentedControl
  SetCapture(Handle);
  if Supports(FSwitchObject, IControl, Control) then
    Control.MouseDown(TMouseButton.mbLeft, KeysToShiftState(Message.Keys), Message.XPos, Message.YPos);
end;

procedure TWinSwitch.WMLButtonUp(var Message: TWMLButtonUp);
var
  Control: IControl;
begin
  try
    if Supports(FSwitchObject, IControl, Control) then
     Control.MouseUp(TMouseButton.mbLeft, KeysToShiftState(Message.Keys), Message.XPos, Message.YPos);
  finally
    ReleaseCapture;
  end;
end;

procedure TWinSwitch.WMMouseLeave(var Message: TMessage);
begin
  FMouseEntered := False;
  DoMouseLeave;
end;

procedure TWinSwitch.WMMouseMove(var Message: TWMMouseMove);

  procedure StartTrackMouseLeave;
  var
    EventTrack: tagTRACKMOUSEEVENT;
  begin
    EventTrack.cbSize := SizeOf(EventTrack);
    EventTrack.hwndTrack := Handle;
    EventTrack.dwFlags := TME_LEAVE;
    EventTrack.dwHoverTime := HOVER_DEFAULT;
    TrackMouseEvent(EventTrack);
  end;

var
  Control: IControl;
begin
  if not FMouseEntered  then
  begin
    FMouseEntered := True;
    DoMouseEnter;
  end;

  StartTrackMouseLeave;

  if Supports(FSwitchObject, IControl, Control) then
    Control.MouseMove(KeysToShiftState(Message.Keys), Message.XPos, Message.YPos);
end;

initialization
  TPresentationProxyFactory.Current.Register(TSwitch, TControlType.Platform, TWinPresentationProxy<TWinSwitch>);
finalization
  TPresentationProxyFactory.Current.Unregister(TSwitch, TControlType.Platform, TWinPresentationProxy<TWinSwitch>);
end.

