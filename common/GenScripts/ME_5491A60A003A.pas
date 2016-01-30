unit K585129079_NSRC;
 {* [RequestLink:585129079] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K585129079_NSRC.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK585129079_NSRC = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:585129079] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK585129079_NSRC
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK585129079_NSRC.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK585129079_NSRC.GetFolder

function TK585129079_NSRC.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5491A60A003A';
end;//TK585129079_NSRC.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK585129079_NSRC.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
