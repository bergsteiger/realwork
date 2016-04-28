unit F1AutoTestSuite;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1AutoTestSuite.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TF1AutoTestSuite" MUID: (4DC3FE5D03B4)

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTestSuiteWithDUnitSupport
;

type
 TF1AutoTestSuite = class(TAutoTestSuiteWithDUnitSupport)
  protected
   procedure DoReReadAbstractTests; override;
  public
   class procedure Register;
 end;//TF1AutoTestSuite
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , F1AutoScripter
 , TestFrameWork
;

class procedure TF1AutoTestSuite.Register;
//#UC START# *4DC40E2F00E3_4DC3FE5D03B4_var*
//#UC END# *4DC40E2F00E3_4DC3FE5D03B4_var*
begin
//#UC START# *4DC40E2F00E3_4DC3FE5D03B4_impl*
 TestFramework.RegisterTest(Self.Create(TF1AutoScripter));
//#UC END# *4DC40E2F00E3_4DC3FE5D03B4_impl*
end;//TF1AutoTestSuite.Register

procedure TF1AutoTestSuite.DoReReadAbstractTests;
//#UC START# *5040A3CE0118_4DC3FE5D03B4_var*
//#UC END# *5040A3CE0118_4DC3FE5D03B4_var*
begin
//#UC START# *5040A3CE0118_4DC3FE5D03B4_impl*
 AddTests(TF1AutoScripter);
//#UC END# *5040A3CE0118_4DC3FE5D03B4_impl*
end;//TF1AutoTestSuite.DoReReadAbstractTests
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
