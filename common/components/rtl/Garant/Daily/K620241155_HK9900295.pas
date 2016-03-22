unit K620241155_HK9900295;
 {* [RequestLink:620241155] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620241155_HK9900295.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620241155_HK9900295" MUID: (56F13568025C)
// Имя типа: "TK620241155_HK9900295"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620241155_HK9900295 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620241155] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620241155_HK9900295
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620241155_HK9900295.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620241155_HK9900295.GetFolder

function TK620241155_HK9900295.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56F13568025C';
end;//TK620241155_HK9900295.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620241155_HK9900295.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
