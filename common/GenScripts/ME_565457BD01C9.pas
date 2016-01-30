unit K612077455;
 {* [Requestlink:612077455] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K612077455.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK612077455 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:612077455] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK612077455
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK612077455.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK612077455.GetFolder

function TK612077455.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '565457BD01C9';
end;//TK612077455.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK612077455.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
