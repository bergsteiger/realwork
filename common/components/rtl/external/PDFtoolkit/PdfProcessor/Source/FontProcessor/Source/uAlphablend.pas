// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in compliance
// with the License. You may obtain a copy of the License at http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for the
// specific language governing rights and limitations under the License.
//
// The original code is VirtualTrees.pas, released November 1, 1999.
//
// The initial developer of the original code is Dipl. Ing. Mike Lischke (Pleiﬂa, Germany, www.delphi-gems.com),
//
// Portions created by Dipl. Ing. Mike Lischke are
// Copyright (C) 1999-2003 Dipl. Ing. Mike Lischke. All Rights Reserved.
// Pascal Translation of mmx routines
// Portions created by Soeren Muehlbauer are
// Copyright (C) 2004 Soeren Muehlbauer. All Rights Reserved.
//----------------------------------------------------------------------------------------------------------------------
unit uAlphablend;

interface

uses
  Windows, Graphics;

type
  // Describes the mode how to blend pixels.
  TBlendMode = (
    bmConstantAlpha,         // apply given constant alpha
    bmPerPixelAlpha,         // use alpha value of the source pixel
    bmMasterAlpha,           // use alpha value of source pixel and multiply it with the constant alpha value
    bmConstantAlphaAndColor  // blend the destination color with the given constant color und the constant alpha value
  );

procedure _AlphaBlend(Source, Destination: HDC; R: TRect; Target: TPoint; Mode: TBlendMode; ConstantAlpha, Bias: Integer);
function _GetBitmapBitsFromDeviceContext(DC: HDC; var Width, Height: Integer): Pointer;

implementation

type
  PBGRA = ^TBGRA;
  TBGRA = packed record
    case Boolean of
      False:
        (Color: Cardinal);
      True:
        (BGR: array[0..2] of Byte;
         Alpha: Byte);
  end;

function _GetBitmapBitsFromDeviceContext(DC: HDC; var Width, Height: Integer): Pointer;

// Helper function used to retrieve the bitmap selected into the given device context. If there is a bitmap then
// the function will return a pointer to its bits otherwise nil is returned.
// Additionally the dimensions of the bitmap are returned.

var
  Bitmap: HBITMAP;
  DIB: TDIBSection;

begin
  Result := nil;
  Width := 0;
  Height := 0;

  Bitmap := GetCurrentObject(DC, OBJ_BITMAP);
  if Bitmap <> 0 then
  begin
    if GetObject(Bitmap, SizeOf(DIB), @DIB) = SizeOf(DIB) then
    begin
      Result := DIB.dsBm.bmBits;
      Width := DIB.dsBmih.biWidth;
      Height := DIB.dsBmih.biHeight;
    end;
  end;
end;

function CalculateScanline(Bits: Pointer; Width, Height, Row: Integer): Pointer;

// Helper function to calculate the start address for the given row.

begin
  if Height > 0 then  // bottom-up DIB
    Row := Height - Row - 1;
  // Return DWORD aligned address of the requested scanline.
  Integer(Result) := Integer(Bits) + Row * ((Width * 32 + 31) and not 31) div 8;
end;

procedure AlphaBlendLineConstantPas(Source, Destination: Pointer; Count: Integer; ConstantAlpha, Bias: Integer);
var
  I: Integer;
  lSource,
  lTarget: PBGRA;
begin
  lSource := PBGRA(Source);
  lTarget := PBGRA(Destination);
  for I := 0 to Count - 1 do    // Iterate
  begin
    lTarget.BGR[0] := ((ConstantAlpha * (lSource.BGR[0] - lTarget.BGR[0]) + 256 * lTarget.BGR[0]) div 256) + Bias;
    lTarget.BGR[1] := ((ConstantAlpha * (lSource.BGR[1] - lTarget.BGR[1]) + 256 * lTarget.BGR[1]) div 256) + Bias;
    lTarget.BGR[2] := ((ConstantAlpha * (lSource.BGR[2] - lTarget.BGR[2]) + 256 * lTarget.BGR[2]) div 256) + Bias;
    Inc(lSource);
    Inc(lTarget);
  end;    // for
end;

procedure AlphaBlendLinePerPixelPas(Source, Destination: Pointer; Count, Bias: Integer);
var
  I: Integer;
  lSource,
  lTarget: PBGRA;
begin
  lSource := PBGRA(Source);
  lTarget := PBGRA(Destination);
  for I := 0 to Count - 1 do    // Iterate
  begin
    lTarget.BGR[0] := ((lSource.Alpha * (lSource.BGR[0] - lTarget.BGR[0]) + 256 * lTarget.BGR[0]) div 256) + Bias;
    lTarget.BGR[1] := ((lSource.Alpha * (lSource.BGR[1] - lTarget.BGR[1]) + 256 * lTarget.BGR[1]) div 256) + Bias;
    lTarget.BGR[2] := ((lSource.Alpha * (lSource.BGR[2] - lTarget.BGR[2]) + 256 * lTarget.BGR[2]) div 256) + Bias;
    Inc(lSource);
    Inc(lTarget);
  end;    // for
end;

procedure AlphaBlendLineMasterPas(Source, Destination: Pointer; Count: Integer; ConstantAlpha, Bias: Integer);
var
  I: Integer;
  lSource,
  lTarget: PBGRA;
  lAlpha: Integer;
