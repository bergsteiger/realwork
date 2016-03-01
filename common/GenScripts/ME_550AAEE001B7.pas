unit sdsInpharmMainMenu;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\InpharmControllers\sdsInpharmMainMenu.pas"
// Стереотип: "UseCaseControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InpharmInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _SetType_ = IsdsInpharmMainMenu;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
 TsdsInpharmMainMenu = class(_vcmTinyUseCaseController_, IsdsInpharmMainMenu)
  private
   f_dsInpharmMainMenuData: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsInpharmMainMenuData }
  protected
   function pm_GetdsInpharmMainMenuData: IdsInpharmMainMenu;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsInpharmMainMenu
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsInpharmMainMenu
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
;

type _Instance_R_ = TsdsInpharmMainMenu;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}

function TsdsInpharmMainMenu.pm_GetdsInpharmMainMenuData: IdsInpharmMainMenu;
//#UC START# *550C0D1A00CC_550AAEE001B7get_var*
//#UC END# *550C0D1A00CC_550AAEE001B7get_var*
begin
//#UC START# *550C0D1A00CC_550AAEE001B7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *550C0D1A00CC_550AAEE001B7get_impl*
end;//TsdsInpharmMainMenu.pm_GetdsInpharmMainMenuData

{$If NOT Defined(NoVCM)}
procedure TsdsInpharmMainMenu.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_550AAEE001B7_var*
//#UC END# *4938F7E702B7_550AAEE001B7_var*
begin
//#UC START# *4938F7E702B7_550AAEE001B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_550AAEE001B7_impl*
end;//TsdsInpharmMainMenu.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
