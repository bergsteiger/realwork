unit EverestLiteKeyWords;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestTestSupport"
// Модуль: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/EverestLiteKeyWords.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::EverestLiteKeyWords
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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