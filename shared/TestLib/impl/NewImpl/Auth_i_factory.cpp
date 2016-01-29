////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/TestLib/impl/NewImpl/Auth_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::TestLib::NewImpl::Auth_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/TestLib/impl/NewImpl/Auth_i_factory.h"
#include "shared/TestLib/impl/NewImpl/Auth_i.h"

namespace TestLib {
namespace NewImpl {

Auth_i_factory::Auth_i_factory () {
}

void Auth_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	CoreSrv::AuthenticatorFactoryManager::register_factory (this, priority);
}

const char* Auth_i_factory::key () const {
	return "Auth_i";
}

CoreSrv::Authenticator* Auth_i_factory::get () {
	Auth_i_var ret = new Auth_i ();
	return ret._retn ();
}

} // namespace NewImpl
} // namespace TestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

