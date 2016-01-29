{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ElExtBkgnd;

interface

uses
  Windows,
  Graphics,
{$ifdef VCL_6_USED}
Types,
{$endif}
  Classes,
  SysUtils,
  ElTools,
  ElVCLUtils;


procedure ExtDrawBkgnd2(DC : HDC; R, DocRect : TRect; Origin : TPoint; FillColor : TColor;
          SourceBitmap : Graphics.TBitmap; DrawMode : TElBkGndType);

procedure ExtDrawBkgnd(DC : HDC; RectDoc, RectWindow, RectDC, RectOnDC : TRect;
  InvertedMode : boolean; FillColor, OverColor : TColor;
  SourceBitmap : Graphics.TBitmap; DrawMode : TElBkGndType);


// RectWindow - the Window Rectangle. Just to calculate window's width and height
// RectDC - the DC full rectangle relation to RectWindow
// RectOnDC - the rectangle relative to DC coordinates to which the bitmap is drawn
// DrawMode = (bgtTileBitmap, bgtStretchBitmap, bgtColorFill, bgtCenterBitmap);

implementation

procedure ExtDrawBkgnd2(DC : HDC; R, DocRect : TRect; Origin : TPoint; FillColor : TColor;
          SourceBitmap : Graphics.TBitmap; DrawMode : TElBkGndType);
var CurRect,
    DstRect,
    SrcRect,
    RealRect : TRect;
    i, j, k,
    l, n,
    sw, sh   : integer;
    HelpBmp  : TBitmap;
    aSaveDC  : integer;
begin
  if DrawMode = bgtColorFill then
  begin
    FillSolidRect2(DC, R, ColorToRGB(FillColor));
    exit;
  end;
  RealRect := R;
  OffsetRect(RealRect, Origin.X, Origin.Y);
  if (RealRect.Bottom > DocRect.Bottom) or
     (RealRect.Top < DocRect.Top) or
     (RealRect.Right > DocRect.Right) or
     (RealRect.Left < DocRect.Left) then
  begin
    FillSolidRect2(DC, R, ColorToRGB(FillColor));
  end;
  case DrawMode of
    bgtTileBitmap:
      begin
        sw := SourceBitmap.Width;
        sh := SourceBitmap.Height;
        i := 0;
        while i + sh < RealRect.Top do
          inc(i, sh);
        j := 0;
        while j + sw < RealRect.Left do
          inc(j, sw);
        k := j;
        while i < RealRect.Bottom do
        begin
          while j < RealRect.Right do
          begin
            // get visible area of the tiled bitmap
            SrcRect := Rect(j, i, j + sw, i + sh);
            IntersectRect(DstRect, SrcRect, RealRect);
            // get the portion of the bitmap to be copied
            l := DstRect.Left mod sw;
            n := DstRect.Top mod sh;
            //SrcRect := Rect(l, n, l + DstRect.Right - DstRect.Left, n + DstRect.Bottom - DstRect.Top);
            bitblt(DC, DstRect.Left - Origin.X,
                       DstRect.Top - Origin.Y,
                       DstRect.Right - DstRect.Left,
                       DstRect.Bottom - DstRect.Top,
                       SourceBitmap.Canvas.Handle,
                       l, n, SRCCOPY);
            inc(j, sw);
          end;
          j := k;
          inc(i, sh);
        end;
      end;
    bgtTopLeftBitmap,
    bgtCenterBitmap:
      begin
        // Center the bitmap
        if DrawMode = bgtCenterBitmap then
        begin
          CenterRects(SourceBitmap.Width, DocRect.Right - DocRect.Left, SourceBitmap.Height, DocRect.Bottom - DocRect.Top, CurRect);
        end
        else
          CurRect := Rect(0, 0, SourceBitmap.Width, SourceBitmap.Height);

        OffsetRect(CurRect, DocRect.Left, DocRect.Top);
        // now get the target rectangle
        IntersectRect(DstRect, CurRect, RealRect);
        // now get the source rectangle
        SrcRect := DstRect;
        OffsetRect(SrcRect, - CurRect.Left, -CurRect.Top);
        l := SrcRect.Left;
        n := SrcRect.Top;
        bitblt(DC, DstRect.Left - Origin.X,
                   DstRect.Top - Origin.Y,
                   DstRect.Right - DstRect.Left,
                   DstRect.Bottom - DstRect.Top,
                   SourceBitmap.Canvas.Handle,
                   l, n, SRCCOPY);
        aSaveDC := SaveDC(DC);
        ExcludeClipRect(DC, DstRect.Left - Origin.X,
                            DstRect.Top - Origin.Y,
                            DstRect.Right - DstRect.Left,
                            DstRect.Bottom - DstRect.Top);
        FillSolidRect2(DC, RealRect, ColorToRGB(FillColor));
        RestoreDC(DC, aSaveDC);
      end;
    bgtStretchBitmap:
      begin
        HelpBmp := TBitmap.Create;
        try
          HelpBmp.Width := DocRect.Right - DocRect.Left;
          HelpBmp.Height := DocRect.Bottom - DocRect.Top;

          SetStretchBltMode(HelpBmp.Canvas.Handle, COLORONCOLOR);
          stretchblt(HelpBmp.Canvas.Handle, 0, 0, HelpBmp.Width, HelpBmp.Height,
                     SourceBitmap.Canvas.Handle, 0, 0, SourceBitmap.Width, SourceBitmap.Height, SRCCOPY);

          DstRect := RealRect;
          CurRect := Rect(0, 0, HelpBmp.Width, HelpBmp.Height);

          OffsetRect(CurRect, DocRect.Left, DocRect.Top);
          // now get the target rectangle
          IntersectRect(DstRect, CurRect, RealRect);
          // now get the source rectangle
          SrcRect := DstRect;
          OffsetRect(SrcRect, - CurRect.Left, -CurRect.Top);
          l := SrcRect.Left;
          n := SrcRect.Top;
          bitblt(DC, DstRect.Left - Origin.X,
                     DstRect.Top - Origin.Y,
                     DstRect.Right - DstRect.Left,
                     DstRect.Bottom - DstRect.Top,
                     HelpBmp.Canvas.Handle,
                     l, n, SRCCOPY);
        finally
          HelpBmp.Free;
        end;
      end;
  end;
end;

procedure ExtDrawBkgnd(DC : HDC; RectDoc, RectWindow, RectDC, RectOnDC : TRect;
  InvertedMode : boolean; FillColor, OverColor : TColor;
  SourceBitmap : Graphics.TBitmap; DrawMode : TElBkGndType);
var
  DestRect : TRect;
  SrcRect : TRect;
  TmpRect : TRect;
  BltMode : Integer;
  HelpBmp : TBitmap;
  sw, sh : integer;
  CurRect : TRect;
  CurLeft,
    CurTop : integer;
  //TempDC : HDC;

begin
  TmpRect := RectOnDC;
  if (DrawMode = bgtColorFill) or (SourceBitmap.Empty and (DrawMode in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap, bgtTopLeftBitmap])) then
  begin
    FillSolidRect2(DC, TmpRect, ColorToRGB(FillColor));
    exit;
  end;
  case DrawMode of
    bgtTileBitmap :
      begin
        OffsetRect(TmpRect, -RectDC.Left, -RectDC.Top);
        CurLeft := RectWindow.Left + RectDoc.Left;
        CurTop := RectWindow.Top + RectDoc.Top;
        sw := SourceBitmap.Width;
        sh := SourceBitmap.Height;
        CurRect := Rect(CurLeft - RectDoc.Left, CurTop - RectDoc.Top, CurLeft + sw - RectDoc.Left, CurTop + sh - RectDoc.Top);
        while CurRect.Bottom <= TmpRect.Top do
        begin
          inc(CurTop, sh);
          CurRect := Rect(CurLeft - RectDoc.Left, CurTop - RectDoc.Top, CurLeft + sw - RectDoc.Left, CurTop + sh - RectDoc.Top);
        end;
        while CurTop < TmpRect.Bottom do
        begin
          while CurLeft < TmpRect.Right do
          begin
            SrcRect := Rect(CurLeft, CurTop, CurLeft + sw, CurTop + sh);
            IntersectRect(DestRect, TmpRect, SrcRect);
            if not IsRectEmpty(DestRect) then
            begin
              SrcRect := DestRect;
              OffsetRect(SrcRect, -CurLeft, -CurTop);

              OffsetRect(DestRect, -RectDC.Left, -RectDC.Top);

              if InvertedMode then
                BltMode := SRCINVERT
              else
                BltMode := SRCCOPY;
              begin
                bitblt(DC,
                  DestRect.Left, DestRect.Top,
                  DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top,
                  SourceBitmap.Canvas.Handle,
                  SrcRect.Left, SrcRect.Top, BltMode);
              end;
            end;
            CurLeft := CurLeft + SourceBitmap.Width;
          end;
          CurLeft := RectWindow.Left + RectDoc.Left;
          CurTop := CurTop + SourceBitmap.Height;
        end;
      end;
    bgtTopLeftBitmap,
    bgtCenterBitmap :
      begin
        FillSolidRect2(DC, TmpRect, ColorToRGB(FillColor));
        OffsetRect(TmpRect, -RectDC.Left, -RectDC.Top);

        if DrawMode = bgtCenterBitmap then
        begin
          CenterRects(SourceBitmap.Width, RectWindow.Right - RectWindow.Left,
            SourceBitmap.Height, RectWindow.Bottom - RectWindow.Top, SrcRect);
        end
        else
          SrcRect := Rect(0, 0, SourceBitmap.Width, SourceBitmap.Height);

        OffsetRect(SrcRect, RectWindow.Left, RectWindow.Top);

        IntersectRect(TmpRect, TmpRect, SrcRect);
        if not IsRectEmpty(TmpRect) then
        begin
          DestRect := TmpRect;
          OffsetRect(DestRect, -SrcRect.Left, -SrcRect.Top);
          SrcRect := DestRect;

          DestRect := TmpRect;
          OffsetRect(DestRect, -RectDC.Left, -RectDC.Top);


          if InvertedMode then
            BltMode := SRCINVERT
          else
            BltMode := SRCCOPY;
          begin
            bitblt(DC,
              DestRect.Left, DestRect.Top,
              DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top,
              SourceBitmap.Canvas.Handle,
              SrcRect.Left, SrcRect.Top, BltMode);
          end;
        end;
      end;
    bgtStretchBitmap :
      begin
        OffsetRect(TmpRect, -RectDC.Left, -RectDC.Top);
        HelpBmp := TBitmap.Create;
        HelpBmp.Width := RectWindow.Right - RectWindow.Left;
        HelpBmp.Height := RectWindow.Bottom - rectWindow.Top;
        SetStretchBltMode(HelpBmp.Canvas.Handle, COLORONCOLOR);
        stretchblt(HelpBmp.Canvas.Handle, 0, 0, HelpBmp.Width, HelpBmp.Height,
          SourceBitmap.Canvas.Handle, 0, 0, SourceBitmap.Width, SourceBitmap.Height, SRCCOPY);
        SrcRect := RectWindow;
        IntersectRect(TmpRect, TmpRect, SrcRect);
        if not IsRectEmpty(TmpRect) then
        begin
          SrcRect := TmpRect;
          OffsetRect(SrcRect, -RectWindow.Left, -RectWindow.Top);
          DestRect := TmpRect;
          OffsetRect(DestRect, -RectDC.Left, -RectDC.Top);
          if InvertedMode then
            BltMode := SRCINVERT
          else
            BltMode := SRCCOPY;
          begin
            bitblt(DC,
              DestRect.Left, DestRect.Top,
              DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top,
              HelpBmp.Canvas.Handle,
              SrcRect.Left, SrcRect.Top, BltMode);

          end;
          HelpBmp.Free;
        end;

      end;
  end;
end;

end.
