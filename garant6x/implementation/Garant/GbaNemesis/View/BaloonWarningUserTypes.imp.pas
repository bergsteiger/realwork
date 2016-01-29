{$IfNDef BaloonWarningUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaloonWarningUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BaloonWarningUserTypes_ = {abstract form} class(_BaloonWarningUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_BaloonWarningUserTypes_
{$Else}

 _BaloonWarningUserTypes_ = _BaloonWarningUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaloonWarningUserTypes_imp}

{$IfNDef BaloonWarningUserTypes_imp_impl}
{$Define BaloonWarningUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ FakeLocalConstants }
  str_FakeCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FakeCaption'; rValue : '��������������');
   { ��������� ����������������� ���� "��������������" }

var
   { ������������ ������ WarnJurorLocalConstants }
  str_WarnJurorCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnJurorCaption'; rValue : '����������� ��������������');
   { ��������� ����������������� ���� "����������� ��������������" }

var
   { ������������ ������ WarnPreActiveLocalConstants }
  str_WarnPreActiveCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnPreActiveCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ WarnIsAbolishedLocalConstants }
  str_WarnIsAbolishedCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnIsAbolishedCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ WarnOnControlLocalConstants }
  str_WarnOnControlCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnOnControlCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ WarnInactualDocumentLocalConstants }
  str_WarnInactualDocumentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnInactualDocumentCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ WarnTimeMachineOnLocalConstants }
  str_WarnTimeMachineOnCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineOnCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ WarnRedactionLocalConstants }
  str_WarnRedactionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnRedactionCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ WarnTimeMachineWarningLocalConstants }
  str_WarnTimeMachineWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineWarningCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ WarnTimeMachineExceptionLocalConstants }
  str_WarnTimeMachineExceptionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineExceptionCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ remListModifiedLocalConstants }
  str_remListModifiedCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListModifiedCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ remListFilteredLocalConstants }
  str_remListFilteredCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListFilteredCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ remTimeMachineWarningLocalConstants }
  str_remTimeMachineWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remTimeMachineWarningCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ remUnreadConsultationsLocalConstants }
  str_remUnreadConsultationsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remUnreadConsultationsCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ remOnlineDeadLocalConstants }
  str_remOnlineDeadCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remOnlineDeadCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ TrialModeWarningLocalConstants }
  str_TrialModeWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TrialModeWarningCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ OldBaseWarningLocalConstants }
  str_OldBaseWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldBaseWarningCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

var
   { ������������ ������ ControlledChangingWarningLocalConstants }
  str_ControlledChangingWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ControlledChangingWarningCaption'; rValue : '');
   { ��������� ����������������� ���� "" }

// start class _BaloonWarningUserTypes_

procedure _BaloonWarningUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(FakeName,
  str_FakeCaption,
  str_FakeCaption,
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
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
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ControlledChangingWarningName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  BaloonWarningUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_FakeCaption
 str_FakeCaption.Init;
// ������������� str_WarnJurorCaption
 str_WarnJurorCaption.Init;
// ������������� str_WarnPreActiveCaption
 str_WarnPreActiveCaption.Init;
// ������������� str_WarnIsAbolishedCaption
 str_WarnIsAbolishedCaption.Init;
// ������������� str_WarnOnControlCaption
 str_WarnOnControlCaption.Init;
// ������������� str_WarnInactualDocumentCaption
 str_WarnInactualDocumentCaption.Init;
// ������������� str_WarnTimeMachineOnCaption
 str_WarnTimeMachineOnCaption.Init;
// ������������� str_WarnRedactionCaption
 str_WarnRedactionCaption.Init;
// ������������� str_WarnTimeMachineWarningCaption
 str_WarnTimeMachineWarningCaption.Init;
// ������������� str_WarnTimeMachineExceptionCaption
 str_WarnTimeMachineExceptionCaption.Init;
// ������������� str_remListModifiedCaption
 str_remListModifiedCaption.Init;
// ������������� str_remListFilteredCaption
 str_remListFilteredCaption.Init;
// ������������� str_remTimeMachineWarningCaption
 str_remTimeMachineWarningCaption.Init;
// ������������� str_remUnreadConsultationsCaption
 str_remUnreadConsultationsCaption.Init;
// ������������� str_remOnlineDeadCaption
 str_remOnlineDeadCaption.Init;
// ������������� str_TrialModeWarningCaption
 str_TrialModeWarningCaption.Init;
// ������������� str_OldBaseWarningCaption
 str_OldBaseWarningCaption.Init;
// ������������� str_ControlledChangingWarningCaption
 str_ControlledChangingWarningCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaloonWarningUserTypes_imp_impl}
{$EndIf BaloonWarningUserTypes_imp}
