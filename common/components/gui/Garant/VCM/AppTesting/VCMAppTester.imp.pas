{$IfNDef VCMAppTester_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$ Applications Testing"
// ������: "w:/common/components/gui/Garant/VCM/AppTesting/VCMAppTester.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Testing Framework::VCM$ Applications Testing::AppTestingSupport::VCMAppTester
//
// ������� ��� ������������ ����������, ����������� �� VCM
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define VCMAppTester_imp}
{$If defined(InsiderTest) AND defined(nsTest)}
 _GUIAppTester_Parent_ = _VCMAppTester_Parent_;
 {$Include w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas}
 _VCMAppTester_ = {abstract mixin} class(_GUIAppTester_)
  {* ������� ��� ������������ ����������, ����������� �� VCM }
 protected
 // overridden protected methods
    {$If not defined(NoVCM)}
   class procedure BeforeApplicationRun; override;
    {$IfEnd} //not NoVCM
 end;//_VCMAppTester_
{$Else}

 _GUIAppTester_Parent_ = _VCMAppTester_Parent_;
 {$Include w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas}
 _VCMAppTester_ = _GUIAppTester_;

{$IfEnd} //InsiderTest AND nsTest

{$Else VCMAppTester_imp}

{$If defined(InsiderTest) AND defined(nsTest)}

{$Include w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas}

// start class _VCMAppTester_

{$If not defined(NoVCM)}
class procedure _VCMAppTester_.BeforeApplicationRun;
//#UC START# *52F2269B0373_4F79CD9F015F_var*
//#UC END# *52F2269B0373_4F79CD9F015F_var*
begin
//#UC START# *52F2269B0373_4F79CD9F015F_impl*
 ReadyToRun;
//#UC END# *52F2269B0373_4F79CD9F015F_impl*
end;//_VCMAppTester_.BeforeApplicationRun
{$IfEnd} //not NoVCM

{$IfEnd} //InsiderTest AND nsTest

{$EndIf VCMAppTester_imp}
