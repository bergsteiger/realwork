
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ArchiGate::DocCardRemote
//
// для работы с гардоком
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTE_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteC.h"
#include <vector>

namespace ArchiGate {
namespace DocCardRemote {

/// factory interface for BigFileIterator
class BigFileIteratorFactory {
public:
	static BigFileIterator* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<BigFileIteratorFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

/// factory interface for ArchiEventsListener
class ArchiEventsListenerFactory {
public:
	// make
	static ArchiEventsListener* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<ArchiEventsListenerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

/// factory interface for Searcher2
class Searcher2Factory {
public:
	static Searcher2* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<Searcher2FactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

/// factory interface for Utils
class UtilsFactory {
public:
	static Utils* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<UtilsFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

/// factory interface for GardocGetter
class GardocGetterFactory {
public:
	static GardocGetter* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<GardocGetterFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

/// factory interface for Searcher
class SearcherFactory {
public:
	static Searcher* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<SearcherFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

} // namespace DocCardRemote
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

