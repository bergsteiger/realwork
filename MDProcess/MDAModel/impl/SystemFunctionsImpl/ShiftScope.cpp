////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftScope.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ShiftScope
//
// реализация встроенной функции генератора "_shift_scope".
// _shift_scope(true/false) - устанавливает флаг - нужно ли сдвинуть scope на один уровень.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftScope.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ShiftScope::ShiftScope ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC790020_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC790020_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC790020_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC790020_BODY*
}

ShiftScope::~ShiftScope () {
	//#UC START# *4A2CEC790020_DESTR_BODY*
	//#UC END# *4A2CEC790020_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ShiftScope::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEC790020*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string param = TemplatePainter::resolve_exp(params[0], painter);
	AbstractDumperBase::s_shift_scope = (param == "true");
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CEC790020*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

