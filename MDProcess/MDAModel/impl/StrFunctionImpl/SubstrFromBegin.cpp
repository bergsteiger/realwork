////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SubstrFromBegin
//
// реализация встроенной функции генератора "_substr_from_begin"
// _substr_from_begin("<строка>",n) - возвращает n символов с начала строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SubstrFromBegin::SubstrFromBegin ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE6FA00E6_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE6FA00E6_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE6FA00E6_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE6FA00E6_BODY*
}

SubstrFromBegin::~SubstrFromBegin () {
	//#UC START# *4A2CE6FA00E6_DESTR_BODY*
	//#UC END# *4A2CE6FA00E6_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SubstrFromBegin::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE6FA00E6*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string source_str = TemplatePainter::resolve_exp(params[0], painter);
	std::string::size_type symbols_count = boost::lexical_cast<long> (TemplatePainter::resolve_exp(params[1], painter));
	if (symbols_count > source_str.size ()) {//если просят символов больше чем есть - отдаем всю строку
		symbols_count = source_str.size ();
	}
	std::string ret (
		source_str.begin () 
		, source_str.begin () + symbols_count
	);
	return ret;	
	//#UC END# *4A2CE18202C1_4A2CE6FA00E6*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

