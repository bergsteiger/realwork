unit F1LikeRes;

// Модуль: "w:\common\components\gui\Garant\VCM\View\F1LikeRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "F1Like" MUID: (4F6B607F027E)
// Имя типа: "TF1LikeRes"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLikeRes
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TF1LikeRes = {abstract} class(TOfficeLikeRes)
  protected
   {$If NOT Defined(NoVCM)}
   class procedure MakeResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TF1LikeRes

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , moTasksPanelMenu
 {$IfEnd} // NOT Defined(NoVCM)
 , moParentAndChild
 , vtStdRes
;

{$If NOT Defined(NoVCM)}
class procedure TF1LikeRes.MakeResources;
//#UC START# *4F6AF5F00058_4F6B607F027E_var*
//#UC END# *4F6AF5F00058_4F6B607F027E_var*
begin
//#UC START# *4F6AF5F00058_4F6B607F027E_impl*
 Application.CreateForm(TvtStdResources, vtStdResources);
//#UC END# *4F6AF5F00058_4F6B607F027E_impl*
end;//TF1LikeRes.MakeResources
{$IfEnd} // NOT Defined(NoVCM)

end.
