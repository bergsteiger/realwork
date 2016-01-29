{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.XPActnCtrls;

interface

uses Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.Buttons, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnMenus, Vcl.ActnCtrls, Vcl.ActnColorMaps, Vcl.ShadowWnd;

type

{ TXPStyleMenuItem }

  TXPStyleMenuItem = class(TCustomMenuItem)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawSeparator(const Offset: Integer); override;
    procedure DrawSubMenuGlyph; override;
    procedure DrawText(var Rect: TRect; var Flags: Cardinal; Text: String); override;
    procedure DrawUnusedEdges; override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: String;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure CalcLayout; override;
  public
    procedure CalcBounds; override;
  end;

{ TXPStyleMenuButton }

  TXPStyleMenuButton = class(TCustomMenuButton)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal;
      Text: String); override;
  end;

{ TXPStylePopupMenu }

  TXPStylePopupMenu = class(TCustomActionPopupMenu)
  private
    FBtnShadow: TShadowWindow;
  protected
    function GetExpandBtnClass: TCustomMenuExpandBtnClass; override;
    procedure NCPaint(DC: HDC); override;
    procedure PositionPopup(AnOwner: TCustomActionBar;
      ParentItem: TCustomActionControl); override;
    procedure VisibleChanging; override;
    procedure DisplayShadow; override;
    procedure HideShadow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TXPStyleExpandBtn }

  TXPStyleExpandBtn = class(TCustomMenuExpandBtn)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawFrame(ARect: TRect; Down: Boolean); override;
  end;

{ TXPStyleButton }

  TXPStyleButton = class(TCustomButtonControl)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawFrame(ARect: TRect; Down: Boolean); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal;
      Text: String); override;
  end;

{ TXPStyleDropDownBtn }

  TXPStyleDropDownBtn = class(TCustomDropDownButton)
  protected
    procedure DrawFrame(ARect: TRect; Down: Boolean); override;
    procedure DrawBackground(var PaintRect: TRect); override;
    function GetPopupClass: TCustomActionBarClass; override;
    procedure DrawGlyph(const Location: TPoint); override;
  end;

{ TXPStyleCustomizePopup }

  TXPStyleCustomizePopup = class(TCustomizeActionToolBar)
  protected
    procedure NCPaint(DC: HDC); override;
    function GetAddRemoveItemClass: TCustomAddRemoveItemClass; override;
    function GetDefaultColorMapClass: TCustomColorMapClass; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TXPStyleToolScrollBtn }

  TXPStyleToolScrollBtn = class(TCustomToolScrollBtn)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
  end;

{ TXPStyleAddRemoveItem }

  TXPStyleAddRemoveItem = class(TCustomAddRemoveItem)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawSeparator(const Offset: Integer); override;
    procedure DrawText(var Rect: TRect; var Flags: Cardinal; Text: String); override;
    procedure DrawUnusedEdges; override;
  public
    procedure CalcBounds; override;
  end;

implementation

uses
  System.SysUtils, System.Types, System.UITypes, System.Contnrs, Vcl.Forms, Vcl.ActnList, Vcl.GraphUtil, Vcl.ListActns,
  Vcl.ImgList;

function IsMouseButtonPressed: Boolean;
begin
  Result := not (((GetAsyncKeyState(VK_RBUTTON)and $8000)=0) and
            ((GetAsyncKeyState(VK_LBUTTON)and $8000)=0));
end;

{ TXPStyleMenuItem }

procedure TXPStyleMenuItem.CalcBounds;
var
  NewTextPos: TRect;
begin
  inherited;
  if Separator then
    Height := 3
  else
    Height := Height + 2;
  if not HasGlyph then
  begin
    NewTextPos := TextBounds;
    NewTextPos.Top := NewTextPos.Top + 1;
    TextBounds := NewTextPos;
  end;
end;

procedure TXPStyleMenuItem.CalcLayout;
begin
  inherited;
  GlyphPos := Point(GlyphPos.X, GlyphPos.Y + 1);
end;

procedure TXPStyleMenuItem.DrawBackground(var PaintRect: TRect);
var
  BannerRect: TRect;
  BGRect: TRect;
