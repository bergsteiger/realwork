unit fcCanvas;
{
//
// Components : TfcCanvas
//
// Copyright (c) 1999 by Woll2Woll Software
}

interface

uses
  Windows, Graphics, Messages, SysUtils, Classes, Controls, fcCommon;

const
  DT_DISABLED = $80000;

type
  TwwRectSide = (rsLeft, rsTop, rsRight, rsBottom);
  TwwRectSides = Set of TwwRectSide;

  TfcCanvas = class(TControlCanvas)
  public
    procedure Refresh;
    function DrawText(AText: string; ARect: TRect; Style: LongInt): TRect;
    procedure DottedLine(p1, p2: TPoint);
    procedure VCenterDrawText(AText: string; ARect: TRect; Style: Integer);
    procedure CenterDraw(SourceBitmap: TGraphic; ClipRect: TRect);
    procedure CenterRect(SourceBitmap: TBitmap; SourceRect, ClipRect: TRect);
    procedure DisabledDraw(X, Y: Integer; Bitmap: TBitmap);
    procedure FrameRectPen(ARect: TRect);
    procedure ClearRect(ARect: Trect; AGraphic: TGraphic; Stretch: Boolean; FillColor: TColor);
    procedure TileDraw(SourceBitmap: TBitmap);
    procedure Dither(r: TRect; ABrush: TBitmap);
    procedure DrawFrameControl(r: TRect; uType, uState: Integer);
    procedure ParseDraw(DestRect: TRect; ABitmap: TBitmap; NumImages, ImageIndex: Integer);
    procedure ParseCenterDraw(DestRect: TRect; ABitmap: TBitmap; NumImages, ImageIndex: Integer);
  end;

implementation

uses AxCtrls;

procedure TfcCanvas.TileDraw(SourceBitmap: TBitmap);
var CurLeft, CurTop: Integer;
begin
  if (SourceBitmap.Width <= 0) or (SourceBitmap.Height <= 0) then Exit;
  CurLeft := 0;
  while (CurLeft < ClipRect.Right) do
  begin
    CurTop := 0;
    while (CurTop < ClipRect.Bottom) do
    begin
      Draw(CurLeft, CurTop, SourceBitmap);
      inc(CurTop, SourceBitmap.Height);
    end;
    inc(CurLeft, SourceBitmap.Width);
  end;
end;

procedure TfcCanvas.Refresh;
begin
  SelectObject(Handle, Pen.Handle);
  SelectObject(Handle, Font.Handle);
  SelectObject(Handle, Brush.Handle);
end;

procedure TfcCanvas.DottedLine(p1, p2: TPoint);
var i: integer;
    x, y: integer;
    tot: integer;
begin
  Refresh;
  x := p1.x;
  y := p1.y;
  tot := fcMax(Abs(p2.y - p1.y), Abs(p2.x - p1.x));
  for i := 0 to tot do if i mod 2 = 0 then
  begin
    Polyline([Point(x,y), Point(x+1,y+1)]);
    inc(x, (p2.x - p1.x) div fcMax(1, (tot div 2)));
    inc(y, (p2.y - p1.y) div fcMax(1, (tot div 2)));
  end;
end;

procedure TfcCanvas.CenterRect(SourceBitmap: TBitmap; SourceRect, ClipRect: TRect);
var ALeft, ATop: Integer;
    ABitmap: TBitmap;
begin
  ALeft := (fcRectWidth(ClipRect) - fcRectWidth(SourceRect)) div 2 + ClipRect.Left;
  ATop := (fcRectHeight(ClipRect) - fcRectHeight(SourceRect)) div 2 + ClipRect.Top;
  FillRect(Rect(ALeft, ATop, ALeft + fcRectWidth(SourceRect), ATop + fcRectHeight(SourceRect)));
  ABitmap := TBitmap.Create;
  ABitmap.Transparent := True;
  SourceBitmap.Transparent := True;
  SourceBitmap.TransparentColor := SourceBitmap.Canvas.Pixels[0,0];
