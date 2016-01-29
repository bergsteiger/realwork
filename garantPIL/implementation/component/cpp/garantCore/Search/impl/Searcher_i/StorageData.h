////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/StorageData.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::StorageData
//
// StorageData
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_SEARCHER_I_STORAGEDATA_H__
#define __GARANTCORE_SEARCH_SEARCHER_I_STORAGEDATA_H__

#include "shared/Core/sys/std_inc.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/index.h"

//#UC START# *5107F94B015E_CUSTOM_INCLUDES*
//#UC END# *5107F94B015E_CUSTOM_INCLUDES*

namespace Search {
namespace Searcher_i {

// StorageData
class StorageData {
	SET_OBJECT_COUNTER (StorageData)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ������� ��� ��������� ��������� ����
	static SortedCollection* make (long type);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit StorageData (SearchBase* base);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������
	SortedCollection* _retn ();

	// ��������
	void add (const char* name, const char* from, const char* to);

	// ������
	SortedCollection* get (const char* name, const char* val);

private:
	// ��������
	void add (Index* index, const void* key);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchBase* m_base;

//#UC START# *5107F94B015E*
	Core::Aptr <SortedCollection> m_data;
//#UC END# *5107F94B015E*
}; // class StorageData

} // namespace Searcher_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_SEARCHER_I_STORAGEDATA_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

