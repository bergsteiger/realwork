unit fcBitmap;
{
//
// Components : TfcBitmap
//
// Copyright (c) 1999 by Woll2Woll Software
}
interface

{$i fcIfDef.pas}

uses Windows, Graphics, Classes, fcGraphics, fcChangeLink, SysUtils;

type
  TfcColor = record
    b, g, r: Byte
  end;
  PfcColor = ^TfcColor;

  TfcLine = array[0..0] of TfcColor;
  PfcLine = ^TfcLine;

  TfcPLines = array[0..0] of PfcLine;
  PfcPLines = ^TfcPLines;

  TfcBitmap = class(TGraphic)
  private
    FSmoothStretching: Boolean;
    FTransparentColor: TColor;

    FWidth: Integer;
    FHeight: Integer;
    FGap: Integer;
    FMaskBitmap: TBitmap;
    FRowInc: Integer;
    FSize: Integer;
    FBits: Pointer;
    FHandle: Integer;
    FDC: HDC;
    FCanvas: TCanvas;

    FMemoryImage: Pointer;
    FMemorySize: Integer;
    FMemoryDim: TSize;

    FPixelFormat: TPixelFormat;
    FPalette: HPALETTE;
    FRespectPalette: Boolean;

    FIgnoreChange: Boolean;
    FChangeLinks: TList;

//    FPicture: TPicture;

    bmInfo: TBitmapInfo;
    bmHeader: TBitmapInfoHeader;
    function GetSleeping: Boolean;
    procedure InitHeader;
  protected
    Assigning: Boolean;

    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure Changed(Sender: TObject); override;
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;

    procedure CleanUp; virtual;
    procedure Initialize; virtual;
    procedure NotifyChanges; virtual;
    procedure PaletteNeeded; virtual;

    property Gap: Integer read FGap;
    property RowInc: Integer read FRowInc;
    property DC: HDC read FDC;
  public
    Patch: Variant;
    Pixels: PfcPLines;
    Colors: array[Byte] of TRGBQuad;

    constructor Create; override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    procedure RegisterChanges(ChangeLink: TfcChangeLink); virtual;
    procedure UnRegisterChanges(ChangeLink: TfcChangeLink); virtual;

    procedure Clear; virtual;
    procedure FreeMemoryImage; virtual;
    procedure LoadBlank(AWidth, AHeight: Integer); virtual;
    procedure LoadFromBitmap(Bitmap: TBitmap); virtual;
    procedure LoadFromJPEG(JPEG: TGraphic); virtual;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPALETTE); override;
    procedure LoadFromGraphic(Graphic: TGraphic); virtual;
    procedure LoadFromMemory(ABits: Pointer; ASize: Integer; Dimensions: TSize); virtual;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToBitmap(Bitmap: TBitmap); virtual;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
      var APalette: HPALETTE); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure SetSize(const AWidth, AHeight: Integer); virtual;

    function GetMaskBitmap: TBitmap;
    function CopyPixels: PfcPLines;
    procedure Fill(Color: TColor);
    procedure Resize(AWidth, AHeight: Integer); virtual;
    procedure Sleep; virtual;
    procedure SmoothStretchDraw(ACanvas: TCanvas; Rect: TRect); virtual;
    procedure StretchDraw(ACanvas: TCanvas; const Rect: TRect); virtual;
    procedure TileDraw(ACanvas: TCanvas; ARect: TRect); virtual;
    procedure TransparentDraw(ACanvas: TCanvas; const Rect: TRect); virtual;
    procedure Wake; virtual;

    // Filters
    procedure AlphaBlend(Bitmap: TfcBitmap; Alpha: Integer; Stretch: Boolean);
    procedure Blur(Amount: Integer); virtual;
    procedure Contrast(Amount: Integer); virtual;
    procedure Emboss; virtual;
    procedure Flip(Horizontal: Boolean); virtual;
    procedure GaussianBlur(Amount: Integer); virtual;
    procedure Grayscale; virtual;
    procedure Invert; virtual;
    procedure Brightness(Amount: Integer); virtual;
    procedure Mask(MaskColor: TfcColor); virtual;
    procedure ColorTint(ra, ga, ba: Integer); virtual;
    procedure Colorize(ra, ga, ba: Integer); virtual;
    procedure Rotate(Center: TPoint; Angle: Extended); virtual;
    procedure Saturation(Amount: Integer); virtual;
    procedure Sharpen(Amount: Integer); virtual;
    procedure Sponge(Amount: Integer); virtual;
    procedure Wave(XDiv, YDiv, RatioVal: Extended; Wrap: Boolean); virtual;

    property Bits: Pointer read FBits;
    property Canvas: TCanvas read FCanvas;
    property Handle: Integer read FHandle;
    property IgnoreChange: Boolean read FIgnoreChange write FIgnoreChange;
    property MaskBitmap: TBitmap read GetMaskBitmap;
    property RespectPalette: Boolean read FRespectPalette write FRespectPalette;
    property SmoothStretching: Boolean read FSmoothStretching write FSmoothStretching;
    property Sleeping: Boolean read GetSleeping;
    property Size: Integer read FSize;
    property TransparentColor: TColor read FTransparentColor write FTransparentColor;
  end;

function fcGetColor(Color: TColor): TfcColor;
function fcGetStdColor(Color: TfcColor): TColor;
function fcRGB(r, g, b: Byte): TfcColor;
function fcIntToByte(Value: Integer): Byte;
function fcTrimInt(i, Min, Max: Integer): Integer;

implementation

uses fcCommon;

{$R-}

function fcGetColor(Color: TColor): TfcColor;
begin
  //2/17/99 - Get Actual Color Value
  Color := ColorToRGB(Color);
  result.r := Color and $FF;
  result.g := Color and $FF00 shr 8;
  result.b := Color and $FF0000 shr 16;
