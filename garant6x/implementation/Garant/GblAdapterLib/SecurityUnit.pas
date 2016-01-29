unit SecurityUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/SecurityUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, DynamicTreeUnit
	//#UC START# *4423F94903C8_45EEAA96039C_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEAA96039C_UNIT_FOR_Stream*
	;

type

IUserProfile = interface;
{ - предварительное описание IUserProfile. }

IUserFilter = interface;
{ - предварительное описание IUserFilter. }

IProfileNode = interface;
{ - предварительное описание IProfileNode. }

IUidList = interface;
{ - предварительное описание IUidList. }

IUserManager = interface;
{ - предварительное описание IUserManager. }

IGroupNode = interface;
{ - предварительное описание IGroupNode. }


// Неверные данные аутентификации
EWrongAuthentication = class (Exception);

// Превышение лимита профилей пользователей
ENoMoreProfiles = class (Exception);

// Попытка удалить работающего в данный момент пользователя
EUserActive = class (Exception);

// Нарушение лицензионных настроек
ELicenceViolation = class (Exception);

// Активен процесс заливки на стороне сервера
EXMLImportRunning = class (Exception);

// Данный пользователь уже зарегестрирован в системе
ELoginDuplicate = class (Exception);

// Бросается в случае попытки залогинится в момент завершения работы сервера.
EShutdownInited = class (Exception);

// Время ознакомительной версии истекло
ETrialPeriodExpired = class (Exception);

// Авторегистрация запрещена администратором системы
EAutoregistrationDisabled = class (Exception);

// нельзя завести новых пользователей с привилегированным входом
ENoMorePrivilegedProfiles = class (Exception);

// Информация о пользователе
IUserProfile = interface (IEntityBase) ['{600B24EC-1FB9-40F2-A6FC-E89397679F80}']
	function CanBuyConsulting (): Bytebool; stdcall;

	procedure GetLogin (
		out aRet {: IString}
	); stdcall;

	procedure GetMail (
		out aRet {: IString}
	); stdcall;

	procedure GetName (
		out aRet {: IString}
	); stdcall;

	function GetUid (): Longint; stdcall;

	// идентификатор группы, к которой принадлежит пользователь.
	function GetGroupId (): TUid; stdcall;

	function HasPassword (): Bytebool; stdcall;

	// привилегированный пользователь
	function IsPrivileged (): Bytebool; stdcall;

	function IsSystem (): Bytebool; stdcall;
end;

// Фильтр для дерева пользователей
IUserFilter = interface (IFilterForTree) ['{A3970144-43FB-4E18-BBBB-7B246074873E}']
	function GetFlags (): Longword; stdcall;
	procedure SetFlags (aFlags: Longword); stdcall;

	// идентификатор группы по которой необходимо осуществить фильтрацию
	function GetGroupUid (): TUid; stdcall;
	procedure SetGroupUid (aGroupUid: TUid); stdcall;
end;

// Узел в дереве пользователей
IProfileNode = interface (INodeBase) ['{A5ED9F82-E286-4359-839E-021E436CA65E}']
	function GetUid (): TUid; stdcall;
end;

