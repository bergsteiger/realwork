unit PrimWarningBaloonOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimWarningBaloonOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimWarningBaloonOptions" MUID: (4EA599F501CF)
// Имя типа: "TPrimWarningBaloonOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _BaloonWarningUserTypes_Parent_ = TPrimWarningOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes.imp.pas}
 TPrimWarningBaloonOptionsForm = class(_BaloonWarningUserTypes_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   function IsBaloon: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimWarningBaloonOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , BaloonWarningUserTypes_WarnJuror_UserType
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_WarnTimeMachineOn_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType
 , BaloonWarningUserTypes_remListModified_UserType
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , BaloonWarningUserTypes_remUnreadConsultations_UserType
 , BaloonWarningUserTypes_remOnlineDead_UserType
 , BaloonWarningUserTypes_TrialModeWarning_UserType
 , BaloonWarningUserTypes_OldBaseWarning_UserType
 , BaloonWarningUserTypes_ControlledChangingWarning_UserType
 , Document_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4EA599F501CFimpl_uses*
 //#UC END# *4EA599F501CFimpl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes.imp.pas}

{$If NOT Defined(NoVCM)}
function TPrimWarningBaloonOptionsForm.IsBaloon: Boolean;
//#UC START# *4F748C5A00CB_4EA599F501CF_var*
//#UC END# *4F748C5A00CB_4EA599F501CF_var*
begin
//#UC START# *4F748C5A00CB_4EA599F501CF_impl*
 Result := true;
//#UC END# *4F748C5A00CB_4EA599F501CF_impl*
end;//TPrimWarningBaloonOptionsForm.IsBaloon
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWarningBaloonOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_Warning, op_TimeMachineOffAndReset, False);
  ShowInToolbar(en_Warning, op_TimeMachineOffAndReset, False);
 end;//with Entities.Entities
 AddUserTypeExclude(WarnJurorName, en_File, op_Print, False);
 AddUserTypeExclude(WarnJurorName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnJurorName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(WarnPreActiveName, en_File, op_Print, False);
 AddUserTypeExclude(WarnPreActiveName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnPreActiveName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(WarnIsAbolishedName, en_File, op_Print, False);
 AddUserTypeExclude(WarnIsAbolishedName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnIsAbolishedName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(WarnOnControlName, en_File, op_Print, False);
 AddUserTypeExclude(WarnOnControlName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnOnControlName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(WarnInactualDocumentName, en_File, op_Print, False);
 AddUserTypeExclude(WarnInactualDocumentName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnInactualDocumentName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(WarnTimeMachineOnName, en_File, op_Print, False);
 AddUserTypeExclude(WarnTimeMachineOnName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnTimeMachineOnName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(WarnRedactionName, en_File, op_Print, False);
 AddUserTypeExclude(WarnRedactionName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnRedactionName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(WarnTimeMachineWarningName, en_File, op_Print, False);
 AddUserTypeExclude(WarnTimeMachineWarningName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnTimeMachineWarningName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(WarnTimeMachineExceptionName, en_File, op_Print, False);
 AddUserTypeExclude(WarnTimeMachineExceptionName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarnTimeMachineExceptionName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(remListModifiedName, en_File, op_Print, False);
 AddUserTypeExclude(remListModifiedName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(remListModifiedName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(remListFilteredName, en_File, op_Print, False);
 AddUserTypeExclude(remListFilteredName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(remListFilteredName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(remTimeMachineWarningName, en_File, op_Print, False);
 AddUserTypeExclude(remTimeMachineWarningName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(remTimeMachineWarningName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(remUnreadConsultationsName, en_File, op_Print, False);
 AddUserTypeExclude(remUnreadConsultationsName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(remUnreadConsultationsName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(remOnlineDeadName, en_File, op_Print, False);
 AddUserTypeExclude(remOnlineDeadName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(remOnlineDeadName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(TrialModeWarningName, en_File, op_Print, False);
 AddUserTypeExclude(TrialModeWarningName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(TrialModeWarningName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(OldBaseWarningName, en_File, op_Print, False);
 AddUserTypeExclude(OldBaseWarningName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(OldBaseWarningName, en_File, op_PrintPreview, False);
 AddUserTypeExclude(ControlledChangingWarningName, en_File, op_Print, False);
 AddUserTypeExclude(ControlledChangingWarningName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(ControlledChangingWarningName, en_File, op_PrintPreview, False);
end;//TPrimWarningBaloonOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWarningBaloonOptionsForm);
 {* Регистрация PrimWarningBaloonOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
