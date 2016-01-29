//
// AdapterLoader.h : header file
//

#ifndef __CONTEXT_SEARCH_ADAPTER_LOADER_H__
#define __CONTEXT_SEARCH_ADAPTER_LOADER_H__

#include "shared/GCL/os/DllLoader.h"

#include "garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/Adapter/Adapter.h"

static const unsigned long SEARCH_ADAPTER_VERSION = 8;

class SearchAdapter
	: public GCL::DllLoader {
public:
	SearchAdapter () : GCL::DllLoader ("CSAdapter"), m_adapter (0) {
		GDS_ASSERT (this->is_loaded ());
	}

	virtual ~SearchAdapter () {
		this->done ();
	}

public:
	SearchAdapterLib::Adapter::ISearcher* get (DBCore::IBase* base, Morpho::Def::ICache* cache, const::std::string& src) {
		return (this->init_adapter ())? m_adapter->get (base, cache, src) : 0;
	}

	SearchAdapterLib::Adapter::IHelper* get (DBCore::IBase* base, Morpho::Def::ICache* cache) {
		return (this->init_adapter ())? m_adapter->get (base, cache) : 0;
	}

	const DBCore::RelTuneData& get_tune_data () {
		static const DBCore::RelTuneData data;
		return (this->init_adapter ())? m_adapter->get_tune_data () : data;
	}

	void load_cache (DBCore::IBase* base) {
		if (this->init_adapter ()) {
			m_adapter->init (base);
		}
	}

	void load_memcache (const DBCore::MemCacheSettings& settings) {
		if (this->init_adapter ()) {
			m_adapter->load_memcache (settings);
		}
	}

	void reset () {
		if (m_adapter) {
			m_adapter->fini ();
		}
	}

	void init () {
		if (this->is_loaded ()) {
			try {
				typedef void (*ADAPTER_INIT) (unsigned long);
				ADAPTER_INIT dll_init = this->get_func_ptr <ADAPTER_INIT> ("dll_init");

				dll_init (SEARCH_ADAPTER_VERSION);

			} catch (Core::Root::WrongVersion&) {
				LOG_E (("%s: invalid version", GDS_CURRENT_FUNCTION));
				throw;
			} catch (Core::Root::DuplicatedFactoryKey&) {
				LOG_I (("%s: duplicated factory key", GDS_CURRENT_FUNCTION));
			} catch (...) {
				LOG_UEX (("%s: init", GDS_CURRENT_FUNCTION));
				throw;
			}
		}
	}

	void done () {
		if (this->is_loaded ()) {
			try {
				typedef void (*ADAPTER_DONE) ();
				ADAPTER_DONE dll_done = this->get_func_ptr <ADAPTER_DONE> ("dll_done");
				dll_done ();
			} catch (...) {
				LOG_UEX ((GDS_CURRENT_FUNCTION));
			}
		}
	}

private:
	bool init_adapter () {
		if (m_adapter == 0 && this->is_loaded ()) {
			try {
				typedef void (*SET_LOG) (ACE_Log_Msg_Backend*);
				SET_LOG set_log = this->get_func_ptr <SET_LOG> ("set_log");

				set_log (ACE_LOG_MSG->msg_backend ());

				typedef SearchAdapterLib::Adapter::IAdapter& (*GET_ADAPTER) ();
				GET_ADAPTER get_adapter = this->get_func_ptr <GET_ADAPTER> ("get");

				m_adapter = &get_adapter ();
			} catch (...) {
				LOG_UEX (("%s: get_adapter", GDS_CURRENT_FUNCTION));
				throw;
			}
		}

		GDS_ASSERT (m_adapter);

		return (m_adapter != 0);
	}

private:
	typedef ACE_Singleton <SearchAdapter, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SearchAdapter, ACE_SYNCH_RECURSIVE_MUTEX>;

public:
	static SearchAdapter* instance () {
		return Singleton::instance ();
	}

private:
	SearchAdapterLib::Adapter::IAdapter* m_adapter;
};

#endif // __CONTEXT_SEARCH_ADAPTER_LOADER_H__
