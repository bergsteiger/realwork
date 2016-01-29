unit vtInterfaces;

interface

uses
 l3IntfUses
 , Graphics
 , ImgList
 , Classes
;

type
 TvtPILBpp = (
  bpp24
  , bpp8
  , bpp4
 );//TvtPILBpp
 
 TvtPILSize = (
  ps16x16
  , ps32x32
  , ps24x24
 );//TvtPILSize
 
 TvtPILSizes = set of TvtPILSize;
 
 IvtFlashImageList = interface
  procedure SaveImageToStream(aStream: TStream;
   aIndex: TImageIndex;
   aBpp: TvtPILBpp);
  procedure Draw(Canvas: TCanvas;
   X: Integer;
   Y: Integer;
   Index: TImageIndex;
   Enabled: Boolean;
   HalfTransparent: Boolean);
 end;//IvtFlashImageList
 
implementation

uses
 l3ImplUses
;

end.
