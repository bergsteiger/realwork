////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ArchiGate::DocCardRemote
//
// для работы с гардоком
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"
#include "MDProcess/ArchiGate/LibHome.h"

namespace ArchiGate {
namespace DocCardRemote {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for BigFileIterator
bool BigFileIteratorFactoryManager::s_was_destroyed = false;

BigFileIteratorFactoryManager::BigFileIteratorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BigFileIteratorFactoryManager::~BigFileIteratorFactoryManager () {
	s_was_destroyed = true;
}

void BigFileIteratorFactoryManager::register_factory (
	BigFileIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BigFileIteratorFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		BigFileIteratorFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ArchiGate::DocCardRemote::BigFileIterator");
	}
}

void BigFileIteratorFactoryManager::register_factory_i (
	BigFileIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiGate::DocCardRemote::BigFileIteratorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BigFileIteratorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BigFileIteratorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

BigFileIterator* BigFileIteratorFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiGate::DocCardRemote::BigFileIteratorFactory");
	}
	BigFileIterator* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiGate::DocCardRemote::BigFileIteratorFactory impl can't return zerro"));
	return ret_;
}

void BigFileIteratorFactoryManager::destroy (BigFileIterator* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	Singleton::instance ()->destroy_i (obj_);
}

void BigFileIteratorFactoryManager::destroy_i (BigFileIterator* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	{
		
	}
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ArchiEventsListener
bool ArchiEventsListenerFactoryManager::s_was_destroyed = false;

ArchiEventsListenerFactoryManager::ArchiEventsListenerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ArchiEventsListenerFactoryManager::~ArchiEventsListenerFactoryManager () {
	s_was_destroyed = true;
}

void ArchiEventsListenerFactoryManager::register_factory (
	ArchiEventsListenerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ArchiEventsListenerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		ArchiEventsListenerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ArchiGate::DocCardRemote::ArchiEventsListener");
	}
}

void ArchiEventsListenerFactoryManager::register_factory_i (
	ArchiEventsListenerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiGate::DocCardRemote::ArchiEventsListenerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ArchiEventsListenerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ArchiEventsListenerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ArchiEventsListener* ArchiEventsListenerFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiGate::DocCardRemote::ArchiEventsListenerFactory");
	}
	ArchiEventsListener* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiGate::DocCardRemote::ArchiEventsListenerFactory impl can't return zerro"));
	return ret_;
}

void ArchiEventsListenerFactoryManager::release (ArchiEventsListener* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	Singleton::instance ()->release_i (obj_);
}

void ArchiEventsListenerFactoryManager::release_i (ArchiEventsListener* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	{
		
	}
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Searcher2
bool Searcher2FactoryManager::s_was_destroyed = false;

Searcher2FactoryManager::Searcher2FactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

Searcher2FactoryManager::~Searcher2FactoryManager () {
	s_was_destroyed = true;
}

void Searcher2FactoryManager::register_factory (
	Searcher2AbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void Searcher2FactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		Searcher2FactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ArchiGate::DocCardRemote::Searcher2");
	}
}

void Searcher2FactoryManager::register_factory_i (
	Searcher2AbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiGate::DocCardRemote::Searcher2Factory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = Searcher2AbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = Searcher2AbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Searcher2* Searcher2FactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiGate::DocCardRemote::Searcher2Factory");
	}
	Searcher2* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiGate::DocCardRemote::Searcher2Factory impl can't return zerro"));
	return ret_;
}

void Searcher2FactoryManager::release (Searcher2* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	Singleton::instance ()->release_i (obj_);
}

void Searcher2FactoryManager::release_i (Searcher2* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	{
		
	}
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Utils
bool UtilsFactoryManager::s_was_destroyed = false;

UtilsFactoryManager::UtilsFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

UtilsFactoryManager::~UtilsFactoryManager () {
	s_was_destroyed = true;
}

void UtilsFactoryManager::register_factory (
	UtilsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void UtilsFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		UtilsFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ArchiGate::DocCardRemote::Utils");
	}
}

void UtilsFactoryManager::register_factory_i (
	UtilsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiGate::DocCardRemote::UtilsFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = UtilsAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = UtilsAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Utils* UtilsFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiGate::DocCardRemote::UtilsFactory");
	}
	Utils* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiGate::DocCardRemote::UtilsFactory impl can't return zerro"));
	return ret_;
}

void UtilsFactoryManager::release (Utils* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	Singleton::instance ()->release_i (obj_);
}

void UtilsFactoryManager::release_i (Utils* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	{
		
	}
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for GardocGetter
bool GardocGetterFactoryManager::s_was_destroyed = false;

GardocGetterFactoryManager::GardocGetterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

GardocGetterFactoryManager::~GardocGetterFactoryManager () {
	s_was_destroyed = true;
}

void GardocGetterFactoryManager::register_factory (
	GardocGetterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void GardocGetterFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		GardocGetterFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ArchiGate::DocCardRemote::GardocGetter");
	}
}

void GardocGetterFactoryManager::register_factory_i (
	GardocGetterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiGate::DocCardRemote::GardocGetterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = GardocGetterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = GardocGetterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

GardocGetter* GardocGetterFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiGate::DocCardRemote::GardocGetterFactory");
	}
	GardocGetter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiGate::DocCardRemote::GardocGetterFactory impl can't return zerro"));
	return ret_;
}

void GardocGetterFactoryManager::release (GardocGetter* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	Singleton::instance ()->release_i (obj_);
}

void GardocGetterFactoryManager::release_i (GardocGetter* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	{
		
	}
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Searcher
bool SearcherFactoryManager::s_was_destroyed = false;

SearcherFactoryManager::SearcherFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SearcherFactoryManager::~SearcherFactoryManager () {
	s_was_destroyed = true;
}

void SearcherFactoryManager::register_factory (
	SearcherAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SearcherFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		SearcherFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ArchiGate::DocCardRemote::Searcher");
	}
}

void SearcherFactoryManager::register_factory_i (
	SearcherAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiGate::DocCardRemote::SearcherFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SearcherAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SearcherAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Searcher* SearcherFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiGate::DocCardRemote::SearcherFactory");
	}
	Searcher* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiGate::DocCardRemote::SearcherFactory impl can't return zerro"));
	return ret_;
}

void SearcherFactoryManager::release (Searcher* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	Singleton::instance ()->release_i (obj_);
}

void SearcherFactoryManager::release_i (Searcher* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	{
		
	}
}
} // namespace DocCardRemote
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

