////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/GenerationContents/GenerationContentsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::GenerationContents
//
// все ответственности связанные с генерацией в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContentsFactories.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace GenerationContents {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Page
bool PageFactoryManager::s_was_destroyed = false;

PageFactoryManager::PageFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PageFactoryManager::~PageFactoryManager () {
	s_was_destroyed = true;
}

void PageFactoryManager::register_factory (
	PageAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

PageFactoryKeySet* PageFactoryManager::keys () throw (CORBA::SystemException) {
	PageFactoryKeySet_var list (new PageFactoryKeySet (m_factories_map.size ()));
	size_t i = 0;
	for (FactoryMap::iterator it = m_factories_map.begin (); it != m_factories_map.end (); ++it) {
		(*list)[i++] = it->first.c_str ();
	}
	
	return list._retn ();
}

void PageFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		PageFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ServerGate::GenerationContents::Page");
	}
}

void PageFactoryManager::register_factory_i (
	PageAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ServerGate::GenerationContents::PageFactory"
			, factory->key().c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PageAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PageAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Page* PageFactoryManager::get (ModelElementId_const guid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	GUARD(m_mutex_for_get);
	CachedObjectsForGet::iterator f = m_cached_objects_for_get.find (ObjectCreationIdForGet(guid));
	if (f == m_cached_objects_for_get.end()) {
		Core::Var<PageAbstractFactory> factory;
		//#UC START# *4623887901B5_CUSTOM_SELECT_FACTORY*
		FactoryMap::const_iterator f_it = m_factories_map.find ("Page");
		if (f_it != m_factories_map.end ()) {
			factory = f_it->second.factory;
		}
		//#UC END# *4623887901B5_CUSTOM_SELECT_FACTORY*
		if (factory.is_nil () == true) {
			throw CoreSrv::NoActiveFactory ();
		}
		f = m_cached_objects_for_get.insert (
			CachedObjectsForGet::value_type(
				ObjectCreationIdForGet(guid)
				, factory->get (guid)
			)
		).first;
		m_cached_objects_index_for_get.insert (
			CachedObjectsIndexForGet::value_type (
				f->second->_hash (std::numeric_limits<CORBA::ULong>::max ()), f
			)
		);
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("ServerGate::GenerationContents::PageFactory impl can't return zerro"));
	return Page::_duplicate(f->second.in());
}

void PageFactoryManager::remove (Page* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	Singleton::instance ()->remove_i (obj_);
}

void PageFactoryManager::remove_i (Page* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	{
		CORBA::ULong obj_hash = obj_->_hash (std::numeric_limits<CORBA::ULong>::max ());
		
		{
			GUARD(m_mutex_for_get);

			CachedObjectsIndexForGet::iterator it = m_cached_objects_index_for_get.find (obj_hash);
			if (it != m_cached_objects_index_for_get.end ()) {
				m_cached_objects_for_get.erase (it->second);
				m_cached_objects_index_for_get.erase (it);
			}
		}
	
	}
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for GenerationManager
bool GenerationManagerFactoryManager::s_was_destroyed = false;

GenerationManagerFactoryManager::GenerationManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

GenerationManagerFactoryManager::~GenerationManagerFactoryManager () {
	s_was_destroyed = true;
}

void GenerationManagerFactoryManager::register_factory (
	GenerationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void GenerationManagerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		GenerationManagerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ServerGate::GenerationContents::GenerationManager");
	}
}

void GenerationManagerFactoryManager::register_factory_i (
	GenerationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ServerGate::GenerationContents::GenerationManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = GenerationManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = GenerationManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

GenerationManager* GenerationManagerFactoryManager::get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("ServerGate::GenerationContents::GenerationManagerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("ServerGate::GenerationContents::GenerationManagerFactory impl can't return zerro"));
		}
	}
	return GenerationManager::_duplicate(m_cached_object_for_get.in ());
}
} // namespace GenerationContents
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

