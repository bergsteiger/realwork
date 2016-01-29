////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/FilePublish/FilePublishFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::FilePublishLib::FilePublish
//
// публикация файла как результата теста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublishFactories.h"

namespace FilePublishLib {
namespace FilePublish {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PlainTextPublish
bool PlainTextPublishFactoryManager::s_was_destroyed = false;

PlainTextPublishFactoryManager::PlainTextPublishFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PlainTextPublishFactoryManager::~PlainTextPublishFactoryManager () {
	s_was_destroyed = true;
}

void PlainTextPublishFactoryManager::register_factory (
	PlainTextPublishAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PlainTextPublishFactoryManager::register_factory_i (
	PlainTextPublishAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"FilePublishLib::FilePublish::PlainTextPublishFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PlainTextPublishAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PlainTextPublishAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PlainTextPublish* PlainTextPublishFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("FilePublishLib::FilePublish::PlainTextPublishFactory");
	}
	PlainTextPublish* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("FilePublishLib::FilePublish::PlainTextPublishFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PlainText2FunctionalTest
bool PlainText2FunctionalTestFactoryManager::s_was_destroyed = false;

PlainText2FunctionalTestFactoryManager::PlainText2FunctionalTestFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PlainText2FunctionalTestFactoryManager::~PlainText2FunctionalTestFactoryManager () {
	s_was_destroyed = true;
}

void PlainText2FunctionalTestFactoryManager::register_factory (
	PlainText2FunctionalTestAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PlainText2FunctionalTestFactoryManager::register_factory_i (
	PlainText2FunctionalTestAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"FilePublishLib::FilePublish::PlainText2FunctionalTestFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PlainText2FunctionalTestAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PlainText2FunctionalTestAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PlainText2FunctionalTest& PlainText2FunctionalTestFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("FilePublishLib::FilePublish::PlainText2FunctionalTestFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("FilePublishLib::FilePublish::PlainText2FunctionalTestFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace FilePublish
} // namespace FilePublishLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

