unit K290266820;
 {* [RequestLink:290266820] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K290266820.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK290266820 = class(TAutoTest)
  {* [RequestLink:290266820] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK290266820
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK290266820.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScriptTest';
end;//TK290266820.GetFolder

function TK290266820.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F15696B0227';
end;//TK290266820.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK290266820.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
