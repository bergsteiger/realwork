unit vcmMainFormModelPart;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormModelPart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmMainFormModelPart" MUID: (4F7B0CBE0283)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmContainerForm
;

type
 TvcmMainFormModelPart = class(TvcmContainerForm)
  protected
   procedure DispatcherCreated; virtual;
   procedure AfterModulesRegistered; virtual;
 end;//TvcmMainFormModelPart
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4F7B0CBE0283impl_uses*
 //#UC END# *4F7B0CBE0283impl_uses*
;

procedure TvcmMainFormModelPart.DispatcherCreated;
//#UC START# *4F7B0CF50022_4F7B0CBE0283_var*
//#UC END# *4F7B0CF50022_4F7B0CBE0283_var*
begin
//#UC START# *4F7B0CF50022_4F7B0CBE0283_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4F7B0CF50022_4F7B0CBE0283_impl*
end;//TvcmMainFormModelPart.DispatcherCreated

procedure TvcmMainFormModelPart.AfterModulesRegistered;
//#UC START# *537DB0AD03D8_4F7B0CBE0283_var*
//#UC END# *537DB0AD03D8_4F7B0CBE0283_var*
begin
//#UC START# *537DB0AD03D8_4F7B0CBE0283_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *537DB0AD03D8_4F7B0CBE0283_impl*
end;//TvcmMainFormModelPart.AfterModulesRegistered

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmMainFormModelPart);
 {* Регистрация TvcmMainFormModelPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
