////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Security_i/Session_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Security_i::Session_i
// Заголовок реализации класса серванта для интерфеса Session
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITY_I_SESSION_I_H__
#define __SHARED_CORESRV_SECURITY_I_SESSION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "shared/CoreSrv/Security/Security.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrv.h"
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"

namespace CoreSrv {
namespace Security_i {

class Session_i; // self forward Var
typedef ::Core::Var<Session_i> Session_i_var;
typedef ::Core::Var<const Session_i> Session_i_cvar;

class Session_i_factory;

class Session_i:
	virtual public Session
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Session_i)
	friend class Session_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// массив пользовательских интерцепторов запросов
	typedef std::vector < UserRequestInterceptor_var > UserRequestInterceptorSet;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Session_i ();

	virtual ~Session_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// запускает поток в котором циклически дергается серверный kep_alive
	/*oneway*/ Core::ThreadHandle keep_alive () const;

//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_keep_alive_ (void* arg);

protected:
	virtual void keep_alive_ () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable Core::ThreadHandle m_my_ka_thread;

	SecuritySrv::Token m_tk;

	UserRequestInterceptorSet m_uri_set;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Session
	// добавляет пользовательский интерцептор входящих запросов
	virtual void add_request_interceptor (const UserRequestInterceptor* rint);

	// implemented method from Session
	// Добавдляет каллбек-интерфейс для слежения за сессиями
	virtual void add_session_interceptor (SessionInterceptor* sint);

	// implemented method from Session
	// Идентификатор сессии вызывающего контекста. Т.е. идентификатор сессии клиента сделавший текущей
	// вызов. Используется в контексте сервера.
	virtual SessionID get_context_sid () const;

	// implemented method from Session
	// Идентификатор пользователя вызывающего контекста. Т.е. идентификатор пользователя от лица
	// которого был сделан текущей вызов. Используется в контексте сервера.
	virtual UserID get_context_uid () const;

	// implemented method from Session
	// вызывается из системного интерцептора после завершения запроса; приводит к вызову функции
	// finish на всех зарегистрированных пользовательских интерцепторах входящих запросах.
	// {warning}Нужно сделать приватным{warning}
	virtual void finish_user_request (UserID uid) const;

	// implemented method from Session
	// Авторизация на сервере с указанием логин-пароля. В случае успешной авторизации клиентская
	// сессия получает идентификатор отличный от нуля. В случае ошибки авторизации воозбуждается
	// исключение
	virtual void login (const std::string& login, const std::string& pswd) /*throw (AccessDenied, AlreadyLogged)*/;

	// implemented method from Session
	// Завершение сессии
	virtual void logout ();

	// implemented method from Session
	// Идентификатор клиентской сессии (не равен нулю в случае успешной авторизации на сервере).
	// Используется в контексте клиента.
	virtual SessionID get_self_sid () const;

	// implemented method from Session
	// Идентификатор пользователя от имени которого была выполнена автоизация. Используется в
	// контексте клиента.
	virtual UserID get_self_uid () const;

	// implemented method from Session
	// вызывается из системного интерцептора перед началом вывполнения запроса; приводит к вызову
	// функции start на всех зарегистрированных пользовательских интерцепторах входящих запросах.
	// {warning}Нужно сделать приватным{warning}
	virtual void start_user_request (UserID uid) const;
}; // class Session_i

} // namespace Security_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_SECURITY_I_SESSION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
