unit moTips;
 {* ����� ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moTips.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Tips" MUID: (4AA0D56B027A)
// ��� ����: "Tmo_Tips"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DayTips_Module
;

type
 Tmo_Tips = {final} class(TDayTipsModule)
  {* ����� ��� }
 end;//Tmo_Tips
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
