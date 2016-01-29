////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i_AutoLoginAdmin.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::UsersImportLib::UsersImport_i::Writer_i::AutoLoginAdmin
//
// класс для авторизации администратора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i.h"

//#UC START# *48200E98006D_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"
//#UC END# *48200E98006D_CUSTOM_INCLUDES*

namespace UsersImport_i {
class Writer_i;
//#UC START# *48200E98006D*
//#UC END# *48200E98006D*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// фабрика
Writer_i::AutoLoginAdmin::AutoLoginAdmin (GslUserManager::UserManager* user_manager)
//#UC START# *48200F170398_BASE_INIT*
: m_user_manager (user_manager)
//#UC END# *48200F170398_BASE_INIT*
{
	//#UC START# *48200F170398_BODY*
	const std::string std_admin_login ("ADMIN");
	const std::string std_admin_password ("ADMIN");

	std::string password = Core::ParamManagerFactory::get ().get_string ("-pwd", "ADMIN");
	std::string login = Core::ParamManagerFactory::get ().get_string ("-login", "ADMIN");

	while (1) {
		try {
			m_user_manager->login (login.c_str (), password.c_str ());
			break;
		} catch (GCD::XMLImportRunning&) {
			LOG_W (("xml import running, wait..."));
			ACE_OS::sleep (5);
		}
	}
	//#UC END# *48200F170398_BODY*
}

Writer_i::AutoLoginAdmin::~AutoLoginAdmin () {
	//#UC START# *48200E98006D_DESTR_BODY*
	m_user_manager->logout_current ();
	//#UC END# *48200E98006D_DESTR_BODY*
}


} // namespace UsersImport_i

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

