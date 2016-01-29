////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/Actions/ActionsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::KPageToolLib::Actions
//
// Пакет доступных действий со страницей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONS_FCTR_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace Actions {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for KPageAction

class KPageActionAbstractFactory;

/// factory manager for KPageAction
class KPageActionFactoryManager {
public:
	static void register_factory (KPageActionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static KPageActionFactory::KeySet* keys ();

protected:
	KPageActionFactoryManager ();
	
	~KPageActionFactoryManager ();
	
	void register_factory_i (KPageActionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	KPageAction& get (PageActionsEnum key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class KPageActionFactory;
	typedef ACE_Singleton <KPageActionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <KPageActionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<KPageActionAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <PageActionsEnum, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<KPageActionAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	struct ObjectCreationIdForGet {
		PageActionsEnum key_arg;

		ObjectCreationIdForGet (PageActionsEnum key) : key_arg(key) {
		}

		bool operator < (const ObjectCreationIdForGet& c) const {
			return  key_arg < c.key_arg;
		}
	};

	typedef std::map<ObjectCreationIdForGet, KPageAction_var> CachedObjectsForGet;
	typedef std::map<const KPageAction*, CachedObjectsForGet::iterator> CachedObjectsIndexForGet;
	CachedObjectsForGet m_cached_objects_for_get;
	CachedObjectsIndexForGet m_cached_objects_index_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for KPageAction
class KPageActionAbstractFactory : virtual public Core::IObject {
	friend class KPageActionFactoryManager;
protected:
	virtual const PageActionsEnum key () const = 0;

	virtual KPageAction* get () = 0;
};

} // namespace Actions
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

