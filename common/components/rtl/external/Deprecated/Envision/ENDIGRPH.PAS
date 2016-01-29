{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnDiGrph
|
| Description: Abstract TGraphic descendant which supports a device indenpendent
|              drawing surface.
|
| History: Oct 29, 1998. Michel Brazeau, first version
|          Feb 13, 1999. MB Add AssignFromDIBHandle
|          Sep 06, 1999. MB fix SaveToClipboardFormat to work under NT
|
|---------------------------------------------------------------------------}
unit EnDiGrph;

{$I Envision.Inc}

interface

uses
    Windows,  { for TRect, PMaxLogPalette }
    SysUtils, { for Exception, PByteArray }
    ExtCtrls, { for TTimer }
    Classes,  { for TStream }
    Controls, { for TControl }
    Graphics, { for TGraphic, TCanvas }
    EnMisc;   { for PMaxLogPalette }

type

TBitmapInfo = packed record
     BmpHeader : TBitmapInfoHeader;
     Palette   : array[Byte] of TRgbQuad;
end;

TRgb = packed record
    Red    : Byte;
    Green  : Byte;
    Blue   : Byte;
    Filler : Byte;
end;

TSetPixelProc = procedure( const ScanLine : PByteArray;
                           const X        : LongInt;
                           const Value    : LongInt );

TGetPixelFunc = function( const ScanLine : PByteArray;
                          const X        : LongInt ) : LongInt;

type

TIndexCacheEntry = packed record
    Color : TRgb;
    Index : SmallInt;
end;

TRgbToPaletteConverter = class(TObject)
protected
    pPalette  : PMaxLogPalette;

    { lower bound of Cache must always be 0.}
    Cache    : array[0..1019] of TIndexCacheEntry;

    Hits     : LongInt;
    Misses   : LongInt;

public
    constructor Create(var Palette : TMaxLogPalette);
    function GetIndex(const Color : TRgb) : Word;
end;

TDibGraphic = class(TGraphic)
protected
    FBitmapHandle       : HBITMAP;
    FDC                 : HDC;
    FBits               : PByteArray;
    FPaletteHandle      : HPALETTE;
    FImageFormat        : TImageFormat;
    FBitmapInfo         : TBitmapInfo;

    FPalette            : TMaxLogPalette;

    { size in bytes of a scan line, longword alligned }
    FScanLineSize       : LongInt;

    FCanvas             : TCanvas;

    FImageToLoad        : LongInt;

    { when MultiLoad is True, LoadFromStream will load all the frames (images)
      when the file format supports multiple images }
    FMultiLoad         : Boolean;

    { list of frames when supporting multiple image file formats. See
      MultiLoad property. This object is only created when MultiLoad is
      set True  }
    FFrames             : TList;

    { Delay in milli seconds, which indicates the display duration when the
      Animated property is True }
    FImageDelay         : LongInt;

    FAnimated           : Boolean;

    FAnimationTimer     : TTimer;

    { current frame being displayed. 1..FrameCount }
    FCurrentFrame       : LongInt;

    FGetPixelFunc       : TGetPixelFunc;
    FSetPixelProc       : TSetPixelProc;

    FRgbToPaletteConverter : TRgbToPaletteConverter;

    FOldBitmapHandle    : HBitmap;

    procedure AnimateTimer( Sender : TObject );

    procedure SetMultiLoad( const Multi : Boolean );
    procedure SetAnimated( const InAnimated : Boolean );

    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;

    procedure SetWidth(Value: Integer); override;
    procedure SetHeight(Value: Integer); override;

    function GetXDotsPerInch : Word;
    function GetYDotsPerInch : Word;

    procedure SetXDotsPerInch( const XDpi : Word );
    procedure SetYDotsPerInch( const YDpi : Word );

    function GetScanLine( const Y : LongInt ) : PByteArray; register;

    function GetRGB( const X,Y : LongInt ) : TRgb; register;
    procedure SetRGB( const X,Y : LongInt;
                      const RGB : TRgb ); register;

    function GetPaletteIndex( const X,Y : LongInt ) : Byte; register;
    procedure SetPaletteIndex( const X,Y   : LongInt;
                                     Index : Byte ); register;

    function GetPaletteHandle : HPalette;

    function GetPalettePtr : PMaxLogPalette;

    function GetFrame(FrameNo : LongInt) : TDibGraphic;
    function GetFrameCount : LongInt;
    procedure SetCurrentFrame( FrameNo : LongInt );

  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest : TPersistent); override;
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;

    procedure AssignFromBitmapHandle( const InBitmapHandle : HBITMAP );

    procedure AssignFromDIBHandle( const InDibHandle : THandle );

    function GetImageCount( const Stream : TStream ) : LongInt; virtual;

    function IsEmpty : Boolean;

    { if MultiLoad is False, ImageToLoad may be set before calling
      LoadFromStream to specify which image to load. Default is 1.
      It is the user's responsible to ensure ImageToLoad contains a
      valid value, by first invoking GetImageCount. }
    property ImageToLoad : LongInt read FImageToLoad
                                   write FImageToLoad;

    procedure LoadFromStream(Stream: TStream); override;
    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                 ); virtual;

    procedure SaveToStream(Stream: TStream); override;
    procedure AppendToStream(Stream : TStream); virtual;

    procedure LoadFromClipboardFormat(AFormat: WorD; AData: THandle;
      APalette: HPalette); override;
    procedure SaveToClipboardFormat(var AFormat: WorD; var AData: THandle;
      var APalette: HPalette); override;

    procedure NewImage( const Width          : LongInt;
                        const Height         : LongInt;
                        const ImageFormat    : TImageFormat;
                              pPalette       : PMaxLogPalette;
                        const InXDotsPerInch : Word;
                        const InYDotsPerInch : Word ); virtual;

    procedure Clear;

    property ImageFormat : TImageFormat read FImageFormat;

    property Bits : PByteArray read FBits;

    { 0 <= Y < Height. No validation for performance }
    property ScanLine[ const Y : LongInt ] : PByteArray
        read GetScanLine;

    property ScanLineSize : LongInt
        read FScanLineSize;

    property RGB[ const X,Y : LongInt ] : TRgb
        read GetRGB
        write SetRGB;

    property PaletteIndex[ const X,Y : LongInt ] : Byte
        read GetPaletteIndex
        write SetPaletteIndex;

    property Palette : TMaxLogPalette read FPalette;

    property PalettePtr : PMaxLogPalette read GetPalettePtr;

    property PaletteHandle : HPalette
        read GetPaletteHandle;

    property BitmapHandle : HBitmap
        read FBitmapHandle;

    property XDotsPerInch : Word read GetXDotsPerInch
                                 write SetXDotsPerInch;

    property YDotsPerInch : Word read GetYDotsPerInch
                                 write SetYDotsPerInch;

    property Canvas : TCanvas read FCanvas;

    property DC : HDC read FDC;

    property BitmapInfo : TBitmapInfo read FBitmapInfo;

    property MultiLoad : Boolean read FMultiLoad
                                  write SetMultiLoad;

    property ImageDelay : LongInt read FImageDelay
                                  write FImageDelay;

    property Animated : Boolean read FAnimated
                                write SetAnimated;

    property Frames[FrameNo: LongInt] : TDibGraphic read GetFrame;
    property FrameCount : LongInt read GetFrameCount;

    { current frame being displayed. Must only be set when MultiLoad is
      True. 1..FrameCount }
    property CurrentFrame : LongInt read FCurrentFrame
                                    write SetCurrentFrame;

end;

TDibGraphicClass = class of TDibGraphic;

{--------------------------------------------------------------------------}

function MakeRgb( Red : Byte; Green : Byte; Blue : Byte ) : TRgb;

{--------------------------------------------------------------------------}

function GetBitDepth( const ImageFormat : TImageFormat ) : Word;

{--------------------------------------------------------------------------}

procedure SetBWPalette( var Palette : TMaxLogPalette );
procedure SetGray16Palette( var Palette : TMaxLogPalette );
procedure SetGray256Palette( var Palette : TMaxLogPalette );
procedure SetColor16Palette( var Palette : TMaxLogPalette );
procedure SetColor256Palette( var Palette : TMaxLogPalette );

{--------------------------------------------------------------------------}

procedure SetPixelBc1( const ScanLine : PByteArray;
                       const X        : LongInt;
                       const Value    : LongInt ); register;

function GetPixelBc1( const ScanLine : PByteArray;
                      const X        : LongInt ) : LongInt; register;

{--------------------------------------------------------------------------}

procedure SetPixelBc4( const ScanLine : PByteArray;
                       const X        : LongInt;
                       const Value    : LongInt ); register;

function GetPixelBc4( const ScanLine : PByteArray;
                      const X        : LongInt ) : LongInt; register;

{--------------------------------------------------------------------------}

procedure SetPixelBc8( const ScanLine : PByteArray;
                       const X        : LongInt;
                       const Value    : LongInt ); register;

function GetPixelBc8( const ScanLine : PByteArray;
                      const X        : LongInt ) : LongInt; register;

{--------------------------------------------------------------------------}

procedure SetPixelBc24( const ScanLine : PByteArray;
                        const X        : LongInt;
                        const Value    : LongInt ); register;

function GetPixelBc24( const ScanLine : PByteArray;
                       const X        : LongInt ) : LongInt; register;

{--------------------------------------------------------------------------}

{ swap the Red and Blue channels on a 24 bit scan line. }
procedure SwapRBOnScanLine( const pScanLine    : PByteArray;
                            const ScanLineSize : LongInt);

{--------------------------------------------------------------------------}

