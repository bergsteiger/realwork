unit K619724818;
 {* [Requestlink:619724818] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619724818.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK619724818 = class(THTMLtoEVDFull)
  {* [Requestlink:619724818] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619724818
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619724818.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619724818.GetFolder

function TK619724818.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E69259026C';
end;//TK619724818.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619724818.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
