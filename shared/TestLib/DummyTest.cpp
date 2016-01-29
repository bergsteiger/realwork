////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/TestLib/DummyTest.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> shared::TestLib::NewLibraryImpl::DummyTest
//
// тестовый исполнитель
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Signal.h"
#include "shared/TestLib/DummyTest.h"
// by <<uses>> dependencies
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"

namespace TestLib {

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void DummyTest::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)DummyTest::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)DummyTest::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)DummyTest::handle_control, SIGQUIT);
	
		//#UC START# *45D6DB230146*
		LOG_D (("Hello world, this is DummyTest_executor!"));
		/*CoreSrv::Session& s = CoreSrv::SessionFactory::get();
		s.login ("a", "b");
		
		LOG_D (("self sid = %d", s.get_self_sid()));
		LOG_D (("self uid = %d", s.get_self_uid()));

		LOG_D ((
			"config is: debug = %d; use_corba = %d, server_side = %d"
			, Core::Root::ConfigurationFactory::get().get_info().debug
			, Core::Root::ConfigurationFactory::get().get_info().use_corba
			, Core::Root::ConfigurationFactory::get().get_info().server_side
		));

		s.logout ();
		*/
		LOG_I(("System resource info:"));
		GCI::ResourceInfo::CPUInfo& cpu = GCI::ResourceInfo::CPUInfoFactory::get ();
		LOG_I((
			"CPU info: %dMHZ[%s][%s]"
			, cpu.get_frequency ()
			, cpu.get_identifier ().c_str ()
			, cpu.get_name ().c_str ()
		));

		GCI::ResourceInfo::ProcessMemoryInfo& process_mem = GCI::ResourceInfo::ProcessMemoryInfoFactory::get ();
		LOG_I((
			"Process memory info: %Qb Curr usage; %Qb Max usage; %Qb VM usage; %d PageFaults"
			, process_mem.get_current_usage ()
			, process_mem.get_max_usage ()
			, process_mem.get_vm_usage ()
			, process_mem.get_page_fault_count ()
		));
		
		GCI::ResourceInfo::PhysicalMemoryInfo& sys_mem = GCI::ResourceInfo::PhysicalMemoryInfoFactory::get ();
		LOG_I((
			"System memory info: %dM Available; %dM Available Virtual; %dM VM Size; %dM Full memory size"
			, static_cast<unsigned long> (sys_mem.get_available_memory_size ()/(1024*1024))
			, static_cast<unsigned long> (sys_mem.get_available_virtual_memory_size ()/(1024*1024))
			, static_cast<unsigned long> (sys_mem.get_virtual_memory_size ()/(1024*1024))
			, static_cast<unsigned long> (sys_mem.get_full_memory_size ()/(1024*1024))
		));
		ACE_OS::sleep (10);
		this->set_current_status (Core::Root::ES_EXIT_REQUESTED);
		return;
		
		//#UC END# *45D6DB230146*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void DummyTest::finalize () {
	//#UC START# *45D6DB230146_FINI*
	//#UC END# *45D6DB230146_FINI*
}

void DummyTest::handle_control (int sig) {
	//#UC START# *45D6DB230146_HANDLE_CONTROl*
	//TODO: write your code for handle Ctrl-C
	//#UC END# *45D6DB230146_HANDLE_CONTROl*
}

} // namespace TestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
