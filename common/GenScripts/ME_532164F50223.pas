unit K517783699;
 {* [Requestlink:517783699] }

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K517783699.pas"
// Стереотип: "TestCase"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK517783699 = class(TArchiInsiderTest)
  {* [Requestlink:517783699] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK517783699
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK517783699.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'PreivewTests';
end;//TK517783699.GetFolder

function TK517783699.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '532164F50223';
end;//TK517783699.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK517783699.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
