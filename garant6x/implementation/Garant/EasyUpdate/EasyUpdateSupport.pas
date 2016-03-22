unit EasyUpdateSupport;

interface

uses
 Windows
 , ActiveX
 , Classes
 , COMObj
 , Forms
 , IniFiles
 , SysUtils
 //
 , LocaleMessages
 ;

const
 IID_IEnumWorkItems: TGUID       = '{148BD528-A2AB-11CE-B11F-00AA00530503}';
 IID_IPersistFile: TGUID         = '{0000010B-0000-0000-C000-000000000046}';
 IID_ITask: TGUID                = '{148BD524-A2AB-11CE-B11F-00AA00530503}';
 IID_ITaskScheduler: TGUID       = '{148BD527-A2AB-11CE-B11F-00AA00530503}';
 IID_ITaskTrigger: TGUID         = '{148BD52B-A2AB-11CE-B11F-00AA00530503}';
 IID_IScheduledWorkItem: TGUID   = '{A6B952F0-A4B1-11D0-997D-00AA006887EC}';

 CLSID_CTask: TGUID              = '{148BD520-A2AB-11CE-B11F-00AA00530503}';
 CLSID_CTaskScheduler: TGUID     = '{148BD52A-A2AB-11CE-B11F-00AA00530503}';

const
 ERROR_TASK_IS_DISABLED          = HRESULT($80041326);

const
 SCHED_S_TASK_READY              = $00041300;
 SCHED_S_TASK_RUNNING            = $00041301;
 SCHED_S_TASK_DISABLED           = $00041302;
 SCHED_S_TASK_HAS_NOT_RUN        = $00041303;
 SCHED_S_TASK_NOT_SCHEDULED      = $00041305;

const
 TASK_FLAG_DISABLED              = $00000004;

const
 TASK_SUNDAY                     = $0001;
 TASK_MONDAY                     = $0002;
 TASK_TUESDAY                    = $0004;
 TASK_WEDNESDAY                  = $0008;
 TASK_THURSDAY                   = $0010;
 TASK_FRIDAY                     = $0020;
 TASK_SATURDAY                   = $0040;

type
 LPLPWSTR = ^LPWSTR;
 LPSYSTEMTIME = ^SYSTEMTIME;

 PTaskTriggerType = ^TTaskTriggerType;
 TTaskTriggerType = (
  TASK_TIME_TRIGGER_ONCE,
  TASK_TIME_TRIGGER_DAILY,
  TASK_TIME_TRIGGER_WEEKLY,
  TASK_TIME_TRIGGER_MONTHLYDATE,
  TASK_TIME_TRIGGER_MONTHLYDOW,
  TASK_EVENT_TRIGGER_ON_IDLE,
  TASK_EVENT_TRIGGER_AT_SYSTEMSTART,
  TASK_EVENT_TRIGGER_AT_LOGON
 );

 PDaily = ^TDaily;
 TDaily = record
  DaysInterval: WORD;
 end;

 PWeekly = ^TWeekly;
 TWeekly = record
  WeeksInterval: WORD;
  rgfDaysOfTheWeek: WORD;
 end;

 PMonthlyDate = ^TMonthlyDate;
 TMonthlyDate = record
  rgfDays: DWORD;
  rgfMonths: WORD;
 end;

 PMonthlyDow = ^TMonthlyDow;
 TMonthlyDow = record
  wWhichWeek: WORD;
  rgfDaysOfTheWeek: WORD;
  rgfMonths: WORD;
 end;

 PTriggerTypeUnion = ^TTriggerTypeUnion;
 TTriggerTypeUnion = record
  case Integer of
   0: (Daily: TDaily);
   1: (Weekly: TWeekly);
   2: (MonthlyDate: TMonthlyDate);
   3: (MonthlyDOW: TMonthlyDow);
 end;

 PTaskTrigger = ^TTaskTrigger;
 TTaskTrigger = record
  cbTriggerSize: WORD;
  Reserved1: WORD;
  wBeginYear: WORD;
  wBeginMonth: WORD;
  wBeginDay: WORD;
  wEndYear: WORD;
  wEndMonth: WORD;
  wEndDay: WORD;
  wStartHour: WORD;
  wStartMinute: WORD;
  MinutesDuration: DWORD;
  MinutesInterval: DWORD;
  rgFlags: DWORD;
  TriggerType: TTaskTriggerType;
  Type_: TTriggerTypeUnion;
  Reserved2: WORD;
  wRandomMinutesInterval: WORD;
 end;

 IEnumWorkItems = interface(IUnknown) ['{148BD528-A2AB-11CE-B11F-00AA00530503}']
  function Next(celt: ULONG; out rgpwszNames: LPLPWSTR; out pceltFetched: ULONG): HRESULT; stdcall;
  function Skip(celt: ULONG): HRESULT; stdcall;
  function Reset: HRESULT; stdcall;
  function Clone(out ppEnumWorkItems: IEnumWorkItems): HRESULT; stdcall;
 end;

 ITaskTrigger = interface(IUnknown) ['{148BD52B-A2AB-11CE-B11F-00AA00530503}']
  function SetTrigger(const pTrigger: PTaskTrigger): HRESULT; stdcall;
  function GetTrigger(pTrigger: PTaskTrigger): HRESULT; stdcall;
  function GetTriggerString(var ppwszTrigger: LPWSTR): HRESULT; stdcall;
 end;

 IScheduledWorkItem = interface(IUnknown) ['{A6B952F0-A4B1-11D0-997D-00AA006887EC}']
  function CreateTrigger(out piNewTrigger: Word; out ppTrigger: ITaskTrigger): HRESULT; stdcall;
  function DeleteTrigger(iTrigger: Word): HRESULT; stdcall;
  function GetTriggerCount(out pwCount: Word): HRESULT; stdcall;
  function GetTrigger(iTrigger: Word; var ppTrigger: ITaskTrigger): HRESULT; stdcall;
  function GetTriggerString(iTrigger: Word; out ppwszTrigger: PWideChar): HRESULT; stdcall;
  function GetRunTimes(const pstBegin: LPSYSTEMTIME; const pstEnd: LPSYSTEMTIME; var pCount: Word; out rgstTaskTimes: LPSYSTEMTIME): HRESULT; stdcall;
  function GetNextRunTime(var pstNextRun: SYSTEMTIME): HRESULT; stdcall;
  function SetIdleWait(wIdleMinutes: Word; wDeadlineMinutes: Word): HRESULT; stdcall;
  function GetIdleWait(out pwIdleMinutes: Word; out pwDeadlineMinutes: Word): HRESULT; stdcall;
  function Run: HRESULT; stdcall;
  function Terminate: HRESULT; stdcall;
  function EditWorkItem(hParent: HWND; dwReserved: DWORD): HRESULT; stdcall;
  function GetMostRecentRunTime(out pstLastRun: TSystemTime): HRESULT; stdcall;
  function GetStatus(out phrStatus: HRESULT): HRESULT stdcall;
  function GetExitCode(out pdwExitCode: DWORD): HRESULT stdcall;
  function SetComment(pwszComment: LPCWSTR): HRESULT stdcall;
  function GetComment(out ppwszComment: LPWSTR): HRESULT stdcall;
  function SetCreator(pwszCreator: LPCWSTR): HRESULT; stdcall;
  function GetCreator(out ppwszCreator: LPWSTR): HRESULT; stdcall;
  function SetWorkItemData(cbData: Word; var rgbData: Byte): HRESULT; stdcall;
  function GetWorkItemData(out pcbData: Word; out prgbData: Byte): HRESULT; stdcall;
  function SetErrorRetryCount(wRetryCount: Word): HRESULT; stdcall;
  function GetErrorRetryCount(out pwRetryCount: Word): HRESULT; stdcall;
  function SetErrorRetryInterval(wRetryInterval: Word): HRESULT; stdcall;
  function GetErrorRetryInterval(out pwRetryInterval: Word): HRESULT; stdcall;
  function SetFlags(dwFlags: DWORD): HRESULT; stdcall;
  function GetFlags(out pdwFlags: DWORD): HRESULT; stdcall;
  function SetAccountInformation(pwszAccountName: LPCWSTR; pwszPassword: LPCWSTR): HRESULT; stdcall;
  function GetAccountInformation(out ppwszAccountName: LPWSTR): HRESULT; stdcall;
 end;

 ITask = interface (IScheduledWorkItem) ['{148BD524-A2AB-11CE-B11F-00AA00530503}']
  function SetApplicationName(pwszApplicationName: LPCWSTR): HRESULT; stdcall;
  function GetApplicationName(out ppwszApplicationName: LPWSTR): HRESULT; stdcall;
  function SetParameters(pwszParameters: LPCWSTR): HRESULT; stdcall;
  function GetParameters(out ppwszParameters: LPWSTR): HRESULT; stdcall;
  function SetWorkingDirectory(pwszWorkingDirectory: LPCWSTR): HRESULT; stdcall;
  function GetWorkingDirectory(out ppwszWorkingDirectory: LPWSTR): HRESULT; stdcall;
  function SetPriority(dwPriority: DWORD): HRESULT; stdcall;
  function GetPriority(out pdwPriority: DWORD): HRESULT; stdcall;
  function SetTaskFlags(dwFlags: DWORD): HRESULT; stdcall;
  function GetTaskFlags(out pdwFlags: DWORD): HRESULT; stdcall;
  function SetMaxRunTime(dwMaxRunTimeMS: DWORD): HRESULT; stdcall;
  function GetMaxRunTime(out pdwMaxRunTimeMS: DWORD): HRESULT; stdcall;
 end;

 ITaskScheduler = interface(IUnknown) ['{148BD527-A2AB-11CE-B11F-00AA00530503}']
  function SetTargetComputer(pwszComputer: LPCWSTR): HRESULT; stdcall;
  function GetTargetComputer(out ppwszComputer: LPWSTR): HRESULT; stdcall;
  function Enum(out ppEnumWorkItems: IEnumWorkItems): HRESULT; stdcall;
  function Activate(pwszName: PWideChar; var riid: TGUID; out ppUnk: IUnknown): HRESULT; stdcall;
  function Delete(pwszName: LPCWSTR): HRESULT; stdcall;
  function NewWorkItem(pwszTaskName: PWideChar; var rclsid: TGUID; var riid: TGUID; out ppUnk: IUnknown): HRESULT; stdcall;
  function AddWorkItem(pwszTaskName: LPCWSTR; var pWorkItem: IScheduledWorkItem): HRESULT; stdcall;
  function IsOfType(pwszName: LPCWSTR; var riid: TGUID): HRESULT; stdcall;
 end;

