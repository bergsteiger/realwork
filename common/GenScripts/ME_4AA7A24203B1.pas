unit moMainMenu;
 {* �������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moMainMenu.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "MainMenu" MUID: (4AA7A24203B1)
// ��� ����: "Tmo_MainMenu"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MainMenu_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_MainMenu = {final} class(TMainMenuModule)
  {* �������� ���� }
 end;//Tmo_MainMenu
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_MainMenu, '�������� ����'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
