unit NOT_FINISHED_vcmControl;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmControl.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvcmControl" MUID: (5028DFB00090)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , afwCustomCommonControl
;

type
 TvcmControl = class(TafwCustomCommonControl)
 end;//TvcmControl
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *5028DFB00090impl_uses*
 //#UC END# *5028DFB00090impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmControl);
 {* Регистрация TvcmControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
