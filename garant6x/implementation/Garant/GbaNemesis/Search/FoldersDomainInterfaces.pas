unit FoldersDomainInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/FoldersDomainInterfaces.pas"
// Начат: 09.02.2009 14:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::Search::FoldersDomainInterfaces
//
// Модель папок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseTypesUnit,
  BaseTreeSupportUnit,
  FoldersUnit,
  FiltersUnit,
  UnderControlUnit,
  SecurityUnit,
  l3Interfaces,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Tree_TLB,
  bsTypes
  ;

type
 TnsShowFolders = (
  {* Определяет какие папки в дереве "Мои документы" нужно показывать }
   sfAll // показывать все папки
 , sfMyDocuments // папку мои документы
 , sfMyDocumentsAndCommon // Мои документы и Общие
 );//TnsShowFolders

 TnsFolderFilterFor = (
  {* Место вызова фильтра }
   ns_ffDrug
 , ns_ffDocument
 , ns_ffNone
 );//TnsFolderFilterFor

 TnsFolderFilter = (
   ffNone
 , ffBookmark
 , ffList
 , ffQuery
 , ffListAndBookMarks
 );//TnsFolderFilter

 InsFolderFilterInfoListener = interface(Il3Notify)
  {* Слушатель событий информации о фильтре }
   ['{E13CC3ED-70F4-4F51-B09A-593EB211A526}']
   procedure Changed;
     {* фильтр изменился }
 end;//InsFolderFilterInfoListener

 InsFolderFilterInfo = interface(IUnknown{, Il3ChangeNotifier})
   ['{D2451B25-8EAE-4C4D-B86D-59BE6282F60D}']
   function pm_GetFilterFor: TnsFolderFilterFor;
   function pm_GetFilterType: TnsFolderFilter;
   procedure pm_SetFilterType(aValue: TnsFolderFilter);
   function pm_GetShowFolders: TnsShowFolders;
   procedure pm_SetShowFolders(aValue: TnsShowFolders);
   function IsSame(const aValue: InsFolderFilterInfo): Boolean;
   property FilterFor: TnsFolderFilterFor
     read pm_GetFilterFor;
   property FilterType: TnsFolderFilter
     read pm_GetFilterType
     write pm_SetFilterType;
   property ShowFolders: TnsShowFolders
     read pm_GetShowFolders
     write pm_SetShowFolders;
  // Методы преобразования к реализуемым интерфейсам
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
 end;//InsFolderFilterInfo

 InsFoldersInfo = interface(IUnknown)
   ['{144A25CD-7101-4CBE-BB7E-7959684ED2A4}']
   function pm_GetCantChangeFilter: Boolean;
   procedure pm_SetCantChangeFilter(aValue: Boolean);
   function pm_GetFilterInfo: InsFolderFilterInfo;
   procedure pm_SetFilterInfo(const aValue: InsFolderFilterInfo);
   function NodeHasVisibleChildren(const aNode: Il3SimpleNode): Boolean;
   property CantChangeFilter: Boolean
     read pm_GetCantChangeFilter
     write pm_SetCantChangeFilter;
   property FilterInfo: InsFolderFilterInfo
     read pm_GetFilterInfo
     write pm_SetFilterInfo;
 end;//InsFoldersInfo

 TFoldersElementType = (
   fetNone
 , fetBookmark
 , fetList
 , fetQuery
 , fetDrugBookmark
 , fetDrugList
 );//TFoldersElementType

 TFoldersInfoType = (
   fiNone
 , fiNewFolder
 , fiEdit
 , fiLoad
 , fiSave
 , fiSelect
 );//TFoldersInfoType

 TFolderOperationType = (
   fotNone
 , fotAdd
 , fotModify
 , fotDelete
 , fotOverride
 );//TFolderOperationType

 InsFolderNodeListener = interface(Il3Notify)
  {* Слушатель событий узла дерева "Мои документы". }
   ['{55692E10-34ED-4FF1-BE30-D05322EBD66B}']
   procedure ChildNodeAdded(const aNode: Il3SimpleNode);
     {* был добавлен дочерний узел }
 end;//InsFolderNodeListener

 InsFolderNodeNotify = interface(IUnknown)
  {* Уведомляет о событиях узлов дерева }
   ['{217915C3-9FB0-4BB5-8DA2-33034A0421E0}']
   procedure AddListener(const aListener: InsFolderNodeListener);
     {* добавить слушателя }
   procedure RemoveListener(const aListener: InsFolderNodeListener);
     {* удалить слушателя }
 end;//InsFolderNodeNotify

 TFoldersNodeChangeEvent = (
   fnceNone
 , fnceChangeFilterType
 , fnceChangeControlledState
 , fnceRenameFilter
 );//TFoldersNodeChangeEvent

 TFoldersNodeDeleteEvent = (
   fndeNone
 , fndeQuery
 , fndeControlled
 );//TFoldersNodeDeleteEvent

 InsFolderNodeNotifyObject = interface(IUnknown)
   ['{2B070BEC-E82D-42DE-AE35-118AE9B1B8F9}']
   procedure NodeChanged(const aNode: INode;
    anEvent: TFoldersNodeChangeEvent);
   procedure NodeBeforeDelete(const aNode: INode;
    anEvent: TFoldersNodeDeleteEvent);
   procedure NodeDeleted(aFlags: Integer;
    aNodeType: TFoldersItemType);
 end;//InsFolderNodeNotifyObject

 InsFolderNodeNotification = interface(IUnknown)
   ['{EC791322-3830-4D59-9F9C-E8D4E770CBF2}']
   procedure ChangedNotify(const aNode: INode;
    anEvent: TFoldersNodeChangeEvent);
   procedure BeforeDeleteNotify(const aNode: INode;
    anEvent: TFoldersNodeDeleteEvent);
   procedure AfterDeleteNotify(aFlags: Integer;
    aNodeType: TFoldersItemType);
 end;//InsFolderNodeNotification

 TFoldersActions = (
   faView
 , faModify
 , faDelete
 , faAddChild
 , faChangeRights
 );//TFoldersActions

 InsNodeWithRights = interface(IUnknown)
   ['{C2339314-0E2C-4F1B-8DF7-64F6A9DD6EC7}']
   function CheckRights(aAction: TFoldersActions): Boolean;
   procedure DropUserRightsCache;
   procedure DropAllChildrenUserRightsCache;
 end;//InsNodeWithRights

 TFiltersType = (
   fttNone
 , fttLocal
 , fttGlobal
 );//TFiltersType

 InsFoldersNode = interface(InsNodeWithRights)
   ['{9EBE48CF-E8AE-4FAA-BF3C-FD3AB66C4E54}']
   procedure SetUnderControlStatus(aState: Boolean);
   procedure ChangeUnderControlStatus;
   procedure DropContentCache;
 end;//InsFoldersNode

 TFoldersActionsSet = set of TFoldersActions;

 InsChildTree = interface(InsFolderNodeNotification{, Il3ChangeNotifier})
   ['{96E5B2CE-5055-4694-9B51-1CE38D37B6A1}']
   function pm_GetRoot: Il3SimpleNode;
   procedure AddChild(const aChild: INode);
   property Root: Il3SimpleNode
     read pm_GetRoot;
  // Методы преобразования к реализуемым интерфейсам
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
 end;//InsChildTree

 InsUnderControlRootListener = interface(Il3Notify)
  {* Слушатель событий корня списка документов на контроле }
   ['{16D88C26-7BFA-4F05-8062-9154F64C1BAB}']
   procedure Updated;
     {* список обновился }
 end;//InsUnderControlRootListener

 TnsUCSortType = (
   ucstChanging
 , ucstAlphabet
 );//TnsUCSortType

 InsUnderControlInfo = interface(IUnknown)
  {* Информация о документах на контроле }
   ['{CC034875-958F-4CBC-B092-3B421363CE4F}']
   function pm_GetSortType: TnsUCSortType;
   procedure pm_SetSortType(aValue: TnsUCSortType);
   property SortType: TnsUCSortType
     read pm_GetSortType
     write pm_SetSortType;
 end;//InsUnderControlInfo

 InsUnderControlRoot = interface(IUnknown)
  {* Корень списка документов на контроле }
   ['{0762F9F4-B69E-4AD8-919D-071BAAC3141B}']
   function pm_GetSortType: TnsUCSortType;
   procedure pm_SetSortType(aValue: TnsUCSortType);
   property SortType: TnsUCSortType
     read pm_GetSortType
     write pm_SetSortType;
 end;//InsUnderControlRoot

 InsUnderControlNode = interface(IUnknown)
  {* Узел списка документов на контроле }
   ['{21671F5F-F4E8-4807-BE84-8CEC54CC9693}']
   function pm_GetStatus: Integer;
   function pm_GetIsOpened: Boolean;
   procedure pm_SetIsOpened(aValue: Boolean);
   function pm_GetDocumentStatus: TItemStatus;
   procedure ResetStatus;
   property Status: Integer
     read pm_GetStatus;
   property IsOpened: Boolean
     read pm_GetIsOpened
     write pm_SetIsOpened;
   property DocumentStatus: TItemStatus
     read pm_GetDocumentStatus;
 end;//InsUnderControlNode

 TnsKnownDefferedTree = (
   kdtFolders
 , kdtDocumentFilters
 , kdtDrugFilters
 , kdtUnknown
 );//TnsKnownDefferedTree

 InsDefferedTreeListener = interface(IUnknown)
   ['{14C8C8B1-CCD8-48EC-9E1C-CA96B920EA63}']
   procedure TreeLoaded(aTree: TnsKnownDefferedTree);
 end;//InsDefferedTreeListener

 InsReloadedTree = interface(IUnknown)
   ['{9E17745D-E754-40B3-880A-8F1375D3B712}']
   procedure ReloadChildren(const aNode: INode);
 end;//InsReloadedTree

 InsControlledList = interface(IUnknown)
   ['{9D1C666C-1B53-4F6D-BFF8-EB4201546289}']
   procedure AddControllable(const aControllable: IControllable);
   procedure DeleteControllable(const aControllable: IControllable);
   procedure SetOpenedFlag(const aControllable: IControllable);
   procedure DropModifiedFlagForOpened(const aForm: IvcmEntityForm);
   procedure AddFakeNode;
 end;//InsControlledList

 TnsListMergeKind = (
   lmkAllow
 , lmkDeny
 , lmkAbort
 );//TnsListMergeKind

 InsDeferredTree = interface(IUnknown)
   ['{DB490843-BBB5-4DA7-A72E-6169A5E30E38}']
   function MakeRealRoot: Il3RootNode;
   procedure SetBuildedRoot(const aNewRoot: Il3RootNode);
   procedure WaitForReady;
   function IsReady: Boolean;
 end;//InsDeferredTree

 IdeSaveObject = interface(IUnknown)
  {* Объект папок }
   ['{2A047AC4-EBD3-4D90-8A75-0C11A7229DE1}']
   function pm_GetObjectType: TFoldersElementType;
   function pm_GetObjectValue: IUnknown;
   property ObjectType: TFoldersElementType
     read pm_GetObjectType;
     {* тип объекта }
   property ObjectValue: IUnknown
     read pm_GetObjectValue;
     {* сохраняемый объект }
 end;//IdeSaveObject
{$IfEnd} //not Admin AND not Monitorings

implementation

end.