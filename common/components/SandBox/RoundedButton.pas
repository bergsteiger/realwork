unit RoundedButton;

// Модуль: "w:\common\components\SandBox\RoundedButton.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TRoundedButton" MUID: (517C0F9C03C3)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Region
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
;

type
 _RefCounted_Parent_ = TButton;
 {$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}
 _RoundedControl_Parent_ = _RefCounted_;
 {$Include w:\common\components\SandBox\RoundedControl.imp.pas}
 TRoundedButton = class(_RoundedControl_)
 end;//TRoundedButton

implementation

uses
 l3ImplUses
 , Windows
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Themes
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *517C0F9C03C3impl_uses*
 //#UC END# *517C0F9C03C3impl_uses*
;

{$If NOT Defined(NoVCL)}
{$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}

{$Include w:\common\components\SandBox\RoundedControl.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRoundedButton);
 {* Регистрация TRoundedButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
