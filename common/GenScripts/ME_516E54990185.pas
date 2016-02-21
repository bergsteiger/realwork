unit K449682598;
 {* [Requestlink:449682598] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K449682598.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK449682598 = class(THTMLtoEVDTest)
  {* [Requestlink:449682598] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK449682598
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK449682598.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK449682598.GetFolder

function TK449682598.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516E54990185';
end;//TK449682598.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK449682598.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
