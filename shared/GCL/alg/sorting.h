////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/sorting.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::alg::sorting
//
// алгоритмы сортировки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_ALG_SORTING_H__
#define __SHARED_GCL_ALG_SORTING_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *450133F10000_USER_INCLUDES*
//#UC END# *450133F10000_USER_INCLUDES*

namespace GCL {

//#UC START# *450133F10000_USER_DEFINITION*
// uqsort
// метод сортировки простым переборам БЕЗ учета равенства пар
// уникальный алгоритм для сортировки массивов для элементов которых может
// выполнятся условие:
//	 1. arr[i] == arr[k]
//	 2. arr[k] == arr[j]
//	 3. arr[i] != arr[j]
inline void uqsort( void *base, size_t num, size_t width, int (__cdecl *compare )(const void *elem1, const void *elem2 ) );
//#UC END# *450133F10000_USER_DEFINITION*

} // namespace GCL

#include "shared/GCL/alg/sorting.i.h"

#endif //__SHARED_GCL_ALG_SORTING_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
