////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Profile/Profile.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Profile
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/Profile.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/ProfileFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for StopWatch
StopWatch* StopWatchFactory::make (
	const char* context
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StopWatchFactoryManager::Singleton::instance ()->make (context);
}

// factory interface wrapper for StopWatchEx
StopWatchEx* StopWatchExFactory::make (
	const char* id
	, const char* context
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StopWatchExFactoryManager::Singleton::instance ()->make (id, context);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

