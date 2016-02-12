{$IfNDef VCMAppTester_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas"
// Стереотип: "Impurity"

{$Define VCMAppTester_imp}

{$If Defined(nsTest) AND Defined(InsiderTest)}
 _GUIAppTester_Parent_ = _VCMAppTester_Parent_;
 {$Include w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas}
 _VCMAppTester_ = {abstract} class(_GUIAppTester_)
  {* Примесь для тестирования приложений, построенных на VCM }
  protected
   {$If NOT Defined(NoVCM)}
   class procedure BeforeApplicationRun; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_VCMAppTester_

{$Else Defined(nsTest) AND Defined(InsiderTest)}

_GUIAppTester_Parent_ = _VCMAppTester_Parent_;
{$Include w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas}
_VCMAppTester_ = _GUIAppTester_;

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
{$Else VCMAppTester_imp}

{$IfNDef VCMAppTester_imp_impl}

{$Define VCMAppTester_imp_impl}

{$If Defined(nsTest) AND Defined(InsiderTest)}
{$Include w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas}

{$If NOT Defined(NoVCM)}
class procedure _VCMAppTester_.BeforeApplicationRun;
//#UC START# *52F2269B0373_4F79CD9F015F_var*
//#UC END# *52F2269B0373_4F79CD9F015F_var*
begin
//#UC START# *52F2269B0373_4F79CD9F015F_impl*
 ReadyToRun;
//#UC END# *52F2269B0373_4F79CD9F015F_impl*
end;//_VCMAppTester_.BeforeApplicationRun
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
{$EndIf VCMAppTester_imp_impl}

{$EndIf VCMAppTester_imp}

