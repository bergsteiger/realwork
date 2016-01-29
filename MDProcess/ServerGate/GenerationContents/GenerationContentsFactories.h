////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/GenerationContents/GenerationContentsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::GenerationContents
//
// все ответственности связанные с генерацией в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_GENERATIONCONTENTS_FCTR_H__
#define __MDPROCESS_SERVERGATE_GENERATIONCONTENTS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContents.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContentsS.h"

namespace ServerGate {
namespace GenerationContents {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Page

class PageAbstractFactory;

/// factory manager for Page
class PageFactoryManager: virtual public POA_ServerGate::GenerationContents::PageFactoryManagerSrv {
public:
	static void register_factory (PageAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	PageFactoryKeySet* keys () throw (CORBA::SystemException);

	static void remove (Page* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	static void publish_self ();

protected:
	PageFactoryManager ();
	
	~PageFactoryManager ();
	
	void register_factory_i (PageAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Page* get (ModelElementId_const guid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	void remove_i (Page* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	friend class PageFactory;
	typedef ACE_Singleton <PageFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PageFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PageAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PageAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	struct ObjectCreationIdForGet {
		std::string guid_arg;

		ObjectCreationIdForGet (ModelElementId_const guid) : guid_arg (guid) {
		}

		bool operator < (const ObjectCreationIdForGet& c) const {
			return guid_arg < c.guid_arg;
		}
	};

	typedef std::map<ObjectCreationIdForGet, Page_var> CachedObjectsForGet;
	typedef std::map<CORBA::ULong, CachedObjectsForGet::iterator> CachedObjectsIndexForGet;
	CachedObjectsForGet m_cached_objects_for_get;
	CachedObjectsIndexForGet m_cached_objects_index_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for Page
class PageAbstractFactory : virtual public Core::IObject {
	friend class PageFactoryManager;
protected:
	virtual const std::string key () const = 0;

	virtual Page* get (ModelElementId_const guid) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for GenerationManager

class GenerationManagerAbstractFactory;

/// factory manager for GenerationManager
class GenerationManagerFactoryManager: virtual public POA_ServerGate::GenerationContents::GenerationManagerFactoryManagerSrv {
public:
	static void register_factory (GenerationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	GenerationManagerFactoryManager ();
	
	~GenerationManagerFactoryManager ();
	
	void register_factory_i (GenerationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	GenerationManager* get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class GenerationManagerFactory;
	typedef ACE_Singleton <GenerationManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <GenerationManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<GenerationManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<GenerationManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	GenerationManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for GenerationManager
class GenerationManagerAbstractFactory : virtual public Core::IObject {
	friend class GenerationManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual GenerationManager* get () = 0;
};

} // namespace GenerationContents
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_GENERATIONCONTENTS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

