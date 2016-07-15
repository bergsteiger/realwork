unit moLiteSearch;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\moLiteSearch.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "LiteSearch" MUID: (4AA0EAA5019F)
// Имя типа: "Tmo_LiteSearch"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , LiteSearch_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_LiteSearch = {final} class(TLiteSearchModule)
 end;//Tmo_LiteSearch

implementation

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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_LiteSearch, ''));

end.
