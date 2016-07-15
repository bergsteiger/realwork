unit moRubricator;
 {* �������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moRubricator.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Rubricator" MUID: (4AA6778D0357)
// ��� ����: "Tmo_Rubricator"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Rubricator_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Rubricator = {final} class(TRubricatorModule)
  {* �������� ��������� }
 end;//Tmo_Rubricator
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Rubricator, '�������� ���������'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
