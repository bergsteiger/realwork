unit RegisterVcmControls;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\RegisterVcmControls.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmMenuManager
 {$If NOT Defined(NoTB97)}
 , TB97Tlbr
 {$IfEnd} // NOT Defined(NoTB97)
 , vcmToolbar
 , tfwClassRef
 , elCustomButtonEdit
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtNavigator
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineForm
 {$IfEnd} // NOT Defined(NoVGScene)
;

initialization
//#UC START# *52B16BBF00B4*
 TtfwClassRef.Register(TCustomUpDown);
//#UC END# *52B16BBF00B4*
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
