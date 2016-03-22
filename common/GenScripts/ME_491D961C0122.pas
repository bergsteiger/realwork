unit AdminInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\AdminInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "AdminInterfaces" MUID: (491D961C0122)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3Interfaces
 , AdminDomainInterfaces
 , DynamicTreeUnit
 , SysUtils
 , TreeInterfaces
 , l3TreeInterfaces
 , l3InternalInterfaces
 , l3PureMixIns
 , SecurityUnit
 , bsTypes
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
;

type
 IdsForbidAutoregistration = interface
  {* Запрет авторегистрации }
  ['{3AD6F7F6-8949-4E2D-AB8D-390FC970D5A9}']
  function pm_GetPhone: Il3CString;
  procedure pm_SetPhone(const aValue: Il3CString); { can raise EdsMaxLengthExceed }
  function pm_GetEmail: Il3CString;
  procedure pm_SetEmail(const aValue: Il3CString); { can raise EdsMaxLengthExceed }
  function Get_NeedForbid: Boolean;
  procedure Set_NeedForbid(aValue: Boolean);
  property Phone: Il3CString
   read pm_GetPhone
   write pm_SetPhone;
  property Email: Il3CString
   read pm_GetEmail
   write pm_SetEmail;
  property NeedForbid: Boolean
   read Get_NeedForbid
   write Set_NeedForbid;
   {* Форма выставляет флаг, если нужно запретить авторегистрацию }
 end;//IdsForbidAutoregistration

 IdsUserProperty = interface
  {* Бизнес объект формы "efUserProperty" }
  ['{052ADD5C-A39A-41EA-9CE7-65CD4EC60DEA}']
  function Get_IsReadOnlyFor268342582: Boolean;
  procedure Set_IsReadOnlyFor268342582(aValue: Boolean);
  function Get_UID: Integer;
  function Get_GroupUID: Integer;
  function Get_Login: Il3CString;
  function Get_Name: Il3CString;
  function Get_Mail: Il3CString;
  function Get_IsChanged: Boolean;
  procedure Set_IsChanged(aValue: Boolean);
  function Get_IsNewUser: Boolean;
  function Get_CanBuyConsulting: Boolean;
  function Get_IsSystem: Boolean;
  function Get_IsPrivileged: Boolean;
  function Get_DontDeleteIdle: Boolean;
  procedure CreateUserProfile(const aLogin: Tl3WString;
   const aName: Tl3WString;
   const aMail: Tl3WString;
   const aPassword: Tl3WString;
   aCanBuyConsulting: Boolean;
   aIsPrivileged: Boolean;
   aGroupUID: Integer);
  procedure CreateUserFinished(Successfull: Boolean);
   {* Нотификация об отскзе создания пользователя }
  procedure CheckUnsavedUserProperty;
  function HasUserProfile: Boolean;
  function HasPassword: Boolean;
  procedure SaveUserProfile(const aName: Tl3WString;
   const aMail: Tl3WString;
   aCanBuyConsulting: Boolean;
   aIsPrivileged: Boolean;
   aDontDeleteIdle: Boolean;
   const aPassword: Tl3WString;
   aGroupUID: Integer;
   IsPasswordChanged: Boolean = False);
  procedure SaveUserInfo(const aName: Tl3WString;
   const aMail: Tl3WString;
   const aPassword: Tl3WString;
   IsPasswordChanged: Boolean = False);
  property IsReadOnlyFor268342582: Boolean
   read Get_IsReadOnlyFor268342582
   write Set_IsReadOnlyFor268342582;
   {* IsReadOnly - это "костыль" к К268342582 }
  property UID: Integer
   read Get_UID;
  property GroupUID: Integer
   read Get_GroupUID;
  property Login: Il3CString
   read Get_Login;
  property Name: Il3CString
   read Get_Name;
  property Mail: Il3CString
   read Get_Mail;
  property IsChanged: Boolean
   read Get_IsChanged
   write Set_IsChanged;
  property IsNewUser: Boolean
   read Get_IsNewUser;
  property CanBuyConsulting: Boolean
   read Get_CanBuyConsulting;
  property IsSystem: Boolean
   read Get_IsSystem;
  property IsPrivileged: Boolean
   read Get_IsPrivileged;
  property DontDeleteIdle: Boolean
   read Get_DontDeleteIdle;
 end;//IdsUserProperty

 TUserState = (
  {* Состояния пользователя для списка пользователей }
  usActive
  , usSystem
  , usExiting
 );//TUserState

 TUserStates = set of TUserState;
  {* Состояния пользователя для списка пользователей }

 TUserListFilterTypes = (
  {* Типы фильтров для списка пользователей }
  ulftNone
  , ulftActive
  , ulftUsual
  , ulftSystem
  , ulftConsultingEnabled
  , ulftConsultingDisabled
  , ulftPrivileged
  , ulftNonPrivileged
  , ulftWithoutGroup
 );//TUserListFilterTypes

 IdeNode = interface
  {* Интерфейс обмена данными содержащий Node }
  ['{5D00EAFC-C30A-45F3-96C5-E981574D42E4}']
  function pm_GetNode: INodeBase;
  property Node: INodeBase
   read pm_GetNode;
 end;//IdeNode

 ETryLogoutCurrentUser = class(Exception)
  {* Попытка отключить текущего пользователя }
 end;//ETryLogoutCurrentUser

 IdsAdmin = interface
  ['{8A098DB1-6F9C-452B-AA29-3497FD30A9B2}']
 end;//IdsAdmin

 TbsGroupNodeType = (
  gntUnknown
   {* Неизвестно }
  , gntSystem
   {* Системная группа }
  , gntUsual
   {* Обычная группа }
 );//TbsGroupNodeType

 IbsUserListViewListener = interface(Il3Notify)
  ['{E050E43C-8AD2-4FE5-92CF-B2B5A8F78DB3}']
  procedure CreateUserFinished(Successfull: Boolean);
  procedure GroupChanged(aGroupUID: Integer);
   {* Сменилась группа }
  procedure RequestUpdateCurrent;
 end;//IbsUserListViewListener

 IdsGroupsList = interface(IdsSimpleTree)
  {* Группы пользователей }
  ['{9132AE46-655E-4237-81CC-EAB73967E8DA}']
  procedure NotifyTreeViewInvalidate;
  function GroupsListNodeType(const aNode: Il3SimpleNode): TbsGroupNodeType;
   {* Тип ноды }
  procedure DeleteGroup(const aNode: Il3SimpleNode);
   {* Удалить группу }
  procedure CreateNewGroup;
   {* Создать группу }
  function ChangeBasesAccessForGroup(const aNode: Il3SimpleNode): Boolean;
  procedure RenameGroup(const aNode: Il3SimpleNode);
   {* Переименовать группу }
  function HasUsers(const aNode: Il3SimpleNode): Boolean;
   {* Есть ли пользователи в группе }
  procedure CheckUnsavedUserProperty;
   {* Если свойства не сохранены - спросить об этом }
 end;//IdsGroupsList

 //_ItemType_ = Il3SimpleNode;
 IadminUserNodeList = interface
  ['{C963E478-2414-4D17-A1FB-9549248012E4}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: Il3SimpleNode;
  function pm_GetLast: Il3SimpleNode;
  function pm_GetItems(anIndex: Integer): Il3SimpleNode;
  function pm_GetCount: Integer;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: Il3SimpleNode
   read pm_GetFirst;
   {* Первый элемент. }
  property Last: Il3SimpleNode
   read pm_GetLast;
   {* Последний элемент. }
  property Items[anIndex: Integer]: Il3SimpleNode
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* Число элементов. }
 end;//IadminUserNodeList

 IbsEditGroupName = interface
  {* Редактировщик имени группы }
  ['{B893553B-CB1F-4A88-9EF6-DF904B7A1A11}']
  function Get_Name: Il3CString;
  procedure Set_Name(const aValue: Il3CString);
  property Name: Il3CString
   read Get_Name
   write Set_Name;
   {* Имя }
 end;//IbsEditGroupName

 EDuplicateGroupName = class(Exception)
  {* Дублирующееся имя группы.
Имя группы идет как Message }
 end;//EDuplicateGroupName

 IbsUserPropertyListener = interface(Il3Notify)
  ['{4DBE54A4-7C28-4EFB-804F-64943FB4043D}']
  procedure CheckUnsavedProperties;
 end;//IbsUserPropertyListener

 IdeAdmin = interface
  ['{622B8389-BAF4-43D9-B829-D78CE2DF5D7A}']
  function pm_GetGroups: IdeNode;
  function pm_GetUsers: IdeNode;
  property Groups: IdeNode
   read pm_GetGroups;
  property Users: IdeNode
   read pm_GetUsers;
 end;//IdeAdmin

 IdeProfile = interface
  ['{135CCCDC-EB25-4EAF-A55F-9A4155604629}']
  function pm_GetUserProfile: IUserProfile;
  function pm_GetIsNewProfile: Boolean;
  property UserProfile: IUserProfile
   read pm_GetUserProfile;
   {* профиль пользователя }
  property IsNewProfile: Boolean
   read pm_GetIsNewProfile;
   {* флаг заведения нового пользователя }
 end;//IdeProfile

 IdsUserList = interface(IdsSimpleTree)
  {* Бизнес объект формы "efUserList" }
  ['{001CDCB3-0E2D-4942-81C2-A8000C66465B}']
  function pm_GetCurrentFlagFilter: TUserListFilterTypes;
  function pm_GetConsultingPaymentForNewbies: Boolean;
  procedure pm_SetConsultingPaymentForNewbies(aValue: Boolean);
  function pm_GetCurrentContextFilter: InscContextFilterState;
  function UserListNodeType(const aNode: Il3SimpleNode): TbsUserNodeType;
  function GetFrosenNode(const aNode: Il3SimpleNode): IdeNode;
  function FindFrosenNode(const aNode: IdeNode;
   aShowRootFlag: Boolean): Integer;
  procedure DeleteUser(const aNode: Il3SimpleNode;
   out aFailed: Boolean);
  procedure DeleteUsers(const aUserTree: Il3SimpleTree;
   out aFailed: IadminUserNodeList);
   {* Удалить выделенных на дереве пользователей, вернуть список нод которые не удалось удалить }
  procedure CreateNewUser;
  function GetUserState(const aNode: Il3SimpleNode): TUserStates;
  procedure LogoutUser(const aNode: Il3SimpleNode);
  procedure LogoutUsers(const aUserTree: Il3SimpleTree);
   {* Отключить выделенных на дереве пользователей }
  function FiltrateByType(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   aFilter: TUserListFilterTypes;
   out aCurrent: Integer): Il3SimpleTree;
  procedure SetConsultingPaymentForAll(IsAllowed: Boolean);
  procedure SetConsultingPayment(const aUserTree: Il3SimpleTree;
   IsAllowed: Boolean);
   {* Изменить возможность консалтинга для выделенных на дереве пользователей }
  procedure SetIsPrivileged(const aNode: Il3SimpleNode;
   IsPrivileged: Boolean);
  procedure SetPrivelegedRights(const aUserTree: Il3SimpleTree;
   IsPrivileged: Boolean);
   {* Изменить привилегированность для выделенных на дереве пользователей }
  procedure SelectNodes(const aUserTree: Il3SimpleTree;
   const aList: IadminUserNodeList);
   {* Выделить ноды по списку (Il3SimpleNode) }
  procedure NotifyCreateUserFinished(Successfull: Boolean);
   {* Нотификация об отскзе создания пользователя }
  procedure NotifyGroupChanged(aGroupUID: Integer);
   {* Сменилась группа }
  function FiltrateByGroup(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   aFilter: Integer;
   out aCurrent: Integer): Il3SimpleTree;
  procedure CheckUnsavedUserProperty;
   {* Если свойства не сохранены - спросить об этом }
  procedure RequestUpdateCureent;
  function FiltrateByContext(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   const aFilter: InscContextFilterState;
   out aCurrent: Integer): Il3SimpleTree;
  property CurrentFlagFilter: TUserListFilterTypes
   read pm_GetCurrentFlagFilter;
  property ConsultingPaymentForNewbies: Boolean
   read pm_GetConsultingPaymentForNewbies
   write pm_SetConsultingPaymentForNewbies;
  property CurrentContextFilter: InscContextFilterState
   read pm_GetCurrentContextFilter;
 end;//IdsUserList

 IbsGroupListViewListener = interface(Il3Notify)
  ['{BE7B7261-9EAB-4C1E-9962-4725D497A7AC}']
  procedure TreeViewInvalidate;
 end;//IbsGroupListViewListener

 IsdsAdmin = interface
  ['{AD45CA47-4C5B-4B00-A9A7-E8A7C45E2F0D}']
  function Get_CurrentGroupUID: Integer;
  function pm_GetConsultingPaymentForNewbies: Boolean;
  procedure pm_SetConsultingPaymentForNewbies(aValue: Boolean);
  function pm_GetdsUserList: IdsUserList;
  function pm_GetdsAdmin: IdsAdmin;
  function pm_GetdsUserProperty: IdsUserProperty;
  function pm_GetdsGroupsList: IdsGroupsList;
  procedure ChangeUser(const aProfile: IdeProfile);
  procedure DeleteUser(const aNode: Il3SimpleNode;
   out aFailed: Boolean);
  procedure DeleteUsers(const aUserTree: Il3SimpleTree;
   const anList: IadminUserNodeList;
   out aFailed: IadminUserNodeList);
   {* Удалить выделенных на дереве пользователей, вернуть список нод которые не удалось удалить }
  procedure SetConsultingPaymentForAll(IsAllowed: Boolean);
  procedure SetConsultingPayment(const anList: IadminUserNodeList;
   IsAllowed: Boolean);
   {* Изменить возможность консалтинга для выделенных на дереве пользователей }
  procedure LogoutUser(const aNode: Il3SimpleNode); { can raise ETryLogoutCurrentUser }
  procedure LogoutUsers(const anList: IadminUserNodeList); { can raise ETryLogoutCurrentUser }
   {* Отключить выделенных на дереве пользователей, вернуть список нод которые не удалось отключить }
  procedure SetIsPrivileged(const aNode: Il3SimpleNode;
   IsPrivileged: Boolean);
  procedure SetPrivelegedRights(const anList: IadminUserNodeList;
   IsPrivileged: Boolean);
   {* Изменить привилегированность для выделенных на дереве пользователей }
  function ChangeBaseAccessForGroup(const aNode: Il3SimpleNode): Boolean; overload;
   {* Изменить доступ для групп }
  procedure DeleteGroup(const aNode: Il3SimpleNode);
   {* Удалить группу }
  procedure CreateNewGroup;
   {* Создать группу }
  function ChangeBaseAccessForGroup(anUID: Integer): Boolean; overload;
  procedure ChangeGroup(const aNode: Il3SimpleNode);
   {* Поменялась группа }
  procedure RenameGroup(const aNode: Il3SimpleNode);
   {* переименовать группу }
  procedure CreateUserFinished(Successfull: Boolean);
   {* Нотификация об убиении пользователя }
  procedure CheckUnsavedUserProperty;
   {* Если свойства не сохранены - спросить об этом }
  procedure RequestUpdateCurrent;
  procedure SetDontDeleteIdle(const aNode: Il3SimpleNode;
   aValue: Boolean);
  property CurrentGroupUID: Integer
   read Get_CurrentGroupUID;
   {* Текущая группа }
  property ConsultingPaymentForNewbies: Boolean
   read pm_GetConsultingPaymentForNewbies
   write pm_SetConsultingPaymentForNewbies;
  property dsUserList: IdsUserList
   read pm_GetdsUserList;
  property dsAdmin: IdsAdmin
   read pm_GetdsAdmin;
  property dsUserProperty: IdsUserProperty
   read pm_GetdsUserProperty;
  property dsGroupsList: IdsGroupsList
   read pm_GetdsGroupsList;
 end;//IsdsAdmin
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Admin)

end.
