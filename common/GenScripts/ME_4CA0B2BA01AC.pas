unit FailedTest;

// Модуль: "w:\common\components\rtl\Garant\TestForTFW\FailedTest.pas"
// Стереотип: "TestCase"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TFailedTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TFailedTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TFailedTest.DoIt;
//#UC START# *4CA0B2E40378_4CA0B2BA01AC_var*
//#UC END# *4CA0B2E40378_4CA0B2BA01AC_var*
begin
//#UC START# *4CA0B2E40378_4CA0B2BA01AC_impl*
 Check(false);
//#UC END# *4CA0B2E40378_4CA0B2BA01AC_impl*
end;//TFailedTest.DoIt

function TFailedTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TFWTests';
end;//TFailedTest.GetFolder

function TFailedTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA0B2BA01AC';
end;//TFailedTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TFailedTest.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
