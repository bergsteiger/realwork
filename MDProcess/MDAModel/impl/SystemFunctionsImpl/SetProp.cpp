////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/SetProp.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::SetProp
//
// реализация встроенной функции генератора "_set_prop"
// _set_prop(«prop id»,«value») - устанавливает свойству ГЕНЕРАТОРА указанное значение.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/SetProp.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetProp::SetProp ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC450138_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC450138_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC450138_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC450138_BODY*
}

SetProp::~SetProp () {
	//#UC START# *4A2CEC450138_DESTR_BODY*
	//#UC END# *4A2CEC450138_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetProp::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEC450138*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string prop_id = TemplatePainter::resolve_exp(params[0], painter);
	std::string prop_val = TemplatePainter::resolve_exp(params[1], painter);
	AbstractDumperBase::s_gen_infos[AbstractDumperBase::s_current_map]->set_property (prop_id, prop_val);

	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CEC450138*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

