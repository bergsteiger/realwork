////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/assert.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::assert
//
// макрос проверки выполнения условия, с возможностью вывода в лог
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_ASSERT_H__
#define __SHARED_CORE_SYS_ASSERT_H__

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"

//#UC START# *450E981C03D8_USER_INCLUDES*
#include <cassert>
//#UC END# *450E981C03D8_USER_INCLUDES*

namespace Core {

//#UC START# *450E981C03D8_USER_DEFINITION*
#ifdef NDEBUG
#define GDS_ASSERT(exp)            (void)( (exp) || (LOG_A (("ASSERTION FAILED [%s:%d]: %s", __FILE__, __LINE__, #exp)), 0) ); 
#define GDS_ASSERT_MSG(exp, msg)   (void)( (exp) || (LOG_A (("ASSERTION FAILED [%s:%d]: %s", __FILE__, __LINE__, #exp)), LOG_A (msg), 0) );
#else
#define GDS_ASSERT(exp)            assert((exp));
#define GDS_ASSERT_MSG(exp, msg)   (void)( (exp) || (LOG_A (("ASSERTION FAILED [%s:%d]: %s", __FILE__, __LINE__, #exp)), LOG_A (msg), assert((exp)), 0));
#endif // NDEBUG
//#UC END# *450E981C03D8_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_SYS_ASSERT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
