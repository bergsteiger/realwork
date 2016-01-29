////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Facade/Facade.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garantCore::Search::Facade::Facade
//
// Фасад
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FACADE_FACADE_H__
#define __GARANTCORE_SEARCH_FACADE_FACADE_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Facade/Factory.h"

//#UC START# *50F574C8029E_USER_INCLUDES*
#include "boost/function.hpp"
//#UC END# *50F574C8029E_USER_INCLUDES*

namespace Search {

//#UC START# *50F574C8029E_USER_DEFINITION*
typedef boost::function <SortedCollection* (const std::string&, unsigned long)> CallBack;
typedef boost::function <SortedCollection* (SearchBase*, const std::string&)> CallBackBase;

void register_key (const std::string& key, const CallBack& callback);
void register_key_base (const std::string& key, const CallBackBase& callback);

bool is_registered (const std::string& key);
bool is_registered_base (const std::string& key);

////////////////////////////////////////////////////////////////////////////////////////

class QueryData {
protected:
	QueryData (MergeOp op) : m_op (op) { }

public:
	virtual const IQuery* query () const = 0;

	MergeOp op () const { 
		return m_op; 
	}

private:
	MergeOp m_op;
};

class Query : virtual public QueryData {
public:
	Query (const std::string& type, const std::string& value, MergeOp op);

protected:
	virtual const IQuery* query () const;

private:
	mutable IQuery_var m_query;
};

class BooleanQuery : virtual public QueryData {
public:
	BooleanQuery (MergeOp op = Search::so_AND);
	BooleanQuery (const std::string& str, MergeOp op = Search::so_AND);

public:
	Search::SearchResult* execute (SearchBase* base, const SearchProp& prop);

	bool is_valid (SearchBase* base) const;

	const std::string& get_data () const;

	BooleanQuery& operator << (const QueryData& data);

	virtual const IQuery* query () const;

private:
	mutable IBooleanQuery_var m_query;
};
//#UC END# *50F574C8029E_USER_DEFINITION*

} // namespace Search


#endif //__GARANTCORE_SEARCH_FACADE_FACADE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
