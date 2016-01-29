////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Utils/cos_naming_op.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::Utils::cos_naming_op
//
// вспомогательные функции упрощающие работу с CosNaming
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_UTILS_COS_NAMING_OP_H__
#define __SHARED_CORESRV_UTILS_COS_NAMING_OP_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4503D72603B9_USER_INCLUDES*
#include "TAO/orbsvcs/orbsvcs/CosNamingC.h"
//#UC END# *4503D72603B9_USER_INCLUDES*

namespace CoreSrv {

//#UC START# *4503D72603B9_USER_DEFINITION*
inline void bind_path (CosNaming::NamingContext_ptr root, CORBA::Object_ptr source, const char* path);
	
inline CosNaming::NamingContext_ptr create_path (CosNaming::NamingContext_ptr root, const char* path);
	
inline CORBA::Object_ptr resolve_path (CosNaming::NamingContext_ptr root, const char* path);
//#UC END# *4503D72603B9_USER_DEFINITION*

} // namespace CoreSrv

#include "shared/CoreSrv/Utils/cos_naming_op.i.h"

#endif //__SHARED_CORESRV_UTILS_COS_NAMING_OP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
