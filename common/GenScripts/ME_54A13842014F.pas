unit K585940757;
 {* [Requestlink:585940757] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K585940757.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK585940757 = class(THTMLtoEVDTest)
  {* [Requestlink:585940757] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK585940757
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK585940757.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK585940757.GetFolder

function TK585940757.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54A13842014F';
end;//TK585940757.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK585940757.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
