unit PrimTurnOnTimeMachineOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimTurnOnTimeMachineOptions_Form.pas"
// Начат: 10.09.2010 15:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::TimeMachine::PrimTurnOnTimeMachineOptions
//
// Включить Машину времени
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
  PrimTurnOnTimeMachine_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimTurnOnTimeMachineOptionsForm = {form} class(TPrimTurnOnTimeMachineForm)
  {* Включить Машину времени }
 protected
  procedure InitEntities; override;
 end;//TPrimTurnOnTimeMachineOptionsForm

 TvcmEntityFormRef = TPrimTurnOnTimeMachineOptionsForm;
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

// start class TPrimTurnOnTimeMachineOptionsForm

procedure TPrimTurnOnTimeMachineOptionsForm.InitEntities;
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
// Регистрация PrimTurnOnTimeMachineOptions
 TtfwClassRef.Register(TPrimTurnOnTimeMachineOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.