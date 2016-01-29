
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Comm/Comm.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Comm
//
// Коммуникационные иинтерфейсы для взаимодействия с внешними агентами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_COMM_H__
#define __MDPROCESS_SERVERGATE_COMM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Comm/CommC.h"
#include "MDProcess/ServerGate/Contents/Contents.h"

namespace ServerGate {
namespace Comm {

/// factory interface for BuildListner
class BuildListnerFactory {
public:
	// возвращает зарегистрированный в системе "тестировщик сборок"
	static BuildListner& get ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<BuildListnerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory get
	typedef ACE_Singleton <BuildListner_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForGet;
	static CORBA::ULong s_cached_object_hash_for_get;

	static Core::Mutex s_mutex_for_get;
};

} // namespace Comm
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_COMM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

