unit K620241155_Hk0800412;
 {* [RequestLink:620241155] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620241155_Hk0800412.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620241155_Hk0800412" MUID: (56F1354A0235)
// Имя типа: "TK620241155_Hk0800412"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620241155_Hk0800412 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620241155] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620241155_Hk0800412
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620241155_Hk0800412.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620241155_Hk0800412.GetFolder

function TK620241155_Hk0800412.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56F1354A0235';
end;//TK620241155_Hk0800412.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620241155_Hk0800412.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
