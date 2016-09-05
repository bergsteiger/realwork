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
 , Base_Operations_F1Services_Contracts
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tmo_Search);
 {* Регистрация Search }
{$IfEnd} // NOT Defined(NoScripts)
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Search, 'Поиск'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'AllSearch', 'Поиск', False, mod_opcode_SearchService_AllSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'AttributeSearch', 'Поиск по реквизитам', False, mod_opcode_SearchService_AttributeSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'BaseSearch', '', False, mod_opcode_SearchService_BaseSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'DocumentsWithoutClass', '', False, mod_opcode_SearchService_DocumentsWithoutClass));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'DocumentsWithoutIncluded', '', False, mod_opcode_SearchService_DocumentsWithoutIncluded));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'DocumentsWithoutKey', '', False, mod_opcode_SearchService_DocumentsWithoutKey));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'InpharmSearch', 'Поиск лекарственных средств', False, mod_opcode_SearchService_InpharmSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'OpenConsult', '', False, mod_opcode_SearchService_OpenConsult));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'PublishSourceSearch', '', False, mod_opcode_SearchService_PublishSourceSearch));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'StartENO', '', False, mod_opcode_SearchService_StartENO));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Search, 'OpenKeyWordSearch', 'Поиск по ситуации', False, mod_opcode_SearchService_OpenKeyWordSearch));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
