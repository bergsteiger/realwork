unit K502351620;
 {* [RequestLink:502351620] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K502351620.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK502351620 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:502351620] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK502351620
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK502351620.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK502351620.GetFolder

function TK502351620.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '52861957036B';
end;//TK502351620.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK502351620.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
