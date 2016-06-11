{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Switch.Style;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.UITypes, FMX.Controls, FMX.StdCtrls, FMX.Presentation.Style, FMX.Presentation.Messages,
  FMX.Controls.Presentation, FMX.Styles.Switch;

type

{ TStyledSwitch }

  /// <summary>A styled presentation of TSwitch.</summary>
  TStyledSwitch = class(TStyledPresentation)
  private
    FSwitchObject: TCustomSwitchObject;
    procedure SwitchObjectChanged(Sender: TObject);
    function GetModel: TSwitchModel;
  protected
    { Messages From Model}
    /// <summary>Notification about changing Value of <c>TSwitch</c></summary>
    procedure MMValueChanged(var AMessage: TDispatchMessageWithValue<Boolean>); message MM_VALUE_CHANGED;
    { Messages From Controller }
    /// <summary>Notification about initialization of current presentation</summary>
    procedure PMInit(var AMessage: TDispatchMessage); message PM_INIT;
  protected
    { Styles }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    { Mouse Events }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
    /// <summary>Changes value of <c>TSwitchModel.Value</c></summary>
    procedure DoSwitch; virtual;
    /// <summary>Access to switch style object. Can be nil, if current style doesn't have it.</summary>
    property SwitchObject: TCustomSwitchObject read FSwitchObject;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>Model of <c>TSwitch</c></summary>
    property Model: TSwitchModel read GetModel;
  end;

implementation

uses
  System.SysUtils, FMX.Presentation.Factory, FMX.Types, FMX.Consts;

{ TStyledSwitch }

procedure TStyledSwitch.ApplyStyle;
begin
  inherited;
  if ResourceLink is TCustomSwitchObject then
  begin
    FSwitchObject := TCustomSwitchObject(ResourceLink);
    FSwitchObject.Value := Model.Value;
    FSwitchObject.Control := Self;
    FSwitchObject.OnChange := SwitchObjectChanged;
  end;
end;

constructor TStyledSwitch.Create(AOwner: TComponent);
begin
  inherited;
  AutoCapture := True;
  CanFocus := True;
end;

procedure TStyledSwitch.DoSwitch;
begin
  Model.DisableNotify;
  try
    if FSwitchObject <> nil then
      Model.Value := FSwitchObject.Value;
    Model.Change;
  finally
    Model.EnableNotify;
  end;
end;

procedure TStyledSwitch.FreeStyle;
begin
  inherited;
  if FSwitchObject <> nil then
  begin
    FSwitchObject.Control := nil;
    FSwitchObject.OnChange := nil;
    FSwitchObject := nil;
  end;
end;

function TStyledSwitch.GetModel: TSwitchModel;
begin
  Result := inherited GetModel<TSwitchModel>;
end;

procedure TStyledSwitch.MMValueChanged(var AMessage: TDispatchMessageWithValue<Boolean>);
begin
  if FSwitchObject <> nil then
    FSwitchObject.Value := AMessage.Value
  else
    SwitchObjectChanged(Self);
end;

procedure TStyledSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Control: IControl;
begin
  inherited;
  if Supports(FSwitchObject, IControl, Control) then
    Control.MouseDown(Button, Shift, X, Y);
end;

procedure TStyledSwitch.DoMouseEnter;
var
  Control: IControl;
begin
  inherited;
  if Supports(FSwitchObject, IControl, Control) then
    Control.DoMouseEnter;
end;

procedure TStyledSwitch.DoMouseLeave;
var
  Control: IControl;
begin
  inherited;
  if Supports(FSwitchObject, IControl, Control) then
    Control.DoMouseLeave;
end;

procedure TStyledSwitch.MouseMove(Shift: TShiftState; X, Y: Single);
var
  Control: IControl;
begin
  inherited;
  if Supports(FSwitchObject, IControl, Control) then
    Control.MouseMove(Shift, X, Y);
end;

procedure TStyledSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Control: IControl;
begin
  inherited;
  if Supports(FSwitchObject, IControl, Control) then
    Control.MouseUp(Button, Shift, X, Y);
end;

procedure TStyledSwitch.PMInit(var AMessage: TDispatchMessage);
begin
  if FSwitchObject <> nil then
    FSwitchObject.Value := Model.Value;
end;

procedure TStyledSwitch.SwitchObjectChanged(Sender: TObject);
begin
  DoSwitch;
end;

initialization
  TPresentationProxyFactory.Current.Register(TSwitch, TControlType.Styled, TStyledPresentationProxy<TStyledSwitch>);
finalization
  TPresentationProxyFactory.Current.Unregister(TSwitch, TControlType.Styled, TStyledPresentationProxy<TStyledSwitch>);
end.