end;

function fcGetStdColor(Color: TfcColor): TColor;
begin
  with Color do result := RGB(r, g, b);
end;

function fcRGB(r, g, b: Byte): TfcColor;
begin
  result.r := r;
  result.g := g;
  result.b := b;
end;

function fcIntToByte(Value: Integer): Byte;
begin
  if Value > 255 then result := 255
  else if Value < 0 then result := 0
  else result := Value;
end;

function fcTrimInt(i, Min, Max: Integer): Integer;
begin
  if i > Max then result := Max
  else if i < Min then result := Min
  else result := i;
end;

constructor TfcBitmap.Create;
begin
  inherited;
  FCanvas := TCanvas.Create;
  FChangeLinks := TList.Create;
  FTransparentColor := clNone;
  FPixelFormat := pf24Bit;
end;

destructor TfcBitmap.Destroy;
begin
  FChangeLinks.Free;
  if Sleeping then FreeMemoryImage;
  CleanUp;
  FCanvas.Free;
  inherited;
end;

function TfcBitmap.GetSleeping: Boolean;
begin
  result := (FMemorySize > 0) and (FMemoryImage <> nil);
end;

function TfcBitmap.GetEmpty: Boolean;
begin
  result := FHandle = 0;
end;

function TfcBitmap.GetHeight: Integer;
begin
  result := FHeight;
end;

function TfcBitmap.GetWidth: Integer;
begin
  result := FWidth;
end;

procedure TfcBitmap.Assign(Source: TPersistent);
begin
  if (Source is TBitmap) and not (Source as TBitmap).Empty then
  begin
    FPixelFormat := (Source as TBitmap).PixelFormat;
    LoadFromBitmap(Source as TBitmap);
    Transparent := (Source as TBitmap).Transparent;
//    TransparentColor := (Source as TBitmap).TransparentColor;
  end else if (Source = nil) or ((Source is TBitmap) and (Source as TBitmap).Empty) then
  begin
    CleanUp;
    Changed(self);
  end else if (Source is TGraphic) and not (Source is TfcBitmap) then
  begin
    LoadFromGraphic(Source as TGraphic);
  end else inherited;
end;

procedure TfcBitmap.AssignTo(Dest: TPersistent);
begin
  if Dest is TBitmap then
  begin
    (Dest as TBitmap).PixelFormat := self.FPixelFormat;
    SaveToBitmap(Dest as TBitmap);
    (Dest as TBitmap).Transparent := Transparent;
    (Dest as TBitmap).TransparentColor := TransparentColor;
  end else if Dest is TfcBitmap then
    with TfcBitmap(Dest) do
  begin
    if not self.Empty then
    begin
      IgnoreChange := True;
      RespectPalette := self.RespectPalette;
      LoadBlank(self.Width, self.Height);
      CopyMemory(TfcBitmap(Dest).Bits, self.Bits, self.Size);
      Transparent := self.Transparent;
      SmoothStretching := self.SmoothStretching;
      TransparentColor := self.TransparentColor;
      FPixelFormat := self.FPixelFormat;
      CopyMemory(@(Dest as TfcBitmap).Colors, @self.Colors, SizeOf(self.Colors));
      IgnoreChange := False;
      Changed(Dest);
    end else begin
      CleanUp;
      Changed(Dest);
    end;
  end else inherited;
end;

procedure TfcBitmap.Changed(Sender: TObject);
begin
  if not IgnoreChange then
  begin
    inherited Changed(Sender);
    NotifyChanges;
  end;
end;

procedure TfcBitmap.NotifyChanges;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do with TfcChangeLink(FChangeLinks[i]) do
  begin
    Sender := self;
    Change;
  end;
end;

procedure TfcBitmap.RegisterChanges(ChangeLink: TfcChangeLink);
begin
  FChangeLinks.Add(ChangeLink);
end;

procedure TfcBitmap.UnRegisterChanges(ChangeLink: TfcChangeLink);
begin
  FChangeLinks.Remove(ChangeLink);
end;

procedure TfcBitmap.TransparentDraw(ACanvas: TCanvas; const Rect: TRect);
var Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  Bmp.Width := Width;
  Bmp.Height := Height;
  Bmp.PixelFormat := pf24Bit;
  Bmp.Canvas.CopyRect(Classes.Rect(0, 0, Width, Height), Canvas, Classes.Rect(0, 0, Width, Height));
  fcDrawMask(ACanvas, Rect, Bmp, MaskBitmap, True);
  Bmp.Free;
end;

procedure TfcBitmap.StretchDraw(ACanvas: TCanvas; const Rect: TRect);
var TempBitmap: TfcBitmap;
begin
  if Transparent then
  begin
    TempBitmap := TfcBitmap.Create;
    TempBitmap.LoadBlank(fcRectWidth(Rect), fcRectHeight(Rect));
    StretchBlt(TempBitmap.Canvas.Handle, 0, 0, TempBitmap.Width, TempBitmap.Height,
      FDC, 0, 0, FWidth, FHeight, SRCCOPY);
    TempBitmap.TransparentDraw(ACanvas, Rect);
    TempBitmap.Free;
  end else begin
    SetStretchBltMode(ACanvas.Handle, COLORONCOLOR);
    with Rect do StretchBlt(ACanvas.Handle, Left, Top, Right - Left, Bottom - Top,
      FDC, 0, 0, FWidth, FHeight, SRCCOPY);
  end;
end;

procedure TfcBitmap.Draw(ACanvas: TCanvas; const Rect: TRect);
  function Transparent: Boolean;
  begin
    result := self.Transparent and not Assigning;
  end;
  function SmoothStretching: Boolean;
  begin
    result := self.SmoothStretching and not Assigning;
  end;
