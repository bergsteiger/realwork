unit PrimTurnOnTimeMachineOptions_Form;
 {* Включить Машину времени }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimTurnOnTimeMachineOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTurnOnTimeMachine_Form
;

type
 TPrimTurnOnTimeMachineOptionsForm = class(TPrimTurnOnTimeMachineForm)
  {* Включить Машину времени }
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
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

{$If NOT Defined(NoVCM)}
procedure TPrimTurnOnTimeMachineOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C8A1B5C0356_var*
//#UC END# *4C762A1501FC_4C8A1B5C0356_var*
begin
//#UC START# *4C762A1501FC_4C8A1B5C0356_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C8A1B5C0356_impl*
end;//TPrimTurnOnTimeMachineOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTurnOnTimeMachineOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4C8A1B5C0356_var*
//#UC END# *4C762AB601E1_4C8A1B5C0356_var*
begin
//#UC START# *4C762AB601E1_4C8A1B5C0356_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4C8A1B5C0356_impl*
end;//TPrimTurnOnTimeMachineOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTurnOnTimeMachineOptionsForm);
 {* Регистрация PrimTurnOnTimeMachineOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
