unit NOT_COMPLETED_AdminMain_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\NOT_COMPLETED_AdminMain_Form.pas"
// ���������: "VCMMainForm"
// ������� ������: "AdminMain" MUID: (4F7C3C0B035C)
// ��� ����: "TAdminMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimAdminMain_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_AdminMainForm: TvcmFormDescriptor = (rFormID : (rName : 'AdminMainForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TAdminMainForm }

type
 TAdminMainForm = class;

 AdminMainFormDef = interface
  {* ������������� ����� AdminMain }
  ['{26239010-1045-42DC-ABBF-3909601CF2CB}']
 end;//AdminMainFormDef

 TAdminMainForm = {final} class(TPrimAdminMainForm, AdminMainFormDef)
   Entities : TvcmEntities;
 end;//TAdminMainForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AdminMainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_AdminMainForm.SetFactory(TAdminMainForm.Make);
 {* ����������� ������� ����� AdminMain }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAdminMainForm);
 {* ����������� AdminMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
