////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Search/SearchFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Search
//
// Интерфейсы и типы для алгоритмов контекстного поиска.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_FCTR_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/ContextSearch/Search/Search.h"

namespace ContextSearch {
namespace Search {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for IWorker

class IWorkerAbstractFactory;

/// factory manager for IWorker
class IWorkerFactoryManager {
public:
	static void register_factory (IWorkerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IWorkerFactoryManager ();
	
	~IWorkerFactoryManager ();
	
	void register_factory_i (IWorkerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IWorker* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class IWorkerFactory;
	typedef ACE_Singleton <IWorkerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IWorkerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IWorkerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IWorkerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IWorker
class IWorkerAbstractFactory : virtual public Core::IObject {
	friend class IWorkerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IWorker* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IRequestView

class IRequestViewAbstractFactory;

/// factory manager for IRequestView
class IRequestViewFactoryManager {
public:
	static void register_factory (IRequestViewAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static IRequestViewFactory::KeySet* keys ();

protected:
	IRequestViewFactoryManager ();
	
	~IRequestViewFactoryManager ();
	
	void register_factory_i (IRequestViewAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IRequestView* make (
		DBComm::IDBCommunicator* comm
		, Morpho::Def::INormalizer* normalizer
		, AlgorithmSelector key
	) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class IRequestViewFactory;
	typedef ACE_Singleton <IRequestViewFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IRequestViewFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IRequestViewAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <AlgorithmSelector, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IRequestViewAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IRequestView
class IRequestViewAbstractFactory : virtual public Core::IObject {
	friend class IRequestViewFactoryManager;
protected:
	virtual const AlgorithmSelector key () const = 0;

	virtual IRequestView* make (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IAlgorithm

class IAlgorithmAbstractFactory;

/// factory manager for IAlgorithm
class IAlgorithmFactoryManager {
public:
	static void register_factory (IAlgorithmAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static IAlgorithmFactory::KeySet* keys ();

protected:
	IAlgorithmFactoryManager ();
	
	~IAlgorithmFactoryManager ();
	
	void register_factory_i (IAlgorithmAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IAlgorithm* make (
		IRequestView* view
		, DBComm::IProgress* progress
		, const AlgorithmProperties& properties
		, AlgorithmSelector key
	) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class IAlgorithmFactory;
	typedef ACE_Singleton <IAlgorithmFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IAlgorithmFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IAlgorithmAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <AlgorithmSelector, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IAlgorithmAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IAlgorithm
class IAlgorithmAbstractFactory : virtual public Core::IObject {
	friend class IAlgorithmFactoryManager;
protected:
	virtual const AlgorithmSelector key () const = 0;

	virtual IAlgorithm* make (IRequestView* view, DBComm::IProgress* progress, const AlgorithmProperties& properties) = 0;
};

} // namespace Search
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

