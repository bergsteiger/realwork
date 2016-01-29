////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToOmg.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToOmg
//
// реализация встроенной функции генератора "_to_omg"
// _to_omg (<шаблон>) - конвертирует строку <шаблон> в стиль «OMG» - составные части с маленьких
// букв разделенных символом подчеркивания
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToOmg.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ToOmg::ToOmg ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CECE100F9_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CECE100F9_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CECE100F9_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CECE100F9_BODY*
}

ToOmg::~ToOmg () {
	//#UC START# *4A2CECE100F9_DESTR_BODY*
	//#UC END# *4A2CECE100F9_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ToOmg::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CECE100F9*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string ret = TemplatePainter::resolve_exp(params[0], painter);
	return GCL::convert_to_omg_style(ret, GCL::CI_FUNCTION);
	//#UC END# *4A2CE18202C1_4A2CECE100F9*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

