////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Contents/ContentsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Contents
//
// базовые ответственности связанные с работой с контентом в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_CONTENTS_FCTR_H__
#define __MDPROCESS_SERVERGATE_CONTENTS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/ServerGate/Contents/Contents.h"
#include "MDProcess/ServerGate/Contents/ContentsS.h"

namespace ServerGate {
namespace Contents {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for KPage

class KPageAbstractFactory;

/// factory manager for KPage
class KPageFactoryManager: virtual public POA_ServerGate::Contents::KPageFactoryManagerSrv {
public:
	static void register_factory (KPageAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void free (KPage* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	static void publish_self ();

protected:
	KPageFactoryManager ();
	
	~KPageFactoryManager ();
	
	void register_factory_i (KPageAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	KPage* create (
		const char* name
		, KPage* parent
	) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, CantCreatePage, PermissionException);

	KPage* get (PageId page_id) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound);

	KPage* get_by_name_and_space (
		const char* name
		, const char* spacekey
	) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound);

	KPage* get_by_model_element_guid (
		const char* guid
	) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound);

	void free_i (KPage* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	friend class KPageFactory;
	typedef ACE_Singleton <KPageFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <KPageFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<KPageAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<KPageAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	struct ObjectCreationIdForGet {
		PageId page_id_arg;

		ObjectCreationIdForGet (PageId page_id) : page_id_arg (page_id) {
		}

		bool operator < (const ObjectCreationIdForGet& c) const {
			return page_id_arg < c.page_id_arg;
		}
	};

	typedef std::map<ObjectCreationIdForGet, KPage_var> CachedObjectsForGet;
	typedef std::map<CORBA::ULong, CachedObjectsForGet::iterator> CachedObjectsIndexForGet;
	CachedObjectsForGet m_cached_objects_for_get;
	CachedObjectsIndexForGet m_cached_objects_index_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for KPage
class KPageAbstractFactory : virtual public Core::IObject {
	friend class KPageFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual KPage* create (const char* name, KPage* parent) /*throw (CantCreatePage, PermissionException)*/ = 0;

	virtual KPage* get (PageId page_id) /*throw (PageNotFound)*/ = 0;

	virtual KPage* get_by_name_and_space (const char* name, const char* spacekey) /*throw (PageNotFound)*/ = 0;

	virtual KPage* get_by_model_element_guid (const char* guid) /*throw (PageNotFound)*/ = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Request

class RequestAbstractFactory;

/// factory manager for Request
class RequestFactoryManager: virtual public POA_ServerGate::Contents::RequestFactoryManagerSrv {
public:
	static void register_factory (RequestAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	RequestFactoryManager ();
	
	~RequestFactoryManager ();
	
	void register_factory_i (RequestAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Request* get_by_name_and_space (
		const char* name
		, const char* spacekey
	) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound, PermissionException, PageIsNotRequest);

	Request* get (
		PageId page_id
	) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, PageNotFound, PermissionException, PageIsNotRequest);

	Request* create (
		RequestType type
		, RequestImportance importance
		, const char* name
		, KPage* parent
	) throw (CORBA::SystemException, CoreSrv::NoActiveFactory, CantCreatePage, PermissionException);

	friend class RequestFactory;
	typedef ACE_Singleton <RequestFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <RequestFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<RequestAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<RequestAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Request
class RequestAbstractFactory : virtual public Core::IObject {
	friend class RequestFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Request* get_by_name_and_space (
		const char* name
		, const char* spacekey
	) /*throw (PageNotFound, PermissionException, PageIsNotRequest)*/ = 0;

	virtual Request* get (PageId page_id) /*throw (PageNotFound, PermissionException, PageIsNotRequest)*/ = 0;

	virtual Request* create (
		RequestType type
		, RequestImportance importance
		, const char* name
		, KPage* parent
	) /*throw (CantCreatePage, PermissionException)*/ = 0;
};

} // namespace Contents
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_CONTENTS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

