unit ChromeLikeInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::ChromeLikeControls::ChromeLikeInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Types
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  
  ;

type
 TChromeLikeTabSetParams = record
   rCloseButtonImages : TCustomImageList;
   rTabImages : TCustomImageList;
   rCloseButtonImageIndex : TImageIndex;
   rCloseButtonHotImageIndex : TImageIndex;
 end;//TChromeLikeTabSetParams

  TChromeLikeCaptionMenuKind = (
   {* Тип попап-меню в заголовочном контроле }
    cl_cmkSystem // Показывать системное меню
  , cl_cmkCustom // Показывать свое меню
  , cl_cmkNone // Не показывать никакого меню
  );//TChromeLikeCaptionMenuKind

 IChromeLikeCaptionControl = interface(IUnknown)
   ['{A051CA0C-AA42-42C4-B5BE-0A024F9C99BC}']
   function GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
   procedure ShowContextMenu(const aPoint: TPoint);
   function pm_GetVCLWinControl: TWinControl;
   property VCLWinControl: TWinControl
     read pm_GetVCLWinControl;
 end;//IChromeLikeCaptionControl


function TChromeLikeTabSetParams_C(aTabImages: TCustomImageList;
     aCloseButtonImages: TCustomImageList;
     aCloseButtonImageIndex: TImageIndex;
     aCloseButtonHotImageIndex: TImageIndex): TChromeLikeTabSetParams;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

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
end;//TChromeLikeTabSetParams.C

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.