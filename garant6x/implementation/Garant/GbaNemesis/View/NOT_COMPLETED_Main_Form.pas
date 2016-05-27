unit NOT_COMPLETED_Main_Form;
 {* Главная форма }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_COMPLETED_Main_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "Main" MUID: (4A952BA3006D)
// Имя типа: "TMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MainOptions_Form
 , l3Interfaces
 , PrimBaseSearchInterfaces
 , BaseSearchInterfaces
 , F1_Without_Usecases_System_Controls
 , nsNotificationManager
 , l3TabbedContainersDispatcher
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Messages
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Windows
 , nsIntegrationSupport
 , l3ProtoObject
;

type
 TMainForm = class;

 IMainFormState = interface(IvcmBase)
  ['{91AB783F-E890-4E0B-B4BF-7641733FCD57}']
  function Get_BaseSearcherState: InsBaseSearcherInitialState;
  function Get_InnerState: IvcmBase;
  property BaseSearcherState: InsBaseSearcherInitialState
   read Get_BaseSearcherState;
  property InnerState: IvcmBase
   read Get_InnerState;
 end;//IMainFormState

 TMainFormState = class(Tl3ProtoObject, IMainFormState)
  private
   f_BaseSearcherState: InsBaseSearcherInitialState;
   f_InnerState: IvcmBase;
  protected
   function Get_BaseSearcherState: InsBaseSearcherInitialState;
   function Get_InnerState: IvcmBase;
  public
   constructor Create(const aBaseSearcherState: InsBaseSearcherInitialState;
    const aInnerState: IvcmBase); reintroduce;
   class function Make(const aBaseSearcherState: InsBaseSearcherInitialState;
    const aInnerState: IvcmBase): IMainFormState; reintroduce;
 end;//TMainFormState

 TMainForm = class(TMainOptionsForm, Il3ItemNotifyRecipient, InsBaseSearchResultProcessor, InsBaseSearchDataReadyChecker, InsBaseSearchQueryDataProcessor, Il3MouseWheelListener, InsIntegrationProcessor, InsNotificationListener, InsBaseSearchInitialStateProvider, Il3TabbedContainersListener, InsBaseSearcherProvider)
  {* Главная форма }
  private
   f_StartupTipsForm: IvcmEntityForm;
   f_InitialContext: Il3CString;
  protected
   f_BaseSearcher: InsBaseSearcher;
   f_LastWMActivateTickCount: Cardinal;
   f_ActivatesCount: Cardinal;
  private
   procedure CorrectStartupTipsPosition;
   procedure NotifyBaseSearcherFormClosing;
   procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
   procedure WMActivateApp(var Message: TWMActivateApp); message WM_ACTIVATEAPP;
   procedure WMCopyData(var aMessage: TWMCopyData); message WM_COPYDATA;
   procedure WMDisplayChange(var aMessage: TWMDisplayChange); message WM_DISPLAYCHANGE;
   procedure WMWindowPosChanging(var aMessage: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
  protected
   procedure UpdateUnreadConsultations;
   procedure InitForm;
   procedure PrepareChildZoneBeforeResize(aNewHeight: Integer);
   function BaseSearcher: InsBaseSearcher;
   procedure FillOldBaseWarning; virtual; abstract;
   procedure ShowStartupAdvertising;
   function CheckStartupAdvertisingEnabled: Boolean;
   procedure CheckFirstLoginActivity;
   function CanFirstLoginActivity: Boolean;
   function CheckInstallDefaultSettings: Boolean;
   function IntegrationInProcess: Boolean;
   procedure vcmMainFormShow(Sender: TObject);
   procedure CheckConsultationManagerStatus;
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   procedure CheckLocalDataReady;
   procedure SearchResultEmpty(TryFullList: Boolean);
   procedure SearchResultExists;
   procedure AnotherSearchSuccessed;
   procedure SetDataFromQuery(const aQuery: IUnknown);
   procedure RequestFind;
   procedure RequestCheckFragmentsCount;
   procedure RequestCheckFindBack;
   procedure AnotherSearchCancelled;
   procedure MouseWheelListenerNotify(Msg: PMsg;
    var theResult: Tl3HookProcResult);
   function ProcessCommand(aCommand: Integer;
    InNewWindow: Boolean;
    const aContainer: IvcmContainer): Boolean;
   function ProcessLink(aLink: PnsLinkDataArray): Boolean;
   function CheckKey(aKey: PnsLinkDataArray): Boolean;
   procedure CheckInconic;
   procedure nsNotification(aType: TnsNotificationType);
   function pm_GetInitialState: InsBaseSearcherInitialState;
   procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
   function pm_GetStateForClone: InsBaseSearcherInitialState;
   function Get_BaseSearcher: InsBaseSearcher;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceFinish; override;
   procedure UserSettingsChanged; override;
    {* Изменились настройки пользователя }
   procedure StartSettingsEdit; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ReleaseResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInitFromPrevContainer(const aContainer: IvcmContainer;
    aForClone: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Common_MemUsage_Execute(const aParams: IvcmExecuteParamsPrim);
   constructor Create(AOwner: TComponent); override;
 end;//TMainForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , nsConst
 , nsQueryInterfaces
 , IOUnit
 , l3String
 , DataAdapter
 , nsOpenUtils
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , BaseTypesUnit
 , bsTypes
 , nsManagers
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsBaseSearcher
 , nsQueryUtils
 , nsContextHistory
 , MemoryUsage_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3AsincMessageWindow
 , l3SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , IntegrationProjectUnit
 {$If NOT Defined(NoVCM)}
 , vcmMenuManager
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ListenersManager
 , HelpIntfs
 , vtVerInf
 , SettingsUnit
 {$If NOT Defined(NoVCM)}
 , nsWindowsList
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConfiguration
 , nsValueMaps
 , resWarnImages
 , nsValueMapsIDs
 , nsSettingsUtils
 , ContextHistoryInterfaces
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsBaseSearchService
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

var g_IntegrationMessage: Cardinal = 0;
var g_LastMainWindowMessage: Cardinal = 0;

constructor TMainFormState.Create(const aBaseSearcherState: InsBaseSearcherInitialState;
 const aInnerState: IvcmBase);
//#UC START# *5729DFC3021F_5729DF4D0159_var*
//#UC END# *5729DFC3021F_5729DF4D0159_var*
begin
//#UC START# *5729DFC3021F_5729DF4D0159_impl*
 inherited Create;
 f_BaseSearcherState := aBaseSearcherState;
 f_InnerState := aInnerState;
//#UC END# *5729DFC3021F_5729DF4D0159_impl*
end;//TMainFormState.Create

class function TMainFormState.Make(const aBaseSearcherState: InsBaseSearcherInitialState;
 const aInnerState: IvcmBase): IMainFormState;
var
 l_Inst : TMainFormState;
begin
 l_Inst := Create(aBaseSearcherState, aInnerState);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TMainFormState.Make

function TMainFormState.Get_BaseSearcherState: InsBaseSearcherInitialState;
//#UC START# *5729DEC300A8_5729DF4D0159get_var*
//#UC END# *5729DEC300A8_5729DF4D0159get_var*
begin
//#UC START# *5729DEC300A8_5729DF4D0159get_impl*
 Result := f_BaseSearcherState;
//#UC END# *5729DEC300A8_5729DF4D0159get_impl*
end;//TMainFormState.Get_BaseSearcherState

function TMainFormState.Get_InnerState: IvcmBase;
//#UC START# *5729DFB7006F_5729DF4D0159get_var*
//#UC END# *5729DFB7006F_5729DF4D0159get_var*
begin
//#UC START# *5729DFB7006F_5729DF4D0159get_impl*
 Result := f_InnerState;
//#UC END# *5729DFB7006F_5729DF4D0159get_impl*
end;//TMainFormState.Get_InnerState

procedure TMainForm.UpdateUnreadConsultations;
//#UC START# *4F88013F007B_4A952BA3006D_var*
//#UC END# *4F88013F007B_4A952BA3006D_var*
begin
//#UC START# *4F88013F007B_4A952BA3006D_impl*
 IsRemUnreadConsultationsVisible := ConsultationManager.HasUnread;
 CheckConsultationConnection;
//#UC END# *4F88013F007B_4A952BA3006D_impl*
end;//TMainForm.UpdateUnreadConsultations

procedure TMainForm.InitForm;
//#UC START# *4F8813D6026A_4A952BA3006D_var*
//#UC END# *4F8813D6026A_4A952BA3006D_var*
begin
//#UC START# *4F8813D6026A_4A952BA3006D_impl*
 { Читаем позиции значка напоминания из настроек }
 if (not defDataAdapter.AdministratorLogin) and
  (not TvcmTabbedContainerFormDispatcher.Instance.CloningTab) and
  (not TvcmTabbedContainerFormDispatcher.Instance.ReopeningTab) then
 begin
  // Конфигурации
  if afw.Settings.LoadBoolean(pi_Sheets_Config, dv_Sheets_Config) then
   TdmStdRes.OpenConfList(Self)
  else
   TdmStdRes.CloseConfList(Self);
  // Основное меню(навигатор)
  if afw.Settings.LoadBoolean(pi_Sheets_MainMenu, dv_Sheets_MainMenu) then
   TdmStdRes.GetNavigator(nil, Self)
  else
   TdmStdRes.CloseNavigator(Self);
  // Мои документы
  if afw.Settings.LoadBoolean(pi_Sheets_MyDocuments, dv_Sheets_MyDocuments) then
   TdmStdRes.OpenFolders(Self, true)
  else
   TdmStdRes.CloseFolders(Self);
  // На контроле
  if afw.Settings.LoadBoolean(piSheetsDocUnderControl, dvSheetsDocUnderControl) then
   TdmStdRes.OpenUnderControl(Self)
  else
   TdmStdRes.CloseUnderControl(Self);
  if afw.Settings.LoadBoolean(piSheetsTaskPanel, dvSheetsTaskPanel) then
  begin
   TdmStdRes.CloseTasksPanel(Self); // http://mdp.garant.ru/pages/viewpage.action?pageId=342864296
   TdmStdRes.OpenTasksPanel(Self);
  end
  else
   TdmStdRes.CloseTasksPanel(Self);
 end;//not defDataAdapter.AdministratorLogin
 LoadSettings;
//#UC END# *4F8813D6026A_4A952BA3006D_impl*
end;//TMainForm.InitForm

procedure TMainForm.PrepareChildZoneBeforeResize(aNewHeight: Integer);
//#UC START# *4F881735018D_4A952BA3006D_var*

 function lp_UsedHeight: Integer;
  {* Высота используемая панелью инструментов, строкой состояния и другими
     "постоянными". }
 begin//lp_UsedHeight
  Result := Height - (ChildZonePanel.Height + ParentZonePanel.Height) +
   ParentZonePanel.Constraints.MinHeight;
 end;//lp_UsedHeight

var
 l_AvailableHeight: Integer;
//#UC END# *4F881735018D_4A952BA3006D_var*
begin
//#UC START# *4F881735018D_4A952BA3006D_impl*
 if (ChildZonePanel <> nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=365840014
  if ChildZonePanel.Visible then
  begin
   l_AvailableHeight := aNewHeight - lp_UsedHeight;
   // При уменьшении размера главной формы уменьшаем размер дочерней зоны, иначе
   // форму уменьшить будет нельзя:
   if (ChildZonePanel.Height > l_AvailableHeight) and
     (l_AvailableHeight >= ChildZonePanel.Constraints.MinHeight) then
    ChildZonePanel.Height := l_AvailableHeight;
  end;//if ChildZonePanel.Visible then
//#UC END# *4F881735018D_4A952BA3006D_impl*
end;//TMainForm.PrepareChildZoneBeforeResize

function TMainForm.BaseSearcher: InsBaseSearcher;
//#UC START# *4F881C2E0175_4A952BA3006D_var*
//#UC END# *4F881C2E0175_4A952BA3006D_var*
begin
//#UC START# *4F881C2E0175_4A952BA3006D_impl*
 if (f_BaseSearcher = nil) then
  f_BaseSearcher := TnsBaseSearcher.Make(Self, nsGetContextHistory(ns_chkDocument));
 Result := f_BaseSearcher;
//#UC END# *4F881C2E0175_4A952BA3006D_impl*
end;//TMainForm.BaseSearcher

procedure TMainForm.ShowStartupAdvertising;
//#UC START# *4F8BF3940103_4A952BA3006D_var*
const
 c_HelpWhatsNewPage ='page-main.htm';
 {$I nsBuildVersion.inc}
var
 l_SettingsVersion: Il3CString;
 l_ShellVersion: Il3CString;
 l_ShowCounter: Integer;

 procedure lp_ShowHelp;
 const
  c_MaxWhatNewAutoFlash = 3;
 var
  l_HelpFile: string;
 begin//lp_ShowHelp
  if defDataAdapter.CommonInterfaces.AutoShowHelp then
  begin
   l_SettingsVersion := afw.PermanentSettings.LoadString(pi_ActiveShelVersion);
   if l3Same(l_SettingsVersion, l_ShellVersion) then
   begin
    l_ShowCounter := afw.PermanentSettings.LoadInteger(pi_ShowHelpCounter);
    // Если версия совпадает и уже показывали нужное число раз - выходим и ничего не делаем
    if l_ShowCounter >= c_MaxWhatNewAutoFlash then
     Exit;
    Inc(l_ShowCounter);
   end//l3Same(l_SettingsVersion, l_ShellVersion)
   else
    l_ShowCounter := 1;

   // Новинки показываются из своего chm-файла
   l_HelpFile := Application.HelpFile;
   try
    Application.HelpFile := 'F1WhatsNew.chm';
    try
     Application.HelpSystem.ShowTopicHelp(c_HelpWhatsNewPage, '');
    except
     on EHelpSystemException do
      Say(war_HelpNotFound);
    end;//try..except
   finally
    Application.HelpFile := l_HelpFile;
   end;//try..finally
  end//defDataAdapter.CommonInterfaces.AutoShowHelp
  else
   l_ShowCounter := c_MaxWhatNewAutoFlash;
  afw.PermanentSettings.SaveInteger(pi_ShowHelpCounter, l_ShowCounter);
  afw.PermanentSettings.SaveString(pi_ActiveShelVersion, l_ShellVersion);
 end;//lp_ShowHelp

//#UC END# *4F8BF3940103_4A952BA3006D_var*
begin
//#UC START# *4F8BF3940103_4A952BA3006D_impl*
 if CheckStartupAdvertisingEnabled then
 begin
  if (c_BuildVersion <> 'X.XX.X.XXX') then
  begin
   l_ShellVersion := l3Fmt('%s', [Copy(c_BuildVersion, 1, 6)]);
  end
  else
   with TVersionInfo.Create, FileLongVersion do
   try
    l_ShellVersion := l3Fmt('%d.%d.%d', [All[2], All[1], All[4]]);
   finally
    Free;
   end;//try..finally

  if defDataAdapter.Monitoring.IsExist and
     defDataAdapter.PrimeManager.GetHasOnlineAccess and
   not afw.PermanentSettings.LoadBoolean(pi_NoShowPrimeDialog, dv_NoShowPrimeDialog) then
  begin
   afw.PermanentSettings.SaveBoolean(pi_NoShowPrimeDialog, True);
   afw.PermanentSettings.SaveBoolean(pi_NeedShowSettingsDialog, dmStdRes.NeedShowSettingsDialog);
   dmStdRes.NeedShowSettingsDialog := False;
   dmStdRes.NeedAskToFillPrimeAtStartup := True;
  end;

  if not dmStdRes.NeedAskToFillPrimeAtStartup then
  begin
   if not dmStdRes.NeedShowSettingsDialog then
    dmStdRes.NeedShowSettingsDialog := afw.PermanentSettings.LoadBoolean(pi_NeedShowSettingsDialog, dv_NeedShowSettingsDialog);
   if dmStdRes.NeedShowSettingsDialog then
   begin
    dmStdRes.NeedShowSettingsDialog := True;
    afw.PermanentSettings.SaveBoolean(pi_NeedShowSettingsDialog, False);
   end else
   if not afw.Settings.LoadBoolean(pi_DayTips_DontShowAtStart, dv_DayTips_DontShowAtStart) then
   begin
    f_StartupTipsForm := TdmStdRes.ShowDayTipsAtStartup;
    if not Assigned(f_StartupTipsForm) then
     lp_ShowHelp;
   end else
    lp_ShowHelp;
  end;
 end;//CheckStartupAdvertisingEnabled
//#UC END# *4F8BF3940103_4A952BA3006D_impl*
end;//TMainForm.ShowStartupAdvertising

function TMainForm.CheckStartupAdvertisingEnabled: Boolean;
//#UC START# *4F8BF3B5012A_4A952BA3006D_var*
//#UC END# *4F8BF3B5012A_4A952BA3006D_var*
begin
//#UC START# *4F8BF3B5012A_4A952BA3006D_impl*
 Result := (g_Dispatcher.FormDispatcher.MainFormsCount = 1) and
  not defDataAdapter.AdministratorLogin;
//#UC END# *4F8BF3B5012A_4A952BA3006D_impl*
end;//TMainForm.CheckStartupAdvertisingEnabled

procedure TMainForm.CheckFirstLoginActivity;
//#UC START# *4F8BF3CC02A6_4A952BA3006D_var*
var
 l_FirstLogin: Boolean;
//#UC END# *4F8BF3CC02A6_4A952BA3006D_var*
begin
//#UC START# *4F8BF3CC02A6_4A952BA3006D_impl*
 if CanFirstLoginActivity then
 begin
  l_FirstLogin := afw.PermanentSettings.LoadBoolean(pi_FirstLogin, True);
  if l_FirstLogin then
   defDataAdapter.ConsultationManager.CreateQueryWithNoticeUser;
  afw.PermanentSettings.SaveBoolean(pi_FirstLogin, false);
 end;//CanFirstLoginActivity
//#UC END# *4F8BF3CC02A6_4A952BA3006D_impl*
end;//TMainForm.CheckFirstLoginActivity

function TMainForm.CanFirstLoginActivity: Boolean;
//#UC START# *4F8BF3ED02D0_4A952BA3006D_var*
//#UC END# *4F8BF3ED02D0_4A952BA3006D_var*
begin
//#UC START# *4F8BF3ED02D0_4A952BA3006D_impl*
 Result := (g_Dispatcher.FormDispatcher.MainFormsCount = 1) and
  not defDataAdapter.AdministratorLogin;
//#UC END# *4F8BF3ED02D0_4A952BA3006D_impl*
end;//TMainForm.CanFirstLoginActivity

function TMainForm.CheckInstallDefaultSettings: Boolean;
//#UC START# *4F8BF4060008_4A952BA3006D_var*
//#UC END# *4F8BF4060008_4A952BA3006D_var*
begin
//#UC START# *4F8BF4060008_4A952BA3006D_impl*
 Result := False;
 with DefDataAdapter do
 begin
  // Если открывается копия оболочки, то InstallDefaultSettingsInfo будет уже
  // пустым, см. комм. в конце процедуры.
  //
  // В системе были установлены настройки по умолчанию:
  if Assigned(InstallDefaultSettingsInfo) and
   (InstallDefaultSettingsInfo.GetState <> NO_CHANGES) then
   Result := True;
 end;//with DefDataAdapter.InstallDefaultSettingsInfo do
 // Отпустим интерфейс, он нам больше не нужен, во избежании недоразумений,
 // он всетаки содержит указатель на скопированную конфигурацию:
 DefDataAdapter.InstallDefaultSettingsInfo := nil;
//#UC END# *4F8BF4060008_4A952BA3006D_impl*
end;//TMainForm.CheckInstallDefaultSettings

function TMainForm.IntegrationInProcess: Boolean;
//#UC START# *4F8BF41E00D8_4A952BA3006D_var*
var
 l_Handle: THandle;
//#UC END# *4F8BF41E00D8_4A952BA3006D_var*
begin
//#UC START# *4F8BF41E00D8_4A952BA3006D_impl*
 l_Handle := OpenMutex(SYNCHRONIZE,False,c_IntergationMutexName);
 try
  Result := l_Handle <> 0;
 finally
  CloseHandle(l_Handle);
 end;//try..finally 
//#UC END# *4F8BF41E00D8_4A952BA3006D_impl*
end;//TMainForm.IntegrationInProcess

procedure TMainForm.vcmMainFormShow(Sender: TObject);
//#UC START# *4F8BF5C602C3_4A952BA3006D_var*
//#UC END# *4F8BF5C602C3_4A952BA3006D_var*
begin
//#UC START# *4F8BF5C602C3_4A952BA3006D_impl*
 if not NeedUseTabs then
  ShowStartupAdvertising;
 TdmStdRes.MakeChatDispatcher.StartProcessing;
//#UC END# *4F8BF5C602C3_4A952BA3006D_impl*
end;//TMainForm.vcmMainFormShow

procedure TMainForm.CorrectStartupTipsPosition;
//#UC START# *5411B2D10071_4A952BA3006D_var*
var
 l_WndPos: TPoint;
//#UC END# *5411B2D10071_4A952BA3006D_var*
begin
//#UC START# *5411B2D10071_4A952BA3006D_impl*
 if Assigned(f_StartupTipsForm) and
    Assigned(f_StartupTipsForm.VCLWinControl) then
 try
  l_WndPos := ClientToScreen(Point(0, 0));

  with f_StartupTipsForm.VCLWinControl do
   SetBounds(l_WndPos.X + (Self.Width - Width) div 2,
             l_WndPos.Y + (Self.Height - Height) div 2,
             Width, Height);
 finally
  f_StartupTipsForm := nil;
 end;
//#UC END# *5411B2D10071_4A952BA3006D_impl*
end;//TMainForm.CorrectStartupTipsPosition

procedure TMainForm.CheckConsultationManagerStatus;
//#UC START# *550144FA0072_4A952BA3006D_var*
var
 l_NeedSay: Boolean;
 l_Status: TbsConsultationOperations;
//#UC END# *550144FA0072_4A952BA3006D_var*
begin
//#UC START# *550144FA0072_4A952BA3006D_impl*
 l_NeedSay := (Visible and Enabled and
  ((Dispatcher.FormDispatcher.CurrentMainForm.VCLWinControl = Self) or
  (Dispatcher.FormDispatcher.MainFormsCount = 1)));

 l_Status := ConsultationManager.CurrentStatus;

 if (coUnreadChanged in l_Status) then
  UpdateUnreadConsultations;
 if (coNoConnection in l_Status) and l_NeedSay then
  Say(war_NoConnectionOnSend, [defDataAdapter.GetDealerInfo]);
 if (coNoSubscription in l_Status) and l_NeedSay then
  Say(war_NoSubscription, [defDataAdapter.GetDealerInfo]);
 if (coInternetConnected in l_Status) then
  CheckConsultationConnection;
 if (coInternetDisConnected in l_Status) then
  CheckInternetConnection;
//#UC END# *550144FA0072_4A952BA3006D_impl*
end;//TMainForm.CheckConsultationManagerStatus

procedure TMainForm.NotifyBaseSearcherFormClosing;
//#UC START# *55CC2C9101F8_4A952BA3006D_var*
//#UC END# *55CC2C9101F8_4A952BA3006D_var*
begin
//#UC START# *55CC2C9101F8_4A952BA3006D_impl*
 if (f_BaseSearcher <> nil) then
  f_BaseSearcher.ContainerIsClosing;
//#UC END# *55CC2C9101F8_4A952BA3006D_impl*
end;//TMainForm.NotifyBaseSearcherFormClosing

procedure TMainForm.WMActivate(var Message: TWMActivate);
//#UC START# *4F882B3402EB_4A952BA3006D_var*
var
 l_p: TPoint;
//#UC END# *4F882B3402EB_4A952BA3006D_var*
begin
//#UC START# *4F882B3402EB_4A952BA3006D_impl*
 inherited;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=346763353
 // PS1: никакие комбинации с SetActiveWindow, WM_ACTIVATE + Result не помогли...
 // PS2: после inherited сделано специально
 if Visible and CanFocus and
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=566789558
    (Message.Active = WA_ACTIVE) then
 begin
  if not l3IsTimeElapsed(f_LastWMActivateTickCount, 100) then
  begin
   // ждем указанное число миганий, чтобы не выполнять в обычном режиме работы
   // после чего, делаем клик средней клавишей мыши (перевод фокуса)
   Inc(f_ActivatesCount);
   if f_ActivatesCount > 2 then
   begin
    f_ActivatesCount := 0;

    SetForegroundWindow(Handle);

    GetCursorPos(l_p);
    SetCursorPos(Left + Width div 2, Top + 2);
    Mouse_Event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
    Mouse_Event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
    SetCursorPos(l_p.x, l_p.y);
   end;//f_ActivatesCount > 2
  end//not l3IsTimeElapsed(f_LastWMActivateTickCount, 100)
  else
   f_ActivatesCount := 0;
  f_LastWMActivateTickCount := GetTickCount;   
 end;//Message.Active = WA_ACTIVE 
//#UC END# *4F882B3402EB_4A952BA3006D_impl*
end;//TMainForm.WMActivate

procedure TMainForm.WMActivateApp(var Message: TWMActivateApp);
//#UC START# *4F882B6101CA_4A952BA3006D_var*
var
 l_Flash: IvcmFlashingWindow;
 l_IDX: Integer;
//#UC END# *4F882B6101CA_4A952BA3006D_var*
begin
//#UC START# *4F882B6101CA_4A952BA3006D_impl*
 ActivateAllAsyncWindows(Message.Active);
 if Message.Active then
  for l_IDX := 0 to Dispatcher.FormDispatcher.MainFormsCount - 1 do
   if Supports(Dispatcher.FormDispatcher.MainForm[l_IDX], IvcmFlashingWindow, l_Flash) then
    l_Flash.StopFlashing;
 TvcmTabbedContainerFormDispatcher.Instance.StopFlashing;
 inherited;
//#UC END# *4F882B6101CA_4A952BA3006D_impl*
end;//TMainForm.WMActivateApp

procedure TMainForm.WMCopyData(var aMessage: TWMCopyData);
//#UC START# *4F882BA300FD_4A952BA3006D_var*
var
 l_Processor: InsIntegrationProcessor;
 l_RealMainForm: TCustomForm;
//#UC END# *4F882BA300FD_4A952BA3006D_var*
begin
//#UC START# *4F882BA300FD_4A952BA3006D_impl*
 if aMessage.CopyDataStruct^.dwData = g_IntegrationMessage then
 begin
  l_RealMainForm := GetParentForm(Self);
  if (l_RealMainForm = nil) then
   l_RealMainForm := Self;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=566812855
  if not IsWindowEnabled(l_RealMainForm.Handle) then
   aMessage.Result := GI_BUSY
  else
   if aMessage.CopyDataStruct^.cbData<SizeOf(TIntegrationData) then
    aMessage.Result := GI_INVALIDLINKFORMAT
   else
    with PIntegrationData(aMessage.CopyDataStruct^.lpData)^ do
    begin
     if OpenInNewWindow then
      if OpenNewMainWindow = nil then
      begin
       aMessage.Result := GI_TOOMANYOPENWINDOWS;
       Exit;
      end;
      // - http://mdp.garant.ru/pages/viewpage.action?pageId=566789558
     if Supports(Self.Dispatcher.FormDispatcher.MainForm[Self.Dispatcher.FormDispatcher.MainFormsCount-1],
      InsIntegrationProcessor, l_Processor) then
      begin
       l_Processor.CheckInconic;
       aMessage.Result := aMessage.CopyDataStruct^.dwData;
       case Kind of
        idkCommand:
         if aMessage.CopyDataStruct^.cbData<>SizeOf(TIntegrationData) then
          aMessage.Result := GI_INVALIDLINKFORMAT
         else
          if not l_Processor.ProcessCommand(Command, OpenInNewWindow, nil) then
           aMessage.Result := GI_INVALIDLINKFORMAT;
        idkLink:
         if (aMessage.CopyDataStruct^.cbData < SizeOf(TIntegrationData)) or
          (Integer(StrLen(PAnsiChar(@Link)))<>LinkLength) then
          aMessage.Result := GI_INVALIDLINKFORMAT
         else
         begin
          try
           if not l_Processor.ProcessLink(@Link) then
            aMessage.Result := GI_INVALIDLINKFORMAT;
          except
           on ECanNotFindData do aMessage.Result := GI_SYSTEMERROR;
           on EInvalidXMLType do aMessage.Result := GI_INVALIDLINKFORMAT;
           on ECantCreateObject do aMessage.Result := GI_QUERYPARAMSHASABSENTVALUES;
           //http://mdp.garant.ru/pages/viewpage.action?pageId=462553651
           on ETryToFindEmptyContext do aMessage.Result := GI_TRYTOFINDEMPTYCONTEXT;
          end;
         end;
        idkCheckIntegrationKey:
         if (aMessage.CopyDataStruct^.cbData < SizeOf(TIntegrationData)) or
          (Integer(StrLen(PAnsiChar(@Key)))<>KeyLength) then
          aMessage.Result := GI_SYSTEMERROR
         else
          if not l_Processor.CheckKey(@Key) then
           aMessage.Result := GI_ALREADYRUNNING;
       end;
       if (aMessage.Result <> LongInt(aMessage.CopyDataStruct^.dwData)) and
        (OpenInNewWindow or not f_WindowInitialized) then
        l_Processor.ProcessCommand(GC_ACTIVATE, True, nil);
      end
     else
      aMessage.Result := GI_NOTFOUND;
   end;//aMessage.CopyDataStruct^.cbData<SizeOf(TIntegrationData)
 end//aMessage.CopyDataStruct^.dwData = g_IntegrationMessage
 else
  if aMessage.CopyDataStruct^.dwData = g_LastMainWindowMessage then
   aMessage.Result := Self.Dispatcher.FormDispatcher.MainForm[Self.Dispatcher.FormDispatcher.MainFormsCount-1].VCLWinControl.Handle;
//#UC END# *4F882BA300FD_4A952BA3006D_impl*
end;//TMainForm.WMCopyData

procedure TMainForm.WMDisplayChange(var aMessage: TWMDisplayChange);
//#UC START# *4F882BCD02ED_4A952BA3006D_var*
//#UC END# *4F882BCD02ED_4A952BA3006D_var*
begin
//#UC START# *4F882BCD02ED_4A952BA3006D_impl*
 MenuManager.BeginOp;
 try
  (MenuManager as TvcmCustomMenuManager).GlyphColordepth := (MenuManager as TvcmCustomMenuManager).GlyphColordepth;
 finally
  MenuManager.EndOp;
 end;//try..finally
//#UC END# *4F882BCD02ED_4A952BA3006D_impl*
end;//TMainForm.WMDisplayChange

procedure TMainForm.WMWindowPosChanging(var aMessage: TWMWindowPosChanging);
//#UC START# *4F882C0000BA_4A952BA3006D_var*
//#UC END# *4F882C0000BA_4A952BA3006D_var*
begin
//#UC START# *4F882C0000BA_4A952BA3006D_impl*
 with aMessage.WindowPos^ do
  if cy > Constraints.MinHeight then
   PrepareChildZoneBeforeResize(cy);
 inherited;
//#UC END# *4F882C0000BA_4A952BA3006D_impl*
end;//TMainForm.WMWindowPosChanging

procedure TMainForm.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_4A952BA3006D_var*
//#UC END# *46A4504B03C4_4A952BA3006D_var*
begin
//#UC START# *46A4504B03C4_4A952BA3006D_impl*
 if TbsNotification(aOperation) = nConsultation then
  CheckConsultationManagerStatus;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=590745386 
//#UC END# *46A4504B03C4_4A952BA3006D_impl*
end;//TMainForm.Notify

procedure TMainForm.CheckLocalDataReady;
//#UC START# *496B4F6D02B5_4A952BA3006D_var*
var
 l_Notifier: InsBaseSearchDataReadyChecker;
//#UC END# *496B4F6D02B5_4A952BA3006D_var*
begin
//#UC START# *496B4F6D02B5_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchDataReadyChecker, l_Notifier) then
  l_Notifier.CheckLocalDataReady;
//#UC END# *496B4F6D02B5_4A952BA3006D_impl*
end;//TMainForm.CheckLocalDataReady

procedure TMainForm.SearchResultEmpty(TryFullList: Boolean);
//#UC START# *496B4FAA02FA_4A952BA3006D_var*
var
 l_Processor: InsBaseSearchResultProcessor;
//#UC END# *496B4FAA02FA_4A952BA3006D_var*
begin
//#UC START# *496B4FAA02FA_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchResultProcessor, l_Processor) then
  l_Processor.SearchResultEmpty(TryFullList);
//#UC END# *496B4FAA02FA_4A952BA3006D_impl*
end;//TMainForm.SearchResultEmpty

procedure TMainForm.SearchResultExists;
//#UC START# *496B4FC70065_4A952BA3006D_var*
var
 l_Processor: InsBaseSearchResultProcessor;
//#UC END# *496B4FC70065_4A952BA3006D_var*
begin
//#UC START# *496B4FC70065_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchResultProcessor, l_Processor) then
  l_Processor.SearchResultExists;
//#UC END# *496B4FC70065_4A952BA3006D_impl*
end;//TMainForm.SearchResultExists

procedure TMainForm.AnotherSearchSuccessed;
//#UC START# *496B4FD20320_4A952BA3006D_var*
var
 l_Processor: InsBaseSearchResultProcessor;
//#UC END# *496B4FD20320_4A952BA3006D_var*
begin
//#UC START# *496B4FD20320_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchResultProcessor, l_Processor) then
  l_Processor.AnotherSearchSuccessed;
//#UC END# *496B4FD20320_4A952BA3006D_impl*
end;//TMainForm.AnotherSearchSuccessed

procedure TMainForm.SetDataFromQuery(const aQuery: IUnknown);
//#UC START# *496B534B0098_4A952BA3006D_var*
var
 l_QueryLoader: InsBaseSearchQueryDataProcessor;
//#UC END# *496B534B0098_4A952BA3006D_var*
begin
//#UC START# *496B534B0098_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchQueryDataProcessor, l_QueryLoader) then
  l_QueryLoader.SetDataFromQuery(aQuery);
//#UC END# *496B534B0098_4A952BA3006D_impl*
end;//TMainForm.SetDataFromQuery

procedure TMainForm.RequestFind;
//#UC START# *496B5356008C_4A952BA3006D_var*
var
 l_QueryLoader: InsBaseSearchQueryDataProcessor;
//#UC END# *496B5356008C_4A952BA3006D_var*
begin
//#UC START# *496B5356008C_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchQueryDataProcessor, l_QueryLoader) then
  try
   l_QueryLoader.RequestFind;
  except
   on ETryToFindEmptyContext do
    Ask(inf_SimpleMainMenuSearchCondition);
  end;//try..except
//#UC END# *496B5356008C_4A952BA3006D_impl*
end;//TMainForm.RequestFind

procedure TMainForm.RequestCheckFragmentsCount;
//#UC START# *49FFFE5B033A_4A952BA3006D_var*
var
 l_QueryLoader: InsBaseSearchQueryDataProcessor;
//#UC END# *49FFFE5B033A_4A952BA3006D_var*
begin
//#UC START# *49FFFE5B033A_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchQueryDataProcessor, l_QueryLoader) then
  l_QueryLoader.RequestCheckFragmentsCount;
//#UC END# *49FFFE5B033A_4A952BA3006D_impl*
end;//TMainForm.RequestCheckFragmentsCount

procedure TMainForm.RequestCheckFindBack;
//#UC START# *4A13A97F0211_4A952BA3006D_var*
var
 l_QueryLoader: InsBaseSearchQueryDataProcessor;
//#UC END# *4A13A97F0211_4A952BA3006D_var*
begin
//#UC START# *4A13A97F0211_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchQueryDataProcessor, l_QueryLoader) then
  l_QueryLoader.RequestCheckFindBack;
//#UC END# *4A13A97F0211_4A952BA3006D_impl*
end;//TMainForm.RequestCheckFindBack

{$If NOT Defined(NoVCM)}
procedure TMainForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4AC5D61E0284_4A952BA3006Dtest_var*
//#UC END# *4AC5D61E0284_4A952BA3006Dtest_var*
begin
//#UC START# *4AC5D61E0284_4A952BA3006Dtest_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4AC5D61E0284_4A952BA3006Dtest_impl*
end;//TMainForm.Result_Cancel_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4AC5D61E0284_4A952BA3006Dexec_var*
//#UC END# *4AC5D61E0284_4A952BA3006Dexec_var*
begin
//#UC START# *4AC5D61E0284_4A952BA3006Dexec_impl*
 Dispatcher.History.Back;
//#UC END# *4AC5D61E0284_4A952BA3006Dexec_impl*
end;//TMainForm.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
 {* Отмена }
//#UC START# *4AC5D61E0284_4A952BA3006Dgetstate_var*
//#UC END# *4AC5D61E0284_4A952BA3006Dgetstate_var*
begin
//#UC START# *4AC5D61E0284_4A952BA3006Dgetstate_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_4A952BA3006Dgetstate_impl*
end;//TMainForm.Result_Cancel_GetState
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainForm.AnotherSearchCancelled;
//#UC START# *4C04AFC8015D_4A952BA3006D_var*
var
 l_Processor: InsBaseSearchResultProcessor;
//#UC END# *4C04AFC8015D_4A952BA3006D_var*
begin
//#UC START# *4C04AFC8015D_4A952BA3006D_impl*
 if Supports(BaseSearcher, InsBaseSearchResultProcessor, l_Processor) then
  l_Processor.AnotherSearchCancelled;
//#UC END# *4C04AFC8015D_4A952BA3006D_impl*
end;//TMainForm.AnotherSearchCancelled

procedure TMainForm.MouseWheelListenerNotify(Msg: PMsg;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79D08A02C7_4A952BA3006D_var*
var
 l_Rect: TRect;
//#UC END# *4F79D08A02C7_4A952BA3006D_var*
begin
//#UC START# *4F79D08A02C7_4A952BA3006D_impl*
 if HandleAllocated and (Msg^.Message = WM_MOUSEWHEEL) and
   (KeysToShiftState(LoWord(Msg^.wParam)) = [ssCtrl]) and IsWindowEnabled(Handle) then
 begin
  GetWindowRect(Handle, l_Rect);
  if PtInRect(l_Rect, SmallPointToPoint(TSmallPoint(Msg^.LParam))) then
  begin
   if CanChangeDefaultFontSize(Msg^.wParam > 0) then
    ChangeDefaultFontSize(Msg^.wParam > 0);
   Msg^.Message := WM_NULL;
  end;//PtInRect(l_Rect, SmallPointToPoint(TSmallPoint(Msg^.LParam)))
 end;//HandleAllocated and (Msg^.Message = WM_MOUSEWHEEL)..
//#UC END# *4F79D08A02C7_4A952BA3006D_impl*
end;//TMainForm.MouseWheelListenerNotify

function TMainForm.ProcessCommand(aCommand: Integer;
 InNewWindow: Boolean;
 const aContainer: IvcmContainer): Boolean;
//#UC START# *4F86BF5F0198_4A952BA3006D_var*
var
 l_FormToActivate: TCustomForm;
//#UC END# *4F86BF5F0198_4A952BA3006D_var*
begin
//#UC START# *4F86BF5F0198_4A952BA3006D_impl*
 f_WindowInitialized := True;
 Result := (aCommand >= GC_FIRST) and (aCommand <= GC_LAST);
 if Result then
 begin
  l_FormToActivate := GetParentForm(Self);
  if (l_FormToActivate = nil) then
   l_FormToActivate := Self;
  if (l_FormToActivate.WindowState = wsMinimized) then
   SendMessage(l_FormToActivate.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  SetActiveWindow(l_FormToActivate.Handle);
  SetForegroundWindow(l_FormToActivate.Handle);   
  afw.ProcessMessages;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=566789558
  case aCommand of
   GC_ACTIVATE:
    if InNewWindow then
     ProcessCommand(ConvertOpenOnStartSetting, false, aContainer);
   GC_MAIN_MENU:
    TdmStdRes.OpenMainMenuIfNeeded(aContainer);
   GC_NAVIGATOR:
    TdmStdRes.OpenRubricatorOnStart(aContainer);
   GC_SITUATION_SEARCH:
    TdmStdRes.OpenQuery(lg_qtKeyWord, nil, aContainer);
   GC_ATTRIBUTES_SEARCH:
    TdmStdRes.OpenQuery(lg_qtAttribute, nil, aContainer);
   GC_PUBLISH_SOURCE_SEARCH:
    //http://mdp.garant.ru/pages/viewpage.action?pageId=497226332
    if defDataAdapter.IsExists_PublishSourceTag then
     TdmStdRes.OpenQuery(lg_qtPublishedSource, nil, aContainer)
    else
     TdmStdRes.OpenMainMenuIfNeeded(aContainer);
   GC_REVIEW:
    TdmStdRes.OpenQuery(lg_qtLegislationReview, nil, aContainer);
   GC_DICTION:
    Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Diction_OpenDict);
   GC_NEW_DOCS:
    TdmStdRes.OpenNewDocs(aContainer);
   GC_INPHARM_SEARCH:
    if defDataAdapter.IsInpharmExists then
     TdmStdRes.OpenQuery(lg_qtInpharmSearch, nil, aContainer)
    else
     TdmStdRes.OpenMainMenuIfNeeded(aContainer);
   GC_DRUG_LIST:
    if defDataAdapter.IsInpharmExists then
     //Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_DrugList)
     TdmStdRes.OpenDrugListIfNeeded(aContainer)
    else
     TdmStdRes.OpenMainMenuIfNeeded(aContainer);
   GC_INPHARM_MAIN_MENU:
    if defDataAdapter.IsInpharmExists then
     TdmStdRes.OpenInpharmMainMenu(aContainer)
     //Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_MedicMainMenu)
    else
     TdmStdRes.OpenMainMenuIfNeeded(aContainer);
   GC_IMPHARM_DICTION:
    if defDataAdapter.IsInpharmExists then
     Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_MedicDiction)
    else
     TdmStdRes.OpenMainMenuIfNeeded(aContainer);
   GC_INTERNET_AGENT:
    if defDataAdapter.IsInternetAgentEnabled then
     Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_InternetAgent_InternetAgent)
    else
     TdmStdRes.OpenMainMenuIfNeeded(aContainer);
   GC_OPEN_CONSULT:
    Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Search_OpenConsult);
   GC_PRIME:
    TdmStdRes.OpenNewsLine(True)
   else
    TdmStdRes.OpenMainMenuIfNeeded(aContainer);
  end;//case aCommand
 end;//Result
//#UC END# *4F86BF5F0198_4A952BA3006D_impl*
end;//TMainForm.ProcessCommand

function TMainForm.ProcessLink(aLink: PnsLinkDataArray): Boolean;
//#UC START# *4F86BF850173_4A952BA3006D_var*
//#UC END# *4F86BF850173_4A952BA3006D_var*
begin
//#UC START# *4F86BF850173_4A952BA3006D_impl*
 try
  SetForegroundWindow(Handle);
  Result := nsIntergationOpenLink(PAnsiChar(aLink), Self);
 except
  if not HasForm(vcm_ztParent) then
   ProcessCommand(ConvertOpenOnStartSetting, False, Self);
  raise;
 end;//try..except
//#UC END# *4F86BF850173_4A952BA3006D_impl*
end;//TMainForm.ProcessLink

function TMainForm.CheckKey(aKey: PnsLinkDataArray): Boolean;
//#UC START# *4F86BFA3034E_4A952BA3006D_var*
var
 l_Str: IString;
//#UC END# *4F86BFA3034E_4A952BA3006D_var*
begin
//#UC START# *4F86BFA3034E_4A952BA3006D_impl*
 try
  DefDataAdapter.Integration.GetIntegrationComplectId(l_Str);
  Result := StrComp(PAnsiChar(aKey),l_Str.GetData) = 0;
 except
  on ECanNotFindData do
   Result := False;
 end;//try..except
//#UC END# *4F86BFA3034E_4A952BA3006D_impl*
end;//TMainForm.CheckKey

procedure TMainForm.CheckInconic;
//#UC START# *4F86BFBF01AE_4A952BA3006D_var*
var
 l_Placement: TWindowPlacement;
//#UC END# *4F86BFBF01AE_4A952BA3006D_var*
begin
//#UC START# *4F86BFBF01AE_4A952BA3006D_impl*
 if IsIconic(Handle) then
 begin
  l_Placement.length := SizeOf(TWindowPlacement);
  GetWindowPlacement(Handle, @l_Placement);
  if (l_Placement.flags and WPF_RESTORETOMAXIMIZED) <> 0 then
   WindowState := wsMaximized
  else
   WindowState := wsNormal;
 end;//IsIconic(Handle)
//#UC END# *4F86BFBF01AE_4A952BA3006D_impl*
end;//TMainForm.CheckInconic

procedure TMainForm.Common_MemUsage_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4F88213001DE_4A952BA3006Dexec_var*
//#UC END# *4F88213001DE_4A952BA3006Dexec_var*
begin
//#UC START# *4F88213001DE_4A952BA3006Dexec_impl*
 {$IfOpt D+}
 TMemoryUsageForm.Make(vcmMakeParams);
 {$EndIf}
//#UC END# *4F88213001DE_4A952BA3006Dexec_impl*
end;//TMainForm.Common_MemUsage_Execute

procedure TMainForm.nsNotification(aType: TnsNotificationType);
//#UC START# *542BF11D00B6_4A952BA3006D_var*
//#UC END# *542BF11D00B6_4A952BA3006D_var*
begin
//#UC START# *542BF11D00B6_4A952BA3006D_impl*
 if aType = ntMainFormBecomeTopmostAtStartup then
  ShowStartupAdvertising;
//#UC END# *542BF11D00B6_4A952BA3006D_impl*
end;//TMainForm.nsNotification

function TMainForm.pm_GetInitialState: InsBaseSearcherInitialState;
//#UC START# *54327CCD0178_4A952BA3006Dget_var*
//#UC END# *54327CCD0178_4A952BA3006Dget_var*
begin
//#UC START# *54327CCD0178_4A952BA3006Dget_impl*
 Result := BaseSearcher.MakeStateParams([ns_sseContext, ns_sseNeedShowWindow], False);
//#UC END# *54327CCD0178_4A952BA3006Dget_impl*
end;//TMainForm.pm_GetInitialState

procedure TMainForm.NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
//#UC START# *55321ADE02E9_4A952BA3006D_var*
//#UC END# *55321ADE02E9_4A952BA3006D_var*
begin
//#UC START# *55321ADE02E9_4A952BA3006D_impl*
 if aNotification = tcnMainFormBecomeVisible then
 begin
  if Assigned(Application.MainForm) then
   if Application.MainForm.Visible then
    CorrectStartupTipsPosition;
 end;
//#UC END# *55321ADE02E9_4A952BA3006D_impl*
end;//TMainForm.NotifyContainersChanged

function TMainForm.pm_GetStateForClone: InsBaseSearcherInitialState;
//#UC START# *560B83DE0294_4A952BA3006Dget_var*
//#UC END# *560B83DE0294_4A952BA3006Dget_var*
begin
//#UC START# *560B83DE0294_4A952BA3006Dget_impl*
 Result := BaseSearcher.MakeStateParams([ns_sseContext, ns_sseNeedShowWindow, ns_sseOpenKind], True); 
//#UC END# *560B83DE0294_4A952BA3006Dget_impl*
end;//TMainForm.pm_GetStateForClone

function TMainForm.Get_BaseSearcher: InsBaseSearcher;
//#UC START# *5631AC7700D9_4A952BA3006Dget_var*
//#UC END# *5631AC7700D9_4A952BA3006Dget_var*
begin
//#UC START# *5631AC7700D9_4A952BA3006Dget_impl*
 Result := BaseSearcher;
//#UC END# *5631AC7700D9_4A952BA3006Dget_impl*
end;//TMainForm.Get_BaseSearcher

procedure TMainForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A952BA3006D_var*
//#UC END# *479731C50290_4A952BA3006D_var*
begin
//#UC START# *479731C50290_4A952BA3006D_impl*
 f_InitialContext := nil;
 f_StartupTipsForm := nil;
 TvcmTabbedContainerFormDispatcher.Instance.UnSubscribe(Self);
 if (ConsultationManager <> nil) then
  ConsultationManager.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
 // Удалим форму из списка открытых окон
 Tl3ListenersManager.RemoveMouseWheelListener(Self);
 TnsNotificationManager.RemoveListener(Self);
 NotifyBaseSearcherFormClosing;
 TnsBaseSearchService.Instance.UnregisterBaseSearcherProvider(Self, Self); 
 inherited;
//#UC END# *479731C50290_4A952BA3006D_impl*
end;//TMainForm.Cleanup

constructor TMainForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4A952BA3006D_var*
//#UC END# *47D1602000C6_4A952BA3006D_var*
begin
//#UC START# *47D1602000C6_4A952BA3006D_impl*
 Self.OnShow := Self.VcmMainFormShow;
 inherited;
//#UC END# *47D1602000C6_4A952BA3006D_impl*
end;//TMainForm.Create

procedure TMainForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4A952BA3006D_var*
//#UC END# *47EA4E9002C6_4A952BA3006D_var*
begin
//#UC START# *47EA4E9002C6_4A952BA3006D_impl*
 inherited;
 UpdateMainCaptionPrefix;
 FillOldBaseWarning;
//#UC END# *47EA4E9002C6_4A952BA3006D_impl*
end;//TMainForm.FinishDataUpdate

procedure TMainForm.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_4A952BA3006D_var*
//#UC END# *47EA8B9601FE_4A952BA3006D_var*
begin
//#UC START# *47EA8B9601FE_4A952BA3006D_impl*
 inherited;
 TasksPanel.Refresh;
  // - перечитаем операции панели задач;
 InitForm;
//#UC END# *47EA8B9601FE_4A952BA3006D_impl*
end;//TMainForm.SettingsReplaceFinish

procedure TMainForm.UserSettingsChanged;
 {* Изменились настройки пользователя }
//#UC START# *4958BE910345_4A952BA3006D_var*
//#UC END# *4958BE910345_4A952BA3006D_var*
begin
//#UC START# *4958BE910345_4A952BA3006D_impl*
 inherited;
 LoadSettings;
//#UC END# *4958BE910345_4A952BA3006D_impl*
end;//TMainForm.UserSettingsChanged

procedure TMainForm.StartSettingsEdit;
//#UC START# *4958F46C003B_4A952BA3006D_var*
//#UC END# *4958F46C003B_4A952BA3006D_var*
begin
//#UC START# *4958F46C003B_4A952BA3006D_impl*
 inherited;
 DoSaveInSettings;
//#UC END# *4958F46C003B_4A952BA3006D_impl*
end;//TMainForm.StartSettingsEdit

{$If NOT Defined(NoVCM)}
procedure TMainForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4A952BA3006D_var*
//#UC END# *49803F5503AA_4A952BA3006D_var*
begin
//#UC START# *49803F5503AA_4A952BA3006D_impl*
 Constraints.MinHeight := 600;
 Constraints.MinWidth := 800;
 inherited;

 if (not aFromHistory) then
  TnsBaseSearchService.Instance.RegisterBaseSearcherProvider(Self, Self);

 TnsNotificationManager.AddListener(Self);
 Tl3ListenersManager.AddMouseWheelListener(Self);
 if (ConsultationManager <> nil) then
  ConsultationManager.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self));
 // Грязнейший хак для К-132222088.
 // После успешных разборок с тормозами записи (загрузки) журнала работы
 // этот вызов папок надо убрать !!
 //UserFoldersTree.AsyncTree;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=271753603
 nsWarnImages;
 with Dispatcher do
 begin
  if (FormDispatcher.MainFormsCount = 1) then
  begin
   InitialLoadStyleTableFromSettings;
   LogSystemInfo;
  end;//if (FormDispatcher.MainFormsCount = 1) then
  FormDispatcher.Lock;
  try
   // Убираем вспомогательные элементы:
   ChildZonePanel.Hide;
   InitForm;
   if (Dispatcher.FormDispatcher.MainFormsCount = 1) and
       (not IntegrationInProcess) then
    LoadStartState(vcmMakeParams(nil, Self));
  finally
   FormDispatcher.UnLock;
  end;//try..finally
 end;//with Dispatcher
 if (Dispatcher.FormDispatcher.MainFormsCount = 1) then
  defDataAdapter.ControlMgr.UpdateStatus(False);
 FillOldBaseWarning;
 // Появилась новая форма, перегрузим список открытых окон
 TnsWindowsList.Instance.Reload;
 f_InternetMap := nsStringMapManager.Map[smap_InternetCaptions];

 UpdateUnreadConsultations;

 // Сообщим пользователю если были установлены настройки по умолчанию:
 dmStdRes.NeedShowSettingsDialog := CheckInstallDefaultSettings;

 CheckFirstLoginActivity;

 TvcmTabbedContainerFormDispatcher.Instance.Subscribe(Self);

 if (ConsultationManager <> nil) then
  CheckConsultationManagerStatus;
