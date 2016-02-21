unit K336664105;
 {* [RequestLink:336664105] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K336664105.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK336664105 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:336664105] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK336664105
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336664105.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK336664105.GetFolder

function TK336664105.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F4CC311038D';
end;//TK336664105.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336664105.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
