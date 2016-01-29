////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/sys/std_inc.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::sys::std_inc
//
// стандартный заголовочный файл включающий в себя минимально необходимый набор заголовочных
// CoreSrv-файлов. Должен быть включен первым во все h/cpp файлы используещие CORBA
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SYS_STD_INC_H__
#define __SHARED_CORESRV_SYS_STD_INC_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *458F948C00A5_USER_INCLUDES*
#ifndef USE_TAO
#error This file (as a part of CoreSrv lib) must be used only in CORBA-environment
#endif

#include "tao/Any.h"
#include "shared/CoreSrv/sys/Logs.h"
#include "shared/CoreSrv/sys/Exception.h"
#include "shared/CoreSrv/Root/Root.h"
#include "shared/CoreSrv/Security/Security.h"
#include "shared/CoreSrv/sys/RefCountServantBase.h"
#include "shared/CoreSrv/Utils/cos_naming_op.h"
//#UC END# *458F948C00A5_USER_INCLUDES*

namespace CoreSrv {

//#UC START# *458F948C00A5_USER_DEFINITION*
//#UC END# *458F948C00A5_USER_DEFINITION*

} // namespace CoreSrv


#endif //__SHARED_CORESRV_SYS_STD_INC_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
