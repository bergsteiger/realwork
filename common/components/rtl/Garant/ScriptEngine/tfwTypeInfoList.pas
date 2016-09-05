unit tfwTypeInfoList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwTypeInfoList" MUID: (55BF2A720281)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwTypeInfoListPrim
;

type
 TtfwTypeInfoList = class(TtfwTypeInfoListPrim)
 end;//TtfwTypeInfoList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *55BF2A720281impl_uses*
 //#UC END# *55BF2A720281impl_uses*
;
{$IfEnd} // NOT Defined(NoScripts)

end.
