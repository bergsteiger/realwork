{*********************************************************************}
{*                                                                   *}
{*             Add-In Express Component Library                      *}
{*                Add-in Express 2010 for VCL                        *}
{*                                                                   *}
{*             Copyright (C) Add-in Express Ltd.                     *}
{*             ALL RIGHTS RESERVED                                   *}
{*                                                                   *}
{*   The entire contents of this file is protected by U.S. and       *}
{*   International Copyright Laws. Unauthorized reproduction,        *}
{*   reverse-engineering, and distribution of all or any portion of  *}
{*   the code contained in this file is strictly prohibited and may  *}
{*   result in severe civil and criminal penalties and will be       *}
{*   prosecuted to the maximum extent possible under the law.        *}
{*                                                                   *}
{*   RESTRICTIONS                                                    *}
{*                                                                   *}
{*   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE       *}
{*   CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS    *}
{*   LTD.                                                            *}
{*   THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE              *}
{*   THE ADX Extensions VCL for Microsoft Outlook                    *}
{*   AND ALL ACCOMPANYING VCL COMPONENTS AS PART OF                  *}
{*   AN EXECUTABLE PROGRAM ONLY.                                     *}
{*                                                                   *}
{*   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      *}
{*   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        *}
{*   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       *}
{*   AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT          *}
{*   AND PERMISSION FROM ADD-IN EXPRESS LTD.                         *}
{*                                                                   *}
{*   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       *}
{*   ADDITIONAL RESTRICTIONS.                                        *}
{*                                                                   *}
{*********************************************************************}

unit adxGdiPAPI;

{$ALIGN ON}
{$MINENUMSIZE 4}

interface
uses
  Windows, Classes;

const
  GDIPlusDLL = 'gdiplus.dll';

type
  TadxGPBase = class
  public
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
  end;

type
  QualityMode = Integer;
const
  QualityModeInvalid   = -1;
  QualityModeDefault   =  0;
  QualityModeLow       =  1;
  QualityModeHigh      =  2;

type
  TUnit = (UnitWorld, UnitDisplay, UnitPixel, UnitPoint, UnitInch, UnitDocument, UnitMillimeter);

  CombineMode = (CombineModeReplace, CombineModeIntersect, CombineModeUnion, CombineModeXor,
    CombineModeExclude, CombineModeComplement);
  TCombineMode = CombineMode;

  ImageType = (ImageTypeUnknown, ImageTypeBitmap, ImageTypeMetafile);
  TImageType = ImageType;

  MatrixOrder = (MatrixOrderPrepend, MatrixOrderAppend);
  TMatrixOrder = MatrixOrder;

type
  SmoothingMode = Integer;
const
  SmoothingModeInvalid     = QualityModeInvalid;
  SmoothingModeDefault     = QualityModeDefault;
  SmoothingModeHighSpeed   = QualityModeLow;
  SmoothingModeHighQuality = QualityModeHigh;
  SmoothingModeNone        = 3;
  SmoothingModeAntiAlias   = 4;

type
  TSmoothingMode = SmoothingMode;

  TextRenderingHint = (
    TextRenderingHintSystemDefault,
    TextRenderingHintSingleBitPerPixelGridFit,
    TextRenderingHintSingleBitPerPixel,
    TextRenderingHintAntiAliasGridFit,
    TextRenderingHintAntiAlias,
    TextRenderingHintClearTypeGridFit
  );
  TTextRenderingHint = TextRenderingHint;

  FlushIntention = (FlushIntentionFlush, FlushIntentionSync);
  TFlushIntention = FlushIntention;

  ImageAbort = function: BOOL; stdcall;
  DrawImageAbort = ImageAbort;

type
  Status = (Ok, GenericError, InvalidParameter, OutOfMemory, ObjectBusy, InsufficientBuffer, NotImplemented,
            Win32Error, WrongState, Aborted, FileNotFound, ValueOverflow, AccessDenied, UnknownImageFormat,
            FontFamilyNotFound, FontStyleNotFound, NotTrueTypeFont, UnsupportedGdiplusVersion,
            GdiplusNotInitialized, PropertyNotFound, PropertyNotSupported);
  TStatus = Status;

type
  PGPPointF = ^TGPPointF;
  TGPPointF = packed record
    X : Single;
    Y : Single;
  end;
  TPointFDynArray = array of TGPPointF;

type
  PGPPoint = ^TGPPoint;
  TGPPoint = packed record
    X : Integer;
    Y : Integer;
  end;
  TPointDynArray = array of TGPPoint;

type
  PGPRectF = ^TGPRectF;
  TGPRectF = packed record
    X     : Single;
    Y     : Single;
    Width : Single;
    Height: Single;
  end;
  TRectFDynArray = array of TGPRectF;

type
  PGPRect = ^TGPRect;
  TGPRect = packed record
    X     : Integer;
    Y     : Integer;
    Width : Integer;
    Height: Integer;
  end;
  TRectDynArray = array of TGPRect;

type
  PCharacterRange = ^TGPCharacterRange;
  TGPCharacterRange = packed record
    First  : Integer;
    Length : Integer;
  end;

type
  DebugEventLevel = (
    DebugEventLevelFatal,
    DebugEventLevelWarning
  );
  TDebugEventLevel = DebugEventLevel;

  DebugEventProc = procedure(level: DebugEventLevel; message: PChar); stdcall;
  NotificationHookProc = function(out token: ULONG): Status; stdcall;
  NotificationUnhookProc = procedure(token: ULONG); stdcall;

  GdiplusStartupInput = packed record
    GdiplusVersion          : Cardinal;
    DebugEventCallback      : DebugEventProc;
    SuppressBackgroundThread: BOOL;

    SuppressExternalCodecs  : BOOL;
  end;
  TGdiplusStartupInput = GdiplusStartupInput;
  PGdiplusStartupInput = ^TGdiplusStartupInput;

  GdiplusStartupOutput = packed record
    NotificationHook  : NotificationHookProc;
    NotificationUnhook: NotificationUnhookProc;
  end;
  TGdiplusStartupOutput = GdiplusStartupOutput;
  PGdiplusStartupOutput = ^TGdiplusStartupOutput;

 function GdiplusStartup(out token: ULONG; input: PGdiplusStartupInput;
   output: PGdiplusStartupOutput): Status; stdcall;

  procedure GdiplusShutdown(token: ULONG); stdcall;

type
  PARGB  = ^ARGB;
  ARGB   = DWORD;
  ARGB64 = Int64;

const
  ALPHA_SHIFT = 24;
  RED_SHIFT   = 16;
  GREEN_SHIFT = 8;
  BLUE_SHIFT  = 0;
  ALPHA_MASK  = (ARGB($ff) shl ALPHA_SHIFT);

  colorTransparent          = $00FFFFFF;
  colorWhite                = $FFFFFFFF;
  colorBlack                = $FF000000;

  AlphaShift  = 24;
  RedShift    = 16;
  GreenShift  = 8;
  BlueShift   = 0;

  AlphaMask   = $ff000000;
  RedMask     = $00ff0000;
  GreenMask   = $0000ff00;
  BlueMask    = $000000ff;

type
  PixelFormat = Integer;
  TPixelFormat = PixelFormat;

