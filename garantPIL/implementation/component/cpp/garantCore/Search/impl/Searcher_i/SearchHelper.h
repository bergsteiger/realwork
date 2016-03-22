////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/SearchHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Searcher_i::SearchHelper
//
// ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_SEARCHER_I_SEARCHHELPER_H__
#define __GARANTCORE_SEARCH_SEARCHER_I_SEARCHHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/Base.h"

namespace Search {
namespace Searcher_i {

// ��������
class SearchHelper {
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� �� ����������
	static bool check_query (Base* base, const std::string& in);

	// ����������� ���������
	static SortedCollection* copy_collection (const SortedCollection* in);

	// ���������
	static short get_data_priority (short type);

	// ������� ������ ��� ���������
	static char* make_date_key (const std::string& str);

	// ������� ������ ��� ���������
	static char* make_key (Base* base, const QueryTag& tag);

	// �������������
	static SortedCollection* transform_for_title_search (SortedCollection* in, const SortedCollection* list);

}; // class SearchHelper

} // namespace Searcher_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_SEARCHER_I_SEARCHHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

