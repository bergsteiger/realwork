unit K541895041;
 {* [Requestlink:541895041] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K541895041.pas"
// Стереотип: "TestCase"
// Элемент модели: "K541895041" MUID: (53984D810366)
// Имя типа: "TK541895041"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK541895041 = class(THTMLtoEVDTest)
  {* [Requestlink:541895041] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK541895041
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK541895041.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK541895041.GetFolder

function TK541895041.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53984D810366';
end;//TK541895041.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK541895041.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
