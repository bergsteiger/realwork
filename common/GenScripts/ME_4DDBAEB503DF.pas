unit moChangesBetweenEditions;
 {* �������� ������ ���������� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moChangesBetweenEditions.pas"
// ���������: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChangesBetweenEditions_Module
;

type
 Tmo_ChangesBetweenEditions = {final} class(TChangesBetweenEditionsModule)
  {* �������� ������ ���������� ���������� }
 end;//Tmo_ChangesBetweenEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
