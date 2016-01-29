////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/Executor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::MDAFormat::LibSupport::Executor
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "ace/Signal.h"
#include "MDProcess/MDAFormat/Executor.h"
// by <<uses>> dependencies
#include "MDProcess/MDAFormat/ModelPartDef/ModelPart.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPart.h"
#include "MDProcess/MDAFormat/RootFile/ModelRoot.h"

namespace MDAFormat {

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void Executor::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)Executor::handle_control, SIGQUIT);
	
		//#UC START# *48ABDF5E022E*
		/*Core::Box<ModelPartDef::RootPackage> uml_package;
		try {			
			Core::GDS::StopWatch ex ("ModelPartDef parse");
			ModelPartDef::ModelPart parser ("W:/example.uml");
			uml_package = parser.root_package ();
			std::ofstream out ("W:/example_out.uml", std::ios_base::out);
			out << *uml_package;
		} catch (antlr::ANTLRException& ex) {
			LOG_E (("%s", ex.toString ()));
		}

		Core::Box<AdditionalPartDef::Package> umla_package;
		try {			
			Core::GDS::StopWatch ex ("AdditionalPartDef parse");
			AdditionalPartDef::AdditionalPart parser ("W:/example.umla");
			umla_package = parser.package ();
			std::ofstream out ("W:/example_out.umla", std::ios_base::out);
			out << *umla_package;
		} catch (antlr::ANTLRException& ex) {
			LOG_E (("%s", ex.toString ()));
		}*/
		//#UC END# *48ABDF5E022E*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void Executor::finalize () {
	//#UC START# *48ABDF5E022E_FINI*
	//#UC END# *48ABDF5E022E_FINI*
}

void Executor::handle_control (int sig) {
	//#UC START# *48ABDF5E022E_HANDLE_CONTROl*
	//TODO: write your code for handle Ctrl-C
	//#UC END# *48ABDF5E022E_HANDLE_CONTROl*
}

} // namespace MDAFormat

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
