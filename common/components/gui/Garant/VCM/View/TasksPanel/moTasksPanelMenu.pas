unit moTasksPanelMenu;
 {* Настройка панели задач }

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\moTasksPanelMenu.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "TasksPanelMenu" MUID: (4C8DE85601C4)
// Имя типа: "Tmo_TasksPanelMenu"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTasksPanelMenu_Module
 , vcmExternalInterfaces
 , vcmModule
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
 , vcmModulesForRegister
 , vcmModuleOperationsForRegister
 , VCMCustomization_Customization_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_TasksPanelMenu, 'Настройка панели задач'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_TasksPanelMenu, 'Customize', 'Настройка...', False, g_module_opcode_TaskPanelService_Customize));
{$IfEnd} // NOT Defined(NoVCM)

end.
