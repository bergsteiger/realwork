unit moConsultations;
 {* ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moConsultations.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Consultations" MUID: (4ABCFAE400A8)
// ��� ����: "Tmo_Consultations"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Consultation_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Consultations, '������������'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
