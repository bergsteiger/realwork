unit moSettings;
 {* Установки }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moSettings.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Settings_Module
;

type
 Tmo_Settings = {final} class(TSettingsModule)
  {* Установки }
 end;//Tmo_Settings
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
