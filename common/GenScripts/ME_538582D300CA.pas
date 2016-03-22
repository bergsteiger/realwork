unit K537974930;
 {* [Requestlink:537974930] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537974930.pas"
// Стереотип: "TestCase"
// Элемент модели: "K537974930" MUID: (538582D300CA)
// Имя типа: "TK537974930"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537974930 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537974930] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK537974930
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK537974930.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK537974930.GetFolder

function TK537974930.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '538582D300CA';
end;//TK537974930.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537974930.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
