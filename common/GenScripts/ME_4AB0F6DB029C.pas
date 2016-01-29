unit ImgList;

interface

uses
 l3IntfUses
 , Classes
 , Graphics
 , Types
;

type
 TCustomImageList = class(TComponent)
  {* CustomImageList is the base class for collections of same-sized images, each of which can be referred to by its index. }
  procedure Change;
  procedure ReadData(Stream: TStream);
  procedure WriteData(Stream: TStream);
  procedure DoDraw(Index: Integer;
   Canvas: TCanvas;
   X: Integer;
   Y: Integer;
   Style: Cardinal;
   Enabled: Boolean);
  function ImageExtent(anIndex: Integer): TPoint;
  function IsSmart: Boolean;
 end;//TCustomImageList
 
 TChangeLink = class(TObject)
  {* The TImageList component uses TChangeLink internally to notify other objects when changes are made to the image list. }
 end;//TChangeLink
 
 // TOverlay
 
 TDrawingStyle = (
  {* TDrawingStyle indicates the style to use when rendering an image from an image list. }
  dsFocus
   {* Draws the image blending 25% with the color specified by the BlendColor property. This only affects image lists that contain masks. }
  , dsSelected
   {* Draws the image blending 50% with the color specified by the BlendColor property. This only affects image lists that contain masks. }
  , dsNormal
   {* Draws the image using the color specified in the BkColor property. If the BkColor is clNone, the image is drawn transparently using the mask. }
  , dsTransparent
   {* Draws using the mask regardless of the BkColor setting. }
 );//TDrawingStyle
 
 TImageType = (
  {* TImageType indicates whether to use a mask when rendering an image from an image list. }
  itImage
   {* Image does not include a mask. }
  , itMask
   {* Image uses a mask. }
 );//TImageType
 
 TResType = (
  {* TResType identifies a type of graphical resource to an image list. }
  rtBitmap
   {* Loads or retrieves a bitmap. }
  , rtCursor
   {* Loads or retrieves a cursor. }
  , rtIcon
   {* Loads or retrieves an icon. }
 );//TResType
 
 TLoadResource = (
  {* TLoadResource and TLoadResources determine how a resource is loaded into an image list. }
  lrDefaultColor
   {* Use the color format of the display. }
  , lrDefaultSize
   {* Use system metrics for Height and Width if the Width parameter to GetResource is 0. If the Width parameter is 0 and this option is not specified for cursors and icons, the resources width and height will be used. }
  , lrFromFile
   {* Loads the resource from a specified file. }
  , lrMap3DColors
   {* Replaces the images' gray shades with the 3D windows colors. }
  , lrTransparent
   {* Replaces the color table entry for the first pixel of the resource with the default window color (COLOR_WINDOW). This applies only to images with color tables. }
  , lrMonoChrome
   {* Loads the resource as black and white. }
 );//TLoadResource
 
 TLoadResources = set of TLoadResource;
  {* TLoadResource and TLoadResources determine how a resource is loaded into an image list. }
 
 TImageIndex = type Integer;
  {* TImageIndex represents the index of an image in a TImageList component. }
 
implementation

uses
 l3ImplUses
;

end.
