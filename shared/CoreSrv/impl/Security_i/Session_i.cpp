////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Security_i/Session_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Security_i::Session_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/LibHome.h"
#include "shared/CoreSrv/impl/Security_i/Session_i.h"
// by <<uses>> dependencies
#include "shared/CoreSrv/SecuritySrv/SecuritySrv.h"

namespace CoreSrv {
namespace Security_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Session_i::Session_i ()
//#UC START# *45E2AB200236_45E2ABB60061_45E2AC180236_BASE_INIT*
//#UC END# *45E2AB200236_45E2ABB60061_45E2AC180236_BASE_INIT*
{
	//#UC START# *45E2AB200236_45E2ABB60061_45E2AC180236_BODY*
	m_tk.sid = 0;
	m_tk.uid = 0;
	//#UC END# *45E2AB200236_45E2ABB60061_45E2AC180236_BODY*
}

Session_i::~Session_i () {
	//#UC START# *45E2AC180236_DESTR_BODY*
	//#UC END# *45E2AC180236_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// запускает поток в котором циклически дергается серверный kep_alive
void Session_i::keep_alive_ () const {
	//#UC START# *45EEDB6B024A*
	int i = 30;
	while (!Core::ThreadPoolFactory::def().is_current_canceled ()) {
		if (i == 30) {
			i = 0;
			SecuritySrv::SessionManagerFactory::get().keep_alive();
		}
		ACE_OS::sleep (1); // 1.00 second
		i++;
	}
	LOG_D (("Session_i::keep_alive_ () - cancel detected, now exit"));
	//#UC END# *45EEDB6B024A*
}
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
struct KeepAliveParams_ {
	Session_i_cvar self;
	KeepAliveParams_ (const Session_i* self_) : self(Session_i::_duplicate(self_)) {
	}
};

void Session_i::thr_keep_alive_ (void* arg) {
	try {
		Core::Aptr<KeepAliveParams_> arg_ (reinterpret_cast<KeepAliveParams_*>(arg));
		arg_->self->keep_alive_ ();
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute Session_i::keep_alive oneway function"));
	} catch (...) {
		LOG_UEX (("while execute Session_i::keep_alive oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle Session_i::keep_alive () const {
	Core::Aptr<KeepAliveParams_> arg = new KeepAliveParams_ (this);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (Session_i::thr_keep_alive_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Session
// добавляет пользовательский интерцептор входящих запросов
void Session_i::add_request_interceptor (const UserRequestInterceptor* rint) {
	//#UC START# *46124A210177_45E2AC180236*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46124A210177_45E2AC180236*
}

// implemented method from Session
// Добавдляет каллбек-интерфейс для слежения за сессиями
void Session_i::add_session_interceptor (SessionInterceptor* sint) {
	//#UC START# *45F54ED30271_45E2AC180236*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45F54ED30271_45E2AC180236*
}

// implemented method from Session
// Идентификатор сессии вызывающего контекста. Т.е. идентификатор сессии клиента сделавший текущей
// вызов. Используется в контексте сервера.
SessionID Session_i::get_context_sid () const {
	//#UC START# *45E693C90242_45E2AC180236_GET*
	SessionID ret = 0;
	try {
		CORBA::Any_var data = LibHomeFactory::get().get_orb_facet().get_pi_current ().get_slot (
			CurrentSlotAccessor::get_current_token_slot_id ()
		);

		SecuritySrv::Token* tk;
		*data >>= tk;
		if (tk) {
			ret = tk->sid;
		}
	} CATCH_AND_LOG ("...");

	return ret;
	//#UC END# *45E693C90242_45E2AC180236_GET*
}

// implemented method from Session
// Идентификатор пользователя вызывающего контекста. Т.е. идентификатор пользователя от лица
// которого был сделан текущей вызов. Используется в контексте сервера.
UserID Session_i::get_context_uid () const {
	//#UC START# *45ED2B9A0132_45E2AC180236_GET*
	UserID ret = 0;
	try {
		CORBA::Any_var data = LibHomeFactory::get().get_orb_facet().get_pi_current ().get_slot (
			CurrentSlotAccessor::get_current_token_slot_id ()
		);

		SecuritySrv::Token* tk;
		*data >>= tk;
		if (tk) {
			ret = tk->uid;
		}
	} CATCH_AND_LOG ("...");

	return ret;
	//#UC END# *45ED2B9A0132_45E2AC180236_GET*
}

// implemented method from Session
// вызывается из системного интерцептора после завершения запроса; приводит к вызову функции finish
// на всех зарегистрированных пользовательских интерцепторах входящих запросах.
// {warning}Нужно сделать приватным{warning}
void Session_i::finish_user_request (UserID uid) const {
	//#UC START# *46124B1E0138_45E2AC180236*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46124B1E0138_45E2AC180236*
}

// implemented method from Session
// Авторизация на сервере с указанием логин-пароля. В случае успешной авторизации клиентская сессия
// получает идентификатор отличный от нуля. В случае ошибки авторизации воозбуждается исключение
void Session_i::login (const std::string& login, const std::string& pswd) /*throw (AccessDenied, AlreadyLogged)*/ {
	//#UC START# *45E2ABD100CE_45E2AC180236*
	LOG_D (("Atempt to login: %s", login.c_str ()));
	m_tk = SecuritySrv::SessionManagerFactory::get().login(login.data(), pswd.data());
	m_my_ka_thread = this->keep_alive ();
	//#UC END# *45E2ABD100CE_45E2AC180236*
}

// implemented method from Session
// Завершение сессии
void Session_i::logout () {
	//#UC START# *45E6967B007D_45E2AC180236*
	Core::ThreadPoolFactory::def().cancel_thread (m_my_ka_thread);
	Core::ThreadPoolFactory::def().join_thread (m_my_ka_thread);
	SecuritySrv::SessionManagerFactory::get().logout();
	//#UC END# *45E6967B007D_45E2AC180236*
}

// implemented method from Session
// Идентификатор клиентской сессии (не равен нулю в случае успешной авторизации на сервере).
// Используется в контексте клиента.
SessionID Session_i::get_self_sid () const {
	//#UC START# *45E551CD008C_45E2AC180236_GET*
	return m_tk.sid;
	//#UC END# *45E551CD008C_45E2AC180236_GET*
}

// implemented method from Session
// Идентификатор пользователя от имени которого была выполнена автоизация. Используется в контексте
// клиента.
UserID Session_i::get_self_uid () const {
	//#UC START# *45ED2B8E022C_45E2AC180236_GET*
	return m_tk.uid;
	//#UC END# *45ED2B8E022C_45E2AC180236_GET*
}

// implemented method from Session
// вызывается из системного интерцептора перед началом вывполнения запроса; приводит к вызову
// функции start на всех зарегистрированных пользовательских интерцепторах входящих запросах.
// {warning}Нужно сделать приватным{warning}
void Session_i::start_user_request (UserID uid) const {
	//#UC START# *46124A7202AF_45E2AC180236*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46124A7202AF_45E2AC180236*
}
} // namespace Security_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

