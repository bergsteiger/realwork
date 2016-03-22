unit K608627000;
 {* [RequestLink:608627000] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K608627000.pas"
// Стереотип: "TestCase"
// Элемент модели: "K608627000" MUID: (561E6ACA013F)
// Имя типа: "TK608627000"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK608627000 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:608627000] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK608627000
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK608627000.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK608627000.GetFolder

function TK608627000.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561E6ACA013F';
end;//TK608627000.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608627000.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
