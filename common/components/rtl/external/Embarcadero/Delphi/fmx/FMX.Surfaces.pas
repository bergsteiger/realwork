{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2013 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit FMX.Surfaces;

interface

uses
  System.UITypes, System.Generics.Collections, System.Classes, FMX.PixelFormats;

type
  TBitmapSurface = class(TPersistent)
  private
    FBits: Pointer;
    FPitch: Integer;
    FWidth: Integer;
    FHeight: Integer;

    FPixelFormat: TPixelFormat;
    FBytesPerPixel: Integer;

    function GetScanline(Index: Integer): Pointer;
    function GetPixel(X, Y: Integer): Cardinal;
    procedure SetPixel(X, Y: Integer; const Value: Cardinal);
  public
    property Bits: Pointer read FBits;
    property Pitch: Integer read FPitch;

    property Width: Integer read FWidth;
    property Height: Integer read FHeight;

    property PixelFormat: TPixelFormat read FPixelFormat;
    property BytesPerPixel: Integer read FBytesPerPixel;

    property Scanline[Index: Integer]: Pointer read GetScanline;

    property Pixels[X, Y: Integer]: Cardinal read GetPixel write SetPixel;

    function GetPixelAddr(X, Y: Integer): Pointer;

    procedure SetSize(AWidth, AHeight: Integer; APixelFormat: TPixelFormat = pfUnknown);
    procedure Clear(Color: Cardinal);

    constructor Create();
    destructor Destroy(); override;
  end;

  TMipmapSurface = class(TBitmapSurface)
  private type
    TMipmapSurfaces = TObjectList<TMipmapSurface>;
  private
    FChildMipmaps: TMipmapSurfaces;

    function GetMipCount(): Integer;
    function GetMip(MipIndex: Integer): TMipmapSurface;
  protected
    procedure StretchHalfFrom(const Source: TMipmapSurface);
  public
    property MipCount: Integer read GetMipCount;
    property Mip[MipIndex: Integer]: TMipmapSurface read GetMip;

    procedure GenerateMips();
    procedure ClearMips();

    constructor Create();
    destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils, System.RTLConsts;

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

constructor TBitmapSurface.Create();
begin
  inherited;

  FBits := nil;
  FPitch := 0;
  FWidth := 0;
  FHeight := 0;
  FPixelFormat := pfUnknown;
  FBytesPerPixel := 0;
end;

destructor TBitmapSurface.Destroy();
begin
  if (Assigned(FBits)) then
  begin
    FreeMem(FBits);
    FBits := nil;
  end;

  inherited;
end;

function TBitmapSurface.GetScanline(Index: Integer): Pointer;
begin
  if (Index >= 0) and (Index < FHeight) then
    Result := Pointer(NativeInt(FBits) + (NativeInt(FPitch) * Index))
  else
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
end;

function TBitmapSurface.GetPixel(X, Y: Integer): Cardinal;
var
  SrcPtr: Pointer;
begin
  if (X < 0) or (Y < 0) or (X >= FWidth) or (Y >= FHeight) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);

  if (FPixelFormat <> pfUnknown) then
  begin
    SrcPtr := Pointer(NativeInt(FBits) + (NativeInt(FPitch) * Y) + (NativeInt(X) * GetPixelFormatBytes(FPixelFormat)));
    Result := PixelToAlphaColor(SrcPtr, FPixelFormat);
  end
  else
    Result := 0;
end;

procedure TBitmapSurface.SetPixel(X, Y: Integer; const Value: Cardinal);
var
  DestPtr: Pointer;
begin
  if (X < 0) or (Y < 0) or (X >= FWidth) or (Y >= FHeight) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);

  if (FPixelFormat <> pfUnknown) then
  begin
    DestPtr := Pointer(NativeInt(FBits) + (NativeInt(FPitch) * Y) + (NativeInt(X) * GetPixelFormatBytes(FPixelFormat)));
    AlphaColorToPixel(Value, DestPtr, FPixelFormat);
  end;
end;

function TBitmapSurface.GetPixelAddr(X, Y: Integer): Pointer;
begin
  if (X < 0) or (Y < 0) or (X >= FWidth) or (Y >= FHeight) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);

  if (FPixelFormat <> pfUnknown) then
  begin
    Result := Pointer(NativeInt(FBits) + (NativeInt(FPitch) * Y) + (NativeInt(X) * GetPixelFormatBytes(FPixelFormat)));
  end
  else
  begin
    Result := Pointer(NativeInt(FBits) + (NativeInt(FPitch) * Y) + (NativeInt(X) * FBytesPerPixel));
  end;
end;

procedure TBitmapSurface.SetSize(AWidth, AHeight: Integer; APixelFormat: TPixelFormat);
var
  NumOfBytes: Integer;
begin
  FPixelFormat := APixelFormat;
  if (FPixelFormat = pfUnknown) then
    FPixelFormat := pfA8R8G8B8;

  FBytesPerPixel := GetPixelFormatBytes(FPixelFormat);

  FWidth := AWidth;
  if (FWidth < 0) then
    FWidth := 0;

  FHeight := AHeight;
  if (FHeight < 0) then
    FHeight := 0;

  FPitch := FWidth * FBytesPerPixel;

  NumOfBytes := FWidth * FHeight * FBytesPerPixel;

  ReallocMem(FBits, NumOfBytes);
  FillChar(FBits^, NumOfBytes, 0);
end;

procedure TBitmapSurface.Clear(Color: Cardinal);
var
  Index: Integer;
  Dest: Pointer;
begin
  if (FWidth < 1) or (FHeight < 1) or (not Assigned(FBits)) then
    Exit;

  Dest := FBits;

  for Index := 0 to (FWidth * FHeight) - 1 do
  begin
    AlphaColorToPixel(Color, Dest, FPixelFormat);
    Inc(NativeInt(Dest), FBytesPerPixel);
  end;
end;

constructor TMipmapSurface.Create();
begin
  inherited;

  FChildMipmaps := TMipmapSurfaces.Create();
end;

destructor TMipmapSurface.Destroy();
begin
  FChildMipmaps.Free;

  inherited;
end;

function TMipmapSurface.GetMipCount(): Integer;
begin
  Result := FChildMipmaps.Count;
end;

function TMipmapSurface.GetMip(MipIndex: Integer): TMipmapSurface;
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
  if (Source.PixelFormat = pfUnknown) or (Source.Width < 1) or (Source.Height < 1) or ((Source.Width < 2) and (Source.Height < 2)) then
    Exit;

  NewWidth := Source.Width div 2;
  if (NewWidth < 1) then
    NewWidth := 1;

  NewHeight := Source.Height div 2;
  if (NewHeight < 1) then
    NewHeight := 1;

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

procedure TMipmapSurface.GenerateMips();
var
  Source, Dest: TMipmapSurface;
  NewIndex: Integer;
begin
  FChildMipmaps.Clear();

  Source := Self;

  while ((Source.Width > 1) or (Source.Height > 1)) and (Source.PixelFormat <> pfUnknown) do
  begin
    NewIndex := FChildMipmaps.Add(TMipmapSurface.Create());

    Dest := FChildMipmaps[NewIndex];
    if (not Assigned(Dest)) then
      Break;

    Dest.StretchHalfFrom(Source);
    Source := Dest;
  end;
end;

procedure TMipmapSurface.ClearMips();
begin
  FChildMipmaps.Clear();
end;

end.
