////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/os/disk_op.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::os::disk_op
//
// расширенные операции над диском (получение свободного места, ...)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_OS_DISK_OP_H__
#define __SHARED_GCL_OS_DISK_OP_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4503DE0B02EE_USER_INCLUDES*
//#UC END# *4503DE0B02EE_USER_INCLUDES*

namespace GCL {

// Get free disk space for the path, in kb
// If the function succeeds, the return value is nonzero
bool get_free_space (const char* path, unsigned long& free_space);

//#UC START# *4503DE0B02EE_USER_DEFINITION*
//#UC END# *4503DE0B02EE_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_OS_DISK_OP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
