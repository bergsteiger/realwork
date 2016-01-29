////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Cache/AttrCache.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Cache::AttrCache
//
// Кэш типов атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Cache/AttrCache.h"
// by <<uses>> dependencies
#include "boost/assign/std/set.hpp"

namespace Search {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AttrCache::AttrCache ()
//#UC START# *50D1D7C00052_BASE_INIT*
//#UC END# *50D1D7C00052_BASE_INIT*
{
	//#UC START# *50D1D7C00052_BODY*
	using namespace boost::assign;

	m_date_attr += "RDate", "Date", "AnnoDate", "Active", "RegDate", "AnnulDate";
	m_date_attr += "CalAll", "CalIn", "CalAb", "CalCh", "SortDate", "VAnonced", "VIncluded";

	m_int_attr += "Segment", "Status", "Status_ex", "NewCorr";
	m_str_attr += "Category", "Number", "RCode", "IntName", "TradeName", "Tag";
	//#UC END# *50D1D7C00052_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// тип атрибута
AttrCache::AttributeType AttrCache::get_type (const std::string& str) const {
	//#UC START# *50D1D7D101E9*
	if (std::binary_search (m_date_attr.begin (), m_date_attr.end (), str)) {
		return at_Date;
	} else if (std::binary_search (m_str_attr.begin (), m_str_attr.end (), str)) {
		return at_String;
	} else if (std::binary_search (m_int_attr.begin (), m_int_attr.end (), str)) {
		return at_Integer;
	}
	return at_Hierarchical;
	//#UC END# *50D1D7D101E9*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