var OldPalette: HPALETTE;
begin
  OldPalette := 0;
  if (GetDeviceCaps(FDC, BITSPIXEL) <= 8) and RespectPalette then
  begin
    PaletteNeeded;
    OldPalette := SelectPalette(ACanvas.Handle, FPalette, True);
    RealizePalette(ACanvas.Handle);
  end;

  with Rect do
  begin
    if ((Right - Left) = Width) and ((Bottom - Top) = Height) then
    begin
      if Transparent then TransparentDraw(ACanvas, Rect)
      else BitBlt(ACanvas.Handle, Left, Top, Right - Left, Bottom - Top, FDC, 0, 0, SRCCOPY);
    end else begin
      if FSmoothStretching then SmoothStretchDraw(ACanvas, Rect)
      else StretchDraw(ACanvas, Rect);
    end;
  end;
  if (GetDeviceCaps(FDC, BITSPIXEL) <= 8) and RespectPalette then
  begin
    SelectPalette(ACanvas.Handle, OldPalette, True);
    if FPalette <> 0 then
    begin
      DeleteObject(FPalette);
      FPalette := 0;
    end;
  end;
end;

procedure TfcBitmap.Initialize;
var x, i: Integer;
    TempDC: HDC;
begin
  GetMem(Pixels, FHeight * SizeOf(PfcLine));
  FRowInc := (FWidth * 3) + FWidth mod 4;
  FGap := FWidth mod 4;
  FSize := FRowInc * FHeight;
  x := Integer(Bits);
  for i := 0 to Height - 1 do
  begin
    Pixels[i] := Pointer(x);
    Inc(x, RowInc);
  end;
  TempDC := GetDC(0);
  FDC := CreateCompatibleDC(TempDC);
  ReleaseDC(0, TempDC);
  SelectObject(FDC, FHandle);
  if Handle = 0 then CleanUp;
  FCanvas.Handle := FDC;
  Changed(self);
end;

procedure TfcBitmap.PaletteNeeded;
var Pal: TMaxLogPalette;
begin
  if (FPalette <> 0) or (PInteger(@Colors[0])^ = 0) then Exit;

  Pal.palVersion := $300;
  Pal.palNumEntries := 256;
  Move(Colors, Pal.palPalEntry, 256 * 4);

  if (Pal.palNumEntries <> 16) then
    ByteSwapColors(Pal.palPalEntry, Pal.palNumEntries);
  FPalette := CreatePalette(PLogPalette(@Pal)^);
end;

procedure TfcBitmap.SetHeight(Value: Integer);
begin
  SetSize(Width, Height);
end;

procedure TfcBitmap.SetWidth(Value: Integer);
begin
  SetSize(Value, Height);
end;

procedure TfcBitmap.CleanUp;
begin
  FCanvas.Handle := 0;
  if FDC <> 0 then DeleteDC(FDC);
  if FHandle <> 0 then DeleteObject(FHandle);
  if Pixels <> nil then FreeMem(Pixels);
  if FMaskBitmap <> nil then FMaskBitmap.Free;
  FDC := 0;
  FHandle := 0;
  Pixels := nil;
  FMaskBitmap := nil;
  FWidth := 0;
  FHeight := 0;
  FSize := 0;
  FBits := nil;
end;

procedure TfcBitmap.Clear;
begin
  CleanUp;
end;

procedure TfcBitmap.FreeMemoryImage;
begin
  FreeMem(FMemoryImage);
  FMemoryImage := nil;
  FMemoryDim := fcSize(0, 0);
  FMemorySize := 0;
end;

procedure TfcBitmap.InitHeader;
begin
  with bmHeader do
  begin
    biSize := SizeOf(bmHeader);
    biWidth := Width;
    biHeight := -Height;
    biPlanes := 1;
    biBitCount := 24;
    biCompression := BI_RGB;
  end;
end;

procedure TfcBitmap.LoadBlank(AWidth, AHeight: Integer);
begin
  CleanUp;
  if (AWidth = 0) or (AHeight = 0) then Exit;

  FWidth := AWidth;
  FHeight := AHeight;

  InitHeader;

  bmInfo.bmiHeader := bmHeader;
  FHandle := CreateDIBSection(0, bmInfo, DIB_RGB_COLORS, FBits, 0, 0);
  Initialize;
  FCanvas.Brush.Color := clWhite;
  FCanvas.FillRect(Rect(0, 0, FWidth, FHeight));
end;

procedure TfcBitmap.LoadFromBitmap(Bitmap: TBitmap);
var MemDC: Integer;
  { RSW - 3/2/99}
  procedure SetPixelFormat;
  var DS: TDIBSection;
  begin
    FPixelFormat:= Bitmap.PixelFormat;
    if Bitmap.PixelFormat <> pfCustom then exit;

    DS.dsbmih.biSize := 0;
    GetObject(Bitmap.Handle, SizeOf(DS), @DS);
    case DS.dsbmih.biBitCount of
    1: FPixelFormat:= pf1bit;
    4: FPixelFormat:= pf4bit;
    8: FPixelFormat:= pf8bit;
    16: FPixelFormat:= pf16bit;
    24: FPixelFormat:= pf24bit;
    32: FPixelFormat:= pf32bit;
    end;
  end;

begin
  CleanUp;
  FWidth := Bitmap.Width;
  FHeight := Bitmap.Height;
  FSize := ((FWidth * 3) + (FWidth mod 4)) * FHeight;

  InitHeader;

  bmInfo.bmiHeader := bmHeader;
  FHandle := CreateDIBSection(0, bmInfo, DIB_RGB_COLORS, FBits, 0, 0);
  MemDC := GetDC(0);
  GetDIBits(MemDC, Bitmap.Handle, 0, FHeight, FBits, bmInfo, DIB_RGB_COLORS);
  ReleaseDC(0, MemDC);
  Initialize;
