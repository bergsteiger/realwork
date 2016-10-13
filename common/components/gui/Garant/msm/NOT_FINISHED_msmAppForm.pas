unit NOT_FINISHED_msmAppForm;

// Модуль: "w:\common\components\gui\Garant\msm\NOT_FINISHED_msmAppForm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmAppForm" MUID: (57CD56D802A2)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmRefcountedForm
 , Classes
;

type
 TmsmAppForm = class(TmsmRefcountedForm)
  public
   constructor Create(AOwner: TComponent); override;
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

constructor TmsmAppForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57CD56D802A2_var*
//#UC END# *47D1602000C6_57CD56D802A2_var*
begin
//#UC START# *47D1602000C6_57CD56D802A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D1602000C6_57CD56D802A2_impl*
end;//TmsmAppForm.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmAppForm);
 {* Регистрация TmsmAppForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
