////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToLower.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToLower
//
// реализация встроенной функции генератора "_to_lower".
// _to_lower  ("<строка>") - изменяет регистр строки на lowercase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToLower.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ToLower::ToLower ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE768013F_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE768013F_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE768013F_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE768013F_BODY*
}

ToLower::~ToLower () {
	//#UC START# *4A2CE768013F_DESTR_BODY*
	//#UC END# *4A2CE768013F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ToLower::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE768013F*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string ret = TemplatePainter::resolve_exp(params[0], painter);
	GCL::to_lower(ret);
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE768013F*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

