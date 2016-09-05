unit NOT_FINISHED_vtShockwaveFlashEx;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtShockwaveFlashEx.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvtShockwaveFlashEx" MUID: (4981A4AE0282)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , vtFlashWordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4981A4AE0282impl_uses*
 //#UC END# *4981A4AE0282impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtShockwaveFlashEx);
 {* Регистрация TvtShockwaveFlashEx }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoFlash)

end.
