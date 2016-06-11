{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiView.Types.Style;

interface

uses
  System.UITypes, System.Classes, FMX.Types, FMX.Graphics, FMX.Controls.Model, FMX.Controls.Presentation,
  FMX.Presentation.Style, FMX.Presentation.Messages, FMX.MultiView.Types, FMX.Objects;

type

{ TStyledOverlayLayout }

  /// <summary>Styled presentation for <c>TCustomOverlayLayout</c></summary>
  TStyledOverlayLayout = class(TStyledPresentation)
  private
    function GetModel: TCustomOverlayLayoutModel;
  public
    function PointInObjectLocal(X, Y: Single): Boolean; override;
    /// <summary>Returns model of <c>TCustomOverlayLayout</c></summary>
    property Model: TCustomOverlayLayoutModel read GetModel;
  end;

{ TStyledShadowedLayout }

  /// <summary>Styled presentation for <c>TShadowedOverlayLayout</c> (presentation)</summary>
  TStyledShadowedLayout = class(TStyledOverlayLayout)
  private
    FShadow: TRectangle;
    function GetModel: TCustomShadowedOverlayLayoutModel;
  protected
    { Messages from Model }
    /// <summary>Notification about changing <c>TShadowedOverlayLayout.Color</c> of shadow</summary>
    procedure MMColorChanged(var AMessage: TDispatchMessageWithValue<TAlphaColor>); message MM_COLOR_CHANGED;
    /// <summary>Notification about changing <c>TShadowedOverlayLayout.EnabledShadow</c></summary>
    procedure MMEnabledShadowChanged(var AMessage: TDispatchMessageWithValue<Boolean>); message MM_ENABLED_SHADOW_CHANGED;
    { Messages From Controller }
    /// <summary>Notification about initialization of presentation</summary>
    procedure PMInit(var AMessage: TDispatchMessage); message PM_INIT;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>Returns model of <c>TShadowedOverlayLayout</c></summary>
    property Model: TCustomShadowedOverlayLayoutModel read GetModel;
  end;

implementation

uses
  FMX.Presentation.Factory, FMX.Controls;

{ TStyledShadowedLayout }

constructor TStyledShadowedLayout.Create(AOwner: TComponent);
begin
  inherited;
  FShadow := TRectangle.Create(nil);
  FShadow.Parent := Self;
  FShadow.Stored := False;
  FShadow.Align := TAlignLayout.Contents;
  FShadow.HitTest := False;
  FShadow.Stroke.Kind := TBrushKind.None;
  FShadow.Lock;
  FDesignSelectionMarks := False;
end;

function TStyledShadowedLayout.GetModel: TCustomShadowedOverlayLayoutModel;
begin
  Result := inherited Model as TCustomShadowedOverlayLayoutModel;
end;

procedure TStyledShadowedLayout.MMColorChanged(var AMessage: TDispatchMessageWithValue<TAlphaColor>);
begin
  FShadow.Fill.Color := AMessage.Value;
end;

procedure TStyledShadowedLayout.MMEnabledShadowChanged(var AMessage: TDispatchMessageWithValue<Boolean>);
begin
  FShadow.Visible := AMessage.Value;
end;

procedure TStyledShadowedLayout.PMInit(var AMessage: TDispatchMessage);
begin
  FShadow.Fill.Color := Model.ShadowColor;
  FShadow.Visible := Model.EnabledShadow;
end;

{ TStyledOverlayLayout }

function TStyledOverlayLayout.GetModel: TCustomOverlayLayoutModel;
begin
  Result := inherited GetModel<TCustomOverlayLayoutModel>;
end;

function TStyledOverlayLayout.PointInObjectLocal(X, Y: Single): Boolean;
begin
  Result := inherited;
  if Assigned(Model.OnPointInObjectEvent) then
    Result := Result and Model.OnPointInObjectEvent(PresentedControl, X, Y);
  case Model.Mode of
    TOverlayMode.LeftSide:
      Result := Result and (X <= Model.InterceptionSize);
    TOverlayMode.RightSide:
      Result := Result and (Width - Model.InterceptionSize <= X);
    TOverlayMode.TopSide:
      Result := Result and (Y <= Model.InterceptionSize);
    TOverlayMode.BottomSide:
      Result := Result and (Height - Model.InterceptionSize <= Y);
  end;
end;

initialization
  TPresentationProxyFactory.Current.Register(TOverlayLayout, TControlType.Styled, TStyledPresentationProxy<TStyledOverlayLayout>);
  TPresentationProxyFactory.Current.Register(TShadowedOverlayLayout, TControlType.Styled, TStyledPresentationProxy<TStyledShadowedLayout>);
finalization
  TPresentationProxyFactory.Current.Unregister(TOverlayLayout, TControlType.Styled, TStyledPresentationProxy<TStyledOverlayLayout>);
  TPresentationProxyFactory.Current.Unregister(TShadowedOverlayLayout, TControlType.Styled, TStyledPresentationProxy<TStyledShadowedLayout>);
end.
