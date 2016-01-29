////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::MDAModel::RoseInternal::DispatchHelper
//
// вспомогательный набор функций для реализации IDispatch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_DISPATCHHELPER_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_DISPATCHHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *4A3774B900C6_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
//#UC END# *4A3774B900C6_CUSTOM_INCLUDES*

namespace RoseInternal {

// вспомогательный набор функций для реализации IDispatch
class DispatchHelper {
	SET_OBJECT_COUNTER (DispatchHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	static void make_bool_result (bool in, VARIANT* result);

	static void make_bool_result (VARIANT_BOOL in, VARIANT* result);

	static void make_dispatch_result (IDispatch* in, VARIANT* result);

	static void make_string_result (const std::string& in, VARIANT* result);


//#UC START# *4A3774B900C6*
//#UC END# *4A3774B900C6*
}; // class DispatchHelper

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_DISPATCHHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

