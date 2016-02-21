unit K493324121;
 {* [Requestlink:493324121] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K493324121.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK493324121 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:493324121] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK493324121
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK493324121.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK493324121.GetFolder

function TK493324121.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5260E08F0378';
end;//TK493324121.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK493324121.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
