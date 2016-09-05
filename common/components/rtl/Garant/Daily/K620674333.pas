unit K620674333;
 {* [Requestlink:620674333] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620674333.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620674333" MUID: (56FE23890265)
// Имя типа: "TK620674333"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK620674333 = class(THTMLtoEVDTest)
  {* [Requestlink:620674333] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620674333
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56FE23890265impl_uses*
 //#UC END# *56FE23890265impl_uses*
;

function TK620674333.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK620674333.GetFolder

function TK620674333.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56FE23890265';
end;//TK620674333.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620674333.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
