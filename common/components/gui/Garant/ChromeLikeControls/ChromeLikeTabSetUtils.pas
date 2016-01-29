unit ChromeLikeTabSetUtils;

interface


uses
  Windows, SysUtils, Controls, Classes, Graphics, Messages, ExtCtrls, Forms,
  GraphUtil, Math, GDIPObj, GDIPAPI, ImgList, ActiveX, ChromeLikeTabSetTypes;

 function IsPtInRect(const aPoint: TPoint; const aRect: TRect): Boolean;
 function MakeGDIPColor(aColor: TColor; aAlpha: Byte = 255): Cardinal;
 function SameRect(const aRect1: TRect; const aRect2: TRect): Boolean;
 function ColorBetween(aColorA: TColor; aColorB: TColor; aPercent: Integer): TColor;
 function IntegerBetween(aIntA: Integer;aIntB: Integer; aPercent: Integer): Integer;
 function SingleBetween(aSingA: Single; aSingB: Single; aPercent: Integer): Single;
 function ImageListToTGPImage(aImageList: TCustomImageList; aImageIndex: Integer): TGPImage;
 function RectToGPRectF(const aRect: TRect): TGPRectF;
 function RectToGPRect(const aRect: TRect): TGPRect;
 function GPRectToRect(const aRect: TGPRect): TRect;
 function PointToGPPoint(const aPt: TPoint): TGPPoint;
 function IconToGPImage(aIcon: TIcon): TGPImage;
 function BitmapToGPBitmap(aBitmap: TBitmap): TGPBitmap;
 procedure ClearBitmap(aBitmap: TBitmap);
 function ContrastingColor(Color: TColor): TColor;
 function RectHeight(Rect: TRect): Integer;
 function RectWidth(Rect: TRect): Integer;
 function RectInflate(const aRect: TRect;
                      aValue: Integer): TRect;
 procedure SetColorAlpha(aBitmap: TBitmap;
                         aColor: TColor;
                         aNewAlpha: Byte);
 function TransformRect(const aStartRect: TRect;
                        const aEndRect: TRect;
                        aCurrentTicks: Cardinal;
                        aEndTicks: Cardinal;
                        aEaseType: TChromeLikeTabEaseType): TRect;

 function CalculateEase(CurrentTime, StartValue, ChangeInValue, Duration: Real; EaseType: TChromeLikeTabEaseType): Real; overload;
 
 function CalculateEase(StartPos, EndPos, PositionPct: Real; EaseType: TChromeLikeTabEaseType): Real; overload;
 procedure ResetMouseControl;
 function PlaceRectInCenter(const aSize: TSize;
                            const aOuterRect: TRect;
                                  aLeftMargin: Integer;
                                  aTopMargin: Integer;
                                  aRightMargin: Integer;
                                  aBottomMargin: Integer): TRect;
 function MakeTSize(aCx: Integer; aCy: Integer): TSize;

implementation
uses
 Types, vtInterfaces, l3Memory;

