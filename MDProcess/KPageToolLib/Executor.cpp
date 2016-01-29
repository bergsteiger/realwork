////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/Executor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::KPageToolLib::LibSupport::Executor
//
// получает из параметров с которыми инициализированно приложение идентифкатор страницы и действие,
// которое необходимо произвести и выполняет его.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Signal.h"
#include "MDProcess/KPageToolLib/Executor.h"
// by <<uses>> dependencies
#include "MDProcess/KPageToolLib/Settings.h"
#include "MDProcess/KPageToolLib/Actions/ActionsFactories.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void Executor::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGQUIT);
	
		//#UC START# *48E4980802A2*
		struct AutoLoginLogout {
			AutoLoginLogout (const std::string& login, const std::string& passw) {
				CoreSrv::SessionFactory::get().login (login, passw);
			}
			~AutoLoginLogout () {
				CoreSrv::SessionFactory::get().logout ();
			}
		};

		std::string login = Settings::get_login ();
		std::string password = Settings::get_password ();
		
		//логинимся
		AutoLoginLogout auto_login (login, password);

		Actions::PageActionsEnum operation = Settings::get_operation ();
		
		Actions::KPageAction* action = 0;
		try {
			//получаем действие, которое нужно выполнить
			action = &Actions::KPageActionFactory::get (operation);			
		} catch (Core::Root::UnknownFactoryKey&) {
			action = 0;
		}
		if (action == 0) {
			LOG_E (("Неизвестная операция"));
			this->set_current_status(Core::Root::ES_ERROR);
			return;
		}

		unsigned long page_id = Settings::get_page_id ();
		try {
			ServerGate::Contents::KPage& page = ServerGate::Contents::KPageFactory::get (page_id);
			if (action->execute (&page) != 0) {
				this->set_current_status(Core::Root::ES_ERROR);
				return;
			}
		} catch (ServerGate::Contents::PageNotFound&) {
			LOG_E (("Page \"%d\" was not found", page_id));
			this->set_current_status(Core::Root::ES_ERROR);
			return;
		}
		//#UC END# *48E4980802A2*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void Executor::finalize () {
	//#UC START# *48E4980802A2_FINI*
	//#UC END# *48E4980802A2_FINI*
}

void Executor::handle_control (int sig) {
	//#UC START# *48E4980802A2_HANDLE_CONTROl*
	//TODO: write your code for handle Ctrl-C
	//#UC END# *48E4980802A2_HANDLE_CONTROl*
}

} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
