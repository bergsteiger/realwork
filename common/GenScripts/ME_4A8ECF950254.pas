unit moMonitorings;
 {* ����������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moMonitorings.pas"
// ���������: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMonitorings_Module
;

type
 Tmo_Monitorings = {final} class(TPrimMonitoringsModule)
  {* ����������� }
 end;//Tmo_Monitorings
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
