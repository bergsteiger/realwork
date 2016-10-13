unit msmButton;

// Модуль: "w:\common\components\gui\Garant\msm\msmButton.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmButton" MUID: (57FD6B8A0273)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
;

type
 TmsmButton = class({$If NOT Defined(NoVCL)}
 TButton
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   constructor Create(AOwner: TComponent); override;
 end;//TmsmButton

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57FD6B8A0273impl_uses*
 //#UC END# *57FD6B8A0273impl_uses*
;

{$If NOT Defined(NoVCL)}
constructor TmsmButton.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57FD6B8A0273_var*
//#UC END# *47D1602000C6_57FD6B8A0273_var*
begin
//#UC START# *47D1602000C6_57FD6B8A0273_impl*
 inherited;
//#UC END# *47D1602000C6_57FD6B8A0273_impl*
end;//TmsmButton.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmButton);
 {* Регистрация TmsmButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
