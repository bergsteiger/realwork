unit K620262073_C20900337_2;
 {* [RequestLink:620262073] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620262073_C20900337_2.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620262073_C20900337_2" MUID: (56F420CE0115)
// Имя типа: "TK620262073_C20900337_2"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_C20900337_2 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620262073_C20900337_2
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56F420CE0115impl_uses*
 //#UC END# *56F420CE0115impl_uses*
;

function TK620262073_C20900337_2.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620262073_C20900337_2.GetFolder

function TK620262073_C20900337_2.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56F420CE0115';
end;//TK620262073_C20900337_2.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_C20900337_2.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
