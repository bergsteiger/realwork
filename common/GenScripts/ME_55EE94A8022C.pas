unit K606634250;
 {* [Requestlink:606634250] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K606634250.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606634250 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606634250] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK606634250
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606634250.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK606634250.GetFolder

function TK606634250.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55EE94A8022C';
end;//TK606634250.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606634250.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
