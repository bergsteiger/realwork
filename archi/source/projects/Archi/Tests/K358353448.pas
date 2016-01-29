unit K358353448;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ArchiInsiderTests"
// Модуль: "w:/archi/source/projects/Archi/Tests/K358353448.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::BlockTest::TK358353448
//
// {Requestlink:358353448}
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
  ArchiInsiderTest
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TK358353448 = class(TArchiInsiderTest)
  {* [Requestlink:358353448] }
 protected
 // overridden protected methods
   function GetFolder: String; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: String; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK358353448
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK358353448

function TK358353448.GetFolder: String;
 {-}
begin
 Result := 'BlockTest';
end;//TK358353448.GetFolder

function TK358353448.GetModelElementGUID: String;
 {-}
begin
 Result := '4FB4DCB8020E';
end;//TK358353448.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK358353448.Suite);

end.