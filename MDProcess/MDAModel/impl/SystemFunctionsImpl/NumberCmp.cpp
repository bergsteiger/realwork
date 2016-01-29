////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NumberCmp
//
// реализация встроенной функции генератора _number_cmp
// _number_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает как числа строку1 со
// строкой2 применяя заданную операцию (>,<,==, !=, >=, <=). Если результат сравнения - истина,
// возвращает 1, в противном случае 0.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NumberCmp::NumberCmp ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CF2F20307_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CF2F20307_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CF2F20307_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CF2F20307_BODY*
}

NumberCmp::~NumberCmp () {
	//#UC START# *4A2CF2F20307_DESTR_BODY*
	//#UC END# *4A2CF2F20307_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string NumberCmp::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CF2F20307*
	if (params.size () < 3) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 3, params.size ());
	}
	std::string first_str = TemplatePainter::resolve_exp(params[0], painter);
	std::string second_str = TemplatePainter::resolve_exp(params[1], painter);
	std::string op = TemplatePainter::resolve_exp(params[2], painter);

	first_str = first_str.substr (1, first_str.length () - 2);
	second_str = second_str.substr (1, second_str.length () - 2);		

	long first;
	long second;

	try {
		first = boost::lexical_cast<long> (
			first_str
		);
		second = boost::lexical_cast<long> (
			second_str
		);
	} catch (boost::bad_lexical_cast&) {
		std::string mess ("Bad params in function: ");
		mess += GDS_CURRENT_FUNCTION;
		mess += " (";
		mess += first_str;
		mess += ", ";
		mess += second_str;
		mess += ", ";
		mess += op;
		
		throw Base::FatalError (mess);
	}		

	bool res;
	if (op == "\"<\"") {
		res = first < second;
	} else if (op == "\"<=\"") {
		res = first <= second;
	} else if (op == "\">\"") {
		res = first > second;
	} else if (op == "\">=\"") {
		res = first >= second;
	} else if (op == "\"==\"") {
		res = first == second;
	} else if (op == "\"!=\"") {
		res = first != second;
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += ", unknown comapre operation: ";
		mess == op;
		throw Base::FatalError (mess);
	}
	return res ? "1" : "0";
	//#UC END# *4A2CE18202C1_4A2CF2F20307*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

