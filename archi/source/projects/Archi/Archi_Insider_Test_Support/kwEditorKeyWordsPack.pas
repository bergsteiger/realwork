unit kwEditorKeyWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwEditorKeyWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$TestSupport::Archi Insider Test Support::EditorKeyWords::kwEditorKeyWordsPack
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwPopEditorEditFormula,
  kwPopEditorAlignCellsBoundary,
  kwPopEditorSetStyle2Block,
  kwPopEditorInsertFormula,
  kwPushMainForm,
  kwPopEditorSetStyle2Table,
  tfwScriptingTypes
  ;

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts
end.