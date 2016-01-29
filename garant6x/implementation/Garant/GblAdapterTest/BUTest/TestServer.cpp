#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"

#include <fstream>
#include "TestServer.h"

#include "garantServer/src/Services/GslDataPipe/Server/Stream.h"
#include "garantServer/src/Services/GslDataPipe/Server/PipeManager_i.h"

TestServer::TestServer () {
	register_receptacles(Defines::FN_BASE_UPDATE);
	register_receptacles(Defines::FN_USER_MANAGER);
}

void TestServer::execute () {
	bool is_error = false;

	GCMSimpleServer::execute ();
	GslUserManager::UserManager_var user_manager;
	try {
		CORBA::Object_var obj = provide (Defines::FN_USER_MANAGER);
		user_manager = GslUserManager::UserManager::_narrow (obj.in ());

		std::string password = Core::ParamManagerFactory::get ().get_string ("-pwd", "ADMIN");
		user_manager->login ("ADMIN", password.c_str ());

		if (!user_manager->has_admin_rights ()) {
			throw "TestServer::execute - Login:ADMIN, pass:ADMIN not allowed by server";
		}
		obj = provide (Defines::FN_BASE_UPDATE);
		GblPilot::BaseUpdate_var base_update = GblPilot::BaseUpdate::_narrow (obj.in ());
		GslDataPipe::FileReadingSet_var file_set;

		std::string path_to_new_base = Core::ParamManagerFactory::get ().get_string ("-PathToNewBase");

		
		printf ("******************************************\n"
				"Start TestCase: async update\n"
				"******************************************\n"
			);
		try {
			printf ("test_swap_base - start\n");
			if (path_to_new_base.empty ()) {
				base_update->test_swap_base ();
			}  else {
				printf ("new path: %s\n", path_to_new_base.c_str ());
				base_update->test_swap_base_with_path (path_to_new_base.c_str ());
			}
			printf ("test_swap_base - finish\n");		
		} catch (GCD::AccessDenied&) {														
			printf ("TestServer::execute: catch GCD::AccessDenied\n");						
		} catch (GCD::CanNotFindData&) {													
			printf ("TestServer::execute: catch GCD::CanNotFindData\n");					
		} catch (GCD::InvalidDatastoreKey&) {												
			printf ("TestServer::execute: catch GCD::InvalidDatastoreKey\n");				
		} catch (GCD::CopyProcessFailed&) {													
			printf ("TestServer::execute: catch GCD::CopyProcessFailed\n");					
		} catch (GCD::NotEnoughRoom&) {														
			printf ("TestServer::execute: catch GCD::NotEnoughRoom\n");						
		} catch (GblPilot::UpdateAlreadyStarted&) {											
			printf ("TestServer::execute: catch GblPilot::UpdateAlreadyStarted\n");			
		} catch (GblPilot::UpdateFailed&) {													
			printf ("TestServer::execute: catch GblPilot::UpdateFailed\n");					
		} catch(CORBA::Exception& ex) {														
			printf ("TestServer::execute: CORBA::Exception: %s\n", ex._info ().c_str());	
		} catch (...) {																		
			std::cout << "Some exception in TestServer::execute\n";
		}
	} catch (GslUserManager::LoginFailed&) {
		is_error = true;
		std::cout << "TestServer::execute: exception GslUserManager::LoginFailed\n";
	} catch (GslUserManager::LoginDuplicate&) {
		is_error = true;
		std::cout << "TestServer::execute: exception GslUserManager::LoginDuplicate\n";
	} catch (GslUserManager::LoginBlocked&) {
		is_error = true;
		std::cout << "TestServer::execute: exception GslUserManager::LoginBlocked\n";
	} catch (GslUserManager::NoMoreConnections&) {
		is_error = true;
		std::cout << "TestServer::execute: exception GslUserManager::NoMoreConnections\n";
	} catch (CORBA::TRANSIENT&) {
		is_error = true;
		std::cout << "TestServer::execute: exception CORBA::TRANSIENT\n";
	} catch(CORBA::Exception& ex) {
		is_error = true;
		printf ("TestServer::execute: CORBA::Exception: %s\n", ex._info ().c_str());
	} catch (const char* msg) {
		is_error = true;
		printf ("TestServer::execute: %s\n", msg);
	} catch (...) {
		is_error = true;
		std::cout << "Some exception in TestServer::execute\n";
	}
	if (NULL != user_manager.in ()) {
		user_manager->logout_current ();
	}
	status (is_error ? (GCM::cs_error) : (GCM::cs_exit_requested));
}
