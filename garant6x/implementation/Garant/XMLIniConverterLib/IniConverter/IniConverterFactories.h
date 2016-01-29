////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverterFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::XMLIniConverterLib::IniConverter
//
// интерфейсы для конвертации ini-файлов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_FCTR_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

namespace XMLIniConverterLib {
namespace IniConverter {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Parameter

class ParameterAbstractFactory;

/// factory manager for Parameter
class ParameterFactoryManager {
public:
	static void register_factory (ParameterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ParameterFactoryManager ();
	
	~ParameterFactoryManager ();
	
	void register_factory_i (ParameterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Parameter* make (
		const char* name
		, const char* value
		, ParameterState state
		, const char* delimiter
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ParameterFactory;
	typedef ACE_Singleton <ParameterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ParameterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ParameterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ParameterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Parameter
class ParameterAbstractFactory : virtual public Core::IObject {
	friend class ParameterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Parameter* make (const char* name, const char* value, ParameterState state, const char* delimiter) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Section

class SectionAbstractFactory;

/// factory manager for Section
class SectionFactoryManager {
public:
	static void register_factory (SectionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SectionFactoryManager ();
	
	~SectionFactoryManager ();
	
	void register_factory_i (SectionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Section* make (const char* name) /*throw (Core::Root::NoActiveFactory)*/;

	Section* make (const char* name, ParameterState state) /*throw (Core::Root::NoActiveFactory)*/;

	friend class SectionFactory;
	typedef ACE_Singleton <SectionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SectionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SectionAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SectionAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Section
class SectionAbstractFactory : virtual public Core::IObject {
	friend class SectionFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Section* make (const char* name) = 0;

	virtual Section* make (const char* name, ParameterState state) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IniFile

class IniFileAbstractFactory;

/// factory manager for IniFile
class IniFileFactoryManager {
public:
	static void register_factory (IniFileAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IniFileFactoryManager ();
	
	~IniFileFactoryManager ();
	
	void register_factory_i (IniFileAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IniFile* make (const char* filename) /*throw (Core::Root::NoActiveFactory)*/;

	friend class IniFileFactory;
	typedef ACE_Singleton <IniFileFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IniFileFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IniFileAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IniFileAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IniFile
class IniFileAbstractFactory : virtual public Core::IObject {
	friend class IniFileFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IniFile* make (const char* filename) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Rule

class RuleAbstractFactory;

/// factory manager for Rule
class RuleFactoryManager {
public:
	static void register_factory (RuleAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static RuleFactory::KeySet* keys ();

protected:
	RuleFactoryManager ();
	
	~RuleFactoryManager ();
	
	void register_factory_i (RuleAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Rule* make (XercesHelpers::DOMNodeEx& rule_node, const char* key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class RuleFactory;
	typedef ACE_Singleton <RuleFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <RuleFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<RuleAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<RuleAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Rule
class RuleAbstractFactory : virtual public Core::IObject {
	friend class RuleFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Rule* make (XercesHelpers::DOMNodeEx& rule_node) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for RulesManager

class RulesManagerAbstractFactory;

/// factory manager for RulesManager
class RulesManagerFactoryManager {
public:
	static void register_factory (RulesManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	RulesManagerFactoryManager ();
	
	~RulesManagerFactoryManager ();
	
	void register_factory_i (RulesManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	RulesManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class RulesManagerFactory;
	typedef ACE_Singleton <RulesManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <RulesManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<RulesManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<RulesManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for RulesManager
class RulesManagerAbstractFactory : virtual public Core::IObject {
	friend class RulesManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual RulesManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for XMLRuleParser

class XMLRuleParserAbstractFactory;

/// factory manager for XMLRuleParser
class XMLRuleParserFactoryManager {
public:
	static void register_factory (XMLRuleParserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static XMLRuleParserFactory::KeySet* keys ();

protected:
	XMLRuleParserFactoryManager ();
	
	~XMLRuleParserFactoryManager ();
	
	void register_factory_i (XMLRuleParserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	XMLRuleParser* make (
		RulesManager* manager
		, XercesHelpers::DOMNodeEx& rule_node
		, const char* key
	) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class XMLRuleParserFactory;
	typedef ACE_Singleton <XMLRuleParserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <XMLRuleParserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<XMLRuleParserAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<XMLRuleParserAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for XMLRuleParser
class XMLRuleParserAbstractFactory : virtual public Core::IObject {
	friend class XMLRuleParserFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual XMLRuleParser* make (RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node) = 0;
};

} // namespace IniConverter
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

