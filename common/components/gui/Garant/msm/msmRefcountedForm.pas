unit msmRefcountedForm;

// Модуль: "w:\common\components\gui\Garant\msm\msmRefcountedForm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmRefcountedForm" MUID: (57F7C5E10207)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3Forms
 , Classes
;

type
 TmsmRefcountedForm = class(Tl3Form)
  public
   constructor Create(AOwner: TComponent); override;
 end;//TmsmRefcountedForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57F7C5E10207impl_uses*
 //#UC END# *57F7C5E10207impl_uses*
;

constructor TmsmRefcountedForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57F7C5E10207_var*
//#UC END# *47D1602000C6_57F7C5E10207_var*
begin
//#UC START# *47D1602000C6_57F7C5E10207_impl*
 inherited;
//#UC END# *47D1602000C6_57F7C5E10207_impl*
end;//TmsmRefcountedForm.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmRefcountedForm);
 {* Регистрация TmsmRefcountedForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
