unit PrimTurnOffTimeMachineOptions_Form;
 {* Выключить Машину времени / Изменить дату }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTurnOffTimeMachineOptions_Form.pas"
// Стереотип: "VCMForm"

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
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
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

{$If NOT Defined(NoVCM)}
procedure TPrimTurnOffTimeMachineOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C8A171801CA_var*
//#UC END# *4C762A1501FC_4C8A171801CA_var*
begin
//#UC START# *4C762A1501FC_4C8A171801CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C8A171801CA_impl*
end;//TPrimTurnOffTimeMachineOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTurnOffTimeMachineOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4C8A171801CA_var*
//#UC END# *4C762AB601E1_4C8A171801CA_var*
begin
//#UC START# *4C762AB601E1_4C8A171801CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4C8A171801CA_impl*
end;//TPrimTurnOffTimeMachineOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTurnOffTimeMachineOptionsForm);
 {* Регистрация PrimTurnOffTimeMachineOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
