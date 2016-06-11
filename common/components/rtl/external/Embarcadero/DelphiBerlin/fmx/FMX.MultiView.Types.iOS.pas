{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiView.Types.iOS;

interface

uses
  System.TypInfo, System.UITypes, System.Types, iOSapi.Foundation, iOSApi.CoreGraphics, iOSApi.UIKit,
  FMX.Controls.Presentation, FMX.Presentation.iOS, FMX.Presentation.Messages, FMX.MultiView.Types, FMX.Controls.Model;

type

{ TiOSOverlayLayout }

  IFMXOverlayLayout = interface(UIView)
  ['{AE38D2FD-F601-40B5-9B72-47AAF640FB8B}']
    { Touches }
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    function pointInside(point: CGPoint; withEvent: UIEvent): Boolean; cdecl;
  end;

  /// <summary>Native presentation for <c>TOverlayLayout</c></summary>
  TiOSOverlayLayout = class(TiOSNativeView)
  private
    function GetModel: TCustomOverlayLayoutModel;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function DefineModelClass: TDataModelClass; override;
  protected
    { Messages From Controller }
    procedure PMGetRecommendSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_GET_RECOMMEND_SIZE;
  public
    function pointInside(point: CGPoint; withEvent: UIEvent): Boolean; override; cdecl;
  public
    property Model: TCustomOverlayLayoutModel read GetModel;
  end;

{ TiOSShadowedLayout }

  IFMXShadowedLayout = interface(UIView)
  ['{50546536-EE2A-42C5-9852-0A9483ADA45C}']
    { Touches }
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    function pointInside(point: CGPoint; withEvent: UIEvent): Boolean; cdecl;
  end;

  /// <summary>Native presentation for <c>TShadowedOverlayLayout</c></summary>
  TiOSShadowedLayout = class(TiOSOverlayLayout)
  private
    FShadowView: UIView;
    procedure UpdateShadowColor;
    function GetModel: TCustomShadowedOverlayLayoutModel;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function DefineModelClass: TDataModelClass; override;
  protected
    { Messages from Model }
    procedure MMColorChanged(var AMessage: TDispatchMessageWithValue<TAlphaColor>); message MM_COLOR_CHANGED;
    procedure MMEnabledShadowChanged(var AMessage: TDispatchMessageWithValue<Boolean>); message MM_ENABLED_SHADOW_CHANGED;
    { Messages From Controller }
    procedure PMSetAlpha(var AMessage: TDispatchMessageWithValue<Single>); message PM_SET_ABSOLUTE_OPACITY;
    procedure PMInit(var AMessage: TDispatchMessage); message PM_INIT;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Model: TCustomShadowedOverlayLayoutModel read GetModel;
    property ShadowView: UIView read FShadowView write FShadowView;
  end;

implementation

uses
  System.SysUtils, Macapi.ObjCRuntime, FMX.Types, FMX.Controls, FMX.Presentation.Factory, FMX.Helpers.iOS, FMX.Consts;

{ TiOSShadowedOverlayLayout }

constructor TiOSShadowedLayout.Create;
begin
  inherited;
  FShadowView := TUIView.Create;
  FShadowView.setFrame(CGRectMake(0, 0, View.frame.size.width, View.frame.size.height));
  FShadowView.setUserInteractionEnabled(False);
  FShadowView.setAutoresizingMask(UIViewAutoresizingFlexibleWidth or UIViewAutoresizingFlexibleHeight);
  View.addSubview(FShadowView);
  View.setExclusiveTouch(False);
end;

function TiOSShadowedLayout.DefineModelClass: TDataModelClass;
begin
  Result := TCustomShadowedOverlayLayoutModel;
end;

destructor TiOSShadowedLayout.Destroy;
begin
  FShadowView.removeFromSuperView;
  FShadowView.release;
  inherited;
end;

function TiOSShadowedLayout.GetModel: TCustomShadowedOverlayLayoutModel;
begin
  Result := inherited Model as TCustomShadowedOverlayLayoutModel;
end;

function TiOSShadowedLayout.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IFMXShadowedLayout);
end;

procedure TiOSShadowedLayout.PMInit(var AMessage: TDispatchMessage);
begin
  inherited;
  UpdateShadowColor;
end;

procedure TiOSShadowedLayout.PMSetAlpha(var AMessage: TDispatchMessageWithValue<Single>);
begin
  ShadowView.setAlpha(Control.AbsoluteOpacity);
end;

procedure TiOSShadowedLayout.UpdateShadowColor;
begin
  if Model.EnabledShadow then
    ShadowView.setBackgroundColor(AlphaColorToUIColor(Model.ShadowColor))
  else
    ShadowView.setBackgroundColor(nil);
end;

procedure TiOSShadowedLayout.MMColorChanged(var AMessage: TDispatchMessageWithValue<TAlphaColor>);
begin
  UpdateShadowColor;
end;

procedure TiOSShadowedLayout.MMEnabledShadowChanged(var AMessage: TDispatchMessageWithValue<Boolean>);
begin
  UpdateShadowColor;
end;

{ TiOSOverlayLayout }

function TiOSOverlayLayout.DefineModelClass: TDataModelClass;
begin
  Result := TCustomOverlayLayoutModel;
end;

function TiOSOverlayLayout.GetModel: TCustomOverlayLayoutModel;
begin
  Result := inherited GetModel<TCustomOverlayLayoutModel>;
end;

function TiOSOverlayLayout.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IFMXOverlayLayout);
end;

procedure TiOSOverlayLayout.PMGetRecommendSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
end;

function TiOSOverlayLayout.pointInside(point: CGPoint; withEvent: UIEvent): Boolean;
begin
  Result := True;
  if Assigned(Model.OnPointInObjectEvent) then
    Result := Model.OnPointInObjectEvent(Control, point.X, point.Y);

  case Model.Mode of
    TOverlayMode.LeftSide:
      Result := Result and (point.X <= Model.InterceptionSize);
    TOverlayMode.RightSide:
      Result := Result and (Size.Width - Model.InterceptionSize <= point.X);
    TOverlayMode.TopSide:
      Result := Result and (point.Y <= Model.InterceptionSize);
    TOverlayMode.BottomSide:
      Result := Result and (Size.Height - Model.InterceptionSize <= point.Y);
  end;
end;

initialization
  TPresentationProxyFactory.Current.Register(TOverlayLayout, TControlType.Platform, TiOSPresentationProxy<TiOSOverlayLayout>);
  TPresentationProxyFactory.Current.Register(TShadowedOverlayLayout, TControlType.Platform, TiOSPresentationProxy<TiOSShadowedLayout>);
finalization
  TPresentationProxyFactory.Current.Unregister(TOverlayLayout, TControlType.Platform, TiOSPresentationProxy<TiOSOverlayLayout>);
  TPresentationProxyFactory.Current.Unregister(TShadowedOverlayLayout, TControlType.Platform, TiOSPresentationProxy<TiOSShadowedLayout>);
end.
