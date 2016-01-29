////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrSplit
//
// реализация встроенной функции генератора "_str_split".
// _str_split ("<строка>","<префикс>","<разделитель>") - разбивает строку на n-строк с заданным
// префиксом и разделителем (размер одной части пока что задан жестко в генераторе)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StrSplit::StrSplit ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE4E70116_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE4E70116_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE4E70116_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE4E70116_BODY*
}

StrSplit::~StrSplit () {
	//#UC START# *4A2CE4E70116_DESTR_BODY*
	//#UC END# *4A2CE4E70116_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string StrSplit::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE4E70116*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, 4, params.size ());
	}
	std::string ret = TemplatePainter::resolve_exp(params[0], painter);
	
	size_t split_len = 100;
	std::string prefix;

	if (params.size() > 1) {
		prefix = TemplatePainter::resolve_exp(params[1], painter);
	}
	
	if (params.size() > 3) {
		std::string param = TemplatePainter::resolve_exp(params[3], painter);
		try {
			split_len = boost::lexical_cast<size_t> (param);
		} catch (boost::bad_lexical_cast&) {
			LOG_E (("Wrong split size param: %s", param.c_str ()));
		}
	}
	split_len -= prefix.size ();
	GCL::StrVector strs = GCL::split_string_format (ret.c_str(), split_len);
	
	std::string sep;
	if (params.size() > 2) {
		sep = TemplatePainter::resolve_exp(params[2], painter);
	} else {
		sep = "\n";
	}
			
	ret = "";
	for (GCL::StrVector::iterator it = strs.begin(); it != strs.end(); it++) {
		ret += prefix + GCL::trim_ws(it->c_str ());
		if (std::distance (it, strs.end()) > 1) {
			ret += sep;
		}
	}
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE4E70116*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

