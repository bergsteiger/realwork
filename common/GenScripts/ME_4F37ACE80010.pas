unit CompilationPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\CompilationPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "CompilationPack" MUID: (4F37ACE80010)

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
 , kwFORWARD
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
