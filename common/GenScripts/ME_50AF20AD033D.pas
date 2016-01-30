unit K409747548;
 {* [Requestlink:409747548] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K409747548.pas"
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
 TK409747548 = class(TArchiInsiderTest)
  {* [Requestlink:409747548] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK409747548
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK409747548.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK409747548.GetFolder

function TK409747548.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50AF20AD033D';
end;//TK409747548.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK409747548.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
