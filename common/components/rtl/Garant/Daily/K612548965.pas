unit K612548965;
 {* [Requestlink:612548965] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K612548965.pas"
// Стереотип: "TestCase"
// Элемент модели: "K612548965" MUID: (565EB4980024)
// Имя типа: "TK612548965"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK612548965 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:612548965] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK612548965
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK612548965.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK612548965.GetFolder

function TK612548965.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '565EB4980024';
end;//TK612548965.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK612548965.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
