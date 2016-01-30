unit RoundedButton;

// Модуль: "w:\common\components\SandBox\RoundedButton.pas"
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
 _RefCounted_Parent_ = TButton;
 {$Include RefCounted.imp.pas}
 _RoundedControl_Parent_ = _RefCounted_;
 {$Include RoundedControl.imp.pas}
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

{$Include RefCounted.imp.pas}

{$Include RoundedControl.imp.pas}

end.
