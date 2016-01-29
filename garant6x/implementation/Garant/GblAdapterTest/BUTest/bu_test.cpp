// bu_test.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"
#include "ace/ARGV.h"

#include "tao/Basic_Types.h"

#include <string>
#include <iostream>
#include <fstream>

#include "shared/Core/fix/wine.h"
#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectCounter.h"
#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"
#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClientHome.h"

#include "TestServer.h"

class Local {
public:
	static int do_exit (int ret_val) {
		wait ();
		return ret_val;
	}

	static void wait () {
		// dolgop: закомментировано в связи с 28263
		//std::cout << "Press Enter to exit...";
		//getchar ();
		ACE::fini ();
	}
};

class LocalWrapper {
public:
	LocalWrapper () {}

	~LocalWrapper () {
		Local::wait ();
	}
};

static LocalWrapper lw;

int main(int argc, char* argv[])
{
	ACE::init();

	std::string s = "-GCMConfigFile \".\\garant.ini\" -GPMAdapterConfigSection \"F1Client Params\"";
	for (int i = 1; i < argc; ++i) {
		s += " \"";
		s += argv[i];
		s += "\"";
	}
	ACE_ARGV arg (s.c_str ());
	
	//регистрируем фабрику ParamManager'а
	Core::ParamManagerReg::instance ();
	
	try {
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (arg.argc (), arg.argv ()), GCL::F1::ADAPTER);
		GCM::GCMManager_ptr theManager = GCM::GCM_get_manager();
		//
		theManager->register_component(new GblPilot::PilotClientHome());
		theManager->register_component(new GslSecurity::SecurityClientHome());
		theManager->register_component(new GslUserManager::UserManagerClientHome());
        theManager->register_local_component(new GslSessionHandlerClientServer::SessionHandlerClientServerHome);
		theManager->register_local_component(new TestServer ());
		theManager->start_components(true);
	}
	catch(Core::DataNotCorrect&) {
		std::cout << "MAIN: Core::DataNotCorrect (invalid config file)\n";
		return Local::do_exit (1);
	}
	catch(GCM::InvalidName&) {
		std::cout << "MAIN: GCM::InvalidName\n";
		return Local::do_exit (1);
	}
	catch (GCM::ServerIsStarting&) {
		std::cout << "MAIN: The application server is in the process of initialization. Try to start later!\n";
		return Local::do_exit (1);
	}
	catch(CORBA::TRANSIENT&) {
		std::cout << "MAIN: CORBA::TRANSIENT\n";
		return Local::do_exit (1);
	}
	catch(CORBA::Exception& ex) {
		std::cout << "MAIN: CORBA::Exception: ";
		std::cout << ex._info ().c_str() << std::endl;
		return Local::do_exit (1);
	}
	catch(...) {
		std::cout << "MAIN: unknown exception\n";
		return Local::do_exit (1);
	}

	ACE::fini ();
	return 0;
}

