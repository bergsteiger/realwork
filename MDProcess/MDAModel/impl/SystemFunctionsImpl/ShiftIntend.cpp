////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftIntend.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ShiftIntend
//
// реализация встроенной функции генератора "_shift_intend".
// _shift_intend(N) - изменяет величину отступа по команде # на величину N, где N - целое число со
// знаком.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftIntend.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ShiftIntend::ShiftIntend ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC5F02EA_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC5F02EA_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC5F02EA_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC5F02EA_BODY*
}

ShiftIntend::~ShiftIntend () {
	//#UC START# *4A2CEC5F02EA_DESTR_BODY*
	//#UC END# *4A2CEC5F02EA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ShiftIntend::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEC5F02EA*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string value = TemplatePainter::resolve_exp(params[0], painter);
	AbstractDumperBase::s_intend_shift += atoi(value.c_str());
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CEC5F02EA*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

