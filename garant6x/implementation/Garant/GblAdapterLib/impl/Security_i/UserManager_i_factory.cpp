////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserManager_i.h"

namespace GblAdapterLib {

UserManager_i_factory::UserManager_i_factory () {
}

void UserManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UserManagerFactoryManager::register_factory (this, priority);
}

const char* UserManager_i_factory::key () const {
	return "UserManager_i";
}

UserManager* UserManager_i_factory::make () {
	return Core::IObject::_duplicate (UserManager_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

