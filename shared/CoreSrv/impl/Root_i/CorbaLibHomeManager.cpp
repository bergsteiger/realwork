////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Root_i/CorbaLibHomeManager.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::CorbaLibHomeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/LibHome.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeManager.h"
// by <<uses>> dependencies
#include "shared/CoreSrv/impl/Root_i/Root_i.h"
#include "shared/CoreSrv/Utils/cos_naming_op.h"
#include "TAO/orbsvcs/orbsvcs/Naming/Naming_Server.h"
#include "shared/CoreSrv/Root/ServerSettings.h"
#include "shared/Core/Params/Params.h"

//#UC START# *457EA15F01D0_CUSTOM_INCLUDES*
#include "ace/Service_Config.h"
#include "shared/CoreSrv/ServerLibHome.h"
//#UC END# *457EA15F01D0_CUSTOM_INCLUDES*

namespace CoreSrv {
namespace Root_i {

//#UC START# *457EA15F01D0*
//#UC END# *457EA15F01D0*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// потоковая функция для рабочих потоков ORB-а, проводит дополнительную инициализацию потока (через
// инициализаторов потока)
void* CorbaLibHomeManager::orb_cycle_thread (void* arg) {
	//#UC START# *45802E120196*
	Core::Root::LibHomeManagerFactory::get().init_thread();
	try {
		mpcxc_set_se_handler ();
		
		CORBA::ORB_var orb = CORBA::ORB::_duplicate (static_cast <CORBA::ORB_ptr> (arg));
		GDS_ASSERT (!CORBA::is_nil (orb.in ()));

		CORBA::String_var orb_id = orb->id ();
		orb->run ();
	} CATCH_AND_LOG("inside CorbaLibHomeManager::orb_cycle_thread")

	Core::Root::LibHomeManagerFactory::get().finalize_thread();
	return 0;
	//#UC END# *45802E120196*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CorbaLibHomeManager::CorbaLibHomeManager ()
//#UC START# *457EA00F001B_457EA01F004A_457EA15F01D0_BASE_INIT*
//#UC END# *457EA00F001B_457EA01F004A_457EA15F01D0_BASE_INIT*
{
	//#UC START# *457EA00F001B_457EA01F004A_457EA15F01D0_BODY*
	this->registrate_lib_home (&CoreSrv::ServerLibHomeFactory::get());
	this->registrate_lib_home (&CoreSrv::LibHomeFactory::get());
	//#UC END# *457EA00F001B_457EA01F004A_457EA15F01D0_BODY*
}

CorbaLibHomeManager::~CorbaLibHomeManager () {
	//#UC START# *457EA15F01D0_DESTR_BODY*
	//#UC END# *457EA15F01D0_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// вызавет запуск всех необходимых (на основе параметров) стандартных CORBA-сервисов
void CorbaLibHomeManager::cos_run () {
	//#UC START# *457FC8550138*
	TAO_Naming_Server naming_server;

	long err = naming_server.init (
		m_main_orb.in()
		, m_root_poa.in ()
		, ACE_DEFAULT_MAP_SIZE
		, 0 // time out
		, 0 // resolve for existing naming service
		, 0 // persistence_location
		, TAO_NAMING_BASE_ADDR // base addr
		, 0 // enable multicast
		, 0 // use_storable_context
	);

	if (err == 0) {
		CORBA::String_var naming_service_ior = naming_server.naming_service_ior ();

		LOG_D (("Naming Service activated"));
		//LOG_D (("Naming Service ready:\n%s\n", naming_service_ior.in ()));
		m_main_orb->register_initial_reference ("NameService", naming_server.operator-> ());

		ACE_Auto_Basic_Array_Ptr <char> env; 
		{
			const char* name_service_ior_env_prefix = "NameServiceIOR=";
			env.reset (
				new char [
					ACE_OS::strlen (name_service_ior_env_prefix)
					+ACE_OS::strlen (naming_service_ior.in ())
					+1 // `+1` для нулевого символа ['\0'] в конце
				]
			);
			ACE_OS::sprintf (env.get (), "%s%s", name_service_ior_env_prefix, naming_service_ior.in ());
		}
		ACE_OS::putenv (env.get ());
	} else {
		LOG_E (("Naming Service error code: %d.\n", err));
		throw Core::Root::HomeManagerInitError();
	}

	//создаём менеджера каналов событий и регестрируем его в нэйм сервисе
	/*try {
		m_event_manager = EventComm::EventChannelManagerFactory::make ();
		
		m_event_manager->init ();

		CORBA::Object_var naming_obj = m_main_orb->resolve_initial_references ("NameService");
		CosNaming::NamingContext_var naming_server = CosNaming::NamingContext::_narrow (naming_obj.in ());
		if (!CORBA::is_nil (naming_server)) {
			CosNaming::Name name;
			name.length (1);
			name[0].id = static_cast<const char*>("EventChannelManager");
			naming_server->rebind (name, m_event_manager.in ());
		} else {
			LOG_E (("NameService not found"));
			throw Core::Root::HomeManagerInitError();
		}
	} catch (Core::Root::HomeManagerInitError&) {
	} CATCH_LOG_AND_DO("Can't create EventChannelManager", throw Core::Root::HomeManagerInitError(););
	*/
	//#UC END# *457FC8550138*
}

// Находит и устанавливает ссылки на все необходимые CORBA-сервисы
void CorbaLibHomeManager::cos_setup () {
	//#UC START# *457FC8AC02CE*
	CosNaming::NamingContext_var root_ns;
	try {
		CORBA::Object_var obj = m_main_orb->resolve_initial_references("NameService");
		root_ns = CosNaming::NamingContext::_narrow(obj.in());
		
		std::string root_context;
		try {
			root_context = Root::ServerSettings::get_ns_context ();
		} catch (Core::ParameterIsMissing&) {
		}
		m_name_service = CoreSrv::create_path (root_ns, root_context.data());

	} catch(CORBA::Exception& ex) {
		LOG_CEX (( ex, "NameService not found" ));
		throw Core::Root::HomeManagerInitError();
	}
	
	//получаем менеджера каналов
	/*try {
		CORBA::Object_var obj = CoreSrv::resolve_path (root_ns.in (), "EventChannelManager");
		m_event_manager = EventComm::EventChannelManager::_narrow (obj.in ());
	} CATCH_LOG_AND_DO("EventChannelManager not found", throw Core::Root::HomeManagerInitError(););
	*/	
	//#UC END# *457FC8AC02CE*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Root::OrbAcsessor
// Основной ORB
CORBA::ORB& CorbaLibHomeManager::get_main_orb () const {
	//#UC START# *458115C00148_457EA15F01D0_GET*
	return *m_main_orb;
	//#UC END# *458115C00148_457EA15F01D0_GET*
}

// implemented method from Root::OrbAcsessor
// Рутовый объект контекста Name Service-а
CosNaming::NamingContext& CorbaLibHomeManager::get_ns_root () const {
	//#UC START# *458115CB0399_457EA15F01D0_GET*
	//return *m_name_service;
	if (m_name_service.ptr()) {
		return *m_name_service;
	} else {
		throw Core::Root::CachedAttrUninitialized ("CorbaLibHomeBase::name_service");
	}
	//#UC END# *458115CB0399_457EA15F01D0_GET*
}

// implemented method from Root::OrbAcsessor
// Объект текущего контекста PICurrent
PortableInterceptor::Current& CorbaLibHomeManager::get_pi_current () const {
	//#UC START# *45E54A7602DE_457EA15F01D0_GET*
	return *m_pi_current;
	//#UC END# *45E54A7602DE_457EA15F01D0_GET*
}

// implemented method from Root::OrbAcsessor
// Рутовый POA
PortableServer::POA& CorbaLibHomeManager::get_root_poa () const {
	//#UC START# *458115F00271_457EA15F01D0_GET*
	return *m_root_poa;
	//#UC END# *458115F00271_457EA15F01D0_GET*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Core::Root::LibHomeManager
// запуск фремворка на исполнение. Инициализирует все билиотеки и запускает их исполнителей.
void CorbaLibHomeManager::execute () /*throw (Core::Root::InvalidParams, Core::Root::HomeManagerInitError)*/ {
	//#UC START# *457EA04C00F5_457EA15F01D0*
	bool no_server = false;
	try {
		for (LibHomes::iterator it = this->get_lib_homes ().begin (); it != this->get_lib_homes ().end (); ++it ) {
			CorbaLibHomeLocal* clh = dynamic_cast<CorbaLibHomeLocal*> (*it);
			if (clh) {
				PortableInterceptor::ORBInitializer* init = clh->get_orb_initializer();
				if (init) {
					PortableInterceptor::register_orb_initializer (init);
				}
			}
		}
		
		Core::Aptr <Core::ParamArgs> arg_list;
		try {
			arg_list = Core::ParamManagerFactory::get ().command_line_for_orb_init ();
		} catch (Core::DataNotFound&) {
			LOG_E (("%s: ORB params not defined", GDS_CURRENT_FUNCTION));
			throw Core::Root::InvalidParams ();
		}
		
		Core::Aptr<ACE_ARGV> arg = Core::ParamConvert::make_ace_argv (*arg_list);
		
		int argc = arg->argc ();
		m_main_orb = CORBA::ORB_init (argc, arg->argv (), "MainORB");
		
				
		//настройки из GCMManager_i
		ACE_Service_Config::process_directive (
			"static Client_Strategy_Factory \""
				"-ORBConnectionHandlerCleanup false"
				" -ORBClientConnectionHandler mt_noupcall"
				" -ORBConnectStrategy blocked"
			"\""
		);

		ACE_Service_Config::process_directive (
			"static Resource_Factory \""
				"-ORBFlushingStrategy blocking"
			"\""
		);

		CORBA::Object_var obj = m_main_orb->resolve_initial_references ("RootPOA");
		m_root_poa = PortableServer::POA::_narrow (obj.in ());
		PortableServer::POAManager_var poa_manager = m_root_poa->the_POAManager ();
		m_root_poa->the_POAManager ()->activate();

		obj = m_main_orb->resolve_initial_references ("PICurrent");
		m_pi_current = PortableInterceptor::Current::_narrow (obj.in ());
		
		for (LibHomes::iterator it = this->get_lib_homes().begin(); it != this->get_lib_homes().end(); ++it) {
			CorbaLibHomeLocal* clh = dynamic_cast<CorbaLibHomeLocal*> (*it);
			if (clh) {
				clh->set_orb_facet (this);
			}
		}	

		if (!Core::ParamManagerFactory::get ().is_exist ("-ORBInitRef")) {
			this->cos_run ();
		}
		
		this->cos_setup ();

		size_t orb_pool_threads_count = Core::ParamManagerFactory::get ().get_long ("-GCMORBPoolThreads", 5);

		// увеличиваем колличество орбовых потоков на клиенте в 2 раза, если включен би-дир,
		// т.к. в этом случае сервер сам не устанавливает соединений с клиентом -
		// все соединения всегда инициируются самим клиентом и в случае использования би-дира
		// их должно быть в 2 раза больше (но это нужно делать только на клиентской стороне)
		if (Core::ParamManagerFactory::get ().get_long ("-GCMBiDirectional", 0)) {
			orb_pool_threads_count *= 2;
		}

		if (
			m_main_orb->orb_core ()->thr_mgr ()->spawn_n (
				orb_pool_threads_count
				, (ACE_THR_FUNC)CorbaLibHomeManager::orb_cycle_thread
				, m_main_orb.ptr ()
				, THR_NEW_LWP | THR_DETACHED | THR_INHERIT_SCHED
			) < 0
		) {
			LOG_E (("Cannot create threads pool for the ORB"));
			throw Core::Root::HomeManagerInitError();
		}
	} CATCH_LOG_AND_DO ("In CorbaLibHomeManager startup", no_server = true;)
	
	this->registrate_all_factories ();	

	if (no_server) {
		//Инициализируем и запускаем на выполнение ТОЛЬКО НЕ СЕРВЕРНЫЕ библиотеки:
		for (LibHomes::iterator it = this->get_lib_homes().begin(); it != this->get_lib_homes().end(); ++it) {
			if (!dynamic_cast<CorbaLibHomeLocal*> (*it)) {
				(*it)->initialize ();
			}
		}

		for (LibHomes::iterator it = this->get_lib_homes().begin(); it != this->get_lib_homes().end(); ++it) {
			if (!dynamic_cast<CorbaLibHomeLocal*> (*it)) {
				(*it)->execute ();
			}
		}

		throw Core::Root::HomeManagerInitError();
	}

	for (LibHomes::iterator it = this->get_lib_homes().begin(); it != this->get_lib_homes().end (); ++it) {
		CorbaLibHomeLocal* clh = dynamic_cast<CorbaLibHomeLocal*> (*it);
		if (clh) {
			clh->publish_all_servers_factories ();
		}
	}
	
	//запускаем инициализацию
	this->initialize_all_libhomes ();

	this->execute_all_libhomes ();

	LOG_D (("CorbaLibHomeManager completly executed"));
	//#UC END# *457EA04C00F5_457EA15F01D0*
}

// overloaded method from Core::Root::LibHomeManager
// останавливает работу фреймворка и освобождает все занятые ресурсы (особождение ресоров
// зарегистрированных библиотек осуществляется в порядке, обратном их регистрации!)
void CorbaLibHomeManager::finalize () {
	//#UC START# *4580427A009C_457EA15F01D0*
	//сначала прибиваем орбовый поток, т.к в нём используется LibHomeManager
	
	if (m_root_poa.ptr()) {
		m_root_poa->destroy(true, true);
		m_root_poa = 0;
	}

	if (m_main_orb.ptr()) {
		m_main_orb->shutdown(1);
		m_main_orb->orb_core ()->thr_mgr ()->cancel_all ();
		m_main_orb->orb_core ()->thr_mgr ()->wait ();
		m_main_orb->destroy();
		m_main_orb = 0;
	}

	//теперь можно очистить зарегистрированные LibHome
	//если возникнет необходимость при очистке ресурсов библиотеки делать удалённые вызовы -
	//нужно будеть LibHomeManager чистить отдельно!!!
	StdLibHomeManager::finalize ();
	LOG_D (("CorbaLibHomeManager completly finalized"));
	//#UC END# *4580427A009C_457EA15F01D0*
}

} // namespace Root_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

