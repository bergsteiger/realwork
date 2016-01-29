{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

unit frmStyleImageSelect;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Clipbrd,
  ElXPThemedControl,
  ElBtnCtl,
  ElPopBtn,
  ExtCtrls,
  ElPanel,
  ElScrollBox,
  ElGroupBox,
  ElCheckCtl,
  ElEdits,
  ExtDlgs;

type

  TImageType = (itBitmap, itIcon);

  TStyleImageSelectForm = class(TForm)
    Panel1: TElPanel;
    OkButton: TElPopupButton;
    CancelButton: TElPopupButton;
    ElPanel1: TElPanel;
    ScrollBox: TElScrollBox;
    Image: TImage;
    btnLoad: TElPopupButton;
    btnSave: TElPopupButton;
    btnClear: TElPopupButton;
    btnPaste: TElPopupButton;
    btnCopy: TElPopupButton;
    SD: TSaveDialog;
    btnMono: TElPopupButton;
    procedure ImageListSelClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMonoClick(Sender: TObject);
  private
    { Private declarations }
    // Open Dialog Component:
    fOD: {$IFNDEF D_6_UP}
         TOpenDialog;
         {$ELSE}
         TOpenPictureDialog;
         {$ENDIF}
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    procedure CheckEnabledPaste;
    procedure CheckEnabledCopy;
  public
    { Public declarations }
    function isImage: Boolean;
    procedure SaveToStream(S:TStream; Format:TImageType);
    procedure LoadFromStream(S:TStream; Format: TImageType);
  end;

var
  StyleImageSelectForm: TStyleImageSelectForm;

resourcestring
  rsBitmapInvalid = 'Bitmap image is not valid';

type
  TCursorOrIcon = packed record
    Reserved: Word;
    wType: Word;
    Count: Word;
  end;

  PIconRec = ^TIconRec;
  TIconRec = packed record
    Width: Byte;
    Height: Byte;
    Colors: Word;
    Reserved1: Word;
    Reserved2: Word;
    DIBSize: Longint;
    DIBOffset: Longint;
  end;

const
  { Icon and cursor types }
  rc3_StockIcon = 0;
  rc3_Icon      = 1;
  rc3_Cursor    = 2;

implementation

{$R *.DFM}

function CreateIconFromBitmap(ABitmap: TBitmap): TIcon;
var
  sys_icon_width: integer;
  sys_icon_height: integer;
  mXorBitmap: TBitmap;
  mMonoBitmap: TBitmap;
  mBlackBitmap: TBitmap;
  icon_info: TIconInfo;
  R: TRect;
  TransparentColor: Tcolor;
begin
//???
  // set the icon size
  sys_icon_width := GetSystemMetrics(SM_CXICON);
  sys_icon_height := GetSystemMetrics(SM_CYICON);
  R := Rect(0, 0, sys_icon_width, sys_icon_height);
  mMonoBitmap := nil;
  mBlackBitmap := nil;
  // create xo mask
  mXorBitmap := TBitmap.Create;
  try
    mXorBitmap.Width := sys_icon_width;
    mXorBitmap.Height := sys_icon_height;
    // stretch Draw
    mXorBitmap.canvas.draw(0, 0, Abitmap);
    TransparentColor := mXorBitmap.Canvas.Pixels[0, sys_icon_height - 1];
    // create monochrome mask
    mMonoBitmap := TBitmap.Create;
    mMonoBitmap.Width := sys_icon_width;
    mMonoBitmap.Height := sys_icon_height;
    mMonoBitmap.Canvas.Brush.Color := Clwhite;
    mMonoBitmap.Canvas.FillRect(R);
    // create black mask
    mBlackBitmap := TBitmap.Create;
    mBlackBitmap.Width := sys_icon_width;
    mBlackBitmap.Height := sys_icon_height;
    // if transparent color is not black we We should impose the xor mask
    if TransparentColor <> clblack then
    begin
      mBlackBitmap.Canvas.Brush.Color := $F8F9FA;
      mBlackBitmap.Canvas.FillRect(R);
      mBlackBitmap.canvas.BrushCopy(R, mXorBitmap, R, clblack);
      mXorBitmap.Assign(mBlackBitmap);
    end;
    // make black mask
    mBlackBitmap.Canvas.Brush.Color := Clblack;
    mBlackBitmap.Canvas.FillRect(R);
    // paint xor mask (brushcopy)
    mBlackBitmap.canvas.BrushCopy(R, mXorBitmap, R, TransparentColor);
    mXorBitmap.Assign(mBlackBitmap);
    // set and paint the mono mask
    mXorBitmap.Transparent := true;
    mXorBitmap.TransparentColor := clblack;
    mMonoBitmap.Canvas.draw(0, 0, mXorBitmap);
    mMonoBitmap.canvas.copymode := cmsrcinvert;
    mMonoBitmap.canvas.CopyRect(R, mXorBitmap.canvas, R);
    mMonoBitmap.monochrome := true;
    // restore the black color in the image
    mBlackBitmap.Canvas.Brush.Color := Clblack;
    mBlackBitmap.Canvas.FillRect(R);
    mBlackBitmap.canvas.BrushCopy(R, mXorBitmap, R, $F8F9FA);
    mXorBitmap.Assign(mBlackBitmap);
    // Create icon
    Result := TIcon.Create;
    try
      icon_info.fIcon := true;
      icon_info.xHotspot := 0;
      icon_info.yHotspot := 0;
      icon_info.hbmMask := mMonoBitmap.Handle;
      icon_info.hbmColor := mXorBitmap.Handle;
      Result.Handle := CreateIconIndirect(icon_info);
    except
      Result.Free;
      Result := nil;
      raise;
    end;
  finally
    // free temporary bitmaps
    mXorBitmap.Free;
    mMonoBitmap.free;
    mBlackBitmap.free;
  end;
end;

procedure SaveColorIconToStream(Stream: TStream; Icon: HICON);

  function BytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: Longint): Longint;
  begin
    Dec(Alignment);
    Result := ((PixelsPerScanline * BitsPerPixel) + Alignment) and not Alignment;
    Result := Result div 8;
  end;

  procedure InitBitmapInfo(hBitmap: HBITMAP; var BI: TBitmapInfoHeader;
    Colors: Integer);
  var
    DIBSec: TDIBSection;
    cBytes: Integer;
  begin
    DIBSec.dsbmih.biSize := 0;
    cBytes := GetObject(hBitmap, SizeOf(TDIBSection), @DIBSec);
    if cBytes = 0 then
      raise Exception.Create(rsBitmapInvalid)
    else
      with DIBSec do
        if (cBytes >= (SizeOf(dsbm) + SizeOf(dsbmih))) and
          (dsbmih.biSize >= DWORD(SizeOf(dsbmih))) then
          BI := DIBSec.dsbmih
        else
        begin
          FillChar(BI, SizeOf(BI), 0);
          with BI, DIBSec.dsbm do
          begin
            biSize := SizeOf(TBitmapInfoHeader);
            biWidth := bmWidth;
            biHeight := bmHeight;
          end;
        end;
    with BI do
    begin
      if Colors <> 0 then
        case Colors of
          2: biBitCount := 1;
          16: biBitCount := 4;
          256: biBitCount := 8;
        end
      else
        biBitCount := DIBSec.dsbm.bmBitsPixel * DIBSec.dsbm.bmPlanes;
      biPlanes := 1;
      if biSizeImage = 0 then
        biSizeImage := BytesPerScanLine(biWidth, biBitCount, 32) *
          Abs(BI.biHeight);
    end;
  end;

  procedure _SetDIBSizes(Bitmap: HBITMAP; var InfoHeaderSize: DWORD;
    var ImageSize: DWORD; Colors: Integer);
  var
    BI: TBitmapInfoHeader;
  begin
    InitBitmapInfo(Bitmap, BI, Colors);
    if BI.biBitCount > 8 then
    begin
      InfoHeaderSize := SizeOf(TBitmapInfoHeader);
      if (BI.biCompression and BI_BITFIELDS) <> 0 then
        Inc(InfoHeaderSize, 12);
    end
    else
      InfoHeaderSize := SizeOf(TBitmapInfoHeader) + SizeOf(TRGBQuad) *
        (1 shl BI.biBitCount);
    ImageSize := BI.biSizeImage;
  end;

  function _SetDIB(Bitmap: HBITMAP; Palette: HPALETTE;
    var BitmapInfo; var Bits; Colors: Integer): Boolean;
  var
    OldPalete: HPALETTE;
    DC: HDC;
  begin
    InitBitmapInfo(Bitmap, TBitmapInfoHeader(BitmapInfo), Colors);
    OldPalete := 0;
    DC := CreateCompatibleDC(0);
    try
      if Palette <> 0 then
      begin
        OldPalete := SelectPalette(DC, Palette, False);
        RealizePalette(DC);
      end;
      Result := GetDIBits(DC, Bitmap, 0, TBitmapInfoHeader(BitmapInfo).biHeight,
        @Bits,
        TBitmapInfo(BitmapInfo), DIB_RGB_COLORS) <> 0;
    finally
      if OldPalete <> 0 then SelectPalette(DC, OldPalete, False);
      DeleteDC(DC);
    end;
  end;

