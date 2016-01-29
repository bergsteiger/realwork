#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/str/str_op.h"
#include "ace/ACE.h"
#include "ace/OS.h"
#include "ace/Codecs.h"

#include "orbsvcs/HTIOP/HTIOP_Factory.h"
#include "tao/Codeset/Codeset.h"

// Этот заголовок нужен для инициализации механизмов TAO
// см. http://mdp.garant.ru/x/y4Z5Bw
#include "tao/Messaging/Messaging.h"

#include "shared/CoreSrv/Utils/cos_naming_op.h"
#include "shared/GCL/network/smtp_service.h"
#include "shared/Adapters/WinInet/WinInet.h"
#include "shared/CoreSrv/sys/Logs.h"

#include "ConsultingCheckUp.h"

#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"

#include "boost/lexical_cast.hpp"
#include <conio.h>
#include <fstream>
#include <memory>
#include <sstream>

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

//INIT_ORDER_BEGIN
//	INIT_OBJECT_COUNTER
//INIT_ORDER_END

ACE_STATIC_SVC_REQUIRE (TAO_HTIOP_Protocol_Factory);
ACE_STATIC_SVC_DECLARE (TAO_HTIOP_Protocol_Factory);

namespace GalConsultingCheckUp {

	ProxyData::ProxyData () : use_default (true) {
		try {
			Adapters::WinInet proxy_params;
			proxy_params.get_proxy_info (this->address, this->port);
		} catch (...) {
			LOG_W (("Can't automatically get proxy params"));
		}
	}
	
	ConsultingCheckUp::ConsultingCheckUp () 
		: m_proxy_data ()
		, m_ini_file ()
		, m_proxy_file ()
	{				
	}
	
	void open_log_stream (const char* log_file) {
		ofstream* output_stream = new ofstream ();
		output_stream->open (log_file, ios::out | ios::app);
		if (!output_stream->bad ()) {
			ACE_LOG_MSG->msg_ostream (output_stream, 1);
		} else {
			delete output_stream;
		}
		ACE_LOG_MSG->clr_flags (ACE_Log_Msg::STDERR | ACE_Log_Msg::LOGGER);
		ACE_LOG_MSG->set_flags (ACE_Log_Msg::OSTREAM);
	}

	void ConsultingCheckUp::init (int argc, char* argv []) {
		try {
			Core::ParamManagerReg::instance ();

			Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), GCL::F1::ADAPTER);						
			if (false == Core::ParamManagerFactory::get ().is_exist ("-ORBDebugLevel")) {
				Core::ParamManagerFactory::get ().set_long ("-ORBDebugLevel", 0);
			}
			if (Core::ParamManagerFactory::get ().is_exist("-ORBLogFile")) {
				open_log_stream (
					Core::ParamManagerFactory::get ().get_string ("-ORBLogFile").c_str ()
				);
			}
			static std::string empty_string;
			this->m_proxy_data.login = Core::ParamManagerFactory::get ().get_string (PROXY_LOGIN, empty_string.c_str ());			
			this->m_proxy_data.password = Core::ParamManagerFactory::get ().get_string (PROXY_PWD, empty_string.c_str ());
			bool use_proxy = Core::ParamManagerFactory::get ().is_exist (USE_PROXY);

