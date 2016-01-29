////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Facade/Helper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Facade::Helper
//
// ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FACADE_HELPER_H__
#define __GARANTCORE_SEARCH_FACADE_HELPER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"

namespace Search {

// ��������
class Helper {
	SET_OBJECT_COUNTER (Helper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����������� ���������
	static SearchAdapterLib::Adapter::IFragments* get_fragments (SearchBase* base, const char* in, long doc_id, long para);

	// ������� ����������� ����������
	static SearchAdapterLib::Adapter::IPositions* get_positions (SearchBase* base, const GCL::StrVector& reqs, long doc_id);

	// �������� memcache
	static void load_memcache (const SearchAdapterLib::Adapter::MemCacheSettings& settings);

	// ������� �����
	static void reset ();

private:
	// searcher
	static SearchAdapterLib::Adapter::ISearcher* get_searcher (SearchBase* base, long id);

}; // class Helper

} // namespace Search


#endif //__GARANTCORE_SEARCH_FACADE_HELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

