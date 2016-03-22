unit K210043160;
 {* [RequestLink:210043160] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210043160.pas"
// Стереотип: "TestCase"
// Элемент модели: "K210043160" MUID: (4BE2C475019D)
// Имя типа: "TK210043160"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK210043160 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:210043160] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK210043160
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210043160.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210043160.GetFolder

function TK210043160.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE2C475019D';
end;//TK210043160.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210043160.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
