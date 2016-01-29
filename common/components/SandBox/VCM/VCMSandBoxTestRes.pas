unit VCMSandBoxTestRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "VCMSandBoxTestRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: VCMTestApplication::Class Shared Delphi Sand Box$TestApp::VCMSandBox::VCMSandBoxTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\VCM\sbtDefine.inc}

interface

uses
  VCMSandBoxRes
  {$If defined(nsTest)}
  ,
  GUITestRunner
  {$IfEnd} //nsTest
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
  ,
  tfwScriptDebugger
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts AND not NotTunedDUnit
  ,
  Classes {a},
  vcmInterfaces {a},
  vcmExternalInterfaces {a}
  ;

type
 _VCMAppTester_Parent_ = TVCMSandBoxRes;
 {$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}
 TVCMSandBoxTestRes = {final} class(_VCMAppTester_)
 public
 // realized methods
    {$If defined(nsTest)}
   class function CalcBatchMode: Boolean; override;
    {$IfEnd} //nsTest
 end;//TVCMSandBoxTestRes
 TvcmApplicationRef = TVCMSandBoxTestRes;
  {* Ссылка на приложение для DesignTime редакторов }


implementation

uses
  SysUtils
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
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineEX
  {$IfEnd} //not NoScripts
  ,
  l3BatchService
  ;

{$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}

// start class TVCMSandBoxTestRes

{$If defined(nsTest)}
class function TVCMSandBoxTestRes.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_523024100274_var*
//#UC END# *4F79BCC902C5_523024100274_var*
begin
//#UC START# *4F79BCC902C5_523024100274_impl*
 //Result := KTestRunner.NeedKTestRunner([TtoK, TItsLAW, TtoK64, TtoKT, TBaseUC]);
 Result := KTestRunner.NeedKTestRunner([]);
//#UC END# *4F79BCC902C5_523024100274_impl*
end;//TVCMSandBoxTestRes.CalcBatchMode
{$IfEnd} //nsTest

end.