begin
  if (ActionClient = nil) then exit;

  if ActionClient.Color <> clDefault then
    Canvas.Brush.Color := ActionClient.Color;

  BGRect := PaintRect;
  if TextBounds.Left > GlyphPos.X then
    BGRect.Left := 0;
  BannerRect := PaintRect;
  if TextBounds.Left > GlyphPos.X then
    BannerRect.Right := TextBounds.Left - 3
  else
    BannerRect.Right := TextBounds.Right + 3;
  BannerRect.Right := 25;
  BGRect.Left := BannerRect.Right - BannerRect.Left;
  if ActionClient.Unused then
    Canvas.Brush.Color := ActionBar.ColorMap.UnusedColor
  else
    Canvas.Brush.Color := ActionBar.ColorMap.Color;
  Canvas.FillRect(BannerRect);
  Canvas.Brush.Color := Menu.ColorMap.MenuColor;

  if (Selected and Enabled) or (Selected and not MouseSelected) then
  begin
    if Enabled and not ActionBar.DesignMode then
      if not Separator or (Separator and ActionBar.DesignMode) then
        Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
    Dec(PaintRect.Right, 1);
  end;
  inherited DrawBackground(BGRect);
  if (not ActionBar.DesignMode and Separator) then exit;
  if not Mouse.IsDragging and ((Selected and Enabled) or
     (Selected and not MouseSelected)) then
  begin
    Canvas.FillRect(PaintRect);
    Canvas.Brush.Color := ActionBar.ColorMap.BtnFrameColor;
    Inc(PaintRect.Right);
    Canvas.FrameRect(PaintRect);
  end;
end;

procedure TXPStyleMenuItem.DrawGlyph(const Location: TPoint);
var
  OldColor, OldBrushColor: TColor;
  NewLocation: TPoint;
  FrameRect: TRect;
  SelBmp: TBitmap;
  ImageList: TCustomImageList;
begin
  if (Assigned(ActionClient) and not ActionClient.HasGlyph) and
     ((Action is TCustomAction) and TCustomAction(Action).Checked) then
  begin
    if IsChecked then
    begin
      FrameRect := System.Types.Rect(Location.X - 1, 1,
        Location.X + 20, Self.Height - 1);
      Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
      Canvas.FillRect(FrameRect);
      Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
      Canvas.Rectangle(FrameRect);
    end;
    Canvas.Pen.Color := ActionBar.ColorMap.FontColor;
    with Location do
      DrawCheck(Canvas, Point(X + 6, Y + 3), 2)
  end
  else
  begin
    if IsChecked then
    begin
      FrameRect := System.Types.Rect(Location.X - 1, 1,
        Location.X + 20, Self.Height - 1);
      Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
      Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
      Canvas.Rectangle(FrameRect);
    end;
    OldColor := Canvas.Brush.Color;
    if (Selected and Enabled) or (Selected and not MouseSelected) then
      Canvas.Brush.Color := Menu.ColorMap.SelectedColor
    else
      Canvas.Brush.Color := Menu.ColorMap.ShadowColor;
    NewLocation := Location;

    if (Selected and Enabled and ActionClient.HasGlyph) then
    begin
      OldBrushColor := Canvas.Brush.Color;
      SelBmp := TBitmap.Create;
      try
        ImageList := FindImageList(False, ActionClient.ImageIndex);
        if Assigned(ImageList) then
        begin
          Canvas.Brush.Color := GetShadowColor(Menu.ColorMap.SelectedColor);
          SelBmp.Width := ImageList.Width;
          SelBmp.Height := ImageList.Width;

          SelBmp.Canvas.FillRect(SelBmp.Canvas.ClipRect);

          if ImageList.ColorDepth = cdDeviceDependent then
            ImageList.Draw(SelBmp.Canvas, 0, 0, ActionClient.ImageIndex, dsNormal, itMask)
          else
            ImageList.Draw( SelBmp.Canvas, 0, 0, ActionClient.ImageIndex);


          DrawState(Canvas.Handle, Canvas.Brush.Handle, nil, LPARAM(SelBmp.Handle), 0,
            NewLocation.X + 3, NewLocation.Y + 2, 0, 0, DST_BITMAP or DSS_MONO);
        end;
      finally
        SelBmp.Free;
        Canvas.Brush.Color := OldBrushColor;
      end;

      Inc(NewLocation.X, 1);
      inherited DrawGlyph(NewLocation);
    end
    else begin
      Inc(NewLocation.X, 2);
      Inc(NewLocation.Y, 1);
      inherited DrawGlyph(NewLocation);
    end;
    Canvas.Brush.Color := OldColor;
  end;
