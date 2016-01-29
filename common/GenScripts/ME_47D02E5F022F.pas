unit l3ImageList;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3InternalInterfaces
 , ImgList
 , l3Core
 , l3Units
 , l3Interfaces
;

type
 Tl3ImageList = class(Tl3CProtoObject, Il3ImageList)
  procedure Create(aList: TCustomImageList);
  function Make(aList: TCustomImageList): Il3ImageList;
  function DoGetBigSize: Boolean;
  procedure DoSetBigSize(aValue: Boolean);
  procedure Draw(const aCanvas: Il3Canvas;
   const aRect: Tl3SRect;
   aFillColor: Tl3Color;
   Index: Integer;
   Enabled: Boolean); overload;
  procedure Draw(const aCanvas: Il3Canvas;
   X: Integer;
   Y: Integer;
   Index: Integer;
   Enabled: Boolean); overload;
  procedure Draw(const aCanvas: Il3Canvas;
   X: Integer;
   Y: Integer;
   Index: Integer;
   ADrawingStyle: Tl3DrawingStyle;
   AImageType: Tl3ImageType;
   Enabled: Boolean); overload;
  function Hack: pointer;
  function Width: Integer;
  function Height: Integer;
  function Count: Integer;
  function Handle: THandle;
  function BigSize: Boolean;
 end;//Tl3ImageList
 
implementation

uses
 l3ImplUses
 , l3Bitmap
 , Graphics
 , Types
;

end.
