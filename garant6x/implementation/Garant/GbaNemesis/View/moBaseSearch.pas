unit moBaseSearch;
 {* ������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moBaseSearch.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "BaseSearch" MUID: (4CC97A9F0310)
// ��� ����: "Tmo_BaseSearch"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseSearch_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_BaseSearch = {final} class(TBaseSearchModule)
  {* ������� ����� }
 end;//Tmo_BaseSearch
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tmo_BaseSearch);
 {* ����������� BaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_BaseSearch, '������� �����'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