type
 TEasyUpdateSupport = class
 private
  f_IsJobSettingsChanged: Boolean;
  //
  f_JobSettingsData: TStrings;
  //
  f_TaskScheduler: ITaskScheduler;
 private
  function HelpEvent(a_Command: Word; a_Data: Longint; var a_CallHelp: Boolean): Boolean;
 private
  class function  CurrentTaskName: WideString;
  //
  class function  CurrentIniFileName: string;
  class function  CurrentJobFileName: string;
  class function  CurrentSetFileName: string;
  //
  class function  CurrentEtalonFileName: string;
 private
  class function  SavePersistFile(const a_Unknown: IUnknown): HResult;
  class function  SavePersistTask(const a_Task: ITask): HResult;
  //
  class function  CleanupTriggers(const a_Task: ITask): HResult;
 private
  procedure LoadJobSettings;
  procedure SaveJobSettings;
 private
  function  FindValuePosition(const a_String: string): Integer;
  function  FindCurrentSettingsValueIndex(const a_ValueName: string): Integer;
  //
  function  GetCurrentSettingsBooleanValue(const a_ValueName: string): Boolean;
  procedure SetCurrentSettingsBooleanValue(const a_ValueName: string; const a_Value: Boolean);
  //
  function  GetCurrentSettingsStringValue(const a_ValueName: string): string;
  procedure SetCurrentSettingsStringValue(const a_ValueName: string; const a_Value: string);
 private
  procedure SetTaskEnabledStatus(const a_Task: ITask; const a_Enabled: Boolean);
 private
  function  pm_GetTask: ITask;
  //
  function  pm_GetTaskName: WideString;
  //
  function  pm_GetTaskComment: WideString;
  procedure pm_SetTaskComment(const a_Value: WideString);
  //
  function  pm_GetTaskScheduler: ITaskScheduler;
 private
  function  pm_GetLocale: string;
  //
  function  pm_GetRootFolder: string;
 private
  function  pm_GetIsAutomaticUpdateEnabled: Boolean;
  procedure pm_SetIsAutomaticUpdateEnabled(const a_Value: Boolean);
  //
  function  pm_GetNextTimeToRun: TDateTime;
  function  pm_GetLastTimeToRun: TDateTime;
  //
  function  pm_GetLastRunStatus: Integer;
 private
  class function DownloadEnabledFlagName: string;
  //
  function  pm_GetDownloadEnabledFlag: Boolean;
  procedure pm_SetDownloadEnabledFlag(const a_Value: Boolean);
 private
  class function DownloadIDName: string;
  //
  function  pm_GetDownloadID: string;
  procedure pm_SetDownloadID(const a_Value: string);
 private
  class function DownloadPathName: string;
  //
  function  pm_GetDownloadPath: string;
  procedure pm_SetDownloadPath(const a_Value: string);
 private
  class function DownloadRestoreFlagName: string;
  //
  function  pm_GetDownloadRestoreFlag: Boolean;
  procedure pm_SetDownloadRestoreFlag(const a_Value: Boolean);
 private
  class function DownloadRestoreTimeName: string;
  //
  function  pm_GetDownloadRestoreTime: Integer;
  procedure pm_SetDownloadRestoreTime(const a_Value: Integer);
 private
  class function DownloadResumeFlagName: string;
  //
  function  pm_GetDownloadResumeFlag: Boolean;
  procedure pm_SetDownloadResumeFlag(const a_Value: Boolean);
 private
  class function DownloadRetryFlagName: string;
  //
  function  pm_GetDownloadRetryFlag: Boolean;
  procedure pm_SetDownloadRetryFlag(const a_Value: Boolean);
 private
  class function DownloadRevisionFlagName: string;
  //
  function  pm_GetDownloadRevisionFlag: Boolean;
  procedure pm_SetDownloadRevisionFlag(const a_Value: Boolean);
 private
  class function DownloadSendReportFlagName: string;
  //
  function  pm_GetDownloadSendReportFlag: Boolean;
  procedure pm_SetDownloadSendReportFlag(const a_Value: Boolean);
 private
  class function UpdateEnabledFlagName: string;
  //
  function  pm_GetUpdateEnabledFlag: Boolean;
  procedure pm_SetUpdateEnabledFlag(const a_Value: Boolean);
 private
  class function UpdateAdminNameName: string;
  //
  function  pm_GetUpdateAdminName: string;
  procedure pm_SetUpdateAdminName(const a_Value: string);
 private
  class function UpdateAdminPasswordName: string;
  //
  function  pm_GetUpdateAdminPassword: string;
  procedure pm_SetUpdateAdminPassword(const a_Value: string);
 private
  class function UpdateNoBackupFlagName: string;
  //
  function  pm_GetUpdateNoBackupFlag: Boolean;
  procedure pm_SetUpdateNoBackupFlag(const a_Value: Boolean);
 private
  class function UpdateRemoveArchiveFlagName: string;
  //
  function  pm_GetUpdateRemoveArchiveFlag: Boolean;
  procedure pm_SetUpdateRemoveArchiveFlag(const a_Value: Boolean);
 private
  class function UpdatePathName: string;
  //
  function  pm_GetUpdatePath: string;
  procedure pm_SetUpdatePath(const a_Value: string);
 private
  class function UpdateSendReportFlagName: string;
  //
  function  pm_GetUpdateSendReportFlag: Boolean;
  procedure pm_SetUpdateSendReportFlag(const a_Value: Boolean);
 private
  class function UpdateSkipWarningFlagName: string;
  //
  function  pm_GetUpdateSkipWarningFlag: Boolean;
  procedure pm_SetUpdateSkipWarningFlag(const a_Value: Boolean);
 private
  class function RunAtEndEnabledName: string;
  //
  function  pm_GetRunAtEndEnabled: Boolean;
  procedure pm_SetRunAtEndEnabled(const a_Value: Boolean);
 private
  class function RunAtEndApplicationName: string;
  //
  function  pm_GetRunAtEndApplication: string;
  procedure pm_SetRunAtEndApplication(const a_Value: string);
 private
  class function RunAtEndCommandLineName: string;
  //
  function  pm_GetRunAtEndCommandLine: string;
  procedure pm_SetRunAtEndCommandLine(const a_Value: string);
 private
  class function MailFromName: string;
  //
  function  pm_GetMailFrom: string;
  procedure pm_SetMailFrom(const a_Value: string);
 private
  class function MailToName: string;
  //
  function  pm_GetMailTo: string;
  procedure pm_SetMailTo(const a_Value: string);
 private
  class function MailCharsetName: string;
  //
  function  pm_GetMailCharset: string;
  procedure pm_SetMailCharset(const a_Value: string);
 private
  class function MailPriorityName: string;
  //
  function  pm_GetMailPriority: string;
  procedure pm_SetMailPriority(const a_Value: string);
 private
  class function MailReplyToName: string;
  //
  function  pm_GetMailReplyTo: string;
  procedure pm_SetMailReplyTo(const a_Value: string);
 private
  class function MailServerName: string;
  //
  function  pm_GetMailServer: string;
  procedure pm_SetMailServer(const a_Value: string);
 private
  class function MailServerUserName: string;
  //
  function  pm_GetMailServerUser: string;
  procedure pm_SetMailServerUser(const a_Value: string);
 private
  class function MailServerPasswordName: string;
  //
  function  pm_GetMailServerPassword: string;
  procedure pm_SetMailServerPassword(const a_Value: string);
 public
  class function  Instance: TEasyUpdateSupport;
  class procedure DestroyInstance;
 public
  class procedure SetApplicationHelpFile(const a_HelpFile: string);
  class procedure SetApplicationTitle(const a_Title: string);
 public
  class procedure RestoreJobFile;
 public
  class function  IsUpdateAdminFormAvailable: Boolean;
  class function  IsDownloadTuned: Boolean;
  class function  IsSystemCompatible: Boolean;
 public
  class function  DefaultTimeForWeekDay(const a_DayNumber: Byte): TDateTime;
 public
  constructor Create;
  destructor Destroy; override;
 public
  procedure FlushJobSettings;
  procedure ResetJobSettings;
 public
  procedure Run;
  procedure Terminate;
 public
  procedure GetScheduleTime(
   out a_Monday: TDateTime
   ; out a_Tuesday: TDateTime
   ; out a_Wednesday: TDateTime
   ; out a_Thursday: TDateTime
   ; out a_Friday: TDateTime
   ; out a_Saturday: TDateTime
   ; out a_Sunday: TDateTime
  ); overload;
  //
  procedure GetScheduleTime(
   const a_Task: ITask
   ; out a_Monday: TDateTime
   ; out a_Tuesday: TDateTime
   ; out a_Wednesday: TDateTime
   ; out a_Thursday: TDateTime
   ; out a_Friday: TDateTime
   ; out a_Saturday: TDateTime
   ; out a_Sunday: TDateTime
  ); overload;
  //
  procedure SetScheduleTime(
   const a_Monday: TDateTime
   ; const a_Tuesday: TDateTime
   ; const a_Wednesday: TDateTime
   ; const a_Thursday: TDateTime
   ; const a_Friday: TDateTime
   ; const a_Saturday: TDateTime
   ; const a_Sunday: TDateTime
  ); overload;
  //
  procedure SetScheduleTime(
   const a_Task: ITask
   ; const a_Monday: TDateTime
   ; const a_Tuesday: TDateTime
   ; const a_Wednesday: TDateTime
   ; const a_Thursday: TDateTime
   ; const a_Friday: TDateTime
   ; const a_Saturday: TDateTime
   ; const a_Sunday: TDateTime
  ); overload;
 private
  property Task: ITask read pm_GetTask;
  property TaskScheduler: ITaskScheduler read pm_GetTaskScheduler;
 public
  property Locale: string read pm_GetLocale;
  //
  property RootFolder: string read pm_GetRootFolder;
 public
  property IsAutomaticUpdateEnabled: Boolean read pm_GetIsAutomaticUpdateEnabled write pm_SetIsAutomaticUpdateEnabled;
  //
  property NextTimeToRun: TDateTime read pm_GetNextTimeToRun;
  property LastTimeToRun: TDateTime read pm_GetLastTimeToRun;
  //
  property LastRunStatus: Integer read pm_GetLastRunStatus;
  //
  property TaskName: WideString read pm_GetTaskName;
  property TaskComment: WideString read pm_GetTaskComment write pm_SetTaskComment;
 public
  property DownloadEnabledFlag: Boolean read pm_GetDownloadEnabledFlag write pm_SetDownloadEnabledFlag;
  //
  property DownloadID: string read pm_GetDownloadID write pm_SetDownloadID;
  //
  property DownloadPath: string read pm_GetDownloadPath write pm_SetDownloadPath;
  //
  property DownloadRestoreFlag: Boolean read pm_GetDownloadRestoreFlag write pm_SetDownloadRestoreFlag;
  property DownloadRestoreTime: Integer read pm_GetDownloadRestoreTime write pm_SetDownloadRestoreTime;
  //
  property DownloadResumeFlag: Boolean read pm_GetDownloadResumeFlag write pm_SetDownloadResumeFlag;
  //
  property DownloadRetryFlag: Boolean read pm_GetDownloadRetryFlag write pm_SetDownloadRetryFlag;
  //
  property DownloadRevisionFlag: Boolean read pm_GetDownloadRevisionFlag write pm_SetDownloadRevisionFlag;
  //
  property DownloadSendReportFlag: Boolean read pm_GetDownloadSendReportFlag write pm_SetDownloadSendReportFlag;
 public
  property UpdateEnabledFlag: Boolean read pm_GetUpdateEnabledFlag write pm_SetUpdateEnabledFlag;
  //
  property UpdateAdminName: string read pm_GetUpdateAdminName write pm_SetUpdateAdminName;
  property UpdateAdminPassword: string read pm_GetUpdateAdminPassword write pm_SetUpdateAdminPassword;
  //
  property UpdateNoBackupFlag: Boolean read pm_GetUpdateNoBackupFlag write pm_SetUpdateNoBackupFlag;
  //
  property UpdateRemoveArchiveFlag: Boolean read pm_GetUpdateRemoveArchiveFlag write pm_SetUpdateRemoveArchiveFlag;
  //
  property UpdatePath: string read pm_GetUpdatePath write pm_SetUpdatePath;
  //
  property UpdateSendReportFlag: Boolean read pm_GetUpdateSendReportFlag write pm_SetUpdateSendReportFlag;
  //
  property UpdateSkipWarningFlag: Boolean read pm_GetUpdateSkipWarningFlag write pm_SetUpdateSkipWarningFlag;
 public
  property RunAtEndEnabled: Boolean read pm_GetRunAtEndEnabled write pm_SetRunAtEndEnabled;
  //
  property RunAtEndApplication: string read pm_GetRunAtEndApplication write pm_SetRunAtEndApplication;
  property RunAtEndCommandLine: string read pm_GetRunAtEndCommandLine write pm_SetRunAtEndCommandLine;
 public
  property MailFrom: string read pm_GetMailFrom write pm_SetMailFrom;
  property MailTo: string read pm_GetMailTo write pm_SetMailTo;
  //
  property MailCharset: string read pm_GetMailCharset write pm_SetMailCharset;
  property MailPriority: string read pm_GetMailPriority write pm_SetMailPriority;
  property MailReplyTo: string read pm_GetMailReplyTo write pm_SetMailReplyTo;
  //
  property MailServer: string read pm_GetMailServer write pm_SetMailServer;
  property MailServerUser: string read pm_GetMailServerUser write pm_SetMailServerUser;
  property MailServerPassword: string read pm_GetMailServerPassword write pm_SetMailServerPassword;
 end;

