////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/Math/MathFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::Math
//
// Пакет интерфейсов связанных с математическими выичслениями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/Math/MathFactories.h"

namespace GCI {
namespace Math {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Calculator
bool CalculatorFactoryManager::s_was_destroyed = false;

CalculatorFactoryManager::CalculatorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CalculatorFactoryManager::~CalculatorFactoryManager () {
	s_was_destroyed = true;
}

void CalculatorFactoryManager::register_factory (
	CalculatorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CalculatorFactoryManager::register_factory_i (
	CalculatorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::Math::CalculatorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CalculatorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CalculatorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Calculator& CalculatorFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_make.ptr() == 0) {
		GUARD(m_mutex_for_make);
		if (m_cached_object_for_make.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GCI::Math::CalculatorFactory");
			}
			m_cached_object_for_make = m_single_active_factory->make ();
		
			GDS_ASSERT_MSG (m_cached_object_for_make.ptr() != 0, ("GCI::Math::CalculatorFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_make;
}
} // namespace Math
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

