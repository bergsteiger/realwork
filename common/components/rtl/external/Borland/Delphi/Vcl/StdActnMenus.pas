
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1995-2002 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit StdActnMenus;

interface

uses Windows, Messages, Classes, Controls, Graphics, Buttons, ActnMenus,
  ToolWin, ActnMan, ActnCtrls;

type

{ TStandardMenuItem }

  TStandardMenuItem = class(TCustomMenuItem)
  protected
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawDesignFocus(var PaintRect: TRect); override;
    procedure DrawEdge(Edges: TMenuEdges); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawGlyphFrame(const Location: TPoint);
    procedure DrawSeparator(const Offset: Integer); override;
    procedure DrawText(var Rect: TRect; var Flags: Cardinal; Text: String); override;
    procedure DrawLargeGlyph(Location: TPoint); override;
  end;

{ TStandardMenuButton }

  TStandardMenuButton = class(TCustomMenuButton)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal;
      Text: String); override;
    procedure DrawDesignFocus(var PaintRect: TRect); override;
    procedure DrawFrame(ARect: TRect; Down: Boolean); override;
  end;

{ TStandardToolScrollBtn }

  TStandardToolScrollBtn = class(TCustomToolScrollBtn)
  protected
    procedure DrawFrame(ARect: TRect; Down: Boolean); override;
  end;

{ TStandardMenuExpandBtn }

  TStandardMenuExpandBtn = class(TCustomMenuExpandBtn)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawFrame(ARect: TRect; Down: Boolean); override;
  end;

{ TStarndardMenuPopup }

  TStandardMenuPopup = class(TCustomActionPopupMenu)
  protected
    function CanAutoSize(var NewWidth: Integer;
      var NewHeight: Integer): Boolean; override;
    function GetExpandBtnClass: TCustomMenuExpandBtnClass; override;
    procedure NCPaint(DC: HDC); override;
    procedure PositionPopup(AnOwner: TCustomActionBar;
      ParentItem: TCustomActionControl); override;
    end;

{ TStandardAddRemoveItem }

  TStandardAddRemoveItem = class(TCustomAddRemoveItem)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
  end;

{ TStandardCustomizePopup }

  TStandardCustomizePopup = class(TCustomizeActionToolBar)
  protected
    function CanAutoSize(var NewWidth: Integer;
      var NewHeight: Integer): Boolean; override;
    procedure PositionPopup(AnOwner: TCustomActionBar;
      ParentItem: TCustomActionControl); override;
  end;

{ TStandardButtonControl }

  TStandardButtonControl = class(TCustomButtonControl)
  protected
    procedure DrawText(var ARect: TRect; var Flags: Cardinal;
      Text: String); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawFrame(ARect: TRect; Down: Boolean); override;
  end;

procedure RegisterStandardMenus; deprecated;

implementation

uses SysUtils, Menus, ActnList, GraphUtil, Forms, ActnColorMaps, ImgList;

const
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
  FrameStyle: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  EdgesOffset: array[Boolean] of Integer = (0, 1);

procedure RegisterStandardMenus;
begin
// No longer used
end;

{ TStandardMenuItem }

procedure TStandardMenuItem.DrawSeparator(const Offset: Integer);
begin
  Color := Canvas.Brush.Color;
  inherited DrawSeparator(13);
end;

procedure TStandardMenuItem.DrawBackground(var PaintRect: TRect);
begin
  if ActionClient = nil then exit;

  if ((Selected and Enabled) or (Selected and not MouseSelected)) and
     not ActionBar.DesignMode then
  begin
    if ActionClient.HasGlyph or IsChecked then
      Inc(PaintRect.Left, 21)
    else
      Inc(PaintRect.Left);
    Dec(PaintRect.Right);
  end;
  Canvas.Brush.Color := ActionBar.ColorMap.MenuColor;
  if Selected then
    Canvas.Brush.Color := ActionBar.ColorMap.SelectedColor;
  if ActionClient.Unused and not Selected then
    Canvas.Brush.Color := ActionBar.ColorMap.UnusedColor;
  if Selected and ActionBar.DesignMode and not ActionClient.HasItems then
    if ActionClient.Unused then
      Canvas.Brush.Color := ActionBar.ColorMap.UnusedColor
    else
      Canvas.Brush.Color := ActionBar.ColorMap.MenuColor;
  inherited DrawBackground(PaintRect);
