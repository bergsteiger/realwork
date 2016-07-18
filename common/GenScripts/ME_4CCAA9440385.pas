unit moFilters;
 {* ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moFilters.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Filters" MUID: (4CCAA9440385)
// ��� ����: "Tmo_Filters"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Filters_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Filters = {final} class(TFiltersModule)
  {* ������� }
 end;//Tmo_Filters
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Filters, '�������'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
