unit K226006206;
 {* [RequestLink:226006206] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K226006206.pas"
// Стереотип: "TestCase"
// Элемент модели: "K226006206" MUID: (4C73E85C02D6)
// Имя типа: "TK226006206"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK226006206 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:226006206] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK226006206
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK226006206.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK226006206.GetFolder

function TK226006206.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C73E85C02D6';
end;//TK226006206.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226006206.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
