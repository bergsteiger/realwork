{$IfNDef BaloonWarningUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "BaloonWarningUserTypes" MUID: (4F5E12C20114)
// Имя типа: "_BaloonWarningUserTypes_"

{$Define BaloonWarningUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _BaloonWarningUserTypes_ = {abstract} class(_BaloonWarningUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_BaloonWarningUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_BaloonWarningUserTypes_ = _BaloonWarningUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaloonWarningUserTypes_imp}

{$IfNDef BaloonWarningUserTypes_imp_impl}

{$Define BaloonWarningUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _BaloonWarningUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(FakeName,
  str_FakeCaption,
  str_FakeCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(FakeName
 with AddUsertype(WarnJurorName,
  str_WarnJurorCaption,
  str_WarnJurorCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnJurorName
 with AddUsertype(WarnPreActiveName,
  str_WarnPreActiveCaption,
  str_WarnPreActiveCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnPreActiveName
 with AddUsertype(WarnIsAbolishedName,
  str_WarnIsAbolishedCaption,
  str_WarnIsAbolishedCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnIsAbolishedName
 with AddUsertype(WarnOnControlName,
  str_WarnOnControlCaption,
  str_WarnOnControlCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnOnControlName
 with AddUsertype(WarnInactualDocumentName,
  str_WarnInactualDocumentCaption,
  str_WarnInactualDocumentCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnInactualDocumentName
 with AddUsertype(WarnTimeMachineOnName,
  str_WarnTimeMachineOnCaption,
  str_WarnTimeMachineOnCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnTimeMachineOnName
 with AddUsertype(WarnRedactionName,
  str_WarnRedactionCaption,
  str_WarnRedactionCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnRedactionName
 with AddUsertype(WarnTimeMachineWarningName,
  str_WarnTimeMachineWarningCaption,
  str_WarnTimeMachineWarningCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnTimeMachineWarningName
 with AddUsertype(WarnTimeMachineExceptionName,
  str_WarnTimeMachineExceptionCaption,
  str_WarnTimeMachineExceptionCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnTimeMachineExceptionName
 with AddUsertype(remListModifiedName,
  str_remListModifiedCaption,
  str_remListModifiedCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remListModifiedName
 with AddUsertype(remListFilteredName,
  str_remListFilteredCaption,
  str_remListFilteredCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remListFilteredName
 with AddUsertype(remTimeMachineWarningName,
  str_remTimeMachineWarningCaption,
  str_remTimeMachineWarningCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remTimeMachineWarningName
 with AddUsertype(remUnreadConsultationsName,
  str_remUnreadConsultationsCaption,
  str_remUnreadConsultationsCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remUnreadConsultationsName
 with AddUsertype(remOnlineDeadName,
  str_remOnlineDeadCaption,
  str_remOnlineDeadCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remOnlineDeadName
 with AddUsertype(TrialModeWarningName,
  str_TrialModeWarningCaption,
  str_TrialModeWarningCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(TrialModeWarningName
 with AddUsertype(OldBaseWarningName,
  str_OldBaseWarningCaption,
  str_OldBaseWarningCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(OldBaseWarningName
 with AddUsertype(ControlledChangingWarningName,
  str_ControlledChangingWarningCaption,
  str_ControlledChangingWarningCaption,
  False,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ControlledChangingWarningName
end;//_BaloonWarningUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf BaloonWarningUserTypes_imp_impl}

{$EndIf BaloonWarningUserTypes_imp}

