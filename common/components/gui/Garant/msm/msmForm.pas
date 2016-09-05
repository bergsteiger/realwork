unit msmForm;

// Модуль: "w:\common\components\gui\Garant\msm\msmForm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmForm" MUID: (57AB4B6D0236)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TmsmForm = class({$If NOT Defined(NoVCL)}
 TForm
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//TmsmForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57AB4B6D0236impl_uses*
 //#UC END# *57AB4B6D0236impl_uses*
;

{$If NOT Defined(NoVCL)}
initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmForm);
 {* Регистрация TmsmForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
