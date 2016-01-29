unit EasyUpdateForm;

interface

uses
 Windows
 , Buttons
 , Classes
 , Controls
 , ExtCtrls
 , Forms
 , StdCtrls
 , SysUtils
 //
 , EasyUpdateParamsForm
 , EasyUpdateSupport
 //
 , LocaleMessages
 ;

type
 TEasyUpdateForm = class(TForm)
  f_MainPanel: TPanel;
   f_StatusGroupBox: TGroupBox;
    f_AutomaticUpdateLabel: TLabel;
    f_AutomaticUpdateStatusLabel: TLabel;
    f_NextTimeRunLabel: TLabel;
    f_NextTimeRunStatusLabel: TLabel;
    f_LastTimeRunLabel: TLabel;
    f_LastTimeRunStatusLabel: TLabel;
    f_LastRunLabel: TLabel;
    f_LastRunStatusLabel: TLabel;
   f_SetupParamsLabel: TLabel;
   f_HelpBitBtn: TBitBtn;
   f_OnBitBtn: TBitBtn;
   f_OffBitBtn: TBitBtn;
   f_RunBitBtn: TBitBtn;
   f_TaskName: TLabel;
  f_InvalidateStatusTimer: TTimer;
  //
  procedure FormCreate(a_Sender: TObject);
  //
  procedure SetupParamsLabelClick(a_Sender: TObject);
  procedure HelpBitBtnClick(a_Sender: TObject);
  procedure OnBitBtnClick(a_Sender: TObject);
  procedure OffBitBtnClick(a_Sender: TObject);
  procedure RunBitBtnClick(a_Sender: TObject);
  //
  procedure InvalidateStatusTimer(a_Sender: TObject);
 private
  function  AutomaticUpdateStatusToString(const a_Value: Boolean): string;
  //
  function  NextTimeToString(const a_Value: TDateTime): string;
  function  LastTimeToString(const a_Value: TDateTime): string;
  //
  function  LastRunStatusToString(const a_Value: Integer): string;
 private
  procedure InvalidateStatus;
 end;

var
 g_EasyUpdateForm: TEasyUpdateForm;

implementation {$R *.dfm}

var
 g_LocalFormatSettings: TFormatSettings;

procedure TEasyUpdateForm.FormCreate(a_Sender: TObject);
begin
 Caption := GetCurrentLocaleMessage(c_EasyUpdateFormCaption);
 //
 f_StatusGroupBox.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormStatusGroupBoxCaption);
 //
 f_AutomaticUpdateLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormAutomaticUpdateLabelCaption);
 f_NextTimeRunLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormNextTimeRunLabelCaption);
 f_LastTimeRunLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormLastTimeRunLabelCaption);
 f_LastRunLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormLastRunLabel);
 //
 f_HelpBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormHelpBitBtnCaption);
 //
 f_OnBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormOnBitBtnCaption);
 f_OffBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormOffBitBtnCaption);
 //
 f_RunBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormRunBitBtnCaption);
 //
 f_SetupParamsLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateFormSetupParamsLabelCaption);
 //
 f_TaskName.Hint := GetCurrentLocaleMessage(c_EasyUpdateFormTaskNameLabelHintToString);
 //
 InvalidateStatus;
 //
 f_InvalidateStatusTimer.Enabled := True;
end;

procedure TEasyUpdateForm.SetupParamsLabelClick(a_Sender: TObject);
begin
 f_InvalidateStatusTimer.Enabled := False;
 try
  Hide;
  try
   with g_EasyUpdateParamsForm do
   begin
    StoreState;
    //
    if (ShowModal = mrCancel) then
     RestoreState;
   end;
  finally
   Show;
  end;
 finally
  f_InvalidateStatusTimer.Enabled := True;
 end;
end;

procedure TEasyUpdateForm.HelpBitBtnClick(a_Sender: TObject);
begin
 Application.HelpSystem.ShowTopicHelp('page-setting.htm', '');
end;

procedure TEasyUpdateForm.OnBitBtnClick(a_Sender: TObject);
begin
 f_InvalidateStatusTimer.Enabled := False;
 try
  TEasyUpdateSupport.Instance.IsAutomaticUpdateEnabled := True;
  //
  InvalidateStatus;
 finally
  f_InvalidateStatusTimer.Enabled := True;
 end;
