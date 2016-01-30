unit NOT_FINISHED_vcmControl;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmControl.pas"
// Стереотип: "GuiControl"

{$Include vcmDefine.inc}

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
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmControl);
 {* Регистрация TvcmControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
