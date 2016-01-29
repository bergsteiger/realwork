////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/LinkSupport/ConfModelLinks/ConfModelLinksFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::LinkSupport::ConfModelLinks
//
// пакет, обеспечивающий переход из Конфлюенса в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinksFactories.h"
#include "MDProcess/LinkSupport/LibHome.h"

namespace LinkSupport {
namespace ConfModelLinks {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ShowOnModelMng
bool ShowOnModelMngFactoryManager::s_was_destroyed = false;

ShowOnModelMngFactoryManager::ShowOnModelMngFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ShowOnModelMngFactoryManager::~ShowOnModelMngFactoryManager () {
	s_was_destroyed = true;
}

void ShowOnModelMngFactoryManager::register_factory (
	ShowOnModelMngAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ShowOnModelMngFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		ShowOnModelMngFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "LinkSupport::ConfModelLinks::ShowOnModelMng");
	}
}

void ShowOnModelMngFactoryManager::register_factory_i (
	ShowOnModelMngAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"LinkSupport::ConfModelLinks::ShowOnModelMngFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ShowOnModelMngAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ShowOnModelMngAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ShowOnModelMng* ShowOnModelMngFactoryManager::get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("LinkSupport::ConfModelLinks::ShowOnModelMngFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("LinkSupport::ConfModelLinks::ShowOnModelMngFactory impl can't return zerro"));
		}
	}
	return ShowOnModelMng::_duplicate(m_cached_object_for_get.in ());
}
} // namespace ConfModelLinks
} // namespace LinkSupport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