implementation

uses
 SPHtmlHelp
 ;

const
 c_SpaceSet = [#9, ' '];

var
 g_EasyUpdateSupportInstance: TEasyUpdateSupport = nil;

var
 g_HoliDefaultTime: TDateTime = 0;
 g_WorkDefaultTime: TDateTime = 0;

function ReplaceAliases(const a_String: string): string; forward;

function RemoveFinalSlash(const a_String: string): string;
var
 l_Length: Integer;
begin
 Result := a_String;
 //
 l_Length := Length(Result);
 if ((l_Length > 0) and (Result[l_Length] = '\')) then
  SetLength(Result, Pred(l_Length));
end;

function GetConfigAliasReplace: string;
begin
 with TIniFile.Create(TEasyUpdateSupport.CurrentIniFileName) do
  try
   Result := RemoveFinalSlash(ReplaceAliases(ReadString('EasyUpdate', 'Config', '$(Garant)\garant.ini')));
  finally
   Free;
  end;
end;

function GetDownloadLoginAliasReplace: string;
begin
 with TIniFile.Create(ReplaceAliases('$(Config)')) do
  try
   Result := ReadString('Downloader', 'Login', '');
  finally
   Free;
  end;
end;

function GetDownloadPasswordAliasReplace: string;
begin
 with TIniFile.Create(ReplaceAliases('$(Config)')) do
  try
   Result := ReadString('Downloader', 'Pswd', '');
  finally
   Free;
  end;
end;

function GetExecuteRootAliasReplace: string;
begin
 Result := RemoveFinalSlash(ExtractFileDir(ParamStr(0)));
end;

function GetGarantRootAliasReplace: string;
begin
 with TIniFile.Create(TEasyUpdateSupport.CurrentIniFileName) do
  try
   Result := RemoveFinalSlash(ReplaceAliases(ReadString('EasyUpdate', 'Garant', '$(ExecuteRoot)\..')));
  finally
   Free;
  end;
end;

function GetLocaleAliasReplace: string;
begin
 with TIniFile.Create(ReplaceAliases('$(Config)')) do
  try
   Result := ReadString('F1Server Params', '-Locale', 'en');
  finally
   Free;
  end;
end;

function GetProductIdAliasReplace: string;
begin
 with TIniFile.Create(ReplaceAliases('$(Config)')) do
  try
   Result := ReadString('Version', '-ProductId', '{D7BBCD74-0CAB-4C22-A975-6856BD092CD7}');
  finally
   Free;
  end;
end;

function GetProductVersionAliasReplace: string;
begin
 with TIniFile.Create(ReplaceAliases('$(Config)')) do
  try
   Result := ReadString('Version', '-Product', 'server');
  finally
   Free;
  end;
end;

function ReplaceAliases(const a_String: string): string;
 //
 type
  TGetAliasReplace = function: string;
 //
 function ReplaceAlias(var a_String: string; const a_Alias: string; const a_GetAliasReplace: TGetAliasReplace): Boolean;
 var
  l_Pos: Integer;
 begin
  Result := False;
  //
  l_Pos := Pos(a_Alias, a_String);
  if (l_Pos > 0) then
  begin
   Delete(a_String, l_Pos, Length(a_Alias));
   Insert(a_GetAliasReplace, a_String, l_Pos);
   //
   Result := True;
  end;
 end;
 //
var
 l_AliasReplaced: Boolean;
begin
 Result := a_String;
 //
 if (Result <> '') then
  repeat
   l_AliasReplaced := False;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(Config)', GetConfigAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(Garant)', GetGarantRootAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(ExecuteRoot)', GetExecuteRootAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(Locale)', GetLocaleAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(DownloadLogin)', GetDownloadLoginAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(DownloadPassword)', GetDownloadPasswordAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(ProductId)', GetProductIdAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(ProductVersion)', GetProductVersionAliasReplace) or l_AliasReplaced;
  until not(l_AliasReplaced);
end;

function TEasyUpdateSupport.HelpEvent(a_Command: Word; a_Data: Longint; var a_CallHelp: Boolean): Boolean;
begin
 Result := False;
 a_CallHelp := False;
 //
 Application.HelpSystem.ShowTopicHelp('page-first_start.htm', '');
end;

class function TEasyUpdateSupport.CurrentTaskName: WideString;
begin
 Result := Format('GARANT_%s', [ReplaceAliases('$(ProductId)')]);
end;

class function TEasyUpdateSupport.CurrentIniFileName: string;
begin
 Result := ChangeFileExt(ParamStr(0), '.ini');
end;

class function TEasyUpdateSupport.CurrentJobFileName: string;
begin
 with TIniFile.Create(CurrentIniFileName) do
  try
   Result := ReplaceAliases(ReadString('EasyUpdate', 'JobFile', '$(Garant)\tools\schedule\F1EasyUpdateJob.bat'));
  finally
   Free;
  end;
end;

class function TEasyUpdateSupport.CurrentSetFileName: string;
begin
 with TIniFile.Create(CurrentIniFileName) do
  try
   Result := ReplaceAliases(ReadString('EasyUpdate', 'SetFile', '$(Garant)\tools\schedule\F1EasyUpdateSet.bat'));
  finally
   Free;
  end;
end;

class function TEasyUpdateSupport.CurrentEtalonFileName: string;
begin
 with TIniFile.Create(CurrentIniFileName) do
  try
   Result := ReplaceAliases(ReadString('EasyUpdate', 'Etalon', '$(ExecuteRoot)\schedule\F1EasyUpdate.bat'));
  finally
   Free;
  end;
end;

class function TEasyUpdateSupport.SavePersistFile(const a_Unknown: IUnknown): HResult;
var
 l_PersistFile: IPersistFile;
begin
 with a_Unknown do
 begin
  Result := QueryInterface(IID_IPersistFile, l_PersistFile);
  //
  if (Succeeded(Result)) then
   Result := l_PersistFile.Save(nil, True);
 end;
end;

class function TEasyUpdateSupport.SavePersistTask(const a_Task: ITask): HResult;
begin
 Result := a_Task.SetAccountInformation('', nil);
 //
 if (Succeeded(Result)) then
  Result := SavePersistFile(a_Task);
end;

class function TEasyUpdateSupport.CleanupTriggers(const a_Task: ITask): HResult;
var
 l_Index: Word;
 //
 l_TriggerCount: Word;
begin
 with a_Task do
 begin
  Result := GetTriggerCount(l_TriggerCount);
  //
  if (Succeeded(Result)) then
   if (l_TriggerCount > 0) then
    for l_Index := 0 to Pred(l_TriggerCount) do
    begin
     Result := DeleteTrigger(0);
     //
     if not (Succeeded(Result)) then
      Exit;
    end;
   end;
 //
 Result := SavePersistTask(a_Task);
end;

procedure TEasyUpdateSupport.LoadJobSettings;
var
 l_Text: string;
begin
 with f_JobSettingsData do
  try
   Clear;
   LoadFromFile(CurrentSetFileName);
   //
   l_Text := Text;
   OemToChar(PChar(l_Text), PChar(l_Text)); // OEM -> ANSI
   Text := l_Text;
  except
   on EFOpenError do Clear; // cleanup, if cannot read
  end;
 //
 f_IsJobSettingsChanged := False;
end;

procedure TEasyUpdateSupport.SaveJobSettings;
const
 c_GarantRootName: string = 'GARANT';
var
 l_Text: string;
begin
 if ((f_IsJobSettingsChanged) or (GetCurrentSettingsStringValue(c_GarantRootName) = '')) then
 begin
  SetCurrentSettingsStringValue(c_GarantRootName, ReplaceAliases('$(Garant)'));
  //
  with f_JobSettingsData do
  begin
   l_Text := Text;
   CharToOem(PChar(l_Text), PChar(l_Text)); // ANSI -> OEM
   Text := l_Text;
   //
   SaveToFile(CurrentSetFileName);
   f_IsJobSettingsChanged := False;
   //
   l_Text := Text;
   OemToChar(PChar(l_Text), PChar(l_Text)); // OEM -> ANSI
   Text := l_Text;
  end;
 end;
end;

function TEasyUpdateSupport.FindValuePosition(const a_String: string): Integer;
var
 l_Position: Integer;
 l_String: string;
begin
 Result := Pos('=', a_String);
 //
 if (Result > 0) then
 begin
  l_String := a_String;
  //
  while ((Length (l_String) > 0) and (l_String[1] in c_SpaceSet)) do
   System.Delete(l_String, 1, 1);
  //
  l_Position := Pos(' ', l_String);
  //
  if ((l_Position = 0) or (AnsiCompareText('set', Copy(l_String, 1, Pred(l_Position))) <> 0)) then
   Result := 0
  else
   Result := Succ(Result);
 end;
end;

function TEasyUpdateSupport.FindCurrentSettingsValueIndex(const a_ValueName: string): Integer;
var
 l_Index: Integer;
 l_Position: Integer;
 l_String: string;
 l_SubString: string;
begin
 Result := -1;
 //
 with f_JobSettingsData do
  for l_Index := 0 to Pred(Count) do
  begin
   l_String := Strings[l_Index];
   l_Position := FindValuePosition(l_String);
   //
   if (l_Position > 1) then
   begin
    l_SubString := Copy(l_String, 1, Pred(l_Position)- 1);
    //
    while ((Length (l_SubString) > 0) and (l_SubString[Length (l_SubString)] in c_SpaceSet)) do
     SetLength(l_SubString, Pred(Length (l_SubString)));
    //
    while ((Length (l_SubString) > 0) and (l_SubString[1] in c_SpaceSet)) do
     System.Delete(l_SubString, 1, 1);
    //
    if (AnsiCompareText('set', Copy(l_SubString, 1, 3)) = 0) then
     System.Delete(l_SubString, 1, 3);
    //
    while ((Length (l_SubString) > 0) and (l_SubString[1] in c_SpaceSet)) do
     System.Delete(l_SubString, 1, 1);
    //
    if (AnsiCompareText(a_ValueName, l_SubString) = 0) then
    begin
     Result := l_Index;
     //
     Break;
    end;
   end;
  end;
end;

function TEasyUpdateSupport.GetCurrentSettingsBooleanValue(const a_ValueName: string): Boolean;
var
 l_Value: string;
begin
 l_Value := GetCurrentSettingsStringValue(a_ValueName);
 //
 Result := ((l_Value <> '') and (l_Value <> '0'));
end;

procedure TEasyUpdateSupport.SetCurrentSettingsBooleanValue(const a_ValueName: string; const a_Value: Boolean);
const
 c_ValueAdapter: array [Boolean] of string = ('0', '1');
begin
 SetCurrentSettingsStringValue(a_ValueName, c_ValueAdapter[a_Value]);
end;

function TEasyUpdateSupport.GetCurrentSettingsStringValue(const a_ValueName: string): string;
var
 l_Index: Integer;
 l_String: string;
 l_Position: Integer;
begin
 Result := '';
 //
 l_Index := FindCurrentSettingsValueIndex(a_ValueName);
 //
 if (l_Index >= 0) then
  with f_JobSettingsData do
  begin
   l_String := Strings[l_Index];
   //
   l_Position := FindValuePosition(l_String);
   //
   if (l_Position > 0) then
    Result := Copy(l_String, l_Position, Succ(Length(l_String)-l_Position));
  end;
end;

procedure TEasyUpdateSupport.SetCurrentSettingsStringValue(const a_ValueName: string; const a_Value: string);
var
 l_Index: Integer;
 l_String: string;
 l_Position: Integer;
 //
 l_BegPosition: Integer;
 l_EndPosition: Integer;
begin
 l_Index := FindCurrentSettingsValueIndex(a_ValueName);
 //
 with f_JobSettingsData do
  if (l_Index >= 0) then
  begin
   l_String := Strings[l_Index];
   //
   l_Position := FindValuePosition(l_String);
   //
   if (l_Position > 0) then
   begin
    SetLength(l_String, Pred(l_Position));
    Strings[l_Index] := Format('%s%s', [l_String, a_Value]);
   end;
  end
  else
  begin
   l_Index := Pred(Count);
   //
   while (l_Index >= 0) do
   begin
    l_String := Strings[l_Index];
    //
    l_Position := FindValuePosition(l_String);
    //
    if (l_Position > 1) then
    begin
     l_String := Copy(l_String, 1, Pred(l_Position));
     //
     l_EndPosition := Length(l_String)- 1;
     //
     while ((l_EndPosition > 0) and (l_String[l_EndPosition] in c_SpaceSet)) do
      Dec(l_EndPosition);
     //
     l_BegPosition := l_EndPosition;
     //
     while ((l_BegPosition > 0) and not (l_String[l_BegPosition] in c_SpaceSet)) do
      Dec(l_BegPosition);
     //
     if (l_BegPosition >= 0) then
     begin
      Inc(l_BegPosition);
      //
      System.Delete(l_String, l_BegPosition, Succ(l_EndPosition- l_BegPosition));
      System.Insert(a_ValueName, l_String, l_BegPosition);
      //
      Insert(Succ(l_Index), Format('%s%s', [l_String, a_Value]));
     end;
     //
     f_IsJobSettingsChanged := True;
     Exit;
    end;
    //
    Dec(l_Index);
   end;
   //
   Add('@echo off');
   Add(#9'set GARANT=');
   Add(''); // empty line
   Add(Format(#9'set %s=%s', [a_ValueName, a_Value]));
   Add('exit /b');
  end;
 //
 f_IsJobSettingsChanged := True;
end;

procedure TEasyUpdateSupport.SetTaskEnabledStatus(const a_Task: ITask; const a_Enabled: Boolean);
const
 c_ResArray: array [Boolean] of DWORD = (DWORD(-1), DWORD(not TASK_FLAG_DISABLED));
 c_SetArray: array [Boolean] of DWORD = (DWORD(TASK_FLAG_DISABLED), DWORD(0));
var
 l_Flags: DWORD;
begin
 with a_Task do
 begin
  OleCheck(GetFlags(l_Flags));
  //
  l_Flags := (l_Flags and c_ResArray[a_Enabled]) or c_SetArray[a_Enabled];
  //
  OleCheck(SetFlags(l_Flags));
 end;
 //
 OleCheck(SavePersistTask(a_Task));
end;

function TEasyUpdateSupport.pm_GetTask: ITask;
var
 l_TaskName: WideString;
 //
 l_AppsName: WideString;
 l_AppsPath: WideString;
 //
 l_NeedCID: TGUID;
 l_NeedIID: TGUID;
 //
 l_Unknown: IUnknown;
begin
 with TaskScheduler do
 begin
  l_TaskName := CurrentTaskName;
  //
  try
   l_NeedIID := IID_ITask;
   //
   OleCheck(Activate(PWideChar(l_TaskName), l_NeedIID, l_Unknown));
   OleCheck(l_Unknown.QueryInterface(IID_ITask, Result));
  except
   on EOleSysError do
   begin
    l_AppsName := CurrentJobFileName;
    l_AppsPath := ExtractFileDir(l_AppsName);
    //
    l_NeedCID := CLSID_CTask;
    l_NeedIID := IID_ITask;
    //
    OleCheck(NewWorkItem(PWideChar(l_TaskName), l_NeedCID, l_NeedIID, l_Unknown));
    OleCheck(l_Unknown.QueryInterface(IID_ITask, Result));
    //
    with Result do
    begin
     OleCheck(SetApplicationName(PWideChar(l_AppsName)));
     OleCheck(SetWorkingDirectory(PWideChar(l_AppsPath)));
    end;
    //
    OleCheck(SavePersistTask(Result));
    //
    SetTaskEnabledStatus(Result, False);
    SetScheduleTime(
     Result
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
 end;
end;

function TEasyUpdateSupport.pm_GetTaskName: WideString;
begin
 Result := CurrentTaskName;
end;

function TEasyUpdateSupport.pm_GetTaskComment: WideString;
var
 l_Comment: LPWSTR;
begin
 OleCheck(Task.GetComment(l_Comment));
 //
 Result := l_Comment;
end;

procedure TEasyUpdateSupport.pm_SetTaskComment(const a_Value: WideString);
var
 l_Task: ITask;
begin
 l_Task := Task;
 //
 OleCheck(l_Task.SetComment(PWideChar(a_Value)));
 OleCheck(SavePersistTask(l_Task));
end;

function TEasyUpdateSupport.pm_GetTaskScheduler: ITaskScheduler;
begin
 if (f_TaskScheduler = nil) then
  OleCheck(CoCreateInstance(CLSID_CTaskScheduler, nil, CLSCTX_INPROC_SERVER, ITaskScheduler, f_TaskScheduler));
 //
 Result := f_TaskScheduler;
end;

function TEasyUpdateSupport.pm_GetLocale: string;
begin
 Result := ReplaceAliases('$(Locale)');
end;

function TEasyUpdateSupport.pm_GetRootFolder: string;
begin
 Result := ReplaceAliases('$(Garant)');
end;

function TEasyUpdateSupport.pm_GetIsAutomaticUpdateEnabled: Boolean;
var
 l_Flags: DWORD;
begin
 OleCheck(Task.GetFlags(l_Flags));
 //
 Result := ((l_Flags and TASK_FLAG_DISABLED) <> TASK_FLAG_DISABLED);
end;

procedure TEasyUpdateSupport.pm_SetIsAutomaticUpdateEnabled(const a_Value: Boolean);
begin
 SetTaskEnabledStatus(Task, a_Value);
end;

function TEasyUpdateSupport.pm_GetNextTimeToRun: TDateTime;
var
 l_HResult: HResult;
 l_SystemTime: TSystemTime;
begin
 l_HResult := Task.GetNextRunTime(l_SystemTime);
 //
 if (l_HResult = ERROR_TASK_IS_DISABLED) then
  Result := 0
 else
 begin
  OleCheck(l_HResult);
  //
  try
   Result := SystemTimeToDateTime(l_SystemTime);
  except
   on EConvertError do
    Result := 0;
  end;
 end;
end;

function TEasyUpdateSupport.pm_GetLastTimeToRun: TDateTime;
var
 l_HResult: HResult;
 l_SystemTime: TSystemTime;
begin
 l_HResult := Task.GetMostRecentRunTime(l_SystemTime);
 //
 if (l_HResult = ERROR_TASK_IS_DISABLED) then
  Result := 0
 else
 begin
  OleCheck(l_HResult);
  //
  try
   Result := SystemTimeToDateTime(l_SystemTime);
  except
   on EConvertError do
    Result := 0;
  end;
 end;
end;

function TEasyUpdateSupport.pm_GetLastRunStatus: Integer;
var
 l_ExitCode: DWORD;
 l_HResult: HResult;
 l_Status: HResult;
begin
 with Task do
 begin
  l_HResult := GetExitCode(l_ExitCode);
  //
  if ((l_HResult = SCHED_S_TASK_HAS_NOT_RUN) or (l_HResult = ERROR_TASK_IS_DISABLED)) then
   Result := -1
  else
  begin
   OleCheck(l_HResult);
   OleCheck(GetStatus(l_Status));
   //
   if (l_Status = SCHED_S_TASK_RUNNING) then
    Result := -2
   else
    Result := Integer(l_ExitCode);
  end;
 end;
end;

class function TEasyUpdateSupport.DownloadEnabledFlagName: string;
begin
 Result := 'DOWNLOAD_ENABLED';
end;

function TEasyUpdateSupport.pm_GetDownloadEnabledFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(DownloadEnabledFlagName);
end;

procedure TEasyUpdateSupport.pm_SetDownloadEnabledFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(DownloadEnabledFlagName, a_Value);
end;

class function TEasyUpdateSupport.DownloadIDName: string;
begin
 Result := 'DOWNLOAD_ID';
end;

function TEasyUpdateSupport.pm_GetDownloadID: string;
begin
 Result := GetCurrentSettingsStringValue(DownloadIDName);
end;

procedure TEasyUpdateSupport.pm_SetDownloadID(const a_Value: string);
begin
 SetCurrentSettingsStringValue(DownloadIDName, a_Value);
end;

class function TEasyUpdateSupport.DownloadPathName: string;
begin
 Result := 'DOWNLOAD_PATH';
end;

function TEasyUpdateSupport.pm_GetDownloadPath: string;
begin
 Result := GetCurrentSettingsStringValue(DownloadPathName);
end;

procedure TEasyUpdateSupport.pm_SetDownloadPath(const a_Value: string);
begin
 SetCurrentSettingsStringValue(DownloadPathName, a_Value);
end;

class function TEasyUpdateSupport.DownloadRestoreFlagName: string;
begin
 Result := 'DOWNLOAD_RESTORE';
end;

function TEasyUpdateSupport.pm_GetDownloadRestoreFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(DownloadRestoreFlagName);
end;

procedure TEasyUpdateSupport.pm_SetDownloadRestoreFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(DownloadRestoreFlagName, a_Value);
end;

class function TEasyUpdateSupport.DownloadRestoreTimeName: string;
begin
 Result := 'DOWNLOAD_RESTORE_TIME';
end;

function TEasyUpdateSupport.pm_GetDownloadRestoreTime: Integer;
begin
 Result := StrToIntDef(GetCurrentSettingsStringValue(DownloadRestoreTimeName), 5);
end;

procedure TEasyUpdateSupport.pm_SetDownloadRestoreTime(const a_Value: Integer);
begin
 SetCurrentSettingsStringValue(DownloadRestoreTimeName, IntToStr(a_Value));
end;

class function TEasyUpdateSupport.DownloadResumeFlagName: string;
begin
 Result := 'DOWNLOAD_RESUME';
end;

function TEasyUpdateSupport.pm_GetDownloadResumeFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(DownloadResumeFlagName);
end;

procedure TEasyUpdateSupport.pm_SetDownloadResumeFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(DownloadResumeFlagName, a_Value);
end;

class function TEasyUpdateSupport.DownloadRetryFlagName: string;
begin
 Result := 'DOWNLOAD_RETRY';
end;

function TEasyUpdateSupport.pm_GetDownloadRetryFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(DownloadRetryFlagName);
end;

procedure TEasyUpdateSupport.pm_SetDownloadRetryFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(DownloadRetryFlagName, a_Value);
end;

class function TEasyUpdateSupport.DownloadRevisionFlagName: string;
begin
 Result := 'DOWNLOAD_REVISION';
end;

function TEasyUpdateSupport.pm_GetDownloadRevisionFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(DownloadRevisionFlagName);
end;

procedure TEasyUpdateSupport.pm_SetDownloadRevisionFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(DownloadRevisionFlagName, a_Value);
end;

class function TEasyUpdateSupport.DownloadSendReportFlagName: string;
begin
 Result := 'DOWNLOAD_SEND_REPORT';
end;

function TEasyUpdateSupport.pm_GetDownloadSendReportFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(DownloadSendReportFlagName);
end;

procedure TEasyUpdateSupport.pm_SetDownloadSendReportFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(DownloadSendReportFlagName, a_Value);
end;

class function TEasyUpdateSupport.UpdateEnabledFlagName: string;
begin
 Result := 'UPDATE_ENABLED';
end;

function TEasyUpdateSupport.pm_GetUpdateEnabledFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(UpdateEnabledFlagName);
end;

procedure TEasyUpdateSupport.pm_SetUpdateEnabledFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(UpdateEnabledFlagName, a_Value);
end;

class function TEasyUpdateSupport.UpdateAdminNameName: string;
begin
 Result := 'UPDATE_ADMIN_NAME';
end;

function TEasyUpdateSupport.pm_GetUpdateAdminName: string;
begin
 Result := GetCurrentSettingsStringValue(UpdateAdminNameName);
end;

procedure TEasyUpdateSupport.pm_SetUpdateAdminName(const a_Value: string);
begin
 SetCurrentSettingsStringValue(UpdateAdminNameName, a_Value);
end;

class function TEasyUpdateSupport.UpdateAdminPasswordName: string;
begin
 Result := 'UPDATE_ADMIN_PASSWORD';
end;

function TEasyUpdateSupport.pm_GetUpdateAdminPassword: string;
begin
 Result := GetCurrentSettingsStringValue(UpdateAdminPasswordName);
end;

procedure TEasyUpdateSupport.pm_SetUpdateAdminPassword(const a_Value: string);
begin
 SetCurrentSettingsStringValue(UpdateAdminPasswordName, a_Value);
end;

class function TEasyUpdateSupport.UpdateNoBackupFlagName: string;
begin
 Result := 'UPDATE_NO_BACKUP';
end;

function TEasyUpdateSupport.pm_GetUpdateNoBackupFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(UpdateNoBackupFlagName);
end;

procedure TEasyUpdateSupport.pm_SetUpdateNoBackupFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(UpdateNoBackupFlagName, a_Value);
end;

class function TEasyUpdateSupport.UpdateRemoveArchiveFlagName: string;
begin
 Result := 'UPDATE_REMOVE_ARCHIVE';
end;

function TEasyUpdateSupport.pm_GetUpdateRemoveArchiveFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(UpdateRemoveArchiveFlagName);
end;

procedure TEasyUpdateSupport.pm_SetUpdateRemoveArchiveFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(UpdateRemoveArchiveFlagName, a_Value);
end;

class function TEasyUpdateSupport.UpdatePathName: string;
begin
 Result := 'UPDATE_PATH';
end;

function TEasyUpdateSupport.pm_GetUpdatePath: string;
begin
 Result := GetCurrentSettingsStringValue(UpdatePathName);
end;

procedure TEasyUpdateSupport.pm_SetUpdatePath(const a_Value: string);
begin
 SetCurrentSettingsStringValue(UpdatePathName, a_Value);
end;

class function TEasyUpdateSupport.UpdateSendReportFlagName: string;
begin
 Result := 'UPDATE_SEND_REPORT';
end;

function TEasyUpdateSupport.pm_GetUpdateSendReportFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(UpdateSendReportFlagName);
end;

procedure TEasyUpdateSupport.pm_SetUpdateSendReportFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(UpdateSendReportFlagName, a_Value);
end;

class function TEasyUpdateSupport.UpdateSkipWarningFlagName: string;
begin
 Result := 'UPDATE_SKIP_WARNING';
end;

function TEasyUpdateSupport.pm_GetUpdateSkipWarningFlag: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(UpdateSkipWarningFlagName);
end;

procedure TEasyUpdateSupport.pm_SetUpdateSkipWarningFlag(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(UpdateSkipWarningFlagName, a_Value);
end;

class function TEasyUpdateSupport.RunAtEndEnabledName: string;
begin
 Result := 'RUN_AT_END_ENABLED';
end;

function TEasyUpdateSupport.pm_GetRunAtEndEnabled: Boolean;
begin
 Result := GetCurrentSettingsBooleanValue(RunAtEndEnabledName);
end;

procedure TEasyUpdateSupport.pm_SetRunAtEndEnabled(const a_Value: Boolean);
begin
 SetCurrentSettingsBooleanValue(RunAtEndEnabledName, a_Value);
end;

class function TEasyUpdateSupport.RunAtEndApplicationName: string;
begin
 Result := 'RUN_AT_END_APPLICATION';
end;

function TEasyUpdateSupport.pm_GetRunAtEndApplication: string;
begin
 Result := GetCurrentSettingsStringValue(RunAtEndApplicationName);
end;

procedure TEasyUpdateSupport.pm_SetRunAtEndApplication(const a_Value: string);
begin
 SetCurrentSettingsStringValue(RunAtEndApplicationName, a_Value);
end;

class function TEasyUpdateSupport.RunAtEndCommandLineName: string;
begin
 Result := 'RUN_AT_END_COMMANDLINE';
end;

function TEasyUpdateSupport.pm_GetRunAtEndCommandLine: string;
begin
 Result := GetCurrentSettingsStringValue(RunAtEndCommandLineName);
end;

procedure TEasyUpdateSupport.pm_SetRunAtEndCommandLine(const a_Value: string);
begin
 SetCurrentSettingsStringValue(RunAtEndCommandLineName, a_Value);
end;

class function TEasyUpdateSupport.MailFromName: string;
begin
 Result := 'MAIL_FROM';
end;

function TEasyUpdateSupport.pm_GetMailFrom: string;
begin
 Result := GetCurrentSettingsStringValue(MailFromName);
end;

procedure TEasyUpdateSupport.pm_SetMailFrom(const a_Value: string);
begin
 SetCurrentSettingsStringValue(MailFromName, a_Value);
end;

class function TEasyUpdateSupport.MailToName: string;
begin
 Result := 'MAIL_TO';
end;

function TEasyUpdateSupport.pm_GetMailTo: string;
begin
 Result := GetCurrentSettingsStringValue(MailToName);
end;

procedure TEasyUpdateSupport.pm_SetMailTo(const a_Value: string);
begin
 SetCurrentSettingsStringValue(MailToName, a_Value);
end;

class function TEasyUpdateSupport.MailCharsetName: string;
begin
 Result := 'MAIL_CHARSET';
end;

function TEasyUpdateSupport.pm_GetMailCharset: string;
begin
 Result := GetCurrentSettingsStringValue(MailCharsetName);
end;

procedure TEasyUpdateSupport.pm_SetMailCharset(const a_Value: string);
begin
 SetCurrentSettingsStringValue(MailCharsetName, a_Value);
end;

class function TEasyUpdateSupport.MailPriorityName: string;
begin
 Result := 'MAIL_PRIORITY';
end;

function TEasyUpdateSupport.pm_GetMailPriority: string;
begin
 Result := GetCurrentSettingsStringValue(MailPriorityName);
end;

procedure TEasyUpdateSupport.pm_SetMailPriority(const a_Value: string);
begin
 SetCurrentSettingsStringValue(MailPriorityName, a_Value);
end;

class function TEasyUpdateSupport.MailReplyToName: string;
begin
 Result := 'MAIL_REPLYTO';
end;

function TEasyUpdateSupport.pm_GetMailReplyTo: string;
begin
 Result := GetCurrentSettingsStringValue(MailReplyToName);
end;

procedure TEasyUpdateSupport.pm_SetMailReplyTo(const a_Value: string);
begin
 SetCurrentSettingsStringValue(MailReplyToName, a_Value);
end;

class function TEasyUpdateSupport.MailServerName: string;
begin
 Result := 'MAIL_SERVER';
end;

function TEasyUpdateSupport.pm_GetMailServer: string;
begin
 Result := GetCurrentSettingsStringValue(MailServerName);
end;

procedure TEasyUpdateSupport.pm_SetMailServer(const a_Value: string);
begin
 SetCurrentSettingsStringValue(MailServerName, a_Value);
end;

class function TEasyUpdateSupport.MailServerUserName: string;
begin
 Result := 'MAIL_SERVER_USER';
end;

function TEasyUpdateSupport.pm_GetMailServerUser: string;
begin
 Result := GetCurrentSettingsStringValue(MailServerUserName);
end;

procedure TEasyUpdateSupport.pm_SetMailServerUser(const a_Value: string);
begin
 SetCurrentSettingsStringValue(MailServerUserName, a_Value);
end;

class function TEasyUpdateSupport.MailServerPasswordName: string;
begin
 Result := 'MAIL_SERVER_PASS';
end;

function TEasyUpdateSupport.pm_GetMailServerPassword: string;
begin
 Result := GetCurrentSettingsStringValue(MailServerPasswordName);
end;

procedure TEasyUpdateSupport.pm_SetMailServerPassword(const a_Value: string);
begin
 SetCurrentSettingsStringValue(MailServerPasswordName, a_Value);
end;

class function TEasyUpdateSupport.Instance: TEasyUpdateSupport;
begin
 if (g_EasyUpdateSupportInstance = nil) then
  g_EasyUpdateSupportInstance := TEasyUpdateSupport.Create;
 //
 Result := g_EasyUpdateSupportInstance;
end;

class procedure TEasyUpdateSupport.DestroyInstance;
begin
 FreeAndNil(g_EasyUpdateSupportInstance);
end;

class procedure TEasyUpdateSupport.SetApplicationHelpFile(const a_HelpFile: string);
begin
 Application.HelpFile := a_HelpFile;
end;

class procedure TEasyUpdateSupport.SetApplicationTitle(const a_Title: string);
begin
 Application.Title := a_Title;
end;

class procedure TEasyUpdateSupport.RestoreJobFile;
var
 l_Index: Integer;
 l_Stream: TStream;
begin
 try
  for l_Index := 1 to ParamCount do
   if (AnsiCompareText('-RestoreJobFile', ParamStr(l_Index)) = 0) then
   begin
    l_Stream := TFileStream.Create(CurrentEtalonFileName, fmOpenRead or fmShareDenyWrite);
    try
     with TFileStream.Create(CurrentJobFileName, fmCreate) do
      try
       CopyFrom(l_Stream, 0);
      finally
       Free;
      end;
    finally
     FreeAndNil(l_Stream);
    end;
    //
    Break;
   end;
  except
   Application.MessageBox(
    PChar(GetCurrentLocaleMessage(c_EasyUpdateSupportRestoreJobFileText))
    , PChar(GetCurrentLocaleMessage(c_EasyUpdateSupportRestoreJobFileCaption))
    , MB_ICONWARNING or MB_OK
   );
  end;
end;

class function TEasyUpdateSupport.IsUpdateAdminFormAvailable: Boolean;
begin
 Result := (AnsiCompareText(ReplaceAliases('$(ProductVersion)'), 'server') = 0);
end;

class function TEasyUpdateSupport.IsDownloadTuned: Boolean;
 //
 procedure RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string);
  //
  function GetCreationFlags: DWORD;
  begin
   Result := DWORD(CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS);
  end;
  //
  function QuoteStringIfNeed(const a_String: string): string;
  begin
   if ((Pos(' ', a_String) <> 0) or (Pos('''', a_String) <> 0)) then
    Result := Format('"%s"', [a_String])
   else
    Result := a_String;
  end;
  //
 var
  l_Application: string;
  l_Commandline: string;
  l_ProcessInformation: TProcessInformation;
  l_StartupInfo: TStartupInfo;
 begin
  l_Application := QuoteStringIfNeed(Format('%s\%s', [a_CurrentDirectory, a_Application]));
  //
  FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
  with l_StartupInfo do
  begin
   cb := DWORD(SizeOf(l_StartupInfo));
   dwFlags := STARTF_USESTDHANDLES;
  end;
  //
  l_CommandLine := l_Application;
  if (a_CommandLine <> '') then
   l_CommandLine := Format('%s %s', [l_CommandLine, a_CommandLine]);
  //
  if CreateProcess(nil, PChar(l_CommandLine), nil, nil, False, GetCreationFlags, nil, PChar(a_CurrentDirectory), l_StartupInfo, l_ProcessInformation) then
   with l_ProcessInformation do
   begin
    CloseHandle(hThread);
    CloseHandle(hProcess);
   end;
 end;
 //
var
 l_HelpEvent: THelpEvent;
begin
 Result := ((ReplaceAliases('$(DownloadLogin)') <> '') and (ReplaceAliases('$(DownloadPassword)') <> ''));
 //
 if (not Result) then
 begin
  with Application do
  begin
   l_HelpEvent := OnHelp;
   try
    OnHelp := Instance.HelpEvent;
    //
    Windows.MessageBox(
     Handle
     , PChar(GetCurrentLocaleMessage(c_EasyUpdateSupportDownloadNotTunedText))
     , PChar(GetCurrentLocaleMessage(c_EasyUpdateSupportDownloadNotTunedCaption))
     , MB_ICONERROR or MB_OK or MB_HELP
    );
   finally
    OnHelp := l_HelpEvent;
   end;
  end;
  //
  RunProcess('download.exe', '', ReplaceAliases('$(Garant)'));
 end;
end;

class function TEasyUpdateSupport.IsSystemCompatible: Boolean;
var
 l_HelpEvent: THelpEvent;
 l_OSVersionInfo: TOSVersionInfo;
begin
 l_OSVersionInfo.dwOSVersionInfoSize := SizeOf(l_OSVersionInfo);
 Win32Check(GetVersionEx(l_OSVersionInfo));
 //
 with l_OSVersionInfo do
 begin
  Result := (Longint(GetVersion) >= 0) and (dwMajorVersion >= 5);
  //
  if (not Result) then
  begin
   with Application do
   begin
    l_HelpEvent := OnHelp;
    try
     OnHelp := Instance.HelpEvent;
     //
     Windows.MessageBox(
      Handle
      , PChar(GetCurrentLocaleMessage(c_EasyUpdateSupportSystemNotCompatibleText))
      , PChar(GetCurrentLocaleMessage(c_EasyUpdateSupportSystemNotCompatibleCaption))
      , MB_ICONERROR or MB_OK or MB_HELP
     );
    finally
     OnHelp := l_HelpEvent;
    end;
   end;
  end;
 end;
end;

class function TEasyUpdateSupport.DefaultTimeForWeekDay(const a_DayNumber: Byte): TDateTime;
 //
 function MakeTime(
  const a_StartHour: Word
  ; const a_StartMinutes: Word
  ; const a_FinishHour: Word
  ; const a_FinishMinutes: Word
 ): TDateTime;
 const
  c_MskHours: Word = 3;
  c_MskMinutes: Word = 0;
 var
  l_TimeZoneInformation: TTimeZoneInformation;
  //
  l_BiasTime: TDateTime;
  //
  l_StartMinutes: Word;
  l_FinishMinutes: Word;
  //
  l_RunMinutes: Word;
 begin
  l_BiasTime := 0;
  //
  if (GetTimeZoneInformation(l_TimeZoneInformation) <> 0) then
   with l_TimeZoneInformation do
    if (Bias >= 0) then
     l_BiasTime := +EncodeTime(Word(+Bias div MinsPerHour), Word(+Bias mod MinsPerHour), 0, 0)
    else
     l_BiasTime := -EncodeTime(Word(-Bias div MinsPerHour), Word(-Bias mod MinsPerHour), 0, 0);
  //
  l_StartMinutes := a_StartHour* MinsPerHour+ a_StartMinutes;
  l_FinishMinutes := a_FinishHour* MinsPerHour+ a_FinishMinutes;
  //
  l_RunMinutes := l_StartMinutes+ Random(l_FinishMinutes- l_StartMinutes);
  //
  Result := Frac(
   EncodeTime(l_RunMinutes div MinsPerHour, l_RunMinutes mod MinsPerHour, 0, 0)
   - EncodeTime(c_MskHours, c_MskMinutes, 0, 0)
   - l_BiasTime
  );
 end;
 //
begin
 if (g_HoliDefaultTime = 0) then
  g_HoliDefaultTime := MakeTime(00, 01, 23, 59); // [00:01 - 23:59]
 //
 if (g_WorkDefaultTime = 0) then
  g_WorkDefaultTime := MakeTime(01, 00, 05, 00); // [01:00 - 05:00]
 //
 case a_DayNumber of
  1: Result := 1+ g_WorkDefaultTime; // monday
  2: Result := 2+ g_WorkDefaultTime; // tuesday
  3: Result := 3+ g_WorkDefaultTime; // wednesday
  4: Result := 4+ g_WorkDefaultTime; // thursday
  5: Result := 5+ g_WorkDefaultTime; // friday

  6: Result := 6+ g_HoliDefaultTime; // saturday
  7: Result := 7+ g_HoliDefaultTime; // sunday
 else
  Result := 0;
 end;
end;

constructor TEasyUpdateSupport.Create;
begin
 f_JobSettingsData := TStringList.Create;
 //
 LoadJobSettings;
end;

destructor TEasyUpdateSupport.Destroy;
begin
 SaveJobSettings;
 //
 FreeAndNil(f_JobSettingsData);
end;

procedure TEasyUpdateSupport.FlushJobSettings;
begin
 SaveJobSettings;
end;

procedure TEasyUpdateSupport.ResetJobSettings;
begin
 LoadJobSettings;
end;

procedure TEasyUpdateSupport.Run;
begin
 OleCheck(Task.Run);
end;

procedure TEasyUpdateSupport.Terminate;
begin
 OleCheck(Task.Terminate);
end;

procedure TEasyUpdateSupport.GetScheduleTime(
 out a_Monday: TDateTime
 ; out a_Tuesday: TDateTime
 ; out a_Wednesday: TDateTime
 ; out a_Thursday: TDateTime
 ; out a_Friday: TDateTime
 ; out a_Saturday: TDateTime
 ; out a_Sunday: TDateTime
);
begin
 GetScheduleTime(Task, a_Monday, a_Tuesday, a_Wednesday, a_Thursday, a_Friday, a_Saturday, a_Sunday);
end;

procedure TEasyUpdateSupport.GetScheduleTime(
 const a_Task: ITask
 ; out a_Monday: TDateTime
 ; out a_Tuesday: TDateTime
 ; out a_Wednesday: TDateTime
 ; out a_Thursday: TDateTime
 ; out a_Friday: TDateTime
 ; out a_Saturday: TDateTime
 ; out a_Sunday: TDateTime
);
var
 l_Index: Word;
 //
 l_TaskTrigger: ITaskTrigger;
 l_TriggerCount: Word;
 l_TriggerData: TTaskTrigger;
begin
 with a_Task do
 begin
  OleCheck(GetTriggerCount(l_TriggerCount));
  //
  a_Monday    := DefaultTimeForWeekDay(0);
  a_Tuesday   := DefaultTimeForWeekDay(0);
  a_Wednesday := DefaultTimeForWeekDay(0);
  a_Thursday  := DefaultTimeForWeekDay(0);
  a_Friday    := DefaultTimeForWeekDay(0);
  a_Saturday  := DefaultTimeForWeekDay(0);
  a_Sunday    := DefaultTimeForWeekDay(0);
  //
  if (l_TriggerCount > 0) then
   for l_Index := 0 to Pred(l_TriggerCount) do
   begin
    OleCheck(GetTrigger(l_Index, l_TaskTrigger));
    OleCheck(l_TaskTrigger.GetTrigger(@l_TriggerData));
    //
    with l_TriggerData do
     if (TriggerType = TASK_TIME_TRIGGER_WEEKLY) then
      case Type_.Weekly.rgfDaysOfTheWeek of
       TASK_SUNDAY:    a_Sunday    := 7+ EncodeTime(wStartHour, wStartMinute, 0, 0);
       TASK_MONDAY:    a_Monday    := 1+ EncodeTime(wStartHour, wStartMinute, 0, 0);
       TASK_TUESDAY:   a_Tuesday   := 2+ EncodeTime(wStartHour, wStartMinute, 0, 0);
       TASK_WEDNESDAY: a_Wednesday := 3+ EncodeTime(wStartHour, wStartMinute, 0, 0);
       TASK_THURSDAY:  a_Thursday  := 4+ EncodeTime(wStartHour, wStartMinute, 0, 0);
       TASK_FRIDAY:    a_Friday    := 5+ EncodeTime(wStartHour, wStartMinute, 0, 0);
       TASK_SATURDAY:  a_Saturday  := 6+ EncodeTime(wStartHour, wStartMinute, 0, 0);
      end;
    //
    g_HoliDefaultTime := Frac(a_Sunday);
    g_WorkDefaultTime := Frac(a_Monday);
   end;
 end;
end;

procedure TEasyUpdateSupport.SetScheduleTime(
 const a_Monday: TDateTime
 ; const a_Tuesday: TDateTime
 ; const a_Wednesday: TDateTime
 ; const a_Thursday: TDateTime
 ; const a_Friday: TDateTime
 ; const a_Saturday: TDateTime
 ; const a_Sunday: TDateTime
);
begin
 SetScheduleTime(Task, a_Monday, a_Tuesday, a_Wednesday, a_Thursday, a_Friday, a_Saturday, a_Sunday);
end;

procedure TEasyUpdateSupport.SetScheduleTime(
 const a_Task: ITask
 ; const a_Monday: TDateTime
 ; const a_Tuesday: TDateTime
 ; const a_Wednesday: TDateTime
 ; const a_Thursday: TDateTime
 ; const a_Friday: TDateTime
 ; const a_Saturday: TDateTime
 ; const a_Sunday: TDateTime
);
 //
 function FillTrigger(var a_TriggerData: TTaskTrigger; const a_Time: TDateTime): PTaskTrigger;
  //
  function TimeToWeekly(const a_Time: TDateTime): TWeekly;
  begin
   with Result do
   begin
    WeeksInterval := 1;
    //
    case Trunc(a_Time) of
     1: rgfDaysOfTheWeek := TASK_MONDAY;
     2: rgfDaysOfTheWeek := TASK_TUESDAY;
     3: rgfDaysOfTheWeek := TASK_WEDNESDAY;
     4: rgfDaysOfTheWeek := TASK_THURSDAY;
     5: rgfDaysOfTheWeek := TASK_FRIDAY;
     6: rgfDaysOfTheWeek := TASK_SATURDAY;
     7: rgfDaysOfTheWeek := TASK_SUNDAY;
    else
     rgfDaysOfTheWeek := 0;
    end;
   end;
  end;
  //
 var
  l_Year: Word;
  l_Month: Word;
  l_Day: Word;
  //
  l_Hour: Word;
  l_Min: Word;
  l_Sec: Word;
  l_MSec: Word;
 begin
  DecodeDate(Now, l_Year, l_Month, l_Day);
  DecodeTime(a_Time, l_Hour, l_Min, l_Sec, l_MSec);
  //
  FillChar(a_TriggerData, SizeOf(a_TriggerData), $00);
  //
  with a_TriggerData do
  begin
   cbTriggerSize := SizeOf(a_TriggerData);
   //
   wBeginYear := l_Year;
   wBeginMonth := l_Month;
   wBeginDay := l_Day;
   //
   wStartHour := l_Hour;
   wStartMinute := l_Min;
   //
   TriggerType := TASK_TIME_TRIGGER_WEEKLY;
   Type_.Weekly := TimeToWeekly(a_Time);
  end;
  //
  Result := @a_TriggerData;
 end;
 //
var
 l_TaskTrigger: ITaskTrigger;
 l_TriggerData: TTaskTrigger;
 l_TriggerIndex: Word;
begin
 OleCheck(CleanupTriggers(a_Task));
 //
 with a_Task do
 begin
  if (a_Monday <> 0) then
  begin
   OleCheck(CreateTrigger(l_TriggerIndex, l_TaskTrigger));
   OleCheck(l_TaskTrigger.SetTrigger(FillTrigger(l_TriggerData, 1+ Frac(a_Monday))));
  end;
  //
  if (a_Tuesday <> 0) then
  begin
   OleCheck(CreateTrigger(l_TriggerIndex, l_TaskTrigger));
   OleCheck(l_TaskTrigger.SetTrigger(FillTrigger(l_TriggerData, 2+ Frac(a_Tuesday))));
  end;
  //
  if (a_Wednesday <> 0) then
  begin
   OleCheck(CreateTrigger(l_TriggerIndex, l_TaskTrigger));
   OleCheck(l_TaskTrigger.SetTrigger(FillTrigger(l_TriggerData, 3+ Frac(a_Wednesday))));
  end;
  //
  if (a_Thursday <> 0) then
  begin
   OleCheck(CreateTrigger(l_TriggerIndex, l_TaskTrigger));
   OleCheck(l_TaskTrigger.SetTrigger(FillTrigger(l_TriggerData, 4+ Frac(a_Thursday))));
  end;
  //
  if (a_Friday <> 0) then
  begin
   OleCheck(CreateTrigger(l_TriggerIndex, l_TaskTrigger));
   OleCheck(l_TaskTrigger.SetTrigger(FillTrigger(l_TriggerData, 5+ Frac(a_Friday))));
  end;
  //
  if (a_Saturday <> 0) then
  begin
   OleCheck(CreateTrigger(l_TriggerIndex, l_TaskTrigger));
   OleCheck(l_TaskTrigger.SetTrigger(FillTrigger(l_TriggerData, 6+ Frac(a_Saturday))));
  end;
  //
  if (a_Sunday <> 0) then
  begin
   OleCheck(CreateTrigger(l_TriggerIndex, l_TaskTrigger));
   OleCheck(l_TaskTrigger.SetTrigger(FillTrigger(l_TriggerData, 7+ Frac(a_Sunday))));
  end;
 end;
 //
 OleCheck(SavePersistTask(a_Task));
end;


initialization
 CoInitialize(nil);
 Randomize;
 TEasyUpdateSupport.Instance; // creation
finalization
 TEasyUpdateSupport.DestroyInstance;
 CoUnInitialize;
end.
