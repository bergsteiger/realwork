unit NOT_COMPLETED_NewGenMainPrim_Form;

// Модуль: "w:\MDProcess\NewGen\NOT_COMPLETED_NewGenMainPrim_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "NewGenMainPrim" MUID: (4F6B6E380367)
// Имя типа: "TNewGenMainPrimForm"

{$Include w:\MDProcess\NewGen\ngDefine.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 , MainPrim_Form
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TNewGenMainPrimForm = class(TMainPrimForm)
 end;//TNewGenMainPrimForm
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4F6B6E380367impl_uses*
 //#UC END# *4F6B6E380367impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNewGenMainPrimForm);
 {* Регистрация NewGenMainPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(NewGen)

end.