function ImageFormatStr( const ImageFormat : TImageFormat ) : String;

{--------------------------------------------------------------------------}

{ Register a TDibGraphic for integration with Delphi's TImage component.
  This routine should be used instread of TPicture.RegisterFileFormat,
  in order to use the FindDibGraphicClass function. Extension must NOT
  include the leading '.'


  MB Oct 25, 1999. Very nasty bug in CBuilder, where when passing a
  metaclass as a parameter, the linker was unable to link the function. By
  making a pointer a generic pointer, and typecasting inside the function,
  the link is successful.

  MB Nov 07, 1999. Since the DCU's of the evaluation version are compiled
  with Delphi, the evaluation version of CBuilder was not able to link
  this function. So to workaround this bug, the DibGraphicClass is
  passed as Pointer with all compilers.
}
procedure RegisterDibGraphic( const Extension       : String;
                              const Description     : String;
                              const DibGraphicClass : Pointer
                              );

{--------------------------------------------------------------------------}

{ Returns a TDibGraphicClass which is capable of reading FileName. FileName
  may be a complete file name or an extension. Returns nil, if there is not
  any TDibGraphicClass registered to open FileName. }
function FindDibGraphicClass( const FileName : String ) : TDibGraphicClass;

{--------------------------------------------------------------------------}

{ Returns a TDibGraphic instance capable of reading FileName. FileName
  may be a complete file name or an extension. Returns nil, if there is not
  an TDibGraphicClass registered to open FileName. }
function NewDibGraphic( const FileName : String ) : TDibGraphic;

{--------------------------------------------------------------------------}

const

CSetPixelArray : array[TImageFormat] of TSetPixelProc = (
                    SetPixelBc1,
                    SetPixelBc4,
                    SetPixelBc8,
                    SetPixelBc4,
                    SetPixelBc8,
                    SetPixelBc24 );

CGetPixelArray : array[TImageFormat] of TGetPixelFunc = (
                    GetPixelBc1,
                    GetPixelBc4,
                    GetPixelBc8,
                    GetPixelBc4,
                    GetPixelBc8,
                    GetPixelBc24 );

CWhiteRgb : TRgb = (Red:255; Green:255; Blue:255; Filler:0);
CBlackRgb : TRgb = (Red:0; Green:0; Blue:0; Filler:0);

var

{ default Palettes }
pBlackWhitePalette : PMaxLogPalette;
pGray16Palette     : PMaxLogPalette;
pGray256Palette    : PMaxLogPalette;
pColor16Palette    : PMaxLogPalette;
pColor256Palette   : PMaxLogPalette;

{ ScreenGamma default = 2.2. This value should be a good guess on the
  PC platform. }
ScreenGamma        : Double;

{--------------------------------------------------------------------------}

implementation

uses
    {$ifdef __Evaluation}
    Dialogs,  { for MessageDlg }
    {$endif}
    Forms,    { for Application }
    ClipBrd,  { for ClipBoard }
    EnIcoGr,  { for TIconGraphic }
    EnMsg;    { for EEnvisionError }

var

DibClasses    : TStringList;

{--------------------------------------------------------------------------}

function MakeRgb( Red : Byte; Green : Byte; Blue : Byte ) : TRgb;
begin
    Result.Red    := Red;
    Result.Green  := Green;
    Result.Blue   := Blue;
    Result.Filler := 0;
end;

{--------------------------------------------------------------------------}

function GetBitDepth( const ImageFormat : TImageFormat ) : Word;
begin
    case ImageFormat of
        ifBlackWhite : Result := 1;
        ifGray16     : Result := 4;
        ifGray256    : Result := 8;
        ifColor16    : Result := 4;
        ifColor256   : Result := 8;
        ifTrueColor  : Result := 24;
        else
            raise EEnvisionError.Create(msgInvalidImageFormat);
    end;
end; { GetBitCount }

{--------------------------------------------------------------------------}

function ImageFormatStr( const ImageFormat : TImageFormat ) : String;
begin
    Result := '';

    case ImageFormat of
        ifBlackWhite : Result := 'Black and white';
        ifGray16     : Result := '16 shades of gray';
        ifGray256    : Result := '256 shades of gray';
        ifColor16    : Result := '16 color';
        ifColor256   : Result := '256 color';
        ifTrueColor  : Result := 'True color';
    end;

end;

{--------------------------------------------------------------------------}

procedure RegisterDibGraphic( const Extension       : String;
                              const Description     : String;
                              const DibGraphicClass : Pointer
                              );
begin
    TPicture.RegisterFileFormat(Extension, Description, TDibGraphicClass(DibGraphicClass));

    { MB Aug 13, 1999. This routine may be called before this unit
     is initialized, so create the object if it is nil. The unit
     initialization will not recreate it. }
    if DibClasses = nil then
        DibClasses := TStringList.Create;

    DibClasses.AddObject(AnsiUpperCase(Extension), TObject(DibGraphicClass));
end;

{--------------------------------------------------------------------------}

function FindDibGraphicClass( const FileName : String ) : TDibGraphicClass;
var
    Index : Integer;
    Ext   : String;
begin
    Result := nil;

    Ext    := AnsiUpperCase(ExtractFileExt(FileName));

    if (Ext = '') then
    begin
        { assume FileName is an extension }
        Ext := '.' + FileName;
    end;

    Delete(Ext, 1, 1);

    Index := DibClasses.IndexOf(Ext);

    if Index >= 0 then
        Result := TDibGraphicClass(DibClasses.Objects[Index]);
end;

{--------------------------------------------------------------------------}

function NewDibGraphic(const FileName : String) : TDibGraphic;
var
    DibGraphicClass : TDibGraphicClass;
begin
    DibGraphicClass := FindDibGraphicClass(FileName);

    if DibGraphicClass = nil then
        raise EEnvisionError.Create(
                          Format( msgFileFormatNotSupported,
                                 [ExtractFileExt(FileName)]));

    Result := DibGraphicClass.Create;
end;

{--------------------------------------------------------------------------}

function ComputeScanLineSize( const Width    : LongInt;
                              const BitCount : Word ) : LongInt;
begin
    Result := (((Width * BitCount) + 31) and not 31) div 8;
end;


{--------------------------------------------------------------------------}

procedure GetBitmapHeader( const Bitmap : HBITMAP;
                           var   Header : TBitmapInfoHeader );
var
    DibSection   : TDIBSection;
    Bytes        : Integer;
begin
    DibSection.dsbmih.biSize := 0;
    Bytes := GetObject(Bitmap, SizeOf(DibSection), @DibSection);
    if Bytes = 0 then
        EInvalidGraphic.Create(msgInvalidBitmap)
    else if (Bytes >= (sizeof(DibSection.dsbm) + sizeof(DibSection.dsbmih))) and
            (DibSection.dsbmih.biSize >= (sizeof(DibSection.dsbmih))) then
        Header := DibSection.dsbmih
    else
    begin
        FillChar(Header, sizeof(Header), 0);
        Header.biSize   := SizeOf(Header);
        Header.biWidth  := DibSection.dsbm.bmWidth;
        Header.biHeight := DibSection.dsbm.bmHeight;
    end;
    Header.biBitCount := DibSection.dsbm.bmBitsPixel * DibSection.dsbm.bmPlanes;

    if Header.biBitCount in [16, 32] then
    begin
        Header.biBitCount  := 24; { only 24 True color bitmaps supported }

        { MB Apr 26, 1999. GetDiBits was failing because the image size was
          not properly set. }
        Header.biSizeImage := 0;  { force recalculating size with new bit count }
    end;

    Header.biPlanes := 1;
    if Header.biSizeImage = 0 then
        Header.biSizeImage := ComputeScanLineSize(Header.biWidth, Header.biBitCount) * Abs(Header.biHeight);
end;

{--------------------------------------------------------------------------}

procedure GetDIBSizes( const BitmapHandle   : HBITMAP;
                       var   InfoHeaderSize : DWORD;
                       var   ImageSize      : DWORD );
var
  Header : TBitmapInfoHeader;
begin
    GetBitmapHeader(BitmapHandle, Header);
    if Header.biBitCount > 8 then
    begin
        InfoHeaderSize := SizeOf(TBitmapInfoHeader);
        if (Header.biCompression and BI_BITFIELDS) <> 0 then
            Inc(InfoHeaderSize, 12);
    end
    else
        InfoHeaderSize := SizeOf(TBitmapInfoHeader) + SizeOf(TRGBQuad) *
                          (1 shl Header.biBitCount);

    ImageSize := Header.biSizeImage;
end;

{--------------------------------------------------------------------------}

function GetDIB( const BitmapHandle : HBITMAP;
                 var   BitmapInfo   : Windows.TBitmapInfo;
                 const Bits         : PByteArray ): Boolean;
var
  DC          : HDC;
  SavedHeader : TBitmapInfoHeader;
begin
    GetBitmapHeader(BitmapHandle, BitmapInfo.bmiHeader);
    DC := CreateCompatibleDC(0);
    try
        { Oct 05, 1999. MB. GetDIBits seems to overwrite the biClrUsed field,
          so a temporary copy is saved. }
        SavedHeader := BitmapInfo.bmiHeader;

        Result := GetDIBits( DC, BitmapHandle, 0,
                             BitmapInfo.bmiHeader.biHeight,
                             Bits, BitmapInfo,
                             DIB_RGB_COLORS) <> 0;

        BitmapInfo.bmiHeader := SavedHeader;
    finally
        DeleteDC(DC);
    end;
end;

{--------------------------------------------------------------------------}