end;

procedure TXPStyleMenuItem.DrawSeparator(const Offset: Integer);
var
  PaintRect: TRect;
  PR: TPenRecall;
  BR: TBrushRecall;
begin
  BR := TBrushRecall.Create(Canvas.Brush);
  PR := TPenRecall.Create(Canvas.Pen);
  try
    if Assigned(ActionClient) and ActionClient.Unused and not Transparent then
      Canvas.Brush.Style := bsSolid
    else
    begin
      Canvas.Brush.Color := Menu.ColorMap.Color;
      PaintRect := BoundsRect;
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_LEFT);
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_RIGHT);
    end;
    Canvas.Pen.Color := Menu.ColorMap.DisabledFontColor;
    Canvas.MoveTo(32, ClientHeight div 2);
    Canvas.LineTo(ClientWidth, ClientHeight div 2);
  finally
    BR.Free;
    PR.Free;
  end;
end;

procedure TXPStyleMenuItem.DrawShadowedText(Rect: TRect; Flags: Cardinal;
  Text: String; TextColor, ShadowColor: TColor);
begin
  OffsetRect(Rect, 6, 0);
  inherited;
end;

procedure TXPStyleMenuItem.DrawSubMenuGlyph;
const
  ArrowPos = 11;
  ArrowColor: array[Boolean] of Integer = (clBtnText, clWhite);
begin
  inherited;
  with Canvas do
  begin
    Pen.Color := Menu.ColorMap.FontColor;
    Brush.Color := Pen.Color;
  end;
  DrawArrow(Canvas, sdRight, Point(Width - ArrowPos, Height div 2 - 3), 3);
end;

procedure TXPStyleMenuItem.DrawText(var Rect: TRect; var Flags: Cardinal;
  Text: String);
begin
  OffsetRect(Rect, 6, 0);
  inherited DrawText(Rect, Flags, Text);
end;

procedure TXPStyleMenuItem.DrawUnusedEdges;
begin
end;

{ TXPStyleButton }

procedure TXPStyleMenuButton.DrawBackground(var PaintRect: TRect);

  procedure DrawSelectedFrame;
  begin
    Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
    Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
    Canvas.Rectangle(0, 0, Width, Height);
    InflateRect(PaintRect, -1, -1);
  end;

var
  Offset: TPoint;
begin
  Canvas.Brush.Color := ActionBar.ColorMap.Color;
  if (ActionBar is TCustomActionMenuBar) and
    TCustomActionMenuBar(ActionBar).InMenuLoop then
  begin
    if Selected then
      if ActionClient.ChildActionBar = nil then
      begin
        if TCustomActionMenuBar(Menu.RootMenu).PopupStack.Count = 1 then
        begin
          DrawSelectedFrame;
          Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
        end;
      end
      else
      begin
        Canvas.Brush.Color := Menu.ColorMap.BtnSelectedColor;
        Canvas.Pen.Color := ActionBar.ColorMap.FrameTopLeftOuter;
        Canvas.Rectangle(0, 0, Width, Height);
        Offset := Parent.ClientToScreen(BoundsRect.TopLeft);
        if Offset.Y >= ActionClient.ChildActionBar.BoundsRect.Bottom then
          Offset.Y := 0
        else
          Offset.Y := Height - 1;
        Canvas.Pen.Color := ActionBar.ColorMap.BtnSelectedColor;
        Canvas.MoveTo(1, Offset.Y);
        Canvas.LineTo(Width - 1, Offset.Y);
        InflateRect(PaintRect, -1 , -1);
      end;
  end
  else if MouseInControl then
    DrawSelectedFrame;
  inherited DrawBackground(PaintRect);
end;

