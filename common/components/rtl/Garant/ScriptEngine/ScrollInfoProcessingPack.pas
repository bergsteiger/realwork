unit ScrollInfoProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ScrollInfoProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ScrollInfoProcessingPack" MUID: (54F5C3C70126)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , kwPopControlScrollInfo
 , kwPopControlScrollInfoMin
 , kwPopControlScrollInfoMax
 , kwPopControlScrollInfoPageSize
 , kwPopControlScrollInfoPosition
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *54F5C3C70126impl_uses*
 //#UC END# *54F5C3C70126impl_uses*
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
