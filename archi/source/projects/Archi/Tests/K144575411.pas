unit K144575411;
 {* [Requestlink:144575411] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K144575411.pas"
// Стереотип: "TestCase"
// Элемент модели: "K144575411" MUID: (51F8F9B00364)
// Имя типа: "TK144575411"

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
 TK144575411 = class(TArchiInsiderTest)
  {* [Requestlink:144575411] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK144575411
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK144575411.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK144575411.GetFolder

function TK144575411.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51F8F9B00364';
end;//TK144575411.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK144575411.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
