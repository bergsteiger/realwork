unit moChangesBetweenEditions;
 {* �������� ������ ���������� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moChangesBetweenEditions.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "ChangesBetweenEditions" MUID: (4DDBAEB503DF)
// ��� ����: "Tmo_ChangesBetweenEditions"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChangesBetweenEditions_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_ChangesBetweenEditions = {final} class(TChangesBetweenEditionsModule)
  {* �������� ������ ���������� ���������� }
 end;//Tmo_ChangesBetweenEditions
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_ChangesBetweenEditions, '�������� ������ ���������� ����������'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