//  FPixelFormat := Bitmap.PixelFormat;
  SetPixelFormat;
  GetDIBColorTable(Bitmap.Canvas.Handle, 0, 256, Colors);
end;

procedure TfcBitmap.LoadFromJPEG(JPEG: TGraphic);
var ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  ABitmap.Width := JPEG.Width;
  ABitmap.Height := JPEG.Height;
  ABitmap.Canvas.Draw(0, 0, JPEG);
  LoadFromBitmap(ABitmap);
  ABitmap.Free;
end;

procedure TfcBitmap.LoadFromGraphic(Graphic: TGraphic);
var ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  ABitmap.Assign(Graphic);
  LoadFromBitmap(ABitmap);
  ABitmap.Free;
end;

procedure TfcBitmap.LoadFromClipboardFormat(AFormat: Word; AData: THandle;
  APalette: HPALETTE);
begin
end;

procedure TfcBitmap.LoadFromMemory(ABits: Pointer; ASize: Integer; Dimensions: TSize);
var MemDC: Integer;
    TempBmHandle: HBITMAP;
begin
  CleanUp;
  FWidth := Dimensions.cx;
  FHeight := Dimensions.cy;
  FSize := ASize;

  InitHeader;

  bmInfo.bmiHeader := bmHeader;
  MemDC := GetDC(0);
  FHandle := CreateDIBSection(0, bmInfo, DIB_RGB_COLORS, FBits, 0, 0);
  TempBmHandle := CreateDIBitmap(MemDC, bmHeader, CBM_INIT, ABits, bmInfo, DIB_RGB_COLORS);
  GetDIBits(MemDC, TempBmHandle, 0, FHeight, FBits, bmInfo, DIB_RGB_COLORS);
  DeleteObject(TempBmHandle);
  ReleaseDC(0, MemDC);
  Initialize;
end;

procedure TfcBitmap.LoadFromStream(Stream: TStream);
var Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.LoadFromStream(Stream);
    LoadFromBitmap(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

procedure TfcBitmap.SaveToBitmap(Bitmap: TBitmap);
begin
  Bitmap.PixelFormat := FPixelFormat;
  Bitmap.Width := Width;
  Bitmap.Height := Height;
  SetDIBColorTable(Bitmap.Canvas.Handle, 0, 256, Colors);
  Assigning := True;
  Bitmap.Canvas.Draw(0, 0, self);
  Assigning := False;
end;

procedure TfcBitmap.SetSize(const AWidth, AHeight: Integer);
begin
  if (AWidth <> Width) or (AHeight <> Height) then
    LoadBlank(AWidth, AHeight);
end;

procedure TfcBitmap.SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
  var APalette: HPALETTE);
begin
end;

procedure TfcBitmap.SaveToStream(Stream: TStream);
var Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    SaveToBitmap(Bitmap);
    Bitmap.SaveToStream(Stream);
  finally
    Bitmap.Free;
  end;
end;

function TfcBitmap.GetMaskBitmap: TBitmap;
var Bitmap: TfcBitmap;
    TranColor: TfcColor;
begin
  if FMaskBitmap = nil then
  begin
    FMaskBitmap := TBitmap.Create;
    Bitmap := TfcBitmap.Create;
    Bitmap.Assign(self);
    TranColor := Bitmap.Pixels[0, 0];
    if TransparentColor <> clNone then TranColor := fcGetColor(TransparentColor);
    Bitmap.Mask(TranColor);
    FMaskBitmap.Assign(Bitmap);
    FMaskBitmap.Monochrome := True;
    Bitmap.Free;
  end;
  result := FMaskBitmap;
end;

function TfcBitmap.CopyPixels: PfcPLines;
begin
  GetMem(result, FHeight * SizeOf(PfcLine));
  CopyMemory(result, Pixels, FHeight * SizeOf(PfcLine));
end;

procedure TfcBitmap.Fill(Color: TColor);
var Brush: HBRUSH;
begin
  Brush := CreateSolidBrush(ColorToRGB(Color));
  try
    FillRect(FDC, Rect(0, 0, FWidth, FHeight), Brush);
  finally
    DeleteObject(Brush);
  end;
end;

procedure TfcBitmap.Resize(AWidth, AHeight: Integer);
var ABitmap: TfcBitmap;
begin
  if (AWidth = Width) and (AHeight = Height) then Exit;
  ABitmap := TfcBitmap.Create;
  try
    ABitmap.Assign(self);
    LoadBlank(AWidth, AHeight);
    Canvas.StretchDraw(Rect(0, 0, AWidth, AHeight), ABitmap);
  finally
    ABitmap.Free;
  end;
end;

procedure TfcBitmap.SmoothStretchDraw(ACanvas: TCanvas; Rect: TRect);
var x, y, xP, yP, yP2, xP2: Integer;
    Read, Read2: PfcLine;
    t, z, z2, iz2: Integer;
    pc: PfcColor;
    w1,w2,w3,w4: Integer;
    Col1,Col2:   PfcColor;
    Dst: TfcBitmap;
