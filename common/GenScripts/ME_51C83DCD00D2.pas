unit K462555833_1;
 {* [RequestLink:462555833] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K462555833_1.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK462555833_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:462555833] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK462555833_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK462555833_1.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK462555833_1.GetFolder

function TK462555833_1.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51C83DCD00D2';
end;//TK462555833_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK462555833_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