end;

procedure TStandardMenuItem.DrawGlyph(const Location: TPoint);
begin
  DrawGlyphFrame(Location);
  if not HasGlyph and IsChecked then
  begin
    Canvas.Pen.Color := ActionBar.ColorMap.FontColor;
    DrawCheck(Canvas, Point((TextBounds.Left - 5) div 2, Height div 2), 2);
  end;
  inherited DrawGlyph(Location);
end;

type
  TCustomActionBarType = class(TCustomActionBar);

procedure TStandardMenuItem.DrawText(var Rect: TRect; var Flags: Cardinal;
  Text: String);
var
  S: string;
begin
  S := Text;
  if Parent is TCustomActionBar then
    if not TCustomActionBarType(Parent).PersistentHotkeys then
      S := FNoPrefix;
  Text := S;
  inherited DrawText(Rect, Flags, Text);
end;

procedure TStandardMenuItem.CMTextchanged(var Message: TMessage);
begin
  inherited;
  if Separator then
    Height := GetSystemMetrics(SM_CYMENU) div 2
end;

procedure TStandardMenuItem.DrawDesignFocus(var PaintRect: TRect);
begin
  if Mouse.IsDragging then exit;
  with Canvas do
    if Assigned(ActionClient) and ActionClient.HasItems then
      with ClientRect do
      begin
        Brush.Color := clBlue;
        PatBlt(Handle, Left, Top, Width, 2, PATINVERT);
        PatBlt(Handle, Left + Width - 4, Top + 2, 2, Height, PATINVERT);
        PatBlt(Handle, Left + 3, Top + Height - 2, Width - 7, 2, PATINVERT);
        PatBlt(Handle, Left + 1, Top + 2, 2, Height, PATINVERT);
      end
    else
      inherited DrawDesignFocus(PaintRect);
end;

procedure TStandardMenuItem.DrawGlyphFrame(const Location: TPoint);
var
  FrameRect: TRect;
  Clrs: array[Boolean] of TColor;
begin
  if not HasGlyph and not IsChecked then exit;
  FrameRect := Rect(Location.X - 1, 0, Location.X + TextBounds.Left - 5, Self.Height);
  if ((Selected and Enabled) or (Selected and not MouseSelected)) or IsChecked then
    if not (csDesigning in ComponentState) then
    begin
      Inc(FrameRect.Top, EdgesOffset[ebTop in Edges]);
      Dec(FrameRect.Bottom, EdgesOffset[ebBottom in Edges]);
      Clrs[False] := Menu.ColorMap.FrameTopLeftInner;
      Clrs[True] := Menu.ColorMap.FrameBottomRightInner;
      Canvas.Pen.Color := Clrs[IsChecked];
      Canvas.MoveTo(FrameRect.Right - 1, FrameRect.Top);
      Canvas.LineTo(FrameRect.Left, FrameRect.Top);
      Canvas.LineTo(FrameRect.Left, FrameRect.Bottom);

      Canvas.Pen.Color := Clrs[not IsChecked];
      Canvas.MoveTo(FrameRect.Right - 1, FrameRect.Top);
      Canvas.LineTo(FrameRect.Right - 1, FrameRect.Bottom - 1);
      Canvas.LineTo(FrameRect.Left - 1, FrameRect.Bottom - 1);
    end;
    if not Transparent then
    begin
      if not Selected and IsChecked then
        Canvas.Brush.Bitmap := AllocPatternBitmap(Menu.ColorMap.MenuColor,
          Menu.ColorMap.UnusedColor)
      else
        if ActionClient.Unused then
          Canvas.Brush.Color := Menu.ColorMap.UnusedColor
        else
          Canvas.Brush.Color := Menu.ColorMap.MenuColor;
      InflateRect(FrameRect, -1, -1);
      Canvas.FillRect(FrameRect);
    end;
end;

procedure TStandardMenuItem.DrawLargeGlyph(Location: TPoint);
begin
  DrawGlyphFrame(Location);
  inherited;
