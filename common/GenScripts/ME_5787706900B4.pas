unit K627006470;
 {* [Requestlink:627006470] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K627006470.pas"
// Стереотип: "TestCase"
// Элемент модели: "K627006470" MUID: (5787706900B4)
// Имя типа: "TK627006470"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK627006470 = class(THTMLtoEVDFull)
  {* [Requestlink:627006470] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK627006470
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK627006470.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK627006470.GetFolder

function TK627006470.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5787706900B4';
end;//TK627006470.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK627006470.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
