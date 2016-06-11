{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Surfaces;

interface

{$SCOPEDENUMS ON}

uses
  System.UITypes, System.Generics.Collections, System.Classes, FMX.Types;

type
  TBitmapSurface = class(TPersistent)
  private
    FBits: Pointer;
    FPitch: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FPixelFormat: TPixelFormat;
    FBytesPerPixel: Integer;

    function GetScanline(const Index: Integer): Pointer;
    function GetPixel(const X, Y: Integer): TAlphaColor;
    procedure SetPixel(const X, Y: Integer; const Value: TAlphaColor);

    class procedure SwapColors(var Color1, Color2: TAlphaColor); overload; static; inline;
    procedure SwapColors(const X1, Y1, X2, Y2: Integer); overload; inline;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;

    function GetPixelAddr(const X, Y: Integer): Pointer;
    procedure Clear(const Color: TAlphaColor);
    procedure SetSize(const AWidth, AHeight: Integer; const APixelFormat: TPixelFormat = TPixelFormat.None);
    procedure StretchFrom(const Source: TBitmapSurface; const NewWidth, NewHeight: Integer;
      APixelFormat: TPixelFormat = TPixelFormat.None);
    procedure Mirror;
    procedure Flip;
    procedure Rotate90;
    /// <summary>Rotates bitmap on 90 degress by clockwise</summary>
    procedure Rotate180;
    /// <summary>Rotates bitmap on 270 degress by clockwise</summary>
    procedure Rotate270;

    property Bits: Pointer read FBits;
    property Pitch: Integer read FPitch;
    property Width: Integer read FWidth;
    property Height: Integer read FHeight;
    property PixelFormat: TPixelFormat read FPixelFormat;
    property BytesPerPixel: Integer read FBytesPerPixel;
    property Scanline[const Index: Integer]: Pointer read GetScanline;
    property Pixels[const X, Y: Integer]: TAlphaColor read GetPixel write SetPixel;
  end;

  TMipmapSurface = class(TBitmapSurface)
  private type
    TMipmapSurfaces = TObjectList<TMipmapSurface>;
  private
    FChildMipmaps: TMipmapSurfaces;

    function GetMipCount: Integer;
    function GetMip(const MipIndex: Integer): TMipmapSurface;
  protected
    procedure StretchHalfFrom(const Source: TMipmapSurface);
  public
    constructor Create;
    destructor Destroy; override;

    procedure GenerateMips;
    procedure ClearMips;

    property MipCount: Integer read GetMipCount;
    property Mip[const MipIndex: Integer]: TMipmapSurface read GetMip;
  end;

implementation

uses
  System.SysUtils, System.RTLConsts, System.Math;

function ComputePixelAverage2(Color1, Color2: TAlphaColor): TAlphaColor;
begin
  TAlphaColorRec(Result).R := (Integer(TAlphaColorRec(Color1).R) + TAlphaColorRec(Color2).R) div 2;
  TAlphaColorRec(Result).G := (Integer(TAlphaColorRec(Color1).G) + TAlphaColorRec(Color2).G) div 2;
  TAlphaColorRec(Result).B := (Integer(TAlphaColorRec(Color1).B) + TAlphaColorRec(Color2).B) div 2;
  TAlphaColorRec(Result).A := (Integer(TAlphaColorRec(Color1).A) + TAlphaColorRec(Color2).A) div 2;
end;

function ComputePixelAverage4(Color1, Color2, Color3, Color4: TAlphaColor): TAlphaColor;
begin
  TAlphaColorRec(Result).R := (Integer(TAlphaColorRec(Color1).R) + TAlphaColorRec(Color2).R + TAlphaColorRec(Color3).R +
    TAlphaColorRec(Color4).R) div 4;
  TAlphaColorRec(Result).G := (Integer(TAlphaColorRec(Color1).G) + TAlphaColorRec(Color2).G + TAlphaColorRec(Color3).G +
    TAlphaColorRec(Color4).G) div 4;
  TAlphaColorRec(Result).B := (Integer(TAlphaColorRec(Color1).B) + TAlphaColorRec(Color2).B + TAlphaColorRec(Color3).B +
    TAlphaColorRec(Color4).B) div 4;
  TAlphaColorRec(Result).A := (Integer(TAlphaColorRec(Color1).A) + TAlphaColorRec(Color2).A + TAlphaColorRec(Color3).A +
    TAlphaColorRec(Color4).A) div 4;
end;

constructor TBitmapSurface.Create;
begin
  inherited;

  FBits := nil;
  FPitch := 0;
  FWidth := 0;
  FHeight := 0;
  FPixelFormat := TPixelFormat.None;
  FBytesPerPixel := 0;
end;

destructor TBitmapSurface.Destroy;
begin
  if FBits <> nil then
  begin
    FreeMem(FBits);
    FBits := nil;
  end;

  inherited;
end;

function TBitmapSurface.GetScanline(const Index: Integer): Pointer;
begin
  if (Index >= 0) and (Index < FHeight) then
    Result := Pointer(NativeInt(FBits) + (NativeInt(FPitch) * Index))
  else
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
end;

function TBitmapSurface.GetPixel(const X, Y: Integer): TAlphaColor;
var
  SrcPtr: Pointer;
begin
  if (X < 0) or (Y < 0) or (X >= FWidth) or (Y >= FHeight) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);

  if FPixelFormat <> TPixelFormat.None then
  begin
    SrcPtr := Pointer(NativeInt(FBits) + NativeInt(FPitch) * Y + NativeInt(X) * PixelFormatBytes[FPixelFormat]);
    Result := PixelToAlphaColor(SrcPtr, FPixelFormat);
  end
  else
    Result := 0;
