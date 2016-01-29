////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/I18N/I18NFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::I18N
//
// Интернационализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_FCTR_H__
#define __SHARED_GCI_I18N_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GCI/I18N/I18N.h"

namespace GCI {
namespace I18N {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for LocaleOperations

class LocaleOperationsAbstractFactory;

/// factory manager for LocaleOperations
class LocaleOperationsFactoryManager {
public:
	static void register_factory (LocaleOperationsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LocaleOperationsFactoryManager ();
	
	~LocaleOperationsFactoryManager ();
	
	void register_factory_i (LocaleOperationsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	LocaleOperations& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class LocaleOperationsFactory;
	typedef ACE_Singleton <LocaleOperationsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LocaleOperationsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LocaleOperationsAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LocaleOperationsAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	LocaleOperations_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for LocaleOperations
class LocaleOperationsAbstractFactory : virtual public Core::IObject {
	friend class LocaleOperationsFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual LocaleOperations* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Messages

class MessagesAbstractFactory;

/// factory manager for Messages
class MessagesFactoryManager {
public:
	static void register_factory (MessagesAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MessagesFactoryManager ();
	
	~MessagesFactoryManager ();
	
	void register_factory_i (MessagesAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Messages& messages () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MessagesFactory;
	typedef ACE_Singleton <MessagesFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MessagesFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MessagesAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MessagesAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory messages
	Messages_var m_cached_object_for_messages;

	Core::Mutex m_mutex_for_messages;
};

/// abstract factory for Messages
class MessagesAbstractFactory : virtual public Core::IObject {
	friend class MessagesFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Messages* messages () = 0;
};

} // namespace I18N
} // namespace GCI


#endif //__SHARED_GCI_I18N_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

