unit K605843892;
 {* [Requestlink:605843892] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K605843892.pas"
// Стереотип: "TestCase"
// Элемент модели: "K605843892" MUID: (55D726B80326)
// Имя типа: "TK605843892"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK605843892 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:605843892] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK605843892
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK605843892.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK605843892.GetFolder

function TK605843892.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55D726B80326';
end;//TK605843892.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK605843892.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
