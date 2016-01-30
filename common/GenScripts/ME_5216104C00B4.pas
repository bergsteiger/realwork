unit K477643230;
 {* [Requestlink:477643230] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K477643230.pas"
// Стереотип: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK477643230 = class(TArchiInsiderTest)
  {* [Requestlink:477643230] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK477643230
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK477643230.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK477643230.GetFolder

function TK477643230.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5216104C00B4';
end;//TK477643230.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK477643230.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