constructor TDibGraphic.Create;
begin
    inherited Create;

    FBitmapHandle           := 0;
    FPaletteHandle          := 0;
    FDC                     := 0;
    FOldBitmapHandle        := 0;
    FBits                   := nil;
    FRgbToPaletteConverter  := nil;
    FillChar(FPalette, SizeOf(FPalette), 0);
    FFrames                 := TList.Create;
    FAnimationTimer         := TTimer.Create(nil);
    FAnimationTimer.OnTimer := AnimateTimer;
    FAnimationTimer.Enabled := False;
    FMultiLoad              := False;
    FImageDelay             := 200;
    FAnimated               := False;
    FCurrentFrame       := -1;
    FImageToLoad            := 1;
end;

{--------------------------------------------------------------------------}

destructor TDibGraphic.Destroy;
var
    ImageNo    : LongInt;
begin

    FAnimationTimer.Enabled := False;
    FAnimationTimer.Free;

    for ImageNo := 0 to (FFrames.Count-1) do
    begin
        TDibGraphic(FFrames.Items[ImageNo]).Free;
    end;

    FFrames.Free;

    Clear;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.NewImage( const Width          : LongInt;
                                const Height         : LongInt;
                                const ImageFormat    : TImageFormat;
                                      pPalette       : PMaxLogPalette;
                                const InXDotsPerInch : Word;
                                const InYDotsPerInch : Word );

begin
    Clear;

    FDC := CreateCompatibleDC(0);
    try
        FImageFormat := ImageFormat;

        if (ImageFormat <> ifTrueColor) and
           (pPalette = nil) then
        begin
            case ImageFormat of
                 ifBlackWhite : pPalette := pBlackWhitePalette;
                 ifGray16     : pPalette := pGray16Palette;
                 ifGray256    : pPalette := pGray256Palette;
                 ifColor16    : pPalette := pColor16Palette;
                 ifColor256   : pPalette := pColor256Palette;
                 else
                     raise EEnvisionError.Create(msgInvalidImageFormat);
            end;
        end;

        with FBitmapInfo.BmpHeader do
        begin
            biSize            := SizeOf(FBitmapInfo.BmpHeader);
            biWidth           := Width;
            biHeight          := Height;
            biPlanes          := 1;
            biBitCount        := GetBitDepth(ImageFormat);
            biCompression     := Windows.BI_RGB;

            FScanLineSize     := ComputeScanLineSize(
                                    biWidth,
                                    biBitCount );

            biSizeImage       := biHeight * FScanLineSize;

            biClrImportant    := 0;

            if ImageFormat = ifTrueColor then
                biClrUsed  := 0
            else
            begin
                biClrUsed  := pPalette^.palNumEntries;
                Move( pPalette^.palPalEntry, FBitmapInfo.Palette,
                      biClrUsed*SizeOf(TRgbQuad));

                FRgbToPaletteConverter := TRgbToPaletteConverter.Create(
                                                                  pPalette^ );

                { ensure palette version is always set }
                pPalette^.palVersion := $0300;
            end;
        end;

        if InXDotsPerInch > 0 then
            XDotsPerInch := InXDotsPerInch
        else
            XDotsPerInch := GetDeviceCaps(FDC, LOGPIXELSX);

        if InYDotsPerInch > 0 then
            YDotsPerInch := InYDotsPerInch
        else
            YDotsPerInch := GetDeviceCaps(FDC, LOGPIXELSY);

        FBitmapHandle := CreateDibSection( FDC, Windows.PBitmapInfo(@FBitmapInfo)^,
                                           DIB_RGB_COLORS, Pointer(FBits),
                                           0, 0);
        if FBitmapHandle = 0 then
            raise EEnvisionError.Create('CreateDibSection failed');

        FGetPixelFunc := CGetPixelArray[ImageFormat];
        FSetPixelProc := CSetPixelArray[ImageFormat];

        FOldBitmapHandle := SelectObject(FDC, FBitmapHandle);

        FillChar(FPalette, SizeOf(FPalette), 0);
        if ImageFormat <> ifTrueColor then
        begin
            Move( pPalette^, FPalette,
                  4 + (pPalette^.palNumEntries*SizeOf(Windows.TPaletteEntry)));
            FPalette.palVersion := $0300;
        end;

        FCanvas := TCanvas.Create;
        FCanvas.Handle := FDC;

    except
        Clear;
        raise;
    end;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.Clear;
begin
    if FCanvas <> nil then
    begin
        FCanvas.Free;
        FCanvas := nil;
    end;

    { it is very important to restore the old bitmap handle into the
      device contexts. Omitting this operation creates a heavy resource
      leak. }
    if (FOldBitmapHandle <> 0) and
       (FDC <> 0) then
    begin
        SelectObject(FDC, FOldBitmapHandle);
        FOldBitmapHandle := 0;
    end;

    if FRgbToPaletteConverter <> nil then
    begin
        FRgbToPaletteConverter.Free;
        FRgbToPaletteConverter := nil;
    end;

    if FPaletteHandle <> 0 then
    begin
        DeleteObject(FPaletteHandle);
        FPaletteHandle := 0;
    end;

    if FBitmapHandle <> 0 then
    begin
        DeleteObject(FBitmapHandle);
        FBitmapHandle := 0;
    end;

    if FDC <> 0 then
    begin
        DeleteDC(FDC);
        FDC := 0;
    end;

    FBits := nil;
    FillChar(FBitmapInfo, SizeOf(FBitmapInfo), 0);
end;

{--------------------------------------------------------------------------}

function TDibGraphic.IsEmpty : Boolean;
begin
    Result := (FBitmapHandle = 0);
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.Draw(ACanvas: TCanvas; const Rect: TRect);
var
    CanvasPalette : HPalette;
    OldPalette    : HPalette;
    StretchMode   : Integer;

begin
    { using HALFTONE stretch mode, the stretch quality is better.
      The API help on SetStretchBltMode specifies that SetBrushOrgEx
      must be called afterwords.

      MB Jun 05, 1999. "Terwiske, John J." <JTerwiske@Kronos.com>, reported
      that with true color images, COLORONCOLOR procduces better results. On
      my video driver, I did not see any difference though. Windows API help
      does mention that HALFTONE should produce better results. }
    if FImageFormat = ifTrueColor then
        StretchMode := Windows.COLORONCOLOR
    else
        StretchMode := Windows.HALFTONE;

    SetStretchBltMode( ACanvas.Handle, StretchMode );

    if StretchMode = Windows.HALFTONE then
        SetBrushOrgEx( ACanvas.Handle, 0, 0, nil );

    OldPalette := 0;

    if (GetDeviceCaps(ACanvas.Handle, Windows.RASTERCAPS) and Windows.RC_PALETTE) <> 0 then
    begin
        { screen is uses a palette }

        { MB Apr 3, 1999. The display quality is better with CreateHalftonePalette,
          but I still have not figured out how have the displayed image dithered
          as in Navigator
          CanvasPalette := CreatePalette(PLogPalette(pColor256Palette)^);
        }
        CanvasPalette := CreateHalftonePalette(ACanvas.Handle);

        try
            OldPalette := SelectPalette(ACanvas.Handle, CanvasPalette, False);
            RealizePalette(ACanvas.Handle);
        finally
            DeleteObject(CanvasPalette);
        end;
    end;

    StretchDiBits( ACanvas.Handle, Rect.Left, Rect.Top,
                   Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                   0, 0,
                   FBitmapInfo.BmpHeader.biWidth, FBitmapInfo.BmpHeader.biHeight,
                   Pointer(FBits), Windows.PBitmapInfo(@FBitmapInfo)^,
                   DIB_RGB_COLORS, SRCCOPY);

    {$ifdef __Evaluation}
    ACanvas.Font.Size   := 10;
    ACanvas.Font.Name   := 'Arial';
    ACanvas.Font.Style  := [fsBold];
    ACanvas.Font.Color  := clLime;
    SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);

    ACanvas.TextOut(4, 2, 'Envision Image Library Demo');

    ACanvas.Font.Color := clGray;
    ACanvas.Font.Size  := 9;
    ACanvas.TextOut(4, 20, 'www.intervalsoftware.com');

    SetBkMode(ACanvas.Handle, Windows.OPAQUE);
    {$endif}


    if OldPalette <> 0 then
        SelectPalette(ACanvas.Handle, OldPalette, False);
end;

{--------------------------------------------------------------------------}

type
    TProtectedGraphic = class(TGraphic);

procedure TDibGraphic.Assign(Source: TPersistent);
var
    SourceDib     : TDibGraphic;
    BitmapHandle  : HBITMAP;
    PaletteHandle : HPALETTE;
    Rect          : TRect;
