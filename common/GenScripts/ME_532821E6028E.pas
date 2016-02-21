unit K515524193;
 {* [Requestlink:515524193] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K515524193.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK515524193 = class(TArchiInsiderTest)
  {* [Requestlink:515524193] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK515524193
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK515524193.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK515524193.GetFolder

function TK515524193.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '532821E6028E';
end;//TK515524193.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK515524193.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