begin
  Dst := TfcBitmap.Create;
  Dst.LoadBlank(fcRectWidth(Rect), fcRectHeight(Rect));
  if(Dst.FWidth<1)or(Dst.FHeight<1)then Exit;
  if(Dst.FWidth=FWidth)and(Dst.FHeight=FHeight)then
  begin
    CopyMemory(Dst.FBits, FBits, FSize);
    Exit;
  end;
  xP2:=((FWidth-1)shl 15)div Dst.FWidth;
  yP2:=((FHeight-1)shl 15)div Dst.FHeight;
  yP:=0;
  for y:=0 to Dst.FHeight-1 do
  begin
    xP:=0;
    Read:=Pixels[yP shr 15];
    if yP shr 16<FHeight-1 then
      Read2:=Pixels[yP shr 15+1]
    else
      Read2:=Pixels[yP shr 15];
    pc:=@Dst.Pixels[y,0];
    z2:=yP and $7FFF;
    iz2:=$8000-z2;
    for x:=0 to Dst.FWidth-1 do
    begin
      t:=xP shr 15;
      Col1:=@Read[t];
      Col2:=@Read2[t];
      z:=xP and $7FFF;
      w2:=(z*iz2)shr 15;
      w1:=iz2-w2;
      w4:=(z*z2)shr 15;
      w3:=z2-w4;
      pc.b:=
        (Col1.b*w1+PfcColor(Integer(Col1)+3).b*w2+
         Col2.b*w3+PfcColor(Integer(Col2)+3).b*w4)shr 15;
      pc.g:=
        (Col1.g*w1+PfcColor(Integer(Col1)+3).g*w2+
         Col2.g*w3+PfcColor(Integer(Col2)+3).g*w4)shr 15;
      pc.r:=
        (Col1.r*w1+PfcColor(Integer(Col1)+3).r*w2+
         Col2.r*w3+PfcColor(Integer(Col2)+3).r*w4)shr 15;
      Inc(pc);
      Inc(xP,xP2);
    end;
    Inc(yP,yP2);
  end;
  if Transparent then Dst.TransparentDraw(ACanvas, Rect)
  else ACanvas.Draw(Rect.Left, Rect.Top, Dst);
  Dst.Free;
end;

procedure TfcBitmap.TileDraw(ACanvas: TCanvas; ARect: TRect);
var RectSize: TSize;
    i, j: Integer;
begin
  if Empty then exit; { 4/5/99 - RSW }

  { 4/10/99 - RSW - Code changed so that tiledraw paints at least to bottom right of ARect }
  with ARect, RectSize do
  begin
    cx := Right;
    cy := Bottom;
  end;

{  with ARect, RectSize do
  begin
    cx := Right - Left;
    cy := Bottom - Top;
  end;
}
  j := 0;
  while j < RectSize.cy do
  begin
    i := 0;
    while i < RectSize.cx do
    begin
      ACanvas.Draw(i - ARect.Left, j - ARect.Top, self);
      inc(i, FWidth);
    end;
    inc(j, FHeight);
  end;
end;

// Filter Methods

procedure TfcBitmap.Brightness(Amount: Integer);
var x,y: Integer;
    Table: array[0..255] of Byte;
    CurBits: PfcColor;
begin
  if Amount > 0 then
    for x:=0 to 255 do Table[x] := fcIntToByte(x + ((Amount * (x xor 255)) shr 8))
  else for x:=0 to 255 do Table[x] := fcIntToByte(x - ((Abs(Amount) * x) shr 8));

  CurBits := Bits;

  for y := 1 to FHeight do
  begin
    for x := 1 to FWidth do
    begin
      CurBits.b := Table[CurBits.b];
      CurBits.g := Table[CurBits.g];
      CurBits.r := Table[CurBits.r];
      Inc(CurBits);
    end;
    CurBits := Pointer(Integer(CurBits) + Gap);
  end;
end;

procedure TfcBitmap.Saturation(Amount: Integer);
var Grays: array[0..255] of Byte;
    Alpha: array[0..255] of Word;
    Gray: Byte;
    x, y, ag: Integer;
    CurBits: TfcColor;
    pc: PfcColor;
begin
  x:=0;
  y:=0;
  for ag := 0 to 85 do
  begin
    Grays[x + 0] := y;
    Grays[x + 1] := y;
    Grays[x + 2] := y;
    Inc(y);
    Inc(x, 3);
  end;

  for x := 0 to 255 do Alpha[x] := (x * Amount) shr 8;
  pc := Bits;
  for y := 0 to FHeight - 1 do
  begin
    for x := 0 to FWidth - 1 do
    begin
      CurBits := pc^;
      Gray := Grays[CurBits.r] + Grays[CurBits.g] + Grays[CurBits.b];
      ag := Alpha[Gray];
      pc.b := fcIntToByte(Gray + (Alpha[CurBits.b] - ag));
      pc.g := fcIntToByte(Gray + (Alpha[CurBits.g] - ag));
      pc.r := fcIntToByte(Gray + (Alpha[CurBits.r] - ag));
      Inc(pc);
    end;
    pc := Pointer(Integer(pc) + Gap);
  end;
end;

procedure TfcBitmap.ColorTint(ra, ga, ba: Integer);
var Table: array[0..255] of TfcColor;
    x, y, i: Integer;
    CurBits: PfcColor;
begin
  for i := 0 to 255 do
  begin
    Table[i].b := fcIntToByte(i + ba);
    Table[i].g := fcIntToByte(i + ga);
    Table[i].r := fcIntToByte(i + ra);
  end;
  CurBits := Bits;
  for y := 0 to Height - 1 do
  begin
    for x := 0 to Width - 1 do
    begin
      CurBits.b := Table[CurBits.b].b;
      CurBits.g := Table[CurBits.g].g;
      CurBits.r := Table[CurBits.r].r;
      Inc(CurBits);
    end;
    CurBits := Pointer(Integer(CurBits) + Gap);
  end;
end;

procedure TfcBitmap.Colorize(ra, ga, ba: Integer);
var x, y: Integer;
    CurBits: PfcColor;
    Tran: Boolean;
    TranColor: TfcColor;
