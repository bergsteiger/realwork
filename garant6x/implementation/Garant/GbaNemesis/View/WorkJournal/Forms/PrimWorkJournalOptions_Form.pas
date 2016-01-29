unit PrimWorkJournalOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal/Forms/PrimWorkJournalOptions_Form.pas"
// Начат: 27.10.2010 12:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Основные прецеденты::WorkJournal::View::WorkJournal::PrimWorkJournalOptions
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
  PrimWorkJournal_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimWorkJournalOptionsForm = {form} class(TPrimWorkJournalForm)
 protected
  procedure InitEntities; override;
 end;//TPrimWorkJournalOptionsForm

 TvcmEntityFormRef = TPrimWorkJournalOptionsForm;
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
  StdRes {a},
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimWorkJournalOptionsForm

procedure TPrimWorkJournalOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  
  ShowInContextMenu(en_SavedQuery, op_OpenQuery, true);
  ShowInToolbar(en_SavedQuery, op_OpenQuery, false);
  
  ShowInContextMenu(en_SavedQuery, op_ExecuteQuery, true);
  ShowInToolbar(en_SavedQuery, op_ExecuteQuery, false);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimWorkJournalOptions
 TtfwClassRef.Register(TPrimWorkJournalOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.