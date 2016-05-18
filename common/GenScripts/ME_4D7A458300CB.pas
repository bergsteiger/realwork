unit BaseSearchContainer_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchContainer_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "BaseSearchContainer" MUID: (4D7A458300CB)
// Имя типа: "TBaseSearchContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimBaseSearchContainer_Form
 , Common_FormDefinitions_Controls
;

type
 TBaseSearchContainerForm = {final} class(TPrimBaseSearchContainerForm, BaseSearchContainerFormDef)
 end;//TBaseSearchContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , BaseSearchContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseSearchContainerForm);
 {* Регистрация BaseSearchContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_BaseSearchContainerForm.SetFactory(TBaseSearchContainerForm.Make);
 {* Регистрация фабрики формы BaseSearchContainer }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
