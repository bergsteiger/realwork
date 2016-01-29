////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/DefaultLogManagerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::DefaultLogManagerImpl
//
// реализация менеджера логгирования, пишет сообщения в спец. закладки в Розе и дублирует их в
// системно логе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/DefaultLogManagerImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace GenSupportImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// константы
const std::string DefaultLogManagerImpl::ERROR_TAB_NAME = "Errors"; // имя вкладки, куда будут писаться сообщения об ошибках
const std::string DefaultLogManagerImpl::WARNING_TAB_NAME = "Warnings"; // имя вкладки, куда будут писаться предупреждения
const std::string DefaultLogManagerImpl::DOMAIN_TAB_NAME = "MDA"; // домент - идентификатор для создаваемых табов

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DefaultLogManagerImpl::DefaultLogManagerImpl ()
//#UC START# *4BBB08630331_4BBB089402E7_4BBB09AB0289_BASE_INIT*
//#UC END# *4BBB08630331_4BBB089402E7_4BBB09AB0289_BASE_INIT*
{
	//#UC START# *4BBB08630331_4BBB089402E7_4BBB09AB0289_BODY*
	//#UC END# *4BBB08630331_4BBB089402E7_4BBB09AB0289_BODY*
}

DefaultLogManagerImpl::~DefaultLogManagerImpl () {
	//#UC START# *4BBB09AB0289_DESTR_BODY*
	//#UC END# *4BBB09AB0289_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// записывает сообщение в нужную вкладку
void DefaultLogManagerImpl::write_message_to_tab (const std::string& tab_name, const std::string& message) const {
	//#UC START# *4BBB0B8C00C3*
	IRoseApplicationPtr app = RoseHelper::rose_app ();
	if (app) {
		app->LogCreateTab (tab_name.c_str (), DOMAIN_TAB_NAME.c_str ());
		app->LogSetActiveTab (tab_name.c_str (), DOMAIN_TAB_NAME.c_str ());
		app->LogWriteTab (tab_name.c_str (), DOMAIN_TAB_NAME.c_str (), message.c_str ());
	}
	//#UC END# *4BBB0B8C00C3*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GenSupport::LogManager
// инициализация менеджера, может вызываться несколько раз
void DefaultLogManagerImpl::init () const {
	//#UC START# *4BBB0A4B0023_4BBB09AB0289*
	IRoseApplicationPtr app = RoseHelper::rose_app ();
	if (app) {
		app->LogCloseTab (ERROR_TAB_NAME.c_str (), DOMAIN_TAB_NAME.c_str ());
		app->LogCloseTab (WARNING_TAB_NAME.c_str (), DOMAIN_TAB_NAME.c_str ());
	}
	//#UC END# *4BBB0A4B0023_4BBB09AB0289*
}

// implemented method from GenSupport::LogManager
// логгирование ошибки
void DefaultLogManagerImpl::log_error (const std::string& message) const {
	//#UC START# *4BBB08EB00A1_4BBB09AB0289*
	write_message_to_tab (ERROR_TAB_NAME, message);
	LOG_E (("%s", message.c_str ()));
	//#UC END# *4BBB08EB00A1_4BBB09AB0289*
}

// implemented method from GenSupport::LogManager
// логгирование информационного сообщения
void DefaultLogManagerImpl::log_info (const std::string& message) const {
	//#UC START# *4BBB094F019D_4BBB09AB0289*
	IRoseApplicationPtr app = RoseHelper::rose_app ();
	if (app) {
		app->WriteErrorLog (message.c_str ());
	}

	LOG_I (("%s", message.c_str ()));
	//#UC END# *4BBB094F019D_4BBB09AB0289*
}

// implemented method from GenSupport::LogManager
// логгирование предупреждения
void DefaultLogManagerImpl::log_warning (const std::string& message) const {
	//#UC START# *4BBB09060329_4BBB09AB0289*
	write_message_to_tab (WARNING_TAB_NAME, message);
	LOG_W (("%s", message.c_str ()));
	//#UC END# *4BBB09060329_4BBB09AB0289*
}
} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

