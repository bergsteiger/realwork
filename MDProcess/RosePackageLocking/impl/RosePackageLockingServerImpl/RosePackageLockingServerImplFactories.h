////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImplFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_FCTR_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerFactories.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for PackageManagerEx

class PackageManagerExAbstractFactory;

/// factory manager for PackageManagerEx
class PackageManagerExFactoryManager {
public:
	static void register_factory (PackageManagerExAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PackageManagerExFactoryManager ();
	
	~PackageManagerExFactoryManager ();
	
	void register_factory_i (PackageManagerExAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	friend class PackageManagerExFactory;
	typedef ACE_Singleton <PackageManagerExFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PackageManagerExFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PackageManagerExAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PackageManagerExAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for PackageManagerEx
class PackageManagerExAbstractFactory : virtual public Core::IObject, virtual public RosePackageLockingServer::PackageManagerAbstractFactory {
	friend class PackageManagerExFactoryManager;
protected:
};

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

