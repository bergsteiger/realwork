////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ConsistOf.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ConsistOf
//
// реализация встроенной функции генератора:
// _consist_of(строка,список символов) - проверят, что исходная строка состоит только из
// определённых символов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ConsistOf.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsistOf::ConsistOf ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CF65700DE_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CF65700DE_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CF65700DE_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CF65700DE_BODY*
}

ConsistOf::~ConsistOf () {
	//#UC START# *4A2CF65700DE_DESTR_BODY*
	//#UC END# *4A2CF65700DE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ConsistOf::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CF65700DE*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}

	std::string source_str = TemplatePainter::resolve_exp (params[0], painter);
	std::string symbols_str = TemplatePainter::resolve_exp (params[1], painter);

	std::string res ("true");
	
	std::string::const_iterator it = source_str.begin ();
	std::string::const_iterator it_end = source_str.end ();

	for (; it != it_end; ++it) {
		if (symbols_str.find (*it) == std::string::npos) {
			//не нашли символ - выходим
			res = "false";
			break;
		}
	}
	return res;
	//#UC END# *4A2CE18202C1_4A2CF65700DE*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

