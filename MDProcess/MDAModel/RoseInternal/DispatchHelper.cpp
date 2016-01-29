////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/DispatchHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::MDAModel::RoseInternal::DispatchHelper
//
// вспомогательный набор функций для реализации IDispatch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *4A3774B900C6_CUSTOM_INCLUDES*
//#UC END# *4A3774B900C6_CUSTOM_INCLUDES*

namespace RoseInternal {

//#UC START# *4A3774B900C6*
//#UC END# *4A3774B900C6*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void DispatchHelper::make_bool_result (bool in, VARIANT* result) {
	//#UC START# *4A3781BB0275*
	make_bool_result (in ? VARIANT_TRUE : VARIANT_FALSE, result);
	//#UC END# *4A3781BB0275*
}

void DispatchHelper::make_bool_result (VARIANT_BOOL in, VARIANT* result) {
	//#UC START# *4A3781CC0357*
	if (result) {
		V_BOOL(result) = in;
        V_VT(result) = VT_BOOL;
	}
	//#UC END# *4A3781CC0357*
}

void DispatchHelper::make_dispatch_result (IDispatch* in, VARIANT* result) {
	//#UC START# *4A3775AD01AA*
	if (result) {
		V_DISPATCH(result) = in;
		V_VT(result) = VT_DISPATCH;
	}
	//#UC END# *4A3775AD01AA*
}

void DispatchHelper::make_string_result (const std::string& in, VARIANT* result) {
	//#UC START# *4A3775B20051*
	if (result) {
		_bstr_t res = in.c_str ();
		V_BSTR(result) = res.Detach ();
		V_VT(result) = VT_BSTR;
	}
	//#UC END# *4A3775B20051*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

