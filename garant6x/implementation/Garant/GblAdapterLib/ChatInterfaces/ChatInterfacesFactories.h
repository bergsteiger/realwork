////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfacesFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// интерфейсы для поддержки чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATINTERFACES_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_CHATINTERFACES_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"

namespace GblAdapterLib {
namespace ChatInterfaces {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ChatManager

class ChatManagerAbstractFactory;

/// factory manager for ChatManager
class ChatManagerFactoryManager {
public:
	static void register_factory (ChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ChatManagerFactoryManager ();
	
	~ChatManagerFactoryManager ();
	
	void register_factory_i (ChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ChatManager& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ChatManagerFactory;
	typedef ACE_Singleton <ChatManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ChatManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ChatManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ChatManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	ChatManager_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for ChatManager
class ChatManagerAbstractFactory : virtual public Core::IObject {
	friend class ChatManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ChatManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MessagesManager

class MessagesManagerAbstractFactory;

/// factory manager for MessagesManager
class MessagesManagerFactoryManager {
public:
	static void register_factory (MessagesManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MessagesManagerFactoryManager ();
	
	~MessagesManagerFactoryManager ();
	
	void register_factory_i (MessagesManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MessagesManager& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MessagesManagerFactory;
	typedef ACE_Singleton <MessagesManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MessagesManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MessagesManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MessagesManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	MessagesManager_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for MessagesManager
class MessagesManagerAbstractFactory : virtual public Core::IObject {
	friend class MessagesManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MessagesManager* make () = 0;
};

} // namespace ChatInterfaces
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CHATINTERFACES_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

