unit moDiction;
 {* �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDiction.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Diction" MUID: (4A9CE63301FF)
// ��� ����: "Tmo_Diction"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Diction_Module
;

type
 Tmo_Diction = {final} class(TDictionModule)
  {* �������� ������� }
 end;//Tmo_Diction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
