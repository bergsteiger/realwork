////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ParsersImpl/OperationParserImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ParsersImpl::OperationParserImpl
//
// реализация парсера сигнатуры функции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/ParsersImpl/OperationParserImpl.h"
// by <<uses>> dependencies
#include "boost/regex.hpp"
#include "shared/GCL/str/str_op.h"
#include "boost/token_iterator.hpp"

namespace ParsersImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

OperationParserImpl::OperationParserImpl ()
//#UC START# *4A388D0203B2_4A38BE54018D_4A388FD20240_BASE_INIT*
//#UC END# *4A388D0203B2_4A38BE54018D_4A388FD20240_BASE_INIT*
{
	//#UC START# *4A388D0203B2_4A38BE54018D_4A388FD20240_BODY*
	//#UC END# *4A388D0203B2_4A38BE54018D_4A388FD20240_BODY*
}

OperationParserImpl::~OperationParserImpl () {
	//#UC START# *4A388FD20240_DESTR_BODY*
	//#UC END# *4A388FD20240_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Parsers::OperationParser
// возвращает данные операции
Parsers::OperationData* OperationParserImpl::parse (const std::string& source) {
	//#UC START# *4A38BD8202C4_4A388FD20240*
	boost::regex operation_exp ("(.*)\\((.*)\\)\\s*:?(.*)");
	boost::smatch op_match;
	if (!regex_match (source, op_match, operation_exp)) {
		throw Parsers::ParseError ("Неверный формат операции");
	}
	
	Core::Aptr<Parsers::OperationData> data (new Parsers::OperationData ());

	std::string name (op_match[1].first, op_match[1].second);
	data->name = GCL::trim_ws(name.data());
	
	std::string params_str (op_match[2].first, op_match[2].second); 
	
	std::string return_type (op_match[3].first, op_match[3].second);
	data->return_type = GCL::trim_ws(return_type.data());
	
	boost::char_separator<char> sep (",;", "", boost::drop_empty_tokens);
	typedef boost::token_iterator_generator<boost::char_separator<char>>::type TokenIter;

	TokenIter tok_begin = boost::make_token_iterator<std::string> (
		params_str.begin(), params_str.end(), sep
	);

	TokenIter tok_end = boost::make_token_iterator<std::string> (
		params_str.end(), params_str.end(), sep
	); 

	for (TokenIter it = tok_begin; it != tok_end; ++it) {										
		Core::Aptr<Parsers::AttributeData> attr_data = Parsers::AttributeParserFactory::get ().parse (*it);
		if (attr_data->type.empty ()) {
			throw Parsers::ParseError ("Не задан тип параметра операции");		
		}
		data->parameters.push_back (*attr_data);
	}

	return data.forget ();
	//#UC END# *4A38BD8202C4_4A388FD20240*
}
} // namespace ParsersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

