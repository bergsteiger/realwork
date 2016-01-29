////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementationFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::NemesisChatImplementation::ChatImplementation
//
// реализация чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_FCTR_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"
#include "shared/ChatLibrary/ChatService/ChatServiceFactories.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for LocalChatManager

class LocalChatManagerAbstractFactory;

/// factory manager for LocalChatManager
class LocalChatManagerFactoryManager {
public:
	static void register_factory (LocalChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LocalChatManagerFactoryManager ();
	
	~LocalChatManagerFactoryManager ();
	
	void register_factory_i (LocalChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	friend class LocalChatManagerFactory;
	typedef ACE_Singleton <LocalChatManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LocalChatManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LocalChatManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LocalChatManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for LocalChatManager
class LocalChatManagerAbstractFactory : virtual public Core::IObject, virtual public ChatLibrary::ChatService::ChatManagerAbstractFactory {
	friend class LocalChatManagerFactoryManager;
protected:
};

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

