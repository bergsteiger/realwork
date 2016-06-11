{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Helpers.Win;

interface

uses
  System.Types, System.SysUtils, System.Classes, System.UITypes, System.Math, Winapi.Windows, Winapi.Messages,
  FMX.Types, FMX.Graphics, FMX.ImgList, FMX.Surfaces, Winapi.D2D1;

const
  CN_BASE              = $1000;
  CN_CTLCOLORMSGBOX    = CN_BASE + WM_CTLCOLORMSGBOX;
  CN_CTLCOLOREDIT      = CN_BASE + WM_CTLCOLOREDIT;
  CN_CTLCOLORLISTBOX   = CN_BASE + WM_CTLCOLORLISTBOX;
  CN_CTLCOLORBTN       = CN_BASE + WM_CTLCOLORBTN;
  CN_CTLCOLORDLG       = CN_BASE + WM_CTLCOLORDLG;
  CN_CTLCOLORSCROLLBAR = CN_BASE + WM_CTLCOLORSCROLLBAR;
  CN_CTLCOLORSTATIC    = CN_BASE + WM_CTLCOLORSTATIC;

  WM_ADDUPDATERECT     = WM_USER + 123;
  WM_RELEASEFORM       = WM_USER + 125;
  WM_NCADDUPDATERECT   = WM_USER + 126;
  WM_CLOSEMENU         = WM_USER + 127;

type
  ///<summary>Static class that provides methods and properties to configure IME support for text input
  ///controls</summary>
  TImeModeHelper = class
  private
    const Imm32ModName = 'imm32.dll';
    class var Imm32Dll: THandle;
    class var FIMEs: TStrings;
    class var FDefaultIme: string;
    class var FDefaultKbLayout: HKL;
  private
    class function Win32NLSEnableIME(hWnd: HWND; Enable: Boolean): Boolean;
    class function GetIMEs: TStrings; static;
    class function GetDefaultIME: string; static;
    class procedure SetImeMode(Handle: HWND; Mode: TImeMode);
  public
    class constructor Create;
    class destructor Destroy;
    ///<summary>Switchs on IME for control with handle <c>Handle</c></summary>
    class procedure SetIme(Handle: HWND; Mode: TImeMode);
    ///<summary>Switchs off IME for control with handle <c>Handle</c></summary>
    class procedure ResetIme(Handle: HWND; Mode: TImeMode);
    ///<summary>Returns default IME provider name</summary>
    class property DefaultIme: string read GetDefaultIme;
    ///<summary>Returns active input locale identifier</summary>
    ///<remarks>The return value is the input locale identifier for the thread. The low word contains a
    ///<c>Language Identifier</c> for the input language and the high word contains a device handle to the physical
    ///layout of the keyboard.</remarks>
    class property DefaultKbLayout: HKL read FDefaultKbLayout;
    ///<summary>Returns list of names of available IME providers</summary>
    class property IMEs: TStrings read GetIMEs;
  end;


function BitmapToWinBitmap(const Bitmap: FMX.Graphics.TBitmap; const RemoveBlackPixel: Boolean): HBITMAP; overload;
function BitmapToWinBitmap(const Bitmap: FMX.Graphics.TBitmap; const Background: TAlphaColor): HBITMAP; overload;
function BitmapToMenuBitmap(const TopLevel: Boolean; const Bitmap: FMX.Graphics.TBitmap): HBITMAP;
function ImageListToMenuBitmap(const TopLevel: Boolean; const Images: TCustomImageList; const Index: Integer): HBITMAP;
function BitmapToIcon(const Bitmap: FMX.Graphics.TBitmap): HICON;
function DIBDataToBitmapSurface(DataPtr: Pointer): TBitmapSurface;

function KeysToShiftState(Keys: Longint): TShiftState;
/// <summary> This function can only be called when handling a mouse message. It uses
/// GetMessageExtraInfo to determine the origin (mouse, touch or pen) of the
/// message. Touch or pen origins are encoded into the returned TShiftState.
/// <para> See also Vcl.Controls.MouseOriginToShiftState </para>
/// </summary>
function MouseToShiftState(Keys: Longint): TShiftState;
function KeyDataToShiftState(KeyData: Longint): TShiftState;
procedure ShortCutToKey(const ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
function ShortCutToText(const ShortCut: TShortCut): string;
function TextToShortCut(Text: string): Integer;

procedure CheckWinapiResult(const AResult: Boolean; const AdditionalInfo: string = '');
function CheckWinapiHandle(const AHandle: Winapi.Windows.THandle;
  const AdditionalInfo: string = ''): Winapi.Windows.THandle;

function DisableTaskWindows(ActiveWindow: HWND): Pointer;
procedure EnableTaskWindows(WindowList: Pointer);
function FindTopMostWindow(ActiveWindow: HWnd): HWnd;

/// <summary>This function returns a unique id available to be used as menu command id.</summary>
function NewUniqueMenuCommand: LongWord;
/// <summary>This function releases a menu command obtained previously from NewUniqueMenuCommand.</summary>
procedure FreeUniqueMenuCommand(Id: LongWord);

/// <summary>This function gets text from the control that is represented by <c>AHandle</c> Windows handle.</summary>
function GetHWNDText(const AWnd: HWND): string;

function FontWeightToDWrite(const AWeight: TFontWeight): TDWriteFontWeight;
function DWriteFontWeightToWeight(const AWeight: TDWriteFontWeight): TFontWeight;
function FontWeightToWinapi(const AWeight: TFontWeight): Cardinal;
function WinapiWeightToFontWeight(const AWeight: Cardinal): TFontWeight;
function FontStretchToDWrite(const AStretch: TFontStretch): TDWriteFontStretch;
function DWriteFontStretchToStretch(const AStretch: TDWriteFontStretch): TFontStretch;
function FontSlantToDWrite(const ASlant: TFontSlant): TDWriteFontStyle;
function DWriteFontStyleToSlant(const ASlant: TDWriteFontStyle): TFontSlant;

type
  TWow64Redirection = class
  private type
    TWow64DisableWow64FsRedirection = function(out Wow64FsEnableRedirection: LongBool): LongBool; stdcall;
    TWow64RevertWow64FsRedirection = function(var Wow64FsEnableRedirection: LongBool): LongBool; stdcall;
    TWow64EnableWow64FsRedirection = function(const Wow64FsEnableRedirection: LongBool): LongBool; stdcall;
  private
    class var FOldValue: LongBool;
    class var FDisableCount: Integer;
    class var FCurrent: TWow64Redirection;
    class var FRedirectLoaded: Boolean;
    class var Wow64DisableWow64FsRedirection: TWow64DisableWow64FsRedirection;
    class var Wow64RevertWow64FsRedirection: TWow64RevertWow64FsRedirection;
    class var Wow64EnableWow64FsRedirection: TWow64EnableWow64FsRedirection;
    class function RedirectLoad: Boolean; static;
    class function GetCurrent: TWow64Redirection; static;
  public
    class property Current: TWow64Redirection read GetCurrent;
    function Disable: Boolean;
    function Restore: Boolean;
    function SetEnable(const Value: Boolean): Boolean;
  end;

const
  StandardDpi = 96;

function GetDCScale(const DC: HDC): Single;
function GetWndScale(const Wnd: HWnd): Single;

implementation

uses
  System.SysConst, Winapi.UxTheme, FMX.Consts, FMX.Platform, FMX.Menus, FMX.Utils,
  Winapi.Imm, Winapi.MSCTF, Winapi.MultiMon, Winapi.ShellScaling;

const
  AlmostBlackColor = $0A0A0A;
  AlmostTransparentColorValue = $0A;

function CreateBitmapHandler(const Bitmap: TBitmap; var BitmapBits: Pointer; const BitCount: Word = 32): HBITMAP;
var
  BitmapInfo: tagBITMAPINFO;
begin
  FillChar(BitmapInfo, SizeOf(BitmapInfo), 0);
  BitmapInfo.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  BitmapInfo.bmiHeader.biPlanes := 1;
  BitmapInfo.bmiHeader.biBitCount := BitCount;
  BitmapInfo.bmiHeader.biCompression := BI_RGB;
  BitmapInfo.bmiHeader.biWidth := Bitmap.Width;
  if BitmapInfo.bmiHeader.biWidth <= 0 then
    BitmapInfo.bmiHeader.biWidth := 1;
  BitmapInfo.bmiHeader.biHeight := -Bitmap.Height;
  if BitmapInfo.bmiHeader.biHeight >= 0 then
    BitmapInfo.bmiHeader.biHeight := -1;
  Result := CreateDIBSection(0, BitmapInfo, DIB_RGB_COLORS, Pointer(BitmapBits), 0, 0);
  if Result = 0 then
    RaiseLastOSError;
end;

function BitmapToWinBitmap(const Bitmap: FMX.Graphics.TBitmap; const RemoveBlackPixel: Boolean): HBITMAP;
var
  BitmapBits: Pointer;
  BitmapData: TBitmapData;
  I, J: Integer;
  C: PAlphaColorRec;
begin
  Result := CreateBitmapHandler(Bitmap, BitmapBits);
  try
    if (BitmapBits <> nil) and Bitmap.Map(TMapAccess.Read, BitmapData) then
      try
        if BitmapData.PixelFormat = TPixelFormat.BGRA then
          for I := 0 to Bitmap.Height - 1 do
            Move(PAlphaColorArray(BitmapData.Data)[I * (BitmapData.Pitch div 4)],
              PAlphaColorArray(BitmapBits)[I * Bitmap.Width], Bitmap.Width * 4)
        else
          for I := 0 to Bitmap.Height - 1 do
            for J := 0 to Bitmap.Width - 1 do
              PAlphaColorArray(BitmapBits)[I * Bitmap.Width + J] := BitmapData.GetPixel(J, I);
        // Remove black pixel that didn't show
        if RemoveBlackPixel then
          for I := 0 to Bitmap.Height - 1 do
            for J := 0 to Bitmap.Width - 1 do
            begin
              C := @PAlphaColorRecArray(BitmapBits)[I * Bitmap.Width + J];
              if (C.A > 0) and ((C.Color and $FFFFFF) = 0) then
                C.Color := (C.Color and $FF000000) or AlmostBlackColor;
            end;
      finally
        Bitmap.Unmap(BitmapData);
      end;
  except
    DeleteObject(Result);
    raise;
  end;
end;

function BitmapToWinBitmap(const Bitmap: FMX.Graphics.TBitmap; const Background: TAlphaColor): HBITMAP;
var
  TempBitmap: TBitmap;
  Rect: TRectF;
  Color: TAlphaColor;
begin
  Result := 0;
  TempBitmap := TBitmap.Create(Bitmap.Width, Bitmap.Height);
  try
    if TempBitmap.Canvas.BeginScene then
    begin
      try
        Color := Background;
        if TOSVersion.Major < 6 then
          TAlphaColorRec(Color).A := 255;
        TempBitmap.Clear(Color);
        Rect := TRectF.Create(0, 0, Bitmap.Width, Bitmap.Height);
        TempBitmap.Canvas.DrawBitmap(Bitmap, Rect, Rect, 1, False);
      finally
        TempBitmap.Canvas.EndScene;
      end;
      Result := BitmapToWinBitmap(TempBitmap, False);
    end;
  finally
    TempBitmap.Free;
  end;
end;

procedure InitSrcDstRects(const SourceSize, DestinationSize: TSizeF; var SourceRect, DestinationRect: TRectF);

  function ScaleOfBitmap(const SourceSize, DestinationSize: TSizeF): Single;
  var
    HScale, VScale: Single;
  begin
    if SourceSize.cx > 0 then
      HScale := DestinationSize.cx / SourceSize.cx
    else
      HScale := 1;
    if SourceSize.cy > 0 then
      VScale := DestinationSize.cy / SourceSize.cy
    else
      VScale := 1;
    Result := Min(HScale, VScale);
  end;

var
  Scale: Single;
begin
  Scale := Min(1, ScaleOfBitmap(SourceSize, DestinationSize));
  SourceRect := TRectF.Create(0, 0, SourceSize.cx, SourceSize.cy);
  DestinationRect.Left := Round((DestinationSize.cx - SourceSize.cx * Scale) / 2);
  DestinationRect.Top := Round((DestinationSize.cy - SourceSize.cy * Scale) / 2);
  DestinationRect.Width := Round(SourceSize.cx * Scale);
  DestinationRect.Height := Round(SourceSize.cy * Scale);
end;

function MultipleOf(const Value, Denominator: Integer; const Greater: Boolean = True): Integer;
begin
  if Greater then
    Result := ((Value + Denominator - 1) div Denominator) * Denominator
  else
    Result := ((Value + (Denominator div 2)) div Denominator) * Denominator;
end;

procedure MenuItemMetrics(const TopLevel: Boolean; var Themed: Boolean; var BitmapSize, ImageSize: TSize);
var
  ItemHeight: Integer;
begin
  Themed := IsThemeActive;
  ItemHeight := GetSystemMetrics(SM_CYMENU);
  ImageSize.cx := MultipleOf(GetSystemMetrics(SM_CXMENUCHECK), 4);
  ImageSize.cy := MultipleOf(GetSystemMetrics(SM_CYMENUCHECK), 4);
  if TopLevel then
    BitmapSize.cy := Max(ItemHeight, ImageSize.cy + 2 * GetSystemMetrics(SM_CYEDGE))
  else
    BitmapSize.cy := ImageSize.cy;
  if Themed then
    BitmapSize.cx := ImageSize.cx
  else
    BitmapSize.cx := ImageSize.cx + 2 * GetSystemMetrics(SM_CXEDGE);
end;

function BitmapToMenuBitmap(const TopLevel: Boolean; const Bitmap: FMX.Graphics.TBitmap): HBITMAP;
var
  ImgSize, BmpSize: TSize;
  Color: TAlphaColorRec;
  TempBitmap: TBitmap;
  Src, Dst: TRectF;
  Themed: Boolean;
begin
  Result := 0;
  if (Bitmap <> nil) and (not Bitmap.IsEmpty) then
  begin
    Color.Color := GetSysColor(COLOR_MENU);
    MenuItemMetrics(TopLevel, Themed, BmpSize, ImgSize);
    TempBitmap := TBitmap.Create(BmpSize.cx, BmpSize.cy);
    try
      if TempBitmap.Canvas.BeginScene then
      begin
        try
          if TOSVersion.Major < 6 then
            Color.A := 255;
          TempBitmap.Clear(Color.Color);
          InitSrcDstRects(TSizeF.Create(Bitmap.Width, Bitmap.Height), TSizeF.Create(ImgSize.cx, ImgSize.cy), Src, Dst);
          Dst.Location := TPointF.Create(Dst.Left, Round((BmpSize.cy - Dst.Height) / 2));
          if not Themed then
            Dst.Location := TPointF.Create(0, Dst.Top);
          TempBitmap.Canvas.DrawBitmap(Bitmap, Src, Dst, 1, False);
        finally
          TempBitmap.Canvas.EndScene;
        end;
        Result := BitmapToWinBitmap(TempBitmap, False);
      end;
    finally
      TempBitmap.Free;
    end;
  end;
end;

function ImageListToMenuBitmap(const TopLevel: Boolean; const Images: TCustomImageList; const Index: Integer): HBITMAP;
var
  ImgSize, BmpSize: TSize;
  Themed: Boolean;
begin
  Result := 0;
  if (Images <> nil) and (Index >= 0) then
  begin
    MenuItemMetrics(TopLevel, Themed, BmpSize, ImgSize);
    Result := BitmapToMenuBitmap(TopLevel, Images.Bitmap(TSizeF.Create(ImgSize.cx, ImgSize.Height), Index));
  end;
end;

function BitmapToIcon(const Bitmap: FMX.Graphics.TBitmap): HICON;
var
  IconInfo: TIconInfo;
  TempBitmap: FMX.Graphics.TBitmap;
  Src, Dst: TRectF;
  ColorBitmap, MaskBitmap: HBITMAP;
  ColorBitmapBits, MaskBitmapBits: Pointer;
  BitmapData: TBitmapData;
  IconSize, LineSize, I, J, PixelNumber: Integer;
  Pixels8: Byte;
begin
  Result := 0;
  ColorBitmap := 0;
  MaskBitmap := 0;
  if (Bitmap <> nil) and not Bitmap.IsEmpty then
  begin
    IconSize := Min(256, Max(16, MultipleOf(Max(Bitmap.Width, Bitmap.Height), 16, False)));
    TempBitmap := FMX.Graphics.TBitmap.Create(IconSize, IconSize);
    try
      if TempBitmap.Canvas.BeginScene then
        try
          TempBitmap.Clear(TAlphaColorRec.Null);
          InitSrcDstRects(TSizeF.Create(Bitmap.Width, Bitmap.Height), TSizeF.Create(IconSize, IconSize), Src, Dst);
          TempBitmap.Canvas.DrawBitmap(Bitmap, Src, Dst, 1, False);
        finally
          TempBitmap.Canvas.EndScene;
        end
      else
        Exit;
      if TempBitmap.Map(TMapAccess.Read, BitmapData) then
        try
          ColorBitmap := CreateBitmapHandler(TempBitmap, ColorBitmapBits);
          if BitmapData.PixelFormat = TPixelFormat.BGRA then
            for I := 0 to TempBitmap.Height - 1 do
              Move(PAlphaColorArray(BitmapData.Data)[I * (BitmapData.Pitch div 4)],
                PAlphaColorArray(ColorBitmapBits)[I * TempBitmap.Width], TempBitmap.Width * 4)
          else
            for I := 0 to TempBitmap.Height - 1 do
              for J := 0 to TempBitmap.Width - 1 do
                PAlphaColorArray(ColorBitmapBits)[I * TempBitmap.Width + J] := BitmapData.GetPixel(J, I);
          MaskBitmap := CreateBitmapHandler(TempBitmap, MaskBitmapBits, 1);
          PixelNumber := 0;
          Pixels8 := 0;
          LineSize := MultipleOf((TempBitmap.Width + 7) div 8, 4);
          for I := 0 to TempBitmap.Height - 1 do
            for J := 0 to TempBitmap.Width - 1 do
            begin
              if TAlphaColorRec(BitmapData.GetPixel(J, I)).A < AlmostTransparentColorValue then
                Pixels8 := Pixels8 or ($80 shr PixelNumber);
              Inc(PixelNumber);
              if PixelNumber = 8 then
              begin
                PByteArray(MaskBitmapBits)[I * LineSize + J div 8] := Pixels8;
                Pixels8 := 0;
                PixelNumber := 0;
              end;
            end;
        finally
          TempBitmap.Unmap(BitmapData);
        end
      else
        Exit;
      IconInfo.fIcon := True;
      IconInfo.xHotspot := 0;
      IconInfo.yHotspot := 0;
      IconInfo.hbmMask := MaskBitmap;
      IconInfo.hbmColor := ColorBitmap;
      Result := CreateIconIndirect(IconInfo);
      if Result = 0 then
        RaiseLastOSError;
    finally
      TempBitmap.Free;
      if (ColorBitmap <> 0) and not DeleteObject(ColorBitmap) then
        RaiseLastOSError;
      if (MaskBitmap <> 0) and not DeleteObject(MaskBitmap) then
        RaiseLastOSError;
    end;
  end;
end;

function DIBDataToBitmapSurface(DataPtr: Pointer): TBitmapSurface;
type
  TColor24 = record
    Blue, Green, Red: Byte;
  end;
  PColor24 = ^TColor24;
var
  BitmapHeader: TBitmapInfoHeader;
  BytePointer: PByte;
  ColorRec: TAlphaColorRec;
  I, J, BytesPerPixel, RowAlignment: Integer;
  Color24Pointer: PColor24;
  Color16Pointer: PWord;
begin
  Result := nil;
  Move(DataPtr^, BitmapHeader, SizeOf(BitmapHeader));
  if (BitmapHeader.biCompression = BI_RGB) or (BitmapHeader.biCompression = BI_BITFIELDS) then
  begin
    Result := TBitmapSurface.Create;
    try
      Result.SetSize(BitmapHeader.biWidth, Abs(BitmapHeader.biHeight));
      BytePointer := PByte(DataPtr) + BitmapHeader.biSize;
      if BitmapHeader.biCompression = BI_BITFIELDS then
        //With this compression after header we have additional 3 DWORD of color mask
        BytePointer := BytePointer + SizeOf(DWORD) * 3;
      BytesPerPixel := Round(BitmapHeader.biBitCount / 8);
      //Calculation 4-bytes alignment for each row
      RowAlignment := (4 - (BitmapHeader.biWidth * BytesPerPixel mod 4)) mod 4;
      if BitmapHeader.biBitCount = 32 then
      begin
        if BitmapHeader.biHeight > 0 then
          for I := 0 to BitmapHeader.biHeight - 1 do
            Move((BytePointer + BitmapHeader.biWidth * I * BytesPerPixel)^,
              Result.Scanline[BitmapHeader.biHeight - 1 - I]^, BitmapHeader.biWidth * BytesPerPixel)
        else
          Move(BytePointer^, Result.Bits^, BitmapHeader.biSizeImage)
      end
      else if BitmapHeader.biBitCount = 24 then
      begin
        for I := 0 to Abs(BitmapHeader.biHeight) - 1 do
        begin
          Color24Pointer := PColor24(BytePointer + I * (BitmapHeader.biWidth * BytesPerPixel + RowAlignment));
          for J := 0 to BitmapHeader.biWidth - 1 do
          begin
            ColorRec.B := Color24Pointer^.Blue;
            ColorRec.G := Color24Pointer^.Green;
            ColorRec.R := Color24Pointer^.Red;
            ColorRec.A := 255;
            if BitmapHeader.biHeight > 0 then
              Result.Pixels[J, BitmapHeader.biHeight - 1 - I] := ColorRec.Color
            else
              Result.Pixels[J, I] := ColorRec.Color;
            Inc(Color24Pointer);
          end;
        end;
      end
      else if BitmapHeader.biBitCount = 16 then
      begin
        for I := 0 to Abs(BitmapHeader.biHeight) - 1 do
        begin
          Color16Pointer := PWord(BytePointer + I * (BitmapHeader.biWidth * BytesPerPixel + RowAlignment));
          for J := 0 to BitmapHeader.biWidth - 1 do
          begin
            ColorRec.B := Color16Pointer^ and $1F;
            ColorRec.G := (Color16Pointer^ shr 5) and $1F;
            ColorRec.R := (Color16Pointer^ shr 10) and $1F;
            ColorRec.A := 255;
            if BitmapHeader.biHeight > 0 then
              Result.Pixels[J, BitmapHeader.biHeight - 1 - I] := ColorRec.Color
            else
              Result.Pixels[J, I] := ColorRec.Color;
            Inc(Color16Pointer);
          end;
        end;
      end;
    except
      Result := nil;
    end;
  end;
end;

{ moved from Vcl.Forms }

function KeysToShiftState(Keys: Longint): TShiftState;
begin
  Result := [];
  if Keys and MK_SHIFT <> 0 then
    Include(Result, ssShift);
  if Keys and MK_CONTROL <> 0 then
    Include(Result, ssCtrl);
  if Keys and MK_LBUTTON <> 0 then
    Include(Result, ssLeft);
  if Keys and MK_RBUTTON <> 0 then
    Include(Result, ssRight);
  if Keys and MK_MBUTTON <> 0 then
    Include(Result, ssMiddle);
  if GetKeyState(VK_MENU) < 0 then
    Include(Result, ssAlt);
end;

{ moved from Vcl.Forms }

function MouseOriginToShiftState: TShiftState;
const
  MouseOriginMask  = $FFFFFF80;
  MouseOriginPen   = $FF515700;
  MouseOriginTouch = $FF515780;
var
  ExtraInfo: Cardinal;
begin
  ExtraInfo := GetMessageExtraInfo and MouseOriginMask;
  if ExtraInfo = MouseOriginPen then
    Result := [ssPen]
  else if ExtraInfo = MouseOriginTouch then
    Result := [ssTouch]
  else
    Result := [];
end;

function MouseToShiftState(Keys: Longint): TShiftState;
begin
  Result := KeysToShiftState(Keys) + MouseOriginToShiftState;
end;

function KeyDataToShiftState(KeyData: Longint): TShiftState;
const
  AltMask = $20000000;
begin
  Result := [];
  if GetKeyState(VK_SHIFT) < 0 then
    Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then
    Include(Result, ssCtrl);
  if KeyData and AltMask <> 0 then
    Include(Result, ssAlt);
end;

type
  TMenuKeyCap = (mkcBkSp, mkcTab, mkcEsc, mkcEnter, mkcSpace, mkcPgUp, mkcPgDn, mkcEnd, mkcHome, mkcLeft, mkcUp,
    mkcRight, mkcDown, mkcIns, mkcDel, mkcShift, mkcCtrl, mkcAlt, mkcCmd);

const
  vkShifts = [vkShift, vkLShift, vkRShift];
  vkCtrls = [vkControl, vkLControl, vkRControl];
  vkWindows = [vkLWin, vkRWin];
  vkAlts = [vkMenu, vkLMenu, vkRMenu];

var
  MenuKeyCaps: array [TMenuKeyCap] of string = (
    SmkcBkSp, SmkcTab, SmkcEsc, SmkcEnter, SmkcSpace, SmkcPgUp,
    SmkcPgDn, SmkcEnd, SmkcHome, SmkcLeft, SmkcUp, SmkcRight,
    SmkcDown, SmkcIns, SmkcDel, SmkcShift, SmkcCtrl, SmkcAlt, SmkcCmd);

  OEMKeyCaps: array [$BA..$E1] of string;

function GetSpecialName(ShortCut: TShortCut): string;
var
  ScanCode: Integer;
  KeyName: MarshaledString;
  R: Integer;
begin
  Result := '';
  if ShortCut <> 0 then
  begin
    ScanCode := MapVirtualKey(LoByte(Word(ShortCut)), 0) shl 16;
    if ScanCode <> 0 then
    begin
      KeyName := StrAlloc(256);
      R := GetKeyNameText(ScanCode, KeyName, 256);
      if R > 0 then
        Result := KeyName;
      StrDispose(KeyName);
    end;
    if Result = '' then
      Result := '(' + IntToStr($00FF and ShortCut) + ')'
    else
      Result := '''' + Result + '''';
  end;
end;

procedure InitOEMKeyCaps;
var
  I: integer;
begin
  for I := Low(OEMKeyCaps) to High(OEMKeyCaps) do
    OEMKeyCaps[I] := GetSpecialName(I);
end;

procedure ShortCutToKey(const ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
begin
  Key := ShortCut and not (scShift + scCtrl + scAlt + scCommand);
  Shift := [];
  if ShortCut and scShift <> 0 then
    Include(Shift, ssShift);
  if ShortCut and scCtrl <> 0 then
    Include(Shift, ssCtrl);
  if ShortCut and scAlt <> 0 then
    Include(Shift, ssAlt);
  if ShortCut and scCommand <> 0 then
    Include(Shift, ssCommand);
end;

function ShortCutToText(const ShortCut: TShortCut): string;
var
  Name: string;
  Key: Byte;
begin
  Key := LoByte(Word(ShortCut));
  if (Key >= Low(OEMKeyCaps)) and (Key <= High(OEMKeyCaps)) then
    Name := OEMKeyCaps[Key]
  else
  case Key of
    vkBack, vkTab:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcBkSp) + Key - vkBack)];
    vkReturn:
      Name := MenuKeyCaps[mkcEnter];
    vkEscape:
      Name := MenuKeyCaps[mkcEsc];
    vkSpace..vkDown:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcSpace) + Key - vkSpace)];
    vkInsert .. vkDelete:
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcIns) + Key - vkInsert)];
    vkShift .. vkMenu:
    begin
      Name := MenuKeyCaps[TMenuKeyCap(Ord(mkcShift) + Key - vkShift)];
      while (Length(Name) > 0) and CharInSet(Name[Length(Name)], [' ', '+']) do
        System.Delete(Name, Length(Name), 1);
    end;
    vkCapital:
      Name := SmkcCapital;
    vk0 .. vk9:
      Name := Chr(Key);
    vkA .. vkZ:
      Name := Chr(Key);
    vkF1 .. vkF24:
      Name := 'F' + IntToStr(Key - vkF1 + 1);
    vkSemicolon:
      Name := ';';
    vkEqual:
      Name := '=';
    vkComma:
      Name := ',';
    vkMinus:
      Name := '-';
    vkPeriod:
      Name := '.';
    vkSlash:
      Name := '/';
    vkTilde:
      Name := '~';
    vkLeftBracket:
      Name := '[';
    vkBackslash:
      Name := '\';
    vkRightBracket:
      Name := ']';
    vkQuote:
      Name := '''';
    vkPara:
      Name := SmkcPara;
    vkCamera:
      Name := SmkcCamera;
    vkBrowserBack:
      Name := SmkcBrowserBack;
    vkHardwareBack:
      Name := SmkcHardwareBack;
    vkLWin:
      Name := SmkcLWin;
    vkRWin:
      Name := SmkcRWin;
    vkApps:
      Name := SmkcApps;
    vkClear:
      Name := SmkcClear;
    vkScroll:
      Name := SmkcScroll;
    vkCancel:
      Name := SmkcCancel;
    vkPause:
      Name := SmkcPause;
    vkLShift:
      Name := SmkcLShift;
    vkRShift:
      Name := SmkcRShift;
    vkLControl:
      Name := SmkcLControl;
    vkRControl:
      Name := SmkcRControl;
    vkLMenu:
      Name := SmkcLMenu;
    vkRMenu:
      Name := SmkcRMenu;
    vkOem102:
      Name := SmkcOem102;
    vkNumLock:
      Name := SmkcNumLock;
    vkNumpad0 .. vkDivide:
    case Key of
      vkNumpad0 .. vkNumpad9:
        Name := Format(SmkcNum, [Chr(Ord('0') + Key - vkNumpad0)]);
      vkMultiply:
        Name := Format(SmkcNum, ['*']);
      vkAdd:
        Name := Format(SmkcNum, ['+']);
      vkSeparator:
        Name := Format(SmkcNum, [',']);
      vkSubtract:
        Name := Format(SmkcNum, ['-']);
      vkDecimal:
        Name := Format(SmkcNum, ['.']);
      vkDivide:
        Name := Format(SmkcNum, ['/']);
    end;
  else
    Name := GetSpecialName(Key);
  end;
  if Name <> '' then
  begin
    Result := '';
    if (ShortCut and scShift <> 0) and not (Key in vkShifts) then
      Result := Result + MenuKeyCaps[mkcShift];
    if (ShortCut and scCtrl <> 0) and not (Key in vkCtrls) then
      Result := Result + MenuKeyCaps[mkcCtrl];
    if (ShortCut and scCommand <> 0) and not (Key in vkWindows) then
      Result := Result + MenuKeyCaps[mkcCmd];
    if (ShortCut and scAlt <> 0) and not (Key in vkAlts) then
      Result := Result + MenuKeyCaps[mkcAlt];
    Result := Result + Name;
  end
  else
    Result := '';
end;

function TextToShortCut(Text: string): Integer;
{ If the front of Text is equal to Front then remove the matching piece
  from Text and return True, otherwise return False }

  function CompareFront(var Text: string; const Front: string): Boolean;
  begin
    Result := False;
    if (Length(Text) >= Length(Front)) and (AnsiStrLIComp(PChar(Text), PChar(Front), Length(Front)) = 0) then
    begin
      Result := True;
      Text := Text.Remove(0, Front.Length);
    end;
  end;

var
  Key: TShortCut;
  Shift: TShortCut;
begin
  Result := 0;
  Shift := 0;
  while True do
  begin
    if CompareFront(Text, MenuKeyCaps[mkcShift]) then
      Shift := Shift or scShift
    else if CompareFront(Text, '^') then
      Shift := Shift or scCtrl
    else if CompareFront(Text, MenuKeyCaps[mkcCtrl]) then
      Shift := Shift or scCtrl
    else if CompareFront(Text, MenuKeyCaps[mkcCmd]) then
      Shift := Shift or scCommand
    else if CompareFront(Text, MenuKeyCaps[mkcAlt]) then
      Shift := Shift or scAlt
    else
      Break;
  end;
  if Text = '' then
    Exit;
  for Key := 1 to 255 do
    if AnsiCompareText(Text, ShortCutToText(Key)) = 0 then
    begin
      if Key in vkShifts then
          Shift := Shift or scShift;
      if Key in vkCtrls then
          Shift := Shift or scCtrl;
      if Key in vkAlts then
          Shift := Shift or scAlt;
      Exit(Key or Shift);
    end;
end;

procedure CheckWinapiResult(const AResult: Boolean; const AdditionalInfo: string = ''); overload;
var
  Error: EOSError;
  LastError: DWORD;
begin
  if not AResult then
  begin
    LastError := GetLastError;
    if LastError <> 0 then
      Error := EOSError.CreateResFmt(@SOSError, [LastError, SysErrorMessage(LastError), AdditionalInfo])
    else
      Error := EOSError.CreateRes(@SUnkOSError);
    Error.ErrorCode := LastError;
    raise Error at ReturnAddress;
  end;
end;

function CheckWinapiHandle(const AHandle: Winapi.Windows.THandle;
  const AdditionalInfo: string = ''): Winapi.Windows.THandle;
var
  Error: EOSError;
  LastError: DWORD;
begin
  if (AHandle = 0) or (AHandle = INVALID_HANDLE_VALUE) then
  begin
    LastError := GetLastError;
    if LastError <> 0 then
      Error := EOSError.CreateResFmt(@SOSError, [LastError, SysErrorMessage(LastError), AdditionalInfo])
    else
      Error := EOSError.CreateRes(@SUnkOSError);
    Error.ErrorCode := LastError;
    raise Error at ReturnAddress;
  end
  else
    Result := AHandle;
end;

type
  PTaskWindow = ^TTaskWindow;

  TTaskWindow = record
    Next: PTaskWindow;
    Window: HWND;
  end;

var
  TaskActiveWindow: HWND = 0;
  TaskFirstWindow: HWND = 0;
  TaskFirstTopMost: HWND = 0;
  TaskWindowList: PTaskWindow = nil;

function DoDisableWindow(Window: HWND; Data: Longint): BOOL; stdcall;
var
  P: PTaskWindow;
begin
  if (Window <> TaskActiveWindow) and IsWindowVisible(Window) and IsWindowEnabled(Window) then
  begin
    New(P);
    P^.Next := TaskWindowList;
    P^.Window := Window;
    TaskWindowList := P;
    EnableWindow(Window, False);
  end;
  Result := True;
end;

procedure EnableTaskWindows(WindowList: Pointer);
var
  P: PTaskWindow;
begin
  while WindowList <> nil do
  begin
    P := WindowList;
    if IsWindow(P^.Window) then
      EnableWindow(P^.Window, True);
    WindowList := P^.Next;
    Dispose(P);
  end;
end;

function DoFindWindow(Window: HWND; Param: LPARAM): BOOL; {$IFNDEF CLR}stdcall; {$ENDIF}
begin
  if (Window <> TaskActiveWindow) and IsWindowVisible(Window) and IsWindowEnabled(Window) then
    if GetWindowLong(Window, GWL_EXSTYLE) and WS_EX_TOPMOST = 0 then
    begin
      if TaskFirstWindow = 0 then
        TaskFirstWindow := Window;
    end
    else
    begin
      if TaskFirstTopMost = 0 then
        TaskFirstTopMost := Window;
    end;
  Result := True;
end;

function FindTopMostWindow(ActiveWindow: HWND): HWND;
var
  EnumProc: TFNWndEnumProc; // keep a reference to the delegate!
begin
  TaskActiveWindow := ActiveWindow;
  TaskFirstWindow := 0;
  TaskFirstTopMost := 0;
  EnumProc := @DoFindWindow;
  EnumThreadWindows(GetCurrentThreadID, EnumProc, 0);
  if TaskFirstWindow <> 0 then
    Result := TaskFirstWindow
  else
    Result := TaskFirstTopMost;
end;

function DisableTaskWindows(ActiveWindow: HWND): Pointer;
var
  SaveActiveWindow: HWND;
  SaveWindowList: Pointer;
begin
  Result := nil;
  SaveActiveWindow := TaskActiveWindow;
  SaveWindowList := TaskWindowList;
  TaskActiveWindow := ActiveWindow;
  TaskWindowList := nil;
  try
    try
      EnumThreadWindows(GetCurrentThreadID, @DoDisableWindow, 0);
      Result := TaskWindowList;
    except
      EnableTaskWindows(TaskWindowList);
      raise;
    end;
  finally
    TaskWindowList := SaveWindowList;
    TaskActiveWindow := SaveActiveWindow;
  end;
end;


{ TImeModeHelper }

class constructor TImeModeHelper.Create;
var
  OldError: Longint;
begin
  Imm32Dll := 0;
  if Syslocale.FarEast then
  begin
    OldError := SetErrorMode(SEM_NOOPENFILEERRORBOX);
    try
      if Imm32Dll = 0 then
        Imm32Dll := LoadLibrary(Imm32ModName);
    finally
      SetErrorMode(OldError);
    end;
  end;
  FDefaultKbLayout := GetKeyboardLayout(0);
end;

class destructor TImeModeHelper.Destroy;
begin
  FIMEs.Free;
  if Imm32Dll <> 0 then
    FreeLibrary(Imm32Dll);
end;

class function TImeModeHelper.GetDefaultIME: string;
begin
  GetIMEs;
  Result := FDefaultIme;
end;

class function TImeModeHelper.GetIMEs: TStrings;
const
  KbLayoutRegkeyFmt = 'System\CurrentControlSet\Control\Keyboard Layouts\%.8x'; // do not localize
  KbLayoutRegSubkey = 'layout text'; // do not localize
var
  TotalKbLayout, I, Bufsize: Integer;
  KbList: array [0..63] of HKL;
  qKey: HKey;
  ImeFileName: array [Byte] of Char;
  RegKey: array [0..63] of Char;
begin
  if FIMEs = nil then
  begin
    FIMEs := TStringList.Create;
    FDefaultIme := string.Empty;
    TotalKbLayout := GetKeyboardLayoutList(64, KbList);

    for I := 0 to TotalKbLayout - 1 do
    begin
      if ImmIsIME(KbList[I]) then
      begin
        if RegOpenKeyEx(HKEY_LOCAL_MACHINE, StrFmt(RegKey, KbLayoutRegkeyFmt, [KbList[I]]), 0, KEY_READ, qKey) = ERROR_SUCCESS
        then
          try
            Bufsize := sizeof(ImeFileName);
            if RegQueryValueEx(qKey, KbLayoutRegSubkey, nil, nil, @ImeFileName, @Bufsize) = ERROR_SUCCESS then
            begin
              FIMEs.AddObject(ImeFileName, TObject(KbList[I]));
              if KbList[I] = FDefaultKbLayout then
                FDefaultIme := ImeFileName;
            end;
          finally
            RegCloseKey(qKey);
          end;
      end;
    end;
    TStringList(FIMEs).Duplicates := dupIgnore;
    TStringList(FIMEs).Sorted := True;
  end;
  Result := FIMEs;
end;

class procedure TImeModeHelper.ResetIme(Handle: HWND; Mode: TImeMode);
begin
  if SysLocale.FarEast then
  begin
    if not DefaultIme.IsEmpty then
    begin
      if AnsiCompareText(DefaultIme, TImeModeHelper.DefaultIme) <> 0 then
        ActivateKeyboardLayout(TImeModeHelper.DefaultKbLayout, KLF_ACTIVATE);
    end;
    if Mode = TImeMode.imDisable then
      Win32NLSEnableIME(Handle, True);
  end;
end;

class procedure TImeModeHelper.SetIme(Handle: HWND; Mode: TImeMode);
var
  I: Integer;
  HandleToSet: HKL;
begin
  if SysLocale.FarEast then
  begin
    if not DefaultIme.IsEmpty then
    begin
      if (AnsiCompareText(DefaultIme, TImeModeHelper.DefaultIme) <> 0) and (TImeModeHelper.IMEs.Count <> 0) then
      begin
        HandleToSet := TImeModeHelper.DefaultKbLayout;
        if Mode <> TImeMode.imDisable then
        begin
          I := TImeModeHelper.IMEs.IndexOf(DefaultIme);
          if I >= 0 then
            HandleToSet := HKL(TImeModeHelper.IMEs.Objects[I]);
        end;
        ActivateKeyboardLayout(HandleToSet, KLF_ACTIVATE);
      end;
    end;
    SetImeMode(Handle, Mode);
  end;
end;

class procedure TImeModeHelper.SetImeMode(Handle: HWND; Mode: TImeMode);
const
  InputSourceModeMap: array [TImeMode.imSAlpha..TImeMode.imHanguel] of InputScope =
    ( { imSAlpha: } IS_ALPHANUMERIC_HALFWIDTH,
      { imAlpha:  } IS_ALPHANUMERIC_FULLWIDTH,
      { imHira:   } IS_HIRAGANA,
      { imSKata:  } IS_KATAKANA_HALFWIDTH,
      { imKata:   } IS_KATAKANA_FULLWIDTH,
      { imChineseClose } IS_DEFAULT,
      { imOnHalf  } IS_DEFAULT,
      { imSHanguel} IS_HANJA_HALFWIDTH,
      { imHanguel } IS_HANJA_FULLWIDTH );
  ConversionStatusModeMap: array [TImeMode.imSAlpha..TImeMode.imHanguel] of Byte =  // flags in use are all < 255
    ( { imSAlpha: } IME_CMODE_ALPHANUMERIC,
      { imAlpha:  } IME_CMODE_ALPHANUMERIC or IME_CMODE_FULLSHAPE,
      { imHira:   } IME_CMODE_NATIVE or IME_CMODE_FULLSHAPE,
      { imSKata:  } IME_CMODE_NATIVE or IME_CMODE_KATAKANA,
      { imKata:   } IME_CMODE_NATIVE or IME_CMODE_KATAKANA or IME_CMODE_FULLSHAPE,
      { imChineseClose:} IME_CMODE_NATIVE or IME_CMODE_FULLSHAPE,
      { imOnHalf:} IME_CMODE_NATIVE or IME_CMODE_FULLSHAPE,
      { imSHanguel} IME_CMODE_NATIVE,
      { imHanguel } IME_CMODE_NATIVE or IME_CMODE_FULLSHAPE );
var
  IMC: HIMC;
  Conv, Sent: DWORD;
begin
  if SysLocale.FarEast and (Mode <> TImeMode.imDontCare) then
  begin
    if Mode = TImeMode.imDisable then
    begin
      if TOSVersion.Check(5, 1) then
        ImmAssociateContextEx(Handle, 0, 0)
      else
        WINNLSEnableIME(Handle, False);
      Exit;
    end;

    if TOSVersion.Check(5, 1) then
      ImmAssociateContextEx(Handle, 0, IACE_DEFAULT)
    else
      WINNLSEnableIME(Handle, True);

    if Mode in [TImeMode.imClose, TImeMode.imOpen] then
    begin
      IMC := ImmGetContext(Handle);
      if IMC <> 0 then
      try
        ImmGetConversionStatus(IMC, Conv, Sent);
        ImmSetOpenStatus(IMC, Mode = TImeMode.imOpen);
        ImmSetConversionStatus(IMC, Conv, Sent);
      finally
        ImmReleaseContext(Handle, IMC);
      end;
    end
    else
    begin
      if IsMSCTFAvailable then
        SetInputScope(Handle, InputSourceModeMap[Mode])
      else
      begin
        IMC := ImmGetContext(Handle);
        if IMC <> 0 then
        try
          ImmSetOpenStatus(IMC, TRUE);
          ImmGetConversionStatus(IMC, Conv, Sent);
          Conv := Conv and (not(IME_CMODE_LANGUAGE or IME_CMODE_FULLSHAPE)) or ConversionStatusModeMap[Mode];
          ImmSetConversionStatus(IMC, Conv, Sent);
        finally
          ImmReleaseContext(Handle, IMC);
        end;
      end;
    end;
  end;
end;

class function TImeModeHelper.Win32NLSEnableIME(hWnd: HWND; Enable: Boolean): Boolean;
begin
  if Imm32Dll <> 0 then
    Result := WINNLSEnableIME(hWnd, Enable)
  else
    Result := False;
end;

{ TWow64Redirect }

class function TWow64Redirection.RedirectLoad: Boolean;
var
  H: HModule;
begin
  if not FRedirectLoaded then
  begin
    H := GetModuleHandle('kernel32.dll');
    if H <> 0 then
    begin
      @Wow64DisableWow64FsRedirection := GetProcAddress(H, 'Wow64DisableWow64FsRedirection');
      @Wow64RevertWow64FsRedirection := GetProcAddress(H, 'Wow64RevertWow64FsRedirection');
      @Wow64EnableWow64FsRedirection := GetProcAddress(H, 'Wow64EnableWow64FsRedirection');
    end
    else
    begin
      @Wow64DisableWow64FsRedirection := nil;
      @Wow64RevertWow64FsRedirection := nil;
      @Wow64EnableWow64FsRedirection := nil;
    end;
    FRedirectLoaded := True;
  end;
  Result := (@Wow64DisableWow64FsRedirection <> nil) and (@Wow64RevertWow64FsRedirection <> nil) and
    (@Wow64EnableWow64FsRedirection <> nil);
end;

function TWow64Redirection.Disable: Boolean;
begin
  Result := RedirectLoad and ((FDisableCount > 0) or Wow64DisableWow64FsRedirection(FOldValue));
  if Result then
    Inc(FDisableCount);
end;

function TWow64Redirection.Restore: Boolean;
begin
  Result := RedirectLoad and (FDisableCount > 0) and ((FDisableCount > 1) or Wow64RevertWow64FsRedirection(FOldValue));
  if Result then
    Dec(FDisableCount);
end;

function TWow64Redirection.SetEnable(const Value: Boolean): Boolean;
var
  LValue: LongBool;
begin
  LValue := Value;
  Result := RedirectLoad and Wow64EnableWow64FsRedirection(LValue);
end;

class function TWow64Redirection.GetCurrent: TWow64Redirection;
begin
  if FCurrent = nil then
  begin
    FRedirectLoaded := False;
    FDisableCount := 0;
    FCurrent := TWow64Redirection.Create;
  end;
  Result := FCurrent;
end;

var
  CommandPool: TBits = nil;

function NewUniqueMenuCommand: LongWord;
var
  R: Integer;
begin
  if CommandPool = nil then
    CommandPool := TBits.Create;
  repeat
    R := CommandPool.OpenBit;
    CommandPool[R] := True;
    Result := LongWord(R);
  until (R <> -1) and (R <> 0);
end;

procedure FreeUniqueMenuCommand(Id: LongWord);
begin
  if (CommandPool <> nil) and (Id <> 0) then
    CommandPool[Integer(Id)] := False;
end;

function GetHWNDText(const AWnd: HWND): string;
var
  TextLength: Integer;
  WindowsText: TArray<Char>;
begin
  TextLength := GetWindowTextLength(AWnd);
  if TextLength > 0 then
  begin
    SetLength(WindowsText, TextLength + 1);
    GetWindowText(AWnd, PChar(WindowsText), TextLength + 1);
  end;
  Result := string.Create(WindowsText, 0, TextLength);
end;

function GetDCScale(const DC: HDC): Single;
begin
  Result := GetDeviceCaps(DC, LOGPIXELSX) / StandardDpi;
end;

function GetWndScale(const Wnd: HWnd): Single;
var
  DC: HDC;
  Monitor: HMonitor;
  DpiX, DpiY: Cardinal;
begin
  if TOSVersion.Check(6, 3) then
  begin
    Monitor := Winapi.MultiMon.MonitorFromWindow(Wnd, MONITOR_DEFAULTTONEAREST);
    GetDPIForMonitor(Monitor, MDT_Default, DpiX, DpiY);
    Result := DpiX / StandardDpi;
  end
  else
  begin
    DC := GetWindowDC(Wnd);
    try
      Result := GetDCScale(DC);
    finally
      ReleaseDC(Wnd, DC);
    end;
  end;
end;

function FontWeightToDWrite(const AWeight: TFontWeight): TDWriteFontWeight;
begin
  case AWeight of
    TFontWeight.Thin:
      Result := DWRITE_FONT_WEIGHT_THIN;
    TFontWeight.UltraLight:
      Result := DWRITE_FONT_WEIGHT_ULTRA_LIGHT;
    TFontWeight.Light:
      Result := DWRITE_FONT_WEIGHT_LIGHT;
    TFontWeight.SemiLight:
      Result := DWRITE_FONT_WEIGHT_SEMI_LIGHT;
    TFontWeight.Regular:
      Result := DWRITE_FONT_WEIGHT_REGULAR;
    TFontWeight.Medium:
      Result := DWRITE_FONT_WEIGHT_MEDIUM;
    TFontWeight.Semibold:
      Result := DWRITE_FONT_WEIGHT_SEMI_BOLD;
    TFontWeight.Bold:
      Result := DWRITE_FONT_WEIGHT_BOLD;
    TFontWeight.UltraBold:
      Result := DWRITE_FONT_WEIGHT_ULTRA_BOLD;
    TFontWeight.Black:
      Result := DWRITE_FONT_WEIGHT_BLACK;
    TFontWeight.UltraBlack:
      Result := DWRITE_FONT_WEIGHT_ULTRA_BLACK;
  else
    Result := DWRITE_FONT_WEIGHT_REGULAR;
  end;
end;

function DWriteFontWeightToWeight(const AWeight: TDWriteFontWeight): TFontWeight;
begin
  case AWeight of
    DWRITE_FONT_WEIGHT_THIN:
      Result := TFontWeight.Thin;
    DWRITE_FONT_WEIGHT_ULTRA_LIGHT:
      Result := TFontWeight.UltraLight;
    DWRITE_FONT_WEIGHT_LIGHT:
      Result := TFontWeight.Light;
    DWRITE_FONT_WEIGHT_SEMI_LIGHT:
      Result := TFontWeight.SemiLight;
    DWRITE_FONT_WEIGHT_REGULAR:
      Result := TFontWeight.Regular;
    DWRITE_FONT_WEIGHT_MEDIUM:
      Result := TFontWeight.Medium;
    DWRITE_FONT_WEIGHT_SEMI_BOLD:
      Result := TFontWeight.Semibold;
    DWRITE_FONT_WEIGHT_BOLD:
      Result := TFontWeight.Bold;
    DWRITE_FONT_WEIGHT_ULTRA_BOLD:
      Result := TFontWeight.UltraBold;
    DWRITE_FONT_WEIGHT_BLACK:
      Result := TFontWeight.Black;
    DWRITE_FONT_WEIGHT_ULTRA_BLACK:
      Result := TFontWeight.UltraBlack;
  else
    Result := TFontWeight.Regular;
  end;
end;

function FontWeightToWinapi(const AWeight: TFontWeight): Cardinal;
begin
  case AWeight of
    TFontWeight.Thin:
      Result := FW_THIN;
    TFontWeight.UltraLight:
      Result := FW_ULTRALIGHT;
    TFontWeight.Light,
    TFontWeight.SemiLight:
      Result := FW_LIGHT;
    TFontWeight.Regular:
      Result := FW_REGULAR;
    TFontWeight.Medium:
      Result := FW_MEDIUM;
    TFontWeight.Semibold:
      Result := FW_SEMIBOLD;
    TFontWeight.Bold:
      Result := FW_BOLD;
    TFontWeight.UltraBold:
      Result := FW_ULTRABOLD;
    TFontWeight.Black:
      Result := FW_BLACK;
    TFontWeight.UltraBlack:
      Result := FW_HEAVY;
  else
    Result := FW_DONTCARE;
  end;
end;

function WinapiWeightToFontWeight(const AWeight: Cardinal): TFontWeight;
begin
  case AWeight of
    FW_THIN:
      Result := TFontWeight.Thin;
    FW_ULTRALIGHT:
      Result := TFontWeight.UltraLight;
    FW_LIGHT:
      Result := TFontWeight.Light;
    FW_REGULAR:
      Result := TFontWeight.Regular;
    FW_MEDIUM:
      Result := TFontWeight.Medium;
    FW_SEMIBOLD:
      Result := TFontWeight.Semibold;
    FW_BOLD:
      Result := TFontWeight.Bold;
    FW_ULTRABOLD:
      Result := TFontWeight.UltraBold;
    FW_BLACK:
      Result := TFontWeight.Black;
    1000:
      Result := TFontWeight.UltraBlack;
  else
    Result := TFontWeight.Regular;
  end;
end;

function FontStretchToDWrite(const AStretch: TFontStretch): TDWriteFontStretch;
begin
  case AStretch of
    TFontStretch.UltraCondensed:
      Result := DWRITE_FONT_STRETCH_ULTRA_CONDENSED;
    TFontStretch.ExtraCondensed:
      Result := DWRITE_FONT_STRETCH_EXTRA_CONDENSED;
    TFontStretch.Condensed:
      Result := DWRITE_FONT_STRETCH_CONDENSED;
    TFontStretch.SemiCondensed:
      Result := DWRITE_FONT_STRETCH_SEMI_CONDENSED;
    TFontStretch.Regular:
      Result := DWRITE_FONT_STRETCH_NORMAL;
    TFontStretch.SemiExpanded:
      Result := DWRITE_FONT_STRETCH_SEMI_EXPANDED;
    TFontStretch.Expanded:
      Result := DWRITE_FONT_STRETCH_EXPANDED;
    TFontStretch.ExtraExpanded:
      Result := DWRITE_FONT_STRETCH_EXTRA_EXPANDED;
    TFontStretch.UltraExpanded:
      Result := DWRITE_FONT_STRETCH_ULTRA_EXPANDED;
  else
    Result := DWRITE_FONT_STRETCH_NORMAL;
  end;
end;

function DWriteFontStretchToStretch(const AStretch: TDWriteFontStretch): TFontStretch;
begin
  case AStretch of
    DWRITE_FONT_STRETCH_ULTRA_CONDENSED:
      Result := TFontStretch.UltraCondensed;
    DWRITE_FONT_STRETCH_EXTRA_CONDENSED:
      Result := TFontStretch.ExtraCondensed;
    DWRITE_FONT_STRETCH_CONDENSED:
      Result := TFontStretch.Condensed;
    DWRITE_FONT_STRETCH_SEMI_CONDENSED:
      Result := TFontStretch.SemiCondensed;
    DWRITE_FONT_STRETCH_NORMAL:
      Result := TFontStretch.Regular;
    DWRITE_FONT_STRETCH_SEMI_EXPANDED:
      Result := TFontStretch.SemiExpanded;
    DWRITE_FONT_STRETCH_EXPANDED:
      Result := TFontStretch.Expanded;
    DWRITE_FONT_STRETCH_EXTRA_EXPANDED:
      Result := TFontStretch.ExtraExpanded;
    DWRITE_FONT_STRETCH_ULTRA_EXPANDED:
      Result := TFontStretch.UltraExpanded;
  else
    Result := TFontStretch.Regular;
  end;
end;

function FontSlantToDWrite(const ASlant: TFontSlant): TDWriteFontStyle;
begin
  case ASlant of
    TFontSlant.Regular:
      Result := DWRITE_FONT_STYLE_NORMAL;
    TFontSlant.Italic:
      Result := DWRITE_FONT_STYLE_ITALIC;
    TFontSlant.Oblique:
      Result := DWRITE_FONT_STYLE_OBLIQUE;
  else
    Result := DWRITE_FONT_STYLE_NORMAL;
  end;
end;

function DWriteFontStyleToSlant(const ASlant: TDWriteFontStyle): TFontSlant;
begin
  case ASlant of
    DWRITE_FONT_STYLE_NORMAL:
    Result := TFontSlant.Regular;
    DWRITE_FONT_STYLE_OBLIQUE:
    Result := TFontSlant.Oblique;
    DWRITE_FONT_STYLE_ITALIC:
      Result := TFontSlant.Italic;
  else
    Result := TFontSlant.Regular;
  end;
end;

initialization
  InitOEMKeyCaps;
  InitThemeLibrary;
finalization
  CommandPool.Free;
end.