procedure TXPStyleMenuButton.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: String);
begin
  OffsetRect(ARect, 1, 0);
  inherited DrawText(ARect, Flags, Text);
end;

{ TXPStylePopupMenu }

constructor TXPStylePopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  VertMargin := 0;
end;

destructor TXPStylePopupMenu.Destroy;
begin
  FreeAndNil(FBtnShadow);
  inherited;
end;

procedure TXPStylePopupMenu.DisplayShadow;
begin
  inherited;
  if not Shadow or DesignMode then exit;
  if Assigned(ActionClient) and (ActionClient is TActionClientItem) and
    (TActionClientItem(ActionClient).Control is TCustomMenuButton) then
    if not Assigned(FBtnShadow) then
      FBtnShadow := TShadowWindow.CreateShadow(Self, csRight);
  if Assigned(FBtnShadow) then
    FBtnShadow.Control := TActionClientItem(ActionClient).Control;
end;

function TXPStylePopupMenu.GetExpandBtnClass: TCustomMenuExpandBtnClass;
begin
  Result := TXPStyleExpandBtn;
end;

procedure TXPStylePopupMenu.HideShadow;
begin
  inherited;
  if Assigned(FBtnShadow) then
    FBtnShadow.Hide;
end;

procedure TXPStylePopupMenu.NCPaint(DC: HDC);
var
  RC, RW: TRect;
  OldHandle: THandle;
  Offset: TPoint;
begin
  Winapi.Windows.GetClientRect(Handle, RC);
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  { Draw border in non-client area }
  OffsetRect(RW, -RW.Left, -RW.Top);
  OldHandle := Canvas.Handle;
  try
    Canvas.Handle := DC;
    Canvas.Pen.Width := 1;

    Canvas.Pen.Color := ColorMap.FrameTopLeftOuter;
    Canvas.MoveTo(RW.Right, RW.Top);
    Canvas.LineTo(RW.Left, Rw.Top);
    Canvas.LineTo(RW.Left, RW.Bottom);

    Canvas.Pen.Color := ColorMap.FrameTopLeftInner;
    Canvas.MoveTo(RW.Right - 1, RW.Top + 1);
    Canvas.LineTo(RW.Left + 1, Rw.Top + 1);
    Canvas.LineTo(RW.Left + 1, RW.Bottom - 2);

    Canvas.Pen.Color := ColorMap.FrameBottomRightOuter;
    Canvas.MoveTo(RW.Right - 1, RW.Top);
    Canvas.LineTo(RW.Right - 1, RW.Bottom - 1);
    Canvas.LineTo(RW.Left - 1, RW.Bottom - 1);

    Canvas.Pen.Color := ColorMap.FrameBottomRightInner;
    Canvas.MoveTo(RW.Right - 2, RW.Top + 1);
    Canvas.LineTo(RW.Right - 2, RW.Bottom - 2);
    Canvas.LineTo(RW.Left, RW.Bottom - 2);

    if Assigned(ActionClient) and (ColorMap.BtnSelectedColor <> ColorMap.FrameTopLeftOuter) and
       (ParentControl is TXPStyleMenuButton) then
    begin
      Offset := ParentControl.Parent.ClientToScreen(ParentControl.BoundsRect.TopLeft);
      if BoundsRect.Bottom <= Offset.Y then
        Offset.Y := RW.Bottom - 1
      else
        Offset.Y := 0;
      Canvas.MoveTo(Offset.X - Left + 1, Offset.Y);
      Canvas.Pen.Color := ColorMap.BtnSelectedColor;
      Canvas.LineTo(Offset.X - Left + ParentControl.Width - 1, Offset.Y);
    end;

  finally
    Canvas.Handle := OldHandle;
  end;
end;

procedure TXPStylePopupMenu.PositionPopup(AnOwner: TCustomActionBar;
  ParentItem: TCustomActionControl);
begin
  inherited PositionPopup(AnOwner, ParentItem);
  if (ParentItem is TCustomMenuItem) and (Left > ParentItem.Parent.BoundsRect.Left) then
    Left := ParentItem.Parent.BoundsRect.Right - 1
  else if ParentItem is TCustomMenuButton and (Left > ParentItem.BoundsRect.Left) then
    Left := Left - 1;
