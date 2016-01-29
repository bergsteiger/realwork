////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObjectFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for ExternalLink
ExternalLink* ExternalLinkFactory::make (
	const char* url
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ExternalLinkFactoryManager::Singleton::instance ()->make (url);
}

// factory interface wrapper for ExternalObject
ExternalObject* ExternalObjectFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ExternalObjectFactoryManager::Singleton::instance ()->make ();
}

ExternalObject* ExternalObjectFactory::make (
	GblPilot::InternalObj* obj
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ExternalObjectFactoryManager::Singleton::instance ()->make (obj);
}

// factory interface wrapper for SplashScreen
SplashScreen* SplashScreenFactory::make (
	bool is_start
	, short x
	, short y
	, bool flash_available
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, CanNotFindData)*/ {
	return SplashScreenFactoryManager::Singleton::instance ()->make (is_start, x, y, flash_available);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

