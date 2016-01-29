unit SecurityUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/SecurityUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  DynamicTreeUnit
  ;

const
  { UserFilterFlags }
 UFF_USER_ACTIVE : Cardinal = 1;
 UFF_USER_NOT_ACTIVE : Cardinal = 2;
 UFF_USER_SYSTEM : Cardinal = 4;
 UFF_USER_NOT_SYSTEM : Cardinal = 8;
 UFF_USER_NOT_CURRENT : Cardinal = 16;
 UFF_GUEST_USER : Cardinal = 32;
 UFF_NOT_GUEST_USER : Cardinal = 64;
 UFF_USER_CAN_BUY_CONSULTING : Cardinal = 128;
 UFF_USER_CANT_BUY_CONSULTING : Cardinal = 256;
 UFF_USER_PRIVILEGED : Cardinal = 512;
 UFF_USER_NOT_PRIVILEGED : Cardinal = 1024;
 UFF_GROUP_UID : Cardinal = 2048;
  { выбрать пользователей только заданной группы }
 UFF_NOT_GROUPPED_USERS : Cardinal = 4096;
  { пользователи, входящие только в группу все }
 UFF_CHAT_CONTACT_LIST_USERS : Cardinal = 8192;
  { только те пользователи, которые включены в список контактов для чата текущего пользователя }

type
 WrongAuthentication = class
  {* Неверные данные аутентификации }
 end;//WrongAuthentication

 NoMoreProfiles = class
  {* Превышение лимита профилей пользователей }
 end;//NoMoreProfiles

 UserActive = class
  {* Попытка удалить работающего в данный момент пользователя }
 end;//UserActive

 LicenceViolation = class
  {* Нарушение лицензионных настроек }
 end;//LicenceViolation

 XMLImportRunning = class
  {* Активен процесс заливки на стороне сервера }
 end;//XMLImportRunning

 LoginDuplicate = class
  {* Данный пользователь уже зарегестрирован в системе }
 end;//LoginDuplicate

 ShutdownInited = class
  {* Бросается в случае попытки залогинится в момент завершения работы сервера. }
 end;//ShutdownInited

const
  { Состояния в которых могут находится пользователи с точки зрения их отображения. }
 PNT_LOGGED_FLAG : TNodeType = 1;
  { пользователь в данный момент работает в системе }
 PNT_SYSTEM_FLAG : TNodeType = 2;
  { признак системности }
 PNT_EXIT_FLAG : TNodeType = 4;
 PNT_PRIVILEGED_FLAG : TNodeType = 8;

