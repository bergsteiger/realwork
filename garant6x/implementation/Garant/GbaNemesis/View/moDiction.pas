unit moDiction;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDiction.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "Diction" MUID: (4A9CE63301FF)
// Имя типа: "Tmo_Diction"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Diction_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Diction = {final} class(TDictionModule)
  {* Толковый словарь }
 end;//Tmo_Diction

var g_module_opcode_Diction_OpenDict: TvcmMOPID = (rMoID : -1; rOpID : -1);
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Diction, 'Толковый словарь'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Diction, 'OpenDict', 'Толковый словарь', False, g_module_opcode_Diction_OpenDict));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
