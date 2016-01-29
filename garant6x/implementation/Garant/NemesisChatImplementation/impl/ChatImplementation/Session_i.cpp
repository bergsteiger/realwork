////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::Session_i
//
// заглушка для получения идентификатора пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/LibHome.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UserHelper.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Session_i::Session_i ()
//#UC START# *45E2AB200236_45E2ABB60061_4A4B3C240198_BASE_INIT*
//#UC END# *45E2AB200236_45E2ABB60061_4A4B3C240198_BASE_INIT*
{
	//#UC START# *45E2AB200236_45E2ABB60061_4A4B3C240198_BODY*
	//#UC END# *45E2AB200236_45E2ABB60061_4A4B3C240198_BODY*
}

Session_i::~Session_i () {
	//#UC START# *4A4B3C240198_DESTR_BODY*
	//#UC END# *4A4B3C240198_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CoreSrv::Session
// добавляет пользовательский интерцептор входящих запросов
void Session_i::add_request_interceptor (const CoreSrv::UserRequestInterceptor* rint) {
	//#UC START# *46124A210177_4A4B3C240198*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46124A210177_4A4B3C240198*
}

// implemented method from CoreSrv::Session
// Добавдляет каллбек-интерфейс для слежения за сессиями
void Session_i::add_session_interceptor (CoreSrv::SessionInterceptor* sint) {
	//#UC START# *45F54ED30271_4A4B3C240198*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45F54ED30271_4A4B3C240198*
}

// implemented method from CoreSrv::Session
// Идентификатор сессии вызывающего контекста. Т.е. идентификатор сессии клиента сделавший текущей
// вызов. Используется в контексте сервера.
CoreSrv::SessionID Session_i::get_context_sid () const {
	//#UC START# *45E693C90242_4A4B3C240198_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45E693C90242_4A4B3C240198_GET*
}

// implemented method from CoreSrv::Session
// Идентификатор пользователя вызывающего контекста. Т.е. идентификатор пользователя от лица
// которого был сделан текущей вызов. Используется в контексте сервера.
CoreSrv::UserID Session_i::get_context_uid () const {
	//#UC START# *45ED2B9A0132_4A4B3C240198_GET*
	return UserHelper::get_user_id ();
	//#UC END# *45ED2B9A0132_4A4B3C240198_GET*
}

// implemented method from CoreSrv::Session
// вызывается из системного интерцептора после завершения запроса; приводит к вызову функции finish
// на всех зарегистрированных пользовательских интерцепторах входящих запросах.
// {warning}Нужно сделать приватным{warning}
void Session_i::finish_user_request (CoreSrv::UserID uid) const {
	//#UC START# *46124B1E0138_4A4B3C240198*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46124B1E0138_4A4B3C240198*
}

// implemented method from CoreSrv::Session
// Авторизация на сервере с указанием логин-пароля. В случае успешной авторизации клиентская сессия
// получает идентификатор отличный от нуля. В случае ошибки авторизации воозбуждается исключение
void Session_i::login (
	const std::string& login
	, const std::string& pswd
) /*throw (
	CoreSrv::AccessDenied
	, CoreSrv::AlreadyLogged
)*/ {
	//#UC START# *45E2ABD100CE_4A4B3C240198*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45E2ABD100CE_4A4B3C240198*
}

// implemented method from CoreSrv::Session
// Завершение сессии
void Session_i::logout () {
	//#UC START# *45E6967B007D_4A4B3C240198*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45E6967B007D_4A4B3C240198*
}

// implemented method from CoreSrv::Session
// Идентификатор клиентской сессии (не равен нулю в случае успешной авторизации на сервере).
// Используется в контексте клиента.
CoreSrv::SessionID Session_i::get_self_sid () const {
	//#UC START# *45E551CD008C_4A4B3C240198_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45E551CD008C_4A4B3C240198_GET*
}

// implemented method from CoreSrv::Session
// Идентификатор пользователя от имени которого была выполнена автоизация. Используется в контексте
// клиента.
CoreSrv::UserID Session_i::get_self_uid () const {
	//#UC START# *45ED2B8E022C_4A4B3C240198_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45ED2B8E022C_4A4B3C240198_GET*
}

// implemented method from CoreSrv::Session
// вызывается из системного интерцептора перед началом вывполнения запроса; приводит к вызову
// функции start на всех зарегистрированных пользовательских интерцепторах входящих запросах.
// {warning}Нужно сделать приватным{warning}
void Session_i::start_user_request (CoreSrv::UserID uid) const {
	//#UC START# *46124A7202AF_4A4B3C240198*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46124A7202AF_4A4B3C240198*
}
} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

