unit EasyUpdateParamsForm;

interface

uses
 Windows
 , Buttons
 , Classes
 , ComCtrls
 , Controls
 , Dialogs
 , ExtCtrls
 , FileCtrl
 , Forms
 , Mask
 , StdCtrls
 , SysUtils
 //
 , EasyUpdateAdminForm
 , EasyUpdateMailForm
 //
 , EasyUpdateSupport
 //
 , LocaleMessages
 ;

type
 TEasyUpdateParamsForm = class(TForm)
  f_MainPanel: TPanel;
   f_MainPageControl: TPageControl;
    f_DownloadTabSheet: TTabSheet;
     f_DownloadRevisionCheckBox: TCheckBox;
     f_DownloadRetryCheckBox: TCheckBox;
     f_DownloadRestoreCheckBox: TCheckBox;
     f_DownloadRestoreEdit: TEdit;
     f_DownloadRestoreMinutesLabel: TLabel;
     f_DownloadResumeCheckBox: TCheckBox;
     f_DownloadSaveToLabel: TLabel;
     f_DownloadSaveToEdit: TEdit;
     f_DownloadSaveToSelectButton: TButton;
     f_DownloadUserAgentLabel: TLabel;
     f_DownloadUserAgentEdit: TEdit;
     f_DownloadSendReportCheckBox: TCheckBox;
     f_DownloadSendReportStatusLabel: TLabel;
     f_DownloadSendReportParametersLabel: TLabel;
     f_DownloadRestoreAllBitBtn: TBitBtn;
    f_UpdateTabSheet: TTabSheet;
     f_UpdateNoBackupCheckBox: TCheckBox;
     f_UpdateRemoveZipsCheckBox: TCheckBox;
     f_UpdateSearchInLabel: TLabel;
     f_UpdateSearchInEdit: TEdit;
     f_UpdateSearchInSelectButton: TButton;
     f_UpdateAdminPasswordLabel: TLabel;
     f_UpdateAdminPasswordCommentLabel: TLabel;
     f_UpdateSendReportCheckBox: TCheckBox;
     f_UpdateSkipWarningCheckBox: TCheckBox;
     f_UpdateSendReportStatusLabel: TLabel;
     f_UpdateSendReportParametersLabel: TLabel;
     f_UpdateRestoreAllBitBtn: TBitBtn;
    f_ScheduleTabSheet: TTabSheet;
     f_ScheduleDownloadEnabledCheckBox: TCheckBox;
     f_ScheduleUpdateEnabledCheckBox: TCheckBox;
     f_ScheduleRunAtEndCheckBox: TCheckBox;
     f_ScheduleRunAtEndApplicationEdit: TEdit;
     f_ScheduleRunAtEndApplicationButton: TButton;
     f_ScheduleRunAtEndCommandLineLabel: TLabel;
     f_ScheduleRunAtEndCommandLineEdit: TEdit;
     f_ScheduleWeekGroupBox: TGroupBox;
      f_ScheduleMondayCheckBox: TCheckBox;
      f_ScheduleMondayEdit: TEdit;
      f_ScheduleTuesdayCheckBox: TCheckBox;
      f_ScheduleTuesdayEdit: TEdit;
      f_ScheduleWednesdayCheckBox: TCheckBox;
      f_ScheduleWednesdayEdit: TEdit;
      f_ScheduleThursdayCheckBox: TCheckBox;
      f_ScheduleThursdayEdit: TEdit;
      f_ScheduleFridayCheckBox: TCheckBox;
      f_ScheduleFridayEdit: TEdit;
      f_ScheduleSaturdayCheckBox: TCheckBox;
      f_ScheduleSaturdayEdit: TEdit;
      f_ScheduleSundayCheckBox: TCheckBox;
      f_ScheduleSundayEdit: TEdit;
      f_ScheduleRestoreAllBitBtn: TBitBtn;
  f_BottomPanel: TPanel;
   f_CommonHelpBitBtn: TBitBtn;
   f_CommonSaveBitBtn: TBitBtn;
   f_CommonCancelBitBtn: TBitBtn;
  f_ScheduleRunAtEndOpenDialog: TOpenDialog;
  //
  procedure FormCreate(a_Sender: TObject);
  //
  procedure DownloadRestoreEditExit(a_Sender: TObject);
  //
  procedure DownloadSaveToSelectButtonClick(a_Sender: TObject);
  //
  procedure DownloadRestoreAllBitBtnClick(a_Sender: TObject);
  //
  procedure UpdateAdminPasswordLabelClick(a_Sender: TObject);
  //
  procedure UpdateSearchInSelectButtonClick(a_Sender: TObject);
  //
  procedure UpdateRestoreAllBitBtnClick(a_Sender: TObject);
  //
  procedure ScheduleRunAtEndCheckBoxClick(Sender: TObject);
  procedure ScheduleRunAtEndButtonClick(a_Sender: TObject);
  //
  procedure ScheduleMondayCheckBoxClick(a_Sender: TObject);
  procedure ScheduleMondayEditExit(a_Sender: TObject);
  //
  procedure ScheduleTuesdayCheckBoxClick(a_Sender: TObject);
  procedure ScheduleTuesdayEditExit(a_Sender: TObject);
  //
  procedure ScheduleWednesdayCheckBoxClick(a_Sender: TObject);
  procedure ScheduleWednesdayEditExit(a_Sender: TObject);
  //
  procedure ScheduleThursdayCheckBoxClick(a_Sender: TObject);
  procedure ScheduleThursdayEditExit(a_Sender: TObject);
  //
  procedure ScheduleFridayCheckBoxClick(a_Sender: TObject);
  procedure ScheduleFridayEditExit(a_Sender: TObject);
  //
  procedure ScheduleSaturdayCheckBoxClick(a_Sender: TObject);
  procedure ScheduleSaturdayEditExit(a_Sender: TObject);
  //
  procedure ScheduleSundayCheckBoxClick(a_Sender: TObject);
  procedure ScheduleSundayEditExit(a_Sender: TObject);
  //
  procedure ScheduleRestoreAllBitBtnClick(a_Sender: TObject);
  //
  procedure SendReportParametersLabelClick(a_Sender: TObject);
  //
  procedure CommonHelpBitBtnClick(a_Sender: TObject);
  procedure CommonSaveBitBtnClick(a_Sender: TObject);
 private
  class procedure ShowInvalidDataFormatError;
  //
  class function  ValidateMinutes(const a_Text: string; const a_WinControl: TWinControl): string;
  class function  ValidateTime(const a_Text: string; const a_WinControl: TWinControl): string;
 private
  class function  ReplaceRootFolder(const a_Path: string): string;
 private
  procedure InvalidateStatus;
  //
  procedure InvalidateApplyStatus(
   const a_NoBackupFlag: Boolean
   ; const a_RemoveArchiveFlag: Boolean
   ; const a_LookIn: string
   ; const a_SendReport: Boolean
   ; const a_SkipWarning: Boolean
  );
  //
  procedure InvalidateLoadStatus(
   const a_RevisionFlag: Boolean
   ; const a_RetryFlag: Boolean
   ; const a_RestoreFlag: Boolean
   ; const a_RestoreTime: Integer
   ; const a_ResumeFlag: Boolean
   ; const a_SaveTo: string
   ; const a_Process: string
   ; const a_SendReport: Boolean
  );
  //
  procedure InvalidateScheduleStatus(
   const a_AutoUpdate: Boolean
   ; const a_AutoApply: Boolean
   ; const a_RunAtEnd: Boolean
   ; const a_RunAtEndApplication: string
   ; const a_RunAtEndCommandLine: string
   ; const a_Monday: TDateTime
   ; const a_Tuesday: TDateTime
   ; const a_Wednesday: TDateTime
   ; const a_Thursday: TDateTime
   ; const a_Friday: TDateTime
   ; const a_Saturday: TDateTime
   ; const a_Sunday: TDateTime
  );
 private
  f_DownloadRevisionCheckBoxState: Boolean;
  //
  f_DownloadRetryCheckBoxState: Boolean;
  //
  f_DownloadRestoreCheckBoxState: Boolean;
  f_DownloadRestoreEditState: string;
  //
  f_DownloadResumeCheckBoxState: Boolean;
  //
  f_DownloadSaveToEditState: string;
  //
  f_DownloadUserAgentEditState: string;
  //
  f_DownloadSendReportCheckBoxState: Boolean;
  //
  f_UpdateNoBackupCheckBoxState: Boolean;
  //
  f_UpdateRemoveZipsCheckBoxState: Boolean;
  //
  f_UpdateSearchInEditState: string;
  //
  f_UpdateSendReportCheckBoxState: Boolean;
  //
  f_UpdateSkipWarningCheckBoxState: Boolean;
  //
  f_ScheduleDownloadEnabledCheckBoxState: Boolean;
  //
  f_ScheduleUpdateEnabledCheckBoxState: Boolean;
  //
  f_ScheduleRunAtEndCheckBoxState: Boolean;
  f_ScheduleRunAtEndApplicationEditState: string;
  f_ScheduleRunAtEndCommandLineEditState: string;
  //
  f_ScheduleMondayCheckBoxState: Boolean;
  f_ScheduleMondayEditState: string;
  //
  f_ScheduleTuesdayCheckBoxState: Boolean;
  f_ScheduleTuesdayEditState: string;
  //
  f_ScheduleWednesdayCheckBoxState: Boolean;
  f_ScheduleWednesdayEditState: string;
  //
  f_ScheduleThursdayCheckBoxState: Boolean;
  f_ScheduleThursdayEditState: string;
  //
  f_ScheduleFridayCheckBoxState: Boolean;
  f_ScheduleFridayEditState: string;
  //
  f_ScheduleSaturdayCheckBoxState: Boolean;
  f_ScheduleSaturdayEditState: string;
  //
  f_ScheduleSundayCheckBoxState: Boolean;
  f_ScheduleSundayEditState: string;
 public
  procedure StoreState;
  procedure RestoreState;
 end;

