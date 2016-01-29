////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageContainer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::PackageContainer
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/LibHome.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageContainer.h"
// by <<uses>> dependencies
#include "MDProcess/ServerGate/Users/Users.h"
#include "MDProcess/RosePackageLocking/LockStarageDef/LockStorage.h"
#include "shared/GCL/os/FileOp.h"
#include <fstream>
#include "ace/Reactor.h"
#include "antlr/ANTLRException.hpp"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageParams.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// возвращает статус залочки дл€ определенного юзера
RosePackageLockingServer::LockStatus PackageContainer::get_status (CoreSrv::UserID user_id, CoreSrv::UserID owner_id) {
	//#UC START# *45E6CC8F001C*
	if (0 == owner_id) {
		return RosePackageLocking::RosePackageLockingServer::LS_FREE;
	} else if (user_id == owner_id) {
		return RosePackageLocking::RosePackageLockingServer::LS_LOCKED_TO_SELF;
	}
	return RosePackageLocking::RosePackageLockingServer::LS_LOCKED;
	//#UC END# *45E6CC8F001C*
}

// ¬озвращает текущую дату и врем€ в виде строки
const std::string PackageContainer::get_time () {
	//#UC START# *47676EAC001E*
	ACE_Time_Value time = ACE_OS::gettimeofday ();
	ACE_TCHAR timestamp[26];

	const ACE_TCHAR *time_fmt = ACE_LIB_TEXT ("%s %s %s");
	time_t now = time.sec ();
	ACE_TCHAR ctp[26]; // 26 is a magic number...

	if (ACE_OS::ctime_r (&now, ctp, sizeof ctp) == 0) {
		return std::string ();
	}
	/* 01234567890123456789012345 */
	/* Wed Oct 18 14:25:36 1989n0 */
	
	ctp[10] = '\0'; // NUL-terminate after the data.
	ctp[19] = '\0'; // NUL-terminate after the time.
	ctp[24] = '\0'; // NUL-terminate after the year.

	ACE_OS::sprintf (timestamp,
				   time_fmt,
				   ctp,
				   ctp + 20,
				   ctp + 11);
	
	return std::string (timestamp);
	//#UC END# *47676EAC001E*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PackageContainer::PackageContainer ()
//#UC START# *45DB054C0051_45E2B3D00320_45E56B7A00D7_BASE_INIT*
//#UC END# *45DB054C0051_45E2B3D00320_45E56B7A00D7_BASE_INIT*
{
	//#UC START# *45DB054C0051_45E2B3D00320_45E56B7A00D7_BODY*
	if (PackageParams::get_storage_file() != "") {
		this->load_infos ();

		//устанавливаем таймер, при срабатывание которого, будет происходить
		//запись информации о залочках в файл (по-умалчанию таймер срабатывает каждые 5 минут)
		unsigned long timeout = PackageParams::get_flush_timeout();
		
		LibHomeFactory::get ().get_orb_facet ().get_main_orb ().orb_core ()->reactor ()->schedule_timer (
			this, 0, ACE_Time_Value (timeout), ACE_Time_Value (timeout)
		);
	} else {
		LOG_W (("-StorageFile not defined - lock info wouldn't be stored!"));
	}
	//#UC END# *45DB054C0051_45E2B3D00320_45E56B7A00D7_BODY*
}

PackageContainer::~PackageContainer () {
	//#UC START# *45E56B7A00D7_DESTR_BODY*
	LibHomeFactory::get ().get_orb_facet ().get_main_orb ().orb_core ()->reactor ()->cancel_timer (this);
	this->store_infos ();
	//#UC END# *45E56B7A00D7_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// поток, в котором через определЄнные промежутки времени информаци€ о залочках сохран€етс€ в
// хранилище
void PackageContainer::flush_thread_ () const {
	//#UC START# *487AEFCA0238*
	//врем€ через которое нужно "сбрасывать" информацию в хранилище (по-умолчанию 5 минут)
	unsigned long timeout = PackageParams::get_flush_timeout();
	unsigned long i = 0;
	while (!Core::ThreadPoolFactory::def().is_current_canceled ()) {
		if (i == timeout) {
			i = 0;
			this->store_infos ();
		}
		ACE_OS::sleep (1); // 1.00 second
		i++;
	}
	//сохран€ем информацию о залочках перед выходом, т.к веро€тна ситуаци€, когда деструктор не вызоветс€...
	this->store_infos ();
	LOG_D (("PackageContainer::flush_thread_ () - cancel detected, now exit"));
	//#UC END# *487AEFCA0238*
}

// восстанавливает информацию о залочках из хранилища
void PackageContainer::load_infos () {
	//#UC START# *487AEF6502EE*
	std::string storage_file = PackageParams::get_storage_file();
	if (storage_file.empty () == false) {
		std::ifstream try_open (storage_file.c_str ());
		if (try_open.is_open ()) {
			try_open.close ();

			LOG_I (("Trying to load lock info from file: %s", storage_file.c_str ()));
			RosePackageLocking::LockStarageDef::LockStorage storage (storage_file.c_str ());
			try {
				RosePackageLocking::LockStarageDef::PackageInfoList infos = storage.packages ();
				LOG_D (("Read %d packages from storage", infos.size ()));

				RosePackageLocking::LockStarageDef::PackageInfoList::const_iterator it = infos.begin ();
				RosePackageLocking::LockStarageDef::PackageInfoList::const_iterator it_end = infos.end ();
				GUARD (m_access_guard);
				for (; it != it_end; ++it) {
					PackageInfo& info = m_guid2info[(*it)->get_guid ()];
					info.owner_user = (*it)->get_owner_id ();
					info.time = (*it)->get_time ();
					info.full_name = (*it)->get_full_name ();
				}
			} catch (antlr::ANTLRException& ex) {
				LOG_E (("PackageContainer::load_infos() catch ANTLRException"));
			} CATCH_AND_LOG("while PackageContainer::load_infos ()");
		}
	}
	//#UC END# *487AEF6502EE*
}

// рассылает всем сообщение о изменении состо€ни€  залочки
void PackageContainer::send_lock_changed_ (
	CoreSrv::UserID user_id
	, RosePackageLockingServer::LockChange lc
	, RosePackageLockingServer::PackageGUID_const guid
	, const char* time
) {
	//#UC START# *45E6DEF201D1*
	ServerGate::Users::User& user = ServerGate::Users::UserFactory::make (user_id);
	CORBA::String_var name = user.get_name ();

	LOG_D (("PackageContainer::send_lock_changed START, %s %s by %s, m_locks_listeners.size() = %d", guid, (RosePackageLockingServer::LC_LOCK == lc) ? "locked": "unlocked", name.in (), m_locks_listeners.size()));

	Core::Aptr<LocksListeners> copy;
	//делаем копию, что бы освободить гуард
	{
		GUARD (m_listeners_guard);
		copy = new LocksListeners (m_locks_listeners.begin(), m_locks_listeners.end());
	}


	for (LocksListeners::iterator it = copy->begin (); it != copy->end (); ++it) {
		try {
			//нужен дл€ копии, что бы в другом потоке не занулили
			RosePackageLockingServer::LocksListener_var listener_copy;

			{
				GUARD (m_listeners_guard);
				if (!CORBA::is_nil(it->ptr()->listener.in())) { 
					listener_copy = RosePackageLockingServer::LocksListener::_duplicate (it->ptr()->listener.in());
				}
			}

			if (!CORBA::is_nil(listener_copy.in())) {
				if (user_id != it->ptr()->owner_user) {
					listener_copy->lock_changed (guid, name.in (), time, lc);
				}
			}

		} catch (CORBA::Exception& e) {
			LOG_CEX ((e, "in PackageContainer::send_lock_changed"));

			GUARD (m_listeners_guard);
			it->ptr()->listener = RosePackageLockingServer::LocksListener::_nil();
		}
	}

	LOG_D (("PackageContainer::send_lock_changed FINISH, m_locks_listeners.size() = %d", m_locks_listeners.size()));
	//#UC END# *45E6DEF201D1*
}

// сохран€ет информацию о залочках в хранилище
void PackageContainer::store_infos () const {
	//#UC START# *487AEF8F0073*
	GUARD (m_store_guard);

	std::string storage_file = PackageParams::get_storage_file();
	if (storage_file.empty () == false) {
		std::string tmp_file = storage_file + ".bk"; //копируем во временный файл
		std::ifstream try_open (storage_file.c_str ());
		if (try_open.is_open ()) {
			try_open.close ();
			try {
				GCL::FileOp::copy_file (storage_file.c_str (), tmp_file.c_str (), true);
			} catch (GCL::FileOp::FOException& ex)  {
				LOG_E (("Can't backup storage file: %s", ex.what ()));
			}
		}
		std::ofstream out_stream (storage_file.c_str (), std::ios_base::trunc | std::ios_base::out);
		if (out_stream.is_open ()) {
			LOG_I (("Trying to store lock info to file: %s", storage_file.c_str ()));

			//копируем информацию о залочках, чтобы не задерживать доступ.
			GUID2PackageInfo copied_info;
			{
				GUARD (m_access_guard);
				copied_info = m_guid2info;
			}
			GUID2PackageInfo::const_iterator it = copied_info.begin ();
			GUID2PackageInfo::const_iterator it_end = copied_info.end ();
			for (; it != it_end; ++it) {
				if (it->second.owner_user != 0) {
					RosePackageLocking::LockStarageDef::PackageInfo info;
					info.set_guid (it->first);
					info.set_owner_id (it->second.owner_user);
					info.set_full_name (it->second.full_name);
					info.set_time (it->second.time);

					out_stream << info;
				}
			}
		} else {
			LOG_E (("Can't open file \"%s\" to store lock infos", storage_file.c_str ()));
		}
	}
	//#UC END# *487AEF8F0073*
}
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
struct FlushThreadParams_ {
	PackageContainer_cvar self;
	FlushThreadParams_ (const PackageContainer* self_) : self(PackageContainer::_duplicate(self_)) {
	}
};

void PackageContainer::thr_flush_thread_ (void* arg) {
	try {
		Core::Aptr<FlushThreadParams_> arg_ (reinterpret_cast<FlushThreadParams_*>(arg));
		arg_->self->flush_thread_ ();
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute PackageContainer::flush_thread oneway function"));
	} catch (...) {
		LOG_UEX (("while execute PackageContainer::flush_thread oneway function"));
	}
}

struct SendLockChangedParams_ {
	PackageContainer_var self;
	CoreSrv::UserID user_id;
	RosePackageLockingServer::LockChange lc;
	std::string guid;
	std::string time;
	SendLockChangedParams_ (
		PackageContainer* self_
		, CoreSrv::UserID user_id_
		, RosePackageLockingServer::LockChange lc_
		, RosePackageLockingServer::PackageGUID_const guid_
		, const char* time_
	) :
		self(PackageContainer::_duplicate(self_))
		, user_id(user_id_)
		, lc(lc_)
		, guid(guid_)
		, time(time_)
	{
	}
};

void PackageContainer::thr_send_lock_changed_ (void* arg) {
	try {
		Core::Aptr<SendLockChangedParams_> arg_ (reinterpret_cast<SendLockChangedParams_*>(arg));
		arg_->self->send_lock_changed_ (arg_->user_id, arg_->lc, arg_->guid.data (), arg_->time.data ());
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute PackageContainer::send_lock_changed oneway function"));
	} catch (...) {
		LOG_UEX (("while execute PackageContainer::send_lock_changed oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle PackageContainer::flush_thread () const {
	Core::Aptr<FlushThreadParams_> arg = new FlushThreadParams_ (this);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (PackageContainer::thr_flush_thread_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}

/*oneway*/ Core::ThreadHandle PackageContainer::send_lock_changed (
	CoreSrv::UserID user_id
	, RosePackageLockingServer::LockChange lc
	, RosePackageLockingServer::PackageGUID_const guid
	, const char* time
) {
	Core::Aptr<SendLockChangedParams_> arg = new SendLockChangedParams_ (this, user_id, lc, guid, time);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (PackageContainer::thr_send_lock_changed_), arg.in ()
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

// implemented method from RosePackageLockingServer::PackageManager
// добавл€ет слушател€, которые будет получать сообщени€ о залочках пакетов
void PackageContainer::add_locks_listener (
	RosePackageLockingServer::LocksListener* ll
) throw (
	CORBA::SystemException
) {
	//#UC START# *4628BABA03CD_45E56B7A00D7*
	CoreSrv::Session& sm = CoreSrv::SessionFactory::get();
	CoreSrv::UserID user_id = sm.get_context_uid ();
	ListenerInfo_var li = new ListenerInfo();
	li->owner_user = user_id;
	li->listener = RosePackageLockingServer::LocksListener::_duplicate (ll);

	ServerGate::Users::User& user = ServerGate::Users::UserFactory::make (user_id);
	CORBA::String_var name = user.get_name ();
	LOG_D (("PackageContainer::add_locks_listener START for %s", name.in ()));

	{
		GUARD (m_listeners_guard)

		LOG_D (("PackageContainer::add_locks_listener() before delete m_locks_listeners.size() = %d", m_locks_listeners.size()));

		LocksListeners::iterator it = m_locks_listeners.begin ();
		while (it != m_locks_listeners.end ()) {
			if (CORBA::is_nil(it->ptr()->listener.in())) {
				m_locks_listeners.erase(it++);
			} else {
				it++;
			}
		}

		LOG_D (("PackageContainer::add_locks_listener() after delete m_locks_listeners.size() = %d", m_locks_listeners.size()));

		m_locks_listeners.push_back (li);
	}

	LOG_D (("PackageContainer::add_locks_listener FINISH"));
	//#UC END# *4628BABA03CD_45E56B7A00D7*
}

// implemented method from RosePackageLockingServer::PackageManager
// возвращает список пакетов, захваченных пользователем
RosePackageLockingServer::PackageInfoSeq* PackageContainer::get_self_locked () throw (CORBA::SystemException) {
	//#UC START# *483BE5C20298_45E56B7A00D7*
	CoreSrv::Session& sm = CoreSrv::SessionFactory::get();
	CoreSrv::UserID user_id = sm.get_context_uid ();
	
	RosePackageLockingServer::PackageInfoSeq_var infos = new RosePackageLockingServer::PackageInfoSeq ();
	GUARD (m_access_guard);
	
	GUID2PackageInfo::const_iterator it = m_guid2info.begin ();
	GUID2PackageInfo::const_iterator it_end = m_guid2info.end ();
	
	infos->length (m_guid2info.size ());

	unsigned long count = 0;
	for (; it != it_end; ++it) {
		RosePackageLockingServer::LockStatus lock_status = get_status (user_id, it->second.owner_user);		
		if (lock_status == RosePackageLocking::RosePackageLockingServer::LS_LOCKED_TO_SELF) {
			count++;
			infos->length (count);
			RosePackageLockingServer::PackageInfo& pi = (*infos)[count-1];
			pi.guid = CORBA::String_var (it->first.c_str ());
			pi.full_name = CORBA::String_var (it->second.full_name.c_str ());
			pi.time = CORBA::String_var (it->second.time.c_str ());
			pi.lock_status = RosePackageLockingServer::LS_LOCKED_TO_SELF;
			pi.lock_owner_name = CORBA::String_var (ServerGate::Users::UserFactory::make (it->second.owner_user).get_name ()).in ();
		}
	}

	return infos._retn ();
	//#UC END# *483BE5C20298_45E56B7A00D7*
}

// implemented method from RosePackageLockingServer::PackageManager
// sync - проставл€ет статусы залочек дл€ пакетов с модели, сиквенс которых передаетс€ в piseq.
void PackageContainer::sync (RosePackageLockingServer::PackageInfoSeq& piseq) throw (CORBA::SystemException) {
	//#UC START# *45DB05F70283_45E56B7A00D7*
	CoreSrv::Session& sm = CoreSrv::SessionFactory::get();
	CoreSrv::UserID user_id = sm.get_context_uid ();
	GUARD (m_access_guard);
	for (unsigned int i = 0; i < piseq.length (); i++) {
		RosePackageLockingServer::PackageInfo& pi = piseq[i];
		GUID2PackageInfo::const_iterator it = m_guid2info.find (pi.guid.in ());
		if (m_guid2info.end () == it) {
			m_guid2info[pi.guid.in ()].owner_user = 0;
			m_guid2info[pi.guid.in ()].full_name = pi.full_name;
		}
		pi.lock_status = get_status (user_id, m_guid2info[pi.guid.in ()].owner_user);
		pi.time =  CORBA::String_var (m_guid2info[pi.guid.in ()].time.c_str ());
		if (pi.lock_status == RosePackageLocking::RosePackageLockingServer::LS_LOCKED) {
			pi.lock_owner_name = CORBA::String_var (ServerGate::Users::UserFactory::make (m_guid2info[pi.guid.in ()].owner_user).get_name ()).in ();
		}
	}
	//#UC END# *45DB05F70283_45E56B7A00D7*
}

// implemented method from PackageManagerEx
// лочит пакет
void PackageContainer::lock (const std::string& guid) /*throw (RosePackageLockingServer::LockFailed)*/ {
	//#UC START# *488DA30903E7_45E56B7A00D7*
	CoreSrv::Session& sm = CoreSrv::SessionFactory::get();
	CoreSrv::UserID user_id = sm.get_context_uid ();
	
	std::string time = PackageContainer::get_time ();

	GUARD (m_access_guard);
	GUID2PackageInfo::iterator it = m_guid2info.find (guid);
	if (m_guid2info.end () == it) {
		m_guid2info[guid].owner_user = user_id;
		m_guid2info[guid].time = time;
	} else {
		if (0 == it->second.owner_user) {
			it->second.owner_user = user_id;
			it->second.time = time;
			this->send_lock_changed (
				user_id
				, RosePackageLockingServer::LC_LOCK
				, RosePackageLockingServer::PackageGUID (guid.c_str ())
				, time.c_str ()

			);
		} else {
			throw RosePackageLockingServer::LockFailed ();
		}
	}
	//#UC END# *488DA30903E7_45E56B7A00D7*
}

// implemented method from PackageManagerEx
// разлачивает пакет и не рассылает все ссобщение если установлен need_roolback
void PackageContainer::unlock (
	const std::string& guid
	, CORBA::Boolean need_roolback
) /*throw (
	RosePackageLockingServer::LockFailed
)*/ {
	//#UC START# *488DA30C02AB_45E56B7A00D7*
	CoreSrv::Session& sm = CoreSrv::SessionFactory::get();
	CoreSrv::UserID user_id = sm.get_context_uid ();
	std::string time = PackageContainer::get_time ();

	GUARD (m_access_guard);
	GUID2PackageInfo::iterator it = m_guid2info.find (guid);
	if (m_guid2info.end () != it && user_id == it->second.owner_user) {
		it->second.owner_user = 0;
		it->second.time = time;
		this->send_lock_changed (
			user_id
			, (need_roolback) ? RosePackageLockingServer::LC_ROLLBACK: RosePackageLockingServer::LC_UNLOCK
			, RosePackageLockingServer::PackageGUID (guid.c_str ())
			, time.c_str ()
		);
	} else {
		throw RosePackageLockingServer::LockFailed ();
	}
	//#UC END# *488DA30C02AB_45E56B7A00D7*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from ACE_Event_Handler
int PackageContainer::handle_timeout (const ACE_Time_Value& current_time, const void* act) {
	//#UC START# *488D76F001B4_45E56B7A00D7*
	this->store_infos ();

	return 0;
	//#UC END# *488D76F001B4_45E56B7A00D7*
}

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

