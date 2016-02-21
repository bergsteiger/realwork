unit ListAnalize_Form;
 {* Анализ списка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalize_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListAnalize_Form
 , Common_FormDefinitions_Controls
;

type
 TListAnalizeForm = {final} class(TPrimListAnalizeForm, ListAnalizeFormDef)
  {* Анализ списка }
 end;//TListAnalizeForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListAnalizeKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TListAnalizeForm);
 {* Регистрация ListAnalize }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ListAnalizeForm.SetFactory(TListAnalizeForm.Make);
 {* Регистрация фабрики формы ListAnalize }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
