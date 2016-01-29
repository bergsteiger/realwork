
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Contents/Contents.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Contents
//
// базовые ответственности связанные с работой с контентом в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_CONTENTS_H__
#define __MDPROCESS_SERVERGATE_CONTENTS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Contents/ContentsC.h"
#include <vector>
#include <list>

namespace ServerGate {
namespace Contents {

/// factory interface for KPage
class KPageFactory {
public:
	// Создает новую страницу с указанным именем в указаном родителе, если страница с таким именем в
	// *этом* родителе уже есть - генерируется исключение
	static KPage* create (const char* name, KPage* parent)
		/*throw (CoreSrv::NoActiveFactory, CantCreatePage, PermissionException)*/;

	// Возвращает интерфейс существующей страницы
	// ВРЕМЕННО(!) Потом (когда доделаем локальные интерфейс для серверных объектов) нужно будет
	// перенести на локальный интерфейс
	static KPage& get (PageId page_id)
		/*throw (CoreSrv::NoActiveFactory, PageNotFound)*/;

	static KPage* get_by_name_and_space (const char* name, const char* spacekey)
		/*throw (CoreSrv::NoActiveFactory, PageNotFound)*/;

	// пытается получить по гуиду элемента, есди не нашла - выкидывает исключение
	static KPage* get_by_model_element_guid (const char* guid)
		/*throw (CoreSrv::NoActiveFactory, PageNotFound)*/;
private:
	typedef ACE_Singleton<KPageFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

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
	typedef ACE_Singleton <CachedObjectsForGet, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsForGetSngl;
	typedef ACE_Singleton <CachedObjectsIndexForGet, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsIndexForGetSngl;

	static Core::Mutex s_mutex_for_get;
};

/// factory interface for Request
class RequestFactory {
public:
	static Request* get_by_name_and_space (const char* name, const char* spacekey)
		/*throw (CoreSrv::NoActiveFactory, PageNotFound, PermissionException, PageIsNotRequest)*/;

	static Request* get (PageId page_id)
		/*throw (CoreSrv::NoActiveFactory, PageNotFound, PermissionException, PageIsNotRequest)*/;

	static Request* create (RequestType type, RequestImportance importance, const char* name, KPage* parent)
		/*throw (CoreSrv::NoActiveFactory, CantCreatePage, PermissionException)*/;
private:
	typedef ACE_Singleton<RequestFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

} // namespace Contents
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_CONTENTS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

