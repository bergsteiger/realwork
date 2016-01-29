unit vcmInterfaces;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , vcmBaseTypes
 , l3Interfaces
 , afwInterfaces
 , Controls
 , l3Core
 , vcmFormSetFormItemList
 , vcmUserControls
 , Forms
 , Types
 , vcmFormDispatcherInterfaces
 , Classes
 , l3TabbedContainersDispatcher
;

type
 TvcmObject = (
  {* Объект VCM. }
  vcm_objModule
  , vcm_objEntity
  , vcm_objEntityOperation
  , vcm_objModuleOperation
  , vcm_objControl
  , vcm_objMessage
  , vcm_objForm
  , vcm_objMainMenuItem
  , vcm_objUserType
  , vcm_objOperationState
  , vcm_objStrings
  , vcm_objFormSetFactory
 );//TvcmObject
 
 TvcmStringID = Tl3StringID;
 
 TvcmProjectFormName = type AnsiString;
  {* Тип для работы со списком форм проекта }
 
 PvcmStringID = ^TvcmStringID;
 
 TvcmOperationCode = Tl3OperationCode;
  {* команда возвращаемая компоненту в результате срабатывания механизма ShortCut-ов }
 
 IvcmData = interface
  {* Базовый интерфейс данных }
  function Clone: IvcmData;
   {* сделать копию }
 end;//IvcmData
 
 IvcmObjectWithData = interface
  {* Объект с данными }
 end;//IvcmObjectWithData
 
 TvcmTestEvent = procedure(const aParams: IvcmTestParamsPrim) of object;
  {* Вызывается в момент проверки доступности операции из главного меню. }
 
 TvcmStatusStrings = TafwStatusInfo;
 
 IvcmBase = vcmExternalInterfaces.IvcmBase;
 
 (*
 MvcmEntityFormState = interface
  function IsBaloon: Boolean;
 end;//MvcmEntityFormState
 *)
 
 (*
 MvcmLayout = interface
  function IsAcceptable(aDataUpdate: Boolean): Boolean;
   {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
 end;//MvcmLayout
 *)
 
 IvcmLayout = interface
  function IsAcceptable(aDataUpdate: Boolean): Boolean;
   {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
 end;//IvcmLayout
 
 TvcmFormID = vcmBaseTypes.TvcmFormID;
  {* Идентификатор формы. }
 
 TvcmZoneType = vcmBaseTypes.TvcmZoneType;
 
 IvcmContainer = interface;
 
 IvcmParams = interface;
 
 IvcmTestParams = interface(IvcmTestParamsPrim)
  function BasePart: IvcmParams;
  procedure SetControlEvent(anEvent: TvcmControlTestEvent);
 end;//IvcmTestParams
 
 IvcmFormSetDataSource = interface;
 
 IvcmEntityForm = interface;
 
 IvcmFormDataSource = interface(Il3ChangeNotifier)
  {* Бизнес объект формы }
  function IsDataAvailable: Boolean;
   {* существуют ли данные в текущих условиях. Например, на текущей базе. }
  function IsSame(const aValue: IvcmFormDataSource): Boolean;
   {* проверка на равенство }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* является ли форма главной в сборке }
  function IsLikeViewAreaController(const aDataSource: IvcmFormDataSource): Boolean;
   {* определим нужно ли менять позицию на данные }
  function CastUCC(const aGUID: TGUID;
   out theObj;
   NeedsException: Boolean): Boolean;
   {* Приводит контроллер прецедента к заданному интерфейсу. Это нужно, чтобы избавится от явного знания о контроллере прецедента. [$122674504] }
 end;//IvcmFormDataSource
 
 IvcmExecuteParams = interface(IvcmFlexParams)
  {* Параметры выполнения операции. }
  procedure SetControlEvent(anEvent: TvcmControlEvent);
  function BasePart: IvcmParams;
 end;//IvcmExecuteParams
 
 IvcmFormSet = interface;
 
 IvcmFormSetRefreshDataParams = interface;
 
 IvcmFormSetDataSource = interface(IvcmObjectWithData)
  {* Интерфейс бизнес объекта сборки форм. [$54689847] }
  procedure BeginRefresh;
   {* вызывается перед началом обновления }
  procedure EndRefresh;
   {* вызывается в конце обновления }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* является ли форма главной в сборке }
  function IsLikeUseCaseController(const aDataSource: IvcmFormSetDataSource): Boolean;
   {* определим нужно ли пересоздавать сборку или все отличие в позиции на данных }
  function IsRefreshing: Boolean;
   {* сборка находится в состоянии обновления }
  procedure PushFromHistory;
   {* сборка была выгружена из истории }
  procedure Refresh(const aParams: IvcmFormSetRefreshDataParams);
   {* обновить представление сборки }
  function MakeClone: IvcmFormSetDataSource;
  procedure PopToHistory;
 end;//IvcmFormSetDataSource
 
 TvcmCanClose = (
  {* Определяет возможность закрытия формы }
  vcm_ccNone
   {* Не определено. Если у TvcmEntityForm.CanClose = vcm_ccNone,
                     а у TvcmZonesCollectionItem.CanClose <> vcm_ccNone, то
                     форме устанавливает CanClose как у зоны стыковки }
  , vcm_ccEnable
   {* Окно может быть закрыто }
  , vcm_ccDisable
   {* Окно не может быть закрыто }
 );//TvcmCanClose
 
 IvcmDispatcher = interface;
 
 IvcmForm = interface(IvcmLayout)
  {* Базовый класс формы библиотеки VCM }
  function SafeClose: Boolean;
  function ShowModal: Integer;
 end;//IvcmForm
 
 TvcmFormDataSourceNotify = (
  {* Нотификация рассылаемая _IvcmFormDataSource слушателям }
  vcm_dsnDestroy
 );//TvcmFormDataSourceNotify
 
 IvcmUserTypeDef = interface(IvcmBaseObjectDef)
 end;//IvcmUserTypeDef
 
 IvcmUserTypesIterator = interface
  function Next: IvcmUserTypeDef;
 end;//IvcmUserTypesIterator
 
 TvcmActivateIfUpdate = (
  {* определяет способ активации формы (сделать закладку активной) при
       обновлении сборки. }
  wafNone
   {* не активировать }
  , wafAlways
   {* всегда активировать }
  , wafIfNotActivated
   {* активировать только если не активных с флагом ActivateIfUpdate }
 );//TvcmActivateIfUpdate
 
 IvcmEntityFormDef = interface(IvcmBaseObjectDef)
 end;//IvcmEntityFormDef
 
 TvcmBool = (
  {* Логический тип используемый в VCM }
  vcm_bNone
  , vcm_bFalse
  , vcm_bTrue
 );//TvcmBool
 
 TvcmImageSize = (
  {* Размер иконки. Используется для указания размеров иконок для зоны }
  isNone
  , isSmall
  , isLarge
  , isMedium
 );//TvcmImageSize
 
 IvcmToolbarStyle = interface
  {* Стиль панели инструментов }
  procedure Merge(const aStyle: IvcmToolbarStyle);
   {* объединить стили }
 end;//IvcmToolbarStyle
 
 IvcmToolbarsStyle = interface
  {* Иконки панелей инструментов }
  procedure Merge(const aStyle: IvcmToolbarsStyle);
   {* объединить стили }
  function IsDefault: Boolean;
   {* для одной из панелей устновлены иконки }
  procedure ForbidMerge;
   {* запретить объединение панелей инструментов }
 end;//IvcmToolbarsStyle
 
 IvcmFormStyle = interface
  {* стиль VCM формы }
  procedure Merge(const aStyle: IvcmFormStyle);
   {* объединить стили }
 end;//IvcmFormStyle
 
 IvcmEntity = interface;
 
 IvcmAggregate = interface;
 
 IvcmEntityForm = interface(IvcmForm)
  function SameName(const aName: TvcmFormID): Boolean;
   {* Проверяет является ли переданное имя именем сущности }
  function LoadState(const aState: IvcmBase;
   aStateType: TvcmStateType): Boolean;
  function SaveState(out theState: IvcmBase;
   aStateType: TvcmStateType): Boolean;
  function IsMainObjectForm: Boolean;
  function IsModalForm: Boolean;
   {* сначала проверяет свой флаг IsModal, если False, то рекурсивно
             проверяет флаги родителей формы }
  function IsModal: Boolean;
   {* форма является модальной }
  function GetStatus(out theStatus: TvcmStatusStrings): Boolean;
  procedure SetActiveInParent;
   {* сделать активным в родителе. Применяется для форм находящихся в PageControl-е }
  procedure SetFirstActiveInParent;
   {* сделать активным первого в родителе }
  procedure SetActiveAndShowInParent;
   {* сделать активной и развернуть навигатор он был свернут }
  procedure SetInactiveInParent;
   {* сделать активным предыдующего в родителе. Применяется для форм находящихся в PageControl-е }
  function IsActiveInParent: Boolean;
   {* является ли форма активная в родителе. Применяется для форм находящихся в PageControl-е }
  procedure CloseInParent;
   {* Попытаться закрыть форму во вкладке }
  procedure LockFocus;
  procedure UnlockFocus;
  procedure MakeAggregate;
  procedure RegInContainer;
  procedure UnregInContainer;
  function GetTabInfo(out theCaption: Il3CString;
   out theItemIndex: Integer): Boolean;
   {* Информация для закладки, в которую вставляется форма }
  procedure CheckFloatingVisibility;
  function NeedSaveToTabHistory: Boolean;
  function SaveStateForClone(out theState: IvcmBase;
   aStateType: TvcmStateType): Boolean;
  function LoadCloneState(const theState: IvcmBase;
   aStateType: TvcmStateType): Boolean;
  procedure BeforeHistoryNavigate;
  function IsBaloon: Boolean;
 end;//IvcmEntityForm
 
 IvcmAggregate = interface
  procedure AddEntity(const anEntity: IvcmEntity);
   {* Добавляет сущность в агрегацию }
  procedure RemoveEntity(const anEntity: IvcmEntity);
   {* удаляет сущность из агрегации }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): IvcmExecuteParams; overload;
  function Operation(const anOp: TvcmOPID): IvcmExecuteParams; overload;
  function HasForm(const aName: TvcmFormID;
   theForm: PIvcmEntityForm): Boolean;
   {* Проверяет, присутствует ли указанная форма в агрегации }
 end;//IvcmAggregate
 
 (*
 vcmEntitiesContainer = interface
 end;//vcmEntitiesContainer
 *)
 
 IvcmFormSetFactory = interface;
 
 IvcmFormSet = interface(IvcmAggregate)
  {* Сборка форм }
  procedure Refresh(const aParams: IvcmFormSetRefreshDataParams);
   {* обновляет представление сборки }
  procedure SaveHistory;
   {* сохраняет сборку в историю }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* является ли форма главной в сборке }
  function FindStatusInfoForm: IvcmEntityForm;
   {* найти форму отвечающую за вывод статуса }
  procedure PopToHistory;
   {* сборка помещена в историю }
  procedure PushFromHistory;
   {* сборка выгружена из истории }
  procedure AssignFormList(aFormList: TvcmFormSetFormList);
   {* Заполнить мапу форм / флажков в сборке }
  function GetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr): TvcmNeedMakeDS;
  procedure SetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr;
   aNeedMakeDS: TvcmNeedMakeDS);
  function CastFS(const aGUID: TGUID;
   out theObj): Boolean;
  procedure SetFormClosed(const aForm: IvcmEntityForm);
   {* Установить признак того, что форма была закрыта }
  procedure SetIfNeedMakeNo(const aFormDescr: TvcmFormSetFormItemDescr;
   aNeedMake: TvcmNeedMakeDS);
  procedure SaveFormList(aFormList: TvcmFormSetFormList);
  function MakeClone(const aContainer: IvcmContainer): IvcmFormSet;
 end;//IvcmFormSet
 
 TvcmSaveFormSetToHistory = (
  sfsNone
   {* сохранение форм не требуется }
  , sfsAllForms
   {* сохранять все формы }
  , sfsOnlyIfDataSourceChanged
   {* сохранять только изменившиеся формы }
 );//TvcmSaveFormSetToHistory
 
 IvcmFormSetRefreshDataParams = interface
 end;//IvcmFormSetRefreshDataParams
 
 IvcmEntityFormIterator = interface
  {* Итератор форм }
  function Next: IvcmEntityForm;
 end;//IvcmEntityFormIterator
 
 TvcmMainFormInfo = record
  {* информация о главной форме. }
 end;//TvcmMainFormInfo
 
 IvcmFormSetIterator = interface
  function Next: IvcmFormSet;
 end;//IvcmFormSetIterator
 
 IvcmAggregateIterator = interface
  function Next: IvcmAggregate;
 end;//IvcmAggregateIterator
 
 IvcmContainer = interface
  {* Контейнер форм }
  function NeedSetFocusToMainObjectFormOnRefresh: Boolean;
   {* Надо ли передвигать фокус в главную форму при изменении сборки }
  procedure SetTabCaption(const aTabCaption: IvcmCString);
  procedure InitFromPrevContainer(const aPrevContainer: IvcmContainer;
   aClone: Boolean);
  procedure RegForm(const aForm: IvcmEntityForm);
  procedure UnregForm(const aForm: IvcmEntityForm);
  function InsertForm(const aForm: IvcmEntityForm): Boolean;
   {* вставляет форму в контейнер }
  function HasForm(const aName: TvcmFormID;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   theForm: PIvcmEntityForm;
   aUserType: TvcmUserType;
   aGUID: PGUID;
   aSubUserType: TvcmUserType): Boolean; overload;
   {* проверяет есть ли в контейнере такая форма }
  function HasForm(aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   theForm: PIvcmEntityForm;
   aUserType: TvcmUserType;
   aGUID: PGUID;
   aSubUserType: TvcmUserType): Boolean; overload;
   {* проверяет есть ли в контейнере такая форма }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
   {* Выполнение операции по имени сущности }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams): Boolean; overload;
   {* Выполнение операции по имени сущности }
  function Operation(const anOp: TvcmOPID;
   aMode: TvcmOperationMode): Boolean; overload;
   {* Выполнение операции по имени сущности }
  function IsNull: Boolean;
  procedure FormStyle(const aForm: IvcmEntityForm;
   const aStyle: IvcmFormStyle);
   {* определим стиль формы }
  procedure SetFocusToMainObjectForm;
   {* устанавливаем фокус в самую вложенную форму указанной зоны }
  procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
   const anOld: IvcmFormDataSource;
   const aNew: IvcmFormDataSource);
   {* вызывается при изменении источника данных вложенной формы }
 end;//IvcmContainer
 
 IvcmParams = interface(IvcmBaseParamsPrim)
  {* Параметры операции }
  procedure SetContainerPrim(const aContainer: IvcmContainer;
   aReplace: Boolean);
 end;//IvcmParams
 
 IvcmEntity = interface
  {* Сущность }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmParams;
   aMode: TvcmOperationMode): Boolean; overload;
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams): Boolean; overload;
 end;//IvcmEntity
 
 IvcmHistoryItem = interface
  {* Элемент истории приложения }
  function Activate(const aMainForm: IvcmEntityForm): Boolean; overload;
  function Activate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean; overload;
  function Drop: Boolean;
  function IsAcceptable: Boolean;
   {* можно ли активизировать элемент истории в текущих условиях }
 end;//IvcmHistoryItem
 
 TvcmHistoryItemType = (
  {* Типы элемента истории. }
  vcm_hitNone
   {* обычный. }
  , vcm_hitClose
   {* содержит информацию о форме которая должна быть закрыта,
            предварительно сохранив данные существующей формы. }
  , vcm_hitContent
   {* содержит информацию о форме, которая должна быть создана, но после
           создания элемент должен перейти в состояние hitClose. }
 );//TvcmHistoryItemType
 
 IvcmContainerHistoryItem = interface(IvcmHistoryItem)
  function Add(const anItem: IvcmHistoryItem;
   aDelta: Integer): Boolean;
  function IsEmpty: Boolean;
  function ItemsCount: Integer;
  function GetItem(anIndex: Integer): IvcmHistoryItem;
 end;//IvcmContainerHistoryItem
 
 IvcmHistoryItems = interface;
 
 IvcmHistoryState = interface
 end;//IvcmHistoryState
 
 IvcmHistoryItems = interface
  function MakeClone: IvcmHistoryItems;
 end;//IvcmHistoryItems
 
 IvcmHistory = interface
  procedure DeleteBackItem;
   {* Удаляет один элемент из списка Back }
  function GetBackCount: Integer;
  function GetForwardCount: Integer;
  function GetBackItem(anIndex: Integer): Il3CString;
  function GetForwardItem(anIndex: Integer): Il3CString;
  procedure DeleteForwardItem;
   {* Удаляет один элемент из списка Forward }
  procedure ResetContainer;
  procedure SaveClone(const aForm: IvcmEntityForm);
  procedure BeforeFormDestroy(const aForm: IvcmEntityForm);
  function ForceSaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): Boolean;
   {* сохранение без проверки необходимости сохранения формы }
  function SaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): Boolean;
  procedure SaveClose(const aForm: IvcmEntityForm;
   const aFormID: TvcmFormID;
   aUserType: TvcmUserType;
   aZoneType: TvcmZoneType;
   aSubUserType: TvcmUserType);
   {* форма которая должна быть закрыта при переходе по истории }
  function HasInPreviousStep(const aFormClass: TvcmFormID;
   aUserType: TvcmUserType): Boolean;
  function Back(aTruncate: Boolean): Boolean; overload;
  function Forward: Boolean; overload;
  procedure Back(const aParams: IvcmExecuteParamsPrim;
   aTruncate: Boolean); overload;
  procedure Forward(const aParams: IvcmExecuteParamsPrim); overload;
  function CanBack: Boolean;
  function CanForward: Boolean;
  procedure GetBackStrings(const aParams: IvcmTestParamsPrim);
  procedure GetForwardStrings(const aParams: IvcmTestParamsPrim);
  procedure Start(const aSender: IvcmEntityForm;
   const aCaption: IvcmCString;
   aFormSet: Boolean);
  procedure Finish(const aSender: IvcmEntityForm);
  procedure AddForm(const aForm: IvcmEntityForm);
  procedure RemoveForm(const aForm: IvcmEntityForm);
  function Add(const anItem: IvcmHistoryItem): Boolean;
   {* добавляет запись в историю }
  function IsLast: Boolean;
  function InBack: Boolean;
   {* Находимся в процессе Back, если нет, то Forward }
  procedure Clear(aHeedCheckCurrent: Boolean);
   {* Очищает историю }
  function MakeState: IvcmHistoryState;
  procedure AssignState(const aState: IvcmHistoryState);
 end;//IvcmHistory
 
 IvcmLockListener = interface
  {* слушатель блокировок }
  procedure Lock;
   {* отрисовка запрещена }
  procedure BeforeUnlock;
   {* переходные процессы уже завершились, но отрисовка ещё запрещена }
  procedure Unlock;
   {* отрисовка разрешена }
 end;//IvcmLockListener
 
 IvcmMainFormProvider = interface;
 
 IvcmFormDispatcher = interface
  {* Диспетчер форм приложения }
  procedure AddForm(const aForm: IvcmEntityForm);
   {* добавить новую форму в приложение }
  procedure RemoveForm(const aForm: IvcmEntityForm);
   {* удалить форму из приложения }
  procedure ShowMainForm(const aForm: IvcmEntityForm);
   {* показать главную форму }
  procedure Lock;
  procedure UnLock;
  procedure BackupLockStatus;
  procedure RestoreLockStatus;
  function FindForm(const aGUID: TGUID;
   out theForm: IvcmEntityForm): Boolean;
  procedure AddFormForInvalidate(const aForm: IvcmEntityForm);
  procedure AddControlForInvalidate(aControl: TObject);
  procedure AddFormForUpdateActions(const aForm: IvcmEntityForm);
  procedure AddDockManager(const aDockManager: IDockManager);
  procedure AddLockListener(const aListener: IvcmLockListener);
  procedure RemoveLockListener(const aListener: IvcmLockListener);
  procedure UpdateMainCaption(const aForm: IvcmEntityForm);
  procedure AddToCloseQueue(const aForm: IvcmEntityForm);
  procedure PlaceNewMainForm(aSource: TCustomForm;
   aNew: TCustomForm);
   {* разместить новую главную форму.
             aSourceMainForm:
               - форма на которой вызвали создание новой }
  procedure StartNewMainForm;
   {* вызывается перед началом создания главной формы }
 end;//IvcmFormDispatcher
 
 IvcmMainFormProvider = interface
 end;//IvcmMainFormProvider
 
 IvcmModule = interface;
 
 IvcmEntityFormsIterable = interface;
 
 IvcmDispatcher = interface
  {* Диспетчер приложения }
  procedure BeginRestoreAllSettings;
  procedure EndRestoreAllSettings;
  procedure RestoreFormSize;
   {* перечитывает размер компонентов на форме (восстанавливает сначала
             размеры Design-Time, потом читает из настроек) }
  procedure ReloadAllToolbars;
   {* перезагружает информацию toolbar-ов у всех открытых в данный момент
             форм }
  function EntityOperation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
  procedure EntityOperation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams); overload;
  procedure EntityOperationBroadcast(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams);
  procedure CallModuleOperation(const anOp: TvcmMOPID;
   const aParams: IvcmExecuteParams);
   {* Выполняет операцию модуля. (!) Только для вызова изнутри VCM. Не для использования на формах }
  procedure ModuleOperation(const anOp: TvcmMOPID;
   const aParams: IvcmTestParams); overload;
   {* выполняет операцию модуля }
  function ModuleOperation(const anOp: TvcmMOPID): Boolean; overload;
   {* выполняет операцию модуля }
  function GetModuleByID(aModuleID: TvcmControlID): IvcmModule;
   {* возвращает модуль по идентификатору }
  procedure UpdateStatus;
  procedure AddAggregate(const anAggregate: IvcmAggregate);
  procedure RemoveAggregate(const anAggregate: IvcmAggregate);
  function FindAggregate(const aGUID: TGUID;
   out theAggregate: IvcmAggregate): Boolean;
  procedure StoreFocus;
  procedure RestoreFocus;
  procedure BeginOp(anInternal: Boolean);
  procedure EndOp;
  procedure StoreFocused(aHandle: THandle);
  function InOp(anInternal: Boolean): Boolean;
  procedure BeginCancelModal;
  procedure EndCancelModal;
  function InCancelModal: Boolean;
  procedure LockCursor;
  procedure UnlockCursor;
  procedure LockActionUpdate;
  procedure UnlockActionUpdate;
   {* блокировать OnTest-ы операций. Необходимо когда система находится в
             переходном состоянии и не все данные актуальны }
  procedure AddObjectForFree(O: TObject);
  procedure ReinsertForms;
   {* перечитывает значения форм }
  procedure TileWindowsHorizontal(const aForms: IvcmEntityFormsIterable);
   {* упорядочить открытые окна приложения горизонтально }
  procedure TileWindowsVertical(const aForms: IvcmEntityFormsIterable);
   {* упорядочить открытые окна приложения ветикально }
  procedure CascadeWindows(const aForms: IvcmEntityFormsIterable);
   {* расположить открытые окна каскадом }
  procedure CloseAllWindows(const aForms: IvcmEntityFormsIterable;
   const aCurrent: IvcmEntityForm);
   {* закрыть все открытые окна кроме текущего, если он не указан, то закрывается приложение }
  procedure LockInOp;
   {* Игнорируем скобки BeginOp/EndOp }
  procedure UnlockInOp;
   {* Игнорируем скобки BeginOp/EndOp }
 end;//IvcmDispatcher
 
 TvcmEntityOperationsOption = (
  {* для настройки сущностей }
  vcm_enoGroupItemsInContextMenu
   {* группировать элементы в контекстном меню }
 );//TvcmEntityOperationsOption
 
 TvcmEntityOperationsOptions = set of TvcmEntityOperationsOption;
 
 IvcmEntityDef = interface(IvcmOperationalIdentifiedUserFriendlyControl)
  {* Описание сущности }
 end;//IvcmEntityDef
 
 IvcmEntitiesDefIterator = interface
  {* Итератор описаний сущностей }
 end;//IvcmEntitiesDefIterator
 
 IvcmModuleDef = interface(IvcmOperationalIdentifiedUserFriendlyControl)
  function Make: IvcmModule;
   {* создает модуль }
 end;//IvcmModuleDef
 
 IvcmModule = interface
  {* Модуль (что он на самом деле олицетворяет - я и сам теперь не понимаю) }
  procedure Operation(anID: TvcmControlID;
   const aParams: IvcmParams;
   aMode: TvcmOperationMode);
   {* выполняет операцию модуля }
  function GetOperationByID(anID: TvcmControlID): IvcmOperationDef;
 end;//IvcmModule
 
 PIvcmEntityForm = ^IvcmEntityForm;
 
 TvcmInitProc = procedure(aForm: TWinControl);
 
 // TvcmEffectiveUserType
 
 TvcmFormSetID = object
  {* идентификатор сборки. }
 end;//TvcmFormSetID
 
 PvcmFormSetID = ^TvcmFormSetID;
 
 IvcmFormSetRefreshParams = interface(IvcmFormSetRefreshDataParams)
  {* Параметры обновления сборки }
 end;//IvcmFormSetRefreshParams
 
 IvcmFormSetSimpleFactory = interface;
 
 IvcmFormSetFactory = interface
  {* Фабрика сборки }
  procedure Refresh(const aParams: IvcmFormSetRefreshParams);
   {* обновляет данные сборки.
            aDataForHistory - данные aDataSource, которые необходимо сохранить
                              в историю }
  procedure SaveHistory(const aContainer: IvcmContainer;
   aNeedSaveUseCaseData: Boolean);
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* является ли форма главной в сборке }
  function IsDefaultStatusForm(const aForm: IvcmEntityForm): Boolean;
   {* является ли форма отвечающую за вывод статуса }
  function MakeMainCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function MakeMainImageIndex(const aDataSource: IvcmFormSetDataSource): Integer;
  function MakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function MakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function MakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function CloneFormSet(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer): IvcmFormSet;
  function GetSimpleFactory: IvcmFormSetSimpleFactory;
  function CanCloneFormSet(const aFormSet: IvcmFormSet): Boolean;
  function CanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean;
 end;//IvcmFormSetFactory
 
 TvcmEffectiveUserTypes = set of TvcmEffectiveUserType;
 
 IvcmEntityFormsIterable = interface
  procedure IterateFormsF(anAction: TvcmIteratorAction);
  procedure AddForm(const aForm: IvcmEntityForm);
 end;//IvcmEntityFormsIterable
 
 IvcmFormSetSimpleFactory = interface
  function MakeFormset(const aDataSource: IvcmFormSetDataSource;
   const aContainer: IvcmContainer;
   aSaveToHistory: Boolean;
   aLockSetFocusToMainObjectForm: Boolean;
   const aFormSetToClone: IvcmFormSet): IvcmFormSet;
 end;//IvcmFormSetSimpleFactory
 
 TvcmZoneTypes = set of TvcmZoneType;
  {* Набор типов доны докинга }
 
 // TvcmEffectiveZoneType
 
 TvcmEffectiveZoneTypes = set of TvcmEffectiveZoneType;
  {* множество типов реальных зон докинга }
 
 IvcmMakeParams = interface(IvcmBase)
 end;//IvcmMakeParams
 
 TvcmFormFactory = function(const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aUserType: TvcmEffectiveUserType;
  aGUID: PGUID;
  const aDataSource: IvcmFormDataSource;
  aSubUserType: TvcmUserType;
  aAfterCreate: TvcmInitProc): IvcmEntityForm of object;
  {* Фабрика формы VCM }
 
 TvcmUserTypeInfo = class
  function AllowCustomizeToolbars(const anUserType: IvcmUserTypeDef): Boolean;
  function IsCustomizationInternal(const anUserType: IvcmUserTypeDef): Boolean;
 end;//TvcmUserTypeInfo
 
 TvcmFormDescriptor = object
 end;//TvcmFormDescriptor
 
 IvcmResourceHolder = interface
  procedure ReleaseResources;
 end;//IvcmResourceHolder
 
 TvcmMainFormOpenKind = (
  {* Поведение при открытии новой главной формы }
  vcm_okInCurrentTab
   {* В текущей вкладке }
  , vcm_okInNewTab
   {* В новой вкладке }
  , vcm_okInNewWindow
   {* В новом окне }
 );//TvcmMainFormOpenKind
 
 IvcmContainerMaker = interface
  function MakeContainer: IvcmContainer;
 end;//IvcmContainerMaker
 
 IvcmFormSetIconProvider = interface
 end;//IvcmFormSetIconProvider
 
 IvcmSizeableForm = interface(IvcmBase)
 end;//IvcmSizeableForm
 
 IvcmForms = interface
 end;//IvcmForms
 
 PvcmFormDescriptor = ^TvcmFormDescriptor;
 
 IvcmFormSetCaptionProvider = interface(IvcmBase)
 end;//IvcmFormSetCaptionProvider
 
 IvcmMainMenuForChromeLike = interface(IvcmBase)
 end;//IvcmMainMenuForChromeLike
 
 IvcmContainedForm = interface
  procedure NotifyContainerIsClosing;
  procedure InitContainedForm;
  procedure SaveFocusedControl;
  procedure RestoreFocusedControl;
  function OpenNew(aOpenKind: TvcmMainFormOpenKind): IvcmContainedForm;
  procedure CloseContainedForm;
  procedure StartTabHistoryOperation;
  procedure FinishTabHistoryOperation;
 end;//IvcmContainedForm
 
 IvcmFormSetFormHistoryItem = interface
  function MakeForm(const aContainer: IvcmContainer;
   const aFormSet: IvcmFormSet;
   const aAggregate: IvcmAggregate;
   out aForm: IvcmEntityForm): Boolean;
 end;//IvcmFormSetFormHistoryItem
 
 IvcmFormSetHistoryItem = interface
  function GetItem(aIndex: Integer): IvcmFormSetFormHistoryItem;
  function MakeFormSet(const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet;
   aNeedAssignHistory: Boolean): Boolean;
 end;//IvcmFormSetHistoryItem
 
 IvcmFormSetHistoryStepItem = interface
  procedure Restore(const aContainer: IvcmContainer;
   const aFormSetToClone: IvcmFormSet;
   aNeedAssignHistory: Boolean);
 end;//IvcmFormSetHistoryStepItem
 
 IvcmFormSetHistoryStepItems = interface
  procedure Add(const anItem: IvcmFormSetHistoryStepItem);
  procedure Reset;
 end;//IvcmFormSetHistoryStepItems
 
 IvcmFormSetHistoryStep = interface(IvcmFormSetHistoryStepItems)
  procedure Restore(const aContainer: IvcmContainer;
   const aFormSetToClone: IvcmFormSet;
   aNeedAssignHistory: Boolean);
 end;//IvcmFormSetHistoryStep
 
 IvcmFormSetHistory = interface
  procedure Back(const aContainer: IvcmContainer);
  procedure CloneTab(const aTab: Il3FormTab);
  procedure SaveTab(const aTab: Il3FormTab);
  function CanBack: Boolean;
  function IsContainerInOp(const aContainer: IvcmContainer): Boolean;
 end;//IvcmFormSetHistory
 
 PIvcmFormSet = ^IvcmFormSet;
 
 IvcmSelectedTabDependent = Il3SelectedTabDependent;
 
implementation

uses
 l3ImplUses
 , afwFacade
 , SysUtils
;

end.
