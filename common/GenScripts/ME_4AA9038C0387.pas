unit NOT_COMPLETED_MonitoringsRes;
 {* ����������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\NOT_COMPLETED_MonitoringsRes.pas"
// ���������: "VCMApplication"
// ������� ������: "Monitorings" MUID: (4AA9038C0387)
// ��� ����: "TMonitoringsRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3IntfUses
 , ShellAndMonitoringsRes
 , l3StringIDEx
;

const
 {* ������������ ������ MonitoringTitle }
 str_MonitoringTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MonitoringTitle'; rValue : '������ ����');
  {* '������ ����' }

type
 TMonitoringsRes = {final} class(TShellAndMonitoringsRes)
  {* ����������� }
  protected
   class procedure DoRun(var theSplash: IUnknown); override;
   procedure Loaded; override;
 end;//TMonitoringsRes

 TvcmApplicationRef = TMonitoringsRes;
  {* ������ �� ���������� ��� DesignTime ���������� }
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3ImplUses
 , moCommonPost
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimMonitoringsMain_Form
 , MonitoringsMain_Form
 {$If NOT Defined(NoScripts)}
 , MonitoringsMainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

class procedure TMonitoringsRes.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4AA9038C0387_var*
var
 l_Main : TMonitoringsMainForm;
//#UC END# *4AA7E4DC0047_4AA9038C0387_var*
begin
//#UC START# *4AA7E4DC0047_4AA9038C0387_impl*
 inherited;
 Application.CreateForm(TMonitoringsMainForm, l_Main);
//#UC END# *4AA7E4DC0047_4AA9038C0387_impl*
end;//TMonitoringsRes.DoRun

procedure TMonitoringsRes.Loaded;
begin
 inherited;
end;//TMonitoringsRes.Loaded

initialization
 str_MonitoringTitle.Init;
 {* ������������� str_MonitoringTitle }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMonitoringsRes);
 {* ����������� Monitorings }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

end.
