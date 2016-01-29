////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrToRule.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrToRule
//
// конвертирует переданную строчку в грамматическое правило, например строчка "pack|package"
// сконвертируется в ("pack"|"package")
// 
// Использование:
// %f_str_to_rule(pack|package)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrToRule.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StrToRule::StrToRule ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE50C0124_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE50C0124_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE50C0124_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE50C0124_BODY*
}

StrToRule::~StrToRule () {
	//#UC START# *4A2CE50C0124_DESTR_BODY*
	//#UC END# *4A2CE50C0124_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string StrToRule::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE50C0124*
	class StringQuoter : public std::unary_function <std::string, std::string> {
	public:
		std::string operator () (const std::string& source) {
			std::string ret ("\"");
			ret += source;
			ret += "\"";

			return ret;
		}
	};

	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string source_str = TemplatePainter::resolve_exp (params[0], painter);
	
	std::string result;
	if (source_str.empty () == false) {
		GCL::StrVector ws_items = GCL::split_string_by (source_str.c_str (), ' ');
		GCL::StrVector res_ws_items;
		std::string local_result;
		for (
			GCL::StrVector::iterator it = ws_items.begin ()
			; it != ws_items.end ()
			; ++it
		) {
			//список элементов, объединённых по ИЛИ
			GCL::StrVector or_items = GCL::split_string_by (it->c_str (), '|');
			if (or_items.size () == 1) {
				//список элементов, объединённых по НЕ
				StringQuoter quoter;
				local_result = quoter (*it);
			} else {
				StringQuoter quoter;
				std::transform (or_items.begin (), or_items.end (), or_items.begin (), quoter);

				std::string res ("(");
				res += GCL::join (or_items, "|");
				res += ")";
				local_result = res;
			}
			res_ws_items.push_back (local_result);
		}
		result = GCL::join (res_ws_items, " ");
	}
	return result;
	//#UC END# *4A2CE18202C1_4A2CE50C0124*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

