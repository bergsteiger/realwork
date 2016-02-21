unit K616227557;
 {* [Requestlink:616227557] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K616227557.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDWithURLTest
;

type
 TK616227557 = class(THTMLtoEVDWithURLTest)
  {* [Requestlink:616227557] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK616227557
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK616227557.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK616227557.GetFolder

function TK616227557.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56A6190500B2';
end;//TK616227557.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616227557.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
