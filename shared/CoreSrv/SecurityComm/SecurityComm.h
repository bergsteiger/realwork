////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/SecurityComm/SecurityComm.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::SecurityComm
//
// коммуникационные локальные интерфейсы и типы ддля подсистемы Безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITYCOMM_H__
#define __SHARED_CORESRV_SECURITYCOMM_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"

namespace CoreSrv {

// Тип профиля пользователя
enum ProfileType {
	PT_REGULAR // Обычный пользователь, пользователь с таким профайлом и уникальным идентификатором может быть связан только с одной активной сессией
	, PT_MULTIPLE // Множественный пользователь. Пользователь с таким профайлом и уникальным идентификатором может быть связан с несколькими активными сессиями. Например guest.
};

#pragma pack (push, 1)

// аутентификационные данные
struct ProfileData {
	// идентификатор пользователя
	UserID uid;
	// тип профиля
	ProfileType type;
};

#pragma pack (pop)

class Authenticator;
typedef ::Core::Var<Authenticator> Authenticator_var;
typedef ::Core::Var<const Authenticator> Authenticator_cvar;
// Comm интерфейс, для непосредственного проведения аутентификации
class Authenticator
	: virtual public ::Core::IObject
{
public:
	// вторизация, в случае успеха должнга вернуть данные профайла с соотвествующими идентификатором
	// пользователя и типом. Иначе исключение
	virtual ProfileData* authentication (const char* login, const char* pswd) const /*throw (AccessDenied)*/ = 0;
};

/// factory interface for Authenticator
class AuthenticatorFactory {
public:
	// возвращает зарегистрированный объект аутентификации.
	static Authenticator& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class UserRequestInterceptor;
typedef ::Core::Var<UserRequestInterceptor> UserRequestInterceptor_var;
typedef ::Core::Var<const UserRequestInterceptor> UserRequestInterceptor_cvar;
// Калбек интерфейс пользоваптельского интецептора запросов. Пользователь может установить сколь
// угодно много своих интерцепторов, для обработки начала и конца всех входящих авторизированных
// вызовов, с идентификацией от чьего имени они делаются
class UserRequestInterceptor
	: virtual public ::Core::IObject
{
public:
	// калбек метод, вызывается после завершения обработки входящего вызова
	virtual void finish (UserID uid) const = 0;

	// калбек метод, вызывается перед началом обработки входящего вызова
	virtual void start (UserID uid) const = 0;
};

} // namespace CoreSrv

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <CoreSrv::Authenticator> {
	typedef CoreSrv::AuthenticatorFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORESRV_SECURITYCOMM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
