unit K620262073_C20900337_4;
 {* [RequestLink:620262073] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620262073_C20900337_4.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620262073_C20900337_4" MUID: (56F474030233)
// Имя типа: "TK620262073_C20900337_4"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_C20900337_4 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620262073_C20900337_4
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_C20900337_4.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620262073_C20900337_4.GetFolder

function TK620262073_C20900337_4.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56F474030233';
end;//TK620262073_C20900337_4.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_C20900337_4.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
