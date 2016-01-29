////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/fix/wine.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::fix::wine
//
// подключение external-библиотеки WINE (эмуляция некоторых функций Windows API, которые отсутсвуют
// в win95/98/NT, но эти функции используются MSVC 2005 run-time)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_FIX_WINE_H__
#define __SHARED_CORE_FIX_WINE_H__

#include "ace/ACE.h"

//#UC START# *45E40FD200AB_USER_INCLUDES*
#if (defined (WIN32) && !defined (WIN64)) 
#if !(defined (_MSC_VER) && (_MSC_VER >= 1800))
	#define  WINE_USE_ACE 1
	#include "wine/wine.h"
#endif 
#endif   // defined (WIN32)
//#UC END# *45E40FD200AB_USER_INCLUDES*

namespace Core {

//#UC START# *45E40FD200AB_USER_DEFINITION*
//#UC END# *45E40FD200AB_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_FIX_WINE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
