unit K371654285;
 {* [Requestlink:371654285] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K371654285.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK371654285 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:371654285] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK371654285
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK371654285.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK371654285.GetFolder

function TK371654285.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51ADD32A0065';
end;//TK371654285.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK371654285.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
