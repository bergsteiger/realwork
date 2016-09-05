unit NOT_FINISHED_msmAppForm;

// Модуль: "w:\common\components\gui\Garant\msm\NOT_FINISHED_msmAppForm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmAppForm" MUID: (57CD56D802A2)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3Forms
;

type
 TmsmAppForm = class(Tl3Form)
 end;//TmsmAppForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57CD56D802A2impl_uses*
 //#UC END# *57CD56D802A2impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmAppForm);
 {* Регистрация TmsmAppForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
