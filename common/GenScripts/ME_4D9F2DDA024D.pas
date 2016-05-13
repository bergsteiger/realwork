unit NemesisTestRes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\NemesisTestRes.pas"
// ���������: "VCMTestApplication"
// ������� ������: "NemesisTest" MUID: (4D9F2DDA024D)
// ��� ����: "TNemesisTestRes"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , NemesisRes
 {$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , tfwScriptDebugger
 {$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 , GUITestRunner
;

type
 _VCMAppTester_Parent_ = TNemesisRes;
 {$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}
 TNemesisTestRes = {final} class(_VCMAppTester_)
  protected
   procedure Loaded; override;
  public
   class function CalcBatchMode: Boolean; override;
 end;//TNemesisTestRes

 TvcmApplicationRef = TNemesisTestRes;
  {* ������ �� ���������� ��� DesignTime ���������� }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , toK
 , ItsLAW
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmForm
 {$IfEnd} // NOT Defined(NoVCM)
 , toK64
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 , toKT
 , l3Base
 , BaseUC
 , toK2
 , toK3
 , l3ComponentInfoHelper
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX
 {$IfEnd} // NOT Defined(NoScripts)
 , l3BatchService
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , evExtFormat
;

{$Include w:\common\components\gui\Garant\VCM\AppTesting\VCMAppTester.imp.pas}

class function TNemesisTestRes.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_4D9F2DDA024D_var*
//#UC END# *4F79BCC902C5_4D9F2DDA024D_var*
begin
//#UC START# *4F79BCC902C5_4D9F2DDA024D_impl*
 Result := KTestRunner.NeedKTestRunner([TtoK, TItsLAW, TtoK64, TtoKT, TBaseUC, TtoK2, TtoK3]);
//#UC END# *4F79BCC902C5_4D9F2DDA024D_impl*
end;//TNemesisTestRes.CalcBatchMode

procedure TNemesisTestRes.Loaded;
begin
 inherited;
end;//TNemesisTestRes.Loaded

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNemesisTestRes);
 {* ����������� NemesisTest }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