function CalculateEase(CurrentTime, StartValue, ChangeInValue, Duration: Real; EaseType: TChromeLikeTabEaseType): Real;
begin
  case EaseType of
    ttNone:
      begin
        Result := 0;
      end;

    ttLinearTween:
      begin
        Result := ChangeInValue * CurrentTime / Duration + StartValue;
      end;

    ttEaseInQuad:
      begin
        CurrentTime := CurrentTime / Duration;

	      Result := ChangeInValue * CurrentTime * CurrentTime + StartValue;
      end;

    ttEaseOutQuad:
      begin
        CurrentTime := CurrentTime / Duration;

	      Result := -ChangeInValue * CurrentTime * (CurrentTime-2) + StartValue;
      end;

    ttEaseInOutQuad:
      begin
        CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := ChangeInValue / 2 * CurrentTime * CurrentTime + StartValue
        else
        begin
          CurrentTime := CurrentTime - 1;
          Result := -ChangeInValue / 2 * (CurrentTime * (CurrentTime - 2) - 1) + StartValue;
        end;
      end;

    ttEaseInCubic:
      begin
        CurrentTime := CurrentTime / Duration;

        Result := ChangeInValue * CurrentTime * CurrentTime * CurrentTime + StartValue;
      end;

    ttEaseOutCubic:
      begin
        CurrentTime := (CurrentTime / Duration) - 1;

        Result := ChangeInValue * ( CurrentTime * CurrentTime * CurrentTime + 1) + StartValue;
      end;

    ttEaseInOutCubic:
      begin
        CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := ChangeInValue / 2 * CurrentTime * CurrentTime * CurrentTime + StartValue
        else
        begin
          CurrentTime := CurrentTime - 2;

          Result := ChangeInValue / 2 * (CurrentTime * CurrentTime * CurrentTime + 2) + StartValue;
        end;
      end;

    ttEaseInQuart:
      begin
        CurrentTime := CurrentTime / Duration;

        Result := ChangeInValue * CurrentTime * CurrentTime * CurrentTime * CurrentTime + StartValue;
      end;

    ttEaseOutQuart:
      begin
        CurrentTime := (CurrentTime / Duration) - 1;

        Result := -ChangeInValue * (CurrentTime * CurrentTime * CurrentTime * CurrentTime - 1) + StartValue;
      end;

    ttEaseInOutQuart:
      begin
	      CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := ChangeInValue / 2 * CurrentTime * CurrentTime * CurrentTime * CurrentTime + StartValue
        else
        begin
          CurrentTime := CurrentTime - 2;

          Result := -ChangeInValue / 2 * (CurrentTime * CurrentTime * CurrentTime * CurrentTime - 2) + StartValue;
        end;
      end;

    ttEaseInQuint:
      begin
        CurrentTime := CurrentTime / Duration;

        Result := ChangeInValue * CurrentTime * CurrentTime * CurrentTime * CurrentTime * CurrentTime + StartValue;
      end;

    ttEaseOutQuint:
      begin
        CurrentTime := (CurrentTime / Duration) - 1;

	      Result := ChangeInValue * (CurrentTime * CurrentTime * CurrentTime * CurrentTime * CurrentTime + 1) + StartValue;
      end;

    ttEaseInOutQuint:
      begin
      	CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := ChangeInValue / 2 * CurrentTime * CurrentTime * CurrentTime * CurrentTime * CurrentTime + StartValue
        else
        begin
          CurrentTime := CurrentTime - 2;

          Result := ChangeInValue / 2 * (CurrentTime * CurrentTime * CurrentTime * CurrentTime * CurrentTime + 2) + StartValue;
        end;
      end;

    ttEaseInSine:
      begin
	      Result := -ChangeInValue * Cos(CurrentTime / Duration * (PI / 2)) + ChangeInValue + StartValue;
      end;

    ttEaseOutSine:
      begin
	      Result := ChangeInValue * Sin(CurrentTime / Duration * (PI / 2)) + StartValue;
      end;

    ttEaseInOutSine:
      begin
        Result := -ChangeInValue / 2 * (Cos(PI * CurrentTime / Duration) - 1) + StartValue;
      end;

    ttEaseInExpo:
      begin
        Result := ChangeInValue * Power(2, 10 * (CurrentTime / Duration - 1) ) + StartValue;
      end;

    ttEaseOutExpo:
      begin
        Result := ChangeInValue * (-Power(2, -10 * CurrentTime / Duration ) + 1 ) + StartValue;
      end;

    ttEaseInOutExpo:
      begin
        CurrentTime := CurrentTime / (Duration/2);

	      if CurrentTime < 1 then
          Result := ChangeInValue / 2 * Power(2, 10 * (CurrentTime - 1) ) + StartValue
        else
         begin
           CurrentTime := CurrentTime - 1;

	         Result := ChangeInValue / 2 * (-Power(2, -10 * CurrentTime) + 2 ) + StartValue;
         end;
      end;

    ttEaseInCirc:
      begin
        CurrentTime := CurrentTime / Duration;

	      Result := -ChangeInValue * (Sqrt(1 - CurrentTime * CurrentTime) - 1) + StartValue;
      end;

    ttEaseOutCirc:
      begin
        CurrentTime := (CurrentTime / Duration) - 1;

        Result := ChangeInValue * Sqrt(1 - CurrentTime * CurrentTime) + StartValue;
      end;

    ttEaseInOutCirc:
      begin
        CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := -ChangeInValue / 2 * (Sqrt(1 - CurrentTime * CurrentTime) - 1) + StartValue
        else
        begin
        	CurrentTime := CurrentTime - 2;

	        Result := ChangeInValue / 2 * (Sqrt(1 - CurrentTime * CurrentTime) + 1) + StartValue;
        end;
      end;
    else
    begin
      Result := 0;

      Assert(FALSE, 'Invalid Ease Type');
    end;
  end;
