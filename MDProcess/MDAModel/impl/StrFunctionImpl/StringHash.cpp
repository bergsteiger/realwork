////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringHash.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringHash
//
// реализация встроенной функции генератора "_string_hash"
// _string_hash("<строка>") - хэш переданной строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringHash.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"
#include "boost/functional/hash/hash.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StringHash::StringHash ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE6BB0290_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE6BB0290_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE6BB0290_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE6BB0290_BODY*
}

StringHash::~StringHash () {
	//#UC START# *4A2CE6BB0290_DESTR_BODY*
	//#UC END# *4A2CE6BB0290_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string StringHash::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE6BB0290*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string source_str = TemplatePainter::resolve_exp(params[0], painter);
	boost::hash<std::string> str_hash;		
	std::string ret = boost::lexical_cast<std::string> (str_hash (source_str));
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE6BB0290*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

