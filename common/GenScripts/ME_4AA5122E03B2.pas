unit moAdmin;
 {* ����������������� ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moAdmin.pas"
// ���������: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , Admin_Module
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
;
{$IfEnd} // Defined(Admin)

end.
