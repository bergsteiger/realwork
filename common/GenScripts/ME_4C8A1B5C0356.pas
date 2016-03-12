unit PrimTurnOnTimeMachineOptions_Form;
 {* Включить Машину времени }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimTurnOnTimeMachineOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTurnOnTimeMachine_Form
;

type
 TPrimTurnOnTimeMachineOptionsForm = class(TPrimTurnOnTimeMachineForm)
  {* Включить Машину времени }
 end;//TPrimTurnOnTimeMachineOptionsForm
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
 TtfwClassRef.Register(TPrimTurnOnTimeMachineOptionsForm);
 {* Регистрация PrimTurnOnTimeMachineOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
