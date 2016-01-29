////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewComTarget/NewComTarget.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ComTarget::Category>> TestModel::NewComTarget
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectWatcher.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeManager_factory.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
#include "TestModel/NewLibrary/LibHome.h"
#include "TestModel/BasicTests/LibHome.h"
#include "TestModel/gui/Garant/SubTestLibrary/LibHome.h"
#include "TestModel/SubServerLibrary/LibHome.h"
#include "TestModel/NewServerLibrary/LibHome.h"
#include "TestModel/NewServerLibrary/ServerLibHome.h"
#include "TestModel/BasicTests/LibHome.h"
#include "TestModel/gui/Garant/SubTestLibrary/LibHome.h"
#include "TestModel/SubServerLibrary/LibHome.h"
#include "TestModel/gui/Garant/NewTestLibrary/LibHome.h"
#include "TestModel/BasicTests/LibHome.h"
#include "TestModel/gui/Garant/SubTestLibrary/LibHome.h"
#include "TestModel/SubServerLibrary/LibHome.h"


/////////////////////ComServant includes//////////////////////
#include "TestModel/BasicTests/impl/NewImpl1/NewComServant.h"

//#UC START# *49AECD1A0248_CUSTOM_INC*
//#UC END# *49AECD1A0248_CUSTOM_INC*

ATL::CComModule _Module;

BEGIN_OBJECT_MAP(ObjectMap)

	OBJECT_ENTRY(CLSID_CoNewComInterface, BasicTests::NewImpl1::NewComServant)
	
END_OBJECT_MAP()

class NewComTargetApp: public CWinApp {
public:
	virtual BOOL InitInstance();
	
	virtual int ExitInstance();
	
	DECLARE_MESSAGE_MAP()
};

BEGIN_MESSAGE_MAP(NewComTargetApp, CWinApp)
END_MESSAGE_MAP()

NewComTargetApp theApp;

class ComThreadInit: public virtual Core::Root::ThreadInitializer, public virtual Core::RefCountObjectBase {
	// Вызывается при создании потока
	void thread_init () {
		::CoInitialize (0);
	}

	// вызывается при завершении потока
	void thread_finalize () {
		::CoUninitialize ();
	}
};

Core::Mutex COMDllInintializator::s_init_mutex;
unsigned long COMDllInintializator::s_count = 0;

void COMDllInintializator::init () {
	GUARD (s_init_mutex);
	if (s_count++ != 0) {
		return;
	}
	
	Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get();
	Core::Var<ComThreadInit> cti = new ComThreadInit ();
	lhm.registrate_thread_initializer (cti.in());

	{
		lhm.registrate_lib_home (&BasicTests::LibHomeFactory::get ());
		lhm.registrate_lib_home (&SubTestLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&SubServerLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewServerLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewServerLibrary::ServerLibHomeFactory::get ());
		lhm.registrate_lib_home (&NewTestLibrary::LibHomeFactory::get ());
	}

	try {
		lhm.execute ();
	} catch (Core::Root::HomeManagerInitError&) {
		LOG_W (("Server uninitialized - working in standalone mode"));
	} CATCH_LOG_AND_DO ("while HomeManager processed", return;)
}
	
void COMDllInintializator::done () {
	GUARD (s_init_mutex);
	if (--s_count != 0) {
		return;
	}
	Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get();
	lhm.finalize ();
}

BOOL NewComTargetApp::InitInstance() {
	Core::init ();
	_Module.Init(ObjectMap, m_hInstance, &LIBID_NewComInterfacesLib);
	
	{
		CoreSrv::Root_i::CorbaLibHomeManager_factory_var f = new CoreSrv::Root_i::CorbaLibHomeManager_factory ();
		f->registrate_me(0);
	}
	{
		Core::ParamsImpl::ParamManagerImpl_factory_var f = new Core::ParamsImpl::ParamManagerImpl_factory ();
		f->registrate_me(0);
	}
	try {
		Core::ParamManagerInitData init = {"NewComTarget", "Core::RegistryHelper::KEY_LOCAL_MACHINE\\Software\\Garant\\TestModel\\NewComTarget"};
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (0, 0), init);
	} CATCH_AND_LOG ("while init ParamManager executed")
	return CWinApp::InitInstance();
}

int NewComTargetApp::ExitInstance() {
	_Module.Term();
	Core::fini ();
	return CWinApp::ExitInstance();
}

// Used to determine whether the DLL can be unloaded by OLE
STDAPI DllCanUnloadNow () {
    AFX_MANAGE_STATE (AfxGetStaticModuleState ());
    return (AfxDllCanUnloadNow () == S_OK && _Module.GetLockCount () == 0) ? S_OK : S_FALSE;
}

// Returns a class factory to create an object of the requested type
STDAPI DllGetClassObject (REFCLSID rclsid, REFIID riid, LPVOID* ppv) {
    AFX_MANAGE_STATE (AfxGetStaticModuleState ());
    return _Module.GetClassObject (rclsid, riid, ppv);
}

// DllRegisterServer - Adds entries to the system registry
STDAPI DllRegisterServer () {
    AFX_MANAGE_STATE (AfxGetStaticModuleState ());
    return _Module.RegisterServer (TRUE);
}

// DllUnregisterServer - Removes entries from the system registry
STDAPI DllUnregisterServer () {
    AFX_MANAGE_STATE (AfxGetStaticModuleState ());
    return _Module.UnregisterServer (TRUE);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
