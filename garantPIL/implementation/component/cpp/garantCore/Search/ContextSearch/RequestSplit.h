////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/RequestSplit.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::RequestSplit
//
// Разделение запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_CONTEXTSEARCH_REQUESTSPLIT_H__
#define __GARANTCORE_SEARCH_CONTEXTSEARCH_REQUESTSPLIT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"

namespace Search {

// Разделение запроса
class RequestSplit {
	SET_OBJECT_COUNTER (RequestSplit)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// validate
	static void validate (const std::string& str, std::string& out);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit RequestSplit (SearchBase* base);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// execute
	bool execute (const std::string& req, std::string& name_part, std::string& text_part);

private:
	// is_equal
	bool is_equal (const std::string& str, const std::string& syn, std::string& out);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	const GCL::StrVector& m_data;

	Morpho::Def::INormalizer_var m_normalizer;
}; // class RequestSplit

} // namespace Search


#endif //__GARANTCORE_SEARCH_CONTEXTSEARCH_REQUESTSPLIT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