begin
  CurBits := Bits;
  Tran := FTransparentColor <> clNone;
  TranColor := fcGetColor(FTransparentColor);
  for y := 0 to Height - 1 do
  begin
    for x := 0 to Width - 1 do
    begin
      with TranColor do if not Tran or (Tran and not ((r = Pixels[y, x].r) and (g = Pixels[y, x].g) and (b = Pixels[y, x].b))) then
      begin
        CurBits.b := fcIntToByte((CurBits.b - 192) + ba);
        CurBits.g := fcIntToByte((CurBits.g - 192) + ga);
        CurBits.r := fcIntToByte((CurBits.r - 192) + ra);
      end;
      Inc(CurBits);
    end;
    CurBits := Pointer(Integer(CurBits) + Gap);
  end;
end;

procedure TfcBitmap.Contrast(Amount: Integer);
var x, y: Integer;
    Table: array[0..255] of Byte;
    CurBits: PfcColor;
begin
  for x := 0 to 126 do
  begin
    y := (Abs(128 - x) * Amount) div 256;
    y := x - y;
    Table[x] := fcIntToByte(y);
  end;
  for x := 127 to 255 do
  begin
    y := (Abs(128 - x) * Amount) div 256;
    y := x + y;
    Table[x] := fcIntToByte(y);
  end;
  CurBits := Bits;
  for y := 1 to FHeight do
  begin
    for x := 1 to FWidth do
    begin
      CurBits.b := Table[CurBits.b];
      CurBits.g := Table[CurBits.g];
      CurBits.r := Table[CurBits.r];
      Inc(CurBits);
    end;
    CurBits := Pointer(Integer(CurBits) + Gap);
  end;
end;

procedure TfcBitmap.AlphaBlend(Bitmap: TfcBitmap; Alpha: Integer; Stretch: Boolean);
var x, y, i: Integer;
    c1, c2, c3: PfcColor;
    Table: array[-255..255] of Integer;
    TranColor: TfcColor;
    Tran: Boolean;
    PassedBm: TfcBitmap;
begin
  PassedBm := nil;
  if (Width <> Bitmap.Width) or (Height <> Bitmap.Height) then
  begin
    if not Stretch then raise EInvalidOperation.Create('In Alpha Blend, Blend Bitmap must be same dimensions as Current Bitmap')
    else begin
      PassedBm := Bitmap;
      Tran := PassedBm.Transparent;
      PassedBm.Transparent := False;
      Bitmap := TfcBitmap.Create;
      Bitmap.Transparent := Tran;
      Bitmap.LoadBlank(Width, Height);
      Bitmap.Canvas.StretchDraw(Rect(0, 0, Width - 1, Height - 1), PassedBm);
      PassedBm.Transparent := Tran;
    end;
  end;

  for i := -255 to 255 do Table[i] := (Alpha * i) shr 8;
  TranColor := fcGetColor(0);
  c1 := Bits;
  c2 := Bitmap.Bits;
  c3 := Bits;

  Tran := Bitmap.Transparent and (Bitmap.Height = Height) and (Bitmap.Width = Width);
  if Tran then
  begin
{    if TransparentColor = clNone then TranColor := c2^
    else TranColor := fcGetColor(TransparentColor);}
    TranColor := c2^;
  end;

  for y := 0 to FHeight - 1 do
  begin
    for x := 0 to FWidth - 1 do
    begin
      if not Tran or (Tran and not ((c2.r = TranColor.r) and (c2.g = TranColor.g) and (c2.b = TranColor.b))) then
      begin
        c1.b := Table[c2.b - c3.b] + c3.b;
        c1.g := Table[c2.g - c3.g] + c3.g;
        c1.r := Table[c2.r - c3.r] + c3.r;
      end;
      Inc(c1);
      Inc(c2);
      Inc(c3);
    end;
    c1 := Pointer(Integer(c1) + Gap);
    c2 := Pointer(Integer(c2) + Bitmap.Gap);
    c3 := Pointer(Integer(c3) + Gap);
  end;
  if PassedBm <> nil then Bitmap.Free;
end;

procedure TfcBitmap.Grayscale;
var Grays: array[0..256] of Byte;
    i, x, y: Integer;
    CurBits: PfcColor;
begin
  x := 0; y := 0;
  for i := 0 to 85 do
  begin
    Grays[x + 0] := y;
    Grays[x + 1] := y;
    Grays[x + 2] := y;
    Inc(y);
    Inc(x, 3);
  end;
  CurBits := Bits;
  for y := 0 to FHeight - 1 do
  begin
    for x := 0 to FWidth - 1 do
    begin
      i := Grays[CurBits.b] + Grays[CurBits.g] + Grays[CurBits.r];
      CurBits.b := i;
      CurBits.g := i;
      CurBits.r := i;
      Inc(CurBits);
    end;
    CurBits := Pointer(Integer(CurBits) + Gap);
  end;
end;

procedure TfcBitmap.Invert;
var x, y: Integer;
    CurBits: PfcColor;
begin
  CurBits := Bits;
  for y := 0 to FHeight - 1 do
  begin
    for x := 0 to Width - 1 do
    begin
      CurBits.b := CurBits.b xor 255;
      CurBits.g := CurBits.g xor 255;
      CurBits.r := CurBits.r xor 255;
      Inc(CurBits);
    end;
    CurBits := Pointer(Integer(CurBits) + Gap);
  end;
end;

procedure TfcBitmap.Flip(Horizontal: Boolean);
var w, h, x, y: Integer;
    CurBits:  TfcColor;
    TmpLine, TmpLine2, Line: PfcLine;
    TopY: Integer;
