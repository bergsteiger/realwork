unit K537232046;
 {* [Requestlink:537232046] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537232046.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537232046 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537232046] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK537232046
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK537232046.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK537232046.GetFolder

function TK537232046.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53917A1A02AE';
end;//TK537232046.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537232046.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
