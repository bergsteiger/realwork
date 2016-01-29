////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Security_i/SessionManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Security_i::SessionManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/impl/Security_i/SessionManager_i_factory.h"
#include "shared/CoreSrv/impl/Security_i/SessionManager_i.h"
#include "shared/CoreSrv/LibHome.h"

namespace CoreSrv {
namespace Security_i {

SessionManager_i_factory::SessionManager_i_factory () {
}

void SessionManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SecuritySrv::SessionManagerFactoryManager::register_factory (this, priority);
}

const char* SessionManager_i_factory::key () const {
	return "SessionManager_i";
}

SecuritySrv::SessionManager* SessionManager_i_factory::get () {
	SessionManager_i_var ret = new SessionManager_i ();
	return ret->_this ();
}

} // namespace Security_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

