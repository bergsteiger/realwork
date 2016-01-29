////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicatorFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::SearchProgressIndicator
//
// Прогрессиндикаторы для поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for CancelSearch

class CancelSearchAbstractFactory;

/// factory manager for CancelSearch
class CancelSearchFactoryManager {
public:
	static void register_factory (CancelSearchAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CancelSearchFactoryManager ();
	
	~CancelSearchFactoryManager ();
	
	void register_factory_i (CancelSearchAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	CancelSearch* make (GblPilot::SearchManager* search_manager) /*throw (Core::Root::NoActiveFactory)*/;

	friend class CancelSearchFactory;
	typedef ACE_Singleton <CancelSearchFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CancelSearchFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CancelSearchAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CancelSearchAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for CancelSearch
class CancelSearchAbstractFactory : virtual public Core::IObject {
	friend class CancelSearchFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual CancelSearch* make (GblPilot::SearchManager* search_manager) = 0;
};

} // namespace SearchProgressIndicator
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

