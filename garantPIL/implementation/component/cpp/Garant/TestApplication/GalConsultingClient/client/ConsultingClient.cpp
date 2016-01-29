#include "ace/ACE.h"
#include "ace/OS.h"
#include "ace/Codecs.h"


// без этого инклюда enable_request_timeout выбрасывает исключение
#include "tao/Messaging/Messaging.h"

#include "orbsvcs/HTIOP/HTIOP_Factory.h"
#include "tao/Codeset/Codeset.h"

#include "shared/CoreSrv/Utils/cos_naming_op.h"
#include "shared/Adapters/WinInet/WinInet.h"
#include "shared/CoreSrv/sys/Logs.h"

#include "ConsultingClient.h"

#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"
#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"

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

const char* GalConsultingClient::ConsultingClient::s_default_passwd = "11D4503F59CCC30903";

namespace GalConsultingClient {
	
	ProxyData::ProxyData () : use_default (true) {
		try {
			Adapters::WinInet proxy_params;
			proxy_params.get_proxy_info (this->address, this->port);
		} catch (...) {
			LOG_W (("Can't automatically get proxy params"));
		}
	}
	
	ConsultingClient::ConsultingClient () 
		: m_proxy_data ()
		, m_proxy_file ()
	{				
	}
	
	void ConsultingClient::init (int argc, char* argv []) {
		try {
			Core::ParamManagerReg::instance ();
			Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), GCL::F1::ADAPTER);
			
			static std::string empty_string;
		
			this->m_proxy_data.login = Core::ParamManagerFactory::get ().get_string (PROXY_LOGIN, empty_string.c_str ());			
			this->m_proxy_data.password = Core::ParamManagerFactory::get ().get_string (PROXY_PWD, empty_string.c_str ());
			bool use_proxy = Core::ParamManagerFactory::get ().is_exist (USE_PROXY);
			
			if (use_proxy) {
				m_proxy_file = Core::ParamManagerFactory::get ().get_string (PROXY_CONFIG_FILE, empty_string.c_str ());
				this->write_proxy_conf (m_proxy_data);				
			}
			
			m_consulting_orb = new GalConsultingClient::ConsultingClientORB ("ConsultingClientORB", 0, m_proxy_file);
			m_consulting_orb->init (0, 0);

			const long request_timeout = Core::ParamManagerFactory::get ().get_long (REQUEST_TIMEOUT, 60);
			m_consulting_orb->set_request_timeout(static_cast<unsigned short> (request_timeout));

