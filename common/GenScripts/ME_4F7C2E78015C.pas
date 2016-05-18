unit NOT_COMPLETED_MonitoringsMain_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\NOT_COMPLETED_MonitoringsMain_Form.pas"
// ���������: "VCMMainForm"
// ������� ������: "MonitoringsMain" MUID: (4F7C2E78015C)
// ��� ����: "TMonitoringsMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimMonitoringsMain_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_MonitoringsMainForm: TvcmFormDescriptor = (rFormID : (rName : 'MonitoringsMainForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TMonitoringsMainForm }

type
 TMonitoringsMainForm = class;

 MonitoringsMainFormDef = interface
  {* ������������� ����� MonitoringsMain }
  ['{302D255D-E242-47AD-ACB5-B3822A5E3F7F}']
 end;//MonitoringsMainFormDef

 TMonitoringsMainForm = {final} class(TPrimMonitoringsMainForm, MonitoringsMainFormDef)
 end;//TMonitoringsMainForm
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MonitoringsMainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
 fm_MonitoringsMainForm.SetFactory(TMonitoringsMainForm.Make);
 {* ����������� ������� ����� MonitoringsMain }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMonitoringsMainForm);
 {* ����������� MonitoringsMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

end.
