unit AdminTestRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/AdminTestRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMTestApplication::Class>> F1 ���������� ����� ��������������::Admin::AdminTest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(Admin) AND defined(InsiderTest) AND defined(nsTest)}
uses
  AdminAppRes,
  GUITestRunner
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
  ,
  tfwScriptDebugger
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts AND not NotTunedDUnit
  ,
  Classes {a},
  vcmInterfaces {a},
  vcmExternalInterfaces {a}
  ;
{$IfEnd} //Admin AND InsiderTest AND nsTest

{$If defined(Admin) AND defined(InsiderTest) AND defined(nsTest)}
type
 _VCMAppTester_Parent_ = TAdminAppRes;
 {$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}
 TAdminTestRes = {final} class(_VCMAppTester_)
 public
 // realized methods
   class function CalcBatchMode: Boolean; override;
 end;//TAdminTestRes
 TvcmApplicationRef = TAdminTestRes;
  {* ������ �� ���������� ��� DesignTime ���������� }

{$IfEnd} //Admin AND InsiderTest AND nsTest

implementation

{$If defined(Admin) AND defined(InsiderTest) AND defined(nsTest)}
uses
  toKAdmin
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  l3Base,
  l3ComponentInfoHelper
  {$If not defined(NoScripts)}
  ,
  afwAnswer
  {$IfEnd} //not NoScripts
  ,
  TestFrameWork
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineEX
  {$IfEnd} //not NoScripts
  ,
  l3BatchService
  ;
{$IfEnd} //Admin AND InsiderTest AND nsTest

{$If defined(Admin) AND defined(InsiderTest) AND defined(nsTest)}

{$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}

// start class TAdminTestRes

class function TAdminTestRes.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_5123A74700E2_var*
//#UC END# *4F79BCC902C5_5123A74700E2_var*
begin
//#UC START# *4F79BCC902C5_5123A74700E2_impl*
 Result := KTestRunner.NeedKTestRunner([TtoKAdmin]);
//#UC END# *4F79BCC902C5_5123A74700E2_impl*
end;//TAdminTestRes.CalcBatchMode

{$IfEnd} //Admin AND InsiderTest AND nsTest

end.