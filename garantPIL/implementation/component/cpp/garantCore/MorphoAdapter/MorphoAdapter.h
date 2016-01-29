////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapter/MorphoAdapter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> garantCore::MorphoAdapter
//
// Dll морфологии
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTER_H__
#define __GARANTCORE_MORPHOADAPTER_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/DefFactories.h"

namespace MorphoAdapter {

class Root : virtual public Core::RefCountObjectBase {
public:
	virtual MorphoAdapterLib::MlmaRu* make_mlma_ru (
	) {
		return MorphoAdapterLib::MlmaRuFactory::make();
	}

	virtual MorphoAdapterLib::MorphoAdapter* make_morpho_adapter (
	) {
		return MorphoAdapterLib::MorphoAdapterFactory::make();
	}

	virtual MorphoAdapterLib::MorphoManager* make_morpho_manager (
	) {
		return MorphoAdapterLib::MorphoManagerFactory::make();
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
} //namespace MorphoAdapter


extern "C" __declspec (dllexport) void __stdcall dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall dll_done ();

extern "C" __declspec (dllexport) void __stdcall dll_get_root (
	MorphoAdapter::Root*& root
);
extern "C" __declspec (dllexport) unsigned long __stdcall dll_version ();


#endif //__GARANTCORE_MORPHOADAPTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
