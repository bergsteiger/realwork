////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/MMapComImplFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::MMapComImpl
//
// платформонезависимая часть реализации MMAP
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPCOMIMPL_FCTR_H__
#define __SHARED_GCI_MMAPCOMIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImpl.h"
#include "shared/GCI/MMap/MMapFactories.h"
#if defined(WIN32)

namespace GCI {
namespace MMapComImpl {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for PoolListHandler

class PoolListHandlerAbstractFactory;

/// factory manager for PoolListHandler
class PoolListHandlerFactoryManager {
public:
	static void register_factory (PoolListHandlerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PoolListHandlerFactoryManager ();
	
	~PoolListHandlerFactoryManager ();
	
	void register_factory_i (PoolListHandlerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	friend class PoolListHandlerFactory;
	typedef ACE_Singleton <PoolListHandlerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PoolListHandlerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PoolListHandlerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PoolListHandlerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for PoolListHandler
class PoolListHandlerAbstractFactory : virtual public Core::IObject, virtual public MMap::MemoryPoolAbstractFactory {
	friend class PoolListHandlerFactoryManager;
protected:
};

} // namespace MMapComImpl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPCOMIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

