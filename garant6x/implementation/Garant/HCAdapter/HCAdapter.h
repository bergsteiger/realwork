////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapter/HCAdapter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> garant6x::HCAdapter
//
// Библиотека для взаимодействия сервера консультаций и ПО отдела правовой поддержки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTER_H__
#define __GARANT6X_HCADAPTER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IOFactories.h"
#include "shared/GCI/I18N/I18NFactories.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelperFactories.h"
#include "garant6x/implementation/Garant/CommonUtils/XML/XMLFactories.h"
#include "shared/GSI/NotifyService/NotifyServiceFactories.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"
//#UC START# *442BEE8500AB_CUSTOM_INCLUDE*
#include "garantServer/src/Business/GblConsulting/GblConsultingC.h"
//#UC END# *442BEE8500AB_CUSTOM_INCLUDE*

namespace HCAdapter {

class Root : virtual public Core::RefCountObjectBase {
public:
	virtual CommonUtils::XML::XMLReader* make_xml_reader (
	) {
		return CommonUtils::XML::XMLReaderFactory::make();
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

	virtual GSI::NotifyService::Manager& make_manager (
	) {
		return GSI::NotifyService::ManagerFactory::make();
	}

	virtual GSI::NotifyService::Supplier* make_supplier (
	) {
		return GSI::NotifyService::SupplierFactory::make();
	}

	virtual HCAdapterLib::HCInterfaces::BusinessLogicLifeCycle* make_business_logic_life_cycle (
	) {
		return HCAdapterLib::HCInterfaces::BusinessLogicLifeCycleFactory::make();
	}

	virtual HCAdapterLib::HCInterfaces::ConsultingRequests* make_consulting_requests (
	) {
		return HCAdapterLib::HCInterfaces::ConsultingRequestsFactory::make();
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
} //namespace HCAdapter


extern "C" __declspec (dllexport) void __stdcall dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall dll_done ();

extern "C" __declspec (dllexport) void __stdcall dll_get_root (
	HCAdapter::Root*& root
);
extern "C" __declspec (dllexport) unsigned long __stdcall dll_version ();


#endif //__GARANT6X_HCADAPTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
