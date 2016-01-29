////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Utils/ORB.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::CoreSrv::Utils::ORB
//
// обертка над CORBA::ORB предоставляющая функции управления дополнительными свойствами ОРБа
// (БиДир, ПулПотоков, РТ-расширения)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Utils/ORB.h"

//#UC START# *4503D75003D8_CUSTOM_INCLUDES*
#include "tao/BiDir_GIOP/BiDirGIOP.h"
#include "tao/Messaging/Messaging_RT_PolicyC.h"
#include "tao/PortableServer/POAManagerC.h"
//#UC END# *4503D75003D8_CUSTOM_INCLUDES*

namespace CoreSrv {

//#UC START# *4503D75003D8*
CORBA::ORB_ptr ORB::get_cached_orb () const {
	GDS_ASSERT (!CORBA::is_nil (m_orb.in ()));
	return m_orb.ptr ();
}

const char* ORB::name () const {
	return m_name.c_str ();
}

size_t ORB::threads_count () const {
	return m_threads_count;
}

namespace {

ACE_THR_FUNC_RETURN run_orb_proc (void *arg) {
	try {
		mpcxc_set_se_handler ();
		
		CORBA::ORB_var orb = CORBA::ORB::_duplicate (
			static_cast <CORBA::ORB_ptr> (arg)
		);
		CORBA::String_var orb_id = orb->id ();

		GDS_ASSERT (!CORBA::is_nil (orb.in ()));

		LOG_D (("Now making run of the ORB [%s]", orb_id.in ()));
		{
			orb->run ();
		}
		LOG_D (("Run of the ORB [%s] completed", orb_id.in ()));
	} catch (...) {
		LOG_D (("Unknown exception inside GCL::run_orb_proc"));
	}
	
	return (ACE_THR_FUNC_RETURN)0;
}

} // namespace

void ORB::enable_request_timeout (CORBA::ORB_ptr orb, unsigned short seconds) {
	// why 10e7 not 10e6 or 10e9? I don't know :)
	TimeBase::TimeT relative_rt_timeout = seconds * 10000000;
	CORBA::Any relative_rt_timeout_as_any;
	relative_rt_timeout_as_any <<= relative_rt_timeout;

	CORBA::PolicyList policy_list;
	policy_list.length ( 1);
	policy_list[0] = orb->create_policy (
		Messaging::RELATIVE_RT_TIMEOUT_POLICY_TYPE
		, relative_rt_timeout_as_any
	);

	CORBA::Object_var obj = orb->resolve_initial_references ("ORBPolicyManager");
	CORBA::PolicyManager_var policy_manager = CORBA::PolicyManager::_narrow (obj.in ());
	policy_manager->set_policy_overrides (policy_list, CORBA::SET_OVERRIDE);

	for (CORBA::ULong i = 0; i < policy_list.length (); ++i) {
		policy_list[i]->destroy ();
	}
}

ORB::ORB (const char* name, size_t threads_count)
	: m_name (name), m_threads_count (threads_count) {
}

void ORB::init (int argc, char* argv []) {
	LOG_D (("Now making initialization of the ORB [%s]", m_name.c_str ()));
	{
		m_orb = CORBA::ORB_init (argc, argv, m_name.c_str ());
		CORBA::Object_var obj = m_orb->resolve_initial_references ("RootPOA");
		m_root_poa = PortableServer::POA::_narrow (obj.in ());
		PortableServer::POAManager_var poa_manager = m_root_poa->the_POAManager ();
		poa_manager->activate ();
	}
	LOG_D (("Initialization of the ORB [%s] completed", m_name.c_str ()));
 }

void ORB::run () {
	GDS_ASSERT (!CORBA::is_nil (m_orb.in ()));

	m_orb->run ();
}

void ORB::spawn_run () {
	GDS_ASSERT (!CORBA::is_nil (m_orb.in ()) && (m_threads_count > 0));

	if (
		m_orb->orb_core ()->thr_mgr ()->spawn_n (
			m_threads_count
			, run_orb_proc
			, m_orb.ptr ()
			, THR_NEW_LWP | THR_DETACHED | THR_INHERIT_SCHED
		) < 0
	) {
		CORBA::String_var orb_id = m_orb->id ();
		LOG_F (("Cannot create threads for the ORB [%s]", orb_id.in ()));
	}
}

void ORB::shutdown () {
	if (!CORBA::is_nil (m_orb.in ())) {
		CORBA::String_var orb_id = m_orb->id ();

		LOG_D (("Now making shutdown of the ORB [%s]", orb_id.in ()));
		{
			m_orb->shutdown (1);
		}
		LOG_D (("Shutdown of the ORB [%s] completed", orb_id.in ()));

		m_orb = CORBA::ORB::_nil (); // release ORB
	}
}
//#UC END# *4503D75003D8*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// включает режим bi-dir
void ORB::enable_bidir (CORBA::ORB* orb) {
	//#UC START# *4503D86D0290*
	CORBA::Object_var object = orb->resolve_initial_references ("RootPOA");

	PortableServer::POA_var root_poa = PortableServer::POA::_narrow (object.in ());
	PortableServer::POAManager_var poa_manager = root_poa->the_POAManager ();

	// Policies for the childPOA to be created.
	CORBA::PolicyList policies (1);
	policies.length (1);

	CORBA::Any pol;
	pol <<= BiDirPolicy::BOTH;
	policies [0] = orb->create_policy (BiDirPolicy::BIDIRECTIONAL_POLICY_TYPE, pol);

	// Create POA as child of RootPOA with the above policies.  This POA
	// will receive request in the same connection in which it sent
	// the request
	try {
		PortableServer::POA_var child_poa = root_poa->create_POA ("BiDirectionalPOA", poa_manager, policies);

		CORBA::String_var orb_id = orb->id ();
		LOG_I (("CoreSrv::ORB::enable_bidir: BiDirectional GIOP is enabled for the ORB [%s].", orb_id.in ()));
	} catch (PortableServer::POA::AdapterAlreadyExists&) {
	}
	// Creation of childPOA is over. Destroy the Policy objects.
	for (CORBA::ULong i = 0; i < policies.length (); ++i) {
		policies [i]->destroy ();
	}
	//#UC END# *4503D86D0290*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ORB::~ORB () {
	//#UC START# *4503D75003D8_DESTR_BODY*
	// TODO check is m_orb shutdowned
	GDS_ASSERT ("ORB MUST be shutdown"); // TODO inverse assert condition :)
	//#UC END# *4503D75003D8_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает закешированную ссылку на рутовый POA
PortableServer::POA* ORB::get_cached_root_poa () const {
	//#UC START# *4503D93502EE*
	GDS_ASSERT (!CORBA::is_nil (m_root_poa.in ()));
	return m_root_poa.ptr ();
	//#UC END# *4503D93502EE*
}

} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