begin
  lSource := PBGRA(Source);
  lTarget := PBGRA(Destination);
  for I := 0 to Count - 1 do    // Iterate
  begin
    lAlpha := (lSource.Alpha * ConstantAlpha) div 256;
    lTarget.BGR[0] := ((lAlpha * (lSource.BGR[0] - lTarget.BGR[0]) + 256 * lTarget.BGR[0]) div 256) + Bias;
    lTarget.BGR[1] := ((lAlpha * (lSource.BGR[1] - lTarget.BGR[1]) + 256 * lTarget.BGR[1]) div 256) + Bias;
    lTarget.BGR[2] := ((lAlpha * (lSource.BGR[2] - lTarget.BGR[2]) + 256 * lTarget.BGR[2]) div 256) + Bias;
    //lTarget.Color := lTarget.Color + Bias;
    Inc(lSource);
    Inc(lTarget);
  end;    // for
end;

procedure AlphaBlendLineMasterAndColorPas(Destination: Pointer; Count: Integer; ConstantAlpha, Color: Integer);
var
  I: Integer;
  lTarget: PBGRA;
  lFactor: TBGRA;
begin
  lTarget := PBGRA(Destination);
  lFactor.Color := Color;
  lFactor.BGR[0] := lFactor.BGR[0] * ConstantAlpha;
  lFactor.BGR[1] := lFactor.BGR[1] * ConstantAlpha;
  lFactor.BGR[2] := lFactor.BGR[2] * ConstantAlpha;
  lFactor.Alpha := 256 - ConstantAlpha;
  for I := 0 to Count - 1 do    // Iterate
  begin
    lTarget.BGR[0] := (lFactor.BGR[0] + lFactor.Alpha * lTarget.BGR[0]) div 256;
    lTarget.BGR[1] := (lFactor.BGR[1] + lFactor.Alpha * lTarget.BGR[1]) div 256;
    lTarget.BGR[2] := (lFactor.BGR[2] + lFactor.Alpha * lTarget.BGR[2]) div 256;
    Inc(lTarget);
  end;    // for
end;

procedure _AlphaBlend(Source, Destination: HDC; R: TRect; Target: TPoint; Mode: TBlendMode; ConstantAlpha, Bias: Integer);
var
  Y: Integer;
  SourceRun,
  TargetRun: PByte;

  SourceBits,
  DestBits: Pointer;
  SourceWidth,
  SourceHeight,
  DestWidth,
  DestHeight: Integer;

begin
  if not IsRectEmpty(R) then
  begin
    case Mode of
      bmConstantAlpha:
        begin
          SourceBits := _GetBitmapBitsFromDeviceContext(Source, SourceWidth, SourceHeight);
          DestBits := _GetBitmapBitsFromDeviceContext(Destination, DestWidth, DestHeight);
          if Assigned(SourceBits) and Assigned(DestBits) then
          begin
            for Y := 0 to R.Bottom - R.Top - 1 do
            begin
              SourceRun := CalculateScanline(SourceBits, SourceWidth, SourceHeight, Y + R.Top);
              Inc(SourceRun, 4 * R.Left);
              TargetRun := CalculateScanline(DestBits, DestWidth, DestHeight, Y + Target.Y);
              Inc(TargetRun, 4 * Target.X);
              AlphaBlendLineConstantPas(SourceRun, TargetRun, R.Right - R.Left, ConstantAlpha, Bias);
            end;
          end;
        end;
      bmPerPixelAlpha:
        begin
          SourceBits := _GetBitmapBitsFromDeviceContext(Source, SourceWidth, SourceHeight);
          DestBits := _GetBitmapBitsFromDeviceContext(Destination, DestWidth, DestHeight);
          if Assigned(SourceBits) and Assigned(DestBits) then
          begin
            for Y := 0 to R.Bottom - R.Top - 1 do
            begin
              SourceRun := CalculateScanline(SourceBits, SourceWidth, SourceHeight, Y + R.Top);
              Inc(SourceRun, 4 * R.Left);
              TargetRun := CalculateScanline(DestBits, DestWidth, DestHeight, Y + Target.Y);
              Inc(TargetRun, 4 * Target.X);
              AlphaBlendLinePerPixelPas(SourceRun, TargetRun, R.Right - R.Left, Bias);
            end;
          end;
        end;
      bmMasterAlpha:
        begin
          SourceBits := _GetBitmapBitsFromDeviceContext(Source, SourceWidth, SourceHeight);
          DestBits := _GetBitmapBitsFromDeviceContext(Destination, DestWidth, DestHeight);
          if Assigned(SourceBits) and Assigned(DestBits) then
          begin
            for Y := 0 to R.Bottom - R.Top - 1 do
            begin
              SourceRun := CalculateScanline(SourceBits, SourceWidth, SourceHeight, Y + R.Top);
              Inc(SourceRun, 4 * Target.X);
              TargetRun := CalculateScanline(DestBits, DestWidth, DestHeight, Y + Target.Y);
              AlphaBlendLineMasterPas(SourceRun, TargetRun, R.Right - R.Left, ConstantAlpha, Bias)
            end;
          end;
        end;
      bmConstantAlphaAndColor:
        begin
          // Source is ignore since there is a constant color value.
          DestBits := _GetBitmapBitsFromDeviceContext(Destination, DestWidth, DestHeight);
          if Assigned(DestBits) then
          begin
            for Y := 0 to R.Bottom - R.Top - 1 do
            begin
              TargetRun := CalculateScanline(DestBits, DestWidth, DestHeight, Y + R.Top);
              Inc(TargetRun, 4 * R.Left);
              AlphaBlendLineMasterAndColorPas(TargetRun, R.Right - R.Left, ConstantAlpha, Bias);
            end;
          end;
        end;
    end;
  end;
end;


end.
