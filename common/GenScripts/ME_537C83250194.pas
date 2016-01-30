unit K535902713;
 {* [Requestlink:535902713] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K535902713.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK535902713 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:535902713] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK535902713
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK535902713.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK535902713.GetFolder

function TK535902713.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '537C83250194';
end;//TK535902713.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK535902713.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
