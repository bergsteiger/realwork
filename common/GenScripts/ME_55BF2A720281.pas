unit tfwTypeInfoList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoList.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

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
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;
{$IfEnd} // NOT Defined(NoScripts)

end.
