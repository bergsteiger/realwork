////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapter/ArchiAdapter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> MDProcess::ArchiAdapter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTER_H__
#define __MDPROCESS_ARCHIADAPTER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IOFactories.h"
#include "shared/GCI/I18N/I18NFactories.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelperFactories.h"
#include "shared/CoreSrv/SecurityComm/SecurityCommFactories.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapter {

class Root : virtual public Core::RefCountObjectBase {
public:
	virtual ArchiAdapterLib::Gardocs::ArchiEventsListener& get_archi_events_listener (
	) {
		return ArchiAdapterLib::Gardocs::ArchiEventsListenerFactory::get();
	}

	virtual ArchiAdapterLib::Gardocs::GardocGetter* get_gardoc_getter (
	) {
		return ArchiAdapterLib::Gardocs::GardocGetterFactory::get();
	}

	virtual ArchiAdapterLib::Gardocs::Searcher& get_searcher (
	) {
		return ArchiAdapterLib::Gardocs::SearcherFactory::get();
	}

	virtual ArchiAdapterLib::Gardocs::Searcher2* get_searcher2 (
	) {
		return ArchiAdapterLib::Gardocs::Searcher2Factory::get();
	}

	virtual ArchiAdapterLib::Gardocs::Utils* get_utils (
	) {
		return ArchiAdapterLib::Gardocs::UtilsFactory::get();
	}

	virtual CoreSrv::Authenticator& get_authenticator (
	) {
		return CoreSrv::AuthenticatorFactory::get();
	}

	virtual GCI::UnicodeHelper::ConverterHelper* make_converter_helper (
	) {
		return GCI::UnicodeHelper::ConverterHelperFactory::make();
	}

	virtual GCI::I18N::LocaleOperations& make_locale_operations (
	) {
		return GCI::I18N::LocaleOperationsFactory::make();
	}

	virtual GCI::I18N::Messages& messages_messages (
	) {
		return GCI::I18N::MessagesFactory::messages();
	}

	virtual GCI::IO::Stream* make_stream (
	) {
		return GCI::IO::StreamFactory::make();
	}

	virtual GCI::IO::Stream* make_stream (
		const char* path
	
	) {
		return GCI::IO::StreamFactory::make(path);
	}

	virtual GCI::IO::String* make_string (
		const char* str
	
	) {
		return GCI::IO::StringFactory::make(str);
	}

	virtual GCI::IO::String* alloc_string (
		unsigned long maximum
	
	) {
		return GCI::IO::StringFactory::alloc(maximum);
	}


	
	typedef ACE_Singleton <Root, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Root, ACE_SYNCH_RECURSIVE_MUTEX>;
};

class DllInintializator {
public:
	static void init (unsigned long client_version, const char* locale_string);
	static void done ();

private:
	static Core::Mutex s_init_mutex;
	static unsigned long s_count;
};
} //namespace ArchiAdapter


extern "C" __declspec (dllexport) void __stdcall dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall dll_done ();

extern "C" __declspec (dllexport) void __stdcall dll_get_root (
	ArchiAdapter::Root*& root
);
extern "C" __declspec (dllexport) unsigned long __stdcall dll_version ();


#endif //__MDPROCESS_ARCHIADAPTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