end;

procedure TStandardMenuItem.DrawEdge(Edges: TMenuEdges);
var
  Clrs: array[Boolean] of TColor;
begin
  inherited;
  Clrs[False] := GetHighLightColor(ActionBar.Color);
  Clrs[True] := GetShadowColor(ActionBar.Color);
  Canvas.Pen.Color := Clrs[False];
  Canvas.MoveTo(ClientRect.Right, ClientRect.Top);
  if ebTop in Edges then
    Canvas.LineTo(ClientRect.Left, ClientRect.Top)
  else
    Canvas.MoveTo(ClientRect.Left, ClientRect.Top);
  if ebLeft in Edges then
    Canvas.LineTo(ClientRect.Left, ClientRect.Bottom)
  else
    Canvas.MoveTo(ClientRect.Left, ClientRect.Bottom);
  Canvas.Pen.Color := Clrs[True];
  Canvas.Pen.Width := 1;
  Canvas.MoveTo(ClientRect.Right - 1, ClientRect.Top);
  Canvas.LineTo(ClientRect.Right - 1, ClientRect.Bottom);
  Canvas.MoveTo(ClientRect.Right - 2, ClientRect.Top);
  Canvas.Pen.Color := Clrs[True];
  if Assigned(ActionClient) and not ActionClient.Unused and (ebRight in Edges) then
    Canvas.LineTo(ClientRect.Right - 2, ClientRect.Bottom + 1)
  else
    Canvas.MoveTo(ClientRect.Right - 2, ClientRect.Bottom - 1);
  if ebBottom in Edges then
    Canvas.LineTo(ClientRect.Left, ClientRect.Bottom - 1);
end;

{ TStandardMenuPopup }

function TStandardMenuPopup.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
  Inc(NewHeight);
end;

function TStandardMenuPopup.GetExpandBtnClass: TCustomMenuExpandBtnClass;
begin
  Result := TStandardMenuExpandBtn;
end;

procedure TStandardMenuPopup.NCPaint(DC: HDC);
var
  RC, RW: TRect;
  OldHandle: THandle;
begin
  Windows.GetClientRect(Handle, RC);
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
  finally
    Canvas.Handle := OldHandle;
  end;
end;

procedure TStandardMenuPopup.PositionPopup(AnOwner: TCustomActionBar;
  ParentItem: TCustomActionControl);
begin
  inherited PositionPopup(AnOwner, ParentItem);
  if (ParentItem is TCustomMenuItem) and (Left > ParentItem.Parent.BoundsRect.Left) then
    Left := ParentItem.Parent.BoundsRect.Right - 6;
end;

{ TStandardAddRemoveItem }

procedure TStandardAddRemoveItem.DrawGlyph(const Location: TPoint);
var
  FrameRect: TRect;
begin
  if HasGlyph then
  begin
    FrameRect := Rect(Location.X - 1, 0, Location.X + 18, Self.Height);
    if ((Selected and Enabled) or (Selected and not MouseSelected)) or IsChecked then
    begin
      Inc(FrameRect.Top, EdgesOffset[ebTop in Edges]);
      Dec(FrameRect.Bottom, EdgesOffset[ebBottom in Edges]);
      if not (csDesigning in ComponentState) then
        Windows.DrawEdge(Canvas.Handle, FrameRect, FrameStyle[IsChecked],
          FillStyles[Transparent] or BF_RECT);
      if not Transparent then
      begin
        if not Selected then
          Canvas.Brush.Bitmap := AllocPatternBitmap(Menu.ColorMap.Color,
            GetHighLightColor(Menu.ColorMap.Color))
        else
          Canvas.Brush.Color := Menu.ColorMap.Color;
        InflateRect(FrameRect, -1, -1);
        Canvas.FillRect(FrameRect);
      end;
    end;
  end;
  if not HasGlyph and IsChecked then
  begin
    Canvas.Pen.Color := Menu.ColorMap.FontColor;
    DrawCheck(Canvas, Point(Location.X + 4, Location.Y + 4), 2);
  end;
  inherited DrawGlyph(Location);
  if IsActionVisible then
  begin
    FrameRect := Rect(2 - 1, 0, 18, Self.Height);
    Inc(FrameRect.Top, EdgesOffset[ebTop in Edges]);
    Dec(FrameRect.Bottom, EdgesOffset[ebBottom in Edges]);
    if not (csDesigning in ComponentState) then
      Windows.DrawEdge(Canvas.Handle, FrameRect, FrameStyle[True],
        FillStyles[False] or BF_RECT);
    if not Transparent then
    begin
      if not Selected then
        Canvas.Brush.Bitmap := AllocPatternBitmap(Menu.ColorMap.Color,
          GetHighLightColor(Menu.ColorMap.Color))
      else
        Canvas.Brush.Color := GetHighLightColor(Menu.ColorMap.Color);
      InflateRect(FrameRect, -1, -1);
      Canvas.FillRect(FrameRect);
    end;
    DrawCheck(Canvas, Point(6, Height div 2 + 1), 2, True);
  end;