var
  IconInfo: TIconInfo;
  MonoInfoSize, ColorInfoSize: DWORD;
  MonoBitsSize, ColorBitsSize: DWORD;
  MonoInfo, MonoBits, ColorInfo, ColorBits: Pointer;
  CI: TCursorOrIcon;
  List: TIconRec;
begin
  FillChar(CI, SizeOf(CI), 0);
  FillChar(List, SizeOf(List), 0);
  if not GetIconInfo(Icon, IconInfo) then
{$IFNDEF D_6_UP}
    raise Exception.Create('Windows error. Code:' +
      IntToStr(Windows.GetLastError));
{$ELSE}
    RaiseLastOSError;
{$ENDIF}
  try
    _SetDIBSizes(IconInfo.hbmMask, MonoInfoSize, MonoBitsSize, 2);
    _SetDIBSizes(IconInfo.hbmColor, ColorInfoSize, ColorBitsSize, 256);
    MonoInfo := nil;
    MonoBits := nil;
    ColorInfo := nil;
    ColorBits := nil;
    try
      MonoInfo := AllocMem(MonoInfoSize);
      MonoBits := AllocMem(MonoBitsSize);
      ColorInfo := AllocMem(ColorInfoSize);
      ColorBits := AllocMem(ColorBitsSize);
      _SetDIB(IconInfo.hbmMask, 0, MonoInfo^, MonoBits^, 2);
      _SetDIB(IconInfo.hbmColor, 0, ColorInfo^, ColorBits^, 256);
      with CI do
      begin
        CI.wType := RC3_ICON;
        CI.Count := 1;
      end;
      Stream.Write(CI, SizeOf(CI));
      with List, PBitmapInfoHeader(ColorInfo)^ do
      begin
        Width := biWidth;
        Height := biHeight;
        Colors := biPlanes * biBitCount;
        DIBSize := ColorInfoSize + ColorBitsSize + MonoBitsSize;
        DIBOffset := SizeOf(CI) + SizeOf(List);
      end;
      Stream.Write(List, SizeOf(List));
      with PBitmapInfoHeader(ColorInfo)^ do
        Inc(biHeight, biHeight); { color height includes mono bits }
      Stream.Write(ColorInfo^, ColorInfoSize);
      Stream.Write(ColorBits^, ColorBitsSize);
      Stream.Write(MonoBits^, MonoBitsSize);
    finally
      FreeMem(ColorInfo, ColorInfoSize);
      FreeMem(ColorBits, ColorBitsSize);
      FreeMem(MonoInfo, MonoInfoSize);
      FreeMem(MonoBits, MonoBitsSize);
    end;
  finally
    DeleteObject(IconInfo.hbmColor);
    DeleteObject(IconInfo.hbmMask);
  end;
