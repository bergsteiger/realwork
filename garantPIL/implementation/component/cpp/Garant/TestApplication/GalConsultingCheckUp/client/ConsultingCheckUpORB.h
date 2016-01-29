#ifndef _CONSULTING_CHECK_UP_ORB_H_
#define _CONSULTING_CHECK_UP_ORB_H_

#include "shared/CoreSrv/Utils/ORB.h"
#include <string>

namespace GalConsultingCheckUp {

class ConsultingCheckUpORB : virtual public CoreSrv::ORB {
public:
	CORBA::ORB_ptr get_cached_client_orb ();
	
public:
	ConsultingCheckUpORB (const char* name, size_t threads_count, std::string proxy_config_name);

	virtual void init (int argc, char* argv[]);
	virtual void spawn_run ();

public:
	void set_request_timeout (unsigned short seconds);

private:
	virtual void shutdown ();

private:
	CORBA::ORB_ptr m_orb;
	static const std::string s_default_consulting_server_host;
	static const std::string s_default_consulting_server_port;

private:
	std::string m_proxy_config;
	bool m_shutdowned;
};

} // namespace GalGalConsultingCheckUp

#endif // _CONSULTING_CHECK_UP_ORB_H_
