unit moUnderControl;
 {* ��������� �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moUnderControl.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "UnderControl" MUID: (4CCAC6B7019D)
// ��� ����: "Tmo_UnderControl"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , UnderControl_Module
;

type
 Tmo_UnderControl = {final} class(TUnderControlModule)
  {* ��������� �� �������� }
 end;//Tmo_UnderControl
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
