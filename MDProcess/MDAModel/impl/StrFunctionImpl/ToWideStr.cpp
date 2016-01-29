////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToWideStr
//
// реализация встроенной функции генератора "_to_wide_str"
// _to_wide_str (<строка>, <префикс>, <открывающий символ>, <закрывающий символ>) - трансформирует
// строку в wide-коды, если задан открывающий символ то английские символы сохраняются в ASCI-
// формате и обрамляются указанными символами.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ToWideStr::ToWideStr ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE7DA02AD_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE7DA02AD_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE7DA02AD_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE7DA02AD_BODY*
}

ToWideStr::~ToWideStr () {
	//#UC START# *4A2CE7DA02AD_DESTR_BODY*
	//#UC END# *4A2CE7DA02AD_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ToWideStr::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE7DA02AD*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, 4, params.size ());
	}
	std::string ret = TemplatePainter::resolve_exp(params[0], painter);
	char prefix = 0;
	char open = 0;
	char close = 0;
	bool keep_eng = false;
	
	if (params.size() > 1) {
		prefix = params[1][0];
	}

	if (params.size() > 2) {
		open = params[2][0];
		keep_eng = true;
	}

	if (params.size() > 3 && !params[3].empty ()) {
		close = params[3][0];
	}

	return GCL::multibyte_to_str (ret, prefix, keep_eng, open, close);
	//#UC END# *4A2CE18202C1_4A2CE7DA02AD*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

