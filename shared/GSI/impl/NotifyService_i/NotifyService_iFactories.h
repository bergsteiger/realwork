////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/NotifyService_iFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GSI::NotifyService_i
//
// Реализация сервиса нотификаций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_FCTR_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "shared/GSI/NotifyService/NotifyServiceFactories.h"

namespace GSI {
namespace NotifyService_i {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ManagerLocal

class ManagerLocalAbstractFactory;

/// factory manager for ManagerLocal
class ManagerLocalFactoryManager {
public:
	static void register_factory (ManagerLocalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ManagerLocalFactoryManager ();
	
	~ManagerLocalFactoryManager ();
	
	void register_factory_i (ManagerLocalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	friend class ManagerLocalFactory;
	typedef ACE_Singleton <ManagerLocalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ManagerLocalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ManagerLocalAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ManagerLocalAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ManagerLocal
class ManagerLocalAbstractFactory : virtual public Core::IObject, virtual public NotifyService::ManagerAbstractFactory {
	friend class ManagerLocalFactoryManager;
protected:
};

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

