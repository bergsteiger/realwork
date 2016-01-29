unit K425036023;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ArchiInsiderTests"
// Модуль: "w:/archi/source/projects/Archi/Tests/K425036023.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::ScrollTests::K425036023
//
// {Requestlink:425036023}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  ArchiInsiderTest
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TK425036023 = class(TArchiInsiderTest)
  {* [Requestlink:425036023] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK425036023
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK425036023

function TK425036023.GetFolder: AnsiString;
 {-}
begin
 Result := 'ScrollTests';
end;//TK425036023.GetFolder

function TK425036023.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5110BFC6038E';
end;//TK425036023.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK425036023.Suite);

end.