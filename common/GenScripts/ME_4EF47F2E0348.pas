unit UserCR1_WarningBaloon_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\UserCR1_WarningBaloon_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "UserCR1_WarningBaloon" MUID: (4EF47F2E0348)
// Имя типа: "TUserCR1_WarningBaloonForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningBaloonOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TUserCR1_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, UserCR1_WarningBaloonFormDef)
 end;//TUserCR1_WarningBaloonForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , UserCR1_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TUserCR1_WarningBaloonForm);
 {* Регистрация UserCR1_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_UserCR1_WarningBaloonForm.SetFactory(TUserCR1_WarningBaloonForm.Make);
 {* Регистрация фабрики формы UserCR1_WarningBaloon }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
