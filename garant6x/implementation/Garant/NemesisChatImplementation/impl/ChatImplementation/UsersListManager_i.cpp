////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UsersListManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::UsersListManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/LibHome.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UsersListManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UserHelper.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Storage.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UsersListManager_i::UsersListManager_i (CoreSrv::UserID uid, const FactoriesID::Get& factory_id)
//#UC START# *4A2E039200FC_4A3735D401C5_4A2E3A060102_BASE_INIT*
: m_uid (uid)
//#UC END# *4A2E039200FC_4A3735D401C5_4A2E3A060102_BASE_INIT*
{
	//#UC START# *4A2E039200FC_4A3735D401C5_4A2E3A060102_BODY*
	//#UC END# *4A2E039200FC_4A3735D401C5_4A2E3A060102_BODY*
}

UsersListManager_i::UsersListManager_i (CoreSrv::UserID uid, const FactoriesID::GetByUid& factory_id)
//#UC START# *4A2E039200FC_4A7979290005_4A2E3A060102_BASE_INIT*
: m_uid (uid)
//#UC END# *4A2E039200FC_4A7979290005_4A2E3A060102_BASE_INIT*
{
	//#UC START# *4A2E039200FC_4A7979290005_4A2E3A060102_BODY*
	//#UC END# *4A2E039200FC_4A7979290005_4A2E3A060102_BODY*
}

UsersListManager_i::~UsersListManager_i () {
	//#UC START# *4A2E3A060102_DESTR_BODY*
	//#UC END# *4A2E3A060102_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ChatLibrary::ChatService::UsersListManager
// добавить пользователя в список контактов
void UsersListManager_i::add_user_to_list (
	CoreSrv::UserID user
) throw (
	CORBA::SystemException
	, ChatLibrary::ChatService::UnknownUser
) {
	//#UC START# *4A2E03E401C9_4A2E3A060102*
	if (!UserHelper::is_user_exists (user)) {
		throw ChatLibrary::ChatService::UnknownUser ();
	}
	Stg::instance ()->add_to_contacts (m_uid, user);
	//#UC END# *4A2E03E401C9_4A2E3A060102*
}

// implemented method from ChatLibrary::ChatService::UsersListManager
// удалить пользователя из списка контактов
void UsersListManager_i::del_user_from_list (
	CoreSrv::UserID user
) throw (
	CORBA::SystemException
	, ChatLibrary::ChatService::UnknownUser
) {
	//#UC START# *4A2E06EB02D6_4A2E3A060102*
	if (!UserHelper::is_user_exists (user)) {
		throw ChatLibrary::ChatService::UnknownUser ();
	}
	Stg::instance ()->delete_from_contacts (m_uid, user);
	//#UC END# *4A2E06EB02D6_4A2E3A060102*
}

// implemented method from ChatLibrary::ChatService::UsersListManager
// получить список контактов
ChatLibrary::ChatService::UidList* UsersListManager_i::get_contacts_list () throw (CORBA::SystemException) {
	//#UC START# *4A2E0717034A_4A2E3A060102*
	return Stg::instance ()->get_contacts (m_uid);
	//#UC END# *4A2E0717034A_4A2E3A060102*
}
} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

