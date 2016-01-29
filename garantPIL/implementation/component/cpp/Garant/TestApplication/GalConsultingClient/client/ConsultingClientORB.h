#ifndef _CONSULTING_CLIENT_ORB_H_
#define _CONSULTING_CLIENT_ORB_H_

#include "shared/CoreSrv/Utils/ORB.h"
#include <string>

namespace GalConsultingClient {

	class ConsultingClientORB : public CoreSrv::ORB {
public:
	CORBA::ORB_ptr get_cached_client_orb ();
	
public:
	ConsultingClientORB (const char* name, size_t threads_count, std::string proxy_config_name);

	virtual void init (int argc, char* argv[]);
	virtual void spawn_run ();
	virtual void shutdown ();
	
	void ConsultingClientORB::set_request_timeout (unsigned short seconds);

private:
	CORBA::ORB_ptr m_orb;
	static const std::string s_default_consulting_server_host;
	static const std::string s_default_consulting_server_port;

private:
	std::string m_proxy_config;
};

} // namespace GalConsultingClientClient

#endif // _CONSULTING_CLIENT_ORB_H_
