unit K606138650;
 {* [Requestlink:606138650] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K606138650.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606138650 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606138650] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK606138650
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606138650.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK606138650.GetFolder

function TK606138650.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55E03C6A019B';
end;//TK606138650.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606138650.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
