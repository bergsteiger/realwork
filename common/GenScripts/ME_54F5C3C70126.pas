unit ScrollInfoProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ScrollInfoProcessingPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include seDefine.inc}

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
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
