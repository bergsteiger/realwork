unit K600665073;
 {* [Requestlink:600665073] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K600665073.pas"
// Стереотип: "TestCase"
// Элемент модели: "K600665073" MUID: (55718C49012D)
// Имя типа: "TK600665073"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK600665073 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:600665073] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK600665073
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK600665073.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK600665073.GetFolder

function TK600665073.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55718C49012D';
end;//TK600665073.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK600665073.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
