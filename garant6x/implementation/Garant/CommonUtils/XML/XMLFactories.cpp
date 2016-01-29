////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/CommonUtils/XML/XMLFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::CommonUtils::XML
//
// Интерфейс для чтения XML от внешних систем.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/CommonUtils/XML/XMLFactories.h"

namespace CommonUtils {
namespace XML {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for XMLReader
bool XMLReaderFactoryManager::s_was_destroyed = false;

XMLReaderFactoryManager::XMLReaderFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

XMLReaderFactoryManager::~XMLReaderFactoryManager () {
	s_was_destroyed = true;
}

void XMLReaderFactoryManager::register_factory (
	XMLReaderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void XMLReaderFactoryManager::register_factory_i (
	XMLReaderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"CommonUtils::XML::XMLReaderFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = XMLReaderAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = XMLReaderAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

XMLReader* XMLReaderFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("CommonUtils::XML::XMLReaderFactory");
	}
	XMLReader* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("CommonUtils::XML::XMLReaderFactory impl can't return zerro"));
	return ret_;
}
} // namespace XML
} // namespace CommonUtils

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

