unit K620665614_C21100713;
 {* [RequestLink:620665614] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620665614_C21100713.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620665614_C21100713" MUID: (56FA6CE00222)
// Имя типа: "TK620665614_C21100713"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620665614_C21100713 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620665614] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620665614_C21100713
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620665614_C21100713.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620665614_C21100713.GetFolder

function TK620665614_C21100713.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56FA6CE00222';
end;//TK620665614_C21100713.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620665614_C21100713.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
