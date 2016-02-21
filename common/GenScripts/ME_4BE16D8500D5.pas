unit K209584396;
 {* [RequestLink:209584396] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K209584396.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK209584396 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:209584396] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK209584396
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK209584396.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK209584396.GetFolder

function TK209584396.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE16D8500D5';
end;//TK209584396.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK209584396.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
