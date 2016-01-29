////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/TimeStampSyncInterface/TimeStampSyncInterface.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

static const unsigned long UFF_USER_ACTIVE = 1;
static const unsigned long UFF_USER_NOT_ACTIVE = 2;
static const unsigned long UFF_USER_SYSTEM = 4;
static const unsigned long UFF_USER_NOT_SYSTEM = 8;
static const unsigned long UFF_USER_NOT_CURRENT = 16;
static const unsigned long UFF_GUEST_USER = 32;
static const unsigned long UFF_NOT_GUEST_USER = 64;
static const unsigned long UFF_USER_CAN_BUY_CONSULTING = 128;
static const unsigned long UFF_USER_CANT_BUY_CONSULTING = 256;
static const unsigned long UFF_USER_PRIVILEGED = 512;
static const unsigned long UFF_USER_NOT_PRIVILEGED = 1024;
static const unsigned long UFF_GROUP_UID = 2048; // выбрать пользователей только заданной группы
static const unsigned long UFF_NOT_GROUPPED_USERS = 4096; // пользователи, входящие только в группу все
static const unsigned long UFF_CHAT_CONTACT_LIST_USERS = 8192; // только те пользователи, которые включены в список контактов для чата текущего пользователя

// Неверные данные аутентификации
class WrongAuthentication : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Превышение лимита профилей пользователей
class NoMoreProfiles : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Попытка удалить работающего в данный момент пользователя
class UserActive : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Нарушение лицензионных настроек
class LicenceViolation : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Активен процесс заливки на стороне сервера
class XMLImportRunning : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Данный пользователь уже зарегестрирован в системе
class LoginDuplicate : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Бросается в случае попытки залогинится в момент завершения работы сервера.
class ShutdownInited : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Состояния в которых могут находится пользователи с точки зрения их отображения.
static const NodeType PNT_LOGGED_FLAG = 1; // пользователь в данный момент работает в системе
static const NodeType PNT_SYSTEM_FLAG = 2; // признак системности
static const NodeType PNT_EXIT_FLAG = 4;
static const NodeType PNT_PRIVILEGED_FLAG = 8;

class UserProfile;
typedef ::Core::Var<UserProfile> UserProfile_var;
typedef ::Core::Var<const UserProfile> UserProfile_cvar;
// Информация о пользователе
class UserProfile
	: virtual public EntityBase
	, virtual public ActiveChangeable
{
public:
	// идентификатор группы, к которой принадлежит пользователь.
	virtual const Uid get_group_id () const
		/*throw (AccessDenied)*/ = 0;

	virtual const GCI::IO::String& get_login () const = 0;

	virtual bool has_password () const = 0;

	virtual const GCI::IO::String& get_name () const = 0;

	virtual const GCI::IO::String& get_mail () const = 0;

	virtual long get_uid () const = 0;

	virtual bool is_system () const = 0;

	virtual bool can_buy_consulting () const = 0;

	// привилегированный пользователь
	virtual bool is_privileged () const = 0;
};

