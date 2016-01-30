unit moTasksPanelMenu;
 {* Настройка панели задач }

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\moTasksPanelMenu.pas"
// Стереотип: "VCMFormsPack"

{$Include sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTasksPanelMenu_Module
;

type
 Tmo_TasksPanelMenu = {final} class(TPrimTasksPanelMenuModule)
  {* Настройка панели задач }
 end;//Tmo_TasksPanelMenu
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
