////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/Parsers/ParsersFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::Parsers
//
// вспомогательные парсеры сигнатур функций, атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_PARSERS_FCTR_H__
#define __MDPROCESS_MDAMODEL_PARSERS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"

namespace Parsers {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for AttributeParser

class AttributeParserAbstractFactory;

/// factory manager for AttributeParser
class AttributeParserFactoryManager {
public:
	static void register_factory (AttributeParserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	AttributeParserFactoryManager ();
	
	~AttributeParserFactoryManager ();
	
	void register_factory_i (AttributeParserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	AttributeParser& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class AttributeParserFactory;
	typedef ACE_Singleton <AttributeParserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AttributeParserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AttributeParserAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AttributeParserAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	AttributeParser_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for AttributeParser
class AttributeParserAbstractFactory : virtual public Core::IObject {
	friend class AttributeParserFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual AttributeParser* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for OperationParser

class OperationParserAbstractFactory;

/// factory manager for OperationParser
class OperationParserFactoryManager {
public:
	static void register_factory (OperationParserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	OperationParserFactoryManager ();
	
	~OperationParserFactoryManager ();
	
	void register_factory_i (OperationParserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	OperationParser& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class OperationParserFactory;
	typedef ACE_Singleton <OperationParserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <OperationParserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<OperationParserAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<OperationParserAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	OperationParser_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for OperationParser
class OperationParserAbstractFactory : virtual public Core::IObject {
	friend class OperationParserFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual OperationParser* get () = 0;
};

} // namespace Parsers


#endif //__MDPROCESS_MDAMODEL_PARSERS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

