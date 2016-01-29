////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/Executor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::RosePackageLocking::LibSupport::Executor
//
// при старте сервера устанавливает обработчик Ctrl-C и загружает информацию о залочках из файла
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Signal.h"
#include "MDProcess/RosePackageLocking/Executor.h"
// by <<uses>> dependencies
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerFactories.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"


#include "shared/CoreSrv/Utils/ORB.h"
#include "MDProcess/RosePackageLocking/LibHome.h"

namespace RosePackageLocking {

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void Executor::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGQUIT);
	
		//#UC START# *487B360B009A*
		//в конструкторе серванта, реализующего PackageManager выполняется загрузка сохранённой информации
		RosePackageLocking::RosePackageLockingServer::PackageManagerFactory::instance ();

		unsigned short request_timeout = static_cast<unsigned short>(Core::ParamManagerFactory::get ().get_ulong ("-GCMRequestTimeout", 60));
		LOG_D (("RosePackageLocking::Executor::execute_ () request_timeout = %d", request_timeout));
		CoreSrv::ORB::enable_request_timeout(&RosePackageLocking::LibHomeFactory::get ().get_orb_facet ().get_main_orb (), request_timeout);

		//#UC END# *487B360B009A*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void Executor::finalize () {
	//#UC START# *487B360B009A_FINI*
	//#UC END# *487B360B009A_FINI*
}

void Executor::handle_control (int sig) {
	//#UC START# *487B360B009A_HANDLE_CONTROl*
	Executor::get ().set_current_status (Core::Root::ES_EXIT_REQUESTED);
	//#UC END# *487B360B009A_HANDLE_CONTROl*
}

} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
