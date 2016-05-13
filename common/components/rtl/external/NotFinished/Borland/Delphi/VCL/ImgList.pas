unit ImgList;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\ImgList.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ImgList" MUID: (4AB0F6DB029C)

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Classes
 , Graphics
 , Types
;

type
 TCustomImageList = class(TComponent)
  {* CustomImageList is the base class for collections of same-sized images, each of which can be referred to by its index. }
  protected
   procedure Change; virtual;
   procedure ReadData(Stream: TStream); virtual;
   procedure WriteData(Stream: TStream); virtual;
  public
   procedure DoDraw(Index: Integer;
    Canvas: TCanvas;
    X: Integer;
    Y: Integer;
    Style: Cardinal;
    Enabled: Boolean); virtual;
   {$If NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
   function ImageExtent(anIndex: Integer): TPoint; virtual;
   {$IfEnd} // NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)
   {$If NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
   function IsSmart: Boolean; virtual;
   {$IfEnd} // NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)
 end;//TCustomImageList

 TChangeLink = class(TObject)
  {* The TImageList component uses TChangeLink internally to notify other objects when changes are made to the image list. }
  protected
   function pm_GetOnChange: TNotifyEvent; virtual; abstract;
   procedure pm_SetOnChange(aValue: TNotifyEvent); virtual; abstract;
   function pm_GetSender: TCustomImageList; virtual; abstract;
   procedure pm_SetSender(aValue: TCustomImageList); virtual; abstract;
  public
   property OnChange: TNotifyEvent
    read pm_GetOnChange
    write pm_SetOnChange;
   property Sender: TCustomImageList
    read pm_GetSender
    write pm_SetSender;
 end;//TChangeLink

 TOverlay = 0 .. 3;
  {* TOverlay indicates the index of an overlay mask. }

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
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TCustomImageList.Change;
//#UC START# *4FD08E8503DC_473DA2AF0168_var*
//#UC END# *4FD08E8503DC_473DA2AF0168_var*
begin
//#UC START# *4FD08E8503DC_473DA2AF0168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD08E8503DC_473DA2AF0168_impl*
end;//TCustomImageList.Change

procedure TCustomImageList.ReadData(Stream: TStream);
//#UC START# *4FD08F7F01AD_473DA2AF0168_var*
//#UC END# *4FD08F7F01AD_473DA2AF0168_var*
begin
//#UC START# *4FD08F7F01AD_473DA2AF0168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD08F7F01AD_473DA2AF0168_impl*
end;//TCustomImageList.ReadData

procedure TCustomImageList.WriteData(Stream: TStream);
//#UC START# *4FD08FA7008C_473DA2AF0168_var*
//#UC END# *4FD08FA7008C_473DA2AF0168_var*
begin
//#UC START# *4FD08FA7008C_473DA2AF0168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD08FA7008C_473DA2AF0168_impl*
end;//TCustomImageList.WriteData

procedure TCustomImageList.DoDraw(Index: Integer;
 Canvas: TCanvas;
 X: Integer;
 Y: Integer;
 Style: Cardinal;
 Enabled: Boolean);
//#UC START# *4FD093CB025F_473DA2AF0168_var*
//#UC END# *4FD093CB025F_473DA2AF0168_var*
begin
//#UC START# *4FD093CB025F_473DA2AF0168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD093CB025F_473DA2AF0168_impl*
end;//TCustomImageList.DoDraw

{$If NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
function TCustomImageList.ImageExtent(anIndex: Integer): TPoint;
//#UC START# *4FD0944D0202_473DA2AF0168_var*
//#UC END# *4FD0944D0202_473DA2AF0168_var*
begin
//#UC START# *4FD0944D0202_473DA2AF0168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD0944D0202_473DA2AF0168_impl*
end;//TCustomImageList.ImageExtent
{$IfEnd} // NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)

{$If NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
function TCustomImageList.IsSmart: Boolean;
//#UC START# *4FD095D20217_473DA2AF0168_var*
//#UC END# *4FD095D20217_473DA2AF0168_var*
begin
//#UC START# *4FD095D20217_473DA2AF0168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD095D20217_473DA2AF0168_impl*
end;//TCustomImageList.IsSmart
{$IfEnd} // NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomImageList);
 {* Регистрация TCustomImageList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
