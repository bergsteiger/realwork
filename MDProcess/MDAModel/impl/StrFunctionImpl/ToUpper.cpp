////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToUpper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToUpper
//
// реализация встроенной функции генератора "_to_upper".
// _to_upper ("<строка>")  - изменяет регистр строки на uppercase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToUpper.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ToUpper::ToUpper ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE7B40017_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE7B40017_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE7B40017_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE7B40017_BODY*
}

ToUpper::~ToUpper () {
	//#UC START# *4A2CE7B40017_DESTR_BODY*
	//#UC END# *4A2CE7B40017_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ToUpper::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE7B40017*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string ret = TemplatePainter::resolve_exp(params[0], painter);
	GCL::to_upper(ret);
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE7B40017*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