var
  g_EasyUpdateParamsForm: TEasyUpdateParamsForm;

implementation {$R *.dfm}

var
 g_LocalFormatSettings: TFormatSettings;

procedure TEasyUpdateParamsForm.FormCreate(a_Sender: TObject);
begin
 Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormCaption);
 //
 f_DownloadTabSheet.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadTabSheetCaption);
 //
 f_DownloadRevisionCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadRevisionCheckBoxCaption);
 //
 f_DownloadRetryCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadRetryCheckBoxCaption);
 //
 f_DownloadRestoreCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadRestoreCheckBoxCaption);
 f_DownloadRestoreMinutesLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadRestoreMinutesLabelCaption);
 //
 f_DownloadResumeCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadResumeCheckBoxCaption);
 //
 f_DownloadSaveToLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadSaveToLabelCaption);
 //
 f_DownloadUserAgentLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadUserAgentLabelCaption);
 //
 f_DownloadSendReportCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadSendReportCheckBoxCaption);
 //
 f_DownloadSendReportParametersLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadSendReportParametersLabelCaption);
 //
 f_DownloadRestoreAllBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormDownloadRestoreAllBitBtnCaption);
 //
 f_UpdateTabSheet.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateTabSheetCaption);
 //
 f_UpdateNoBackupCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateNoBackupCheckBoxCaption);
 //
 f_UpdateRemoveZipsCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateRemoveZipsCheckBoxCaption);
 //
 f_UpdateSearchInLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateSearchInLabelCaption);
 //
 f_UpdateAdminPasswordLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateAdminPasswordLabelCaption);
 f_UpdateAdminPasswordCommentLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateAdminPasswordCommentLabelCaption);
 //
 f_UpdateSendReportCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateSendReportCheckBoxCaption);
 //
 f_UpdateSkipWarningCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateSkipWarningCheckBoxCaption);
 //
 f_UpdateSendReportParametersLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateSendReportParametersLabelCaption);
 //
 f_UpdateRestoreAllBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormUpdateRestoreAllBitBtnCaption);
 //
 f_ScheduleTabSheet.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleTabSheetCaption);
 //
 f_ScheduleDownloadEnabledCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleDownloadEnabledCheckBoxCaption);
 f_ScheduleUpdateEnabledCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleUpdateEnabledCheckBoxCaption);
 //
 f_ScheduleRunAtEndCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleRunAtEndCheckBoxCaption);
 f_ScheduleRunAtEndCommandLineLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleRunAtEndCommandLineLabelCaption);
 //
 f_ScheduleWeekGroupBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleWeekGroupBoxCaption);
 //
 f_ScheduleMondayCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleMondayCheckBoxCaption);
 f_ScheduleTuesdayCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleTuesdayCheckBoxCaption);
 f_ScheduleWednesdayCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleWednesdayCheckBoxCaption);
 f_ScheduleThursdayCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleThursdayCheckBoxCaption);
 f_ScheduleFridayCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleFridayCheckBoxCaption);
 f_ScheduleSaturdayCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleSaturdayCheckBoxCaption);
 f_ScheduleSundayCheckBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleSundayCheckBoxCaption);
 //
 f_ScheduleRestoreAllBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormScheduleRestoreAllBitBtnCaption);
 //
 f_CommonHelpBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormCommonHelpBitBtnCaption);
 f_CommonSaveBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormCommonSaveBitBtnCaption);
 f_CommonCancelBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateParamsFormCommonCancelBitBtnCaption);
 //
 f_MainPageControl.TabIndex := 0;
 //
 with TEasyUpdateSupport.Instance do
 begin
  f_UpdateAdminPasswordLabel.Visible := IsUpdateAdminFormAvailable;
  f_UpdateAdminPasswordCommentLabel.Visible := IsUpdateAdminFormAvailable;
 end;
 // 
 InvalidateStatus;