//#UC END# *49803F5503AA_4A952BA3006D_impl*
end;//TMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TMainForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
//#UC START# *49806ED503D5_4A952BA3006D_var*
var
 l_InnerState: IvcmBase;
 l_BaseSearcher: InsBaseSearcher;
//#UC END# *49806ED503D5_4A952BA3006D_var*
begin
//#UC START# *49806ED503D5_4A952BA3006D_impl*
 Result := inherited DoSaveState(l_InnerState, aStateType, aForClone);
 l_BaseSearcher := TnsBaseSearchService.Instance.GetBaseSearcher(As_IvcmEntityForm);
 Assert(l_BaseSearcher <> nil);
 theState := TMainFormState.Make(l_BaseSearcher.MakeState, l_InnerState);
//#UC END# *49806ED503D5_4A952BA3006D_impl*
end;//TMainForm.DoSaveState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TMainForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_4A952BA3006D_var*
var
 l_MainFormState: IMainFormState;
 l_InnerState: IvcmBase;
 l_BaseSearcher: InsBaseSearcher;
//#UC END# *49807428008C_4A952BA3006D_var*
begin
//#UC START# *49807428008C_4A952BA3006D_impl*
 if Supports(aState, IMainFormState, l_MainFormState) then
 begin
  l_BaseSearcher := TnsBaseSearchService.Instance.GetBaseSearcher(As_IvcmEntityForm);
  Assert(l_BaseSearcher <> nil);
  l_BaseSearcher.AssignState(l_MainFormState.BaseSearcherState);
  l_InnerState := l_MainFormState.InnerState;
 end
 else
  l_InnerState := aState;
 Result := inherited DoLoadState(l_InnerState, aStateType);
