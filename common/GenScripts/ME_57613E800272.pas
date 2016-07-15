unit K624690924;
 {* [Requestlink:624690924] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K624690924.pas"
// Стереотип: "TestCase"
// Элемент модели: "K624690924" MUID: (57613E800272)
// Имя типа: "TK624690924"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLwoCSS
;

type
 TK624690924 = class(TEVDtoHTMLwoCSS)
  {* [Requestlink:624690924] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK624690924
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK624690924.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK624690924.GetFolder

function TK624690924.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '57613E800272';
end;//TK624690924.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624690924.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