end;

procedure TEasyUpdateParamsForm.DownloadRestoreEditExit(a_Sender: TObject);
begin
 f_DownloadRestoreEdit.Text := ValidateMinutes(f_DownloadRestoreEdit.Text, a_Sender as TWinControl);
end;

procedure TEasyUpdateParamsForm.DownloadSaveToSelectButtonClick(a_Sender: TObject);
var
 l_Directory: string;
begin
 if SelectDirectory(f_DownloadSaveToLabel.Caption, '', l_Directory) then
  f_DownloadSaveToEdit.Text := ReplaceRootFolder(l_Directory);
end;

procedure TEasyUpdateParamsForm.DownloadRestoreAllBitBtnClick(a_Sender: TObject);
begin
 InvalidateLoadStatus(False, True, True, 5, False, '%GARANT%\delta', 'F1Download', False);
end;

procedure TEasyUpdateParamsForm.UpdateAdminPasswordLabelClick(a_Sender: TObject);
begin
 Hide;
 try
  with TEasyUpdateSupport.Instance do
   with g_EasyUpdateAdminForm do
   begin
    f_AdminNameEdit.Text := UpdateAdminName;
    //
    f_AdminPasswordEdit.Text := UpdateAdminPassword;
    f_AdminPasswordCheckEdit.Text := UpdateAdminPassword;
    //
    if (ShowModal <> mrCancel) then
    begin
     UpdateAdminName := f_AdminNameEdit.Text;
     UpdateAdminPassword := f_AdminPasswordEdit.Text;
    end;
   end;
 finally
  Show;
 end;
end;

procedure TEasyUpdateParamsForm.UpdateSearchInSelectButtonClick(a_Sender: TObject);
var
 l_Directory: string;
begin
 if SelectDirectory(f_UpdateSearchInLabel.Caption, '', l_Directory) then
  f_UpdateSearchInEdit.Text := ReplaceRootFolder(l_Directory);
end;

procedure TEasyUpdateParamsForm.UpdateRestoreAllBitBtnClick(a_Sender: TObject);
begin
 InvalidateApplyStatus(False, False, '%GARANT%\delta', False, False);
end;

procedure TEasyUpdateParamsForm.ScheduleRunAtEndCheckBoxClick(Sender: TObject);
begin
 with f_ScheduleRunAtEndCheckBox do
 begin
  f_ScheduleRunAtEndApplicationEdit.Enabled := Checked;
  f_ScheduleRunAtEndApplicationButton.Enabled := Checked;
  //
  f_ScheduleRunAtEndCommandLineEdit.Enabled := Checked;
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleRunAtEndButtonClick(a_Sender: TObject);
var
 l_InitialDir: string;
