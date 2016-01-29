////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrReplace.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrReplace
//
// реализация встроенной функции генератора "_str_replace".
// _str_replace (<строка>,<исходная подстрока>,<новая подстрока>) - заменяет в строку все исходные
// подстроки на новые
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrReplace.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StrReplace::StrReplace ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE4C401E7_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE4C401E7_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE4C401E7_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE4C401E7_BODY*
}

StrReplace::~StrReplace () {
	//#UC START# *4A2CE4C401E7_DESTR_BODY*
	//#UC END# *4A2CE4C401E7_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string StrReplace::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE4C401E7*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, 3, params.size ());
	}

	std::string ret = TemplatePainter::resolve_exp(params[0], painter);
	std::string source_substr = TemplatePainter::resolve_exp(params[1], painter);

	std::string target_substr;
	if (params.size() > 2) {
		target_substr = TemplatePainter::resolve_exp(params[2], painter);
	}
			
	GCL::str_replace (ret, source_substr.data(), target_substr.data());
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE4C401E7*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

