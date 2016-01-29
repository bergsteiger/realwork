////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Facade/Factory.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Facade::Factory
//
// Фасад
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Facade/Factory.h"
// by <<uses>> dependencies
#include "garantCore/Search/impl/Queries_i/BooleanQuery_i.h"
#include "garantCore/Search/impl/Queries_i/Query_i.h"
#include "garantCore/Search/impl/Searcher_i/Searcher_i.h"

namespace Search {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// фабрика
IBooleanQuery* Factory::make_boolean_query () {
	//#UC START# *509D392202E2*
	return new Queries_i::BooleanQuery_i ();
	//#UC END# *509D392202E2*
}

// фабрика
IBooleanQuery* Factory::make_boolean_query (const std::string& str) {
	//#UC START# *55B8C9FE009A*
	return new Queries_i::BooleanQuery_i (str);
	//#UC END# *55B8C9FE009A*
}

// фабрика
IQuery* Factory::make_query (const std::string& type, const std::string& str) {
	//#UC START# *509D3CBC0205*
	return new Queries_i::Query_i (type, str);
	//#UC END# *509D3CBC0205*
}

// фабрика
ISearcher* Factory::make_searcher (SearchBase* base) {
	//#UC START# *509D389B01AB*
	return new Searcher_i::Searcher_i (base);
	//#UC END# *509D389B01AB*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

