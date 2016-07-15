unit moMonitorings;
 {* ����������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moMonitorings.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Monitorings" MUID: (4A8ECF950254)
// ��� ����: "Tmo_Monitorings"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMonitorings_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Monitorings = {final} class(TPrimMonitoringsModule)
  {* ����������� }
 end;//Tmo_Monitorings

var g_module_opcode_Monitorings_OpenNewsLine: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Monitorings_OpenLegislationReview: TvcmMOPID = (rMoID : -1; rOpID : -1);
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Monitorings, '�����������'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Monitorings, 'OpenNewsLine', '��������� �����', False, g_module_opcode_Monitorings_OpenNewsLine));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Monitorings, 'OpenLegislationReview', '����� ��������� ����������������', False, g_module_opcode_Monitorings_OpenLegislationReview));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
