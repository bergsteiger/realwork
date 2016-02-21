unit QueryCardProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\QueryCardProcessingPack.pas"
// ���������: "ScriptKeywordsPack"

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
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
