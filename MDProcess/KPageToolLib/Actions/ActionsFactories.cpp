////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/Actions/ActionsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::KPageToolLib::Actions
//
// Пакет доступных действий со страницей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/lexical_cast.hpp"
#include "boost/bind.hpp"
#include "MDProcess/KPageToolLib/Actions/ActionsFactories.h"

namespace KPageToolLib {
namespace Actions {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for KPageAction
bool KPageActionFactoryManager::s_was_destroyed = false;

KPageActionFactoryManager::KPageActionFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

KPageActionFactoryManager::~KPageActionFactoryManager () {
	s_was_destroyed = true;
}

void KPageActionFactoryManager::register_factory (
	KPageActionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

KPageActionFactory::KeySet* KPageActionFactoryManager::keys () {
	Core::Aptr<KPageActionFactory::KeySet> keys (new KPageActionFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void KPageActionFactoryManager::register_factory_i (
	KPageActionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"KPageToolLib::Actions::KPageActionFactory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = KPageActionAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = KPageActionAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

KPageAction& KPageActionFactoryManager::get (PageActionsEnum key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	GUARD(m_mutex_for_get);
	CachedObjectsForGet::iterator f = m_cached_objects_for_get.find (ObjectCreationIdForGet(key));
	if (f == m_cached_objects_for_get.end()) {
		FactoryMap::iterator f_fct = m_factories_map.find (key);
		if (f_fct == m_factories_map.end()) {
			throw Core::Root::UnknownFactoryKey (
				"KPageToolLib::Actions::KPageActionFactory"
				, boost::lexical_cast<std::string> (key).c_str ()
			);
		}
		f = m_cached_objects_for_get.insert (
			CachedObjectsForGet::value_type(
				ObjectCreationIdForGet(key)
				, f_fct->second.factory->get ()
			)
		).first;
		m_cached_objects_index_for_get.insert (
			CachedObjectsIndexForGet::value_type (
				f->second.in()
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("KPageToolLib::Actions::KPageActionFactory impl can't return zerro"));
	return *f->second;
}
} // namespace Actions
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

