////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromBegin.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromBegin
//
// реализация встроенной функции генератора "_delsubstr_from_begin"
// _delsubstr_from_begin("<строка>",n) - удаляет n символов с начала строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromBegin.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DelSubstrFromBegin::DelSubstrFromBegin ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE3B603C9_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE3B603C9_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE3B603C9_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE3B603C9_BODY*
}

DelSubstrFromBegin::~DelSubstrFromBegin () {
	//#UC START# *4A2CE3B603C9_DESTR_BODY*
	//#UC END# *4A2CE3B603C9_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string DelSubstrFromBegin::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE3B603C9*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}

	std::string source_str = TemplatePainter::resolve_exp(params[0], painter);
	std::string::size_type symbols_count = boost::lexical_cast<long> (TemplatePainter::resolve_exp(params[1], painter));
	if (symbols_count > source_str.size ()) {//если просят символов больше чем есть - удаляем всю строку
		symbols_count = source_str.size ();
	}	

	return source_str.substr (symbols_count);
	//#UC END# *4A2CE18202C1_4A2CE3B603C9*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

