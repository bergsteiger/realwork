unit kwEditorKeyWordsPack;

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorKeyWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "kwEditorKeyWordsPack" MUID: (4F5DA0BF025A)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwPopEditorEditFormula
 , kwPopEditorAlignCellsBoundary
 , kwPopEditorSetStyle2Block
 , kwPopEditorInsertFormula
 , kwPushMainForm
 , kwPopEditorSetStyle2Table
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
