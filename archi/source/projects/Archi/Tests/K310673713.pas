unit K310673713;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ArchiInsiderTests"
// Модуль: "w:/archi/source/projects/Archi/Tests/K310673713.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::SBSTests::K310673713
//
// {Requestlink:310673713}
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
 TK310673713 = class(TArchiInsiderTest)
  {* [Requestlink:310673713] }
 protected
 // overridden protected methods
   function GetFolder: String; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: String; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK310673713
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK310673713

function TK310673713.GetFolder: String;
 {-}
begin
 Result := 'SBSTests';
end;//TK310673713.GetFolder

function TK310673713.GetModelElementGUID: String;
 {-}
begin
 Result := '4ED8723A007E';
end;//TK310673713.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK310673713.Suite);

end.