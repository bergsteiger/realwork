unit EverestLiteKeyWords;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestTestSupport"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/EverestLiteKeyWords.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::EverestLiteKeyWords
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  kwCreate,
  kwOpen,
  kwCloseActiveWindow,
  kwSaveWithOtherExtention,
  kwOpenWith,
  kwIsPreviewInProgress,
  archiEditorWindowWordsPack
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  
  ;

{$IfEnd} //InsiderTest AND nsTest
end.