unit moConsultations;
 {* ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moConsultations.pas"
// ���������: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Consultation_Module
;

type
 Tmo_Consultations = {final} class(TConsultationModule)
  {* ������������ }
 end;//Tmo_Consultations
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
