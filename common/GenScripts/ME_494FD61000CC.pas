unit Admin_Users_Controls;
 {* �������� ��� ����� � �������� �������� ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin_Users_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Users" MUID: (494FD61000CC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Admin)

end.
