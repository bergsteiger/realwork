unit NOT_COMPLETED_PrimMonitoringsMain_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\NOT_COMPLETED_PrimMonitoringsMain_Form.pas"
// ���������: "VCMMainForm"
// ������� ������: "PrimMonitoringsMain" MUID: (4AA919040176)
// ��� ����: "TPrimMonitoringsMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3IntfUses
 , ShellAndMonitoringsMain_Form
;

type
 _AdminAndMonitoringsMainForm_Parent_ = TShellAndMonitoringsMainForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}
 TPrimMonitoringsMainForm = class(_AdminAndMonitoringsMainForm_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimMonitoringsMainForm
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
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
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimMonitoringsMain_utEmptyMainWindow_UserType
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
 inherited;
 TdmStdRes.StartOpen(Self, False);
//#UC END# *49803F5503AA_4AA919040176_impl*
end;//TPrimMonitoringsMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMonitoringsMainForm.MakeControls;
begin
 inherited;
 with AddUsertype(utEmptyMainWindowName,
  str_utEmptyMainWindowCaption,
  str_utEmptyMainWindowSettingsCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utEmptyMainWindowName
end;//TPrimMonitoringsMainForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utEmptyMainWindowCaption.Init;
 {* ������������� str_utEmptyMainWindowCaption }
 str_utEmptyMainWindowSettingsCaption.Init;
 {* ������������� str_utEmptyMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMonitoringsMainForm);
 {* ����������� PrimMonitoringsMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

end.
