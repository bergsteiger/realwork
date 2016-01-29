////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/start_stop.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::start_stop
// Файл реализации утилитного набора start_stop
//
// функции инициализации и осианова приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/sys/start_stop.h"

//#UC START# *45E68A64006D_CUSTOM_INCLUDES*
#include <locale.h>
#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectCounter.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "shared/Core/GDS/ObjectWatcher.h"
//#UC END# *45E68A64006D_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *45E68A64006D*
//#UC END# *45E68A64006D*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// чистка ресурсов приложения перед остановом, возвращает результат выполнения ACE::fini
int fini () {
	//#UC START# *45E68A87036B*
	return ACE::fini ();
	//#UC END# *45E68A87036B*
}

// инициализация приложения, возвращает результат выполнения ACE::init
int init () {
	//#UC START# *45E68A77031C*
	int result = ACE::init ();
	setlocale (LC_ALL, "Russian");
	ACE_OS::srand (static_cast<unsigned int> (time (0)));

#if defined (_MSC_VER) && (_MSC_VER >= 1200) && defined (_DEBUG)
	Core::GDS::MemoryWatcher::MemoryWatcherSingleton::instance ();
#endif
#if defined (_DEBUG)
	Core::GDS::CountHolderManager::CountHolderManagerSingleton::instance ();
#endif
	Core::PoolMemoryOwnerSingleton::instance ();
	Core::PoolObjectOwnerSingleton::instance ();
#if defined (_DEBUG)
	Core::GDS::ObjectWatcherSingleton::instance ();
#endif
	return result;
	//#UC END# *45E68A77031C*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

