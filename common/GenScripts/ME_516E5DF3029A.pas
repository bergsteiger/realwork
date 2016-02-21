unit K336662790;
 {* [Requestlink:336662790] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K336662790.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK336662790 = class(THTMLtoEVDTest)
  {* [Requestlink:336662790] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK336662790
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336662790.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK336662790.GetFolder

function TK336662790.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516E5DF3029A';
end;//TK336662790.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336662790.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
