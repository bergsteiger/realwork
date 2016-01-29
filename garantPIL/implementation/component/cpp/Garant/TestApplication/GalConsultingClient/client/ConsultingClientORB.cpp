
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"

#include <stdexcept>

#include "tao/BiDir_GIOP/BiDirGIOP.h"
#include "orbsvcs/Naming/Naming_Server.h"
#include "orbsvcs/HTIOP/HTIOP_Factory.h"

#include "garantServer/src/Global/Defines/DefinesC.h" 
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "shared/CoreSrv/sys/Logs.h"

#include "ConsultingClientORB.h"

#if !defined (ACE_WIN32) || (defined (ACE_WIN32) && defined (ACE_AS_STATIC_LIBS))
ACE_STATIC_SVC_REQUIRE (TAO_HTIOP_Protocol_Factory);
ACE_STATIC_SVC_DECLARE (TAO_HTIOP_Protocol_Factory);
#endif

namespace GalConsultingClient {

const std::string ConsultingClientORB::s_default_consulting_server_host = "zzz.garant.ru";
const std::string ConsultingClientORB::s_default_consulting_server_port = "80";

ConsultingClientORB::ConsultingClientORB (const char* name, size_t threads_count, std::string proxy_config_name)
	: ORB (name, threads_count), m_proxy_config (proxy_config_name), m_orb (0) {
}

CORBA::ORB_ptr ConsultingClientORB::get_cached_client_orb () {
	GDS_ASSERT (m_orb || !"Try to use uninitialized Consulting Checker ORB");
	return m_orb;
}

void ConsultingClientORB::init (int argc, char* argv[]) {
	// Creating fake orb for register HTIOP factory.
	int fake_arg = 1;
	char* fake_argv[] = {"1", 0};
	CORBA::ORB_var fake_orb = CORBA::ORB_init (fake_arg, fake_argv, "FakeORB");

	try {
		ACE_Service_Config::process_directive (
			"static Resource_Factory \""
				"-ORBProtocolFactory HTIOP_Factory"
			"\""
		);	
		
		std::string HTIOP_Factory_directive;
		if (!m_proxy_config.empty ()) {
			HTIOP_Factory_directive =  "static HTIOP_Factory \"-inside 1 -config '" + m_proxy_config + "'\"";
		} else {
			HTIOP_Factory_directive =  "static HTIOP_Factory \"-inside 1\"";
		}
		ACE_Service_Config::process_directive (HTIOP_Factory_directive.c_str ());

		std::string server_address = Core::ParamManagerFactory::get ().get_string (
			Defines::PS_SYS_CONSULTING_SERVER_ADDRESS
			, ConsultingClientORB::s_default_consulting_server_host.c_str ()
		);
		
		if (server_address.empty ()) {
			throw std::logic_error ("Consulting client configuration FAILED: consulting server address not specified.");
		}
		
		std::string server_port = Core::ParamManagerFactory::get ().get_string (
			Defines::PS_SYS_CONSULTING_SERVER_PORT
			, ConsultingClientORB::s_default_consulting_server_port.c_str ()
		);
		
		std::string orb_init_ref = "NameService=corbaloc:htiop:1.2@" + server_address + ":" + server_port + "/NameService";
		Core::Aptr<char, Core::ArrayDeleteDestructor <char> > sz_orb_init_ref (new char [orb_init_ref.size () + 1]);
		strcpy (sz_orb_init_ref.ptr (), orb_init_ref.c_str ());
		
		std::string log_file = Core::ParamManagerFactory::get ().get_string ("-ORBLogFile", "");
		std::string debug_level = Core::ParamManagerFactory::get ().get_string ("-ORBDebugLevel", "1");
		if ("false" == Core::ParamManagerFactory::get ().get_string ("-GCMEnforceRemoteConnection", "true")) {			

			char* argv_ [] = {
				"-ORBDottedDecimalAddresses", "1"
				, "-ORBUseSharedProfiles", "1"
				, "-ORBInitRef", sz_orb_init_ref.in ()
				, "-ORBDebugLevel", const_cast<char *> (debug_level.c_str ())
				, "-ORBLogFile", const_cast<char *> (log_file.c_str ())
				, 0
			};		
			int argc_ = 10;
			CoreSrv::ORB::init (argc_, argv_);
		} else {
			Core::Aptr<char, Core::ArrayDeleteDestructor <char> > sz_server_address (new char [server_address.size () + 1]);
			strcpy (sz_server_address.ptr (), server_address.c_str ());
			Core::Aptr<char, Core::ArrayDeleteDestructor <char> > sz_server_port (new char [server_port.size () + 1]);
			strcpy (sz_server_port.ptr (), server_port.c_str ());
			char* argv_ [] = {
				"-ORBDottedDecimalAddresses", "1"
				, "-ORBUseSharedProfiles", "1"
				, "-ORBInitRef", sz_orb_init_ref.in ()
				, "-ORBEnforceRemoteConnectionHostTo", sz_server_address.in ()
				, "-ORBEnforceRemoteConnectionPortTo", sz_server_port.in ()
				, "-ORBDebugLevel", const_cast<char *> (debug_level.c_str ())
				, "-ORBLogFile", const_cast<char *> (log_file.c_str ())
				, 0
			};		
			int argc_ = 14;
			CoreSrv::ORB::init (argc_, argv_);

			ACE_Service_Config::process_directive (
				"static Client_Strategy_Factory \""
				"-ORBClientConnectionHandler mt_noupcall"
				" -ORBConnectionHandlerCleanup false"
				" -ORBConnectStrategy blocked"
			"\""
			);

			ACE_Service_Config::process_directive (
				"static Resource_Factory \""
				"-ORBFlushingStrategy blocking"
				"\""
			);
		}
		CoreSrv::ORB::enable_bidir (this->get_cached_orb ());

		m_orb = this->get_cached_orb ();
	} catch (std::exception& ex) {
		LOG_SEX ((ex, "%s", GDS_CURRENT_FUNCTION));
	} catch (CORBA::Exception& ex) {
		LOG_CEX ((ex, "%s", GDS_CURRENT_FUNCTION));
	}
}

void ConsultingClientORB::set_request_timeout (unsigned short seconds) {
	GDS_ASSERT (m_orb || !"ConsultingClientORB should be initialized before setting timeout");
	CoreSrv::ORB::enable_request_timeout (this->get_cached_orb (), seconds);
}

void ConsultingClientORB::spawn_run () {
	GDS_ASSERT (false || !"ConsultingClientORB::spawn_run not released!");
}

void ConsultingClientORB::shutdown () {
	GDS_ASSERT (false || !"ConsultingClientORB::shutdown not released!");
}

} // namespace GalConsultingClientClient 