begin
    if (Source = nil) or (Source is TDibGraphic) then
    begin
        Self.Clear;
        if (Source = nil) then
            SourceDib := nil
        else
            SourceDib := TDibGraphic(Source);

        if (SourceDib <> nil) and (SourceDib.Width > 0) and (SourceDib.Height > 0) then
        begin
            Self.NewImage( SourceDib.Width,
                           SourceDib.Height,
                           SourceDib.ImageFormat,
                           @SourceDib.FPalette,
                           SourceDib.XDotsPerInch,
                           SourceDib.YDotsPerInch );

            Self.XDotsPerInch   := SourceDib.XDotsPerInch;
            Self.YDotsPerInch   := SourceDib.YDotsPerInch;

            Self.ImageDelay     := SourceDib.ImageDelay;

            Move( SourceDib.FBits^, Self.FBits^,
                  SourceDib.ScanLineSize * SourceDib.Height);
        end;
    end
    else if Source is TClipBoard then
    begin
        Clipboard.Open;
        try
            BitmapHandle  := GetClipboardData(CF_BITMAP);
            PaletteHandle := GetClipboardData(CF_PALETTE);
            Self.LoadFromClipboardFormat(CF_BITMAP, BitmapHandle, PaletteHandle);
        finally
            Clipboard.Close;
        end;
    end
    else if Source is TBitmap then
    begin
        { AssignFromBitmapHandle reads the X and Y resolutions }

        { MB Oct 28, 1999. The AssignFromBitmapHandle works with a device
          dependent bitmap. This is required to load 16 bit bitmaps, in order
          to convert them to 24 bits using the GetDIB function. }
        TBitmap(Source).HandleType := bmDDB;

        Self.AssignFromBitmapHandle(TBitmap(Source).Handle);
    end
    else if Source is TGraphic then
    begin
        { any TGraphic (other than TBitmap) use the Draw method. The resolution
          is not available }
        Rect.Left   := 0;
        Rect.Top    := 0;
        Rect.Right  := TGraphic(Source).Width;
        Rect.Bottom := TGraphic(Source).Height;

        NewImage( Rect.Right, Rect.Bottom, ifTrueColor, nil, 0, 0 );
        FillChar(Self.Bits^, Self.Height*ScanLineSize, 0);
        TProtectedGraphic(Source).Draw(Self.Canvas, Rect);
    end
    else
        inherited Assign(Source);
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.AssignTo(Dest : TPersistent);
var
    Rect        : TRect;
    IconGraphic : TIconGraphic;
    Stream      : TMemoryStream;