			m_uuid_generator.init();
		} catch (...) {
			LOG_E (("Can't init ParamManager - check your configuration."));
			throw;
		}
	}


	ConsultingClient::~ConsultingClient () {
	}


	long build_random_data (char*& data, long min_size, long max_size) {
		static char ascii_symbols[] = {' ', '!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\\', ']', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}', '~', 'А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ж', 'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ы', 'Ь', 'Э', 'Ю', 'Я', 'а', 'б', 'в', 'г', 'д', 'е', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я', 'Ё', 'ё'};	
		static long ascii_symbols_size = sizeof(ascii_symbols)/sizeof(char);
        ACE_OS::srand ( static_cast<u_int>(time (0)) );		
		long size = ((ACE_OS::rand () % (long)(((max_size) + 1) - (min_size))) + (min_size));
		data = new char[size];
        for (long i = 0; i < size - 1; ++i) {				
                char value = ascii_symbols [static_cast<long> (ACE_OS::rand () % (ascii_symbols_size - 1))];
                data[i] = value;
        }
		data[size - 1] = '\0';
		return size;
	}

	const char* HTBP_SECTION_HEADER = "[htbp]";

	void ConsultingClient::write_proxy_conf (ProxyData& proxy_data) {
		if (!m_proxy_file.empty ()) {
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

	GblConsulting::ConsultingFacade77* ConsultingClient::get_consulting_facade () {

		//GalConsultingClient::ConsultingClientORB consulting_orb ("ConsultingClientORB", 0, m_proxy_file);
		//consulting_orb.init (0, 0);

		CORBA::ORB_ptr orb = m_consulting_orb->get_cached_orb();
		CosNaming::NamingContext_var context = CosNaming::NamingContext::_nil ();
		if (CORBA::is_nil (orb)) {
			LOG_E (("Can't init consulting ORB"));			
		} else {
			try {
				CORBA::Object_var obj = m_consulting_orb->get_cached_orb()->resolve_initial_references ("NameService");
				context = CosNaming::NamingContext::_narrow (obj.in ());
			} catch (CORBA::TRANSIENT&) {
				LOG_E (("Can't create connection with consulting server (CORBA::TRANSIENT)"));				
				return 0;
			} catch (CORBA::COMM_FAILURE&) {
				LOG_E (("Can't create connection with consulting server (CORBA::COMM_FAILURE)"));				
				return 0;
			} catch (CORBA::Exception& ex) {
				LOG_CEX ((ex, "ConsultingClientORB::init"));				
				return 0;
			}
		}
		if (CORBA::is_nil (context)) {
			LOG_E (("Can't get NameService!"));			
			return 0;
		} else {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (context, "GblConsulting/ConsultingFacade77");
				if (CORBA::is_nil (obj)) {
					LOG_E (("Can't use received NameService"));					
					return 0;
				}
				GblConsulting::ConsultingFacade77_var consulting_facade = GblConsulting::ConsultingFacade77::_narrow (obj.in ());
				return 	consulting_facade._retn ();	
		
			} catch (CORBA::Exception& ex) {
				LOG_CEX ((ex, "GCL::resolve_path"));				
				return 0;
			} catch (...) {
				LOG_UEX (("GCL::resolve_path"));				
				return 0;
			}
		}

		return 0;
	}


	void ConsultingClient::execute () {
		long count = Core::ParamManagerFactory::get ().get_long (ITERATION_COUNT, 1);
		long thread_count = Core::ParamManagerFactory::get ().get_long (THREAD_COUNT, 1);

		long current_iteration = 0;
		while ((current_iteration++ < count) || (count == 0)) {
			LOG_D (("Start %d iteration", current_iteration));
			//this->send_consultation ();
			ACE_Thread_Manager::instance ()->spawn_n (
				thread_count
				, (ACE_THR_FUNC) ConsultingClient::send_consultation_thread
				, static_cast<void*> (this)
			);
			ACE_Thread_Manager::instance ()->wait ();
			LOG_D (("End %d iteration", current_iteration));
		}
	}


	void* ConsultingClient::send_consultation_thread (void* arg) {
		ConsultingClient* client = reinterpret_cast<ConsultingClient*> (arg);
		GDS_ASSERT (client);
		client->send_consultation ();
		return 0;
	}


	void ConsultingClient::send_consultation () {
		const unsigned long min_packet_size = Core::ParamManagerFactory::get ().get_long (MIN_PACKET_SIZE, s_min_packet_size);
		const unsigned long max_packet_size = Core::ParamManagerFactory::get ().get_long (MAX_PACKET_SIZE, s_max_packet_size);
		const unsigned long send_delay = Core::ParamManagerFactory::get ().get_long(SEND_DELAY, 0);
		
		CORBA::String_var query;
		long packet_size = build_random_data (query.out (), min_packet_size, max_packet_size);
		
		GblConsultingDef::ConsultationID_var id = new GblConsultingDef::ConsultationID ();
		//
		ACE_Utils::UUID gen_id;
		m_uuid_generator.generateUUID (gen_id, 0x0001, 0xc0);		
		//
		id->consultation_id = gen_id.to_string ()->c_str (); //uid generator
		id->client_id.complect_id = Core::ParamManagerFactory::get ().get_long (COMPLECT_ID, ConsultingClient::s_default_complect_id);
		id->client_id.passwd = Core::ParamManagerFactory::get ().get_string (COMPLECT_PASSWD, ConsultingClient::s_default_passwd).c_str ();
		
		GblConsultingDef::ExtendedClientInfo_var extended_client_info = new GblConsultingDef::ExtendedClientInfo ();				
		
		extended_client_info->base_revision_date.year = 2006;
		extended_client_info->base_revision_date.month = 5;
		extended_client_info->base_revision_date.day = 23;

		extended_client_info->complect_name = "Test";
		extended_client_info->complect_network_type = GCD::ct_Local;
		extended_client_info->block_id_list.length (0);

		GblConsultingDef::UserInfo70_var user_info = new GblConsultingDef::UserInfo70 ();
		user_info->name = "TestUser";
		user_info->region_code = "495";
		user_info->phone_number = "322223322";
		user_info->email = "name@domain.com";


		GCD::DateTime_var date_time = new GCD::DateTime ();
		//
		__time64_t now_time;
		_time64(&now_time);
		struct tm local_now_time;
		_localtime64_s(&local_now_time, &now_time);
		//
		date_time->date_value.year = local_now_time.tm_year;
		date_time->date_value.month = local_now_time.tm_mon;
		date_time->date_value.day = local_now_time.tm_mday;
		//
		date_time->time_value.hour = local_now_time.tm_hour;
		date_time->time_value.min = local_now_time.tm_min;
		date_time->time_value.sec = local_now_time.tm_sec;


		long attempt = 0;
		GblConsulting::ConsultingFacade77_var consulting_facade;
		do {
			consulting_facade = this->get_consulting_facade ();
			if (consulting_facade.ptr () == 0) {
				LOG_E (("Can't get ConsultingFacade, attemp %d", ++attempt));
				ACE_OS::sleep (1);
			}
		} while (consulting_facade.ptr () == 0);
		bool success = false;
		attempt = 0;
		while (success != true) {
			try {				
				consulting_facade->consultation_request (id.in (), query.in (), date_time.in (), extended_client_info.in (), user_info.in ());
				success = true;
				LOG_I (("Consultation successfully sent on %d attempt", ++attempt));
			} catch (GblConsulting::DuplicateConsultationID&) {
				LOG_E (("DuplicateConsultationID, attemp %d", ++attempt));
			}catch (GblConsultingDef::NoSubscription&) {
				LOG_E (("NoSubscription, attemp %d", ++attempt));
			} catch (CORBA::Exception& ex) {
				LOG_CEX ((ex, "%s: error while sending consultation request, attempt %d", GDS_CURRENT_FUNCTION, ++attempt));			
			} catch (...) {
				LOG_UEX (("%s: error while sending consultation request, attempt %d", GDS_CURRENT_FUNCTION, ++attempt));					
			}
			// задержка
			if (send_delay != 0)
			{
				LOG_I (("Sleeping for %d s.", send_delay));
				ACE_OS::sleep(send_delay);
			}
		}
	}
	
} // namespace GalConsultingClientClient
