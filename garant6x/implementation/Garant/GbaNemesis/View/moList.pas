unit moList;
 {* Список }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moList.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "List" MUID: (4A9BF3F302BF)
// Имя типа: "Tmo_List"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_List, 'Список'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
