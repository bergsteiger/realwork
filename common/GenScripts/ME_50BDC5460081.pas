unit K408654725;
 {* [RequestLink:408654725] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K408654725.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK408654725 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:408654725] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK408654725
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK408654725.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK408654725.GetFolder

function TK408654725.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50BDC5460081';
end;//TK408654725.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK408654725.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
