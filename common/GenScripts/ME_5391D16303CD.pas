unit F1_Without_Usecases_DocumentsCacheOperations_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_DocumentsCacheOperations_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "DocumentsCacheOperations" MUID: (5391D16303CD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // DocumentsCache
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
