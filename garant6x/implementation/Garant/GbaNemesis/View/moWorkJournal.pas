unit moWorkJournal;
 {* Журнал работы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moWorkJournal.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "WorkJournal" MUID: (4A811E460199)
// Имя типа: "Tmo_WorkJournal"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseWorkJournal_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_WorkJournal = {final} class(TBaseWorkJournalModule)
  {* Журнал работы }
 end;//Tmo_WorkJournal

var g_module_opcode_WorkJournal_OpenJournal: TvcmMOPID = (rMoID : -1; rOpID : -1);
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_WorkJournal, 'Журнал работы'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_WorkJournal, 'OpenJournal', '', False, g_module_opcode_WorkJournal_OpenJournal));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
