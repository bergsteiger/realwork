unit K400523879;
 {* [Requestlink:400523879] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K400523879.pas"
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
 TK400523879 = class(TArchiInsiderTest)
  {* [Requestlink:400523879] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK400523879
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK400523879.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'InnerTable';
end;//TK400523879.GetFolder

function TK400523879.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '506EA7BD01AB';
end;//TK400523879.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK400523879.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