end;

function CalculateEase(StartPos, EndPos, PositionPct: Real; EaseType: TChromeLikeTabEaseType): Real;
var
  t, b, c, d: Real;
begin
  c := EndPos - StartPos;
  d := 100;
  t := PositionPct;
  b := StartPos;

  Result := CalculateEase(t, b, c, d, EaseType);
end;

function TransformRect(const aStartRect: TRect;
                       const aEndRect: TRect;
                       aCurrentTicks: Cardinal;
                       aEndTicks: Cardinal;
                       aEaseType: TChromeLikeTabEaseType): TRect;

  function TransformInteger(aStartInt: Integer; aEndInt: Integer): Integer;
  begin
    TransformInteger := Round(CalculateEase(aCurrentTicks, aStartInt, aEndInt - aStartInt, aEndTicks, aEaseType));
  end;

begin
  Result.Left := TransformInteger(aStartRect.Left, aEndRect.Left);
  Result.Top := TransformInteger(aStartRect.Top, aEndRect.Top);
  Result.Right := TransformInteger(aStartRect.Right, aEndRect.Right);
  Result.Bottom := TransformInteger(aStartRect.Bottom, aEndRect.Bottom);
end;

function ContrastingColor(Color: TColor): TColor;
begin
  Color := ColorToRGB(Color);

  Result := (Color+$000080) and $0000FF +
            (Color+$008000) and $00FF00 +
            (Color+$800000) and $FF0000;
end;

function RectHeight(Rect: TRect): Integer;
begin
  Result := Rect.Bottom - Rect.Top;
end;

function RectWidth(Rect: TRect): Integer;
begin
  Result := Rect.Right - Rect.Left;
end;

procedure ClearBitmap(aBitmap: TBitmap);
var
 l_Graphics: TGPGraphics;
 l_Brush: TGPBrush;
 l_Color: TGPColor;
begin
 l_Graphics := TGPGraphics.Create(aBitmap.Handle);
 try
  l_Color := MakeGDIPColor(clBlack, 0);
  l_Brush := TGPLinearGradientBrush.Create(MakePoint(0, 0),
                                           MakePoint(0, aBitmap.Height),
                                           l_Color,
                                           l_Color);
  try
   l_Graphics.FillRectangle(l_Brush, 0, 0, aBitmap.Width, aBitmap.Height);
  finally
   FreeAndNil(l_Brush);
  end;
 finally
  FreeAndNil(l_Graphics);
 end;
end;

function RectInflate(const aRect: TRect; aValue: Integer): TRect;
begin
 Result := Rect(aRect.Left + aValue,
                aRect.Top + aValue,
                aRect.Right - aValue,
                aRect.Bottom - aValue);
end;

function RectToGPRectF(const aRect: TRect): TGPRectF;
begin
 Result.X := aRect.Left;
 Result.Y := aRect.Top;
 Result.Width := RectWidth(aRect);
 Result.Height := RectHeight(aRect);
