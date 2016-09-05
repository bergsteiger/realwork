unit NOT_FINISHED_ElXPThemedControl;

// Модуль: "w:\common\components\gui\Garant\VT\elClone\Source\NOT_FINISHED_ElXPThemedControl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TElXPThemedControl" MUID: (52B993FB000A)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , afwCustomCommonControl
;

type
 TElXPThemedControl = class(TafwCustomCommonControl)
 end;//TElXPThemedControl

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *52B993FB000Aimpl_uses*
 //#UC END# *52B993FB000Aimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TElXPThemedControl);
 {* Регистрация TElXPThemedControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