begin
    if Dest is TDibGraphic then
        Dest.Assign(Self)
    else
    begin
        if Dest is TBitmap then
        begin
            { MB Aug 11, 1999. This code seemed to work, but a subsequent
              Bitmap.SaveToFile would raise an out of resources exception.
              Using the Draw method seems to be more stable
            TBitmap(Dest).Palette := Self.PaletteHandle;
            TBitmap(Dest).Handle  := Self.BitmapHandle;
            }
            Rect.Left   := 0;
            Rect.Top    := 0;
            Rect.Right  := Self.Width;
            Rect.Bottom := Self.Height;

            TBitmap(Dest).PixelFormat := pf24bit;
            TBitmap(Dest).Width       := Self.Width;
            TBitmap(Dest).Height      := Self.Height;

            Self.Draw( TBitmap(Dest).Canvas, Rect );
        end
        else if Dest is TIcon then
        begin
            { assigning to a TIcon is important to allow specify the
              Application's Icon at design in the project options }
            Stream := TMemoryStream.Create;
            try
                if (Self is TIconGraphic) then
                    Self.SaveToStream(Stream)
                else
                begin
                    IconGraphic := TIconGraphic.Create;
                    try
                        IconGraphic.Assign(Self);
                        IconGraphic.SaveToStream(Stream);
                    finally
                        IconGraphic.Free;
                    end;
                end;

                Stream.Seek(0, soFromBeginning);

                TIcon(Dest).LoadFromStream(Stream);
            finally
                Stream.Free;
            end;
        end
        else
            raise EEnvisionError.Create(
                          Format( msgCannotAssign,
                                 ['TDibGraphic', Dest.ClassName]));

    end;
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetEmpty: Boolean;
begin
    Result := (FBitmapHandle = 0);
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetHeight: Integer;
begin
    Result := FBitmapInfo.BmpHeader.biHeight;
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetWidth: Integer;
begin
    Result := FBitmapInfo.BmpHeader.biWidth;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetWidth(Value: Integer);
begin
   raise EEnvisionError.Create(msgUseNewImageToChangeSize);
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetHeight(Value: Integer);
begin
   raise EEnvisionError.Create(msgUseNewImageToChangeSize);
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetImageCount( const Stream : TStream ) : LongInt;
begin
    Result := 1;
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetPaletteHandle : HPalette;
begin
    if ImageFormat <> ifTrueColor then
    begin
        if FPaletteHandle = 0 then
        begin
            FPaletteHandle := CreatePalette(PLogPalette(@FPalette)^);
            Result := FPaletteHandle;
        end
        else
            Result := FPaletteHandle;
    end
    else
        Result := 0;
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetPalettePtr : PMaxLogPalette;
begin
    Result := @FPalette;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.LoadFromStream(Stream: TStream);
var
    ImageNo         : LongInt;
    ImageCount      : LongInt;
    DibGraphic      : TDibGraphic;
    DibGraphicClass : TDibGraphicClass;
    WasAnimated     : Boolean;
    SavedPos        : LongInt;

begin
    WasAnimated := Animated;
    Animated := False;
    try

        { MB Mar 08, 1999. Do NOT seek to the beginning of the stream,
          as this prevents the image from being loaded at design time
          in a TImage component. }

        SavedPos := 0; { prevent compiler warning }

        if MultiLoad then
        begin
            { MB Aug 8, 1999. Ensure the stream positioned is not changed
              after calling GetImageCount, previously with TIFF images, the
              TTiffGraphic.SingleLoadFrom stream still behaved properly
              but a temporary memory stream was created without reason.
              With the new TDcxGraphic, this problem was found }
            SavedPos := Stream.Position;
            ImageCount  := GetImageCount(Stream);

            if ImageCount = 1 then
                MultiLoad := False;
        end
        else
            ImageCount := 1; { prevent compiler warning }

        if MultiLoad then
        begin
            for ImageNo := 1 to ImageCount do
            begin
                { use ClassType to create the proper type of TDibGraphic }
                DibGraphicClass := TDibGraphicClass(Self.ClassType);
                DibGraphic := DibGraphicClass.Create;

                { restore the original stream position }
                Stream.Seek(SavedPos, soFromBeginning);

                DibGraphic.SingleLoadFromStream(Stream, ImageNo);

                FFrames.Add(DibGraphic);
            end;

            CurrentFrame  := 1;
        end
        else
        begin
            Self.SingleLoadFromStream(Stream, FImageToLoad);
        end;

    finally
        Animated := WasAnimated;
    end;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SingleLoadFromStream(
                                   const Stream      : TStream;
                                   const ImageToLoad : LongInt
                                 );
begin
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SaveToStream(Stream: TStream);
begin
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.AppendToStream(Stream : TStream);
begin
    raise EEnvisionError.Create(
                          Format( msgSingleImageFileFormat,
                                 [Self.ClassName]));
end;

{--------------------------------------------------------------------------}

function GetImageFormat( const BitCount : Word ) : TImageFormat;
begin
    case BitCount of
        1 : Result := ifBlackWhite;
        4 : Result := ifColor16;
        8 : Result := ifColor256;
        24: Result := ifTrueColor;
        else
            raise EEnvisionError.Create('Unsupported bit count');
    end;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.AssignFromBitmapHandle( const InBitmapHandle : HBITMAP );
var
    BitmapHeaderPtr : PBitmapInfo;
    BitmapBits      : PByteArray;
    HeaderSize      : DWORD;
    ImageSize       : DWORD;
    Palette         : TMaxLogPalette;
    PalettePtr      : PMaxLogPalette;
    XDpi            : Integer;
    YDpi            : Integer;

begin
    GetDIBSizes(InBitmapHandle, HeaderSize, ImageSize);
    GetMem(BitmapHeaderPtr, HeaderSize);
    GetMem(BitmapBits, ImageSize);
    try
        if not GetDIB(InBitmapHandle, BitmapHeaderPtr^, BitmapBits) then
            raise EEnvisionError.Create('GetDIB failed');

        with BitmapHeaderPtr^.bmiHeader do
        begin
            if biCompression <> Windows.BI_RGB then
                raise EEnvisionError.Create('Unsupported compression');

            PalettePtr := nil;
            if (biClrUsed > 0) and (biClrUsed <= 256) then
            begin
                Palette.palNumEntries := biClrUsed;
                Palette.palVersion    := $0300;

                Move( BitmapHeaderPtr^.bmiColors, Palette.palPalEntry,
                      biClrUsed*SizeOf(TRgbQuad));

                PalettePtr := @Palette;
            end;

            XDpi := 0;
            YDpi := 0;

            if biXPelsPerMeter > 0 then
                XDpi := Round(biXPelsPerMeter / CInchesPerMeter);
            if biYPelsPerMeter > 0 then
                YDpi := Round(biYPelsPerMeter / CInchesPerMeter);

            if (XDpi > $FFFF) or (XDpi < 0) then
                XDpi := 0;

            if (YDpi > $FFFF) or (YDpi < 0) then
                YDpi := 0;

            Self.NewImage( biWidth, biHeight, GetImageFormat(biBitCount),
                           PalettePtr, XDpi, YDpi );

            Move(BitmapBits^, Self.FBits^, ImageSize);

        end;

    finally
        FreeMem(BitmapHeaderPtr, HeaderSize);
        FreeMem(BitmapBits, ImageSize);
    end;
end;

{--------------------------------------------------------------------------}

procedure DibToBmpStream( const HDIB   : THandle;
                          const Stream : TStream );
var
    BmpHeader      : TBitmapFileHeader;
    pBmpInfoHeader : ^TBitmapInfoHeader;
    BitsPerPixel   : Word;
    ColorCount     : LongInt;
    ScanLineSize   : LongInt;
    BytesToWrite   : LongInt;

begin
    pBmpInfoHeader := GlobalLock(HDIB);
    try
        BitsPerPixel := pBmpInfoHeader^.biBitCount;
        ColorCount   := pBmpInfoHeader^.biClrUsed;

	if (ColorCount = 0) and (BitsPerPixel <= 8) then
            ColorCount := (1 shl BitsPerPixel);

	if pBmpInfoHeader^.biCompression = BI_RGB then
        begin
	    ScanLineSize := ((pBmpInfoHeader^.biWidth * BitsPerPixel) + 31) and (not 31);
            ScanLineSize := ScanLineSize div 8;

	    pBmpInfoHeader^.biSizeImage := ScanLineSize * pBmpInfoHeader^.biHeight;
	end
        else if (pBmpInfoHeader^.biSizeImage = 0) then
            raise EEnvisionError.Create('Invalid HDIB');

	FillChar(BmpHeader, SizeOf(BmpHeader), 0);
	BmpHeader.bfType    := $4d42;
	BmpHeader.bfOffBits := SizeOf(TBitmapFileHeader) +
                               SizeOf(TBitmapInfoHeader) +
                               SizeOf(TRgbQuad) * ColorCount;

	BmpHeader.bfSize := BmpHeader.bfOffBits +
                            pBmpInfoHeader^.biSizeImage;

        BytesToWrite := BmpHeader.bfSize - SizeOf(BmpHeader);

        if Stream is TMemoryStream then
            TMemoryStream(Stream).SetSize(SizeOf(BmpHeader) + BytesToWrite);

        Stream.Write(BmpHeader, SizeOf(BmpHeader));

        Stream.Write(pBmpInfoHeader^, BytesToWrite);
    finally
        GlobalUnLock(HDIB);
    end;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.AssignFromDIBHandle( const InDibHandle : THandle );
var
    pBmpInfoHeader : ^TBitmapInfoHeader;
    pBitmapInfo    : Windows.PBitmapInfo;
    BitsPerPixel   : Word;
    ColorCount     : LongInt;
    Palette        : TMaxLogPalette;
    pPalette       : PMaxLogPalette;
    ImageFormat    : TImageFormat;

    Stream         : TMemoryStream;
    Bitmap         : TBitmap;

begin
    pBmpInfoHeader := GlobalLock(InDibHandle);
    try
        pBitmapInfo  := Pointer(pBmpInfoHeader);

        BitsPerPixel := pBmpInfoHeader^.biBitCount;
        ColorCount   := pBmpInfoHeader^.biClrUsed;

	{ determine size of palette, if biClrUsed was not specified. }
	if (ColorCount = 0) and (BitsPerPixel <= 8) then
            ColorCount := (1 shl BitsPerPixel);

        if BitsPerPixel > 8 then
            ColorCount := 0;

        if BitsPerPixel <= 8 then
        begin
            FillChar(Palette, SizeOf(Palette), 0);
            Palette.palVersion    := $0300;
            Palette.palNumEntries := ColorCount;
            Move( pBitmapInfo^.bmiColors[0],
                  Palette.palPalEntry[0],
                  ColorCount*SizeOf(TRgbQuad));

            pPalette := @Palette;
        end
        else
            pPalette := nil;

        if BitsPerPixel in [16,32] then
            ImageFormat := ifTrueColor
        else
            ImageFormat := GetImageFormat(BitsPerPixel);

        Self.NewImage( pBmpInfoHeader^.biWidth, pBmpInfoHeader^.biHeight,
                       ImageFormat, pPalette,
                       Round(pBmpInfoHeader^.biXPelsPerMeter / CInchesPerMeter),
                       Round(pBmpInfoHeader^.biYPelsPerMeter / CInchesPerMeter) );

        if (BitsPerPixel in [1, 4, 8, 24]) and
           (pBmpInfoHeader^.biCompression = BI_RGB) then
        begin
            { most DIB's are 1,4,8 or 24 bits, not compressed. This is
              supported directly by TDibGraphic }
            Move( PByteArray(pBmpInfoHeader)^[SizeOf(TBitmapInfoHeader) + ColorCount*SizeOf(TRgbQuad)],
                  Self.Bits^,
                  Self.ScanLineSize*pBmpInfoHeader^.biHeight);
        end
        else
        begin
            { bit (16,32) count not supported directly by TDibGraphic. Convert
              to a bitmap stream, and let Delphi's TBitmap class do the
              conversion. }
            Stream := TMemoryStream.Create;
            Bitmap := TBitmap.Create;
            try
                DibToBmpStream(InDibHandle, Stream);
                Stream.Seek(0, soFromBeginning);
                Bitmap.LoadFromStream(Stream);

                { free the stream to reduce memory usage }
                Stream.Free;
                Stream := nil;

                AssignFromBitmapHandle(Bitmap.Handle);
            finally
                Bitmap.Free;
                Stream.Free;
            end;
        end;

    finally
        GlobalUnLock(InDibHandle);
    end;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.LoadFromClipboardFormat(
  AFormat: WorD; AData: THandle;
  APalette: HPalette);
begin
    if (AFormat <> CF_BITMAP) or (AData = 0) then
        raise EInvalidGraphic.Create(
            Format(msgUnsupportedClipboardFormat, [AFormat]));

    AssignFromBitmapHandle(AData);
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SaveToClipboardFormat(
                  var AFormat  : Word;
                  var AData    : THandle;
                  var APalette : HPalette);
var
  ScreenDC, NewImageDC : HDC;
  OldBitmapHandle      : HBITMAP;

begin
    AFormat := CF_BITMAP;

    ScreenDC := GetDC(0);
    NewImageDC := CreateCompatibleDC(ScreenDC);
    try
        if Self.ImageFormat = ifBlackWhite then
            AData := CreateBitmap(Self.Width, Self.Height, 1, 1, nil)
        else
            AData := CreateCompatibleBitmap(ScreenDC, Self.Width, Self.Height);

        if AData = 0 then
            raise EEnvisionError.Create('CopyBitmap: CreateBitmap failed');

        OldBitmapHandle := SelectObject(NewImageDC, AData);
        try
            BitBlt( NewImageDC, 0, 0, Self.Width, Self.Height,
                    Self.FDC, 0, 0, SRCCOPY);
        finally
            SelectObject(NewImageDC, OldBitmapHandle);
        end;
    finally
        DeleteDC(NewImageDC);
        ReleaseDC(0, ScreenDC);
    end;
end;

(* MB Sep 06, 1999 Old version not saving to clipboard properly on NT
var
    NewDibGraphic : TDibGraphic;
begin
    NewDibGraphic := TDibGraphic.Create;
    try
        NewDibGraphic.Assign(Self);
        AFormat  := CF_BITMAP;
        APalette := NewDibGraphic.PaletteHandle;
        AData    := NewDibGraphic.BitmapHandle;
    finally
        { set the palete and bitmap handles to 0, because the clipboard
          is responsible to delete them }
        NewDibGraphic.FPaletteHandle := 0;
        NewDibGraphic.FBitmapHandle  := 0;
        NewDibGraphic.Free;
    end;
end;
*)

{--------------------------------------------------------------------------}

function TDibGraphic.GetScanLine( const Y : LongInt ) : PByteArray;
begin
    Result := Pointer( LongInt(FBits) +
                       (FBitmapInfo.BmpHeader.biHeight-Y-1)*FScanLineSize);
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetRGB( const X,Y : LongInt ) : TRgb;
var
    Index : Word;
begin
    if ImageFormat = ifTrueColor then
        Result := TRgb(FGetPixelFunc(ScanLine[Y], X))
    else
    begin
        Index  := PaletteIndex[X, Y];
        { carefull with TRgbQuad inversion }
        TRgb(Result).Blue   := FPalette.palPalEntry[Index].peBlue;
        TRgb(Result).Green  := FPalette.palPalEntry[Index].peGreen;
        TRgb(Result).Red    := FPalette.palPalEntry[Index].peRed;
        TRgb(Result).Filler := 0;
    end;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetRGB( const X,Y : LongInt;
                              const RGB : TRgb );
begin
    if ImageFormat = ifTrueColor then
        FSetPixelProc(ScanLine[Y], X, LongInt(RGB))
    else
        PaletteIndex[X, Y] := FRgbToPaletteConverter.GetIndex(RGB);
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetPaletteIndex( const X,Y : LongInt ) : Byte;
begin
    if ImageFormat = ifTrueColor then
        raise EEnvisionError.Create(msgImageDoesNotHavePalette);

    Result := FGetPixelFunc(ScanLine[Y], X);
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetPaletteIndex( const X,Y : LongInt;
                                             Index : Byte );
begin
    if ImageFormat = ifTrueColor then
        raise EEnvisionError.Create(msgImageDoesNotHavePalette);

    FSetPixelProc(ScanLine[Y], X, Index);
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetXDotsPerInch : Word;
begin
    Result := Round(FBitmapInfo.BmpHeader.biXPelsPerMeter/CInchesPerMeter);
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetYDotsPerInch : Word;
begin
    Result := Round(FBitmapInfo.BmpHeader.biYPelsPerMeter/CInchesPerMeter);
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetXDotsPerInch( const XDpi : Word );
begin
    FBitmapInfo.BmpHeader.biXPelsPerMeter := Round(XDpi*CInchesPerMeter);

end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetYDotsPerInch( const YDpi : Word );
begin
    FBitmapInfo.BmpHeader.biYPelsPerMeter := Round(YDpi*CInchesPerMeter);
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.AnimateTimer( Sender : TObject );
begin
    if FFrames.Count = 0 then
        Exit;
        
    FAnimationTimer.Enabled := False;
    try
        if CurrentFrame = FrameCount then
            CurrentFrame := 1
        else
            CurrentFrame := CurrentFrame + 1;
    finally
        FAnimationTimer.Interval := Self.ImageDelay;
        FAnimationTimer.Enabled  := True;
    end;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetMultiLoad( const Multi : Boolean );
begin
    FMultiLoad := Multi;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetAnimated( const InAnimated : Boolean );
begin
    FAnimated := InAnimated;

    if FAnimated and (FFrames.Count > 0)then
    begin
        FAnimationTimer.Interval := FImageDelay;
        FAnimationTimer.Enabled  := True;
    end
    else
        FAnimationTimer.Enabled  := False;
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetFrame(FrameNo : LongInt) : TDibGraphic;
begin
    { convert to 0 based }
    FrameNo := FrameNo - 1;

    if (FrameNo < 0) or (FrameNo >= FFrames.Count) then
        raise EEnvisionError.Create(
                          Format( msgFrameDoesNotExist, [FrameNo+1]));

    Result := TDibGraphic(FFrames[FrameNo]);
end;

{--------------------------------------------------------------------------}

function TDibGraphic.GetFrameCount : LongInt;
begin
    Result := FFrames.Count;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphic.SetCurrentFrame(FrameNo : LongInt);
begin
    if (FrameNo = FCurrentFrame) then
        Exit;

    FrameNo := FrameNo - 1;

    if (FrameNo < 0) or (FrameNo >= FFrames.Count) then
        raise EEnvisionError.Create(
                          Format( msgFrameDoesNotExist, [FrameNo+1]));

    Self.Assign(TDibGraphic(FFrames.Items[FrameNo]));

    Changed(Self);

    Application.ProcessMessages;

    FCurrentFrame := FrameNo + 1;
end;


{--------------------------------------------------------------------------}

constructor TRgbToPaletteConverter.Create(var Palette : TMaxLogPalette);
var
    Index : Integer;
begin
    inherited Create;

    pPalette := @Palette;

    for Index := Low(Cache) to High(Cache) do
        Cache[Index].Index := -1;
end;

{--------------------------------------------------------------------------}

function TRgbToPaletteConverter.GetIndex(const Color : TRgb) : Word;
var
    Index        : LongInt;
    MinDistance  : LongInt;
    Distance     : LongInt;
    DiffRed      : LongInt;
    DiffGreen    : LongInt;
    DiffBlue     : LongInt;

    CacheIndex   : Integer;

begin
    Result       := 0;

    { this calculation assumes Cache array starts at 0. }
    CacheIndex  := DWORD(Color) mod (High(Cache)+1);

    { check if color is in cache }
    if (LongInt(Cache[CacheIndex].Index) >= 0) and
       (LongInt(Cache[CacheIndex].Color) = LongInt(Color)) then
    begin
        Result := Cache[CacheIndex].Index;
        Inc(Hits);
    end
    else
    begin
        Inc(Misses);
        MinDistance  := MaxLongInt;
        for Index := 0 to (pPalette^.palNumEntries - 1) do
        begin
            DiffRed   := (Color.Red - pPalette^.palPalEntry[Index].peRed);
            DiffGreen := (Color.Green - pPalette^.palPalEntry[Index].peGreen);
            DiffBlue  := (Color.Blue - pPalette^.palPalEntry[Index].peBlue);

            Distance  := DiffRed*DiffRed + DiffGreen*DiffGreen + DiffBlue*DiffBlue;

            if Distance < MinDistance then
            begin
                MinDistance := Distance;
                Result      := Index;

                if Distance = 0 then
                    Break;
            end;
        end;

        Cache[CacheIndex].Color := Color;
        Cache[CacheIndex].Index := Result;
    end;
end;

{--------------------------------------------------------------------------}

procedure SwapRBOnScanLine( const pScanLine    : PByteArray;
                            const ScanLineSize : LongInt);
var
    pRGB      : ^TRgbQuad;
    Index     : LongInt;
    TempByte  : Byte;
    Width     : LongInt;
begin
    Width := ScanLineSize div 3;
    for Index := 0 to (Width-1) do
    begin
        pRGB          := @pScanLine^[Index*3];
        TempByte      := pRGB^.rgbRed;
        pRGB^.rgbRed  := pRGB^.rgbBlue;
        pRGB^.rgbBlue := TempByte;
    end;
end;

{--------------------------------------------------------------------------}

procedure SetPixelBc1( const ScanLine : PByteArray;
                       const X        : LongInt;
                       const Value    : LongInt );
var
    pByte : ^Byte;
begin
    pByte := @ScanLine^[(X div 8)];
    if Value > 0 then
         { set the bit }
         pByte^ := pByte^ or ($01 shl (8 - ((X mod 8) + 1)))
    else
         { clear the bit }
         pByte^ := pByte^ and not ($01 shl (8 - ((X mod 8) + 1)));
end;

{--------------------------------------------------------------------------}

function GetPixelBc1( const ScanLine : PByteArray;
                      const X        : LongInt ) : LongInt;
begin
    if (ScanLine^[(X div 8)] and ($01 shl (8 - ((X mod 8) + 1)))) <> 0 then
        Result := 1
    else
        Result := 0;
end;

{--------------------------------------------------------------------------}

procedure SetPixelBc4( const ScanLine : PByteArray;
                       const X        : LongInt;
                       const Value    : LongInt );
var
    pByte  : ^Byte;
begin
    pByte   := @ScanLine^[(X div 2)];

    if (X and $01) = 0 then
        pByte^ := (pByte^ and $0F) or (Value shl 4)
    else
        pByte^ := (pByte^ and $F0) or (Value);
end;

{--------------------------------------------------------------------------}

function GetPixelBc4( const ScanLine : PByteArray;
                      const X        : LongInt ) : LongInt;
begin
    if (X and $01) = 0 then
        Result := (ScanLine^[(X div 2)] shr 4) and $0F
    else
        Result := ScanLine^[(X div 2)] and $0F;
end;

{--------------------------------------------------------------------------}

procedure SetPixelBc8( const ScanLine : PByteArray;
                       const X        : LongInt;
                       const Value    : LongInt );
begin
    ScanLine^[X] := Value;
end;

{--------------------------------------------------------------------------}

function GetPixelBc8( const ScanLine : PByteArray;
                      const X        : LongInt ) : LongInt; register;
begin
    Result := ScanLine^[X];
end;

{--------------------------------------------------------------------------}

procedure SetPixelBc24( const ScanLine : PByteArray;
                        const X        : LongInt;
                        const Value    : LongInt ); register;
var
    pRGB : ^Windows.TRGBTriple;
begin
    pRGB := @ScanLine^[X+X+X];
    pRGB^.rgbtBlue   := (Value shr 0) and $FF;
    pRGB^.rgbtGreen := (Value shr 8) and $FF;
    pRGB^.rgbtRed  := (Value shr 16) and $FF;
end;

{--------------------------------------------------------------------------}

function GetPixelBc24( const ScanLine : PByteArray;
                       const X        : LongInt ) : LongInt; register;
var
    pRGB : ^Windows.TRGBTriple;
begin
    pRGB   := @ScanLine^[X+X+X];
    Result := pRGB^.rgbtBlue or (pRGB^.rgbtGreen shl 8) or (pRGB^.rgbtRed shl 16);
end;

{--------------------------------------------------------------------------}

function PaletteSize( const ColorCount : Integer ) : Integer;
begin
    Result := 4 + ColorCount*SizeOf(Windows.TPaletteEntry);
end;

{--------------------------------------------------------------------------}

procedure SetBWPalette( var Palette : TMaxLogPalette );
var
    Index : Integer;
begin
    Palette.palVersion    := $0300;
    Palette.palNumEntries := 2;
    for Index := 0 to (Palette.palNumEntries-1) do
    begin
        Palette.palPalEntry[Index].peRed   := 255 * Index;
        Palette.palPalEntry[Index].peGreen := 255 * Index;
        Palette.palPalEntry[Index].peBlue  := 255 * Index;
    end;
end;

{--------------------------------------------------------------------------}

procedure SetGray16Palette( var Palette : TMaxLogPalette );
var
    Index : Integer;
begin
    Palette.palVersion    := $0300;
    Palette.palNumEntries := 16;
    for Index := 0 to (Palette.palNumEntries-1) do
    begin
        Palette.palPalEntry[Index].peRed   := 17 * Index;
        Palette.palPalEntry[Index].peGreen := 17 * Index;
        Palette.palPalEntry[Index].peBlue  := 17 * Index;
    end;
end;

{--------------------------------------------------------------------------}

procedure SetGray256Palette( var Palette : TMaxLogPalette );
var
    Index : Integer;
begin
    Palette.palVersion    := $0300;
    Palette.palNumEntries := 256;
    for Index := 0 to (Palette.palNumEntries-1) do
    begin
        Palette.palPalEntry[Index].peRed   := Index;
        Palette.palPalEntry[Index].peGreen := Index;
        Palette.palPalEntry[Index].peBlue  := Index;
    end;
end;

{--------------------------------------------------------------------------}

procedure SetColor16Palette( var Palette : TMaxLogPalette );
const
    Color16Entries : packed array [0..15] of TPaletteEntry =
    (
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $AA),
        (peRed : $00; peGreen : $AA; peBlue : $00),
        (peRed : $00; peGreen : $AA; peBlue : $AA),
        (peRed : $AA; peGreen : $00; peBlue : $00),
        (peRed : $AA; peGreen : $00; peBlue : $AA),
        (peRed : $AA; peGreen : $55; peBlue : $00),
        (peRed : $AA; peGreen : $AA; peBlue : $AA),
        (peRed : $55; peGreen : $55; peBlue : $55),
        (peRed : $55; peGreen : $55; peBlue : $FF),
        (peRed : $55; peGreen : $FF; peBlue : $55),
        (peRed : $55; peGreen : $FF; peBlue : $FF),
        (peRed : $FF; peGreen : $55; peBlue : $55),
        (peRed : $FF; peGreen : $55; peBlue : $FF),
        (peRed : $FF; peGreen : $FF; peBlue : $55),
        (peRed : $FF; peGreen : $FF; peBlue : $FF)
    );
