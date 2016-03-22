unit LocaleMessages;

interface

type
 TLocaleMessages = (
  c_ApplicationTitle
 // EasyUpdateForm
  , c_EasyUpdateFormCaption
  , c_EasyUpdateFormStatusGroupBoxCaption
  , c_EasyUpdateFormAutomaticUpdateLabelCaption
  , c_EasyUpdateFormNextTimeRunLabelCaption
  , c_EasyUpdateFormLastTimeRunLabelCaption
  , c_EasyUpdateFormLastRunLabel
  , c_EasyUpdateFormHelpBitBtnCaption
  , c_EasyUpdateFormOnBitBtnCaption
  , c_EasyUpdateFormOffBitBtnCaption
  , c_EasyUpdateFormRunBitBtnCaption
  , c_EasyUpdateFormSetupParamsLabelCaption
  , c_EasyUpdateFormAutomaticUpdateStatusToStringFalse
  , c_EasyUpdateFormAutomaticUpdateStatusToStringTrue
  , c_EasyUpdateFormNextTimeToString
  , c_EasyUpdateFormLastTimeToString
  , c_EasyUpdateFormLastRunStatusToString
  , c_EasyUpdateFormLastRunStatusIsStillActiveToString
  , c_EasyUpdateFormTaskNameLabelHintToString
 // EasyUpdateAdminForm
  , c_EasyUpdateAdminFormCaption
  , c_EasyUpdateAdminFormInformationMemoLinesText
  , c_EasyUpdateAdminFormAdminNameLabelCaption
  , c_EasyUpdateAdminFormAdminPasswordLabelCaption
  , c_EasyUpdateAdminFormAdminPasswordCheckLabelCaption
  , c_EasyUpdateAdminFormCommonSaveBitBtnCaption
  , c_EasyUpdateAdminFormCommonCancelBitBtnCaption
  , c_EasyUpdateAdminFormShowInvalidPasswordErrorText
  , c_EasyUpdateAdminFormShowInvalidPasswordErrorCaption
 // EasyUpdateMailForm
  , c_EasyUpdateMailFormCaption
  , c_EasyUpdateMailFormInformationMemoLinesText
  , c_EasyUpdateMailFormMailFromLabelCaption
  , c_EasyUpdateMailFormMailToLabelCaption
  , c_EasyUpdateMailFormMailServerLabelCaption
  , c_EasyUpdateMailFormMailServerUserLabelCaption
  , c_EasyUpdateMailFormMailServerPasswordLabelCaption
  , c_EasyUpdateMailFormCommonSaveBitBtnCaption
  , c_EasyUpdateMailFormCommonCancelBitBtnCaption
 // EasyUpdateParamsForm
  , c_EasyUpdateParamsFormCaption
  , c_EasyUpdateParamsFormDownloadTabSheetCaption
  , c_EasyUpdateParamsFormDownloadRevisionCheckBoxCaption
  , c_EasyUpdateParamsFormDownloadRetryCheckBoxCaption
  , c_EasyUpdateParamsFormDownloadRestoreCheckBoxCaption
  , c_EasyUpdateParamsFormDownloadRestoreMinutesLabelCaption
  , c_EasyUpdateParamsFormDownloadResumeCheckBoxCaption
  , c_EasyUpdateParamsFormDownloadSaveToLabelCaption
  , c_EasyUpdateParamsFormDownloadUserAgentLabelCaption
  , c_EasyUpdateParamsFormDownloadSendReportCheckBoxCaption
  , c_EasyUpdateParamsFormDownloadSendReportStatusLabelTrueCaption
  , c_EasyUpdateParamsFormDownloadSendReportStatusLabelFalseCaption
  , c_EasyUpdateParamsFormDownloadSendReportParametersLabelCaption
  , c_EasyUpdateParamsFormDownloadRestoreAllBitBtnCaption
  , c_EasyUpdateParamsFormUpdateTabSheetCaption
  , c_EasyUpdateParamsFormUpdateNoBackupCheckBoxCaption
  , c_EasyUpdateParamsFormUpdateRemoveZipsCheckBoxCaption
  , c_EasyUpdateParamsFormUpdateSearchInLabelCaption
  , c_EasyUpdateParamsFormUpdateAdminPasswordLabelCaption
  , c_EasyUpdateParamsFormUpdateAdminPasswordCommentLabelCaption
  , c_EasyUpdateParamsFormUpdateSendReportCheckBoxCaption
  , c_EasyUpdateParamsFormUpdateSkipWarningCheckBoxCaption
  , c_EasyUpdateParamsFormUpdateSendReportStatusLabelTrueCaption
  , c_EasyUpdateParamsFormUpdateSendReportStatusLabelFalseCaption
  , c_EasyUpdateParamsFormUpdateSendReportParametersLabelCaption
  , c_EasyUpdateParamsFormUpdateRestoreAllBitBtnCaption
  , c_EasyUpdateParamsFormScheduleTabSheetCaption
  , c_EasyUpdateParamsFormScheduleDownloadEnabledCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleUpdateEnabledCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleRunAtEndCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleRunAtEndCommandLineLabelCaption
  , c_EasyUpdateParamsFormScheduleWeekGroupBoxCaption
  , c_EasyUpdateParamsFormScheduleMondayCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleTuesdayCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleWednesdayCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleThursdayCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleFridayCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleSaturdayCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleSundayCheckBoxCaption
  , c_EasyUpdateParamsFormScheduleRestoreAllBitBtnCaption
  , c_EasyUpdateParamsFormCommonHelpBitBtnCaption
  , c_EasyUpdateParamsFormCommonSaveBitBtnCaption
  , c_EasyUpdateParamsFormCommonCancelBitBtnCaption
  , c_EasyUpdateParamsFormShowInvalidDataFormatErrorText
  , c_EasyUpdateParamsFormShowInvalidDataFormatErrorCaption
 // EasyUpdateSupport
  , c_EasyUpdateSupportDownloadNotTunedText
  , c_EasyUpdateSupportDownloadNotTunedCaption
  , c_EasyUpdateSupportRestoreJobFileText
  , c_EasyUpdateSupportRestoreJobFileCaption
  , c_EasyUpdateSupportSystemNotCompatibleText
  , c_EasyUpdateSupportSystemNotCompatibleCaption
 );

