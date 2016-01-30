unit K616564654;
 {* [Requestlink:616564654] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K616564654.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDWithURLTest
;

type
 TK616564654 = class(THTMLtoEVDWithURLTest)
  {* [Requestlink:616564654] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK616564654
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK616564654.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK616564654.GetFolder

function TK616564654.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56A9DCBB0258';
end;//TK616564654.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616564654.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