end;

procedure TBitmapSurface.SetPixel(const X, Y: Integer; const Value: TAlphaColor);
var
  DestPtr: Pointer;
begin
  if (X < 0) or (Y < 0) or (X >= FWidth) or (Y >= FHeight) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);

  if FPixelFormat <> TPixelFormat.None then
  begin
    DestPtr := Pointer(NativeInt(FBits) + NativeInt(FPitch) * Y + NativeInt(X) * PixelFormatBytes[FPixelFormat]);
    AlphaColorToPixel(Value, DestPtr, FPixelFormat);
  end;
end;

function TBitmapSurface.GetPixelAddr(const X, Y: Integer): Pointer;
begin
  if (X < 0) or (Y < 0) or (X >= FWidth) or (Y >= FHeight) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);

  if FPixelFormat <> TPixelFormat.None then
    Result := Pointer(NativeInt(FBits) + NativeInt(FPitch) * Y + NativeInt(X) * PixelFormatBytes[FPixelFormat])
  else
    Result := Pointer(NativeInt(FBits) + NativeInt(FPitch) * Y + NativeInt(X) * FBytesPerPixel);
end;

procedure TBitmapSurface.SetSize(const AWidth, AHeight: Integer; const APixelFormat: TPixelFormat);
var
  NumOfBytes: Integer;
begin
  FPixelFormat := APixelFormat;
  if FPixelFormat = TPixelFormat.None then
    FPixelFormat := TPixelFormat.BGRA;

  FBytesPerPixel := PixelFormatBytes[FPixelFormat];

  FWidth := Max(AWidth, 0);
  FHeight := Max(AHeight, 0);
  FPitch := FWidth * FBytesPerPixel;
  NumOfBytes := FWidth * FHeight * FBytesPerPixel;

  ReallocMem(FBits, NumOfBytes);
  FillChar(FBits^, NumOfBytes, 0);
end;

procedure TBitmapSurface.StretchFrom(const Source: TBitmapSurface; const NewWidth, NewHeight: Integer;
  APixelFormat: TPixelFormat = TPixelFormat.None);
var
  I, J: Integer;
  SourceI, SourceJ: Single;
  SourceIInt, SourceJInt: Integer;
  SourceINext, SourceJNext: Integer;
  SourceIOffset, SourceJOffset: Single;
  D1, D2, D3, D4: Single;
  P1, P2, P3, P4: TAlphaColorF;
  Dest: TAlphaColorF;
