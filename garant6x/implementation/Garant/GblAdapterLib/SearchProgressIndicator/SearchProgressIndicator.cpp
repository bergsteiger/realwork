////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::SearchProgressIndicator
//
// Прогрессиндикаторы для поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicatorFactories.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator {

// factory interface wrapper for CancelSearch
CancelSearch* CancelSearchFactory::make (
	GblPilot::SearchManager* search_manager
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CancelSearchFactoryManager::Singleton::instance ()->make (search_manager);
}

} // namespace SearchProgressIndicator
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

