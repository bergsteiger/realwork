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

var g_module_opcode_Inpharm_MedicDiction: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Inpharm_MedicFirms: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Inpharm_DrugList: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Inpharm_MedicMainMenu: TvcmMOPID = (rMoID : -1; rOpID : -1);
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Inpharm, 'Инфарм'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicDiction', 'Словарь медицинских терминов', False, g_module_opcode_Inpharm_MedicDiction));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicFirms', 'Фармацевтические фирмы', False, g_module_opcode_Inpharm_MedicFirms));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'DrugList', 'Список выпускаемых препаратов', False, g_module_opcode_Inpharm_DrugList));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Inpharm, 'MedicMainMenu', 'Основное меню ИнФарм', False, g_module_opcode_Inpharm_MedicMainMenu));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
