unit K458072971;
 {* [Requestlink:458072971] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K458072971.pas"
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
 TK458072971 = class(TArchiInsiderTest)
  {* [Requestlink:458072971] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK458072971
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK458072971.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK458072971.GetFolder

function TK458072971.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51A4608F021D';
end;//TK458072971.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK458072971.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
