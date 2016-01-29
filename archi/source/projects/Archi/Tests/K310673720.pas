unit K310673720;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ArchiInsiderTests"
// Модуль: "w:/archi/source/projects/Archi/Tests/K310673720.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::SBSTests::K310673720
//
// {RequestLink:310673720}
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
 TK310673720 = class(TArchiInsiderTest)
  {* [RequestLink:310673720] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK310673720
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK310673720

function TK310673720.GetFolder: AnsiString;
 {-}
begin
 Result := 'SBSTests';
end;//TK310673720.GetFolder

function TK310673720.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4ED7818400C7';
end;//TK310673720.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK310673720.Suite);

end.