begin
 with f_ScheduleRunAtEndOpenDialog do
 begin
  if (InitialDir = '') then
  begin
   l_InitialDir := ExtractFilePath(f_ScheduleRunAtEndApplicationEdit.Text);
   //
   if (l_InitialDir = '') then
    l_InitialDir := TEasyUpdateSupport.Instance.RootFolder;
  end;
  //
  if (Execute) then
   f_ScheduleRunAtEndApplicationEdit.Text := FileName;
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleMondayCheckBoxClick(a_Sender: TObject);
begin
 with f_ScheduleMondayEdit do
 begin
  Enabled := f_ScheduleMondayCheckBox.Checked;
  //
  with TEasyUpdateSupport do
   if (Enabled) then
    Text := TimeToStr(DefaultTimeForWeekDay(1), g_LocalFormatSettings)
   else
    Text := TimeToStr(DefaultTimeForWeekDay(0), g_LocalFormatSettings);
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleMondayEditExit(a_Sender: TObject);
begin
 f_ScheduleMondayEdit.Text := ValidateTime(f_ScheduleMondayEdit.Text, a_Sender as TWinControl);
end;

procedure TEasyUpdateParamsForm.ScheduleTuesdayCheckBoxClick(a_Sender: TObject);
begin
 with f_ScheduleTuesdayEdit do
 begin
  Enabled := f_ScheduleTuesdayCheckBox.Checked;
  //
  with TEasyUpdateSupport do
   if (Enabled) then
    Text := TimeToStr(DefaultTimeForWeekDay(2), g_LocalFormatSettings)
   else
    Text := TimeToStr(DefaultTimeForWeekDay(0), g_LocalFormatSettings);
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleTuesdayEditExit(a_Sender: TObject);
begin
 f_ScheduleTuesdayEdit.Text := ValidateTime(f_ScheduleTuesdayEdit.Text, a_Sender as TWinControl);
end;

procedure TEasyUpdateParamsForm.ScheduleWednesdayCheckBoxClick(a_Sender: TObject);
begin
 with f_ScheduleWednesdayEdit do
 begin
  Enabled := f_ScheduleWednesdayCheckBox.Checked;
  //
  with TEasyUpdateSupport do
   if (Enabled) then
    Text := TimeToStr(DefaultTimeForWeekDay(3), g_LocalFormatSettings)
   else
    Text := TimeToStr(DefaultTimeForWeekDay(0), g_LocalFormatSettings);
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleWednesdayEditExit(a_Sender: TObject);
begin
 f_ScheduleWednesdayEdit.Text := ValidateTime(f_ScheduleWednesdayEdit.Text, a_Sender as TWinControl);
end;

procedure TEasyUpdateParamsForm.ScheduleThursdayCheckBoxClick(a_Sender: TObject);
begin
 with f_ScheduleThursdayEdit do
 begin
  Enabled := f_ScheduleThursdayCheckBox.Checked;
  //
  with TEasyUpdateSupport do
   if (Enabled) then
    Text := TimeToStr(DefaultTimeForWeekDay(4), g_LocalFormatSettings)
   else
    Text := TimeToStr(DefaultTimeForWeekDay(0), g_LocalFormatSettings);
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleThursdayEditExit(a_Sender: TObject);
begin
 f_ScheduleThursdayEdit.Text := ValidateTime(f_ScheduleThursdayEdit.Text, a_Sender as TWinControl);
end;

procedure TEasyUpdateParamsForm.ScheduleFridayCheckBoxClick(a_Sender: TObject);
begin
 with f_ScheduleFridayEdit do
 begin
  Enabled := f_ScheduleFridayCheckBox.Checked;
  //
  with TEasyUpdateSupport do
   if (Enabled) then
    Text := TimeToStr(DefaultTimeForWeekDay(5), g_LocalFormatSettings)
   else
    Text := TimeToStr(DefaultTimeForWeekDay(0), g_LocalFormatSettings);
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleFridayEditExit(a_Sender: TObject);
begin
 f_ScheduleFridayEdit.Text := ValidateTime(f_ScheduleFridayEdit.Text, a_Sender as TWinControl);
end;

procedure TEasyUpdateParamsForm.ScheduleSaturdayCheckBoxClick(a_Sender: TObject);
begin
 with f_ScheduleSaturdayEdit do
 begin
  Enabled := f_ScheduleSaturdayCheckBox.Checked;
  //
  with TEasyUpdateSupport do
   if (Enabled) then
    Text := TimeToStr(DefaultTimeForWeekDay(6), g_LocalFormatSettings)
   else
    Text := TimeToStr(DefaultTimeForWeekDay(0), g_LocalFormatSettings);
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleSaturdayEditExit(a_Sender: TObject);
begin
 f_ScheduleSaturdayEdit.Text := ValidateTime(f_ScheduleSaturdayEdit.Text, a_Sender as TWinControl);
end;

procedure TEasyUpdateParamsForm.ScheduleSundayCheckBoxClick(a_Sender: TObject);
begin
 with f_ScheduleSundayEdit do
 begin
  Enabled := f_ScheduleSundayCheckBox.Checked;
  //
  with TEasyUpdateSupport do
   if (Enabled) then
    Text := TimeToStr(DefaultTimeForWeekDay(7), g_LocalFormatSettings)
   else
    Text := TimeToStr(DefaultTimeForWeekDay(0), g_LocalFormatSettings);
 end;
end;