end;

procedure TXPStylePopupMenu.VisibleChanging;
begin
  if ParentControl is TCustomButtonControl then
    ParentControl.Invalidate;
  inherited;
end;

{ TXPStyleExpandBtn }

procedure TXPStyleExpandBtn.DrawBackground(var PaintRect: TRect);
var
  BannerRect: TRect;
begin
  Canvas.Brush.Color := Menu.ColorMap.MenuColor;
  Canvas.FillRect(PaintRect);
  BannerRect := PaintRect;
  BannerRect.Right := 24;
  Canvas.Brush.Color := Menu.ColorMap.BtnSelectedColor;
  Canvas.FillRect(BannerRect);
  if ((FState = bsDown) or not Flat or MouseInControl or IsChecked) then
  begin
    OffsetRect(PaintRect, 0, 1);
    InflateRect(PaintRect, -2, -4);
    Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
    Canvas.FillRect(PaintRect);
  end;
end;

procedure TXPStyleExpandBtn.DrawFrame(ARect: TRect; Down: Boolean);
begin
  if Enabled and ((FState = bsDown) or not Flat or MouseInControl or IsChecked) then
  begin
    OffsetRect(ARect, 0, 1);
    InflateRect(ARect, -2, -4);
    Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
    Canvas.Rectangle(ARect);
  end;
end;

{ TXPStyleButton }

procedure TXPStyleButton.DrawBackground(var PaintRect: TRect);
begin
  if Enabled and not (ActionBar.DesignMode) then
  begin
    if (MouseInControl or IsChecked) and
       (Assigned(ActionClient) and not ActionClient.Separator) then
      Canvas.Brush.Color := ActionBar.ColorMap.SelectedColor
    else
      Canvas.Brush.Color := ActionBar.ColorMap.Color;
  end
  else
    Canvas.Brush.Color := ActionBar.ColorMap.Color;
  inherited DrawBackground(PaintRect);
end;

procedure TXPStyleButton.DrawFrame(ARect: TRect; Down: Boolean);
begin
  if not ActionBar.DesignMode and Enabled and
     ((FState = bsDown) or not Flat or MouseInControl or IsChecked) then
  begin
    Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(ARect);
  end;
end;

procedure TXPStyleButton.DrawGlyph(const Location: TPoint);
var
  OldBrushColor: TColor;
  SelBmp: TBitmap;
  NewLocation: TPoint;
  ImageList: TCustomImageList;
begin
  NewLocation := Location;
  if not ActionBar.DesignMode and MouseInControl and
     not IsChecked and Enabled and ActionClient.HasGlyph then
  begin
    OldBrushColor := Canvas.Brush.Color;
    SelBmp := TBitmap.Create;
    try
      if ActionClient.Action <> nil then
      begin
        ImageList := FindImageList(False, ActionClient.ImageIndex);
        if Assigned(ImageList) and (ActionClient.ImageIndex > -1) and
           (ActionClient.ImageIndex < ImageList.Count) then
        begin
          Canvas.Brush.Color := GetShadowColor(ActionBar.ColorMap.SelectedColor);
          SelBmp.Width := ImageList.Width;
          SelBmp.Height := ImageList.Width;

          SelBmp.Canvas.FillRect(SelBmp.Canvas.ClipRect);

          if ImageList.ColorDepth = cdDeviceDependent then
            ImageList.Draw(SelBmp.Canvas, 0, 0, ActionClient.ImageIndex, dsNormal, itMask)
          else
            ImageList.Draw( SelBmp.Canvas, 0, 0, ActionClient.ImageIndex);

          DrawState(Canvas.Handle, Canvas.Brush.Handle, nil, LPARAM(SelBmp.Handle), 0,
            NewLocation.X + 1, NewLocation.Y + 1, 0, 0, DST_BITMAP or DSS_MONO);
        end;
      end;
    finally
      SelBmp.Free;
      Canvas.Brush.Color := OldBrushColor;
    end;
    if not IsChecked then
    begin
      Dec(NewLocation.X);
      Dec(NewLocation.Y);
    end;
  end;
  if not (csDesigning in ComponentState) and ((FState = bsDown) and not IsChecked)
     and IsMouseButtonPressed then
  begin
    Inc(NewLocation.X);
    Inc(NewLocation.Y);
  end;
  inherited DrawGlyph(NewLocation);
