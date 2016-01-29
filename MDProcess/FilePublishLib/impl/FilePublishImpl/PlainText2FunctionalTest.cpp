////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/impl/FilePublishImpl/PlainText2FunctionalTest.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::FilePublishLib::FilePublishImpl::PlainText2FunctionalTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/LibHome.h"
#include "MDProcess/FilePublishLib/impl/FilePublishImpl/PlainText2FunctionalTest.h"
// by <<uses>> dependencies
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"
#include <fstream>

namespace FilePublishLib {
namespace FilePublishImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PlainText2FunctionalTest::PlainText2FunctionalTest ()
//#UC START# *4C88DB900328_4C88DC060356_4C8A28300362_BASE_INIT*
//#UC END# *4C88DB900328_4C88DC060356_4C8A28300362_BASE_INIT*
{
	//#UC START# *4C88DB900328_4C88DC060356_4C8A28300362_BODY*
	//#UC END# *4C88DB900328_4C88DC060356_4C8A28300362_BODY*
}

PlainText2FunctionalTest::~PlainText2FunctionalTest () {
	//#UC START# *4C8A28300362_DESTR_BODY*
	//#UC END# *4C8A28300362_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from FilePublish::PlainText2FunctionalTest
// собственно метод конвертации plain text в FunctionalTest
FilePublish::FunctionalTestSuite* PlainText2FunctionalTest::convert (const std::string& file_path) const {
	//#UC START# *4C88DBD503A4_4C8A28300362*
	LOG_I (("%s (): file_path = %s", GDS_CURRENT_FUNCTION, file_path.c_str ()));
	std::string file_path_win = file_path;
	GCL::str_replace (file_path_win, "/", "\\");
	std::ifstream ss (file_path_win.c_str ());
	if (!ss) {
		LOG_E (("%s (): bad file_path_win = %s", GDS_CURRENT_FUNCTION, file_path_win.c_str ()));
		return 0;
	}
	::Core::Aptr <FilePublishLib::FilePublish::FunctionalTestSuite> func_test_suite = new FilePublishLib::FilePublish::FunctionalTestSuite ();
	std::string test_name = "";
	int test_passed = 0;
	std::string test_log_file = "";
	std::string test_description_link = "";
	std::string test_exceptions = "";
	double test_duration = 0.0;
	std::string test_errors = "";
	std::string test_extra_data = "";
	int test_cnt = 0;
	while (ss >> test_name >> test_passed >> test_log_file >> test_description_link >> test_exceptions >> test_duration >> test_errors >> test_extra_data) {
		++test_cnt;
		LOG_I (("%s (): test_cnt = %d", GDS_CURRENT_FUNCTION, test_cnt));
		std::string log_path_win = file_path_win.substr (0, file_path_win.rfind ("\\")) + "\\" + test_log_file;
		std::ifstream ss1 (log_path_win.c_str ());
		std::string log_file_body = "";
		if (ss1) {
			LOG_I (("%s (): opened: log_path_win = %s", GDS_CURRENT_FUNCTION, log_path_win.c_str ()));
			char linebuf [65536];
			while (ss1.getline (linebuf, 65536)) {
				log_file_body += linebuf;
				log_file_body += "\r\n";
			}
		}
		LOG_I (("before BuildTestLib::TestResults::FunctionalTestFactory::make ()"));
		BuildTestLib::TestResults::FunctionalTest_var func_test = BuildTestLib::TestResults::FunctionalTestFactory::make ();
		LOG_I (("after BuildTestLib::TestResults::FunctionalTestFactory::make ()"));
		func_test->set_name (test_name.c_str ());
		func_test->set_passed (test_passed);
		func_test->set_log_file (log_file_body.c_str ());
		func_test->set_description_link (test_description_link.c_str ());
		func_test->set_exceptions (test_exceptions.c_str ());
		func_test->set_duration (test_duration);
		func_test->set_errors (test_errors.c_str ());

		CORBA::ULong sz = test_extra_data.size ();
		char* strbuf = new char [sz+1];
		ACE_OS::strcpy (strbuf, test_extra_data.c_str ());
		char* buf [1000];
		int j = 0;
		for (CORBA::ULong i = 0; i < sz; ++i) {
			if (strbuf [i] == ',') {
				strbuf [i] = '\0';
				if ((i+1) != sz) {
					buf [j] = &strbuf [i+1];
					++j;
				} else {
					buf [j] = '\0';
					strbuf [i+1] = '\0';
				}
			}
		}
		GDS_ASSERT (j <= 1000);
		BuildTestLib::TestResults::ExtraDataArray result = BuildTestLib::TestResults::ExtraDataArray (1000, j, buf, 0);

		func_test->set_extra_data (result);

		func_test_suite.inout()->push_back (func_test);
	}
	LOG_I (("before _retn ()"));
	return func_test_suite._retn ();
	//#UC END# *4C88DBD503A4_4C8A28300362*
}
} // namespace FilePublishImpl
} // namespace FilePublishLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

