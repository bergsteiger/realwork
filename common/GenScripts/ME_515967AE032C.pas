unit K437519128;
 {* [Requestlink:437519128] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K437519128.pas"
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
 TK437519128 = class(TArchiInsiderTest)
  {* [Requestlink:437519128] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK437519128
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK437519128.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK437519128.GetFolder

function TK437519128.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '515967AE032C';
end;//TK437519128.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK437519128.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
