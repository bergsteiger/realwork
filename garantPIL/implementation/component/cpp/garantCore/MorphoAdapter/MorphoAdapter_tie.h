////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapter/MorphoAdapter_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> garantCore::MorphoAdapter
//
// Dll морфологии
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTER_TIE_H__
#define __GARANTCORE_MORPHOADAPTER_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO_tie.h"
#include "shared/GCI/IO/IOFactories.h"
#include "garantCore/MorphoAdapterLib/Def/Def_tie.h"
#include "garantCore/MorphoAdapterLib/Def/DefFactories.h"

namespace MorphoAdapter {

class Root_tie {
	SET_OBJECT_COUNTER (Root_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	) {
		static ::Core::ComIID my_iid = {0xD82FA250, 0x743D, 0x4F77, {0x96, 0x42, 0xB6, 0x62, 0x4A, 0xF8, 0xE0, 0xD3}};
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

	virtual void _stdcall make_mlma_ru_4EA17FF50393 (
		MorphoAdapterLib::IMlmaRu_tie*& ret_
	) {
		_DLL_TRY
		MorphoAdapterLib::MlmaRu_tie::make_tie (MorphoAdapterLib::MlmaRuFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_morpho_adapter_4EA004A6000C (
		MorphoAdapterLib::IMorphoAdapter_tie*& ret_
	) {
		_DLL_TRY
		MorphoAdapterLib::MorphoAdapter_tie::make_tie (MorphoAdapterLib::MorphoAdapterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_morpho_manager_4EA41F3C0255 (
		MorphoAdapterLib::IMorphoManager_tie*& ret_
	) {
		_DLL_TRY
		MorphoAdapterLib::MorphoManager_tie::make_tie (MorphoAdapterLib::MorphoManagerFactory::make(), ret_);
		_DLL_CATCH
	}


};

} //namespace MorphoAdapter

extern "C" __declspec (dllexport) unsigned long __stdcall tie_dll_version ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall tie_dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall tie_dll_done ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_get_root (
	MorphoAdapter::Root_tie*& root
);


#endif //__GARANTCORE_MORPHOADAPTER_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
