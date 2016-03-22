unit NewGenMainPrim_Form;

// Модуль: "w:\MDProcess\NewGen\NewGenMainPrim_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "NewGenMainPrim" MUID: (4F6B6E380367)
// Имя типа: "TNewGenMainPrimForm"

{$Include w:\MDProcess\NewGen\ngDefine.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 , MainPrim_Form
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
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNewGenMainPrimForm);
 {* Регистрация NewGenMainPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(NewGen)

end.
