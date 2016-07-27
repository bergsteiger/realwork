unit moInpharm;
 {* ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moInpharm.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Inpharm" MUID: (4AA0D69601AB)
// ��� ����: "Tmo_Inpharm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Inpharm_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Inpharm = {final} class(TInpharmModule)
  {* ������ }
 end;//Tmo_Inpharm
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
 , Base_Operations_F1Services_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Inpharm, '������'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'DrugList', '������ ����������� ����������', False, mod_opcode_InpharmService_DrugList));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicDiction', '������� ����������� ��������', False, mod_opcode_InpharmService_MedicDiction));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicFirms', '���������������� �����', False, mod_opcode_InpharmService_MedicFirms));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicMainMenu', '�������� ���� ������', False, mod_opcode_InpharmService_MedicMainMenu));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
