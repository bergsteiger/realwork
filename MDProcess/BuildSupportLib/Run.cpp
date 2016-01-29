////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildSupportLib/Run.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::BuildSupportLib::LibSupport::Run
//
// Обрабатывает входные параметры и передает их в экземпляр объекта Сборки, вызывая на нем
// соответствующее событие.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Signal.h"
#include "MDProcess/BuildSupportLib/Run.h"
// by <<uses>> dependencies
#include "MDProcess/ServerGate/BuildSupport/BuildSupportFactories.h"
#include "MDProcess/ServerGate/BuildSupport/BuildSupport.h"
#include "MDProcess/BuildSupportLib/RunSettings.h"
#include "boost/lexical_cast.hpp"
#include <fstream>

namespace BuildSupportLib {

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void Run::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)Run::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)Run::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)Run::handle_control, SIGQUIT);
	
		//#UC START# *47D7FDD8010A*
		const std::string login = RunSettings::get_login();
		const std::string paswd = RunSettings::get_paswd();

		const std::string event_name = RunSettings::get_event();
		const std::string project_name = RunSettings::get_project();
		const std::string tag_name = RunSettings::get_tag();
		const std::string build_name = RunSettings::get_build();		
		const std::string build_path = RunSettings::get_build_path();
		const std::string branch_number = RunSettings::get_branch();
		
		struct sTLogin {
			sTLogin (const std::string& login, const std::string& paswd) {
				CoreSrv::SessionFactory::get().login(login, paswd);
			}
			~sTLogin () {
				CoreSrv::SessionFactory::get().logout();
			}
		} auto_login (login,paswd);

		LOG_D(("Run::execute_: make(%s,%s,%s,%s,%s,%s)"
			,event_name.c_str()
			, project_name.c_str()
			, tag_name.c_str()
			, build_name.c_str()
			, branch_number.empty () ? "''" : branch_number.c_str()
			, build_path.empty () ? "''" : build_path.c_str()
		));
		
		const std::string log_file_path = RunSettings::get_build_log ();
		std::string log_data;
		if (log_file_path.empty () == false) {
			std::ifstream in_file (log_file_path.c_str (), std::ios::in);
			if (!in_file) {
				LOG_E (("Can't open file: %s", log_file_path.c_str ()));
			} else {
				std::copy (
					std::istreambuf_iterator<char>(in_file)
					, std::istreambuf_iterator<char>()
					, std::back_inserter(log_data)
				);
			}
		}
		ServerGate::BuildSupport::BuildManager& build_manager = ServerGate::BuildSupport::BuildManagerFactory::get();
		build_manager.make(
			event_name.c_str()
			, project_name.c_str()
			, tag_name.c_str()
			, build_name.c_str()
			, branch_number.c_str()
			, build_path.c_str ()
			, log_data.c_str ()
		);
		//#UC END# *47D7FDD8010A*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void Run::finalize () {
	//#UC START# *47D7FDD8010A_FINI*
	//#UC END# *47D7FDD8010A_FINI*
}

void Run::handle_control (int sig) {
	//#UC START# *47D7FDD8010A_HANDLE_CONTROl*
	//TODO: write your code for handle Ctrl-C
	//#UC END# *47D7FDD8010A_HANDLE_CONTROl*
}

} // namespace BuildSupportLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
