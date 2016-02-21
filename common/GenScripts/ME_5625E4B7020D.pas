unit K607275587;
 {* [Requestlink:607275587] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K607275587.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607275587 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:607275587] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK607275587
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607275587.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK607275587.GetFolder

function TK607275587.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5625E4B7020D';
end;//TK607275587.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607275587.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
