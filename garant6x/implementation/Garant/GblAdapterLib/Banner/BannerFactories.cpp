////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Banner/BannerFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// Баннеры
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/BannerFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Banner
bool BannerFactoryManager::s_was_destroyed = false;

BannerFactoryManager::BannerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BannerFactoryManager::~BannerFactoryManager () {
	s_was_destroyed = true;
}

void BannerFactoryManager::register_factory (
	BannerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BannerFactoryManager::register_factory_i (
	BannerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Banner::BannerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BannerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BannerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Banner* BannerFactoryManager::make () /*throw (Core::Root::NoActiveFactory, CanNotFindData)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Banner::BannerFactory");
	}
	Banner* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Banner::BannerFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

