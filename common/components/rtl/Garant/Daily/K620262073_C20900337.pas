unit K620262073_C20900337;
 {* [RequestLink:620262073] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620262073_C20900337.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620262073_C20900337" MUID: (56F4166F00D5)
// Имя типа: "TK620262073_C20900337"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_C20900337 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620262073_C20900337
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_C20900337.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620262073_C20900337.GetFolder

function TK620262073_C20900337.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56F4166F00D5';
end;//TK620262073_C20900337.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_C20900337.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
