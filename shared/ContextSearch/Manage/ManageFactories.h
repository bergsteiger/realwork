////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Manage/ManageFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Manage
//
// Интерфейсы и типы для менеджеров поисковых алгоритмов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_FCTR_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/ContextSearch/Manage/Manage.h"

namespace ContextSearch {
namespace Manage {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for IRequestTransformer

class IRequestTransformerAbstractFactory;

/// factory manager for IRequestTransformer
class IRequestTransformerFactoryManager {
public:
	static void register_factory (IRequestTransformerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IRequestTransformerFactoryManager ();
	
	~IRequestTransformerFactoryManager ();
	
	void register_factory_i (IRequestTransformerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IRequestTransformer* make (Morpho::Def::INormalizer* normalizer) /*throw (Core::Root::NoActiveFactory)*/;

	friend class IRequestTransformerFactory;
	typedef ACE_Singleton <IRequestTransformerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IRequestTransformerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IRequestTransformerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IRequestTransformerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IRequestTransformer
class IRequestTransformerAbstractFactory : virtual public Core::IObject {
	friend class IRequestTransformerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IRequestTransformer* make (Morpho::Def::INormalizer* normalizer) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ISynManager

class ISynManagerAbstractFactory;

/// factory manager for ISynManager
class ISynManagerFactoryManager {
public:
	static void register_factory (ISynManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ISynManagerFactoryManager ();
	
	~ISynManagerFactoryManager ();
	
	void register_factory_i (ISynManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ISynManager* make (
		Morpho::Def::INormalizer* normalizer
		, DBComm::IDBCommunicator* comm
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ISynManagerFactory;
	typedef ACE_Singleton <ISynManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ISynManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ISynManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ISynManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ISynManager
class ISynManagerAbstractFactory : virtual public Core::IObject {
	friend class ISynManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ISynManager* make (Morpho::Def::INormalizer* normalizer, DBComm::IDBCommunicator* comm) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IQuery

class IQueryAbstractFactory;

/// factory manager for IQuery
class IQueryFactoryManager {
public:
	static void register_factory (IQueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IQueryFactoryManager ();
	
	~IQueryFactoryManager ();
	
	void register_factory_i (IQueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IQuery* make (const Env& in, DBComm::IDBCommunicator* comm) /*throw (Core::Root::NoActiveFactory)*/;

	friend class IQueryFactory;
	typedef ACE_Singleton <IQueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IQueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IQueryAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IQueryAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IQuery
class IQueryAbstractFactory : virtual public Core::IObject {
	friend class IQueryFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IQuery* make (const Env& in, DBComm::IDBCommunicator* comm) = 0;
};

} // namespace Manage
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

