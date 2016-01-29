#ifndef _CONSULTING_CHECK_UP_H_
#define _CONSULTING_CHECK_UP_H_

#include "shared/Core/sys/std_inc.h"

#include "ace/UUID.h"

#include "garantServer/src/Business/GblConsulting/Home/Client.h"
#include "ConsultingCheckUpORB.h"

#include <string>
#include <vector>
#include <exception>

static const char* PROXY_LOGIN = "-ProxyLogin";
static const char* PROXY_PWD = "-ProxyPassword";
static const char* USE_PROXY = "-UseProxy";
static const char* PROXY_CONFIG_FILE = "-ProxyConfigFile";
static const char* CHECK_TIMEOUT = "-CheckTimeout";
static const char* EMAIL_WHO= "-EMailWho";
static const char* BAD_ATTEMPTS_BETWEEN_MAIL = "-BadAttemptsCountBetweenMail";
static const char* BAD_ATTEMPTS_BEFORE_MAIL = "-BadAttemptsCountBeforeMail";


namespace GalConsultingCheckUp {
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

	class ConsultingCheckUp {
		SET_OBJECT_COUNTER(ConsultingCheckUp)
	public:
		ConsultingCheckUp ();
		void init (int argc, char* argv []) /*throw (Core::DataNotFound, Core::DataNotCorrect)*/;
		void execute ();
		bool test_availability ();		
		void write_proxy_conf (ProxyData& proxy_data);
		void send_warning_mail (std::string& body_hello);
		~ConsultingCheckUp ();

	private:
		ProxyData m_proxy_data;
		std::string m_ini_file;	
		std::string m_proxy_file;
		CORBA::ORB_var m_fake_orb;
	};
} // namespace GalConsultingCheckUp
#endif // _CONSULTING_CHECK_UP_H_