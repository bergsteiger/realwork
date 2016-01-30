unit vcmInterfaces;
 {* Базовые интерфейсы. }

// Модуль: "w:\common\components\gui\Garant\VCM\vcmInterfaces.pas"
// Стереотип: "InternalInterfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 , vcmBaseTypes
 , l3Interfaces
 , afwInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Core
 , vcmFormSetFormItemList
 , vcmUserControls
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
 , vcmFormDispatcherInterfaces
 , Classes
 , l3TabbedContainersDispatcher
;

const
 {* Идентификаторы контролов. }
 vcm_cidEmpty = TvcmControlID(0);
  {* Пустой идентификтор управляющего объекта. }
 cNullWeight = -1;
  {* cNullWeight - не установленный вес }
 vcm_utAny = vcmBaseTypes.vcm_utAny;
  {* любой пользовательский тип. }
 vcm_DefaultOperationState: TvcmOperationStateIndex = (rID : -1);
 {* Алиасы для значений vcmBaseTypes.TvcmZoneType }
 vcm_ztAny = vcmBaseTypes.vcm_ztAny;
 vcm_ztMain = vcmBaseTypes.vcm_ztMain;
 vcm_ztNavigator = vcmBaseTypes.vcm_ztNavigator;
 vcm_ztParent = vcmBaseTypes.vcm_ztParent;
 vcm_ztChild = vcmBaseTypes.vcm_ztChild;
 vcm_ztReminder = vcmBaseTypes.vcm_ztReminder;
 vcm_ztFloating = vcmBaseTypes.vcm_ztFloating;
 vcm_ztModal = vcmBaseTypes.vcm_ztModal;
 vcm_ztManualModal = vcmBaseTypes.vcm_ztManualModal;
 vcm_ztForToolbarsInfo = vcmBaseTypes.vcm_ztForToolbarsInfo;
 vcm_ztSimpleFloat = vcmBaseTypes.vcm_ztSimpleFloat;
 vcm_ztMainObjectForm = vcmBaseTypes.vcm_ztMainObjectForm;
 vcm_ztForFocus = vcmBaseTypes.vcm_ztForFocus;

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
  ['{519F45D2-92C3-4312-A8BA-15CC5E79E1B2}']
  function Clone: IvcmData;
   {* сделать копию }
 end;//IvcmData

 IvcmObjectWithData = interface
  {* Объект с данными }
  ['{8B787E25-8F5C-4D3D-9F96-A6F494CF4910}']
  function pm_GetDataForSave: IvcmData;
  procedure pm_SetDataForSave(const aValue: IvcmData);
  property DataForSave: IvcmData
   read pm_GetDataForSave
   write pm_SetDataForSave;
   {* данные необходимые сборки храняться отдельно, потому что состоние сборки может в определенные моменты времени сохраняться }
 end;//IvcmObjectWithData

 TvcmTestEvent = procedure(const aParams: IvcmTestParamsPrim) of object;
  {* Вызывается в момент проверки доступности операции из главного меню. }

 TvcmStatusStrings = TafwStatusInfo;

 IvcmBase = vcmExternalInterfaces.IvcmBase;

 (*
 MvcmEntityFormState = interface
  function Get_VCMClosing: Boolean;
  function IsBaloon: Boolean;
  property VCMClosing: Boolean
   read Get_VCMClosing;
 end;//MvcmEntityFormState
 *)

 (*
 MvcmLayout = interface
  function Get_VCLWinControl: TWinControl;
  function IsAcceptable(aDataUpdate: Boolean): Boolean;
   {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
  property VCLWinControl: TWinControl
   read Get_VCLWinControl;
 end;//MvcmLayout
 *)

 IvcmLayout = interface
  ['{2540CD94-01DC-49C1-9BA8-749631163C9B}']
  function Get_VCLWinControl: TWinControl;
  function IsAcceptable(aDataUpdate: Boolean): Boolean;
   {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
  property VCLWinControl: TWinControl
   read Get_VCLWinControl;
 end;//IvcmLayout

 TvcmFormID = vcmBaseTypes.TvcmFormID;
  {* Идентификатор формы. }

 TvcmZoneType = vcmBaseTypes.TvcmZoneType;

 IvcmContainer = interface;

 IvcmParams = interface;

 IvcmTestParams = interface(IvcmTestParamsPrim)
  ['{2E888E67-0D8C-4382-A211-D7E9836C3317}']
  function Get_Container: IvcmContainer;
  function BasePart: IvcmParams;
  procedure SetControlEvent(anEvent: TvcmControlTestEvent);
  property Container: IvcmContainer
   read Get_Container;
 end;//IvcmTestParams

 IvcmFormSetDataSource = interface;

 IvcmEntityForm = interface;

 IvcmFormDataSource = interface(Il3ChangeNotifier)
  {* Бизнес объект формы }
  ['{1EA49D91-5C33-490E-9108-C51B3E7C39E6}']
  function pm_GetUseCaseController: IvcmFormSetDataSource;
  function Get_DisplayName: IvcmCString;
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
   NeedsException: Boolean = False): Boolean;
   {* Приводит контроллер прецедента к заданному интерфейсу. Это нужно, чтобы избавится от явного знания о контроллере прецедента. [$122674504] }
  property UseCaseController: IvcmFormSetDataSource
   read pm_GetUseCaseController;
   {* Контроллер логики прецедента. При изменении полей бизнес объекта, он принимает решение об обновлении данных сборки (Refresh) }
  property DisplayName: IvcmCString
   read Get_DisplayName;
   {* название источинка данных }
 end;//IvcmFormDataSource

 IvcmExecuteParams = interface(IvcmFlexParams)
  {* Параметры выполнения операции. }
  ['{3800F95B-6E41-4AB7-A52E-71DB98647DE4}']
  function pm_GetData: IUnknown;
  function Get_Container: IvcmContainer;
  procedure SetControlEvent(anEvent: TvcmControlEvent);
  function BasePart: IvcmParams;
  property Data: IUnknown
   read pm_GetData;
   {* используется для обмена данными. Пользователь описывает интерфейс,
             который известен и приемнику и источнику. Источник создаёт
             интерфейс, заполняет его данными и присваивает полю Data }
  property Container: IvcmContainer
   read Get_Container;
 end;//IvcmExecuteParams

 IvcmFormSet = interface;

 IvcmFormSetRefreshDataParams = interface;

 IvcmFormSetDataSource = interface(IvcmObjectWithData)
  {* Интерфейс бизнес объекта сборки форм. [$54689847] }
  ['{948306E4-5742-41CC-8B87-F3A0973DCB66}']
  function pm_GetFormSetImageIndex: Integer;
  function pm_GetFormSet: IvcmFormSet;
  procedure pm_SetFormSet(const aValue: IvcmFormSet);
  function pm_GetMainCaption: IvcmCString;
  function pm_GetMainImageIndex: Integer;
  function pm_GetInInit: Boolean;
  function pm_GetTabCaption: IvcmCString;
  function pm_GetTabHint: IvcmCString;
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
  procedure Refresh(const aParams: IvcmFormSetRefreshDataParams = nil);
   {* обновить представление сборки }
  function MakeClone: IvcmFormSetDataSource;
  procedure PopToHistory;
  function As_Il3ChangeNotifier: Il3ChangeNotifier;
   {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
  property FormSetImageIndex: Integer
   read pm_GetFormSetImageIndex;
  property FormSet: IvcmFormSet
   read pm_GetFormSet
   write pm_SetFormSet;
  property MainCaption: IvcmCString
   read pm_GetMainCaption;
  property MainImageIndex: Integer
   read pm_GetMainImageIndex;
  property InInit: Boolean
   read pm_GetInInit;
   {* флаг взведен при первом обновлении сборки }
  property TabCaption: IvcmCString
   read pm_GetTabCaption;
  property TabHint: IvcmCString
   read pm_GetTabHint;
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
  ['{F2D3FFAE-B8EA-4261-A4B6-EBF0175BA64D}']
  function Get_InClose: Boolean;
  function Get_Container: IvcmContainer;
  function Get_Dispatcher: IvcmDispatcher;
  function Get_NativeMainForm: IvcmContainer;
  function Get_Caption: IvcmCString;
  procedure Set_Caption(const aValue: IvcmCString);
  function SafeClose: Boolean;
  function ShowModal: Integer;
  property InClose: Boolean
   read Get_InClose;
  property Container: IvcmContainer
   read Get_Container;
   {* Контейнер, в который входит данная форма }
  property Dispatcher: IvcmDispatcher
   read Get_Dispatcher;
  property NativeMainForm: IvcmContainer
   read Get_NativeMainForm;
  property Caption: IvcmCString
   read Get_Caption
   write Set_Caption;
 end;//IvcmForm

 TvcmFormDataSourceNotify = (
  {* Нотификация рассылаемая _IvcmFormDataSource слушателям }
  vcm_dsnDestroy
 );//TvcmFormDataSourceNotify

 IvcmUserTypeDef = interface(IvcmBaseObjectDef)
  ['{1CC34971-4A78-4406-B24B-CB368802431F}']
  function Get_ID: Integer;
  function Get_FormClass: TClass;
  function Get_UserVisibleOpCount: Integer;
  function Get_AllowCustomizeToolbars: Boolean;
  function Get_SettingsCaption: AnsiString;
  function Get_UseToolbarAnotherUserType: Boolean;
  property ID: Integer
   read Get_ID;
  property FormClass: TClass
   read Get_FormClass;
  property UserVisibleOpCount: Integer
   read Get_UserVisibleOpCount;
  property AllowCustomizeToolbars: Boolean
   read Get_AllowCustomizeToolbars;
   {* Можно ли настраивать тулбары у формы с данным пользовательским типом }
  property SettingsCaption: AnsiString
   read Get_SettingsCaption;
  property UseToolbarAnotherUserType: Boolean
   read Get_UseToolbarAnotherUserType;
 end;//IvcmUserTypeDef

 IvcmUserTypesIterator = interface
  ['{601CCBA3-D46D-4DF4-8322-27582B18A05A}']
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
  ['{1BEF93AC-39A2-4630-964C-FCFD9714FCC7}']
  function Get_UserTypesIterator: IvcmUserTypesIterator;
  property UserTypesIterator: IvcmUserTypesIterator
   read Get_UserTypesIterator;
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
  ['{8583988A-F32A-4579-8430-D6DB885BC9C0}']
  function pm_GetImageSize: TvcmImageSize;
  function pm_GetMergeWithContainer: TvcmBool;
  function pm_GetContainer: IvcmEntityForm;
  procedure Merge(const aStyle: IvcmToolbarStyle);
   {* объединить стили }
  property ImageSize: TvcmImageSize
   read pm_GetImageSize;
   {* размер иконок }
  property MergeWithContainer: TvcmBool
   read pm_GetMergeWithContainer;
   {* объединять с панелью инструментов контейнера формы }
  property Container: IvcmEntityForm
   read pm_GetContainer;
   {* контейнер для размещения панели иснтрументов }
 end;//IvcmToolbarStyle

 IvcmToolbarsStyle = interface
  {* Иконки панелей инструментов }
  ['{1AF66E21-1226-46EA-9BF3-312C75E600CA}']
  function pm_GetLeft: IvcmToolbarStyle;
  function pm_GetRight: IvcmToolbarStyle;
  function pm_GetTop: IvcmToolbarStyle;
  function pm_GetBottom: IvcmToolbarStyle;
  procedure Merge(const aStyle: IvcmToolbarsStyle);
   {* объединить стили }
  function IsDefault: Boolean;
   {* для одной из панелей устновлены иконки }
  procedure ForbidMerge;
   {* запретить объединение панелей инструментов }
  property Left: IvcmToolbarStyle
   read pm_GetLeft;
  property Right: IvcmToolbarStyle
   read pm_GetRight;
  property Top: IvcmToolbarStyle
   read pm_GetTop;
  property Bottom: IvcmToolbarStyle
   read pm_GetBottom;
 end;//IvcmToolbarsStyle

 IvcmFormStyle = interface
  {* стиль VCM формы }
  ['{94D33121-029B-4F1D-A03D-6DD1FBE1ED4B}']
  function pm_GetToolbars: IvcmToolbarsStyle;
  procedure Merge(const aStyle: IvcmFormStyle);
   {* объединить стили }
  property Toolbars: IvcmToolbarsStyle
   read pm_GetToolbars;
   {* иконки для панелей инструментов формы }
 end;//IvcmFormStyle

 IvcmEntity = interface;

 IvcmAggregate = interface;

 IvcmEntityForm = interface(IvcmForm)
  ['{325580D6-55ED-48B2-8335-DE9E4B50BB38}']
  function pm_GetGUID: TGUID;
  procedure pm_SetGUID(const aValue: TGUID);
  function pm_GetIsMainInFormSet: Boolean;
  function pm_GetKeyInFormSet: TvcmFormSetFormItemDescr;
  function pm_GetNeedAddFormToTasksPanel: Boolean;
  function Get_Entity: IvcmEntity;
  function Get_Aggregate: IvcmAggregate;
  function Get_ZoneType: TvcmZoneType;
  function pm_GetUserType: TvcmUserType;
  function pm_GetSubUserType: TvcmUserType;
  function Get_MainCaption: IvcmCString;
  function Get_FormDef: IvcmEntityFormDef;
  function pm_GetCurUserTypeDef: IvcmUserTypeDef;
  function pm_GetCurUseToolbarOfUserType: IvcmUserTypeDef;
  function pm_GetZoneControl: TControl;
  procedure pm_SetZoneControl(aValue: TControl);
  function pm_GetDataSource: IvcmFormDataSource;
  procedure pm_SetDataSource(const aValue: IvcmFormDataSource);
  function pm_GetFormSet: IvcmFormSet;
  function pm_GetStyle: IvcmFormStyle;
  function Get_AsContainer: IvcmContainer;
  function pm_GetTabCaption: IvcmCString;
  procedure pm_SetTabCaption(const aValue: IvcmCString);
  function Get_VCMClosing: Boolean;
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
  property GUID: TGUID
   read pm_GetGUID
   write pm_SetGUID;
  property IsMainInFormSet: Boolean
   read pm_GetIsMainInFormSet;
   {* форма является главной в сборке }
  property KeyInFormSet: TvcmFormSetFormItemDescr
   read pm_GetKeyInFormSet;
  property NeedAddFormToTasksPanel: Boolean
   read pm_GetNeedAddFormToTasksPanel;
  property Entity: IvcmEntity
   read Get_Entity;
   {* Сущность, которую олицетворяет форма }
  property Aggregate: IvcmAggregate
   read Get_Aggregate;
   {* Агрегация, в которую входит сущность }
  property ZoneType: TvcmZoneType
   read Get_ZoneType;
   {* Зона, в которую может встраиваться форма сущности }
  property UserType: TvcmUserType
   read pm_GetUserType;
  property SubUserType: TvcmUserType
   read pm_GetSubUserType;
   {* уточняет текущий UserType }
  property MainCaption: IvcmCString
   read Get_MainCaption;
  property FormDef: IvcmEntityFormDef
   read Get_FormDef;
  property CurUserTypeDef: IvcmUserTypeDef
   read pm_GetCurUserTypeDef;
  property CurUseToolbarOfUserType: IvcmUserTypeDef
   read pm_GetCurUseToolbarOfUserType;
   {* тип формы для чтения настроек }
  property ZoneControl: TControl
   read pm_GetZoneControl
   write pm_SetZoneControl;
   {* компонент зоны, в которую была вставлена форма }
  property DataSource: IvcmFormDataSource
   read pm_GetDataSource
   write pm_SetDataSource;
  property FormSet: IvcmFormSet
   read pm_GetFormSet;
  property Style: IvcmFormStyle
   read pm_GetStyle;
  property AsContainer: IvcmContainer
   read Get_AsContainer;
  property TabCaption: IvcmCString
   read pm_GetTabCaption
   write pm_SetTabCaption;
  property VCMClosing: Boolean
   read Get_VCMClosing;
 end;//IvcmEntityForm

 IvcmAggregate = interface
  ['{BD00EF86-1F46-4CAA-A4EB-0103086805B3}']
  function Get_GUID: TGUID;
  procedure AddEntity(const anEntity: IvcmEntity);
   {* Добавляет сущность в агрегацию }
  procedure RemoveEntity(const anEntity: IvcmEntity);
   {* удаляет сущность из агрегации }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): IvcmExecuteParams; overload;
  function Operation(const anOp: TvcmOPID): IvcmExecuteParams; overload;
  function HasForm(const aName: TvcmFormID;
   theForm: PIvcmEntityForm = nil): Boolean;
   {* Проверяет, присутствует ли указанная форма в агрегации }
  property GUID: TGUID
   read Get_GUID;
 end;//IvcmAggregate

 (*
 vcmEntitiesContainer = interface
  function Get_Entity(anIndex: Integer): IvcmEntity;
  function Get_EntitiesCount: Integer;
  property Entity[anIndex: Integer]: IvcmEntity
   read Get_Entity;
  property EntitiesCount: Integer
   read Get_EntitiesCount;
 end;//vcmEntitiesContainer
 *)

 IvcmFormSetFactory = interface;

 IvcmFormSet = interface(IvcmAggregate)
  {* Сборка форм }
  ['{68DCE8D7-D4FA-411D-B6D7-69309F7FA3C8}']
  function pm_GetCanRefresh: Boolean;
  function pm_GetFormSetImageIndex: Integer;
  function pm_GetFormSetCaption: IvcmCString;
  function pm_GetFormSetTabCaption: IvcmCString;
  function pm_GetFormSetTabHint: IvcmCString;
  function pm_GetCanBeCloned: Boolean;
  function pm_GetCanBeSavedToHistory: Boolean;
  function pm_GetContainer: IvcmContainer;
  procedure pm_SetContainer(const aValue: IvcmContainer);
  function pm_GetFactory: IvcmFormSetFactory;
  procedure pm_SetFactory(const aValue: IvcmFormSetFactory);
  function pm_GetDataSource: IvcmFormSetDataSource;
  procedure pm_SetDataSource(const aValue: IvcmFormSetDataSource);
  function Get_Entity(anIndex: Integer): IvcmEntity;
  function Get_EntitiesCount: Integer;
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
  property CanRefresh: Boolean
   read pm_GetCanRefresh;
   {* после помещения удаляемой сборки в историю обновлять ее нельзя }
  property FormSetImageIndex: Integer
   read pm_GetFormSetImageIndex;
  property FormSetCaption: IvcmCString
   read pm_GetFormSetCaption;
  property FormSetTabCaption: IvcmCString
   read pm_GetFormSetTabCaption;
  property FormSetTabHint: IvcmCString
   read pm_GetFormSetTabHint;
  property CanBeCloned: Boolean
   read pm_GetCanBeCloned;
  property CanBeSavedToHistory: Boolean
   read pm_GetCanBeSavedToHistory;
  property Container: IvcmContainer
   read pm_GetContainer
   write pm_SetContainer;
  property Factory: IvcmFormSetFactory
   read pm_GetFactory
   write pm_SetFactory;
  property DataSource: IvcmFormSetDataSource
   read pm_GetDataSource
   write pm_SetDataSource;
   {* бизнес объект прецедента }
  property Entity[anIndex: Integer]: IvcmEntity
   read Get_Entity;
  property EntitiesCount: Integer
   read Get_EntitiesCount;
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
  ['{08A20A53-92F1-4579-842F-3F6FD86A8563}']
  function pm_GetSaveToHistory: TvcmSaveFormSetToHistory;
  function pm_GetDataForHistory: IvcmData;
  function pm_GetDataSource: IvcmFormSetDataSource;
  procedure pm_SetDataSource(const aValue: IvcmFormSetDataSource);
  function pm_GetFormSet: IvcmFormSet;
  procedure pm_SetFormSet(const aValue: IvcmFormSet);
  function pm_GetLockSetFocusToMainObjectForm: Boolean;
  procedure pm_SetLockSetFocusToMainObjectForm(aValue: Boolean);
  function pm_GetFormSetToClone: IvcmFormSet;
  property SaveToHistory: TvcmSaveFormSetToHistory
   read pm_GetSaveToHistory;
   {* записать в историю формы, у которых изменились _DataSource }
  property DataForHistory: IvcmData
   read pm_GetDataForHistory;
   {* данные aDataSource, которые необходимо сохранить в историю }
  property DataSource: IvcmFormSetDataSource
   read pm_GetDataSource
   write pm_SetDataSource;
  property FormSet: IvcmFormSet
   read pm_GetFormSet
   write pm_SetFormSet;
  property LockSetFocusToMainObjectForm: Boolean
   read pm_GetLockSetFocusToMainObjectForm
   write pm_SetLockSetFocusToMainObjectForm;
  property FormSetToClone: IvcmFormSet
   read pm_GetFormSetToClone;
 end;//IvcmFormSetRefreshDataParams

 IvcmEntityFormIterator = interface
  {* Итератор форм }
  ['{4D060767-BC15-4155-B148-005D1611436D}']
  function Next: IvcmEntityForm;
 end;//IvcmEntityFormIterator

 TvcmMainFormInfo = record
  {* информация о главной форме. }
  rWindowState: TWindowState;
  rBounds: TRect;
   {* положение окна в координатах экрана. }
 end;//TvcmMainFormInfo

 IvcmFormSetIterator = interface
  ['{EA17BD08-C17A-4592-B935-24D19B636FA4}']
  function Next: IvcmFormSet;
 end;//IvcmFormSetIterator

 IvcmAggregateIterator = interface
  ['{47922ED9-18D9-4FDE-9819-20F3E15D4895}']
  function Next: IvcmAggregate;
 end;//IvcmAggregateIterator

 IvcmContainer = interface
  {* Контейнер форм }
  ['{719C2E6C-F3EA-4ED1-BB08-4C3327734EB2}']
  function pm_GetEntityFormIterator: IvcmEntityFormIterator;
  function Get_NativeMainForm: IvcmContainer;
  function Get_AsForm: IvcmEntityForm;
  function pm_GetFormSetIterator: IvcmFormSetIterator;
  function pm_GetAggregateIterator: IvcmAggregateIterator;
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
   aZoneType: TvcmZoneType = vcm_ztAny;
   aRecursive: Boolean = True;
   theForm: PIvcmEntityForm = nil;
   aUserType: TvcmUserType = vcmUserControls.vcm_utAny;
   aGUID: PGUID = nil;
   aSubUserType: TvcmUserType = vcmUserControls.vcm_utAny): Boolean; overload;
   {* проверяет есть ли в контейнере такая форма }
  function HasForm(aZoneType: TvcmZoneType = vcm_ztAny;
   aRecursive: Boolean = True;
   theForm: PIvcmEntityForm = nil;
   aUserType: TvcmUserType = vcmUserControls.vcm_utAny;
   aGUID: PGUID = nil;
   aSubUserType: TvcmUserType = vcmUserControls.vcm_utAny): Boolean; overload;
   {* проверяет есть ли в контейнере такая форма }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
   {* Выполнение операции по имени сущности }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams): Boolean; overload;
   {* Выполнение операции по имени сущности }
  function Operation(const anOp: TvcmOPID;
   aMode: TvcmOperationMode = vcmUserControls.vcm_omExecute): Boolean; overload;
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
  function IsSame(const aAnother: IvcmContainer): Boolean;
  property EntityFormIterator: IvcmEntityFormIterator
   read pm_GetEntityFormIterator;
   {* итератор форм контейнера }
  property NativeMainForm: IvcmContainer
   read Get_NativeMainForm;
  property AsForm: IvcmEntityForm
   read Get_AsForm;
  property FormSetIterator: IvcmFormSetIterator
   read pm_GetFormSetIterator;
  property AggregateIterator: IvcmAggregateIterator
   read pm_GetAggregateIterator;
 end;//IvcmContainer

 IvcmParams = interface(IvcmBaseParamsPrim)
  {* Параметры операции }
  ['{71B728D6-3EFB-4B1B-ACD3-4A5E9C1D5A84}']
  function Get_HasContainer: Boolean;
  function pm_GetTestPart: IvcmTestParams;
  function pm_GetExecutePart: IvcmExecuteParams;
  procedure SetContainerPrim(const aContainer: IvcmContainer;
   aReplace: Boolean);
  property HasContainer: Boolean
   read Get_HasContainer;
  property TestPart: IvcmTestParams
   read pm_GetTestPart;
  property ExecutePart: IvcmExecuteParams
   read pm_GetExecutePart;
 end;//IvcmParams

 IvcmEntity = interface
  {* Сущность }
  ['{B0C75CC0-B3B7-440D-806A-6A5AB057C637}']
  function Get_ID: TvcmControlID;
  function Get_AsForm: IvcmEntityForm;
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmParams;
   aMode: TvcmOperationMode): Boolean; overload;
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams): Boolean; overload;
  property ID: TvcmControlID
   read Get_ID;
  property AsForm: IvcmEntityForm
   read Get_AsForm;
 end;//IvcmEntity

 IvcmHistoryItem = interface
  {* Элемент истории приложения }
  ['{31043D04-F4D1-4E89-8DDA-F005E711AC11}']
  function pm_GetCaption: IvcmCString;
  function Activate(const aMainForm: IvcmEntityForm): Boolean; overload;
  function Activate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean; overload;
  function Drop: Boolean;
  function IsAcceptable: Boolean;
   {* можно ли активизировать элемент истории в текущих условиях }
  property Caption: IvcmCString
   read pm_GetCaption;
   {* название }
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
  ['{85EBC57E-7442-4726-AFE4-A6BDCE989F82}']
  function Add(const anItem: IvcmHistoryItem;
   aDelta: Integer): Boolean;
  function IsEmpty: Boolean;
  function ItemsCount: Integer;
  function GetItem(anIndex: Integer): IvcmHistoryItem;
 end;//IvcmContainerHistoryItem

 IvcmHistoryItems = interface;

 IvcmHistoryState = interface
  ['{A570EF57-53AB-4207-AB84-7A95696FCA67}']
  function pm_GetItems: IvcmHistoryItems;
  function pm_GetCurrent: Integer;
  function pm_GetContainerItem: IvcmContainerHistoryItem;
  property Items: IvcmHistoryItems
   read pm_GetItems;
  property Current: Integer
   read pm_GetCurrent;
  property ContainerItem: IvcmContainerHistoryItem
   read pm_GetContainerItem;
 end;//IvcmHistoryState

 IvcmHistoryItems = interface
  ['{15A9DBF6-3187-431D-8C58-FC061C73CEB9}']
  function Get_HistoryItemCount: Integer;
  function Get_HistoryItems(Index: Integer): IvcmHistoryItem;
  function MakeClone: IvcmHistoryItems;
  property HistoryItemCount: Integer
   read Get_HistoryItemCount;
  property HistoryItems[Index: Integer]: IvcmHistoryItem
   read Get_HistoryItems;
 end;//IvcmHistoryItems

 IvcmHistory = interface
  ['{D98392A1-1592-465C-A07E-B3B059CFB5D1}']
  function pm_GetInBF: Boolean;
  function pm_GetInProcess: Boolean;
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
   aStateType: TvcmStateType = vcmExternalInterfaces.vcm_stContent): Boolean;
   {* сохранение без проверки необходимости сохранения формы }
  function SaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType = vcmExternalInterfaces.vcm_stContent): Boolean;
  procedure SaveClose(const aForm: IvcmEntityForm;
   const aFormID: TvcmFormID;
   aUserType: TvcmUserType;
   aZoneType: TvcmZoneType;
   aSubUserType: TvcmUserType);
   {* форма которая должна быть закрыта при переходе по истории }
  function HasInPreviousStep(const aFormClass: TvcmFormID;
   aUserType: TvcmUserType = vcmUserControls.vcm_utAny): Boolean;
  function Back(aTruncate: Boolean = False): Boolean; overload;
  function Forward: Boolean; overload;
  procedure Back(const aParams: IvcmExecuteParamsPrim;
   aTruncate: Boolean = False); overload;
  procedure Forward(const aParams: IvcmExecuteParamsPrim); overload;
  function CanBack: Boolean;
  function CanForward: Boolean;
  procedure GetBackStrings(const aParams: IvcmTestParamsPrim);
  procedure GetForwardStrings(const aParams: IvcmTestParamsPrim);
  procedure Start(const aSender: IvcmEntityForm;
   const aCaption: IvcmCString = nil;
   aFormSet: Boolean = False);
  procedure Finish(const aSender: IvcmEntityForm);
  procedure AddForm(const aForm: IvcmEntityForm);
  procedure RemoveForm(const aForm: IvcmEntityForm);
  function Add(const anItem: IvcmHistoryItem): Boolean;
   {* добавляет запись в историю }
  function IsLast: Boolean;
  function InBack: Boolean;
   {* Находимся в процессе Back, если нет, то Forward }
  procedure Clear(aHeedCheckCurrent: Boolean = True);
   {* Очищает историю }
  function MakeState: IvcmHistoryState;
  procedure AssignState(const aState: IvcmHistoryState);
  property InBF: Boolean
   read pm_GetInBF;
   {* история находится в состоянии перехода (Back/Forward) }
  property InProcess: Boolean
   read pm_GetInProcess;
   {* история находится в процессе сохранения (между сколбками Start-Finish) }
 end;//IvcmHistory

 IvcmLockListener = interface
  {* слушатель блокировок }
  ['{E0D65BF5-6B21-4ABC-9F2C-395BADEB1D05}']
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
  ['{D21F3AC0-178F-4F13-A571-79F897BEB2D9}']
  function Get_Locked: Boolean;
  function Get_MainFormsCount: Integer;
  function Get_MainForm(anIndex: Integer): IvcmEntityForm;
  function Get_CurrentMainForm: IvcmEntityForm;
  function Get_Notify: IvcmFormDispatcherNotify;
  function pm_GetMainFormProvider: IvcmMainFormProvider;
  procedure pm_SetMainFormProvider(const aValue: IvcmMainFormProvider);
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
  procedure UpdateMainCaption(const aForm: IvcmEntityForm = nil);
  procedure AddToCloseQueue(const aForm: IvcmEntityForm);
  procedure PlaceNewMainForm(aSource: TCustomForm;
   aNew: TCustomForm);
   {* разместить новую главную форму.
             aSourceMainForm:
               - форма на которой вызвали создание новой }
  procedure StartNewMainForm;
   {* вызывается перед началом создания главной формы }
  property Locked: Boolean
   read Get_Locked;
  property MainFormsCount: Integer
   read Get_MainFormsCount;
  property MainForm[anIndex: Integer]: IvcmEntityForm
   read Get_MainForm;
  property CurrentMainForm: IvcmEntityForm
   read Get_CurrentMainForm;
  property Notify: IvcmFormDispatcherNotify
   read Get_Notify;
  property MainFormProvider: IvcmMainFormProvider
   read pm_GetMainFormProvider
   write pm_SetMainFormProvider;
 end;//IvcmFormDispatcher

 IvcmMainFormProvider = interface
  ['{6155D3F0-A171-41F9-9802-90711A07CC02}']
  function pm_GetCurrentMainForm: IvcmEntityForm;
  function pm_GetCurrentVCMContainer: IvcmContainer;
  property CurrentMainForm: IvcmEntityForm
   read pm_GetCurrentMainForm;
  property CurrentVCMContainer: IvcmContainer
   read pm_GetCurrentVCMContainer;
 end;//IvcmMainFormProvider

 IvcmModule = interface;

 IvcmEntityFormsIterable = interface;

 IvcmDispatcher = interface
  {* Диспетчер приложения }
  ['{7FC5CA97-184A-4632-9A87-B97D59C5AE84}']
  function Get_ModulesCount: Integer;
  function Get_EntitiesCount: Integer;
  function Get_IsRestoringAllSettings: Boolean;
  function Get_InClosingAllWindows: Boolean;
  function pm_GetIsLockActionUpdate: Boolean;
  function Get_Module(anIndex: Integer): IvcmModule;
  function Get_FormDispatcher: IvcmFormDispatcher;
  function Get_History: IvcmHistory;
  function Get_ActiveEntity: IvcmEntity;
  function Get_Entity(anIndex: Integer): IvcmEntity;
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
  {$If NOT Defined(DesignTimeLibrary)}
  procedure EntityOperationBroadcast(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams);
  {$IfEnd} // NOT Defined(DesignTimeLibrary)
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
  procedure BeginOp(anInternal: Boolean = False);
  procedure EndOp;
  procedure StoreFocused(aHandle: THandle);
  function InOp(anInternal: Boolean = False): Boolean;
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
  procedure TileWindowsHorizontal(const aForms: IvcmEntityFormsIterable = nil);
   {* упорядочить открытые окна приложения горизонтально }
  procedure TileWindowsVertical(const aForms: IvcmEntityFormsIterable = nil);
   {* упорядочить открытые окна приложения ветикально }
  procedure CascadeWindows(const aForms: IvcmEntityFormsIterable = nil);
   {* расположить открытые окна каскадом }
  procedure CloseAllWindows(const aForms: IvcmEntityFormsIterable = nil;
   const aCurrent: IvcmEntityForm = nil);
   {* закрыть все открытые окна кроме текущего, если он не указан, то закрывается приложение }
  procedure LockInOp;
   {* Игнорируем скобки BeginOp/EndOp }
  procedure UnlockInOp;
   {* Игнорируем скобки BeginOp/EndOp }
  property ModulesCount: Integer
   read Get_ModulesCount;
  property EntitiesCount: Integer
   read Get_EntitiesCount;
  property IsRestoringAllSettings: Boolean
   read Get_IsRestoringAllSettings;
   {* идет восстановление всех настроек системы }
  property InClosingAllWindows: Boolean
   read Get_InClosingAllWindows;
   {* идет закрытие всех окон системы }
  property IsLockActionUpdate: Boolean
   read pm_GetIsLockActionUpdate;
   {* обновление операций запрещено }
  property Module[anIndex: Integer]: IvcmModule
   read Get_Module;
  property FormDispatcher: IvcmFormDispatcher
   read Get_FormDispatcher;
   {* диспетчер форм приложения }
  property History: IvcmHistory
   read Get_History;
  property ActiveEntity: IvcmEntity
   read Get_ActiveEntity;
   {* Активная сущность }
  property Entity[anIndex: Integer]: IvcmEntity
   read Get_Entity;
 end;//IvcmDispatcher

 TvcmEntityOperationsOption = (
  {* для настройки сущностей }
  vcm_enoGroupItemsInContextMenu
   {* группировать элементы в контекстном меню }
 );//TvcmEntityOperationsOption

 TvcmEntityOperationsOptions = set of TvcmEntityOperationsOption;

 IvcmEntityDef = interface(IvcmOperationalIdentifiedUserFriendlyControl)
  {* Описание сущности }
  ['{99A2B713-A7AD-462E-85F1-BF8BAB015709}']
  function pm_GetOptions: TvcmEntityOperationsOptions;
  function Get_ContextMenuWeight: Integer;
  property Options: TvcmEntityOperationsOptions
   read pm_GetOptions;
  property ContextMenuWeight: Integer
   read Get_ContextMenuWeight;
 end;//IvcmEntityDef

 IvcmEntitiesDefIterator = interface
  {* Итератор описаний сущностей }
  ['{2B7E0191-516A-4291-A8C8-3B21174FBDE0}']
  function Get_Next: IvcmEntityDef;
  property Next: IvcmEntityDef
   read Get_Next;
   {* следующий описатель сущности }
 end;//IvcmEntitiesDefIterator

 IvcmModuleDef = interface(IvcmOperationalIdentifiedUserFriendlyControl)
  ['{8EC2C72E-6BC1-4DB5-92A5-364301DA3F62}']
  function Get_EntitiesDefIterator: IvcmEntitiesDefIterator;
  function Get_UserTypesIterator: IvcmUserTypesIterator;
  function Make: IvcmModule;
   {* создает модуль }
  property EntitiesDefIterator: IvcmEntitiesDefIterator
   read Get_EntitiesDefIterator;
   {* итератор описаний сущностей. Может быть nil }
  property UserTypesIterator: IvcmUserTypesIterator
   read Get_UserTypesIterator;
 end;//IvcmModuleDef

 IvcmModule = interface
  {* Модуль (что он на самом деле олицетворяет - я и сам теперь не понимаю) }
  ['{B04FFD05-9E96-4970-9DDD-7DA8173A828D}']
  function Get_ModuleDef: IvcmModuleDef;
  procedure Operation(anID: TvcmControlID;
   const aParams: IvcmParams;
   aMode: TvcmOperationMode);
   {* выполняет операцию модуля }
  function GetOperationByID(anID: TvcmControlID): IvcmOperationDef;
  property ModuleDef: IvcmModuleDef
   read Get_ModuleDef;
   {* описатель модуля }
 end;//IvcmModule

 PIvcmEntityForm = ^IvcmEntityForm;

 TvcmInitProc = procedure(aForm: TWinControl);

 TvcmEffectiveUserType = Low(TvcmUserType) .. Pred(High(TvcmUserType));

 TvcmFormSetID = object
  {* идентификатор сборки. }
  public
   rName: AnsiString;
  public
   function EQ(const anOther: TvcmFormSetID): Boolean;
 end;//TvcmFormSetID

 PvcmFormSetID = ^TvcmFormSetID;

 IvcmFormSetRefreshParams = interface(IvcmFormSetRefreshDataParams)
  {* Параметры обновления сборки }
  ['{A4A09A60-7E69-46AA-8321-30102D348F15}']
 end;//IvcmFormSetRefreshParams

 IvcmFormSetSimpleFactory = interface;

 IvcmFormSetFactory = interface
  {* Фабрика сборки }
  ['{B9D1E9AD-C234-41E1-940C-C50042E56540}']
  function pm_GetFormSetId: PvcmFormSetID;
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
  property FormSetId: PvcmFormSetID
   read pm_GetFormSetId;
   {* идентификатор сборки, имя сборки указанное при описании сборки }
 end;//IvcmFormSetFactory

 TvcmEffectiveUserTypes = set of TvcmEffectiveUserType;

 IvcmEntityFormsIterable = interface
  ['{C721BADE-213E-42D8-BDDE-BA8E48388BF2}']
  function pm_GetFormsCount: Integer;
  procedure IterateFormsF(anAction: TvcmIteratorAction);
  procedure AddForm(const aForm: IvcmEntityForm);
  property FormsCount: Integer
   read pm_GetFormsCount;
 end;//IvcmEntityFormsIterable

 IvcmFormSetSimpleFactory = interface
  ['{862623F3-FC24-4ED8-948C-C38F822E8D80}']
  function MakeFormset(const aDataSource: IvcmFormSetDataSource;
   const aContainer: IvcmContainer;
   aSaveToHistory: Boolean;
   aLockSetFocusToMainObjectForm: Boolean;
   const aFormSetToClone: IvcmFormSet): IvcmFormSet;
 end;//IvcmFormSetSimpleFactory

 TvcmZoneTypes = set of TvcmZoneType;
  {* Набор типов доны докинга }

 TvcmEffectiveZoneType = Main .. Reminder;
  {* реальная зона докинга }

 TvcmEffectiveZoneTypes = set of TvcmEffectiveZoneType;
  {* множество типов реальных зон докинга }

 IvcmMakeParams = interface(IvcmBase)
  ['{5D4BEDAD-5C8D-407F-B53C-46BF377DB7F8}']
  function Get_Owner: TComponent;
  function Get_Aggregate: IvcmAggregate;
  function Get_Container: IvcmContainer;
  property Owner: TComponent
   read Get_Owner;
  property Aggregate: IvcmAggregate
   read Get_Aggregate;
   {* Агрегация, к которой относятся параметры }
  property Container: IvcmContainer
   read Get_Container;
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
  public
   class function AllowCustomizeToolbars(const anUserType: IvcmUserTypeDef): Boolean;
   class function IsCustomizationInternal(const anUserType: IvcmUserTypeDef): Boolean;
 end;//TvcmUserTypeInfo

 TvcmFormDescriptor = object
  public
   rFormID: TvcmFormID;
   rFactory: TvcmFormFactory;
  public
   procedure SetFactory(aFactory: TvcmFormFactory);
   function MakeForm(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aUserType: TvcmEffectiveUserType;
    aGUID: PGUID;
    const aDataSource: IvcmFormDataSource;
    aSubUserType: TvcmUserType;
    aAfterCreate: TvcmInitProc): IvcmEntityForm;
   function FormClass: TClass;
 end;//TvcmFormDescriptor

 IvcmResourceHolder = interface
  ['{4792A4F9-B1E6-4395-9EA0-64D0853AF9AF}']
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
  ['{DC6618D6-FB3B-4E3A-A109-B0546A816F75}']
  function MakeContainer: IvcmContainer;
 end;//IvcmContainerMaker

 IvcmFormSetIconProvider = interface
  ['{4C8A579E-79CE-4DF8-A14A-83CE8ACE6C9C}']
  function pm_GetFormSetImageIndex: Integer;
  function pm_GetCanDefineFormSetIcon: Boolean;
  property FormSetImageIndex: Integer
   read pm_GetFormSetImageIndex;
  property CanDefineFormSetIcon: Boolean
   read pm_GetCanDefineFormSetIcon;
 end;//IvcmFormSetIconProvider

 IvcmSizeableForm = interface(IvcmBase)
  ['{A050975A-A938-4AA9-803F-D8D84004A926}']
  function pm_GetCanChangeSize: Boolean;
  function pm_GetCanBeMaximized: Boolean;
  property CanChangeSize: Boolean
   read pm_GetCanChangeSize;
  property CanBeMaximized: Boolean
   read pm_GetCanBeMaximized;
 end;//IvcmSizeableForm

 IvcmForms = interface
  ['{B9C2DA58-E331-4DC2-9F54-0ED00A062F2A}']
  function pm_GetCount: Integer;
  property Count: Integer
   read pm_GetCount;
 end;//IvcmForms

 PvcmFormDescriptor = ^TvcmFormDescriptor;

 IvcmFormSetCaptionProvider = interface(IvcmBase)
  ['{437FC8E1-5CEF-4BAD-8AAE-E918ABC67947}']
  function pm_GetFormSetCaption: IvcmCString;
  function pm_GetFormSetTabCaption: IvcmCString;
  property FormSetCaption: IvcmCString
   read pm_GetFormSetCaption;
  property FormSetTabCaption: IvcmCString
   read pm_GetFormSetTabCaption;
 end;//IvcmFormSetCaptionProvider

 IvcmMainMenuForChromeLike = interface(IvcmBase)
  ['{2C638936-766A-4AA1-AF6E-AA13E40A023E}']
  function pm_GetIsActive: Boolean;
  function pm_GetFocusedControl: TWinControl;
  property IsActive: Boolean
   read pm_GetIsActive;
  property FocusedControl: TWinControl
   read pm_GetFocusedControl;
 end;//IvcmMainMenuForChromeLike

 IvcmContainedForm = interface
  ['{F546303D-4549-43A6-859D-468147909611}']
  function pm_GetIsEmpty: Boolean;
  function Get_AsForm: IvcmEntityForm;
  function pm_GetContainedFormHistory: IvcmHistory;
  function pm_GetIsInHistoryOperation: Boolean;
  procedure NotifyContainerIsClosing;
  procedure InitContainedForm;
  procedure SaveFocusedControl;
  procedure RestoreFocusedControl;
  function OpenNew(aOpenKind: TvcmMainFormOpenKind;
   aOpenLast: Boolean): IvcmContainedForm;
  procedure CloseContainedForm;
  procedure StartTabHistoryOperation;
  procedure FinishTabHistoryOperation;
  property IsEmpty: Boolean
   read pm_GetIsEmpty;
  property AsForm: IvcmEntityForm
   read Get_AsForm;
  property ContainedFormHistory: IvcmHistory
   read pm_GetContainedFormHistory;
  property IsInHistoryOperation: Boolean
   read pm_GetIsInHistoryOperation;
 end;//IvcmContainedForm

 IvcmFormSetFormHistoryItem = interface
  ['{00655407-1826-4A81-979E-88E15D0F5594}']
  function pm_GetZoneType: TvcmZoneType;
  function pm_GetUserType: TvcmUserType;
  function pm_GetSubUserType: TvcmUserType;
  function pm_GetDataSource: IvcmFormDataSource;
  function pm_GetFormData: IvcmBase;
  function pm_GetFormID: TvcmFormID;
  function pm_GetGUID: TGUID;
  function pm_GetContainerGUID: TGUID;
  function MakeForm(const aContainer: IvcmContainer;
   const aFormSet: IvcmFormSet;
   const aAggregate: IvcmAggregate;
   out aForm: IvcmEntityForm): Boolean;
  property ZoneType: TvcmZoneType
   read pm_GetZoneType;
  property UserType: TvcmUserType
   read pm_GetUserType;
  property SubUserType: TvcmUserType
   read pm_GetSubUserType;
  property DataSource: IvcmFormDataSource
   read pm_GetDataSource;
  property FormData: IvcmBase
   read pm_GetFormData;
  property FormID: TvcmFormID
   read pm_GetFormID;
  property GUID: TGUID
   read pm_GetGUID;
  property ContainerGUID: TGUID
   read pm_GetContainerGUID;
 end;//IvcmFormSetFormHistoryItem

 IvcmFormSetHistoryItem = interface
  ['{BF5063EB-ADFC-4DC2-8B0E-0D2E3A832536}']
  function pm_GetCaption: IvcmCString;
  function pm_GetItemCount: Integer;
  function GetItem(aIndex: Integer): IvcmFormSetFormHistoryItem;
  function MakeFormSet(const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet;
   aNeedAssignHistory: Boolean): Boolean;
  property Caption: IvcmCString
   read pm_GetCaption;
  property ItemCount: Integer
   read pm_GetItemCount;
 end;//IvcmFormSetHistoryItem

 IvcmFormSetHistoryStepItem = interface
  ['{7BF247FB-5FDE-4E1A-B393-DF060023E2B0}']
  procedure Restore(const aContainer: IvcmContainer;
   const aFormSetToClone: IvcmFormSet;
   aNeedAssignHistory: Boolean);
 end;//IvcmFormSetHistoryStepItem

 IvcmFormSetHistoryStepItems = interface
  ['{0B74CE7B-2DC8-45B7-97DC-7412EED1F729}']
  function pm_GetNext: Boolean;
  function Get_Current: IvcmFormSetHistoryStepItem;
  procedure Add(const anItem: IvcmFormSetHistoryStepItem);
  procedure Reset;
  property Next: Boolean
   read pm_GetNext;
  property Current: IvcmFormSetHistoryStepItem
   read Get_Current;
 end;//IvcmFormSetHistoryStepItems

 IvcmFormSetHistoryStep = interface(IvcmFormSetHistoryStepItems)
  ['{81DCFAA4-8941-4293-B6E5-ED572DA0F4FE}']
  procedure Restore(const aContainer: IvcmContainer;
   const aFormSetToClone: IvcmFormSet;
   aNeedAssignHistory: Boolean);
 end;//IvcmFormSetHistoryStep

 IvcmFormSetHistory = interface
  ['{A2DC2387-6A00-4C74-8315-626452F22FDE}']
  function pm_GetItemCount: Integer;
  function pm_GetInBF: Boolean;
  procedure Back(const aContainer: IvcmContainer);
  procedure CloneTab(const aTab: Il3FormTab);
  procedure SaveTab(const aTab: Il3FormTab);
  function CanBack: Boolean;
  function IsContainerInOp(const aContainer: IvcmContainer): Boolean;
  property ItemCount: Integer
   read pm_GetItemCount;
  property InBF: Boolean
   read pm_GetInBF;
 end;//IvcmFormSetHistory

 PIvcmFormSet = ^IvcmFormSet;

 IvcmSelectedTabDependent = Il3SelectedTabDependent;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , afwFacade
 , SysUtils
