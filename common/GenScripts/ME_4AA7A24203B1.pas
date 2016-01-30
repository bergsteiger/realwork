unit moMainMenu;
 {* Основное меню }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moMainMenu.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MainMenu_Module
;

type
 Tmo_MainMenu = {final} class(TMainMenuModule)
  {* Основное меню }
 end;//Tmo_MainMenu
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