begin
    Palette.palVersion    := $0300;
    Palette.palNumEntries := 16;

    Move(Color16Entries, Palette.palPalEntry, SizeOf(Color16Entries));
end;

{--------------------------------------------------------------------------}

procedure SetColor256Palette( var Palette : TMaxLogPalette );
const
    Color256Entries : packed array [0..255] of TPaletteEntry =
    (
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $AA),
        (peRed : $00; peGreen : $AA; peBlue : $00),
        (peRed : $00; peGreen : $AA; peBlue : $AA),
        (peRed : $AA; peGreen : $00; peBlue : $00),
        (peRed : $AA; peGreen : $00; peBlue : $AA),
        (peRed : $AA; peGreen : $55; peBlue : $00),
        (peRed : $AA; peGreen : $AA; peBlue : $AA),
        (peRed : $55; peGreen : $55; peBlue : $55),
        (peRed : $55; peGreen : $55; peBlue : $FF),
        (peRed : $55; peGreen : $FF; peBlue : $55),
        (peRed : $55; peGreen : $FF; peBlue : $FF),
        (peRed : $FF; peGreen : $55; peBlue : $55),
        (peRed : $FF; peGreen : $55; peBlue : $FF),
        (peRed : $FF; peGreen : $FF; peBlue : $55),
        (peRed : $FF; peGreen : $FF; peBlue : $FF),
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $14; peGreen : $14; peBlue : $14),
        (peRed : $20; peGreen : $20; peBlue : $20),
        (peRed : $2C; peGreen : $2C; peBlue : $2C),
        (peRed : $38; peGreen : $38; peBlue : $38),
        (peRed : $45; peGreen : $45; peBlue : $45),
        (peRed : $51; peGreen : $51; peBlue : $51),
        (peRed : $61; peGreen : $61; peBlue : $61),
        (peRed : $71; peGreen : $71; peBlue : $71),
        (peRed : $82; peGreen : $82; peBlue : $82),
        (peRed : $92; peGreen : $92; peBlue : $92),
        (peRed : $A2; peGreen : $A2; peBlue : $A2),
        (peRed : $B6; peGreen : $B6; peBlue : $B6),
        (peRed : $CB; peGreen : $CB; peBlue : $CB),
        (peRed : $E3; peGreen : $B3; peBlue : $B3),
        (peRed : $FF; peGreen : $FF; peBlue : $FF),
        (peRed : $00; peGreen : $00; peBlue : $FF),
        (peRed : $41; peGreen : $00; peBlue : $FF),
        (peRed : $7D; peGreen : $00; peBlue : $FF),
        (peRed : $BE; peGreen : $00; peBlue : $FF),
        (peRed : $FF; peGreen : $00; peBlue : $FF),
        (peRed : $FF; peGreen : $00; peBlue : $BE),
        (peRed : $FF; peGreen : $00; peBlue : $7D),
        (peRed : $FF; peGreen : $00; peBlue : $41),
        (peRed : $FF; peGreen : $00; peBlue : $00),
        (peRed : $FF; peGreen : $41; peBlue : $00),
        (peRed : $FF; peGreen : $7D; peBlue : $00),
        (peRed : $FF; peGreen : $BE; peBlue : $00),
        (peRed : $FF; peGreen : $FF; peBlue : $00),
        (peRed : $BE; peGreen : $FF; peBlue : $00),
        (peRed : $7D; peGreen : $FF; peBlue : $00),
        (peRed : $41; peGreen : $FF; peBlue : $00),
        (peRed : $00; peGreen : $FF; peBlue : $00),
        (peRed : $00; peGreen : $FF; peBlue : $41),
        (peRed : $00; peGreen : $FF; peBlue : $7D),
        (peRed : $00; peGreen : $FF; peBlue : $BE),
        (peRed : $00; peGreen : $FF; peBlue : $FF),
        (peRed : $00; peGreen : $BE; peBlue : $FF),
        (peRed : $00; peGreen : $7D; peBlue : $FF),
        (peRed : $00; peGreen : $41; peBlue : $FF),
        (peRed : $7D; peGreen : $7D; peBlue : $FF),
        (peRed : $9E; peGreen : $7D; peBlue : $FF),
        (peRed : $BE; peGreen : $7D; peBlue : $FF),
        (peRed : $DF; peGreen : $7D; peBlue : $FF),
        (peRed : $FF; peGreen : $7D; peBlue : $FF),
        (peRed : $FF; peGreen : $7D; peBlue : $DF),
        (peRed : $FF; peGreen : $7D; peBlue : $BE),
        (peRed : $FF; peGreen : $7D; peBlue : $9E),
        (peRed : $FF; peGreen : $7D; peBlue : $7D),
        (peRed : $FF; peGreen : $9E; peBlue : $7D),
        (peRed : $FF; peGreen : $BE; peBlue : $7D),
        (peRed : $FF; peGreen : $DF; peBlue : $7D),
        (peRed : $FF; peGreen : $FF; peBlue : $7D),
        (peRed : $DF; peGreen : $FF; peBlue : $7D),
        (peRed : $BE; peGreen : $FF; peBlue : $7D),
        (peRed : $9E; peGreen : $FF; peBlue : $7D),
        (peRed : $7D; peGreen : $FF; peBlue : $7D),
        (peRed : $7D; peGreen : $FF; peBlue : $9E),
        (peRed : $7D; peGreen : $FF; peBlue : $BE),
        (peRed : $7D; peGreen : $FF; peBlue : $DF),
        (peRed : $7D; peGreen : $FF; peBlue : $FF),
        (peRed : $7D; peGreen : $DF; peBlue : $FF),
        (peRed : $7D; peGreen : $BE; peBlue : $FF),
        (peRed : $7D; peGreen : $9E; peBlue : $FF),
        (peRed : $B6; peGreen : $B6; peBlue : $FF),
        (peRed : $C7; peGreen : $B6; peBlue : $FF),
        (peRed : $DB; peGreen : $B6; peBlue : $FF),
        (peRed : $EB; peGreen : $B6; peBlue : $FF),
        (peRed : $FF; peGreen : $B6; peBlue : $FF),
        (peRed : $DF; peGreen : $B6; peBlue : $EB),
        (peRed : $FF; peGreen : $B6; peBlue : $DB),
        (peRed : $FF; peGreen : $B6; peBlue : $C7),
        (peRed : $FF; peGreen : $B6; peBlue : $B6),
        (peRed : $FF; peGreen : $C7; peBlue : $B6),
        (peRed : $FF; peGreen : $DB; peBlue : $B6),
        (peRed : $FF; peGreen : $EB; peBlue : $B6),
        (peRed : $FF; peGreen : $FF; peBlue : $B6),
        (peRed : $EB; peGreen : $FF; peBlue : $B6),
        (peRed : $DB; peGreen : $FF; peBlue : $B6),
        (peRed : $C7; peGreen : $FF; peBlue : $B6),
        (peRed : $B6; peGreen : $DF; peBlue : $B6),
        (peRed : $B6; peGreen : $FF; peBlue : $C7),
        (peRed : $B6; peGreen : $FF; peBlue : $DB),
        (peRed : $B6; peGreen : $FF; peBlue : $EB),
        (peRed : $B6; peGreen : $FF; peBlue : $FF),
        (peRed : $B6; peGreen : $EB; peBlue : $FF),
        (peRed : $B6; peGreen : $DB; peBlue : $FF),
        (peRed : $B6; peGreen : $C7; peBlue : $FF),
        (peRed : $00; peGreen : $00; peBlue : $71),
        (peRed : $1C; peGreen : $00; peBlue : $71),
        (peRed : $38; peGreen : $00; peBlue : $71),
        (peRed : $55; peGreen : $00; peBlue : $71),
        (peRed : $71; peGreen : $00; peBlue : $71),
        (peRed : $71; peGreen : $00; peBlue : $55),
        (peRed : $71; peGreen : $00; peBlue : $38),
        (peRed : $71; peGreen : $00; peBlue : $1C),
        (peRed : $71; peGreen : $00; peBlue : $00),
        (peRed : $71; peGreen : $1C; peBlue : $00),
        (peRed : $71; peGreen : $38; peBlue : $00),
        (peRed : $71; peGreen : $55; peBlue : $00),
        (peRed : $71; peGreen : $71; peBlue : $00),
        (peRed : $55; peGreen : $71; peBlue : $00),
        (peRed : $38; peGreen : $71; peBlue : $00),
        (peRed : $1C; peGreen : $71; peBlue : $00),
        (peRed : $00; peGreen : $71; peBlue : $00),
        (peRed : $00; peGreen : $71; peBlue : $1C),
        (peRed : $00; peGreen : $71; peBlue : $38),
        (peRed : $00; peGreen : $71; peBlue : $55),
        (peRed : $00; peGreen : $71; peBlue : $71),
        (peRed : $00; peGreen : $55; peBlue : $71),
        (peRed : $00; peGreen : $38; peBlue : $71),
        (peRed : $00; peGreen : $1C; peBlue : $71),
        (peRed : $38; peGreen : $38; peBlue : $71),
        (peRed : $45; peGreen : $38; peBlue : $71),
        (peRed : $55; peGreen : $38; peBlue : $71),
        (peRed : $61; peGreen : $38; peBlue : $71),
        (peRed : $71; peGreen : $38; peBlue : $71),
        (peRed : $71; peGreen : $38; peBlue : $61),
        (peRed : $71; peGreen : $38; peBlue : $55),
        (peRed : $71; peGreen : $38; peBlue : $45),
        (peRed : $71; peGreen : $38; peBlue : $38),
        (peRed : $71; peGreen : $45; peBlue : $38),
        (peRed : $71; peGreen : $55; peBlue : $38),
        (peRed : $71; peGreen : $61; peBlue : $38),
        (peRed : $71; peGreen : $71; peBlue : $38),
        (peRed : $61; peGreen : $71; peBlue : $38),
        (peRed : $55; peGreen : $71; peBlue : $38),
        (peRed : $45; peGreen : $71; peBlue : $38),
        (peRed : $38; peGreen : $71; peBlue : $38),
        (peRed : $38; peGreen : $71; peBlue : $45),
        (peRed : $38; peGreen : $71; peBlue : $55),
        (peRed : $38; peGreen : $71; peBlue : $61),
        (peRed : $38; peGreen : $71; peBlue : $71),
        (peRed : $38; peGreen : $61; peBlue : $71),
        (peRed : $38; peGreen : $55; peBlue : $71),
        (peRed : $38; peGreen : $45; peBlue : $71),
        (peRed : $51; peGreen : $51; peBlue : $71),
        (peRed : $59; peGreen : $51; peBlue : $71),
        (peRed : $61; peGreen : $51; peBlue : $71),
        (peRed : $69; peGreen : $51; peBlue : $71),
        (peRed : $71; peGreen : $51; peBlue : $71),
        (peRed : $71; peGreen : $51; peBlue : $69),
        (peRed : $71; peGreen : $51; peBlue : $61),
        (peRed : $71; peGreen : $51; peBlue : $59),
        (peRed : $71; peGreen : $51; peBlue : $51),
        (peRed : $71; peGreen : $59; peBlue : $51),
        (peRed : $71; peGreen : $61; peBlue : $51),
        (peRed : $71; peGreen : $69; peBlue : $51),
        (peRed : $71; peGreen : $71; peBlue : $51),
        (peRed : $69; peGreen : $71; peBlue : $51),
        (peRed : $61; peGreen : $71; peBlue : $51),
        (peRed : $59; peGreen : $71; peBlue : $51),
        (peRed : $51; peGreen : $71; peBlue : $51),
        (peRed : $51; peGreen : $71; peBlue : $59),
        (peRed : $51; peGreen : $71; peBlue : $61),
        (peRed : $51; peGreen : $71; peBlue : $69),
        (peRed : $51; peGreen : $71; peBlue : $71),
        (peRed : $51; peGreen : $69; peBlue : $71),
        (peRed : $51; peGreen : $61; peBlue : $71),
        (peRed : $51; peGreen : $59; peBlue : $71),
        (peRed : $00; peGreen : $00; peBlue : $41),
        (peRed : $10; peGreen : $00; peBlue : $41),
        (peRed : $20; peGreen : $00; peBlue : $41),
        (peRed : $30; peGreen : $00; peBlue : $41),
        (peRed : $41; peGreen : $00; peBlue : $41),
        (peRed : $41; peGreen : $00; peBlue : $30),
        (peRed : $41; peGreen : $00; peBlue : $20),
        (peRed : $41; peGreen : $00; peBlue : $10),
        (peRed : $41; peGreen : $00; peBlue : $00),
        (peRed : $41; peGreen : $10; peBlue : $00),
        (peRed : $41; peGreen : $20; peBlue : $00),
        (peRed : $41; peGreen : $30; peBlue : $00),
        (peRed : $41; peGreen : $41; peBlue : $00),
        (peRed : $30; peGreen : $41; peBlue : $00),
        (peRed : $20; peGreen : $41; peBlue : $00),
        (peRed : $10; peGreen : $41; peBlue : $00),
        (peRed : $00; peGreen : $41; peBlue : $00),
        (peRed : $00; peGreen : $41; peBlue : $10),
        (peRed : $00; peGreen : $41; peBlue : $20),
        (peRed : $00; peGreen : $41; peBlue : $30),
        (peRed : $00; peGreen : $41; peBlue : $41),
        (peRed : $00; peGreen : $30; peBlue : $41),
        (peRed : $00; peGreen : $20; peBlue : $41),
        (peRed : $00; peGreen : $10; peBlue : $41),
        (peRed : $20; peGreen : $20; peBlue : $41),
        (peRed : $28; peGreen : $20; peBlue : $41),
        (peRed : $30; peGreen : $20; peBlue : $41),
        (peRed : $38; peGreen : $20; peBlue : $41),
        (peRed : $41; peGreen : $20; peBlue : $41),
        (peRed : $41; peGreen : $20; peBlue : $38),
        (peRed : $41; peGreen : $20; peBlue : $30),
        (peRed : $41; peGreen : $20; peBlue : $28),
        (peRed : $41; peGreen : $20; peBlue : $20),
        (peRed : $41; peGreen : $28; peBlue : $20),
        (peRed : $41; peGreen : $30; peBlue : $20),
        (peRed : $41; peGreen : $38; peBlue : $20),
        (peRed : $41; peGreen : $41; peBlue : $20),
        (peRed : $38; peGreen : $41; peBlue : $20),
        (peRed : $30; peGreen : $41; peBlue : $20),
        (peRed : $28; peGreen : $41; peBlue : $20),
        (peRed : $20; peGreen : $41; peBlue : $20),
        (peRed : $20; peGreen : $41; peBlue : $28),
        (peRed : $20; peGreen : $41; peBlue : $30),
        (peRed : $20; peGreen : $41; peBlue : $38),
        (peRed : $20; peGreen : $41; peBlue : $41),
        (peRed : $20; peGreen : $38; peBlue : $41),
        (peRed : $20; peGreen : $30; peBlue : $41),
        (peRed : $20; peGreen : $28; peBlue : $41),
        (peRed : $2C; peGreen : $2C; peBlue : $41),
        (peRed : $30; peGreen : $2C; peBlue : $41),
        (peRed : $34; peGreen : $2C; peBlue : $41),
        (peRed : $3C; peGreen : $2C; peBlue : $41),
        (peRed : $41; peGreen : $2C; peBlue : $41),
        (peRed : $41; peGreen : $2C; peBlue : $3C),
        (peRed : $41; peGreen : $2C; peBlue : $34),
        (peRed : $41; peGreen : $2C; peBlue : $30),
        (peRed : $41; peGreen : $2C; peBlue : $2C),
        (peRed : $41; peGreen : $30; peBlue : $2C),
        (peRed : $41; peGreen : $34; peBlue : $2C),
        (peRed : $41; peGreen : $3C; peBlue : $2C),
        (peRed : $41; peGreen : $41; peBlue : $2C),
        (peRed : $3C; peGreen : $41; peBlue : $2C),
        (peRed : $34; peGreen : $41; peBlue : $2C),
        (peRed : $30; peGreen : $41; peBlue : $2C),
        (peRed : $2C; peGreen : $41; peBlue : $2C),
        (peRed : $2C; peGreen : $41; peBlue : $30),
        (peRed : $2C; peGreen : $41; peBlue : $34),
        (peRed : $2C; peGreen : $41; peBlue : $3C),
        (peRed : $2C; peGreen : $41; peBlue : $41),
        (peRed : $2C; peGreen : $3C; peBlue : $41),
        (peRed : $2C; peGreen : $34; peBlue : $41),
        (peRed : $2C; peGreen : $30; peBlue : $41),
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $00),
        (peRed : $00; peGreen : $00; peBlue : $00)
     );

