unit NOT_FINISHED_vtRadioButton;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtRadioButton.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 _vtUnicodeButtonControl_Parent_ = TRadioButton;
 {$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.imp.pas}
 TvtRadioButton = class(_vtUnicodeButtonControl_)
 end;//TvtRadioButton

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtRadioButton);
 {* Регистрация TvtRadioButton }
{$IfEnd} // NOT Defined(NoScripts)

end.