//  SourceBitmap.Mask($00808000);
  ABitmap.Width := SourceBitmap.Width;
  ABitmap.Height := SourceBitmap.Height;
  ABitmap.Canvas.Brush.Color := SourceBitmap.Canvas.Brush.Color;
  ABitmap.Canvas.FillRect(ABitmap.Canvas.ClipRect);
  ABitmap.Canvas.Draw(0, 0, SourceBitmap);
  CopyRect(Rect(ALeft, ATop, ALeft + fcRectWidth(SourceRect), ATop + fcRectHeight(SourceRect)),
           ABitmap.Canvas, SourceRect);
  ABitmap.Free;
end;

procedure TfcCanvas.CenterDraw(SourceBitmap: TGraphic; ClipRect: TRect);
begin
  if (SourceBitmap.Width = 0) or (SourceBitmap.Height = 0) then Exit;
  Draw((fcRectWidth(ClipRect) - SourceBitmap.Width) div 2 + ClipRect.Left,
    (fcRectHeight(ClipRect) - SourceBitmap.Height) div 2 + ClipRect.Top, SourceBitmap);
end;

procedure TfcCanvas.Dither(r: TRect; ABrush: TBitmap);
begin
  Brush.Bitmap := ABrush;
  SetBKColor(Handle, ColorToRGB(clRed));
  SetTextColor(Handle, ColorToRGB(clGreen));
  FillRect(r);
  Brush.Bitmap := nil;
end;

function TfcCanvas.DrawText(AText: string; ARect: TRect; Style: Integer): TRect;
begin
  // Used by DrawText API Function when "Item" has focus.
  SetBkColor(Handle, ColorToRGB(Brush.Color));
  SetTextColor(Handle, ColorToRGB(Font.Color));

  Refresh;
  if (Style and DT_DISABLED <> 0) and (Style and DT_CALCRECT = 0) then
  begin
    Font.Color := clBtnHighlight;
    OffSetRect(ARect, 1, 1);
    Windows.DrawText(Handle, PChar(AText), Length(AText), ARect, Style);
    SetBkMode(Handle, TRANSPARENT);
    OffSetRect(ARect, -1, -1);
    Font.Color := clBtnShadow;
  end;
  Windows.DrawTextEx(Handle, PChar(AText), Length(AText), ARect, Style, nil);
  result := ARect;
end;

procedure TfcCanvas.VCenterDrawText(AText: string; ARect: TRect; Style: Integer);
var r: TRect;
begin
  r := DrawText(AText, ARect, Style or DT_CALCRECT);
  r := Rect(ARect.Left, fcMax(ARect.Top, ARect.Top + ((fcRectHeight(ARect) - fcRectHeight(r)) div 2)), ARect.Right, ARect.Bottom);
  DrawText(AText, r, Style);
end;

procedure TfcCanvas.DisabledDraw(X, Y: Integer; Bitmap: TBitmap);
const
  ROP_DSPDxax = $00E20746;
var
  Bit: TBitmap;
begin
  Bit := TBitmap.Create;
  Bit.Assign(Bitmap);
  Brush.Color := clBtnFace;

  with Bit do begin
    HandleType := bmDDB;
    Canvas.Brush.Color := clBlack;
    if Monochrome then
    begin
      Canvas.Font.Color := clWhite;
      Monochrome := False;
      Canvas.Brush.Color := clWhite;
    end;
    Monochrome := True;
  end;

  Brush.Color := clBtnFace;
  FillRect(Rect(0,0,Bitmap.Width,Bitmap.Height));
  Brush.Color := clBtnHighlight;
  SetTextColor(Handle, clBlack);
  SetBkColor(Handle, clWhite);
  StretchBlt(Handle, 0, 0, Bitmap.Width, Bitmap.Height,
    Bit.Canvas.Handle, 0, 0, Bit.Width, Bit.Height, ROP_DSPDxax);
  Brush.Color := clBtnShadow;
  SetTextColor(Handle, clBlack);
  SetBkColor(Handle, clWhite);
  StretchBlt(Handle, 0, 0, Bitmap.Width, Bitmap.Height,
    Bit.Canvas.Handle, 0, 0, Bit.Width, Bit.Height, ROP_DSPDxax);
  Bit.Free;