begin
  TmpLine := nil;
  w := FWidth - 1;
  h := FHeight - 1;

  TopY := FHeight - 1;
  if not Horizontal then
  begin
    TopY := h div 2;
    GetMem(TmpLine, RowInc);
  end;

  try
    Line := Bits;
    for y := 0 to TopY do
    begin
      if Horizontal then for x := 0 to w div 2 do
      begin
        CurBits := Line[x];
        Line[x] := Line[w - x];
        Line[w - x] := CurBits;
      end else begin
        TmpLine2 := Pointer(Integer(Bits) + (h - y) * RowInc);
        CopyMemory(TmpLine, Line, RowInc);
        CopyMemory(Line, TmpLine2, RowInc);
        CopyMemory(TmpLine2, TmpLine, RowInc);
      end;
      Line := Pointer(Integer(Line) + RowInc);
    end;
  finally
    if not Horizontal then FreeMem(TmpLine);
  end;
end;

procedure TfcBitmap.Blur(Amount: Integer);
var Lin1, Lin2: PfcLine;
    pc: PfcColor;
    cx, x, y: Integer;
    Buf: array[0..3] of TfcColor;
begin
  pc := Bits;
  for y := 0 to FHeight - 1 do
  begin
    Lin1 := Pixels[fcTrimInt(y + Amount, 0, FHeight - 1)];
    Lin2 := Pixels[fcTrimInt(y - Amount, 0, FHeight - 1)];
    for x := 0 to FWidth - 1 do
    begin
      cx := fcTrimInt(x + Amount, 0, FWidth - 1);
      Buf[0] := Lin1[cx];
      Buf[1] := Lin2[cx];
      cx := fcTrimInt(x - Amount, 0, Width - 1);
      Buf[2] := Lin1[cx];
      Buf[3] := Lin2[cx];
      pc.b := (Buf[0].b + Buf[1].b + Buf[2].b + Buf[3].b) shr 2;
      pc.g := (Buf[0].g + Buf[1].g + Buf[2].g + Buf[3].g) shr 2;
      pc.r := (Buf[0].r + Buf[1].r + Buf[2].r + Buf[3].r) shr 2;
      Inc(pc);
    end;
    pc := Pointer(Integer(pc) + Gap);
  end;
end;

procedure TfcBitmap.GaussianBlur(Amount: Integer);
var i: Integer;
begin
  for i := Amount downto 1 do
  Blur(i);
end;

procedure TfcBitmap.Sharpen(Amount: Integer);
var Lin0, Lin1, Lin2: PfcLine;
    pc: PfcColor;
    cx, x, y: Integer;
    Buf: array[0..8] of TfcColor;
begin
  pc := Bits;
  for y := 0 to FHeight - 1 do
  begin
    Lin0 := Pixels[fcTrimInt(y - Amount, 0, Height - 1)];
    Lin1 := Pixels[y];
    Lin2 := Pixels[fcTrimInt(y + Amount, 0, FHeight - 1)];
    for x := 0 to FWidth - 1 do
    begin
      cx := fcTrimInt(x - Amount, 0, FWidth - 1);
      Buf[0]:=Lin0[cx];
      Buf[1]:=Lin1[cx];
      Buf[2]:=Lin2[cx];
      Buf[3]:=Lin0[x];
      Buf[4]:=Lin1[x];
      Buf[5]:=Lin2[x];
      cx := fcTrimInt(x + Amount, 0, FWidth - 1);
      Buf[6]:=Lin0[cx];
      Buf[7]:=Lin1[cx];
      Buf[8]:=Lin2[cx];
      pc.b := fcIntToByte((256 * Buf[4].b - (Buf[0].b + Buf[1].b +
        Buf[2].b + Buf[3].b + Buf[5].b + Buf[6].b + Buf[7].b +
        Buf[8].b) * 16) div 128);
      pc.g := fcIntToByte((256*Buf[4].g - (Buf[0].g + Buf[1].g + Buf[2].g +
        Buf[3].g + Buf[5].g + Buf[6].g + Buf[7].g + Buf[8].g) * 16)
        div 128);
      pc.r := fcIntToByte((256*Buf[4].r - (Buf[0].r + Buf[1].r + Buf[2].r +
        Buf[3].r + Buf[5].r + Buf[6].r + Buf[7].r + Buf[8].r) * 16)
        div 128);
      Inc(pc);
    end;
    pc := Pointer(Integer(pc) + Gap);
  end;
end;

procedure TfcBitmap.Sponge(Amount: Integer);
var r, x, y: Integer;
begin
  for y := 0 to FHeight - 1 do
    for x := 0 to FWidth - 1 do
    begin
      r := Random(Amount);
      Pixels[y, x] := Pixels[
        fcTrimInt(y + (r - Random(r * 2)), 0, FHeight - 1),
        fcTrimInt(x + (r - Random(r * 2)), 0, FWidth - 1)
      ];
    end;
end;

procedure TfcBitmap.Emboss;
var x, y: Integer;
    p1, p2: PfcColor;
    Line: PfcLine;
begin
  p1 := Bits;
  p2 := Pointer(Integer(p1) + RowInc + 3);
  GetMem(Line, RowInc);
  CopyMemory(Line, Pixels[FHeight - 1], RowInc);
  for y := 0 to Height - 1 do
  begin
    for x := 0 to Width - 1 do
    begin
      p1.b := (p1.b + (p2.b xor $FF)) shr 1;
      p1.g := (p1.g + (p2.g xor $FF)) shr 1;
      p1.r := (p1.r + (p2.r xor $FF)) shr 1;
      Inc(p1);
      if(y < FHeight - 2) and (x < FWidth - 2) then Inc(p2);
    end;
    p1 := Pointer(Integer(p1) + FGap);
    if y < FHeight - 2 then p2 := Pointer(Integer(p2) + Gap + 6)
    else p2 := Pointer(Integer(Line) + 3);
  end;
  FreeMem(Line);
