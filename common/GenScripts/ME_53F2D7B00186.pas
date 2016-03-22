unit ChromeLikeInterfaces;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "ChromeLikeInterfaces" MUID: (53F2D7B00186)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
;

type
 TChromeLikeTabSetParams = record
  rCloseButtonImages: TCustomImageList;
  rTabImages: TCustomImageList;
  rCloseButtonImageIndex: TImageIndex;
  rCloseButtonHotImageIndex: TImageIndex;
 end;//TChromeLikeTabSetParams

 TChromeLikeCaptionMenuKind = (
  {* Тип попап-меню в заголовочном контроле }
  cl_cmkSystem
   {* Показывать системное меню }
  , cl_cmkCustom
   {* Показывать свое меню }
  , cl_cmkNone
   {* Не показывать никакого меню }
 );//TChromeLikeCaptionMenuKind

 IChromeLikeCaptionControl = interface
  ['{A051CA0C-AA42-42C4-B5BE-0A024F9C99BC}']
  function pm_GetVCLWinControl: TWinControl;
  function GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
  procedure ShowContextMenu(const aPoint: TPoint);
  property VCLWinControl: TWinControl
   read pm_GetVCLWinControl;
 end;//IChromeLikeCaptionControl

function TChromeLikeTabSetParams_C(aTabImages: TCustomImageList;
 aCloseButtonImages: TCustomImageList;
 aCloseButtonImageIndex: TImageIndex;
 aCloseButtonHotImageIndex: TImageIndex): TChromeLikeTabSetParams;
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
;

function TChromeLikeTabSetParams_C(aTabImages: TCustomImageList;
 aCloseButtonImages: TCustomImageList;
 aCloseButtonImageIndex: TImageIndex;
 aCloseButtonHotImageIndex: TImageIndex): TChromeLikeTabSetParams;
//#UC START# *5518DC3B0065_551552FA002B_var*
//#UC END# *5518DC3B0065_551552FA002B_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5518DC3B0065_551552FA002B_impl*
 with Result do
 begin
  rCloseButtonImages := aCloseButtonImages;
  rTabImages := aTabImages;
  rCloseButtonImageIndex := aCloseButtonImageIndex;
  rCloseButtonHotImageIndex := aCloseButtonHotImageIndex;
 end;
//#UC END# *5518DC3B0065_551552FA002B_impl*
end;//TChromeLikeTabSetParams_C
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
