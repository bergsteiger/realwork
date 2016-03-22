unit SecurityUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SecurityUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Security" MUID: (45EEAA96039C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , BaseTypesUnit
 , IOUnit
 , DynamicTreeDefinesUnit
;

const
 UFF_USER_ACTIVE: Cardinal = 1;
 UFF_USER_NOT_ACTIVE: Cardinal = 2;
 UFF_USER_SYSTEM: Cardinal = 4;
 UFF_USER_NOT_SYSTEM: Cardinal = 8;
 UFF_USER_NOT_CURRENT: Cardinal = 16;
 UFF_GUEST_USER: Cardinal = 32;
 UFF_NOT_GUEST_USER: Cardinal = 64;
 UFF_USER_CAN_BUY_CONSULTING: Cardinal = 128;
 UFF_USER_CANT_BUY_CONSULTING: Cardinal = 256;
 UFF_USER_PRIVILEGED: Cardinal = 512;
 UFF_USER_NOT_PRIVILEGED: Cardinal = 1024;
 UFF_GROUP_UID: Cardinal = 2048;
  {* выбрать пользователей только заданной группы }
 UFF_NOT_GROUPPED_USERS: Cardinal = 4096;
  {* пользователи, входящие только в группу все }
 UFF_CHAT_CONTACT_LIST_USERS: Cardinal = 8192;
  {* только те пользователи, которые включены в список контактов для чата текущего пользователя }
 {* Состояния в которых могут находится пользователи с точки зрения их отображения. }
 PNT_LOGGED_FLAG: TNodeType = 1;
  {* пользователь в данный момент работает в системе }
 PNT_SYSTEM_FLAG: TNodeType = 2;
  {* признак системности }
 PNT_EXIT_FLAG: TNodeType = 4;
 PNT_PRIVILEGED_FLAG: TNodeType = 8;
 {* константы, связанные с группами }
 GROUP_ALL_ID: TUid = 0;
  {* идентификатор группы "Все" }

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

 IUserProfile = interface(IEntityBase)
  {* Информация о пользователе }
  ['{600B24EC-1FB9-40F2-A6FC-E89397679F80}']
  function Get_group_id: TUid; { can raise AccessDenied }
  function get_login: IString;
  function has_password: Boolean;
  function get_name: IString;
  function get_mail: IString;
  function get_uid: Integer;
  function is_system: Boolean;
  function can_buy_consulting: Boolean;
  function is_privileged: Boolean;
   {* привилегированный пользователь }
  property group_id: TUid
   read Get_group_id;
   {* идентификатор группы, к которой принадлежит пользователь. }
 end;//IUserProfile

 IUserFilter = interface(IFilterForTree)
  {* Фильтр для дерева пользователей }
  ['{A3970144-43FB-4E18-BBBB-7B246074873E}']
  function Get_flags: Cardinal;
  procedure Set_flags(aValue: Cardinal);
  function Get_group_uid: TUid;
  procedure Set_group_uid(aValue: TUid);
  property flags: Cardinal
   read Get_flags
   write Set_flags;
  property group_uid: TUid
   read Get_group_uid
   write Set_group_uid;
   {* идентификатор группы по которой необходимо осуществить фильтрацию }
 end;//IUserFilter

 IProfileNode = interface(INodeBase)
  {* Узел в дереве пользователей }
  ['{A5ED9F82-E286-4359-839E-021E436CA65E}']
  function get_uid: TUid;
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

 IUserManager = interface
  {* Класс для работы с пользователями. Содержит метод для получения дерева пользователей. }
  ['{F9017C5B-D7D9-4DD0-8E29-BD24E6BA051E}']
  procedure create_user_with_rights(name: PAnsiChar;
   login: PAnsiChar;
   password: PAnsiChar;
   mail: PAnsiChar;
   can_buy_consulting: Boolean;
   is_privileged: Boolean;
   group_id: TUid); { can raise WrongAuthentication, NoMoreProfiles, XMLImportRunning, LoginDuplicate, TrialPeriodExpired, NoMorePrivilegedProfiles }
  procedure delete_user(uid: TUid); { can raise AccessDenied, CanNotFindData, UserActive }
  procedure change_user_info(uid: TUid;
   name: PAnsiChar;
   mail: PAnsiChar); { can raise AccessDenied, CanNotFindData, LicenceViolation, XMLImportRunning }
   {* Изменение параметров пользователя за исключением
пароля. Пользователь идентифицируется по uid. }
  procedure change_user_password(uid: TUid;
   password: PAnsiChar); { can raise AccessDenied, CanNotFindData, WrongAuthentication, LicenceViolation, XMLImportRunning }
   {* Изменение пароля пользователя. Пользователь идентифицируется по uid. }
  procedure change_user_group(user_id: TUid;
   group_id: TUid); { can raise AccessDenied, CanNotFindData }
  procedure change_users_group(const id_list: IUidList;
   group_id: TUid); { can raise AccessDenied, CanNotFindData }
  procedure user_can_buy_consulting(uid: TUid;
   is_allowed: Boolean); { can raise AccessDenied, CanNotFindData, LicenceViolation, XMLImportRunning }
   {* Установка свойства - может ли данный пользователь платить за консультации }
  procedure user_is_privileged(uid: TUid;
   is_privileged: Boolean); { can raise AccessDenied, XMLImportRunning, NoMorePrivilegedProfiles }
   {* установить свойство привилегированности для пользователя }
  procedure logout_user(uid: TUid); { can raise AccessDenied, CanNotFindData }
  function get_self_profile: IUserProfile; { can raise CanNotFindData }
  procedure set_consulting_payment_for_all(is_allowed: Boolean); { can raise AccessDenied }
   {* установка политики оплаты консультаций для всех пользователей }
  procedure set_consulting_payment_for_newbies(is_allowed: Boolean); { can raise AccessDenied }
   {* установка политики оплаты консультаций для новых пользователей }
  function get_consulting_payment_for_newbies: Boolean;
   {* возвращает текущее значение политики оплаты консультаций для новых пользователей (true - оплата разрешена) }
  function delete_users(const list: IUidList): IUidList; { can raise AccessDenied }
   {* удалить список пользователей. Возвращает список пользователей, которых удалить не удалось. }
  procedure logout_users(const list: IUidList); { can raise AccessDenied }
   {* завершить работу в системе указанного списка пользователей. }
  procedure set_consulting_rights(const list: IUidList;
   is_payment_allowed: Boolean); { can raise AccessDenied, InternalDatabaseError }
   {* задать права на оплату консультаций для заданного списка пользователей. }
  procedure set_privileged_rights(const list: IUidList;
   is_privileged: Boolean); { can raise AccessDenied, XMLImportRunning, NoMorePrivilegedProfiles }
   {* установить права привилегированности }
  function can_create_privileged_user: Boolean; { can raise AccessDenied }
   {* можно ли зоздавать привилегированных пользователей }
  function get_active_users_list_for_net_one_user_version: IStringList; { can raise CanNotFindData }
   {* Получение списка юзеров, захвативших сетевую версию }
  function get_groups_tree: INodeBase;
   {* получить дерево групп }
  function get_users_tree: INodeBase;
   {* получить дерево пользователей для группы с заданным идентификатором }
  procedure create_group(name: PAnsiChar); { can raise AccessDenied, WrongAuthentication, XMLImportRunning, LoginDuplicate }
   {* создать группу с заданным именем }
  procedure delete_group(uid: TUid); { can raise AccessDenied, CanNotFindData }
   {* удалить группу с заданным идентификатором }
  procedure set_nonsearchable_blocks_for_group(uid: TUid;
   const blocks_ids: INodeIdList); { can raise AccessDenied, CanNotFindData }
   {* установить список блоков базы по которым запрещён поиск группе пользователей }
  function get_nonsearchable_blocks_for_group(uid: TUid): INodeIdList; { can raise AccessDenied, InternalDatabaseError }
   {* получить список блоков базы по которым запрещён поиск группе пользователей }
  procedure change_group_name(uid: TUid;
   name: PAnsiChar); { can raise AccessDenied, CanNotFindData, LoginDuplicate }
   {* сменить имя группы }
  function has_shared_filters(uid: TUid): Boolean;
   {* общие ли фильтры пользователя }
  procedure set_shared_filters_state(uid: TUid;
   state: Boolean);
   {* устанавливает флажок являются ли фильтры пользователя uid общими в соответствии со значением state }
  function is_erasable(uid: TUid): Boolean;
   {* может ли пользователь быть удалён }
  procedure set_erasable_state(uid: TUid;
   state: Boolean);
   {* установка свойства - можно ли удалить пользователя }
 end;//IUserManager

 IGroupNode = interface(IProfileNode)
  {* узел дерева групп }
  ['{1EA308E6-3D7C-4A5C-A1DB-3CA087F94096}']
  function has_users: Boolean; { can raise AccessDenied, CanNotFindData }
   {* есть ли в группе пользователи }
 end;//IGroupNode

class function make(uid: TUid;
 login: PAnsiChar;
 name: PAnsiChar;
 mail: PAnsiChar;
 is_system: Boolean;
 has_password: Boolean;
 can_buy_consulting: Boolean;
 is_permanent: Boolean): BadFactoryType; overload;
class function make: BadFactoryType; overload;
class function make: BadFactoryType;
class function make: BadFactoryType;
class function make: BadFactoryType;
 {* фабрика }

implementation

uses
 l3ImplUses
;

class function make(uid: TUid;
 login: PAnsiChar;
 name: PAnsiChar;
 mail: PAnsiChar;
 is_system: Boolean;
 has_password: Boolean;
 can_buy_consulting: Boolean;
 is_permanent: Boolean): BadFactoryType;
var
 l_Inst : IUserProfile;
begin
 l_Inst := Create(uid, login, name, mail, is_system, has_password, can_buy_consulting, is_permanent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IUserProfile;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IProfileNode;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IUserManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : IGroupNode;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
