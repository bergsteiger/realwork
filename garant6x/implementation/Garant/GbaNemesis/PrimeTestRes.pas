unit PrimeTestRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/PrimeTestRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMTestApplication::Class>> F1 Ежедневные тесты ПРАЙМ::Prime::PrimeTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}
uses
  Classes
  {$If defined(Monitorings) AND not defined(Admin)}
  ,
  MonitoringsRes
  {$IfEnd} //Monitorings AND not Admin
  ,
  GUITestRunner
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
  ,
  tfwScriptDebugger
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts AND not NotTunedDUnit
  ,
  vcmInterfaces {a},
  vcmExternalInterfaces {a}
  ;
{$IfEnd} //InsiderTest AND Monitorings AND nsTest

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}
type
 _VCMAppTester_Parent_ = TMonitoringsRes;
 {$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}
 TPrimeTestRes = {final} class(_VCMAppTester_)
 public
 // realized methods
   class function CalcBatchMode: Boolean; override;
 end;//TPrimeTestRes
 TvcmApplicationRef = TPrimeTestRes;
  {* Ссылка на приложение для DesignTime редакторов }

{$IfEnd} //InsiderTest AND Monitorings AND nsTest

implementation

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}
uses
  toKPrime,
  toKTPrime
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
{$IfEnd} //InsiderTest AND Monitorings AND nsTest

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}

{$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}

// start class TPrimeTestRes

class function TPrimeTestRes.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_5123800A0080_var*
//#UC END# *4F79BCC902C5_5123800A0080_var*
begin
//#UC START# *4F79BCC902C5_5123800A0080_impl*
 Result := KTestRunner.NeedKTestRunner([TtoKPrime, TtoKTPrime]);
//#UC END# *4F79BCC902C5_5123800A0080_impl*
end;//TPrimeTestRes.CalcBatchMode

{$IfEnd} //InsiderTest AND Monitorings AND nsTest

end.