end;

procedure ConvertColoredCanvasToMono(C: TCanvas);
var
  X, Y: Integer;
  Color: LongInt;
  R, G, B,
    ConvertedColor: Byte;
begin
  with C do
    for X := Cliprect.Left to ClipRect.Right do
      for Y := Cliprect.Top to ClipRect.Bottom do
      begin
        Color := ColorToRGB(Pixels[X, Y]);
        B := (Color and $FF0000) shr 16;
        G := (Color and $FF00) shr 8;
        R := (Color and $FF);
        ConvertedColor := HiByte(R * 77 + G * 151 + B * 28);
        Pixels[X, Y] := RGB(ConvertedColor, ConvertedColor, ConvertedColor);
      end;
end;

{ TStyleImageSelectForm }

procedure TStyleImageSelectForm.FormCreate(Sender: TObject);
begin
  fOD :=
{$IFNDEF D_6_UP}
  TOpenDialog.Create(Self);
{$ELSE}
  TOpenPictureDialog.Create(Self);
{$ENDIF}
    // properties:
  fOD.InitialDir := '.';
  fOD.Options := fOD.Options - [ofHideReadOnly];
  fOD.Filter :=
    'All Images (*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf)|*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf|' +
    'JPEG Image File (*.jpg)|*.jpg|' +
    'JPEG Image File (*.jpeg)|*.jpeg|' +
    'Bitmaps (*.bmp)|*.bmp|' +
    'Icons (*.ico)|*.ico|' +
    'Enhanced Metafiles (*.emf)|*.emf|' +
    'Metafiles (*.wmf)|*.wmf|' +
    'All (*.*)|*.*';
  fOD.Title := 'Load image file';
