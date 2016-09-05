unit moInpharm;
 {* Инфарм }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moInpharm.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "Inpharm" MUID: (4AA0D69601AB)
// Имя типа: "Tmo_Inpharm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Inpharm_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Inpharm = {final} class(TInpharmModule)
  {* Инфарм }
 end;//Tmo_Inpharm
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
 , Common_F1CommonServices_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Inpharm, 'Инфарм'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'DrugList', 'Список выпускаемых препаратов', False, mod_opcode_InpharmOperations_DrugList));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicDiction', 'Словарь медицинских терминов', False, mod_opcode_InpharmOperations_MedicDiction));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicFirms', 'Фармацевтические фирмы', False, mod_opcode_InpharmOperations_MedicFirms));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicMainMenu', 'Основное меню ИнФарм', False, mod_opcode_InpharmOperations_MedicMainMenu));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
