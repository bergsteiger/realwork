unit K358975616;
 {* [Requestlink:358975616] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358975616.pas"
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
 TK358975616 = class(TArchiInsiderTest)
  {* [Requestlink:358975616] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358975616
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358975616.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK358975616.GetFolder

function TK358975616.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F9912860108';
end;//TK358975616.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358975616.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
