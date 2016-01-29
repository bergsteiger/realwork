////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/SetGenID.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::SetGenID
//
// реализация встроенной функции генератора "_set_gen_id"
// _set_gen_id(«gen id») - устанавливает генератор.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/SetGenID.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetGenID::SetGenID ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC230045_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC230045_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC230045_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC230045_BODY*
}

SetGenID::~SetGenID () {
	//#UC START# *4A2CEC230045_DESTR_BODY*
	//#UC END# *4A2CEC230045_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetGenID::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEC230045*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	std::string new_gen_id = TemplatePainter::resolve_exp(params[0], painter);

	AbstractDumperBase::s_current_map = new_gen_id;

	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CEC230045*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

