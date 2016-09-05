unit vtSpeedButton;

// Модуль: "w:\common\components\gui\Garant\VT\vtSpeedButton.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtSpeedButton" MUID: (4C43D65C0204)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
;

type
 TvtSpeedButton = class({$If NOT Defined(NoTB97)}
 TToolbarButton97
 {$IfEnd} // NOT Defined(NoTB97)
 )
 end;//TvtSpeedButton

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4C43D65C0204impl_uses*
 //#UC END# *4C43D65C0204impl_uses*
;

{$If NOT Defined(NoTB97)}
initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtSpeedButton);
 {* Регистрация TvtSpeedButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoTB97)

end.
