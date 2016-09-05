unit K537768536;
 {* [Requestlink:537768536] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537768536.pas"
// Стереотип: "TestCase"
// Элемент модели: "K537768536" MUID: (53843E030196)
// Имя типа: "TK537768536"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

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
 //#UC START# *53843E030196impl_uses*
 //#UC END# *53843E030196impl_uses*
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
