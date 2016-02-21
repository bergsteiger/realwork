unit K480825135;
 {* [Requestlink:480825135] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K480825135.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK480825135 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:480825135] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK480825135
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK480825135.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK480825135.GetFolder

function TK480825135.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '523AC3E40022';
end;//TK480825135.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK480825135.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
