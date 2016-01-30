unit NOT_FINISHED_vtShockwaveFlashEx;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtShockwaveFlashEx.pas"
// Стереотип: "SimpleClass"

{$Include vtDefine.inc}

interface

{$If NOT Defined(NoFlash)}
uses
 l3IntfUses
;

type
 TvtShockwaveFlashEx = class
 end;//TvtShockwaveFlashEx
{$IfEnd} // NOT Defined(NoFlash)

implementation

{$If NOT Defined(NoFlash)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , vtFlashWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtShockwaveFlashEx);
 {* Регистрация TvtShockwaveFlashEx }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoFlash)

end.
