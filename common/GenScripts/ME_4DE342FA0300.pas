unit ArchiAutoTestSuite;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiAutoTestSuite.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomAutoTestsSuite
;

type
 TArchiAutoTestSuite = class(TCustomAutoTestSuite)
  protected
   procedure DoReReadAbstractTests; override;
  public
   class procedure Register;
 end;//TArchiAutoTestSuite
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ArchiAutoTest
 , TestFrameWork
 {$If NOT Defined(NoVCL)}
 , kwKeyWordsPack
 {$IfEnd} // NOT Defined(NoVCL)
 , kwArchiEverestWordsPack
 , l3ComponentInfoHelper
;

class procedure TArchiAutoTestSuite.Register;
//#UC START# *4DE368140094_4DE342FA0300_var*
//#UC END# *4DE368140094_4DE342FA0300_var*
begin
//#UC START# *4DE368140094_4DE342FA0300_impl*
 TestFramework.RegisterTest(Self.Create(TArchiAutoTest));
//#UC END# *4DE368140094_4DE342FA0300_impl*
end;//TArchiAutoTestSuite.Register

procedure TArchiAutoTestSuite.DoReReadAbstractTests;
//#UC START# *5040A3CE0118_4DE342FA0300_var*
//#UC END# *5040A3CE0118_4DE342FA0300_var*
begin
//#UC START# *5040A3CE0118_4DE342FA0300_impl*
 AddTests(TArchiAutoTest);
//#UC END# *5040A3CE0118_4DE342FA0300_impl*
end;//TArchiAutoTestSuite.DoReReadAbstractTests
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