//#UC END# *49807428008C_4A952BA3006D_impl*
end;//TMainForm.DoLoadState
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainForm.ClearFields;
begin
 f_BaseSearcher := nil;
 inherited;
end;//TMainForm.ClearFields

{$If NOT Defined(NoVCM)}
procedure TMainForm.ReleaseResources;
//#UC START# *538C374A00B7_4A952BA3006D_var*
//#UC END# *538C374A00B7_4A952BA3006D_var*
begin
//#UC START# *538C374A00B7_4A952BA3006D_impl*
 NotifyBaseSearcherFormClosing;
 inherited;
//#UC END# *538C374A00B7_4A952BA3006D_impl*
end;//TMainForm.ReleaseResources
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainForm.DoInitFromPrevContainer(const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *54327E120331_4A952BA3006D_var*
var
 l_StateProvider: InsBaseSearchInitialStateProvider;
 l_State: InsBaseSearcherInitialState;
//#UC END# *54327E120331_4A952BA3006D_var*
begin
//#UC START# *54327E120331_4A952BA3006D_impl*
 inherited;
 if Supports(aContainer, InsBaseSearchInitialStateProvider, l_StateProvider) then
 try
  if aForClone then
   l_State := l_StateProvider.StateForClone
  else
   l_State := l_StateProvider.InitialState;
  try
   BaseSearcher.AssignState(l_State);
  finally
   l_State := nil;
  end;
 finally
  l_StateProvider := nil;
 end;
//#UC END# *54327E120331_4A952BA3006D_impl*
end;//TMainForm.DoInitFromPrevContainer
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Common, nil);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, Result_Cancel_GetState);
  PublishOp(en_Common, op_MemUsage, Common_MemUsage_Execute, nil, nil);
 end;//with Entities.Entities
end;//TMainForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
//#UC START# *4F882E1B0358*
 g_IntegrationMessage := RegisterWindowMessage(c_IntegrationMessageName);
 g_LastMainWindowMessage := RegisterWindowMessage(c_LastMainWindowMessageName);
//#UC END# *4F882E1B0358*
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainForm);
 {* Регистрация Main }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
