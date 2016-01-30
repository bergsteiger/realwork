unit K587155634;
 {* [Requestlink:587155634] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K587155634.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK587155634 = class(THTMLtoEVDTest)
  {* [Requestlink:587155634] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK587155634
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK587155634.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK587155634.GetFolder

function TK587155634.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54CB4A7A00D6';
end;//TK587155634.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK587155634.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