begin
  if APixelFormat = TPixelFormat.None then
    APixelFormat := Source.PixelFormat;

  SetSize(NewWidth, NewHeight, APixelFormat);

  if (Source.Width > 1) and (Source.Width > 1) and (Width > 1) and (Width > 1) then
    for I := Width - 1 downto 0 do
      for J := 0 to Height - 1 do
      begin
        SourceI := (I / (Width - 1)) * (Source.Width - 1);
        SourceJ := (J / (Height - 1)) * (Source.Height - 1);

        SourceIInt := Trunc(SourceI);
        SourceJInt := Trunc(SourceJ);
        SourceINext := Min(Source.Width - 1, SourceIInt + 1);
        SourceJNext := Min(Source.Height - 1, SourceJInt + 1);

        SourceIOffset := Frac(SourceI);
        SourceJOffset := Frac(SourceJ);

        D1 := (1 - SourceIOffset) * (1 - SourceJOffset);
        D2 := SourceIOffset * (1 - SourceJOffset);
        D3 := SourceIOffset * SourceJOffset;
        D4 := (1 - SourceIOffset) * SourceJOffset;

        P1 := TAlphaColorF.Create(Source.Pixels[SourceIInt, SourceJInt]);
        P2 := TAlphaColorF.Create(Source.Pixels[SourceINext, SourceJInt]);
        P3 := TAlphaColorF.Create(Source.Pixels[SourceINext, SourceJNext]);
        P4 := TAlphaColorF.Create(Source.Pixels[SourceIInt, SourceJNext]);

        Dest := P1 * D1 + P2 * D2 + P3 * D3 + P4 * D4;
        SetPixel(I, J, Dest.Clamp.ToAlphaColor);
      end;
end;

procedure TBitmapSurface.SwapColors(const X1, Y1, X2, Y2: Integer);
var
  ColorTmp: TAlphaColor;
begin
  ColorTmp := Pixels[X1, Y1];
  Pixels[X1, Y1] := Pixels[X2, Y2];
  Pixels[X2, Y2] := ColorTmp;
end;

procedure TBitmapSurface.Clear(const Color: TAlphaColor);
var
  Index: Integer;
  Dest: Pointer;
begin
  if (FWidth < 1) or (FHeight < 1) or (FBits = nil) then
    Exit;
  Dest := FBits;
  for Index := 0 to (FWidth * FHeight) - 1 do
  begin
    AlphaColorToPixel(Color, Dest, FPixelFormat);
    Inc(NativeInt(Dest), FBytesPerPixel);
  end;
end;

procedure TBitmapSurface.Mirror;
var
  I, J: Integer;
  SourceColor, DestColor: PAlphaColor;
begin
  for J := 0 to FHeight - 1 do
  begin
    SourceColor := Scanline[J];
    DestColor := Pointer(NativeInt(Scanline[J]) + (FWidth - 1) * 4);
    for I := 0 to (FWidth div 2) - 1 do
    begin
      SwapColors(SourceColor^, DestColor^);
      Inc(SourceColor);
      Dec(DestColor);
    end;
  end;
end;

procedure TBitmapSurface.Flip;
var
  I, J: Integer;
  SourceColor, DestColor: PAlphaColor;
begin
  for J := 0 to (FHeight div 2) - 1 do
  begin
    SourceColor := Scanline[J];
    DestColor := Scanline[FHeight - (J + 1)];
    for I := 0 to FWidth - 1 do
    begin
      SwapColors(SourceColor^, DestColor^);
      Inc(SourceColor);
      Inc(DestColor);
    end;
  end;
end;

procedure TBitmapSurface.Rotate180;
var
  I, J: Integer;
begin
  for J := 0 to (FHeight div 2) - 1 do
    for I := 0 to FWidth - 1 do
      SwapColors(I, J, FWidth - (I + 1), FHeight - (J + 1));
end;

procedure TBitmapSurface.Rotate270;
var
  TempSurface: TBitmapSurface;
  X, Y: Integer;
begin
  TempSurface := TBitmapSurface.Create;
  try
    TempSurface.Assign(Self);
    SetSize(FHeight, FWidth, FPixelFormat);
    for Y := 0 to FHeight - 1 do
      for X := 0 to FWidth - 1 do
        Pixels[X, FHeight - (Y + 1)] := TempSurface.Pixels[Y, X];
  finally
    TempSurface.Free;
  end;
end;

procedure TBitmapSurface.Rotate90;
var
  TempSurface: TBitmapSurface;
  X, Y: Integer;
