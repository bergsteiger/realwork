////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Queries_i/Query_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Queries_i::Query_i
//
// Реализация интерфейса запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_QUERIES_I_QUERY_I_H__
#define __GARANTCORE_SEARCH_QUERIES_I_QUERY_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Def/Def.h"

namespace Search {
namespace Queries_i {

// Реализация интерфейса запроса
class Query_i;
typedef Core::Var<Query_i> Query_i_var;
typedef Core::Var<const Query_i> Query_i_cvar;

class Query_i :
	virtual public IQuery
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Query_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	Query_i (const std::string& type, const std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_data;

	std::string m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IQuery
	// данные
	const std::string& get_data () const;

	// implemented method from IQuery
	// тип
	const std::string& get_type () const;
}; // class Query_i

} // namespace Queries_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_QUERIES_I_QUERY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

