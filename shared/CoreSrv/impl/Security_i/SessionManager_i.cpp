////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Security_i/SessionManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Security_i::SessionManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/LibHome.h"
#include "shared/CoreSrv/impl/Security_i/SessionManager_i.h"
// by <<uses>> dependencies
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"

namespace CoreSrv {
namespace Security_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SessionManager_i::SessionManager_i () : m_sid_incrementor (0)
//#UC START# *45E2B8CC0255_45E2B9010090_45E2B93701A9_BASE_INIT*
//#UC END# *45E2B8CC0255_45E2B9010090_45E2B93701A9_BASE_INIT*
{
	//#UC START# *45E2B8CC0255_45E2B9010090_45E2B93701A9_BODY*
	this->session_watcher();
	//#UC END# *45E2B8CC0255_45E2B9010090_45E2B93701A9_BODY*
}

SessionManager_i::~SessionManager_i () {
	//#UC START# *45E2B93701A9_DESTR_BODY*
	//#UC END# *45E2B93701A9_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Удаляет сессию из списка активных и проводит процедуру особождения связанный с ней данных. Так
// же вызывает зарегистрированные калбек-интерфейсы.
void SessionManager_i::remove_sid (SessionID sid) {
	//#UC START# *45F549BB029F*
	LOG_D (("SessionManager_i::remove_sid (%d)", sid));
	GUARD (m_session_mut);
	SessionMap::iterator f = m_sessions.find(sid);
	if (f != m_sessions.end()) {
		for (SInts::iterator it = m_sints.begin(); it != m_sints.end(); ++it) {
			try {
				(*it)->before_session_delete (sid, f->second.profile.uid);
			} CATCH_AND_LOG ("while try to notify SessionInterceptor");
		}
	
		m_sessions.erase(f);
	} else {
		LOG_E (("SessionManager_i::remove_sid (%d) - unknown sid", sid));
	}
	//#UC END# *45F549BB029F*
}

// Контролирует (в цикле) время жизни активных сессий
void SessionManager_i::session_watcher_ () {
	//#UC START# *45F550590138*
	while (!Core::ThreadPoolFactory::def().is_current_canceled ()) {
		{
			GUARD (m_session_mut);
		
			for (SessionMap::iterator it = m_sessions.begin(); it != m_sessions.end(); ++it) {
				if (it->second.time_to_kill != ACE_Time_Value (0, 0)) {
					it->second.time_to_kill -= ACE_Time_Value (1, 0);
				} else {
					this->remove_sid (it->first);
					break; // есть риск не почистить все сессии умершие в интервале одной секунды... нужнопотом поправить
				}
			}
		}
		
		ACE_OS::sleep (1); // 1.00 second
	}

	// удаляем все оставшиеся сессии
	for (SessionMap::iterator it = m_sessions.begin(); it != m_sessions.end(); ++it) {
		this->remove_sid (it->first);
	}

	LOG_D (("SessionManager_i::session_watcher_ () - cancel detected, now exit"));
	//#UC END# *45F550590138*
}
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
struct SessionWatcherParams_ {
	SessionManager_i_var self;
	SessionWatcherParams_ (SessionManager_i* self_) : self(SessionManager_i::_duplicate(self_)) {
	}
};

void SessionManager_i::thr_session_watcher_ (void* arg) {
	try {
		Core::Aptr<SessionWatcherParams_> arg_ (reinterpret_cast<SessionWatcherParams_*>(arg));
		arg_->self->session_watcher_ ();
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute SessionManager_i::session_watcher oneway function"));
	} catch (...) {
		LOG_UEX (("while execute SessionManager_i::session_watcher oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle SessionManager_i::session_watcher () {
	Core::Aptr<SessionWatcherParams_> arg = new SessionWatcherParams_ (this);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (SessionManager_i::thr_session_watcher_), arg.in ()
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

// implemented method from SecuritySrv::SessionManager
// Добавдляет каллбек-интерфейс для слежения за сессиями
void SessionManager_i::add_session_interceptor (SessionInterceptor* sint) throw (CORBA::SystemException) {
	//#UC START# *45F55293009C_45E2B93701A9*
	m_sints.insert (SessionInterceptor::_duplicate(sint));
	//#UC END# *45F55293009C_45E2B93701A9*
}

// implemented method from SecuritySrv::SessionManager
// сообщает менеджеру о том что текущая (от имиени которой сделан вызов) сессияи жива
void SessionManager_i::keep_alive () throw (CORBA::SystemException) {
	//#UC START# *45EEDB8E023A_45E2B93701A9*
	LOG_D (("%d still live", CoreSrv::SessionFactory::get().get_context_uid()));
	SessionID sid = CoreSrv::SessionFactory::get().get_context_sid();
	
	GUARD (m_session_mut);
	SessionMap::iterator f = m_sessions.find(sid);
	if (f != m_sessions.end()) {
		f->second.time_to_kill = ACE_Time_Value (60, 0);
	} else {
		LOG_E (("SessionManager_i::keep_alive [%d] - unknown sid", sid));
	}
	//#UC END# *45EEDB8E023A_45E2B93701A9*
}

// implemented method from SecuritySrv::SessionManager
// Авторизация и начало сессии. В случае успеха воззвращает авторазационные данные с не нулевым id
// сессии. Иначе исключение.
SecuritySrv::Token SessionManager_i::login (
	const char* login
	, const char* pswd
) throw (
	CORBA::SystemException
	, AccessDenied
	, AlreadyLogged
) {
	//#UC START# *45E2F05B0003_45E2B93701A9*
	Core::Aptr <ProfileData> data = AuthenticatorFactory::get().authentication (login, pswd);
	
	// check sessions
	GUARD (m_session_mut);
	{
		for (SessionMap::iterator it = m_sessions.begin(); it != m_sessions.end(); ++it) {
			if (it->second.profile.uid == data->uid) {
				if (it->second.profile.type == CoreSrv::PT_REGULAR) {
					throw AlreadyLogged ();
				}
			}
		}
	}

	SecuritySrv::Token ret;
	ret.sid = ++this->m_sid_incrementor;
	ret.uid = data->uid;

	m_sessions[ret.sid].profile = *data;
	m_sessions[ret.sid].time_to_kill = ACE_Time_Value (60, 0);

	for (SInts::iterator it = m_sints.begin(); it != m_sints.end(); ++it) {
		try {
			(*it)->after_session_created(ret.sid, ret.uid);
		} CATCH_AND_LOG ("while try to notify SessionInterceptor");
	}

	return ret;
	//#UC END# *45E2F05B0003_45E2B93701A9*
}

// implemented method from SecuritySrv::SessionManager
// Завершение сессии.
void SessionManager_i::logout () throw (CORBA::SystemException) {
	//#UC START# *45E695C603A9_45E2B93701A9*
	this->remove_sid (CoreSrv::SessionFactory::get().get_context_sid());
	//#UC END# *45E695C603A9_45E2B93701A9*
}
} // namespace Security_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

