////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ParsersImpl/AttributeParserImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ParsersImpl::AttributeParserImpl
//
// реализация парсера атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/ParsersImpl/AttributeParserImpl.h"
// by <<uses>> dependencies
#include "boost/regex.hpp"
#include "shared/GCL/str/str_op.h"

namespace ParsersImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AttributeParserImpl::AttributeParserImpl ()
//#UC START# *4A388B7501E9_4A38BE5001B5_4A3890230033_BASE_INIT*
//#UC END# *4A388B7501E9_4A38BE5001B5_4A3890230033_BASE_INIT*
{
	//#UC START# *4A388B7501E9_4A38BE5001B5_4A3890230033_BODY*
	//#UC END# *4A388B7501E9_4A38BE5001B5_4A3890230033_BODY*
}

AttributeParserImpl::~AttributeParserImpl () {
	//#UC START# *4A3890230033_DESTR_BODY*
	//#UC END# *4A3890230033_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Parsers::AttributeParser
// парсит строку, в случае успеха возвращает true
Parsers::AttributeData* AttributeParserImpl::parse (const std::string& source) /*throw (Parsers::ParseError)*/ {
	//#UC START# *4A38BD330207_4A3890230033*
	boost::regex param_exp ("^[[:space:]]*([\\w]+[^:=]*)?[[:space:]]*(:[^=]+[[:space:]]*)?[=|[:space:]]*[[:space:]]*(.*)");
	boost::smatch param_match;
	if (
		!regex_match (source, param_match, param_exp)
		|| param_match.size () < 2
	) {		
		throw Parsers::ParseError ("Неверный формат атрибута");
	}

	Core::Aptr<Parsers::AttributeData> data (new Parsers::AttributeData ());
	std::string arg (param_match[1].first, param_match[1].second);
	GCL::StrVector arg_vec = GCL::split_string_by (arg.data(), ' ');
	if (arg_vec.size () > 1 && arg_vec[0] == "var") {
		arg = "inout ";
		arg += arg_vec[1];
	}

	std::string arg_type;
	if (param_match.size () > 2) {
		arg_type.assign (param_match[2].first, param_match[2].second);
		if (!arg_type.empty ()) {
			//отрезаем первый символ, т.к он согласно регулярному выражению
			//является ":"
			arg_type.erase (0, 1);
		}
	}

	std::string arg_init;
	if (param_match.size () > 3) {
		arg_init.assign (param_match[3].first, param_match[3].second);
	}

	data->name = GCL::trim_ws(arg.data());
	data->type = GCL::trim_ws(arg_type.data());
	data->init_value = GCL::trim_ws(arg_init.data());

	if (data->name.empty ()) {
		throw Parsers::ParseError ("Имя параметра не может быть пустым");		
	}

	return data.forget ();
	//#UC END# *4A38BD330207_4A3890230033*
}
} // namespace ParsersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

