unit K596385658;
 {* [Requestlink:596385658] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K596385658.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK596385658 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:596385658] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK596385658
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK596385658.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK596385658.GetFolder

function TK596385658.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '552BA2D60363';
end;//TK596385658.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK596385658.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
