////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewLibExecutor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> TestModel::BasicTests::NewLibSupport::NewLibExecutor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "ace/Signal.h"
#include "TestModel/BasicTests/NewLibExecutor.h"

namespace BasicTests {

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void NewLibExecutor::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)NewLibExecutor::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)NewLibExecutor::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)NewLibExecutor::handle_control, SIGQUIT);
	
		//#UC START# *49AEE40E0291*
		LOG_D (("Hello world, this is NewLibExecutor!"));
		//#UC END# *49AEE40E0291*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void NewLibExecutor::finalize () {
	//#UC START# *49AEE40E0291_FINI*
	//#UC END# *49AEE40E0291_FINI*
}

void NewLibExecutor::handle_control (int sig) {
	//#UC START# *49AEE40E0291_HANDLE_CONTROl*
	//TODO: write your code for handle Ctrl-C
	//#UC END# *49AEE40E0291_HANDLE_CONTROl*
}

} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
