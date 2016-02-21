unit K440434932;
 {* [Requestlink:440434932] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K440434932.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK440434932 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:440434932] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK440434932
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK440434932.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK440434932.GetFolder

function TK440434932.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '514C25F3010A';
end;//TK440434932.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK440434932.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
