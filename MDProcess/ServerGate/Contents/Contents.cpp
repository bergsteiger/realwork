
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Contents/Contents.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Contents
//
// базовые ответственности связанные с работой с контентом в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Contents/Contents.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace Contents {

Core::Mutex KPageFactory::s_init_mutex;
bool KPageFactory::s_renew_mode = false;
Core::Mutex KPageFactory::s_mutex_for_get;


// Создает новую страницу с указанным именем в указаном родителе, если страница с таким именем в
// *этом* родителе уже есть - генерируется исключение
KPage* KPageFactory::create (const char* name, KPage* parent) /*throw (CoreSrv::NoActiveFactory, CantCreatePage, PermissionException)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Contents::KPage");
				*FactoryManagerSrvSingleton::instance() = KPageFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for KPage");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->create (name, parent);
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("KPageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew KPageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		KPage_var ret = create (name, parent);
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("KPageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew KPageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		KPage_var ret = create (name, parent);
		s_renew_mode = false;
		
		return ret._retn();				
	}
}

// Возвращает интерфейс существующей страницы
// ВРЕМЕННО(!) Потом (когда доделаем локальные интерфейс для серверных объектов) нужно будет
// перенести на локальный интерфейс
KPage& KPageFactory::get (PageId page_id) /*throw (CoreSrv::NoActiveFactory, PageNotFound)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Contents::KPage");
				*FactoryManagerSrvSingleton::instance() = KPageFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for KPage");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		GUARD(s_mutex_for_get);
		CachedObjectsForGet::iterator f = CachedObjectsForGetSngl::instance()->find (ObjectCreationIdForGet(page_id));
		if (f == CachedObjectsForGetSngl::instance()->end()) {
			f = CachedObjectsForGetSngl::instance()->insert (
				CachedObjectsForGet::value_type(
					ObjectCreationIdForGet(page_id)
					, (*FactoryManagerSrvSingleton::instance())->get (page_id)
				)
			).first;
			(*CachedObjectsIndexForGetSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
			created_new = true;
		}
		if (created_new == false) {
			//если объект получили из кэша - нужно проверить, что он валиден
			bool need_recreate = false;
			try {
				need_recreate = f->second->_non_existent ();
			} catch (...) {
				need_recreate = true;
			}
			if (need_recreate) {
				CachedObjectsForGetSngl::instance()->erase (f);
				f = CachedObjectsForGetSngl::instance()->insert (
					CachedObjectsForGet::value_type(
						ObjectCreationIdForGet(page_id)
						, (*FactoryManagerSrvSingleton::instance())->get (page_id)
					)
				).first;
				(*CachedObjectsIndexForGetSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
			}
		}
		return *f->second;
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("KPageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew KPageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		KPage& ret = get (page_id);
		s_renew_mode = false;
		
		return ret;				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("KPageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew KPageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		KPage& ret = get (page_id);
		s_renew_mode = false;
		
		return ret;				
	}
}

KPage* KPageFactory::get_by_name_and_space (const char* name, const char* spacekey) /*throw (CoreSrv::NoActiveFactory, PageNotFound)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Contents::KPage");
				*FactoryManagerSrvSingleton::instance() = KPageFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for KPage");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->get_by_name_and_space (name, spacekey);
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("KPageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew KPageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		KPage_var ret = get_by_name_and_space (name, spacekey);
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("KPageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew KPageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		KPage_var ret = get_by_name_and_space (name, spacekey);
		s_renew_mode = false;
		
		return ret._retn();				
	}
}

// пытается получить по гуиду элемента, есди не нашла - выкидывает исключение
KPage* KPageFactory::get_by_model_element_guid (const char* guid) /*throw (CoreSrv::NoActiveFactory, PageNotFound)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Contents::KPage");
				*FactoryManagerSrvSingleton::instance() = KPageFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for KPage");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->get_by_model_element_guid (guid);
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("KPageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew KPageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		KPage_var ret = get_by_model_element_guid (guid);
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("KPageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew KPageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		KPage_var ret = get_by_model_element_guid (guid);
		s_renew_mode = false;
		
		return ret._retn();				
	}
}


Core::Mutex RequestFactory::s_init_mutex;
bool RequestFactory::s_renew_mode = false;

Request* RequestFactory::get_by_name_and_space (const char* name, const char* spacekey) /*throw (CoreSrv::NoActiveFactory, PageNotFound, PermissionException, PageIsNotRequest)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Contents::Request");
				*FactoryManagerSrvSingleton::instance() = RequestFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for Request");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->get_by_name_and_space (name, spacekey);
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("RequestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew RequestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Request_var ret = get_by_name_and_space (name, spacekey);
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("RequestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew RequestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Request_var ret = get_by_name_and_space (name, spacekey);
		s_renew_mode = false;
		
		return ret._retn();				
	}
}

Request* RequestFactory::get (PageId page_id) /*throw (CoreSrv::NoActiveFactory, PageNotFound, PermissionException, PageIsNotRequest)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Contents::Request");
				*FactoryManagerSrvSingleton::instance() = RequestFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for Request");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->get (page_id);
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("RequestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew RequestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Request_var ret = get (page_id);
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("RequestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew RequestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Request_var ret = get (page_id);
		s_renew_mode = false;
		
		return ret._retn();				
	}
}

Request* RequestFactory::create (RequestType type, RequestImportance importance, const char* name, KPage* parent) /*throw (CoreSrv::NoActiveFactory, CantCreatePage, PermissionException)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Contents::Request");
				*FactoryManagerSrvSingleton::instance() = RequestFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for Request");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->create (type, importance, name, parent);
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("RequestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew RequestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Request_var ret = create (type, importance, name, parent);
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("RequestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew RequestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Request_var ret = create (type, importance, name, parent);
		s_renew_mode = false;
		
		return ret._retn();				
	}
}


} // namespace Contents
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

