unit Base_Operations_F1Specific_Controls;
 {* ��������, ����������� ��� F1 }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_F1Specific_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "F1Specific" MUID: (495237D80268)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // File
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
