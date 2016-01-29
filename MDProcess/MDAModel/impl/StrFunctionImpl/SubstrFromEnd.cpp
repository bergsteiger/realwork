////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromEnd.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SubstrFromEnd
//
// реализация встроенной функции генератора "_substr_from_end"
// _substr_from_end("<строка>",n) - возвращает n символов с конца строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromEnd.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SubstrFromEnd::SubstrFromEnd ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE72302CC_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE72302CC_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE72302CC_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE72302CC_BODY*
}

SubstrFromEnd::~SubstrFromEnd () {
	//#UC START# *4A2CE72302CC_DESTR_BODY*
	//#UC END# *4A2CE72302CC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SubstrFromEnd::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE72302CC*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}	
	std::string source_str = TemplatePainter::resolve_exp(params[0], painter);
	long symbols_count = boost::lexical_cast<long> (TemplatePainter::resolve_exp(params[1], painter));
	long skip_symbols = source_str.size () - symbols_count;
	if (skip_symbols < 0) {//если просят символов больше чем есть - отдаем всю строку
		skip_symbols = 0;
	}
	std::string ret (
		source_str.begin () + skip_symbols
		, source_str.end ()
	);
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE72302CC*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

