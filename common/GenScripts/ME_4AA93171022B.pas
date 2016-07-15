unit moCommonSearch;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\moCommonSearch.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "CommonSearch" MUID: (4AA93171022B)
// Имя типа: "Tmo_CommonSearch"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , CommonSearch_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_CommonSearch = {final} class(TCommonSearchModule)
 end;//Tmo_CommonSearch
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_CommonSearch, ''));
{$IfEnd} // NOT Defined(Admin)

end.
