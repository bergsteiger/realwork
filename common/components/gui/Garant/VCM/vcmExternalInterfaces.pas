unit vcmExternalInterfaces;
 {* Интерфейсы для взаимодействия с другими библиотеками. }

// Модуль: "w:\common\components\gui\Garant\VCM\vcmExternalInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "vcmExternalInterfaces" MUID: (467BAB7F021E)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , afwInterfaces
 , l3TreeInterfaces
 , l3Core
 , l3PureMixIns
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 IvcmBase = interface
  {* Базовый интерфес. Введен для общности. }
  ['{2F621927-A8BB-4C2D-95FB-5E4A3FF59633}']
 end;//IvcmBase

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

 IvcmState = interface(IvcmBase)
  ['{16FBEE65-C63E-4EE1-849C-6C81E4F6B7D4}']
  function SaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadState(const theState: IUnknown;
   aStateType: TvcmStateType;
   aClone: Boolean): Boolean;
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
  rEnID: TvcmControlID;
   {* Сущность. }
  rOpID: TvcmControlID;
   {* Операция. }
 end;//TvcmOPID

 TvcmMOPID = record
  {* Идентификатор операции модуля. }
  rMoID: TvcmControlID;
   {* Модуль. }
  rOpID: TvcmControlID;
   {* Операция }
 end;//TvcmMOPID

 TvcmOpKind = (
  vcm_okNone
  , vcm_okModule
  , vcm_okEntity
 );//TvcmOpKind

 TvcmOpSelector = record
  Case rKind: TvcmOpKind of
   vcm_okModule: (rMID: TvcmMOPID);
   vcm_okEntity: (rID: TvcmOPID);
 end;//TvcmOpSelector

 IvcmItems = interface(IvcmStrings)
  {* Список элементов для выбора. }
  ['{EB667E06-C2AA-46F4-B112-5AA6A8E5D849}']
  function pm_GetOp(anIndex: Integer): TvcmOpSelector;
  function AddOp(const anOp: TvcmOpSelector;
   const aCap: IvcmCString = nil;
   anObj: TObject = nil): Integer; overload;
  function AddOp(const anOp: TvcmOPID;
   const aCap: IvcmCString = nil;
   anObj: TObject = nil): Integer; overload;
  function AddOp(const anOp: TvcmMOPID;
   const aCap: IvcmCString = nil;
   anObj: TObject = nil): Integer; overload;
  property Op[anIndex: Integer]: TvcmOpSelector
   read pm_GetOp;
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

 //_ItemType_ = IvcmNode;
 IvcmNodes = interface(IvcmBase)
  {* Ноды для построения меню операции. }
  ['{087BD09D-2EBD-4305-9300-A7872C1B0AE9}']
  function Get_PlainLevel: Integer;
  procedure Set_PlainLevel(aValue: Integer);
  function Get_ShowRoot: Boolean;
  procedure Set_ShowRoot(aValue: Boolean);
  function Get_Current: IvcmNode;
  procedure Set_Current(const aValue: IvcmNode);
  function Get_Tree: IvcmTree;
  procedure Set_Tree(const aValue: IvcmTree);
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: IvcmNode;
  function pm_GetLast: IvcmNode;
  function pm_GetItems(anIndex: Integer): IvcmNode;
  function pm_GetCount: Integer;
  procedure Clear;
   {* Очищает список. }
  function Add(const anItem: IvcmNode): Integer;
   {* Добавляет ноду в список. }
  property PlainLevel: Integer
   read Get_PlainLevel
   write Set_PlainLevel;
  property ShowRoot: Boolean
   read Get_ShowRoot
   write Set_ShowRoot;
  property Current: IvcmNode
   read Get_Current
   write Set_Current;
   {* Текущая нода. }
  property Tree: IvcmTree
   read Get_Tree
   write Set_Tree;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: IvcmNode
   read pm_GetFirst;
   {* Первый элемент. }
  property Last: IvcmNode
   read pm_GetLast;
   {* Последний элемент. }
  property Items[anIndex: Integer]: IvcmNode
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* Число элементов. }
 end;//IvcmNodes

 IvcmBaseParamsPrim = interface(IvcmBase)
  ['{3431206A-F8DC-4E11-A486-446A7AF873C2}']
  function Get_Control: TComponent;
  procedure Set_Control(aValue: TComponent);
  function Get_Target: IUnknown;
  procedure Set_Target(const aValue: IUnknown);
  function pm_GetOperationType: TvcmOperationType;
  procedure pm_SetOperationType(aValue: TvcmOperationType);
  function Get_Done: Boolean;
  function Get_DoneStatus: TvcmDoneStatus;
  procedure Set_DoneStatus(aValue: TvcmDoneStatus);
  function CallControl: Boolean;
  property Control: TComponent
   read Get_Control
   write Set_Control;
  property Target: IUnknown
   read Get_Target
   write Set_Target;
  property OperationType: TvcmOperationType
   read pm_GetOperationType
   write pm_SetOperationType;
   {* тип операции для которой эти операции сформированны. }
  property Done: Boolean
   read Get_Done;
   {* Признак обработанности списка параметров. }
  property DoneStatus: TvcmDoneStatus
   read Get_DoneStatus
   write Set_DoneStatus;
   {* Признак обработанности списка параметров. }
 end;//IvcmBaseParamsPrim

 IvcmOpParams = interface(IvcmBase)
  {* Параметры операции. }
  ['{953E889F-A018-40FA-A616-B62B351050F2}']
  function Get_ImageIndex: Integer;
  procedure Set_ImageIndex(aValue: Integer);
  function Get_ShortCut: Integer;
  procedure Set_ShortCut(aValue: Integer);
  function Get_SelectedString: IvcmCString;
  procedure Set_SelectedString(const aValue: IvcmCString);
  function Get_SubItems: IvcmItems;
  procedure Set_SubItems(const aValue: IvcmItems);
  function Get_SubNodes: IvcmNodes;
  procedure Set_SubNodes(const aValue: IvcmNodes);
  function Get_Font: IvcmFont;
  procedure Set_Font(const aValue: IvcmFont);
  function Get_Caption: IvcmCString;
  procedure Set_Caption(const aValue: IvcmCString);
  function Get_Hint: IvcmCString;
  procedure Set_Hint(const aValue: IvcmCString);
  function Get_LongHint: IvcmCString;
  procedure Set_LongHint(const aValue: IvcmCString);
  function Get_Flag(anIndex: TvcmOpFlag): Boolean;
  procedure Set_Flag(anIndex: TvcmOpFlag;
   aValue: Boolean);
  function HasSubItems: Boolean;
  function HasSubNodes: Boolean;
  function HasFont: Boolean;
  property ImageIndex: Integer
   read Get_ImageIndex
   write Set_ImageIndex;
  property ShortCut: Integer
   read Get_ShortCut
   write Set_ShortCut;
  property SelectedString: IvcmCString
   read Get_SelectedString
   write Set_SelectedString;
  property SubItems: IvcmItems
   read Get_SubItems
   write Set_SubItems;
  property SubNodes: IvcmNodes
   read Get_SubNodes
   write Set_SubNodes;
  property Font: IvcmFont
   read Get_Font
   write Set_Font;
   {* Шрифт. }
  property Caption: IvcmCString
   read Get_Caption
   write Set_Caption;
  property Hint: IvcmCString
   read Get_Hint
   write Set_Hint;
  property LongHint: IvcmCString
   read Get_LongHint
   write Set_LongHint;
  property Flag[anIndex: TvcmOpFlag]: Boolean
   read Get_Flag
   write Set_Flag;
   {* Флаги операции. }
 end;//IvcmOpParams

 IvcmRealExecuteParams = interface(IvcmBaseParamsPrim)
  ['{66CFE94A-511B-4E02-A128-494F407ADACF}']
  function Get_ItemIndex: Integer;
  procedure Set_ItemIndex(aValue: Integer);
  function Get_CurrentNode: IvcmNode;
  procedure Set_CurrentNode(const aValue: IvcmNode);
  function Get_SelectedString: IvcmCString;
  procedure Set_SelectedString(const aValue: IvcmCString);
  property ItemIndex: Integer
   read Get_ItemIndex
   write Set_ItemIndex;
  property CurrentNode: IvcmNode
   read Get_CurrentNode
   write Set_CurrentNode;
  property SelectedString: IvcmCString
   read Get_SelectedString
   write Set_SelectedString;
 end;//IvcmRealExecuteParams

 IvcmExecuteParamsPrim = IvcmRealExecuteParams;

 IvcmTestParamsPrim = interface(IvcmBaseParamsPrim)
  ['{BE9F2D7D-185C-4F85-BDA6-0E76C48EE574}']
  function Get_Op: IvcmOpParams;
  property Op: IvcmOpParams
   read Get_Op;
 end;//IvcmTestParamsPrim

 TvcmControlEvent = procedure(const aParams: IvcmExecuteParamsPrim) of object;

 IvcmFlexParams = interface(IvcmRealExecuteParams)
  {* Параметры операции. }
  ['{6824C4ED-DA13-44B7-AE30-9902632C1FBA}']
 end;//IvcmFlexParams

 TvcmControlTestEvent = procedure(const aParams: IvcmTestParamsPrim) of object;
  {* Вызывается в момент проверки доступности операции из главного меню }

 IvcmToolbarNotifier = interface(IvcmBase)
  {* интерфейс используется для уведомления компонента зоны vcm_ztNavigator
       о размере toolbar-а с маленькими иконками и компонентами TvcmDateEdit,
       TvcmEdit. }
  ['{701DCDE5-10B8-4A3B-A8BF-92014A9A0100}']
  procedure SmallToolbarSize(aValue: Integer);
 end;//IvcmToolbarNotifier

 IvcmDockType = interface(IvcmBase)
  {* тип докинга (для ZonesCollectionItem.IsControlPanel) }
  ['{ADB055B7-59E8-4EFA-8CDA-5DD4CBE2B983}']
  function Get_ControlIsPanel: Boolean;
  property ControlIsPanel: Boolean
   read Get_ControlIsPanel;
 end;//IvcmDockType

 IvcmPopupIgnoresAction = interface(IvcmBase)
  ['{572DC1D0-2CC9-479F-9C9D-43756BF38F2E}']
  function pm_GetPopupIgnoresAction: Boolean;
  property PopupIgnoresAction: Boolean
   read pm_GetPopupIgnoresAction;
 end;//IvcmPopupIgnoresAction

 IvcmSettingsUser = interface(IvcmBase)
  ['{B3FE4095-4F87-42BA-AD1C-101BBA3C527A}']
  procedure WriteBackSettings;
 end;//IvcmSettingsUser

 TvcmControlExecuteEvent = TvcmControlEvent;
  {* Вызывается при выполнении операции из главного меню. }

 TvcmControlGetTargetEvent = function(const aPt: TPoint;
  out theTarget: IUnknown): Boolean of object;

 TvcmOperationStateIndex = record
  rID: Integer;
 end;//TvcmOperationStateIndex

 IvcmAction = interface(IvcmBase)
  ['{ACDFCCF3-A2C1-4666-80FA-1F5A69B496C8}']
  function pm_GetIsDefault: Boolean;
  procedure pm_SetIsDefault(aValue: Boolean);
  function pm_GetFont: IvcmFont;
  function pm_GetSubNodes: IvcmNodes;
  function pm_GetHint: IvcmCString;
  procedure pm_SetHint(const aValue: IvcmCString);
  function pm_GetSubItems: IvcmItems;
  function pm_GetSelectedString: IvcmCString;
  procedure pm_SetSelectedString(const aValue: IvcmCString);
  function pm_GetIsSelectedStringChanged: Boolean;
  function pm_GetCaption: IvcmCString;
  procedure pm_SetCaption(const aValue: IvcmCString);
  function pm_GetIsStringsChanged: Boolean;
  procedure LockUpdate;
  procedure UnlockUpdate;
  procedure Execute;
  function IsExecuteLocked: Boolean;
  procedure UnlockExecute;
  procedure LockExecute;
  function HasInfoForCombo: Boolean;
  procedure SaveStrings;
   {* сохраняет текущее значение строк. }
  property IsDefault: Boolean
   read pm_GetIsDefault
   write pm_SetIsDefault;
  property Font: IvcmFont
   read pm_GetFont;
   {* Шрифт. }
  property SubNodes: IvcmNodes
   read pm_GetSubNodes;
  property Hint: IvcmCString
   read pm_GetHint
   write pm_SetHint;
  property SubItems: IvcmItems
   read pm_GetSubItems;
  property SelectedString: IvcmCString
   read pm_GetSelectedString
   write pm_SetSelectedString;
   {* содержит выбранное при выполнении действия значение. }
  property IsSelectedStringChanged: Boolean
   read pm_GetIsSelectedStringChanged;
   {* изменилась ли выбранное значение. }
  property Caption: IvcmCString
   read pm_GetCaption
   write pm_SetCaption;
  property IsStringsChanged: Boolean
   read pm_GetIsStringsChanged;
   {* проверяет изменилось значение строк. }
 end;//IvcmAction

 IvcmActionLink = interface(IvcmBase)
  ['{BFEEFBEF-3036-4141-B77C-8196E2083F2B}']
  procedure ParamsChanged(const anAction: IvcmAction);
  procedure ParamsChanging(const anAction: IvcmAction);
 end;//IvcmActionLink

 IvcmSettings = IafwSettings;

 IvcmResources = IafwResources;

 IvcmSettingsSource = IafwSettingsSource;

 TvcmSettingId = TafwSettingId;

 IvcmFormHandler = interface(IvcmBase)
  {* Обработчик формы. }
  ['{8708F998-5844-4B4B-9980-AE9A4E04729F}']
  function Get_Form: TCustomForm;
  function Get_Handler: TNotifyEvent;
  function Get_Hint: IvcmCString;
  function CanHaveCloseButtonInNavigator: Boolean;
  function CanHaveOwnCloseButtonInNavigator: Boolean;
  property Form: TCustomForm
   read Get_Form;
   {* Форма обработчика. }
  property Handler: TNotifyEvent
   read Get_Handler;
   {* Обработчик формы. }
  property Hint: IvcmCString
   read Get_Hint;
   {* Подсказка к обработчику. }
 end;//IvcmFormHandler

 IvcmFormHandlersPublisher = interface(IvcmBase)
  {* Спецификация объекта, который публикует обработчики формы. }
  ['{674F0DBD-8D5E-4A7B-A9F7-A82CB0885E43}']
  procedure Publish(const aCloseHandler: IvcmFormHandler);
 end;//IvcmFormHandlersPublisher

 TvcmControlGetStateEvent = procedure(var State: TvcmOperationStateIndex) of object;
  {* Обработчик события для определения состояния операции }

 IvcmCloseFormHandlerWatcher = interface(IvcmBase)
  {* Приглядывающий за обработчиком закрытия формы }
  ['{E7A13C9D-18E7-4F69-84DC-D519550692AF}']
  procedure SetWatch(const aHandler: IvcmFormHandler);
 end;//IvcmCloseFormHandlerWatcher

 IvcmOperationsPublisher = interface(IvcmBase)
  {* Контрол представляющий операции пользователю. }
  ['{BB2697B6-0966-4857-828B-FA4F4BA78109}']
  procedure PublishEntity(const anEntity: TvcmString;
   aGetTarget: TvcmControlGetTargetEvent);
   {* опубликовать сущность. }
  procedure PublishOp(const anEntity: TvcmString;
   const anOperation: TvcmString;
   anExecute: TvcmControlExecuteEvent = nil;
   aTest: TvcmControlTestEvent = nil;
   aGetState: TvcmControlGetStateEvent = nil;
   aNoPrefix: Boolean = False);
   {* Опубликовать операцию. aNoPrefix - костыль для [$133891300] }
 end;//IvcmOperationsPublisher

 IvcmOperationsProvider = interface(IvcmBase)
  {* Контрол с поддержкой операций. }
  ['{BD5A4AF8-9AC8-4411-9AFB-E60098B21373}']
  procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
   {* предоставить список доступных операций. }
 end;//IvcmOperationsProvider

 IvcmDatasourceChangeListener = interface(IvcmBase)
  ['{4ED370FF-415E-4620-9B94-2EDA86F89988}']
  procedure DataSourceChanged(aControl: TControl);
 end;//IvcmDatasourceChangeListener

 IvcmComponentWithAction = interface(IvcmBase)
  ['{8E3276DA-3A8F-4D13-90B9-102C8EA45E28}']
  function Get_EntityName: AnsiString;
  procedure Set_EntityName(const aValue: AnsiString);
  function Get_OperationName: AnsiString;
  procedure Set_OperationName(const aValue: AnsiString);
  function Get_Action: TCustomAction;
  procedure Set_Action(aValue: TCustomAction);
  function Get_Hint: AnsiString;
  procedure Set_Hint(const aValue: AnsiString);
  function Get_Caption: AnsiString;
  procedure Set_Caption(const aValue: AnsiString);
  function Get_Visible: Boolean;
  procedure Set_Visible(aValue: Boolean);
  function GetParentForm: TComponent;
  function GetComponent: TComponent;
  property EntityName: AnsiString
   read Get_EntityName
   write Set_EntityName;
  property OperationName: AnsiString
   read Get_OperationName
   write Set_OperationName;
  property Action: TCustomAction
   read Get_Action
   write Set_Action;
  property Hint: AnsiString
   read Get_Hint
   write Set_Hint;
  property Caption: AnsiString
   read Get_Caption
   write Set_Caption;
  property Visible: Boolean
   read Get_Visible
   write Set_Visible;
 end;//IvcmComponentWithAction

 IvcmComponentContainer = interface(IvcmBase)
  ['{B8F103A1-FA45-4FDD-B6A4-F623EA089B56}']
  function Get_Count: Integer;
  function Get_OwnedComponent(aIndex: Integer): TComponent;
  property Count: Integer
   read Get_Count;
  property OwnedComponent[aIndex: Integer]: TComponent
   read Get_OwnedComponent;
 end;//IvcmComponentContainer

{$If Defined(Nemesis)}
 IvcmFlashingWindow = interface(IvcmBase)
  ['{18DC2344-959D-4854-A58E-84080F09D788}']
  procedure StartFlashing;
  procedure StopFlashing;
 end;//IvcmFlashingWindow
{$IfEnd} // Defined(Nemesis)

 IvcmMainFormDependent = interface(IvcmBase)
  ['{3395E902-086E-47B0-874E-BC39562D6D14}']
  procedure MainFormChanged(aForm: TControl);
   {* Вызывается при измении главной формы }
 end;//IvcmMainFormDependent

 IvcmCloneableState = interface(IvcmBase)
  ['{D1968E93-A54D-4375-B9EE-5E8898DE352A}']
  function SaveStateForClone(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadCloneState(const aState: IUnknown;
   aStateType: TvcmStateType): Boolean;
 end;//IvcmCloneableState
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