end;

procedure TStandardAddRemoveItem.DrawBackground(var PaintRect: TRect);
begin
  if ActionClient = nil then exit;

  if ((Selected and Enabled) or (Selected and not MouseSelected)) and
     not ActionBar.DesignMode then
  begin
    if ActionClient.HasGlyph or IsChecked then
      Inc(PaintRect.Left, 22)
    else
      Inc(PaintRect.Left);
    Dec(PaintRect.Right, 2);
  end;
  if Selected then
    Canvas.Brush.Color := ActionBar.ColorMap.SelectedColor;
  if ActionClient.Unused and not Selected then
    Canvas.Brush.Color := ActionBar.ColorMap.UnusedColor;
  if Selected and ActionBar.DesignMode and not ActionClient.HasItems then
    if ActionClient.Unused then
      Canvas.Brush.Color := ActionBar.ColorMap.UnusedColor
    else
      Canvas.Brush.Color := ActionBar.ColorMap.MenuColor;
  inherited DrawBackground(PaintRect);
end;

{ TStandardCustomizePopup }

function TStandardCustomizePopup.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
//  Inc(NewHeight, 2);
end;

procedure TStandardCustomizePopup.PositionPopup(AnOwner: TCustomActionBar;
  ParentItem: TCustomActionControl);
begin
  inherited PositionPopup(AnOwner, ParentItem);
//  Left := Left - 5;
//  Top := Top - 3;
end;

{ TStandardMenuButton }

procedure TStandardMenuButton.DrawBackground(var PaintRect: TRect);
begin
  if Selected then
    Canvas.Brush.Color := ActionBar.ColorMap.BtnSelectedColor
  else
    Canvas.Brush.Color := ActionBar.ColorMap.Color;
  inherited;
end;

procedure TStandardMenuButton.DrawDesignFocus(var PaintRect: TRect);
begin
  if Mouse.IsDragging then exit;
  inherited;
end;

procedure TStandardMenuButton.DrawFrame(ARect: TRect; Down: Boolean);
var
  Clrs: array[Boolean] of TColor;
begin
  inherited;
  if (FState = bsDown) or not Flat or MouseInControl or IsChecked then
  begin
    Clrs[False] := ActionBar.ColorMap.FrameTopLeftInner;
    Clrs[True] := ActionBar.ColorMap.FrameBottomRightInner;
    Canvas.Pen.Color := Clrs[Down];
    Canvas.MoveTo(ARect.Right - Integer(not Down), ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Bottom - Integer(not Down));
    Canvas.Pen.Color := Clrs[not Down];
    Canvas.MoveTo(ARect.Right - 1, ARect.Top - Integer(Down));
    Canvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    Canvas.LineTo(ARect.Left{-1 }+ Integer(Down), ARect.Bottom - 1);
  end;
end;

procedure TStandardMenuButton.DrawText(var ARect: TRect;
  var Flags: Cardinal; Text: String);
begin
  if not (csDesigning in ComponentState) and ((FState = bsDown) or IsChecked) then
    OffsetRect(ARect, 1, 1);
  inherited DrawText(ARect, Flags, Text);
end;

{ TStandardToolScrollBtn }

procedure TStandardToolScrollBtn.DrawFrame(ARect: TRect; Down: Boolean);
var
  Clrs: array[Boolean] of TColor;