/// factory interface for UserProfile
class UserProfileFactory {
public:
	static UserProfile* make (
		Uid uid
		, const char* login
		, const char* name
		, const char* mail
		, bool is_system
		, bool has_password
		, bool can_buy_consulting
		, bool is_permanent
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static UserProfile* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class UserFilter;
typedef ::Core::Var<UserFilter> UserFilter_var;
typedef ::Core::Var<const UserFilter> UserFilter_cvar;
// Фильтр для дерева пользователей
class UserFilter
	: virtual public FilterForTree
{
public:
	virtual unsigned long get_flags () const = 0;

	virtual void set_flags (unsigned long flags) = 0;

	// идентификатор группы по которой необходимо осуществить фильтрацию
	virtual const Uid get_group_uid () const = 0;

	virtual void set_group_uid (Uid group_uid) = 0;
};

/// factory interface for UserFilter
class UserFilterFactory {
public:
	static UserFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ProfileNode;
typedef ::Core::Var<ProfileNode> ProfileNode_var;
typedef ::Core::Var<const ProfileNode> ProfileNode_cvar;
// Узел в дереве пользователей
class ProfileNode
	: virtual public NodeBase
{
public:
	virtual Uid get_uid () const = 0;
};

/// factory interface for ProfileNode
class ProfileNodeFactory {
public:
	static ProfileNode* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Время ознакомительной версии истекло
class TrialPeriodExpired : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// список пользователей
typedef std::vector < Uid > UidList;

// Авторегистрация запрещена администратором системы
class AutoregistrationDisabled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// нельзя завести новых пользователей с привилегированным входом
class NoMorePrivilegedProfiles : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class UserManager;
typedef ::Core::Var<UserManager> UserManager_var;
typedef ::Core::Var<const UserManager> UserManager_cvar;
// Класс для работы с пользователями. Содержит метод для получения дерева пользователей.
class UserManager
	: virtual public ::Core::IObject
{
public:
	virtual void create_user_with_rights (
		const char* name
		, const char* login
		, const char* password
		, const char* mail
		, bool can_buy_consulting
		, bool is_privileged
		, Uid group_id
	) const /*throw (
		WrongAuthentication
		, NoMoreProfiles
		, XMLImportRunning
		, LoginDuplicate
		, TrialPeriodExpired
		, NoMorePrivilegedProfiles
	)*/ = 0;

	virtual void delete_user (Uid uid) const /*throw (AccessDenied, CanNotFindData, UserActive)*/ = 0;

	// Изменение параметров пользователя за исключением
	// пароля. Пользователь идентифицируется по uid.
	virtual void change_user_info (
		Uid uid
		, const char* name
		, const char* mail
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, LicenceViolation
		, XMLImportRunning
	)*/ = 0;

	// Изменение пароля пользователя. Пользователь идентифицируется по uid.
	virtual void change_user_password (
		Uid uid
		, const char* password
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, WrongAuthentication
		, LicenceViolation
		, XMLImportRunning
	)*/ = 0;

	virtual void change_user_group (Uid user_id, Uid group_id) const /*throw (AccessDenied, CanNotFindData)*/ = 0;

	virtual void change_users_group (
		const UidList& id_list
		, Uid group_id
	) const /*throw (
		AccessDenied
		, CanNotFindData
	)*/ = 0;

	// Установка свойства - может ли данный пользователь платить за консультации
	virtual void user_can_buy_consulting (
		Uid uid
		, bool is_allowed
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, LicenceViolation
		, XMLImportRunning
	)*/ = 0;

	// установить свойство привилегированности для пользователя
	virtual void user_is_privileged (
		Uid uid
		, bool is_privileged
	) const /*throw (
		AccessDenied
		, XMLImportRunning
		, NoMorePrivilegedProfiles
	)*/ = 0;

	virtual void logout_user (Uid uid) const /*throw (AccessDenied, CanNotFindData)*/ = 0;

	virtual UserProfile* get_self_profile () /*throw (CanNotFindData)*/ = 0;

	// установка политики оплаты консультаций для всех пользователей
	virtual void set_consulting_payment_for_all (bool is_allowed) const /*throw (AccessDenied)*/ = 0;

	// установка политики оплаты консультаций для новых пользователей
	virtual void set_consulting_payment_for_newbies (bool is_allowed) const /*throw (AccessDenied)*/ = 0;

	// возвращает текущее значение политики оплаты консультаций для новых пользователей (true - оплата
	// разрешена)
	virtual bool get_consulting_payment_for_newbies () const = 0;

	// удалить список пользователей. Возвращает список пользователей, которых удалить не удалось.
	virtual UidList* delete_users (const UidList& list) const /*throw (AccessDenied)*/ = 0;

	// завершить работу в системе указанного списка пользователей.
	virtual void logout_users (const UidList& list) const /*throw (AccessDenied)*/ = 0;

	// задать права на оплату консультаций для заданного списка пользователей.
	virtual void set_consulting_rights (
		const UidList& list
		, bool is_payment_allowed
	) const /*throw (
		AccessDenied
		, InternalDatabaseError
	)*/ = 0;

	// установить права привилегированности
	virtual void set_privileged_rights (
		const UidList& list
		, bool is_privileged
	) const /*throw (
		AccessDenied
		, XMLImportRunning
		, NoMorePrivilegedProfiles
	)*/ = 0;

	// можно ли зоздавать привилегированных пользователей
	virtual bool can_create_privileged_user () const /*throw (AccessDenied)*/ = 0;

	// Получение списка юзеров, захвативших сетевую версию
	virtual StringList* get_active_users_list_for_net_one_user_version () const /*throw (CanNotFindData)*/ = 0;

	// получить дерево групп
	virtual NodeBase* get_groups_tree () const = 0;

	// получить дерево пользователей для группы с заданным идентификатором
	virtual NodeBase* get_users_tree () const = 0;

	// создать группу с заданным именем
	virtual void create_group (
		const char* name
	) const /*throw (
		AccessDenied
		, WrongAuthentication
		, XMLImportRunning
		, LoginDuplicate
	)*/ = 0;

	// удалить группу с заданным идентификатором
	virtual void delete_group (Uid uid) const /*throw (AccessDenied, CanNotFindData)*/ = 0;

	// установить список блоков базы по которым запрещён поиск группе пользователей
	virtual void set_nonsearchable_blocks_for_group (
		Uid uid
		, const NodeIdList& blocks_ids
	) const /*throw (
		AccessDenied
		, CanNotFindData
	)*/ = 0;

	// получить список блоков базы по которым запрещён поиск группе пользователей
	virtual NodeIdList* get_nonsearchable_blocks_for_group (
		Uid uid
	) const /*throw (
		AccessDenied
		, InternalDatabaseError
	)*/ = 0;

	// сменить имя группы
	virtual void change_group_name (
		Uid uid
		, const char* name
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, LoginDuplicate
	)*/ = 0;

	// общие ли фильтры пользователя
	virtual bool has_shared_filters (Uid uid) const = 0;

	// устанавливает флажок являются ли фильтры пользователя uid общими в соответствии со значением
	// state
	virtual void set_shared_filters_state (Uid uid, bool state) const = 0;

	// может ли пользователь быть удалён
	virtual bool is_erasable (Uid uid) const = 0;

	// установка свойства - можно ли удалить пользователя
	virtual void set_erasable_state (Uid uid, bool state) const = 0;
};

/// factory interface for UserManager
class UserManagerFactory {
public:
	static UserManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// константы, связанные с группами
static const Uid GROUP_ALL_ID = 0; // идентификатор группы "Все"

class GroupNode;
typedef ::Core::Var<GroupNode> GroupNode_var;
typedef ::Core::Var<const GroupNode> GroupNode_cvar;
// узел дерева групп
class GroupNode
	: virtual public ProfileNode
{
public:
	// есть ли в группе пользователи
	virtual bool has_users () const /*throw (AccessDenied, CanNotFindData)*/ = 0;
};

/// factory interface for GroupNode
class GroupNodeFactory {
public:
	// фабрика
	static GroupNode* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::UserProfile> {
	typedef GblAdapterLib::UserProfileFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::UserFilter> {
	typedef GblAdapterLib::UserFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ProfileNode> {
	typedef GblAdapterLib::ProfileNodeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::UserManager> {
	typedef GblAdapterLib::UserManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::GroupNode> {
	typedef GblAdapterLib::GroupNodeFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
