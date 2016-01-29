////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewAdapterTarget/NewAdapterTarget.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> TestModel::NewAdapterTarget
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_NEWADAPTERTARGET_H__
#define __TESTMODEL_NEWADAPTERTARGET_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NewInterfaces/NewInterfacesFactories.h"
#include "TestModel/BasicTests/IfdefInterfaces/IfdefInterfacesFactories.h"

namespace NewAdapterTarget {

class Root : virtual public Core::RefCountObjectBase {
public:
	virtual BasicTests::NewInterfaces::DerivedInterface* factory_derived_interface (
	) {
		return BasicTests::NewInterfaces::DerivedInterfaceFactory::factory();
	}

	virtual BasicTests::IfdefInterfaces::TestInterface* make_test_interface (
	) {
		return BasicTests::IfdefInterfaces::TestInterfaceFactory::make();
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
} //namespace NewAdapterTarget


extern "C" __declspec (dllexport) void __stdcall dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall dll_done ();

extern "C" __declspec (dllexport) void __stdcall dll_get_root (
	NewAdapterTarget::Root*& root
);

#endif //__TESTMODEL_NEWADAPTERTARGET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
