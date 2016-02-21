unit VCMSandBoxTestRes;

// Модуль: "w:\common\components\SandBox\VCM\VCMSandBoxTestRes.pas"
// Стереотип: "VCMTestApplication"

{$Include w:\common\components\SandBox\VCM\sbtDefine.inc}

interface

uses
 l3IntfUses
 , VCMSandBoxRes
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , tfwScriptDebugger
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 {$If Defined(nsTest)}
 , GUITestRunner
 {$IfEnd} // Defined(nsTest)
;

type
 TvcmApplicationRef = TVCMSandBoxTestRes;
  {* Ссылка на приложение для DesignTime редакторов }

 _VCMAppTester_Parent_ = TVCMSandBoxRes;
 {$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}
 TVCMSandBoxTestRes = {final} class(_VCMAppTester_)
  public
   {$If Defined(nsTest)}
   class function CalcBatchMode: Boolean; override;
   {$IfEnd} // Defined(nsTest)
 end;//TVCMSandBoxTestRes

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 , l3Base
 , l3ComponentInfoHelper
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX
 {$IfEnd} // NOT Defined(NoScripts)
 , l3BatchService
;

{$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}

{$If Defined(nsTest)}
class function TVCMSandBoxTestRes.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_523024100274_var*
//#UC END# *4F79BCC902C5_523024100274_var*
begin
//#UC START# *4F79BCC902C5_523024100274_impl*
 //Result := KTestRunner.NeedKTestRunner([TtoK, TItsLAW, TtoK64, TtoKT, TBaseUC]);
 Result := KTestRunner.NeedKTestRunner([]);
//#UC END# *4F79BCC902C5_523024100274_impl*
end;//TVCMSandBoxTestRes.CalcBatchMode
{$IfEnd} // Defined(nsTest)

end.
