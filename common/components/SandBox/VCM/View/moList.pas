unit moList;
 {* Список }

// Модуль: "w:\common\components\SandBox\VCM\View\moList.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "List" MUID: (521DA5BA002C)
// Имя типа: "Tmo_List"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , List_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_List = {final} class(TListModule)
  {* Список }
 end;//Tmo_List

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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_List, 'Список'));

end.
