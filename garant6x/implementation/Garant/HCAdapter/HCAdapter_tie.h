////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapter/HCAdapter_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> garant6x::HCAdapter
//
// Библиотека для взаимодействия сервера консультаций и ПО отдела правовой поддержки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTER_TIE_H__
#define __GARANT6X_HCADAPTER_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO_tie.h"
#include "shared/GCI/IO/IOFactories.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces_tie.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"

namespace HCAdapter {

class Root_tie {
	SET_OBJECT_COUNTER (Root_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	) {
		static ::Core::ComIID my_iid = {0xFA9E7DCD, 0x7E2B, 0x43FF, {0x87, 0x15, 0x86, 0x57, 0x04, 0xC0, 0xC7, 0x4B}};
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

	virtual void _stdcall make_business_logic_life_cycle_47861A37017B (
		HCAdapterLib::HCInterfaces::IBusinessLogicLifeCycle_tie*& ret_
	) {
		_DLL_TRY
		HCAdapterLib::HCInterfaces::BusinessLogicLifeCycle_tie::make_tie (HCAdapterLib::HCInterfaces::BusinessLogicLifeCycleFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_consulting_requests_442CE1BE03C8 (
		HCAdapterLib::HCInterfaces::IConsultingRequests_tie*& ret_
	) {
		_DLL_TRY
		HCAdapterLib::HCInterfaces::ConsultingRequests_tie::make_tie (HCAdapterLib::HCInterfaces::ConsultingRequestsFactory::make(), ret_);
		_DLL_CATCH
	}


};

} //namespace HCAdapter

extern "C" __declspec (dllexport) unsigned long __stdcall tie_dll_version ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall tie_dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall tie_dll_done ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_get_root (
	HCAdapter::Root_tie*& root
);


#endif //__GARANT6X_HCADAPTER_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
