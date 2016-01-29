////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/start_stop.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::start_stop
//
// функции инициализации и осианова приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_START_STOP_H__
#define __SHARED_CORE_SYS_START_STOP_H__

#include "ace/ACE.h"

//#UC START# *45E68A64006D_USER_INCLUDES*
//#UC END# *45E68A64006D_USER_INCLUDES*

namespace Core {

// инициализация приложения, возвращает результат выполнения ACE::init
int init ();

// чистка ресурсов приложения перед остановом, возвращает результат выполнения ACE::fini
int fini ();

//#UC START# *45E68A64006D_USER_DEFINITION*
//#UC END# *45E68A64006D_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_SYS_START_STOP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
