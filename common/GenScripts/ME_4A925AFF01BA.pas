unit PrimNemesisRes;
 {* Приложение Nemesis }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimNemesisRes.pas"
// Стереотип: "VCMApplication"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ShellAndMonitoringsRes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsQueryInterfaces
 , SearchUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
 , F1_Without_Usecases_System_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUnderControlNotificationManager
 , l3Interfaces
 , MainWindowInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsInterfaces
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerForm
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , Windows
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , L10nInterfaces
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 , nsIntegrationSupport
 , PrimBaseSearchInterfaces
 , BaseSearchInterfaces
 , nsNotificationManager
 , l3TabbedContainersDispatcher
 , Messages
 , Classes
;

const
 {* Локализуемые строки Reminders' Hints }
 str_ControlledChangingWarningHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ControlledChangingWarningHint'; rValue : 'Внимание! Документы на контроле изменились');
  {* 'Внимание! Документы на контроле изменились' }
 str_OldBaseWarningHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldBaseWarningHint'; rValue : 'Внимание! Информационный банк устарел');
  {* 'Внимание! Информационный банк устарел' }
 str_TrialModeWarningHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TrialModeWarningHint'; rValue : 'Вы работаете с ознакомительной версией системы ГАРАНТ');
  {* 'Вы работаете с ознакомительной версией системы ГАРАНТ' }
 str_remUnreadConsultationsHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remUnreadConsultationsHint'; rValue : 'Получены ответы или уведомления от службы Правовой поддержки онлайн');
  {* 'Получены ответы или уведомления от службы Правовой поддержки онлайн' }
 str_remOnlineDeadHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remOnlineDeadHint'; rValue : 'С момента последнего обновления Вашего информационного банка прошло более 6 месяцев. Онлайн-проверка актуальности документов будет отключена.');
  {* 'С момента последнего обновления Вашего информационного банка прошло более 6 месяцев. Онлайн-проверка актуальности документов будет отключена.' }

const
 fm_nsMainWindow: TvcmFormDescriptor = (rFormID : (rName : 'nsMainWindow'; rID : 0); rFactory : nil);
  {* Идентификатор формы TnsMainWindow }

type
 _nsUserSettingsListener_Parent_ = TShellAndMonitoringsMainForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}
 _nsUserSettingsEditListener_Parent_ = _nsUserSettingsListener_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsEditListener.imp.pas}
 _StatusBarItems_Parent_ = _nsUserSettingsEditListener_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _vcmContainedForm_Parent_ = _StatusBarItems_;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmContainedForm.imp.pas}
 TNemesisMainForm = class(_vcmContainedForm_, InsUnderControlNotificationListener)
  {* Главная форма }
  private
   f_CarrierLostHint: Il3CString;
   f_CantReceiveAnswer: Boolean;
   f_InternetDisconnected: Boolean;
   f_ConnectionWasLost: Boolean;
   f_sdsMainWindow: IsdsMainWindow;
  protected
   f_IsControlledObjectsChanging: Boolean;
  private
   procedure UpdateCarrierHint;
   function OpenNewMainForm(aOpenKind: TvcmMainFormOpenKind;
    aOpenLast: Boolean): TvcmMainForm;
  protected
   procedure CheckConsultationConnection;
   procedure ChangeDefaultFontSize(aInc: Boolean = True);
   procedure LogSystemInfo;
   function CanChangeDefaultFontSize(aInc: Boolean = True): Boolean;
   procedure CheckInternetConnection;
   procedure ResetControlledObjectsChanging;
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
    {* Заполняет список операций. Для перекрытия в потомках }
   procedure UnderControlNotificationChanged;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedsStatusBarItems: Boolean; override;
    {* Определяет, что операции в статусной строке таки надо публиковать }
   {$If NOT Defined(NoVCM)}
   function InsertForm(const aForm: IvcmEntityForm): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoBack(const aParams: IvcmExecuteParamsPrim); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoForward(const aParams: IvcmExecuteParamsPrim); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function NeedUseTabs: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   function NeedAskMayExit: Boolean; override;
   function OpenNewMainWindow: TvcmMainForm; override;
   {$If NOT Defined(NoVCM)}
   function LimitOpenedWindowsCount: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoCascadeWindows; override;
   procedure DoTileWindowsHorizontal; override;
   procedure DoTileWindowsVertical; override;
   function GetCanCloseAllWindows: Boolean; override;
   procedure DoCloseAllWindows; override;
   function DoGetNextMainForm: IvcmEntityForm; override;
   {$If NOT Defined(NoVCM)}
   function DoGetCaptionForSaving: AnsiString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   procedure DoOnContainerIsClosing; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   function GetCurrentActiveWindow: IvcmEntityForm; override;
   function GetCurrentOpenedWindowsCount: Integer; override;
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoOpenNew(aOpenKind: TvcmMainFormOpenKind;
    aOpenLast: Boolean): IvcmContainedForm; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   function Load: Boolean; override;
    {* Коллеги, кто может описать этот метод? }
   procedure CantReceiveLegalServiceAnswer; override;
    {* Статус связи с ППО }
 end;//TNemesisMainForm

 InsIntegrationProcessor = interface
  ['{C3E4F420-4422-4607-9F30-25BB208269A6}']
  function ProcessCommand(aCommand: Integer;
   InNewWindow: Boolean;
   const aContainer: IvcmContainer): Boolean;
  function ProcessLink(aLink: PnsLinkDataArray): Boolean;
  function CheckKey(aKey: PnsLinkDataArray): Boolean;
  procedure CheckInconic;
 end;//InsIntegrationProcessor

 TMainOptionsForm = class(TNemesisMainForm)
  private
   f_RemindersLine: TnscRemindersLine;
    {* Поле для свойства RemindersLine }
   f_ControlledChangingWarning: TnscReminder;
    {* Поле для свойства ControlledChangingWarning }
   f_remUnreadConsultations: TnscReminder;
    {* Поле для свойства remUnreadConsultations }
   f_IsRemUnreadConsultationsVisible: Boolean;
    {* Поле для свойства IsRemUnreadConsultationsVisible }
  protected
   f_InternetMap: InsStringValueMap;
   f_WindowInitialized: Boolean;
  protected
   procedure LoadStartState(const aParams: IvcmMakeParams);
   procedure OpenUnderControl;
   procedure ShowWhatsNewHelpPage;
   function ConvertOpenOnStartSetting: Integer;
   procedure InitClone(aForm: TvcmMainForm); override;
   procedure vcmMainFormAfterInsertForm(const aForm: IvcmEntityForm); override;
   procedure DropChangeStatusToOpened; override;
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ReleaseResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   procedure DoInitContainedForm(aForm: TvcmMainForm); override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure IncreaseFont; override;
   procedure DecreaseFont; override;
   procedure HotInformation; override;
   procedure HelpShortCuts; override;
   procedure HelpNewFeatures; override;
   procedure ContactInformation; override;
   procedure ReplyBook; override;
   procedure GarantInternet; override;
   procedure About; override;
   procedure BookmarkList; override;
   procedure BuildControlledList; override;
    {* Построить список изменившихся документов на контроле }
   procedure OpenUnderControlTree; override;
    {* Открыть вкладку "Документы на контроле" }
   procedure HideReminder; override;
    {* Скрыть предупреждающий знак }
   {$If NOT Defined(NoVCM)}
   procedure Back; override;
    {* Назад }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Forward; override;
    {* Вперёд }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OpenNewWindowByUser; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure GetWindowList; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CascadeWindows; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure TileWindowsHorizontal; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure TileWindowsVertical; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CloseAllWindows; override;
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property IsRemUnreadConsultationsVisible: Boolean
    read f_IsRemUnreadConsultationsVisible
    write f_IsRemUnreadConsultationsVisible;
  public
   property RemindersLine: TnscRemindersLine
    read f_RemindersLine;
 end;//TMainOptionsForm

 TMainForm = class(TMainOptionsForm, Il3ItemNotifyRecipient, InsBaseSearchResultProcessor, InsBaseSearchDataReadyChecker, InsBaseSearchWindowOpener, InsBaseSearchQueryDataProcessor, Il3MouseWheelListener, InsIntegrationProcessor, InsNotificationListener, InsBaseSearchInitialStateProvider, Il3TabbedContainersListener, InsBaseSearcherProvider)
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
   procedure WMActivate(var Message: TWMActivate);
   procedure WMActivateApp(var Message: TWMActivateApp);
   procedure WMCopyData(var aMessage: TWMCopyData);
   procedure WMDisplayChange(var aMessage: TWMDisplayChange);
   procedure WMWindowPosChanging(var aMessage: TWMWindowPosChanging);
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
   procedure OpenWindow(OpenKind: TnsBaseSearchOpenKind);
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
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ReleaseResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInitFromPrevContainer(const aContainer: IvcmContainer;
    aForClone: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure MemUsage; override;
   constructor Create(AOwner: TComponent); override;
 end;//TMainForm

 // RemindersZone

 TMainWithRemindersForm = class(TMainForm{$If Defined(Nemesis) AND NOT Defined(NoVCM)}
 , IvcmFlashingWindow
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(NoVCM)
 )
  private
   f_Flashing: Boolean;
   f_remOnlineDead: TnscReminder;
    {* Поле для свойства remOnlineDead }
   f_remNewChatMessages: TnscReminder;
    {* Поле для свойства remNewChatMessages }
   f_TrialModeWarning: TnscReminder;
    {* Поле для свойства TrialModeWarning }
   f_OldBaseWarning: TnscReminder;
    {* Поле для свойства OldBaseWarning }
  protected
   f_remOnlineDeadHidden: Boolean;
   f_OldBaseWarningString: Il3CString;
  private
   procedure ControlledChangingWarningBecomeVisible(Sender: TObject);
   procedure ControlledChangingWarningAfterBaloonShowed(Sender: TObject);
   procedure ControlledChangingWarningAfterBaloonHidden(Sender: TObject);
   procedure remOnlineDeadAfterBaloonHidden(Sender: TObject);
  protected
   {$If Defined(Nemesis) AND NOT Defined(NoVCM)}
   procedure StartFlashing;
   {$IfEnd} // Defined(Nemesis) AND NOT Defined(NoVCM)
   {$If Defined(Nemesis) AND NOT Defined(NoVCM)}
   procedure StopFlashing;
   {$IfEnd} // Defined(Nemesis) AND NOT Defined(NoVCM)
   procedure FillOldBaseWarning; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure EntitiesInited; override;
    {* Вызывается после того как все операции зарегистрированы }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure BecomeVisible; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure BecomeInvisible; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure RemMWControlledChangingWarning; override;
   procedure RemMWOldBaseWarning; override;
   procedure RemMWTrialModeWarning; override;
   procedure RemNewChatMessages; override;
   procedure RemOnlineDead; override;
   procedure remUnreadConsultations; override;
 end;//TMainWithRemindersForm

 MainWindowFormDef = interface
  {* Идентификатор формы MainWindow }
  ['{A88F9772-00AF-401E-BACE-E6A02B415485}']
 end;//MainWindowFormDef

 TnsMainWindow = {final} class(TMainWithRemindersForm, MainWindowFormDef)
  {* Гарант }
 end;//TnsMainWindow

 TPrimNemesisRes = {abstract} class(TShellAndMonitoringsRes)
  {* Приложение Nemesis }
  private
   class procedure BeforeCorrectDate(const aDate: AnsiString);
  protected
   class function RunOtherProcesses: Boolean; override;
   class function DoGlobalInit(aLogo: TCustomForm;
    var theSplash: IUnknown): Boolean; override;
   class procedure DoRun(var theSplash: IUnknown); override;
  public
   class procedure OpenQuery(aQueryType: TlgQueryType;
    const aQuery: IQuery;
    const aContainer: IvcmContainer); override;
 end;//TPrimNemesisRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsStartupSupport
 , GblAdapter
 , l3Base
 , StartUnit
 , SysUtils
 , MedicMainMenuRes
 , MainMenuNewRes
 , nsHooks
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , DebugStr
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , TabbedContainerRes
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineTabbedContainerNotificationProxy
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeInterfaces
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 , vtDateEditRes
 , DataAdapter
 , resWarnImages
 , BaseTypesUnit
 , nsNodes
 , BaseTreeSupportUnit
 , nsForwardEvent
 , nsBackEvent
 , Search_ScalingSupport_Controls
 , sdsMainWindow
 , nsConst
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , afwFacade
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDefsList
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDef
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsChangeFontSizeEvent
 , evStyleInterface
 , nsSettingsUtils
 , evStyleTableTools
 , nsPrimaryMonitorResolutionEvent
 , nsDPIEvent
 , nsFontSizeEvent
 {$If NOT Defined(NoVCM)}
 , OfficeLikeAppInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , nsWindowsList
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 , nsExternalObjectPrim
 , nsFolderFilterInfo
 , nsBaseMainMenuTree
 , nsOpenUtils
 , nsTypes
 , FoldersDomainInterfaces
 , DynamicTreeUnit
 , Common_FormDefinitions_Controls
 , Common_Rubricator_Controls
 , nsUtils
 , DocumentUnit
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , IOUnit
 , bsTypes
 , nsManagers
 , nsBaseSearcher
 , nsQueryUtils
 , nsContextHistory
 , MemoryUsage_Form
 , l3AsincMessageWindow
 , l3SysUtils
 , IntegrationProjectUnit
 {$If NOT Defined(NoVCM)}
 , vcmMenuManager
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ListenersManager
 , HelpIntfs
 , vtVerInf
 , SettingsUnit
 , nsConfiguration
 , nsValueMaps
 , nsValueMapsIDs
 , ContextHistoryInterfaces
 , nsBaseSearchService
 , l3Chars
 , BaloonWarningUserTypes_ControlledChangingWarning_UserType
 , BaloonWarningUserTypes_OldBaseWarning_UserType
 , BaloonWarningUserTypes_TrialModeWarning_UserType
 , BaloonWarningUserTypes_remUnreadConsultations_UserType
 , BaloonWarningUserTypes_remOnlineDead_UserType
 {$If NOT Defined(NoScripts)}
 , MainWindowKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

var g_InternerMapStrings: IvcmStrings = nil;
var g_IntegrationMessage: Cardinal = 0;
var g_LastMainWindowMessage: Cardinal = 0;

const
 {* Локализуемые строки Local }
 str_CarrierLost: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CarrierLost'; rValue : 'Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
  {* 'Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
 str_InternetAbsent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InternetAbsent'; rValue : 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Возможности онлайн-проверки актуальности документов будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
  {* 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Возможности онлайн-проверки актуальности документов будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
 str_TotalFailure: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TotalFailure'; rValue : 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Онлайн-проверка актуальности документов и работа со службой Правовой поддержки онлайн будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
  {* 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Онлайн-проверка актуальности документов и работа со службой Правовой поддержки онлайн будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
 str_CaptionForSaving: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CaptionForSaving'; rValue : 'ГАРАНТ аэро');
  {* 'ГАРАНТ аэро' }
 {* Локализуемые строки utMainWindowLocalConstants }
 str_utMainWindowCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowCaption'; rValue : 'Главное окно');
  {* Заголовок пользовательского типа "Главное окно" }
 str_utMainWindowSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowSettingsCaption'; rValue : 'Главная панель инструментов');
  {* Заголовок пользовательского типа "Главное окно" для настройки панелей инструментов }

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsEditListener.imp.pas}

type _Instance_R_ = TNemesisMainForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmContainedForm.imp.pas}

procedure TNemesisMainForm.CheckConsultationConnection;
//#UC START# *4A8E7A6E0379_4958D2EA00CC_var*
//#UC END# *4A8E7A6E0379_4958D2EA00CC_var*
begin
//#UC START# *4A8E7A6E0379_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E7A6E0379_4958D2EA00CC_impl*
end;//TNemesisMainForm.CheckConsultationConnection

procedure TNemesisMainForm.ChangeDefaultFontSize(aInc: Boolean = True);
//#UC START# *4B0BAF65023E_4958D2EA00CC_var*
//#UC END# *4B0BAF65023E_4958D2EA00CC_var*
begin
//#UC START# *4B0BAF65023E_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B0BAF65023E_4958D2EA00CC_impl*
end;//TNemesisMainForm.ChangeDefaultFontSize

procedure TNemesisMainForm.LogSystemInfo;
//#UC START# *4B0BAF8E03D0_4958D2EA00CC_var*
//#UC END# *4B0BAF8E03D0_4958D2EA00CC_var*
begin
//#UC START# *4B0BAF8E03D0_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B0BAF8E03D0_4958D2EA00CC_impl*
end;//TNemesisMainForm.LogSystemInfo

function TNemesisMainForm.CanChangeDefaultFontSize(aInc: Boolean = True): Boolean;
//#UC START# *4BB3637402F5_4958D2EA00CC_var*
//#UC END# *4BB3637402F5_4958D2EA00CC_var*
begin
//#UC START# *4BB3637402F5_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BB3637402F5_4958D2EA00CC_impl*
end;//TNemesisMainForm.CanChangeDefaultFontSize

procedure TNemesisMainForm.CheckInternetConnection;
//#UC START# *4BCDAB6F00D2_4958D2EA00CC_var*
//#UC END# *4BCDAB6F00D2_4958D2EA00CC_var*
begin
//#UC START# *4BCDAB6F00D2_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BCDAB6F00D2_4958D2EA00CC_impl*
end;//TNemesisMainForm.CheckInternetConnection

procedure TNemesisMainForm.UpdateCarrierHint;
//#UC START# *4BCDABAC037C_4958D2EA00CC_var*
//#UC END# *4BCDABAC037C_4958D2EA00CC_var*
begin
//#UC START# *4BCDABAC037C_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BCDABAC037C_4958D2EA00CC_impl*
end;//TNemesisMainForm.UpdateCarrierHint

function TNemesisMainForm.OpenNewMainForm(aOpenKind: TvcmMainFormOpenKind;
 aOpenLast: Boolean): TvcmMainForm;
//#UC START# *5566B0FA013A_4958D2EA00CC_var*
//#UC END# *5566B0FA013A_4958D2EA00CC_var*
begin
//#UC START# *5566B0FA013A_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5566B0FA013A_4958D2EA00CC_impl*
end;//TNemesisMainForm.OpenNewMainForm

procedure TNemesisMainForm.ResetControlledObjectsChanging;
//#UC START# *55D450020396_4958D2EA00CC_var*
//#UC END# *55D450020396_4958D2EA00CC_var*
begin
//#UC START# *55D450020396_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *55D450020396_4958D2EA00CC_impl*
end;//TNemesisMainForm.ResetControlledObjectsChanging

function TNemesisMainForm.Load: Boolean;
 {* Коллеги, кто может описать этот метод? }
//#UC START# *49895A2102E8_4958D2EA00CC_var*
//#UC END# *49895A2102E8_4958D2EA00CC_var*
begin
//#UC START# *49895A2102E8_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *49895A2102E8_4958D2EA00CC_impl*
end;//TNemesisMainForm.Load

procedure TNemesisMainForm.FillList(const aList: InscStatusBarItemDefsList);
 {* Заполняет список операций. Для перекрытия в потомках }
//#UC START# *4A8E5E4702C6_4958D2EA00CC_var*
//#UC END# *4A8E5E4702C6_4958D2EA00CC_var*
begin
//#UC START# *4A8E5E4702C6_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E5E4702C6_4958D2EA00CC_impl*
end;//TNemesisMainForm.FillList

procedure TNemesisMainForm.CantReceiveLegalServiceAnswer;
 {* Статус связи с ППО }
//#UC START# *4C7D38560348_4958D2EA00CC_var*
//#UC END# *4C7D38560348_4958D2EA00CC_var*
begin
//#UC START# *4C7D38560348_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D38560348_4958D2EA00CC_impl*
end;//TNemesisMainForm.CantReceiveLegalServiceAnswer

procedure TNemesisMainForm.UnderControlNotificationChanged;
//#UC START# *55D42A4A0031_4958D2EA00CC_var*
//#UC END# *55D42A4A0031_4958D2EA00CC_var*
begin
//#UC START# *55D42A4A0031_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *55D42A4A0031_4958D2EA00CC_impl*
end;//TNemesisMainForm.UnderControlNotificationChanged

procedure TNemesisMainForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4958D2EA00CC_var*
//#UC END# *479731C50290_4958D2EA00CC_var*
begin
//#UC START# *479731C50290_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4958D2EA00CC_impl*
end;//TNemesisMainForm.Cleanup

{$If NOT Defined(NoVCM)}
procedure TNemesisMainForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4958D2EA00CC_var*
//#UC END# *49803F5503AA_4958D2EA00CC_var*
begin
//#UC START# *49803F5503AA_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *49803F5503AA_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

function TNemesisMainForm.NeedsStatusBarItems: Boolean;
 {* Определяет, что операции в статусной строке таки надо публиковать }
//#UC START# *4A8E5CEC021F_4958D2EA00CC_var*
//#UC END# *4A8E5CEC021F_4958D2EA00CC_var*
begin
//#UC START# *4A8E5CEC021F_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E5CEC021F_4958D2EA00CC_impl*
end;//TNemesisMainForm.NeedsStatusBarItems

{$If NOT Defined(NoVCM)}
function TNemesisMainForm.InsertForm(const aForm: IvcmEntityForm): Boolean;
//#UC START# *4AD44CA20001_4958D2EA00CC_var*
//#UC END# *4AD44CA20001_4958D2EA00CC_var*
begin
//#UC START# *4AD44CA20001_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD44CA20001_4958D2EA00CC_impl*
end;//TNemesisMainForm.InsertForm
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TNemesisMainForm.DoBack(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDE6B01A6_4958D2EA00CC_var*
//#UC END# *4C8DDE6B01A6_4958D2EA00CC_var*
begin
//#UC START# *4C8DDE6B01A6_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8DDE6B01A6_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoBack
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TNemesisMainForm.DoForward(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDEA5007E_4958D2EA00CC_var*
//#UC END# *4C8DDEA5007E_4958D2EA00CC_var*
begin
//#UC START# *4C8DDEA5007E_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8DDEA5007E_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoForward
{$IfEnd} // NOT Defined(NoVCM)

procedure TNemesisMainForm.ClearFields;
begin
 f_CarrierLostHint := nil;
 f_sdsMainWindow := nil;
 inherited;
end;//TNemesisMainForm.ClearFields

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TNemesisMainForm.NeedUseTabs: Boolean;
//#UC START# *537DB22C0249_4958D2EA00CC_var*
//#UC END# *537DB22C0249_4958D2EA00CC_var*
begin
//#UC START# *537DB22C0249_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *537DB22C0249_4958D2EA00CC_impl*
end;//TNemesisMainForm.NeedUseTabs
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

function TNemesisMainForm.NeedAskMayExit: Boolean;
//#UC START# *53A013DF03E1_4958D2EA00CC_var*
//#UC END# *53A013DF03E1_4958D2EA00CC_var*
begin
//#UC START# *53A013DF03E1_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53A013DF03E1_4958D2EA00CC_impl*
end;//TNemesisMainForm.NeedAskMayExit

function TNemesisMainForm.OpenNewMainWindow: TvcmMainForm;
//#UC START# *53AD17180374_4958D2EA00CC_var*
//#UC END# *53AD17180374_4958D2EA00CC_var*
begin
//#UC START# *53AD17180374_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AD17180374_4958D2EA00CC_impl*
end;//TNemesisMainForm.OpenNewMainWindow

{$If NOT Defined(NoVCM)}
function TNemesisMainForm.LimitOpenedWindowsCount: Boolean;
//#UC START# *53AD2E740057_4958D2EA00CC_var*
//#UC END# *53AD2E740057_4958D2EA00CC_var*
begin
//#UC START# *53AD2E740057_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AD2E740057_4958D2EA00CC_impl*
end;//TNemesisMainForm.LimitOpenedWindowsCount
{$IfEnd} // NOT Defined(NoVCM)

procedure TNemesisMainForm.DoCascadeWindows;
//#UC START# *53D0E77003DD_4958D2EA00CC_var*
//#UC END# *53D0E77003DD_4958D2EA00CC_var*
begin
//#UC START# *53D0E77003DD_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53D0E77003DD_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoCascadeWindows

procedure TNemesisMainForm.DoTileWindowsHorizontal;
//#UC START# *53D0ECFB035D_4958D2EA00CC_var*
//#UC END# *53D0ECFB035D_4958D2EA00CC_var*
begin
//#UC START# *53D0ECFB035D_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53D0ECFB035D_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoTileWindowsHorizontal

procedure TNemesisMainForm.DoTileWindowsVertical;
//#UC START# *53D0ED410163_4958D2EA00CC_var*
//#UC END# *53D0ED410163_4958D2EA00CC_var*
begin
//#UC START# *53D0ED410163_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53D0ED410163_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoTileWindowsVertical

function TNemesisMainForm.GetCanCloseAllWindows: Boolean;
//#UC START# *53D20CE2034C_4958D2EA00CC_var*
//#UC END# *53D20CE2034C_4958D2EA00CC_var*
begin
//#UC START# *53D20CE2034C_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53D20CE2034C_4958D2EA00CC_impl*
end;//TNemesisMainForm.GetCanCloseAllWindows

procedure TNemesisMainForm.DoCloseAllWindows;
//#UC START# *53D20D0402AC_4958D2EA00CC_var*
//#UC END# *53D20D0402AC_4958D2EA00CC_var*
begin
//#UC START# *53D20D0402AC_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53D20D0402AC_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoCloseAllWindows

function TNemesisMainForm.DoGetNextMainForm: IvcmEntityForm;
//#UC START# *53D21DEA02A4_4958D2EA00CC_var*
//#UC END# *53D21DEA02A4_4958D2EA00CC_var*
begin
//#UC START# *53D21DEA02A4_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53D21DEA02A4_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoGetNextMainForm

{$If NOT Defined(NoVCM)}
function TNemesisMainForm.DoGetCaptionForSaving: AnsiString;
//#UC START# *540953180034_4958D2EA00CC_var*
//#UC END# *540953180034_4958D2EA00CC_var*
begin
//#UC START# *540953180034_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *540953180034_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoGetCaptionForSaving
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
procedure TNemesisMainForm.DoOnContainerIsClosing;
//#UC START# *54363DD90183_4958D2EA00CC_var*
//#UC END# *54363DD90183_4958D2EA00CC_var*
begin
//#UC START# *54363DD90183_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *54363DD90183_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoOnContainerIsClosing
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

function TNemesisMainForm.GetCurrentActiveWindow: IvcmEntityForm;
//#UC START# *54607EC40295_4958D2EA00CC_var*
//#UC END# *54607EC40295_4958D2EA00CC_var*
begin
//#UC START# *54607EC40295_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *54607EC40295_4958D2EA00CC_impl*
end;//TNemesisMainForm.GetCurrentActiveWindow

function TNemesisMainForm.GetCurrentOpenedWindowsCount: Integer;
//#UC START# *54607EEF00BB_4958D2EA00CC_var*
//#UC END# *54607EEF00BB_4958D2EA00CC_var*
begin
//#UC START# *54607EEF00BB_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *54607EEF00BB_4958D2EA00CC_impl*
end;//TNemesisMainForm.GetCurrentOpenedWindowsCount

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TNemesisMainForm.DoOpenNew(aOpenKind: TvcmMainFormOpenKind;
 aOpenLast: Boolean): IvcmContainedForm;
//#UC START# *5566C7BD037F_4958D2EA00CC_var*
//#UC END# *5566C7BD037F_4958D2EA00CC_var*
begin
//#UC START# *5566C7BD037F_4958D2EA00CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5566C7BD037F_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoOpenNew
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

procedure TMainOptionsForm.LoadStartState(const aParams: IvcmMakeParams);
//#UC START# *4C8A33C301CA_4C8A29700261_var*
//#UC END# *4C8A33C301CA_4C8A29700261_var*
begin
//#UC START# *4C8A33C301CA_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A33C301CA_4C8A29700261_impl*
end;//TMainOptionsForm.LoadStartState

procedure TMainOptionsForm.OpenUnderControl;
//#UC START# *4C8A4B95003E_4C8A29700261_var*
//#UC END# *4C8A4B95003E_4C8A29700261_var*
begin
//#UC START# *4C8A4B95003E_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A4B95003E_4C8A29700261_impl*
end;//TMainOptionsForm.OpenUnderControl

procedure TMainOptionsForm.ShowWhatsNewHelpPage;
//#UC START# *4C8A4C9B00F9_4C8A29700261_var*
//#UC END# *4C8A4C9B00F9_4C8A29700261_var*
begin
//#UC START# *4C8A4C9B00F9_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A4C9B00F9_4C8A29700261_impl*
end;//TMainOptionsForm.ShowWhatsNewHelpPage

function TMainOptionsForm.ConvertOpenOnStartSetting: Integer;
//#UC START# *4F86CBED00E7_4C8A29700261_var*
//#UC END# *4F86CBED00E7_4C8A29700261_var*
begin
//#UC START# *4F86CBED00E7_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86CBED00E7_4C8A29700261_impl*
end;//TMainOptionsForm.ConvertOpenOnStartSetting

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C8A29700261_var*
//#UC END# *4C762C910358_4C8A29700261_var*
begin
//#UC START# *4C762C910358_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C8A29700261_impl*
end;//TMainOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainOptionsForm.IncreaseFont;
//#UC START# *4C8A2A5C03E4_4C8A29700261_var*
//#UC END# *4C8A2A5C03E4_4C8A29700261_var*
begin
//#UC START# *4C8A2A5C03E4_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A2A5C03E4_4C8A29700261_impl*
end;//TMainOptionsForm.IncreaseFont

procedure TMainOptionsForm.DecreaseFont;
//#UC START# *4C8A2A72034C_4C8A29700261_var*
//#UC END# *4C8A2A72034C_4C8A29700261_var*
begin
//#UC START# *4C8A2A72034C_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A2A72034C_4C8A29700261_impl*
end;//TMainOptionsForm.DecreaseFont

procedure TMainOptionsForm.HotInformation;
//#UC START# *4C8A43B3015E_4C8A29700261_var*
//#UC END# *4C8A43B3015E_4C8A29700261_var*
begin
//#UC START# *4C8A43B3015E_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A43B3015E_4C8A29700261_impl*
end;//TMainOptionsForm.HotInformation

procedure TMainOptionsForm.HelpShortCuts;
//#UC START# *4C8A43C40120_4C8A29700261_var*
//#UC END# *4C8A43C40120_4C8A29700261_var*
begin
//#UC START# *4C8A43C40120_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A43C40120_4C8A29700261_impl*
end;//TMainOptionsForm.HelpShortCuts

procedure TMainOptionsForm.HelpNewFeatures;
//#UC START# *4C8A43E30011_4C8A29700261_var*
//#UC END# *4C8A43E30011_4C8A29700261_var*
begin
//#UC START# *4C8A43E30011_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A43E30011_4C8A29700261_impl*
end;//TMainOptionsForm.HelpNewFeatures

procedure TMainOptionsForm.ContactInformation;
//#UC START# *4C8A43FE01BD_4C8A29700261_var*
//#UC END# *4C8A43FE01BD_4C8A29700261_var*
begin
//#UC START# *4C8A43FE01BD_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A43FE01BD_4C8A29700261_impl*
end;//TMainOptionsForm.ContactInformation

procedure TMainOptionsForm.ReplyBook;
//#UC START# *4C8A440F025D_4C8A29700261_var*
//#UC END# *4C8A440F025D_4C8A29700261_var*
begin
//#UC START# *4C8A440F025D_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A440F025D_4C8A29700261_impl*
end;//TMainOptionsForm.ReplyBook

procedure TMainOptionsForm.GarantInternet;
//#UC START# *4C8A4428006F_4C8A29700261_var*
//#UC END# *4C8A4428006F_4C8A29700261_var*
begin
//#UC START# *4C8A4428006F_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A4428006F_4C8A29700261_impl*
end;//TMainOptionsForm.GarantInternet

procedure TMainOptionsForm.About;
//#UC START# *4C8A4442036F_4C8A29700261_var*
//#UC END# *4C8A4442036F_4C8A29700261_var*
begin
//#UC START# *4C8A4442036F_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A4442036F_4C8A29700261_impl*
end;//TMainOptionsForm.About

procedure TMainOptionsForm.BookmarkList;
//#UC START# *4C8A44DD0291_4C8A29700261_var*
//#UC END# *4C8A44DD0291_4C8A29700261_var*
begin
//#UC START# *4C8A44DD0291_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A44DD0291_4C8A29700261_impl*
end;//TMainOptionsForm.BookmarkList

procedure TMainOptionsForm.BuildControlledList;
 {* Построить список изменившихся документов на контроле }
//#UC START# *4C8A454E0063_4C8A29700261_var*
//#UC END# *4C8A454E0063_4C8A29700261_var*
begin
//#UC START# *4C8A454E0063_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A454E0063_4C8A29700261_impl*
end;//TMainOptionsForm.BuildControlledList

procedure TMainOptionsForm.OpenUnderControlTree;
 {* Открыть вкладку "Документы на контроле" }
//#UC START# *4C8A456A0188_4C8A29700261_var*
//#UC END# *4C8A456A0188_4C8A29700261_var*
begin
//#UC START# *4C8A456A0188_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A456A0188_4C8A29700261_impl*
end;//TMainOptionsForm.OpenUnderControlTree

procedure TMainOptionsForm.HideReminder;
 {* Скрыть предупреждающий знак }
//#UC START# *4C8A4584039B_4C8A29700261_var*
//#UC END# *4C8A4584039B_4C8A29700261_var*
begin
//#UC START# *4C8A4584039B_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A4584039B_4C8A29700261_impl*
end;//TMainOptionsForm.HideReminder

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.Back;
 {* Назад }
//#UC START# *4ADDDC550118_4C8A29700261_var*
//#UC END# *4ADDDC550118_4C8A29700261_var*
begin
//#UC START# *4ADDDC550118_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDDC550118_4C8A29700261_impl*
end;//TMainOptionsForm.Back
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.Forward;
 {* Вперёд }
//#UC START# *4ADDDC630097_4C8A29700261_var*
//#UC END# *4ADDDC630097_4C8A29700261_var*
begin
//#UC START# *4ADDDC630097_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDDC630097_4C8A29700261_impl*
end;//TMainOptionsForm.Forward
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.OpenNewWindowByUser;
//#UC START# *4C8A30B60087_4C8A29700261_var*
//#UC END# *4C8A30B60087_4C8A29700261_var*
begin
//#UC START# *4C8A30B60087_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A30B60087_4C8A29700261_impl*
end;//TMainOptionsForm.OpenNewWindowByUser
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.GetWindowList;
//#UC START# *4C8A30DB001D_4C8A29700261_var*
//#UC END# *4C8A30DB001D_4C8A29700261_var*
begin
//#UC START# *4C8A30DB001D_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A30DB001D_4C8A29700261_impl*
end;//TMainOptionsForm.GetWindowList
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.CascadeWindows;
//#UC START# *4C8A30F30115_4C8A29700261_var*
//#UC END# *4C8A30F30115_4C8A29700261_var*
begin
//#UC START# *4C8A30F30115_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A30F30115_4C8A29700261_impl*
end;//TMainOptionsForm.CascadeWindows
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.TileWindowsHorizontal;
//#UC START# *4C8A3114001E_4C8A29700261_var*
//#UC END# *4C8A3114001E_4C8A29700261_var*
begin
//#UC START# *4C8A3114001E_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A3114001E_4C8A29700261_impl*
end;//TMainOptionsForm.TileWindowsHorizontal
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.TileWindowsVertical;
//#UC START# *4C8A312F018D_4C8A29700261_var*
//#UC END# *4C8A312F018D_4C8A29700261_var*
begin
//#UC START# *4C8A312F018D_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A312F018D_4C8A29700261_impl*
end;//TMainOptionsForm.TileWindowsVertical
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.CloseAllWindows;
//#UC START# *4C8A31770143_4C8A29700261_var*
//#UC END# *4C8A31770143_4C8A29700261_var*
begin
//#UC START# *4C8A31770143_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A31770143_4C8A29700261_impl*
end;//TMainOptionsForm.CloseAllWindows
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainOptionsForm.InitClone(aForm: TvcmMainForm);
//#UC START# *4F7AE85E01EF_4C8A29700261_var*
//#UC END# *4F7AE85E01EF_4C8A29700261_var*
begin
//#UC START# *4F7AE85E01EF_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7AE85E01EF_4C8A29700261_impl*
end;//TMainOptionsForm.InitClone

procedure TMainOptionsForm.vcmMainFormAfterInsertForm(const aForm: IvcmEntityForm);
//#UC START# *4F7AEC7F03CB_4C8A29700261_var*
//#UC END# *4F7AEC7F03CB_4C8A29700261_var*
begin
//#UC START# *4F7AEC7F03CB_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7AEC7F03CB_4C8A29700261_impl*
end;//TMainOptionsForm.vcmMainFormAfterInsertForm

procedure TMainOptionsForm.DropChangeStatusToOpened;
//#UC START# *4F7AED150304_4C8A29700261_var*
//#UC END# *4F7AED150304_4C8A29700261_var*
begin
//#UC START# *4F7AED150304_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7AED150304_4C8A29700261_impl*
end;//TMainOptionsForm.DropChangeStatusToOpened

procedure TMainOptionsForm.ClearFields;
begin
 f_InternetMap := nil;
 inherited;
end;//TMainOptionsForm.ClearFields

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.ReleaseResources;
//#UC START# *538C374A00B7_4C8A29700261_var*
//#UC END# *538C374A00B7_4C8A29700261_var*
begin
//#UC START# *538C374A00B7_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *538C374A00B7_4C8A29700261_impl*
end;//TMainOptionsForm.ReleaseResources
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
procedure TMainOptionsForm.DoInitContainedForm(aForm: TvcmMainForm);
//#UC START# *546464260137_4C8A29700261_var*
//#UC END# *546464260137_4C8A29700261_var*
begin
//#UC START# *546464260137_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *546464260137_4C8A29700261_impl*
end;//TMainOptionsForm.DoInitContainedForm
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

procedure TMainForm.UpdateUnreadConsultations;
//#UC START# *4F88013F007B_4A952BA3006D_var*
//#UC END# *4F88013F007B_4A952BA3006D_var*
begin
//#UC START# *4F88013F007B_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F88013F007B_4A952BA3006D_impl*
end;//TMainForm.UpdateUnreadConsultations

procedure TMainForm.InitForm;
//#UC START# *4F8813D6026A_4A952BA3006D_var*
//#UC END# *4F8813D6026A_4A952BA3006D_var*
begin
//#UC START# *4F8813D6026A_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8813D6026A_4A952BA3006D_impl*
end;//TMainForm.InitForm

procedure TMainForm.PrepareChildZoneBeforeResize(aNewHeight: Integer);
//#UC START# *4F881735018D_4A952BA3006D_var*
//#UC END# *4F881735018D_4A952BA3006D_var*
begin
//#UC START# *4F881735018D_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F881735018D_4A952BA3006D_impl*
end;//TMainForm.PrepareChildZoneBeforeResize

function TMainForm.BaseSearcher: InsBaseSearcher;
//#UC START# *4F881C2E0175_4A952BA3006D_var*
//#UC END# *4F881C2E0175_4A952BA3006D_var*
begin
//#UC START# *4F881C2E0175_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F881C2E0175_4A952BA3006D_impl*
end;//TMainForm.BaseSearcher

procedure TMainForm.ShowStartupAdvertising;
//#UC START# *4F8BF3940103_4A952BA3006D_var*
//#UC END# *4F8BF3940103_4A952BA3006D_var*
begin
//#UC START# *4F8BF3940103_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8BF3940103_4A952BA3006D_impl*
end;//TMainForm.ShowStartupAdvertising

function TMainForm.CheckStartupAdvertisingEnabled: Boolean;
//#UC START# *4F8BF3B5012A_4A952BA3006D_var*
//#UC END# *4F8BF3B5012A_4A952BA3006D_var*
begin
//#UC START# *4F8BF3B5012A_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8BF3B5012A_4A952BA3006D_impl*
end;//TMainForm.CheckStartupAdvertisingEnabled

procedure TMainForm.CheckFirstLoginActivity;
//#UC START# *4F8BF3CC02A6_4A952BA3006D_var*
//#UC END# *4F8BF3CC02A6_4A952BA3006D_var*
begin
//#UC START# *4F8BF3CC02A6_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8BF3CC02A6_4A952BA3006D_impl*
end;//TMainForm.CheckFirstLoginActivity

function TMainForm.CanFirstLoginActivity: Boolean;
//#UC START# *4F8BF3ED02D0_4A952BA3006D_var*
//#UC END# *4F8BF3ED02D0_4A952BA3006D_var*
begin
//#UC START# *4F8BF3ED02D0_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8BF3ED02D0_4A952BA3006D_impl*
end;//TMainForm.CanFirstLoginActivity

function TMainForm.CheckInstallDefaultSettings: Boolean;
//#UC START# *4F8BF4060008_4A952BA3006D_var*
//#UC END# *4F8BF4060008_4A952BA3006D_var*
begin
//#UC START# *4F8BF4060008_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8BF4060008_4A952BA3006D_impl*
end;//TMainForm.CheckInstallDefaultSettings

function TMainForm.IntegrationInProcess: Boolean;
//#UC START# *4F8BF41E00D8_4A952BA3006D_var*
//#UC END# *4F8BF41E00D8_4A952BA3006D_var*
begin
//#UC START# *4F8BF41E00D8_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8BF41E00D8_4A952BA3006D_impl*
end;//TMainForm.IntegrationInProcess

procedure TMainForm.vcmMainFormShow(Sender: TObject);
//#UC START# *4F8BF5C602C3_4A952BA3006D_var*
//#UC END# *4F8BF5C602C3_4A952BA3006D_var*
begin
//#UC START# *4F8BF5C602C3_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8BF5C602C3_4A952BA3006D_impl*
end;//TMainForm.vcmMainFormShow

procedure TMainForm.CorrectStartupTipsPosition;
//#UC START# *5411B2D10071_4A952BA3006D_var*
//#UC END# *5411B2D10071_4A952BA3006D_var*
begin
//#UC START# *5411B2D10071_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5411B2D10071_4A952BA3006D_impl*
end;//TMainForm.CorrectStartupTipsPosition

procedure TMainForm.CheckConsultationManagerStatus;
//#UC START# *550144FA0072_4A952BA3006D_var*
//#UC END# *550144FA0072_4A952BA3006D_var*
begin
//#UC START# *550144FA0072_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *550144FA0072_4A952BA3006D_impl*
end;//TMainForm.CheckConsultationManagerStatus

procedure TMainForm.NotifyBaseSearcherFormClosing;
//#UC START# *55CC2C9101F8_4A952BA3006D_var*
//#UC END# *55CC2C9101F8_4A952BA3006D_var*
begin
//#UC START# *55CC2C9101F8_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CC2C9101F8_4A952BA3006D_impl*
end;//TMainForm.NotifyBaseSearcherFormClosing

procedure TMainForm.WMActivate(var Message: TWMActivate);
//#UC START# *4F882B3402EB_4A952BA3006D_var*
//#UC END# *4F882B3402EB_4A952BA3006D_var*
begin
//#UC START# *4F882B3402EB_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F882B3402EB_4A952BA3006D_impl*
end;//TMainForm.WMActivate

procedure TMainForm.WMActivateApp(var Message: TWMActivateApp);
//#UC START# *4F882B6101CA_4A952BA3006D_var*
//#UC END# *4F882B6101CA_4A952BA3006D_var*
begin
//#UC START# *4F882B6101CA_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F882B6101CA_4A952BA3006D_impl*
end;//TMainForm.WMActivateApp

procedure TMainForm.WMCopyData(var aMessage: TWMCopyData);
//#UC START# *4F882BA300FD_4A952BA3006D_var*
//#UC END# *4F882BA300FD_4A952BA3006D_var*
begin
//#UC START# *4F882BA300FD_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F882BA300FD_4A952BA3006D_impl*
end;//TMainForm.WMCopyData

procedure TMainForm.WMDisplayChange(var aMessage: TWMDisplayChange);
//#UC START# *4F882BCD02ED_4A952BA3006D_var*
//#UC END# *4F882BCD02ED_4A952BA3006D_var*
begin
//#UC START# *4F882BCD02ED_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F882BCD02ED_4A952BA3006D_impl*
end;//TMainForm.WMDisplayChange

procedure TMainForm.WMWindowPosChanging(var aMessage: TWMWindowPosChanging);
//#UC START# *4F882C0000BA_4A952BA3006D_var*
//#UC END# *4F882C0000BA_4A952BA3006D_var*
begin
//#UC START# *4F882C0000BA_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
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
 !!! Needs to be implemented !!!
//#UC END# *46A4504B03C4_4A952BA3006D_impl*
end;//TMainForm.Notify

procedure TMainForm.CheckLocalDataReady;
//#UC START# *496B4F6D02B5_4A952BA3006D_var*
//#UC END# *496B4F6D02B5_4A952BA3006D_var*
begin
//#UC START# *496B4F6D02B5_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B4F6D02B5_4A952BA3006D_impl*
end;//TMainForm.CheckLocalDataReady

procedure TMainForm.SearchResultEmpty(TryFullList: Boolean);
//#UC START# *496B4FAA02FA_4A952BA3006D_var*
//#UC END# *496B4FAA02FA_4A952BA3006D_var*
begin
//#UC START# *496B4FAA02FA_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B4FAA02FA_4A952BA3006D_impl*
end;//TMainForm.SearchResultEmpty

procedure TMainForm.SearchResultExists;
//#UC START# *496B4FC70065_4A952BA3006D_var*
//#UC END# *496B4FC70065_4A952BA3006D_var*
begin
//#UC START# *496B4FC70065_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B4FC70065_4A952BA3006D_impl*
end;//TMainForm.SearchResultExists

procedure TMainForm.AnotherSearchSuccessed;
//#UC START# *496B4FD20320_4A952BA3006D_var*
//#UC END# *496B4FD20320_4A952BA3006D_var*
begin
//#UC START# *496B4FD20320_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B4FD20320_4A952BA3006D_impl*
end;//TMainForm.AnotherSearchSuccessed

procedure TMainForm.OpenWindow(OpenKind: TnsBaseSearchOpenKind);
//#UC START# *496B52D602EE_4A952BA3006D_var*
//#UC END# *496B52D602EE_4A952BA3006D_var*
begin
//#UC START# *496B52D602EE_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B52D602EE_4A952BA3006D_impl*
end;//TMainForm.OpenWindow

procedure TMainForm.SetDataFromQuery(const aQuery: IUnknown);
//#UC START# *496B534B0098_4A952BA3006D_var*
//#UC END# *496B534B0098_4A952BA3006D_var*
begin
//#UC START# *496B534B0098_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B534B0098_4A952BA3006D_impl*
end;//TMainForm.SetDataFromQuery

procedure TMainForm.RequestFind;
//#UC START# *496B5356008C_4A952BA3006D_var*
//#UC END# *496B5356008C_4A952BA3006D_var*
begin
//#UC START# *496B5356008C_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B5356008C_4A952BA3006D_impl*
end;//TMainForm.RequestFind

procedure TMainForm.RequestCheckFragmentsCount;
//#UC START# *49FFFE5B033A_4A952BA3006D_var*
//#UC END# *49FFFE5B033A_4A952BA3006D_var*
begin
//#UC START# *49FFFE5B033A_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FFFE5B033A_4A952BA3006D_impl*
end;//TMainForm.RequestCheckFragmentsCount

procedure TMainForm.RequestCheckFindBack;
//#UC START# *4A13A97F0211_4A952BA3006D_var*
//#UC END# *4A13A97F0211_4A952BA3006D_var*
begin
//#UC START# *4A13A97F0211_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A13A97F0211_4A952BA3006D_impl*
end;//TMainForm.RequestCheckFindBack

{$If NOT Defined(NoVCM)}
procedure TMainForm.Cancel;
 {* Отмена }
//#UC START# *4AC5D61E0284_4A952BA3006D_var*
//#UC END# *4AC5D61E0284_4A952BA3006D_var*
begin
//#UC START# *4AC5D61E0284_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4A952BA3006D_impl*
end;//TMainForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainForm.AnotherSearchCancelled;
//#UC START# *4C04AFC8015D_4A952BA3006D_var*
//#UC END# *4C04AFC8015D_4A952BA3006D_var*
begin
//#UC START# *4C04AFC8015D_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C04AFC8015D_4A952BA3006D_impl*
end;//TMainForm.AnotherSearchCancelled

procedure TMainForm.MouseWheelListenerNotify(Msg: PMsg;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79D08A02C7_4A952BA3006D_var*
//#UC END# *4F79D08A02C7_4A952BA3006D_var*
begin
//#UC START# *4F79D08A02C7_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F79D08A02C7_4A952BA3006D_impl*
end;//TMainForm.MouseWheelListenerNotify

function TMainForm.ProcessCommand(aCommand: Integer;
 InNewWindow: Boolean;
 const aContainer: IvcmContainer): Boolean;
//#UC START# *4F86BF5F0198_4A952BA3006D_var*
//#UC END# *4F86BF5F0198_4A952BA3006D_var*
begin
//#UC START# *4F86BF5F0198_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86BF5F0198_4A952BA3006D_impl*
end;//TMainForm.ProcessCommand

function TMainForm.ProcessLink(aLink: PnsLinkDataArray): Boolean;
//#UC START# *4F86BF850173_4A952BA3006D_var*
//#UC END# *4F86BF850173_4A952BA3006D_var*
begin
//#UC START# *4F86BF850173_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86BF850173_4A952BA3006D_impl*
end;//TMainForm.ProcessLink

function TMainForm.CheckKey(aKey: PnsLinkDataArray): Boolean;
//#UC START# *4F86BFA3034E_4A952BA3006D_var*
//#UC END# *4F86BFA3034E_4A952BA3006D_var*
begin
//#UC START# *4F86BFA3034E_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86BFA3034E_4A952BA3006D_impl*
end;//TMainForm.CheckKey

procedure TMainForm.CheckInconic;
//#UC START# *4F86BFBF01AE_4A952BA3006D_var*
//#UC END# *4F86BFBF01AE_4A952BA3006D_var*
begin
//#UC START# *4F86BFBF01AE_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86BFBF01AE_4A952BA3006D_impl*
end;//TMainForm.CheckInconic

procedure TMainForm.MemUsage;
//#UC START# *4F88213001DE_4A952BA3006D_var*
//#UC END# *4F88213001DE_4A952BA3006D_var*
begin
//#UC START# *4F88213001DE_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F88213001DE_4A952BA3006D_impl*
end;//TMainForm.MemUsage

procedure TMainForm.nsNotification(aType: TnsNotificationType);
//#UC START# *542BF11D00B6_4A952BA3006D_var*
//#UC END# *542BF11D00B6_4A952BA3006D_var*
begin
//#UC START# *542BF11D00B6_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *542BF11D00B6_4A952BA3006D_impl*
end;//TMainForm.nsNotification

function TMainForm.pm_GetInitialState: InsBaseSearcherInitialState;
//#UC START# *54327CCD0178_4A952BA3006Dget_var*
//#UC END# *54327CCD0178_4A952BA3006Dget_var*
begin
//#UC START# *54327CCD0178_4A952BA3006Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *54327CCD0178_4A952BA3006Dget_impl*
end;//TMainForm.pm_GetInitialState

procedure TMainForm.NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
//#UC START# *55321ADE02E9_4A952BA3006D_var*
//#UC END# *55321ADE02E9_4A952BA3006D_var*
begin
//#UC START# *55321ADE02E9_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *55321ADE02E9_4A952BA3006D_impl*
end;//TMainForm.NotifyContainersChanged

function TMainForm.pm_GetStateForClone: InsBaseSearcherInitialState;
//#UC START# *560B83DE0294_4A952BA3006Dget_var*
//#UC END# *560B83DE0294_4A952BA3006Dget_var*
begin
//#UC START# *560B83DE0294_4A952BA3006Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *560B83DE0294_4A952BA3006Dget_impl*
end;//TMainForm.pm_GetStateForClone

function TMainForm.Get_BaseSearcher: InsBaseSearcher;
//#UC START# *5631AC7700D9_4A952BA3006Dget_var*
//#UC END# *5631AC7700D9_4A952BA3006Dget_var*
begin
//#UC START# *5631AC7700D9_4A952BA3006Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5631AC7700D9_4A952BA3006Dget_impl*
end;//TMainForm.Get_BaseSearcher

procedure TMainForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A952BA3006D_var*
//#UC END# *479731C50290_4A952BA3006D_var*
begin
//#UC START# *479731C50290_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4A952BA3006D_impl*
end;//TMainForm.Cleanup

constructor TMainForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4A952BA3006D_var*
//#UC END# *47D1602000C6_4A952BA3006D_var*
begin
//#UC START# *47D1602000C6_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D1602000C6_4A952BA3006D_impl*
end;//TMainForm.Create

procedure TMainForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4A952BA3006D_var*
//#UC END# *47EA4E9002C6_4A952BA3006D_var*
begin
//#UC START# *47EA4E9002C6_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47EA4E9002C6_4A952BA3006D_impl*
end;//TMainForm.FinishDataUpdate

procedure TMainForm.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_4A952BA3006D_var*
//#UC END# *47EA8B9601FE_4A952BA3006D_var*
begin
//#UC START# *47EA8B9601FE_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47EA8B9601FE_4A952BA3006D_impl*
end;//TMainForm.SettingsReplaceFinish

procedure TMainForm.UserSettingsChanged;
 {* Изменились настройки пользователя }
//#UC START# *4958BE910345_4A952BA3006D_var*
//#UC END# *4958BE910345_4A952BA3006D_var*
begin
//#UC START# *4958BE910345_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4958BE910345_4A952BA3006D_impl*
end;//TMainForm.UserSettingsChanged

procedure TMainForm.StartSettingsEdit;
//#UC START# *4958F46C003B_4A952BA3006D_var*
//#UC END# *4958F46C003B_4A952BA3006D_var*
begin
//#UC START# *4958F46C003B_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4958F46C003B_4A952BA3006D_impl*
end;//TMainForm.StartSettingsEdit

{$If NOT Defined(NoVCM)}
procedure TMainForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4A952BA3006D_var*
//#UC END# *49803F5503AA_4A952BA3006D_var*
begin
//#UC START# *49803F5503AA_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *49803F5503AA_4A952BA3006D_impl*
end;//TMainForm.DoInit
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
 !!! Needs to be implemented !!!
//#UC END# *538C374A00B7_4A952BA3006D_impl*
end;//TMainForm.ReleaseResources
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainForm.DoInitFromPrevContainer(const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *54327E120331_4A952BA3006D_var*
//#UC END# *54327E120331_4A952BA3006D_var*
begin
//#UC START# *54327E120331_4A952BA3006D_impl*
 !!! Needs to be implemented !!!
//#UC END# *54327E120331_4A952BA3006D_impl*
end;//TMainForm.DoInitFromPrevContainer
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainWithRemindersForm.ControlledChangingWarningBecomeVisible(Sender: TObject);
//#UC START# *4F7DCAFE028B_4F7DAC14027A_var*
//#UC END# *4F7DCAFE028B_4F7DAC14027A_var*
begin
//#UC START# *4F7DCAFE028B_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7DCAFE028B_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.ControlledChangingWarningBecomeVisible

procedure TMainWithRemindersForm.ControlledChangingWarningAfterBaloonShowed(Sender: TObject);
//#UC START# *4F7DCB4E032C_4F7DAC14027A_var*
//#UC END# *4F7DCB4E032C_4F7DAC14027A_var*
begin
//#UC START# *4F7DCB4E032C_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7DCB4E032C_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.ControlledChangingWarningAfterBaloonShowed

procedure TMainWithRemindersForm.ControlledChangingWarningAfterBaloonHidden(Sender: TObject);
//#UC START# *4F7DCB68009E_4F7DAC14027A_var*
//#UC END# *4F7DCB68009E_4F7DAC14027A_var*
begin
//#UC START# *4F7DCB68009E_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7DCB68009E_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.ControlledChangingWarningAfterBaloonHidden

procedure TMainWithRemindersForm.remOnlineDeadAfterBaloonHidden(Sender: TObject);
//#UC START# *4F7DCB83012B_4F7DAC14027A_var*
//#UC END# *4F7DCB83012B_4F7DAC14027A_var*
begin
//#UC START# *4F7DCB83012B_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7DCB83012B_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.remOnlineDeadAfterBaloonHidden

{$If Defined(Nemesis) AND NOT Defined(NoVCM)}
procedure TMainWithRemindersForm.StartFlashing;
//#UC START# *4F7DCF74032D_4F7DAC14027A_var*
//#UC END# *4F7DCF74032D_4F7DAC14027A_var*
begin
//#UC START# *4F7DCF74032D_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7DCF74032D_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.StartFlashing
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoVCM)

{$If Defined(Nemesis) AND NOT Defined(NoVCM)}
procedure TMainWithRemindersForm.StopFlashing;
//#UC START# *4F7DCF8D03CC_4F7DAC14027A_var*
//#UC END# *4F7DCF8D03CC_4F7DAC14027A_var*
begin
//#UC START# *4F7DCF8D03CC_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7DCF8D03CC_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.StopFlashing
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoVCM)

procedure TMainWithRemindersForm.RemMWControlledChangingWarning;
//#UC START# *4F86AAF903B5_4F7DAC14027A_var*
//#UC END# *4F86AAF903B5_4F7DAC14027A_var*
begin
//#UC START# *4F86AAF903B5_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86AAF903B5_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.RemMWControlledChangingWarning

procedure TMainWithRemindersForm.RemMWOldBaseWarning;
//#UC START# *4F86AB3A03E4_4F7DAC14027A_var*
//#UC END# *4F86AB3A03E4_4F7DAC14027A_var*
begin
//#UC START# *4F86AB3A03E4_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86AB3A03E4_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.RemMWOldBaseWarning

procedure TMainWithRemindersForm.RemMWTrialModeWarning;
//#UC START# *4F86AB490283_4F7DAC14027A_var*
//#UC END# *4F86AB490283_4F7DAC14027A_var*
begin
//#UC START# *4F86AB490283_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86AB490283_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.RemMWTrialModeWarning

procedure TMainWithRemindersForm.RemNewChatMessages;
//#UC START# *4F86AB5600B9_4F7DAC14027A_var*
//#UC END# *4F86AB5600B9_4F7DAC14027A_var*
begin
//#UC START# *4F86AB5600B9_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86AB5600B9_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.RemNewChatMessages

procedure TMainWithRemindersForm.RemOnlineDead;
//#UC START# *4F86AB6502AA_4F7DAC14027A_var*
//#UC END# *4F86AB6502AA_4F7DAC14027A_var*
begin
//#UC START# *4F86AB6502AA_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F86AB6502AA_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.RemOnlineDead

procedure TMainWithRemindersForm.FillOldBaseWarning;
//#UC START# *4F8BED97037A_4F7DAC14027A_var*
//#UC END# *4F8BED97037A_4F7DAC14027A_var*
begin
//#UC START# *4F8BED97037A_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8BED97037A_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.FillOldBaseWarning

procedure TMainWithRemindersForm.remUnreadConsultations;
//#UC START# *542D70330042_4F7DAC14027A_var*
//#UC END# *542D70330042_4F7DAC14027A_var*
begin
//#UC START# *542D70330042_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *542D70330042_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.remUnreadConsultations

{$If NOT Defined(NoVCM)}
procedure TMainWithRemindersForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4F7DAC14027A_var*
//#UC END# *4A8E8F2E0195_4F7DAC14027A_var*
begin
//#UC START# *4A8E8F2E0195_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E8F2E0195_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainWithRemindersForm.EntitiesInited;
 {* Вызывается после того как все операции зарегистрированы }
//#UC START# *4AE1948900DE_4F7DAC14027A_var*
//#UC END# *4AE1948900DE_4F7DAC14027A_var*
begin
//#UC START# *4AE1948900DE_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE1948900DE_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.EntitiesInited
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainWithRemindersForm.BecomeVisible;
//#UC START# *4F7C808A0349_4F7DAC14027A_var*
//#UC END# *4F7C808A0349_4F7DAC14027A_var*
begin
//#UC START# *4F7C808A0349_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7C808A0349_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.BecomeVisible
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainWithRemindersForm.ClearFields;
begin
 f_OldBaseWarningString := nil;
 inherited;
end;//TMainWithRemindersForm.ClearFields

{$If NOT Defined(NoVCM)}
procedure TMainWithRemindersForm.BecomeInvisible;
//#UC START# *537C9007038A_4F7DAC14027A_var*
//#UC END# *537C9007038A_4F7DAC14027A_var*
begin
//#UC START# *537C9007038A_4F7DAC14027A_impl*
 !!! Needs to be implemented !!!
//#UC END# *537C9007038A_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.BecomeInvisible
{$IfEnd} // NOT Defined(NoVCM)

class procedure TPrimNemesisRes.BeforeCorrectDate(const aDate: AnsiString);
//#UC START# *4AA8AC090381_4A925AFF01BA_var*
//#UC END# *4AA8AC090381_4A925AFF01BA_var*
begin
//#UC START# *4AA8AC090381_4A925AFF01BA_impl*
 vcmAsk(err_DateWillBeCorrectF, [aDate]);
//#UC END# *4AA8AC090381_4A925AFF01BA_impl*
end;//TPrimNemesisRes.BeforeCorrectDate

class function TPrimNemesisRes.RunOtherProcesses: Boolean;
//#UC START# *4AA7C28A0113_4A925AFF01BA_var*
//#UC END# *4AA7C28A0113_4A925AFF01BA_var*
begin
//#UC START# *4AA7C28A0113_4A925AFF01BA_impl*
 Result := true;
 with TnsStartupSupport do
 begin
  repeat
   StartupPendingNotify;
   if IsRunDataInstallerParamExist then
   begin
    if TryRunDataInstaller then
    begin
     StartupCompletedNotify;
     WaitForDataInstallerExit;
     Result := false;
     Exit;
    end;//TryRunDataInstaller
   end//IsRunDataInstallerParamExist
   else
   if IsRunDataUpdaterParamExist then
   begin
    if TryRunDataUpdater then
    begin
     StartupCompletedNotify;
     WaitForDataUpdaterExit;
     Result := false;
     Exit;
    end;//TryRunDataUpdater
   end//IsRunDataUpdaterParamExist
   else
   if IsRunDownloaderParamExist then
   begin
    if TryRunDownloader then
    begin
     StartupCompletedNotify;
     WaitForDownloaderExit;
     Result := false;
     Exit;
    end;//TryRunDownloader
   end//IsRunDownloaderParamExist
   else
   if (TryUnlockLogin or TrySwitchToOtherRunningCopy) then
   begin
    TrySendOpenByNumer;
    //
    StartupCompletedNotify;
    Result := false;
    Exit;
   end;//TryUnlockLogin or TrySwitchToOtherRunningCopy
   StartupCompletedNotify;
  until (CheckAndCreateRunningCopyMutex);
  StartupPendingNotify;
 end;//TnsStartupSupport
//#UC END# *4AA7C28A0113_4A925AFF01BA_impl*
end;//TPrimNemesisRes.RunOtherProcesses

class function TPrimNemesisRes.DoGlobalInit(aLogo: TCustomForm;
 var theSplash: IUnknown): Boolean;
//#UC START# *4AA7D7CA00FE_4A925AFF01BA_var*
//#UC END# *4AA7D7CA00FE_4A925AFF01BA_var*
begin
//#UC START# *4AA7D7CA00FE_4A925AFF01BA_impl*
 Result := true;
 try
  theSplash := DataAdapter.GlobalInit(aLogo, afw.Application.LocaleInfo.Name,
   False, TnsStartupSupport.IsSilentRunAndExitParamExist);
 except
  on EAbort do
  begin
   l3System.CheckClipboard;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=121145106
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы выполнились все секции финализации (в частности те, которые удаляют временные файлы)
  end;//on EAbort
  on EInvalidBase do
  begin
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы в десктопе завершила работу с настройками серверная часть (которая жива)
  end;//on EInvalidBase
  on EMorphoNotExists do
  begin
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы в десктопе завершила работу с настройками серверная часть (которая жива)
  end;//on EMorphoNotExists
  on ECorbaException do
  begin
   aLogo.Hide;
   Application.HandleException(nil);
   TerminateProcess(GetCurrentProcess, 255);
  end;//on ECorbaException
  else
  begin
   aLogo.Hide;
   theSplash := nil;
   TerminateProcess(GetCurrentProcess, 255);
  end;
 end;//try..except
//#UC END# *4AA7D7CA00FE_4A925AFF01BA_impl*
end;//TPrimNemesisRes.DoGlobalInit

class procedure TPrimNemesisRes.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4A925AFF01BA_var*

 //http://mdp.garant.ru/pages/viewpage.action?pageId=481813781
 function lp_SilentRunAndExit: Boolean;
 const
  c_OpenByNumberParamName = '-OpenByNumber';
 var
  l_ArgIdx: Integer;
  l_ArgCnt: Integer;
  l_SilentProcessCommand: Boolean;
  l_DocNumberStr: String;
  l_WrongLink: Boolean;
 begin
  Result := False;
  if TnsStartupSupport.IsSilentRunAndExitParamExist then
  begin
   Result := True;
   l_ArgCnt := ParamCount;
   for l_ArgIdx := 1 to l_ArgCnt do
    if (AnsiCompareText(ParamStr(l_ArgIdx), c_OpenByNumberParamName) = 0) then
    begin
     if (l_ArgIdx < l_ArgCnt) then
      l_DocNumberStr := ParamStr(Succ(l_ArgIdx));
     if (l_DocNumberStr <> '') then
      if (not nsNeedShellToOpenDocument(l_DocNumberStr, True, l_WrongLink)) or l_WrongLink then
      begin
       if not l_WrongLink then
        Result := nsOpenLink(l_DocNumberStr, True, False, False);
      end
      else
       Result := False;
    end;//if (AnsiCompareText(ParamStr(l_ArgIdx), c_OpenByNumberParamName) = 0)
  end;//if TnsStartupSupport.IsSilentRunAndExitParamExist
 end;//lp_SilentRunAndExit

var
 l_Main : TnsMainWindow;
 l_Cont : TvcmEntityForm;
 l_NeedSilentRunAndExit: Boolean;
//#UC END# *4AA7E4DC0047_4A925AFF01BA_var*
begin
//#UC START# *4AA7E4DC0047_4A925AFF01BA_impl*
 inherited;
 g_vtBeforeCorrectDate := Self.BeforeCorrectDate;
 afw.Application.LockKeyboard;
 try
  l_NeedSilentRunAndExit := lp_SilentRunAndExit;
  if not l_NeedSilentRunAndExit then
  begin
   defDataAdapter.DefineApplicationTitle;
   Application.CreateForm(TdmMedicMainMenuRes, dmMedicMainMenuRes);
   afw.ProcessMessages;
   Application.CreateForm(TdmMainMenuNew, dmMainMenuNew);
   afw.ProcessMessages;
   Application.CreateForm(TnsMainWindow, l_Main);

   {$IfDef InsiderTest}
   l_Main.DefaultMonitor := dmDesktop;
   {$EndIf InsiderTest}
   afw.ProcessMessages;
  end;
 finally
  if defDataAdapter.FatalExceptionRaised then
  begin
   theSplash := nil;
   TerminateProcess(GetCurrentProcess, 255);
  end;
  theSplash := nil;
  defDataAdapter.InStartUpProcess := False;
  afw.Application.UnLockKeyboard;

  l_Cont := nil; 
  if (not l_NeedSilentRunAndExit) and
   TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
  begin
   TvcmTabbedContainerFormDispatcher.Instance.TabImages := nsTabbedContainerRes.ilTabImages;
   TvgRemindersLineTabbedContainerNotificationProxy.Instance;
   l_Cont := TvcmTabbedContainerFormDispatcher.Instance.MakeNewtabbedContainer(l_Main);
   l_Cont.Visible := true;
  end;

  if (l_Cont <> nil) then
   if l_Cont.HandleAllocated then
    SetForegroundWindow(l_Cont.Handle)
   else
  else
  if (l_Main <> nil) then
   if l_Main.HandleAllocated then
    SetForegroundWindow(l_Main.Handle);
  TnsNotificationManager.NotifyListeners(ntMainFormBecomeTopmostAtStartup);
 end;//try..finally
//#UC END# *4AA7E4DC0047_4A925AFF01BA_impl*
end;//TPrimNemesisRes.DoRun

class procedure TPrimNemesisRes.OpenQuery(aQueryType: TlgQueryType;
 const aQuery: IQuery;
 const aContainer: IvcmContainer);
//#UC START# *4AC4A69D03B7_4A925AFF01BA_var*
//#UC END# *4AC4A69D03B7_4A925AFF01BA_var*
begin
//#UC START# *4AC4A69D03B7_4A925AFF01BA_impl*
 case aQueryType of
  lg_qtKeyWord:
   TdmStdRes.OpenKeyWord(aQuery, aContainer);
  lg_qtAttribute:
   TdmStdRes.AttributeSearch(aQuery, nil, aContainer);
  lg_qtPublishedSource:
   TdmStdRes.PublishSourceSearch(aQuery, nil);
  lg_qtLegislationReview:
   TdmStdRes.OpenLegislationReview(aQuery);
  lg_qtSendConsultation:
   vcmDispatcher.ModuleOperation(TdmStdRes.mod_opcode_Search_OpenConsult);
  lg_qtBaseSearch:
   TdmStdRes.OpenBaseSearch(ns_bsokGlobal,
                            aQuery);
  lg_qtInpharmSearch:
   TdmStdRes.InpharmSearch(aQuery, nil, aContainer);
  else
   inherited;   
 end;//case aQueryType
//#UC END# *4AC4A69D03B7_4A925AFF01BA_impl*
end;//TPrimNemesisRes.OpenQuery

initialization
 str_CarrierLost.Init;
 {* Инициализация str_CarrierLost }
 str_InternetAbsent.Init;
 {* Инициализация str_InternetAbsent }
 str_TotalFailure.Init;
 {* Инициализация str_TotalFailure }
 str_CaptionForSaving.Init;
 {* Инициализация str_CaptionForSaving }
 str_utMainWindowCaption.Init;
 {* Инициализация str_utMainWindowCaption }
 str_utMainWindowSettingsCaption.Init;
 {* Инициализация str_utMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNemesisMainForm);
 {* Регистрация NemesisMain }
{$IfEnd} // NOT Defined(NoScripts)
//#UC START# *4C8A47F102D1*
//#UC END# *4C8A47F102D1*
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainOptionsForm);
 {* Регистрация MainOptions }
{$IfEnd} // NOT Defined(NoScripts)
//#UC START# *4F882E1B0358*
//#UC END# *4F882E1B0358*
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainForm);
 {* Регистрация Main }
{$IfEnd} // NOT Defined(NoScripts)
 str_ControlledChangingWarningHint.Init;
 {* Инициализация str_ControlledChangingWarningHint }
 str_OldBaseWarningHint.Init;
 {* Инициализация str_OldBaseWarningHint }
 str_TrialModeWarningHint.Init;
 {* Инициализация str_TrialModeWarningHint }
 str_remUnreadConsultationsHint.Init;
 {* Инициализация str_remUnreadConsultationsHint }
 str_remOnlineDeadHint.Init;
 {* Инициализация str_remOnlineDeadHint }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainWithRemindersForm);
 {* Регистрация MainWithReminders }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsMainWindow);
 {* Регистрация MainWindow }
{$IfEnd} // NOT Defined(NoScripts)
 fm_nsMainWindow.SetFactory(TnsMainWindow.Make);
 {* Регистрация фабрики формы MainWindow }

finalization
//#UC START# *4C8A47FA036C*
//#UC END# *4C8A47FA036C*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
