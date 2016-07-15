unit moInternetAgent;
 {* ��������-����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moInternetAgent.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "InternetAgent" MUID: (49F6E8F90153)
// ��� ����: "Tmo_InternetAgent"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimInternetAgent_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_InternetAgent = {final} class(TPrimInternetAgentModule)
  {* ��������-����� }
 end;//Tmo_InternetAgent

var g_module_opcode_InternetAgent_InternetAgent: TvcmMOPID = (rMoID : -1; rOpID : -1);
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_InternetAgent, '��������-�����'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_InternetAgent, 'InternetAgent', '������� ������', False, g_module_opcode_InternetAgent_InternetAgent));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
