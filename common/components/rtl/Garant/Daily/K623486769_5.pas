unit K623486769_5;
 {* [Requestlink:623486769] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K623486769_5.pas"
// Стереотип: "TestCase"
// Элемент модели: "K623486769_5" MUID: (574EAFD002C5)
// Имя типа: "TK623486769_5"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK623486769_5 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:623486769] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK623486769_5
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *574EAFD002C5impl_uses*
 //#UC END# *574EAFD002C5impl_uses*
;

function TK623486769_5.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK623486769_5.GetFolder

function TK623486769_5.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '574EAFD002C5';
end;//TK623486769_5.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK623486769_5.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
