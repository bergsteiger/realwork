////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/SecurityComm/SecurityComm.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::SecurityComm
//
// коммуникационные локальные интерфейсы и типы ддля подсистемы Безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"
#include "shared/CoreSrv/SecurityComm/SecurityCommFactories.h"

namespace CoreSrv {

// factory interface wrapper for Authenticator
Authenticator& AuthenticatorFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return AuthenticatorFactoryManager::Singleton::instance ()->get ();
}

} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

