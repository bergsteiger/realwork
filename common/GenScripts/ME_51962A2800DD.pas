unit K453164226;
 {* [Requestlink:453164226] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K453164226.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK453164226 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:453164226] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK453164226
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK453164226.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK453164226.GetFolder

function TK453164226.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51962A2800DD';
end;//TK453164226.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK453164226.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
