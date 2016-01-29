////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournalFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for UserJournal

class UserJournalAbstractFactory;

/// factory manager for UserJournal
class UserJournalFactoryManager {
public:
	static void register_factory (UserJournalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	UserJournalFactoryManager ();
	
	~UserJournalFactoryManager ();
	
	void register_factory_i (UserJournalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	UserJournal* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class UserJournalFactory;
	typedef ACE_Singleton <UserJournalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UserJournalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<UserJournalAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<UserJournalAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for UserJournal
class UserJournalAbstractFactory : virtual public Core::IObject {
	friend class UserJournalFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual UserJournal* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

