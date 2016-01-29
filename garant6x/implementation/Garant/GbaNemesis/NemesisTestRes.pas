unit NemesisTestRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/NemesisTestRes.pas"
// Начат: 08.04.2011 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMTestApplication::Class>> F1 Ежедневные тесты::Nemesis::NemesisTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}
uses
  NemesisRes,
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
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}
type
 _VCMAppTester_Parent_ = TNemesisRes;
 {$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}
 TNemesisTestRes = {final} class(_VCMAppTester_)
 public
 // realized methods
   class function CalcBatchMode: Boolean; override;
 end;//TNemesisTestRes
 TvcmApplicationRef = TNemesisTestRes;
  {* Ссылка на приложение для DesignTime редакторов }

{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}
uses
  TestFrameWork
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  toK,
  ItsLAW
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  F1ScriptEngine
  {$IfEnd} //not NoScripts
  ,
  toK64
  {$If not defined(NoScripts)}
  ,
  afwAnswer
  {$IfEnd} //not NoScripts
  ,
  toKT,
  l3Base,
  BaseUC,
  toK2,
  toK3,
  l3ComponentInfoHelper
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineEX
  {$IfEnd} //not NoScripts
  ,
  l3BatchService
  ;
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}

// start class TNemesisTestRes

class function TNemesisTestRes.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_4D9F2DDA024D_var*
//#UC END# *4F79BCC902C5_4D9F2DDA024D_var*
begin
//#UC START# *4F79BCC902C5_4D9F2DDA024D_impl*
 Result := KTestRunner.NeedKTestRunner([TtoK, TItsLAW, TtoK64, TtoKT, TBaseUC, TtoK2, TtoK3]);
//#UC END# *4F79BCC902C5_4D9F2DDA024D_impl*
end;//TNemesisTestRes.CalcBatchMode

{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

end.