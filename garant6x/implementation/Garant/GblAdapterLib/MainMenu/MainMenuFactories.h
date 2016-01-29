////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for SectionItem

class SectionItemAbstractFactory;

/// factory manager for SectionItem
class SectionItemFactoryManager {
public:
	static void register_factory (SectionItemAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SectionItemFactoryManager ();
	
	~SectionItemFactoryManager ();
	
	void register_factory_i (SectionItemAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	SectionItem* make (const GblPilot::SectionItem& section_item) /*throw (Core::Root::NoActiveFactory)*/;

	friend class SectionItemFactory;
	typedef ACE_Singleton <SectionItemFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SectionItemFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SectionItemAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SectionItemAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for SectionItem
class SectionItemAbstractFactory : virtual public Core::IObject {
	friend class SectionItemFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual SectionItem* make (const GblPilot::SectionItem& section_item) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Section

class SectionAbstractFactory;

/// factory manager for Section
class SectionFactoryManager {
public:
	static void register_factory (SectionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static SectionFactory::KeySet* keys ();

protected:
	SectionFactoryManager ();
	
	~SectionFactoryManager ();
	
	void register_factory_i (SectionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Section& make (SectionType key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class SectionFactory;
	typedef ACE_Singleton <SectionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SectionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SectionAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <SectionType, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SectionAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	struct ObjectCreationIdForMake {
		SectionType key_arg;

		ObjectCreationIdForMake (SectionType key) : key_arg(key) {
		}

		bool operator < (const ObjectCreationIdForMake& c) const {
			return  key_arg < c.key_arg;
		}
	};

	typedef std::map<ObjectCreationIdForMake, Section_var> CachedObjectsForMake;
	typedef std::map<const Section*, CachedObjectsForMake::iterator> CachedObjectsIndexForMake;
	CachedObjectsForMake m_cached_objects_for_make;
	CachedObjectsIndexForMake m_cached_objects_index_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for Section
class SectionAbstractFactory : virtual public Core::IObject {
	friend class SectionFactoryManager;
protected:
	virtual const SectionType key () const = 0;

	virtual Section* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MainMenu

class MainMenuAbstractFactory;

/// factory manager for MainMenu
class MainMenuFactoryManager {
public:
	static void register_factory (MainMenuAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MainMenuFactoryManager ();
	
	~MainMenuFactoryManager ();
	
	void register_factory_i (MainMenuAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MainMenu& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MainMenuFactory;
	typedef ACE_Singleton <MainMenuFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MainMenuFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MainMenuAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MainMenuAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	MainMenu_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for MainMenu
class MainMenuAbstractFactory : virtual public Core::IObject {
	friend class MainMenuFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MainMenu* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