end;

procedure TfcCanvas.FrameRectPen(ARect: TRect);
begin
//  InflateRect(ARect, -(Pen.Width - 1), -(Pen.Width - 1));
  OffSetRect(ARect, Pen.Width - 1, Pen.Width - 1);
  Polyline([Point(ARect.Left, ARect.Top), Point(ARect.Right, ARect.Top),
    Point(ARect.Right, ARect.Bottom), Point(ARect.Left, ARect.Bottom),
    Point(ARect.Left, ARect.Top)]);
end;

procedure TfcCanvas.ClearRect(ARect: Trect; AGraphic: TGraphic; Stretch: Boolean; FillColor: TColor);
var ABitmap: TBitmap;
    AColor: TColor;
begin
  if AGraphic = nil then
  begin
    AColor := Brush.Color;
    Brush.Color := FillColor;
    FillRect(ARect);
    Brush.Color := AColor;
  end else begin
    ABitmap := TBitmap.Create;
    ABitmap.Width := fcRectWidth(ClipRect);
    ABitmap.Height := fcRectHeight(ClipRect);
    if Stretch then ABitmap.Canvas.StretchDraw(ClipRect, AGraphic)
    else ABitmap.Canvas.Draw(0, 0, AGraphic);
    ABitmap.Canvas.CopyRect(ARect, self, ARect);
    ABitmap.Free;
  end;
end;

procedure TfcCanvas.DrawFrameControl(r: TRect; uType, uState: Integer);
var bit, bit2: TBitmap;
begin
  bit := TBitmap.Create;
  bit2 := TBitmap.Create;
  try
    bit.Width := fcRectWidth(r);
    bit.Height := fcRectHeight(r);
    bit.Transparent := False;
    bit2.Assign(bit);

    Windows.DrawFrameControl(bit.Canvas.Handle, bit.Canvas.ClipRect, uType, uState);

    bit2.Canvas.Brush.Color := clRed;
    bit2.Canvas.FillRect(bit2.Canvas.ClipRect);
    BitBlt(bit2.Canvas.Handle,
           0, 0, bit2.Width, bit2.Height,
           Bit.Canvas.Handle,
           0, 0,
           SRCPAINT);

    bit2.Transparent := True;
    Draw(r.Left, r.Top, bit2);
  finally
    bit.free;
    bit2.Free;
  end;
end;

procedure TfcCanvas.ParseDraw(DestRect: TRect; ABitmap: TBitmap; NumImages, ImageIndex: Integer);
var AImageWidth: Integer;
    ALeft: Integer;
begin
  AImageWidth := ABitmap.Width div NumImages;
  ALeft := AImageWidth * ImageIndex;
  Brush.Style := bsClear;
  BrushCopy(Rect(DestRect.Left, DestRect.Top, DestRect.Left + AImageWidth, DestRect.Top + ABitmap.Height),
    ABitmap,
    Rect(ALeft, 0, ALeft + AImageWidth, ABitmap.Height),
    ABitmap.TransparentColor);
end;

procedure TfcCanvas.ParseCenterDraw(DestRect: TRect; ABitmap: TBitmap; NumImages, ImageIndex: Integer);
var AImageWidth: Integer;
    ALeft: Integer;
    ATop: Integer;
begin
  AImageWidth := ABitmap.Width div NumImages;
  ALeft := DestRect.Left + (((DestRect.Right - DestRect.Left) - AImageWidth) div 2);
  ATop := DestRect.Top + (((DestRect.Bottom - DestRect.Top) - ABitmap.Height) div 2);
  ParseDraw(Rect(ALeft, ATop, ALeft + AImageWidth, ATop + ABitmap.Height),
    ABitmap, NumImages, ImageIndex);
end;

end.
