unit EverestLiteTestSuite;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestInsiderTests"
// Модуль: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestInsiderTests/EverestLiteTestSuite.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$EverestLite$TestSupport::EverestInsiderTests::EverestLiteInsiderTest::TEverestLiteTestSuite
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  ArchiAutoTestSuite
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TEverestLiteTestSuite = class(TArchiAutoTestSuite)
 end;//TEverestLiteTestSuite
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  SysUtils
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  EverestLiteKeyWords
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwEditorKeyWordsPack
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwArchiEverestWordsPack
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}


{$IfEnd} //InsiderTest AND nsTest
end.