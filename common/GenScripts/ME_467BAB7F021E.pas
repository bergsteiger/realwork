unit vcmExternalInterfaces;

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 , afwInterfaces
 , l3Interfaces
 , l3PureMixIns
 , l3Core
 , Forms
 , Classes
 , Controls
 , ActnList
;

type
 TvcmControlID = Integer;
  {* Тип идентификатора управляющего элемента. }
 
 IvcmNode = Il3SimpleNode;
 
 TvcmStateType = (
  {* Определяет тип хранимой для формы информации в элементе истории. }
  vcm_stContent
   {* данные формы. }
  , vcm_stPosition
   {* меняется только позиция в данных формы. }
 );//TvcmStateType
 
 IvcmCString = IafwCString;
  {* Атомарная строка с поддержкой различных кодировок }
 
 TvcmOperationType = (
  {* Тип представления операции. }
  vcm_otButton
   {* Операция стандартного вида. Представляется как
                       строка в меню и кнопка на панели инструментов. }
  , vcm_otShortCut
  , vcm_otTextButton
  , vcm_otButtonCombo
  , vcm_otButtonPopup
  , vcm_otCheck
   {* Операция с возможностью пометки. Отображается как
                       строка с пометкой в меню. }
  , vcm_otRadio
  , vcm_otEdit
  , vcm_otTyper
  , vcm_otCombo
   {* Выпадающий список строк. В меню отображается как
                       подменю, на панели инструментов - как выпадающий
                       список строк. }
  , vcm_otMenuButtonCombo
  , vcm_otEditCombo
  , vcm_otFontName
   {* Выпадающий список имен шрифтов. В меню
                       отображается как подменю, на панели инструментов -
                       как выпадающий список строк. }
  , vcm_otFontSize
   {* Выпадающий список размеров шрифтов. В меню
                       отображается как подменю, на панели инструментов -
                       как выпадающий список строк. }
  , vcm_otDate
  , vcm_otInternal
   {* Внутренняя операции сущности. Не отображается ни в меню, ни на панели инструментов. Кандидат на удаление }
  , vcm_otHidden
 );//TvcmOperationType
 
 TvcmString = AnsiString;
 
 IvcmState = interface
  function SaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadState(const theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
 end;//IvcmState
 
 TvcmDoneStatus = (
  {* Статус выполнения операции. }
  vcm_dsNotDone
   {* не выполнено }
  , vcm_dsDisabled
   {* операция запрещена (Disabled) }
  , vcm_dsInvalidParams
   {* неверный набор параметров }
  , vcm_dsSkippedInTest
   {* разрежен OnTest - сейчас такого нету }
  , vcm_dsExcludedInUserType
   {* запрещена в данном UserType'у }
  , vcm_dsNoAggregate
   {* нет агрегации }
  , vcm_dsNoEntity
   {* нет такой сущности }
  , vcm_dsFormInClose
   {* форма закрывается }
  , vcm_dsNullContainer
   {* операция пришла псевдо-контейнеру }
  , vcm_dsDone
   {* операция выполнена }
 );//TvcmDoneStatus
 
 IvcmStrings = IafwStrings;
  {* Список строк. }
 
 TvcmOPID = record
  {* Идентификатор операции сущности }
 end;//TvcmOPID
 
 IvcmBase = interface
  {* Базовый интерфес. Введен для общности. }
 end;//IvcmBase
 
 TvcmMOPID = record
  {* Идентификатор операции модуля. }
 end;//TvcmMOPID
 
 TvcmOpKind = (
  vcm_okNone
  , vcm_okModule
  , vcm_okEntity
 );//TvcmOpKind
 
 TvcmOpSelector = record
 end;//TvcmOpSelector
 
 IvcmItems = interface(IvcmStrings)
  {* Список элементов для выбора. }
  function AddOp(const anOp: TvcmOpSelector;
   const aCap: IvcmCString;
   anObj: TObject): Integer; overload;
  function AddOp(const anOp: TvcmOPID;
   const aCap: IvcmCString;
   anObj: TObject): Integer; overload;
  function AddOp(const anOp: TvcmMOPID;
   const aCap: IvcmCString;
   anObj: TObject): Integer; overload;
 end;//IvcmItems
 
 IvcmTree = Il3SimpleTree;
  {* Дерево. }
 
 IvcmFont = IafwFont;
  {* Шрифт. }
 
 TvcmOpFlag = (
  {* Свойство операции. }
  vcm_ofEnabled
  , vcm_ofVisible
  , vcm_ofChecked
  , vcm_ofDefault
 );//TvcmOpFlag
 
 IvcmNodes = interface
  {* Ноды для построения меню операции. }
  procedure Clear;
   {* Очищает список. }
  function Add(const anItem: IvcmNode): Integer;
   {* Добавляет ноду в список. }
 end;//IvcmNodes
 
 IvcmBaseParamsPrim = interface
  function CallControl: Boolean;
 end;//IvcmBaseParamsPrim
 
 IvcmOpParams = interface
  {* Параметры операции. }
  function HasSubItems: Boolean;
  function HasSubNodes: Boolean;
  function HasFont: Boolean;
 end;//IvcmOpParams
 
 IvcmRealExecuteParams = interface(IvcmBaseParamsPrim)
 end;//IvcmRealExecuteParams
 
 IvcmExecuteParamsPrim = IvcmRealExecuteParams;
 
 IvcmTestParamsPrim = interface(IvcmBaseParamsPrim)
 end;//IvcmTestParamsPrim
 
 TvcmControlEvent = procedure(const aParams: IvcmExecuteParamsPrim) of object;
 
 IvcmFlexParams = interface(IvcmRealExecuteParams)
  {* Параметры операции. }
 end;//IvcmFlexParams
 
 TvcmControlTestEvent = procedure(const aParams: IvcmTestParamsPrim) of object;
  {* Вызывается в момент проверки доступности операции из главного меню }
 
 IvcmToolbarNotifier = interface
  {* интерфейс используется для уведомления компонента зоны vcm_ztNavigator
       о размере toolbar-а с маленькими иконками и компонентами TvcmDateEdit,
       TvcmEdit. }
  procedure SmallToolbarSize(aValue: Integer);
 end;//IvcmToolbarNotifier
 
 IvcmDockType = interface
  {* тип докинга (для ZonesCollectionItem.IsControlPanel) }
 end;//IvcmDockType
 
 IvcmPopupIgnoresAction = interface
 end;//IvcmPopupIgnoresAction
 
 IvcmSettingsUser = interface
  procedure WriteBackSettings;
 end;//IvcmSettingsUser
 
 TvcmControlExecuteEvent = TvcmControlEvent;
  {* Вызывается при выполнении операции из главного меню. }
 
 TvcmControlGetTargetEvent = function(const aPt: TPoint;
  out theTarget: IUnknown): Boolean of object;
 
 TvcmOperationStateIndex = record
 end;//TvcmOperationStateIndex
 
 IvcmAction = interface
  procedure LockUpdate;
  procedure UnlockUpdate;
  procedure Execute;
  function IsExecuteLocked: Boolean;
  procedure UnlockExecute;
  procedure LockExecute;
  function HasInfoForCombo: Boolean;
  procedure SaveStrings;
   {* сохраняет текущее значение строк. }
 end;//IvcmAction
 
 IvcmActionLink = interface
  procedure ParamsChanged(const anAction: IvcmAction);
  procedure ParamsChanging(const anAction: IvcmAction);
 end;//IvcmActionLink
 
 IvcmSettings = IafwSettings;
 
 IvcmResources = IafwResources;
 
 IvcmSettingsSource = IafwSettingsSource;
 
 TvcmSettingId = TafwSettingId;
 
 IvcmFormHandler = interface
  {* Обработчик формы. }
  function CanHaveCloseButtonInNavigator: Boolean;
  function CanHaveOwnCloseButtonInNavigator: Boolean;
 end;//IvcmFormHandler
 
 IvcmFormHandlersPublisher = interface
  {* Спецификация объекта, который публикует обработчики формы. }
  procedure Publish(const aCloseHandler: IvcmFormHandler);
 end;//IvcmFormHandlersPublisher
 
 TvcmControlGetStateEvent = procedure(var State: TvcmOperationStateIndex) of object;
  {* Обработчик события для определения состояния операции }
 
 IvcmCloseFormHandlerWatcher = interface
  {* Приглядывающий за обработчиком закрытия формы }
  procedure SetWatch(const aHandler: IvcmFormHandler);
 end;//IvcmCloseFormHandlerWatcher
 
 IvcmOperationsPublisher = interface
  {* Контрол представляющий операции пользователю. }
  procedure PublishEntity(const anEntity: TvcmString;
   aGetTarget: TvcmControlGetTargetEvent);
   {* опубликовать сущность. }
  procedure PublishOp(const anEntity: TvcmString;
   const anOperation: TvcmString;
   anExecute: TvcmControlExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent;
   aNoPrefix: Boolean);
   {* Опубликовать операцию. aNoPrefix - костыль для [$133891300] }
 end;//IvcmOperationsPublisher
 
 IvcmOperationsProvider = interface
  {* Контрол с поддержкой операций. }
  procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
   {* предоставить список доступных операций. }
 end;//IvcmOperationsProvider
 
 IvcmDatasourceChangeListener = interface
  procedure DataSourceChanged(aControl: TControl);
 end;//IvcmDatasourceChangeListener
 
 IvcmComponentWithAction = interface
  function GetParentForm: TComponent;
  function GetComponent: TComponent;
 end;//IvcmComponentWithAction
 
 IvcmComponentContainer = interface
 end;//IvcmComponentContainer
 
 IvcmFlashingWindow = interface
  procedure StartFlashing;
  procedure StopFlashing;
 end;//IvcmFlashingWindow
 
 IvcmMainFormDependent = interface(IvcmBase)
  procedure MainFormChanged(aForm: TControl);
   {* Вызывается при измении главной формы }
 end;//IvcmMainFormDependent
 
 IvcmCloneableState = interface
  function SaveStateForClone(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadCloneState(const aState: IUnknown;
   aStateType: TvcmStateType): Boolean;
 end;//IvcmCloneableState
 
implementation

uses
 l3ImplUses
;

end.