procedure TEasyUpdateParamsForm.ScheduleSundayEditExit(a_Sender: TObject);
begin
 f_ScheduleSundayEdit.Text := ValidateTime(f_ScheduleSundayEdit.Text, a_Sender as TWinControl);
end;

procedure TEasyUpdateParamsForm.ScheduleRestoreAllBitBtnClick(a_Sender: TObject);
begin
 with TEasyUpdateSupport do
 begin
  InvalidateScheduleStatus(
   True
   , True
   , False
   , ''
   , ''
   , DefaultTimeForWeekDay(1)
   , DefaultTimeForWeekDay(2)
   , DefaultTimeForWeekDay(3)
   , DefaultTimeForWeekDay(4)
   , DefaultTimeForWeekDay(5)
   , DefaultTimeForWeekDay(0)
   , DefaultTimeForWeekDay(7)
  );
 end;
end;

procedure TEasyUpdateParamsForm.SendReportParametersLabelClick(a_Sender: TObject);
begin
 Hide;
 try
  with TEasyUpdateSupport.Instance do
   with g_EasyUpdateMailForm do
   begin
    f_MailToEdit.Text := MailTo;
    f_MailFromEdit.Text := MailFrom;
    //
    f_MailServerEdit.Text := MailServer;
    f_MailServerUserEdit.Text := MailServerUser;
    f_MailServerPasswordEdit.Text := MailServerPassword;
    //
    //
    if (ShowModal <> mrCancel) then
    begin
     MailTo := f_MailToEdit.Text;
     MailFrom := f_MailFromEdit.Text;
     //
     MailServer := f_MailServerEdit.Text;
     MailServerUser := f_MailServerUserEdit.Text;
     MailServerPassword := f_MailServerPasswordEdit.Text;
    end;
   end;
 finally
  Show;
 end;
end;

procedure TEasyUpdateParamsForm.CommonHelpBitBtnClick(a_Sender: TObject);
var
 l_HelpPage: string;
begin
 with f_MainPageControl do
  case TabIndex of
   0: l_HelpPage := 'page-setting_download.htm';
   1: l_HelpPage := 'page-setting_update.htm';
   2: l_HelpPage := 'page-setting_scheduler.htm';
   else
      l_HelpPage := 'page-main.htm';
  end;
 //
 Application.HelpSystem.ShowTopicHelp(l_HelpPage, '');
end;

procedure TEasyUpdateParamsForm.CommonSaveBitBtnClick(a_Sender: TObject);
 //
 function CorrectTimeToZero(const a_Time: TDateTime; const a_Valid: Boolean): TDateTime;
 begin
  if (a_Valid) then
   Result := a_Time
  else
   Result := 0;
 end;
 //
begin
 with TEasyUpdateSupport.Instance do
 begin
  with f_ScheduleDownloadEnabledCheckBox do
   DownloadEnabledFlag := Checked and Enabled;
  //
  with f_DownloadRevisionCheckBox do
   DownloadRevisionFlag := Checked and Enabled;
  //
  with f_DownloadRetryCheckBox do
   DownloadRetryFlag := Checked and Enabled;
  //
  with f_DownloadRestoreCheckBox do
   DownloadRestoreFlag := Checked and Enabled;
  //
  DownloadRestoreTime := StrToInt(f_DownloadRestoreEdit.Text);
  //
  with f_DownloadResumeCheckBox do
   DownloadResumeFlag := Checked and Enabled;
  //
  DownloadPath := f_DownloadSaveToEdit.Text;
  //
  DownloadID := f_DownloadUserAgentEdit.Text;
  //
  with f_DownloadSendReportCheckBox do
   DownloadSendReportFlag := Checked and Enabled;
  //
  with f_ScheduleUpdateEnabledCheckBox do
   UpdateEnabledFlag := Checked and Enabled;
  //
  with f_UpdateNoBackupCheckBox do
   UpdateNoBackupFlag := Checked and Enabled;
  //
  with f_UpdateRemoveZipsCheckBox do
   UpdateRemoveArchiveFlag := Checked and Enabled;
  //
  UpdatePath := f_UpdateSearchInEdit.Text;
  //
  with f_UpdateSendReportCheckBox do
   UpdateSendReportFlag := Checked and Enabled;
  //
  with f_UpdateSkipWarningCheckBox do
   UpdateSkipWarningFlag := Checked and Enabled;
  //
  with f_ScheduleRunAtEndCheckBox do
   RunAtEndEnabled := Checked and Enabled;
  //
  RunAtEndApplication := f_ScheduleRunAtEndApplicationEdit.Text;
  RunAtEndCommandLine := f_ScheduleRunAtEndCommandLineEdit.Text;
  //
  SetScheduleTime(
   CorrectTimeToZero(1+ StrToTime(f_ScheduleMondayEdit.Text, g_LocalFormatSettings), f_ScheduleMondayCheckBox.Checked)
   , CorrectTimeToZero(2+ StrToTime(f_ScheduleTuesdayEdit.Text, g_LocalFormatSettings), f_ScheduleTuesdayCheckBox.Checked)
   , CorrectTimeToZero(3+ StrToTime(f_ScheduleWednesdayEdit.Text, g_LocalFormatSettings), f_ScheduleWednesdayCheckBox.Checked)
   , CorrectTimeToZero(4+ StrToTime(f_ScheduleThursdayEdit.Text, g_LocalFormatSettings), f_ScheduleThursdayCheckBox.Checked)
   , CorrectTimeToZero(5+ StrToTime(f_ScheduleFridayEdit.Text, g_LocalFormatSettings), f_ScheduleFridayCheckBox.Checked)
   , CorrectTimeToZero(6+ StrToTime(f_ScheduleSaturdayEdit.Text, g_LocalFormatSettings), f_ScheduleSaturdayCheckBox.Checked)
   , CorrectTimeToZero(7+ StrToTime(f_ScheduleSundayEdit.Text, g_LocalFormatSettings), f_ScheduleSundayCheckBox.Checked)
  );
  //
  FlushJobSettings;
 end;
