unit K601992686;
 {* [Requestlink:601992686] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K601992686.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK601992686 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:601992686] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK601992686
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK601992686.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK601992686.GetFolder

function TK601992686.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '558A7C3800B0';
end;//TK601992686.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK601992686.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
