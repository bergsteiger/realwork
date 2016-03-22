unit K452374409;
 {* [Requestlink:452374409] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K452374409.pas"
// Стереотип: "TestCase"
// Элемент модели: "K452374409" MUID: (517A3CC10135)
// Имя типа: "TK452374409"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK452374409 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:452374409] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK452374409
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK452374409.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK452374409.GetFolder

function TK452374409.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '517A3CC10135';
end;//TK452374409.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK452374409.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
