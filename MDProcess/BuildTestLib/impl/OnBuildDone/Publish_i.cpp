////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/Publish_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::Publish_i
//
// текущая реализация публикует результаты тестов в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/LibHome.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/Publish_i.h"
// by <<uses>> dependencies
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/KLoginParams.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"

namespace BuildTestLib {
namespace OnBuildDone {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Publish_i::Publish_i ()
//#UC START# *4C878E2D0298_4C87960E0173_4C878FE10386_BASE_INIT*
//#UC END# *4C878E2D0298_4C87960E0173_4C878FE10386_BASE_INIT*
{
	//#UC START# *4C878E2D0298_4C87960E0173_4C878FE10386_BODY*
	LOG_I (("%s ()", GDS_CURRENT_FUNCTION));
	//#UC END# *4C878E2D0298_4C87960E0173_4C878FE10386_BODY*
}

Publish_i::~Publish_i () {
	//#UC START# *4C878FE10386_DESTR_BODY*
	LOG_I (("%s ()", GDS_CURRENT_FUNCTION));
	//#UC END# *4C878FE10386_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// постит результаты функционального теста
void Publish_i::functional_part_to_K (TestResults::FunctionalTest* func_test, ServerGate::Contents::KPage* p) const {
	//#UC START# *4C90C376030E*
	LOG_I (("%s (): func_test = %@", GDS_CURRENT_FUNCTION, func_test));
	TestKForm test_k_form;
	test_k_form.wiki_text += "| ";
	test_k_form.wiki_text += func_test->get_passed () ? "{iconForLabel:test_done}" : "{iconForLabel:test_failed}";
	test_k_form.wiki_text += " [";
	test_k_form.wiki_text += func_test->get_name ();
	test_k_form.wiki_text += "|";
	test_k_form.wiki_text += func_test->get_description_link ();
	test_k_form.wiki_text += "]";
	test_k_form.wiki_text += " | ";
	std::string bstr = boost::lexical_cast <std::string> (func_test->get_duration ());
	std::string::size_type dot_pos = bstr.find (".");
	if (dot_pos == std::string::npos) {
		dot_pos = bstr.find (",");
	}
	std::string obstr = bstr;
	if ((dot_pos != std::string::npos) && ((dot_pos + 2) <= bstr.size ())) {
		obstr = bstr.substr (0, dot_pos + 2);
	}
	test_k_form.wiki_text += obstr;
	test_k_form.wiki_text += " | ";
	test_k_form.wiki_text += func_test->get_errors ();
	test_k_form.wiki_text += " | ";
	test_k_form.wiki_text += func_test->get_exceptions ();
	test_k_form.wiki_text += " | ";
	test_k_form.wiki_text += func_test->get_passed () ? "" : "[^";
	std::string att_name = func_test->get_passed () ? "--" : std::string (func_test->get_name ()) + ".log";
	test_k_form.wiki_text += att_name;
	test_k_form.wiki_text += func_test->get_passed () ? "" : "]";
	test_k_form.wiki_text += " |";
	for (CORBA::ULong i = 1; i < func_test->get_extra_data ()->length (); ++i) {
		test_k_form.wiki_text += std::string (" ") + std::string (func_test->get_extra_data ()->operator [] (i).in ()) + std::string (" |");
	}
	test_k_form.wiki_text += "\n";
	LOG_I (("%s (): before p->append_wiki_text", GDS_CURRENT_FUNCTION));
	p->append_wiki_text (test_k_form.wiki_text.c_str ());
	if (!func_test->get_passed ()) {
		ServerGate::Contents::ByteBuffer_var log_file_body = ServerGate::Contents::ByteBuffer (16*1024*1024, strlen (func_test->get_log_file ()), (CORBA::Octet *) func_test->get_log_file (), 0);
		LOG_I (("%s (): before p->add_attachment", GDS_CURRENT_FUNCTION));
		p->add_attachment (att_name.c_str (), log_file_body.in (), "text/plain");
	}
	//#UC END# *4C90C376030E*
}

// постит общие результаты теста
void Publish_i::generic_testsuite_to_K (
	const TestPublish::TestSuite& gen_test_suite
	, ServerGate::Contents::KPage* p
) const {
	//#UC START# *4C9B39C203AF*
	LOG_I (("%s (): gen_test.length () = %u", GDS_CURRENT_FUNCTION, gen_test_suite.length ()));
	TestKForm test_k_form;
	if (gen_test_suite.length () == 0) {
		return;
	}
	test_k_form.wiki_text += "\n\nh2. Тесты\n\n";
	bool passed = true;
	bool aborted = false;
	bool func_part = false;
	CORBA::ULong max_extra_collumns = 0;
	for (CORBA::ULong i = 0; i < gen_test_suite.length (); ++i) {
		TestResults::FunctionalTest* func_result = TestResults::FunctionalTest::_narrow (gen_test_suite [i]);
		if (func_result != 0) {
			func_part = true;
			try {
				if (boost::lexical_cast <int> (func_result->get_exceptions ()) != 0) {
					LOG_E (("%s (): func_result->get_exceptions () = %s not a number", GDS_CURRENT_FUNCTION, func_result->get_exceptions ()));
					aborted = true;
				}
			} catch (boost::bad_lexical_cast&) {
				aborted = true;
			}
		}
		if (gen_test_suite [i]->get_passed () == 0) {
			passed = false;
		}
		if (gen_test_suite [i]->get_extra_data ()->length () > max_extra_collumns) {
			max_extra_collumns = gen_test_suite [i]->get_extra_data ()->length ();
		}
	}
	if (func_part) {
		test_k_form.wiki_text += "h3. Функциональные\n\n";
		test_k_form.wiki_text += "|| имя теста || длительность || ошибки || исключения || лог ||";
		for (CORBA::ULong i = 1; i < max_extra_collumns; ++i) {
			test_k_form.wiki_text += std::string (" ") + boost::lexical_cast <std::string> (i) + std::string (" ||");
		}
		test_k_form.wiki_text += "\n";
		LOG_I (("%s (): before p->set_wiki_text", GDS_CURRENT_FUNCTION));
		p->append_wiki_text (test_k_form.wiki_text.c_str ());
		for (CORBA::ULong i = 0; i < gen_test_suite.length (); ++i) {
			TestResults::FunctionalTest* func_result = TestResults::FunctionalTest::_narrow (gen_test_suite [i]);
			if (func_result != 0) {
				this->functional_part_to_K (func_result, p);
			}
		}
	}
	test_k_form.page_labels = passed ? "test_done" : (aborted ? "test_aborted" : "test_failed");
	std::string prev_labels = p->get_labels ();
	std::string full_labels = prev_labels + "," + test_k_form.page_labels;
	LOG_I (("%s (): before p->set_labels (full_labels = %s)", GDS_CURRENT_FUNCTION, full_labels.c_str ()));
	p->set_labels (full_labels.c_str ());
	//#UC END# *4C9B39C203AF*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TestPublish::Publish
// постит результаты теста стандартным образом (сейчас - в К)
void Publish_i::post (
	const TestPublish::TestSuite& result
	, ServerGate::Contents::PageId page_id
) throw (
	CORBA::SystemException
) {
	//#UC START# *4C878E6901EA_4C878FE10386*
	try {
		LOG_I (("%s (): result = %@, page_id = %Q", GDS_CURRENT_FUNCTION, result, page_id));
		LocalPageLogin_var local_page_login = LocalPageLoginFactory::make (KLoginParams::get_login (), KLoginParams::get_password (), page_id);
		LOG_I (("%s (): local_page_login->get_p () = %@", GDS_CURRENT_FUNCTION, local_page_login->get_p ()));
		this->generic_testsuite_to_K (result, local_page_login->get_p ());
	} CATCH_AND_LOG ("exception in Publish_i::post")
	//#UC END# *4C878E6901EA_4C878FE10386*
}
} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