begin
    Palette.palVersion    := $0300;
    Palette.palNumEntries := 256;

    Move(Color256Entries, Palette.palPalEntry, SizeOf(Color256Entries));
end;

{--------------------------------------------------------------------------}

procedure InitPalettes;
begin
    GetMem(pBlackWhitePalette, PaletteSize(2));
    SetBWPalette(pBlackWhitePalette^);

    GetMem(pGray16Palette, PaletteSize(16));
    SetGray16Palette(pGray16Palette^);

    GetMem(pGray256Palette, PaletteSize(256));
    SetGray256Palette(pGray256Palette^);

    GetMem(pColor16Palette, PaletteSize(16));
    SetColor16Palette(pColor16Palette^);

    GetMem(pColor256Palette, PaletteSize(256));
    SetColor256Palette(pColor256Palette^);
end;

{--------------------------------------------------------------------------}

procedure FreePalette( const pPalette : PMaxLogPalette );
begin
    FreeMem(pPalette, PaletteSize(pPalette^.palNumEntries));
end;

{--------------------------------------------------------------------------}

initialization

    ScreenGamma  := 2.2;

    InitPalettes;

    if DibClasses = nil then
        DibClasses := TStringList.Create;

    TPicture.RegisterClipboardFormat(CF_BITMAP, TDibGraphic);

    {$ifdef __Evaluation}
    MessageDlg( 'This software was created with an evaluation'#13 +
                'version of the Envision Image Library. Contact'#13 +
                'your program vendor to obtain a licensed copy.',
                mtInformation, [mbOk], 0);
    {$endif}

finalization

    { unregister the TDibGraphic clipboard format, otherwise
      a GPF would occur when closing Delphi at design time.}
    TPicture.UnregisterGraphicClass(TDibGraphic);

    DibClasses.Free;

    FreePalette(pBlackWhitePalette);
    FreePalette(pGray16Palette);
    FreePalette(pGray256Palette);
    FreePalette(pColor16Palette);
    FreePalette(pColor256Palette);

end.

