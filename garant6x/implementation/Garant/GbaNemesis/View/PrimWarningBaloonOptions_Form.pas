unit PrimWarningBaloonOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimWarningBaloonOptions_Form.pas"
// Начат: 24.10.2011 21:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Warning::PrimWarningBaloonOptions
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
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimWarningOptions_Form,
  BaloonWarningUserTypes_Fake_UserType
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnTimeMachineOn_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType,
  BaloonWarningUserTypes_WarnTimeMachineException_UserType,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  BaloonWarningUserTypes_remUnreadConsultations_UserType,
  BaloonWarningUserTypes_remOnlineDead_UserType,
  BaloonWarningUserTypes_TrialModeWarning_UserType,
  BaloonWarningUserTypes_OldBaseWarning_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_ControlledChangingWarning_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _BaloonWarningUserTypes_Parent_ = TPrimWarningOptionsForm;
 {$Include ..\View\BaloonWarningUserTypes.imp.pas}
 TPrimWarningBaloonOptionsForm = {form} class(_BaloonWarningUserTypes_)
 protected
  procedure InitEntities; override;
 public
 // overridden public methods
    {$If not defined(NoVCM)}
   function IsBaloon: Boolean; override;
    {$IfEnd} //not NoVCM
 end;//TPrimWarningBaloonOptionsForm

 TvcmEntityFormRef = TPrimWarningBaloonOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID,
  StdRes {a},
  Document_Strange_Controls,
  Base_Operations_Editions_Controls
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include ..\View\BaloonWarningUserTypes.imp.pas}

// start class TPrimWarningBaloonOptionsForm

{$If not defined(NoVCM)}
function TPrimWarningBaloonOptionsForm.IsBaloon: Boolean;
//#UC START# *4F748C5A00CB_4EA599F501CF_var*
//#UC END# *4F748C5A00CB_4EA599F501CF_var*
begin
//#UC START# *4F748C5A00CB_4EA599F501CF_impl*
 Result := true;
//#UC END# *4F748C5A00CB_4EA599F501CF_impl*
end;//TPrimWarningBaloonOptionsForm.IsBaloon
{$IfEnd} //not NoVCM

procedure TPrimWarningBaloonOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  
  ShowInContextMenu(en_Warning, op_TimeMachineOffAndReset, false);
  ShowInToolbar(en_Warning, op_TimeMachineOffAndReset, false);
 end;//with Entities.Entities
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnJurorName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnPreActiveName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnIsAbolishedName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnOnControlName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnInactualDocumentName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineOnName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnRedactionName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineWarningName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineExceptionName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remListModifiedName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remListFilteredName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remTimeMachineWarningName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remUnreadConsultationsName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remOnlineDeadName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(TrialModeWarningName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(OldBaseWarningName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(ControlledChangingWarningName, en_File, op_Print, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnJurorName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnPreActiveName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnIsAbolishedName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnOnControlName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnInactualDocumentName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineOnName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnRedactionName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineWarningName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineExceptionName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remListModifiedName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remListFilteredName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remTimeMachineWarningName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remUnreadConsultationsName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remOnlineDeadName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(TrialModeWarningName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(OldBaseWarningName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(ControlledChangingWarningName, en_File, op_PrintDialog, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnJurorName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnPreActiveName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnIsAbolishedName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnOnControlName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnInactualDocumentName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineOnName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnRedactionName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineWarningName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(WarnTimeMachineExceptionName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remListModifiedName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remListFilteredName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remTimeMachineWarningName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remUnreadConsultationsName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(remOnlineDeadName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(TrialModeWarningName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(OldBaseWarningName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(ControlledChangingWarningName, en_File, op_PrintPreview, false);
 {$IfEnd} //not NoVCM
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include ..\View\BaloonWarningUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimWarningBaloonOptions
 TtfwClassRef.Register(TPrimWarningBaloonOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.