
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// DLL контекстного морфологического поиска
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/start_stop.h"
#include "shared/Core/sys/std_inc.h"
#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectWatcher.h"	
#include "shared/Core/mng/LogMsgSmartBackend.h"
#include "shared/Core/impl/Root_i/StdLibHomeManager_factory.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
#include "shared/GCL/LibHome.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/Morpho/LibHome.h"

#include "garantCore/SearchAdapterLib/Adapter/AdapterFactories.h"
#include "garantCore/SearchAdapterLib/LibHome.h"
#include "garantCore/DBExt/LibHome.h"

#include "CSAdapter.h"

static const unsigned long DLL_VERSION = 8;

namespace CSAdapter {

	class AdapterLog {
	public:
		AdapterLog () {	}

		void init (ACE_Log_Msg_Backend* log_msg_backend) {
			GUARD (m_mutex);
			if (m_catcher.is_nil ()) {
				m_catcher = new Core::LogMsgSmartBackendCatcher (log_msg_backend);
			}
		}

		void release () {
			GUARD (m_mutex);
			m_catcher.release ();
		}

	public:
		typedef ACE_Singleton <AdapterLog, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <AdapterLog, ACE_SYNCH_RECURSIVE_MUTEX>;

	private:
		Core::Mutex m_mutex;
		Core::Aptr <Core::LogMsgSmartBackendCatcher> m_catcher;
	};

	/////////////////////////////////////////////////////////////////////////////////////////////////////

	class DllInitializer {
	public:
		static void init (unsigned long client_version);
		static void init ();
		static void done ();

	private:
		static Core::Mutex s_mutex;
		static size_t s_count;
	};

	Core::Mutex DllInitializer::s_mutex;
	size_t DllInitializer::s_count = 0;
	
	void DllInitializer::init (unsigned long client_version) {
		GUARD (s_mutex);

		if (s_count++ != 0) {
			return;
		}

		if (client_version != DLL_VERSION) {
			Core::Root::WrongVersion ex (client_version, DLL_VERSION);
			throw ex;
		}

		Core::init ();

		{
			Core::Root_i::StdLibHomeManager_factory_var f = new Core::Root_i::StdLibHomeManager_factory ();
			f->registrate_me (0);
		} 
		
		Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get ();

		lhm.registrate_lib_home (&GCL::LibHomeFactory::get ());
		lhm.registrate_lib_home (&Morpho::LibHomeFactory::get ());
		lhm.registrate_lib_home (&ContextSearch::LibHomeFactory::get ());
		lhm.registrate_lib_home (&DBExt::LibHomeFactory::get ());
		lhm.registrate_lib_home (&SearchAdapterLib::LibHomeFactory::get ());

		lhm.execute ();
	}

	void DllInitializer::init () {
		if (s_count == 0) {
			try {
				DllInitializer::init (DLL_VERSION);
			} catch (...) {
				LOG_UEX ((GDS_CURRENT_FUNCTION));
			}
		}
	}
	
	void DllInitializer::done () {
		GUARD (s_mutex);

		if (--s_count != 0) {
			return;
		}

		AdapterLog::Singleton::instance ()->release ();

		Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get ();
		lhm.finalize ();

		Core::fini ();
	}

} //namespace CSAdapter

extern "C" __declspec (dllexport) void dll_init (unsigned long client_version) {
	CSAdapter::DllInitializer::init (client_version);
}

extern "C" __declspec (dllexport) void dll_done () {
	CSAdapter::DllInitializer::done ();
}

extern "C" __declspec (dllexport) void set_log (ACE_Log_Msg_Backend* log_msg_backend) {
	CSAdapter::AdapterLog::Singleton::instance ()->init (log_msg_backend);
}

extern "C" __declspec (dllexport) SearchAdapterLib::Adapter::IAdapter& get () {
	CSAdapter::DllInitializer::init ();
	return SearchAdapterLib::Adapter::IAdapterFactory::instance ();
}

extern "C" __declspec (dllexport) unsigned long dll_version () {
	return DLL_VERSION;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
