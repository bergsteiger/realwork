unit tfwTypeInfoList;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoList.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwTypeInfoList" MUID: (55BF2A720281)

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
;
{$IfEnd} // NOT Defined(NoScripts)

end.
