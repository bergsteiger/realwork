unit F1AutoTestSuite;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 AutoTests"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_AutoTests/F1AutoTestSuite.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ��������� ������::F1 AutoTests::AutoTests::TF1AutoTestSuite
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  AutoTestSuiteWithDUnitSupport
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TF1AutoTestSuite = class(TAutoTestSuiteWithDUnitSupport)
 protected
 // overridden protected methods
   procedure DoReReadAbstractTests; override;
     {* ��������� ������ DoReReadAbstractTests }
 public
 // public methods
   class procedure Register;
 end;//TF1AutoTestSuite
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  F1AutoScripter,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TF1AutoTestSuite

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

{$IfEnd} //nsTest AND not NoScripts

end.