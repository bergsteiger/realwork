unit RoundedEdit;

// Модуль: "w:\common\components\SandBox\RoundedEdit.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TRoundedEdit" MUID: (517C102F03B5)

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
 _RefCounted_Parent_ = TEdit;
 {$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}
 _RoundedControl_Parent_ = _RefCounted_;
 {$Include w:\common\components\SandBox\RoundedControl.imp.pas}
 TRoundedEdit = class(_RoundedControl_)
 end;//TRoundedEdit

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
;

{$If NOT Defined(NoVCL)}
{$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}

{$Include w:\common\components\SandBox\RoundedControl.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRoundedEdit);
 {* Регистрация TRoundedEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
