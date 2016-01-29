////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAGenerator/MDAGenerator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ComTarget::Category>> MDProcess::MDAGenerator
//
// цель сборки - com-dll плагина к Rose
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
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "MDProcess/RosePackageLocking/LibHome.h"
#include "MDProcess/ServerGate/LibHome.h"
#include "shared/WinGUI/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "MDProcess/RosePackageLocking/LibHome.h"
#include "shared/WinGUI/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "MDProcess/LinkSupport/LibHome.h"


/////////////////////ComServant includes//////////////////////
#include "MDProcess/MDAAddinLib/impl/Addin_i/CGeneration.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CModelExplorer.h"

//#UC START# *45DDD5F001A5_CUSTOM_INC*
//#UC END# *45DDD5F001A5_CUSTOM_INC*

ATL::CComModule _Module;

BEGIN_OBJECT_MAP(ObjectMap)

	OBJECT_ENTRY(CLSID_CoIGeneration, CGeneration)
	OBJECT_ENTRY(CLSID_CoIModelExplorer, CModelExplorer)
	
END_OBJECT_MAP()

class MDAGeneratorApp: public CWinApp {
public:
	virtual BOOL InitInstance();
	
	virtual int ExitInstance();
	
	DECLARE_MESSAGE_MAP()
};

BEGIN_MESSAGE_MAP(MDAGeneratorApp, CWinApp)
END_MESSAGE_MAP()

MDAGeneratorApp theApp;

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
		lhm.registrate_lib_home (&GCL::LibHomeFactory::get ());
		lhm.registrate_lib_home (&WinGUI::LibHomeFactory::get ());
		lhm.registrate_lib_home (&GCI::LibHomeFactory::get ());
		lhm.registrate_lib_home (&ServerGate::LibHomeFactory::get ());
		lhm.registrate_lib_home (&RosePackageLocking::LibHomeFactory::get ());
		lhm.registrate_lib_home (&LinkSupport::LibHomeFactory::get ());
		lhm.registrate_lib_home (&MDAModel::LibHomeFactory::get ());
		lhm.registrate_lib_home (&MDAAddinLib::LibHomeFactory::get ());
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

BOOL MDAGeneratorApp::InitInstance() {
	Core::init ();
	_Module.Init(ObjectMap, m_hInstance, &LIBID_AddinLib);
	
	{
		CoreSrv::Root_i::CorbaLibHomeManager_factory_var f = new CoreSrv::Root_i::CorbaLibHomeManager_factory ();
		f->registrate_me(0);
	}
	{
		Core::ParamsImpl::ParamManagerImpl_factory_var f = new Core::ParamsImpl::ParamManagerImpl_factory ();
		f->registrate_me(0);
	}
	try {
		Core::ParamManagerInitData init = {"MDAGenerator", "Core::RegistryHelper::KEY_LOCAL_MACHINE\\Software\\Garant\\MDProcess\\MDAGenerator"};
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (0, 0), init);
	} CATCH_AND_LOG ("while init ParamManager executed")
	return CWinApp::InitInstance();
}

int MDAGeneratorApp::ExitInstance() {
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
