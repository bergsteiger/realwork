unit Warning_Form;
 {* Предупреждение }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Warning_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDockedWarning_Form
 , Common_FormDefinitions_Controls
;

type
 TWarningForm = {final} class(TPrimDockedWarningForm, WarningFormDef)
  {* Предупреждение }
 end;//TWarningForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , WarningConst
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , WarningKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TWarningForm);
 {* Регистрация Warning }
{$IfEnd} // NOT Defined(NoScripts)
 fm_WarningForm.SetFactory(TWarningForm.Make);
 {* Регистрация фабрики формы Warning }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
