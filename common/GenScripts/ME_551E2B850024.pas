unit K595976509;
 {* [Requestlink:595976509] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K595976509.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK595976509 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:595976509] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK595976509
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK595976509.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK595976509.GetFolder

function TK595976509.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '551E2B850024';
end;//TK595976509.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK595976509.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
