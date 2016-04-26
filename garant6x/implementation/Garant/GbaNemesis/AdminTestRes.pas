unit AdminTestRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AdminTestRes.pas"
// Стереотип: "VCMTestApplication"
// Элемент модели: "AdminTest" MUID: (5123A74700E2)
// Имя типа: "TAdminTestRes"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)}
uses
 l3IntfUses
 , AdminAppRes
 {$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , tfwScriptDebugger
 {$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 , GUITestRunner
;

type
 _VCMAppTester_Parent_ = TAdminAppRes;
 {$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}
 TAdminTestRes = {final} class(_VCMAppTester_)
  public
   class function CalcBatchMode: Boolean; override;
 end;//TAdminTestRes

 TvcmApplicationRef = TAdminTestRes;
  {* Ссылка на приложение для DesignTime редакторов }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)}
uses
 l3ImplUses
 , toKAdmin
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
 , evExtFormat
 , StdRes
;

{$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}

class function TAdminTestRes.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_5123A74700E2_var*
//#UC END# *4F79BCC902C5_5123A74700E2_var*
begin
//#UC START# *4F79BCC902C5_5123A74700E2_impl*
 Result := KTestRunner.NeedKTestRunner([TtoKAdmin]);
//#UC END# *4F79BCC902C5_5123A74700E2_impl*
end;//TAdminTestRes.CalcBatchMode
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)

end.
