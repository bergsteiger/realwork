////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/math/NumericTraits.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::GCL::math::NumericTraits
//
// набор хараектеристик вспомогательных операций на числовыми типами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_MATH_NUMERICTRAITS_H__
#define __SHARED_GCL_MATH_NUMERICTRAITS_H__

#include "shared/Core/sys/std_inc.h"

namespace GCL {

// набор хараектеристик вспомогательных операций на числовыми типами
class NumericTraits {
	SET_OBJECT_COUNTER (NumericTraits)

//////////////////////////////////////////////////////////////////////////////////////////
// template methods
public:
	// возвращает число бит выставленных в 1 в числе value
	template <class BOType>
	static size_t bits_count (const BOType& value);



}; // class NumericTraits

} // namespace GCL

#include "shared/GCL/math/NumericTraits.i.h"

#endif //__SHARED_GCL_MATH_NUMERICTRAITS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

