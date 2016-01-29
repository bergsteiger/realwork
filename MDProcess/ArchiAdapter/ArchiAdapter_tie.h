////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapter/ArchiAdapter_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> MDProcess::ArchiAdapter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTER_TIE_H__
#define __MDPROCESS_ARCHIADAPTER_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO_tie.h"
#include "shared/GCI/IO/IOFactories.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs_tie.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapter {

class Root_tie {
	SET_OBJECT_COUNTER (Root_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	) {
		static ::Core::ComIID my_iid = {0xF46E9F00, 0xB3F3, 0x471D, {0xAE, 0xE5, 0x45, 0x51, 0x82, 0xD9, 0x9D, 0xB3}};
		if (my_iid == iid) {
			this->addref();
			object = this;
			return 0x00000000UL;
		} else {
			object = 0;
			return 0x80004002UL;
		}
	}

public:
	virtual unsigned long __stdcall addref () const {
		return ++m_counter;
	}

	virtual unsigned long __stdcall release () const {
		if (m_counter == 1) {
			delete this;
			return 0;
		}
		return --m_counter;
	}
	
private:
	typedef ACE_Singleton<Root_tie, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;

public:
	Root_tie () : m_counter (1) {
	}

	static Root_tie* instance() {
		return Singleton::instance();
	}

	// exported factories

	virtual void _stdcall get_archi_events_listener_4E8F4243005A (
		ArchiAdapterLib::Gardocs::IArchiEventsListener_tie*& ret_
	) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::ArchiEventsListener_tie::make_tie (&ArchiAdapterLib::Gardocs::ArchiEventsListenerFactory::get(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall get_gardoc_getter_5499A00F031A (
		ArchiAdapterLib::Gardocs::IGardocGetter_tie*& ret_
	) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::GardocGetter_tie::make_tie (ArchiAdapterLib::Gardocs::GardocGetterFactory::get(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_gardoc_list_4E1447980009 (ArchiAdapterLib::Gardocs::GardocList_tie*& ret_) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::GardocList_tie::new_tie (new ArchiAdapterLib::Gardocs::GardocList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_image_list_4EA1133902FC (ArchiAdapterLib::Gardocs::ImageList_tie*& ret_) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::ImageList_tie::new_tie (new ArchiAdapterLib::Gardocs::ImageList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_long_list_5499A05501EF (ArchiAdapterLib::Gardocs::LongList_tie*& ret_) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::LongList_tie::new_tie (new ArchiAdapterLib::Gardocs::LongList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall get_searcher_4E1446DD013E (
		ArchiAdapterLib::Gardocs::ISearcher_tie*& ret_
	) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::Searcher_tie::make_tie (&ArchiAdapterLib::Gardocs::SearcherFactory::get(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall get_searcher2_541AB3ED00FA (
		ArchiAdapterLib::Gardocs::ISearcher2_tie*& ret_
	) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::Searcher2_tie::make_tie (ArchiAdapterLib::Gardocs::Searcher2Factory::get(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_string_list_4E15588F0197 (ArchiAdapterLib::Gardocs::StringList_tie*& ret_) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::StringList_tie::new_tie (new ArchiAdapterLib::Gardocs::StringList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall get_utils_54999FC6024E (
		ArchiAdapterLib::Gardocs::IUtils_tie*& ret_
	) {
		_DLL_TRY
		ArchiAdapterLib::Gardocs::Utils_tie::make_tie (ArchiAdapterLib::Gardocs::UtilsFactory::get(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_stream_442807A00138 (
		GCI::IO::IStream_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::Stream_tie::make_tie (GCI::IO::StreamFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_stream_44312A6F0128 (
		const char* path
		, GCI::IO::IStream_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::Stream_tie::make_tie (GCI::IO::StreamFactory::make(path), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall alloc_string_43184161036A (
		unsigned long maximum
		, GCI::IO::IString_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::String_tie::make_tie (GCI::IO::StringFactory::alloc(maximum), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_string_461384D70213 (
		const char* str
		, GCI::IO::IString_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::String_tie::make_tie (GCI::IO::StringFactory::make(str), ret_);
		_DLL_CATCH
	}


};

} //namespace ArchiAdapter

extern "C" __declspec (dllexport) unsigned long __stdcall tie_dll_version ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall tie_dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall tie_dll_done ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_get_root (
	ArchiAdapter::Root_tie*& root
);


#endif //__MDPROCESS_ARCHIADAPTER_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