;

function TvcmFormSetID.EQ(const anOther: TvcmFormSetID): Boolean;
//#UC START# *4FFDBAD10278_4683F4F6007E_var*
//#UC END# *4FFDBAD10278_4683F4F6007E_var*
begin
//#UC START# *4FFDBAD10278_4683F4F6007E_impl*
 Result := (Self.rName = anOther.rName);
//#UC END# *4FFDBAD10278_4683F4F6007E_impl*
end;//TvcmFormSetID.EQ

class function TvcmUserTypeInfo.AllowCustomizeToolbars(const anUserType: IvcmUserTypeDef): Boolean;
//#UC START# *51D6CBF90231_51D6CBDB0194_var*
//#UC END# *51D6CBF90231_51D6CBDB0194_var*
begin
//#UC START# *51D6CBF90231_51D6CBDB0194_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=466760570
 Result := anUserType.AllowCustomizeToolbars or afw.Application.IsInternal;
//#UC END# *51D6CBF90231_51D6CBDB0194_impl*
end;//TvcmUserTypeInfo.AllowCustomizeToolbars

class function TvcmUserTypeInfo.IsCustomizationInternal(const anUserType: IvcmUserTypeDef): Boolean;
//#UC START# *51FF6ED902F6_51D6CBDB0194_var*
//#UC END# *51FF6ED902F6_51D6CBDB0194_var*
begin
//#UC START# *51FF6ED902F6_51D6CBDB0194_impl*
 Result := (not anUserType.AllowCustomizeToolbars)
  and AllowCustomizeToolbars(anUserType);
