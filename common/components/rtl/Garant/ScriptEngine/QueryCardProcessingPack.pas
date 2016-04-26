unit QueryCardProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\QueryCardProcessingPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "QueryCardProcessingPack" MUID: (4F6995330222)

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
 , tfwTypeRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