end;

class procedure TEasyUpdateParamsForm.ShowInvalidDataFormatError;
begin
 Application.MessageBox(
  PChar(GetCurrentLocaleMessage(c_EasyUpdateParamsFormShowInvalidDataFormatErrorText))
  , PChar(GetCurrentLocaleMessage(c_EasyUpdateParamsFormShowInvalidDataFormatErrorCaption))
  , MB_ICONERROR or MB_OK
 );
end;

class function TEasyUpdateParamsForm.ValidateMinutes(const a_Text: string; const a_WinControl: TWinControl): string;
var
 l_Value: Integer;
begin
 Result := a_Text;
 //
 try
  l_Value := StrToInt(a_Text);
  //
  if (l_Value <= 0) then
   StrToInt(''); // raise `EConvertError` for invalid values
  //
  Result := Format('%.02u', [l_Value]);
 except
  on EConvertError do
  begin
   ShowInvalidDataFormatError;
   //
   if (a_WinControl <> nil) then
    a_WinControl.SetFocus;
  end;
 end;
end;

class function TEasyUpdateParamsForm.ValidateTime(const a_Text: string; const a_WinControl: TWinControl): string;
var
 l_Value: TDateTime;
begin
 Result := a_Text;
 //
 try
  l_Value := StrToTime(a_Text, g_LocalFormatSettings);
  //
  Result := Copy(TimeToStr(l_Value, g_LocalFormatSettings), 1, 5);
 except
  on EConvertError do
  begin
   ShowInvalidDataFormatError;
   //
   if (a_WinControl <> nil) then
    a_WinControl.SetFocus;
  end;
 end;
end;

class function TEasyUpdateParamsForm.ReplaceRootFolder(const a_Path: string): string;
var
 l_Path: string;
 l_RootFolder: string;
begin
 Result := a_Path;
 //
 l_Path := AnsiUpperCase(a_Path);
 l_RootFolder := AnsiUpperCase(TEasyUpdateSupport.Instance.RootFolder);
 //
 if (Pos(l_RootFolder, l_Path) = 1) then
 begin
  Delete(Result, 1, Length(a_Path));
  //
  Result := Format('%%GARANT%%%s', [Result]);
 end;
end;

procedure TEasyUpdateParamsForm.InvalidateStatus;
var
 l_Monday: TDateTime;
 l_Tuesday: TDateTime;
 l_Wednesday: TDateTime;
 l_Thursday: TDateTime;
 l_Friday: TDateTime;
 l_Saturday: TDateTime;
 l_Sunday: TDateTime;
begin
 with TEasyUpdateSupport.Instance do
 begin
  GetScheduleTime(l_Monday, l_Tuesday, l_Wednesday, l_Thursday, l_Friday, l_Saturday, l_Sunday);
  //
  InvalidateApplyStatus(
   UpdateNoBackupFlag
   , UpdateRemoveArchiveFlag
   , UpdatePath
   , UpdateSendReportFlag
   , UpdateSkipWarningFlag
  );
  //
  InvalidateLoadStatus(
   DownloadRevisionFlag
   , DownloadRetryFlag
   , DownloadRestoreFlag
   , DownloadRestoreTime
   , DownloadResumeFlag
   , DownloadPath
   , DownloadID
   , DownloadSendReportFlag
   );
  //
  InvalidateScheduleStatus(
   DownloadEnabledFlag
   , UpdateEnabledFlag
   , RunAtEndEnabled
   , RunAtEndApplication
   , RunAtEndCommandLine
   , l_Monday
   , l_Tuesday
   , l_Wednesday
   , l_Thursday
   , l_Friday
   , l_Saturday
   , l_Sunday
  );
 end;
end;

procedure TEasyUpdateParamsForm.InvalidateApplyStatus(
 const a_NoBackupFlag: Boolean
 ; const a_RemoveArchiveFlag: Boolean
 ; const a_LookIn: string
 ; const a_SendReport: Boolean
 ; const a_SkipWarning: Boolean
);
begin
 f_UpdateNoBackupCheckBox.Checked := a_NoBackupFlag;
 //
 f_UpdateRemoveZipsCheckBox.Checked := a_RemoveArchiveFlag;
 //
 f_UpdateSearchInEdit.Text := a_LookIn;
 //
 f_UpdateSendReportCheckBox.Checked := a_SendReport;
 //
 f_UpdateSkipWarningCheckBox.Checked := a_SkipWarning;
end;

procedure TEasyUpdateParamsForm.InvalidateLoadStatus(
 const a_RevisionFlag: Boolean
 ; const a_RetryFlag: Boolean
 ; const a_RestoreFlag: Boolean
 ; const a_RestoreTime: Integer
 ; const a_ResumeFlag: Boolean
 ; const a_SaveTo: string
 ; const a_Process: string
 ; const a_SendReport: Boolean
);
begin
 f_DownloadRevisionCheckBox.Checked := a_RevisionFlag;
 //
 f_DownloadRetryCheckBox.Checked := a_RetryFlag;
 //
 f_DownloadRestoreCheckBox.Checked := a_RestoreFlag;
 f_DownloadRestoreEdit.Text := Format('%.02u', [a_RestoreTime]);
 //
 f_DownloadResumeCheckBox.Checked := a_ResumeFlag;
 //
 f_DownloadSaveToEdit.Text := a_SaveTo;
 //
 f_DownloadUserAgentEdit.Text := a_Process;
 //
 f_DownloadSendReportCheckBox.Checked := a_SendReport;
