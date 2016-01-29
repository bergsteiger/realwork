////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Security/Security.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::Security
//
// сервисные локальные интерфейсы подсистемы безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Security/Security.h"
#include "shared/CoreSrv/Security/SecurityFactories.h"

namespace CoreSrv {

// factory interface wrapper for Session
Session& SessionFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SessionFactoryManager::Singleton::instance ()->get ();
}

} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

