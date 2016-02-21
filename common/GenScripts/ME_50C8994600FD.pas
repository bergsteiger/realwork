unit K415728258;
 {* [Requestlink:415728258] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K415728258.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK415728258 = class(TNSRCtoEVDTest)
  {* [Requestlink:415728258] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK415728258
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK415728258.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK415728258.GetFolder

function TK415728258.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50C8994600FD';
end;//TK415728258.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK415728258.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
