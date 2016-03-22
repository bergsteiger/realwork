unit K430740658;
 {* [Requestlink:430740658] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K430740658.pas"
// Стереотип: "TestCase"
// Элемент модели: "K430740658" MUID: (512481A202F2)
// Имя типа: "TK430740658"

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
 TK430740658 = class(TArchiInsiderTest)
  {* [Requestlink:430740658] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK430740658
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK430740658.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'MacrosTest';
end;//TK430740658.GetFolder

function TK430740658.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '512481A202F2';
end;//TK430740658.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK430740658.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
