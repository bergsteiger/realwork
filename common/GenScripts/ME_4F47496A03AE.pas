unit K341082326;
 {* [Requestlink:341082326] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K341082326.pas"
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
 TK341082326 = class(TArchiInsiderTest)
  {* [Requestlink:341082326] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK341082326
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK341082326.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK341082326.GetFolder

function TK341082326.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F47496A03AE';
end;//TK341082326.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK341082326.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
