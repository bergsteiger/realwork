unit K290951357;
 {* [RequestLink:290951357] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K290951357.pas"
// Стереотип: "TestCase"
// Элемент модели: "K290951357" MUID: (4F1569B6019A)
// Имя типа: "TK290951357"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK290951357 = class(TAutoTest)
  {* [RequestLink:290951357] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK290951357
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F1569B6019Aimpl_uses*
 //#UC END# *4F1569B6019Aimpl_uses*
;

function TK290951357.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScriptTest';
end;//TK290951357.GetFolder

function TK290951357.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F1569B6019A';
end;//TK290951357.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK290951357.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
