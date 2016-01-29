////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Utils/corba_object_op.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::Utils::corba_object_op
//
// вспомогательные функции работы с объектом (получение его TypeId, ...)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_UTILS_CORBA_OBJECT_OP_H__
#define __SHARED_CORESRV_UTILS_CORBA_OBJECT_OP_H__

#include "shared/Core/sys/std_inc.h"
#include "tao/ORB_Core.h"

//#UC START# *4503D57D00EA_USER_INCLUDES*
//#UC END# *4503D57D00EA_USER_INCLUDES*

namespace CoreSrv {

// возвращает type_id для указанного объекта
const char* get_object_type_id (CORBA::Object* obj);

//#UC START# *4503D57D00EA_USER_DEFINITION*
//#UC END# *4503D57D00EA_USER_DEFINITION*

} // namespace CoreSrv


#endif //__SHARED_CORESRV_UTILS_CORBA_OBJECT_OP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
