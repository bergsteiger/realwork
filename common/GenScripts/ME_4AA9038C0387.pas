unit MonitoringsRes;
 {* ����������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\MonitoringsRes.pas"
// ���������: "VCMApplication"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3IntfUses
 , ShellAndMonitoringsRes
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_MonitoringsMainForm: TvcmFormDescriptor = (rFormID : (rName : 'MonitoringsMainForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TMonitoringsMainForm }

const
 {* ������������ ������ MonitoringTitle }
 str_MonitoringTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MonitoringTitle'; rValue : '������ ����');
  {* '������ ����' }

type
 _AdminAndMonitoringsMainForm_Parent_ = TShellAndMonitoringsMainForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}
 TPrimMonitoringsMainForm = class(_AdminAndMonitoringsMainForm_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimMonitoringsMainForm

 MonitoringsMainFormDef = interface
  {* ������������� ����� MonitoringsMain }
  ['{302D255D-E242-47AD-ACB5-B3822A5E3F7F}']
 end;//MonitoringsMainFormDef

 TMonitoringsMainForm = {final} class(TPrimMonitoringsMainForm, MonitoringsMainFormDef)
 end;//TMonitoringsMainForm

 TvcmApplicationRef = TMonitoringsRes;
  {* ������ �� ���������� ��� DesignTime ���������� }

 TMonitoringsRes = {final} class(TShellAndMonitoringsRes)
  {* ����������� }
  protected
   class procedure DoRun(var theSplash: IUnknown); override;
 end;//TMonitoringsRes
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3ImplUses
 , moCommonPost
 , l3MessageID
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmSettings
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , MonitoringsMainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ utEmptyMainWindowLocalConstants }
 str_utEmptyMainWindowCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowCaption'; rValue : '������� ����');
  {* ��������� ����������������� ���� "������� ����" }
 str_utEmptyMainWindowSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowSettingsCaption'; rValue : '������� ������ ������������');
  {* ��������� ����������������� ���� "������� ����" ��� ��������� ������� ������������ }

type _Instance_R_ = TPrimMonitoringsMainForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TPrimMonitoringsMainForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_4AA919040176_var*
//#UC END# *49803F5503AA_4AA919040176_var*
begin
//#UC START# *49803F5503AA_4AA919040176_impl*
 !!! Needs to be implemented !!!
//#UC END# *49803F5503AA_4AA919040176_impl*
end;//TPrimMonitoringsMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

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

initialization
 str_utEmptyMainWindowCaption.Init;
 {* ������������� str_utEmptyMainWindowCaption }
 str_utEmptyMainWindowSettingsCaption.Init;
 {* ������������� str_utEmptyMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMonitoringsMainForm);
 {* ����������� PrimMonitoringsMain }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMonitoringsMainForm);
 {* ����������� MonitoringsMain }
{$IfEnd} // NOT Defined(NoScripts)
 fm_MonitoringsMainForm.SetFactory(TMonitoringsMainForm.Make);
 {* ����������� ������� ����� MonitoringsMain }
 str_MonitoringTitle.Init;
 {* ������������� str_MonitoringTitle }
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

end.
