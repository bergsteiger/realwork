unit Attributes_Form;
 {* Информация о документе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Attributes_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "Attributes" MUID: (4AB1357D0253)
// Имя типа: "TAttributesForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimAttributesOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TAttributesForm = {final} class(TPrimAttributesOptionsForm, AttributesFormDef)
  {* Информация о документе }
 end;//TAttributesForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AttributesKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAttributesForm);
 {* Регистрация Attributes }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AttributesForm.SetFactory(TAttributesForm.Make);
 {* Регистрация фабрики формы Attributes }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
