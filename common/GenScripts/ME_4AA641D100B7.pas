unit moSearch;
 {* Поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moSearch.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "Search" MUID: (4AA641D100B7)
// Имя типа: "Tmo_Search"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Search_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Search = {final} class(TSearchModule)
  {* Поиск }
 end;//Tmo_Search

var g_module_opcode_Search_PublishSourceSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_InpharmSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_StartENO: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_DocumentsWithoutClass: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_DocumentsWithoutIncluded: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_DocumentsWithoutKey: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_BaseSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_OpenConsult: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_AllSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_OpenKeyWordSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Search_AttributeSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tmo_Search);
 {* Регистрация Search }
{$IfEnd} // NOT Defined(NoScripts)
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Search, 'Поиск'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'PublishSourceSearch', '', False, g_module_opcode_Search_PublishSourceSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'InpharmSearch', 'Поиск лекарственных средств', False, g_module_opcode_Search_InpharmSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'StartENO', '', False, g_module_opcode_Search_StartENO));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'DocumentsWithoutClass', '', False, g_module_opcode_Search_DocumentsWithoutClass));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'DocumentsWithoutIncluded', '', False, g_module_opcode_Search_DocumentsWithoutIncluded));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'DocumentsWithoutKey', '', False, g_module_opcode_Search_DocumentsWithoutKey));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'BaseSearch', '', False, g_module_opcode_Search_BaseSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'OpenConsult', '', False, g_module_opcode_Search_OpenConsult));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'AllSearch', 'Поиск', False, g_module_opcode_Search_AllSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'OpenKeyWordSearch', 'Поиск по ситуации', False, g_module_opcode_Search_OpenKeyWordSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'AttributeSearch', 'Поиск по реквизитам', False, g_module_opcode_Search_AttributeSearch));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
