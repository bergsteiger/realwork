
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/LinkSupport/ConfModelLinks/ConfModelLinks.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::LinkSupport::ConfModelLinks
//
// пакет, обеспечивающий переход из Конфлюенса в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinks.h"
#include "MDProcess/LinkSupport/LibHome.h"

namespace LinkSupport {
namespace ConfModelLinks {

Core::Mutex ShowOnModelMngFactory::s_init_mutex;
bool ShowOnModelMngFactory::s_renew_mode = false;
Core::Mutex ShowOnModelMngFactory::s_mutex_for_get;
CORBA::ULong ShowOnModelMngFactory::s_cached_object_hash_for_get = 0;


// получить экземпляр соответствующий юзеру
ShowOnModelMng& ShowOnModelMngFactory::get () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "LinkSupport::ConfModelLinks::ShowOnModelMng");
				*FactoryManagerSrvSingleton::instance() = ShowOnModelMngFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for ShowOnModelMng");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		if (CachedObjectForGet::instance()->ptr() == 0) {
			GUARD(s_mutex_for_get);
			if (CachedObjectForGet::instance()->ptr() == 0) {
				*CachedObjectForGet::instance() = (*FactoryManagerSrvSingleton::instance())->get ();
				s_cached_object_hash_for_get = (*CachedObjectForGet::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
				created_new = true;
			}
		}
		if (created_new == false) {
			//если объект получили из кэша - нужно проверить, что он валиден
			bool need_recreate = false;
			try {
				need_recreate = CachedObjectForGet::instance()->ptr()->_non_existent ();
			} catch (...) {
				need_recreate = true;
			}
			if (need_recreate) {
				GUARD(s_mutex_for_get);
				*CachedObjectForGet::instance() = 0;
				*CachedObjectForGet::instance() = (*FactoryManagerSrvSingleton::instance())->get ();
				s_cached_object_hash_for_get = (*CachedObjectForGet::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
			}
		}
		return *CachedObjectForGet::instance()->ptr();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("ShowOnModelMngFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew ShowOnModelMngFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		ShowOnModelMng& ret = get ();
		s_renew_mode = false;
		
		return ret;
	}
}


} // namespace ConfModelLinks
} // namespace LinkSupport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

