unit vtPngImgList;

interface

uses
 l3IntfUses
 , Windows
 , ImgList
 , vtInterfaces
 , vtPngImgListUtils
 , hyieutils
 , l3InternalInterfaces
 , l3PrinterInterfaces
 , l3Core
 , Graphics
 , Classes
 , Types
;

type
 TvtNonFixedPngImageListPrim = class(TCustomImageList, IvtFlashImageList)
  procedure CalcCount;
  procedure ResizeAll(aCount: Integer);
  function CanAlphaDraw(aBpp: TvtPILBpp): Boolean;
  procedure ClearAlphaDrawCache;
  procedure ClearCache;
  function AddItem: Integer;
  procedure Delete(aIndex: Integer);
  procedure AddImage(Index: Integer;
   Bpp: TvtPILBpp;
   Image: TIEBitmap);
  procedure GetImage(Index: Integer;
   Bpp: TvtPILBpp;
   Image: TIEBitmap);
  procedure Clear;
  procedure DrawGlyphSpecified(Index: Integer;
   const Canvas: Il3Canvas;
   Bpp: TvtPILBpp;
   X: Integer;
   Y: Integer;
   Enabled: Boolean); overload;
  procedure DrawGlyphSpecified(Index: Integer;
   Canvas: TCanvas;
   Bpp: TvtPILBpp;
   X: Integer;
   Y: Integer;
   Enabled: Boolean;
   HalfTransparent: Boolean); overload;
  procedure SaveImage(const aFilename: AnsiString;
   aIndex: Integer;
   aBpp: TvtPILBpp);
  procedure Exchange(Index1: Integer;
   Index2: Integer);
  function ImageExtent(anIndex: Integer): TPoint;
  procedure Draw(Canvas: TCanvas;
   X: Integer;
   Y: Integer;
   Index: TImageIndex;
   Enabled: Boolean;
   HalfTransparent: Boolean);
  procedure SaveImageToStream(aStream: TStream;
   aIndex: TImageIndex;
   aBpp: TvtPILBpp);
 end;//TvtNonFixedPngImageListPrim
 
 // TvtBPPGlyphs
 
 // TvtSizeBPPGlyphs
 
 // TvtPILSizeBitmapArray
 
 // TvtPILSizeBoolArray
 
 TvtPngImageListPrim = class(TCustomImageList, IvtFlashImageList)
  procedure CalcCount(UseNewSizes: Boolean);
  procedure ResizeAll(aCount: Integer);
  function CanAlphaDraw(aBpp: TvtPILBpp;
   aSize: TvtPILSize): Boolean;
  procedure ClearAlphaDrawCache;
  procedure ClearCache;
  function AddItem: Integer;
  procedure Delete(aIndex: Integer);
  procedure AddImage(Index: Integer;
   Size: TvtPILSize;
   Bpp: TvtPILBpp;
   Image: TIEBitmap);
  procedure DrawGlyphSpecified(Index: Integer;
   const Canvas: Il3Canvas;
   Size: TvtPILSize;
   Bpp: TvtPILBpp;
   X: Integer;
   Y: Integer;
   Enabled: Boolean); overload;
  procedure Exchange(Index1: Integer;
   Index2: Integer);
  procedure _RepairSizes;
  procedure Clear;
  procedure CopySizeToSize(aSizeFrom: TvtPILSize;
   aSizeTo: TvtPILSize);
  procedure SaveImage(const aFilename: AnsiString;
   aIndex: Integer;
   aSize: TvtPILSize;
   aBpp: TvtPILBpp);
  procedure DrawGlyphSpecified(Index: Integer;
   Canvas: TCanvas;
   Size: TvtPILSize;
   Bpp: TvtPILBpp;
   X: Integer;
   Y: Integer;
   Enabled: Boolean;
   HalfTransparent: Boolean); overload;
  function ImageExtent(anIndex: Integer): TPoint;
  procedure Draw(Canvas: TCanvas;
   X: Integer;
   Y: Integer;
   Index: TImageIndex;
   Enabled: Boolean;
   HalfTransparent: Boolean);
  procedure SaveImageToStream(aStream: TStream;
   aIndex: TImageIndex;
   aBpp: TvtPILBpp);
 end;//TvtPngImageListPrim
 
 TvtFixedSizeProxyPngImageListPrim = class(TCustomImageList, IvtFlashImageList)
  procedure ImageListChange(Sender: TObject);
  procedure Draw(Canvas: TCanvas;
   X: Integer;
   Y: Integer;
   Index: TImageIndex;
   Enabled: Boolean;
   HalfTransparent: Boolean);
  procedure SaveImageToStream(aStream: TStream;
   aIndex: TImageIndex;
   aBpp: TvtPILBpp);
 end;//TvtFixedSizeProxyPngImageListPrim
 
 TvtNonFixedPngImageList = class(TvtNonFixedPngImageListPrim)
 end;//TvtNonFixedPngImageList
 
 TvtPngImageList = class(TvtPngImageListPrim)
 end;//TvtPngImageList
 
 TvtFixedSizeProxyPngImageList = class(TvtFixedSizeProxyPngImageListPrim)
 end;//TvtFixedSizeProxyPngImageList
 
 TBitmap = vtPngImgListUtils.TBitmap;
 
implementation

uses
 l3ImplUses
 , l3Bitmap
 , l3Base
 , hyiedefs
 , imageenio
 , l3ObjectList
 , SysUtils
;

end.