end;

function RectToGPRect(const ARect: TRect): TGPRect;
begin
 Result.X := aRect.Left;
 Result.Y := aRect.Top;
 Result.Width := RectWidth(aRect);
 Result.Height := RectHeight(aRect);
end;

function GPRectToRect(const aRect: TGPRect): TRect;
begin
 Result.Left := aRect.X;
 Result.Top := aRect.Y;
 Result.Right := aRect.X + aRect.Width;
 Result.Bottom := aRect.Y + aRect.Height;
end;

function PointToGPPoint(const aPt: TPoint): TGPPoint;
begin
 Result.X := aPt.X;
 Result.Y := aPt.Y;
end;

function IconToGPImage(aIcon: TIcon): TGPImage;
var
 l_MemStream: Tl3MemoryStream;
begin
 l_MemStream := Tl3MemoryStream.Create;
 try
  aIcon.SaveToStream(l_MemStream);
  l_MemStream.Position := 0;
  Result := TGPImage.Create(l_MemStream);
 finally
  FreeAndNil(l_MemStream);
 end;
end;

function BitmapToGPBitmap(aBitmap: TBitmap): TGPBitmap;
var
 l_MemStream: Tl3MemoryStream;
begin
 l_MemStream := Tl3MemoryStream.Create;
 try
  aBitmap.SaveToStream(l_MemStream);
  l_MemStream.Position := 0;
  Result := TGPBitmap.Create(l_MemStream);
 finally
  FreeAndNil(l_MemStream);
 end;
end;

function ImageListToTGPImage(aImageList: TCustomImageList; aImageIndex: Integer): TGPImage;
var
 l_ImageList: IvtFlashImageList;
 l_MemStream: Tl3MemoryStream;
begin
 if Supports(aImageList, IvtFlashImageList, l_ImageList) then
 try
  l_MemStream := Tl3MemoryStream.Create;
  try
   l_ImageList.SaveImageToStream(l_MemStream, aImageIndex, bpp24);
   l_MemStream.Position := 0;
   Result := TGPBitmap.Create(l_MemStream, True);
  finally
   FreeAndNil(l_MemStream);
  end;
 finally
  l_ImageList := nil;
 end;
end;

function IntegerBetween(aIntA: Integer; aIntB: Integer; aPercent: Integer): Integer;
begin
  Result := aPercent * (aIntB - aIntA) div 100 + aIntA;
end;

function SingleBetween(aSingA: Single; aSingB: Single; aPercent: Integer): Single;
begin
  Result := aPercent * (aSingB - aSingA) / 100 + aSingA;
end;

function ColorBetween(aColorA: TColor; aColorB: TColor; aPercent: Integer): TColor;
var
  l_R1: Byte;
  l_G1: Byte;
  l_B1: Byte;
  l_R2: Byte;
  l_G2: Byte;
  l_B2: Byte;
begin
  l_R1:= GetRValue(aColorA);
  l_G1:= GetGValue(aColorA);
  l_B1:= GetBValue(aColorA);
  l_R2:= GetRValue(aColorB);
  l_G2:= GetGValue(aColorB);
  l_B2:= GetBValue(aColorB);

  Result:= RGB(aPercent * (l_R2 - l_R1) div 100 + l_R1,
               aPercent * (l_G2 - l_G1) div 100 + l_G1,
               aPercent * (l_B2 - l_B1) div 100 + l_B1);
end;

function SameRect(const aRect1: TRect; const aRect2: TRect): Boolean;
begin
  Result := (aRect1.Left = aRect2.Left) and
            (aRect1.Top = aRect2.Top) and
            (aRect1.Right = aRect2.Right) and
            (aRect1.Bottom = aRect2.Bottom);
end;