end;

function TStyleImageSelectForm.isImage: Boolean;
begin
  Result := Assigned(Image.Picture.Graphic) and (not
    Image.Picture.Graphic.Empty);
end;

procedure TStyleImageSelectForm.ImageListSelClick(Sender: TObject);
begin
  //editImageList.Enabled := radioFindImageList.Checked;
end;

procedure TStyleImageSelectForm.btnClearClick(Sender: TObject);
begin
  Image.Picture.Assign(nil);
  CheckEnabledCopy();
  btnSave.Enabled := isImage;
  btnClear.Enabled := btnSave.Enabled;
  btnMono.Enabled := btnSave.Enabled;
end;

//Load Image:

procedure TStyleImageSelectForm.btnLoadClick(Sender: TObject);
begin
  if not fOD.Execute then
    exit;
  Screen.Cursor := crHourGlass;
  try
    Image.Picture.LoadFromFile(fOD.FileName);
  finally
    Screen.Cursor := crDefault;
  end;
  CheckEnabledCopy();
  btnSave.Enabled := isImage;
  btnClear.Enabled := btnSave.Enabled;
  btnMono.Enabled := btnSave.Enabled;
end;

//Save Image:

procedure TStyleImageSelectForm.btnSaveClick(Sender: TObject);

procedure SaveGraphicAsBitmap(APixelFormat: TPixelFormat);
  var
    B: TBitmap;
    Graphic: TGraphic;
  begin
    if (Image.Picture.Graphic is TBitmap) and
      (Image.Picture.Bitmap.PixelFormat = APixelFormat) then
    begin
      Image.Picture.SaveToFile(SD.FileName);
      exit;
    end;
    Graphic := Image.Picture.Graphic;
    B := TBitmap.Create;
    with B do
    try
      Width := Graphic.Width;
      Height := Graphic.Height;
      PixelFormat := APixelFormat;
      Canvas.Draw(0, 0, Graphic);
      SaveToFile(SD.FileName);
    finally
      B.Free;
    end;
  end;

  procedure SaveGraphicAsIco(APixelFormat: TPixelFormat);
  var
    Icon: TIcon;
    FS: TFilestream;
    B: TBitmap;
  begin

    if (Image.Picture.Graphic is TIcon) then
    begin
      FS:=TFileStream.Create (SD.FileName, fmCreate or fmOpenWrite);
      try
        // 16 colors:
        // Image.Picture.Icon.SaveToStream(FS);
        // 2, 16, 256 colors:
        SaveColorIconToStream(FS, Image.Picture.Icon.Handle);
      finally
        FS.Free;
      end;
      exit;
    end;

    if Image.Picture.Graphic is TBitmap then
    begin
      B := Image.Picture.Bitmap;
      if B.PixelFormat = APixelFormat then
      begin
        FS := nil;
        Icon := CreateIconFromBitmap(B);
        if Assigned(Icon) then
        try
          FS := TFileStream.Create(SD.FileName, fmCreate or fmOpenWrite);
          // 16 colors:
          // Icon.SaveToStream(FS);
          // 2, 16, 256 colors:
          SaveColorIconToStream(FS, Icon.Handle);
        finally
          FS.Free;
          Icon.Free;
        end;
        exit;
      end;
    end;

    //convert Graphics to Bitmap
    B := TBitmap.Create;
    with B do
    try
      Width := Image.Picture.Width;
      Height := Image.Picture.Height;
      PixelFormat := APixelFormat;
      Canvas.Draw(0, 0, Image.Picture.Graphic);
      Icon := CreateIconFromBitmap(B);
    finally
      B.Free;
    end;
    FS := nil;
    if Assigned(Icon) then
    try
      FS := TFileStream.Create(SD.FileName, fmCreate or fmOpenWrite);
      // 16 colors:
      // Icon.SaveToFile(SD.FileName);
      // 2, 16, 256 colors:
      SaveColorIconToStream(FS, Icon.Handle);
    finally
      Icon.Free;
      FS.Free;
    end;

  end;
