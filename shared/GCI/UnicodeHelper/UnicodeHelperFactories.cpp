////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/UnicodeHelper/UnicodeHelperFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::UnicodeHelper
//
// вспомогательные интерфейсы для работы с Unicode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "boost/lexical_cast.hpp"
#include "boost/bind.hpp"
#include "shared/GCI/UnicodeHelper/UnicodeHelperFactories.h"

//#UC START# *4869FD4C0050_CUSTOM_INCLUDES_FOR_TRANSPARENT_MULTI_FACTORY*
#include "shared/GCI/I18N/I18N.h"
//#UC END# *4869FD4C0050_CUSTOM_INCLUDES_FOR_TRANSPARENT_MULTI_FACTORY*

namespace GCI {
namespace UnicodeHelper {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ConverterHelper
bool ConverterHelperFactoryManager::s_was_destroyed = false;

ConverterHelperFactoryManager::ConverterHelperFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ConverterHelperFactoryManager::~ConverterHelperFactoryManager () {
	s_was_destroyed = true;
}

void ConverterHelperFactoryManager::register_factory (
	ConverterHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

ConverterHelperFactory::KeySet* ConverterHelperFactoryManager::keys () {
	Core::Aptr<ConverterHelperFactory::KeySet> keys (new ConverterHelperFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void ConverterHelperFactoryManager::register_factory_i (
	ConverterHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::UnicodeHelper::ConverterHelperFactory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ConverterHelperAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ConverterHelperAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ConverterHelper* ConverterHelperFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	Core::Var<ConverterHelperAbstractFactory> factory;
	//#UC START# *486A077002FA_CUSTOM_SELECT_FACTORY*
	GCI::I18N::SupportedLocales key = GCI::I18N::SL_UNKNOWN;
	switch (I18N::LocaleOperationsFactory::make ().get_locale ()) {
		case GCI::I18N::SL_TATAR : key = GCI::I18N::SL_TATAR;   break;
		default                  : key = GCI::I18N::SL_UNKNOWN;
	}
	
	FactoryMap::iterator it = m_factories_map.find (key);
	if (it == m_factories_map.end ()) {
		throw Core::Root::NoActiveFactory (
			("GCI::UnicodeHelper::ConverterHelperFactory for key" + boost::lexical_cast<std::string> (key)).c_str ()
		);
	}
	
	factory = it->second.factory;
	//#UC END# *486A077002FA_CUSTOM_SELECT_FACTORY*
	if (factory.is_nil () == true) {
		throw Core::Root::NoActiveFactory ("GCI::UnicodeHelper::ConverterHelperFactory");
	}
	
	return factory->make ();
}
} // namespace UnicodeHelper
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

