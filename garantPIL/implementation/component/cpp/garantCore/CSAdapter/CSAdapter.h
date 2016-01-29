////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/CSAdapter/CSAdapter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> garantCore::CSAdapter
//
// DLL контекстного морфологического поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_CSADAPTER_H__
#define __GARANTCORE_CSADAPTER_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/AdapterFactories.h"

namespace CSAdapter {

class Root : virtual public Core::RefCountObjectBase {
public:
	virtual SearchAdapterLib::Adapter::IAdapter& instance_i_adapter (
	) {
		return SearchAdapterLib::Adapter::IAdapterFactory::instance();
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
} //namespace CSAdapter


extern "C" __declspec (dllexport) void __stdcall dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall dll_done ();

extern "C" __declspec (dllexport) void __stdcall dll_get_root (
	CSAdapter::Root*& root
);
extern "C" __declspec (dllexport) unsigned long __stdcall dll_version ();


#endif //__GARANTCORE_CSADAPTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
