unit K103942050;
 {* [Requestlink:103942050] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K103942050.pas"
// Стереотип: "TestCase"
// Элемент модели: "K103942050" MUID: (529DA88400C3)
// Имя типа: "TK103942050"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK103942050 = class(THTMLtoEVDTest)
  {* [Requestlink:103942050] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK103942050
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK103942050.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK103942050.GetFolder

function TK103942050.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '529DA88400C3';
end;//TK103942050.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK103942050.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
