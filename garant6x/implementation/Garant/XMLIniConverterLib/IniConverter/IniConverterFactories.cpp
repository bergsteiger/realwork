////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverterFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::XMLIniConverterLib::IniConverter
//
// интерфейсы для конвертации ini-файлов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "boost/bind.hpp"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverterFactories.h"

namespace XMLIniConverterLib {
namespace IniConverter {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Parameter
bool ParameterFactoryManager::s_was_destroyed = false;

ParameterFactoryManager::ParameterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ParameterFactoryManager::~ParameterFactoryManager () {
	s_was_destroyed = true;
}

void ParameterFactoryManager::register_factory (
	ParameterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ParameterFactoryManager::register_factory_i (
	ParameterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"XMLIniConverterLib::IniConverter::ParameterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ParameterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ParameterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Parameter* ParameterFactoryManager::make (const char* name, const char* value, ParameterState state, const char* delimiter) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("XMLIniConverterLib::IniConverter::ParameterFactory");
	}
	Parameter* ret_ = m_single_active_factory->make (name, value, state, delimiter);
	GDS_ASSERT_MSG (ret_ != 0, ("XMLIniConverterLib::IniConverter::ParameterFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Section
bool SectionFactoryManager::s_was_destroyed = false;

SectionFactoryManager::SectionFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SectionFactoryManager::~SectionFactoryManager () {
	s_was_destroyed = true;
}

void SectionFactoryManager::register_factory (
	SectionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SectionFactoryManager::register_factory_i (
	SectionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"XMLIniConverterLib::IniConverter::SectionFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SectionAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SectionAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Section* SectionFactoryManager::make (const char* name) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("XMLIniConverterLib::IniConverter::SectionFactory");
	}
	Section* ret_ = m_single_active_factory->make (name);
	GDS_ASSERT_MSG (ret_ != 0, ("XMLIniConverterLib::IniConverter::SectionFactory impl can't return zerro"));
	return ret_;
}

Section* SectionFactoryManager::make (const char* name, ParameterState state) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("XMLIniConverterLib::IniConverter::SectionFactory");
	}
	Section* ret_ = m_single_active_factory->make (name, state);
	GDS_ASSERT_MSG (ret_ != 0, ("XMLIniConverterLib::IniConverter::SectionFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IniFile
bool IniFileFactoryManager::s_was_destroyed = false;

IniFileFactoryManager::IniFileFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IniFileFactoryManager::~IniFileFactoryManager () {
	s_was_destroyed = true;
}

void IniFileFactoryManager::register_factory (
	IniFileAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IniFileFactoryManager::register_factory_i (
	IniFileAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"XMLIniConverterLib::IniConverter::IniFileFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IniFileAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IniFileAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IniFile* IniFileFactoryManager::make (const char* filename) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("XMLIniConverterLib::IniConverter::IniFileFactory");
	}
	IniFile* ret_ = m_single_active_factory->make (filename);
	GDS_ASSERT_MSG (ret_ != 0, ("XMLIniConverterLib::IniConverter::IniFileFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Rule
bool RuleFactoryManager::s_was_destroyed = false;

RuleFactoryManager::RuleFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

RuleFactoryManager::~RuleFactoryManager () {
	s_was_destroyed = true;
}

void RuleFactoryManager::register_factory (
	RuleAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

RuleFactory::KeySet* RuleFactoryManager::keys () {
	Core::Aptr<RuleFactory::KeySet> keys (new RuleFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void RuleFactoryManager::register_factory_i (
	RuleAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"XMLIniConverterLib::IniConverter::RuleFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = RuleAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = RuleAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Rule* RuleFactoryManager::make (XercesHelpers::DOMNodeEx& rule_node, const char* key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"XMLIniConverterLib::IniConverter::RuleFactory"
			, key
		);
	}
	return f->second.factory->make (rule_node);
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for RulesManager
bool RulesManagerFactoryManager::s_was_destroyed = false;

RulesManagerFactoryManager::RulesManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

RulesManagerFactoryManager::~RulesManagerFactoryManager () {
	s_was_destroyed = true;
}

void RulesManagerFactoryManager::register_factory (
	RulesManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void RulesManagerFactoryManager::register_factory_i (
	RulesManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"XMLIniConverterLib::IniConverter::RulesManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = RulesManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = RulesManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

RulesManager* RulesManagerFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("XMLIniConverterLib::IniConverter::RulesManagerFactory");
	}
	RulesManager* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("XMLIniConverterLib::IniConverter::RulesManagerFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for XMLRuleParser
bool XMLRuleParserFactoryManager::s_was_destroyed = false;

XMLRuleParserFactoryManager::XMLRuleParserFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

XMLRuleParserFactoryManager::~XMLRuleParserFactoryManager () {
	s_was_destroyed = true;
}

void XMLRuleParserFactoryManager::register_factory (
	XMLRuleParserAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

XMLRuleParserFactory::KeySet* XMLRuleParserFactoryManager::keys () {
	Core::Aptr<XMLRuleParserFactory::KeySet> keys (new XMLRuleParserFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void XMLRuleParserFactoryManager::register_factory_i (
	XMLRuleParserAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"XMLIniConverterLib::IniConverter::XMLRuleParserFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = XMLRuleParserAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = XMLRuleParserAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

XMLRuleParser* XMLRuleParserFactoryManager::make (RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node, const char* key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"XMLIniConverterLib::IniConverter::XMLRuleParserFactory"
			, key
		);
	}
	return f->second.factory->make (manager, rule_node);
}
} // namespace IniConverter
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

