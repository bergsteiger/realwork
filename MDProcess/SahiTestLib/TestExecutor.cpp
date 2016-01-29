////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/SahiTestLib/TestExecutor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::SahiTestLib::TestPerformer::TestExecutor
//
// исполнитель тестов sahi - контролирует процесс выполнения тестов и публикует результаты
// стандартным способом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Signal.h"
#include "MDProcess/SahiTestLib/TestExecutor.h"
// by <<uses>> dependencies
#include "MDProcess/FilePublishLib/FilePublish/FilePublishFactories.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublish.h"
#include "MDProcess/SahiTestLib/SahiSettings.h"
#include <fstream>
#include "MDProcess/SahiTestLib/TestPlaceSettings.h"

namespace SahiTestLib {

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void TestExecutor::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)TestExecutor::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)TestExecutor::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)TestExecutor::handle_control, SIGQUIT);
	
		//#UC START# *4C87948E01DD*
		LOG_I (("Hello world, this is TestExecutor!"));
		std::string prefix_path = TestPlaceSettings::get_prefix_path ();
		LOG_I (("%s (): prefix_path = %s", GDS_CURRENT_FUNCTION, prefix_path.c_str ()));
		std::string prefix_path_win = prefix_path;
		GCL::str_replace (prefix_path_win, "/", "\\");
		std::string bat_file_path = SahiSettings::get_bat_file_path ();
		std::string bat_file_path_win = bat_file_path;
		GCL::str_replace (bat_file_path_win, "/", "\\");
		std::string text_file_path = SahiSettings::get_text_file_path ();
		std::string text_file_path_win = text_file_path;
		GCL::str_replace (text_file_path_win, "/", "\\");
		std::string bat_file_cmd = prefix_path_win + std::string ("\\") + bat_file_path_win + std::string (" ") + std::string (TestPlaceSettings::prefix_path_param_name ()) + std::string (" ") + prefix_path_win;
		int res = ACE_OS::system (bat_file_cmd.c_str ());
		if (res == -1) {
			LOG_E ((
				"%s (): can't bat_file_cmd = %s"
				, GDS_CURRENT_FUNCTION
				, bat_file_cmd.c_str ()
			));
		}
		std::string abs_text_file_path_win = prefix_path_win + std::string ("\\") + text_file_path_win;
		bool done = false;
		while (!done) {
			::Sleep (10000);
			{ // stack frame for ifstream
			ifstream ss (abs_text_file_path_win.c_str ());
			if (ss) {
				::Sleep (10000);
				done = true;
			}
			} // end stack frame for ifstream
		}
		std::string str_page_id = prefix_path_win.substr (prefix_path_win.rfind ("\\") + 1);
		FilePublishLib::FilePublish::PlainTextPublish_var file_pub = FilePublishLib::FilePublish::PlainTextPublishFactory::make ();
		file_pub->post_as_functional_test (abs_text_file_path_win.c_str (), str_page_id);
		//#UC END# *4C87948E01DD*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void TestExecutor::finalize () {
	//#UC START# *4C87948E01DD_FINI*
	//#UC END# *4C87948E01DD_FINI*
}

void TestExecutor::handle_control (int sig) {
	//#UC START# *4C87948E01DD_HANDLE_CONTROl*
	//TODO: write your code for handle Ctrl-C
	//#UC END# *4C87948E01DD_HANDLE_CONTROl*
}

} // namespace SahiTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
