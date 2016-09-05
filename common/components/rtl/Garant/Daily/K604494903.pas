unit K604494903;
 {* [Requestlink:604494903] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K604494903.pas"
// Стереотип: "TestCase"
// Элемент модели: "K604494903" MUID: (55C1EE7D00A7)
// Имя типа: "TK604494903"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK604494903 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:604494903] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK604494903
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *55C1EE7D00A7impl_uses*
 //#UC END# *55C1EE7D00A7impl_uses*
;

function TK604494903.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK604494903.GetFolder

function TK604494903.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55C1EE7D00A7';
end;//TK604494903.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK604494903.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
