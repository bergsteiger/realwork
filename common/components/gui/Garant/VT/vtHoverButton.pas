unit vtHoverButton;

interface
uses
  Windows, Controls, Classes, Messages, ImgList;

type

  TvtHoverButtonState = (hbsNormal, hbsHovered, hbsPressed);

  TvtHoverButton = class(TGraphicControl)
  private
    FState: TvtHoverButtonState;
    FAutoSize: Boolean;
    FImageList: TCustomImageList;
    FNormalImageIndex: Integer;
    FHoveredImageIndex: Integer;
    FPressedImageIndex: Integer;
    FOnClick: TNotifyEvent;
    procedure pm_SetAutoSize(AValue: Boolean);
    procedure SetState(AState: TvtHoverButtonState);
    procedure AdjustSize;
    function GetStateImageIndex: Integer;
    function NeedPaintImageByIndex: Boolean;
    procedure pm_SetHoveredImageIndex(AValue: Integer);
    procedure pm_SetNormalImageIndex(AValue: Integer);
    procedure pm_SetPressedImageIndex(AValue: Integer);
    procedure pm_SetImageList(AValue: TCustomImageList);
  protected
    procedure Paint; override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
  published
    property AutoSize: Boolean read FAutoSize write pm_SetAutoSize;
    property ImageList: TCustomImageList read FImageList write pm_SetImageList;
    property NormalImageIndex: Integer read FNormalImageIndex write pm_SetNormalImageIndex default -1;
    property HoveredImageIndex: Integer read FHoveredImageIndex write pm_SetHoveredImageIndex default -1;
    property PressedImageIndex: Integer read FPressedImageIndex write pm_SetPressedImageIndex default -1;
    property OnClick read FOnClick write FOnClick;
  end;

implementation
uses
  SysUtils, Graphics;

{ TvtHoverPngButton }

procedure TvtHoverButton.CMMouseEnter(var Message: TMessage);
begin
 inherited;
 SetState(hbsHovered);
end;

procedure TvtHoverButton.CMMouseLeave(var Message: TMessage);
begin
 inherited;
 SetState(hbsNormal);
end;

procedure TvtHoverButton.WMLButtonDown(var Message: TWMLButtonDown);
begin
 if (FState in [hbsNormal, hbsHovered]) then
   SetState(hbsPressed);
 inherited;
end;


procedure TvtHoverButton.WMLButtonUp(var Message: TWMLButtonUp);
begin
 if Assigned(FOnClick) then
  FOnClick(Self);
 if (FState = hbsPressed) then
   SetState(hbsNormal);
end;

function TvtHoverButton.GetStateImageIndex: Integer;
begin
 case FState of
  hbsNormal:
   Result := FNormalImageIndex;
  hbsHovered:
   begin
    if (FHoveredImageIndex <> -1) then
     Result := FHoveredImageIndex
    else
     Result := FNormalImageIndex;
   end;//hbsHovered
  hbsPressed:
   begin
    if (FPressedImageIndex <> -1) then
     Result := FPressedImageIndex
    else
     Result := FHoveredImageIndex;
   end;//hbsPressed
 end;//case FState
end;

function TvtHoverButton.NeedPaintImageByIndex: Boolean;
begin
 Result := (FImageList <> nil) and (GetStateImageIndex <> -1);
end;

procedure TvtHoverButton.Paint;
begin
 if NeedPaintImageByIndex then
  FImageList.Draw(Canvas, 0, 0, GetStateImageIndex);
end;

procedure TvtHoverButton.SetState(AState: TvtHoverButtonState);
begin
 if (AState <> FState) then
 begin
  FState := AState;
  Invalidate;
 end;
end;

procedure TvtHoverButton.pm_SetAutoSize(AValue: Boolean);
begin
 if (AValue <> FAutoSize) then
 begin
  FAutoSize := AValue;
  AdjustSize;
 end;
end;

procedure TvtHoverButton.AdjustSize;
begin
 if (FNormalImageIndex <> -1) and (FImageList <> nil) then
 begin
  Height := FImageList.Height;
  Width := FImageList.Width;
 end;
end;

procedure TvtHoverButton.pm_SetHoveredImageIndex(AValue: Integer);
begin
 if (AValue <> FHoveredImageIndex) then
 begin
  FHoveredImageIndex := AValue;
  if (FState = hbsHovered) then
   Invalidate;
 end;
end;

procedure TvtHoverButton.pm_SetNormalImageIndex(AValue: Integer);
begin
 if (AValue <> FNormalImageIndex) then
 begin
  FNormalImageIndex := AValue;
  if (FState = hbsNormal) then
   Invalidate;
 end;
end;

procedure TvtHoverButton.pm_SetPressedImageIndex(AValue: Integer);
begin
 if (AValue <> FPressedImageIndex) then
 begin
  FPressedImageIndex := AValue;
  if (FState = hbsPressed) then
   Invalidate;
 end;
end;

procedure TvtHoverButton.pm_SetImageList(AValue: TCustomImageList);
begin
 if (AValue <> FImageList) then
 begin
  FImageList := AValue;
  if FAutoSize then
   AdjustSize
  else
   Invalidate;
 end;
end;

end.
