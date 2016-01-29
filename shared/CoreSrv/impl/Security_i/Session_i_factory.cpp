////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Security_i/Session_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Security_i::Session_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/impl/Security_i/Session_i_factory.h"
#include "shared/CoreSrv/impl/Security_i/Session_i.h"

namespace CoreSrv {
namespace Security_i {

Session_i_factory::Session_i_factory () {
}

void Session_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SessionFactoryManager::register_factory (this, priority);
}

const char* Session_i_factory::key () const {
	return "Session_i";
}

Session* Session_i_factory::get () {
	Session_i_var ret = new Session_i ();
	return ret._retn ();
}

} // namespace Security_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

