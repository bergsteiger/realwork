////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocalFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypesLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPESLOCAL_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPESLOCAL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for DataReadingStream

class DataReadingStreamAbstractFactory;

/// factory manager for DataReadingStream
class DataReadingStreamFactoryManager {
public:
	static void register_factory (DataReadingStreamAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DataReadingStreamFactoryManager ();
	
	~DataReadingStreamFactoryManager ();
	
	void register_factory_i (DataReadingStreamAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DataReadingStream* make (GslDataPipe::DataReading* data_reading) /*throw (Core::Root::NoActiveFactory)*/;

	friend class DataReadingStreamFactory;
	typedef ACE_Singleton <DataReadingStreamFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DataReadingStreamFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DataReadingStreamAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DataReadingStreamAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DataReadingStream
class DataReadingStreamAbstractFactory : virtual public Core::IObject {
	friend class DataReadingStreamFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DataReadingStream* make (GslDataPipe::DataReading* data_reading) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MemoryStream

class MemoryStreamAbstractFactory;

/// factory manager for MemoryStream
class MemoryStreamFactoryManager {
public:
	static void register_factory (MemoryStreamAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MemoryStreamFactoryManager ();
	
	~MemoryStreamFactoryManager ();
	
	void register_factory_i (MemoryStreamAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MemoryStream* make (const OctetSeq& data, bool with_copy) /*throw (Core::Root::NoActiveFactory)*/;

	friend class MemoryStreamFactory;
	typedef ACE_Singleton <MemoryStreamFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MemoryStreamFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MemoryStreamAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MemoryStreamAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for MemoryStream
class MemoryStreamAbstractFactory : virtual public Core::IObject {
	friend class MemoryStreamFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MemoryStream* make (const OctetSeq& data, bool with_copy) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPESLOCAL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

