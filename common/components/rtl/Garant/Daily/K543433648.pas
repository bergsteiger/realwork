unit K543433648;
 {* [Requestlink:543433648] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K543433648.pas"
// Стереотип: "TestCase"
// Элемент модели: "K543433648" MUID: (53A4207501E7)
// Имя типа: "TK543433648"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK543433648 = class(THTMLtoEVDTest)
  {* [Requestlink:543433648] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK543433648
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK543433648.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK543433648.GetFolder

function TK543433648.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53A4207501E7';
end;//TK543433648.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK543433648.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
