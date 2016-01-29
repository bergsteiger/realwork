unit PrimCustomizeTasksPanel_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/View/TasksPanel/Forms/PrimCustomizeTasksPanel_Form.pas"
// Начат: 13.09.2010
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations::VCMCustomization::View::TasksPanel::PrimCustomizeTasksPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoVCM)}
uses
  vcmTaskPanelInterfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmBase {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TPrimCustomizeTasksPanelForm = {form} class(TvcmEntityForm)
 protected
 // property methods
   function pm_GetTasksPanel: IvcmCustOps; virtual; abstract;
   procedure pm_SetTasksPanel(const aValue: IvcmCustOps); virtual; abstract;
 public
 // public methods
   class function Make(const aPanel: IvcmCustOps;
     const aParams : IvcmMakeParams = nil;
     aZoneType     : TvcmZoneType = vcm_ztAny;
     aUserType     : TvcmEffectiveUserType = 0;
     aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
     {* Фабрика }
 public
 // public properties
   property TasksPanel: IvcmCustOps
     read pm_GetTasksPanel
     write pm_SetTasksPanel;
 end;//TPrimCustomizeTasksPanelForm

 TvcmEntityFormRef = TPrimCustomizeTasksPanelForm;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TPrimCustomizeTasksPanelForm

class function TPrimCustomizeTasksPanelForm.Make(const aPanel: IvcmCustOps;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimCustomizeTasksPanelForm);
 begin
  with aForm do
  begin
//#UC START# *4C8E51FA022E_4C8E4D21001F_impl*
   TasksPanel := aPanel;
//#UC END# *4C8E51FA022E_4C8E4D21001F_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

{$IfEnd} //not NoVCM

end.