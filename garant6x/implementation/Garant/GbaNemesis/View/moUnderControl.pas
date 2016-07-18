unit moUnderControl;
 {* Документы на контроле }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moUnderControl.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "UnderControl" MUID: (4CCAC6B7019D)
// Имя типа: "Tmo_UnderControl"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , UnderControl_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_UnderControl = {final} class(TUnderControlModule)
  {* Документы на контроле }
 end;//Tmo_UnderControl
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_UnderControl, 'Документы на контроле'));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
