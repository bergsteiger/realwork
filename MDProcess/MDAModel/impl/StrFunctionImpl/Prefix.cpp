////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/Prefix.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::Prefix
//
// Формат вызова:
// %f_prefix(строка,префикс) - если строка начинается с префикса - возвращает префикс, иначе
// возвращает исходную строку
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/Prefix.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Prefix::Prefix ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE43F03D6_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE43F03D6_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE43F03D6_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE43F03D6_BODY*
}

Prefix::~Prefix () {
	//#UC START# *4A2CE43F03D6_DESTR_BODY*
	//#UC END# *4A2CE43F03D6_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string Prefix::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE43F03D6*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string source_str = TemplatePainter::resolve_exp (params[0], painter);
	std::string prefix = TemplatePainter::resolve_exp (params[1], painter);

	if (GCL::start_with (source_str.c_str (), prefix.c_str ())) {
		return prefix;
	}
	return source_str;
	//#UC END# *4A2CE18202C1_4A2CE43F03D6*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

