unit IncludesAndUsesPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\IncludesAndUsesPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "IncludesAndUsesPack" MUID: (4F476424014E)

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
 , kwInclude
 , kwUses
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
