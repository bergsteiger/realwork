////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/DebugFunc.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::DebugFunc
//
// реализация встроенной функции генератора "_dbg_point"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DebugFunc.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DebugFunc::DebugFunc ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE8150126_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE8150126_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE8150126_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE8150126_BODY*
}

DebugFunc::~DebugFunc () {
	//#UC START# *4A2CE8150126_DESTR_BODY*
	//#UC END# *4A2CE8150126_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string DebugFunc::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE8150126*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string dbg_id = TemplatePainter::resolve_exp (params[0], painter);
	TRACE ("DEBUG POINT: %s\n", dbg_id.data());
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CE8150126*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

