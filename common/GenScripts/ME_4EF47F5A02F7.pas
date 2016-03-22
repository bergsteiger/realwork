unit UserCR2_WarningBaloon_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\UserCR2_WarningBaloon_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "UserCR2_WarningBaloon" MUID: (4EF47F5A02F7)
// ��� ����: "TUserCR2_WarningBaloonForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningBaloonOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TUserCR2_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, UserCR2_WarningBaloonFormDef)
 end;//TUserCR2_WarningBaloonForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , UserCR2_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TUserCR2_WarningBaloonForm);
 {* ����������� UserCR2_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_UserCR2_WarningBaloonForm.SetFactory(TUserCR2_WarningBaloonForm.Make);
 {* ����������� ������� ����� UserCR2_WarningBaloon }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
