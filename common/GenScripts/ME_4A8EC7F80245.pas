unit moCommon;
 {* Окна }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCommon.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Common" MUID: (4A8EC7F80245)
// Имя типа: "Tmo_Common"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimF1Common_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Common = {final} class(TPrimF1CommonModule)
  {* Окна }
 end;//Tmo_Common

var g_module_opcode_Common_ComplectInfo: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_PageSetup: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_ShowEULA: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_OpenMainMenuByButton: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_OpenMainMenuNew: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_TasksPanel: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_LetterToDevelopers: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_OpenRubricator: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_OpenInformation: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_get_navigator: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Common_OpenIntranet: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDataExchangeRealization
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Common, 'Окна'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'ComplectInfo', 'Информация о комплекте', False, g_module_opcode_Common_ComplectInfo));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'PageSetup', 'Настройка страницы...', False, g_module_opcode_Common_PageSetup));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'ShowEULA', 'Условия использования', False, g_module_opcode_Common_ShowEULA));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenMainMenuByButton', 'Основное меню системы ГАРАНТ', False, g_module_opcode_Common_OpenMainMenuByButton));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenMainMenuNew', 'Основное меню', True, g_module_opcode_Common_OpenMainMenuNew));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'TasksPanel', 'Панель задач', False, g_module_opcode_Common_TasksPanel));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'LetterToDevelopers', 'Письмо разработчикам', True, g_module_opcode_Common_LetterToDevelopers));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenRubricator', 'Правовой навигатор', False, g_module_opcode_Common_OpenRubricator));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenInformation', 'Справочная информация', False, g_module_opcode_Common_OpenInformation));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'get_navigator', 'Меню (вкладка)', True, g_module_opcode_Common_get_navigator));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenIntranet', '', False, g_module_opcode_Common_OpenIntranet));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
