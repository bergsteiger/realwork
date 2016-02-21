unit K602000766;
 {* [Requestlink:602000766] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K602000766.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK602000766 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:602000766] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK602000766
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK602000766.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK602000766.GetFolder

function TK602000766.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '558A7CAF0101';
end;//TK602000766.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK602000766.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
