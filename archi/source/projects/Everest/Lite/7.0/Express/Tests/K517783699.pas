unit K517783699;
 {* [Requestlink:517783699] }

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K517783699.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517783699" MUID: (532164F50223)
// Имя типа: "TK517783699"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK517783699 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
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

{$If NOT Defined(NoScripts)}
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
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
