unit moAdmin;
 {* ����������������� ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moAdmin.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Admin" MUID: (4AA5122E03B2)
// ��� ����: "Tmo_Admin"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , Admin_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Admin = {final} class(TAdminModule)
  {* ����������������� ������������� }
 end;//Tmo_Admin
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Admin, '����������������� �������������'));
{$IfEnd} // Defined(Admin)

end.
