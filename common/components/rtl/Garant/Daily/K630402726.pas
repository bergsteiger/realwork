unit K630402726;
 {* [Requestlink:630402726] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K630402726.pas"
// Стереотип: "TestCase"
// Элемент модели: "K630402726" MUID: (57DBC78600D1)
// Имя типа: "TK630402726"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK630402726 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:630402726] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK630402726
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *57DBC78600D1impl_uses*
 //#UC END# *57DBC78600D1impl_uses*
;

function TK630402726.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK630402726.GetFolder

function TK630402726.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '57DBC78600D1';
end;//TK630402726.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK630402726.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
