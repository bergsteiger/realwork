{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.PixelFormats;

{
  General description of all pixel formats supported by HRH, along with the
  conversion between different formats. In addition, it simplifies matching
  of one or more pixel formats so that a closest alternative can be found
  within a list of available formats.
}
interface

uses
  System.Generics.Collections, System.Types;

type
  { Native pixel format that describes how color and data are encoded for each
    pixel in bitmap and/or texture. }
  TPixelFormat = (pfUnknown,

    { 64-bit format with 16 bits per channel. }
    pfA16B16G16R16,

    { 32-bit format with 10 bits for color channels and 2 bits for alpha channel. }
    pfA2R10G10B10,

    { 32-bit format with 10 bits for color channels and 2 bits for alpha channel. }
    pfA2B10G10R10,

    { 32-bit format with 8 bits per channel. }
    pfA8R8G8B8,

    { 32-bit format with 8 bits for color channels. }
    pfX8R8G8B8,

    { 32-bit format with 8 bits per channel. }
    pfA8B8G8R8,

    { 32-bit format with 8 bits for color channels. }
    pfX8B8G8R8,

    { 16-bit format with 5 bits for red and blue channels and 6 bits for
      green channel. }
    pfR5G6B5,

    { 16-bit format with 4 bits per channel. }
    pfA4R4G4B4,

    { 16-bit format with 5 bits for color channels and 1 bit for alpha channel. }
    pfA1R5G5B5,

    { 16-bit format with 5 bits for color channels. }
    pfX1R5G5B5,

    { 32-bit format with 16 bits for red and green channels. }
    pfG16R16,

    { 16-bit format with 8 bits for alpha and luminance channels. }
    pfA8L8,

    { 8-bit format with 4 bits for alpha and luminance channels. }
    pfA4L4,

    { 16-bit format for luminance channel. }
    pfL16,

    { 8-bit format for luminance channel. }
    pfL8,

    { 16-bit floating-point format for red channel. }
    pfR16F,

    { 32-bit floating-point format for green and red channels. }
    pfG16R16F,

    { 64-bit floating-point format with 16 bits per channel. }
    pfA16B16G16R16F,

    { 32-bit floating-point format for red channel. }
    pfR32F,

    { 64-bit floating-point format with 32 bits for green and red channels. }
    pfG32R32F,

    { 128-bit floating-point format with 32 bits per channel. }
    pfA32B32G32R32F,

    { 8-bit format for alpha channel. }
    pfA8,

    { 16-bit bump-map format. }
    pfV8U8,

    { 16-bit bump-map format. }
    pfL6V5U5,

    { 32-bit bump-map format. }
    pfX8L8V8U8,

    { 32-bit bump-map format. }
    pfQ8W8V8U8,

    { 32-bit bump-map format. }
    pfV16U16,

    { 32-bit bump-map format. }
    pfA2W10V10U10,

    { 32-bit FourCC packed format U8Y8_V8Y8 describing a pair of YUV pixels
      (first Y8, U8, V8) and (second Y8, U8, V8). }
    pfU8Y8_V8Y8,

    { 32-bit packed format describing a pair of pixels (R8, first G8, B8)
      and (R8, second G8, B8). }
    pfR8G8_B8G8,

    { 32-bit FourCC packed format Y8U8_Y8V8 describing a pair of YUV pixels
      (first Y8, U8, V8) and (second Y8, U8, V8). }
    pfY8U8_Y8V8,

    { 32-bit packed format describing a pair of pixels (R8, first G8, B8)
      and (R8, second G8, B8). }
    pfG8R8_G8B8,

    { 64-bit bumo-map format with 16 bits for QWVU channels. }
    pfQ16W16V16U16,

    { 16-bit normal compression format. }
    pfCxV8U8,

    { block compression 1: stores 16 pixels into 64 bits consisting of
      two 16 bits RGB(R5G6B5) and a 4x4 2 bits lookup table. }
    pfDXT1,

    { block compression 2: stores 16 pixels into 128 bits consisting of
      64 bits of alpha channel (4 bits per pixel) and a 64 bits of color channels
      premultiplied by alpha. }
    pfDXT2,

    { block compression 2: stores 16 pixels into 128 bits consisting of
      64 bits of alpha channel (4 bits per pixel) and a 64 bits of color channels
      without being premultiplied by alpha. }
    pfDXT3,

    { block compression 3: stores 16 pixels into 128 bits consisting of
      64 bits of alpha channel (two 8-bit alpha values and a 4x4 3-bit
      lookup table) and a 64 bits of color channels premultiplied by alpha. }
    pfDXT4,

    { block compression 3: stores 16 pixels into 128 bits consisting of
      64 bits of alpha channel (two 8-bit alpha values and a 4x4 3-bit
      lookup table) and a 64 bits of color channels without being premultiplied
      by alpha. }
    pfDXT5,

    { 128-bit BGRA pixel format with 32 bits per channel. }
    pfA32B32G32R32,

    { 32-bit BGR pixel format with 11 bits for Red and Green channels, and
      10 bits for Blue channel. }
    pfB10G11R11F);

type
  { The list of available pixel formats that can be used for matching
    using FindClosestPixelFormat() function. }
  TPixelFormatList = TList<TPixelFormat>;

  { Returns the number of bytes that each pixel occupies in the specified format. }
function GetPixelFormatBytes(Format: TPixelFormat): Integer;

{ Converts pixel refenced by the given pointer from its native format into
  4-component floating-point vector (XYZW coordinates correspond to RGBA). }
function PixelToFloat4(Source: Pointer; SrcFormat: TPixelFormat): TVector3D;

{ Converts pixel refenced by the given pointer from its native format into
  32-bit A8R8G8B8 value. }
function PixelToAlphaColor(Source: Pointer; SrcFormat: TPixelFormat): Cardinal;

{ Converts 4-component floating-point vector (XYZW coordinates corresponding
  to RGBA) of one pixel into the native pixel format. The destination pixel
  is referenced by the given pointer. }
procedure Float4ToPixel(const Source: TVector3D; Dest: Pointer; DestFormat: TPixelFormat);

{ Converts 32-bit A8R8G8B8 value of one pixel into the native pixel format.
  The destination pixel is referenced by the given pointer. }
procedure AlphaColorToPixel(Source: Cardinal; Dest: Pointer; DestFormat: TPixelFormat);

{ Converts an array of contiguous pixels from their native format into 32-bit
  A8R8G8B8 pixel format; Source points to the first pixel in the input array,
  while Dest points to the first pixel in the output array. }
procedure ScanlineToAlphaColor(Source, Dest: Pointer; PixelCount: Integer; SrcFormat: TPixelFormat);

{ Converts an array of contiguous pixels in 32-bit A8R8G8B8 format into a
  different pixel format; Source points to the first pixel in the input array,
  while Dest points to the first pixel in the output array. }
procedure AlphaColorToScanline(Source, Dest: Pointer; PixelCount: Integer; DestFormat: TPixelFormat);

{ Converts the specified pixel format into a readable string describing each
  of the channels, for example "A8R8G8B8". }
function PixelFormatToString(Format: TPixelFormat): string;

{ Given the specified pixel format and a list of available pixel formats, this
  function tries to find a format contained in the list that closely
  resembles the specified format (if no exact match exists). }
function FindClosestPixelFormat(Format: TPixelFormat; const FormatList: TPixelFormatList): TPixelFormat;

implementation

uses
  System.Character, System.SysUtils, System.Generics.Defaults, System.UIConsts, FMX.Types3D;

const
  MaxPixelFormatChannels = 4;

type
  TPixelFormatType = (ftRGB, ftRGBf, ftLuminance, ftBump, ftSpecial);

  TPixelFormatChannel = record
    Letter: Char;
    Start: Integer;
    Size: Integer;
  end;

  TPixelFormatDesc = record
    Channels: array [0 .. MaxPixelFormatChannels - 1] of TPixelFormatChannel;
    BitCount: Integer;
    FormType: TPixelFormatType;

    function AddChannel(Letter: Char; Start, Size: Integer): Integer;
    function IsChannelMeaningful(Index: Integer): Boolean;
    function IndexOfLetter(Letter: Char): Integer;
    function GetMeaningfulChannelCount(): Integer;
  end;

  TPixelFormatComparer = class(TComparer<TPixelFormat>)
  private
    FPivot: TPixelFormat;
  public
    property Pivot: TPixelFormat read FPivot write FPivot;

    function Compare(const Left, Right: TPixelFormat): Integer; override;
  end;

function TPixelFormatDesc.AddChannel(Letter: Char; Start, Size: Integer): Integer;
var
  Index: Integer;
begin
  Result := -1;

  for Index := 0 to MaxPixelFormatChannels - 1 do
    if (Channels[Index].Letter = #0) or (Channels[Index].Size < 1) then
    begin
      Result := Index;
      Break;
    end;

  if (Result = -1) then
    Exit;

  Channels[Result].Letter := Letter;
  Channels[Result].Start := Start;
  Channels[Result].Size := Size;
end;

function TPixelFormatDesc.IsChannelMeaningful(Index: Integer): Boolean;
begin
  Result := (Index >= 0) and (Index <= MaxPixelFormatChannels) and (Channels[Index].Size > 0);
  if (not Result) then
    Exit;

  Result := Channels[Index].Letter.ToUpper.IsInArray(['R', 'G', 'B', 'A', 'L', 'U', 'V', 'W', 'Q']);
end;

function TPixelFormatDesc.IndexOfLetter(Letter: Char): Integer;
var
  Index: Integer;
begin
  Result := -1;

  for Index := 0 to MaxPixelFormatChannels - 1 do
    if (Channels[Index].Size > 0) and (UpCase(Channels[Index].Letter) = UpCase(Letter)) then
    begin
      Result := Index;
      Break;
    end;
end;

function TPixelFormatDesc.GetMeaningfulChannelCount(): Integer;
var
  Index: Integer;
begin
  Result := 0;

  for Index := 0 to MaxPixelFormatChannels - 1 do
    if (IsChannelMeaningful(Index)) then
      Inc(Result);
end;

function GetPixelFormatDesc(Format: TPixelFormat): TPixelFormatDesc;
begin
  FillChar(Result, SizeOf(TPixelFormatDesc), 0);

  case Format of
    pfA16B16G16R16:
      begin
        Result.BitCount := 64;
        Result.FormType := ftRGB;
        Result.AddChannel('R', 0, 16);
        Result.AddChannel('G', 16, 16);
        Result.AddChannel('B', 32, 16);
        Result.AddChannel('A', 48, 16);
      end;

    pfA2R10G10B10:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGB;
        Result.AddChannel('B', 0, 10);
        Result.AddChannel('G', 10, 10);
        Result.AddChannel('R', 20, 10);
        Result.AddChannel('A', 30, 2);
      end;

    pfA2B10G10R10:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGB;
        Result.AddChannel('R', 0, 10);
        Result.AddChannel('G', 10, 10);
        Result.AddChannel('B', 20, 10);
        Result.AddChannel('A', 30, 2);
      end;

    pfA8R8G8B8:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGB;
        Result.AddChannel('B', 0, 8);
        Result.AddChannel('G', 8, 8);
        Result.AddChannel('R', 16, 8);
        Result.AddChannel('A', 24, 8);
      end;

    pfX8R8G8B8:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGB;
        Result.AddChannel('B', 0, 8);
        Result.AddChannel('G', 8, 8);
        Result.AddChannel('R', 16, 8);
        Result.AddChannel('X', 24, 8);
      end;

    pfA8B8G8R8:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGB;
        Result.AddChannel('R', 0, 8);
        Result.AddChannel('G', 8, 8);
        Result.AddChannel('B', 16, 8);
        Result.AddChannel('A', 24, 8);
      end;

    pfX8B8G8R8:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGB;
        Result.AddChannel('R', 0, 8);
        Result.AddChannel('G', 8, 8);
        Result.AddChannel('B', 16, 8);
        Result.AddChannel('X', 24, 8);
      end;

    pfR5G6B5:
      begin
        Result.BitCount := 16;
        Result.FormType := ftRGB;
        Result.AddChannel('B', 0, 5);
        Result.AddChannel('G', 5, 6);
        Result.AddChannel('R', 11, 5);
      end;

    pfA4R4G4B4:
      begin
        Result.BitCount := 16;
        Result.FormType := ftRGB;
        Result.AddChannel('B', 0, 4);
        Result.AddChannel('G', 4, 4);
        Result.AddChannel('R', 8, 4);
        Result.AddChannel('A', 12, 4);
      end;

    pfA1R5G5B5:
      begin
        Result.BitCount := 16;
        Result.FormType := ftRGB;
        Result.AddChannel('B', 0, 5);
        Result.AddChannel('G', 5, 5);
        Result.AddChannel('R', 10, 5);
        Result.AddChannel('A', 15, 1);
      end;

    pfX1R5G5B5:
      begin
        Result.BitCount := 16;
        Result.FormType := ftRGB;
        Result.AddChannel('B', 0, 5);
        Result.AddChannel('G', 5, 5);
        Result.AddChannel('R', 10, 5);
        Result.AddChannel('X', 15, 1);
      end;

    pfG16R16:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGB;
        Result.AddChannel('R', 0, 16);
        Result.AddChannel('G', 16, 16);
      end;

    pfA8L8:
      begin
        Result.BitCount := 16;
        Result.FormType := ftLuminance;
        Result.AddChannel('L', 0, 8);
        Result.AddChannel('A', 8, 8);
      end;

    pfA4L4:
      begin
        Result.BitCount := 8;
        Result.FormType := ftLuminance;
        Result.AddChannel('L', 0, 4);
        Result.AddChannel('A', 4, 4);
      end;

    pfL16:
      begin
        Result.BitCount := 16;
        Result.FormType := ftLuminance;
        Result.AddChannel('L', 0, 16);
      end;

    pfL8:
      begin
        Result.BitCount := 8;
        Result.FormType := ftLuminance;
        Result.AddChannel('L', 0, 8);
      end;

    pfR16F:
      begin
        Result.BitCount := 16;
        Result.FormType := ftRGBf;
        Result.AddChannel('R', 0, 16);
      end;

    pfG16R16F:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGBf;
        Result.AddChannel('R', 0, 16);
        Result.AddChannel('G', 16, 16);
      end;

    pfA16B16G16R16F:
      begin
        Result.BitCount := 64;
        Result.FormType := ftRGBf;
        Result.AddChannel('R', 0, 16);
        Result.AddChannel('G', 16, 16);
        Result.AddChannel('B', 32, 16);
        Result.AddChannel('A', 48, 16);
      end;

    pfR32F:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGBf;
        Result.AddChannel('R', 0, 32);
      end;

    pfG32R32F:
      begin
        Result.BitCount := 64;
        Result.FormType := ftRGBf;
        Result.AddChannel('R', 0, 32);
        Result.AddChannel('G', 32, 32);
      end;

    pfA32B32G32R32F:
      begin
        Result.BitCount := 128;
        Result.FormType := ftRGBf;
        Result.AddChannel('R', 0, 32);
        Result.AddChannel('G', 32, 32);
        Result.AddChannel('B', 64, 32);
        Result.AddChannel('A', 96, 32);
      end;

    pfA8:
      begin
        Result.BitCount := 8;
        Result.FormType := ftRGB;
        Result.AddChannel('A', 0, 8);
      end;

    pfV8U8:
      begin
        Result.BitCount := 16;
        Result.FormType := ftBump;
        Result.AddChannel('U', 0, 8);
        Result.AddChannel('V', 8, 8);
      end;

    pfL6V5U5:
      begin
        Result.BitCount := 16;
        Result.FormType := ftBump;
        Result.AddChannel('U', 0, 5);
        Result.AddChannel('V', 5, 5);
        Result.AddChannel('L', 10, 6);
      end;

    pfX8L8V8U8:
      begin
        Result.BitCount := 32;
        Result.FormType := ftBump;
        Result.AddChannel('U', 0, 8);
        Result.AddChannel('V', 8, 8);
        Result.AddChannel('L', 16, 8);
        Result.AddChannel('X', 24, 8);
      end;

    pfQ8W8V8U8:
      begin
        Result.BitCount := 32;
        Result.FormType := ftBump;
        Result.AddChannel('U', 0, 8);
        Result.AddChannel('V', 8, 8);
        Result.AddChannel('W', 16, 8);
        Result.AddChannel('Q', 24, 8);
      end;

    pfV16U16:
      begin
        Result.BitCount := 32;
        Result.FormType := ftBump;
        Result.AddChannel('U', 0, 16);
        Result.AddChannel('V', 16, 16);
      end;

    pfA2W10V10U10:
      begin
        Result.BitCount := 32;
        Result.FormType := ftBump;
        Result.AddChannel('U', 0, 10);
        Result.AddChannel('V', 10, 10);
        Result.AddChannel('W', 20, 10);
        Result.AddChannel('A', 30, 2);
      end;

    pfU8Y8_V8Y8:
      begin
        Result.BitCount := 16;
        Result.FormType := ftSpecial;
        Result.AddChannel('U', 0, 1);
        Result.AddChannel('Y', 1, 1);
        Result.AddChannel('V', 2, 1);
        Result.AddChannel('Y', 3, 1);
      end;

    pfR8G8_B8G8:
      begin
        Result.BitCount := 32;
        Result.FormType := ftSpecial;
        Result.AddChannel('G', 0, 8);
        Result.AddChannel('B', 8, 8);
        Result.AddChannel('G', 16, 8);
        Result.AddChannel('R', 24, 8);
      end;

    pfY8U8_Y8V8:
      begin
        Result.BitCount := 16;
        Result.FormType := ftSpecial;
        Result.AddChannel('2', 0, 1);
        Result.AddChannel('Y', 1, 1);
        Result.AddChannel('U', 2, 1);
        Result.AddChannel('Y', 3, 1);
      end;

    pfG8R8_G8B8:
      begin
        Result.BitCount := 32;
        Result.FormType := ftSpecial;
        Result.AddChannel('B', 0, 8);
        Result.AddChannel('G', 8, 8);
        Result.AddChannel('R', 16, 8);
        Result.AddChannel('G', 24, 8);
      end;

    pfQ16W16V16U16:
      begin
        Result.BitCount := 64;
        Result.FormType := ftBump;
        Result.AddChannel('U', 0, 16);
        Result.AddChannel('V', 16, 16);
        Result.AddChannel('W', 32, 16);
        Result.AddChannel('Q', 48, 16);
      end;

    pfCxV8U8:
      begin
        Result.BitCount := 16;
        Result.FormType := ftSpecial;
        Result.AddChannel('U', 0, 1);
        Result.AddChannel('V', 1, 1);
        Result.AddChannel('X', 2, 1);
        Result.AddChannel('C', 3, 1);
      end;

    pfDXT1:
      begin
        Result.BitCount := 4;
        Result.FormType := ftSpecial;
        Result.AddChannel('1', 0, 1);
        Result.AddChannel('T', 1, 1);
        Result.AddChannel('X', 2, 1);
        Result.AddChannel('D', 3, 1);
      end;

    pfDXT2:
      begin
        Result.BitCount := 8;
        Result.FormType := ftSpecial;
        Result.AddChannel('2', 0, 1);
        Result.AddChannel('T', 1, 1);
        Result.AddChannel('X', 2, 1);
        Result.AddChannel('D', 3, 1);
      end;

    pfDXT3:
      begin
        Result.BitCount := 8;
        Result.FormType := ftSpecial;
        Result.AddChannel('3', 0, 1);
        Result.AddChannel('T', 1, 1);
        Result.AddChannel('X', 2, 1);
        Result.AddChannel('D', 3, 1);
      end;

    pfDXT4:
      begin
        Result.BitCount := 8;
        Result.FormType := ftSpecial;
        Result.AddChannel('4', 0, 1);
        Result.AddChannel('T', 1, 1);
        Result.AddChannel('X', 2, 1);
        Result.AddChannel('D', 3, 1);
      end;

    pfDXT5:
      begin
        Result.BitCount := 8;
        Result.FormType := ftSpecial;
        Result.AddChannel('5', 0, 1);
        Result.AddChannel('T', 1, 1);
        Result.AddChannel('X', 2, 1);
        Result.AddChannel('D', 3, 1);
      end;

    pfA32B32G32R32:
      begin
        Result.BitCount := 128;
        Result.FormType := ftRGB;
        Result.AddChannel('B', 0, 32);
        Result.AddChannel('G', 32, 32);
        Result.AddChannel('R', 64, 32);
        Result.AddChannel('A', 96, 32);
      end;

    pfB10G11R11F:
      begin
        Result.BitCount := 32;
        Result.FormType := ftRGBf;
        Result.AddChannel('R', 0, 11);
        Result.AddChannel('G', 11, 11);
        Result.AddChannel('B', 22, 10);
      end;
  end;
end;

function GetPixelFormatBytes(Format: TPixelFormat): Integer;
begin
  Result := 0;

  case Format of
    pfA32B32G32R32F, pfA32B32G32R32:
      Result := 16;

    pfA16B16G16R16, pfA16B16G16R16F, pfG32R32F, pfQ16W16V16U16:
      Result := 8;

    pfA2R10G10B10, pfA2B10G10R10, pfA8R8G8B8, pfX8R8G8B8, pfA8B8G8R8, pfX8B8G8R8, pfG16R16, pfG16R16F, pfR32F,
      pfX8L8V8U8, pfQ8W8V8U8, pfV16U16, pfA2W10V10U10, pfR8G8_B8G8, pfG8R8_G8B8, pfB10G11R11F:
      Result := 4;

    pfR5G6B5, pfA4R4G4B4, pfA1R5G5B5, pfX1R5G5B5, pfA8L8, pfL16, pfR16F, pfV8U8, pfL6V5U5:
      Result := 2;

    pfA4L4, pfL8, pfA8:
      Result := 1;
  end;
end;

function IsFormatConvertible(Source, Dest: TPixelFormat): Boolean;
var
  SourceDesc, DestDesc: TPixelFormatDesc;
  Index, DestIndex: Integer;
  OneElement: Boolean;
begin
  SourceDesc := GetPixelFormatDesc(Source);
  DestDesc := GetPixelFormatDesc(Dest);

  Result := (SourceDesc.FormType = DestDesc.FormType) and (SourceDesc.BitCount > 0) and (DestDesc.BitCount > 0);
  if (not Result) then
    Exit;

  OneElement := False;

  for Index := 0 to MaxPixelFormatChannels - 1 do
  begin
    if (not SourceDesc.IsChannelMeaningful(Index)) then
      Continue;

    DestIndex := DestDesc.IndexOfLetter(SourceDesc.Channels[Index].Letter);
    if (DestIndex = -1) then
    begin
      Result := False;
      Exit;
    end;

    OneElement := True;
  end;

  Result := OneElement;
end;

function GetChannelSizeDifference(Source, Dest: TPixelFormat): Integer;
var
  SourceDesc, DestDesc: TPixelFormatDesc;
  SrcIndex, DestIndex: Integer;
begin
  SourceDesc := GetPixelFormatDesc(Source);
  DestDesc := GetPixelFormatDesc(Dest);

  Result := 0;

  for SrcIndex := 0 to MaxPixelFormatChannels - 1 do
  begin
    if (not SourceDesc.IsChannelMeaningful(SrcIndex)) then
      Continue;

    DestIndex := DestDesc.IndexOfLetter(SourceDesc.Channels[SrcIndex].Letter);
    if (DestIndex = -1) then
      Continue;

    Inc(Result, Sqr(SourceDesc.Channels[SrcIndex].Size - DestDesc.Channels[DestIndex].Size));
  end;

  Result := Round(Sqrt(Result));
end;

function GetChannelWastedBits(Source, Dest: TPixelFormat): Integer;
var
  SourceDesc, DestDesc: TPixelFormatDesc;
  Index: Integer;
begin
  SourceDesc := GetPixelFormatDesc(Source);
  DestDesc := GetPixelFormatDesc(Dest);

  Result := 0;

  for Index := 0 to MaxPixelFormatChannels - 1 do
  begin
    if (DestDesc.Channels[Index].Size < 1) then
      Continue;

    if (not DestDesc.IsChannelMeaningful(Index)) or (SourceDesc.IndexOfLetter(DestDesc.Channels[Index].Letter) = -1)
    then
      Inc(Result, DestDesc.Channels[Index].Size);
  end;
end;

function GetChannelLocationDifference(Source, Dest: TPixelFormat): Integer;
var
  SourceDesc, DestDesc: TPixelFormatDesc;
  SrcIndex, DestIndex: Integer;
begin
  SourceDesc := GetPixelFormatDesc(Source);
  DestDesc := GetPixelFormatDesc(Dest);

  Result := 0;

  for SrcIndex := 0 to MaxPixelFormatChannels - 1 do
  begin
    if (not SourceDesc.IsChannelMeaningful(SrcIndex)) then
      Continue;

    DestIndex := DestDesc.IndexOfLetter(SourceDesc.Channels[SrcIndex].Letter);
    if (DestIndex = -1) then
      Continue;

    Inc(Result, Sqr(SourceDesc.Channels[SrcIndex].Start - DestDesc.Channels[DestIndex].Start));
  end;

  Result := Round(Sqrt(Result));
end;

function PixelToAlphaColor(Source: Pointer; SrcFormat: TPixelFormat): Cardinal;
begin
  case SrcFormat of
    pfA8R8G8B8: Result := PLongWord(Source)^;
    pfA8B8G8R8: Result := RGBtoBGR(PLongWord(Source)^);
  else
    Result := Vector3DToColor(PixelToFloat4(Source, SrcFormat));
  end;
end;

function PixelToFloat4(Source: Pointer; SrcFormat: TPixelFormat): TVector3D;
begin
  Result := Vector3D(1.0, 1.0, 1.0, 1.0);

  case SrcFormat of
    pfA16B16G16R16:
      begin
        Result.X := (PLongWord(Source)^ and $FFFF) / 65535.0;
        Result.Y := ((PLongWord(Source)^ shr 16) and $FFFF) / 65535.0;
        Result.Z := (PLongWord(NativeInt(Source) + 4)^ and $FFFF) / 65535.0;
        Result.W := ((PLongWord(NativeInt(Source) + 4)^ shr 16) and $FFFF) / 65535.0;
      end;

    pfA2R10G10B10:
      begin
        Result.X := ((PLongWord(Source)^ shr 20) and $3FF) / 1023.0;
        Result.Y := ((PLongWord(Source)^ shr 10) and $3FF) / 1023.0;
        Result.Z := (PLongWord(Source)^ and $3FF) / 1023.0;
        Result.W := ((PLongWord(Source)^ shr 30) and $03) / 3.0;
      end;

    pfA2B10G10R10:
      begin
        Result.X := (PLongWord(Source)^ and $3FF) / 1023.0;
        Result.Y := ((PLongWord(Source)^ shr 10) and $3FF) / 1023.0;
        Result.Z := ((PLongWord(Source)^ shr 20) and $3FF) / 1023.0;
        Result.W := ((PLongWord(Source)^ shr 30) and $03) / 3.0;
      end;

    pfA8R8G8B8:
      begin
        Result.X := ((PLongWord(Source)^ shr 16) and $FF) / 255.0;
        Result.Y := ((PLongWord(Source)^ shr 8) and $FF) / 255.0;
        Result.Z := (PLongWord(Source)^ and $FF) / 255.0;
        Result.W := ((PLongWord(Source)^ shr 24) and $FF) / 255.0;
      end;

    pfX8R8G8B8:
      begin
        Result.X := ((PLongWord(Source)^ shr 16) and $FF) / 255.0;
        Result.Y := ((PLongWord(Source)^ shr 8) and $FF) / 255.0;
        Result.Z := (PLongWord(Source)^ and $FF) / 255.0;
        Result.W := 1.0;
      end;

    pfA8B8G8R8:
      begin
        Result.X := (PLongWord(Source)^ and $FF) / 255.0;
        Result.Y := ((PLongWord(Source)^ shr 8) and $FF) / 255.0;
        Result.Z := ((PLongWord(Source)^ shr 16) and $FF) / 255.0;
        Result.W := ((PLongWord(Source)^ shr 24) and $FF) / 255.0;
      end;

    pfX8B8G8R8:
      begin
        Result.X := (PLongWord(Source)^ and $FF) / 255.0;
        Result.Y := ((PLongWord(Source)^ shr 8) and $FF) / 255.0;
        Result.Z := ((PLongWord(Source)^ shr 16) and $FF) / 255.0;
      end;

    pfR5G6B5:
      begin
        Result.X := ((PWord(Source)^ shr 11) and $1F) / 31.0;
        Result.Y := ((PWord(Source)^ shr 5) and $3F) / 63.0;
        Result.Z := (PWord(Source)^ and $1F) / 31.0;
      end;

    pfA4R4G4B4:
      begin
        Result.X := ((PWord(Source)^ shr 8) and $0F) / 15.0;
        Result.Y := ((PWord(Source)^ shr 4) and $0F) / 15.0;
        Result.Z := (PWord(Source)^ and $0F) / 15.0;
        Result.W := ((PLongWord(Source)^ shr 12) and $0F) / 15.0;
      end;

    pfA1R5G5B5:
      begin
        Result.X := ((PWord(Source)^ shr 10) and $1F) / 31.0;
        Result.Y := ((PWord(Source)^ shr 5) and $1F) / 31.0;
        Result.Z := (PWord(Source)^ and $1F) / 31.0;
        Result.W := (PLongWord(Source)^ shr 15) and $01;
      end;

    pfX1R5G5B5:
      begin
        Result.X := ((PWord(Source)^ shr 10) and $1F) / 31.0;
        Result.Y := ((PWord(Source)^ shr 5) and $1F) / 31.0;
        Result.Z := (PWord(Source)^ and $1F) / 31.0;
      end;

    pfG16R16:
      begin
        Result.Y := (PLongWord(Source)^ and $FFFF) / 65535.0;
        Result.X := ((PLongWord(Source)^ shr 16) and $FFFF) / 65535.0;
      end;

    pfA8L8:
      begin
        Result.X := (PWord(Source)^ and $FF) / 255.0;
        Result.Y := Result.X;
        Result.Z := Result.X;
        Result.W := ((PWord(Source)^ shr 16) and $FF) / 255.0;
      end;

    pfA4L4:
      begin
        Result.X := (PByte(Source)^ and $0F) / 15.0;
        Result.Y := Result.X;
        Result.Z := Result.X;
        Result.W := ((PByte(Source)^ shr 8) and $0F) / 15.0;
      end;

    pfL16:
      begin
        Result.X := PWord(Source)^ / 65535.0;
        Result.Y := Result.X;
        Result.Z := Result.X;
      end;

    pfL8:
      begin
        Result.X := PByte(Source)^ / 255.0;
        Result.Y := Result.X;
        Result.Z := Result.X;
      end;

    pfA8:
      begin
        Result.X := 0.0;
        Result.Y := 0.0;
        Result.Z := 0.0;
        Result.W := PByte(Source)^ / 255.0;
      end;

    pfR32F:
      begin
        Result.X := PSingle(Source)^;
        Result.Y := Result.X;
        Result.Z := Result.X;
      end;

    pfA32B32G32R32:
      begin
        Result.X := PLongWord(Source)^ / High(LongWord);
        Result.Y := PLongWord(NativeInt(Source) + 4)^ / High(LongWord);
        Result.Z := PLongWord(NativeInt(Source) + 8)^ / High(LongWord);
        Result.W := PLongWord(NativeInt(Source) + 12)^ / High(LongWord);
      end;
  end;
end;

procedure Float4ToPixel(const Source: TVector3D; Dest: Pointer; DestFormat: TPixelFormat);
begin
  case DestFormat of
    pfA16B16G16R16:
      begin
        PLongWord(Dest)^ := Round(Source.X * 65535.0) or (Round(Source.Y * 65535.0) shl 16);

        PLongWord(NativeInt(Dest) + 4)^ := Round(Source.Z * 65535.0) or (Round(Source.W * 65535.0) shl 16);
      end;

    pfA2R10G10B10:
      PLongWord(Dest)^ := Round(Source.Z * 1023.0) or (Round(Source.Y * 1023.0) shl 10) or
        (Round(Source.X * 1023.0) shl 20) or (Round(Source.W * 3.0) shl 30);

    pfA2B10G10R10:
      PLongWord(Dest)^ := Round(Source.X * 1023.0) or (Round(Source.Y * 1023.0) shl 10) or
        (Round(Source.Z * 1023.0) shl 20) or (Round(Source.W * 3.0) shl 30);

    pfA8R8G8B8:
      PLongWord(Dest)^ := Round(Source.Z * 255.0) or (Round(Source.Y * 255.0) shl 8) or (Round(Source.X * 255.0) shl 16)
        or (Round(Source.W * 255.0) shl 24);

    pfX8R8G8B8:
      PLongWord(Dest)^ := Round(Source.Z * 255.0) or (Round(Source.Y * 255.0) shl 8) or
        (Round(Source.X * 255.0) shl 16);

    pfA8B8G8R8:
      PLongWord(Dest)^ := Round(Source.X * 255.0) or (Round(Source.Y * 255.0) shl 8) or (Round(Source.Z * 255.0) shl 16)
        or (Round(Source.W * 255.0) shl 24);

    pfX8B8G8R8:
      PLongWord(Dest)^ := Round(Source.X * 255.0) or (Round(Source.Y * 255.0) shl 8) or
        (Round(Source.Z * 255.0) shl 16);

    pfR5G6B5:
      PWord(Dest)^ := Round(Source.X * 31.0) or (Round(Source.Y * 63.0) shl 5) or (Round(Source.Z * 31.0) shl 11);

    pfA4R4G4B4:
      PWord(Dest)^ := Round(Source.Z * 15.0) or (Round(Source.Y * 15.0) shl 4) or (Round(Source.X * 15.0) shl 8) or
        (Round(Source.W * 15.0) shl 12);

    pfA1R5G5B5:
      PWord(Dest)^ := Round(Source.Z * 31.0) or (Round(Source.Y * 31.0) shl 5) or (Round(Source.X * 31.0) shl 10) or
        (Round(Source.W) shl 15);

    pfX1R5G5B5:
      PWord(Dest)^ := Round(Source.Z * 31.0) or (Round(Source.Y * 31.0) shl 5) or (Round(Source.X * 31.0) shl 10);

    pfG16R16:
      PLongWord(Dest)^ := Round(Source.X * 65535.0) or (Round(Source.Y * 65535.0) shl 16);

    pfA8L8:
      PWord(Dest)^ := Round((Source.X * 0.3 + Source.Y * 0.59 + Source.Z * 0.11) * 255.0) or
        (Round(Source.W * 255.0) shl 8);

    pfA4L4:
      PByte(Dest)^ := Round((Source.X * 0.3 + Source.Y * 0.59 + Source.Z * 0.11) * 15.0) or
        (Round(Source.W * 15.0) shl 4);

    pfL16:
      PWord(Dest)^ := Round((Source.X * 0.3 + Source.Y * 0.59 + Source.Z * 0.11) * 65535.0);

    pfL8:
      PByte(Dest)^ := Round((Source.X * 0.3 + Source.Y * 0.59 + Source.Z * 0.11) * 255.0);

    pfA8:
      PByte(Dest)^ := Round(Source.W * 255.0);

    pfR32F:
      PSingle(Dest)^ := (Source.X * 0.3 + Source.Y * 0.59 + Source.Z * 0.11);

    pfA32B32G32R32:
      begin
        PLongWord(Dest)^ := Round(Source.X * High(LongWord));
        PLongWord(NativeInt(Dest) + 4)^ := Round(Source.Y * High(LongWord));
        PLongWord(NativeInt(Dest) + 8)^ := Round(Source.Z * High(LongWord));
        PLongWord(NativeInt(Dest) + 12)^ := Round(Source.W * High(LongWord));
      end;
  end;
end;

procedure AlphaColorToPixel(Source: Cardinal; Dest: Pointer; DestFormat: TPixelFormat);
begin
  case DestFormat of
    pfA8R8G8B8: PLongWord(Dest)^ := Source;
    pfA8B8G8R8: PLongWord(Dest)^ := RGBtoBGR(Source);
  else
    Float4ToPixel(ColorToVector3D(Source), Dest, DestFormat);
  end;
end;

procedure ScanlineToAlphaColor(Source, Dest: Pointer; PixelCount: Integer; SrcFormat: TPixelFormat);
var
  InpData: Pointer;
  OutData: PLongWord;
  Index, SrcPitch: Integer;
begin
  SrcPitch := GetPixelFormatBytes(SrcFormat);
  if (SrcPitch < 1) then
    Exit;

  InpData := Source;
  OutData := Dest;

  for Index := 0 to PixelCount - 1 do
  begin
    OutData^ := PixelToAlphaColor(InpData, SrcFormat);

    Inc(NativeInt(InpData), SrcPitch);
    Inc(OutData);
  end;
end;

procedure AlphaColorToScanline(Source, Dest: Pointer; PixelCount: Integer; DestFormat: TPixelFormat);
var
  InpData: PLongWord;
  OutData: Pointer;
  Index, DestPitch: Integer;
begin
  DestPitch := GetPixelFormatBytes(DestFormat);
  if (DestPitch < 1) then
    Exit;

  InpData := Source;
  OutData := Dest;

  for Index := 0 to PixelCount - 1 do
  begin
    AlphaColorToPixel(InpData^, OutData, DestFormat);

    Inc(InpData);
    Inc(NativeInt(OutData), DestPitch);
  end;
end;

function PixelFormatToString(Format: TPixelFormat): string;
var
  Desc: TPixelFormatDesc;
  Index: Integer;
begin
  Desc := GetPixelFormatDesc(Format);

  Result := '';

  case Desc.FormType of
    ftRGB, ftRGBf, ftLuminance, ftBump:
      begin
        for Index := MaxPixelFormatChannels - 1 downto 0 do
        begin
          if (Desc.Channels[Index].Size < 1) then
            Continue;

          Result := Result + Desc.Channels[Index].Letter + IntToStr(Desc.Channels[Index].Size);
        end;

        if (Desc.FormType = ftRGBf) then
          Result := Result + 'F';
      end;

    ftSpecial:
      begin
        case Format of
          pfR8G8_B8G8:
            Result := 'R8G8_B8G8';

          pfG8R8_G8B8:
            Result := 'G8R8_G8B8';

          pfCxV8U8:
            Result := 'CxV8U8';

        else
          begin
            for Index := MaxPixelFormatChannels - 1 downto 0 do
            begin
              if (Desc.Channels[Index].Size < 1) then
                Continue;

              Result := Result + Desc.Channels[Index].Letter;
            end;
          end;
        end;
      end;
  end;

  if (Result = '') then
    Result := 'pfUnknown'
  else
    Result := 'pf' + Result;
end;

function FindClosestPixelFormat(Format: TPixelFormat; const FormatList: TPixelFormatList): TPixelFormat;
var
  Possibilities: TPixelFormatList;
  Index: Integer;
  Comparer: TPixelFormatComparer;
begin
  if (FormatList.IndexOf(Format) <> -1) then
  begin
    Result := Format;
    Exit;
  end;

  Comparer := TPixelFormatComparer.Create();
  Comparer.Pivot := Format;

  Possibilities := TPixelFormatList.Create(Comparer);

  for Index := 0 to FormatList.Count - 1 do
    if (IsFormatConvertible(Format, FormatList[Index])) then
      Possibilities.Add(FormatList[Index]);

  Possibilities.Sort();

  if (Possibilities.Count > 0) then
    Result := Possibilities[0]
  else
    Result := pfUnknown;

  FreeAndNil(Possibilities);
end;

function TPixelFormatComparer.Compare(const Left, Right: TPixelFormat): Integer;
var
  Diff1, Diff2: Integer;
  Desc1, Desc2, SortDesc: TPixelFormatDesc;
begin
  Diff1 := GetChannelSizeDifference(FPivot, Left);
  Diff2 := GetChannelSizeDifference(FPivot, Right);

  if (Diff1 = Diff2) then
  begin
    Diff1 := GetChannelWastedBits(FPivot, Left);
    Diff2 := GetChannelWastedBits(FPivot, Right);
  end;

  if (Diff1 = Diff2) then
  begin
    Diff1 := GetChannelLocationDifference(FPivot, Left);
    Diff2 := GetChannelLocationDifference(FPivot, Right);
  end;

  if (Diff1 = Diff2) then
  begin
    Desc1 := GetPixelFormatDesc(Left);
    Desc2 := GetPixelFormatDesc(Left);

    Diff1 := Desc1.GetMeaningfulChannelCount();
    Diff2 := Desc2.GetMeaningfulChannelCount();

    if (Diff1 = Diff2) then
    begin
      SortDesc := GetPixelFormatDesc(FPivot);

      Diff1 := Abs(Desc1.BitCount - SortDesc.BitCount);
      Diff2 := Abs(Desc2.BitCount - SortDesc.BitCount);
    end;
  end;

  Result := 0;

  if (Diff1 > Diff2) then
    Result := 1;
  if (Diff1 < Diff2) then
    Result := -1;
end;

end.
