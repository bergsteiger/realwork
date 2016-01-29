////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Contents/ContentsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Contents
//
// базовые ответственности связанные с работой с контентом в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Contents/ContentsFactories.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace Contents {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for KPage
bool KPageFactoryManager::s_was_destroyed = false;

KPageFactoryManager::KPageFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

KPageFactoryManager::~KPageFactoryManager () {
	s_was_destroyed = true;
}

void KPageFactoryManager::register_factory (
	KPageAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void KPageFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		KPageFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ServerGate::Contents::KPage");
	}
}

void KPageFactoryManager::register_factory_i (
	KPageAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ServerGate::Contents::KPageFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = KPageAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = KPageAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

KPage* KPageFactoryManager::create (const char* name, KPage* parent) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, CantCreatePage, PermissionException) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ServerGate::Contents::KPageFactory");
	}
	KPage* ret_ = m_single_active_factory->create (name, parent);
	GDS_ASSERT_MSG (ret_ != 0, ("ServerGate::Contents::KPageFactory impl can't return zerro"));
	return ret_;
}

KPage* KPageFactoryManager::get (PageId page_id) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound) {
	GUARD(m_mutex_for_get);
	CachedObjectsForGet::iterator f = m_cached_objects_for_get.find (ObjectCreationIdForGet(page_id));
	if (f == m_cached_objects_for_get.end()) {
		if (m_single_active_factory.is_nil()) {
			throw Core::Root::NoActiveFactory ("ServerGate::Contents::KPageFactory");
		}
		f = m_cached_objects_for_get.insert (
			CachedObjectsForGet::value_type(
				ObjectCreationIdForGet(page_id)
				, m_single_active_factory->get (page_id)
			)
		).first;
		m_cached_objects_index_for_get.insert (
			CachedObjectsIndexForGet::value_type (
				f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("ServerGate::Contents::KPageFactory impl can't return zerro"));
	return KPage::_duplicate(f->second.in ());
}

KPage* KPageFactoryManager::get_by_name_and_space (const char* name, const char* spacekey) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ServerGate::Contents::KPageFactory");
	}
	KPage* ret_ = m_single_active_factory->get_by_name_and_space (name, spacekey);
	GDS_ASSERT_MSG (ret_ != 0, ("ServerGate::Contents::KPageFactory impl can't return zerro"));
	return ret_;
}

KPage* KPageFactoryManager::get_by_model_element_guid (const char* guid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ServerGate::Contents::KPageFactory");
	}
	KPage* ret_ = m_single_active_factory->get_by_model_element_guid (guid);
	GDS_ASSERT_MSG (ret_ != 0, ("ServerGate::Contents::KPageFactory impl can't return zerro"));
	return ret_;
}

void KPageFactoryManager::free (KPage* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	Singleton::instance ()->free_i (obj_);
}

void KPageFactoryManager::free_i (KPage* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
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
// implementation of factory manager methods for Request
bool RequestFactoryManager::s_was_destroyed = false;

RequestFactoryManager::RequestFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

RequestFactoryManager::~RequestFactoryManager () {
	s_was_destroyed = true;
}

void RequestFactoryManager::register_factory (
	RequestAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void RequestFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		RequestFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ServerGate::Contents::Request");
	}
}

void RequestFactoryManager::register_factory_i (
	RequestAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ServerGate::Contents::RequestFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = RequestAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = RequestAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Request* RequestFactoryManager::get_by_name_and_space (const char* name, const char* spacekey) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound, PermissionException, PageIsNotRequest) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ServerGate::Contents::RequestFactory");
	}
	Request* ret_ = m_single_active_factory->get_by_name_and_space (name, spacekey);
	GDS_ASSERT_MSG (ret_ != 0, ("ServerGate::Contents::RequestFactory impl can't return zerro"));
	return ret_;
}

Request* RequestFactoryManager::get (PageId page_id) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound, PermissionException, PageIsNotRequest) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ServerGate::Contents::RequestFactory");
	}
	Request* ret_ = m_single_active_factory->get (page_id);
	GDS_ASSERT_MSG (ret_ != 0, ("ServerGate::Contents::RequestFactory impl can't return zerro"));
	return ret_;
}

Request* RequestFactoryManager::create (RequestType type, RequestImportance importance, const char* name, KPage* parent) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, CantCreatePage, PermissionException) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ServerGate::Contents::RequestFactory");
	}
	Request* ret_ = m_single_active_factory->create (type, importance, name, parent);
	GDS_ASSERT_MSG (ret_ != 0, ("ServerGate::Contents::RequestFactory impl can't return zerro"));
	return ret_;
}
} // namespace Contents
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

