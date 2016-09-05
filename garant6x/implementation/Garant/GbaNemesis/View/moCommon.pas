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
 , Common_F1CommonServices_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Common, 'Окна'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'ComplectInfo', 'Информация о комплекте', False, mod_opcode_CommonService_ComplectInfo));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'LetterToDevelopers', 'Письмо разработчикам', True, mod_opcode_CommonService_LetterToDevelopers));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenInformation', 'Справочная информация', False, mod_opcode_CommonService_OpenInformation));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenIntranet', '', False, mod_opcode_CommonService_OpenIntranet));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenMainMenuByButton', 'Основное меню системы ГАРАНТ', False, mod_opcode_CommonService_OpenMainMenuByButton));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenMainMenuNew', 'Основное меню', True, mod_opcode_CommonService_OpenMainMenuNew));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenRubricator', 'Правовой навигатор', False, mod_opcode_CommonService_OpenRubricator));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'PageSetup', 'Настройка страницы...', False, mod_opcode_CommonService_PageSetup));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'ShowEULA', 'Условия использования', False, mod_opcode_CommonService_ShowEULA));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'TasksPanel', 'Панель задач', False, mod_opcode_CommonService_TasksPanel));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'get_navigator', 'Меню (вкладка)', True, mod_opcode_CommonService_get_navigator));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
