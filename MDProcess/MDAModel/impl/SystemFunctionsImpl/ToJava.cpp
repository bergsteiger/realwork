////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToJava.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToJava
//
// реализация встроенной функции генератора "_to_java"
// _to_java (<шаблон>) - конвертирует строку <шаблон> в стиль «Java» - составные части склеены и
// начинаются с заглавных букв (кроме первой части)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToJava.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ToJava::ToJava ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CECBF0234_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CECBF0234_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CECBF0234_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CECBF0234_BODY*
}

ToJava::~ToJava () {
	//#UC START# *4A2CECBF0234_DESTR_BODY*
	//#UC END# *4A2CECBF0234_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ToJava::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CECBF0234*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string ret = TemplatePainter::resolve_exp(params[0], painter);
	return GCL::convert_to_java_style(ret, GCL::CI_FUNCTION);
	//#UC END# *4A2CE18202C1_4A2CECBF0234*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