end;

procedure TXPStyleButton.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: String);
begin
  if MouseInControl and (ActionBar.ColorMap.HotFontColor <> clDefault) then
    Canvas.Font.Color := ActionBar.ColorMap.HotFontColor;
  inherited;
end;

{ TXPStyleDropDownBtn }

procedure TXPStyleDropDownBtn.DrawBackground(var PaintRect: TRect);
begin
  if Enabled and not (ActionBar.DesignMode) then
  begin
    if (MouseInControl or IsChecked or DroppedDown) and Assigned(ActionClient) then
      Canvas.Brush.Color := ActionBar.ColorMap.SelectedColor
    else
      Canvas.Brush.Color := ActionBar.ColorMap.Color;
  end
  else
    Canvas.Brush.Color := ActionBar.ColorMap.Color;
  inherited DrawBackground(PaintRect);
end;

procedure TXPStyleDropDownBtn.DrawFrame(ARect: TRect; Down: Boolean);
begin
  if Enabled and not (ActionBar.DesignMode) then
    if (MouseInControl or IsChecked or DroppedDown) and Assigned(ActionClient) then
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
      Dec(ARect.Right, 9);
      Canvas.Rectangle(ARect);
      ARect.Left := ARect.Right - 1;
      Inc(ARect.Right, 9);
      Canvas.Rectangle(ARect);
    end;
end;

procedure TXPStyleDropDownBtn.DrawGlyph(const Location: TPoint);
var
  OldBrushColor: TColor;
  SelBmp: TBitmap;
  NewLocation: TPoint;
  ImageList: TCustomImageList;
begin
  NewLocation := Location;
  if not ActionBar.DesignMode and MouseInControl and
     not IsChecked and Enabled and ActionClient.HasGlyph then
  begin
    OldBrushColor := Canvas.Brush.Color;
    SelBmp := TBitmap.Create;
    try
      if Action <> nil then
      begin
        ImageList := FindImageList(False, ActionClient.ImageIndex);
        if Assigned(ImageList) and (ActionClient.ImageIndex > -1) and
           (ActionClient.ImageIndex < ImageList.Count) then
        begin
          Canvas.Brush.Color := GetShadowColor(ActionBar.ColorMap.SelectedColor);
          SelBmp.Width := ImageList.Width;
          SelBmp.Height := ImageList.Width;

          SelBmp.Canvas.FillRect(SelBmp.Canvas.ClipRect);

          if ImageList.ColorDepth = cdDeviceDependent then
            ImageList.Draw(SelBmp.Canvas, 0, 0, ActionClient.ImageIndex, dsNormal, itMask)
          else
            ImageList.Draw( SelBmp.Canvas, 0, 0, ActionClient.ImageIndex);

          DrawState(Canvas.Handle, Canvas.Brush.Handle, nil, LPARAM(SelBmp.Handle), 0,
            NewLocation.X + 1, NewLocation.Y + 1, 0, 0, DST_BITMAP or DSS_MONO);
        end;
      end;
    finally
      SelBmp.Free;
      Canvas.Brush.Color := OldBrushColor;
    end;
    if not IsChecked then
    begin
      Dec(NewLocation.X);
      Dec(NewLocation.Y);
    end;
  end;
  if not (csDesigning in ComponentState) and ((FState = bsDown) and not IsChecked)
     and IsMouseButtonPressed then
  begin
    Inc(NewLocation.X);
    Inc(NewLocation.Y);
  end;
  inherited DrawGlyph(NewLocation);
end;

function TXPStyleDropDownBtn.GetPopupClass: TCustomActionBarClass;
begin
  Result := TXPStylePopupMenu;
end;

{ TXPStyleCustomizePopup }

constructor TXPStyleCustomizePopup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  VertMargin := 0;
end;

function TXPStyleCustomizePopup.GetAddRemoveItemClass: TCustomAddRemoveItemClass;
begin
  Result := TXPStyleAddRemoveItem;