			if (use_proxy) {
				m_proxy_file = Core::ParamManagerFactory::get ().get_string (PROXY_CONFIG_FILE, empty_string.c_str ());
				this->write_proxy_conf (m_proxy_data);				
			}						
		} catch (...) {
			LOG_E (("Can't init ParamManager - check your configuration."));
			throw;
		}
	}
	ConsultingCheckUp::~ConsultingCheckUp () {
	}


	void ConsultingCheckUp::write_proxy_conf (ProxyData& proxy_data) {
		if (!m_proxy_file.empty ()) {
			const char* HTBP_SECTION_HEADER = "[htbp]";
			std::ofstream config_file (m_proxy_file.c_str (), std::ios_base::trunc);
			// Write proxy params
			config_file << std::endl;
			config_file << HTBP_SECTION_HEADER << std::endl;
			config_file << "proxy_port=" << proxy_data.port << std::endl;
			config_file << "proxy_host=" << proxy_data.address << std::endl;

			if (proxy_data.login.size () && proxy_data.password.size ()) {
				size_t encoded_length = 0;
				std::string string_for_encoding (proxy_data.login + ":" + proxy_data.password);
				Core::Aptr <ACE_Byte,  Core::ArrayDeleteDestructor<ACE_Byte> > encoded_buffer (
					ACE_Base64::encode (
						reinterpret_cast<const ACE_Byte*> (string_for_encoding.c_str ())
						, string_for_encoding.size ()
						, &encoded_length
					)
				);
				std::string encoded_data (reinterpret_cast<const char*> (encoded_buffer.in ()), encoded_length);
				config_file << "proxy_auth=" << encoded_data << std::endl;
			}

			config_file.close ();
		}
	}

	bool ConsultingCheckUp::test_availability () {
		const char* OPTION_WAIT_TIMEOUT = "-WaitTimeout";
		const unsigned short MAX_REQUEST_TIMEOUT = 30;

		GalConsultingCheckUp::ConsultingCheckUpORB consulting_orb ("ConsultingCheckUpORB", 0, m_proxy_file);

		try {
			consulting_orb.init (0, 0);
		} catch (...) {
			LOG_E (("Can't init orb. Maybe program started on old Windows without net."));
			return false;
		}

		long timeout = Core::ParamManagerFactory::get ().get_long (OPTION_WAIT_TIMEOUT, MAX_REQUEST_TIMEOUT);
		consulting_orb.set_request_timeout (static_cast<unsigned short> (timeout));

		CORBA::ORB_ptr orb = consulting_orb.get_cached_orb();
		CosNaming::NamingContext_var context = CosNaming::NamingContext::_nil ();
		if (CORBA::is_nil (orb)) {
			LOG_E (("Can't init consulting ORB"));
			return false;
		} else {
			try {
				CORBA::Object_var obj = orb->resolve_initial_references ("NameService");
				context = CosNaming::NamingContext::_narrow (obj.in ());
			} catch (CORBA::TRANSIENT&) {
				LOG_E (("Can't create connection with consulting server (CORBA::TRANSIENT)"));
				return false;
			} catch (CORBA::COMM_FAILURE&) {
				LOG_E (("Can't create connection with consulting server (CORBA::COMM_FAILURE)"));
				return false;
			} catch (CORBA::TIMEOUT&) {
				LOG_E (("Can't create connection with consulting server - timeout expired"));
				return false;
			} catch (CORBA::Exception& ex) {
				LOG_CEX ((ex, "ConsultingCheckerORB::init"));
				return false;
			}
		}
		if (CORBA::is_nil (context)) {
			LOG_E (("Can't get NameService!"));
			return false;
		} else {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (context, "GblConsulting/ConsultingFacade77");
				if (CORBA::is_nil (obj)) {
					LOG_E (("Can't use received NameService"));
					return false;
				}
			} catch (CORBA::Exception& ex) {
				LOG_CEX ((ex, "GCL::resolve_path"));
				return false;
			} catch (...) {
				LOG_UEX (("GCL::resolve_path"));
				return false;
			}
		}

		return true;
	}
	
	int test_thread_starter (void* arg) {
		ConsultingCheckUp* object = static_cast<ConsultingCheckUp*> (arg);
		GDS_ASSERT (object);
		const unsigned long check_timeout = Core::ParamManagerFactory::get ().get_long (CHECK_TIMEOUT, 60);
		const unsigned long bad_attempts_count_between_mail = Core::ParamManagerFactory::get ().get_long (BAD_ATTEMPTS_BETWEEN_MAIL, 1);
		const unsigned long bad_attempts_count_before_mail = Core::ParamManagerFactory::get ().get_long (BAD_ATTEMPTS_BEFORE_MAIL, 1);
		unsigned long failed_attempt = 0;
		bool is_first_mail_sent = false;
		while (true) {
			LOG_I (("Start checking consulting server"));
			if (object->test_availability () == false) {
				++failed_attempt; //увеличиваем счетчик неудачных попыток
				if ((failed_attempt >= bad_attempts_count_before_mail)
					&& (((failed_attempt % bad_attempts_count_between_mail) == 0) || ((failed_attempt == bad_attempts_count_before_mail) && (!is_first_mail_sent) ) ) )
				{
					if (!is_first_mail_sent)
					{
						is_first_mail_sent = true;
						--failed_attempt;
					}
					std::string body_hello ("Срочно необходимо проверить сервер консультаций по адресу:\n\n");					
					body_hello += "\n";
					body_hello += "Попытка N";
					body_hello += boost::lexical_cast<std::string> (failed_attempt);

					bool has_sent = false;
					const char *err_msg = "Exception while sending e-mail! Possible network troubles.";
					try {
						object->send_warning_mail (body_hello);
						has_sent = true;
					} catch (std::exception& ex) {
						LOG_SEX ((ex, err_msg));
					} catch(...) {
						LOG_UEX ((err_msg));
					}
					//
					if (!has_sent)
					{
						LOG_E(("E-Mail has not been sent. Failed attempts counter has been reset."));
						failed_attempt = 0;
						is_first_mail_sent = false;
					}
				}
			} else {
				failed_attempt = 0;
				is_first_mail_sent = false;
				LOG_I (("Consulting server available"));
			}
			const unsigned long sleep_quant = 10;
			const long count_sleep = check_timeout/sleep_quant;
			for (long i = 1; i <= count_sleep; i++) {
				if (ACE_Thread_Manager::instance ()->testcancel (ACE_Thread::self ()) != 0) {
					LOG_I (("Thread was canceled"));
					return 1;
				}
				ACE_OS::sleep (sleep_quant);
			}
		}
		return 0;
	}

	static volatile bool g_is_terminate = false;

	static BOOL WINAPI ConsoleHandler (DWORD ctrlType) 
	{		
		ACE_TCHAR *str_signal;
		switch (ctrlType)
		{
			case CTRL_C_EVENT :
				str_signal = ACE_TEXT("CTRL_C_EVENT");
				break;
			case CTRL_BREAK_EVENT :	
				str_signal = ACE_TEXT("CTRL_BREAK_EVENT");
				break;
			case CTRL_CLOSE_EVENT :
				str_signal = ACE_TEXT("CTRL_CLOSE_EVENT");
				break;
			case CTRL_LOGOFF_EVENT :
				str_signal = ACE_TEXT("CTRL_LOGOFF_EVENT");
				break;
			case CTRL_SHUTDOWN_EVENT :
				str_signal = ACE_TEXT("CTRL_SHUTDOWN_EVENT");
				break;
			default:
				str_signal = ACE_TEXT("UNKNOWN");
		}

		LOG_I(("Signal %s has received.", str_signal));
		g_is_terminate = true;
	
		return true;
	}

	void ConsultingCheckUp::execute () {	
		ACE_thread_t work_thread;
		if (ACE_Thread_Manager::instance ()->spawn (
			(ACE_THR_FUNC) test_thread_starter
			, static_cast<void*> (this)
			, THR_NEW_LWP | THR_JOINABLE
			, &work_thread
		) == -1) {
			LOG_E (("Can't create thread"));
			return;
		}

		SetConsoleCtrlHandler(&ConsoleHandler, BOOL(true));
		while (!g_is_terminate) {									
			ACE_OS::sleep (1);
		}
		LOG_I(("Now exit..."));

		ACE_Thread_Manager::instance ()->cancel (work_thread);
		ACE_Thread_Manager::instance ()->wait ();			
	}

	void ConsultingCheckUp::send_warning_mail (std::string& body_hello) {
		const std::string consulting_server_address = Core::ParamManagerFactory::get ().get_string (Defines::PS_SYS_CONSULTING_SERVER_ADDRESS);
		body_hello += "\n";
		body_hello += consulting_server_address;

		std::string data_from ("Проверка доступности сервера консультаций ");
		std::string body_subject ("Система ГАРАНТ: необходимо проверить доступность сервера консультаций: ");
		body_subject += consulting_server_address;
				
		const std::string who_mail = Core::ParamManagerFactory::get ().get_string (EMAIL_WHO);
		const std::string admin_mail ("auto_reply@garant.ru");

		std::string smtp_server_str = Core::ParamManagerFactory::get ().get_string (Defines::PC_SYS_SMTP_SERVER);
		if (true == smtp_server_str.empty ()) {
			throw std::logic_error ("Smtp server address not define");
		}

		if (false == Core::ParamManagerFactory::get ().is_exist (Defines::PC_SYS_SMTP_SERVER_PORT)) {
			LOG_W (("Port for smtp server not defined. Using default value: 25"));
		}
		unsigned short port = static_cast<unsigned short> (Core::ParamManagerFactory::get ().get_long (Defines::PC_SYS_SMTP_SERVER_PORT, 25));
		LOG_I (("Using smtp server: %s:%d", smtp_server_str.c_str (), port));
		
		GCL::SMTPServer server(smtp_server_str, port);		
		//GCL::StrVector who_mail_vec = GCL::split_string_by (who_mail.c_str (), ';');	
		if (who_mail.size () > 0) {
			//std::string rcpt_to (who_mail);
			GCL::SMTPMessage message (admin_mail, who_mail);
			
			message.data_from (admin_mail);
			message.data_to (who_mail);
			message.data (body_hello);
			message.subject (body_subject);
			
			server.send_message (message);

			LOG_D (("Sent: %s", message.data ().c_str ()));
		} else {
			LOG_E (("Can't send mail, because %s parametr incorrect", EMAIL_WHO));
		}
		
	}

} // namespace GalConsultingCheckUp
