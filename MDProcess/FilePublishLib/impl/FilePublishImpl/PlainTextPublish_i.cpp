////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/impl/FilePublishImpl/PlainTextPublish_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::FilePublishLib::FilePublishImpl::PlainTextPublish_i
//
// конвертит файл в тест и публикует его
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/LibHome.h"
#include "MDProcess/FilePublishLib/impl/FilePublishImpl/PlainTextPublish_i.h"
// by <<uses>> dependencies
#include "MDProcess/BuildTestLib/TestPublish/TestPublish.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublish.h"
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"
#include "boost/lexical_cast.hpp"

namespace FilePublishLib {
namespace FilePublishImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PlainTextPublish_i::PlainTextPublish_i ()
//#UC START# *4C88E09A03B0_4C88E16C0128_4C88E4CF0081_BASE_INIT*
//#UC END# *4C88E09A03B0_4C88E16C0128_4C88E4CF0081_BASE_INIT*
{
	//#UC START# *4C88E09A03B0_4C88E16C0128_4C88E4CF0081_BODY*
	LOG_I (("%s ()", GDS_CURRENT_FUNCTION));
	//#UC END# *4C88E09A03B0_4C88E16C0128_4C88E4CF0081_BODY*
}

PlainTextPublish_i::~PlainTextPublish_i () {
	//#UC START# *4C88E4CF0081_DESTR_BODY*
	LOG_I (("%s ()", GDS_CURRENT_FUNCTION));
	//#UC END# *4C88E4CF0081_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from FilePublish::PlainTextPublish
// публикует текстовый файл как результат функционального теста
void PlainTextPublish_i::post_as_functional_test (const std::string& file_path, const std::string& page_id) {
	//#UC START# *4C88E0F30054_4C88E4CF0081*
	LOG_I (("%s (): file_path = %s, page_id = %s", GDS_CURRENT_FUNCTION, file_path.c_str (), page_id.c_str ()));
	FilePublishLib::FilePublish::PlainText2FunctionalTest& converter = FilePublishLib::FilePublish::PlainText2FunctionalTestFactory::get ();
	::Core::Aptr <FilePublishLib::FilePublish::FunctionalTestSuite> result = converter.convert (file_path);
	LOG_I (("%s (): after  _retn () in post_as_functional_test", GDS_CURRENT_FUNCTION));
	BuildTestLib::TestPublish::Publish_var publish = BuildTestLib::TestPublish::PublishFactory::make ();
	long long llid = 0;
	try {
		llid = boost::lexical_cast <long long> (page_id);
	} catch (boost::bad_lexical_cast&) {
		LOG_E (("%s (): bad page_id = %s", GDS_CURRENT_FUNCTION, page_id.c_str ()));
		return;
	}
	LOG_I (("%s (): before publish->post in post_as_functional_test", GDS_CURRENT_FUNCTION));
	try {
		BuildTestLib::TestResults::Test* p [1024];
		GDS_ASSERT (result.in ()->size () < 1024);
		for (unsigned int i = 0; i < result.in ()->size (); ++i) {
			if (i < 1024) {
				p [i] = result.in ()->operator [] (i).in ();
			}
		}
		publish->post (BuildTestLib::TestPublish::TestSuite (1024, result.in ()->size (), p, 0), llid);
	} CATCH_AND_LOG ("try publish->post")
	//#UC END# *4C88E0F30054_4C88E4CF0081*
}
} // namespace FilePublishImpl
} // namespace FilePublishLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

