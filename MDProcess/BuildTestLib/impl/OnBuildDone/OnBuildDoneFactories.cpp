////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDoneFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::BuildTestLib::OnBuildDone
//
// имлементация того что надо сделать по событию окончания сборки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDoneFactories.h"

namespace BuildTestLib {
namespace OnBuildDone {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for LocalPageLogin
bool LocalPageLoginFactoryManager::s_was_destroyed = false;

LocalPageLoginFactoryManager::LocalPageLoginFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

LocalPageLoginFactoryManager::~LocalPageLoginFactoryManager () {
	s_was_destroyed = true;
}

void LocalPageLoginFactoryManager::register_factory (
	LocalPageLoginAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	
}

void LocalPageLoginFactoryManager::register_factory_i (
	LocalPageLoginAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BuildTestLib::OnBuildDone::LocalPageLoginFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = LocalPageLoginAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = LocalPageLoginAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

LocalPageLogin* LocalPageLoginFactoryManager::make (const std::string& login, const std::string& passwd, ServerGate::Contents::PageId page_id) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("BuildTestLib::OnBuildDone::LocalPageLoginFactory");
	}
	LocalPageLogin* ret_ = m_single_active_factory->make (login, passwd, page_id);
	GDS_ASSERT_MSG (ret_ != 0, ("BuildTestLib::OnBuildDone::LocalPageLoginFactory impl can't return zerro"));
	return ret_;
}
} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

