////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/Security/impl/SecurityImpl/AuthenticatorImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::Security::SecurityImpl::AuthenticatorImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/Security/impl/SecurityImpl/AuthenticatorImpl_factory.h"
#include "MDProcess/Security/impl/SecurityImpl/AuthenticatorImpl.h"

namespace Security {
namespace SecurityImpl {

AuthenticatorImpl_factory::AuthenticatorImpl_factory () {
}

void AuthenticatorImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	CoreSrv::AuthenticatorFactoryManager::register_factory (this, priority);
}

const char* AuthenticatorImpl_factory::key () const {
	return "AuthenticatorImpl";
}

CoreSrv::Authenticator* AuthenticatorImpl_factory::get () {
	AuthenticatorImpl_var ret = new AuthenticatorImpl ();
	return ret._retn ();
}

} // namespace SecurityImpl
} // namespace Security

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

