unit K615938312;
 {* [RequestLink:615938312] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K615938312.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK615938312 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:615938312] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK615938312
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK615938312.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK615938312.GetFolder

function TK615938312.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E7C06600D9';
end;//TK615938312.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK615938312.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
