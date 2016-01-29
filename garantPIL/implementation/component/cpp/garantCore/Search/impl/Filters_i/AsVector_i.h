////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/AsVector_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Filters_i::AsVector_i
//
// Реализация интерфейса IFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FILTERS_I_ASVECTOR_I_H__
#define __GARANTCORE_SEARCH_FILTERS_I_ASVECTOR_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantCore/Search/Def/Def.h"

namespace Search {

// Реализация интерфейса IFilter
class AsVector_i;
typedef Core::Var<AsVector_i> AsVector_i_var;
typedef Core::Var<const AsVector_i> AsVector_i_cvar;

class AsVector_i :
	virtual public SearchAdapterLib::Adapter::IFilter
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AsVector_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	AsVector_i (const SearchAdapterLib::Adapter::LongVector& in, MergeOp op);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	const SearchAdapterLib::Adapter::LongVector& m_data;

	MergeOp m_op;

	size_t m_pos;

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
}; // class AsVector_i

} // namespace Search


#endif //__GARANTCORE_SEARCH_FILTERS_I_ASVECTOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