procedure SetCurrentLocale(const a_LocaleValue: string);
function  GetCurrentLocaleMessage(const a_LocaleMessages: TLocaleMessages): string;

implementation

uses
 SysUtils;

var
 g_LocaleMessagesArray: array [TLocaleMessages] of record
  r_Current: PAnsiChar;
  //
  r_English: PAnsiChar;
  r_Russian: PAnsiChar;
 end = (
  (
   r_Current: nil  // c_ApplicationTitle
   ; r_English: 'GARANT aero: Automatic update'
   ; r_Russian: '������ ����: �������������� ����������'
  )
 // EasyUpdateForm
  , (
   r_Current: nil  // c_EasyUpdateFormCaption
   ; r_English: 'GARANT aero: Automatic update'
   ; r_Russian: '������ ����: �������������� ����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormStatusGroupBoxCaption
   ; r_English: 'Status'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormAutomaticUpdateLabelCaption
   ; r_English: 'Automatic update is:'
   ; r_Russian: '�������������� ����������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormNextTimeRunLabelCaption
   ; r_English: 'Next run time:'
   ; r_Russian: '����� ���������� �������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormLastTimeRunLabelCaption
   ; r_English: 'Last run time:'
   ; r_Russian: '����� ���������� �������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormLastRunLabelCaption
   ; r_English: 'Last run status/startup code:'
   ; r_Russian: '������/��� ���������� �������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormHelpBitBtnCaption
   ; r_English: 'Help'
   ; r_Russian: '�������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormOnBitBtnCaption
   ; r_English: 'On'
   ; r_Russian: '��������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormOffBitBtnCaption
   ; r_English: 'Off'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormRunBitBtnCaption
   ; r_English: 'Run'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormSetupParamsLabelCaption
   ; r_English: 'Setup parameters'
   ; r_Russian: '��������� ���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormAutomaticUpdateStatusToStringFalse
   ; r_English: 'Off'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormAutomaticUpdateStatusToStringTrue
   ; r_English: 'On'
   ; r_Russian: '��������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormNextTimeToString
   ; r_English: 'Not set'
   ; r_Russian: '�� �����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormLastTimeToString
   ; r_English: 'Not set'
   ; r_Russian: '�� �����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormLastRunStatusToString
   ; r_English: 'Not defined'
   ; r_Russian: '�� ����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormLastRunStatusIsStillActiveToString
   ; r_English: 'Running'
   ; r_Russian: '�����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateFormTaskNameLabelHintToString
   ; r_English: 'Task name'
   ; r_Russian: '��� �������'
  )
 // EasyUpdateAdminForm
  , (
   r_Current: nil  // c_EasyUpdateAdminFormCaption
   ; r_English: 'GARANT: Parameters for ADMIN user'
   ; r_Russian: '������: ��������� ������ ������������ ADMIN'
  )
  , (
   r_Current: nil  // c_EasyUpdateAdminFormInformationMemoLinesText
   ; r_English: ' If the administrator account password in GARANT System (ADMIN) is different from the default one,'
                + ' to launch the updating procedure in the automatic mode please enter a new password in the fields'
                + ' User Password and Confirm User Password.'
   ; r_Russian: ' ���� ������ ����������������� ������� ������ � ������� ������ (ADMIN) ���������� �� �������������� ��������,'
                + ' ��� ������� ��������� ���������� ���������� � �������������� ������, �������, ����������,'
                + ' ����� �������� ������ � ���� "������ ������������" � "����������� ������ ������������".'
  )
  , (
   r_Current: nil  // c_EasyUpdateAdminFormAdminNameLabelCaption
   ; r_English: 'Enter user name:'
   ; r_Russian: '������� ��� ������������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateAdminFormAdminPasswordLabelCaption
   ; r_English: 'Enter user password:'
   ; r_Russian: '������� ������ ������������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateAdminFormAdminPasswordCheckLabelCaption
   ; r_English: 'Confirm user password:'
   ; r_Russian: '����������� ������ ������������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateAdminFormCommonSaveBitBtnCaption
   ; r_English: 'Save'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateAdminFormCommonCancelBitBtnCaption
   ; r_English: 'Cancel'
   ; r_Russian: '��������'
  )
  , (
   r_Current: nil  // c_EasyUpdateAdminFormShowInvalidPasswordErrorText
   ; r_English: 'Password and password confirmation do not match'
   ; r_Russian: '��������� ������ �� ���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateAdminFormShowInvalidPasswordErrorCaption
   ; r_English: 'ERROR'
   ; r_Russian: '������'
  )
 // EasyUpdateMailForm
  , (
   r_Current: nil  // c_EasyUpdateMailFormCaption
   ; r_English: 'GARANT: Mail parameters'
   ; r_Russian: '������: ��������� �����'
  )
  , (
   r_Current: nil  // c_EasyUpdateMailFormInformationMemoLinesText
   ; r_English: ' For notification by e-mail of the termination of downloading and/or application of updating files, please, indicate the settings parameters, including:'#13
               + '   - sender e-mail address (to be used to send the notification);'#13
               + '   - recipient e-mail address (to be used to receive the notification);'#13
               + '   - outgoing mail server name (SMTP server to be used to send the notification).'
   ; r_Russian: ' ��� ����������� �� ����������� ����� � ���������� ���������� �(���) ���������� ������ ����������, �������, ����������, ��������� ��������, � ��� �����:'#13
               + '   - ����������� ����� ����������� (� �������� ����� ������������ �����������);'#13
               + '   - ����������� ����� ���������� (�� ������� ����� ��������� �����������);'#13
               + '   - ��� ������� ��������� ����� (SMTP-������, � �������� ����� ������������ �����������).'
  )
  , (
   r_Current: nil  // c_EasyUpdateMailFormMailFromLabelCaption
   ; r_English: 'Enter sender e-mail address:'
   ; r_Russian: '������� ����������� ����� �����������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateMailFormMailToLabelCaption
   ; r_English: 'Enter recipient e-mail address:'
   ; r_Russian: '������� ����������� ����� ����������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateMailFormMailServerLabelCaption
   ; r_English: 'Enter outgoing mail server name:'
   ; r_Russian: '������� ��� ������� ��������� �����:'
  )
  , (
   r_Current: nil  // c_EasyUpdateMailFormMailServerUserLabelCaption
   ; r_English: 'Enter outgoing mail server login:'
   ; r_Russian: '������� ����� �� �������� �������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateMailFormMailServerPasswordLabelCaption
   ; r_English: 'Enter outgoing mail server password:'
   ; r_Russian: '������� ������ �� �������� �������:'
  )
  , (
   r_Current: nil  // c_EasyUpdateMailFormCommonSaveBitBtnCaption
   ; r_English: 'Save'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateMailFormCommonCancelBitBtnCaption
   ; r_English: 'Cancel'
   ; r_Russian: '��������'
  )
 // EasyUpdateParamsForm
  , (
   r_Current: nil  // c_EasyUpdateParamsFormCaption
   ; r_English: 'GARANT: Automatic update parameters'
   ; r_Russian: '������: ��������� ��������������� ����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadTabSheetCaption
   ; r_English: 'Download updates'
   ; r_Russian: '���������� ����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadRevisionCheckBoxCaption
   ; r_English: 'Permit follow-up downloading'
   ; r_Russian: '��������� ��������� ����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadRetryCheckBoxCaption
   ; r_English: 'If no updates available, check for them each 20 minutes'
   ; r_Russian: '� ������ ���������� ���������� ��������� ������� ���������� ������ 20 �����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadRestoreCheckBoxCaption
   ; r_English: 'If connection lost, retry within'
   ; r_Russian: '��� ������ ���������� �������� ��������������� � �������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadRestoreMinutesLabelCaption
   ; r_English: 'minutes'
   ; r_Russian: '�����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadResumeCheckBoxCaption
   ; r_English: 'Continue interrupted downloading next time'
   ; r_Russian: '���������� ���������� ���������� ��� ��������� �������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadSaveToLabelCaption
   ; r_English: 'Save updates to'
   ; r_Russian: '��������� ���������� �'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadUserAgentLabelCaption
   ; r_English: 'Identify as'
   ; r_Russian: '���������������� ���'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadSendReportCheckBoxCaption
   ; r_English: 'At end of download send mail report'
   ; r_Russian: '�� ���������� ���������� �������� ����������� �� �����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadSendReportStatusLabelTrueCaption
   ; r_English: '[Parameters exist]'
   ; r_Russian: '[��������� ���������]'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadSendReportStatusLabelFalseCaption
   ; r_English: '[Parameters not exist]'
   ; r_Russian: '[��������� ��������]'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadSendReportParametersLabelCaption
   ; r_English: 'Setup mail parameters'
   ; r_Russian: '��������� ��������� �����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormDownloadRestoreAllBitBtnCaption
   ; r_English: 'Restore to default values'
   ; r_Russian: '������������ �������� �� ���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateTabSheetCaption
   ; r_English: 'Apply updates'
   ; r_Russian: '���������� ����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateNoBackupCheckBoxCaption
   ; r_English: 'No backups (not recommended!)'
   ; r_Russian: '���������� �� �������� ��������� ����� (�� �������������!)'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateRemoveZipsCheckBoxCaption
   ; r_English: 'Remove updates from Archive folder'
   ; r_Russian: '������� ������ ������������� ���������� �� ����������� Archive'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateSearchInLabelCaption
   ; r_English: 'Looking for updates in'
   ; r_Russian: '������ ���������� �'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateAdminPasswordLabelCaption
   ; r_English: 'Set user password for ADMIN'
   ; r_Russian: '������ ������ ������������ ADMIN'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateAdminPasswordCommentLabelCaption
   ; r_English: '(unless set as default)'
   ; r_Russian: '(���� �� ���������� �� ��������������)'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateSendReportCheckBoxCaption
   ; r_English: 'At end of apply send mail report'
   ; r_Russian: '�� ���������� ���������� �������� ����������� �� �����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateSkipWarningCheckBoxCaption
   ; r_English: 'Launch update even in the absence of space'
   ; r_Russian: '��������� ���������� ���� � ������ �������� �����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateSendReportStatusLabelTrueCaption
   ; r_English: '[Parameters exist]'
   ; r_Russian: '[��������� ���������]'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateSendReportStatusLabelFalseCaption
   ; r_English: '[Parameters not exist]'
   ; r_Russian: '[��������� ��������]'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateSendReportParametersLabelCaption
   ; r_English: 'Setup mail parameters'
   ; r_Russian: '��������� ��������� �����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormUpdateRestoreAllBitBtnCaption
   ; r_English: 'Restore default values'
   ; r_Russian: '������������ �������� �� ���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleTabSheetCaption
   ; r_English: 'Schedule'
   ; r_Russian: '����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleDownloadEnabledCheckBoxCaption
   ; r_English: 'Enable automatic updates download'
   ; r_Russian: '�������� �������������� ���������� ����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleUpdateEnabledCheckBoxCaption
   ; r_English: 'Enable automatic updates apply'
   ; r_Russian: '�������� �������������� ���������� ����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleRunAtEndCheckBoxCaption
   ; r_English: 'Run at end'
   ; r_Russian: '��������� � �����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleRunAtEndCommandLineLabelCaption
   ; r_English: 'with parameters'
   ; r_Russian: '� �����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleWeekGroupBoxCaption
   ; r_English: 'Run any'
   ; r_Russian: '��������� ������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleMondayCheckBoxCaption
   ; r_English: 'Monday'
   ; r_Russian: '�����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleTuesdayCheckBoxCaption
   ; r_English: 'Tuesday'
   ; r_Russian: '�������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleWednesdayCheckBoxCaption
   ; r_English: 'Wednesday'
   ; r_Russian: '�����'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleThursdayCheckBoxCaption
   ; r_English: 'Thursday'
   ; r_Russian: '�������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleFridayCheckBoxCaption
   ; r_English: 'Friday'
   ; r_Russian: '�������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleSaturdayCheckBoxCaption
   ; r_English: 'Saturday'
   ; r_Russian: '�������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleSundayCheckBoxCaption
   ; r_English: 'Sunday'
   ; r_Russian: '�����������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormScheduleRestoreAllBitBtnCaption
   ; r_English: 'Restore default values'
   ; r_Russian: '������������ �������� �� ���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormCommonHelpBitBtnCaption
   ; r_English: 'Help'
   ; r_Russian: '�������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormCommonSaveBitBtnCaption
   ; r_English: 'Save'
   ; r_Russian: '���������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormCommonCancelBitBtnCaption
   ; r_English: 'Cancel'
   ; r_Russian: '��������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormShowInvalidDataFormatErrorText
   ; r_English: 'Data format invalid'
   ; r_Russian: '������������ ������ ������'
  )
  , (
   r_Current: nil  // c_EasyUpdateParamsFormShowInvalidDataFormatErrorCaption
   ; r_English: 'ERROR'
   ; r_Russian: '������'
  )
  , (
   r_Current: nil  // c_EasyUpdateSupportDownloadNotTunedText
   ; r_English: 'Please download update files in manual mode once'
   ; r_Russian: '����� ������� ������ ��������� ��������� ��������������� ���������� ����� ���� ��� ������� ����� ���������� � ������ ������'
  )
  , (
   r_Current: nil  // c_EasyUpdateSupportDownloadNotTunedCaption
   ; r_English: 'ERROR'
   ; r_Russian: '������'
  )
  , (
   r_Current: nil  // c_EasyUpdateSupportRestoreJobFileText
   ; r_English: 'Can not restore job-file'
   ; r_Russian: '�� ���� ������������ job-����'
  )
  , (
   r_Current: nil  // c_EasyUpdateSupportRestoreJobFileCaption
   ; r_English: 'WARNING'
   ; r_Russian: '��������������'
  )
  , (
   r_Current: nil  // c_EasyUpdateSupportSystemNotCompatibleText
   ; r_English: 'This program is compatible with Windows 2000 and upwards'
   ; r_Russian: '������ ��������� ������������� ������ ��� ������ ��� Windows 2000 � ����'
  )
  , (
   r_Current: nil  // c_EasyUpdateSupportSystemNotCompatibleCaption
   ; r_English: 'ERROR'
   ; r_Russian: '������'
  )
 );

