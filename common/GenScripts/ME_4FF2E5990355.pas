unit moAAC;
 {* ���������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moAAC.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "AAC" MUID: (4FF2E5990355)
// ��� ����: "Tmo_AAC"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACPrim_Module
;

type
 Tmo_AAC = {final} class(TAACPrimModule)
  {* ���������� ��������� }
 end;//Tmo_AAC
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