end;

procedure TfcBitmap.Mask(MaskColor: TfcColor);
var x, y: Integer;
begin
  for y := 0 to FHeight - 1 do
    for x := 0 to FWidth - 1 do
      with Pixels[y, x] do
    begin
      if (r = MaskColor.r) and (g = MaskColor.g) and (b = MaskColor.b) then
        Pixels[y, x] := fcRGB(0, 0, 0)
      else Pixels[y, x] := fcRGB(255, 255, 255);
    end;
end;

procedure TfcBitmap.Wave(XDiv, YDiv, RatioVal: Extended; Wrap: Boolean);
type
  TArray = array[0..0]of Integer;
  PArray = ^TArray;
var i, j, XSrc, YSrc: Integer;
    st: PArray;
    Pix: PfcColor;
    Line: PfcLine;
    Dst: TfcBitmap;
    Max: Integer;
    PInt: PInteger;
begin
  if (YDiv = 0) or (XDiv = 0) then Exit;
  Line := nil;
  Max := 0;

  Dst := TfcBitmap.Create;
  Dst.LoadBlank(FWidth, FHeight);
  GetMem(st, 4 * FHeight);

  try
    for j := 0 to FHeight - 1 do
      st[j] := Round(RatioVal * Sin(j / YDiv));

    if Wrap then Max := Integer(Pixels[FHeight - 1]) + RowInc;

    for i := 0 to FWidth - 1 do
    begin
      YSrc := Round(RatioVal * Sin(i / XDiv));

      if Wrap then
      begin
        if YSrc < 0 then YSrc := FHeight - 1 - (-YSrc mod FHeight)
        else if YSrc >= FHeight then YSrc := YSrc mod (FHeight - 1);
      end;

      Pix := Pointer(Integer(Dst.Bits) + i * 3);
      if ((YSrc >= 0) and (YSrc < FHeight)) or Wrap then Line := Pixels[YSrc];
      PInt := PInteger(st);

      for j := 0 to FHeight - 1 do
      begin
        if Wrap then
        begin
          XSrc := i + PInt^;
          Inc(PInt);
          if XSrc < 0 then
            XSrc := FWidth - 1 - (-XSrc mod FWidth)
          else if XSrc >= FWidth then
            XSrc := XSrc mod FWidth;
          Pix^ := Line[XSrc];
          Pix := Pointer(Integer(Pix) + Dst.RowInc);
          Line := Pointer(Integer(Line) + FRowInc);
          if Integer(Line) >= Max then Line := FBits;
        end else begin
          if (YSrc >= FHeight) then Break;
          XSrc := i + st[j];
          if (XSrc > -1) and (XSrc < FWidth) and (YSrc > -1) then
            Pix^ := Line^[XSrc]
          else if YSrc = -1 then
          begin
            Pix := Pointer(Integer(Pix) + Dst.RowInc);
            Line := FBits;
            YSrc:=0;
            Continue;
          end;
          Pix := Pointer(Integer(Pix) + Dst.RowInc);
          Line := Pointer(Integer(Line) + RowInc);
          Inc(YSrc);
        end;
      end;
    end;
    CopyMemory(FBits, Dst.Bits, FSize);
  finally
    FreeMem(st);
    Dst.Free;
  end;
end;

procedure TfcBitmap.Rotate(Center: TPoint; Angle: Extended);
var cAngle, sAngle: Double;                   // Cos Angle, Sin Angle, respectively
    SrcX, SrcY, px, py, x, y: Integer;
    CurBits: PfcColor;
    Dst: TfcBitmap;
begin
  if Center.x < 0 then Center.X := FWidth div 2;
  if Center.y < 0 then Center.Y := FHeight div 2;

  Dst := TfcBitmap.Create;
  Dst.LoadBlank(Width, Height);
  Dst.Canvas.Brush.Color := fcGetStdColor(Pixels[0, 0]);
  Dst.Canvas.FillRect(Rect(0, 0, Dst.Width, Dst.Height));
  Angle := -Angle * Pi / 180;
  sAngle := Sin(Angle);
  cAngle := Cos(Angle);
  CurBits := Dst.Bits;
  for y := 0 to Dst.Height - 1 do
  begin
    py := 2 * (y - Center.y) + 1;
    for x := 0 to Dst.Width - 1 do
    begin
      px := 2 * (x - Center.x) + 1;
      SrcX := ((Round(px * cAngle - py * sAngle) - 1) div 2 + Center.x);
      SrcY:= ((Round(px * sAngle + py * cAngle) - 1) div 2 + Center.y);
      if (SrcX > -1) and (SrcX < FWidth) and (SrcY > -1) and (SrcY < FHeight) then
        CurBits^ := Pixels[SrcY, SrcX];
      Inc(CurBits);
    end;
    CurBits := Pointer(Integer(CurBits) + Dst.Gap);
  end;
  CopyMemory(FBits, Dst.Bits, FSize);
  Dst.Free;
end;

procedure TfcBitmap.Sleep;
begin
  if Sleeping then FreeMemoryImage;

  FMemorySize := FSize;
  FMemoryDim := fcSize(Width, Height);
  GetMem(FMemoryImage, FMemorySize);
  CopyMemory(FMemoryImage, FBits, FMemorySize);
  CleanUp;
end;

procedure TfcBitmap.Wake;
begin
  if (FMemoryImage = nil) or (FMemorySize = 0) then Exit;

  LoadFromMemory(FMemoryImage, FMemorySize, FMemoryDim);
  FreeMemoryImage;
end;

{$R+}

end.
