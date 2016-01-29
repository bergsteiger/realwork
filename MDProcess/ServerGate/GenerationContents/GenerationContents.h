
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/GenerationContents/GenerationContents.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::GenerationContents
//
// все ответственности связанные с генерацией в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_GENERATIONCONTENTS_H__
#define __MDPROCESS_SERVERGATE_GENERATIONCONTENTS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContentsC.h"
#include <vector>
#include "MDProcess/ServerGate/Contents/Contents.h"

namespace ServerGate {
namespace GenerationContents {

typedef const char* ModelElementId_const;

typedef const char* PagePath_const;

/// factory interface for Page
class PageFactory {
public:
	PageFactoryKeySet* keys (); /*throw (CoreSrv::ForeignObject)*/
public:
	// возвращает существующую страницу по ее ид
	static Page& get (ModelElementId_const guid)
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<PageFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

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
	typedef ACE_Singleton <CachedObjectsForGet, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsForGetSngl;
	typedef ACE_Singleton <CachedObjectsIndexForGet, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsIndexForGetSngl;

	static Core::Mutex s_mutex_for_get;
};

/// factory interface for GenerationManager
class GenerationManagerFactory {
public:
	// кэшированная фабрика
	static GenerationManager& get ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<GenerationManagerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory get
	typedef ACE_Singleton <GenerationManager_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForGet;
	static CORBA::ULong s_cached_object_hash_for_get;

	static Core::Mutex s_mutex_for_get;
};

} // namespace GenerationContents
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_GENERATIONCONTENTS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

