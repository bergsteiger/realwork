unit NOT_FINISHED_vtRadioButton;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtRadioButton.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtRadioButton" MUID: (517941E500BF)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

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
 //#UC START# *517941E500BFimpl_uses*
 //#UC END# *517941E500BFimpl_uses*
;

{$If NOT Defined(NoVCL)}
{$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtRadioButton);
 {* Регистрация TvtRadioButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