end;

function TXPStyleCustomizePopup.GetDefaultColorMapClass: TCustomColorMapClass;
begin
  Result := TXPColorMap;
end;

procedure TXPStyleCustomizePopup.NCPaint(DC: HDC);
var
  RC, RW: TRect;
begin
  Winapi.Windows.GetClientRect(Handle, RC);
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  { Draw border in non-client area }
  OffsetRect(RW, -RW.Left, -RW.Top);
  try
    Canvas.Handle := DC;
    Canvas.Pen.Color := ColorMap.FrameTopLeftOuter;
    Canvas.Brush.Color := ColorMap.Color;
    Canvas.Rectangle(RW);
    Canvas.Pen.Color := ColorMap.BtnSelectedColor;
    Canvas.MoveTo(1,1);
    Canvas.LineTo(1, Height - 1);
  finally
    IntersectClipRect(Canvas.Handle, RW.Left, RW.Top, RW.Right, RW.Bottom);
    Canvas.Handle := 0;
  end;
end;

{ TXPStyleAddRemoveItem }

procedure TXPStyleAddRemoveItem.CalcBounds;
begin
  inherited;
  if Separator then
    Height := 3
  else
    Height := Height + 2;
end;

procedure TXPStyleAddRemoveItem.DrawBackground(var PaintRect: TRect);
var
  BannerRect: TRect;
  BGRect: TRect;
begin
  if ActionClient = nil then exit;

  if ActionClient.Color <> clDefault then
    Canvas.Brush.Color := ActionClient.Color;

  BGRect := PaintRect;
  if TextBounds.Left > GlyphPos.X then
    BGRect.Left := 0;
  BannerRect := PaintRect;
  if TextBounds.Left > GlyphPos.X then
    BannerRect.Right := TextBounds.Left - 3
  else
    BannerRect.Right := TextBounds.Right + 3;
  BannerRect.Right := 44;
  BGRect.Left := BannerRect.Right - BannerRect.Left;
  if ActionClient.Unused then
    Canvas.Brush.Color := Menu.ColorMap.UnusedColor
  else
    Canvas.Brush.Color := Menu.ColorMap.BtnSelectedColor;
  inherited DrawBackground(BannerRect);
  if not Separator then
    Canvas.Brush.Color := Menu.ColorMap.MenuColor;

  if (((Selected and Enabled) or (Selected and not MouseSelected))) and not Separator then
  begin
    Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
    Dec(PaintRect.Right, 1);
  end;
  inherited DrawBackground(BGRect);
  if (Selected and Enabled) or (Selected and not MouseSelected) then
  begin
    Canvas.FillRect(PaintRect);
    if not Separator then
    begin
      Canvas.Brush.Color := ActionBar.ColorMap.BtnFrameColor;
      Canvas.FrameRect(PaintRect);
    end;
  end;
end;

procedure TXPStyleAddRemoveItem.DrawGlyph(const Location: TPoint);
var
  OldColor, OldBrushColor: TColor;
  NewLocation: TPoint;
  FrameRect: TRect;
  SelBmp: TBitmap;
  ImageList: TCustomImageList;