type
 IUserProfile = interface(IEntityBase)
  {* Информация о пользователе }
   ['{600B24EC-1FB9-40F2-A6FC-E89397679F80}']
   function GetGroupId: TUid; stdcall;
   procedure GetLogin(out aRet {: IString}); stdcall;
   function HasPassword: ByteBool; stdcall;
   procedure GetName(out aRet {: IString}); stdcall;
   procedure GetMail(out aRet {: IString}); stdcall;
   function GetUid: Integer; stdcall;
   function IsSystem: ByteBool; stdcall;
   function CanBuyConsulting: ByteBool; stdcall;
   function IsPrivileged: ByteBool; stdcall;
     {* привилегированный пользователь }
   property group_id: TUid
     read GetGroupId;
     {* идентификатор группы, к которой принадлежит пользователь. }
 end;//IUserProfile

 IUserFilter = interface(IFilterForTree)
  {* Фильтр для дерева пользователей }
   ['{A3970144-43FB-4E18-BBBB-7B246074873E}']
   function GetFlags: Cardinal; stdcall;
   procedure SetFlags(aValue: Cardinal); stdcall;
   function GetGroupUid: TUid; stdcall;
   procedure SetGroupUid(aValue: TUid); stdcall;
   property flags: Cardinal
     read GetFlags
     write SetFlags;
   property group_uid: TUid
     read GetGroupUid
     write SetGroupUid;
     {* идентификатор группы по которой необходимо осуществить фильтрацию }
 end;//IUserFilter

 IProfileNode = interface(INodeBase)
  {* Узел в дереве пользователей }
   ['{A5ED9F82-E286-4359-839E-021E436CA65E}']
   function GetUid: TUid; stdcall;
 end;//IProfileNode

 TrialPeriodExpired = class
  {* Время ознакомительной версии истекло }
 end;//TrialPeriodExpired

 IUidList = array of TUid;
  {* список пользователей }

 AutoregistrationDisabled = class
  {* Авторегистрация запрещена администратором системы }
 end;//AutoregistrationDisabled

 NoMorePrivilegedProfiles = class
  {* нельзя завести новых пользователей с привилегированным входом }
 end;//NoMorePrivilegedProfiles

 IUserManager = interface(IUnknown)
  {* Класс для работы с пользователями. Содержит метод для получения дерева пользователей. }
   ['{F9017C5B-D7D9-4DD0-8E29-BD24E6BA051E}']
   procedure CreateUserWithRights(aName: PAnsiChar;
    aLogin: PAnsiChar;
    aPassword: PAnsiChar;
    aMail: PAnsiChar;
    aCanBuyConsulting: Boolean;
    aIsPrivileged: Boolean;
    aGroupId: TUid); stdcall; // can raise WrongAuthentication, NoMoreProfiles, XMLImportRunning, LoginDuplicate, TrialPeriodExpired, NoMorePrivilegedProfiles
   procedure DeleteUser(aUid: TUid); stdcall; // can raise AccessDenied, CanNotFindData, UserActive
   procedure ChangeUserInfo(aUid: TUid;
    aName: PAnsiChar;
    aMail: PAnsiChar); stdcall; // can raise AccessDenied, CanNotFindData, LicenceViolation, XMLImportRunning
     {* Изменение параметров пользователя за исключением
пароля. Пользователь идентифицируется по uid. }
   procedure ChangeUserPassword(aUid: TUid;
    aPassword: PAnsiChar); stdcall; // can raise AccessDenied, CanNotFindData, WrongAuthentication, LicenceViolation, XMLImportRunning
     {* Изменение пароля пользователя. Пользователь идентифицируется по uid. }
   procedure ChangeUserGroup(aUserId: TUid;
    aGroupId: TUid); stdcall; // can raise AccessDenied, CanNotFindData
   procedure ChangeUsersGroup(const aIdList: IUidList;
    aGroupId: TUid); stdcall; // can raise AccessDenied, CanNotFindData
   procedure UserCanBuyConsulting(aUid: TUid;
    aIsAllowed: Boolean); stdcall; // can raise AccessDenied, CanNotFindData, LicenceViolation, XMLImportRunning
     {* Установка свойства - может ли данный пользователь платить за консультации }
   procedure UserIsPrivileged(aUid: TUid;
    aIsPrivileged: Boolean); stdcall; // can raise AccessDenied, XMLImportRunning, NoMorePrivilegedProfiles
     {* установить свойство привилегированности для пользователя }
   procedure LogoutUser(aUid: TUid); stdcall; // can raise AccessDenied, CanNotFindData
   procedure GetSelfProfile(out aRet {: IUserProfile}); stdcall; // can raise CanNotFindData
   procedure SetConsultingPaymentForAll(aIsAllowed: Boolean); stdcall; // can raise AccessDenied
     {* установка политики оплаты консультаций для всех пользователей }
   procedure SetConsultingPaymentForNewbies(aIsAllowed: Boolean); stdcall; // can raise AccessDenied
     {* установка политики оплаты консультаций для новых пользователей }
   function GetConsultingPaymentForNewbies: ByteBool; stdcall;
     {* возвращает текущее значение политики оплаты консультаций для новых пользователей (true - оплата разрешена) }
   procedure DeleteUsers(const aList: IUidList; out aRet {: IUidList}); stdcall; // can raise AccessDenied
     {* удалить список пользователей. Возвращает список пользователей, которых удалить не удалось. }
   procedure LogoutUsers(const aList: IUidList); stdcall; // can raise AccessDenied
     {* завершить работу в системе указанного списка пользователей. }
   procedure SetConsultingRights(const aList: IUidList;
    aIsPaymentAllowed: Boolean); stdcall; // can raise AccessDenied, InternalDatabaseError
     {* задать права на оплату консультаций для заданного списка пользователей. }
   procedure SetPrivilegedRights(const aList: IUidList;
    aIsPrivileged: Boolean); stdcall; // can raise AccessDenied, XMLImportRunning, NoMorePrivilegedProfiles
     {* установить права привилегированности }
   function CanCreatePrivilegedUser: ByteBool; stdcall; // can raise AccessDenied
     {* можно ли зоздавать привилегированных пользователей }
   procedure GetActiveUsersListForNetOneUserVersion(out aRet {: IStringList}); stdcall; // can raise CanNotFindData
     {* Получение списка юзеров, захвативших сетевую версию }
   procedure GetGroupsTree(out aRet {: INodeBase}); stdcall;
     {* получить дерево групп }
   procedure GetUsersTree(out aRet {: INodeBase}); stdcall;
     {* получить дерево пользователей для группы с заданным идентификатором }
   procedure CreateGroup(aName: PAnsiChar); stdcall; // can raise AccessDenied, WrongAuthentication, XMLImportRunning, LoginDuplicate
     {* создать группу с заданным именем }
   procedure DeleteGroup(aUid: TUid); stdcall; // can raise AccessDenied, CanNotFindData
     {* удалить группу с заданным идентификатором }
   procedure SetNonsearchableBlocksForGroup(aUid: TUid;
    const aBlocksIds: INodeIdList); stdcall; // can raise AccessDenied, CanNotFindData
     {* установить список блоков базы по которым запрещён поиск группе пользователей }
   procedure GetNonsearchableBlocksForGroup(aUid: TUid; out aRet {: INodeIdList}); stdcall; // can raise AccessDenied, InternalDatabaseError
     {* получить список блоков базы по которым запрещён поиск группе пользователей }
   procedure ChangeGroupName(aUid: TUid;
    aName: PAnsiChar); stdcall; // can raise AccessDenied, CanNotFindData, LoginDuplicate
     {* сменить имя группы }
   function HasSharedFilters(aUid: TUid): ByteBool; stdcall;
     {* общие ли фильтры пользователя }
   procedure SetSharedFiltersState(aUid: TUid;
    aState: Boolean); stdcall;
     {* устанавливает флажок являются ли фильтры пользователя uid общими в соответствии со значением state }
   function IsErasable(aUid: TUid): ByteBool; stdcall;
     {* может ли пользователь быть удалён }
   procedure SetErasableState(aUid: TUid;
    aState: Boolean); stdcall;
     {* установка свойства - можно ли удалить пользователя }
 end;//IUserManager

const
  { константы, связанные с группами }
 GROUP_ALL_ID : TUid = 0;
  { идентификатор группы "Все" }

type
 IGroupNode = interface(IProfileNode)
  {* узел дерева групп }
   ['{1EA308E6-3D7C-4A5C-A1DB-3CA087F94096}']
   function HasUsers: ByteBool; stdcall; // can raise AccessDenied, CanNotFindData
     {* есть ли в группе пользователи }
 end;//IGroupNode

implementation

end.