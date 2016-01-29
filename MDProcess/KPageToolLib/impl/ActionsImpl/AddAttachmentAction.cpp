////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AddAttachmentAction
//
// AddAttachmentAction
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/LibHome.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction.h"
// by <<uses>> dependencies
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"
#include "MDProcess/KPageToolLib/Settings.h"

namespace KPageToolLib {
namespace ActionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddAttachmentAction::AddAttachmentAction ()
//#UC START# *48E49C08024A_48E49C5D02FE_4AE824A402C8_BASE_INIT*
//#UC END# *48E49C08024A_48E49C5D02FE_4AE824A402C8_BASE_INIT*
{
	//#UC START# *48E49C08024A_48E49C5D02FE_4AE824A402C8_BODY*
	//#UC END# *48E49C08024A_48E49C5D02FE_4AE824A402C8_BODY*
}

AddAttachmentAction::~AddAttachmentAction () {
	//#UC START# *4AE824A402C8_DESTR_BODY*
	//#UC END# *4AE824A402C8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Actions::KPageAction
// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
// (подробности в консольном окне).
// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
int AddAttachmentAction::execute (ServerGate::Contents::KPage* page) {
	//#UC START# *48E49D8D0020_4AE824A402C8*
	GDS_ASSERT_MSG(page != 0,("Error page can't be NULL"));
	int ret = 0;

	CharVector file_content;
	ret = SourceFileHelper::read_as_char_vector (file_content);
	if (ret != 0) {
		return ret;
	}

	std::string file = Settings::get_file ();
	std::string short_file_name = file;
	if (std::string::npos != file.find_last_of ('\\')) {
		std::string::size_type i = file.find_last_of ('\\')+1;
		short_file_name = file.substr (i, file.length () - i);
	} else if (std::string::npos != file.find_last_of ('/')) {
		std::string::size_type i = file.find_last_of ('/')+1;
		short_file_name = file.substr (i, file.length () - i);
	}

	std::string file_ext = 
		(short_file_name.find_last_of(".") > 0)
		? short_file_name.substr (short_file_name.find_last_of("."), short_file_name.length()-short_file_name.find_last_of("."))
		: ""
	;

	std::string content_type = "text/plain";
	if (file_ext == ".pdf") {
		content_type = "application/pdf";
	} else if (file_ext == ".gif") {
		content_type = "image/gif";
	} else if (file_ext == ".jpeg" || file_ext == ".jpg") {
		content_type = "image/jpeg";
	} else if (file_ext == ".xml") {
		content_type = "text/xml";
	} else if (file_ext == ".html" || file_ext == ".htm") {
		content_type = "text/html";
	} else if (file_ext == ".doc") {
		content_type = "application/msword";
	}


	if (file_content.size () > 0) {
		try {
			page->add_attachment (
				short_file_name.c_str ()
				, ServerGate::Contents::ByteBuffer (
					file_content.size ()
					, file_content.size ()
					, (CORBA::Octet*)&file_content[0]
					, 0
				)
				, content_type.c_str ()
			);
		} catch (CORBA::SystemException& se) {
			LOG_CEX ((se, "While execute KPage::add_attachment"));
			return 1;
		} catch (ServerGate::Contents::PermissionException) {
			LOG_E (("Permission denied while execute KPage::add_attachment"));
			return 1;
		}

	}
	return 0;
	//#UC END# *48E49D8D0020_4AE824A402C8*
}
} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

