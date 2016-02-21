unit RoundedButton;

// Модуль: "w:\common\components\SandBox\RoundedButton.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\SandBox\sbDefine.inc}

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
;

{$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}

{$Include w:\common\components\SandBox\RoundedControl.imp.pas}

end.