end;

procedure TEasyUpdateForm.OffBitBtnClick(a_Sender: TObject);
begin
 f_InvalidateStatusTimer.Enabled := False;
 try
  TEasyUpdateSupport.Instance.IsAutomaticUpdateEnabled := False;
  //
  InvalidateStatus;
 finally
  f_InvalidateStatusTimer.Enabled := True;
 end;
end;

procedure TEasyUpdateForm.RunBitBtnClick(a_Sender: TObject);
begin
 f_InvalidateStatusTimer.Enabled := False;
 try
  f_RunBitBtn.Enabled := False;
  //
  with TEasyUpdateSupport.Instance do
  begin
   FlushJobSettings;
   Run;
  end;
 finally
  f_InvalidateStatusTimer.Enabled := True;
 end;
end;

procedure TEasyUpdateForm.InvalidateStatusTimer(a_Sender: TObject);
begin
 InvalidateStatus;
end;

function TEasyUpdateForm.AutomaticUpdateStatusToString(const a_Value: Boolean): string;
begin
 if (a_Value) then
  Result := GetCurrentLocaleMessage(c_EasyUpdateFormAutomaticUpdateStatusToStringTrue)
 else
  Result := GetCurrentLocaleMessage(c_EasyUpdateFormAutomaticUpdateStatusToStringFalse);
end;

function TEasyUpdateForm.NextTimeToString(const a_Value: TDateTime): string;
begin
 if (a_Value = 0) then
  Result := GetCurrentLocaleMessage(c_EasyUpdateFormNextTimeToString)
 else
  Result := DateTimeToStr(a_Value, g_LocalFormatSettings);
end;

function TEasyUpdateForm.LastTimeToString(const a_Value: TDateTime): string;
begin
 if (a_Value = 0) then
  Result := GetCurrentLocaleMessage(c_EasyUpdateFormLastTimeToString)
 else
  Result := DateTimeToStr(a_Value, g_LocalFormatSettings);
end;

function TEasyUpdateForm.LastRunStatusToString(const a_Value: Integer): string;
begin
 if (a_Value = -1) then
  Result := GetCurrentLocaleMessage(c_EasyUpdateFormLastRunStatusToString)
 else
  if (a_Value = -2) then
   Result := GetCurrentLocaleMessage(c_EasyUpdateFormLastRunStatusIsStillActiveToString)
  else
   Result := Format('0x%0.8x', [a_Value]);
end;

procedure TEasyUpdateForm.InvalidateStatus;
var
 l_IsAutomaticUpdateEnabled: Boolean;
begin
 with TEasyUpdateSupport.Instance do
 begin
  l_IsAutomaticUpdateEnabled := IsAutomaticUpdateEnabled;
  //
  f_NextTimeRunLabel.Enabled := l_IsAutomaticUpdateEnabled;
  //
  with f_NextTimeRunStatusLabel do
  begin
   Enabled := l_IsAutomaticUpdateEnabled;
   Caption := NextTimeToString(NextTimeToRun);
  end;
  //
  f_LastTimeRunLabel.Enabled := l_IsAutomaticUpdateEnabled;
  //
  with f_LastTimeRunStatusLabel do
  begin
   Enabled := l_IsAutomaticUpdateEnabled;
   Caption := LastTimeToString(LastTimeToRun);
  end;
  //
  f_LastRunLabel.Enabled := l_IsAutomaticUpdateEnabled;
  //
  with f_LastRunStatusLabel do
  begin
   Enabled := l_IsAutomaticUpdateEnabled;
   Caption := LastRunStatusToString(LastRunStatus);
  end;
  //
  f_AutomaticUpdateStatusLabel.Caption := AutomaticUpdateStatusToString(l_IsAutomaticUpdateEnabled);
  //
  f_OnBitBtn.Enabled := ((not l_IsAutomaticUpdateEnabled) and (LastRunStatus <> -2));
  //
  f_OffBitBtn.Enabled := (l_IsAutomaticUpdateEnabled and (LastRunStatus <> -2));
  f_RunBitBtn.Enabled := (l_IsAutomaticUpdateEnabled and (LastRunStatus <> -2));
  //
  f_TaskName.Caption := TaskName;
 end;
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