IUidList = interface(IInterface)
['{A75B8B20-685F-4F9B-A39F-960F9B086944}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TUid; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TUid); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TUid): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TUid); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: TUid
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//IUidList

// Класс для работы с пользователями. Содержит метод для получения дерева пользователей.
IUserManager = interface (IInterface) ['{F9017C5B-D7D9-4DD0-8E29-BD24E6BA051E}']
	function DontUseMe: Pointer;
	// можно ли зоздавать привилегированных пользователей
	function CanCreatePrivilegedUser (): Bytebool; stdcall; // can raise EAccessDenied

	// сменить имя группы
	procedure ChangeGroupName (
		aUid: TUid;
		const aName: PAnsiChar
	); stdcall; // can raise EAccessDenied, ECanNotFindData, ELoginDuplicate

	procedure ChangeUserGroup (
		aUserId: TUid;
		aGroupId: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	// Изменение параметров пользователя за исключением
	// пароля. Пользователь идентифицируется по uid.
	procedure ChangeUserInfo (
		aUid: TUid;
		const aName: PAnsiChar;
		const aMail: PAnsiChar
	); stdcall; // can raise EAccessDenied, ECanNotFindData, ELicenceViolation, EXMLImportRunning

	// Изменение пароля пользователя. Пользователь идентифицируется по uid.
	procedure ChangeUserPassword (
		aUid: TUid;
		const aPassword: PAnsiChar
	); stdcall; // can raise EAccessDenied, ECanNotFindData, EWrongAuthentication, ELicenceViolation, EXMLImportRunning

	procedure ChangeUsersGroup (
		const aIdList: IUidList;
		aGroupId: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	// создать группу с заданным именем
	procedure CreateGroup (
		const aName: PAnsiChar
	); stdcall; // can raise EAccessDenied, EWrongAuthentication, EXMLImportRunning, ELoginDuplicate

	procedure CreateUserWithRights (
		const aName: PAnsiChar;
		const aLogin: PAnsiChar;
		const aPassword: PAnsiChar;
		const aMail: PAnsiChar;
		aCanBuyConsulting: Bytebool;
		aIsPrivileged: Bytebool;
		aGroupId: TUid
	); stdcall; // can raise EWrongAuthentication, ENoMoreProfiles, EXMLImportRunning, ELoginDuplicate, ETrialPeriodExpired, ENoMorePrivilegedProfiles

	// удалить группу с заданным идентификатором
	procedure DeleteGroup (
		aUid: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	procedure DeleteUser (
		aUid: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData, EUserActive

	// удалить список пользователей. Возвращает список пользователей, которых удалить не удалось.
	procedure DeleteUsers (
		const aList: IUidList;
		out aRet {: IUidList}
	); stdcall; // can raise EAccessDenied

	// Получение списка юзеров, захвативших сетевую версию
	procedure GetActiveUsersListForNetOneUserVersion (
		out aRet {: IStringList}
	); stdcall; // can raise ECanNotFindData

	// возвращает текущее значение политики оплаты консультаций для новых пользователей (true - оплата
	// разрешена)
	function GetConsultingPaymentForNewbies (): Bytebool; stdcall;

	// получить дерево групп
	procedure GetGroupsTree (
		out aRet {: INodeBase}
	); stdcall;

	// получить список блоков базы по которым запрещён поиск группе пользователей
	procedure GetNonsearchableBlocksForGroup (
		aUid: TUid;
		out aRet {: INodeIdList}
	); stdcall; // can raise EAccessDenied, EInternalDatabaseError

	procedure GetSelfProfile (
		out aRet {: IUserProfile}
	); stdcall; // can raise ECanNotFindData

	// получить дерево пользователей для группы с заданным идентификатором
	procedure GetUsersTree (
		out aRet {: INodeBase}
	); stdcall;

	// общие ли фильтры пользователя
	function HasSharedFilters (
		aUid: TUid
	): Bytebool; stdcall;

	// может ли пользователь быть удалён
	function IsErasable (
		aUid: TUid
	): Bytebool; stdcall;

	procedure LogoutUser (
		aUid: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	// завершить работу в системе указанного списка пользователей.
	procedure LogoutUsers (
		const aList: IUidList
	); stdcall; // can raise EAccessDenied

	// установка политики оплаты консультаций для всех пользователей
	procedure SetConsultingPaymentForAll (
		aIsAllowed: Bytebool
	); stdcall; // can raise EAccessDenied

	// установка политики оплаты консультаций для новых пользователей
	procedure SetConsultingPaymentForNewbies (
		aIsAllowed: Bytebool
	); stdcall; // can raise EAccessDenied

	// задать права на оплату консультаций для заданного списка пользователей.
	procedure SetConsultingRights (
		const aList: IUidList;
		aIsPaymentAllowed: Bytebool
	); stdcall; // can raise EAccessDenied, EInternalDatabaseError

	// установка свойства - можно ли удалить пользователя
	procedure SetErasableState (
		aUid: TUid;
		aState: Bytebool
	); stdcall;

	// установить список блоков базы по которым запрещён поиск группе пользователей
	procedure SetNonsearchableBlocksForGroup (
		aUid: TUid;
		const aBlocksIds: INodeIdList
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	// установить права привилегированности
	procedure SetPrivilegedRights (
		const aList: IUidList;
		aIsPrivileged: Bytebool
	); stdcall; // can raise EAccessDenied, EXMLImportRunning, ENoMorePrivilegedProfiles

	// устанавливает флажок являются ли фильтры пользователя uid общими в соответствии со значением
	// state
	procedure SetSharedFiltersState (
		aUid: TUid;
		aState: Bytebool
	); stdcall;

	// Установка свойства - может ли данный пользователь платить за консультации
	procedure UserCanBuyConsulting (
		aUid: TUid;
		aIsAllowed: Bytebool
	); stdcall; // can raise EAccessDenied, ECanNotFindData, ELicenceViolation, EXMLImportRunning

	// установить свойство привилегированности для пользователя
	procedure UserIsPrivileged (
		aUid: TUid;
		aIsPrivileged: Bytebool
	); stdcall; // can raise EAccessDenied, EXMLImportRunning, ENoMorePrivilegedProfiles
end;

// узел дерева групп
IGroupNode = interface (IProfileNode) ['{1EA308E6-3D7C-4A5C-A1DB-3CA087F94096}']
	// есть ли в группе пользователи
	function HasUsers (): Bytebool; stdcall; // can raise EAccessDenied, ECanNotFindData
end;

const

 { UserFilterFlags }
	UFF_USER_ACTIVE = Longword(1);
	UFF_USER_NOT_ACTIVE = Longword(2);
	UFF_USER_SYSTEM = Longword(4);
	UFF_USER_NOT_SYSTEM = Longword(8);
	UFF_USER_NOT_CURRENT = Longword(16);
	UFF_GUEST_USER = Longword(32);
	UFF_NOT_GUEST_USER = Longword(64);
	UFF_USER_CAN_BUY_CONSULTING = Longword(128);
	UFF_USER_CANT_BUY_CONSULTING = Longword(256);
	UFF_USER_PRIVILEGED = Longword(512);
	UFF_USER_NOT_PRIVILEGED = Longword(1024);
	UFF_GROUP_UID = Longword(2048);
 { выбрать пользователей только заданной группы }
	UFF_NOT_GROUPPED_USERS = Longword(4096);
 { пользователи, входящие только в группу все }
	UFF_CHAT_CONTACT_LIST_USERS = Longword(8192);
 { только те пользователи, которые включены в список контактов для чата текущего пользователя }

 { Состояния в которых могут находится пользователи с точки зрения их отображения. }
	PNT_LOGGED_FLAG = TNodeType(1);
 { пользователь в данный момент работает в системе }
	PNT_SYSTEM_FLAG = TNodeType(2);
 { признак системности }
	PNT_EXIT_FLAG = TNodeType(4);
	PNT_PRIVILEGED_FLAG = TNodeType(8);

 { константы, связанные с группами }
	GROUP_ALL_ID = TUid(0);
 { идентификатор группы "Все" }

implementation
end.