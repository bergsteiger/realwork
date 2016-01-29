////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Facade/Facade.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garantCore::Search::Facade::Facade
// Файл реализации утилитного набора Facade
//
// Фасад
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Facade/Facade.h"

//#UC START# *50F574C8029E_CUSTOM_INCLUDES*
#include "garantCore/Search/impl/Searcher_i/Invoker.h"
#include "garantCore/Search/impl/Searcher_i/SearchHelper.h"
//#UC END# *50F574C8029E_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *50F574C8029E*

////////////////////////////////////////////////////////////////////////////////////////
// Register key
void register_key (const std::string& key, const CallBack& call_back) {
	Searcher_i::Invoker::instance ()->add (key, call_back);
}

void register_key_base (const std::string& key, const CallBackBase& call_back) {
	Searcher_i::Invoker::instance ()->add (key, call_back);
}

bool is_registered (const std::string& key) {
	return Searcher_i::Invoker::instance ()->is_exist (key, false);
}

bool is_registered_base (const std::string& key) {
	return Searcher_i::Invoker::instance ()->is_exist (key, true);
}

////////////////////////////////////////////////////////////////////////////////////////
// class Query implementation

// NonContextQuery
Query::Query (const std::string& type, const std::string& value, MergeOp op) 
	: QueryData (op) 
	, m_query (Factory::make_query (type, value)) {
}

const IQuery* Query::query () const {
	return m_query.in ();
}

////////////////////////////////////////////////////////////////////////////////////////
// class BooleanQuery implementation

BooleanQuery::BooleanQuery (MergeOp op)
	: QueryData (op)
	, m_query (Factory::make_boolean_query ()) {
}

BooleanQuery::BooleanQuery (const std::string& str, MergeOp op) 
	: QueryData (op)
	, m_query (Factory::make_boolean_query (str)) {
}

const IQuery* BooleanQuery::query () const {
	return m_query.in ();
}

Search::SearchResult* BooleanQuery::execute (SearchBase* base, const SearchProp& prop) {
	ISearcher_var searcher = Factory::make_searcher (base);
	return searcher->execute (m_query.in (), prop);
}

bool BooleanQuery::is_valid (SearchBase* base) const {
	return Searcher_i::SearchHelper::check_query (base, m_query->get_data ());
}

const std::string& BooleanQuery::get_data () const {
	return m_query->get_data ();
}

BooleanQuery& BooleanQuery::operator << (const QueryData& data) {
	m_query->add (const_cast <IQuery*> (data.query ()), data.op ());
	return *this;
}

////////////////////////////////////////////////////////////////////////////////////////
//#UC END# *50F574C8029E*

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

