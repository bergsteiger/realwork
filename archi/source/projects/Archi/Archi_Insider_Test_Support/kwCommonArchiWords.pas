unit kwCommonArchiWords;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwCommonArchiWords.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::kwCommonArchiWords
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwMainFormFindDocuments,
  kwBaseExport,
  kwBaseRelCorrecter,
  kwPreview,
  kwSearchWinSaveDocumentList,
  kwMainFormClearHistory,
  kwEditorTextSaveAs,
  kwClearTemplateStorage,
  kwMainFormFormClose,
  kwDialogsLockDocumentGetSkipMode,
  kwDialogsLockDocumentSetSkipMode,
  AttributeExplorerWordsPack,
  tfwScriptingTypes
  ;

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
end.