unit RoundedEdit;

// Модуль: "w:\common\components\SandBox\RoundedEdit.pas"
// Стереотип: "GuiControl"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Region
 , Messages
;

type
 _RefCounted_Parent_ = TEdit;
 {$Include RefCounted.imp.pas}
 _RoundedControl_Parent_ = _RefCounted_;
 {$Include RoundedControl.imp.pas}
 TRoundedEdit = class(_RoundedControl_)
 end;//TRoundedEdit

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , Windows
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Themes
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include RefCounted.imp.pas}

{$Include RoundedControl.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRoundedEdit);
 {* Регистрация TRoundedEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
