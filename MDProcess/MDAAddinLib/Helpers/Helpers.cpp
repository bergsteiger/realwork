////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/Helpers/Helpers.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Helpers
//
// набор вспомогательных интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"

namespace Helpers {

// factory interface wrapper for StereotypeManager
StereotypeManager* StereotypeManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StereotypeManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for KViewElement
KViewElement& KViewElementFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return KViewElementFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for ReportBuilder
ReportBuilder* ReportBuilderFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ReportBuilderFactoryManager::Singleton::instance ()->make ();
}

} // namespace Helpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

