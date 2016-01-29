unit PrimTurnOffTimeMachineOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimTurnOffTimeMachineOptions_Form.pas"
// Начат: 10.09.2010 15:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::PrimTurnOffTimeMachineOptions
//
// Выключить Машину времени / Изменить дату
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  PrimTurnOffTimeMachine_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimTurnOffTimeMachineOptionsForm = {form} class(TPrimTurnOffTimeMachineForm)
  {* Выключить Машину времени / Изменить дату }
 protected
  procedure InitEntities; override;
 end;//TPrimTurnOffTimeMachineOptionsForm

 TvcmEntityFormRef = TPrimTurnOffTimeMachineOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimTurnOffTimeMachineOptionsForm

procedure TPrimTurnOffTimeMachineOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, false);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimTurnOffTimeMachineOptions
 TtfwClassRef.Register(TPrimTurnOffTimeMachineOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.