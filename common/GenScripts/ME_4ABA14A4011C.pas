unit StyleEditorExample_Form;
 {* Пример текста }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorExample_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "StyleEditorExample" MUID: (4ABA14A4011C)
// Имя типа: "TStyleEditorExampleForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimStyleEditorExample_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_StyleEditorExampleForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorExampleForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TStyleEditorExampleForm }

type
 TStyleEditorExampleForm = class;

 StyleEditorExampleFormDef = interface
  {* Идентификатор формы StyleEditorExample }
  ['{941E9E1B-2C84-4067-938E-6CFE6F2614A7}']
 end;//StyleEditorExampleFormDef

 TStyleEditorExampleForm = {final} class(TPrimStyleEditorExampleForm, StyleEditorExampleFormDef)
  {* Пример текста }
 end;//TStyleEditorExampleForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StyleEditorExampleKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorExampleForm);
 {* Регистрация StyleEditorExample }
{$IfEnd} // NOT Defined(NoScripts)
 fm_StyleEditorExampleForm.SetFactory(TStyleEditorExampleForm.Make);
 {* Регистрация фабрики формы StyleEditorExample }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
