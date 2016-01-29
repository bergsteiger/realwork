////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImportFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::UsersImportLib::UsersImport
//
// интерфейсы уутилиты
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_FCTR_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"

namespace UsersImport {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for DataWriter

class DataWriterAbstractFactory;

/// factory manager for DataWriter
class DataWriterFactoryManager {
public:
	static void register_factory (DataWriterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DataWriterFactoryManager ();
	
	~DataWriterFactoryManager ();
	
	void register_factory_i (DataWriterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DataWriter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class DataWriterFactory;
	typedef ACE_Singleton <DataWriterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DataWriterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DataWriterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DataWriterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DataWriter
class DataWriterAbstractFactory : virtual public Core::IObject {
	friend class DataWriterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DataWriter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DataParser

class DataParserAbstractFactory;

/// factory manager for DataParser
class DataParserFactoryManager {
public:
	static void register_factory (DataParserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DataParserFactoryManager ();
	
	~DataParserFactoryManager ();
	
	void register_factory_i (DataParserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DataParser* make (DataWriter* writer) /*throw (Core::Root::NoActiveFactory)*/;

	friend class DataParserFactory;
	typedef ACE_Singleton <DataParserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DataParserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DataParserAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DataParserAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DataParser
class DataParserAbstractFactory : virtual public Core::IObject {
	friend class DataParserFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DataParser* make (DataWriter* writer) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DataReader

class DataReaderAbstractFactory;

/// factory manager for DataReader
class DataReaderFactoryManager {
public:
	static void register_factory (DataReaderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DataReaderFactoryManager ();
	
	~DataReaderFactoryManager ();
	
	void register_factory_i (DataReaderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DataReader* make (const std::string& source, DataParser* parser) /*throw (Core::Root::NoActiveFactory)*/;

	DataReader* make (const std::string& source) /*throw (Core::Root::NoActiveFactory)*/;

	friend class DataReaderFactory;
	typedef ACE_Singleton <DataReaderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DataReaderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DataReaderAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DataReaderAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DataReader
class DataReaderAbstractFactory : virtual public Core::IObject {
	friend class DataReaderFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DataReader* make (const std::string& source, DataParser* parser) = 0;

	virtual DataReader* make (const std::string& source) = 0;
};

} // namespace UsersImport


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

