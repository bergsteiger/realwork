unit F1_Without_Usecases_System_Controls;
 {* "���������" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_System_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "System" MUID: (4A8E792A0108)

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
