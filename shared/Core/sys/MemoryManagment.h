////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/MemoryManagment.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::MemoryManagment
//
// вспомогательные функция для работы с памятью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_MEMORYMANAGMENT_H__
#define __SHARED_CORE_SYS_MEMORYMANAGMENT_H__

#include "ace/ACE.h"

//#UC START# *4DA7DAFF006D_USER_INCLUDES*
//#UC END# *4DA7DAFF006D_USER_INCLUDES*

namespace Core {
namespace MemoryManagment {

// инициализация специальной низкофрагментированной кучи(поддерживается только под windows).
void init_low_fragmentation_heap ();

// устанавливает обработчик для перехвата неудачного выделения памяти
void install_new_handler ();

//#UC START# *4DA7DAFF006D_USER_DEFINITION*
//#UC END# *4DA7DAFF006D_USER_DEFINITION*

} // namespace MemoryManagment
} // namespace Core


#endif //__SHARED_CORE_SYS_MEMORYMANAGMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
