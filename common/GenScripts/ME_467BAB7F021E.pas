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
  {* ��� �������������� ������������ ��������. }
 
 IvcmNode = Il3SimpleNode;
 
 TvcmStateType = (
  {* ���������� ��� �������� ��� ����� ���������� � �������� �������. }
  vcm_stContent
   {* ������ �����. }
  , vcm_stPosition
   {* �������� ������ ������� � ������ �����. }
 );//TvcmStateType
 
 IvcmCString = IafwCString;
  {* ��������� ������ � ���������� ��������� ��������� }
 
 TvcmOperationType = (
  {* ��� ������������� ��������. }
  vcm_otButton
   {* �������� ������������ ����. �������������� ���
                       ������ � ���� � ������ �� ������ ������������. }
  , vcm_otShortCut
  , vcm_otTextButton
  , vcm_otButtonCombo
  , vcm_otButtonPopup
  , vcm_otCheck
   {* �������� � ������������ �������. ������������ ���
                       ������ � �������� � ����. }
  , vcm_otRadio
  , vcm_otEdit
  , vcm_otTyper
  , vcm_otCombo
   {* ���������� ������ �����. � ���� ������������ ���
                       �������, �� ������ ������������ - ��� ����������
                       ������ �����. }
  , vcm_otMenuButtonCombo
  , vcm_otEditCombo
  , vcm_otFontName
   {* ���������� ������ ���� �������. � ����
                       ������������ ��� �������, �� ������ ������������ -
                       ��� ���������� ������ �����. }
  , vcm_otFontSize
   {* ���������� ������ �������� �������. � ����
                       ������������ ��� �������, �� ������ ������������ -
                       ��� ���������� ������ �����. }
  , vcm_otDate
  , vcm_otInternal
   {* ���������� �������� ��������. �� ������������ �� � ����, �� �� ������ ������������. �������� �� �������� }
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
  {* ������ ���������� ��������. }
  vcm_dsNotDone
   {* �� ��������� }
  , vcm_dsDisabled
   {* �������� ��������� (Disabled) }
  , vcm_dsInvalidParams
   {* �������� ����� ���������� }
  , vcm_dsSkippedInTest
   {* �������� OnTest - ������ ������ ���� }
  , vcm_dsExcludedInUserType
   {* ��������� � ������ UserType'� }
  , vcm_dsNoAggregate
   {* ��� ��������� }
  , vcm_dsNoEntity
   {* ��� ����� �������� }
  , vcm_dsFormInClose
   {* ����� ����������� }
  , vcm_dsNullContainer
   {* �������� ������ ������-���������� }
  , vcm_dsDone
   {* �������� ��������� }
 );//TvcmDoneStatus
 
 IvcmStrings = IafwStrings;
  {* ������ �����. }
 
 TvcmOPID = record
  {* ������������� �������� �������� }
 end;//TvcmOPID
 
 IvcmBase = interface
  {* ������� ��������. ������ ��� ��������. }
 end;//IvcmBase
 
 TvcmMOPID = record
  {* ������������� �������� ������. }
 end;//TvcmMOPID
 
 TvcmOpKind = (
  vcm_okNone
  , vcm_okModule
  , vcm_okEntity
 );//TvcmOpKind
 
 TvcmOpSelector = record
 end;//TvcmOpSelector
 
 IvcmItems = interface(IvcmStrings)
  {* ������ ��������� ��� ������. }
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
  {* ������. }
 
 IvcmFont = IafwFont;
  {* �����. }
 
 TvcmOpFlag = (
  {* �������� ��������. }
  vcm_ofEnabled
  , vcm_ofVisible
  , vcm_ofChecked
  , vcm_ofDefault
 );//TvcmOpFlag
 
 IvcmNodes = interface
  {* ���� ��� ���������� ���� ��������. }
  procedure Clear;
   {* ������� ������. }
  function Add(const anItem: IvcmNode): Integer;
   {* ��������� ���� � ������. }
 end;//IvcmNodes
 
 IvcmBaseParamsPrim = interface
  function CallControl: Boolean;
 end;//IvcmBaseParamsPrim
 
 IvcmOpParams = interface
  {* ��������� ��������. }
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
  {* ��������� ��������. }
 end;//IvcmFlexParams
 
 TvcmControlTestEvent = procedure(const aParams: IvcmTestParamsPrim) of object;
  {* ���������� � ������ �������� ����������� �������� �� �������� ���� }
 
 IvcmToolbarNotifier = interface
  {* ��������� ������������ ��� ����������� ���������� ���� vcm_ztNavigator
       � ������� toolbar-� � ���������� �������� � ������������ TvcmDateEdit,
       TvcmEdit. }
  procedure SmallToolbarSize(aValue: Integer);
 end;//IvcmToolbarNotifier
 
 IvcmDockType = interface
  {* ��� ������� (��� ZonesCollectionItem.IsControlPanel) }
 end;//IvcmDockType
 
 IvcmPopupIgnoresAction = interface
 end;//IvcmPopupIgnoresAction
 
 IvcmSettingsUser = interface
  procedure WriteBackSettings;
 end;//IvcmSettingsUser
 
 TvcmControlExecuteEvent = TvcmControlEvent;
  {* ���������� ��� ���������� �������� �� �������� ����. }
 
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
   {* ��������� ������� �������� �����. }
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
  {* ���������� �����. }
  function CanHaveCloseButtonInNavigator: Boolean;
  function CanHaveOwnCloseButtonInNavigator: Boolean;
 end;//IvcmFormHandler
 
 IvcmFormHandlersPublisher = interface
  {* ������������ �������, ������� ��������� ����������� �����. }
  procedure Publish(const aCloseHandler: IvcmFormHandler);
 end;//IvcmFormHandlersPublisher
 
 TvcmControlGetStateEvent = procedure(var State: TvcmOperationStateIndex) of object;
  {* ���������� ������� ��� ����������� ��������� �������� }
 
 IvcmCloseFormHandlerWatcher = interface
  {* �������������� �� ������������ �������� ����� }
  procedure SetWatch(const aHandler: IvcmFormHandler);
 end;//IvcmCloseFormHandlerWatcher
 
 IvcmOperationsPublisher = interface
  {* ������� �������������� �������� ������������. }
  procedure PublishEntity(const anEntity: TvcmString;
   aGetTarget: TvcmControlGetTargetEvent);
   {* ������������ ��������. }
  procedure PublishOp(const anEntity: TvcmString;
   const anOperation: TvcmString;
   anExecute: TvcmControlExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent;
   aNoPrefix: Boolean);
   {* ������������ ��������. aNoPrefix - ������� ��� [$133891300] }
 end;//IvcmOperationsPublisher
 
 IvcmOperationsProvider = interface
  {* ������� � ���������� ��������. }
  procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
   {* ������������ ������ ��������� ��������. }
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
   {* ���������� ��� ������� ������� ����� }
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
