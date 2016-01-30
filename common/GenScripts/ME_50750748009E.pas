unit K400531159;
 {* [Requestlink:400531159] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K400531159.pas"
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
 TK400531159 = class(TArchiInsiderTest)
  {* [Requestlink:400531159] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK400531159
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK400531159.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK400531159.GetFolder

function TK400531159.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50750748009E';
end;//TK400531159.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK400531159.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
