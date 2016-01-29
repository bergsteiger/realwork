#ifndef _CONSULTING_CLIENT_H_
#define _CONSULTING_CLIENT_H_

#include "shared/Core/sys/std_inc.h"

#include "ace/UUID.h"

#include "garantServer/src/Business/GblConsulting/Home/Client.h"
#include "ConsultingClientORB.h"

#include <string>
#include <vector>
#include <exception>

static const char* PROXY_LOGIN = "-ProxyLogin";
static const char* PROXY_PWD = "-ProxyPWD";
static const char* USE_PROXY = "-ProxyUseDefault";
static const char* PROXY_CONFIG_FILE = "-ProxyConfigFile";

static const char* MAX_PACKET_SIZE = "-MaxPacketSize";
static const char* MIN_PACKET_SIZE = "-MinPacketSize";

static const char* ITERATION_COUNT = "-IterationCount";

static const char* COMPLECT_ID = "-ComplectID";
static const char* COMPLECT_PASSWD = "-ComplectPasswd";

static const char* SEND_DELAY = "-SendDelay";

static const char* THREAD_COUNT = "-ThreadCount";

static const char* REQUEST_TIMEOUT = "-RequestTimeout";

static const unsigned long s_min_packet_size = 10;
static const unsigned long s_max_packet_size = 100;



namespace GalConsultingClient {
	struct ProxyData {
		bool use_default;

		std::string address;
		unsigned short port;
		std::string login;
		std::string password;

		// TODO: right behaviour  if wininet throws exception
		ProxyData ();
	};
	
	class InvalidParam : public std::exception {
	public:
		InvalidParam () {
		}
		
		virtual const char* what () {
			return "Can't init ParamManager - check your configuration";
		}
	};

	class ConsultingClient {
		SET_OBJECT_COUNTER(ConsultingClient)
	public:
		ConsultingClient ();
		void init (int argc, char* argv []) /*throw (Core::DataNotFound, Core::DataNotCorrect)*/;
		void execute ();
		void send_consultation ();
	
		GblConsulting::ConsultingFacade77* get_consulting_facade ();
		void write_proxy_conf (ProxyData& proxy_data);

		~ConsultingClient ();

	public:
		static void* send_consultation_thread (void* arg);
		static const long s_default_complect_id = 402;
		static const char* s_default_passwd; 
	private:
		ProxyData m_proxy_data;		
		std::string m_proxy_file;
		ACE_Utils::UUID_Generator m_uuid_generator;

		::Core::Aptr<GalConsultingClient::ConsultingClientORB> m_consulting_orb;
	};
} // namespace GalConsultingClientClient
#endif // _CONSULTING_CLIENT_H_