//#UC END# *51FF6ED902F6_51D6CBDB0194_impl*
end;//TvcmUserTypeInfo.IsCustomizationInternal

procedure TvcmFormDescriptor.SetFactory(aFactory: TvcmFormFactory);
//#UC START# *4FFC436A0015_4FFC30A800DF_var*
//#UC END# *4FFC436A0015_4FFC30A800DF_var*
begin
//#UC START# *4FFC436A0015_4FFC30A800DF_impl*
 Assert(@Self <> nil);
 Assert(not Assigned(rFactory));
 rFactory := aFactory;
//#UC END# *4FFC436A0015_4FFC30A800DF_impl*
end;//TvcmFormDescriptor.SetFactory

function TvcmFormDescriptor.MakeForm(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aUserType: TvcmEffectiveUserType;
 aGUID: PGUID;
 const aDataSource: IvcmFormDataSource;
 aSubUserType: TvcmUserType;
 aAfterCreate: TvcmInitProc): IvcmEntityForm;
//#UC START# *4FFC47240301_4FFC30A800DF_var*
//#UC END# *4FFC47240301_4FFC30A800DF_var*
begin
//#UC START# *4FFC47240301_4FFC30A800DF_impl*
 Assert(@Self <> nil);
 Assert(Assigned(rFactory), Format('Не зарегистрирована фабрика для формы %s', [rFormID.rName]));
 Result := rFactory(aParams, aZoneType, aUserType, aGUID, aDataSource, aSubUserType, aAfterCreate);
//#UC END# *4FFC47240301_4FFC30A800DF_impl*
end;//TvcmFormDescriptor.MakeForm

function TvcmFormDescriptor.FormClass: TClass;
//#UC START# *4FFD9F7A02D6_4FFC30A800DF_var*
var
 l_Factory : TvcmFormFactory;
 l_M       : TMethod absolute l_Factory;
//#UC END# *4FFD9F7A02D6_4FFC30A800DF_var*
begin
//#UC START# *4FFD9F7A02D6_4FFC30A800DF_impl*
 Assert(@Self <> nil);
 Assert(Assigned(rFactory));
 l_Factory := rFactory;
 Result := l_M.Data;
//#UC END# *4FFD9F7A02D6_4FFC30A800DF_impl*
end;//TvcmFormDescriptor.FormClass
{$IfEnd} // NOT Defined(NoVCM)

end.
