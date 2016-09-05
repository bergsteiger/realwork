unit NOT_FINISHED_eeCheckBox;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_eeCheckBox.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TeeCheckBox" MUID: (4AC5E484002C)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 TeeCheckBox = class
 end;//TeeCheckBox

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4AC5E484002Cimpl_uses*
 //#UC END# *4AC5E484002Cimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeCheckBox);
 {* Регистрация TeeCheckBox }
{$IfEnd} // NOT Defined(NoScripts)

end.
