unit K615706665;
 {* [Requestlink:615706665] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K615706665.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK615706665 = class(THTMLtoEVDTest)
  {* [Requestlink:615706665] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK615706665
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK615706665.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK615706665.GetFolder

function TK615706665.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56A0792802FF';
end;//TK615706665.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK615706665.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
