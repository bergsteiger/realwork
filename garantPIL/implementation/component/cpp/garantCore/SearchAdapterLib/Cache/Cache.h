////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/Cache/Cache.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::Cache::Cache
//
// Кэш
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_CACHE_CACHE_H__
#define __GARANTCORE_SEARCHADAPTERLIB_CACHE_CACHE_H__

#include "shared/Core/sys/std_inc.h"
#include "ace/Singleton.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/DB/DBCore/DBCore.h"

//#UC START# *52BAD68202DF_CUSTOM_INCLUDES*
//#UC END# *52BAD68202DF_CUSTOM_INCLUDES*

namespace SearchAdapterLib {

// Кэш
class Cache {
	SET_OBJECT_COUNTER (Cache)

	// singleton declaration
	typedef ACE_Singleton <Cache, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Cache, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static Cache* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Cache ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// финализация
	void fini ();

	// коммуникатор
	ContextSearch::DBComm::IDBCommunicator* get ();

	// инициализация
	bool init (DBCore::IBase* base);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ContextSearch::DBComm::IDBCommunicator_var m_communicator;

	Core::Mutex m_mutex;

//#UC START# *52BAD68202DF*
//#UC END# *52BAD68202DF*
}; // class Cache

} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_CACHE_CACHE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