end;

procedure TEasyUpdateParamsForm.InvalidateScheduleStatus(
 const a_AutoUpdate: Boolean
 ; const a_AutoApply: Boolean
 ; const a_RunAtEnd: Boolean
 ; const a_RunAtEndApplication: string
 ; const a_RunAtEndCommandLine: string
 ; const a_Monday: TDateTime
 ; const a_Tuesday: TDateTime
 ; const a_Wednesday: TDateTime
 ; const a_Thursday: TDateTime
 ; const a_Friday: TDateTime
 ; const a_Saturday: TDateTime
 ; const a_Sunday: TDateTime
);
begin
 f_ScheduleDownloadEnabledCheckBox.Checked := a_AutoUpdate;
 //
 f_ScheduleUpdateEnabledCheckBox.Checked := a_AutoApply;
 //
 f_ScheduleRunAtEndCheckBox.Checked := a_RunAtEnd;
 f_ScheduleRunAtEndApplicationEdit.Text := a_RunAtEndApplication;
 f_ScheduleRunAtEndCommandLineEdit.Text := a_RunAtEndCommandLine;
 //
 f_ScheduleMondayCheckBox.Checked := (a_Monday <> 0);
 f_ScheduleMondayEdit.Text := TimeToStr(a_Monday, g_LocalFormatSettings);
 f_ScheduleMondayEdit.Enabled := f_ScheduleMondayCheckBox.Checked;
 //
 f_ScheduleTuesdayCheckBox.Checked := (a_Tuesday <> 0);
 f_ScheduleTuesdayEdit.Text := TimeToStr(a_Tuesday, g_LocalFormatSettings);
 f_ScheduleTuesdayEdit.Enabled := f_ScheduleTuesdayCheckBox.Checked;
 //
 f_ScheduleWednesdayCheckBox.Checked := (a_Wednesday <> 0);
 f_ScheduleWednesdayEdit.Text := TimeToStr(a_Wednesday, g_LocalFormatSettings);
 f_ScheduleWednesdayEdit.Enabled := f_ScheduleWednesdayCheckBox.Checked;
 //
 f_ScheduleThursdayCheckBox.Checked := (a_Thursday <> 0);
 f_ScheduleThursdayEdit.Text := TimeToStr(a_Thursday, g_LocalFormatSettings);
 f_ScheduleThursdayEdit.Enabled := f_ScheduleThursdayCheckBox.Checked;
 //
 f_ScheduleFridayCheckBox.Checked := (a_Friday <> 0);
 f_ScheduleFridayEdit.Text := TimeToStr(a_Friday, g_LocalFormatSettings);
 f_ScheduleFridayEdit.Enabled := f_ScheduleFridayCheckBox.Checked;
 //
 f_ScheduleSaturdayCheckBox.Checked := (a_Saturday <> 0);
 f_ScheduleSaturdayEdit.Text := TimeToStr(a_Saturday, g_LocalFormatSettings);
 f_ScheduleSaturdayEdit.Enabled := f_ScheduleSaturdayCheckBox.Checked;
 //
 f_ScheduleSundayCheckBox.Checked := (a_Sunday <> 0);
 f_ScheduleSundayEdit.Text := TimeToStr(a_Sunday, g_LocalFormatSettings);
 f_ScheduleSundayEdit.Enabled := f_ScheduleSundayCheckBox.Checked;
end;

procedure TEasyUpdateParamsForm.StoreState;
begin
 f_DownloadRevisionCheckBoxState := f_DownloadRevisionCheckBox.Checked;
 //
 f_DownloadRetryCheckBoxState := f_DownloadRetryCheckBox.Checked;
 //
 f_DownloadRestoreCheckBoxState := f_DownloadRestoreCheckBox.Checked;
 f_DownloadRestoreEditState := f_DownloadRestoreEdit.Text;
 //
 f_DownloadResumeCheckBoxState := f_DownloadResumeCheckBox.Checked;
 //
 f_DownloadSaveToEditState := f_DownloadSaveToEdit.Text;
 //
 f_DownloadUserAgentEditState := f_DownloadUserAgentEdit.Text;
 //
 f_DownloadSendReportCheckBoxState := f_DownloadSendReportCheckBox.Checked;
 //
 f_UpdateNoBackupCheckBoxState := f_UpdateNoBackupCheckBox.Checked;
 //
 f_UpdateRemoveZipsCheckBoxState := f_UpdateRemoveZipsCheckBox.Checked;
 //
 f_UpdateSearchInEditState := f_UpdateSearchInEdit.Text;
 //
 f_UpdateSendReportCheckBoxState := f_UpdateSendReportCheckBox.Checked;
 //
 f_UpdateSkipWarningCheckBoxState := f_UpdateSkipWarningCheckBox.Checked;
 //
 f_ScheduleDownloadEnabledCheckBoxState := f_ScheduleDownloadEnabledCheckBox.Checked;
 //
 f_ScheduleUpdateEnabledCheckBoxState := f_ScheduleUpdateEnabledCheckBox.Checked;
 //
 f_ScheduleRunAtEndCheckBoxState := f_ScheduleRunAtEndCheckBox.Checked;
 f_ScheduleRunAtEndApplicationEditState := f_ScheduleRunAtEndApplicationEdit.Text;
 f_ScheduleRunAtEndCommandLineEditState := f_ScheduleRunAtEndCommandLineEdit.Text;
 //
 f_ScheduleMondayCheckBoxState := f_ScheduleMondayCheckBox.Checked;
 f_ScheduleMondayEditState := f_ScheduleMondayEdit.Text;
 //
 f_ScheduleTuesdayCheckBoxState := f_ScheduleTuesdayCheckBox.Checked;
 f_ScheduleTuesdayEditState := f_ScheduleTuesdayEdit.Text;
 //
 f_ScheduleWednesdayCheckBoxState := f_ScheduleWednesdayCheckBox.Checked;
 f_ScheduleWednesdayEditState := f_ScheduleWednesdayEdit.Text;
 //
 f_ScheduleThursdayCheckBoxState := f_ScheduleThursdayCheckBox.Checked;
 f_ScheduleThursdayEditState := f_ScheduleThursdayEdit.Text;
 //
 f_ScheduleFridayCheckBoxState := f_ScheduleFridayCheckBox.Checked;
 f_ScheduleFridayEditState := f_ScheduleFridayEdit.Text;
 //
 f_ScheduleSaturdayCheckBoxState := f_ScheduleSaturdayCheckBox.Checked;
 f_ScheduleSaturdayEditState := f_ScheduleSaturdayEdit.Text;
 //
 f_ScheduleSundayCheckBoxState := f_ScheduleSundayCheckBox.Checked;
 f_ScheduleSundayEditState := f_ScheduleSundayEdit.Text;
