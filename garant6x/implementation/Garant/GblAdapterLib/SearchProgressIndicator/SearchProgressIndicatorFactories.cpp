////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicatorFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::SearchProgressIndicator
//
// Прогрессиндикаторы для поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicatorFactories.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for CancelSearch
bool CancelSearchFactoryManager::s_was_destroyed = false;

CancelSearchFactoryManager::CancelSearchFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CancelSearchFactoryManager::~CancelSearchFactoryManager () {
	s_was_destroyed = true;
}

void CancelSearchFactoryManager::register_factory (
	CancelSearchAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CancelSearchFactoryManager::register_factory_i (
	CancelSearchAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::SearchProgressIndicator::CancelSearchFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CancelSearchAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CancelSearchAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

CancelSearch* CancelSearchFactoryManager::make (GblPilot::SearchManager* search_manager) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::SearchProgressIndicator::CancelSearchFactory");
	}
	CancelSearch* ret_ = m_single_active_factory->make (search_manager);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::SearchProgressIndicator::CancelSearchFactory impl can't return zerro"));
	return ret_;
}
} // namespace SearchProgressIndicator
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

