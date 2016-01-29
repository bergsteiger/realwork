////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/TestPublish/TestPublishFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::BuildTestLib::TestPublish
//
// стандартная публикация результатов тестов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublishFactories.h"
#include "MDProcess/BuildTestLib/LibHome.h"

namespace BuildTestLib {
namespace TestPublish {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Publish
bool PublishFactoryManager::s_was_destroyed = false;

PublishFactoryManager::PublishFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PublishFactoryManager::~PublishFactoryManager () {
	s_was_destroyed = true;
}

void PublishFactoryManager::register_factory (
	PublishAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PublishFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		PublishFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "BuildTestLib::TestPublish::Publish");
	}
}

void PublishFactoryManager::register_factory_i (
	PublishAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BuildTestLib::TestPublish::PublishFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PublishAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PublishAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Publish* PublishFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("BuildTestLib::TestPublish::PublishFactory");
	}
	Publish* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("BuildTestLib::TestPublish::PublishFactory impl can't return zerro"));
	return ret_;
}
} // namespace TestPublish
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

