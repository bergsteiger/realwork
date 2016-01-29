unit afwInterfaces;

interface

uses
 l3IntfUses
 , Controls
 , l3Interfaces
 , l3InternalInterfaces
 , l3Core
 , afwTypes
 , l3PrinterInterfaces
 , ImgList
 , Forms
;

type
 TafwRect = Tl3_Rect;
 
 IafwCString = Il3CString;
 
 IafwFontCache = interface
 end;//IafwFontCache
 
 IafwStyleTableSpy = interface
  {* Объект, принимающий уведомления об таблицы стилей. }
  procedure StyleTableChanged;
   {* таблица стилей изменилась. }
 end;//IafwStyleTableSpy
 
 IafwScrollListener = interface
  {* Объект принимающий нотификации от скроллера. }
  procedure Signal;
   {* Позиция скроллера изменилась. }
 end;//IafwScrollListener
 
 IafwPreviewPage = interface
  {* Страница Preview. }
  procedure Add(const aPage: IafwPreviewPage);
   {* добавляет страницу в ширину. }
  procedure Drop(aCounter: Boolean);
   {* сбрасывает страницу на диск. }
  procedure Finish(aPageNumber: Integer;
   aPageWidthNumber: Integer;
   anOverallPageNumber: Integer);
   {* завершает построение страницы. }
  function GetMMWidth: Integer;
   {* ширина страницы в мм. }
  function GetMMHeight: Integer;
   {* высота (длина) страницы в мм. }
  procedure DrawTo(const aRect: TRect;
   aBitmap: VCLBitmap);
   {* рисует страницу в прямоугольнике на битмапе }
  function WidthCount: Integer;
   {* количество страниц в ширину. }
  function WidthPage(anIndex: Integer): IafwPreviewPage;
   {* страницы в ширину. }
 end;//IafwPreviewPage
 
 IafwStrings = Il3StringsEx;
  {* Список строк. }
 
 IafwFont = interface(Il3FontPrim)
  {* Шрифт. }
  procedure Assign2Font(aFont: TFont);
 end;//IafwFont
 
 IafwBase = interface(Il3Base)
  {* Базовый интерфейс библиотеки AFW. }
 end;//IafwBase
 
 TafwPagesInfo = object
 end;//TafwPagesInfo
 
 IafwPreviewCanvas = interface
  {* Канва для вывода предварительного просмотра печати. }
  function IsMonochrome: Boolean;
   {* true, если устройство назначения не поддерживает цвет; определяет, будет по-умолчанию подавлен цвет. }
  function GetPagesCount: Integer;
   {* длина документа в страницах (количество страниц "в высоту"). }
  function GetPagesWidthCount(aIndex: Integer): Integer;
   {* сколько страниц в ширину, для заданной страницы. }
  function GetPageByObject(anObjectID: Integer): Integer;
   {* страница по смещению с начала. }
  function GetMMPageWidth(aIndex: Integer;
   aWIndex: Integer): Integer;
   {* ширина страницы в мм. }
  function GetMMPageHeight(aIndex: Integer;
   aWIndex: Integer): Integer;
   {* высота (длина) страницы в мм. }
  procedure DrawTo(aIndex: Integer;
   aWIndex: Integer;
   const aRect: TRect;
   aBitmap: VCLBitmap);
   {* рисует страницу в прямоугольнике на битмапе }
  function GetIntervalPages(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager): TafwPrintPagesArray;
   {* получает массив страниц, по диапазону. }
  procedure Drop;
   {* сбрасывает страницы на диск. }
  function IsPagesCounter: Boolean;
   {* канва для подсчета числа страниц? }
  function PreviewPage(aIndex: Integer;
   aWIndex: Integer): IafwPreviewPage;
   {* страница preview. }
 end;//IafwPreviewCanvas
 
 IafwPrinter = Il3Printer;
  {* Принтер. }
 
 IafwPreviewNotifier = interface
  {* Подписчик на изменения содержимого превью }
  procedure ContentChanged;
   {* Содержимое preview изменилось. }
 end;//IafwPreviewNotifier
 
 TafwPreviewContentKind = (
  afw_pckDocument
  , afw_pckInfo
  , afw_pckSelection
 );//TafwPreviewContentKind
 
 IafwPreviewPanel = interface
  {* Панель Print-preview. }
  procedure SetCurrentPage(aValue: Integer);
  procedure Invalidate;
  procedure Done;
  function ShouldStop: Boolean;
 end;//IafwPreviewPanel
 
 IafwDocumentPreview = interface
  function DocumentName: IafwCString;
   {* имя документа для preview. }
  function InProcess: Boolean;
   {* идет процесс? }
  function InPagesCounting: Boolean;
   {* сейчас в процессе подсчета страниц? }
  function InUpdate: Boolean;
   {* находимся в процессе построения preview? }
  function InPrinting: Boolean;
   {* находимся в процессе построения печати? }
  procedure Update(const aPanel: IafwPreviewPanel);
   {* установить preview на панель для отображения. }
  procedure Print(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager;
   aCopies: Integer;
   const aFileName: AnsiString;
   aCollate: Boolean);
   {* напечатать на принтер. }
  procedure Stop(aWnd: THandle);
   {* остановит процесс построение preview/печати. }
  function Stopped: Boolean;
   {* процесс остановлен? }
  function CloseRequested: Boolean;
   {* при остановке процесса был запрос на закрытие превью }
  function PreviewResetting: Boolean;
   {* канва отсутствует, но будет передалываться }
  procedure SetCurrentPage(const aCursor: IUnknown);
   {* устанавливает курсор на текущую страницу. }
  procedure SetCurrentPagePara(aParaID: Integer);
   {* устанавливает курсор на текущую страницу. }
  procedure SetCurrentPageNumber(aPageNumber: Integer);
   {* устанавливает курсор на текущую страницу. }
  function CurrentPage: Integer;
   {* текущая страница для печати. }
  function HasCurrentPage: Boolean;
   {* установлена ли текущая страница. }
 end;//IafwDocumentPreview
 
 IafwPageSetup = interface
  {* Установки печати. }
 end;//IafwPageSetup
 
 TafwPoint = Tl3_Point;
 
 IafwShape = interface
 end;//IafwShape
 
 IafwPrintManager = interface
  {* Менеджер печати. }
  function CanPrint: Boolean;
  procedure PrintDialog(const aPreview: IafwDocumentPreview);
   {* выводит диалог печати. }
  procedure ShowPreview(const aPreview: IafwDocumentPreview);
   {* показывает предварительный просмотр печати. }
 end;//IafwPrintManager
 
 IafwDropDownWindow = interface
  {* Интерфейс для идентификации выпадающего окна. Для принятия решения при
      управлении активностью плавающих в приложении форм. }
 end;//IafwDropDownWindow
 
 IafwStringsSource = interface
  procedure FillStrings(const aStrings: IafwStrings);
 end;//IafwStringsSource
 
 IafwResources = Il3ApplicationL10NStrings;
 
 IafwLongProcessVisualizer = interface
  {* Визуализатор длительных процессов }
 end;//IafwLongProcessVisualizer
 
 IafwForm = interface
  {* Форма приложения. }
  procedure UpdateCaption(const aCaption: IafwCString);
   {* установить заголовок формы. }
 end;//IafwForm
 
 TafwStringArray = Tl3CStringArray;
 
 TafwStatusInfo = record
  {* Список строк статуса. }
 end;//TafwStatusInfo
 
 IafwStatusElement = interface
  {* GetStatusInfo(out theString: IafwCString; out theNeedProgress: Boolean) }
  procedure GetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
 end;//IafwStatusElement
 
 IafwStatus = interface
  {* Строка статуса. }
  procedure AddElement(const anElement: IafwStatusElement);
  procedure RemoveElement(const anElement: IafwStatusElement);
  procedure Update;
  procedure GetStatus(out theStatus: TafwStatusInfo);
 end;//IafwStatus
 
 IafwStatusBar = interface
  {* Визуализация строки статуса. }
  procedure UpdateStrings(const aStrings: TafwStatusInfo);
 end;//IafwStatusBar
 
 IafwUserQuery = interface
  {* "Ворота" для запроса пользователя. }
  function Ask(const aQuery: AnsiString): Boolean;
   {* задает вопрос пользователю и получает ответ. }
 end;//IafwUserQuery
 
 IafwMainForm = interface(IafwForm)
  {* Основная форма приложения. }
 end;//IafwMainForm
 
 TafwSettingId = AnsiString;
  {* Идентификатор настройки. }
 
 TafwSettingsState = (
  {* Состояние компонента работы с настройками. }
  afw_ssNone
   {* - обычное состояние. }
  , afw_ssSaveInAllSettings
   {* - сохранять настройки во все конфигурации. }
 );//TafwSettingsState
 
 (*
 afwSettingsPrim = interface
  function LoadInteger(const aSettingId: TafwSettingId;
   aDefault: Integer;
   aRestoreDefault: Boolean): Integer;
  function LoadParam(const aSettingId: TafwSettingId;
   aType: byte;
   out aValue;
   aDefault;
   aRestoreDefault: Boolean): Boolean;
  function LoadString(const aSettingId: TafwSettingId;
   const aDefault: AnsiString;
   aRestoreDefault: Boolean): IafwCString;
  procedure SaveBoolean(const aSettingId: TafwSettingId;
   aValue: Boolean;
   aDefault: Boolean;
   aSetAsDefault: Boolean);
  procedure SaveInteger(const aSettingId: TafwSettingId;
   aValue: Integer;
   aDefault: Integer;
   aSetAsDefault: Boolean);
   {* aValue - текущее значение, aDefault - значение по умолчанию, устанавливается для восстанвления настроек. }
  procedure SaveParam(const aSettingId: TafwSettingId;
   aType: byte;
   aValue;
   aDefault;
   aSetAsDefault: Boolean);
  procedure SaveString(const aSettingId: TafwSettingId;
   const aValue: IafwCString;
   const aDefault: AnsiString;
   aSetAsDefault: Boolean);
  function LoadBoolean(const aSettingId: TafwSettingId;
   aDefault: Boolean;
   aRestoreDefault: Boolean): Boolean;
  function LoadStrings(const aSettingId: TafwSettingId;
   aRestoreDefault: Boolean): IafwStrings;
  procedure SaveStrings(const aSettingId: TafwSettingId;
   const aValue: IafwStrings;
   aSetAsDefault: Boolean);
 end;//afwSettingsPrim
 *)
 
 IafwLocaleInfo = Il3LocaleInfo;
  {* Информация о локали. }
 
 TafwShiftState = TShiftState;
 
 TafwClickKind = (
  afw_ckSingle
  , afw_ckDouble
  , afw_ckTriple
 );//TafwClickKind
 
 TafwStrobType = (
  {* Тип строба. }
  afw_stNone
  , afw_stHorz
  , afw_stVert
 );//TafwStrobType
 
 TafwMouseState = record
 end;//TafwMouseState
 
 TafwCursorState = type TafwMouseState;
 
 TafwMouseEffect = record
 end;//TafwMouseEffect
 
 TafwCursorShape = (
  {* Форма курсора. }
  ev_csDefault
  , ev_csNone
  , ev_csArrow
  , ev_csCross
  , ev_csIBeam
  , ev_csSizeNESW
  , ev_csSizeNS
  , ev_csSizeNWSE
  , ev_csSizeWE
  , ev_csUpArrow
  , ev_csHourGlass
  , ev_csDrag
  , ev_csNoDrop
  , ev_csHSplit
  , ev_csVSplit
  , ev_csMultiDrag
  , ev_csSQLWait
  , ev_csNo
  , ev_csAppStart
  , ev_csHelp
  , ev_csHandPoint
  , ev_csSize
  , ev_csSizeAll
  , ev_csSelectCell
  , ev_csSelectColumn
  , ev_csSelectLine
  , ev_csProperties
  , ev_csExternalHand
  , ev_csInvalidHand
  , ev_csAbolishedHand
  , ev_csPreactiveHand
  , ev_csExternalEno
   {* Внешнее приложение }
  , ev_csTimeMachineHand
 );//TafwCursorShape
 
 TafwCursorInfo = record
 end;//TafwCursorInfo
 
 IafwAbortableProcess = interface
  procedure Abort;
 end;//IafwAbortableProcess
 
 IafwTextControl = interface
 end;//IafwTextControl
 
 IafwWeightListener = interface
  {* Интерфейс закладки для взаимодействия со сторонними компонентами. }
  procedure WeightChanged;
   {* вес компонента был изменен, надо переразместить компоненты. }
 end;//IafwWeightListener
 
 IafwGUIDHolder = interface
 end;//IafwGUIDHolder
 
 IafwTabSheetControl = interface
  {* Интерфейс который может поддержать объект для определения его веса по сравнению с другими объектами поддерживающими этот интерфейс. }
  procedure PageInactive;
   {* активная закладка стала не активной. }
  procedure PageActive;
   {* закладка стала активной. }
 end;//IafwTabSheetControl
 
 TafwValueMapID = Tl3ValueMapID;
 
 IafwValueMap = Il3ValueMap;
 
 IafwStringValueMap = Il3StringValueMap;
 
 IafwStringValueMapFactory = Il3StringValueMapFactory;
 
 IafwStringValueMapManager = Il3StringValueMapManager;
 
 IafwIntegerValueMap = Il3IntegerValueMap;
 
 IafwIntegerValueMapFactory = Il3IntegerValueMapFactory;
 
 IafwIntegerValueMapManager = Il3IntegerValueMapManager;
 
 IafwPreviewNotificationSource = interface
  {* источник нотификаций об изменении содержимого превью }
  procedure Subscribe(const aNotifier: IafwPreviewNotifier);
  procedure UnSubscribe(const aNotifier: IafwPreviewNotifier);
 end;//IafwPreviewNotificationSource
 
 IafwSettingListener = interface
  {* Изменилась настройка. }
  function SettingChanged(const aSettingId: TafwSettingId): Boolean;
   {* настройки изменились. }
 end;//IafwSettingListener
 
 IafwSettingsReplaceListener = interface
  {* Слушатель замены настроек. }
  procedure Start;
   {* перед заменой настроек. }
  procedure Finish;
   {* после замены настроек. }
 end;//IafwSettingsReplaceListener
 
 IafwApplicationDataListener = interface
  {* Слушатель событий данных приложения. }
  procedure UpdateFinished;
   {* Информирует слушателя об окончании обновления данных }
 end;//IafwApplicationDataListener
 
 IafwApplicationDataNotify = interface
  {* Уведомляет о событиях данных приложения. }
  procedure AddListener(const aListener: IafwApplicationDataListener);
   {* - добавить слушателя. }
  procedure RemoveListener(const aListener: IafwApplicationDataListener);
   {* - удалить слушателя. }
 end;//IafwApplicationDataNotify
 
 IafwApplicationData = interface
  {* Данные приложения. }
  procedure FinishUpdate;
   {* Информирует систему о конце обновления данных. }
 end;//IafwApplicationData
 
 TafwCustomImageList = TCustomImageList;
  {* Базовый список картинок. }
 
 IafwComplexDocumentPreview = interface(IafwDocumentPreview)
  {* Предварительный просмотр печати составного документа. }
  function Current: IafwDocumentPreview;
  function Document: IafwDocumentPreview;
  procedure SetDocument(const aDocument: IafwDocumentPreview);
  function Selection: IafwDocumentPreview;
  procedure SetSelection(const aSelection: IafwDocumentPreview);
  function Info: IafwDocumentPreview;
  procedure SetInfo(const anInfo: IafwDocumentPreview);
 end;//IafwComplexDocumentPreview
 
 THandle = l3Core.THandle;
  {* Handle объекта Windows. }
 
 TPersistent = l3Core.TPersistent;
 
 IafwCaret = Il3Caret;
 
 IafwScrollCaret = Il3ScrollCaret;
 
 TafwSPoint = Tl3_SPoint;
 
 IafwSettingsPrim = interface
  function LoadInteger(const aSettingId: TafwSettingId;
   aDefault: Integer;
   aRestoreDefault: Boolean): Integer;
  function LoadParam(const aSettingId: TafwSettingId;
   aType: byte;
   out aValue;
   aDefault;
   aRestoreDefault: Boolean): Boolean;
  function LoadString(const aSettingId: TafwSettingId;
   const aDefault: AnsiString;
   aRestoreDefault: Boolean): IafwCString;
  procedure SaveBoolean(const aSettingId: TafwSettingId;
   aValue: Boolean;
   aDefault: Boolean;
   aSetAsDefault: Boolean);
  procedure SaveInteger(const aSettingId: TafwSettingId;
   aValue: Integer;
   aDefault: Integer;
   aSetAsDefault: Boolean);
   {* aValue - текущее значение, aDefault - значение по умолчанию, устанавливается для восстанвления настроек. }
  procedure SaveParam(const aSettingId: TafwSettingId;
   aType: byte;
   aValue;
   aDefault;
   aSetAsDefault: Boolean);
  procedure SaveString(const aSettingId: TafwSettingId;
   const aValue: IafwCString;
   const aDefault: AnsiString;
   aSetAsDefault: Boolean);
  function LoadBoolean(const aSettingId: TafwSettingId;
   aDefault: Boolean;
   aRestoreDefault: Boolean): Boolean;
  function LoadStrings(const aSettingId: TafwSettingId;
   aRestoreDefault: Boolean): IafwStrings;
  procedure SaveStrings(const aSettingId: TafwSettingId;
   const aValue: IafwStrings;
   aSetAsDefault: Boolean);
 end;//IafwSettingsPrim
 
 TafwScrollBarType = (
  {* Тип необходимых полос прокрутки. }
  afw_sbHorz
  , afw_sbVert
 );//TafwScrollBarType
 
 TafwScrollBars = set of TafwScrollBarType;
  {* Множество необходимых полос прокрутки. }
 
 // afw_sbBoth
 
 IafwControl = interface
  {* Контрол вывода. }
  procedure UpdateScrollRange(WhatUpdate: TafwScrollBars);
  function IsA(anObj: TObject): Boolean;
 end;//IafwControl
 
 IafwAlwaysOnTopControl = interface
  {* Фиктивный интерфейс-флаг. По мотивам [$86478352]. }
 end;//IafwAlwaysOnTopControl
 
 IafwTempStream = Il3TempStream;
 
 TafwColor = Tl3Color;
  {* Цвет. }
 
 TafwFontIndex = Tl3FontIndex;
 
 IafwHAFPainter = Il3HAFPainter;
 
 IafwMultiDocumentPreview = interface(IafwDocumentPreview)
  {* Предварительный просмотр нескольких документов пачкой. }
  procedure AddDocument(const aDocument: IafwDocumentPreview);
   {* Добавляет документ в пачку. }
 end;//IafwMultiDocumentPreview
 
 IafwSettings = interface(IafwSettingsPrim)
  {* интерфейс для работы с настройками. }
  function LoadDouble(const aSettingId: TafwSettingId;
   aDefault: Double;
   aRestoreDefault: Boolean): Double;
  procedure SaveDouble(const aSettingId: TafwSettingId;
   aValue: Double;
   aDefault: Double;
   aSetAsDefault: Boolean);
 end;//IafwSettings
 
 TafwPreviewCaleeArea = (
  afw_pcaMain
  , afw_pcaReference
  , afw_pcaAnnotation
  , afw_pcaTranslation
  , afw_pcaChronology
 );//TafwPreviewCaleeArea
 
 IafwHAFMacroReplacer = Il3HAFMacroReplacer;
 
 IafwProportionalControl = interface
  {* Для нотификации контрола о успешной загрузки сохраненных размеров его детей. K-137463980 }
  procedure NotifyLoaded;
   {* Все дети загружены }
 end;//IafwProportionalControl
 
 TafwJumpToEffect = (
  {* Поведение требуемое при переходе по гиперссылке }
  afw_jteRequestNewWindow
   {* Открытваться в новом окне }
  , afw_jteRequestNewTab
  , afw_jteRequestNoActivate
 );//TafwJumpToEffect
 
 TafwJumpToEffects = set of TafwJumpToEffect;
  {* Поведение требуемое при переходе по гиперссылке }
 
 TafwAskClearClipboardProc = Tl3AskClearClipboardProc;
 
 IafwMenuUnlockedPostBuild = interface
  procedure MenuUnlockedFixUp;
 end;//IafwMenuUnlockedPostBuild
 
 TafwTabInterfaceType = (
  afw_titNoTabs
   {* Приложение без вкладок }
  , afw_titTabs
   {* Приложение с вкладками }
  , afw_titTabsDisabled
   {* Приложение с вкладками, но они отключены }
 );//TafwTabInterfaceType
 
 IafwComplexDocumentPreviewFactory = interface
  {* Фабрика с кэшем }
  function Make: IafwComplexDocumentPreview;
  function Count: Integer;
  procedure ResetCache(ResetInfo: Boolean);
 end;//IafwComplexDocumentPreviewFactory
 
 IafwFormView = interface
  {* [RequestLink:259168102] }
  function CalculateHeightByWidth(var theWidth: Integer;
   aForceLoadData: Boolean): Integer;
  procedure SetBackColor(aColor: TafwColor);
 end;//IafwFormView
 
 IafwFloatingWindow = interface
  procedure DisableClose;
  procedure DisableReactivate;
 end;//IafwFloatingWindow
 
 IafwSettingsSource = interface
  {* Объект, умеющий работать с настройками. }
 end;//IafwSettingsSource
 
 (*
 MafwSettingsNotify = interface
  procedure AddListener(const aListener: IafwSettingListener); overload;
  procedure AddListener(const aListener: IafwSettingsReplaceListener); overload;
  procedure RemoveListener(const aListener: IafwSettingListener); overload;
  procedure RemoveListener(const aListener: IafwSettingsReplaceListener); overload;
 end;//MafwSettingsNotify
 *)
 
 TafwCustomForm = TCustomForm;
 
 IafwMainFormContainer = interface
  procedure UpdateFormCaption(aForm: TafwCustomForm);
 end;//IafwMainFormContainer
 
 IafwMainFormProvider = interface
 end;//IafwMainFormProvider
 
 (*
 MafwVisualizater = interface
  function MakeLongProcessVisualizer(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer): IafwLongProcessVisualizer;
 end;//MafwVisualizater
 *)
 
 IafwApplication = interface
  {* Скелет приложения, знающий об основных объектах. }
  function IsTrialMode: Boolean;
  procedure ApplyActiveLanguage(const aTarget: IafwResources);
  procedure LockKeyBoard;
  procedure UnlockKeyBoard;
  function AskClearClipboardProc: TafwAskClearClipboardProc;
  function MakeLongProcessVisualizer(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer): IafwLongProcessVisualizer;
 end;//IafwApplication
 
implementation

uses
 l3ImplUses
;

end.
