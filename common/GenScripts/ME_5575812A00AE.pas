unit K600945017;
 {* [Requestlink:600945017] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K600945017.pas"
// Стереотип: "TestCase"
// Элемент модели: "K600945017" MUID: (5575812A00AE)
// Имя типа: "TK600945017"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK600945017 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:600945017] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK600945017
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK600945017.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK600945017.GetFolder

function TK600945017.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5575812A00AE';
end;//TK600945017.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK600945017.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
