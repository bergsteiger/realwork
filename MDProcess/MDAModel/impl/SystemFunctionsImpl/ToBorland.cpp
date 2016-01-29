////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToBorland.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToBorland
//
// реализация встроенной функции генератора "_to_borland"
// _to_borland (<шаблон>) - конвертирует строку <шаблон> в стиль «Borland» - составные части
// склеены и начинаются с заглавных букв
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToBorland.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ToBorland::ToBorland ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CECA2024F_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CECA2024F_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CECA2024F_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CECA2024F_BODY*
}

ToBorland::~ToBorland () {
	//#UC START# *4A2CECA2024F_DESTR_BODY*
	//#UC END# *4A2CECA2024F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ToBorland::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CECA2024F*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string ret = TemplatePainter::resolve_exp(params[0], painter);
	return GCL::convert_to_borland_style(ret, GCL::CI_FUNCTION);
	//#UC END# *4A2CE18202C1_4A2CECA2024F*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

