////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ComplectInfo/ComplectInfoFactories.cpp"
// C++ Interface Factories implementation files (.cpp)
// Generated from UML model, root element: <<Interface::Category>> garant6x::GblAdapterLib::ComplectInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ComplectInfo/ComplectInfoFactories.h"

namespace GblAdapterLib {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ComplectInfo

ComplectInfoFactoryManager::ComplectInfoFactoryManager () : m_has_registred_factories(false) {
}

void ComplectInfoFactoryManager::register_factory (ComplectInfoAbstractFactory* factory) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	Singleton::instance()->register_factory_i (factory);
}

void ComplectInfoFactoryManager::register_factory_i (ComplectInfoAbstractFactory* factory) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	if (m_factories_map.find(factory->key()) != m_factories_map.end()) {
		throw Core::Root::DuplicatedFactoryKey ("GblAdapterLib::ComplectInfo::ComplectInfoFactory", factory->key());
	}
	m_factories_map[factory->key()] = ComplectInfoAbstractFactory::_duplicate(factory);
	m_single_active_factory = ComplectInfoAbstractFactory::_duplicate(factory);
}

ComplectInfo* ComplectInfoFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::ComplectInfo::ComplectInfoFactory");
	}
	return m_single_active_factory->make ();
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