begin
  TempSurface := TBitmapSurface.Create;
  try
    TempSurface.Assign(Self);
    SetSize(FHeight, FWidth, FPixelFormat);
    for Y := 0 to FHeight - 1 do
      for X := 0 to FWidth - 1 do
        Pixels[X, Y] := TempSurface.Pixels[Y, FWidth - (X + 1)];
  finally
    TempSurface.Free;
  end;
end;

procedure TBitmapSurface.AssignTo(Dest: TPersistent);
var
  I: Integer;
begin
  if Dest is TBitmapSurface then
  begin
    TBitmapSurface(Dest).SetSize(FWidth, FHeight, FPixelFormat);
    for I := 0 to FHeight - 1 do
      Move(Scanline[I]^, TBitmapSurface(Dest).Scanline[I]^, FWidth * 4);
  end
  else
    inherited;
end;

class procedure TBitmapSurface.SwapColors(var Color1, Color2: TAlphaColor);
var
  Temp: TAlphaColor;
begin
  Temp := Color2;
  Color2 := Color1;
  Color1 := Temp;
end;

constructor TMipmapSurface.Create;
begin
  inherited;

  FChildMipmaps := TMipmapSurfaces.Create;
end;

destructor TMipmapSurface.Destroy;
begin
  FChildMipmaps.Free;

  inherited;
end;

function TMipmapSurface.GetMipCount: Integer;
begin
  Result := FChildMipmaps.Count;
end;

function TMipmapSurface.GetMip(const MipIndex: Integer): TMipmapSurface;
begin
  if (MipIndex >= 0) and (MipIndex < FChildMipmaps.Count) then
    Result := FChildMipmaps[MipIndex]
  else
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
end;

procedure TMipmapSurface.StretchHalfFrom(const Source: TMipmapSurface);
var
  PosX, PosY: Integer;
  NewWidth, NewHeight: Integer;
begin
  if (Source.PixelFormat = TPixelFormat.None) or (Source.Width < 1) or (Source.Height < 1) or ((Source.Width < 2) and
    (Source.Height < 2)) then
    Exit;

  NewWidth := Max(Source.Width div 2, 1);
  NewHeight := Max(Source.Height div 2, 1);

  if (FWidth <> NewWidth) or (FHeight <> NewHeight) or (FPixelFormat <> Source.PixelFormat) then
    SetSize(NewWidth, NewHeight, Source.PixelFormat);

  if (Source.Width > 1) and (Source.Height = 1) then
  begin // (W)x(1) -> (W/2)x(1)
    for PosX := 0 to FWidth - 1 do
      Pixels[PosX, 0] := ComputePixelAverage2(Source.Pixels[PosX * 2, 0], Source.Pixels[(PosX * 2) + 1, 0]);
  end
  else if (Source.Width = 1) and (Source.Height > 1) then
  begin // (1)x(H) -> (1)x(H/2)
    for PosY := 0 to FHeight - 1 do
      Pixels[0, PosY] := ComputePixelAverage2(Source.Pixels[0, PosY * 2], Source.Pixels[0, (PosY * 2) + 1]);
  end
  else
  begin // General solution (W and H are bigger than 1)
    for PosY := 0 to FHeight - 1 do
      for PosX := 0 to FWidth - 1 do
        Pixels[PosX, PosY] := ComputePixelAverage4(Source.Pixels[PosX * 2, PosY * 2], Source.Pixels[(PosX * 2) + 1, PosY * 2],
          Source.Pixels[PosX * 2, (PosY * 2) + 1], Source.Pixels[(PosX * 2) + 1, (PosY * 2) + 1]);
  end;
end;

procedure TMipmapSurface.GenerateMips;
var
  Source, Dest: TMipmapSurface;
  NewIndex: Integer;
begin
  FChildMipmaps.Clear;

  Source := Self;

  while ((Source.Width > 1) or (Source.Height > 1)) and (Source.PixelFormat <> TPixelFormat.None) do
  begin
    NewIndex := FChildMipmaps.Add(TMipmapSurface.Create);

    Dest := FChildMipmaps[NewIndex];
    if Dest = nil then
      Break;

    Dest.StretchHalfFrom(Source);
    Source := Dest;
  end;
end;

procedure TMipmapSurface.ClearMips;
begin
  FChildMipmaps.Clear;
end;

end.
