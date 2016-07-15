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
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Diction = {final} class(TDictionModule)
  {* �������� ������� }
 end;//Tmo_Diction

var g_module_opcode_Diction_OpenDict: TvcmMOPID = (rMoID : -1; rOpID : -1);
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Diction, '�������� �������'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Diction, 'OpenDict', '�������� �������', False, g_module_opcode_Diction_OpenDict));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
