unit Diction_Form;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\Diction_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "Diction" MUID: (4A9CEA5001CF)
// Имя типа: "TenDiction"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDictionOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TenDiction = {final} class(TPrimDictionOptionsForm, DictionFormDef)
  {* Толковый словарь }
 end;//TenDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DictionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenDiction);
 {* Регистрация Diction }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enDiction.SetFactory(TenDiction.Make);
 {* Регистрация фабрики формы Diction }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
