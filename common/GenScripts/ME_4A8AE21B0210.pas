unit Base_Operations_Chat_Controls;
 {* ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Chat_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Chat" MUID: (4A8AE21B0210)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
