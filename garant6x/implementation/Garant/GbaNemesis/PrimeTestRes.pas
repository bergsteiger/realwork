unit PrimeTestRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\PrimeTestRes.pas"
// Стереотип: "VCMTestApplication"
// Элемент модели: "PrimeTest" MUID: (5123800A0080)
// Имя типа: "TPrimeTestRes"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(Admin)}
 , MonitoringsRes
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , tfwScriptDebugger
 {$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 , GUITestRunner
;

type
 _VCMAppTester_Parent_ = TMonitoringsRes;
 {$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}
 TPrimeTestRes = {final} class(_VCMAppTester_)
  public
   class function CalcBatchMode: Boolean; override;
 end;//TPrimeTestRes

 TvcmApplicationRef = TPrimeTestRes;
  {* Ссылка на приложение для DesignTime редакторов }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)}
uses
 l3ImplUses
 , toKPrime
 , toKTPrime
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , l3Base
 , l3ComponentInfoHelper
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 , TestFrameWork
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX
 {$IfEnd} // NOT Defined(NoScripts)
 , l3BatchService
;

{$If NOT Defined(Admin)}
{$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}

class function TPrimeTestRes.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_5123800A0080_var*
//#UC END# *4F79BCC902C5_5123800A0080_var*
begin
//#UC START# *4F79BCC902C5_5123800A0080_impl*
 Result := KTestRunner.NeedKTestRunner([TtoKPrime, TtoKTPrime]);
//#UC END# *4F79BCC902C5_5123800A0080_impl*
end;//TPrimeTestRes.CalcBatchMode
{$IfEnd} // NOT Defined(Admin)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)
end.
