unit Folders_Result_Controls;
 {* ��������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Result_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Result" MUID: (4A97FFC40154)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // Result

 // ResultExt
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
