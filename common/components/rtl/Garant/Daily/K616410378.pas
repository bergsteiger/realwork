unit K616410378;
 {* [Requestlink:616410378] - в ширину попадал символ #13 }

// Модуль: "w:\common\components\rtl\Garant\Daily\K616410378.pas"
// Стереотип: "TestCase"
// Элемент модели: "K616410378" MUID: (56B1B04203D9)
// Имя типа: "TK616410378"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK616410378 = class(THTMLtoEVDTest)
  {* [Requestlink:616410378] - в ширину попадал символ #13 }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK616410378
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK616410378.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK616410378.GetFolder

function TK616410378.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56B1B04203D9';
end;//TK616410378.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616410378.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
