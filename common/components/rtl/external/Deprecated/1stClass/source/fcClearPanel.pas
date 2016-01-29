unit fcClearPanel;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommCtrl, StdCtrls, Buttons, ExtCtrls, fcCommon;

type
  TfcCustomTransparentPanel = class(TCustomPanel)
  private
    procedure WMEraseBkGnd(var Message:TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMMove(var Message: TWMMove); Message WM_Move;
  protected
    // Property Storage Variables
    FTransparent: Boolean;
    FInEraseBkGnd: Boolean;

    procedure ClipChildren(Value: Boolean);

    // Property Access Methods
    procedure SetTransparent(Value: Boolean); virtual;

    // Overridden methods
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Paint; override;
    procedure SetParent(AParent:TWinControl); override;
    function IsTransparent: boolean; virtual;
  public
    BasePatch: Variant;
    constructor Create(AOwner: TComponent); override;
    procedure Invalidate; override;

    property Transparent: Boolean read FTransparent write SetTransparent;
  end;

  TfcTransparentPanel = class(TfcCustomTransparentPanel)
  published
    property Align;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Transparent;
  end;

//  procedure Register;

implementation
{
constructor TfcCustomTransparentPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls];
end;

procedure TfcCustomTransparentPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  if AControl is TGraphicControl then Invalidate;
end;

procedure TfcCustomTransparentPanel.Paint;
var i: Integer;
begin
  SetWindowLong(Parent.Handle, GWL_STYLE,
    GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);

  for i := 0 to ControlCount - 1 do
    if Controls[i] is TWinControl then
      InvalidateRect((Controls[i] as TWinControl).Handle, nil, False);
end;

procedure TfcCustomTransparentPanel.WMEraseBkgnd(var Message: TWMEraseBkGnd);
var DC: HDC;
    r: TRect;
    Rgn, TmpRgn: HRGN;
begin
  if FInEraseBkGnd then Exit;
  FInEraseBkGnd := True;
  Message.result := 1;

{  if Parent <> nil then
  begin
    Rgn := CreateRectRgn(0, 0, Width, Height);
    TmpRgn := fcGetChildRegions(self);
    CombineRgn(Rgn, Rgn, TmpRgn, RGN_DIFF);
    DeleteObject(TmpRgn);
    OffsetRgn(Rgn, Left, Top);

    InvalidateRgn(Parent.Handle, Rgn, False);
    Parent.Update;

    DeleteObject(Rgn);

    DC := GetDC(Parent.Handle);
    BitBlt(Message.DC, 0, 0, Width, Height, DC, Left, Top, SRCCOPY);
    ReleaseDC(Parent.Handle, DC);
  end;
  FInEraseBkGnd := False;
end;

}constructor TfcCustomTransparentPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque, csSetCaption];

  FTransparent := True;
  BevelOuter := bvRaised;
end;

procedure TfcCustomTransparentPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if IsTransparent then Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TfcCustomTransparentPanel.CreateWnd;
begin
  inherited;
end;

procedure TfcCustomTransparentPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TfcCustomTransparentPanel.Paint;
var
  ARect: TRect;
  TopColor, BottomColor: TColor;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin
  if IsTransparent then
  begin
    ARect := GetClientRect;

    // For BevelOuter property
    if BevelOuter <> bvNone then
    begin
      AdjustColors(BevelOuter);
      Frame3D(Canvas, ARect, TopColor, BottomColor, BevelWidth);
    end;

    // For BorderWidth property
    Frame3D(Canvas, ARect, Color, Color, BorderWidth);

    // For BevelInner Property
    if BevelInner <> bvNone then
    begin
      AdjustColors(BevelInner);
      Frame3D(Canvas, ARect, TopColor, BottomColor, BevelWidth);
    end;
    Update;
  end else inherited;
end;

procedure TfcCustomTransparentPanel.WMEraseBkGnd(var Message: TWMEraseBkGnd);
//var r: TRect;
begin
//  inherited;
  if IsTransparent then Message.Result := 1;
{  if not InEraseBK and (csDesigning in ComponentState) and FTransparent then
  begin
    InEraseBK := True;
    r := Rect(Left, Top, Left + Width, Top + Height);
    InvalidateRect(Parent.Handle, @r, True);
    Parent.Update;
    Invalidate;
    Update;
//    InEraseBK := False;
  end;}
end;

procedure TfcCustomTransparentPanel.WMMove(var Message: TWMMove);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TfcCustomTransparentPanel.ClipChildren(Value: Boolean);
begin
  if (Parent <> nil) then
  begin
    if Value then
      SetWindowLong(Parent.Handle, GWL_STYLE,
        GetWindowLong(Parent.Handle, GWL_STYLE) or WS_CLIPCHILDREN)
    else
      SetWindowLong(Parent.Handle, GWL_STYLE,
        GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
    end;
end;

procedure TfcCustomTransparentPanel.SetParent(AParent:TWinControl);
begin
  inherited SetParent(AParent);

  // Without this, the panel would be transparent indeed, but you would see through the form into the background apps
//  ClipChildren(not FTransparent);
end;

procedure TfcCustomTransparentPanel.Invalidate;
var Rect :TRect;
    i: Integer;
begin
  if IsTransparent and (Parent <> nil) and Parent.HandleAllocated then
  begin
    Rect:= BoundsRect;
    InvalidateRect(Parent.Handle, @Rect, True);
//    Parent.Update; { 8/5/99 - RSW - Calling this causes problem with TImage or TfcImager not being painted }
                     { This happened when you enter page/down in a scrollable region }
    for i := 0 to ControlCount - 1 do Controls[i].Invalidate;
  end
  else inherited Invalidate;
end;

procedure TfcCustomTransparentPanel.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    if not (csLoading in ComponentState) and HandleAllocated then { 4/30/99 }
      Invalidate;
//    ClipChildren(not Value);
//    RecreateWnd;
  end;
end;

Function TfcCustomTransparentPanel.IsTransparent: boolean;
begin
   result:= FTransparent;
end;

{procedure Register;
begin
  RegisterComponents('1stClass', [TfcTransparentPanel]);
end;
}
end.
