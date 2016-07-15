unit moList;
 {* ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moList.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "List" MUID: (4A9BF3F302BF)
// ��� ����: "Tmo_List"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , List_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_List = {final} class(TListModule)
  {* ������ }
 end;//Tmo_List
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_List, '������'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
