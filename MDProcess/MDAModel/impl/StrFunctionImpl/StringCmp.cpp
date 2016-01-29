////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringCmp
//
// реализация встроенной функции генератора _string_cmp
// _string_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает строку1 со строкой2
// применяя заданную операцию (>,<,==, !=, >=, <=)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StringCmp::StringCmp ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE590011F_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE590011F_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE590011F_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE590011F_BODY*
}

StringCmp::~StringCmp () {
	//#UC START# *4A2CE590011F_DESTR_BODY*
	//#UC END# *4A2CE590011F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string StringCmp::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE590011F*
	if (params.size () < 3) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 3, params.size ());
	}
	std::string first = TemplatePainter::resolve_exp(params[0], painter);
	std::string second = TemplatePainter::resolve_exp(params[1], painter);
	std::string op = TemplatePainter::resolve_exp(params[2], painter);

	std::string ret;
	if (op == "\"<\"") {
		ret = boost::lexical_cast<std::string> (first < second);
	} else if (op == "\"<=\"") {
		ret = boost::lexical_cast<std::string> (first <= second);
	} else if (op == "\">\"") {
		ret = boost::lexical_cast<std::string> (first > second);
	} else if (op == "\">=\"") {
		ret = boost::lexical_cast<std::string> (first >= second);
	} else if (op == "\"==\"") {
		ret = boost::lexical_cast<std::string> (first == second);
	} else if (op == "\"!=\"") {
		ret = boost::lexical_cast<std::string> (first != second);
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += ", unknown compare operation: ";
		mess += op;
		throw Base::FatalError (mess);
	}
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE590011F*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

