unit K620262073_D910n0036915;
 {* [RequestLink:620262073] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620262073_D910n0036915.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620262073_D910n0036915" MUID: (56F4169F0104)
// Имя типа: "TK620262073_D910n0036915"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_D910n0036915 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620262073_D910n0036915
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_D910n0036915.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620262073_D910n0036915.GetFolder

function TK620262073_D910n0036915.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56F4169F0104';
end;//TK620262073_D910n0036915.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_D910n0036915.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
