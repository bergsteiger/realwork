unit QueryCardProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\QueryCardProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "QueryCardProcessingPack" MUID: (4F6995330222)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwPopQueryCardAttributeSetWithLogicOperation
 , kwPopQueryCardSetAttribute
 , kwPopQueryCardAttributeSetCollapsed
 , kwPopQueryCardAttributeSetFocus
 , kwPopQueryCardAttributeGetFocus
 , kwPopQueryCardAttributeGetCollapsed
 , kwPopQueryCardAttributeGetLogicOperation
 , kwPopQueryCardAttributeIsLogicOperationEnabled
 , kwPopQueryCardGetCurrentReqName
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4F6995330222impl_uses*
 //#UC END# *4F6995330222impl_uses*
;
{$IfEnd} // NOT Defined(NoScripts)

end.
