unit vcmContainerFormModelPart;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmContainerFormModelPart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmContainerFormModelPart" MUID: (4F7B1BC201C2)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmEntityForm
 , vcmInterfaces
;

type
 TvcmContainerFormModelPart = class(TvcmEntityForm)
  protected
   procedure AfterInsertForm(const aForm: IvcmEntityForm); virtual;
 end;//TvcmContainerFormModelPart
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvcmContainerFormModelPart.AfterInsertForm(const aForm: IvcmEntityForm);
//#UC START# *4F7C6DFE00DE_4F7B1BC201C2_var*
//#UC END# *4F7C6DFE00DE_4F7B1BC201C2_var*
begin
//#UC START# *4F7C6DFE00DE_4F7B1BC201C2_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4F7C6DFE00DE_4F7B1BC201C2_impl*
end;//TvcmContainerFormModelPart.AfterInsertForm

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmContainerFormModelPart);
 {* Регистрация TvcmContainerFormModelPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
