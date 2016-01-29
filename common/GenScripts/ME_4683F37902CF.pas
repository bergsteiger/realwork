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
  {* ������ VCM. }
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
  {* ��� ��� ������ �� ������� ���� ������� }
 
 PvcmStringID = ^TvcmStringID;
 
 TvcmOperationCode = Tl3OperationCode;
  {* ������� ������������ ���������� � ���������� ������������ ��������� ShortCut-�� }
 
 IvcmData = interface
  {* ������� ��������� ������ }
  function Clone: IvcmData;
   {* ������� ����� }
 end;//IvcmData
 
 IvcmObjectWithData = interface
  {* ������ � ������� }
 end;//IvcmObjectWithData
 
 TvcmTestEvent = procedure(const aParams: IvcmTestParamsPrim) of object;
  {* ���������� � ������ �������� ����������� �������� �� �������� ����. }
 
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
   {* ����� �� ��������� ����� � ������� �������� (��������, �� ������� ����) }
 end;//MvcmLayout
 *)
 
 IvcmLayout = interface
  function IsAcceptable(aDataUpdate: Boolean): Boolean;
   {* ����� �� ��������� ����� � ������� �������� (��������, �� ������� ����) }
 end;//IvcmLayout
 
 TvcmFormID = vcmBaseTypes.TvcmFormID;
  {* ������������� �����. }
 
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
  {* ������ ������ ����� }
  function IsDataAvailable: Boolean;
   {* ���������� �� ������ � ������� ��������. ��������, �� ������� ����. }
  function IsSame(const aValue: IvcmFormDataSource): Boolean;
   {* �������� �� ��������� }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ������� � ������ }
  function IsLikeViewAreaController(const aDataSource: IvcmFormDataSource): Boolean;
   {* ��������� ����� �� ������ ������� �� ������ }
  function CastUCC(const aGUID: TGUID;
   out theObj;
   NeedsException: Boolean): Boolean;
   {* �������� ���������� ���������� � ��������� ����������. ��� �����, ����� ��������� �� ������ ������ � ����������� ����������. [$122674504] }
 end;//IvcmFormDataSource
 
 IvcmExecuteParams = interface(IvcmFlexParams)
  {* ��������� ���������� ��������. }
  procedure SetControlEvent(anEvent: TvcmControlEvent);
  function BasePart: IvcmParams;
 end;//IvcmExecuteParams
 
 IvcmFormSet = interface;
 
 IvcmFormSetRefreshDataParams = interface;
 
 IvcmFormSetDataSource = interface(IvcmObjectWithData)
  {* ��������� ������ ������� ������ ����. [$54689847] }
  procedure BeginRefresh;
   {* ���������� ����� ������� ���������� }
  procedure EndRefresh;
   {* ���������� � ����� ���������� }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ������� � ������ }
  function IsLikeUseCaseController(const aDataSource: IvcmFormSetDataSource): Boolean;
   {* ��������� ����� �� ������������� ������ ��� ��� ������� � ������� �� ������ }
  function IsRefreshing: Boolean;
   {* ������ ��������� � ��������� ���������� }
  procedure PushFromHistory;
   {* ������ ���� ��������� �� ������� }
  procedure Refresh(const aParams: IvcmFormSetRefreshDataParams);
   {* �������� ������������� ������ }
  function MakeClone: IvcmFormSetDataSource;
  procedure PopToHistory;
 end;//IvcmFormSetDataSource
 
 TvcmCanClose = (
  {* ���������� ����������� �������� ����� }
  vcm_ccNone
   {* �� ����������. ���� � TvcmEntityForm.CanClose = vcm_ccNone,
                     � � TvcmZonesCollectionItem.CanClose <> vcm_ccNone, ��
                     ����� ������������� CanClose ��� � ���� �������� }
  , vcm_ccEnable
   {* ���� ����� ���� ������� }
  , vcm_ccDisable
   {* ���� �� ����� ���� ������� }
 );//TvcmCanClose
 
 IvcmDispatcher = interface;
 
 IvcmForm = interface(IvcmLayout)
  {* ������� ����� ����� ���������� VCM }
  function SafeClose: Boolean;
  function ShowModal: Integer;
 end;//IvcmForm
 
 TvcmFormDataSourceNotify = (
  {* ����������� ����������� _IvcmFormDataSource ���������� }
  vcm_dsnDestroy
 );//TvcmFormDataSourceNotify
 
 IvcmUserTypeDef = interface(IvcmBaseObjectDef)
 end;//IvcmUserTypeDef
 
 IvcmUserTypesIterator = interface
  function Next: IvcmUserTypeDef;
 end;//IvcmUserTypesIterator
 
 TvcmActivateIfUpdate = (
  {* ���������� ������ ��������� ����� (������� �������� ��������) ���
       ���������� ������. }
  wafNone
   {* �� ������������ }
  , wafAlways
   {* ������ ������������ }
  , wafIfNotActivated
   {* ������������ ������ ���� �� �������� � ������ ActivateIfUpdate }
 );//TvcmActivateIfUpdate
 
 IvcmEntityFormDef = interface(IvcmBaseObjectDef)
 end;//IvcmEntityFormDef
 
 TvcmBool = (
  {* ���������� ��� ������������ � VCM }
  vcm_bNone
  , vcm_bFalse
  , vcm_bTrue
 );//TvcmBool
 
 TvcmImageSize = (
  {* ������ ������. ������������ ��� �������� �������� ������ ��� ���� }
  isNone
  , isSmall
  , isLarge
  , isMedium
 );//TvcmImageSize
 
 IvcmToolbarStyle = interface
  {* ����� ������ ������������ }
  procedure Merge(const aStyle: IvcmToolbarStyle);
   {* ���������� ����� }
 end;//IvcmToolbarStyle
 
 IvcmToolbarsStyle = interface
  {* ������ ������� ������������ }
  procedure Merge(const aStyle: IvcmToolbarsStyle);
   {* ���������� ����� }
  function IsDefault: Boolean;
   {* ��� ����� �� ������� ���������� ������ }
  procedure ForbidMerge;
   {* ��������� ����������� ������� ������������ }
 end;//IvcmToolbarsStyle
 
 IvcmFormStyle = interface
  {* ����� VCM ����� }
  procedure Merge(const aStyle: IvcmFormStyle);
   {* ���������� ����� }
 end;//IvcmFormStyle
 
 IvcmEntity = interface;
 
 IvcmAggregate = interface;
 
 IvcmEntityForm = interface(IvcmForm)
  function SameName(const aName: TvcmFormID): Boolean;
   {* ��������� �������� �� ���������� ��� ������ �������� }
  function LoadState(const aState: IvcmBase;
   aStateType: TvcmStateType): Boolean;
  function SaveState(out theState: IvcmBase;
   aStateType: TvcmStateType): Boolean;
  function IsMainObjectForm: Boolean;
  function IsModalForm: Boolean;
   {* ������� ��������� ���� ���� IsModal, ���� False, �� ����������
             ��������� ����� ��������� ����� }
  function IsModal: Boolean;
   {* ����� �������� ��������� }
  function GetStatus(out theStatus: TvcmStatusStrings): Boolean;
  procedure SetActiveInParent;
   {* ������� �������� � ��������. ����������� ��� ���� ����������� � PageControl-� }
  procedure SetFirstActiveInParent;
   {* ������� �������� ������� � �������� }
  procedure SetActiveAndShowInParent;
   {* ������� �������� � ���������� ��������� �� ��� ������� }
  procedure SetInactiveInParent;
   {* ������� �������� ������������ � ��������. ����������� ��� ���� ����������� � PageControl-� }
  function IsActiveInParent: Boolean;
   {* �������� �� ����� �������� � ��������. ����������� ��� ���� ����������� � PageControl-� }
  procedure CloseInParent;
   {* ���������� ������� ����� �� ������� }
  procedure LockFocus;
  procedure UnlockFocus;
  procedure MakeAggregate;
  procedure RegInContainer;
  procedure UnregInContainer;
  function GetTabInfo(out theCaption: Il3CString;
   out theItemIndex: Integer): Boolean;
   {* ���������� ��� ��������, � ������� ����������� ����� }
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
   {* ��������� �������� � ��������� }
  procedure RemoveEntity(const anEntity: IvcmEntity);
   {* ������� �������� �� ��������� }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): IvcmExecuteParams; overload;
  function Operation(const anOp: TvcmOPID): IvcmExecuteParams; overload;
  function HasForm(const aName: TvcmFormID;
   theForm: PIvcmEntityForm): Boolean;
   {* ���������, ������������ �� ��������� ����� � ��������� }
 end;//IvcmAggregate
 
 (*
 vcmEntitiesContainer = interface
 end;//vcmEntitiesContainer
 *)
 
 IvcmFormSetFactory = interface;
 
 IvcmFormSet = interface(IvcmAggregate)
  {* ������ ���� }
  procedure Refresh(const aParams: IvcmFormSetRefreshDataParams);
   {* ��������� ������������� ������ }
  procedure SaveHistory;
   {* ��������� ������ � ������� }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ������� � ������ }
  function FindStatusInfoForm: IvcmEntityForm;
   {* ����� ����� ���������� �� ����� ������� }
  procedure PopToHistory;
   {* ������ �������� � ������� }
  procedure PushFromHistory;
   {* ������ ��������� �� ������� }
  procedure AssignFormList(aFormList: TvcmFormSetFormList);
   {* ��������� ���� ���� / ������� � ������ }
  function GetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr): TvcmNeedMakeDS;
  procedure SetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr;
   aNeedMakeDS: TvcmNeedMakeDS);
  function CastFS(const aGUID: TGUID;
   out theObj): Boolean;
  procedure SetFormClosed(const aForm: IvcmEntityForm);
   {* ���������� ������� ����, ��� ����� ���� ������� }
  procedure SetIfNeedMakeNo(const aFormDescr: TvcmFormSetFormItemDescr;
   aNeedMake: TvcmNeedMakeDS);
  procedure SaveFormList(aFormList: TvcmFormSetFormList);
  function MakeClone(const aContainer: IvcmContainer): IvcmFormSet;
 end;//IvcmFormSet
 
 TvcmSaveFormSetToHistory = (
  sfsNone
   {* ���������� ���� �� ��������� }
  , sfsAllForms
   {* ��������� ��� ����� }
  , sfsOnlyIfDataSourceChanged
   {* ��������� ������ ������������ ����� }
 );//TvcmSaveFormSetToHistory
 
 IvcmFormSetRefreshDataParams = interface
 end;//IvcmFormSetRefreshDataParams
 
 IvcmEntityFormIterator = interface
  {* �������� ���� }
  function Next: IvcmEntityForm;
 end;//IvcmEntityFormIterator
 
 TvcmMainFormInfo = record
  {* ���������� � ������� �����. }
 end;//TvcmMainFormInfo
 
 IvcmFormSetIterator = interface
  function Next: IvcmFormSet;
 end;//IvcmFormSetIterator
 
 IvcmAggregateIterator = interface
  function Next: IvcmAggregate;
 end;//IvcmAggregateIterator
 
 IvcmContainer = interface
  {* ��������� ���� }
  function NeedSetFocusToMainObjectFormOnRefresh: Boolean;
   {* ���� �� ����������� ����� � ������� ����� ��� ��������� ������ }
  procedure SetTabCaption(const aTabCaption: IvcmCString);
  procedure InitFromPrevContainer(const aPrevContainer: IvcmContainer;
   aClone: Boolean);
  procedure RegForm(const aForm: IvcmEntityForm);
  procedure UnregForm(const aForm: IvcmEntityForm);
  function InsertForm(const aForm: IvcmEntityForm): Boolean;
   {* ��������� ����� � ��������� }
  function HasForm(const aName: TvcmFormID;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   theForm: PIvcmEntityForm;
   aUserType: TvcmUserType;
   aGUID: PGUID;
   aSubUserType: TvcmUserType): Boolean; overload;
   {* ��������� ���� �� � ���������� ����� ����� }
  function HasForm(aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   theForm: PIvcmEntityForm;
   aUserType: TvcmUserType;
   aGUID: PGUID;
   aSubUserType: TvcmUserType): Boolean; overload;
   {* ��������� ���� �� � ���������� ����� ����� }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
   {* ���������� �������� �� ����� �������� }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams): Boolean; overload;
   {* ���������� �������� �� ����� �������� }
  function Operation(const anOp: TvcmOPID;
   aMode: TvcmOperationMode): Boolean; overload;
   {* ���������� �������� �� ����� �������� }
  function IsNull: Boolean;
  procedure FormStyle(const aForm: IvcmEntityForm;
   const aStyle: IvcmFormStyle);
   {* ��������� ����� ����� }
  procedure SetFocusToMainObjectForm;
   {* ������������� ����� � ����� ��������� ����� ��������� ���� }
  procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
   const anOld: IvcmFormDataSource;
   const aNew: IvcmFormDataSource);
   {* ���������� ��� ��������� ��������� ������ ��������� ����� }
 end;//IvcmContainer
 
 IvcmParams = interface(IvcmBaseParamsPrim)
  {* ��������� �������� }
  procedure SetContainerPrim(const aContainer: IvcmContainer;
   aReplace: Boolean);
 end;//IvcmParams
 
 IvcmEntity = interface
  {* �������� }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmParams;
   aMode: TvcmOperationMode): Boolean; overload;
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams): Boolean; overload;
 end;//IvcmEntity
 
 IvcmHistoryItem = interface
  {* ������� ������� ���������� }
  function Activate(const aMainForm: IvcmEntityForm): Boolean; overload;
  function Activate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean; overload;
  function Drop: Boolean;
  function IsAcceptable: Boolean;
   {* ����� �� �������������� ������� ������� � ������� �������� }
 end;//IvcmHistoryItem
 
 TvcmHistoryItemType = (
  {* ���� �������� �������. }
  vcm_hitNone
   {* �������. }
  , vcm_hitClose
   {* �������� ���������� � ����� ������� ������ ���� �������,
            �������������� �������� ������ ������������ �����. }
  , vcm_hitContent
   {* �������� ���������� � �����, ������� ������ ���� �������, �� �����
           �������� ������� ������ ������� � ��������� hitClose. }
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
   {* ������� ���� ������� �� ������ Back }
  function GetBackCount: Integer;
  function GetForwardCount: Integer;
  function GetBackItem(anIndex: Integer): Il3CString;
  function GetForwardItem(anIndex: Integer): Il3CString;
  procedure DeleteForwardItem;
   {* ������� ���� ������� �� ������ Forward }
  procedure ResetContainer;
  procedure SaveClone(const aForm: IvcmEntityForm);
  procedure BeforeFormDestroy(const aForm: IvcmEntityForm);
  function ForceSaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): Boolean;
   {* ���������� ��� �������� ������������� ���������� ����� }
  function SaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): Boolean;
  procedure SaveClose(const aForm: IvcmEntityForm;
   const aFormID: TvcmFormID;
   aUserType: TvcmUserType;
   aZoneType: TvcmZoneType;
   aSubUserType: TvcmUserType);
   {* ����� ������� ������ ���� ������� ��� �������� �� ������� }
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
   {* ��������� ������ � ������� }
  function IsLast: Boolean;
  function InBack: Boolean;
   {* ��������� � �������� Back, ���� ���, �� Forward }
  procedure Clear(aHeedCheckCurrent: Boolean);
   {* ������� ������� }
  function MakeState: IvcmHistoryState;
  procedure AssignState(const aState: IvcmHistoryState);
 end;//IvcmHistory
 
 IvcmLockListener = interface
  {* ��������� ���������� }
  procedure Lock;
   {* ��������� ��������� }
  procedure BeforeUnlock;
   {* ���������� �������� ��� �����������, �� ��������� ��� ��������� }
  procedure Unlock;
   {* ��������� ��������� }
 end;//IvcmLockListener
 
 IvcmMainFormProvider = interface;
 
 IvcmFormDispatcher = interface
  {* ��������� ���� ���������� }
  procedure AddForm(const aForm: IvcmEntityForm);
   {* �������� ����� ����� � ���������� }
  procedure RemoveForm(const aForm: IvcmEntityForm);
   {* ������� ����� �� ���������� }
  procedure ShowMainForm(const aForm: IvcmEntityForm);
   {* �������� ������� ����� }
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
   {* ���������� ����� ������� �����.
             aSourceMainForm:
               - ����� �� ������� ������� �������� ����� }
  procedure StartNewMainForm;
   {* ���������� ����� ������� �������� ������� ����� }
 end;//IvcmFormDispatcher
 
 IvcmMainFormProvider = interface
 end;//IvcmMainFormProvider
 
 IvcmModule = interface;
 
 IvcmEntityFormsIterable = interface;
 
 IvcmDispatcher = interface
  {* ��������� ���������� }
  procedure BeginRestoreAllSettings;
  procedure EndRestoreAllSettings;
  procedure RestoreFormSize;
   {* ������������ ������ ����������� �� ����� (��������������� �������
             ������� Design-Time, ����� ������ �� ��������) }
  procedure ReloadAllToolbars;
   {* ������������� ���������� toolbar-�� � ���� �������� � ������ ������
             ���� }
  function EntityOperation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): Boolean; overload;
  procedure EntityOperation(const anOp: TvcmOPID;
   const aParams: IvcmTestParams); overload;
  procedure EntityOperationBroadcast(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams);
  procedure CallModuleOperation(const anOp: TvcmMOPID;
   const aParams: IvcmExecuteParams);
   {* ��������� �������� ������. (!) ������ ��� ������ ������� VCM. �� ��� ������������� �� ������ }
  procedure ModuleOperation(const anOp: TvcmMOPID;
   const aParams: IvcmTestParams); overload;
   {* ��������� �������� ������ }
  function ModuleOperation(const anOp: TvcmMOPID): Boolean; overload;
   {* ��������� �������� ������ }
  function GetModuleByID(aModuleID: TvcmControlID): IvcmModule;
   {* ���������� ������ �� �������������� }
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
   {* ����������� OnTest-� ��������. ���������� ����� ������� ��������� �
             ���������� ��������� � �� ��� ������ ��������� }
  procedure AddObjectForFree(O: TObject);
  procedure ReinsertForms;
   {* ������������ �������� ���� }
  procedure TileWindowsHorizontal(const aForms: IvcmEntityFormsIterable);
   {* ����������� �������� ���� ���������� ������������� }
  procedure TileWindowsVertical(const aForms: IvcmEntityFormsIterable);
   {* ����������� �������� ���� ���������� ���������� }
  procedure CascadeWindows(const aForms: IvcmEntityFormsIterable);
   {* ����������� �������� ���� �������� }
  procedure CloseAllWindows(const aForms: IvcmEntityFormsIterable;
   const aCurrent: IvcmEntityForm);
   {* ������� ��� �������� ���� ����� ��������, ���� �� �� ������, �� ����������� ���������� }
  procedure LockInOp;
   {* ���������� ������ BeginOp/EndOp }
  procedure UnlockInOp;
   {* ���������� ������ BeginOp/EndOp }
 end;//IvcmDispatcher
 
 TvcmEntityOperationsOption = (
  {* ��� ��������� ��������� }
  vcm_enoGroupItemsInContextMenu
   {* ������������ �������� � ����������� ���� }
 );//TvcmEntityOperationsOption
 
 TvcmEntityOperationsOptions = set of TvcmEntityOperationsOption;
 
 IvcmEntityDef = interface(IvcmOperationalIdentifiedUserFriendlyControl)
  {* �������� �������� }
 end;//IvcmEntityDef
 
 IvcmEntitiesDefIterator = interface
  {* �������� �������� ��������� }
 end;//IvcmEntitiesDefIterator
 
 IvcmModuleDef = interface(IvcmOperationalIdentifiedUserFriendlyControl)
  function Make: IvcmModule;
   {* ������� ������ }
 end;//IvcmModuleDef
 
 IvcmModule = interface
  {* ������ (��� �� �� ����� ���� ������������ - � � ��� ������ �� �������) }
  procedure Operation(anID: TvcmControlID;
   const aParams: IvcmParams;
   aMode: TvcmOperationMode);
   {* ��������� �������� ������ }
  function GetOperationByID(anID: TvcmControlID): IvcmOperationDef;
 end;//IvcmModule
 
 PIvcmEntityForm = ^IvcmEntityForm;
 
 TvcmInitProc = procedure(aForm: TWinControl);
 
 // TvcmEffectiveUserType
 
 TvcmFormSetID = object
  {* ������������� ������. }
 end;//TvcmFormSetID
 
 PvcmFormSetID = ^TvcmFormSetID;
 
 IvcmFormSetRefreshParams = interface(IvcmFormSetRefreshDataParams)
  {* ��������� ���������� ������ }
 end;//IvcmFormSetRefreshParams
 
 IvcmFormSetSimpleFactory = interface;
 
 IvcmFormSetFactory = interface
  {* ������� ������ }
  procedure Refresh(const aParams: IvcmFormSetRefreshParams);
   {* ��������� ������ ������.
            aDataForHistory - ������ aDataSource, ������� ���������� ���������
                              � ������� }
  procedure SaveHistory(const aContainer: IvcmContainer;
   aNeedSaveUseCaseData: Boolean);
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ������� � ������ }
  function IsDefaultStatusForm(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ���������� �� ����� ������� }
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
  {* ����� ����� ���� ������� }
 
 // TvcmEffectiveZoneType
 
 TvcmEffectiveZoneTypes = set of TvcmEffectiveZoneType;
  {* ��������� ����� �������� ��� ������� }
 
 IvcmMakeParams = interface(IvcmBase)
 end;//IvcmMakeParams
 
 TvcmFormFactory = function(const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aUserType: TvcmEffectiveUserType;
  aGUID: PGUID;
  const aDataSource: IvcmFormDataSource;
  aSubUserType: TvcmUserType;
  aAfterCreate: TvcmInitProc): IvcmEntityForm of object;
  {* ������� ����� VCM }
 
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
  {* ��������� ��� �������� ����� ������� ����� }
  vcm_okInCurrentTab
   {* � ������� ������� }
  , vcm_okInNewTab
   {* � ����� ������� }
  , vcm_okInNewWindow
   {* � ����� ���� }
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
