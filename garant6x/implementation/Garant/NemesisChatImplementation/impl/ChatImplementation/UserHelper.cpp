////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UserHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garant6x::NemesisChatImplementation::ChatImplementation::UserHelper
//
// определение идентификатора пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UserHelper.h"

//#UC START# *4A364A4E009C_CUSTOM_INCLUDES*
#include "garantServer/src/ServiceAdapter/GsaUserData/Server/UserDataStorage_i.h"

#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClient.h"
//#UC END# *4A364A4E009C_CUSTOM_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

//#UC START# *4A364A4E009C*
//#UC END# *4A364A4E009C*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получить идентификатор пользователя
CoreSrv::UserID UserHelper::get_user_id () {
	//#UC START# *4A364A6B026F*
	return GslUserManager::get_current_uid_or_throw ();
	//#UC END# *4A364A6B026F*
}

// плучить информацию о пользователе
ChatLibrary::ChatService::UserInfo* UserHelper::get_user_info (CoreSrv::UserID user) {
	//#UC START# *4A3754650389*
	try {
		GslUserManager::UserInfo_var base_user_info = GsaUserDataServer::user_manager_storage ()->get_user_info (user);
		ChatLibrary::ChatService::UserInfo_var user_info (new ChatLibrary::ChatService::UserInfo ());

		user_info->name = base_user_info->m_name;
		user_info->login = base_user_info->m_login;
		user_info->email = base_user_info->m_mail;

		return user_info._retn ();
	} catch (CORBA::Exception&) {
		throw ChatLibrary::ChatService::UnknownUser ();
	}

	GDS_ASSERT (false && "UNREACHABLE");
	throw ChatLibrary::ChatService::UnknownUser ();
	//#UC END# *4A3754650389*
}

// возвращает true, если пользователь есть в системе
CORBA::Boolean UserHelper::is_user_exists (CoreSrv::UserID user) {
	//#UC START# *4A3777D40314*
	try {
		GslUserManager::UserInfo_var base_user_info = GsaUserDataServer::user_manager_storage ()->get_user_info (user);
		return true;
	} catch (CORBA::Exception&) {
		return false;
	}

	GDS_ASSERT (false && "UNREACHABLE");
	return false;
	//#UC END# *4A3777D40314*
}

} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

