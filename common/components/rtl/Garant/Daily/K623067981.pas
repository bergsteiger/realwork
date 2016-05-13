unit K623067981;
 {* [Requestlink:623067981] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K623067981.pas"
// Стереотип: "TestCase"
// Элемент модели: "K623067981" MUID: (5735925800E1)
// Имя типа: "TK623067981"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLwoCSS
;

type
 TK623067981 = class(TEVDtoHTMLwoCSS)
  {* [Requestlink:623067981] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK623067981
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK623067981.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK623067981.GetFolder

function TK623067981.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5735925800E1';
end;//TK623067981.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK623067981.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
