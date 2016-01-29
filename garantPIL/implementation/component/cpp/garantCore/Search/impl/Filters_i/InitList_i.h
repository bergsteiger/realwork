////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/InitList_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Filters_i::InitList_i
//
// Реализация интерфейса IFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FILTERS_I_INITLIST_I_H__
#define __GARANTCORE_SEARCH_FILTERS_I_INITLIST_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantCore/Search/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"

//#UC START# *52F0E0B5016E_CUSTOM_INCLUDES*
//#UC END# *52F0E0B5016E_CUSTOM_INCLUDES*

namespace Search {

// Реализация интерфейса IFilter
class InitList_i;
typedef Core::Var<InitList_i> InitList_i_var;
typedef Core::Var<const InitList_i> InitList_i_cvar;

class InitList_i :
	virtual public SearchAdapterLib::Adapter::IFilter
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (InitList_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	InitList_i (SortedCollection* in, MergeOp op);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SortedCollection* m_data;

	MergeOp m_op;

	size_t m_pos;

	short m_type;

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
	// создать дубликат
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

//#UC START# *52F0E0B5016E*
//#UC END# *52F0E0B5016E*
}; // class InitList_i

} // namespace Search


#endif //__GARANTCORE_SEARCH_FILTERS_I_INITLIST_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

