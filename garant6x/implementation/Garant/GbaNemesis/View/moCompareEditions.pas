unit moCompareEditions;
 {* ��������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCompareEditions.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "CompareEditions" MUID: (4A6D5A4902D8)
// ��� ����: "Tmo_CompareEditions"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseEditions_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_CompareEditions = {final} class(TBaseEditionsModule)
  {* ��������� �������� }
 end;//Tmo_CompareEditions
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_CompareEditions, '��������� ��������'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
