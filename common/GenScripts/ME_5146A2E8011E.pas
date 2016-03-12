unit K437519030;
 {* [Requestlink:437519030] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K437519030.pas"
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
 TK437519030 = class(TArchiInsiderTest)
  {* [Requestlink:437519030] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK437519030
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK437519030.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableResize';
end;//TK437519030.GetFolder

function TK437519030.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5146A2E8011E';
end;//TK437519030.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK437519030.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