const
  PixelFormatIndexed        = $00010000;
  PixelFormatGDI            = $00020000;
  PixelFormatAlpha          = $00040000;
  PixelFormatPAlpha         = $00080000;
  PixelFormatExtended       = $00100000;
  PixelFormatCanonical      = $00200000;
  PixelFormatUndefined      = 0;
  PixelFormatDontCare       = 0;
  PixelFormat1bppIndexed    = (1  or ( 1 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat4bppIndexed    = (2  or ( 4 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat8bppIndexed    = (3  or ( 8 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat16bppGrayScale = (4  or (16 shl 8) or PixelFormatExtended);
  PixelFormat16bppRGB555    = (5  or (16 shl 8) or PixelFormatGDI);
  PixelFormat16bppRGB565    = (6  or (16 shl 8) or PixelFormatGDI);
  PixelFormat16bppARGB1555  = (7  or (16 shl 8) or PixelFormatAlpha or PixelFormatGDI);
  PixelFormat24bppRGB       = (8  or (24 shl 8) or PixelFormatGDI);
  PixelFormat32bppRGB       = (9  or (32 shl 8) or PixelFormatGDI);
  PixelFormat32bppARGB      = (10 or (32 shl 8) or PixelFormatAlpha or PixelFormatGDI or PixelFormatCanonical);
  PixelFormat32bppPARGB     = (11 or (32 shl 8) or PixelFormatAlpha or PixelFormatPAlpha or PixelFormatGDI);
  PixelFormat48bppRGB       = (12 or (48 shl 8) or PixelFormatExtended);
  PixelFormat64bppARGB      = (13 or (64 shl 8) or PixelFormatAlpha  or PixelFormatCanonical or PixelFormatExtended);
  PixelFormat64bppPARGB     = (14 or (64 shl 8) or PixelFormatAlpha  or PixelFormatPAlpha or PixelFormatExtended);
  PixelFormatMax            = 15;

type
  PGPColor = ^TGPColor;
  TGPColor = ARGB;
  TColorDynArray = array of TGPColor;

type
  RECTL = Windows.TRect;
  SIZEL = Windows.TSize;

  ImageLockMode = Integer;
  TImageLockMode = ImageLockMode;

const
    ImageLockModeRead         = $0001;
    ImageLockModeWrite        = $0002;
    ImageLockModeUserInputBuf = $0004;

type
  BitmapData = packed record
    Width       : UINT;
    Height      : UINT;
    Stride      : Integer;
    PixelFormat : PixelFormat;
    Scan0       : Pointer;
    Reserved    : UINT;
  end;
  TBitmapData = BitmapData;
  PBitmapData = ^TBitmapData;

  RotateFlipType = (RotateNoneFlipNone, Rotate90FlipNone, Rotate180FlipNone, Rotate270FlipNone,
                    RotateNoneFlipX, Rotate90FlipX, Rotate180FlipX, Rotate270FlipX);
const
  RotateNoneFlipY    = Rotate180FlipX;
  Rotate90FlipY      = Rotate270FlipX;
  Rotate180FlipY     = RotateNoneFlipX;
  Rotate270FlipY     = Rotate90FlipX;

  RotateNoneFlipXY   = Rotate180FlipNone;
  Rotate90FlipXY     = Rotate270FlipNone;
  Rotate180FlipXY    = RotateNoneFlipNone;
  Rotate270FlipXY    = Rotate90FlipNone;

type
  TRotateFlipType = RotateFlipType;

type
  ColorAdjustType = (
    ColorAdjustTypeDefault,
    ColorAdjustTypeBitmap,
    ColorAdjustTypeBrush,
    ColorAdjustTypePen,
    ColorAdjustTypeText,
    ColorAdjustTypeCount,
    ColorAdjustTypeAny
  );
  TColorAdjustType = ColorAdjustType;

  GpGraphics = Pointer;
  GpBrush = Pointer;
  GpTexture = Pointer;
  GpSolidFill = Pointer;
  GpPen = Pointer;
  GpImage = Pointer;
  GpBitmap = Pointer;
  GpImageAttributes = Pointer;
  GpRegion = Pointer;
  GpFont = Pointer;
  GpStringFormat = Pointer;
  GpStatus          = TStatus;
  GpUnit            = TUnit;
  GpPointF          = PGPPointF;
  GpPoint           = PGPPoint;
  GpRectF           = PGPRectF;
  GpRect            = PGPRect;
  GpMatrixOrder     = TMatrixOrder;
  GpFlushIntention  = TFlushIntention;

type
  TadxGPIconDirEntry = packed record
    bWidth: Byte;
    bHeight: Byte;
    bColorCount: Byte;
    bReserved:  Byte;
    wPlanes: Word;
    wBitCount: Word;
    dwBytesInRes: DWORD;
    dwImageOffset: DWORD;
  end;

  TadxGPIconDirEntries = array of TadxGPIconDirEntry;

  TadxGPIconHeader = packed record
    ihReserved: Word;
    ihType: Word;
    ihCount: Word;
  end;

  TRGBQuads = array of TRGBQuad;
  TGPBytes = array of byte;

  PadxGPIconImage = ^TadxGPIconImage;
  TadxGPIconImage = packed record
    icHeader: TBitmapInfoHeader;
    icColors: TRGBQuads;
    icXOR: TGPBytes;
    icAND: TGPBytes;
  end;

  PadxGPColorData = ^TadxGPColorData;
  TadxGPColorData = array [0..0] of TGPColor;

  TadxGPRegion = class(TadxGPBase)
  protected
    nativeRegion: GpRegion;
    lastResult: TStatus;
    function SetStatus(status: TStatus): TStatus;
    procedure SetNativeRegion(nativeRegion: GpRegion);
  public
    constructor Create(rect: TGPRect); reintroduce; overload;
    destructor Destroy; override;
    function Exclude(const rect: TGPRect): TStatus; overload;
  end;

  TadxGPFont = class(TadxGPBase)
  protected
    nativeFont: GpFont;
    lastResult: TStatus;
    procedure SetNativeFont(Font: GpFont);
  public
    constructor Create(hdc: HDC); reintroduce; overload;
    constructor Create(hdc: HDC; hfont: HFONT); reintroduce; overload;
    destructor Destroy; override;
    property GDIResult: TStatus read lastResult;
  end;

  TadxGPImage = class(TadxGPBase)
  protected
    nativeImage: GpImage;
    lastResult: TStatus;
    loadStatus: TStatus;
    procedure SetNativeImage(nativeImage: GpImage);
    function SetStatus(status: TStatus): TStatus;
    constructor Create(nativeImage: GpImage; status: TStatus); reintroduce; overload;
  public
    destructor Destroy; override;
    function GetType: TImageType;
    function GetWidth: UINT;
    function GetHeight: UINT;
    function RotateFlip(rotateFlipType: TRotateFlipType): TStatus;
  end;

  TadxGPBitmap = class(TadxGPImage)
  public
    constructor Create(width, height: Integer; format: TPixelFormat = PixelFormat32bppARGB); reintroduce; overload;
    function LockBits(rect: TGPRect; flags: UINT; format: TPixelFormat; out lockedBitmapData: TBitmapData): TStatus;
    function UnlockBits(var lockedBitmapData: TBitmapData): TStatus;
    function GetPixel(x, y: Integer; out color: TGPColor): TStatus;
    function SetPixel(x, y: Integer; color: TGPColor): TStatus;
    constructor Create(hInstance: HMODULE; bitmapName: WideString); reintroduce; overload;
  end;

  TadxGPImageAttributes = class(TadxGPBase)
  protected
    nativeImageAttr: GpImageAttributes;
    lastResult: TStatus;
    function SetStatus(status: TStatus): TStatus;
  public
    constructor Create; reintroduce; overload;
    destructor Destroy; override;
    function SetColorKey(colorLow, colorHigh: TGPColor; type_: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
  end;

  TMatrixArray = array[0..5] of Single;

  TadxGPBrush = class(TadxGPBase)
  protected
    nativeBrush: GpBrush;
    lastResult: TStatus;
    procedure SetNativeBrush(nativeBrush: GpBrush);
    function SetStatus(status: TStatus): TStatus;
  public
    destructor Destroy; override;
  end;

  TadxGPSolidBrush = class(TadxGPBrush)
  public
    constructor Create(color: TGPColor); reintroduce; overload;
    function SetColor(color: TGPColor): TStatus;
  end;

  TadxGPTextureBrush = class(TadxGPBrush)
  public
    constructor Create(image: TadxGPImage; dstRect: TGPRect; imageAttributes: TadxGPImageAttributes = nil); reintroduce; overload;
    function TranslateTransform(dx, dy: Single; order: MatrixOrder = MatrixOrderPrepend): TStatus;
    function ScaleTransform(sx, sy: Single; order: TMatrixOrder = MatrixOrderPrepend): TStatus;
  end;

  TadxGPPen = class(TadxGPBase)
  protected
    nativePen: GpPen;
    lastResult: TStatus;
    function SetStatus(status: TStatus): TStatus;
  public
    constructor Create(color: TGPColor; width: Single = 1.0); reintroduce; overload;
    destructor Destroy; override;
    function SetColor(color: TGPColor): TStatus;
  end;

  TadxGPGraphics = class(TadxGPBase)
  protected
    nativeGraphics: GpGraphics;
    lastResult: TStatus;
    procedure SetNativeGraphics(graphics: GpGraphics);
    function SetStatus(status: TStatus): TStatus;
  public
    constructor Create(hdc: HDC); reintroduce; overload;
    constructor Create(image: TadxGPImage); reintroduce; overload;
    destructor Destroy; override;
    procedure Flush(intention: TFlushIntention = FlushIntentionFlush);
    function GetHDC: HDC;
    procedure ReleaseHDC(hdc: HDC);
    function SetTextRenderingHint(newMode: TTextRenderingHint): TStatus;
    function SetSmoothingMode(smoothingMode: TSmoothingMode): TStatus;

    function DrawLine(pen: TadxGPPen; x1, y1, x2, y2: Integer): TStatus; overload;
    function DrawRectangle(pen: TadxGPPen; const rect: TGPRect): TStatus; overload;
    function DrawRectangle(pen: TadxGPPen; x, y, width, height: Integer): TStatus; overload;
    function Clear(color: TGPColor): TStatus;

    function FillRectangle(brush: TadxGPBrush; const rect: TGPRect): TStatus; overload;
    function FillRectangle(brush: TadxGPBrush; x, y, width, height: Integer): TStatus; overload;
    function FillRegion(brush: TadxGPBrush; region: TadxGPRegion): TStatus;

    function DrawString(string_: WideString; length: Integer; font: TadxGPFont;
      const origin: TGPPointF; brush: TadxGPBrush): TStatus; overload;

    function DrawImage(image: TadxGPImage; x, y: Single): TStatus; overload;
    function DrawImage(image: TadxGPImage; x, y: Integer): TStatus; overload;
    function DrawImage(image: TadxGPImage; const rect: TGPRect): TStatus; overload;
    function DrawImage(image: TadxGPImage; x, y, width, height: Integer): TStatus; overload;

    function DrawImage(image: TadxGPImage; const destRect: TGPRect; srcx, srcy,
      srcwidth, srcheight: Integer; srcUnit: TUnit;
      imageAttributes: TadxGPImageAttributes = nil; callback: DrawImageAbort = nil;
      callbackData: Pointer = nil): TStatus; overload;

    function MeasureString(textString: WideString; font: TadxGPFont;
      var textSize: TSize): TStatus;
    function SetClip(region: TadxGPRegion; mode: TCombineMode): TStatus; overload;
    function SetClip(const rect: TGPRect; mode: TCombineMode): TStatus; overload;
  end;

  function MakeRect(x, y, width, height: Integer): TGPRect; overload;
  function MakeRect(const Rect: TRect): TGPRect; overload;
  function MakeColor(r, g, b: Byte): ARGB; overload;
  function MakeColor(a, r, g, b: Byte): ARGB; overload;
  function GetAlpha(color: ARGB): BYTE;
  function GetRed(color: ARGB): BYTE;
  function GetGreen(color: ARGB): BYTE;
  function GetBlue(color: ARGB): BYTE;
  function ColorRefToARGB(rgb: COLORREF): ARGB;
  function ARGBToColorRef(Color: ARGB): COLORREF;

  procedure IconToBitmap(Stream: TStream; var Bitmap: TadxGPBitmap; BestImageIndex: integer = -1);

  function GdipAlloc(size: ULONG): pointer; stdcall;

  procedure GdipFree(ptr: pointer); stdcall;

  function GdipCreateRegionRectI(rect: GPRECT;
    out region: GPREGION): GPSTATUS; stdcall;

  function GdipDeleteRegion(region: GPREGION): GPSTATUS; stdcall;

  function GdipCombineRegionRect(region: GPREGION; rect: GPRECTF;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;

  function GdipCombineRegionRectI(region: GPREGION; rect: GPRECT;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;

  function GdipDeleteBrush(brush: GPBRUSH): GPSTATUS; stdcall;

  function GdipCreateTextureIAI(image: GPIMAGE;
    imageAttributes: GPIMAGEATTRIBUTES; x: Integer; y: Integer; width: Integer;
    height: Integer; out texture: GPTEXTURE): GPSTATUS; stdcall;

  function GdipTranslateTextureTransform(brush: GPTEXTURE; dx: Single;
    dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;

  function GdipResetTextureTransform(brush: GPTEXTURE): GPSTATUS; stdcall;

  function GdipScaleTextureTransform(brush: GPTEXTURE; sx: Single; sy: Single;
    order: GPMATRIXORDER): GPSTATUS; stdcall;

  function GdipCreateSolidFill(color: ARGB;
    out brush: GPSOLIDFILL): GPSTATUS; stdcall;

  function GdipSetSolidFillColor(brush: GPSOLIDFILL;
    color: ARGB): GPSTATUS; stdcall;

  function GdipCreatePen1(color: ARGB; width: Single; unit_: GPUNIT;
    out pen: GPPEN): GPSTATUS; stdcall;

  function GdipDeletePen(pen: GPPEN): GPSTATUS; stdcall;

  function GdipSetPenColor(pen: GPPEN; argb: ARGB): GPSTATUS; stdcall;

  function GdipCloneImage(image: GPIMAGE;
  out cloneImage: GPIMAGE): GPSTATUS; stdcall;

  function GdipDisposeImage(image: GPIMAGE): GPSTATUS; stdcall;

  function GdipGetImageGraphicsContext(image: GPIMAGE;
  out graphics: GPGRAPHICS): GPSTATUS; stdcall;

  function GdipGetImageType(image: GPIMAGE;
  var type_: IMAGETYPE): GPSTATUS; stdcall;

  function GdipGetImageWidth(image: GPIMAGE;
  var width: UINT): GPSTATUS; stdcall;

  function GdipGetImageHeight(image: GPIMAGE;
  var height: UINT): GPSTATUS; stdcall;

  function GdipImageRotateFlip(image: GPIMAGE;
    rfType: ROTATEFLIPTYPE): GPSTATUS; stdcall;

  function GdipCreateBitmapFromScan0(width: Integer; height: Integer;
    stride: Integer; format: PIXELFORMAT; scan0: PBYTE;
    out bitmap: GPBITMAP): GPSTATUS; stdcall;

  function GdipCreateBitmapFromResource(hInstance: HMODULE;
    lpBitmapName: PWCHAR; out bitmap: GPBITMAP): GPSTATUS; stdcall;

  function GdipCloneBitmapArea(x: Single; y: Single; width: Single;
    height: Single; format: PIXELFORMAT; srcBitmap: GPBITMAP;
    out dstBitmap: GPBITMAP): GPSTATUS; stdcall;

  function GdipCloneBitmapAreaI(x: Integer; y: Integer; width: Integer;
    height: Integer; format: PIXELFORMAT; srcBitmap: GPBITMAP;
    out dstBitmap: GPBITMAP): GPSTATUS; stdcall;

  function GdipBitmapLockBits(bitmap: GPBITMAP; rect: GPRECT; flags: UINT;
    format: PIXELFORMAT; lockedBitmapData: PBITMAPDATA): GPSTATUS; stdcall;

  function GdipBitmapUnlockBits(bitmap: GPBITMAP;
    lockedBitmapData: PBITMAPDATA): GPSTATUS; stdcall;

  function GdipBitmapGetPixel(bitmap: GPBITMAP; x: Integer; y: Integer;
    var color: ARGB): GPSTATUS; stdcall;

  function GdipBitmapSetPixel(bitmap: GPBITMAP; x: Integer; y: Integer;
    color: ARGB): GPSTATUS; stdcall;

  function GdipBitmapSetResolution(bitmap: GPBITMAP; xdpi: Single;
    ydpi: Single): GPSTATUS; stdcall;

  function GdipCreateImageAttributes(
    out imageattr: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;

  function GdipDisposeImageAttributes(
    imageattr: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;

  function GdipSetImageAttributesColorKeys(imageattr: GPIMAGEATTRIBUTES;
    type_: COLORADJUSTTYPE; enableFlag: Bool; colorLow: ARGB;
    colorHigh: ARGB): GPSTATUS; stdcall;

  function GdipFlush(graphics: GPGRAPHICS;
    intention: GPFLUSHINTENTION): GPSTATUS; stdcall;

  function GdipCreateFromHDC(hdc: HDC;
    out graphics: GPGRAPHICS): GPSTATUS; stdcall;

  function GdipDeleteGraphics(graphics: GPGRAPHICS): GPSTATUS; stdcall;

  function GdipGetDC(graphics: GPGRAPHICS; var hdc: HDC): GPSTATUS; stdcall;

  function GdipReleaseDC(graphics: GPGRAPHICS; hdc: HDC): GPSTATUS; stdcall;

  function GdipSetSmoothingMode(graphics: GPGRAPHICS;
    smoothingMode: SMOOTHINGMODE): GPSTATUS; stdcall;

  function GdipSetTextRenderingHint(graphics: GPGRAPHICS;
    mode: TEXTRENDERINGHINT): GPSTATUS; stdcall;

  function GdipDrawLine(graphics: GPGRAPHICS; pen: GPPEN; x1: Single;
    y1: Single; x2: Single; y2: Single): GPSTATUS; stdcall;

  function GdipDrawLineI(graphics: GPGRAPHICS; pen: GPPEN; x1: Integer;
    y1: Integer; x2: Integer; y2: Integer): GPSTATUS; stdcall;

  function GdipDrawRectangle(graphics: GPGRAPHICS; pen: GPPEN; x: Single;
    y: Single; width: Single; height: Single): GPSTATUS; stdcall;

  function GdipDrawRectangleI(graphics: GPGRAPHICS; pen: GPPEN; x: Integer;
    y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;

  function GdipGraphicsClear(graphics: GPGRAPHICS;
    color: ARGB): GPSTATUS; stdcall;

  function GdipFillRectangle(graphics: GPGRAPHICS; brush: GPBRUSH; x: Single;
    y: Single; width: Single; height: Single): GPSTATUS; stdcall;

  function GdipFillRectangleI(graphics: GPGRAPHICS; brush: GPBRUSH; x: Integer;
    y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;

  function GdipFillRegion(graphics: GPGRAPHICS; brush: GPBRUSH;
    region: GPREGION): GPSTATUS; stdcall;

  function GdipDrawImage(graphics: GPGRAPHICS; image: GPIMAGE; x: Single;
    y: Single): GPSTATUS; stdcall;

  function GdipDrawImageI(graphics: GPGRAPHICS; image: GPIMAGE; x: Integer;
    y: Integer): GPSTATUS; stdcall;

  function GdipDrawImageRect(graphics: GPGRAPHICS; image: GPIMAGE; x: Single;
    y: Single; width: Single; height: Single): GPSTATUS; stdcall;

  function GdipDrawImageRectI(graphics: GPGRAPHICS; image: GPIMAGE; x: Integer;
    y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;

  function GdipDrawImageRectRect(graphics: GPGRAPHICS; image: GPIMAGE;
    dstx: Single; dsty: Single; dstwidth: Single; dstheight: Single;
    srcx: Single; srcy: Single; srcwidth: Single; srcheight: Single;
    srcUnit: GPUNIT; imageAttributes: GPIMAGEATTRIBUTES;
    callback: DRAWIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;

  function GdipDrawImageRectRectI(graphics: GPGRAPHICS; image: GPIMAGE;
    dstx: Integer; dsty: Integer; dstwidth: Integer; dstheight: Integer;
    srcx: Integer; srcy: Integer; srcwidth: Integer; srcheight: Integer;
    srcUnit: GPUNIT; imageAttributes: GPIMAGEATTRIBUTES;
    callback: DRAWIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;

  function GdipCreateFontFromDC(hdc: HDC; out font: GPFONT): GPSTATUS; stdcall;

  function GdipCreateFontFromLogfontA(hdc: HDC; logfont: PLOGFONTA;
    out font: GPFONT): GPSTATUS; stdcall;

  function GdipDeleteFont(font: GPFONT): GPSTATUS; stdcall;

  function GdipDrawString(graphics: GPGRAPHICS; string_: PWCHAR;
    length: Integer; font: GPFONT; layoutRect: PGPRectF;
    stringFormat: GPSTRINGFORMAT; brush: GPBRUSH): GPSTATUS; stdcall;

  function GdipMeasureString(graphics: GPGRAPHICS; string_: PWCHAR;
    length: Integer; font: GPFONT; layoutRect: PGPRectF;
    stringFormat: GPSTRINGFORMAT; boundingBox: PGPRectF;
    codepointsFitted: PInteger; linesFilled: PInteger): GPSTATUS; stdcall;

  function GdipSetClipRegion(graphics: GPGRAPHICS; region: GPREGION;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;

  function GdipSetClipRectI(graphics: GPGRAPHICS; x: Integer; y: Integer;
    width: Integer; height: Integer;
    combineMode: COMBINEMODE): GPSTATUS; stdcall;

  procedure StartupGDI;

  procedure ShutdownGDI;


var
   GDIStarted: boolean;
   StartupInput: TGDIPlusStartupInput;
   StartupOutput: TGDIPlusStartupOutput;
   gdiplusToken: ULONG;

implementation

  function GdipAlloc; external GDIPlusDLL name 'GdipAlloc';
  procedure GdipFree; external GDIPlusDLL name 'GdipFree';
  function GdiplusStartup; external GDIPlusDLL name 'GdiplusStartup';
  procedure GdiplusShutdown; external GDIPlusDLL name 'GdiplusShutdown';

  function GdipCreateRegionRectI; external GDIPlusDLL name 'GdipCreateRegionRectI';
  function GdipDeleteRegion; external GDIPlusDLL name 'GdipDeleteRegion';
  function GdipCombineRegionRect; external GDIPlusDLL name 'GdipCombineRegionRect';
  function GdipCombineRegionRectI; external GDIPlusDLL name 'GdipCombineRegionRectI';
  function GdipDeleteBrush; external GDIPlusDLL name 'GdipDeleteBrush';
  function GdipCreateTextureIAI; external GDIPlusDLL name 'GdipCreateTextureIAI';
  function GdipTranslateTextureTransform; external GDIPlusDLL name 'GdipTranslateTextureTransform';
  function GdipResetTextureTransform; external GDIPlusDLL name 'GdipResetTextureTransform';
  function GdipScaleTextureTransform; external GDIPlusDLL name 'GdipScaleTextureTransform';
  function GdipCreateSolidFill; external GDIPlusDLL name 'GdipCreateSolidFill';
  function GdipSetSolidFillColor; external GDIPlusDLL name 'GdipSetSolidFillColor';
  function GdipCreatePen1; external GDIPlusDLL name 'GdipCreatePen1';
  function GdipDeletePen; external GDIPlusDLL name 'GdipDeletePen';
  function GdipSetPenColor; external GDIPlusDLL name 'GdipSetPenColor';
  function GdipCloneImage; external GDIPlusDLL name 'GdipCloneImage';
  function GdipDisposeImage; external GDIPlusDLL name 'GdipDisposeImage';
  function GdipGetImageGraphicsContext; external GDIPlusDLL name 'GdipGetImageGraphicsContext';
  function GdipGetImageType; external GDIPlusDLL name 'GdipGetImageType';
  function GdipGetImageWidth; external GDIPlusDLL name 'GdipGetImageWidth';
  function GdipGetImageHeight; external GDIPlusDLL name 'GdipGetImageHeight';
  function GdipImageRotateFlip; external GDIPlusDLL name 'GdipImageRotateFlip';
  function GdipCreateBitmapFromScan0; external GDIPlusDLL name 'GdipCreateBitmapFromScan0';
  function GdipCreateBitmapFromResource; external GDIPlusDLL name 'GdipCreateBitmapFromResource';
  function GdipCloneBitmapArea; external GDIPlusDLL name 'GdipCloneBitmapArea';
  function GdipCloneBitmapAreaI; external GDIPlusDLL name 'GdipCloneBitmapAreaI';
  function GdipBitmapLockBits; external GDIPlusDLL name 'GdipBitmapLockBits';
  function GdipBitmapUnlockBits; external GDIPlusDLL name 'GdipBitmapUnlockBits';
  function GdipBitmapGetPixel; external GDIPlusDLL name 'GdipBitmapGetPixel';
  function GdipBitmapSetPixel; external GDIPlusDLL name 'GdipBitmapSetPixel';
  function GdipBitmapSetResolution; external GDIPlusDLL name 'GdipBitmapSetResolution';
  function GdipCreateImageAttributes; external GDIPlusDLL name 'GdipCreateImageAttributes';
  function GdipDisposeImageAttributes; external GDIPlusDLL name 'GdipDisposeImageAttributes';
  function GdipSetImageAttributesColorKeys; external GDIPlusDLL name 'GdipSetImageAttributesColorKeys';
  function GdipFlush; external GDIPlusDLL name 'GdipFlush';
  function GdipCreateFromHDC; external GDIPlusDLL name 'GdipCreateFromHDC';
  function GdipDeleteGraphics; external GDIPlusDLL name 'GdipDeleteGraphics';
  function GdipGetDC; external GDIPlusDLL name 'GdipGetDC';
  function GdipReleaseDC; external GDIPlusDLL name 'GdipReleaseDC';
  function GdipSetSmoothingMode; external GDIPlusDLL name 'GdipSetSmoothingMode';
  function GdipSetTextRenderingHint; external GDIPlusDLL name 'GdipSetTextRenderingHint';
  function GdipDrawLine; external GDIPlusDLL name 'GdipDrawLine';
  function GdipDrawLineI; external GDIPlusDLL name 'GdipDrawLineI';
  function GdipDrawRectangle; external GDIPlusDLL name 'GdipDrawRectangle';
  function GdipDrawRectangleI; external GDIPlusDLL name 'GdipDrawRectangleI';
  function GdipGraphicsClear; external GDIPlusDLL name 'GdipGraphicsClear';
  function GdipFillRectangle; external GDIPlusDLL name 'GdipFillRectangle';
  function GdipFillRectangleI; external GDIPlusDLL name 'GdipFillRectangleI';
  function GdipFillRegion; external GDIPlusDLL name 'GdipFillRegion';
  function GdipDrawImage; external GDIPlusDLL name 'GdipDrawImage';
  function GdipDrawImageI; external GDIPlusDLL name 'GdipDrawImageI';
  function GdipDrawImageRect; external GDIPlusDLL name 'GdipDrawImageRect';
  function GdipDrawImageRectI; external GDIPlusDLL name 'GdipDrawImageRectI';
  function GdipDrawImageRectRect; external GDIPlusDLL name 'GdipDrawImageRectRect';
  function GdipDrawImageRectRectI; external GDIPlusDLL name 'GdipDrawImageRectRectI';
  function GdipCreateFontFromDC; external GDIPlusDLL name 'GdipCreateFontFromDC';
  function GdipCreateFontFromLogfontA; external GDIPlusDLL name 'GdipCreateFontFromLogfontA';
  function GdipDeleteFont; external GDIPlusDLL name 'GdipDeleteFont';
  function GdipDrawString; external GDIPlusDLL name 'GdipDrawString';
  function GdipMeasureString; external GDIPlusDLL name 'GdipMeasureString';
  function GdipSetClipRegion; external GDIPlusDLL name 'GdipSetClipRegion';
  function GdipSetClipRectI; external GDIPlusDLL name 'GdipSetClipRectI';

function MakeRect(x, y, width, height: Integer): TGPRect; overload;
begin
  Result.X      := x;
  Result.Y      := y;
  Result.Width  := width;
  Result.Height := height;
end;

function MakeRect(const Rect: TRect): TGPRect;
begin
  Result.X := rect.Left;
  Result.Y := Rect.Top;
  Result.Width := Rect.Right-Rect.Left;
  Result.Height:= Rect.Bottom-Rect.Top;
end;

function MakeColor(r, g, b: Byte): ARGB; overload;
begin
  result := MakeColor(255, r, g, b);
end;

function MakeColor(a, r, g, b: Byte): ARGB; overload;
begin
  result := ((DWORD(b) shl  BlueShift) or
             (DWORD(g) shl GreenShift) or
             (DWORD(r) shl   RedShift) or
             (DWORD(a) shl AlphaShift));
end;

function GetAlpha(color: ARGB): BYTE;
begin
  result := BYTE(color shr AlphaShift);
end;

function GetRed(color: ARGB): BYTE;
begin
  result := BYTE(color shr RedShift);
end;

function GetGreen(color: ARGB): BYTE;
begin
  result := BYTE(color shr GreenShift);
end;

function GetBlue(color: ARGB): BYTE;
begin
  result := BYTE(color shr BlueShift);
end;

function ColorRefToARGB(rgb: COLORREF): ARGB;
begin
  result := MakeColor(255, GetRValue(rgb), GetGValue(rgb), GetBValue(rgb));
end;

function ARGBToColorRef(Color: ARGB): COLORREF;
begin
  result := RGB(GetRed(Color), GetGreen(Color), GetBlue(Color));
end;

procedure IconToBitmap(Stream: TStream; var Bitmap: TadxGPBitmap; BestImageIndex: integer = -1);
const
  BestImageSize = 16;
var
  icHeader: TadxGPIconHeader;
  icEntries: TadxGPIconDirEntries;
  icImage: TadxGPIconImage;

  iconIndex, iconBits, iWidth, iHeight: integer;
  bitmapData: TBitmapData;
  i, j, row, col, t, cl, maskByte, maskLen: integer;
  pColor: PadxGPColorData;
  icRGB: TRGBQuad;

begin
  Bitmap:= nil; iconIndex:= 0; iconBits:= 1;
  Stream.Seek(0, soFromBeginning);
  Stream.Read(icHeader, sizeOf(TadxGPIconHeader));

  if (icHeader.ihCount > 0) and (icHeader.ihType > 0) then begin
    SetLength(icEntries, icHeader.ihCount);

    for i:= 0 to  icHeader.ihCount-1 do begin
      Stream.Read(icEntries[i], sizeOf(TadxGPIconDirEntry));
      if icEntries[i].wBitCount >= iconBits then begin
        iconIndex:= i;
        iconBits:= icEntries[i].wBitCount;
      end;
    end;
    if (BestImageIndex > -1) and (BestImageIndex < icHeader.ihCount) then
      iconIndex:= BestImageIndex;

    Stream.seek(icEntries[iconIndex].dwImageOffset, soFromBeginning);
    Stream.Read(icImage.icHeader, sizeOf(TBitmapInfoHeader));

    iWidth:= icEntries[iconIndex].bWidth;
    iHeight:= icEntries[iconIndex].bHeight;
    maskLen:= (round(int(iWidth/ 32))+ byte(iWidth mod 32 > 0))* 32;

    t := iWidth* iHeight;
    if icImage.icHeader.biBitCount in [1, 4, 8, 24, 32] then begin
      case icImage.icHeader.biBitCount of
        1: begin
          SetLength(icImage.icColors, 2);
          Stream.Read(icImage.icColors[0], sizeOf(TRGBQuad)* 2);
          SetLength(icImage.icXOR, t div 8);
          Stream.Read(icImage.icXOR[0], t div 8);
        end;
        4: begin
          SetLength(icImage.icColors, 16);
          Stream.Read(icImage.icColors[0], sizeOf(TRGBQuad)* 16);
          SetLength(icImage.icXOR, t div 2);
          Stream.Read(icImage.icXOR[0], t div 2);
        end;
        8: begin
          SetLength(icImage.icColors, 256);
          Stream.Read(icImage.icColors[0], sizeOf(TRGBQuad)* 256);
          SetLength(icImage.icXOR, t);
          Stream.Read(icImage.icXOR[0], t);
        end;
        24: begin
          icImage.icColors:= nil;
          SetLength(icImage.icXOR, t* 3);
          Stream.Read(icImage.icXOR[0], t* 3);
        end;
        32: begin
          icImage.icColors:= nil;
          SetLength(icImage.icXOR, t* 4);
          Stream.Read(icImage.icXOR[0], t* 4);
        end;
      end;
      SetLength(icImage.icAND, (maskLen* iHeight) div 8);
      Stream.Read(icImage.icAND[0], (maskLen* iHeight) div 8);

      Bitmap:= TadxGPBitmap.Create(iWidth, iHeight, PixelFormat32bppARGB);

      Bitmap.LockBits(MakeRect(0, 0, iWidth, iHeight), ImageLockModeWrite, PixelFormat32bppARGB, bitmapData);
      try
        pColor:= PadxGPColorData(bitmapData.Scan0);

        if icImage.icHeader.biBitCount in [1, 4, 8, 24, 32] then begin
        for row := 0 to iHeight- 1 do
          for col:= 0 to iWidth- 1 do begin
            i:= row* iWidth+ col;
            j:= (iHeight- 1- row)* iWidth+ col;
            maskByte:= (i div iWidth)* 4 + ((i mod iWidth) div 8);
            if icImage.icAND[maskByte] and ($01 shl (7- i mod 8)) = 0 then  begin
              case icImage.icHeader.biBitCount of
                1: begin
                  cl:= byte( icImage.icXOR[i div 8] and ($01 shl (7- i mod 8)) > 0 );
                  icRGB:= icImage.icColors[cl];
                  icRGB.rgbReserved:= $FF;
                end;
                4: begin
                  cl:= icImage.icXOR[i div 2];
                  if (i mod 2) = 0 then
                    cl:= (cl and $F0) shr 4
                  else
                    cl:= cl and $0F;
                  icRGB:= icImage.icColors[cl];
                  icRGB.rgbReserved:= $FF;
                end;
                8: begin
                  cl:= icImage.icXOR[i];
                  icRGB:= icImage.icColors[cl];
                  icRGB.rgbReserved:= $FF;
                end;
                24: begin
                  icRGB.rgbRed:=    icImage.icXOR[i*3+ 2];
                  icRGB.rgbGreen:=  icImage.icXOR[i*3+ 1];
                  icRGB.rgbBlue:=   icImage.icXOR[i*3];
                  icRGB.rgbReserved:= $FF;
                end;
                32: begin
                  icRGB.rgbRed:=      icImage.icXOR[i*4+ 2];
                  icRGB.rgbGreen:=    icImage.icXOR[i*4+ 1];
                  icRGB.rgbBlue:=     icImage.icXOR[i*4];
                  icRGB.rgbReserved:= icImage.icXOR[i*4+ 3];
                end;
              end;
              pColor^[j]:= MakeColor(icRGB.rgbReserved, icRGB.rgbRed, icRGB.rgbGreen, icRGB.rgbBlue);
            end
            else
              pColor^[j]:= colorTransparent;
          end;
        end;
      finally
        Bitmap.UnlockBits(bitmapData);
      end;

      SetLength(icImage.icColors, 0);
      SetLength(icImage.icXOR, 0);
      SetLength(icImage.icXOR, 0);
    end;
    SetLength(icEntries, 0);
  end;
end;

{ TadxGdiplusBase }

class function TadxGPBase.NewInstance: TObject;
begin
  Result := InitInstance(GdipAlloc(ULONG(instanceSize)));
end;

procedure TadxGPBase.FreeInstance;
begin
  CleanupInstance;
  GdipFree(Self);
end;

{ TadxGPImageAttributes }

constructor TadxGPImageAttributes.Create;
begin
  nativeImageAttr := nil;
  lastResult := GdipCreateImageAttributes(nativeImageAttr);
end;

destructor TadxGPImageAttributes.Destroy;
begin
  GdipDisposeImageAttributes(nativeImageAttr);
  inherited Destroy;
end;

function TadxGPImageAttributes.SetColorKey(colorLow, colorHigh: TGPColor;
  type_: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
  result := SetStatus(GdipSetImageAttributesColorKeys(nativeImageAttr, type_,
    TRUE, colorLow, colorHigh));
end;

function TadxGPImageAttributes.SetStatus(status: TStatus): TStatus;
begin
  if (status <> Ok) then lastResult := status;
  result := status;
end;

{ TadxGPRegion }

constructor TadxGPRegion.Create(rect: TGPRect);
var
  region: GpRegion;
begin
  region := nil;
  lastResult := GdipCreateRegionRectI(@rect, region);
  SetNativeRegion(region);
end;

destructor TadxGPRegion.Destroy;
begin
  GdipDeleteRegion(nativeRegion);
end;

function TadxGPRegion.Exclude(const rect: TGPRect): TStatus;
begin
   result := SetStatus(GdipCombineRegionRectI(nativeRegion, @rect, CombineModeExclude));
end;

function TadxGPRegion.SetStatus(status: TStatus): TStatus;
begin
  if (status <> Ok) then lastResult := status;
  result := status;
end;

procedure TadxGPRegion.SetNativeRegion(nativeRegion: GpRegion);
begin
  self.nativeRegion := nativeRegion;
end;

{TadxGPPen}

constructor TadxGPPen.Create(color: TGPColor; width: Single = 1.0);
var unit_: TUnit;
begin
  unit_ := UnitWorld;
  nativePen := nil;
  lastResult := GdipCreatePen1(color, width, unit_, nativePen);
end;

destructor TadxGPPen.Destroy;
begin
  GdipDeletePen(nativePen);
end;

function TadxGPPen.SetColor(color: TGPColor): TStatus;
begin
  result := SetStatus(GdipSetPenColor(nativePen, color));
end;

function TadxGPPen.SetStatus(status: TStatus): TStatus;
begin
  if (status <> Ok) then lastResult := status;
  result := status;
end;

{ TadxGPBrush }

destructor TadxGPBrush.Destroy;
begin
  GdipDeleteBrush(nativeBrush);
end;

procedure TadxGPBrush.SetNativeBrush(nativeBrush: GpBrush);
begin
  self.nativeBrush := nativeBrush;
end;

function TadxGPBrush.SetStatus(status: TStatus): TStatus;
begin
  if (status <> Ok) then lastResult := status;
  result := status;
end;

{ TadxGPSolidBrush }

constructor TadxGPSolidBrush.Create(color: TGPColor);
var
  brush: GpSolidFill;
begin
  brush := nil;
  lastResult := GdipCreateSolidFill(color, brush);
  SetNativeBrush(brush);
end;

function TadxGPSolidBrush.SetColor(color: TGPColor): TStatus;
begin
  result := SetStatus(GdipSetSolidFillColor(GpSolidFill(nativeBrush), color));
end;

{ TadxGPTextureBrush }

constructor TadxGPTextureBrush.Create(image: TadxGPImage; dstRect: TGPRect; imageAttributes: TadxGPImageAttributes = nil);
var texture: GpTexture;
    ImgAtt: GpImageAttributes;
begin
  texture := nil;
  if assigned(imageAttributes) then
    ImgAtt := imageAttributes.nativeImageAttr
  else ImgAtt := nil;

  lastResult := GdipCreateTextureIAI(image.nativeImage, ImgAtt, dstRect.X,
    dstRect.Y, dstRect.Width, dstRect.Height, texture);

  SetNativeBrush(texture);
end;

function TadxGPTextureBrush.TranslateTransform(dx, dy: Single; order: MatrixOrder = MatrixOrderPrepend): TStatus;
begin
  result := SetStatus(GdipTranslateTextureTransform(GpTexture(nativeBrush), dx, dy, order));
end;

function TadxGPTextureBrush.ScaleTransform(sx, sy: Single; order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
  result := SetStatus(GdipScaleTextureTransform(GpTexture(nativeBrush), sx, sy, order));
end;

{ TadxGPImage }

destructor TadxGPImage.Destroy;
begin
  GdipDisposeImage(nativeImage);
end;

function TadxGPImage.GetType: TImageType;
begin
  SetStatus(GdipGetImageType(nativeImage, result));
end;

function TadxGPImage.GetWidth: UINT;
var width: UINT;
begin
  width := 0;
  SetStatus(GdipGetImageWidth(nativeImage, width));
  result := width;
end;

function TadxGPImage.GetHeight: UINT;
var height: UINT;
begin
  height := 0;
  SetStatus(GdipGetImageHeight(nativeImage, height));
  result := height;
end;

function TadxGPImage.RotateFlip(rotateFlipType: TRotateFlipType): TStatus;
begin
  result := SetStatus(GdipImageRotateFlip(nativeImage, rotateFlipType));
end;

constructor TadxGPImage.Create(nativeImage: GpImage; status: TStatus);
begin
  SetNativeImage(nativeImage);
  lastResult := status;
end;

procedure TadxGPImage.SetNativeImage(nativeImage: GpImage);
begin
  self.nativeImage := nativeImage;
end;

function TadxGPImage.SetStatus(status: TStatus): TStatus;
begin
  if (status <> Ok) then lastResult := status;
  result := status;
end;

{ TadxGPBitmap }

constructor TadxGPBitmap.Create(width, height: Integer; format: TPixelFormat = PixelFormat32bppARGB);
var bitmap: GpBitmap;
begin
  bitmap := nil;
  lastResult := GdipCreateBitmapFromScan0(width, height, 0, format, nil, bitmap);
  SetNativeImage(bitmap);
end;

function TadxGPBitmap.LockBits(rect: TGPRect; flags: UINT; format: TPixelFormat; out lockedBitmapData: TBitmapData): TStatus;
begin
  result := SetStatus(GdipBitmapLockBits(GpBitmap(nativeImage), @rect, flags, format, @lockedBitmapData));
end;

function TadxGPBitmap.UnlockBits(var lockedBitmapData: TBitmapData): TStatus;
begin
  result := SetStatus(GdipBitmapUnlockBits(GpBitmap(nativeImage), @lockedBitmapData));
end;

function TadxGPBitmap.GetPixel(x, y: Integer; out color: TGPColor): TStatus;
begin
  result := SetStatus(GdipBitmapGetPixel(GpBitmap(nativeImage), x, y, color));
end;

function TadxGPBitmap.SetPixel(x, y: Integer; color: TGPColor): TStatus;
begin
  result := SetStatus(GdipBitmapSetPixel(GpBitmap(nativeImage), x, y, color));
end;


constructor TadxGPBitmap.Create(hInstance: HMODULE; bitmapName: WideString);
var bitmap: GpBitmap;
begin
  bitmap := nil;
  lastResult := GdipCreateBitmapFromResource(hInstance, PWideChar(bitmapName), bitmap);
  SetNativeImage(bitmap);
end;

{ TadxGPGraphics }

constructor TadxGPGraphics.Create(hdc: HDC);
var graphics: GpGraphics;
begin
  graphics:= nil;
  lastResult := GdipCreateFromHDC(hdc, graphics);
  SetNativeGraphics(graphics);
end;

constructor TadxGPGraphics.Create(image: TadxGPImage);
var graphics: GpGraphics;
begin
  graphics:= nil;
  if (image <> nil) then
    lastResult := GdipGetImageGraphicsContext(image.nativeImage, graphics);
  SetNativeGraphics(graphics);
end;

destructor TadxGPGraphics.Destroy;
begin
  GdipDeleteGraphics(nativeGraphics);
end;

procedure TadxGPGraphics.Flush(intention: TFlushIntention = FlushIntentionFlush);
begin
  GdipFlush(nativeGraphics, intention);
end;

function TadxGPGraphics.GetHDC: HDC;
begin
  SetStatus(GdipGetDC(nativeGraphics, result));
end;

function TadxGPGraphics.MeasureString(textString: WideString; font: TadxGPFont;
  var textSize: TSize): TStatus;
var
  layoutRect: TGPRectF;
  boundingBox: TGPRectF;
begin
  layoutRect.X := 0;
  layoutRect.Y := 0;
  layoutRect.Width  := 0;
  layoutRect.Height := 0;

  boundingBox.X := 0;
  boundingBox.Y := 0;
  boundingBox.Width  := 0;
  boundingBox.Height := 0;

  result := SetStatus(GdipMeasureString(nativeGraphics, PWideChar(textString),
    length(textString), font.nativeFont, @layoutRect, nil, @boundingBox, nil, nil));
  textSize.cx:= Round(boundingBox.Width);
  textSize.cy:= Round(boundingBox.Height);
end;

procedure TadxGPGraphics.ReleaseHDC(hdc: HDC);
begin
  SetStatus(GdipReleaseDC(nativeGraphics, hdc));
end;

function TadxGPGraphics.SetTextRenderingHint(newMode: TTextRenderingHint): TStatus;
begin
  result := SetStatus(GdipSetTextRenderingHint(nativeGraphics, newMode));
end;

function TadxGPGraphics.SetSmoothingMode(smoothingMode: TSmoothingMode): TStatus;
begin
  result := SetStatus(GdipSetSmoothingMode(nativeGraphics, smoothingMode));
end;

function TadxGPGraphics.DrawLine(pen: TadxGPPen; x1, y1, x2, y2: Integer): TStatus;
begin
  result := SetStatus(GdipDrawLineI(nativeGraphics, pen.nativePen, x1, y1, x2, y2));
end;

function TadxGPGraphics.DrawRectangle(pen: TadxGPPen; const rect: TGPRect): TStatus;
begin
  result := DrawRectangle(pen, rect.X, rect.Y, rect.Width, rect.Height);
end;

function TadxGPGraphics.DrawRectangle(pen: TadxGPPen; x, y, width, height: Integer): TStatus;
begin
  result := SetStatus(GdipDrawRectangleI(nativeGraphics, pen.nativePen, x, y, width, height));
end;

function TadxGPGraphics.Clear(color: TGPColor): TStatus;
begin
  result := SetStatus(GdipGraphicsClear(nativeGraphics, color));
end;

function TadxGPGraphics.FillRectangle(brush: TadxGPBrush; const rect: TGPRect): TStatus;
begin
  result := FillRectangle(brush, rect.X, rect.Y, rect.Width, rect.Height);
end;

function TadxGPGraphics.FillRectangle(brush: TadxGPBrush; x, y, width, height: Integer): TStatus;
begin
  result := SetStatus(GdipFillRectangleI(nativeGraphics, brush.nativeBrush, x, y, width, height));
end;

function TadxGPGraphics.FillRegion(brush: TadxGPBrush; region: TadxGPRegion): TStatus;
begin
  result := SetStatus(GdipFillRegion(nativeGraphics, brush.nativeBrush, region.nativeRegion));
end;

function TadxGPGraphics.DrawString(string_: WideString; length: Integer; font: TadxGPFont;
         const origin: TGPPointF; brush: TadxGPBrush): TStatus;
var
  rect: TGPRectF;
  nfont: Gpfont;
  nBrush: GpBrush;
begin
  rect.X := origin.X;
  rect.Y := origin.Y;
  rect.Width := 0.0;
  rect.Height := 0.0;
  if assigned(font) then
    nfont := font.nativeFont
  else nfont := nil;

  if assigned(Brush) then
    nBrush := Brush.nativeBrush
  else nBrush := nil;

  result := SetStatus(GdipDrawString(nativeGraphics, PWideChar(string_), length, nfont, @rect, nil, nbrush));
end;

function TadxGPGraphics.SetClip(const rect: TGPRect; mode: TCombineMode): TStatus;
begin
  result := SetStatus(GdipSetClipRectI(nativeGraphics, rect.X, rect.Y,
              rect.Width, rect.Height, mode));
end;

function TadxGPGraphics.SetClip(region: TadxGPRegion; mode: TCombineMode): TStatus;
begin
  result := SetStatus(GdipSetClipRegion(nativeGraphics, region.nativeRegion, mode));
end;

function TadxGPGraphics.DrawImage(image: TadxGPImage; x, y: Single): TStatus;
var
 nImage: GpImage;
begin
  if assigned(Image) then nImage := Image.nativeImage else nImage := nil;
  result := SetStatus(GdipDrawImage(nativeGraphics, nImage, x, y));
end;

function TadxGPGraphics.DrawImage(image: TadxGPImage; x, y: Integer): TStatus;
var
 nImage: GpImage;
begin
  if assigned(Image) then
    nImage := Image.nativeImage
  else nImage := nil;

  result := SetStatus(GdipDrawImageI(nativeGraphics, nimage, x, y));
end;

function TadxGPGraphics.DrawImage(image: TadxGPImage; const rect: TGPRect): TStatus;
begin
  result := DrawImage(image, rect.X, rect.Y, rect.Width, rect.Height);
end;

function TadxGPGraphics.DrawImage(image: TadxGPImage; x, y, width, height: Integer): TStatus;
var
 nImage: GpImage;
begin
  if assigned(Image) then
    nImage := Image.nativeImage
  else nImage := nil;

  result := SetStatus(GdipDrawImageRectI(nativeGraphics, nimage, x, y, width, height));
end;

function TadxGPGraphics.DrawImage(image: TadxGPImage; const destRect: TGPRect; srcx, srcy, srcwidth,
     srcheight: Integer; srcUnit: TUnit; imageAttributes: TadxGPImageAttributes = nil;
     callback: DrawImageAbort = nil; callbackData: Pointer = nil): TStatus;
var
  nImage: GpImage;
  nimageAttributes: GpimageAttributes;
begin
  if assigned(Image) then
    nImage := Image.nativeImage
  else nImage := nil;
  if assigned(imageAttributes) then
    nimageAttributes := imageAttributes.nativeImageAttr
  else nimageAttributes := nil;

  result := SetStatus(GdipDrawImageRectRectI(nativeGraphics, nimage, destRect.X, destRect.Y,
                      destRect.Width, destRect.Height, srcx, srcy, srcwidth, srcheight,
                      srcUnit, nimageAttributes, callback, callbackData));
end;

procedure TadxGPGraphics.SetNativeGraphics(graphics: GpGraphics);
begin
  self.nativeGraphics := graphics;
end;

function TadxGPGraphics.SetStatus(status: TStatus): TStatus;
begin
  if (status <> Ok) then lastResult := status;
  result := status;
end;

{ TadxGPFont }

constructor TadxGPFont.Create(hdc: HDC);
var font: GpFont;
begin
  font := nil;
  lastResult := GdipCreateFontFromDC(hdc, font);
  SetNativeFont(font);
end;

constructor TadxGPFont.Create(hdc: HDC; hfont: HFONT);
var
  font: GpFont;
  lf: LOGFONTA;
begin
  font := nil;
  if BOOL(hfont) then
  begin
    if( BOOL(GetObjectA(hfont, sizeof(LOGFONTA), @lf))) then
          lastResult := GdipCreateFontFromLogfontA(hdc, @lf, font)
      else
          lastResult := GdipCreateFontFromDC(hdc, font);
  end
  else
    lastResult := GdipCreateFontFromDC(hdc, font);
  SetNativeFont(font);
end;

destructor TadxGPFont.Destroy;
begin
  GdipDeleteFont(nativeFont);
end;

procedure TadxGPFont.SetNativeFont(Font: GpFont);
begin
  nativeFont := Font;
end;

procedure StartupGDI;
begin
  if (not GDIStarted) then begin
    StartupInput.DebugEventCallback := nil;
    StartupInput.SuppressBackgroundThread := true;
    StartupInput.SuppressExternalCodecs   := False;
    StartupInput.GdiplusVersion := 1;

    GdiplusStartup(gdiplusToken, @StartupInput, @StartupOutput);
    GDIStarted := true;
  end;
end;

procedure ShutdownGDI;
begin
  if (GDIStarted) then begin
    GdiplusShutdown(gdiplusToken);
    GDIStarted := false;
  end;
end;

initialization
begin
  GDIStarted := false;
end;

finalization
begin
end;

end.

