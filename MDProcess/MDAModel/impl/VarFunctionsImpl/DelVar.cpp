////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/DelVar.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::DelVar
//
// реализация встроенной функции генератора _del_var.
// _del_var («идентификатор») - удаляет глобальную переменную (область видимость неограничена)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/DelVar.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DelVar::DelVar ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDF6F01D4_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDF6F01D4_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDF6F01D4_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDF6F01D4_BODY*
}

DelVar::~DelVar () {
	//#UC START# *4A2CDF6F01D4_DESTR_BODY*
	//#UC END# *4A2CDF6F01D4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string DelVar::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDF6F01D4*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);
	TemplatePainter::delete_var_dumper (var_id);

	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDF6F01D4*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