function IsPtInRect(const aPoint: TPoint; const aRect: TRect): Boolean;
begin
 Result := (aPoint.X >= aRect.Left) and (aPoint.Y >= aRect.Top) and
           (aPoint.X <= aRect.Right) and (aPoint.Y <= aRect.Bottom);   
end;

function MakeGDIPColor(aColor: TColor; aAlpha: Byte = 255): Cardinal;
var
 l_tmpRGB : TColorRef;
begin
 l_tmpRGB := ColorToRGB(aColor);

 Result := ((DWORD(GetBValue(l_tmpRGB)) shl  BlueShift) or
            (DWORD(GetGValue(l_tmpRGB)) shl GreenShift) or
            (DWORD(GetRValue(l_tmpRGB)) shl   RedShift) or
            (DWORD(aAlpha) shl AlphaShift));
end;

procedure SetColorAlpha(aBitmap: TBitmap; aColor: TColor; aNewAlpha: Byte);
var
 l_Row, l_Col: Integer;
 l_p: PRGBQuad;
 l_PreMult: array[byte, byte] of byte;
begin
 // precalculate all possible values of a*b
 for l_Row := 0 to 255 do
   for l_Col := l_Row to 255 do
   begin
     l_PreMult[l_Row, l_Col] := l_Row * l_Col div 255;
      if (l_Row <> l_Col) then
       l_PreMult[l_Col, l_Row] := l_PreMult[l_Row, l_Col]; // a*b = b*a
   end;

 for l_Row := 0 to Pred(aBitmap.Height) do
 begin
  l_Col := aBitmap.Width;
  l_p := aBitmap.ScanLine[l_Row];
  while (l_Col > 0) do
  begin
   if (GetRed(aColor) = l_p.rgbRed) and
      (GetBlue(aColor) = l_p.rgbBlue) and
      (GetGreen(aColor) = l_p.rgbGreen) then
   begin
    l_p.rgbReserved := aNewAlpha;
    l_p.rgbBlue := l_PreMult[l_p.rgbReserved, l_p.rgbBlue];
    l_p.rgbGreen := l_PreMult[l_p.rgbReserved, l_p.rgbGreen];
    l_p.rgbRed := l_PreMult[l_p.rgbReserved, l_p.rgbRed];
   end;
   Inc(l_p);
   Dec(l_Col);
  end;
 end;
end;

type
 THackApplication = class(TComponent)
 private
  FHandle: HWnd;
  FBiDiMode: TBiDiMode;
  FBiDiKeyboard: string;
  FNonBiDiKeyboard: string;
  FObjectInstance: Pointer;
  FMainForm: TForm;
  FMouseControl: TControl;
 end;

procedure ResetMouseControl;
begin
 THackApplication(Application).FMouseControl := nil;
end;

function PlaceRectInCenter(const aSize: TSize;
                           const aOuterRect: TRect;
                                 aLeftMargin: Integer;
                                 aTopMargin: Integer;
                                 aRightMargin: Integer;
                                 aBottomMargin: Integer): TRect;
var
 l_Rect: TRect;
 l_RectCenter: TPoint;
 l_Offsets: TSize;
begin
 l_Rect := aOuterRect;
 Inc(l_Rect.Left, aLeftMargin);
 Inc(l_Rect.Top, aTopMargin);
 Dec(l_Rect.Right, aRightMargin);
 Dec(l_Rect.Bottom, aBottomMargin);
 l_RectCenter := CenterPoint(l_Rect);
 l_Offsets.cx := aSize.cx div 2;
 l_Offsets.cy := aSize.cy div 2;
 with Result do
 begin
  TopLeft := Point(l_RectCenter.X - l_Offsets.cx,
                   l_RectCenter.Y - l_Offsets.cy);
  BottomRight := Point(l_RectCenter.X + l_Offsets.cx,
                       l_RectCenter.Y + l_Offsets.cy);
 end;
end;

function MakeTSize(aCx: Integer; aCy: Integer): TSize;
begin
 Result.cx := aCx;
 Result.cy := aCy;
end;



end.