end;

procedure TEasyUpdateParamsForm.RestoreState;
begin
 f_ScheduleSundayEdit.Text := f_ScheduleSundayEditState;
 f_ScheduleSundayCheckBox.Checked := f_ScheduleSundayCheckBoxState;
 //
 f_ScheduleSaturdayEdit.Text := f_ScheduleSaturdayEditState;
 f_ScheduleSaturdayCheckBox.Checked := f_ScheduleSaturdayCheckBoxState;
 //
 f_ScheduleFridayEdit.Text := f_ScheduleFridayEditState;
 f_ScheduleFridayCheckBox.Checked := f_ScheduleFridayCheckBoxState;
 //
 f_ScheduleThursdayEdit.Text := f_ScheduleThursdayEditState;
 f_ScheduleThursdayCheckBox.Checked := f_ScheduleThursdayCheckBoxState;
 //
 f_ScheduleWednesdayEdit.Text := f_ScheduleWednesdayEditState;
 f_ScheduleWednesdayCheckBox.Checked := f_ScheduleWednesdayCheckBoxState;
 //
 f_ScheduleTuesdayEdit.Text := f_ScheduleTuesdayEditState;
 f_ScheduleTuesdayCheckBox.Checked := f_ScheduleTuesdayCheckBoxState;
 //
 f_ScheduleMondayEdit.Text := f_ScheduleMondayEditState;
 f_ScheduleMondayCheckBox.Checked := f_ScheduleMondayCheckBoxState;
 //
 f_ScheduleRunAtEndCommandLineEdit.Text := f_ScheduleRunAtEndCommandLineEditState;
 f_ScheduleRunAtEndApplicationEdit.Text := f_ScheduleRunAtEndApplicationEditState;
 f_ScheduleRunAtEndCheckBox.Checked := f_ScheduleRunAtEndCheckBoxState;
 //
 f_ScheduleUpdateEnabledCheckBox.Checked := f_ScheduleUpdateEnabledCheckBoxState;
 //
 f_ScheduleDownloadEnabledCheckBox.Checked := f_ScheduleDownloadEnabledCheckBoxState;
 //
 f_UpdateSkipWarningCheckBox.Checked := f_UpdateSkipWarningCheckBoxState;
 //
 f_UpdateSendReportCheckBox.Checked := f_UpdateSendReportCheckBoxState;
 //
 f_UpdateSearchInEdit.Text := f_UpdateSearchInEditState;
 //
 f_UpdateRemoveZipsCheckBox.Checked := f_UpdateRemoveZipsCheckBoxState;
 //
 f_UpdateNoBackupCheckBox.Checked := f_UpdateNoBackupCheckBoxState;
 //
 f_DownloadSendReportCheckBox.Checked := f_DownloadSendReportCheckBoxState;
 //
 f_DownloadUserAgentEdit.Text := f_DownloadUserAgentEditState;
 //
 f_DownloadSaveToEdit.Text := f_DownloadSaveToEditState;
 //
 f_DownloadResumeCheckBox.Checked := f_DownloadResumeCheckBoxState;
 //
 f_DownloadRestoreEdit.Text := f_DownloadRestoreEditState;
 f_DownloadRestoreCheckBox.Checked := f_DownloadRestoreCheckBoxState;
 //
 f_DownloadRetryCheckBox.Checked := f_DownloadRetryCheckBoxState;
 //
 f_DownloadRevisionCheckBox.Checked := f_DownloadRevisionCheckBoxState;
end;


initialization
 GetLocaleFormatSettings(GetThreadLocale, g_LocalFormatSettings);
 //
 with g_LocalFormatSettings do
 begin
  TimeSeparator   := ':';
  TimeAMString    := '';
  TimePMString    := '';
  ShortTimeFormat := 'hh:mm';
  LongTimeFormat  := 'hh:mm';
 end;
end.
