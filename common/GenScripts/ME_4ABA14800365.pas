unit Settings_Form;
 {* ��������� ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\Settings_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "Settings" MUID: (4ABA14800365)
// ��� ����: "Tcf_Settings"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSettings_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_cf_Settings: TvcmFormDescriptor = (rFormID : (rName : 'cf_Settings'; rID : 0); rFactory : nil);
  {* ������������� ����� Tcf_Settings }

type
 Tcf_Settings = class;

 SettingsFormDef = interface
  {* ������������� ����� Settings }
  ['{AE03AFD6-01DB-435D-9437-B777E585331E}']
 end;//SettingsFormDef

 Tcf_Settings = {final} class(TPrimSettingsForm, SettingsFormDef)
  {* ��������� ������������ }
 end;//Tcf_Settings
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SettingsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tcf_Settings);
 {* ����������� Settings }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
