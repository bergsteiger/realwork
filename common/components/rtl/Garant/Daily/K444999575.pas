unit K444999575;
 {* [Requestlink:444999575] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K444999575.pas"
// Стереотип: "TestCase"
// Элемент модели: "K444999575" MUID: (51551EC40046)
// Имя типа: "TK444999575"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK444999575 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:444999575] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK444999575
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK444999575.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK444999575.GetFolder

function TK444999575.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51551EC40046';
end;//TK444999575.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK444999575.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
