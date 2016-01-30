unit K537768536;
 {* [Requestlink:537768536] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537768536.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK537768536 = class(THTMLtoEVDTest)
  {* [Requestlink:537768536] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK537768536
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK537768536.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK537768536.GetFolder

function TK537768536.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53843E030196';
end;//TK537768536.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537768536.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
