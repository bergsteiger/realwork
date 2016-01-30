{$IfNDef BaloonWarningUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes.imp.pas"
// ���������: "VCMForm"

{$Define BaloonWarningUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _BaloonWarningUserTypes_ = {abstract} class(_BaloonWarningUserTypes_Parent_)
 end;//_BaloonWarningUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_BaloonWarningUserTypes_ = _BaloonWarningUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaloonWarningUserTypes_imp}

{$IfNDef BaloonWarningUserTypes_imp_impl}

{$Define BaloonWarningUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ FakeLocalConstants }
 str_FakeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FakeCaption'; rValue : '��������������');
  {* ��������� ����������������� ���� "��������������" }
 {* ������������ ������ WarnJurorLocalConstants }
 str_WarnJurorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnJurorCaption'; rValue : '����������� ��������������');
  {* ��������� ����������������� ���� "����������� ��������������" }
 {* ������������ ������ WarnPreActiveLocalConstants }
 str_WarnPreActiveCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnPreActiveCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ WarnIsAbolishedLocalConstants }
 str_WarnIsAbolishedCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnIsAbolishedCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ WarnOnControlLocalConstants }
 str_WarnOnControlCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnOnControlCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ WarnInactualDocumentLocalConstants }
 str_WarnInactualDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnInactualDocumentCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ WarnTimeMachineOnLocalConstants }
 str_WarnTimeMachineOnCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineOnCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ WarnRedactionLocalConstants }
 str_WarnRedactionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnRedactionCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ WarnTimeMachineWarningLocalConstants }
 str_WarnTimeMachineWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineWarningCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ WarnTimeMachineExceptionLocalConstants }
 str_WarnTimeMachineExceptionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineExceptionCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ remListModifiedLocalConstants }
 str_remListModifiedCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListModifiedCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ remListFilteredLocalConstants }
 str_remListFilteredCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListFilteredCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ remTimeMachineWarningLocalConstants }
 str_remTimeMachineWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remTimeMachineWarningCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ remUnreadConsultationsLocalConstants }
 str_remUnreadConsultationsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remUnreadConsultationsCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ remOnlineDeadLocalConstants }
 str_remOnlineDeadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remOnlineDeadCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ TrialModeWarningLocalConstants }
 str_TrialModeWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TrialModeWarningCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ OldBaseWarningLocalConstants }
 str_OldBaseWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldBaseWarningCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ������������ ������ ControlledChangingWarningLocalConstants }
 str_ControlledChangingWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ControlledChangingWarningCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }

{$Else BaloonWarningUserTypes_imp_impl}

 str_FakeCaption.Init;
 {* ������������� str_FakeCaption }
 str_WarnJurorCaption.Init;
 {* ������������� str_WarnJurorCaption }
 str_WarnPreActiveCaption.Init;
 {* ������������� str_WarnPreActiveCaption }
 str_WarnIsAbolishedCaption.Init;
 {* ������������� str_WarnIsAbolishedCaption }
 str_WarnOnControlCaption.Init;
 {* ������������� str_WarnOnControlCaption }
 str_WarnInactualDocumentCaption.Init;
 {* ������������� str_WarnInactualDocumentCaption }
 str_WarnTimeMachineOnCaption.Init;
 {* ������������� str_WarnTimeMachineOnCaption }
 str_WarnRedactionCaption.Init;
 {* ������������� str_WarnRedactionCaption }
 str_WarnTimeMachineWarningCaption.Init;
 {* ������������� str_WarnTimeMachineWarningCaption }
 str_WarnTimeMachineExceptionCaption.Init;
 {* ������������� str_WarnTimeMachineExceptionCaption }
 str_remListModifiedCaption.Init;
 {* ������������� str_remListModifiedCaption }
 str_remListFilteredCaption.Init;
 {* ������������� str_remListFilteredCaption }
 str_remTimeMachineWarningCaption.Init;
 {* ������������� str_remTimeMachineWarningCaption }
 str_remUnreadConsultationsCaption.Init;
 {* ������������� str_remUnreadConsultationsCaption }
 str_remOnlineDeadCaption.Init;
 {* ������������� str_remOnlineDeadCaption }
 str_TrialModeWarningCaption.Init;
 {* ������������� str_TrialModeWarningCaption }
 str_OldBaseWarningCaption.Init;
 {* ������������� str_OldBaseWarningCaption }
 str_ControlledChangingWarningCaption.Init;
 {* ������������� str_ControlledChangingWarningCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf BaloonWarningUserTypes_imp_impl}

{$EndIf BaloonWarningUserTypes_imp}

