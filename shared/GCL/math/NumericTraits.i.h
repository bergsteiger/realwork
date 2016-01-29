////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/math/NumericTraits.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::GCL::math::NumericTraits
//
// набор хараектеристик вспомогательных операций на числовыми типами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/math/NumericTraits.h"

namespace GCL {

//////////////////////////////////////////////////////////////////////////////////////////
// template methods implementation

// возвращает число бит выставленных в 1 в числе value
template <class BOType>
size_t NumericTraits::bits_count (const BOType& value) {
	//#UC START# *4995582D02A5_499547F901F2*
	BOType n (value);
	
	size_t count = 0;
	while (n) {
		count++;
		n &= (n - 1);
	}
	return count;
	//#UC END# *4995582D02A5_499547F901F2**cpp*
}



} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

