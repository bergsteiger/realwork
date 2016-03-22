unit K606129412;
 {* [Requestlink:606129412] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K606129412.pas"
// Стереотип: "TestCase"
// Элемент модели: "K606129412" MUID: (55EEDF480240)
// Имя типа: "TK606129412"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606129412 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606129412] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK606129412
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606129412.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK606129412.GetFolder

function TK606129412.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55EEDF480240';
end;//TK606129412.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606129412.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
