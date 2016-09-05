unit moSettings;
 {* Установки }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moSettings.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "Settings" MUID: (4AA79F3C03BE)
// Имя типа: "Tmo_Settings"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Settings_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Settings, 'Установки'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'AutoLogin', 'Автоматический вход в систему', False, mod_opcode_SettingsService_AutoLogin));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'LoadActiveSettings', 'Настройка конфигурации...', False, mod_opcode_SettingsService_LoadActiveSettings));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'OpenConfList', 'Список конфигураций', False, mod_opcode_SettingsService_OpenConfList));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'OpenStyleEditorAsModal', 'Редактор стилей...', False, mod_opcode_SettingsService_OpenStyleEditorAsModal));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'SelectConfig', 'Выбор конфигурации', False, mod_opcode_SettingsService_SelectConfig));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'UserProperties', 'Изменить мои регистрационные данные...', False, mod_opcode_SettingsService_UserProperties));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
