unit vcmEntityForm;

interface

uses
 l3IntfUses
 , vcmEntityFormModelPart
 , l3InternalInterfaces
 , afwInterfaces
 , vcmToolbarsInterfaces
 , vcmFormDispatcherInterfaces
 , vcmInterfaces
 , vcmExternalInterfaces
 , l3Interfaces
 , vcmUserTypesCollectionItem
 , l3Core
 , vcmEntityFormImplementationModelPart
 , l3ProtoDataContainer
;

type
 TvcmEntityFormImplementation = class(TvcmEntityFormImplementationModelPart)
 end;//TvcmEntityFormImplementation
 
 TvcmGetLocalizationInfo = procedure(Sender: TObject;
  var theInfo: AnsiString) of object;
 
 TvcmSetLocalizationInfo = procedure(Sender: TObject;
  const theInfo: AnsiString) of object;
 
 RvcmEntityForm = ;
 
 TvcmEntityForm = class(TvcmEntityFormModelPart, Il3CommandTarget, IafwForm, IafwTabSheetControl, IvcmToolbarsCustomizeListener, IvcmFormDispatcherListener)
  procedure UpdateStatusInfo;
  procedure NotifyUserTypeSet;
  procedure DefaultQueryClose(aSender: TObject);
  procedure CheckFloatingVisibility;
  procedure CreateFormGUID(var theGUID: TGUID);
   {* Создаёт идентификатор формы. Для того, чтобы отличать однотипные формы друг от друга. В частности для истории. }
  function AddUserType: TvcmUserTypesCollectionItem;
  function HasFormFloatingZoneTypeAndVisible: Boolean;
  procedure CleanDependencies;
  procedure SetupFormLayout;
   {* Тут можно настроить внешний вид формы }
  procedure ReleaseResources;
  procedure BeforeClosing;
  function DoGetTabCaption: IvcmCString;
  function HasFormModalState: Boolean;
  procedure DoOnShowModal;
  function DoGetNeedAddFormToTasksPanel: Boolean;
  function GetInner(anEntityID: TvcmControlID): IvcmEntity;
  function NeedTerminateApp: Boolean;
  function DoGetNeedSaveToTabHistory: Boolean;
  function NeedLoadFormStateForClone(const aState: IvcmBase;
   aStateType: TvcmStateType): Boolean;
  procedure DoBeforeHistoryNavigate;
  procedure DoInit(aFromHistory: Boolean);
   {* Инициализация формы. Для перекрытия в потомках }
  function DoSaveState(out theState: IvcmBase;
   aStateType: TvcmStateType;
   aForClone: Boolean): Boolean;
   {* Сохраняет состояние формы. Для перекрытия в потомках }
  function DoLoadState(const aState: IvcmBase;
   aStateType: TvcmStateType): Boolean;
   {* Загружает состояние формы. Для перекрытия в потомках }
  procedure SetPositionByDS;
   {* Вызывается когда нужно изменить позицию используя источник данных. [$136258455] }
  function NeedDrawCaption: Boolean;
   {* Нужно ли рисовать заголовок зоны }
  procedure BecomeActive;
  function SettingsSuffix: AnsiString;
  procedure SetActiveControl;
   {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
  function DoGetTabInfo(out theCaption: Il3CString;
   out theItemIndex: Integer): Boolean;
   {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
  procedure BecomeInactive;
  function SaveOwnFormState(out theState: IvcmBase;
   aStateType: TvcmStateType;
   aForClone: Boolean): Boolean;
  procedure PageActive; overload;
  procedure PageInactive; overload;
  procedure UpdateCaption(const aCaption: IafwCString);
   {* установить заголовок формы. }
  function BoundsRect: TRect;
   {* прямоугольник, который занимает форма. }
  procedure PageInactive; overload;
   {* активная закладка стала не активной. }
  procedure PageActive; overload;
   {* закладка стала активной. }
  function Weight: Integer;
   {* вес компонента, учитывается при размещении закладок. }
  function ProcessCommand(Cmd: Tl3OperationCode;
   aForce: Boolean;
   aCount: Integer): Boolean;
  procedure StartNewMainForm;
   {* вызывается перед созданием главной формы }
  procedure BeforeCustomize;
   {* вызывается перед вызовом окна редактирования панелей инструментов }
 end;//TvcmEntityForm
 
implementation

uses
 l3ImplUses
 , l3VCLFormPtrList
 , vcmFormsUtils
 , vcmControlList
 , TtfwClassRef_Proxy
 , VCMFormsProcessingPack
 , afwFacade
 , afwSettingsChangePublisher
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 IvcmFormState = interface(IvcmBase)
  procedure LoadState(aForm: TvcmEntityForm;
   aStateType: TvcmStateType);
 end;//IvcmFormState
 
 IvcmStateItem = interface
  procedure LoadState(aForm: TvcmEntityForm;
   aStateType: TvcmStateType);
 end;//IvcmStateItem
 
 TvcmFormState = class(Tl3ProtoDataContainer, IvcmBase, IvcmFormState)
  procedure AddState(const aName: AnsiString;
   const aState: IUnknown);
  procedure LoadState(aForm: TvcmEntityForm;
   aStateType: TvcmStateType);
 end;//TvcmFormState
 
end.
