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
 , Classes
;

type
 TmsmForm = class({$If NOT Defined(NoVCL)}
 TForm
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   constructor Create(AOwner: TComponent); override;
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
constructor TmsmForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57AB4B6D0236_var*
//#UC END# *47D1602000C6_57AB4B6D0236_var*
begin
//#UC START# *47D1602000C6_57AB4B6D0236_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D1602000C6_57AB4B6D0236_impl*
end;//TmsmForm.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmForm);
 {* Регистрация TmsmForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
