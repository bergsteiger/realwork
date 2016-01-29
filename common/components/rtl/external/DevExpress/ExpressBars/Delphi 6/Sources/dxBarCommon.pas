
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars common                                          }
{                                                                   }
{       Copyright (c) 1998-2001 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxBarCommon;

interface

uses
  Windows, dxCommon, dxBar;

procedure DrawCloseButton(DC: HDC; var ARect: TRect; Selected, Pressed, Flat: Boolean;
  ACorner: TdxCorner);

procedure dxBarPopupNCCalcSize(Handle: HWND; var ARect: TRect;
  var Corner: TdxCorner; Combo: TdxBarItem; AllowResizing: Boolean);
procedure dxBarPopupNCPaint(Handle: HWND; AllowResizing, Flat,
  MouseAboveCloseButton, CloseButtonIsTracking: Boolean;
  var CloseButtonRect, GripRect: TRect; Corner: TdxCorner);

implementation

uses
  Classes;

procedure DrawCloseButton(DC: HDC; var ARect: TRect; Selected, Pressed, Flat: Boolean;
  ACorner: TdxCorner);
const
  Borders: array[Boolean] of Longint = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  States: array[Boolean] of Longint = (0, DFCS_PUSHED);
var
  Delta, SX, SY: Integer;
  Rgn1, Rgn2: HRGN;
  ClipRgnExists: Boolean;
begin
  SX := GetSystemMetrics(SM_CXSIZE);
  Delta := 1;//Byte(SX = 18);
  SY := GetSystemMetrics(SM_CXSIZE) + Delta;
  with ARect do
  begin
    if ACorner in [coTopRight, coBottomRight] then
      Right := Left + SX
    else
      Left := Right - SX;
    Top := (Top + Bottom - SY) div 2;
    if ACorner in [coBottomLeft, coBottomRight] then Inc(Top, Delta);
    Bottom := Top + SY;
  end;
  InflateRect(ARect, -1, -2);
  if Selected and not Flat then
    DrawEdge(DC, ARect, Borders[Pressed], BF_RECT)
  else
    FrameRect(DC, ARect, GetSysColorBrush(COLOR_BTNFACE));
  InflateRect(ARect, -1, -1);
  FrameRect(DC, ARect, GetSysColorBrush(COLOR_BTNFACE));

  Rgn1 := CreateRectRgn(0, 0, 0, 0);
  ClipRgnExists := GetClipRgn(DC, Rgn1) = 1;
  with ARect do
    Rgn2 := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
  SelectClipRgn(DC, Rgn2);
  DeleteObject(Rgn2);
  InflateRect(ARect, 1, 1);
  if SX <> 22 then Inc(ARect.Top, Delta);
  DrawFrameControl(DC, ARect, DFC_CAPTION,
    DFCS_CAPTIONCLOSE or DFCS_FLAT or States[Pressed and not Flat]);
  if SX <> 22 then Dec(ARect.Top, Delta);
  if ClipRgnExists then
    SelectClipRgn(DC, Rgn1)
  else
    SelectClipRgn(DC, 0);
  DeleteObject(Rgn1);
end;

procedure dxBarPopupNCCalcSize(Handle: HWND; var ARect: TRect;
  var Corner: TdxCorner; Combo: TdxBarItem; AllowResizing: Boolean);
var
  R: TRect;
  AControl: TdxBarWinControl;
begin
  InflateRect(ARect, -1, -1);
  if AllowResizing and
    (Combo.CurItemLink <> nil) and (Combo.CurItemLink.Control <> nil) then
  begin
    GetWindowRect(Handle, R);
    AControl := TdxBarWinControl(Combo.CurItemLink.Control);
    MapWindowPoints(0, AControl.Parent.Handle, R, 2);
    Corner := GetCornerForRects(AControl.WindowRect, R);
    with ARect do
      if Corner in [coBottomLeft, coBottomRight] then
        Dec(Bottom, dxDropDownNCHeight)
      else
        Inc(Top, dxDropDownNCHeight);
  end;
end;

procedure dxBarPopupNCPaint(Handle: HWND; AllowResizing, Flat,
  MouseAboveCloseButton, CloseButtonIsTracking: Boolean;
  var CloseButtonRect, GripRect: TRect; Corner: TdxCorner);
var
  R, CR: TRect;
  B: Integer;
  BorderBrush: HBRUSH;
  DC: HDC;
  AStyle: Longint;
begin
  DC := GetWindowDC(Handle);
  try
    GetWindowRect(Handle, R);
    CloseButtonRect := R;
    GripRect := R;
    GetClientRect(Handle, CR);
    MapWindowPoints(0, Handle, R, 2);
    B := -R.Left;
    OffsetRect(CR, -R.Left, -R.Top);
    OffsetRect(R, -R.Left, -R.Top);

    if Flat then
      BorderBrush := COLOR_BTNSHADOW
    else
      BorderBrush := COLOR_WINDOWFRAME;
    BorderBrush := GetSysColorBrush(BorderBrush);

    FrameRect(DC, R, BorderBrush);

    if not AllowResizing then
    begin
      SetRectEmpty(CloseButtonRect);
      SetRectEmpty(GripRect);
      Exit;
    end;

    InflateRect(R, -B, -B);
    if Corner in [coBottomLeft, coBottomRight] then
    begin
      R.Top := R.Bottom - dxDropDownNCHeight + 1;
      FillRect(DC, Rect(R.Left, R.Top - 1, R.Right, R.Top), BorderBrush);
    end
    else
    begin
      R.Bottom := R.Top + dxDropDownNCHeight - 1;
      FillRect(DC, Rect(R.Left, R.Bottom, R.Right, R.Bottom + 1), BorderBrush);
    end;

    CR := R;
    DrawSizeGrip(DC, CR, Corner);
    with CR do
      ExcludeClipRect(DC, Left, Top, Right, Bottom);
    InflateRect(CR, 2, 2);
    if CR.Top < R.Top then CR.Top := R.Top;
    if CR.Bottom > R.Bottom then CR.Bottom := R.Bottom;
    OffsetRect(CR, GripRect.Left, GripRect.Top);
    GripRect := CR;

    CR := R;
    DrawCloseButton(DC, CR, MouseAboveCloseButton or CloseButtonIsTracking,
      MouseAboveCloseButton and CloseButtonIsTracking, Flat, Corner);
    with CR do
      ExcludeClipRect(DC, Left, Top, Right, Bottom);
    with CloseButtonRect do OffsetRect(CR, Left, Top);
    CloseButtonRect := CR;

    FillRect(DC, R, COLOR_BTNFACE + 1);
    if Corner in [coBottomLeft, coBottomRight] then
    begin
      AStyle := GetWindowLong(Handle, GWL_STYLE);
      if (AStyle and WS_HSCROLL <> 0) and (AStyle and WS_VSCROLL <> 0) then
        with R do
        begin
          Left := Right - GetSystemMetrics(SM_CXVSCROLL);
          Bottom := Top - 1;
          Top := Bottom - GetSystemMetrics(SM_CYHSCROLL);
          FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
        end;
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

end.
