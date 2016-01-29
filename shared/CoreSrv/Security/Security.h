////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Security/Security.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::Security
//
// сервисные локальные интерфейсы подсистемы безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITY_H__
#define __SHARED_CORESRV_SECURITY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"

namespace CoreSrv {

class Session;
typedef ::Core::Var<Session> Session_var;
typedef ::Core::Var<const Session> Session_cvar;
// Интерфейс домтупа к базовым функциям свзяанных с аутентификацией и безопасеностью. Все методы
// получения идентификаторов сесии и пользователя гарантированно локальны.
class Session
	: virtual public ::Core::IObject
{
public:
	// Идентификатор клиентской сессии (не равен нулю в случае успешной авторизации на сервере).
	// Используется в контексте клиента.
	virtual SessionID get_self_sid () const = 0;

	// Идентификатор пользователя от имени которого была выполнена автоизация. Используется в
	// контексте клиента.
	virtual UserID get_self_uid () const = 0;

	// Идентификатор сессии вызывающего контекста. Т.е. идентификатор сессии клиента сделавший текущей
	// вызов. Используется в контексте сервера.
	virtual SessionID get_context_sid () const = 0;

	// Идентификатор пользователя вызывающего контекста. Т.е. идентификатор пользователя от лица
	// которого был сделан текущей вызов. Используется в контексте сервера.
	virtual UserID get_context_uid () const = 0;

	// Авторизация на сервере с указанием логин-пароля. В случае успешной авторизации клиентская
	// сессия получает идентификатор отличный от нуля. В случае ошибки авторизации воозбуждается
	// исключение
	virtual void login (const std::string& login, const std::string& pswd) /*throw (AccessDenied, AlreadyLogged)*/ = 0;

	// Завершение сессии
	virtual void logout () = 0;

	// Добавдляет каллбек-интерфейс для слежения за сессиями
	virtual void add_session_interceptor (SessionInterceptor* sint) = 0;

	// добавляет пользовательский интерцептор входящих запросов
	virtual void add_request_interceptor (const UserRequestInterceptor* rint) = 0;

	// вызывается из системного интерцептора перед началом вывполнения запроса; приводит к вызову
	// функции start на всех зарегистрированных пользовательских интерцепторах входящих запросах.
	// {warning}Нужно сделать приватным{warning}
	virtual void start_user_request (UserID uid) const = 0;

	// вызывается из системного интерцептора после завершения запроса; приводит к вызову функции
	// finish на всех зарегистрированных пользовательских интерцепторах входящих запросах.
	// {warning}Нужно сделать приватным{warning}
	virtual void finish_user_request (UserID uid) const = 0;
};

/// factory interface for Session
class SessionFactory {
public:
	// возвращает объект текущей сессии
	static Session& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace CoreSrv

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <CoreSrv::Session> {
	typedef CoreSrv::SessionFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORESRV_SECURITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