const
  cPixelFormat: array[1..4] of TPixelFormat = (pf24bit, pf8bit, pf4bit, pf1bit);

  procedure CheckExtension(const Ext: string);
  var
    vExt: string;
  begin
    vExt := ExtractFileExt(SD.FileName);
    if CompareText(vExt, Ext) <> 0 then
      SD.FileName := SD.FileName + Ext;
  end;
begin
  if not isImage then
    exit;

  // select default(base) type
  if (Image.Picture.Graphic is TBitmap) then
  begin
    case Image.Picture.Bitmap.PixelFormat of
      pf1bit:
        SD.FilterIndex := 4;
      pf4bit:
        SD.FilterIndex := 3;
      pf8bit:
        SD.FilterIndex := 2;
    else
      SD.FilterIndex := 1;
    end;
  end
  else
    if (Image.Picture.Graphic is TIcon) then
  begin
    if not (SD.FilterIndex in [5..7]) then
      SD.FilterIndex := 5;
  end
  else
    SD.FilterIndex := 8;

  if not SD.Execute then
    exit;

  Screen.Cursor := crHourGlass;
  try
    with Image.Picture do
      case SD.FilterIndex of
        1..4: // Save as *.bmp (if source is ico or bitmap)
          begin
            CheckExtension('.bmp');
            SaveGraphicAsBitmap(cPixelFormat[SD.FilterIndex])
          end;
        5..7: // Save as *.ico (if source is ico or bitmap)
          begin
            CheckExtension('.ico');
            SaveGraphicAsIco(cPixelFormat[SD.FilterIndex - 3])
          end;
      else // Other: *.* - save to base format of Image.Picture.Graphic
        SaveToFile(SD.FileName);
      end;
  finally
    Screen.Cursor := crDefault;
  end;
  CheckEnabledCopy;
end;

// Copy Image to clipboard:

