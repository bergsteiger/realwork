unit moMainMenu;
 {* �������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moMainMenu.pas"
// ���������: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MainMenu_Module
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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
