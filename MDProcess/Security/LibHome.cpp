////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/Security/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::Security
//
// нужно для реализаци базовых интерфейсов аутентификации из шареда
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/Security/LibHome.h"
#include "MDProcess/Security/impl/SecurityImpl/AuthenticatorImpl_factory.h"

namespace Security {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4614DE64033C_ENVIRONMENTS_CONFIG*
	//#UC END# *4614DE64033C_ENVIRONMENTS_CONFIG*

	{
		SecurityImpl::AuthenticatorImpl_factory_var fctr = new SecurityImpl::AuthenticatorImpl_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace Security

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