begin
  if (Assigned(ActionClient) and not ActionClient.HasGlyph) and
     ((Action is TCustomAction) and TCustomAction(Action).Checked) then
  begin
    if IsChecked then
    begin
      FrameRect := System.Types.Rect(Location.X - 1, 1, Location.X + 20,
        Self.Height - 1);
      Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
      Canvas.FillRect(FrameRect);
      Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
      Canvas.Rectangle(FrameRect);
    end;
    Canvas.Pen.Color := Menu.ColorMap.FontColor;
    with Location do
      DrawCheck(Canvas, Point(X + 6, Y + 3), 2)
  end
  else
  begin
    if IsChecked then
    begin
      FrameRect := System.Types.Rect(Location.X - 1, 1, Location.X + 20,
        Self.Height - 1);
      Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
      Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
      Canvas.Rectangle(FrameRect);
    end;
    OldColor := Canvas.Brush.Color;
    if (Selected and Enabled) or (Selected and not MouseSelected) then
      Canvas.Brush.Color := Menu.ColorMap.SelectedColor
    else
      Canvas.Brush.Color := Menu.ColorMap.BtnSelectedColor;
    NewLocation := Location;

    if (Selected and Enabled and ActionClient.HasGlyph) then
    begin
      OldBrushColor := Canvas.Brush.Color;
      SelBmp := TBitmap.Create;
      try
        Canvas.Brush.Color := clBtnShadow;
        ImageList := FindImageList(False, ActionClient.ImageIndex);
        if ImageList.GetBitmap(ActionClient.ImageIndex, SelBmp) then
        begin
          SelBmp.Width := ImageList.Width;
          SelBmp.Height := ImageList.Width;
          DrawState(Canvas.Handle, Canvas.Brush.Handle, nil, LPARAM(SelBmp.Handle), 0,
            NewLocation.X + 3, NewLocation.Y + 2, 0, 0, DST_BITMAP or DSS_MONO);
        end;
      finally
        SelBmp.Free;
        Canvas.Brush.Color := OldBrushColor;
      end;

      Inc(NewLocation.X, 1);
      inherited DrawGlyph(NewLocation);
    end
    else begin
      Inc(NewLocation.X, 2);
      Inc(NewLocation.Y, 1);
      inherited DrawGlyph(NewLocation);
    end;
    Canvas.Brush.Color := OldColor;
  end;
  if IsActionVisible then
  begin
    FrameRect := System.Types.Rect(2 - 1, 1, 18, Self.Height - 1);
    Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
    Canvas.FillRect(FrameRect);
    Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
    Canvas.Rectangle(FrameRect);
    Canvas.Pen.Color := Menu.ColorMap.FontColor;
    with Location do
      DrawCheck(Canvas, Point(FrameRect.Left + 5, Self.Height div 2 - 1), 2);
  end;
end;

procedure TXPStyleAddRemoveItem.DrawSeparator(const Offset: Integer);
var
  PaintRect: TRect;
  PR: TPenRecall;
  BR: TBrushRecall;
begin
  if Selected then
    Canvas.FillRect(ClientRect);
  BR := TBrushRecall.Create(Canvas.Brush);
  PR := TPenRecall.Create(Canvas.Pen);
  try
    if Assigned(ActionClient) and ActionClient.Unused and not Transparent then
      Canvas.Brush.Style := bsSolid
    else
    begin
      Canvas.Brush.Color := Color;
      PaintRect := BoundsRect;
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_LEFT);
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_RIGHT);
    end;
    Canvas.Pen.Color := clBtnShadow;
    Canvas.MoveTo(32, ClientHeight div 2);
    Canvas.LineTo(ClientWidth, ClientHeight div 2);
  finally
    BR.Free;
    PR.Free;
  end;
end;

procedure TXPStyleAddRemoveItem.DrawText(var Rect: TRect; var Flags: Cardinal;
  Text: String);
var
  S: string;
begin
  S := Text;
  if Parent is TCustomActionBar then
    if not TCustomActionBar(Parent).PersistentHotkeys then
      begin
        if Pos('&', S) > 0 then
          Delete(S, Pos('&', S), 1);
      end;
  Text := S;
  OffsetRect(Rect, 6, 0);
  if Enabled then
    Canvas.Font.Color := Menu.ColorMap.FontColor
  else
    Canvas.Font.Color := Menu.ColorMap.DisabledFontColor;
  inherited DrawText(Rect, Flags, Text);
end;

procedure TXPStyleAddRemoveItem.DrawUnusedEdges;
begin
// This style of menu item does not have unused edges
end;

{ TXPStyleToolScrollBtn }

procedure TXPStyleToolScrollBtn.DrawBackground(var PaintRect: TRect);
begin
  if Enabled and MouseInControl then
      Canvas.Brush.Color := ActionBar.ColorMap.SelectedColor
  else
    Canvas.Brush.Color := ActionBar.ColorMap.Color;
  inherited DrawBackground(PaintRect);
  if Enabled and MouseInControl then
  begin
    Canvas.Pen.Color := ActionBar.ColorMap.BtnFrameColor;
    Canvas.Rectangle(ClientRect);
  end;
end;

end.
