////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Relevancy/RelevancyFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Relevancy
//
// Интерфейсы и типы для алгоритма вычисления релевантности.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_FCTR_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

namespace ContextSearch {
namespace Relevancy {

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
		const Data& req_data
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

	virtual IAlgorithm* make (const Data& req_data, const AlgorithmProperties& properties) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IBlocksAlgorithm

class IBlocksAlgorithmAbstractFactory;

/// factory manager for IBlocksAlgorithm
class IBlocksAlgorithmFactoryManager {
public:
	static void register_factory (IBlocksAlgorithmAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IBlocksAlgorithmFactoryManager ();
	
	~IBlocksAlgorithmFactoryManager ();
	
	void register_factory_i (IBlocksAlgorithmAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IBlocksAlgorithm* make (
		const Data& req_data
		, const AlgorithmProperties& properties
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class IBlocksAlgorithmFactory;
	typedef ACE_Singleton <IBlocksAlgorithmFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IBlocksAlgorithmFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IBlocksAlgorithmAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IBlocksAlgorithmAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IBlocksAlgorithm
class IBlocksAlgorithmAbstractFactory : virtual public Core::IObject {
	friend class IBlocksAlgorithmFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IBlocksAlgorithm* make (const Data& req_data, const AlgorithmProperties& properties) = 0;
};

} // namespace Relevancy
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