begin
  if MouseInControl then
  begin
    Clrs[False] := ActionBar.ColorMap.FrameTopLeftInner;
    Clrs[True] := ActionBar.ColorMap.FrameBottomRightInner;
    Canvas.Pen.Color := Clrs[Down];
    Canvas.MoveTo(ARect.Right - Integer(not Down), ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Bottom - Integer(not Down));
    Canvas.Pen.Color := Clrs[not Down];
    Canvas.MoveTo(ARect.Right - 1, ARect.Top - Integer(Down));
    Canvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    Canvas.LineTo(ARect.Left{-1 }+ Integer(Down), ARect.Bottom - 1);
  end;
end;

{ TStandardButtonControl }

procedure TStandardButtonControl.DrawFrame(ARect: TRect; Down: Boolean);
var
  Clrs: array[Boolean] of TColor;
begin
  inherited;
  if (FState = bsDown) or not Flat or MouseInControl or IsChecked then
  begin
    Clrs[False] := ActionBar.ColorMap.FrameTopLeftInner;
    Clrs[True] := ActionBar.ColorMap.FrameBottomRightInner;
    Canvas.Pen.Color := Clrs[Down];
    Canvas.MoveTo(ARect.Right - Integer(not Down), ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Bottom - Integer(not Down));
    Canvas.Pen.Color := Clrs[not Down];
    Canvas.MoveTo(ARect.Right - 1, ARect.Top - Integer(Down));
    Canvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    Canvas.LineTo(ARect.Left{-1 }+ Integer(Down), ARect.Bottom - 1);
  end;
end;

procedure TStandardButtonControl.DrawGlyph(const Location: TPoint);
var
  NewLocation: TPoint;
begin
  NewLocation := Location;
  if not (csDesigning in ComponentState) and ((FState = bsDown) or IsChecked) then
  begin
    Inc(NewLocation.X);
    Inc(NewLocation.Y);
  end;
  inherited DrawGlyph(NewLocation);
end;

procedure TStandardButtonControl.DrawText(var ARect: TRect;
  var Flags: Cardinal; Text: String);
begin
  if not (csDesigning in ComponentState) and ((FState = bsDown) or IsChecked) then
    OffsetRect(ARect, 1, 1);
  Canvas.Font.Color := ActionBar.ColorMap.FontColor;
  inherited;
end;

{ TStandardMenuExpandBtn }

procedure TStandardMenuExpandBtn.DrawBackground(var PaintRect: TRect);
begin
  Canvas.Brush.Color := Menu.ColorMap.MenuColor;
  Canvas.FillRect(PaintRect);
  inherited;
  if ((FState = bsDown) or not Flat or MouseInControl or IsChecked) then
  begin
    Canvas.Brush.Color := Menu.ColorMap.UnusedColor;
    Canvas.FillRect(PaintRect);
  end;
end;

procedure TStandardMenuExpandBtn.DrawFrame(ARect: TRect; Down: Boolean);
var
  Clrs: array[Boolean] of TColor;
begin
  OffsetRect(ARect, 0, 1);
  InflateRect(ARect, -2, -4);
  inherited;
  if (FState = bsDown) or not Flat or MouseInControl or IsChecked then
  begin
    Clrs[False] := Menu.ColorMap.FrameTopLeftInner;
    Clrs[True] := Menu.ColorMap.FrameBottomRightInner;
    Clrs[False] := ActionBar.ColorMap.FrameTopLeftInner;
    Clrs[True] := ActionBar.ColorMap.FrameBottomRightInner;
    Canvas.Pen.Color := Menu.ColorMap.FrameTopLeftInner;;//Clrs[Down];
    Canvas.MoveTo(ARect.Right - Integer(not Down), ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Bottom - Integer(not Down));
    Canvas.Pen.Color := Menu.ColorMap.FrameBottomRightInner;//Clrs[not Down];
    Canvas.MoveTo(ARect.Right - 1, ARect.Top - Integer(Down));
    Canvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    Canvas.LineTo(ARect.Left{-1 }+ Integer(Down), ARect.Bottom - 1);
  end;
end;

end.