procedure SetCurrentLocale(const a_LocaleValue: string);
const
 c_English = 1;
 c_Russian = 2;

 c_Default = c_English;
 //
 function GetLanguage(const a_LocaleValue: string): Word;
 begin
  Result := c_Default;
  //
  if (StrLIComp(PAnsiChar(a_LocaleValue), PAnsiChar('en'), 2) = 0) then
   Result := c_English
  else
   if (StrLIComp(PAnsiChar(a_LocaleValue), PAnsiChar('ru'), 2) = 0) then
    Result := c_Russian;
 end;
 //
var
 l_Index: TLocaleMessages;
 l_Language: Word;
begin
 l_Language := GetLanguage(a_LocaleValue);
 //
 for l_Index := Low(g_LocaleMessagesArray) to High(g_LocaleMessagesArray) do
  case l_Language of
   c_English: g_LocaleMessagesArray[l_Index].r_Current := g_LocaleMessagesArray[l_Index].r_English;
   c_Russian: g_LocaleMessagesArray[l_Index].r_Current := g_LocaleMessagesArray[l_Index].r_Russian;
  else
   g_LocaleMessagesArray[l_Index].r_Current := g_LocaleMessagesArray[l_Index].r_English;
  end;
end;

function GetCurrentLocaleMessage(const a_LocaleMessages: TLocaleMessages): string;
begin
 Result := g_LocaleMessagesArray[a_LocaleMessages].r_Current;
end;

initialization SetCurrentLocale('$(UserDefaultLocale)'); // First initialization as User Default Locale (== English now)

end.

