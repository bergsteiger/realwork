////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/LoadList_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Filters_i::LoadList_i
//
// ���������� ���������� IFilter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FILTERS_I_LOADLIST_I_H__
#define __GARANTCORE_SEARCH_FILTERS_I_LOADLIST_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantCore/Search/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/index.h"

//#UC START# *52FA456D02C7_CUSTOM_INCLUDES*
//#UC END# *52FA456D02C7_CUSTOM_INCLUDES*

namespace Search {

// ���������� ���������� IFilter
class LoadList_i;
typedef Core::Var<LoadList_i> LoadList_i_var;
typedef Core::Var<const LoadList_i> LoadList_i_cvar;

class LoadList_i :
	virtual public SearchAdapterLib::Adapter::IFilter
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LoadList_i)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ���������
	static const int ItemCount; // ���������� ���������

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	LoadList_i (Index* index, const char* key, MergeOp op);

public:
	~LoadList_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������
	bool load ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchAdapterLib::Adapter::LongVector m_data;

	Index* m_index;

	unsigned short m_item_size;

	unsigned long m_last_id;

	MergeOp m_op;

	bool m_stop;

	size_t m_total;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContextSearch::Defs::IFilter
	// check
	bool check (ContextSearch::Defs::DocId val);

	// implemented method from ContextSearch::Defs::IFilter
	// check
	bool check () const;

	// implemented method from ContextSearch::Defs::IFilter
	// ������� ��������
	ContextSearch::Defs::IFilter* duplicate ();

	// implemented method from ContextSearch::Defs::IFilter
	// logic op
	char get_op () const;

	// implemented method from ContextSearch::Defs::IFilter
	// size
	size_t get_size () const;

	// implemented method from ContextSearch::Defs::IFilter
	// reset
	void reset ();

	// implemented method from ContextSearch::Defs::IFilter
	// type
	const char* type () const;

//#UC START# *52FA456D02C7*
private:
	Stream* m_store;
//#UC END# *52FA456D02C7*
}; // class LoadList_i

} // namespace Search


#endif //__GARANTCORE_SEARCH_FILTERS_I_LOADLIST_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

