////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::Session_i
// Заголовок реализации класса серванта для интерфеса Session
//
// заглушка для получения идентификатора пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Security/Security.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

class Session_i; // self forward Var
typedef ::Core::Var<Session_i> Session_i_var;
typedef ::Core::Var<const Session_i> Session_i_cvar;

class Session_i_factory;

// заглушка для получения идентификатора пользователя
class Session_i:
	virtual public CoreSrv::Session
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Session_i)
	friend class Session_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Session_i ();

	virtual ~Session_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CoreSrv::Session
	// добавляет пользовательский интерцептор входящих запросов
	virtual void add_request_interceptor (const CoreSrv::UserRequestInterceptor* rint);

	// implemented method from CoreSrv::Session
	// Добавдляет каллбек-интерфейс для слежения за сессиями
	virtual void add_session_interceptor (CoreSrv::SessionInterceptor* sint);

	// implemented method from CoreSrv::Session
	// Идентификатор сессии вызывающего контекста. Т.е. идентификатор сессии клиента сделавший текущей
	// вызов. Используется в контексте сервера.
	virtual CoreSrv::SessionID get_context_sid () const;

	// implemented method from CoreSrv::Session
	// Идентификатор пользователя вызывающего контекста. Т.е. идентификатор пользователя от лица
	// которого был сделан текущей вызов. Используется в контексте сервера.
	virtual CoreSrv::UserID get_context_uid () const;

	// implemented method from CoreSrv::Session
	// вызывается из системного интерцептора после завершения запроса; приводит к вызову функции
	// finish на всех зарегистрированных пользовательских интерцепторах входящих запросах.
	// {warning}Нужно сделать приватным{warning}
	virtual void finish_user_request (CoreSrv::UserID uid) const;

	// implemented method from CoreSrv::Session
	// Авторизация на сервере с указанием логин-пароля. В случае успешной авторизации клиентская
	// сессия получает идентификатор отличный от нуля. В случае ошибки авторизации воозбуждается
	// исключение
	virtual void login (
		const std::string& login
		, const std::string& pswd
	) /*throw (
		CoreSrv::AccessDenied
		, CoreSrv::AlreadyLogged
	)*/;

	// implemented method from CoreSrv::Session
	// Завершение сессии
	virtual void logout ();

	// implemented method from CoreSrv::Session
	// Идентификатор клиентской сессии (не равен нулю в случае успешной авторизации на сервере).
	// Используется в контексте клиента.
	virtual CoreSrv::SessionID get_self_sid () const;

	// implemented method from CoreSrv::Session
	// Идентификатор пользователя от имени которого была выполнена автоизация. Используется в
	// контексте клиента.
	virtual CoreSrv::UserID get_self_uid () const;

	// implemented method from CoreSrv::Session
	// вызывается из системного интерцептора перед началом вывполнения запроса; приводит к вызову
	// функции start на всех зарегистрированных пользовательских интерцепторах входящих запросах.
	// {warning}Нужно сделать приватным{warning}
	virtual void start_user_request (CoreSrv::UserID uid) const;
}; // class Session_i

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
