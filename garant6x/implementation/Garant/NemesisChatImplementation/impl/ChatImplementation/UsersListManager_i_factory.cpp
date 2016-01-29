////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UsersListManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::UsersListManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UsersListManager_i_factory.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UsersListManager_i.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/LibHome.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

UsersListManager_i_factory::UsersListManager_i_factory () {
}

void UsersListManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ChatLibrary::ChatService::UsersListManagerFactoryManager::register_factory (this, priority);
}

const char* UsersListManager_i_factory::key () const {
	return "UsersListManager_i";
}

ChatLibrary::ChatService::UsersListManager* UsersListManager_i_factory::get (CoreSrv::UserID uid) {
	UsersListManager_i_var ret = new UsersListManager_i (uid, UsersListManager_i::FactoriesID::Get());
	return ret->_this ();
}

ChatLibrary::ChatService::UsersListManager* UsersListManager_i_factory::get_by_uid (CoreSrv::UserID uid) {
	UsersListManager_i_var ret = new UsersListManager_i (uid, UsersListManager_i::FactoriesID::GetByUid());
	return ret->_this ();
}

} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

