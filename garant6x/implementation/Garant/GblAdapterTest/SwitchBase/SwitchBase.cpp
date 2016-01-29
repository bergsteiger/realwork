#include "ace/ACE.h"
#include "ace/Service_Config.h"
#include "ace/Thread_Manager.h"

#include "SwitchBase.h"

#include "Global/Core/Common/AutoIPConfig.h"

#if defined (_GCD_CLIENT)
#include "utils/os/ParamManager.h"
#include "shared/Core/GDS/ObjectCounter.h"
INIT_OBJECT_COUNTER
#endif

#include <conio.h>
#include <string.h>
#include <fstream>

#if defined (_GCD_CLIENT) || defined (PILOT)
BaseSwitcher :: BaseSwitcher() : m_logged(false) {
		_login = "";
		_pass = "";
		GCMServerBase::register_receptacles (Defines::FN_BASE_SWITCH);
        GCMServerBase::register_receptacles (Defines::FN_USER_MANAGER);        
}

void BaseSwitcher :: terminate_exit () {
        this->logout_current ();
        status (GCM::cs_exit_requested);
}

void BaseSwitcher::execute () {
#if defined (_GCD_CLIENT) || defined (PILOT)
	bool switch_result = false;
	try {
			CORBA::Object_var um_obj = provide (Defines::FN_USER_MANAGER);
			um = GslUserManager::UserManager::_narrow (um_obj.in ());
			if ((um->get_rest_trial_days_count () >= 0) && (um->get_protection_error () == 0)) {
				std::string msg = "Обновление информационного банка в ознакомительной версии невозможно.";
				status (GCM::cs_exit_requested);
				LOG_E (("%s", msg.c_str ()));
				return;
			}
			this->um->login (this->_login.c_str (), this->_pass.c_str ());			
			m_logged = true;			

			CORBA::Object_var bs_obj = provide (Defines::FN_BASE_SWITCH);
			bs = GblPilot::BaseSwitch::_narrow (bs_obj.in ());		
			try {
				this->bs->switch_start ();	
				switch_result = true;
			} catch(GCD::NoDatastore&) {				
				this->logout_current();
				status (GCM::cs_exit_requested);
			}
		} catch(GslUserManager::LoginFailed&) {
			this->logout_current ();
			LOG_E (("LoginFailed"));
			
		} catch(GslUserManager::LoginDuplicate&) {
			this->logout_current ();
			LOG_E (("LoginDuplicate"));
			
		} catch(GslUserManager::LoginBlocked&) {
			this->logout_current ();
			LOG_E (("LoginBlocked"));
			
		} catch(GslUserManager::NoMoreConnections&) {
			this->logout_current ();
			LOG_E (("NoMoreConnections"));
			
		} catch(CORBA::TRANSIENT&) {
			this->logout_current ();
			LOG_E (("CORBA::TRANSIENT"));
			
		} catch(CORBA::Exception& ex) {
			this->logout_current ();
			LOG_E (("CORBA::Exception [%s]", ex._rep_id ()));
			
		} catch(...) {			
			this->logout_current ();
			LOG_E (("Unknown exception"));			
		}	    
	try {
		if (switch_result) {
			this->bs->switch_complete();
		}
	} catch (GblPilot::UpdateFailed&) {
		LOG_E (("GblPilot::UpdateFailed"));
	} catch(GCD::InvalidDatastoreKey&) {
		LOG_E (("GCD::InvalidDatastoreKey"));
	} catch(CORBA::TRANSIENT&) {
		LOG_E (("CORBA::TRANSIENT"));
	} catch(CORBA::Exception& ex) {
		LOG_E (("CORBA::Exception [%s]", ex._rep_id ()));
	} catch(...) {
		LOG_E (("Unknown exception"));
	}
#endif
	terminate_exit();
}

void BaseSwitcher::logout_current () {
	if (m_logged) {
		try {
			this->um->logout_current ();
		} catch(...){
		}
		m_logged = false;
	}
}

#endif
struct AceAutoInit {
	AceAutoInit () {
		ACE::init ();
	}
	~AceAutoInit () {
		ACE::fini ();
	}
} s_ace_init;

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

int main(int argc, char* argv[]) {		
	#if defined (_GCD_CLIENT) || defined (PILOT)
	try {
		Core::ParamManager::instance ()->init (argv, argc, GCL::F1::DATA_SETUP);
		if (Core::ParamManager::instance ()->is_exist("-log")) {
			open_log_stream (
				Core::ParamManager::instance ()->get_string ("-log").c_str ()
			);
		}
		GCM::GCMManager_ptr theManager = GCM::GCM_get_manager();
		BaseSwitcher *switcher= new BaseSwitcher();
		switcher->_login = Core::ParamManager::instance ()->get_string ("-login").c_str ();
		switcher->_pass = Core::ParamManager::instance ()->get_string ("-pass").c_str ();

		theManager->register_component(new GblPilot::PilotClientHome());
		theManager->register_component(new GslUserManager::UserManagerClientHome());
#if defined (_GCD_CLIENT)
        theManager->register_local_component(new GslSessionHandlerClientServer::SessionHandlerClientServerHome);
#endif
		theManager->register_component(new GslSecurity::SecurityClientHome());
		theManager->register_local_component(switcher);
		theManager->start_components(true);
	} catch (GCM::AutoIPConfig::ServerNotFound&) {
		LOG_E (("GCM::AutoIPConfig::ServerNotFound"));
		return false;
	} catch (GCM::AutoIPConfig::BadNetworkConfig&) {
		LOG_E (("GCM::AutoIPConfig::BadNetworkConfig"));
		return false;
	} catch (GCM::AutoIPConfig::IPAddressNotFound&) {
		LOG_E (("GCM::AutoIPConfig::IPAddressNotFound"));
		return false;
	} catch (Core::DataNotFound&) {
		LOG_E (("Core::DataNotFound"));
		return false;
	} catch (GCM::InvalidName&) {
		LOG_E (("GCL::InvalidName"));
		return false;
	} catch (CORBA::TRANSIENT&) {
		LOG_E (("CORBA::TRANSIENT"));
		return false;
	} catch (CORBA::Exception& ex) {
		LOG_E (("CORBA::Exception [%s]", ex._rep_id ()));
		return false;
	} catch (...) {
		LOG_E (("Unknown exception"));
		return false;
	}
	return true;
#endif
}