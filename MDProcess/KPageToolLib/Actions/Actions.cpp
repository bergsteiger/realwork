////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/Actions/Actions.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::KPageToolLib::Actions
//
// Пакет доступных действий со страницей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"
#include "MDProcess/KPageToolLib/Actions/ActionsFactories.h"

namespace KPageToolLib {
namespace Actions {

// factory interface wrapper for KPageAction
KPageAction& KPageActionFactory::get (PageActionsEnum key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return KPageActionFactoryManager::Singleton::instance ()->get (key);
}


KPageActionFactory::KeySet* KPageActionFactory::keys () {
	return KPageActionFactoryManager::keys ();
}

} // namespace Actions
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