procedure TStyleImageSelectForm.btnCopyClick(Sender: TObject);
  {var
    imgFormat  :Word;
    imgData    :THandle;
    imgPalette :HPALETTE;{}
begin
  if (not isImage) then
    exit;
  {
  Image.Picture.SaveToClipboardFormat(imgFormat, imgData, imgPalette)
  ClipBoard.SetAsHandle(imgFormat,imgData);
  {}
  Screen.Cursor := crHourGlass;
  try
    Clipboard.Assign(Image.Picture);
  finally
    Screen.Cursor := crDefault;
  end;

  CheckEnabledPaste;
end;

// Paste from Clipboard into image:

procedure TStyleImageSelectForm.btnPasteClick(Sender: TObject);
var
  Palette: HPALETTE;
begin
  Screen.Cursor := crHourGlass;
  try

    if Clipboard.HasFormat(CF_BITMAP) then
      Palette := CF_BITMAP
    else
      if Clipboard.HasFormat(CF_PICTURE) then
      Palette := CF_PICTURE
    else
      if Clipboard.HasFormat(CF_METAFILEPICT) then
      Palette := CF_METAFILEPICT
    else
      Palette := 0;
    if Palette <> 0 then
      Image.Picture.LoadFromClipboardFormat(cf_BitMap,
        ClipBoard.GetAsHandle(cf_Bitmap), 0)
    else
      Image.Picture.Assign(Clipboard);
    CheckEnabledCopy;
    btnSave.Enabled := isImage;
    btnClear.Enabled := btnSave.Enabled;
    btnMono.Enabled := btnSave.Enabled;

  finally
    Screen.Cursor := crDefault;
  end;
end;

// check clipboard on activate window

procedure TStyleImageSelectForm.WMActivate(var Msg: TWMActivate);
begin
  if Msg.Active <> WA_INACTIVE then
    CheckEnabledPaste;
  inherited;
end;

procedure TStyleImageSelectForm.CheckEnabledPaste;
begin
  btnPaste.Enabled :=
    Clipboard.HasFormat(CF_BITMAP) or Clipboard.HasFormat(CF_METAFILEPICT) or
    Clipboard.HasFormat(CF_PICTURE);
end;

// check allow copy if assigned image

procedure TStyleImageSelectForm.CheckEnabledCopy;
begin
  btnCopy.Enabled := isImage;
end;

// convert colored image to black/white colors

procedure TStyleImageSelectForm.btnMonoClick(Sender: TObject);
begin
  if (not isImage) then
    exit;
  Screen.Cursor := crHourGlass;
  try
    ConvertColoredCanvasToMono(Image.Canvas);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TStyleImageSelectForm.LoadFromStream(S: TStream; Format: TImageType);
  procedure LoadAsBitmap;
    var
      B:TBitmap;
  begin
    B := TBitmap.Create;
    try
      B.LoadFromStream(S);
      Image.Picture.Assign(B);
    finally
      B.Free;
    end;
  end;
  procedure LoadAsIco;
    var
      Ico:TIcon;
  begin
    Ico := TIcon.Create;
    try
      Ico.LoadFromStream(S);
      Image.Picture.Assign(Ico);
    finally
      Ico.Free;
    end;
  end;
begin
  if (S=nil)or(S.Position = S.Size) then
  begin
    btnClearClick(Self);
    exit;
  end;

  try
    if Format = itBitmap then
      LoadAsBitmap
    else { when Format == itIcon }
      LoadAsIco;
  except
    btnClearClick(Self);
    raise;
  end;

  CheckEnabledCopy();
  btnSave.Enabled := isImage;
  btnClear.Enabled := btnSave.Enabled;
  btnMono.Enabled := btnSave.Enabled;
end;

procedure TStyleImageSelectForm.SaveToStream(S: TStream; Format: TImageType);

  procedure SaveGraphicAsBitmap;
    var B:TBitmap;
        Graphic:TGraphic;
  begin
    if (Image.Picture.Graphic is TBitmap) then
      Image.Picture.Bitmap.SaveToStream(S)
    else
    begin
      Graphic := Image.Picture.Graphic;
      B := TBitmap.Create;
      with B do
      try
        Width  := Graphic.Width;
        Height := Graphic.Height;
        if (Image.Picture.Graphic is TIcon) then
          PixelFormat := pf8bit
        else
          PixelFormat := pf24bit;
        Canvas.Draw(0, 0, Graphic);
        SaveToStream(S);
      finally
        B.Free;
      end;
    end;
  end;

  procedure SaveGraphicAsIco;
    var
      Icon:TIcon;
      B:TBitmap;
  begin
    if (Image.Picture.Graphic is TIcon) then
      //16 colors:
      //Image.Picture.Icon.SaveToStream(S)
      // 2, 16, 256 colors:
      SaveColorIconToStream(S, Image.Picture.Icon.Handle)
    else
      if Image.Picture.Graphic is TBitmap then
      begin
        B := Image.Picture.Bitmap;
        Icon := CreateIconFromBitmap(B);
        try
          if Assigned(Icon) then
            //16 colors:
            //Icon.SaveToStream(S);
            // 2, 16, 256 colors:
            SaveColorIconToStream(S, Icon.Handle);
        finally
          Icon.Free;
        end;
      end
    else
    begin
      //convert Graphics to Bitmap
      B := TBitmap.Create;
      with B do
      try
        Width  := Image.Picture.Width;
        Height := Image.Picture.Height;
        PixelFormat := pf8bit;
        Canvas.Draw(0, 0, Image.Picture.Graphic);
        Icon := CreateIconFromBitmap(B);
      finally
        B.Free;
      end;
      if Assigned(Icon) then
      try
        // 16 colors:
        // Icon.SaveToStream(S);
        // 2, 16, 256 colors:
        SaveColorIconToStream(S, Icon.Handle);
      finally
        Icon.Free;
      end;
    end;
  end;

begin
  if not isImage then
    exit;
  if Format = itBitmap then
    SaveGraphicAsBitmap
  else { when Format == itIcon }
    SaveGraphicAsIco;
end;

end.
