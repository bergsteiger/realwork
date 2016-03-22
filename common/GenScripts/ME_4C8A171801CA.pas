unit PrimTurnOffTimeMachineOptions_Form;
 {* Выключить Машину времени / Изменить дату }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTurnOffTimeMachineOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimTurnOffTimeMachineOptions" MUID: (4C8A171801CA)
// Имя типа: "TPrimTurnOffTimeMachineOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTurnOffTimeMachine_Form
;

type
 TPrimTurnOffTimeMachineOptionsForm = class(TPrimTurnOffTimeMachineForm)
  {* Выключить Машину времени / Изменить дату }
 end;//TPrimTurnOffTimeMachineOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTurnOffTimeMachineOptionsForm);
 {* Регистрация PrimTurnOffTimeMachineOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
