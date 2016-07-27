unit moInternetAgent;
 {* Интернет-агент }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moInternetAgent.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "InternetAgent" MUID: (49F6E8F90153)
// Имя типа: "Tmo_InternetAgent"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimInternetAgent_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_InternetAgent = {final} class(TPrimInternetAgentModule)
  {* Интернет-агент }
 end;//Tmo_InternetAgent
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
 , Base_Operations_F1Services_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_InternetAgent, 'Интернет-агент'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_InternetAgent, 'InternetAgent', '', False, mod_opcode_InternetAgentService_InternetAgent));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
