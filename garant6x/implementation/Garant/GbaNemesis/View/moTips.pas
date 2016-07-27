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
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Tips, '����� ���'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Tips, 'ShowDayTips', '', False, mod_opcode_DayTipsService_ShowDayTips));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
